with Text_IO; use Text_IO;
with Ada.Numerics.Discrete_Random;
package body Grilles is

   procedure inc (n : in out Integer)
     with
       Post => n = n'Old + 1
   is
   begin
      n := n + 1;
   end;


   function Nbre_Mines_Autour (T: in out Grille_Jeu.Table2d ; l, c : Index) return Integer is
      nbre_mines : Integer := 0;
   begin

      if l < 1 or l > Nbre_Lignes or c < 1 or c > Nbre_Colonnes then
         raise Constraint_Error;
      end if;

      -- on traite la ligne l-1 (au dessus de la ligne courante)
      if l > 1 then

         if c > 1 and then T.Get(l - 1, c - 1) = MINE then
            inc(nbre_mines);
         end if;

         if T.Get(l - 1, c) = MINE then
            inc(nbre_mines);
         end if;

         if c < Nbre_Colonnes and then T.Get(l - 1, c + 1) = MINE then
            inc(nbre_mines);
         end if;

      end if;
      -- on traite la ligne l-1 (au dessus de la ligne courante)


      -- on traite la ligne l
      if c > 1 and then  T.Get(l , c - 1) = MINE then
         inc(nbre_mines);
      end if;

      if c < Nbre_Colonnes and then T.Get(l , c + 1) = MINE then
         inc(nbre_mines);
      end if;
      -- on traite la ligne l


      -- on traite la ligne l+1 (au dessous de la ligne courante)
      if l < Nbre_Lignes then

         if c > 1 and then T.Get(l + 1, c - 1) = MINE then
            inc(nbre_mines);
         end if;

         if T.Get(l + 1, c) = MINE then
            inc(nbre_mines);
         end if;

         if c < Nbre_Colonnes and then T.Get(l + 1, c + 1) = MINE then
            inc(nbre_mines);
         end if;
         -- on traite la ligne l+1 (au dessous de la ligne courante)

      end if;

      return nbre_mines;
   end;


   -------------------
   -- Remplir_Mines --
   -------------------

   procedure Remplir_Mines (T: in out Grille_Jeu.Table2d ; nombre : Positive) is

      subtype Index_Ligne is Index range 1 .. Nbre_lignes;
      package Random_Index_Ligne is new Ada.Numerics.Discrete_Random (Index_Ligne);
      use Random_Index_Ligne;

      subtype Index_Colonne is Index range 1 .. Nbre_colonnes;
      package Random_Index_Colonne is new Ada.Numerics.Discrete_Random (Index_Colonne);
      use Random_Index_Colonne;

      nombre_cases : Positive; -- nombre de cases de la grille de jeu
      n : Integer := nombre;	-- nombre de bombes restant à placer

      -- générateurs de nombre aléatoire
      Generateur_ligne		: Random_Index_Ligne.Generator;
      Generateur_colonne	: Random_Index_Colonne.Generator;

      l, c : Index;	-- coordonnées dans la grille de jeu

   begin
      -- limiter le nombre de mines à placer au nombre de cases
      nombre_cases := Positive(Nbre_Lignes) * Positive(Nbre_colonnes);
      if n > nombre_cases then
         n := nombre_cases;
      end if;

      -- On place des mines dans la grille aux endroits où il n'y en a pas déjà
      Random_Index_Ligne.Reset (Generateur_ligne);  -- Start the generator in a unique state in each run
      Random_Index_Colonne.Reset (Generateur_colonne);

      while n /= 0 loop
         l := Random_Index_Ligne.Random(Generateur_ligne);
         c := Random_Index_Colonne.Random(Generateur_colonne);

         if T.Get(l,c) /= MINE then
            T.Set(Ligne => l, Colonne => c, Item => MINE);
            n:=n-1;
         end if;

      end loop;


      -- Positionner les nombres de mines autour des mines
      declare
         mines_autour : Integer; -- nombre de mines autour d'une case
      begin

         for l in 1.. Nbre_lignes loop
            for c in 1.. Nbre_colonnes loop
               mines_autour :=  Nbre_Mines_Autour(T, l, c);

               if T.Get(l,c) /= MINE then

                  case mines_autour is
                     when 0 =>
                        null;
                     when 1 =>
                        T.Set(l , c , UN);
                     when 2 =>
                        T.Set(l , c , DEUX);
                     when 3 =>
                        T.Set(l , c , TROIS);
                     when 4 =>
                        T.Set(l , c , QUATRE);
                     when 5 =>
                        T.Set(l , c , CINQ);
                     when 6 =>
                        T.Set(l , c , SIX);
                     when 7 =>
                        T.Set(l , c , SEPT);
                     when 8 =>
                        T.Set(l , c , HUIT);
                     when others =>
                        null;
                  end case;

               end if;

            end loop; -- lignes
         end loop; -- colonnes

      end;
      -- Positionner les nombres de mines autour des mines

   end Remplir_Mines;


   function Verifier_Contenu(T : in Grille_Jeu.Table2d) return Boolean is
      -- pour la post condition de Remplir_Mines
      -- vérifie que les cases sont bien des valeurs de case_grille_jeu
   begin
      for l in 1 .. Nbre_lignes loop
         for c in 1.. Nbre_colonnes loop
            if T.Get(l,c) not in case_grille_jeu'First .. case_grille_jeu'Last then
               return False;
            end if;
         end loop;
      end loop;

      return True;
   end;


   -------------------------------
   -- Determiner_cases_visibles --
   -------------------------------
   -- Détermine les cases visibles autour de la cas choisie de proche en proche
   -- dans la grille de jeu :
   -- quand une case vide est découverte on affiche tous les cases adjacentes
   -- de proche en proch jusqu'aux cases avec le nombre de mines incluses
   -- Les cases avec nombre de mines (cases adjacentes aux mines)
   -- constituent le périmètre (inclus) à afficher au joueur.
   -- Toutes les cases vides (VIDE) ainsi découvertes de proches en proches sont
   -- rendues visibles au joueur
   --
   -- On utilise un algorithme récursif pour simplifier
   --
   -- Pour chaque case VIDE trouvée on inspecte les cases adjacentes est-ouest-nord-sud
   -- nb : c'est suffisant car par ex SO sera exploré quand on aura exploré S puis O.
   -- De plus il ne faut pas "traverser" les limites en diagonale sinon on explore
   -- de l'autre côté de la limite des cases "nombre"
   -- L'arrêt de la récursivité a lieu quand on tombe sur une case VISIBLE de la grille
   -- du joueur, c'est-à-dire une case déjà explorée
   -- ou quand on tombe sur une case "nombre" (case adjacente à une mine)

   procedure Déterminer_cases_visibles(ligne : in Index; colonne : in Index) is
   begin

      -- case déjà explorée : on arrête l'exploration
      if grille_du_joueur.Get(ligne, colonne) = VISIBLE then
         return;
      end if;

      case grille_de_jeu.Get(ligne, colonne) is

         when VIDE =>
            -- si une case est vide alors elle est rendue visible au joueur
            -- puis on explore les cases adjacentes

            grille_du_joueur.Set(ligne, colonne, Item => VISIBLE);

            if colonne > 1 then
               Déterminer_cases_visibles(ligne, colonne-1);
            end if;

            if colonne < Nbre_colonnes then
               Déterminer_cases_visibles(ligne, colonne+1);
            end if;

            if ligne > 1 then
               Déterminer_cases_visibles(ligne-1, colonne);
            end if;

            if ligne < Nbre_lignes then
               Déterminer_cases_visibles(ligne+1, colonne);
            end if;

         when MINE =>
            null;

         when UN|DEUX|TROIS|QUATRE|CINQ|SIX|SEPT|HUIT =>
            -- les cases adjacentes aux mines sont affichées et constituent la limite
            -- d'exploration
            grille_du_joueur.Set(ligne, colonne, Item => VISIBLE);

      end case;

   end Déterminer_cases_visibles;


   ----------------------------
   -- Afficher_Grille_Joueur --
   ----------------------------
   -- Affiche la grille du joueur en fonction des cases rendues visibles :
   -- Pour les cases rendues visibles dans la grille du joueur (VISIBLE)
   -- on affiche les cases de la grille de jeu
   procedure Afficher_Grille_Joueur is
   begin
      for l in 1..Nbre_Lignes loop
         for c in 1..Nbre_colonnes loop
            case grille_du_joueur.Get(l, c) is
               when DRAPEAU => Put("D");
               when INTERROGATION => Put("?");
               when VISIBLE => Afficher_Case_Jeu(grille_de_jeu.Get(l, c));
               when others => Afficher_Case_Joueur(grille_du_joueur.Get(l, c));
            end case;
            --  if grille_du_joueur.Get(l, c) = VISIBLE then
            --     Afficher_Case_Jeu(grille_de_jeu.Get(l, c));
            --  else
            --     Afficher_Case_Joueur(grille_du_joueur.Get(l, c));
            --  end if;
         end loop;
         New_Line;
      end loop;
   end Afficher_Grille_Joueur;

   -------------------------------
   -- initialisation du package --
   -------------------------------
begin
   -- initialisation de la grille de jeu avec les mines
   Remplir_Mines(T => grille_de_jeu , nombre => Nbre_mines);
end Grilles;

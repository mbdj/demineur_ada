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
   -- initialisation du package --
   -------------------------------
begin
   -- initialisation de la grille de jeu avec les mines
   Remplir_Mines(T => grille_de_jeu , nombre => Nbre_mines);
end Grilles;

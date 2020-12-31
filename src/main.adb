with Text_IO; use Text_IO;
with Type_Index; use Type_Index.Index_IO;

with Grilles; use Grilles;
with Type_case;  use Type_case;
with Type_Index; use Type_Index;

----------
-- Main --
----------

procedure Main is
   --
   -- jeu de démineur
   --

   Perdu : Boolean := False;	-- le joueur n'a pas perdu et peut donc continuer s'il le souhaite
   Continuer : Boolean := True;	-- le joueur veut continuer
   réponse : Character;
   case_jouée : coordonnees_case_grille;	-- case jouée

begin

   grille_de_jeu.Afficher;
   New_Line;
   grille_du_joueur.Afficher;
   New_Line;

   --
   -- Boucle de jeu
   --

   while not Perdu and Continuer loop

      loop
         Put_Line("ligne ?"); Get(case_jouée.ligne);
         exit when case_jouée.ligne >= 1 and case_jouée.ligne <= Grilles.Nbre_lignes;
      end loop;

      loop
         Put_Line("colonne ?"); Get(case_jouée.colonne);
         exit when case_jouée.colonne >= 1 and case_jouée.colonne <= Grilles.Nbre_colonnes;
      end loop;

      -- Put_Line(case_jouée.ligne'Image & " ;" & case_jouée.colonne'Image);

      if grille_de_jeu.Get(case_jouée.ligne,case_jouée.colonne) = MINE then
         Perdu := True;
         Put_Line("Perdu !");
         New_Line;
         grille_de_jeu.Afficher;
         New_Line;
      else
         Déterminer_cases_visibles(case_jouée.ligne, case_jouée.colonne);
         Afficher_Grille_Joueur;
         New_Line;
         Put_Line("Voulez-vous continuer (O/n) ?");
         Get(réponse);
         Continuer := (if réponse /='o' and réponse /= 'O' then False else True);
         Put_Line("Au revoir !");
      end if;
   end loop;

   New_Line;
   grille_de_jeu.Afficher;
   New_Line;

end Main;

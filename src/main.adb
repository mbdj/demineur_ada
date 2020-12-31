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
   -- jeu de d�mineur
   --

   Perdu : Boolean := False;	-- le joueur n'a pas perdu et peut donc continuer s'il le souhaite
   Continuer : Boolean := True;	-- le joueur veut continuer
   r�ponse : Character;
   case_jou�e : coordonnees_case_grille;	-- case jou�e

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
         Put_Line("ligne ?"); Get(case_jou�e.ligne);
         exit when case_jou�e.ligne >= 1 and case_jou�e.ligne <= Grilles.Nbre_lignes;
      end loop;

      loop
         Put_Line("colonne ?"); Get(case_jou�e.colonne);
         exit when case_jou�e.colonne >= 1 and case_jou�e.colonne <= Grilles.Nbre_colonnes;
      end loop;

      -- Put_Line(case_jou�e.ligne'Image & " ;" & case_jou�e.colonne'Image);

      if grille_de_jeu.Get(case_jou�e.ligne,case_jou�e.colonne) = MINE then
         Perdu := True;
         Put_Line("Perdu !");
         New_Line;
         grille_de_jeu.Afficher;
         New_Line;
      else
         D�terminer_cases_visibles(case_jou�e.ligne, case_jou�e.colonne);
         Afficher_Grille_Joueur;
         New_Line;
         Put_Line("Voulez-vous continuer (O/n) ?");
         Get(r�ponse);
         Continuer := (if r�ponse /='o' and r�ponse /= 'O' then False else True);
         Put_Line("Au revoir !");
      end if;
   end loop;

   New_Line;
   grille_de_jeu.Afficher;
   New_Line;

end Main;

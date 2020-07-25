with Ada.Text_IO; use Ada.Text_IO;

with Grilles; use Grilles;


with Type_case;  use Type_case;

----------
-- Main --
----------

procedure Main is
   --
   -- jeu de démineur
   --

begin
   grille_du_joueur.Set(Ligne => 1,
                        Colonne => 1,
                        Item    => VISIBLE);

   grille_de_jeu.Set(Ligne   => 2,
                     Colonne => 3,
                     Item    => MINE);

   Put_Line (grille_de_jeu.Get(Ligne => 1, Colonne => 1)'Image);
   Put_Line (grille_de_jeu.Get(Ligne => 2,Colonne => 3)'Image);

   New_Line;

   grille_de_jeu.Afficher;
   New_Line;
   New_Line;

   grille_du_joueur.Afficher;


end Main;

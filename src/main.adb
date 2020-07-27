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

   grille_de_jeu.Afficher;

   New_Line;

   grille_du_joueur.Afficher;

end Main;

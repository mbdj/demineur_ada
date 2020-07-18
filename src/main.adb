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
   grille_de_jeu.Set(Ligne => 1, Colonne => 1, Item    => Type_case.VISIBLE);

   grille_de_jeu.Set(Ligne   => 2,
                     Colonne => 3,
                     Item    => Type_case.CACHE);

   Put_Line (grille_de_jeu.Get(Ligne => 1, Colonne => 1)'Image);
   Put_Line(grille_de_jeu.Get(Ligne => 2,Colonne => 3)'Image);

end Main;

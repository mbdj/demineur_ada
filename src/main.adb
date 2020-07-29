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

   Pas_Perdu : Boolean := True;	-- le joueur n'a pas perdu et peut donc continuer s'il le souhaite
   Continuer : Boolean := True;	-- le joueur veut continuer

begin

   grille_de_jeu.Afficher;

   New_Line;

   grille_du_joueur.Afficher;


   --
   -- Boucle de jeu
   --

   while Pas_Perdu and Continuer loop
      exit;
   end loop;


end Main;

pragma Ada_2012;
with Ada.Text_IO; use Ada.Text_IO;
package body Type_case is

   --------------
   -- Afficher --
   --------------

   procedure Afficher_Grille_Joueur (c : case_grille_joueur) is
   begin
      Put(c'Image);
   end Afficher_Grille_Joueur;

   --------------
   -- Afficher --
   --------------

   procedure Afficher_Grille_Jeu (c : case_grille_jeu) is
   begin
      Put(c'Image);
   end Afficher_Grille_Jeu;

end Type_case;

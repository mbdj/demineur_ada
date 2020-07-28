pragma Ada_2012;
with Ada.Text_IO; use Ada.Text_IO;
package body Type_case is

   --------------------------
   -- Afficher_Case_Joueur --
   --------------------------

   procedure Afficher_Case_Joueur (c : case_grille_joueur) is
      -- Affiche la grille du joueur
   begin
      Put(String(c'Image)(1));
   end Afficher_Case_Joueur;

   -----------------------
   -- Afficher_Case_Jeu --
   -----------------------

   procedure Afficher_Case_Jeu (c : case_grille_jeu) is
      -- Affiche la grille de jeu
   begin
      -- Put(String(c'Image)(1));

      case c is
         when VIDE =>
            Put('.');
         when MINE =>
            Put('¤');
         when UN =>
            Put('1');
         when DEUX =>
            Put('2');
         when TROIS =>
            Put('3');
         when QUATRE =>
            Put('4');
         when CINQ =>
            Put('5');
         when SIX =>
            Put('6');
         when SEPT =>
            Put('7');
         when HUIT =>
            Put('8');
         when others =>
            null;
      end case;
   end Afficher_Case_Jeu;

end Type_case;

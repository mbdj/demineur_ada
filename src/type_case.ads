with Type_Index; use Type_Index;
with Gwindows.Drawing_Objects; use Gwindows.Drawing_Objects;
with GWindows.Drawing_Panels; use GWindows.Drawing_Panels;

package Type_case is

   type case_grille_joueur is (CACHE, VISIBLE, DRAPEAU, INTERROGATION);
   type case_grille_jeu 	is (VIDE, MINE, UN, DEUX, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT);

   procedure Afficher_Case_Joueur (c : case_grille_joueur);
   procedure Afficher_Case_Jeu (c : case_grille_jeu);

   procedure Afficher_Graphique_Case_Jeu (c : in case_grille_jeu; Canvas : in out Drawing_Canvas_Type; X : in Integer; Y : in Integer);
   procedure Afficher_Graphique_Case_Joueur (c : in case_grille_joueur; Canvas : in out Drawing_Canvas_Type; X : in Integer; Y : in Integer);

   type coordonnees_case_grille is record
      ligne :   Index;
      colonne : Index;
   end record;

   Bitmap_hauteur : constant Integer := 50;
   Bitmap_largeur : constant Integer := 50;

private
   --
   -- à voir si on peut mettre ces déclarations dans le body ?  --- A ETUDIER ---
   --

   Bitmap_cache, Bitmap_vide, Bitmap_mine, Bitmap_un, Bitmap_deux, Bitmap_trois,
     Bitmap_quatre, Bitmap_cinq, Bitmap_six, Bitmap_sept, Bitmap_huit,
     Bitmap_drapeau, Bitmap_interrogation : Bitmap_Type;
end Type_case;

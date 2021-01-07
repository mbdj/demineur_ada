pragma Ada_2012;
with Ada.Text_IO; use Ada.Text_IO;

package body Type_case is


   -----------------------
   -- Afficher_Case_Jeu --
   -----------------------

   procedure Afficher_Case_Jeu (c : case_grille_jeu) is
      -- Affiche une case de la grille de jeu
   begin
      -- Put(String(c'Image)(1));

      case c is
         when VIDE =>   Put('.');
         when MINE =>   Put('¤');
         when UN =>     Put('1');
         when DEUX =>   Put('2');
         when TROIS =>  Put('3');
         when QUATRE => Put('4');
         when CINQ =>   Put('5');
         when SIX =>    Put('6');
         when SEPT =>   Put('7');
         when HUIT =>   Put('8');
         when others => null;
      end case;
   end Afficher_Case_Jeu;



   procedure Afficher_Graphique_Case_Jeu (c : in case_grille_jeu; Canvas : in out Drawing_Canvas_Type; X : in Integer; Y : in Integer) is
      -- Affiche une case de la grille de jeu
   begin
      -- Put(String(c'Image)(1));

      case c is
         when VIDE =>		Paint_Bitmap(Canvas, Bitmap_vide, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when MINE =>		Paint_Bitmap(Canvas, Bitmap_mine, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when UN =>			Paint_Bitmap(Canvas, Bitmap_un, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when DEUX =>		Paint_Bitmap(Canvas, Bitmap_deux, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when TROIS =>		Paint_Bitmap(Canvas, Bitmap_trois, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when QUATRE =>		Paint_Bitmap(Canvas, Bitmap_quatre, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when CINQ =>		Paint_Bitmap(Canvas, Bitmap_cinq, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when SIX =>		Paint_Bitmap(Canvas, Bitmap_six, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when SEPT =>		Paint_Bitmap(Canvas, Bitmap_sept, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when HUIT =>		Paint_Bitmap(Canvas, Bitmap_huit, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when others => null;
      end case;
   end Afficher_Graphique_Case_Jeu;


   --------------------------
   -- Afficher_Case_Joueur --
   --------------------------

   procedure Afficher_Case_Joueur (c : in case_grille_joueur) is
      -- Affiche une case de la grille du joueur
   begin
      -- Put(String(c'Image)(1));

      case c is
         when CACHE =>				Put('X');
         when VISIBLE =>			Put('V');
         when DRAPEAU =>			Put('P');
         when INTERROGATION =>	Put('?');
         when others =>				null;
      end case;
   end Afficher_Case_Joueur;



   ------------------------------------
   -- Afficher_Graphique_Case_Joueur --
   ------------------------------------

   procedure Afficher_Graphique_Case_Joueur (c : in case_grille_joueur; Canvas : in out Drawing_Canvas_Type; X : in Integer; Y : in Integer) is
      -- Affiche une case de la grille du joueur
   begin
      -- Put(String(c'Image)(1));

      case c is
         when CACHE => null;	 Paint_Bitmap(Canvas, Bitmap_cache, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when VISIBLE => null;	-- pas d'affichage graphique (uniquement console)
         when DRAPEAU =>		 Paint_Bitmap(Canvas, Bitmap_drapeau, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when INTERROGATION => Paint_Bitmap(Canvas, Bitmap_interrogation, X, Y, Bitmap_largeur, Bitmap_hauteur);
         when others => null;
      end case;
   end Afficher_Graphique_Case_Joueur;


begin
   -- charger les dessins des cases
   Load_Bitmap_From_File (Bitmap => Bitmap_cache, File_Name => "caché.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_vide, File_Name => "vide.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_mine, File_Name => "mine.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_un, File_Name => "un.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_deux, File_Name => "deux.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_trois, File_Name => "trois.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_quatre, File_Name => "quatre.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_cinq, File_Name => "cinq.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_six, File_Name => "six.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_sept, File_Name => "sept.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_huit, File_Name => "huit.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_drapeau, File_Name => "drapeau.bmp");
   Load_Bitmap_From_File (Bitmap => Bitmap_interrogation, File_Name => "interrogation.bmp");

end Type_case;

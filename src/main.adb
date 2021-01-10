with Text_IO; use Text_IO;

with Grilles; use Grilles;
with Type_case;  use Type_case;
with Type_Index; use Type_Index;

-- Pour les graphiques : bibliothèque GWindows
with Gwindows.Drawing_Panels;  use Gwindows.Drawing_Panels;
with Gwindows.Events;
with Gwindows.Application;
with Gwindows.Message_Boxes;   use Gwindows.Message_Boxes;
with GWindows.Windows;         use GWindows.Windows;
with GNAT.OS_Lib;
with GWindows.Base; use GWindows.Base;


----------
-- Main --
----------

procedure Main is
   pragma Linker_Options ("-mwindows"); -- pour GWindows
   --
   -- jeu de démineur
   --


   Partie_Perdue : Boolean := False;
   Partie_Gagnée : Boolean := False;

   Main_Window : Gwindows.Drawing_Panels.Drawing_Panel_Type;
   Canvas      : Gwindows.Drawing_Panels.Drawing_Canvas_Type;

   -----------------
   -- Do_On_Close --
   -----------------
   procedure Do_On_Close (Windows : in out Gwindows.Base.Base_Window_Type'Class; Can_Close : out Boolean) is
   begin
      Can_Close := True; 			-- indique que la fenêtre peut se fermer

      GWindows.Application.End_Application; 	--  Ends message loop in main thread of application
      --  If additional message loops are still running the application will not close down.

      GNAT.OS_Lib.OS_Exit (Status => 0); 	-- c'est pourquoi on force ici la fermeture de l'application
   end Do_On_Close;


   ------------
   -- Gagné --
   ------------

   function Gagné return Boolean is
      -- Détermine si le joueur a gagné
      -- C'est le cas si le nombre de mines trouvées (= nombre de drapeaux posés) est égal au nombre de mines
      -- et que qu'il n'y a plus de cases cachées

      Nbre_Drapeaux : Integer := 0;
      Nbre_Cachés   : Integer := 0;
   begin

      for l in 1..Nbre_Lignes loop
         for c in 1..Nbre_colonnes loop

            case grille_du_joueur.Get(l,c) is
               when CACHE => return False;
               when DRAPEAU => Nbre_Drapeaux := Nbre_Drapeaux + 1;
               when others => null;
            end case;
         end loop;
      end loop;

      return Nbre_Drapeaux = Nbre_Mines;

   end Gagné;


   ---------------------------
   -- Récupérer_Coordonnées --
   ---------------------------
   procedure Récupérer_Coordonnées(X, Y : in Integer; ligne, colonne : out Integer) is
      -- Détermine les coordonnées (ligne; colonne) dans la grille
      -- à partir de la position de la souris
      -- et des variables globales Bitmap_largeur et Bitmap_hauteur
   begin
      ligne   := Y / Bitmap_largeur + 1;
      colonne := X / Bitmap_hauteur + 1;
   end;


   ----------------------
   -- Do_On_Click_Left --
   ----------------------
   procedure Do_On_Click_Left (Windows : in out Gwindows.Base.Base_Window_Type'Class;
                                X       : in     Integer;
                                Y       : in     Integer;
                                Keys    : in     Mouse_Key_States) is
      l,c : Integer;
   begin
      Capture_Mouse (Main_Window);
      Récupérer_Coordonnées(X,Y,l,c);
      Release_Mouse;

      if Partie_Perdue or Partie_Gagnée then
         return;
      end if;

      if grille_de_jeu.Get(Index(l),Index(c)) = MINE then
         Partie_Perdue := True;

         Afficher_Grille_Jeu(Canvas);
         Redraw (Window => Main_Window, Erase => True, Redraw_Now => True);

         Message_Box(Window   => Windows,
                     Title    => "Perdu",
                     Text     => "Perdu !");
      else
         Déterminer_cases_visibles(Index(l),Index(c));

         Afficher_Grille_Joueur(canvas => Canvas);
         Redraw (Window => Main_Window, Erase => True, Redraw_Now => True);
      end if;

      if Gagné then
         Partie_Gagnée := True;

         Afficher_Grille_Jeu(Canvas);
         Redraw (Window => Main_Window, Erase => True, Redraw_Now => True);

         Message_Box(Window   => Windows,
                     Title    => "Gagné",
                     Text     => "Gagné !");
      end if;

   end Do_On_Click_Left;


   -----------------------
   -- Do_On_Click_Right --
   -----------------------
   procedure Do_On_Click_Right (Windows : in out Gwindows.Base.Base_Window_Type'Class;
                                X       : in     Integer;
                                Y       : in     Integer;
                                Keys    : in     Mouse_Key_States) is
      -- Le clic droit sert à poser le ? ou le drapeau qui signale une mine
      l,c : Integer;
   begin

      if Partie_Perdue or Partie_Gagnée then
         return;
      end if;

      Capture_Mouse (Main_Window);
      Récupérer_Coordonnées(X,Y,l,c);
      Release_Mouse;

      case grille_du_joueur.Get(Index(l),Index(c)) is
         when CACHE				=> grille_du_joueur.Set(Index(l),Index(c), Item => INTERROGATION);
         when INTERROGATION	=> grille_du_joueur.Set(Index(l),Index(c), Item => DRAPEAU);
         when DRAPEAU			=> grille_du_joueur.Set(Index(l),Index(c), Item => CACHE);
         when others			=> null;
      end case;

      Afficher_Grille_Joueur(canvas => Canvas);
      Redraw (Window => Main_Window, Erase => True, Redraw_Now => True);

      if Gagné then
         Afficher_Grille_Jeu(Canvas);
         Redraw (Window => Main_Window, Erase => True, Redraw_Now => True);

         Message_Box(Window   => Windows,
                     Title    => "Gagné",
                     Text     => "Gagné !");
      end if;

   end Do_On_Click_Right;


begin

   Create (Main_Window, "Jeu de démineur");

   Main_Window.Client_Area_Size(Width  => Integer(Integer(Nbre_colonnes) * Bitmap_largeur),
                                Height => Integer(Integer(Nbre_lignes) * Bitmap_hauteur));


   Visible (Main_Window, True);

   On_Destroy_Handler (Main_Window, Gwindows.Events.Do_End_Application'Access);
   --  Since Drawing_Panel_Type is not derived from Main_Window_Type it will not automaticly close the application when the window is destroyed.
   --  This handler will do that for us.

   On_Close_Handler (Window => Main_Window, Handler => Do_On_Close'Unrestricted_Access);
   On_Left_Mouse_Button_Down_Handler (Window => Main_Window, Handler => Do_On_Click_Left'Unrestricted_Access);
   On_Right_Mouse_Button_Down_Handler (Window => Main_Window, Handler => Do_On_Click_right'Unrestricted_Access);

   --Auto_Resize (Main_Window, True);
   --Resize_Canvas (Main_Window, Gwindows.Application.Desktop_Width, Gwindows.Application.Desktop_Height);
   --  By turning off auto resize and setting canvas to the size of of the desktop contents will be saved no matter how we resize the window

   Get_Canvas (Main_Window, Canvas);

   --grille_de_jeu.Afficher;
   --New_Line;

   Afficher_Grille_Joueur(canvas => Canvas);
   Redraw (Window => Main_Window, Erase => True, Redraw_Now => True);
   Gwindows.Application.Message_Check;

   -- boucle des messages
   Gwindows.Application.Message_Loop;

end Main;

with Text_IO; use Text_IO;
with Type_Index; use Type_Index.Index_IO;

with Grilles; use Grilles;
with Type_case;  use Type_case;
with Type_Index; use Type_Index;

-- Pour les graphiques : bibliothèque GWindows
with Gwindows.Windows.Main;    use Gwindows.Windows.Main;
with Gwindows.Drawing_Panels;  use Gwindows.Drawing_Panels;
with Gwindows.Scroll_Panels;   use Gwindows.Scroll_Panels;
with Gwindows.Drawing;         use Gwindows.Drawing;
with Gwindows.Colors;          use Gwindows.Colors;
with Gwindows.Events;
with Gwindows.Base;
with Gwindows.Application;
with Gwindows.Drawing_Objects; use Gwindows.Drawing_Objects;
with Gwindows.Message_Boxes;   use Gwindows.Message_Boxes;
with GWindows.Windows;         use GWindows.Windows;
with GNAT.OS_Lib;


----------
-- Main --
----------

procedure Main is
   pragma Linker_Options ("-mwindows"); -- pour GWindows
   --
   -- jeu de démineur
   --


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


   -----------------
   -- Do_On_Click --
   -----------------
   procedure Do_On_Click (Windows : in out Gwindows.Base.Base_Window_Type'Class;
                          X       : in     Integer;
                          Y       : in     Integer;
                          Keys    : in     Mouse_Key_States) is
   begin
      null;
   end Do_On_Click;



   Perdu : Boolean := False;	-- le joueur n'a pas perdu et peut donc continuer s'il le souhaite
   Continuer : Boolean := True;	-- le joueur veut continuer
   réponse : Character;
   case_jouée : coordonnees_case_grille;	-- case jouée

begin

   Create (Main_Window, "Jeu de démineur",
           Width => Integer(Nbre_colonnes) * Bitmap_largeur,
           Height => Integer(Nbre_lignes) * Bitmap_hauteur);

   Visible (Main_Window, True);

   On_Destroy_Handler (Main_Window, Gwindows.Events.Do_End_Application'Access);
   --  Since Drawing_Panel_Type is not derived from Main_Window_Type it will not automaticly close the application when the window is destroyed.
   --  This handler will do that for us.

   On_Close_Handler (Window => Main_Window, Handler => Do_On_Close'Unrestricted_Access);
   On_Left_Mouse_Button_Down_Handler (Window => Main_Window, Handler => Do_On_Click'Unrestricted_Access);

   --Auto_Resize (Main_Window, True);
   --Resize_Canvas (Main_Window, Gwindows.Application.Desktop_Width, Gwindows.Application.Desktop_Height);
   --  By turning off auto resize and setting canvas to the size of of the desktop contents will be saved no matter how we resize the window

   Get_Canvas (Main_Window, Canvas);


   grille_de_jeu.Afficher;
   New_Line;

   Afficher_Grille_Joueur(canvas => Canvas);
   Redraw (Window => Main_Window, Erase => True, Redraw_Now => True);
   Gwindows.Application.Message_Check;
   New_Line;

   --
   -- Boucle de jeu
   --

   while not Perdu and Continuer loop

      loop
         Put_Line("ligne ?"); Get(case_jouée.ligne);
         exit when case_jouée.ligne >= 1 and case_jouée.ligne <= Grilles.Nbre_lignes;
      end loop;

      loop
         Put_Line("colonne ?"); Get(case_jouée.colonne);
         exit when case_jouée.colonne >= 1 and case_jouée.colonne <= Grilles.Nbre_colonnes;
      end loop;


      if grille_de_jeu.Get(case_jouée.ligne,case_jouée.colonne) = MINE then
         Perdu := True;
         Put_Line("Perdu !");
         New_Line;
      else
         Déterminer_cases_visibles(case_jouée.ligne, case_jouée.colonne);

         Afficher_Grille_Joueur(canvas => Canvas);
         Redraw (Window => Main_Window, Erase => True, Redraw_Now => True);
         Gwindows.Application.Message_Check;
         New_Line;

         Put_Line("Voulez-vous continuer (O/n) ?");
         Get(réponse);
         Continuer := (if réponse /='o' and réponse /= 'O' then False else True);
      end if;

      --  traiter les messages (par ex fermeture de fenêtre)
      Gwindows.Application.Message_Check;

   end loop;

   Put_Line("Au revoir !");
   New_Line;
   grille_de_jeu.Afficher;
   New_Line;

   --  traiter les messages (par ex fermeture de fenêtre)
   Gwindows.Application.Message_Check;
   Gwindows.Application.Message_Loop;

end Main;

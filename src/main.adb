with Ada.Text_IO; use Ada.Text_IO;
with Table2d;

with Type_case;  use Type_case;
with Type_Index; use Type_Index;

----------
-- Main --
----------

procedure Main is
   --
   -- jeu de démineur
   --

   Nbre_lignes   : constant Index := 20;
   Nbre_colonnes : constant Index := 20;

   -------------------
   -- Grille_Joueur --
   -------------------

   package Grille_Joueur is new Table2d(Contenu         => case_grille_joueur,
                                        Nombre_Lignes   => Nbre_lignes,
                                        Nombre_Colonnes => Nbre_colonnes);

   use Grille_Joueur;

   grille_du_joueur : Grille_Joueur.Table2d;

   ----------------
   -- Grille_Jeu --
   ----------------

   package Grille_Jeu is new  Table2d(Contenu         => case_grille_joueur,
                                      Nombre_Lignes   => Nbre_lignes,
                                      Nombre_Colonnes => Nbre_colonnes);
   use Grille_Jeu;

   grille_de_jeu : Grille_Jeu.Table2d;

begin
   Set(T       => grille_de_jeu,
       Ligne   => 1,
       Colonne => 1,
       Item    => Type_case.VISIBLE);
   grille_de_jeu.Set(Ligne => 1, Colonne => 1, Item    => Type_case.VISIBLE);
   grille_de_jeu.Set(Ligne   => 2,
                     Colonne => 3,
                     Item    => Type_case.CACHE);

   Put_Line (grille_de_jeu.Get(Ligne => 1, Colonne => 1)'Image);
   Put_Line(grille_de_jeu.Get(Ligne => 2,Colonne => 3)'Image);

end Main;

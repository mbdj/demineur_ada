with Table2d;

with case_grille;
use case_grille;
with Type_Index; use Type_Index;

procedure Main is
   --
   -- jeu de démineur
   --

   Nbre_lignes   : constant Index := 20;
   Nbre_colonnes : constant Index := 20;

   package Grille_Joueur is new Table2d(Contenu         => case_grille_joueur,
                                             Nombre_Lignes   => Nbre_lignes,
                                             Nombre_Colonnes => Nbre_colonnes);

   package Grille_Jeu is new  Table2d(Contenu         => case_grille_joueur,
                                      Nombre_Lignes   => Nbre_lignes,
                                      Nombre_Colonnes => Nbre_colonnes);

begin
   --  Insert code here.
   null;
end Main;

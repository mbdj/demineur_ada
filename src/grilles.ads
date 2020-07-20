with Type_Index; use Type_Index;
with Type_case; use Type_case;
with Table2d_pack; 

package Grilles is

   Nbre_lignes   : constant Index := 20;
   Nbre_colonnes : constant Index := 20;
   
   -------------------
   -- Grille_Joueur --
   -------------------

   package Grille_Joueur is new Table2d_pack(Contenu         => case_grille_joueur,
                                        Nombre_Lignes   => Nbre_lignes,
                                        Nombre_Colonnes => Nbre_colonnes);

   use Grille_Joueur;

   grille_du_joueur : Grille_Joueur.Table2d;

   ----------------
   -- Grille_Jeu --
   ----------------

   package Grille_Jeu is new  Table2d_pack(Contenu         => case_grille_joueur,
                                           Nombre_Lignes   => Nbre_lignes,
                                           Nombre_Colonnes => Nbre_colonnes);
   use Grille_Jeu;

   grille_de_jeu : Grille_Jeu.Table2d;
   

end Grilles;

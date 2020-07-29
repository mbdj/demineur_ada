pragma Ada_2012;

with Type_Index; use Type_Index;
with Type_case; use Type_case;
with Table2d_pack; 

package Grilles is

   
   Nbre_lignes   : constant Index := 15;
   Nbre_colonnes : constant Index := 10;
   Nbre_Mines		: constant Positive := 5;
   
   -------------------
   -- Grille_Joueur --
   -------------------

   package Grille_Joueur is new Table2d_pack(Contenu 			=> case_grille_joueur,
                                             Afficher        => Afficher_Case_Joueur,
                                             Nombre_Lignes   => Nbre_lignes,
                                             Nombre_Colonnes => Nbre_colonnes);

   use Grille_Joueur;

   grille_du_joueur : Grille_Joueur.Table2d;
   

   ----------------
   -- Grille_Jeu --
   ----------------

   package Grille_Jeu is new  Table2d_pack(Contenu				=> case_grille_jeu,
                                           Afficher 			=> Afficher_Case_Jeu,
                                           Nombre_Lignes		=> Nbre_lignes,
                                           Nombre_Colonnes	=> Nbre_colonnes);
   use Grille_Jeu;

   grille_de_jeu : Grille_Jeu.Table2d;

   
   function Verifier_Contenu (T : in Grille_Jeu.Table2d) return Boolean;
   -- pour la post condition de Remplir_Mines
   -- vérifie que les cases sont bien des valeurs de case_grille_jeu
   
   procedure Remplir_Mines (T: in out Grille_Jeu.Table2d ; nombre : Positive)
     with  
       Pre		=> nombre in 1 .. Positive(Nbre_lignes*Nbre_colonnes),  
     	Post	=> Verifier_Contenu(T);
   -- Remplit la grille de jeu avec le nombre de mines spécifié

end Grilles;

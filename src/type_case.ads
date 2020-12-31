with Type_Index; use Type_Index;

package Type_case is

   type case_grille_joueur is (CACHE, VISIBLE, DRAPEAU, INTERROGATION);
   type case_grille_jeu 	is (VIDE, MINE, UN, DEUX, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT);

   procedure Afficher_Case_Joueur (c : case_grille_joueur);
   procedure Afficher_Case_Jeu (c : case_grille_jeu);


   type coordonnees_case_grille is record
      ligne :   Index;
      colonne : Index;
   end record;

end Type_case;

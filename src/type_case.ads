package Type_case is

   type case_grille_joueur is (CACHE, VISIBLE, DRAPEAU, INTERROGATION);
   type case_grille_jeu 	is (VIDE, MINE, UN, DEUX, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT);

   procedure Afficher_Grille_Joueur (c : case_grille_joueur);
   procedure Afficher_Grille_Jeu (c : case_grille_jeu);

end Type_case;

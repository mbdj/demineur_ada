with Ada.Numerics.Discrete_Random;
package body Grilles is


   -------------------
   -- Remplir_Mines --
   -------------------

   procedure Remplir_Mines (T: in out Grille_Jeu.Table2d ; nombre : Positive) is

      subtype Index_Ligne is Index range 1 .. Nbre_lignes;
      package Random_Index_Ligne is new Ada.Numerics.Discrete_Random (Index_Ligne);
      use Random_Index_Ligne;

      subtype Index_Colonne is Index range 1 .. Nbre_colonnes;
      package Random_Index_Colonne is new Ada.Numerics.Discrete_Random (Index_Colonne);
      use Random_Index_Colonne;

      nombre_cases : Positive; -- nombre de cases de la grille de jeu
      n : Integer := nombre;	-- nombre de bombes restant à placer

      -- générateurs de nombre aléatoire
      Generateur_ligne		: Random_Index_Ligne.Generator;
      Generateur_colonne	: Random_Index_Colonne.Generator;

      l, c : Index;	-- coordonnées dans la grille de jeu

   begin
      -- limiter le nombre de mines à placer au nombre de cases
      nombre_cases := Positive(Nbre_Lignes) * Positive(Nbre_colonnes);
      if n > nombre_cases then
         n := nombre_cases;
      end if;

      -- On place des mines dans la grille aux endroits où il n'y en a pas déjà
      Random_Index_Ligne.Reset (Generateur_ligne);  -- Start the generator in a unique state in each run
      Random_Index_Colonne.Reset (Generateur_colonne);

      while n /= 0 loop
         l := Random_Index_Ligne.Random(Generateur_ligne);
         c := Random_Index_Colonne.Random(Generateur_colonne);

         if T.Get(l,c) /= MINE then
            T.Set(Ligne => l, Colonne => c, Item => MINE);
            n:=n-1;
         end if;

      end loop;
   end;


begin
   -- initialisation de la grille de jeu avec les mines
   Remplir_Mines(T => grille_de_jeu , nombre => Nbre_mines);
end Grilles;

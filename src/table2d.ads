--
-- mehdi
-- 14/07/2020
--
-- table g�n�rique en 2 dimensions
--
with Type_Index; use Type_Index;
generic
   type Contenu is private;
   Nombre_Lignes : 	Index :=10;
   Nombre_colonnes :	Index := 10;

package Table2d is

   type Table2d is tagged private;	-- tagged private permet d'utiliser la notation point�e dans les appels de m�thodes

   Procedure	Set (  T : in out Table2d;  Ligne : in Index;   Colonne : in Index;   Item : in Contenu);
   -- affecter un �l�ment dans la grille

   Function	Get (  T : in Table2d;  Ligne : in Index;   Colonne : in Index) return Contenu;
   -- r�cup�rer un �l�ment dans la grille

private

   type array2d is array (1 .. Nombre_Lignes, 1 .. Nombre_Colonnes) of Contenu;

   -- record n�cessaire pour un type tagged
   type Table2d is tagged record
      table : array2d; -- nb : on ne peut pas mettre ici un array anomyne => d'o� le type array2d
   end record;

end Table2d;

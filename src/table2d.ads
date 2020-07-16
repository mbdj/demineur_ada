--
-- mehdi
-- 14/07/2020
--
-- table g�n�rique en 2 dimensions
--
with Type_Index; use Type_Index;
generic
   type Contenu is private;
   Nombre_Lignes : Index :=10;
   Nombre_colonnes : Index := 10;

package Table2d is

   type Table2d is private;

   Procedure	Set (  T : in out Table2d;  Ligne : in Index;   Colonne : in Index;   Item : in Contenu);
   Function	Get (  T : in Table2d;  Ligne : in Index;   Colonne : in Index) return Contenu;

private

   type Table2d is array (1 .. Nombre_Lignes, 1 .. Nombre_Colonnes) of Contenu;

end Table2d;

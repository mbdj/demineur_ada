generic
   type Contenu is private;

package Table2d is
   type Index is new Positive range 1 .. Positive'Last;
   type Table2d is private;

   Procedure	Set (  T : in out Table2d;  Ligne : in Index;   Colonne : in Index;   Item : in Contenu);
   Function	Get (  T : in Table2d;  Ligne : in Index;   Colonne : in Index) return Contenu;

private
   Nombre_Lignes 	: Index := 10;
   Nombre_Colonnes	: Index := 10;
   type Table2d is array (1 .. Nombre_Lignes, 1 .. Nombre_Colonnes) of Contenu;

end Table2d;

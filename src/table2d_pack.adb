pragma Ada_2012;
package body Table2d_pack is

   ---------
   -- Set --
   ---------

   procedure Set (T     	: in out Table2d;
                  Ligne   	: in Index;
                  Colonne 	: in Index;
                  Item 		: in Contenu) is
   begin
      T.table(Ligne, Colonne) := Item;
   end Set;

   ---------
   -- Get --
   ---------

   function Get (T     		: in Table2d;
                 Ligne   	: in Index;
                 Colonne 	: in Index) return Contenu is
   begin
      return T.table(Ligne, Colonne);
   end Get;

end Table2d_pack;

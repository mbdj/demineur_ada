pragma Ada_2012;
with Ada.Text_IO; use Ada.Text_IO;
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


   --------------
   -- Afficher --
   --------------

   procedure Afficher (T : in Table2d) is
   begin
      for l in 1..Nombre_Lignes loop
         for c in 1..Nombre_colonnes loop
            Afficher(T.Get(Ligne => l, Colonne => c));
         end loop;
         New_Line;
      end loop;
   end Afficher;


end Table2d_pack;

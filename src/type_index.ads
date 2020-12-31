with Text_IO;

package Type_Index is

   type Index is new Positive range 1 .. Positive'Last;
   -- index de table2d
   -- nb : cette déclaration ne peut pas être mise dans la déclaration générique
   -- de table2d à cause de la contrainte range qui n'est pas acceptée dans une
   -- déclaration générique (dommage)

   -- package pour lire/écrire les Index à la console
   package Index_IO is new Text_IO.Integer_IO(Index);

end Type_Index;

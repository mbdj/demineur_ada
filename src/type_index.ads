package Type_Index is

   type Index is new Positive range 1 .. Positive'Last;
   -- index de table2d
   -- nb : cette déclaration ne peut pas être mise dans la déclaration générique
   -- de table2d à cause de la contrainte range qui n'est pas acceptée dans une
   -- déclaration générique (dommage)

end Type_Index;

package Type_Index is

   type Index is new Positive range 1 .. Positive'Last;
   -- index de table2d
   -- nb : cette d�claration ne peut pas �tre mise dans la d�claration g�n�rique
   -- de table2d � cause de la contrainte range qui n'est pas accept�e dans une
   -- d�claration g�n�rique (dommage)

end Type_Index;

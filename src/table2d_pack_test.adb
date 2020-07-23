pragma Ada_2012;
with Table2d_pack;
with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Type_Index; use Type_Index;
package body Table2d_pack_test is
   use Assertions;

   --------------
   -- Fixtures --
   --------------

   package Table_Integer_pack is new Table2d_pack(Contenu         => Integer,
                                                  Nombre_Lignes   => 10,
                                                  Nombre_colonnes => 10);

   T2d : Table_Integer_pack.Table2d;
   -- table d'Integer pour les tests


   --------------------
   -- Register_Tests --
   --------------------

   procedure Register_Tests (T : in out Table2d_test_case) is
      use Test_Cases.Registration;
   begin
      Register_Routine(T, Test_Set_Get'Access, "Test Set et Get");
      -- T.Register_Routine(Test_Set_Get'Access, "Test Set et Get");
   end Register_Tests;

   ----------
   -- Name --
   ----------

   function Name (T : Table2d_test_case) return Test_String is
   begin
      return Format ("Tests table2d_pack");
   end Name;

   ------------
   -- Set_Up --
   ------------

   procedure Set_Up (T : in out Table2d_test_case) is
   begin
      for l in 1..10 loop
         for c in 1..10 loop
            T2d.Set(Ligne   => Index(l),
                    Colonne => Index(c),
                    Item    => (l-1)*10+c);    -- 1ère ligne : 1 à 10 2ème ligne : 11 à 20, etc.
         end loop;
      end loop;
   end Set_Up;

   ------------------
   -- Test_Set_Get --
   ------------------

   procedure Test_Set_Get (T : in out Test_Cases.Test_Case'Class) is
   begin
      T2d.Set(Ligne   => 1,
              Colonne => 1,
              Item    => 12);

      Assert(T2d.Get(Ligne => 1, Colonne => 1) = 12,
             "Get /= Set");

   end Test_Set_Get;

end Table2d_pack_test;

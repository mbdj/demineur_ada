with AUnit; use AUnit;
with AUnit.Test_Results; use AUnit.Test_Results;
with AUnit.Test_Cases; use AUnit.Test_Cases;
package Table2d_pack_test is
   use Test_Results;
   
   type Table2d_test_case is new Test_Cases.Test_Case with null Record;
   
   procedure Register_Tests (T : in out Table2d_test_case);
   
   function Name (T : Table2d_test_case) return Test_String;
   
   procedure Set_Up (T: in out Table2d_test_case);
   
   -- liste des tests
   procedure Test_Set_Get (T : in out Test_Cases.Test_Case'Class);
   procedure Test_Get (T : in out Test_Cases.Test_Case'Class);
   
end Table2d_pack_test;

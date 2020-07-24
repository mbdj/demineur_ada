with Table2d_pack_test;
package body Suite_Tests_Demineur is

   use AUnit.Test_Suites;
   
   Result : aliased Test_Suite;
   Test_table2d : aliased Table2d_pack_test.Table2d_test_case;
   -- ajouter ici les autres cas de tests de démineur
   
   function Suite_Demineur return Access_Test_Suite is
   begin
      Add_Test(Result'Access, Test_table2d'Access);
      -- ajouter ici les autres cas de tests de démineur
      
      return Result'Access;
   end Suite_Demineur;
    
end Suite_Tests_Demineur;

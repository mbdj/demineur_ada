--------------
-- Ada_2012 --
--------------

pragma Ada_2012;
with Ada.Text_IO; use Ada.Text_IO;
with Table2d_pack;
with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Type_Index; use Type_Index;
package body Table2d_pack_test is
   use Assertions;

   --------------
   -- Fixtures --
   --------------
   procedure Afficher (i: Integer) is
   begin
      Put(i'Image);
   end Afficher;

   package Table_Integer_pack is new Table2d_pack(Contenu => Integer, Afficher => Afficher);

   T2d : Table_Integer_pack.Table2d;
   -- table d'Integer pour les tests


   --------------------
   -- Register_Tests --
   --------------------

   procedure Register_Tests (T : in out Table2d_test_case) is
      use Test_Cases.Registration;
   begin
      -- Ici on enregistre toutes les routines de test
      Register_Routine(T, Test_Set_Get'Access, "Test Set et Get");
      Register_Routine(T, Test_Get'Access, "Test Get");
      Register_Routine(T, Test_Exception_Set_Zero'Access, "Test exception Erreur_Index");
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
                    Item    => (l-1)*10+c);    -- 1ère ligne : 1 à 10 ; 2ème ligne : 11 à 20, etc.
         end loop;
      end loop;
   end Set_Up;

   ------------------
   -- Test_Set_Get --
   ------------------

   procedure Test_Get (T : in out Test_Cases.Test_Case'Class) is
   begin
      Assert(T2d.Get(Ligne => 1, Colonne => 5) = 5,
             "Test_Get : Get KO");
   end Test_Get;

   ------------------
   -- Test_Set_Get --
   ------------------

   procedure Test_Set_Get (T : in out Test_Cases.Test_Case'Class) is
   begin
      T2d.Set(Ligne   => 1,
              Colonne => 1,
              Item    => 12);

      Assert(T2d.Get(Ligne => 1, Colonne => 1) = 12,
             "Test_Set_Get : Get /= Set");
   end Test_Set_Get;



   -----------------------------
   -- Test_Exception_Set_Zero --
   -----------------------------


--
-- Première façon de faire mais on ne sait pas quelle exception est levée
--

   --
   --  NB : La procedure Provoque_Exception_Set_Ligne_zero ne peut pas être dans la procedure de Test à cause de l'accès 'Access
   --

--  procedure Provoque_Exception_Set_Ligne_zero is
--  begin
--     T2d.Set(Ligne => 0, Colonne => 1, Item => 5);
--  end Provoque_Exception_Set_Ligne_zero;


--     procedure Test_Exception_Set_Zero (T : in out Test_Cases.Test_Case'Class) is
--     begin
--        Assert_Exception(Proc    => Provoque_Exception_Set_Ligne_zero'Access,
--                         Message => "Pas d'exception de Set() avec ligne 0");
--     end Test_Exception_Set_Zero;


   procedure Test_Exception_Set_Zero (T : in out Test_Cases.Test_Case'Class) is
      procedure Provoque_Exception_Set_Ligne_zero is
      begin
         T2d.Set(Ligne => 0, Colonne => 1, Item => 5);
      end Provoque_Exception_Set_Ligne_zero;

   begin
      Provoque_Exception_Set_Ligne_zero;
      Assert(False,"Pas d'exception de Set() avec ligne 0");

   exception
      when Constraint_Error =>
         null;
      when others =>
         Assert(False,"Autre exception que Constraint_Error dans Set() avec ligne 0");
   end Test_Exception_Set_Zero;

end Table2d_pack_test;

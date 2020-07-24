with Suite_Tests_Demineur;
with AUnit.Run;
with AUnit.Reporter.Text; use AUnit.Reporter.Text;
procedure Tests_Demineur is
   procedure Run is new AUnit.Run.Test_Runner(Suite_Tests_Demineur.Suite_Demineur);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Set_Use_ANSI_Colors(Engine => Reporter,
                       Value  => True);
   Run(Reporter);
end Tests_Demineur;

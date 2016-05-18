program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UniTypes in 'UniTypes.pas',
  UnitMainWork in 'UnitMainWork.pas',
  Unit3 in 'Unit3.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

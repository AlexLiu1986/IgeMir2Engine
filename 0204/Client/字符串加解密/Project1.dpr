program Project1;

uses
  Forms,
  EDcodeUnit in '..\..\Common\EDcodeUnit.pas',
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

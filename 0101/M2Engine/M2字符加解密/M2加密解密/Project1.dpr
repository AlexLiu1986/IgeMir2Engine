program Project1;

uses
  Forms,
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  DESTR in '..\Common\DESTR.pas',
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

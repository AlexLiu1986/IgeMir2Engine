program Project1;

uses
  ExceptionLog,
  Forms,
  DESTR in '..\Common\DESTR.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  Unit1 in 'Unit1.pas' {Form1},
  Share in 'Share.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

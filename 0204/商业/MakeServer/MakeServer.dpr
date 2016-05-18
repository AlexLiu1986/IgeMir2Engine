program MakeServer;

uses
  ExceptionLog,
  Forms,
  Main in 'Main.pas' {FrmMain},
  BasicSet in 'BasicSet.pas' {FrmBasicSet},
  HUtil32 in '..\Common\HUtil32.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  EDcode in '..\Common\EDCode.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  Common in '..\Common\Common.pas',
  Share in 'Share.pas',
  MakeThread in 'MakeThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'IGE科技生成器';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmBasicSet, FrmBasicSet);
  Application.Run;
end.

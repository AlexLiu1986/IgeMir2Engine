program W2Server;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  HUtil32 in '..\Common\HUtil32.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  Share in 'Share.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  EDcode in '..\Common\EDCode.pas',
  Common in '..\Common\Common.pas',
  MD5EncodeStr in 'MD5EncodeStr.pas',
  DM in 'DM.pas' {FrmDm: TDataModule},
  ThreadQuery in 'ThreadQuery.pas',
  BasicSet in 'BasicSet.pas' {FrmBasicSet};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'IGE�Ƽ���������';
  Application.CreateForm(TFrmDm, FrmDm);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmBasicSet, FrmBasicSet);
  Application.Run;
end.

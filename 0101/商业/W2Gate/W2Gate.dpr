program W2Gate;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  GateShare in 'GateShare.pas',
  GeneralConfig in 'GeneralConfig.pas' {frmGeneralConfig},
  IPaddrFilter in 'IPaddrFilter.pas' {frmIPaddrFilter},
  HUtil32 in '..\Common\HUtil32.pas',
  Common in '..\Common\Common.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  AboutUnit in 'AboutUnit.pas' {FrmAbout},
  QQWry in 'QQWry.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'IGE¿Æ¼¼µÇÂ½Íø¹Ø';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmGeneralConfig, frmGeneralConfig);
  Application.CreateForm(TfrmIPaddrFilter, frmIPaddrFilter);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.Run;
end.


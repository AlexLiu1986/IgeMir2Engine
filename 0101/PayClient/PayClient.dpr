program PayClient;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Share in 'Share.pas',
  GeneralConfig in 'GeneralConfig.pas' {FrmGeneralConfig},
  NpcConfig in 'NpcConfig.pas' {FrmNpcConfig},
  AddServer in 'AddServer.pas' {FrmAddServer},
  OldPayRecord in 'OldPayRecord.pas' {FrmOldPayRecord},
  Login in 'Login.pas' {FrmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmGeneralConfig, FrmGeneralConfig);
  Application.CreateForm(TFrmNpcConfig, FrmNpcConfig);
  Application.CreateForm(TFrmAddServer, FrmAddServer);
  Application.CreateForm(TFrmOldPayRecord, FrmOldPayRecord);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.

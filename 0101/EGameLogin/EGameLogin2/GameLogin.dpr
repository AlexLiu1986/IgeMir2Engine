program GameLogin;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  NewAccount in 'NewAccount.pas' {FrmNewAccount},
  ChangePassword in 'ChangePassword.pas' {FrmChangePassword},
  GetBackPassword in 'GetBackPassword.pas' {FrmGetBackPassword},
  MsgBox in 'MsgBox.pas' {FrmMessageBox},
  Common in '..\LoginCommon\Common.pas',
  Grobal2 in '..\..\Common\Grobal2.pas',
  HUtil32 in '..\..\Common\HUtil32.pas',
  EDcode in '..\..\Common\EDcode.pas',
  md5 in '..\LoginCommon\Md5.pas',
  Reg in '..\LoginCommon\Reg.pas',
  GameLoginShare in 'GameLoginShare.pas',
  GameMon in 'GameMon.pas',
  Secrch in 'Secrch.pas';

{$R *.res}
{$R ..\资源文件\Mir2.Res}
begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmNewAccount, FrmNewAccount);
  Application.CreateForm(TFrmChangePassword, FrmChangePassword);
  Application.CreateForm(TFrmGetBackPassword, FrmGetBackPassword);
  Application.CreateForm(TFrmMessageBox, FrmMessageBox);
  Application.Run;
end.

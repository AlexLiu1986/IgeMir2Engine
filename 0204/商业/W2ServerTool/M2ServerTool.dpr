program M2ServerTool;

uses
  Forms,
  LoginFrm in 'LoginFrm.pas' {LoginForm},
  EDcode in '..\Common\EDcode.pas',
  Grobal2 in '..\..\Common\Grobal2.pas',
  Main in 'Main.pas' {MainFrm},
  AddUser in 'AddUser.pas' {FrmAddUser},
  Globals in 'Globals.pas',
  LogFrm in 'LogFrm.pas' {LogForm},
  ModiUser in 'ModiUser.pas' {ModiUserFrm},
  MD5EncodeStr in '..\W2Server\MD5EncodeStr.pas',
  SXSum in 'SXSum.pas' {SXSumFrm},
  Rpt_DZSFrm in 'Report\Rpt_DZSFrm.pas' {Rpt_DZSForm: TQuickRep},
  previewt in 'previewt.pas' {prev},
  sMain in 'MakeKey\sMain.pas' {FrmMakeKey},
  SystemManage in 'MakeKey\SystemManage.pas',
  UserLicense in 'MakeKey\UserLicense.pas',
  HardInfo in 'MakeKey\HardInfo.pas',
  share in 'MakeKey\share.pas',
  Rpt_ScriptFrm in 'Report\Rpt_ScriptFrm.pas' {Rpt_ScriptForm: TQuickRep};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'IGE数据工具';
  Application.CreateForm(TLoginForm, LoginForm);
  Application.Run;
end.

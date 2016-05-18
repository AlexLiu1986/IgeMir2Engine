program MakeScriptCode;

uses
  ExceptionLog,
  Forms,
  Login in 'Login.pas' {FrmLogin},
  Main in 'Main.pas' {FrmMain},
  SystemManage in '..\..\W2ServerTool\MakeKey\SystemManage.pas',
  UserLicense in '..\..\W2ServerTool\MakeKey\UserLicense.pas',
  ChinaRAS in '..\..\W2ServerTool\MakeKey\ChinaRAS.pas',
  HardInfo in '..\..\W2ServerTool\MakeKey\HardInfo.pas',
  DESCrypt in '..\..\W2ServerTool\MakeKey\DESCrypt.pas',
  Share in 'Share.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

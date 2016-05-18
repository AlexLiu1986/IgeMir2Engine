program MakeScript;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  share in 'share.pas',
  MD5EncodeStr in '..\MD5EncodeStr.pas',
  RegFrm in 'RegFrm.pas' {Form2},
  ChinaRAS in '..\ChinaRAS.pas',
  DESTR in '..\DESTR.pas',
  RSADESCrypt in '..\RSADESCrypt.pas',
  FGInt in '..\FGInt.pas',
  FGIntPrimeGeneration in '..\FGIntPrimeGeneration.pas',
  FGIntRSA in '..\FGIntRSA.pas',
  UserFrm in 'UserFrm.pas' {UserForm},
  UserLicense in 'UserLicense.pas',
  SysManage in 'SysManage.pas';

{$R 'ScriptLoader.res' 'ScriptLoader.txt'}
{$R *.res}

begin
  Application.Initialize;
  Application.Title := '脚本加密插件生成器';
  Application.CreateForm(TUserForm, UserForm);
  Application.Run;
end.

library SystemModule;


uses
  SystemManage in 'SystemManage.pas',
  SystemShare in 'SystemShare.pas',
  Module in 'Module.pas',
  SDK in 'SDK.pas',
  EncryptUnit in 'EncryptUnit.pas',
  UserLicense in 'UserLicense\UserLicense.pas',
  DESTRING in 'DESTRING.pas';

{$R *.res}
exports
  Init,UnInit;
  
begin
  GetDLLUers;//DLLÅĞ¶ÏÊÇÄÄ¸öEXE¼ÓÔØ
end.

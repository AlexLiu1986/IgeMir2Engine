library ScriptLoader;

uses
  PlugMain in 'PlugMain.pas',
  Share in 'Share.pas',
  SDK in 'SDK.pas',
  Module in 'Module.pas',
  DESTR in 'DESTR.pas',
  DiaLogMain in 'DiaLogMain.pas' {FrmDiaLog},
  EDcode in 'EDcode.pas',
  ChinaRAS in 'ChinaRAS.pas';

{$R *.res}
procedure Config(); stdcall;
begin
  Open();
end;

exports
  Init,UnInit{$IF HookSearchMode = 1},Config {$IFEND};//20081016 ��ҵ��ɵ���ע�ᴰ��
begin
  GetDLLUers; //DLL�ж����ĸ�EXE����
end.

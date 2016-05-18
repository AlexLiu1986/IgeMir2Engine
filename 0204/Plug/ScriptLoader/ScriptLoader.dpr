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
  Init,UnInit{$IF HookSearchMode = 1},Config {$IFEND};//20081016 商业版可弹出注册窗口
begin
  GetDLLUers; //DLL判断是哪个EXE加载
end.

library MagicManage;

uses
  Windows,
  PlugMain in 'PlugMain.pas',
  PlugShare in 'PlugShare.pas',
  MagicManageConfig in 'MagicManageConfig.pas' {FrmMagicManage},
  UserMagic in 'UserMagic.pas',
  HUtil32 in '..\PlugInCommon\HUtil32.pas',
  EngineAPI in '..\PlugInCommon\EngineAPI.pas',
  EngineType in '..\PlugInCommon\EngineType.pas';

{$R *.res}
const
  PlugName = '【IGE科技 魔法管理插件】(2008/11/30)';
  LoadPlus = '加载【IGE科技 魔法管理插件】成功';
  UnLoadPlus = '卸载【IGE科技 魔法管理插件】成功';
  nFindObj = 5;
  nPlugHandle = 6;
  nStartPlug = 8;
type
  TMsgProc = procedure(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
  TFindProc = function(sProcName: PChar; nNameLen: Integer): Pointer; stdcall;
  TFindObj = function(sObjName: PChar; nNameLen: Integer): TObject; stdcall;
  TSetProc = function(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean; stdcall;
  TStartPlug = function(): Boolean; stdcall;
  TGetFunAddr = function(nIndex: Integer): Pointer; stdcall;
  TSetStartPlug = function(StartPlug: TStartPlug): Boolean; stdcall;

var
  OutMessage: TMsgProc;

function Start():Boolean;stdcall;
begin
  Result := StartPlug();
end;
             
function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;
var
//  FindObj: TFindObj;//20080523
  SetStartPlug: TSetStartPlug;
begin
  PlugHandle := 0;
  OutMessage := MsgProc;
  MsgProc(LoadPlus, length(LoadPlus), 0);
  PlugHandle := PInteger(GetFunAddr(nPlugHandle))^;
//  FindObj := TFindObj(GetFunAddr(nFindObj));//20080523
  SetStartPlug := TSetStartPlug(GetFunAddr(nStartPlug));
  SetStartPlug(Start);
  InitPlug();
  Result := PlugName;
end;

procedure MainOutMessasge(Msg: string; nMode: Integer);
begin
  if Assigned(OutMessage) then begin
    OutMessage(PChar(Msg), length(Msg), nMode);
  end;
end;

procedure UnInit(); stdcall;
begin
  UnInitPlug();
  MainOutMessasge(UnLoadPlus,0);
end;

procedure Config(); stdcall;
begin
  FrmMagicManage := TFrmMagicManage.Create(nil);
  FrmMagicManage.Open;
  FrmMagicManage.Free;
end;

exports
  Init, UnInit, Config;
begin

end.


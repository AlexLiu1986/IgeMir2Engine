library zPlugOfEngine;


uses
  Windows,
  SysUtils,
  Classes,
  PlugMain in 'PlugMain.pas',
  PlayUserCmd in 'PlayUserCmd.pas',
  NpcScriptCmd in 'NpcScriptCmd.pas',
  PlugShare in 'PlugShare.pas',
  PlayUser in 'PlayUser.pas',
  FunctionConfig in 'FunctionConfig.pas' {FrmFunctionConfig},
  HUtil32 in '..\PlugInCommon\HUtil32.pas',
  EngineType in '..\PlugInCommon\EngineType.pas',
  Common in '..\..\Common\Common.pas',
  EngineAPI in '..\PlugInCommon\EngineAPI.pas';

{$R *.res}
const
  SuperUser = 240621028; //飘飘网络
  UserKey1 = 13677866; //飞尔世界
  UserKey2 = 398432431;//过客的Q号
  Version = UserKey2;
const
{$IF Version = SuperUser}
  PlugName = '飘飘网络引擎功能插件 (2008/04/28)';
  LoadPlus = '加载飘飘网络引擎功能插件成功...';
  UnLoadPlus = '卸载飘飘网络引擎功能插件成功...';
{$ELSEIF Version = UserKey1}
  PlugName = '飞尔世界引擎功能插件 (2008/04/28)';
  LoadPlus = '加载飞尔世界引擎功能插件成功...';
  UnLoadPlus = '卸载飞尔世界引擎功能插件成功...';
{$ELSEIF Version = UserKey2}
  PlugName = '【IGE科技 数据引擎功能插件】(2008/11/30)';
  LoadPlus = '加载【IGE科技 数据引擎功能插件】成功';
  UnLoadPlus = '卸载【IGE科技 数据引擎功能插件】成功';
{$IFEND}

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

function Start(): Boolean; stdcall;
begin
  Result := StartPlug;
end;
function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;
var
 // FindObj: TFindObj;//20080523
  SetStartPlug: TSetStartPlug;
begin
  PlugHandle := 0;
  OutMessage := MsgProc;
  MsgProc(LoadPlus, length(LoadPlus), 0);
  PlugHandle := PInteger(GetFunAddr(nPlugHandle))^;
  //FindObj := TFindObj(GetFunAddr(nFindObj));//20080523
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
end;

procedure Config(); stdcall;
begin
  FrmFunctionConfig := TFrmFunctionConfig.Create(nil);
  FrmFunctionConfig.Open();
  FrmFunctionConfig.Free;
end;

exports
  Init, UnInit, Config;
begin

end.


unit SDK;

interface
uses
  Windows, SysUtils,Controls, Forms, SystemManage, {IdTCPClient, IdHTTP,}
  ShellApi, ExtCtrls, Classes;
var
  nCode: Integer;//M2程序CRCA
  boSetLicenseInfo, boSetUserLicense, boTodayDate: Boolean;
  TodayDate: TDate;
  m_btUserMode: Byte;
  m_wCount: Word;
  m_wPersonCount: Word;
  m_nErrorInfo: Integer;
  m_btStatus: Byte;
  m_dwSearchTick: Longword;
  m_dwSearchTime: Longword = 1000 * 60 * 60 * 6; //6个小时重新读取注册信息
type
{  TMyTimer = class(TObject) 20080330 去掉新版提示功能
    Timer: TTimer;
    procedure OnTimer(Sender: TObject);
  end; }
  TMsgProc = procedure(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
  TFindProc = function(ProcName: PChar; nNameLen: Integer): Pointer; stdcall;
  TSetProc = function(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean; stdcall;
  TFindObj = function(ObjName: PChar; nNameLen: Integer): TObject; stdcall;

  TGetFunAddr = function(nIndex: Integer): Pointer; stdcall;
  TFindOBjTable_ = function(ObjName: PChar; nNameLen, nCode: Integer): TObject; stdcall;
  TSetProcCode_ = function(ProcName: PChar; nNameLen, nCode: Integer): Boolean; stdcall;
  TSetProcTable_ = function(ProcAddr: Pointer; ProcName: PChar; nNameLen, nCode: Integer): Boolean; stdcall;
  TFindProcCode_ = function(ProcName: PChar; nNameLen: Integer): Integer; stdcall;
  TFindProcTable_ = function(ProcName: PChar; nNameLen, nCode: Integer): Pointer; stdcall;
  TStartPlug = function(): Boolean; stdcall;
  TSetStartPlug = function(StartPlug: TStartPlug): Boolean; stdcall;
  TChangeCaptionText = procedure(Msg: PChar; nLen: Integer); stdcall; //20080404
  TSetUserLicense = procedure(nDay, nUserCout: Integer); stdcall;
  TFrmMain_ChangeGateSocket = procedure(boOpenGateSocket: Boolean; nCRCA: Integer); stdcall;

function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;
procedure UnInit(); stdcall;
procedure StartModule(); stdcall;
function GetLicenseInfo(var nSearchMode: Integer; var nDay: Integer; var nPersonCount: Integer): Integer; stdcall; //20071229
function RegisterName: PChar; stdcall;
function RegisterLicense(sRegisterInfo, sUserName: PChar): Integer; stdcall;
function GetUserVersion: Boolean;
function GetUserName: Boolean;//检查是否为IGEM2 20081203
//function Start(): Boolean; stdcall; 20080330 去掉新版提示功能
//function GetProductVersion: Boolean; stdcall; 20080330 去掉新版提示功能
//function GetVersionNumber: Integer;20080330 去掉新版提示功能
//procedure InitTimer(); 20080330 去掉新版提示功能
//procedure UnInitTimer(); 20080330 去掉新版提示功能
procedure GetDateIP(Src: PChar; Dest: PChar); stdcall;  //DLL输出加解函数过程 20080217
function GetSysDate(Dest: PChar): Boolean; stdcall;//输出插件标识，以判断是否IGE自己的系统插件 20081203
procedure GetDLLUers;//DLL判断是哪个EXE加载
function GetProductAddress(Src0: PChar): Boolean; stdcall;//访问指定网站文本,如果为特殊指令,则在M2上显示相关信息(输出由M2调用) 20081018
implementation
uses Module, EncryptUnit, EDcode, DESTRING, SystemShare;
{var
  //MyTimer: TMyTimer;20080330 去掉新版提示功能
  sHomePage: string;}
const
  ProductVersion = 20080306;//版本号,要与M2 Common.pas 中的nProductVersion
  SuperUser = 398432431; //飘飘网络  此处要与M2相关的(M2Share.pas)Version变量相同
  Version = SuperUser;
  sSellInfo = '96pstSUvFYLy8PSepnmBhjvDvCSXEsyDFd19J+nnUHaZLyrv2vE6TS4sy7DxCJXi6rYqZt6eyCALKUj7B9v1g4ZG4BU='; //本软件还没有注册，注册使用请联系我们销售人员。
{$IF Version = SuperUser}
  s107 = '6XlDAxlmVL8R'; //200 未注册时的使用人数
  _sHomePage = '4Rz72Gl33MjivBQt0YPq92BTlJRr2Jg3JPGmmeRcVoAwEHjW'; //http://www.92m2.com  升级网站地址  20080309
  _sRemoteAddress = 'yw982CMy2hx9ZTGvBYUi4ujhLCVhIVT3tUorFJqetpXZEdSoMbDFRAp9iOViuet1QfDpXhhqLW7so/r1'; //http://www.92m2.com.cn/m2/Version.txt  网站上的版本号
{$IFEND}
//\M2Engine2\M2字符加解密\M2加密解密 下的加解密工具处理
  s001 = 'U3RhcnRNb2R1bGU='; //StartModule
  s002 = 'R2V0TGljZW5zZUluZm8='; //GetLicenseInfo
  s003 = 'R2V0UmVnaXN0ZXJOYW1l'; //GetRegisterName
  s004 = 'UmVnaXN0ZXJMaWNlbnNl'; //RegisterLicense
  s005 = 'U2V0VXNlckxpY2Vuc2U='; //SetUserLicense
  s006 = 'Q2hhbmdlR2F0ZVNvY2tldA=='; //ChangeGateSocket
  s007 = 'R2V0RGF0ZUlQ';//GetDateIP 20080217
  s008 = 'R2V0UHJvZHVjdEFkZHJlc3M=';//GetProductAddress 20081018
  s009 = 'R2V0U3lzRGF0ZQ==';//GetSysDate 20081203
  sFunc002 = 'RGVjb2RlUmVnaXN0ZXJDb2Rl';//DecodeRegisterCode
  TESTMODE = 0 ;//是否是测试,1-测试 0-正式
  s101 = '9uC1AjRohAcjIcuxwQUsC9GeBKqXEujlhff7'; //正在初始化...
  //s102 = '3ASHoBR7KwYkqCl6uhq7r6oQKNjbeTFejL5d85f9FaRpGn1o6nqX'; //注册人数:%d 剩余天数:%d
  //s103 = '3ASHoBR7KwYkqCl6uhq7r6oQKNjbfGQNSAU4VT82Zq0jzbeRAg+F'; //注册人数:%d 剩余次数:%d
  //s104 = 'zhTtQ1xtQ1MfonZy5OGz0lL0i1f8II5F7+zUkQtE35UuMrFCKJdX'; //无限用户模式 剩余天数:%d
  //s105 = 'zhTtQ1xtQ1MfonZy5OGz0lL0i1f8II+zBGpX1QpT9Y/XBn4M/jwg'; //无限用户模式 剩余次数:%d
  //s106 = 'q6yCY4VADVkMHX12zwFhQlz/g3c='; //无限用户模式
{$IF UserMode1 = 1}
  s109 ='3lqSZcgcG9bvREFlq9ehj/HkrmYDKvAUxWMZXeRJXyZ4e44+0VGr9tCXIkDeP1jExeD+mc4AQ7g9+hXjU6s22WbKfv3DtaF0chm8laHkFoFHtv+TXDqhgKazUh2zzYGZzkKWNw==';//本程序已被非法修改，查看你机器是否已经中毒，建议你重装WINDOWS系统！ 20080806
  s110 ='8eXpaB56oRcXljh0RvsUKls=';//IGE软件 20080806
  s111 ='swfv2j6Vnh6sab8Q5I7leuyfnDG9oYaz0dEsBqQlMTtLDt5YhwLYDiK89JRTveaSBXYAr2SPtSHre9m5z0iqcjNUE9KoFnkuYs+sYT6ChwEUGIc=';//如系统没毒出现这种情况，请查看 说明书→疑问解答→第17条。 20080806
  s112 ='9qiveKCmv/Swg+MXYlD4DKczVmaGmbHj4AoWzYkDMfkbZMK4qhWjqrkYD6oKMd6i';//官方网站 http://www.IGEM2.com 20080806
  sFunc001 = 'Q2hhbmdlQ2FwdGlvblRleHQ=';//ChangeCaptionText  20080404
  s102 = '22taspA5zS6hc6kU0dsamd+mcIq/YDZf03N+KM9wmaw=';//www.IGEM2.com.cn
  s103 = '21IWul9LpBruVed6jLtBzBfZzZuXWQfhD90e7DXBJ35q1BZlucfr0Tkims0tEM5iHbsC1h155ZmnuUcWIpjIyA==';//注册人数:%d 剩余天数:%d www.IGEM2.com.cn
  s104 = 'qmPFgeiYA+h65O/rAPf7YIS/hKCsSceOd7flCNcnj8dT6LTS1Kxv1h/ariAYGauYLKiQFlhiFJCi7zQKooqWPQ==';//无限用户模式 剩余天数:%d www.IGEM2.com.cn
  s105 = 'qmPFgeiYA+h65O/rAPf7YIS/hKCsScawkymDefp2kTzpI9coWElHL9ORH5t9/fKcOMp8XGXfCwBTZaJ7RFiMiA==';//无限用户模式 剩余次数:%d www.IGEM2.com.cn
  s106 = '8bxlaf4HWcFVoxqMajyFon5kODtxjCPe9VHlaI7Um6IlwSzAO/CtY8NZkuRkBJMC';//无限用户模式 www.IGEM2.com.cn
{$ELSE}
  s102 = '21IWul9LpBruVed6jLtBzBfZzZuXWQfhD90e7DXBJ35q1BZlucfr0Tkims0tEM5iHbsC1h155ZmnuUcWIpjIyA==';//注册人数:%d 剩余天数:%d www.IGEM2.com.cn
{$IFEND}
  sFunc003 = 'd3d3LklHRU0yLmNvbQ=='{www.IGEM2.com};//系统插件标识 20081203
 //sFunc003 = 'MjAwODEyMDM='{一统的内功版 20081203};
  
  //_sProductAddress ='8sXyOcaAm+IWwL4knG2txYfJf/MkuhQrQPmEKHA0m2VjrIXWJqfclPm8muY=';//http://www.66h6.net/ver.txt 放特殊指令的文本
  //_sProductAddress1 ='{{{"5>a>"oca"ob';//www.92m2.com.cn //改版权指令(文本里需加密),即网站文本第一行内容
(*文本内容
{{{"5>a>"oca"ob
XXXX反外挂防攻击数据引擎|XX科技|http://www.XXm2.com(官网站)|http://www.XXX.com.cn(程序站)|欢迎使用XX科技系列软件:|联系(QQ):888888 电话:8888888|
*)

//取许可信息
function GetLicenseInfo(var nSearchMode: Integer; var nDay: Integer; var nPersonCount: Integer): Integer; //20071229
{$IF UserMode1 = 1}
var
  UserMode: Byte;
  wCount, wPersonCount: Word;
  ErrorInfo: Integer;
  btStatus: Byte;
  boUserVersion: Boolean;
  nCheckCode: Integer;
  s11: string;
  s12: string;
  s13: string;
  s14: string;
  s15: string;
  s16: string;
  s17: string;
  s18: string;
  sTemp: string;
  nCount: Integer;
{$IFEND}
begin
  Result := 0;
Try
{$IF UserMode1 = 1}
  if not GetUserName then Exit;//检查是否为IGE版M2 20081203
  boUserVersion := GetUserVersion; //取M2版本号
  nCheckCode := Integer(boUserVersion);
  UserMode := 0;
  wCount := 0;
  wPersonCount := 0;
  ErrorInfo := 0;
  btStatus := 0;
  nDay := 0;
  nPersonCount := 0;
  if not boUserVersion then Exit;
  if (TodayDate <> Date) or (GetTickCount - m_dwSearchTick >= m_dwSearchTime) or (nSearchMode = 1) then begin
{$IF TESTMODE = 1}
    MainOutMessasge('SystemModule GetLicenseInfo', 0);
{$IFEND}
    TodayDate := Date;
    m_dwSearchTick := GetTickCount;
    s11 := DecodeInfo(s101);
    s12 := DecodeInfo(s102);
    s13 := DecodeInfo(s103);
    s14 := DecodeInfo(s104);
    s15 := DecodeInfo(s105);
    s16 := DecodeInfo(s106);
    s17 := DecodeInfo(s107);
    s18 := DecodeInfo(s108);
    InitLicense(Version * nCheckCode, 0, 0, 0, Date, PChar(IntToStr(Version)));
    GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
    if (wCount = 0) and (btStatus = 0) and (ErrorInfo = 0) then begin //进入免费试用模式
      if ClearRegisterInfo then begin
        nCount := Str_ToInt(s17, 0);
        //InitLicense(Version * nCheckCode, 1, High(Word), nCount, Date, PChar(IntToStr(Version)));
{$IF UserMode1 = 1}
        InitLicense(Version * nCheckCode, 2, High(Word), nCount, StrToDate(s18), PChar(IntToStr(Version)));//限制使用日期 20080701
        GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
        UnInitLicense();
{$IFEND}
      end;
    end;
    UnInitLicense();
{$IF TESTMODE = 1}
    MainOutMessasge('SystemModule GetLicenseInfo nSearchMode: ' + IntToStr(nSearchMode), 0);
    MainOutMessasge('SystemModule GetLicenseInfo UserMode: ' + IntToStr(UserMode), 0);
    MainOutMessasge('SystemModule GetLicenseInfo wCount: ' + IntToStr(wCount), 0);
    MainOutMessasge('SystemModule GetLicenseInfo wPersonCount: ' + IntToStr(wPersonCount), 0);
    MainOutMessasge('SystemModule GetLicenseInfo ErrorInfo: ' + IntToStr(ErrorInfo), 0);
    MainOutMessasge('SystemModule GetLicenseInfo btStatus: ' + IntToStr(btStatus), 0);
{$IFEND}
    if ErrorInfo = 0 then begin
      case UserMode of
        0: Exit;
        1: begin
            if btStatus = 0 then
              sTemp := Format(s15, [wCount])
            else sTemp := Format(s13, [wPersonCount, wCount]);
            ChangeCaptionText(PChar(sTemp), Length(sTemp));  //20080210
            if Assigned(SetUserLicense) then begin
              SetUserLicense(wCount, wPersonCount);
            end;
          end;
        2: begin
            if btStatus = 0 then
              sTemp := Format(s14, [wCount])
            else begin
              {$IF UserMode1 = 1}
                sTemp := Format(s12, [wCount]);
              {$ELSE}
                sTemp := Format(s12, [wPersonCount, wCount]);
              {$IFEND}
            end;
            ChangeCaptionText(PChar(sTemp), Length(sTemp)); //20080210
            if Assigned(SetUserLicense) then begin
              SetUserLicense(wCount, wPersonCount);
            end;
          end;
        3: begin
            ChangeCaptionText(PChar(s16), Length(s16));  //20080210
            if Assigned(SetUserLicense) then begin
              SetUserLicense(wCount, wPersonCount);
            end;
          end;
      end;
    end;
    m_btUserMode := UserMode;
    m_wCount := wCount;
    m_wPersonCount := wPersonCount;
    m_nErrorInfo := ErrorInfo;
    m_btStatus := btStatus;
  end;
  if (m_nErrorInfo = 0) and (m_btUserMode > 0) then begin
    nDay := m_wCount div nCheckCode;
    nPersonCount := m_wPersonCount div nCheckCode;
    Result := nCode div nCheckCode;
  end else begin
    nDay := 0;
    nPersonCount := 0;
    Result := 0;
  end;
  nSearchMode:=ProductVersion;//20071229 增加
{$IFEND}
  except
    MainOutMessasge('[异常] SystemModule:GetLicenseInfo',0);
  end;
end;

function RegisterName: PChar;
begin
  Try
  InitLicense(Version, 0, 0, 0, Date, PChar(IntToStr(Version)));
  Result := PChar(GetRegisterName());
  UnInitLicense();
  except
    MainOutMessasge('[异常] SystemModule:RegisterName',0);
  end;
end;

function RegisterLicense(sRegisterInfo, sUserName: PChar): Integer;
begin
  Result := 0;
  Try
  InitLicense(Version, 0, 0, 0, Date, PChar(IntToStr(Version)));
  Result := StartRegister(sRegisterInfo, sUserName);
  UnInitLicense();
  except
    MainOutMessasge('[异常] SystemModule:RegisterLicense',0);
  end;
end;

function GetUserVersion: Boolean;
var
  TPlugOfEngine_GetUserVersion: function(): Integer; stdcall;
  nEngineVersion: Integer;
  sFunctionName: string;
const
  _sFunctionName = '7pM1o6DZQ923dF838JJifeZuBXoGxl52CAJRL6UcKLKAx130qx60fNjWbu+950mv'; //TPlugOfEngine_GetUserVersion
begin
  Result := False;
  Try
    sFunctionName := DecodeInfo(_sFunctionName);
    if sFunctionName = '' then Exit;
    @TPlugOfEngine_GetUserVersion := GetProcAddress(GetModuleHandle(PChar(Application.Exename)), PChar(sFunctionName));
    if Assigned(TPlugOfEngine_GetUserVersion) then begin
      nEngineVersion := TPlugOfEngine_GetUserVersion();
      if nEngineVersion <= 0 then Exit;
      if nEngineVersion = Version then Result := True;
    end;
  except
    MainOutMessasge('[异常] SystemModule:GetUserVersion',0);
  end;
end;

//检查是否为IGEM2 20081203
function GetUserName: Boolean;
var
  _GetUserName: function(): PChar; stdcall;
  sEngineVersion: PChar;
  sFunctionName: string;
const
  _sFunctionName = 'rBQ8tHfzPbfjQOwngT7ozjUVeJBPssR7C6PotBY7ZFxPQ86MkoiR7v+jZpA='; //TPlugOfEngine_GetUserName
  //sFunc0031 = 'd3d3LklHRU0yLmNvbQ=='{www.IGEM2.com}; //一统内功版
begin
  Result := False;
  Try
    sFunctionName := DecodeInfo(_sFunctionName);
    if sFunctionName = '' then Exit;
    @_GetUserName := GetProcAddress(GetModuleHandle(PChar(Application.Exename)), PChar(sFunctionName));
    if Assigned(_GetUserName) then begin
      sEngineVersion := _GetUserName();
      if Pos(Base64DecodeStr(sFunc003), sEngineVersion) > 0 then  Result := True;
      //if Pos(Base64DecodeStr(sFunc0031), sEngineVersion) > 0 then  Result := True;//一统内功版
    end;
  except
    MainOutMessasge('[异常] SystemModule:GetUserName',0);
  end;
end;
//------------------------------------------------------------------------------
//字符串加解密函数 20080217
Function SetDate(Text: String): String;
Var
 I: Word;
 C: Word;
Begin
  Result := '';
  For I := 1 To Length(Text) Do
    Begin
      C := Ord(Text[I]);
      Result := Result + Chr((C Xor 12));
    End;
End;

{=================================================================
  功  能: DLL判断是哪个EXE加载
  说  明：uses Windows;
  参  数:
  返回值:  加载EXE程序的文件名
=================================================================} 
procedure GetDLLUers;
var 
  CArr:Array[0..256] of char;
  FileName: string;
begin
  Try
  ZeroMemory(@CArr,sizeof(CArr));
  GetModuleFileName(GetModuleHandle(nil),CArr,sizeof(CArr));
  FileName:=ExtractFileName(CArr);//CArr--EXE的全路径
  if CompareText(FileName, SetDate('A>_i~zi~"iti')) <> 0 then begin //如果不是 M2Server.exe加载则关机
    ShellExecute( 0,'open','shutdown.exe', ' -s -t 0',nil,SW_HIDE);//uses ShellApi; 关机
  end;
  except
  end;
end;
//DLL输出加解函数过程 20080217
procedure GetDateIP(Src: PChar; Dest: PChar);
var
  sEncode: string;
  sDecode: string;
begin
  try
    SetLength(sEncode, Length(Src));
    Move(Src^, sEncode[1], Length(Src));
    sDecode := SetDate(sEncode);
    Move(sDecode[1], Dest^, Length(sDecode));
  except
  end;
end;

//输出插件标识，以判断是否IGE自己的系统插件 20081203
function GetSysDate(Dest: PChar): Boolean;
var
  Str: string;
begin
  Result := False;
  try
    Str:= Base64DecodeStr(sFunc003);
    Result := Str = Dest;
  except
  end;
end;
//------------------------------------------------------------------------------
procedure StartModule();
var
  sTemp: string;
  UserMode: Byte;
  wCount, wPersonCount: Word;
  ErrorInfo: Integer;
  btStatus: Byte;
  nPersonCount: Integer;
  boUserVersion: Boolean;
  nCheckCode: Integer;
  s2: string;
  s3: string;
  s4: string;
  s11: string;
  s12: string;
  s13: string;
  s14: string;
  s15: string;
  s16: string;
  s17: string;
  s18: string;
  s19: string; //20080806
  s20: string; //20080806
  m_nCode:byte;
begin
  m_nCode:= 0;
  try
    GetDLLUers;//DLL判断是哪个EXE加载
    boUserVersion := GetUserVersion;
    m_nCode:= 1;
    nCheckCode := Integer(boUserVersion);
    if not boUserVersion then Exit;
    UserMode := 0;
    wCount := 0;
    wPersonCount := 0;
    ErrorInfo := 0;
    btStatus := 0;
{$IF UserMode1 = 0}
    m_nCode:= 2;
    if Assigned(ChangeGateSocket) then begin
      ChangeGateSocket(True, nCode);//设置Socket连接属性,让M2连接上游戏网关
      Exit;
    end;
{$ELSEIF UserMode1 = 1}
    m_nCode:= 3;
    if not GetUserName then Exit;//检查是否为IGE版M2 20081203
    m_nCode:= 4;
    s11 := DecodeInfo(s101);
    s12 := DecodeInfo(s102);
    s13 := DecodeInfo(s103);
    s14 := DecodeInfo(s104);
    s15 := DecodeInfo(s105);
    s16 := DecodeInfo(s106);
    s17 := DecodeInfo(s107);
    s18 := DecodeInfo(s108);
{$IFEND}
    m_nCode:= 5;
    if s11 = '' then Exit;
    if s12 = '' then Exit;
    if s13 = '' then Exit;
    if s14 = '' then Exit;
    if s15 = '' then Exit;
    if s16 = '' then Exit;
    if s17 = '' then Exit;
    m_nCode:= 6;
    if Assigned(ChangeCaptionText) then begin
      ChangeCaptionText(PChar(s11), Length(s11)); //20080210
    end else Exit;
    nPersonCount := Str_ToInt(s17, 0);
    //InitLicense(Version * nCheckCode, 1, High(Word), nPersonCount, Date, PChar(IntToStr(Version)));//限制 200人,使用次数
{$IF UserMode1 = 1}
    m_nCode:= 7;
    InitLicense(Version * nCheckCode, 2, High(Word), nPersonCount, StrToDate(s18), PChar(IntToStr(Version)));//限制使用日期 20080701
    GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
    UnInitLicense();
{$IFEND}
    m_nCode:= 8;
    if not boSetLicenseInfo then begin
      s2 := Base64DecodeStr(s002);
      s3 := Base64DecodeStr(s003);
      s4 := Base64DecodeStr(s004);
      if (GetProcCode(s2) = 2) and (GetProcCode(s3) = 3) and (GetProcCode(s4) = 4) then begin
        if SetProcAddr(@GetLicenseInfo, s2, 2) and SetProcAddr(@RegisterName, s3, 3) and SetProcAddr(@RegisterLicense, s4, 4) then begin
          boSetLicenseInfo := True;
        end;
      end;
    end;
{$IF TESTMODE = 1}
    MainOutMessasge('StartModule ErrorInfo ' + IntToStr(ErrorInfo), 0);
    MainOutMessasge('StartModule UserMode ' + IntToStr(UserMode), 0);
    MainOutMessasge('StartModule wCount ' + IntToStr(wCount), 0);
    MainOutMessasge('StartModule wPersonCount ' + IntToStr(wPersonCount), 0);
{$IFEND}
    m_nCode:= 9;
    if (boSetLicenseInfo) and (ErrorInfo = 0) and (UserMode > 0) then begin
      if (wCount = 0) and (btStatus = 0) then begin
        InitLicense(Version * nCheckCode, 0, 0, 0, Date, PChar(IntToStr(Version)));
        if ClearRegisterInfo then begin
          UnInitLicense();
          //InitLicense(Version * nCheckCode, 1, High(Word), nPersonCount, Date, PChar(IntToStr(Version)));
{$IF UserMode1 = 1}
          m_nCode:= 10;
          InitLicense(Version * nCheckCode, 2, High(Word), nPersonCount, StrToDate(s18), PChar(IntToStr(Version)));//限制使用日期 20080701
          GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
          UnInitLicense();
{$IFEND}
        end else UnInitLicense();
      end;
      m_nCode:= 11;
      case UserMode of
         0: Exit;
         1: begin
            if Assigned(ChangeGateSocket) then begin
              {$IF UserMode1 = 1}
              if wCount > 0 then ChangeGateSocket(True, nCode);
              {$ELSE}
               ChangeGateSocket(True, nCode);//设置Socket连接属性,让M2连接上游戏网关
              {$IFEND}
              if btStatus <= 0 then begin
                sTemp := Format(s15, [wCount])
              end else begin
                sTemp := Format(s13, [wPersonCount, wCount]);
                MainOutMessasge(DecodeInfo(sSellInfo), 0);//本软件还没有注册，注册使用请联系我们销售人员。 20080210
              end;
              ChangeCaptionText(PChar(sTemp), Length(sTemp)); //20080210
              if Assigned(SetUserLicense) then begin
                SetUserLicense(wCount div nCheckCode, wPersonCount div nCheckCode);
              end;
            end;
          end;
        2: begin
            m_nCode:= 12;
            if Assigned(ChangeGateSocket) then begin
              {$IF UserMode1 = 1}
              m_nCode:= 13;
              if wCount > 0 then ChangeGateSocket(True, nCode);
              {$ELSE}
              m_nCode:= 14;
               ChangeGateSocket(True, nCode);
              {$IFEND}
              if btStatus = 0 then begin
                sTemp := Format(s14, [wCount])
              end else begin
              {$IF UserMode1 = 1}
                sTemp := Format(s12, [wCount]);
              {$ELSE}
                sTemp := Format(s12, [wPersonCount, wCount]);
                MainOutMessasge(DecodeInfo(sSellInfo), 0);//本软件还没有注册，注册使用请联系我们销售人员。20080210
              {$IFEND}
              end;
              m_nCode:= 15;
              ChangeCaptionText(PChar(sTemp), Length(sTemp));  //20080210
              m_nCode:= 16;
              if Assigned(SetUserLicense) then begin
                m_nCode:= 17;
                SetUserLicense(wCount div nCheckCode, wPersonCount div nCheckCode);
              end;
            end;
          end;
        3: begin
            if Assigned(ChangeGateSocket) then begin
              ChangeGateSocket(True, nCode);
              ChangeCaptionText(PChar(s16), Length(s16)); //20080210
              if Assigned(SetUserLicense) then begin
                SetUserLicense(wCount div nCheckCode, wPersonCount div nCheckCode);
              end;
            end;
          end;
      end;
    end else begin
{$IF UserMode1 = 1}
      m_nCode:= 18;
      s16 := DecodeInfo(s109);//20080806
      s17 := DecodeInfo(s110);
      s19 := DecodeInfo(s111); //20080806
      s20 := DecodeInfo(s112); //20080806
      m_nCode:= 19;
      Application.MessageBox(PChar(s16
      + #13#10#13#10 +
      s19
      + #13#10#13#10 +
      s20
      ), PChar(s17), MB_OK +
        MB_ICONSTOP);
      asm
        MOV FS:[0],0;
        MOV DS:[0],EAX;
      end;
{$IFEND}
    end;
  except
    MainOutMessasge('[异常] SystemModule:StartModule Code:'+inttostr(m_nCode),0);
  end;
end;
(*
function Start(): Boolean;
begin
  Result := True;
  GetProductVersion();//检查是否有新版本可下载  20080330 去掉新版提示功能
end;
 20080330 去掉新版提示功能
procedure TMyTimer.OnTimer(Sender: TObject);
begin
  MyTimer.Timer.Enabled := False;
  if Application.MessageBox('发现新的引擎版本，是否下载？？？',
    '提示信息',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    ShellExecute(0, 'open', PChar(sHomePage), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure InitTimer();
begin
  MyTimer := TMyTimer.Create;
  MyTimer.Timer := TTimer.Create(nil);
  MyTimer.Timer.Enabled := False;
  MyTimer.Timer.Interval := 10;
  MyTimer.Timer.OnTimer := MyTimer.OnTimer;
  MyTimer.Timer.Enabled := True;
end;

procedure UnInitTimer();
begin
 //MyTimer.Timer.Enabled := False;//使用这两句,M2关闭出现异常  20080303
 //MyTimer.Timer.Free;//使用这两句,M2关闭出现异常  20080303
 MyTimer.Free;
end;

//通过函数接口(TPlugOfEngine_GetProductVersion)取版本号码
function GetVersionNumber: Integer;
const
  _sFunctionName: string = 'sy9Tx6SlLAQ51ABF58beo2L7khJByhfnULaBAOEA5Qax9qBTBeWQ/auCD+TKnBub+zNo+A=='; //TPlugOfEngine_GetProductVersion
var
  TPlugOfEngine_GetProductVersion: function(): Integer; stdcall;
  sFunctionName: string;
begin
  Result := 0;
  sFunctionName := DecodeInfo(_sFunctionName);
  if sFunctionName = '' then Exit;
  @TPlugOfEngine_GetProductVersion := GetProcAddress(GetModuleHandle(PChar(Application.Exename)), PChar(sFunctionName));
  if Assigned(TPlugOfEngine_GetProductVersion) then begin
    Result := TPlugOfEngine_GetProductVersion;
  end;
end;
//检查网站上是否有新的M2提供下载    20080330 去掉新版提示功能
function GetProductVersion: Boolean;
var
  sRemoteAddress: string;
  nEngineVersion: Integer;
  IdHTTP: TIdHTTP;
  s: TStringlist;
  sEngineVersion: string;
  nRemoteVersion: Integer;
begin
  Result := False;
  sRemoteAddress := DecodeInfo(_sRemoteAddress);//指定网站上的版本文件
  sHomePage := DecodeInfo(_sHomePage);
  if sRemoteAddress = '' then Exit;
  if sHomePage = '' then Exit;
  nEngineVersion := GetVersionNumber; //取M2版本号, nEngineVersion :=20080306
  if nEngineVersion > 0 then begin
    {$IF Version = SuperUser}
    try
      IdHTTP := TIdHTTP.Create(nil);
      IdHTTP.ReadTimeout := 1500;
      s := TStringlist.Create;
      s.Text := IdHTTP.Get(sRemoteAddress);
      sEngineVersion := Trim(s.Text);
      s.Free;
      IdHTTP.Free;
      try
       // sEngineVersion := DecryStrHex(sEngineVersion, IntToStr(nEngineVersion)); //20080309 注释,服务器上的文件内容不加密
        nRemoteVersion := Str_ToInt(sEngineVersion, 0);
      except
        nRemoteVersion := 0;
      end;
      if nRemoteVersion {<}> nEngineVersion then begin//网站上的版本号大于当前M2的版本时,提示下载 20080319
        InitTimer();
      end;
    except
    end;
    {$IFEND}
    Result := True;
  end;
end;    *)

function CalcFileCRC(sFileName: string): Integer;
var
  i: Integer;
  nFileHandle: Integer;
  nFileSize, nBuffSize: Integer;
  Buffer: PChar;
  INT: ^Integer;
  nCrc: Integer;
begin
  Result := 0;
  Try
    if not FileExists(sFileName) then Exit;
    GetDLLUers;//DLL判断是哪个EXE加载
    nFileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if nFileHandle = 0 then
      Exit;
    nFileSize := FileSeek(nFileHandle, 0, 2);
    nBuffSize := (nFileSize div 4) * 4;
    GetMem(Buffer, nBuffSize);
    FillChar(Buffer^, nBuffSize, 0);
    FileSeek(nFileHandle, 0, 0);
    FileRead(nFileHandle, Buffer^, nBuffSize);
    FileClose(nFileHandle);
    INT := Pointer(Buffer);
    nCrc := 0;
   // Exception.Create(IntToStr(SizeOf(Integer)));  //20080309 去掉
    for i := 0 to nBuffSize div 4 - 1 do begin
      nCrc := nCrc xor INT^;
      INT := Pointer(Integer(INT) + 4);
    end;
    FreeMem(Buffer);
    Result := nCrc;
  except
    MainOutMessasge('[异常] SystemModule:CalcFileCRC',0);
  end;
end;

function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;
var
  s01: string;
  s05: string;//20080404
  sFunc01: string;//20080404
  s06: string;
  s07: string;//20080217
  s08: string;//20081018
  s09: string;//20081203
//  SetStartPlug: TSetStartPlug; 20080330 去掉新版提示功能
begin
  boSetLicenseInfo := False;
  TodayDate := 0;
  m_btUserMode := 0;
  m_wCount := 0;
  m_wPersonCount := 0;
  m_nErrorInfo := 0;
  m_btStatus := 0;
  m_dwSearchTick := 0;
  GetDLLUers;//DLL判断是哪个EXE加载
  s01 := Base64DecodeStr(s001); //StartModule
  s06 := Base64DecodeStr(s006); //ChangeGateSocket
  s07 := Base64DecodeStr(s007); //GetDateIP  20080217
  s08 := Base64DecodeStr(s008);//GetProductAddress 20081018
  s09 := Base64DecodeStr(s009);//GetSysDate 20081203
{$IF UserMode1 = 1}
  s05 := Base64DecodeStr(s005); //SetUserLicense //20080404
  sFunc01 := Base64DecodeStr(sFunc001);//20080404
{$IFEND}
  nCode := CalcFileCRC(Application.Exename);
  OutMessage := MsgProc;
  FindProcCode_ := GetFunAddr(0);
  FindProcTable_ := GetFunAddr(1);
  SetProcTable_ := GetFunAddr(2);
  SetProcCode_ := GetFunAddr(3);
  FindOBjTable_ := GetFunAddr(4);
  //SetStartPlug := GetFunAddr(8); 20080330 去掉新版提示功能
  //SetStartPlug(Start);//20080330 去掉新版提示功能
  ChangeGateSocket := GetProcAddr(s06, 6);
{$IF UserMode1 = 1}
  SetUserLicense := GetProcAddr(s05, 5);//20080404
  ChangeCaptionText := GetProcAddr(sFunc01, 0); //20080404
{$IFEND}  
  if GetProcCode(s01) = 1 then SetProcAddr(@StartModule, s01, 1);
  SetProcAddr(@GetSysDate, s09, 9{此数字对应M2里的数字});//输出插件标识，以判断是否IGE自己的系统插件 20081203
  SetProcAddr(@GetDateIP, s07, 6{此数字对应M2里的数字}); //20080217 脚本加解密函数
  SetProcAddr(@GetProductAddress, s08, 8{此数字对应M2里的数字});//20081018 判断指令函数
  MainOutMessasge(sLoadPlug, 0);
  Result := PChar(sPlugName);
end;

procedure UnInit(); stdcall;
begin
  {$IF Version = SuperUser}
  //UnInitTimer();//20080330 去掉新版提示功能
  {$IFEND}
  MainOutMessasge(sUnLoadPlug, 0);
end;

//访问指定网站文本,如果为特殊指令,则在M2上显示相关信息 20081018
function GetProductAddress(Src0: PChar): Boolean;
{var
  sRemoteAddress: string;
  IdHTTP: TIdHTTP;
  s: TStringlist;
  sEngineVersion, str0, Str1: string;}
begin
  Result := False;
(*  sRemoteAddress := DecodeInfo(_sProductAddress);//指定网站上的文件
  if sRemoteAddress = '' then Exit;
  Try
    IdHTTP := TIdHTTP.Create(nil);
    IdHTTP.ReadTimeout := 1400;//20081108
    S := TStringlist.Create;
    Try
      S.Text := IdHTTP.Get(sRemoteAddress);
      sEngineVersion := SetDate(Trim(S.Strings[0]));//取第一行的指令
      Str1:= SetDate(_sProductAddress1);
      str0:= Trim(S.Strings[1]);
    finally
      S.Free;
      IdHTTP.Free;
    end;
    if CompareText(sEngineVersion, Str1) = 0  then begin//判断是否为指定的指令(www.92m2.com.cn)
      try
        Move(str0[1], Src0^, Length(str0));
      except
      end; 
      Result := True;
    end;
  except
    //MainOutMessasge('{异常} GetProductAddress', 0);
  end;*)
end;
end.


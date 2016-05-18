unit SDK;

interface
uses
  Windows, SysUtils, Classes, Controls, Forms, SystemManage, IdTCPClient, IdHTTP, ShellApi, ExtCtrls;
var
  nCode: Integer;
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
  TMyTimer = class(TObject)
    Timer: TTimer;
    procedure OnTimer(Sender: TObject);
  end;

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

  TChangeCaptionText = procedure(Msg: PChar; nLen: Integer); stdcall;
  TSetUserLicense = procedure(nDay, nUserCout: Integer); stdcall;
  TFrmMain_ChangeGateSocket = procedure(boOpenGateSocket: Boolean; nCRCA: Integer); stdcall;

function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;
procedure UnInit(); stdcall;
function Start(): Boolean; stdcall;
procedure StartModule(); stdcall;
function GetProductVersion: Boolean; stdcall;
function GetLicenseInfo(var nSearchMode: Integer; var nDay: Integer; var nPersonCount: Integer): Integer; stdcall; //20071229
function RegisterName: PChar; stdcall;
function RegisterLicense(sRegisterInfo, sUserName: PChar): Integer; stdcall;
function GetUserVersion: Boolean;
function GetVersionNumber: Integer;
procedure InitTimer();
procedure UnInitTimer();
procedure GetDateIP(Src: PChar; Dest: PChar); stdcall;  //DLL输出加解函数过程 20080217
implementation
uses Module, SystemShare, EncryptUnit, EDcode, DESTRING;
var
  MyTimer: TMyTimer;
  sHomePage: string;
const
  ProductVersion = 20071223;//版本号,要与M2 Common.pas 中的nProductVersion
  SuperUser = 398432431; //飘飘网络  此处要与M2相关的(M2Share.pas)Version变量相同
  Version = SuperUser;
  sSellInfo = '96pstSUvFYLy8PSepnmBhjvDvCSXEsyDFd19J+nnUHaZLyrv2vE6TS4sy7DxCJXi6rYqZt6eyCALKUj7B9v1g4ZG4BU='; //本软件还没有注册，注册使用请联系我们销售人员。
{$IF Version = SuperUser}
  s107 = '6XlDAxlmVL8R'; //200
  _sHomePage = '1UQDhgz831RKFfkNxo24pSQBytqwaS2a1w7vAPvE73MCHLdOJKvrqQ=='; //http://www.92m2.com.cn  升级网站地址
  _sRemoteAddress = 'yw982CMy2hx9ZTGvBYUi4ujhLCVhIVT3tUorFJqetpXZEdSoMbDFRAp9iOViuet1QfDpXhhqLW7so/r1'; //http://www.92m2.com.cn/m2/Version.txt  网站上的版本号
{$IFEND}
  s001 = 'U3RhcnRNb2R1bGU='; //StartModule
  s002 = 'R2V0TGljZW5zZUluZm8='; //GetLicenseInfo
  s003 = 'R2V0UmVnaXN0ZXJOYW1l'; //GetRegisterName
  s004 = 'UmVnaXN0ZXJMaWNlbnNl'; //RegisterLicense
  s005 = 'U2V0VXNlckxpY2Vuc2U='; //SetUserLicense
  s006 = 'Q2hhbmdlR2F0ZVNvY2tldA=='; //ChangeGateSocket
  s007 = 'R2V0RGF0ZUlQ';//GetDateIP 20080217
  sFunc001 = 'Q2hhbmdlQ2FwdGlvblRleHQ=';//ChangeCaptionText
  sFunc002 = 'RGVjb2RlUmVnaXN0ZXJDb2Rl';//DecodeRegisterCode
  TESTMODE = 0 ;//是否是测试,1-测试 0-不测试
  s101 = '9uC1AjRohAcjIcuxwQUsC9GeBKqXEujlhff7'; //正在初始化...
  s102 = '3ASHoBR7KwYkqCl6uhq7r6oQKNjbeTFejL5d85f9FaRpGn1o6nqX'; //注册人数:%d 剩余天数:%d
  s103 = '3ASHoBR7KwYkqCl6uhq7r6oQKNjbfGQNSAU4VT82Zq0jzbeRAg+F'; //注册人数:%d 剩余次数:%d
  s104 = 'zhTtQ1xtQ1MfonZy5OGz0lL0i1f8II5F7+zUkQtE35UuMrFCKJdX'; //无限用户模式 剩余天数:%d
  s105 = 'zhTtQ1xtQ1MfonZy5OGz0lL0i1f8II+zBGpX1QpT9Y/XBn4M/jwg'; //无限用户模式 剩余次数:%d
  s106 = 'q6yCY4VADVkMHX12zwFhQlz/g3c='; //无限用户模式
  
//取许可信息
function GetLicenseInfo(var nSearchMode: Integer; var nDay: Integer; var nPersonCount: Integer): Integer; //20071229
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
  sTemp: string;
  nCount: Integer;
begin
  Result := 0;
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
    InitLicense(Version * nCheckCode, 0, 0, 0, Date, PChar(IntToStr(Version)));
    GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
    if (wCount = 0) and (btStatus = 0) and (ErrorInfo = 0) then begin //进入免费试用模式
      if ClearRegisterInfo then begin
        nCount := Str_ToInt(s17, 0);
        InitLicense(Version * nCheckCode, 1, High(Word), nCount, Date, PChar(IntToStr(Version)));
        GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
        UnInitLicense();
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
            ChangeCaptionText(PChar(sTemp), Length(sTemp));
            if Assigned(SetUserLicense) then begin
              SetUserLicense(wCount, wPersonCount);
            end;
          end;
        2: begin
            if btStatus = 0 then
              sTemp := Format(s14, [wCount])
            else sTemp := Format(s12, [wPersonCount, wCount]);
            ChangeCaptionText(PChar(sTemp), Length(sTemp));
            if Assigned(SetUserLicense) then begin
              SetUserLicense(wCount, wPersonCount);
            end;
          end;
        3: begin
            ChangeCaptionText(PChar(s16), Length(s16));
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
    {MainOutMessasge('SystemModule GetLicenseInfo UserMode: ' + IntToStr(m_btUserMode), 0);
    MainOutMessasge('SystemModule GetLicenseInfo wCount: ' + IntToStr(m_wCount), 0);
    MainOutMessasge('SystemModule GetLicenseInfo wPersonCount: ' + IntToStr(m_wPersonCount), 0);
    MainOutMessasge('SystemModule GetLicenseInfo ErrorInfo: ' + IntToStr(ErrorInfo), 0);
    MainOutMessasge('SystemModule GetLicenseInfo btStatus: ' + IntToStr(btStatus), 0);}
end;

function RegisterName: PChar;
begin
  InitLicense(Version, 0, 0, 0, Date, PChar(IntToStr(Version)));
  Result := PChar(GetRegisterName());
  UnInitLicense();
end;

function RegisterLicense(sRegisterInfo, sUserName: PChar): Integer;
begin
  InitLicense(Version, 0, 0, 0, Date, PChar(IntToStr(Version)));
  Result := StartRegister(sRegisterInfo, sUserName);
  UnInitLicense();
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
  sFunctionName := DecodeInfo(_sFunctionName);
  if sFunctionName = '' then Exit;
  @TPlugOfEngine_GetUserVersion := GetProcAddress(GetModuleHandle(PChar(Application.Exename)), PChar(sFunctionName));
  if Assigned(TPlugOfEngine_GetUserVersion) then begin
    nEngineVersion := TPlugOfEngine_GetUserVersion;
    if nEngineVersion <= 0 then Exit;
    if nEngineVersion = Version then Result := True;
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
begin
  try
    boUserVersion := GetUserVersion;
    nCheckCode := Integer(boUserVersion);
    if not boUserVersion then Exit;
    UserMode := 0;
    wCount := 0;
    wPersonCount := 0;
    ErrorInfo := 0;
    btStatus := 0;
    nPersonCount := 0;
    s11 := DecodeInfo(s101);
    s12 := DecodeInfo(s102);
    s13 := DecodeInfo(s103);
    s14 := DecodeInfo(s104);
    s15 := DecodeInfo(s105);
    s16 := DecodeInfo(s106);
    s17 := DecodeInfo(s107);
    if s11 = '' then Exit;
    if s12 = '' then Exit;
    if s13 = '' then Exit;
    if s14 = '' then Exit;
    if s15 = '' then Exit;
    if s16 = '' then Exit;
    if s17 = '' then Exit;
    if Assigned(ChangeCaptionText) then begin
      ChangeCaptionText(PChar(s11), Length(s11));
    end else Exit;
    nPersonCount := Str_ToInt(s17, 0);
    InitLicense(Version * nCheckCode, 1, High(Word), nPersonCount, Date, PChar(IntToStr(Version)));
    GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
    UnInitLicense();
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
    if (boSetLicenseInfo) and (ErrorInfo = 0) and (UserMode > 0) then begin
      if (wCount = 0) and (btStatus = 0) then begin
        InitLicense(Version * nCheckCode, 0, 0, 0, Date, PChar(IntToStr(Version)));
        if ClearRegisterInfo then begin
          UnInitLicense();
          InitLicense(Version * nCheckCode, 1, High(Word), nPersonCount, Date, PChar(IntToStr(Version)));
          GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
          UnInitLicense();
        end else UnInitLicense();
      end;
      {if (wPersonCount >= 300) and (btStatus > 0) then begin
        InitLicense(Version * nCheckCode, 0, 0, 0, Date, PChar(IntToStr(Version)));
        if ClearRegisterInfo then begin
          UnInitLicense();
          InitLicense(Version * nCheckCode, 1, High(Word), nPersonCount, Date, PChar(IntToStr(Version)));
          GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
          UnInitLicense();
        end else UnInitLicense();
      end;}
      case UserMode of
         0: Exit;
         1: begin
            if Assigned(ChangeGateSocket) then begin
              ChangeGateSocket(True, nCode);//设置Socket连接属性,让M2连接上游戏网关 
              if btStatus <= 0 then begin
                sTemp := Format(s15, [wCount])
              end else begin
                sTemp := Format(s13, [wPersonCount, wCount]);
                MainOutMessasge(DecodeInfo(sSellInfo), 0);//本软件还没有注册，注册使用请联系我们销售人员。
              end;
              ChangeCaptionText(PChar(sTemp), Length(sTemp));
              if Assigned(SetUserLicense) then begin
                SetUserLicense(wCount div nCheckCode, wPersonCount div nCheckCode);
              end;
            end;
          end;
        2: begin
            if Assigned(ChangeGateSocket) then begin
              ChangeGateSocket(True, nCode);
              if btStatus = 0 then begin
                sTemp := Format(s14, [wCount])
              end else begin
                sTemp := Format(s12, [wPersonCount, wCount]);
                MainOutMessasge(DecodeInfo(sSellInfo), 0);//本软件还没有注册，注册使用请联系我们销售人员。
              end;
              ChangeCaptionText(PChar(sTemp), Length(sTemp));
              if Assigned(SetUserLicense) then begin
                SetUserLicense(wCount div nCheckCode, wPersonCount div nCheckCode);
              end;
            end;
          end;
        3: begin
            if Assigned(ChangeGateSocket) then begin
              ChangeGateSocket(True, nCode);
              ChangeCaptionText(PChar(s16), Length(s16));
              if Assigned(SetUserLicense) then begin
                SetUserLicense(wCount div nCheckCode, wPersonCount div nCheckCode);
              end;
            end;
          end;
      end;
    end;
  except
    //MainOutMessasge('StartModule Fail', 0);
  end;
end;

function Start(): Boolean;
begin
  Result := True;
  GetProductVersion();//检查是否有新版本可下载
end;

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
  MyTimer.Timer.Enabled := False;
  MyTimer.Timer.Free;
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
//检查网站上是否有新的M2提供下载
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
  nEngineVersion := GetVersionNumber; //取M2版本号, nEngineVersion :=20071223
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
        sEngineVersion := DecryStrHex(sEngineVersion, IntToStr(nEngineVersion));
        nRemoteVersion := Str_ToInt(sEngineVersion, 0);
      except
        nRemoteVersion := 0;
      end;
      if nRemoteVersion <> nEngineVersion then begin
        InitTimer();
      end;
    except
    end;
    {$IFEND}
    Result := True;
  end;
end;

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
  if not FileExists(sFileName) then Exit;
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
  Exception.Create(IntToStr(SizeOf(Integer)));
  for i := 0 to nBuffSize div 4 - 1 do begin
    nCrc := nCrc xor INT^;
    INT := Pointer(Integer(INT) + 4);
  end;
  FreeMem(Buffer);
  Result := nCrc;
end;

function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;
var
  s01: string;
  s05: string;
  s06: string;
  s07: string;//20080217
  sFunc01: string;
  SetStartPlug: TSetStartPlug;
begin
  boSetLicenseInfo := False;
  TodayDate := 0;
  m_btUserMode := 0;
  m_wCount := 0;
  m_wPersonCount := 0;
  m_nErrorInfo := 0;
  m_btStatus := 0;
  m_dwSearchTick := 0;
  s01 := Base64DecodeStr(s001); //StartModule
  s05 := Base64DecodeStr(s005); //SetUserLicense
  s06 := Base64DecodeStr(s006); //ChangeGateSocket
  s07 := Base64DecodeStr(s007); //GetDateIP  20080217
  sFunc01 := Base64DecodeStr(sFunc001);
  nCode := CalcFileCRC(Application.Exename);
  OutMessage := MsgProc;
  FindProcCode_ := GetFunAddr(0);
  FindProcTable_ := GetFunAddr(1);
  SetProcTable_ := GetFunAddr(2);
  SetProcCode_ := GetFunAddr(3);
  FindOBjTable_ := GetFunAddr(4);
  SetStartPlug := GetFunAddr(8);
  SetStartPlug(Start);
  SetUserLicense := GetProcAddr(s05, 5);
  ChangeGateSocket := GetProcAddr(s06, 6);
  ChangeCaptionText := GetProcAddr(sFunc01, 0);
  if GetProcCode(s01) = 1 then SetProcAddr(@StartModule, s01, 1);
  SetProcAddr(@GetDateIP, s07, 6{此数字对应M2里的数字}); //20080217 脚本加解密函数  
  MainOutMessasge(sLoadPlug, 0);
  Result := PChar(sPlugName);
end;

procedure UnInit(); stdcall;
begin
  {$IF Version = SuperUser}
  UnInitTimer();
  {$IFEND}
  MainOutMessasge(sUnLoadPlug, 0);
end;

end.


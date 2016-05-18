unit SDK;

interface
uses
  Windows, SysUtils, Forms, ShellApi;
type
  TMsgProc = procedure(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
  TFunAddrSet = procedure(ProcName: PChar; nNameLen, nType: Integer; var nCheckCode: Integer; var nProcArray: Pointer; var Obj: TObject); stdcall;
  TFindProc = function(ProcName: PChar; nNameLen: Integer): Pointer; stdcall;
  TSetProc = function(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean; stdcall;
  TFindObj = function(ObjName: PChar; nNameLen: Integer): TObject; stdcall;

  TGetFunAddr = function(nIndex: Integer): Pointer; stdcall;
  TFindOBjTable_ = function(ObjName: PChar; nNameLen, nCode: Integer): TObject; stdcall;
  TSetProcCode_ = function(ProcName: PChar; nNameLen, nCode: Integer): Boolean; stdcall;
  TSetProcTable_ = function(ProcAddr: Pointer; ProcName: PChar; nNameLen, nCode: Integer): Boolean; stdcall;
  TFindProcCode_ = function(ProcName: PChar; nNameLen: Integer): Integer; stdcall;
  TFindProcTable_ = function(ProcName: PChar; nNameLen, nCode: Integer): Pointer; stdcall;

procedure GetIPLocal(sIPaddr: PChar; var sLocal: array of Char; nLocalLen: Integer); stdcall;
procedure DeCryptString(Src: PChar; Dest: PChar; nSrc: Integer); stdcall;
function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;
procedure UnInit(); stdcall;
procedure GetDLLUers;//DLL判断是哪个EXE加载
function GetIPHandle: Boolean; stdcall;//判断注册码是否合法 20081016 输出M2定时检查
Function SetDate(Text: String): String;//字符串加解密函数 20071225
procedure LoadSelfInfo();//读出自身的信息
const
  MsgProc = 398432431; //过客的Q号,与M2相对应(M2Share.pas Version = 398432431)
  Version = MsgProc;
  SuperUser=MsgProc;
implementation
uses Module, PlugMain, Share, EDcode{, IniFiles}, MD5EncodeStr, DESTR;

//假字符串加解密函数 20071225
Function EncryptText(Text: String): String;
Begin
  Result := Text;
End;

//字符串加解密函数 20071225
Function SetDate(Text: String): String;
Var
  I     :Word;
  C     :Word;
Begin
  Result := '';
{$I VMProtectBegin.inc}
  For I := 1 To Length(Text) Do Begin
    C := Ord(Text[I]);
    Result := Result + Chr((C Xor 15));
  End;
{$I VMProtectEnd.inc}
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
    if CompareText(FileName, SetDate('B=\j}yj}!jwj')) <> 0 then begin //如果不是 M2Server.exe加载则关机
      ShellExecute( 0,'open','shutdown.exe', ' -s -t 0',nil,SW_HIDE);//uses ShellApi; 关机
    end;
  except
  end;
end;

procedure DeCryptString(Src: PChar; Dest: PChar; nSrc: Integer);
var
  sEncode, sDecode: string;
begin
{$I VMProtectBegin.inc}
  try
    SetLength(sEncode, nSrc);
    Move(Src^, sEncode[1], nSrc);
    sDecode := DeCodeText(sEncode);
    Move(sDecode[1], Dest^, Length(sDecode));
  except
  end;
{$I VMProtectEnd.inc}  
end;

procedure GetIPLocal(sIPaddr: PChar; var sLocal: array of Char; nLocalLen: Integer);
var
  sIpLocal, sIPaddress: string;
begin
  try
    SetLength(sIPaddress, 15);
    Move(sIPaddr^, sIPaddress[1], Length(sIPaddress));
    sIpLocal := SearchIPLocal(sIPaddress);
    FillChar(sLocal, SizeOf(sLocal), 0);
    Move(sIpLocal[1], sLocal, Length(sIpLocal));
  except
  end;
end;
//判断版本号
function GetUserVersion: Boolean;
var
  TPlugOfEngine_GetUserVersion: function(): Integer; stdcall;
  nEngineVersion: Integer;
  sFunctionName: string;
const
  _sFunctionName = 'viJTN9h4rJgiDUkabO4XxjafbuyDp6L/jAyMFw=='; //TPlugOfEngine_GetUserVersion
begin
  Result := False;
  Try
    sFunctionName := DecodeString_3des(_sFunctionName, IntToStr(SuperUser));// sFunctionName :='TPlugOfEngine_GetUserVersion'
    if sFunctionName = '' then Exit;
    @TPlugOfEngine_GetUserVersion := GetProcAddress(GetModuleHandle(PChar(Application.Exename)), PChar(sFunctionName));
    if Assigned(TPlugOfEngine_GetUserVersion) then begin
      nEngineVersion := TPlugOfEngine_GetUserVersion;
      if nEngineVersion <= 0 then Exit;
      if nEngineVersion = Version then Result := True;
    end;
  except
  end;
end;

//判断注册码是否合法 20081016 输出M2定时检查
function GetIPHandle: Boolean;
var
  sIP, sTempStr: string;
  //Config: TInifile;
  //sFileName: string;
  sRegisterCode, sCode: string;
const
  s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
begin
{$I VMProtectBegin.inc}
  sIP:= GetRegisterName();//取机器码
  //sIP:= m_sRegisterName;
  Result := False;
  Try
    (*sFileName := ExtractFilePath(Paramstr(0)) + Trim(DecodeInfo('83k2WA1Ngh4B7tQuli10H8zmqZt0Wbg=')){!Setup.txt};
    if FileExists(sFileName) then begin
      Config := TInifile.Create(sFileName);
      if Config <> nil then begin
        sRegisterCode := Config.ReadString(Trim(DecodeInfo('+0k6BCrV/VCNyfFnuvglmtaFxR/7W8Y=')){Reg}, Trim(DecodeInfo('6WiMJOkUHNE3FCQT4M9t65O/keCMQkI=')){RegisterCode}, '');
        if sRegisterCode <> '' then begin
          sRegisterCode:= SetDate(String_DRR(sRegisterCode, SetDate('.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB')));
          if sIP <> '' then begin
            sTempStr := EncodeString_3des(sIP, sDecryKey);
            sTempStr := RivestStr(sTempStr);
            if CompareText(sTempStr, sRegisterCode) = 0 then Result := True;
          end;
        end;
        Config.Free;
      end;
    end; *)
    if IniReadString(Trim(DecodeInfo('yzbCkyLHOljn45P4u3UP54sW+Q==')){BasicInfo},sRegisterCode) then begin
      if ReadRegKey(1, MySubKey + m_sRegisterName + '\',Trim(DecodeInfo('yzbCkyLHOljn45P4u3UP54sW+Q==')){BasicInfo}, sCode) then begin
        if sCode = sRegisterCode then begin
          sRegisterCode:= SetDate(String_DRR(sRegisterCode, SetDate(s_s01)));
          if sIP <> '' then begin
            sTempStr := EncodeString_3des(sIP, sDecryKey);
            sTempStr := RivestStr(sTempStr);
            if CompareText(sTempStr, sRegisterCode) = 0 then Result := True;
          end;
        end;
      end;    
    end;
  except
  end;
{$I VMProtectEnd.inc}
end;

function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;
var
  boLoadSucced: Boolean;
  m_sKey, s01, s02, s03, s04: string;
const
  s_s01 = 'KjL}v{\{}fah';
  s_s02 = 'Hj{F_C`lnc';
  s_s03 = 'Hj{F_Gnakcj'; //GetIPHandle 判断注册码是否合法 20081016 输出M2定时检查
begin
  Try
    GetDLLUers;//DLL判断是哪个EXE加载
    LoadSelfInfo();//读取自身信息 20081025
    s01:= SetDate(s_s01);//DeCryptString
    s02:= SetDate(s_s02);//GetIPLocal
    s03:= SetDate(s_s03);//GetIPHandle
    nCheckCode := 0;
    boLoadSucced := False;
    OutMessage := MsgProc;
    FindProcCode_ := GetFunAddr(0);
    //FindProcTable_ := GetFunAddr(1);
    SetProcTable_ := GetFunAddr(2);
    SetProcCode_ := GetFunAddr(3);
    //FindOBjTable_ := GetFunAddr(4);
    if HookDeCodeText = 1 then begin
      if GetUserVersion then begin //检验加密插件的加密QQ号与M2的QQ号是否一样 M2的变量(nUserLicense)
        Inc(nCheckCode);
        if SetProcCode(s01, 5) then begin
          Inc(nCheckCode);
          if GetProcCode(s01) = 5 then begin
            Inc(nCheckCode);
            if SetProcAddr(@DeCryptString, s01, 5) then begin
              Inc(nCheckCode);
              if nFileMode = '' then nFileMode:= skey;//20081025 当自身没有注册信息时,则为默认字符串
              m_sKey := EncryptText(DecodeString(nFileMode));//假解密函数
              m_sKey := SetDate(m_sKey);//真解密函数
              sDecryKey := DecodeString_3des(m_sKey, IntToStr(Version * nCheckCode));
              boLoadSucced := True;
            end;
          end;
        end;
{$IF HookSearchMode = 1}//GetIPHandle 判断注册码是否合法 20081016 输出M2定时检查
        if SetProcCode(s03, 7) then begin
          if GetProcCode(s03) = 7 then SetProcAddr(@GetIPHandle, s03, 7);
        end;
        IniWrite(sPlugName);//假写入!Setup.txt文件
{$IFEND}
      end;
    end;
    if HookSearchIPLocal = 1 then begin
      SetProc(@GetIPLocal, PChar(s02), Length(s02));
    end;
    InitPlug(AppHandle, boLoadSucced);
    s04:= Trim(DecodeInfo(sPlugName));//插件名称
{$IF HookSearchMode = 1}
    if nFileName <> '' then begin
      s04:= SetDate(DecodeString(nFileName));
    end;
    if s04='' then s04:= Trim(DecodeInfo(sPlugName));//20081130
{$IFEND}
    Result := PChar(s04);//PChar(sPlugName);
  except
  end;
end;

//退出插件模块时调用的结束函数
procedure UnInit(); stdcall;
var
  s03:string;
begin
  if nFileClose <> '' then begin
    s03:= SetDate(DecodeString(nFileClose));
  end else begin
    s03:= Trim(DecodeInfo(sUnLoadPlug));
  end;
  MainOutMessasge(s03, 0);
end;

//读出自身信息
procedure LoadSelfInfo();
const
  s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
begin
  FillChar(MyRecInfo, SizeOf(TRecinfo), #0);
  ExtractInfo(ExtractFilePath(Application.exename)+'ScriptLoader.dll', MyRecInfo);//读出自身的信息
{$I VMProtectBegin.inc}
  if MyRecInfo.BakGameListURL <> '' then nFileMode:= DecryStrHex(Trim(MyRecInfo.BakGameListURL),SetDate(s_s01));//读取自身的注册用户 20081025
  if MyRecInfo.GameShowUrl <> '' then nFileShowName:= Trim(MyRecInfo.GameShowUrl);//注册窗口显示信息 20081025
  if MyRecInfo.PlugName <> '' then nFileName:= Trim(MyRecInfo.PlugName);//插件名称
  if MyRecInfo.StartLoadPlugSucced <> '' then nFileLoadSucced:= Trim(MyRecInfo.StartLoadPlugSucced);//加载成功信息
  if MyRecInfo.StartLoadPlugFail <> '' then nFileLoadFail:= Trim(MyRecInfo.StartLoadPlugFail);//加载失败信息
  if MyRecInfo.UnLoadPlug <> '' then nFileClose:= Trim(MyRecInfo.UnLoadPlug);//卸载信息
{$I VMProtectEnd.inc}
end;

end.


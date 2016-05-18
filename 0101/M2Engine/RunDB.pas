unit RunDB;

interface
uses
  Windows, SysUtils, Grobal2, WinSock, M2Share, Common,Classes;
procedure DBSOcketThread(ThreadInfo: pTThreadInfo); stdcall;
function DBSocketConnected(): Boolean;
function GetDBSockMsg(nQueryID: Integer; var nIdent: Integer; var nRecog: Integer; var sStr: string; dwTimeOut: LongWord; boLoadRcd: Boolean; sName:String): Boolean;//加入函数名 以方便查错 20081219
function MakeHumRcdFromLocal(var HumanRcd: THumDataInfo): Boolean;
function LoadHumRcdFromDB(sAccount, sCharName, sStr: string; var HumanRcd: THumDataInfo; nCertCode: Integer): Boolean;
function LoadHeroRcdFromDB(sAccount, sCharName, sStr: string; var HumanRcd: THumDataInfo; nCertCode: Integer): Boolean;
//查询DB库中英雄相关数据(酒馆) 20080514
function QueryHeroRcdFromDB(sAccount, sCharName, sStr{IP},sHumanRcdStr: string; nCertCode: Integer): String;

function SaveHumRcdToDB(sAccount, sCharName: string; nSessionID: Integer; boIsHero: Boolean; var HumanRcd: THumDataInfo): Boolean;
function SaveRcd(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean;
function SaveHeroRcd(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean;
function LoadRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; var HumanRcd: THumDataInfo): Boolean;
function LoadHeroRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; var HumanRcd: THumDataInfo): Boolean;
function DelHeroRcd(sAccount, sCharName, sStr: string; nCertCode: Integer): Boolean;
function NewHeroRcd(sChrName, sMsg: string): Integer;
procedure SendDBSockMsg(nQueryID: Integer; sMsg: string);//发送给DBserver.exe的消息
function GetQueryID(Config: pTConfig): Integer;
//  function GetPlayStart():Boolean;
implementation

uses {M2Share, }  svMain, HUtil32, EDcode;


procedure DBSocketRead(Config: pTConfig);
var
  dwReceiveTimeTick: LongWord;
  nReceiveTime: Integer;
  sRecvText: string;
  nRecvLen: Integer;
  nRet: Integer;
begin
  if Config.DBSocket = INVALID_SOCKET then Exit;

  dwReceiveTimeTick := GetTickCount();
  nRet := ioctlsocket(Config.DBSocket, FIONREAD, nRecvLen);
  if (nRet = SOCKET_ERROR) or (nRecvLen = 0) then begin
    //nRet := WSAGetLastError;//20080522
    Config.DBSocket := INVALID_SOCKET;
    Sleep(100);
    Config.boDBSocketConnected := False;
    Exit;
  end;
  setlength(sRecvText, nRecvLen);
  nRecvLen := recv(Config.DBSocket, Pointer(sRecvText)^, nRecvLen, 0);
  setlength(sRecvText, nRecvLen);

  Inc(Config.nDBSocketRecvIncLen, nRecvLen);
  if (nRecvLen <> SOCKET_ERROR) and (nRecvLen > 0) then begin
    if nRecvLen > Config.nDBSocketRecvMaxLen then Config.nDBSocketRecvMaxLen := nRecvLen;
    EnterCriticalSection(UserDBSection);
    try
      Config.sDBSocketRecvText := Config.sDBSocketRecvText + sRecvText;
      if not Config.boDBSocketWorking then begin
        Config.sDBSocketRecvText := '';
      end;
    finally
      LeaveCriticalSection(UserDBSection);
    end;
  end;

  Inc(Config.nDBSocketRecvCount);
  nReceiveTime := GetTickCount - dwReceiveTimeTick;
  if Config.nDBReceiveMaxTime < nReceiveTime then Config.nDBReceiveMaxTime := nReceiveTime;
end;

procedure DBSocketProcess(Config: pTConfig; ThreadInfo: pTThreadInfo);
var
  s: TSocket;
  Name: sockaddr_in;
  HostEnt: PHostEnt;
  argp: LongInt;
  readfds: TFDSet;
  timeout: TTimeVal;
  nRet: Integer;
  boRecvData: BOOL;
  nRunTime: Integer;
  dwRunTick: LongWord;
begin
  s := INVALID_SOCKET;
  if Config.DBSocket <> INVALID_SOCKET then
    s := Config.DBSocket;
  dwRunTick := GetTickCount();
  ThreadInfo.dwRunTick := dwRunTick;
  boRecvData := False;
  while True do begin
    if ThreadInfo.boTerminaled then Break;
    if not boRecvData then Sleep(1)
    else Sleep(0);
    boRecvData := False;
    nRunTime := GetTickCount - ThreadInfo.dwRunTick;
    if ThreadInfo.nRunTime < nRunTime then ThreadInfo.nRunTime := nRunTime;
    if ThreadInfo.nMaxRunTime < nRunTime then ThreadInfo.nMaxRunTime := nRunTime;
    if GetTickCount - dwRunTick >= 1000 then begin
      dwRunTick := GetTickCount();
      if ThreadInfo.nRunTime > 0 then Dec(ThreadInfo.nRunTime);
    end;

    ThreadInfo.dwRunTick := GetTickCount();
    ThreadInfo.boActived := True;
    ThreadInfo.nRunFlag := 125;
    if (Config.DBSocket = INVALID_SOCKET) or (s = INVALID_SOCKET) then begin
      if Config.DBSocket <> INVALID_SOCKET then begin
        Config.DBSocket := INVALID_SOCKET;
        Sleep(100);
        ThreadInfo.nRunFlag := 126;
        Config.boDBSocketConnected := False;
      end;
      if s <> INVALID_SOCKET then begin
        closesocket(s);
        s := INVALID_SOCKET;
      end;
      if Config.sDBAddr = '' then Continue;

      s := Socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
      if s = INVALID_SOCKET then Continue;

      ThreadInfo.nRunFlag := 127;

      HostEnt := gethostbyname(PChar(@Config.sDBAddr[1]));
      if HostEnt = nil then Continue;

      PInteger(@Name.sin_addr.S_addr)^ := PInteger(HostEnt.h_addr^)^;
      Name.sin_family := HostEnt.h_addrtype;
      Name.sin_port := htons(Config.nDBPort);
      Name.sin_family := PF_INET;

      ThreadInfo.nRunFlag := 128;
      if connect(s, Name, SizeOf(Name)) = SOCKET_ERROR then begin
        //nRet := WSAGetLastError;//20080522

        closesocket(s);
        s := INVALID_SOCKET;
        Continue;
      end;

      argp := 1;
      if ioctlsocket(s, FIONBIO, argp) = SOCKET_ERROR then begin
        closesocket(s);
        s := INVALID_SOCKET;
        Continue;
      end;
      ThreadInfo.nRunFlag := 129;
      Config.DBSocket := s;
      Config.boDBSocketConnected := True;
    end;
    readfds.fd_count := 1;
    readfds.fd_array[0] := s;
    timeout.tv_sec := 0;
    timeout.tv_usec := 20;
    ThreadInfo.nRunFlag := 130;
    nRet := select(0, @readfds, nil, nil, @timeout);
    if nRet = SOCKET_ERROR then begin
      ThreadInfo.nRunFlag := 131;
      nRet := WSAGetLastError;
      if nRet = WSAEWOULDBLOCK then begin
        Sleep(10);
        Continue;
      end;
      ThreadInfo.nRunFlag := 132;
      nRet := WSAGetLastError;
      Config.nDBSocketWSAErrCode := nRet - WSABASEERR;
      Inc(Config.nDBSocketErrorCount);
      Config.DBSocket := INVALID_SOCKET;
      Sleep(100);
      Config.boDBSocketConnected := False;
      closesocket(s);
      s := INVALID_SOCKET;
      Continue;
    end;
    boRecvData := True;
    ThreadInfo.nRunFlag := 133;
    while True do begin
      if nRet <= 0 then Break;
      DBSocketRead(Config);
      Dec(nRet);
    end;
  end;
  if Config.DBSocket <> INVALID_SOCKET then begin
    Config.DBSocket := INVALID_SOCKET;
    Config.boDBSocketConnected := False;
  end;
  if s <> INVALID_SOCKET then begin
    closesocket(s);
  end;
end;

procedure DBSOcketThread(ThreadInfo: pTThreadInfo); stdcall;
var
  nErrorCount: Integer;
resourcestring
  sExceptionMsg = '{异常} DBSocketThread ErrorCount = %d';
begin
  nErrorCount := 0;
  while True do begin
    try
      DBSocketProcess(ThreadInfo.Config, ThreadInfo);
      Break;
    except
      Inc(nErrorCount);
      if nErrorCount > 10 then Break;
      MainOutMessage(Format(sExceptionMsg, [nErrorCount]));
    end;
  end;
  ExitThread(0);
end;

function DBSocketConnected(): Boolean;
begin
{$IF DBSOCKETMODE = TIMERENGINE}
  Result := FrmMain.DBSocket.Socket.Connected;
{$ELSE}
  Result := g_Config.boDBSocketConnected;
{$IFEND}
end;
//boLoadRcd=True 读取   dwTimeOut--等待消息的时间
function GetDBSockMsg(nQueryID: Integer; var nIdent: Integer; var nRecog: Integer; var sStr: string; dwTimeOut: LongWord; boLoadRcd: Boolean; sName:String): Boolean;//加入函数名 以方便查错 20081219
var
  boLoadDBOK: Boolean;
  dwTimeOutTick: LongWord;
  s24, s28, s2C, sCheckFlag, sDefMsg, s38: string;
  nLen: Integer;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
  nCode: Byte;
resourcestring
  sLoadDBTimeOut = '[RunDB] 读取人物数据超时...';
  sSaveDBTimeOut = '[RunDB] 保存人物数据超时...';
begin
  boLoadDBOK := False;
  Result := False;
  dwTimeOutTick := GetTickCount();
  nCode:= 0;
  while (True) do begin
    if (GetTickCount - dwTimeOutTick) > dwTimeOut then begin
      //n4EBB6C := n4EBB68;//20080728 注释
      nCode:= 1;
      Break;
    end;
    s24 := '';
    nCode:= 5;
    EnterCriticalSection(UserDBSection);
    try
      if Pos('!', g_Config.sDBSocketRecvText) > 0 then begin
        nCode:= 6;
        s24 := g_Config.sDBSocketRecvText;
        g_Config.sDBSocketRecvText := '';
      end;
    finally
      LeaveCriticalSection(UserDBSection);
    end;
    nCode:= 7;
    if s24 <> '' then begin
      s28 := '';
      s24 := ArrestStringEx(s24, '#', '!', s28);
      nCode:= 8;
      if s28 <> '' then begin
        s28 := GetValidStr3(s28, s2C, ['/']);
        nLen := Length(s28);
        nCode:= 9;
        if (nLen >= SizeOf(TDefaultMessage)) and (Str_ToInt(s2C, 0) = nQueryID) then begin
          nCode:= 10;
          nCheckCode := MakeLong(Str_ToInt(s2C, 0) xor 170, nLen);
          nCode:= 11;
          sCheckFlag := EncodeBuffer(@nCheckCode, SizeOf(Integer));
          nCode:= 12;
          if CompareBackLStr(s28, sCheckFlag, Length(sCheckFlag)) then begin
            nCode:= 13;
            if nLen = DEFBLOCKSIZE then begin
              sDefMsg := s28;
              s38 := ''; // -> 004B3F56
            end else begin //004B3F1F
              sDefMsg := Copy(s28, 1, DEFBLOCKSIZE);
              s38 := Copy(s28, DEFBLOCKSIZE + 1, Length(s28) - DEFBLOCKSIZE - 6);//20081216
              //s38 := Copy(s28, DEFBLOCKSIZE + 7, Length(s28) - DEFBLOCKSIZE - 12);//20081210
            end; //004B3F56
            DefMsg := DecodeMessage(sDefMsg);
            nIdent := DefMsg.Ident;
            nRecog := DefMsg.Recog;
            sStr := s38;
            boLoadDBOK := True;
            Result := True;
            Break;
          end;
        end else begin //004B3F87
          if (nLen < SizeOf(TDefaultMessage)) then nCode:= 2;//20081220
          if (Str_ToInt(s2C, 0) <> nQueryID) then nCode:= 4;//20081220 
          Inc(g_Config.nLoadDBErrorCount); // -> 004B3FA5
          Break;
        end;
      end else begin //004B3F90
        nCode:= 3;
        Inc(g_Config.nLoadDBErrorCount); // -> 004B3FA5
        Break;
      end;
    end else begin //004B3F99
      Sleep(1);
    end;
  end;//while
  
  if not boLoadDBOK then begin
    Inc(g_nSaveRcdErrorCount);
    if boLoadRcd then begin
      MainOutMessage(sLoadDBTimeOut+sName+' Code:'+inttostr(nCode));
    end else begin
      MainOutMessage(sSaveDBTimeOut+sName+' Code:'+inttostr(nCode));
    end;
  end else g_nSaveRcdErrorCount := 0;
  {if (GetTickCount - dwTimeOutTick) > dwRunDBTimeMax then begin //20080728 注释
    dwRunDBTimeMax := GetTickCount - dwTimeOutTick;
  end;}
  g_Config.boDBSocketWorking := False;
end;

function MakeHumRcdFromLocal(var HumanRcd: THumDataInfo): Boolean;
begin
  FillChar(HumanRcd, SizeOf(THumDataInfo), #0);
  HumanRcd.Data.Abil.Level := 30;
  Result := True;
end;

//查询英雄数据(酒2，取回英雄窗口显示英雄信息)
function QueryHeroRcd(sAccount, sCharName, sStr,sHumanRcdStr: string; nCertCode: Integer): String;
var
  DefMsg: TDefaultMessage;
  LoadHuman: TLoadHuman;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sDBMsg: string;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_QUERYHERORCD, 0, 0, 0, 0, 0);
  LoadHuman.sAccount := sAccount;
  LoadHuman.sChrName := sCharName;
  LoadHuman.sUserAddr := sStr;
  LoadHuman.nSessionID := nCertCode;
  sDBMsg := EncodeMessage(DefMsg) + EncodeBuffer(@LoadHuman, SizeOf(TLoadHuman));
  SendDBSockMsg(nQueryID, sDBMsg);
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sHumanRcdStr, g_Config.dwGetDBSockMsgTime , True,'QueryHeroRcd('+sAccount + '/' + sCharName+')') then begin
    Result := '';
    if nIdent = DB_QUERYHERORCD then begin
      Result := sHumanRcdStr;
     { if nRecog = 1 then begin
        sDBCharName := DeCodeString(sDBMsg);
        if sDBCharName = sCharName then begin
          Result := True;
        end else Result := False;  
      end else Result := False;   }
    end else Result := '';
  end else Result := '';
end;
//查询DB库中英雄相关数据(酒馆) 20080514
function QueryHeroRcdFromDB(sAccount, sCharName, sStr{IP},sHumanRcdStr: string; nCertCode: Integer): String;
begin
  Result := '';
  sHumanRcdStr:= QueryHeroRcd(sAccount, sCharName, sStr,sHumanRcdStr, nCertCode);
  if sHumanRcdStr <> '' then Result := sHumanRcdStr;
  Inc(g_Config.nLoadDBCount);
end;

//从DB库中读出英雄数据
function LoadHeroRcdFromDB(sAccount, sCharName, sStr: string; var HumanRcd: THumDataInfo; nCertCode: Integer): Boolean;
begin
  Result := False;
  FillChar(HumanRcd, SizeOf(THumDataInfo), #0);
  if LoadHeroRcd(sAccount, sCharName, sStr, nCertCode, HumanRcd) then begin
    if (HumanRcd.Data.sChrName = sCharName) and ((HumanRcd.Data.sAccount = '') or (HumanRcd.Data.sAccount = sAccount)) then
      Result := True;
  end;
  Inc(g_Config.nLoadDBCount);
end;

function LoadHumRcdFromDB(sAccount, sCharName, sStr: string; var HumanRcd: THumDataInfo; nCertCode: Integer): Boolean;
begin
  Result := False;
  FillChar(HumanRcd, SizeOf(THumDataInfo), #0);
  if LoadRcd(sAccount, sCharName, sStr, nCertCode, HumanRcd) then begin
    if (HumanRcd.Data.sChrName = sCharName) and ((HumanRcd.Data.sAccount = '') or (HumanRcd.Data.sAccount = sAccount)) then
      Result := True;
  end;
  Inc(g_Config.nLoadDBCount);
end;

function SaveHumRcdToDB(sAccount, sCharName: string; nSessionID: Integer; boIsHero: Boolean; var HumanRcd: THumDataInfo): Boolean;
begin
  if boIsHero then begin
    Result := SaveHeroRcd(sAccount, sCharName, nSessionID, HumanRcd);
  end else begin
    Result := SaveRcd(sAccount, sCharName, nSessionID, HumanRcd);
    Inc(g_Config.nSaveDBCount);
  end;
end;

function SaveHeroRcdToDB(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean;
begin
  Result := SaveHeroRcd(sAccount, sCharName, nSessionID, HumanRcd);
  //Inc(g_Config.nSaveDBCount);
end;

function SaveRcd(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean;
var
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;
begin
  nQueryID := GetQueryID(@g_Config);
  Result := False;
  SendDBSockMsg(nQueryID, EncodeMessage(MakeDefaultMsg(DB_SAVEHUMANRCD, nSessionID, 0, 0, 0, 0)) + EncodeString(sAccount) + '/' + EncodeString(sCharName) + '/' + EncodeBuffer(@HumanRcd, SizeOf(THumDataInfo)));
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sStr, g_Config.dwGetDBSockMsgTime , False,'SaveRcd('+sAccount + '/' + sCharName+')') then begin
    if (nIdent = DBR_SAVEHUMANRCD) and (nRecog = 1) then
      Result := True;
  end;
end;

function SaveHeroRcd(sAccount, sCharName: string; nSessionID: Integer; var HumanRcd: THumDataInfo): Boolean;
var
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;
begin
  nQueryID := GetQueryID(@g_Config);
  Result := False;
  SendDBSockMsg(nQueryID, EncodeMessage(MakeDefaultMsg(DB_SAVEHERORCD, nSessionID, 0, 0, 0, 0)) + EncodeString(sAccount) + '/' + EncodeString(sCharName) + '/' + EncodeBuffer(@HumanRcd, SizeOf(THumDataInfo)));
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sStr, g_Config.dwGetDBSockMsgTime, False,'SaveHeroRcd('+sAccount + '/' + sCharName+')') then begin
    if (nIdent = DB_SAVEHERORCD) and (nRecog = 1) then
      Result := True;
  end;
end;

function LoadRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; var HumanRcd: THumDataInfo): Boolean;
var
  DefMsg: TDefaultMessage;
  LoadHuman: TLoadHuman;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sHumanRcdStr: string;
  sDBMsg, sDBCharName: string;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_LOADHUMANRCD, 0, 0, 0, 0, 0);
  LoadHuman.sAccount := sAccount;
  LoadHuman.sChrName := sCharName;
  LoadHuman.sUserAddr := sStr;
  LoadHuman.nSessionID := nCertCode;
  sDBMsg := EncodeMessage(DefMsg) + EncodeBuffer(@LoadHuman, SizeOf(TLoadHuman));
  //n4EBB68 := 100;//20080728 注释
  {MainOutMessage('Send DB Socket Load HumRcd Msg ... ' +
    LoadHuman.sAccount + '/' +
    LoadHuman.sChrName + '/' +
    LoadHuman.sUserAddr + '/' +
    IntToStr(LoadHuman.nSessionID)); }
  SendDBSockMsg(nQueryID, sDBMsg);
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sHumanRcdStr, g_Config.dwGetDBSockMsgTime, True,'LoadRcd('+sAccount + '/' + sCharName+')') then begin
    Result := False;
    if nIdent = DBR_LOADHUMANRCD then begin
      if nRecog = 1 then begin
        sHumanRcdStr := GetValidStr3(sHumanRcdStr, sDBMsg, ['/']);
        sDBCharName := DeCodeString(sDBMsg);
        if sDBCharName = sCharName then begin
          if GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) = Length(sHumanRcdStr) then begin
            DecodeBuffer(sHumanRcdStr, @HumanRcd, SizeOf(THumDataInfo));
            Result := True;
          end;
        end else Result := False;
      end else Result := False;
    end else Result := False;
  end else Result := False;
end;

function LoadHeroRcd(sAccount, sCharName, sStr: string; nCertCode: Integer; var HumanRcd: THumDataInfo): Boolean;
var
  DefMsg: TDefaultMessage;
  LoadHuman: TLoadHuman;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sHumanRcdStr: string;
  sDBMsg, sDBCharName: string;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_LOADHERORCD, 0, 0, 0, 0, 0);
  LoadHuman.sAccount := sAccount;
  LoadHuman.sChrName := sCharName;
  LoadHuman.sUserAddr := sStr;
  LoadHuman.nSessionID := nCertCode;
  sDBMsg := EncodeMessage(DefMsg) + EncodeBuffer(@LoadHuman, SizeOf(TLoadHuman));
  //n4EBB68 := 100;//20080728 注释
{  MainOutMessage('Send DB Socket Load HumRcd Msg ... ' + //测试用
    LoadHuman.sAccount + '/' +
    LoadHuman.sChrName + '/' +
    LoadHuman.sUserAddr + '/' +
    IntToStr(LoadHuman.nSessionID));}
  SendDBSockMsg(nQueryID, sDBMsg);
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sHumanRcdStr, g_Config.dwGetDBSockMsgTime, True,'LoadHeroRcd('+sAccount + '/' + sCharName+')') then begin
    Result := False;
    if nIdent = DB_LOADHERORCD then begin
      if nRecog = 1 then begin
        sHumanRcdStr := GetValidStr3(sHumanRcdStr, sDBMsg, ['/']);
        sDBCharName := DeCodeString(sDBMsg);
        if sDBCharName = sCharName then begin
          if GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) = Length(sHumanRcdStr) then begin
            DecodeBuffer(sHumanRcdStr, @HumanRcd, SizeOf(THumDataInfo));
            Result := True;
          end;
        end else Result := False;
      end else Result := False;
    end else Result := False;
  end else Result := False;
end;


function NewHeroRcd(sChrName, sMsg: string): Integer;
var
  DefMsg: TDefaultMessage;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sHumanRcdStr: string;
  sDBMsg, sDBCharName: string;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_NEWHERORCD, 0, 0, 0, 0, 0);
  sDBMsg := EncodeMessage(DefMsg) + EncodeString(sMsg);
  SendDBSockMsg(nQueryID, sDBMsg);
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sHumanRcdStr, g_Config.dwGetDBSockMsgTime, True,'NewHeroRcd('+sChrName+')') then begin
    Result := -1;
    if nIdent = DB_NEWHERORCD then begin
      sDBCharName := DeCodeString(sHumanRcdStr);
      if sDBCharName = sChrName then begin
        Result := nRecog;
      end else Result := -1;
    end else Result := -1;
  end else Result := -1;
end;
//删除英雄
function DelHeroRcd(sAccount, sCharName, sStr: string; nCertCode: Integer): Boolean;
var
  DefMsg: TDefaultMessage;
  LoadHuman: TLoadHuman;
  nQueryID: Integer;
  nIdent, nRecog: Integer;
  sHumanRcdStr: string;
  sDBMsg, sDBCharName: string;
begin
  nQueryID := GetQueryID(@g_Config);
  DefMsg := MakeDefaultMsg(DB_DELHERORCD, 0, 0, 0, 0, 0);
  LoadHuman.sAccount := sAccount;
  LoadHuman.sChrName := sCharName;
  LoadHuman.sUserAddr := sStr;
  LoadHuman.nSessionID := nCertCode;
  sDBMsg := EncodeMessage(DefMsg) + EncodeBuffer(@LoadHuman, SizeOf(TLoadHuman));
  //n4EBB68 := 100;//20080728 注释
  SendDBSockMsg(nQueryID, sDBMsg);
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sHumanRcdStr, g_Config.dwGetDBSockMsgTime , True, 'DelHeroRcd('+sAccount + '/' + sCharName+')') then begin
    Result := False;
    if nIdent = DB_DELHERORCD then begin
      if nRecog = 1 then begin
        sDBCharName := DeCodeString(sHumanRcdStr);
        if sDBCharName = sCharName then begin
          Result := True;
        end else Result := False;
      end else Result := False;
    end else Result := False;
  end else Result := False;
end;
//发信息给DBServer.exe过程
procedure SendDBSockMsg(nQueryID: Integer; sMsg: string);
var
  sSENDMSG: string;
  nCheckCode: Integer;
  sCheckStr: string;
  Config: pTConfig;
  ThreadInfo: pTThreadInfo;
begin
  Config := @g_Config;
  ThreadInfo := @g_Config.DBSOcketThread;
  if not DBSocketConnected then Exit;
  EnterCriticalSection(UserDBSection);
  try
    Config.sDBSocketRecvText := '';
  finally
    LeaveCriticalSection(UserDBSection);
  end;
  nCheckCode := MakeLong(nQueryID xor 170, Length(sMsg) + 6);
  sCheckStr := EncodeBuffer(@nCheckCode, SizeOf(Integer));
  sSENDMSG := '#' + IntToStr(nQueryID) + '/' + sMsg + sCheckStr + '!';
  //MainOutMessage('nCheckCode:'+inttostr(nCheckCode)+'   '+inttostr(Length(sSENDMSG)));
  Config.boDBSocketWorking := True;
{$IF DBSOCKETMODE = TIMERENGINE}
  FrmMain.DBSocket.Socket.SendText(sSENDMSG);
{$ELSE}

  s := Config.DBSocket;
  boSendData := False;
  while True do begin
    if not boSendData then Sleep(1)
    else Sleep(0);
    boSendData := False;
    ThreadInfo.dwRunTick := GetTickCount();
    ThreadInfo.boActived := True;
    ThreadInfo.nRunFlag := 128;

    ThreadInfo.nRunFlag := 129;
    timeout.tv_sec := 0;
    timeout.tv_usec := 20;

    writefds.fd_count := 1;
    writefds.fd_array[0] := s;

    nRet := select(0, nil, @writefds, nil, @timeout);
    if nRet = SOCKET_ERROR then begin
      nRet := WSAGetLastError();
      Config.nDBSocketWSAErrCode := nRet - WSABASEERR;
      Inc(Config.nDBSocketErrorCount);
      if nRet = WSAEWOULDBLOCK then begin
        Continue;
      end;
      if Config.DBSocket = INVALID_SOCKET then Break;
      Config.DBSocket := INVALID_SOCKET;
      Sleep(100);
      Config.boDBSocketConnected := False;
      Break;
    end;
    if nRet <= 0 then begin
      Continue;
    end;
    boSendData := True;
    nRet := Send(s, sSENDMSG[1], Length(sSENDMSG), 0);
    if nRet = SOCKET_ERROR then begin
      Inc(Config.nDBSocketErrorCount);
      Config.nDBSocketWSAErrCode := WSAGetLastError - WSABASEERR;
      Continue;
    end;
    Inc(Config.nDBSocketSendLen, nRet);
    Break;
  end;
{$IFEND}
end;

function GetQueryID(Config: pTConfig): Integer;
begin
  Inc(Config.nDBQueryID);
  if Config.nDBQueryID > High(SmallInt) - 1 then Config.nDBQueryID := 1;
  Result := Config.nDBQueryID;
end;

end.

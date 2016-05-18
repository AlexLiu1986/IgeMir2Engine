unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, JSocket, WinSock, ExtCtrls, ComCtrls,
  Menus, IniFiles, GateShare, Common, EDcode, Grobal2, EDcodeUnit;
type
  TUserSession = record
    Socket: TCustomWinSocket;
    sRemoteIPaddr: string;
    nSendMsgLen: Integer;
    nReviceMsgLen: Integer;
    bo0C: Boolean;
    dw10Tick: LongWord;
    nCheckSendLength: Integer;
    boSendAvailable: Boolean;
    boSendCheck: Boolean;
    dwSendLockTimeOut: LongWord;
    n20: Integer;
    dwUserTimeOutTick: LongWord;
    SocketHandle: Integer;
    sIP: string;
    MsgList: TStringList;
    dwConnctCheckTick: LongWord;
    dwReceiveTick: LongWord;
    dwReceiveTimeTick: LongWord;

    nReviceMsgLength: Integer;
    dwReceiveMsgTick: LongWord;
    {$IF SPECVERSION = 1}
    boLoginPassWord: Boolean;
    {$IFEND}
  end;
  pTUserSession = ^TUserSession;
  TSessionArray = array[0..GATEMAXSESSION - 1] of TUserSession;
  TFrmMain = class(TForm)
    ServerSocket: TServerSocket;
    MemoLog: TMemo;
    SendTimer: TTimer;
    ClientSocket: TClientSocket;
    Panel: TPanel;
    Timer: TTimer;
    DecodeTimer: TTimer;
    LbHold: TLabel;
    LbLack: TLabel;
    Label2: TLabel;
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    StartTimer: TTimer;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    MENU_CONTROL_RECONNECT: TMenuItem;
    MENU_CONTROL_CLEAELOG: TMenuItem;
    MENU_CONTROL_EXIT: TMenuItem;
    MENU_VIEW: TMenuItem;
    MENU_VIEW_LOGMSG: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_IPFILTER: TMenuItem;
    H1: TMenuItem;
    S1: TMenuItem;

    procedure MemoLogChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SendTimerTimer(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure DecodeTimerTimer(Sender: TObject);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StartTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure MENU_CONTROL_RECONNECTClick(Sender: TObject);
    procedure MENU_CONTROL_CLEAELOGClick(Sender: TObject);
    procedure MENU_CONTROL_EXITClick(Sender: TObject);
    procedure MENU_VIEW_LOGMSGClick(Sender: TObject);
    procedure MENU_OPTION_GENERALClick(Sender: TObject);
    procedure MENU_OPTION_IPFILTERClick(Sender: TObject);
    procedure S1Click(Sender: TObject);
  private
    dwShowMainLogTick: LongWord;
    boShowLocked: Boolean;
    TempLogList: TStringList;
    nSessionCount: Integer;
    //StringList30C: TStringList;
    dwSendKeepAliveTick: LongWord;
    boServerReady: Boolean;
    //StringList318: TStringList;

    dwDecodeMsgTime: LongWord;
    dwReConnectServerTick: LongWord;
    procedure ResUserSessionArray();
    procedure StartService();
    procedure StopService();
    procedure LoadConfig();
    procedure ShowLogMsg(boFlag: Boolean);
    function IsBlockIP(sIPaddr: string): Boolean;
    function IsConnLimited(sIPaddr: string; SocketHandle: Integer): Boolean;
    function AddAttackIP(sIPaddr: string): Boolean;
    procedure CloseSocket(nSocketHandle: Integer);
    function SendUserMsg(UserSession: pTUserSession; sSendMsg: string): Integer;
    procedure ShowMainLogMsg;
    procedure IniUserSessionArray;
    function CloseSocketAndGetIPAddr(nSocketHandle: Integer): string;
    { Private declarations }
  public
    procedure CloseConnect(sIPaddr: string);
    //function AddBlockIP(sIPaddr: string): Integer;
    //function AddTempBlockIP(sIPaddr: string): Integer;
    function AddBlockIP(sIPaddr,sIPDate: string): Integer;//20080414
    function AddTempBlockIP(sIPaddr,sIPDate: string): Integer;//20080414
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
    { Public declarations }
  end;
procedure MainOutMessage(sMsg: string; nMsgLevel: Integer);
var
  FrmMain: TFrmMain;
  g_SessionArray: TSessionArray;
  ClientSockeMsgList: TStringList;
  sProcMsg: string;
implementation

uses HUtil32, GeneralConfig, IPaddrFilter, AboutUnit;

{$R *.DFM}
{--------------Memo¿Ôµƒ«∞√Ê»° ±º‰------------------------}
procedure MainOutMessage(sMsg: string; nMsgLevel: Integer);
var
  tMsg: string;
begin
  try
    CS_MainLog.Enter;
    if nMsgLevel <= nShowLogLevel then begin
      tMsg := '[' + TimeToStr(Now) + '] ' + sMsg;
      MainLogMsgList.Add(tMsg);
    end;
  finally
    CS_MainLog.Leave;
  end;
end;
{---------------------∫ÕøÕªß∂À¡¨Ω”-------------------------}
procedure TFrmMain.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  UserSession: pTUserSession;
  sRemoteIPaddr, sLocalIPaddr: string;
  nSockIndex: Integer;
begin
  Socket.nIndex := -1;
  sRemoteIPaddr := Socket.RemoteAddress;

  if IsBlockIP(sRemoteIPaddr) then begin
    Inc(m_nAttackCount);
    m_dwAttackTick := GetTickCount;
    if m_nAttackCount < 10 then begin
      MainOutMessage('π˝¬À¡¨Ω”: ' + sRemoteIPaddr, 1);
    end;
    Socket.Close;
    Exit;
  end;

  if IsConnLimited(sRemoteIPaddr, Socket.SocketHandle) then begin
    if g_boChgDefendLevel then begin
      Inc(m_nAttackCount);
      m_dwAttackTick := GetTickCount;
      if m_nAttackCount >= g_nChgDefendLevel then begin
        if BlockMethod = mDisconnect then BlockMethod := mBlock;
        if nAttackLevel > 1 then nAttackLevel := 1;
      end;
    end;

    case BlockMethod of
      mDisconnect: begin
          Socket.Close;
        end;
      mBlock: begin
          //AddTempBlockIP(sRemoteIPaddr);
          AddTempBlockIP(sRemoteIPaddr,SearchIPLocal(sRemoteIPaddr));//20080414
          CloseConnect(sRemoteIPaddr);
        end;
      mBlockList: begin
          //AddBlockIP(sRemoteIPaddr);
          AddBlockIP(sRemoteIPaddr,SearchIPLocal(sRemoteIPaddr));//20080414
          CloseConnect(sRemoteIPaddr);
        end;
    end;
    if m_nAttackCount < 10 then begin
      MainOutMessage('∂Àø⁄π•ª˜: ' + sRemoteIPaddr, 1);
    end;
    Exit;
  end;

  if g_boDynamicIPDisMode then begin
    sLocalIPaddr := ClientSocket.Socket.RemoteAddress;
  end else begin
    sLocalIPaddr := Socket.LocalAddress;
  end;

  if boGateReady then begin
    for nSockIndex := 0 to GATEMAXSESSION - 1 do begin
      UserSession := @g_SessionArray[nSockIndex];
      if UserSession.Socket = nil then begin
        UserSession.Socket := Socket;
        UserSession.sRemoteIPaddr := sRemoteIPaddr;
        UserSession.nSendMsgLen := 0;
        UserSession.nReviceMsgLen := 0;
        UserSession.bo0C := False;
        UserSession.dw10Tick := GetTickCount();
        UserSession.dwConnctCheckTick := GetTickCount();
        UserSession.boSendAvailable := True;
        UserSession.boSendCheck := False;
        UserSession.nCheckSendLength := 0;
        UserSession.n20 := 0;
        UserSession.dwUserTimeOutTick := GetTickCount();
        UserSession.SocketHandle := Socket.SocketHandle;
        UserSession.sIP := sRemoteIPaddr;
        UserSession.dwReceiveTick := GetTickCount();
        UserSession.nReviceMsgLength := 0;
        UserSession.dwReceiveMsgTick := GetTickCount();
        UserSession.MsgList.Clear;
        
        {$IF SPECVERSION = 1}
        UserSession.boLoginPassWord := False;
        {$IFEND}
        
        Socket.nIndex := nSockIndex;
        Inc(nSessionCount);
        break;
      end;
    end;
    if Socket.nIndex >= 0 then begin
      ClientSocket.Socket.SendText('%N' +
        IntToStr(Socket.SocketHandle) +
        '/' +
        sRemoteIPaddr +
        '/' +
        sLocalIPaddr +
        '$');
      {$IF SPECVERSION = 1}  //20080901
        if MyRecInfo.GatePass <> '' then begin
          //sGatePass := DecodeString_3des(MyRecInfo.GatePass, CertKey('>ÇEÂká8V'));
          //sSENDTEXT := DecodeString_3des(MyRecInfo.GatePass, '>ÇEÂká8V');  //º”√‹
          Socket.SendText('#' + EncodeMessage(MakeDefaultMsg(SM_SENDLOGINKEY, 0, 0, 0, 0, 0)) + EncodeString(MyRecInfo.GatePass) + '!');
        end;
      {$IFEND}
      MainOutMessage('Connect: ' + sRemoteIPaddr, 5);
    end else begin
      Socket.Close;
      MainOutMessage('Kick Off: ' + sRemoteIPaddr, 1);
    end;
  end else begin
    Socket.Close;
    MainOutMessage('Kick Off: ' + sRemoteIPaddr, 1);
  end;
end;
{-----------------∫ÕøÕªß∂À∑«¡¨Ω”--------------------}
procedure TFrmMain.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I, II: Integer;
  UserSession: pTUserSession;
  nSockIndex: Integer;
  sRemoteIPaddr: string;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
  IPList: TList;
begin
  sRemoteIPaddr := Socket.RemoteAddress;
  nSockIndex := Socket.nIndex;
  nIPaddr := inet_addr(PChar(sRemoteIPaddr));
  CurrIPaddrList.Lock;
  try
    for I := CurrIPaddrList.Count - 1 downto 0 do begin
      IPList := TList(CurrIPaddrList.Items[I]);
      if IPList <> nil then begin
        for II := IPList.Count - 1 downto 0 do begin
          IPaddr := IPList.Items[II];
          if (IPaddr.nIPaddr = nIPaddr) and (IPaddr.nSocketHandle = Socket.SocketHandle) then begin
            Dispose(IPaddr);
            IPList.Delete(II);
            if IPList.Count <= 0 then begin
              IPList.Free;
              CurrIPaddrList.Delete(I);
            end;
            break;
          end;
        end;
      end;
    end;
  finally
    CurrIPaddrList.UnLock;
  end;

  if (nSockIndex >= 0) and (nSockIndex < GATEMAXSESSION) then begin
    UserSession := @g_SessionArray[nSockIndex];
    UserSession.Socket := nil;
    UserSession.sRemoteIPaddr := '';
    UserSession.SocketHandle := -1;
    UserSession.MsgList.Clear;
    Dec(nSessionCount);
    if boGateReady then begin
      ClientSocket.Socket.SendText('%C' +
        IntToStr(Socket.SocketHandle) +
        '$');
      MainOutMessage('∂œø™: ' + sRemoteIPaddr, 5);
    end;
  end;
end;
{--------------------∫ÕøÕªß∂À∑¢…˙¥ÌŒÛ---------------------}
procedure TFrmMain.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  //StringList30C.Add('Error ' + IntToStr(ErrorCode) + ': ' + Socket.RemoteAddress);
  Socket.Close;
  ErrorCode := 0;
end;
{----------------∂¡»°øÕªß∂À∑¢¿¥µƒ ˝æ›------------------}
procedure TFrmMain.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  UserSession: pTUserSession;
  nSockIndex: Integer;
  sRemoteAddress, sReviceMsg, s10, s1C: string;
  nPos: Integer;
  nMsgLen: Integer;
  //nIPaddr: Integer;
  nMsgCount: Integer;
  bo01: Boolean;
  bo02: Boolean;
  {$IF SPECVERSION = 1}  //20080831
  sLoginPass: string;
  {$IFEND}
begin
  bo01 := False;
  bo02 := False;
  nSockIndex := Socket.nIndex;
  sRemoteAddress := Socket.RemoteAddress;
  if (nSockIndex >= 0) and (nSockIndex < GATEMAXSESSION) then begin
    UserSession := @g_SessionArray[nSockIndex];
    sReviceMsg := Socket.ReceiveText;
    if (sReviceMsg <> '') and (boServerReady) then begin
      nMsgLen := Length(sReviceMsg);
      if nAttackLevel > 0 then begin
        Inc(UserSession.nReviceMsgLen, nMsgLen);
        nMsgCount := TagCount(sReviceMsg, '!');
       { MainOutMessage('nMsgCount: ' + IntToStr(nMsgCount), 1);
        MainOutMessage('nMsgLen: ' + IntToStr(nMsgLen), 1); }
        if nMsgCount > nMaxClientMsgCount * nAttackLevel then bo02 := True;
        if nMsgLen > 358{ * nAttackLevel} then bo01 := True;
        if bo01 or bo02 then begin

          if g_boChgDefendLevel then begin
            Inc(m_nAttackCount);
            m_dwAttackTick := GetTickCount;
            if m_nAttackCount >= g_nChgDefendLevel then begin
              if BlockMethod = mDisconnect then BlockMethod := mBlock;
              if nAttackLevel > 1 then nAttackLevel := 1;
            end;
          end;

          case BlockMethod of
            mDisconnect: begin
                //Socket.Close;
              end;
            mBlock: begin
                //AddTempBlockIP(sRemoteAddress);
                AddTempBlockIP(sRemoteAddress,SearchIPLocal(sRemoteAddress));//20080414
                CloseConnect(sRemoteAddress);
              end;
            mBlockList: begin
                //AddBlockIP(sRemoteAddress);
                AddBlockIP(sRemoteAddress,SearchIPLocal(sRemoteAddress));//20080414
                CloseConnect(sRemoteAddress);
              end;
          end;
          if m_nAttackCount < 10 then begin
            if bo01 then
              MainOutMessage('∂Àø⁄π•ª˜: ' + sRemoteAddress + '  ˝æ›∞¸≥§∂»: ' + IntToStr(UserSession.nReviceMsgLen), 1);
            if bo02 then
              MainOutMessage('∂Àø⁄π•ª˜: ' + sRemoteAddress + ' –≈œ¢ ˝¡ø£∫' + IntToStr(nMsgCount), 1);
          end;
          Socket.Close;
          Exit;
        end;
      end;

      nPos := Pos('*', sReviceMsg);
      if nPos > 0 then begin
        UserSession.boSendAvailable := True;
        UserSession.boSendCheck := False;
        UserSession.nCheckSendLength := 0;
        UserSession.dwReceiveTick := GetTickCount();
        s10 := Copy(sReviceMsg, 1, nPos - 1);
        s1C := Copy(sReviceMsg, nPos + 1, Length(sReviceMsg) - nPos);
        sReviceMsg := s10 + s1C;
      end;
      nMsgLen := Length(sReviceMsg);

      if UserSession.nReviceMsgLength <= 0 then
        UserSession.dwReceiveMsgTick := GetTickCount();
      Inc(UserSession.nReviceMsgLength, nMsgLen);

      if (sReviceMsg <> '') and (boGateReady) and (not boKeepAliveTimcOut) then begin
        UserSession.dwConnctCheckTick := GetTickCount();
        if (GetTickCount - UserSession.dwUserTimeOutTick) < 1000 then begin
          Inc(UserSession.n20, nMsgLen);
        end else UserSession.n20 := nMsgLen;
        {$IF SPECVERSION = 1}  //20080831
        if Pos('<56m2>', sReviceMsg) > 0 then begin
          sLoginPass := Copy(sReviceMsg, 7, Length(sReviceMsg)-1);
          sLoginPass := DeCodeString(sLoginPass);
          sLoginPass := Decrypt(sLoginPass, CertKey('?-WÆÍ'));
          if sLoginPass = g_sPassWord then begin
            UserSession.boLoginPassWord := True;
          end;
        end else begin
          if UserSession.boLoginPassWord then begin
            ClientSocket.Socket.SendText('%D' +
              IntToStr(Socket.SocketHandle) +
              '/' +
              sReviceMsg +
              '$');
          end else begin
            Socket.SendText('#' + EncodeMessage(MakeDefaultMsg(SM_GATEPASS_FAIL, 0, 0, 0, 0, 0)) + '!');
          end;
        end;
        {$ELSE}
        ClientSocket.Socket.SendText('%D' +
          IntToStr(Socket.SocketHandle) +
          '/' +
          sReviceMsg +
          '$');
        {$IFEND}
      end;
    end;
  end;
end;
{---------»Áπ˚MEMO¿Ôº«¬º¥Û”⁄200ƒ«√¥«Â≥˝µÙ-----------}
procedure TFrmMain.MemoLogChange(Sender: TObject);
begin
  if MemoLog.Lines.Count > 200 then MemoLog.Clear;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
var
  nIndex: Integer;
begin
  //StringList30C.Free;
  TempLogList.Free;
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    g_SessionArray[nIndex].MsgList.Free;
  end;
end;
{--------------------------πÿ±’µƒ ±∫Ú≥ˆœ÷------------------------------}
procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if boClose then Exit;
  if Application.MessageBox(' «∑Ò»∑»œÕÀ≥ˆ∑˛ŒÒ∆˜£ø',
    'Ã· æ–≈œ¢',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    if boServiceStart then begin
      StartTimer.Enabled := True;
      CanClose := False;
    end;
  end else CanClose := False;
end;
{----------------------∫ÕLoginSrv¡¨Ω”------------------------}
procedure TFrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  boGateReady := True;
  nSessionCount := 0;
  dwKeepAliveTick := GetTickCount();
  ResUserSessionArray();
  boServerReady := True;
end;
{----------------------∫ÕLoginSrv√ª¡¨Ω”------------------------}
procedure TFrmMain.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  UserSession: pTUserSession;
  nIndex: Integer;
begin
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    if UserSession.Socket <> nil then
      UserSession.Socket.Close;
    UserSession.Socket := nil;
    UserSession.sRemoteIPaddr := '';
    UserSession.SocketHandle := -1;
  end;
  ResUserSessionArray();
  ClientSockeMsgList.Clear;
  boGateReady := False;
  nSessionCount := 0;
end;
{-----------------∫ÕLoginSrv¡¨Ω”¥ÌŒÛ-------------------}
procedure TFrmMain.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  Socket.Close;
  ErrorCode := 0;
  boServerReady := False;
end;
{-----------------∂¡»°LoginSrv∑¢¿¥µƒ ˝æ›-------------------}
procedure TFrmMain.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sRecvMsg: string;
begin
  sRecvMsg := Socket.ReceiveText;
  ClientSockeMsgList.Add(sRecvMsg);
end;

procedure TFrmMain.SendTimerTimer(Sender: TObject);
var
  nIndex: Integer;
  UserSession: pTUserSession;
begin
  if ServerSocket.Active then begin
    n456A30 := ServerSocket.Socket.ActiveConnections;
  end;
  if boSendHoldTimeOut then begin
    LbHold.Caption := IntToStr(n456A30) + '#';
    if (GetTickCount - dwSendHoldTick) > 3000 then boSendHoldTimeOut := False;
  end else begin
    LbHold.Caption := IntToStr(n456A30);
  end;
  if boGateReady and (not boKeepAliveTimcOut) then begin
    for nIndex := 0 to GATEMAXSESSION - 1 do begin
      UserSession := @g_SessionArray[nIndex];
      if UserSession.Socket <> nil then begin
        if (GetTickCount - UserSession.dwUserTimeOutTick) > 3600000{60 * 60 * 1000} then begin
          UserSession.Socket.Close;
          UserSession.Socket := nil;
          UserSession.SocketHandle := -1;
          UserSession.MsgList.Clear;
          UserSession.sRemoteIPaddr := '';
        end;
      end;
    end;
  end;
  if not boGateReady and (boServiceStart) then begin
    if (GetTickCount - dwReConnectServerTick) > 1000 {30 * 1000} then begin
      dwReConnectServerTick := GetTickCount();
      ClientSocket.Active := False;
      ClientSocket.Port := ServerPort;
      ClientSocket.Host := ServerAddr;
      ClientSocket.Active := True;
    end;
  end;
end;

procedure TFrmMain.TimerTimer(Sender: TObject);
var
  I: Integer;
begin
  if ServerSocket.Active then begin
    if g_boClearTempList then begin
      if GetTickCount - m_dwAttackTick > 1000 * g_dwClearTempList then begin
        //m_dwAttackTick := GetTickCount;//20081030 ‘ˆº”
        m_nAttackCount := 0;
        if TempBlockIPList <> nil then begin
          TempBlockIPList.Lock;
          try
            for I := 0 to TempBlockIPList.Count - 1 do begin
              Dispose(pTSockaddr(TempBlockIPList.Items[I]));
            end;
            TempBlockIPList.Clear;
          finally
            TempBlockIPList.UnLock;
          end;
        end;
      end;
    end;

    if g_boReliefDefend then begin
      if (GetTickCount - m_dwAttackTick > 1000 * g_dwClearTempList) and (m_nAttackCount = 0) then begin
        if nAttackLevel <> nUseAttackLevel then nAttackLevel := nUseAttackLevel;
        if BlockMethod <> UseBlockMethod then BlockMethod := UseBlockMethod;
      end;
    end;

    if m_nAttackCount > 0 then begin
      StatusBar.Panels[3].Text := 'π•ª˜º∆¥Œ:' + IntToStr(m_nAttackCount);
    end;

    StatusBar.Panels[0].Text := IntToStr(ServerSocket.Port);
    if boSendHoldTimeOut then
      StatusBar.Panels[2].Text := IntToStr(nSessionCount) + '/#' + IntToStr(ServerSocket.Socket.ActiveConnections)
    else
      StatusBar.Panels[2].Text := IntToStr(nSessionCount) + '/' + IntToStr(ServerSocket.Socket.ActiveConnections);
  end else begin
    StatusBar.Panels[0].Text := '????';
    StatusBar.Panels[2].Text := '????';
  end;
  Label2.Caption := IntToStr(dwDecodeMsgTime);
  if not boGateReady then begin
    StatusBar.Panels[1].Text := '---]    [---';
    //StatusBar.Panels[1].Text := 'Œ¥¡¨Ω”';
  end else begin
    if boKeepAliveTimcOut then begin
      StatusBar.Panels[1].Text := '---]$$$$[---';
      //StatusBar.Panels[1].Text := '≥¨ ±';
    end else begin
      StatusBar.Panels[1].Text := '-----][-----';
      //StatusBar.Panels[1].Text := '“—¡¨Ω”';
      LbLack.Caption := IntToStr(n456A2C) + '/' + IntToStr(nSendMsgCount);
    end;
  end;
end;

procedure TFrmMain.DecodeTimerTimer(Sender: TObject);
var
  sProcessMsg: string;
  sSocketMsg: string;
  sSocketHandle: string;
  nSocketIndex: Integer;
  nMsgCount: Integer;
  nSendRetCode: Integer;
  nSocketHandle: Integer;
  dwDecodeTick: LongWord;
  dwDecodeTime: LongWord;
  sRemoteIPaddr: string;
  UserSession: pTUserSession;
begin
  ShowMainLogMsg();
  if boDecodeLock or (not boGateReady) then Exit;
  try
    dwDecodeTick := GetTickCount();
    boDecodeLock := True;
    sProcessMsg := '';
    while (True) do begin
      if ClientSockeMsgList.Count <= 0 then break;
      sProcessMsg := sProcMsg + ClientSockeMsgList.Strings[0];
      sProcMsg := '';
      ClientSockeMsgList.Delete(0);
      while (True) do begin
        if TagCount(sProcessMsg, '$') < 1 then break;
        sProcessMsg := ArrestStringEx(sProcessMsg, '%', '$', sSocketMsg);
        if sSocketMsg = '' then break;
        if sSocketMsg[1] = '+' then begin
          case sSocketMsg[2] of
            '-': begin
                CloseSocket(Str_ToInt(Copy(sSocketMsg, 3, Length(sSocketMsg) - 2), 0));
                Continue;
              end;
            'B': begin
                Inc(m_nAttackCount);
                m_dwAttackTick := GetTickCount;
                sRemoteIPaddr := CloseSocketAndGetIPAddr(Str_ToInt(Copy(sSocketMsg, 3, Length(sSocketMsg) - 2), 0));
                //AddTempBlockIP(sRemoteIPaddr);
                AddTempBlockIP(sRemoteIPaddr,SearchIPLocal(sRemoteIPaddr));//20080414
                Continue;
              end;
            'T': begin
                Inc(m_nAttackCount);
                m_dwAttackTick := GetTickCount;
                sRemoteIPaddr := CloseSocketAndGetIPAddr(Str_ToInt(Copy(sSocketMsg, 3, Length(sSocketMsg) - 2), 0));
                //AddBlockIP(sRemoteIPaddr);
                AddBlockIP(sRemoteIPaddr,SearchIPLocal(sRemoteIPaddr));//20080414
                Continue;
              end;
          else begin
              dwKeepAliveTick := GetTickCount();
              boKeepAliveTimcOut := False;
              Continue;
            end;
          end;
        end;
        sSocketMsg := GetValidStr3(sSocketMsg, sSocketHandle, ['/']);
        nSocketHandle := Str_ToInt(sSocketHandle, -1);
        if nSocketHandle < 0 then Continue;
        for nSocketIndex := 0 to GATEMAXSESSION - 1 do begin
          if g_SessionArray[nSocketIndex].SocketHandle = nSocketHandle then begin
            g_SessionArray[nSocketIndex].MsgList.Add(sSocketMsg);
            break;
          end;
        end;
      end;
    end;
    //if sProcessMsg <> '' then ClientSockeMsgList.Add(sProcessMsg);
    if sProcessMsg <> '' then sProcMsg := sProcessMsg;

    nSendMsgCount := 0;
    n456A2C := 0;
    //StringList318.Clear;
    for nSocketIndex := 0 to GATEMAXSESSION - 1 do begin
      if g_SessionArray[nSocketIndex].SocketHandle <= -1 then Continue;

      //Ãﬂ≥˝≥¨ ±Œﬁ ˝æ›¥´ ‰¡¨Ω”
      if (nAttackLevel > 0) and ((GetTickCount - g_SessionArray[nSocketIndex].dwConnctCheckTick) > dwKeepConnectTimeOut * nAttackLevel) then begin
        sRemoteIPaddr := g_SessionArray[nSocketIndex].sRemoteIPaddr;
        g_SessionArray[nSocketIndex].Socket.Close;
        //MainOutMessage('∂Àø⁄ø’¡¨Ω”π•ª˜: ' + sRemoteIPaddr, 1);}
        Continue;
      end;
      { if (nAttackLevel > 0) and ((GetTickCount - g_SessionArray[nSocketIndex].dwReceiveMsgTick) > 1000 * 30 * nAttackLevel) and (g_SessionArray[nSocketIndex].nReviceMsgLength > 1000) then begin
         sRemoteIPaddr := g_SessionArray[nSocketIndex].sRemoteIPaddr;
         Inc(m_nAttackCount);
         m_dwAttackTick := GetTickCount;
         if m_nAttackCount >= 3 then begin
           if BlockMethod = mDisconnect then BlockMethod := mBlock;
           if nAttackLevel > 1 then nAttackLevel := 1;
         end;
         case BlockMethod of
           mDisconnect: begin
               //Socket.Close;
             end;
           mBlock: begin
               AddTempBlockIP(sRemoteIPaddr);
               CloseConnect(sRemoteIPaddr);
             end;
           mBlockList: begin
               AddBlockIP(sRemoteIPaddr);
               CloseConnect(sRemoteIPaddr);
             end;
         end;
         if m_nAttackCount < 10 then begin
           MainOutMessage('∂Àø⁄π•ª˜: ' + sRemoteIPaddr, 1);
         end;
         g_SessionArray[nSocketIndex].Socket.Close;
         Continue;
       end;}

      while (True) do begin
        if g_SessionArray[nSocketIndex].MsgList.Count <= 0 then break;
        UserSession := @g_SessionArray[nSocketIndex];
        nSendRetCode := SendUserMsg(UserSession, UserSession.MsgList.Strings[0]);
        if (nSendRetCode >= 0) then begin
          if nSendRetCode = 1 then begin
            UserSession.dwConnctCheckTick := GetTickCount();
            UserSession.MsgList.Delete(0);
            Continue;
          end;
          if UserSession.MsgList.Count > 100 then begin
            nMsgCount := 0;
            while nMsgCount <> 51 do begin
              UserSession.MsgList.Delete(0);
              Inc(nMsgCount);
            end;
          end;
          Inc(n456A2C, UserSession.MsgList.Count);
          MainOutMessage(UserSession.sIP +
            ' : ' +
            IntToStr(UserSession.MsgList.Count), 5);
          Inc(nSendMsgCount);
        end else begin
          UserSession.SocketHandle := -1;
          UserSession.Socket := nil;
          UserSession.MsgList.Clear;
        end;
      end;
    end;
    if (GetTickCount - dwSendKeepAliveTick) > 2 * 1000 then begin
      dwSendKeepAliveTick := GetTickCount();
      if boGateReady then
        ClientSocket.Socket.SendText('%--$');
    end;
    if (GetTickCount - dwKeepAliveTick) > 10 * 1000 then begin
      boKeepAliveTimcOut := True;
      ClientSocket.Close;
    end;
  finally
    boDecodeLock := False;
  end;
  dwDecodeTime := GetTickCount - dwDecodeTick;
  if dwDecodeMsgTime < dwDecodeTime then dwDecodeMsgTime := dwDecodeTime;
  if dwDecodeMsgTime > 50 then Dec(dwDecodeMsgTime, 50);
end;
{--------------------πÿ±’¡¨Ω”----------------------}
procedure TFrmMain.CloseSocket(nSocketHandle: Integer);
var
  nIndex: Integer;
  UserSession: pTUserSession;
begin
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    if (UserSession.Socket <> nil) and (UserSession.SocketHandle = nSocketHandle) then begin
      UserSession.Socket.Close;
      break;
    end;
  end;
end;

function TFrmMain.CloseSocketAndGetIPAddr(nSocketHandle: Integer): string;
var
  nIndex: Integer;
  UserSession: pTUserSession;
begin
  Result := '';
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    if (UserSession.Socket <> nil) and (UserSession.SocketHandle = nSocketHandle) then begin
      Result := UserSession.sRemoteIPaddr;
      UserSession.Socket.Close;
      break;
    end;
  end;
end;

function TFrmMain.SendUserMsg(UserSession: pTUserSession; sSendMsg: string): Integer;
begin
  Result := -1;
  if UserSession.Socket <> nil then begin
    if not UserSession.bo0C then begin
      if not UserSession.boSendAvailable and (GetTickCount > UserSession.dwSendLockTimeOut) then begin
        UserSession.boSendAvailable := True;
        UserSession.nCheckSendLength := 0;
        boSendHoldTimeOut := True;
        dwSendHoldTick := GetTickCount();
      end;
      if UserSession.boSendAvailable then begin
        if UserSession.nCheckSendLength >= 250 then begin
          if not UserSession.boSendCheck then begin
            UserSession.boSendCheck := True;
            sSendMsg := '*' + sSendMsg;
          end;
          if UserSession.nCheckSendLength >= 512 then begin
            UserSession.boSendAvailable := False;
            UserSession.dwSendLockTimeOut := GetTickCount + 3 * 1000;
          end;
        end;
        UserSession.Socket.SendText(sSendMsg);
        Inc(UserSession.nSendMsgLen, Length(sSendMsg));
        Inc(UserSession.nCheckSendLength, Length(sSendMsg));
        Result := 1;
      end else begin
        Result := 0;
      end;
    end else begin
      Result := 0;
    end;
  end;
end;
{-----------∂¡»°ini≈‰÷√Œƒº˛-----------}
procedure TFrmMain.LoadConfig;
var
  Conf: TIniFile;
  sConfigFileName: string;
begin
  sConfigFileName := '.\Config.ini';
  Conf := TIniFile.Create(sConfigFileName);
  TitleName := Conf.ReadString(GateClass, 'Title', TitleName);
  ServerPort := Conf.ReadInteger(GateClass, 'ServerPort', ServerPort);
  ServerAddr := Conf.ReadString(GateClass, 'ServerAddr', ServerAddr);
  GatePort := Conf.ReadInteger(GateClass, 'GatePort', GatePort);
  GateAddr := Conf.ReadString(GateClass, 'GateAddr', GateAddr);
  nShowLogLevel := Conf.ReadInteger(GateClass, 'ShowLogLevel', nShowLogLevel);
  BlockMethod := TBlockIPMethod(Conf.ReadInteger(GateClass, 'BlockMethod', Integer(BlockMethod)));
  UseBlockMethod := BlockMethod;

  if Conf.ReadInteger(GateClass, 'KeepConnectTimeOut', -1) <= 0 then
    Conf.WriteInteger(GateClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);

  if Conf.ReadInteger(GateClass, 'AttackLevel', -1) <= 0 then
    Conf.WriteInteger(GateClass, 'AttackLevel', nAttackLevel);

  nAttackLevel := Conf.ReadInteger(GateClass, 'AttackLevel', nAttackLevel);
  nUseAttackLevel := nAttackLevel;

  nMaxConnOfIPaddr := Conf.ReadInteger(GateClass, 'MaxConnOfIPaddr', nMaxConnOfIPaddr);
  dwKeepConnectTimeOut := Conf.ReadInteger(GateClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);
  g_boDynamicIPDisMode := Conf.ReadBool(GateClass, 'DynamicIPDisMode', g_boDynamicIPDisMode);
  g_boMinimize := Conf.ReadBool(GateClass, 'Minimize', g_boMinimize);

  g_boChgDefendLevel := Conf.ReadBool(GateClass, 'ChgDefendLevel', g_boChgDefendLevel);
  g_boClearTempList := Conf.ReadBool(GateClass, 'ClearTempList', g_boClearTempList);
  g_boReliefDefend := Conf.ReadBool(GateClass, 'ReliefDefend', g_boReliefDefend);
  g_nChgDefendLevel := Conf.ReadInteger(GateClass, 'ChgDefendLevelCount', g_nChgDefendLevel);
  g_dwClearTempList := Conf.ReadInteger(GateClass, 'ClearTempListTime', g_dwClearTempList);
  g_dwReliefDefend := Conf.ReadInteger(GateClass, 'ReliefDefendTime', g_dwReliefDefend);
  {$IF SPECVERSION = 1}
    g_boSpecLogin := Conf.ReadBool(GateClass, 'SpecLogin', g_boSpecLogin);
    g_sPassWord := Conf.ReadString(GateClass, 'PassWord', g_sPassWord);
  {$IFEND}
  Conf.Free;          
  LoadBlockIPFile();
end;
{-----------ø™ º∑˛ŒÒ------------}
procedure TFrmMain.StartService;
var
  sLogoStr: string;
begin
  try
    MainOutMessage('’˝‘⁄∆Ù∂Ø∑˛ŒÒ...', 3);
    SendGameCenterMsg(SG_STARTNOW, g_sNowStartGate);
    //StatusBar.Panels[3].Text:=sVersion;
    boServiceStart := True;
    boGateReady := False;
    boServerReady := False;
    nSessionCount := 0;
    MENU_CONTROL_START.Enabled := False;
    MENU_CONTROL_STOP.Enabled := True;

    dwReConnectServerTick := GetTickCount - 25 * 1000;
    boKeepAliveTimcOut := False;
    nSendMsgCount := 0;
    n456A2C := 0;
    dwSendKeepAliveTick := GetTickCount();
    boSendHoldTimeOut := False;
    dwSendHoldTick := GetTickCount();

    CurrIPaddrList := TGList.Create;
    BlockIPList := TGList.Create;
    TempBlockIPList := TGList.Create;
    AttackIPaddrList := TGList.Create;
    ClientSockeMsgList := TStringList.Create;

    ResUserSessionArray();
    LoadConfig();
    Caption := GateName + ' - ' + TitleName;
    ClientSocket.Active := False;
    ClientSocket.Host := ServerAddr;
    ClientSocket.Port := ServerPort;
    ClientSocket.Active := True;

    ServerSocket.Active := False;
    ServerSocket.Address := GateAddr;
    ServerSocket.Port := GatePort;
    ServerSocket.Active := True;

    SendTimer.Enabled := True;
    MainOutMessage('∆Ù∂Ø∑˛ŒÒÕÍ≥…...', 3);
    SendGameCenterMsg(SG_STARTOK, g_sNowStartOK);
    {$IF SPECVERSION = 1}
    Decode(g_sLogoStr, sLogoStr);
    MainOutMessage(sLogoStr, 3);
    {$IFEND}
    if g_boMinimize then Application.Minimize;
  except
    on E: Exception do begin
      MENU_CONTROL_START.Enabled := True;
      MENU_CONTROL_STOP.Enabled := False;
      MainOutMessage(E.Message, 0);
    end;
  end;
end;
{----------------Õ£÷π∑˛ŒÒ--------------}
procedure TFrmMain.StopService;
var
  I, II: Integer;
  nSockIdx: Integer;
  IPaddr: pTSockaddr;
  IPList: TList;
begin
  MainOutMessage('’˝‘⁄Õ£÷π∑˛ŒÒ...', 3);
  boServiceStart := False;
  boGateReady := False;
  MENU_CONTROL_START.Enabled := True;
  MENU_CONTROL_STOP.Enabled := False;
  SendTimer.Enabled := False;
  for nSockIdx := 0 to GATEMAXSESSION - 1 do begin
    if g_SessionArray[nSockIdx].Socket <> nil then
      g_SessionArray[nSockIdx].Socket.Close;
  end;
  SaveBlockIPList();
  ServerSocket.Close;
  ClientSocket.Close;
  ClientSockeMsgList.Free;

  CurrIPaddrList.Lock;
  try
    for I := 0 to CurrIPaddrList.Count - 1 do begin
      IPList := TList(CurrIPaddrList.Items[I]);
      if IPList <> nil then begin
        for II := 0 to IPList.Count - 1 do begin
          if pTSockaddr(IPList.Items[II]) <> nil then
            Dispose(pTSockaddr(IPList.Items[II]));
        end;
        IPList.Free;
      end;
    end;
  finally
    CurrIPaddrList.UnLock;
    CurrIPaddrList.Free;
  end;

  BlockIPList.Lock;
  try
    for I := 0 to BlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(BlockIPList.Items[I]);
      Dispose(IPaddr);
    end;
  finally
    BlockIPList.UnLock;
    BlockIPList.Free;
  end;

  TempBlockIPList.Lock;
  try
    for I := 0 to TempBlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(TempBlockIPList.Items[I]);
      Dispose(IPaddr);
    end;
  finally
    TempBlockIPList.UnLock;
    TempBlockIPList.Free;
  end;

  AttackIPaddrList.Lock;
  try
    for I := 0 to AttackIPaddrList.Count - 1 do begin
      IPaddr := pTSockaddr(AttackIPaddrList.Items[I]);
      Dispose(IPaddr);
    end;
  finally
    AttackIPaddrList.UnLock;
    AttackIPaddrList.Free;
  end;

  MainOutMessage('Õ£÷π∑˛ŒÒÕÍ≥…...', 3);
end;

procedure TFrmMain.ResUserSessionArray;
var
  UserSession: pTUserSession;
  nIndex: Integer;
begin
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    UserSession.Socket := nil;
    UserSession.sRemoteIPaddr := '';
    UserSession.SocketHandle := -1;
    UserSession.MsgList.Clear;
  end;
end;
procedure TFrmMain.IniUserSessionArray();
var
  UserSession: pTUserSession;
  nIndex: Integer;
begin
  for nIndex := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @g_SessionArray[nIndex];
    UserSession.Socket := nil;
    UserSession.sRemoteIPaddr := '';
    UserSession.nSendMsgLen := 0;
    UserSession.bo0C := False;
    UserSession.dw10Tick := GetTickCount();
    UserSession.boSendAvailable := True;
    UserSession.boSendCheck := False;
    UserSession.nCheckSendLength := 0;
    UserSession.n20 := 0;
    UserSession.dwUserTimeOutTick := GetTickCount();
    UserSession.SocketHandle := -1;
    UserSession.dwReceiveTick := GetTickCount();
    UserSession.nReviceMsgLength := 0;
    UserSession.dwReceiveMsgTick := GetTickCount();
    UserSession.MsgList := TStringList.Create;
  end;
end;

procedure TFrmMain.StartTimerTimer(Sender: TObject);
begin
  if boStarted then begin
    StartTimer.Enabled := False;
    StopService();
    boClose := True;
    Close;
  end else begin
    MENU_VIEW_LOGMSGClick(Sender);
    boStarted := True;
    StartTimer.Enabled := False;
    StartService();
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  nX, nY: Integer;
begin
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  nX := Str_ToInt(ParamStr(2), -1);
  nY := Str_ToInt(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;
  TempLogList := TStringList.Create;
  //StringList30C := TStringList.Create;
  //StringList318 := TStringList.Create;
  dwDecodeMsgTime := 0;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  IniUserSessionArray();
  {$IF SPECVERSION = 1}  //20080831
  ExtractInfo(ProgramPath, MyRecInfo);//∂¡≥ˆ◊‘…Ìµƒ–≈œ¢
  {$IFEND}
end;

procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  StartService();
end;

procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  if Application.MessageBox(' «∑Ò»∑»œÕ£÷π∑˛ŒÒ£ø',
    '»∑»œ–≈œ¢',
    MB_YESNO + MB_ICONQUESTION) = IDYES then
    StopService();
end;

procedure TFrmMain.MENU_CONTROL_RECONNECTClick(Sender: TObject);
begin
  dwReConnectServerTick := 0;
end;

procedure TFrmMain.MENU_CONTROL_CLEAELOGClick(Sender: TObject);
begin
  if Application.MessageBox(' «∑Ò»∑»œ«Â≥˝œ‘ æµƒ»’÷æ–≈œ¢£ø',
    '»∑»œ–≈œ¢',
    MB_OKCANCEL + MB_ICONQUESTION
    ) <> IDOK then Exit;
  MemoLog.Clear;
end;

procedure TFrmMain.MENU_CONTROL_EXITClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.MENU_VIEW_LOGMSGClick(Sender: TObject);
begin
  MENU_VIEW_LOGMSG.Checked := not MENU_VIEW_LOGMSG.Checked;
  ShowLogMsg(MENU_VIEW_LOGMSG.Checked);
end;

procedure TFrmMain.ShowLogMsg(boFlag: Boolean);
var
  nHeight: Integer;
begin
  case boFlag of
    True: begin
        nHeight := Panel.Height;
        Panel.Height := 0;
        MemoLog.Height := nHeight;
        MemoLog.Top := Panel.Top;
      end;
    False: begin
        nHeight := MemoLog.Height;
        MemoLog.Height := 0;
        Panel.Height := nHeight;
      end;
  end;
end;

procedure TFrmMain.MENU_OPTION_GENERALClick(Sender: TObject);
begin
  frmGeneralConfig.Top := Self.Top + 20;
  frmGeneralConfig.Left := Self.Left;
  with frmGeneralConfig do begin
    EditGateIPaddr.Text := GateAddr;
    EditGatePort.Text := IntToStr(GatePort);
    EditServerIPaddr.Text := ServerAddr;
    EditServerPort.Text := IntToStr(ServerPort);
    EditTitle.Text := TitleName;
    TrackBarLogLevel.Position := nShowLogLevel;
    CheckBoxMinimize.Checked := g_boMinimize;
  {$IF SPECVERSION = 1}
    TabSheet2.TabVisible := True;
    CheckBoxSpecLogin.Checked := g_boSpecLogin;
    EdtPassword.Text := g_sPassWord;
    if FileExists('.\WarningMsg.txt') then
      MemoWarningMsg.Lines.LoadFromFile('.\WarningMsg.txt');
  {$ELSE}
    TabSheet2.TabVisible := False;
  {$IFEND}
  end;
  frmGeneralConfig.ShowModal;
end;

procedure TFrmMain.CloseConnect(sIPaddr: string);
var
  I: Integer;
  boCheck: Boolean;
begin
  if ServerSocket.Active then
    while (True) do begin
      boCheck := False;
      for I := 0 to ServerSocket.Socket.ActiveConnections - 1 do begin
        if sIPaddr = ServerSocket.Socket.Connections[I].RemoteAddress then begin
          ServerSocket.Socket.Connections[I].Close;
          boCheck := True;
          break;
        end;
      end;
      if not boCheck then break;
    end;
end;

procedure TFrmMain.MENU_OPTION_IPFILTERClick(Sender: TObject);
var
  I: Integer;
  sIPaddr: string;
begin
  frmIPaddrFilter.Top := Self.Top + 20;
  frmIPaddrFilter.Left := Self.Left;
  frmIPaddrFilter.ListBoxActiveList.Clear;
  frmIPaddrFilter.ListBoxTempList.Clear;
  frmIPaddrFilter.ListBoxBlockList.Clear;
  if ServerSocket.Active then
    for I := 0 to ServerSocket.Socket.ActiveConnections - 1 do begin
      sIPaddr := ServerSocket.Socket.Connections[I].RemoteAddress;
      if sIPaddr <> '' then begin
        sIPaddr := sIPaddr+'->'+SearchIPLocal(sIPaddr);
        frmIPaddrFilter.ListBoxActiveList.Items.AddObject(sIPaddr, TObject(ServerSocket.Socket.Connections[I]));
      end;
    end;

  for I := 0 to TempBlockIPList.Count - 1 do begin
    if pos('*',pTSockaddr(TempBlockIPList.Items[I]).sIPaddr) > 0 then begin//≈–∂œ «∑Ò «IP∂Œ 20081030
      frmIPaddrFilter.ListBoxTempList.Items.Add(pTSockaddr(TempBlockIPList.Items[I]).sIPaddr+'->');
    end else begin
      frmIPaddrFilter.ListBoxTempList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(TempBlockIPList.Items[I]).nIPaddr)))+'->'+pTSockaddr(TempBlockIPList.Items[i]).sIPDate);//20080414
    end;
  end;
  for I := 0 to BlockIPList.Count - 1 do begin
    if pos('*',pTSockaddr(BlockIPList.Items[I]).sIPaddr) > 0 then begin//≈–∂œ «∑Ò «IP∂Œ 20081030
      frmIPaddrFilter.ListBoxBlockList.Items.Add(pTSockaddr(BlockIPList.Items[I]).sIPaddr+'->');
    end else begin
      frmIPaddrFilter.ListBoxBlockList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr)))+'->'+pTSockaddr(BlockIPList.Items[i]).sIPDate);//20080414
    end;
  end;
  frmIPaddrFilter.TrackBarAttack.Position := nAttackLevel;
  frmIPaddrFilter.EditMaxConnect.Value := nMaxConnOfIPaddr;

  frmIPaddrFilter.CheckBoxChg.Checked := g_boChgDefendLevel;
  frmIPaddrFilter.CheckBoxAutoClearTempList.Checked := g_boClearTempList;
  frmIPaddrFilter.CheckBoxReliefDefend.Checked := g_boReliefDefend;

  frmIPaddrFilter.SpinEdit1.Value := g_nChgDefendLevel;
  frmIPaddrFilter.SpinEdit2.Value := g_dwClearTempList;
  frmIPaddrFilter.SpinEdit3.Value := g_dwReliefDefend;
  case BlockMethod of
    mDisconnect: frmIPaddrFilter.RadioDisConnect.Checked := True;
    mBlock: frmIPaddrFilter.RadioAddTempList.Checked := True;
    mBlockList: frmIPaddrFilter.RadioAddBlockList.Checked := True;
  end;
  frmIPaddrFilter.ShowModal;
end;
//ºÏ≤È «∑Ò «π•ª˜µƒIP
function TFrmMain.IsBlockIP(sIPaddr: string): Boolean;
var
  I: Integer;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
  function IsRightBlockIP(sIPaddr, sSetIP: string): Boolean;
  var
    K: integer;
    sTemp,sTemp1: string;
  begin
    Result := False;
    K:= pos('*', sSetIP);
    if K > 0 then begin//≈–∂œ «∑Ò «IP∂Œ 20081030
      sTemp:= Copy(sSetIP, 0, K - 1);
      sTemp1:= Copy(sIPaddr, 0, length(sTemp));
      if sTemp = sTemp1 then Result := True;
    end;
  end;
begin
  Result := False;
  TempBlockIPList.Lock;
  try
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to TempBlockIPList.Count - 1 do begin
      IPaddr := pTSockaddr(TempBlockIPList.Items[I]);
      if IPaddr.nIPaddr = nIPaddr then begin
        Result := True;
        break;
      end;
      if IsRightBlockIP(sIPaddr, IPaddr.sIPaddr) then begin
        Result := True;
        break;
      end;
    end;
  finally
    TempBlockIPList.UnLock;
  end;
  //-------------------------------
  if not Result then begin
    BlockIPList.Lock;
    try
      for I := 0 to BlockIPList.Count - 1 do begin
        IPaddr := pTSockaddr(BlockIPList.Items[I]);
        if IPaddr.nIPaddr = nIPaddr then begin
          Result := True;
          break;
        end;
        if IsRightBlockIP(sIPaddr, IPaddr.sIPaddr) then begin
          Result := True;
          break;
        end;
      end;
    finally
      BlockIPList.UnLock;
    end;
  end;
end;
{-------------ÃÌº”œﬁ÷∆IP∫Ø ˝---------------------}
function TFrmMain.AddBlockIP(sIPaddr, sIPDate: string): Integer;
var
  I: Integer;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
begin
  BlockIPList.Lock;
  try
    Result := 0;
    if pos('*',sIPaddr) > 0 then begin//≈–∂œ «∑Ò «IP∂Œ 20081030
      for I := 0 to BlockIPList.Count - 1 do begin
        IPaddr := pTSockaddr(BlockIPList.Items[I]);
        if IPaddr.sIPaddr = sIPaddr then begin
          Result := BlockIPList.Count;
          break;
        end;
      end;
      if Result <= 0 then begin
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.sIPaddr := sIPaddr;//IP∂Œ
        IPaddr^.sIPDate := sIPDate;//20080414
        BlockIPList.Add(IPaddr);
        Result := BlockIPList.Count;
      end;
    end else begin
      nIPaddr := inet_addr(PChar(sIPaddr));
      for I := 0 to BlockIPList.Count - 1 do begin
        IPaddr := pTSockaddr(BlockIPList.Items[I]);
        if IPaddr.nIPaddr = nIPaddr then begin
          Result := BlockIPList.Count;
          break;
        end;
      end;
      if Result <= 0 then begin
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.nIPaddr := nIPaddr;
        IPaddr^.sIPDate := sIPDate;//20080414
        BlockIPList.Add(IPaddr);
        Result := BlockIPList.Count;
      end;
    end;
  finally
    BlockIPList.UnLock;
  end;
end;
//‘ˆº”∂ØÃ¨π˝¬ÀIP
function TFrmMain.AddTempBlockIP(sIPaddr,sIPDate: string): Integer;
var
  I: Integer;
  IPaddr: pTSockaddr;
  nIPaddr: Integer;
begin
  TempBlockIPList.Lock;
  try
    Result := 0;
    if pos('*',sIPaddr) > 0 then begin//≈–∂œ «∑Ò «IP∂Œ 20081030
      for I := 0 to TempBlockIPList.Count - 1 do begin
        IPaddr := pTSockaddr(TempBlockIPList.Items[I]);
        if IPaddr.sIPaddr = sIPaddr then begin
          Result := TempBlockIPList.Count;
          break;
        end;
      end;
      if Result <= 0 then begin
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.sIPaddr := sIPaddr;//IP∂Œ
        IPaddr^.sIPDate := sIPDate;//20080414
        TempBlockIPList.Add(IPaddr);
        Result := TempBlockIPList.Count;
      end;
    end else begin
      nIPaddr := inet_addr(PChar(sIPaddr));
      for I := 0 to TempBlockIPList.Count - 1 do begin
        IPaddr := pTSockaddr(TempBlockIPList.Items[I]);
        if IPaddr.nIPaddr = nIPaddr then begin
          Result := TempBlockIPList.Count;
          break;
        end;
      end;
      if Result <= 0 then begin
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.nIPaddr := nIPaddr;
        IPaddr^.sIPDate := sIPDate;//20080414
        TempBlockIPList.Add(IPaddr);
        Result := TempBlockIPList.Count;
      end;
    end;
  finally
    TempBlockIPList.UnLock;
  end;
end;

function TFrmMain.AddAttackIP(sIPaddr: string): Boolean;
var
  I: Integer;
  IPaddr, AddIPaddr: pTSockaddr;
  nIPaddr: Integer;
  bo01: Boolean;
begin
  Result := False;
  AttackIPaddrList.Lock;
  try
    if nAttackLevel > 0 then begin
      bo01 := False;
      nIPaddr := inet_addr(PChar(sIPaddr));
      for I := AttackIPaddrList.Count - 1 downto 0 do begin
        IPaddr := pTSockaddr(AttackIPaddrList.Items[I]);
        if IPaddr.nIPaddr = nIPaddr then begin
          if (GetTickCount - IPaddr.dwStartAttackTick) <= dwAttackTime div nAttackLevel then begin
            IPaddr.dwStartAttackTick := GetTickCount;
            Inc(IPaddr.nAttackCount);
            //MainOutMessage('IPaddr.nAttackCount: '+IntToStr(IPaddr.nAttackCount), 0);
            if IPaddr.nAttackCount >= nAttackCount * nAttackLevel then begin
              AttackIPaddrList.Delete(I);
              Dispose(IPaddr);
              Result := True;
            end;
          end else begin
            if IPaddr.nAttackCount > nAttackCount * nAttackLevel then begin
              Inc(m_nAttackCount);
              m_dwAttackTick := GetTickCount;
              Result := True;
            end;
            AttackIPaddrList.Delete(I);
            Dispose(IPaddr);
          end;
          bo01 := True;
          break;
        end;
      end;
      if not bo01 then begin
        New(AddIPaddr);
        FillChar(AddIPaddr^, SizeOf(TSockaddr), 0);
        AddIPaddr^.nIPaddr := nIPaddr;
        AddIPaddr^.dwStartAttackTick := GetTickCount;
        AddIPaddr^.nAttackCount := 0;
        AttackIPaddrList.Add(AddIPaddr);
      end;
    end;
  finally
    AttackIPaddrList.UnLock;
  end;
end;

function TFrmMain.IsConnLimited(sIPaddr: string; SocketHandle: Integer): Boolean;
var
  I: Integer;
  IPaddr, AttackIPaddr: pTSockaddr;
  nIPaddr: Integer;
  bo01: Boolean;
  IPList: TList;
begin
  Result := False;
  CurrIPaddrList.Lock;
  try
    if nAttackLevel > 0 then begin
      bo01 := False;
      nIPaddr := inet_addr(PChar(sIPaddr));
      for I := 0 to CurrIPaddrList.Count - 1 do begin
        IPList := TList(CurrIPaddrList.Items[I]);
        if (IPList <> nil) and (IPList.Count > 0) then begin
          IPaddr := pTSockaddr(IPList.Items[0]);
          if IPaddr <> nil then begin
            if IPaddr.nIPaddr = nIPaddr then begin
              bo01 := True;
              Result := AddAttackIP(sIPaddr);
              if Result then break;
              New(AttackIPaddr);
              FillChar(AttackIPaddr^, SizeOf(TSockaddr), 0);
              AttackIPaddr^.nIPaddr := nIPaddr;
              AttackIPaddr^.nSocketHandle := SocketHandle;
              IPList.Add(AttackIPaddr);
              if IPList.Count > nMaxConnOfIPaddr * nAttackLevel then Result := True;
              break;
            end;
          end;
        end;
      end;
      if not bo01 then begin
        IPList := nil;
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.nIPaddr := nIPaddr;
        IPaddr^.nSocketHandle := SocketHandle;
        IPList := TList.Create;
        IPList.Add(IPaddr);
        CurrIPaddrList.Add(IPList);
      end;
    end;
  finally
    CurrIPaddrList.UnLock;
  end;
end;

procedure TFrmMain.ShowMainLogMsg;
var
  I: Integer;
begin
  if (GetTickCount - dwShowMainLogTick) < 200 then Exit;
  dwShowMainLogTick := GetTickCount();
  try
    boShowLocked := True;
    try
      CS_MainLog.Enter;
      for I := 0 to MainLogMsgList.Count - 1 do begin
        TempLogList.Add(MainLogMsgList.Strings[I]);
      end;
      MainLogMsgList.Clear;
    finally
      CS_MainLog.Leave;
    end;
    for I := 0 to TempLogList.Count - 1 do begin
      MemoLog.Lines.Add(TempLogList.Strings[I]);
    end;
    TempLogList.Clear;
  finally
    boShowLocked := False;
  end;
end;

procedure TFrmMain.MyMessage(var MsgData: TWmCopyData);
var
  sData: string;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of
    GS_QUIT: begin
        if boServiceStart then begin
          StartTimer.Enabled := True;
        end else begin
          boClose := True;
          Close();
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;
{-------------œ‘ æ∞Ê»®–≈œ¢---------------}
procedure TFrmMain.S1Click(Sender: TObject);
begin
  FrmAbout := TFrmAbout.Create(Owner);
  FrmAbout.Open();
  FrmAbout.Free;
end;

end.


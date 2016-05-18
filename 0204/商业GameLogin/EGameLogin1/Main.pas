unit Main;

interface

uses
  Windows, Messages, SysUtils, Graphics,  Forms, IniFiles, ShellAPI, Grobal2,
  EDcode, JSocket, Winsock, RzLabel,  IdHTTP, Md5, GameLoginShare,
  RzBmpBtn, RzCmboBx, RzRadChk, ExtCtrls, Classes,
  Common, RzPanel, IdComponent,
  SHDocVw, ComCtrls, Controls, 
  IdAntiFreeze, WinInet, WinHTTP, jpeg, ImageProgressbar, EDcodeUnit, Reg,
  IdAntiFreezeBase, IdBaseComponent, IdTCPConnection, IdTCPClient,
  RzButton, StdCtrls, OleCtrls;
type
  TFrmMain = class(TForm)
    MainImage: TImage;
    WebBrowser1: TWebBrowser;
    RzPanel1: TRzPanel;
    TimeGetGameList: TTimer;
    ClientSocket: TClientSocket;
    ClientTimer: TTimer;
    TreeView1: TTreeView;
    IdHTTP1: TIdHTTP;
    Timer2: TTimer;
    SecrchTimer: TTimer;
    TimerKillCheat: TTimer;
    Timer3: TTimer;
    IdAntiFreeze: TIdAntiFreeze;
    ServerSocket: TServerSocket;
    WinHTTP: TWinHTTP;
    RzComboBox1: TRzComboBox;
    RzCheckBox1: TRzCheckBox;
    RzLabelStatus: TRzLabel;
    MinimizeBtn: TRzBmpButton;
    CloseBtn: TRzBmpButton;
    StartMirButton: TRzBmpButton;
    ButtonHomePage: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    ImageButtonClose: TRzBmpButton;
    ButtonGetBackPassword: TRzBmpButton;
    ButtonChgPassword: TRzBmpButton;
    ButtonNewAccount: TRzBmpButton;
    ProgressBarCurDownload: TImageProgressbar;
    ProgressBarAll: TImageProgressbar;
    procedure MainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MinimizeBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimeGetGameListTimer(Sender: TObject);
    procedure SendCSocket(sendstr: string);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketConnecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientTimerTimer(Sender: TObject);
    procedure DecodeMessagePacket(datablock: string);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure TreeView1AdvancedCustomDraw(Sender: TCustomTreeView;
      const ARect: TRect; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure SecrchTimerTimer(Sender: TObject);
    procedure TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TimerKillCheatTimer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WinHTTPDone(Sender: TObject; const ContentType: String;
      FileSize: Integer; Stream: TStream);
    procedure WinHTTPHTTPError(Sender: TObject; ErrorCode: Integer;
      Stream: TStream);
    procedure WinHTTPHostUnreachable(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StartMirButtonClick(Sender: TObject);
    procedure ButtonHomePageClick(Sender: TObject);
    procedure ImageButtonCloseClick(Sender: TObject);
    procedure ButtonGetBackPasswordClick(Sender: TObject);
    procedure ButtonChgPasswordClick(Sender: TObject);
    procedure ButtonNewAccountClick(Sender: TObject);
    procedure MinimizeBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
  private
    dwClickTick: LongWord;
    function  WriteMirInfo(MirPath: string): Boolean;
    procedure ServerActive;  //20080310
    procedure ButtonActive; //��������   20080311
    procedure ButtonActiveF; //��������   20080311
    procedure AnalysisFile();
    procedure LoadPatchList();
    procedure LoadGameMonList(str: TStream);
    function DownLoadFile(sURL,sFName: string;CanBreak: Boolean): boolean;  //�����ļ�
  public
    procedure LoadServerList(str: TStream);
    procedure LoadServerTreeView();
    procedure CreateDelFile();
    procedure LoadSelfInfo();

    procedure SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd); //�����½��˺�
    procedure SendChgPw(sAccount, sPasswd, sNewPasswd: string); //�����޸�����
    procedure SendGetBackPassword(sAccount, sQuest1, sAnswer1, sQuest2, sAnswer2, sBirthDay: string); //�����һ�����

  end;

var
  FrmMain: TFrmMain;
  HomeURL: string;
  GameItemsURL: string;
 {$if Version = 0}
 GameListURL: pchar ='http://www.56m2.cn/QKServerList.txt';
 PatchListURL: pchar ='http://www.56m2.cn/QKPatchList.txt';
 GameESystemURL: pchar ='http://www.56m2.com';
 {$ifend}
 NowNode : TTreeNode = nil;
 GetUrlStep: TGetUrlStep;
implementation
uses HUtil32,NewAccount, ChangePassword, GetBackPassword, Secrch, 
  MsgBox, GameMon;
{$R *.dfm}

//�����������Ϣ
procedure TFrmMain.LoadSelfInfo();
var
  str: string;
  //�ַ����ӽ��ܺ��� 20071225
  Function SetDate(Text: String): String;
  Var
    I     :Word;
    C     :Word;
  Begin
    asm
      db $EB,$10,'VMProtect begin',0
    end;
      Result := '';
      For I := 1 To Length(Text) Do Begin
        C := Ord(Text[I]);
        Result := Result + Chr((C Xor 15));
      End;
    asm
      db $EB,$0E,'VMProtect end',0
    end;
  End;
const
  s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
  s_s02 = 'K_pxJodu';
  s_s03 = 'JoijVo`rK_\rVriiJoXsI\';
  s_s04 = 'VOUfJ?dxJ_xwJBprI_\wWL';
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  ExtractInfo(ProgramPath, MyRecInfo);//�����������Ϣ
  if MyRecInfo.GameListURL <> '' then begin
    LnkName := MyRecInfo.lnkName;
    {$if Version = 1}
    str := LoginMainImagesD(MyRecInfo.GameListURL,SetDate(DecodeString(s_s03)));
    GameListURL := LoginMainImagesB(str,SetDate(DecodeString(s_s03)));//DecodeString_3des(MyRecInfo.GameListURL, CertKey('9�z�<L��Ů'));
    str := LoginMainImagesD(MyRecInfo.BakGameListURL,SetDate(DecodeString(s_s03)));
    BakGameListURL := LoginMainImagesB(str,SetDate(DecodeString(s_s03)));//DecodeString_3des(MyRecInfo.BakGameListURL, CertKey('9�z�<L��Ů'));
    str := LoginMainImagesD(MyRecInfo.PatchListURL,SetDate(DecodeString(s_s03)));
    PatchListURL := LoginMainImagesB(str,SetDate(DecodeString(s_s03)));//DecodeString_3des(MyRecInfo.PatchListURL, CertKey('9�z�<L��Ů'));
    g_boGameMon := MyRecInfo.boGameMon;
    str := LoginMainImagesD(MyRecInfo.GameMonListURL,SetDate(DecodeString(s_s03)));
    GameMonListURL := LoginMainImagesB(str,SetDate(DecodeString(s_s03)));//DecodeString_3des(MyRecInfo.GameMonListURL, CertKey('9�z�<L��Ů'));
    str := LoginMainImagesD(MyRecInfo.GameESystemUrl,SetDate(DecodeString(s_s03)));
    GameESystemURL := LoginMainImagesB(str,SetDate(DecodeString(s_s03)));//DecodeString_3des(MyRecInfo.GameESystemUrl, CertKey('9�z�<L��Ů'));
    ClientFileName := MyRecInfo.ClientFileName;
    str := LoginMainImagesD(MyRecInfo.GatePass,SetDate(DecodeString(s_s03)));
    g_sGatePassWord := LoginMainImagesB(str,SetDate(DecodeString(s_s03)));//DecodeString_3des(MyRecInfo.GatePass, CertKey('9�z�<L��Ů'));
    sSourceFileSize := MyRecInfo.SourceFileSize;
    {$ifend}
    Application.Title := MyRecInfo.lnkName;
  end;
  {$if Version = 0}
  ClientFileName := '0.exe';
  m_sLocalGameListName := '1.txt';
  {$IFEND}
    asm
      db $EB,$0E,'VMProtect end',0
    end;
end;


procedure TFrmMain.CreateDelFile();
begin
  if Fileexists(PChar(m_sMirClient)+'blueyue.ini') then Deletefile(PChar(m_sMirClient)+'blueyue.ini');
  if Fileexists(PChar(m_sMirClient)+'QKServerList.txt') then Deletefile(PChar(m_sMirClient)+'QKServerList.txt');
  if Fileexists(PChar(m_sMirClient)+'QKPatchList.txt') then Deletefile(PChar(m_sMirClient)+'QKPatchList.txt');
  //if Fileexists(PChar(m_sMirClient)+'QKGameMonList.txt') then Deletefile(PChar(m_sMirClient)+'QKGameMonList.txt');
  if FileExists(PChar(ExtractFilePath(ParamStr(0)))+BakFileName) then DeleteFile(PChar(ExtractFilePath(ParamStr(0)))+BakFileName);
end;

//����Ϣ��ٵ������б���
procedure TFrmMain.LoadServerTreeView();
var
  ServerInfo,ServerInfo1: pTServerInfo;
  TmpNode: TTreeNode;
  I,K,J:integer;
  BB:Boolean;
begin
   TreeView1.Items.Clear;
   for I := 0 to g_ServerList.Count - 1 do begin
   BB:=False;
    ServerInfo := pTServerInfo(g_ServerList.Items[I]);
    if TreeView1.Items<> nil then
    for J:=0 to TreeView1.Items.Count-1 do begin
       if CompareText(ServerInfo.ServerArray,TreeView1.Items[j].Text)=0 then BB:=True;
    end;
     if BB then Continue;
     TmpNode := TreeView1.Items.Add(nil,ServerInfo.ServerArray);
      for K := 0 to g_ServerList.Count - 1 do  begin
      ServerInfo1 := pTServerInfo(g_ServerList.Items[K]);
       if CompareText(ServerInfo.ServerArray,ServerInfo1.ServerArray)=0 then
         TreeView1.Items.AddChildObject(TmpNode,ServerInfo1.ServerName,ServerInfo1);
      end;
   end;
end;
//���ļ���ȡ��Ϸ�б�
procedure TFrmMain.LoadServerList(str: TStream);
var
  I: Integer;
   sLineText: string;
  LoadList: TStringList;
  //LoadList1: TStringList;
  ServerInfo: pTServerInfo;
  sServerArray, sServerName, sServerIP, sServerPort, sServerNoticeURL, sServerHomeURL: string;
  sGameItemsURL: string;
  sGatePass: string;
begin
  //sFileName := 'QKServerList.txt';
  {if not FileExists(PChar(m_sMirClient)+sFileName) then begin
    TreeView1.Items.Clear;
    TreeView1.Items.Add(nil,'��ȡ�������б�ʧ��...');
    Exit;
  end; }
  g_ServerList.Clear;
  LoadList := Classes.TStringList.Create();
  try
  //LoadList1 := Classes.TStringList.Create();
  //LoadList1.LoadFromFile(PChar(m_sMirClient)+sFileName);
  //LoadList1.LoadFromStream(str);
  //LoadList.Text := (decrypt(Trim(LoadList1.Text),CertKey('?-W��')));
  LoadList.LoadFromStream(str);
  //LoadList1.Free;
  if LoadList.Text <> '' then begin
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sLineText := GetValidStr3(sLineText, sServerArray, ['|']);
        sLineText := GetValidStr3(sLineText, sServerName, ['|']);
        sLineText := GetValidStr3(sLineText, sServerIP, ['|']);
        sLineText := GetValidStr3(sLineText, sServerPort, ['|']);
        sLineText := GetValidStr3(sLineText, sServerNoticeURL, ['|']);
        sLineText := GetValidStr3(sLineText, sServerHomeURL, ['|']);
        sLineText := GetValidStr3(sLineText, sGameItemsURL, ['|']);
        sLineText := GetValidStr3(sLineText, sGatePass, ['|']);
        if (sServerArray <> '') and (sServerIP <> '') and (sServerPort <> '') then begin
            New(ServerInfo);
            ServerInfo.ServerArray := sServerArray;
            ServerInfo.ServerName := sServerName;
            ServerInfo.ServerIP := sServerIP;
            ServerInfo.ServerPort := StrToInt(sServerPort);
            ServerInfo.ServerNoticeURL := sServerNoticeURL;
            ServerInfo.ServerHomeURL := sServerHomeURL;
            ServerInfo.GameItemsURL := sGameItemsURL;
            ServerInfo.GatePass := sGatePass;
            g_ServerList.Add(ServerInfo);
        end;
      end;
    end;
  end;
  finally
    LoadList.Free;
  end;
  LoadServerTreeView();
  if TreeView1.Items.Count > 0 then TreeView1.Items[0].Selected := True;   //�Զ�ѡ���һ������
end;
//�����ͼ�����ƶ� ����Ҳ�����ƶ�
procedure TFrmMain.MainImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;
//��С��
procedure TFrmMain.MinimizeBtn1Click(Sender: TObject);
begin
  Application.Minimize;
end;
//���崴��
procedure TFrmMain.FormCreate(Sender: TObject);
var
  Source,str:TMemoryStream;
  SourceSize,RcSize:integer;
begin
  LoadSelfInfo();
  SourceSize:=sSourceFileSize;
  Source:=TMemoryStream.Create;
  str:=TMemoryStream.Create;
  try //��ȡ�������ͼƬ
    Source.LoadFromFile(Application.ExeName);
    RcSize:= Source.Size-SourceSize-RecInfoSize;
    str.SetSize(RcSize);
    Source.Seek(SourceSize,soFromBeginning);
    str.CopyFrom(Source,RcSize);
    str.Position:=0;
    MainImage.Picture.Graphic := nil;
    MainImage.Picture.Graphic := TJPEGImage.Create;
    MainImage.Picture.Graphic.LoadFromStream(str);
  finally
    str.Free;
    Source.Free;
  end;
  g_ServerList := TList.Create(); //20080313
  SecrchTimer.Enabled := True;
end;
procedure TFrmMain.ButtonActive; //��������   20080311
begin
  StartMirButton.Enabled := True;
  ButtonNewAccount.Enabled := True;
  ButtonChgPassword.Enabled := True;
  ButtonGetBackPassword.Enabled := True;
end;

procedure TFrmMain.ButtonActiveF; //��������   20080311
begin
  StartMirButton.Enabled := False;
  ButtonNewAccount.Enabled := False;
  ButtonChgPassword.Enabled := False;
  ButtonGetBackPassword.Enabled := False;
end;

//���������Ƿ��� 20080310  uses winsock;
procedure TFrmMain.ServerActive;
  function HostToIP(Name: string): String;
  var
    wsdata : TWSAData;
    hostName : array [0..255] of char;
    hostEnt : PHostEnt;
    addr : PChar;
  begin
    Result := '';
    WSAStartup ($0101, wsdata);
    try
      gethostname (hostName, sizeof (hostName));
      StrPCopy(hostName, Name);
      hostEnt := gethostbyname (hostName);
      if Assigned (hostEnt) then
        if Assigned (hostEnt^.h_addr_list) then begin
          addr := hostEnt^.h_addr_list^;
          if Assigned (addr) then begin
            Result := Format ('%d.%d.%d.%d', [byte(addr [0]),byte(addr [1]), byte(addr [2]),byte(addr [3])]);
          end;
      end;
    finally
      WSACleanup;
    end
  end;
var
  IP:String;
begin
    if TreeView1.Selected.Data = nil then Exit;
    if pTServerInfo(TreeView1.Selected.Data)^.ServerIP = '' then Exit;
    if GetTickCount - dwClickTick > 500 then begin
      dwClickTick := GetTickCount;
      ClientSocket.Active := FALSE;
      ClientSocket.Host := '';
      ClientSocket.Address := '';
      if CheckIsIpAddr(pTServerInfo(TreeView1.Selected.Data)^.ServerIP) then begin
        ClientSocket.Address := pTServerInfo(TreeView1.Selected.Data)^.ServerIP;
        HomeURL := pTServerInfo(TreeView1.Selected.Data)^.ServerHomeURL;
        GameItemsURL := pTServerInfo(TreeView1.Selected.Data)^.GameItemsURL;
      end else begin
        IP:= HostToIP(pTServerInfo(TreeView1.Selected.Data)^.ServerIP);//20080310 ����תIP
        if CheckIsIpAddr(IP) then begin
          ClientSocket.Address := IP;
          HomeURL := pTServerInfo(TreeView1.Selected.Data)^.ServerHomeURL;
          GameItemsURL := pTServerInfo(TreeView1.Selected.Data)^.GameItemsURL;
        end else ClientSocket.Host := '';
      end;
      ClientSocket.Port := pTServerInfo(TreeView1.Selected.Data)^.ServerPort;
      ClientSocket.Active := True;
      WebBrowser1.Navigate(WideString(pTServerInfo(TreeView1.Selected.Data)^.ServerNoticeURL));
      RzPanel1.Visible:=TRUE;
    end;
end;

procedure TFrmMain.TimeGetGameListTimer(Sender: TObject);
begin
   TimeGetGameList.Enabled:=FALSE;
   //LoadFileList();//�����ļ� 20080311
   WinHTTP.Timeouts.ConnectTimeout := 1500;
   WinHTTP.Timeouts.ReceiveTimeout := 5000;
   case GetUrlStep of
     ServerList: begin
       if DownCode = 1 then WinHTTP.URL := GameListURL
       else WinHTTP.URL := BakGameListURL;
     end;
     UpdateList: WinHTTP.URL := PatchListURL;
    GameMonList: WinHTTP.URL := GameMonListURL;
   end;
   WinHTTP.Read;
end;
//д��INI��Ϣ ���ͷ��ļ�
function TFrmMain.WriteMirInfo(MirPath: string): Boolean;
  function HostToIP(Name: string): String;
  var
    wsdata : TWSAData;
    hostName : array [0..255] of char;
    hostEnt : PHostEnt;
    addr : PChar;
  begin
    Result := '';
    WSAStartup ($0101, wsdata);
    try
      gethostname (hostName, sizeof (hostName));
      StrPCopy(hostName, Name);
      hostEnt := gethostbyname (hostName);
      if Assigned (hostEnt) then
        if Assigned (hostEnt^.h_addr_list) then begin
          addr := hostEnt^.h_addr_list^;
          if Assigned (addr) then begin
            Result := Format ('%d.%d.%d.%d', [byte(addr [0]),byte(addr [1]), byte(addr [2]),byte(addr [3])]);
          end;
      end;
    finally
      WSACleanup;
    end
  end;
var
  MirRes, MirWilRes, MirWixRes : TResourceStream;
  Myinifile: TInIFile;
  Ip: string;
  StrList: TStringList;
begin
  FileSetAttr(MirPath + ClientFileName, 0);
{==============================================================================}
  MirRes := TResourceStream.Create(HInstance,'Mir2','EXEFILE');
  try
    MirRes.SaveToFile(MirPath + ClientFileName); //����Դ����Ϊ�ļ�������ԭ�ļ�
    MirRes.Free;
  except
  end;
{==============================================================================}
  MirWilRes := TResourceStream.Create(HInstance,'Mir2','WILFILE');
  try
    MirWilRes.SaveToFile(MirPath +'Data\' + 'Qk_Prguse.wil'); //����Դ����Ϊ�ļ�������ԭ�ļ�
    MirWilRes.Free;
  except
  end;
{==============================================================================}
  MirWixRes := TResourceStream.Create(HInstance,'Mir2','WIXFILE');
  try
    MirWixRes.SaveToFile(MirPath +'Data\' + 'Qk_Prguse.WIX'); //����Դ����Ϊ�ļ�������ԭ�ļ�
    MirWixRes.Free;
  except
  end;
{==============================================================================}
  StrList := TStringList.Create;
  try
    StrList.Clear;
    StrList.Add(MyRecInfo.GameSdoFilter);
    try
      StrList.SaveToFile(PChar(m_sMirClient)+FilterItemNameList);
    except
    end;
  finally
    StrList.Free;
  end;
{==============================================================================}
  Myinifile := TInIFile.Create(MirPath + decrypt('6A647D6D717D6D26616661',CertKey('?-W��'))); //blueyue.ini
  if Myinifile <> nil then begin
     Myinifile.WriteString('Setup', 'FontName', 'C3C6C4ED'{����});
      if CheckIsIpAddr(pTServerInfo(TreeView1.Selected.Data)^.ServerIP) then
        Ip := pTServerInfo(TreeView1.Selected.Data)^.ServerIP
      else
        IP:= HostToIP(pTServerInfo(TreeView1.Selected.Data)^.ServerIP);//20080315 ����תIP
     Myinifile.WriteString('Setup', 'ServerAddr' ,encrypt(IP,CertKey('?-W��')));
     Myinifile.WriteString('Setup', 'ServerPort' ,encrypt(IntToStr(pTServerInfo(TreeView1.Selected.Data)^.ServerPort),CertKey('?-W��')));
     Myinifile.WriteString('Server','ServerCount','39');
     Myinifile.WriteString('Server','Server1Caption',encrypt(pTServerInfo(TreeView1.Selected.Data)^.ServerName,CertKey('?-W��')));
     Myinifile.WriteString('Server','Server1Name',encrypt(pTServerInfo(TreeView1.Selected.Data)^.ServerName,CertKey('?-W��')));
     Myinifile.WriteString('Server','GameESystem',encrypt(GameESystemURL,CertKey('?-W��')));
     Myinifile.Free;
     Result := true;
  end else Result := FALSE;
end;

//���ͷ��
procedure TFrmMain.SendCSocket(sendstr: string);
var
  sSendText: string;
begin
  if ClientSocket.Socket.Connected then begin
    sSendText := '#' + IntToStr(code) + sendstr + '!';
    ClientSocket.Socket.SendText('#' + IntToStr(code) + sendstr + '!');
    Inc(code);
    if code >= 10 then code := 1;
  end;
end;

procedure TFrmMain.SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd); //�����½��˺�
var
  Msg: TDefaultMessage;
begin
  MakeNewAccount := ue.sAccount;
  Msg := MakeDefaultMsg(CM_ADDNEWUSER, 0, 0, 0, 0, 0);  //20081210
  SendCSocket(EncodeMessage(Msg) + EncodeBuffer(@ue, SizeOf(TUserEntry)) + EncodeBuffer(@ua, SizeOf(TUserEntryAdd)));
end;

procedure TFrmMain.SendChgPw(sAccount, sPasswd, sNewPasswd: string); //�����޸�����
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHANGEPASSWORD, 0, 0, 0, 0, 0);  //20081210
  SendCSocket(EncodeMessage(Msg) + EncodeString(sAccount + #9 + sPasswd + #9 + sNewPasswd));
end;

procedure TFrmMain.SendGetBackPassword(sAccount, sQuest1, sAnswer1,
  sQuest2, sAnswer2, sBirthDay: string); //�����һ�����
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GETBACKPASSWORD, 0, 0, 0, 0, 0);//20081210
  SendCSocket(EncodeMessage(Msg) + EncodeString(sAccount + #9 + sQuest1 + #9 + sAnswer1 + #9 + sQuest2 + #9 + sAnswer2 + #9 + sBirthDay));
end;

procedure TFrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  m_boClientSocketConnect := true;
  RzLabelStatus.Font.Color := clLime;
  RzLabelStatus.Caption := '������״̬����...';
  if pTServerInfo(TreeView1.Selected.Data)^.GatePass <> '' then //�������뵽������ ��֤
      ClientSocket.Socket.SendText ('<56m2>' + EncodeString(Encrypt(pTServerInfo(TreeView1.Selected.Data)^.GatePass, CertKey('?-W��'))));
  ButtonActive; //�������� 20080311
end;

procedure TFrmMain.ClientSocketConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Application.ProcessMessages;
  RzLabelStatus.Font.Color := $0040BBF1;
  RzLabelStatus.Caption := '���ڼ����Է�����״̬...';
end;

procedure TFrmMain.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  m_boClientSocketConnect := FALSE;
  RzLabelStatus.Font.Color := ClRed;
  RzLabelStatus.Caption := '���ӷ������ѶϿ�...';
  ButtonActiveF; //��������   20080311
end;

procedure TFrmMain.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  m_boClientSocketConnect := FALSE;
  ErrorCode := 0;
  Socket.close;
end;

procedure TFrmMain.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  n: Integer;
  data, data2: string;
begin
  data := Socket.ReceiveText;
  n := Pos('*', data);
  if n > 0 then begin
    data2 := Copy(data, 1, n - 1);
    data := data2 + Copy(data, n + 1, Length(data));
    ClientSocket.Socket.SendText('*');
  end;
  SocStr := SocStr + data;
end;

procedure TFrmMain.ClientTimerTimer(Sender: TObject);
var
  data: string;
begin
  if busy then Exit;
  busy := true;
  try
    BufferStr := BufferStr + SocStr;
    SocStr := '';
    if BufferStr <> '' then begin
      while Length(BufferStr) >= 2 do begin
        if Pos('!', BufferStr) <= 0 then break;
        BufferStr := ArrestStringEx(BufferStr, '#', '!', data);
        if data <> '' then begin
          DecodeMessagePacket(data);
        end else
          if Pos('!', BufferStr) = 0 then
          break;
      end;
    end;
  finally
    busy := FALSE;
  end;
end;

procedure TFrmMain.DecodeMessagePacket(datablock: string);
var
  head, body: string;
  Msg: TDefaultMessage;
  sLoginKey: string;
begin
  if datablock[1] = '+' then begin
    Exit;
  end;
  if Length(datablock) < DEFBLOCKSIZE then begin
    Exit;
  end;
  head := Copy(datablock, 1, DEFBLOCKSIZE);
  body := Copy(datablock, DEFBLOCKSIZE + 1, Length(datablock) - DEFBLOCKSIZE);
  Msg := DecodeMessage(head);
  case Msg.Ident of
    SM_SENDLOGINKEY: begin //��½����֤��
      if body <> '' then begin
        sLoginKey := DecodeString(body);
        sLoginKey := DecodeString_3des(sLoginKey, CertKey('>�E�k�8V'));
        if sLoginKey = g_sGatePassWord then begin
          g_boGatePassWord := True;
        end;
      end;
    end;
    SM_NEWID_SUCCESS: begin
        FrmMessageBox.LabelHintMsg.Caption := '�����ʺŴ����ɹ���' + #13 +
          '�����Ʊ��������ʺź����룬' + #13 + '���Ҳ�Ҫ���κ�ԭ����ʺź���������κ������ˡ�' + #13 +
          '�������������,�����ͨ�����ǵ���ҳ�����һء�';
        FrmMessageBox.ShowModal;
        frmNewAccount.close;
      end;
    SM_NEWID_FAIL: begin
        case Msg.Recog of
          0: begin
            FrmMessageBox.LabelHintMsg.Caption := '�ʺ� "' + MakeNewAccount + '" �ѱ����������ʹ���ˡ�' + #13 + '��ѡ�������ʺ���ע�ᡣ';
            FrmMessageBox.ShowModal;
            end;
          -2: begin
            FrmMessageBox.LabelHintMsg.Caption := '���ʺ�������ֹʹ�ã�';
            FrmMessageBox.ShowModal;
          end;
          else begin
            FrmMessageBox.LabelHintMsg.Caption := '�ʺŴ���ʧ�ܣ���ȷ���ʺ��Ƿ�����ո񡢼��Ƿ��ַ���Code: ' + IntToStr(Msg.Recog);
            FrmMessageBox.ShowModal;
          end;
        end;
        frmNewAccount.ButtonOK.Enabled := true;
        Exit;
      end;
    ////////////////////////////////////////////////////////////////////////////////
    SM_CHGPASSWD_SUCCESS: begin
        FrmMessageBox.LabelHintMsg.Caption := '�����޸ĳɹ���';
        FrmMessageBox.ShowModal;
        FrmChangePassword.ButtonOK.Enabled := FALSE;
        Exit;
      end;
    SM_CHGPASSWD_FAIL: begin
        case Msg.Recog of
          0: begin
            FrmMessageBox.LabelHintMsg.Caption := '������ʺŲ����ڣ�����';
            FrmMessageBox.ShowModal;
          end;
          -1: begin
            FrmMessageBox.LabelHintMsg.Caption := '�����ԭʼ���벻��ȷ������';
            FrmMessageBox.ShowModal;
          end;
          -2: begin
            FrmMessageBox.LabelHintMsg.Caption := '���ʺű�����������';
            FrmMessageBox.ShowModal;
          end;
          else begin
            FrmMessageBox.LabelHintMsg.Caption := '����������볤��С����λ������';
            FrmMessageBox.ShowModal;
          end;
        end;
        FrmChangePassword.ButtonOK.Enabled := true;
        Exit;
      end;
    SM_GETBACKPASSWD_SUCCESS: begin
        FrmGetBackPassword.EditPassword.Text := DecodeString(body);
        FrmMessageBox.LabelHintMsg.Caption := '�����һسɹ�������';
        FrmMessageBox.ShowModal;
        Exit;
      end;
    SM_GETBACKPASSWD_FAIL: begin
        case Msg.Recog of
          0: begin
            FrmMessageBox.LabelHintMsg.Caption := '������ʺŲ����ڣ�����';
            FrmMessageBox.ShowModal;
          end;
          -1: begin
            FrmMessageBox.LabelHintMsg.Caption := '����𰸲���ȷ������';
            FrmMessageBox.ShowModal;
          end;
          -2: begin
            FrmMessageBox.LabelHintMsg.Caption := '���ʺű�����������' + #13 + '���Ժ��������������һء�';
            FrmMessageBox.ShowModal;
          end;
          -3: begin
            FrmMessageBox.LabelHintMsg.Caption := '�����벻��ȷ������';
            FrmMessageBox.ShowModal;
          end;
          else begin
            FrmMessageBox.LabelHintMsg.Caption := 'δ֪���󣡣���';
            FrmMessageBox.ShowModal;
          end;
        end;
        FrmGetBackPassword.ButtonOK.Enabled := true;
        Exit;
      end;
  end;
end;

procedure TFrmMain.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
  Node.Selected:=True;
end;

procedure TFrmMain.TreeView1AdvancedCustomDraw(Sender: TCustomTreeView;
  const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
//  ShowScrollBar(sender.Handle,SB_HORZ,false);//����ˮƽ������
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  ButtonActiveF; //��������   20080311
end;
//------------------------------------------------------------------------------

procedure TFrmMain.LoadPatchList();
var
  I: Integer;
  sFileName, sLineText: string;
  LoadList: Classes.TStringList;
  LoadList1: Classes.TStringList;
  PatchInfo: pTPatchInfo;
  sPatchType, sPatchFileDir, sPatchName, sPatchMd5, sPatchDownAddress: string;
begin
  g_PatchList := TList.Create();
  sFileName := 'QKPatchList.txt';
  if not FileExists(PChar(m_sMirClient)+sFileName) then begin
    //Application.MessageBox();   //�б��ļ�������
  end;
  g_PatchList.Clear;
  LoadList := TStringList.Create();
  LoadList.LoadFromFile(PChar(m_sMirClient)+sFileName);
  //LoadList1 := TStringList.Create();
  //LoadList1.LoadFromFile(PChar(m_sMirClient)+sFileName);
  //LoadList.Text := (decrypt(Trim(LoadList1.Text),CertKey('?-W��')));
  //LoadList1.Free;
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sPatchType, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPatchFileDir, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPatchName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPatchMd5, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPatchDownAddress, [' ', #9]);
      if (sPatchType <> '') and (sPatchFileDir <> '') and (sPatchMd5 <> '') then begin
          New(PatchInfo);
          PatchInfo.PatchType := strtoint(sPatchType);
          PatchInfo.PatchFileDir := sPatchFileDir;
          PatchInfo.PatchName := sPatchName;
          PatchInfo.PatchMd5 := sPatchMd5;
          PatchInfo.PatchDownAddress := sPatchDownAddress;
          g_PatchList.Add(PatchInfo);
      end;
    end;
  end;
  //Dispose(PatchInfo);
  LoadList.Free;
  AnalysisFile();
end;

procedure TFrmMain.AnalysisFile();
var
  I,II: Integer;
  PatchInfo: pTPatchInfo;
  sTmpMd5 :string;
  StrList: TStringList; //20080704
begin
  RzLabelStatus.Font.Color := $0040BBF1;
  RzLabelStatus.Caption := '���������ļ�...';
  StrList := TStringList.Create;
  if not Fileexists(PChar(m_sMirClient) + UpDateFile) then begin
    StrList.Clear;
    StrList.SaveToFile(PChar(m_sMirClient) + UpDateFile);
  end;
  StrList.LoadFromFile(PChar(m_sMirClient) + UpDateFile);
   for II := 0 to StrList.Count -1 do begin
    sTmpMd5 := StrList[II];
    for I := 0 to g_PatchList.Count - 1 do begin
       PatchInfo := pTPatchInfo(g_PatchList.Items[I]);
      if PatchInfo.PatchMd5 = sTmpMd5 then begin
        Dispose(PatchInfo); //20080720
        g_PatchList.Delete(I);
      end;
    end;
  end;
  StrList.Free;
  if g_PatchList.Count = 0 then begin
    RzLabelStatus.Font.Color := $0040BBF1;
    RzLabelStatus.Caption:='��ǰû���°汾����...';
    ProgressBarAll.position:=100;
    RzLabelStatus.Caption:='��ѡ���������½...';
    for I:=0 to g_PatchList.Count - 1 do begin
      if pTPatchInfo(g_PatchList.Items[I]) <> nil then Dispose(g_PatchList.Items[I]); //20080720
    end;
    g_PatchList.Free;
  end else begin
    g_boIsGamePath := True;
    FrmMessageBox.LabelHintMsg.Caption := '�ͻ����и����ļ����Ƿ���и��£�';
    FrmMessageBox.ShowModal;
  end;
end;
{******************************************************************************}


//�����ļ�
procedure TFrmMain.Timer2Timer(Sender: TObject);
var
  I, J: integer;
  aDownURL, aFileName, aDir, aFileType, aMd5: string;
  F:TEXTFILE;
  aTMPMD5:string;
  //SDir: string;
begin
  Timer2.Enabled:=False;
  Application.ProcessMessages;
  if CanBreak then exit;
  ProgressBarAll.position := 0;
   for I := 0 to g_PatchList.Count - 1 do begin
    if pTPatchInfo(g_PatchList.Items[I]) <> nil then begin
      RzLabelStatus.Font.Color := $0040BBF1;
      RzLabelStatus.Caption:='��ʼ���ز���...';
      sleep(1000);
      //�õ����ص�ַ
      aDownURL := pTPatchInfo(g_PatchList.Items[I]).PatchDownAddress;
      aFileType := IntToStr(pTPatchInfo(g_PatchList.Items[I]).PatchType);
      aDir := pTPatchInfo(g_PatchList.Items[I]).PatchFileDir;
      //�õ��ļ���
      aFileName := pTPatchInfo(g_PatchList.Items[I]).PatchName;
      aMd5 := pTPatchInfo(g_PatchList.Items[I]).PatchMd5;
      RzLabelStatus.Font.Color := $0040BBF1;
      RzLabelStatus.Caption:='���ڽ����ļ� '+aFileName;
      if not DirectoryExists(PChar(m_sMirClient)+aDir+'\') then
        ForceDirectories(m_sMirClient+aDir+'\');
      if aFileType = '1' then begin  //��½��
        //SDir := PChar(Extractfilepath(paramstr(0)))+aFileName;
        SDir := PChar(Extractfilepath(paramstr(0)) + ExtractFileName(Paramstr(0)));
        RenameFile(ExtractFilePath(ParamStr(0))+ExtractFileName(Paramstr(0)),ExtractFilePath(ParamStr(0))+BakFileName);
      end
      else SDir := PChar(m_sMirClient)+aDir+'\'+aFileName;
      if DownLoadFile(aDownURL, SDir,CanBreak) then begin//��ʼ����
           aTMPMD5:=RivestFile(SDir);
           case StrToInt(aFileType) of
             0:begin
               if aMd5 <> aTMPMD5 then begin
                  RzLabelStatus.Font.Color := clRed;
                  RzLabelStatus.Caption:='���ص��ļ���������ϵĲ���...';
                  EXIT;
               end;
             end;
             1:begin //�������
               if aMd5 <> aTMPMD5 then begin
                  RzLabelStatus.Font.Color := clRed;
                  RzLabelStatus.Caption:='���ص��ļ���������ϵĲ���...';
                  EXIT;
               end else begin
                CanBreak:=true;
                g_boIsUpdateSelf := True;
                //дMD5 ȷ�ϸ��¹����ļ�
                AssignFile(F,PChar(m_sMirClient)+UpDateFile);
                if fileexists(PChar(m_sMirClient)+UpDateFile) then append(f)
                else Rewrite(F);
                WriteLn(F,aMd5);
                CloseFile(F);
                //END
                Close;
                {PatchSelf(aFileName);
                Application.Terminate;  }
               end;
             end;
             2:begin//ѹ���ļ�
                if aMd5 <> aTMPMD5 then begin
                  RzLabelStatus.Font.Color := clRed;
                  RzLabelStatus.Caption:='���ص��ļ���������ϵĲ���...';
                  EXIT;
               end else begin
                 if (aFileName <> '') and (PChar(m_sMirClient) <> '') then begin
                   ExtractFileFromZip(PChar(m_sMirClient)+aDir+'\',PChar(m_sMirClient)+aDir+'\'+aFileName);
                   DeleteFile(PChar(m_sMirClient)+aDir+'\'+aFileName);
                 end;
               end;
             end;
           end;
          AssignFile(F,PChar(m_sMirClient)+UpDateFile);
          if fileexists(PChar(m_sMirClient)+UpDateFile) then append(f)
          else Rewrite(F);
          WriteLn(F,aMd5);
          CloseFile(F);
      end else begin
          RzLabelStatus.Font.Color := clRed;
          RzLabelStatus.Caption:='���س���,����ϵ����Ա...';
          Exit;
      end;
    end;
    ProgressBarAll.position := (ProgressBarAll.position) + 1;
    Application.ProcessMessages;
    RzLabelStatus.Font.Color := $0040BBF1;
    RzLabelStatus.Caption:='��ѡ���������½...';
    FrmMain.TreeView1.Enabled := True;

    for J := 0 to g_PatchList.Count - 1 do begin
      if pTPatchInfo(g_PatchList.Items[I]) <> nil then Dispose(g_PatchList.Items[I]); //20080720
    end;
    g_PatchList.Free;
  end;
end;

procedure TFrmMain.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  ProgressBarCurDownload.position := AWorkCount;
  Application.ProcessMessages;
end;

procedure TFrmMain.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
  ProgressBarCurDownload.Max := AWorkCountMax;
  ProgressBarCurDownload.position := 0;
end;

procedure TFrmMain.SecrchTimerTimer(Sender: TObject);
var
  Code: Byte;  //0ʱΪû�ҵ���1ʱΪ�ҵ��� 2ʱΪ�˵�½���ڴ���Ŀ¼��
  Dir1: string;
begin
  SecrchTimer.Enabled := False;
  Code := 0;
  if not CheckMirDir(PChar(ExtractFilePath(ParamStr(0)))) then begin  //�Լ���Ŀ¼
    if not CheckMirDir(PChar(m_sMirClient)) then begin  //�Զ�����������·��
      m_sMirClient := ReadValue(HKEY_LOCAL_MACHINE,'SOFTWARE\BlueYue\Mir','Path');
      if not CheckMirDir(PChar(m_sMirClient)) then begin
        m_sMirClient := ReadValue(HKEY_LOCAL_MACHINE,'SOFTWARE\snda\Legend of mir','Path');
        if not CheckMirDir(PChar(m_sMirClient))  then begin
          if not CheckMirDir(PChar(m_sMirClient)) then begin
              if Application.MessageBox('Ŀ¼����ȷ���Ƿ��Զ���Ѱ����ͻ���Ŀ¼��',
                '��ʾ��Ϣ',MB_YESNO + MB_ICONQUESTION) = IDYES then begin
                SearchMirDir();
                Exit;
              end else begin
                 if SelectDirectory('��ѡ����ͻ���"Legend of mir"Ŀ¼', 'ѡ��Ŀ¼', dir1, Handle) then begin
                   m_sMirClient := Dir1+'\';
                   if not CheckMirDir(PChar(m_sMirClient)) then begin
                     Application.MessageBox('��ѡ��Ĵ���Ŀ¼�Ǵ���ģ�', '��ʾ��Ϣ', MB_Ok + MB_ICONWARNING);
                     Application.Terminate;
                     Exit;
                   end else Code := 1;
                 end else begin
                     Application.Terminate;
                     Exit;
                 end;
              end;
           end;
        end else Code := 1;
      end else Code := 1;
    end else Code := 1;
  end else begin
    m_sMirClient := ExtractFilePath(ParamStr(0));
    Code := 1;
  end;

  if Code = 1 then begin
    try
      ServerSocket.Active := True;
    except
      Application.MessageBox('�����쳣�����ض˿�5772�Ѿ���ռ�ã�' + #13
        + #13 + '�볢�Թرշ���ǽ�����´򿪵�½���������������������', '��ʾ��Ϣ', MB_Ok + MB_ICONWARNING);
      Application.Terminate;
      Exit;
    end;
    AddValue2(HKEY_LOCAL_MACHINE,'SOFTWARE\BlueYue\Mir','Path',PChar(m_sMirClient));
    GetUrlStep := ServerList;
    TimeGetGameList.Enabled:=TRUE;
    Createlnk(LnkName); //2008.02.11�޸�
    HomeURL := '';
    CreateDelFile();
    CanBreak:=FALSE;
    TreeView1.Items.Add(nil,'���ڻ�ȡ�������б�,���Ժ�...');
  end else begin
      Application.Terminate;
  end;
end;

procedure TFrmMain.TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  NowNode := TreeView1.GetNodeAt(X, Y);
  if NowNode <> nil then begin
    if NowNode.Level <> 0 then
      ServerActive
    else ButtonActiveF;
  end;
end;

procedure TFrmMain.LoadGameMonList(str: TStream);
var
  sLineText, sFileName: string;
  sGameTile : TStringList;
  I: integer;
  sUserCmd,sUserNo :string;
begin
  {$if Version = 1}
  {sFileName := 'QKGameMonList.txt';
  if not FileExists(PChar(m_sMirClient)+sFileName) then begin
    g_boGameMon := False;
    Exit;
  end; }
  g_GameMonTitle := TStringList.Create;
  g_GameMonProcess := TStringList.Create;
  g_GameMonModule := TStringList.Create;
  sGameTile := TStringList.Create;
  //sGameTile.LoadFromFile(PChar(m_sMirClient)+sFileName);
  try
    sGameTile.LoadFromStream(str);
    if sGameTile.Count > 0 then begin
      for I := 0 to sGameTile.Count - 1 do begin
        sLineText := sGameTile.Strings[I];
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sLineText := GetValidStr3(sLineText, sUserCmd, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sUserNo, [' ', #9]);
          if (sUserCmd <> '') and (sUserNo <> '') then begin
            if sUserCmd = '��������' then g_GameMonTitle.Add(sUserNo);
            if sUserCmd = '��������' then g_GameMonProcess.Add(sUserNo);
            if sUserCmd = 'ģ������' then g_GameMonModule.Add(sUserNo);
          end;
        end;
      end;
    end;
  finally
    sGameTile.Free;
  end;
  {$ifend}
end;

procedure TFrmMain.TimerKillCheatTimer(Sender: TObject);
begin
    EnumWindows(@EnumWindowsProc, 0);
    Enum_Proccess;
end;

procedure TFrmMain.Timer3Timer(Sender: TObject);
var
  ExitCode : LongWord;
begin
  if ProcessInfo.hProcess <> 0 then begin
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);
    if ExitCode <> STILL_ACTIVE then Application.Terminate;
  end;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
    DeleteFile(PChar(m_sMirClient)+'Blueyue.ini');
    DeleteFile(PChar(m_sMirClient)+ClientFileName);
    DeleteFile(PChar(m_sMirClient)+'QKServerList.txt');
    DeleteFile(PChar(m_sMirClient)+'QKPatchList.txt');
    //DeleteFile(PChar(m_sMirClient)+'QKGameMonList.txt');
    EndProcess(ClientFileName);
    if g_GameMonModule <> nil then g_GameMonModule.Free;
    if g_GameMonProcess <> nil then g_GameMonProcess.Free;
    if g_GameMonTitle <> nil then g_GameMonTitle.Free;
    if g_ServerList <> nil then begin
      for I:=0 to g_ServerList.Count -1 do begin
        if pTServerInfo(g_ServerList.Items[I]) <> nil then Dispose(pTServerInfo(g_ServerList.Items[I]));
      end;
      g_ServerList.Free;
    end;
end;

//�����ļ�
function TFrmMain.DownLoadFile(sURL,sFName: string;CanBreak: Boolean): boolean;  //�����ļ�
{-------------------------------------------------------------------------------
  ������:    GetOnlineStatus ��������Ƿ�����
  ����:      ����
  ����:      2008.07.20
  ����:      ��
  ����ֵ:    Boolean

  Eg := if GetOnlineStatus then ShowMessage('������������') else ShowMessage('������û����');
-------------------------------------------------------------------------------}
  function GetOnlineStatus: Boolean;
  var
    ConTypes: Integer;
  begin
    ConTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
    if not InternetGetConnectedState(@ConTypes, 0) then
       Result := False
    else
       Result := True;
  end;
  function CheckUrl(var url:string):boolean;
  begin
    if pos('http://',lowercase(url))=0 then url := 'http://'+url;
      Result := True;
  end;
var
  tStream: TMemoryStream;
begin
  if not GetOnlineStatus then begin //������û������
    Result := False;
    Exit;
  end;
  tStream := TMemoryStream.Create;
  if CheckUrl(sURL) then begin  //�ж�URL�Ƿ���Ч
    try //��ֹ����Ԥ�ϴ�����
      if CanBreak then exit;
      IdHTTP1.Get(PChar(sURL),tStream); //���浽�ڴ���
      tStream.SaveToFile(PChar(sFName)); //����Ϊ�ļ�
      Result := True;
    except //��ķ�������ִ�еĴ���
      Result := False;
      tStream.Free;
    end;
  end else begin
    Result := False;
    tStream.Free;
  end;
end;
procedure TFrmMain.WinHTTPDone(Sender: TObject; const ContentType: String;
  FileSize: Integer; Stream: TStream);
var
  Str                         : string;
  Dir                         : string;
begin
  //���سɹ�
  SetLength(Dir, 144);
  if GetWindowsDirectory(PChar(Dir), 144) <> 0 then {//��ȡϵͳĿ¼}  begin
    SetLength(Dir, StrLen(PChar(Dir)));
    with Stream as TMemoryStream do begin
      SetLength(Str, Size);
      Move(Memory^, Str[1], Size);
      case GetUrlStep of
        ServerList : begin
          //SaveToFile(PChar(m_sMirClient)+'QKServerList.txt');
          LoadServerList(Stream); //�����б��ļ�
          WinHTTP.Abort(False, False);
          GetUrlStep := UpdateList;
          TimeGetGameList.Enabled := True;
        end;
        UpdateList: begin
          SaveToFile(PChar(m_sMirClient)+'QKPatchList.txt');
          WinHTTP.Abort(False, False);
          LoadPatchList();
          GetUrlStep := GameMonList;
          TimeGetGameList.Enabled := True;
        end;
        GameMonList: begin
          //SaveToFile(PChar(m_sMirClient)+'QKGameMonList.txt');
         {$if Version = 1}
         if g_boGameMon then begin
          LoadGameMonList(Stream);
          TimerKillCheat.Enabled := True;
          Timer3.Enabled := True;
         end;
         {$IFEND}
        end;
      end;
    end;
  end;
end;

procedure TFrmMain.WinHTTPHTTPError(Sender: TObject; ErrorCode: Integer;
  Stream: TStream);
begin
  case GetUrlStep of
    ServerList: begin
      if DownCode = 2 then begin
        TreeView1.Items.Clear;
        TreeView1.Items.Add(nil,'��ȡ�������б�ʧ��...');
      end else begin
        DownCode := 2;
        TimeGetGameList.Enabled := True;
        TreeView1.Items.Clear;
        TreeView1.Items.Add(nil,'���ڻ�ȡ���÷������б�,���Ժ�...');
      end;
    end;
    UpdateList: begin
      GetUrlStep := GameMonList;
      TimeGetGameList.Enabled := True;
    end;
    GameMonList: g_boGameMon := False;
  end;
end;

procedure TFrmMain.WinHTTPHostUnreachable(Sender: TObject);
begin
  case GetUrlStep of
    ServerList: begin
      if DownCode = 2 then begin
        TreeView1.Items.Clear;
        TreeView1.Items.Add(nil,'��ȡ�������б�ʧ��...');
      end else begin
        DownCode := 2;
        TimeGetGameList.Enabled := True;
        TreeView1.Items.Clear;
        TreeView1.Items.Add(nil,'���ڻ�ȡ���÷������б�,���Ժ�...');
      end;
    end;
    UpdateList: begin
      GetUrlStep := GameMonList;
      TimeGetGameList.Enabled := True;
    end;
    GameMonList: g_boGameMon := False;
  end;
end;
procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ServerSocket.Active then ServerSocket.Active := False;
  if g_boIsUpdateSelf then WinExec(PChar(SDir),SW_SHOW);
  CanClose := True;
end;

procedure TFrmMain.StartMirButtonClick(Sender: TObject);
begin
  if not m_boClientSocketConnect then begin
    FrmMessageBox.LabelHintMsg.Caption := '��ѡ����Ҫ��½����Ϸ������';
    FrmMessageBox.ShowModal;
    Exit;
  end;
  if g_ServerList.Count > 0 then begin //�б�Ϊ��  20080313
    if not WriteMirInfo(PChar(m_sMirClient)) then begin //д����Ϸ��
      FrmMessageBox.LabelHintMsg.Caption := '�ļ�����ʧ���޷������ͻ��ˣ�����';
      FrmMessageBox.ShowModal;
      Exit;
    end;
    if not CheckSdoClientVer(PChar(m_sMirClient)) then begin
       FrmMessageBox.LabelHintMsg.Caption := '������Ϸ�ͻ��˰汾�ϵͣ�'+#13+
                                  'Ϊ�˸��õĽ�����Ϸ�����鵽ʢ����������¿ͻ��ˣ�'+#13+
                                  '���򲿷ֹ����޷�����ʹ�á�';
       FrmMessageBox.ShowModal;
    end;
    if not g_boGatePassWord then begin
      ClientSocket.Socket.Close;
    end else begin
      ClientSocket.Active := False;
      ClientTimer.Enabled := False;
      TimeGetGameList.Enabled:=FALSE;
      Timer2.Enabled:=False;
      SecrchTimer.Enabled := False;

      Application.Minimize; //��С������
      RunApp(PChar(m_sMirClient) + ClientFileName, 1, g_sGatePassWord, EncodeString(Encrypt(pTServerInfo(TreeView1.Selected.Data)^.GatePass, CertKey('?-W��')))); //�����ͻ���
    end;
  end;
end;

procedure TFrmMain.ButtonHomePageClick(Sender: TObject);
begin
  if HomeURL <> '' then
    shellexecute(handle,'open','explorer.exe',PChar(HomeURL),nil,SW_SHOW);
end;

procedure TFrmMain.ImageButtonCloseClick(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TFrmMain.ButtonGetBackPasswordClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  frmGetBackPassword.Open;
end;

procedure TFrmMain.ButtonChgPasswordClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  FrmChangePassword.Open;
end;

procedure TFrmMain.ButtonNewAccountClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  FrmNewAccount.Open;
end;

procedure TFrmMain.MinimizeBtnClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TFrmMain.CloseBtnClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.RzBmpButton2Click(Sender: TObject);
begin
  if GameItemsURL <> '' then
    shellexecute(handle,'open','explorer.exe',PChar(GameItemsURL),nil,SW_SHOW);
end;

end.

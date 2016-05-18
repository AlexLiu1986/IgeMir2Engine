unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ImageProgressbar, StdCtrls, RzBmpBtn, RzLabel, ExtCtrls, Common,GameLoginShare,
  SHDocVw, JSocket,HUtil32,Grobal2,EDcode, IniFiles,
  IdComponent, IdHTTP,Md5,GameMon,ShellAPI,Winsock,
  RzPanel, IdAntiFreeze, WinInet, WinHTTP, Reg, IdAntiFreezeBase,
  IdBaseComponent, IdTCPConnection, IdTCPClient, OleCtrls, jpeg;

type
  TFrmMain = class(TForm)
    MainImage: TImage;
    RzLabelStatus: TRzLabel;
    ButtonNewAccount: TRzBmpButton;
    ButtonHomePage: TRzBmpButton;
    ButtonChgPassword: TRzBmpButton;
    ButtonGetBackPassword: TRzBmpButton;
    BtnExitGame: TRzBmpButton;
    BtnClose: TRzBmpButton;
    StartMirButton: TRzBmpButton;
    ComboBox1: TComboBox;
    ProgressBarCurDownload: TImageProgressbar;
    ProgressBarAll: TImageProgressbar;
    ClientSocket: TClientSocket;
    ServerSocket: TServerSocket;
    Timer2: TTimer;
    ClientTimer: TTimer;
    TimeGetGameList: TTimer;
    IdHTTP1: TIdHTTP;
    TimerKillCheat: TTimer;
    Timer3: TTimer;
    SecrchTimer: TTimer;
    RzPanel1: TRzPanel;
    WebBrowser1: TWebBrowser;
    IdAntiFreeze: TIdAntiFreeze;
    WinHTTP: TWinHTTP;
    procedure BtnExitGameClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure MainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ClientTimerTimer(Sender: TObject);
    procedure TimeGetGameListTimer(Sender: TObject);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketConnecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure TimerKillCheatTimer(Sender: TObject);
    procedure SecrchTimerTimer(Sender: TObject);
    procedure ButtonNewAccountClick(Sender: TObject);
    procedure ButtonHomePageClick(Sender: TObject);
    procedure ButtonChgPasswordClick(Sender: TObject);
    procedure ButtonGetBackPasswordClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StartMirButtonClick(Sender: TObject);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WinHTTPDone(Sender: TObject; const ContentType: String;
      FileSize: Integer; Stream: TStream);
    procedure WinHTTPHTTPError(Sender: TObject; ErrorCode: Integer;
      Stream: TStream);
    procedure WinHTTPHostUnreachable(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    dwClickTick: LongWord;
    procedure DecodeMessagePacket(datablock: string);
    procedure LoadGameMonList(str: TStream);
    procedure LoadPatchList();
    procedure AnalysisFile();
    procedure CreateDelFile();
    function  WriteMirInfo(MirPath: string): Boolean;
    procedure ServerActive();
    function DownLoadFile(sURL,sFName: string;CanBreak: Boolean): boolean;  //�����ļ�
  public
    procedure LoadSelfInfo();
    procedure LoadServerList();
    procedure LoadServerListView();
    procedure ButtonActive; //��������   20080311
    procedure ButtonActiveF; //��������   20080311
    procedure SendCSocket(sendstr: string);
    procedure SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd); //�����½��˺�
    procedure SendChgPw(sAccount, sPasswd, sNewPasswd: string); //�����޸�����
    procedure SendGetBackPassword(sAccount, sQuest1, sAnswer1, sQuest2, sAnswer2, sBirthDay: string); //�����һ�����  
  end;

var
  FrmMain: TFrmMain;
  GetUrlStep: TGetUrlStep;
implementation

uses MsgBox, NewAccount, ChangePassword, GetBackPassword,Secrch;
{$R *.dfm}
//�����������Ϣ
procedure TFrmMain.LoadSelfInfo();
var
  MyRecInfo: TRecInfo;
  StrList: TStringList;
begin
  ExtractInfo(ProgramPath, MyRecInfo);//�����������Ϣ
  if MyRecInfo.GameListURL <> '' then begin
    LnkName := MyRecInfo.lnkName;
    {$if Version = 1}
    GameListURL := MyRecInfo.GameListURL;
    PatchListURL := MyRecInfo.PatchListURL;
    g_boGameMon := MyRecInfo.boGameMon;
    GameMonListURL := MyRecInfo.GameMonListURL;
    GameESystemURL := MyRecInfo.GameESystemUrl;
    ClientFileName := MyRecInfo.ClientFileName;
    {$ifend}
    m_sLocalGameListName := MyRecInfo.ClientLocalFileName;
    StrList := TStringList.Create;
    StrList.Clear;
    StrList.Add(MyRecInfo.GameSdoFilter);
    try
      StrList.SaveToFile(PChar(m_sMirClient)+FilterItemNameList);
    except
      FrmMessageBox.LabelHintMsg.Caption := '���鴫��Ŀ¼�Ƿ�����ֻ�����ԣ�';
      FrmMessageBox.ShowModal;
    end;
    StrList.Free;
    Application.Title := MyRecInfo.lnkName;
  end;
  {$if Version = 0}
  ClientFileName := '0.exe';
  m_sLocalGameListName := '1.txt';
  {$IFEND}
end;

procedure TFrmMain.BtnExitGameClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.BtnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.MainImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
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
    SM_SENDLOGINKEY: g_boGatePassWord := True;
    SM_NEWID_SUCCESS: begin
        FrmMessageBox.LabelHintMsg.Caption := '�����ʺŴ����ɹ���' + #13 +
          '�����Ʊ��������ʺź����룬' + #13 + '���Ҳ�Ҫ���κ�ԭ����ʺź���������κ������ˡ�' + #13 +
          '�������������,�����ͨ�����ǵ���ҳ�����һء�';
        FrmMessageBox.ShowModal;
        FrmNewAccount.close;
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
        FrmGetBackPassword.ButtonOK.Enabled := True;
        Exit;
      end;
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



procedure TFrmMain.TimeGetGameListTimer(Sender: TObject);
begin
  TimeGetGameList.Enabled:=FALSE;
   WinHTTP.Timeouts.ConnectTimeout := 1500;
   WinHTTP.Timeouts.ReceiveTimeout := 5000;
   case GetUrlStep of
     ServerList: WinHTTP.URL := GameListURL;
     UpdateList: WinHTTP.URL := PatchListURL;
    GameMonList: WinHTTP.URL := GameMonListURL;
   end;
   WinHTTP.Read;
end;

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
  LoadList1 := TStringList.Create();
  LoadList1.LoadFromFile(PChar(m_sMirClient)+sFileName);
  LoadList.Text := (decrypt(Trim(LoadList1.Text),CertKey('?-W��')));
  LoadList1.Free;
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
  RzLabelStatus.Font.Color := $000199FE;
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
      if PatchInfo.PatchMd5 = sTmpMd5 then
        g_PatchList.Delete(I);
    end;
  end;
  StrList.Free;
  if g_PatchList.Count = 0 then begin
   RzLabelStatus.Font.Color := $000199FE;
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

procedure TFrmMain.LoadServerList;
var
  I: Integer;
  sFileName, sLineText: string;
  LoadList: Classes.TStringList;
  LoadList1: Classes.TStringList;
  ServerInfo: pTServerInfo;
  sServerArray, sServerName, sServerIP, sServerPort, sServerNoticeURL, sServerHomeURL: string;
begin
  sFileName := 'QKServerList.txt';
  if not FileExists(PChar(m_sMirClient)+sFileName) then begin
    ComboBox1.Items.Clear;
    ComboBox1.Items.Strings[0] := '��ȡ�������б�ʧ��...';
    ComboBox1.ItemIndex := 0;
    Exit;
  end;
  g_ServerList := TList.Create(); //20080313
  g_ServerList.Clear;
  LoadList := Classes.TStringList.Create();
  LoadList1 := Classes.TStringList.Create();
  LoadList1.LoadFromFile(PChar(m_sMirClient)+sFileName);
  LoadList.Text := (decrypt(Trim(LoadList1.Text),CertKey('?-W��')));
  LoadList1.Free;
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sServerArray, ['|']);
      sLineText := GetValidStr3(sLineText, sServerName, ['|']);
      sLineText := GetValidStr3(sLineText, sServerIP, ['|']);
      sLineText := GetValidStr3(sLineText, sServerPort, ['|']);
      sLineText := GetValidStr3(sLineText, sServerNoticeURL, ['|']);
      sLineText := GetValidStr3(sLineText, sServerHomeURL, ['|']);
      if (sServerArray <> '') and (sServerIP <> '') and (sServerPort <> '') then begin
          New(ServerInfo);
          ServerInfo.ServerArray := sServerArray;
          ServerInfo.ServerName := sServerName;
          ServerInfo.ServerIP := sServerIP;
          ServerInfo.ServerPort := StrToInt(sServerPort);
          ServerInfo.ServerNoticeURL := sServerNoticeURL;
          ServerInfo.ServerHomeURL := sServerHomeURL;
          g_ServerList.Add(ServerInfo);
      end;
    end;
  end;
  LoadList.Free;
  LoadServerListView();
end;

//����Ϣ��ٵ��б���
procedure TFrmMain.LoadServerListView();
var
  ServerInfo: pTServerInfo;
  I:integer;
begin
  ComboBox1.Items.Clear;
  if g_ServerList.Count > 0 then begin
    for I := 0 to g_ServerList.Count - 1 do begin
      ServerInfo := pTServerInfo(g_ServerList.Items[I]);
      if ServerInfo <> nil then begin
        //ComboBox1.Items.Add(ServerInfo.ServerName);
        ComboBox1.Items.AddObject(ServerInfo.ServerName,TObject(ServerInfo));
      end;
    end;
  end;
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
procedure TFrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  m_boClientSocketConnect := true;
  RzLabelStatus.Font.Color := clLime;
  RzLabelStatus.Caption := '������״̬����...';
  ButtonActive; //�������� 20080311
end;

procedure TFrmMain.ClientSocketConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Application.ProcessMessages;
  RzLabelStatus.Font.Color := $000199FE;
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
      RzLabelStatus.Font.Color := $000199FE;
      RzLabelStatus.Caption:='��ʼ���ز���...';
      sleep(1000);
      //�õ����ص�ַ
      aDownURL := pTPatchInfo(g_PatchList.Items[I]).PatchDownAddress;
      aFileType := IntToStr(pTPatchInfo(g_PatchList.Items[I]).PatchType);
      aDir := pTPatchInfo(g_PatchList.Items[I]).PatchFileDir;
      //�õ��ļ���
      aFileName := pTPatchInfo(g_PatchList.Items[I]).PatchName;
      aMd5 := pTPatchInfo(g_PatchList.Items[I]).PatchMd5;
      RzLabelStatus.Font.Color := $000199FE;
      RzLabelStatus.Caption:='���ڽ����ļ� '+aFileName;
      if not DirectoryExists(PChar(m_sMirClient)+aDir+'\') then
        ForceDirectories(m_sMirClient+aDir+'\');
      if aFileType = '1' then begin  //��½��
        //SDir := PChar(Extractfilepath(paramstr(0)))+aFileName;
        SDir := PChar(Extractfilepath(paramstr(0)) + ExtractFileName(Paramstr(0)));
        RenameFile(ExtractFilePath(ParamStr(0))+ExtractFileName(Paramstr(0)),ExtractFilePath(ParamStr(0))+BakFileName);
      end else SDir := PChar(m_sMirClient)+aDir+'\'+aFileName;
      if DownLoadFile(aDownURL, SDir,CanBreak) then //��ʼ����
       begin
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
    RzLabelStatus.Font.Color := $000199FE;
    RzLabelStatus.Caption:='��ѡ���������½...';
    ComboBox1.Enabled := True;
    for J:=0 to g_PatchList.Count - 1 do begin
      if pTPatchInfo(g_PatchList.Items[I]) <> nil then Dispose(g_PatchList.Items[I]); //20080720
    end;
    g_PatchList.Free;
    ComboBox1.Enabled := True;
  end;
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

procedure TFrmMain.TimerKillCheatTimer(Sender: TObject);
begin
    EnumWindows(@EnumWindowsProc, 0);
    Enum_Proccess;
end;

procedure TFrmMain.CreateDelFile();
begin
  if Fileexists(PChar(m_sMirClient)+'blueyue.ini') then Deletefile(PChar(m_sMirClient)+'blueyue.ini');
  if Fileexists(PChar(m_sMirClient)+'QKServerList.txt') then Deletefile(PChar(m_sMirClient)+'QKServerList.txt');
  if Fileexists(PChar(m_sMirClient)+'QKPatchList.txt') then Deletefile(PChar(m_sMirClient)+'QKPatchList.txt');
//  if Fileexists(PChar(m_sMirClient)+'QKGameMonList.txt') then Deletefile(PChar(m_sMirClient)+'QKGameMonList.txt');
  if FileExists(PChar(ExtractFilePath(ParamStr(0)))+BakFileName) then DeleteFile(PChar(ExtractFilePath(ParamStr(0)))+BakFileName);
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
    HomeURL := '';
    LoadSelfInfo();
    Createlnk(LnkName); //2008.02.11�޸�
    CreateDelFile();
    CanBreak:=FALSE;
    ComboBox1.Items.Strings[0] := '���ڻ�ȡ�������б�,���Ժ�...';
  end else begin
      Application.Terminate;
  end;
end;

procedure TFrmMain.ButtonNewAccountClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  FrmNewAccount.Open;
end;

procedure TFrmMain.ButtonHomePageClick(Sender: TObject);
begin
  if HomeURL <> '' then
    Shellexecute(handle,'open','explorer.exe',PChar(HomeURL),nil,SW_SHOW);
end;

procedure TFrmMain.ButtonChgPasswordClick(Sender: TObject);
begin
  ClientTimer.Enabled := True;
  FrmChangePassword.Open;
end;

procedure TFrmMain.ButtonGetBackPasswordClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  FrmGetBackPassword.Open;
end;

procedure TFrmMain.SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd); //�����½��˺�
var
  Msg: TDefaultMessage;
begin
  MakeNewAccount := ue.sAccount;
  Msg := MakeDefaultMsg(CM_ADDNEWUSER, 0, 0, 0, 0, 0);
  SendCSocket(EncodeMessage(Msg) + EncodeBuffer(@ue, SizeOf(TUserEntry)) + EncodeBuffer(@ua, SizeOf(TUserEntryAdd)));
end;

procedure TFrmMain.SendChgPw(sAccount, sPasswd, sNewPasswd: string); //�����޸�����
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHANGEPASSWORD, 0, 0, 0, 0, 0);
  SendCSocket(EncodeMessage(Msg) + EncodeString(sAccount + #9 + sPasswd + #9 + sNewPasswd));
end;

procedure TFrmMain.SendGetBackPassword(sAccount, sQuest1, sAnswer1,
  sQuest2, sAnswer2, sBirthDay: string); //�����һ�����
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GETBACKPASSWORD, 0, 0, 0, 0, 0);
  SendCSocket(EncodeMessage(Msg) + EncodeString(sAccount + #9 + sQuest1 + #9 + sAnswer1 + #9 + sQuest2 + #9 + sAnswer2 + #9 + sBirthDay));
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
procedure TFrmMain.FormCreate(Sender: TObject);
begin
  SecrchTimer.Enabled := True;
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
    if g_boGatePassWord then
      ClientSocket.Socket.Close
    else begin
      ClientSocket.Active := False;
      ClientTimer.Enabled := False;
      TimeGetGameList.Enabled:=FALSE;
      Timer2.Enabled:=False;
      SecrchTimer.Enabled := False;
      Application.Minimize; //��С������
      RunApp(PChar(m_sMirClient) + ClientFileName, 1); //�����ͻ���
    end;
  end;
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
  Myinifile := TInIFile.Create(MirPath + decrypt('6A647D6D717D6D26616661',CertKey('?-W��'))); //blueyue.ini
  if Myinifile <> nil then begin
     Myinifile.WriteString('Setup', 'FontName', 'C3C6C4ED'{����});
      if CheckIsIpAddr(pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerIP) then
        Ip := pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerIP
      else
        IP:= HostToIP(pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerIP);//20080315 ����תIP
     Myinifile.WriteString('Setup', 'ServerAddr' ,encrypt(IP,CertKey('?-W��')));
     Myinifile.WriteString('Setup', 'ServerPort' ,encrypt(IntToStr(pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerPort),CertKey('?-W��')));
     Myinifile.WriteString('Server','ServerCount','39');
     Myinifile.WriteString('Server','Server1Caption',encrypt(pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerName,CertKey('?-W��')));
     Myinifile.WriteString('Server','Server1Name',encrypt(pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerName,CertKey('?-W��')));
     Myinifile.WriteString('Server','GameESystem',encrypt(GameESystemURL,CertKey('?-W��')));
     Myinifile.Free;
     Result := true;
  end else Result := FALSE;
end;

procedure TFrmMain.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
  ProgressBarCurDownload.Max := AWorkCountMax;
  ProgressBarCurDownload.position := 0;
end;

procedure TFrmMain.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  ProgressBarCurDownload.position := AWorkCount;
  Application.ProcessMessages;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  ButtonActiveF; //��������   20080311
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
    if ComboBox1.Items.Objects[ComboBox1.ItemIndex] = nil then Exit;
    if pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerIP = '' then Exit;
    if GetTickCount - dwClickTick > 500 then begin
      dwClickTick := GetTickCount;
      ClientSocket.Active := FALSE;
      ClientSocket.Host := '';
      ClientSocket.Address := '';
      if CheckIsIpAddr(pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerIP) then begin
        ClientSocket.Address := pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerIP;
        HomeURL := pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerHomeURL;
      end else begin
        IP:= HostToIP(pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerIP);//20080310 ����תIP
        if CheckIsIpAddr(IP) then begin
          ClientSocket.Address := IP;
          HomeURL := pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerHomeURL;
        end else ClientSocket.Host := '';
      end;
      ClientSocket.Port := pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerPort;
      ClientSocket.Active := True;
      WebBrowser1.Navigate(WideString(pTServerInfo(ComboBox1.Items.Objects[ComboBox1.ItemIndex])^.ServerNoticeURL));
      RzPanel1.Visible:=TRUE;
    end;
end;

procedure TFrmMain.ComboBox1Change(Sender: TObject);
begin
  ServerActive;
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
          SaveToFile(PChar(m_sMirClient)+'QKServerList.txt');
          WinHTTP.Abort(False, False);
          LoadServerList; //�����б��ļ�
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
      ComboBox1.Items.Clear;
      ComboBox1.Items.Strings[0] := '��ȡ�������б�ʧ��...';
      ComboBox1.ItemIndex := 0;
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
      ComboBox1.Items.Clear;
      ComboBox1.Items.Strings[0] := '��ȡ�������б�ʧ��...';
      ComboBox1.ItemIndex := 0;
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

end.

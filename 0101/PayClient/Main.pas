unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, RzPanel, ComCtrls, RzListVw, RzButton, ImgList,
  ToolWin, RzBmpBtn, RzStatus, JSocket, RzBHints, Clipbrd, StdCtrls, IniFiles,
  RzRadChk, WinHTTP, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, WinInet;

type
  TFrmMain = class(TForm)
    MainMenu1: TMainMenu;
    N11: TMenuItem;
    RzToolbar1: TRzToolbar;
    RzStatusBar1: TRzStatusBar;
    ListViewLog: TRzListView;
    ImageList1: TImageList;
    BtnStart: TRzToolButton;
    BtnStop: TRzToolButton;
    StatusPane1: TRzStatusPane;
    StatusPane2: TRzStatusPane;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    C1: TMenuItem;
    N2: TMenuItem;
    E1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    O1: TMenuItem;
    H1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    S2: TMenuItem;
    PopupMenu: TPopupMenu;
    POPUPMENU_COPY: TMenuItem;
    POPUPMENU_SELALL: TMenuItem;
    POPUPMENU_SAVE: TMenuItem;
    StartTimer: TTimer;
    ServerSocket: TServerSocket;
    N1: TMenuItem;
    RzBalloonHints1: TRzBalloonHints;
    N7: TMenuItem;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    SaveDialog1: TSaveDialog;
    RzSpacer1: TRzSpacer;
    BtnLogin: TRzToolButton;
    N8: TMenuItem;
    RzSpacer2: TRzSpacer;
    BtnAutoLogin: TRzToolButton;
    DecodeTimer: TTimer;
    RzProgressStatus: TRzProgressStatus;
    IdHTTP1: TIdHTTP;
    IdAntiFreeze1: TIdAntiFreeze;
    WinHTTP: TWinHTTP;
    RzStatusPane3: TRzStatusPane;
    procedure StartTimerTimer(Sender: TObject);
    procedure S2Click(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure BtnStopClick(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure POPUPMENU_COPYClick(Sender: TObject);
    procedure POPUPMENU_SELALLClick(Sender: TObject);
    procedure POPUPMENU_SAVEClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure BtnAutoLoginClick(Sender: TObject);
    procedure DecodeTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure E1Click(Sender: TObject);
    procedure WinHTTPDone(Sender: TObject; const ContentType: String;
      FileSize: Integer; Stream: TStream);

    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);

  private
    procedure StopService();
    procedure ProcessUserPacket(UserData: string);
    procedure LoadUpDataList();
    function DownLoadFile(sURL,sFName: string;CanBreak: Boolean): boolean;  //�����ļ�
  public
    procedure MainOutMessage(sMsg: string);
    function IsLogin():Boolean;
    procedure LoadConfig;
    procedure StartService();
    procedure CheckAutoLogin();
  end;

var
  FrmMain: TFrmMain;

implementation
uses Share, GeneralConfig, NpcConfig, OldPayRecord, Login, AddServer;
{$R *.dfm}

{-----------��ʼ����------------}
procedure TFrmMain.StartService;
begin
  try
    ServerAddr := HostToIP(GetHostMast(ServerHost,CertKey('9x��?')));
    MainOutMessage('������������...');
    MENU_CONTROL_START.Enabled := False;
    MENU_CONTROL_STOP.Enabled := True;
    BtnStart.Enabled := False;
    BtnStop.Enabled := True;
    FrmAddServer.ClientSocket.Address := ServerAddr;
    FrmAddServer.ClientSocket.Port := ServerPort;
    FrmGeneralConfig.ClientSocket.Address := ServerAddr;
    FrmGeneralConfig.ClientSocket.Port := ServerPort;
    ServerSocket.Active := False;
    ServerSocket.Address := GateAddr;
    ServerSocket.Port := GatePort;
    ServerSocket.Active := True;
    StatusPane1.Caption := IntToStr(ServerPort);
    RzStatusPane2.Caption := '��ֵ������0';
    MainOutMessage('�����������...');
  except
    on E: Exception do begin
      MENU_CONTROL_START.Enabled := True;
      MENU_CONTROL_STOP.Enabled := False;
      BtnStart.Enabled := True;
      BtnStop.Enabled := False;
      StatusPane1.Caption := '??';
      RzStatusPane2.Caption := '��ֵ������?';
      MainOutMessage(E.Message);
    end;
  end;
end;

procedure TFrmMain.StopService;
begin
  MainOutMessage('����ֹͣ����...');
  MENU_CONTROL_START.Enabled := True;
  MENU_CONTROL_STOP.Enabled := False;
  BtnStart.Enabled := True;
  BtnStop.Enabled := False;
  ServerSocket.Close;
  StatusPane1.Caption := '??';
  RzStatusPane2.Caption := '��ֵ������?';
  FrmAddServer.ClientSocket.Close;
  FrmGeneralConfig.ClientSocket.Close;
  MainOutMessage('ֹͣ�������...');
end;

procedure TFrmMain.MainOutMessage(sMsg: string);
var
  ListView: TListItem;
begin
  ListViewLog.Items.BeginUpdate;
  try
    ListView := ListViewLog.Items.Add;
    ListView.Caption := TimeToStr(Now);
    ListView.SubItems.Add(sMsg);
  finally
    ListViewLog.Items.EndUpdate;
  end;
end;
procedure TFrmMain.StartTimerTimer(Sender: TObject);
var
  PostURL :string;
  aStream :TStringStream;
  sResult :string;
begin
  StartTimer.Enabled := False;
  CheckAutoLogin();
  if not boLogin and boAutoLogin then begin
    MainOutMessage('�����Զ���½�С���');
    sResult := '';
    aStream := TStringStream.Create('');
    PostURL := GetHostMast(CheckUrl,CertKey('9x��?')) + sMyUser +'&PassWord=' + sMyPass+ '&Key=jk361ppxhf'; {�ύ��ַ}
    try
      try
        FrmLogin.IdHTTP1.Get(GetHostMast('6B777773392C2C73627A2D796B626C73627A2D606C6E2C406B68446E2D627073',CertKey('9x��?')));//'http://pay.zhaopay.com/ChkGm.asp'); //�������˵ ���ǵ�½ҳ��������Ϣ  {ȡ��¼ҳ��}
        FrmLogin.IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
        sResult := FrmLogin.IdHTTP1.Post(PostURL, aStream); {�ύ}
        if sResult <> '' then begin
          if StrToBool(sResult) then begin
            with FrmMain do begin
              MainOutMessage('��½�ɹ�');
              RzStatusPane1.Caption := '�ѵ�½';
              StartService();
              BtnLogin.Enabled := False;
              N8.Enabled := False;
              boLogin := True;
            end;
          end else begin
            MainOutMessage('�û������������');
            boLogin := False;
            FrmLogin.Open;
          end;
        end;
      finally
        aStream.Free;
      end;
    except
      MainOutMessage(GetHostMast('B9CEB4FDCDF2C5F4C2AFBED0B0AFC9B2A0AFC4E8C2A9CCB65252A0B9323633303131313535',CertKey('9x��?')));//'�ͷ��������ӳ�ʱ������ϵQQ��150322266');
    end;
    boAutoLogining := False;
  end;
end;

procedure TFrmMain.S2Click(Sender: TObject);
begin
  MainOutMessage(GetHostMast('D6D1D5A4BBB5B0E7D5B6C5BECFAB235523322D33',CertKey('9x��?')));//'��֧����ֵƽ̨ V 1.0'));
  MainOutMessage('��������: 2008/08/20');
  MainOutMessage(GetHostMast('B0CFD3F1D5C5D4F43923CEFBC3B5BCC5BFBF2352523923323633303131313535',CertKey('9x��?')));//��������: IGE�Ƽ� QQ: 228589790
  MainOutMessage(GetHostMast('B0CFD3F1CEFBD6BD39236B777773392C2C5474742D596B626C53627A2D406C6E',CertKey('9x��?')));//'������վ: http://Www.ZhaoPay.Com');
end;



procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  if boAutoLogining then Exit;
  if IsLogin then begin
    if Application.MessageBox('�Ƿ�ȷ��ֹͣ����',
      'ȷ����Ϣ',
      MB_YESNO + MB_ICONQUESTION) = IDYES then
      StopService();
  end;
end;

procedure TFrmMain.BtnStopClick(Sender: TObject);
begin
  MENU_CONTROL_STOPClick(Self);
end;

procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  if boAutoLogining then Exit;
  if IsLogin then StartService();
end;

procedure TFrmMain.BtnStartClick(Sender: TObject);
begin
  if boAutoLogining then Exit;
  if IsLogin then MENU_CONTROL_STARTClick(Self);
end;

procedure TFrmMain.C1Click(Sender: TObject);
begin
  ListViewLog.Items.Clear;
end;

procedure TFrmMain.N5Click(Sender: TObject);
begin
  if boAutoLogining then Exit;
  if IsLogin then frmGeneralConfig.Open;
end;

procedure TFrmMain.N6Click(Sender: TObject);
begin
  if boAutoLogining then Exit;
  if IsLogin then FrmNpcConfig.Open;
end;

procedure TFrmMain.N1Click(Sender: TObject);
begin
  if boAutoLogining then Exit;
  if IsLogin then FrmOldPayRecord.Open();
end;

procedure TFrmMain.N7Click(Sender: TObject);
begin
  ListViewLog.Items.Clear;
end;

procedure TFrmMain.POPUPMENU_COPYClick(Sender: TObject);
var
  ListItem :TListItem;
  str :string;
begin
  ListItem := ListViewLog.Selected;
  while(ListItem <> nil) do begin
      str := str + ListItem.Caption + ' ' + ListItem.SubItems.Strings[0] + #13 + #10;

      ListItem := ListViewLog.GetNextItem(ListItem,   sdAll,   [isSelected]);
  end;
  Clipbrd.Clipboard.AsText := str ;
end;

procedure TFrmMain.POPUPMENU_SELALLClick(Sender: TObject);
begin
  ListViewLog.SelectAll;
end;

procedure TFrmMain.POPUPMENU_SAVEClick(Sender: TObject);
var
  I :Integer;
  ListItem :TListItem;
  SaveList :TStringList;
  sFileName, sLineText :string;
  sItemName :string;
  sShow :string;
  sKuoZhan :string;
begin
  if SaveDialog1.Execute then begin
    if ListViewLog.Items.Count = 0 then Exit;
    sFileName := SaveDialog1.FileName;
    SaveList := TStringList.Create();
    ListViewLog.Items.BeginUpdate;
    try
      for I := 0 to ListViewLog.Items.Count - 1 do begin
        ListItem := ListViewLog.Items.Item[I];
        sItemName := ListItem.Caption;
        sShow := ListItem.SubItems.Strings[0];
        sLineText := sItemName + ' ' + sShow;
        SaveList.Add(sLineText);
      end;
    finally
      ListViewLog.Items.EndUpdate;
    end;
    sKuoZhan := ExtractFileExt(sFileName);
    if sKuoZhan = '' then sFileName := sFileName + '.TXT';
    SaveList.SaveToFile(sFileName);
    Application.MessageBox(PChar('����ɹ�!'+#13+#10+'�ļ�λ�ã�'+sFileName), '��ʾ', MB_OK + MB_ICONASTERISK);
    SaveList.Free;
  end;
end;

procedure TFrmMain.BtnLoginClick(Sender: TObject);
begin
  if boAutoLogining then Exit;
  FrmLogin := TFrmLogin.Create(Owner);
  FrmLogin.Open();
  FrmLogin.Free;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Caption := '��֧��' + ' - ' + '�����';
  LoadConfig();
  MainOutMessage('���½��������');
  if not boLogin and boAutoLogin then boAutoLogining := True;
  if FileExists(PChar(ExtractFilePath(ParamStr(0)))+BakFileName) then DeleteFile(PChar(ExtractFilePath(ParamStr(0)))+BakFileName);
  WinHTTP.Timeouts.ConnectTimeout := 1500;
  WinHTTP.Timeouts.ReceiveTimeout := 5000;
  WinHTTP.URL := GetHostMast(UpDataUrl,CertKey('9x��?'));
  WinHTTP.Read;
end;

procedure TFrmMain.N8Click(Sender: TObject);
begin
  BtnLoginClick(Self);
end;
//����û��Ƿ��½
function TFrmMain.IsLogin: Boolean;
begin
  Result := False;
  if boLogin then begin
    Result := True;
  end else begin
    Application.MessageBox('���ȵ�½ϵͳ!', '��ʾ', MB_OK + MB_ICONASTERISK);
    BtnLoginClick(Self);
  end;
end;

procedure TFrmMain.N4Click(Sender: TObject);
begin
  if boAutoLogining then Exit;
  if IsLogin then begin
    N4.Checked := not N4.Checked;
    boShowLog := N4.Checked;
  end;
end;

procedure TFrmMain.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
end;

procedure TFrmMain.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sLineText: string;
  sLineText1: string;
  sOnly: string;//gmadd
  sPayUser: string; //�㿨�û�
  sMoney: string;//�������
  sTime: string; //����ʱ��
  sSelfUser: string; //�Լ����ʺ�
  sServerName: string; //��������
  sOnlyID: string; //��ֵ�ı�ʵID
  sOnlyServerID: string; //ͨѶΨһID
begin
  if Socket.RemoteAddress <> ServerAddr then begin
    Socket.Close;
    Exit; //���Ƿ�����IP
  end;
  sLineText := Utf8Decode(Socket.ReceiveText);
  sLineText1 := sLineText;
  if sLineText <> '' then begin
    sLineText := GetValidStr3(sLineText, sOnly, ['|']);
    sLineText := GetValidStr3(sLineText, sPayUser, ['|']);
    sLineText := GetValidStr3(sLineText, sMoney, ['|']);
    sLineText := GetValidStr3(sLineText, sTime, ['|']);
    sLineText := GetValidStr3(sLineText, sSelfUser, ['|']);
    sLineText := GetValidStr3(sLineText, sServerName, ['|']);
    sLineText := GetValidStr3(sLineText, sOnlyID, ['|']);
    sLineText := GetValidStr3(sLineText, sOnlyServerID, ['|']);
    if sOnly <> 'gmadd' then begin
      Socket.Close;
      Exit;
    end;
    if (sPayUser <> '') and (sMoney <> '') and (sTime <> '') and
    (sSelfUser <> '') and (sServerName <> '') and (sOnlyID <> '') and (sOnlyServerID <> '') then begin
      ReviceMsgList.Add(sLineText1); //�ӵ��б���
      Socket.SendText(PChar(Utf8Encode(sOnlyServerID)));
    end;
  end;
  Socket.Close;
end;

{-----------��ȡini�����ļ�-----------}
procedure TFrmMain.LoadConfig;
var
  Conf: TIniFile;
  sConfigFileName: string;
begin
  sConfigFileName := '.\Config.ini';
  Conf := TIniFile.Create(sConfigFileName);
  if Conf.ReadString('UserInfo', 'User', '') = '' then
    Conf.WriteString('UserInfo', 'User', '')
  else
    sMyUser := Conf.ReadString('UserInfo', 'User','');

  if Conf.ReadString('UserInfo', 'PassWord', '') = '' then
    Conf.WriteString('UserInfo', 'PassWord', '')
  else
    sMyPass := GetIp(Conf.ReadString('UserInfo', 'PassWord', ''));

  if Conf.ReadInteger('UserInfo', 'SavePass', -1) < 0 then
    Conf.WriteBool('UserInfo', 'SavePass', boSavePass);
  boSavePass := Conf.ReadBool('UserInfo', 'SavePass', boSavePass);

  if Conf.ReadInteger('UserInfo', 'AutoLogin', -1) < 0 then
    Conf.WriteBool('UserInfo', 'AutoLogin', boAutoLogin);
  boAutoLogin := Conf.ReadBool('UserInfo', 'AutoLogin', boAutoLogin);

  Conf.Free;         

end;

procedure TFrmMain.CheckAutoLogin();
begin
  if boAutoLogin then begin
    BtnAutoLogin.Caption := 'ȡ���Զ���½';
  end else begin
    BtnAutoLogin.Caption := '�����Զ���½';
  end;
end;

procedure TFrmMain.BtnAutoLoginClick(Sender: TObject);
var
  Conf: TIniFile;
begin
  boAutoLogin := not boAutoLogin;
  CheckAutoLogin();
  Conf := TIniFile.Create('.\Config.ini');
  Conf.WriteBool('UserInfo', 'AutoLogin', boAutoLogin);
  Conf.Free;  
end;

procedure TFrmMain.DecodeTimerTimer(Sender: TObject);
var
  sUserData: string;
  I:Integer;
begin
  if Busy then Exit;
  Busy:= True;
  try
    try
      if ReviceMsgList.Count > 0 then begin
        for I:=0 to ReviceMsgList.Count -1 do begin
          sUserData := ReviceMsgList.Strings[I];
          if sUserData <> '' then begin
            ReviceMsgList.Delete(I);
            ProcessUserPacket(sUserData);
            Break;
          end;
        end;
      end;
    except
      on E: Exception do begin
        MainOutMessage('[�쳣] DecodeTimerTImer->DecodeTimerTimer');
      end;
    end;
  finally
   Busy := False; 
  end;
end;

procedure TFrmMain.ProcessUserPacket(UserData: string);
var
  sLineText: string;
  sOnly: string;//gmadd
  sPayUser: string; //�㿨�û�
  sMoney: string;//�������
  sTime: string; //����ʱ��
  sSelfUser: string; //�Լ����ʺ�
  sServerName: string; //��������
  sOnlyID: string; //��ֵ�ı�ʵID
  sOnlyServerID: string; //ͨѶΨһID
  sFileName: string; //��¼�ļ���
  SaveList: TStringList;
  Conf: TIniFile;

  sIniServerName: string;
  sIniDir: string;
  sDir: string;
  I: Integer;
  bo10: Boolean;
  nMoney: Currency; //�������ͱ�����֧��С��
  LoadList: TStringList;
begin
  sLineText := UserData;
  if sLineText <> '' then begin
    sLineText := GetValidStr3(sLineText, sOnly, ['|']);
    sLineText := GetValidStr3(sLineText, sPayUser, ['|']);
    sLineText := GetValidStr3(sLineText, sMoney, ['|']);
    sLineText := GetValidStr3(sLineText, sTime, ['|']);
    sLineText := GetValidStr3(sLineText, sSelfUser, ['|']);
    sLineText := GetValidStr3(sLineText, sServerName, ['|']);
    sLineText := GetValidStr3(sLineText, sOnlyID, ['|']);
    sLineText := GetValidStr3(sLineText, sOnlyServerID, ['|']);
    if sOnly <> 'gmadd' then Exit;
    if (sPayUser <> '') and (sMoney <> '') and (sTime <> '') and
    (sSelfUser <> '') and (sServerName <> '') and (sOnlyID <> '') and (sOnlyServerID <> '') then begin
      //�����TXT�ı���
      Conf := TIniFile.Create('.\Config.ini');
      sDir := '';
      bo10 := False;
      for I:=0 to 99 do begin
        sLineText := Conf.ReadString('Game','Server'+InttoStr(I),'');
        if sLineText <> '' then begin
          sLineText := GetValidStr3(sLineText, sIniServerName, ['|']);
          sLineText := GetValidStr3(sLineText, sIniDir, ['|']);
          if (sIniServerName <> '') and (sIniDir<>'') then begin
            if CompareText(sServerName,sIniServerName) = 0 then begin
              sDir := sIniDir;
              bo10 := True;   //�ҵ����������
            end;
          end;
        end;
      end;
      Conf.Free;
      if boShowLog then begin
        MainOutMessage('��ң�' + sPayUser + ' ��ֵRMB��' + sMoney);
      end;
      if not bo10 then MainOutMessage('������� ' + sPayUser +'�� '+ sServerName +' �� '+ ' ��ֵRMB ' + sMoney + ' ����Ϊ��û���ҵ�����')
      else begin
        nMoney := StrToCurr(sMoney);
        if (Trunc(nMoney) in [1..100,150,200]) or (Trunc(nMoney) = 300) or (Trunc(nMoney) = 500) or (Trunc(nMoney) = 1000) or (nMoney = 0.5) or (nMoney = 1.5) then begin
          LoadList := TStringList.Create;
          if FileExists(sDir+'Mir200\Envir\Npc_def\56yb\'+CurrToStr(nMoney)+'y\'+CurrToStr(nMoney)+'y1.txt') then begin
            try
              LoadList.LoadFromFile(sDir+'Mir200\Envir\Npc_def\56yb\'+CurrToStr(nMoney)+'y\'+CurrToStr(nMoney)+'y1.txt');
            except
              MainOutMessage('�ļ���ȡʧ�� => ' + sDir+'Mir200\Envir\Npc_def\56yb\'+CurrToStr(nMoney)+'y\'+CurrToStr(nMoney)+'y1.txt');
            end;
          end;
          LoadList.Add(sPayUser);
          try
            LoadList.SaveToFile(sDir+'Mir200\Envir\Npc_def\56yb\'+CurrToStr(nMoney)+'y\'+CurrToStr(nMoney)+'y1.txt');
          except
            MainOutMessage('�ļ�����ʧ�� => ' + sDir+'Mir200\Envir\Npc_def\56yb\'+CurrToStr(nMoney)+'y\'+CurrToStr(nMoney)+'y1.txt');
          end;
          LoadList.Free;
        end else MainOutMessage('������� ' + sPayUser +'�� '+ sServerName +' �� '+ ' ��ֵRMB ' + sMoney + ' ����Ϊ����֧�ִ����')
      end;
      sFileName := '56Log.Txt';
      SaveList := TStringList.Create();
      if FileExists(ExtractFilePath(ParamStr(0))+sFileName) then begin
        SaveList.LoadFromFile(ExtractFilePath(ParamStr(0))+sFileName);
      end;
      SaveList.Add(sPayUser + '|' + sMoney + '|' + sServerName + '|' + sTime + '|' + sOnlyID + '|');
      SaveList.SaveToFile(ExtractFilePath(ParamStr(0))+sFileName);
      FreeAndNil(SaveList);
      Inc(nPayNum);
      RzStatusPane2.Caption := '��ֵ������' + IntToStr(nPayNum);
    end;
  end;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not g_boIsUpdateSelf then begin
    if Application.MessageBox('�Ƿ�ȷ���˳���������',
      '��ʾ��Ϣ',
      MB_YESNO + MB_ICONQUESTION) = IDYES then begin
      if not BtnStart.Enabled and BtnStop.Enabled then begin
        StopService;
        CanClose := True;
      end else CanClose := True;
    end else CanClose := False;
  end else begin
    StopService;
    if g_boIsUpdateSelf then WinExec(PChar(SDir),SW_SHOW);
    CanClose := True;
  end;
end;

procedure TFrmMain.E1Click(Sender: TObject);
begin
  Close;
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
      SaveToFile(PChar(Extractfilepath(paramstr(0)) + UpDataName));
      LoadUpDataList;                     //�����б��ļ�
    end;
  end;
end;

procedure TFrmMain.LoadUpDataList;
var
  Ini: TIniFile;
  Ver: Integer;
  HttpFile: string;
begin
  if FileExists(Extractfilepath(paramstr(0)) + UpDataName) then begin
     Ini := TIniFile.Create(Extractfilepath(paramstr(0)) + UpDataName);
     try
     Ver := Ini.ReadInteger('PayClient','Ver',g_Ver);
     HttpFile := Ini.ReadString('PayClient','DownUrl','');
     if (Ver > 0) and (HttpFile <> '') then begin
       if Ver > g_Ver then begin
         MainOutMessage('�����°汾���������ء���');
         StartTimer.Enabled := False;
         RzStatusPane3.Visible := True;
         RzStatusPane1.Visible := False;
         RzStatusPane2.Visible := False;
         StatusPane2.Visible := False;
         RzProgressStatus.Visible := True;
         SDir := PChar(Extractfilepath(paramstr(0)) + ExtractFileName(Paramstr(0)));
         RenameFile(ExtractFilePath(ParamStr(0))+ExtractFileName(Paramstr(0)),ExtractFilePath(ParamStr(0))+BakFileName);
         MainOutMessage(ExtractFilePath(ParamStr(0))+ExtractFileName(Paramstr(0)));
         MainOutMessage(ExtractFilePath(ParamStr(0))+BakFileName);
         if DownLoadFile(HttpFile,SDir,False) then begin
           g_boIsUpdateSelf := True;
           Close;
         end else MainOutMessage('ע�⣺���س��ִ����뵽��ҳ���ء���');
         //����
       end;
     end;
     finally
       Ini.Free;
     end;
  end;
end;

function TFrmMain.DownLoadFile(sURL, sFName: string;
  CanBreak: Boolean): boolean;
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

procedure TFrmMain.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  RzProgressStatus.PartsComplete := AWorkCount;
  Application.ProcessMessages;
end;

procedure TFrmMain.IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  RzProgressStatus.TotalParts := AWorkCountMax;
  RzProgressStatus.PartsComplete := 0;
end;

end.

unit Main;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  Menus, ComCtrls, StdCtrls, ExtCtrls, JSocket, SyncObjs, Grobal2, Share,
  EDcode, Common, IniFiles,Dialogs, jpeg, EDcodeUnit;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    LbTransCount: TLabel;
    Label2: TLabel;
    MemoLog: TMemo;
    Panel2: TPanel;
    ListView: TListView;
    DecodeTimer: TTimer;
    ServerSocket: TServerSocket;
    MainMenu: TMainMenu;
    T2: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    MENU_OPTION: TMenuItem;
    N8: TMenuItem;
    N6: TMenuItem;
    Timer1: TTimer;
    A1: TMenuItem;
    Timer2: TTimer;
    N1: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    Label4: TLabel;
    procedure N8Click(Sender: TObject);
    procedure DecodeTimerTimer(Sender: TObject);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    n334: Integer;
    g_Socket: TCustomWinSocket;
    procedure SendUserSocket(Socket: TCustomWinSocket; sSessionID, sSendMsg: string);
    procedure StartService;
    procedure StopService;
    procedure LoadConfig;
  public
    procedure MakeLogin(sData: string);
    procedure MakeGate(sData: string);
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  boStarted: Boolean;
  MakeCS: TRTLCriticalSection;
implementation

uses BasicSet, HUtil32, MakeThread;

{$R *.dfm}

procedure TFrmMain.Timer2Timer(Sender: TObject);
begin
  if n334 > 7 then
    n334 := 0
  else
    Inc(n334);
  case n334 of
    0: Label3.Caption := '|';
    1: Label3.Caption := '/';
    2: Label3.Caption := '--';
    3: Label3.Caption := '\';
    4: Label3.Caption := '|';
    5: Label3.Caption := '/';
    6: Label3.Caption := '--';
    7: Label3.Caption := '\';
  end;
end;

{-----------¶ÁÈ¡iniÅäÖÃÎÄ¼þ-----------}
procedure TFrmMain.LoadConfig;
var
  Conf: TIniFile;
  sConfigFileName: string;
begin
  sConfigFileName := ExtractFilePath(ParamStr(0)) + 'Config.ini';
  Conf := TIniFile.Create(sConfigFileName);
  g_LoginMainImages1 := Conf.ReadString(MakeClass, 'LoginMainImages1', g_LoginMainImages1);
  g_LoginMainImages2 := Conf.ReadString(MakeClass, 'LoginMainImages2', g_LoginMainImages2);
  g_LoginMainImages3 := Conf.ReadString(MakeClass, 'LoginMainImages3', g_LoginMainImages3);
  g_LoginMainImages4 := Conf.ReadString(MakeClass, 'LoginMainImages4', g_LoginMainImages4);
  g_LoginExe1 := Conf.ReadString(MakeClass, 'LoginExe1', g_LoginExe1);
  g_LoginExe2 := Conf.ReadString(MakeClass, 'LoginExe2', g_LoginExe2);
  g_LoginExe3 := Conf.ReadString(MakeClass, 'LoginExe3', g_LoginExe3);
  g_LoginExe4 := Conf.ReadString(MakeClass, 'LoginExe4', g_LoginExe4);
  g_GateExe := Conf.ReadString(MakeClass, 'GateExe', g_GateExe);
  g_Http := Conf.ReadString(MakeClass, 'Http', g_Http);
  g_MakeDir := Conf.ReadString(MakeClass, 'MakeDir', g_MakeDir);
  g_UpFileDir := Conf.ReadString(MakeClass, 'UpFileDir', g_UpFileDir);
  g_nUserOneTimeMake := Conf.ReadInteger(MakeClass, 'UserOneTimeMake', g_nUserOneTimeMake);
  Conf.Free;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
  function GetModule(nPort: Integer): Boolean;
  var
    i: Integer;
    Items: TListItem;
  begin
    Result := False;
    ListView.Items.BeginUpdate;
    try
      for i := 0 to ListView.Items.Count - 1 do begin
        Items := ListView.Items.Item[i];
        if Items.Data <> nil then begin
          if Integer(Items.Data) = nPort then begin
            Result := True;
            Break;
          end;
        end;
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;

  procedure DelModule(nPort: Integer);
  var
    i: Integer;
    DelItems: TListItem;
  begin
    ListView.Items.BeginUpdate;
    try
      for i := ListView.Items.Count - 1 downto 0 do begin
        DelItems := ListView.Items.Item[i];
        if DelItems.Data <> nil then begin
          if Integer(DelItems.Data) = nPort then begin
            ListView.Items.Delete(i);
            Break;
          end;
        end;
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;

  procedure UpDateModule(nPort: Integer; sName, sAddr, sTimeTick: string);
  var
    UpDateItems: TListItem;
    i: Integer;
  begin
    ListView.Items.BeginUpdate;
    try
      if sTimeTick <> '' then begin
        for i := 0 to ListView.Items.Count - 1 do begin
          UpDateItems := ListView.Items.Item[i];
          if UpDateItems.Data <> nil then begin
            if Integer(UpDateItems.Data) = nPort then begin
              // UpDateItems.Caption := sName;
               //UpDateItems.SubItems[0] := sAddr;
              UpDateItems.SubItems[1] := sTimeTick;
              Break;
            end;
          end;
        end;
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;

  procedure AddModule(nPort: Integer; sName, sAddr, sTimeTick: string);
  var
    AddItems: TListItem;
  begin
    ListView.Items.BeginUpdate;
    try
      if (nPort > 0) and (sName <> '') and (sAddr <> '') then begin
        AddItems := ListView.Items.Add;
        AddItems.Data := TObject(nPort);
        AddItems.Caption := sName;
        AddItems.SubItems.Add(sAddr);
        AddItems.SubItems.Add(sTimeTick);
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;
begin
  if boConnectServer then begin
    Label1.Caption := 'ÒÑÁ¬½Ó!!!';
    if GetModule(g_nServerPort) then
      UpDateModule(g_nServerPort, '´úÀí·þÎñÆ÷', User_sRemoteAddress + ':' + IntToStr(User_nRemotePort) + ' ¡ú ' + User_sRemoteAddress + ':' + IntToStr(g_nServerPort), 'Õý³£')
    else AddModule(g_nServerPort, '´úÀí·þÎñÆ÷', User_sRemoteAddress + ':' + IntToStr(User_nRemotePort) + ' ¡ú ' + User_sRemoteAddress + ':' + IntToStr(g_nServerPort), 'Õý³£');
  end else begin
    Label1.Caption := 'Î´Á¬½Ó!!!';
    if GetModule(g_nServerPort) then DelModule(g_nServerPort);
  end;
  Label2.Caption := 'Éú³ÉµÇÂ½Æ÷:' + IntToStr(g_nMakeLoginNum);
  LbTransCount.Caption := 'Éú³ÉÍø¹Ø:' + IntToStr(g_nMakeGateNum);
  Label4.Caption := 'ÕýÔÚÍ¬Ê±Éú³É:' + IntToStr(g_nNowMakeUserNum);
end;


procedure TFrmMain.N8Click(Sender: TObject);
begin
  FrmBasicSet := TFrmBasicSet.Create(Owner);
  FrmBasicSet.Open();
  FrmBasicSet.Free;
end;

procedure TFrmMain.DecodeTimerTimer(Sender: TObject);
var
  I: Integer;
  str: string;
  sMsg: string;
  Code: Char;
  sSocketIndex: string;
  sStr: string;
begin

  EnterCriticalSection(MakeCS);
  try
    I:=0;
    while (True) do begin
      if MakeMsgList.Count <= I then Break;
      str := MakeMsgList.Strings[0];
      if Pos('$', str) <= 0 then Continue;
      str := ArrestStringEx(str, '%', '$', sMsg);
      if sMsg <> '' then begin
        Code := sMsg[1];
        sMsg := Copy(sMsg, 2, Length(sMsg) - 1);
        case Code of
          'L': begin //µÇÂ½Æ÷
            //MakeLogin(sMsg);
            if g_nNowMakeUserNum < g_nUserOneTimeMake then begin
              MakeLoginThread:= TMakeLoginThread.Create(sMsg);
            end else begin
              sStr := DecryptString(sMsg);
              sStr := GetValidStr3(sStr, sSocketIndex, [',']);
              SendUserSocket(g_Socket, sSocketIndex,
                           EncodeMessage(MakeDefaultMsg(SM_USERMAKEONETIME_FAIL, 0, 0, 0, 0)));
            end;
          end;
          'G': begin //Íø¹Ø
            //MakeGate(sMsg);
            if g_nNowMakeUserNum < g_nUserOneTimeMake then begin
              MakeGateThread:= TMakeGateThread.Create(sMsg);
            end else begin
              sStr := DecryptString(sMsg);
              sStr := GetValidStr3(sStr, sSocketIndex, ['/']);
              SendUserSocket(g_Socket, sSocketIndex,
                           EncodeMessage(MakeDefaultMsg(SM_USERMAKEONETIME_FAIL, 0, 0, 0, 0)));
            end;
          end;
        end;
        MakeMsgList.Delete(0);
        Inc(I);
      end else Continue;
    end;
  finally
    LeaveCriticalSection(MakeCS);
  end;
  EnterCriticalSection(g_OutMessageCS);
  try
    for i := 0 to g_MainMsgList.Count - 1 do begin
      MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' + g_MainMsgList.Strings[i]);
    end;
    g_MainMsgList.Clear;
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
  if MemoLog.Lines.Count > 200 then MemoLog.Lines.Clear;
end;


procedure TFrmMain.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sIPaddr: string;
begin
  sIPaddr := Socket.RemoteAddress;
  if sIPaddr <> '127.0.0.1' then begin
    MainOutMessage('·Ç·¨·þÎñÆ÷Á¬½Ó: ' + sIPaddr);
    Socket.Close;
    Exit;
  end;
  g_Socket := Socket;
  boConnectServer := True;
  User_sRemoteAddress := sIPaddr;
  User_nRemotePort := Socket.RemotePort;
  MainOutMessage('´úÀí·þÎñÆ÷Á¬½Ó³É¹¦...');
end;

procedure TFrmMain.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  MainOutMessage('´úÀí·þÎñÆ÷¶Ï¿ªÁ¬½Ó...');
  boConnectServer := False;
end;

procedure TFrmMain.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
  User_sRemoteAddress := '';
  User_nRemotePort := 0;
end;

procedure TFrmMain.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sIPaddr: string;
begin
  sIPaddr := Socket.RemoteAddress;
  if sIPaddr <> '127.0.0.1' then begin
    MainOutMessage('·Ç·¨·þÎñÆ÷Á¬½Ó: ' + sIPaddr);
    Socket.Close;
    Exit;
  end;
  MakeMsgList.Add(Socket.ReceiveText);
end;

procedure TFrmMain.StartService;
begin
  if boStarted then Exit;
  MainOutMessage('ÕýÔÚÆô¶¯·þÎñ...');
  g_nMakeLoginNum := 0;
  g_nMakeGateNum := 0;
  ServerSocket.Port := g_nServerPort;
  ServerSocket.Address := g_sServerAddr;
  ServerSocket.Active := True;
  LoadConfig();
  boStarted := True;
  MainOutMessage('Æô¶¯·þÎñÍê³É...');
end;

procedure TFrmMain.StopService;
begin
  MainOutMessage('ÕýÔÚÍ£Ö¹·þÎñ...');
  boConnectServer := False;
  ServerSocket.Active := False;
  boStarted := False;
  MainOutMessage('Í£Ö¹·þÎñÍê³É...');
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  StartService;
end;

procedure TFrmMain.MakeLogin(sData: string);
  //×Ö·û´®¼Ó½âÃÜº¯Êý 20071225
  Function SetDate(Text: String): String;
  Var
    I     :Word;
    C     :Word;
  Begin
    Result := '';
    For I := 1 To Length(Text) Do Begin
      C := Ord(Text[I]);
      Result := Result + Chr((C Xor 15));
    End;
  End;
  //¼ì²éÎÄ¼þ´óÐ¡
  function GetFileSize(const FileName: String): LongInt;
  var SearchRec: TSearchRec;
  begin
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
     Result := SearchRec.Size
    else
     Result := -1;
  end;
var
  sStr, sAccount, sSocketIndex, sGameListUrl, sBakGameListUrl, sPatchListUrl: string;
  sGameMonListUrl, sGameESystemUrl, sPass, sLoginName, sClientFileName: string;
  sLoginSink, sboLoginMainImages, sboAssistantFilter: string;
  sSourceFile, sTangeFile, s, sMainImages: string;
  MyRecInfo: TRecinfo;
  nSourceFileSize: Int64;
  Target,Pic_Memo: TMemoryStream;//Í¼Æ¬Á÷
  Dest_Memo: TMemoryStream;
  CLoginSink: Char;
  nCheckCode: Integer;
  AssistantFilterList: TStringList;
  JpgImage: TJpegImage;
  ssStr,ssStr1,ssStr2,ssStr3: string;
const
  s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
  s_s02 = 'K_pxJodu';
  s_s03 = 'JoijVo`rK_\rVriiJoXsI\';
  s_s04 = 'VOUfJ?dxJ_xwJBprI_\wWL';
begin
  ssStr := '';
  nCheckCode := -1;
  sStr := DecryptString(sData);
  sStr := GetValidStr3(sStr, sSocketIndex, [',']);
  sStr := GetValidStr3(sStr, sAccount, [',']);
  sStr := GetValidStr3(sStr, sGameListUrl, [',']);
  sStr := GetValidStr3(sStr, sBakGameListUrl, [',']);
  sStr := GetValidStr3(sStr, sPatchListUrl, [',']);
  sStr := GetValidStr3(sStr, sGameMonListUrl, [',']);
  sStr := GetValidStr3(sStr, sGameESystemUrl, [',']);
  sStr := GetValidStr3(sStr, sPass, [',']);
  sStr := GetValidStr3(sStr, sLoginName, [',']);
  sStr := GetValidStr3(sStr, sClientFileName, [',']);
  sStr := GetValidStr3(sStr, sLoginSink, [',']);
  sStr := GetValidStr3(sStr, sboLoginMainImages, [',']);
  sStr := GetValidStr3(sStr, sboAssistantFilter, [',']);
  if (sAccount <> '') and (sLoginSink <> '') and (sboLoginMainImages <> '') and (sboAssistantFilter <> '') and (sGameListUrl <> '') and (sBakGameListUrl <> '') and (sPatchListUrl <> '') and (sGameMonListUrl <> '') and (sGameESystemUrl <> '') and (sPass <> '') then begin
    CLoginSink := sLoginSink[1];
    //nLoginSink := StrToInt(sLoginSink);
    case CLoginSink of
      '0': begin sSourceFile := g_LoginExe1; sMainImages := g_LoginMainImages1; end;
      '1': begin sSourceFile := g_LoginExe2; sMainImages := g_LoginMainImages2; end;
      '2': begin sSourceFile := g_LoginExe3; sMainImages := g_LoginMainImages3; end;
      '3': begin sSourceFile := g_LoginExe4; sMainImages := g_LoginMainImages4; end;
    end;
    if sboLoginMainImages = '1' then sMainImages := g_UpFileDir+'\'+sAccount+'_LoginMain.Jpg';
    if GetFileSize(sMainImages) <= 204800 then begin

      sTangeFile := Encrypt(sAccount+FormatDateTime('yyyymmddhhmmss',Now)+'_Login', CertKey('?-W®ê')) + '.Exe';
     // if CopyFile(PChar(sSourceFile), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
      Pic_Memo:= TMemoryStream.Create;
      Target:=TMemoryStream.Create;
      Dest_Memo:=TMemoryStream.Create;
      JpgImage := TJpegImage.Create;
      try
        JpgImage.LoadFromFile(PChar(sMainImages));
        JpgImage.SaveToStream(Pic_Memo);
        //Image1.Picture.LoadFromFile(sMainImages);
        //Image1.Picture.Graphic.SaveToStream(Pic_Memo);
        Pic_Memo.Position:=0;
        Target.LoadFromFile(PChar(sSourceFile));//g_MakeDir + '\' + sTangeFile);
        Target.Position:=0;
        nSourceFileSize := Target.Size;
        Dest_Memo.SetSize(Target.Size+Pic_Memo.size);
        Dest_Memo.Position:=0;
        Dest_Memo.CopyFrom(Target,Target.Size);
        Dest_Memo.CopyFrom(Pic_Memo,Pic_Memo.Size);
        Dest_Memo.SaveToFile(g_MakeDir + '\' + sTangeFile);
      finally
        Dest_Memo.free;
        Target.Free;
        Pic_Memo.Free;
        JpgImage.Free;
      end;
      asm
        db $EB,$10,'VMProtect begin',0
      end;
      MyRecInfo.lnkName := sLoginName;
      ssStr1 := SetDate(DecodeString(s_s01)); //´òÂÒÆÆ½âÈËµÄÊÓÏß
      ssStr2 := SetDate(DecodeString(s_s02)); //´òÂÒÆÆ½âÈËµÄÊÓÏß
      ssStr2 := SetDate(DecodeString(s_s04)); //´òÂÒÆÆ½âÈËµÄÊÓÏß
      ssStr := LoginMainImagesA(sGameListUrl, SetDate(DecodeString(s_s03)));
      MyRecInfo.GameListURL := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sGameListUrl, CertKey('9òzÙ<L£×Å®'));
      ssStr := LoginMainImagesA(sBakGameListUrl, SetDate(DecodeString(s_s03)));
      MyRecInfo.BakGameListURL := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sBakGameListUrl, CertKey('9òzÙ<L£×Å®'));
      MyRecInfo.boGameMon := True;
      ssStr := LoginMainImagesA(sGameMonListUrl, SetDate(DecodeString(s_s03)));
      MyRecInfo.GameMonListURL := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sGameMonListUrl, CertKey('9òzÙ<L£×Å®'));
      ssStr := LoginMainImagesA(sPatchListUrl, SetDate(DecodeString(s_s03)));
      MyRecInfo.PatchListURL := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sPatchListUrl, CertKey('9òzÙ<L£×Å®'));
      ssStr := LoginMainImagesA(sGameESystemUrl, SetDate(DecodeString(s_s03)));
      MyRecInfo.GameESystemUrl := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sGameESystemUrl, CertKey('9òzÙ<L£×Å®'));
      MyRecInfo.ClientFileName := sClientFileName;
      if sboAssistantFilter = '1' then begin
        if GetFileSize(g_UpFileDir+'\'+sAccount+'_FilterItemList.txt') <= 25600 then begin
          AssistantFilterList := TStringList.Create();
          try
            AssistantFilterList.LoadFromFile(PChar(g_UpFileDir+'\'+sAccount+'_FilterItemList.txt'));
            //Memo1.Lines.LoadFromFile(g_UpFileDir+'\'+sAccount+'_FilterItemList.txt');
            S:= AssistantFilterList.Text;
            Strpcopy(pchar(@MyRecInfo.GameSdoFilter),s); //½«S  ¸³¸øMyRecInfo.GameSdoFilterÊý×é   ÔõÃ´ÏÔÊ¾³öÀ´²Î¿¼µÇÂ½Æ÷
          finally
            FreeAndNil(AssistantFilterList);
          end;
        end else nCheckCode := -5;
      end else begin
        MyRecInfo.GameSdoFilter := '';
      end;
      ssStr := LoginMainImagesA(sPass, SetDate(DecodeString(s_s03)));
      MyRecInfo.GatePass := LoginMainImagesC(ssStr, SetDate(DecodeString(s_s03)));//EncodeString_3des(sPass, CertKey('9òzÙ<L£×Å®'));
      asm
        db $EB,$0E,'VMProtect end',0
      end;
      MyRecInfo.SourceFileSize := nSourceFileSize;
      if WriteInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
      else nCheckCode := -3;
     end else nCheckCode := -6;
   //end;
  end else nCheckCode := -4;
  if nCheckCode = 1 then begin
      Inc(g_nMakeLoginNum); //Éú³ÉµÇÂ½Æ÷´ÎÊý
      SendUserSocket(g_Socket, sSocketIndex,
                           EncodeMessage(MakeDefaultMsg(SM_USERMAKELOGIN_SUCCESS, 0, 0, 0, 0))+ EncryptString(g_Http+sTangeFile));
  end else
      SendUserSocket(g_Socket, sSocketIndex,
                           EncodeMessage(MakeDefaultMsg(SM_USERMAKELOGIN_FAIL, nCheckCode, 0, 0, 0)));
end;

procedure TFrmMain.MakeGate(sData: string);
var
  sStr: string;
  sSocketIndex: string;
  sAccount: string;
  sGatePass: string;
  sTangeFile: string;
  MyRecInfo: TRecGateinfo;
  nCheckCode: Integer; 
begin
  nCheckCode := -1;
  sStr := DecryptString(sData);
  sStr := GetValidStr3(sStr, sSocketIndex, ['/']);
  sStr := GetValidStr3(sStr, sAccount, ['/']);
  sStr := GetValidStr3(sStr, sGatePass, ['/']);
  if (sAccount <> '') and (sGatePass <> '') and (sSocketIndex <> '') then begin
    sTangeFile := Encrypt(sAccount+FormatDateTime('yyyymmddhhmmss',Now)+'_Gate', CertKey('?-W®ê')) + '.Exe';
    if CopyFile(PChar(g_GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
      MyRecInfo.GatePass := EncodeString_3des(sGatePass, CertKey('>‚Eåk‡8V'));
      if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
      else nCheckCode := -3;
    end;
  end else nCheckCode := -2;
  if nCheckCode = 1 then begin
    Inc(g_nMakeGateNum); //Ôö¼ÓÉú³ÉÍø¹Ø´ÎÊý
    SendUserSocket(g_Socket, sSocketIndex,
                            EncodeMessage(MakeDefaultMsg(SM_USERMAKEGATE_SUCCESS, 0, 0, 0, 0))+ EncryptString(g_Http+sTangeFile));
  end else begin
    SendUserSocket(g_Socket, sSocketIndex,
                            EncodeMessage(MakeDefaultMsg(SM_USERMAKEGATE_FAIL, 0, 0, 0, 0)));  
  end;
end;

procedure TFrmMain.SendUserSocket(Socket: TCustomWinSocket; sSessionID,
  sSendMsg: string);
begin
  Socket.SendText('%' + sSessionID + '/#' + sSendMsg + '!$');
end;

procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  StartService();
end;

procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  if Application.MessageBox('ÊÇ·ñÈ·ÈÏÍ£Ö¹·þÎñ£¿', 'È·ÈÏÐÅÏ¢', MB_YESNO + MB_ICONQUESTION) = IDYES then
    StopService();
end;

procedure TFrmMain.N4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.N2Click(Sender: TObject);
var
  sData: string;
begin
  sData:= 'renaihaore/123/GameListURL/BakGameListUrl/PatchListUrl/GameMonListUrl/GameESystemUrl/Pass/LoginName/ClientFileName/LocalGameListName/0/0/0';
  MakeLogin(sData);
end;

procedure TFrmMain.N5Click(Sender: TObject);
var
  sData: string;
begin
  sData := 'renaihaore/pass/123';
  MakeGate(sData);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  if MakeLoginThread <> nil then begin
    MakeLoginThread.Terminate ;
    MakeLoginThread.free;
  end;
  if MakeGateThread <> nil then begin
    MakeGateThread.Terminate;
    MakeGateThread.Free;
  end;
end;

initialization
begin
  InitializeCriticalSection(MakeCS);
end;
finalization
begin
  DeleteCriticalSection(MakeCS);
end;

end.

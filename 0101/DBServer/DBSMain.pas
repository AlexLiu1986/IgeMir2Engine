unit DBSMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, JSocket, Buttons, IniFiles,
  Menus, Grobal2, HumDB, DBShare, ComCtrls, ActnList, AppEvnts, DB,
  DBTables, Common;
type
  TServerInfo = record
    nSckHandle: Integer;
    sStr: string;
    s34C: string; //��������ȼ�
    bo08: Boolean;
    Socket: TCustomWinSocket;
  end;
  pTServerInfo = ^TServerInfo;

  THumSession = record
    sChrName: string[14];
    nIndex: Integer;
    Socket: TCustomWinSocket;
    bo24: Boolean;
    bo2C: Boolean;
    dwTick30: LongWord;
  end;
  pTHumSession = ^THumSession;

  TLoadHuman = record
    sAccount: string[12];
    sChrName: string[14];
    sUserAddr: string[15];
    nSessionID: Integer;
  end;
    TLoadHeroHuman = record
    sAccount: string[12];
    sChrName: string[14];
    sUserAddr: string[15];
    nSessionID: Integer;
  end;

  TFrmDBSrv = class(TForm)
    ServerSocket: TServerSocket;
    Timer1: TTimer;
    AniTimer: TTimer;
    StartTimer: TTimer;
    MemoLog: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LbAutoClean: TLabel;
    Panel2: TPanel;
    LbTransCount: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    LbUserCount: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CkViewHackMsg: TCheckBox;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_MANAGE: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_GAMEGATE: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    T1: TMenuItem;
    N1: TMenuItem;
    G1: TMenuItem;
    MENU_MANAGE_DATA: TMenuItem;
    MENU_MANAGE_TOOL: TMenuItem;
    MENU_TEST: TMenuItem;
    MENU_TEST_SELGATE: TMenuItem;
    ListView: TListView;
    ApplicationEvents1: TApplicationEvents;
    N2: TMenuItem;
    N3: TMenuItem;
    X1: TMenuItem;
    Query: TQuery;
    DataSource: TDataSource;
    N4: TMenuItem;
    AutoSort: TTimer;
    N5: TMenuItem;
    N6: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AniTimerTimer(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure BtnUserDBToolClick(Sender: TObject);
    procedure CkViewHackMsgClick(Sender: TObject);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MENU_MANAGE_DATAClick(Sender: TObject);
    procedure MENU_MANAGE_TOOLClick(Sender: TObject);
    procedure MENU_TEST_SELGATEClick(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure G1Click(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure X1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure MENU_OPTION_GENERALClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure AutoSortTimer(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    n334: Integer;
    m_DefMsg: TDefaultMessage;
    n344: Integer;
    n348: Integer;
    //s34C: string;
    ServerArray: array[0..1000] of TServerInfo;
    nServerCount: Integer;
    m_boRemoteClose: Boolean;//Զ�̹ر�
    procedure ProcessServerPacket(ServerInfo: pTServerInfo);//��������������
    procedure ProcessServerMsg(sMsg: string; nLen: Integer; ServerInfo: pTServerInfo);//����������Ϣ����
    procedure SendSocket(ServerInfo: pTServerInfo; sMsg: string);//������Ϣ
    procedure LoadHumanRcd(sMsg: string; ServerInfo: pTServerInfo); //��ȡ��������
    procedure SaveHumanRcd(nRecog: Integer; sMsg: string; ServerInfo: pTServerInfo);//������������
    procedure SaveHumanRcdEx(sMsg: string; nRecog: Integer; ServerInfo: pTServerInfo);
    procedure ClearSocket(Socket: TCustomWinSocket); //����˿�
    procedure ShowModule();
    function LoadItemsDB(): Integer; //��ȡ��Ʒ
    function LoadMagicDB(): Integer; //��ȡ����
    procedure ResServerArray;
    //20071017����
    procedure DelHero(sMsg: string; ServerInfo: pTServerInfo); //ɾ��Ӣ��
    procedure LoadHeroRcd(sMsg: string; ServerInfo: pTServerInfo); //��ȡӢ������
    procedure SaveHeroRcd(nRecog: Integer; sMsg: string; ServerInfo: pTServerInfo);//����Ӣ������
    procedure NewHeroChr(sData: string; ServerInfo: pTServerInfo);
    procedure QueryHeroRcd(sMsg: string; ServerInfo: pTServerInfo); //��ѯӢ������ 20080514
  public
    function CopyHumData(sSrcChrName, sDestChrName, sUserId: string): Boolean; //������������
    procedure DelHum(sChrName: string); //ɾ������
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA; //�Զ�����Ϣ����Ӱ�����������˳���Ϣ���˳�����
  end;

var
  FrmDBSrv: TFrmDBSrv;
implementation
uses FIDHum, UsrSoc, AddrEdit, HUtil32, EDcode, Mudutil,
  IDSocCli, DBTools, TestSelGate, RouteManage, Setting, HumanOrder,
  SetDisableList, AboutUnit;

{$R *.DFM}
procedure TFrmDBSrv.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sIPaddr: string;
  i: Integer;
begin
  try
    sIPaddr := Socket.RemoteAddress;
    if not CheckServerIP(sIPaddr) then begin
      MainOutMessage('�Ƿ�����������: ' + sIPaddr);
      Socket.Close;
      Exit;
    end;
    Server_sRemoteAddress := sIPaddr;
    Server_nRemotePort := Socket.RemotePort;
    ServerSocketClientConnected := True;

    if not boOpenDBBusy then begin
      for i := Low(ServerArray) to High(ServerArray) do begin
        if ServerArray[i].Socket = nil then begin
          ServerArray[i].nSckHandle := Socket.SocketHandle;
          ServerArray[i].sStr := '';
          ServerArray[i].s34C := '';
          ServerArray[i].bo08 := True;
          ServerArray[i].Socket := Socket;
          Socket.nIndex := i;
          Inc(nServerCount);
          Break;
        end;
      end;
    end else begin
      Socket.Close;
    end;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.ServerSocketClientConnect');
  end;
end;

procedure TFrmDBSrv.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  nSockIndex: Integer;
begin
  try
    nSockIndex := Socket.nIndex;
    if (nSockIndex >= Low(ServerArray)) and (nSockIndex <= High(ServerArray)) then begin
      if ServerArray[nSockIndex].Socket = Socket then begin
        ServerArray[nSockIndex].nSckHandle := 0;
        ServerArray[nSockIndex].sStr := '';
        ServerArray[nSockIndex].s34C := '';
        ServerArray[nSockIndex].bo08 := False;
        ServerArray[nSockIndex].Socket := nil;
        Dec(nServerCount);
      end;
    end;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.ServerSocketClientDisconnect');
  end;
end;

procedure TFrmDBSrv.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
  ServerSocketClientConnected := False;
end;

procedure TFrmDBSrv.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  ServerInfo: pTServerInfo;
  nSockIndex: Integer;
  s10: string;
begin
  try
    dwKeepServerAliveTick := GetTickCount;
    g_CheckCode.dwThread0 := 1001000;
    nSockIndex := Socket.nIndex;
    if (nSockIndex >= Low(ServerArray)) and (nSockIndex <= High(ServerArray)) then begin
      g_CheckCode.dwThread0 := 1001001;
      ServerInfo := @ServerArray[nSockIndex];
      g_CheckCode.dwThread0 := 1001002;
      if ServerInfo.nSckHandle = Socket.SocketHandle then begin
        g_CheckCode.dwThread0 := 1001003;
        s10 := Socket.ReceiveText; //��ȡ����������
        Inc(n4ADBF4);
        if s10 <> '' then begin
          g_CheckCode.dwThread0 := 1001004;
          ServerInfo.sStr := ServerInfo.sStr + s10;
          g_CheckCode.dwThread0 := 1001005;
          if Pos('!', s10) > 0 then begin
            g_CheckCode.dwThread0 := 1001006;
            ProcessServerPacket(ServerInfo);
            g_CheckCode.dwThread0 := 1001007;
            Inc(n4ADBF8);
            Inc(n348);
          end else begin
            if Length(ServerInfo.sStr) > 81920 then begin
              ServerInfo.sStr := '';
              //Inc(n4ADC2C);
            end;
          end;
        end;
      end;
    end;
    g_CheckCode.dwThread0 := 1001008;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.ServerSocketClientRead');
  end;
end;

//���գ�M2(SendDBSockMsg)������������Ϣ
procedure TFrmDBSrv.ProcessServerPacket(ServerInfo: pTServerInfo);
var
  bo25: Boolean;
  SC, s1C, s20, s24: string;
  n14, n18: Integer;
  wE, w10: Word;
begin
  try
    g_CheckCode.dwThread0 := 1001100;
    if boOpenDBBusy then Exit;
    try
      bo25 := False;
      s1C := ServerInfo.sStr;
      ServerInfo.sStr := '';
      s20 := '';
      g_CheckCode.dwThread0 := 1001101;
      s1C := ArrestStringEx(s1C, '#', '!', s20);
      g_CheckCode.dwThread0 := 1001102;
      if s20 <> '' then begin
        g_CheckCode.dwThread0 := 1001103;
        s20 := GetValidStr3(s20, s24, ['/']);
        n14 := Length(s20);
        if (n14 >= DEFBLOCKSIZE) and (s24 <> '') then begin
          wE := Str_ToInt(s24, 0) xor 170;
          w10 := n14;
          n18 := MakeLong(wE, w10);
          SC := EncodeBuffer(@n18, SizeOf(Integer));
          ServerInfo.s34C := s24;
          if CompareBackLStr(s20, SC, Length(SC)) then begin
            g_CheckCode.dwThread0 := 1001104;
            ProcessServerMsg(s20, n14, ServerInfo);
            g_CheckCode.dwThread0 := 1001105;
            bo25 := True;
          end;
        end;
      end;
      if s1C <> '' then begin
        Inc(n4ADC00);
        Label4.Caption := '����A ' + IntToStr(n4ADC00);
      end;
      if not bo25 then begin
        m_DefMsg := MakeDefaultMsg(DBR_FAIL, 0, 0, 0, 0, 0);
        SendSocket(ServerInfo, EncodeMessage(m_DefMsg));
        Inc(n4ADC00);
        Label4.Caption := '����B ' + IntToStr(n4ADC00);
      end;
    finally
    end;
    g_CheckCode.dwThread0 := 1001106;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.ProcessServerPacket');
  end;
end;

procedure TFrmDBSrv.SendSocket(ServerInfo: pTServerInfo; sMsg: string);
var
  n10: Integer;
  s18: string;
begin
  try
    Inc(n4ADBFC);
    n10 := MakeLong(Str_ToInt(ServerInfo.s34C, 0) xor 170, Length(sMsg) + 6);
    s18 := EncodeBuffer(@n10, SizeOf(Integer));
    ServerInfo.Socket.SendText('#' + ServerInfo.s34C + '/' + sMsg + s18 + '!');
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.SendSocket');
  end;
end;
//���շ�����(M2)���������ݣ�����������
procedure TFrmDBSrv.ProcessServerMsg(sMsg: string; nLen: Integer; ServerInfo: pTServerInfo);
var
  sDefMsg, sData: string;
  DefMsg: TDefaultMessage;
begin
  try
    if nLen = DEFBLOCKSIZE then begin
      sDefMsg := sMsg;
      sData := '';
    end else begin
      sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
      sData := Copy(sMsg, DEFBLOCKSIZE + 1, Length(sMsg) - DEFBLOCKSIZE - 6);//20081216
      //sData := Copy(sMsg, DEFBLOCKSIZE + 7, Length(sMsg) - DEFBLOCKSIZE - 12);//20081210
    end;
    DefMsg := DecodeMessage(sDefMsg);
   // MemoLog.Lines.Add('DefMsg.Ident��:'+inttostr(DefMsg.Ident)+'    '+sMsg);
    case DefMsg.Ident of
      DB_LOADHUMANRCD: begin //��ȡ��������
          LoadHumanRcd(sData, ServerInfo);
        end;
      DB_NEWHERORCD:begin //�½�Ӣ��  20071018����
          NewHeroChr(sData, ServerInfo);
        end;
      DB_DELHERORCD:begin //ɾ��Ӣ��  20071018����
          DelHero(sData, ServerInfo);
        end;
      DB_LOADHERORCD: begin //��ȡӢ������ 20071017����
          LoadHeroRcd(SData, ServerInfo);
        end;
      DB_SAVEHUMANRCD: begin //������������
          SaveHumanRcd(DefMsg.Recog, sData, ServerInfo);
        end;
      DB_SAVEHERORCD: begin //����Ӣ������  20071017����
          SaveHeroRcd(DefMsg.Recog, sData, ServerInfo);
        end;
      DB_SAVEHUMANRCDEX: begin
          SaveHumanRcdEx(sData, DefMsg.Recog, ServerInfo);
        end;
      DB_QUERYHERORCD: begin//��ѯӢ��������� 20080514
          QueryHeroRcd(SData, ServerInfo);
        end;
    else begin
        m_DefMsg := MakeDefaultMsg(DBR_FAIL, 0, 0, 0, 0, 0);
        SendSocket(ServerInfo, EncodeMessage(m_DefMsg));
        Inc(n4ADC04);
        MemoLog.Lines.Add('ʧ�� ' + IntToStr(n4ADC04));
      end;
    end;
    g_CheckCode.dwThread0 := 1001216;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.ProcessServerMsg');
  end;
end;
//��ȡ��������
procedure TFrmDBSrv.LoadHumanRcd(sMsg: string; ServerInfo: pTServerInfo);
var   {sMsg�������������ļ��ܵ�����}
  sHumName: string;
  sAccount: string;
  sIPaddr: string;
  nIndex: Integer;
  nSessionID: Integer;
  nCheckCode: Integer;
  HumanRCD: THumDataInfo;
  LoadHuman: TLoadHuman;
  boFoundSession: Boolean;
begin
  try
    DecodeBuffer(sMsg, @LoadHuman, SizeOf(TLoadHuman));
    sAccount := LoadHuman.sAccount;
    sHumName := LoadHuman.sChrName;
    sIPaddr := LoadHuman.sUserAddr;
    nSessionID := LoadHuman.nSessionID;
    nCheckCode := -1;
    if (sAccount <> '') and (sHumName <> '') and (nSessionID >= 0) then begin
     { if (FrmIDSoc.CheckSessionLoadRcd(sAccount, sIPaddr, nSessionID, boFoundSession)) then begin    //20081230 ע��
        nCheckCode := 1;
      end else begin
        if boFoundSession then begin
          MainOutMessage('[�Ƿ��ظ�����] ' + '�ʺ�: ' + sAccount + ' IP: ' + sIPaddr + ' ��ʶ: ' + IntToStr(nSessionID));
        end else begin
          MainOutMessage('[�Ƿ�����A] ' + '�ʺ�: ' + sAccount + ' IP: ' + sIPaddr + ' ��ʶ: ' + IntToStr(nSessionID));
        end;
       // nCheckCode:= 1; //�����ã�����ȥ��
      end;}
      nCheckCode:= 1; //20081230
    end else begin
      MainOutMessage('[�Ƿ�����A] ' + '�ʺ�: ' + sAccount + ' IP: ' + sIPaddr + ' ��ʶ: ' + IntToStr(nSessionID));
    end;
    if nCheckCode = 1 then begin
      try
        if HumDataDB.OpenEx then begin
          nIndex := HumDataDB.Index(sHumName);
          if nIndex >= 0 then begin
            if HumDataDB.Get(nIndex, HumanRCD) < 0 then nCheckCode := -2;
          end else nCheckCode := -3;
        end else nCheckCode := -4;
      finally
        HumDataDB.Close();
      end;
    end;
    if nCheckCode = 1 then begin
      m_DefMsg := MakeDefaultMsg(DBR_LOADHUMANRCD, 1, 0, 0, 1, 0);
      SendSocket(ServerInfo, EncodeMessage(m_DefMsg) + EncodeString(sHumName) + '/' + EncodeBuffer(@HumanRCD, SizeOf(THumDataInfo)));
    end else begin
      m_DefMsg := MakeDefaultMsg(DBR_LOADHUMANRCD, nCheckCode, 0, 0, 0, 0);
      SendSocket(ServerInfo, EncodeMessage(m_DefMsg));
    end;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.LoadHumanRcd');
  end;
end;
//������������
procedure TFrmDBSrv.SaveHumanRcd(nRecog: Integer; sMsg: string; ServerInfo: pTServerInfo);
var
  sChrName: string;
  sUserId: string;
  sHumanRCD: string;
  nIndex: Integer;
  bo21: Boolean;
  HumanRCD: THumDataInfo;
begin
  try
    sHumanRCD := GetValidStr3(sMsg, sUserId, ['/']);
    sHumanRCD := GetValidStr3(sHumanRCD, sChrName, ['/']);
    sUserId := DecodeString(sUserId);
    sChrName := DecodeString(sChrName);
    bo21 := False;
    FillChar(HumanRCD.Data, SizeOf(THumData), #0);
    if Length(sHumanRCD) = GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) then
      DecodeBuffer(sHumanRCD, @HumanRCD, SizeOf(THumDataInfo))
    else bo21 := True;
    if not bo21 then begin
      bo21 := True;
      try
        if HumDataDB.Open then begin
          nIndex := HumDataDB.Index(sChrName);
          if nIndex < 0 then begin
            HumanRCD.Header.boIsHero := False;
            HumanRCD.Header.sName := sChrName;
            HumanRCD.Data.sAccount:=sUserId;
            HumDataDB.Add(HumanRCD);
            bo21 := False;//20081221
            //nIndex := HumDataDB.Index(sChrName);//20081221 ע��
          end else
          if nIndex >= 0 then begin
            HumanRCD.Header.boIsHero := False;
            HumanRCD.Header.sName := sChrName;
            HumanRCD.Data.sAccount:=sUserId;
            HumDataDB.Update(nIndex, HumanRCD);
            bo21 := False;
          end;
        end;
      finally
        HumDataDB.Close;
      end;
      //FrmIDSoc.SetSessionSaveRcd(sUserId);//20081223 �ƶ�λ�ã�����Ϣ����ٴ���
    end;
    if not bo21 then begin
      m_DefMsg := MakeDefaultMsg(DBR_SAVEHUMANRCD, 1, 0, 0, 0, 0);
      SendSocket(ServerInfo, EncodeMessage(m_DefMsg));
      //FrmIDSoc.SetSessionSaveRcd(sUserId);//20081223 ����Ϣ����ٴ���  20081230 ע��
    end else begin
      m_DefMsg := MakeDefaultMsg(DBR_LOADHUMANRCD, 0, 0, 0, 0, 0);
      SendSocket(ServerInfo, EncodeMessage(m_DefMsg));
    end;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.SaveHumanRcd');
  end;
end;
//ɾ��Ӣ��
procedure TFrmDBSrv.DelHero(sMsg: String; ServerInfo: pTServerInfo); //0x004A0610
var
  LoadHuman:TLoadHuman;
  sChrName: string;
  boCheck: Boolean;
  Msg: TDefaultMessage;
  ssMsg: string;
  n10: Integer;
  HumRecord: THumInfo;
  HumanRCD: THumDataInfo;//20080220
begin
  try
    g_CheckCode.dwThread0 := 1000300;
    DecodeBuffer(sMsg, @LoadHuman, SizeOf(LoadHuman));
    sChrName := {DecodeString(sData)}LoadHuman.sChrName;
    boCheck := False;
    g_CheckCode.dwThread0 := 1000301;
    try
      if HumChrDB.OpenEx then begin//20081224
        n10 := HumChrDB.Index(sChrName);
        if n10 >= 0 then begin
          HumChrDB.Get(n10, HumRecord);
          if HumRecord.sAccount = LoadHuman.sAccount then begin
            HumRecord.boDeleted := True;
            HumRecord.dModDate := Now();
            HumChrDB.Update(n10, HumRecord);
            boCheck := True;
          end;
        end;
      end;
  //--------------------------20080220--------------------------------------------
      if boCheck then begin//20081221
        if HumDataDB.OpenEx then begin//20081224
          n10 := HumDataDB.Index(sChrName);
          if n10 >= 0 then begin
            HumDataDB.Get(n10, HumanRCD);
            if HumanRCD.Data.sAccount = LoadHuman.sAccount then begin
              HumanRCD.Header.boDeleted := True;
              HumDataDB.Update(n10, HumanRCD);
            end;
          end;
        end;
      end;
  //------------------------------------------------------------------------------
    finally
      HumChrDB.Close;
      HumDataDB.Close;//20080220
    end;
    g_CheckCode.dwThread0 := 1000302;
    if boCheck then
      Msg := MakeDefaultMsg(DB_DELHERORCD, 1, 0, 0, 0, 0)
    else
      Msg := MakeDefaultMsg(DB_DELHERORCD, 0, 0, 0, 0, 0);

    ssMsg := EncodeMessage(Msg)+EncodeString(sChrName);
    SendSocket(ServerInfo,ssMsg);
    g_CheckCode.dwThread0 := 1000303;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.DelHero');
  end;
end;
//��ѯӢ������(��2��ȡ��Ӣ�۴�����ʾӢ����Ϣ) 20080514
procedure TFrmDBSrv.QueryHeroRcd(sMsg: string; ServerInfo: pTServerInfo);
var   {sMsg�������������ļ��ܵ�����}
  sHumName: string;
  sAccount: string;
  sIPaddr: string;
  nSessionID: Integer;
  nCheckCode: Integer;
  HumanRCD: THumDataInfo;
  LoadHeroHuman: TLoadHeroHuman;
  I, J: Integer;
  Str: String;
  HeroRCD: THeroDataInfo;

  ChrList: TStringList;
  QuickID: pTQuickID;
  HumRecord: THumInfo;
  sChrName: string;
  nIndex: Integer;
begin
  try
    DecodeBuffer(sMsg, @LoadHeroHuman, SizeOf(TLoadHeroHuman));
    sAccount := LoadHeroHuman.sAccount;//�˺�
    sHumName := LoadHeroHuman.sChrName;//ʦ����
    sIPaddr := LoadHeroHuman.sUserAddr;
    nSessionID := LoadHeroHuman.nSessionID;
    nCheckCode := -1;
    J:= 0;
    if (sAccount <> '') and (sHumName <> '') and (sIPaddr <>'') and (nSessionID >=0) then begin
      nCheckCode := 1;
    end;
//-----------------------------------------------------------------------------
//�ȼ�����Ӧ�˺ŵĽ�ɫ����Ȼ�ٲ�ָ���Ľ�ɫ��Ϣ���Լ��ٲ�ѯ���ٶ� 20081223
    if nCheckCode = 1 then begin
      ChrList := TStringList.Create;
      try
        if HumChrDB.Open and (HumChrDB.FindByAccount(sAccount, ChrList) >= 0) then begin
          try
            if HumDataDB.OpenEx then begin
              for i := 0 to ChrList.Count - 1 do begin
                QuickID := pTQuickID(ChrList.Objects[i]);
                if HumChrDB.GetBy(QuickID.nIndex, HumRecord) and (not HumRecord.boDeleted) then begin
                  sChrName := QuickID.sChrName;
                  nIndex := HumDataDB.Index(sChrName);
                  if (nIndex < 0) then Continue;
                  if HumDataDB.Get(nIndex, HumanRCD) >= 0 then begin
                    if (not HumanRCD.Data.boIsHero) or (HumanRCD.Header.boDeleted) then Continue;//����
                    if CompareText(HumanRCD.Data.sMasterName, sHumName) = 0 then begin
                      Inc(J);
                      HeroRCD.sChrName:=HumanRCD.Data.sChrName;
                      HeroRCD.Level:=HumanRCD.Data.Abil.Level;
                      HeroRCD.btSex:=HumanRCD.Data.btSex;
                      HeroRCD.btJob:=HumanRCD.Data.btJob;
                      HeroRCD.btType:=HumanRCD.Data.btEF;
                      Str:= Str + EncodeBuffer(@HeroRCD, SizeOf(THeroDataInfo))+'/';
                      if J >= 2 then break;//20081223 �鵽��Ӣ�����˳�ѭ��
                    end;
                  end;
                end;
              end;
            end else nCheckCode := -4;
          finally
            HumDataDB.Close;
          end;
        end else nCheckCode := -3;
      finally
        HumChrDB.Close;
        ChrList.Free;
      end;
    end;
//----------------------------------------------------------------------------
{    if nCheckCode = 1 then begin
      try
        if HumDataDB.OpenEx then begin
          if HumDataDB.count > 0 then begin
            for I:= 0 to HumDataDB.count -1 do begin
              if HumDataDB.Get(I, HumanRCD) >= 0 then begin
                if (not HumanRCD.Data.boIsHero) or (HumanRCD.Header.boDeleted) then Continue;//����
                if CompareText(HumanRCD.Data.sMasterName, sHumName) = 0 then begin
                   Inc(J);
                   HeroRCD.sChrName:=HumanRCD.Data.sChrName;
                   HeroRCD.Level:=HumanRCD.Data.Abil.Level;
                   HeroRCD.btSex:=HumanRCD.Data.btSex;
                   HeroRCD.btJob:=HumanRCD.Data.btJob;
                   HeroRCD.btType:=HumanRCD.Data.btEF;
                   Str:= Str + EncodeBuffer(@HeroRCD, SizeOf(THeroDataInfo))+'/';
                   if J >=2 then break;//20081223 �鵽��Ӣ�����˳�ѭ��
                end;
              end;
            end;
          end else nCheckCode := -3;
        end else nCheckCode := -4;
      finally
        HumDataDB.Close();
      end;
    end;  }
    if nCheckCode = 1 then begin
      m_DefMsg := MakeDefaultMsg(DB_QUERYHERORCD, 1, 0, 0, 1, 0);
      SendSocket(ServerInfo, EncodeMessage(m_DefMsg) + '/' + Str);
    end else begin
      m_DefMsg := MakeDefaultMsg(DB_QUERYHERORCD, nCheckCode, 0, 0, 0, 0);
      SendSocket(ServerInfo, EncodeMessage(m_DefMsg));
    end;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.QueryHeroRcd');
  end;
end;

//��ȡӢ������
procedure TFrmDBSrv.LoadHeroRcd(sMsg: string; ServerInfo: pTServerInfo);
var   {sMsg�������������ļ��ܵ�����}
  sHumName, sAccount, sIPaddr: string;
  nIndex, nCheckCode, nSessionID: Integer;
  HumanRCD: THumDataInfo;
  LoadHeroHuman: TLoadHeroHuman;
  //boFoundSession: Boolean;
begin
  try
    DecodeBuffer(sMsg, @LoadHeroHuman, SizeOf(TLoadHeroHuman));
    sAccount := LoadHeroHuman.sAccount;
    sHumName := LoadHeroHuman.sChrName;
    sIPaddr := LoadHeroHuman.sUserAddr;
    nSessionID := LoadHeroHuman.nSessionID;
    nCheckCode := -1;
    {boFoundSession := True;
    if (sAccount <> '') and (sHumName <> '') then begin
      FrmIDSoc.CheckSessionLoadRcd(sAccount, sIPaddr, nSessionID, boFoundSession);//20080902
      if boFoundSession then begin
        nCheckCode := 1;
      end else begin
        MainOutMessage('[�Ƿ�����B] ' + '�ʺ�: ' + sAccount + ' IP: ' + sIPaddr + ' ��ʶ: ' + IntToStr(nSessionID));
      end;
      //nCheckCode := 1;//20080902
    end; }
    if (sAccount <> '') and (sHumName <> '') and (sIPaddr <> '') and (nSessionID >= 0) then begin//20081224 ��ȡӢ�����ݣ������ỰID
      nCheckCode := 1;
    end else begin
      MainOutMessage('[�Ƿ�����B] ' + '�ʺ�: ' + sAccount + ' IP: ' + sIPaddr + ' ��ʶ: ' + IntToStr(nSessionID));
    end;
    
    if nCheckCode = 1 then begin
      try
        if HumDataDB.OpenEx then begin
          nIndex := HumDataDB.Index(sHumName);
          if nIndex >= 0 then begin
            if HumDataDB.Get(nIndex, HumanRCD) < 0 then nCheckCode := -2;     //��ʱ����������ж� 20080902
            if (not HumanRCD.Header.boIsHero) or (HumanRCD.Header.boDeleted) {or (CompareText(HumanRCD.Data.sAccount,sAccount) <> 0)} then nCheckCode := -4;//20080902 ����
          end else nCheckCode := -3;
        end else nCheckCode := -4;
      finally
        HumDataDB.Close();
      end;
    end;
    if nCheckCode = 1 then begin
      m_DefMsg := MakeDefaultMsg(DB_LOADHERORCD, 1, 0, 0, 1, 0);
      SendSocket(ServerInfo, EncodeMessage(m_DefMsg) + EncodeString(sHumName) + '/' + EncodeBuffer(@HumanRCD, SizeOf(THumDataInfo)));
    end else begin
      m_DefMsg := MakeDefaultMsg(DB_LOADHERORCD, nCheckCode, 0, 0, 0, 0);
      SendSocket(ServerInfo, EncodeMessage(m_DefMsg));
    end;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.LoadHeroRcd');
  end;
end;
//20081221 ����Ӣ������
procedure TFrmDBSrv.SaveHeroRcd(nRecog: Integer; sMsg: string;
  ServerInfo: pTServerInfo);
var
  sChrName: string;
  sUserId: string;
  sHumanRCD: string;
  nIndex: Integer;
  bo21: Boolean;
  HumanRCD: THumDataInfo;
begin
  try
    sHumanRCD := GetValidStr3(sMsg, sUserId, ['/']);
    sHumanRCD := GetValidStr3(sHumanRCD, sChrName, ['/']);
    sUserId := DecodeString(sUserId);
    sChrName := DecodeString(sChrName);
    bo21 := False;
    FillChar(HumanRCD.Data, SizeOf(THumData), #0);

    if Length(sHumanRCD) = GetCodeMsgSize(SizeOf(THumDataInfo) * 4 / 3) then begin
      DecodeBuffer(sHumanRCD, @HumanRCD, SizeOf(THumDataInfo));
    end else bo21 := True;

    if not bo21 then begin
      bo21 := True;
      try
        if HumDataDB.Open then begin
          nIndex := HumDataDB.Index(sChrName);
          if nIndex < 0 then begin
            HumanRCD.Header.boIsHero := True; //���Ա���
            HumanRCD.Data.sAccount := sUserId;
            HumanRCD.Header.sName := sChrName;
            HumDataDB.Add(HumanRCD);
            bo21 := False;//20081221
            //nIndex := HumDataDB.Index(sChrName);//20081221 �޸�
          end else
          if nIndex >= 0 then begin
            HumanRCD.Header.boIsHero := True; //���Ա���
            HumanRCD.Data.sAccount := sUserId;
            HumanRCD.Header.sName := sChrName;
            HumDataDB.Update(nIndex, HumanRCD);
            bo21 := False;
          end;
        end;
      finally
        HumDataDB.Close;
      end;
      //FrmIDSoc.SetSessionSaveRcd(sUserId);//20081224 ע�ͣ�Ӣ�۲������Ự��
    end;
    if not bo21 then begin
      m_DefMsg := MakeDefaultMsg(DB_SAVEHERORCD, 1, 0, 0, 0, 0);
      SendSocket(ServerInfo, EncodeMessage(m_DefMsg));
    end else begin
      m_DefMsg := MakeDefaultMsg(DBR_LOADHERORCD, 0, 0, 0, 0, 0);
      SendSocket(ServerInfo, EncodeMessage(m_DefMsg));
    end;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.SaveHeroRcd');
  end;
end;

//����Ӣ��   20071019
procedure TFrmDBSrv.NewHeroChr(sData: string; ServerInfo: pTServerInfo);
var
  Data, sAccount, sChrName, sHair, sJob, sSex,sIsHero,sMasterName,sHeroType: string;
  boIsHero:Boolean;
  nCode: Integer;
  Msg: TDefaultMessage;
  sMsgs: string;
  HumRecord: THumInfo;
  HumanRCD: THumDataInfo;
  I {,K}: Integer;
begin
  try
    nCode := -1;
    Data := DecodeString(sData);
    Data := GetValidStr3(Data, sAccount, ['/']);
    Data := GetValidStr3(Data, sChrName, ['/']);
    Data := GetValidStr3(Data, sHair, ['/']);
    Data := GetValidStr3(Data, sJob, ['/']);
    Data := GetValidStr3(Data, sSex, ['/']);
    Data := GetValidStr3(Data, sIsHero, ['/']);
    Data := GetValidStr3(Data, sMasterName, ['/']);//�������� 20080408
    Data := GetValidStr3(Data, sHeroType, ['/']);//Ӣ������ 20080514

    boIsHero := StrToBool(sIsHero);
    if Trim(Data) <> '' then nCode := 0;
    sChrName := Trim(sChrName);
    if Length(sChrName) < 3 then nCode := 0;
    if not FrmUserSoc.CheckDenyChrName(sChrName) then nCode := 2;
    if not CheckChrName(sChrName) then nCode := 0;
    if not boDenyChrName then begin
      for i := 1 to Length(sChrName) do begin
        if (sChrName[i] = #$A1) or (sChrName[i] = ' ') or (sChrName[i] = '/') or
          (sChrName[i] = '@') or (sChrName[i] = '?') or (sChrName[i] = '''') or
          (sChrName[i] = '"') or (sChrName[i] = '\') or (sChrName[i] = '.') or
          (sChrName[i] = ',') or (sChrName[i] = ':') or (sChrName[i] = ';') or
          (sChrName[i] = '`') or (sChrName[i] = '~') or (sChrName[i] = '!') or
          (sChrName[i] = '#') or (sChrName[i] = '$') or (sChrName[i] = '%') or
          (sChrName[i] = '^') or (sChrName[i] = '&') or (sChrName[i] = '*') or
          (sChrName[i] = '(') or (sChrName[i] = ')') or (sChrName[i] = '-') or
          (sChrName[i] = '_') or (sChrName[i] = '+') or (sChrName[i] = '=') or
          (sChrName[i] = '|') or (sChrName[i] = '[') or (sChrName[i] = '{') or
          (sChrName[i] = ']') or (sChrName[i] = '}') then nCode := 0;
      end;
    end;
    //K:= 0;
    if nCode = -1 then begin
      try
        HumDataDB.Lock;
        if HumDataDB.Index(sChrName) >= 0 then nCode := 2;//�鿴�����Ƿ��ظ�
      finally
        HumDataDB.UnLock;
      end;
      {if nCode = -1 then begin//����û�ظ��ż������Ӣ���� 20081221    //20081224 ע��
        try
          if HumDataDB.OpenEx then begin//��ѯ����Ӣ����
            if HumDataDB.count > 0 then begin
              for I:= 0 to HumDataDB.count -1 do begin
                if HumDataDB.Get(I, HumanRCD) >= 0 then begin
                  if (HumanRCD.Header.boDeleted) or (not HumanRCD.Data.boIsHero) then Continue;//����
                  if CompareText(HumanRCD.Data.sMasterName, sMasterName)= 0 then Inc(K);
                end;
              end;
            end;
          end;
        finally
          HumDataDB.Close();
        end;
      end; }
    end;
    if nCode = -1 then begin
      try
        if HumChrDB.Open then begin
          //MainOutMessage('AAAA '+inttostr(HumChrDB.HeroChrCountOfAccount(sAccount))+'   '+inttostr(K));
          if (HumChrDB.HeroChrCountOfAccount(sAccount) < 4) {and (K < 2)} then begin//20080515 �˺�Ӣ�������ܴ���4,����һ����ɫֻ����2��Ӣ��
            FillChar(HumRecord, SizeOf(THumInfo), #0);
            HumRecord.sChrName := sChrName;
            HumRecord.sAccount := sAccount;
            HumRecord.boDeleted := False;
            HumRecord.Header.boIsHero:= True;//��Ӣ�� 20080408
            HumRecord.btCount := 0;
            HumRecord.Header.sName := sChrName;
            if HumRecord.Header.sName <> '' then
            if not HumChrDB.Add(HumRecord) then nCode := 2;
          end else nCode:= 3;
        end;
      finally
        HumChrDB.Close;
      end;

      if nCode = -1 then begin
        if FrmUserSoc.NewHeroChrData(sAccount,sChrName, Str_ToInt(sSex, 0), Str_ToInt(sJob, 0), Str_ToInt(sHair, 0),Str_ToInt(sHeroType, 0),boIsHero, sMasterName) then
          nCode := 1;
      end else begin
        FrmDBSrv.DelHum(sChrName);
        nCode := 4;
      end;
    end;

    if nCode = 1 then begin
      Msg := MakeDefaultMsg(DB_NEWHERORCD, 1, 0, 0, 0, 0);
    end else begin
      Msg := MakeDefaultMsg(DB_NEWHERORCD, nCode, 0, 0, 0, 0);  //���� 2007.11.13
    end;
    sMsgs := EncodeMessage(Msg)+EncodeString(sChrName);

    SendSocket(ServerInfo,sMsgs);
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.NewHeroChr');
  end;
end;

procedure TFrmDBSrv.SaveHumanRcdEx(sMsg: string; nRecog: Integer; ServerInfo: pTServerInfo);
var
  sChrName: string;
  sUserId: string;
  sHumanRCD: string;
begin
  try
    sHumanRCD := GetValidStr3(sMsg, sUserId, ['/']);
    sHumanRCD := GetValidStr3(sHumanRCD, sChrName, ['/']);
    sUserId := DecodeString(sUserId);
    sChrName := DecodeString(sChrName);
    SaveHumanRcd(nRecog, sMsg, ServerInfo);
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.SaveHumanRcdEx');
  end;
end;

procedure TFrmDBSrv.Timer1Timer(Sender: TObject);
var
  i: Integer;
begin
  LbTransCount.Caption := IntToStr(n348);
  n348 := 0;
  if nServerCount > 0 then
    Label1.Caption := '������...'
  else Label1.Caption := 'δ���� !!';
  Label2.Caption := '������: ' + IntToStr(nServerCount);
  LbUserCount.Caption := IntToStr(FrmUserSoc.GetUserCount);
  if boOpenDBBusy then begin
    if n4ADB18 > 0 then begin
      if not bo4ADB1C then begin
        Label4.Caption := '[1/4] ' + IntToStr(Round((n4ADB10 / n4ADB18) * 1.0E2)) + '% ' +
          IntToStr(n4ADB14) + '/' +
          IntToStr(n4ADB18);
      end;
    end;
    if n4ADB04 > 0 then begin
      if not boHumDBReady then begin
        Label4.Caption := '[3/4] ' + IntToStr(Round((n4ADAFC / n4ADB04) * 1.0E2)) + '% ' +
          IntToStr(n4ADB00) + '/' +
          IntToStr(n4ADB04);
      end;
    end;
    if n4ADAF0 > 0 then begin
      if not boDataDBReady then begin
        Label4.Caption := '[4/4] ' + IntToStr(Round((n4ADAE4 / n4ADAF0) * 1.0E2)) + '% ' +
          IntToStr(n4ADAE8) + '/' +
          IntToStr(n4ADAEC) + '/' +
          IntToStr(n4ADAF0);
      end;
    end;
  end;

  LbAutoClean.Caption := IntToStr(g_nClearIndex) + '/(' + IntToStr(g_nClearCount) + '/' + IntToStr(g_nClearItemIndexCount) + ')/' + IntToStr(g_nClearRecordCount);
  Label8.Caption := 'H-QyChr=' + IntToStr(g_nQueryChrCount);
  Label9.Caption := 'H-NwChr=' + IntToStr(nHackerNewChrCount);
  Label10.Caption := 'H-DlChr=' + IntToStr(nHackerDelChrCount);
  Label11.Caption := 'Dubb-Sl=' + IntToStr(nHackerSelChrCount);
  EnterCriticalSection(g_OutMessageCS);
  try
    ShowModule();
    for i := 0 to g_MainMsgList.Count - 1 do begin
      MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' + g_MainMsgList.Strings[i]);
    end;
    g_MainMsgList.Clear;
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
  if MemoLog.Lines.Count > 200 then MemoLog.Lines.Clear;
end;

procedure TFrmDBSrv.ShowModule();
//var
//  nIndex: Integer;
//  dwTempTick, dwAliveTick: LongWord;
  function GetModule(nPort: Integer): Boolean;
  var
    i: Integer;
    Items: TListItem;
  begin
    Result := False;
    ListView.Items.BeginUpdate;
    try
      for i := 0 to FrmDBSrv.ListView.Items.Count - 1 do begin
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
  function GetSelectTickStr(): string;
  var
    s01, s02: string;
  begin
    s01 := IntToStr(dwKeepAliveTick);
    s01 := Copy(s01, Length(s01) - 4, 4);
    s02 := IntToStr(GetTickCount + dwKeepAliveTick);
    s02 := Copy(s02, Length(s02) - 4, 4);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    Result := Format('%s%s%s', [s01, '/', s02]);
  end;
  function GetIDServerTickStr(): string;
  var
    s01, s02: string;
  begin
    s01 := IntToStr(dwKeepIDAliveTick);
    s01 := Copy(s01, Length(s01) - 4, 4);
    s02 := IntToStr(GetTickCount + dwKeepIDAliveTick);
    s02 := Copy(s02, Length(s02) - 4, 4);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    Result := Format('%s%s%s', [s01, '/', s02]);
  end;
  function GetM2ServerTickStr(): string;
  var
    s01, s02: string;
  begin
    s01 := IntToStr(dwKeepServerAliveTick);
    s01 := Copy(s01, Length(s01) - 4, 4);
    s02 := IntToStr(GetTickCount + dwKeepServerAliveTick);
    s02 := Copy(s02, Length(s02) - 4, 4);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s01) > 1) and (s01[1] = '0') then s01 := Copy(s01, 2, Length(s01) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    if (Length(s02) > 1) and (s02[1] = '0') then s02 := Copy(s02, 2, Length(s02) - 1);
    Result := Format('%s%s%s', [s01, '/', s02]);
  end;
begin
  if UserSocketClientConnected then begin
    if GetModule(g_nGatePort) then
      UpDateModule(g_nGatePort, '��ɫ����', User_sRemoteAddress + ':' + IntToStr(User_nRemotePort) + ' �� ' + User_sRemoteAddress + ':' + IntToStr(g_nGatePort), GetSelectTickStr())
    else AddModule(g_nGatePort, '��ɫ����', User_sRemoteAddress + ':' + IntToStr(User_nRemotePort) + ' �� ' + User_sRemoteAddress + ':' + IntToStr(g_nGatePort), GetSelectTickStr());
  end else begin
    if GetModule(g_nGatePort) then DelModule(g_nGatePort);
  end;
  if IDSocketConnected then begin
    if GetModule(nIDServerPort) then
      UpDateModule(nIDServerPort, sServerName, ID_sRemoteAddress + ':' + IntToStr(ID_nRemotePort) + ' �� ' + ID_sRemoteAddress + ':' + IntToStr(nIDServerPort), GetIDServerTickStr())
    else AddModule(nIDServerPort, sServerName, ID_sRemoteAddress + ':' + IntToStr(ID_nRemotePort) + ' �� ' + ID_sRemoteAddress + ':' + IntToStr(nIDServerPort), GetIDServerTickStr());
  end else begin
    if GetModule(nIDServerPort) then DelModule(nIDServerPort);
  end;
  if ServerSocketClientConnected then begin
    if GetModule(nServerPort) then
      UpDateModule(nServerPort, '��Ϸ����', Server_sRemoteAddress + ':' + IntToStr(Server_nRemotePort) + ' �� ' + Server_sRemoteAddress + ':' + IntToStr(nServerPort), GetM2ServerTickStr())
    else AddModule(nServerPort, '��Ϸ����', Server_sRemoteAddress + ':' + IntToStr(Server_nRemotePort) + ' �� ' + Server_sRemoteAddress + ':' + IntToStr(nServerPort), GetM2ServerTickStr());
  end else begin
    if GetModule(nServerPort) then DelModule(nServerPort);
  end;
  {if DataManageSocketClientConnected then begin
    if GetModule(nDataManagePort) then
      UpDateModule(nDataManagePort, '���ݹ���', DataManage_sRemoteAddress + ':' + IntToStr(DataManage_nRemotePort) + ' �� ' + DataManage_sRemoteAddress + ':' + IntToStr(nServerPort), '')
    else AddModule(nDataManagePort, '���ݹ���', DataManage_sRemoteAddress + ':' + IntToStr(DataManage_nRemotePort) + ' �� ' + DataManage_sRemoteAddress + ':' + IntToStr(nServerPort), '');
  end else begin
    if GetModule(nDataManagePort) then DelModule(nDataManagePort);
  end;}
end;

procedure TFrmDBSrv.ResServerArray;
var
  nSockIndex: Integer;
begin
  try
    for nSockIndex := Low(ServerArray) to High(ServerArray) do begin
      ServerArray[nSockIndex].nSckHandle := 0;
      ServerArray[nSockIndex].sStr := '';
      ServerArray[nSockIndex].s34C := '';
      ServerArray[nSockIndex].bo08 := False;
      ServerArray[nSockIndex].Socket := nil;
    end;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.ResServerArray');
  end;
end;

procedure TFrmDBSrv.FormCreate(Sender: TObject);
var
//  Conf: TIniFile;
  nX, nY: Integer;
begin
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  nX := Str_ToInt(ParamStr(2), -1);
  nY := Str_ToInt(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;
  m_boRemoteClose := False;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  MainOutMessage('�����������ݿ������...');
  boOpenDBBusy := True;
  Label4.Caption := '';
  LbAutoClean.Caption := '-/-';
  HumChrDB := nil;
  HumDataDB := nil;
  LoadConfig();
  ResServerArray;
  nServerCount := 0;
  AttackIPaddrList := TGList.Create; //����IP��ʱ�б�

  n334 := 0;
  n4ADBF4 := 0;
  n4ADBF8 := 0;
  n4ADBFC := 0;
  n4ADC00 := 0;
  n4ADC04 := 0;
  n344 := 2;
  n348 := 0;
  nHackerNewChrCount := 0;
  nHackerDelChrCount := 0;
  nHackerSelChrCount := 0;
  n4ADC1C := 0;
  n4ADC20 := 0;
  n4ADC24 := 0;
  n4ADC28 := 0;
  SendGameCenterMsg(SG_STARTNOW, '�����������ݿ������...');
  StartTimer.Enabled := True;
end;

procedure TFrmDBSrv.StartTimerTimer(Sender: TObject);
begin
  StartTimer.Enabled := False;
  if SizeOf(THumDataInfo) <> 4430 then begin //20081227
    ShowMessage('sizeof(THuman) ' + IntToStr(SizeOf(THumDataInfo)) + ' <> SIZEOFTHUMAN ' + '4430');
    Close;
    Exit;
  end;
  ListView.Items.Clear;
  boOpenDBBusy := True;
  HumChrDB := TFileHumDB.Create(sHumDBFilePath + 'Hum.DB');
  HumDataDB := TFileDB.Create(sDataDBFilePath + 'Mir.DB');

  boOpenDBBusy := False;
  boAutoClearDB := True;
  Label4.Caption := '';
//----------------------20080219----------------------------------------------
  LoadFiltrateUserNameList();//��ȡ���ֹ����б� 20080220
  LoadFiltrateSortNameList();//��ȡ�ַ������б� 20080220
//------------------------------------------------------------------------------
  LoadItemsDB(); //������Ʒ����
  LoadMagicDB(); //���ؼ�������
  ServerSocket.Address := sServerAddr;
  ServerSocket.Port := nServerPort;
  ServerSocket.Active := True;
  FrmIDSoc.OpenConnect();
  MainOutMessage('������������...');
  SendGameCenterMsg(SG_STARTOK, '���ݿ�������������...');
  AutoSort.Enabled:= True;//20080220
  SendGameCenterMsg(SG_CHECKCODEADDR, IntToStr(Integer(@g_CheckCode)));
  if boMinimize then Application.Minimize;
end;

procedure TFrmDBSrv.FormDestroy(Sender: TObject);
var
  i : Integer;
begin
  if HumDataDB <> nil then HumDataDB.Free;
  if HumChrDB <> nil then HumChrDB.Free;

  AttackIPaddrList.Lock;
  try
    for i := 0 to AttackIPaddrList.Count - 1 do begin
      Dispose(pTSockaddr(AttackIPaddrList.Items[i]));
    end;
  finally
    AttackIPaddrList.UnLock;
  end;
  AttackIPaddrList.Free;
end;

procedure TFrmDBSrv.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if m_boRemoteClose then Exit;
  if Application.MessageBox('�Ƿ�ȷ���˳����ݿ������ ?', 'ȷ����Ϣ', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    CanClose := True;
    ServerSocket.Active := False;
    MainOutMessage('���ڹرշ�����...');
  end else begin
    CanClose := False;
  end;
end;
//������Ʒ����
function TFrmDBSrv.LoadItemsDB(): Integer;
var
  i, Idx: Integer;
  StdItem: pTStdItem;
  nRecordCount: Integer;
resourcestring
  sSQLString = 'select * from StdItems';
begin
  MainOutMessage('���ڼ�����Ʒ����...');
  try
    Result := -1;
    Query.SQL.Clear;
    Query.DatabaseName := sHeroDB;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -2;
    end;
    nRecordCount := Query.RecordCount;
    for i := 0 to nRecordCount - 1 do begin
      New(StdItem);
      Idx := Query.FieldByName('Idx').AsInteger;
      StdItem.Name := Query.FieldByName('Name').AsString;
      StdItem.StdMode := Query.FieldByName('StdMode').AsInteger;
      StdItem.Shape := Query.FieldByName('Shape').AsInteger;
      StdItem.Weight := Query.FieldByName('Weight').AsInteger;
      StdItem.AniCount := Query.FieldByName('AniCount').AsInteger;
      StdItem.Source := Query.FieldByName('Source').AsInteger;
      StdItem.Reserved := Query.FieldByName('Reserved').AsInteger;
      StdItem.Looks := Query.FieldByName('Looks').AsInteger;
      StdItem.DuraMax := Word(Query.FieldByName('DuraMax').AsInteger);
      StdItem.AC := MakeLong(Round(Query.FieldByName('Ac').AsInteger), Round(Query.FieldByName('Ac2').AsInteger));
      StdItem.MAC := MakeLong(Round(Query.FieldByName('Mac').AsInteger), Round(Query.FieldByName('MAc2').AsInteger));
      StdItem.DC := MakeLong(Round(Query.FieldByName('Dc').AsInteger), Round(Query.FieldByName('Dc2').AsInteger));
      StdItem.MC := MakeLong(Round(Query.FieldByName('Mc').AsInteger), Round(Query.FieldByName('Mc2').AsInteger));
      StdItem.SC := MakeLong(Round(Query.FieldByName('Sc').AsInteger), Round(Query.FieldByName('Sc2').AsInteger));
      StdItem.Need := Query.FieldByName('Need').AsInteger;
      StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;
      StdItem.Price := Query.FieldByName('Price').AsInteger;
      if StdItemList.Count = Idx then begin
        StdItemList.Add(StdItem);
        Result := 1;
      end else begin
        MainOutMessage(Format('������Ʒ(Idx:%d Name:%s)����ʧ�ܣ�����', [Idx, StdItem.Name]));
        Result := -100;
        Exit;
      end;
      Query.Next;
    end;
    Result := nRecordCount;
    MainOutMessage(Format('��Ʒ���ݿ�������(%d)...', [nRecordCount]));
  finally
    Query.Close;
  end;
end;
//���ؼ������ݿ�
function TFrmDBSrv.LoadMagicDB(): Integer;
var
  i, nRecordCount: Integer;
  Magic: pTMagic;
resourcestring
  sSQLString = 'select * from Magic';
begin
  Result := -1;
  MainOutMessage('���ڼ��ؼ������ݿ�...');
  Query.SQL.Clear;
  Query.DatabaseName := sHeroDB;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
  finally
    Result := -2;
  end;
  nRecordCount := Query.RecordCount;
  for i := 0 to nRecordCount - 1 do begin
    New(Magic);
    Magic.wMagicId := Query.FieldByName('MagId').AsInteger;
    Magic.sMagicName := Query.FieldByName('MagName').AsString;
    Magic.btEffectType := Query.FieldByName('EffectType').AsInteger;
    Magic.btEffect := Query.FieldByName('Effect').AsInteger;
    Magic.wSpell := Query.FieldByName('Spell').AsInteger;
    Magic.wPower := Query.FieldByName('Power').AsInteger;
    Magic.wMaxPower := Query.FieldByName('MaxPower').AsInteger;
    Magic.btJob := Query.FieldByName('Job').AsInteger;
    Magic.TrainLevel[0] := Query.FieldByName('NeedL1').AsInteger;
    Magic.TrainLevel[1] := Query.FieldByName('NeedL2').AsInteger;
    Magic.TrainLevel[2] := Query.FieldByName('NeedL3').AsInteger;
    Magic.TrainLevel[3] := Query.FieldByName('NeedL3').AsInteger;
    Magic.MaxTrain[0] := Query.FieldByName('L1Train').AsInteger;
    Magic.MaxTrain[1] := Query.FieldByName('L2Train').AsInteger;
    Magic.MaxTrain[2] := Query.FieldByName('L3Train').AsInteger;
    Magic.MaxTrain[3] := Magic.MaxTrain[2];
    Magic.btTrainLv := 3;
    Magic.dwDelayTime := Query.FieldByName('Delay').AsInteger;
    Magic.btDefSpell := Query.FieldByName('DefSpell').AsInteger;
    Magic.btDefPower := Query.FieldByName('DefPower').AsInteger;
    Magic.btDefMaxPower := Query.FieldByName('DefMaxPower').AsInteger;
    Magic.sDescr := Query.FieldByName('Descr').AsString;
    if Magic.wMagicId > 0 then begin
      MagicList.Add(Magic);
    end else begin
      Dispose(Magic);
    end;
    Result := 1;
    Query.Next;
  end;
  Query.Close;
  MainOutMessage(Format('�������ݿ�������(%d)...', [nRecordCount]));
end;

procedure TFrmDBSrv.AniTimerTimer(Sender: TObject);
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

procedure TFrmDBSrv.BtnUserDBToolClick(Sender: TObject);
begin
  if boHumDBReady and boDataDBReady then
    FrmIDHum.Show;
end;

procedure TFrmDBSrv.CkViewHackMsgClick(Sender: TObject);
var
  Conf: TIniFile;
begin
  boViewHackMsg:= CkViewHackMsg.Checked;//20080928 ����
  Conf := TIniFile.Create(sConfFileName);
  if Conf <> nil then begin
    Conf.WriteBool('Setup', 'ViewHackMsg', CkViewHackMsg.Checked);
    Conf.Free;
  end;
end;

procedure TFrmDBSrv.ClearSocket(Socket: TCustomWinSocket);
begin

end;

function TFrmDBSrv.CopyHumData(sSrcChrName, sDestChrName,
  sUserId: string): Boolean;
var
  n14: Integer;
  bo15: Boolean;
  HumanRCD: THumDataInfo;
begin
  Result := False;
  try
    bo15 := False;
    try
      if HumDataDB.Open then begin
        n14 := HumDataDB.Index(sSrcChrName);
        if (n14 >= 0) and (HumDataDB.Get(n14, HumanRCD) >= 0) then bo15 := True;
        if bo15 then begin
          n14 := HumDataDB.Index(sDestChrName);
          if (n14 >= 0) then begin
            HumanRCD.Header.sName := sDestChrName;
            HumanRCD.Data.sChrName := sDestChrName;
            HumanRCD.Data.sAccount := sUserId;
            HumDataDB.Update(n14, HumanRCD);
            Result := True;
          end;
        end;
      end;
    finally
      HumDataDB.Close;
    end;
  except
    if boViewHackMsg then MainOutMessage('[�쳣] TFrmDBSrv.CopyHumData');
  end;
end;
//ɾ����������
procedure TFrmDBSrv.DelHum(sChrName: string);
begin
  try
    if HumChrDB.Open then HumChrDB.Delete(sChrName);
  finally
    HumChrDB.Close;
  end;
end;

procedure TFrmDBSrv.MENU_MANAGE_DATAClick(Sender: TObject);
begin
  if boHumDBReady and boDataDBReady then
    FrmIDHum.Show;
end;

procedure TFrmDBSrv.MENU_MANAGE_TOOLClick(Sender: TObject);
begin
  frmDBTool.Top := Self.Top + 20;
  frmDBTool.Left := Self.Left;
  frmDBTool.Open();
end;

procedure TFrmDBSrv.MyMessage(var MsgData: TWmCopyData);
var
  sData: string;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of
    GS_QUIT: begin
        ServerSocket.Active := False;
        m_boRemoteClose := True;
        Close();
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TFrmDBSrv.MENU_TEST_SELGATEClick(Sender: TObject);
begin
  frmTestSelGate := TfrmTestSelGate.Create(Owner);
  frmTestSelGate.ShowModal;
  frmTestSelGate.Free;
end;

procedure TFrmDBSrv.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  if Sender = MENU_CONTROL_START then begin

  end else
    if Sender = MENU_OPTION_GAMEGATE then begin
    frmRouteManage.Open;
  end;
end;

procedure TFrmDBSrv.G1Click(Sender: TObject);
begin
  try
    FrmUserSoc.LoadServerInfo();
    LoadIPTable();
    LoadGateID();
    MainOutMessage('���������������...');
  except
    MainOutMessage('������������ʧ��...');
  end;
end;

procedure TFrmDBSrv.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  MemoLog.Lines.Add(E.Message);
end;

procedure TFrmDBSrv.X1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmDBSrv.N3Click(Sender: TObject);
begin
  {MainOutMessage(g_sVersion);
  MainOutMessage(g_sUpDateTime);
  MainOutMessage(g_sProgram);
  MainOutMessage(g_sWebSite);
  MainOutMessage(g_sWebSite1); }
  FrmAbout := TFrmAbout.Create(Owner);
  FrmAbout.Open();
  FrmAbout.Free;
end;

procedure TFrmDBSrv.MENU_OPTION_GENERALClick(Sender: TObject);
begin
  FrmSetting := TFrmSetting.Create(Owner);
  FrmSetting.Open;
  FrmSetting.Free;
end;

procedure TFrmDBSrv.N4Click(Sender: TObject);
begin
  APPLICATION.CreateForm(THumanOrderFrm,HumanOrderFrm); //���а���� 20080219
  HumanOrderFrm.SHOWMODAL;
  HumanOrderFrm.FREE;
end;

procedure TFrmDBSrv.AutoSortTimer(Sender: TObject);
var
  Min, Hour, Sec, Ms:Word;
begin
  if m_boAutoSort then begin //�Զ�����
    case nSortClass of
      0:begin//ÿ��
         if (GetTickCount - m_dwBakTick) > (nSortHour * 3600 + nSortMinute * 60) * 1000 then begin
           m_dwBakTick := GetTickCount();
           try
             if not boHumanOrder then RecHumanOrder;//20080315 �����߳�,ֱ���ù�������
           except
             if boViewHackMsg then MainOutMessage('[�쳣] �Զ�����ʧ��1...');
           end;
         end;
       end;
      1:begin//ÿ��
         DecodeTime(Time, Hour, Min, Sec, Ms);
         if (Hour = nSortHour) and (Min = nSortMinute) and (Sec = 01) then begin
            try
              if not boHumanOrder then RecHumanOrder; //20080315 �����߳�,ֱ���ù�������
            except
              if boViewHackMsg then MainOutMessage('[�쳣] �Զ�����ʧ��2...');
            end;
         end;
       end;
    end;
  end;
end;

procedure TFrmDBSrv.N6Click(Sender: TObject);
begin
  APPLICATION.CreateForm(TSetDisableListFrm,SetDisableListFrm); //���а�������� 20080220
  SetDisableListFrm.SHOWMODAL;
  SetDisableListFrm.FREE;
end;

{����������ɫ,�˺Ŵ�000-199,һ���˺Ŵ���������ɫ 20080525
procedure TFrmDBSrv.Button1Click(Sender: TObject);
var
  Data, sAccount, sChrName, sHair, sJob, sSex: string;
  nCode: Integer;
  HumRecord: THumInfo;
  I: Integer;
  k,J:integer;
begin
for K:=0 to 199 do begin
  sAccount :=FormatFloat('000',K);
  sHair :='0';
  sJob :='0';
  sSex :='0';
  for J:=0 to 1 do begin
  nCode := -1;
  sChrName :=sAccount+inttostr(J);
  if nCode = -1 then begin
    try
      try
      if HumDataDB.Open then begin
      HumDataDB.Lock;
      if HumDataDB.Index(sChrName) >= 0 then nCode := 2;
      end;
     finally
      HumDataDB.Close;
    end;
    finally
      HumDataDB.UnLock;
    end;
  end;
  if nCode = -1 then begin
    try
      if HumChrDB.Open then begin
        if HumChrDB.ChrCountOfAccount(sAccount) < 2 then begin//����Խ��2����ɫ
          FillChar(HumRecord, SizeOf(THumInfo), #0);
          HumRecord.sChrName := sChrName;//����
          HumRecord.sAccount := sAccount;//��¼�˺�
          HumRecord.boDeleted := False;
          HumRecord.btCount := 0;
          HumRecord.Header.sName := HumRecord.sChrName;
          HumRecord.Header.boIsHero:= False;//20080515
          HumRecord.Header.nSelectID := 28;
          if HumRecord.Header.sName <> '' then
            if not HumChrDB.Add(HumRecord) then nCode := 2;
        end else nCode:= 3;
      end;
    finally
      HumChrDB.Close;
    end;
    if nCode = -1 then begin
      if FrmUserSoc.NewChrData(sChrName, Str_ToInt(sSex, 0), Str_ToInt(sJob, 0), Str_ToInt(sHair, 0)) then
        nCode := 1;
    end else begin
      FrmDBSrv.DelHum(sChrName);
      nCode := 4;
    end;
  end;
  end;
end;
end; }

end.


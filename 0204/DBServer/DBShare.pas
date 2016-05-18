unit DBShare;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket, WinSock, IniFiles, Grobal2,
  MudUtil, Common, HumDB;

const
  g_sProductName = '61284E6430922F6EB45CC2736C6D7F8DCFA5313C50C50CE4'; //IGE�Ƽ����ݿ������
  g_sVersion = 'AF7BE30A93DDA7B52F344FC7EADF5DF9BDCF5B8070D2B211';  //2.00 Build 20081231
  g_sUpDateTime = '06B8C6D3CEBD9FAD41CB00DED3803788'; //2008/12/31
  g_sProgram = 'C0CB995DE0C2A55814577F81CCE3A3BD'; //IGE�Ƽ�
  g_sWebSite = 'E14A1EC77CDEF28A670B57F56B07D834D8758E442B312AF440574B5A981AB1752C73BF5C6670B79C'; // http://www.IGEM2.com(����վ)
  g_sBbsSite = '2E5A58E761D583C119D6606E0F38D7A9D8758E442B312AF440574B5A981AB17538E97FF2F0C39555'; //http://www.IGEM2.com.cn(����վ)
  //g_sProductInfo = '8DFDF45695C4099770F02197A7BCE1C5B07D1DD7CD1455D1783D523EA941CBFB'; //��ӭʹ��IGE����ϵ�����:
  //g_sSellInfo1 = '71043F0BD11D04C7BA0E09F9A2EF83B7B936E13B070575B9';//��ϵ(QQ):228589790

type
  TGList = class(TList)
  private
    GLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  TSockaddr = record
    nIPaddr: Integer;
    dwStartAttackTick: LongWord;
    nAttackCount: Integer;
  end;
  pTSockaddr = ^TSockaddr;

  TCheckCode = record
    dwThread0: LongWord;
  end;
  TGateInfo = record
    Socket: TCustomWinSocket;
    sGateaddr: string; //0x04
    sText: string; //0x08
    UserList: TList; //0x0C
    dwTick10: LongWord; //0x10
    nGateID: Integer; //����ID
  end;
  pTGateInfo = ^TGateInfo;
  TUserInfo = record
    sAccount: string; //0x00
    sUserIPaddr: string; //0x0B
    sGateIPaddr: string;
    sConnID: string; //0x20
    nSessionID: Integer; //0x24
    Socket: TCustomWinSocket;
    s2C: string; //0x2C
    boChrSelected: Boolean; //0x30
    boChrQueryed: Boolean; //��ɫ��Ϣ�Ƿ���Բ�ѯ
    dwTick34: LongWord; //0x34
    dwChrTick: LongWord; //0x38
    nSelGateID: ShortInt; //��ɫ����ID
    nDataCount: Integer;
    sRandomCode: String;//��֤�� 20080612
    boRandomCode: Boolean; //�Ƿ���֤����֤��
  end;
  pTUserInfo = ^TUserInfo;
  TRouteInfo = record
    nGateCount: Integer;
    sSelGateIP: string[15];
    sGameGateIP: array[0..7] of string[15];
    nGameGatePort: array[0..7] of Integer;
  end;
  pTRouteInfo = ^TRouteInfo;

procedure LoadConfig();
procedure LoadIPTable();
procedure LoadGateID();
function GetGateID(sIPaddr: string): Integer;
function GetCodeMsgSize(X: Double): Integer;
function CheckChrName(sChrName: string): Boolean;
function InClearMakeIndexList(nIndex: Integer): Boolean;
procedure WriteLogMsg(sMsg: string);
function CheckServerIP(sIP: string): Boolean;
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
procedure MainOutMessage(sMsg: string);
function GetMagicName(wMagicId: Word): string;
function GetStdItemName(nPosition: Integer): string;
function AddAttackIP(sIPaddr: string): Boolean;
procedure QuickSort(sList: TStringList; Order: Boolean); //�ٶȸ�������� 20080219
function LoadFiltrateUserNameList(): Boolean;//��ȡ���ֹ����б� 20080220
function LoadFiltrateSortNameList(): Boolean;//��ȡ�ַ������б� 20080220
function GetDisableUserNameList(sHumanName: string): Boolean;//�Ƿ��ǹ��˵����� 20080220

procedure SaveHumanOrder;//�������а� 20080315
procedure RecHumanOrder;//ˢ�����а� 20080315
var
  boHumanOrder:Boolean= False;//20080315
  sHumDBFilePath: string = '.\FDB\';
  sDataDBFilePath: string = '.\FDB\';
  sFeedPath: string = '.\FDB\';
  sBackupPath: string = '.\FDB\';
  sConnectPath: string = '.\Connects\';
  sLogPath: string = '.\Log\';

  nServerPort: Integer = 6000;
  sServerAddr: string = '0.0.0.0';
  g_nGatePort: Integer = 5100;
  g_sGateAddr: string = '0.0.0.0';
  nIDServerPort: Integer = 5600;
  sIDServerAddr: string = '127.0.0.1';


  nDataManagePort: Integer = 6600;
  sDataManageAddrPort: string = '0.0.0.0';
  g_boEnglishNames   :Boolean = False;

  boViewHackMsg: Boolean = False;
  //  sDBIdxHeaderDesc   :String = 'legend of mir database index file 2001/7';
  //  sDBHeaderDesc      :String = 'legend of mir database file 1999/1';
  HumDB_CS: TRTLCriticalSection; //0x004ADACC

  n4ADAE4: Integer;
  n4ADAE8: Integer;
  n4ADAEC: Integer;
  n4ADAF0: Integer;
  boDataDBReady: Boolean; //0x004ADAF4
  n4ADAFC: Integer;
  n4ADB00: Integer;
  n4ADB04: Integer;
  boHumDBReady: Boolean; //0x4ADB08
  n4ADBF4: Integer;
  n4ADBF8: Integer;
  n4ADBFC: Integer;
  n4ADC00: Integer;
  n4ADC04: Integer;
  boAutoClearDB: Boolean; //�Զ���������
  g_nQueryChrCount: Integer; //��ѯ��ɫ��Ϣ�Ĵ���
  nHackerNewChrCount: Integer; //0x004ADC10
  nHackerDelChrCount: Integer; //0x004ADC14
  nHackerSelChrCount: Integer; //0x004ADC18
  n4ADC1C: Integer;
  n4ADC20: Integer;
  n4ADC24: Integer;
  n4ADC28: Integer;
  //n4ADC2C: Integer;
  n4ADB10: Integer;
  n4ADB14: Integer;
  n4ADB18: Integer;
  n4ADBB8: Integer;
  bo4ADB1C: Boolean;

  sServerName: string = '��������';//20080307
  sConfFileName: string = '.\Dbsrc.ini';
  sGateConfFileName: string = '.\!ServerInfo.txt';
  sServerIPConfFileNmae: string = '.\!AddrTable.txt';
  sGateIDConfFileName: string = '.\SelectID.txt';
  sHeroDB: string = 'HeroDB';
//---------------------------------------------------------------------------
// 20080219
  sSort: string ='..\Mir200\Sort\';
  m_boAutoSort: Boolean =True;//�Զ���������
  nSortClass: Integer =0;//���� 0-ÿ�� 1-ÿ��
  nSortHour: Integer =0; //Сʱ
  nSortMinute: Integer =30; //��
  nSortLevel: Integer =30;//���˵ȼ�
  m_dwBakTick : LongWord;

  m_HumanOrderLevelList: TStringList;//����ȼ�����
  m_WarrorObjectLevelList: TStringList; //սʿ�ȼ�����
  m_WizardObjectLevelList: TStringList; //��ʦ�ȼ�����
  m_TaoistObjectLevelList: TStringList; //��ʿ�ȼ�����
  m_PlayObjectMasterList: TStringList; //ͽ��������

  m_HeroObjectLevelList: TStringList; //Ӣ�۵ȼ�����
  m_WarrorHeroObjectLevelList: TStringList; //Ӣ��սʿ�ȼ�����
  m_WizardHeroObjectLevelList: TStringList; //Ӣ�۷�ʦ�ȼ�����
  m_TaoistHeroObjectLevelList: TStringList; //Ӣ�۵�ʿ�ȼ�����

  g_FiltrateSortName: TStringList;//�ַ������б�
  g_FiltrateUserName: TStringList;//���ֹ����б�

  G_HumLoginList: TStringList;//�����½�󱣴�nSessionID�б� 20081205
//------------------------------------------------------------------------------
  sMapFile: string;
  DenyChrNameList: TStringList;
  ServerIPList: TStringList;
  GateIDList: TStringList;
  StdItemList: TList;
  MagicList: TList;
  {
  nClearIndex        :Integer;   //��ǰ����λ�ã���¼��ID��
  nClearCount        :Integer;   //��ǰ�Ѿ���������
  nRecordCount       :Integer;   //��ǰ�ܼ�¼��
    }
  {  boClearLevel1      :Boolean = True;
  boClearLevel2      :Boolean = True;
  boClearLevel3      :Boolean = True;  }

  dwInterval: LongWord = 3000; //����ʱ��������

  nLevel1: Integer = 1; //����ȼ� 1
  nLevel2: Integer = 7; //����ȼ� 2
  nLevel3: Integer = 14; //����ȼ� 3

  nDay1: Integer = 14; //����δ��¼���� 1
  nDay2: Integer = 62; //����δ��¼���� 2
  nDay3: Integer = 124; //����δ��¼���� 3

  nMonth1: Integer = 0; //����δ��¼���� 1
  nMonth2: Integer = 0; //����δ��¼���� 2
  nMonth3: Integer = 0; //����δ��¼���� 3

  g_nClearRecordCount: Integer;
  g_nClearIndex: Integer; //0x324
  g_nClearCount: Integer; //0x328
  g_nClearItemIndexCount: Integer;

  boOpenDBBusy: Boolean; //0x350
  g_dwGameCenterHandle: THandle;
  g_boDynamicIPMode: Boolean = False;
  g_CheckCode: TCheckCode;
  g_ClearMakeIndex: TStringList;

  g_RouteInfo: array[0..19] of TRouteInfo;
  g_MainMsgList: TStringList;
  g_OutMessageCS: TRTLCriticalSection;
  //ProcessHumanCriticalSection: TRTLCriticalSection;//20080915 ע��,δʹ��
  HumanSortCriticalSection: TRTLCriticalSection;//�����ٽ��� 20080915
  IDSocketConnected: Boolean;
  UserSocketClientConnected: Boolean;
  ServerSocketClientConnected: Boolean;
  DataManageSocketClientConnected: Boolean;

  ID_sRemoteAddress: string;
  User_sRemoteAddress: string;
  Server_sRemoteAddress: string;
  DataManage_sRemoteAddress: string;

  ID_nRemotePort: Integer;
  User_nRemotePort: Integer;
  Server_nRemotePort: Integer;
  DataManage_nRemotePort: Integer;

  dwKeepAliveTick: LongWord;
  dwKeepIDAliveTick: LongWord;
  dwKeepServerAliveTick: LongWord;

  AttackIPaddrList: TGList; //����IP��ʱ�б�
  boAttack: Boolean = False;
  boDenyChrName: Boolean = True;
  boMinimize: Boolean = True;
  g_boRandomCode: Boolean = True;
  g_boNoCanResDelChr: Boolean = False;//20080706 ��ֹ�ָ�ɾ���Ľ�ɫ
const
  tDBServer = 0;
implementation

uses DBSMain, HUtil32;

procedure LoadGateID();
var
  i: Integer;
  LoadList: TStringList;
  sLineText: string;
  sID: string;
  sIPaddr: string;
  nID: Integer;
begin
  GateIDList.Clear;
  if FileExists(sGateIDConfFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sGateIDConfFileName);
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[i];
      if (sLineText = '') or (sLineText[1] = ';') then Continue;
      sLineText := GetValidStr3(sLineText, sID, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sIPaddr, [' ', #9]);
      nID := Str_ToInt(sID, -1);
      if nID < 0 then Continue;
      GateIDList.AddObject(sIPaddr, TObject(nID))
    end;
    LoadList.Free;
  end;
end;
function GetGateID(sIPaddr: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to GateIDList.Count - 1 do begin
    if GateIDList.Strings[i] = sIPaddr then begin
      Result := Integer(GateIDList.Objects[i]);
      break;
    end;
  end;
end;

procedure LoadIPTable();
var
  LoadList: TStringList;
begin
  ServerIPList.Clear;
  try
    if not FileExists(sServerIPConfFileNmae) then begin
      LoadList := TStringList.Create;
      LoadList.Add(';IP�б��ļ�');
      LoadList.SaveToFile(sServerIPConfFileNmae);
      LoadList.Free;
    end;
    ServerIPList.LoadFromFile(sServerIPConfFileNmae);
  except
    MainOutMessage('����IP�б��ļ� ' + sServerIPConfFileNmae + ' ��������');
  end;
end;
procedure LoadConfig();
var
  Conf: TIniFile;
  LoadInteger: Integer;
  LoadString: string;
begin
  Conf := TIniFile.Create(sConfFileName);
  if Conf <> nil then begin
    LoadString := Conf.ReadString('DB', 'Dir', '');
    if LoadString = '' then Conf.WriteString('DB', 'Dir', sDataDBFilePath)
    else sDataDBFilePath:= LoadString;

    LoadString := Conf.ReadString('DB', 'HumDir', '');
    if LoadString = '' then Conf.WriteString('DB', 'HumDir', sHumDBFilePath)
    else sHumDBFilePath:= LoadString;

    LoadString := Conf.ReadString('DB', 'FeeDir', '');
    if LoadString = '' then Conf.WriteString('DB', 'FeeDir', sFeedPath)
    else sFeedPath:= LoadString;

    LoadString := Conf.ReadString('DB', 'Backup', '');
    if LoadString = '' then Conf.WriteString('DB', 'Backup', sBackupPath)
    else sBackupPath:= LoadString;

    LoadString := Conf.ReadString('DB', 'ConnectDir', '');
    if LoadString = '' then Conf.WriteString('DB', 'ConnectDir', sConnectPath)
    else sConnectPath:= LoadString;
    
    LoadString := Conf.ReadString('DB', 'LogDir', '');
    if LoadString = '' then Conf.WriteString('DB', 'LogDir', sLogPath)
    else sLogPath:= LoadString;

    LoadInteger := Conf.ReadInteger('Setup', 'ServerPort', -1);
    if LoadInteger < 0 then Conf.WriteInteger('Setup', 'ServerPort', nServerPort)
    else nServerPort:= LoadInteger;

    LoadString := Conf.ReadString('Setup', 'ServerAddr', '');
    if LoadString = '' then Conf.WriteString('Setup', 'ServerAddr', sServerAddr)
    else sServerAddr:= LoadString;
    //nServerPort := Conf.ReadInteger('Setup', 'ServerPort', nServerPort);
    //sServerAddr := Conf.ReadString('Setup', 'ServerAddr', sServerAddr);

    LoadInteger := Conf.ReadInteger('Setup', 'GatePort', -1);
    if LoadInteger < 0 then Conf.WriteInteger('Setup', 'GatePort', g_nGatePort)
    else g_nGatePort:= LoadInteger;

    LoadString := Conf.ReadString('Setup', 'GateAddr', '');
    if LoadString = '' then Conf.WriteString('Setup', 'GateAddr', g_sGateAddr)
    else g_sGateAddr:= LoadString;
    //g_nGatePort := Conf.ReadInteger('Setup', 'GatePort', g_nGatePort);
    //g_sGateAddr := Conf.ReadString('Setup', 'GateAddr', g_sGateAddr);

    LoadInteger := Conf.ReadInteger('Server', 'IDSPort', -1);
    if LoadInteger < 0 then Conf.WriteInteger('Server', 'IDSPort', nIDServerPort)
    else nIDServerPort:= LoadInteger;

    LoadString := Conf.ReadString('Server', 'IDSAddr', '');
    if LoadString = '' then Conf.WriteString('Server', 'IDSAddr', sIDServerAddr)
    else sIDServerAddr:= LoadString;
    //sIDServerAddr := Conf.ReadString('Server', 'IDSAddr', sIDServerAddr);
    //nIDServerPort := Conf.ReadInteger('Server', 'IDSPort', nIDServerPort);

    LoadString := Conf.ReadString('Setup', 'ServerName', '');
    if LoadString = '' then Conf.WriteString('Setup', 'ServerName', sServerName)
    else sServerName:= LoadString;

    LoadInteger := Conf.ReadInteger('Setup', 'ViewHackMsg', -1);
    if LoadInteger < 0 then begin
      Conf.WriteBool('Setup', 'ViewHackMsg', boViewHackMsg);
    end else boViewHackMsg := LoadInteger = 1;
    //boViewHackMsg := Conf.ReadBool('Setup', 'ViewHackMsg', boViewHackMsg);
    //sServerName := Conf.ReadString('Setup', 'ServerName', sServerName);

    LoadInteger := Conf.ReadInteger('Setup', 'Attack', -1);
    if LoadInteger < 0 then begin
      Conf.WriteBool('Setup', 'Attack', boAttack);
    end else boAttack := LoadInteger = 1;

    LoadInteger := Conf.ReadInteger('Setup', 'DenyChrName', -1);
    if LoadInteger < 0 then begin
      Conf.WriteBool('Setup', 'DenyChrName', boDenyChrName);
    end else boDenyChrName := LoadInteger = 1;
    //boAttack := Conf.ReadBool('Setup', 'Attack', boAttack);
    //boDenyChrName := Conf.ReadBool('Setup', 'DenyChrName', boDenyChrName);

    LoadInteger := Conf.ReadInteger('Setup', 'Minimize', -1);
    if LoadInteger < 0 then begin
      Conf.WriteBool('Setup', 'Minimize', boMinimize);
    end else boMinimize := LoadInteger = 1;
    //boMinimize := Conf.ReadBool('Setup', 'Minimize', boMinimize);
    {
    boClearLevel1:=Conf.ReadBool('DBClear','ClearLevel1',boClearLevel1);
    boClearLevel2:=Conf.ReadBool('DBClear','ClearLevel2',boClearLevel2);
    boClearLevel3:=Conf.ReadBool('DBClear','ClearLevel3',boClearLevel3);
    }
    dwInterval := Conf.ReadInteger('DBClear', 'Interval', dwInterval);
    nLevel1 := Conf.ReadInteger('DBClear', 'Level1', nLevel1);
    nLevel2 := Conf.ReadInteger('DBClear', 'Level2', nLevel2);
    nLevel3 := Conf.ReadInteger('DBClear', 'Level3', nLevel3);
    nDay1 := Conf.ReadInteger('DBClear', 'Day1', nDay1);
    nDay2 := Conf.ReadInteger('DBClear', 'Day2', nDay2);
    nDay3 := Conf.ReadInteger('DBClear', 'Day3', nDay3);
    nMonth1 := Conf.ReadInteger('DBClear', 'Month1', nMonth1);
    nMonth2 := Conf.ReadInteger('DBClear', 'Month2', nMonth2);
    nMonth3 := Conf.ReadInteger('DBClear', 'Month3', nMonth3);

    LoadInteger := Conf.ReadInteger('Setup', 'DynamicIPMode', -1);
    if LoadInteger < 0 then begin
      Conf.WriteBool('Setup', 'DynamicIPMode', g_boDynamicIPMode);
    end else g_boDynamicIPMode := LoadInteger = 1;
    
    sHeroDB := Conf.ReadString('Setup', 'DBName', '');
    if sHeroDB = '' then begin
      Conf.WriteString('Setup', 'DBName', 'HeroDB');
    end;

    if Conf.ReadInteger('Setup', 'AutoSort', -1) < 0 then
      Conf.WriteBool('Setup', 'AutoSort', m_boAutoSort);
    m_boAutoSort := Conf.ReadBool('Setup', 'AutoSort', m_boAutoSort);//�Զ��������� 20080219

    LoadInteger :=Conf.ReadInteger('Setup', 'SortClass', -1);//���� 0-ÿ�� 1-ÿ�� 20080219
    if LoadInteger < 0 then
      Conf.WriteInteger('Setup', 'SortClass', nSortClass)
    else nSortClass:= LoadInteger;
    LoadInteger :=Conf.ReadInteger('Setup', 'SortHour', -1);//Сʱ  20080219
    if LoadInteger < 0 then
      Conf.WriteInteger('Setup', 'SortHour', nSortHour)
    else nSortHour:= LoadInteger;
    LoadInteger :=Conf.ReadInteger('Setup', 'SortMinute', -1);//��   20080219
    if LoadInteger < 0 then
      Conf.WriteInteger('Setup', 'SortMinute', nSortMinute)
    else nSortMinute:= LoadInteger;
    LoadInteger :=Conf.ReadInteger('Setup', 'SortLevel', -1);//���˵ȼ� 20080219
    if LoadInteger < 0 then
      Conf.WriteInteger('Setup', 'SortLevel', nSortLevel)
    else nSortLevel:= LoadInteger;

    LoadString := Conf.ReadString('DB', 'Sort', '');//20080617
    if LoadString = '' then  Conf.WriteString('DB', 'Sort', sSort)
    else sSort:= LoadString;

    if Conf.ReadInteger('Setup', 'RandomCode', -1) < 0 then
      Conf.WriteBool('Setup', 'RandomCode', g_boRandomCode);
    g_boRandomCode := Conf.ReadBool('Setup', 'RandomCode', g_boRandomCode);

    if Conf.ReadInteger('Setup', 'NoCanResDelChr', -1) < 0 then//20080706 ��ֹ�ָ�ɾ���Ľ�ɫ
      Conf.WriteBool('Setup', 'NoCanResDelChr', g_boNoCanResDelChr);
    g_boNoCanResDelChr := Conf.ReadBool('Setup', 'NoCanResDelChr', g_boNoCanResDelChr);

    Conf.Free;
  end;
  LoadIPTable();
  LoadGateID();
end;

function GetStdItemName(nPosition: Integer): string;
var
  StdItem: pTStdItem;
begin
  if (nPosition - 1 >= 0) and (nPosition < StdItemList.Count) then begin
    StdItem := StdItemList.Items[nPosition - 1];
    if StdItem <> nil then begin
      Result := StdItem.Name;
    end;
  end;
end;

function GetMagicName(wMagicId: Word): string;
var
  i: Integer;
  Magic: pTMagic;
begin
  for i := 0 to MagicList.Count - 1 do begin
    Magic := MagicList.Items[i];
    if Magic <> nil then begin
      if Magic.wMagicId = wMagicId then begin
        Result := Magic.sMagicName;
        break;
      end;
    end;
  end;
end;

function GetCodeMsgSize(X: Double): Integer;
begin
  if INT(X) < X then Result := TRUNC(X) + 1
  else Result := TRUNC(X)
end;

function CheckChrName(sChrName: string): Boolean;
//0x0045BE60
var
  i: Integer;
  Chr: Char;
  boIsTwoByte: Boolean;
  FirstChr: Char;
begin
  Result := True;
  boIsTwoByte := False;
  FirstChr := #0;
  for i := 1 to Length(sChrName) do begin
    Chr := (sChrName[i]);
    if boIsTwoByte then begin
      //if Chr < #$A1 then Result:=False; //���С�ھ��ǷǷ��ַ�
//      if Chr < #$81 then Result:=False; //���С�ھ��ǷǷ��ַ�

      if not ((FirstChr <= #$F7) and (Chr >= #$40) and (Chr <= #$FE)) then
        if not ((FirstChr > #$F7) and (Chr >= #$40) and (Chr <= #$A0)) then Result := False;

      boIsTwoByte := False;
    end else begin //0045BEC0
      //if (Chr >= #$B0) and (Chr <= #$C8) then begin
      if (Chr >= #$81) and (Chr <= #$FE) then begin
        boIsTwoByte := True;
        FirstChr := Chr;
      end else begin //0x0045BED2
        if not ((Chr >= '0' {#30}) and (Chr <= '9' {#39})) and
          not ((Chr >= 'a' {#61}) and (Chr <= 'z') {#7A}) and
          not ((Chr >= 'A' {#41}) and (Chr <= 'Z' {#5A})) then
          Result := False;
      end;
    end;
    if not Result then break;
  end;
end;

function InClearMakeIndexList(nIndex: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to g_ClearMakeIndex.Count - 1 do begin
    if nIndex = Integer(g_ClearMakeIndex.Objects[i]) then begin
      Result := True;
      break;
    end;
  end;
end;

procedure MainOutMessage(sMsg: string);
begin
  EnterCriticalSection(g_OutMessageCS);
  try
    g_MainMsgList.Add(sMsg);
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
end;

procedure WriteLogMsg(sMsg: string);
begin

end;

function CheckServerIP(sIP: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to ServerIPList.Count - 1 do begin
    if CompareText(sIP, ServerIPList.Strings[i]) = 0 then begin
      Result := True;
      break;
    end;
  end;
end;

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tDBServer), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

constructor TGList.Create;
begin
  inherited Create;
  InitializeCriticalSection(GLock);
end;

destructor TGList.Destroy;
begin
  DeleteCriticalSection(GLock);
  inherited;
end;

procedure TGList.Lock;
begin
  EnterCriticalSection(GLock);
end;

procedure TGList.UnLock;
begin
  LeaveCriticalSection(GLock);
end;

function AddAttackIP(sIPaddr: string): Boolean;
var
  I: Integer;
  IPaddr, AddIPaddr: pTSockaddr;
  nIPaddr: Integer;
  bo01: Boolean;
begin
  Result := False;
  AttackIPaddrList.Lock;
  try
    bo01 := False;
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to AttackIPaddrList.Count - 1 do begin
      IPaddr := pTSockaddr(AttackIPaddrList.Items[I]);
      if IPaddr.nIPaddr = nIPaddr then begin
        if IPaddr.nAttackCount >= 3 then Result := True;
        Inc(IPaddr.nAttackCount);
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
  finally
    AttackIPaddrList.UnLock;
  end;
end;
//------------------------------------------------------------------------------
//��ȡ���ֹ����б�
function LoadFiltrateUserNameList(): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sFileName, sLineText: string;
begin
  Result := False;
  sFileName := 'FiltrateUserName.txt';
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    g_FiltrateUserName.Clear;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
     sLineText := LoadList.Strings[I];
     if (sLineText <> '') and (sLineText[1] <> ';') then
      g_FiltrateUserName.Add(Trim(LoadList.Strings[I]));
    end;
    Result := True;
  end else begin
    LoadList.Add(';���а������������');
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;
//��ȡ�ַ������б�
function LoadFiltrateSortNameList(): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sFileName, sLineText: string;
begin
  Result := False;
  sFileName := 'FiltrateSortName.txt';
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    g_FiltrateSortName.Clear;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
     sLineText := LoadList.Strings[I];
     if (sLineText <> '') and (sLineText[1] <> ';') then
        g_FiltrateSortName.Add(Trim(LoadList.Strings[I]));
    end;
    Result := True;
  end else begin
    LoadList.Add(';������������ַ�');
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;

procedure QuickSort(sList: TStringList; Order: Boolean); //�ٶȸ��������
  procedure QuickSortStrListCase(List: TStringList; l, r: Integer);
  var
    I, j: Integer;
    p: string;
  begin
    if List.Count <= 0 then Exit;
    repeat
      I := l;
      j := r;
      p := List[(l + r) shr 1];
      repeat
        if Order then begin //����
          while CompareStr(List[I], p) < 0 do Inc(I);
          while CompareStr(List[j], p) > 0 do Dec(j);
        end else begin //����
          while CompareStr(p, List[I]) < 0 do Inc(I);
          while CompareStr(p, List[j]) > 0 do Dec(j);
        end;
        if I <= j then begin
          List.Exchange(I, j);
          Inc(I);
          Dec(j);
        end;
      until I > j;
      if l < j then QuickSortStrListCase(List, l, j);
      l := I;
    until I >= r;
  end;
  procedure AddList(TempList: TStringList; slen: string; s: string; AObject: TObject);
  var
    I: Integer;
    List: TStringList;
    boFound: Boolean;
  begin
    boFound := False;
    for I := 0 to TempList.Count - 1 do begin
      if CompareText(TempList.Strings[I], slen) = 0 then begin
        List := TStringList(TempList.Objects[I]);
        List.AddObject(s, AObject);
        boFound := True;
        Break;
      end;
    end;
    if not boFound then begin
      List := TStringList.Create;
      List.AddObject(s, AObject);
      TempList.AddObject(slen, List);
    end;
  end;
var
  TempList: TStringList;
  List: TStringList;
  I: Integer;
  nLen: Integer;
begin
  TempList := TStringList.Create;
  for I := 0 to sList.Count - 1 do begin
    nLen := Length(sList.Strings[I]);
    AddList(TempList, IntToStr(nLen), sList.Strings[I], sList.Objects[I]);
  end;
  QuickSortStrListCase(TempList, 0, TempList.Count - 1);
  sList.Clear;
  for I := 0 to TempList.Count - 1 do begin
    List := TStringList(TempList.Objects[I]);
    QuickSortStrListCase(List, 0, List.Count - 1);
    sList.AddStrings(List);
    List.Free;
  end;
  TempList.Free;
end;

//�Ƿ��ǹ��˵�����
function GetDisableUserNameList(sHumanName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if g_FiltrateSortName.Count > 0 then begin//20090101
    for I := 0 to g_FiltrateSortName.Count - 1 do begin//�ַ�����
      if pos(g_FiltrateSortName.Strings[I],sHumanName) <> 0 then begin
        Result := True;
        Exit;
      end;
    end;
  end;
  if g_FiltrateUserName.Count > 0 then begin//20090101
    for I := 0 to g_FiltrateUserName.Count - 1 do begin//���ֹ���
      if CompareText(sHumanName, g_FiltrateUserName.Strings[I]) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

procedure RecHumanOrder;//ˢ�����а� 20080315
var
  I: Integer;
  ChrRecord: THumDataInfo;
  CharName: pTCharName;
  HeroName: pTHeroName;
begin
  if boHumanOrder then Exit;//20080914
  boHumanOrder:=True;
  try
    try
      EnterCriticalSection(HumanSortCriticalSection);//20080915
      if HumDataDB <> nil then begin
        if m_HumanOrderLevelList.Count > 0 then begin
          for I := 0 to m_HumanOrderLevelList.Count - 1 do begin
            Dispose(pTCharName(m_HumanOrderLevelList.Objects[I]));
          end;
          m_HumanOrderLevelList.Clear; //����ȼ�������
        end;
        if m_WarrorObjectLevelList.Count > 0 then m_WarrorObjectLevelList.Clear; //սʿ�ȼ�����
        if m_WizardObjectLevelList.Count > 0 then m_WizardObjectLevelList.Clear; //��ʦ�ȼ�����
        if m_TaoistObjectLevelList.Count > 0 then m_TaoistObjectLevelList.Clear; //��ʿ�ȼ�����

        if m_PlayObjectMasterList.Count > 0 then begin
          for I := 0 to m_PlayObjectMasterList.Count - 1 do begin
            Dispose(pTCharName(m_PlayObjectMasterList.Objects[I]));
          end;
          m_PlayObjectMasterList.Clear; //ͽ��������
        end;
        if m_HeroObjectLevelList.Count > 0 then begin
          for I := 0 to m_HeroObjectLevelList.Count - 1 do begin
            Dispose(pTHeroName(m_HeroObjectLevelList.Objects[I]));
          end;
          m_HeroObjectLevelList.Clear; //Ӣ�۵ȼ�����
        end;
        if m_WarrorHeroObjectLevelList.Count > 0 then m_WarrorHeroObjectLevelList.Clear; //Ӣ��սʿ�ȼ�����
        if m_WizardHeroObjectLevelList.Count > 0 then m_WizardHeroObjectLevelList.Clear; //Ӣ�۷�ʦ�ȼ�����
        if m_TaoistHeroObjectLevelList.Count > 0 then m_TaoistHeroObjectLevelList.Clear; //Ӣ�۵�ʿ�ȼ�����

        if HumDataDB.OpenEx then begin
          if HumDataDB.count > 0 then begin
            for I:= 0 to HumDataDB.count -1 do begin
              if HumDataDB.Get(I, ChrRecord) >= 0 then begin
                if ChrRecord.Header.boDeleted or (ChrRecord.Data.sChrName = '') or (ChrRecord.Data.sAccount= '') then Continue;//���� 20090110 ���ֻ��˺�Ϊ��������
                if (ChrRecord.Data.Abil.Level >= nSortLevel) and (not GetDisableUserNameList(ChrRecord.Data.sChrName)) then begin
                   if (not ChrRecord.Data.boIsHero) then begin
                      New(CharName);
                      FillChar(CharName^, SizeOf(TCharName), 0);
                      CharName^ :=  ChrRecord.Data.sChrName;
                      m_HumanOrderLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level) , TObject(CharName));
                      case ChrRecord.Data.btJob of
                        0: m_WarrorObjectLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level), TObject(CharName));//սʿ
                        1: m_WizardObjectLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level), TObject(CharName));//��ʿ
                        2: m_TaoistObjectLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level), TObject(CharName));//��ʿ
                      end;
                   end;
                   if ChrRecord.Data.boIsHero then begin //Ӣ������
                     New(HeroName);
                     FillChar(HeroName^, SizeOf(THeroName), 0);
                     HeroName^ := ChrRecord.Data.sChrName + #13 + ChrRecord.Data.sMasterName;
                     m_HeroObjectLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level), TObject(HeroName));
                     case ChrRecord.Data.btJob of
                       0: m_WarrorHeroObjectLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level), TObject(HeroName));
                       1: m_WizardHeroObjectLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level), TObject(HeroName));
                       2: m_TaoistHeroObjectLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level), TObject(HeroName));
                     end;
                   end;
                end;
                if ChrRecord.Data.wMasterCount > 0 then begin
                  New(CharName);
                  FillChar(CharName^, SizeOf(TCharName), 0);
                  CharName^ :=  ChrRecord.Data.sChrName;
                  m_PlayObjectMasterList.AddObject(IntToStr(ChrRecord.Data.wMasterCount), TObject(CharName));
                end;
              end; //if HumDataDB1.Get(I, ChrRecord) >= 0 then begin
            end; //for
            if m_HumanOrderLevelList.Count > 0 then QuickSort( m_HumanOrderLevelList, False); //����ȼ�����
            if m_WarrorObjectLevelList.Count > 0 then QuickSort( m_WarrorObjectLevelList, False); //սʿ�ȼ�����
            if m_WizardObjectLevelList.Count > 0 then QuickSort( m_WizardObjectLevelList, False); //��ʦ�ȼ�����
            if m_TaoistObjectLevelList.Count > 0 then QuickSort( m_TaoistObjectLevelList, False); //��ʿ�ȼ�����
            if m_PlayObjectMasterList.Count > 0 then QuickSort( m_PlayObjectMasterList, False); //ͽ��������
            if m_HeroObjectLevelList.Count > 0 then QuickSort( m_HeroObjectLevelList, False); //Ӣ�۵ȼ�����
            if m_WarrorHeroObjectLevelList.Count > 0 then QuickSort( m_WarrorHeroObjectLevelList, False); //Ӣ��սʿ�ȼ�����
            if m_WizardHeroObjectLevelList.Count > 0 then QuickSort( m_WizardHeroObjectLevelList, False); //Ӣ�۷�ʦ�ȼ�����
            if m_TaoistHeroObjectLevelList.Count > 0 then QuickSort( m_TaoistHeroObjectLevelList, False); //Ӣ�۵�ʿ�ȼ�����
            SaveHumanOrder;//�������а� 20080220
            boHumanOrder:= False;
          end;
        end;
      end;
    finally
      LeaveCriticalSection(HumanSortCriticalSection);//20080915
      HumDataDB.Close;
      boHumanOrder:= False;//20080819 ����
    end;
  except
    on E: Exception do
     if boViewHackMsg then MainOutMessage('[�쳣] THumanOrderThread.RecHumanOrder');
  end;
end;

procedure SaveHumanOrder;//�������а� 20080315
  (*function IsFileInUse(fName : string) : boolean;//�ж��ļ��Ƿ���ʹ��
  var
     HFileRes : HFILE;
  begin
     Result := false; //����ֵΪ��(���ļ�����ʹ��)
     if not FileExists(fName) then exit; //����ļ����������˳�
     HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0 , nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
     Result := (HFileRes = INVALID_HANDLE_VALUE); //���CreateFile����ʧ�� ��ôResultΪ��(���ļ����ڱ�ʹ��)
     CloseHandle(HFileRes);//��ô�رվ�� 
  end;  *)
var
  sHumDBFile, sWarrHum, sWizardHum, sTaosHum, sMaster: string;
  sAllHero, sWarrHero, sWizardHero, sTaosHero: string;
  I, Level: Integer;
  CharName: pTCharName;
  HeroName: pTHeroName;
  sCharName, sHeroName: string;
  SaveList: TStringList;
begin
  try
    if not DirectoryExists(sSort) then CreateDir(sSort);
    sHumDBFile := sSort + 'AllHum.DB';
    sWarrHum:= sSort +'WarrHum.DB';
    sWizardHum:= sSort +'WizardHum.DB';
    sTaosHum:= sSort +'TaosHum.DB';
    sMaster:= sSort +'Master.DB';
    sAllHero:= sSort +'AllHero.DB';
    sWarrHero:= sSort +'WarrHero.DB';
    sWizardHero:= sSort +'WizardHero.DB';
    sTaosHero:= sSort +'TaosHero.DB';
    (*if FileExists(sHumDBFile) and (not IsFileInUse(sHumDBFile)) then
      if not DeleteFile(sHumDBFile) then Exit;

    if FileExists(sWarrHum) and (not IsFileInUse(sWarrHum)) then
      if not DeleteFile(sWarrHum) then Exit;

    if FileExists(sWizardHum) and (not IsFileInUse(sWizardHum)) then
      if not DeleteFile(sWizardHum) then Exit;

    if FileExists(sTaosHum) and (not IsFileInUse(sTaosHum)) then
      if not  DeleteFile(sTaosHum) then Exit;

    if FileExists(sMaster) and (not IsFileInUse(sMaster)) then
      if not DeleteFile(sMaster) then Exit;

    if FileExists(sAllHero) and (not IsFileInUse(sAllHero)) then
      if not DeleteFile(sAllHero) then Exit;

    if FileExists(sWarrHero) and (not IsFileInUse(sWarrHero)) then
      if not DeleteFile(sWarrHero) then Exit;

    if FileExists(sWizardHero) and (not IsFileInUse(sWizardHero)) then
      if not DeleteFile(sWizardHero) then Exit;

    if FileExists(sTaosHero) and (not IsFileInUse(sTaosHero)) then
      if not DeleteFile(sTaosHero) then Exit;  *)

    SaveList := TStringList.Create;
    try
      if m_HumanOrderLevelList.Count > 0 then begin
        for I:=0 to m_HumanOrderLevelList.Count -1 do begin
          if I >= 2000 then Break;
          CharName := pTCharName(m_HumanOrderLevelList.Objects[I]);
          Level := StrToInt(m_HumanOrderLevelList.Strings[I]);
          SaveList.Add(CharName^ + #9 + Inttostr(Level));
        end;
      end;
      SaveList.SaveToFile(sHumDBFile);
      SaveList.clear;

      if m_WarrorObjectLevelList.Count > 0 then begin
        for I:=0 to m_WarrorObjectLevelList.Count -1 do begin
          if I >= 2000 then Break;
          CharName := pTCharName(m_WarrorObjectLevelList.Objects[I]);
          Level := StrToInt(m_WarrorObjectLevelList.Strings[I]);
          SaveList.Add(CharName^ + #9 + Inttostr(Level));
        end;
      end;
      SaveList.SaveToFile(sWarrHum);
      SaveList.clear;

      if m_WizardObjectLevelList.Count > 0 then begin
        for I:=0 to m_WizardObjectLevelList.Count -1 do begin
          if I >= 2000 then Break;
          CharName := pTCharName(m_WizardObjectLevelList.Objects[I]);
          Level := StrToInt(m_WizardObjectLevelList.Strings[I]);
          SaveList.Add(CharName^ + #9 + Inttostr(Level));
        end;
      end;
      SaveList.SaveToFile(sWizardHum);
      SaveList.clear;

      if m_TaoistObjectLevelList.Count > 0 then begin
        for I:=0 to m_TaoistObjectLevelList.Count -1 do begin
          if I >= 2000 then Break;
          CharName := pTCharName(m_TaoistObjectLevelList.Objects[I]);
          Level := StrToInt(m_TaoistObjectLevelList.Strings[I]);
          SaveList.Add(CharName^ + #9 + Inttostr(Level));
        end;
      end;
      SaveList.SaveToFile(sTaosHum);
      SaveList.clear;

      if m_PlayObjectMasterList.Count > 0 then begin
        for I:=0 to m_PlayObjectMasterList.Count -1 do begin
          if I >= 2000 then Break;
          CharName := pTCharName(m_PlayObjectMasterList.Objects[I]);
          Level := StrToInt(m_PlayObjectMasterList.Strings[I]);
          SaveList.Add(CharName^ + #9 + Inttostr(Level));
        end;
      end;
      SaveList.SaveToFile(sMaster);
      SaveList.clear;

      if m_HeroObjectLevelList.Count > 0 then begin
        for I:=0 to m_HeroObjectLevelList.Count -1 do begin
          if I >= 2000 then Break;
          HeroName := pTHeroName(m_HeroObjectLevelList.Objects[I]);
          sHeroName := HeroName^;
          sHeroName := GetValidStr3(sHeroName, sCharName, [#13]);
          Level := StrToInt(m_HeroObjectLevelList.Strings[I]);
          SaveList.Add(sHeroName + #9+ sCharName + #9 + Inttostr(Level));
        end;
      end;
      SaveList.SaveToFile(sAllHero);
      SaveList.clear;

      if m_WarrorHeroObjectLevelList.Count > 0 then begin
        for I:=0 to m_WarrorHeroObjectLevelList.Count -1 do begin
          if I >= 2000 then Break;
          HeroName := pTHeroName(m_WarrorHeroObjectLevelList.Objects[I]);
          sHeroName := HeroName^;
          sHeroName := GetValidStr3(sHeroName, sCharName, [#13]);
          Level := StrToInt(m_WarrorHeroObjectLevelList.Strings[I]);
          SaveList.Add(sHeroName + #9+ sCharName + #9 + Inttostr(Level));
        end;
      end;
      SaveList.SaveToFile(sWarrHero);
      SaveList.clear;

      if m_WizardHeroObjectLevelList.Count > 0 then begin
        for I:=0 to m_WizardHeroObjectLevelList.Count -1 do begin
          if I >= 2000 then Break;
          HeroName := pTHeroName(m_WizardHeroObjectLevelList.Objects[I]);
          sHeroName := HeroName^;
          sHeroName := GetValidStr3(sHeroName, sCharName, [#13]);
          Level := StrToInt(m_WizardHeroObjectLevelList.Strings[I]);
          SaveList.Add(sHeroName + #9+ sCharName + #9 + Inttostr(Level));
        end;
      end;
      SaveList.SaveToFile(sWizardHero);
      SaveList.clear;

      if m_TaoistHeroObjectLevelList.Count > 0 then begin
        for I:=0 to m_TaoistHeroObjectLevelList.Count -1 do begin
          if I >= 2000 then Break;
          HeroName := pTHeroName(m_TaoistHeroObjectLevelList.Objects[I]);
          sHeroName := HeroName^;
          sHeroName := GetValidStr3(sHeroName, sCharName, [#13]);
          Level := StrToInt(m_TaoistHeroObjectLevelList.Strings[I]);
          SaveList.Add(sHeroName + #9+ sCharName + #9 + Inttostr(Level));
        end;
      end;
      SaveList.SaveToFile(sTaosHero);
    finally
      SaveList.Free;
    end;
  except
    on E: Exception do
     if boViewHackMsg then MainOutMessage('[�쳣] THumanOrderThread.SaveHumanOrder');
  end;
end;
//------------------------------------------------------------------------------
initialization
  begin
    InitializeCriticalSection(g_OutMessageCS);
    InitializeCriticalSection(HumDB_CS);
    InitializeCriticalSection(HumanSortCriticalSection);//�����ٽ��� 20080915
    g_MainMsgList := TStringList.Create;
    DenyChrNameList := TStringList.Create;
    ServerIPList := TStringList.Create;
    GateIDList := TStringList.Create;
    g_ClearMakeIndex := TStringList.Create;
    StdItemList := TList.Create;
    MagicList := TList.Create;
//------------------------------------------------------------------------------
//20080219
    m_HumanOrderLevelList:= TStringList.Create;//����ȼ�����
    m_WarrorObjectLevelList:= TStringList.Create; //սʿ�ȼ�����
    m_WizardObjectLevelList:= TStringList.Create; //��ʦ�ȼ�����
    m_TaoistObjectLevelList:= TStringList.Create; //��ʿ�ȼ�����
    m_PlayObjectMasterList:= TStringList.Create; //ͽ��������

    m_HeroObjectLevelList:= TStringList.Create; //Ӣ�۵ȼ�����
    m_WarrorHeroObjectLevelList:= TStringList.Create; //Ӣ��սʿ�ȼ�����
    m_WizardHeroObjectLevelList:= TStringList.Create; //Ӣ�۷�ʦ�ȼ�����
    m_TaoistHeroObjectLevelList:= TStringList.Create; //Ӣ�۵�ʿ�ȼ�����

    g_FiltrateSortName:= TStringList.Create;//�ַ������б�
    g_FiltrateUserName:= TStringList.Create;//���ֹ����б�

    G_HumLoginList:= TStringList.Create;
//------------------------------------------------------------------------------
  end;

finalization
  begin
    DeleteCriticalSection(HumDB_CS);
    DeleteCriticalSection(g_OutMessageCS);
    DeleteCriticalSection(HumanSortCriticalSection);//�����ٽ��� 20080915
    DenyChrNameList.Free;
    ServerIPList.Free;
    GateIDList.Free;
    g_ClearMakeIndex.Free;
    g_MainMsgList.Free;
    StdItemList.Free;
    MagicList.Free;
//------------------------------------------------------------------------------
//20080219
    m_HumanOrderLevelList.Free;//����ȼ�����
    m_WarrorObjectLevelList.Free; //սʿ�ȼ�����
    m_WizardObjectLevelList.Free; //��ʦ�ȼ�����
    m_TaoistObjectLevelList.Free; //��ʿ�ȼ�����
    m_PlayObjectMasterList.Free; //ͽ��������

    m_HeroObjectLevelList.Free; //Ӣ�۵ȼ�����
    m_WarrorHeroObjectLevelList.Free; //Ӣ��սʿ�ȼ�����
    m_WizardHeroObjectLevelList.Free; //Ӣ�۷�ʦ�ȼ�����
    m_TaoistHeroObjectLevelList.Free; //Ӣ�۵�ʿ�ȼ�����

    g_FiltrateSortName.Free;//�ַ������б�
    g_FiltrateUserName.Free;//���ֹ����б�

    G_HumLoginList.Free;
//------------------------------------------------------------------------------
  end;

end.

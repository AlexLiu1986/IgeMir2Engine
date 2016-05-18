unit DBShare;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket, WinSock, IniFiles, Grobal2,
  MudUtil, Common, HumDB;

const
  g_sProductName = '61284E6430922F6EB45CC2736C6D7F8DCFA5313C50C50CE4'; //IGE科技数据库服务器
  g_sVersion = 'AF7BE30A93DDA7B52F344FC7EADF5DF9BDCF5B8070D2B211';  //2.00 Build 20081231
  g_sUpDateTime = '06B8C6D3CEBD9FAD41CB00DED3803788'; //2008/12/31
  g_sProgram = 'C0CB995DE0C2A55814577F81CCE3A3BD'; //IGE科技
  g_sWebSite = 'E14A1EC77CDEF28A670B57F56B07D834D8758E442B312AF440574B5A981AB1752C73BF5C6670B79C'; // http://www.IGEM2.com(官网站)
  g_sBbsSite = '2E5A58E761D583C119D6606E0F38D7A9D8758E442B312AF440574B5A981AB17538E97FF2F0C39555'; //http://www.IGEM2.com.cn(程序站)
  //g_sProductInfo = '8DFDF45695C4099770F02197A7BCE1C5B07D1DD7CD1455D1783D523EA941CBFB'; //欢迎使用IGE网络系列软件:
  //g_sSellInfo1 = '71043F0BD11D04C7BA0E09F9A2EF83B7B936E13B070575B9';//联系(QQ):228589790

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
    nGateID: Integer; //网关ID
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
    boChrQueryed: Boolean; //角色信息是否可以查询
    dwTick34: LongWord; //0x34
    dwChrTick: LongWord; //0x38
    nSelGateID: ShortInt; //角色网关ID
    nDataCount: Integer;
    sRandomCode: String;//验证码 20080612
    boRandomCode: Boolean; //是否验证了验证码
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
procedure QuickSort(sList: TStringList; Order: Boolean); //速度更快的排行 20080219
function LoadFiltrateUserNameList(): Boolean;//读取名字过滤列表 20080220
function LoadFiltrateSortNameList(): Boolean;//读取字符过滤列表 20080220
function GetDisableUserNameList(sHumanName: string): Boolean;//是否是过滤的名字 20080220

procedure SaveHumanOrder;//保存排行榜 20080315
procedure RecHumanOrder;//刷新排行榜 20080315
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
  boAutoClearDB: Boolean; //自动清理数据
  g_nQueryChrCount: Integer; //查询角色信息的次数
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

  sServerName: string = '数据中心';//20080307
  sConfFileName: string = '.\Dbsrc.ini';
  sGateConfFileName: string = '.\!ServerInfo.txt';
  sServerIPConfFileNmae: string = '.\!AddrTable.txt';
  sGateIDConfFileName: string = '.\SelectID.txt';
  sHeroDB: string = 'HeroDB';
//---------------------------------------------------------------------------
// 20080219
  sSort: string ='..\Mir200\Sort\';
  m_boAutoSort: Boolean =True;//自动计算排行
  nSortClass: Integer =0;//类型 0-每隔 1-每天
  nSortHour: Integer =0; //小时
  nSortMinute: Integer =30; //分
  nSortLevel: Integer =30;//过滤等级
  m_dwBakTick : LongWord;

  m_HumanOrderLevelList: TStringList;//人物等级排行
  m_WarrorObjectLevelList: TStringList; //战士等级排行
  m_WizardObjectLevelList: TStringList; //法师等级排行
  m_TaoistObjectLevelList: TStringList; //道士等级排行
  m_PlayObjectMasterList: TStringList; //徒弟数排行

  m_HeroObjectLevelList: TStringList; //英雄等级排行
  m_WarrorHeroObjectLevelList: TStringList; //英雄战士等级排行
  m_WizardHeroObjectLevelList: TStringList; //英雄法师等级排行
  m_TaoistHeroObjectLevelList: TStringList; //英雄道士等级排行

  g_FiltrateSortName: TStringList;//字符过滤列表
  g_FiltrateUserName: TStringList;//名字过滤列表

  G_HumLoginList: TStringList;//人物登陆后保存nSessionID列表 20081205
//------------------------------------------------------------------------------
  sMapFile: string;
  DenyChrNameList: TStringList;
  ServerIPList: TStringList;
  GateIDList: TStringList;
  StdItemList: TList;
  MagicList: TList;
  {
  nClearIndex        :Integer;   //当前清理位置（记录的ID）
  nClearCount        :Integer;   //当前已经清量数量
  nRecordCount       :Integer;   //当前总记录数
    }
  {  boClearLevel1      :Boolean = True;
  boClearLevel2      :Boolean = True;
  boClearLevel3      :Boolean = True;  }

  dwInterval: LongWord = 3000; //清理时间间隔长度

  nLevel1: Integer = 1; //清理等级 1
  nLevel2: Integer = 7; //清理等级 2
  nLevel3: Integer = 14; //清理等级 3

  nDay1: Integer = 14; //清理未登录天数 1
  nDay2: Integer = 62; //清理未登录天数 2
  nDay3: Integer = 124; //清理未登录天数 3

  nMonth1: Integer = 0; //清理未登录月数 1
  nMonth2: Integer = 0; //清理未登录月数 2
  nMonth3: Integer = 0; //清理未登录月数 3

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
  //ProcessHumanCriticalSection: TRTLCriticalSection;//20080915 注释,未使用
  HumanSortCriticalSection: TRTLCriticalSection;//排行临界区 20080915
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

  AttackIPaddrList: TGList; //攻击IP临时列表
  boAttack: Boolean = False;
  boDenyChrName: Boolean = True;
  boMinimize: Boolean = True;
  g_boRandomCode: Boolean = True;
  g_boNoCanResDelChr: Boolean = False;//20080706 禁止恢复删除的角色
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
      LoadList.Add(';IP列表文件');
      LoadList.SaveToFile(sServerIPConfFileNmae);
      LoadList.Free;
    end;
    ServerIPList.LoadFromFile(sServerIPConfFileNmae);
  except
    MainOutMessage('加载IP列表文件 ' + sServerIPConfFileNmae + ' 出错！！！');
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
    m_boAutoSort := Conf.ReadBool('Setup', 'AutoSort', m_boAutoSort);//自动计算排行 20080219

    LoadInteger :=Conf.ReadInteger('Setup', 'SortClass', -1);//类型 0-每隔 1-每天 20080219
    if LoadInteger < 0 then
      Conf.WriteInteger('Setup', 'SortClass', nSortClass)
    else nSortClass:= LoadInteger;
    LoadInteger :=Conf.ReadInteger('Setup', 'SortHour', -1);//小时  20080219
    if LoadInteger < 0 then
      Conf.WriteInteger('Setup', 'SortHour', nSortHour)
    else nSortHour:= LoadInteger;
    LoadInteger :=Conf.ReadInteger('Setup', 'SortMinute', -1);//分   20080219
    if LoadInteger < 0 then
      Conf.WriteInteger('Setup', 'SortMinute', nSortMinute)
    else nSortMinute:= LoadInteger;
    LoadInteger :=Conf.ReadInteger('Setup', 'SortLevel', -1);//过滤等级 20080219
    if LoadInteger < 0 then
      Conf.WriteInteger('Setup', 'SortLevel', nSortLevel)
    else nSortLevel:= LoadInteger;

    LoadString := Conf.ReadString('DB', 'Sort', '');//20080617
    if LoadString = '' then  Conf.WriteString('DB', 'Sort', sSort)
    else sSort:= LoadString;

    if Conf.ReadInteger('Setup', 'RandomCode', -1) < 0 then
      Conf.WriteBool('Setup', 'RandomCode', g_boRandomCode);
    g_boRandomCode := Conf.ReadBool('Setup', 'RandomCode', g_boRandomCode);

    if Conf.ReadInteger('Setup', 'NoCanResDelChr', -1) < 0 then//20080706 禁止恢复删除的角色
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
      //if Chr < #$A1 then Result:=False; //如果小于就是非法字符
//      if Chr < #$81 then Result:=False; //如果小于就是非法字符

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
//读取名字过滤列表
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
    LoadList.Add(';排行榜过滤人物名称');
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;
//读取字符过滤列表
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
    LoadList.Add(';创建人物过滤字符');
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;

procedure QuickSort(sList: TStringList; Order: Boolean); //速度更快的排序
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
        if Order then begin //升序
          while CompareStr(List[I], p) < 0 do Inc(I);
          while CompareStr(List[j], p) > 0 do Dec(j);
        end else begin //降序
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

//是否是过滤的名字
function GetDisableUserNameList(sHumanName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if g_FiltrateSortName.Count > 0 then begin//20090101
    for I := 0 to g_FiltrateSortName.Count - 1 do begin//字符过滤
      if pos(g_FiltrateSortName.Strings[I],sHumanName) <> 0 then begin
        Result := True;
        Exit;
      end;
    end;
  end;
  if g_FiltrateUserName.Count > 0 then begin//20090101
    for I := 0 to g_FiltrateUserName.Count - 1 do begin//名字过滤
      if CompareText(sHumanName, g_FiltrateUserName.Strings[I]) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

procedure RecHumanOrder;//刷新排行榜 20080315
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
          m_HumanOrderLevelList.Clear; //人物等级总排行
        end;
        if m_WarrorObjectLevelList.Count > 0 then m_WarrorObjectLevelList.Clear; //战士等级排行
        if m_WizardObjectLevelList.Count > 0 then m_WizardObjectLevelList.Clear; //法师等级排行
        if m_TaoistObjectLevelList.Count > 0 then m_TaoistObjectLevelList.Clear; //道士等级排行

        if m_PlayObjectMasterList.Count > 0 then begin
          for I := 0 to m_PlayObjectMasterList.Count - 1 do begin
            Dispose(pTCharName(m_PlayObjectMasterList.Objects[I]));
          end;
          m_PlayObjectMasterList.Clear; //徒弟数排行
        end;
        if m_HeroObjectLevelList.Count > 0 then begin
          for I := 0 to m_HeroObjectLevelList.Count - 1 do begin
            Dispose(pTHeroName(m_HeroObjectLevelList.Objects[I]));
          end;
          m_HeroObjectLevelList.Clear; //英雄等级排行
        end;
        if m_WarrorHeroObjectLevelList.Count > 0 then m_WarrorHeroObjectLevelList.Clear; //英雄战士等级排行
        if m_WizardHeroObjectLevelList.Count > 0 then m_WizardHeroObjectLevelList.Clear; //英雄法师等级排行
        if m_TaoistHeroObjectLevelList.Count > 0 then m_TaoistHeroObjectLevelList.Clear; //英雄道士等级排行

        if HumDataDB.OpenEx then begin
          if HumDataDB.count > 0 then begin
            for I:= 0 to HumDataDB.count -1 do begin
              if HumDataDB.Get(I, ChrRecord) >= 0 then begin
                if ChrRecord.Header.boDeleted or (ChrRecord.Data.sChrName = '') or (ChrRecord.Data.sAccount= '') then Continue;//继续 20090110 名字或账号为空则跳过
                if (ChrRecord.Data.Abil.Level >= nSortLevel) and (not GetDisableUserNameList(ChrRecord.Data.sChrName)) then begin
                   if (not ChrRecord.Data.boIsHero) then begin
                      New(CharName);
                      FillChar(CharName^, SizeOf(TCharName), 0);
                      CharName^ :=  ChrRecord.Data.sChrName;
                      m_HumanOrderLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level) , TObject(CharName));
                      case ChrRecord.Data.btJob of
                        0: m_WarrorObjectLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level), TObject(CharName));//战士
                        1: m_WizardObjectLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level), TObject(CharName));//法士
                        2: m_TaoistObjectLevelList.AddObject(IntToStr(ChrRecord.Data.Abil.Level), TObject(CharName));//道士
                      end;
                   end;
                   if ChrRecord.Data.boIsHero then begin //英雄排行
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
            if m_HumanOrderLevelList.Count > 0 then QuickSort( m_HumanOrderLevelList, False); //人物等级排行
            if m_WarrorObjectLevelList.Count > 0 then QuickSort( m_WarrorObjectLevelList, False); //战士等级排行
            if m_WizardObjectLevelList.Count > 0 then QuickSort( m_WizardObjectLevelList, False); //法师等级排行
            if m_TaoistObjectLevelList.Count > 0 then QuickSort( m_TaoistObjectLevelList, False); //道士等级排行
            if m_PlayObjectMasterList.Count > 0 then QuickSort( m_PlayObjectMasterList, False); //徒弟数排行
            if m_HeroObjectLevelList.Count > 0 then QuickSort( m_HeroObjectLevelList, False); //英雄等级排行
            if m_WarrorHeroObjectLevelList.Count > 0 then QuickSort( m_WarrorHeroObjectLevelList, False); //英雄战士等级排行
            if m_WizardHeroObjectLevelList.Count > 0 then QuickSort( m_WizardHeroObjectLevelList, False); //英雄法师等级排行
            if m_TaoistHeroObjectLevelList.Count > 0 then QuickSort( m_TaoistHeroObjectLevelList, False); //英雄道士等级排行
            SaveHumanOrder;//保存排行榜 20080220
            boHumanOrder:= False;
          end;
        end;
      end;
    finally
      LeaveCriticalSection(HumanSortCriticalSection);//20080915
      HumDataDB.Close;
      boHumanOrder:= False;//20080819 增加
    end;
  except
    on E: Exception do
     if boViewHackMsg then MainOutMessage('[异常] THumanOrderThread.RecHumanOrder');
  end;
end;

procedure SaveHumanOrder;//保存排行榜 20080315
  (*function IsFileInUse(fName : string) : boolean;//判断文件是否在使用
  var
     HFileRes : HFILE;
  begin
     Result := false; //返回值为假(即文件不被使用)
     if not FileExists(fName) then exit; //如果文件不存在则退出
     HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0 , nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
     Result := (HFileRes = INVALID_HANDLE_VALUE); //如果CreateFile返回失败 那么Result为真(即文件正在被使用)
     CloseHandle(HFileRes);//那么关闭句柄 
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
     if boViewHackMsg then MainOutMessage('[异常] THumanOrderThread.SaveHumanOrder');
  end;
end;
//------------------------------------------------------------------------------
initialization
  begin
    InitializeCriticalSection(g_OutMessageCS);
    InitializeCriticalSection(HumDB_CS);
    InitializeCriticalSection(HumanSortCriticalSection);//排行临界区 20080915
    g_MainMsgList := TStringList.Create;
    DenyChrNameList := TStringList.Create;
    ServerIPList := TStringList.Create;
    GateIDList := TStringList.Create;
    g_ClearMakeIndex := TStringList.Create;
    StdItemList := TList.Create;
    MagicList := TList.Create;
//------------------------------------------------------------------------------
//20080219
    m_HumanOrderLevelList:= TStringList.Create;//人物等级排行
    m_WarrorObjectLevelList:= TStringList.Create; //战士等级排行
    m_WizardObjectLevelList:= TStringList.Create; //法师等级排行
    m_TaoistObjectLevelList:= TStringList.Create; //道士等级排行
    m_PlayObjectMasterList:= TStringList.Create; //徒弟数排行

    m_HeroObjectLevelList:= TStringList.Create; //英雄等级排行
    m_WarrorHeroObjectLevelList:= TStringList.Create; //英雄战士等级排行
    m_WizardHeroObjectLevelList:= TStringList.Create; //英雄法师等级排行
    m_TaoistHeroObjectLevelList:= TStringList.Create; //英雄道士等级排行

    g_FiltrateSortName:= TStringList.Create;//字符过滤列表
    g_FiltrateUserName:= TStringList.Create;//名字过滤列表

    G_HumLoginList:= TStringList.Create;
//------------------------------------------------------------------------------
  end;

finalization
  begin
    DeleteCriticalSection(HumDB_CS);
    DeleteCriticalSection(g_OutMessageCS);
    DeleteCriticalSection(HumanSortCriticalSection);//排行临界区 20080915
    DenyChrNameList.Free;
    ServerIPList.Free;
    GateIDList.Free;
    g_ClearMakeIndex.Free;
    g_MainMsgList.Free;
    StdItemList.Free;
    MagicList.Free;
//------------------------------------------------------------------------------
//20080219
    m_HumanOrderLevelList.Free;//人物等级排行
    m_WarrorObjectLevelList.Free; //战士等级排行
    m_WizardObjectLevelList.Free; //法师等级排行
    m_TaoistObjectLevelList.Free; //道士等级排行
    m_PlayObjectMasterList.Free; //徒弟数排行

    m_HeroObjectLevelList.Free; //英雄等级排行
    m_WarrorHeroObjectLevelList.Free; //英雄战士等级排行
    m_WizardHeroObjectLevelList.Free; //英雄法师等级排行
    m_TaoistHeroObjectLevelList.Free; //英雄道士等级排行

    g_FiltrateSortName.Free;//字符过滤列表
    g_FiltrateUserName.Free;//名字过滤列表

    G_HumLoginList.Free;
//------------------------------------------------------------------------------
  end;

end.

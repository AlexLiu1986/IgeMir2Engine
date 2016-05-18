unit GateShare;

interface
uses
  Windows, SysUtils, Classes, JSocket, WinSock, SyncObjs, IniFiles, Grobal2, Common, QQWry;
const
  g_sProductName = 'FD1EA72C79B074284E14499541CBA48E586745DD9DF92EC3'; //IGE�Ƽ���Ϸ����
  g_sVersion = 'D0C3641FA053A0C32F344FC7EADF5DF9ABABBC28C73FEB4D';  //2.00 Build 2008127
  g_sUpDateTime = '8076DE13F2070953D2CA60CF32F6DA5D'; //2008/12/27
  g_sProgram = 'C0CB995DE0C2A55814577F81CCE3A3BD'; //IGE�Ƽ�
  g_sWebSite = 'E14A1EC77CDEF28A670B57F56B07D834D8758E442B312AF440574B5A981AB1752C73BF5C6670B79C'; // http://www.IGEM2.com(����վ)
  g_sBbsSite = '2E5A58E761D583C119D6606E0F38D7A9D8758E442B312AF440574B5A981AB17538E97FF2F0C39555'; //http://www.IGEM2.com.cn(����վ)
  //g_sProductInfo = '8DFDF45695C4099770F02197A7BCE1C5B07D1DD7CD1455D1783D523EA941CBFB'; //��ӭʹ��IGE����ϵ�����:
  //g_sSellInfo1 = '71043F0BD11D04C7BA0E09F9A2EF83B7B936E13B070575B9';//��ϵ(QQ):228589790
  GATEMAXSESSION = 1000;
  MSGMAXLENGTH = 20000;
  SENDCHECKSIZE = 512;
  SENDCHECKSIZEMAX = 2048;

  sIPFileName      ='..\Mir200\IpList.db';//20080414 IP���ݿ�·��
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

  TBlockIPMethod = (mDisconnect, mBlock, mBlockList);
  TSockaddr = record
    nIPaddr: Integer;
    sIPDate: string;//20080414 IP������ַ
    dwStartAttackTick: LongWord;
    nAttackCount: Integer;
  end;
  pTSockaddr = ^TSockaddr;

  TSessionInfo = record
    Socket: TCustomWinSocket; //45AA8C
    sSocData: string; //45AA90
    sSendData: string; //45AA94
    nUserListIndex: Integer; //45AA98
    nPacketIdx: Integer; //45AA9C
    nPacketErrCount: Integer; //45AAA0  //���ݰ�����ظ��������ͻ����÷���������ݼ�⣩
    boStartLogon: Boolean; //45AAA4 �ͻ��˵�һ�ε�½
    boSendLock: Boolean; //45AAA5
    boOverNomSize: Boolean;
    nOverNomSizeCount: ShortInt;
    dwSendLatestTime: LongWord; //45AAA8
    nCheckSendLength: Integer; //45AAAC
    boSendAvailable: Boolean; //45AAB0
    boSendCheck: Boolean; //45AAB1
    dwTimeOutTime: LongWord; //0x28
    nReceiveLength: Integer; //45AAB8
    dwReceiveLengthTick: LongWord;
    dwReceiveTick: LongWord; //45AABC Tick ������Ϣ���
    nSckHandle: Integer; //45AAC0
    sRemoteAddr: string; //45AAC4
    dwSayMsgTick: LongWord; //���Լ������

    nErrorCount: Integer; //���ٵ��ۼ�ֵ
    dwHitTick: LongWord; //����ʱ��
    dwWalkTick: LongWord; //��·ʱ��
    dwRunTick: LongWord; //�ܲ�ʱ��
    dwSpellTick: LongWord; //ħ��ʱ��
  end;

  pTSessionInfo = ^TSessionInfo;
  TSendUserData = record
    nSocketIdx: Integer; //0x00
    nSocketHandle: Integer; //0x04
    sMsg: string; //0x08
  end;
  pTSendUserData = ^TSendUserData;
procedure AddMainLogMsg(Msg: string; nLevel: Integer);
procedure LoadAbuseFile();
procedure LoadBlockIPFile();
procedure SaveBlockIPList();
function SearchIPLocal(sIPaddr: string): string;
var
  CS_MainLog: TCriticalSection;
  CS_FilterMsg: TCriticalSection;
  MainLogMsgList: TStringList;
  nShowLogLevel: Integer = 3;
  GateClass: string = 'Server';
  GateName: string = '��Ϸ����';
  TitleName: string = 'IGE�Ƽ�';
  ServerAddr: string = '127.0.0.1';
  ServerPort: Integer = 5000;
  GateAddr: string = '0.0.0.0';
  GatePort: Integer = 7200;
  boStarted: Boolean = False;
  boClose: Boolean = False;
  boShowBite: Boolean = True; //��ʾB �� KB
  boServiceStart: Boolean = False;
  boGateReady: Boolean = False; //0045AA74 �����Ƿ����
  boCheckServerFail: Boolean = False; //���� <->��Ϸ������֮�����Ƿ�ʧ�ܣ���ʱ��
  dwCheckServerTimeOutTime: LongWord = 3 * 60 * 1000; //���� <->��Ϸ������֮���ⳬʱʱ�䳤��
  AbuseList: TStringList; //004694F4
  SessionArray: array[0..GATEMAXSESSION - 1] of TSessionInfo;
  SessionCount: Integer; //0x32C ���ӻỰ��
  boShowSckData: Boolean; //0x324 �Ƿ���ʾSOCKET���յ���Ϣ

  sReplaceWord: string = '*';
  ReviceMsgList: TList; //0x45AA64
  SendMsgList: TList; //0x45AA68
  nCurrConnCount: Integer;
  boSendHoldTimeOut: Boolean;
  dwSendHoldTick: LongWord;
  n45AA80: Integer;
  n45AA84: Integer;
  dwCheckRecviceTick: LongWord;
  dwCheckRecviceMin: LongWord;
  dwCheckRecviceMax: LongWord;

  dwCheckServerTick: LongWord;
  dwCheckServerTimeMin: LongWord;
  dwCheckServerTimeMax: LongWord;
  SocketBuffer: PChar; //45AA5C
  nBuffLen: Integer; //45AA60
  boDecodeMsgLock: Boolean;
  dwProcessReviceMsgTimeLimit: LongWord;
  dwProcessSendMsgTimeLimit: LongWord;

  BlockIPList: TGList; //��ֹ����IP�б�
  TempBlockIPList: TGList; //��ʱ��ֹ����IP�б�
  CurrIPaddrList: TGList;
  AttackIPaddrList: TGList; //����IP��ʱ�б�

  nMaxConnOfIPaddr: Integer = 50;
  nMaxClientPacketSize: Integer = 7000;
  nNomClientPacketSize: Integer = 200;
  dwClientCheckTimeOut: LongWord = 50; {3000}
  nMaxOverNomSizeCount: Integer = 2;
  nMaxClientMsgCount: Integer = 20;//��������
  nCheckServerFail: Integer = 0;
  dwAttackTick: LongWord = 200;
  nAttackCount: Integer = 10;

  BlockMethod: TBlockIPMethod = mDisconnect;
  bokickOverPacketSize: Boolean = True;

  nClientSendBlockSize: Integer = 2000; //���͸��ͻ������ݰ���С����
  dwClientTimeOutTime: LongWord = 120000; //�ͻ������ӻỰ��ʱ(ָ��ʱ����δ�����ݴ���)
  Conf: TIniFile;
  sConfigFileName: string = '.\RunGate.ini';
  nSayMsgMaxLen: Integer = 70; //�����ַ�����
  dwSayMsgTime: LongWord = 1000; //�������ʱ��
  //dwSessionTimeOutTime: LongWord = 60 * 60 * 1000;   ע�͵� 1��Сʱ�޶��� ���ߴ���  20080813

  g_boMinimize: Boolean = True;//20071121 ��������С������
//==============================================================================
//��ҿ�����ر���  20081223
  SpeedCheckClass: string = 'SpeedCheck';
  boStartHookCheck: Boolean = False;  //�Ƿ������˷����
  boStartWalkCheck: Boolean = False; //�Ƿ���������·����
  boStartHitCheck: Boolean = False; //�Ƿ������˹�������
  boStartRunCheck: Boolean = False; //�Ƿ��������ܲ�����
  boStartSpellCheck: Boolean = False; //�Ƿ�������ħ������
  boStartWarning: Boolean = False; //�Ƿ���������ʾ
  nIncErrorCount: Integer = 5; //ÿ�μ��ٵ��ۼ�ֵ
  nDecErrorCount: Integer = 1; //���������ļ���ֵ
  dwHitTime: LongWord = 600; //�������ʱ��
  dwWalkTime: LongWord = 550; //��·���ʱ��
  dwRunTime: LongWord = 580; //�ܲ����ʱ��
  dwSpellTime: LongWord = 950; //ħ�����ʱ��
  sErrMsg: string = '[��ʾ]: �밮����Ϸ�������رռ���������µ�½';

  
implementation

procedure AddMainLogMsg(Msg: string; nLevel: Integer);
var
  tMsg: string;
begin
  try
    CS_MainLog.Enter;
    if nLevel <= nShowLogLevel then begin
      tMsg := '[' + TimeToStr(Now) + '] ' + Msg;
      MainLogMsgList.Add(tMsg);
    end;
  finally
    CS_MainLog.Leave;
  end;
end;
procedure LoadAbuseFile();
var
  sFileName: string;
begin
  AddMainLogMsg('���ڼ������ֹ���������Ϣ...', 4);
  sFileName := '.\WordFilter.txt';
  if FileExists(sFileName) then begin
    try
      CS_FilterMsg.Enter;
      AbuseList.LoadFromFile(sFileName);
    finally
      CS_FilterMsg.Leave;
    end;
  end;
  AddMainLogMsg('���ֹ�����Ϣ�������...', 4);
end;

procedure LoadBlockIPFile();
var
  I: Integer;
  sFileName: string;
  LoadList: TStringList;
  sIPaddr: string;
  nIPaddr: Integer;
  IPaddr: pTSockaddr;
begin
  AddMainLogMsg('���ڼ���IP����������Ϣ...', 4);
  sFileName := '.\BlockIPList.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    BlockIPList.Lock;
   Try
    LoadList.LoadFromFile(sFileName);
    BlockIPList.Clear;
     for I := 0 to LoadList.Count - 1 do begin
        sIPaddr := Trim(LoadList.Strings[I]);
        if sIPaddr = '' then Continue;
        nIPaddr := inet_addr(PChar(sIPaddr));
        if nIPaddr = INADDR_NONE then Continue;
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.nIPaddr := nIPaddr;
        IPaddr^.sIPDate := SearchIPLocal(sIPaddr);
        BlockIPList.Add(IPaddr);
      end;
     finally
     BlockIPList.UnLock;
     LoadList.Free;
    end;
  end;
  AddMainLogMsg('IP����������Ϣ�������...', 4);
end;

procedure SaveBlockIPList();
var
  I: Integer;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  for I := 0 to BlockIPList.Count - 1 do begin
    SaveList.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr))));
  end;
  SaveList.SaveToFile('.\BlockIPList.txt');
  SaveList.Free;
end;
//��ѯIP������ַ  20080414
function SearchIPLocal(sIPaddr: string): string;
var
  QQWry: TQQWry;
  IPRecordID: int64;
  IPData: TStringlist;
begin
  try
    QQWry := TQQWry.Create(sIPFileName);
    IPRecordID := QQWry.GetIPDataID(sIPaddr);
    IPData := TStringlist.Create;
    QQWry.GetIPDataByIPRecordID(IPRecordID, IPData);
    QQWry.Destroy;
    Result := Trim(IPData.Strings[2]) + Trim(IPData.Strings[3]);
    IPData.Free;
  except
    Result := '';
  end;
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

initialization
  begin
    Conf := TIniFile.Create(sConfigFileName);
    nShowLogLevel := Conf.ReadInteger(GateClass, 'ShowLogLevel', nShowLogLevel);
    CS_MainLog := TCriticalSection.Create;
    CS_FilterMsg := TCriticalSection.Create;
    MainLogMsgList := TStringList.Create;
    AbuseList := TStringList.Create;
    ReviceMsgList := TList.Create;
    SendMsgList := TList.Create;
    boShowSckData := False;
  end;

finalization
  begin
    ReviceMsgList.Free;
    SendMsgList.Free;
    AbuseList.Free;
    MainLogMsgList.Free;
    CS_MainLog.Free;
    CS_FilterMsg.Free;
    Conf.Free;
  end;

end.


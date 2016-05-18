unit GateShare;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket, WinSock, SyncObjs, QQWry;
const
  GATEMAXSESSION = 10000;
resourcestring
  g_sProductName = 'FD1EA72C79B07428E4CD8B1C084A3260586745DD9DF92EC3'; //IGE�Ƽ���½����
  g_sVersion = 'AA4D9E73FFFD56492F344FC7EADF5DF9872751B81B38A757';  //2.00 Build 20081130
  g_sUpDateTime = '113E143B38ED28EBB9582809A7B375AA'; //2008/11/30
  g_sProgram = 'C0CB995DE0C2A55814577F81CCE3A3BD'; //IGE�Ƽ�
  g_sWebSite = 'E14A1EC77CDEF28A670B57F56B07D834D8758E442B312AF440574B5A981AB1752C73BF5C6670B79C'; // http://www.IGEM2.com(����վ)
  g_sBbsSite = '2E5A58E761D583C119D6606E0F38D7A9D8758E442B312AF440574B5A981AB17538E97FF2F0C39555'; //http://www.IGEM2.com.cn(����վ)
  //g_sProductInfo = '8DFDF45695C4099770F02197A7BCE1C5B07D1DD7CD1455D1783D523EA941CBFB'; //��ӭʹ��IGE����ϵ�����:
  //g_sSellInfo1 = '71043F0BD11D04C7BA0E09F9A2EF83B7B936E13B070575B9';//��ϵ(QQ):228589790
  
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
    nAttackCount: Integer;
    dwStartAttackTick: LongWord;
    nSocketHandle: Integer;
  end;
  pTSockaddr = ^TSockaddr;

procedure LoadBlockIPFile();
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
procedure SaveBlockIPList();
function SearchIPLocal(sIPaddr: string): string;//��ѯIP������ַ  20080414
var
  CS_MainLog: TCriticalSection;
  CS_FilterMsg: TCriticalSection;
  MainLogMsgList: TStringList;
  BlockIPList: TGList;
  TempBlockIPList: TGList;
  CurrIPaddrList: TGList;
  {CurrIPaddrArray:array [0..GATEMAXSESSION - 1] of Integer;
  nSocketCount:Integer = 0;}
  AttackIPaddrList: TGList;
  nIPCountLimit: Integer = 20;
  //nIPCountLimit2              :Integer = 40;
  nShowLogLevel: Integer = 3;
  StringList456A14: TStringList;
  GateClass: string = 'LoginGate';
  GateName: string = '��¼����';
  TitleName: string = 'IGE�Ƽ�';
  ServerPort: Integer = 37001;     //����LoginSrv�Ķ˿�
  ServerAddr: string = '127.0.0.1';
  GatePort: Integer = 37000;       //���ӿͻ��˵Ķ˿�
  GateAddr: string = '0.0.0.0';

  boGateReady: Boolean = False;
  boShowMessage: Boolean;
  boStarted: Boolean = False;
  boClose: Boolean = False;
  boServiceStart: Boolean = False;//�����Ƿ�����
  dwKeepAliveTick: LongWord;
  boKeepAliveTimcOut: Boolean = False;
  nSendMsgCount: Integer;
  n456A2C: Integer;
  n456A30: Integer;
  boSendHoldTimeOut: Boolean;
  dwSendHoldTick: LongWord;
  boDecodeLock: Boolean;
  nMaxConnOfIPaddr: Integer = 10;
  BlockMethod: TBlockIPMethod = mBlock;
  dwKeepConnectTimeOut: LongWord = 10000{10 * 1000};//�߳��޲����û����
  g_boDynamicIPDisMode: Boolean = False; //���ڶ�̬IP���ֻ����õ�¼�����ã��򿪴�ģʽ�����ؽ�������ӵ�¼��������IP��ַ����Ϊ������IP��������¼���������ͻ��˽�ֱ��ʹ�ô�IP���ӽ�ɫ����
  g_dwGameCenterHandle: THandle;
  g_sNowStartGate: string = '����������¼����...';
  g_sNowStartOK: string = '������¼�������...';

  UseBlockMethod: TBlockIPMethod;
  nUseAttackLevel: Integer;

  dwAttackTime: LongWord = 100;
  nAttackCount: Integer = 5;
  nReviceMsgLength: Integer = 380; //ÿMS������ܵĳ��ȣ���������Ϊ�ǹ���
  dwReviceTick: LongWord = 500;
  nAttackLevel: Integer = 1;
  nMaxClientMsgCount: Integer = 1;
  m_nAttackCount: Integer = 0;
  m_dwAttackTick: LongWord = 0;

  g_boChgDefendLevel: Boolean = True;//�Զ����������ȼ�
  g_nChgDefendLevel:Integer = 3; //�������Ĵ���
  g_boClearTempList: Boolean = True;
  g_dwClearTempList: LongWord = 120;
  g_boReliefDefend: Boolean = True;//��ԭ����
  g_dwReliefDefend: LongWord = 120;//��ԭ���� �ȴ�ʱ��
const
  tLoginGate = 4;
implementation

{----------------��ȡ����IP�б����--------------------}
procedure LoadBlockIPFile();
var
  I: Integer;
  sFileName: string;
  LoadList: TStringList;
  sIPaddr: string;
  nIPaddr: Integer;
  IPaddr: pTSockaddr;
begin
  sFileName := '.\BlockIPList.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sIPaddr := Trim(LoadList.Strings[0]);
      if sIPaddr = '' then Continue;
      nIPaddr := inet_addr(PChar(sIPaddr));
      if nIPaddr = INADDR_NONE then Continue;
      New(IPaddr);
      FillChar(IPaddr^, SizeOf(TSockaddr), 0);
      IPaddr.nIPaddr := nIPaddr;
      IPaddr.sIPDate := SearchIPLocal(sIPaddr);//20080414
      BlockIPList.Add(IPaddr);
    end;
    LoadList.Free;
  end;
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
{--------------��������IP�Ĺ���-----------------}
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

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tLoginGate), wIdent);
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

initialization
  begin
    CS_MainLog := TCriticalSection.Create;
    CS_FilterMsg := TCriticalSection.Create;
    StringList456A14 := TStringList.Create;
    MainLogMsgList := TStringList.Create;
  end;

finalization
  begin
    StringList456A14.Free;
    MainLogMsgList.Free;
    CS_MainLog.Free;
    CS_FilterMsg.Free;
  end;

end.


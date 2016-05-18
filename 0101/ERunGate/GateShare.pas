unit GateShare;

interface
uses
  Windows, SysUtils, Classes, JSocket, WinSock, SyncObjs, IniFiles, Grobal2, Common, QQWry;
const
  g_sProductName = 'FD1EA72C79B074284E14499541CBA48E586745DD9DF92EC3'; //IGE科技游戏网关
  g_sVersion = 'D0C3641FA053A0C32F344FC7EADF5DF9ABABBC28C73FEB4D';  //2.00 Build 2008127
  g_sUpDateTime = '8076DE13F2070953D2CA60CF32F6DA5D'; //2008/12/27
  g_sProgram = 'C0CB995DE0C2A55814577F81CCE3A3BD'; //IGE科技
  g_sWebSite = 'E14A1EC77CDEF28A670B57F56B07D834D8758E442B312AF440574B5A981AB1752C73BF5C6670B79C'; // http://www.IGEM2.com(官网站)
  g_sBbsSite = '2E5A58E761D583C119D6606E0F38D7A9D8758E442B312AF440574B5A981AB17538E97FF2F0C39555'; //http://www.IGEM2.com.cn(程序站)
  //g_sProductInfo = '8DFDF45695C4099770F02197A7BCE1C5B07D1DD7CD1455D1783D523EA941CBFB'; //欢迎使用IGE网络系列软件:
  //g_sSellInfo1 = '71043F0BD11D04C7BA0E09F9A2EF83B7B936E13B070575B9';//联系(QQ):228589790
  GATEMAXSESSION = 1000;
  MSGMAXLENGTH = 20000;
  SENDCHECKSIZE = 512;
  SENDCHECKSIZEMAX = 2048;

  sIPFileName      ='..\Mir200\IpList.db';//20080414 IP数据库路径
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
    sIPDate: string;//20080414 IP所属地址
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
    nPacketErrCount: Integer; //45AAA0  //数据包序号重复计数（客户端用封包发送数据检测）
    boStartLogon: Boolean; //45AAA4 客户端第一次登陆
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
    dwReceiveTick: LongWord; //45AABC Tick 发送信息间隔
    nSckHandle: Integer; //45AAC0
    sRemoteAddr: string; //45AAC4
    dwSayMsgTick: LongWord; //发言间隔控制

    nErrorCount: Integer; //加速的累计值
    dwHitTick: LongWord; //攻击时间
    dwWalkTick: LongWord; //走路时间
    dwRunTick: LongWord; //跑步时间
    dwSpellTick: LongWord; //魔法时间
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
  GateName: string = '游戏网关';
  TitleName: string = 'IGE科技';
  ServerAddr: string = '127.0.0.1';
  ServerPort: Integer = 5000;
  GateAddr: string = '0.0.0.0';
  GatePort: Integer = 7200;
  boStarted: Boolean = False;
  boClose: Boolean = False;
  boShowBite: Boolean = True; //显示B 或 KB
  boServiceStart: Boolean = False;
  boGateReady: Boolean = False; //0045AA74 网关是否就绪
  boCheckServerFail: Boolean = False; //网关 <->游戏服务器之间检测是否失败（超时）
  dwCheckServerTimeOutTime: LongWord = 3 * 60 * 1000; //网关 <->游戏服务器之间检测超时时间长度
  AbuseList: TStringList; //004694F4
  SessionArray: array[0..GATEMAXSESSION - 1] of TSessionInfo;
  SessionCount: Integer; //0x32C 连接会话数
  boShowSckData: Boolean; //0x324 是否显示SOCKET接收的信息

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

  BlockIPList: TGList; //禁止连接IP列表
  TempBlockIPList: TGList; //临时禁止连接IP列表
  CurrIPaddrList: TGList;
  AttackIPaddrList: TGList; //攻击IP临时列表

  nMaxConnOfIPaddr: Integer = 50;
  nMaxClientPacketSize: Integer = 7000;
  nNomClientPacketSize: Integer = 200;
  dwClientCheckTimeOut: LongWord = 50; {3000}
  nMaxOverNomSizeCount: Integer = 2;
  nMaxClientMsgCount: Integer = 20;//数量限制
  nCheckServerFail: Integer = 0;
  dwAttackTick: LongWord = 200;
  nAttackCount: Integer = 10;

  BlockMethod: TBlockIPMethod = mDisconnect;
  bokickOverPacketSize: Boolean = True;

  nClientSendBlockSize: Integer = 2000; //发送给客户端数据包大小限制
  dwClientTimeOutTime: LongWord = 120000; //客户端连接会话超时(指定时间内未有数据传输)
  Conf: TIniFile;
  sConfigFileName: string = '.\RunGate.ini';
  nSayMsgMaxLen: Integer = 70; //发言字符长度
  dwSayMsgTime: LongWord = 1000; //发主间隔时间
  //dwSessionTimeOutTime: LongWord = 60 * 60 * 1000;   注释掉 1个小时无动作 掉线处理  20080813

  g_boMinimize: Boolean = True;//20071121 启动后最小化程序
//==============================================================================
//外挂控制相关变量  20081223
  SpeedCheckClass: string = 'SpeedCheck';
  boStartHookCheck: Boolean = False;  //是否启动了反外挂
  boStartWalkCheck: Boolean = False; //是否启动了走路控制
  boStartHitCheck: Boolean = False; //是否启动了攻击控制
  boStartRunCheck: Boolean = False; //是否启动了跑步控制
  boStartSpellCheck: Boolean = False; //是否启动了魔法控制
  boStartWarning: Boolean = False; //是否开启加密提示
  nIncErrorCount: Integer = 5; //每次加速的累加值
  nDecErrorCount: Integer = 1; //正常动作的减少值
  dwHitTime: LongWord = 600; //攻击间隔时间
  dwWalkTime: LongWord = 550; //走路间隔时间
  dwRunTime: LongWord = 580; //跑步间隔时间
  dwSpellTime: LongWord = 950; //魔法间隔时间
  sErrMsg: string = '[提示]: 请爱护游戏环境，关闭加速外挂重新登陆';

  
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
  AddMainLogMsg('正在加载文字过滤配置信息...', 4);
  sFileName := '.\WordFilter.txt';
  if FileExists(sFileName) then begin
    try
      CS_FilterMsg.Enter;
      AbuseList.LoadFromFile(sFileName);
    finally
      CS_FilterMsg.Leave;
    end;
  end;
  AddMainLogMsg('文字过滤信息加载完成...', 4);
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
  AddMainLogMsg('正在加载IP过滤配置信息...', 4);
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
  AddMainLogMsg('IP过滤配置信息加载完成...', 4);
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
//查询IP所属地址  20080414
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


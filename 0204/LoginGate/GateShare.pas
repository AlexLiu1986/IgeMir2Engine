unit GateShare;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket, WinSock, SyncObjs, QQWry;
const
  GATEMAXSESSION = 10000;
  SPECVERSION = 0; //1是商业版 20080831
resourcestring
  g_sProductName = 'FD1EA72C79B07428E4CD8B1C084A3260586745DD9DF92EC3'; //IGE科技登陆网关
  g_sVersion = '82FAC94BBFFC70372F344FC7EADF5DF9BDCF5B8070D2B211';  //2.00 Build 20081129
  g_sUpDateTime = 'CD5175A7F7A5CD4F49413244286E35EB'; //2008/11/29
  g_sProgram = 'C0CB995DE0C2A55814577F81CCE3A3BD'; //IGE科技
  g_sWebSite = 'E14A1EC77CDEF28A670B57F56B07D834D8758E442B312AF440574B5A981AB1752C73BF5C6670B79C'; // http://www.IGEM2.com(官网站)
  g_sBbsSite = '2E5A58E761D583C119D6606E0F38D7A9D8758E442B312AF440574B5A981AB17538E97FF2F0C39555'; //http://www.IGEM2.com.cn(程序站)
  g_sLogoStr = 'F599FE4042939E7C70749AE14B9BCD27B07D1DD7CD1455D1E6377F8305FC113D';//欢迎使用IGE科技商业网关...
  //g_sProductInfo = '8DFDF45695C4099770F02197A7BCE1C5B07D1DD7CD1455D1783D523EA941CBFB'; //欢迎使用IGE网络系列软件:
  //g_sSellInfo1 = '71043F0BD11D04C7BA0E09F9A2EF83B7B936E13B070575B9';//联系(QQ):228589790

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
    sIPaddr: string;//IP段 20081030
    sIPDate: string;//20080414 IP所属地址
    nAttackCount: Integer;
    dwStartAttackTick: LongWord;
    nSocketHandle: Integer;
  end;
  pTSockaddr = ^TSockaddr;
  
  {$IF SPECVERSION = 1}  //20080831
//自身信息记录
  TRecinfo = record
    GatePass: string[30];
  end;
  {$IFEND}
procedure LoadBlockIPFile();
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
procedure SaveBlockIPList();
function SearchIPLocal(sIPaddr: string): string;//查询IP所属地址  20080414
{$IF SPECVERSION = 1}
procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);
function ProgramPath: string;
function Encrypt(const s:string; skey:string):string;
function Decrypt(const s:string; skey:string):string;
function CertKey(key: string): string;
{$IFEND}
const
  tLoginGate = 4;
  {$IF SPECVERSION = 1}
  RecInfoSize = Sizeof(TRecinfo);  //返回被TRecinfo所占用的字节数
  {$IFEND}
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
  GateName: string = '登录网关';
  TitleName: string = 'IGE科技';
  ServerPort: Integer = 5500;     //连接LoginSrv的端口
  ServerAddr: string = '127.0.0.1';
  GatePort: Integer = 7000;       //连接客户端的端口
  GateAddr: string = '0.0.0.0';

  boGateReady: Boolean = False;
  boShowMessage: Boolean;
  boStarted: Boolean = False;
  boClose: Boolean = False;
  boServiceStart: Boolean = False;
  dwKeepAliveTick: LongWord;
  boKeepAliveTimcOut: Boolean = False;
  nSendMsgCount: Integer;
  n456A2C: Integer;
  n456A30: Integer;
  boSendHoldTimeOut: Boolean;
  dwSendHoldTick: LongWord;
  boDecodeLock: Boolean;
  nMaxConnOfIPaddr: Integer = 50;//20081215
  BlockMethod: TBlockIPMethod = mBlock;
  dwKeepConnectTimeOut: LongWord = 120000{60 * 1000};//20081215
  g_boDynamicIPDisMode: Boolean = False; //用于动态IP，分机放置登录网关用，打开此模式后，网关将会把连接登录服务器的IP地址，当为服务器IP，发给登录服务器，客户端将直接使用此IP连接角色网关
  g_dwGameCenterHandle: THandle;
  g_sNowStartGate: string = '正在启动登录网关...';
  g_sNowStartOK: string = '启动登录网关完成...';

  UseBlockMethod: TBlockIPMethod;
  nUseAttackLevel: Integer;

  dwAttackTime: LongWord = 100;
  nAttackCount: Integer = 5;
  nReviceMsgLength: Integer = 380; //每MS允许接受的长度，超过即认为是攻击
  dwReviceTick: LongWord = 500;
  nAttackLevel: Integer = 1;
  nMaxClientMsgCount: Integer = 1;
  m_nAttackCount: Integer = 0;
  m_dwAttackTick: LongWord = 0;

  g_boMinimize: Boolean = True;
  g_boChgDefendLevel: Boolean = True;//自动调整防御等级
  g_nChgDefendLevel:Integer = 3; //被攻击的次数
  g_boClearTempList: Boolean = True;
  g_dwClearTempList: LongWord = 120;
  g_boReliefDefend: Boolean = True;//还原防御
  g_dwReliefDefend: LongWord = 120;//还原防御 等待时间
  {$IF SPECVERSION = 1}
  g_sPassWord: string = 'PassWord'; //20080831
  g_boSpecLogin: Boolean = False;   //20080831
  MyRecInfo: TRecInfo;
  {$IFEND}
implementation

{$IF SPECVERSION = 1}
//读出自身配置等信息
procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);
var
  SourceFile: file;
begin
  try
    AssignFile(SourceFile, FilePath);
    FileMode := 0;
    Reset(SourceFile, 1);
    Seek(SourceFile, FileSize(SourceFile) - RecInfoSize);
    BlockRead(SourceFile, MyRecInfo, RecInfoSize);
    CloseFile(SourceFile);
  except
  end;
end;

function myStrtoHex(s: string): string;
var tmpstr:string;
    i:integer;
begin
    tmpstr := '';
    for i:=1 to length(s) do
    begin
        tmpstr := tmpstr + inttoHex(ord(s[i]),2);
    end;
    result := tmpstr;
end;

//得到文件自身的路径及文件名
function ProgramPath: string;
begin
   SetLength(Result, 256);
   SetLength(Result, GetModuleFileName(HInstance, PChar(Result), 256));
end;

//加密
function Encrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
    hexS   :=myStrtoHex(s);
    hexskey:=myStrtoHex(skey);
    midS   :=hexS;
    for i:=1 to (length(hexskey) div 2)   do
    begin
        if i<>1 then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do
        begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := tmpstr;
end;

function Decrypt(const s:string; skey:string):string;
  function myHextoStr(S: string): string;
  var
    hexS,tmpstr:string;
    i:integer;
    a:byte;
  begin
    hexS  :=s;//应该是该字符串
    if length(hexS) mod 2=1 then begin
        hexS:=hexS+'0';
    end;
    tmpstr:='';
    for i:=1 to (length(hexS) div 2) do begin
        a:=strtoint('$'+hexS[2*i-1]+hexS[2*i]);
        tmpstr := tmpstr+chr(a);
    end;
    result :=tmpstr;
  end;
var
  i,j: integer;
  hexS,hexskey,midS,tmpstr:string;
  a,b,c:byte;
begin
  hexS  :=s;//应该是该字符串
  if length(hexS) mod 2=1 then
  begin
      exit;
  end;
  hexskey:=myStrtoHex(skey);
  tmpstr :=hexS;
  midS   :=hexS;
  for i:=(length(hexskey) div 2) downto 1 do begin
    if i<>(length(hexskey) div 2) then midS:= tmpstr;
    tmpstr:='';
    for j:=1 to (length(midS) div 2) do begin
        a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
        b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
        c:=a xor b;
        tmpstr := tmpstr+myStrtoHex(chr(c));
    end;
  end;
  result := myHextoStr(tmpstr);
end;

//解密密钥
function CertKey(key: string): string;
var i: Integer;
begin
  for i:=1 to length(key) do
    result := result + chr(ord(key[i]) xor length(key)*i*i)
end;
{$IFEND}

{----------------读取阻拦IP列表过程--------------------}
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
      if pos('*',sIPaddr) > 0 then begin//判断是否是IP段 20081030
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr^.sIPaddr := sIPaddr;//IP段
        BlockIPList.Add(IPaddr);
      end else begin
        nIPaddr := inet_addr(PChar(sIPaddr));
        if nIPaddr = INADDR_NONE then Continue;
        New(IPaddr);
        FillChar(IPaddr^, SizeOf(TSockaddr), 0);
        IPaddr.nIPaddr := nIPaddr;
        IPaddr.sIPDate := SearchIPLocal(sIPaddr);//20080414
        BlockIPList.Add(IPaddr);
      end;
    end;
    LoadList.Free;
  end;
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
{--------------储存阻拦IP的过程-----------------}
procedure SaveBlockIPList();
var
  I: Integer;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  for I := 0 to BlockIPList.Count - 1 do begin
    if pos('*',pTSockaddr(BlockIPList.Items[I]).sIPaddr) > 0 then begin//判断是否是IP段 20081030
      SaveList.Add(pTSockaddr(BlockIPList.Items[I]).sIPaddr);
    end else begin
      SaveList.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr))));
    end;
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


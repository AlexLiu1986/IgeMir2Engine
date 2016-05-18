unit Common;

interface
uses
  Windows, SysUtils, Classes, Shlobj, Activex, Registry, Forms,
  ComObj, VCLZip, VCLUnZip;
type
//自身信息记录
  TRecinfo = record
    GameListURL: string[120];
    PatchListURL: string[120];
    GameMonListURL: string[120];
    GameESystemUrl: string[120];
    boGameMon :Boolean;
    lnkName: string[20];
    ClientFileName: string[20];
    ClientLocalFileName: string[20];
    GameSdoFilter: array[0..50000] of char;
  end;
//更新记录
  TPatchInfo = record
    PatchType        : Integer;
    PatchFileDir     : string;
    PatchName        : string;
    PatchMd5         : string;
    PatchDownAddress : string;
  end;
  pTPatchInfo = ^TPatchInfo;
//列表记录
  TServerInfo = record
    ServerArray        : string;
    ServerName     : string;
    ServerIP        : string;
    ServerPort         : integer;
    ServerNoticeURL : string; //公告
    ServerHomeURL : string; //主页
  end;
  pTServerInfo = ^TServerInfo;

  TGetUrlStep = (ServerList, UpdateList, GameMonList);

function RunApp(AppName: string; I: Integer): Integer; //运行程序
procedure Createlnk(LnkName: string);//快捷方式
//function DownLoadFile(sURL,sFName: string;CanBreak: Boolean;IdHTTP:TIdHTTP): boolean;  //下载文件
procedure PatchSelf(aFileName:string);//更新自身文件
function ExtractFileFromZip(const DesPathName,ZipFileName: string): Boolean; //解压Zip文件
function SelectDirectory(const Caption: string; const Root: WideString;  //选择目录函数
  var Directory: string; Owner: THandle): Boolean;
procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);  //读出自身配置等信息
function CheckMirDir(DirName: string): Boolean; //检查是否传奇目录
function ProgramPath: string; //得到文件自身的路径及文件名
function decrypt(const s:string; skey:string):string;
function encrypt(const s:string; skey:string):string;
function CertKey(key: string): string;
procedure GetdriveName(var sList: TStringList);  //获取当前的硬盘所有的盘符
function CheckIsIpAddr(Name: string): Boolean; //检查IP地址格式
function CheckSdoClientVer(Path: string):Boolean;
const
    RecInfoSize = Sizeof(TRecinfo);  //返回被TRecinfo所占用的字节数
    UpDateFile = 'QkUpdate.lis';
var
  g_boIsGamePath: Boolean;
  busy: Boolean;
  SocStr, BufferStr: string;
  MakeNewAccount: string;
  CanBreak:Boolean;
  g_PatchList: TList;
  g_ServerList: TList;
  g_GameMonModule : TStringList;
  g_GameMonProcess : TStringList;
  g_GameMonTitle : TStringList;
  m_boClientSocketConnect: Boolean;
  m_BoSearchFinish: Boolean;
  HomeURL: string;
  code: byte = 1;
  g_boGatePassWord: Boolean = False; //是否有封包码的验证
implementation
//运行程序
function RunApp(AppName: string; I: Integer): Integer;
var
  Sti: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillMemory(@Sti, SizeOf(Sti), 0);
  Sti.wShowWindow := I;
  Sti.dwFlags := STARTF_USEFILLATTRIBUTE;
  Sti.dwFillAttribute := FOREGROUND_INTENSITY or BACKGROUND_BLUE;
  if CreateProcess(nil{PChar(AppName)}, PChar(AppName + ' 56m2'),//nil,
    nil, nil, FALSE,
    0, nil, PChar(ExtractFilePath(AppName)),
    Sti, ProcessInfo) then begin
    Result := ProcessInfo.dwProcessId;
  end else Result := -1;
end;
//快捷方式
procedure Createlnk(LnkName: string);
var
  ShLink: IShellLink;
  PFile: IPersistFile;
  FileName: string;
  WFileName: WideString;
  Reg: TRegIniFile;
  AnObj: IUnknown;
begin
  AnObj := CreateComObject(CLSID_ShellLink); //快捷方式的初始化
  ShLink := AnObj as IShellLink;
  PFile := AnObj as IPersistFile;
  FileName := ParamStr(0);
  ShLink.SetPath(PChar(FileName));
  ShLink.SetWorkingDirectory(PChar(ExtractFilePath(FileName)));
  Reg := TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer');
  WFileName := Reg.ReadString('Shell Folders', 'Desktop', '') + '\' + LnkName + '.lnk';
  Reg.Free;
  PFile.Save(PWChar(WFileName), False);
end;
//更新自身文件
procedure PatchSelf(aFileName:string);
var
  F:TextFile;
begin
  AssignFile(F,'PatchSelf.bat');
  Rewrite(F);
  WriteLn(F,'ping -n 2 127.1 >nul 2>nul');//延时 2秒
  WriteLn(F,'ren '+ExtractFileName(Paramstr(0))+' '+ExtractFileName(Paramstr(0))+'bak');
  WriteLn(F,'ren '+aFileName+' '+ExtractFileName(Paramstr(0)));
  WriteLn(F,'del '+ExtractFileName(Paramstr(0))+'bak');
  WriteLn(F,'del %0');
  WriteLn(F,ExtractFileName(Paramstr(0)));
  CloseFile(F);
  WinExec('PatchSelf.bat',SW_HIDE);//
end;
(*//下载文件
function DownLoadFile(sURL,sFName: string;CanBreak: Boolean;IdHTTP:TIdHTTP): boolean;  //下载文件
{  function CheckUrl(url:string):boolean;
  var
    HSession, Hfile: HInternet;
    dwindex,dwcodelen :dword;
    dwcode:array[1..20] of char;
    res : pchar;
  begin
    if pos('http://',lowercase(url))=0 then url := 'http://'+url;
    Result := false;
    hSession := InternetOpen('InetURL:/1.0', INTERNET_OPEN_TYPE_PRECONFIG,nil, nil, 0);
    if assigned(hsession) then begin
      hfile := InternetOpenUrl(
           hsession,
           pchar(url),
           nil,
           0,
           INTERNET_FLAG_RELOAD,
           0);
      dwIndex  := 0;
      dwCodeLen := 10;
      HttpQueryInfo(hfile, HTTP_QUERY_STATUS_CODE,
              @dwcode, dwcodeLen, dwIndex);
      res := pchar(@dwcode);
      result:= (res ='200') or (res ='302');
      if assigned(hfile) then InternetCloseHandle(hfile);
      InternetCloseHandle(hsession);
    end;
  end; }
{-------------------------------------------------------------------------------
  过程名:    GetOnlineStatus 检查计算机是否联网
  作者:      清清
  日期:      2008.07.20
  参数:      无
  返回值:    Boolean

  Eg := if GetOnlineStatus then ShowMessage('你计算机联网了') else ShowMessage('你计算机没联网');
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
  if not GetOnlineStatus then begin //本机器没有联网
    Result := False;
    Exit;
  end;
  tStream := TMemoryStream.Create;
  if CheckUrl(sURL) then begin  //判断URL是否有效
    try //防止不可预料错误发生
      if CanBreak then exit;
      IdHTTP.Get(PChar(sURL),tStream); //保存到内存流
      tStream.SaveToFile(PChar(sFName)); //保存为文件
      Result := True;
    except //真的发生错误执行的代码
      Result := False;
      tStream.Free;
    end;
  end else begin
    Result := False;
    tStream.Free;
  end;
end;  *)
//解压Zip文件
function ExtractFileFromZip(const DesPathName,ZipFileName: string): Boolean;
var
  AZip: TVCLZip;
begin
  AZip := TVCLZip.Create(nil);
  try
    with AZip do begin
      OverwriteMode := Always;
      ZipName := ZipFileName;
      ZipAction := zaReplace;
      DestDir := DesPathName;
      ReadZip;
      DoAll := True;
      RecreateDirs := True;
      RetainAttributes := True;
      ReplaceReadOnly := True;
      UnZip;
    end;
  finally
    FreeAndNil(AZip);
  end;
  Result := True;
end;

//选择文件夹函数
function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) and (lpData <> 0) then
    SendMessage(Wnd, BFFM_SETSELECTION, Integer(True), lpData);
  result := 0;
end;

function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string; Owner: THandle): Boolean;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
begin
  result := FALSE;
  if not DirectoryExists(Directory) then
    Directory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do begin
        hwndOwner := Owner;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS;
        if Directory <> '' then begin
          lpfn := SelectDirCB;
          lParam := Integer(PChar(Directory));
        end;
      end;
      WindowList := DisableTaskWindows(0);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        EnableTaskWindows(WindowList);
      end;
      result := ItemIDList <> nil;
      if result then begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Directory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;

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

//得到文件自身的路径及文件名
function ProgramPath: string;
begin
   SetLength(Result, 256);
   SetLength(Result, GetModuleFileName(HInstance, PChar(Result), 256));
end;

//检查是否传奇目录
function CheckMirDir(DirName: string): Boolean;
begin
  if (not DirectoryExists(DirName + 'Data')) or
    (not DirectoryExists(DirName + 'Map')) or
    (not DirectoryExists(DirName + 'Wav')) or
    (not FileExists(DirName + 'Data\ChrSel.wil')) then
    Result := FALSE else Result := True;
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

function myHextoStr(S: string): string;
var hexS,tmpstr:string;
    i:integer;
    a:byte;
begin
    hexS  :=s;//应该是该字符串
    if length(hexS) mod 2=1 then
    begin
        hexS:=hexS+'0';
    end;
    tmpstr:='';
    for i:=1 to (length(hexS) div 2) do
    begin
        a:=strtoint('$'+hexS[2*i-1]+hexS[2*i]);
        tmpstr := tmpstr+chr(a);
    end;
    result :=tmpstr;
end;

//加密
function encrypt(const s:string; skey:string):string;
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

//解密
function decrypt(const s:string; skey:string):string;
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
    for i:=(length(hexskey) div 2) downto 1 do
    begin
        if i<>(length(hexskey) div 2) then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do
        begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := myHextoStr(tmpstr);
end;
{******************************************************************************}
//解密密钥
function CertKey(key: string): string;
var i: Integer;
begin
  for i:=1 to length(key) do
    result := result + chr(ord(key[i]) xor length(key)*i*i)
end;

//获取当前的硬盘所有的盘符
procedure GetdriveName(var sList: TStringList);
var
  I, dtype: Integer;
  c: string;
begin
  for I := 65 to 90 do begin
    c := chr(I) + ':\';
    dtype := getdrivetype(PChar(c));
    if (not ((dtype = 0) or (dtype = 1))) and (dtype = drive_fixed) then {//过滤光驱}  begin
      sList.Add(c);
    end;
  end;
end;

//检查IP地址格式
function CheckIsIpAddr(Name: string): Boolean;
var
  PStr: char;
  Temp: PChar;
  I: integer;
begin
  Result := True;
  if Length(Name) <= 15 then begin
    for I := 0 to Length(Name) do begin
      Temp := PChar(copy(Name, I, 1));
      PStr := Temp^;
      if not (PStr in ['0'..'9', '.']) then begin
        Result := False;
        break
      end;
    end;
  end else Result := False;
end;

//检查盛大客户端版本
function CheckSdoClientVer(Path: string):Boolean;
  function StrConut(Str:string):string;
  var
   I,K:Integer;
  begin
    Result := '';
    K := Length(str);
    if K = 0 then Exit;
    for I:=1 to K do
      if not (str[I] in ['.']) then Result:=Result+str[I];
  end;
var
  VerFile: TStringList;
  Int: Integer;
  SdoVer: Integer;
begin
  Result := False;
  if not FileExists(Path+'Data\Ver.Dat') then begin //文件不存在
    Exit;
  end;
  try
    VerFile := TStringList.Create;
    VerFile.LoadFromFile(Path+'Data\Ver.Dat');
    if VerFile.Text <> '' then begin
       Int := pos('ver=',VerFile.Text);
       if Int <> 0 then begin
          SdoVer := StrToInt(Trim(StrConut(Copy(VerFile.Text,Int+4,length(VerFile.Text)))));
          if SdoVer >= 1840 then Result := True;
       end;
    end;
  finally
    VerFile.Free;
  end;
end;
end.

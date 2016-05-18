unit Share;

interface
uses SysUtils, Windows, IniFiles, Registry;

Type
  TRecinfo = record//插件自身信息记录
    PlugName: string[50];//插件名称
    StartLoadPlugSucced: string[50];//加载成功信息
    StartLoadPlugFail: string[50];//加载失败信息
    UnLoadPlug: string[50];//卸载信息
    GameShowUrl: String[250];//注册窗口显示的信息
    BakGameListURL: string[50];//注册用户(即密钥)
  end;

const
  MyRootKey = HKEY_LOCAL_MACHINE; //注册表根键
  MySubKey = '\Software\Microsoft\Windows\CurrentVersion\Windows UpData\'; //注册表子键

  RecInfoSize = Sizeof(TRecinfo);//TRecinfo所占用的字节数
  sIPFileName = '.\IpList.db';//IP地址数据库
  HookDeCodeText = 1; //文本配置信息解码函数
  HookSearchIPLocal = 0; //IP所在地查询函数 0-不启用 1-启用
  HookSearchMode = 1;//0-免费模式 1-商业模式(需注册) 20081016
{$IF HookSearchMode = 1}
  //sKey = '=7;88?:';//2847705 注册,加解密密码
  sKey = 'KOXwJ?\{J\';//2847705
  sPlugName ='3mt69xp4nWEGlbytxBXNxIexHyTAeb0pDjvU9rrjaXc2WjcfO4bIUPneOawrhd8BK9/JCQSNEdk=';//【IGE科技 商业脚本插件】2008/11/30
  sStartLoadPlugSucced = 'qMeN1RCToSYdzwoF60BJqCi75xlJKHjQproVCyR1w38NwX1q8/t/TTsjpmblOjElNG41';//加载【IGE科技 商业脚本插件】成功
  sStartLoadPlugFail = 'qMeN1RCToSYdzwoF60BJqCi75xlJKHjQproVCyR1w38NwX1q8/6G3xUxbxqG/DGaaKAF';//加载【IGE科技 商业脚本插件】失败
  sUnLoadPlug = '7u5Q9053aW691i7DCvV6M3g3L1xtKQyXUx75XDVkwI5Y1UF//wqibkWgvdaP5/HX7eHM';//卸载【IGE科技 商业脚本插件】成功
  sMsg  = '2ZW3WbILr7nYHZHlD2QuEimZkC4GQSY/4Sq74vg9hbpec6mV0fOR+US7m+w=';//联系：IGE科技 QQ:228589790
  sLoadRedOK ='qk7mDAICgi9WFkc8t+XKgj0fbm6DYqEbABHjA9Kyh3M4u19q';//商业插件注册成功！！！
{$ELSE}
  //sKey = '<67;<=;<>';//398432431 注册,加解密密码
  sKey = 'K?TsJolyJolz';//398432431
  sPlugName = '3mt69xp4nWEGlbytxBBriKxCH6z53/IqQLbwINzJZwSuIUI7gGvbekawPTDtUThEAvhd8bjBKKI=';//【IGE科技 脚本扩展插件】2008/11/30
  sStartLoadPlugSucced = 'qMeN1RCToSYdzwoF60BJqCi75EEAlX3V87KqBi8Tc//Iz3TYyZo9IhEaoXjF5p3jauqG';//加载【IGE科技 脚本扩展插件】成功
  sStartLoadPlugFail = 'qMeN1RCToSYdzwoF60BJqCi75EEAlX3V87KqBi8Tc//Iz3TYyZ+phlgQho1qBvMBvQ/a';//加载【IGE科技 脚本扩展插件】失败
  sUnLoadPlug = '7u5Q9053aW691i7DCvV6M3g3LN6BD+zV2vh6Sa3Ug9/RA2QMo3rHsnOlV01R+waX7Sc+';//卸载【IGE科技 脚本扩展插件】成功
{$IFEND}

  procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);//读出自身配置等信息
  procedure IniWriteString(sKey, sRegisterInfo: string);//写入windows目录下的ini文件
  function IniReadString(sKey: string; var sResult: string): Boolean;//读入windows目录下的ini文件
  function WriteRegKey(const iMode: Integer; const sPath, sKeyName, sKeyValue: string): Boolean;//写注册表
  function ReadRegKey(const iMode: Integer; const sPath, sKeyName: string; var sResult: string): Boolean;//读注册表
  procedure IniWrite(sRegisterInfo: string);//假写入!Setup.txt文件
var
  nCheckCode: Integer;
  sDecryKey: string;
  m_sRegisterName: string;//机器码
  nRegister: Integer;
  MyRecInfo: TRecInfo;

  nFileName: string;//插件名称 20081026
  nFileLoadSucced: string;//加载成功信息 20081026
  nFileLoadFail: string;//加载失败信息 20081026
  nFileClose: string;//卸载信息 20081026
  nFileShowName: string;//注册窗口显示的信息 20081025
  nFileMode: String;//读取自身的注册用户(即密钥) 20081025

implementation

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
//取windows目录
function myGetWindowsDirectory: string;
var
  pcWindowsDirectory: PChar;
  dwWDSize: DWORD;
begin
  dwWDSize := MAX_PATH + 1;
  Result := '';
  Try
    GetMem(pcWindowsDirectory, dwWDSize);
    try
      if Windows.GetWindowsDirectory(pcWindowsDirectory, dwWDSize) <> 0 then
        Result := pcWindowsDirectory;
    finally
      FreeMem(pcWindowsDirectory);
    end;
  except
    //MainOutMessasge('[异常] SystemModule:TLicense.myGetWindowsDirectory',0);
  end;
end;

//写入windows目录下的ini文件
procedure IniWriteString(sKey, sRegisterInfo: string);
var
  MyIniFile: TInifile;
  sWindowsDirectory: string;
begin
  Try
    sWindowsDirectory := myGetWindowsDirectory;
    if sWindowsDirectory[Length(sWindowsDirectory)] <> '\' then sWindowsDirectory := sWindowsDirectory + '\';
    MyIniFile := TInifile.Create(sWindowsDirectory + m_sRegisterName + '.ini');
    if MyIniFile <> nil then begin
      MyIniFile.WriteString(m_sRegisterName, sKey, sRegisterInfo);
      MyIniFile.Free;
    end;
    //FileSetAttr(sWindowsDirectory + FKeyFileName, faReadOnly or faSysFile or faHidden);
    FileSetAttr(sWindowsDirectory + m_sRegisterName + '.ini', faHidden + faSysFile);
  except
    //MainOutMessasge('[异常] SystemModule:TLicense.IniWriteString',0);
  end;
end;
//读入windows目录下的ini文件
function IniReadString(sKey: string; var sResult: string): Boolean;
var
  MyIniFile: TInifile;
  sWindowsDirectory: string;
begin
  Result := False;
  Try
    sWindowsDirectory := myGetWindowsDirectory;
    if sWindowsDirectory[Length(sWindowsDirectory)] <> '\' then sWindowsDirectory := sWindowsDirectory + '\';
    MyIniFile := TInifile.Create(sWindowsDirectory + m_sRegisterName + '.ini');
    if MyIniFile <> nil then begin
      sResult := Trim(MyIniFile.ReadString(m_sRegisterName, sKey, ''));
      MyIniFile.Free;
    end;
    if sResult <> '' then Result := True;
  except
    //MainOutMessasge('[异常] SystemModule:TLicense.IniReadString',0);
  end;
end;
//读注册表
function ReadRegKey(const iMode: Integer; const sPath, sKeyName: string; var sResult: string): Boolean;
var
  rRegObject: TRegistry;
begin
  Result := False;
  Try
    rRegObject := TRegistry.Create;
    try
      with rRegObject do begin
        RootKey := MyRootKey;
        if OpenKey(sPath, True) then begin
          case iMode of
            1: sResult := Trim(ReadString(sKeyName));
            2: sResult := IntToStr(ReadInteger(sKeyName));
          end;
          if sResult = '' then Result := False else Result := True;
        end
        else
          Result := False;
        CloseKey;
      end;
    finally
      rRegObject.Free;
    end;
  except
    //MainOutMessasge('[异常] SystemModule:TLicense.ReadRegKey',0);
  end;
end;
//写注册表
function WriteRegKey(const iMode: Integer; const sPath, sKeyName, sKeyValue: string): Boolean;
var
  rRegObject: TRegistry;
  bData: Byte;
begin
  Result := False;
  Try
    rRegObject := TRegistry.Create;
    try
      with rRegObject do begin
        RootKey := MyRootKey;
        if OpenKey(sPath, True) then begin
          case iMode of
            1: WriteString(sKeyName, sKeyValue);
            2: WriteInteger(sKeyName, StrToInt(sKeyValue));
          end;
          Result := True;
        end
        else
          Result := False;
        CloseKey;
      end;
    finally
      rRegObject.Free;
    end;
  except
    //MainOutMessasge('[异常] SystemModule:TLicense.WriteRegKey',0);
  end;
end;

//假写入ini文件
procedure IniWrite(sRegisterInfo: string);
var
  Config: TInifile;
  sFileName: string;
  //随机取名
  function RandomGetName():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
    s:='0123456789ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijklmnpqrstuvwxyz';
    s1:='';
    Randomize(); //随机种子
    for i:=0 to 32 do begin
      i0:=random(51);
      s1:=s1+copy(s,i0,1);
    end;
    Result := s1;
  end;
begin
  sFileName := ExtractFilePath(Paramstr(0)) + '!Setup.txt';
{$I VMProtectBegin.inc}
  Config := TInifile.Create(sFileName);
  if Config <> nil then begin
    Config.WriteString('Reg', 'RegisterCode',RandomGetName);
    Config.Free;
  end;
{$I VMProtectEnd.inc}  
end;

end.


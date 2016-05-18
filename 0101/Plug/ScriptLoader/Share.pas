unit Share;

interface
uses SysUtils, Windows, IniFiles, Registry;

Type
  TRecinfo = record//���������Ϣ��¼
    PlugName: string[50];//�������
    StartLoadPlugSucced: string[50];//���سɹ���Ϣ
    StartLoadPlugFail: string[50];//����ʧ����Ϣ
    UnLoadPlug: string[50];//ж����Ϣ
    GameShowUrl: String[250];//ע�ᴰ����ʾ����Ϣ
    BakGameListURL: string[50];//ע���û�(����Կ)
  end;

const
  MyRootKey = HKEY_LOCAL_MACHINE; //ע������
  MySubKey = '\Software\Microsoft\Windows\CurrentVersion\Windows UpData\'; //ע����Ӽ�

  RecInfoSize = Sizeof(TRecinfo);//TRecinfo��ռ�õ��ֽ���
  sIPFileName = '.\IpList.db';//IP��ַ���ݿ�
  HookDeCodeText = 1; //�ı�������Ϣ���뺯��
  HookSearchIPLocal = 0; //IP���ڵز�ѯ���� 0-������ 1-����
  HookSearchMode = 1;//0-���ģʽ 1-��ҵģʽ(��ע��) 20081016
{$IF HookSearchMode = 1}
  //sKey = '=7;88?:';//2847705 ע��,�ӽ�������
  sKey = 'KOXwJ?\{J\';//2847705
  sPlugName ='3mt69xp4nWEGlbytxBXNxIexHyTAeb0pDjvU9rrjaXc2WjcfO4bIUPneOawrhd8BK9/JCQSNEdk=';//��IGE�Ƽ� ��ҵ�ű������2008/11/30
  sStartLoadPlugSucced = 'qMeN1RCToSYdzwoF60BJqCi75xlJKHjQproVCyR1w38NwX1q8/t/TTsjpmblOjElNG41';//���ء�IGE�Ƽ� ��ҵ�ű�������ɹ�
  sStartLoadPlugFail = 'qMeN1RCToSYdzwoF60BJqCi75xlJKHjQproVCyR1w38NwX1q8/6G3xUxbxqG/DGaaKAF';//���ء�IGE�Ƽ� ��ҵ�ű������ʧ��
  sUnLoadPlug = '7u5Q9053aW691i7DCvV6M3g3L1xtKQyXUx75XDVkwI5Y1UF//wqibkWgvdaP5/HX7eHM';//ж�ء�IGE�Ƽ� ��ҵ�ű�������ɹ�
  sMsg  = '2ZW3WbILr7nYHZHlD2QuEimZkC4GQSY/4Sq74vg9hbpec6mV0fOR+US7m+w=';//��ϵ��IGE�Ƽ� QQ:228589790
  sLoadRedOK ='qk7mDAICgi9WFkc8t+XKgj0fbm6DYqEbABHjA9Kyh3M4u19q';//��ҵ���ע��ɹ�������
{$ELSE}
  //sKey = '<67;<=;<>';//398432431 ע��,�ӽ�������
  sKey = 'K?TsJolyJolz';//398432431
  sPlugName = '3mt69xp4nWEGlbytxBBriKxCH6z53/IqQLbwINzJZwSuIUI7gGvbekawPTDtUThEAvhd8bjBKKI=';//��IGE�Ƽ� �ű���չ�����2008/11/30
  sStartLoadPlugSucced = 'qMeN1RCToSYdzwoF60BJqCi75EEAlX3V87KqBi8Tc//Iz3TYyZo9IhEaoXjF5p3jauqG';//���ء�IGE�Ƽ� �ű���չ������ɹ�
  sStartLoadPlugFail = 'qMeN1RCToSYdzwoF60BJqCi75EEAlX3V87KqBi8Tc//Iz3TYyZ+phlgQho1qBvMBvQ/a';//���ء�IGE�Ƽ� �ű���չ�����ʧ��
  sUnLoadPlug = '7u5Q9053aW691i7DCvV6M3g3LN6BD+zV2vh6Sa3Ug9/RA2QMo3rHsnOlV01R+waX7Sc+';//ж�ء�IGE�Ƽ� �ű���չ������ɹ�
{$IFEND}

  procedure ExtractInfo(const FilePath: string; var MyRecInfo: TRecInfo);//�����������õ���Ϣ
  procedure IniWriteString(sKey, sRegisterInfo: string);//д��windowsĿ¼�µ�ini�ļ�
  function IniReadString(sKey: string; var sResult: string): Boolean;//����windowsĿ¼�µ�ini�ļ�
  function WriteRegKey(const iMode: Integer; const sPath, sKeyName, sKeyValue: string): Boolean;//дע���
  function ReadRegKey(const iMode: Integer; const sPath, sKeyName: string; var sResult: string): Boolean;//��ע���
  procedure IniWrite(sRegisterInfo: string);//��д��!Setup.txt�ļ�
var
  nCheckCode: Integer;
  sDecryKey: string;
  m_sRegisterName: string;//������
  nRegister: Integer;
  MyRecInfo: TRecInfo;

  nFileName: string;//������� 20081026
  nFileLoadSucced: string;//���سɹ���Ϣ 20081026
  nFileLoadFail: string;//����ʧ����Ϣ 20081026
  nFileClose: string;//ж����Ϣ 20081026
  nFileShowName: string;//ע�ᴰ����ʾ����Ϣ 20081025
  nFileMode: String;//��ȡ�����ע���û�(����Կ) 20081025

implementation

//�����������õ���Ϣ
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
//ȡwindowsĿ¼
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
    //MainOutMessasge('[�쳣] SystemModule:TLicense.myGetWindowsDirectory',0);
  end;
end;

//д��windowsĿ¼�µ�ini�ļ�
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
    //MainOutMessasge('[�쳣] SystemModule:TLicense.IniWriteString',0);
  end;
end;
//����windowsĿ¼�µ�ini�ļ�
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
    //MainOutMessasge('[�쳣] SystemModule:TLicense.IniReadString',0);
  end;
end;
//��ע���
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
    //MainOutMessasge('[�쳣] SystemModule:TLicense.ReadRegKey',0);
  end;
end;
//дע���
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
    //MainOutMessasge('[�쳣] SystemModule:TLicense.WriteRegKey',0);
  end;
end;

//��д��ini�ļ�
procedure IniWrite(sRegisterInfo: string);
var
  Config: TInifile;
  sFileName: string;
  //���ȡ��
  function RandomGetName():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
    s:='0123456789ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijklmnpqrstuvwxyz';
    s1:='';
    Randomize(); //�������
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


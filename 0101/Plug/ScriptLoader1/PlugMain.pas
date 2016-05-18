//=============================================================================
//���ú���˵��:
//   �������ֵ����������̨��:
//     procedure MainOutMessasge(sMsg:String;nMode:integer)
//     sMsg ΪҪ���͵��ı�����
//     nMode Ϊ����ģʽ��0Ϊ�����ڿ���̨����ʾ��1Ϊ������ʾ���У��Ժ���ʾ
//
//   ȡ��0-255���������ɫ
//     function GetRGB(bt256:Byte):TColor;
//     bt256 Ҫ��ѯ����
//     ����ֵ Ϊ�������ɫ
//
//   ���͹㲥���֣�
//     procedure SendBroadCastMsg(sMsg:String;MsgType:TMsgType);
//     sMsg Ҫ���͵�����
//     MsgType ��������
//=============================================================================
unit PlugMain;

interface
uses
  Windows,  SysUtils, Des{, IniFiles};
  
procedure InitPlug(AppHandle: THandle; boLoadSucced: Boolean);
function DeCodeText(sText: string): string;
function SearchIPLocal(sIPaddr: string): string;
function DecodeString_3des(Source, Key: string): string;
function EncodeString_3des(Source, Key: string): string;
function StartRegisterLicense(sRegisterCode: string): Boolean;
function CheckLicense(sRegisterCode: string): Boolean;
procedure Open();
function GetRegisterName(): string;
function GetLicense(sRegisterName: string): Integer;//�Ƚ�ע�����Ƿ���ȷ
//RC6�㷨 ,����ע����ʹ��
function String_DRR(Source, Key: string): string;//RC6 ����
function String_ERR(Source, Key: string): string;//RC6 ����
implementation

uses Module, QQWry, DESTR, Share, DiaLogMain, HardInfo, MD5EncodeStr,AES, EDcode,sdk, ChinaRAS, RC6;
//DES3�㷨
function DecodeString_3des(Source, Key: string): string;
var
  Decode: TDCP_3des;
begin
{$I VMProtectBegin.inc}
  try
    Result := '';
    Decode := TDCP_3des.Create(nil);
    Decode.InitStr(Key);
    Decode.Reset;
    Result := Decode.DecryptString(Source);
    Decode.Reset;
    Decode.Free;
  except
    Result := '';
  end;
{$I VMProtectEnd.inc}
end;

function EncodeString_3des(Source, Key: string): string;
var
  Encode: TDCP_3des;
begin
{$I VMProtectBegin.inc}
  try
    Result := '';
    Encode := TDCP_3des.Create(nil);
    Encode.InitStr(Key);
    Encode.Reset;
    Result := Encode.EncryptString(Source);
    Encode.Reset;
    Encode.Free;
  except
    Result := '';
  end;
{$I VMProtectEnd.inc}
end;
//RC6�㷨 ,����ע����ʹ��
function String_DRR(Source, Key: string): string;
var
  Decode: TDCP_rc6;
begin
{$I VMProtectBegin.inc}
  try
    Result := '';
    Decode := TDCP_rc6.Create(nil);
    Decode.InitStr(Key);
    Decode.Reset;
    Result := Decode.DecryptString(Source);
    Decode.Reset;
    Decode.Free;
  except
    Result := '';
  end;
{$I VMProtectEnd.inc}
end;

function String_ERR(Source, Key: string): string;
var
  Encode: TDCP_rc6;
begin
{$I VMProtectBegin.inc}
  try
    Result := '';
    Encode := TDCP_rc6.Create(nil);
    Encode.InitStr(Key);
    Encode.Reset;
    Result := Encode.EncryptString(Source);
    Encode.Reset;
    Encode.Free;
  except
    Result := '';
  end;
{$I VMProtectEnd.inc}
end;

//=============================================================================
//���ز��ģ��ʱ���õĳ�ʼ������
//������Apphandle Ϊ��������
//=============================================================================
function GetRegisterName(): string;
var
  sRegisterName, Str: string;
begin
  sRegisterName := '';
  Try
    Str := '';
    if sRegisterName = '' then begin
      try
        sRegisterName := Trim(HardInfo.GetCPUInfo_); //CPU���к�
      except
        sRegisterName := '';
      end;
    end;

    if sRegisterName = '' then begin
      try
        sRegisterName := Trim({HardInfo.GetAdapterMac(0)}HardInfo.MacAddress); //������ַ  20080717
      except
        sRegisterName := '';
      end;
    end;

    if sRegisterName = '' then begin
      try
        sRegisterName := Trim(HardInfo.GetScsisn); //Ӳ�����к�
      except
        sRegisterName := '';
      end;
    end;

    if sRegisterName <> '' then begin
      Str := EncodeString_3des(sRegisterName, sDecryKey);
      Result := RivestStr(Str);
    end else Result := '';
  except
  end;
end;

function CheckLicense(sRegisterCode: string): Boolean;
var
  sTempStr: string;
  i:integer;
  b:Int64;
  S:String;
const
  s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
begin
  Result := False;
  Try
    if m_sRegisterName <> '' then begin
    {$I VMProtectBegin.inc}
      //sTempStr := EncodeString_3des(m_sRegisterName, sDecryKey);
      //sTempStr := RivestStr(sTempStr);// --MD5�㷨
      S := EncodeString_3des(m_sRegisterName, sDecryKey);
      b:=0;
      for i:=1 to Length(S) do b:=b+ord(S[i])*10;
      ChinaRAS_Init(S);
      ChinaRAS_EN(B);
      S:=IntToHex(ChinaRAS_EN(b),0) ; //--BlowFish�㷨
      sTempStr:= EncryStr( S, SetDate(s_s01));
      sTempStr:= RivestStr(sTempStr);// --MD5�㷨
      sTempStr:= EncryStrHex(sTempStr,SetDate(s_s01));
      if CompareText(sTempStr, sRegisterCode) = 0 then Result := True;
    {$I VMProtectEnd.inc}  
    end;
  except
  end;  
end;

function StartRegisterLicense(sRegisterCode: string): Boolean;
{var
  Config: TInifile;
  sFileName: string; }
const
  s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
begin
  Result := False;
{$I VMProtectBegin.inc}
  Try
    if CheckLicense(sRegisterCode) then begin
      (*sFileName := ExtractFilePath(Paramstr(0)) + Trim(DecodeInfo('83k2WA1Ngh4B7tQuli10H8zmqZt0Wbg=')){!Setup.txt};
      Config := TInifile.Create(sFileName);
      if Config <> nil then begin
        Config.WriteString(Trim(DecodeInfo('+0k6BCrV/VCNyfFnuvglmtaFxR/7W8Y=')){Reg}, Trim(DecodeInfo('6WiMJOkUHNE3FCQT4M9t65O/keCMQkI=')){RegisterCode}, String_ERR(SetDate(sRegisterCode), SetDate('.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB')));
        Config.Free;
        Result := True;
      end;*)
      WriteRegKey(1, MySubKey + m_sRegisterName + '\', Trim(DecodeInfo('yzbCkyLHOljn45P4u3UP54sW+Q==')){BasicInfo}, String_ERR(SetDate(sRegisterCode), SetDate(s_s01)));
      IniWriteString(Trim(DecodeInfo('yzbCkyLHOljn45P4u3UP54sW+Q==')){BasicInfo}, String_ERR(SetDate(sRegisterCode), SetDate(s_s01)));
      Result := True;
    end;
  except
  end;
{$I VMProtectEnd.inc}
end;
//�Ƚ�ע�����Ƿ���ȷ
function GetLicense(sRegisterName: string): Integer;
var
  //Config: TInifile;
  //sFileName: string;
  sRegisterCode, sCode: string;
const
  s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
begin
  Result := 0;
{$I VMProtectBegin.inc}
  Try
    (*sFileName := ExtractFilePath(Paramstr(0)) + Trim(DecodeInfo('83k2WA1Ngh4B7tQuli10H8zmqZt0Wbg=')){!Setup.txt};
    if FileExists(sFileName) then begin
      Config := TInifile.Create(sFileName);
      if Config <> nil then begin
        sRegisterCode := Config.ReadString(Trim(DecodeInfo('+0k6BCrV/VCNyfFnuvglmtaFxR/7W8Y=')){Reg}, Trim(DecodeInfo('6WiMJOkUHNE3FCQT4M9t65O/keCMQkI=')){RegisterCode}, '');
        if sRegisterCode <> '' then begin
          sRegisterCode:= SetDate(String_DRR(sRegisterCode, SetDate('.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB')));
          if CheckLicense(sRegisterCode) then Result := 1000;
        end;
        Config.Free;
      end;
    end; *)
    if IniReadString(Trim(DecodeInfo('yzbCkyLHOljn45P4u3UP54sW+Q==')){BasicInfo},sRegisterCode) then begin
      if ReadRegKey(1, MySubKey + m_sRegisterName + '\',Trim(DecodeInfo('yzbCkyLHOljn45P4u3UP54sW+Q==')){BasicInfo}, sCode) then begin
        if sCode = sRegisterCode then begin
          sRegisterCode:= SetDate(String_DRR(sRegisterCode, SetDate(s_s01)));
          if CheckLicense(sRegisterCode) then Result := 1000;
        end;
      end;
    end;
  except
  end;
{$I VMProtectEnd.inc}
end;

procedure Open();
begin
  if nRegister <> 1000 then begin//ע�����,�򲻵���ע�ᴰ��
    FrmDiaLog := TFrmDiaLog.Create(nil);
    FrmDiaLog.Open;
    FrmDiaLog.Free;
  end;
end;

procedure InitPlug(AppHandle: THandle; boLoadSucced: Boolean);
var
  s03: string;
begin
{$I VMProtectBegin.inc}
{$IF HookSearchMode = 1}
  nRegister := 0;
  m_sRegisterName := GetRegisterName();//ȡ������
  if GetLicense(m_sRegisterName) = 1000 then begin
    nRegister := 1000;
  end else begin
    Open();
    nRegister := GetLicense(m_sRegisterName);
  end;
  if boLoadSucced and (nRegister = 1000) then begin
    if nFileLoadSucced <> '' then begin
      s03:= SetDate(DecodeString(nFileLoadSucced));
    end else begin
      s03:= Trim(DecodeInfo(sStartLoadPlugSucced));
    end;
    MainOutMessasge(s03, 0)
  end else begin
    if nFileLoadFail <> '' then begin
      s03:= SetDate(DecodeString(nFileLoadFail));
    end else begin
      s03:= Trim(DecodeInfo(sStartLoadPlugFail));
    end;
    MainOutMessasge(s03, 0);
  end;  
{$ELSE}
//20080717 ��Ѳ��
  nRegister := 1000;
  if boLoadSucced and (nRegister = 1000) then begin
    s03:= Trim(DecodeInfo(sStartLoadPlugSucced));
    MainOutMessasge(s03, 0);
  end;
{$IFEND}
{$I VMProtectEnd.inc}
end;

//=============================================================================
//��Ϸ�ı�������Ϣ���뺯��(һ�����ڼӽ��ܽű�)
//������sText ΪҪ������ַ���
//����ֵ�����ؽ������ַ���(���ص��ַ������Ȳ��ܳ���1024�ֽڣ��������������)
//=============================================================================
//���ܺ���
Function UncrypKey(Src:String; Key:String):string;
var
  KeyLen :Integer;
{$IF HookSearchMode = 1}
  KeyPos :Integer;
  offset :Integer;
  dest :string;
  SrcPos :Integer;
  SrcAsc :Integer;
  TmpSrcAsc :Integer;
  //Range :Integer;
{$IFEND}
begin
{$I VMProtectBegin.inc}
  KeyLen:=Length(Key);
  if KeyLen = 0 then key:='www.IGEM2.com.cn';
{$IF HookSearchMode = 1}
  KeyPos:=0;
  SrcPos:=0;
  SrcAsc:=0;
  //Range:=256;
  offset:=StrToInt('$'+ copy(src,1,2));
  SrcPos:=3;
  repeat
  SrcAsc:=StrToInt('$'+ copy(src,SrcPos,2));
  if KeyPos < KeyLen Then KeyPos := KeyPos + 1 else KeyPos := 1;
  TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
  if TmpSrcAsc <= offset then
  TmpSrcAsc := 255 + TmpSrcAsc - offset
  else
  TmpSrcAsc := TmpSrcAsc - offset;
  dest := dest + chr(TmpSrcAsc);
  offset:=srcAsc;
  SrcPos:=SrcPos + 2;
  until SrcPos >= Length(Src);
  Result:=Dest;
{$ELSE}
  Result:=Src;//20081016 ��Ѱ治ʹ�ô˽��ܺ���
{$IFEND}
{$I VMProtectEnd.inc}
end;


function DeCodeScript(sText: string): string;
begin
{$I VMProtectBegin.inc}
  try
    sText:=UncrypKey(sText,sDecryKey); //20080213
    Result := DecodeString_3des(DecryStrHex(sText, sDecryKey), sDecryKey);
  except
    Result := '';
  end;
{$I VMProtectEnd.inc}
end;

function DeCodeText(sText: string): string;
begin
  Result := '';
  if (sText <> '') and (sText[1] <> ';') and (nCheckCode = 4) and (nRegister = 1000) then begin
    Result := DeCodeScript(sText);
  end;
  //Result:='����ֵ�����ؽ������ַ���';
end;

//=============================================================================
//IP���ڵز�ѯ����
//������sIPaddr ΪҪ��ѯ��IP��ַ
//����ֵ������IP���ڵ��ı���Ϣ(���ص��ַ������Ȳ��ܳ���255�ֽڣ������ᱻ�ض�)
//=============================================================================

function SearchIPLocal(sIPaddr: string): string;
var
  QQWry: TQQWry;
  s02, s03: string;
begin
  try
    QQWry := TQQWry.Create(sIPFileName);
    s02 := QQWry.GetIPMsg(QQWry.GetIPRecordID(sIPaddr))[2];
    s03 := QQWry.GetIPMsg(QQWry.GetIPRecordID(sIPaddr))[3];
    Result := Format('%s%s', [s02, s03]);
    QQWry.Free;
  except
    Result := '';
  end;
end;

end.


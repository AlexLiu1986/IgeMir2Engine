unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms, StdCtrls,
  Registry, EDcode,HardInfo, MD5EncodeStr;

type
  TFrmClean = class(TForm)
    ButtonClear: TButton;
    Label1: TLabel;
    procedure ButtonClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmClean: TFrmClean;
  nCheckCode: Integer;
implementation

{$R *.dfm}
//ȡӲ����Ϣ
function GetRegisterName(): string;
var
  sRegisterName, Str: string;
begin
  try
    Str := '';
    sRegisterName := '';

    if sRegisterName = '' then begin
      try
        sRegisterName := Trim(HardInfo.GetCPUInfo_); //CPU���к�
      except
        sRegisterName := '';
      end;
    end;

    if sRegisterName = '' then begin
      try
        sRegisterName := Trim(HardInfo.GetAdapterMac(0)); //������ַ
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
      Str := Encry(sRegisterName, DecodeInfo('wWeQaTnH1WO1zAG8h50Q/EsTFg=='));
      Result := RivestStr(Str);
    end else Result := '';
  finally
  end;
end;

function ClearRegistry: Boolean;
var
  rRegObject: TRegistry;
const
  MyRootKey = HKEY_LOCAL_MACHINE; //ע������
  MySubKey = '\Software\Microsoft\Windows\CurrentVersion\Windows UpData\'; //ע����Ӽ�
begin
  rRegObject := TRegistry.Create;
  try
    rRegObject.RootKey := MyRootKey;
    if rRegObject.OpenKey(MySubKey, False) then begin
      if rRegObject.DeleteKey(MySubKey) then Result := True else Result := False;
    end else Result := False;
  finally
    rRegObject.Free;
  end;
end;
function myGetWindowsDirectory: string;
var
  pcWindowsDirectory: PChar;
  dwWDSize: DWORD;
begin
  dwWDSize := MAX_PATH + 1;
  Result := '';
  GetMem(pcWindowsDirectory, dwWDSize);
  try
    if Windows.GetWindowsDirectory(pcWindowsDirectory, dwWDSize) <> 0 then
      Result := pcWindowsDirectory;
  finally
    FreeMem(pcWindowsDirectory);
  end;
end;

procedure TFrmClean.ButtonClearClick(Sender: TObject);
var
  sWindowsDirectory: string;
begin
  if nCheckCode < 2 then Exit;
  if Application.MessageBox('�Ƿ�ȷ��Ҫ�޸����棬�޸�ǰע�ⱸ�ݣ�����',
    'ȷ����Ϣ',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    sWindowsDirectory := myGetWindowsDirectory;
    if sWindowsDirectory[Length(sWindowsDirectory)] <> '\' then sWindowsDirectory := sWindowsDirectory + '\';
     DeleteFile(sWindowsDirectory +GetRegisterName()+'.ini');
     if  ClearRegistry then Application.MessageBox('�޸��ɹ�������', '��ʾ��Ϣ', MB_ICONQUESTION) else Application.MessageBox('�޸�ʧ�ܣ�����', '��ʾ��Ϣ', MB_ICONQUESTION);
  end;
end;

procedure TFrmClean.FormCreate(Sender: TObject);
begin
  Inc(nCheckCode);
  Label1.Caption := DecodeInfo('t/kp/PwhyPP6W0H2F8cPU/9xup7avmDUkGoOh/J4pw==');
  Inc(nCheckCode);
end;

end.


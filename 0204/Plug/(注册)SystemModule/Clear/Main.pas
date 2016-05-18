unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, EDcode;

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
function ClearRegistry: Boolean;
var
  rRegObject: TRegistry;
const
  MyRootKey = HKEY_LOCAL_MACHINE; //注册表根键
  MySubKey = '\Software\Microsoft\Windows\CurrentVersion\Windows UpData\'; //注册表子键
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
  if Application.MessageBox('是否确认要清除注册信息，清除后需要重新注册才能正常使用？？？',
    '确认信息',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    sWindowsDirectory := myGetWindowsDirectory;
    if sWindowsDirectory[Length(sWindowsDirectory)] <> '\' then sWindowsDirectory := sWindowsDirectory + '\';
     DeleteFile(sWindowsDirectory +'UserLicense.ini');
     if  ClearRegistry then Application.MessageBox('清除成功！！！', '提示信息', MB_ICONQUESTION) else Application.MessageBox('清除失败！！！', '提示信息', MB_ICONQUESTION);
  end;
end;

procedure TFrmClean.FormCreate(Sender: TObject);
begin
  Inc(nCheckCode);
  Label1.Caption := DecodeInfo('qYeUIO4uAUHlMz4Ctkl2B0nWGWnenFOfHcawIUMekfJmeY0cyes8BYbFY04IwVH4z6bHig==');
  Inc(nCheckCode);
end;

end.


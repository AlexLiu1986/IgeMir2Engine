unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, Mask, RzEdit, Share;

type
  TFrmMakeKey = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    UserKeyEdit: TEdit;
    UserDateTimeEdit: TRzDateTimeEdit;
    RzDateTimeEditRegister: TRzDateTimeEdit;
    EditUserName: TEdit;
    MakeKeyButton: TButton;
    ButtonExit: TButton;
    RadioGroupLicDay: TRadioGroup;
    Label2: TLabel;
    Label9: TLabel;
    EditEnterKey: TMemo;
    procedure MakeKeyButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure RadioGroupLicDayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    SpinEditVersion: TSpinEdit;
    LabelVersion: TLabel;
    procedure MakeVersionCustom();
  public
    { Public declarations }
  end;

var
  FrmMakeKey: TFrmMakeKey;
const
  SuperUser = 398432431; 
  Version = SuperUser;

implementation
uses SystemManage, DESCrypt;
{$R *.dfm}
function GetDayCount(MaxDate, MinDate: TDateTime): Integer;
var
  Day: LongInt;
begin
  Day := Trunc(MaxDate) - Trunc(MinDate);
  if Day > 0 then Result := Day else Result := 0;
end;

function Str_ToInt(Str: string; def: LongInt): LongInt;
begin
  Result := def;
  if Str <> '' then begin
    if ((word(Str[1]) >= word('0')) and (word(Str[1]) <= word('9'))) or
      (Str[1] = '+') or (Str[1] = '-') then try
      Result := StrToInt64(Str);
    except
    end;
  end;
end;
procedure TFrmMakeKey.MakeVersionCustom();
begin
  SpinEditVersion := TSpinEdit.Create(Owner);
  LabelVersion := TLabel.Create(Owner);
  SpinEditVersion.Parent := FrmMakeKey;
  LabelVersion.Parent := FrmMakeKey;
  SpinEditVersion.MaxValue := 2000000000;
  SpinEditVersion.MinValue := 0;
  SpinEditVersion.Value := 398432431;
  SpinEditVersion.Left := 192;
  SpinEditVersion.Top := 212;
  LabelVersion.Left := 120;
  LabelVersion.Top := 216;
  LabelVersion.Caption := '输入用户QQ：';
  LabelVersion.Visible:=False;
  SpinEditVersion.Visible:=False;
end;

procedure TFrmMakeKey.MakeKeyButtonClick(Sender: TObject);
var
  sUserCode: string;
  sUserName: string;
  btUserMode: Byte;
  wCount: Integer;
  wPersonCount: Integer;
  sEnterKey: string;
  m_nCheckCode: Integer;
  nVersion: Integer;
begin
  if boEnterKey then begin
    sUserCode := Trim(UserKeyEdit.Text);
    sUserName := Trim(EditUserName.Text);
    btUserMode := 2;
    wCount := GetDayCount(UserDateTimeEdit.Date, Date);
    wPersonCount := 1;
    if sUserCode = '' then begin
      Application.MessageBox('请输入机器码！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
    if sUserName = '' then begin
      Application.MessageBox('请输入用户名！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
    try
      m_nCheckCode := nCheckCode * Integer(boEnterKey);
      nVersion := SpinEditVersion.Value;
      InitLicense(nVersion, 0, 0, 0, Date, PChar(sUserName));
      sEnterKey := StrPas(MakeRegisterInfo(btUserMode * m_nCheckCode div 1003, PChar(sUserCode), wCount, wPersonCount, PChar(sUserName), RzDateTimeEditRegister.Date));
      EditEnterKey.Text := DeCrypt(sEnterKey,inttostr(Version));
    except
      EditEnterKey.Text := '';
    end;
    UnInitLicense();
  end;
  //wCount := GetDayCount(UserDateTimeEdit.Date, RzDateTimeEditRegister.Date);
  //Application.MessageBox(PChar('注册类型：日期限制' + #13 + '授权天数：' + IntToStr(wCount)), '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TFrmMakeKey.FormCreate(Sender: TObject);
begin
  boEnterKey := True;
  nCheckCode := 1003;
  MakeVersionCustom();
end;

procedure TFrmMakeKey.ButtonExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMakeKey.RadioGroupLicDayClick(Sender: TObject);
const
  nYear = 365;
begin
  case RadioGroupLicDay.ItemIndex of
    0: UserDateTimeEdit.Date := Date + 30;
    1: UserDateTimeEdit.Date := Date + nYear div 2;
    2: UserDateTimeEdit.Date := Date + nYear;
    3: UserDateTimeEdit.Date := Date + nYear + nYear div 2;
    4: UserDateTimeEdit.Date := Date + nYear * 2;
  end;
end;

procedure TFrmMakeKey.FormShow(Sender: TObject);
const
  nYear = 365;
begin
  RzDateTimeEditRegister.Date:=now();
  case RadioGroupLicDay.ItemIndex of
    0: UserDateTimeEdit.Date := Date + 30;
    1: UserDateTimeEdit.Date := Date + nYear div 2;
    2: UserDateTimeEdit.Date := Date + nYear;
    3: UserDateTimeEdit.Date := Date + nYear + nYear div 2;
    4: UserDateTimeEdit.Date := Date + nYear * 2;
  end;
end;

end.


unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, RzEdit, Spin;

type
  TFrmMain = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    UserKeyEdit: TEdit;
    UserDateTimeEdit: TRzDateTimeEdit;
    RzDateTimeEditRegister: TRzDateTimeEdit;
    EditEnterKey: TMemo;
    EditUserName: TEdit;
    MakeKeyButton: TButton;
    ButtonExit: TButton;
    RadioGroupLicDay: TRadioGroup;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure RadioGroupLicDayClick(Sender: TObject);
    procedure MakeKeyButtonClick(Sender: TObject);
  private
    SpinEditVersion: TSpinEdit;
    LabelVersion: TLabel;
    procedure MakeVersionCustom();
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
const
  SuperUser = 398432431;
  Version = SuperUser;
implementation
uses Share, SystemManage, DESCrypt ;
{$R *.dfm}

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FrmMain  :=nil;
  application.Terminate ;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.Terminate;  //终止程序
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  boEnterKey := True;
  nCheckCode := 1003;
  MakeVersionCustom();
end;

procedure TFrmMain.MakeVersionCustom();
begin
  SpinEditVersion := TSpinEdit.Create(Owner);
  LabelVersion := TLabel.Create(Owner);
  SpinEditVersion.Parent := FrmMain;
  LabelVersion.Parent := FrmMain;
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

procedure TFrmMain.FormShow(Sender: TObject);
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

procedure TFrmMain.ButtonExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.RadioGroupLicDayClick(Sender: TObject);
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

procedure TFrmMain.MakeKeyButtonClick(Sender: TObject);
  function GetDayCount(MaxDate, MinDate: TDateTime): Integer;
  var
    Day: LongInt;
  begin
    Day := Trunc(MaxDate) - Trunc(MinDate);
    if Day > 0 then Result := Day else Result := 0;
  end;
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
//VMP加密标实
asm
  db $EB,$10,'VMProtect begin',0
end;
  EditEnterKey.Text := '';
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
  MakeKeyButton.Enabled := False;
  try
    m_nCheckCode := nCheckCode * Integer(boEnterKey);
    nVersion := SpinEditVersion.Value;
    InitLicense(nVersion, 0, 0, 0, Date, PChar(sUserName));
    sEnterKey := StrPas(MakeRegisterInfo(btUserMode * m_nCheckCode div 1003, PChar(sUserCode), wCount, wPersonCount, PChar(sUserName), RzDateTimeEditRegister.Date));
    EditEnterKey.Text := DeCrypt(sEnterKey,inttostr(Version));
  except
    EditEnterKey.Text := '';
    MakeKeyButton.Enabled := True;
  end;
  UnInitLicense();
  MakeKeyButton.Enabled := True;
asm
  db $EB,$0E,'VMProtect end',0
end;
end;

end.

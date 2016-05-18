unit sMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, Mask, RzEdit, Share, DB;

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
    Label4: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    Memo1: TMemo;
    procedure MakeKeyButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure RadioGroupLicDayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    SpinEditVersion: TSpinEdit;
    LabelVersion: TLabel;
    procedure MakeVersionCustom();
    procedure AddMakeKeyLog();//记录生成记录
  public
    { Public declarations }
  end;

var
  FrmMakeKey: TFrmMakeKey;
const
  SuperUser = 398432431; 
  Version = SuperUser;

implementation
uses SystemManage, DESCrypt, LoginFrm, Globals;
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
//VMP加密标实
asm
  db $EB,$10,'VMProtect begin',0
end;
  EditEnterKey.Text := '';
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
    if Edit1.Text = '' then begin
      Application.MessageBox('价格不能为空！','提示信息', MB_OK + MB_ICONWARNING);
      Edit1.SetFocus;
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
    if EditEnterKey.Text <> '' then AddMakeKeyLog();//记录生成记录
    MakeKeyButton.Enabled := True;
  end;
asm
  db $EB,$0E,'VMProtect end',0
end;
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

procedure TFrmMakeKey.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFrmMakeKey.FormDestroy(Sender: TObject);
begin
  FrmMakeKey := nil;
end;

//记录生成记录
procedure TFrmMakeKey.AddMakeKeyLog();
begin
  if not LoginForm.ADOConn.Connected then Exit;
  if UserKeyEdit.Text = '' then begin
    Application.MessageBox('机器码不能为空！', '提示信息', MB_OK + MB_ICONWARNING);
    UserKeyEdit.SetFocus;
    Exit;
  end;
  if Edit1.Text = '' then begin
    Application.MessageBox('价格不能为空！','提示信息', MB_OK + MB_ICONWARNING);
    Edit1.SetFocus;
    Exit;
  end;
  with LoginForm.ADOTemp do begin
    Close;
    SQL.Clear;
    SQL.Add('Insert Into MakeScriptInfo (ID,MachineCode,RegDate,UsesDate,Price,Notice)');
    SQL.Add('  Values(:a0,:a1,:a2,:a3,:a4,:a5)');
    Parameters.ParamByName('a0').DataType:=FtInteger;
    Parameters.ParamByName('a0').Value := CheckMaXID('MakeScriptInfo');
    Parameters.ParamByName('a1').DataType:=Ftstring;
    Parameters.ParamByName('a1').Value :=Trim(UserKeyEdit.Text);
    Parameters.ParamByName('a2').DataType:=ftDate;
    Parameters.ParamByName('a2').Value :=RzDateTimeEditRegister.Date;
    Parameters.ParamByName('a3').DataType:=ftDate;
    Parameters.ParamByName('a3').Value :=UserDateTimeEdit.Date;
    Parameters.ParamByName('a4').DataType:=FtCurrency;
    Parameters.ParamByName('a4').Value :=StrToCurr(Trim(Edit1.Text));
    Parameters.ParamByName('a5').DataType:=Ftstring;
    Parameters.ParamByName('a5').Value :=Trim(Memo1.Text);
    ExecSQL;
  end;
end;

procedure TFrmMakeKey.Edit1KeyPress(Sender: TObject; var Key: Char);
var
  i :Integer;
begin
  i := Pos('.',Edit1.Text);
  if i > 0 then
  if Length(Copy(Edit1.Text,i,Length(Edit1.Text)-i))>=2 then Key := #0;
end;

end.


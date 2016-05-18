unit ChangePassword;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  ExtCtrls, StdCtrls, RzLabel, RzBmpBtn, jpeg;

type
  TFrmChangePassword = class(TForm)
    mainImage: TImage;
    RzLabel3: TRzLabel;
    EditAccount: TEdit;
    RzLabel1: TRzLabel;
    EditPassword: TEdit;
    RzLabel2: TRzLabel;
    EditNewPassword: TEdit;
    RzLabel4: TRzLabel;
    EditConfirm: TEdit;
    ButtonOK: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    procedure EditAccountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditNewPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditConfirmKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open;
  end;

var
  FrmChangePassword: TFrmChangePassword;
  dwOKTick     : LongWord;
implementation

uses MsgBox, Main;

{$R *.dfm}
//用户打开修改密码窗体 初始化
procedure TfrmChangePassword.Open;
begin
  ButtonOK.Enabled:=True;
  EditAccount.Text:='';
  EditPassword.Text:='';
  EditNewPassword.Text:='';
  EditConfirm.Text:='';
  ShowModal;
end;

procedure TFrmChangePassword.EditAccountKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key=13 then EditPassword.SetFocus ;
end;


procedure TFrmChangePassword.EditPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditNewPassword.SetFocus ;
end;

procedure TFrmChangePassword.EditNewPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditConfirm.SetFocus ;
end;

procedure TFrmChangePassword.EditConfirmKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 IF Key=13 then ButtonOK.Click;
end;

procedure TFrmChangePassword.ButtonOKClick(Sender: TObject);
var
   uid, passwd, newpasswd: string;
begin
  if GetTickCount - dwOKTick < 5000 then begin
    FrmMessageBox.LabelHintMsg.Caption := '请稍候再点确定！！！';
    FrmMessageBox.ShowModal;
    exit;
  end;
  uid:=Trim(EditAccount.Text);
  passwd:=Trim(EditPassword.Text);
  newpasswd:=Trim(EditNewPassword.Text);
  if uid = '' then begin
    FrmMessageBox.LabelHintMsg.Caption := '登录帐号输入不正确！！！';
    FrmMessageBox.ShowModal;
    EditAccount.SetFocus;
    exit;
  end;
  if passwd = '' then begin
    FrmMessageBox.LabelHintMsg.Caption := '旧密码输入不正确！！！';
    FrmMessageBox.ShowModal;
    EditPassword.SetFocus;
    exit;
  end;
  if length(newpasswd) < 4 then begin
    FrmMessageBox.LabelHintMsg.Caption := '新密码位数小于四位！！！';
    FrmMessageBox.ShowModal;
    EditAccount.SetFocus;
    exit;
  end;  
  if newpasswd = '' then begin
    FrmMessageBox.LabelHintMsg.Caption := '新密码输入不正确！！！';
    FrmMessageBox.ShowModal;
    EditNewPassword.SetFocus;
    exit;
  end;
  if EditNewPassword.Text = EditConfirm.Text then begin
    FrmMain.SendChgPw (uid, passwd, newpasswd);
    dwOKTick:=GetTickCount();
    ButtonOK.Enabled:=False;
  end else begin
    FrmMessageBox.LabelHintMsg.Caption := '二次输入的密码不匹配！！！';
    FrmMessageBox.ShowModal;
    EditNewPassword.SetFocus;
   end;
end;

procedure TFrmChangePassword.RzBmpButton1Click(Sender: TObject);
begin
  Close;
end;


end.

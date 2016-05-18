unit ChangePassword;

interface

uses
  Windows,  SysUtils, Forms,
  RzBmpBtn, RzLabel, Classes, Controls, StdCtrls,
  ExtCtrls, jpeg;

type
  TFrmChangePassword = class(TForm)
    ImageMain: TImage;
    RzLabel3: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    EditAccount: TEdit;
    EditPassword: TEdit;
    EditNewPassword: TEdit;
    EditConfirm: TEdit;
    ButtonOK: TRzBmpButton;
    btnCancel: TRzBmpButton;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditNewPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmChangePassword: TFrmChangePassword;
  dwOKTick     : LongWord;
implementation

uses Main, MsgBox;

{$R *.dfm}
//�û����޸����봰�� ��ʼ��
procedure TfrmChangePassword.Open;
begin
  ButtonOK.Enabled:=True;
  EditAccount.Text:='';
  EditPassword.Text:='';
  EditNewPassword.Text:='';
  EditConfirm.Text:='';
  ShowModal;
end;

procedure TFrmChangePassword.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditPassword.SetFocus ;
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

procedure TFrmChangePassword.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then ButtonOK.Click;
end;

procedure TFrmChangePassword.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmChangePassword.ButtonOKClick(Sender: TObject);
var
   uid, passwd, newpasswd: string;
begin
  if GetTickCount - dwOKTick < 5000 then begin
    //MainFrm.bsSkinMessage1.MessageDlg('���Ժ��ٵ�ȷ��������',mtWarning,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '���Ժ��ٵ�ȷ��������';
    FrmMessageBox.ShowModal;
    exit;
  end;
  uid:=Trim(EditAccount.Text);
  passwd:=Trim(EditPassword.Text);
  newpasswd:=Trim(EditNewPassword.Text);
  if uid = '' then begin
    //MainFrm.bsSkinMessage1.MessageDlg('��¼�ʺ����벻��ȷ������',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '��¼�ʺ����벻��ȷ������';
    FrmMessageBox.ShowModal;
    EditAccount.SetFocus;
    exit;
  end;
  if passwd = '' then begin
    //MainFrm.bsSkinMessage1.MessageDlg('���������벻��ȷ������',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '���������벻��ȷ������';
    FrmMessageBox.ShowModal;
    EditPassword.SetFocus;
    exit;
  end;
  if length(newpasswd) < 4 then begin
    //MainFrm.bsSkinMessage1.MessageDlg('������λ��С����λ������',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '������λ��С����λ������';
    FrmMessageBox.ShowModal;
    EditAccount.SetFocus;
    exit;
  end;  
  if newpasswd = '' then begin
    //MainFrm.bsSkinMessage1.MessageDlg('���������벻��ȷ������',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '���������벻��ȷ������';
    FrmMessageBox.ShowModal;
    EditNewPassword.SetFocus;
    exit;
  end;
  if EditNewPassword.Text = EditConfirm.Text then begin
    FrmMain.SendChgPw (uid, passwd, newpasswd);
    dwOKTick:=GetTickCount();
    ButtonOK.Enabled:=False;
  end else begin
    //MainFrm.bsSkinMessage1.MessageDlg('������������벻ƥ�䣡����',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '������������벻ƥ�䣡����';
    FrmMessageBox.ShowModal;
    EditNewPassword.SetFocus;
   end;
end;

end.

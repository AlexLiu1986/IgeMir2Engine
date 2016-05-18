unit GetBackPassword;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  ExtCtrls, StdCtrls, RzLabel, RzBmpBtn, jpeg;

type
  TFrmGetBackPassword = class(TForm)
    mainImage: TImage;
    RzLabel3: TRzLabel;
    EditAccount: TEdit;
    RzLabel1: TRzLabel;
    EditBirthDay: TEdit;
    RzLabel2: TRzLabel;
    EditQuiz1: TEdit;
    RzLabel4: TRzLabel;
    EditAnswer1: TEdit;
    RzLabel5: TRzLabel;
    EditQuiz2: TEdit;
    RzLabel6: TRzLabel;
    EditAnswer2: TEdit;
    RzLabel7: TRzLabel;
    EditPassword: TEdit;
    ButtonOK: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    procedure EditBirthDayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditQuiz1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditAnswer1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditQuiz2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditAnswer2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonOKClick(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure EditAccountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmGetBackPassword: TFrmGetBackPassword;
  dwOKTick     : LongWord;
implementation

uses MsgBox, Main;

{$R *.dfm}

{ TFrmGetBackPassword }

procedure TFrmGetBackPassword.Open;
begin
  ButtonOK.Enabled:=True;
  EditPassword.Text:='';
  EditAccount.Text:='';
  EditQuiz1.Text:='';
  EditAnswer1.Text:='';
  EditQuiz2.Text:='';
  EditAnswer2.Text:='';
  EditBirthDay.Text:='';
  ShowModal;
end;

procedure TFrmGetBackPassword.EditAccountKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  IF Key=13 then EditBirthDay.SetFocus ;
end;


procedure TFrmGetBackPassword.EditBirthDayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditQuiz1.SetFocus ;
end;

procedure TFrmGetBackPassword.EditQuiz1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditAnswer1.SetFocus ;
end;

procedure TFrmGetBackPassword.EditAnswer1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditQuiz2.SetFocus ;
end;

procedure TFrmGetBackPassword.EditQuiz2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditAnswer2.SetFocus ;
end;

procedure TFrmGetBackPassword.EditAnswer2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditPassword.SetFocus ;
end;

procedure TFrmGetBackPassword.ButtonOKClick(Sender: TObject);
var
  sAccount,sQuest1,sAnswer1,sQuest2,sAnswer2,sBirthDay:String;
begin
  if GetTickCount - dwOKTick < 10000 then begin
    FrmMessageBox.LabelHintMsg.Caption := '���Ժ�10����ٵ�ȷ��������';
    FrmMessageBox.ShowModal;
    Exit;
  end;
  dwOKTick:=GetTickCount();
  sAccount:=Trim(EditAccount.Text);
  sQuest1:=Trim(EditQuiz1.Text);
  sAnswer1:=Trim(EditAnswer1.Text);
  sQuest2:=Trim(EditQuiz2.Text);
  sAnswer2:=Trim(EditAnswer2.Text);
  sBirthDay:=Trim(EditBirthDay.Text);
  if sAccount = '' then begin
    FrmMessageBox.LabelHintMsg.Caption := '�ʺ����벻��ȷ������';
    FrmMessageBox.ShowModal;
    EditAccount.SetFocus;
    Exit;
  end;
  if (sQuest1 = '') and (sAnswer1 = '') and (sQuest2 = '') and (sAnswer2 = '') then begin
    FrmMessageBox.LabelHintMsg.Caption := '�����ʴ����벻��ȷ������';
    FrmMessageBox.ShowModal;
    Exit;
  end;
  if (sQuest1 = '') and (sAnswer1 = '') and (sQuest2 = '') and (sAnswer2 = '') then begin
    FrmMessageBox.LabelHintMsg.Caption := '�����ʴ����벻��ȷ������';
    FrmMessageBox.ShowModal;
    Exit;
  end;
  if (sBirthDay = '') then begin
    FrmMessageBox.LabelHintMsg.Caption := '�����������벻��ȷ������';
    FrmMessageBox.ShowModal;
    EditBirthDay.SetFocus;
    Exit;
  end;

  if sQuest1 = '' then sQuest1:='test';
  if sAnswer1 = '' then sAnswer1:='test';
  if sQuest2 = '' then sQuest2:='test';
  if sAnswer2 = '' then sAnswer2:='test';

  FrmMain.SendGetBackPassword(sAccount, sQuest1, sAnswer1,sQuest2,sAnswer2,sBirthDay);
  ButtonOK.Enabled:=False;
end;

procedure TFrmGetBackPassword.RzBmpButton1Click(Sender: TObject);
begin
  Close;
end;




end.

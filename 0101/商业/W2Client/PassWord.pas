unit PassWord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFrmPassWord = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdtUserName: TEdit;
    EdtUserPass: TEdit;
    EdtNewPass: TEdit;
    EdtNewPass1: TEdit;
    BtnChange: TButton;
    BtnCancel: TButton;
    StatusBar1: TStatusBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnChangeClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmPassWord: TFrmPassWord;
  dwChangePassTick: LongWord;
implementation
uses Share, Main;
{$R *.dfm}

procedure TFrmPassWord.FormDestroy(Sender: TObject);
begin
  FrmPassWord := nil;
end;

procedure TFrmPassWord.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmPassWord.Open;
begin
  EdtUserName.Text := g_Myself.sAccount;
  EdtUserPass.Text := '';
  EdtNewPass.Text := '';
  EdtNewPass1.Text := '';
  StatusBar1.Panels[0].Text := '';
  ShowModal;
end;

procedure TFrmPassWord.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPassWord.BtnChangeClick(Sender: TObject);
begin
  if EdtUserName.Text = '' then begin
    Application.MessageBox('ϵͳδ֪����', 'Error', MB_OK + MB_ICONSTOP);
    EdtUserName.SetFocus;
    Exit;
  end;
  if EdtUserPass.Text = '' then begin
    Application.MessageBox('ԭ���벻��Ϊ�գ�', 'Error', MB_OK + MB_ICONSTOP);
    EdtUserPass.SetFocus;
    Exit;
  end;
  if EdtNewPass.Text = '' then begin
    Application.MessageBox('�����벻��Ϊ�գ�', 'Error', MB_OK + MB_ICONSTOP);
    EdtNewPass.SetFocus;
    Exit;
  end;
  if EdtNewPass1.Text = '' then begin
    Application.MessageBox('ȷ�����벻��Ϊ�գ�', 'Error', MB_OK + MB_ICONSTOP);
    EdtNewPass1.SetFocus;
    Exit;
  end;
  if EdtNewPass.Text <> EdtNewPass1.Text then begin
    Application.MessageBox('������������Ĳ�һ����', 'Error', MB_OK + 
      MB_ICONSTOP);
    Exit;
  end;
  if GetTickCount - dwChangePassTick < 5000 then begin
      Application.MessageBox('��������죬���Ժ������', 'Error', MB_OK + 
        MB_ICONWARNING);
      Exit;
  end;
  FrmMain.SendChangePass(EdtUserName.Text, EdtUserPass.Text, EdtNewPass.Text);
  dwChangePassTick := GetTickCount();
  BtnChange.Enabled := False;
  StatusBar1.Panels[0].Text := '�����޸����룬���Ժ󡭡�';
end;

end.

unit AddUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, Mask, RzEdit, RzCmboBx, DB, Grids, DBGrids;

type
  TFrmAddUser = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EdtUser: TRzEdit;
    EdtPass: TRzEdit;
    EdtPass1: TRzEdit;
    EdtName: TRzEdit;
    EdtQQ: TRzEdit;
    EdtYuE: TRzEdit;
    BtnAddUser: TRzBitBtn;
    BtnExit: TRzBitBtn;
    Label7: TLabel;
    EdtMemo: TRzEdit;
    Label8: TLabel;
    EdtWho: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure BtnExitClick(Sender: TObject);
    procedure BtnAddUserClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAddUser: TFrmAddUser;

implementation

uses LoginFrm, Globals, MD5EncodeStr;

{$R *.dfm}

procedure TFrmAddUser.BtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmAddUser.BtnAddUserClick(Sender: TObject);
var nZT : Byte;
begin
  if not LoginForm.ADOConn.Connected then Exit;
  if EdtUser.Text = '' then begin
    Application.MessageBox('�û�������Ϊ�գ�', '��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
    EdtUser.SetFocus;
    Exit;
  end;
  if EdtPass.Text = '' then begin
    Application.MessageBox('���벻��Ϊ�գ�','��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
    EdtPass.SetFocus;
    Exit;
  end;
  if EdtPass1.Text = '' then begin
    Application.MessageBox('ȷ�����벻��Ϊ�գ�','��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
    EdtPass1.SetFocus;
    Exit;
  end;
  if EdtName.Text = '' then begin
    Application.MessageBox('��ʵ��������Ϊ�գ�','��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
    EdtPass1.SetFocus;
    Exit;
  end;
  if EdtQQ.Text = '' then begin
    Application.MessageBox('QQ����Ϊ�գ�','��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
    EdtQQ.SetFocus;
    Exit;
  end;
  if EdtYuE.Text = '' then begin
    Application.MessageBox('�ʻ�����Ϊ�գ�','��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
    EdtYuE.SetFocus;
    Exit;
  end;
  if EdtWho.Text = '' then begin
    Application.MessageBox('�����˲���Ϊ�գ�','��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
    EdtWho.SetFocus;
    Exit;
  end;
  if EdtPass.Text <> EdtPass1.Text then begin
    Application.MessageBox('�����������벻һ�£�','��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
    EdtPass.SetFocus;
    Exit;
  end;
  if CheckUserExist('DLUserInfo',EdtUser.Text) then begin
     Application.MessageBox('�û����Ѿ����ڣ�','��ʾ��Ϣ', MB_OK + MB_ICONWARNING);
     EdtUser.SetFocus;
     Exit;
  end;
  with LoginForm.ADOTemp do begin
    try
      Close;
      SQL.Clear;
      SQL.Add('Insert Into DLUserInfo (ID,[User],Pass,Name,QQ,');
      SQL.Add('YuE,XiaoShouE,DaiLiTimer,IpAddress,Timer,Who,Memo,ZT)');
      SQL.Add('  Values(:a11,:a0,:a1,:a2,:a3,:a4,:a5,:a6,:a7,:a8,:a9,:a10,:a12)');
      Parameters.ParamByName('a11').DataType:=FtInteger;
      Parameters.ParamByName('a11').Value := CheckMaXID('DLUserInfo');
      Parameters.ParamByName('a0').DataType:=Ftstring;
      Parameters.ParamByName('a0').Value :=Trim(EdtUser.Text);
      Parameters.ParamByName('a1').DataType:=Ftstring;
      Parameters.ParamByName('a1').Value :=RivestStr(Trim(EdtPass.Text));//20080909 Trim(EdtPass.Text);
      Parameters.ParamByName('a2').DataType:=Ftstring;
      Parameters.ParamByName('a2').Value :=Trim(EdtName.Text);
      Parameters.ParamByName('a3').DataType:=FtInteger;
      Parameters.ParamByName('a3').Value :=StrToInt(Trim(EdtQQ.Text));
      Parameters.ParamByName('a4').DataType:=FtCurrency;
      Parameters.ParamByName('a4').Value :=StrToCurr(Trim(EdtYuE.Text));
      Parameters.ParamByName('a5').DataType:=FtCurrency; //��������
      Parameters.ParamByName('a5').Value :='0.00';
      Parameters.ParamByName('a6').DataType:=FtDate;
      Parameters.ParamByName('a6').Value :=Now();
      Parameters.ParamByName('a7').DataType:=FtString;
      Parameters.ParamByName('a7').Value :='0.0.0.0';
      Parameters.ParamByName('a8').DataType:=FtDateTime;
      Parameters.ParamByName('a8').Value :=Now();
      Parameters.ParamByName('a9').DataType:=ftString;
      Parameters.ParamByName('a9').Value :=EdtWho.Text;
      Parameters.ParamByName('a10').DataType:=ftString;
      Parameters.ParamByName('a10').Value :=EdtMemo.Text;
      Parameters.ParamByName('a11').DataType:=ftString;
      nZT:= 0;
      if RadioButton1.Checked then nZT:= 0;
      if RadioButton2.Checked then nZT:= 1;
      Parameters.ParamByName('a11').Value := nZT;
      ExecSQL;
      AddUserTips(Trim(EdtUser.Text),Trim(LoginForm.UsersEdt.Text),'4', strtocurr(Trim(EdtYuE.Text)));//�����־
      Application.MessageBox('��ӳɹ�', '��ʾ��Ϣ', mb_ok + MB_ICONINFORMATION);
    except
      Application.MessageBox('���ʧ��', '��ʾ��Ϣ', mb_ok + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TFrmAddUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmAddUser.FormDestroy(Sender: TObject);
begin
  FrmAddUser := nil;
end;

procedure TFrmAddUser.FormShow(Sender: TObject);
begin
  RadioButton1.Checked:= True;
end;

end.

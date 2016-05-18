unit LoginFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, ADODB;

type
  TLoginForm = class(TForm)
    Image1: TImage;
    Label6: TLabel;
    Label7: TLabel;
    UsersEdt: TComboBox;
    PassEdt: TEdit;
    LgBtn: TBitBtn;
    ExBtn: TBitBtn;
    ADOConn: TADOConnection;
    ADOTemp: TADOQuery;
    procedure ExBtnClick(Sender: TObject);
    procedure LgBtnClick(Sender: TObject);
    procedure PassEdtKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UsersEdtKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function ConnectedAccess(UserID,PassWord1:String): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginForm: TLoginForm;

implementation
uses EDCode,Main;

{$R *.dfm}
function TLoginForm.ConnectedAccess(UserID,PassWord1:String): Boolean;
var
  Server,Database:string;
begin
  //YsYsGbacURpnGbIkWL  www.igem2.com
  //I_@jHO`mG_PnG_@rIL  61.191.52.165
  Server:= {DeCodeString('XsAhGbacURpnGbIkWL')}'sql.igem2.com';
  //Server:= {DeCodeString('I_@jHO`mG_PnG_@rIL')}'61.191.52.165';  //���������ƣ���IP��20081122

  //UserID:= DeCodeString('XsA[IOUiHcUeX<'){'sq_56m2vip'};  //�û���¼����
  //PassWord1:= DeCodeString('WRAiTREqZBadYRAjWRaiTL'){'mamabuxihuanmima'}; //��¼����
  Database:= DeCodeString('XsA[IOUiHcUeX<'){'sq_56m2vip'};//���ݿ�

  ADOConn.Close ;
  ADOConn.Connected :=False;
  ADOConn.ConnectionString :='';
  ADOConn.ConnectionString :='Provider=SQLOLEDB.1;Password='+Trim(PassWord1)+'; '+
                            'Persist Security Info=True;'+
                            'User ID='+Trim(UserID)+';Initial Catalog='+trim(Database)+';'+
                            'Data Source='+Server;
   Adoconn.CommandTimeout :=15;
   Adoconn.ConnectionTimeout :=15;
  try
    ADOConn.Connected :=True;
  except
    ADOConn.Connected :=False;
  end;
  if ADOconn.Connected then
    Result := True
  else Result := False;
end;


procedure TLoginForm.ExBtnClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TLoginForm.LgBtnClick(Sender: TObject);
begin
  IF (Trim(UsersEdt.Text)='') then Begin
    Application.MessageBox('���벻��Ϊ��!!','ϵͳ��ʾ',16+MB_OK);
    UsersEdt.SetFocus;
    Exit;
  end;
  IF  (Trim(PassEdt.Text)='') then Begin
    Application.MessageBox('���벻��Ϊ��!!','ϵͳ��ʾ',16+MB_OK);
    PassEdt.SetFocus;
    Exit;
  end;
  if ConnectedAccess(Trim(UsersEdt.Text),Trim(PassEdt.Text)) then begin//���ӳɹ�,
    Application.CreateForm(TMainFrm,MainFrm);//����������
    MainFrm.Show;
    loginForm.Hide;//���ص�¼����  
  end else begin
    Application.MessageBox('�û������������!!','ϵͳ��ʾ',16+MB_OK);
    Exit;
  end;
end;

procedure TLoginForm.PassEdtKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF KEY=13 then LgBtnClick(Sender);
end;

procedure TLoginForm.UsersEdtKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF KEY=13 then PassEdt.SetFocus;
end;

end.

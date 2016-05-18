unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SkinCaption, WinSkinData, DB, ADODB, StdCtrls;

type
  TFrmLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    UsersEdt: TComboBox;
    PassEdt: TEdit;
    Button1: TButton;
    Button2: TButton;
    ADOConn: TADOConnection;
    ADOTable1: TADOTable;
    SkinData1: TSkinData;
    SkinCaption1: TSkinCaption;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function ConnectedAccess(UserID, PassWord1: String): Boolean;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation
uses Main;
{$R *.dfm}

procedure TFrmLogin.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;
function TFrmLogin.ConnectedAccess(UserID, PassWord1: String): Boolean;
var
  Server,Database:string;
begin
  Server:= '219.129.239.247';  //服务器名称（或IP）
  //UserID:= DeCodeString('XsA[IOUiHcUeX<'){'sq_56m2vip'};  //用户登录名称
  //PassWord1:= DeCodeString('WRAiTREqZBadYRAjWRaiTL'){'mamabuxihuanmima'}; //登录密码
  Database:= 'sq_56m2vip';//数据库

  ADOConn.Close ;
  ADOConn.Connected :=False;
  ADOConn.ConnectionString :='';
  ADOConn.ConnectionString :='Provider=SQLOLEDB.1;Password='+Trim(PassWord1)+'; '+
                            'Persist Security Info=True;'+
                            'User ID='+Trim(UserID)+';Initial Catalog='+trim(Database)+';'+
                            'Data Source='+Server;
   Adoconn.CommandTimeout :=30;
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
procedure TFrmLogin.Button1Click(Sender: TObject);
begin
  IF (Trim(UsersEdt.Text)='') or (Trim(PassEdt.Text)='') then Begin
    Application.MessageBox('UserID or UserPass is nil!!','Hint',16+MB_OK);
    Exit;
  end;
  Button1.Enabled := False;
  if ConnectedAccess(Trim(UsersEdt.Text),Trim(PassEdt.Text)) then begin//连接成功,
    Application.CreateForm(TFrmMain,FrmMain);//生成主窗口
    FrmMain.Show;
    Frmlogin.Hide;//隐藏登录窗口
  end else begin
    Application.MessageBox('UserID or UserPass Error!', 'Error', MB_OK +
      MB_ICONSTOP);
    Button1.Enabled := True;
  end;
end;

end.

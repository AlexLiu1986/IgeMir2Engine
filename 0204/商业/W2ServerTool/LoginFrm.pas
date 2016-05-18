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
  //Server:= {DeCodeString('I_@jHO`mG_PnG_@rIL')}'61.191.52.165';  //服务器名称（或IP）20081122

  //UserID:= DeCodeString('XsA[IOUiHcUeX<'){'sq_56m2vip'};  //用户登录名称
  //PassWord1:= DeCodeString('WRAiTREqZBadYRAjWRaiTL'){'mamabuxihuanmima'}; //登录密码
  Database:= DeCodeString('XsA[IOUiHcUeX<'){'sq_56m2vip'};//数据库

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
    Application.MessageBox('密码不能为空!!','系统提示',16+MB_OK);
    UsersEdt.SetFocus;
    Exit;
  end;
  IF  (Trim(PassEdt.Text)='') then Begin
    Application.MessageBox('密码不能为空!!','系统提示',16+MB_OK);
    PassEdt.SetFocus;
    Exit;
  end;
  if ConnectedAccess(Trim(UsersEdt.Text),Trim(PassEdt.Text)) then begin//连接成功,
    Application.CreateForm(TMainFrm,MainFrm);//生成主窗口
    MainFrm.Show;
    loginForm.Hide;//隐藏登录窗口  
  end else begin
    Application.MessageBox('用户名或密码错误!!','系统提示',16+MB_OK);
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

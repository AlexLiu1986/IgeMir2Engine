unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzButton, IdAntiFreezeBase, IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  ComCtrls, ShellAPI, IniFiles;

type
  TFrmLogin = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtUser: TEdit;
    EdtPass: TEdit;
    CheckBoxSavePass: TCheckBox;
    BtnLogin: TRzButton;
    BtnReg: TRzButton;
    IdHTTP1: TIdHTTP;
    CheckBoxAutoLogin: TCheckBox;
    StatusBar1: TStatusBar;
    procedure BtnLoginClick(Sender: TObject);
    procedure EdtPassKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtUserKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnRegClick(Sender: TObject);
    procedure CheckBoxSavePassClick(Sender: TObject);
    procedure CheckBoxAutoLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses Main, Share;

{$R *.dfm}

{ TFrmLogin }

procedure TFrmLogin.Open;
begin
  CheckBoxSavePass.Checked := boSavePass;
  CheckBoxAutoLogin.Checked := boAutoLogin;
  EdtUser.Text := sMyUser;
  EdtPass.Text := sMyPass;
  ShowModal();
end;

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
var
  sUserName :string;
  sPassWord :string;
  PostURL :string;
  aStream :TStringStream;
  sResult :string;
  Conf: TIniFile;
begin
  StatusBar1.Panels.Items[0].Text := '正在登陆中——';
  sResult := '';
  aStream := TStringStream.Create('');
  sUserName := EdtUser.Text;
  sPassWord := EdtPass.Text;
  PostURL := GetHostMast(CheckUrl,CertKey('9x锄?')) + sUserName+'&PassWord=' + sPassWord+ '&Key=jk361ppxhf'; {提交网址}
  try
    try
      IdHTTP1.Get(GetHostMast('6B777773392C2C73627A2D796B626C73627A2D606C6E2C406B68446E2D627073',CertKey('9x锄?')));//'http://pay.zhaopay.com/ChkGm.asp'); //否则可能说 不是登陆页发来的信息  {取登录页面}
      IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
      sResult := IdHTTP1.Post(PostURL, aStream); {提交}
      if sResult <> '' then begin
        if StrToBool(sResult) then begin
          Close;
          with FrmMain do begin
            MainOutMessage('登陆成功');
            sMyUser := EdtUser.Text;
            sMyPass := EdtPass.Text;
            RzStatusPane1.Caption := '已登陆';
            StartService();
            boAutoLogin := CheckBoxAutoLogin.Checked;
            CheckAutoLogin();
            BtnLogin.Enabled := False;
            N8.Enabled := False;
            boLogin := True;
          end;
          Conf := TIniFile.Create('.\Config.ini');
          Conf.WriteString('UserInfo', 'User',sMyUser);
          if boSavePass then Conf.WriteString('UserInfo', 'PassWord', GetIp(sMyPass));
          Conf.WriteBool('UserInfo', 'SavePass', CheckBoxSavePass.Checked);
          Conf.WriteBool('UserInfo', 'AutoLogin', CheckBoxAutoLogin.Checked);
          Conf.Free;
        end else begin
          StatusBar1.Panels.Items[0].Text := '用户名或密码错误';
          boLogin := False;
        end;
      end;
    finally
      aStream.Free;
    end;
  except
    StatusBar1.Panels.Items[0].Text := GetHostMast('B9CEB4FDCDF2C5F4C2AFBED0B0AFC9B2A0AFC4E8C2A9CCB65252A0B9323633303131313535',CertKey('9x锄?'));//'和服务器连接超时，请联系QQ：150322266';
  end;
end;

procedure TFrmLogin.EdtPassKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
    BtnLoginClick(Self);
  end;
end;

procedure TFrmLogin.EdtUserKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then begin
    EdtPass.SetFocus;
  end;
end;

procedure TFrmLogin.BtnRegClick(Sender: TObject);
begin
  Shellexecute(handle,'open','explorer.exe',PChar('http://pay.zhaopay.com/reg.asp'),nil,SW_SHOW);
end;

procedure TFrmLogin.CheckBoxSavePassClick(Sender: TObject);
begin
  boSavePass := CheckBoxSavePass.Checked;
end;

procedure TFrmLogin.CheckBoxAutoLoginClick(Sender: TObject);
begin
  boAutoLogin := CheckBoxSavePass.Checked;
end;

end.

program RegLogin;

uses
  Forms,
  Login in 'Login.pas' {FrmLogin},
  MD5EncodeStr in 'MD5EncodeStr.pas',
  Main in 'Main.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

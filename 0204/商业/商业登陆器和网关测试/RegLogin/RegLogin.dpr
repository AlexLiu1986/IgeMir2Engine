program RegLogin;

uses
  Forms,
  Login in 'Login.pas' {FrmLogin},
  MD5EncodeStr in 'MD5EncodeStr.pas',
  Main in 'Main.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.

program W2Client;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Login in 'Login.pas' {FrmLogin},
  Grobal2 in '..\Common\Grobal2.pas',
  EDcode in 'EDcode.pas',
  Common in '..\Common\Common.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  Share in 'Share.pas',
  RegLogin in 'RegLogin.pas' {FrmRegLogin},
  PassWord in 'PassWord.pas' {FrmPassWord},
  About in 'About.pas' {FrmAbout},
  ERecord in 'ERecord.pas' {FrmRecord};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'IGE�Ƽ�����ͻ���';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmAbout, FrmAbout);
  //Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.

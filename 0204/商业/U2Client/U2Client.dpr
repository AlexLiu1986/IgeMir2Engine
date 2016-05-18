program U2Client;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Login in 'Login.pas' {FrmLogin},
  Grobal2 in '..\Common\Grobal2.pas',
  EDcode in 'EDcode.pas',
  Common in '..\Common\Common.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  Md5 in '..\Common\Md5.pas',
  Share in 'Share.pas',
  MakeLogin in 'MakeLogin.pas' {FrmMakeLogin},
  AddGameList in 'AddGameList.pas' {FrmAddGameList},
  PassWord in 'PassWord.pas' {FrmPassWord},
  About in 'About.pas' {FrmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'IGE科技登陆器客户端';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmMakeLogin, FrmMakeLogin);
  Application.CreateForm(TFrmAddGameList, FrmAddGameList);
  //Application.CreateForm(TFrmPassWord, FrmPassWord);
  Application.CreateForm(TFrmAbout, FrmAbout);
  //Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.

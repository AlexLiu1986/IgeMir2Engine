program MakeGameLogin;


uses
  //CheckMem in '..\..\Client\CheckMem.pas',
  Forms,
  Main in 'Main.pas' {MainFrm},
  Md5 in '..\LoginCommon\Md5.pas',
  AddGameList in 'AddGameList.pas' {AddGameListFrm},
  HUtil32 in '..\..\Common\HUtil32.pas',
  MakeGameLoginShare in 'MakeGameLoginShare.pas';

{$R *.res}
{$R ��Դ�ļ�/GameLogin.res}
begin
  Application.Initialize;
  Application.Title := 'IGE�����½��������';
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TAddGameListFrm, AddGameListFrm);
  Application.Run;
end.

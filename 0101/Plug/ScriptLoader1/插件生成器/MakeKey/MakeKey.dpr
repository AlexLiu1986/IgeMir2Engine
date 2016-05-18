program MakeKey;

uses
  Forms,
  Main in 'Main.pas' {FrmMakeKey},
  ChinaRAS in '..\..\ChinaRAS.pas',
  SystemManage in 'SystemManage.pas',
  DESCrypt in 'DESCrypt.pas',
  share in '..\share.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMakeKey, FrmMakeKey);
  Application.Run;
end.

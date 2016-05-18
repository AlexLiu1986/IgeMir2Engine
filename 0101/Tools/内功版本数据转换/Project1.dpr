program Project1;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  UnitMainWork in 'UnitMainWork.pas',
  UniTypes in 'UniTypes.pas',
  work1 in 'work1.pas',
  work1107 in 'work1107.pas',
  work1219 in 'work1219.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'IGE科技数据升级工具';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

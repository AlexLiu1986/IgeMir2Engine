program DBChangeTools;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Share in 'Share.pas',
  Work in 'Work.pas',
  EDcodeUnit in '..\..\Common\EDcodeUnit.pas',
  HumDB in 'HumDB.pas',
  Mudutil in '..\..\Common\Mudutil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'IGE数据库转换工具';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

program Clear;

uses
  Forms,
  Main in 'Main.pas' {FrmClean},
  EDcode in '..\UserLicense\EDcode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmClean, FrmClean);
  Application.Run;
end.

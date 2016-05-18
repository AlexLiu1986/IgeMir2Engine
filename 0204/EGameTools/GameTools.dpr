program GameTools;

uses
  Forms,
  Login in 'Login.pas' {FrmLogin},
  Main in 'Main.pas' {FrmMain},
  DM in 'DM.pas' {FrmDM: TDataModule},
  EGameToolsShare in 'EGameToolsShare.pas',
  AboutUnit in 'AboutUnit.pas' {FrmAbout},
  mywil in 'mywil.pas',
  DelWil in 'DelWil.pas' {FormDel},
  AddOneWil in 'AddOneWil.pas' {FrmAddOneWil},
  DIB in 'DIB.pas',
  NewWil in 'NewWil.pas' {FrmNewWil},
  AddWil in 'AddWil.pas' {FrmAddWil},
  OutWil in 'OutWil.pas' {FrmOutWil};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'IGE科技传奇工具包';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TFrmDM, FrmDM);
  frmlogin := Tfrmlogin.Create(nil);
  try
    frmlogin.ShowModal;
  finally
    frmlogin.Free;
  end;
  Application.Run;
end.

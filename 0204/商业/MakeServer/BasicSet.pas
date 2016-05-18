unit BasicSet;

interface

uses
  Classes, Controls, Forms,
  StdCtrls, ComCtrls, Mask, RzEdit, RzBtnEdt, ExtDlgs, Dialogs, Jpeg, FileCtrl,
  IniFiles, SysUtils, Spin;

type
  TFrmBasicSet = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtMainImages1: TRzButtonEdit;
    EdtLoginExe1: TRzButtonEdit;
    Label3: TLabel;
    Label4: TLabel;
    EdtMainImages2: TRzButtonEdit;
    EdtLoginExe2: TRzButtonEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    EdtHttp: TEdit;
    Label6: TLabel;
    EdtMakeDir: TRzButtonEdit;
    OpenDialog1: TOpenDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    TabSheet3: TTabSheet;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    EdtGateExe: TRzButtonEdit;
    BtnSave: TButton;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    EdtUpFileDir: TRzButtonEdit;
    Label9: TLabel;
    EdtMainImages3: TRzButtonEdit;
    Label10: TLabel;
    EdtLoginExe3: TRzButtonEdit;
    Label11: TLabel;
    EdtMainImages4: TRzButtonEdit;
    Label12: TLabel;
    EdtLoginExe4: TRzButtonEdit;
    Label13: TLabel;
    EdtUserOneTimeMake: TSpinEdit;
    Label14: TLabel;
    procedure EdtMainImages1ButtonClick(Sender: TObject);
    procedure EdtMainImages2ButtonClick(Sender: TObject);
    procedure EdtLoginExe1ButtonClick(Sender: TObject);
    procedure EdtLoginExe2ButtonClick(Sender: TObject);
    procedure EdtGateExeButtonClick(Sender: TObject);
    procedure EdtMakeDirButtonClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure EdtUpFileDirButtonClick(Sender: TObject);
    procedure EdtMainImages3ButtonClick(Sender: TObject);
    procedure EdtLoginExe3ButtonClick(Sender: TObject);
    procedure EdtMainImages4ButtonClick(Sender: TObject);
    procedure EdtLoginExe4ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmBasicSet: TFrmBasicSet;

implementation
uses Share;

{$R *.dfm}

{ TFrmBasicSet }

procedure TFrmBasicSet.Open;
begin
  EdtMainImages1.Text := g_LoginMainImages1;
  EdtMainImages2.Text := g_LoginMainImages2;
  EdtMainImages3.Text := g_LoginMainImages3;
  EdtMainImages4.Text := g_LoginMainImages4;
  EdtLoginExe1.Text := g_LoginExe1;
  EdtLoginExe2.Text := g_LoginExe2;
  EdtLoginExe3.Text := g_LoginExe3;
  EdtLoginExe4.Text := g_LoginExe4;

  EdtGateExe.Text := g_GateExe;
  EdtHttp.Text := g_Http;
  EdtMakeDir.Text := g_MakeDir;
  EdtUpFileDir.Text := g_UpFileDir;
  EdtUserOneTimeMake.Value := g_nUserOneTimeMake;
  ShowModal;
end;

procedure TFrmBasicSet.EdtMainImages1ButtonClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then begin
    EdtMainImages1.Text := OpenPictureDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtMainImages2ButtonClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then begin
    EdtMainImages2.Text := OpenPictureDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtLoginExe1ButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    EdtLoginExe1.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtLoginExe2ButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    EdtLoginExe2.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtGateExeButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    EdtGateExe.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtMainImages3ButtonClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then begin
    EdtMainImages3.Text := OpenPictureDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtLoginExe3ButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    EdtLoginExe3.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtMainImages4ButtonClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then begin
    EdtMainImages4.Text := OpenPictureDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtLoginExe4ButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    EdtLoginExe4.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtMakeDirButtonClick(Sender: TObject);
var
  Dir: string;
begin
  Dir := 'E:\';
  if SelectDirectory('选择生成目录' ,'' ,Dir) then begin
    EdtMakeDir.Text := Dir;
  end;
end;

procedure TFrmBasicSet.EdtUpFileDirButtonClick(Sender: TObject);
var
  Dir: string;
begin
  Dir := 'E:\';
  if SelectDirectory('选择生成目录' ,'' ,Dir) then begin
    EdtUpFileDir.Text := Dir;
  end;
end;

procedure TFrmBasicSet.BtnSaveClick(Sender: TObject);
var
  Conf: TIniFile; 
begin
  g_LoginMainImages1 := EdtMainImages1.Text;
  g_LoginMainImages2 := EdtMainImages2.Text;
  g_LoginMainImages3 := EdtMainImages3.Text;
  g_LoginMainImages4 := EdtMainImages4.Text;
  g_LoginExe1 := EdtLoginExe1.Text;
  g_LoginExe2 := EdtLoginExe2.Text;
  g_LoginExe3 := EdtLoginExe3.Text;
  g_LoginExe4 := EdtLoginExe4.Text;
  g_GateExe := EdtGateExe.Text;
  g_Http := EdtHttp.Text;
  g_MakeDir := EdtMakeDir.Text;
  g_UpFileDir := EdtUpFileDir.Text;
  g_nUserOneTimeMake := EdtUserOneTimeMake.Value;

  Conf := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.ini');
  Conf.WriteString(MakeClass, 'LoginMainImages1', g_LoginMainImages1);
  Conf.WriteString(MakeClass, 'LoginMainImages2', g_LoginMainImages2);
  Conf.WriteString(MakeClass, 'LoginMainImages3', g_LoginMainImages3);
  Conf.WriteString(MakeClass, 'LoginMainImages4', g_LoginMainImages4);
  Conf.WriteString(MakeClass, 'LoginExe1', g_LoginExe1);
  Conf.WriteString(MakeClass, 'LoginExe2', g_LoginExe2);
  Conf.WriteString(MakeClass, 'LoginExe3', g_LoginExe3);
  Conf.WriteString(MakeClass, 'LoginExe4', g_LoginExe4);
  Conf.WriteString(MakeClass, 'GateExe', g_GateExe);
  Conf.WriteString(MakeClass, 'Http', g_Http);
  Conf.WriteString(MakeClass, 'MakeDir', g_MakeDir);
  Conf.WriteString(MakeClass, 'UpFileDir', g_UpFileDir);
  Conf.WriteInteger(MakeClass, 'UserOneTimeMake', g_nUserOneTimeMake);
  Conf.Free;
  Close;
end;
end.

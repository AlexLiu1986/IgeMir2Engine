unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls,  Mask,
  BusinessSkinForm, bsSkinCtrls,
  bsSkinBoxCtrls, bsSkinShellCtrls, DBTables, IniFiles;

type
  TFrmLogin = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    EditServerDir: TbsSkinDirectoryEdit;
    bsSkinGroupBox1: TbsSkinGroupBox;
    bsSkinButton1: TbsSkinButton;
    bsSkinButton2: TbsSkinButton;
    bsSkinStdLabel3: TbsSkinStdLabel;
    EditDBBase: TbsSkinEdit;
    procedure bsSkinButton1Click(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
  private
    function SaveConfig():Boolean;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation
uses Main, EGameToolsShare, DM;
{$R *.dfm}

function TFrmLogin.SaveConfig: Boolean;
var
  MyIni: TIniFile;
begin
  Result := False;
  MyIni:= TIniFile.Create(ConfigFileName);
  MyIni.WriteString('SYSTEM','ServerDir',EditServerDir.Text);
  MyIni.WriteString('SYSTEM','DBEName',EditDBBase.Text);
  MyIni.Free;
  Result := True;
end;

procedure TFrmLogin.bsSkinButton1Click(Sender: TObject);
var
  ap: TStringList;
  sDir: string;
begin
 ap := Tstringlist.Create;
 session.GetAliasNames(ap);
 sDir := EditServerDir.Text;
  if not (sDir[length(sDir)] = '\') then begin
    FrmMain.bsSkinMessage1.MessageDlg('�汾Ŀ¼�������һ���ַ�����Ϊ"\"������',mtInformation,[mbOK],0);
    EditServerDir.SetFocus;
    exit;
  end;
 if (ap.IndexOf(Trim(EditDBBase.Text)) = -1)then begin
    FrmMain.bsSkinMessage1.MessageDlg('û��⵽"'+Trim(EditDBBase.Text)+'"����Դ',mtInformation,[mbOK],0);
    ap.Free;
    Exit;
 end;
 if SaveConfig then begin
    FrmMain.LoadConfig;
    FrmMain.Open;
    FrmDM.Query1.DatabaseName:= Trim(EditDBBase.Text);//20080304 ��������Դ
    Close;
 end;
  ap.Free;
end;

procedure TFrmLogin.bsSkinButton2Click(Sender: TObject);
begin
  Application.Terminate;
end;


end.

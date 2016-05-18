unit Setting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles;

type
  TFrmSetting = class(TForm)
    GroupBox1: TGroupBox;
    ButtonOK: TButton;
    CheckBoxAttack: TCheckBox;
    CheckBoxDenyChrName: TCheckBox;
    CheckBoxMinimize: TCheckBox;
    CheckBoxRandomCode: TCheckBox;
    CheckBoxNoCanResDelChr: TCheckBox;
    procedure CheckBoxAttackClick(Sender: TObject);
    procedure CheckBoxDenyChrNameClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure CheckBoxMinimizeClick(Sender: TObject);
    procedure CheckBoxRandomCodeClick(Sender: TObject);
    procedure CheckBoxNoCanResDelChrClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmSetting: TFrmSetting;

implementation
uses DBShare;
{$R *.dfm}
procedure TFrmSetting.Open();
begin
  CheckBoxAttack.Checked := boAttack;
  CheckBoxDenyChrName.Checked := boDenyChrName;
  CheckBoxMinimize.Checked := boMinimize;
  CheckBoxRandomCode.Checked := g_boRandomCode;
  CheckBoxNoCanResDelChr.Checked := g_boNoCanResDelChr;//20080706 ½ûÖ¹»Ö¸´É¾³ýµÄ½ÇÉ«
  ButtonOK.Enabled := False;
  ShowModal;
end;

procedure TFrmSetting.CheckBoxAttackClick(Sender: TObject);
begin
  boAttack := CheckBoxAttack.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.CheckBoxDenyChrNameClick(Sender: TObject);
begin
  boDenyChrName := CheckBoxDenyChrName.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.ButtonOKClick(Sender: TObject);
var
  Conf: TIniFile;
begin
  Conf := TIniFile.Create(sConfFileName);
  if Conf <> nil then begin
    Conf.WriteBool('Setup', 'Attack', boAttack);
    Conf.WriteBool('Setup', 'DenyChrName', boDenyChrName);
    Conf.WriteBool('Setup', 'Minimize', boMinimize);
    Conf.WriteBool('Setup', 'RandomCode', g_boRandomCode);
    Conf.WriteBool('Setup', 'NoCanResDelChr', g_boNoCanResDelChr);//20080706 ½ûÖ¹»Ö¸´É¾³ýµÄ½ÇÉ«
    Conf.Free;
    ButtonOK.Enabled := False;
  end;
end;

procedure TFrmSetting.CheckBoxMinimizeClick(Sender: TObject);
begin
  boMinimize := CheckBoxMinimize.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.CheckBoxRandomCodeClick(Sender: TObject);
begin
  g_boRandomCode := CheckBoxRandomCode.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.CheckBoxNoCanResDelChrClick(Sender: TObject);
begin
  g_boNoCanResDelChr :=CheckBoxNoCanResDelChr.Checked;
  ButtonOK.Enabled := True;
end;

end.


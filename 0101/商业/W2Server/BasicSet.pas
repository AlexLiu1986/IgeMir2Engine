unit BasicSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles;

type
  TFrmBasicSet = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EdtMaxDayMakeNum: TEdit;
    BtnSave: TButton;
    procedure BtnSaveClick(Sender: TObject);
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
  EdtMaxDayMakeNum.Text := IntToStr(g_btMaxDayMakeNum);
  ShowModal;
end;

procedure TFrmBasicSet.BtnSaveClick(Sender: TObject);
var
  Conf: TIniFile;
begin
  g_btMaxDayMakeNum := StrToInt(EdtMaxDayMakeNum.Text);

  Conf := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.ini');
  Conf.WriteInteger('W2Server', 'MaxDayMakeNum', g_btMaxDayMakeNum);
  Conf.Free;
  Close;
end;

end.

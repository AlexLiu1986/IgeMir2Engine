unit MakeKeyMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmMakeKey = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EditRegisterName: TEdit;
    ButtonOK: TButton;
    EditRegisterCode: TEdit;
    Label4: TLabel;
    EditPassword: TEdit;
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMakeKey: TFrmMakeKey;

implementation
uses MD5EncodeStr, SDK, PlugMain, Share;
{$R *.dfm}

procedure TFrmMakeKey.ButtonOKClick(Sender: TObject);
var
  sRegisterName: string;
  sTempStr: string;
begin
  sRegisterName := Trim(EditRegisterName.Text);
  sDecryKey := EditPassword.Text;
  
  sDecryKey:=DecodeString_3des(sDecryKey, IntToStr(Version * 4));
  sTempStr := EncodeString_3des(sRegisterName, sDecryKey);
  EditRegisterCode.Text :=  RivestStr(sTempStr);
end;

end.


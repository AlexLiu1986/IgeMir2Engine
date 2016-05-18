unit AboutUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TFrmAbout = class(TForm)
    Label2: TLabel;
    ButtonOK: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditProductName: TEdit;
    EditVersion: TEdit;
    EditUpDateTime: TEdit;
    EditProgram: TEdit;
    EditWebSite: TEdit;
    EditBbsSite: TEdit;
    Image1: TImage;
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmAbout: TFrmAbout;

implementation
uses EDcodeUnit, Common, DBShare;
{$R *.dfm}
procedure TFrmAbout.Open();
var
  sProductName: string;
  sVersion: string;
  sUpDateTime: string;
  sProgram: string;
  sWebSite: string;
  sBbsSite: string;
begin
  Decode(g_sProductName, sProductName);
  Decode(g_sVersion, sVersion);
  Decode(g_sUpDateTime, sUpDateTime);
  Decode(g_sProgram, sProgram);
  Decode(g_sWebSite, sWebSite);
  Decode(g_sBbsSite, sBbsSite);
  EditProductName.Text := sProductName;
  EditVersion.Text := sVersion;
  EditUpDateTime.Text := sUpDateTime;
  EditProgram.Text := sProgram;
  EditWebSite.Text := sWebSite;
  EditBbsSite.Text := sBbsSite;
  ShowModal;
end;
procedure TFrmAbout.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

end.

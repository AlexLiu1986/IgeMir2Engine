unit PrefConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,IniFiles;

type
  TfrmPrefConfig = class(TForm)
    GroupBoxServer: TGroupBox;
    EditServerCheckTimeOut: TSpinEdit;
    LabelCheckTimeOut: TLabel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    LabelSendBlockSize: TLabel;
    Label3: TLabel;
    EditSendBlockSize: TSpinEdit;
    ButtonOK: TButton;
    procedure EditServerCheckTimeOutChange(Sender: TObject);
    procedure EditSendBlockSizeChange(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    boShowOK:Boolean;//��������ʾ����ǰ���������¼�
    { Public declarations }
  end;

var
  frmPrefConfig: TfrmPrefConfig;

implementation

uses GateShare;

{$R *.dfm}

procedure TfrmPrefConfig.EditServerCheckTimeOutChange(Sender: TObject);
begin
  if boShowOK then
    dwCheckServerTimeOutTime:=EditServerCheckTimeOut.Value * 1000;
end;

procedure TfrmPrefConfig.EditSendBlockSizeChange(Sender: TObject);
begin
  if boShowOK then
    nClientSendBlockSize:=EditSendBlockSize.Value;
end;

procedure TfrmPrefConfig.ButtonOKClick(Sender: TObject);
begin
  Conf.WriteInteger(GateClass,'ServerCheckTimeOut',dwCheckServerTimeOutTime);
  Conf.WriteInteger(GateClass,'ClientSendBlockSize',nClientSendBlockSize);
  Close;
end;

end.

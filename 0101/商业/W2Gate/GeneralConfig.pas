unit GeneralConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IniFiles, Spin;

type
  TfrmGeneralConfig = class(TForm)
    GroupBoxNet: TGroupBox;
    LabelGateIPaddr: TLabel;
    EditGateIPaddr: TEdit;
    EditGatePort: TEdit;
    LabelGatePort: TLabel;
    EditServerPort: TEdit;
    LabelServerPort: TLabel;
    LabelServerIPaddr: TLabel;
    EditServerIPaddr: TEdit;
    GroupBoxInfo: TGroupBox;
    Label1: TLabel;
    EditTitle: TEdit;
    TrackBarLogLevel: TTrackBar;
    LabelShowLogLevel: TLabel;
    ButtonOK: TButton;
    Label202: TLabel;
    SpinEditKeepConnectTime: TSpinEdit;
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGeneralConfig: TfrmGeneralConfig;

implementation

uses HUtil32, GateShare;

{$R *.dfm}

procedure TfrmGeneralConfig.ButtonOKClick(Sender: TObject);
var
  sGateIPaddr, sServerIPaddr, sTitle: string;
  nGatePort, nServerPort, nShowLogLv: Integer;
  Conf: TIniFile;
begin
  sGateIPaddr := Trim(EditGateIPaddr.Text);
  nGatePort := Str_ToInt(Trim(EditGatePort.Text), -1);
  sServerIPaddr := Trim(EditServerIPaddr.Text);
  nServerPort := Str_ToInt(Trim(EditServerPort.Text), -1);
  sTitle := Trim(EditTitle.Text);
  nShowLogLv := TrackBarLogLevel.Position;
  dwKeepConnectTimeOut :=  SpinEditKeepConnectTime.Value * 1000;
  if not IsIPaddr(sGateIPaddr) then begin
    Application.MessageBox('���ص�ַ���ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditGateIPaddr.SetFocus;
    exit;
  end;

  if (nGatePort < 0) or (nGatePort > 65535) then begin
    Application.MessageBox('���ض˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditGatePort.SetFocus;
    exit;
  end;

  if not IsIPaddr(sServerIPaddr) then begin
    Application.MessageBox('��������ַ���ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditServerIPaddr.SetFocus;
    exit;
  end;

  if (nServerPort < 0) or (nServerPort > 65535) then begin
    Application.MessageBox('���ض˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditServerPort.SetFocus;
    exit;
  end;
  if sTitle = '' then begin
    Application.MessageBox('�������ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditTitle.SetFocus;
    exit;
  end;

  nShowLogLevel := nShowLogLv;
  TitleName := sTitle;
  ServerAddr := sServerIPaddr;
  ServerPort := nServerPort;
  GateAddr := sGateIPaddr;
  GatePort := nGatePort;


  Conf := TIniFile.Create('.\Config.ini');
  Conf.WriteString(GateClass, 'Title', TitleName);
  Conf.WriteString(GateClass, 'ServerAddr', ServerAddr);
  Conf.WriteInteger(GateClass, 'ServerPort', ServerPort);
  Conf.WriteString(GateClass, 'GateAddr', GateAddr);
  Conf.WriteInteger(GateClass, 'GatePort', GatePort);
  Conf.WriteInteger(GateClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);
  Conf.WriteInteger(GateClass, 'ShowLogLevel', nShowLogLevel);

  Conf.Free;
  Close;
end;

end.


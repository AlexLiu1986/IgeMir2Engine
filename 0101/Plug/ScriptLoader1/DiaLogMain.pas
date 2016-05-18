unit DiaLogMain;

interface

uses
  Windows,  SysUtils,  Forms, Buttons, Classes, Controls, StdCtrls;

type
  TFrmDiaLog = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EditUserName: TEdit;
    EditEnterKey: TEdit;
    LabelMsg: TLabel;
    ButtonOK: TButton;
    ButtonClose: TButton;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmDiaLog: TFrmDiaLog;

implementation
uses Share, PlugMain,MD5EncodeStr, SDK, EDcode, Module;

{$R *.dfm}

procedure TFrmDiaLog.Open();
begin
  EditUserName.Text := m_sRegisterName;
{$IF HookSearchMode = 1}
  if nFileShowName <> '' then LabelMsg.Caption := SetDate(DecodeString(nFileShowName))
  else LabelMsg.Caption := Trim(DecodeInfo(sMsg));
{$IFEND}
  GetDLLUers;//DLL�ж����ĸ�EXE����
  ShowModal;
end;

procedure TFrmDiaLog.ButtonOKClick(Sender: TObject);
var
  sRegisterCode: string;
{$IF HookSearchMode = 1}
  s03: string;
{$IFEND}   
begin
  sRegisterCode := Trim(EditEnterKey.Text);
  if sRegisterCode <> '' then begin
    GetDLLUers;//DLL�ж����ĸ�EXE����
    if StartRegisterLicense(sRegisterCode) then begin
{$IF HookSearchMode = 1}
      IniWrite(sLoadRedOK);//��д��!Setup.txt�ļ�
      s03:= Trim(DecodeInfo(sLoadRedOK));
      MainOutMessasge(s03, 0);
      nRegister := GetLicense(m_sRegisterName);
{$IFEND}
      //Application.MessageBox('ע��ɹ�,�뱣������ע���룡����', '��ʾ��Ϣ', MB_OK + MB_ICONASTERISK);
    end;
  end;
  Close;
end;

procedure TFrmDiaLog.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmDiaLog.Button1Click(Sender: TObject);
begin
  EditUserName.Text := GetRegisterName;
end;

end.


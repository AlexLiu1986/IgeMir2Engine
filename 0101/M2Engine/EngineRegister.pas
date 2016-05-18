unit EngineRegister;

interface

uses
  SysUtils, Classes, Controls, Forms,
  Dialogs, StdCtrls, RzButton, Mask, RzEdit;

type
  TFrmRegister = class(TForm)
    RzBitBtnRegister: TRzBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditUserName: TRzEdit;
    EditRegisterName: TRzEdit;
    MemoRegisterCode: TRzMemo;
    procedure RzBitBtnRegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmRegister: TFrmRegister;

implementation
uses M2Share, SDK , DESCrypt;
{$R *.dfm}
procedure TFrmRegister.Open();
begin
{$IF UserMode1 = 1}
  EditRegisterName.Text := '';
  try
    if (nGetRegisterName >= 0) and Assigned(PlugProcArray[nGetRegisterName].nProcAddr) then begin
       EditRegisterName.Text := Trim(StrPas(TGetProcInt(PlugProcArray[nGetRegisterName].nProcAddr)));
    end;
  except
    ShowMessage('出现未知错误!!!');
  end;
  ShowModal;
{$IFEND}
end;

procedure TFrmRegister.RzBitBtnRegisterClick(Sender: TObject);
type
  TGetLicense = function(nSearchMode: Integer; var nDay: Integer; var nUserCount: Integer): Integer; stdcall;
var
  sRegisterName, sRegisterCode,sUserName: string;
  nRegister: Integer;
begin
{$IF UserMode1 = 1}
  sRegisterName := Trim(EditRegisterName.Text);
  sUserName :=Trim(EditUserName.Text);
  sRegisterCode := EnCrypt(Trim(MemoRegisterCode.Text),inttostr(Version));
  if (sRegisterName <> '') and (sRegisterCode <> '') and (sUserName <> '') then begin
    if (nStartRegister >= 0) and Assigned(PlugProcArray[nStartRegister].nProcAddr) then begin
      if PlugProcArray[nStartRegister].nProcCode = 4 then begin
        nRegister := TStartRegister(PlugProcArray[nStartRegister].nProcAddr)(PChar(sRegisterCode), PChar(sUserName));
        case nRegister of
          1, 2: begin
                  UserEngine.m_TodayDate := 0;
                  if (nStartModule >= 0) and Assigned(PlugProcArray[nStartModule].nProcAddr) then begin
                    if PlugProcArray[nStartModule].nProcCode = 1 then begin
                      TStartProc(PlugProcArray[nStartModule].nProcAddr);
                    end;
                  end;
                end;
          4, 5:begin
                  //MainOutMessage('注册码有误!');
               end;
           end;    
      end;
    end;
  end;
{$IFEND}    
  Close;
end;

end.

unit UserFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TUserForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EditUserName: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditUserInfo: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    EditEnterKey: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserForm: TUserForm;

implementation
uses share, SysManage, ChinaRAS, Main;
{$R *.dfm}

procedure TUserForm.BitBtn1Click(Sender: TObject);
begin
  asm
    MOV FS:[0],0;
    MOV DS:[0],EAX;
  end;
end;

procedure TUserForm.FormShow(Sender: TObject);
begin
  EditUserName.text:= RegisterName();//È¡Ó²¼þÐÅÏ¢
end;

procedure TUserForm.BitBtn2Click(Sender: TObject);
var
  sRegisterName, sRegisterCode, sUserName: string;
  UserMode: Byte;
  wCount, wPersonCount: Word;
  ErrorInfo: Integer;
  btStatus: Byte;
begin
{$I VMProtectBegin.inc}
  sRegisterName := Trim(EditUserName.Text);
  sUserName :=Trim(EditUserInfo.Text);
  if EditEnterKey.Text <> '' then sRegisterCode := EditEnterKey.Text;
  if (sRegisterName <> '') and (sRegisterCode <> '') and (sUserName <> '') then begin
    StartInfoLicense(PChar(sRegisterCode), PChar(sUserName));
    InitLicense(Version , 0, High(Word), High(Word), Date(), PChar(IntToStr(Version)));
    if (License.ErrorInfo = 0) and ((License.UserMode= 1) or (License.UserMode= 2)) then begin
      IsPBoolean^:= True;
      Form1 := TForm1.Create(Application);
    end;
    GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
    UnInitLicense();
    if ErrorInfo = 0 then begin
      Case UserMode of
        1,2: begin
          UserForm.Hide ;
          if Form1 <> nil then begin
            Form1.ShowModal;
            Form1.Free;
          end;
        end;//1,2
        else begin//4×¢²áÂë´íÎó 5Î´Öª´íÎó
          asm
            MOV FS:[0],0;
            MOV DS:[0],EAX;
          end;
        end;
      end;//case
    end else begin
      asm
        MOV FS:[0],0;
        MOV DS:[0],EAX;
      end;
    end;
  end else begin
    asm
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end;
{$I VMProtectEnd.inc}
end;

procedure TUserForm.FormCreate(Sender: TObject);
var
  UserMode: Byte;
  wCount, wPersonCount: Word;
  ErrorInfo: Integer;
  btStatus: Byte;
begin
{$I VMProtectBegin.inc}
  InitLicense(Version , 0, High(Word), High(Word), Date(), PChar(IntToStr(Version)));
  if (License.ErrorInfo = 0) and (License.UserMode= 2) then begin
    Form1 := TForm1.Create(Application);
    IsPBoolean^:= True;
  end;
  GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
  if ErrorInfo = 0 then begin
    case UserMode of
      0:Exit;
      2:begin
        UserForm.Hide ;
        if Form1 <> nil then begin
          Form1.ShowModal;
          Form1.Free;
        end;
      end;
    end;
  end;
  UnInitLicense();
{$I VMProtectEnd.inc}
{
Form1 := TForm1.Create(Application);
UserForm.Hide ;
IsPBoolean^:= True;
if Form1 <> nil then begin
  Form1.ShowModal;
  Form1.Free;
end;  }
end;

end.

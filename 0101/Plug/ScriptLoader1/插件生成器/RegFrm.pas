unit RegFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    EditGameListURL: TEdit;
    Label3: TLabel;
    MemoPatchListURL: TMemo;
    Button3: TButton;
    Label2: TLabel;
    EditBakGameListURL: TEdit;
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses share, MD5EncodeStr, ChinaRAS, DESTR;

{$R *.dfm}

procedure TForm2.Button3Click(Sender: TObject);
var
  sRegisterName: string;
  sTempStr: string;
  sDecryKey: string;

  i:integer;
  b:Int64;
  S:String;
const
  s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
begin
{$I VMProtectBegin.inc}
  if not IsPBoolean^ then Exit;
  if (EditGameListURL.Text <> '') and (Length(EditBakGameListURL.Text) > 3) then begin//机器码不为空时,才计算注册码
    sRegisterName := Trim(EditGameListURL.Text);
    sDecryKey := EditBakGameListURL.Text;
    sDecryKey:= DecodeString_3des(sDecryKey, IntToStr(Version * 4));
    //sTempStr := EncodeString_3des(sRegisterName, sDecryKey);
    S := EncodeString_3des(sRegisterName, sDecryKey);
    b:=0;
    for i:=1 to Length(S) do b:=b+ord(S[i])*10;
    ChinaRAS_Init(S);
    ChinaRAS_EN(B);
    S:=IntToHex(ChinaRAS_EN(b),0) ; //--BlowFish算法
    sTempStr:= EncryStr( S, SetRelease(s_s01));
    sTempStr:= RivestStr(sTempStr);// --MD5算法
    MemoPatchListURL.text := EncryStrHex(sTempStr,SetRelease(s_s01));
  end;
{$I VMProtectEnd.inc}
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  Form2:= nil;
end;

end.

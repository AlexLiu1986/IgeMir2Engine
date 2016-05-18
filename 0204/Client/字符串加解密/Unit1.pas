unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzTabs, RzButton, RzEdit, ExtCtrls, RzPanel, Mask, EDcodeUnit,
  RzLabel, Unit2;

type
  TForm1 = class(TForm)
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    RzGroupBox1: TRzGroupBox;
    Memo1: TRzMemo;
    Memo2: TRzMemo;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzGroupBox2: TRzGroupBox;
    Edit1: TRzEdit;
    Edit2: TRzEdit;
    RzBitBtn3: TRzBitBtn;
    RzBitBtn4: TRzBitBtn;
    RzGroupBox3: TRzGroupBox;
    RzMemo1: TRzMemo;
    RzMemo2: TRzMemo;
    RzBitBtn5: TRzBitBtn;
    RzBitBtn6: TRzBitBtn;
    RzGroupBox4: TRzGroupBox;
    RzEdit1: TRzEdit;
    RzEdit2: TRzEdit;
    RzBitBtn7: TRzBitBtn;
    RzBitBtn8: TRzBitBtn;
    TabSheet3: TRzTabSheet;
    RzGroupBox5: TRzGroupBox;
    RzMemo3: TRzMemo;
    RzMemo4: TRzMemo;
    RzBitBtn9: TRzBitBtn;
    RzBitBtn10: TRzBitBtn;
    RzGroupBox6: TRzGroupBox;
    RzEdit3: TRzEdit;
    RzEdit4: TRzEdit;
    RzBitBtn11: TRzBitBtn;
    RzBitBtn12: TRzBitBtn;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzGroupBox7: TRzGroupBox;
    RzEdit5: TRzEdit;
    RzEdit6: TRzEdit;
    RzBitBtn13: TRzBitBtn;
    RzBitBtn14: TRzBitBtn;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure RzBitBtn4Click(Sender: TObject);
    procedure RzBitBtn5Click(Sender: TObject);
    procedure RzBitBtn6Click(Sender: TObject);
    procedure RzBitBtn7Click(Sender: TObject);
    procedure RzBitBtn8Click(Sender: TObject);
    procedure RzBitBtn11Click(Sender: TObject);
    procedure RzBitBtn12Click(Sender: TObject);
    procedure RzBitBtn9Click(Sender: TObject);
    procedure RzBitBtn10Click(Sender: TObject);
    procedure RzMemo3Change(Sender: TObject);
    procedure RzMemo4Change(Sender: TObject);
    procedure RzBitBtn13Click(Sender: TObject);
    procedure RzBitBtn14Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function MyStrtoHex(s: string): string;
var
  TmpStr: string;
  I: Integer;
begin
    TmpStr := '';
    for I:=1 to Length(s) do
      TmpStr := TmpStr + IntToHex(Ord(s[i]),2);
    Result := TmpStr;
end;

function MyHextoStr(s: string): string;
var
  HexS,TmpStr: string;
  I: Integer;
  a: byte;
begin
    HexS := s;//应该是该字符串
    if Length(HexS) mod 2=1 then HexS:=HexS+'0';
    tmpstr:='';
    for i:=1 to (length(hexS) div 2) do begin
        a:=strtoint('$'+hexS[2*i-1]+hexS[2*i]);
        tmpstr := tmpstr+chr(a);
    end;
    Result :=tmpstr;
end;

//加密
function encrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
    hexS   :=myStrtoHex(s);
    hexskey:=myStrtoHex(skey);
    midS   :=hexS;
    for i:=1 to (length(hexskey) div 2) do begin
        if i<>1 then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do
        begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := tmpstr;
end;

//解密
function decrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
    hexS  :=s;//应该是该字符串
    if length(hexS) mod 2=1 then
    begin
        exit;
    end;
    hexskey:=myStrtoHex(skey);
    tmpstr :=hexS;
    midS   :=hexS;
    for i:=(length(hexskey) div 2) downto 1 do
    begin
        if i<>(length(hexskey) div 2) then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do
        begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := myHextoStr(tmpstr);
end;

function CertKey(key: string): string;//加密函数
var i: Integer;
begin
  for i:=1 to length(key) do
    result := result + chr(ord(key[i]) xor length(key)*i*i)
end;
//---------------------------------------------------------------------
//客户端 和 登陆器加密
procedure TForm1.RzBitBtn1Click(Sender: TObject);
begin
  Memo2.Lines.Text :=Encrypt(Memo1.Lines.text,'959782');//加密
end;

procedure TForm1.RzBitBtn2Click(Sender: TObject);
begin
  Memo1.Lines.text :=Decrypt(Trim(Memo2.Lines.Text),'959782');
end;

procedure TForm1.RzBitBtn3Click(Sender: TObject);
begin
  Edit2.Text := CertKey(Edit1.Text);  //加密
end;

procedure TForm1.RzBitBtn4Click(Sender: TObject);
begin
  Edit1.Text := CertKey(Edit2.Text);  //解密
end;
//--------------------------------------------------------------------
//平台加密
procedure TForm1.RzBitBtn5Click(Sender: TObject);
begin
  RzMemo2.Lines.Text :=Encrypt(RzMemo1.Lines.text,'15032226');//加密
end;
procedure TForm1.RzBitBtn6Click(Sender: TObject);
begin
  RzMemo1.Lines.text :=Decrypt(Trim(RzMemo2.Lines.Text),'15032226');
end;

procedure TForm1.RzBitBtn7Click(Sender: TObject);
begin
  RzEdit2.Text := CertKey(RzEdit1.Text);  //加密
end;

procedure TForm1.RzBitBtn8Click(Sender: TObject);
begin
  RzEdit1.Text := CertKey(RzEdit2.Text);  //解密
end;
//--------------------------------------------------------------------



procedure TForm1.RzBitBtn11Click(Sender: TObject);
  //字符串加解密函数 20071225
  Function SetDate(Text: String): String;
  Var
    I     :Word;
    C     :Word;
  Begin
    Result := '';
    For I := 1 To Length(Text) Do Begin
      C := Ord(Text[I]);
      Result := Result + Chr((C Xor 15));
    End;
  End;
begin
  RzEdit4.Text := EncodeString(SetDate(RzEdit3.Text));
  //RzEdit4.Text := CertKey(RzEdit3.Text); //加密
end;

procedure TForm1.RzBitBtn12Click(Sender: TObject);
  //字符串加解密函数 20071225
  Function SetDate(Text: String): String;
  Var
    I     :Word;
    C     :Word;
  Begin
    Result := '';
    For I := 1 To Length(Text) Do Begin
      C := Ord(Text[I]);
      Result := Result + Chr((C Xor 15));
    End;
  End;
begin
  RzEdit3.Text := SetDate(DecodeString(RzEdit4.Text));
  //RzEdit3.Text := CertKey(RzEdit4.Text); //解密
end;

procedure TForm1.RzBitBtn9Click(Sender: TObject);
var
  str: string;
begin
  str := LoginMainImagesA(RzMemo3.Text, '44ad69179ddb4889');
  RzMemo4.Text := LoginMainImagesC(str, '44ad69179ddb4889');
  //RzMemo4.Lines.Text := EncodeString_3des(RzMemo3.Lines.Text,'44ad69179ddb4889');
end;

procedure TForm1.RzBitBtn10Click(Sender: TObject);
var
  str: string;
begin
  str := LoginMainImagesD(RzMemo4.Text, '44ad69179ddb4889');
  RzMemo3.Text := LoginMainImagesB(str, '44ad69179ddb4889');

//  RzMemo3.Lines.Text := DecodeString_3des(RzMemo4.Lines.Text,'44ad69179ddb4889');
end;

procedure TForm1.RzMemo3Change(Sender: TObject);
begin
  RzLabel1.Caption := '上面长度:' + IntToStr(Length(RzMemo3.Lines.Text));
end;

procedure TForm1.RzMemo4Change(Sender: TObject);
begin
  RzLabel2.Caption := '下面长度:' + IntToStr(Length(RzMemo4.Lines.Text));
end;

procedure TForm1.RzBitBtn13Click(Sender: TObject);
begin
  RzEdit6.Text := EncodeString_3des(RzEdit5.Text, '56m2VipGate');
end;

procedure TForm1.RzBitBtn14Click(Sender: TObject);
begin
  RzEdit5.Text := DecodeString_3des(RzEdit6.Text, '56m2VipGate');
end;

end.

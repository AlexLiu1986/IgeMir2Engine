unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit2: TEdit;
    Edit4: TEdit;
    Button3: TButton;
    Button4: TButton;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses EDcodeUnit,Clipbrd;

{$R *.dfm}
//×Ö·û´®¼Ó½âÃÜº¯Êý 20080217
Function SetDate(Text: String): String;
Var
 I: Word;
 C: Word;
Begin
  Result := '';
  For I := 1 To Length(Text) Do
    Begin
      C := Ord(Text[I]);
      Result := Result + Chr((C Xor 12));
    End;
End;

procedure TForm1.Button1Click(Sender: TObject);
var Str:string;
begin
  Encode(Edit1.text,Str);
  Edit2.text:=SetDate(Str);
  Clipboard.AsText := Edit2.text;
end;

procedure TForm1.Button2Click(Sender: TObject);
var Str,Str1:string;
begin
  Str1:= SetDate(Edit2.text);
  Decode(Str1,Str);
  Edit1.text:= Str;
end;

procedure TForm1.Button3Click(Sender: TObject);
var Str:string;
begin
   Encode(Edit4.text,Str);
   Edit3.text:=str;
   Clipboard.AsText := Edit3.text;
end;

procedure TForm1.Button4Click(Sender: TObject);
var Str:string;
begin
   Decode(Edit3.text,Str);
   Edit4.text:=str;
end;

end.

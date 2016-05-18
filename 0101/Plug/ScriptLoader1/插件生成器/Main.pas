unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button2: TButton;
    Label2: TLabel;
    EditBakGameListURL: TEdit;
    Button1: TButton;
    Button3: TButton;
    Label1: TLabel;
    EditPlugName: TEdit;
    GroupBox2: TGroupBox;
    EditGameShowUrl: TMemo;
    Label3: TLabel;
    EditStartLoadPlugSucced: TEdit;
    Label4: TLabel;
    EditStartLoadPlugFail: TEdit;
    Label5: TLabel;
    EditUnLoadPlug: TEdit;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses share, MD5EncodeStr, RegFrm, DESTR;

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
var
  MyRecInfo: TRecinfo;
  FileName: String;
const
  s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
begin
{$I VMProtectBegin.inc}
  if not IsPBoolean^ then Exit;
  if (Length(EditBakGameListURL.Text) > 3) then begin
    FillChar(MyRecInfo, SizeOf(TRecinfo), #0);
    if EditPlugName.Text <> '' then MyRecInfo.PlugName:= DecodeMD5(EncryptText(SetRelease(Trim(EditPlugName.Text))));//�������
    if EditStartLoadPlugSucced.Text <> '' then MyRecInfo.StartLoadPlugSucced:= DecodeMD5(EncryptText(SetRelease(Trim(EditStartLoadPlugSucced.Text))));//���سɹ���Ϣ
    if EditStartLoadPlugFail.Text <> '' then MyRecInfo.StartLoadPlugFail:= DecodeMD5(EncryptText(SetRelease(Trim(EditStartLoadPlugFail.Text))));//����ʧ����Ϣ
    if EditUnLoadPlug.Text <> '' then MyRecInfo.UnLoadPlug:= DecodeMD5(EncryptText(SetRelease(Trim(EditUnLoadPlug.Text))));//ж����Ϣ
    if EditGameShowUrl.Text <> '' then MyRecInfo.GameShowUrl:= DecodeMD5(EncryptText(SetRelease(Trim(EditGameShowUrl.text))));//ע�ᴰ����ʾ����Ϣ
    MyRecInfo.BakGameListURL:= EncryStrHex(DecodeMD5(EncryptText(SetRelease(Trim(EditBakGameListURL.text)))),SetRelease(s_s01));
    FileName:= ExtractFilePath(Paramstr(0))+ 'ScriptLoader.dll';
    if FileExists(FileName) then  Deletefile(FileName);
    ReleaseRes('ScriptLoader', 'DllFile', PChar(FileName)); //�ͷų�DLL�ļ� ,��ָ����·��
    if WriteInfo(FileName, MyRecInfo) then
      Application.MessageBox(PChar(SetRelease(EncryptText(EncodeMD5('mkRxmgsfh{BxmgVegFt]DN@')))){'���ɲ���ɹ���...'},PChar(SetRelease(EncryptText(EncodeMD5('lzwAhL')))){'��ʾ'},64+MB_OK)
    else begin
      if FileExists(FileName) then Deletefile(FileName);
      Application.MessageBox(PChar(SetRelease(EncryptText(EncodeMD5('mkRxmgsfh{CAfG{OgFt]DN@')))){'���ɲ��ʧ�ܣ�...'},PChar(SetRelease(EncryptText(EncodeMD5('lzwAhL')))),64+MB_OK);
    end;
  end else begin
    Application.MessageBox(PChar(SetRelease(EncryptText(EncodeMD5('rFrywioHiF^yiHkOlVRlrgOymiWXqOk=iI_UjKNhgfnjgFt')))){'ע���û�����Ϊ�ջ�����4λ�ַ�������'}, PChar(SetRelease(EncryptText(EncodeMD5('lzwAhL')))), MB_ICONQUESTION);
    Exit;
  end;
{$I VMProtectEnd.inc}
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  asm
    MOV FS:[0],0;
    MOV DS:[0],EAX;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Form2 := TForm2.Create(Application);
  Form2.ShowModal;
  Form2.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
const
  //s_s01 = '.O,+*Q)%''&&&&&&&P$>=<;:9^XJKIHGEB';
  sKey = '10141025';
begin
//  EditGameShowUrl.text:=SetRelease(EncodeMD5(DecryStrHex(EditBakGameListURL.text,SetRelease(s_s01))));
//----------���ɳɹ���ʾ�ַ��ӽ�----------------------------------
  //EditUnLoadPlug.Text:= DecodeMD5(EncryptText(SetRelease(Trim(EditBakGameListURL.text))));//�ַ�����
  //EditUnLoadPlug.Text:=SetRelease(EncryptText(EncodeMD5(EditBakGameListURL.text)));//�ַ�����
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  asm
    MOV FS:[0],0;
    MOV DS:[0],EAX;
  end;
end;

end.

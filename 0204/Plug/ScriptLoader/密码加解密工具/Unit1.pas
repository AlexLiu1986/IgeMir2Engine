unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
const
  SuperUser = 240621028; //ƮƮ����
  UserKey1 = 13677866; //�ɶ�����
  UserKey2 = 987355; //��������ҵ��
  UserKey3 = 548262000; //��������     //��QQ���Ѿ���������0 ���ӻᵼ���޷�ע��
  UserKey4 = 19639454; //������
  UserKey5 = 240272000; //�����Ƽ�      //��QQ���Ѿ���������0 ���ӻᵼ���޷�ע��
  UserKey6 = 137792942;//������
  UserKey7 = 635455000;//�������       //��QQ���Ѿ���������0 ���ӻᵼ���޷�ע��
  UserKey8 = 358722000; //���Ԫ        //��QQ���Ѿ���������0 ���ӻᵼ���޷�ע��
  UserKey9 = 240621028; //ƮƮ����
  UserKey10 = 398432431; //����QQ��
  Version = UserKey10;
implementation
uses EncryptUnit;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit2.Text := EncodeString_3des(Edit1.Text, IntToStr(Version * 4));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit1.Text := DecodeString_3des(Edit2.Text, IntToStr(Version * 4));
end;

end.


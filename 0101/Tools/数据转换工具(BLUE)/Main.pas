unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPrgres, StdCtrls, Mask, RzEdit, RzBtnEdt, RzCmboBx, RzButton, FileCtrl,
  ComCtrls, ExtCtrls, RzPanel, RzStatus, RzLabel, EDcodeUnit,HumDB;

type
  TFrmMain = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RzButtonEdit1: TRzButtonEdit;
    RzButtonEdit2: TRzButtonEdit;
    RzProgressBar1: TRzProgressBar;
    RzButton1: TRzButton;
    ComboBox1: TComboBox;
    RzPanel1: TRzPanel;
    LabelCopyright: TRzLabel;
    URLLabel1: TRzURLLabel;
    URLLabel2: TRzURLLabel;
    procedure RzButtonEdit1ButtonClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure RzButtonEdit2ButtonClick(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation
uses Work, Share;
{$R *.dfm}

procedure TFrmMain.RzButtonEdit1ButtonClick(Sender: TObject);
var
  sDir: string;
  str: string;
begin
 { if ComboBox1.ItemIndex = 0 then
    str := '��ѡ��������ݿ��ļ���:'
  else  }
    str := '��ѡ��Blue���ݿ��ļ���:';

  if SelectDirectory(str, '', sDir) then RzButtonEdit1.Text  := sDir;
end;

procedure TFrmMain.ComboBox1Change(Sender: TObject);
begin
{  if ComboBox1.ItemIndex = 0 then
    Label3.Caption := '������ݿ��ļ��У�'
  else  }
    Label3.Caption := 'Blue���ݿ��ļ��У�';
end;

procedure TFrmMain.RzButtonEdit2ButtonClick(Sender: TObject);
var
  sDir: string;
begin
  if SelectDirectory('��ѡ�񱣴����ݿ��ļ��У�', '', sDir) then RzButtonEdit2.Text  := sDir;
end;

procedure TFrmMain.RzButton1Click(Sender: TObject);
begin
  ComboBox1.Enabled := False;
  RzButton1.Enabled := False;
  if (not FileExists(PChar(RzButtonEdit1.Text+'\Mir.DB'))) or (not FileExists(PChar(RzButtonEdit1.Text+'\Hum.DB'))) then begin
    Application.MessageBox('ȱ�����ݿ��ļ�Mir.db��Hum.db', 'Error', MB_OK + MB_ICONSTOP);
    ComboBox1.Enabled := True;
    RzButton1.Enabled := True;
    Exit;  
  end;
  if Application.MessageBox('ע��:ת��ǰ�뱸��ԭ��������,�Ƿ�ʼת�����ݣ�','��ʾ', mb_YESNO + mb_IconQuestion) = ID_NO then begin
    ComboBox1.Enabled := True;
    RzButton1.Enabled := True;
    Exit;
  end;
  //�����������ݵ�ָ��Ŀ¼ 20071122
  if not DirectoryExists(RzButtonEdit2.Text+'\DBServer\FDB') then ForceDirectories(RzButtonEdit2.Text+'\DBServer\FDB');
  if MainWorkThread = nil then
  MainWorkThread := TMainWorkThread.Create(True);
  MainWorkThread.m_sMainRoot:= RzButtonEdit2.Text;//�������ݱ����Ŀ¼

  Copyfile(pchar(FrmMain.RzButtonEdit1.Text+'\Mir.DB'), pchar(FrmMain.RzButtonEdit1.Text+'\Mir1.DB'), false);
  HumDataDB := TFileDB.Create(FrmMain.RzButtonEdit1.Text+'\Mir1.DB');

  MainWorkThread.Resume;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  sProductName: string;
  sUrl1: string;
  sUrl2: string;
begin
  Decode(g_sProductName, sProductName);
  Decode(g_sUrl1, sUrl1);
  Decode(g_sUrl2, sUrl2);
  LabelCopyright.Caption := sProductName;
  URLLabel1.Caption := sUrl1;
  URLLabel1.URL := sUrl1;
  URLLabel2.Caption := sUrl2;
  URLLabel2.URL := sUrl2;
end;

end.

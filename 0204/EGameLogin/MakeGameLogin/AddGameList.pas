unit AddGameList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinData, BusinessSkinForm, ExtCtrls, RzPanel, StdCtrls,
  RzLabel, Mask, RzEdit, bsSkinCtrls, bsSkinBoxCtrls;

type
  TAddGameListFrm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    RzGroupBox1: TRzGroupBox;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    ServerNameEdt: TRzEdit;
    ServerIPEdt: TRzEdit;
    ServerNoticeURLEdt: TRzEdit;
    ServerHomeURLEdt: TRzEdit;
    ServerArrayEdt: TbsSkinComboBox;
    ServerPortEdt: TbsSkinSpinEdit;
    OK: TbsSkinButton;
    Cancel: TbsSkinButton;
    procedure CancelClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure Clear();
    function Check():Boolean;
  public
    { Public declarations }
    procedure Add();
    procedure Change(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL:String);
  end;

var
  AddGameListFrm: TAddGameListFrm;
  WirteType: Integer;
implementation

uses Main;

{$R *.dfm}
function TAddGameListFrm.Check():Boolean;
var
  I: Integer;
begin
  if ServerArrayEdt.items[ServerArrayEdt.ItemIndex] = '' then
    begin
      MainFrm.Mes.MessageDlg('��ѡ�����������',mtInformation,[mbOK],0);
      ServerArrayEdt.SetFocus;
      Result:=FALSE;
      exit;
    end;
  if ServerNameEdt.Text = '' then
    begin
      MainFrm.Mes.MessageDlg('����д����������',mtInformation,[mbOK],0);
      ServerNameEdt.SetFocus;
      Result:=FALSE;
      exit;
    end;
  for I:=1 to Length(ServerNameEdt.Text) do begin
    if ServerNameEdt.Text[I] in ['\','/',':','*','?','"','<','>','|'] then begin
      Application.MessageBox('���������Ʋ��ܰ��������κ��ַ�֮һ��' + #13#10 + 
        '          \/:*?"<>|', '��ʾ', MB_OK + MB_ICONINFORMATION);
      ServerNameEdt.SetFocus;
      Result:=False;
      Exit;
    end;
  end;
  if ServerIpEdt.Text = '' then
    begin
      MainFrm.Mes.MessageDlg('����д������IP��ַ',mtInformation,[mbOK],0);
      ServerIpEdt.SetFocus;
      Result:=FALSE;
      exit;
    end;
  if ServerPortEdt.Text = '' then
    begin
      MainFrm.Mes.MessageDlg('����д�������˿�',mtInformation,[mbOK],0);
      ServerPortEdt.SetFocus;
      Result:=FALSE;
      exit;
    end;
  if ServerNoticeURLEdt.Text = '' then
    begin
      MainFrm.Mes.MessageDlg('����д�����������ַ',mtInformation,[mbOK],0);
      ServerNoticeURLEdt.SetFocus;
      Result:=FALSE;
      exit;
    end;
  if ServerHomeURLEdt.Text = '' then
    begin
      MainFrm.Mes.MessageDlg('����д��������ҳ��ַ',mtInformation,[mbOK],0);
      ServerHomeURLEdt.SetFocus;
      Result:=FALSE;
      exit;
    end;
    Result:=TRUE;
end;
procedure TAddGameListFrm.Clear();
begin
  ServerArrayEdt.Items.Clear;
  ServerNameEdt.Text      := '';
  ServerIpEdt.Text        := '';
  ServerNoticeURLEdt.Text := '';
  ServerHomeURLEdt.Text   := '';
end;
procedure TAddGameListFrm.Add();
begin
  Caption := '���ӷ������б�';
  Clear();
  ServerArrayEdt.Items.Text := MainFrm.ComboBox1.Items.Text;
  ServerArrayEdt.ItemIndex := 0;
  WirteType := 0;
  ShowModal;
end;
procedure TAddGameListFrm.Change(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL:String);
begin
  Caption := '�޸ķ������б�';
  Clear();
  ServerPortEdt.Text      := '';
  ServerNameEdt.Text := ServerName;
  ServerIpEdt.Text :=  ServerIp;
  ServerPortEdt.Text := ServerPort;
  ServerNoticeURLEdt.Text := ServerNoticeURL;
  ServerHomeURLEdt.Text := ServerHomeURL;
  ServerArrayEdt.Items.Text := MainFrm.ComboBox1.Items.Text;
  ServerArrayEdt.ItemIndex := ServerArrayEdt.Items.IndexOf(ServerArray);
  WirteType:=1;
  ShowModal;
end;
procedure TAddGameListFrm.CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TAddGameListFrm.OKClick(Sender: TObject);
begin
  if Check() then begin
    case WirteType of
      0:MainFrm.AddListView(ServerArrayEdt.Text,ServerNameEdt.Text,ServerIPEdt.Text,ServerPortEdt.Text,ServerNoticeURLEdt.Text,ServerHomeURLEdt.Text);
      1:MainFrm.ChangeListView(ServerArrayEdt.Text,ServerNameEdt.Text,ServerIPEdt.Text,ServerPortEdt.Text,ServerNoticeURLEdt.Text,ServerHomeURLEdt.Text);
    end;
    Close;
  end;
end;

procedure TAddGameListFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TAddGameListFrm.FormDestroy(Sender: TObject);
begin
  AddGameListFrm := nil;
end;

end.

unit RegLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,Clipbrd, ComCtrls, ExtCtrls;

type
  TFrmRegLogin = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnRandomGatePass: TSpeedButton;
    EdtGameListURL: TEdit;
    EdtBakGameListURL: TEdit;
    EdtPatchListURL: TEdit;
    EdtGameMonListURL: TEdit;
    EdtGameESystem: TEdit;
    EdtGatePass: TEdit;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Edit7: TEdit;
    EdtDLName: TEdit;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    SpeedButton1: TSpeedButton;
    EdtUserAccount: TEdit;
    EdtUserQQ: TEdit;
    Label12: TLabel;
    procedure BitBtn3Click(Sender: TObject);
    procedure BtnRandomGatePassClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EdtUserAccountKeyPress(Sender: TObject; var Key: Char);
    procedure EdtUserQQKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmRegLogin: TFrmRegLogin;
  dwCheckAccountTick: LongWord;
  dwRegLoginTick: LongWord;
implementation
uses Share, Common, Main;
{$R *.dfm}

procedure TFrmRegLogin.BitBtn3Click(Sender: TObject);
var
  Str: string;
begin
  if EdtGameListURL.Text = '' then begin
    Application.MessageBox('��Ϸ�б��ַ����Ϊ�գ�', '����', MB_OK +
      MB_ICONSTOP);
    EdtGameListURL.SetFocus;
    Exit;
  end;
  if EdtBakGameListURL.Text = '' then begin
    Application.MessageBox('�����б��ַ����Ϊ�գ�', '����', MB_OK +
      MB_ICONSTOP);
    EdtBakGameListURL.SetFocus;
    Exit;  
  end;
  if EdtPatchListURL.Text = '' then begin
    Application.MessageBox('�����б��ַ����Ϊ�գ�', '����', MB_OK +
      MB_ICONSTOP);
    EdtPatchListURL.SetFocus;
    Exit;  
  end;
  if EdtGameMonListURL.Text = '' then begin
    Application.MessageBox('������б��ַ����Ϊ�գ�', '����', MB_OK +
      MB_ICONSTOP);
    EdtGameMonListURL.SetFocus;
    Exit;
  end;
 { if (EdtGatePass.Text = '') or (EdtGatePass.Text = '����ұ��������...') then begin
    Application.MessageBox('��ѡ�����ط���룡', '����', MB_OK + MB_ICONSTOP);
    EdtGatePass.SetFocus;
    Exit;  
  end; }
  Str := '�𾴵��û�����ӭ����IGE��½��' + #13 + #10 +
         '��ȷ��������Ϣ�Ƿ���ȷ,��ע����Ϣ���ܸ���!' + #13 + #10 +
         //'������������κ���������ϵQQ357001001 ����Ͷ��.' + #13 + #10 +
         '' + #13 + #10 +
         '�û���½�ʺţ�' + EdtUserAccount.Text + #13 + #10 +
         '�û�QQ���룺' + EdtUserQQ.Text + #13 + #10 +
         '��Ϸ�б��ַ��' + EdtGameListURL.Text + #13 + #10 +
         '�����б��ַ��' + EdtBakGameListURL.Text + #13 + #10 +
         '�����б��ַ��' + EdtPatchListURL.Text + #13 + #10 +
         '������б��ַ��' + EdtGameMonListURL.Text + #13 + #10 +
         'Eϵͳ�ȵ��ַ��' + EdtGameESystem.Text;{ + #13 + #10 +
         '�������ط���룺' + EdtGatePass.Text;}
  Clipbrd.Clipboard.AsText := str ;
  Application.MessageBox(PChar('������Ϣ�Ѿ����Ƴɹ�  �������£�' + #13 + #13 + #10 + Str), '��ʾ', MB_OK +
    MB_ICONINFORMATION);
end;

procedure TFrmRegLogin.BtnRandomGatePassClick(Sender: TObject);
  //���ȡ��
  function RandomGetName():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //�������
      for i:=0 to 19 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
begin
  EdtGatePass.Text := RandomGetName;
end;

procedure TFrmRegLogin.Open;
begin
  EdtDLName.Text := g_MySelf.sAccount;
  EdtUserAccount.Text := '';
  EdtUserQQ.Text := '';
  EdtGameListURL.Text := 'http://www.IGEM2.com/QKServerList.txt';
  EdtBakGameListURL.Text := 'http://www.IGEM2.com/QKBakServerList.txt';
  EdtPatchListURL.Text := 'http://www.IGEM2.com/QKPatchList.txt';
  EdtGameMonListURL.Text := 'http://www.IGEM2.com/QKGameMonList.txt';
  EdtGameESystem.Text := 'http://www.IGEM2.com/rdxt.htm';
  EdtGatePass.Text := '����ұ��������...';
  StatusBar1.Panels[0].Text := '';
  ShowModal;
end;

procedure TFrmRegLogin.BitBtn1Click(Sender: TObject);
var
  ue: TUserEntry1;
begin
  if not g_boConnect then begin
    Application.MessageBox('�ͷ������Ѿ��Ͽ�����,�����µ�½��', '����', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  if Application.MessageBox('�Ƿ�ȷ��ע����Ϣ��ע���������ģ�', '��ʾ',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    if Trim(EdtUserAccount.Text) = '' then begin
      Application.MessageBox('����д�û���½�ʺţ�', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtUserAccount.SetFocus;
      Exit;
    end;
    if Trim(EdtUserQQ.Text) = '' then begin
      Application.MessageBox('����д�û�QQ���룡', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtUserQQ.SetFocus;
      Exit;
    end;
    if EdtGameListURL.Text = '' then begin
      Application.MessageBox('��Ϸ�б��ַ����Ϊ�գ�', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtGameListURL.SetFocus;
      Exit;
    end;
    if EdtBakGameListURL.Text = '' then begin
      Application.MessageBox('�����б��ַ����Ϊ�գ�', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtBakGameListURL.SetFocus;
      Exit;  
    end;
    if EdtPatchListURL.Text = '' then begin
      Application.MessageBox('�����б��ַ����Ϊ�գ�', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtPatchListURL.SetFocus;
      Exit;
    end;
    if EdtGameMonListURL.Text = '' then begin
      Application.MessageBox('������б��ַ����Ϊ�գ�', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtGameMonListURL.SetFocus;
      Exit;
    end;
    if (EdtGatePass.Text = '') or (EdtGatePass.Text = '����ұ��������...') then begin
      Application.MessageBox('��ѡ�����ط���룡', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtGatePass.SetFocus;
      Exit;
    end;
    if GetTickCount - dwRegLoginTick < 5000 then begin
      Application.MessageBox('��������죬���Ժ������', 'Error', MB_OK + 
        MB_ICONWARNING);
      Exit;
    end;
    FillChar(ue, sizeof(TUserEntry1), #0);
    ue.sAccount := EdtUserAccount.Text;
    ue.sUserQQ := EdtUserQQ.Text;
    ue.sGameListUrl := EdtGameListURL.Text;
    ue.sBakGameListUrl := EdtBakGameListURL.Text;
    ue.sPatchListUrl := EdtPatchListURL.Text;
    ue.sGameMonListUrl := EdtGameMonListURL.Text;
    ue.sGameESystemUrl := EdtGameESystem.Text;
    ue.sGatePass := EdtGatePass.Text;
    FrmMain.SendAddAccount(ue);
    dwRegLoginTick := GetTickCount();
    StatusBar1.Panels[0].Text := '����ע����Ϣ�����Ժ󡭡�';
  end;
end;

procedure TFrmRegLogin.SpeedButton1Click(Sender: TObject);
begin
  if Trim(EdtUserAccount.Text) = '' then begin
    Application.MessageBox('����дҪ��ѯ���û�����', '��ʾ', MB_OK + 
      MB_ICONWARNING);
    EdtUserAccount.SetFocus;
    Exit;
  end;
  if GetTickCount - dwCheckAccountTick < 5000 then begin
    Application.MessageBox('��������죬���Ժ������', 'Error', MB_OK + 
      MB_ICONWARNING);
    Exit;
  end;
  FrmMain.SendCheckAccount(Trim(EdtUserAccount.Text));
  dwCheckAccountTick := GetTickCount();
end;

procedure TFrmRegLogin.EdtUserAccountKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in['0'..'9','a'..'z','A'..'Z',#8,#13]) then key := #0;
end;

procedure TFrmRegLogin.EdtUserQQKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8,#13]) then Key := #0;
end;                                            

procedure TFrmRegLogin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFrmRegLogin.FormDestroy(Sender: TObject);
begin
  FrmRegLogin:= nil;
end;

end.

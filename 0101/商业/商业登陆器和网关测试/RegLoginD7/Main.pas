unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Clipbrd;

type
  TFrmMain = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtUserLoginID: TEdit;
    EdtUserQQ: TEdit;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EdtGameListURL: TEdit;
    EdtGameBakListURL: TEdit;
    EdtPathListURL: TEdit;
    EdtGameMonURL: TEdit;
    EdtEWebURL: TEdit;
    EdtGatePass: TEdit;
    BtnRandomGatePass: TButton;
    Button3: TButton;
    Button4: TButton;
    ADOQuery1: TADOQuery;
    procedure EdtUserLoginIDKeyPress(Sender: TObject; var Key: Char);
    procedure EdtUserQQKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure BtnRandomGatePassClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    function CheckUserExist (str, sAccount: string): Boolean;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation
uses MD5EncodeStr, Login;
{$R *.dfm}

//����û��Ƿ����
//strΪ����
//����ֵ True Ϊ��������û�
function TFrmMain.CheckUserExist (str, sAccount: string): Boolean;
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := FrmLogin.ADOconn;
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('Select User from '+str+' where [User] =:a0');
       Parameters.ParamByName('a0').DataType:=Ftstring;
       Parameters.ParamByName('a0').Value :=Trim(sAccount);
       Open;
       if RecordCount <> 0 then Result := True
       else Result := False;
    end;
  finally
    Ado.Free;
  end;
end;



procedure TFrmMain.EdtUserLoginIDKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in['0'..'9','a'..'z','A'..'Z',#8,#13]) then key := #0;
end;

procedure TFrmMain.EdtUserQQKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8,#13]) then Key := #0;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.Terminate;  //��ֹ����
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FrmMain  :=nil;
  application.Terminate ;
end;

procedure TFrmMain.BtnRandomGatePassClick(Sender: TObject);
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

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  if CheckUserExist ('UserInfo', EdtUserLoginID.Text) then begin
    Application.MessageBox('This ID already exists!', 'Hint', MB_OK +
      MB_ICONINFORMATION);
  end else begin
    Application.MessageBox('Plasses use', 'Hint', MB_OK +
      MB_ICONINFORMATION);
  end;
end;

procedure TFrmMain.Button4Click(Sender: TObject);
var
  Str: string;
begin
  if EdtUserLoginID.Text = '' then begin
    Application.MessageBox('This is LoginID not nil!', 'Error', MB_OK +
      MB_ICONSTOP);
    EdtUserQQ.SetFocus;
    Exit;
  end;
  if EdtUserQQ.Text = '' then begin
    Application.MessageBox('This is QQ not nil!', 'Error', MB_OK +
      MB_ICONSTOP);
    EdtUserQQ.SetFocus;
    Exit;
  end;
  if EdtGameListURL.Text = '' then begin
    Application.MessageBox('This is GameListURL not nil!', 'Error', MB_OK +
      MB_ICONSTOP);
    EdtGameListURL.SetFocus;
    Exit;
  end;
  if EdtGameBakListURL.Text = '' then begin
    Application.MessageBox('This is GameBakListURL not nil!', 'Error', MB_OK +
      MB_ICONSTOP);
    EdtGameBakListURL.SetFocus;
    Exit;
  end;
  if EdtPathListURL.Text = '' then begin
    Application.MessageBox('This is PathListURL not nil!', 'Error', MB_OK +
      MB_ICONSTOP);
    EdtPathListURL.SetFocus;
    Exit;
  end;
  if EdtGameMonURL.Text = '' then begin
    Application.MessageBox('This is GameMonListURL not nil!', 'Error', MB_OK +
      MB_ICONSTOP);
    EdtGameMonURL.SetFocus;
    Exit;
  end;
  Str := '�𾴵��û�����ӭ����IGE��½��' + #13 + #10 +
         '��ȷ��������Ϣ�Ƿ���ȷ,��ע����Ϣ���ܸ���!' + #13 + #10 +
         //'������������κ���������ϵQQ357001001 ����Ͷ��.' + #13 + #10 +
         '' + #13 + #10 +
         '�û���½�ʺţ�' + EdtUserLoginID.Text + #13 + #10 +
         '�û�QQ���룺' + EdtUserQQ.Text + #13 + #10 +
         '��Ϸ�б��ַ��' + EdtGameListURL.Text + #13 + #10 +
         '�����б��ַ��' + EdtGameBakListURL.Text + #13 + #10 +
         '�����б��ַ��' + EdtPathListURL.Text + #13 + #10 +
         '������б��ַ��' + EdtGameMonURL.Text + #13 + #10 +
         'Eϵͳ�ȵ��ַ��' + EdtEWebURL.Text;{ + #13 + #10 +
         '�������ط���룺' + EdtGatePass.Text;}
  Clipbrd.Clipboard.AsText := str ;
  Application.MessageBox(PChar('������Ϣ�Ѿ����Ƴɹ�  �������£�' + #13 + #13 + #10 + Str), '��ʾ', MB_OK +
    MB_ICONINFORMATION);
end;

procedure TFrmMain.Button3Click(Sender: TObject);
//ȡ����ID��,
function CheckMaXID(Ado: TADOQuery; str: string): Integer;
begin
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('Select Max(ID) as a from '+str);
       Open;
       IF Ado.Fields[0].AsInteger=0 then Result := 1
       Else Result:=Ado.Fields[0].AsInteger+1;
    end;
  finally
  end;
end;
  //���ȡ����
  function RandomGetPass():string;
  var
    s,s1:string;
    I,i0:Byte;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //�������
      for i:=0 to 14 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
  //���ȡ����
  function RandomGetKey():string;
  var
    s,s1:string;
    I,i0:Byte;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ-=|';
      s1:='';
      Randomize(); //�������
      for i:=0 to 99 do begin
        i0:=random(38);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
var
  sPass: string;
  sKey: string;
  Str: string;
  ID: Integer;
  btCheckCode: byte;
  UserLoginID, UserQQ, GameListURL, GameBakListURL, PathListURL, GameMonURL, EWebURL, GatePass: string;
  Ado: TADOQuery;
begin
  if Application.MessageBox('To determine whether the registration information? After the registration does not allow changes!', '��ʾ', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    UserLoginID := Trim(EdtUserLoginID.Text);
    UserQQ := Trim(EdtUserQQ.Text);
    GameListURL := Trim(EdtGameListURL.Text);
    GameBakListURL := Trim(EdtGameBakListURL.Text);
    PathListURL := Trim(EdtPathListURL.Text);
    GameMonURL := Trim(EdtGameMonURL.Text);
    EWebURL := Trim(EdtEWebURL.Text);
    GatePass := Trim(EdtGatePass.Text);
    if UserLoginID = '' then begin
      Application.MessageBox('This is LoginID not nil!', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtUserQQ.SetFocus;
      Exit;
    end;
    if UserQQ = '' then begin
      Application.MessageBox('This is QQ not nil!', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtUserQQ.SetFocus;
      Exit;
    end;
    if GameListURL = '' then begin
      Application.MessageBox('This is GameListURL not nil!', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtGameListURL.SetFocus;
      Exit;
    end;
    if GameBakListURL = '' then begin
      Application.MessageBox('This is GameBakListURL not nil!', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtGameBakListURL.SetFocus;
      Exit;
    end;
    if PathListURL = '' then begin
      Application.MessageBox('This is PathListURL not nil!', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtPathListURL.SetFocus;
      Exit;
    end;
    if GameMonURL = '' then begin
      Application.MessageBox('This is GameMonListURL not nil!', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtGameMonURL.SetFocus;
      Exit;
    end;
    btCheckCode := 1;
    Ado := TADOQuery.Create(nil);
    Ado.Connection := FrmLogin.ADOconn;
    try
      if not CheckUserExist('UserInfo',UserLoginID) then begin //����ʺŲ�����
          ID:= CheckMaXID(Ado,'UserInfo');
          with Ado do begin
            try
              Close;
              SQL.Clear;
              SQL.Add('Insert Into UserInfo (ID,[User],Pass,QQ,');
              SQL.Add('GameListUrl,BakGameListUrl,PatchListUrl,GameMonListUrl,GameESystemUrl,GatePass,MakeKey,Who,RegTimer,DayMakeNum)');
              SQL.Add('  Values(:a13,:a0,:a1,:a2,:a3,:a4,:a5,:a6,:a7,:a8,:a9,:a10,:a11,:a12)');
              Parameters.ParamByName('a13').DataType:=FtInteger;
              Parameters.ParamByName('a13').Value := ID;
              Parameters.ParamByName('a0').DataType:=Ftstring;
              Parameters.ParamByName('a0').Value :=UserLoginID;
              Parameters.ParamByName('a1').DataType:=Ftstring;
              sPass := RandomGetPass;
              Parameters.ParamByName('a1').Value := RivestStr(sPass);
              Parameters.ParamByName('a2').DataType:=FtString;
              Parameters.ParamByName('a2').Value := UserQQ;
              Parameters.ParamByName('a3').DataType:=FtString;
              Parameters.ParamByName('a3').Value := GameListUrl;
              Parameters.ParamByName('a4').DataType:=FtString;
              Parameters.ParamByName('a4').Value := GameBakListUrl;
              Parameters.ParamByName('a5').DataType:=FtString;
              Parameters.ParamByName('a5').Value := PathListUrl;
              Parameters.ParamByName('a6').DataType:=FtString;
              Parameters.ParamByName('a6').Value := GameMonUrl;
              Parameters.ParamByName('a7').DataType:=FtString;
              Parameters.ParamByName('a7').Value := EWebUrl;
              Parameters.ParamByName('a8').DataType:=FtString;
              Parameters.ParamByName('a8').Value := GatePass;
              Parameters.ParamByName('a9').DataType:=FtString;
              sKey := RandomGetKey;
              Parameters.ParamByName('a9').Value := sKey;
              Parameters.ParamByName('a10').DataType:=FtString;
              Parameters.ParamByName('a10').Value := ''; //�����û�
              Parameters.ParamByName('a11').DataType:=FtDateTime;
              Parameters.ParamByName('a11').Value := Now();
              Parameters.ParamByName('a12').DataType:=FtInteger;
              Parameters.ParamByName('a12').Value := 0;
              ExecSQL;
            except
              btCheckCode := 5;  //δ֪�쳣
            end;
          end;
      end else btCheckCode := 3; //�û�����
    finally
      Ado.Free;
    end;

    if btCheckCode = 1 then begin
      Str := '�𾴵��û�����ӭ����IGE��½��'  + #13 + #10 +
             '�뵽www.IgeM2.com������ҵ��������' + #13 + #10 +
             '���ܺ���ĵ�½���ʺš����롢��Կ����ʧ���и���,�뾡���޸Ĵ�����' + #13 + #10 +
             '' + #13 + #10 +
             '�û���½�ʺţ�' + UserLoginID + #13 + #10 +
             '�û���½���룺' + sPass + #13 + #10 +
             '�û���Կ��' + sKey;
      Clipbrd.Clipboard.AsText := str ;
      Application.MessageBox(PChar('ע��ɹ���' + #13 + '�Ѿ������Լ��������������ݣ��뷢���û�' + #10 + Str), '��ʾ', MB_OK +
        MB_ICONINFORMATION);
    end else begin
      case btCheckCode of
        3: Application.MessageBox('This ID already exists!', 'Error', MB_OK +MB_ICONSTOP);
        5: Application.MessageBox('Unknown error!', 'Error', MB_OK +MB_ICONSTOP);
      end;
    end;
  end;
end;

end.

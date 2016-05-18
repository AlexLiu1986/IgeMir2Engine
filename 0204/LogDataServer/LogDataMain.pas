unit LogDataMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, IniFiles, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer, IdSocketHandle, Menus, DB, ADODB, IdGlobal;

type
  TFrmLogData = class(TForm)
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    IdUDPServerLog: TIdUDPServer;
    StartTimer: TTimer;
    MainMenu1: TMainMenu;
    V1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    A1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure WriteLogFile();
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure StartTimerTimer(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IdUDPServerLogUDPRead(AThread: TIdUDPListenerThread; AData: TIdBytes; ABinding: TIdSocketHandle);
  private
    LogMsgList: TStringList;
    m_boRemoteClose: Boolean;
    { Private declarations }
   //д������
  procedure WriteAccess(FileName,s0, s1, s2, s3, s4, s5, s6, s7, s8: String);
  public
   //����Access�ļ�������ļ�������ʧ��
    function CreateAccessFile(FileName:String;PassWord:string=''):boolean;
    //�������ݿ�
    procedure ConnectedAccess(FileName:String;PassWord:string='');
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
   //�жϱ��Ƿ����(���쳣�ж�)
   function TableExists(log:string):Boolean;  
    { Public declarations }
  end;

var
  FrmLogData: TFrmLogData;
  sLogFile: String;
  boBusy: Boolean = false;//20080928 �����ж�TTimer �Ƿ�����
  boIsRaedLog: Boolean = false;//20080928 �Ƿ��ڽ�����־
//���������ַ���
Const
SConnectionString = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;'
                  +'Jet OLEDB:Database Password=%s;';
implementation

uses LDShare, Grobal2, HUtil32,ComObj,ActiveX,LogSelect,DM,About;

{$R *.DFM}
//-----------------------------MDB���ݿ����-----------------------------------
//�������ݿ�
procedure TFrmLogData.ConnectedAccess(FileName:String;PassWord:string='');
begin
with DMFrm.ADOconn do
 begin
  ConnectionString:=format(SConnectionString,[FileName,PassWord]);
  connected:=true;
 end;
end;

//д������
procedure TFrmLogData.WriteAccess(FileName,s0, s1, s2, s3, s4, s5, s6, s7, s8: String);
var Str2:string;
begin
  Str2:=s0;
  if not DMFrm.ADOconn.Connected then ConnectedAccess(FileName,'');
  case strtoint(s0) of
    0:Str2:='ȡ����Ʒ';//ȡ����Ʒ
    1:Str2:='�����Ʒ';//�����Ʒ
    2:Str2:='����ҩƷ';//����ҩƷ
    3:Str2:='�־���ʧ';//�־���ʧ
    4:Str2:='������Ʒ';//������Ʒ
    5:Str2:='������Ʒ';//������Ʒ
    6:Str2:='�ٵ���Ʒ';//�ٵ���Ʒ
    7:Str2:='�ӵ���Ʒ';//�ӵ���Ʒ
    8:Str2:='������Ʒ';//������Ʒ
    9:Str2:='������Ʒ'; //������Ʒ
    10:Str2:='������Ʒ';//������Ʒ
    11:Str2:='ʹ����Ʒ';//ʹ����Ʒ
    12:Str2:='��������';//��������
    13:Str2:='���ٽ��';//���ٽ��
    14:Str2:='���ӽ��';//���ӽ��
    15:Str2:='��������';//��������
    16:Str2:='������Ʒ';//������Ʒ
    17:Str2:='�ȼ�����';//�ȼ�����
    18:Str2:='��Ч����';//��Ч����
    19:Str2:='��������';//��������
    20:Str2:='�����ɹ�';//�����ɹ�
    21:Str2:='����ʧ��';//����ʧ��
    22:Str2:='�Ǳ�ȡǮ';//�Ǳ�ȡǮ
    23:Str2:='�Ǳ���Ǯ';//�Ǳ���Ǯ
    24:Str2:='����ȡ��';//����ȡ��
    25:Str2:='��������';//��������
    26:Str2:='��������';//��������
    27:Str2:='�ı����';//�ı����
    28:Str2:='Ԫ���ı�';//Ԫ���ı�
    29:Str2:='�����ı�';//�����ı�
    30:Str2:='���̹���';//���̹���
    31:Str2:='װ������';//װ������
    32:Str2:='������Ʒ';//������Ʒ
    33:Str2:='���۹���';//���۹���
    34:Str2:='�����̵�';//�����̵�
    35:Str2:='�л��Ȫ';//�л��Ȫ
    36:Str2:='��ս��Ʒ';//��ս��Ʒ
    37:Str2:='�����ι�';//�����ι�
    38:Str2:='NPC ���';//NPC ���
    39:Str2:='��ÿ�ʯ';//��ÿ�ʯ
    40:Str2:='��������';
    41:Str2:='������Ʒ';
    111,112,113,114,115,116:Str2:='�ɳ��ı�';
  end;

  with DMFrm.ADOQuery1 do begin
    close;
    SQL.Clear;
    SQL.Add('Insert Into Log (����,��ͼ,X����,Y����,');
    SQL.Add('��������,��Ʒ����,��ƷID,��¼,���׶���,ʱ��)');
    SQL.Add('  Values(:a0,:a1,:a2,:a3,:a4,:a5,:a6,:a7,:a8,:a9)');
    parameters.ParamByName('a0').DataType:=Ftstring;
    parameters.ParamByName('a0').Value :=Trim(Str2);
    parameters.ParamByName('a1').DataType :=Ftstring;
    parameters.ParamByName('a1').Value :=Trim(s1);
    parameters.ParamByName('a2').DataType:=Ftinteger;
    parameters.ParamByName('a2').Value :=strToint(Trim(s2));
    parameters.ParamByName('a3').DataType :=Ftinteger;
    parameters.ParamByName('a3').Value :=strToint(Trim(s3));
    parameters.ParamByName('a4').DataType :=Ftstring;
    parameters.ParamByName('a4').Value :=Trim(s4);
    parameters.ParamByName('a5').DataType :=Ftstring;
    parameters.ParamByName('a5').Value :=Trim(s5);
    parameters.ParamByName('a6').DataType :=Ftstring;
    parameters.ParamByName('a6').Value :=Trim(s6);
    parameters.ParamByName('a7').DataType :=Ftstring;
    parameters.ParamByName('a7').Value :=Trim(s7);
    parameters.ParamByName('a8').DataType :=Ftstring;
    parameters.ParamByName('a8').Value :=Trim(s8);
    parameters.ParamByName('a9').DataType :=Ftdate;
    parameters.ParamByName('a9').Value :=now();
    ExecSQL;
  end;
end;

//�жϱ��Ƿ����(���쳣�ж�)
function TFrmLogData.TableExists(log:string):Boolean;
begin
  Result:=False;
  try
   with DMFrm.ADOQuery1 do
     begin
      close;
      SQL.Clear;
      SQL.Add('select top 1 ���� from '+log);
      open;
      Result:=True;
     end;
  except
    Result:=False;
  end;
end;

function GetTempPathFileName():string;
//ȡ����ʱ�ļ���
var
  SPath,SFile:array [0..254] of char;
begin
  GetTempPath(254,SPath);
  GetTempFileName(SPath,'~SM',0,SFile);
  result:=SFile;
  DeleteFile(PChar(result));
end;

//����Access�ļ�������ļ�������ʧ��
function TFrmLogData.CreateAccessFile(FileName:String;PassWord:string=''):boolean;
var
  STempFileName:string;
  vCatalog:OleVariant;
begin
  STempFileName:=GetTempPathFileName;
  try
    vCatalog:=CreateOleObject('ADOX.Catalog');
    vCatalog.Create(format(SConnectionString,[STempFileName,PassWord]));
    result:=CopyFile(PChar(STempFileName),PChar(FileName),True);
    DeleteFile(STempFileName);
  except
    result:=false;
  end;
end;

//--------------------------------------------------------------------------

procedure TFrmLogData.FormCreate(Sender: TObject);
var
  nX, nY: Integer;
begin
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  nX := Str_ToInt(ParamStr(2), -1);
  nY := Str_ToInt(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;

  m_boRemoteClose := False;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  SendGameCenterMsg(SG_STARTNOW, '����������־������...');
  LogMsgList := TStringList.Create;
  StartTimer.Enabled := True;
end;

procedure TFrmLogData.FormDestroy(Sender: TObject);
begin
  LogMsgList.Free;
end;

procedure TFrmLogData.IdUDPServerLogUDPRead(AThread: TIdUDPListenerThread; AData: TIdBytes; ABinding: TIdSocketHandle);
var
  LogStr: String absolute AData;
begin
  LogMsgList.Add(LogStr);
end;

procedure TFrmLogData.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if m_boRemoteClose then exit;
  if Application.MessageBox('�Ƿ�ȷ���˳���������',
    '��ʾ��Ϣ',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
  end else CanClose := False;
end;

procedure TFrmLogData.Timer1Timer(Sender: TObject);
begin
  if boBusy then Exit;
  boBusy:= True;
  try
    WriteLogFile();
  finally
    boBusy:= False;
  end;
end;


procedure TFrmLogData.WriteLogFile();
var
  I: Integer;
  Year, Month, Day: Word;
  S10,s0, s1, s2, s3, s4, s5, s6, s7, s8, sA,sB,sC: String;
begin
try
  DecodeDate(Date, Year, Month, Day);

//Ŀ¼������,�򴴽�Ŀ¼
  if not FileExists(sBaseDir) then CreateDirectoryA(PChar(sBaseDir), nil);

  sLogFile :=sBaseDir + IntToStr(Year) + '-' + IntToString(Month) + '-' + IntToString(Day)+ '.mdb';
  Label4.Caption := sLogFile;

  //��־�ļ�������,�򴴽�
  if not FileExists(sLogFile) then begin
    DMFrm.ADOconn.Connected:=False;
    CreateAccessFile(sLogFile,'');
  end;
  //���û���������ݿ�,���������ݿ�
  if not DMFrm.ADOconn.Connected then ConnectedAccess(sLogFile,''); //�������ݿ�

//��־�ļ�����
  if FileExists(sLogFile) then begin
   if (not TableExists('Log')) then begin //������,�򴴽���
     with DMFrm.ADOQuery1 do begin //�������ݱ�
       close;
       SQL.Clear;
       SQL.Add('Create Table Log (��� Counter,���� string,��ͼ string,X���� integer,Y���� integer,');
       SQL.Add('�������� string,��Ʒ����  string,��ƷID  string,��¼  string,���׶���  string,ʱ�� DateTime)');
       ExecSQL;
     end;
   end else begin //д������
     for I := LogMsgList.Count - 1 downto 0 do begin //��������
       if (LogMsgList.Count <= 0) or boIsRaedLog then Break;
       s10 := LogMsgList.Strings[I];
       if (s10 <> '') then begin
          s10 := GetValidStr3(s10, sA, ['	']);
          s10 := GetValidStr3(s10, sB, ['	']);
          s10 := GetValidStr3(s10, sC, ['	']);
          s10 := GetValidStr3(s10, s0, ['	']);
          s10 := GetValidStr3(s10, s1, ['	']);
          s10 := GetValidStr3(s10, s2, ['	']);
          s10 := GetValidStr3(s10, s3, ['	']);
          s10 := GetValidStr3(s10, s4, ['	']);
          s10 := GetValidStr3(s10, s5, ['	']);
          s10 := GetValidStr3(s10, s6, ['	']);
          s10 := GetValidStr3(s10, s7, ['	']);
          s10 := GetValidStr3(s10, s8, ['	']);
          if (S0<>'') and  (s1 <> '') and (s2 <> '') and (s3 <> '') and
             (S4<>'') and  (s5 <> '') and (s6 <> '') and (s7 <> '') and
             (s8 <> '') then begin
              if boIsRaedLog then Break;
             //д�����ݱ�
              WriteAccess(sLogFile, s0, s1, s2, s3, s4, s5, s6, s7, s8);
              LogMsgList.Delete(I);//20080928 �޸�
             end;
       end;
     end;
     //LogMsgList.Clear;//20080928 ע��
    end;
  end;
  except
    
  end;
end;

procedure TFrmLogData.MyMessage(var MsgData: TWmCopyData);
var
  sData: String;
  //ProgramType: TProgamType;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  //  ProgramType:=TProgamType(LoWord(MsgData.From));
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of //
    GS_QUIT: begin
        m_boRemoteClose := True;
        Close();
      end;
    1: ;
    2: ;
    3: ;
  end; // case
end;

procedure TFrmLogData.StartTimerTimer(Sender: TObject);
var
  Conf: TIniFile;
  boMinimize: Boolean;
begin
  boMinimize:= False;
  StartTimer.Enabled := False;
  Conf := TIniFile.Create('.\LogData.ini');
  if Conf <> nil then begin
    sBaseDir := Conf.ReadString('Setup', 'BaseDir', sBaseDir);
    sServerName := Conf.ReadString('Setup', 'Caption', sServerName);
    sServerName := Conf.ReadString('Setup', 'ServerName', sServerName);
    nServerPort := Conf.ReadInteger('Setup', 'Port', nServerPort);
    boMinimize := Conf.ReadBool('Setup', 'Minimize', True);
    Conf.Free;
  end;
  Caption := sCaption + ' (' + sServerName + ')';
  IdUDPServerLog.DefaultPort := nServerPort;
  try
    IdUDPServerLog.Active := True;
  except
    Application.MessageBox(PChar(IntToStr(nServerPort)+'�˿ڱ�ռ�á�'), '��ʾ', MB_OK + MB_ICONSTOP);
  end;
  if boMinimize then Application.Minimize;//��С������
  SendGameCenterMsg(SG_STARTOK, '��־�������������...');
end;

procedure TFrmLogData.N1Click(Sender: TObject);
begin
  LogFrm := TLogFrm.Create(Owner);
  LogFrm.ShowModal;
  LogFrm.Free;
end;

procedure TFrmLogData.A1Click(Sender: TObject);
begin
  AboutFrm := TAboutFrm.Create(Owner);
  AboutFrm.Open();
  AboutFrm.Free;
end;

procedure TFrmLogData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Application.Terminate;
end;

end.


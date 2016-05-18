unit GameCommand;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  Grids, ComCtrls, StdCtrls, Spin, Grobal2;

type
  TfrmGameCmd = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    StringGridGameCmd: TStringGrid;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditUserCmdName: TEdit;
    EditUserCmdPerMission: TSpinEdit;
    Label6: TLabel;
    EditUserCmdOK: TButton;
    LabelUserCmdFunc: TLabel;
    LabelUserCmdParam: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditUserCmdSave: TButton;
    StringGridGameMasterCmd: TStringGrid;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    LabelGameMasterCmdFunc: TLabel;
    LabelGameMasterCmdParam: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditGameMasterCmdName: TEdit;
    EditGameMasterCmdPerMission: TSpinEdit;
    EditGameMasterCmdOK: TButton;
    EditGameMasterCmdSave: TButton;
    StringGridGameDebugCmd: TStringGrid;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    LabelGameDebugCmdFunc: TLabel;
    LabelGameDebugCmdParam: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EditGameDebugCmdName: TEdit;
    EditGameDebugCmdPerMission: TSpinEdit;
    EditGameDebugCmdOK: TButton;
    EditGameDebugCmdSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure StringGridGameCmdClick(Sender: TObject);
    procedure EditUserCmdNameChange(Sender: TObject);
    procedure EditUserCmdPerMissionChange(Sender: TObject);
    procedure EditUserCmdOKClick(Sender: TObject);
    procedure EditUserCmdSaveClick(Sender: TObject);
    procedure StringGridGameMasterCmdClick(Sender: TObject);
    procedure EditGameMasterCmdNameChange(Sender: TObject);
    procedure EditGameMasterCmdPerMissionChange(Sender: TObject);
    procedure EditGameMasterCmdOKClick(Sender: TObject);
    procedure StringGridGameDebugCmdClick(Sender: TObject);
    procedure EditGameDebugCmdNameChange(Sender: TObject);
    procedure EditGameDebugCmdPerMissionChange(Sender: TObject);
    procedure EditGameDebugCmdOKClick(Sender: TObject);
    procedure EditGameMasterCmdSaveClick(Sender: TObject);
    procedure EditGameDebugCmdSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    nRefGameUserIndex: Integer;
    nRefGameMasterIndex: Integer;
    nRefGameDebugIndex: Integer;
    procedure RefUserCommand();
    procedure RefGameMasterCommand();
    procedure RefGameMasterCmd(GameCmd: pTGameCmd; sCmdParam, sDesc: string);
    procedure RefDebugCommand();
    procedure RefGameDebugCmd(GameCmd: pTGameCmd; sCmdParam,
      sDesc: string);
    procedure RefGameUserCmd(GameCmd: pTGameCmd; sCmdParam, sDesc: string);
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmGameCmd: TfrmGameCmd;

implementation

uses M2Share;

{$R *.dfm}


procedure TfrmGameCmd.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  StringGridGameCmd.RowCount := 50;
  StringGridGameCmd.Cells[0, 0] := '��Ϸ����';
  StringGridGameCmd.Cells[1, 0] := '����Ȩ��';
  StringGridGameCmd.Cells[2, 0] := '�����ʽ';
  StringGridGameCmd.Cells[3, 0] := '����˵��';

  StringGridGameMasterCmd.RowCount := 105;
  StringGridGameMasterCmd.Cells[0, 0] := '��Ϸ����';
  StringGridGameMasterCmd.Cells[1, 0] := '����Ȩ��';
  StringGridGameMasterCmd.Cells[2, 0] := '�����ʽ';
  StringGridGameMasterCmd.Cells[3, 0] := '����˵��';

  StringGridGameDebugCmd.RowCount := 41;
  StringGridGameDebugCmd.Cells[0, 0] := '��Ϸ����';
  StringGridGameDebugCmd.Cells[1, 0] := '����Ȩ��';
  StringGridGameDebugCmd.Cells[2, 0] := '�����ʽ';
  StringGridGameDebugCmd.Cells[3, 0] := '����˵��';


end;

procedure TfrmGameCmd.Open;
begin
  RefUserCommand();
  RefGameMasterCommand();
  RefDebugCommand();
  ShowModal;
end;
procedure TfrmGameCmd.RefGameUserCmd(GameCmd: pTGameCmd; sCmdParam, sDesc: string);
begin
  Inc(nRefGameUserIndex);
  if StringGridGameCmd.RowCount - 1 < nRefGameUserIndex then begin
    StringGridGameCmd.RowCount := nRefGameUserIndex + 1;
  end;

  StringGridGameCmd.Cells[0, nRefGameUserIndex] := GameCmd.sCmd;
  StringGridGameCmd.Cells[1, nRefGameUserIndex] := IntToStr(GameCmd.nPermissionMin) + '/' + IntToStr(GameCmd.nPermissionMax);
  StringGridGameCmd.Cells[2, nRefGameUserIndex] := sCmdParam;
  StringGridGameCmd.Cells[3, nRefGameUserIndex] := sDesc;
  StringGridGameCmd.Objects[0, nRefGameUserIndex] := TObject(GameCmd);
end;




//  StringGridGameCmd.Cells[3,12]:='δʹ��';
//  StringGridGameCmd.Cells[3,13]:='�ƶ���ͼָ������(��Ҫ������װ��)';
//  StringGridGameCmd.Cells[3,14]:='̽����������λ��(��Ҫ������װ��)';
//  StringGridGameCmd.Cells[3,15]:='������䴫��';
//  StringGridGameCmd.Cells[3,16]:='�������Ա���͵����(��Ҫ������ȫ��װ��)';
//  StringGridGameCmd.Cells[3,17]:='�����лᴫ��';
//  StringGridGameCmd.Cells[3,18]:='���л��Ա�������(��Ҫ���лᴫ��װ��)';
//  StringGridGameCmd.Cells[3,19]:='�����ֿ�������';
//  StringGridGameCmd.Cells[3,20]:='������¼������';
//  StringGridGameCmd.Cells[3,21]:='���ֿ���������';
//  StringGridGameCmd.Cells[3,22]:='���òֿ�����';
//  StringGridGameCmd.Cells[3,23]:='�޸Ĳֿ�����';
//  StringGridGameCmd.Cells[3,24]:='�������(�ȿ������������)';
//  StringGridGameCmd.Cells[3,25]:='δʹ��';
//  StringGridGameCmd.Cells[3,26]:='��ѯ����λ��';
//  StringGridGameCmd.Cells[3,27]:='������޴���';
//  StringGridGameCmd.Cells[3,28]:='���޽��Է����͵����';
//  StringGridGameCmd.Cells[3,29]:='��ѯʦͽλ��';
//  StringGridGameCmd.Cells[3,30]:='����ʦͽ����';
//  StringGridGameCmd.Cells[3,31]:='ʦ����ͽ���ٻ������';
//  StringGridGameCmd.Cells[3,32]:='��������ģʽ(�����Ҫ�޸�)';
//  StringGridGameCmd.Cells[3,33]:='��������״̬(�����Ҫ�޸�)';
//  StringGridGameCmd.Cells[3,34]:='�����ƺ�������';
//  StringGridGameCmd.Cells[3,35]:='����������';
//  StringGridGameCmd.Cells[3,36]:='';
//  StringGridGameCmd.Cells[3,37]:='����/�رյ�¼��';
procedure TfrmGameCmd.RefUserCommand;
begin
  EditUserCmdOK.Enabled := False;
  nRefGameUserIndex := 0;

  RefGameUserCmd(@g_GameCommand.Data,
    '@' + g_GameCommand.Data.sCmd,
    '�鿴��ǰ����������ʱ��');
  RefGameUserCmd(@g_GameCommand.PRVMSG,
    '@' + g_GameCommand.PRVMSG.sCmd,
    '��ָֹ�����﷢��˽����Ϣ');
  RefGameUserCmd(@g_GameCommand.ALLOWMSG,
    '@' + g_GameCommand.ALLOWMSG.sCmd,
    '��ֹ�������Լ���˽����Ϣ');
  RefGameUserCmd(@g_GameCommand.LETSHOUT,
    '@' + g_GameCommand.LETSHOUT.sCmd,
    '��ֹ�������������Ϣ');
{  RefGameUserCmd(@g_GameCommand.BANGMMSG, //�ܾ����к�����Ϣ 20080211
    '@' + g_GameCommand.BANGMMSG.sCmd,
    '��ֹ�������к�����Ϣ');  }
  RefGameUserCmd(@g_GameCommand.LETTRADE,
    '@' + g_GameCommand.LETTRADE.sCmd,
    '��ֹ���׽�����Ʒ');
  RefGameUserCmd(@g_GameCommand.LETGUILD,
    '@' + g_GameCommand.LETGUILD.sCmd,
    '��������л�');
  RefGameUserCmd(@g_GameCommand.ENDGUILD,
    '@' + g_GameCommand.ENDGUILD.sCmd,
    '�˳���ǰ��������л�');
  RefGameUserCmd(@g_GameCommand.BANGUILDCHAT,
    '@' + g_GameCommand.BANGUILDCHAT.sCmd,
    '��ֹ�����л�������Ϣ');
  RefGameUserCmd(@g_GameCommand.AUTHALLY,
    '@' + g_GameCommand.AUTHALLY.sCmd,
    '���л��������');
  RefGameUserCmd(@g_GameCommand.AUTH,
    '@' + g_GameCommand.AUTH.sCmd,
    '��ʼ�����л�����(�����ʽ��Ϊ@Alliance,������Ϸ�����޷�����)');
  RefGameUserCmd(@g_GameCommand.AUTHCANCEL,
    '@' + g_GameCommand.AUTHCANCEL.sCmd,
    'ȡ���л����˹�ϵ(�����ʽ��Ϊ@CancelAlliance,������Ϸ�����޷�ȡ������)');
 // Exit;//20080823

  RefGameUserCmd(@g_GameCommand.USERMOVE,
    '@' + g_GameCommand.USERMOVE.sCmd + '  ����X  ����Y',
    '���͵�ָ������');

  RefGameUserCmd(@g_GameCommand.SEARCHING,
    '@' + g_GameCommand.SEARCHING.sCmd + ' ��������',
    '̽��ָ�������ںδ�');

  RefGameUserCmd(@g_GameCommand.ALLOWGROUPCALL,
    '@' + g_GameCommand.ALLOWGROUPCALL.sCmd ,
    '������غ�һ(����������������ֹ���鴫�͹���)');

  RefGameUserCmd(@g_GameCommand.GROUPRECALLL,
    '@' + g_GameCommand.GROUPRECALLL.sCmd,
    '��غ�һ');

  RefGameUserCmd(@g_GameCommand.ALLOWGUILDRECALL,
    '@' + g_GameCommand.ALLOWGUILDRECALL.sCmd,
    '�����л��һ(�лᴫ�ͣ��л������˿��Խ������л��Աȫ������)');

  RefGameUserCmd(@g_GameCommand.GUILDRECALLL,
    '@' + g_GameCommand.GUILDRECALLL.sCmd,
    '�л��һ');

  RefGameUserCmd(@g_GameCommand.UNLOCKSTORAGE,
    '@' + g_GameCommand.UNLOCKSTORAGE.sCmd,
    '�ֿ⿪��');

  RefGameUserCmd(@g_GameCommand.UnLock,
    '@' + g_GameCommand.UnLock.sCmd,
    '����');

  RefGameUserCmd(@g_GameCommand.Lock,
    '@' + g_GameCommand.Lock.sCmd,
    '�����ֿ�');

  RefGameUserCmd(@g_GameCommand.SETPASSWORD,
    '@' + g_GameCommand.SETPASSWORD.sCmd,
    '��������');

  RefGameUserCmd(@g_GameCommand.CHGPASSWORD,
    '@' + g_GameCommand.CHGPASSWORD.sCmd,
    '�޸�����');

  RefGameUserCmd(@g_GameCommand.UNPASSWORD,
    '@' + g_GameCommand.UNPASSWORD.sCmd,
    '�������');

  RefGameUserCmd(@g_GameCommand.MEMBERFUNCTION,
    '@' + g_GameCommand.MEMBERFUNCTION.sCmd,
    '�򿪻�Ա���ܴ���(QManage-[@Member])');

  RefGameUserCmd(@g_GameCommand.DEAR,
    '@' + g_GameCommand.DEAR.sCmd+ ' ��������',
    '���������ڲ�ѯ��ż��ǰ����λ��');

  RefGameUserCmd(@g_GameCommand.ALLOWDEARRCALL,
    '@' + g_GameCommand.ALLOWDEARRCALL.sCmd,
    '������޴���');

  RefGameUserCmd(@g_GameCommand.DEARRECALL,
    '@' + g_GameCommand.DEARRECALL.sCmd,
    '���޴��ͣ����Է����͵��Լ���ߣ��Է�����������');

  RefGameUserCmd(@g_GameCommand.MASTER,
    '@' + g_GameCommand.MASTER.sCmd + ' ��������',
    '���������ڲ�ѯʦͽ��ǰ����λ��');

  RefGameUserCmd(@g_GameCommand.ALLOWMASTERRECALL,
    '@' + g_GameCommand.ALLOWMASTERRECALL.sCmd,
    '����ʦͽ����');

  RefGameUserCmd(@g_GameCommand.MASTERECALL,
    '@' +  g_GameCommand.MASTERECALL.sCmd + ' ��������',
    'ʦͽ����');

  RefGameUserCmd(@g_GameCommand.ATTACKMODE,
    '@' +  g_GameCommand.ATTACKMODE.sCmd ,
    '�ı乥��ģʽ');

  RefGameUserCmd(@g_GameCommand.REST,
    '@' +  g_GameCommand.REST.sCmd ,
    '�ı�����״̬');

  RefGameUserCmd(@g_GameCommand.MEMBERFUNCTIONEX,
    '@' +  g_GameCommand.MEMBERFUNCTIONEX.sCmd ,
    '�򿪻�Ա����(QFunction-[@Member])');

  RefGameUserCmd(@g_GameCommand.LOCKLOGON,
    '@' +  g_GameCommand.LOCKLOGON.sCmd ,
    '���õ�¼������');

{  RefGameUserCmd(@g_GameCommand.REMTEMSG,
    '@' +  g_GameCommand.REMTEMSG.sCmd ,
    '���������Ϣ(���)');  }
                          
{ //δʹ�� 20080823
  StringGridGameCmd.Cells[0, 12] := g_GameCommand.DIARY.sCmd;
  StringGridGameCmd.Cells[1, 12] := IntToStr(g_GameCommand.DIARY.nPermissionMin);
  StringGridGameCmd.Cells[2, 12] := '@' + g_GameCommand.DIARY.sCmd;
  StringGridGameCmd.Objects[0, 12] := TObject(@g_GameCommand.DIARY);}

{  StringGridGameCmd.Cells[0, 13] := g_GameCommand.USERMOVE.sCmd;
  StringGridGameCmd.Cells[1, 13] := IntToStr(g_GameCommand.USERMOVE.nPermissionMin);
  StringGridGameCmd.Cells[2, 13] := '@' + g_GameCommand.USERMOVE.sCmd;
  StringGridGameCmd.Objects[0, 13] := TObject(@g_GameCommand.USERMOVE);

  StringGridGameCmd.Cells[0, 14] := g_GameCommand.SEARCHING.sCmd;
  StringGridGameCmd.Cells[1, 14] := IntToStr(g_GameCommand.SEARCHING.nPermissionMin);
  StringGridGameCmd.Cells[2, 14] := '@' + g_GameCommand.SEARCHING.sCmd;
  StringGridGameCmd.Objects[0, 14] := TObject(@g_GameCommand.SEARCHING); 

  StringGridGameCmd.Cells[0, 15] := g_GameCommand.ALLOWGROUPCALL.sCmd;//������غ�һ
  StringGridGameCmd.Cells[1, 15] := IntToStr(g_GameCommand.ALLOWGROUPCALL.nPermissionMin);
  StringGridGameCmd.Cells[2, 15] := '@' + g_GameCommand.ALLOWGROUPCALL.sCmd;
  StringGridGameCmd.Objects[0, 15] := TObject(@g_GameCommand.ALLOWGROUPCALL); 

  StringGridGameCmd.Cells[0, 16] := g_GameCommand.GROUPRECALLL.sCmd;//��غ�һ
  StringGridGameCmd.Cells[1, 16] := IntToStr(g_GameCommand.GROUPRECALLL.nPermissionMin);
  StringGridGameCmd.Cells[2, 16] := '@' + g_GameCommand.GROUPRECALLL.sCmd;
  StringGridGameCmd.Objects[0, 16] := TObject(@g_GameCommand.GROUPRECALLL); 

  StringGridGameCmd.Cells[0, 17] := g_GameCommand.ALLOWGUILDRECALL.sCmd;//�����л��һ
  StringGridGameCmd.Cells[1, 17] := IntToStr(g_GameCommand.ALLOWGUILDRECALL.nPermissionMin);
  StringGridGameCmd.Cells[2, 17] := '@' + g_GameCommand.ALLOWGUILDRECALL.sCmd;
  StringGridGameCmd.Objects[0, 17] := TObject(@g_GameCommand.ALLOWGUILDRECALL);  

  StringGridGameCmd.Cells[0, 18] := g_GameCommand.GUILDRECALLL.sCmd;//�л��һ
  StringGridGameCmd.Cells[1, 18] := IntToStr(g_GameCommand.GUILDRECALLL.nPermissionMin);
  StringGridGameCmd.Cells[2, 18] := '@' + g_GameCommand.GUILDRECALLL.sCmd;
  StringGridGameCmd.Objects[0, 18] := TObject(@g_GameCommand.GUILDRECALLL);

  StringGridGameCmd.Cells[0, 19] := g_GameCommand.UNLOCKSTORAGE.sCmd;//�ֿ⿪��
  StringGridGameCmd.Cells[1, 19] := IntToStr(g_GameCommand.UNLOCKSTORAGE.nPermissionMin);
  StringGridGameCmd.Cells[2, 19] := '@' + g_GameCommand.UNLOCKSTORAGE.sCmd;
  StringGridGameCmd.Objects[0, 19] := TObject(@g_GameCommand.UNLOCKSTORAGE);

  StringGridGameCmd.Cells[0, 20] := g_GameCommand.UnLock.sCmd;//����
  StringGridGameCmd.Cells[1, 20] := IntToStr(g_GameCommand.UnLock.nPermissionMin);
  StringGridGameCmd.Cells[2, 20] := '@' + g_GameCommand.UnLock.sCmd;
  StringGridGameCmd.Objects[0, 20] := TObject(@g_GameCommand.UnLock);

  StringGridGameCmd.Cells[0, 21] := g_GameCommand.Lock.sCmd;//�����ֿ�
  StringGridGameCmd.Cells[1, 21] := IntToStr(g_GameCommand.Lock.nPermissionMin);
  StringGridGameCmd.Cells[2, 21] := '@' + g_GameCommand.Lock.sCmd;
  StringGridGameCmd.Objects[0, 21] := TObject(@g_GameCommand.Lock); 

  StringGridGameCmd.Cells[0, 22] := g_GameCommand.SETPASSWORD.sCmd;//��������
  StringGridGameCmd.Cells[1, 22] := IntToStr(g_GameCommand.SETPASSWORD.nPermissionMin);
  StringGridGameCmd.Cells[2, 22] := '@' + g_GameCommand.SETPASSWORD.sCmd;
  StringGridGameCmd.Objects[0, 22] := TObject(@g_GameCommand.SETPASSWORD); 

  StringGridGameCmd.Cells[0, 23] := g_GameCommand.CHGPASSWORD.sCmd;//�޸�����
  StringGridGameCmd.Cells[1, 23] := IntToStr(g_GameCommand.CHGPASSWORD.nPermissionMin);
  StringGridGameCmd.Cells[2, 23] := '@' + g_GameCommand.CHGPASSWORD.sCmd;
  StringGridGameCmd.Objects[0, 23] := TObject(@g_GameCommand.CHGPASSWORD);

  StringGridGameCmd.Cells[0, 24] := g_GameCommand.UNPASSWORD.sCmd;//�������
  StringGridGameCmd.Cells[1, 24] := IntToStr(g_GameCommand.UNPASSWORD.nPermissionMin);
  StringGridGameCmd.Cells[2, 24] := '@' + g_GameCommand.UNPASSWORD.sCmd;
  StringGridGameCmd.Objects[0, 24] := TObject(@g_GameCommand.UNPASSWORD); 

  StringGridGameCmd.Cells[0, 25] := g_GameCommand.MEMBERFUNCTION.sCmd;//��̨����
  StringGridGameCmd.Cells[1, 25] := IntToStr(g_GameCommand.MEMBERFUNCTION.nPermissionMin);
  StringGridGameCmd.Cells[2, 25] := '@' + g_GameCommand.MEMBERFUNCTION.sCmd;
  StringGridGameCmd.Objects[0, 25] := TObject(@g_GameCommand.MEMBERFUNCTION);

  StringGridGameCmd.Cells[0, 26] := g_GameCommand.DEAR.sCmd;//���������ڲ�ѯ��ż��ǰ����λ��
  StringGridGameCmd.Cells[1, 26] := IntToStr(g_GameCommand.DEAR.nPermissionMin);
  StringGridGameCmd.Cells[2, 26] := '@' + g_GameCommand.DEAR.sCmd;
  StringGridGameCmd.Objects[0, 26] := TObject(@g_GameCommand.DEAR); 

  StringGridGameCmd.Cells[0, 27] := g_GameCommand.ALLOWDEARRCALL.sCmd;//������޴���
  StringGridGameCmd.Cells[1, 27] := IntToStr(g_GameCommand.ALLOWDEARRCALL.nPermissionMin);
  StringGridGameCmd.Cells[2, 27] := '@' + g_GameCommand.ALLOWDEARRCALL.sCmd;
  StringGridGameCmd.Objects[0, 27] := TObject(@g_GameCommand.ALLOWDEARRCALL);

  StringGridGameCmd.Cells[0, 28] := g_GameCommand.DEARRECALL.sCmd;//���޴���
  StringGridGameCmd.Cells[1, 28] := IntToStr(g_GameCommand.DEARRECALL.nPermissionMin);
  StringGridGameCmd.Cells[2, 28] := '@' + g_GameCommand.DEARRECALL.sCmd;
  StringGridGameCmd.Objects[0, 28] := TObject(@g_GameCommand.DEARRECALL); 

  StringGridGameCmd.Cells[0, 29] := g_GameCommand.MASTER.sCmd;//���������ڲ�ѯʦͽ��ǰ����λ��
  StringGridGameCmd.Cells[1, 29] := IntToStr(g_GameCommand.MASTER.nPermissionMin);
  StringGridGameCmd.Cells[2, 29] := '@' + g_GameCommand.MASTER.sCmd;
  StringGridGameCmd.Objects[0, 29] := TObject(@g_GameCommand.MASTER);  

  StringGridGameCmd.Cells[0, 30] := g_GameCommand.ALLOWMASTERRECALL.sCmd;//����ʦͽ����
  StringGridGameCmd.Cells[1, 30] := IntToStr(g_GameCommand.ALLOWMASTERRECALL.nPermissionMin);
  StringGridGameCmd.Cells[2, 30] := '@' + g_GameCommand.ALLOWMASTERRECALL.sCmd;
  StringGridGameCmd.Objects[0, 30] := TObject(@g_GameCommand.ALLOWMASTERRECALL); 

  StringGridGameCmd.Cells[0, 31] := g_GameCommand.MASTERECALL.sCmd;//ʦͽ����
  StringGridGameCmd.Cells[1, 31] := IntToStr(g_GameCommand.MASTERECALL.nPermissionMin);
  StringGridGameCmd.Cells[2, 31] := '@' + g_GameCommand.MASTERECALL.sCmd;
  StringGridGameCmd.Objects[0, 31] := TObject(@g_GameCommand.MASTERECALL); 

  StringGridGameCmd.Cells[0, 32] := g_GameCommand.ATTACKMODE.sCmd;//�ı乥��ģʽ
  StringGridGameCmd.Cells[1, 32] := IntToStr(g_GameCommand.ATTACKMODE.nPermissionMin);
  StringGridGameCmd.Cells[2, 32] := '@' + g_GameCommand.ATTACKMODE.sCmd;
  StringGridGameCmd.Objects[0, 32] := TObject(@g_GameCommand.ATTACKMODE);

  StringGridGameCmd.Cells[0, 33] := g_GameCommand.REST.sCmd;//�ı�����״̬
  StringGridGameCmd.Cells[1, 33] := IntToStr(g_GameCommand.REST.nPermissionMin);
  StringGridGameCmd.Cells[2, 33] := '@' + g_GameCommand.REST.sCmd;
  StringGridGameCmd.Objects[0, 33] := TObject(@g_GameCommand.REST);   }

{  StringGridGameCmd.Cells[0, 34] := g_GameCommand.TAKEONHORSE.sCmd;//����
  StringGridGameCmd.Cells[1, 34] := IntToStr(g_GameCommand.TAKEONHORSE.nPermissionMin);
  StringGridGameCmd.Cells[2, 34] := '@' + g_GameCommand.TAKEONHORSE.sCmd;
  StringGridGameCmd.Objects[0, 34] := TObject(@g_GameCommand.TAKEONHORSE);

  StringGridGameCmd.Cells[0, 35] := g_GameCommand.TAKEOFHORSE.sCmd;//����
  StringGridGameCmd.Cells[1, 35] := IntToStr(g_GameCommand.TAKEOFHORSE.nPermissionMin);
  StringGridGameCmd.Cells[2, 35] := '@' + g_GameCommand.TAKEOFHORSE.sCmd;
  StringGridGameCmd.Objects[0, 35] := TObject(@g_GameCommand.TAKEOFHORSE);  }

{  StringGridGameCmd.Cells[0, 36] := g_GameCommand.MEMBERFUNCTIONEX.sCmd;//�򿪻�Ա����
  StringGridGameCmd.Cells[1, 36] := IntToStr(g_GameCommand.MEMBERFUNCTIONEX.nPermissionMin);
  StringGridGameCmd.Cells[2, 36] := '@' + g_GameCommand.MEMBERFUNCTIONEX.sCmd;
  StringGridGameCmd.Objects[0, 36] := TObject(@g_GameCommand.MEMBERFUNCTIONEX); 

  StringGridGameCmd.Cells[0, 37] := g_GameCommand.LOCKLOGON.sCmd;//���õ�¼������
  StringGridGameCmd.Cells[1, 37] := IntToStr(g_GameCommand.LOCKLOGON.nPermissionMin);
  StringGridGameCmd.Cells[2, 37] := '@' + g_GameCommand.LOCKLOGON.sCmd;
  StringGridGameCmd.Objects[0, 37] := TObject(@g_GameCommand.LOCKLOGON); }
end;

procedure TfrmGameCmd.StringGridGameCmdClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
begin
  nIndex := StringGridGameCmd.Row;
  GameCmd := pTGameCmd(StringGridGameCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    EditUserCmdName.Text := GameCmd.sCmd;
    EditUserCmdPerMission.Value := GameCmd.nPermissionMin;
    LabelUserCmdParam.Caption := StringGridGameCmd.Cells[2, nIndex];
    LabelUserCmdFunc.Caption := StringGridGameCmd.Cells[3, nIndex];
  end;
  EditUserCmdOK.Enabled := False;
end;

procedure TfrmGameCmd.EditUserCmdNameChange(Sender: TObject);
begin
  EditUserCmdOK.Enabled := True;
  EditUserCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditUserCmdPerMissionChange(Sender: TObject);
begin
  EditUserCmdOK.Enabled := True;
  EditUserCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditUserCmdOKClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
  sCmd: string;
  nPermission: Integer;
begin
  sCmd := Trim(EditUserCmdName.Text);
  nPermission := EditUserCmdPerMission.Value;
  if sCmd = '' then begin
    Application.MessageBox('�������Ʋ���Ϊ�գ�����', '��ʾ��Ϣ', MB_OK + MB_ICONERROR);
    EditUserCmdName.SetFocus;
    Exit;
  end;

  nIndex := StringGridGameCmd.Row;
  GameCmd := pTGameCmd(StringGridGameCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    GameCmd.sCmd := sCmd;
    GameCmd.nPermissionMin := nPermission;
  end;
  RefUserCommand();
end;

procedure TfrmGameCmd.EditUserCmdSaveClick(Sender: TObject);
begin
  EditUserCmdSave.Enabled := False;
{$IF SoftVersion <> VERDEMO}
  CommandConf.WriteString('Command', 'Date', g_GameCommand.Data.sCmd);
  CommandConf.WriteString('Command', 'PrvMsg', g_GameCommand.PRVMSG.sCmd);
  CommandConf.WriteString('Command', 'AllowMsg', g_GameCommand.ALLOWMSG.sCmd);
  CommandConf.WriteString('Command', 'LetShout', g_GameCommand.LETSHOUT.sCmd);
{  CommandConf.WriteString('Command', 'BanGmMsg', g_GameCommand.BANGMMSG.sCmd);//�ܾ����к�����Ϣ 20080211 }
  CommandConf.WriteString('Command', 'LetTrade', g_GameCommand.LETTRADE.sCmd);
  CommandConf.WriteString('Command', 'LetGuild', g_GameCommand.LETGUILD.sCmd);
  CommandConf.WriteString('Command', 'EndGuild', g_GameCommand.ENDGUILD.sCmd);
  CommandConf.WriteString('Command', 'BanGuildChat', g_GameCommand.BANGUILDCHAT.sCmd);
  CommandConf.WriteString('Command', 'AuthAlly', g_GameCommand.AUTHALLY.sCmd);
  CommandConf.WriteString('Command', 'Auth', g_GameCommand.AUTH.sCmd);
  CommandConf.WriteString('Command', 'AuthCancel', g_GameCommand.AUTHCANCEL.sCmd);
  //CommandConf.WriteString('Command', 'ViewDiary', g_GameCommand.DIARY.sCmd);//δʹ�� 20080823
  CommandConf.WriteString('Command', 'UserMove', g_GameCommand.USERMOVE.sCmd);
  CommandConf.WriteString('Command', 'Searching', g_GameCommand.SEARCHING.sCmd);
  CommandConf.WriteString('Command', 'AllowGroupCall', g_GameCommand.ALLOWGROUPCALL.sCmd);
  CommandConf.WriteString('Command', 'GroupCall', g_GameCommand.GROUPRECALLL.sCmd);
  CommandConf.WriteString('Command', 'AllowGuildReCall', g_GameCommand.ALLOWGUILDRECALL.sCmd);
  CommandConf.WriteString('Command', 'GuildReCall', g_GameCommand.GUILDRECALLL.sCmd);
  CommandConf.WriteString('Command', 'StorageUnLock', g_GameCommand.UNLOCKSTORAGE.sCmd);
  CommandConf.WriteString('Command', 'PasswordUnLock', g_GameCommand.UnLock.sCmd);
  CommandConf.WriteString('Command', 'StorageLock', g_GameCommand.Lock.sCmd);
  CommandConf.WriteString('Command', 'StorageSetPassword', g_GameCommand.SETPASSWORD.sCmd);
  CommandConf.WriteString('Command', 'StorageChgPassword', g_GameCommand.CHGPASSWORD.sCmd);
  //  CommandConf.WriteString('Command','StorageClearPassword',g_GameCommand.CLRPASSWORD.sCmd)
  //  CommandConf.WriteInteger('Permission','StorageClearPassword', g_GameCommand.CLRPASSWORD.nPermissionMin)
  CommandConf.WriteString('Command', 'StorageUserClearPassword', g_GameCommand.UNPASSWORD.sCmd);
  CommandConf.WriteString('Command', 'MemberFunc', g_GameCommand.MEMBERFUNCTION.sCmd);
  CommandConf.WriteString('Command', 'Dear', g_GameCommand.DEAR.sCmd);
  CommandConf.WriteString('Command', 'Master', g_GameCommand.MASTER.sCmd);
  CommandConf.WriteString('Command', 'DearRecall', g_GameCommand.DEARRECALL.sCmd);
  CommandConf.WriteString('Command', 'MasterRecall', g_GameCommand.MASTERECALL.sCmd);
  CommandConf.WriteString('Command', 'AllowDearRecall', g_GameCommand.ALLOWDEARRCALL.sCmd);
  CommandConf.WriteString('Command', 'AllowMasterRecall', g_GameCommand.ALLOWMASTERRECALL.sCmd);
  CommandConf.WriteString('Command', 'AttackMode', g_GameCommand.ATTACKMODE.sCmd);
  CommandConf.WriteString('Command', 'Rest', g_GameCommand.REST.sCmd);
  CommandConf.WriteString('Command', 'TakeOnHorse', g_GameCommand.TAKEONHORSE.sCmd);
  CommandConf.WriteString('Command', 'TakeOffHorse', g_GameCommand.TAKEOFHORSE.sCmd);

  CommandConf.WriteInteger('Permission', 'Date', g_GameCommand.Data.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'PrvMsg', g_GameCommand.PRVMSG.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'AllowMsg', g_GameCommand.ALLOWMSG.nPermissionMin);
{$IFEND}
end;
procedure TfrmGameCmd.RefGameMasterCmd(GameCmd: pTGameCmd; sCmdParam, sDesc: string);
var nCode: Byte;//20080829
begin
  nCode:= 0;
  try
    Inc(nRefGameMasterIndex);
    nCode:= 1;
    if StringGridGameMasterCmd.RowCount - 1 < nRefGameMasterIndex then begin
      nCode:= 2;
      StringGridGameMasterCmd.RowCount := nRefGameMasterIndex + 1;
    end;
    nCode:= 3;
    StringGridGameMasterCmd.Cells[0, nRefGameMasterIndex] := GameCmd.sCmd;
    nCode:= 4;
    StringGridGameMasterCmd.Cells[1, nRefGameMasterIndex] := IntToStr(GameCmd.nPermissionMin) + '/' + IntToStr(GameCmd.nPermissionMax);
    nCode:= 5;
    StringGridGameMasterCmd.Cells[2, nRefGameMasterIndex] := sCmdParam;
    nCode:= 6;
    StringGridGameMasterCmd.Cells[3, nRefGameMasterIndex] := sDesc;
    nCode:= 7;
    StringGridGameMasterCmd.Objects[0, nRefGameMasterIndex] := TObject(GameCmd);
  except
    MainOutMessage('{�쳣} TfrmGameCmd.RefGameMasterCmd Code:'+inttostr(nCode));
  end;
end;

//��Ϸ����˵��
procedure TfrmGameCmd.RefGameMasterCommand;
begin
  EditGameMasterCmdOK.Enabled := False;
  nRefGameMasterIndex := 0;

  RefGameMasterCmd(@g_GameCommand.CLRPASSWORD,
    '@' + g_GameCommand.CLRPASSWORD.sCmd + ' ��������',
    '�������ֿ�/��¼����(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.WHO,
    '/' + g_GameCommand.WHO.sCmd,
    '�鿴��ǰ��������������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.TOTAL,
    '/' + g_GameCommand.TOTAL.sCmd,
    '�鿴���з�������������(֧��Ȩ�޷���)');


  RefGameMasterCmd(@g_GameCommand.GAMEMASTER,
    '@' + g_GameCommand.GAMEMASTER.sCmd,
    '����/�˳�����Աģʽ(����ģʽ�󲻻��ܵ��κν�ɫ����)(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.OBSERVER,
    '@' + g_GameCommand.OBSERVER.sCmd,
    '����/�˳�����ģʽ(����ģʽ����˿������Լ�)(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.SUEPRMAN,
    '@' + g_GameCommand.SUEPRMAN.sCmd,
    '����/�˳��޵�ģʽ(����ģʽ�����ﲻ������)(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.MAKE,
    '@' + g_GameCommand.MAKE.sCmd + ' ��Ʒ���� ����',
    '����ָ����Ʒ(֧��Ȩ�޷��䣬С�����Ȩ����������ֹ�����б�����)');

  RefGameMasterCmd(@g_GameCommand.SMAKE,
    '@' + g_GameCommand.SMAKE.sCmd + ' �������ʹ��˵��',
    '�����Լ����ϵ���Ʒ����(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.Move,
    '@' + g_GameCommand.Move.sCmd + ' ��ͼ��',
    '�ƶ���ָ����ͼ(֧��Ȩ�޷��䣬С�����Ȩ�����ܽ�ֹ���͵�ͼ�б�����)');

  RefGameMasterCmd(@g_GameCommand.POSITIONMOVE,
    '@' + g_GameCommand.POSITIONMOVE.sCmd + ' ��ͼ�� X Y',
    '�ƶ���ָ����ͼ(֧��Ȩ�޷��䣬С�����Ȩ�����ܽ�ֹ���͵�ͼ�б�����)');

  RefGameMasterCmd(@g_GameCommand.RECALL,
    '@' + g_GameCommand.RECALL.sCmd + ' ��������',
    '��ָ�������ٻ������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.REGOTO,
    '@' + g_GameCommand.REGOTO.sCmd + ' ��������',
    '����ָ������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.TING,
    '@' + g_GameCommand.TING.sCmd + ' ��������',
    '��ָ�������������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.SUPERTING,
    '@' + g_GameCommand.SUPERTING.sCmd + ' �������� ��Χ��С',
    '��ָ���������ָ����Χ�ڵ������������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.MAPMOVE,
    '@' + g_GameCommand.MAPMOVE.sCmd + ' Դ��ͼ�� Ŀ���ͼ��',
    '��������ͼ�е������ƶ���������ͼ��(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.INFO,
    '@' + g_GameCommand.INFO.sCmd + ' ��������',
    '��������Ϣ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.HUMANLOCAL,
    '@' + g_GameCommand.HUMANLOCAL.sCmd + ' ��ͼ��',
    '��ѯ����IP���ڵ���(�����IP������ѯ���)(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.VIEWWHISPER,
    '@' + g_GameCommand.VIEWWHISPER.sCmd + ' ��������',
    '�鿴ָ�������˽����Ϣ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.MOBLEVEL,
    '@' + g_GameCommand.MOBLEVEL.sCmd,
    '�鿴��߽�ɫ��Ϣ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.MOBCOUNT,
    '@' + g_GameCommand.MOBCOUNT.sCmd + ' ��ͼ��',
    '�鿴��ͼ�й�������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.HUMANCOUNT,
    '@' + g_GameCommand.HUMANCOUNT.sCmd,
    '�鿴�������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.Map,
    '@' + g_GameCommand.Map.sCmd,
    '��ʾ��ǰ���ڵ�ͼ�����Ϣ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.Level,
    '@' + g_GameCommand.Level.sCmd,
    '�����Լ��ĵȼ�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.KICK,
    '@' + g_GameCommand.KICK.sCmd + ' ��������',
    '��ָ������������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.ReAlive,
    '@' + g_GameCommand.ReAlive.sCmd + ' ��������',
    '��ָ�����︴��(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.KILL,
    '@' + g_GameCommand.KILL.sCmd + '��������',
    '��ָ����������ɱ��(ɱ����ʱ����Թ���)(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.CHANGEJOB,
    '@' + g_GameCommand.CHANGEJOB.sCmd + ' �������� ְҵ����(Warr Wizard Taos)',
    '���������ְҵ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.FREEPENALTY,
    '@' + g_GameCommand.FREEPENALTY.sCmd + ' ��������',
    '���ָ�������PKֵ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.PKPOINT,
    '@' + g_GameCommand.PKPOINT.sCmd + ' ��������',
    '�鿴ָ�������PKֵ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.IncPkPoint,
    '@' + g_GameCommand.IncPkPoint.sCmd + ' �������� ����',
    '����ָ�������PKֵ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.CHANGEGENDER,
    '@' + g_GameCommand.CHANGEGENDER.sCmd + ' �������� �Ա�(�С�Ů)',
    '����������Ա�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.HAIR,
    '@' + g_GameCommand.HAIR.sCmd + ' ����ֵ',
    '����ָ�������ͷ������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.BonusPoint,
    '@' + g_GameCommand.BonusPoint.sCmd + ' �������� ���Ե���',
    '������������Ե���(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DELBONUSPOINT,
    '@' + g_GameCommand.DELBONUSPOINT.sCmd + ' ��������',
    'ɾ����������Ե���(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.RESTBONUSPOINT,
    '@' + g_GameCommand.RESTBONUSPOINT.sCmd + ' ��������',
    '����������Ե������·���(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.SETPERMISSION,
    '@' + g_GameCommand.SETPERMISSION.sCmd + ' �������� Ȩ�޵ȼ�(0 - 10)',
    '���������Ȩ�޵ȼ������Խ���ͨ������ΪGMȨ��(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.RENEWLEVEL,
    '@' + g_GameCommand.RENEWLEVEL.sCmd + ' �������� ����(Ϊ����鿴)',
    '�����鿴�����ת���ȼ�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DELGOLD,
    '@' + g_GameCommand.DELGOLD.sCmd + ' �������� ����',
    'ɾ������ָ�������Ľ��(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.ADDGOLD,
    '@' + g_GameCommand.ADDGOLD.sCmd + ' �������� ����',
    '��������ָ�������Ľ��(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.GAMEGOLD,
    '@' + g_GameCommand.GAMEGOLD.sCmd + ' �������� ���Ʒ�(+ - =) ����',
    '�����������Ϸ������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.GAMEGIRD,
    '@' + g_GameCommand.GAMEGIRD.sCmd + ' �������� ���Ʒ�(+ - =) ����',
    '����������������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.GAMEDIAMOND,
    '@' + g_GameCommand.GAMEDIAMOND.sCmd + ' �������� ���Ʒ�(+ - =) ����',
    '��������Ľ��ʯ����(֧��Ȩ�޷���)');

//------------------------------------------------------------------------------
// ����Ӣ�۵��ҳ϶� 20080109
  RefGameMasterCmd(@g_GameCommand.HEROLOYAL,
    '@' + '�ı��ҳ�'{g_GameCommand.HEROLOYAL.sCmd} + ' Ӣ������  �ҳ϶�(0-10000)',
    '����Ӣ�۵��ҳ϶�(֧��Ȩ�޷���)');
//------------------------------------------------------------------------------

  RefGameMasterCmd(@g_GameCommand.GAMEPOINT,
    '@' + g_GameCommand.GAMEPOINT.sCmd + ' �������� ���Ʒ�(+ - =) ����',
    '�����������Ϸ������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.CREDITPOINT,
    '@' + g_GameCommand.CREDITPOINT.sCmd + ' �������� ���Ʒ�(+ - =) ����',
    '�����������������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.REFINEWEAPON,
    '@' + g_GameCommand.REFINEWEAPON.sCmd + ' ������ ħ���� ���� ׼ȷ��',
    '����������������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.SysMsg,                 //ǧ�ﴫ�� 20071228
    '@' + g_GameCommand.SysMsg.sCmd + ' ������Ϣ',
    'ǧ�ﴫ������');

  RefGameMasterCmd(@g_GameCommand.HEROLEVEL,                 //����Ӣ�۵ȼ� 20071227
    '@' + g_GameCommand.HEROLEVEL.sCmd + ' Ӣ������ �ȼ�',
    '����ָ��Ӣ�۵ĵȼ�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.ADJUESTLEVEL,
    '@' + g_GameCommand.ADJUESTLEVEL.sCmd + ' �������� �ȼ�',
    '����ָ������ĵȼ�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.NGLEVEL,//���������ڹ��ȼ� 20081221
    '@' + g_GameCommand.NGLEVEL.sCmd + ' �������� �ڹ��ȼ�(1-255)',
    '����ָ�������Ӣ���ڹ��ȼ�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.ADJUESTEXP,
    '@' + g_GameCommand.ADJUESTEXP.sCmd + ' �������� ����ֵ',
    '����ָ������ľ���ֵ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.CHANGEDEARNAME,
    '@' + g_GameCommand.CHANGEDEARNAME.sCmd + ' �������� ��ż����(���Ϊ �� �����)',
    '����ָ���������ż����(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.CHANGEMASTERNAME,
    '@' + g_GameCommand.CHANGEMASTERNAME.sCmd + ' �������� ʦͽ����(���Ϊ �� �����)',
    '����ָ�������ʦͽ����(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.RECALLMOB,
    '@' + g_GameCommand.RECALLMOB.sCmd + ' �������� ���� �ٻ��ȼ�',
    '�ٻ�ָ������Ϊ����(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.RECALLMOBEX,                    //20080122 �ٻ�����
    '@' + g_GameCommand.RECALLMOBEX.sCmd + ' �������� ������ɫ ����X ����Y',
    '�ٻ�ָ������Ϊ����(֧��Ȩ�޷���)-ħ����');

  RefGameMasterCmd(@g_GameCommand.GIVEMINE,                      //20080403 ��ָ�����ȵĿ�ʯ
    '@' + g_GameCommand.GIVEMINE.sCmd + ' ��ʯ���� ���� ����',
    '��ָ�����ȵĿ�ʯ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.MOVEMOBTO,                      //20080123 ��ָ������Ĺ����ƶ���������
    '@' + g_GameCommand.MOVEMOBTO.sCmd + ' �������� ԭ��ͼ ԭX ԭY �µ�ͼ ��X ��Y',
    '��ָ������Ĺ����ƶ���������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.CLEARITEMMAP,                   //20080124 �����ͼ��Ʒ
    '@' + g_GameCommand.CLEARITEMMAP.sCmd + ' ��ͼ X Y ��Χ ��Ʒ����',
    '�����ͼ��Ʒ����Ʒ����ΪALL���������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.TRAINING,
    '@' + g_GameCommand.TRAINING.sCmd + ' ��������  �������� �����ȼ�(0-3)',
    '��������ļ��������ȼ�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.TRAININGSKILL,
    '@' + g_GameCommand.TRAININGSKILL.sCmd + ' ��������  �������� �����ȼ�(0-3)',
    '��ָ���������Ӽ���(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DELETESKILL,
    '@' + g_GameCommand.DELETESKILL.sCmd + ' �������� ��������(All)',
    'ɾ������ļ��ܣ�All����ɾ��ȫ������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DELETEITEM,
    '@' + g_GameCommand.DELETEITEM.sCmd + ' �������� ��Ʒ���� ����',
    'ɾ����������ָ������Ʒ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.CLEARMISSION,
    '@' + g_GameCommand.CLEARMISSION.sCmd + ' ��������',
    '�������������־(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.AddGuild,
    '@' + g_GameCommand.AddGuild.sCmd + ' �л����� ������',
    '�½�һ���л�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DELGUILD,
    '@' + g_GameCommand.DELGUILD.sCmd + ' �л�����',
    'ɾ��һ���л�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.CHANGESABUKLORD,
    '@' + g_GameCommand.CHANGESABUKLORD.sCmd + ' �л�����',
    '���ĳǱ������л�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.FORCEDWALLCONQUESTWAR,
    '@' + g_GameCommand.FORCEDWALLCONQUESTWAR.sCmd,
    'ǿ�п�ʼ/ֹͣ����ս(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.CONTESTPOINT,
    '@' + g_GameCommand.CONTESTPOINT.sCmd + ' �л�����',
    '�鿴�л��������÷����(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.STARTCONTEST,
    '@' + g_GameCommand.STARTCONTEST.sCmd,
    '��ʼ�л�������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.ENDCONTEST,
    '@' + g_GameCommand.ENDCONTEST.sCmd,
    '�����л�������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.ANNOUNCEMENT,
    '@' + g_GameCommand.ANNOUNCEMENT.sCmd + ' �л�����',
    '�鿴�л����������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.MOB,
    '@' + g_GameCommand.MOB.sCmd + ' �������� ���� �ڹ���(0,1)',
    '����߷���ָ�����������Ĺ���(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.Mission,
    '@' + g_GameCommand.Mission.sCmd + ' X  Y',
    '���ù���ļ��е�(���й��﹥����)(֧��Ȩ�޷���');

  RefGameMasterCmd(@g_GameCommand.MobPlace,
    '@' + g_GameCommand.MobPlace.sCmd + ' X  Y �������� �������� �ڹ���(0,1)',
    '�ڵ�ǰ��ͼָ��XY���ù���(֧��Ȩ�޷���(�ȱ������ù���ļ��е�)�����õĹ�����������ṥ����Щ����');

  RefGameMasterCmd(@g_GameCommand.CLEARMON,
    '@' + g_GameCommand.CLEARMON.sCmd + ' ��ͼ��(* Ϊ����) ��������(* Ϊ����) ����Ʒ(0,1)',
    '�����ͼ�еĹ���(֧��Ȩ�޷���'')');

  RefGameMasterCmd(@g_GameCommand.DISABLESENDMSG,
    '@' + g_GameCommand.DISABLESENDMSG.sCmd + ' ��������',
    '��ָ��������뷢�Թ����б������б���Լ����������Լ����Կ����������˿�����(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.ENABLESENDMSG,
    '@' + g_GameCommand.ENABLESENDMSG.sCmd,
    '��ָ������ӷ��Թ����б���ɾ��(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DISABLESENDMSGLIST,
    '@' + g_GameCommand.DISABLESENDMSGLIST.sCmd,
    '�鿴���Թ����б��е�����(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.SHUTUP,
    '@' + g_GameCommand.SHUTUP.sCmd + ' ��������',
    '��ָ���������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.RELEASESHUTUP,
    '@' + g_GameCommand.RELEASESHUTUP.sCmd + ' ��������',
    '��ָ������ӽ����б���ɾ��(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.SHUTUPLIST,
    '@' + g_GameCommand.SHUTUPLIST.sCmd,
    '�鿴�����б��е�����(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.SABUKWALLGOLD,
    '@' + g_GameCommand.SABUKWALLGOLD.sCmd,
    '�鿴�Ǳ������(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.STARTQUEST,
    '@' + g_GameCommand.STARTQUEST.sCmd,
    '��ʼ���ʹ��ܣ���Ϸ��������ͬʱ�������ⴰ��(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DENYIPLOGON,
    '@' + g_GameCommand.DENYIPLOGON.sCmd + ' IP��ַ �Ƿ����÷�(0,1)',
    '��ָ��IP��ַ�����ֹ��¼�б�����ЩIP��¼���û����޷�������Ϸ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DENYACCOUNTLOGON,
    '@' + g_GameCommand.DENYACCOUNTLOGON.sCmd + ' ��¼�ʺ� �Ƿ����÷�(0,1)',
    '��ָ����¼�ʺż����ֹ��¼�б��Դ��ʺŵ�¼���û����޷�������Ϸ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DENYCHARNAMELOGON,
    '@' + g_GameCommand.DENYCHARNAMELOGON.sCmd + ' �������� �Ƿ����÷�(0,1)',
    '��ָ���������Ƽ����ֹ��¼�б������ｫ�޷�������Ϸ(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DELDENYIPLOGON,
    '@' + g_GameCommand.DELDENYIPLOGON.sCmd + ' IP��ַ',
    '�ָ���ֹ��½IP(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DELDENYACCOUNTLOGON,
    '@' + g_GameCommand.DELDENYACCOUNTLOGON.sCmd+ ' ��¼�ʺ�',
    '�ָ���ֹ��½�ʺ�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.DELDENYCHARNAMELOGON,
    '@' + g_GameCommand.DELDENYCHARNAMELOGON.sCmd + ' ��������',
    '�ָ���ֹ��½����(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.SHOWDENYIPLOGON,
    '@' + g_GameCommand.SHOWDENYIPLOGON.sCmd,
    '�鿴��ֹ��½IP(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.SHOWDENYACCOUNTLOGON,
    '@' + g_GameCommand.SHOWDENYACCOUNTLOGON.sCmd,
    '�鿴��ֹ��½�ʺ�(֧��Ȩ�޷���)');


  RefGameMasterCmd(@g_GameCommand.SHOWDENYCHARNAMELOGON,
    '@' + g_GameCommand.SHOWDENYCHARNAMELOGON.sCmd,
    '�鿴��ֹ��¼��ɫ�б�(֧��Ȩ�޷���)');

  RefGameMasterCmd(@g_GameCommand.SetMapMode,
    '@' + g_GameCommand.SetMapMode.sCmd,
    '���õ�ͼģʽ');

  RefGameMasterCmd(@g_GameCommand.SHOWMAPMODE,
    '@' + g_GameCommand.SHOWMAPMODE.sCmd,
    '��ʾ��ͼģʽ');

 { RefGameMasterCmd(@g_GameCommand.Attack,//20080812 ע��
    '@' + g_GameCommand.Attack.sCmd,
    ''); }

  RefGameMasterCmd(@g_GameCommand.LUCKYPOINT,
    '@' + g_GameCommand.LUCKYPOINT.sCmd+ ' �������� ������(+,-,=) ����',
    '����ָ�����������ֵ(֧��Ȩ�޷���)');

 { RefGameMasterCmd(@g_GameCommand.CHANGELUCK,//20080812 ע��
    '@' + g_GameCommand.CHANGELUCK.sCmd,
    ''); }

  RefGameMasterCmd(@g_GameCommand.HUNGER,
    '@' + g_GameCommand.HUNGER.sCmd+ ' �������� ����ֵ',
    '����ָ�����������ֵ(Ȩ��6����)');

 { RefGameMasterCmd(@g_GameCommand.NAMECOLOR,//20080812 ע��
    '@' + g_GameCommand.NAMECOLOR.sCmd,
    ''); 

  RefGameMasterCmd(@g_GameCommand.TRANSPARECY,
    '@' + g_GameCommand.TRANSPARECY.sCmd,
    ''); 

  RefGameMasterCmd(@g_GameCommand.LEVEL0,
    '@' + g_GameCommand.LEVEL0.sCmd,
    ''); }

  RefGameMasterCmd(@g_GameCommand.CHANGEITEMNAME,
    '@' + g_GameCommand.CHANGEITEMNAME.sCmd+ ' ��Ʒ��� ��ƷID�� ��Ʒ����',
    '�ı���Ʒ����(Ȩ��6����)');

 { RefGameMasterCmd(@g_GameCommand.ADDTOITEMEVENT,//20080812 ע��
    '@' + g_GameCommand.ADDTOITEMEVENT.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.ADDTOITEMEVENTASPIECES,
    '@' + g_GameCommand.ADDTOITEMEVENTASPIECES.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.ItemEventList,
    '@' + g_GameCommand.ItemEventList.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.STARTINGGIFTNO,
    '@' + g_GameCommand.STARTINGGIFTNO.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.DELETEALLITEMEVENT,
    '@' + g_GameCommand.DELETEALLITEMEVENT.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.STARTITEMEVENT,
    '@' + g_GameCommand.STARTITEMEVENT.sCmd,
    ''); 

  RefGameMasterCmd(@g_GameCommand.ITEMEVENTTERM,
    '@' + g_GameCommand.ITEMEVENTTERM.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.OPDELETESKILL,
    '@' + g_GameCommand.OPDELETESKILL.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.CHANGEWEAPONDURA,
    '@' + g_GameCommand.CHANGEWEAPONDURA.sCmd,
    '');

  RefGameMasterCmd(@g_GameCommand.SBKDOOR,
    '@' + g_GameCommand.SBKDOOR.sCmd,
    '');}

  RefGameMasterCmd(@g_GameCommand.SPIRIT,
    '@' + g_GameCommand.SPIRIT.sCmd + '  ʱ��(��)',
    '���ڿ�ʼ����Ч�����ѱ�(Ȩ��6����)');

  RefGameMasterCmd(@g_GameCommand.SPIRITSTOP,
    '@' + g_GameCommand.SPIRITSTOP.sCmd,
    '����ֹͣ����Ч���±����ѱ�(Ȩ��6����)');

  RefGameMasterCmd(@g_GameCommand.CLEARCOPYITEM,
    '@' + g_GameCommand.CLEARCOPYITEM.sCmd + ' ��������',
    '�����������ֿ⸴��Ʒ(֧��Ȩ�޷���)');
end;

procedure TfrmGameCmd.RefGameDebugCmd(GameCmd: pTGameCmd; sCmdParam, sDesc: string);
begin
  Inc(nRefGameDebugIndex);
  if StringGridGameMasterCmd.RowCount - 1 < nRefGameDebugIndex then begin
    StringGridGameDebugCmd.RowCount := nRefGameDebugIndex + 1;
  end;

  StringGridGameDebugCmd.Cells[0, nRefGameDebugIndex] := GameCmd.sCmd;
  StringGridGameDebugCmd.Cells[1, nRefGameDebugIndex] := IntToStr(GameCmd.nPermissionMin) + '/' + IntToStr(GameCmd.nPermissionMax);
  StringGridGameDebugCmd.Cells[2, nRefGameDebugIndex] := sCmdParam;
  StringGridGameDebugCmd.Cells[3, nRefGameDebugIndex] := sDesc;
  StringGridGameDebugCmd.Objects[0, nRefGameDebugIndex] := TObject(GameCmd);
end;
//��������
procedure TfrmGameCmd.RefDebugCommand;
var
  GameCmd: pTGameCmd;
begin
  EditGameDebugCmdOK.Enabled := False;
  //  StringGridGameDebugCmd.RowCount:=41;

  GameCmd := @g_GameCommand.SHOWFLAG;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '');

  GameCmd := @g_GameCommand.SETFLAG;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' �������� ��־�� ����(0 - 1)',
    '');

{  GameCmd := @g_GameCommand.SHOWOPEN;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    ''); 

  GameCmd := @g_GameCommand.SETOPEN;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    ''); 

  GameCmd := @g_GameCommand.SHOWUNIT;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    ''); 

  GameCmd := @g_GameCommand.SETUNIT;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    ''); }

  GameCmd := @g_GameCommand.MOBNPC;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' NPC���� �ű��ļ��� ����(����) ��ɳ��(0,1)',
    '����NPC');

  GameCmd := @g_GameCommand.DELNPC;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    'ɾ��NPC(����NPC�����)');

  GameCmd := @g_GameCommand.LOTTERYTICKET;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '�鿴��Ʊ�н�����');

  GameCmd := @g_GameCommand.RELOADADMIN;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼��ع���Ա�б�');

  GameCmd := @g_GameCommand.ReLoadNpc;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼���NPC�ű�');

  GameCmd := @g_GameCommand.RELOADMANAGE;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼��ص�¼�ű�');

  GameCmd := @g_GameCommand.RELOADROBOTMANAGE;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼��ػ���������');

  GameCmd := @g_GameCommand.RELOADROBOT;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼��ػ����˽ű�');

  GameCmd := @g_GameCommand.RELOADMONITEMS;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼��ع��ﱬ������');

 { GameCmd := @g_GameCommand.RELOADDIARY; //20080812 ע��
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    'δʹ��'); }

  GameCmd := @g_GameCommand.RELOADITEMDB;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼�����Ʒ���ݿ�');

  GameCmd := @g_GameCommand.RELOADMAGICDB;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼���ħ�����ݿ�');

  GameCmd := @g_GameCommand.RELOADMONSTERDB;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼��ع������ݿ�');

  GameCmd := @g_GameCommand.RELOADMINMAP;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼���С��ͼ����');

  GameCmd := @g_GameCommand.RELOADGUILD;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' �л�����',
    '���¼���ָ�����л�');

 { GameCmd := @g_GameCommand.RELOADGUILDALL;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    'δʹ��'); }

  GameCmd := @g_GameCommand.RELOADLINENOTICE;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼�����Ϸ������Ϣ');

  GameCmd := @g_GameCommand.RELOADABUSE;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '���¼����໰��������');

  GameCmd := @g_GameCommand.BACKSTEP;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd+' ����(0-8) ����',
    '�ƿ�����');

  GameCmd := @g_GameCommand.RECONNECTION;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '��ָ�����������л���������');

  GameCmd := @g_GameCommand.DISABLEFILTER;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '�����໰���˹���');

  GameCmd := @g_GameCommand.CHGUSERFULL;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' ����',
    '���÷����������������');

  GameCmd := @g_GameCommand.CHGZENFASTSTEP;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' �ٶ�',
    '���ù����ж��ٶ�');

{  GameCmd := @g_GameCommand.OXQUIZROOM;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    'δʹ��');

  GameCmd := @g_GameCommand.BALL;//20080812 ע��
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    'δʹ��'); }

  GameCmd := @g_GameCommand.FIREBURN;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' ����(1-6) ʱ��(��) ����',
    '���ӳ���');

  GameCmd := @g_GameCommand.TESTFIRE;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' ��Χ ����(1-6) ʱ��(��) ����',
    '��һ����Χ���ӳ���');

  GameCmd := @g_GameCommand.TESTSTATUS;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' ����(0..11) ʱ��',
    '�ı��������ʱ����');

{  GameCmd := @g_GameCommand.TESTGOLDCHANGE; //20080812 ע��
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    'δʹ��');

  GameCmd := @g_GameCommand.GSA;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    'δʹ��');}

 { GameCmd := @g_GameCommand.TESTGA;//20081014 ע��
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd,
    '����TESTGA����'); }

  GameCmd := @g_GameCommand.MAPINFO;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' ��ͼ�� X Y',
    '��ʾ��ͼ��Ϣ');

  GameCmd := @g_GameCommand.CLEARBAG;
  RefGameDebugCmd(GameCmd,
    '@' + GameCmd.sCmd + ' ��������',
    '�������ȫ����Ʒ');

end;

procedure TfrmGameCmd.StringGridGameMasterCmdClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
begin
  nIndex := StringGridGameMasterCmd.Row;
  GameCmd := pTGameCmd(StringGridGameMasterCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    EditGameMasterCmdName.Text := GameCmd.sCmd;
    EditGameMasterCmdPerMission.Value := GameCmd.nPermissionMin;
    LabelGameMasterCmdParam.Caption := StringGridGameMasterCmd.Cells[2, nIndex];
    LabelGameMasterCmdFunc.Caption := StringGridGameMasterCmd.Cells[3, nIndex];
  end;
  EditGameMasterCmdOK.Enabled := False;
end;

procedure TfrmGameCmd.EditGameMasterCmdNameChange(Sender: TObject);
begin
  EditGameMasterCmdOK.Enabled := True;
  EditGameMasterCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditGameMasterCmdPerMissionChange(Sender: TObject);
begin
  EditGameMasterCmdOK.Enabled := True;
  EditGameMasterCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditGameMasterCmdOKClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
  sCmd: string;
  nPermission: Integer;
begin

  sCmd := Trim(EditGameMasterCmdName.Text);
  nPermission := EditGameMasterCmdPerMission.Value;
  if sCmd = '' then begin
    Application.MessageBox('�������Ʋ���Ϊ�գ�����', '��ʾ��Ϣ', MB_OK + MB_ICONERROR);
    EditGameMasterCmdName.SetFocus;
    Exit;
  end;

  nIndex := StringGridGameMasterCmd.Row;
  GameCmd := pTGameCmd(StringGridGameMasterCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    GameCmd.sCmd := sCmd;
    GameCmd.nPermissionMin := nPermission;
  end;
  RefGameMasterCommand();
end;

procedure TfrmGameCmd.EditGameMasterCmdSaveClick(Sender: TObject);
begin
  EditGameMasterCmdSave.Enabled := False;
{$IF SoftVersion <> VERDEMO}
  CommandConf.WriteString('Command', 'ObServer', g_GameCommand.OBSERVER.sCmd);
  CommandConf.WriteString('Command', 'GameMaster', g_GameCommand.GAMEMASTER.sCmd);
  CommandConf.WriteString('Command', 'SuperMan', g_GameCommand.SUEPRMAN.sCmd);
  CommandConf.WriteString('Command', 'StorageClearPassword', g_GameCommand.CLRPASSWORD.sCmd);
  CommandConf.WriteString('Command', 'ClearCopyItem', g_GameCommand.CLEARCOPYITEM.sCmd);//20080816 ������Ҹ���Ʒ
  CommandConf.WriteString('Command', 'Who', g_GameCommand.WHO.sCmd);
  CommandConf.WriteString('Command', 'Total', g_GameCommand.TOTAL.sCmd);
  CommandConf.WriteString('Command', 'Make', g_GameCommand.MAKE.sCmd);
  CommandConf.WriteString('Command', 'PositionMove', g_GameCommand.POSITIONMOVE.sCmd);
  CommandConf.WriteString('Command', 'Move', g_GameCommand.Move.sCmd);
  CommandConf.WriteString('Command', 'Recall', g_GameCommand.RECALL.sCmd);
  CommandConf.WriteString('Command', 'ReGoto', g_GameCommand.REGOTO.sCmd);
  CommandConf.WriteString('Command', 'Ting', g_GameCommand.TING.sCmd);
  CommandConf.WriteString('Command', 'SuperTing', g_GameCommand.SUPERTING.sCmd);
  CommandConf.WriteString('Command', 'MapMove', g_GameCommand.MAPMOVE.sCmd);
  CommandConf.WriteString('Command', 'Info', g_GameCommand.INFO.sCmd);
  CommandConf.WriteString('Command', 'HumanLocal', g_GameCommand.HUMANLOCAL.sCmd);
  CommandConf.WriteString('Command', 'ViewWhisper', g_GameCommand.VIEWWHISPER.sCmd);
  CommandConf.WriteString('Command', 'MobLevel', g_GameCommand.MOBLEVEL.sCmd);
  CommandConf.WriteString('Command', 'MobCount', g_GameCommand.MOBCOUNT.sCmd);
  CommandConf.WriteString('Command', 'HumanCount', g_GameCommand.HUMANCOUNT.sCmd);
  CommandConf.WriteString('Command', 'Map', g_GameCommand.Map.sCmd);
  CommandConf.WriteString('Command', 'Level', g_GameCommand.Level.sCmd);
  CommandConf.WriteString('Command', 'Kick', g_GameCommand.KICK.sCmd);
  CommandConf.WriteString('Command', 'ReAlive', g_GameCommand.ReAlive.sCmd);
  CommandConf.WriteString('Command', 'Kill', g_GameCommand.KILL.sCmd);
  CommandConf.WriteString('Command', 'ChangeJob', g_GameCommand.CHANGEJOB.sCmd);
  CommandConf.WriteString('Command', 'FreePenalty', g_GameCommand.FREEPENALTY.sCmd);
  CommandConf.WriteString('Command', 'PkPoint', g_GameCommand.PKPOINT.sCmd);
  CommandConf.WriteString('Command', 'IncPkPoint', g_GameCommand.IncPkPoint.sCmd);
  CommandConf.WriteString('Command', 'ChangeGender', g_GameCommand.CHANGEGENDER.sCmd);
  CommandConf.WriteString('Command', 'Hair', g_GameCommand.HAIR.sCmd);
  CommandConf.WriteString('Command', 'BonusPoint', g_GameCommand.BonusPoint.sCmd);
  CommandConf.WriteString('Command', 'DelBonuPoint', g_GameCommand.DELBONUSPOINT.sCmd);
  CommandConf.WriteString('Command', 'RestBonuPoint', g_GameCommand.RESTBONUSPOINT.sCmd);
  CommandConf.WriteString('Command', 'SetPermission', g_GameCommand.SETPERMISSION.sCmd);
  CommandConf.WriteString('Command', 'ReNewLevel', g_GameCommand.RENEWLEVEL.sCmd);
  CommandConf.WriteString('Command', 'DelGold', g_GameCommand.DELGOLD.sCmd);
  CommandConf.WriteString('Command', 'AddGold', g_GameCommand.ADDGOLD.sCmd);
  CommandConf.WriteString('Command', 'GameGold', g_GameCommand.GAMEGOLD.sCmd);

  CommandConf.WriteString('Command', 'GameDiaMond', g_GameCommand.GameDiaMond.sCmd); //20071226 ���ʯ
  CommandConf.WriteString('Command', 'GameGird', g_GameCommand.GameGird.sCmd); //20071226 ���
  CommandConf.WriteString('Command', 'HEROLOYAL', g_GameCommand.HEROLOYAL.sCmd); //20080109 Ӣ�۵��ҳ϶�

  CommandConf.WriteString('Command', 'GamePoint', g_GameCommand.GAMEPOINT.sCmd);
  CommandConf.WriteString('Command', 'CreditPoint', g_GameCommand.CREDITPOINT.sCmd);
  CommandConf.WriteString('Command', 'RefineWeapon', g_GameCommand.REFINEWEAPON.sCmd);
  CommandConf.WriteString('Command', 'SysMsg','��' {g_GameCommand.SysMsg.sCmd});//ǧ�ﴫ�� 20071228
  CommandConf.WriteString('Command', 'HEROLEVEL', g_GameCommand.HEROLEVEL.sCmd);//����Ӣ�۵ȼ� 20071227
  CommandConf.WriteString('Command', 'AdjuestTLevel', g_GameCommand.ADJUESTLEVEL.sCmd);//��������ȼ�
  CommandConf.WriteString('Command', 'NGLevel', g_GameCommand.NGLEVEL.sCmd);//���������ڹ��ȼ� 20081221
  CommandConf.WriteString('Command', 'AdjuestExp', g_GameCommand.ADJUESTEXP.sCmd);
  CommandConf.WriteString('Command', 'ChangeDearName', g_GameCommand.CHANGEDEARNAME.sCmd);
  CommandConf.WriteString('Command', 'ChangeMasterrName', g_GameCommand.CHANGEMASTERNAME.sCmd);
  CommandConf.WriteString('Command', 'RecallMob', g_GameCommand.RECALLMOB.sCmd);
  CommandConf.WriteString('Command', 'RECALLMOBEX', g_GameCommand.RECALLMOBEX.sCmd);//20080122 �ٻ�����
  CommandConf.WriteString('Command', 'GIVEMINE', g_GameCommand.GIVEMINE.sCmd);//20080403 ��ָ�����ȵĿ�ʯ
  CommandConf.WriteString('Command', 'MOVEMOBTO', g_GameCommand.MOVEMOBTO.sCmd);//20080123 ��ָ������Ĺ����ƶ���������
  CommandConf.WriteString('Command', 'CLEARITEMMAP', g_GameCommand.CLEARITEMMAP.sCmd);//20080124 �����ͼ��Ʒ
  CommandConf.WriteString('Command', 'Training', g_GameCommand.TRAINING.sCmd);
  CommandConf.WriteString('Command', 'OpTraining', g_GameCommand.TRAININGSKILL.sCmd);
  CommandConf.WriteString('Command', 'DeleteSkill', g_GameCommand.DELETESKILL.sCmd);
  CommandConf.WriteString('Command', 'DeleteItem', g_GameCommand.DELETEITEM.sCmd);
  CommandConf.WriteString('Command', 'ClearMission', g_GameCommand.CLEARMISSION.sCmd);
  CommandConf.WriteString('Command', 'AddGuild', g_GameCommand.AddGuild.sCmd);
  CommandConf.WriteString('Command', 'DelGuild', g_GameCommand.DELGUILD.sCmd);
  CommandConf.WriteString('Command', 'ChangeSabukLord', g_GameCommand.CHANGESABUKLORD.sCmd);
  CommandConf.WriteString('Command', 'ForcedWallConQuestWar', g_GameCommand.FORCEDWALLCONQUESTWAR.sCmd);
  CommandConf.WriteString('Command', 'ContestPoint', g_GameCommand.CONTESTPOINT.sCmd);
  CommandConf.WriteString('Command', 'StartContest', g_GameCommand.STARTCONTEST.sCmd);
  CommandConf.WriteString('Command', 'EndContest', g_GameCommand.ENDCONTEST.sCmd);
  CommandConf.WriteString('Command', 'Announcement', g_GameCommand.ANNOUNCEMENT.sCmd);
  CommandConf.WriteString('Command', 'MobLevel', g_GameCommand.MOBLEVEL.sCmd);
  CommandConf.WriteString('Command', 'Mission', g_GameCommand.Mission.sCmd);
  CommandConf.WriteString('Command', 'MobPlace', g_GameCommand.MobPlace.sCmd);

  CommandConf.WriteInteger('Permission', 'GameMaster', g_GameCommand.GAMEMASTER.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ObServer', g_GameCommand.OBSERVER.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'SuperMan', g_GameCommand.SUEPRMAN.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'StorageClearPassword', g_GameCommand.CLRPASSWORD.nPermissionMin);

  CommandConf.WriteInteger('Permission', 'ClearCopyItem', g_GameCommand.CLEARCOPYITEM.nPermissionMin);//20080816 ������Ҹ���Ʒ

  CommandConf.WriteInteger('Permission', 'Who', g_GameCommand.WHO.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Total', g_GameCommand.TOTAL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MakeMin', g_GameCommand.MAKE.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MakeMax', g_GameCommand.MAKE.nPermissionMax);
  CommandConf.WriteInteger('Permission', 'PositionMoveMin', g_GameCommand.POSITIONMOVE.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'PositionMoveMax', g_GameCommand.POSITIONMOVE.nPermissionMax);
  CommandConf.WriteInteger('Permission', 'MoveMin', g_GameCommand.Move.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MoveMax', g_GameCommand.Move.nPermissionMax);
  CommandConf.WriteInteger('Permission', 'Recall', g_GameCommand.RECALL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ReGoto', g_GameCommand.REGOTO.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Ting', g_GameCommand.TING.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'SuperTing', g_GameCommand.SUPERTING.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MapMove', g_GameCommand.MAPMOVE.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Info', g_GameCommand.INFO.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'HumanLocal', g_GameCommand.HUMANLOCAL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ViewWhisper', g_GameCommand.VIEWWHISPER.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MobLevel', g_GameCommand.MOBLEVEL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MobCount', g_GameCommand.MOBCOUNT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'HumanCount', g_GameCommand.HUMANCOUNT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Map', g_GameCommand.Map.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Level', g_GameCommand.Level.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Kick', g_GameCommand.KICK.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ReAlive', g_GameCommand.ReAlive.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Kill', g_GameCommand.KILL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ChangeJob', g_GameCommand.CHANGEJOB.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'FreePenalty', g_GameCommand.FREEPENALTY.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'PkPoint', g_GameCommand.PKPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'IncPkPoint', g_GameCommand.IncPkPoint.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ChangeGender', g_GameCommand.CHANGEGENDER.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Hair', g_GameCommand.HAIR.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'BonusPoint', g_GameCommand.BonusPoint.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'DelBonuPoint', g_GameCommand.DELBONUSPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'RestBonuPoint', g_GameCommand.RESTBONUSPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'SetPermission', g_GameCommand.SETPERMISSION.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ReNewLevel', g_GameCommand.RENEWLEVEL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'DelGold', g_GameCommand.DELGOLD.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'AddGold', g_GameCommand.ADDGOLD.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'GameGold', g_GameCommand.GAMEGOLD.nPermissionMin);

  CommandConf.WriteInteger('Permission', 'GameDiaMond', g_GameCommand.GameDiaMond.nPermissionMin); //20071226 ���ʯ
  CommandConf.WriteInteger('Permission','GameGird', g_GameCommand.GameGird.nPermissionMin); //20071226 ���
  CommandConf.WriteInteger('Permission','HEROLOYAL', g_GameCommand.HEROLOYAL.nPermissionMin); //20080109 Ӣ�۵��ҳ϶�

  CommandConf.WriteInteger('Permission', 'GamePoint', g_GameCommand.GAMEPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'CreditPoint', g_GameCommand.CREDITPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'RefineWeapon', g_GameCommand.REFINEWEAPON.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'SysMsg', g_GameCommand.SysMsg.nPermissionMin);//ǧ�ﴫ�� 20071228
  CommandConf.WriteInteger('Permission', 'HEROLEVEL', g_GameCommand.HEROLEVEL.nPermissionMin);//����Ӣ�۵ȼ� 20071227
  CommandConf.WriteInteger('Permission', 'AdjuestTLevel', g_GameCommand.ADJUESTLEVEL.nPermissionMin);//��������ȼ�
  CommandConf.WriteInteger('Permission', 'NGLevel', g_GameCommand.NGLEVEL.nPermissionMin);//���������ڹ��ȼ� 20081221
  CommandConf.WriteInteger('Permission', 'AdjuestExp', g_GameCommand.ADJUESTEXP.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ChangeDearName', g_GameCommand.CHANGEDEARNAME.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ChangeMasterName', g_GameCommand.CHANGEMASTERNAME.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'RecallMob', g_GameCommand.RECALLMOB.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'RECALLMOBEX', g_GameCommand.RECALLMOBEX.nPermissionMin);//20080122 �ٻ�����
  CommandConf.WriteInteger('Permission', 'GIVEMINE', g_GameCommand.GIVEMINE.nPermissionMin);//20080403 ��ָ�����ȵĿ�ʯ
  CommandConf.WriteInteger('Permission', 'MOVEMOBTO', g_GameCommand.MOVEMOBTO.nPermissionMin);//20080123 ��ָ������Ĺ����ƶ���������
  CommandConf.WriteInteger('Permission', 'CLEARITEMMAP', g_GameCommand.CLEARITEMMAP.nPermissionMin);//20080124 �����ͼ��Ʒ
  CommandConf.WriteInteger('Permission', 'Training', g_GameCommand.TRAINING.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'OpTraining', g_GameCommand.TRAININGSKILL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'DeleteSkill', g_GameCommand.DELETESKILL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'DeleteItem', g_GameCommand.DELETEITEM.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ClearMission', g_GameCommand.CLEARMISSION.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'AddGuild', g_GameCommand.AddGuild.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'DelGuild', g_GameCommand.DELGUILD.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ChangeSabukLord', g_GameCommand.CHANGESABUKLORD.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ForcedWallConQuestWar', g_GameCommand.FORCEDWALLCONQUESTWAR.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'ContestPoint', g_GameCommand.CONTESTPOINT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'StartContest', g_GameCommand.STARTCONTEST.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'EndContest', g_GameCommand.ENDCONTEST.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Announcement', g_GameCommand.ANNOUNCEMENT.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MobLevel', g_GameCommand.MOBLEVEL.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'Mission', g_GameCommand.Mission.nPermissionMin);
  CommandConf.WriteInteger('Permission', 'MobPlace', g_GameCommand.MobPlace.nPermissionMin);
{$IFEND}
end;

procedure TfrmGameCmd.StringGridGameDebugCmdClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
begin
  nIndex := StringGridGameDebugCmd.Row;
  GameCmd := pTGameCmd(StringGridGameDebugCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    EditGameDebugCmdName.Text := GameCmd.sCmd;
    EditGameDebugCmdPerMission.Value := GameCmd.nPermissionMin;
    LabelGameDebugCmdParam.Caption := StringGridGameDebugCmd.Cells[2, nIndex];
    LabelGameDebugCmdFunc.Caption := StringGridGameDebugCmd.Cells[3, nIndex];
  end;
  EditGameDebugCmdOK.Enabled := False;
end;

procedure TfrmGameCmd.EditGameDebugCmdNameChange(Sender: TObject);
begin
  EditGameDebugCmdOK.Enabled := True;
  EditGameDebugCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditGameDebugCmdPerMissionChange(Sender: TObject);
begin
  EditGameDebugCmdOK.Enabled := True;
  EditGameDebugCmdSave.Enabled := True;
end;

procedure TfrmGameCmd.EditGameDebugCmdOKClick(Sender: TObject);
var
  nIndex: Integer;
  GameCmd: pTGameCmd;
  sCmd: string;
  nPermission: Integer;
begin
  sCmd := Trim(EditGameDebugCmdName.Text);
  nPermission := EditGameDebugCmdPerMission.Value;
  if sCmd = '' then begin
    Application.MessageBox('�������Ʋ���Ϊ�գ�����', '��ʾ��Ϣ', MB_OK + MB_ICONERROR);
    EditGameDebugCmdName.SetFocus;
    Exit;
  end;

  nIndex := StringGridGameDebugCmd.Row;
  GameCmd := pTGameCmd(StringGridGameDebugCmd.Objects[0, nIndex]);
  if GameCmd <> nil then begin
    GameCmd.sCmd := sCmd;
    GameCmd.nPermissionMin := nPermission;
  end;
  RefDebugCommand();
end;


procedure TfrmGameCmd.EditGameDebugCmdSaveClick(Sender: TObject);
begin
  EditGameDebugCmdSave.Enabled := False;
end;

procedure TfrmGameCmd.FormDestroy(Sender: TObject);
begin
  frmGameCmd:= nil;
end;

procedure TfrmGameCmd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

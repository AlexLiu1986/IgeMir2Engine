unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
const
  ACTORNAMELEN = 14;
  MAPNAMELEN = 16;
  MAX_STATUS_ATTRIBUTE = 12;//20080626 �޸�
type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TOAbility = packed record
    Level: Word; //�ȼ�
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    HP: Word;
    MP: Word;
    MaxHP: Word;
    MaxMP: Word;
    {btReserved1: Byte;//20081001 ע��
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;}
    NG: Word;//20081001 ��ǰ����ֵ
    MaxNG: Word;//20081001 ����ֵ����
    Exp: LongWord;//��ǰ����
    MaxExp: LongWord;//��������
    Weight: Word;
    MaxWeight: Word; //�������
    WearWeight: Byte;
    MaxWearWeight: Byte; //�����
    HandWeight: Byte;
    MaxHandWeight: Byte; //����
  end;
  pTOAbility = ^TOAbility;

  TNakedAbility = packed record //Size 20
    DC: Word;
    MC: Word;
    SC: Word;
    AC: Word;
    MAC: Word;
    HP: Word;
    MP: Word;
    Hit: Word;
    Speed: Word;
    X2: Word;
  end;
  pTNakedAbility = ^TNakedAbility;
  TUserItem = record // 20080313 �޸�
    MakeIndex: Integer;
    wIndex: Word; //��Ʒid
    Dura: Word; //��ǰ�־�ֵ
    DuraMax: Word; //���־�ֵ
    btValue: array[0..20] of Byte;//��������:9-(��������)װ���ȼ� 12-����(1Ϊ����,0������,2�����鲻�ܾۼ�),13-�Զ�������,14-��ֹ��,15-��ֹ����,16-��ֹ��,17-��ֹ��,18-��ֹ����,19-��ֹ���� 20-����(������,1-��ʼ�۾���,2-�۽���)
  end ;                           //11-δʹ�� 8-������Ʒ 10-������������(1-���� 10-12����DC, 20-22����MC��30-32����SC)
  pTUserItem = ^TUserItem;
  THumMagic = record //���＼��  20080106
    wMagIdx: Word;//����ID
    btLevel: Byte;//�ȼ�
    btKey: Byte;//���ܿ�ݼ�
    nTranPoint: Integer; //��ǰ����ֵ
  end;
  pTHumMagic = ^THumMagic;

  TStatusTime = array[0..MAX_STATUS_ATTRIBUTE - 1] of Word;
  TQuestFlag = array[0..127] of Byte;
  TBagItems = array[0..45] of TUserItem;//������Ʒ
  TStorageItems = array[0..45] of TUserItem;

  TUnKnow = array[0..29{39}] of Byte;
  THumMagics = array[0..29{19}] of THumMagic;//���＼��
  THumNGMagics = array[0..29{19}] of THumMagic;//�ڹ�����

  THumanUseItems = array[0..13] of TUserItem;//��չ֧�ֶ��� 20080416
  THumItems = array[0..8] of TUserItem;//9��װ��
  THumAddItems = array[9..13] of TUserItem;//����4��װ�� ��չ֧�ֶ��� 20080416

  pTHumData = ^THumData;
  THumData = packed record {���������� Size = 4254 Ԥ��N������  4402}
    sChrName: string[ACTORNAMELEN];//����
    sCurMap: string[MAPNAMELEN];//��ͼ
    wCurX: Word; //����X
    wCurY: Word; //����Y
    btDir: Byte; //����
    btHair: Byte;//ͷ��
    btSex: Byte; //�Ա�
    btJob: Byte;//ְҵ 0-ս 1-�� 2-�� 3-�̿�
    nGold: Integer;//�����
    Abil: TOAbility;//+40 ������������
    wStatusTimeArr: TStatusTime; //+24 ����״̬����ֵ��һ���ǳ���������
    sHomeMap: string[MAPNAMELEN];//Home ��
    //btUnKnow1: Byte;//δʹ�� ȥ��
    wHomeX: Word;//Home X
    wHomeY: Word;//Home Y
    sDearName: string[ACTORNAMELEN]; //����(��ż)
    sMasterName: string[ACTORNAMELEN];//ʦ������
    boMaster: Boolean;//�Ƿ���ͽ��
    btCreditPoint: Integer;//������ 20080118
    btDivorce: Byte; //�Ƿ���
    btMarryCount: Byte; //������
    sStoragePwd: string[7];//�ֿ�����
    btReLevel: Byte;//ת���ȼ�
    btUnKnow2: array[0..2] of Byte;//0-�Ƿ�ͨԪ������(1-��ͨ) 1-�Ƿ�Ĵ�Ӣ��(1-����Ӣ��) 2-����ʱ�Ƶ�Ʒ��
    BonusAbil: TNakedAbility; //+20 ����
    nBonusPoint: Integer;//������
    nGameGold: Integer;//��Ϸ��
    nGameDiaMond: Integer;//���ʯ 20071226
    nGameGird:Integer;//��� 20071226
    nGamePoint: Integer;//����
    btGameGlory: Byte; //���� 20080511
    nPayMentPoint: Integer; //��ֵ��
    nLoyal: Integer;//Ӣ�۵��ҳ϶�(20080109)
    nPKPOINT: Integer;//PK����
    btAllowGroup: Byte;//�������
    btF9: Byte;
    btAttatckMode: Byte;//����ģʽ
    btIncHealth: Byte;//���ӽ�����
    btIncSpell: Byte;//���ӹ�����
    btIncHealing: Byte;//����������
    btFightZoneDieCount: Byte;//���л�ռ����ͼ����������
    sAccount: string[10];//��¼�ʺ�
    //btEE: Byte;//δʹ��  ȥ��
    btEF: Byte;//Ӣ������ 0-������Ӣ�� 1-����Ӣ�� 20080514
    boLockLogon: Boolean;//�Ƿ�������½
    wContribution: Word;//����ֵ
    nHungerStatus: Integer;//����״̬
    boAllowGuildReCall: Boolean; //  �Ƿ������л��һ
    wGroupRcallTime: Word; //�Ӵ���ʱ��
    dBodyLuck: Double; //���˶�  8
    boAllowGroupReCall: Boolean; // �Ƿ�������غ�һ
    nEXPRATE: Integer; //���鱶��
    nExpTime: Integer; //���鱶��ʱ��
    btLastOutStatus: Byte; //�˳�״̬ 1Ϊ�����˳�
    wMasterCount: Word; //��ʦͽ����
    boHasHero: Boolean; //�Ƿ��а�����Ӣ��
    boIsHero: Boolean; //�Ƿ���Ӣ��
    btStatus: Byte; //״̬
    sHeroChrName: string[ACTORNAMELEN];//Ӣ������
    UnKnow: TUnKnow;//Ԥ�� array[0..29] of Byte; 0-3���ʹ�� 20080620 4-����ʱ�Ķ��� 5-ħ���ܵȼ� 6-�Ƿ�ѧ���ڹ� 7-�ڹ��ȼ�
    QuestFlag: TQuestFlag; //�ű�����
    HumItems: THumItems; //9��װ�� �·�  ����  ���� ͷ�� ���� ���� ���� ��ָ ��ָ
    BagItems: TBagItems; //����װ��
    HumMagics: THumMagics; //ħ��
    StorageItems: TStorageItems; //�ֿ���Ʒ
    HumAddItems: THumAddItems; //����4�� ����� ���� Ь�� ��ʯ
    n_WinExp: longWord;//�ۼƾ��� 20081001
    n_UsesItemTick: Integer;//������ۼ�ʱ�� 20080221
    nReserved: Integer; //��Ƶ�ʱ��,�����ж೤ʱ�����ȡ�ؾ� 20080620
    nReserved1: Integer; //��ǰҩ��ֵ 20080623
    nReserved2: Integer; //ҩ��ֵ���� 20080623
    nReserved3: Integer; //ʹ��ҩ��ʱ��,���㳤ʱ��ûʹ��ҩ�� 20080623
    n_Reserved: Word;   //��ǰ����ֵ 20080622
    n_Reserved1: Word;  //�������� 20080622
    n_Reserved2: Word;  //��ǰ��ƶ� 20080623
    n_Reserved3: Word;  //ҩ��ֵ�ȼ� 20080623
    boReserved: Boolean; //�Ƿ������ T-�����
    boReserved1: Boolean;//�Ƿ�������Ӣ�� 20080519
    boReserved2: Boolean;//�Ƿ���� T-������� 20080620

    boReserved3: Boolean;//���Ƿ�Ⱦ����� 20080627
    m_GiveDate:Integer;//������ȡ�л��Ȫ���� 20080625
    Exp68: LongWord;//�������嵱ǰ���� 20080625
    MaxExp68: LongWord;//���������������� 20080625
    nExpSkill69: Integer;//�ڹ���ǰ���� 20080930
    HumNGMagics: THumNGMagics;//�ڹ����� 20081001
    m_nReserved1: Word;//����
    m_nReserved2: Word;//����
    m_nReserved3: Word;//����
    m_nReserved4: LongWord;//����
    m_nReserved5: LongWord;//����
    m_nReserved6: Integer;//����
    m_nReserved7: Integer;//����
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
ShowMessage(IntToStr(SizeOf(THumData)));
end;

end.

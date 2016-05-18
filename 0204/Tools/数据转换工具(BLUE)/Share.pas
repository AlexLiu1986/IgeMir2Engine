unit Share;

interface

uses Windows;

type
//===============================Blue��LF��ʽ===================================
  TLF_UserItem = record //=24
    MakeIndex: Integer; //+4
    wIndex: Word; //+2
    Dura: word; //+2
    DuraMax: Word; //+2
    btValue: array[0..13] of byte; //+14
  end;

  TLF_NakedAbility = packed record
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

  TNakedAbility = packed record //Size 20  ��TLF_NakedAbilityһ�£�����BLUE�����TNakedAbility
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

  TLF_OAbility = record      //Size 40
    Level: Word; //0x198
    AC: Word; //0x19A
    MAC: Word; //0x19C
    DC: Word; //0x19E
    MC: Word; //0x1A0
    SC: Word; //0x1A2
    HP: Word; //0x1A4
    MP: Word; //0x1A6
    MaxHP: Word; //0x1A8
    MaxMP: Word; //0x1AA
    GAMEDIAMOND: Word;//���ʯ
    GAMEGIRD: Word;//���
    Exp: LongWord; //0x1B0
    MaxExp: LongWord; //0x1B4
    Weight: Word; //0x1B8
    MaxWeight: Word; //0x1BA
    WearWeight: Byte; //0x1BC
    MaxWearWeight: Byte; //0x1BD
    HandWeight: Byte; //0x1BE
    MaxHandWeight: Byte; //0x1BF
  end;

  TLF_HumRecordHeader = packed record
    boDeleted: boolean;
    nSelectID: Byte;
    bt2: Byte;
    bt3: Byte;
    //dCreateDate     :TDateTime;
    UpdateDate: TDateTime;
    sName: string[15];
  end;
  
  TLF_SaveUserMagic = record
    wMagIdx: word;
    btLevel: byte;
    btKey: byte;
    nTranPoint: integer;
  end;

  TLF_HumMagic = array[0..19] of TLF_SaveUserMagic;

  TLF_StatusTime = array[0..11] of Word;

  TLF_QuestFlag = array[0..99] of Byte;
  TLF_QuestOpen = array[0..12] of Byte;

  TLF_HumItems = array[0..8] of TLF_UserItem;
  TLF_BagItems = array[0..45] of TLF_UserItem;
  TLF_StorageItems = array[0..45] of TLF_UserItem;

  TLF_Hum2Items = array[0..3] of TLF_UserItem;

  TLF_HumData = packed record
    sChrName: string[14]; //*
    sCurMap: string[16]; //*
    wCurX: Word; //* NO
    wCurY: Word;//* NO
    btDir: Byte;//*
    btHair: Byte;//*
    btSex: Byte;//*
    btJob: Byte;//*
    nGold: Integer;//* NO
    Abil: TLF_OAbility;//* NO
    wStatusTimeArr: TLF_StatusTime;// NO
    sHomeMap: string[17];//* NO
    wHomeX: Word;//* NO
    wHomeY: Word;//* NO
    sDearName: string[14];//* NO
    sMasterName: string[14];//* NO
    boMaster: Boolean;//*
    btCreditPoint: Byte;//*
    UnKnow: word;// NO
    sStoragePwd: string[7];//* NO
    btReLevel: Byte;//*
    boLockLogon: Boolean;//*
    UnKnow2: word;// NO
    BonusAbil: TNakedAbility;//* NO
    nBonusPoint: Integer;//* NO
    nGameGold: Integer;//* NO
    nGamePoint: Integer;//* NO
    nPayMentPoint: Integer;//* NO
    UnKnow4: Integer;//  NO
    nPKPoint: Integer;//* NO
    btAllowGroup: Byte;//*
    btF9: Byte;//*
    btAttatckMode: Byte;//*
    btIncHealth: Byte;//*
    btIncSpell: Byte;//*
    btIncHealing: Byte;//*
    btFightZoneDieCount: Byte;//*
    sAccount: string[10];//* NO
    btEE: word;//*  NO
    wContribution: Word;//* NO
    nHungerStatus: Integer;//* NO
    boAllowGuildReCall: Boolean;//*
    UnKnow6: byte;
    wGroupRcallTime: Word;//* NO
    dBodyLuck: TDateTime;//*
    boAllowGroupReCall: Boolean;//*
    nTwoExp: integer;//���鱶�� * NO
    nTwoExpTime: integer;//���鱶��ʱ�� * NO
    sHeroName: string[14];//Ӣ���� //* NO
    sMasterHeroName: string[14];//Ӣ�۵������� //* NO
    UnKnow7: array[0..10] of byte;
    sDieMap: string[16];//������ͼ  NO
    wDieX: Word;//����X����  NO
    wDieY: Word;//����Y����  NO
    UnKnow8: byte;
    QuestOpen: TLF_QuestOpen;
    QuestUnit: TLF_QuestOpen;
    QuestFlag: TLF_QuestFlag;//�ű����� *
    HumItems: TLF_HumItems;//*
    BagItems: TLF_BagItems;//*
    Magic: TLF_HumMagic;//*
    StorageItems: TLF_StorageItems;//*
    HumItems2: TLF_Hum2Items;//*
  end;

  TLF_HumDataInfo = packed record
    Header: TLF_HumRecordHeader;
    Data: TLF_HumData;
  end;

  TLF_DBHum = packed record //Size 72  ��ɫ����   //�����Լ��ӵ�
    Header: TLF_HumRecordHeader;
    sChrName: string[14]; //0x14  //��ɫ����   44
    sAccount: string[10]; //�˺�
    boDeleted: Boolean; //�Ƿ�ɾ��
    bt1: Byte; //δʹ��
    dModDate: TDateTime;//��������
    btCount: Byte; //�����ƴ�
    boSelected: Boolean; //�Ƿ���ѡ�������
    n6: array[0..5] of Byte;//δʹ��
  end;

  TDBHeader = record
    sDesc       :String[$23]; //0x00
    n24         :Integer;    //0x24
    n28         :Integer;    //0x28
    n2C         :Integer;    //0x2C
    n30         :Integer;    //0x30
    n34         :Integer;    //0x34
    n38         :Integer;    //0x38
    n3C         :Integer;    //0x3C
    n40         :Integer;    //0x40
    n44         :Integer;    //0x44
    n48         :Integer;    //0x48
    n4C         :Integer;    //0x4C
    n50         :Integer;    //0x50
    n54         :Integer;    //0x54
    n58         :Integer;    //0x58
    nLastIndex  :Integer;    //0x5C
    dLastDate   :TDateTime;  //0x60
    nHumCount   :Integer;    //0x68
    n6C         :Integer;    //0x6C
    n70         :Integer;    //0x70
    dUpdateDate :TDateTime;  //0x74
  end;

  TDBHeader1 = packed record //Size 124
    sDesc: string[$23]; //0x00    36
    n24: Integer; //0x24
    n28: Integer; //0x28
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C
    dLastDate: TDateTime; //����˵�����
    nHumCount: Integer; //0x68
    n6C: Integer; //0x6C
    n70: Integer; //0x70
    dUpdateDate: TDateTime; //��������
  end;
//=============================�Լ������ݿ��ʽ=================================
  TUserItem = record // 20080313 �޸�
    MakeIndex: Integer;
    wIndex: Word; //��Ʒid
    Dura: Word; //��ǰ�־�ֵ
    DuraMax: Word; //���־�ֵ
    btValue: array[0..20] of Byte;//��������  12-����  13-�Զ�������
  end;
  THumMagicInfo = record
    wMagIdx: Word;
    btLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer; //��ǰ�־�ֵ
  end;

  TStatusTime = array[0..11] of Word;
  TUnKnow = array[0..29] of Byte;
  TQuestFlag = array[0..127] of Byte;
  THumItems=Array[0..8] of TUserItem;
  TBagItems=Array[0..45] of TUserItem;
  THumMagic= Array[0..29] of THumMagicInfo;
  THumNGMagics = array[0..29] of THumMagicInfo;//�ڹ����� 20081001
  TStorageItems=Array[0..45] of TUserItem; //20071115
  THumAddItems=Array[9..13] of TUserItem;//֧�ֶ��� 20080416

  TOAbility = packed record
    Level: Word;
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
    Exp: LongWord;
    MaxExp: LongWord;
    Weight: Word;
    MaxWeight: Word; //����
    WearWeight: Byte;
    MaxWearWeight: Byte; //����
    HandWeight: Byte;
    MaxHandWeight: Byte; //����
  end;

  pTHumData = ^THumData;
  THumData = packed record //IGE�����ݽṹ
    sChrName: string[14];
    sCurMap: string[16];
    wCurX: Word;
    wCurY: Word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    Abil: TOAbility; //+40
    wStatusTimeArr: TStatusTime; //+24
    sHomeMap: string[16];
    //btUnKnow1: Byte;��ʹ��,ȥ��
    wHomeX: Word;
    wHomeY: Word;
    sDearName: string[14];
    sMasterName: string[14];//ʦ������
    boMaster: Boolean;
    btCreditPoint: Integer;//������ 20080118
    btDivorce: Byte; //�Ƿ���
    btMarryCount: Byte; //������
    sStoragePwd: string[7];
    btReLevel: Byte;
    btUnKnow2: array[0..2] of Byte;
    BonusAbil: TNakedAbility; //+20
    nBonusPoint: Integer;
    nGameGold: Integer;//��Ϸ��
    nGameDiaMond: Integer;//���ʯ 20071226
    nGameGird:Integer;//��� 20071226
    nGamePoint: Integer;
    btGameGlory: Byte; //���� 20080511
    nPayMentPoint: Integer; //��ֵ��
    nLoyal: Integer;//Ӣ�۵��ҳ϶�(20080109)
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[10];
    //btEE: Byte;//��ʹ��,ȥ��
    btEF: Byte;
    boLockLogon: Boolean;
    wContribution: Word;
    nHungerStatus: Integer;
    boAllowGuildReCall: Boolean; //  �Ƿ������л��һ
    wGroupRcallTime: Word; //�Ӵ���ʱ��
    dBodyLuck: Double; //���˶�  8
    boAllowGroupReCall: Boolean; // �Ƿ�������غ�һ
    nEXPRATE: Integer; //���鱶��
    nExpTime: Integer; //���鱶��ʱ��
    btLastOutStatus: Byte; //2006-01-12���� �˳�״̬ 1Ϊ�����˳�
    wMasterCount: Word; //��ʦͽ����
    boHasHero: Boolean; //�Ƿ���Ӣ��
    boIsHero: Boolean; //�Ƿ���Ӣ��
    btStatus: Byte; //״̬
    sHeroChrName: string[14];
    UnKnow: TUnKnow;
    QuestFlag: TQuestFlag; //�ű�����
    HumItems: THumItems; //9��װ�� �·�  ����  ���� ͷ�� ���� ���� ���� ��ָ ��ָ
    BagItems: TBagItems; //����װ��
    HumMagics: THumMagic; //ħ��
    StorageItems: TStorageItems; //�ֿ���Ʒ
    HumAddItems: THumAddItems; //����4�� ����� ���� Ь�� ��ʯ
    n_WinExp:longWord;//�ۼƾ��� 20081001
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




  TRecordHeader = packed record //Size 12
    boDeleted: Boolean; //�Ƿ�ɾ��
    nSelectID: Byte;   //ID
    boIsHero: Boolean; //�Ƿ�Ӣ��
    bt2: Byte;
    dCreateDate: TDateTime; //����ʱ��
    sName: string[15]; //0x15  //��ɫ����   28
  end;
  pTRecordHeader = ^TRecordHeader;

  TDBHum = packed record //Size 72  ��ɫ����
    Header: TRecordHeader;
    sChrName: string[14]; //0x14  //��ɫ����   44
    sAccount: string[10]; //�˺�
    boDeleted: Boolean; //�Ƿ�ɾ��
    bt1: Byte; //δʹ��
    dModDate: TDateTime;//��������
    btCount: Byte; //�����ƴ�
    boSelected: Boolean; //�Ƿ���ѡ�������
    n6: array[0..5] of Byte;//δʹ��
  end;

  THumDataInfo = packed record //Size 3176
    Header: TRecordHeader;
    Data: THumData;
  end;
  pTHumDataInfo = ^THumDataInfo;
//==============================================================================
const
  DBFileDesc = '����������ݿ��ļ� 2008/10/06';
  sDBIdxHeaderDesc = '����������ݿ������ļ� 2008/10/06';
  g_sProductName = 'BF329B13CBE9010C52BD18E767E1337B1FE06EDB0131F7270D7F5D73905DAA27532F03D7A864C911'; //��Ȩ���� (C) 2008-2010 IGE�Ƽ�
  g_sURL1 = '9BECFDD8143865D36ED84E1462AA3F04DB7F1D649F9A10D276741565D9B98BDA'; //Http://Www.IGEM2.Com
  g_sURL2 = 'DE71C38C94563C0F6ED84E1462AA3F04DB7F1D649F9A10D27F779F085CC2961B'; //Http://Www.IGEM2.Com.Cn

var
  boDataDBReady: Boolean;
  HumDB_CS: TRTLCriticalSection;
implementation

initialization
  begin
    InitializeCriticalSection(HumDB_CS);
  end;

finalization
  begin
    DeleteCriticalSection(HumDB_CS);
  end;     
end.

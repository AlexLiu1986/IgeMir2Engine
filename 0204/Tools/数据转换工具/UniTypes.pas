unit UniTypes;

interface

uses SysUtils, Classes;

type
  TListArray  = array [Ord('A')..Ord('Z') + 10 + 1] of TStrings;

  pTQuickInfo = ^TQuickInfo;
  TQuickInfo  = packed record
    sChrName  : string[16];
    nPosition : Cardinal;
  end;

  //size 124 ID.DB ����ͷ  
  TDBHeader = packed record
    sDesc: string[34]; //0x00    #
    n23: Integer; //0x23
    n28: Integer; //0x27
    n2C: Integer; //0x2B
    n30: Integer; //0x2F
    n34: Integer; //0x33
    n38: Integer; //0x37
    n3C: Integer; //0x3B
    n40: Integer; //0x3F
    n44: Integer; //0x43
    n48: Integer; //0x47
    n4B: Byte; //0x4B
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C �������� #
    dLastDate: TDateTime; //0x60           #
    nIDCount: Integer; //0x68 ID����       #
    n6C: Integer; //0x6C
    nDeletedIdx: Integer; //0x70     := -1 #
    dUpdateDate: TDateTime; //0x74         # 
  end;
  pTDBHeader = ^TDBHeader;

  //��������ͷ
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

  TRecordHeader = packed record //Size 12
    boDeleted: Boolean; //�Ƿ�ɾ��
    nSelectID: Byte;   //ID
    boIsHero: Boolean; //�Ƿ�Ӣ��
    bt2: Byte;
    dCreateDate: TDateTime; //����ʱ��
    sName: string[15]; //0x15  //��ɫ����   28
  end;
  pTRecordHeader = ^TRecordHeader;

{THumInfo}
  pTDBHum       = ^TDBHum;
  TDBHum        = packed record     //FileHead  72�ֽ�   //Size 72
    Header: TRecordHeader;
    sChrName: string[14]; //0x14  //��ɫ����   44
    sAccount: string[10]; //�˺�
    boDeleted: Boolean; //�Ƿ�ɾ��
    bt1: Byte; //δ֪
    dModDate: TDateTime;//��������
    btCount: Byte; //�����ƴ�
    boSelected: Boolean; //�Ƿ�ѡ��
    n6: array[0..5] of Byte;
  end;

  pTUserItem = ^TUserItem;
  TUserItem = record // 20080313 �޸�
    MakeIndex: Integer;
    wIndex: Word; //��Ʒid
    Dura: Word; //��ǰ�־�ֵ
    DuraMax: Word; //���־�ֵ
    btValue: array[0..20] of Byte;//��������  12-����  13-�Զ�������
  end;

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
    btReserved1: Byte;
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;
    Exp: LongWord;
    MaxExp: LongWord;
    Weight: Word;
    MaxWeight: Word; //����
    WearWeight: Byte;
    MaxWearWeight: Byte; //����
    HandWeight: Byte;
    MaxHandWeight: Byte; //����
  end;

  pTNakedAbility=^TNakedAbility;
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

  pTHumMagicInfo= ^THumMagicInfo;
  THumMagicInfo = record
    wMagIdx: Word;
    btLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer; //��ǰ�־�ֵ
  end;

  TUnKnow = array[0..39] of Byte;
 // TStatusTime = array[0..11] of LongWord; 20071115
  TStatusTime = array[0..11] of Word;
 // TQuestUnit = Array[0..23] of Byte; 20071115
  TQuestUnit = Array[0..127] of Byte;
 // TQuestFlag = Array[0..100] of Byte; 20071115
  TQuestFlag = array[0..127] of Byte;
 // THumanUseItems = array[0..13] of TUserItem;

  pTHumItems=^THumItems;
  THumItems=Array[0..8] of TUserItem;
  pTHumAddItems=^THumAddItems;
  THumAddItems=Array[9..13] of TUserItem;//֧�ֶ��� 20080416
  pTBagItems = ^TBagItems;
  TBagItems=Array[0..45] of TUserItem;
  THumMagic=Array[0..19] of THumMagicInfo;
  pTHumMagic=^THumMagic;
  TStorageItems=Array[0..45] of TUserItem; //20071115
  TAddBagItems=Array[46..51] of TUSerItem;
  pTStorageItems=^TStorageItems;

//û���õ� 20071115  
  pTSQLQueryHumInfo  = ^TSQLQueryHumInfo;
  TSQLQueryHumInfo   = packed record
    boDeleted   : Boolean;
    boDisAbled  : Boolean;
    boSelected  : Boolean;
    btJob       : Byte;
    btHair      : Byte;
    btSex       : Byte;
    wLevel      : Word;
    dModDate    : TDateTime;
  end;

  TSearchLikeMode = (slAny, slBlack, slFront);
  
  pTnewHumData = ^TnewHumData;
  TnewHumData = packed record //�µ����ݽṹ
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
    btUnKnow1: Byte;
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
    N: Integer;//Ӣ�۵��ҳ϶�(20080109)
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[10];
    btEE: Byte;
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
    n_WinExp:integer;//�ۼƾ��� 20080110
    n_UsesItemTick: Integer;//������ۼ�ʱ�� 20080221

    nReserved: Integer; //����
    nReserved1: Integer; //����
    nReserved2: Integer; //����
    nReserved3: Integer; //����
    n_Reserved: Word;   //����
    n_Reserved1: Word;  //����
    n_Reserved2: Word;  //����
    n_Reserved3: Word;  //����
    boReserved: Boolean; //����
    boReserved1: Boolean;//����
    boReserved2: Boolean;//����
    boReserved3: Boolean;//����
    sReserved:string[20];//����
    sReserved1:string[20];//����
  end;

  pTHumData = ^THumData;
  THumData = packed record //�ɵ����ݽṹ
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
    btUnKnow1: Byte;
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
    nPayMentPoint: Integer; //��ֵ��
    N: Integer;//Ӣ�۵��ҳ϶�(20080109)
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[10];
    btEE: Byte;
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
    n_WinExp:integer;//�ۼƾ��� 20080110
    n_UsesItemTick: Integer;//������ۼ�ʱ�� 20080221
  end;

  THumDataInfo = packed record //Size 3176
    Header: TRecordHeader;
    Data: THumData;
  end;
  pTHumDataInfo = ^THumDataInfo;

  TNewHumDataInfo = packed record //�µ����ݽṹ
    Header: TRecordHeader;
    Data: TNewHumData;
  end;
  pTNewHumDataInfo = ^TNewHumDataInfo;


  pTHumData1 = ^THumData1;
  THumData1 = packed record //�ɵ����ݽṹ--2
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
    btUnKnow1: Byte;
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
    N: Integer;//Ӣ�۵��ҳ϶�(20080109)
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[10];
    btEE: Byte;
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
    n_WinExp:integer;//�ۼƾ��� 20080110
    n_UsesItemTick: Integer;//������ۼ�ʱ�� 20080221
  end;

  THumDataInfo1 = packed record //Size 3176
    Header: TRecordHeader;
    Data: THumData1;
  end;
  pTHumDataInfo1 = ^THumDataInfo1;
  
//�û�ע����Ϣ,��ID�˺�
  TUserEntry = packed record
    sAccount: string[10];//�˺�
    sPassword: string[10]; //����
    sUserName: string[20];//�û���
    sSSNo: string[14];  //���֤
    sPhone: string[14];
    sQuiz: string[20];
    sAnswer: string[12];
    sEMail: string[40]; //����
  end;

  TUserEntryAdd = packed record
    sQuiz2: string[20];
    sAnswer2: string[12];
    sBirthDay: string[10];
    sMobilePhone: string[13];
    sMemo: string[20];
    sMemo2: string[20];
  end;

//�˺ż�¼ͷ   size 32
  TIDRecordHeader = packed record
    boDeleted: Boolean;//�Ƿ�ɾ��
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime; //����ʱ��
    UpdateDate: TDateTime; //����¼ʱ��
    sAccount: string[11]; //�˺�
  end;

  TAccountDBRecord = packed record  //size 328
    Header: TIDRecordHeader;
    UserEntry: TUserEntry; //ID�˺���Ϣ
    UserEntryAdd: TUserEntryAdd;
    nErrorCount: Integer;
    dwActionTick: LongWord;
    N: array[0..38] of Byte;
  end;

const
  DBFileDesc = '����������ݿ��ļ� 2007/11/14';

function  GetFirstChar(const  AHzStr:  string):  string;
function  GetWWIndex(const S: string): Integer;
function  _Max14ReName(S: string; DefChar: Char): string;
function  _Max10ReName(S: string; DefChar: Char): string;

implementation

function  GetFirstChar(const  AHzStr:  string):  string;
const
   ChinaCode:  array[0..25,  0..1]  of  Integer  =  ((1601,  1636),
                                                     (1637,  1832),
                                                     (1833,  2077),
                                                     (2078,  2273),
                                                     (2274,  2301),
                                                     (2302,  2432),
                                                     (2433,  2593),
                                                     (2594,  2786),
                                                     (9999,  0000),
                                                     (2787,  3105),
                                                     (3106,  3211),
                                                     (3212,  3471),
                                                     (3472,  3634),
                                                     (3635,  3722),
                                                     (3723,  3729),
                                                     (3730,  3857),
                                                     (3858,  4026),
                                                     (4027,  4085),
                                                     (4086,  4389),
                                                     (4390,  4557),
                                                     (9999,  0000),
                                                     (9999,  0000),
                                                     (4558,  4683),
                                                     (4684,  4924),
                                                     (4925,  5248),
                                                     (5249,  5589));
var  
   i, j, HzOrd:  Integer;
begin  
   i  :=  1;
   while  i  <=  Length(AHzStr)  do  
    begin
      if  (AHzStr[i]  >=  #160)  and  (AHzStr[i  +  1]  >=  #160)  then
        begin
          HzOrd  :=  (Ord(AHzStr[i])  -  160)  *  100  +  Ord(AHzStr[i  +  1])  -  160;
          for  j  :=  0  to  25  do
            begin
              if  (HzOrd  >=  ChinaCode[j][0])  and  (HzOrd  <=  ChinaCode[j][1])  then
               begin
                Result  :=  Result  +  Char(Byte('A')  +  j);
                Break;
               end;
            end;
          Inc(i);
        end  else  Result  :=  Result  +  AHzStr[i];
      Inc(i);
    end;
  Result := UpperCase(Result);
end;

function GetWWIndex(const S: string): Integer;
var
  Str2: string;
begin
  Str2  :=  GetFirstChar(S);
  Result  := High(TListArray);
  if Str2 <> '' then
    begin
      Result := Ord(Str2[1]);
      if Result < 65 then
        Result := Result - 47 + 90;
    end;
  if Result > High(TListArray) - 1
    then Result := High(TListArray);
end;

function  _Max14ReName(S: string; DefChar: Char): string;
begin
  if Length(S) >= 14 then
    begin
     case ByteType(S, Length(S)) of
       mbSingleByte: S := Copy(S, 1, Length(S) - 1);
       mbLeadByte,
       mbTrailByte : S := Copy(S, 1, Length(S) - 2);
     end;
    end;
  Result  := S + DefChar;
end;

function  _Max10ReName(S: string; DefChar: Char): string;
begin
  if Length(S) >= 10 then
    begin
     case ByteType(S, Length(S)) of
       mbSingleByte: S := Copy(S, 1, Length(S) - 1);
       mbLeadByte,
       mbTrailByte : S := Copy(S, 1, Length(S) - 2);
     end;
    end;
  Result  := S + DefChar;
end;

end.


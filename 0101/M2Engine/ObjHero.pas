{------------------------------------------------------------------------------}
{ ��Ԫ����: ObjHero.pas                                                        }
{                                                                              }
{ ��Ԫ����: Mars                                                               }
{ ��������: 2007-02-12 20:30:00                                                }
{                                                                              }
{ ���ܽ���: ʵ��Ӣ�۹��ܵ�Ԫ                                                   }
{------------------------------------------------------------------------------}
unit ObjHero;

interface
uses
  Windows, SysUtils, Classes, Grobal2, ObjBase, Castle;
type
  THeroObject = class(TBaseObject)
    m_dwDoMotaeboTick: LongWord; //Ұ����ײ���  20080529
    m_dwThinkTick: LongWord;
    m_boDupMode: Boolean;  //�����ص���
    //m_nNotProcessCount: Integer;//δʹ�� 20080329
    m_nTargetX: Integer;//Ŀ������X
    m_nTargetY: Integer;//Ŀ������Y
    m_boRunAwayMode: Boolean;  //����Զ��ģʽ
    m_dwRunAwayStart: LongWord;
    m_dwRunAwayTime: LongWord;
    //m_boCanPickUpItem: Boolean;//�ܼ�����Ʒ //20080428 ע��
    //m_boSlavePickUpItem: Boolean;
    m_dwPickUpItemTick: LongWord;//������Ʒ���
    //m_boIsPickUpItem: Boolean;//20080428 ע��
    //m_nPickUpItemMakeIndex: Integer;//20080428 ע��
    m_SelMapItem: PTMapItem;

    m_wHitMode: Word;//������ʽ

    m_btOldDir: Byte;
    m_dwActionTick: LongWord;//�������
    m_wOldIdent: Word;

    m_dwTurnIntervalTime: LongWord;//ת�����ʱ��
    m_dwMagicHitIntervalTime: LongWord;//ħ��������ʱ��
    //m_dwHitIntervalTime: LongWord;//������ʱ��(δʹ�� 20080510)
    m_dwRunIntervalTime: LongWord;//�ܼ��ʱ��
    m_dwWalkIntervalTime: LongWord;//�߼��ʱ��

    m_dwActionIntervalTime: LongWord;//�������ʱ��
    m_dwRunLongHitIntervalTime: LongWord;//���г������ʱ��
    m_dwWalkHitIntervalTime: LongWord;//�߶��������ʱ��
    m_dwRunHitIntervalTime: LongWord;//�ܹ������ʱ��
    m_dwRunMagicIntervalTime: LongWord;//��ħ�����ʱ��

    m_nDieDropUseItemRate: Integer; //������װ������
    m_SkillUseTick: array[0..80 - 1] of LongWord; //ħ��ʹ�ü��
    m_nItemBagCount: Integer;//��������
    m_btStatus: Byte; //״̬ 0-���� 1-���� 2-��Ϣ
    m_boProtectStatus: Boolean;//�Ƿ����ػ�״̬
    m_boProtectOK: Boolean;//�����ػ����� 20080603
    m_boTarget: Boolean; //�Ƿ�����Ŀ��
    m_nProtectTargetX, m_nProtectTargetY: Integer; //�ػ�����
    m_dwAutoAvoidTick: LongWord;//�Զ���ܼ��
    m_boIsNeedAvoid: Boolean;//�Ƿ���Ҫ���

    m_dwEatItemNoHintTick: LongWord;//Ӣ��ûҩ��ʾʱ����  20080129
    m_dwEatItemTick: LongWord;//����ͨҩ���
    m_dwEatItemTick1: LongWord;//������ҩ��� 20080910
    m_dwSearchIsPickUpItemTick: LongWord;//�����ɼ������Ʒ���
    m_dwSearchIsPickUpItemTime: LongWord;//�����ɼ������Ʒʱ��
    m_boCanDrop: Boolean;//�Ƿ���������
    m_boCanUseItem: Boolean; //�Ƿ�����ʹ����Ʒ
    m_boCanWalk: Boolean;//�Ƿ�������
    m_boCanRun: Boolean;//�Ƿ�������
    m_boCanHit: Boolean;//�Ƿ�������
    m_boCanSpell: Boolean;//�Ƿ�����ħ��
    m_boCanSendMsg: Boolean;//�Ƿ���������Ϣ
    m_btReLevel: Byte; //ת���ȼ�
    m_btCreditPoint: Integer;//������ 20080118
    m_nMemberType: Integer; //��Ա����
    m_nMemberLevel: Integer;//��Ա�ȼ�
    m_nKillMonExpRate: Integer; //ɱ�־���ٷ���(�������� 100 Ϊ��������)
    m_nOldKillMonExpRate: Integer;//ûʹ����װǰɱ�־��鱶�� 20080522

    m_dwMagicAttackInterval: LongWord;//ħ���������ʱ��(Dword)
    m_dwMagicAttackTick: LongWord;//ħ������ʱ��(Dword)
    m_dwMagicAttackCount: LongWord; //ħ����������(Dword) 20080510 
    //m_dwSearchMagic: LongWord; //����ħ�����  û��ʹ��
    m_nSelectMagic: Integer;//��ѯħ��
    m_boIsUseMagic: Boolean;//�Ƿ����ʹ�õ�ħ��(True�ſ��ܶ��) 20080714

    m_boIsUseAttackMagic: Boolean;//�Ƿ����ʹ�õĹ���ħ��
    m_btLastDirection: Byte;//���ķ���
    m_wLastHP: Word;//����HPֵ
    m_nPickUpItemPosition: Integer;//�ɼ�����Ʒ��λ��
    m_nFirDragonPoint: Integer;//Ӣ��ŭ��ֵ
    m_dwAddFirDragonTick: LongWord;//����Ӣ��ŭ��ֵ�ļ��
    m_boStartUseSpell: Boolean;//�Ƿ�ʼʹ�úϻ�
    m_boDecDragonPoint:Boolean;//��ʼ��ŭ�� 20080418
   // m_nStartUseSpell: Integer;
    m_dwStartUseSpellTick: LongWord;//ʹ�úϻ��ļ��
    m_boNewHuman: Boolean;//�Ƿ�Ϊ������
    m_nLoyal:Integer;//Ӣ�۵��ҳ϶�(20080110)
    m_dwCheckNoHintTick: LongWord;//Ӣ��û������ʾʱ����  20080328
    n_AmuletIndx: Byte;//�̺춾��ʶ 20080412
    n_HeroTpye: Byte;//Ӣ������ 0-������Ӣ�� 1-����Ӣ�� 20080514
    m_dwDedingUseTick: LongWord;//�ض�ʹ�ü�� 20080524
    boCallLogOut: Boolean;//�Ƿ��ٻ���ȥ 20080605

    m_dwAddAlcoholTick: LongWord;//���Ӿ������ȵļ��  20080623
    m_dwDecWineDrinkValueTick: LongWord;//������ƶȵļ��  20080623
    n_DrinkWineQuality: Byte;//����ʱ�Ƶ�Ʒ�� 20080623
    n_DrinkWineAlcohol: Byte;//����ʱ�ƵĶ��� 20080624
    n_DrinkWineDrunk: Boolean;//�Ⱦ����� 20080623
    dw_UseMedicineTime: Integer; //ʹ��ҩ��ʱ��,���㳤ʱ��ûʹ��ҩ�� 20080623
    n_MedicineLevel: Word;  //ҩ��ֵ�ȼ� 20080623

    dwRockAddHPTick: LongWord;//ħѪʯ��HP ʹ�ü�� 20080728
    dwRockAddMPTick: LongWord;//ħѪʯ��MP ʹ�ü�� 20080728
    m_Exp68: LongWord;//�������嵱ǰ���� 20080925
    m_MaxExp68: LongWord;//���������������� 20080925
    boAutoOpenDefence: Boolean;//�Զ�����ħ���� 20080930

    m_boTrainingNG: Boolean;//�Ƿ�ѧϰ���ڹ� 20081002
    m_NGLevel: Byte;//�ڹ��ȼ� 20081002
    m_ExpSkill69: LongWord;//�ڹ��ķ���ǰ���� 20080930
    m_MaxExpSkill69: LongWord;//�ڹ��ķ��������� 20080930
    m_Skill69NH: Word;//��ǰ����ֵ 20080930
    m_Skill69MaxNH: Word;//�������ֵ 20080930
    m_dwIncNHTick: LongWord;//��������ֵ��ʱ 20081002

    m_Magic46Skill: pTUserMagic; //������ 20081217
    m_MagicSkill_200: pTUserMagic;//ŭ֮��ɱ
    m_MagicSkill_201: pTUserMagic;//��֮��ɱ
    m_MagicSkill_202: pTUserMagic;//ŭ֮����
    m_MagicSkill_203: pTUserMagic;//��֮����
    m_MagicSkill_204: pTUserMagic;//ŭ֮�һ�
    m_MagicSkill_205: pTUserMagic;//��֮�һ�
    m_MagicSkill_206: pTUserMagic;//ŭ֮����
    m_MagicSkill_207: pTUserMagic;//��֮����
    
    m_MagicSkill_208: pTUserMagic;//ŭ֮����
    m_MagicSkill_209: pTUserMagic;//��֮����
    m_MagicSkill_210: pTUserMagic;//ŭ֮�����
    m_MagicSkill_211: pTUserMagic;//��֮�����
    m_MagicSkill_212: pTUserMagic;//ŭ֮��ǽ
    m_MagicSkill_213: pTUserMagic;//��֮��ǽ
    m_MagicSkill_214: pTUserMagic;//ŭ֮������
    m_MagicSkill_215: pTUserMagic;//��֮������
    m_MagicSkill_216: pTUserMagic;//ŭ֮�����Ӱ
    m_MagicSkill_217: pTUserMagic;//��֮�����Ӱ
    m_MagicSkill_218: pTUserMagic;//ŭ֮���ѻ���
    m_MagicSkill_219: pTUserMagic;//��֮���ѻ���
    m_MagicSkill_220: pTUserMagic;//ŭ֮������
    m_MagicSkill_221: pTUserMagic;//��֮������
    m_MagicSkill_222: pTUserMagic;//ŭ֮�׵�
    m_MagicSkill_223: pTUserMagic;//��֮�׵�
    m_MagicSkill_224: pTUserMagic;//ŭ֮�����׹�
    m_MagicSkill_225: pTUserMagic;//��֮�����׹�
    m_MagicSkill_226: pTUserMagic;//ŭ֮������
    m_MagicSkill_227: pTUserMagic;//��֮������
    m_MagicSkill_228: pTUserMagic;//ŭ֮�����
    m_MagicSkill_229: pTUserMagic;//��֮�����
    m_MagicSkill_230: pTUserMagic;//ŭ֮���
    m_MagicSkill_231: pTUserMagic;//��֮���
    m_MagicSkill_232: pTUserMagic;//ŭ֮��Ѫ
    m_MagicSkill_233: pTUserMagic;//��֮��Ѫ
    m_MagicSkill_234: pTUserMagic;//ŭ֮���ǻ���
    m_MagicSkill_235: pTUserMagic;//��֮���ǻ���
    m_MagicSkill_236: pTUserMagic;//ŭ֮�ڹ�����
    m_MagicSkill_237: pTUserMagic;//��֮�ڹ�����

    m_GetExp: LongWord;//����ȡ�õľ���,$GetExp����ʹ��  20081228
    m_AvoidHp: Word;//����Ѫ�� 20081225
    m_boCrazyProtection: Boolean;//����񻯱��� 20081225
  private
    function Think: Boolean;
    function SearchPickUpItem(nPickUpTime: Integer): Boolean; //����Ʒ
    procedure EatMedicine();//��ҩ
    function AutoEatUseItems(btItemType: Byte): Boolean; //�Զ���ҩ
    function WarrAttackTarget(wHitMode: Word): Boolean; {������}
    function WarrorAttackTarget(): Boolean; {սʿ����}
    function WizardAttackTarget(): Boolean; {��ʦ����}
    function TaoistAttackTarget(): Boolean; {��ʿ����}
   // function CompareHP(BaseObject1, BaseObject2: TBaseObject): Boolean;//�Ƚ�HPֵ  20080117
   // function CompareLevel(BaseObject1, BaseObject2: TBaseObject): Boolean;//�Ƚϵȼ� 20080117
   // function CompareXY(BaseObject1, BaseObject2: TBaseObject): Boolean;//�Ƚ�XYֵ 20080117
    function EatUseItems(nShape: Integer): Boolean;//ʹ�õ���Ʒ
    function AutoAvoid(): Boolean; //�Զ����

    function SearchIsPickUpItem(): Boolean;//�Ƿ���Լ����Ʒ
   // function IsPickUpItem(StdItem: pTStdItem): Boolean; 20080117

    function IsNeedAvoid(): Boolean; //�Ƿ���Ҫ���

    function CheckUserMagic(wMagIdx: Word): pTUserMagic;//���ʹ��ħ��
    function CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
    function CheckTargetXYCount1(nX, nY, nRange: Integer): Integer;//սʿ�ж�Ŀ��ʹ�� 20080924
    function CheckTargetXYCount2(): Integer;//�����䵶�ж�Ŀ�꺯�� 20081207

    function GotoTargetXYRange(): Boolean;
    function GetUserItemList(nItemType: Integer; nItemShape: Integer): Integer;
    function UseItem(nItemType, nIndex: Integer; nItemShape: Integer): Boolean;
    function CheckUserItemType(nItemType: Integer; nItemShape: Integer): Boolean;
    function CheckItemType(nItemType: Integer; StdItem: pTStdItem; nItemShape: Integer): Boolean;
    function CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;{���ָ������ͷ�Χ������Ĺ�������}
    function CheckMasterXYOfDirection(TargeTBaseObject: TBaseObject;nX, nY, nDir, nRange: Integer): Integer;{���ָ������ͷ�Χ��,������Ӣ�۵ľ��� 20080204}
    procedure SearchMagic(); //����ħ��
    function SelectMagic(): Integer; //ѡ��ħ��
    //function IsUseMagic(): Boolean; //����Ƿ����ʹ�ñ���ħ�� δʹ�� 20080412
    function IsUseAttackMagic(): Boolean;
    function IsSearchTarget: Boolean;
    function CheckActionStatus(wIdent: Word; var dwDelayTime: LongWord): Boolean; //��鶯����״̬
    //function GetSpellMsgCount: Integer;//ȡ������Ϣ����
    function DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean;
    function CallMobeItem(): Boolean;//�ٻ�ǿ����,���г��ı������7��  20080329
    procedure RepairAllItem(DureCount: Integer; boDec: Boolean);//ȫ���޸�
    Function RepairAllItemDura:Integer;//ȫ���޸�,��Ҫ�ĳ־�ֵ 20080325
    function GetTogetherUseSpell: Integer;
    Function CheckHeroAmulet(nType: Integer; nCount: Integer):Boolean; //�жϵ�Ӣ�۶����Ƿ�����,��ʾ�û� 20080401
    function UseStdmodeFunItem(StdItem: pTStdItem): Boolean;//Ӣ��ʹ����Ʒ����  20080728
    procedure PlaySuperRock;//��Ѫʯ���� 20080729
    function MagMakeHPUp(UserMagic: pTUserMagic): Boolean;//�������� 20080925
    procedure RecalcAdjusBonus();//ˢ��Ӣ������������20081126
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;//������Ϣ
    function AttackTarget(): Boolean;//����Ŀ��
    function CheckTakeOnItems(nWhere: Integer; var StdItem: TStdItem): Boolean;
    function IsEnoughBag(): Boolean;
    procedure RecalcAbilitys; override;
    procedure Run; override;
    procedure Die; override;
    function GetShowName(): string; override;
    procedure ItemDamageRevivalRing();
    procedure DoDamageWeapon(nWeaponDamage: Integer);
    procedure StruckDamage(nDamage: Integer);override;//����override;���ع��� 20080607
    function IsAllowUseMagic(wMagIdx: Word): Boolean;
    procedure SearchTarget();
    procedure DelTargetCreat(); override;
    procedure SetTargetXY(nX, nY: Integer); virtual;
    function WalkToTargetXY2(nTargetX, nTargetY: Integer): Boolean;
    function WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
    function RunToTargetXY(nTargetX, nTargetY: Integer): Boolean;
    function GetGotoXY(BaseObject: TBaseObject; nCode:Byte): Boolean;
    function GotoTargetXY(nTargetX, nTargetY, nCode: Integer): Boolean;

    procedure Wondering(); virtual;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); virtual; //����
    procedure Struck(hiter: TBaseObject); virtual;

    procedure ClientQueryBagItems();
    function FindMagic(wMagIdx: Word): pTUserMagic;//����ħ��
    procedure RefMyStatus();
    function AddItemToBag(UserItem: pTUserItem): Boolean;
    procedure WeightChanged;
    function ReadBook(StdItem: pTStdItem): Boolean;
    function EatItems(StdItem: pTStdItem): Boolean;
    procedure SysMsg(sMsg: string; MsgColor: TMsgColor; MsgType: TMsgType);
    procedure SendSocket(DefMsg: pTDefaultMessage; sMsg: string);
    procedure SendDefMessage(wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: string);
    procedure SendMsg(BaseObject: TBaseObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: string);
    procedure SendUpdateMsg(BaseObject: TBaseObject; wIdent, wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: string);
    procedure SendDelayMsg(BaseObject: TBaseObject; wIdent, wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: string; dwDelay: LongWord);
    procedure SendUpdateDelayMsg(BaseObject: TBaseObject; wIdent, wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: string; dwDelay: LongWord);
    procedure SendChangeItems(nWhere1, nWhere2: Integer; UserItem1, UserItem2: pTUserItem);
    procedure SendUseitems();
    procedure SendUseMagic();
    procedure SendDelMagic(UserMagic: pTUserMagic);
    procedure SendAddMagic(UserMagic: pTUserMagic);
    procedure SendAddItem(UserItem: pTUserItem);
    procedure SendDelItemList(ItemList: TStringList);
    procedure SendDelItems(UserItem: pTUserItem);
    procedure SendUpdateItem(UserItem: pTUserItem);
    procedure ClientHeroUseItems(nItemIdx: Integer; sItemName: string); //Ӣ�۳�ҩ
    procedure GetBagItemCount;
    procedure MakeWeaponUnlock;
    function WeaptonMakeLuck: Boolean;
    function RepairWeapon: Boolean;
    function SuperRepairWeapon: Boolean;
    procedure GetNGExp(dwExp: LongWord; Code: Byte);//ȡ���������� 20081001
    procedure GetExp(dwExp: LongWord);//ȡ�þ���
    procedure WinExp(dwExp: LongWord);
    procedure GainExp(dwExp: LongWord);
    function AbilityUp(UserMagic: pTUserMagic): Boolean;
    function ClientSpellXY(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
      TargeTBaseObject: TBaseObject): Boolean;
    function ClientDropItem(sItemName: string; nItemIdx: Integer): Boolean;
    function DoSpell(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; BaseObject: TBaseObject): Boolean;
    function FindTogetherMagic: pTUserMagic;
    function WearFirDragon: Boolean;
    procedure RepairFirDragon(btType: Byte; nItemIdx: Integer; sItemName: string);//�޲�����֮��

    procedure MakeSaveRcd(var HumanRcd: THumDataInfo);
    procedure Login();
    function LevelUpFunc: Boolean;//Ӣ���������� 20080423
    function IsNeedGotoXY(): Boolean; //�Ƿ�����Ŀ��
    procedure ChangeHeroMagicKey(nSkillIdx, nKey: Integer);//����Ӣ��ħ������ 20080606
    procedure ClearCopyItem(wIndex, MakeIndex: Integer);//����Ӣ�۰�������Ʒ 20080901
    function GetSpellPoint(UserMagic: pTUserMagic): Integer;//ȡʹ��ħ�������MPֵ
    procedure NGMAGIC_LVEXP(UserMagic: pTUserMagic);//�ڹ��������� 20081003
    function CheckItemBindDieNoDrop(UserItem: pTUserItem): Boolean;//�������װ��������Ʒ�Ƿ� 20081127
  end;

implementation
uses UsrEngn, M2Share, Event, Envir, Magic, HUtil32, EDcode,PlugOfEngine;

{ THeroObject }

constructor THeroObject.Create;
begin
  inherited;
  boCallLogOut:= False;
  m_btRaceServer := RC_HEROOBJECT;
  m_boDupMode := False;
  m_dwThinkTick := GetTickCount();
  m_nViewRange := 12;
  m_nRunTime := 250;
  m_dwSearchTick := GetTickCount();
  m_nCopyHumanLevel := 3;
  //m_nNotProcessCount := 0;//δʹ�� 20080329
  m_nTargetX := -1;
  dwTick3F4 := GetTickCount();
  m_btNameColor := g_Config.nHeroNameColor{6};//���ֵ���ɫ  20080315
  m_boFixedHideMode := True;
  //m_dwHitIntervalTime := g_Config.dwHitIntervalTime; //�������
  m_dwMagicHitIntervalTime := g_Config.dwMagicHitIntervalTime; //Ӣ��ħ���������{û��ʹ�� 20080217}

  //m_dwRunIntervalTime := g_Config.dwHeroRunIntervalTime;//Ӣ���ܲ���� 20080213
  //m_dwRunIntervalTime := g_Config.dwRunIntervalTime; //Ӣ���ܲ���� 20080329
  m_dwRunIntervalTime := GetTickCount();//20080925 �޸�

{  case m_btJob of //20080222 ����Ӣ��ְҵ�������ܲ����
   0: m_dwRunIntervalTime := g_Config.dwHeroRunIntervalTime;//Ӣ���ܲ����
   1: m_dwRunIntervalTime := g_Config.dwHeroRunIntervalTime1;//Ӣ���ܲ����
   2: m_dwRunIntervalTime := g_Config.dwHeroRunIntervalTime2;//Ӣ���ܲ����
  end;  }
  m_dwWalkIntervalTime := g_Config.dwHeroWalkIntervalTime; //Ӣ����·���  20080213
  m_dwTurnIntervalTime := g_Config.dwHeroTurnIntervalTime; //Ӣ�ۻ������� 20080213
  m_dwActionIntervalTime := g_Config.dwActionIntervalTime; //��ϲ������
  m_dwRunLongHitIntervalTime := g_Config.dwRunLongHitIntervalTime; //��ϲ������
  m_dwRunHitIntervalTime := g_Config.dwRunHitIntervalTime; //��ϲ������
  m_dwWalkHitIntervalTime := g_Config.dwWalkHitIntervalTime; //��ϲ������
  m_dwRunMagicIntervalTime := g_Config.dwRunMagicIntervalTime; //��λħ�����

  m_dwHitTick := GetTickCount - LongWord(Random(3000));
  m_dwWalkTick := GetTickCount - LongWord(Random(3000));
  m_nWalkSpeed := 350;//20081005 ԭΪ300
  m_nWalkStep := 10;
  m_dwWalkWait := 0;
  m_dwSearchEnemyTick := GetTickCount();
  m_boRunAwayMode := False;
  m_dwRunAwayStart := GetTickCount();
  m_dwRunAwayTime := 0;
  //m_boCanPickUpItem := True;//20080428 ע��
  //m_boSlavePickUpItem := False;//20080428 ע��
  m_dwPickUpItemTick := GetTickCount();
  m_dwAutoAvoidTick := GetTickCount();
  m_dwEatItemTick := GetTickCount();
  m_dwEatItemTick1 := GetTickCount();//20080910
  m_dwEatItemNoHintTick := GetTickCount(); //20080129
  m_boIsNeedAvoid := False;
  m_SelMapItem := nil;
  //m_boIsPickUpItem := False;//20080428 ע��
  m_nNextHitTime := 300;//�´ι���ʱ��
  m_nDieDropUseItemRate := 100;
  m_nItemBagCount := 10;
  m_btStatus := 0; //״̬ Ĭ��Ϊ���� 20080323
  m_boProtectStatus := False; //�Ƿ����ػ�״̬
  m_boProtectOK := False;//�����ػ����� 20080603
  m_boTarget := False; //�Ƿ�����Ŀ��

  m_nProtectTargetX := -1; //�ػ�����
  m_nProtectTargetY := -1; //�ػ�����

  m_boCanDrop := True; //�Ƿ���������Ʒ
  m_boCanUseItem := True; //�Ƿ�����ʹ����Ʒ
  m_boCanWalk := True;
  m_boCanRun := True;
  m_boCanHit := True;
  m_boCanSpell := True;
  m_boCanSendMsg := True;
  m_btReLevel := 0;
  m_btCreditPoint := 0;
  m_nMemberType := 0;
  m_nMemberLevel := 0;
  m_nKillMonExpRate := 100;
  m_nOldKillMonExpRate := m_nKillMonExpRate;//20080522
  m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080714
  m_boIsUseAttackMagic := False;
  m_nSelectMagic := 0;
  m_nPickUpItemPosition := 0;
  m_nFirDragonPoint := 0;//20080419 ŭ�����ó�ʼ��,
  m_dwAddFirDragonTick := GetTickCount();
  m_btLastDirection := m_btDirection;
  m_wLastHP := 0;
 // m_nStartUseSpell := 0;
  m_boStartUseSpell := False;
  m_boDecDragonPoint := False;//20080418 ��ʼ��ŭ��
 //m_dwSearchMagic := GetTickCount();
  FillChar(m_SkillUseTick, SizeOf(m_SkillUseTick), 0);
  m_boNewHuman := False;
  m_nLoyal:=0;//Ӣ�۵��ҳ϶�(20080109)
  n_AmuletIndx:= 0;//20080412
  m_dwDedingUseTick := 0;//20080524 �ض�ʹ�ü��

  m_dwAddAlcoholTick:= GetTickCount;//���Ӿ������ȵļ��  20080623
  m_dwDecWineDrinkValueTick:= GetTickCount;//������ƶȵļ��  20080623
  n_DrinkWineQuality:= 0;//����ʱ�Ƶ�Ʒ�� 20080623
  n_DrinkWineAlcohol:= 0;//����ʱ�ƵĶ��� 20080624
  n_DrinkWineDrunk:= False;//�Ⱦ����� 20080623

  dw_UseMedicineTime:= 0; //ʹ��ҩ��ʱ��,���㳤ʱ��ûʹ��ҩ�� 20080623
  n_MedicineLevel:= 0;  //ҩ��ֵ�ȼ� 20080623

  m_Exp68:= 0;//�������嵱ǰ���� 20080925
  m_MaxExp68:= 0;//���������������� 20080925
  boAutoOpenDefence:= False;//�Զ�����ħ���� 20080930

  m_boTrainingNG := False;//�Ƿ�ѧϰ���ڹ� 20081002
  m_NGLevel := 1;//�ڹ��ȼ� 20081002  
  m_ExpSkill69:= 0;//�ڹ��ķ���ǰ���� 20080930
  m_MaxExpSkill69:= 0;//�ڹ��ķ��������� 20080930
  m_Skill69NH:= 0;//��ǰ����ֵ 20080930
  m_Skill69MaxNH:= 0;//�������ֵ 20080930
  m_dwIncNHTick:= GetTickCount;//��������ֵ��ʱ 20081002

  m_Magic46Skill:= nil; //������ 20081217
  m_MagicSkill_200:= nil;//ŭ֮��ɱ
  m_MagicSkill_201:= nil;//��֮��ɱ
  m_MagicSkill_202:= nil;//ŭ֮����
  m_MagicSkill_203:= nil;//��֮����
  m_MagicSkill_204:= nil;//ŭ֮�һ�
  m_MagicSkill_205:= nil;//��֮�һ�
  m_MagicSkill_206:= nil;//ŭ֮����
  m_MagicSkill_207:= nil;//��֮����
  m_MagicSkill_208:= nil;//ŭ֮����
  m_MagicSkill_209:= nil;//��֮����
  m_MagicSkill_210:= nil;//ŭ֮�����
  m_MagicSkill_211:= nil;//��֮�����
  m_MagicSkill_212:= nil;//ŭ֮��ǽ
  m_MagicSkill_213:= nil;//��֮��ǽ
  m_MagicSkill_214:= nil;//ŭ֮������
  m_MagicSkill_215:= nil;//��֮������
  m_MagicSkill_216:= nil;//ŭ֮�����Ӱ
  m_MagicSkill_217:= nil;//��֮�����Ӱ
  m_MagicSkill_218:= nil;//ŭ֮���ѻ���
  m_MagicSkill_219:= nil;//��֮���ѻ���
  m_MagicSkill_220:= nil;//ŭ֮������
  m_MagicSkill_221:= nil;//��֮������
  m_MagicSkill_222:= nil;//ŭ֮�׵�
  m_MagicSkill_223:= nil;//��֮�׵�
  m_MagicSkill_224:= nil;//ŭ֮�����׹�
  m_MagicSkill_225:= nil;//��֮�����׹�
  m_MagicSkill_226:= nil;//ŭ֮������
  m_MagicSkill_227:= nil;//��֮������
  m_MagicSkill_228:= nil;//ŭ֮�����
  m_MagicSkill_229:= nil;//��֮�����
  m_MagicSkill_230:= nil;//ŭ֮���
  m_MagicSkill_231:= nil;//��֮���
  m_MagicSkill_232:= nil;//ŭ֮��Ѫ
  m_MagicSkill_233:= nil;//��֮��Ѫ
  m_MagicSkill_234:= nil;//ŭ֮���ǻ���
  m_MagicSkill_235:= nil;//��֮���ǻ���
  m_MagicSkill_236:= nil;//ŭ֮�ڹ�����
  m_MagicSkill_237:= nil;//��֮�ڹ�����

  m_GetExp:= 0;//����ȡ�õľ���,$GetExp����ʹ��  20081228
  m_AvoidHp:= 0;//����Ѫ�� 20081225
  m_boCrazyProtection:= False;//����񻯱��� 20081225
end;

destructor THeroObject.Destroy;
begin
  inherited;
end;

procedure THeroObject.SysMsg(sMsg: string; MsgColor: TMsgColor; MsgType: TMsgType);
begin
  if m_Master = nil then Exit;
  if (m_Master <> nil) and TPlayObject(m_Master).m_boNotOnlineAddExp then Exit;
  m_Master.SysMsg({'(Ӣ��)' +} sMsg, MsgColor, MsgType); //20080312
end;

procedure THeroObject.SendSocket(DefMsg: pTDefaultMessage; sMsg: string);
begin
  if m_Master = nil then Exit;
  if (m_Master <> nil) and TPlayObject(m_Master).m_boNotOnlineAddExp then Exit;
  TPlayObject(m_Master).SendSocket(DefMsg, sMsg);
end;

procedure THeroObject.SendDefMessage(wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: string);
begin
  if m_Master = nil then Exit;
  if (m_Master <> nil) and TPlayObject(m_Master).m_boNotOnlineAddExp then Exit;
  TPlayObject(m_Master).SendDefMessage(wIdent, nRecog, nParam, nTag, nSeries, sMsg);
end;

procedure THeroObject.SendMsg(BaseObject: TBaseObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: string);
begin
  if m_Master = nil then Exit;
  if (m_Master <> nil) and TPlayObject(m_Master).m_boNotOnlineAddExp then Exit;
  m_Master.SendMsg(BaseObject, wIdent, wParam, nParam1, nParam2, nParam3, sMsg);
end;

procedure THeroObject.SendUpdateMsg(BaseObject: TBaseObject; wIdent, wParam: Word;
  lParam1, lParam2, lParam3: Integer; sMsg: string);
begin
  if m_Master = nil then Exit;
  if (m_Master <> nil) and TPlayObject(m_Master).m_boNotOnlineAddExp then Exit;
  m_Master.SendUpdateMsg(BaseObject, wIdent, wParam, lParam1, lParam2, lParam3, sMsg);
end;

procedure THeroObject.SendDelayMsg(BaseObject: TBaseObject; wIdent, wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: string; dwDelay: LongWord);
begin
  if m_Master = nil then Exit;
  if (m_Master <> nil) and TPlayObject(m_Master).m_boNotOnlineAddExp then Exit;
  m_Master.SendDelayMsg(BaseObject, wIdent, wParam, lParam1, lParam2, lParam3, sMsg, dwDelay);
end;

procedure THeroObject.SendUpdateDelayMsg(BaseObject: TBaseObject; wIdent, wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: string; dwDelay: LongWord);
begin
  if m_Master = nil then Exit;
  if (m_Master <> nil) and TPlayObject(m_Master).m_boNotOnlineAddExp then Exit;
  m_Master.SendUpdateDelayMsg(BaseObject, wIdent, wParam, lParam1, lParam2, lParam3, sMsg, dwDelay);
end;

function THeroObject.FindTogetherMagic: pTUserMagic;
begin
  Result := FindMagic(GetTogetherUseSpell);
end;
//����ְҵ,�ж�Ӣ�ۿ���ѧϰ���ּ���
function THeroObject.GetTogetherUseSpell: Integer;
begin
  Result := 0;
  if m_Master = nil then Exit;
  case m_Master.m_btJob of
    0: begin
        case m_btJob of
          0: Result := 60;
          1: Result := 62;
          2: Result := 61;
        end;
      end;
    1: begin
        case m_btJob of
          0: Result := 62;
          1: Result := 65;
          2: Result := 64;
        end;
      end;
    2: begin
        case m_btJob of
          0: Result := 61;
          1: Result := 64;
          2: Result := 63;
        end;
      end;
  end;
end;
//ˢ��Ӣ�۵İ���
procedure THeroObject.ClientQueryBagItems();
var
  I: Integer;
  Item: pTStdItem;
  sSENDMSG: string;
  ClientItem: TClientItem;
  StdItem: TStdItem;
  UserItem: pTUserItem;
  sUserItemName: string;
begin
  if m_Master <> nil then begin//20081220
    if TPlayObject(m_Master).m_boCanQueryBag or m_boDeath then Exit;//�Ƿ����ˢ�°��� 20080917  ��������ˢ�°���
    TPlayObject(m_Master).m_boCanQueryBag:= True;
    try
      sSENDMSG := '';
      if m_ItemList.Count > 0 then begin//20080628
        for I := 0 to m_ItemList.Count - 1 do begin
          UserItem := m_ItemList.Items[I];
          if UserItem <> nil then begin//20081220
            Item := UserEngine.GetStdItem(UserItem.wIndex);
            if Item <> nil then begin
              StdItem := Item^;
              ItemUnit.GetItemAddValue(UserItem, StdItem);
              Move(StdItem, ClientItem.s, SizeOf(TStdItem));
              //ȡ�Զ�����Ʒ����
              sUserItemName := '';
              if UserItem.btValue[13] = 1 then
                sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
              if sUserItemName <> '' then ClientItem.s.Name := sUserItemName;
              if UserItem.btValue[12] = 1 then ClientItem.s.Reserved1:=1//��Ʒ���� 20080223
              else  ClientItem.s.Reserved1:= 0;

              if (StdItem.StdMode = 60) and (StdItem.shape <> 0) then begin//����,���վ��� 20080717
                if UserItem.btValue[0] <> 0 then ClientItem.s.AC:=UserItem.btValue[0];//�Ƶ�Ʒ��
                if UserItem.btValue[1] <> 0 then ClientItem.s.MAC:=UserItem.btValue[1];//�Ƶľƾ���
              end;
              if StdItem.StdMode = 8 then begin//��Ʋ��� 20080726
                if UserItem.btValue[0] <> 0 then ClientItem.s.AC:= UserItem.btValue[0];//���ϵ�Ʒ��
              end;

              ClientItem.Dura := UserItem.Dura;
              ClientItem.DuraMax := UserItem.DuraMax;
              ClientItem.MakeIndex := UserItem.MakeIndex;
              {if StdItem.StdMode = 50 then begin//20080726 ע��
                ClientItem.s.Name := ClientItem.s.Name + ' #' + IntToStr(UserItem.Dura);
              end;}
              sSENDMSG := sSENDMSG + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
            end;
          end;
        end;
      end;
      if sSENDMSG <> '' then begin
        m_DefMsg := MakeDefaultMsg(SM_HEROBAGITEMS, Integer(m_Master), 0, 0, m_ItemList.Count, 0);
        SendSocket(@m_DefMsg, sSENDMSG);
      end;
    finally
      TPlayObject(m_Master).m_boCanQueryBag:= False;
    end;
  end;
end;

procedure THeroObject.GetBagItemCount;
var
  I: Integer;
  nOldBagCount: Integer;
begin
  nOldBagCount := m_nItemBagCount;
  for I := High(g_Config.nHeroBagItemCount) downto Low(g_Config.nHeroBagItemCount) do begin
    if m_Abil.Level >= g_Config.nHeroBagItemCount[I] then begin
      case I of
        0: m_nItemBagCount := 10;
        1: m_nItemBagCount := 20;
        2: m_nItemBagCount := 30;
        3: m_nItemBagCount := 35;
        4: m_nItemBagCount := 40;
      end;
      Break;
    end;
  end;
  if nOldBagCount <> m_nItemBagCount then begin
    SendMsg(m_Master, RM_QUERYHEROBAGCOUNT, 0, m_nItemBagCount, 0, 0, '');
  end;
end;

function THeroObject.AddItemToBag(UserItem: pTUserItem): Boolean;
begin
  Result := False;
  if m_Master = nil then Exit;
  if m_ItemList.Count < m_nItemBagCount then begin
    m_ItemList.Add(UserItem);
    WeightChanged();
    Result := True;
  end;
end;
//����ʹ�õ�ħ��
procedure THeroObject.SendUseMagic();
var
  I: Integer;
  sSENDMSG: string;
  UserMagic: pTUserMagic;
  ClientMagic: TClientMagic;
begin
  sSENDMSG := '';
  if m_MagicList.Count > 0 then begin//20080630
    for I := 0 to m_MagicList.Count - 1 do begin
      UserMagic := m_MagicList.Items[I];
      if UserMagic <> nil then begin
        ClientMagic.Key := Chr(UserMagic.btKey);
        ClientMagic.Level := UserMagic.btLevel;
        ClientMagic.CurTrain := UserMagic.nTranPoint;
        ClientMagic.Def := UserMagic.MagicInfo^;
        sSENDMSG := sSENDMSG + EncodeBuffer(@ClientMagic, SizeOf(TClientMagic)) + '/';
      end;
    end;
  end;
  if sSENDMSG <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_HEROSENDMYMAGIC, 0, 0, 0, m_MagicList.Count, 0);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;
end;
//����ʹ�õ���Ʒ,�����ϵ�װ��
procedure THeroObject.SendUseitems();
var
  I: Integer;
  Item: pTStdItem;
  sSENDMSG: string;
  ClientItem: TClientItem;
  StdItem: TStdItem;
  sUserItemName: string;
begin
  sSENDMSG := '';
  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[I].wIndex > 0 then begin
      //sItemNewName:=GetItemName(m_UseItems[i].MakeIndex);
      Item := UserEngine.GetStdItem(m_UseItems[I].wIndex);
      if Item <> nil then begin
        StdItem := Item^;
        ItemUnit.GetItemAddValue(@m_UseItems[I], StdItem);
        Move(StdItem, ClientItem.s, SizeOf(TStdItem));
        //ȡ�Զ�����Ʒ����
        sUserItemName := '';
        if m_UseItems[I].btValue[13] = 1 then
          sUserItemName := ItemUnit.GetCustomItemName(m_UseItems[I].MakeIndex, m_UseItems[I].wIndex);
        if m_UseItems[I].btValue[12] = 1 then ClientItem.s.Reserved1:=1//��Ʒ���� 20080229
        else ClientItem.s.Reserved1:= 0;
        if sUserItemName <> '' then ClientItem.s.Name := sUserItemName;

        ClientItem.Dura := m_UseItems[I].Dura;
        ClientItem.DuraMax := m_UseItems[I].DuraMax;
        ClientItem.MakeIndex := m_UseItems[I].MakeIndex;
        sSENDMSG := sSENDMSG + IntToStr(I) + '/' + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
      end;
    end;
  end;
  if sSENDMSG <> '' then begin

    m_DefMsg := MakeDefaultMsg(SM_SENDHEROUSEITEMS, 0, 0, 0, 0, 0);
    SendSocket(@m_DefMsg, sSENDMSG);
  end;
  TPlayObject(m_Master).IsItem_51(1);//���;�����ľ��� 20080427
  if WearFirDragon and (m_nFirDragonPoint > 0) then begin//�л���֮��,��ŭ������0ʱ����  20080419
     if m_nFirDragonPoint > g_Config.nMaxFirDragonPoint then m_nFirDragonPoint:= g_Config.nMaxFirDragonPoint;//20080528 ��ֹŭ�������󳬹�
     SendMsg(m_Master, RM_FIRDRAGONPOINT, g_Config.nMaxFirDragonPoint, m_nFirDragonPoint, 0, 0, '');//����Ӣ��ŭ��ֵ
  end;
end;

procedure THeroObject.SendChangeItems(nWhere1, nWhere2: Integer; UserItem1, UserItem2: pTUserItem);
var
  StdItem1: pTStdItem;
  StdItem2: pTStdItem;
  StdItem80: TStdItem;
  ClientItem: TClientItem;
  sUserItemName: string;
  sSendText: string;
begin
  sSendText := '';
  if UserItem1 <> nil then begin
    StdItem1 := UserEngine.GetStdItem(UserItem1.wIndex);
    if StdItem1 <> nil then begin
      StdItem80 := StdItem1^;
      ItemUnit.GetItemAddValue(@UserItem1, StdItem80);
      Move(StdItem80, ClientItem.s, SizeOf(TStdItem));
      //ȡ�Զ�����Ʒ����
      sUserItemName := '';
      if UserItem1.btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(UserItem1.MakeIndex, UserItem1.wIndex);
      if sUserItemName <> '' then
        ClientItem.s.Name := sUserItemName;
      ClientItem.MakeIndex := UserItem1.MakeIndex;
      ClientItem.Dura := UserItem1.Dura;
      ClientItem.DuraMax := UserItem1.DuraMax;
      {if StdItem1.StdMode = 50 then begin//20080808 ע��
        ClientItem.s.Name := ClientItem.s.Name + ' #' + IntToStr(UserItem1.Dura);
      end;}
      sSendText := '0/' + IntToStr(nWhere1) + '/' + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
    end;
  end;

  if UserItem2 <> nil then begin
    StdItem2 := UserEngine.GetStdItem(UserItem2.wIndex);
    if StdItem2 <> nil then begin
      StdItem2 := UserEngine.GetStdItem(UserItem2.wIndex);
      StdItem80 := StdItem2^;
      ItemUnit.GetItemAddValue(@UserItem2, StdItem80);
      Move(StdItem80, ClientItem.s, SizeOf(TStdItem));
      //ȡ�Զ�����Ʒ����
      sUserItemName := '';
      if UserItem2.btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(UserItem2.MakeIndex, UserItem2.wIndex);
      if sUserItemName <> '' then
        ClientItem.s.Name := sUserItemName;
      ClientItem.MakeIndex := UserItem2.MakeIndex;
      ClientItem.Dura := UserItem2.Dura;
      ClientItem.DuraMax := UserItem2.DuraMax;
      {if StdItem2.StdMode = 50 then begin //20080808 ע��
        ClientItem.s.Name := ClientItem.s.Name + ' #' + IntToStr(UserItem2.Dura);
      end;}
      if sSendText = '' then begin
        sSendText := '1/' + IntToStr(nWhere2) + '/' + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
      end else begin
        sSendText := sSendText + '1/' + IntToStr(nWhere2) + '/' + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
      end;
    end;
  end;
  if sSendText <> '' then begin
    m_DefMsg := MakeDefaultMsg(SM_HEROCHANGEITEM, Integer(m_Master), 0, 0, 0, 0);
    SendSocket(@m_DefMsg, sSendText);
  end;
end;

procedure THeroObject.SendDelItemList(ItemList: TStringList);
var
  I: Integer;
  s10: string;
begin
  s10 := '';
  if ItemList.Count > 0 then begin//20080630
    for I := 0 to ItemList.Count - 1 do begin
      s10 := s10 + ItemList.Strings[I] + '/' + IntToStr(Integer(ItemList.Objects[I])) + '/';
    end;
  end;
  m_DefMsg := MakeDefaultMsg(SM_HERODELITEMS, 0, 0, 0, ItemList.Count, 0);
  SendSocket(@m_DefMsg, EncodeString(s10));
end;

procedure THeroObject.SendDelItems(UserItem: pTUserItem);
var
  StdItem: pTStdItem;
  StdItem80: TStdItem;
  ClientItem: TClientItem;
  sUserItemName: string;
begin
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem <> nil then begin
    StdItem80 := StdItem^;
    ItemUnit.GetItemAddValue(@UserItem, StdItem80);
    Move(StdItem80, ClientItem.s, SizeOf(TStdItem));
    //ȡ�Զ�����Ʒ����
    sUserItemName := '';
    if UserItem.btValue[13] = 1 then
      sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    if sUserItemName <> '' then
      ClientItem.s.Name := sUserItemName;
    if UserItem.btValue[12] = 1 then ClientItem.s.Reserved1:=1//��Ʒ���� 20080223
     else  ClientItem.s.Reserved1:= 0 ;

    ClientItem.MakeIndex := UserItem.MakeIndex;
    ClientItem.Dura := UserItem.Dura;
    ClientItem.DuraMax := UserItem.DuraMax;
    {if StdItem.StdMode = 50 then begin//20080808 ע��
      ClientItem.s.Name := ClientItem.s.Name + ' #' + IntToStr(UserItem.Dura);
    end;}
    m_DefMsg := MakeDefaultMsg(SM_HERODELITEM, Integer(m_Master), 0, 0, 1, 0);
    SendSocket(@m_DefMsg, EncodeBuffer(@ClientItem, SizeOf(TClientItem)));
  end;
end;

procedure THeroObject.SendAddItem(UserItem: pTUserItem);
var
  pStdItem: pTStdItem;
  StdItem: TStdItem;
  ClientItem: TClientItem;
  sUserItemName: string;
begin
  pStdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if pStdItem = nil then Exit;
  StdItem := pStdItem^;
  ItemUnit.GetItemAddValue(UserItem, StdItem);
  Move(StdItem, ClientItem.s, SizeOf(TStdItem));
  //ȡ�Զ�����Ʒ����
  sUserItemName := '';
  if UserItem.btValue[13] = 1 then
    sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
  if sUserItemName <> '' then
    ClientItem.s.Name := sUserItemName;
  if UserItem.btValue[12] = 1 then ClientItem.s.Reserved1:=1//��Ʒ���� 20080223
  else ClientItem.s.Reserved1:= 0;

  ClientItem.MakeIndex := UserItem.MakeIndex;
  ClientItem.Dura := UserItem.Dura;
  ClientItem.DuraMax := UserItem.DuraMax;
 { if StdItem.StdMode = 50 then begin //20080808 ע��
    ClientItem.s.Name := ClientItem.s.Name + ' #' + IntToStr(UserItem.Dura);
  end;}
  if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then begin
    //if UserItem.btValue[8] = 0 then ClientItem.s.Shape := 0 //20080315 �޸�
    //else ClientItem.s.Shape := 130;
    if UserItem.btValue[8] <> 0 then ClientItem.s.Shape := 130;//20080315 �޸�
  end;
  if (StdItem.StdMode = 60) and (StdItem.shape <> 0) then begin//����,���վ��� 20080702
    if UserItem.btValue[0] <> 0 then ClientItem.s.AC:=UserItem.btValue[0];//�Ƶ�Ʒ��
    if UserItem.btValue[1] <> 0 then ClientItem.s.MAC:=UserItem.btValue[1];//�Ƶľƾ���
  end;
  if StdItem.StdMode = 8 then begin//��Ʋ��� 20080702
    if UserItem.btValue[0] <> 0 then ClientItem.s.AC:=UserItem.btValue[0];//���ϵ�Ʒ��
  end;

  m_DefMsg := MakeDefaultMsg(SM_HEROADDITEM, Integer(m_Master), 0, 0, 1, 0);
  SendSocket(@m_DefMsg, EncodeBuffer(@ClientItem, SizeOf(TClientItem)));
end;

procedure THeroObject.SendUpdateItem(UserItem: pTUserItem);
var
  StdItem: pTStdItem;
  StdItem80: TStdItem;
  ClientItem: TClientItem;
 // OClientItem: TOClientItem;
  sUserItemName: string;
begin
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem <> nil then begin
    StdItem80 := StdItem^;
    ItemUnit.GetItemAddValue(UserItem, StdItem80);
    ClientItem.s := StdItem80;
    //ȡ�Զ�����Ʒ����
    sUserItemName := '';
    if UserItem.btValue[13] = 1 then
      sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
    if sUserItemName <> '' then
      ClientItem.s.Name := sUserItemName;
    if UserItem.btValue[12] = 1 then ClientItem.s.Reserved1:=1//��Ʒ���� 20080223
     else  ClientItem.s.Reserved1:= 0;

    if (StdItem.StdMode = 60) and (StdItem.shape <> 0) then begin//����,���վ��� 20080703
      if UserItem.btValue[0] <> 0 then ClientItem.s.AC:=UserItem.btValue[0];//�Ƶ�Ʒ��
      if UserItem.btValue[1] <> 0 then ClientItem.s.MAC:=UserItem.btValue[1];//�Ƶľƾ���
    end;

    ClientItem.MakeIndex := UserItem.MakeIndex;
    ClientItem.Dura := UserItem.Dura;
    ClientItem.DuraMax := UserItem.DuraMax;
    {if StdItem.StdMode = 50 then begin//20080808 ע��
      ClientItem.s.Name := ClientItem.s.Name + ' #' + IntToStr(UserItem.Dura);
    end;}
    m_DefMsg := MakeDefaultMsg(SM_HEROUPDATEITEM, Integer(Self), 0, 0, 1, 0);
    SendSocket(@m_DefMsg, EncodeBuffer(@ClientItem, SizeOf(TClientItem)));
  end;
end;

function THeroObject.GetShowName(): string;
begin
  //Result := m_sCharName;
  if g_Config.boNameSuffix then //�Ƿ���ʾ��׺  20080315
    Result :=m_sCharName +'\('+ m_Master.m_sCharName + g_Config.sHeroNameSuffix +')'
  else Result := m_sCharName + g_Config.sHeroName;
  if g_Config.boUnKnowHum and IsUsesZhuLi then Result :='������';//���϶��Ҽ���ʾ������ 20080424
end;

procedure THeroObject.ItemDamageRevivalRing();
var
  I: Integer;
  pSItem: pTStdItem;
  nDura, tDura: Integer;
  HeroObject: THeroObject;
begin
  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[I].wIndex > 0 then begin
      pSItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
      if pSItem <> nil then begin
//        if (i = U_RINGR) or (i = U_RINGL) then begin
        if (pSItem.Shape in [114, 160, 161, 162]) or (((I = U_WEAPON) or (I = U_RIGHTHAND)) and (pSItem.AniCount in [114, 160, 161, 162])) then begin
          nDura := m_UseItems[I].Dura;
          tDura := Round(nDura / 1000 {1.03});
          Dec(nDura, 1000);
          if nDura <= 0 then begin
            nDura := 0;
            m_UseItems[I].Dura := nDura;
            if m_btRaceServer = RC_HEROOBJECT then begin
              HeroObject := THeroObject(Self);
              HeroObject.SendDelItems(@m_UseItems[I]);
            end; //004C0310
            m_UseItems[I].wIndex := 0;
            RecalcAbilitys();
            CompareSuitItem(False);//��װ������װ���Ա� 20080729
          end else begin //004C0331
            m_UseItems[I].Dura := nDura;
          end;
          if tDura <> Round(nDura / 1000 {1.03}) then begin
            SendMsg(Self, RM_HERODURACHANGE, I, nDura, m_UseItems[I].DuraMax, 0, '');
          end;
            //break;
        end; //004C0397
//        end;//004C0397
      end; //004C0397 if pSItem <> nil then begin
    end; //if UseItems[i].wIndex > 0 then begin
  end; // for i:=Low(UseItems) to High(UseItems) do begin
end;

procedure THeroObject.DoDamageWeapon(nWeaponDamage: Integer);
var
  nDura, nDuraPoint: Integer;
  HeroObject: THeroObject;
  //StdItem: pTStdItem;//20080229 ȥ��
begin
  if m_UseItems[U_WEAPON].wIndex <= 0 then Exit;
  nDura := m_UseItems[U_WEAPON].Dura;
  nDuraPoint := Round(nDura / 1.03);
  Dec(nDura, nWeaponDamage);
  if nDura <= 0 then begin
    nDura := 0;
    m_UseItems[U_WEAPON].Dura := nDura;
    if m_btRaceServer = RC_HEROOBJECT then begin
      HeroObject := THeroObject(Self);
      HeroObject.SendDelItems(@m_UseItems[U_WEAPON]);
     // StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex); //20080229 ȥ��,��Ϊû�еط�ʹ��
      {if StdItem.NeedIdentify = 1 then
            AddGameDataLog ('3' + #9 +
                        m_sMapName + #9 +
                        IntToStr(m_nCurrX) + #9 +
                        IntToStr(m_nCurrY) + #9 +
                        m_sCharName + #9 +
                        //UserEngine.GetStdItemName(m_UseItems[U_WEAPON].wIndex) + #9 +
                        StdItem.Name + #9 +
                        IntToStr(m_UseItems[U_WEAPON].MakeIndex) + #9 +
                        BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
                        '0');  }
    end;
    m_UseItems[U_WEAPON].wIndex := 0;
    SendMsg(Self, RM_HERODURACHANGE, U_WEAPON, nDura, m_UseItems[U_WEAPON].DuraMax, 0, '');
  end else begin //004C199D
    m_UseItems[U_WEAPON].Dura := nDura;
  end;
  if (nDura / 1.03) <> nDuraPoint then begin
    SendMsg(Self, RM_HERODURACHANGE, U_WEAPON, m_UseItems[U_WEAPON].Dura, m_UseItems[U_WEAPON].DuraMax, 0, '');
  end;
end;
//�ܹ���,����װ�����־�
procedure THeroObject.StruckDamage(nDamage: Integer);
var
  I: Integer;
  nDam: Integer;
  nDura, nOldDura: Integer;
  HeroObject: THeroObject;
  StdItem: pTStdItem;
  bo19: Boolean;
begin
  if nDamage <= 0 then Exit;
  nDam := Random(10) + 5;
  if m_wStatusTimeArr[POISON_DAMAGEARMOR ] > 0 then begin
    nDam := Round(nDam * (g_Config.nPosionDamagarmor / 10));
    nDamage := Round(nDamage * (g_Config.nPosionDamagarmor / 10));
  end;
  bo19 := False;
  if m_UseItems[U_DRESS].wIndex > 0 then begin
    nDura := m_UseItems[U_DRESS].Dura;
    nOldDura := Round(nDura / 1000);
    Dec(nDura, nDam);
    if nDura <= 0 then begin
      if m_btRaceServer = RC_HEROOBJECT then begin
        HeroObject := THeroObject(Self);
        HeroObject.SendDelItems(@m_UseItems[U_DRESS]);
        m_UseItems[U_DRESS].wIndex := 0;
        FeatureChanged();
      end;
      m_UseItems[U_DRESS].wIndex := 0;
      m_UseItems[U_DRESS].Dura := 0;
      bo19 := True;
    end else begin
      m_UseItems[U_DRESS].Dura := nDura;
    end;
    if nOldDura <> Round(nDura / 1000) then begin
      SendMsg(Self, RM_HERODURACHANGE, U_DRESS, nDura, m_UseItems[U_DRESS].DuraMax, 0, '');
    end;
  end;
  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    if (m_UseItems[I].wIndex > 0) and (Random(8) = 0) then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);//20080607
      if (StdItem <> nil) and (((StdItem.StdMode = 2) and (StdItem.AniCount = 21)) or (StdItem.StdMode = 25) or (StdItem.StdMode = 7)) then Continue;//��ף����,����֮����Ʒ������ 20080607
      nDura := m_UseItems[I].Dura;
      nOldDura := Round(nDura / 1000);
      Dec(nDura, nDam);
      if nDura <= 0 then begin
        if m_btRaceServer = RC_HEROOBJECT then begin
          HeroObject := THeroObject(Self);
          HeroObject.SendDelItems(@m_UseItems[I]);
          m_UseItems[I].wIndex := 0;
          FeatureChanged();
        end;
        m_UseItems[I].wIndex := 0;
        m_UseItems[I].Dura := 0;
        bo19 := True;
      end else begin
        m_UseItems[I].Dura := nDura;
      end;
      if nOldDura <> Round(nDura / 1000) then begin
        SendMsg(Self, RM_HERODURACHANGE, I, nDura, m_UseItems[I].DuraMax, 0, '');
      end;
    end;
  end;
  if bo19 then begin
     RecalcAbilitys();
     CompareSuitItem(False);//��װ������װ���Ա� 20080729
  end;
  DamageHealth(nDamage);
end;
//Ӣ������Ʒ
function THeroObject.ClientDropItem(sItemName: string;
  nItemIdx: Integer): Boolean;
var
  I, wIndex, MakeIndex: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  sUserItemName: string;
  //sCheckItemName: string;
  nCode: byte;
begin
  Result := False;
  nCode:= 0;
  TPlayObject(m_Master).m_boCanQueryBag:= True;//����Ʒʱ,����ˢ�°��� 20080917
  Try
    try
      {if not TPlayObject(m_Master).m_boClientFlag then begin
        if TPlayObject(m_Master).m_nStep = 8 then Inc(TPlayObject(m_Master).m_nStep)
        else TPlayObject(m_Master).m_nStep := 0;
      end; }
      if g_Config.boInSafeDisableDrop and InSafeZone then begin
        SendMsg(g_ManageNPC, RM_MENU_OK, 0, Integer(Self), 0, 0, g_sCanotDropInSafeZoneMsg);
        Exit;
      end;
      nCode:= 1;
      if not m_boCanDrop then begin
        SendMsg(g_ManageNPC, RM_MENU_OK, 0, Integer(Self), 0, 0, g_sCanotDropItemMsg);
        Exit;
      end;
      nCode:= 2;
      if Pos(' ', sItemName) > 0 then begin //�۷���Ʒ����(�ż���Ʒ�����ƺ������ʹ�ô���)
        GetValidStr3(sItemName, sItemName, [' ']);
      end;
      nCode:= 3;
      for I := m_ItemList.Count - 1 downto 0 do begin
        if m_ItemList.Count <= 0 then Break;
        nCode:= 4;
        UserItem := m_ItemList.Items[I];
        if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          nCode:= 5;
          if StdItem = nil then Continue;
            //sItem:=UserEngine.GetStdItemName(UserItem.wIndex);
            //ȡ�Զ�����Ʒ����
          sUserItemName := '';
          if UserItem.btValue[13] = 1 then
            sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
          if sUserItemName = '' then
            sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);

          if CompareText(sUserItemName, sItemName) = 0 then begin
            nCode:= 6;
            if CheckItemValue(UserItem ,0) then Break;//�����Ʒ�Ƿ��ֹ�� 20080314
            nCode:= 7;
           { if Assigned(zPlugOfEngine.CheckCanDropItem) then begin
              nCode:= 8;
              sCheckItemName := StdItem.Name;
              if not zPlugOfEngine.CheckCanDropItem(Self, PChar(sCheckItemName)) then Break;
            end; }
            if PlugOfCheckCanItem(0, StdItem.Name, False, 0, 0) then Break;//��ֹ��Ʒ����(����������) 20080729
            nCode:= 9;
            wIndex:= UserItem.wIndex;//20080901
            MakeIndex:= UserItem.MakeIndex;//20080901
            if g_Config.boControlDropItem and (StdItem.Price < g_Config.nCanDropPrice) then begin
              nCode:= 10;
              m_ItemList.Delete(I);
              ClearCopyItem(wIndex, MakeIndex);//20080901 ������Ʒ
              Dispose(UserItem);
              Result := True;
              Break;
            end;
            nCode:= 11;
            if TPlayObject(m_Master).m_boHeroLogOut then Exit;//Ӣ���˳�,��ʧ��(��ֹˢ��Ʒ) 20080923
            if DropItemDown(UserItem, 3, False, False, nil, m_Master) then begin
              nCode:= 12;
              m_ItemList.Delete(I);
              ClearCopyItem(wIndex, MakeIndex);//20080901 ������Ʒ
              Dispose(UserItem);
              Result := True;
              Break;
            end;
          end;
        end;
      end;//for
      if Result then WeightChanged();
    except
      MainOutMessage('{�쳣} THeroObject.ClientDropItem Code:'+inttostr(nCode));
    end;
  finally
    TPlayObject(m_Master).m_boCanQueryBag:= False;//����Ʒʱ,����ˢ�°��� 20080917
  end;
end;
//ȫ���޸�,��Ҫ�ĳ־�ֵ 20080325
Function THeroObject.RepairAllItemDura:Integer;
var
  nWhere: Integer;
//sCheckItemName: string;
  StdItem: pTStdItem;
begin
  Result:= 0;
  for nWhere := Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[nWhere].wIndex > 0 then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[nWhere].wIndex);
      if StdItem <> nil then begin
        if ((m_UseItems[nWhere].DuraMax div 1000)> (m_UseItems[nWhere].Dura div 1000)) and (StdItem.StdMode<>7) and (StdItem.StdMode<>25) and (StdItem.StdMode<>43) and (StdItem.AniCount<>21) then begin
          if CheckItemValue(@m_UseItems[nWhere], 3) then Continue //20080314 ��ֹ��
          else
         { if Assigned(zPlugOfEngine.CheckCanRepairItem) then begin
            sCheckItemName := StdItem.Name;
            if not zPlugOfEngine.CheckCanRepairItem(m_Master, PChar(sCheckItemName)) then Continue;//����Ƿ��ǲ����޸�����Ʒ
          end;}
          if PlugOfCheckCanItem(3, StdItem.Name, False, 0, 0) then Continue;//��ֹ��Ʒ����(����������) 20080729

          Inc(Result,(m_UseItems[nWhere].DuraMax - m_UseItems[nWhere].Dura));
        end;
      end;
    end;
  end;
end;
//�ٻ�ǿ����,���г��ı������7��  20080329
function THeroObject.CallMobeItem(): Boolean;
var
  I: Integer;
  Slave: TBaseObject;
begin
  Result:= False;
  if m_SlaveList.Count= 0 then begin
    SysMsg('��û���ٻ�����,����ʹ�ô���Ʒ!',  c_Red, t_Hint);
    Exit;
  end;
  
  if m_SlaveList.Count > 0 then begin//20080630
    for I := 0 to m_SlaveList.Count - 1 do begin
      Slave := TBaseObject(m_SlaveList.Items[I]);
      if Slave.m_btRaceServer = RC_PLAYMOSTER then Continue;//20081102 �����ܵ���
      if Slave.m_btSlaveExpLevel < 7 then begin //20080323
        Slave.m_btSlaveExpLevel:= 7;
        Slave.RecalcAbilitys;//20080328 �ı�ȼ�,ˢ������
        Slave.RefNameColor;//20080408
        Slave.SendRefMsg(RM_MYSHOW, ET_OBJECTLEVELUP,0, 0, 0, ''); //������������  20080328
        Result:= True;
        SysMsg('�����ص�����Ӱ���£���ĳ���:'+Slave.m_sCharName+' �ɳ�Ϊ7��', BB_Fuchsia, t_Hint);
        Break;
      end;
    end;
  end;
end;
//ȫ���޸�
procedure THeroObject.RepairAllItem(DureCount: Integer; boDec: Boolean);
var
  nWhere,RepCount: Integer;
//  sCheckItemName: string;
  StdItem: pTStdItem;
begin
  for nWhere := Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[nWhere].wIndex > 0 then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[nWhere].wIndex);
      if StdItem <> nil then begin
        if ((m_UseItems[nWhere].DuraMax div 1000) > (m_UseItems[nWhere].Dura div 1000)) and (StdItem.StdMode<>7) and (StdItem.StdMode<>25) and (StdItem.StdMode<>43) and (StdItem.AniCount<>21) then begin
          if CheckItemValue(@m_UseItems[nWhere], 3) then Continue //20080314 ��ֹ��
          else
          {if Assigned(zPlugOfEngine.CheckCanRepairItem) then begin
            sCheckItemName := StdItem.Name;
            if not zPlugOfEngine.CheckCanRepairItem(m_Master, PChar(sCheckItemName)) then Continue;
          end;}
          if PlugOfCheckCanItem(3, StdItem.Name, False, 0, 0) then Continue;//��ֹ��Ʒ����(����������) 20080729

          if not boDec then begin//�޸��㹻,��ֱ���޸�������
            if (m_UseItems[nWhere].DuraMax div 1000) - (m_UseItems[nWhere].Dura div 1000) > 0 then
               SysMsg('װ�� ��'+StdItem.Name+'���ѳɹ��޸�!', BB_Fuchsia, t_Hint); //20071229
            m_UseItems[nWhere].Dura := m_UseItems[nWhere].DuraMax;
            SendMsg(Self, RM_HERODURACHANGE, nWhere, m_UseItems[nWhere].Dura, m_UseItems[nWhere].DuraMax, 0, '');
          end else begin
            RepCount:= (m_UseItems[nWhere].DuraMax div 1000) - (m_UseItems[nWhere].Dura div 1000);
            if DureCount >= RepCount then begin
              Dec(DureCount,RepCount);
              if (m_UseItems[nWhere].DuraMax div 1000) - (m_UseItems[nWhere].Dura div 1000) > 0 then
                 SysMsg('װ�� ��'+StdItem.Name+'���ѳɹ��޸�!', c_Green, t_Hint); //20071229
              m_UseItems[nWhere].Dura := m_UseItems[nWhere].DuraMax;
              SendMsg(Self, RM_HERODURACHANGE, nWhere, m_UseItems[nWhere].Dura, m_UseItems[nWhere].DuraMax, 0, '');//20071229
            end else
            if DureCount > 0 then begin
               DureCount:= 0;
               m_UseItems[nWhere].Dura :=m_UseItems[nWhere].Dura + DureCount * 1000;
               SendMsg(Self, RM_HERODURACHANGE, nWhere, m_UseItems[nWhere].Dura, m_UseItems[nWhere].DuraMax, 0, '');//20071229
               Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;
//�ͻ���Ӣ�۰�����ʹ����Ʒ
procedure THeroObject.ClientHeroUseItems(nItemIdx: Integer; sItemName: string);
  function GetUnbindItemName(nShape: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    if g_UnbindList.Count > 0 then begin//20080630
      for I := 0 to g_UnbindList.Count - 1 do begin
        if Integer(g_UnbindList.Objects[I]) = nShape then begin
          Result := g_UnbindList.Strings[I];
          Break;
        end;
      end;
    end;
  end;
  function GetUnBindItems(sItemName: string; nCount: Integer): Boolean;
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    Result := False;
    if nCount <=0 then nCount:=1;//20080630
    for I := 0 to nCount - 1 do begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
        m_ItemList.Add(UserItem);
        //if m_btRaceServer = RC_PLAYOBJECT then
        SendAddItem(UserItem);
        Result := True;
      end else begin
        Dispose(UserItem);
        Break;
      end;
    end;
  end;
  function FoundUserItem(Item: pTUserItem): Boolean;
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    Result := False;
    if m_ItemList.Count > 0 then begin//20080628
      for I := 0 to m_ItemList.Count - 1 do begin
        UserItem := m_ItemList.Items[I];
        if UserItem = Item then begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
var
  I, ItemCount: Integer;
  boEatOK: Boolean;
  boSendUpDate: Boolean;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  UserItem34: TUserItem;
 // sMapName: string;
 // nCurrX, nCurrY: Integer;
//  sUsesItemName:string;
begin
  TPlayObject(m_Master).m_boCanQueryBag:= True;//ʹ����Ʒʱ,����ˢ�°��� 20080917
  Try
    boEatOK := False;
    boSendUpDate := False;
    StdItem := nil;
    if m_boCanUseItem then begin
      if not m_boDeath then begin
        for I := m_ItemList.Count - 1 downto 0 do begin
          if m_ItemList.Count <= 0 then Break;
          UserItem := m_ItemList.Items[I];
          if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
            UserItem34 := UserItem^;
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem <> nil then begin
              if not m_PEnvir.AllowStdItems(UserItem.wIndex) then begin
                SysMsg(Format(g_sCanotMapUseItemMsg, [StdItem.Name]), BB_Fuchsia, t_Hint);
                Break;
              end;
              {if Assigned(zPlugOfEngine.CheckCanHeroUseItem) and (m_Master <> nil) then begin //�Ƿ��ֹӢ��ʹ�� 20080716
                sUsesItemName:= StdItem.Name ;
                if zPlugOfEngine.CheckCanHeroUseItem(m_Master, PChar(sUsesItemName)) then begin
                  Break;
                end;
              end;}
              if PlugOfCheckCanItem(8, StdItem.Name, False, 0, 0) then Break;//��ֹ��Ʒ����(����������) 20080729

              case StdItem.StdMode of
                0, 1, 3: begin //ҩ
                    if EatItems(StdItem) then begin
                      if UserItem <> nil then begin
                        m_ItemList.Delete(I);
                        DisPoseAndNil(UserItem);
                      end;
                      boEatOK := True;
                    end;
                    Break;
                  end;
                2: begin
                   if StdItem.AniCount= 21 then begin //ף���� ���͵���Ʒ  20080315
                      if StdItem.Reserved <> 56 then begin
                        if UserItem.Dura > 0 then begin
                         if (m_ItemList.Count  - 1) <= MAXBAGITEM then begin
                          if UserItem.Dura >= 1000 then begin //�޸�Ϊ1000,20071229
                            Dec(UserItem.Dura, 1000);
                            Dec(UserItem.DuraMax, 1000);//20080324 ���ٴ���Ʒ����
                          end else begin
                            UserItem.Dura := 0;
                            UserItem.DuraMax:= 0;//20080324 ���ٴ���Ʒ����
                          end;
                           //��Ҫ�޸�UnbindList.txt,���� 3 ף����  20071229  3---Ϊ ף���޵����ֵ
                           GetUnBindItems(GetUnbindItemName(StdItem.Shape), 1); //��һ��ף����  20080310
                           if UserItem.DuraMax = 0 then begin //20080324 ���ܴ�ȡ��Ʒ,��ɾ����Ʒ
                              if UserItem <> nil then begin
                                m_ItemList.Delete(I);
                                DisPoseAndNil(UserItem);
                              end;
                              boEatOK := True;
                           end;
                          end;
                        end;
                      end else begin//Ȫˮ��
                        if UserItem.Dura >= 1000 then begin
                         if (m_ItemList.Count  - 1) <= MAXBAGITEM then begin
                          if UserItem.Dura >= 1000 then begin
                            Dec(UserItem.Dura, 1000);
                            //Dec(UserItem.DuraMax, 1000);//20080324 ���ٴ���Ʒ����
                          end else begin
                            UserItem.Dura := 0;
                            //UserItem.DuraMax:= 0;//20080324 ���ٴ���Ʒ����
                          end;
                           //��Ҫ�޸�UnbindList.txt,���� 1 Ȫˮ    1---Ϊ Ȫˮ�����ֵ
                           GetUnBindItems(GetUnbindItemName(StdItem.Shape), 1); //��һ��Ȫˮ  20080310
                          { if UserItem.DuraMax = 0 then begin //20080324 ���ܴ�ȡ��Ʒ,��ɾ����Ʒ
                              m_ItemList.Delete(I);
                              DisPoseAndNil(UserItem);
                              boEatOK := True;
                           end;}
                          end;
                        end;
                      end;
                       boSendUpDate := True;
                    end else
                  
                    case StdItem.Shape of
                      1: begin //�ٻ�ǿ���� 20080329
                          if UserItem.Dura > 0 then begin
                            if UserItem.Dura >= 1000 then begin
                               if CallMobeItem() then begin //�ٻ�ǿ����,���г��ı������7��  20080221
                                 Dec(UserItem.Dura, 1000);
                                 boEatOK := True;
                               end;
                            end else begin
                             UserItem.Dura := 0;
                            end;
                          end;
                          if UserItem.Dura > 0 then begin
                            boSendUpDate := True;
                            boEatOK := False;
                          end else begin
                            if UserItem <> nil then begin
                              UserItem.wIndex:= 0;//20081014
                              m_ItemList.Delete(I);
                              DisPoseAndNil(UserItem);
                            end;
                          end;
                       end;
                      9: begin //ԭֵΪ1,20071229 //�޸���ˮ
                          ItemCount:= RepairAllItemDura;
                          if (UserItem.Dura > 0) and (ItemCount > 0) then begin
                            if UserItem.Dura >= (ItemCount div 10){100} then begin//20080325
                              Dec(UserItem.Dura, (ItemCount div 10){100});
                              RepairAllItem(ItemCount div 1000, False);
                              if UserItem.Dura < 100 then UserItem.Dura:= 0;
                            end else begin
                              UserItem.Dura:= 0;
                              RepairAllItem(ItemCount div 1000, True);
                            end;
                          end;
                          boEatOK := False;
                          if UserItem.Dura > 0 then begin
                            boSendUpDate := True;
                          end else begin
                            if UserItem <> nil then begin
                              m_ItemList.Delete(I);
                              DisPoseAndNil(UserItem);
                            end;
                            boEatOK := True;
                          end;
                        end;
                     end;//Case
                  end;
                4: begin //��
                    if ReadBook(StdItem) then begin
                      if UserItem <> nil then begin
                        m_ItemList.Delete(I);
                        DisPoseAndNil(UserItem);
                      end;
                      boEatOK := True;
                     { if (m_MagicErgumSkill <> nil) and (not m_boUseThrusting) then begin //20080215 ע��
                        ThrustingOnOff(True);
                        //SendSocket(nil, '+LNG');
                      end;
                      if (m_MagicBanwolSkill <> nil) and (not m_boUseHalfMoon) then begin
                        HalfMoonOnOff(True);
                        //SendSocket(nil, '+WID');
                      end;}
                    end;
                  end;
                31: begin //�����Ʒ
                   case StdItem.AniCount of
                    0..3:begin
                       if (m_ItemList.Count + 6 - 1) <= m_nItemBagCount then begin
                         if UserItem <> nil then begin
                           m_ItemList.Delete(I);
                           DisPoseAndNil(UserItem);
                         end;
                         GetUnBindItems(GetUnbindItemName(StdItem.Shape), 6);
                         boEatOK := True;
                       end;
                     end;//0..3
                     4..255:begin//20080728 ����
                         case StdItem.Shape of
                          0: begin
                              if FoundUserItem(UserItem) then begin//20080819 �Ȳ�����Ʒ��ɾ����Ʒ���ٴ���
                                if UserItem <> nil then begin
                                  m_ItemList.Delete(I);
                                  ClearCopyItem(UserItem.wIndex, UserItem.MakeIndex);//������Ʒ 20080901
                                  DisPoseAndNil(UserItem);
                                  UseStdmodeFunItem(StdItem);//ʹ����Ʒ�����ű���
                                end;
                                boEatOK := True;
                              end;                            
                            end;
                         { 1: begin
                              if ItemDblClick(StdItem.Name, UserItem.MakeIndex, sMapName, nCurrX, nCurrY) then begin
                                m_ItemList.Delete(I);
                                DisPoseAndNil(UserItem);
                                SpaceMove(sMapName, nCurrX, nCurrY, 0);
                                boEatOK := True;
                              end else begin
                                SendMsg(g_ManageNPC, RM_MENU_OK, 0, Integer(Self), 0, 0, '��ǰ��ͼ���걣��ɹ�������\�ٴ�˫���������͵�\��ͼ��' + m_sMapName + ' ���꣺' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY));
                              end;
                            end; }
                        end; //case StdItem.Shape of
                      end;//4..255
                    end;//Case
                   { 20071231 �޸ĳ��������
                   if StdItem.AniCount = 0 then begin
                      if (m_ItemList.Count + 6 - 1) <= m_nItemBagCount then begin
                        m_ItemList.Delete(I);
                        DisPoseAndNil(UserItem);
                        GetUnBindItems(GetUnbindItemName(StdItem.Shape), 6);
                        boEatOK := True;
                      end;
                    end;   }
                  end;//31
                60:begin//���� 20080622
                    if StdItem.Shape <> 0 then begin//���վ���,����ֵ�ﵽҪ��
                       if not n_DrinkWineDrunk then begin
                        if m_Abil.MaxAlcohol >= StdItem.Need then begin//����ֵ�ﵽҪ��
                          if UserItem.Dura > 0 then begin
                            if UserItem.Dura >= 1000 then begin
                              Dec(UserItem.Dura, 1000);
                            end else begin
                              UserItem.Dura := 0;
                            end;
                            SendRefMsg(RM_MYSHOW, 7, 0, 0, 0, ''); //�Ⱦ�������  20080623
                            if m_Abil.WineDrinkValue = 0 then begin//�����ƶ�Ϊ0,���ʼʱ����
                               m_dwDecWineDrinkValueTick:= GetTickCount();
                               m_dwAddAlcoholTick := GetTickCount();
                            end;

                            Inc(m_Abil.WineDrinkValue, (UserItem.btValue[1] * m_Abil.MaxAlcohol div 200));//������ƶ� 20080623
                            n_DrinkWineAlcohol:= UserItem.btValue[1];//����ʱ�ƵĶ��� 20080624
                            n_DrinkWineQuality:= UserItem.btValue[0];//����ʱ�Ƶ�Ʒ�� 20080623
                            if m_Abil.WineDrinkValue >= m_Abil.MaxAlcohol then begin//��ƶȳ�������,��������
                               m_Abil.WineDrinkValue:=  m_Abil.MaxAlcohol;
                               n_DrinkWineDrunk:= True;//�Ⱦ����� 20080623
                               SysMsg('(Ӣ��)�Ծ�ͷ�β���,����Ϊ����ϵ,�κ���ȥ����,������������!',c_Red,t_Hint);
                               SendRefMsg(RM_MYSHOW, 9 ,0, 0, 0, ''); //����������  20080623
                            end;
                            //��ͨ��,Ʒ��2����,25%���ʼ���ʱ���� 20080713
                            if (StdItem.Anicount = 1) and (n_DrinkWineQuality > 2) and (Random(4)=0) and (not n_DrinkWineDrunk) then begin
                               Case Random(2) of
                                 0: DefenceUp(300);//���ӷ�����300��
                                 1: MagDefenceUp(300);//����ħ��300��
                               end;
                            end;                          
                            if (StdItem.Anicount = 2) and (not n_DrinkWineDrunk) then begin//ҩ�ƿ�����ҩ��ֵ
                              //Ʒ��Ϊ4����,ҩ��������ʱ���� 20080626
                              if n_DrinkWineQuality > 4 then begin
                                case StdItem.Shape of
                                  8:begin//���Ǿ� ���ӹ�������,ħ�����޻��������2��,Ч������600��
                                      Case m_btJob of
                                        0:begin
                                           m_wStatusArrValue[0]:= 2;
                                           m_dwStatusArrTimeOutTick[0]:= GetTickCount + 600000{600 * 1000};
                                        end;
                                        1:begin
                                           m_wStatusArrValue[1]:= 2;
                                           m_dwStatusArrTimeOutTick[1]:= GetTickCount + 600000{600 * 1000};
                                        end;
                                        2:begin
                                           m_wStatusArrValue[2]:= 2;
                                           m_dwStatusArrTimeOutTick[2]:= GetTickCount + 600000{600 * 1000};
                                        end;
                                      end;
                                   end;
                                  9:begin//�𲭾�  ��������ֵ����100��,Ч������600��
                                     m_wStatusArrValue[4]:= 100;
                                     m_dwStatusArrTimeOutTick[4]:= GetTickCount + 600000{600 * 1000};
                                  end;
                                  10:begin//������  ��������2��,Ч������600��
                                     m_wStatusArrValue[11]:= 2;
                                     m_dwStatusArrTimeOutTick[11]:= GetTickCount + 600000{600 * 1000};
                                  end;
                                  11:begin//���ξ�  ���ӷ�������4��,Ч������600��
                                      m_wStatusTimeArr[9]:= 4;
                                      m_dwStatusArrTimeOutTick[9]:= GetTickCount + 600000{600 * 1000};
                                  end;
                                  12:begin//�ߵ���  ����ħ��ֵ����200��,Ч������600��
                                     m_wStatusArrValue[5]:= 200;
                                     m_dwStatusArrTimeOutTick[5]:= GetTickCount + 600000{600 * 1000};
                                  end;
                                 end;
                               end;
                             dw_UseMedicineTime:= g_Config.nDesMedicineTick;//ʼ��ʹ��ҩ��ʱ��(12Сʱ)
                              Inc(m_Abil.MedicineValue,UserItem.btValue[2]);//����ҩ��ֵ
                              if m_Abil.MedicineValue >= m_Abil.MaxMedicineValue then begin//��ǰҩ��ֵ�ﵽ��ǰ�ȼ�����ʱ
                                 Dec(m_Abil.MedicineValue, m_Abil.MaxMedicineValue);
                                 Case (n_MedicineLevel mod 6) of//������������
                                   0:begin//����/ħ��/��������(��ְҵ)
                                      Case m_btJob of
                                        0: m_Abil.DC := MakeLong(m_Abil.DC, m_Abil.DC+1);
                                        1: m_Abil.MC := MakeLong(m_Abil.MC, m_Abil.MC+1);
                                        2: m_Abil.SC := MakeLong(m_Abil.SC, m_Abil.SC+1);
                                      end;
                                   end;
                                   1: m_Abil.MAC := MakeLong(m_Abil.MAC+1, m_Abil.MAC);//��ħ������
                                   2: m_Abil.AC := MakeLong(m_Abil.AC+1, m_Abil.AC);//�ӷ�������
                                   3:begin//����/ħ��/��������(��ְҵ)
                                      Case m_btJob of
                                        0: m_Abil.DC := MakeLong(m_Abil.DC+1, m_Abil.DC);
                                        1: m_Abil.MC := MakeLong(m_Abil.MC+1, m_Abil.MC);
                                        2: m_Abil.SC := MakeLong(m_Abil.SC+1, m_Abil.SC);
                                      end;
                                   end;
                                   4: m_Abil.MAC := MakeLong(m_Abil.MAC, m_Abil.MAC+1);//ħ������
                                   5: m_Abil.AC := MakeLong(m_Abil.AC, m_Abil.AC+1);//��������
                                 end;//Case (n_MedicineLevel mod 6) of
                                 if n_MedicineLevel < MAXUPLEVEL then Inc(n_MedicineLevel);//���ӵȼ�
                                 m_Abil.MaxMedicineValue := GetMedicineExp(n_MedicineLevel);//ȡ������ĵȼ���Ӧ��ҩ��ֵ
                                 SysMsg('(Ӣ��)�ƾ�����������,�о�����״̬�����ı�',c_Red,t_Hint);//��ʾ�û�
                              end;
                            end;//if StdItem.Anicount = 2 then begin//ҩ�ƿ�����ҩ��ֵ
                            RecalcAbilitys();
                            CompareSuitItem(False);//��װ������װ���Ա� 20080729
                            SendMsg(Self, RM_HEROABILITY, 0, 0, 0, 0, '');
                            boEatOK := True;
                          end;
                          if UserItem.Dura > 0 then begin
                            boSendUpDate := True;
                            boEatOK := False;
                          end else begin
                            if UserItem <> nil then begin
                              UserItem.wIndex:= 0;//20081014
                              m_ItemList.Delete(I);
                              DisPoseAndNil(UserItem);
                            end;
                          end;
                        end else begin
                           SysMsg('(Ӣ��)������ﵽ'+inttostr(StdItem.Need)+'��������!',c_Red,t_Hint);//��ʾ�û�
                        end;
                      end else begin
                         SysMsg('(Ӣ��)�Ծ�ͷ�β���,����Ϊ����ϵ,�κ���ȥ����,������������!',c_Red,t_Hint);
                      end;
                    end;//if (StdItem.Shape <> 0)
                  end;//60
              end;
              Break;
            end;
          end;
        end;
      end;
    end else begin
      m_Master.SendMsg(g_ManageNPC, RM_MENU_OK, 0, Integer(m_Master), 0, 0, g_sCanotUseItemMsg);
    end;
    if boEatOK then begin
      WeightChanged();
      SendDefMessage(SM_HEROEAT_OK, 0, 0, 0, 0, '');
      if StdItem.NeedIdentify = 1 then
        AddGameDataLog('11' + #9 +
          m_sMapName + #9 +
          IntToStr(m_nCurrX) + #9 + IntToStr(m_nCurrY) + #9 +
          m_sCharName + #9 + StdItem.Name + #9 +
          IntToStr(UserItem34.MakeIndex) + #9 +
          '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
          '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
          '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
          '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
          '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
          IntToStr(UserItem34.btValue[0])+'/'+IntToStr(UserItem34.btValue[1])+'/'+IntToStr(UserItem34.btValue[2])+'/'+
          IntToStr(UserItem34.btValue[3])+'/'+IntToStr(UserItem34.btValue[4])+'/'+IntToStr(UserItem34.btValue[5])+'/'+
          IntToStr(UserItem34.btValue[6])+'/'+IntToStr(UserItem34.btValue[7])+'/'+IntToStr(UserItem34.btValue[8])+'/'+
          IntToStr(UserItem34.btValue[14])+ #9 + '0');
    end else begin
      SendDefMessage(SM_HEROEAT_FAIL, 0, 0, 0, 0, '');
    end;
    if (UserItem <> nil) and boSendUpDate then begin
      SendUpdateItem(UserItem);
    end;
  finally
    TPlayObject(m_Master).m_boCanQueryBag:= False;
  end;
end;

procedure THeroObject.WeightChanged;
begin
  if m_Master = nil then Exit;
  m_WAbil.Weight := RecalcBagWeight();
  if m_btRaceServer = RC_HEROOBJECT then begin
    SendUpdateMsg(m_Master, RM_HEROWEIGHTCHANGED, 0, 0, 0, 0, '');
  end;
end;

procedure THeroObject.RefMyStatus();
begin
  RecalcAbilitys();
  CompareSuitItem(False);//��װ������װ���Ա� 20080729
  m_Master.SendMsg(m_Master, RM_MYSTATUS, 0, 1, 0, 0, '');
end;

function THeroObject.EatItems(StdItem: pTStdItem): Boolean;
var
  bo06: Boolean;
 // nOldStatus: Integer;
begin
  Result := False;
  if m_PEnvir.m_boNODRUG then begin
    SysMsg(sCanotUseDrugOnThisMap, BB_Fuchsia, t_Hint);
    Exit;
  end;
  case StdItem.StdMode of
    0: begin
        case StdItem.Shape of
          1: begin
              IncHealthSpell(StdItem.AC, StdItem.MAC);
              Result := True;
            end;
          2: begin
              m_boUserUnLockDurg := True;
              Result := True;
            end;
          3: begin//�����ڹ�������Ʒ 20081002 Ӣ�۲���ʹ���ڹ���Ʒ  20081227
              {if m_boTrainingNG then begin
                GetNGExp(StdItem.AC * 1000, 1);
                Result := True;
              end;}
            end;
        else begin
            if (StdItem.AC > 0) then begin
              Inc(m_nIncHealth, StdItem.AC);
            end;
            if (StdItem.MAC > 0) then begin
              Inc(m_nIncSpell, StdItem.MAC);
            end;
            Result := True;
          end;
        end;
      end;
    1: Result := False;
    {1: begin
        nOldStatus := GetMyStatus();
        Inc(m_nHungerStatus, StdItem.DuraMax div 10);
        m_nHungerStatus := _MIN(5000, m_nHungerStatus);
        if nOldStatus <> GetMyStatus() then
          RefMyStatus();
        Result := True;
      end;}
    3: begin
        if StdItem.Shape = 12 then begin
          bo06 := False;
          if LoWord(StdItem.DC) > 0 then begin
            m_wStatusArrValue[0] := LoWord(StdItem.DC);
            m_dwStatusArrTimeOutTick[0] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('����������' + IntToStr(HiWord(StdItem.MAC)) + '��', BB_Fuchsia, t_Hint);
            bo06 := True;
          end;
          if LoWord(StdItem.MC) > 0 then begin
            m_wStatusArrValue[1] := LoWord(StdItem.MC);
            m_dwStatusArrTimeOutTick[1 ] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('ħ��������' + IntToStr(HiWord(StdItem.MAC)) + '��', BB_Fuchsia, t_Hint);
            bo06 := True;
          end;
          if LoByte(StdItem.SC) > 0 then begin
            m_wStatusArrValue[2 ] := LoWord(StdItem.SC);
            m_dwStatusArrTimeOutTick[2] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('��������' + IntToStr(HiWord(StdItem.MAC)) + '��', BB_Fuchsia, t_Hint);
            bo06 := True;
          end;
          if HiWord(StdItem.AC) > 0 then begin
            m_wStatusArrValue[3] := HiWord(StdItem.AC);
            m_dwStatusArrTimeOutTick[3] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('�����ٶ�����' + IntToStr(HiWord(StdItem.MAC)) + '��', BB_Fuchsia, t_Hint);
            bo06 := True;
          end;
          if LoWord(StdItem.AC) > 0 then begin
            m_wStatusArrValue[4] := LoWord(StdItem.AC);
            m_dwStatusArrTimeOutTick[4] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('����ֵ����' + IntToStr(HiWord(StdItem.MAC)) + '��', BB_Fuchsia, t_Hint);
            bo06 := True;
          end;
          if LoWord(StdItem.MAC) > 0 then begin
            m_wStatusArrValue[5] := LoWord(StdItem.MAC);
            m_dwStatusArrTimeOutTick[5] := GetTickCount + HiWord(StdItem.MAC) * 1000;
            SysMsg('ħ��ֵ����' + IntToStr(HiWord(StdItem.MAC)) + '��', BB_Fuchsia, t_Hint);
            bo06 := True;
          end;
          if bo06 then begin
            RecalcAbilitys();
            CompareSuitItem(False);//��װ������װ���Ա� 20080729
            SendMsg(m_Master, RM_HEROABILITY, 0, 0, 0, 0, '');
            SendMsg(m_Master, RM_HEROSUBABILITY, 0, 0, 0, 0, '');
            Result := True;
          end;
        end else begin
          Result := EatUseItems(StdItem.Shape);
        end;
      end;
  end;
end;

function THeroObject.ReadBook(StdItem: pTStdItem): Boolean;
var
  Magic: pTMagic;
  UserMagic: pTUserMagic;
begin
  Result := False;
  Magic := UserEngine.FindHeroMagic(StdItem.Name);
  if Magic <> nil then begin
    if not IsTrainingSkill(Magic.wMagicId) then begin                                {������ܲ�����ְҵ 20080316}
      if ((Magic.sDescr = 'Ӣ��') or (Magic.sDescr = '�ڹ�')) and ((Magic.btJob = 99) or (Magic.btJob = m_btJob) or (Magic.wMagicId =75)) then begin
        if (Magic.sDescr = '�ڹ�') then begin//�ڹ�����
          if m_boTrainingNG then begin//ѧ���ڹ��ķ�����ѧϰ����
             if m_NGLevel >= Magic.TrainLevel[0] then begin//�ȼ��ﵽ���Ҫ��
               New(UserMagic);
               UserMagic.MagicInfo := Magic;
               UserMagic.wMagIdx := Magic.wMagicId;
               UserMagic.btKey := 0;
               UserMagic.btLevel := 0;
               UserMagic.nTranPoint := 0;
               m_MagicList.Add(UserMagic);
               RecalcAbilitys();
               CompareSuitItem(False);//��װ������װ���Ա� 20080729
               SendAddMagic(UserMagic);
               TPlayObject(m_Master).HeroAddSkillFunc(Magic.wMagicId);//Ӣ��ѧ���ܴ��� 20080324
               Result := True;
             end else SysMsg(Format('(Ӣ��) �ڹ��ķ��ȼ�û�дﵽ %d,����ѧϰ���ڹ����ܣ�����',[Magic.TrainLevel[0]]), c_Red, t_Hint);
          end else SysMsg('(Ӣ��) ûѧ���ڹ��ķ�,����ѧϰ���ڹ����ܣ�����', c_Red, t_Hint);
        end else begin//��ͨ����
          if (Magic.wMagicId in [60..65]) and (Magic.wMagicId <> GetTogetherUseSpell) then begin
            SysMsg('(Ӣ��) ����ѧϰ�˺ϻ����ܣ�����', BB_Fuchsia, t_Hint);
            Exit;
          end;
          if m_Abil.Level >= Magic.TrainLevel[0] then begin
            if (Magic.wMagicId = 68) and ((m_MaxExp68 <> 0) or (m_Exp68 <> 0)) then begin//�Ǿ������� 20080925
              m_MaxExp68:= 0;
              m_Exp68:= 0;
            end;
            New(UserMagic);
            UserMagic.MagicInfo := Magic;
            UserMagic.wMagIdx := Magic.wMagicId;
            UserMagic.btKey := 0;
            UserMagic.btLevel := 0;
            UserMagic.nTranPoint := 0;
            m_MagicList.Add(UserMagic);
            RecalcAbilitys();
            CompareSuitItem(False);//��װ������װ���Ա� 20080729
            SendAddMagic(UserMagic);
            TPlayObject(m_Master).HeroAddSkillFunc(Magic.wMagicId);//Ӣ��ѧ���ܴ��� 20080324
            Result := True;
          end;
        end;
      end else SysMsg('(Ӣ��) ����ѧϰ�˼��ܣ�����', BB_Fuchsia, t_Hint);
    end else SysMsg('(Ӣ��) �Ѿ�ѧ���˼���,������ѧϰ������', BB_Fuchsia, t_Hint);
  end else SysMsg('(Ӣ��) ����ѧϰ����ļ��ܣ�����', BB_Fuchsia, t_Hint);
end;
//�������ӵ�ħ��
procedure THeroObject.SendAddMagic(UserMagic: pTUserMagic);
var
  ClientMagic: TClientMagic;
begin
  ClientMagic.Key := Char(UserMagic.btKey);
  ClientMagic.Level := UserMagic.btLevel;
  ClientMagic.CurTrain := UserMagic.nTranPoint;
  ClientMagic.Def := UserMagic.MagicInfo^;
  m_DefMsg := MakeDefaultMsg(SM_HEROADDMAGIC, 0, 0, 0, 1, 0);
  SendSocket(@m_DefMsg, EncodeBuffer(@ClientMagic, SizeOf(TClientMagic)));
end;

procedure THeroObject.SendDelMagic(UserMagic: pTUserMagic);
begin
  m_DefMsg := MakeDefaultMsg(SM_HERODELMAGIC, UserMagic.wMagIdx, 0, 0, 1, 0);
  SendSocket(@m_DefMsg, '');
end;

function THeroObject.IsEnoughBag(): Boolean;
begin
  Result := False;
  if m_ItemList.Count < m_nItemBagCount then
    Result := True;
end;

procedure THeroObject.MakeWeaponUnlock;
begin
  if m_UseItems[U_WEAPON].wIndex <= 0 then Exit;
  if m_UseItems[U_WEAPON].btValue[3] > 0 then begin
    Dec(m_UseItems[U_WEAPON].btValue[3]);
    SysMsg(g_sTheWeaponIsCursed, BB_Fuchsia, t_Hint);
  end else begin
    if m_UseItems[U_WEAPON].btValue[4] < 10 then begin
      Inc(m_UseItems[U_WEAPON].btValue[4]);
      SysMsg(g_sTheWeaponIsCursed, BB_Fuchsia, t_Hint);
    end;
  end;
  if m_btRaceServer = RC_HEROOBJECT then begin
    RecalcAbilitys();
    CompareSuitItem(False);//��װ������װ���Ա� 20080729
    SendMsg(m_Master, RM_HEROABILITY, 0, 0, 0, 0, '');
    SendMsg(m_Master, RM_HEROSUBABILITY, 0, 0, 0, 0, '');
  end;
end;

//ʹ��ף����,������������
function THeroObject.WeaptonMakeLuck: Boolean;
var
  StdItem: pTStdItem;
  nRand: Integer;
  boMakeLuck: Boolean;
begin
  Result := False;
  if m_UseItems[U_WEAPON].wIndex <= 0 then Exit;
  nRand := 0;
  StdItem := UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
  if StdItem <> nil then begin
    nRand := abs((HiWord(StdItem.DC) - LoWord(StdItem.DC))) div 5;
  end;
  if Random(g_Config.nWeaponMakeUnLuckRate {20}) = 1 then begin
    MakeWeaponUnlock();
  end else begin
    boMakeLuck := False;
    if m_UseItems[U_WEAPON].btValue[4] > 0 then begin
      Dec(m_UseItems[U_WEAPON].btValue[4]);
      SysMsg(g_sWeaptonMakeLuck {'��������������...'}, BB_Fuchsia, t_Hint);
      boMakeLuck := True;
    end else if m_UseItems[U_WEAPON].btValue[3] < g_Config.nWeaponMakeLuckPoint1 {1} then begin
      Inc(m_UseItems[U_WEAPON].btValue[3]);
      SysMsg(g_sWeaptonMakeLuck {'��������������...'}, BB_Fuchsia, t_Hint);
      boMakeLuck := True;
    end else if (m_UseItems[U_WEAPON].btValue[3] < g_Config.nWeaponMakeLuckPoint2 {3}) and (Random(nRand + g_Config.nWeaponMakeLuckPoint2Rate {6}) = 1) then begin
      Inc(m_UseItems[U_WEAPON].btValue[3]);
      SysMsg(g_sWeaptonMakeLuck {'��������������...'}, BB_Fuchsia, t_Hint);
      boMakeLuck := True;
    end else if (m_UseItems[U_WEAPON].btValue[3] < g_Config.nWeaponMakeLuckPoint3 {7}) and (Random(nRand * g_Config.nWeaponMakeLuckPoint3Rate {10 + 30}) = 1) then begin
      Inc(m_UseItems[U_WEAPON].btValue[3]);
      SysMsg(g_sWeaptonMakeLuck {'��������������...'}, BB_Fuchsia, t_Hint);
      boMakeLuck := True;
    end;
    if m_btRaceServer = RC_HEROOBJECT then begin
      RecalcAbilitys();
      CompareSuitItem(False);//��װ������װ���Ա� 20080729
      SendMsg(m_Master, RM_HEROABILITY, 0, 0, 0, 0, '');
      SendMsg(m_Master, RM_HEROSUBABILITY, 0, 0, 0, 0, '');
    end;
    if not boMakeLuck then SysMsg(g_sWeaptonNotMakeLuck {'��Ч'}, BB_Fuchsia, t_Hint);
  end;
  Result := True;
end;
//�޸�����
function THeroObject.RepairWeapon: Boolean;
var
  nDura: Integer;
  UserItem: pTUserItem;
begin
  Result := False;
  UserItem := @m_UseItems[U_WEAPON];
  if (UserItem.wIndex <= 0) or (UserItem.DuraMax <= UserItem.Dura) then Exit;
  Dec(UserItem.DuraMax, (UserItem.DuraMax - UserItem.Dura) div g_Config.nRepairItemDecDura {30});
  nDura := _MIN(5000, UserItem.DuraMax - UserItem.Dura);
  if nDura > 0 then begin
    Inc(UserItem.Dura, nDura);
    if m_btRaceServer = RC_HEROOBJECT then begin
      SendMsg(m_Master, RM_HERODURACHANGE, 1, UserItem.Dura, UserItem.DuraMax, 0, '');
      SysMsg(g_sWeaponRepairSuccess {'�����޸��ɹ�...'}, BB_Fuchsia, t_Hint);
    end;
    Result := True;
  end;
end;
//�ص�Ʒ�����޸�
function THeroObject.SuperRepairWeapon: Boolean;
begin
  Result := False;
  if m_UseItems[U_WEAPON].wIndex <= 0 then Exit;
  m_UseItems[U_WEAPON].Dura := m_UseItems[U_WEAPON].DuraMax;
  if m_btRaceServer = RC_HEROOBJECT then begin
    SendMsg(m_Master, RM_HERODURACHANGE, 1, m_UseItems[U_WEAPON].Dura, m_UseItems[U_WEAPON].DuraMax, 0, '');
    SysMsg(g_sWeaponRepairSuccess {'�����޸��ɹ�...'}, BB_Fuchsia, t_Hint);
  end;
  Result := True;
end;
//Ӣ���޼�����  20080323 �޸�
//0����������40%   1������60%   2������80%  3������100%  ʱ�䶼��6��
function THeroObject.AbilityUp(UserMagic: pTUserMagic): Boolean;
var
  nSpellPoint, n14: Integer;
begin
  Result := False;
  nSpellPoint := GetSpellPoint(UserMagic);
  if nSpellPoint > 0 then begin
    if m_WAbil.MP < nSpellPoint then Exit;
    if g_Config.boAbilityUpFixMode then begin//�޼�����ʹ�ù̶�ʱ��ģʽ 20081109
      n14:= g_Config.nAbilityUpFixUseTime;//�޼�����ʹ�ù̶�ʱ�� 20081109
    end else n14:=(UserMagic.btLevel * 2)+ 2 + g_Config.nAbilityUpUseTime;//20080603
    m_dwStatusArrTimeOutTick[2] := GetTickCount + n14 * 1000;
    //m_wStatusArrValue[2] := MakeLong(LoWord(m_WAbil.SC), HiWord(m_WAbil.SC) - 2 - (m_Abil.Level div 7)) * 2;
    m_wStatusArrValue[2] := Round(HiWord(m_WAbil.SC)*(UserMagic.btLevel * 0.2 + 0.4));//����ֵ 20080827
    //m_dwStatusArrTimeOutTick[2] := GetTickCount + 6 * 1000;
    SysMsg('(Ӣ��) ����˲ʱ����' + IntToStr(m_wStatusArrValue[2]) + '������ ' + IntToStr(n14) + ' ��', c_Green, t_Hint);
    RecalcAbilitys();
    CompareSuitItem(False);//��װ������װ���Ա� 20080729
    SendMsg(m_Master, RM_HEROABILITY, 0, 0, 0, 0, '');
    SendMsg(m_Master, RM_HEROSUBABILITY, 0, 0, 0, 0, '');
    Result := True;
  end;
end;

procedure THeroObject.GainExp(dwExp: LongWord);
begin
  WinExp(dwExp);
end;

procedure THeroObject.WinExp(dwExp: LongWord);
begin
  if m_Abil.Level > g_Config.nLimitExpLevel then begin
    dwExp := g_Config.nLimitExpValue;
    GetExp(dwExp);
  end else
    if dwExp > 0 then begin
    dwExp := g_Config.dwKillMonExpMultiple * dwExp; //ϵͳָ��ɱ�־��鱶��
    dwExp := Round((m_nKillMonExpRate / 100) * dwExp); //����ָ����ɱ�־���ٷ���
    if m_PEnvir.m_boEXPRATE then
      dwExp := Round((m_PEnvir.m_nEXPRATE / 100) * dwExp); //��ͼ��ָ��ɱ�־��鱶��
    if m_boExpItem then begin //��Ʒ���鱶��
      dwExp := Round(m_rExpItem * dwExp);
    end;
    GetExp(dwExp);
  end;
end;

//ȡ���������� 20081001 Code:0-ɱ�ַ��� 1-��ɱ�ַ��� 2-����,˭������˭ 3-���˷���ɱ�־���
procedure THeroObject.GetNGExp(dwExp: LongWord; Code: Byte);
begin
  if m_boTrainingNG then begin
    if m_Abil.Level > g_Config.nLimitExpLevel then begin
      dwExp := g_Config.nLimitExpValue;
    end else
      if (dwExp > 0) and (Code = 0) then begin
      dwExp := g_Config.dwKillMonExpMultiple * dwExp; //ϵͳָ��ɱ�־��鱶��
      dwExp := Round((m_nKillMonExpRate / 100) * dwExp); //����ָ����ɱ�־���ٷ���
      if m_PEnvir.m_boEXPRATE then
        dwExp := Round((m_PEnvir.m_nEXPRATE / 100) * dwExp); //��ͼ��ָ��ɱ�־��鱶��
      if m_boExpItem then begin //��Ʒ���鱶��
        dwExp := Round(m_rExpItem * dwExp);
      end;
    end else
     if (dwExp > 0) and (Code = 3) then begin
       dwExp := g_Config.dwKillMonNGExpMultiple * dwExp;//ɱ���ڹ����鱶�� 20081218
    end;

    if (dwExp > 0) then begin
      if m_ExpSkill69 >= LongWord(dwExp) then begin//20090101
        if (High(LongWord) - m_ExpSkill69) < LongWord(dwExp) then begin
          dwExp := High(LongWord) - m_ExpSkill69;
        end;
      end else begin
        if (High(LongWord) - LongWord(dwExp)) < m_ExpSkill69 then begin
          dwExp := High(LongWord) - LongWord(dwExp);
        end;
      end;

      Inc(m_ExpSkill69, dwExp);//�ڹ��ķ���ǰ����
      if not TPlayObject(m_Master).m_boNotOnlineAddExp then //ֻ���͸������߹һ�����
        SendMsg(m_Master, RM_HEROWINNHEXP, 0, dwExp, 0, 0, '');
      if m_ExpSkill69 >= m_MaxExpSkill69 then begin
        Dec(m_ExpSkill69, m_MaxExpSkill69);
        Inc(m_NGLevel);
        m_MaxExpSkill69:= GetSkill69Exp(m_NGLevel, m_Skill69MaxNH);//ȡ�ڹ��ķ���������
        m_Skill69NH:= m_Skill69MaxNH;
        SendRefMsg(RM_MAGIC69SKILLNH, 0, m_Skill69NH, m_Skill69MaxNH, 0, ''); //����ֵ�ñ��˿��� 20081002
        SendRefMsg(RM_MYSHOW, ET_OBJECTLEVELUP,0, 0, 0, ''); //������������  20081216
      end;
      SendMsg(Self, RM_HEROMAGIC69SKILLEXP, 0, 0, 0, m_NGLevel, EncodeString(Inttostr(m_ExpSkill69)+'/'+Inttostr(m_MaxExpSkill69)));
    end;
  end;
end;

//�����Ӣ�۾���  20080110
procedure THeroObject.GetExp(dwExp: LongWord);
var
  nCode:byte;
begin
  nCode:= 0;
  try
    if m_Abil.Exp >= LongWord(dwExp) then begin//20090101
      if (High(LongWord) - m_Abil.Exp) < LongWord(dwExp) then begin
        dwExp := High(LongWord) - m_Abil.Exp;
      end;
    end else begin
      if (High(LongWord) - LongWord(dwExp)) < m_Abil.Exp then begin
        dwExp := High(LongWord) - LongWord(dwExp);
      end;
    end;

    m_GetExp:= dwExp;//����ȡ�õľ���,$GetExp����ʹ��  20081228
    Inc(m_nWinExp,dwExp);
    nCode:= 1;
    if m_nWinExp >= g_Config.nWinExp then begin  //�ۼƾ���,�ﵽһ��ֵ,����Ӣ�۵��ҳ϶�(20080110)
      nCode:= 2;
      m_nWinExp:=0;
      m_nLoyal:=m_nLoyal + g_Config.nExpAddLoyal;
      if m_nLoyal > 10000 then m_nLoyal:=10000;
      nCode:= 3;
      m_DefMsg := MakeDefaultMsg(SM_HEROABILITY, m_btGender, 0, m_btJob, m_nLoyal, 0);//����Ӣ�۵��ҳ϶� 20080306
      SendSocket(@m_DefMsg, EncodeBuffer(@m_WAbil, SizeOf(TAbility)));
    end;
    nCode:= 4;
    Inc(m_Abil.Exp, dwExp);
    //AddBodyLuck(dwExp * 0.002);
    nCode:= 5;
    if not TPlayObject(m_Master).m_boNotOnlineAddExp then //ֻ���͸������߹һ�����
      SendMsg(m_Master, RM_HEROWINEXP, 0, dwExp, 0, 0, '');
    if m_Abil.Exp >= m_Abil.MaxExp then begin
      nCode:= 6;
      Dec(m_Abil.Exp, m_Abil.MaxExp);
      if (m_Abil.Level < MAXUPLEVEL) and (m_Abil.Level < g_Config.nLimitExpLevel) then Inc(m_Abil.Level);//20080715 �������Ƶȼ�
      if m_Abil.Level < g_Config.nLimitExpLevel then HasLevelUp(m_Abil.Level - 1);//20080715 �������Ƶȼ�
      //AddBodyLuck(100);
      nCode:= 7;
      AddGameDataLog('12' + #9 + m_sMapName + #9 + //Ӣ��������¼��־ 20080911
        IntToStr(m_Abil.Level) + #9 + IntToStr(m_Abil.Exp)+'/'+IntToStr(m_Abil.MaxExp) + #9 +
        m_sCharName + #9 +'0' + #9 + '0' + #9 + '1' + #9 + '(Ӣ��)');
      nCode:= 8;
      IncHealthSpell(2000, 2000);
    end;
    nCode:= 9;
    if m_Magic68Skill <> nil then begin//ѧ���������� 20080925
      nCode:= 10;
      if m_Magic68Skill.btLevel < 100 then Inc(m_Exp68, dwExp);
      nCode:= 11;
      if m_Exp68 >= m_MaxExp68 then begin//������������,����������
        Dec(m_Exp68, m_MaxExp68);
        if m_Magic68Skill.btLevel < 100 then Inc(m_Magic68Skill.btLevel);
        nCode:= 12;
        m_MaxExp68 := GetSkill68Exp(m_Magic68Skill.btLevel);
        SendDelayMsg(Self, RM_HEROMAGIC_LVEXP, 0, m_Magic68Skill.MagicInfo.wMagicId, m_Magic68Skill.btLevel, m_Magic68Skill.nTranPoint, '', 100);
      end;
      nCode:= 13;
      if (Self <> nil) and (m_Magic68Skill.btLevel < 100) then
        SendMsg(Self, RM_HEROMAGIC68SKILLEXP, 0, 0, 0, 0, EncodeString(Inttostr(m_Exp68)+'/'+Inttostr(m_MaxExp68)));//���;������徭��
      //����Ϣ���¿ͻ�����ʾ
    end;
  except
    MainOutMessage('{�쳣} THeroObject.GetExp Code:'+ IntToStr(nCode));
  end;
end;
//�ܵ�Ŀ������
function THeroObject.RunToTargetXY(nTargetX, nTargetY: Integer): Boolean;
var
  nDir: Integer;
  n10: Integer;
  n14: Integer;
begin
  Result := False;
  if m_boTransparent and (m_boHideMode) then m_wStatusTimeArr[STATE_TRANSPARENT ] := 1;//20080902 ����,һ��������
  if (m_wStatusTimeArr[POISON_STONE] <> 0) and (not g_Config.ClientConf.boParalyCanSpell) then Exit;//��Բ����ܶ� 20080915
  if not m_boCanRun then Exit;//��ֹ��,���˳� 20080810
  if GetTickCount()- m_dwRunIntervalTime > g_Config.dwRunIntervalTime then begin//20080925
  //if GetTickCount()- dwTick3F4 > m_dwRunIntervalTime then begin //20080710
    n10 := nTargetX;
    n14 := nTargetY;
    {nDir := DR_DOWN;//��
    if n10 > m_nCurrX then begin
      nDir := DR_RIGHT;//��
      if n14 > m_nCurrY then nDir := DR_DOWNRIGHT;//������
      if n14 < m_nCurrY then nDir := DR_UPRIGHT;//������
    end else begin
      if n10 < m_nCurrX then begin
        nDir := DR_LEFT;//��
        if n14 > m_nCurrY then nDir := DR_DOWNLEFT;//������
        if n14 < m_nCurrY then nDir := DR_UPLEFT;//������
      end else begin
        if n14 > m_nCurrY then nDir := DR_DOWN//��
        else if n14 < m_nCurrY then nDir := DR_UP;//����
      end;
    end;  }
    nDir:= GetNextDirection(m_nCurrX , m_nCurrY, n10, n14);//20081005
    if not RunTo(nDir, False, nTargetX, nTargetY) then begin
       Result := WalkToTargetXY(nTargetX, nTargetY);
       if Result then dwTick3F4 := GetTickCount();
    end else begin
      if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
        Result := True;
        //dwTick3F4 := GetTickCount();
        m_dwRunIntervalTime:= GetTickCount();//20080925
      end;
    end;
  end;
end;
//����Ŀ��
function THeroObject.WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
var
  I: Integer;
  nDir: Integer;
  n10: Integer;
  n14: Integer;
  n20: Integer;
  nOldX: Integer;
  nOldY: Integer;
begin
  Result := False;
  if m_boTransparent and (m_boHideMode) then m_wStatusTimeArr[STATE_TRANSPARENT ] := 1;//20080902 ����,һ��������
  if (m_wStatusTimeArr[POISON_STONE] <> 0) and (not g_Config.ClientConf.boParalyCanSpell) then Exit;//��Բ����ܶ� 20080915
  if (abs(nTargetX - m_nCurrX) > 1) or (abs(nTargetY - m_nCurrY) > 1) then begin
    if GetTickCount()- dwTick3F4 > m_dwWalkIntervalTime then begin //20080217 �����߼��
      n10 := nTargetX;
      n14 := nTargetY;
      nDir := DR_DOWN;
      if n10 > m_nCurrX then begin
        nDir := DR_RIGHT;
        if n14 > m_nCurrY then nDir := DR_DOWNRIGHT;
        if n14 < m_nCurrY then nDir := DR_UPRIGHT;
      end else begin
        if n10 < m_nCurrX then begin
          nDir := DR_LEFT;
          if n14 > m_nCurrY then nDir := DR_DOWNLEFT;
          if n14 < m_nCurrY then nDir := DR_UPLEFT;
        end else begin
          if n14 > m_nCurrY then nDir := DR_DOWN
          else if n14 < m_nCurrY then nDir := DR_UP;
        end;
      end;
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      WalkTo(nDir, False);
      if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
         Result := True;
         dwTick3F4 := GetTickCount();
      end;
      if not Result then begin
        n20 := Random(3);
        for I := DR_UP to DR_UPLEFT do begin
          if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
            if n20 <> 0 then Inc(nDir)
            else if nDir > 0 then Dec(nDir)
            else nDir := DR_UPLEFT;
            if (nDir > DR_UPLEFT) then nDir := DR_UP;
            WalkTo(nDir, False);
            if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
              Result := True;
              dwTick3F4 := GetTickCount();
              Break;
            end;
          end;
        end;
      end;
    end;//20080217
  end;
end;
//ת��
function THeroObject.WalkToTargetXY2(nTargetX, nTargetY: Integer): Boolean;
var
  I: Integer;
  nDir: Integer;
  n10: Integer;
  n14: Integer;
  n20: Integer;
  nOldX: Integer;
  nOldY: Integer;
begin
  Result := False;
  if m_boTransparent and (m_boHideMode) then m_wStatusTimeArr[STATE_TRANSPARENT ] := 1;//20080902 ����,һ��������
  if (m_wStatusTimeArr[POISON_STONE] <> 0) and (not g_Config.ClientConf.boParalyCanSpell) then Exit;//��Բ����ܶ� 20080915
  if (nTargetX <> m_nCurrX) or (nTargetY <> m_nCurrY) then begin
    if GetTickCount()- dwTick3F4 > m_dwTurnIntervalTime then begin //20080217 ����ת����
      n10 := nTargetX;
      n14 := nTargetY;
      nDir := DR_DOWN;
      if n10 > m_nCurrX then begin
        nDir := DR_RIGHT;
        if n14 > m_nCurrY then nDir := DR_DOWNRIGHT;
        if n14 < m_nCurrY then nDir := DR_UPRIGHT;
      end else begin
        if n10 < m_nCurrX then begin
          nDir := DR_LEFT;
          if n14 > m_nCurrY then nDir := DR_DOWNLEFT;
          if n14 < m_nCurrY then nDir := DR_UPLEFT;
        end else begin
          if n14 > m_nCurrY then nDir := DR_DOWN
          else if n14 < m_nCurrY then nDir := DR_UP;
        end;
      end;
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      WalkTo(nDir, False);
      if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then begin
        Result := True;
        dwTick3F4 := GetTickCount();
      end;
      if not Result then begin
        n20 := Random(3);
        for I := DR_UP to DR_UPLEFT do begin
          if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
            if n20 <> 0 then Inc(nDir)
            else if nDir > 0 then Dec(nDir)
            else nDir := DR_UPLEFT;
            if (nDir > DR_UPLEFT) then nDir := DR_UP;
            WalkTo(nDir, False);
            if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then begin
              Result := True;
              dwTick3F4 := GetTickCount();
              Break;
            end;
          end;
        end;
      end;
    end;//20080217
  end;
end;

//20080828�޸�
function THeroObject.GotoTargetXY(nTargetX, nTargetY, nCode: Integer): Boolean;
begin
  case nCode of
    0:begin//����ģʽ
      if (abs(m_nCurrX - nTargetX) > 2{1}) or (abs(m_nCurrY - nTargetY) > 2{1}) then begin
        if m_wStatusTimeArr[STATE_LOCKRUN] = 0 then begin//20080812 ����,������������
           Result := RunToTargetXY(nTargetX, nTargetY);
        end else begin
           Result := WalkToTargetXY2(nTargetX, nTargetY); //ת��
        end;
      end else begin
        Result := WalkToTargetXY2(nTargetX, nTargetY); //ת��
      end;
    end;//0
    1:begin//���ģʽ
      if (abs(m_nCurrX - nTargetX) > 1) or (abs(m_nCurrY - nTargetY) > 1) then begin
        if m_wStatusTimeArr[STATE_LOCKRUN] = 0 then begin//20080812 ����,������������
           Result := RunToTargetXY(nTargetX, nTargetY);
        end else begin
           Result := WalkToTargetXY2(nTargetX, nTargetY); //ת��
        end;
      end else begin
        Result := WalkToTargetXY2(nTargetX, nTargetY); //ת��
      end;
    end;//1
  end;
end;

function THeroObject.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  //  Result:=False;
  case ProcessMsg.wIdent of
    RM_STRUCK: begin//��������
        if (ProcessMsg.BaseObject = Self) and (TBaseObject(ProcessMsg.nParam3 {AttackBaseObject}) <> nil) then begin
          if (TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT) then begin//20080531 ����
            if (not TBaseObject(ProcessMsg.nParam3).InSafeZone) and (not InSafeZone) then begin
               SetLastHiter(TBaseObject(ProcessMsg.nParam3 {AttackBaseObject}));//����������Լ�����
               Struck(TBaseObject(ProcessMsg.nParam3{AttackBaseObject}));
               BreakHolySeizeMode();
            end;
          end else begin
            SetLastHiter(TBaseObject(ProcessMsg.nParam3 {AttackBaseObject}));//����������Լ�����
            Struck(TBaseObject(ProcessMsg.nParam3 {AttackBaseObject}));
            BreakHolySeizeMode();
          end;
          if (m_Master <> nil) and
            (TBaseObject(ProcessMsg.nParam3) <> m_Master) and
            ((TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT) or
             (TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_HEROOBJECT)) then begin//Ӣ�ۻ�ɫ 20080721
             m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
          end;
          if g_Config.boMonSayMsg then MonsterSayMsg(TBaseObject(ProcessMsg.nParam3), s_UnderFire);
        end;
        Result := True;
      end;
  else begin
      Result := inherited Operate(ProcessMsg);
    end;
  end;
end;
{ 20080117
function THeroObject.CompareHP(BaseObject1, BaseObject2: TBaseObject): Boolean;
var
  HP1, HP2: Integer;
begin
  HP1 := BaseObject1.m_WAbil.HP * 100 div BaseObject1.m_WAbil.MaxHP;
  HP2 := BaseObject2.m_WAbil.HP * 100 div BaseObject2.m_WAbil.MaxHP;
  Result := HP1 > HP2;
end;  

function THeroObject.CompareLevel(BaseObject1, BaseObject2: TBaseObject): Boolean;
begin
  Result := BaseObject1.m_WAbil.Level < BaseObject2.m_WAbil.Level;
end;  

function THeroObject.CompareXY(BaseObject1, BaseObject2: TBaseObject): Boolean;
var
  nXY1, nXY2: Integer;
begin
  nXY1 := abs(BaseObject1.m_nCurrX - m_nCurrX) + abs(BaseObject1.m_nCurrY - m_nCurrY);
  nXY2 := abs(BaseObject2.m_nCurrX - m_nCurrX) + abs(BaseObject2.m_nCurrY - m_nCurrY);
  Result := nXY1 > nXY2;
end;  }
//������
procedure THeroObject.Struck(hiter: TBaseObject);
begin
  if not m_boTarget then begin
    m_dwStruckTick := GetTickCount;
    if hiter <> nil then begin     {20080710ע��}                           {20080222 ע��}
      if (m_TargetCret = nil) {and (m_btStatus = 0)} and (not m_boTarget){  or GetAttackDir(m_TargetCret, btDir)or (Random(6) = 0)} then begin
        if IsProperTarget(hiter) then SetTargetCreat(hiter);//����ΪĿ��
      end;
    end;
    if m_boAnimal then begin
      m_nMeatQuality := m_nMeatQuality - Random(300);
      if m_nMeatQuality < 0 then m_nMeatQuality := 0;
    end;
  end;
  m_dwHitTick := m_dwHitTick + LongWord(150 - _MIN(130, m_Abil.Level * 4));
end;

procedure THeroObject.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
begin
  inherited AttackDir(TargeTBaseObject, m_wHitMode, nDir);
end;

procedure THeroObject.DelTargetCreat;
begin
  inherited;
  m_nTargetX := -1;
  m_nTargetY := -1;
end;
//����Ŀ��
procedure THeroObject.SearchTarget;
var
  BaseObject, BaseObject18: TBaseObject;
  I, nC, n10: Integer;
begin
  if (m_TargetCret = nil) and m_boTarget then m_boTarget := False;
  if (m_TargetCret <> nil) and m_boTarget then begin
    if m_TargetCret.m_boDeath then m_boTarget := False;
  end;

  if (m_btStatus = 0) and {not m_boProtectStatus and} not m_boTarget then begin//�ػ�״̬һ������Ŀ�� 20080402
    BaseObject18 := nil;
    n10 := 15;
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath then begin
          if IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then begin
            nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
            if nC < n10 then begin
              n10 := nC;
              BaseObject18 := BaseObject;
            end;
          end;
        end;
      end;
    end;
    if BaseObject18 <> nil then begin
      SetTargetCreat(BaseObject18);
      {if (m_TargetCret <> nil) and (m_TargetCret.m_boDeath) then m_TargetCret := nil;
      if m_TargetCret <> nil then begin
        if CompareHP(m_TargetCret, BaseObject18) and CompareLevel(m_TargetCret, BaseObject18) and CompareXY(m_TargetCret, BaseObject18) then begin
          SetTargetCreat(BaseObject18);
        end;
      end else SetTargetCreat(BaseObject18); }
    end;
  end;
end;

procedure THeroObject.SetTargetXY(nX, nY: Integer);
begin
  m_nTargetX := nX;
  m_nTargetY := nY;
end;

procedure THeroObject.Wondering;
begin
  if (Random(10) = 0) then
    if (Random(4) = 1) then TurnTo(Random(8))
    else WalkTo(m_btDirection, False);
end;
//�ǲ��ǿ���ʹ�õ�ħ�� 20080606
//UserMagic.btKey 0-���ܿ�,1--���ܹ�
function THeroObject.IsAllowUseMagic(wMagIdx: Word): Boolean;
var
  UserMagic: pTUserMagic;
begin
  Result := False;
  UserMagic := CheckUserMagic(wMagIdx);
  if UserMagic <> nil then begin
    if (GetSpellPoint(UserMagic) < m_WAbil.MP) and (UserMagic.btKey = 0) then Result := True;
  end;
end;

function THeroObject.SelectMagic(): Integer;
//var
//  I:integer;
//  Slave:TBaseObject ;
begin
  Result := 0;
  case m_btJob of
    0: begin //սʿ
        if IsAllowUseMagic(75) and (m_wStatusTimeArr[STATE_ProtectionDEFENCE] = 0) and (not m_boProtectionDefence) and (m_ExpHitter <> nil) and//20081214 �ܹ���ʱ�ſ���
          (GetTickCount - m_boProtectionTick > g_Config.dwProtectionTick) and
          (GetTickCount - m_SkillUseTick[75] > 3000) then begin //ʹ�� ������� 20080107
          m_SkillUseTick[75]:= GetTickCount;//20080228
          Result := 75;
          Exit;
        end;
        if IsAllowUseMagic(68) and (m_WAbil.MP > 30) and (GetTickCount - m_SkillUseTick[68] > 3000) then begin//�������� 20080925
          if (m_Abil.WineDrinkValue >= Round(m_Abil.MaxAlcohol * g_Config.nMinDrinkValue68 div 100)) then begin
            if (GetTickCount - m_dwStatusArrTimeOutTick[4] > g_Config.nHPUpTick * 1000) and (m_wStatusArrValue[4] = 0) then begin
              m_SkillUseTick[68]:= GetTickCount;
              Result := 68;
              Exit;
            end;
          end;
        end;

       //Զ�������ÿ����ػ��������ս��� 20080603
        if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) and (abs(m_TargetCret.m_nCurrX - m_nCurrX) < 5)) or
          ((abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 5)) then begin
          if IsAllowUseMagic(43) and ((GetTickCount - m_dwLatest42Tick) > g_Config.nKill43UseTime * 1000) then begin
             m_bo42kill := True;
             m_n42kill := 2;//�ػ�
             Result := 43;
             Exit;
          end;
          if IsAllowUseMagic(74) and ((GetTickCount - m_dwLatestDailyTick) > 12000{12 * 1000}) then begin //���ս��� 20080528
            m_boDailySkill := True;
            Result := 74;
            Exit;
          end;
        end;

        if IsAllowUseMagic(43) and ((GetTickCount - m_dwLatest42Tick) > g_Config.nKill43UseTime * 1000) then begin //����ն  20080203
          m_bo42kill := True;
          Result := 43;
          if (Random(g_Config.n43KillHitRate) = 0) and (g_Config.btHeroSkillMode43 or (m_TargetCret.m_Abil.Level <= m_Abil.Level)) then begin//Ŀ��ȼ��������Լ�,��ʹ���ػ� 20080826
            m_n42kill := 2;//�ػ�
          end else begin
            m_n42kill := 1;//���
          end;
          Exit;
        end;

        //��ɱλ 20080603
        if (abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2) then begin
          if IsAllowUseMagic(12) then begin //Ӣ�۴�ɱ����
            if not m_boUseThrusting then ThrustingOnOff(True);
            Result := 12;
            exit;
          end;
        end;
        if IsAllowUseMagic(74) and ((GetTickCount - m_dwLatestDailyTick) > 12000{12 * 1000}) then begin //���ս��� 20080528
          m_boDailySkill := True;
          Result := 74;
          Exit;
        end;
        if IsAllowUseMagic(26) and ((GetTickCount - m_dwLatestFireHitTick) > 9000{9 * 1000}) then begin //�һ�  20080112 ����
          //AllowFireHitSkill;
          m_boFireHitSkill := True;
          Result := 26;
          Exit;
        end;
        if IsAllowUseMagic(42) and (GetTickCount - m_dwLatest43Tick > g_Config.nKill42UseTime * 1000) then begin //��Ӱ���� 20080619
          m_bo43kill := True;
          Result := 42;
          Exit;
        end;

        if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil))
         and (m_TargetCret.m_Abil.Level < m_Abil.Level){ and (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.8))} then begin //PKʱ,ʹ��Ұ����ײ  20080826 Ѫ����800ʱʹ��
          if IsAllowUseMagic(27) and ((GetTickCount - m_SkillUseTick[27]) >  10000{10 * 1000}) then begin //pkʱ����Է��ȼ����Լ��;�ÿ��һ��ʱ����һ��Ұ��  20080203
            m_SkillUseTick[27] := GetTickCount;
            Result := 27;
            Exit;
          end
        end else begin //���ʹ�� 20080323
          if IsAllowUseMagic(27) and ((GetTickCount - m_SkillUseTick[27]) > 10000{10 * 1000})
           and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.85)) then begin
             m_SkillUseTick[27] := GetTickCount;
             Result := 27;
             Exit;
          end;
        end;

        if (m_TargetCret.m_Master <> nil) then m_ExpHitter := m_TargetCret.m_Master;//20080924

        if CheckTargetXYCount1(m_nCurrX, m_nCurrY, 1) > 1 then begin //�������Χ   //20080924
            case Random(3) of
              0:begin                                                                                                                                    //20080710 PKʱ����ʨ�Ӻ�
                  if IsAllowUseMagic(41) and (GetTickCount - m_SkillUseTick[41] >  10000{10 * 1000}) and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin
                    m_SkillUseTick[41] := GetTickCount; //ʨ�Ӻ�
                    Result := 41;
                    Exit;
                  end;
                  if IsAllowUseMagic(7)  and ((GetTickCount - m_SkillUseTick[7]) >  10000{10 * 1000}) then begin //��ɱ���� 20071213
                    m_SkillUseTick[7]:= GetTickCount;
                    m_boPowerHit := True;//20080401 ������ɱ
                    Result := 7;
                    Exit;
                  end;
                  if IsAllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] >  10000{10 * 1000}) then begin
                     m_SkillUseTick[39] := GetTickCount; //Ӣ�۳��ض�
                     Result := 39;
                     Exit;
                  end;
                  if IsAllowUseMagic(25) and (CheckTargetXYCount2 > 0){and (GetTickCount - m_SkillUseTick[25] > 1000 * 3)} then begin //Ӣ�۰����䵶
                    //m_SkillUseTick[25] := GetTickCount;
                    if not m_boUseHalfMoon then  HalfMoonOnOff(True);
                    Result := 25;
                    exit;
                  end;
                  if IsAllowUseMagic(40) {and (GetTickCount - m_SkillUseTick[40] > 1000 * 3)} then begin //Ӣ�۱��µ���
                   // m_SkillUseTick[40] := GetTickCount;
                    if not m_boCrsHitkill then SkillCrsOnOff(True);
                    Result := 40;
                    exit;
                  end;
                  if IsAllowUseMagic(12)  then begin //Ӣ�۴�ɱ����
                    if not m_boUseThrusting then ThrustingOnOff(True);
                    Result := 12;
                    exit;
                  end;
                end;
              1:begin
                  if IsAllowUseMagic(41) and (GetTickCount - m_SkillUseTick[41] >  10000{10 * 1000}) and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin
                    m_SkillUseTick[41] := GetTickCount; //ʨ�Ӻ�
                    Result := 41;
                    Exit;
                  end;
                  if IsAllowUseMagic(7)  and ((GetTickCount - m_SkillUseTick[7]) >  10000{10 * 1000}) then begin //��ɱ���� 20071213
                    m_SkillUseTick[7]:= GetTickCount;
                    m_boPowerHit := True;//20080401 ������ɱ
                    Result := 7;
                    Exit;
                  end;
                  if IsAllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] >  10000{10 * 1000}) then begin
                     m_SkillUseTick[39] := GetTickCount; //Ӣ�۳��ض�
                     Result := 39;
                     Exit;
                  end;
                  if IsAllowUseMagic(40) {and (GetTickCount - m_SkillUseTick[40] > 1000 * 3)} then begin //Ӣ�۱��µ���
                    //m_SkillUseTick[40] := GetTickCount;
                    if not m_boCrsHitkill then SkillCrsOnOff(True);
                    Result := 40;
                    exit;
                  end;
                  if IsAllowUseMagic(25) and (CheckTargetXYCount2 > 0){and (GetTickCount - m_SkillUseTick[25] > 1000 * 3)} then begin //Ӣ�۰����䵶
                    //m_SkillUseTick[25] := GetTickCount;
                    if not m_boUseHalfMoon then HalfMoonOnOff(True);
                    Result := 25;
                    exit;
                  end;
                  if IsAllowUseMagic(12) then begin //Ӣ�۴�ɱ����
                    if not m_boUseThrusting then ThrustingOnOff(True);
                    Result := 12;
                    exit;
                  end;
                end;
              2:begin
                  if IsAllowUseMagic(41) and (GetTickCount - m_SkillUseTick[41] >  10000{10 * 1000}) and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin
                    m_SkillUseTick[41] := GetTickCount; //ʨ�Ӻ�
                    Result := 41;
                    Exit;
                  end;
                  if IsAllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] > 10000{10 * 1000}) then begin
                     m_SkillUseTick[39] := GetTickCount; //Ӣ�۳��ض�
                     Result := 39;
                     Exit;
                  end;
                  if IsAllowUseMagic(7)  and ((GetTickCount - m_SkillUseTick[7]) > 10000{10 * 1000}) then begin //��ɱ���� 20071213
                    m_SkillUseTick[7] := GetTickCount;
                    m_boPowerHit := True;//20080401 ������ɱ
                    Result := 7;
                    Exit;
                  end;
                  if IsAllowUseMagic(40) {and (GetTickCount - m_SkillUseTick[40] > 1000 * 3)} then begin //Ӣ�۱��µ���
                    //m_SkillUseTick[40] := GetTickCount;
                    if not m_boCrsHitkill then  SkillCrsOnOff(True);
                    Result := 40;
                    exit;
                  end;
                  if IsAllowUseMagic(25) and (CheckTargetXYCount2 > 0){and (GetTickCount - m_SkillUseTick[25] > 1000 * 3)} then begin //Ӣ�۰����䵶
                    //m_SkillUseTick[25] := GetTickCount;
                    if not m_boUseHalfMoon then  HalfMoonOnOff(True);
                    Result := 25;
                    exit;
                  end;
                  if IsAllowUseMagic(12) then begin //Ӣ�۴�ɱ����
                    if not m_boUseThrusting then ThrustingOnOff(True);
                    Result := 12;
                    exit;
                  end;
                end;
            end;
        end else begin
            if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil)) and
             (CheckTargetXYCount1(m_nCurrX, m_nCurrY, 1) > 1) then begin//PK 20080915 ��߳���2��Ŀ���ʹ��
              if IsAllowUseMagic(40) and (GetTickCount - m_SkillUseTick[40] > 3000) then begin //Ӣ�۱��µ���
                m_SkillUseTick[40] := GetTickCount;
                if not m_boCrsHitkill then  SkillCrsOnOff(True);
                Result := 40;
                exit;
              end;
              if IsAllowUseMagic(25) and (CheckTargetXYCount2 > 0) and (GetTickCount - m_SkillUseTick[25] > 1500) then begin //Ӣ�۰����䵶
                m_SkillUseTick[25] := GetTickCount;
                if not m_boUseHalfMoon then  HalfMoonOnOff(True);
                Result := 25;
                exit;
              end;
            end;
        //20071213���� ������������ ��ɱ����
            if IsAllowUseMagic(7)  and ((GetTickCount - m_SkillUseTick[7]) >  10000{10 * 1000}) then begin //��ɱ����
              m_SkillUseTick[7]:= GetTickCount;
              m_boPowerHit := True;//20080401 ������ɱ
              Result := 7;
              Exit;
            end;
            if IsAllowUseMagic(12) and (GetTickCount - m_SkillUseTick[12] > 1000) then begin //Ӣ�۴�ɱ����
              if not m_boUseThrusting then ThrustingOnOff(True);
              m_SkillUseTick[12]:= GetTickCount;
              Result := 12;
              Exit;
            end;
        end;
         //�Ӹߵ���ʹ��ħ��,20080710
        if IsAllowUseMagic(43) and (GetTickCount - m_dwLatest42Tick > g_Config.nKill43UseTime * 1000) then begin //����ն
          m_bo42kill := True;
          Result := 43;
          if (Random(g_Config.n43KillHitRate) = 0) and (g_Config.btHeroSkillMode43 or (m_TargetCret.m_Abil.Level <= m_Abil.Level)) then begin
           m_n42kill := 2;//�ػ�
          end else begin
           m_n42kill := 1;//���
          end;
          Exit;
        end else
        if IsAllowUseMagic(42) and (GetTickCount - m_dwLatest43Tick > g_Config.nKill42UseTime * 1000) then begin //��Ӱ����
          m_bo43kill := True;
          Result := 42;
          Exit;
        end else
        if IsAllowUseMagic(74) and (GetTickCount - m_dwLatestDailyTick > 12000) then begin //���ս���
          m_boDailySkill := True;
          Result := 74;
          Exit;
        end else
        if IsAllowUseMagic(26) and (GetTickCount - m_dwLatestFireHitTick > 9000) then begin //�һ�
          m_boFireHitSkill := True;
          Result := 26;
          Exit;
        end;
        if IsAllowUseMagic(40) and (GetTickCount - m_SkillUseTick[40] > 3000) and (CheckTargetXYCount1(m_nCurrX, m_nCurrY, 1) > 1) then begin //Ӣ�۱��µ���
          if not m_boCrsHitkill then SkillCrsOnOff(True);
          m_SkillUseTick[40]:= GetTickCount();
          Result := 40;
          exit;
        end;
        if IsAllowUseMagic(39) and (GetTickCount - m_SkillUseTick[39] > 3000) then begin//Ӣ�۳��ض�
           m_SkillUseTick[39]:= GetTickCount;
           Result := 39;
           Exit;
        end;
        if IsAllowUseMagic(25) and (GetTickCount - m_SkillUseTick[25] > 3000) and (CheckTargetXYCount2 > 0) then begin //Ӣ�۰����䵶
          if not m_boUseHalfMoon then HalfMoonOnOff(True);
          m_SkillUseTick[25]:= GetTickCount;
          Result := 25;
          exit;
        end;
        if IsAllowUseMagic(12) and (GetTickCount - m_SkillUseTick[12] > 3000) then begin //Ӣ�۴�ɱ����
          if not m_boUseThrusting then ThrustingOnOff(True);
          m_SkillUseTick[12]:= GetTickCount;
          Result := 12;
          exit;
        end;
        if IsAllowUseMagic(7) and (GetTickCount - m_SkillUseTick[7] > 3000) then begin //��ɱ����
          m_boPowerHit := True;
          m_SkillUseTick[7]:= GetTickCount;
          Result := 7;
          Exit;
        end;
        if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil))
         and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.6)) then begin //PKʱ,ʹ��Ұ����ײ
          if IsAllowUseMagic(27) and (GetTickCount - m_SkillUseTick[27] > 3000) then begin
            m_SkillUseTick[27]:= GetTickCount;
            Result := 27;
            Exit;
          end
        end else begin //���ʹ�� 20080323
          if IsAllowUseMagic(27) and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.6))
           and (GetTickCount - m_SkillUseTick[27] > 3000) then begin
             m_SkillUseTick[27]:= GetTickCount;
             Result := 27;
             Exit;
          end;
        end;
        if IsAllowUseMagic(41) and (m_TargetCret.m_Abil.Level < m_Abil.Level) and (GetTickCount - m_SkillUseTick[41] >  10000) then begin//ʨ�Ӻ�
          m_SkillUseTick[41]:= GetTickCount();
          Result := 41;
          Exit;
        end;
      end;
    1: begin //��ʦ
        //ʹ�� ������� 20080107
        if IsAllowUseMagic(75) and (m_wStatusTimeArr[STATE_ProtectionDEFENCE] = 0) and (not m_boProtectionDefence) and (m_ExpHitter <> nil) and//20081214 �ܹ���ʱ�ſ���
          (GetTickCount - m_boProtectionTick > g_Config.dwProtectionTick) and
          (GetTickCount - m_SkillUseTick[75] > 3000) then begin
          m_SkillUseTick[75]:= GetTickCount;//20080228
          Result := 75;
          Exit;
        end;
        //ʹ�� ħ����
        if (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0) and (not m_boAbilMagBubbleDefence) then begin
          if IsAllowUseMagic(66) then begin//4��ħ����
            Result := 66;
            Exit;
          end;
          if IsAllowUseMagic(31) then begin
            Result := 31;
            Exit;
          end;
        end;
        //�������� 20080925
        if IsAllowUseMagic(68) and (m_WAbil.MP > 30) and (GetTickCount - m_SkillUseTick[68] > 3000) then begin
          if (m_Abil.WineDrinkValue >= Round(m_Abil.MaxAlcohol * g_Config.nMinDrinkValue68 div 100)) then begin
            if (GetTickCount - m_dwStatusArrTimeOutTick[4] > g_Config.nHPUpTick * 1000) and (m_wStatusArrValue[4] = 0) then begin
              m_SkillUseTick[68]:= GetTickCount;
              Result := 68;
              Exit;
            end;
          end;
        end;

        //��������,��ʹ�÷����� 20080206
        if (m_SlaveList.Count = 0) and IsAllowUseMagic(46) and ((GetTickCount - m_dwLatest46Tick) > g_Config.nCopyHumanTick * 1000)//�ٻ�������
         and ((g_Config.btHeroSkillMode46) or (m_LastHiter<> nil) or (m_ExpHitter<> nil)) then begin
          if m_Magic46Skill <> nil then begin
            case m_Magic46Skill.btLevel of//�����ܵȼ����ȼ�����������ж��Ƿ��ʹ�÷�����
              0: begin
                if (m_WAbil.HP <= Round(m_WAbil.MaxHP * (g_Config.nHeroSkill46MaxHP_0 /100))) then begin//20080826 �ܵ�������,HP����80%��ʹ�÷���
                  Result := 46;
                  Exit;
                end;
              end;
              1: begin
                if (m_WAbil.HP <= Round(m_WAbil.MaxHP * (g_Config.nHeroSkill46MaxHP_1 /100))) then begin//1�� Ӣ���ٻ�����HP�ı��� 20081217
                  Result := 46;
                  Exit;
                end;
              end;
              2: begin
                if (m_WAbil.HP <= Round(m_WAbil.MaxHP * (g_Config.nHeroSkill46MaxHP_2 /100))) then begin//1�� Ӣ���ٻ�����HP�ı��� 20081217
                  Result := 46;
                  Exit;
                end;
              end;
              3: begin
                if (m_WAbil.HP <= Round(m_WAbil.MaxHP * (g_Config.nHeroSkill46MaxHP_3 /100))) then begin//1�� Ӣ���ٻ�����HP�ı��� 20081217
                  Result := 46;
                  Exit;
                end;
              end;
            end;//case
          end;
        end;

        if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil))
         and (CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) > 0) and (m_TargetCret.m_WAbil.Level < m_WAbil.Level) then begin //PKʱ,�Ա���������,ʹ�ÿ��ܻ�
          if IsAllowUseMagic(8) and ((GetTickCount - m_SkillUseTick[8]) > 3000{3 * 1000}) then begin
            m_SkillUseTick[8] := GetTickCount;
            Result := 8;
            Exit;
          end
        end else begin //���,�ּ������Լ�,�����йְ�Χ�Լ����� ���ܻ�
          if IsAllowUseMagic(8) and ((GetTickCount - m_SkillUseTick[8]) > 3000{3 * 1000})
            and (CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) > 0)
            and (m_TargetCret.m_WAbil.Level < m_WAbil.Level) then begin
             m_SkillUseTick[8] := GetTickCount;
             Result := 8;
             Exit;
          end;
        end;

        if (m_nLoyal >= 500) and ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or
          (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil)) then begin
          if IsAllowUseMagic(45) and (GetTickCount - m_SkillUseTick[45] > 1300) then begin//�ҳ϶�5%ʱ��PKʱʹ������������ 20080828
            m_SkillUseTick[45] := GetTickCount;
            Result := 45;//Ӣ�������
            Exit;
          end;
        end else begin
          if IsAllowUseMagic(45) and (GetTickCount - m_SkillUseTick[45] > 3000{1000 * 3}) then begin
            m_SkillUseTick[45] := GetTickCount;
            Result := 45;//Ӣ�������
            Exit;
          end;
        end;

        if (GetTickCount - m_SkillUseTick[10] > 5000{1000 * 5}) and m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY) then begin
          if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil))
           and (GetDirBaseObjectsCount(m_btDirection,5)> 0) and
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)))) then begin
            if IsAllowUseMagic(10) then begin
              m_SkillUseTick[10] := GetTickCount;
              Result := 10;//Ӣ�ۼ����Ӱ  20080421
              Exit;
            end else
            if IsAllowUseMagic(9) then begin
              m_SkillUseTick[10] := GetTickCount;
              Result := 9;//������
              Exit;
            end;
          end else
          if (GetDirBaseObjectsCount(m_btDirection,5)> 1) and
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)))) then begin
            if IsAllowUseMagic(10) then begin
              m_SkillUseTick[10] := GetTickCount;
              Result := 10;//Ӣ�ۼ����Ӱ  20080421
              Exit;
            end else
            if IsAllowUseMagic(9) then begin
              m_SkillUseTick[10] := GetTickCount;
              Result := 9;//������
              Exit;
            end;
          end;
        end;

        if IsAllowUseMagic(32) and (GetTickCount - m_SkillUseTick[32] > 10000{1000 * 10}) and (m_TargetCret.m_Abil.Level < g_Config.nMagTurnUndeadLevel) and
        (m_TargetCret.m_btLifeAttrib = LA_UNDEAD) and (m_TargetCret.m_WAbil.Level < m_WAbil.Level -1) then begin //Ŀ��Ϊ����ϵ
          m_SkillUseTick[32] := GetTickCount;
          Result := 32; //ʥ���� 20080710
          Exit;
        end;

        if CheckTargetXYCount(m_nCurrX, m_nCurrY, 2) > 1 then begin //�������Χ    
          if IsAllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 10000{10 * 1000}) and (g_EventManager.GetRangeEvent(m_PEnvir, Self, m_nCurrX, m_nCurrY, 6, ET_FIRE) <> 0) then begin
            if (m_TargetCret.m_btRaceServer <> 101) and (m_TargetCret.m_btRaceServer <> 102) and (m_TargetCret.m_btRaceServer <> 104) then begin//�������,�ŷŻ�ǽ 20081217
              m_SkillUseTick[22] := GetTickCount;
              Result := 22; //��ǽ
              Exit;
            end;
          end;
          //�����׹�,ֻ������(101,102,104)������(91,92,97)��Ұ��(81)ϵ�е���   20080217
          //��������Ĺ�Ӧ�ö��õ����׹⣬�����׵��������ñ����� 20080228
          if m_TargetCret.m_btRaceServer in [91,92,97,101,102,104] then begin
            if IsAllowUseMagic(24) and (GetTickCount - m_SkillUseTick[24] > 4000{1000 * 4}) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
              m_SkillUseTick[24] := GetTickCount;
              Result := 24; //�����׹�
              Exit;
            end else
            if IsAllowUseMagic(11) then begin
              Result := 11; //Ӣ���׵���
              Exit;
            end else
            if IsAllowUseMagic(33) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 2) > 2) then begin
              Result := 33; //Ӣ�۱�����
              Exit;
            end else
            if IsAllowUseMagic(58) and (GetTickCount - m_SkillUseTick[58] > 4000{1000 * 4}) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
              m_SkillUseTick[58] := GetTickCount;
              Result := 58; //���ǻ��� 20080528
              Exit;
            end;
          end;

          case Random(3) of //���ѡ��ħ��
            0: begin
                //������,�����,�׵���,���ѻ���,Ӣ�۱�����,���ǻ��� �Ӹߵ���ѡ��
                if IsAllowUseMagic(58) and (GetTickCount - m_SkillUseTick[58] > 4000{1000 * 4}) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58] := GetTickCount;
                  Result := 58; //���ǻ���
                  Exit;
                end else
                if IsAllowUseMagic(33) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin
                  Result := 33; //Ӣ�۱�����
                  Exit;
                end else
                if IsAllowUseMagic(23) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin
                  Result := 23; //���ѻ���
                  Exit;
                end else
                if IsAllowUseMagic(11) then begin
                  Result := 11; //Ӣ���׵���
                  Exit;
                end else
                if IsAllowUseMagic(5) and (m_nLoyal < 500) then begin
                  Result := 5;//�����
                  Exit;
                end else
                if IsAllowUseMagic(1) and (m_nLoyal < 500) then begin
                  Result := 1;//������
                  Exit;
                end;

                if IsAllowUseMagic(37) then begin
                  Result := 37; //Ӣ��Ⱥ���׵�
                  Exit;
                end;
                if IsAllowUseMagic(47) then begin
                  Result := 47;//������
                  Exit;
                end;
              end;
            1: begin
                if IsAllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
                if IsAllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;

                if IsAllowUseMagic(58) and (GetTickCount - m_SkillUseTick[58] > 4000{1000 * 4}) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58] := GetTickCount;
                  Result := 58; //���ǻ���
                  Exit;
                end else
                if IsAllowUseMagic(33) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin//������,�����,������,���ѻ���,������  �Ӹߵ���ѡ��
                  Result := 33;//������ 
                  Exit;
                end else
                if IsAllowUseMagic(23) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1)  then begin
                  Result := 23; //���ѻ���
                  Exit;
                end else
                if IsAllowUseMagic(11) then begin
                  Result := 11; //Ӣ���׵���
                  Exit;
                end else
                if IsAllowUseMagic(5) and (m_nLoyal < 500) then begin
                  Result := 5;//�����
                  Exit;
                end else
                if IsAllowUseMagic(1) and (m_nLoyal < 500) then begin
                  Result := 1;//������
                  Exit;
                end;
              end;
            2:begin
                if IsAllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;
                
                if IsAllowUseMagic(58) and (GetTickCount - m_SkillUseTick[58] > 4000{1000 * 4}) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin
                  m_SkillUseTick[58]:= GetTickCount();
                  Result := 58; //���ǻ���
                  Exit;
                end else
                if IsAllowUseMagic(33) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin  //������,�����,������,���ѻ��� �Ӹߵ���ѡ��
                  Result := 33;
                  Exit;
                end else
                if IsAllowUseMagic(23) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1) then begin
                  Result := 23; //���ѻ���
                  Exit;
                end else
                if IsAllowUseMagic(11) then begin
                  Result := 11; //Ӣ���׵���
                  Exit;
                end else
                if IsAllowUseMagic(5) and (m_nLoyal < 500) then begin
                  Result := 5;//�����
                  Exit;
                end else
                if IsAllowUseMagic(1) and (m_nLoyal < 500) then begin
                  Result := 1;//������
                  Exit;
                end;

                if IsAllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
              end;
          end;
        end else begin
         //ֻ��һ����ʱ���õ�ħ��
         // if CheckTargetXYCountOfDirection(m_nTargetX, m_nTargetY, m_btDirection, 3) = 1 then begin
            if IsAllowUseMagic(22) and (GetTickCount - m_SkillUseTick[22] > 10000{10 * 1000}) and (g_EventManager.GetRangeEvent(m_PEnvir, Self, m_nCurrX, m_nCurrY, 6, ET_FIRE) = 0) then begin
              if (m_TargetCret.m_btRaceServer <> 101) and (m_TargetCret.m_btRaceServer <> 102) and (m_TargetCret.m_btRaceServer <> 104) then begin//�������,�ŷŻ�ǽ 20081217
                m_SkillUseTick[22] := GetTickCount;
                Result := 22;
                Exit;
              end;  
            end;
           case Random(3) of //���ѡ��ħ��
             0:begin
                if IsAllowUseMagic(11) then begin
                  Result := 11;//�׵���
                  Exit;
                end else
                if IsAllowUseMagic(33) then begin
                  Result := 33;
                  Exit;
                end else
                if IsAllowUseMagic(23) then begin //������,�����,������,���ѻ��� �Ӹߵ���ѡ��
                  Result := 23; //���ѻ���
                  Exit;
                end else
                if IsAllowUseMagic(5) and (m_nLoyal < 500) then begin
                  Result := 5;//�����
                  Exit;
                end else
                if IsAllowUseMagic(1) and (m_nLoyal < 500) then begin
                  Result := 1;//������
                  Exit;
                end;
                if IsAllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
                if IsAllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;
             end;
             1:begin
                if IsAllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
                if IsAllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;
                
               if IsAllowUseMagic(11) then begin
                 Result := 11;//�׵���
                 Exit;
                end else
                if IsAllowUseMagic(33) then begin
                  Result := 33;
                  Exit;
                end else
                if IsAllowUseMagic(23) then begin
                  Result := 23; //���ѻ���
                  Exit;
                end else
                if IsAllowUseMagic(5) and (m_nLoyal < 500) then begin
                  Result := 5;//�����
                  Exit;
                end else
                if IsAllowUseMagic(1) and (m_nLoyal < 500) then begin
                  Result := 1;//������
                  Exit;
                end;
             end;
             2:begin
                if IsAllowUseMagic(47) then begin
                  Result := 47;
                  Exit;
                end;

                if IsAllowUseMagic(11) then begin
                  Result := 11;//�׵���
                  Exit;
                end else
                if IsAllowUseMagic(33) then begin
                  Result := 33;
                  Exit;
                end else                
                if IsAllowUseMagic(23) then begin
                  Result := 23; //���ѻ���
                  Exit;
                end else
                if IsAllowUseMagic(5) and (m_nLoyal < 500) then begin
                  Result := 5;//�����
                  Exit;
                end else
                if IsAllowUseMagic(1) and (m_nLoyal < 500) then begin
                  Result := 1;//������
                  Exit;
                end;
                
                if IsAllowUseMagic(37) then begin
                  Result := 37;
                  Exit;
                end;
             end;
           //end;
           end;
        end;
      //�Ӹߵ���ʹ��ħ�� 20080710
        if IsAllowUseMagic(58) and (GetTickCount - m_SkillUseTick[58] > 4000{1000 * 4}) then begin//���ǻ���
          m_SkillUseTick[58]:= GetTickCount;
          Result := 58;
          Exit;
        end;
        if IsAllowUseMagic(47) then begin//������
          Result := 47;
          Exit;
        end;
        if IsAllowUseMagic(45) then begin//Ӣ�������
          Result := 45;
          Exit;
        end;
        if IsAllowUseMagic(37) then begin//Ӣ��Ⱥ���׵�
          Result := 37;
          Exit;
        end;
        if IsAllowUseMagic(33) then begin//Ӣ�۱�����
          Result := 33;
          Exit;
        end;
        if IsAllowUseMagic(32) and (m_TargetCret.m_Abil.Level < g_Config.nMagTurnUndeadLevel) and
        (m_TargetCret.m_btLifeAttrib = LA_UNDEAD) and (m_TargetCret.m_WAbil.Level < m_WAbil.Level -1) then begin //Ŀ��Ϊ����ϵ
          Result := 32; //ʥ���� 20080710
          Exit;
        end;
        if IsAllowUseMagic(24) and (CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 2) then begin//�����׹�
          Result := 24;
          Exit;
        end;
        if IsAllowUseMagic(23) then begin//���ѻ���
          Result := 23;
          Exit;
        end;
        if IsAllowUseMagic(11) then begin//Ӣ���׵���
          Result := 11;
          Exit;
        end;
        if IsAllowUseMagic(10) and m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY) and
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)))) then begin
          Result := 10;//Ӣ�ۼ����Ӱ
          Exit;
        end;
        if IsAllowUseMagic(9) and m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY) and
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
          (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
          ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4) and (Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4)))) then begin
          Result := 9;//������
          Exit;
        end;
        if IsAllowUseMagic(5) then begin
          Result := 5;//�����
          Exit;
        end;
        if IsAllowUseMagic(1) then begin
          Result := 1;//������
          Exit;
        end;
        if IsAllowUseMagic(22) and (g_EventManager.GetRangeEvent(m_PEnvir, Self, m_nCurrX, m_nCurrY, 6, ET_FIRE) <> 0) then begin
          if (m_TargetCret.m_btRaceServer <> 101) and (m_TargetCret.m_btRaceServer <> 102) and (m_TargetCret.m_btRaceServer <> 104) then begin//�������,�ŷŻ�ǽ 20081217
            Result := 22; //��ǽ
            Exit;
          end;
        end;
      end;
    2: begin //��ʿ
        //Ӣ��HPֵ���ڻ�����60%ʱ,ʹ�������� 20080204 �޸�
        if (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.7)) then begin //ʹ��������
          if IsAllowUseMagic(2) and (GetTickCount - m_SkillUseTick[2] > 3000{1000 * 3}) then begin {ʹ��������}
            m_SkillUseTick[2] := GetTickCount;  //20071226
            Result := 2;
            Exit;
          end;
        end;
        //����HPֵ���ڻ�����60%ʱ,ʹ��Ⱥ�������� 20080204 �޸�
        if (m_Master.m_WAbil.HP <= Round(m_Master.m_WAbil.MaxHP * 0.7)) then begin
          if CheckMasterXYOfDirection(m_Master,m_nTargetX, m_nTargetY, m_btDirection, 3)>=1 then begin //�ж�������Ӣ�۵ľ���
            if IsAllowUseMagic(29) and (GetTickCount - m_SkillUseTick[29] > 3000{1000 * 3}) then begin {ʹ��Ⱥ��������}
              m_SkillUseTick[29] := GetTickCount; //20071226
              Result := 29;
            end else
            if IsAllowUseMagic(2) and (GetTickCount - m_SkillUseTick[2] > 3000{1000 * 3}) then begin {ʹ��������}
              m_SkillUseTick[2] := GetTickCount;
              Result := 2;
            end;
          end else begin
            if IsAllowUseMagic(2) and (GetTickCount - m_SkillUseTick[2] > 3000{1000 * 3}) then begin {ʹ��������}
              m_SkillUseTick[2] := GetTickCount;  //20071226
              Result := 2;
            end;
          end;
          if Result > 0 then  Exit;
        end;
        if (m_SlaveList.Count = 0) and CheckHeroAmulet(1,5) and (GetTickCount - m_SkillUseTick[17] > 1000 * 3) and
        (IsAllowUseMagic(72) or IsAllowUseMagic(30) or IsAllowUseMagic(17)) and (m_WAbil.MP > 20) then begin
           m_SkillUseTick[17]:= GetTickCount;
           //Ĭ��,�Ӹߵ���
            if IsAllowUseMagic(72) then Result := 72//�ٻ�����
            else if IsAllowUseMagic(30) then Result := 30//�ٻ�����
            else if IsAllowUseMagic(17) then Result := 17;//�ٻ�����
            Exit;
        end;

        if IsAllowUseMagic(75) and (m_wStatusTimeArr[STATE_ProtectionDEFENCE] = 0) and (not m_boProtectionDefence) and (m_ExpHitter <> nil) and//20081214 �ܹ���ʱ�ſ���
          (GetTickCount - m_boProtectionTick > g_Config.dwProtectionTick) and
          (GetTickCount - m_SkillUseTick[75] > 3000) then begin {ʹ�� ������� 20080107}
          m_SkillUseTick[75]:= GetTickCount;//20080228
          Result := 75;
          Exit;
        end;

        if (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0) and (not m_boAbilMagBubbleDefence) then begin
          if IsAllowUseMagic(73) then begin//������ 20080909
            Result := 73;
            Exit;
          end;
        end;
        
        //�������� 20080925
        if IsAllowUseMagic(68) and (m_WAbil.MP > 30) and (GetTickCount - m_SkillUseTick[68] > 3000) then begin
          if (m_Abil.WineDrinkValue >= Round(m_Abil.MaxAlcohol * g_Config.nMinDrinkValue68 div 100)) then begin
            if (GetTickCount - m_dwStatusArrTimeOutTick[4] > g_Config.nHPUpTick * 1000) and (m_wStatusArrValue[4] = 0) then begin
              m_SkillUseTick[68]:= GetTickCount;
              Result := 68;
              Exit;
            end;
          end;
        end;
        if CheckHeroAmulet(1,1) and (m_wStatusTimeArr[STATE_TRANSPARENT]= 0) then begin//�������Χʱ,����������,PKʱ���� 20081223
          if (CheckTargetXYCount(m_nCurrX, m_nCurrY, 2) > 2) and (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT)
            and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin
            if IsAllowUseMagic(19) and (GetTickCount - m_SkillUseTick[19] > 8000) then begin//Ӣ��Ⱥ�������� 20081214
              m_SkillUseTick[19]:= GetTickCount;
              Result := 19;
              Exit;
            end else
            if IsAllowUseMagic(18) and (GetTickCount - m_SkillUseTick[18] > 8000) then begin//Ӣ�������� 20081214
              m_SkillUseTick[18]:= GetTickCount;
              Result := 18;
              Exit;
            end;
          end;
        end;
     // if (m_TargetCret <> nil) and m_boIsUseAttackMagic and CheckHeroAmulet(1,1) then begin//20080401�޸��жϷ��ķ���
        {if IsAllowUseMagic(15) and (m_Master.m_wStatusTimeArr[STATE_DEFENCEUP] = 0) then begin //�����˴�ħ��
           m_TargetCret := m_Master;
           Result := 15;
           Exit;
        end;}
      {if IsAllowUseMagic(15) and (m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and //20080710 ע��
        (GetTickCount - m_SkillUseTick[15] > 1000 * 3)  then begin // ʹ����ʥս����
          m_SkillUseTick[15] := GetTickCount;
          m_TargetCret := self;
          Result := 15;
          Exit;
        end; }
        //20080427 Ӣ�۸��Լ��ı����ӷ�
       (* if IsAllowUseMagic(15) and (m_SlaveList.Count > 0) and (GetTickCount - m_SkillUseTick[15] >3000{1000 * 3}) and CheckHeroAmulet(1,1) then begin
          m_SkillUseTick[15] := GetTickCount;
          for I := 0 to m_SlaveList.Count - 1 do begin
            Slave := TBaseObject(m_SlaveList.Items[I]);
            if (Slave <> nil) and (Slave.m_wStatusTimeArr[STATE_DEFENCEUP] = 0) then begin
               m_TargetCret := Slave;
               Result := 15;
               Exit;
            end;
          end;
        end;  *)
        {if IsAllowUseMagic(14) and (m_Master.m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) then begin //�����˴��
           m_TargetCret := m_Master;
           Result := 14;
           Exit;
        end; }
       (* if IsAllowUseMagic(14) and (m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and//����� 20080710 ע��
            (GetTickCount - m_SkillUseTick[14] > 3000{1000 * 3})  then begin
            m_SkillUseTick[14] := GetTickCount;
            m_TargetCret := self;
            Result := 14;
            Exit;
        end; *)
     // end;

      if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil))
       and (CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) > 0) and (m_TargetCret.m_WAbil.Level <= m_WAbil.Level) then begin //PKʱ,�Ա���������,ʹ��������
        if IsAllowUseMagic(48) and ((GetTickCount - m_SkillUseTick[48]) > 3000{3 * 1000}) then begin
          m_SkillUseTick[48] := GetTickCount;
          Result := 48;
          Exit;
        end
      end else begin //���,�ּ������Լ�,�����йְ�Χ�Լ����� ������
        if IsAllowUseMagic(48) and ((GetTickCount - m_SkillUseTick[48]) > 3000{3 * 1000})
          and (CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) > 0)
          and (m_TargetCret.m_WAbil.Level <= m_WAbil.Level)  then begin
           m_SkillUseTick[48] := GetTickCount;
           Result := 48;
           Exit;
        end;
      end;

  (* //PK ʱ,���޼���˫��,���ʱ����˫�����޼� 20080711
    if ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_Master <> nil)) then begin//PK
       //�޼����� 20080323
       if IsAllowUseMagic(50) and (GetTickCount - m_SkillUseTick[50] > g_Config.nAbilityUpTick * 1000) and (m_wStatusArrValue[2]=0)
         and ((g_Config.btHeroSkillMode50) or (m_TargetCret.m_Abil.HP >=800) or ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)))then begin//20080827
          m_SkillUseTick[50] := GetTickCount;
          Result := 50;
          Exit;
        end;
      if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and (GetUserItemList(2,1)>= 0) //�̶�
       and ((g_Config.btHeroSkillMode) or (m_TargetCret.m_Abil.HP >=800) or ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) or m_boTarget)
       and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) < 7{4}) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 7{4})) then begin //����Ѫ������800�Ĺ���  �޸ľ��� 20080704
       n_AmuletIndx:= 0;//20080413
       case Random(2) of
         0: begin
              if IsAllowUseMagic(38) and (GetTickCount - m_SkillUseTick[38] > 1000) then  begin
                m_SkillUseTick[38] := GetTickCount;
                Result := 38;//Ӣ��Ⱥ��ʩ��
                exit;
              end else
              if IsAllowUseMagic(6) and (GetTickCount - m_SkillUseTick[6] >  1000) then  begin
                m_SkillUseTick[6] := GetTickCount;
                Result := 6;//Ӣ��ʩ����
                exit;
              end;
            end;
         1: begin
             if IsAllowUseMagic(6) and (GetTickCount - m_SkillUseTick[6] >  1000) then  begin
               m_SkillUseTick[6] := GetTickCount;
               Result := 6;//Ӣ��ʩ����
               exit;
             end;
            end;
          end;
      end;
      if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and (GetUserItemList(2,2)>= 0) //�춾
       and ((g_Config.btHeroSkillMode) or (m_TargetCret.m_Abil.HP >= 800) or ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) or m_boTarget)
       and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) < 7{4}) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 7{4}))then begin //����Ѫ������100�Ĺ���
       n_AmuletIndx:= 0;//20080413
       case Random(2) of
         0: begin
              if IsAllowUseMagic(38) and (GetTickCount - m_SkillUseTick[38] >  1000) then  begin
                m_SkillUseTick[38] := GetTickCount;
                Result := 38;//Ӣ��Ⱥ��ʩ��
                exit;
              end else
              if IsAllowUseMagic(6) and (GetTickCount - m_SkillUseTick[6] >  1000) then  begin
                m_SkillUseTick[6] := GetTickCount;
                Result := 6;//Ӣ��ʩ����
                exit;
              end;
            end;
         1: begin
             if IsAllowUseMagic(6) and (GetTickCount - m_SkillUseTick[6] >  1000) then  begin
               m_SkillUseTick[6] := GetTickCount;
               Result := 6;//Ӣ��ʩ����
               exit;
             end;
            end;
          end;
      end;
    end else begin   *)
      if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and (GetUserItemList(2,1)>= 0) //�̶�
        and ((g_Config.btHeroSkillMode) or (m_TargetCret.m_Abil.HP >=800) or ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) or m_boTarget)
        and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) < 7{4}) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 7{4}))
        and (m_TargetCret.m_btRaceServer <> 110) and (m_TargetCret.m_btRaceServer <> 111) and (m_TargetCret.m_btRaceServer <> 55) then begin //����Ѫ������800�Ĺ���  �޸ľ��� 20080704 ������ǽ
        n_AmuletIndx:= 0;//20080413
        case Random(2) of
         0: begin
              if IsAllowUseMagic(38) and (GetTickCount - m_SkillUseTick[38] > 1000) then  begin
                m_SkillUseTick[38] := GetTickCount;
                Result := 38;//Ӣ��Ⱥ��ʩ��
                exit;
              end else
              if IsAllowUseMagic(6) and (GetTickCount - m_SkillUseTick[6] > 1000) then  begin
                m_SkillUseTick[6] := GetTickCount;
                Result := 6;//Ӣ��ʩ����
                exit;
              end;
            end;
         1: begin
              if IsAllowUseMagic(6) and (GetTickCount - m_SkillUseTick[6] > 1000) then  begin
                m_SkillUseTick[6] := GetTickCount;
                Result := 6;//Ӣ��ʩ����
                exit;
              end;
            end;
        end;
      end;
      if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and (GetUserItemList(2,2)>= 0) //�춾
        and ((g_Config.btHeroSkillMode) or (m_TargetCret.m_Abil.HP >= 800) or ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER)) or m_boTarget)
        and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) < 7{4}) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) < 7{4}))
        and (m_TargetCret.m_btRaceServer <> 110) and (m_TargetCret.m_btRaceServer <> 111) and (m_TargetCret.m_btRaceServer <> 55) then begin //����Ѫ������100�Ĺ��� ������ǽ
        n_AmuletIndx:= 0;//20080413
        case Random(2) of
         0: begin
              if IsAllowUseMagic(38) and (GetTickCount - m_SkillUseTick[38] > 1000) then  begin
                m_SkillUseTick[38] := GetTickCount;
                Result := 38;//Ӣ��Ⱥ��ʩ��
                exit;
              end else
              if IsAllowUseMagic(6) and (GetTickCount - m_SkillUseTick[6] > 1000) then  begin
                m_SkillUseTick[6] := GetTickCount;
                Result := 6;//Ӣ��ʩ����
                exit;
              end;
            end;
         1: begin
             if IsAllowUseMagic(6) and (GetTickCount - m_SkillUseTick[6] > 1000) then  begin
               m_SkillUseTick[6] := GetTickCount;
               Result := 6;//Ӣ��ʩ����
               exit;
             end;
            end;
        end;
      end;

      //�޼����� 20080323
      if IsAllowUseMagic(50) and (GetTickCount - m_SkillUseTick[50] > g_Config.nAbilityUpTick * 1000) and (m_wStatusArrValue[2]=0)
        and ((g_Config.btHeroSkillMode50) or (m_TargetCret.m_Abil.HP >=800) or ((m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) or (m_TargetCret.m_btRaceServer = RC_PLAYMOSTER))) then begin//20080827
        m_SkillUseTick[50] := GetTickCount;
        Result := 50;
        Exit;
      end;
    //end;
      if IsAllowUseMagic(51) and (GetTickCount - m_SkillUseTick[51] >  5*1000) then begin//Ӣ��쫷��� 20080917
        m_SkillUseTick[51] := GetTickCount;
        Result := 51;
        exit;
      end;
      if CheckHeroAmulet(1,1) then begin//ʹ�÷���ħ��
        case Random(3) of
          0:begin
            if IsAllowUseMagic(59) then begin
              Result := 59; //Ӣ����Ѫ��
              exit;
            end;
            if IsAllowUseMagic(13) and (GetTickCount - m_SkillUseTick[13] > 1000) then begin
              Result := 13; //Ӣ�������
              m_SkillUseTick[13]:= GetTickCount;//20080714
              exit;
            end;
            if IsAllowUseMagic(52) and (m_TargetCret.m_wStatusArrValue[m_TargetCret.m_btJob] = 0) then begin //������
              Result := 52; //Ӣ��������
              Exit;
            end;
          end;
          1:begin
            if IsAllowUseMagic(52) and (m_TargetCret.m_wStatusArrValue[m_TargetCret.m_btJob] = 0) then begin//������
              Result := 52;
              Exit;
            end;
            if IsAllowUseMagic(59) then begin
              Result := 59; //Ӣ����Ѫ��
              exit;
            end;
            if IsAllowUseMagic(13) and (GetTickCount - m_SkillUseTick[13] > 1000) then begin //20080401�޸��жϷ��ķ���
              Result := 13; //Ӣ�������
              m_SkillUseTick[13]:= GetTickCount;//20080714
              exit;
            end;
          end;//1
          2:begin
            if IsAllowUseMagic(13) and (GetTickCount - m_SkillUseTick[13] > 1000) then begin
              Result := 13; //Ӣ�������
              m_SkillUseTick[13]:= GetTickCount;//20080714
              exit;
            end;
            if IsAllowUseMagic(59) then begin
              Result := 59; //Ӣ����Ѫ��
              exit;
            end;
            if IsAllowUseMagic(52) and (m_TargetCret.m_wStatusArrValue[m_TargetCret.m_btJob] = 0) then begin //������
              Result := 52;
              Exit;
            end;
          end;//2
        end;//case Random(3) of ��
        //���ܴӸߵ���ѡ�� 20080710
        if IsAllowUseMagic(59) then begin//Ӣ����Ѫ��
          Result := 59;
          exit;
        end;
        if IsAllowUseMagic(54) then begin//Ӣ�������� 20080917
          Result := 54;
          exit;
        end;
        if IsAllowUseMagic(53) then begin//Ӣ��Ѫ�� 20080917
          Result := 53;
          exit;
        end;
        if IsAllowUseMagic(51) then begin//Ӣ��쫷��� 20080917
          Result := 51;
          exit;
        end;
        if IsAllowUseMagic(13) then begin//Ӣ�������
          Result := 13;
          exit;
        end;
        if IsAllowUseMagic(52) and (m_TargetCret.m_wStatusArrValue[m_TargetCret.m_btJob] = 0) then begin //������
          Result := 52;
          Exit;
        end;
      end;//if CheckHeroAmulet(1,1) then begin//ʹ�÷���ħ��

    end;//��ʿ
  end;//case ְҵ
end;
(* δʹ�� 20080412
function THeroObject.IsUseMagic(): Boolean; //����Ƿ����ʹ�ñ���ħ��  ��ʿ
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  Result := False;
  if m_nSelectMagic <= 0 then Exit;
  case m_btJob of
    2: begin
        for I := 0 to m_MagicList.Count - 1 do begin
          UserMagic := m_MagicList.Items[I];
          if UserMagic.MagicInfo.btJob in [2, 99] then begin
            case UserMagic.wMagIdx of
                SKILL_HEALLING {2},
                SKILL_HANGMAJINBUB {14},
                SKILL_DEJIWONHO {15},
                SKILL_HOLYSHIELD {16},
               //SKILL_SKELLETON {17},
                SKILL_CLOAK {18},
                SKILL_BIGCLOAK {19},
                SKILL_BIGHEALLING {29}: begin //��Ҫ��
                  Result := CheckUserItemType(1,1);
                  if Result then Break;
                  Result := GetUserItemList(1,1) > 0;
                  if Result then Break;
                end;
            end;
          end;
        end;
      end;
  end;
end;  *)
//20080530 ���Ӽ���������ļ��
function THeroObject.CheckActionStatus(wIdent: Word; var dwDelayTime: LongWord): Boolean;
var
  dwCheckTime: LongWord;
  dwActionIntervalTime: LongWord;
begin
  Result := False;
  dwDelayTime := 0;
  //��������ͬ����֮��������ʱ��
  dwCheckTime := GetTickCount - m_dwActionTick;
  case wIdent of//20080923 �ϻ�������
    60..65: begin
        m_dwActionTick := GetTickCount();
        Result := True;
        Exit;
      end;
  end;
  //SysMsg('���: ' + IntToStr(dwCheckTime), c_Blue, t_Notice);

  dwActionIntervalTime := {m_dwActionIntervalTime}530;
  
  if dwCheckTime >= dwActionIntervalTime then begin
    m_dwActionTick := GetTickCount();
    Result := True;
  end else begin
    dwDelayTime := dwActionIntervalTime - dwCheckTime;
  end;
  m_wOldIdent := wIdent;
  m_btOldDir := m_btDirection;
end;
{//ȡ������Ϣ����  20080720 ����
function THeroObject.GetSpellMsgCount: Integer;
var
  I: Integer;
  SendMessage: pTSendMessage;
begin
  Result := 0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    if m_MsgList.Count > 0 then begin
      for I := 0 to m_MsgList.Count - 1 do begin
        SendMessage := m_MsgList.Items[I];
        if (SendMessage.wIdent = RM_SPELL) then begin
          Inc(Result);
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;  }

//1 Ϊ����� 2 Ϊ��ҩ
function THeroObject.IsUseAttackMagic(): Boolean; //����Ƿ����ʹ�ù���ħ��
begin
  Result := False;
  if m_nSelectMagic <= 0 then Exit;
  case m_btJob of
    0, 1: Result := True;
    2: begin
        case m_nSelectMagic of
           SKILL_AMYOUNSUL {6 ʩ����},
           SKILL_GROUPAMYOUNSUL {38 Ⱥ��ʩ����}: begin
              Result := CheckHeroAmulet(2,1);
           end;
           SKILL_FIRECHARM {13},
           SKILL_HOLYSHIELD {16},
           SKILL_SKELLETON {17},
           SKILL_52,
           SKILL_59: begin //��Ҫ��
              Result := CheckHeroAmulet(1,1);
           end;
        end;//case
      end;//2
  end;
end;

function THeroObject.Think(): Boolean;
var
  nOldX, nOldY: Integer;
  UserMagicID: Integer;
  UserMagic: pTUserMagic;//20071224
  nCheckCode: Byte;
resourcestring
  sExceptionMsg = '{�쳣} THeroObject.Think Code:%d';
begin
  Result := False;
  nCheckCode:= 0;
  Try
    if m_Master = nil then Exit;
    if (m_Master.m_nCurrX = m_nCurrX) and (m_Master.m_nCurrY = m_nCurrY) then begin //20080710
      m_boDupMode := True;
    end else begin
      if (GetTickCount - m_dwThinkTick) > 1000 then begin
        m_dwThinkTick := GetTickCount();
        if m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY) >= 2 then m_boDupMode := True;
        nCheckCode:= 13;
        if (m_TargetCret <> nil) then begin
          if (not IsProperTarget(m_TargetCret)) then m_TargetCret := nil;
        end;
      end;
    end;
    nCheckCode:= 1;
    if m_boDupMode and (m_btStatus <> 2) and (GetTickCount()- dwTick3F4 > m_dwWalkIntervalTime) then begin //20080603 �����߼��
      dwTick3F4 := GetTickCount();//20080603 ����
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      WalkTo(Random(8), False);
      if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then begin
        m_boDupMode := False;
        Result := True;
      end;
    end;
    nCheckCode:= 2;
    if g_Config.boHeroAutoProtectionDefence then begin//Ӣ����Ŀ�����Զ������������ 20080715
      if IsAllowUseMagic(75) and (m_wStatusTimeArr[STATE_ProtectionDEFENCE] = 0) and (not m_boProtectionDefence) and
        (GetTickCount - m_boProtectionTick > g_Config.dwProtectionTick) and
        (GetTickCount - m_SkillUseTick[75] > 1000 * 3) then begin //ʹ�û������ 20080710
        m_SkillUseTick[75]:= GetTickCount;
        UserMagic := FindMagic(75);
        m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
        if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self);
      end;
    end;
  //20071224
     case m_btJob of
       0: begin//սʿ
         nCheckCode:= 20;
         if (m_btStatus =1) and (m_TargetCret <> nil) then begin//20080710 ����״̬����
           if CheckTargetXYCount(m_nCurrX, m_nCurrY, 3) > 1 then begin //�������Χʱʹ��ʨ�Ӻ�
             if IsAllowUseMagic(41) and (m_TargetCret.m_Abil.Level < m_Abil.Level) then begin
               UserMagic := FindMagic(41);
               if UserMagic <> nil then ClientSpellXY(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //ʹ��ħ��
             end;
           end else begin//Ұ��
             if IsAllowUseMagic(27) and (m_TargetCret.m_Abil.Level < m_Abil.Level) then begin
               UserMagic := FindMagic(27);
               if UserMagic <> nil then ClientSpellXY(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //ʹ��ħ��
             end;
           end;
           m_TargetCret:= nil;
         end;
       end;
      1: begin //��ʦ
          nCheckCode:= 21;
          if (m_btStatus =1) and (m_TargetCret <> nil) then begin//20080710 ����״̬����
            if IsAllowUseMagic(31) and (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0) and (not m_boAbilMagBubbleDefence) and boAutoOpenDefence then begin//20080930
              UserMagic := FindMagic(31);
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self); //ʹ��ħ����
            end;
            if IsAllowUseMagic(8) and (CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) > 0) and (m_TargetCret.m_WAbil.Level < m_WAbil.Level) then begin
              UserMagic := FindMagic(8);
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //ʹ�ÿ��ܻ�
            end;
            m_TargetCret:= nil;
          end;
          //����ģʽ,һֱ����ħ���� 20080711
          if (m_btStatus =0) and (IsAllowUseMagic(31) or IsAllowUseMagic(66)) and
             (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] = 0) and (not m_boAbilMagBubbleDefence)
              and boAutoOpenDefence then begin//20080930
            if IsAllowUseMagic(66) then begin
               UserMagic := FindMagic(66);
            end else
            if IsAllowUseMagic(31) then begin
               UserMagic := FindMagic(31);
            end;
            m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
            m_dwHitTick := GetTickCount();//20080719
            if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self);
          end;
        end;
      2: begin //��ʿ
          nCheckCode:= 28;
          if (m_nLoyal > 500) and (m_TargetCret <> nil) then begin//�ҳ϶ȳ���5%ʱ��PKʱ����ʹ����ʥս���� ����� 20080826
            if (m_TargetCret.m_btRaceServer <> RC_PLAYOBJECT) and (m_TargetCret.m_btRaceServer <> RC_HEROOBJECT) then begin
              if IsAllowUseMagic(15) and (m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and CheckHeroAmulet(1,1) then begin //��ħ��
                UserMagic := FindMagic(15);
                m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
                if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self); //��ʥս����
              end;
              nCheckCode:= 29;
              if IsAllowUseMagic(14) and (m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and CheckHeroAmulet(1,1) then begin //����ħ��
                UserMagic := FindMagic(14);
                m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
                if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self); //�����
              end;
              if IsAllowUseMagic(15) and (m_Master.m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and (GetTickCount - m_SkillUseTick[15] > 1000 * 3) and CheckHeroAmulet(1,1) then begin //�����˴�ħ��
                m_SkillUseTick[15] := GetTickCount;
                UserMagic := FindMagic(15);
                m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
                if UserMagic <> nil then ClientSpellXY(UserMagic, m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master); //ʹ��ħ��
              end;
              nCheckCode:= 26;
              if IsAllowUseMagic(14) and (m_Master.m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and (GetTickCount - m_SkillUseTick[14] > 3000{1000 * 3}) and CheckHeroAmulet(1,1) then begin //�����˴�ħ��
                m_SkillUseTick[14] := GetTickCount;
                UserMagic := FindMagic(14);
                m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
                if UserMagic <> nil then ClientSpellXY(UserMagic, m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master); //ʹ��ħ��
              end;
            end;
          end else begin
            if IsAllowUseMagic(15) and (m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and CheckHeroAmulet(1,1) then begin //��ħ��
              UserMagic := FindMagic(15);
              m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self); //��ʥս����
            end;
            nCheckCode:= 29;
            if IsAllowUseMagic(14) and (m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and CheckHeroAmulet(1,1) then begin //����ħ��
              UserMagic := FindMagic(14);
              m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self); //�����
            end;
            if IsAllowUseMagic(15) and (m_Master.m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and (GetTickCount - m_SkillUseTick[15] > 1000 * 3) and CheckHeroAmulet(1,1) then begin //�����˴�ħ��
              m_SkillUseTick[15] := GetTickCount;
              UserMagic := FindMagic(15);
              m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master); //ʹ��ħ��
            end;
            nCheckCode:= 26;
            if IsAllowUseMagic(14) and (m_Master.m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and (GetTickCount - m_SkillUseTick[14] > 3000{1000 * 3}) and CheckHeroAmulet(1,1) then begin //�����˴�ħ��
              m_SkillUseTick[14] := GetTickCount;
              UserMagic := FindMagic(14);
              m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master); //ʹ��ħ��
            end;
          end;
          nCheckCode:= 27;
          if (m_btStatus =1) and (m_TargetCret <> nil) then begin//20080710 ����״̬����
            if IsAllowUseMagic(48) and (CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) > 0) and (m_TargetCret.m_WAbil.Level < m_WAbil.Level)  then begin
              UserMagic := FindMagic(48);
              m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //ʹ��������
            end;
            m_TargetCret:= nil;
          end;
          if (m_btStatus <> 0) and (m_ExpHitter <> nil) then begin//20081223
            if CheckHeroAmulet(1,1) and (m_wStatusTimeArr[STATE_TRANSPARENT]= 0) then begin//������ 20081223
              if IsAllowUseMagic(19) and (GetTickCount - m_SkillUseTick[19] > 8000) then begin
                m_SkillUseTick[19]:= GetTickCount;
                UserMagic := FindMagic(19);
                m_boIsUseMagic := False;//�Ƿ��ܶ��
                if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self);
              end else
              if IsAllowUseMagic(18) and (GetTickCount - m_SkillUseTick[18] > 8000) then begin
                m_SkillUseTick[18]:= GetTickCount;
                UserMagic := FindMagic(18);
                m_boIsUseMagic := False;//�Ƿ��ܶ��
                if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self);
              end;
            end;
            m_ExpHitter:= nil;
          end;
          nCheckCode:= 22;
          //����HPֵ���ڻ�����60%ʱ,ʹ��������,�ȼ������ټ��Լ���Ѫ 20071201
          if (m_Master.m_WAbil.HP <= Round(m_Master.m_WAbil.MaxHP * 0.7)) and (m_WAbil.MP >10)
           and (GetTickCount - m_SkillUseTick[2] > 3000) and (m_TargetCret= nil) then begin
            if IsAllowUseMagic(29) then begin
              m_SkillUseTick[2] := GetTickCount;
              UserMagic := FindMagic(29);
              m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master); //ʹ��ħ��
            end else
            if IsAllowUseMagic(2) then begin
              m_SkillUseTick[2] := GetTickCount;
              UserMagic := FindMagic(2);
              m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master); //ʹ��ħ��
            end;
          end;
          nCheckCode:= 23;
          if (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.7)) and (m_WAbil.MP > 10)
           and (GetTickCount - m_SkillUseTick[2] > 3000) and (m_TargetCret= nil) then begin
            if IsAllowUseMagic(29) then begin
              m_SkillUseTick[2] := GetTickCount;
              UserMagic := FindMagic(29);
              m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, nil); //ʹ��ħ��
            end else
            if IsAllowUseMagic(2) then begin
              m_SkillUseTick[2] := GetTickCount;
              UserMagic := FindMagic(2);
              m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
              if UserMagic <> nil then ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, nil); //ʹ��ħ��
            end;
          end;
          nCheckCode:= 24;
          if (m_SlaveList.Count = 0) and g_Config.boHeroNoTargetCall and CheckHeroAmulet(1,5) and (GetTickCount - m_SkillUseTick[17] > 1000 * 3)  then begin// 20080615
            m_SkillUseTick[17]:=GetTickCount;
            //Ĭ��,�Ӹߵ���
            if IsAllowUseMagic(72) then UserMagicID:= 72//�ٻ�����
            else if IsAllowUseMagic(30) then UserMagicID:= 30//�ٻ�����
            else if IsAllowUseMagic(17) then UserMagicID:= 17;//�ٻ�����

            if UserMagicID > 0 then begin //20080401 �޸�Ӣ���ٻ�����
              UserMagic := FindMagic(UserMagicID);
              m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080719
              if UserMagic <> nil then  ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self); //ʹ��ħ��
            end; //if UserMagicID > 0 then
          end;//if (m_SlaveList.Count=0)  then begin
          nCheckCode:= 25;
          if ((GetTickCount - m_dwCheckNoHintTick) > 30000{30 * 1000}) and (not m_boIsUseAttackMagic) and (m_btStatus = 0) then begin//20080401 û������ʾ
            m_dwCheckNoHintTick:= GetTickCount;
            if IsAllowUseMagic(13) or IsAllowUseMagic(59) then begin
               if not CheckHeroAmulet(1,1) then SysMsg('(Ӣ��) ����������꣡', c_Green, t_Hint);
            end;
            if IsAllowUseMagic(6) or IsAllowUseMagic(38) then begin
               if not CheckHeroAmulet(2,1) then SysMsg('(Ӣ��) ��ɫ��ҩ�Ѿ��꣡', c_Green, t_Hint);
               if not CheckHeroAmulet(2,2) then SysMsg('(Ӣ��) ��ɫ��ҩ�Ѿ��꣡', c_Green, t_Hint);
            end;
          end;
       end;
     end;//case
     nCheckCode:= 3;
    //Ӣ���ҳ϶ȴﵽָ��ֵ������ؼ���(��������һ𽣷��������)��3�����Զ��л����ļ�״̬  20080111
    if m_nLoyal >=g_Config.nGotoLV4 then begin
      case m_btJob of
        0:begin
          UserMagic := FindMagic(26);
          if UserMagic <> nil then begin
            if UserMagic.btLevel=3 then begin
              UserMagic.btLevel:=4;//����Ϊ4������
              SendUpdateDelayMsg(m_Master, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 800);
              SysMsg('�����������ܵĹ�ϵ,����Ӣ���Ѿ�������4���һ𽣷�!' , BB_Fuchsia, t_Hint);
            end;
          end;
        end;
        1:begin
          UserMagic := FindMagic(45);
           if UserMagic <> nil then begin
            if UserMagic.btLevel=3 then begin
              UserMagic.btLevel:=4;//����Ϊ4������
              SendUpdateDelayMsg(m_Master, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 800);
              SysMsg('�����������ܵĹ�ϵ,����Ӣ���Ѿ�������4�������!' , BB_Fuchsia, t_Hint);
            end;
          end;
        end;
        2:begin
          UserMagic := FindMagic(13);
          if UserMagic <> nil then begin
            if UserMagic.btLevel=3 then begin
              UserMagic.btLevel:=4;//����Ϊ4������
              SendUpdateDelayMsg(m_Master, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 800);
              SysMsg('�����������ܵĹ�ϵ,����Ӣ���Ѿ�������4�������!' , BB_Fuchsia, t_Hint);
            end;
          end;
        end;
      end;
    end else begin //�ҳ϶ȵ��ڴ���ֵʱ,4����Ϊ3�� 20080609
      case m_btJob of
        0:begin
          UserMagic := FindMagic(26);
          if UserMagic <> nil then begin
            if UserMagic.btLevel=4 then begin
              UserMagic.btLevel:=3;//4����Ϊ3��
              SendUpdateDelayMsg(m_Master, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 800);
            end;
          end;
        end;
        1:begin
          UserMagic := FindMagic(45);
           if UserMagic <> nil then begin
            if UserMagic.btLevel=4 then begin
              UserMagic.btLevel:=3;//4����Ϊ3��
              SendUpdateDelayMsg(m_Master, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 800);
            end;
          end;
        end;
        2:begin
          UserMagic := FindMagic(13);
          if UserMagic <> nil then begin
            if UserMagic.btLevel=4 then begin
              UserMagic.btLevel:=3;//4����Ϊ3��
              SendUpdateDelayMsg(m_Master, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 800);
            end;
          end;
        end;
      end;
    end;

    nCheckCode:= 4;
    if SearchIsPickUpItem then SearchPickUpItem(500);//����Ʒ 20071224

    nCheckCode:= 5;
    if ((m_btStatus < 2) or ((m_btStatus = 2) and (not g_Config.boRestNoFollow))) and (not m_boProtectStatus) and //20080222 ����,���˻���ͼ,Ӣ������һ����
      (m_PEnvir <> m_Master.m_PEnvir) and //����ͬ����ͼʱ�ŷ� 20080409
      ((abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
      (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) then begin
      SpaceMove(m_Master.m_PEnvir.sMapName, m_Master.m_nCurrX, m_Master.m_nCurrY, 1);
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [nCheckCode]));
  end;
end;

function THeroObject.SearchIsPickUpItem(): Boolean;
var
  VisibleMapItem: pTVisibleMapItem;
  MapItem: PTMapItem;
  I: Integer;
  nCurrX, nCurrY: Integer;
  nCode: Byte;
begin
  Result := False;
  nCode:= 0;
  try
    if m_Master = nil then Exit;
    if (m_Master <> nil) and (m_Master.m_boDeath) then Exit;
    if m_btStatus = 2 then Exit;
    if m_TargetCret <> nil then Exit;
    if m_boProtectStatus then Exit;
    nCode:= 3;
    if m_VisibleItems.Count = 0 then Exit;
    nCode:= 4;
    if GetTickCount < m_dwSearchIsPickUpItemTime then Exit;
    if (not IsEnoughBag) {or (not m_boCanPickUpItem) }then Exit; //20080428 ע��
    if m_Master <> nil then begin
      nCurrX := m_Master.m_nCurrX;
      nCurrY := m_Master.m_nCurrY;
      if m_boProtectStatus then begin
        nCurrX := m_nProtectTargetX;
        nCurrY := m_nProtectTargetY;
      end;
      if (abs(nCurrX - m_nCurrX) > 15) or (abs(nCurrY - m_nCurrY) > 15) then begin
        //m_dwSearchIsPickUpItemTick := GetTickCount;
        m_dwSearchIsPickUpItemTime := GetTickCount + 5000{1000 * 5};
        Exit;
      end;
    end;
    {m_dwSearchIsPickUpItemTick := GetTickCount;
    m_dwSearchIsPickUpItemTime := 1000;}
    nCode:= 10;
    if m_VisibleItems.Count > 0 then begin
      for I := 0 to m_VisibleItems.Count - 1 do begin
        nCode:= 11;
        VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
        nCode:= 12;
        if (VisibleMapItem <> nil) then begin
          if (VisibleMapItem.nVisibleFlag > 0) then begin
            MapItem := VisibleMapItem.MapItem;
            nCode:= 13;
            if (MapItem <> nil) then begin
              if (m_Master <> nil) then begin//20080825 �޸�
                nCode:= 14;
                if MapItem.DropBaseObject <> nil then begin//20080803 ����
                  nCode:= 15;
                  if (MapItem.DropBaseObject <> m_Master) then begin
                    nCode:= 16;
                    if IsAllowPickUpItem(VisibleMapItem.sName) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(MapItem.UserItem.wIndex)) then begin
                        //if (MapItem.DropBaseObject <> nil) and (TBaseObject(MapItem.DropBaseObject).m_btRaceServer = RC_PLAYOBJECT) then Continue;
                      nCode:= 17;
                      if (MapItem.OfBaseObject = nil) or (MapItem.OfBaseObject = m_Master) or (MapItem.OfBaseObject = Self)  then begin
                        nCode:= 18;
                        if (abs(VisibleMapItem.nX - m_nCurrX) <= 5) and (abs(VisibleMapItem.nY - m_nCurrY) <= 5) then begin
                          Result := True;
                          Break;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} THeroObject.SearchIsPickUpItem Code:'+inttostr(nCode));
  end;
end;
//δʹ�õĺ���
function THeroObject.GotoTargetXYRange(): Boolean;
var
  n10: Integer;
  n14: Integer;
  nTargetX: Integer;
  nTargetY: Integer;
begin
  Result := True;
  nTargetX := 0;//20080529
  nTargetY := 0;//20080529
  n10 := abs(m_TargetCret.m_nCurrX - m_nCurrX);
  n14 := abs(m_TargetCret.m_nCurrY - m_nCurrY);
  if n10 > 4 then Dec(n10, 5) else n10 := 0;
  if n14 > 4 then Dec(n14, 5) else n14 := 0;
  if m_TargetCret.m_nCurrX > m_nCurrX then nTargetX := m_nCurrX + n10;
  if m_TargetCret.m_nCurrX < m_nCurrX then nTargetX := m_nCurrX - n10;
  if m_TargetCret.m_nCurrY > m_nCurrY then nTargetY := m_nCurrY + n14;
  if m_TargetCret.m_nCurrY < m_nCurrY then nTargetY := m_nCurrY - n14;
  Result := GotoTargetXY(nTargetX, nTargetY ,0);
end;

function THeroObject.AutoAvoid(): Boolean; //�Զ����
  function GetAvoidDir(): Integer;
  var
    n10: Integer;
    n14: Integer;
  begin
    n10 := m_TargetCret.m_nCurrX;
    n14 := m_TargetCret.m_nCurrY;
    Result := DR_DOWN;
    if n10 > m_nCurrX then begin
      Result := DR_LEFT;
      if n14 > m_nCurrY then Result := DR_DOWNLEFT;
      if n14 < m_nCurrY then Result := DR_UPLEFT;
    end else begin
      if n10 < m_nCurrX then begin
        Result := DR_RIGHT;
        if n14 > m_nCurrY then Result := DR_DOWNRIGHT;
        if n14 < m_nCurrY then Result := DR_UPRIGHT;
      end else begin
        if n14 > m_nCurrY then Result := DR_UP
        else if n14 < m_nCurrY then Result := DR_DOWN;
      end;
    end;
  end;

  function GetDirXY(nTargetX, nTargetY: Integer): Byte;
  var
    n10: Integer;
    n14: Integer;
  begin
    n10 := nTargetX;
    n14 := nTargetY;
    Result := DR_DOWN;//��
    if n10 > m_nCurrX then begin
      Result := DR_RIGHT;//��
      if n14 > m_nCurrY then Result := DR_DOWNRIGHT;//������
      if n14 < m_nCurrY then Result := DR_UPRIGHT;//������
    end else begin
      if n10 < m_nCurrX then begin
        Result := DR_LEFT;//��
        if n14 > m_nCurrY then Result := DR_DOWNLEFT;//������
        if n14 < m_nCurrY then Result := DR_UPLEFT;//������
      end else begin
        if n14 > m_nCurrY then Result := DR_DOWN//��
        else if n14 < m_nCurrY then Result := DR_UP;//����
      end;
    end;
  end;

  function GetGotoXY(nDir: Integer; var nTargetX, nTargetY: Integer): Boolean;
  var
    n01: Integer;
  begin
    Result := False;
    n01 := 0;
    while True do begin
      case nDir of
        DR_UP: begin//��
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin //CheckTargetXYCountOfDirection
              //Inc(nTargetY, 2);
              Dec(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then Break;
              //Inc(nTargetY, 2);
              Dec(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_UPRIGHT: begin//����
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
             // Inc(nTargetX, 2);
             // Inc(nTargetY, 2);
              Inc(nTargetX, 2);//20080524
              Dec(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then Break;
              //Inc(nTargetX, 2);
              //Inc(nTargetY, 2);
              Inc(nTargetX, 2);//20080524
              Dec(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end; 
        DR_RIGHT: begin//��
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              Inc(nTargetX, 2);
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then Break;
              Inc(nTargetX, 2);
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_DOWNRIGHT: begin//����
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              //Inc(nTargetX, 2);
              //Dec(nTargetY, 2);
              Inc(nTargetX, 2);//20080524
              Inc(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then Break;
              //Inc(nTargetX, 2);
              //Dec(nTargetY, 2);
              Inc(nTargetX, 2);//20080524
              Inc(nTargetY, 2);//20080524
              Inc(n01);
              Continue;
            end;
          end;
        DR_DOWN: begin//��
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              //Dec(nTargetY, 2);
              Inc(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then Break;
              //Dec(nTargetY, 2);
              Inc(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_DOWNLEFT: begin//����
            if m_PEnvir.CanWalk(nTargetX, nTargetY,False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              //Dec(nTargetX, 2);
              //Dec(nTargetY, 2);
              Dec(nTargetX, 2);//20080524
              Inc(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then Break;
              //Dec(nTargetX, 2);
              //Dec(nTargetY, 2);
              Dec(nTargetX, 2);//20080524
              Inc(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_LEFT: begin//��
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              Dec(nTargetX, 2);
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then Break;
              Dec(nTargetX, 2);
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_UPLEFT: begin//������
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
              //Dec(nTargetX, 2);
              //Inc(nTargetY, 2);
              Dec(nTargetX, 2);//20080524
              Dec(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then Break;
              //Dec(nTargetX, 2);
              //Inc(nTargetY, 2);
              Dec(nTargetX, 2);//20080524
              Dec(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
      else begin
          Break;
        end;
      end;
    end;

  end;

  function GetAvoidXY(var nTargetX, nTargetY: Integer): Boolean;
  var
    n10, nDir: Integer;
    nX, nY: Integer;
  begin
    nX := nTargetX;
    nY := nTargetY;
    Result := GetGotoXY(m_btLastDirection, nTargetX, nTargetY);
    n10 := 0;
    while True do begin
      if n10 >= 7 then Break;
      if Result then Break;
      nTargetX := nX;
      nTargetY := nY;
      nDir := Random(7);
      Result := GetGotoXY(nDir, nTargetX, nTargetY);
      Inc(n10);
    end;
    m_btLastDirection := nDir; //m_btDirection;
  end;
  function GotoMasterXY(var nTargetX, nTargetY: Integer): Boolean;
  var
    nDir: Integer;
  begin
    Result := False;
    if (m_Master <> nil) and ((abs(m_Master.m_nCurrX - m_nCurrX) >= 6) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 6)) and (not m_boProtectStatus) then begin
      nTargetX := m_nCurrX;
      nTargetY := m_nCurrY;
      //nTargetX := m_Master.m_nCurrX;//20080215
      //nTargetY := m_Master.m_nCurrY;//20080215
      nDir := GetDirXY(m_Master.m_nCurrX, m_Master.m_nCurrY);
      //m_btLastDirection := nDir;//20080402
      case nDir of
        DR_UP: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPRIGHT, nTargetX, nTargetY);
              m_btLastDirection := DR_UPRIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPLEFT, nTargetX, nTargetY);
              m_btLastDirection := DR_UPLEFT;
            end;
          end;
        DR_UPRIGHT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UP, nTargetX, nTargetY);
              m_btLastDirection := DR_UP;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_RIGHT, nTargetX, nTargetY);
              m_btLastDirection := DR_RIGHT;
            end;
          end;
        DR_RIGHT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPRIGHT, nTargetX, nTargetY);
              m_btLastDirection := DR_UPRIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNRIGHT, nTargetX, nTargetY);
              m_btLastDirection := DR_DOWNRIGHT;
            end;
          end;
        DR_DOWNRIGHT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_RIGHT, nTargetX, nTargetY);
              m_btLastDirection := DR_RIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWN, nTargetX, nTargetY);
              m_btLastDirection := DR_DOWN;
            end;
          end;
        DR_DOWN: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNRIGHT, nTargetX, nTargetY);
              m_btLastDirection := DR_DOWNRIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNLEFT, nTargetX, nTargetY);
              m_btLastDirection := DR_DOWNLEFT;
            end;
          end;
        DR_DOWNLEFT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWN, nTargetX, nTargetY);
              m_btLastDirection := DR_DOWN;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_LEFT, nTargetX, nTargetY);
              m_btLastDirection := DR_LEFT;
            end;
          end;
        DR_LEFT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNLEFT, nTargetX, nTargetY);
              m_btLastDirection := DR_DOWNLEFT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPLEFT, nTargetX, nTargetY);
              m_btLastDirection := DR_UPLEFT;
            end;
          end;
        DR_UPLEFT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_LEFT, nTargetX, nTargetY);
              m_btLastDirection := DR_LEFT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UP, nTargetX, nTargetY);
              m_btLastDirection := DR_UP;
            end;
          end;
      end;
    end;
  end;
var
  nTargetX: Integer;
  nTargetY: Integer;
  nDir: Integer;
begin
  Result := True;
  if (m_TargetCret <> nil) and not m_TargetCret.m_boDeath then begin
    //nDir := m_btLastDirection;
    if GotoMasterXY(nTargetX, nTargetY) then begin
       Result := GotoTargetXY(nTargetX, nTargetY, 1);
    end else begin
    { m_btLastDirection := GetAvoidDir(); //20080301
      nTargetX := m_nCurrX ;
      nTargetY := m_nCurrY ;
      if GetAvoidXY(nTargetX, nTargetY) then begin
        Result := GotoTargetXY(nTargetX, nTargetY);
      end;}
      nTargetX := m_nCurrX ;
      nTargetY := m_nCurrY ;
      nDir:= GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
      nDir:= GetBackDir(nDir);
      m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,nDir,5,m_nTargetX,m_nTargetY);
      Result :=GotoTargetXY(m_nTargetX, m_nTargetY, 1);
    end;
  //m_btLastDirection := m_btDirection;
  end;
end;
//Ӣ���Զ�����Ʒ
function THeroObject.SearchPickUpItem(nPickUpTime: Integer): Boolean;
  procedure SetHideItem(MapItem: PTMapItem);
  var
    VisibleMapItem: pTVisibleMapItem;
    I: Integer;
  begin
    for I := 0 to m_VisibleItems.Count - 1 do begin
      VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
      if (VisibleMapItem <> nil) and (VisibleMapItem.nVisibleFlag > 0) then begin
        if VisibleMapItem.MapItem = MapItem then begin
          VisibleMapItem.nVisibleFlag := 0;
          Break;
        end;
      end;
    end;
  end;

  function PickUpItem(nX, nY: Integer): Boolean;
  var
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    MapItem: PTMapItem;
  begin
    Result := False;
    MapItem := m_PEnvir.GetItem(nX, nY);
    if MapItem = nil then Exit;
    if CompareText(MapItem.Name, sSTRING_GOLDNAME) = 0 then begin
      if m_PEnvir.DeleteFromMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
        if (m_Master <> nil) and (not m_Master.m_boDeath) then begin //�񵽵�Ǯ�Ӹ�����
          if TPlayObject(m_Master).IncGold(MapItem.Count) then begin
            SendRefMsg(RM_ITEMHIDE, 0, Integer(MapItem), nX, nY, '');
            if g_boGameLogGold then
              AddGameDataLog('4' + #9 +
                m_sMapName + #9 +
                IntToStr(nX) + #9 +
                IntToStr(nY) + #9 +
                m_sCharName + #9 +
                sSTRING_GOLDNAME + #9 +
                IntToStr(MapItem.Count) + #9 +
                '1' + #9 +'0');
            Result := True;
            m_Master.GoldChanged;
            SetHideItem(MapItem);
            Dispose(MapItem);
          end else begin
            m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
          end;
        end else begin
          m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
        end;
      end else begin
        m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
      end;
    end else begin //����Ʒ
      StdItem := UserEngine.GetStdItem(MapItem.UserItem.wIndex);
      if StdItem <> nil then begin
        if m_PEnvir.DeleteFromMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
          New(UserItem);
          FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 ����
          //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 ����
          UserItem^ := MapItem.UserItem;
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if (StdItem <> nil) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex)) then begin
            if AddItemToBag(UserItem) then begin
              SendRefMsg(RM_ITEMHIDE, 0, Integer(MapItem), nX, nY, '');
              SendAddItem(UserItem);
              m_WAbil.Weight := RecalcBagWeight();
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('4' + #9 + m_sMapName + #9 +
                  IntToStr(nX) + #9 + IntToStr(nY) + #9 +
                  m_sCharName + #9 + StdItem.Name + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                  '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                  '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                  '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                  '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                  IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                  IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                  IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                  IntToStr(UserItem.btValue[14])+ #9 +IntToStr(UserItem.Dura)+'/'+IntToStr(UserItem.DuraMax));
              Result := True;
              SetHideItem(MapItem);
              Dispose(MapItem);
            end else begin
              Dispose(UserItem);
              m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
            end;
          end else begin
            Dispose(UserItem);
            m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
          end;
        end else begin
          Dispose(UserItem);
          m_PEnvir.AddToMap(nX, nY, OS_ITEMOBJECT, TObject(MapItem));
        end;
      end;
    end;
  end;

 { function IsOfGroup(BaseObject: TBaseObject): Boolean;
 // var
    //I: Integer;
    //GroupMember: TBaseObject;
  begin
    Result := False;
    if m_Master.m_GroupOwner = nil then Exit;
    for I := 0 to m_Master.m_GroupOwner.m_GroupMembers.Count - 1 do begin
      GroupMember := TBaseObject(m_Master.m_GroupOwner.m_GroupMembers.Objects[I]);
      if GroupMember = BaseObject then begin
        Result := True;
        Break;
      end;
    end;
  end; }
var
  MapItem: PTMapItem;
  VisibleMapItem: pTVisibleMapItem;
  SelVisibleMapItem: pTVisibleMapItem;
  I: Integer;
  boFound: Boolean;
  n01, n02: Integer;
  nCode: Byte;
begin
  Result := False;
  nCode:= 0;
  try
    if GetTickCount() - m_dwPickUpItemTick < nPickUpTime then Exit;
    m_dwPickUpItemTick := GetTickCount();
    boFound := False;
    nCode:= 1;
    if m_SelMapItem <> nil then begin
      nCode:= 2;
      for I := 0 to m_VisibleItems.Count - 1 do begin
        nCode:= 3;
        VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
        nCode:= 4;
        if (VisibleMapItem <> nil) and (VisibleMapItem.nVisibleFlag > 0) then begin
          if VisibleMapItem.MapItem = m_SelMapItem then begin
            nCode:= 5;
            boFound := True;
            Break;
          end;
        end;
      end;
    end;
    if not boFound then m_SelMapItem := nil;
    nCode:= 6;
    if m_SelMapItem <> nil then begin
      if PickUpItem(m_nCurrX, m_nCurrY) then begin
        Result := True;
        Exit;
      end;
    end;
    n01 := 999;
    nCode:= 7;
    SelVisibleMapItem := nil;
    boFound := False;
    if m_SelMapItem <> nil then begin
     nCode:= 8;
      for I := 0 to m_VisibleItems.Count - 1 do begin
       nCode:= 9;
        VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
        nCode:= 10;
        if (VisibleMapItem <> nil) and (VisibleMapItem.nVisibleFlag > 0) then begin
          nCode:= 11;
          if VisibleMapItem.MapItem = m_SelMapItem then begin
            SelVisibleMapItem := VisibleMapItem;
            boFound := True;
            Break;
          end;
        end;
      end;
    end;
    if not boFound then begin
      nCode:= 12;
      for I := 0 to m_VisibleItems.Count - 1 do begin
        nCode:= 13;
        VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
        nCode:= 14;
        if (VisibleMapItem <> nil) then begin
          if (VisibleMapItem.nVisibleFlag > 0) then begin
            MapItem := VisibleMapItem.MapItem;
            nCode:= 15;
            if (MapItem <> nil) then begin
              if (MapItem.DropBaseObject <> m_Master) then begin
                nCode:= 16;
                if IsAllowPickUpItem(VisibleMapItem.sName) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(MapItem.UserItem.wIndex)) then begin
                  //if (MapItem.DropBaseObject <> nil) and (TBaseObject(MapItem.DropBaseObject).m_btRaceServer = RC_PLAYOBJECT) then Continue;
                  nCode:= 17;
                  if (MapItem.OfBaseObject = nil) or (MapItem.OfBaseObject = m_Master) or (MapItem.OfBaseObject = Self) {or IsOfGroup(TBaseObject(MapItem.OfBaseObject))} then begin
                    nCode:= 18;
                    if (abs(VisibleMapItem.nX - m_nCurrX) <= 5) and (abs(VisibleMapItem.nY - m_nCurrY) <= 5) then begin
                      n02 := abs(VisibleMapItem.nX - m_nCurrX) + abs(VisibleMapItem.nY - m_nCurrY);
                      if n02 < n01 then begin
                        n01 := n02;
                        nCode:= 19;
                        SelVisibleMapItem := VisibleMapItem;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;//for
    end;
    nCode:= 20;
    if SelVisibleMapItem <> nil then begin
      nCode:= 21;
      m_SelMapItem := SelVisibleMapItem.MapItem;
      if (m_nCurrX <> SelVisibleMapItem.nX) or (m_nCurrY <> SelVisibleMapItem.nY) then begin
        nCode:= 22;
        WalkToTargetXY2(SelVisibleMapItem.nX, VisibleMapItem.nY);
        Result := True;
      end;
    end;
  except
    MainOutMessage('{�쳣} THeroObject.SearchPickUpItem Code:'+inttostr(nCode));
  end;
end;
(* 20080117
function THeroObject.IsPickUpItem(StdItem: pTStdItem): Boolean;
begin
  Result := True;
  {if StdItem.StdMode = 0 then begin
    if (StdItem.Shape in [0, 1, 2]) then Result := True;
  end else
    if StdItem.StdMode = 31 then begin
    if GetBindItemType(StdItem.Shape) >= 0 then Result := True;
  end else begin
    Result := False;
  end;}
end;    *)

function THeroObject.EatUseItems(nShape: Integer): Boolean;
begin
  Result := False;
  case nShape of
    4: begin
        if WeaptonMakeLuck() then Result := True;
      end;
    9: begin
        if RepairWeapon() then Result := True;
      end;
    10: begin
        if SuperRepairWeapon() then Result := True;
      end;
  end;
end;

function THeroObject.AutoEatUseItems(btItemType: Byte): Boolean; //�Զ���ҩ
  function FoundAddHealthItem(ItemType: Byte): Integer;
  var
    I: Integer;
    UserItem: pTUserItem;
    StdItem: pTStdItem;

    UserItem1: pTUserItem;
    StdItem1, StdItem2, StdItem3: pTStdItem;
    II, MinHP, j, nHP:Integer;
  begin
    Result := -1;
    if m_ItemList.Count > 0 then begin//20080628
      for I := 0 to m_ItemList.Count - 1 do begin
        UserItem := m_ItemList.Items[I];
        if UserItem <> nil then begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem <> nil then begin
            case ItemType of
              0: begin //��ҩ
                  if (StdItem.StdMode = 0) and (StdItem.Shape = 0) and (StdItem.AC > 0) then begin
                    Result := I;
                    Break;
                  end;
                end;
              1: begin //��ҩ
                  if (StdItem.StdMode = 0) and (StdItem.Shape = 0) and (StdItem.MAC > 0) then begin
                    Result := I;
                    Break;
                  end;
                end;
              2: begin //̫��ˮ(��������ҩƷ,�Ա�HP,ѡ���ʺϵ�ҩƷ)
                  {if (StdItem.StdMode = 0) and (StdItem.Shape = 1) and (StdItem.AC > 0) and (StdItem.MAC > 0) then begin
                    Result := I;
                    Break;
                  end;} //20080925 �޸�
                   if (StdItem.StdMode = 0) and (StdItem.Shape = 1) and (StdItem.AC > 0) and (StdItem.MAC > 0) then begin
                     MinHP:= StdItem.AC;
                     nHP:= m_WAbil.MaxHP - m_WAbil.HP;//ȡ��ǰѪ�Ĳ�ֵ
                     J:= I;
                     for II := 0 to m_ItemList.Count - 1 do begin//ѭ���ҳ�+HP���ʺϵ�������Ʒ
                       UserItem1 := m_ItemList.Items[II];
                       if UserItem1 <> nil then begin
                         StdItem1 := UserEngine.GetStdItem(UserItem1.wIndex);
                         if StdItem1 <> nil then begin
                            if (StdItem1.StdMode = 0) and (StdItem1.Shape = 1) and (StdItem1.AC > 0) and (StdItem1.MAC > 0) then begin
                              if abs(StdItem1.AC - nHP) < abs(MinHP - nHP) then begin//20080926
                                MinHP:= StdItem1.AC;
                                J:= II;
                              end;
                            end;
                         end;
                       end;
                     end;
                     for II := 0 to m_ItemList.Count - 1 do begin
                       UserItem1 := m_ItemList.Items[II];
                       if UserItem1 <> nil then begin
                         StdItem1 := UserEngine.GetStdItem(UserItem1.wIndex);
                         if StdItem1 <> nil then begin
                           if (StdItem1.StdMode = 31) and (GetBindItemType(StdItem1.Shape) = 2) and (m_ItemList.Count + 6 < m_nItemBagCount) then begin
                             StdItem3 := UserEngine.GetStdItem(GetBindItemName(StdItem1.Shape));//���Խ��������Ʒ��
                             if StdItem3 <> nil then begin
                               if (StdItem3.StdMode = 0) and (StdItem3.Shape = 1) and (StdItem3.AC > 0) and (StdItem3.MAC > 0) then begin
                                 if abs(StdItem3.AC - nHP) < abs(MinHP - nHP) then begin//20080926
                                   MinHP:= StdItem3.AC;
                                   J:= II;
                                 end;
                               end;
                             end;//if StdItem3 <> nil then begin 
                           end;
                         end;
                       end;
                     end;
                     Result := J;
                     Break;
                   end;
                end;
              3: begin //��ҩ��
                  if (StdItem.StdMode = 31) and (GetBindItemType(StdItem.Shape) = 0) and (m_ItemList.Count + 6 < m_nItemBagCount) then begin
                    Result := I;
                    Break;
                  end;
                end;
              4: begin //��ҩ��
                  if (StdItem.StdMode = 31) and (GetBindItemType(StdItem.Shape) = 1) and (m_ItemList.Count + 6 < m_nItemBagCount) then begin
                    Result := I;
                    Break;
                  end;
                end;
              5: begin//��ҩ�� 20080506
                  {if (StdItem.StdMode = 31) and (GetBindItemType(StdItem.Shape) = 2) and (m_ItemList.Count + 6 < m_nItemBagCount) then begin
                    Result := I;
                    Break;
                  end;}
                  //20080927 ���ܽ��
                  if (StdItem.StdMode = 31) and (GetBindItemType(StdItem.Shape) = 2) and (m_ItemList.Count + 6 < m_nItemBagCount) then begin
                    StdItem1 := UserEngine.GetStdItem(GetBindItemName(StdItem.Shape));//���Խ��������Ʒ��
                    if StdItem1 <> nil then begin
                       MinHP:= StdItem1.AC;
                       nHP:= m_WAbil.MaxHP - m_WAbil.HP;//ȡ��ǰѪ�Ĳ�ֵ
                       J:= I;
                       for II := 0 to m_ItemList.Count - 1 do begin//ѭ���ҳ�+HP���ʺϵ�������Ʒ
                         UserItem1 := m_ItemList.Items[II];
                         if UserItem1 <> nil then begin
                           StdItem2 := UserEngine.GetStdItem(UserItem1.wIndex);
                           if StdItem2 <> nil then begin
                              if (StdItem2.StdMode = 31) and (GetBindItemType(StdItem2.Shape) = 2) then begin
                                 StdItem3 := UserEngine.GetStdItem(GetBindItemName(StdItem2.Shape));//���Խ��������Ʒ��
                                 if StdItem3 <> nil then begin
                                   if (StdItem3.StdMode = 0) and (StdItem3.Shape = 1) and (StdItem3.AC > 0) and (StdItem3.MAC > 0) then begin
                                       if abs(StdItem3.AC - nHP) < abs(MinHP - nHP) then begin//20080926
                                         MinHP:= StdItem3.AC;
                                         J:= II;
                                       end;
                                   end;
                                 end;//if StdItem3 <> nil then begin
                              end;
                           end;
                         end;
                       end;
                    end;
                    Result := J;
                    Break;
                  end;
               end;
            end;
          end;
        end;
      end;
    end;
  end;
var
  nItemIdx: Integer;
  UserItem: pTUserItem;
begin
  Result := False;
  if not m_boDeath then begin
    nItemIdx := FoundAddHealthItem(btItemType);
    if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
      UserItem := pTUserItem(m_ItemList.Items[nItemIdx]);
      SendDelItems(UserItem);
      ClientHeroUseItems(UserItem.MakeIndex, UserEngine.GetStdItem(UserItem.wIndex).Name);
      Result := True;
    end else begin
      case btItemType of //���ҽ����Ʒ
        0: begin
            nItemIdx := FoundAddHealthItem(0);//���Һ�ҩ
            if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
              Result := True;
              UserItem := pTUserItem(m_ItemList.Items[nItemIdx]);
              SendDelItems(UserItem);
              ClientHeroUseItems(UserItem.MakeIndex, UserEngine.GetStdItem(UserItem.wIndex).Name);
            end else begin
              nItemIdx := FoundAddHealthItem(3);//���Һ�ҩ��
              if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
                Result := True;
                UserItem := pTUserItem(m_ItemList.Items[nItemIdx]);
                SendDelItems(UserItem);
                ClientHeroUseItems(UserItem.MakeIndex, UserEngine.GetStdItem(UserItem.wIndex).Name);
              end;
            end;
          end;
        1: begin
            nItemIdx := FoundAddHealthItem(1);//������ҩ
            if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
              Result := True;
              UserItem := pTUserItem(m_ItemList.Items[nItemIdx]);
              SendDelItems(UserItem);
              ClientHeroUseItems(UserItem.MakeIndex, UserEngine.GetStdItem(UserItem.wIndex).Name);
            end else begin
              nItemIdx := FoundAddHealthItem(4);//��ҩ��
              if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
                Result := True;
                UserItem := pTUserItem(m_ItemList.Items[nItemIdx]);
                SendDelItems(UserItem);
                ClientHeroUseItems(UserItem.MakeIndex, UserEngine.GetStdItem(UserItem.wIndex).Name);
              end;  
            end;
         end;
         2:begin
            nItemIdx := FoundAddHealthItem(2);//��������ҩƷ,�Ա�HP,ѡ���ʺϵ�ҩƷ
            if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
              Result := True;
              UserItem := pTUserItem(m_ItemList.Items[nItemIdx]);
              SendDelItems(UserItem);
              ClientHeroUseItems(UserItem.MakeIndex, UserEngine.GetStdItem(UserItem.wIndex).Name);
            end else begin
              nItemIdx := FoundAddHealthItem(5);//��ҩ��
              if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
                Result := True;
                UserItem := pTUserItem(m_ItemList.Items[nItemIdx]);
                SendDelItems(UserItem);
                ClientHeroUseItems(UserItem.MakeIndex, UserEngine.GetStdItem(UserItem.wIndex).Name);
              end;
            end;
         end;//2
      end;//case btItemType of //���ҽ����Ʒ
    end;
  end;
end;

function THeroObject.IsNeedGotoXY(): Boolean; //�Ƿ�����Ŀ��
var
  dwAttackTime: LongWord;
begin
  Result := False;
  if (m_TargetCret <> nil) and (GetTickCount - m_dwAutoAvoidTick > 1100) and ((not m_boIsUseAttackMagic) or (m_btJob = 0)) then begin
    if m_btJob > 0 then begin
      if (m_btStatus <> 2) and (not m_boIsUseMagic) and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > {2}3) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 3{2})) then begin//20081214�޸�
        Result := True;
        Exit;
      end;
      if (m_btStatus <> 2) and g_Config.boHeroAttackTarget and (m_Abil.Level < 22) then begin//20081218 ����22ǰ�Ƿ�������
        Result := True;
        Exit;      
      end;
    end else
    if (m_btStatus <> 2) then begin
      case m_nSelectMagic of //20080501  ����
        12:begin//��ɱ
           if IsAllowUseMagic(12) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, m_nTargetX, m_nTargetY)) then begin
            if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) then begin
              dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWarrorAttackTime) - m_nHitSpeed * g_Config.ClientConf.btItemSpeed); //��ֹ��������
              if (GetTickCount - m_dwHitTick > dwAttackTime) then begin
                 m_dwHitTick := GetTickCount();
                 m_wHitMode:= 4;//��ɱ
                 m_dwTargetFocusTick := GetTickCount();
                 m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                 Attack(m_TargetCret, m_btDirection);
                 BreakHolySeizeMode();
                 Exit;
              end;
             end else begin//new
                if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
            m_nSelectMagic:= 0;
            if IsAllowUseMagic(12) then begin
              if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
                Result := True;
                Exit;
              end;
            end else
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
              Result := True;
              Exit;
            end;
          end;
        74:begin//���ս���
           if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY) then begin
             if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
                (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4))) then begin
            //if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) < 5) or (abs(m_TargetCret.m_nCurrY - m_nCurrY)< 5)) then begin
              dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWarrorAttackTime) - m_nHitSpeed * g_Config.ClientConf.btItemSpeed); //��ֹ��������
              if (GetTickCount - m_dwHitTick > dwAttackTime) then begin
                 m_dwHitTick := GetTickCount();
                 m_wHitMode:= 13;
                 m_dwTargetFocusTick := GetTickCount();
                 m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                 Attack(m_TargetCret, m_btDirection);
                 BreakHolySeizeMode();
                 Exit;
              end;
              end else begin
                if IsAllowUseMagic(12) then begin
                  if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
                    Result := True;
                    Exit;
                  end;
                end else
                if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;
            m_nSelectMagic:= 0;
            if IsAllowUseMagic(12) then begin
              if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
                Result := True;
                Exit;
              end;
            end else
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
              Result := True;
              Exit;
            end;
          end;
        43:begin//20080604 ʵ�ָ�λ�ſ���
           if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY) and (m_n42kill = 2) then begin
             if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
                (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4))) then begin
                dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWarrorAttackTime) - m_nHitSpeed * g_Config.ClientConf.btItemSpeed); //��ֹ��������
                if (GetTickCount - m_dwHitTick > dwAttackTime) then begin
                  m_dwHitTick := GetTickCount();
                  m_wHitMode:= 9;
                  m_dwTargetFocusTick := GetTickCount();
                  m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                  Attack(m_TargetCret, m_btDirection);
                  BreakHolySeizeMode();
                  Exit;
                end;
             end else begin
               if IsAllowUseMagic(12) then begin
                 if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
                   Result := True;
                   Exit;
                 end;
               end else
               if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
                 Result := True;
                 Exit;
               end;
             end;
          end;
           m_nSelectMagic:= 0;
           if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, m_nTargetX, m_nTargetY) and (m_n42kill in [1,2]) then begin
            if (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0) or
               (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2) or
               (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2) then begin
            //if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 2)) and (m_n42kill in [1,2]) then begin
             dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWarrorAttackTime) - m_nHitSpeed * g_Config.ClientConf.btItemSpeed); //��ֹ��������
             if (GetTickCount - m_dwHitTick > dwAttackTime) then begin
               m_dwHitTick := GetTickCount();
               m_wHitMode:= 9;
               m_dwTargetFocusTick := GetTickCount();
               m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
               Attack(m_TargetCret, m_btDirection);
               BreakHolySeizeMode();
               Exit;
             end
             end else begin
                if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) then begin
                  Result := True;
                  Exit;
                end;
             end;
          end;
          m_nSelectMagic:= 0;
          if IsAllowUseMagic(12) then begin
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
              Result := True;
              Exit;
            end;
          end else
          if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
            Result := True;
            Exit;
          end;
        end;
        7, 25, 26:begin
          if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
            Result := True;
            m_nSelectMagic:= 0;
            Exit;
          end;        
        end else begin
          if IsAllowUseMagic(12) then begin
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
              Result := True;
              Exit;
            end;
          end else
          if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
            Result := True;
            Exit;
          end;
        end;
      end;//case m_nSelectMagic of
    end;
  end;
end;
//�Ƿ���Ҫ���
function THeroObject.IsNeedAvoid(): Boolean;
begin
  Result := False;
  if ((GetTickCount - m_dwAutoAvoidTick) > 1100) and m_boIsUseMagic then begin   //Ѫ����25%ʱ,�ض�Ҫ�� 20080711
    if (m_btJob > 0) and (m_btStatus <> 2) and ((m_nSelectMagic = 0) or (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.25))) then begin
      m_dwAutoAvoidTick := GetTickCount();
      case m_btJob of
        1:if CheckTargetXYCount(m_nCurrX, m_nCurrY, 4) > 0 then begin
            Result := True;
            Exit;
          end;
        2:if CheckTargetXYCount(m_nCurrX, m_nCurrY, 4{3}) > 0 then begin
            Result := True;
            Exit;
          end;
      end;
     { if CheckTargetXYCount(m_nCurrX, m_nCurrY, 3) > 0 then begin
        Result := True;
      end; }
    end;
    if (not Result) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.15)) then Result := True;//20080711
  end;
end;
//��ҩ
procedure THeroObject.EatMedicine();
  function FoundItem(ItemType: Byte): Boolean;
  var
    I: Integer;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
  begin
    Result := False;
    if m_ItemList.Count > 0 then begin
      for I := 0 to m_ItemList.Count - 1 do begin
        UserItem := m_ItemList.Items[I];
        if UserItem <> nil then begin
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem <> nil then begin
            case ItemType of
              0: begin //��ҩ
                  if (StdItem.StdMode = 0) and ((StdItem.Shape = 0) or (StdItem.Shape = 1)) and (StdItem.AC > 0) then begin
                    Result := True;
                    Break;
                  end;
                  if (StdItem.StdMode = 31) and ((GetBindItemType(StdItem.Shape) = 0) or (GetBindItemType(StdItem.Shape) = 2)) then begin
                    Result := True;
                    Break;
                  end;
                end;
              1: begin //��ҩ
                  if (StdItem.StdMode = 0) and ((StdItem.Shape = 0) or (StdItem.Shape = 1)) and (StdItem.MAC > 0) then begin
                    Result := True;
                    Break;
                  end;
                  if (StdItem.StdMode = 31) and ((GetBindItemType(StdItem.Shape) = 1) or (GetBindItemType(StdItem.Shape) = 2)) then begin
                    Result := True;
                    Break;
                  end;
                end;
            end;//case
          end;
        end;
      end;//for
    end;
  end;
var
  n01: Integer;
  boFound: Boolean;
  btItemType:Byte;
begin
  boFound := False;
  btItemType:= 0;
  if not m_PEnvir.m_boMISSION then begin //20080509 ��ͼû������ʹ����Ʒʱ,�����Զ���ҩ
    if (GetTickCount - m_dwEatItemTick) > g_Config.nHeroAddHPMPTick then begin//Ӣ�۳���ͨҩ��� 20080601
      m_dwEatItemTick := GetTickCount();
      if (m_nCopyHumanLevel > 0) then begin
        if m_WAbil.HP < (m_WAbil.MaxHP * g_Config.nHeroAddHPRate) div 100 then begin
          n01 := 0;
          while m_WAbil.HP < m_WAbil.MaxHP do begin {������������ƿ}
          if (n01 >= 1) then Break;//20080401 �ĳ�һ��һƿ
            btItemType:= 0;
            if AutoEatUseItems(btItemType) then boFound:= True;
            if m_ItemList.Count = 0 then Break;
            Inc(n01);
          end;
        end;

        if m_WAbil.MP < (m_WAbil.MaxMP * g_Config.nHeroAddMPRate) div 100 then begin
          n01 := 0;
          while m_WAbil.MP < m_WAbil.MaxMP do begin {������������ƿ}
            if (n01 >= 1) then Break;//20080401 �ĳ�һ��һƿ
            btItemType:= 1;
            if AutoEatUseItems(btItemType) then boFound:= True;
            if m_ItemList.Count = 0 then Break;
            Inc(n01);
          end;
        end;
      end;
    end;
    if (GetTickCount - m_dwEatItemTick1) > g_Config.nHeroAddHPMPTick1 then begin//Ӣ�۳�����ҩ��� 20080910
      m_dwEatItemTick1 := GetTickCount();
      if (m_nCopyHumanLevel > 0) and (m_ItemList.Count > 0) then begin
        if (m_WAbil.HP < (m_WAbil.MaxHP * g_Config.nHeroAddHPRate1) div 100) or
           (m_WAbil.MP < (m_WAbil.MaxMP * g_Config.nHeroAddMPRate1) div 100) then begin
           btItemType:= 2;
           if AutoEatUseItems(btItemType) then boFound:= True;
        end;
      end;
    end;
  end;
  if not boFound then begin
    if (GetTickCount - m_dwEatItemNoHintTick) > 30000{30 * 1000} then begin  //20080129
      m_dwEatItemNoHintTick := GetTickCount();
      case btItemType of
        0: begin
           if (m_WAbil.HP < (m_WAbil.MaxHP * g_Config.nHeroAddHPRate) div 100) or
              (m_WAbil.HP < (m_WAbil.MaxHP * g_Config.nHeroAddHPRate1) div 100) then begin
               if not FoundItem(btItemType) then SysMsg('(Ӣ��) ��ҩ�Ѿ����꣡����', BB_Fuchsia, t_Hint);
           end;
         end;
        1: begin
           if (m_WAbil.MP < (m_WAbil.MaxMP * g_Config.nHeroAddMPRate) div 100) or
              (m_WAbil.MP < (m_WAbil.MaxMP * g_Config.nHeroAddMPRate1) div 100) then begin
               if not FoundItem(btItemType) then SysMsg('(Ӣ��) ħ��ҩ�Ѿ����꣡����', BB_Fuchsia, t_Hint);
           end;
         end;
      end;
    end;
  end;
end;

{���ָ������ͷ�Χ������Ĺ�������}
function THeroObject.CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;
var
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := 0;
  if m_VisibleActors.Count > 0 then begin//20080630
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath then begin
          if IsProperTarget(BaseObject) and
            (not BaseObject.m_boHideMode or m_boCoolEye) then begin
            case nDir of
              DR_UP: begin
                  if (abs(nX - BaseObject.m_nCurrX) <= nRange) and ((BaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
                end;
              DR_UPRIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0..nRange]) and ((BaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
                end;
              DR_RIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0..nRange]) and (abs(nY - BaseObject.m_nCurrY) <= nRange) then Inc(Result);
                end;
              DR_DOWNRIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0..nRange]) and ((nY - BaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
                end;
              DR_DOWN: begin
                  if (abs(nX - BaseObject.m_nCurrX) <= nRange) and ((nY - BaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
                end;
              DR_DOWNLEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0..nRange]) and ((nY - BaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
                end;
              DR_LEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0..nRange]) and (abs(nY - BaseObject.m_nCurrY) <= nRange) then Inc(Result);
                end;
              DR_UPLEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0..nRange]) and ((BaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
                end;
            end;
            //if Result > 2 then break;
          end;
        end;
      end;
    end;
  end;
end;

//���ָ������ͷ�Χ��,Ŀ����Ӣ�۵ľ��� 20080426
function THeroObject.CheckMasterXYOfDirection(TargeTBaseObject: TBaseObject; nX, nY, nDir, nRange: Integer): Integer;
begin
  Result := 0;
  if TargeTBaseObject <> nil then begin
    if not TargeTBaseObject.m_boDeath then begin
        case nDir of
          DR_UP: begin
              if (abs(nX - TargeTBaseObject.m_nCurrX) <= nRange) and ((TargeTBaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
            end;
          DR_UPRIGHT: begin
              if ((TargeTBaseObject.m_nCurrX - nX) in [0..nRange]) and ((TargeTBaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
            end;
          DR_RIGHT: begin
              if ((TargeTBaseObject.m_nCurrX - nX) in [0..nRange]) and (abs(nY - TargeTBaseObject.m_nCurrY) <= nRange) then Inc(Result);
            end;
          DR_DOWNRIGHT: begin
              if ((TargeTBaseObject.m_nCurrX - nX) in [0..nRange]) and ((nY - TargeTBaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
            end;
          DR_DOWN: begin
              if (abs(nX - TargeTBaseObject.m_nCurrX) <= nRange) and ((nY - TargeTBaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
            end;
          DR_DOWNLEFT: begin
              if ((nX - TargeTBaseObject.m_nCurrX) in [0..nRange]) and ((nY - TargeTBaseObject.m_nCurrY) in [0..nRange]) then Inc(Result);
            end;
          DR_LEFT: begin
              if ((nX - TargeTBaseObject.m_nCurrX) in [0..nRange]) and (abs(nY - TargeTBaseObject.m_nCurrY) <= nRange) then Inc(Result);
            end;
          DR_UPLEFT: begin
              if ((nX - TargeTBaseObject.m_nCurrX) in [0..nRange]) and ((TargeTBaseObject.m_nCurrY - nY) in [0..nRange]) then Inc(Result);
            end;
        end;
    end;
  end;
end;

function THeroObject.WarrAttackTarget(wHitMode: Word): Boolean; {������}
var
  bt06, nCode: Byte;
  dwDelayTime: LongWord;
begin
  Result := False;
  nCode:= 0;
try
   nCode:= 1;
  if m_TargetCret <> nil then begin
     nCode:= 2;
    if GetAttackDir(m_TargetCret, bt06) then begin
      nCode:= 3;
      m_dwTargetFocusTick := GetTickCount();
      nCode:= 4;
      Attack(m_TargetCret, bt06);
      m_dwActionTick := GetTickCount();//20080720 ��,����
      nCode:= 5;
      BreakHolySeizeMode();
      Result := True;
    end else begin
      nCode:= 6;
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
          nCode:= 7;
         SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end else begin
        nCode:= 8;
       if not m_boTarget then DelTargetCreat();//20080424 ����������Ŀ��,����ɾ��Ŀ��
      end;
    end;
  end;
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} THeroObject.WarrAttackTarget Code:'+inttostr(nCode));
    end;
  end;
end;

function THeroObject.WarrorAttackTarget(): Boolean; {սʿ����}
var
  UserMagic: pTUserMagic;
begin
  Result := False;
  if m_btStatus <> 0 then begin
    if m_TargetCret <> nil then m_TargetCret:= nil;
    Exit;
  end;
  m_wHitMode := 0;
  if m_WAbil.MP > 0 then begin
    if (not m_boStartUseSpell) and ((m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.3)) or m_TargetCret.m_boCrazyMode) then begin //20080718 ע��,ս�����
      //m_boIsUseMagic := True;//�Ƿ��ܶ�� 20080715
      //Exit;
      if IsAllowUseMagic(12) then begin//Ѫ��ʱ��Ŀ����ģʽʱ������λ��ɱ 20080827
        GetGotoXY(m_TargetCret, 2);
        GotoTargetXY( m_nTargetX, m_nTargetY, 0);
      end;
    end;
    if not m_boStartUseSpell then SearchMagic(); //��ѯħ�� 20080328����
    if m_nSelectMagic > 0 then begin
      if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) or ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 5) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 5)) then begin//ħ�����ܴ򵽹� 20080420
         if (abs(m_Master.m_nCurrX - m_nCurrX) >= 7) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 7) then begin
           m_TargetCret:= nil;
           Exit;
         end;//else RunToTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);//20080720 ע��
      end; 
      UserMagic := FindMagic(m_nSelectMagic);
      if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//���ܴ�״̬����ʹ�� 20080606
        case m_nSelectMagic of
         27, 39, 41, 60..65, 68, 75: begin
              m_dwHitTick := GetTickCount();//20080530
              Result := ClientSpellXY(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //սʿħ��
              Exit;
            end;
           7: m_wHitMode := 3; //��ɱ
          12: m_wHitMode := 4; //ʹ�ô�ɱ
          25: m_wHitMode := 5; //ʹ�ð���
          26: m_wHitMode := 7; //ʹ���һ�
          40: m_wHitMode := 8; //���µ���
          43: m_wHitMode := 9; //����ն  20080203
          42: m_wHitMode := 12;//��Ӱ���� 20080203
          74: m_wHitMode := 13;//���ս��� 20080528
        end;
      end;
    end;
  end;
  if not m_boStartUseSpell then Result := WarrAttackTarget(m_wHitMode);//20081214
  if Result then m_dwHitTick := GetTickCount();//20080604 ��ʵ�ָ�λ��ʹ�ü���
end;

function THeroObject.WizardAttackTarget(): Boolean; {��ʦ����}
var
  UserMagic: pTUserMagic;
begin
  Result := False;
  if m_btStatus <> 0 then begin
    if m_TargetCret <> nil then m_TargetCret:= nil;
    Exit;
  end;
  m_wHitMode := 0;
  if not m_boStartUseSpell then begin
     SearchMagic(); //��ѯħ�� 20080328����
     if m_nSelectMagic = 0 then m_boIsUseMagic := True;//�Ƿ��ܶ�� 20080715
  end;
  if m_nSelectMagic > 0 then begin
    if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) or ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 7) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 7)) then begin//ħ�����ܴ򵽹� 20080420
       if (abs(m_Master.m_nCurrX - m_nCurrX) >= 7) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 7) then begin
         m_nSelectMagic := 0;//20080710
         m_TargetCret:= nil;
         Exit;
       end else begin
         if m_nSelectMagic <> 10 then begin//20080717 �������Ӱ��
           GetGotoXY(m_TargetCret,3);//20080712 ����ֻ����Ŀ��3��Χ
           GotoTargetXY( m_nTargetX, m_nTargetY,0);
         end;
       end;
    end;
    UserMagic := FindMagic(m_nSelectMagic);
    if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//���ܴ�״̬����ʹ�� 20080606
      m_dwHitTick := GetTickCount();//20080530
      Result := ClientSpellXY(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //ʹ��ħ��
      Exit;
    end;
  end;
  m_dwHitTick := GetTickCount();//20080530
  if g_Config.boHeroAttackTarget and (m_Abil.Level < 22) then begin//20081218 ��ʦ22��ǰ�Ƿ�������
    m_boIsUseMagic := False;//�Ƿ��ܶ��
    Result := WarrAttackTarget(m_wHitMode);
  end;
end;

function THeroObject.TaoistAttackTarget(): Boolean; {��ʿ���� 20071218}
var
  UserMagic: pTUserMagic;
  nIndex: Integer;
begin
  Result := False;
  if m_btStatus <> 0 then begin
    if m_TargetCret <> nil then m_TargetCret:= nil;
    Exit;
  end;
  m_wHitMode := 0;
  if not m_boStartUseSpell then begin
     SearchMagic(); //��ѯħ�� 20080328����
     if m_nSelectMagic = 0 then m_boIsUseMagic := True;//�Ƿ��ܶ�� 20080715
  end;
  if m_nSelectMagic > 0 then begin
    if (not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret)) or ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 7) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 7)) then begin//ħ�����ܴ򵽹� 20080420
      if (abs(m_Master.m_nCurrX - m_nCurrX) >= 7) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 7) then begin
        m_nSelectMagic := 0;//20080710
        m_TargetCret:= nil;
        Exit;
      end else begin
        GetGotoXY(m_TargetCret, 3);//20080712 ����ֻ����Ŀ��3��Χ
        GotoTargetXY( m_nTargetX, m_nTargetY,0);
        //GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end;

    case m_nSelectMagic of
       SKILL_HEALLING: begin //������ 20080426
          if (m_Master.m_WAbil.HP <= Round(m_Master.m_WAbil.MaxHP * 0.7)) then begin
             UserMagic := FindMagic(m_nSelectMagic);
             if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//���ܴ�״̬����ʹ�� 20080606
               {Result :=}ClientSpellXY(UserMagic, m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master);
               m_dwHitTick := GetTickCount();
               m_boIsUseMagic := True;//�ܶ�� 20080916
               Exit;
             end;
          end;
          if (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.7)) then begin
             UserMagic := FindMagic(m_nSelectMagic);
             if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//���ܴ�״̬����ʹ��
               {Result :=}ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, nil);
               m_dwHitTick := GetTickCount();
               m_boIsUseMagic := True;//�ܶ�� 20080916
               Exit;
             end;
          end;
        end;
      SKILL_BIGHEALLING: begin //Ⱥ��������  20080713
          if (m_Master.m_WAbil.HP <= Round(m_Master.m_WAbil.MaxHP * 0.7)) then begin
             UserMagic := FindMagic(m_nSelectMagic);
             if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//���ܴ�״̬����ʹ�� 20080715
               {Result :=}ClientSpellXY(UserMagic, m_Master.m_nCurrX, m_Master.m_nCurrY, m_Master);
               m_dwHitTick := GetTickCount();
               m_boIsUseMagic := True;//�ܶ�� 20080916
               Exit;
             end;
          end;
          if (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.7)) then begin
             UserMagic := FindMagic(m_nSelectMagic);
             if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//���ܴ�״̬����ʹ��
               {Result :=}ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self);
               m_dwHitTick := GetTickCount();
               m_boIsUseMagic := True;//�ܶ�� 20080916
               Exit;
             end;
          end;
        end;
      SKILL_FIRECHARM: begin//������,�򲻵�Ŀ��ʱ,�ƶ� 20080711
         if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) then begin
            GetGotoXY(m_TargetCret,3);
            GotoTargetXY(m_nTargetX, m_nTargetY,1);
         end;
       end;
      SKILL_AMYOUNSUL{6}, SKILL_GROUPAMYOUNSUL{38}: begin //����
          if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and (GetUserItemList(2,1)>= 0) then begin//�̶�
            n_AmuletIndx:= 1;//20080412  �̶���ʶ
          end else
          if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and (GetUserItemList(2,2)>= 0)  then  begin//�춾
            n_AmuletIndx:= 2;//20080412 �춾��ʶ
          end;
        end;
      SKILL_BIGCLOAK {19}: begin //����������
           UserMagic := FindMagic(m_nSelectMagic);
           if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//���ܴ�״̬����ʹ��
             ClientSpellXY(UserMagic, m_nCurrX, m_nCurrY, self);
             m_dwHitTick := GetTickCount();
             m_boIsUseMagic := False;//�ܶ�� 20080916
             Exit;
           end;
        end;
      SKILL_48,//������ʱ�������ж�� 20080828
      SKILL_SKELLETON,
      SKILL_SINSU,
      SKILL_50,
      SKILL_72,
      SKILL_73,
      SKILL_75: begin
          UserMagic := FindMagic(m_nSelectMagic);
          if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin
            {Result := }ClientSpellXY(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //ʹ��ħ��
            m_dwHitTick := GetTickCount();
            m_boIsUseMagic := True;//�ܶ��
            Exit;
          end;
        end;
    end;
    UserMagic := FindMagic(m_nSelectMagic);
    if (UserMagic <> nil) and (UserMagic.btKey = 0) then begin//���ܴ�״̬����ʹ�� 20080606
      Result := ClientSpellXY(UserMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, m_TargetCret); //ʹ��ħ��
      m_dwHitTick := GetTickCount();//20080530
      Exit;
    end;
  end;
  m_dwHitTick := GetTickCount();//20080530
  {if (m_WAbil.MP > 10) and (m_WAbil.Level < 20) then begin//20080803 19��ʹ�ÿ�  20081225 ע�� 
    Result := WarrAttackTarget(m_wHitMode);
    m_dwHitTick := GetTickCount();
    if Result then m_boIsUseMagic := False;
  end;}
  if (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.15)) then m_boIsUseMagic := True;//�Ƿ��ܶ�� 20080715
  if g_Config.boHeroAttackTarget and (m_Abil.Level < 22) then begin//20081218 ��ʿ22��ǰ�Ƿ�������
    m_boIsUseMagic := False;//�Ƿ��ܶ��
    Result := WarrAttackTarget(m_wHitMode);
  end;
end;

function THeroObject.CheckUserMagic(wMagIdx: Word): pTUserMagic;
var
  I: Integer;
begin
  Result := nil;
  if m_MagicList.Count > 0 then begin//20080630
    for I := 0 to m_MagicList.Count - 1 do begin
      if pTUserMagic(m_MagicList.Items[I]).MagicInfo.wMagicId = wMagIdx then begin
        Result := pTUserMagic(m_MagicList.Items[I]);
        Break;
      end;
    end;
  end;
end;

function THeroObject.CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
var
  BaseObject: TBaseObject;
  I, nC, n10: Integer;
begin
  Result := 0;
  n10 := nRange;
  if m_VisibleActors.Count > 0 then begin//20080630
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath then begin
          if IsProperTarget(BaseObject) and
            (not BaseObject.m_boHideMode or m_boCoolEye) then begin
            nC := abs(nX - BaseObject.m_nCurrX) + abs(nY - BaseObject.m_nCurrY);
            if nC <= n10 then begin
              Inc(Result);
              //if Result > 2 then break;
            end;
          end;
        end;
      end;
    end;
  end;
end;
//սʿ�ж�ʹ�� 20080924
function THeroObject.CheckTargetXYCount1(nX, nY, nRange: Integer): Integer;
var
  BaseObject: TBaseObject;
  I, n10: Integer;
begin
  Result := 0;
  n10 := nRange;
  if m_VisibleActors.Count > 0 then begin
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath then begin
          if IsProperTarget(BaseObject) and
            (not BaseObject.m_boHideMode or m_boCoolEye) then begin
            if (abs(nX - BaseObject.m_nCurrX) <= n10) and (abs(nY - BaseObject.m_nCurrY) <= n10) then begin
              Inc(Result);
            end;
          end;
        end;
      end;
    end;
  end;
end;
//�����䵶�ж�Ŀ�꺯�� 20081207
function THeroObject.CheckTargetXYCount2(): Integer;
var
  nC, n10, I: Integer;
  nX, nY: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  nC := 0;
  if m_VisibleActors.Count > 0 then begin
    for I := 0 to m_VisibleActors.Count - 1 do begin
      n10 := (m_btDirection + g_Config.WideAttack[nC]) mod 8;
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, n10, 1, nX, nY) then begin
        BaseObject := m_PEnvir.GetMovingObject(nX, nY, True);
        if BaseObject <> nil then begin
          if not BaseObject.m_boDeath then begin
            if IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then begin
              Inc(Result);
            end;
          end;
        end;
      end;
      Inc(nC);
      if nC >= 3 then Break;
    end;
  end;
end;

{��ʿ} //�����Ʒ����
function THeroObject.CheckItemType(nItemType: Integer; StdItem: pTStdItem ; nItemShape: Integer): Boolean;
begin
  Result := False;
  case nItemType of
    1: begin
        if (StdItem.StdMode = 25) and (StdItem.Shape = 5) then Result := True;
      end;
    2: begin
        case nItemShape of
          1:if (StdItem.StdMode = 25) and (StdItem.Shape = 1) then Result := True;
          2:if (StdItem.StdMode = 25) and (StdItem.Shape = 2) then Result := True;
        end;
      end;
  end;
end;
//�ж�װ�������Ƿ���ָ�����͵���Ʒ
function THeroObject.CheckUserItemType(nItemType: Integer; nItemShape: Integer): Boolean;
var
  StdItem: pTStdItem;
begin
  Result := False;
 if m_UseItems[U_ARMRINGL].wIndex > 0 then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[U_ARMRINGL].wIndex);
    if (StdItem <> nil) then begin
      case nItemType of
        1:if m_UseItems[U_ARMRINGL].Dura >= nItemShape * 100 then Result := CheckItemType(nItemType, StdItem, nItemShape);
        2:Result := CheckItemType(nItemType, StdItem, nItemShape);
      end;
    end;
  end (* else {20080212 ����,�ж�װ����Ʒһ���Ƿ���ָ�����͵���Ʒ}
  if m_UseItems[U_BUJUK].wIndex > 0 then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
    if StdItem <> nil then begin
      Result := CheckItemType(nItemType, StdItem);
    end;
  end; *)
end;

function THeroObject.UseItem(nItemType, nIndex: Integer; nItemShape: Integer): Boolean; //�Զ�������
var
  UserItem: pTUserItem;
  AddUserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  if (nIndex >= 0) and (nIndex < m_ItemList.Count) then begin
    UserItem := m_ItemList.Items[nIndex];
    if m_UseItems[U_ARMRINGL {U_BUJUK}].wIndex > 0 then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[U_ARMRINGL {U_BUJUK}].wIndex);
      if StdItem <> nil then begin
        case nItemType of
          1:begin
              if CheckItemType(nItemType, StdItem ,nItemShape) and (m_UseItems[U_ARMRINGL {U_BUJUK}].Dura >= nItemShape * 100) then begin
                Result := True;
              end else begin
                m_ItemList.Delete(nIndex);
                New(AddUserItem);
                AddUserItem^ := m_UseItems[U_ARMRINGL {U_BUJUK}];
                if AddItemToBag(AddUserItem) then begin
                  m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
                  SendChangeItems(U_ARMRINGL, U_ARMRINGL, UserItem, AddUserItem);
                  Dispose(UserItem);
                  Result := True;
                end else m_ItemList.Add(UserItem);
              end;
           end;
          2:begin
              if CheckItemType(nItemType, StdItem ,nItemShape) then begin
                Result := True;
              end else begin
                m_ItemList.Delete(nIndex);
                New(AddUserItem);
                AddUserItem^ := m_UseItems[U_ARMRINGL {U_BUJUK}];
                if AddItemToBag(AddUserItem) then begin
                  m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
                  SendChangeItems(U_ARMRINGL, U_ARMRINGL, UserItem, AddUserItem);
                  Dispose(UserItem);
                  Result := True;
                end else m_ItemList.Add(UserItem);
              end;
           end;
        end;
        (*if CheckItemType(nItemType, StdItem ,nItemShape) then begin
          Result := True;
        end else begin
          m_ItemList.Delete(nIndex);
          New(AddUserItem);
          AddUserItem^ := m_UseItems[U_ARMRINGL {U_BUJUK}];
          if AddItemToBag(AddUserItem) then begin
            m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
            SendChangeItems(U_ARMRINGL, U_ARMRINGL, UserItem, AddUserItem);
            Dispose(UserItem);
            Result := True;
          end else m_ItemList.Add(UserItem);
        end; *)
      end else begin
        m_ItemList.Delete(nIndex);
        m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
        SendChangeItems(U_ARMRINGL, U_ARMRINGL, UserItem, nil);
        Dispose(UserItem);
        Result := True;
      end;
    end else begin
      m_ItemList.Delete(nIndex);
      m_UseItems[U_ARMRINGL {U_BUJUK}] := UserItem^;
      SendChangeItems(U_ARMRINGL, U_ARMRINGL, UserItem, nil);
      Dispose(UserItem);
      Result := True;
    end;
  end;
  //SendUseitems();
  //ClientQueryBagItems;
end;

//���������Ƿ��з��Ͷ�
//nType Ϊָ������ 1 Ϊ����� 2 Ϊ��ҩ  ��Ϊ��,�� nItemShape ��ʾ���ĳ־�,��ʱ,1-�̶�,2-�춾
function THeroObject.GetUserItemList(nItemType: Integer; nItemShape: Integer): Integer;
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := -1;
  if m_UseItems[U_ARMRINGL].wIndex > 0 then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[U_ARMRINGL].wIndex);
    if (StdItem <> nil) and (StdItem.StdMode = 25) then begin
      case nItemType of
        1: begin
            if (StdItem.Shape = 5) and (Round(m_UseItems[U_ARMRINGL].Dura / 100) >= nItemShape) then begin
              Result:= 1;
              Exit;
            end;
          end;
        2: begin
            Case nItemShape of
              1: begin
                 if StdItem.Shape = 1 then begin
                   Result:= 1;
                   Exit;
                 end;
               end;
              2:begin
                 if StdItem.Shape = 2 then begin
                   Result:= 1;
                   Exit;
                 end;
              end;
            end;
          end;
      end;
    end;
  end;

  if m_UseItems[U_BUJUK].wIndex > 0 then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
    if (StdItem <> nil) and (StdItem.StdMode = 25) then begin
      case nItemType of //
        1: begin//��
            if (StdItem.Shape = 5) and (Round(m_UseItems[U_BUJUK].Dura / 100) >= nItemShape) then begin
              Result:= 1;
              Exit;
            end;
          end;
        2: begin//��
            Case nItemShape of
              1: begin
                 if StdItem.Shape = 1 then begin
                   Result:= 1;
                   Exit;
                 end;
               end;
              2:begin
                 if StdItem.Shape = 2 then begin
                   Result:= 1;
                   Exit;
                 end;
              end;
            end;
          end;
      end;
    end;
  end;

  for I := m_ItemList.Count - 1 downto 0 do begin//20080916 �޸�
    if m_ItemList.Count <= 0 then Break;//20080916
    UserItem := m_ItemList.Items[I];
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then begin
      if CheckItemType(nItemType, StdItem, nItemShape) then begin
        if UserItem.Dura < 100 then begin
          m_ItemList.Delete(I);
          Continue;
        end;
        case nItemType of
          1:begin
              if UserItem.Dura >= nItemShape * 100 then begin
                Result := I;
                Break;
              end
            end;
          2:begin
              Case nItemShape of
                1: begin
                   if StdItem.Shape = 1 then begin
                     Result := I;
                     Break;
                   end;
                 end;
                2:begin
                   if StdItem.Shape = 2 then begin
                     Result := I;
                     Break;
                   end;
                end;
              end;
            end;
        end;
      end;
    end;
  end;
end;
//�ϻ�������ʱ��,ֱ�ӽ���ϻ� 20080406
function THeroObject.AttackTarget(): Boolean;
var
  dwAttackTime: LongWord;
begin
  Result := False;
  if m_btStatus <> 0 then begin
    if m_TargetCret <> nil then m_TargetCret:= nil;
    Exit;//20080404 ���治���
  end;
  if InSafeZone and (m_TargetCret <> nil) then begin//Ӣ�۽��밲ȫ���ھͲ���PKĿ�� 20080721
    if (m_TargetCret.m_btRaceServer = RC_PLAYOBJECT) or (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) then begin
       m_TargetCret:= nil;
       Exit;
    end;
  end;
  m_dwTargetFocusTick := GetTickCount();
  case m_btJob of
    0: begin
        dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWarrorAttackTime) - m_nHitSpeed * g_Config.ClientConf.btItemSpeed); //��ֹ��������  +�ٶ� 20080405
        if (GetTickCount - m_dwHitTick > dwAttackTime) or m_boStartUseSpell then begin
          //m_dwHitTick := GetTickCount();
          m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080714
          Result := WarrorAttackTarget;
        end;
      end;
    1: begin
        dwAttackTime := _MAX(0, Integer(g_Config.dwHeroWizardAttackTime) - m_nHitSpeed * g_Config.ClientConf.btItemSpeed); //��ֹ��������  +�ٶ� 20080405
        if (GetTickCount - m_dwHitTick > dwAttackTime) or m_boStartUseSpell then begin
          m_dwHitTick := GetTickCount();//20080530
          m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080714
          Result := WizardAttackTarget;
          Exit;//20080719
        end;
        m_nSelectMagic := 0;//20080719
      end;
    2: begin
        dwAttackTime := _MAX(0, Integer(g_Config.dwHeroTaoistAttackTime) - m_nHitSpeed * g_Config.ClientConf.btItemSpeed); //��ֹ��������  +�ٶ� 20080405
        if (GetTickCount - m_dwHitTick > dwAttackTime) or m_boStartUseSpell then begin
          m_dwHitTick := GetTickCount();//20080530
          m_boIsUseMagic := False;//�Ƿ��ܶ�� 20080714
          Result := TaoistAttackTarget;
          Exit;//20080719
        end;
        m_nSelectMagic := 0;//20080719
      end;
  end;
end;

procedure THeroObject.SearchMagic();
var
  UserMagic: pTUserMagic;
begin
  m_nSelectMagic:= 0;
  m_nSelectMagic := SelectMagic;
  if m_nSelectMagic > 0 then begin
    UserMagic := FindMagic(m_nSelectMagic);
    if UserMagic <> nil then begin
      m_boIsUseAttackMagic := IsUseAttackMagic{��Ҫ������ħ��};
    end else begin
      m_boIsUseAttackMagic := False;
     // m_boIsUseMagic:=IsUseMagic;
    end;
  end else begin
    m_boIsUseAttackMagic := False;
  end;
end;

function THeroObject.IsSearchTarget: Boolean;
begin
  Result := False;
  if (m_TargetCret <> nil) then begin
    if (m_TargetCret = Self) then m_TargetCret := nil;
  end;
  if (m_TargetCret = nil) {or}and ((GetTickCount - m_dwSearchEnemyTick) > 400{8000}) and (m_btStatus = 0) then begin
    m_dwSearchEnemyTick := GetTickCount;
    Result := True;
    Exit;
  end;
 { if GetTickCount - m_dwSearchEnemyTick < 1000 then Exit; //20080222 ע��
  m_dwSearchEnemyTick := GetTickCount;
  Result := True; }
  {case m_btJob of
    0: begin
        if (m_TargetCret <> nil) and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) and (CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) >= 1) then begin
          m_dwSearchEnemyTick := GetTickCount;
          Result := True;
          Exit;
        end;
      end;
    1, 2: begin
        if m_boIsUseAttackMagic then begin
          if (m_TargetCret <> nil) and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 3) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 3)) and (CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) > 0) then begin
            m_dwSearchEnemyTick := GetTickCount;
            Result := True;
            Exit;
          end;
        end else begin
          if (m_TargetCret <> nil) and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) and (CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) >= 2) then begin
            m_dwSearchEnemyTick := GetTickCount;
            Result := True;
            Exit;
          end;
        end;
      end;
  end; }
end;
//�����Ʒ�Ƿ�Ϊ����֮��
function THeroObject.WearFirDragon: Boolean;
var
  StdItem: pTStdItem;
begin
 Result := False;
  if m_UseItems[U_BUJUK].wIndex > 0 then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
    if (StdItem <> nil) and (StdItem.StdMode = 25) and (StdItem.Shape = 9) then begin
      Result := True;
    end;
  end;
end;
//�޲�����֮��  20071229   btType:2--����  4--Ӣ��
procedure THeroObject.RepairFirDragon(btType: Byte; nItemIdx: Integer; sItemName: string);
var
  I, n14: Integer;
  UserItem: pTUserItem;
  StdItem{, StdItem20}: pTStdItem;
  sUserItemName: string;
  boRepairOK: Boolean;
  ItemList: TList;
  OldDura: Word;
begin
  boRepairOK := False;
  ItemList := nil;
  StdItem := nil;
  UserItem := nil;
  n14 := -1;
  OldDura :=0;
  if (m_Master <> nil) and WearFirDragon then begin
    if m_UseItems[U_BUJUK].Dura < m_UseItems[U_BUJUK].DuraMax then begin
      OldDura := m_UseItems[U_BUJUK].Dura;
      case btType of
        2: ItemList := m_Master.m_ItemList;
        4: ItemList := m_ItemList;
      end;
      if ItemList <> nil then begin
        if ItemList.Count > 0 then begin//20080630
          for I := 0 to ItemList.Count - 1 do begin
            UserItem := ItemList.Items[I];
            if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
              //ȡ�Զ�����Ʒ����
              sUserItemName := '';
              if UserItem.btValue[13] = 1 then
                sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
              if sUserItemName = '' then
                sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if StdItem <> nil then begin
                if CompareText(sUserItemName, sItemName) = 0 then begin
                  n14 := I;
                  Break;
                end;
              end;
            end;
            UserItem := nil;
          end;
        end;
        if (StdItem <> nil) and (UserItem <> nil) and (StdItem.StdMode = 42) then begin
          Inc(m_UseItems[U_BUJUK].Dura, UserItem.DuraMax);
          if m_UseItems[U_BUJUK].Dura > m_UseItems[U_BUJUK].DuraMax then m_UseItems[U_BUJUK].Dura:=m_UseItems[U_BUJUK].DuraMax;
          boRepairOK := True;
          case btType of
            2: m_Master.DelBagItem(n14);
            4: DelBagItem(n14);
          end;
        end;
      end;
    end;
  end;
  if boRepairOK then begin
    if OldDura <> m_UseItems[U_BUJUK].Dura then
      SendMsg(Self, RM_HERODURACHANGE, U_BUJUK, m_UseItems[U_BUJUK].Dura, m_UseItems[U_BUJUK].DuraMax, 0, '');
      SendDefMessage(SM_REPAIRFIRDRAGON_OK, btType, 0, 0, 0, '');
  end else begin
    SendDefMessage(SM_REPAIRFIRDRAGON_FAIL, btType, 0, 0, 0, '');
    SysMsg('�޲�����֮��ʧ��!', BB_Fuchsia, t_Hint);//20071231
  end;
end;

//ȡ��ɱλ 20080604
function THeroObject.GetGotoXY(BaseObject: TBaseObject; nCode:Byte): Boolean;
begin
  Result := False;
  Case nCode of
    2:begin//��ɱλ
      if (m_nCurrX - 2 <= BaseObject.m_nCurrX) and
        (m_nCurrX + 2 >= BaseObject.m_nCurrX) and
        (m_nCurrY - 2 <= BaseObject.m_nCurrY) and
        (m_nCurrY + 2 >= BaseObject.m_nCurrY) and
        ((m_nCurrX <> BaseObject.m_nCurrX) or
        (m_nCurrY <> BaseObject.m_nCurrY)) then begin
        Result := True;
        if ((m_nCurrX - 2) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 2;
          m_nTargetY:= m_nCurrY;
          Exit;
        end;
        if ((m_nCurrX + 2) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 2;
          m_nTargetY:= m_nCurrY;
          Exit;
        end;
        if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY - 2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX ;
          m_nTargetY:= m_nCurrY - 2;
          Exit;
        end;
        if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY + 2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX ;
          m_nTargetY:= m_nCurrY + 2;
          Exit;
        end;
        if ((m_nCurrX - 2) = BaseObject.m_nCurrX) and ((m_nCurrY -2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 2;
          m_nTargetY:= m_nCurrY - 2;
          Exit;
        end;
        if ((m_nCurrX + 2) = BaseObject.m_nCurrX) and ((m_nCurrY - 2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 2;
          m_nTargetY:= m_nCurrY - 2;
          Exit;
        end;
        if ((m_nCurrX - 2) = BaseObject.m_nCurrX) and ((m_nCurrY + 2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 2;
          m_nTargetY:= m_nCurrY + 2;
          Exit;
        end;
        if ((m_nCurrX + 2) = BaseObject.m_nCurrX) and ((m_nCurrY + 2) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 2;
          m_nTargetY:= m_nCurrY + 2;
          Exit;
        end;
      end;
    end;//2
    3:begin//3��
      if (m_nCurrX - 3 <= BaseObject.m_nCurrX) and
        (m_nCurrX + 3 >= BaseObject.m_nCurrX) and
        (m_nCurrY - 3 <= BaseObject.m_nCurrY) and
        (m_nCurrY + 3 >= BaseObject.m_nCurrY) and
        ((m_nCurrX <> BaseObject.m_nCurrX) or
        (m_nCurrY <> BaseObject.m_nCurrY)) then begin
        Result := True;
        if ((m_nCurrX - 3) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 3;
          m_nTargetY:= m_nCurrY;
          Exit;
        end;
        if ((m_nCurrX + 3) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 3;
          m_nTargetY:= m_nCurrY;
          Exit;
        end;
        if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY - 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX ;
          m_nTargetY:= m_nCurrY - 3;
          Exit;
        end;
        if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY + 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX ;
          m_nTargetY:= m_nCurrY + 3;
          Exit;
        end;
        if ((m_nCurrX - 3) = BaseObject.m_nCurrX) and ((m_nCurrY - 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 3;
          m_nTargetY:= m_nCurrY - 3;
          Exit;
        end;
        if ((m_nCurrX + 3) = BaseObject.m_nCurrX) and ((m_nCurrY - 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 3;
          m_nTargetY:= m_nCurrY - 3;
          Exit;
        end;
        if ((m_nCurrX - 3) = BaseObject.m_nCurrX) and ((m_nCurrY + 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX - 3;
          m_nTargetY:= m_nCurrY + 3;
          Exit;
        end;
        if ((m_nCurrX + 3) = BaseObject.m_nCurrX) and ((m_nCurrY + 3) = BaseObject.m_nCurrY) then begin
          m_nTargetX:= m_nCurrX + 3;
          m_nTargetY:= m_nCurrY + 3;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;

procedure THeroObject.Run;
var
  nX, nY, nDir: Integer;
  nCheckCode: Byte;
resourcestring
  sExceptionMsg = '{�쳣} THeroObject.Run Code:%d';
begin
  nCheckCode:= 0;
  try
  if (not m_boGhost) and (not m_boDeath) and (not m_boFixedHideMode) and (not m_boStoneMode) then begin
    EatMedicine();//��ҩ
    if (m_wStatusTimeArr[POISON_STONE] = 0) then begin//û�б����
      nCheckCode:= 11;
      if Think then begin
        inherited;
        Exit;
      end;

      nCheckCode:= 12;                                  
      if m_Master <> nil then PlaySuperRock;//��Ѫʯ ħѪʯ  20080729
  //------------------------------------------------------------------------------
  //���ƾ�����������
      if m_Abil.WineDrinkValue > 0 then begin//��ƶȴ���0ʱ�Ŵ���
        if (GetTickCount() - m_dwAddAlcoholTick + n_DrinkWineQuality * 1000 > (g_Config.nIncAlcoholTick * 1000)) and (not n_DrinkWineDrunk) then begin//���Ӿ�������
          m_dwAddAlcoholTick := GetTickCount();
          SendRefMsg(RM_MYSHOW, 8, 0, 0, 0, ''); //�������Ӷ���  20080623
          Inc(m_Abil.Alcohol, _MAX(5,(n_DrinkWineAlcohol * m_Abil.MaxAlcohol) div 1000));//�ƶ��� ����������
          if m_Abil.Alcohol > m_Abil.MaxAlcohol then begin//��������
            m_Abil.Alcohol:= m_Abil.Alcohol - m_Abil.MaxAlcohol;
            m_Abil.MaxAlcohol:= m_Abil.MaxAlcohol+ g_Config.nIncAlcoholValue;
            //SysMsg(g_sUpAlcoholHintMsg{'���ľ���������'},c_Green,t_Hint);//��ʾ�û�
            if m_Magic67Skill <> nil then begin//����Ԫ��ħ������
              m_Magic67Skill.nTranPoint:= m_Abil.MaxAlcohol;
              if not CheckMagicLevelup(m_Magic67Skill) then begin
                SendDelayMsg(self, RM_HEROMAGIC_LVEXP, 0,m_Magic67Skill.MagicInfo.wMagicId, m_Magic67Skill.btLevel, m_Magic67Skill.nTranPoint, '', 1000);
              end;
              if m_Abil.WineDrinkValue >= abs(m_Abil.MaxAlcohol * g_Config.nMinDrinkValue67 div 100) then begin//�������ڻ���ھ������޵�5%ʱ����Ч
                 if m_Magic67Skill.btLevel > 0 then begin
                   m_WAbil.AC := MakeLong(LoWord(m_WAbil.AC),HiWord(m_WAbil.AC)+ m_Magic67Skill.btLevel * 2);
                   m_WAbil.MAC := MakeLong(LoWord(m_WAbil.MAC), HiWord(m_WAbil.MAC)+ m_Magic67Skill.btLevel * 2);
                   SendMsg(Self, RM_HEROABILITY, 0, 0, 0, 0, '');//20080823 ����
                 end;
              end;
            end;
          end;
          GetNGExp(g_Config.nDrinkIncNHExp, 2); //���������ڹ����� 2008103
          RecalcAbilitys();
          CompareSuitItem(False);//��װ������װ���Ա� 20080729
          //SendMsg(Self, RM_HEROABILITY, 0, 0, 0, 0, '');
          SendMsg(Self, RM_HEROMAKEWINEABILITY, 0, 0, 0, 0, '');//��2������� 20080804
        end;

        if GetTickCount() - m_dwDecWineDrinkValueTick > g_Config.nDesDrinkTick * 1000 then begin//������ƶ�
           m_dwDecWineDrinkValueTick:= GetTickCount();
           m_Abil.WineDrinkValue:= _MAX(0, m_Abil.WineDrinkValue - m_Abil.MaxAlcohol div 100);
           if m_Abil.WineDrinkValue = 0 then begin
              n_DrinkWineQuality:= 0;//����ʱ�Ƶ�Ʒ�� 20080627
              n_DrinkWineAlcohol:= 0;//����ʱ�ƵĶ��� 20080627         
              n_DrinkWineDrunk:= False;//�Ⱦ����� 20080623
              SysMsg('Ӣ�� '+g_sJiujinOverHintMsg{'�ƾ�������ʧ��,����Ҳ�ָ�ƽ����״̬'},c_Green,t_Hint);//��ʾ�û�
           end;
           RecalcAbilitys();
           CompareSuitItem(False);//��װ������װ���Ա� 20080729
           //SendMsg(Self, RM_HEROABILITY, 0, 0, 0, 0, '');
           SendMsg(Self, RM_HEROMAKEWINEABILITY, 0, 0, 0, 0, '');//��2������� 20080804
        end;
      end;
      if m_boTrainingNG and (m_Skill69NH < m_Skill69MaxNH) then begin//ѧ���ڹ�,���ʱ����������ֵ 20081002
        if GetTickCount - m_dwIncNHTick > g_Config.dwIncNHTime then begin
          m_dwIncNHTick:= GetTickCount();
          m_Skill69NH:= _MIN(m_Skill69MaxNH, m_Skill69NH + _MAX( 1 , Round(m_Skill69MaxNH * 0.014)));//20081026 �޸�,ÿ�������ڹ�ֵ���޵�0.14%
          SendRefMsg(RM_MAGIC69SKILLNH, 0, m_Skill69NH, m_Skill69MaxNH, 0, '');
        end;
      end;
  //------------------------------------------------------------------------------
      nCheckCode:= 1;
      if (not m_boStartUseSpell) and (not m_boDecDragonPoint) then begin
        if m_nFirDragonPoint < g_Config.nMaxFirDragonPoint then begin
          if GetTickCount() - m_dwAddFirDragonTick > g_Config.nIncDragonPointTick{1000 * 3} then begin//20080606 ��ŭ��ʱ��ɵ���
            m_dwAddFirDragonTick := GetTickCount();
            if WearFirDragon and (m_UseItems[U_BUJUK].Dura > 0) then begin    //20080129 ����֮�ĳ־�
              if m_UseItems[U_BUJUK].Dura  >= g_Config.nDecFirDragonPoint then begin
                Dec(m_UseItems[U_BUJUK].Dura, g_Config.nDecFirDragonPoint);
              end else begin
                m_UseItems[U_BUJUK].Dura := 0;
                //m_UseItems[U_BUJUK].wIndex:= 0;//20081014 20081218 ���������֮��
              end;
              Inc(m_nFirDragonPoint, g_Config.nAddFirDragonPoint); //����Ӣ��ŭ��
              if m_nFirDragonPoint > g_Config.nMaxFirDragonPoint then m_nFirDragonPoint:=g_Config.nMaxFirDragonPoint;//20071231 ����ŭ��ֵ��ӳ���
              SendMsg(Self, RM_HERODURACHANGE, U_BUJUK, m_UseItems[U_BUJUK].Dura, m_UseItems[U_BUJUK].DuraMax, 0, '');
              SendMsg(Self, RM_FIRDRAGONPOINT, g_Config.nMaxFirDragonPoint, m_nFirDragonPoint, 0, 0, '');
            end;
          end;
        end;
      end else begin
         if m_boDecDragonPoint and WearFirDragon then begin //��ŭ��
           if m_nFirDragonPoint > 0 then begin
             if GetTickCount() - m_dwAddFirDragonTick > 2000{1000 * 2} then begin
               m_dwAddFirDragonTick := GetTickCount();
               Dec(m_nFirDragonPoint, (g_Config.nMaxFirDragonPoint div 10)); //��Ӣ��ŭ��  20080525
               if m_nFirDragonPoint <= 0 then begin
                 m_nFirDragonPoint:= 0;
                 m_boDecDragonPoint:= False;//20080418 ֹͣ��ŭ��
                 m_boStartUseSpell := False;
               end;
               SendMsg(Self, RM_FIRDRAGONPOINT, g_Config.nMaxFirDragonPoint, m_nFirDragonPoint, 0, 0, '');
             end;
             //ְҵ��ս,�������,�Զ��źϻ� 20080419
             if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) and (m_Master <> nil) then begin
                case GetTogetherUseSpell of
                   60:begin
                     if ((m_wStatusTimeArr[POISON_STONE] = 0) and (m_Master.m_wStatusTimeArr[POISON_STONE] = 0))
                        or (g_Config.ClientConf.boParalyCanSpell) then begin//20080913 �����
                        if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 2)) and
                           ((abs(m_TargetCret.m_nCurrX - m_Master.m_nCurrX) <= 2) and (abs(m_TargetCret.m_nCurrY - m_Master.m_nCurrY) <= 2)) then begin
                           m_boDecDragonPoint:= False;//ֹͣ��ŭ��
                           m_boStartUseSpell := True;//�ϻ����ܿ���
                           m_dwStartUseSpellTick := GetTickCount();
                        end;
                      end;
                    end;
                  61,62:begin//����ն,����һ��
                     if ((m_wStatusTimeArr[POISON_STONE] = 0) and (m_Master.m_wStatusTimeArr[POISON_STONE] = 0))
                        or (g_Config.ClientConf.boParalyCanSpell) then begin//20080913 �����
                       if ((m_btJob = 0) and ((abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 2))) or
                          ((m_Master.m_btJob = 0) and ((abs(m_TargetCret.m_nCurrX - m_Master.m_nCurrX) <= 2) and (abs(m_TargetCret.m_nCurrY - m_Master.m_nCurrY) <= 2))) then begin
                          m_boDecDragonPoint:= False;//ֹͣ��ŭ��
                          m_boStartUseSpell := True;//�ϻ����ܿ���
                          m_dwStartUseSpellTick := GetTickCount();
                       end;
                     end;
                   end;
                  63,64,65:begin//20080913 �����
                     if ((m_wStatusTimeArr[POISON_STONE] = 0) and (m_Master.m_wStatusTimeArr[POISON_STONE] = 0))
                        or (g_Config.ClientConf.boParalyCanSpell) then begin
                        m_boDecDragonPoint:= False;//ֹͣ��ŭ��
                        m_boStartUseSpell := True;//�ϻ����ܿ���
                        m_dwStartUseSpellTick := GetTickCount();
                     end;
                  end;
                end;
             end;//if m_nFirDragonPoint > 0 then begin
           end;//if m_boDecDragonPoint and WearFirDragon then begin //��ŭ��
         end;
       { if m_boStartUseSpell and (m_nStartUseSpell >= 3) then begin //ȥ������,����Ӣ�ۺϻ���ʱ�Ų���,��ŭ��ֵ��Ϊ0 20071227
          m_nStartUseSpell := 0;
          m_boStartUseSpell := False;
        end; }
        if m_boStartUseSpell and (GetTickCount - m_dwStartUseSpellTick > 3000{1000 * 3}) then begin
         // m_nStartUseSpell := 0;
          m_boStartUseSpell := False;
          m_boDecDragonPoint:= False;//20080418 ֹͣ��ŭ��
        end;
        SendMsg(Self, RM_FIRDRAGONPOINT, g_Config.nMaxFirDragonPoint, m_nFirDragonPoint, 0, 0, '');//����Ӣ��ŭ��ֵ
      end;

      if m_boFireHitSkill and ((GetTickCount - m_dwLatestFireHitTick) > 20000{20 * 1000}) then begin
        m_boFireHitSkill := False;
        //SysMsg(sSpiritsGone, BB_Fuchsia, t_Hint);//�ٻ��һ���� 20080112
      end;
      if m_boDailySkill and ((GetTickCount - m_dwLatestDailyTick) > 20000{20 * 1000}) then begin
        m_boDailySkill := False; //���ս������� 20080511
      end;

      nCheckCode:= 2;
      if IsSearchTarget then SearchTarget(); //����Ŀ�� 20080327
      //m_dwWalkWait := 10;
      //m_nWalkSpeed := 10;
      if m_boWalkWaitLocked then begin
        if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then m_boWalkWaitLocked := False;
      end;

      if not m_boWalkWaitLocked and ({Integer}(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
        m_dwWalkTick := GetTickCount();
       //if m_btRaceServer <> RC_HEROOBJECT then begin//20080715 ע��
          Inc(m_nWalkCount);
          if m_nWalkCount > m_nWalkStep then begin
            m_nWalkCount := 0;
            m_boWalkWaitLocked := True;
            m_dwWalkWaitTick := GetTickCount();
          end;
        //end;

        if not m_boRunAwayMode then begin
          if not m_boNoAttackMode then begin
            if m_boProtectStatus then begin//�ػ�״̬,����̫Զ,ֱ�ӷɹ�ȥ  20080417
              if not m_boProtectOK then begin//û�ߵ��ػ����� 20080603
                if RunToTargetXY(m_nProtectTargetX, m_nProtectTargetY) then m_boProtectOK:= True
                else if WalkToTargetXY2(m_nProtectTargetX, m_nProtectTargetY) then m_boProtectOK:= True; //ת��
              end;
              {if (abs(m_nCurrX - m_nProtectTargetX) > 10) or (abs(m_nCurrY - m_nProtectTargetY) > 10) then begin
                m_TargetCret := nil;
                SpaceMove(m_PEnvir.sMapName, m_nProtectTargetX, m_nProtectTargetY, 1);
              end;}
            end;
            nCheckCode:= 6;
            if (m_TargetCret <> nil) then begin
              if m_boStartUseSpell then begin
                m_nSelectMagic := GetTogetherUseSpell; //�жϺϻ�ħ��ID
                if (m_btJob = 0) and (m_nSelectMagic = 60) then //20080227  ����Ϣ��ǰ�Ƿ��ͺϻ� ���ͻ��˵���Ϣ  ����ûʵ���ô�  �����ڷ��ƻ��ȹ�����ʾ�±���������
                SendMsg(m_TargetCret, RM_GOTETHERUSESPELL, m_nSelectMagic, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 0, '');//ʹ�úϻ�
                m_nFirDragonPoint := 0;//���ŭ��
              //end else begin
                 //SearchMagic(); //��ѯħ�� 20080328ע��
              end;

              if AttackTarget then begin//����  20080710
                nCheckCode:= 70;
                m_boStartUseSpell := False;
                inherited;
                Exit;
              end else
              if IsNeedAvoid then begin //�Զ����
                nCheckCode:= 71;
                m_dwActionTick := GetTickCount()- 10;//20080720
                AutoAvoid();
                inherited;
                Exit;
              end else begin
                if IsNeedGotoXY then begin//�Ƿ�����Ŀ��
                  nCheckCode:= 72;
                  m_dwActionTick := GetTickCount();//20080718 ����
                  m_nTargetX:= m_TargetCret.m_nCurrX;
                  m_nTargetY:= m_TargetCret.m_nCurrY;
                  if IsAllowUseMagic(12) and (m_btJob = 0) then GetGotoXY(m_TargetCret, 2);//20080617 �޸�
                  if (m_btJob > 0) then begin
                    if g_Config.boHeroAttackTarget and (m_Abil.Level < 22) then begin//20081218 ����22ǰ�Ƿ�������
                    end else GetGotoXY(m_TargetCret, 3);//20080710 ����ֻ����Ŀ��3��Χ
                  end;
                  GotoTargetXY( m_nTargetX, m_nTargetY, 0);
                  //GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
                  inherited;
                  Exit;
                 end;
              end;
            end else begin
              if not m_boProtectStatus then m_nTargetX := -1;
            end;
          end;
          nCheckCode:= 8;
          if m_TargetCret <> nil then begin
            m_nTargetX := m_TargetCret.m_nCurrX;
            m_nTargetY := m_TargetCret.m_nCurrY;
          end;
          nCheckCode:= 81;
          if SearchIsPickUpItem then begin
            nCheckCode:= 82;
            SearchPickUpItem(500);
            inherited;
            Exit;
          end;
          nCheckCode:= 9;
          if m_Master <> nil then begin
            if m_boProtectStatus then begin //�ػ�״̬
              {if (abs(m_nCurrX - m_nProtectTargetX) > 10) or (abs(m_nCurrY - m_nProtectTargetY) > 10) then begin //������Χ
                m_nTargetX := m_nProtectTargetX;
                m_nTargetY := m_nProtectTargetY;
                m_TargetCret := nil;
                SpaceMove(m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
              end else}
              if (abs(m_nCurrX - m_nProtectTargetX) > 9{6}) or (abs(m_nCurrY - m_nProtectTargetY) > 9{6}) then begin//20081219 �޸��ػ���Χ
                m_nTargetX := m_nProtectTargetX;
                m_nTargetY := m_nProtectTargetY;
                m_TargetCret := nil;
              end else begin
                m_nTargetX := -1;
              end;
            end else begin
              if (m_TargetCret = nil) and (not m_boProtectStatus) and (m_btStatus <> 2) then begin
                nCheckCode:= 95;
                m_Master.GetBackPosition(nX, nY);
                if (abs(m_nTargetX - nX) > 2{1}) or (abs(m_nTargetY - nY ) > 2{1}) then begin//20081016 �޸�2��
                  m_nTargetX := nX;
                  m_nTargetY := nY;
                  if (abs(m_nCurrX - nX) <= 3{2}) and (abs(m_nCurrY - nY) <= 3{2}) then begin//20081016
                    if m_PEnvir.GetMovingObject(nX, nY, True) <> nil then begin
                      m_nTargetX := m_nCurrX;
                      m_nTargetY := m_nCurrY;
                    end;
                  end; 
                end;
              end; //if m_TargetCret = nil then begin
            end;
            if {(not m_Master.m_boSlaveRelax) and} (not m_boProtectStatus) and (m_btStatus <> 2) and //20080408
              ((m_PEnvir <> m_Master.m_PEnvir) or
              (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
              (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) then begin
              nCheckCode:= 99;
              SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
            end;
            if (m_TargetCret <> nil) then begin//��Ŀ����Ӣ�۲���ͬ����ͼ��ɾ��Ŀ�� 20081214
              if (m_TargetCret.m_PEnvir <> m_PEnvir) then DelTargetCreat();
            end;
          end; //if m_Master <> nil then begin
        end else begin
          if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then begin
            m_boRunAwayMode := False;
            m_dwRunAwayTime := 0;
          end;
        end;
        nCheckCode:= 10;
       { if (m_Master <> nil) and m_Master.m_boSlaveRelax then begin //20080408 Ӣ��������Ϊ��Ϣʱ,����Ϣ
          inherited;
          Exit;
        end; }
        if (m_TargetCret = nil) and (m_btStatus <> 2) then begin
          if m_nTargetX <> -1 then begin
            if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
              GotoTargetXY(m_nTargetX, m_nTargetY, 0);
            end;
          end else begin
            Wondering();
          end;
        end;
      end;
    end else begin//���ʱ,��������ŭ�� 20081204
      if (not m_boStartUseSpell) and (not m_boDecDragonPoint) then begin
        if m_nFirDragonPoint < g_Config.nMaxFirDragonPoint then begin
          if GetTickCount() - m_dwAddFirDragonTick > g_Config.nIncDragonPointTick{1000 * 3} then begin//20080606 ��ŭ��ʱ��ɵ���
            m_dwAddFirDragonTick := GetTickCount();
            if WearFirDragon and (m_UseItems[U_BUJUK].Dura > 0) then begin    //20080129 ����֮�ĳ־�
              if m_UseItems[U_BUJUK].Dura  >= g_Config.nDecFirDragonPoint then begin
                Dec(m_UseItems[U_BUJUK].Dura, g_Config.nDecFirDragonPoint);
              end else begin
                m_UseItems[U_BUJUK].Dura := 0;
                //m_UseItems[U_BUJUK].wIndex:= 0;//20081014 20081218 ���������֮��
              end;
              Inc(m_nFirDragonPoint, g_Config.nAddFirDragonPoint); //����Ӣ��ŭ��
              if m_nFirDragonPoint > g_Config.nMaxFirDragonPoint then m_nFirDragonPoint:=g_Config.nMaxFirDragonPoint;//20071231 ����ŭ��ֵ��ӳ���
              SendMsg(Self, RM_HERODURACHANGE, U_BUJUK, m_UseItems[U_BUJUK].Dura, m_UseItems[U_BUJUK].DuraMax, 0, '');
              SendMsg(Self, RM_FIRDRAGONPOINT, g_Config.nMaxFirDragonPoint, m_nFirDragonPoint, 0, 0, '');
            end;
          end;
        end;
      end;
    end;
  end;
  inherited;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg, [nCheckCode]));
    end;
  end;
end;

procedure THeroObject.RecalcAbilitys;
begin
  inherited;
  if m_btRaceServer = RC_HEROOBJECT then begin
    SendUpdateMsg(Self, RM_CHARSTATUSCHANGED, m_nHitSpeed, m_nCharStatus, 0, 0, '');
    RecalcAdjusBonus();//ˢ��Ӣ������������20081126
  end;
end;

procedure THeroObject.Die; //Ӣ������   ����Ӣ������  ���ﱻ���� Ӣ���Զ�ǿ���ٻ�  20080129
var
  nDecExp: Integer;
begin
 inherited;
   //����������,���鲻��,�򽵼� 20080605
   if g_Config.boHeroDieExp then begin
     nDecExp:= Round(GetLevelExp(m_Abil.Level) * (g_Config.nHeroDieExpRate / 100));
     if m_Abil.Exp >= nDecExp then begin
        Dec(m_Abil.Exp, nDecExp);
     end else begin
        if m_Abil.Level >= 1 then begin
          Dec(m_Abil.Level);
          Inc(m_Abil.Exp, GetLevelExp(m_Abil.Level));
          Dec(m_Abil.Exp, nDecExp);
          if m_Abil.Exp < 0 then m_Abil.Exp:= 0;
        end else begin
          m_Abil.Level := 0;
          m_Abil.Exp := 0;
        end;
     end;
   end;

  if (m_btRaceServer = RC_HEROOBJECT) and (m_Master <> nil) then begin //����Ӣ��������Ϣ
     TPlayObject(m_Master).m_nRecallHeroTime:= GetTickCount();//�ٻ�Ӣ�ۼ�� 20080606
    // SendMsg(Self, RM_HERODEATH, 0, 0, 0, 0, '');//20080403 ע��
    m_nLoyal:=_MAX(0,m_nLoyal - g_Config.nDeathDecLoyal);//���������ҳ϶� 20080110
    UserEngine.SaveHeroRcd(TPlayObject(m_Master));//��������  20080320
    TPlayObject(m_Master).m_MyHero := nil;
  end;
 // m_Master := nil;//20080403 ע��
end;

function THeroObject.FindMagic(wMagIdx: Word): pTUserMagic;
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  Result := nil;
  if m_MagicList.Count > 0 then begin//20080630
    for I := 0 to m_MagicList.Count - 1 do begin
      UserMagic := m_MagicList.Items[I];
      if UserMagic.MagicInfo.wMagicId = wMagIdx then begin
        Result := UserMagic;
        Break;
      end;
    end;
  end;
end;
//Ӣ�ۼ�鴩��װ��������
function THeroObject.CheckTakeOnItems(nWhere: Integer; var StdItem: TStdItem): Boolean;
  function GetUserItemWeitht(nWhere: Integer): Integer;
  var
    I: Integer;
    n14: Integer;
    StdItem: pTStdItem;
  begin
    n14 := 0;
    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if (nWhere = -1) or (not (I = nWhere) and not (I = 1) and not (I = 2)) then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
        if StdItem <> nil then Inc(n14, StdItem.Weight);
      end;
    end;
    Result := n14;
  end;
var
  Castle: TUserCastle;
begin
  Result := False;
  if (StdItem.StdMode = 10) and (m_btGender <> 0) then begin
    SysMsg('(Ӣ��) '+sWearNotOfWoMan, BB_Fuchsia, t_Hint); //20080312
    Exit;
  end;
  if (StdItem.StdMode = 11) and (m_btGender <> 1) then begin
    SysMsg('(Ӣ��) '+sWearNotOfMan, BB_Fuchsia, t_Hint); //20080312
    Exit;
  end;
  if (nWhere = 1) or (nWhere = 2) then begin
    if StdItem.Weight > m_WAbil.MaxHandWeight then begin
      SysMsg('(Ӣ��) '+sHandWeightNot, BB_Fuchsia, t_Hint); //20080312
      Exit;
    end;
  end else begin
    if (StdItem.Weight + GetUserItemWeitht(nWhere)) > m_WAbil.MaxWearWeight then begin
      SysMsg('(Ӣ��) '+sWearWeightNot, BB_Fuchsia, t_Hint);//20080312
      Exit;
    end;
  end;
  Castle := g_CastleManager.IsCastleMember(Self);
  case StdItem.Need of //
    0: begin
        if m_Abil.Level >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sLevelNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    1: begin
        if HiWord(m_WAbil.DC) >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sDCNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    10: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (m_Abil.Level >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sJobOrLevelNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    11: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.DC) >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sJobOrDCNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    12: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.MC) >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sJobOrMCNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    13: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.SC) >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sJobOrSCNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    2: begin
        if HiWord(m_WAbil.MC) >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sMCNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    3: begin
        if HiWord(m_WAbil.SC) >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sSCNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    4: begin
        if m_btReLevel >= StdItem.NeedLevel then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sReNewLevelNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    40: begin
        if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
          if m_Abil.Level >= HiWord(StdItem.NeedLevel) then begin
            Result := True;
          end else begin
            SysMsg('(Ӣ��) '+g_sLevelNot, BB_Fuchsia, t_Hint); //20080312
          end;
        end else begin
          SysMsg('(Ӣ��) '+g_sReNewLevelNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    41: begin
        if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
          if HiWord(m_WAbil.DC) >= HiWord(StdItem.NeedLevel) then begin
            Result := True;
          end else begin
            SysMsg('(Ӣ��) '+g_sDCNot, BB_Fuchsia, t_Hint);//20080312
          end;
        end else begin
          SysMsg('(Ӣ��) '+g_sReNewLevelNot, BB_Fuchsia, t_Hint); //20080312
        end;
      end;
    42: begin
        if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
          if HiWord(m_WAbil.MC) >= HiWord(StdItem.NeedLevel) then begin
            Result := True;
          end else begin
            SysMsg('(Ӣ��) '+g_sMCNot, BB_Fuchsia, t_Hint);//20080312
          end;
        end else begin
          SysMsg('(Ӣ��) '+g_sReNewLevelNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    43: begin
        if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
          if HiWord(m_WAbil.SC) >= HiWord(StdItem.NeedLevel) then begin
            Result := True;
          end else begin
            SysMsg('(Ӣ��) '+g_sSCNot, BB_Fuchsia, t_Hint);//20080312
          end;
        end else begin
          SysMsg('(Ӣ��) '+g_sReNewLevelNot, BB_Fuchsia, t_Hint);//20080312
        end;
      end;
    44: begin
        if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin //����װ��,������ 20080509
         // if {m_btCreditPoint}m_Abil.Level >= HiWord(StdItem.NeedLevel) then begin //����������װ��,ֻ�ڵȼ��ﵽ���ɴ��� 20080426
            Result := True;
         // end else begin
            //SysMsg('(Ӣ��)'+g_sCreditPointNot, BB_Fuchsia, t_Hint);//20080118
         //   SysMsg('(Ӣ��)'+g_sLevelNot, BB_Fuchsia, t_Hint);// 20080426
         // end;
        end else begin
          SysMsg('(Ӣ��) '+g_sReNewLevelNot, BB_Fuchsia, t_Hint);//20080118
        end;
      end;
    5: begin //����װ��,������ 20080509
        //if {m_btCreditPoint}m_Abil.Level >= StdItem.NeedLevel then begin//����������װ��,ֻ�ڵȼ��ﵽ���ɴ��� 20080426
          Result := True;
        //end else begin
          //SysMsg('(Ӣ��)'+g_sCreditPointNot, BB_Fuchsia, t_Hint);//20080118
        //  SysMsg('(Ӣ��)'+g_sLevelNot, BB_Fuchsia, t_Hint);// 20080426
       // end;
      end;
    6: begin
        if (m_MyGuild <> nil) then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sGuildNot, BB_Fuchsia, t_Hint);//20080118
        end;
      end;
    60: begin
        if (m_MyGuild <> nil) and (m_nGuildRankNo = 1) then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sGuildMasterNot, BB_Fuchsia, t_Hint);//20080118
        end;
      end;
    7: begin
        //      if (m_MyGuild <> nil) and (UserCastle.m_MasterGuild = m_MyGuild) then begin
        if (m_MyGuild <> nil) and (Castle <> nil) then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sSabukHumanNot, BB_Fuchsia, t_Hint);//20080118
        end;
      end;
    70: begin
        //      if (m_MyGuild <> nil) and (UserCastle.m_MasterGuild = m_MyGuild) and (m_nGuildRankNo = 1) then begin
        if (m_MyGuild <> nil) and (Castle <> nil) and (m_nGuildRankNo = 1) then begin
          if m_Abil.Level >= StdItem.NeedLevel then begin
            Result := True;
          end else begin
            SysMsg('(Ӣ��) '+g_sLevelNot, BB_Fuchsia, t_Hint);//20080118
          end;
        end else begin
          SysMsg('(Ӣ��) '+g_sSabukMasterManNot, BB_Fuchsia, t_Hint); //20080118
        end;
      end;
    8: begin
        if m_nMemberType <> 0 then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sMemberNot, BB_Fuchsia, t_Hint);//20080118
        end;
      end;
    81: begin
        if (m_nMemberType = LoWord(StdItem.NeedLevel)) and (m_nMemberLevel >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sMemberTypeNot, BB_Fuchsia, t_Hint);//20080118
        end;
      end;
    82: begin
        if (m_nMemberType >= LoWord(StdItem.NeedLevel)) and (m_nMemberLevel >= HiWord(StdItem.NeedLevel)) then begin
          Result := True;
        end else begin
          SysMsg('(Ӣ��) '+g_sMemberTypeNot, BB_Fuchsia, t_Hint);//20080118
        end;
      end;
  end;
  //if not Result then SysMsg(g_sCanottWearIt,c_Red,t_Hint);
end;
//ȡ�������ĵ�MPֵ
function THeroObject.GetSpellPoint(UserMagic: pTUserMagic): Integer;
begin
  Result := Round(UserMagic.MagicInfo.wSpell / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + UserMagic.MagicInfo.btDefSpell;
end;
//Ӣ�۽���Ұ����ײ 20080331
function THeroObject.DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean;
  function CanMotaebo(BaseObject: TBaseObject): Boolean;
  var
    nC: Integer;
  begin
    Result := False;
    if (m_Abil.Level > BaseObject.m_Abil.Level) and (not BaseObject.m_boStickMode) then begin
      nC := m_Abil.Level - BaseObject.m_Abil.Level;
      if Random(20) < ((nMagicLevel * 4) + 6 + nC) then begin
        if IsProperTarget(BaseObject) then Result := True;
      end;
    end;
  end;
var
  bo35: Boolean;
  I, n20, n24, n28: Integer;
  PoseCreate: TBaseObject;
  BaseObject_30: TBaseObject;
  BaseObject_34: TBaseObject;
  nX, nY: Integer;
begin
  Result := False;
  bo35 := True;
  m_btDirection := nDir;
  BaseObject_34 := nil;
  n24 := nMagicLevel + 1;
  n28 := n24;
  PoseCreate := GetPoseCreate();
  if PoseCreate <> nil then begin
    for I := 0 to _MAX(2, nMagicLevel + 1) do begin
      PoseCreate := GetPoseCreate();
      if PoseCreate <> nil then begin
        n28 := 0;
        if not CanMotaebo(PoseCreate) then Break;
        if nMagicLevel >= 3 then begin
          if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, nX, nY) then begin
            BaseObject_30 := m_PEnvir.GetMovingObject(nX, nY, True);
            if (BaseObject_30 <> nil) and CanMotaebo(BaseObject_30) then
              BaseObject_30.CharPushed(m_btDirection, 1);
          end;
        end;
        BaseObject_34 := PoseCreate;
        if PoseCreate.CharPushed(m_btDirection, 1) <> 1 then Break;
        GetFrontPosition(nX, nY);
        if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
          m_nCurrX := nX;
          m_nCurrY := nY;
          SendRefMsg(RM_RUSH, nDir, m_nCurrX, m_nCurrY, 0, '');
          bo35 := False;
          Result := True;
        end;
        Dec(n24);
      end; //if PoseCreate <> nil  then begin
    end; //for i:=0 to _MAX(2,nMagicLevel + 1) do begin
  end else begin //if PoseCreate <> nil  then begin
    bo35 := False;
    for I := 0 to _MAX(2, nMagicLevel + 1) do begin
      GetFrontPosition(nX, nY); //sub_004B2790
      if m_PEnvir.MoveToMovingObject(m_nCurrX, m_nCurrY, Self, nX, nY, False) > 0 then begin
        m_nCurrX := nX;
        m_nCurrY := nY;
        SendRefMsg(RM_RUSH, nDir, m_nCurrX, m_nCurrY, 0, '');
        Dec(n28);
      end else begin
        if m_PEnvir.CanWalk(nX, nY, True) then n28 := 0
        else begin
          bo35 := True;
          Break;
        end;
      end;
    end;
  end;
  if (BaseObject_34 <> nil) then begin
    if n24 < 0 then n24 := 0;
    n20 := Random((n24 + 1) * 10) + ((n24 + 1) * 10);
    n20 := BaseObject_34.GetHitStruckDamage(Self, n20);
    BaseObject_34.StruckDamage(n20);
    BaseObject_34.SendRefMsg(RM_STRUCK, n20, BaseObject_34.m_WAbil.HP, BaseObject_34.m_WAbil.MaxHP, Integer(Self), '');
    if BaseObject_34.m_btRaceServer <> RC_PLAYOBJECT then begin
      BaseObject_34.SendMsg(BaseObject_34, RM_STRUCK, n20, BaseObject_34.m_WAbil.HP, BaseObject_34.m_WAbil.MaxHP, Integer(Self), '');
    end;
  end;
  if bo35 then begin
    GetFrontPosition(nX, nY);
    SendRefMsg(RM_RUSHKUNG, m_btDirection, nX, nY, 0, '');
    SysMsg('(Ӣ��) '+sMateDoTooweak {��ײ������������}, BB_Fuchsia, t_Hint);  //20080312
  end;
  if n28 > 0 then begin
    if n24 < 0 then n24 := 0;
    n20 := Random(n24 * 10) + ((n24 + 1) * 3);
    n20 := GetHitStruckDamage(Self, n20);
    StruckDamage(n20);
    SendRefMsg(RM_STRUCK, n20, m_WAbil.HP, m_WAbil.MaxHP, 0, '');
  end;
end;

function THeroObject.ClientSpellXY(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  nSpellPoint: Integer;
  n14: Integer;
  BaseObject: TBaseObject;
  dwCheckTime,dwDelayTime: LongWord;
  boIsWarrSkill: Boolean;
resourcestring
  sDisableMagicCross = '��ǰ��ͼ������ʹ�ã�%s';
begin
  Result := False;
  if not m_boCanSpell then Exit;

  if m_boDeath or ((m_wStatusTimeArr[POISON_STONE] <> 0) and not g_Config.ClientConf.boParalyCanSpell) then Exit;//����
  if m_PEnvir <> nil then begin
    if not m_PEnvir.AllowMagics(UserMagic.MagicInfo.sMagicName) then begin
      SysMsg(Format(sDisableMagicCross, [UserMagic.MagicInfo.sMagicName]), BB_Fuchsia, t_Notice);
      Exit;
    end;
  end;
  boIsWarrSkill := MagicManager.IsWarrSkill(UserMagic.wMagIdx); //�Ƿ���սʿ����

//  if not CheckActionStatus(UserMagic.wMagIdx,dwDelayTime) then Exit;//20080710

  if not boIsWarrSkill then begin
    dwCheckTime := GetTickCount - m_dwMagicAttackTick;
    if dwCheckTime < m_dwMagicAttackInterval then begin
      Inc(m_dwMagicAttackCount);
      dwDelayTime := m_dwMagicAttackInterval - dwCheckTime;
      if dwDelayTime > g_Config.dwHeroMagicHitIntervalTime div 3 then begin
        if m_dwMagicAttackCount >= 2 then begin
          m_dwMagicAttackTick := GetTickCount();
          m_dwMagicAttackCount := 0;
        end else m_dwMagicAttackCount := 0;
        Exit;
      end else Exit;
    end;
  end;    

  Dec(m_nSpellTick, 450);
  m_nSpellTick := _MAX(0, m_nSpellTick);

  if boIsWarrSkill then begin
    //m_dwMagicAttackInterval:=0;
    m_dwMagicAttackInterval:= UserMagic.MagicInfo.dwDelayTime {+ g_Config.dwHeroMagicHitIntervalTime}; //20080524 ħ�����
  end else begin
    m_dwMagicAttackInterval := UserMagic.MagicInfo.dwDelayTime + g_Config.dwHeroMagicHitIntervalTime ;//20080524
  end;
  if GetTickCount - m_dwMagicAttackTick > m_dwMagicAttackInterval then begin//20080222 Ӣ��ħ�����
  m_dwMagicAttackTick := GetTickCount();
  case UserMagic.wMagIdx of //
   SKILL_YEDO{7}:begin //��ɱ����  20071213����
        if m_MagicPowerHitSkill <> nil then begin
          if m_boPowerHit then begin
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                HealthSpellChanged();
              end;
              //SendSocket(nil, '+FIR');
            end;
          end;
        end;
        Result := True;
      end;      
    SKILL_ERGUM {12}: begin //��ɱ����
        if m_MagicErgumSkill <> nil then begin
          if not m_boUseThrusting then begin
            ThrustingOnOff(True);
            //SendSocket(nil, '+LNG');
          end else begin
            ThrustingOnOff(False);
            //SendSocket(nil, '+ULNG');
          end;
        end;
        Result := True;
      end;
    SKILL_BANWOL {25}: begin //�����䵶
        if m_MagicBanwolSkill <> nil then begin
          if not m_boUseHalfMoon then begin
            HalfMoonOnOff(True);
            //SendSocket(nil, '+WID');
          end else begin
            HalfMoonOnOff(False);
            //SendSocket(nil, '+UWID');
          end;
        end;
        Result := True;
      end;
    SKILL_FIRESWORD {26}: begin //�һ𽣷�
        if m_MagicFireSwordSkill <> nil then begin
          if AllowFireHitSkill then begin
            nSpellPoint := GetSpellPoint(UserMagic);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                HealthSpellChanged();
              end;
              //SendSocket(nil, '+FIR');
            end;
          end;
        end;
        Result := True;
      end;
    SKILL_74 :begin////���ս��� 20080511
        if m_Magic74Skill <> nil then begin
          if AllowDailySkill then begin
            nSpellPoint := GetSpellPoint(m_Magic74Skill);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                //HealthSpellChanged();
              end;
            end;
          end;
        end;
        Result := True;
      end;
    SKILL_MOOTEBO {27}: begin //Ұ����ײ
        Result := True;
        if (GetTickCount - m_dwDoMotaeboTick) > {3 * 1000}3000 then begin
          m_dwDoMotaeboTick := GetTickCount();
         // m_btDirection := TargeTBaseObject.m_btDirection{nTargetX};//20080409 �޸�Ұ����ײ�ķ���
         if GetAttackDir(TargeTBaseObject,m_btDirection) then begin//20080409 �޸�Ұ����ײ�ķ���
           nSpellPoint := GetSpellPoint(UserMagic);
           if m_WAbil.MP >= nSpellPoint then begin
             if nSpellPoint > 0 then begin
               DamageSpell(nSpellPoint);
               HealthSpellChanged();
             end;
             if DoMotaebo(m_btDirection, UserMagic.btLevel) then begin
               if UserMagic.btLevel < 3 then begin
                 if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] < m_Abil.Level then begin
                   TrainSkill(UserMagic, Random(3) + 1);
                   if not CheckMagicLevelup(UserMagic) then begin
                     SendDelayMsg(Self,RM_HEROMAGIC_LVEXP,0,UserMagic.MagicInfo.wMagicId, UserMagic.btLevel,UserMagic.nTranPoint,'', 1000);
                   end;
                 end;
               end;
             end;
           end;
         end;
        end;
      end;
    SKILL_40: begin //˫��ն ���µ���
        if m_MagicCrsSkill <> nil then begin
          if not m_boCrsHitkill then begin
            SkillCrsOnOff(True);
            //SendSocket(nil, '+CRS');
          end else begin
            SkillCrsOnOff(False);
            //SendSocket(nil, '+UCRS');
          end;
        end;
        Result := True;
      end;
    43: begin //����ն
        if m_Magic42Skill <> nil then begin
          if Skill42OnOff then begin
            nSpellPoint := GetSpellPoint(UserMagic);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                HealthSpellChanged();
              end;
             // SendSocket(nil, '+TWN');
            end;
          end;
        end;
        Result := True;
      end;
    42: begin //��Ӱ����
        if m_Magic43Skill <> nil then begin
          if Skill43OnOff then begin//20080619
            nSpellPoint := GetSpellPoint(UserMagic);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                HealthSpellChanged();
              end;
            end;
          end;
        end;
        Result := True;
     end;
  else begin
      n14 := GetNextDirection(m_nCurrX, m_nCurrY, nTargetX, nTargetY);
      m_btDirection := n14;
      BaseObject := nil;

      //���Ŀ���ɫ����Ŀ��������Χ���������Χ��������Ŀ������
      {if UserMagic.wMagIdx in [60..65] then begin //����Ǻϻ�����Ŀ��
        if CretInNearXY(TargeTBaseObject, nTargetX, nTargetY, 12) then begin//20080406
          BaseObject := TargeTBaseObject;
          nTargetX := BaseObject.m_nCurrX;
          nTargetY := BaseObject.m_nCurrY;
          if m_Master <> nil then TPlayObject(m_Master).DoSpell(UserMagic, nTargetX, nTargetY, BaseObject);//�ϻ����˹��� 20080522
        end;
      end else begin
       if CretInNearXY(TargeTBaseObject, nTargetX, nTargetY) then begin//20080419 ע��
          BaseObject := TargeTBaseObject;
          nTargetX := BaseObject.m_nCurrX;
          nTargetY := BaseObject.m_nCurrY;
        end;
      end;}
      case UserMagic.wMagIdx of//20080814 �޸�
        60..65: begin
            if ((m_wStatusTimeArr[POISON_STONE] = 0) and (m_Master.m_wStatusTimeArr[POISON_STONE] = 0))
              or g_Config.ClientConf.boParalyCanSpell then begin//20080913 ��Բ��ܺϻ�
              if CretInNearXY(TargeTBaseObject, nTargetX, nTargetY, 12) then begin//20080406
                BaseObject := TargeTBaseObject;
                nTargetX := BaseObject.m_nCurrX;
                nTargetY := BaseObject.m_nCurrY;
                if m_Master <> nil then TPlayObject(m_Master).DoSpell(UserMagic, nTargetX, nTargetY, BaseObject);//�ϻ����˹��� 20080522
              end;
            end else Exit;
          end;
        else begin
           if CretInNearXY(TargeTBaseObject, nTargetX, nTargetY) then begin//20080419 ע��
              BaseObject := TargeTBaseObject;
              nTargetX := BaseObject.m_nCurrX;
              nTargetY := BaseObject.m_nCurrY;
            end;
        end;
      end;//case

      if not DoSpell(UserMagic, nTargetX, nTargetY, BaseObject) then begin
        SendRefMsg(RM_MAGICFIREFAIL, 0, 0, 0, 0, '');//20080216 �������Ӣ�ۻ���ʧ 20080407
      end;
      Result := True;
    end;
  end;
  end;//20080222  Ӣ��ħ�����
end;

function THeroObject.DoSpell(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; BaseObject: TBaseObject): Boolean;
var
  boTrain: Boolean;
  nSpellPoint: Integer;
  boSpellFail: Boolean;
  boSpellFire: Boolean;
  nPower: Integer;
  nAmuletIdx: Integer;
  nPowerRate: Integer;
  nDelayTime: Integer;
  nDelayTimeRate: Integer;
  dwDelayTime: LongWord;//20080718
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
  function GetPower13(nInt: Integer): Integer;
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := Round(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
  end;
  procedure sub_4934B4(PlayObject: TBaseObject);
  begin
    if PlayObject.m_UseItems[U_ARMRINGL].Dura < 100 then begin
      PlayObject.m_UseItems[U_ARMRINGL].Dura := 0;
      if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
        THeroObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
      end;
      PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
    end;
  end;
begin
  Result := False;
  boSpellFail := False;
  boSpellFire := True;
  nSpellPoint := GetSpellPoint(UserMagic); //��Ҫ��ħ��ֵ
  if (nSpellPoint > 0) and (UserMagic.wMagIdx <> 68) then begin //��� ��Ҫ��ħ��ֵ >0  �������岻�ڴ˴���HP 20080925
    if m_WAbil.MP < nSpellPoint then Exit;//���ħ��ֵ С�� ��Ҫ��ħ��ֵ ��ô�˳�
    DamageSpell(nSpellPoint);//��Ӣ�� ���� nSpellPoint mp
    HealthSpellChanged();
  end;
  if m_boTrainingNG then begin//20081003 ѧ���ڹ��ķ�,ÿ����һ�μ�һ������ֵ
    m_Skill69NH := _MAX(0, m_Skill69NH - g_Config.nHitStruckDecNH);
    SendREFMsg( RM_MAGIC69SKILLNH, 0, m_Skill69NH, m_Skill69MaxNH, 0, '');
  end;

  try
    if BaseObject <> nil then  //20080215 �޸�,
      if (BaseObject.m_boGhost) or (BaseObject.m_boDeath) or (BaseObject.m_WAbil.HP <=0) then Exit;//20080428 �޸�
    if MagicManager.IsWarrSkill(UserMagic.wMagIdx) then Exit;
    if (abs(m_nCurrX - nTargetX) > g_Config.nMagicAttackRage) or (abs(m_nCurrY - nTargetY) > g_Config.nMagicAttackRage) then begin
      Exit;
    end;

    if (not CheckActionStatus(UserMagic.MagicInfo.wMagicId,dwDelayTime)) {or (GetSpellMsgCount > 0 )} then Exit;//20080720

    if (m_btJob = 0) and (UserMagic.MagicInfo.wMagicId = 61) then begin //20080604 ����նսʿЧ��
      m_btDirection:= GetNextDirection(m_nCurrX, m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);//20080611
      SendRefMsg(RM_MYSHOW, 5,0, 0, 0, ''); //����սʿ������ 20080611
      SendAttackMsg(RM_PIXINGHIT, m_btDirection, m_nCurrX, m_nCurrY);//20080611
    end else
    if (m_btJob = 0) and (UserMagic.MagicInfo.wMagicId = 62) then begin //20080611 ����һ��սʿЧ��
       m_btDirection:= GetNextDirection(m_nCurrX, m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);//20080611
       SendAttackMsg(RM_LEITINGHIT, m_btDirection, m_nCurrX, m_nCurrY);
    end else begin
      case UserMagic.MagicInfo.wMagicId of //4�����ܷ���ͬ����Ϣ
       13:begin
           if (UserMagic.btLevel = 4) and (m_nLoyal >=g_Config.nGotoLV4)  then //4�����
              SendRefMsg(RM_SPELL, 100, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '')
           else
              SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
         end;
       26:;
       45:begin
          if (UserMagic.btLevel = 4) and (m_nLoyal >=g_Config.nGotoLV4)  then
            SendRefMsg(RM_SPELL, 101, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '')
          else SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
         end;
       else//0..12,14..25,27..44,46..100: //20080324
       SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
      end;
    end;

    if (BaseObject <> nil) and (UserMagic.MagicInfo.wMagicId <> SKILL_57) and (UserMagic.MagicInfo.wMagicId <> SKILL_54) and (UserMagic.MagicInfo.wMagicId < 100) then begin
      if (BaseObject.m_boDeath) then BaseObject := nil;
    end;
    boTrain := False;
    boSpellFail := False;
    boSpellFire := True;
    case UserMagic.MagicInfo.wMagicId of //
      SKILL_FIREBALL {1},
        SKILL_FIREBALL2 {5}: begin //������ �����
          if MagicManager.MagMakeFireball(self,
            UserMagic,
            nTargetX,
            nTargetY,
            BaseObject) then boTrain := True;
        end;
      SKILL_HEALLING {2}: begin //������
          if MagicManager.MagTreatment(self,
            UserMagic,
            nTargetX,
            nTargetY,
            BaseObject) then boTrain := True;
        end;
      SKILL_AMYOUNSUL {6}: begin //ʩ����
          if MagicManager.MagLightening(self, UserMagic, nTargetX, nTargetY, BaseObject, boSpellFail) then
            boTrain := True;
        end;
      SKILL_FIREWIND {8}: begin //���ܻ�
          if MagicManager.MagPushArround(self, UserMagic.btLevel) > 0 then boTrain := True;
        end;
      SKILL_FIRE {9}: begin //������
          if MagicManager.MagMakeHellFire(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_SHOOTLIGHTEN {10}: begin //�����Ӱ
          if MagicManager.MagMakeQuickLighting(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_LIGHTENING {11}: begin //�׵���
          if MagicManager.MagMakeLighting(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_FIRECHARM {13},
      SKILL_HANGMAJINBUB {14},
      SKILL_DEJIWONHO {15},
      SKILL_HOLYSHIELD {16},
      SKILL_SKELLETON {17},
      SKILL_CLOAK {18},
      SKILL_BIGCLOAK {19},
      SKILL_52{52}, 
      SKILL_57,
      SKILL_59: begin
          boSpellFail := True;
          if CheckAmulet(self, 1, 1, nAmuletIdx) then begin
            UseAmulet(self, 1, 1, nAmuletIdx);
            case UserMagic.MagicInfo.wMagicId of //
              SKILL_FIRECHARM {13}: begin //�����
                  if MagicManager.MagMakeFireCharm(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
                end;
              SKILL_HANGMAJINBUB {14}: begin //�����
                  nPower := GetAttackPower(GetPower13(60) + LoWord(m_WAbil.SC) * 10, SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
                  if MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 1) > 0 then boTrain := True;
                end;
              SKILL_DEJIWONHO {15}: begin //��ʥս����
                  nPower := GetAttackPower(GetPower13(60) + LoWord(m_WAbil.SC) * 10, SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
                  if MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 0) > 0 then boTrain := True;
                end;
              SKILL_HOLYSHIELD {16}: begin //��ħ��
                  if MagicManager.MagMakeHolyCurtain(self, GetPower13(40) + GetRPow(m_WAbil.SC) * 3, nTargetX, nTargetY) > 0 then boTrain := True;
                end;
              SKILL_SKELLETON {17}: begin //�ٻ�����
                  if MagicManager.MagMakeSlave(self, UserMagic) then  boTrain := True;
                end;
              SKILL_CLOAK {18}: begin //������
                  if MagicManager.MagMakePrivateTransparent(self, GetPower13(30) + GetRPow(m_WAbil.SC) * 3) then
                    boTrain := True;
                end;
              SKILL_BIGCLOAK {19}: begin //����������
                  if MagicManager.MagMakeGroupTransparent(self, nTargetX, nTargetY, GetPower13(30) + GetRPow(m_WAbil.SC) * 3) then
                    boTrain := True;
                end;
              SKILL_52: begin //������
                  nPower := GetAttackPower(GetPower13(20) + LoWord(m_WAbil.SC) * 2, SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
                  if MagMakeAbilityArea(nTargetX, nTargetY, 3, nPower) > 0 then boTrain := True;
                end;
              SKILL_57: begin //������
                  if MagicManager.MagMakeLivePlayObject(self, UserMagic, BaseObject) then boTrain := True;
                end;
              SKILL_59: begin//��Ѫ�� 20080511
                  if MagicManager.MagFireCharmTreatment(self,UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
                end;
            end;
            boSpellFail := False;
            sub_4934B4(self);
          end;
        end;
      SKILL_TAMMING {20}: begin //�ջ�֮��
          if IsProperTarget(BaseObject) then begin
            if MagicManager.MagTamming(self, BaseObject, nTargetX, nTargetY, UserMagic.btLevel) then boTrain := True;
          end;
        end;
      SKILL_SPACEMOVE {21}: begin //˲Ϣ�ƶ�
          SendRefMsg(RM_MAGICFIRE, 0, MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect), MakeLong(nTargetX, nTargetY), Integer(BaseObject), '');
          boSpellFire := False;
          if MagicManager.MagSaceMove(self, UserMagic.btLevel) then boTrain := True;
        end;
      SKILL_EARTHFIRE {22}: begin //��ǽ
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
          nDelayTime := GetPower(10) + (Word(GetRPow(m_WAbil.MC)) shr 1);
          nPowerRate := Round(nPower * (g_Config.nFirePowerRate / 100));//��ǽ��������
          nDelayTimeRate := Round(nDelayTime * (g_Config.nFireDelayTimeRate / 100));//��ǽʱ��
          if MagicManager.MagMakeFireCross(self, nPowerRate, nDelayTimeRate, nTargetX, nTargetY) > 0 then boTrain := True;
        end;
      SKILL_FIREBOOM {23}: begin //���ѻ���
          if MagicManager.MagBigExplosion(self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX, nTargetY, g_Config.nFireBoomRage {1},SKILL_FIREBOOM) then boTrain := True;
        end;
      SKILL_LIGHTFLOWER {24}: begin //�����׹�
          if MagicManager.MagElecBlizzard(self, GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1)) then boTrain := True;
        end;
      SKILL_SHOWHP {28}: begin//������ʾ
          if (BaseObject <> nil) and not BaseObject.m_boShowHP then begin
            if Random(6) <= (UserMagic.btLevel + 3) then begin
              BaseObject.m_dwShowHPTick := GetTickCount();
              BaseObject.m_dwShowHPInterval := GetPower13(GetRPow(m_WAbil.SC) * 2 + 30) * 1000;
              BaseObject.SendDelayMsg(BaseObject, RM_DOOPENHEALTH, 0, 0, 0, 0, '', 1500);
              boTrain := True;
            end;
          end;
        end;
      SKILL_BIGHEALLING {29}: begin //Ⱥ��������
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC) * 2,
            SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) * 2 + 1);
          if MagicManager.MagBigHealing(self, nPower + m_WAbil.Level, nTargetX, nTargetY) then boTrain := True;
        end;
      SKILL_SINSU {30}: begin  //�ٻ�����
          boSpellFail := True;
          if CheckAmulet(self, 5, 1, nAmuletIdx) then begin
            UseAmulet(self, 5, 1, nAmuletIdx);
            if MagicManager.MagMakeSinSuSlave(self, UserMagic) then boTrain := True;
            boSpellFail := False;
          end;
        end;
      SKILL_SHIELD {31},SKILL_66{66}: begin //ħ����,4��ħ���� 20080624
          if MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(m_WAbil.MC) + 15)) then boTrain := True;
        end;
      SKILL_73 {73}: begin //������  20080301
          if MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(m_WAbil.SC) + 15)) then boTrain := True;
        end;
      SKILL_75 {75}: begin //������� 20080107
            if (GetTickCount - m_boProtectionTick > g_Config.dwProtectionTick) then begin
              if MagProtectionDefenceUp(UserMagic.btLevel) then begin
                boTrain := True;
              end;
            end else Exit;
        end;
      SKILL_KILLUNDEAD {32}: begin //ʥ����
          if IsProperTarget(BaseObject) then begin
            if MagicManager.MagTurnUndead(self, BaseObject, nTargetX, nTargetY, UserMagic.btLevel) then boTrain := True;
          end;
        end;
      SKILL_SNOWWIND {33}: begin //������
          if MagicManager.MagBigExplosion(self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX, nTargetY, g_Config.nSnowWindRange {1},SKILL_SNOWWIND) then boTrain := True;
        end;
      SKILL_UNAMYOUNSUL {34}: begin //�ⶾ��
          if MagicManager.MagMakeUnTreatment(self,UserMagic,nTargetX,nTargetY,BaseObject) then boTrain := True;
        end;
      SKILL_WINDTEBO {35}: if MagicManager.MagWindTebo(self, UserMagic) then boTrain := True;
      SKILL_MABE {36}: begin //�����
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
          if MagicManager.MabMabe(self, BaseObject, nPower, UserMagic.btLevel, nTargetX, nTargetY) then boTrain := True;
        end;
      SKILL_GROUPLIGHTENING {37}: begin//Ⱥ���׵���
          if MagicManager.MagGroupLightening(self, UserMagic, nTargetX, nTargetY, BaseObject, boSpellFire) then boTrain := True;
        end;
      SKILL_GROUPAMYOUNSUL {38}: begin//Ⱥ��ʩ����
          if MagicManager.MagGroupAmyounsul(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_GROUPDEDING {39}: begin//�ض�
          if GetTickCount - m_dwDedingUseTick > g_Config.nDedingUseTime * 1000 then begin
            m_dwDedingUseTick := GetTickCount;
            if MagicManager.MagGroupDeDing(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
          end;
        end;
      SKILL_41: begin //ʨ�Ӻ�
          if MagicManager.MagGroupMb(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_42: begin //����ն
          if MagicManager.MagHbFireBall(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_43: begin //��Ӱ����
          if MagicManager.MagHbFireBall(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_44: begin //������
          if MagicManager.MagHbFireBall(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_45: begin //�����
          if MagicManager.MagMakeFireDay(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
         // boSpellFire:=False;//20080113
        end;
      SKILL_46: begin //������
          if MagicManager.MagMakeSelf(self, BaseObject, UserMagic) then  boTrain := True;
        end;
      SKILL_47: begin //��������
          if MagicManager.MagBigExplosion(self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX, nTargetY, g_Config.nFireBoomRage {1},SKILL_47) then boTrain := True;
        end;
      SKILL_58: begin //���ǻ��� 20080510
          if MagicManager.MagBigExplosion1(self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX, nTargetY, g_Config.nMeteorFireRainRage) then boTrain := True;
        end;
      //��ʿ
      SKILL_48: begin //������
          if MagicManager.MagPushArround(self, UserMagic.btLevel) > 0 then boTrain := True;
        end;
      SKILL_49: begin //������
          boTrain := True;
        end;
      SKILL_50: begin //�޼�����
          if AbilityUp(UserMagic) then boTrain := True;
        end;
      SKILL_51: begin //쫷���
          if MagicManager.MagGroupFengPo(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_53: begin //Ѫ��
          boTrain := True;
        end;
      SKILL_54: begin //������
          if IsProperTargetSKILL_54(BaseObject) then begin
            if MagicManager.MagTamming2(self, BaseObject, nTargetX, nTargetY, UserMagic.btLevel) then boTrain := True;
          end;
        end;
      SKILL_55: begin //������
          if MagicManager.MagMakeArrestObject(self, UserMagic, BaseObject) then boTrain := True;
        end;
      SKILL_56: begin //���л�λ
          if MagicManager.MagChangePosition(self, nTargetX, nTargetY) then boTrain := True;
        end;
      SKILL_68: begin//Ӣ�۾������� 20080925
          MagMakeHPUp(UserMagic);
          boTrain := False;
        end;
      SKILL_72: begin //�ٻ�����
          if CheckAmulet(self, 5, 1, nAmuletIdx) then begin
             UseAmulet(self, 5, 1, nAmuletIdx);
             if MagicManager.MagMakeFairy(self, UserMagic) then boTrain := True;
          end;
        end;
      SKILL_60: begin  //�ƻ�ն  ս+ս
          if MagicManager.MagMakeSkillFire_60(self, UserMagic,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1) * 3) then boTrain := True;
        end;
      SKILL_61: begin //����ն  ս+��
          if MagicManager.MagMakeSkillFire_61(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_62: begin//����һ��  ս+��
          if MagicManager.MagMakeSkillFire_62(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
          //if m_btJob = 1 then boSpellFire := False;//20080611
        end;
      SKILL_63: begin //�ɻ�����  ��+��
          if MagicManager.MagMakeSkillFire_63(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_64: begin //ĩ������  ��+��
          if MagicManager.MagMakeSkillFire_64(self, UserMagic, nTargetX, nTargetY, BaseObject) then boTrain := True;
        end;
      SKILL_65: begin //��������  ��+��
          if MagicManager.MagMakeSkillFire_65(self, GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1)) then
            boTrain := True;
        end;
    else begin
        if Assigned(zPlugOfEngine.SetHookDoSpell) then
          boTrain := zPlugOfEngine.SetHookDoSpell(MagicManager{Self}, TPlayObject(self), UserMagic, nTargetX, nTargetY, BaseObject, boSpellFail, boSpellFire);
      end;
    end;

    m_dwActionTick := GetTickCount();//20080713
    m_dwHitTick := GetTickCount();//20080713
    m_nSelectMagic := 0;
    m_boIsUseMagic := True;//�Ƿ��ܶ�� 20080714

    if boSpellFail then Exit;
    if boSpellFire then begin //20080111 ��4���ټ��ܲ�����Ϣ
      try
        case UserMagic.MagicInfo.wMagicId of //20080113 ��4���ټ��ܲ�����Ϣ      20080227 �޸�
          13:begin
             if (UserMagic.btLevel = 4) and (m_nLoyal >=g_Config.nGotoLV4) then //4����� 20080111
               SendRefMsg(RM_MAGICFIRE, 0,MakeWord(UserMagic.MagicInfo.btEffectType,100),MakeLong(nTargetX, nTargetY),Integer(BaseObject),'')
             else SendRefMsg(RM_MAGICFIRE, 0,MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect), MakeLong(nTargetX, nTargetY),Integer(BaseObject),'');
           end;
          26:;
          45:begin
              if (UserMagic.btLevel = 4) and (m_nLoyal >=g_Config.nGotoLV4) then // 20080227 �޸�
                SendRefMsg(RM_MAGICFIRE, 0,MakeWord(UserMagic.MagicInfo.btEffectType,101),MakeLong(nTargetX, nTargetY),Integer(BaseObject),'')
              else SendRefMsg(RM_MAGICFIRE, 0,MakeWord(UserMagic.MagicInfo.btEffectType,UserMagic.MagicInfo.btEffect), MakeLong(nTargetX, nTargetY),Integer(BaseObject),'');
           end;
          else//0..12,14..25,27..44,46..100://20080324
            SendRefMsg(RM_MAGICFIRE, 0,MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect), MakeLong(nTargetX, nTargetY),Integer(BaseObject),'');
        end;//Case
      except
      end;
    end;

    if (UserMagic.btLevel < 3) and (boTrain) then begin//���ܼ���������
      if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <= m_Abil.Level then begin
        TrainSkill(UserMagic, Random(3) + 1);
        if not CheckMagicLevelup(UserMagic) then begin
          SendDelayMsg(self, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 1000);
        end;
      end;
    end;
    Result := True;
  except
    on E: Exception do begin
      MainOutMessage(Format('{�쳣} THeroObject.DoSpell MagID:%d X:%d Y:%d', [UserMagic.wMagIdx, nTargetX, nTargetY]));
    end;
  end;
end;

procedure THeroObject.MakeSaveRcd(var HumanRcd: THumDataInfo);
var
  I, J, K: Integer;
  HumData: pTHumData;
  HumItems: pTHumItems;
  HumAddItems: pTHumAddItems;
  BagItems: pTBagItems;
  HumMagics: pTHumMagics;
  HumNGMagics: pTHumNGMagics;//20081001
  UserMagic: pTUserMagic;
  nCode: Byte;//20081018
begin
  nCode:= 0;
  Try
    HumanRcd.Header.boIsHero := True;
    HumData := @HumanRcd.Data;
    HumData.sChrName := m_sCharName;
    HumData.sCurMap := m_sMapName;
    HumData.wCurX := m_nCurrX;
    HumData.wCurY := m_nCurrY;
    HumData.btDir := m_btDirection;
    HumData.btHair := m_btHair;
    HumData.btSex := m_btGender;
    HumData.btJob := m_btJob;
    HumData.nGold := m_nFirDragonPoint;//�����������������ŭ��ֵ 20080419
    nCode:= 1;
    HumData.Abil.Level := m_Abil.Level;
    HumData.Abil.HP := m_Abil.HP;
    HumData.Abil.MP := m_Abil.MP;
    HumData.Abil.MaxHP := m_Abil.MaxHP;
    HumData.Abil.MaxMP := m_Abil.MaxMP;
    HumData.Abil.Exp := m_Abil.Exp;
    HumData.Abil.MaxExp := m_Abil.MaxExp;
    HumData.Abil.Weight := m_Abil.Weight;
    HumData.Abil.MaxWeight := m_Abil.MaxWeight;
    HumData.Abil.WearWeight := m_Abil.WearWeight;
    HumData.Abil.MaxWearWeight := m_Abil.MaxWearWeight;
    HumData.Abil.HandWeight := m_Abil.HandWeight;
    HumData.Abil.MaxHandWeight := m_Abil.MaxHandWeight;
    nCode:= 2;
    HumData.Abil.NG := m_Skill69NH;//�ڹ���ǰ����ֵ 20080930
    HumData.Abil.MaxNG := m_Skill69MaxNH;//����ֵ���� 20081001
    nCode:= 3;
    HumData.n_Reserved:= m_Abil.Alcohol;//���� 20080622
    HumData.n_Reserved1:= m_Abil.MaxAlcohol;//�������� 20080622
    HumData.n_Reserved2 := m_Abil.WineDrinkValue;//��ƶ� 2008623
    HumData.btUnKnow2[2] := n_DrinkWineQuality;//����ʱ�Ƶ�Ʒ��
    HumData.UnKnow[4] := n_DrinkWineAlcohol;//����ʱ�ƵĶ��� 20080624
    HumData.UnKnow[5] := m_btMagBubbleDefenceLevel;//ħ���ܵȼ� 20080811
    nCode:= 4;
    HumData.nReserved1:= m_Abil.MedicineValue;//��ǰҩ��ֵ 20080623
    HumData.nReserved2:= m_Abil.MaxMedicineValue;//ҩ��ֵ���� 20080623
    HumData.boReserved3:= n_DrinkWineDrunk;//���Ƿ�Ⱦ����� 20080627
    HumData.nReserved3:= dw_UseMedicineTime;//ʹ��ҩ��ʱ��,���㳤ʱ��ûʹ��ҩ�� 20080623
    HumData.n_Reserved3:= n_MedicineLevel;//ҩ��ֵ�ȼ� 20080623

    HumData.Abil.HP := m_WAbil.HP;
    HumData.Abil.MP := m_WAbil.MP;

    HumData.Exp68:= m_Exp68;//�������嵱ǰ���� 20080925
    HumData.MaxExp68:= m_MaxExp68;//���������������� 20080925
    nCode:= 5;
    HumData.UnKnow[6] := Integer(m_boTrainingNG);//�Ƿ�ѧϰ���ڹ� 20081002
    if m_boTrainingNG then HumData.UnKnow[7] := m_NGLevel//�ڹ��ȼ� 20081204
    else HumData.UnKnow[7] := 0;
    HumData.nExpSkill69 := m_ExpSkill69;//�ڹ���ǰ���� 20080930
    nCode:= 6;
    HumData.wStatusTimeArr := m_wStatusTimeArr;
    nCode:= 13;
    HumData.sHomeMap := m_sHomeMap;
    HumData.wHomeX := m_nHomeX;
    HumData.wHomeY := m_nHomeY;
    HumData.nPKPOINT := m_nPkPoint;
    nCode:= 14;
    HumData.BonusAbil := m_BonusAbil;//20081126 Ӣ����������
    HumData.nBonusPoint := m_nBonusPoint; // 08/09
    HumData.btCreditPoint := m_btCreditPoint;
    HumData.btReLevel := m_btReLevel;
    HumData.nLoyal:= m_nLoyal; //Ӣ�۵��ҳ϶�(20080110)
    nCode:= 15;
    if m_Master <> nil then HumData.sMasterName := m_Master.m_sCharName;//20081024 �����ж�
    nCode:= 7;
    HumData.btAttatckMode := m_btAttatckMode;
    HumData.btIncHealth := m_nIncHealth;
    HumData.btIncSpell := m_nIncSpell;
    HumData.btIncHealing := m_nIncHealing;
    HumData.btFightZoneDieCount := m_nFightZoneDieCount;
    //HumData.sAccount := m_sUserID;
    nCode:= 8;
    HumData.btEF := n_HeroTpye;//Ӣ������ 0-������Ӣ�� 1-����Ӣ�� 20080514
    HumData.dBodyLuck := m_dBodyLuck;
    HumData.btLastOutStatus := m_btLastOutStatus; //2006-01-12���� �˳�״̬ 1Ϊ�����˳�
    HumData.QuestFlag := m_QuestFlag;
    HumData.boHasHero := False;
    HumData.boIsHero := True; //20080118
    HumData.btStatus := m_btStatus;//����Ӣ�۵�״̬ 20080717
    nCode:= 9;
    HumItems := @HumanRcd.Data.HumItems;
    HumItems[U_DRESS] := m_UseItems[U_DRESS];
    HumItems[U_WEAPON] := m_UseItems[U_WEAPON];
    HumItems[U_RIGHTHAND] := m_UseItems[U_RIGHTHAND];
    HumItems[U_HELMET] := m_UseItems[U_NECKLACE];
    HumItems[U_NECKLACE] := m_UseItems[U_HELMET];
    HumItems[U_ARMRINGL] := m_UseItems[U_ARMRINGL];
    HumItems[U_ARMRINGR] := m_UseItems[U_ARMRINGR];
    HumItems[U_RINGL] := m_UseItems[U_RINGL];
    HumItems[U_RINGR] := m_UseItems[U_RINGR];
    nCode:= 10;
    HumAddItems := @HumanRcd.Data.HumAddItems;
    HumAddItems[U_BUJUK] := m_UseItems[U_BUJUK];
    HumAddItems[U_BELT] := m_UseItems[U_BELT];
    HumAddItems[U_BOOTS] := m_UseItems[U_BOOTS];
    HumAddItems[U_CHARM] := m_UseItems[U_CHARM];
    HumAddItems[U_ZHULI] := m_UseItems[U_ZHULI];//20080416 ����
    nCode:= 11;
    BagItems := @HumanRcd.Data.BagItems;
    for I := 0 to m_ItemList.Count - 1 do begin
      if I >= MAXHEROBAGITEM then Break;
      if pTUserItem(m_ItemList.Items[I]).wIndex = 0 then Continue;//20080915 IDΪ0����Ʒ�򲻱���
      BagItems[I] := pTUserItem(m_ItemList.Items[I])^;
    end;
    nCode:= 12; 
    HumMagics := @HumanRcd.Data.HumMagics;
    HumNGMagics:= @HumanRcd.Data.HumNGMagics;//20081001 �ڹ�����
    if m_MagicList.Count > 0 then begin
      J:= 0;
      K:= 0;
      for I := 0 to m_MagicList.Count - 1 do begin
        UserMagic := m_MagicList.Items[I];
        if (UserMagic.MagicInfo.sDescr <> '�ڹ�') then begin
          if J >= MAXMAGIC then Continue{Break};
          HumMagics[J].wMagIdx := UserMagic.wMagIdx;
          HumMagics[J].btLevel := UserMagic.btLevel;
          HumMagics[J].btKey := UserMagic.btKey;
          HumMagics[J].nTranPoint := UserMagic.nTranPoint;
          Inc(J);
        end else begin
          if K >= MAXMAGIC then Continue{Break};
          HumNGMagics[K].wMagIdx := UserMagic.wMagIdx;
          HumNGMagics[K].btLevel := UserMagic.btLevel;
          HumNGMagics[K].btKey := UserMagic.btKey;
          HumNGMagics[K].nTranPoint := UserMagic.nTranPoint;
          Inc(K);
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} THeroObject.MakeSaveRcd Code:'+inttostr(nCode));
  end;
end;
//Ӣ�۵�¼ 20080320
procedure THeroObject.Login();
var
  I: Integer;
  II: Integer;
  UserItem: pTUserItem;
  UserItem1: pTUserItem;
  StdItem: pTStdItem;
  s14: string;
  sItem: string;
resourcestring
  sExceptionMsg = '{�쳣} THeroObject::Login';
begin
  try
    //����������������Ʒ
    if m_boNewHuman then begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sHeroBasicDrug, UserItem) then begin
        m_ItemList.Add(UserItem);
      end else Dispose(UserItem);
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sHeroWoodenSword, UserItem) then begin
        m_ItemList.Add(UserItem);
      end else Dispose(UserItem);
      New(UserItem);
      if m_btGender = 0 then
        sItem := g_Config.sHeroClothsMan
      else
        sItem := g_Config.sHeroClothsWoman;
      if UserEngine.CopyToUserItemFromName(sItem, UserItem) then begin
        m_ItemList.Add(UserItem);
      end else Dispose(UserItem);
    end;

    //��鱳���е���Ʒ�Ƿ�Ϸ�
    for I := m_ItemList.Count - 1 downto 0 do begin
      if m_ItemList.Count <= 0 then Break;
      UserItem := m_ItemList.Items[I];                        //20080813 ���ӣ��ж�����ID�Ƿ�Ϊ����
      if (UserEngine.GetStdItemName(UserItem.wIndex) = '') or (UserItem.MakeIndex < 0) or
        CheckIsOKItem(UserItem, 0) then begin//����̬��Ʒ 20081006
        Dispose(pTUserItem(m_ItemList.Items[I]));
        m_ItemList.Delete(I);
      end;
    end;

    //����������ϵ���Ʒ�Ƿ����ʹ�ù���
    if g_Config.boCheckUserItemPlace then begin
      for I := Low(THumanUseItems) to High(THumanUseItems) do begin
        if m_UseItems[I].wIndex > 0 then begin
          StdItem := UserEngine.GetStdItem(m_UseItems[I].wIndex);
          if StdItem <> nil then begin
            if CheckIsOKItem(@m_UseItems[I], 0) then begin//����̬��Ʒ 20081006
              m_UseItems[I].wIndex := 0;
              Continue;
            end;          
            if not CheckUserItems(I, StdItem) then begin
              New(UserItem);
              FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 ����
              //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 ����
              UserItem^ := m_UseItems[I];
              if not AddItemToBag(UserItem) then begin
                m_ItemList.Insert(0, UserItem);
              end;
              m_UseItems[I].wIndex := 0;
            end;
          end else m_UseItems[I].wIndex := 0;
        end;
      end;
    end;
    //��鱳�����Ƿ��и���Ʒ
    for I := m_ItemList.Count - 1 downto 0 do begin
      if m_ItemList.Count <= 0 then Break;
      UserItem := m_ItemList.Items[I];
      s14 := UserEngine.GetStdItemName(UserItem.wIndex);
      for II := I - 1 downto 0 do begin
        UserItem1 := m_ItemList.Items[II];
        if (UserEngine.GetStdItemName(UserItem1.wIndex) = s14) and
          (UserItem.MakeIndex = UserItem1.MakeIndex) then begin
          m_ItemList.Delete(II);
          Break;
        end;
      end;
    end;    

    for I := Low(m_dwStatusArrTick) to High(m_dwStatusArrTick) do begin
      if m_wStatusTimeArr[I] > 0 then m_dwStatusArrTick[I] := GetTickCount();
    end;

    if m_btLastOutStatus = 1 then begin
       m_WAbil.HP := (m_WAbil.MaxHP div 15)+ 2;//20080404 ��������Ӣ��,ѪҪ���ܵ�
       m_btLastOutStatus := 0;
    end;
   {RecalcLevelAbilitys();
    RecalcAbilitys();
    m_Abil.MaxExp := GetLevelExp(m_Abil.Level);}
    if (g_ManageNPC <> nil) and (m_Master <> nil) then begin
      g_ManageNPC.GotoLable(TPlayObject(m_Master), '@HeroLogin', False);
    end;
    m_boFixedHideMode := False;
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
    end;
  end;
end;

//�жϵ�Ӣ�۶����Ƿ�����,��ʾ�û� 20080401
//���� nType Ϊָ������ 1 Ϊ����� 2 Ϊ��ҩ    nCount Ϊ�־�,������
Function THeroObject.CheckHeroAmulet(nType: Integer; nCount: Integer):Boolean;
var
  I: Integer;
  UserItem: pTUserItem;
  AmuletStdItem: pTStdItem;
begin
  try
  Result:= False;
  if m_UseItems[U_ARMRINGL].wIndex > 0 then begin
    AmuletStdItem := UserEngine.GetStdItem(m_UseItems[U_ARMRINGL].wIndex);
    if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25) then begin
      case nType of
        1: begin
            if (AmuletStdItem.Shape = 5) and (Round(m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
              Result:= True;
              Exit;
            end;
          end;
        2: begin
            if (AmuletStdItem.Shape <= 2) and (Round(m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
              Result:= True;
              Exit;
            end;
          end;
      end;
    end;
  end;

  if m_UseItems[U_BUJUK].wIndex > 0 then begin
    AmuletStdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
    if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25) then begin
      case nType of //
        1: begin//��
            if (AmuletStdItem.Shape = 5) and (Round(m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
              Result:= True;
              Exit;
            end;
          end;
        2: begin//��
            if (AmuletStdItem.Shape <= 2) and (Round(m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
              Result:= True;
              Exit;
            end;
          end;
      end;
    end;
  end;

  //�����������Ƿ���ڶ�,�����
  if m_ItemList.Count > 0 then begin//20080628
    for I := 0 to m_ItemList.Count - 1 do begin //���������Ϊ��
      UserItem := m_ItemList.Items[I];
      AmuletStdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (AmuletStdItem <> nil) and (AmuletStdItem.StdMode = 25) then begin
        case nType of
          1: begin
              if (AmuletStdItem.Shape = 5) and (Round(UserItem.Dura / 100) >= nCount) then begin  //20071227
                Result:= True;
                Exit;
              end;
            end;
          2: begin
              if (AmuletStdItem.Shape <= 2) and (Round(UserItem.Dura / 100) >= nCount) then begin
                Result:= True;
                Exit;
              end;
            end;
        end;//case
      end;
    end;
  end;
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} THeroObject.CheckHeroAmulet');
    end;
  end;
end;

//Ӣ����������  20080423
function THeroObject.LevelUpFunc: Boolean;
begin
  Result := False;
  if (g_FunctionNPC <> nil) and (m_Master <> nil) then begin
    g_FunctionNPC.GotoLable(TPlayObject(m_Master), '@HeroLevelUp', False);
    Result := True;
  end;
end;
//Ӣ��ʹ����Ʒ����  20080728
function THeroObject.UseStdmodeFunItem(StdItem: pTStdItem): Boolean;
begin
  Result := False;
  if (g_FunctionNPC <> nil) and (m_Master <> nil) then begin
    g_FunctionNPC.GotoLable(TPlayObject(m_Master), '@StdModeFunc' + IntToStr(StdItem.AniCount), False);
    Result := True;
  end;
end;

//�ͻ�������ħ������ 20080606
procedure THeroObject.ChangeHeroMagicKey(nSkillIdx, nKey: Integer);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
  if nKey in [0,1] then begin
    if m_MagicList.Count > 0 then begin//20080630
      for I := 0 to m_MagicList.Count - 1 do begin
        UserMagic := m_MagicList.Items[I];
        if UserMagic.MagicInfo.wMagicId = nSkillIdx then begin
          UserMagic.btKey := nKey;
          Break;
        end;
      end;
    end;
  end;
end;

//�������и���Ʒ 20080901
procedure THeroObject.ClearCopyItem(wIndex, MakeIndex: Integer);
var
  I: Integer;
  UserItem: pTUserItem;
begin
  Try
    m_boOperationItemList:= True;//20080928 ��ֹͬʱ���������б�ʱ����
    for I := m_ItemList.Count - 1 downto 0 do begin
      if m_ItemList.Count <= 0 then Break;
      UserItem := m_ItemList.Items[I];
      if (UserItem.wIndex = wIndex) and (UserItem.MakeIndex = MakeIndex) then begin
        SendDelItems(UserItem);
        m_ItemList.Delete(I);
        Break;//20081014 ֻ�ҵ�һ�����˳������Ч��
      end;
    end;
    m_boOperationItemList:= False;//20080928 ��ֹͬʱ���������б�ʱ����
  except
    m_boOperationItemList:= False;//20080928 ��ֹͬʱ���������б�ʱ����
    MainOutMessage('{�쳣} THeroObject.ClearCopyItem');
  end;
end;


//��Ѫʯ���� 20080729
procedure THeroObject.PlaySuperRock;
var
  StdItem: pTStdItem;
  nTempDura: Integer;
begin
  Try
    //��Ѫʯ ħѪʯ                                                                                                  //20080611
    if (not m_boDeath) and (not m_boGhost) and (m_WAbil.HP > 0) then begin
      if (m_UseItems[U_CHARM].wIndex > 0) and (m_UseItems[U_CHARM].Dura > 0) then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[U_CHARM].wIndex);
        if (StdItem <> nil) and (StdItem.Shape > 0) and m_PEnvir.AllowStdItems(StdItem.Name) then begin
          case StdItem.Shape of
            1: begin //��Ѫʯ
                //if m_WAbil.HP <= ((m_WAbil.MaxHP * g_Config.nStartHPRock) div 100) then begin
                if (m_WAbil.MaxHP - m_WAbil.HP) >= g_Config.nStartHPRock then begin//200081215 �ĳɵ���������
                  if GetTickCount - dwRockAddHPTick > g_Config.nHPRockSpell then begin
                    dwRockAddHPTick:= GetTickCount();//��ʯ��HP���
                    if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPRockDecDura then begin
                      Inc(m_WAbil.HP, g_Config.nRockAddHP);
                      nTempDura := m_UseItems[U_CHARM].Dura * 10;
                      Dec(nTempDura, g_Config.nHPRockDecDura);
                      m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                      if m_UseItems[U_CHARM].Dura > 0 then begin
                         SendMsg(self, RM_HERODURACHANGE, U_CHARM, m_UseItems[U_CHARM].Dura, m_UseItems[U_CHARM].DuraMax, 0, '');
                      end else begin
                         SendDelItems(@m_UseItems[U_CHARM]);
                         m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                    end else begin
                      Inc(m_WAbil.HP, g_Config.nRockAddHP);
                      m_UseItems[U_CHARM].Dura := 0;
                      SendDelItems(@m_UseItems[U_CHARM]);
                      m_UseItems[U_CHARM].wIndex:= 0;
                    end;
                    if m_WAbil.HP > m_WAbil.MaxHP then m_WAbil.HP := m_WAbil.MaxHP;
                    PlugHealthSpellChanged();
                  end;
                end;
              end;
            2: begin
                //if m_WAbil.MP <= ((m_WAbil.MaxMP * g_Config.nStartMPRock) div 100) then begin
                if (m_WAbil.MaxMP - m_WAbil.MP) >= g_Config.nStartMPRock then begin//200081215 �ĳɵ���������
                  if GetTickCount - dwRockAddMPTick > g_Config.nMPRockSpell then begin
                    dwRockAddMPTick:= GetTickCount;//��ʯ��MP���
                    if m_UseItems[U_CHARM].Dura * 10 > g_Config.nMPRockDecDura then begin
                      Inc(m_WAbil.MP, g_Config.nRockAddMP);
                      nTempDura := m_UseItems[U_CHARM].Dura * 10;
                      Dec(nTempDura, g_Config.nMPRockDecDura);
                      m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                      if m_UseItems[U_CHARM].Dura > 0 then begin
                         SendMsg(self, RM_HERODURACHANGE, U_CHARM, m_UseItems[U_CHARM].Dura, m_UseItems[U_CHARM].DuraMax, 0, '');
                      end else begin
                         SendDelItems(@m_UseItems[U_CHARM]);
                         m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                    end else begin
                      Inc(m_WAbil.MP, g_Config.nRockAddMP);
                      m_UseItems[U_CHARM].Dura := 0;
                      SendDelItems(@m_UseItems[U_CHARM]);
                      m_UseItems[U_CHARM].wIndex:= 0;
                    end;
                    if m_WAbil.MP > m_WAbil.MaxMP then  m_WAbil.MP:= m_WAbil.MaxMP ;
                    PlugHealthSpellChanged();
                  end;
                end;
              end;
            3: begin 
              //if m_WAbil.HP <= ((m_WAbil.MaxHP * g_Config.nStartHPMPRock) div 100) then begin
              if (m_WAbil.MaxHP - m_WAbil.HP ) >= g_Config.nStartHPMPRock then begin//200081215 �ĳɵ���������
                if GetTickCount - dwRockAddHPTick > g_Config.nHPMPRockSpell then begin
                  dwRockAddHPTick:= GetTickCount;//��ʯ��HP���
                  if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPMPRockDecDura then begin
                    Inc(m_WAbil.HP, g_Config.nRockAddHPMP);
                    nTempDura := m_UseItems[U_CHARM].Dura * 10;
                    Dec(nTempDura, g_Config.nHPMPRockDecDura);
                    m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                    if m_UseItems[U_CHARM].Dura > 0 then begin
                       SendMsg(self, RM_HERODURACHANGE, U_CHARM, m_UseItems[U_CHARM].Dura, m_UseItems[U_CHARM].DuraMax, 0, '');
                    end else begin
                       SendDelItems(@m_UseItems[U_CHARM]);
                       m_UseItems[U_CHARM].wIndex:= 0;
                    end;
                  end else begin
                    Inc(m_WAbil.HP, g_Config.nRockAddHPMP);
                    m_UseItems[U_CHARM].Dura := 0;
                    SendDelItems(@m_UseItems[U_CHARM]);
                    m_UseItems[U_CHARM].wIndex:= 0;
                  end;
                  if m_WAbil.HP > m_WAbil.MaxHP then m_WAbil.HP := m_WAbil.MaxHP;
                  PlugHealthSpellChanged();
                end;
              end;
              //======================================================================
              //if m_WAbil.MP <= ((m_WAbil.MaxMP * g_Config.nStartHPMPRock) div 100) then begin
              if (m_WAbil.MaxMP - m_WAbil.MP ) >= g_Config.nStartHPMPRock then begin//200081215 �ĳɵ���������
                  if GetTickCount - dwRockAddMPTick > g_Config.nHPMPRockSpell then begin
                    dwRockAddMPTick:= GetTickCount;//��ʯ��MP���
                    if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPMPRockDecDura then begin
                      Inc(m_WAbil.MP, g_Config.nRockAddHPMP);
                      nTempDura := m_UseItems[U_CHARM].Dura * 10;
                      Dec(nTempDura, g_Config.nHPMPRockDecDura);
                      m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                      if m_UseItems[U_CHARM].Dura > 0 then begin
                         SendMsg(self, RM_HERODURACHANGE, U_CHARM, m_UseItems[U_CHARM].Dura, m_UseItems[U_CHARM].DuraMax, 0, '');
                      end else begin
                         SendDelItems(@m_UseItems[U_CHARM]);
                         m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                    end else begin
                      Inc(m_WAbil.MP, g_Config.nRockAddHPMP);
                      m_UseItems[U_CHARM].Dura := 0;
                      SendDelItems(@m_UseItems[U_CHARM]);
                      m_UseItems[U_CHARM].wIndex:= 0;
                    end;
                    if m_WAbil.MP > m_WAbil.MaxMP then m_WAbil.MP := m_WAbil.MaxMP;
                    PlugHealthSpellChanged();
                  end;
                end;
            end;//3 begin
          end;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} THeroObject.PlaySuperRock');
  end;
end;

//Ӣ�۾������� 20080925
function THeroObject.MagMakeHPUp(UserMagic: pTUserMagic): Boolean;
  function GetSpellPoint(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wSpell + UserMagic.MagicInfo.btDefSpell;
  end;
var
  nSpellPoint, n14: Integer;
begin
  Result := False;
  nSpellPoint := GetSpellPoint(UserMagic);
  if nSpellPoint > 0 then begin
    //if UserMagic.btLevel > 0 then begin
      if (m_Abil.WineDrinkValue >= Round(m_Abil.MaxAlcohol * g_Config.nMinDrinkValue68 div 100)) then begin
        if (GetTickCount - m_dwStatusArrTimeOutTick[4] > g_Config.nHPUpTick * 1000) and (m_wStatusArrValue[4] = 0) then begin //ʱ����
          if m_WAbil.MP < nSpellPoint then begin
            SysMsg('MPֵ����!!!', c_Red, t_Hint);
            Exit;
          end;
          DamageSpell(nSpellPoint);//��MPֵ
          HealthSpellChanged();
          n14:= {UserMagic.btLevel}300 + g_Config.nHPUpUseTime;
          m_dwStatusArrTimeOutTick[4] := GetTickCount + n14 * 1000;//ʹ��ʱ��
          m_wStatusArrValue[4] := UserMagic.btLevel + 1;//����ֵ
          SysMsg('(Ӣ��)����ֵ˲������, ����' + IntToStr(n14) + '��', c_Green, t_Hint);
          SysMsg('(Ӣ��)���������Ѿ��ڼ���״̬', c_Green, t_Hint);
          RecalcAbilitys();
          CompareSuitItem(False);//��װ������װ���Ա�
          SendMsg(self, RM_HEROABILITY, 0, 0, 0, 0, '');
          Result := True;
        end else SysMsg('(Ӣ��)'+g_sOpenShieldOKMsg, c_Red, t_Hint);
      end else SysMsg('(Ӣ��)��ƶȲ�����'+inttostr(g_Config.nMinDrinkValue68)+'%ʱ,����ʹ�ô˼��� ', c_Red, t_Hint);
    //end else SysMsg('�ȼ����1������,����ʹ�ô˼���', c_Red, t_Hint);
  end;
end;

//�ڹ��������� 20081003
procedure THeroObject.NGMAGIC_LVEXP(UserMagic: pTUserMagic);
begin
  if (UserMagic <> nil) then begin
    if (m_btRaceServer = RC_HEROOBJECT) and (UserMagic.btLevel < 3) and
       (UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <= m_NGLevel) then begin
       TrainSkill(UserMagic, Random(3) + 1);
       if not CheckMagicLevelup(UserMagic) then begin
         SendDelayMsg(Self, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 3000);//20081219 
       end;
    end;
  end;
end;
//ˢ��Ӣ������������20081126
procedure THeroObject.RecalcAdjusBonus();
  procedure AdjustAb(Abil: Byte; Val: Word; var lov, hiv: Word);
  var
    Lo, Hi: Byte;
    I: Integer;
  begin
    Lo := LoByte(Abil);
    Hi := HiByte(Abil);
    lov := 0; hiv := 0;
    for I := 1 to Val do begin
      if Lo + 1 < Hi then begin
        Inc(Lo);
        Inc(lov);
      end else begin
        Inc(Hi);
        Inc(hiv);
      end;
    end;
  end;
var
  BonusTick: pTNakedAbility;
  NakedAbil: pTNakedAbility;
  adc, amc, asc, aac, amac: Integer;
  ldc, lmc, lsc, lac, lmac, hdc, hmc, hsc, hac, hmac: Word;
begin
  BonusTick := nil;
  NakedAbil := nil;
  case m_btJob of
    0: begin
        BonusTick := @g_Config.BonusAbilofWarr;
        NakedAbil := @g_Config.NakedAbilofWarr;
      end;
    1: begin
        BonusTick := @g_Config.BonusAbilofWizard;
        NakedAbil := @g_Config.NakedAbilofWizard;
      end;
    2: begin
        BonusTick := @g_Config.BonusAbilofTaos;
        NakedAbil := @g_Config.NakedAbilofTaos;
      end;
    {3: begin//�̿�(��ʱ��սʿ����)
        BonusTick := @g_Config.BonusAbilofWarr;
        NakedAbil := @g_Config.NakedAbilofWarr;
      end; }
  end;

  adc := m_BonusAbil.DC div BonusTick.DC;
  amc := m_BonusAbil.MC div BonusTick.MC;
  asc := m_BonusAbil.SC div BonusTick.SC;
  aac := m_BonusAbil.AC div BonusTick.AC;
  amac := m_BonusAbil.MAC div BonusTick.MAC;

  AdjustAb(NakedAbil.DC, adc, ldc, hdc);
  AdjustAb(NakedAbil.MC, amc, lmc, hmc);
  AdjustAb(NakedAbil.SC, asc, lsc, hsc);
  AdjustAb(NakedAbil.AC, aac, lac, hac);
  AdjustAb(NakedAbil.MAC, amac, lmac, hmac);
  //lac  := 0;  hac := aac;
  //lmac := 0;  hmac := amac;

  m_WAbil.DC := MakeLong(LoWord(m_WAbil.DC) + ldc, HiWord(m_WAbil.DC) + hdc);
  m_WAbil.MC := MakeLong(LoWord(m_WAbil.MC) + lmc, HiWord(m_WAbil.MC) + hmc);
  m_WAbil.SC := MakeLong(LoWord(m_WAbil.SC) + lsc, HiWord(m_WAbil.SC) + hsc);
  m_WAbil.AC := MakeLong(LoWord(m_WAbil.AC) + lac, HiWord(m_WAbil.AC) + hac);
  m_WAbil.MAC := MakeLong(LoWord(m_WAbil.MAC) + lmac, HiWord(m_WAbil.MAC) + hmac);

  m_WAbil.MaxHP := _MIN(High(Word), m_WAbil.MaxHP + m_BonusAbil.HP div BonusTick.HP);
  m_WAbil.MaxMP := _MIN(High(Word), m_WAbil.MaxMP + m_BonusAbil.MP div BonusTick.MP);
  //m_btSpeedPoint:=m_btSpeedPoint + m_BonusAbil.Speed div BonusTick.Speed;
  //m_btHitPoint:=m_btHitPoint + m_BonusAbil.Hit div BonusTick.Hit;
end;

//�������װ��������Ʒ�Ƿ� 20081127
function THeroObject.CheckItemBindDieNoDrop(UserItem: pTUserItem): Boolean;
var
  I: Integer;
  ItemBind: pTItemBind;
begin
  Result := False;
  g_ItemBindDieNoDropName.Lock;
  try
    if g_ItemBindDieNoDropName.Count > 0 then begin
      for I := 0 to g_ItemBindDieNoDropName.Count - 1 do begin
        ItemBind := g_ItemBindDieNoDropName.Items[I];
        if ItemBind <> nil then begin
          if ItemBind.nItemIdx = UserItem.wIndex then begin
            if (CompareText(ItemBind.sBindName, m_sCharName) = 0) then Result := True;
            Exit;
          end;
        end;
      end;
    end;
  finally
    g_ItemBindDieNoDropName.UnLock;
  end;
end;

end.


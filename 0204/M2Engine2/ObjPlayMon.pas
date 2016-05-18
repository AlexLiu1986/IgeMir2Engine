{���ι��� ����}

unit ObjPlayMon;

interface
uses
  Windows, SysUtils, Classes, Grobal2, ObjBase, IniFiles, ObjHero{20080208 ����};
type
  TPlayMonster = class(TBaseObject)
    m_dwThinkTick: LongWord;
    m_boDupMode: Boolean; //�����ص���
    //m_nNotProcessCount: Integer; //δ��������������ڹ��ﴦ��ѭ��  δʹ�� 20080329
    m_nTargetX: Integer;
    m_nTargetY: Integer;
    m_boRunAwayMode: Boolean;
    m_dwRunAwayStart: LongWord;
    m_dwRunAwayTime: LongWord;
    m_boCanPickUpItem: Boolean;
    //m_boSlavePickUpItem: Boolean;//20080428 ע��
    m_dwPickUpItemTick: LongWord;
    //m_boPickUpItemOK: Boolean;//20080428 ע��
    //m_nPickUpItemMakeIndex: Integer;//20080428 ע��
    m_wHitMode: Word;
    m_dwAutoAvoidTick: LongWord; //�Զ���ܼ��
    m_boAutoAvoid: Boolean; //�Ƿ���
    m_boDoSpellMagic: Boolean; //�Ƿ����ʹ��ħ��
    m_dwDoSpellMagicTick: LongWord; //ʹ��ħ�����
    m_boGotoTargetXY: Boolean; //�Ƿ�����Ŀ��
    m_SkillShieldTick: LongWord; //ħ����ʹ�ü��
    m_Skill_75_Tick: LongWord; //�������ʹ�ü��  20080107
    m_SkillBigHealling: LongWord; //Ⱥ��������ʹ�ü��
    m_SkillDejiwonho: LongWord; //��ʥս����ʹ�ü��
    m_dwCheckDoSpellMagic: LongWord;
    m_nDieDropUseItemRate: Integer; //������װ������

    m_boDropUseItem: Boolean;//�Ƿ��װ�� 20080120
    //m_nButchUserItemRate: Integer;//����ȡʱ�����ڵ�����װ���ļ��� 20080523
    m_boButchUseItem: Boolean;//�Ƿ�������ȡ����װ�� 20080120
    m_nButchRate: Integer;//��ȡ����װ������ 20080120
    m_nButchChargeClass: Byte;//��ȡ����װ���շ�ģʽ(0��ң�1Ԫ����2���ʯ��3���)  20080120
    m_nButchChargeCount: Integer;//��ȡ����װ��ÿ���շѵ��� 20080120
    m_nButchItemTime: LongWord;//����Ʒ���ʱ�� 20080121
    m_ButchItemList: TList;//���ι�����Ʒ�б� 20080523
    boIntoTrigger: Boolean;//���ι����Ƿ���봥�� 20080716
    boIsDieEvent: Boolean;//��������ʬ��,�Ƿ���ʾ������Ч��(��������Ч��) 20080914
    m_dwActionTick: LongWord;//������� 20080715

    wSkill_05: Word; //ħ����
    wSkill_66: Word; //�ļ�ħ���� 20080728
    wSkill_01: Word; //�׵���
    wSkill_02: Word; //�����׹�
    wSkill_03: Word; //������
    wSKILL_58: Word;//���ǻ��� 20080528
    wSKILL_36: Word;//����� 20080410
    wSKILL_45: Word;//����� 20080410
    wSkill_04: Word; //������

    wSkill_06: Word; //ʩ����
    wSkill_07: Word; //�����
    wSKILL_59: Word;//��Ѫ�� 20080528
    wSkill_14: Word; //����� 20080405
    wSkill_73: Word; //������ 20080405
    wSkill_50: Word; //�޼����� 20080405
    wSkill_08: Word; //��ʥս����
    wSkill_09: Word; //Ⱥ��������
    wSkill_10: Word; //Ⱥ��ʩ����
    wSkill_48: Word;//������ 20090111
    wSkill_51: Word;//쫷��� 20080917

    wSkill_11: Word;//�һ𽣷�
    wSkill_12: Word;//��ɱ����
    wSkill_13: Word;//�����䵶
    wSkill_27: Word;//Ұ����ײ 20081016
    wSKILL_40: Word;//���µ��� 20080410
    wSKILL_42: Word;//����ն 20080405
    wSKILL_43: Word;//��Ӱ���� 20080405
    wSKILL_74: Word;//���ս��� 20080528

    wSkill_75: Word; //������� 20080107

    m_nSkill_5Tick: LongWord;//�޼�����ʹ�ü�� 20080605
    m_nSkill_48Tick: LongWord;//������ʹ�ü�� 20090111

    dwRockAddHPTick: LongWord;//ħѪʯ��HP ʹ�ü�� 20080728
    dwRockAddMPTick: LongWord;//ħѪʯ��MP ʹ�ü�� 20080728
    m_dwDoMotaeboTick: LongWord;//Ұ����ײ��� 20081016

    m_nSelectMagic: Integer;//ħ�� 20081206
    m_boProtectStatus: Boolean;//�ػ�ģʽ 20090103
    m_nProtectTargetX, m_nProtectTargetY: Integer;//�ػ����� 20090103
    m_boProtectOK: Boolean;//�����ػ����� 20090107
    m_nGotoProtectXYCount: Integer;//�����ػ�������ۼ��� 20090203
  private
    function Think: Boolean;
    function GetSpellPoint(UserMagic: pTUserMagic): Integer;
    function AllowFireHitSkill(): Boolean; {�һ�}
    function AllowDailySkill(): Boolean;//���ս��� 20080511
    function DoSpellMagic(wMagIdx: Word): Boolean;
    procedure SearchPickUpItem(dwSearchTime: LongWord);
    procedure EatMedicine();

    function WarrAttackTarget(wHitMode: Word): Boolean; {������}
    function WarrorAttackTarget(): Boolean; {սʿ����}
    function WizardAttackTarget(): Boolean; {��ʦ����}
    function TaoistAttackTarget(): Boolean; {��ʿ����}

    function EatUseItems(btItemType: Byte): Boolean; {�Զ���ҩ}
    function AutoAvoid(): Boolean; //�Զ����

    function SearchPickUpItemOK(): Boolean;//����Ƿ���Լ������Ʒ
    function IsPickUpItem(StdItem: pTStdItem): Boolean;
    //function WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
    //function WalkToTargetXY2(nTargetX, nTargetY: Integer): Boolean; //ת��

    //function CheckSlaveTarget(TargetObject: TBaseObject): Boolean; //����Ƿ�������������Ŀ�� //20080522 ע��
    //function CheckSlavePickUpItem(): Boolean; //������������ǲ������ڼ���Ʒ //20080428 ע��
    function StartAutoAvoid(): Boolean;//�Զ����״̬

    function IsNeedGotoXY(): Boolean;//�Ƿ�����Ŀ�� 20080206

    function CheckUserMagic(wMagIdx: Word): Integer;//���ʹ�õ�ħ��
    function CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
    function AllowGotoTargetXY(): Boolean;
    //procedure GotoTargetXYRange();//20080522 ע��
    function GetUserItemList(nItemType: Integer; nItemShape: Integer): Integer;
    function UseItem(nItemType, nIndex: Integer; nItemShape: Integer): Boolean;
    function CheckUserItemType(nItemType: Integer; nItemShape: Integer): Boolean;
    function CheckItemType(nItemType: Integer; StdItem: pTStdItem; nItemShape: Integer): Boolean;

    function CheckDoSpellMagic(): Boolean;

    //function CheckTakeOnItems(nWhere: Integer; var StdItem: TStdItem): Boolean;//20080522 ע��
    function FindMagic(sMagicName: string): pTUserMagic;//����ħ��
    function CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;

    function AbilityUp(UserMagic: pTUserMagic): Boolean; //�޼�����  20080405
    function MagMakeFireDay(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean; //����� 20080410
    function MabMabe(BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel, nTargetX, nTargetY: Integer): Boolean;//����� 20080410
    procedure LoadButchItemList();//�������ι���ȡ�б� 20080523
    procedure PlaySuperRock;//��Ѫʯ���� 20080729
    function DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean;//���ν���Ұ����ײ 20081016
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    function AttackTarget(): Boolean;
    function AddItems(UserItem: pTUserItem; btWhere: Integer): Boolean; //��ȡ����װ��
    procedure Run; override;
    procedure SearchTarget();
    procedure DelTargetCreat(); override;
    procedure SetTargetXY(nX, nY: Integer); virtual;
    procedure GotoTargetXY(nTargetX, nTargetY: Integer); virtual;
    procedure Wondering(); virtual;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); virtual;
    procedure Struck(hiter: TBaseObject); virtual;
    procedure AddItemsFromConfig();
    procedure InitializeMonster;//��ʼ������
  end;

implementation
uses UsrEngn, M2Share, Envir, Magic, HUtil32;


{ TPlayMonster }

constructor TPlayMonster.Create;
begin
  inherited;
  m_boDupMode := False;
  m_nSkill_5Tick:= GetTickCount();//�޼�����ʹ�ü�� 20080605
  m_nSkill_48Tick:= GetTickCount();//������ʹ�ü�� 20090111
  m_dwThinkTick := GetTickCount();
  m_nViewRange := 10;
  m_nRunTime := 250;
  //m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := RC_PLAYMOSTER;
  m_nCopyHumanLevel := 2;
  //m_nNotProcessCount := 0;//δʹ�� 20080329
  m_nTargetX := -1;
  dwTick3F4 := GetTickCount();
  m_dwHitTick := GetTickCount - LongWord(Random(3000));
  m_dwWalkTick := GetTickCount - LongWord(Random(3000));
  m_nWalkSpeed := 500;
  m_nWalkStep := 10;
  m_dwWalkWait := 0;
  m_dwSearchEnemyTick := GetTickCount();
  m_boRunAwayMode := False;
  m_dwRunAwayStart := GetTickCount();
  m_dwRunAwayTime := 0;
  m_boCanPickUpItem := True;
  //m_boSlavePickUpItem := False;//20080428 ע��
  m_dwPickUpItemTick := GetTickCount();
  //m_boPickUpItemOK := True;//20080428 ע��
  m_dwAutoAvoidTick := GetTickCount(); //�Զ���ܼ��
  m_boAutoAvoid := False; //�Ƿ��� 20080715
  m_boDoSpellMagic := True; //�Ƿ�ʹ��ħ��
  m_boGotoTargetXY := True; //�Ƿ�����Ŀ��
  m_nNextHitTime := 300;
  m_dwDoSpellMagicTick := GetTickCount(); //ʹ��ħ�����
  m_SkillShieldTick := GetTickCount(); //ħ����ʹ��ħ�����
  m_Skill_75_Tick := GetTickCount(); //�������ʹ��ħ����� 20080107
  m_SkillBigHealling := GetTickCount(); //Ⱥ��������ʹ�ü��
  m_SkillDejiwonho := GetTickCount(); //��ʥս����ʹ�ü��
  m_dwCheckDoSpellMagic := GetTickCount();
  m_nDieDropUseItemRate := 100;
  m_nButchItemTime := GetTickCount();//����Ʒ���ʱ�� 20080816
  m_ButchItemList := TList.Create;//���ι�����Ʒ�б� 20080523
  m_dwDoMotaeboTick := GetTickCount();//Ұ����ײʹ�ü�� 20081016
  m_boProtectStatus:= False;//�ػ�ģʽ 20090103
  m_boProtectOK:= True;//�����ػ����� 20090107
  m_nGotoProtectXYCount:= 0;//�����ػ�������ۼ��� 2009020
end;

destructor TPlayMonster.Destroy;
var
  I: Integer;
begin
  if m_ButchItemList.Count > 0 then begin//20080630
    for I := 0 to m_ButchItemList.Count - 1 do begin//���ι�����Ʒ�б� 20080523
      if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
         Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
    end;
  end;
  FreeAndNil(m_ButchItemList);
  inherited;
end;

procedure TPlayMonster.InitializeMonster;
begin
  AddItemsFromConfig();
  case m_btJob of
    0: begin
        wSkill_11 := CheckUserMagic(SKILL_FIRESWORD); //�һ𽣷�
        wSkill_12 := CheckUserMagic(SKILL_ERGUM); //��ɱ����
        wSkill_13 := CheckUserMagic(SKILL_BANWOL); //�����䵶
        wSkill_27 := CheckUserMagic(SKILL_MOOTEBO);//Ұ����ײ 20081016
        wSKILL_40 := CheckUserMagic(SKILL_40);//���µ��� 20080410
        wSKILL_42 := CheckUserMagic(SKILL_42); //����ն 20080405
        wSKILL_43 := CheckUserMagic(SKILL_43); //��Ӱ���� 20080405
        wSKILL_74 := CheckUserMagic(SKILL_74);//���ս��� 20080528
        wSkill_75 := CheckUserMagic(SKILL_75); //������� 20080107
      end;
    1: begin
        wSkill_01 := CheckUserMagic(SKILL_LIGHTENING); //�׵���  
        wSkill_02 := CheckUserMagic(SKILL_LIGHTFLOWER); //�����׹�
        wSkill_03 := CheckUserMagic(SKILL_SNOWWIND); //������
        wSkill_04 := CheckUserMagic(SKILL_47); //������
        wSkill_05 := CheckUserMagic(SKILL_SHIELD); //ħ����
        wSkill_66:= CheckUserMagic(SKILL_66); //�ļ�ħ���� 20080728
        wSKILL_58 := CheckUserMagic(SKILL_58);//���ǻ��� 20080528
        wSKILL_36 := CheckUserMagic(SKILL_MABE);//����� 20080410
        wSKILL_45 := CheckUserMagic(SKILL_45);//����� 20080410
        wSkill_75 := CheckUserMagic(SKILL_75); //������� 20080107
        if (wSkill_01 = 0) and (wSkill_02 = 0) and (wSkill_03 = 0) and (wSkill_04 = 0) then m_boDoSpellMagic := False;
      end;
    2: begin
        wSkill_06 := CheckUserMagic(SKILL_AMYOUNSUL); //ʩ����
        wSkill_07 := CheckUserMagic(SKILL_FIRECHARM); //�����
        wSKILL_59 := CheckUserMagic(SKILL_59);//��Ѫ�� 20080528
        wSkill_14 := CheckUserMagic(SKILL_HANGMAJINBUB); //����� 20080405
        wSkill_73 := CheckUserMagic(SKILL_73); //������ 20080405
        wSkill_50 := CheckUserMagic(SKILL_50); //�޼����� 20080405
        wSkill_08 := CheckUserMagic(SKILL_DEJIWONHO); //��ʥս����
        wSkill_09 := CheckUserMagic(SKILL_BIGHEALLING); //Ⱥ��������
        wSkill_10 := CheckUserMagic(SKILL_GROUPAMYOUNSUL); //Ⱥ��ʩ����
        wSkill_75 := CheckUserMagic(SKILL_75); //������� 20080107
        wSkill_48 := CheckUserMagic(SKILL_48);//������ 20090111
        wSkill_51 := CheckUserMagic(SKILL_51); //쫷��� 20080917
        if (wSkill_06 = 0) and (wSkill_07 = 0) and (wSkill_10 = 0) then m_boDoSpellMagic := False;
      end;
  end;
end;

procedure TPlayMonster.GotoTargetXY(nTargetX, nTargetY: Integer);
var
  I: Integer;
  nDir: Integer;
  n10: Integer;
  n14: Integer;
  n20: Integer;
  nOldX: Integer;
  nOldY: Integer;
begin
  if ((m_nCurrX <> nTargetX) or (m_nCurrY <> nTargetY)) then begin
    n10 := nTargetX;
    n14 := nTargetY;
    dwTick3F4 := GetTickCount();
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
    if (abs(m_nCurrX - nTargetX) >= 3) or (abs(m_nCurrY - nTargetY) >= 3) then begin
      if not RunTo(nDir, False, nTargetX, nTargetY) then begin
        WalkTo(nDir, False);
        n20 := Random(3);
        for I := DR_UP to DR_UPLEFT do begin
          if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
            if n20 <> 0 then Inc(nDir)
            else if nDir > 0 then Dec(nDir)
            else nDir := DR_UPLEFT;
            if (nDir > DR_UPLEFT) then nDir := DR_UP;
            WalkTo(nDir, False);
          end;
        end;
      end;
    end else begin
      WalkTo(nDir, False);
      n20 := Random(3);
      for I := DR_UP to DR_UPLEFT do begin
        if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
          if n20 <> 0 then Inc(nDir)
          else if nDir > 0 then Dec(nDir)
          else nDir := DR_UPLEFT;
          if (nDir > DR_UPLEFT) then nDir := DR_UP;
          WalkTo(nDir, False);
        end;
      end;
    end;
  end;
end;
{//ת��
function TPlayMonster.WalkToTargetXY2(nTargetX, nTargetY: Integer): Boolean;
var
  I: Integer;
  nDir: Integer;
  n10: Integer;
  n14: Integer;
  n20: Integer;
  nOldX: Integer;
  nOldY: Integer;
 // n16: Integer;
begin
  Result := False;
  if (nTargetX <> m_nCurrX) or (nTargetY <> m_nCurrY) then begin
    n10 := nTargetX;
    n14 := nTargetY;
    dwTick3F4 := GetTickCount();
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
    if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then Result := True;
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
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TPlayMonster.WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
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
  if ((m_nCurrX <> nTargetX) or (m_nCurrY <> nTargetY)) then begin
    n10 := nTargetX;
    n14 := nTargetY;
    dwTick3F4 := GetTickCount();
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
    if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then Result := True;
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
            Break;
          end;
        end;
      end;
    end;
  end;
end;  }

function TPlayMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  try
    Result:=False;//20080206 ȥ��ע��
    if ProcessMsg.wIdent = RM_STRUCK then begin
      if (ProcessMsg.BaseObject = Self) and (TBaseObject(ProcessMsg.nParam3 {AttackBaseObject}) <> nil) then begin
        SetLastHiter(TBaseObject(ProcessMsg.nParam3 {AttackBaseObject}));
        Struck(TBaseObject(ProcessMsg.nParam3 {AttackBaseObject})); {0FFEC}
        BreakHolySeizeMode();
        {if (m_Master <> nil) and//20080928 ע��
          (TBaseObject(ProcessMsg.nParam3) <> m_Master) and
          (TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT) then begin
          m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
        end; }
        //20080928 �޸�,������Լ�������ɫ,��Ӣ�۷���Ҳ����ɫ
        if (m_Master <> nil) and (TBaseObject(ProcessMsg.nParam3) <> m_Master)
           and ((TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT) or
            (TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_HEROOBJECT)) then begin
           if m_Master.m_btRaceServer = RC_PLAYOBJECT then m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
           if m_Master.m_btRaceServer = RC_HEROOBJECT then begin
             if (m_Master.m_Master <> nil) then begin
               if TBaseObject(ProcessMsg.nParam3) <> m_Master.m_Master then m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
             end else m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
           end;
        end;
        if g_Config.boMonSayMsg then MonsterSayMsg(TBaseObject(ProcessMsg.nParam3), s_UnderFire);
      end;
      Result := True;
    end else begin
      Result := inherited Operate(ProcessMsg);
    end;
  except
    MainOutMessage('{�쳣} TPlayMonster.Operate');
  end;
end;

procedure TPlayMonster.Struck(hiter: TBaseObject);
var
  btDir: Byte;
begin
  m_dwStruckTick := GetTickCount;
  if hiter <> nil then begin
    if (m_TargetCret = nil) or GetAttackDir(m_TargetCret, btDir) or (Random(6) = 0) then begin
      if IsProperTarget(hiter) then
        SetTargetCreat(hiter);
    end;
  end;
  if m_boAnimal then begin
    m_nMeatQuality := m_nMeatQuality - Random(300);
    if m_nMeatQuality < 0 then m_nMeatQuality := 0;
  end;
  //if m_Abil.Level < 50 then
  m_dwHitTick := m_dwHitTick + LongWord(150 - _MIN(130, m_Abil.Level * 4));
  //WalkTime := WalkTime + (300 - _MIN(200, (Abil.Level div 5) * 20));
end;

procedure TPlayMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
begin
  inherited AttackDir(TargeTBaseObject, m_wHitMode, nDir);
end;

procedure TPlayMonster.DelTargetCreat;
begin
  inherited;
  m_nTargetX := -1;
  m_nTargetY := -1;
end;
{//�������Ŀ��  //20080522 ע��
function TPlayMonster.CheckSlaveTarget(TargetObject: TBaseObject): Boolean;
var
  I: Integer;
begin
  Result := False;
  if m_Master <> nil then begin
    for I := 0 to m_Master.m_SlaveList.Count - 1 do begin
      if TBaseObject(m_Master.m_SlaveList.Items[I]).m_TargetCret = TargetObject then begin
        Result := True;
        Break;
      end;
    end;
  end;
end; }
{ //20080428 ע��
function TPlayMonster.CheckSlavePickUpItem(): Boolean;
var
  I: Integer;
begin
  Result := False;
  if m_Master <> nil then begin
    for I := 0 to m_Master.m_SlaveList.Count - 1 do begin
      if TPlayMonster(m_Master.m_SlaveList.Items[I]).m_boSlavePickUpItem then begin
        Result := True;
        Break;
      end;
    end;
  end;
end; }

procedure TPlayMonster.SearchTarget;
var
  BaseObject, BaseObject18: TBaseObject;
  I, nC, n10: Integer;
begin
  if m_boProtectStatus then begin //�ػ�״̬ 20090104
    if (abs(m_nCurrX - m_nProtectTargetX) > 12) or (abs(m_nCurrY - m_nProtectTargetY) > 12) or (not m_boProtectOK) then begin//20090107 ���ӣ�û���ܵ��ػ��㲻����Ŀ��
      Exit;
    end;
  end;
  BaseObject18 := nil;
  n10 := 12;//20090107 ���ιֵ�̽����Χ
  if m_VisibleActors.Count > 0 then begin//20080630
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath then begin
          //Ŀ��ΪӢ��,�ҵȼ�������22��,����״̬,�򲻹���Ӣ�� 20080421
          if (BaseObject.m_btRaceServer = RC_HEROOBJECT) and (BaseObject.m_Abil.Level <= 22) and (THEROOBJECT(BaseObject).m_btStatus = 1) then Continue;
          if IsProperTarget(BaseObject) and (not BaseObject.m_boHideMode or m_boCoolEye) then begin
            nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
            if nC <= n10 then begin
              n10 := nC;
              if m_boProtectStatus then begin //�ػ�״̬ 20090105
                if (abs(BaseObject.m_nCurrX - m_nProtectTargetX) <= 13) or (abs(BaseObject.m_nCurrY - m_nProtectTargetY) <= 13) then begin
                  BaseObject18 := BaseObject;
                  Break;//20090104
                end;
              end else begin
                BaseObject18 := BaseObject;
                Break;//20090104
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  if BaseObject18 <> nil then begin
    if m_boProtectStatus then begin //�ػ�״̬ 20090104
      if (abs(BaseObject18.m_nCurrX - m_nProtectTargetX) > 11) or (abs(BaseObject18.m_nCurrY - m_nProtectTargetY) > 11) then begin
        GotoTargetXY(m_nProtectTargetX, m_nProtectTargetY);
        Exit;
      end;
    end;
    SetTargetCreat(BaseObject18);
  end;
end;

procedure TPlayMonster.SetTargetXY(nX, nY: Integer);
begin
  m_nTargetX := nX;
  m_nTargetY := nY;
end;

procedure TPlayMonster.Wondering;
begin
  if (Random(20) = 0) then 
    if (Random(4) = 1) then TurnTo(Random(8))
    else WalkTo(m_btDirection, False);
end;
//��鹥����ħ��
function TPlayMonster.CheckDoSpellMagic(): Boolean;
var nCode: Byte;
begin
  Result := True;
  nCode:= 0;
  try
    if m_btJob > 0 then begin
      if m_btJob = 1 then begin
        if (wSkill_01 = 0) and (wSkill_02 = 0) and (wSkill_03 = 0) and (wSkill_04 = 0) then begin
          Result := False;
          Exit;
        end;
      end;
      if m_btJob = 2 then begin
        if (wSkill_06 = 0) and (wSkill_07 = 0) and (wSkill_10 = 0) then begin
          Result := False;
          Exit;
        end;
      end;
      if m_WAbil.MP = 0 then begin
        Result := False;
        Exit;
      end;
      if m_btJob = 2 then begin
        nCode:= 1;
        if (wSkill_06 > 0) or (wSkill_10 > 0) then begin//ʩ����
          nCode:= 2;
          if ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin  {�̶�}
            nCode:= 3;
            Result := CheckUserItemType(2,1);
            if Result then Exit;
            nCode:= 4;
            if GetUserItemList(2,1) < 0 then Result := False else Result := True;
            if Result then Exit;
          end;
          nCode:= 5;
          if ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then begin {�춾}
            nCode:= 6;
            Result := CheckUserItemType(2,2);
            if Result then Exit;
            nCode:= 7;
            if GetUserItemList(2,2) < 0 then Result := False else Result := True;
            if Result then Exit;
          end;
        end;
        if (wSkill_07 > 0) or (wSkill_59 > 0) then begin //�����  ��Ѫ��
          nCode:= 8;
          Result := CheckUserItemType(1,0);
          if Result then Exit;
          nCode:= 9;
          if GetUserItemList(1,0) < 0 then Result := False else Result := True;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} TPlayMonster.CheckDoSpellMagic Code:'+Inttostr(nCode));
    end;
  end;
end;

function TPlayMonster.Think(): Boolean;
var
  nOldX, nOldY: Integer;
  nCode: Byte;
begin
  Result := False;
  nCode:= 0;
  try
    if ( m_Master <> nil) and (m_Master.m_nCurrX = m_nCurrX) and (m_Master.m_nCurrY = m_nCurrY) then begin
      m_boDupMode := True;
    end else
    if (GetTickCount - m_dwThinkTick) > 3000{3 * 1000} then begin
      m_dwThinkTick := GetTickCount();
      nCode:= 1;
      if m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY) >= 2 then m_boDupMode := True;
      if not IsProperTarget(m_TargetCret) then m_TargetCret := nil;
    end;
    nCode:= 2;
    if SearchPickUpItemOK() then SearchPickUpItem(500); //����Ʒ
    nCode:= 3;
    EatMedicine(); {��ҩ}
    nCode:= 4;
    if (GetTickCount - m_dwCheckDoSpellMagic) > 1000 then begin //����Ƿ����ʹ��ħ��
      m_dwCheckDoSpellMagic := GetTickCount;
      m_boDoSpellMagic := CheckDoSpellMagic();
    end;
    nCode:= 5;
    if StartAutoAvoid and m_boDoSpellMagic then AutoAvoid(); {�Զ����}
    nCode:= 6;
    if m_boDupMode then begin
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      nCode:= 7;
      WalkTo(Random(8), False);
      if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then begin
        m_boDupMode := False;
        Result := True;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} TPlayMonster.Think Code:'+Inttostr(nCode));
    end;
  end;
end;
//�Ƿ���Լ�����Ʒ
function TPlayMonster.SearchPickUpItemOK(): Boolean;
var
  VisibleMapItem: pTVisibleMapItem;
  MapItem: PTMapItem;
  I: Integer;
begin
  Result := False;
  if (m_VisibleItems.Count = 0) or (m_nCopyHumanLevel = 0) then Exit;
  if m_Master = nil then Exit;
  if (m_Master <> nil) and (m_Master.m_boDeath) then Exit;
  if m_TargetCret <> nil then begin
    if m_TargetCret.m_boDeath then begin
      m_TargetCret := nil;
      Result := True;
    end;
  end;
  //if (m_Master.m_WAbil.Weight >= m_Master.m_WAbil.MaxWeight) and (m_WAbil.Weight >= m_WAbil.MaxWeight) then Exit;
  if m_TargetCret = nil then begin
    if m_VisibleItems.Count > 0 then begin//20080630
      for I := 0 to m_VisibleItems.Count - 1 do begin
        VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
        if (VisibleMapItem <> nil) then begin
          if (VisibleMapItem.nVisibleFlag > 0) then begin
            MapItem := VisibleMapItem.MapItem;
            if (MapItem <> nil) then begin
              if (MapItem.DropBaseObject <> m_Master) then begin
                if IsAllowPickUpItem(VisibleMapItem.sName) then begin
                  //if (MapItem.DropBaseObject <> nil) and (TBaseObject(MapItem.DropBaseObject).m_btRaceServer = RC_PLAYOBJECT) then Continue;
                  if (MapItem.OfBaseObject = nil) or (MapItem.OfBaseObject = m_Master) or (MapItem.OfBaseObject = Self) then begin
                    Result := True;
                    Break;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;//for
    end;
  end;
  if Result then begin
    if (m_ItemList.Count >= g_Config.nCopyHumanBagCount) and (not m_boCanPickUpItem) then begin
      Result := False;
    end;
    if m_boCanPickUpItem and (not TPlayObject(m_Master).IsEnoughBag) and (m_ItemList.Count >= g_Config.nCopyHumanBagCount) then begin
      Result := True;
    end;
  end;
end;
{//20080522
procedure TPlayMonster.GotoTargetXYRange();
var
  n10: Integer;
  n14: Integer;
  nTargetX: Integer;
  nTargetY: Integer;
begin
  nTargetX:= 0;//20080522
  nTargetY:= 0;//20080522
  if CheckTargetXYCount(m_nCurrX, m_nCurrY, 10) < 1 then begin
    n10 := abs(m_TargetCret.m_nCurrX - m_nCurrX);
    n14 := abs(m_TargetCret.m_nCurrY - m_nCurrY);
    if n10 > 4 then Dec(n10, 5) else n10 := 0;
    if n14 > 4 then Dec(n14, 5) else n14 := 0;
    if m_TargetCret.m_nCurrX > m_nCurrX then nTargetX := m_nCurrX + n10;
    if m_TargetCret.m_nCurrX < m_nCurrX then nTargetX := m_nCurrX - n10;
    if m_TargetCret.m_nCurrY > m_nCurrY then nTargetY := m_nCurrY + n14;
    if m_TargetCret.m_nCurrY < m_nCurrY then nTargetY := m_nCurrY - n14;
    GotoTargetXY(nTargetX, nTargetY);
  end;
end;    }

//------------------------------------------------------------------------------
//20080205 ����ԭ�Զ���ܵĴ���,Ӧ��Ӣ�۵�Ԫ����Զ���ܴ�������޸�
function TPlayMonster.AutoAvoid(): Boolean; //�Զ����
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
    Result := DR_DOWN;
    if n10 > m_nCurrX then begin
      Result := DR_RIGHT;
      if n14 > m_nCurrY then Result := DR_DOWNRIGHT;
      if n14 < m_nCurrY then Result := DR_UPRIGHT;
    end else begin
      if n10 < m_nCurrX then begin
        Result := DR_LEFT;
        if n14 > m_nCurrY then Result := DR_DOWNLEFT;
        if n14 < m_nCurrY then Result := DR_UPLEFT;
      end else begin
        if n14 > m_nCurrY then Result := DR_DOWN
        else if n14 < m_nCurrY then Result := DR_UP;
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
        DR_UP: begin
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
        DR_UPRIGHT: begin
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
             // Inc(nTargetX, 2);
             // Inc(nTargetY, 2);
              Inc(nTargetX, 2);//20080524
              Dec(nTargetY, 2);//20080524
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then Break;
             // Inc(nTargetX, 2);
             // Inc(nTargetY, 2);
              Inc(nTargetX, 2);//20080524
              Dec(nTargetY, 2);//20080524
              Inc(n01, 2);
              Continue;
            end;
          end;
        DR_RIGHT: begin
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
        DR_DOWNRIGHT: begin
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
        DR_DOWN: begin
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
        DR_DOWNLEFT: begin
            if m_PEnvir.CanWalk(nTargetX, nTargetY, False) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 3) = 0) then begin
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
        DR_LEFT: begin
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
        DR_UPLEFT: begin
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
    nDir:= 0;//20080522
    Result := GetGotoXY(m_btDirection, nTargetX, nTargetY);
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
    m_btDirection := nDir; //m_btDirection;
  end;
  function GotoMasterXY(var nTargetX, nTargetY: Integer): Boolean;
  var
    nDir: Integer;
  begin
    Result := False;
    if (m_Master <> nil) and ((abs(m_Master.m_nCurrX - m_nCurrX) >= 5) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 5))  then begin
      nTargetX := m_nCurrX;
      nTargetY := m_nCurrY;
      //nTargetX := m_Master.m_nCurrX;//20080215
      //nTargetY := m_Master.m_nCurrY;//20080215      
      nDir := GetDirXY(m_Master.m_nCurrX, m_Master.m_nCurrY);
      m_btDirection := nDir;
      case nDir of
        DR_UP: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPRIGHT, nTargetX, nTargetY);
              m_btDirection := DR_UPRIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPLEFT, nTargetX, nTargetY);
              m_btDirection := DR_UPLEFT;
            end;
          end;
        DR_UPRIGHT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UP, nTargetX, nTargetY);
              m_btDirection := DR_UP;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_RIGHT, nTargetX, nTargetY);
              m_btDirection := DR_RIGHT;
            end;
          end;
        DR_RIGHT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPRIGHT, nTargetX, nTargetY);
              m_btDirection := DR_UPRIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNRIGHT, nTargetX, nTargetY);
              m_btDirection := DR_DOWNRIGHT;
            end;
          end;
        DR_DOWNRIGHT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_RIGHT, nTargetX, nTargetY);
              m_btDirection := DR_RIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWN, nTargetX, nTargetY);
              m_btDirection := DR_DOWN;
            end;
          end;
        DR_DOWN: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNRIGHT, nTargetX, nTargetY);
              m_btDirection := DR_DOWNRIGHT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNLEFT, nTargetX, nTargetY);
              m_btDirection := DR_DOWNLEFT;
            end;
          end;
        DR_DOWNLEFT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWN, nTargetX, nTargetY);
              m_btDirection := DR_DOWN;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_LEFT, nTargetX, nTargetY);
              m_btDirection := DR_LEFT;
            end;
          end;
        DR_LEFT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_DOWNLEFT, nTargetX, nTargetY);
              m_btDirection := DR_DOWNLEFT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UPLEFT, nTargetX, nTargetY);
              m_btDirection := DR_UPLEFT;
            end;
          end;
        DR_UPLEFT: begin
            Result := GetGotoXY(nDir, nTargetX, nTargetY);
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_LEFT, nTargetX, nTargetY);
              m_btDirection := DR_LEFT;
            end;
            if not Result then begin
              nTargetX := m_nCurrX;
              nTargetY := m_nCurrY;
              Result := GetGotoXY(DR_UP, nTargetX, nTargetY);
              m_btDirection := DR_UP;
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
    if GotoMasterXY(nTargetX, nTargetY) then begin
       GotoTargetXY(nTargetX, nTargetY);
    end else begin
      nDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
      nDir:= GetBackDir(nDir);
      m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,nDir,5,m_nTargetX,m_nTargetY);
      GotoTargetXY(m_nTargetX, m_nTargetY);
    end;
  end;
end;       (*
// 20080205 �滻��Ӣ�۵�Ԫ����Զ����
function TPlayMonster.AutoAvoid(): Boolean; //�Զ����
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
  function SearchNextDir(var nTargetX, nTargetY: Integer): Boolean;
  var
    I: Integer;
    nDir: Integer;
    n01: Integer;
    n02: Integer;
    n03: Integer;
    n04: Integer;
    n05: Integer;
    n06: Integer;
    n07: Integer;
    n08: Integer;
    n10: Integer;
    boGotoL2: Boolean;
  label L001;
  label L002;
  label L003;
  begin
    Result := False;
    if not Result then begin
      nDir := GetAvoidDir;
      boGotoL2 := False;
      goto L001;
    end;

    L002:
    if not Result then begin
      n10 := 0;
      while True do begin
        Inc(n10);
        nDir := Random(8);
        if nDir in [0..7] then Break;
        if n10 > 8 then Break;
      end;
      goto L001;
    end;

    L001:
    n01 := 0;
    n02 := 0;
    n03 := 0;
    n04 := 0;
    n05 := 0;
    n06 := 0;
    n07 := 0;
    n08 := 0;
    while True do begin
      if nDir > DR_UPLEFT then Break;
      case nDir of
        DR_UP: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Inc(nTargetY, 10 - n01);
              Result := True;
              Break;
            end else begin
              if n01 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Inc(nTargetY);
              Inc(n01);
              Continue;
            end;
          end;
        DR_UPRIGHT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Inc(nTargetX, 10 - n02);
              Inc(nTargetY, 10 - n02);
              Result := True;
              Break;
            end else begin
              if n02 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Inc(nTargetX);
              Inc(nTargetY);
              Inc(n02);
              Continue;
            end;
          end; //CheckTargetXYCountOfDirection(m_nCurrX, m_nCurrY, m_btDirection, 1)
        DR_RIGHT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Inc(nTargetX, 10 - n03);
              Result := True;
              Break;
            end else begin
              if n03 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Inc(nTargetX);
              Inc(n03);
              Continue;
            end;
          end;
        DR_DOWNRIGHT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Inc(nTargetX, 10 - n04);
              Dec(nTargetY, 10 - n04);
              Result := True;
              Break;
            end else begin
              if n04 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Inc(nTargetX);
              Dec(nTargetY);
              Inc(n04);
              Continue;
            end;
          end;
        DR_DOWN: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Dec(nTargetY, 10 - n05);
              Result := True;
              Break;
            end else begin
              if n05 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Dec(nTargetY);
              Inc(n05);
              Continue;
            end;
          end;
        DR_DOWNLEFT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Dec(nTargetX, 10 - n06);
              Dec(nTargetY, 10 - n06);
              Result := True;
              Break;
            end else begin
              if n06 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Dec(nTargetX);
              Dec(nTargetY);
              Inc(n06);
              Continue;
            end;
          end;
        DR_LEFT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Dec(nTargetX, 10 - n07);
              Result := True;
              Break;
            end else begin
              if n07 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Dec(nTargetX);
              Inc(n07);
              Continue;
            end;
          end;
        DR_UPLEFT: begin
            if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCountOfDirection(nTargetX, nTargetY, nDir, 6) = 0) then begin
              Dec(nTargetX, 10 - n08);
              Inc(nTargetY, 10 - n08);
              Result := True;
              Break;
            end else begin
              if n08 >= 10 then begin
                nTargetX := m_nCurrX;
                nTargetY := m_nCurrY;
                Inc(nDir);
                Continue;
              end;
              Dec(nTargetX);
              Inc(nTargetY);
              Inc(n08);
              Continue;
            end;
          end;
      end;
    end;
    if (not boGotoL2) and (not Result) then begin
      boGotoL2 := True;
      goto L002;
    end;
  end;
var
  n10: Integer;
//  n14: Integer;
//  n20: Integer;
//  nOldX: Integer;
//  nOldY: Integer;
//  n16: Integer;
  nTargetX: Integer;
  nTargetY: Integer;
//  nLoopCount: Integer;
begin
  if m_TargetCret <> nil then begin
    n10 := 0;
    if CheckTargetXYCount(m_nCurrX, m_nCurrY, 6) > 0 then begin
      while True do begin
        Inc(n10);
        nTargetX := m_nCurrX;
        nTargetY := m_nCurrY;
        if SearchNextDir(nTargetX, nTargetY) then
          GotoTargetXY(nTargetX, nTargetY);
        if CheckTargetXYCount(m_nCurrX, m_nCurrY, 6) = 0 then Break;
        if n10 >= 1 then Break;
      end;
    end;
    GotoTargetXYRange();
  end;
  {if m_TargetCret <> nil then begin  //ԭ��ע�͵�,
    nLoopCount := 1;
    if CheckTargetXYCount(m_nCurrX, m_nCurrY, 6) > 0 then begin
      nTargetX := m_nCurrX;
      nTargetY := m_nCurrY + 8;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Inc(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX + 10;
      nTargetY := m_nCurrY + 10;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Inc(nTargetX);
          Inc(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX + 8;
      nTargetY := m_nCurrY;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Inc(nTargetX);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX + 10;
      nTargetY := m_nCurrY + 10;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Inc(nTargetX);
          Inc(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX;
      nTargetY := m_nCurrY - 8;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Dec(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX - 10;
      nTargetY := m_nCurrY - 10;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Dec(nTargetX);
          Dec(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX - 8;
      nTargetY := m_nCurrY;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Dec(nTargetX);
          Inc(n20);
        end;
        Exit;
      end;
      nTargetX := m_nCurrX - 10;
      nTargetY := m_nCurrY + 10;
      if m_PEnvir.CanWalkEx(nTargetX, nTargetY, True) and (CheckTargetXYCount(nTargetX, nTargetY, 6) = 0) then begin
        n20 := 0;
        while True do begin
          if n20 > nLoopCount then break;
          GotoTargetXY(nTargetX, nTargetY);
          Dec(nTargetX);
          Inc(nTargetY);
          Inc(n20);
        end;
        Exit;
      end;
      if m_Master <> nil then begin
        nTargetX := m_Master.m_nCurrX;
        nTargetY := m_Master.m_nCurrY;
        GotoTargetXY(nTargetX, nTargetY);
      end else begin
        GetTargetCretXY(nTargetX, nTargetY);
        GotoTargetXY(nTargetX, nTargetY);
      end;
    end;
  end;}
end;   *)

procedure TPlayMonster.SearchPickUpItem(dwSearchTime: LongWord);
  function PickUpItem(VisibleMapItem: pTVisibleMapItem): Boolean;
  var
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    MapItem: PTMapItem;
//    nDeleteCode: Integer;
  begin
    Result := False;
    MapItem := m_PEnvir.GetItem(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY});
    if MapItem = nil then Exit;
    if CompareText(VisibleMapItem.sName, sSTRING_GOLDNAME) = 0 then begin
      if m_PEnvir.DeleteFromMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
        if (m_Master <> nil) and (not m_Master.m_boDeath) and (m_Master.m_btRaceServer = RC_PLAYOBJECT){20080208 ����} then begin //�񵽵�Ǯ�Ӹ�����
          if TPlayObject(m_Master).IncGold(MapItem.Count) then begin
            SendRefMsg(RM_ITEMHIDE, 0, Integer(MapItem), VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, '');
            if g_boGameLogGold then
              AddGameDataLog('4' + #9 +
                m_sMapName + #9 +
                IntToStr(VisibleMapItem.nX ) + #9 +
                IntToStr(VisibleMapItem.nY ) + #9 +
                m_sCharName + #9 +
                sSTRING_GOLDNAME + #9 +
                IntToStr(MapItem.Count) + #9 +
                '1' + #9 + '0');
            Result := True;
            m_Master.GoldChanged;
            DisPoseAndNil(MapItem);
          end else begin
            m_PEnvir.AddToMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem));
          end;
        end;
      end;
      Exit;
    end else begin //����Ʒ
      if (m_Master <> nil) and (not m_Master.m_boDeath) then begin //�񵽵���Ʒ�Ӹ�����
        if m_ItemList.Count < g_Config.nCopyHumanBagCount then begin //��ҩƷ�ȸ��Լ�
          StdItem := UserEngine.GetStdItem(MapItem.UserItem.wIndex);
          if (StdItem <> nil) and IsPickUpItem(StdItem) then begin
            if m_PEnvir.DeleteFromMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
              New(UserItem);
              FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 ����
              //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 ����
              UserItem^ := MapItem.UserItem;
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if (StdItem <> nil) and IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex)) then begin
                SendRefMsg(RM_ITEMHIDE, 0, Integer(MapItem), VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, '');
                m_ItemList.Add(UserItem);
                //m_WAbil.Weight := RecalcBagWeight();
                if StdItem.NeedIdentify = 1 then
                  AddGameDataLog('4' + #9 + m_sMapName + #9 +
                    IntToStr(VisibleMapItem.nX) + #9 + IntToStr(VisibleMapItem.nY) + #9 +
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
                    IntToStr(UserItem.btValue[14])+ #9 + IntToStr(UserItem.Dura)+'/'+IntToStr(UserItem.DuraMax));
                Result := True;
                DisPoseAndNil(MapItem);
              end;
            end else begin
              DisPoseAndNil(UserItem);
              m_PEnvir.AddToMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem));
            end;
            Exit;
          end;
        end;
        if TPlayObject(m_Master).IsEnoughBag and m_boCanPickUpItem then begin
          if m_PEnvir.DeleteFromMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
            New(UserItem);
            FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 ����
            //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 ����
            UserItem^ := MapItem.UserItem;
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if (StdItem <> nil) and TPlayObject(m_Master).IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex)) then begin
              SendRefMsg(RM_ITEMHIDE, 0, Integer(MapItem), VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, '');
              TPlayObject(m_Master).AddItemToBag(UserItem);
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('4' + #9 + m_sMapName + #9 +
                  IntToStr(VisibleMapItem.nX ) + #9 + IntToStr(VisibleMapItem.nY ) + #9 +
                  m_sCharName + ' - ' + m_Master.m_sCharName + #9 + StdItem.Name + #9 +
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
              DisPoseAndNil(MapItem);
              if not m_Master.m_boDeath then begin
                if (TPlayObject(m_Master).m_btRaceServer = RC_PLAYOBJECT)  then begin
                  TPlayObject(m_Master).SendAddItem(UserItem);
                end else
                if m_Master.m_btRaceServer = RC_HEROOBJECT   then begin {20080208 ����}
                  THeroObject(m_Master).SendAddItem(UserItem);
                end;
              end;
            end else begin
              DisPoseAndNil(UserItem);
              m_PEnvir.AddToMap(VisibleMapItem.nX, VisibleMapItem.nY {m_nCurrX, m_nCurrY}, OS_ITEMOBJECT, TObject(MapItem));
            end;
          end;
        end;
      end;
    end;
  end;

 { function IsOfGroup(BaseObject: TBaseObject): Boolean;
//  var
//    I: Integer;
//    GroupMember: TBaseObject;
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
  end;   }
var
  MapItem: PTMapItem;
  VisibleMapItem: pTVisibleMapItem;
  I: Integer;
  nCode: Byte;
//  nCheckCode: Integer;
//  boFound: Boolean;
//  sName: string;
resourcestring
  sExceptionMsg2 = '{�쳣} TPlayMonster::SearchItemRange 1-%d %s %s %d %d %d';
begin
  try
    nCode:= 0;
    if GetTickCount - m_dwPickUpItemTick > dwSearchTime then begin
      m_dwPickUpItemTick := GetTickCount;
      nCode:= 1;
      if m_VisibleItems.Count > 0 then begin//20080630
        nCode:= 2;
        for I := 0 to m_VisibleItems.Count - 1 do begin
          VisibleMapItem := pTVisibleMapItem(m_VisibleItems.Items[I]);
          nCode:= 3;
          if (VisibleMapItem <> nil) then begin
            if (VisibleMapItem.nVisibleFlag > 0) then begin
              nCode:= 4;
              MapItem := VisibleMapItem.MapItem;
              if (MapItem <> nil) then begin
                if (MapItem.DropBaseObject <> m_Master) then begin
                  nCode:= 5;
                  if IsAllowPickUpItem(VisibleMapItem.sName) then begin
                    nCode:= 6;
                    //if (MapItem.DropBaseObject <> nil) and (TBaseObject(MapItem.DropBaseObject).m_btRaceServer = RC_PLAYOBJECT) then Continue;
                    if (MapItem.OfBaseObject = nil) or (MapItem.OfBaseObject = m_Master) or (MapItem.OfBaseObject = Self) {or IsOfGroup(TBaseObject(MapItem.OfBaseObject))} then begin
                      //GotoTargetXY(VisibleMapItem.nX, VisibleMapItem.nY);
                      nCode:= 7;
                      if PickUpItem(VisibleMapItem) then begin
                        //MainOutMessage('����Ʒ');
                        Break;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;//for
      end;
    end;
  except
    MainOutMessage('{�쳣} TPlayMonster.SearchPickUpItem Code:'+inttostr(nCode));
  end;
end;
//�ǲ��ǿ��Լ��ҩƷ
function TPlayMonster.IsPickUpItem(StdItem: pTStdItem): Boolean;
begin
  Result := False;
  if StdItem.StdMode = 0 then begin
    if (StdItem.Shape in [0, 1, 2]) then Result := True;
  end else
    if StdItem.StdMode = 31 then begin
    if GetBindItemType(StdItem.Shape) >= 0 then Result := True;
  end else begin
    Result := False;
  end;
end;

function TPlayMonster.EatUseItems(btItemType: Byte): Boolean; {�Զ���ҩ}
  function EatItems(StdItem: pTStdItem): Boolean;
  begin
    Result := False;
    if m_PEnvir.m_boNODRUG then begin
      Exit;
    end;
    case StdItem.StdMode of
      0: begin
          case StdItem.Shape of {��ҩ}
            0: begin
                if (StdItem.AC > 0) then begin
                  Inc(m_nIncHealth, StdItem.AC);
                  Result := True;
                end;
                if (StdItem.MAC > 0) then begin {��ҩ}
                  Inc(m_nIncSpell, StdItem.MAC);
                  Result := True;
                end;
              end;
            1: begin
                if (StdItem.AC > 0) and (StdItem.MAC > 0) then begin
                  IncHealthSpell(StdItem.AC, StdItem.MAC);
                  Result := True;
                end;
              end;
          end;
        end;
    end;
  end;

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
    if nCount <= 0 then nCount:=1;//20080630
    for I := 0 to nCount - 1 do begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
        m_ItemList.Add(UserItem);
        Result := True;
      end else begin
        Dispose(UserItem);
        Break;
      end;
    end;
  end;

  function FoundUserItem(nItemIdx: Integer): Boolean;
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    Result := False;
    if m_ItemList.Count > 0 then begin//20080628
      for I := 0 to m_ItemList.Count - 1 do begin
        UserItem := m_ItemList.Items[I];
        if UserItem = nil then Continue;
        if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;

  function FoundAddHealthItem(ItemType: Byte): Integer;
  var
    I: Integer;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
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
              2: begin //̫��ˮ
                  if (StdItem.StdMode = 0) and (StdItem.Shape = 1) and (StdItem.AC > 0) and (StdItem.MAC > 0) then begin
                    Result := I;
                    Break;
                  end;
                end;
              3: begin //��ҩ��
                  if (StdItem.StdMode = 31) and (GetBindItemType(StdItem.Shape) = 0) then begin
                    Result := I;
                    Break;
                  end;
                end;
              4: begin //��ҩ��
                  if (StdItem.StdMode = 31) and (GetBindItemType(StdItem.Shape) = 1) then begin
                    Result := I;
                    Break;
                  end;
                end;
              5: begin//��ҩ 20080506
                  if (StdItem.StdMode = 31) and (GetBindItemType(StdItem.Shape) = 2) then begin
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

  function UseAddHealthItem(nItemIdx: Integer): Boolean;
  var
    UserItem: pTUserItem;
    StdItem: pTStdItem;
  begin
    Result := False;
    UserItem := m_ItemList.Items[nItemIdx];
    if UserItem <> nil then begin
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then begin
        if not m_PEnvir.AllowStdItems(UserItem.wIndex) then begin
          Exit;
        end;
        case StdItem.StdMode of
          0 {, 1, 2, 3}: begin //ҩ
              if EatItems(StdItem) then begin
                if UserItem <> nil then Dispose(UserItem);
                m_ItemList.Delete(nItemIdx);
                //m_WAbil.Weight := RecalcBagWeight();
                Result := True;
              end;
            end;
          31: begin //�����Ʒ
              if (StdItem.AniCount = 0) and (GetBindItemType(StdItem.Shape) >= 0) then begin
                //if (m_ItemList.Count + 6 - 1) <= MAXBAGITEM then begin
                Dispose(UserItem);
                m_ItemList.Delete(nItemIdx);
                GetUnBindItems(GetUnbindItemName(StdItem.Shape), 6);
                Result := True;
              end;
            end;
        end;
      end;
    end;
  end;

var
  nItemIdx: Integer;
begin
  Result := False;//20080522
  if not m_boDeath then begin
    nItemIdx := FoundAddHealthItem(btItemType);
    if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
      Result := UseAddHealthItem(nItemIdx);
    end else begin
      case btItemType of //���ҽ����Ʒ
        0: begin
            nItemIdx := FoundAddHealthItem(3);
            if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
              Result := UseAddHealthItem(nItemIdx);
            end else begin
              nItemIdx := FoundAddHealthItem(2);
              if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
                Result := UseAddHealthItem(nItemIdx);
              end else begin
                nItemIdx := FoundAddHealthItem(5);
                if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then
                  Result := UseAddHealthItem(nItemIdx);
              end;
            end;
          end;
        1: begin
            nItemIdx := FoundAddHealthItem(4);
            if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
              Result := UseAddHealthItem(nItemIdx);
            end else begin
              nItemIdx := FoundAddHealthItem(2);
              if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then begin
                Result := UseAddHealthItem(nItemIdx);
              end else begin
                nItemIdx := FoundAddHealthItem(5);
                if (nItemIdx >= 0) and (nItemIdx < m_ItemList.Count) then
                  Result := UseAddHealthItem(nItemIdx);
              end;
            end;
          end;
      end;
    end;
  end;
end;

function TPlayMonster.AllowGotoTargetXY(): Boolean;
begin
  Result := True;
  if (m_btJob = 0) or (not m_boDoSpellMagic) or (m_TargetCret = nil) then Exit;
  Result := False;
end;
//�һ�
function TPlayMonster.AllowFireHitSkill(): Boolean;
begin
  Result := False;
  if (GetTickCount - m_dwLatestFireHitTick) > 10000{10 * 1000} then begin
    m_dwLatestFireHitTick := GetTickCount();
    m_boFireHitSkill := True;
    Result := True;
  end;
end;
//���ս��� 20080511
function TPlayMonster.AllowDailySkill(): Boolean;
begin
  Result := False;
  if (GetTickCount - m_dwLatestDailyTick) > 10000{10 * 1000}  then begin
    m_dwLatestDailyTick := GetTickCount();
    m_boDailySkill := True;
    Result := True;
  end;
end;
//�Ƿ���Ҫ���,��սʿ��
function TPlayMonster.StartAutoAvoid(): Boolean;
begin
  Result := False;
  if ((GetTickCount - m_dwAutoAvoidTick) > 3000) and  m_boAutoAvoid then begin//�Ƿ��� 20080715
    if ((m_btJob > 0) or (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.25))) and m_boDoSpellMagic and (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) then begin
      m_dwAutoAvoidTick := GetTickCount();
      case m_btJob of
        1:if CheckTargetXYCount(m_nCurrX, m_nCurrY, 4) > 0 then Result := True;
        2:if CheckTargetXYCount(m_nCurrX, m_nCurrY, 3) > 0 then Result := True;
      end;
    end;
  end;
end;
//�Ƿ�����Ŀ�� 20080206
function TPlayMonster.IsNeedGotoXY(): Boolean;
begin
  Result := False;
  if (m_TargetCret <> nil) and ((GetTickCount - m_dwAutoAvoidTick) > 3000{3 * 1000}) and ((not m_boDoSpellMagic) or (m_btJob = 0)) then begin //սʿ
    if m_btJob > 0 then begin
      if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
        Result := True;
      end;
    end else begin//ս 20081205
      case m_nSelectMagic of
        12:begin//��ɱ
            m_nSelectMagic:= 0;
            if (wSkill_12 > 0) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, m_nTargetX, m_nTargetY)) then begin
              if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
                ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) then begin
                if m_Master <> nil then begin//�������ʱ�Ĺ����ٶ�
                  if GetTickCount - m_dwHitTick > g_Config.dwWarrorAttackTime then begin
                     m_dwHitTick := GetTickCount();
                     m_wHitMode:= 4;//��ɱ
                     m_dwTargetFocusTick := GetTickCount();
                     m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                     Attack(m_TargetCret, m_btDirection);
                     BreakHolySeizeMode();
                     Exit;
                  end;
                end else begin
                  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin//Ϊ����ʱ��DB���õĹ����ٶ�
                     m_dwHitTick := GetTickCount();
                     m_wHitMode:= 4;//��ɱ
                     m_dwTargetFocusTick := GetTickCount();
                     m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                     Attack(m_TargetCret, m_btDirection);
                     BreakHolySeizeMode();
                     Exit;
                  end;
                end;
              end else begin//new
                if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) then begin
                  Result := True;
                  Exit;
                end;
              end;
            end;

            if (wSkill_12 > 0) then begin
              if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
                Result := True;
                Exit;
              end;
            end else
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
              Result := True;
              Exit;
            end;
          end;//12
        74:begin//���ս���
            m_nSelectMagic:= 0;
            if (wSKILL_74 > 0) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY)) then begin
              if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<=4)) or
                 (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
                 ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=4)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=4))) then begin
                if m_Master <> nil then begin//�������ʱ�Ĺ����ٶ�
                  if GetTickCount - m_dwHitTick > g_Config.dwWarrorAttackTime then begin
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 13;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end else begin
                  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin//Ϊ����ʱ��DB���õĹ����ٶ�
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 13;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end;
              end else begin
                if (wSkill_12 > 0) then begin
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

            if (wSkill_12 > 0) then begin
              if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
                Result := True;
                Exit;
              end;
            end else
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
              Result := True;
              Exit;
            end;
         end;//74
        43:begin//ʵ�ָ�λ�ſ���
           m_nSelectMagic:= 0;
           if (wSKILL_42 > 0) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 5, m_nTargetX, m_nTargetY)) and (m_n42kill = 2) then begin
             if ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)<={4}5)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0)) or //20090105 �޸�
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)<={4}5)) or
               (((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2)) or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)=3)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=3))  or
               ((Abs(m_nCurrX-m_TargetCret.m_nCurrX)={4}5)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)={4}5))) then begin
                if m_Master <> nil then begin//�������ʱ�Ĺ����ٶ�
                  if GetTickCount - m_dwHitTick > g_Config.dwWarrorAttackTime then begin
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 9;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end else begin
                  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin//Ϊ����ʱ��DB���õĹ����ٶ�
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 9;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end;
             end else begin
               if (wSkill_12 > 0) then begin
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

           if (wSKILL_42 > 0) and (m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 2, m_nTargetX, m_nTargetY)) and (m_n42kill in [1,2]) then begin
             if (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=0) or
                (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=0)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2) or
                (Abs(m_nCurrX-m_TargetCret.m_nCurrX)=2)and(Abs(m_nCurrY-m_TargetCret.m_nCurrY)=2) then begin
                if m_Master <> nil then begin//�������ʱ�Ĺ����ٶ�
                  if GetTickCount - m_dwHitTick > g_Config.dwWarrorAttackTime then begin
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 9;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end else begin
                  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin//Ϊ����ʱ��DB���õĹ����ٶ�
                    m_dwHitTick := GetTickCount();
                    m_wHitMode:= 9;
                    m_dwTargetFocusTick := GetTickCount();
                    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
                    Attack(m_TargetCret, m_btDirection);
                    BreakHolySeizeMode();
                    Exit;
                  end;
                end;
             end else begin
                if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1)) then begin
                  Result := True;
                  Exit;
                end;
             end;
           end;

           if (wSkill_12 > 0) then begin
             if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2) then begin
               Result := True;
               Exit;
             end;
           end else
           if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
             Result := True;
             Exit;
           end;
        end;//43
        7, 25, 26:begin
          m_nSelectMagic:= 0;
          if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
            Result := True;
            Exit;
          end;        
        end else begin
          if (wSkill_12 > 0) then begin
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
    end;
  end;
end;

//ȡ�������ĵ�MPֵ
function TPlayMonster.GetSpellPoint(UserMagic: pTUserMagic): Integer;
begin
  Result := Round(UserMagic.MagicInfo.wSpell / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + UserMagic.MagicInfo.btDefSpell;
end;
//ʹ��ħ��
function TPlayMonster.DoSpellMagic(wMagIdx: Word): Boolean;
  function CheckActionStatus(): Boolean;//���Ӽ���������ļ�� 20080715
  begin
    Result := False;
    if GetTickCount - m_dwActionTick > 1000 then begin
      m_dwActionTick := GetTickCount();
      Result := True;
    end;
  end;
  function DoSpell(UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
  var
    nSpellPoint: Integer;
    boSpellFail: Boolean;
    boSpellFire: Boolean;
    nPower{, NGSecPwr}: Integer;
    nAmuletIdx: Integer;
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
    procedure DelUseItem();
    begin
      if m_UseItems[U_BUJUK].Dura < 100 then begin
        m_UseItems[U_BUJUK].Dura := 0;
        m_UseItems[U_BUJUK].wIndex := 0;
      end;
    end;
  begin
    Result := False;
    boSpellFail := False;
    boSpellFire := True;
    //nPower := 0; //20080415
    if (abs(m_nCurrX - nTargetX) > g_Config.nMagicAttackRage) or (abs(m_nCurrY - nTargetY) > g_Config.nMagicAttackRage) then begin
      Exit;
    end;
    if not CheckActionStatus() then Exit;//20080715
    if UserMagic.btLevel= 4 then begin//4������ �����,���,ħ���� 20080617
      if wMagIdx = SKILL_45 then
         SendRefMsg(RM_SPELL, 101, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '')
      else
      if wMagIdx = SKILL_FIRECHARM then
         SendRefMsg(RM_SPELL, 100, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '')
      else
      if wMagIdx = SKILL_66 then
         SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
    end else begin
      if wMagIdx <> SKILL_MOOTEBO then//�� Ұ����ײ �� 20081108
        SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
    end;
    if (TargeTBaseObject <> nil) and (TargeTBaseObject.m_boDeath) then TargeTBaseObject := nil;
    case wMagIdx of
      SKILL_LIGHTENING {11}: begin {�׵���}
         nSpellPoint := GetSpellPoint(UserMagic);
          if nSpellPoint > 0 then begin
            if m_WAbil.MP < nSpellPoint then Exit;
            DamageSpell(nSpellPoint);
            //HealthSpellChanged();
          end;
          if TargeTBaseObject <> nil then begin
            if IsProperTarget(TargeTBaseObject) then begin
              if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
                nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
                  SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
                if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);
                {if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
                  NGSecPwr:= 0;
                  if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                    NGSecPwr:= MagicManager.GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_223,nPower);//��֮�׵�
                  end else
                  if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                    NGSecPwr:= MagicManager.GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_223,nPower);//��֮�׵�
                  end;
                  nPower := _MAX(0, nPower - NGSecPwr);
                end;}
                SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
                Result := True;
              end else TargeTBaseObject := nil;
            end else TargeTBaseObject := nil;
          end; 
        end;
      SKILL_SHIELD {31},SKILL_66 {66}: begin //ħ���� �ļ�ħ���� 20080728
          if MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(m_WAbil.MC) + 15)) then Result := True;
        end;
      SKILL_73 {73}: begin //������  20080405
        if MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(m_WAbil.SC) + 15)) then Result := True;
       end;
      SKILL_75 {75}: begin //������� 20080107
          if GetTickCount()- m_boProtectionTick < g_Config.dwProtectionTick then Exit; //�������ʹ�ü�� 20080109
           if MagProtectionDefenceUp(UserMagic.btLevel) then Result := True;
        end;
      SKILL_SNOWWIND {33}: begin // ������ 
          if MagicManager.MagBigExplosion(Self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX,
            nTargetY,
            g_Config.nSnowWindRange, SKILL_SNOWWIND) then
            Result := True;
        end;
      SKILL_LIGHTFLOWER {24}: begin //�����׹�
          if MagicManager.MagElecBlizzard(Self, GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1)) then
            Result := True;
        end;
      SKILL_MOOTEBO{27}: begin //Ұ����ײ
         Result := True;
         boSpellFire := False;//20081108
         if GetAttackDir(TargeTBaseObject,m_btDirection) then begin//Ұ����ײ�ķ���
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
                   CheckMagicLevelup(UserMagic);
                 end;
               end;
             end;
           end;
         end;
      end;    
      SKILL_MABE :begin//����� 20080410
          with Self do begin
            nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
              SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
          end;
          if MabMabe(Self, TargeTBaseObject, nPower, UserMagic.btLevel, nTargetX, nTargetY) then Result := True;
        end;
      SKILL_45: begin //����� 20080410
          if MagMakeFireDay(Self, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then Result := True;
        end;
      SKILL_47: begin //������
          if MagicManager.MagBigExplosion(Self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX,
            nTargetY,
            g_Config.nFireBoomRage {1},SKILL_47) then
            Result := True;
        end;
      SKILL_58: begin //���ǻ��� 20080528
          if MagicManager.MagBigExplosion1(self,
            GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1),
            nTargetX, nTargetY, g_Config.nMeteorFireRainRage) then Result := True;
        end;
      {��ʿ}
      SKILL_AMYOUNSUL {6}: begin //ʩ����
          if MagicManager.MagLightening(Self, UserMagic, nTargetX, nTargetY, TargeTBaseObject, boSpellFail) then
            Result := True;
        end;
      SKILL_50:begin//�޼����� 20080405
          if AbilityUp(UserMagic) then Result := True;
        end;
      SKILL_51: begin //쫷��� 20080917
          if MagicManager.MagGroupFengPo(Self, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then Result := True;
        end;
      SKILL_48: begin //������ 20090111
          if MagicManager.MagPushArround(self, UserMagic.btLevel) > 0 then Result := True;
        end;
      SKILL_FIRECHARM {13},
      SKILL_HANGMAJINBUB {14},
      SKILL_DEJIWONHO {15},
      SKILL_59: begin
          boSpellFail := True;
          if CheckAmulet(Self, 1, 1, nAmuletIdx) then begin
            UseAmulet(Self, 1, 1, nAmuletIdx);
            case wMagIdx of
              SKILL_FIRECHARM {13}: begin //�����
                  if MagicManager.MagMakeFireCharm(Self,
                    UserMagic,
                    nTargetX,
                    nTargetY,
                    TargeTBaseObject) then Result := True;
                end;
              SKILL_HANGMAJINBUB {14}: begin //�����
                  nPower := GetAttackPower(GetPower13(60) + LoWord(m_WAbil.SC) * 10, SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
                  if MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 1) > 0 then
                    Result := True;
                end;
              SKILL_DEJIWONHO {15}: begin //��ʥս����
                  nPower := GetAttackPower(GetPower13(60) + LoWord(m_WAbil.SC) * 10, SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1);
                  if MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 0) > 0 then
                    Result := True;
                end;
              SKILL_59: begin//��Ѫ�� 20080528
                   if MagicManager.MagFireCharmTreatment(self,UserMagic, nTargetX, nTargetY, TargeTBaseObject) then Result := True;
                end;
            end;
            boSpellFail := False;
            DelUseItem();
          end;
        end;
      SKILL_GROUPAMYOUNSUL {38 Ⱥ��ʩ����}: begin
          boSpellFail := True;
          if CheckAmulet(Self, 1, 2, nAmuletIdx) then begin
            UseAmulet(Self, 1, 2, nAmuletIdx);
            if MagicManager.MagGroupAmyounsul(Self, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
              Result := True;
            boSpellFail := False;
            DelUseItem();
          end;
        end;
      SKILL_BIGHEALLING {29}: begin //Ⱥ��������
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC) * 2,
            SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) * 2 + 1);
          if MagicManager.MagBigHealing(Self, nPower, nTargetX, nTargetY) then Result := True;
        end;
    end;
    m_dwActionTick := GetTickCount();//20080715
    m_dwHitTick := GetTickCount();//20080715
    m_boAutoAvoid:= True;//�Ƿ��ܶ�� 20080715
    
    if boSpellFire then begin
      if UserMagic.btLevel= 4 then begin//4������ ����� ��� 20080617
        if wMagIdx = SKILL_45 then
          SendRefMsg(RM_MAGICFIRE, 0, MakeWord(UserMagic.MagicInfo.btEffectType, 101),MakeLong(nTargetX, nTargetY),Integer(TargeTBaseObject),'')
        else
        if wMagIdx = SKILL_FIRECHARM then
          SendRefMsg(RM_MAGICFIRE, 0, MakeWord(UserMagic.MagicInfo.btEffectType, 100),MakeLong(nTargetX, nTargetY),Integer(TargeTBaseObject),'');
      end else
      SendRefMsg(RM_MAGICFIRE, 0,
        MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
        MakeLong(nTargetX, nTargetY),
        Integer(TargeTBaseObject),
        '');
    end;
  end;
var
  BaseObject: TBaseObject;
  I: Integer;
  nSpellPoint: Integer;
  UserMagic: pTUserMagic;
  nNewTargetX: Integer;
  nNewTargetY: Integer;
begin
  Result := False;
  Try
    case wMagIdx of
      SKILL_ERGUM {12}: begin //��ɱ����
          if m_MagicErgumSkill <> nil then begin
            if not m_boUseThrusting then begin
              m_boUseThrusting := True;
            end else begin
              m_boUseThrusting := False;
            end;
          end;
          Result := True;
        end;
      SKILL_BANWOL {25}: begin //�����䵶
          if m_MagicBanwolSkill <> nil then begin
            if not m_boUseHalfMoon then begin
              m_boUseHalfMoon := True;
            end else begin
              m_boUseHalfMoon := False;
            end;
          end;
          Result := True;
          Exit;
        end;
      SKILL_FIRESWORD {26}: begin //�һ𽣷�
          if m_MagicFireSwordSkill <> nil then begin
            if AllowFireHitSkill then begin
              nSpellPoint := GetSpellPoint(m_MagicFireSwordSkill);
              if m_WAbil.MP >= nSpellPoint then begin
                if nSpellPoint > 0 then begin
                  DamageSpell(nSpellPoint);
                  //HealthSpellChanged();
                end;
              end;
            end;
          end;
          Result := True;
          Exit;
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
          Exit;
        end;
      SKILL_42: begin //����ն
          if m_Magic42Skill <> nil then begin
            if Skill42OnOff then begin
              nSpellPoint := GetSpellPoint(m_Magic42Skill{UserMagic});//20080522
              if m_WAbil.MP >= nSpellPoint then begin
                if nSpellPoint > 0 then begin
                  DamageSpell(nSpellPoint);
                  HealthSpellChanged();
                end;
              end;
            end;
          end;
          Result := True;
          Exit;
        end;
      SKILL_43: begin //��Ӱ����
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
          Exit;
       end;
      SKILL_40: begin //���µ���
          if m_MagicCrsSkill <> nil then begin
            if not m_boCrsHitkill then begin
              SkillCrsOnOff(True);
            end else begin
              SkillCrsOnOff(False);
            end;
          end;
          Result := True;
          Exit;
        end;
    else begin {ʹ��ħ��}
        nNewTargetX := 0;//20080522
        nNewTargetY := 0;//20080522
        if m_MagicList.Count > 0 then begin//20080630
          for I := 0 to m_MagicList.Count - 1 do begin
            UserMagic := m_MagicList.Items[I];
            if (UserMagic <> nil) and (UserMagic.wMagIdx = wMagIdx) then begin
              m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
              BaseObject := nil;
                //���Ŀ���ɫ����Ŀ��������Χ���������Χ��������Ŀ������
              if CretInNearXY(m_TargetCret, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY) then begin
                BaseObject := m_TargetCret;
                nNewTargetX := BaseObject.m_nCurrX;
                nNewTargetY := BaseObject.m_nCurrY;
              end;
              if wMagIdx in [SKILL_DEJIWONHO,SKILL_HANGMAJINBUB] then begin //����� ��ʥս����,�����,���Ŀ������Ϊ�Լ�  20080610 ԭ��ע��
                BaseObject := Self;
                nNewTargetX := m_nCurrX;
                nNewTargetY := m_nCurrY;
              end;
              Result := DoSpell(UserMagic, nNewTargetX, nNewTargetY, BaseObject);
              Break;
            end;
          end;//for
        end;
      end;
    end;
  except
  end;
end;

function TPlayMonster.WarrAttackTarget(wHitMode: Word): Boolean; {������}
var
  bt06: Byte;
begin
  Result := False;
  if m_TargetCret <> nil then begin
    if (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) and (m_TargetCret.m_Abil.Level <= 22) and (THEROOBJECT(m_TargetCret).m_btStatus = 1) then  begin//20080510 Ӣ��22��ǰ,����ʱ����
       DelTargetCreat();
       Exit;
    end else
    if m_boProtectStatus then begin //�ػ�״̬ 20090105
      if (abs(m_nCurrX - m_nProtectTargetX) > 13) or (abs(m_nCurrY - m_nProtectTargetY) > 13) then begin
        DelTargetCreat();
        Exit;
      end;
    end;
    if GetAttackDir(m_TargetCret, bt06) then begin
      m_dwTargetFocusTick := GetTickCount();
      Attack(m_TargetCret, bt06);
      BreakHolySeizeMode();
      Result := True;
    end else begin                              
      if (m_TargetCret.m_PEnvir = m_PEnvir) then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 12) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 12) then begin //20080605 ����
          SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
        end;
      end else begin
        DelTargetCreat();
      end;
    end;
  end;
end;

procedure TPlayMonster.EatMedicine(); {��ҩ}
var
  n01: Integer;
begin
  if (m_nCopyHumanLevel > 0) and (m_ItemList.Count > 0) then begin
    if m_WAbil.HP < (m_WAbil.MaxHP * g_Config.nCopyHumAddHPRate) div 100 then begin
      n01 := 0;
      while m_WAbil.HP < m_WAbil.MaxHP do begin {������������ƿ}
        if n01 >= 2 then Break;
        EatUseItems(0);
        if m_ItemList.Count = 0 then Break;
        Inc(n01);
      end;
    end;
    if m_WAbil.MP < (m_WAbil.MaxMP * g_Config.nCopyHumAddMPRate) div 100 then begin
      n01 := 0;
      while m_WAbil.MP < m_WAbil.MaxMP do begin {������������ƿ}
        if n01 >= 2 then Break;
        EatUseItems(1);
        if m_ItemList.Count = 0 then Break;
        Inc(n01);
      end;
    end;
    if (m_ItemList.Count = 0) or (m_WAbil.HP < (m_WAbil.MaxHP * 20) div 100) or (m_WAbil.MP < (m_WAbil.MaxMP * 20) div 100) then begin
      if m_VisibleItems.Count > 0 then begin
        //m_boPickUpItemOK := False;//20080428 ע��
        SearchPickUpItem(500);
      end;
    end
  end;
end;

{���ָ������ͷ�Χ������Ĺ�������}
function TPlayMonster.CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;
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
                  if (abs(nX - BaseObject.m_nCurrX) <= nRange) and ((BaseObject.m_nCurrY - nY) in [0, nRange]) then Inc(Result);
                end;
              DR_UPRIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0, nRange]) and ((BaseObject.m_nCurrY - nY) in [0, nRange]) then Inc(Result);
                end;
              DR_RIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0, nRange]) and (abs(nY - BaseObject.m_nCurrY) <= nRange) then Inc(Result);
                end;
              DR_DOWNRIGHT: begin
                  if ((BaseObject.m_nCurrX - nX) in [0, nRange]) and ((nY - BaseObject.m_nCurrY) in [0, nRange]) then Inc(Result);
                end;
              DR_DOWN: begin
                  if (abs(nX - BaseObject.m_nCurrX) <= nRange) and ((nY - BaseObject.m_nCurrY) in [0, nRange]) then Inc(Result);
                end;
              DR_DOWNLEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0, nRange]) and ((nY - BaseObject.m_nCurrY) in [0, nRange]) then Inc(Result);
                end;
              DR_LEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0, nRange]) and (abs(nY - BaseObject.m_nCurrY) <= nRange) then Inc(Result);
                end;
              DR_UPLEFT: begin
                  if ((nX - BaseObject.m_nCurrX) in [0, nRange]) and ((BaseObject.m_nCurrY - nY) in [0, nRange]) then Inc(Result);
                end;
            end;
            if Result > 2 then Break;
          end;
        end;
      end;
    end;
  end;
end;
//սʿ���� �д���һ���Ż�
function TPlayMonster.WarrorAttackTarget(): Boolean;
  procedure SelectMagic();
  begin
    //Զ�������ÿ����ػ��������ս��� 20081211
    if ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1{2}) and (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 5)) or //20090105 �޸�,���ڻ�С��5
      ((abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1{2}) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 5)) then begin
      if (wSKILL_42 > 0) and ((GetTickCount - m_dwLatest42Tick) > g_Config.nKill43UseTime * 1000) then begin
        m_n42kill := 2;//�ػ�
        if not m_bo42kill then DoSpellMagic(SKILL_42); //�򿪿���
        m_nSelectMagic:= 43;//��ѯħ�� 20081206
        if m_bo42kill then Exit;
      end;
      if (wSKILL_74 > 0) and ((GetTickCount - m_dwLatestDailyTick) > 12000{12 * 1000}) then begin //���ս���
        if not m_boDailySkill then DoSpellMagic(SKILL_74);//�����ս���
        m_nSelectMagic:= 74;//��ѯħ�� 20081206
        Exit;
      end;
    end;
    //��ɱλ 20081204
    if (abs(m_TargetCret.m_nCurrX - m_nCurrX) = 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) = 2) then begin
      if (wSkill_12 > 0) then begin //��ɱ����
        if not m_boUseThrusting then DoSpellMagic(SKILL_ERGUM);
        m_nSelectMagic:= 12;//��ѯħ�� 20081206
        exit;
      end;
    end;
    
    if (wSKILL_42 > 0) and ((GetTickCount - m_dwLatest42Tick) > g_Config.nKill43UseTime * 1000) then begin //����ն  20080203
       if Random(g_Config.n43KillHitRate) = 0 then begin  //���� ������� 20080213
         m_n42kill := 2;
       end else begin
         m_n42kill := 1;
       end;
       if not m_bo42kill then DoSpellMagic(SKILL_42); //�򿪿���
       m_nSelectMagic:= 43;//��ѯħ�� 20081206
       if m_bo42kill then Exit;
    end;
    if (SKILL_43 > 0) and ((GetTickCount - m_dwLatest43Tick) > g_Config.nKill42UseTime * 1000) then begin//20080619 ��Ӱ����
      if not m_bo43kill then DoSpellMagic(SKILL_43);
      if m_bo43kill then Exit;
    end;

    if m_boFireHitSkill then DoSpellMagic(SKILL_FIRESWORD );//�ر��һ�
    if m_boUseThrusting then DoSpellMagic(SKILL_ERGUM);     //�رմ�ɱ
    if m_boUseHalfMoon then DoSpellMagic(SKILL_BANWOL);     //�رհ���
    if m_boCrsHitkill then DoSpellMagic(SKILL_40);          //�رյ���
    //if m_bo43kill then DoSpellMagic(SKILL_43);            //�ر���Ӱ
    if m_boDailySkill then DoSpellMagic(SKILL_74);          //�ر����ս��� 20080528 20080619 ע��
    if (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 2) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 2) then begin//Ŀ�����ʱ
      case Random(5) of
        0:begin
           if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD); //ʹ���һ�
             m_nSelectMagic:= 26;//��ѯħ�� 20081206
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//�����ս��� 20080528
             m_nSelectMagic:= 74;//��ѯħ�� 20081206
           end else if (wSkill_12 > 0) then begin
             DoSpellMagic(SKILL_ERGUM);//�򿪴�ɱ
             m_nSelectMagic:= 12;//��ѯħ�� 20081206
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//�򿪰���
             m_nSelectMagic:= 25;//��ѯħ�� 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40);   //���µ���
        end;
        1:begin
           if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//�����ս��� 20080528
             m_nSelectMagic:= 74;//��ѯħ�� 20081206
           end else if (wSkill_12 > 0) then begin
             DoSpellMagic(SKILL_ERGUM);//�򿪴�ɱ
             m_nSelectMagic:= 12;//��ѯħ�� 20081206
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//�򿪰���
             m_nSelectMagic:= 25;//��ѯħ�� 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)        //���µ���
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD);//ʹ���һ�
             m_nSelectMagic:= 26;//��ѯħ�� 20081206
           end;
        end;
        2:begin
           if (wSkill_12 > 0) then begin
             DoSpellMagic(SKILL_ERGUM);//�򿪴�ɱ
             m_nSelectMagic:= 12;//��ѯħ�� 20081206
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//�򿪰���
             m_nSelectMagic:= 25;//��ѯħ�� 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)        //���µ���
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD); //ʹ���һ�
             m_nSelectMagic:= 26;//��ѯħ�� 20081206
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//�����ս��� 20080528
             m_nSelectMagic:= 74;//��ѯħ�� 20081206
           end;  
        end;
        3:begin
           if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//�򿪰���
             m_nSelectMagic:= 25;//��ѯħ�� 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)//���µ���
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD);//ʹ���һ�
             m_nSelectMagic:= 26;//��ѯħ�� 20081206
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//�����ս��� 20080528
             m_nSelectMagic:= 74;//��ѯħ�� 20081206
           end else if (wSkill_12 > 0) then begin
             DoSpellMagic(SKILL_ERGUM);    //�򿪴�ɱ
             m_nSelectMagic:= 12;//��ѯħ�� 20081206
           end;
        end;
        4:begin
           if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)            //���µ���
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD);//ʹ���һ�
             m_nSelectMagic:= 26;//��ѯħ�� 20081206
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//�����ս��� 20080528
             m_nSelectMagic:= 74;//��ѯħ�� 20081206
           end else if (wSkill_12 > 0) then begin
             DoSpellMagic(SKILL_ERGUM);//�򿪴�ɱ
             m_nSelectMagic:= 12;//��ѯħ�� 20081206
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL); //�򿪰���
             m_nSelectMagic:= 25;//��ѯħ�� 20081206
           end;
        end;
      end;//Case Random(4) of
    end else begin//Ŀ�겻����
      case Random({5}4) of//20080619
        0:begin
           if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD); //ʹ���һ�
             m_nSelectMagic:= 26;//��ѯħ�� 20081206
           //else if (wSKILL_43 > 0) then DoSpellMagic(SKILL_43)    //����Ӱ   20080619 ע��
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//�����ս��� 20080528
             m_nSelectMagic:= 74;//��ѯħ�� 20081206
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//�򿪰���
             m_nSelectMagic:= 25;//��ѯħ�� 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40);   //���µ���
        end;
       { 1:begin                                                                  20080619 ע��
           if (wSKILL_43 > 0) then DoSpellMagic(SKILL_43)             //����Ӱ
           else if (wSKILL_74 > 0) then DoSpellMagic(SKILL_74)    //�����ս��� 20080528
           else if (wSkill_13 > 0) then DoSpellMagic(SKILL_BANWOL)    //�򿪰���
           else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)        //���µ���
           else if (wSkill_11 > 0) then DoSpellMagic(SKILL_FIRESWORD);//ʹ���һ�
        end;  }
        1:begin
           if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//�����ս��� 20080528
             m_nSelectMagic:= 74;//��ѯħ�� 20081206
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//�򿪰���
             m_nSelectMagic:= 25;//��ѯħ�� 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)       //���µ���
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD);//ʹ���һ�
             m_nSelectMagic:= 26;//��ѯħ�� 20081206
           end;
           //else if (wSKILL_43 > 0) then DoSpellMagic(SKILL_43);      //����Ӱ  20080619 ע��
        end;
        2:begin
           if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)             //���µ���
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD); //ʹ���һ�
             m_nSelectMagic:= 26;//��ѯħ�� 20081206
           //else if (wSKILL_43 > 0) then DoSpellMagic(SKILL_43)        //����Ӱ  20080619 ע��
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//�����ս��� 20080528
             m_nSelectMagic:= 74;//��ѯħ�� 20081206
           end else if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);   //�򿪰���
             m_nSelectMagic:= 25;//��ѯħ�� 20081206
           end;
        end;
        3:begin
           if (wSkill_13 > 0) then begin
             DoSpellMagic(SKILL_BANWOL);//�򿪰���
             m_nSelectMagic:= 25;//��ѯħ�� 20081206
           end else if (wSKILL_40 > 0) then DoSpellMagic(SKILL_40)       //���µ���
           else if (wSkill_11 > 0) then begin
             DoSpellMagic(SKILL_FIRESWORD);//ʹ���һ�
             m_nSelectMagic:= 26;//��ѯħ�� 20081206
           //else if (wSKILL_43 > 0) then DoSpellMagic(SKILL_43)      //����Ӱ   20080619 ע��
           end else if (wSKILL_74 > 0) then begin
             DoSpellMagic(SKILL_74);//�����ս��� 20080528
             m_nSelectMagic:= 74;//��ѯħ�� 20081206
           end;  
        end;
      end;//Case Random(4) of
    end;
  end;
begin
  Result := False;
  try
    m_wHitMode := 0;
    if m_WAbil.MP > 0 then begin
      //20080420 ����
      if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) or ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 2) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 2)) then begin//ħ�����ܴ򵽹� 20080420
         if (m_Master <> nil) and ((abs(m_Master.m_nCurrX - m_nCurrX) >= 7) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 7)) then begin
           m_TargetCret:= nil;
           Exit;
         end else GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
      if (wSkill_75 > 0) and (m_wStatusTimeArr[STATE_ProtectionDEFENCE] = 0) and (not m_boProtectionDefence) and
        (GetTickCount - m_boProtectionTick > g_Config.dwProtectionTick) then DoSpellMagic(wSkill_75);//������� 20080405

      if (wSKILL_27 > 0) and ((GetTickCount - m_dwDoMotaeboTick) > 10000) and (m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.8)) then begin
         if m_TargetCret <> nil then begin
           if (m_TargetCret.m_Abil.Level < m_Abil.Level) then begin
             m_dwDoMotaeboTick := GetTickCount();
             DoSpellMagic(wSkill_27);//Ұ����ײ 20081016
             Exit;
           end;
         end;
      end;

      SelectMagic();//20080405 �޸�

      if m_boUseThrusting then m_wHitMode := 4 //ʹ�ô�ɱ
      else if m_boUseHalfMoon then m_wHitMode := 5 //ʹ�ð���
      else if m_boCrsHitkill then m_wHitMode := 8//�����䵶 20080410
      else if m_bo43kill then m_wHitMode := 12//ʹ����Ӱ���� 20080201
      else if m_bo42kill then m_wHitMode := 9 //ʹ�ÿ���ն 20080201
      else if m_boFireHitSkill then m_wHitMode := 7 //ʹ���һ�
      else if m_boDailySkill then m_wHitMode := 13; //ʹ�����ս��� 20080528
    end;
    Result := WarrAttackTarget(m_wHitMode);
    if Result then m_dwHitTick := GetTickCount();//20080715 ����
    //if m_WAbil.HP <= Round(m_WAbil.MaxHP * 0.25) then m_boAutoAvoid:= True;//�Ƿ��ܶ�� 20080715 20081217ע��
  except
  end;
end;
//���ʹ�õ�ħ��
function TPlayMonster.CheckUserMagic(wMagIdx: Word): Integer;
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  Result := 0;
  if m_MagicList.Count > 0 then begin//20080630
    for I := 0 to m_MagicList.Count - 1 do begin
      UserMagic := m_MagicList.Items[I];
      if UserMagic.MagicInfo.wMagicId = wMagIdx then begin
        Result := wMagIdx;
        Break;
      end;
    end;
  end;
end;
//ȡָ�����귶Χ�ڵ�Ŀ������
function TPlayMonster.CheckTargetXYCount(nX, nY, nRange: Integer): Integer;
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
              if Result > 2 then Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TPlayMonster.WizardAttackTarget(): Boolean; {��ʦ����}
  function SearchDoSpell: Integer;
  begin
    Result := 0;
    if (wSkill_75 > 0) and (m_wStatusTimeArr[STATE_ProtectionDEFENCE] = 0) and (not m_boProtectionDefence)
    and (GetTickCount - m_boProtectionTick > g_Config.dwProtectionTick) then begin {ʹ�� ������� 20080107}
      Result := wSkill_75;
      Exit;
    end;
    if (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP ] = 0) and (not m_boAbilMagBubbleDefence) then begin{ʹ�� ħ����}
      if (wSkill_66 > 0) then begin
        Result := wSkill_66;
        Exit;
      end else
      if (wSkill_05 > 0) then begin
        Result := wSkill_05;
        Exit;
      end;
    end;

    if CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1 then begin//ȡָ�����귶Χ�ڵ�Ŀ������
      if (abs(m_TargetCret.m_nCurrX - m_nCurrX) <= 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) <= 1) then begin
        if (m_Master <> nil) and (wSkill_02 > 0) then begin//20080803 ���ο���ʹ�õ����׹�
           if m_TargetCret.m_btRaceServer in [91,92,97,101,102,104] then begin
             Result := wSkill_02;
             Exit;
           end;
        end;
        if (wSkill_02 > 0) and (m_Master = nil) then Result := wSkill_02
        else if wSkill_03 > 0 then Result := wSkill_03
        else if wSkill_04 > 0 then Result := wSkill_04
        else if wSkill_01 > 0 then Result := wSkill_01
        else if wSKILL_45 > 0 then Result := wSKILL_45;//20080410
        Exit;
      end else begin
        if (wSkill_03 > 0) and (wSkill_04 > 0) and (wSKILL_45 > 0) and (wSKILL_36 > 0) and (wSKILL_58 > 0) then begin
          case Random(5) of
            0: Result := wSkill_03;
            1: Result := wSkill_04;
            2: Result := wSKILL_45;
            3: Result := wSKILL_36;
            4: Result := wSKILL_58;
          end;
          Exit;
        end else begin
          case Random(6) of
            0:begin
                if wSKILL_45 > 0 then Result := wSKILL_45 //20080410
                else if wSkill_03 > 0 then Result := wSkill_03
                else if wSkill_04 > 0 then Result := wSkill_04
                else if wSkill_36 > 0 then Result := wSkill_36
                else if wSkill_58 > 0 then Result := wSkill_58
                else if wSkill_01 > 0 then Result := wSkill_01;
             end;
            1:begin
               if wSkill_03 > 0 then Result := wSkill_03
               else if wSkill_04 > 0 then Result := wSkill_04
               else if wSkill_36 > 0 then Result := wSkill_36
               else if wSkill_58 > 0 then Result := wSkill_58
               else if wSkill_01 > 0 then Result := wSkill_01
               else if wSKILL_45 > 0 then Result := wSKILL_45;
             end;
             2:begin
               if wSkill_04 > 0 then Result := wSkill_04
               else if wSkill_36 > 0 then Result := wSkill_36
               else if wSkill_58 > 0 then Result := wSkill_58
               else if wSkill_01 > 0 then Result := wSkill_01
               else if wSKILL_45 > 0 then Result := wSKILL_45
               else if wSkill_03 > 0 then Result := wSkill_03;
             end;
             3:begin
               if wSkill_36 > 0 then Result := wSkill_36
               else if wSkill_58 > 0 then Result := wSkill_58
               else if wSkill_01 > 0 then Result := wSkill_01
               else if wSKILL_45 > 0 then Result := wSKILL_45
               else if wSkill_03 > 0 then Result := wSkill_03
               else if wSkill_04 > 0 then Result := wSkill_04;
             end;
             4:begin
               if wSkill_01 > 0 then Result := wSkill_01
               else if wSKILL_45 > 0 then Result := wSKILL_45
               else if wSkill_03 > 0 then Result := wSkill_03
               else if wSkill_04 > 0 then Result := wSkill_04
               else if wSkill_36 > 0 then Result := wSkill_36
               else if wSkill_58 > 0 then Result := wSkill_58;
             end;
             5:begin
               if wSkill_58 > 0 then Result := wSkill_58
               else if wSkill_01 > 0 then Result := wSkill_01
               else if wSKILL_45 > 0 then Result := wSKILL_45
               else if wSkill_03 > 0 then Result := wSkill_03
               else if wSkill_04 > 0 then Result := wSkill_04
               else if wSkill_36 > 0 then Result := wSkill_36;
             end;
          end;
          {if wSKILL_45 > 0 then Result := wSKILL_45 //20080410
          else if wSkill_03 > 0 then Result := wSkill_03
          else if wSkill_04 > 0 then Result := wSkill_04
          else if wSkill_36 > 0 then Result := wSkill_36
          else if wSkill_01 > 0 then Result := wSkill_01;}
          Exit;
        end;
      end;
    end else begin
      {if wSkill_01 > 0 then Result := wSkill_01
      else if wSkill_03 > 0 then Result := wSkill_03
      else if wSkill_36 > 0 then Result := wSkill_36
      else if wSkill_45 > 0 then Result := wSkill_45
      else if wSkill_04 > 0 then Result := wSkill_04; }
      case Random(6) of
        0:begin
            if wSKILL_45 > 0 then Result := wSKILL_45 //20080410
            else if wSkill_03 > 0 then Result := wSkill_03
            else if wSkill_04 > 0 then Result := wSkill_04
            else if wSkill_36 > 0 then Result := wSkill_36
            else if wSkill_58 > 0 then Result := wSkill_58
            else if wSkill_01 > 0 then Result := wSkill_01;
         end;
        1:begin
           if wSkill_03 > 0 then Result := wSkill_03
           else if wSkill_04 > 0 then Result := wSkill_04
           else if wSkill_36 > 0 then Result := wSkill_36
           else if wSkill_58 > 0 then Result := wSkill_58
           else if wSkill_01 > 0 then Result := wSkill_01
           else if wSKILL_45 > 0 then Result := wSKILL_45;
         end;
         2:begin
           if wSkill_04 > 0 then Result := wSkill_04
           else if wSkill_36 > 0 then Result := wSkill_36
           else if wSkill_58 > 0 then Result := wSkill_58
           else if wSkill_01 > 0 then Result := wSkill_01
           else if wSKILL_45 > 0 then Result := wSKILL_45
           else if wSkill_03 > 0 then Result := wSkill_03;
         end;
         3:begin
           if wSkill_36 > 0 then Result := wSkill_36
           else if wSkill_58 > 0 then Result := wSkill_58
           else if wSkill_01 > 0 then Result := wSkill_01
           else if wSKILL_45 > 0 then Result := wSKILL_45
           else if wSkill_03 > 0 then Result := wSkill_03
           else if wSkill_04 > 0 then Result := wSkill_04;
         end;
         4:begin
           if wSkill_01 > 0 then Result := wSkill_01
           else if wSKILL_45 > 0 then Result := wSKILL_45
           else if wSkill_03 > 0 then Result := wSkill_03
           else if wSkill_04 > 0 then Result := wSkill_04
           else if wSkill_36 > 0 then Result := wSkill_36
           else if wSkill_58 > 0 then Result := wSkill_58;
         end;
         5:begin
           if wSkill_58 > 0 then Result := wSkill_58
           else if wSKILL_45 > 0 then Result := wSKILL_45
           else if wSkill_03 > 0 then Result := wSkill_03
           else if wSkill_04 > 0 then Result := wSkill_04
           else if wSkill_36 > 0 then Result := wSkill_36
           else if wSkill_01 > 0 then Result := wSkill_01;
         end;
      end;
    end;
  end;
var
  nMagicID: Integer;
  nCode:Byte;
begin
  Result := False;
  nCode:= 0;
try
  m_wHitMode := 0;
  if m_boDoSpellMagic and (m_TargetCret <> nil) then begin//20080711����
    nCode:= 1;
    nMagicID := SearchDoSpell;
    nCode:= 5;
    if nMagicID = 0 then m_boAutoAvoid:= True;//�Ƿ��ܶ�� 20080715
    nCode:= 6;
    if nMagicID > 0 then begin
      nCode:= 2;
      //20080420 ����
      if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) or ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 7) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 7)) then begin//ħ�����ܴ򵽹� 20080420
         if (m_Master <> nil) and ((abs(m_Master.m_nCurrX - m_nCurrX) >= 7) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 7)) then begin
           nCode:= 3;
           m_TargetCret:= nil;
           Exit;
         end else GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
      nCode:= 4;
      if not DoSpellMagic(nMagicID) then begin
        SendRefMsg(RM_MAGICFIREFAIL, 0, 0, 0, 0, '');
      end;
      Result := True;
    end else Result := WarrAttackTarget(m_wHitMode);
  end else Result := WarrAttackTarget(m_wHitMode);
  m_dwHitTick := GetTickCount();//20080715 ����
  except
    MainOutMessage('{�쳣} TPlayMonster.WizardAttackTarget:'+inttostr(nCode));
  end;
end;

{��ʿ--��������Ƿ��з���}
function TPlayMonster.CheckItemType(nItemType: Integer; StdItem: pTStdItem ; nItemShape: Integer): Boolean;
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
//�ж�װ�����Ƿ���ָ������Ʒ
function TPlayMonster.CheckUserItemType(nItemType: Integer; nItemShape: Integer): Boolean;
var
  StdItem: pTStdItem;
begin
  Result := False;
  if m_UseItems[U_BUJUK].wIndex > 0 then begin
    StdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
    if StdItem <> nil then begin
      Result := CheckItemType(nItemType, StdItem, nItemShape);
    end;
  end;
end;

function TPlayMonster.UseItem(nItemType, nIndex: Integer; nItemShape: Integer): Boolean; //�Զ�������
var
  UserItem: pTUserItem;
  AddUserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := False;
  if (nIndex >= 0) and (nIndex < m_ItemList.Count) then begin
    UserItem := m_ItemList.Items[nIndex];
    if m_UseItems[U_BUJUK].wIndex > 0 then begin
      StdItem := UserEngine.GetStdItem(m_UseItems[U_BUJUK].wIndex);
      if StdItem <> nil then begin
        if CheckItemType(nItemType, StdItem ,nItemShape) then begin
          Result := True;
        end else begin
          m_ItemList.Delete(nIndex);
          New(AddUserItem);
          AddUserItem^ := m_UseItems[U_BUJUK];
          if AddItemToBag(AddUserItem) then begin
            m_UseItems[U_BUJUK] := UserItem^;
            Dispose(UserItem);
            Result := True;
          end else m_ItemList.Add(UserItem);
        end;
      end else begin
        m_ItemList.Delete(nIndex);
        m_UseItems[U_BUJUK] := UserItem^;
        Dispose(UserItem);
        Result := True;
      end;
    end else begin
      m_ItemList.Delete(nIndex);
      m_UseItems[U_BUJUK] := UserItem^;
      Dispose(UserItem);
      Result := True;
    end;
  end;
end;

//���������Ƿ��з��Ͷ�
//nType Ϊָ������ 1 Ϊ����� 2 Ϊ��ҩ
function TPlayMonster.GetUserItemList(nItemType: Integer; nItemShape: Integer): Integer;
var
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  Result := -1;
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
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TPlayMonster.TaoistAttackTarget(): Boolean; {��ʿ����}
  function SearchDoSpell: Integer;
    function GetMagic01: Integer;
    begin
      Result := 0;
      {if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and
        (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) then begin
        if (CheckUserItemType(2) or (GetUserItemList(2) >= 0)) then begin
          if wSkill_10 > 0 then Result := wSkill_10 else if wSkill_06 > 0 then Result := wSkill_06;
        end;
      end;}
      if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0)  and ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin  {�̶�}
        if wSkill_10 > 0 then Result := wSkill_10 else if wSkill_06 > 0 then Result := wSkill_06;
      end;
      if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0)  and ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then begin {�춾}
        if wSkill_10 > 0 then Result := wSkill_10 else if wSkill_06 > 0 then Result := wSkill_06;
      end;
    end;
    function GetMagic02: Integer;
    begin
      Result := 0;
      {if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and
        (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) then begin
        if (CheckUserItemType(2) or (GetUserItemList(2) >= 0)) then begin
          if wSkill_06 > 0 then Result := wSkill_06 else if wSkill_10 > 0 then Result := wSkill_10;
        end;
      end; }
      if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and (m_TargetCret.m_btRaceServer <> 128) and ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin  {�̶�}
        if wSkill_06 > 0 then Result := wSkill_06 else if wSkill_10 > 0 then Result := wSkill_10;
      end;
      if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and (m_TargetCret.m_btRaceServer <> 128) and ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then begin {�춾}
        if wSkill_06 > 0 then Result := wSkill_06 else if wSkill_10 > 0 then Result := wSkill_10;
      end;
    end;
    function GetMagic03: Integer;
    begin
      Result := 0;
      if CheckUserItemType(1,0) or (GetUserItemList(1,0) >= 0) then begin
        case Random(2) of
          0: begin
             if wSkill_07 > 0 then Result := wSkill_07//�����
             else if wSkill_59 > 0 then Result := wSkill_59;//��Ѫ��
           end;
          1: begin
             if wSkill_59 > 0 then Result := wSkill_59//��Ѫ��
             else if wSkill_07 > 0 then Result := wSkill_07;//�����
           end;
        end;//case Random(2) of
      end;
    end;

  begin
    Result := 0;
    try
      if m_TargetCret = nil then Exit;//20080806 ����
      if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 1) and (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 1) then begin
        if (wSkill_08 > 0) and (m_wStatusTimeArr[STATE_DEFENCEUP] = 0) and (CheckUserItemType(1,0) or (GetUserItemList(1,0) >= 0)) then begin
          Result := wSkill_08; {ʹ����ʥս����}
          Exit;
        end;
        if (wSkill_14 > 0) and (m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0) and (CheckUserItemType(1,0) or (GetUserItemList(1,0) >= 0)) then begin
          Result := wSkill_14; {ʹ������� 20080405}
          Exit;
        end;
      end;

      if (wSkill_50 > 0) and (m_wStatusArrValue[2]= 0) and (GetTickCount - m_nSkill_5Tick > 15000) then begin //�޼�����
        m_nSkill_5Tick:= GetTickCount();//�޼�����ʹ�ü�� 20080605
        Result := wSkill_50;
        Exit;
      end;

      if (wSkill_75 > 0) and (m_wStatusTimeArr[STATE_ProtectionDEFENCE] = 0) and (not m_boProtectionDefence)
      and (GetTickCount - m_boProtectionTick > g_Config.dwProtectionTick) then begin {ʹ�� ������� 20080107}
        Result := wSkill_75;
        Exit;
      end else
      if (wSkill_73 > 0) and (m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP ] = 0) and (wSkill_75 = 0) then begin {ʹ�� ������ 20080405}
        Result := wSkill_73;
        Exit;
      end;

      if wSkill_51 > 0 then begin
        if Random(4) = 0 then begin
          Result := wSkill_51;//쫷��� 20080917
          Exit;
        end;
      end;
      if wSkill_48 > 0 then begin
        if (CheckTargetXYCount(m_nCurrX, m_nCurrY, 1) > 0) and (m_TargetCret.m_WAbil.Level <= m_WAbil.Level)
          and (GetTickCount - m_nSkill_48Tick > 5000) then begin//������ 20090111
          m_nSkill_48Tick:= GetTickCount();//������ʹ�ü�� 20090111
          Result := wSkill_48;
          Exit;
        end;
      end;

      if CheckTargetXYCount(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3) > 1 then begin
        if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0)  and ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin  {�̶�}
            Result := GetMagic01;
            if Result = 0 then Result := GetMagic03;
        end else
        if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0)  and ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then begin  {�춾}
            Result := GetMagic01;
            if Result = 0 then Result := GetMagic03;
        end else begin
          Result := GetMagic03;
          if Result = 0 then Result := GetMagic01;
        end;
      end else begin
        if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0)  and ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin  {�̶�}
          Result := GetMagic02;
          if Result = 0 then Result := GetMagic03;
        end else
        if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0)  and ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then begin  {�춾}
          Result := GetMagic02;
          if Result = 0 then Result := GetMagic03;
        end else begin
          Result := GetMagic03;
          if Result = 0 then Result := GetMagic02;
        end;
      end;
    except
    end;
  end;
var
  nMagicID: Integer;
  nIndex: Integer;
  nCode:Byte;
begin
  Result := False;
  nCode:= 0;
try
  if m_TargetCret.m_boDeath then Exit;//20080120 ��ֹ��������,���ιֻ���ʹ��ħ��,����M2����
  m_wHitMode := 0;
  nCode:= 1;
  if m_boDoSpellMagic and (m_TargetCret <> nil) then begin//20080711 ����
    nCode:= 12;
    nMagicID := SearchDoSpell;
    nCode:= 13;
    if nMagicID = 0 then m_boAutoAvoid:= True;//�Ƿ��ܶ�� 20080715
    nCode:= 2;
    if nMagicID > 0 then begin
      //20080420 ����
      if not MagCanHitTarget(m_nCurrX, m_nCurrY, m_TargetCret) or ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 7) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 7)) then begin//ħ�����ܴ򵽹� 20080420
         if (m_Master <> nil) and ((abs(m_Master.m_nCurrX - m_nCurrX) >= 7) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 7)) then begin
           nCode:= 3;
           m_TargetCret:= nil;
           Exit;
         end else GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
      nCode:= 4;
      case nMagicID of
       { SKILL_FIRECHARM, SKILL_DEJIWONHO: begin //���÷��ļ���,װ����û��,ֱ���ð��������Ʒ,�����Զ�����Ʒ 20080415
            if not CheckUserItemType(1,0) then begin
              nIndex := GetUserItemList(1,0);
              if nIndex >= 0 then begin
                UseItem(1, nIndex, 0);
              end;
            end;
          end; }
        SKILL_AMYOUNSUL, SKILL_GROUPAMYOUNSUL: begin //ʩ����
            {if not CheckUserItemType(2) then begin
              nIndex := GetUserItemList(2);
              if nIndex >= 0 then begin
                UseItem(2, nIndex);
              end;
            end; }
           if (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) and ((GetUserItemList(2,1) >= 0) or CheckUserItemType(2,1)) then begin//�̶�
            nCode:= 5;
            if not CheckUserItemType(2,1) then begin //���װ��������Ʒ����
              nCode:= 6;
              nIndex := GetUserItemList(2,1);//ȡ���������ƷID
              if nIndex >= 0 then begin
                nCode:= 7;
                UseItem(2, nIndex,1);//�Զ�����
              end;
            end;
           end else
            if (m_TargetCret.m_wStatusTimeArr[POISON_DAMAGEARMOR] = 0) and ((GetUserItemList(2,2) >= 0) or CheckUserItemType(2,2)) then  begin//�춾
              nCode:= 8;
              if not CheckUserItemType(2,2) then begin //���װ��������Ʒ����
                nCode:= 9;
                nIndex := GetUserItemList(2,2);//ȡ���������ƷID
                if nIndex >= 0 then begin
                  nCode:= 10;
                  UseItem(2, nIndex,2);//�Զ�����
                end;
              end;
            end;
          end;
      end;
      nCode:= 11;
      if not DoSpellMagic(nMagicID) then begin
        SendRefMsg(RM_MAGICFIREFAIL, 0, 0, 0, 0, '');
      end;
      Result := True;
    end else  Result := WarrAttackTarget(m_wHitMode);
  end else  Result := WarrAttackTarget(m_wHitMode);
  m_dwHitTick := GetTickCount();//20080715 ����
  except
    MainOutMessage('{�쳣} TPlayMonster.TaoistAttackTarget Code:'+inttostr(nCode));
  end;
end;

function TPlayMonster.AttackTarget(): Boolean;
begin
  Result := False;
  if m_WAbil.MP < 100 then m_WAbil.MP:= 100;//20080917 ��MP����100ʱ,��ʼΪ100
  case m_btJob of
    0: begin
        if m_Master <> nil then begin//20081103 �������ʱ�Ĺ����ٶ�
          if GetTickCount - m_dwHitTick > g_Config.dwWarrorAttackTime then begin//20080522
            m_nSelectMagic:= 0;//��ѯħ�� 20081206
            //m_dwHitTick := GetTickCount(); 20081206
            m_boAutoAvoid:= False;//�Ƿ��ܶ�� 20080715
            Result := WarrorAttackTarget;
          end;
        end else begin
          if GetTickCount - m_dwHitTick > m_nNextHitTime then begin//Ϊ����ʱ��DB���õĹ����ٶ�
            m_nSelectMagic:= 0;//��ѯħ�� 20081206
            //m_dwHitTick := GetTickCount(); 20081206
            m_boAutoAvoid:= False;//�Ƿ��ܶ�� 20080715
            Result := WarrorAttackTarget;
          end;
        end;
      end;
    1: begin
        if m_Master <> nil then begin//20081103
          if GetTickCount - m_dwHitTick > g_Config.dwWizardAttackTime then begin//20080522
            m_dwHitTick := GetTickCount();
            m_boAutoAvoid:= False;//�Ƿ��ܶ�� 20080715
            Result := WizardAttackTarget;
          end;
        end else begin
          if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
            m_dwHitTick := GetTickCount();
            m_boAutoAvoid:= False;//�Ƿ��ܶ�� 20080715
            Result := WizardAttackTarget;
          end;
        end;
      end;
    2: begin
        if m_Master <> nil then begin//20081103
          if GetTickCount - m_dwHitTick > g_Config.dwTaoistAttackTime then begin //20080522
            m_dwHitTick := GetTickCount();
            m_boAutoAvoid:= False;//�Ƿ��ܶ�� 20080715
            Result := TaoistAttackTarget;
          end;
        end else begin
          if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
            m_dwHitTick := GetTickCount();
            m_boAutoAvoid:= False;//�Ƿ��ܶ�� 20080715
            Result := TaoistAttackTarget;
          end;
        end;
      end;
  end;
end;

procedure TPlayMonster.Run;
var
  nX, nY: Integer;
  nCheckCode: Integer;
resourcestring
  sExceptionMsg = '{�쳣} TPlayMonster.Run Code:%d';
begin
  nCheckCode:= 0;
  try
    if (not m_boGhost) and (not m_boDeath) and (not m_boFixedHideMode) and (not m_boStoneMode) and
      (m_wStatusTimeArr[POISON_STONE] = 0) then begin
      nCheckCode:= 12;
      if Think then begin
        inherited;
        Exit;
      end;

      PlaySuperRock;//��Ѫʯ���� 20080729

      nCheckCode:= 1;
      if m_boFireHitSkill and ((GetTickCount - m_dwLatestFireHitTick) > 20000{20 * 1000}) then begin
        m_boFireHitSkill := False; //�ر��һ�
      end;
      if m_boDailySkill and ((GetTickCount - m_dwLatestDailyTick) > 20000{20 * 1000}) then begin
        m_boDailySkill := False; //�ر����ս��� 20080511
      end;

      nCheckCode:= 2;
      if (GetTickCount - m_dwSearchEnemyTick) > 1100 then begin//20090104 1000�ĳ�1100
        m_dwSearchEnemyTick := GetTickCount();
        if (m_TargetCret = nil) then SearchTarget(); {����Ŀ��}
      end;
      nCheckCode:= 3;
      if m_boWalkWaitLocked then begin
        if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then m_boWalkWaitLocked := False;
      end;
      nCheckCode:= 4;
      if not m_boWalkWaitLocked and ({Integer}(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin//20080715
        m_dwWalkTick := GetTickCount();
        Inc(m_nWalkCount);
        if m_nWalkCount > m_nWalkStep then begin
          m_nWalkCount := 0;
          m_boWalkWaitLocked := True;
          m_dwWalkWaitTick := GetTickCount();
        end;
        nCheckCode:= 5;
        if not m_boRunAwayMode then begin
          if not m_boNoAttackMode then begin
            if m_boProtectStatus then begin//�ػ�״̬,����̫Զ  20090107
              if not m_boProtectOK then begin//û�ߵ��ػ�����  20090107
                if (m_TargetCret <> nil) then m_TargetCret:= nil;
                GotoTargetXY(m_nProtectTargetX, m_nProtectTargetY);
                Inc(m_nGotoProtectXYCount);
                if (abs(m_nCurrX - m_nProtectTargetX) <= 2 ) and (abs(m_nCurrY - m_nProtectTargetY) <= 2) then  begin
                  m_boProtectOK:= True;
                  m_nGotoProtectXYCount:= 0;//�����ػ�������ۼ��� 20090203
                end;
                if (m_nGotoProtectXYCount > 20) and (not m_boProtectOK) then begin//20�λ�û���ߵ��ػ����꣬��ɻ������� 20090203
                  if (abs(m_nCurrX - m_nProtectTargetX) > 13 ) or (abs(m_nCurrY - m_nProtectTargetY) > 13) then  begin
                    SpaceMove(m_PEnvir.sMapName, m_nProtectTargetX, m_nProtectTargetY, 1);//��ͼ�ƶ�
                    m_boProtectOK:= True;
                    m_nGotoProtectXYCount:= 0;//�����ػ�������ۼ��� 20090203
                  end;
                end;
              end;
            end;
            if (m_TargetCret <> nil) then begin//20090103
              if (not m_TargetCret.m_boDeath) and (m_TargetCret.m_WAbil.HP > 0) then begin  //20080424
                nCheckCode:= 51;
                if AttackTarget then begin
                  inherited;
                  Exit;
                end;
                nCheckCode:= 6;
                if StartAutoAvoid and m_boDoSpellMagic then begin //20080305 ����
                  AutoAvoid();  //�Զ����
                  inherited;
                  Exit;
                end else begin
                  nCheckCode:= 61;
                  if IsNeedGotoXY then begin
                    nCheckCode:= 62;
                    GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
                    inherited;
                    Exit;
                  end;
                end;
              end;
            end else begin
              {if not m_boProtectStatus then }m_nTargetX := -1;//20090103
              nCheckCode:= 7;
              if m_boMission then begin //��������˹���Ἧ��,����Ἧ���ƶ�
                m_nTargetX := m_nMissionX;
                m_nTargetY := m_nMissionY;
              end;
            end;
          end;
          nCheckCode:= 8;
          if m_Master <> nil then begin
            if m_TargetCret = nil then begin
              nCheckCode:= 81;
              m_Master.GetBackPosition(nX, nY);
              if (abs(m_nTargetX - nX) > 1) or (abs(m_nTargetY - nY {nX}) > 1) then begin
                m_nTargetX := nX;
                m_nTargetY := nY;
                if (abs(m_nCurrX - nX) <= 2) and (abs(m_nCurrY - nY) <= 2) then begin
                  if m_PEnvir.GetMovingObject(nX, nY, True) <> nil then begin
                    m_nTargetX := m_nCurrX;
                    m_nTargetY := m_nCurrY;
                  end;
                end;
              end;
            end; //if m_TargetCret = nil then begin
            if (not m_Master.m_boSlaveRelax) and
              ((m_PEnvir <> m_Master.m_PEnvir) or
              (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
              (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) then begin
               nCheckCode:= 82;
               SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);//��ͼ�ƶ�
            end;
          end else begin //if m_Master <> nil then begin
            nCheckCode:= 83;
            if m_boProtectStatus then begin //�ػ�״̬ 20090105
              if (abs(m_nCurrX - m_nProtectTargetX) > 13) or (abs(m_nCurrY - m_nProtectTargetY) > 13) then begin
                m_nTargetX := m_nProtectTargetX;
                m_nTargetY := m_nProtectTargetY;
                m_TargetCret := nil;
                m_boProtectOK:= False;//20090107
                GotoTargetXY(m_nTargetX, m_nTargetY);
                if (abs(m_nCurrX - m_nProtectTargetX) <= 1 ) and (abs(m_nCurrY - m_nProtectTargetY) <= 1) then m_boProtectOK:= True;//20090107
              end else begin
                m_nTargetX := -1;
              end;
            end;
          end;
        end else begin
          nCheckCode:= 9;
          if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then begin
            m_boRunAwayMode := False;
            m_dwRunAwayTime := 0;
          end;
        end;
        if (m_Master <> nil) and m_Master.m_boSlaveRelax then begin
          inherited;
          Exit;
        end;
        if (m_TargetCret = nil) then begin//20081204 ����:��Χ����תȦȦ,ת������Ȧ�ٿ�һ��
          if (m_nTargetX <> -1) and AllowGotoTargetXY then begin
            nCheckCode:= 10;
            GotoTargetXY(m_nTargetX, m_nTargetY);
          end else begin
            nCheckCode:= 11;
            Wondering();
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

function TPlayMonster.AddItems(UserItem: pTUserItem; btWhere: Integer): Boolean; //��ȡ����װ��
begin
  Result := False;
  if btWhere in [Low(THumanUseItems)..High(THumanUseItems)] then begin
    m_UseItems[btWhere] := UserItem^;
    Result := True;
  end;
end;
//�������ι���ȡ�б� 20080523
procedure TPlayMonster.LoadButchItemList();
var
  I: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItemInfo;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
begin
  s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '-Item.txt';
  if FileExists(s24) then begin
    if m_ButchItemList <> nil then begin
      if m_ButchItemList.Count > 0 then begin//20080630
        for I := 0 to m_ButchItemList.Count - 1 do begin
          if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
             Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
        end;
      end;
      m_ButchItemList.Clear;
    end;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(s24);
    if LoadList.Count > 0 then begin//20080630
      for I := 0 to LoadList.Count - 1 do begin
        s28 := LoadList.Strings[I];
        if (s28 <> '') and (s28[1] <> ';') then begin
          s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
          n18 := Str_ToInt(s30, -1);
          s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
          n1C := Str_ToInt(s30, -1);
          s28 := GetValidStr3(s28, s30, [' ', #9]);
          if s30 <> '' then begin
            if s30[1] = '"' then
              ArrestStringEx(s30, '"', '"', s30);
          end;
          s2C := s30;
          s28 := GetValidStr3(s28, s30, [' ', #9]);
          n20 := Str_ToInt(s30, 1);
          if (n18 > 0) and (n1C > 0) and (s2C <> '') then begin
            New(MonItem);
            MonItem.SelPoint := n18 - 1;
            MonItem.MaxPoint := n1C;
            MonItem.ItemName := s2C;
            MonItem.Count := n20;
            Randomize;//����������� 20080729
            if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin//������� 1/10 ���10<=1 ��Ϊ���õ���Ʒ
              m_ButchItemList.Add(MonItem);
            end;
          end;
        end;
      end;
    end;
    LoadList.Free;
  end;
{  for i:=0 to  m_ButchItemList.Count-1 do
    MainOutMessage(pTMonItemInfo( m_ButchItemList.Items[i]).ItemName);}
end;

procedure TPlayMonster.AddItemsFromConfig();
var
  TempList: TStringList;
  sCopyHumBagItems: string;
  UserItem: pTUserItem;
  I: Integer;
  sFileName: string;
  ItemIni: TIniFile;
  sMagic: string;
  sMagicName: string;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  StdItem: pTStdItem;
  StdItemNameArray: array[0..13] of string[16];//20080416 ��չ��13 ֧�ֶ���
begin
  if m_nCopyHumanLevel > 0 then begin
    case m_btJob of
      0: sCopyHumBagItems := Trim(g_Config.sCopyHumBagItems1);
      1: sCopyHumBagItems := Trim(g_Config.sCopyHumBagItems2);
      2: sCopyHumBagItems := Trim(g_Config.sCopyHumBagItems3);
    end;
    if sCopyHumBagItems <> '' then begin
      TempList := TStringList.Create;
      ExtractStrings(['|', '\', '/', ','], [], PChar(sCopyHumBagItems), TempList);
      if TempList.Count > 0 then begin//20080630
        for I := 0 to TempList.Count - 1 do begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(TempList.Strings[I], UserItem) then begin
            m_ItemList.Add(UserItem);
            //m_WAbil.Weight := RecalcBagWeight();
          end else Dispose(UserItem);
        end;
      end;
      TempList.Free;
    end;
  end else begin
    sFileName := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '.txt';
    if FileExists(sFileName) then begin
      ItemIni := TIniFile.Create(sFileName);
      if ItemIni <> nil then begin
        m_boDropUseItem := ItemIni.ReadBool('Info','DropUseItem',False);//�Ƿ��װ�� 20080120
        m_nDieDropUseItemRate := ItemIni.ReadInteger('Info', 'DropUseItemRate', 100); //������װ������
        //m_nButchUserItemRate:= ItemIni.ReadInteger('Info','ButchUserItemRate',10);//����ȡʱ�����ڵ�����װ���ļ��� 20080523
        m_boButchUseItem:= ItemIni.ReadBool('Info','ButchUseItem',False);//�Ƿ�������ȡ����װ��
        m_nButchRate:= ItemIni.ReadInteger('Info','ButchRate',10);//��ȡ����װ������ 20080120
        m_nButchChargeClass:= ItemIni.ReadInteger('Info','ButchChargeClass',3);//��ȡ����װ���շ�ģʽ(0��ң�1Ԫ����2���ʯ��3���)  20080120
        m_nButchChargeCount:= ItemIni.ReadInteger('Info','ButchChargeCount',1);//��ȡ����װ��ÿ���շѵ��� 20080120
        sCopyHumBagItems:= ItemIni.ReadString('UseItems', 'InitItems', '');//������Ʒ �綾����Ʒ 20080603
        boIntoTrigger:= ItemIni.ReadBool('Info','ButchCloneItem',False);//���ι����Ƿ���봥�� 20080716
        boIsDieEvent:= ItemIni.ReadBool('Info','IsDieEvent',False);//��������ʬ��,�Ƿ���ʾ������Ч��(��������Ч��) 20080914
        m_boProtectStatus:= ItemIni.ReadBool('Info','ProtectStatus',False);//�Ƿ��ػ�ģʽ 20090103
        if sCopyHumBagItems <> '' then begin
          TempList := TStringList.Create;
          try
            ExtractStrings(['|', '\', '/', ','], [], PChar(sCopyHumBagItems), TempList);
            if TempList.Count > 0 then begin//20080630
              for I := 0 to TempList.Count - 1 do begin
                New(UserItem);
                if UserEngine.CopyToUserItemFromName(TempList.Strings[I], UserItem) then begin
                  m_ItemList.Add(UserItem);
                end else Dispose(UserItem);
              end;
            end;
          finally
            TempList.Free;
          end;
        end;

        m_btJob := ItemIni.ReadInteger('Info', 'Job', 0);//ְҵ
        m_btGender := ItemIni.ReadInteger('Info', 'Gender', 0);//�Ա�
        m_btHair := ItemIni.ReadInteger('Info', 'Hair', 0);//ͷ��
        sMagic := ItemIni.ReadString('Info', 'UseSkill', '');//ʹ��ħ��
        if sMagic <> '' then begin
          TempList := TStringList.Create;
          ExtractStrings(['|', '\', '/', ','], [], PChar(sMagic), TempList);
          if TempList.Count > 0 then begin//20080630
            for I := 0 to TempList.Count - 1 do begin
              sMagicName := Trim(TempList.Strings[I]);
              if FindMagic(sMagicName) = nil then begin
                Magic := UserEngine.FindMagic(sMagicName);
                if Magic <> nil then begin
                  if (Magic.btJob = 99) or (Magic.btJob = m_btJob) then begin
                    New(UserMagic);
                    UserMagic.MagicInfo := Magic;
                    UserMagic.wMagIdx := Magic.wMagicId;
                    if Magic.wMagicId = 66 then UserMagic.btLevel := 4//�ļ�ħ���� 20080728
                    else UserMagic.btLevel := 3;
                    UserMagic.btKey := 0;
                    UserMagic.nTranPoint := Magic.MaxTrain[3];
                    m_MagicList.Add(UserMagic);
                  end;
                end;
              end;
            end;//for
          end;
          TempList.Free;
        end;

        FillChar(StdItemNameArray, SizeOf(StdItemNameArray), #0);
        StdItemNameArray[U_DRESS] := ItemIni.ReadString('UseItems', 'UseItems0'{'DRESSNAME'}, ''); // '�·�';
        StdItemNameArray[U_WEAPON] := ItemIni.ReadString('UseItems', 'UseItems1'{'WEAPONNAME'}, ''); // '����';
        StdItemNameArray[U_RIGHTHAND] := ItemIni.ReadString('UseItems', 'UseItems2'{'RIGHTHANDNAME'}, ''); // '������';
        StdItemNameArray[U_NECKLACE] := ItemIni.ReadString('UseItems', 'UseItems3'{'NECKLACENAME'}, ''); // '����';
        StdItemNameArray[U_HELMET] := ItemIni.ReadString('UseItems', 'UseItems4'{'HELMETNAME'}, ''); // 'ͷ��';
        StdItemNameArray[U_ARMRINGL] := ItemIni.ReadString('UseItems', 'UseItems5'{'ARMRINGLNAME'}, ''); // '������';
        StdItemNameArray[U_ARMRINGR] := ItemIni.ReadString('UseItems', 'UseItems6'{'ARMRINGRNAME'}, ''); // '������';
        StdItemNameArray[U_RINGL] := ItemIni.ReadString('UseItems','UseItems7' {'RINGLNAME'}, ''); // '���ָ';
        StdItemNameArray[U_RINGR] := ItemIni.ReadString('UseItems','UseItems8' {'RINGRNAME'}, ''); // '�ҽ�ָ';
        StdItemNameArray[U_BUJUK] := ItemIni.ReadString('UseItems', 'UseItems9'{'BUJUKNAME'}, ''); // '��Ʒ';
        StdItemNameArray[U_BELT] := ItemIni.ReadString('UseItems', 'UseItems10'{'BELTNAME'}, ''); // '����';
        StdItemNameArray[U_BOOTS] := ItemIni.ReadString('UseItems', 'UseItems11'{'BOOTSNAME'}, ''); // 'Ь��';
        StdItemNameArray[U_CHARM] := ItemIni.ReadString('UseItems','UseItems12' {'CHARMNAME'}, ''); // '��ʯ';
        StdItemNameArray[U_ZHULI] := ItemIni.ReadString('UseItems','UseItems13' {'CHARMNAME'}, ''); // '����'; 20080416
        for I := U_DRESS to U_ZHULI do begin //20080416 ����
          if StdItemNameArray[I] <> '' then begin
            StdItem := UserEngine.GetStdItem(StdItemNameArray[I]);
            if StdItem <> nil then begin
              //if CheckTakeOnItems(i, StdItem^) then begin
              New(UserItem);
              if UserEngine.CopyToUserItemFromName(StdItemNameArray[I], UserItem) then begin
                if Random(g_Config.nPlayMonRandomAddValue) = 0 then UserEngine.RandomUpgradeItem(UserItem);//����֧�ּ�Ʒװ�� 20080716
                AddItems(UserItem, I);
              end;
              Dispose(UserItem);
              //end;
            end;
          end;
        end;
        LoadButchItemList();//�������ι���ȡ�б� 20080523
        ItemIni.Free;
      end;
    end;
  end;
end;
//����ħ��
function TPlayMonster.FindMagic(sMagicName: string): pTUserMagic;
var
  UserMagic: pTUserMagic;
  I: Integer;
begin
  Result := nil;
  if m_MagicList.Count > 0 then begin//20080630
    for I := 0 to m_MagicList.Count - 1 do begin
      UserMagic := m_MagicList.Items[I];
      if CompareText(UserMagic.MagicInfo.sMagicName, sMagicName) = 0 then begin
        Result := UserMagic;
        Break;
      end;
    end;
  end;
end;
{//�������Ʒ   20080522 ע��
function TPlayMonster.CheckTakeOnItems(nWhere: Integer; var StdItem: TStdItem): Boolean;
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
begin
  Result := False;
  if (StdItem.StdMode = 10) and (m_btGender <> 0) then begin
    Exit;
  end;
  if (StdItem.StdMode = 11) and (m_btGender <> 1) then begin
    Exit;
  end;
  if (nWhere = 1) or (nWhere = 2) then begin
    if StdItem.Weight > m_WAbil.MaxHandWeight then Exit;
  end else begin
    if (StdItem.Weight + GetUserItemWeitht(nWhere)) > m_WAbil.MaxWearWeight then Exit;
  end;
  case StdItem.Need of
    0: begin
        if m_Abil.Level >= StdItem.NeedLevel then Result := True;
      end;
    1: begin
        if HiWord(m_WAbil.DC) >= StdItem.NeedLevel then Result := True;
      end;
    10: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (m_Abil.Level >= HiWord(StdItem.NeedLevel)) then Result := True;
      end;
    11: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.DC) >= HiWord(StdItem.NeedLevel)) then Result := True;
      end;
    12: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.MC) >= HiWord(StdItem.NeedLevel)) then Result := True;
      end;
    13: begin
        if (m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.SC) >= HiWord(StdItem.NeedLevel)) then Result := True;
      end;
    2: begin
        if HiWord(m_WAbil.MC) >= StdItem.NeedLevel then Result := True;
      end;
    3: begin
        if HiWord(m_WAbil.SC) >= StdItem.NeedLevel then Result := True;
      end;
  else begin
      Result := True;
    end;
  end;
end; }

//�޼�����  20080323 �޸�
//0����������40%   1������60%   2������80%  3������100%  ʱ�䶼��6��
function TPlayMonster.AbilityUp(UserMagic: pTUserMagic): Boolean;
var
  nSpellPoint, n14: Integer;
begin
  Result := False;
  nSpellPoint := GetSpellPoint(UserMagic);
  if nSpellPoint > 0 then begin
    if m_WAbil.MP < nSpellPoint then Exit;
    n14 := (Random(10 + UserMagic.btLevel) + UserMagic.btLevel) * UserMagic.btLevel;
    m_dwStatusArrTimeOutTick[2] := GetTickCount + n14 * 1000;
    //m_wStatusArrValue[2] := HiWord(m_WAbil.SC)* 2*(UserMagic.btLevel + 2) div 10 ;//����ֵ 20080323 (2+�ȼ�)*0.2*����=����ֵ �滻
    m_wStatusArrValue[2] := Round(MakeLong(LoWord(m_WAbil.SC), HiWord(m_WAbil.SC))*(UserMagic.btLevel * 0.2 + 0.4));//����ֵ 20080826
    RecalcAbilitys();
    Result := True;
  end;
end;

//����� 20080410
function TPlayMonster.MagMakeFireDay(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower{, NGSecPwr}: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      if UserMagic.btLevel = 4 then nPower := nPower + g_Config.nPowerLV4;//4 ������ 20080417
      if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);
      {if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
        NGSecPwr:= 0;
        if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          NGSecPwr:= MagicManager.GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_229,nPower);//��֮�����
        end else
        if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
          NGSecPwr:= MagicManager.GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_229,nPower);//��֮�����
        end;
        nPower := _MAX(0, nPower - NGSecPwr);
      end;}
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
      if g_Config.boPlayObjectReduceMP then begin//���м�MPֵ,��35% 20090107
        TargeTBaseObject.DamageSpell(Abs(Round(nPower * 0.35)));
      end;
      if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
      else if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then Result := True;
    end else TargeTBaseObject := nil
  end else TargeTBaseObject := nil;
end;

//����� 20080410
function TPlayMonster.MabMabe(BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel,
  nTargetX, nTargetY: Integer): Boolean;
var
  nLv: Integer;
begin
  Result := False;
  if BaseObject.MagCanHitTarget(BaseObject.m_nCurrX, BaseObject.m_nCurrY, TargeTBaseObject) then begin
    if BaseObject.IsProperTarget(TargeTBaseObject) and (BaseObject <> TargeTBaseObject) then begin
      if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
        BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower div 3, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
        if (Random(2) + (BaseObject.m_Abil.Level - 1)) > TargeTBaseObject.m_Abil.Level then begin
          nLv := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
          if (Random(g_Config.nMabMabeHitRandRate {100}) < _MAX(g_Config.nMabMabeHitMinLvLimit, (nLevel * 8) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then begin
            if (Random(g_Config.nMabMabeHitSucessRate {21}) < nLevel * 2 + 4) then begin
              if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                BaseObject.SetPKFlag(BaseObject);
                BaseObject.SetTargetCreat(TargeTBaseObject);
              end;
              TargeTBaseObject.SetLastHiter(BaseObject);
              nPower := TargeTBaseObject.GetMagStruckDamage(BaseObject, nPower);
              BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
              if not TargeTBaseObject.m_boUnParalysis then
                TargeTBaseObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE {�ж����� - ���}, nPower div g_Config.nMabMabeHitMabeTimeRate {20} + Random(nLevel), Integer(BaseObject), nLevel, '', 650);
              Result := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//��Ѫʯ���� 20080729
procedure TPlayMonster.PlaySuperRock;
var
  StdItem: pTStdItem;
  nTempDura: Integer;
begin
  Try
    //��Ѫʯ ħѪʯ                                                                                                  //20080611
    if (not m_boDeath) and (not m_boGhost) and (m_WAbil.HP > 0) then begin
      if (m_UseItems[U_CHARM].wIndex > 0) and (m_UseItems[U_CHARM].Dura > 0) then begin
        StdItem := UserEngine.GetStdItem(m_UseItems[U_CHARM].wIndex);
        if (StdItem <> nil) then begin//20090128
          if (StdItem.Shape > 0) and m_PEnvir.AllowStdItems(StdItem.Name) then begin
            case StdItem.Shape of
              1: begin //��Ѫʯ
                  if (m_WAbil.MaxHP - m_WAbil.HP) >= g_Config.nStartHPRock then begin//200081215 �ĳɵ���������
                    if GetTickCount - dwRockAddHPTick > g_Config.nHPRockSpell then begin
                      dwRockAddHPTick:= GetTickCount();//��ʯ��HP���
                      if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPRockDecDura then begin
                        Inc(m_WAbil.HP, g_Config.nRockAddHP);
                        nTempDura := m_UseItems[U_CHARM].Dura * 10;
                        Dec(nTempDura, g_Config.nHPRockDecDura);
                        m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                        if m_UseItems[U_CHARM].Dura <= 0 then m_UseItems[U_CHARM].wIndex:= 0;
                      end else begin
                        Inc(m_WAbil.HP, g_Config.nRockAddHP);
                        m_UseItems[U_CHARM].Dura := 0;
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                      if m_WAbil.HP > m_WAbil.MaxHP then m_WAbil.HP := m_WAbil.MaxHP;
                      PlugHealthSpellChanged();
                    end;
                  end;
                end;
              2: begin
                  if (m_WAbil.MaxMP - m_WAbil.MP) >= g_Config.nStartMPRock then begin//200081215 �ĳɵ���������
                    if GetTickCount - dwRockAddMPTick > g_Config.nMPRockSpell then begin
                      dwRockAddMPTick:= GetTickCount;//��ʯ��MP���
                      if m_UseItems[U_CHARM].Dura * 10 > g_Config.nMPRockDecDura then begin
                        Inc(m_WAbil.MP, g_Config.nRockAddMP);
                        nTempDura := m_UseItems[U_CHARM].Dura * 10;
                        Dec(nTempDura, g_Config.nMPRockDecDura);
                        m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                        if m_UseItems[U_CHARM].Dura <= 0 then m_UseItems[U_CHARM].wIndex:= 0;
                      end else begin
                        Inc(m_WAbil.MP, g_Config.nRockAddMP);
                        m_UseItems[U_CHARM].Dura := 0;
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                      if m_WAbil.MP > m_WAbil.MaxMP then  m_WAbil.MP:= m_WAbil.MaxMP ;
                      PlugHealthSpellChanged();
                    end;
                  end;
                end;
              3: begin
                if (m_WAbil.MaxHP - m_WAbil.HP ) >= g_Config.nStartHPMPRock then begin//200081215 �ĳɵ���������
                    if GetTickCount - dwRockAddHPTick > g_Config.nHPMPRockSpell then begin
                      dwRockAddHPTick:= GetTickCount;//��ʯ��HP���
                      if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPMPRockDecDura then begin
                        Inc(m_WAbil.HP, g_Config.nRockAddHPMP);
                        nTempDura := m_UseItems[U_CHARM].Dura * 10;
                        Dec(nTempDura, g_Config.nHPMPRockDecDura);
                        m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                        if m_UseItems[U_CHARM].Dura <= 0 then m_UseItems[U_CHARM].wIndex:= 0;
                      end else begin
                        Inc(m_WAbil.HP, g_Config.nRockAddHPMP);
                        m_UseItems[U_CHARM].Dura := 0;
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                      if m_WAbil.HP > m_WAbil.MaxHP then m_WAbil.HP := m_WAbil.MaxHP;
                      PlugHealthSpellChanged();
                    end;
                  end;
                //======================================================================
                 if (m_WAbil.MaxMP - m_WAbil.MP ) >= g_Config.nStartHPMPRock then begin//200081215 �ĳɵ���������
                    if GetTickCount - dwRockAddMPTick > g_Config.nHPMPRockSpell then begin
                      dwRockAddMPTick:= GetTickCount;//��ʯ��MP���
                      if m_UseItems[U_CHARM].Dura * 10 > g_Config.nHPMPRockDecDura then begin
                        Inc(m_WAbil.MP, g_Config.nRockAddHPMP);
                        nTempDura := m_UseItems[U_CHARM].Dura * 10;
                        Dec(nTempDura, g_Config.nHPMPRockDecDura);
                        m_UseItems[U_CHARM].Dura := Round(nTempDura / 10);
                        if m_UseItems[U_CHARM].Dura <= 0 then m_UseItems[U_CHARM].wIndex:= 0;
                      end else begin
                        Inc(m_WAbil.MP, g_Config.nRockAddHPMP);
                        m_UseItems[U_CHARM].Dura := 0;
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
    end;
  except
    MainOutMessage('{�쳣} TPlayMonster.PlaySuperRock');
  end;
end;

//���ν���Ұ����ײ 20081016
function TPlayMonster.DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean;
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
  end;
  if n28 > 0 then begin
    if n24 < 0 then n24 := 0;
    n20 := Random(n24 * 10) + ((n24 + 1) * 3);
    n20 := GetHitStruckDamage(Self, n20);
    StruckDamage(n20);
    SendRefMsg(RM_STRUCK, n20, m_WAbil.HP, m_WAbil.MaxHP, 0, '');
  end;
end;

end.

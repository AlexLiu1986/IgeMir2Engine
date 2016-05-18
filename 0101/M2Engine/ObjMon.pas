unit ObjMon;

interface
uses
  Windows, Classes, Grobal2, ObjBase, SysUtils, IniFiles;
type
  TMonster = class(TAnimalObject)
    m_dwThinkTick: LongWord;
    m_boDupMode: Boolean; //人物重叠了
  private
    function Think: Boolean;
    function MakeClone(sMonName: string; OldMon: TBaseObject): TBaseObject;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    function AttackTarget(): Boolean; virtual; //FFEB
    procedure Run; override;
  end;
  TChickenDeer = class(TMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TATMonster = class(TMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TSlowATMonster = class(TATMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TScorpion = class(TATMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TSpitSpider = class(TATMonster)
    m_boUsePoison: Boolean;
  private
    procedure SpitAttack(btDir: Byte);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; {virtual;//} override; //FFEB
  end;
  THighRiskSpider = class(TSpitSpider)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TBigPoisionSpider = class(TSpitSpider)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TGasAttackMonster = class(TATMonster)
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget: Boolean; override;
    function sub_4A9C78(bt05: Byte): TBaseObject; virtual; //FFEA
  end;
  TCowMonster = class(TATMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TMagCowMonster = class(TATMonster)  //火焰沃玛
  private
    procedure sub_4A9F6C(btDir: Byte);
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget: Boolean; override;
  end;
  TCowKingMonster = class(TATMonster)
    dw558: LongWord;
    bo55C: Boolean;
    bo55D: Boolean;
    n560: Integer;
    dw564: LongWord;
    dw568: LongWord;
    dw56C: LongWord;
    dw570: LongWord;
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
    procedure Initialize(); override;
  end;
  TElectronicScolpionMon = class(TMonster)
  private
    m_boUseMagic: Boolean;
    procedure LightingAttack(nDir: Integer);

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TLightingZombi = class(TMonster)
  private
    procedure LightingAttack(nDir: Integer);

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TFairyMonster = class(TMonster) //月灵
    m_dwAutoAvoidTick: LongWord;  //自动躲避间隔
    m_btLastDirection: Byte;//最后的方向
    m_boIsUseAttackMagic: Boolean;//是否可以攻击 20080618
    m_dwActionTick: LongWord;//动作间隔
  private
    procedure FlyAxeAttack(Target: TBaseObject);
    procedure ResetElfMon; //清清2007.12.4

    function WalkToTargetXY2(nTargetX, nTargetY: Integer): Boolean;//20080214
    //function RunToTargetXY(nTargetX, nTargetY: Integer): Boolean;//20080214
    //function WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;//20080214
    function GotoTargetXY(nTargetX, nTargetY: Integer): Boolean;//20080214
    function IsNeedGotoXY(): Boolean; //是否走向目标  //20080327
    function CheckActionStatus(): Boolean;//增加检查两动作的间隔

    function AutoAvoid(): Boolean; //自动躲避 //20080214
    function IsNeedAvoid(): Boolean; //是否需要躲避 //20080214
    function CheckTargetXYCount(nX, nY, nRange: Integer): Integer; //检查身边一定范围的怪数量  20080214
    function CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;{检测指定方向和范围内坐标的怪物数量}//20080214
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure RecalcAbilitys; override;  //清清2007.12.4
    function AttackTarget(): Boolean; override; //FFEB
  end;


  TDigOutZombi = class(TMonster)
  private
    procedure sub_4AA8DC;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TZilKinZombi = class(TATMonster)
    dw558: LongWord;
    nZilKillCount: Integer;
    dw560: LongWord;
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Die; override;
    procedure Run; override;
  end;
  TWhiteSkeleton = class(TATMonster)
    m_boIsFirst: Boolean;
  private
    procedure sub_4AAD54;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;

  TScultureMonster = class(TMonster)
  private
    procedure MeltStone; //
    procedure MeltStoneAll;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TScultureKingMonster = class(TMonster)
    m_nDangerLevel: Integer;
    m_SlaveObjectList: TList; //0x55C
  private
    procedure MeltStone;
    procedure CallSlave;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override; //0FFED
    procedure Run; override;
  end;
  TGasMothMonster = class(TGasAttackMonster) //楔蛾
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function sub_4A9C78(bt05: Byte): TBaseObject; override; //FFEA
  end;
  TGasDungMonster = class(TGasAttackMonster)
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TElfMonster = class(TMonster)
    boIsFirst: Boolean; //0x558
  private
    procedure AppearNow;
    procedure ResetElfMon;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;
  TElfWarriorMonster = class(TSpitSpider)
    n55C: Integer;
    boIsFirst: Boolean; //0x560
    dwDigDownTick: LongWord; //0x564
  private
    procedure AppearNow;
    procedure ResetElfMon;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;

  TGiantSickleSpiderATMonster = class(TATMonster)//巨镰蜘蛛 20080809
    m_boExploration: Boolean;//是否可探索 20080810
    //m_nButchRate: Integer;//挖取物品机率
    m_nButchChargeClass: Byte;//探索收费模式(0金币，1元宝，2金刚石，3灵符)
    m_nButchChargeCount: Integer;//探索每次收费点数
    boIntoTrigger: Boolean;//是否进入触发
    m_ButchItemList: TList;//可探索物品列表 20080810
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Die; override;
    function GetShowName(): string; override;
    procedure AddItemsFromConfig();//读取可探索物品
  end;

  TSalamanderATMonster = class(TATMonster)//狂热火蜥蜴 20080809
    m_boExploration: Boolean;//是否可探索 20080810
    //m_nButchRate: Integer;//挖取物品机率
    m_nButchChargeClass: Byte;//探索收费模式(0金币，1元宝，2金刚石，3灵符)
    m_nButchChargeCount: Integer;//探索每次收费点数
    boIntoTrigger: Boolean;//是否进入触发
    m_ButchItemList: TList;//可探索物品列表 20080810
  private
    function MagMakeFireCross(PlayObject: TBaseObject; nDamage, nHTime, nX, nY: Integer): Integer;    
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    procedure Die; override;
    function AttackTarget():Boolean; override;
    function GetShowName(): string; override;
    procedure AddItemsFromConfig();//读取可探索物品
  end;

  TTempleGuardian = class(TScultureMonster)//圣殿卫士 20080809
    m_boExploration: Boolean;//是否可探索 20080810
    //m_nButchRate: Integer;//挖取物品机率
    m_nButchChargeClass: Byte;//探索收费模式(0金币，1元宝，2金刚石，3灵符)
    m_nButchChargeCount: Integer;//探索每次收费点数
    boIntoTrigger: Boolean;//是否进入触发
    m_ButchItemList: TList;//可探索物品列表 20080810
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Die; override;
    function GetShowName(): string; override;
    procedure AddItemsFromConfig();//读取可探索物品
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer); override;
  end;

  TheCrutchesSpider = class(TMonster)//金杖蜘蛛 20080809
    m_boExploration: Boolean;//是否可探索 20080810
    //m_nButchRate: Integer;//挖取物品机率
    m_nButchChargeClass: Byte;//探索收费模式(0金币，1元宝，2金刚石，3灵符)
    m_nButchChargeCount: Integer;//探索每次收费点数
    boIntoTrigger: Boolean;//是否进入触发
    m_ButchItemList: TList;//可探索物品列表 20080810
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure Run; override;
    procedure Die; override;
    function GetShowName(): string; override;
    procedure AddItemsFromConfig();//读取可探索物品
  end;

  TYanLeiWangSpider = class(TATMonster)//雷炎蛛王 20080811
    m_boExploration: Boolean;//是否可探索
    //m_nButchRate: Integer;//挖取物品机率
    m_nButchChargeClass: Byte;//探索收费模式(0金币，1元宝，2金刚石，3灵符)
    m_nButchChargeCount: Integer;//探索每次收费点数
    boIntoTrigger: Boolean;//是否进入触发
    m_ButchItemList: TList;//可探索物品列表

    boIsSpiderMagic: Boolean;//是否喷出蜘蛛网
    m_dwSpiderMagicTick: LongWord;//喷出蜘蛛网计时,用于延时处理目标身上的小网显示
  private
    procedure SpiderMagicAttack(nPower, nX, nY: Integer; nRage: Integer);//喷出蜘蛛网
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; virtual;//override; 20080914 修改
    procedure Run; override;
    procedure Die; override;
    function GetShowName(): string; override;
    procedure AddItemsFromConfig();//读取可探索物品
  end;
  
implementation

uses UsrEngn, M2Share, Event, HUtil32,ObjHero;

{ TMonster }
constructor TMonster.Create;
begin
  inherited;
  m_boDupMode := False;
  m_dwThinkTick := GetTickCount();
  m_nViewRange := 6; //6
  m_nRunTime := 250;
  m_dwSearchTime := 3000 + Random(2000);
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 80;
  m_boAddToMaped := False;//地图是否计数 20080830
end;

destructor TMonster.Destroy;
begin
  inherited;
end;
function TMonster.MakeClone(sMonName: string; OldMon: TBaseObject): TBaseObject;
var
  ElfMon: TBaseObject;
begin
  Result := nil;
  try
    ElfMon := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, m_nCurrX, m_nCurrY, sMonName);
    if (ElfMon <> nil) and (OldMon <> nil) then begin//20080901 修改
      ElfMon.m_Master := OldMon.m_Master;
      ElfMon.m_dwMasterRoyaltyTick := OldMon.m_dwMasterRoyaltyTick;
      ElfMon.m_dwMasterRoyaltyTime:= OldMon.m_dwMasterRoyaltyTime;//怪物叛变计时 20080813
      ElfMon.m_btSlaveMakeLevel := OldMon.m_btSlaveMakeLevel;
      ElfMon.m_btSlaveExpLevel := OldMon.m_btSlaveExpLevel;
      ElfMon.RecalcAbilitys;
      ElfMon.RefNameColor;
      if OldMon.m_Master <> nil then OldMon.m_Master.m_SlaveList.Add(ElfMon);
      ElfMon.m_WAbil := OldMon.m_WAbil;
      ElfMon.m_wStatusTimeArr := OldMon.m_wStatusTimeArr;
      ElfMon.m_TargetCret := OldMon.m_TargetCret;
      ElfMon.m_dwTargetFocusTick := OldMon.m_dwTargetFocusTick;
      ElfMon.m_LastHiter := OldMon.m_LastHiter;
      ElfMon.m_LastHiterTick := OldMon.m_LastHiterTick;
      ElfMon.m_btDirection := OldMon.m_btDirection;
      Result := ElfMon;
    end;
  except
  end;
end;

function TMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

function TMonster.Think(): Boolean; //004A8E54
var
  nOldX, nOldY: Integer;
begin
  Result := False;
  if (GetTickCount - m_dwThinkTick) > 3000{3 * 1000} then begin
    m_dwThinkTick := GetTickCount();
    if m_PEnvir.GetXYObjCount(m_nCurrX, m_nCurrY) >= 2 then m_boDupMode := True;
    if not IsProperTarget(m_TargetCret) then m_TargetCret := nil;
  end;
  if m_boDupMode then begin
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    WalkTo(Random(8), False);
    if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then begin
      m_boDupMode := False;
      Result := True;
    end;
  end;
end;

function TMonster.AttackTarget(): Boolean; //004A8F34
var
  bt06, nCode: Byte;//20081020
begin
  Result := False;
  nCode := 0;
  Try
    if m_TargetCret <> nil then begin
      nCode := 1;
      if (m_TargetCret.m_btRaceServer = RC_HEROOBJECT) and (m_TargetCret.m_Abil.Level <= 22) and (THEROOBJECT(m_TargetCret).m_btStatus = 1) then  begin//20080510 英雄22级前,跟随时不打
        nCode := 2;
        DelTargetCreat();
        Exit;
      end;
      nCode := 3;
      if GetAttackDir(m_TargetCret, bt06) then begin
        nCode := 4;
        if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
          m_dwHitTick := GetTickCount();
          m_dwTargetFocusTick := GetTickCount();
          nCode := 5;
          Attack(m_TargetCret, bt06); //FFED
          nCode := 6;
          m_TargetCret.SetLastHiter(self);//20080629
          nCode := 7;
          BreakHolySeizeMode();
        end;
        Result := True;
      end else begin
        nCode := 8;
        if m_TargetCret.m_PEnvir = m_PEnvir then begin
          nCode := 9;
          if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin //20080605 增加
            nCode := 10;
            SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          end;
        end else begin
          nCode := 11;
          DelTargetCreat();
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TMonster.AttackTarget Code:'+inttostr(nCode));
  end;
end;

procedure TMonster.Run;
var
  nX, nY: Integer;
  nCode: Byte;//20080907 
begin
  nCode:= 0;
  try
    if not m_boGhost and not m_boDeath and not m_boFixedHideMode and not m_boStoneMode and
      (m_wStatusTimeArr[POISON_STONE] = 0) then begin
      nCode:= 1;
      if Think then begin
        inherited;
        Exit;
      end;
      nCode:= 2;
      if m_boWalkWaitLocked then begin
        if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then begin
          m_boWalkWaitLocked := False;
        end;
      end;
      nCode:= 3;
      if not m_boWalkWaitLocked and (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
        m_dwWalkTick := GetTickCount();
        Inc(m_nWalkCount);
        if m_nWalkCount > m_nWalkStep then begin
          m_nWalkCount := 0;
          m_boWalkWaitLocked := True;
          m_dwWalkWaitTick := GetTickCount();
        end;
        nCode:= 4;
        if not m_boRunAwayMode then begin
          if not m_boNoAttackMode then begin
            if m_TargetCret <> nil then begin
              nCode:= 5;
              if AttackTarget then begin
                nCode:= 51;
                inherited;
                Exit;
              end;
            end else begin
              m_nTargetX := -1;
              if m_boMission then begin
                m_nTargetX := m_nMissionX;
                m_nTargetY := m_nMissionY;
              end;
            end;
          end; //if not bo2C0 then begin
          nCode:= 6;
          if m_Master <> nil then begin
            if m_TargetCret = nil then begin
              nCode:= 7;
              if not m_Master.m_boGhost then begin//20081216
                m_Master.GetBackPosition(nX, nY);
                if (abs(m_nTargetX - nX) > 1) or (abs(m_nTargetY - nY ) > 1) then begin
                  m_nTargetX := nX;
                  m_nTargetY := nY;
                  if (abs(m_nCurrX - nX) <= 2) and (abs(m_nCurrY - nY) <= 2) then begin
                    nCode:= 8;
                    if m_PEnvir.GetMovingObject(nX, nY, True) <> nil then begin
                      m_nTargetX := m_nCurrX;
                      m_nTargetY := m_nCurrY;
                    end
                  end;
                end;
              end;
            end; //if m_TargetCret = nil then begin
            nCode:= 9;
            if m_Master <> nil then begin//20081216
              if not m_Master.m_boGhost then begin//20081216
                if (not m_Master.m_boSlaveRelax) and
                  ((m_PEnvir <> m_Master.m_PEnvir) or
                  (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
                  (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) then begin
                  nCode:= 10;
                  SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
                end;
              end;
            end;
          end; //if m_Master <> nil then begin
        end else begin
          nCode:= 11;
          if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then begin
            m_boRunAwayMode := False;
            m_dwRunAwayTime := 0;
          end;
        end; //004A937E
        nCode:= 12;
        if (m_Master <> nil) then begin
          if m_Master.m_boSlaveRelax then begin
            inherited;
            Exit;
          end;  
        end; //004A93A6
        if m_nTargetX <> -1 then begin
          nCode:= 13;
          GotoTargetXY();
        end else begin
          nCode:= 14;
          if m_TargetCret = nil then Wondering(); // FFEE   //Jacky
        end;
      end; //if not bo510 and ((GetTickCount - m_dwWalkTick) > n4FC) then begin
    end; //
    inherited;
  except
    MainOutMessage('{异常} TMonster.Run Code:'+inttostr(nCode));
  end;
end;

{ TChickenDeer }

constructor TChickenDeer.Create; //004A93E8
begin
  inherited;
  m_nViewRange := 5;
end;

destructor TChickenDeer.Destroy;
begin
  inherited;
end;

procedure TChickenDeer.Run; //004A9438
var
  I: Integer;
  nC, n10, n14: Integer;
  BaseObject1C, BaseObject: TBaseObject;
begin
  Try
    n10 := 9999;
    BaseObject := nil;
    BaseObject1C := nil;
    if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
      if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
        if m_VisibleActors.Count > 0 then begin //20080629
          for I := 0 to m_VisibleActors.Count - 1 do begin
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
            if BaseObject = nil then Continue;
            if BaseObject.m_boDeath then Continue;
            if IsProperTarget(BaseObject) then begin
              if not BaseObject.m_boHideMode or m_boCoolEye then begin
                nC := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
                if nC < n10 then begin
                  n10 := nC;
                  BaseObject1C := BaseObject;
                end;
              end;
            end;
          end; // for
        end;
        if BaseObject1C <> nil then begin
          m_boRunAwayMode := True;
          m_TargetCret := BaseObject1C;
        end else begin
          m_boRunAwayMode := False;
          m_TargetCret := nil;
        end;
      end; //
      if m_boRunAwayMode and (m_TargetCret <> nil) and
        (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 6) and (abs(m_nCurrX - BaseObject.m_nCurrX) <= 6) then begin
          n14 := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
          m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, n14, 5, m_nTargetX, m_nTargetY);
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TChickenDeer.Run');
  end;
  inherited;
end;

{ TATMonster }

constructor TATMonster.Create; //004A9690
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TATMonster.Destroy;
begin

  inherited;
end;

procedure TATMonster.Run;
begin
  Try
    if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget(); //搜索目标
      end;
    end;
  except
    MainOutMessage('{异常} TATMonster.Run');
  end;
  inherited;
end;

{ TSlowATMonster }

constructor TSlowATMonster.Create; //004A97AC
begin
  inherited;
end;

destructor TSlowATMonster.Destroy;
begin
  inherited;
end;

{ TScorpion }

constructor TScorpion.Create; //004A97F0
begin
  inherited;
  m_boAnimal := True;
end;

destructor TScorpion.Destroy;
begin

  inherited;
end;

{ TSpitSpider }
constructor TSpitSpider.Create; //004A983C
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_boAnimal := True;
  m_boUsePoison := True;
end;

destructor TSpitSpider.Destroy;
begin

  inherited;
end;

procedure TSpitSpider.SpitAttack(btDir: Byte); //004A98AC
var
  WAbil: pTAbility;
  nC, n10, n14, n18, n1C: Integer;
  BaseObject: TBaseObject;
begin
  m_btDirection := btDir;
  WAbil := @m_WAbil;
  n1C := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
  if n1C <= 0 then Exit;
  SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  nC := 0;

  while (nC < 5) do begin
    n10 := 0;
    while (n10 < 5) do begin
      if g_Config.SpitMap[btDir, nC, n10] = 1 then begin
        n14 := m_nCurrX - 2 + n10;
        n18 := m_nCurrY - 2 + nC;
        BaseObject := m_PEnvir.GetMovingObject(n14, n18, True);
        if (BaseObject <> nil) and
          (BaseObject <> Self) and
          (IsProperTarget(BaseObject)) and
          (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
          n1C := BaseObject.GetMagStruckDamage(Self, n1C);
          if n1C > 0 then begin
            BaseObject.StruckDamage(n1C);
            BaseObject.SetLastHiter(self);//20080629
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n1C, m_WAbil.HP, m_WAbil.MaxHP, Integer(Self), '', 300);
            if m_boUsePoison then begin
              if (Random(m_btAntiPoison + 20) = 0) then
                BaseObject.MakePosion(POISON_DECHEALTH, 30, 1);
              //if Random(2) = 0 then
              //  BaseObject.MakePosion(POISON_STONE,5,1);
            end;
          end;
        end;
      end;


      Inc(n10);
      {
      if n10 >= 5 then break;
      }
    end;
    Inc(nC);
    //if nC >= 5 then break;
  end; // while

end;
function TSpitSpider.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if TargetInSpitRange(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      SpitAttack(btDir);
      BreakHolySeizeMode();
    end;
    Result := True;
    Exit;
  end;
  if m_TargetCret.m_PEnvir = m_PEnvir then begin
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin //20080605 增加
      SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    end;
  end else begin
    DelTargetCreat();
  end;
end;

{ THighRiskSpider }

constructor THighRiskSpider.Create; //004A9B64
begin
  inherited;
  m_boAnimal := False;
  m_boUsePoison := False;
end;

destructor THighRiskSpider.Destroy;
begin

  inherited;
end;

{ TBigPoisionSpider }

constructor TBigPoisionSpider.Create; //004A9BBC
begin
  inherited;
  m_boAnimal := False;
  m_boUsePoison := True;
end;

destructor TBigPoisionSpider.Destroy;
begin

  inherited;
end;

{ TGasAttackMonster }

constructor TGasAttackMonster.Create; //004A9C14
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_boAnimal := True;
end;

destructor TGasAttackMonster.Destroy;
begin
  inherited;
end;

function TGasAttackMonster.sub_4A9C78(bt05: Byte): TBaseObject;
var
  WAbil: pTAbility;
  n10: Integer;
  BaseObject: TBaseObject;
begin
  Result := nil;
  m_btDirection := bt05;
  WAbil := @m_WAbil;
  n10 := Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC);
  if n10 > 0 then begin
    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    BaseObject := GetPoseCreate();
    if (BaseObject <> nil) and
      IsProperTarget(BaseObject) and
      (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
      n10 := BaseObject.GetMagStruckDamage(Self, n10);
      if n10 > 0 then begin
        BaseObject.StruckDamage(n10);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n10, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 300);
        if Random(BaseObject.m_btAntiPoison + 20) = 0 then begin
          BaseObject.MakePosion(POISON_STONE, 5, 0)
        end;
        Result := BaseObject;
      end;
    end;
  end;
end;

function TGasAttackMonster.AttackTarget(): Boolean; //004A9DD4
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetAttackDir(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      sub_4A9C78(btDir);
      BreakHolySeizeMode();
    end;
    Result := True;
  end else begin
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin //20080605 增加
         SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end else begin
      DelTargetCreat();
    end;
  end;
end;

{ TCowMonster }

constructor TCowMonster.Create; //004A9EB4
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TCowMonster.Destroy;
begin

  inherited;
end;

{ TMagCowMonster }

constructor TMagCowMonster.Create; //004A9F10
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TMagCowMonster.Destroy;
begin

  inherited;
end;
procedure TMagCowMonster.sub_4A9F6C(btDir: Byte);
var
  WAbil: pTAbility;
  n10: Integer;
  BaseObject: TBaseObject;
begin
  m_btDirection := btDir;
  WAbil := @m_WAbil;
  n10 := Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC);
  if n10 > 0 then begin
    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    BaseObject := GetPoseCreate();
    if (BaseObject <> nil) and
      IsProperTarget(BaseObject) and
      (m_nAntiMagic >= 0) then begin
      n10 := BaseObject.GetMagStruckDamage(Self, n10);
      if n10 > 0 then begin
        BaseObject.StruckDamage(n10);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n10, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 300);
      end;
    end;
  end;
end;

function TMagCowMonster.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetAttackDir(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      sub_4A9F6C(btDir);
      BreakHolySeizeMode();
    end;
    Result := True;
  end else begin
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin //20080605 增加
         SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end else begin
      DelTargetCreat();
    end;
  end;
end;

{ TCowKingMonster }



constructor TCowKingMonster.Create; //004AA160
begin
  inherited;
  m_dwSearchTime := Random(1500) + 500;
  dw558 := GetTickCount();
  bo2BF := True;
  n560 := 0;
  bo55C := False;
  bo55D := False;
end;

destructor TCowKingMonster.Destroy;
begin

  inherited;
end;
procedure TCowKingMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer); //004AA1F0
var
  WAbil: pTAbility;
  nPower: Integer;
begin
  WAbil := @m_WAbil;
  nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  HitMagAttackTarget(TargeTBaseObject, nPower div 2, nPower div 2, True);
  //  inherited;
end;

procedure TCowKingMonster.Initialize;
begin
  dw56C := m_nNextHitTime;
  dw570 := m_nWalkSpeed;
  inherited;

end;
procedure TCowKingMonster.Run; //004AA294
var
  n8, nC, n10: Integer;
begin
  Try
    if (not m_boDeath) and (not m_boGhost) and ((GetTickCount - dw558) > 30000{30 * 1000}) then begin

      dw558 := GetTickCount();
      if (m_TargetCret <> nil) and (sub_4C3538 >= 5) then begin
        m_TargetCret.GetBackPosition(n8, nC);
        if m_PEnvir.CanWalk(n8, nC, False) then begin
          SpaceMove(m_PEnvir.sMapName, n8, nC, 0);
          Exit;
        end;
        MapRandomMove(m_PEnvir.sMapName, 0);
        Exit;
      end;
      n10 := n560;
      n560 := 7 - m_WAbil.HP div (m_WAbil.MaxHP div 7);
      if (n560 >= 2) and (n560 <> n10) then begin
        bo55C := True;
        dw564 := GetTickCount();
      end;
      if bo55C then begin
        if (GetTickCount - dw564) < 8000 then begin
          m_nNextHitTime := 10000;
        end else begin
          bo55C := False;
          bo55D := True;
          dw568 := GetTickCount();
        end;
      end; //004AA43D
      if bo55D then begin
        if (GetTickCount - dw568) < 8000 then begin
          m_nNextHitTime := 500;
          m_nWalkSpeed := 400;
        end else begin
          bo55D := False;
          m_nNextHitTime := dw56C;
          m_nWalkSpeed := dw570;
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TCowKingMonster.Run');
  end;
  inherited;
end;

{ TLightingZombi }

constructor TLightingZombi.Create; //004AA4B4
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
end;

destructor TLightingZombi.Destroy;
begin

  inherited;
end;
procedure TLightingZombi.LightingAttack(nDir: Integer);
var
  nSX, nSY, nTX, nTY, nPwr: Integer;
  WAbil: pTAbility;
begin
  m_btDirection := nDir;
  SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
  if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, 1, nSX, nSY) then begin
    m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, nDir, 9, nTX, nTY);
    WAbil := @m_WAbil;
    nPwr := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    MagPassThroughMagic(nSX, nSY, nTX, nTY, nDir, nPwr, nPwr, True, 0);
  end;
  BreakHolySeizeMode();
end;
procedure TLightingZombi.Run; //004AA604
var
  nAttackDir: Integer;
begin
  Try
    if (not m_boDeath) and (not m_boGhost) and (m_wStatusTimeArr[POISON_STONE ] = 0) and
      ((GetTickCount - m_dwSearchEnemyTick) > 8000) then begin

      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
      end;
      if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) and (m_TargetCret <> nil) and
        (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 4) then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and
          (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) and (Random(3) <> 0) then begin
          inherited;
          Exit;
        end;
        GetBackPosition(m_nTargetX, m_nTargetY);
      end;
      if (m_TargetCret <> nil) then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 6) and
           (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 6) and (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
           m_dwHitTick := GetTickCount();
           nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
           LightingAttack(nAttackDir);
        end;   
      end;
    end;
  except
    MainOutMessage('{异常} TLightingZombi.Run');
  end;
  inherited;
end;

{ TDigOutZombi }

constructor TDigOutZombi.Create; //004AA848
begin
  inherited;
  m_nViewRange := 7;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 95;
  m_boFixedHideMode := True;
end;

destructor TDigOutZombi.Destroy;
begin

  inherited;
end;

procedure TDigOutZombi.sub_4AA8DC;
var
  Event: TEvent;
begin
  Event := TEvent.Create(m_PEnvir, m_nCurrX, m_nCurrY, 1, 300000{5 * 60 * 1000}, True);
  g_EventManager.AddEvent(Event);
  m_boFixedHideMode := False;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, Integer(Event), '');
end;

procedure TDigOutZombi.Run; //004AA95C
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  Try
    if (not m_boGhost) and (not m_boDeath) and (m_wStatusTimeArr[POISON_STONE {5}] = 0) and
      (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin
      if m_boFixedHideMode then begin
        if m_VisibleActors.Count > 0 then begin//20080629
          for I := 0 to m_VisibleActors.Count - 1 do begin
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
            if BaseObject = nil then Continue;
            if BaseObject.m_boDeath then Continue;
            if IsProperTarget(BaseObject) then begin
              if not BaseObject.m_boHideMode or m_boCoolEye then begin
                if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 3) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 3) then begin
                  sub_4AA8DC();
                  m_dwWalkTick := GetTickCount + 1000;
                  Break;
                end;
              end;
            end;
          end; // for
        end;
      end else begin //004AB0C7
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TDigOutZombi.Run');
  end;
  inherited;
end;


{ TZilKinZombi }

constructor TZilKinZombi.Create;
begin
  inherited;
  m_nViewRange := 6;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 96;
  nZilKillCount := 0;
  if Random(3) = 0 then begin
    nZilKillCount := Random(3) + 1;
  end;
end;

destructor TZilKinZombi.Destroy;
begin
  inherited;

end;

procedure TZilKinZombi.Die;
begin
  inherited;
  if nZilKillCount > 0 then begin
    dw558 := GetTickCount();
    dw560 := (Random(20) + 4) * 1000;
  end;
  Dec(nZilKillCount);
end;

procedure TZilKinZombi.Run; //004AABE4
begin
  Try
    if m_boDeath and (not m_boGhost) and (nZilKillCount >= 0) and
      (m_wStatusTimeArr[POISON_STONE {5}] = 0) and (m_VisibleActors.Count > 0) and
      ((GetTickCount - dw558) >= dw560) then begin
      m_Abil.MaxHP := m_Abil.MaxHP shr 1;
      m_dwFightExp := m_dwFightExp div 2;
      m_Abil.HP := m_Abil.MaxHP;
      m_WAbil.HP := m_Abil.MaxHP;
      ReAlive();
      m_dwWalkTick := GetTickCount + 1000
    end;
  except
    MainOutMessage('{异常} TZilKinZombi.Run');
  end;
  inherited;
end;

{ TWhiteSkeleton }

constructor TWhiteSkeleton.Create; //00004AACCC
begin
  inherited;
  m_boIsFirst := True;
  m_boFixedHideMode := True;
  m_btRaceServer := 100;
  m_nViewRange := 6;
end;

destructor TWhiteSkeleton.Destroy;
begin

  inherited;
end;

procedure TWhiteSkeleton.RecalcAbilitys; //004AAD38
begin
  inherited;
  sub_4AAD54();
end;
procedure TWhiteSkeleton.Run;
begin
  Try
    if m_boIsFirst then begin
      m_boIsFirst := False;
      m_btDirection := 5;
      m_boFixedHideMode := False;
      SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;
  except
    MainOutMessage('{异常} TWhiteSkeleton.Run');
  end;
  inherited;
end;

procedure TWhiteSkeleton.sub_4AAD54; //004AAD54
begin
  m_nNextHitTime := 3000 - m_btSlaveMakeLevel * 600;
  m_nWalkSpeed := 1200 - m_btSlaveMakeLevel * 250;
  m_dwWalkTick := GetTickCount + 2000;
end;

{ TScultureMonster }

constructor TScultureMonster.Create; //004AAE20
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_nViewRange := 7;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;
end;

destructor TScultureMonster.Destroy;
begin

  inherited;
end;
procedure TScultureMonster.MeltStone;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boStoneMode := False;
end;
procedure TScultureMonster.MeltStoneAll;
var
  I: Integer;
  List10: TList;
  BaseObject: TBaseObject;
begin
  MeltStone();
  List10 := TList.Create;
  try
  GetMapBaseObjects(m_PEnvir, m_nCurrX, m_nCurrY, 7, List10);
  if List10.Count > 0 then begin//20080629
    for I := 0 to List10.Count - 1 do begin
      BaseObject := TBaseObject(List10.Items[I]);
      if BaseObject <> nil then begin
        if BaseObject.m_boStoneMode then begin
          if BaseObject is TScultureMonster then begin
            TScultureMonster(BaseObject).MeltStone
          end;
        end;
      end;
    end; // for
  end;
  finally
   List10.Free;
  end;
end;

procedure TScultureMonster.Run; //004AAF98
var
  I: Integer;
  BaseObject: TBaseObject;
  nCode: Byte;//20080812 增加
begin
  nCode:= 0;
try
  if (not m_boGhost) and (not m_boDeath) and (m_wStatusTimeArr[POISON_STONE] = 0) and
    (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
    if m_boStoneMode then begin
      nCode:= 1;
      if m_VisibleActors.Count > 0 then begin//20080629
        nCode:= 2;
        for I := 0 to m_VisibleActors.Count - 1 do begin
          nCode:= 3;
          BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
          nCode:= 4;
          if BaseObject = nil then Continue;
          nCode:= 5;
          if BaseObject.m_boDeath then Continue;
          nCode:= 6;
          if IsProperTarget(BaseObject) then begin
            nCode:= 7;
            if not BaseObject.m_boHideMode or m_boCoolEye then begin
              nCode:= 8;
              if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 2) then begin
                nCode:= 9;
                MeltStoneAll();
                Break;
              end;
            end;
          end;
        end; // for
      end;
    end else begin //004AB0C7
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        nCode:= 10;
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
      end;
    end;
  end;
  inherited;
  except
    MainOutMessage('{异常} TScultureMonster.Run Code:'+inttostr(nCode));
  end;
end;

{ TScultureKingMonster }

constructor TScultureKingMonster.Create; //004AB120
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_nViewRange := 8;
  m_boStoneMode := True;
  m_nCharStatusEx := STATE_STONE_MODE;
  m_btDirection := 5;
  m_nDangerLevel := 5;
  m_SlaveObjectList := TList.Create;
end;

destructor TScultureKingMonster.Destroy; //004AB1C8
begin
  m_SlaveObjectList.Free;
  inherited;
end;
procedure TScultureKingMonster.MeltStone; //004AB208
var
  Event: TEvent;
begin
  m_nCharStatusEx := 0;
  m_nCharStatus := GetCharStatus();
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boStoneMode := False;
  Event := TEvent.Create(m_PEnvir, m_nCurrX, m_nCurrY, 6, 300000{5 * 60 * 1000}, True);
  g_EventManager.AddEvent(Event);
end;
//召唤下属
procedure TScultureKingMonster.CallSlave;
var
  I: Integer;
  nC: Integer;
  n10, n14: Integer;
  BaseObject: TBaseObject;
begin
  nC := Random(6) + 6;
  GetFrontPosition(n10, n14);

  for I := 1 to nC do begin
    if m_SlaveObjectList.Count >= 30 then Break;
    BaseObject := UserEngine.RegenMonsterByName(m_sMapName, n10, n14, g_Config.sZuma[Random(4)]);
    if BaseObject <> nil then begin
      //BaseObject.m_Master:=Self;
      //BaseObject.m_dwMasterRoyaltyTick:=GetTickCount + 24 * 60 * 60 * 1000;
      m_SlaveObjectList.Add(BaseObject);
    end;
  end; // for
end;
procedure TScultureKingMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer); //004AB3E8
var
  WAbil: pTAbility;
  nPower: Integer;
begin
  if TargeTBaseObject <> nil then begin
    WAbil := @m_WAbil;
    nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
    HitMagAttackTarget(TargeTBaseObject, 0, nPower, True);
  end;
end;
procedure TScultureKingMonster.Run; //004AB444
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  Try
    if (not m_boGhost) and (not m_boDeath) and (m_wStatusTimeArr[POISON_STONE] = 0) and
      (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
      if m_boStoneMode then begin
        //MeltStone();//测试用
        if m_VisibleActors.Count > 0 then begin//20080629
          for I := 0 to m_VisibleActors.Count - 1 do begin
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
            if BaseObject = nil then Continue;
            if BaseObject.m_boDeath then Continue;
            if IsProperTarget(BaseObject) then begin
              if not BaseObject.m_boHideMode or m_boCoolEye then begin
                if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 2) then begin
                  MeltStone();
                  Break;
                end;
              end;
            end;
          end; // for
        end;
      end else begin
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
          (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget();
          //CallSlave(); //测试用
          if (m_nDangerLevel > m_WAbil.HP / m_WAbil.MaxHP * 5) and (m_nDangerLevel > 0) then begin
            Dec(m_nDangerLevel);
            CallSlave();
          end;
          if m_WAbil.HP = m_WAbil.MaxHP then m_nDangerLevel := 5;
        end;
      end;
      for I := m_SlaveObjectList.Count - 1 downto 0 do begin
        if m_SlaveObjectList.Count <= 0 then Break;
        BaseObject := TBaseObject(m_SlaveObjectList.Items[I]);
        if BaseObject <> nil then begin
          if BaseObject.m_boDeath or BaseObject.m_boGhost then
            m_SlaveObjectList.Delete(I);
        end;
      end; // for
    end;
  except
    MainOutMessage('{异常} TScultureKingMonster.Run');
  end;
  inherited;
end;
{ TGasMothMonster }

constructor TGasMothMonster.Create; //004AB6B8
begin
  inherited;
  m_nViewRange := 7;
end;

destructor TGasMothMonster.Destroy;
begin

  inherited;
end;

function TGasMothMonster.sub_4A9C78(bt05: Byte): TBaseObject; //004AB708
var
  BaseObject: TBaseObject;
begin
  BaseObject := inherited sub_4A9C78(bt05);
  if (BaseObject <> nil) and (Random(3) = 0) and (BaseObject.m_boHideMode) then begin
    BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT {8}] := 1;
  end;
  Result := BaseObject;
end;
procedure TGasMothMonster.Run; //004AB758
begin
  Try
    if (not m_boDeath) and (not m_boGhost) and (m_wStatusTimeArr[POISON_STONE {5}] = 0) and
      (Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
        (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick := GetTickCount();
        sub_4C959C();
      end;
    end;
  except
    MainOutMessage('{异常} TGasMothMonster.Run');
  end;
  inherited;
end;
{ TGasDungMonster }

constructor TGasDungMonster.Create; //004AB7F4
begin
  inherited;
  m_nViewRange := 7;
end;

destructor TGasDungMonster.Destroy;
begin

  inherited;
end;

{ TElfMonster }

procedure TElfMonster.AppearNow; //神兽
begin
  boIsFirst := False;
  m_boFixedHideMode := False;
  //SendRefMsg (RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
//   Appear;
//   ResetElfMon;
  RecalcAbilitys;
  m_dwWalkTick := m_dwWalkTick + 800; //
end;

constructor TElfMonster.Create;
begin
  inherited;
  m_nViewRange := 6;
  m_boFixedHideMode := True;
  m_boNoAttackMode := True;
  boIsFirst := True;
end;

destructor TElfMonster.Destroy;
begin

  inherited;
end;

procedure TElfMonster.RecalcAbilitys; //004AB8B0
begin
  inherited;
  ResetElfMon();
end;

procedure TElfMonster.ResetElfMon(); //004AB8CC
begin
  m_nWalkSpeed := 500 - m_btSlaveMakeLevel * 50;
  m_dwWalkTick := GetTickCount + 2000;
end;

procedure TElfMonster.Run;
var
  boChangeFace: Boolean;
  ElfMon: TBaseObject;
  nCode: Byte;
begin
  nCode:= 0;
Try
  if boIsFirst then begin
    nCode:= 1;
    boIsFirst := False;
    m_boFixedHideMode := False;
    nCode:= 2;
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    nCode:= 3;
    ResetElfMon();
  end;
  nCode:= 4;
  if m_boDeath then begin
    if (GetTickCount - m_dwDeathTick > 2000{2 * 1000}) then begin
      MakeGhost();
    end;
  end else begin
    nCode:= 6;
    boChangeFace := False;
    if m_TargetCret <> nil then boChangeFace := True;
    if (m_Master <> nil) then begin
      if ((m_Master.m_TargetCret <> nil) or (m_Master.m_LastHiter <> nil)) then boChangeFace := True;
    end;  
    nCode:= 7;
    if boChangeFace then begin
      nCode:= 8;
      //ElfMon:=MakeClone(sDogz1,Self);
      ElfMon := MakeClone(m_sCharName + '1', Self);
      nCode:= 9;
      if ElfMon <> nil then begin
        nCode:= 10;
        ElfMon.m_boAutoChangeColor := m_boAutoChangeColor;
        nCode:= 11;
        if ElfMon is TElfWarriorMonster then TElfWarriorMonster(ElfMon).AppearNow;
        nCode:= 12;
        m_Master := nil;
        KickException();
      end;
    end;
  end;
  inherited;
  except
    MainOutMessage('{异常} TElfMonster.Run Code:'+inttostr(nCode));
    KickException();
  end;
end;
{ TElfWarriorMonster }
procedure TElfWarriorMonster.AppearNow; //004ABB60
begin
  boIsFirst := False;
  m_boFixedHideMode := False;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  RecalcAbilitys;
  m_dwWalkTick := m_dwWalkTick + 800; 
  dwDigDownTick := GetTickCount();
end;

constructor TElfWarriorMonster.Create;
begin
  inherited;
  m_nViewRange := 6;
  m_boFixedHideMode := True;
  boIsFirst := True;
  m_boUsePoison := False;
end;

destructor TElfWarriorMonster.Destroy;
begin

  inherited;
end;

procedure TElfWarriorMonster.RecalcAbilitys;
begin
  inherited;
  ResetElfMon();
end;

procedure TElfWarriorMonster.ResetElfMon();
begin
  m_nNextHitTime := 1500 - m_btSlaveMakeLevel * 100;
  m_nWalkSpeed := 500 - m_btSlaveMakeLevel * 50;
  m_dwWalkTick := GetTickCount + 2000;
end;

procedure TElfWarriorMonster.Run; //004ABBD0
var
  boChangeFace: Boolean;
  ElfMon: TBaseObject;
  ElfName: string;
  nCode: Byte;
begin
  nCode:= 0;
try
  ElfMon := nil;
  nCode:= 1;
  if boIsFirst then begin
    nCode:= 2;
    boIsFirst := False;
    m_boFixedHideMode := False;
    nCode:= 3;
    SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    ResetElfMon();
  end; //004ABC27
  nCode:= 4;
  if m_boDeath then begin
    if (GetTickCount - m_dwDeathTick > 2000{2 * 1000}) then begin
      nCode:= 5;
      MakeGhost();
    end;
  end else begin
    nCode:= 6;
    boChangeFace := True;
    if m_TargetCret <> nil then boChangeFace := False;
    nCode:= 7;
    if (m_Master <> nil) then begin
      if ((m_Master.m_TargetCret <> nil) or (m_Master.m_LastHiter <> nil)) then boChangeFace := False;
    end;  
    nCode:= 8;
    if boChangeFace then begin
      if (GetTickCount - dwDigDownTick) > 60000{6 * 10 * 1000} then begin
        //if (GetTickCount - dwDigDownTick) > 10 * 1000 then begin
          //ElfMon:=MakeClone(sDogz,Self);
        nCode:= 9;
        ElfName := m_sCharName;
        if ElfName[Length(ElfName)] = '1' then begin
          ElfName := Copy(ElfName, 1, Length(ElfName) - 1);
          nCode:= 10;
          ElfMon := MakeClone(ElfName, Self);
        end;
        if ElfMon <> nil then begin
          nCode:= 11;
          SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
          SendRefMsg(RM_CHANGEFACE, 0, Integer(Self), Integer(ElfMon), 0, '');
          nCode:= 12;
          ElfMon.m_boAutoChangeColor := m_boAutoChangeColor;
          if ElfMon is TElfMonster then
            TElfMonster(ElfMon).AppearNow;
          nCode:= 13;  
          m_Master := nil;
          KickException();
        end;
      end;
    end else begin
      dwDigDownTick := GetTickCount();
    end;
  end;
  inherited;
  except
    MainOutMessage('{异常} TElfWarriorMonster.Run Code:'+inttostr(nCode));
    KickException();
  end;
end;

{ TElectronicScolpionMon }
//大蜈蚣
constructor TElectronicScolpionMon.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_boUseMagic := False;
end;

destructor TElectronicScolpionMon.Destroy;
begin

  inherited;
end;

procedure TElectronicScolpionMon.LightingAttack(nDir: Integer);
var
  WAbil: pTAbility;
  nPower, nDamage: Integer;
  btGetBackHP: Integer;
begin
  if m_TargetCret <> nil then begin
    m_btDirection := nDir;
    WAbil := @m_WAbil;
    nPower := GetAttackPower(LoWord(WAbil.MC), SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)));
    nDamage := m_TargetCret.GetMagStruckDamage(Self, nPower);
    if nDamage > 0 then begin
      btGetBackHP := LoByte(m_WAbil.MP);
      if btGetBackHP <> 0 then Inc(m_WAbil.HP, nDamage div btGetBackHP);
      m_TargetCret.StruckDamage(nDamage);
      m_TargetCret.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, m_TargetCret.m_WAbil.HP, m_TargetCret.m_WAbil.MaxHP, Integer(Self), '', 200);
    end;
    SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
  end;
end;

procedure TElectronicScolpionMon.Run;
var
  nAttackDir: Integer;
  nX, nY: Integer;
begin
  Try
    if (not m_boDeath) and (not m_boGhost) and (m_wStatusTimeArr[POISON_STONE {5}] = 0) then begin
      //血量低于一半时开始用魔法攻击
      if m_WAbil.HP < m_WAbil.MaxHP div 2 then m_boUseMagic := True
      else m_boUseMagic := False;

      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget();
      end;
      if m_TargetCret = nil then Exit;

      nX := abs(m_nCurrX - m_TargetCret.m_nCurrX);
      nY := abs(m_nCurrY - m_TargetCret.m_nCurrY);

      if (nX <= 2) and (nY <= 2) then begin
        if m_boUseMagic or ((nX = 2) or (nY = 2)) then begin
          if (Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime) then begin
            m_dwHitTick := GetTickCount();
            nAttackDir := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
            LightingAttack(nAttackDir);
          end;
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TElectronicScolpionMon.Run');
  end;
  inherited Run;
end;



{TFairyMonster}
//20080214
function TFairyMonster.CheckTargetXYCount(nX, nY, nRange: Integer): Integer; //检查身边一定范围的怪数量  20080214 增加
var
  BaseObject: TBaseObject;
  I, nC, n10: Integer;
begin
  Result := 0;
  n10 := nRange;
  if m_VisibleActors.Count > 0 then begin//20080629
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
    end;//for
  end;
end;
//20080327 
function TFairyMonster.IsNeedGotoXY(): Boolean; //是否走向目标
begin
  Result := False;
  if (m_TargetCret <> nil) and (GetTickCount - m_dwAutoAvoidTick > 1100) and (not m_boIsUseAttackMagic) and
  ((abs(m_TargetCret.m_nCurrX - m_nCurrX) > 6) or (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 6)) then begin
      m_dwAutoAvoidTick := GetTickCount();//20081108 增加
      Result := True;
  end;
end;
//20080214
function TFairyMonster.IsNeedAvoid(): Boolean; //是否需要躲避  20080214 增加
begin
  Result := False;
  if (GetTickCount - m_dwAutoAvoidTick > 1000) and (m_TargetCret <> nil) and (not m_boIsUseAttackMagic) then begin //20080618 怪在近身二格内
    //m_dwAutoAvoidTick := GetTickCount();
    if CheckTargetXYCount(m_nCurrX, m_nCurrY, 2) > 0 then begin
      m_dwAutoAvoidTick := GetTickCount();//20081108
      Result := True;
    end;
  end;
end;
//20080214
function TFairyMonster.CheckTargetXYCountOfDirection(nX, nY, nDir, nRange: Integer): Integer;{检测指定方向和范围内坐标的怪物数量}
var
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := 0;
  if m_VisibleActors.Count > 0 then begin//20080629
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
    end;//for
  end;
end;
(*//20080214
function TFairyMonster.RunToTargetXY(nTargetX, nTargetY: Integer): Boolean;
var
  nDir: Integer;
  n10: Integer;
  n14: Integer;
begin
  Result := False;
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
  if not RunTo(nDir, False, nTargetX, nTargetY) then begin
    Result := WalkToTargetXY(nTargetX, nTargetY);
  end else begin
    if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
      Result := True;
    end;
  end;
end;
//20080214
function TFairyMonster.WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
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
  if (abs(nTargetX - m_nCurrX) > 1) or (abs(nTargetY - m_nCurrY) > 1) then begin
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
    if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then Result := True;
    if not Result then begin
      n20 := Random(3);
      for I := DR_UP to DR_UPLEFT do begin
        if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
         { if n20 <> 0 then Inc(nDir)
          else if nDir > 0 then Dec(nDir)
          else nDir := DR_UPLEFT;
          if (nDir > DR_UPLEFT) then nDir := DR_UP;}

          if n20 <> 0 then Inc(nDir);//20080304 修改
          if (nDir > DR_UPLEFT) then nDir := DR_UP;//20080304 修改

          WalkTo(nDir, False);
          if (abs(nTargetX - m_nCurrX) <= 1) and (abs(nTargetY - m_nCurrY) <= 1) then begin
            Result := True;
            Break;
          end;
        end;
      end;
    end;
  end;
end;  *)
//20080214
function TFairyMonster.WalkToTargetXY2(nTargetX, nTargetY: Integer): Boolean;
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
//20080214
function TFairyMonster.GotoTargetXY(nTargetX, nTargetY: Integer): Boolean;
begin
{  if (abs(m_nCurrX - nTargetX) > 3) or (abs(m_nCurrY - nTargetY) > 3) then begin 
    Result := RunToTargetXY(nTargetX, nTargetY)
  end else begin
    Result := WalkToTargetXY2(nTargetX, nTargetY);
  end;}
  Result := WalkToTargetXY2(nTargetX, nTargetY);//20080722 修改
end;

//20080214
function TFairyMonster.AutoAvoid(): Boolean; //自动躲避
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
    Result := GetGotoXY(m_btLastDirection, nTargetX, nTargetY);
   n10 := 0;
    while True do begin
      if n10 >= 10 then Break;
      if Result then Break;
      nTargetX := nX;
      nTargetY := nY;
      nDir := Random(7);
      Result := GetGotoXY(nDir, nTargetX, nTargetY);
      Inc(n10);
    end;
   // m_btLastDirection := nDir; //m_btDirection;  20080402
  end;
  function GotoMasterXY(var nTargetX, nTargetY: Integer): Boolean;
  var
    nDir: Integer;
  begin
    Result := False;
    if (m_Master <> nil) and ((abs(m_Master.m_nCurrX - m_nCurrX) >= 4) or (abs(m_Master.m_nCurrY - m_nCurrY) >= 4))  then begin
      nTargetX := m_nCurrX;
      nTargetY := m_nCurrY;
      //nTargetX := m_Master.m_nCurrX;//20080215
      //nTargetY := m_Master.m_nCurrY;//20080215
      nDir := GetDirXY(m_Master.m_nCurrX, m_Master.m_nCurrY);
      //m_btLastDirection := nDir;//20080618
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
  if (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) then begin
    if GotoMasterXY(nTargetX, nTargetY) then begin
      Result := GotoTargetXY(nTargetX, nTargetY);
    end else begin
      nTargetX := m_TargetCret.m_nCurrX;
      nTargetY := m_TargetCret.m_nCurrY;
      nDir:=GetNextDirection(m_nCurrX,m_nCurrY,nTargetX, nTargetY);
      nDir:= GetBackDir(nDir);
      m_PEnvir.GetNextPosition(nTargetX, nTargetY,nDir,3,m_nTargetX, m_nTargetY);
      Result :=GotoTargetXY(m_nTargetX, m_nTargetY);
    end;
  end;
end;

procedure TFairyMonster.FlyAxeAttack(Target: TBaseObject);
var
  WAbil: pTAbility;
  nDamage: Integer;
begin
  if (Random(g_Config.nFairyDuntRate) = 0) and (Target.m_Abil.Level <= m_Abil.Level) then begin //重击几率 //目标等级不高于自己,才使用重击 20080826
    //if m_PEnvir.CanFly(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY) then begin //20080314 注释
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY);
      WAbil := @m_WAbil;
      nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC)) * g_Config.nFairyAttackRate{重击倍数};
      if nDamage > 0 then begin
        nDamage := Target.GetHitStruckDamage(Self, nDamage);
      end;
      if nDamage > 0 then Target.StruckDamage(nDamage);
      Target.SetLastHiter(self);//20080628
      Target.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, Target.m_WAbil.HP, Target.m_WAbil.MaxHP, Integer(Self), '',
        _MAX(abs(m_nCurrX - Target.m_nCurrX), abs(m_nCurrY - Target.m_nCurrY)) * 50 + 600);
      SendRefMsg(RM_FAIRYATTACKRATE, 1, m_nCurrX, m_nCurrY, Integer(Target), '');
      m_dwActionTick := GetTickCount();
    //end; //20080314 注释
  end else begin
    //if m_PEnvir.CanFly(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY) then begin //20080314 注释
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, Target.m_nCurrX, Target.m_nCurrY);
      WAbil := @m_WAbil;
      nDamage := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
      if nDamage > 0 then begin
        nDamage := Target.GetHitStruckDamage(Self, nDamage);
      end;
      if nDamage > 0 then Target.StruckDamage(nDamage);
      Target.SetLastHiter(self);//20080628
      Target.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nDamage, Target.m_WAbil.HP, Target.m_WAbil.MaxHP, Integer(Self), '',
        _MAX(abs(m_nCurrX - Target.m_nCurrX), abs(m_nCurrY - Target.m_nCurrY)) * 50 + 600);
      SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(Target), '');
      m_dwActionTick := GetTickCount();
   // end; //20080314 注释
  end;
end;

//增加检查两动作的间隔
function TFairyMonster.CheckActionStatus(): Boolean;
begin
  Result := False;
  if GetTickCount - m_dwActionTick > 900 then begin
    m_dwActionTick := GetTickCount();
    Result := True;
  end;
end;

function TFairyMonster.AttackTarget: Boolean; //00459B14
begin
  Result := False;
  if (m_TargetCret = nil) or (m_TargetCret = m_Master) then  Exit;
  if not CheckActionStatus then begin
    m_boIsUseAttackMagic:= False;//20080717
    Exit;
  end;
  m_boIsUseAttackMagic:= True;//20080717
  if {Integer}(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin//20080716 修改
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 6) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 6) then begin
      m_dwTargetFocusTick := GetTickCount();
      FlyAxeAttack(m_TargetCret);
      m_boIsUseAttackMagic:= False;//20080717
      Result := True;
      Exit;
    end else m_boIsUseAttackMagic:= False;//20080722
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end else begin
      DelTargetCreat();
    end;
  end else m_boIsUseAttackMagic:= False;//20080717
end;

constructor TFairyMonster.Create;
begin
  inherited;
  m_dwSearchTime := Random(1500) + 1500;
  m_boIsUseAttackMagic:= False;//20080618
end;

destructor TFairyMonster.Destroy;
begin
  inherited;
end;

procedure TFairyMonster.Run;
var
  nX, nY: Integer;
begin
  Try
    if (not m_boDeath) and (not m_boGhost) and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
        if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
          m_dwSearchEnemyTick := GetTickCount();
          SearchTarget(); //搜索可攻击目标
        end;

        if ({Integer}(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) then begin//走路间隔
          m_dwWalkTick := GetTickCount;//走路间隔 20080715
          {Inc(m_nWalkCount);
          if m_nWalkCount > m_nWalkStep then begin
            m_nWalkCount := 0;
            m_boWalkWaitLocked := True;
            m_dwWalkWaitTick := GetTickCount();
          end;}
          if not m_boNoAttackMode then begin
            if (m_TargetCret <> nil) then begin
              if (not m_TargetCret.m_boDeath) then begin//目标不为空
                if AttackTarget then begin
                  inherited;
                  Exit;
                end;
                if IsNeedAvoid then begin //20080214 月灵躲避
                  AutoAvoid(); //自动躲避
                  inherited;
                  Exit;
                end else begin
                  if IsNeedGotoXY then begin //20080327 目标离远了,走向目标
                    GotoTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
                    inherited;
                    Exit;
                  end;
                end;
              end;
            end;
          end;
          if (m_Master<> nil) then begin
            if (not m_Master.m_boSlaveRelax) then begin//20080725 增加,离主人远后,自已走近主人
              if m_TargetCret = nil then begin
                m_Master.GetBackPosition(nX, nY);
                if (abs(m_nTargetX - nX) > {3}1) or (abs(m_nTargetY - nY ) > {3}1) then begin
                  m_nTargetX := nX;
                  m_nTargetY := nY;
                  if (abs(m_nCurrX - nX) <= {4}2) and (abs(m_nCurrY - nY) <= {4}2) then begin
                    if m_PEnvir.GetMovingObject(nX, nY, True) <> nil then begin
                      m_nTargetX := m_nCurrX;
                      m_nTargetY := m_nCurrY;
                    end;
                  end;
                end;
                if m_nTargetX <> -1 then begin
                  if (abs(m_nCurrX - m_nTargetX) > 1) or (abs(m_nCurrY - m_nTargetY) > 1) then begin
                    GotoTargetXY(m_nTargetX, m_nTargetY);
                  end;
                end;
              end;
            end;

            if (m_Master<> nil) and (not m_Master.m_boSlaveRelax) and//离主人远了,直接飞到主人身边 20080409
              ((m_PEnvir <> m_Master.m_PEnvir) or
              (abs(m_nCurrX - m_Master.m_nCurrX) > 20) or
              (abs(m_nCurrY - m_Master.m_nCurrY) > 20)) then begin
              SpaceMove(m_Master.m_PEnvir.sMapName, m_Master.m_nCurrX, m_Master.m_nCurrY, 1);
            end;
          end;
        end;
    end else begin
      if m_boDeath then begin
        if (GetTickCount - m_dwDeathTick > 2000) then MakeGhost();//尸体消失
      end;
    end;
  except
    MainOutMessage('{异常} TFairyMonster.Run');
  end;
  inherited;
end;

//在USR单元初始化
procedure TFairyMonster.RecalcAbilitys;
begin
  inherited;
  ResetElfMon();
end;
//月灵间隔
procedure TFairyMonster.ResetElfMon();
begin
  m_nNextHitTime := 1500 - m_btSlaveMakeLevel * 100;//下次攻击时间
  //m_dwWalkTick := GetTickCount;//走路间隔
  if m_Master<> nil then m_nWalkSpeed := 400 - m_btSlaveMakeLevel * 50;//走路速度 20081108
end;


{ TGiantSickleSpiderATMonster 巨镰蜘蛛}
constructor TGiantSickleSpiderATMonster.Create;
begin
  inherited;
  m_boExploration:= False;//是否可探索 20080810
  m_ButchItemList := TList.Create;//可探索物品列表 20080810
end;

destructor TGiantSickleSpiderATMonster.Destroy;
var
  I: Integer;
begin
  if m_ButchItemList.Count > 0 then begin//可探索物品列表 20080810
    for I := 0 to m_ButchItemList.Count - 1 do begin
      if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
         Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
    end;
  end;
  FreeAndNil(m_ButchItemList);
  inherited;
end;

procedure TGiantSickleSpiderATMonster.Die;
begin
  if m_boExploration then begin//可探索,则发消息让客户端提示
    SendRefMsg(RM_CANEXPLORATION, 0, 0, 0, 0, '');
  end;
  inherited;
end;

//显示名字,重载此方法,使人物进入地图后,可以看到死了怪身上有"可探索"字样
function TGiantSickleSpiderATMonster.GetShowName(): string;
begin
  Result := FilterShowName(m_sCharName);//过滤有数字的名称
  if m_boExploration and m_boDeath and (not m_boGhost) then begin//可探索,则发消息让客户端提示
    SendRefMsg(RM_CANEXPLORATION, 0, 0, 0, 0, '');
  end;
end;

procedure TGiantSickleSpiderATMonster.AddItemsFromConfig();
var
  I: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItemInfo;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
  ItemIni: TIniFile;
begin
//---------------------------读取怪物配置----------------------------------
  s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '.txt';
  if FileExists(s24) then begin
    ItemIni := TIniFile.Create(s24);
    if ItemIni <> nil then begin
      //m_nButchRate:= ItemIni.ReadInteger('Info','ButchRate',10);//挖取身上装备机率
      m_nButchChargeClass:= ItemIni.ReadInteger('Info','ButchChargeClass',3);//收费模式(0金币，1元宝，2金刚石，3灵符)
      m_nButchChargeCount:= ItemIni.ReadInteger('Info','ButchChargeCount',1);//挖每次收费点数
      boIntoTrigger:= ItemIni.ReadBool('Info','ButchCloneItem',False);//怪挖是否进入触发
  //---------------------------读取探索物品----------------------------------
      s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '-Item.txt';
      if FileExists(s24) then begin
        if m_ButchItemList <> nil then begin
          if m_ButchItemList.Count > 0 then begin
            for I := 0 to m_ButchItemList.Count - 1 do begin
              if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
                 Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
            end;
          end;
          m_ButchItemList.Clear;
        end;
        LoadList := TStringList.Create;
        LoadList.LoadFromFile(s24);
        if LoadList.Count > 0 then begin
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
                Randomize;//播下随机种子
                if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin//计算机率 1/10 随机10<=1 即为所得的物品
                  m_ButchItemList.Add(MonItem);
                end;
              end;
            end;
          end;
        end;
        if m_ButchItemList.Count > 0 then m_boExploration:= True;//是否可探索 20080810
        LoadList.Free;
      end;
      ItemIni.Free;
    end;
  end;
end;

{TSalamanderATMonster 狂热火蜥蜴 20080809}
constructor TSalamanderATMonster.Create;
begin
  inherited;
  m_boExploration:= False;//是否可探索 20080810
  m_ButchItemList := TList.Create;//可探索物品列表 20080810
end;

destructor TSalamanderATMonster.Destroy;
var
  I: Integer;
begin
  if m_ButchItemList.Count > 0 then begin//可探索物品列表 20080810
    for I := 0 to m_ButchItemList.Count - 1 do begin
      if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
         Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
    end;
  end;
  FreeAndNil(m_ButchItemList);
  inherited;
end;

procedure TSalamanderATMonster.Die;
begin
  if m_boExploration then begin//可探索,则发消息让客户端提示
    SendRefMsg(RM_CANEXPLORATION, 0, 0, 0, 0, '');
  end;
  inherited;
end;

//显示名字
function TSalamanderATMonster.GetShowName(): string;
begin
  Result := FilterShowName(m_sCharName);//过滤有数字的名称
  if m_boExploration and m_boDeath and (not m_boGhost) then begin//可探索,则发消息让客户端提示
    SendRefMsg(RM_CANEXPLORATION, 0, 0, 0, 0, '');
  end;
end;

procedure TSalamanderATMonster.AddItemsFromConfig();
var
  I: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItemInfo;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
  ItemIni: TIniFile;
begin
//---------------------------读取怪物配置----------------------------------
  s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '.txt';
  if FileExists(s24) then begin
    ItemIni := TIniFile.Create(s24);
    if ItemIni <> nil then begin
      //m_nButchRate:= ItemIni.ReadInteger('Info','ButchRate',10);//挖取身上装备机率
      m_nButchChargeClass:= ItemIni.ReadInteger('Info','ButchChargeClass',3);//收费模式(0金币，1元宝，2金刚石，3灵符)
      m_nButchChargeCount:= ItemIni.ReadInteger('Info','ButchChargeCount',1);//挖每次收费点数
      boIntoTrigger:= ItemIni.ReadBool('Info','ButchCloneItem',False);//怪挖是否进入触发
  //---------------------------读取探索物品----------------------------------
      s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '-Item.txt';
      if FileExists(s24) then begin
        if m_ButchItemList <> nil then begin
          if m_ButchItemList.Count > 0 then begin
            for I := 0 to m_ButchItemList.Count - 1 do begin
              if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
                 Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
            end;
          end;
          m_ButchItemList.Clear;
        end;
        LoadList := TStringList.Create;
        LoadList.LoadFromFile(s24);
        if LoadList.Count > 0 then begin
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
                Randomize;//播下随机种子
                if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin//计算机率 1/10 随机10<=1 即为所得的物品
                  m_ButchItemList.Add(MonItem);
                end;
              end;
            end;
          end;
        end;
        if m_ButchItemList.Count > 0 then m_boExploration:= True;//是否可探索 20080810
        LoadList.Free;
      end;
      ItemIni.Free;
    end;
  end;
end;

procedure TSalamanderATMonster.Run;
var
  nPower: Integer;
begin
  Try
    if (not m_boDeath) and (not m_boGhost) and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
      if (m_TargetCret <> nil) and (GetTickCount - m_dwHitTick > m_nNextHitTime) and
         (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) then begin
         m_dwHitTick:= GetTickCount();

        if (Random(4) = 0) then begin//癫狂状态
          if (g_EventManager.GetEvent(m_PEnvir, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, ET_FIRE) = nil) {and (Random(2) = 0)} then begin
             MagMakeFireCross(Self, GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))), 4, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);//火墙
          end else
          if (Random(4) = 0) then begin
            if IsProperTarget(m_TargetCret) then begin
              if Random(m_TargetCret.m_btAntiPoison + 7) <= 6 then begin//施毒
                 //nPower:={(m_TargetCret.m_WAbil.MaxHP * LoWord(m_WAbil.MC)) div 100};
                 nPower:=GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
                 m_TargetCret.SendDelayMsg(self, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPower, Integer(self), 4, '', 150);
              end;
            end;
          end else AttackTarget();//物理攻击
        end else begin
          if (Random(4) = 0) then begin
            if IsProperTarget(m_TargetCret) then begin
              if Random(m_TargetCret.m_btAntiPoison + 7) <= 6 then begin//施毒
                 //nPower:={(m_TargetCret.m_WAbil.MaxHP * LoWord(m_WAbil.MC)) div 100};
                 nPower:=GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
                 m_TargetCret.SendDelayMsg(self, RM_POISON, POISON_DECHEALTH {中毒类型 - 绿毒}, nPower, Integer(self), 4, '', 150);
              end;
            end;
          end else
           if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) then begin
             AttackTarget();//物理攻击
           end;
        end;
      end;
    end;//if (not m_boDeath)
  except
    MainOutMessage('{异常} TSalamanderATMonster.Run');
  end;
  inherited;
end;

function TSalamanderATMonster.AttackTarget():Boolean;
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
    if TargetInSpitRange(m_TargetCret, btDir) then begin
      m_dwHitTick:= GetTickCount();
      m_dwTargetFocusTick:=GetTickCount();
      Attack(m_TargetCret,btDir);
      Result:=True;
    end;
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin //20080605 增加
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end else begin
      DelTargetCreat();
    end;
  end;
end;
//火墙 4*4
function TSalamanderATMonster.MagMakeFireCross(PlayObject: TBaseObject; nDamage, nHTime, nX, nY: Integer): Integer;
var
  FireBurnEvent: TFireBurnEvent;
begin
  Result := 0;
  if PlayObject.m_PEnvir.GetEvent(nX, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX, nY - 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY - 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX, nY - 2) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY - 2, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX, nY + 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY + 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX, nY + 2) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY + 2, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX -1, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX - 1, nY - 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY - 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX - 1, nY - 2) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY - 2, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX - 1, nY + 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY + 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX - 1, nY + 2) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY + 2, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX - 2, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 2, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX - 2, nY - 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 2, nY - 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX - 2, nY + 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 2, nY + 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX + 1, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX + 1, nY - 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY - 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX + 1, nY - 2) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY - 2, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX + 1, nY + 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY + 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX + 1, nY + 2) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY + 2, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX + 2, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 2, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX + 2, nY - 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 2, nY - 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  if PlayObject.m_PEnvir.GetEvent(nX + 2, nY + 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 2, nY + 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end;
  Result := 1;
end;

{TTempleGuardian 圣殿卫士 20080809}
constructor TTempleGuardian.Create;
begin
  inherited;
  m_boExploration:= False;//是否可探索 20080810
  m_ButchItemList := TList.Create;//可探索物品列表 20080810
end;

destructor TTempleGuardian.Destroy;
var
  I: Integer;
begin
  if m_ButchItemList.Count > 0 then begin//可探索物品列表 20080810
    for I := 0 to m_ButchItemList.Count - 1 do begin
      if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
         Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
    end;
  end;
  FreeAndNil(m_ButchItemList);
  inherited;
end;

procedure TTempleGuardian.Die;
begin
  if m_boExploration then begin//可探索,则发消息让客户端提示
    SendRefMsg(RM_CANEXPLORATION, 0, 0, 0, 0, '');
  end;
  inherited;
end;

//显示名字
function TTempleGuardian.GetShowName(): string;
begin
  Result := FilterShowName(m_sCharName);//过滤有数字的名称
  if m_boExploration and m_boDeath and (not m_boGhost) then begin//可探索,则发消息让客户端提示
    SendRefMsg(RM_CANEXPLORATION, 0, 0, 0, 0, '');
  end;
end;

procedure TTempleGuardian.AddItemsFromConfig();
var
  I: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItemInfo;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
  ItemIni: TIniFile;
begin
//---------------------------读取怪物配置----------------------------------
  s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '.txt';
  if FileExists(s24) then begin
    ItemIni := TIniFile.Create(s24);
    if ItemIni <> nil then begin
      //m_nButchRate:= ItemIni.ReadInteger('Info','ButchRate',10);//挖取身上装备机率
      m_nButchChargeClass:= ItemIni.ReadInteger('Info','ButchChargeClass',3);//收费模式(0金币，1元宝，2金刚石，3灵符)
      m_nButchChargeCount:= ItemIni.ReadInteger('Info','ButchChargeCount',1);//挖每次收费点数
      boIntoTrigger:= ItemIni.ReadBool('Info','ButchCloneItem',False);//怪挖是否进入触发
  //---------------------------读取探索物品----------------------------------
      s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '-Item.txt';
      if FileExists(s24) then begin
        if m_ButchItemList <> nil then begin
          if m_ButchItemList.Count > 0 then begin
            for I := 0 to m_ButchItemList.Count - 1 do begin
              if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
                 Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
            end;
          end;
          m_ButchItemList.Clear;
        end;
        LoadList := TStringList.Create;
        LoadList.LoadFromFile(s24);
        if LoadList.Count > 0 then begin
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
                Randomize;//播下随机种子
                if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin//计算机率 1/10 随机10<=1 即为所得的物品
                  m_ButchItemList.Add(MonItem);
                end;
              end;
            end;
          end;
        end;
        if m_ButchItemList.Count > 0 then m_boExploration:= True;//是否可探索 20080810
        LoadList.Free;
      end;
      ItemIni.Free;
    end;
  end;
end;

procedure TTempleGuardian.Attack(TargeTBaseObject: TBaseObject; nDir: Integer);
var
  WAbil: pTAbility;
  nPower: Integer;
begin
  WAbil := @m_WAbil;
  nPower := GetAttackPower(LoWord(WAbil.DC), SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  HitMagAttackTarget(TargeTBaseObject, nPower div 2, nPower div 2, True);
end;

{ TheCrutchesSpider  金杖蜘蛛 20080809}

constructor TheCrutchesSpider.Create;
begin
  inherited;
  m_boExploration:= False;//是否可探索 20080810
  m_ButchItemList := TList.Create;//可探索物品列表 20080810
end;

destructor TheCrutchesSpider.Destroy;
var
  I: Integer;
begin
  if m_ButchItemList.Count > 0 then begin//可探索物品列表 20080810
    for I := 0 to m_ButchItemList.Count - 1 do begin
      if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
         Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
    end;
  end;
  FreeAndNil(m_ButchItemList);
  inherited;
end;

procedure TheCrutchesSpider.Die;
begin
  if m_boExploration then begin//可探索,则发消息让客户端提示
    SendRefMsg(RM_CANEXPLORATION, 0, 0, 0, 0, '');
  end;
  inherited;
end;

//显示名字
function TheCrutchesSpider.GetShowName(): string;
begin
  Result := FilterShowName(m_sCharName);//过滤有数字的名称
  if m_boExploration and m_boDeath and (not m_boGhost) then begin//可探索,则发消息让客户端提示
    SendRefMsg(RM_CANEXPLORATION, 0, 0, 0, 0, '');
  end;
end;

procedure TheCrutchesSpider.AddItemsFromConfig();
var
  I: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItemInfo;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
  ItemIni: TIniFile;
begin
//---------------------------读取怪物配置----------------------------------
  s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '.txt';
  if FileExists(s24) then begin
    ItemIni := TIniFile.Create(s24);
    if ItemIni <> nil then begin
      //m_nButchRate:= ItemIni.ReadInteger('Info','ButchRate',10);//挖取身上装备机率
      m_nButchChargeClass:= ItemIni.ReadInteger('Info','ButchChargeClass',3);//收费模式(0金币，1元宝，2金刚石，3灵符)
      m_nButchChargeCount:= ItemIni.ReadInteger('Info','ButchChargeCount',1);//挖每次收费点数
      boIntoTrigger:= ItemIni.ReadBool('Info','ButchCloneItem',False);//怪挖是否进入触发
  //---------------------------读取探索物品----------------------------------
      s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '-Item.txt';
      if FileExists(s24) then begin
        if m_ButchItemList <> nil then begin
          if m_ButchItemList.Count > 0 then begin
            for I := 0 to m_ButchItemList.Count - 1 do begin
              if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
                 Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
            end;
          end;
          m_ButchItemList.Clear;
        end;
        LoadList := TStringList.Create;
        LoadList.LoadFromFile(s24);
        if LoadList.Count > 0 then begin
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
                Randomize;//播下随机种子
                if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin//计算机率 1/10 随机10<=1 即为所得的物品
                  m_ButchItemList.Add(MonItem);
                end;
              end;
            end;
          end;
        end;
        if m_ButchItemList.Count > 0 then m_boExploration:= True;//是否可探索 20080810
        LoadList.Free;
      end;
      ItemIni.Free;
    end;
  end;
end;

procedure TheCrutchesSpider.Run;
begin
  Try
    if not m_boDeath and not m_boGhost and(m_wStatusTimeArr[POISON_STONE ] = 0) then begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
        m_dwSearchEnemyTick := GetTickCount();
        SearchTarget(); //搜索可攻击目标
      end;

      if  (m_TargetCret <> nil) then begin     //走路间隔
        if (GetTickCount - m_dwWalkTick > m_nWalkSpeed) and (not m_TargetCret.m_boDeath) then begin//目标不为空
           if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) then begin
              if (m_WAbil.HP < Round(m_WAbil.MaxHP)) and (Random(4) = 0) then begin//使用群体治疗术
                if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
                  m_dwHitTick := GetTickCount();
                  MagicManager.MagBigHealing(Self, 50 ,m_nCurrX,m_nCurrY);//群体治疗术
                  SendRefMsg(RM_FAIRYATTACKRATE, 1, m_nCurrX, m_nCurrY, Integer(self), '');
                end;
              end;
              AttackTarget;
           end else begin
              GotoTargetXY;
           end;
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TheCrutchesSpider.Run');
  end;
  inherited;
end;

//远距离使用冰咆哮 5*5范围
function TheCrutchesSpider.AttackTarget: Boolean;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) then begin
      m_dwTargetFocusTick := GetTickCount();
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      MagicManager.MagBigExplosion(self, GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))), m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, g_Config.nSnowWindRange, SKILL_SNOWWIND);
      SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
      Result := True;
      Exit;
    end;
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end else begin
      DelTargetCreat();
    end;
  end;
end;

{TYanLeiWangSpider 雷炎蛛王}

constructor TYanLeiWangSpider.Create;
begin
  inherited;
  m_boExploration:= False;//是否可探索
  m_ButchItemList := TList.Create;//可探索物品列表
  boIsSpiderMagic:= False;//是否喷出蜘蛛网
end;

destructor TYanLeiWangSpider.Destroy;
var
  I: Integer;
begin
  if m_ButchItemList.Count > 0 then begin//可探索物品列表
    for I := 0 to m_ButchItemList.Count - 1 do begin
      if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
         Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
    end;
  end;
  FreeAndNil(m_ButchItemList);
  inherited;
end;

procedure TYanLeiWangSpider.Die;
begin
  if m_boExploration then begin//可探索,则发消息让客户端提示
    SendRefMsg(RM_CANEXPLORATION, 0, 0, 0, 0, '');
  end;
  inherited;
end;

//显示名字
function TYanLeiWangSpider.GetShowName(): string;
begin
  Result := FilterShowName(m_sCharName);//过滤有数字的名称
  if m_boExploration and m_boDeath and (not m_boGhost) then begin//可探索,则发消息让客户端提示
    SendRefMsg(RM_CANEXPLORATION, 0, 0, 0, 0, '');
  end;
end;

procedure TYanLeiWangSpider.AddItemsFromConfig();
var
  I: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItemInfo;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
  ItemIni: TIniFile;
begin
//---------------------------读取怪物配置----------------------------------
  s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '.txt';
  if FileExists(s24) then begin
    ItemIni := TIniFile.Create(s24);
    if ItemIni <> nil then begin
      //m_nButchRate:= ItemIni.ReadInteger('Info','ButchRate',10);//挖取身上装备机率
      m_nButchChargeClass:= ItemIni.ReadInteger('Info','ButchChargeClass',3);//收费模式(0金币，1元宝，2金刚石，3灵符)
      m_nButchChargeCount:= ItemIni.ReadInteger('Info','ButchChargeCount',1);//挖每次收费点数
      boIntoTrigger:= ItemIni.ReadBool('Info','ButchCloneItem',False);//挖是否进入触发
  //---------------------------读取探索物品----------------------------------
      s24 := g_Config.sEnvirDir + 'MonUseItems\' + m_sCharName + '-Item.txt';
      if FileExists(s24) then begin
        if m_ButchItemList <> nil then begin
          if m_ButchItemList.Count > 0 then begin
            for I := 0 to m_ButchItemList.Count - 1 do begin
              if pTMonItemInfo(m_ButchItemList.Items[I]) <> nil then
                 Dispose(pTMonItemInfo(m_ButchItemList.Items[I]));
            end;
          end;
          m_ButchItemList.Clear;
        end;
        LoadList := TStringList.Create;
        LoadList.LoadFromFile(s24);
        if LoadList.Count > 0 then begin
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
                Randomize;//播下随机种子
                if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin//计算机率 1/10 随机10<=1 即为所得的物品
                  m_ButchItemList.Add(MonItem);
                end;
              end;
            end;
          end;
        end;
        if m_ButchItemList.Count > 0 then m_boExploration:= True;//是否可探索 20080810
        LoadList.Free;
      end;
      ItemIni.Free;
    end;
  end;
end;

procedure TYanLeiWangSpider.Run;
var
  nPower: Integer;
begin
  Try
    if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE ] = 0) then begin
      if (GetTickCount - m_dwWalkTick > m_nWalkSpeed) and//走路间隔
          (m_TargetCret <> nil) and (not m_TargetCret.m_boDeath) then begin//目标不为空
         if boIsSpiderMagic then begin//喷出网后,延时1100毫秒显示目标的效果
           if GetTickCount - m_dwSpiderMagicTick > 1100 then begin
             boIsSpiderMagic:= False;//是否喷出蜘蛛网
             SpiderMagicAttack(nPower div 2, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 3);
             inherited;
             Exit;
           end;
         end;
         if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) then begin
            if (Random(4) = 0) and (m_TargetCret.m_wStatusTimeArr[STATE_LOCKRUN] = 0) then begin//喷出蜘蛛网
              if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
                m_dwHitTick := GetTickCount();
                nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
                SendRefMsg(RM_LIGHTING, 1, m_nCurrX, m_nCurrY, Integer(m_TargetCret), '');
                m_dwSpiderMagicTick:= GetTickCount();//喷出蜘蛛网计时,用于延时处理目标身上的小网显示
                boIsSpiderMagic:= True;//是否喷出蜘蛛网
              end;
            end else AttackTarget;
         end else begin
            GotoTargetXY;
         end;
      end;
    end; 
  except
    MainOutMessage('{异常} TYanLeiWangSpider.Run');
  end;
  inherited;
end;
//物理攻击
function TYanLeiWangSpider.AttackTarget: Boolean;
var
  nPower: Integer;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetTickCount - m_dwHitTick > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) then begin
      m_dwTargetFocusTick := GetTickCount();
      //m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      nPower := GetAttackPower(LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)));
      HitMagAttackTarget(m_TargetCret, nPower div 2, nPower div 2, True);
      Result := True;
      Exit;
    end;
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin
        SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end else begin
      DelTargetCreat();
    end;
  end; 
end;
//喷出蜘蛛网   被蜘蛛网包围,只能走动,不能跑动
procedure TYanLeiWangSpider.SpiderMagicAttack(nPower, nX, nY: Integer; nRage: Integer);
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  BaseObjectList := TList.Create;
  GetMapBaseObjects(m_PEnvir, nX, nY, nRage, BaseObjectList);
  if BaseObjectList.Count > 0 then begin
    for I := 0 to BaseObjectList.Count - 1 do begin
      TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
      if IsProperTarget(TargeTBaseObject) then begin
        if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin //英雄锁定后,不打锁定怪 20081214 修改
          if not THeroObject(TargeTBaseObject).m_boTarget then TargeTBaseObject.SetTargetCreat(self);
        end else TargeTBaseObject.SetTargetCreat(self);

        TargeTBaseObject.SendMsg(self, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
        TargeTBaseObject.MakeSpiderMag(7);//中蛛网，不能跑动   //改变角色状态
      end;
    end;
  end;
  BaseObjectList.Free;
end;

end.

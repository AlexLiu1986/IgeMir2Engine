unit ObjMon2;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjMon, SysUtils;
type
  TStickMonster = class(TAnimalObject)//ʳ�˻�
    bo550: Boolean;
    n554: Integer;
    n558: Integer;
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; virtual;
    procedure sub_FFEA; virtual;
    procedure sub_FFE9; virtual;
    procedure VisbleActors; virtual; //FFE8
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  TBeeQueen = class(TAnimalObject) //û�д����
    BBList: TList;
  private
    procedure MakeChildBee;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  TCentipedeKingMonster = class(TStickMonster) //������  ���ܶ��Ĺ��
    m_dwAttickTick: LongWord; //0x560
  private
    function sub_4A5B0C: Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean; override;
    procedure sub_FFE9; override;
    procedure Run; override;
  end;
  TBigHeartMonster = class(TAnimalObject) //���¶�ħ  ǧ������  Ӧ���� ������ʱ�� �ӵ���ð�̵�  ���ܶ��Ĺ�
  private

  public
    constructor Create(); override;
    destructor Destroy; override;

    function AttackTarget(): Boolean; virtual;
    procedure Run; override;
  end;
  TSpiderHouseMonster = class(TAnimalObject) //���ڿ��� �����ֵ� ��
    BBList: TList;
  private
    procedure GenBB;
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override; //FFFC
    procedure Run; override;
  end;
  TExplosionSpider = class(TMonster)//��Ӱ֩��
    dw558: LongWord;
  private
    procedure sub_4A65C4;

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
    function AttackTarget(): Boolean; override; //FFEB
  end;
  TGuardUnit = class(TAnimalObject)
    dw54C: LongWord; //0x54C
    m_nX550: Integer; //0x550
    m_nY554: Integer; //0x554
    m_nDirection: Integer; //����
  public
    function IsProperTarget(BaseObject: TBaseObject): Boolean; override; //FFF4
    procedure Struck(hiter: TBaseObject); override; //FFEC
  end;
  TArcherGuard = class(TGuardUnit)//����������� NPC
  private
    procedure sub_4A6B30(TargeTBaseObject: TBaseObject);

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
//------------------------------------------------------------------------------
  TArcherGuardMon = class(TGuardUnit)//���ƹ����ֵĹ�,ֻ��������,�����˺ͱ��� 20080121
  private
    procedure sub_4A6B30(TargeTBaseObject: TBaseObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
//------------------------------------------------------------------------------
  TArcherGuardMon1 = class(TAnimalObject)//136��,���ṥ��,�����ƶ� 20080122
    m_NewCurrX: Integer;
    m_NewCurrY: Integer;
    m_boWalk: Boolean;
  private
    function WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;
//------------------------------------------------------------------------------
  TArcherPolice = class(TArcherGuard) //û�д����
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
  end;
  TCastleDoor = class(TGuardUnit)//ɳ�Ϳ˵� ����
    dw55C: LongWord; //0x55C
    dw560: LongWord; //0x560
    m_boOpened: Boolean; //0x564
    bo565n: Boolean; //0x565
    bo566n: Boolean; //0x566
    bo567n: Boolean; //0x567
  private
    procedure SetMapXYFlag(nFlag: Integer);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Die; override;
    procedure Run; override;
    procedure Initialize(); override;
    procedure Close;
    procedure Open;
    procedure RefStatus;
  end;
  TWallStructure = class(TGuardUnit)//ɳ�Ϳ˵� ��ǽ
    n55C: Integer;
    dw560: LongWord;
    boSetMapFlaged: Boolean;//��ͼ��ʶ
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize; override;
    procedure Die; override;
    procedure Run; override;
    procedure RefStatus;
  end;
  TSoccerBall = class(TAnimalObject)//�ɻ�����
    n548: Integer;
    n550: Integer;
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Struck(hiter: TBaseObject); virtual; //FFEC
    procedure Run; override;
  end;
implementation

uses M2Share, HUtil32, Castle, Guild;


{ TStickMonster }
constructor TStickMonster.Create; //004A51C0
begin
  inherited;
  bo550 := False;
  m_nViewRange := 7;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_btRaceServer := 85;
  n554 := 4;
  n558 := 4;
  m_boFixedHideMode := True;
  m_boStickMode := True;
  m_boAnimal := True;
end;

destructor TStickMonster.Destroy; //004A5290
begin

  inherited;
end;
function TStickMonster.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetAttackDir(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      Attack(m_TargetCret, btDir);
    end;
    Result := True;
    Exit;
  end;
  if m_TargetCret.m_PEnvir = m_PEnvir then begin
    if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin //20080605 ����
      SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
    end;
  end else begin
    DelTargetCreat();
  end;
end;

procedure TStickMonster.sub_FFE9();
begin
  m_boFixedHideMode := False;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;
procedure TStickMonster.VisbleActors(); //004A53E4
var
  I: Integer;
resourcestring
  sExceptionMsg = '{�쳣} TStickMonster::VisbleActors Dispose';
begin
  SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  try
    if m_VisibleActors.Count > 0 then begin//20080629
      for I := 0 to m_VisibleActors.Count - 1 do begin
        Dispose({pTVisibleBaseObject}(m_VisibleActors.Items[I]));
      end;
    end;
    m_VisibleActors.Clear;
  except
    MainOutMessage(sExceptionMsg);
  end;
  m_boFixedHideMode := True;
end;
procedure TStickMonster.sub_FFEA(); //004A53E4
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  if m_VisibleActors.Count > 0 then begin//20080629
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject = nil then Continue;
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if not BaseObject.m_boHideMode or m_boCoolEye then begin
          if (abs(m_nCurrX - BaseObject.m_nCurrX) < n554) and (abs(m_nCurrY - BaseObject.m_nCurrY) < n554) then begin
            sub_FFE9();
            Break;
          end;
        end;
      end;
    end; // for
  end;
end;

function TStickMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TStickMonster.Run; //004A5614
var
  bo05: Boolean;
begin
  try
    if not m_boGhost and
      not m_boDeath and
      (m_wStatusTimeArr[POISON_STONE {5}] = 0) then begin
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        m_dwWalkTick := GetTickCount();
        if m_boFixedHideMode then begin
          sub_FFEA();
        end else begin
          if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
            SearchTarget();
          end;
          bo05 := False;
          if m_TargetCret <> nil then begin
            if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > n558) or
              (abs(m_TargetCret.m_nCurrY - m_nCurrY) > n558) then begin
              bo05 := True;
            end;
          end else bo05 := True;
          if bo05 then begin
            VisbleActors();
          end else begin
            if AttackTarget then begin
              inherited;
              Exit;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TStickMonster.Run');
  end;
  inherited;
end;



{ TSoccerBall }

constructor TSoccerBall.Create; //004A764C
begin
  inherited;
  m_boAnimal := False;
  m_boSuperMan := True;
  n550 := 0;
  m_nTargetX := -1;
end;

destructor TSoccerBall.Destroy;
begin

  inherited;
end;



procedure TSoccerBall.Run;
var
  n08, n0C: Integer;
  bo0D: Boolean;
begin
  try
    if n550 > 0 then begin
      if m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, 1, n08, n0C) then begin
        if m_PEnvir.CanWalk(n08, n0C, bo0D) then begin
          case m_btDirection of //
            0: m_btDirection := 4;
            1: m_btDirection := 7;
            2: m_btDirection := 6;
            3: m_btDirection := 5;
            4: m_btDirection := 0;
            5: m_btDirection := 3;
            6: m_btDirection := 2;
            7: m_btDirection := 1;
          end; // case
          m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, n550, m_nTargetX, m_nTargetY)
        end;
      end;
    end else begin //004A78A1
      m_nTargetX := -1;
    end;
    if m_nTargetX <> -1 then begin
      GotoTargetXY();
      if (m_nTargetX = m_nCurrX) and (m_nTargetY = m_nCurrY) then n550 := 0;
    end;
  except
    MainOutMessage('{�쳣} TSoccerBall.Run');
  end;
  inherited;
end;

procedure TSoccerBall.Struck(hiter: TBaseObject);
begin
  if hiter = nil then Exit;
  m_btDirection := hiter.m_btDirection;
  n550 := Random(4) + (n550 + 4);
  n550 := _MIN(20, n550);
  m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, n550, m_nTargetX, m_nTargetY);
end;

{ TBeeQueen }

constructor TBeeQueen.Create; //004A5750
begin
  inherited;
  m_nViewRange := 9;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := GetTickCount();
  m_boStickMode := True;
  BBList := TList.Create;
end;

destructor TBeeQueen.Destroy; //004A57F0
begin
  BBList.Free;
  inherited;
end;

procedure TBeeQueen.MakeChildBee;
begin
  if BBList.Count >= 15 then Exit;
  SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  SendDelayMsg(Self, RM_ZEN_BEE, 0, 0, 0, 0, '', 500);
end;

function TBeeQueen.Operate(ProcessMsg: pTProcessMessage): Boolean;
var
  BB: TBaseObject;
begin
  if ProcessMsg.wIdent = RM_ZEN_BEE then begin
    BB := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, m_nCurrX, m_nCurrY, g_Config.sBee);
    if BB <> nil then begin
      BB.SetTargetCreat(m_TargetCret);
      BBList.Add(BB);
    end;
  end;
  Result := inherited Operate(ProcessMsg);
end;

procedure TBeeQueen.Run;
var
  I: Integer;
  BB: TBaseObject;
begin
  try
    if not m_boGhost and
      not m_boDeath and
      (m_wStatusTimeArr[POISON_STONE {5}] = 0) then begin
      if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
        m_dwWalkTick := GetTickCount();
        if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
          m_dwHitTick := GetTickCount();
          SearchTarget();
          if m_TargetCret <> nil then MakeChildBee();
        end;
        for I := BBList.Count - 1 downto 0 do begin
          if BBList.Count <= 0 then Break;//20080917
          BB := TBaseObject(BBList.Items[I]);
          if (BB <> nil) then begin
            if (BB.m_boDeath) or (BB.m_boGhost) then BBList.Delete(I);
          end;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TBeeQueen.Run');
  end;
  inherited;
end;

{ TCentipedeKingMonster }



constructor TCentipedeKingMonster.Create; //004A5A8C
begin
  inherited;
  m_nViewRange := 6;
  n554 := 4;
  n558 := 6;
  m_boAnimal := False;
  m_dwAttickTick := GetTickCount();
end;

destructor TCentipedeKingMonster.Destroy;
begin
  inherited;
end;

function TCentipedeKingMonster.sub_4A5B0C: Boolean;
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;
  if m_VisibleActors.Count > 0 then begin//20080629
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject = nil then Continue;
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

function TCentipedeKingMonster.AttackTarget: Boolean; //004A5BC0
var
  WAbil: pTAbility;
  nPower, I: Integer;
  BaseObject: TBaseObject;
begin
  Result := False;
  if not sub_4A5B0C then begin
    Exit;
  end;
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    m_dwHitTick := GetTickCount();
    SendAttackMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY);
    WAbil := @m_WAbil;
    nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if m_VisibleActors.Count > 0 then begin//20080629
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then Continue;
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if (abs(m_nCurrX - BaseObject.m_nCurrX) < m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) < m_nViewRange) then begin
            m_dwTargetFocusTick := GetTickCount();
            SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 600);
            if Random(4) = 0 then begin
              if Random(3) <> 0 then begin
                BaseObject.MakePosion(POISON_DECHEALTH, 60, 3);
              end else begin
                BaseObject.MakePosion(POISON_STONE, 5, 0);
              end;
              m_TargetCret := BaseObject;
            end;
          end;
        end;
      end; // for
    end;
  end;
  Result := True;
end;

procedure TCentipedeKingMonster.sub_FFE9;
begin
  inherited;
  m_WAbil.HP := m_WAbil.MaxHP;
end;

procedure TCentipedeKingMonster.Run;
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  try
    if not m_boGhost and
      not m_boDeath and
      (m_wStatusTimeArr[POISON_STONE {5}] = 0) then begin
      if Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed then begin
        m_dwWalkTick := GetTickCount();
        if m_boFixedHideMode then begin
          if (GetTickCount - m_dwAttickTick) > 10000 then begin
            if m_VisibleActors.Count > 0 then //20080629
            for I := 0 to m_VisibleActors.Count - 1 do begin
              BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
              if BaseObject = nil then Continue;
              if BaseObject.m_boDeath then Continue;
              if IsProperTarget(BaseObject) then begin
                if not BaseObject.m_boHideMode or m_boCoolEye then begin
                  if (abs(m_nCurrX - BaseObject.m_nCurrX) < n554) and (abs(m_nCurrY - BaseObject.m_nCurrY) < n554) then begin
                    sub_FFE9();
                    m_dwAttickTick := GetTickCount();
                    Break;
                  end;
                end;
              end;
            end;
          end; //004A5F86
        end else begin
          if (GetTickCount - m_dwAttickTick) > 3000 then begin
            if AttackTarget() then begin
              inherited;
              Exit;
            end;
            if (GetTickCount - m_dwAttickTick) > 10000 then begin
              VisbleActors();
              m_dwAttickTick := GetTickCount();
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TCentipedeKingMonster.Run');
  end;
  inherited;
end;


{ TBigHeartMonster }


constructor TBigHeartMonster.Create;
begin
  inherited;
  m_nViewRange := 16;
  m_boAnimal := False;
end;

destructor TBigHeartMonster.Destroy;
begin
  inherited;
end;

function TBigHeartMonster.AttackTarget(): Boolean;
var
  I: Integer;
  BaseObject: TBaseObject;
  nPower: Integer;
  WAbil: pTAbility;
begin
  Result := False;
  if {Integer}(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin//20080815 �޸�
    m_dwHitTick := GetTickCount();
    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    WAbil := @m_WAbil;
    nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if m_VisibleActors.Count > 0 then begin//20080629
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject = nil then Continue;
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then begin
            SendDelayMsg(Self, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 1, Integer(BaseObject), '', 200);
            SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 1 {type}, '');
          end;
        end;
      end; // for
    end;
    Result := True;
  end;
  //  inherited;
end;

procedure TBigHeartMonster.Run; //004A617C
begin
  try
    if not m_boGhost and not m_boDeath and (m_wStatusTimeArr[POISON_STONE{5}] = 0) then begin
      if m_VisibleActors <> nil then begin
        if m_VisibleActors.Count > 0 then AttackTarget();
      end;
    end;
    inherited;
  except
    MainOutMessage('{�쳣} TBigHeartMonster.Run');
  end;
end;

{ TSpiderHouseMonster }

constructor TSpiderHouseMonster.Create; //004A61D0
begin
  inherited;
  m_nViewRange := 9;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := 0;
  m_boStickMode := True;
  BBList := TList.Create;
end;

destructor TSpiderHouseMonster.Destroy;
begin
  BBList.Free;
  inherited;
end;

procedure TSpiderHouseMonster.GenBB;
begin
  if BBList.Count < 15 then begin
    SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    SendDelayMsg(Self, RM_ZEN_BEE, 0, 0, 0, 0, '', 500);
  end;
end;

function TSpiderHouseMonster.Operate(ProcessMsg: pTProcessMessage): Boolean;
var
  BB: TBaseObject;
  n08, n0C: Integer;
begin
  if ProcessMsg.wIdent = RM_ZEN_BEE then begin
    n08 := m_nCurrX;
    n0C := m_nCurrY + 1;
    if m_PEnvir.CanWalk(n08, n0C, True) then begin
      BB := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, n08, n0C, g_Config.sSpider);
      if BB <> nil then begin
        BB.SetTargetCreat(m_TargetCret);
        BBList.Add(BB);
      end;
    end;
  end;
  Result := inherited Operate(ProcessMsg);
end;

procedure TSpiderHouseMonster.Run;
var
  I: Integer;
  BB: TBaseObject;
begin
  try
    if not m_boGhost and not m_boDeath and (m_wStatusTimeArr[POISON_STONE {5}] = 0) then begin
      if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
        m_dwWalkTick := GetTickCount();
        if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
          m_dwHitTick := GetTickCount();
          SearchTarget();
          if m_TargetCret <> nil then GenBB();
        end;
        for I := BBList.Count - 1 downto 0 do begin
          if BBList.Count <= 0 then Break;
          BB := TBaseObject(BBList.Items[I]);
          if BB <> nil then begin
            if BB.m_boDeath or (BB.m_boGhost) then BBList.Delete(I);
          end;
        end; // for
      end;
    end;
  except
    MainOutMessage('{�쳣} TSpiderHouseMonster.Run');
  end;
  inherited;
end;

{ TExplosionSpider }

constructor TExplosionSpider.Create;
//004A6538
begin
  inherited;
  m_nViewRange := 5;
  m_nRunTime := 250;
  m_dwSearchTime := Random(1500) + 2500;
  m_dwSearchTick := 0;
  dw558 := GetTickCount();
end;

destructor TExplosionSpider.Destroy;
begin

  inherited;
end;
procedure TExplosionSpider.sub_4A65C4;
var
  WAbil: pTAbility;
  I, nPower, n10: Integer;
  BaseObject: TBaseObject;
begin
  m_WAbil.HP := 0;
  WAbil := @m_WAbil;
  nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
  if m_VisibleActors.Count > 0 then begin//20080629
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject = nil then Continue;
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 1) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 1) then begin
          n10 := 0;
          Inc(n10, BaseObject.GetHitStruckDamage(Self, nPower div 2));
          Inc(n10, BaseObject.GetMagStruckDamage(Self, nPower div 2));
          if n10 > 0 then begin
            BaseObject.StruckDamage(n10);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, n10, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '', 700);
            //BaseObject.SendMsg(TBaseObject(RM_STRUCK), RM_10101, n10, BaseObject.m_WAbil.HP, BaseObject.m_WAbil.MaxHP, Integer(Self), '');
          end;
        end;
      end;
    end; // for
  end;
end;
function TExplosionSpider.AttackTarget: Boolean;
var
  btDir: Byte;
begin
  Result := False;
  if m_TargetCret = nil then Exit;
  if GetAttackDir(m_TargetCret, btDir) then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      sub_4A65C4();
    end;
    Result := True;
  end else begin
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 11) then begin //20080605 ����
         SetTargetXY(m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      end;
    end else begin
      DelTargetCreat(); {0FFF1h}
    end;
  end;
end;

procedure TExplosionSpider.Run;
begin
  try
    if not m_boDeath and not m_boGhost then
      if (GetTickCount - dw558) > 60000{60 * 1000} then begin
        dw558 := GetTickCount();
        sub_4A65C4();
      end;
  except
    MainOutMessage('{�쳣} TExplosionSpider.Run');
  end;
  inherited;
end;

{ TGuardUnit }
procedure TGuardUnit.Struck(hiter: TBaseObject);
begin
  inherited;
  if m_Castle <> nil then begin
    bo2B0 := True;
    m_dw2B4Tick := GetTickCount();
  end;
end;
//���ʵ���Ŀ��
function TGuardUnit.IsProperTarget(BaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if m_Castle <> nil then begin
    if m_LastHiter = BaseObject then Result := True;
    if (BaseObject <> nil) and (BaseObject.bo2B0) then begin
      if (GetTickCount - BaseObject.m_dw2B4Tick) < 120000{2 * 60 * 1000} then begin
        Result := True;
      end else BaseObject.bo2B0 := False;
      if BaseObject.m_Castle <> nil then begin
        BaseObject.bo2B0 := False;
        Result := False;
      end;
    end;
    if TUserCastle(m_Castle).m_boUnderWar then Result := True;
    if TUserCastle(m_Castle).m_MasterGuild <> nil then begin
      if BaseObject.m_Master = nil then begin
        if (TUserCastle(m_Castle).m_MasterGuild = BaseObject.m_MyGuild) or
          (TUserCastle(m_Castle).m_MasterGuild.IsAllyGuild(TGUild(BaseObject.m_MyGuild))) then begin
          if m_LastHiter <> BaseObject then Result := False;
        end;
      end else begin //004A6988
        if (TUserCastle(m_Castle).m_MasterGuild = BaseObject.m_Master.m_MyGuild) or
          (TUserCastle(m_Castle).m_MasterGuild.IsAllyGuild(TGUild(BaseObject.m_Master.m_MyGuild))) then begin
          if (m_LastHiter <> BaseObject.m_Master) and (m_LastHiter <> BaseObject) then Result := False;
        end;
      end;
    end; //004A69EF
    if (BaseObject <> nil) and
      BaseObject.m_boAdminMode or
      BaseObject.m_boStoneMode or
      ((BaseObject.m_btRaceServer >= 10) and
      (BaseObject.m_btRaceServer < 50)) or
      (BaseObject = Self) or (BaseObject.m_Castle = Self.m_Castle) then begin
      Result := False;
    end;
    Exit;
  end; //004A6A41
  if m_LastHiter = BaseObject then Result := True;
  if (BaseObject.m_TargetCret <> nil) and (BaseObject.m_TargetCret.m_btRaceServer = 112) then
    Result := True;
  if (BaseObject <> nil) and (BaseObject.PKLevel >= 2) then Result := True;//��������
  if (BaseObject <> nil) and BaseObject.m_boAdminMode or
    BaseObject.m_boStoneMode or
    (BaseObject = Self) then Result := False;
end;

{ TArcherGuard ������}

constructor TArcherGuard.Create; //004A6AB4
begin
  inherited;
  m_nViewRange := 12; //���ӷ�Χ
  m_boWantRefMsg := True;
  m_Castle := nil;//�Ǳ�
  m_nDirection := -1; //����
  m_btRaceServer := 112;//������
end;

destructor TArcherGuard.Destroy;
begin

  inherited;
end;
//������NPC
procedure TArcherGuard.sub_4A6B30(TargeTBaseObject: TBaseObject); //004A6B30
var
  nPower: Integer;
  WAbil: pTAbility;
begin
  if TargeTBaseObject <> nil then begin
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
    WAbil := @m_WAbil;
    nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if nPower > 0 then
      nPower := TargeTBaseObject.GetHitStruckDamage(Self, nPower);
    if nPower > 0 then begin
      TargeTBaseObject.SetLastHiter(Self);
      TargeTBaseObject.m_ExpHitter := nil;
      TargeTBaseObject.StruckDamage(nPower);
      TargeTBaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP, Integer(Self), '',
        _MAX(abs(m_nCurrX - TargeTBaseObject.m_nCurrX), abs(m_nCurrY - TargeTBaseObject.m_nCurrY)) * 50 + 600);
    end;
    SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(TargeTBaseObject), '');
  end;
end;

procedure TArcherGuard.Run;
var
  I: Integer;
  nAbs: Integer;
  nRage: Integer;
  BaseObject: TBaseObject;
  TargeTBaseObject: TBaseObject;
begin
  try
   //nRage := 9999;
    nRage := 13;//�����ֵķ�Χ 20080623
    TargeTBaseObject := nil;
    if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
      if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
        m_dwWalkTick := GetTickCount();
        if m_VisibleActors.Count > 0 then begin//20080629
          for I := 0 to m_VisibleActors.Count - 1 do begin
            BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
            if BaseObject = nil then Continue;
            if BaseObject.m_boDeath then Continue;
            if IsProperTarget(BaseObject) then begin
              nAbs := abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
              if nAbs < nRage then begin
                nRage := nAbs;
                TargeTBaseObject := BaseObject;
              end;
            end;
          end;//for
        end;
        if TargeTBaseObject <> nil then begin
          SetTargetCreat(TargeTBaseObject);
        end else begin
          DelTargetCreat();
        end;
      end;
      if m_TargetCret <> nil then begin
        if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
          m_dwHitTick := GetTickCount();
          sub_4A6B30(m_TargetCret);
        end;
      end else begin
        if (m_nDirection >= 0) and (m_btDirection <> m_nDirection) then begin
          TurnTo(m_nDirection);
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TArcherGuard.Run');
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{ TArcherGuardMon ���ƹ����ֵĹ�,ֻ����� 20080121}

constructor TArcherGuardMon.Create; //004A6AB4
begin
  inherited;
//  m_nViewRange := 12; //���ӷ�Χ
  m_boWantRefMsg := True;
  m_Castle := nil;//�Ǳ�
  m_nDirection := -1; //����
  m_btRaceServer := 135;//������
  m_dwSearchTime := Random(1500) + 1500;//����Ŀ���ʱ��
end;

destructor TArcherGuardMon.Destroy;
begin

  inherited;
end;

procedure TArcherGuardMon.sub_4A6B30(TargeTBaseObject: TBaseObject); //004A6B30
var
  nPower: Integer;
  WAbil: pTAbility;
  spell:Boolean;
begin
  if TargeTBaseObject <> nil then begin
  spell:=False;
  case TargeTBaseObject.m_btRaceServer of
    11..65,67..99: spell:=True;
    101..107,110..111: spell:=True;
    115..120,136,150: spell:=True;
  end;
  if spell then begin
    m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
    WAbil := @m_WAbil;
    nPower := (Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    if nPower > 0 then nPower := TargeTBaseObject.GetHitStruckDamage(Self, nPower);
    if nPower > 0 then begin
      TargeTBaseObject.SetLastHiter(Self);
      TargeTBaseObject.m_ExpHitter := nil;
      TargeTBaseObject.StruckDamage(nPower);
      TargeTBaseObject.SendDelayMsg(TBaseObject(RM_STRUCK), RM_10101, nPower, TargeTBaseObject.m_WAbil.HP, TargeTBaseObject.m_WAbil.MaxHP, Integer(Self), '',
        _MAX(abs(m_nCurrX - TargeTBaseObject.m_nCurrX), abs(m_nCurrY - TargeTBaseObject.m_nCurrY)) * 50 + 600);
    end;
    SendRefMsg(RM_FLYAXE, m_btDirection, m_nCurrX, m_nCurrY, Integer(TargeTBaseObject), '');
   end;
  end;
end;

procedure TArcherGuardMon.Run;
var
  I: Integer;
  BaseObject: TBaseObject;
  TargeTBaseObject: TBaseObject;
  spell:Boolean;
begin
  try
    spell:=False;
    TargeTBaseObject := nil;
    if (m_Master=nil) or (CompareText(m_Master.m_sMapName,m_sMapName)<>0) then m_boDeath:=True; //���˲����ڻ������˲���ͬһ��ͼ���Զ���ʧ

    if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
      if Integer(GetTickCount - m_dwWalkTick) >= m_nWalkSpeed then begin
        m_dwWalkTick := GetTickCount();
        if m_TargetCret = nil then begin
          if m_VisibleActors.Count > 0 then begin//20080629
            for I := 0 to m_VisibleActors.Count - 1 do begin
              BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
              if BaseObject = nil then Continue;
              if BaseObject.m_boDeath then Continue;
                case BaseObject.m_btRaceServer of
                  11..65,67..99: spell:=True;
                  101..107,110..111: spell:=True;
                  115..120,136,150: spell:=True;
                end;
              if spell then begin
                //�ڿ��ӷ�Χ,�򹥻�����Ŀ��
                if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_btCoolEye{�ֵĿ��ӷ�Χ}) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_btCoolEye) then begin
                  TargeTBaseObject := BaseObject;//����Ϊ����Ŀ��
                  SetTargetCreat(TargeTBaseObject);//20080623
                  if m_TargetCret <> nil then Break;//20080623
                end;
              end;
            end;//for
          end;
        end;
        if TargeTBaseObject <> nil then begin
          SetTargetCreat(TargeTBaseObject);
        end else begin
          DelTargetCreat();
        end;
      end;
      if m_TargetCret <> nil then begin
        if Integer(GetTickCount - m_dwHitTick) >= m_nNextHitTime then begin
          m_dwHitTick := GetTickCount();
          sub_4A6B30(m_TargetCret);
        end;
      end else begin
        if (m_nDirection >= 0) and (m_btDirection <> m_nDirection) then begin
          TurnTo(m_nDirection);
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TArcherGuardMon.Run');
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{ TArcherGuardMon1 136��,�����ƶ�,���ṥ�� 20080122}
constructor TArcherGuardMon1.Create; 
begin
  inherited;
  m_Castle := nil;//�Ǳ�
  m_btRaceServer := 136;//������
  m_boWalk:=False;
end;

destructor TArcherGuardMon1.Destroy;
begin
  inherited;
end;

function TArcherGuardMon1.WalkToTargetXY(nTargetX, nTargetY: Integer): Boolean;
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
   { nDir := DR_DOWN; //20081018 ע��
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
    end;   }
    nOldX := m_nCurrX;
    nOldY := m_nCurrY;
    
    nDir:= GetNextDirection(m_nCurrX , m_nCurrY, n10, n14);//20081018 ����
    WalkTo(nDir, False);
    if (nTargetX = m_nCurrX) and (nTargetY = m_nCurrY) then Result := True;
    if not Result then begin
      n20 := Random(3);
      for I := DR_UP to DR_UPLEFT do begin
        if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
         { if n20 <> 0 then Inc(nDir)           //20080304 �޸�
          else if nDir > 0 then Dec(nDir)
          else nDir := DR_UPLEFT;
          if (nDir > DR_UPLEFT) then nDir := DR_UP; }

          if n20 <> 0 then Inc(nDir);//20080304 �޸�
          if (nDir > DR_UPLEFT) then nDir := DR_UP;//20080304 �޸�

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

procedure TArcherGuardMon1.Run;
begin
  try
    if not m_boDeath and not m_boGhost and (m_wStatusTimeArr[POISON_STONE] = 0) then begin
      if (Integer(GetTickCount - m_dwWalkTick) > m_nWalkSpeed) and m_boWalk then begin//�߶�
        m_dwWalkTick := GetTickCount();
        if WalkToTargetXY( m_NewCurrX, m_NewCurrY) then begin
          //m_boDeath:= True; //����ָ����XY��,�Զ���ʧ
          MakeGhost();//20081018 ��ָ��XY��,ֱ���������
        end;
      end;
      //if Random(m_btCoolEye) <> 0 then m_boNoDropItem:=False;
    end;
  except
    MainOutMessage('{�쳣} TArcherGuardMon1.Run');
  end;
  inherited;
end;
//------------------------------------------------------------------------------
{ TArcherPolice }

constructor TArcherPolice.Create; //004A6E14
begin
  inherited;
  m_btRaceServer := 20;
end;

destructor TArcherPolice.Destroy;
begin

  inherited;
end;


{ TCastleDoor }

constructor TCastleDoor.Create; //004A6E60
begin
  inherited;
  m_boAnimal := False;
  m_boStickMode := True;
  m_boOpened := False;
  m_btAntiPoison := 200;
end;

destructor TCastleDoor.Destroy;
begin

  inherited;
end;
procedure TCastleDoor.SetMapXYFlag(nFlag: Integer); //004A6FB4
var
  bo06: Boolean;
begin
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 2, True);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 1, True);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 2, True);
  if nFlag = 1 then bo06 := False
  else bo06 := True;
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 1, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 2, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 1, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 2, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1, m_nCurrY, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 2, m_nCurrY, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1, m_nCurrY - 1, bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1, m_nCurrY + 1, bo06);
  if nFlag = 0 then begin
    m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY - 2, False);
    m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 1, False);
    m_PEnvir.SetMapXYFlag(m_nCurrX + 1, m_nCurrY - 2, False);
  end;
end;

procedure TCastleDoor.Open;
begin
  if m_boDeath then Exit;
  m_btDirection := 7;
  SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boOpened := True;
  m_boStoneMode := True;
  SetMapXYFlag(0);
  bo2B9 := False;
end;

procedure TCastleDoor.Close;
begin
  if m_boDeath then Exit;
  m_btDirection := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  if (m_btDirection - 3) >= 0 then m_btDirection := 0;
  SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  m_boOpened := False;
  m_boStoneMode := False;
  SetMapXYFlag(1);
  bo2B9 := True;
end;

procedure TCastleDoor.Die;
begin
  inherited;
  dw560 := GetTickCount();
  SetMapXYFlag(2);
end;

procedure TCastleDoor.Run;
var
  n08: Integer;
begin
  try
    if m_boDeath and (m_Castle <> nil) then
      m_dwDeathTick := GetTickCount()
    else m_nHealthTick := 0;
    if not m_boOpened then begin
      n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
      if (m_btDirection <> n08) and (n08 < 3) then begin
        m_btDirection := n08;
        SendRefMsg(RM_TURN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
      end;
    end;
  except
    MainOutMessage('{�쳣} TCastleDoor.Run');
  end;
  inherited;
end;

procedure TCastleDoor.RefStatus; //004A6F24
var
  n08: Integer;
begin
  n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  if (n08 - 3) >= 0 then n08 := 0;
  m_btDirection := n08;
  SendRefMsg(RM_ALIVE, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TCastleDoor.Initialize; //0x004A6ECC
begin
  //  m_btDirection:=0;
  inherited;
  {
  if m_WAbil.HP > 0 then begin
    if m_boOpened then begin
      SetMapXYFlag(0);
      exit;
    end;
    SetMapXYFlag(1);
    exit;
  end;
  SetMapXYFlag(2);
  }
end;

{ TWallStructure ��ǽ��Ĺ�(������ǽ)}

constructor TWallStructure.Create;
begin
  inherited;
  m_boAnimal := False;
  m_boStickMode := True;//���ܳ�ײģʽ(�����˲���ʹ��Ұ����ײ���ܹ���)
  boSetMapFlaged := False;
  m_btAntiPoison := 200;//�ж����
end;

destructor TWallStructure.Destroy;
begin
  inherited;
end;

procedure TWallStructure.Initialize;
begin
  m_btDirection := 0;
  inherited;
end;

procedure TWallStructure.RefStatus;
var
  n08: Integer;
begin
  if m_WAbil.HP > 0 then begin
    n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
  end else begin
    n08 := 4;
  end;
  if n08 >= 5 then n08 := 0;
  m_btDirection := n08;
  SendRefMsg(RM_ALIVE, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TWallStructure.Die;
begin
  inherited;
  dw560 := GetTickCount();
end;

procedure TWallStructure.Run;
var
  n08: Integer;
begin
  try
    if m_boDeath then begin
      m_dwDeathTick := GetTickCount();
      if boSetMapFlaged then begin
        m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY, True);
        boSetMapFlaged := False;
      end;
    end else begin
      m_nHealthTick := 0;
      if not boSetMapFlaged then begin
        m_PEnvir.SetMapXYFlag(m_nCurrX, m_nCurrY, False);
        boSetMapFlaged := True;
      end;
    end;
    if m_WAbil.HP > 0 then begin
      n08 := 3 - Round(m_WAbil.HP / m_WAbil.MaxHP * 3.0);
    end else begin
      n08 := 4;
    end;
    if (m_btDirection <> n08) and (n08 < 5) then begin
      m_btDirection := n08;
      SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;
  except
    MainOutMessage('{�쳣} TWallStructure.Run');
  end;
  inherited;
end;

end.


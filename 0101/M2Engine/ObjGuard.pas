unit ObjGuard;

interface
uses
  Windows, Classes, Grobal2, ObjNpc;
type
  TSuperGuard = class(TNormNpc)//����ʿ
  public
    constructor Create(); override;
    destructor Destroy; override;
    function AttackTarget(): Boolean;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
  end;
implementation

uses ObjBase, M2Share;

{ TSuperGuard ����ʿ}

function TSuperGuard.AttackTarget(): Boolean;
var
  nOldX, nOldY: Integer;
  btOldDir: Byte;
  wHitMode: Word;
begin
  Result := False;
  if m_TargetCret.m_PEnvir = m_PEnvir then begin
    if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
      m_dwHitTick := GetTickCount();
      m_dwTargetFocusTick := GetTickCount();
      nOldX := m_nCurrX;
      nOldY := m_nCurrY;
      btOldDir := m_btDirection;
      m_TargetCret.GetBackPosition(m_nCurrX, m_nCurrY);
      m_btDirection := GetNextDirection(m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
      wHitMode := 0;
      _Attack(wHitMode, m_TargetCret);
      m_TargetCret.SetLastHiter(Self);
      m_TargetCret.m_ExpHitter := nil;
      m_nCurrX := nOldX;
      m_nCurrY := nOldY;
      m_btDirection := btOldDir;
      TurnTo(m_btDirection);
      BreakHolySeizeMode();
    end;
    Result := True;
  end else begin
    DelTargetCreat();
  end;
end;

constructor TSuperGuard.Create;
begin
  inherited;
  m_btRaceServer := 11;
  m_nViewRange := 7;
  m_nLight := 4;
end;

destructor TSuperGuard.Destroy;
begin
  inherited;
end;

function TSuperGuard.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TSuperGuard.Run;
var
  I: Integer;
  BaseObject: TBaseObject;
begin
  if m_Master <> nil then m_Master := nil; //�������ٻ�Ϊ����
  if Integer(GetTickCount - m_dwHitTick) > m_nNextHitTime then begin
    if m_VisibleActors.Count > 0 then begin//20080629
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject := TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if (BaseObject = nil) or (BaseObject.m_boDeath) then Continue;
        if (BaseObject.m_nCopyHumanLevel = 2) and (not g_Config.boAllowGuardAttack) or (BaseObject.m_nCopyHumanLevel = 3) then Continue; {����������}
        if (BaseObject.m_btRaceServer = 112) {and BaseObject.InSafeZone} then Continue;//�󵶲�����ȫ���ڹ����� 20081208 
        if (BaseObject.PKLevel >= 2) or ((BaseObject.m_btRaceServer >= RC_MONSTER) and (not BaseObject.m_boMission)) then begin
          SetTargetCreat(BaseObject);
          Break;
        end;
      end;//for
    end;
  end;
  if m_TargetCret <> nil then AttackTarget();
  inherited;
end;

end.

unit Event;

interface

uses
  Windows, Classes, ObjBase, Envir, Grobal2, SDK, SysUtils{IntToStr()需引用 20081129};
type
 { TEvent = class;//20080903 注释

  pTMagicEvent = ^TMagicEvent;//此结构在M2Share.pas中已声明
  TMagicEvent = record
    BaseObjectList: TList;
    dwStartTick: DWord;
    dwTime: DWord;
    Events: array[0..7] of TEvent;
  end;}

  TEvent = class
    nVisibleFlag: Integer;
    m_Envir: TEnvirnoment;//所在地图场景
    m_nX: Integer;//X坐标
    m_nY: Integer;//Y坐标
    m_nEventType: Integer;//类型
    m_nEventParam: Integer;
    m_dwOpenStartTick: LongWord;
    m_dwContinueTime: LongWord;//显示时间长度
    m_dwCloseTick: LongWord;//关闭间隔
    m_boClosed: Boolean;//是否关闭
    m_nDamage: Integer;//火墙威力
    m_OwnBaseObject: TBaseObject;
    m_dwRunStart: LongWord;//启动时间
    m_dwRunTick: LongWord;//运行间隔
    m_boVisible: Boolean;//是否可见
    m_boActive: Boolean;
  public
    constructor Create(tEnvir: TEnvirnoment; nTX, nTY, nType, dwETime: Integer; boVisible: Boolean);
    destructor Destroy; override;
    procedure Run(); virtual;
    procedure Close();
  end;
  TStoneMineEvent = class(TEvent)
    m_nMineCount: Integer;
    m_nAddStoneCount: Integer;
    m_dwAddStoneMineTick: LongWord;
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
    destructor Destroy; override;
    procedure AddStoneMine();
  end;
  TPileStones = class(TEvent)
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
    destructor Destroy; override;
    procedure AddEventParam();
  end;
  THolyCurtainEvent = class(TEvent)
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
    destructor Destroy; override;
  end;
  TFireBurnEvent = class(TEvent)//火墙
    m_dwRunTick: LongWord;
    m_nType:Byte;//20080925
    nTwoPwr:Integer;//20081222 内功技能之前的威力值
    boReadSkill: Boolean;//20081223 学习过内功技能
  public
    constructor Create(Creat: TBaseObject; nX, nY: Integer; nType: Integer; nTime, nDamage: Integer);
    destructor Destroy; override;
    procedure Run(); override;
  end;
  TSafeEvent = class(TEvent) //安全区光环
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
    destructor Destroy; override;
    procedure Run(); override;
  end;

  TFlowerEvent = class(TEvent) //烟花
  public
    constructor Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
    destructor Destroy; override;
    procedure Run(); override;
  end;
  //==============================================================================
  TEventManager = class
    m_EventList: TGList;
    m_ClosedEventList: TGList;
  public
    constructor Create();
    destructor Destroy; override;
    function GetEvent(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer): TEvent;
    function GetRangeEvent(Envir: TEnvirnoment; OwnBaseObject: TBaseObject; nX, nY, nRange: Integer; nType: Integer): Integer;
    procedure AddEvent(Event: TEvent);
    function FindEvent(Envir: TEnvirnoment; Event: TEvent): TEvent;
    procedure Run();
  end;
implementation

uses M2Share, ObjHero;

{ TStoneMineEvent }

constructor TStoneMineEvent.Create(Envir: TEnvirnoment; nX, nY, nType: Integer);
begin
  inherited Create(Envir, nX, nY, nType, 0, False);
  m_Envir.AddToMapMineEvent(nX, nY, OS_EVENTOBJECT, Self);
  m_boVisible := False;
  m_nMineCount := Random(200);
  m_dwAddStoneMineTick := GetTickCount();
  m_boActive := False;
  m_nAddStoneCount := Random(80);
end;

destructor TStoneMineEvent.Destroy;
begin

  inherited;
end;
{ TEventManager }
procedure TEventManager.Run;
var
  I: Integer;
  Event: TEvent;
  nCode: Byte;//20081129
begin
  nCode:= 0;
  Try
    m_EventList.Lock;
    try
      nCode:= 1;
      for I := m_EventList.Count - 1 downto 0 do begin
        if m_EventList.Count <= 0 then Break;//20080917
        nCode:= 2;
        Event := TEvent(m_EventList.Items[I]);
        nCode:= 3;
        if Event <> nil then begin//20081129
          if Event.m_boActive and ((GetTickCount - Event.m_dwRunStart) > Event.m_dwRunTick) then begin
            Event.m_dwRunStart := GetTickCount();
            nCode:= 4;
            Event.Run();
            if Event.m_boClosed then begin
              m_ClosedEventList.Lock;
              try
                nCode:= 5;
                m_ClosedEventList.Add(Event);
              finally
                m_ClosedEventList.UnLock;
              end;
              nCode:= 6;
              m_EventList.Delete(I);
            end;
          end;
        end;
      end;//for
    finally
      m_EventList.UnLock;
    end;

    nCode:= 7;
    m_ClosedEventList.Lock;
    try
      nCode:= 8;
      for I := m_ClosedEventList.Count - 1 downto 0 do begin
        if m_ClosedEventList.Count <= 0 then Break;//20080917
        nCode:= 9;
        Event := TEvent(m_ClosedEventList.Items[I]);
        nCode:= 10;
        if Event <> nil then begin//20081129
          if (GetTickCount - Event.m_dwCloseTick) > 300000{5 * 60 * 1000} then begin
            m_ClosedEventList.Delete(I);
            nCode:= 13;
            if Event <> nil then Event.Free;//20090129 修改
            nCode:= 12;
          end;
        end;
      end;
    finally
      m_ClosedEventList.UnLock;
    end;
  except
    MainOutMessage('{异常} TEventManager.Run Code:'+IntToStr(nCode));
  end;
end;

function TEventManager.GetRangeEvent(Envir: TEnvirnoment; OwnBaseObject: TBaseObject;
  nX, nY, nRange: Integer; nType: Integer): Integer;
var
  I: Integer;
  Event: TEvent;
begin
  Result := 0;
  m_EventList.Lock;
  try
    if m_EventList.Count > 0 then begin//20080630
      for I := 0 to m_EventList.Count - 1 do begin
        Event := TEvent(m_EventList.Items[I]);
        if (Event.m_OwnBaseObject = OwnBaseObject) and
          (abs(Event.m_nX - nX) <= nRange) and
          (abs(Event.m_nY - nY) <= nRange) and
          (Event.m_nEventType = nType) then begin
          Inc(Result);
        end;
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;

function TEventManager.GetEvent(Envir: TEnvirnoment; nX, nY,
  nType: Integer): TEvent;
var
  I: Integer;
  Event: TEvent;
begin
  Result := nil;
  m_EventList.Lock;
  try
    if m_EventList.Count > 0 then begin//20080630
      for I := 0 to m_EventList.Count - 1 do begin
        Event := TEvent(m_EventList.Items[I]);
        if (Event.m_Envir = Envir) and
          (Event.m_nX = nX) and
          (Event.m_nY = nY) and
          (Event.m_nEventType = nType) then begin
          Result := Event;
          Break;
        end;
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;

function TEventManager.FindEvent(Envir: TEnvirnoment; Event: TEvent): TEvent;
var
  I: Integer;
begin
  Result := nil;
  m_EventList.Lock;
  try
    if m_EventList.Count > 0 then begin//20080630
      for I := 0 to m_EventList.Count - 1 do begin
        if (TEvent(m_EventList.Items[I]).m_Envir = Envir) and (TEvent(m_EventList.Items[I]) = Event) then begin
          Result := TEvent(m_EventList.Items[I]);
          Break;
        end;
      end;
    end;
  finally
    m_EventList.UnLock;
  end;
end;

procedure TEventManager.AddEvent(Event: TEvent);
begin
  m_EventList.Lock;
  try
    m_EventList.Add(Event);
  finally
    m_EventList.UnLock;
  end;
end;

constructor TEventManager.Create();
begin
  m_EventList := TGList.Create;
  m_ClosedEventList := TGList.Create;
end;

destructor TEventManager.Destroy;
var
  I: Integer;
begin
  if m_EventList.Count > 0 then begin//20080630
    for I := 0 to m_EventList.Count - 1 do begin
      TEvent(m_EventList.Items[I]).Free;
    end;
  end;
  m_EventList.Free;
  if m_ClosedEventList.Count > 0 then begin//20080630
    for I := 0 to m_ClosedEventList.Count - 1 do begin
      TEvent(m_ClosedEventList.Items[I]).Free;
    end;
  end;
  m_ClosedEventList.Free;
  inherited;
end;

{ THolyCurtainEvent }

constructor THolyCurtainEvent.Create(Envir: TEnvirnoment; nX, nY, nType, nTime: Integer);
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
end;

destructor THolyCurtainEvent.Destroy;
begin

  inherited;
end;
{ TSafeEvent 安全区光环}

constructor TSafeEvent.Create(Envir: TEnvirnoment; nX, nY: Integer; nType: Integer);
begin
  inherited Create(Envir, nX, nY, nType, GetTickCount, True);
end;

destructor TSafeEvent.Destroy;
begin

  inherited;
end;

procedure TSafeEvent.Run();
begin
  m_dwOpenStartTick := GetTickCount();
  inherited;
end;

{ TFlowerEvent 烟花}

constructor TFlowerEvent.Create(Envir: TEnvirnoment; nX, nY: Integer; nType, nTime: Integer);
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
end;

destructor TFlowerEvent.Destroy;
begin
  inherited;
end;

procedure TFlowerEvent.Run();
begin
  //m_dwOpenStartTick := GetTickCount();
  inherited;
end;

{ TFireBurnEvent }

constructor TFireBurnEvent.Create(Creat: TBaseObject; nX, nY, nType, nTime, nDamage: Integer);
begin
  inherited Create(Creat.m_PEnvir, nX, nY, nType, nTime, True);
  m_nDamage := nDamage;
  m_OwnBaseObject := Creat;
  m_nType:= nType;//20080925
  nTwoPwr:= 0;//20081222
  boReadSkill:= False;//20081223 学习过内功技能
end;

destructor TFireBurnEvent.Destroy;
begin
  inherited;
end;

procedure TFireBurnEvent.Run;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  nSePwr, nPwr:Integer;
begin
  if (GetTickCount - m_dwRunTick) > 3000 then begin
    m_dwRunTick := GetTickCount();
    BaseObjectList := TList.Create;
    Try
      if m_Envir <> nil then begin
        m_Envir.GeTBaseObjects(m_nX, m_nY, True, BaseObjectList);
        if BaseObjectList.Count > 0 then begin//20080630
          for I := 0 to BaseObjectList.Count - 1 do begin
            TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
            nSePwr:= m_nDamage;
            if (TargeTBaseObject <> nil) and (m_OwnBaseObject <> nil) then begin
              if (not m_OwnBaseObject.m_boRobotObject) then begin//20090129
                if (m_OwnBaseObject.IsProperTarget(TargeTBaseObject)) then begin
                  if (m_nType = ET_FIRE) then begin//20080925 英雄火墙
                    if (m_OwnBaseObject.m_btRaceServer = RC_HEROOBJECT) then m_OwnBaseObject.m_ExpHitter:= TargeTBaseObject;
                    if ((m_OwnBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (m_OwnBaseObject.m_btRaceServer = RC_HEROOBJECT)) and boReadSkill then begin//20081223
                      nPwr:= 0;
                      if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                        nPwr:= MagicManager.GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_213,nTwoPwr);//静之火墙
                      end else
                      if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                        nPwr:= MagicManager.GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_213,nTwoPwr);//静之火墙
                      end;
                      nSePwr := nSePwr - nPwr;
                      if nSePwr < 0 then nSePwr:= 0;
                    end;
                  end;
                  TargeTBaseObject.SendMsg(m_OwnBaseObject, RM_MAGSTRUCK_MINE, 0, nSePwr, 0, 0, '');
                end;
              end;
            end;
          end;//for
        end;
      end;
    finally
      BaseObjectList.Free;
    end;
  end;
  inherited;
end;

{ TEvent }

constructor TEvent.Create(tEnvir: TEnvirnoment; nTX, nTY, nType, dwETime: Integer; boVisible: Boolean);
begin
  m_dwOpenStartTick := GetTickCount();
  m_nEventType := nType;
  m_nEventParam := 0;
  m_dwContinueTime := dwETime;
  m_boVisible := boVisible;
  m_boClosed := False;
  m_Envir := tEnvir;
  m_nX := nTX;
  m_nY := nTY;
  m_boActive := True;
  m_nDamage := 0;
  m_OwnBaseObject := nil;
  m_dwRunStart := GetTickCount();
  m_dwRunTick := 500;
  if (m_Envir <> nil) and (m_boVisible) then begin
    m_Envir.AddToMap(m_nX, m_nY, OS_EVENTOBJECT, Self);
  end else m_boVisible := False;
end;

destructor TEvent.Destroy;
begin
  m_boClosed := True;//20080903 增加
  inherited;
end;

procedure TEvent.Run;
begin
  if (GetTickCount - m_dwOpenStartTick) > m_dwContinueTime then begin
    m_boClosed := True;
    Close();
  end;
  if (not m_boClosed) and (m_OwnBaseObject <> nil) and (m_OwnBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (m_nEventType = ET_FIRE) and g_Config.boChangeMapFireExtinguish and not m_OwnBaseObject.m_boSuperMan {2007-02-04 增加 机器人除外} then begin
    if (m_OwnBaseObject.m_PEnvir <> m_Envir) or (m_OwnBaseObject.m_PEnvir.sMapName <> m_Envir.sMapName) then begin //2006-11-12 火墙换地图消失
      m_OwnBaseObject := nil;
      m_boClosed := True;
      Close();
      Exit;
    end;
  end;
  if (m_OwnBaseObject <> nil) and (m_OwnBaseObject.m_boGhost or (m_OwnBaseObject.m_boDeath)) then begin
    m_OwnBaseObject := nil;
  end;
end;

procedure TEvent.Close;
begin
  m_dwCloseTick := GetTickCount();
  if m_boVisible then begin
    m_boVisible := False;
    if m_Envir <> nil then begin
      m_Envir.DeleteFromMap(m_nX, m_nY, OS_EVENTOBJECT, Self);
    end;
    m_Envir := nil;
  end;
end;

{ TPileStones }

constructor TPileStones.Create(Envir: TEnvirnoment; nX, nY, nType,
  nTime: Integer);
begin
  inherited Create(Envir, nX, nY, nType, nTime, True);
  m_nEventParam := 1;
end;

destructor TPileStones.Destroy;
begin
  inherited;
end;

procedure TPileStones.AddEventParam;
begin
  if m_nEventParam < 5 then Inc(m_nEventParam);
end;

procedure TStoneMineEvent.AddStoneMine;
begin
  m_nMineCount := m_nAddStoneCount;
  m_dwAddStoneMineTick := GetTickCount();
end;

end.

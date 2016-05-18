unit Envir;

interface

uses
  Windows, SysUtils, Classes, SDK, Grobal2;
type
  TMapHeader = packed record
    wWidth: Word;
    wHeight: Word;
    sTitle: string[16];
    UpdateDate: TDateTime;
    Reserved: array[0..22] of Char;
  end;
  TMapUnitInfo = packed record
    wBkImg: Word; //为禁止移动区域
    wMidImg: Word;
    wFrImg: Word;
    btDoorIndex: Byte; 
    btDoorOffset: Byte;
    btAniFrame: Byte;
    btAniTick: Byte;
    btArea: Byte;
    btLight: Byte;
  end;
  pTMapUnitInfo = ^TMapUnitInfo;
  TMap = array[0..1000 * 1000 - 1] of TMapUnitInfo;
  pTMap = ^TMap;
  TMapCellinfo = record
    chFlag: Byte;
    ObjList: TList;
  end;
  pTMapCellinfo = ^TMapCellinfo;
  PTEnvirnoment = ^TEnvirnoment;
  TEnvirnoment = class
    sMapName: string; //地图ID
    sMapDesc: string;//地图名称
    sMainMapName: string;//小地图名称
    //sSubMapName: string; //未使用 20080723
    m_boMainMap: Boolean; //
    MapCellArray: array of TMapCellinfo; //
    nMinMap: Integer; //小地图数量
    nServerIndex: Integer; //0x14
    nRequestLevel: Integer;//进入本地图所需等级
    m_nWidth: Integer; //0x1C
    m_nHeight: Integer; //0x20
    m_boDARK: Boolean; //0x24
    m_boDAY: Boolean; //0x25
    m_boDarkness: Boolean;
    m_boDayLight: Boolean;
    m_DoorList: TList; //门列表
    bo2C: Boolean;
    m_boSAFE: Boolean; //0x2D
    m_boFightZone: Boolean; //PK地图
    m_boFight2Zone: Boolean; //PK掉装备地图 20080525
    m_boFight3Zone: Boolean; //行会战争地图
    m_boFight4Zone: Boolean;//挑战地图 20080706
    m_boQUIZ: Boolean; //0x30
    m_boNORECONNECT: Boolean; //0x31
    m_boNEEDHOLE: Boolean; //进入需要洞
    m_boNORECALL: Boolean; //0x33
    m_boNOGUILDRECALL: Boolean;
    m_boNODEARRECALL: Boolean;
    m_boNOMASTERRECALL: Boolean;
    m_boNORANDOMMOVE: Boolean; //0x34
    m_boNODRUG: Boolean; //0x35
    m_boMINE: Boolean; //可以挖矿
    m_boNOPOSITIONMOVE: Boolean; //0x37
    sNoReconnectMap: string; //0x38
    QuestNPC: TObject; //0x3C
    nNEEDSETONFlag: Integer; //0x40
    nNeedONOFF: Integer; //0x44
    m_QuestList: TList; //0x48
    m_boNoManNoMon: Boolean;//无人不刷怪 20080525
    m_boRUNHUMAN: Boolean; //可以穿人
    m_boRUNMON: Boolean; //可以穿怪
    m_boINCHP: Boolean; //自动加HP值
    m_boIncGameGold: Boolean; //自动减游戏币
    m_boINCGAMEPOINT: Boolean; //自动加点
    m_boDECGAMEPOINT: Boolean; //自动减游戏点

    m_boNEEDLEVELTIME: Boolean;//雪域地图传送,判断等级,地图时间 20081228
    m_nNEEDLEVELPOINT: Integer;//进雪域地图最低等级
    m_boMoveToHome: Boolean;//是否需倒计时传送到回城点(雪域) 20081230
    m_sMoveToHomeMap: string;//传送的地图名
    m_nMoveToHomeX : Integer;//传送的地图X
    m_nMoveToHomeY : Integer;//传送的地图Y

    m_boNOCALLHERO: Boolean; //禁止召唤英雄 20080124
    m_boNOHEROPROTECT: Boolean;//禁止英雄守护 20080629
    m_boNODROPITEM: Boolean; //禁止死亡掉物品 20080503
    m_boKILLFUNC: Boolean;//地图杀人触发 20080415
    m_nKILLFUNC: Integer;//地图杀人触发  20080415 
    m_boMISSION: Boolean; //不允许使用任何物品和技能 20080124
    m_boDECHP: Boolean; //自动减HP值
    m_boDecGameGold: Boolean; //自动减游戏币
    m_boMUSIC: Boolean; //音乐
    m_boEXPRATE: Boolean; //杀怪经验倍数
    m_boPKWINLEVEL: Boolean; //PK得等级
    m_boPKWINEXP: Boolean; //PK得经验
    m_boPKLOSTLEVEL: Boolean; //PK丢等级
    m_boPKLOSTEXP: Boolean; //PK丢经验
    m_nPKWINLEVEL: Integer; //PK得等级数
    m_nPKLOSTLEVEL: Integer; //PK丢等级
    m_nPKWINEXP: Integer; //PK得经验数
    m_nPKLOSTEXP: Integer; //PK丢经验
    m_nDECHPTIME: Integer; //减HP间隔时间
    m_nDECHPPOINT: Integer; //一次减点数
    m_nINCHPTIME: Integer; //加HP间隔时间
    m_nINCHPPOINT: Integer; //一次加点数
    m_nDECGAMEGOLDTIME: Integer; //减游戏币间隔时间
    m_nDecGameGold: Integer; //一次减数量
    m_nINCGAMEGOLDTIME: Integer; //加游戏币间隔时间
    m_nIncGameGold: Integer; //一次加数量
    m_nINCGAMEPOINTTIME: Integer; //加游戏币间隔时间
    m_nINCGAMEPOINT: Integer; //一次加数量
    m_nDECGAMEPOINTTIME: Integer; //减游戏币间隔时间
    m_nDECGAMEPOINT: Integer; //一次减数量

    m_nMUSICID: Integer; //音乐ID
    m_sMUSICName: string;//音乐ID
    m_nEXPRATE: Integer; //经验倍率
    m_nMonCount: Integer;//地图上怪物的数量
    m_nHumCount: Integer;//地图上人物的数量

    m_boUnAllowStdItems: Boolean; //是否不允许使用物品
    m_UnAllowStdItemsList: TGStringList; //不允许使用物品列表

    m_boUnAllowMagics: Boolean; //是否不允许使用魔法
    m_UnAllowMagicList: TGStringList; //不允许使用魔法列表

    m_boFIGHTPK: Boolean; //PK可以爆装备不红名
    nThunder:Integer;//雷电 地图参数 20080327 
    nLava:Integer;//地上冒岩浆 地图参数  20080327
  private
    procedure Initialize(nWidth, nHeight: Integer);
  public
    constructor Create();
    destructor Destroy; override;
    function AddToMap(nX, nY: Integer; btType: Byte; pRemoveObject: TObject): Pointer; //增加到地图上
    function CanWalk(nX, nY: Integer; boFlag: Boolean): Boolean;
    function CanWalkOfItem(nX, nY: Integer; boFlag, boItem: Boolean): Boolean;
    function CanWalkEx(nX, nY: Integer; boFlag: Boolean): Boolean;
    function CanFly(nSX, nSY, nDX, nDY: Integer): Boolean;
    function MoveToMovingObject(nCX, nCY: Integer; Cert: TObject; nX, nY: Integer; boFlag: Boolean): Integer;
    function GetItem(nX, nY: Integer): PTMapItem;//取地图物品
    function DeleteFromMap(nX, nY: Integer; btType: Byte; pRemoveObject: TObject): Integer;//从地图上删除
    function IsCheapStuff(): Boolean;//是廉价东西
    procedure AddDoorToMap;//增加门到地图上
    function AddToMapMineEvent(nX, nY: Integer; nType: Integer; Event: TObject): TObject;
    function LoadMapData(sMapFile: string): Boolean;
    function CreateQuest(nFlag, nValue: Integer; s24, s28, s2C: string; boGrouped: Boolean): Boolean;
    function GetMapCellInfo(nX, nY: Integer; var MapCellInfo: pTMapCellinfo): Boolean;
    function GetXYObjCount(nX, nY: Integer): Integer;
    function GetNextPosition(sX, sY, nDir, nFlag: Integer; var snx: Integer; var sny: Integer): Boolean;
    function sub_4B5FC8(nX, nY: Integer): Boolean;
    procedure VerifyMapTime(nX, nY: Integer; BaseObject: TObject);
    function CanSafeWalk(nX, nY: Integer): Boolean;
    function ArroundDoorOpened(nX, nY: Integer): Boolean;
    function GetMovingObject(nX, nY: Integer; boFlag: Boolean): Pointer;
    function GetQuestNPC(BaseObject: TObject; sCharName, sStr: string; boFlag: Boolean): TObject;
    function GetItemEx(nX, nY: Integer; var nCount: Integer): Pointer;
    function GetDoor(nX, nY: Integer): pTDoorInfo;
    function IsValidObject(nX, nY: Integer; nRage: Integer; BaseObject: TObject): Boolean;//有效的对象
    function GetRangeBaseObject(nX, nY: Integer; nRage: Integer; boFlag: Boolean; BaseObjectList: TList): Integer;//取范围内的对像
    function GeTBaseObjects(nX, nY: Integer; boFlag: Boolean; BaseObjectList: TList): Integer;//取对像
    function GetEvent(nX, nY: Integer): TObject;
    procedure SetMapXYFlag(nX, nY: Integer; boFlag: Boolean);
    function GetXYHuman(nMapX, nMapY: Integer): Boolean;
    function GetEnvirInfo(): string;//取地图信息
    function AllowStdItems(sItemName: string): Boolean; overload;//是否允许使用物品
    function AllowStdItems(nItemIdx: Integer): Boolean; overload;//是否允许使用物品
    function AllowMagics(sMagName: string): Boolean; overload;//是否允许使用魔法
    function AllowMagics(nMagIdx: Integer): Boolean; overload;//是否允许使用魔法

    procedure AddObject(nType: Integer);
    procedure DelObjectCount(BaseObject: TObject);
    property MonCount: Integer read m_nMonCount;//怪物数量
    property HumCount: Integer read m_nHumCount;//当前地图人物数量

    function GetMapItem(nX, nY, nRage: Integer;BaseObjectList: TList): Integer;//20080124 取指定地图范围内里的物品
  end;
  TMapManager = class(TGList)
  private
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadMapDoor();
    function AddMapInfo(sMapName, sMainMapName, sMapDesc: string; nServerNumber: Integer; MapFlag: pTMapFlag; QuestNPC: TObject): TEnvirnoment;
    function GetMapInfo(nServerIdx: Integer; sMapName: string): TEnvirnoment;
    function AddMapRoute(sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO: string; nDMapX, nDMapY: Integer): Boolean;
    function GetMapOfServerIndex(sMapName: string): Integer;
    function FindMap(sMapName: string): TEnvirnoment;//查找地图
    function GetMainMap(Envir: TEnvirnoment): string;
    procedure ReSetMinMap();
    procedure Run();
    procedure ProcessMapDoor();
    procedure MakeSafePkZone();
  end;
implementation

uses ObjBase, ObjNpc, M2Share, Event, ObjMon, HUtil32, Castle;

{ TEnvirList }

procedure TMapManager.MakeSafePkZone();
var
  nX, nY: Integer;
  SafeEvent: TSafeEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  I: Integer;
  StartPoint: pTStartPoint;
  Envir: TEnvirnoment;
begin
  g_StartPointList.Lock;
  if g_StartPointList.Count > 0 then begin//20080630
    for I := 0 to g_StartPointList.Count - 1 do begin
      StartPoint := pTStartPoint(g_StartPointList.Objects[I]);
      if (StartPoint <> nil) and (StartPoint.m_nType > 0) then begin
        Envir := FindMap(StartPoint.m_sMapName);
        if Envir <> nil then begin
          nMinX := StartPoint.m_nCurrX - StartPoint.m_nRange;
          nMaxX := StartPoint.m_nCurrX + StartPoint.m_nRange;
          nMinY := StartPoint.m_nCurrY - StartPoint.m_nRange;
          nMaxY := StartPoint.m_nCurrY + StartPoint.m_nRange;
          for nX := nMinX to nMaxX do begin
            for nY := nMinY to nMaxY do begin
              if ((nX < nMaxX) and (nY = nMinY)) or
                ((nY < nMaxY) and (nX = nMinX)) or
                (nX = nMaxX) or (nY = nMaxY) then begin
                SafeEvent := TSafeEvent.Create(Envir, nX, nY, StartPoint.m_nType);
                g_EventManager.AddEvent(SafeEvent);
              end;
            end;
          end;
        end;
      end;
    end;//for
  end;
end;

function TMapManager.AddMapInfo(sMapName, sMainMapName, sMapDesc: string; nServerNumber: Integer; MapFlag: pTMapFlag; QuestNPC: TObject): TEnvirnoment;
var
  Envir: TEnvirnoment;
  I: Integer;
  nStd: Integer;
  TempList: TStringList;
  sTemp: string;
begin
  Result := nil;
  Envir := TEnvirnoment.Create;
  Envir.sMapName := sMapName;
  Envir.sMainMapName := sMainMapName;
  //Envir.sSubMapName := sMapName;//未使用 20080723
  Envir.sMapDesc := sMapDesc;
  if sMainMapName <> '' then Envir.m_boMainMap := True;
  Envir.nServerIndex := nServerNumber;
  Envir.m_boSAFE := MapFlag.boSAFE;
  Envir.m_boFightZone := MapFlag.boFIGHT;
  Envir.m_boFight2Zone:=MapFlag.boFIGHT2;//PK掉装备地图 20080525
  Envir.m_boFight3Zone := MapFlag.boFIGHT3;
  Envir.m_boFight4Zone := MapFlag.boFIGHT4;//挑战地图 20080706
  Envir.m_boDARK := MapFlag.boDARK;
  Envir.m_boDAY := MapFlag.boDAY;
  Envir.m_boQUIZ := MapFlag.boQUIZ;
  Envir.m_boNORECONNECT := MapFlag.boNORECONNECT;
  Envir.m_boNEEDHOLE := MapFlag.boNEEDHOLE;
  Envir.m_boNORECALL := MapFlag.boNORECALL;
  Envir.m_boNOGUILDRECALL := MapFlag.boNOGUILDRECALL;
  Envir.m_boNODEARRECALL := MapFlag.boNODEARRECALL;
  Envir.m_boNOMASTERRECALL := MapFlag.boNOMASTERRECALL;
  Envir.m_boNORANDOMMOVE := MapFlag.boNORANDOMMOVE;
  Envir.m_boNODRUG := MapFlag.boNODRUG;
  Envir.m_boMINE := MapFlag.boMINE;
  Envir.m_boNOPOSITIONMOVE := MapFlag.boNOPOSITIONMOVE;
  Envir.m_boNoManNoMon := MapFlag.boNoManNoMon;//无人不刷怪 20080525
  Envir.m_boRUNHUMAN := MapFlag.boRUNHUMAN; //可以穿人
  Envir.m_boRUNMON := MapFlag.boRUNMON; //可以穿怪
  Envir.m_boDECHP := MapFlag.boDECHP; //自动减HP值
  Envir.m_boINCHP := MapFlag.boINCHP; //自动加HP值
  Envir.m_boDecGameGold := MapFlag.boDECGAMEGOLD; //自动减游戏币
  Envir.m_boDECGAMEPOINT := MapFlag.boDECGAMEPOINT; //自动减游戏点
  Envir.m_boIncGameGold := MapFlag.boINCGAMEGOLD; //自动加游戏币
  Envir.m_boINCGAMEPOINT := MapFlag.boINCGAMEPOINT; //自动加游戏点

  Envir.m_boNEEDLEVELTIME := MapFlag.boNEEDLEVELTIME;//雪域地图传送,判断等级 20081228
  Envir.m_nNEEDLEVELPOINT := MapFlag.nNEEDLEVELPOINT;//进雪域地图最低等级
  Envir.m_boMoveToHome:= MapFlag.boMoveToHome;//是否需倒计时传送到回城点(雪域) 20081230
  Envir.m_sMoveToHomeMap := MapFlag.sMoveToHomeMap;//传送的地图名
  Envir.m_nMoveToHomeX := MapFlag.nMoveToHomeX;//传送的地图X
  Envir.m_nMoveToHomeY := MapFlag.nMoveToHomeY;//传送的地图Y

  Envir.m_boNOCALLHERO := MapFlag.boNOCALLHERO; //禁止召唤英雄  20080124
  Envir.m_boNOHEROPROTECT := MapFlag.boNOHEROPROTECT; //禁止英雄守护  20080629
  Envir.m_boNODROPITEM := MapFlag.boNODROPITEM; //禁止死亡掉物品  20080503

  Envir.m_boKILLFUNC := MapFlag.boKILLFUNC; //地图杀人触发  20080415
  Envir.m_nKILLFUNC := MapFlag.nKILLFUNC; //地图杀人触发  20080415

  Envir.m_boMISSION := MapFlag.boMISSION; //不允许使用任何物品和技能  20080124
  Envir.m_boMUSIC := MapFlag.boMUSIC; //音乐
  Envir.m_boEXPRATE := MapFlag.boEXPRATE; //杀怪经验倍数
  Envir.m_boPKWINLEVEL := MapFlag.boPKWINLEVEL; //PK得等级
  Envir.m_boPKWINEXP := MapFlag.boPKWINEXP; //PK得经验
  Envir.m_boPKLOSTLEVEL := MapFlag.boPKLOSTLEVEL;
  Envir.m_boPKLOSTEXP := MapFlag.boPKLOSTEXP;
  Envir.m_nPKWINLEVEL := MapFlag.nPKWINLEVEL; //PK得等级数
  Envir.m_nPKWINEXP := MapFlag.nPKWINEXP; //PK得经验数
  Envir.m_nPKLOSTLEVEL := MapFlag.nPKLOSTLEVEL;
  Envir.m_nPKLOSTEXP := MapFlag.nPKLOSTEXP;
  Envir.m_nPKWINEXP := MapFlag.nPKWINEXP; //PK得经验数
  Envir.m_nDECHPTIME := MapFlag.nDECHPTIME; //减HP间隔时间
  Envir.m_nDECHPPOINT := MapFlag.nDECHPPOINT; //一次减点数
  Envir.m_nINCHPTIME := MapFlag.nINCHPTIME; //加HP间隔时间
  Envir.m_nINCHPPOINT := MapFlag.nINCHPPOINT; //一次加点数
  Envir.m_nDECGAMEGOLDTIME := MapFlag.nDECGAMEGOLDTIME; //减游戏币间隔时间
  Envir.m_nDecGameGold := MapFlag.nDECGAMEGOLD; //一次减数量
  Envir.m_nINCGAMEGOLDTIME := MapFlag.nINCGAMEGOLDTIME; //减游戏币间隔时间
  Envir.m_nIncGameGold := MapFlag.nINCGAMEGOLD; //一次减数量
  Envir.m_nINCGAMEPOINTTIME := MapFlag.nINCGAMEPOINTTIME; //加游戏点间隔时间
  Envir.m_nINCGAMEPOINT := MapFlag.nINCGAMEPOINT; //一次减数量
  Envir.m_nDECGAMEPOINTTIME := MapFlag.nDECGAMEPOINTTIME; //减游戏点间隔时间
  Envir.m_nDECGAMEPOINT := MapFlag.nDECGAMEPOINT; //一次减数量

  Envir.m_nMUSICID := MapFlag.nMUSICID; //音乐ID
  Envir.m_nEXPRATE := MapFlag.nEXPRATE; //经验倍率
  Envir.m_sMUSICName := MapFlag.sMUSICName;

  Envir.sNoReconnectMap := MapFlag.sReConnectMap;
  Envir.QuestNPC := QuestNPC;
  Envir.nNEEDSETONFlag := MapFlag.nNEEDSETONFlag;
  Envir.nNeedONOFF := MapFlag.nNeedONOFF;

  Envir.m_boUnAllowStdItems := MapFlag.boUnAllowStdItems;
  Envir.m_boUnAllowMagics := MapFlag.boNOTALLOWUSEMAGIC;

  Envir.m_boFIGHTPK := MapFlag.boFIGHTPK; //PK可以爆装备不红名

  Envir.nThunder:= MapFlag.nThunder;//20080327
  Envir.nLava:= MapFlag.nLava;//20080327
  if (Envir.nThunder <> 0) or (Envir.nLava <> 0) then//20080408
    UserEngine.EffectList.add(Envir);
{  if Envir.nLava <> 0 then //20080327
    UserEngine.EffectList.add(Envir); }

  if (Envir.m_boUnAllowStdItems) and (MapFlag.sUnAllowStdItemsText <> '') then begin
    TempList := TStringList.Create;
    ExtractStrings(['|', '\', '/'], [], PChar(Trim(MapFlag.sUnAllowStdItemsText)), TempList);
    if TempList.Count > 0 then begin//20080630
      for I := 0 to TempList.Count - 1 do begin
        nStd := UserEngine.GetStdItemIdx(Trim(TempList.Strings[I]));
        if nStd >= 0 then
          Envir.m_UnAllowStdItemsList.AddObject(Trim(TempList.Strings[I]), TObject(nStd));
      end;
    end;
    TempList.Free;
  end;

  if (Envir.m_boUnAllowMagics) and (MapFlag.sUnAllowMagicText <> '') then begin
    TempList := TStringList.Create;
    ExtractStrings(['|', '\', '/'], [], PChar(Trim(MapFlag.sUnAllowMagicText)), TempList);
    if TempList.Count > 0 then begin//20080630
      for I := 0 to TempList.Count - 1 do begin
        sTemp := Trim(TempList.Strings[I]);
        if sTemp <> '' then Envir.m_UnAllowMagicList.Add(sTemp);
      end;
    end;
    TempList.Free;
  end;

  if MiniMapList.Count > 0 then begin//20080630
    for I := 0 to MiniMapList.Count - 1 do begin
      if CompareText(MiniMapList.Strings[I], Envir.sMapName) = 0 then begin
        Envir.nMinMap := Integer(MiniMapList.Objects[I]);
        Break;
      end;
    end;
  end;
  if sMainMapName <> '' then begin
    if Envir.LoadMapData(g_Config.sMapDir + sMainMapName + '.map') then begin
      Result := Envir;
      Self.Add(Envir);
    end else begin
      MainOutMessage('地图文件 ' + g_Config.sMapDir + sMainMapName + '.map' + ' 未找到！！！');
    end;
  end else begin
    if Envir.LoadMapData(g_Config.sMapDir + sMapName + '.map') then begin
      Result := Envir;
      Self.Add(Envir);
    end else begin
      MainOutMessage('地图文件 ' + g_Config.sMapDir + sMapName + '.map' + ' 未找到！！！');
    end;
  end;
end;
//增加地图连接点
function TMapManager.AddMapRoute(sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO: string; nDMapX, nDMapY: Integer): Boolean;
var
  GateObj: pTGateObj;
  SEnvir: TEnvirnoment;
  DEnvir: TEnvirnoment;
begin
  Result := False;
  SEnvir := FindMap(sSMapNO);
  DEnvir := FindMap(sDMapNO);
  if (SEnvir <> nil) and (DEnvir <> nil) then begin
    New(GateObj);
    GateObj.boFlag := False;
    GateObj.DEnvir := DEnvir;
    GateObj.nDMapX := nDMapX;
    GateObj.nDMapY := nDMapY;
    SEnvir.AddToMap(nSMapX, nSMapY, OS_GATEOBJECT, TObject(GateObj));
    Result := True;
  end;
end;

function TEnvirnoment.AddToMap(nX, nY: Integer; btType: Byte;
  pRemoveObject: TObject): Pointer;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  MapItem: PTMapItem;
  I: Integer;
  nGoldCount: Integer;
  bo1E: Boolean;
  btRaceServer: Byte;
  nCode: Byte;
resourcestring
  sExceptionMsg = '{异常} TEnvirnoment::AddToMap Code:';
begin
  Result := nil;
  nCode:= 0;
  try
    bo1E := False;
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
      if MapCellInfo.ObjList = nil then begin
        MapCellInfo.ObjList := TList.Create;
      end else begin
        if btType = OS_ITEMOBJECT then begin
          if PTMapItem(pRemoveObject).Name = sSTRING_GOLDNAME then begin
            if MapCellInfo.ObjList.Count > 0 then begin//20080630
              for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
                OSObject := MapCellInfo.ObjList.Items[I];
                if (OSObject <> nil) and (OSObject.btType = OS_ITEMOBJECT) then begin
                  MapItem := PTMapItem(pTOSObject(MapCellInfo.ObjList.Items[I]).CellObj);
                  if MapItem.Name = sSTRING_GOLDNAME then begin
                    nGoldCount := MapItem.Count + PTMapItem(pRemoveObject).Count;
                    if nGoldCount <= 2000 then begin
                      MapItem.Count := nGoldCount;
                      MapItem.Looks := GetGoldShape(nGoldCount);
                      MapItem.AniCount := 0;
                      MapItem.Reserved := 0;
                      OSObject.dwAddTime := GetTickCount();
                      Result := MapItem;
                      bo1E := True;
                    end;
                  end;
                end;
              end;//for
            end;
          end;
          if not bo1E and (MapCellInfo.ObjList.Count >= 5) then begin
            Result := nil;
            bo1E := True;
          end;
        end;
        if btType = OS_EVENTOBJECT then begin

        end;
      end;
      if not bo1E then begin
        New(OSObject);
        OSObject.btType := btType;
        OSObject.CellObj := pRemoveObject;
        OSObject.dwAddTime := GetTickCount();
        nCode:= 1;
        MapCellInfo.ObjList.Add(OSObject);
        nCode:= 2;
        Result := Pointer(pRemoveObject);

        if (btType = OS_MOVINGOBJECT) and (not TBaseObject(pRemoveObject).m_boAddToMaped) then begin
          TBaseObject(pRemoveObject).m_boDelFormMaped := False;
          TBaseObject(pRemoveObject).m_boAddToMaped := True;
          btRaceServer := TBaseObject(pRemoveObject).m_btRaceServer;
          nCode:= 3;
          if btRaceServer = RC_PLAYOBJECT then Inc(m_nHumCount);
          if btRaceServer >= RC_ANIMAL then Inc(m_nMonCount);
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg + IntToStr(nCode));
  end;
end;
//地图是否允许使用物品
function TEnvirnoment.AllowStdItems(sItemName: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  try
    if (not m_boUnAllowStdItems) or (m_UnAllowStdItemsList = nil) then Exit;//20080930 增加
    if m_UnAllowStdItemsList.Count > 0 then begin//20080630
      for I := 0 to m_UnAllowStdItemsList.Count - 1 do begin
        if CompareText(m_UnAllowStdItemsList.Strings[I], sItemName) = 0 then begin
          Result := False;
          Break;
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TEnvirnoment.AllowStdItems Code:0');
  end;
end;
//地图是否允许使用物品
function TEnvirnoment.AllowStdItems(nItemIdx: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;
  try
    if (not m_boUnAllowStdItems) or (m_UnAllowStdItemsList = nil)  then Exit;//20080930 增加
    if m_UnAllowStdItemsList.Count > 0 then begin//20080630
      for I := 0 to m_UnAllowStdItemsList.Count - 1 do begin
        if Integer(m_UnAllowStdItemsList.Objects[I]) = nItemIdx then begin
          Result := False;
          Break;
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TEnvirnoment.AllowStdItems Code:1');
  end;
end;


function TEnvirnoment.AllowMagics(sMagName: string): Boolean; //是否允许使用魔法
var
  I: Integer;
begin
  Result := True;
  if not m_boUnAllowMagics then Exit;
  if m_UnAllowMagicList.Count > 0 then begin//20080630
    for I := 0 to m_UnAllowMagicList.Count - 1 do begin
      if CompareText(m_UnAllowMagicList.Strings[I], sMagName) = 0 then begin
        Result := False;
        Break;
      end;
    end;
  end;
end;

function TEnvirnoment.AllowMagics(nMagIdx: Integer): Boolean; //是否允许使用魔法
var
  I: Integer;
begin
  Result := True;
  if not m_boUnAllowMagics then Exit;
  if m_UnAllowMagicList.Count > 0 then begin//20080630
    for I := 0 to m_UnAllowMagicList.Count - 1 do begin
      if Integer(m_UnAllowMagicList.Objects[I]) = nMagIdx then begin
        Result := False;
        Break;
      end;
    end;
  end;
end;

procedure TEnvirnoment.AddDoorToMap();
var
  I: Integer;
  Door: pTDoorInfo;
begin
  if  m_DoorList.Count > 0 then begin//20080630
    for I := 0 to m_DoorList.Count - 1 do begin
      Door := m_DoorList.Items[I];
      AddToMap(Door.nX, Door.nY, OS_DOOR, TObject(Door));
    end;
  end;
end;

function TEnvirnoment.GetMapCellInfo(nX, nY: Integer; var MapCellInfo: pTMapCellinfo): Boolean;
begin
  Result := False;//20080826 增加
  try
    if (nX >= 0) and (nX < m_nWidth) and (nY >= 0) and (nY < m_nHeight) then begin
      MapCellInfo := @MapCellArray[nX * m_nHeight + nY];
      Result := True;
    end else begin
      Result := False;
    end;
  except
  end;
end;

function TEnvirnoment.MoveToMovingObject(nCX, nCY: Integer; Cert: TObject; nX, nY: Integer; boFlag: Boolean): Integer;
var
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  OSObject: pTOSObject;
  I: Integer;
  bo1A: Boolean;
  nCode: Byte;//20080702
//label //20080727 未使用的标签
//  Loop, Over;
begin
  Result := 0;
  nCode:= 0;
  try
    bo1A := True;
    if not boFlag and GetMapCellInfo(nX, nY, MapCellInfo) then begin
      if MapCellInfo.chFlag = 0 then begin
        if MapCellInfo.ObjList <> nil then begin
          if MapCellInfo.ObjList.Count > 0 then begin//20080630
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              if pTOSObject(MapCellInfo.ObjList.Items[I]) <> nil then begin//20080730
                if pTOSObject(MapCellInfo.ObjList.Items[I]).btType = OS_MOVINGOBJECT then begin
                  BaseObject := TBaseObject(pTOSObject(MapCellInfo.ObjList.Items[I]).CellObj);
                  if BaseObject <> nil then begin //检测移动地点是否有人物
                    if not BaseObject.m_boGhost and BaseObject.bo2B9 and not BaseObject.m_boDeath
                      and not BaseObject.m_boFixedHideMode and not BaseObject.m_boObMode then begin
                      bo1A := False;
                      Break;
                    end;
                  end;
                end;
              end;
            end;//for
          end;
        end;
      end else begin //if MapCellInfo.chFlag = 0 then begin
        Result := -1;
        bo1A := False;
      end;
    end;
    if bo1A then begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag <> 0) then begin
        Result := -1;
      end else begin
        if GetMapCellInfo(nCX, nCY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          I := 0;
          nCode:= 1;
          while (True) do begin
            if MapCellInfo.ObjList.Count <= I then Break;
            OSObject := MapCellInfo.ObjList.Items[I];
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
              if TBaseObject(OSObject.CellObj) = TBaseObject(Cert) then begin
                nCode:= 5;
                MapCellInfo.ObjList.Delete(I);
                nCode:= 6;
                DisPoseAndNil(OSObject);
                if MapCellInfo.ObjList.Count > 0 then Continue;
                FreeAndNil(MapCellInfo.ObjList);
                break;
              end;
            end;
            Inc(I);
          end;
        end;
        if GetMapCellInfo(nX, nY, MapCellInfo) then begin
          nCode:= 9;
          if (MapCellInfo.ObjList = nil) then begin
            MapCellInfo.ObjList := TList.Create;
          end;
          nCode:= 10;
          New(OSObject);
          OSObject.btType := OS_MOVINGOBJECT;
          OSObject.CellObj := Cert;
          OSObject.dwAddTime := GetTickCount;
          nCode:= 11;
          MapCellInfo.ObjList.Add(OSObject);
          Result := 1;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage('{异常} TEnvirnoment::MoveToMovingObject Code:'+inttostr(nCode));
    end;
  end;
end;
//======================================================================
//检查地图指定座标是否可以移动
//boFlag  如果为TRUE 则忽略座标上是否有角色
//返回值 True 为可以移动，False 为不可以移动
//======================================================================1
function TEnvirnoment.CanWalk(nX, nY: Integer; boFlag: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    Result := True;
    if not boFlag and (MapCellInfo.ObjList <> nil) then begin
      if MapCellInfo.ObjList.Count > 0 then begin//20080630
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if BaseObject <> nil then begin
              if not BaseObject.m_boGhost
                and BaseObject.bo2B9
                and not BaseObject.m_boDeath
                and not BaseObject.m_boFixedHideMode
                and not BaseObject.m_boObMode then begin
                Result := False;
                Break;
              end;
            end;
          end;
        end;//for
      end;
    end;
  end;
end;

//======================================================================
//检查地图指定座标是否可以移动
//boFlag  如果为TRUE 则忽略座标上是否有角色
//返回值 True 为可以移动，False 为不可以移动
//======================================================================
function TEnvirnoment.CanWalkOfItem(nX, nY: Integer; boFlag, boItem: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  I: Integer;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    if (MapCellInfo.ObjList <> nil) then begin
      if MapCellInfo.ObjList.Count > 0 then begin//20080630
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if not boFlag and (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if BaseObject <> nil then begin
              if not BaseObject.m_boGhost
                and BaseObject.bo2B9
                and not BaseObject.m_boDeath
                and not BaseObject.m_boFixedHideMode
                and not BaseObject.m_boObMode then begin
                Result := False;
                Break;
              end;
            end;
          end;
          if not boItem and (OSObject.btType = OS_ITEMOBJECT) then begin
            Result := False;
            Break;
          end;
        end;//for
      end;
    end;
  end;
end;

function TEnvirnoment.CanWalkEx(nX, nY: Integer; boFlag: Boolean): Boolean;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  I: Integer;
  Castle: TUserCastle;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    Result := True;
    if not boFlag and (MapCellInfo.ObjList <> nil) then begin
      if MapCellInfo.ObjList.Count > 0 then begin//20080630
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if OSObject <> nil then begin
            if OSObject.btType = OS_MOVINGOBJECT then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if BaseObject <> nil then begin
                {//01/25 多城堡 控制
                if g_Config.boWarDisHumRun and UserCastle.m_boUnderWar and
                  UserCastle.InCastleWarArea(BaseObject.m_PEnvir,BaseObject.m_nCurrX,BaseObject.m_nCurrY) then begin
                }
                Castle := g_CastleManager.InCastleWarArea(BaseObject);
                if g_Config.boWarDisHumRun and (Castle <> nil) and (Castle.m_boUnderWar) then begin
                end else begin
                  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                    if g_Config.boRUNHUMAN or m_boRUNHUMAN then Continue;
                  end else begin
                    if BaseObject.m_btRaceServer = RC_NPC then begin
                      if g_Config.boRunNpc then Continue;
                    end else begin
                      if BaseObject.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD] then begin
                        if g_Config.boRunGuard then Continue;
                      end else begin
                        if BaseObject.m_btRaceServer <> 55 then begin //不允许穿过练功师
                          if g_Config.boRUNMON or m_boRUNMON then Continue;
                        end;
                      end;
                    end;
                  end;
                end;
                if not BaseObject.m_boGhost
                  and BaseObject.bo2B9
                  and not BaseObject.m_boDeath
                  and not BaseObject.m_boFixedHideMode
                  and not BaseObject.m_boObMode then begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end;
        end;//for
      end;
    end;
  end;
end;

constructor TMapManager.Create;
begin
  inherited Create;
end;

destructor TMapManager.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do begin
    TEnvirnoment(Items[I]).Free;
  end;
  inherited;
end;
//Envir:TEnvirnoment
function TMapManager.GetMainMap(Envir: TEnvirnoment): string;
begin
  if Envir.m_boMainMap then Result := Envir.sMainMapName
  else Result := Envir.sMapName;
end;

function TMapManager.FindMap(sMapName: string): TEnvirnoment;
var
  Map: TEnvirnoment;
  I: Integer;
begin
  Result := nil;
  Lock;
  try
    for I := 0 to Count - 1 do begin
      Map := TEnvirnoment(Items[I]);
      if CompareText(Map.sMapName, sMapName) = 0 then begin
        Result := Map;
        Break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TMapManager.GetMapInfo(nServerIdx: Integer; sMapName: string): TEnvirnoment;
var
  I: Integer;
  Envir: TEnvirnoment;
begin
  Result := nil;
  Lock;
  try
    if Count > 0 then begin//20080630
      for I := 0 to Count - 1 do begin
        Envir := Items[I];
        if (Envir.nServerIndex = nServerIdx) and (CompareText(Envir.sMapName, sMapName) = 0) then begin
          Result := Envir;
          Break;
        end;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TEnvirnoment.DeleteFromMap(nX, nY: Integer; btType: Byte;
  pRemoveObject: TObject): Integer;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  n18: Integer;
  btRaceServer: Byte;
resourcestring
  sExceptionMsg1 = '{异常} TEnvirnoment::DeleteFromMap -> Except 1 ** %d';
  sExceptionMsg2 = '{异常} TEnvirnoment::DeleteFromMap -> Except 2 ** %d';
begin
  Result := -1;
  try
    if GetMapCellInfo(nX, nY, MapCellInfo) then begin
      if MapCellInfo <> nil then begin
        try
          if MapCellInfo.ObjList <> nil then begin
            n18 := 0;
            while (True) do begin
              if MapCellInfo.ObjList.Count <= n18 then Break;
              OSObject := MapCellInfo.ObjList.Items[n18];
              if OSObject <> nil then begin
                if (OSObject.btType = btType) and (OSObject.CellObj = pRemoveObject) then begin
                  MapCellInfo.ObjList.Delete(n18);
                  DisPoseAndNil(OSObject);
                  Result := 1;
                  //减地图人物怪物计数
                  if (btType = OS_MOVINGOBJECT) and (not TBaseObject(pRemoveObject).m_boDelFormMaped) then begin
                    TBaseObject(pRemoveObject).m_boDelFormMaped := True;
                    TBaseObject(pRemoveObject).m_boAddToMaped := False;
                    btRaceServer := TBaseObject(pRemoveObject).m_btRaceServer;
                    if btRaceServer = RC_PLAYOBJECT then Dec(m_nHumCount);
                    if btRaceServer >= RC_ANIMAL then Dec(m_nMonCount);
                  end;
                  if MapCellInfo.ObjList.Count <= 0 then begin
                    FreeAndNil(MapCellInfo.ObjList);
                    Break;
                  end;
                  Continue;
                end
              end else begin
                MapCellInfo.ObjList.Delete(n18);
                if MapCellInfo.ObjList.Count > 0 then Continue;
                if MapCellInfo.ObjList.Count <= 0 then begin
                  FreeAndNil(MapCellInfo.ObjList);
                  Break;
                end;
              end;
              Inc(n18);
            end;
          end else begin
            Result := -2;
          end;
        except
          OSObject := nil;
          MainOutMessage(Format(sExceptionMsg1, [btType]));
        end;
      end else Result := -3;
    end else Result := 0;
  except
    MainOutMessage(Format(sExceptionMsg2, [btType]));
  end;
end;

function TEnvirnoment.GetItem(nX, nY: Integer): PTMapItem;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then begin
      if MapCellInfo.ObjList.Count > 0 then begin//20080630
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if OSObject <> nil then begin
            if OSObject.btType = OS_ITEMOBJECT then begin
              Result := PTMapItem(OSObject.CellObj);
              Exit;
            end;
            if OSObject.btType = OS_GATEOBJECT then
              bo2C := False;
            if OSObject.btType = OS_MOVINGOBJECT then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if not BaseObject.m_boDeath then
                bo2C := False;
            end;
          end;
        end;//for
      end;
    end;
  end;
end;

function TMapManager.GetMapOfServerIndex(sMapName: string): Integer;
var
  I: Integer;
  Envir: TEnvirnoment;
begin
  Result := 0;
  Lock;
  try
    if Count > 0 then begin//20080630
      for I := 0 to Count - 1 do begin
        Envir := Items[I];
        if (CompareText(Envir.sMapName, sMapName) = 0) then begin
          Result := Envir.nServerIndex;
          Break;
        end;
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TMapManager.LoadMapDoor;
var
  I: Integer;
begin
  if Count > 0 then begin//20080630
    for I := 0 to Count - 1 do begin
      TEnvirnoment(Items[I]).AddDoorToMap;
    end;
  end;
end;
procedure TMapManager.ProcessMapDoor;
begin

end;

procedure TMapManager.ReSetMinMap;
var
  I, II: Integer;
  Envirnoment: TEnvirnoment;
begin
  if Count > 0 then begin//20080630
    for I := 0 to Count - 1 do begin
      Envirnoment := TEnvirnoment(Items[I]);
      if MiniMapList.Count > 0 then begin//20080630
        for II := 0 to MiniMapList.Count - 1 do begin
          if CompareText(MiniMapList.Strings[II], Envirnoment.sMapName) = 0 then begin
            Envirnoment.nMinMap := Integer(MiniMapList.Objects[II]);
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.IsCheapStuff: Boolean;
begin
  if m_QuestList.Count > 0 then Result := True
  else Result := False;
end;

function TEnvirnoment.AddToMapMineEvent(nX, nY: Integer; nType: Integer; Event: TObject): TObject;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  bo19, bo1A: Boolean;
resourcestring
  sExceptionMsg = '{异常} TEnvirnoment::AddToMapMineEvent ';
begin
  Result := nil;
  try
    bo19 := GetMapCellInfo(nX, nY, MapCellInfo);
    bo1A := False;
    if bo19 and (MapCellInfo.chFlag <> 0) then begin
      if MapCellInfo.ObjList = nil then MapCellInfo.ObjList := TList.Create;
      if not bo1A then begin
        New(OSObject);
        OSObject.btType := nType;
        OSObject.CellObj := Event;
        OSObject.dwAddTime := GetTickCount();
        MapCellInfo.ObjList.Add(OSObject);
        Result := Event;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TEnvirnoment.VerifyMapTime(nX, nY: Integer; BaseObject: TObject);
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  boVerify: Boolean;
resourcestring
  sExceptionMsg = '{异常} TEnvirnoment::VerifyMapTime';
begin
  try
    boVerify := False;
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo <> nil) and (MapCellInfo.ObjList <> nil) then begin
      if MapCellInfo.ObjList.Count > 0 then begin//20080630
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) and (OSObject.CellObj = BaseObject) then begin
            OSObject.dwAddTime := GetTickCount();
            boVerify := True;
            Break;
          end;
        end;//for
      end;
    end;
    if not boVerify then
      AddToMap(nX, nY, OS_MOVINGOBJECT, BaseObject);
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

constructor TEnvirnoment.Create;
begin
  Pointer(MapCellArray) := nil;
  sMapName := '';
  //sSubMapName := '';
  sMainMapName := '';
  m_boMainMap := False;
  nServerIndex := 0;
  nMinMap := 0;
  m_nWidth := 0;
  m_nHeight := 0;
  m_boDARK := False;
  m_boDAY := False;
  m_nMonCount := 0;
  m_nHumCount := 0; ;
  m_DoorList := TList.Create;
  m_QuestList := TList.Create;
  m_UnAllowStdItemsList := TGStringList.Create;
  m_UnAllowMagicList := TGStringList.Create;
end;

destructor TEnvirnoment.Destroy;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  nX, nY: Integer;
  DoorInfo: pTDoorInfo;
begin
  for nX := 0 to m_nWidth - 1 do begin
    for nY := 0 to m_nHeight - 1 do begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        if MapCellInfo.ObjList.Count > 0 then begin//20080630
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if OSObject <> nil then begin//20080723
              case OSObject.btType of
                OS_ITEMOBJECT: if PTMapItem(OSObject.CellObj) <> nil then Dispose(PTMapItem(OSObject.CellObj));
                OS_GATEOBJECT: if pTGateObj(OSObject.CellObj) <> nil then Dispose(pTGateObj(OSObject.CellObj));
                OS_EVENTOBJECT: TEvent(OSObject.CellObj).Free;
              end;
              DisPoseAndNil(OSObject);
            end;
          end;//for
        end;
        FreeAndNil(MapCellInfo.ObjList);
      end;
    end;
  end;     
  if m_DoorList.Count > 0 then begin//20080630
    for I := 0 to m_DoorList.Count - 1 do begin
      DoorInfo := m_DoorList.Items[I];
      if DoorInfo <> nil then begin//20080723
        if DoorInfo.Status <> nil then begin//20080723
          Dec(DoorInfo.Status.nRefCount);
          if DoorInfo.Status.nRefCount <= 0 then Dispose(DoorInfo.Status);
        end;
        Dispose(DoorInfo);
      end;
    end;
  end;
  m_DoorList.Free;
  if m_QuestList.Count > 0 then begin//20080630
    for I := 0 to m_QuestList.Count - 1 do begin
      if pTMapQuestInfo(m_QuestList.Items[I]) <> nil then
        Dispose(pTMapQuestInfo(m_QuestList.Items[I]));
    end;
  end;
  m_QuestList.Free;
  //if MapCellArray <> nil then begin//20080723
  if Pointer(MapCellArray) <> nil then begin//20080723
    FreeMem(Pointer(MapCellArray));
    Pointer(MapCellArray) := nil;
  end;
  m_UnAllowStdItemsList.Free; //20061228 增加
  m_UnAllowMagicList.Free; //20061228 增加
  inherited;
end;

function TEnvirnoment.LoadMapData(sMapFile: string): Boolean;
var
  fHandle: Integer;
  Header: TMapHeader;
  nMapSize: Integer;
  n24, nW, nH: Integer;
  MapBuffer: pTMap;
  Point: Integer;
  Door: pTDoorInfo;
  I: Integer;
  MapCellInfo: pTMapCellinfo;
begin
  Result := False;
  if FileExists(sMapFile) then begin
    fHandle := FileOpen(sMapFile, fmOpenRead or fmShareExclusive);
    if fHandle > 0 then begin
      FileRead(fHandle, Header, SizeOf(TMapHeader));
      m_nWidth := Header.wWidth;
      m_nHeight := Header.wHeight;
      Initialize(m_nWidth, m_nHeight);
      nMapSize := m_nWidth * SizeOf(TMapUnitInfo) * m_nHeight;

      MapBuffer := AllocMem(nMapSize);
      FileRead(fHandle, MapBuffer^, nMapSize);

      for nW := 0 to m_nWidth - 1 do begin
        n24 := nW * m_nHeight;
        for nH := 0 to m_nHeight - 1 do begin
          if (MapBuffer[n24 + nH].wBkImg) and $8000 <> 0 then begin
            MapCellInfo := @MapCellArray[n24 + nH];
            MapCellInfo.chFlag := 1;
          end;
          if MapBuffer[n24 + nH].wFrImg and $8000 <> 0 then begin
            MapCellInfo := @MapCellArray[n24 + nH];
            MapCellInfo.chFlag := 2;
          end;
          if MapBuffer[n24 + nH].btDoorIndex and $80 <> 0 then begin
            Point := (MapBuffer[n24 + nH].btDoorIndex and $7F);
            if Point > 0 then begin
              New(Door);
              Door.nX := nW;
              Door.nY := nH;
              Door.n08 := Point;
              Door.Status := nil;
              if m_DoorList.Count > 0 then begin//20080630
                for I := 0 to m_DoorList.Count - 1 do begin
                  if abs(pTDoorInfo(m_DoorList.Items[I]).nX - Door.nX) <= 10 then begin
                    if abs(pTDoorInfo(m_DoorList.Items[I]).nY - Door.nY) <= 10 then begin
                      if pTDoorInfo(m_DoorList.Items[I]).n08 = Point then begin
                        Door.Status := pTDoorInfo(m_DoorList.Items[I]).Status;
                        Inc(Door.Status.nRefCount);
                        Break;
                      end;
                    end;
                  end;
                end;//for
              end;
              if Door.Status = nil then begin
                New(Door.Status);
                Door.Status.boOpened := False;
                Door.Status.bo01 := False;
                Door.Status.n04 := 0;
                Door.Status.dwOpenTick := 0;
                Door.Status.nRefCount := 1;
              end;
              m_DoorList.Add(Door);
            end;
          end;
        end;
      end;
      FreeMem(MapBuffer);
      FileClose(fHandle);
      Result := True;
    end;
  end;
end;

procedure TEnvirnoment.Initialize(nWidth, nHeight: Integer);
var
  nW, nH: Integer;
  MapCellInfo: pTMapCellinfo;
begin
  if (nWidth > 1) and (nHeight > 1) then begin
    if MapCellArray <> nil then begin
      for nW := 0 to m_nWidth - 1 do begin
        for nH := 0 to m_nHeight - 1 do begin
          MapCellInfo := @MapCellArray[nW * m_nHeight + nH];
          if MapCellInfo.ObjList <> nil then begin
            FreeAndNil(MapCellInfo.ObjList);
          end;
        end;
      end;
      FreeMem(Pointer(MapCellArray));
      Pointer(MapCellArray) := nil;
    end;
    m_nWidth := nWidth;
    m_nHeight := nHeight;
    Pointer(MapCellArray) := AllocMem((m_nWidth * m_nHeight) * SizeOf(TMapCellinfo));
  end;
end;

//nFlag,boFlag,Monster,Item,Quest,boGrouped
function TEnvirnoment.CreateQuest(nFlag, nValue: Integer; s24, s28, s2C: string;
  boGrouped: Boolean): Boolean;
var
  MapQuest: pTMapQuestInfo;
  MapMerchant: TMerchant;
begin
  Result := False;
  if nFlag < 0 then Exit;
  New(MapQuest);
  MapQuest.nFlag := nFlag;
  if nValue > 1 then nValue := 1;
  MapQuest.nValue := nValue;
  if s24 = '*' then s24 := '';
  MapQuest.s08 := s24;
  if s28 = '*' then s28 := '';
  MapQuest.s0C := s28;
  if s2C = '*' then s2C := '';

  MapQuest.bo10 := boGrouped;
  MapMerchant := TMerchant.Create;
  MapMerchant.m_sMapName := '0';
  MapMerchant.m_nCurrX := 0;
  MapMerchant.m_nCurrY := 0;
  MapMerchant.m_sCharName := s2C;
  MapMerchant.m_nFlag := 0;
  MapMerchant.m_wAppr := 0;
  MapMerchant.m_sFilePath := 'MapQuest_def\';
  MapMerchant.m_boIsHide := True;
  MapMerchant.m_boIsQuest := False;

  UserEngine.QuestNPCList.Add(MapMerchant);
  MapQuest.NPC := MapMerchant;
  m_QuestList.Add(MapQuest);
  Result := True;
end;

function TEnvirnoment.GetXYObjCount(nX, nY: Integer): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := 0;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin//20080630
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if BaseObject <> nil then begin
            if not BaseObject.m_boGhost and
              BaseObject.bo2B9 and
              not BaseObject.m_boDeath and
              not BaseObject.m_boFixedHideMode and
              not BaseObject.m_boObMode then begin
              Inc(Result);
            end;
          end;
        end;
      end;//for
    end;
  end;
end;

function TEnvirnoment.GetNextPosition(sX, sY, nDir, nFlag: Integer; var snx: Integer; var sny: Integer): Boolean;
begin
  snx := sX;
  sny := sY;
  case nDir of
    DR_UP: if sny > nFlag - 1 then Dec(sny, nFlag);
    DR_DOWN: if sny < (m_nHeight - nFlag) then Inc(sny, nFlag);
    DR_LEFT: if snx > nFlag - 1 then Dec(snx, nFlag);
    DR_RIGHT: if snx < (m_nWidth - nFlag) then Inc(snx, nFlag);
    DR_UPLEFT: begin
        if (snx > nFlag - 1) and (sny > nFlag - 1) then begin
          Dec(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_UPRIGHT: begin
        if (snx > nFlag - 1) and (sny < (m_nHeight - nFlag)) then begin
          Inc(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_DOWNLEFT: begin
        if (snx < (m_nWidth - nFlag)) and (sny > nFlag - 1) then begin
          Dec(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
    DR_DOWNRIGHT: begin
        if (snx < (m_nWidth - nFlag)) and (sny < (m_nHeight - nFlag)) then begin
          Inc(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
  end;
  if (snx = sX) and (sny = sY) then Result := False
  else Result := True;
end;
//能安全的走
function TEnvirnoment.CanSafeWalk(nX, nY: Integer): Boolean;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin//20080630
      for I := MapCellInfo.ObjList.Count - 1 downto 0 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) and (OSObject.btType = OS_EVENTOBJECT) then begin
          if TEvent(OSObject.CellObj).m_nDamage > 0 then Result := False;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.ArroundDoorOpened(nX, nY: Integer): Boolean;
var
  I: Integer;
  Door: pTDoorInfo;
resourcestring
  sExceptionMsg = '{异常} TEnvirnoment::ArroundDoorOpened ';
begin
  Result := True;
  try
    if m_DoorList.Count > 0 then begin//20080630
      for I := 0 to m_DoorList.Count - 1 do begin
        Door := m_DoorList.Items[I];
        if (abs(Door.nX - nX) <= 1) and ((abs(Door.nY - nY) <= 1)) then begin
          if not Door.Status.boOpened then begin
            Result := False;
            Break;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TEnvirnoment.GetMovingObject(nX, nY: Integer; boFlag: Boolean): Pointer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin//20080630
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if ((BaseObject <> nil) and
            (not BaseObject.m_boGhost) and
            (BaseObject.bo2B9)) and
            ((not boFlag) or (not BaseObject.m_boDeath)) then begin
            Result := BaseObject;
            Break;
          end;
        end;
      end;
    end;
  end;
end;
//取地图任务NPC
function TEnvirnoment.GetQuestNPC(BaseObject: TObject; sCharName, sStr: string; boFlag: Boolean): TObject;
var
  I: Integer;
  MapQuestFlag: pTMapQuestInfo;
  nFlagValue: Integer;
  bo1D: Boolean;
begin
  Result := nil;
  Try
    if m_QuestList.Count > 0 then begin//20080630
      for I := 0 to m_QuestList.Count - 1 do begin
        MapQuestFlag := m_QuestList.Items[I];
        nFlagValue := TBaseObject(BaseObject).GetQuestFalgStatus(MapQuestFlag.nFlag);
        if nFlagValue = MapQuestFlag.nValue then begin
          if (boFlag = MapQuestFlag.bo10) or (not boFlag) then begin
            bo1D := False;
            if (MapQuestFlag.s08 <> '') and (MapQuestFlag.s0C <> '') then begin
              if (MapQuestFlag.s08 = sCharName) and (MapQuestFlag.s0C = sStr) then bo1D := True;
            end;
            if (MapQuestFlag.s08 <> '') and (MapQuestFlag.s0C = '') then begin
              if (MapQuestFlag.s08 = sCharName) and (sStr = '') then bo1D := True;
            end;
            if (MapQuestFlag.s08 = '') and (MapQuestFlag.s0C <> '') then begin
              if (MapQuestFlag.s0C = sStr) then  bo1D := True;
            end;
            if bo1D then begin
              Result := MapQuestFlag.NPC;
              Break;
            end;
          end;
        end;
      end;
    end;
  except
  end;
end;

function TEnvirnoment.GetItemEx(nX, nY: Integer; var nCount: Integer): Pointer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  nCount := 0;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then begin
      if MapCellInfo.ObjList.Count > 0 then begin//20080630
        for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject := MapCellInfo.ObjList.Items[I];
          if OSObject <> nil then begin
            if OSObject.btType = OS_ITEMOBJECT then begin
              Result := Pointer(OSObject.CellObj);
              Inc(nCount);
            end;
            if OSObject.btType = OS_GATEOBJECT then begin
              bo2C := False;
            end;
            if OSObject.btType = OS_MOVINGOBJECT then begin
              BaseObject := TBaseObject(OSObject.CellObj);
              if not BaseObject.m_boDeath then
                bo2C := False;
            end;
          end;
        end;//for
      end;
    end;
  end;
end;

function TEnvirnoment.GetDoor(nX, nY: Integer): pTDoorInfo;
var
  I: Integer;
  Door: pTDoorInfo;
begin
  Result := nil;
  if m_DoorList.Count > 0 then begin//20080630
    for I := 0 to m_DoorList.Count - 1 do begin
      Door := m_DoorList.Items[I];
      if (Door.nX = nX) and (Door.nY = nY) then begin
        Result := Door;
        Exit;
      end;
    end;
  end;
end;
//判断目标是否有效果(用于挖尸体时的判断)
function TEnvirnoment.IsValidObject(nX, nY, nRage: Integer; BaseObject: TObject): Boolean;
var
  nXX, nYY, I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        if MapCellInfo.ObjList.Count > 0 then begin//20080630
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if (OSObject <> nil) and (OSObject.CellObj = BaseObject) then begin
              Result := True;
              Exit;
            end;
          end;//for
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetRangeBaseObject(nX, nY, nRage: Integer; boFlag: Boolean;
  BaseObjectList: TList): Integer;
var
  nXX, nYY: Integer;
begin
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      GeTBaseObjects(nXX, nYY, boFlag, BaseObjectList);
    end;
  end;
  Result := BaseObjectList.Count;
end;
//boFlag 是否包括死亡对象
//FALSE 包括死亡对象
//TRUE  不包括死亡对象
function TEnvirnoment.GeTBaseObjects(nX, nY: Integer; boFlag: Boolean;
  BaseObjectList: TList): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin//20080630
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if BaseObject <> nil then begin
            if not BaseObject.m_boGhost and BaseObject.bo2B9 then begin
              if not boFlag or not BaseObject.m_boDeath then
                BaseObjectList.Add(BaseObject);
            end;
          end;
        end;
      end;
    end;
  end;
  Result := BaseObjectList.Count;
end;
//------------------------------------------------------------------------------
//20080124 取指定地图范围内里的物品
function TEnvirnoment.GetMapItem(nX, nY, nRage: Integer;BaseObjectList: TList): Integer;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  MapItem: PTMapItem;
  nXX, nYY: Integer;
begin
  for nXX := nX - nRage to nX + nRage do begin
    for nYY := nY - nRage to nY + nRage do begin
      if GetMapCellInfo(nXX, nYY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        if MapCellInfo.ObjList.Count > 0 then begin//20080630
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject := MapCellInfo.ObjList.Items[I];
            if (OSObject <> nil) and (OSObject.btType = OS_ITEMOBJECT) then begin
              MapItem := PTMapItem(pTOSObject(MapCellInfo.ObjList.Items[I]).CellObj);
              if MapItem.Name <> '' then  BaseObjectList.Add(MapItem);
            end;
          end;
        end;
      end;
    end;
  end;
  Result := BaseObjectList.Count;
end;
//------------------------------------------------------------------------------

function TEnvirnoment.GetEvent(nX, nY: Integer): TObject;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin//20080630
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) and (OSObject.btType = OS_EVENTOBJECT) then begin
          Result := OSObject.CellObj;
        end;
      end;
    end;
  end;
end;

procedure TEnvirnoment.SetMapXYFlag(nX, nY: Integer; boFlag: Boolean);
var
  MapCellInfo: pTMapCellinfo;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) then begin
    if boFlag then MapCellInfo.chFlag := 0
    else MapCellInfo.chFlag := 2;
  end;
end;

function TEnvirnoment.CanFly(nSX, nSY, nDX, nDY: Integer): Boolean;
var
  r28, r30: real;
  n14, n18, n1C: Integer;
begin
  Result := True;
  r28 := (nDX - nSX) / 1.0E1;
  r30 := (nDY - nDX) / 1.0E1;
  n14 := 0;
  while (True) do begin
    n18 := Round(nSX + r28);
    n1C := Round(nSY + r30);
    if not CanWalk(n18, n1C, True) then begin
      Result := False;
      Break;
    end;
    Inc(n14);
    if n14 >= 10 then Break;
  end;
end;

function TEnvirnoment.GetXYHuman(nMapX, nMapY: Integer): Boolean;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := False;
  if GetMapCellInfo(nMapX, nMapY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
    if MapCellInfo.ObjList.Count > 0 then begin//20080630
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject := MapCellInfo.ObjList.Items[I];
        if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
            Result := True;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.sub_4B5FC8(nX, nY: Integer): Boolean;
var
  MapCellInfo: pTMapCellinfo;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 2) then
    Result := False;
end;
//取地图信息
function TEnvirnoment.GetEnvirInfo: string;
var
  sMsg: string;
begin
  sMsg := '地图名:%s(%s) DAY:%s DARK:%s SAFE:%s FIGHT:%s FIGHT3:%s QUIZ:%s NORECONNECT:%s(%s) MUSIC:%s(%d) EXPRATE:%s(%f) PKWINLEVEL:%s(%d) PKLOSTLEVEL:%s(%d) PKWINEXP:%s(%d) PKLOSTEXP:%s(%d) DECHP:%s(%d/%d) INCHP:%s(%d/%d)';
  sMsg := sMsg + ' DECGAMEGOLD:%s(%d/%d) INCGAMEGOLD:%s(%d/%d) INCGAMEPOINT:%s(%d/%d) DECGAMEPOINT:%s(%d/%d) RUNHUMAN:%s RUNMON:%s NEEDHOLE:%s NORECALL:%s NOGUILDRECALL:%s NODEARRECALL:%s NOMASTERRECALL:%s NODRUG:%s MINE:%s NOPOSITIONMOVE:%s NOCALLHERO:%s MISSION:%s';
  Result := Format(sMsg, [sMapName, sMapDesc,
      BoolToCStr(m_boDAY),
      BoolToCStr(m_boDARK),
      BoolToCStr(m_boSAFE),
      BoolToCStr(m_boFightZone),
      BoolToCStr(m_boFight3Zone),
      BoolToCStr(m_boQUIZ),
      BoolToCStr(m_boNORECONNECT), sNoReconnectMap,
      BoolToCStr(m_boMUSIC), m_nMUSICID,
      BoolToCStr(m_boEXPRATE), m_nEXPRATE / 100,
      BoolToCStr(m_boPKWINLEVEL), m_nPKWINLEVEL,
      BoolToCStr(m_boPKLOSTLEVEL), m_nPKLOSTLEVEL,
      BoolToCStr(m_boPKWINEXP), m_nPKWINEXP,
      BoolToCStr(m_boPKLOSTEXP), m_nPKLOSTEXP,
      BoolToCStr(m_boDECHP), m_nDECHPTIME, m_nDECHPPOINT,
      BoolToCStr(m_boINCHP), m_nINCHPTIME, m_nINCHPPOINT,
      BoolToCStr(m_boDecGameGold), m_nDECGAMEGOLDTIME, m_nDecGameGold,
      BoolToCStr(m_boIncGameGold), m_nINCGAMEGOLDTIME, m_nIncGameGold,
      BoolToCStr(m_boINCGAMEPOINT), m_nINCGAMEPOINTTIME, m_nINCGAMEPOINT,
      BoolToCStr(m_boDECGAMEPOINT), m_nDECGAMEPOINTTIME, m_nDECGAMEPOINT,
      BoolToCStr(m_boRUNHUMAN),
      BoolToCStr(m_boRUNMON),
      BoolToCStr(m_boNEEDHOLE),
      BoolToCStr(m_boNORECALL),
      BoolToCStr(m_boNOGUILDRECALL),
      BoolToCStr(m_boNODEARRECALL),
      BoolToCStr(m_boNOMASTERRECALL),
      BoolToCStr(m_boNODRUG),
      BoolToCStr(m_boMINE),
      BoolToCStr(m_boNOPOSITIONMOVE),
      BoolToCStr(m_boNOCALLHERO), //20080124 禁止召唤英雄
      BoolToCStr(m_boMISSION) //20080124 不允许使用任何物品和技能
      ]);
end;

procedure TEnvirnoment.AddObject(nType: Integer);
begin
  case nType of
    0: Inc(m_nHumCount);
    1: Inc(m_nMonCount);
  end;
end;

procedure TEnvirnoment.DelObjectCount(BaseObject: TObject);
var
  btRaceServer: Byte;
begin
  btRaceServer := TBaseObject(BaseObject).m_btRaceServer;
  if btRaceServer = RC_PLAYOBJECT then Dec(m_nHumCount);
  if btRaceServer >= RC_ANIMAL then Dec(m_nMonCount);
end;

procedure TMapManager.Run;
begin

end;

end.

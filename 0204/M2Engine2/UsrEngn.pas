unit UsrEngn;

interface
uses
  Windows, Classes, SysUtils, StrUtils, Controls, Forms, ObjBase, ObjNpc, Envir,
  Grobal2, SDK,ObjHero;
  
type
  TMonGenInfo = record//刷怪类
    sMapName: string[14];//地图名
    nRace: Integer;
    nRange: Integer;//范围
    nMissionGenRate: Integer;//集中座标刷新机率 1 -100
    dwStartTick: LongWord;//刷怪间隔
    nX: Integer;//X坐标
    nY: Integer;//Y坐标
    sMonName: string[14];//怪物名
    nAreaX: Integer;
    nAreaY: Integer;
    nCount: Integer;//怪物数量
    dwZenTime: LongWord;//刷怪时间
    dwStartTime: LongWord;//启动时间
    boIsNGMon: Boolean;//内功怪,打死可以增加内力值 20081001
    nNameColor: Byte; //自定义名字的颜色 20080810
    nChangeColorType: Integer; //2007-02- 01 增加  0自动变色 >0改变颜色 -1不改变
    CertList: TList;
    Envir: TEnvirnoment;
    nCurrMonGen: Integer;//刷怪索引 20080830
  end;
  pTMonGenInfo = ^TMonGenInfo;

  TMapMonGenCount = record
    sMapName: string[14];//地图名称
    nMonGenCount: Integer;//刷怪数量
    dwNotHumTimeTick: LongWord;//没玩家的间隔
    nClearCount: Integer;//清除数量
    boNotHum: Boolean;//是否有玩家
    dwMakeMonGenTimeTick: LongWord;//刷怪的间隔
    nMonGenRate: Integer; //刷怪倍数  10
    dwRegenMonstersTime: LongWord; //刷怪速度    200
  end;
  pTMapMonGenCount = ^TMapMonGenCount;

  TUserEngine = class
    m_LoadPlaySection: TRTLCriticalSection;
    m_LoadPlayList: TStringList; //从DB读取人物数据
    m_PlayObjectList: TStringList; //在线角色列表
    m_PlayObjectFreeList: TList; //0x10
    m_MonObjectList: TList;//火龙殿中的守护兽 20090111
    m_ChangeHumanDBGoldList: TList; //0x14
    dwShowOnlineTick: LongWord; //显示在线人数间隔
    dwSendOnlineHumTime: LongWord; //发送在线人数间隔
    dwProcessMapDoorTick: LongWord; //0x20
    dwProcessMissionsTime: LongWord; //0x24
    dwRegenMonstersTick: LongWord; //0x28
    m_dwProcessLoadPlayTick: LongWord; //0x30
    m_nCurrMonGen: Integer; //刷怪索引
    m_nMonGenListPosition: Integer; //0x3C
    m_nMonGenCertListPosition: Integer; //0x40
    m_nProcHumIDx: Integer; //0x44 处理人物开始索引（每次处理人物数限制）
    //nProcessHumanLoopTime: Integer; //20080815 注释
    nMerchantPosition: Integer; //0x4C
    nNpcPosition: Integer; //0x50
    StdItemList: TList; //物品列表(即数据库中的数据)
    MonsterList: TList; //怪物列表
    m_MonGenList: TList; //怪物列表(MonGen.txt文件里的设置)
    m_MagicList: TList; //魔法列表
    m_MapMonGenCountList: TList;
    m_AdminList: TGList; //管理员列表
    m_MerchantList: TGList; //List_68 NPC列表(Merchant.txt)
    QuestNPCList: TList; //0x6C
    m_ChangeServerList: TList;
    m_MagicEventList: TList;

    nMonsterCount: Integer; //怪物总数
    nMonsterProcessPostion: Integer; //0x80处理怪物总数位置，用于计算怪物总数
    nMonsterProcessCount: Integer; //0x88处理怪物数，用于统计处理怪物个数
    boItemEvent: Boolean; //ItemEvent
    //dwProcessMonstersTick: LongWord;//20080815 注释
    dwProcessMerchantTimeMin: Integer;
    dwProcessMerchantTimeMax: Integer;
    dwProcessNpcTimeMin: LongWord;
    dwProcessNpcTimeMax: LongWord;
    m_NewHumanList: TList;
    m_ListOfGateIdx: TList;
    m_ListOfSocket: TList;
    OldMagicList: TList;
    EffectList: TList;//地图效果列表
    m_TargetList: TList;//雷炎地图(中魔法的对像) 20080726
    m_nLimitUserCount: Integer; //限制用户数
    m_nLimitNumber: Integer; //限制使用天数或次数
    m_boStartLoadMagic: Boolean;//开始读取魔法
    m_dwSearchTick: LongWord;//
    m_dwGetTodyDayDateTick: LongWord;
    m_TodayDate: TDate;//今天日期

    m_PlayObjectLevelList: TSStringList; //人物等级排行
    m_WarrorObjectLevelList: TSStringList; //战士等级排行
    m_WizardObjectLevelList: TSStringList; //法师等级排行
    m_TaoistObjectLevelList: TSStringList; //道士等级排行
    m_PlayObjectMasterList: TSStringList; //徒弟数排行

    m_HeroObjectLevelList: TSStringList; //英雄等级排行
    m_WarrorHeroObjectLevelList: TSStringList; //英雄战士等级排行
    m_WizardHeroObjectLevelList: TSStringList; //英雄法师等级排行
    m_TaoistHeroObjectLevelList: TSStringList; //英雄道士等级排行
    dwGetOrderTick: LongWord;//取人物等级排行的间隔

    m_nCurrX_136: Integer; //起始座标X 20080124
    m_nCurrY_136: Integer; //起始座标Y 20080124
    m_NewCurrX_136: Integer;//终止座标X 20080124
    m_NewCurrY_136: Integer;//终止座标Y 20080124
    //m_sMapName_136: string[MAPNAMELEN]; //地图名称 20080124  20090204
    bo_ReadPlayLeveList: Boolean;//是否正在读取排行文件 20080829
  private
    procedure ProcessHumans();
    procedure ProcessMonsters();
    procedure ProcessMerchants();
    procedure ProcessNpcs();
    procedure ProcessEvents();
    procedure ProcessMapDoor();

    procedure ProcessEffects();//20080327
    procedure EffectTarget(x,y:Integer;Envir:TEnvirnoment);//20080327
    function FindNearbyTarget(x,y:Integer;Envir:TEnvirnoment;xTargetList:TList): TBaseObject; //20080327

    procedure NPCinitialize;
    procedure MerchantInitialize;
    function MonGetRandomItems(mon: TBaseObject): Integer;
    function RegenMonsters(MonGen: pTMonGenInfo; nCount: Integer): Boolean;//创建怪物对像
    //procedure WriteShiftUserData;//未使用 20080522
    function GetGenMonCount(MonGen: pTMonGenInfo): Integer;
    function AddBaseObject(sMapName: string; nX, nY: Integer; nMonRace: Integer; sMonName: string): TBaseObject;
    function AddPlayObject(PlayObject: TPlayObject; nX, nY: Integer; sMonName: string): TBaseObject; //创建分身
    //procedure GenShiftUserData();//20080522 注释
    procedure KickOnlineUser(sChrName: string);
    function SendSwitchData(PlayObject: TPlayObject; nServerIndex: Integer): Boolean;
    procedure SendChangeServer(PlayObject: TPlayObject; nServerIndex: Integer);
    procedure AddToHumanFreeList(PlayObject: TPlayObject);
    procedure GetHumData(PlayObject: TPlayObject; var HumanRcd: THumDataInfo);//取角色的数据
    procedure GetHeroData(BaseObject: TBaseObject; var HumanRcd: THumDataInfo); //取英雄的数据

    function GetHomeInfo(var nX: Integer; var nY: Integer): string;
    function GetRandHomeX(PlayObject: TPlayObject): Integer;
    function GetRandHomeY(PlayObject: TPlayObject): Integer;
    //function GetSwitchData(sChrName: string; nCode: Integer): pTSwitchDataInfo;//20080522 注释
    procedure LoadSwitchData(SwitchData: pTSwitchDataInfo; var PlayObject: TPlayObject);
    procedure DelSwitchData(SwitchData: pTSwitchDataInfo);
    procedure MonInitialize(BaseObject: TBaseObject; sMonName: string);
    function MapRageHuman(sMapName: string; nMapX, nMapY, nRage: Integer): Boolean;
    function GetOnlineHumCount(): Integer;
    function GetUserCount(): Integer;
    function GetLoadPlayCount(): Integer;
    function GetAutoAddExpPlayCount: Integer;
    //procedure GetHumanOrder(); 20080527 注释
    procedure GetPlayObjectLevelList();//20080220 读取排行榜文件
  public
    constructor Create();
    destructor Destroy; override;
    procedure Initialize();
    procedure ClearItemList(); virtual;
    procedure SwitchMagicList();

    procedure Run();
    procedure PrcocessData();
    procedure Execute;
    function RegenMonsterByName(sMAP: string; nX, nY: Integer; sMonName: string): TBaseObject;
    function RegenPlayByName(PlayObject: TPlayObject; nX, nY: Integer; sMonName: string): TBaseObject;

    function RegenMyHero(PlayObject: TPlayObject; nX, nY: Integer; HumanRcd: THumDataInfo): TBaseObject;
    function AddHeroObject(PlayObject: TPlayObject; nX, nY: Integer; HumanRcd: THumDataInfo): TBaseObject; //创建英雄
    procedure SaveHeroRcd(PlayObject: TPlayObject);
    procedure SaveHumanRcd(PlayObject: TPlayObject);

    procedure AddObjectToMonList(BaseObject: TBaseObject);
    function GetStdItem(nItemIdx: Integer): pTStdItem; overload;
    function GetStdItem(sItemName: string): pTStdItem; overload;
    function GetMakeWineStdItem(Anicount: Integer): pTStdItem;//(酿酒)通过材料Anicount得到对应酒的函数  20080620
    function GetMakeWineStdItem1(Shape: Integer): pTStdItem;//(酿酒)通过酒Shape得到对应酒曲的函数  20080621
    function GetStdItemWeight(nItemIdx: Integer): Integer;
    function GetStdItemName(nItemIdx: Integer): string;
    function GetStdItemIdx(sItemName: string): Integer;
    function FindOtherServerUser(sName: string; var nServerIndex): Boolean;
    procedure CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY, nWide: Integer; btFColor, btBColor: Byte; sMsg: string);
    procedure ProcessUserMessage(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; Buff: PChar);
    procedure SendServerGroupMsg(nCode, nServerIdx: Integer; sMsg: string);
    function GetMonRace(sMonName: string): Integer;
    //function GetMonRaceImg(sMonName: string): Integer;//20080313 取怪的图
    function InsMonstersList(MonGen: pTMonGenInfo; Monster: TAnimalObject): Boolean;
    function GetHeroObject(HeroObject: TBaseObject): TPlayObject;overload;
    function GetHeroObject(sName: string): TBaseObject;overload; //20071227 根据名字查找英雄类

    function GetMasterObject(sName: string): TPlayObject;//取师傅类 20080512

    function GetPlayObject(sName: string): TPlayObject; overload;
    function GetPlayObject(PlayObject: TBaseObject): TPlayObject; overload;
    function GetPlayObjectEx(sAccount, sName: string): TPlayObject;
    function GetPlayObjectExOfAutoGetExp(sAccount: string): TPlayObject;
    procedure KickPlayObjectEx(sAccount, sName: string);
    function FindMerchant(Merchant: TObject): TMerchant;
    function FindNPC(GuildOfficial: TObject): TGuildOfficial;
    //function InMerchantList(Merchant: TMerchant): Boolean;//是否是交易NPC,未使用 20080406
    //function InQuestNPCList(NPC: TNormNpc): Boolean;//未使用的函数  20080422
    function CopyToUserItemFromName(sItemName: string; Item: pTUserItem): Boolean;
    function GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY, nRange: Integer): Integer;
    function GetHumPermission(sUserName: string; var sIPaddr: string; var btPermission: Byte): Boolean;
    procedure AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
    procedure RandomUpgradeItem(Item: pTUserItem);//随机升级物品
    procedure GetUnknowItemValue(Item: pTUserItem);
    function OpenDoor(Envir: TEnvirnoment; nX, nY: Integer): Boolean;
    function CloseDoor(Envir: TEnvirnoment; Door: pTDoorInfo): Boolean;
    procedure SendDoorStatus(Envir: TEnvirnoment; nX, nY: Integer; wIdent, wX: Word; nDoorX, nDoorY, nA: Integer; sStr: string);
    function FindMagic(sMagicName: string): pTMagic; overload;
    function FindMagic(nMagIdx: Integer): pTMagic; overload;
    function FindHeroMagic(sMagicName: string): pTMagic; overload;
    function FindHeroMagic(nMagIdx: Integer): pTMagic; overload;
    function AddMagic(Magic: pTMagic): Boolean;
    function DelMagic(wMagicId: Word): Boolean;
    procedure AddMerchant(Merchant: TMerchant);
    function GetMerchantList(Envir: TEnvirnoment; nX, nY, nRange: Integer; TmpList: TList): Integer;
    function GetNpcList(Envir: TEnvirnoment; nX, nY, nRange: Integer; TmpList: TList): Integer;
    procedure ReloadMerchantList();
    procedure ReloadNpcList();
    procedure HumanExpire(sAccount: string);
    function GetMapMonster(Envir: TEnvirnoment; List: TList): Integer;
   // function IsMapRageHuman(sMapName: string; nRageX, nRageY, nRage: Integer): Boolean;//判断怪物坐标范围内是否有玩家 20080520
    function GetMapMonsterCount(Envir: TEnvirnoment; nX, nY, nRange:Integer; Name:string): Integer;//20081217 检查地图指定坐标指定名称怪物数量
    function GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange: Integer; List: TList): Integer;
    function GetMapHuman(sMapName: string): Integer;
    function GetMapRageHuman(Envir: TEnvirnoment; nRageX, nRageY, nRage: Integer; List: TList): Integer;
    procedure SendBroadCastMsg(sMsg: string; MsgType: TMsgType);
    procedure SendBroadCastMsg1(sMsg: string; MsgType: TMsgType; FColor, BColor: Byte);//加强版文件信息发送函数(供NPC命令-SendMsg使用) 20081214
    procedure SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType);
    procedure sub_4AE514(GoldChangeInfo: pTGoldChangeInfo);
    procedure ClearMonSayMsg();
    procedure SendQuestMsg(sQuestName: string);
    procedure ClearMerchantData();
    function GetMapMonGenCount(sMapName: string): pTMapMonGenCount;
    function AddMapMonGenCount(sMapName: string; nMonGenCount: Integer): Integer;
    function ClearMonsters(sMapName: string): Boolean;

    property MonsterCount: Integer read nMonsterCount;//怪物数量
    property OnlinePlayObject: Integer read GetOnlineHumCount;//在线人数
    property PlayObjectCount: Integer read GetUserCount;//总人数
    property AutoAddExpPlayCount: Integer read GetAutoAddExpPlayCount;//自动挂机人数
    property LoadPlayCount: Integer read GetLoadPlayCount;
    function GetShopStdItem(sItemName: string): pTStdItem;//20080801 取商铺物品

    function GetMapMonGenIdx(Envir: TEnvirnoment;var Idx:integer): Integer;//取有人才刷怪地图,刷怪索引 20080830
  end;
var
  g_dwEngineTick: LongWord;
  g_dwEngineRunTime: LongWord;
  m_boHumProcess: Boolean = False;//20080717 检查过程是否重入
  m_boProcessEffects: Boolean = False;////20080726 检查雷炎效果过程是否重入
  m_boPrcocessData: Boolean = False;
implementation

//{$R+}//20081204 检查数组越界

uses IdSrvClient, Guild, ObjMon, EDcode, ObjGuard, ObjAxeMon, M2Share,
  ObjMon2, ObjPlayMon, Event, InterMsgClient, InterServerMsg, ObjRobot, HUtil32, svMain,
  Castle, PlugIn, EDcodeUnit, Common, PlugOfEngine, IniFiles;
{ TUserEngine }

constructor TUserEngine.Create();
begin
  InitializeCriticalSection(m_LoadPlaySection);
  m_LoadPlayList := TStringList.Create;
  m_PlayObjectList := TStringList.Create;
  m_PlayObjectFreeList := TList.Create;
  m_MonObjectList := TList.Create;//火龙殿中的守护兽 20090111
  m_ChangeHumanDBGoldList := TList.Create;
  dwShowOnlineTick := GetTickCount;
  dwSendOnlineHumTime := GetTickCount;
  dwProcessMapDoorTick := GetTickCount;
  dwProcessMissionsTime := GetTickCount;
  //dwProcessMonstersTick := GetTickCount;//20080815 注释
  dwRegenMonstersTick := GetTickCount;
  m_dwProcessLoadPlayTick := GetTickCount;
  m_nCurrMonGen := 0;
  m_nMonGenListPosition := 0;
  m_nMonGenCertListPosition := 0;
  m_nProcHumIDx := 0;
  //nProcessHumanLoopTime := 0; //20080815 注释
  nMerchantPosition := 0;
  nNpcPosition := 0;

{$IF UserMode1 = 1}
  m_nLimitNumber := {1000000}0;//20080630(注册)
  m_nLimitUserCount := {1000000}0;//20080630(注册)
{$ELSE}
  m_nLimitNumber := 1000000;//20080630(注册)
  m_nLimitUserCount := 1000000;//20080630(注册)
{$IFEND}

  StdItemList := TList.Create; //List_54
  MonsterList := TList.Create;
  m_MonGenList := TList.Create;
  m_MagicList := TList.Create;
  m_AdminList := TGList.Create;
  m_MerchantList := TGList.Create;
  QuestNPCList := TList.Create;
  m_ChangeServerList := TList.Create;
  m_MagicEventList := TList.Create;
  m_MapMonGenCountList := TList.Create;
  boItemEvent := False;
  dwProcessMerchantTimeMin := 0;
  dwProcessMerchantTimeMax := 0;
  dwProcessNpcTimeMin := 0;
  dwProcessNpcTimeMax := 0;
  m_NewHumanList := TList.Create;
  m_ListOfGateIdx := TList.Create;
  m_ListOfSocket := TList.Create;
  OldMagicList := TList.Create;
  Effectlist := TList.Create;//20080327  //20080408
  m_TargetList:= TList.Create;//雷炎地图(中魔法的对像) 20080726
  m_boStartLoadMagic := False;
  m_dwSearchTick := GetTickCount;
  m_dwGetTodyDayDateTick := GetTickCount;
  m_TodayDate := 0;

  m_PlayObjectLevelList := TSStringList.Create; //人物排行 等级
  m_WarrorObjectLevelList := TSStringList.Create; //战士等级排行
  m_WizardObjectLevelList := TSStringList.Create; //法师等级排行
  m_TaoistObjectLevelList := TSStringList.Create; //道士等级排行
  m_PlayObjectMasterList := TSStringList.Create; //徒弟数排行

  m_HeroObjectLevelList := TSStringList.Create; //英雄等级排行
  m_WarrorHeroObjectLevelList := TSStringList.Create; //英雄战士等级排行
  m_WizardHeroObjectLevelList := TSStringList.Create; //英雄法师等级排行
  m_TaoistHeroObjectLevelList := TSStringList.Create; //英雄道士等级排行
  //dwGetOrderTick := GetTickCount; //20080220 注释
  bo_ReadPlayLeveList:= False;//是否正在读取排行文件 20080829
end;

destructor TUserEngine.Destroy;
var
  I: Integer;
  II: Integer;
  MonInfo: pTMonInfo;
  MonGenInfo: pTMonGenInfo;
  MagicEvent: pTMagicEvent;
  TmpList: TList;
begin
  if m_LoadPlayList.Count > 0 then begin//20080629
    for I := 0 to m_LoadPlayList.Count - 1 do begin
      if pTUserOpenInfo(m_LoadPlayList.Objects[I]) <> nil then
        Dispose(pTUserOpenInfo(m_LoadPlayList.Objects[I]));
    end;
  end;
  m_LoadPlayList.Free;

  if m_PlayObjectList.Count > 0 then begin//20080629
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      TPlayObject(m_PlayObjectList.Objects[I]).Free;
    end;
  end;
  m_PlayObjectList.Free;

  if m_PlayObjectFreeList.Count > 0 then begin//20080629
    for I := 0 to m_PlayObjectFreeList.Count - 1 do begin
      TPlayObject(m_PlayObjectFreeList.Items[I]).Free;
    end;
  end;
  m_PlayObjectFreeList.Free;

  if m_MonObjectList.Count > 0 then begin//火龙殿中的守护兽 20090111
    for I := 0 to m_MonObjectList.Count - 1 do begin
      TBaseObject(m_MonObjectList.Items[I]).Free;
    end;
  end;
  m_MonObjectList.Free;

  if m_ChangeHumanDBGoldList.Count > 0 then begin//20080629
    for I := 0 to m_ChangeHumanDBGoldList.Count - 1 do begin
      if pTGoldChangeInfo(m_ChangeHumanDBGoldList.Items[I]) <> nil then
         Dispose(pTGoldChangeInfo(m_ChangeHumanDBGoldList.Items[I]));
    end;
  end;
  m_ChangeHumanDBGoldList.Free;

  if StdItemList.Count > 0 then begin//20080629
    for I := 0 to StdItemList.Count - 1 do begin
      if pTStdItem(StdItemList.Items[I]) <> nil then
         Dispose(pTStdItem(StdItemList.Items[I]));
    end;
  end;
  StdItemList.Free;

  if MonsterList.Count > 0 then begin//20080629
    for I := 0 to MonsterList.Count - 1 do begin
      MonInfo := MonsterList.Items[I];
      if MonInfo.ItemList <> nil then begin
        if MonInfo.ItemList.Count > 0 then begin
          for II := 0 to MonInfo.ItemList.Count - 1 do begin
            if pTMonItem(MonInfo.ItemList.Items[II]) <> nil then//20080627
              Dispose(pTMonItem(MonInfo.ItemList.Items[II]));
          end;
        end;
        MonInfo.ItemList.Free;
      end;
      Dispose(MonInfo);
    end;
  end;
  MonsterList.Free;

  if m_MonGenList.Count > 0 then begin//20080629
    for I := 0 to m_MonGenList.Count - 1 do begin
      MonGenInfo := m_MonGenList.Items[I];
      if MonGenInfo.CertList.Count > 0 then begin//20080629
        for II := 0 to MonGenInfo.CertList.Count - 1 do begin
          TBaseObject(MonGenInfo.CertList.Items[II]).Free;
        end;
      end;
      Dispose(pTMonGenInfo(m_MonGenList.Items[I]));
    end;
  end;
  m_MonGenList.Free;

  if m_MagicList.Count > 0 then begin//20080629
    for I := 0 to m_MagicList.Count - 1 do begin
      if pTMagic(m_MagicList.Items[I]) <> nil then
        Dispose(pTMagic(m_MagicList.Items[I]));
    end;
  end;
  m_MagicList.Free;

  if m_AdminList.Count > 0 then begin//20080814
    for I := 0 to m_AdminList.Count - 1 do begin
      if pTAdminInfo(m_AdminList.Items[I]) <> nil then
        Dispose(pTAdminInfo(m_AdminList.Items[I]));
    end;
  end;
  m_AdminList.Free;

  if m_MerchantList.Count > 0 then begin//20080629
    for I := 0 to m_MerchantList.Count - 1 do TMerchant(m_MerchantList.Items[I]).Free;
  end;
  m_MerchantList.Free;
  if QuestNPCList.Count > 0 then begin//20080629
    for I := 0 to QuestNPCList.Count - 1 do begin
      TNormNpc(QuestNPCList.Items[I]).Free;
    end;
  end;
  QuestNPCList.Free;

  if m_ChangeServerList.Count > 0 then begin//20080629
    for I := 0 to m_ChangeServerList.Count - 1 do begin
      if pTSwitchDataInfo(m_ChangeServerList.Items[I]) <> nil then
         Dispose(pTSwitchDataInfo(m_ChangeServerList.Items[I]));
    end;
  end;
  m_ChangeServerList.Free;
  if m_MagicEventList.Count > 0 then begin//20080629
    for I := 0 to m_MagicEventList.Count - 1 do begin
      MagicEvent := m_MagicEventList.Items[I];
      if MagicEvent.BaseObjectList <> nil then MagicEvent.BaseObjectList.Free;
      Dispose(MagicEvent);
    end;
  end;
  m_MagicEventList.Free;
  m_NewHumanList.Free;
  m_ListOfGateIdx.Free;
  m_ListOfSocket.Free;
  if OldMagicList.Count > 0 then begin//20080629
    for I := 0 to OldMagicList.Count - 1 do begin
      TmpList := TList(OldMagicList.Items[I]);
      if TmpList.Count > 0 then begin
        for II := 0 to TmpList.Count - 1 do begin
          if pTMagic(TmpList.Items[II]) <> nil then Dispose(pTMagic(TmpList.Items[II]));
        end;
      end;
      TmpList.Free;
    end;
  end;
  OldMagicList.Free;

  if m_MapMonGenCountList.Count > 0 then begin//20080629
    for I := 0 to m_MapMonGenCountList.Count - 1 do begin
      if pTMapMonGenCount(m_MapMonGenCountList.Items[I]) <> nil then
         Dispose(pTMapMonGenCount(m_MapMonGenCountList.Items[I]));
    end;
  end;
  m_MapMonGenCountList.Free;

  {if Effectlist.Count > 0 then begin//20080629
    for I := 0 to Effectlist.Count - 1 do begin//20080407
      if pTEnvirnoment(Effectlist.Items[I]) <> nil then Dispose(pTEnvirnoment(Effectlist.Items[I]));
    end;
  end;  }
  if Effectlist.Count > 0 then begin//20080629
    //for I := 0 to Effectlist.Count - 1 do begin//20080407
    for I:=Effectlist.Count - 1 downto 0 do begin
      TEnvirnoment(Effectlist.Items[I]).Free;
      Effectlist.Delete(I);
    end;
  end;
  Effectlist.Free; //雷电 岩浆地图 //20080408
  m_TargetList.Free;//雷炎地图(中魔法的对像) 20080726

  if m_PlayObjectLevelList.Count > 0 then begin//20080629
    for I := 0 to m_PlayObjectLevelList.Count - 1 do begin
      if pTCharName(m_PlayObjectLevelList.Objects[I]) <> nil then
         Dispose(pTCharName(m_PlayObjectLevelList.Objects[I]));
    end;
  end;
  m_PlayObjectLevelList.Free; //人物排行 等级

  if m_WarrorObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_WarrorObjectLevelList.Count - 1 do begin
      if pTCharName(m_WarrorObjectLevelList.Objects[I]) <> nil then
         Dispose(pTCharName(m_WarrorObjectLevelList.Objects[I]));
    end;
  end;
  m_WarrorObjectLevelList.Free; //战士等级排行

  if m_WizardObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_WizardObjectLevelList.Count - 1 do begin
      if pTCharName(m_WizardObjectLevelList.Objects[I]) <> nil then
         Dispose(pTCharName(m_WizardObjectLevelList.Objects[I]));
    end;
  end;
  m_WizardObjectLevelList.Free; //法师等级排行

  if m_TaoistObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_TaoistObjectLevelList.Count - 1 do begin
      if pTCharName(m_TaoistObjectLevelList.Objects[I]) <> nil then
         Dispose(pTCharName(m_TaoistObjectLevelList.Objects[I]));
    end;
  end;
  m_TaoistObjectLevelList.Free; //道士等级排行
  
  if m_PlayObjectMasterList.Count > 0 then begin//20080629
    for I := 0 to m_PlayObjectMasterList.Count - 1 do begin
      if pTCharName(m_PlayObjectMasterList.Objects[I]) <> nil then
         Dispose(pTCharName(m_PlayObjectMasterList.Objects[I]));
    end;
  end;
  m_PlayObjectMasterList.Free; //徒弟数排行

  if m_HeroObjectLevelList.Count > 0 then begin//20080629
    for I := 0 to m_HeroObjectLevelList.Count - 1 do begin
      if pTHeroName(m_HeroObjectLevelList.Objects[I]) <> nil then
         Dispose(pTHeroName(m_HeroObjectLevelList.Objects[I]));
    end;
  end;
  m_HeroObjectLevelList.Free; //英雄等级排行

  if m_WarrorHeroObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_WarrorHeroObjectLevelList.Count - 1 do begin
      if pTHeroName(m_WarrorHeroObjectLevelList.Objects[I]) <> nil then
         Dispose(pTHeroName(m_WarrorHeroObjectLevelList.Objects[I]));
    end;
  end;
  m_WarrorHeroObjectLevelList.Free; //英雄战士等级排行

  if m_WizardHeroObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_WizardHeroObjectLevelList.Count - 1 do begin
      if pTHeroName(m_WizardHeroObjectLevelList.Objects[I]) <> nil then
         Dispose(pTHeroName(m_WizardHeroObjectLevelList.Objects[I]));
    end;
  end;
  m_WizardHeroObjectLevelList.Free; //英雄法师等级排行

  if m_TaoistHeroObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_TaoistHeroObjectLevelList.Count - 1 do begin
      if pTHeroName(m_TaoistHeroObjectLevelList.Objects[I]) <> nil then
         Dispose(pTHeroName(m_TaoistHeroObjectLevelList.Objects[I]));
    end;
  end;
  m_TaoistHeroObjectLevelList.Free; //英雄道士等级排行
  
  DeleteCriticalSection(m_LoadPlaySection);
  inherited;
end;
//------------------------------------------------------------------------------
//20080220 读取排行榜文件
procedure TUserEngine.GetPlayObjectLevelList();
  function IsFileInUse(fName : string) : boolean;//判断文件是否在使用
  //var
  //   HFileRes : HFILE;
  begin
     Result := false; //返回值为假(即文件不被使用)
     //20080914 注释,不使用函数
    (* if not FileExists(fName) then exit; //如果文件不存在则退出
     HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0 , nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
     Result := (HFileRes = INVALID_HANDLE_VALUE); //如果CreateFile返回失败 那么Result为真(即文件正在被使用)
     {if not Result then }CloseHandle(HFileRes);//那么关闭句柄 *)
  end;
var
  sHumDBFile, sWarrHum, sWizardHum, sTaosHum, sMaster: string;
  sAllHero, sWarrHero, sWizardHero, sTaosHero: string;
  LoadList: TStringList;
  I:Integer;
  sLineText, sData ,s_Master: string;
  CharName: pTCharName;
  HeroName: pTHeroName;
  nCode: Byte;
begin
  nCode:= 0;
  bo_ReadPlayLeveList:= True;
  try
    EnterCriticalSection(HumanSortCriticalSection);//20080926
    LoadList := TStringList.Create;
    try
      EnterCriticalSection(ProcessHumanCriticalSection);
      try
        nCode:= 1;
        sHumDBFile := g_Config.sSortDir + 'AllHum.DB';
        sWarrHum:=  g_Config.sSortDir + 'WarrHum.DB';
        sWizardHum:= g_Config.sSortDir + 'WizardHum.DB';
        sTaosHum:=  g_Config.sSortDir + 'TaosHum.DB';
        sMaster:=  g_Config.sSortDir + 'Master.DB';
        sAllHero:=  g_Config.sSortDir + 'AllHero.DB';
        sWarrHero:=  g_Config.sSortDir + 'WarrHero.DB';
        sWizardHero:=  g_Config.sSortDir + 'WizardHero.DB';
        sTaosHero:=  g_Config.sSortDir + 'TaosHero.DB';
        nCode:= 2;
        if FileExists(sHumDBFile) and (not IsFileInUse(sHumDBFile)) then begin//人物等级总排行
          LoadList.LoadFromFile(sHumDBFile);
          nCode:= 3;
          if m_PlayObjectLevelList.Count > 0 then begin//20080629
            nCode:= 4;
            for I := m_PlayObjectLevelList.Count - 1 downto 0 do begin //20080527 可读文件,才清空原来的排行数据
              if pTCharName(m_PlayObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTCharName(m_PlayObjectLevelList.Objects[I]));
            end;
            m_PlayObjectLevelList.Clear;
          end;
          nCode:= 5;
          if LoadList.Count > 0 then begin//20090108
            for I := 0 to LoadList.Count - 1 do begin
              sLineText := LoadList.Strings[I];
              if (sLineText <> '') and (sLineText[1] <> ';') then begin
                sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
                New(CharName);
                FillChar(CharName^, SizeOf(TCharName), 0);
                CharName^ := sData;
                m_PlayObjectLevelList.AddObject(sLineText, TObject(CharName));
              end;
            end;
          end;
        end;
        nCode:= 6;
        if FileExists(sWarrHum) and (not IsFileInUse(sWarrHum)) then begin
          LoadList.Clear;
          LoadList.LoadFromFile(sWarrHum);
          nCode:= 7;
          if m_WarrorObjectLevelList.Count > 0 then begin//20080814
            for I := m_WarrorObjectLevelList.Count - 1 downto 0 do begin //20080814 可读文件,才清空原来的排行数据
              if pTCharName(m_WarrorObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTCharName(m_WarrorObjectLevelList.Objects[I]));
            end;
            m_WarrorObjectLevelList.Clear; //战士等级排行
          end;
          nCode:= 8;
          if LoadList.Count > 0 then begin//20090108
            for I := 0 to LoadList.Count - 1 do begin
              sLineText := LoadList.Strings[I];
              if (sLineText <> '') and (sLineText[1] <> ';') then begin
                sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
                New(CharName);
                FillChar(CharName^, SizeOf(TCharName), 0);
                CharName^ := sData;
                m_WarrorObjectLevelList.AddObject(sLineText, TObject(CharName));
              end;
            end;
          end;
        end;
        nCode:= 9;
        if FileExists(sWizardHum) and (not IsFileInUse(sWizardHum)) then begin
          LoadList.Clear;
          LoadList.LoadFromFile(sWizardHum);
          nCode:= 10;
          if m_WizardObjectLevelList.Count > 0 then begin//20080814
            for I := m_WizardObjectLevelList.Count - 1 downto 0  do begin //20080814 可读文件,才清空原来的排行数据
              if pTCharName(m_WizardObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTCharName(m_WizardObjectLevelList.Objects[I]));
            end;
            m_WizardObjectLevelList.Clear; //法师等级排行
          end;
          nCode:= 11;
          if LoadList.Count > 0 then begin//20090108
            for I := 0 to LoadList.Count - 1 do begin
              sLineText := LoadList.Strings[I];
              if (sLineText <> '') and (sLineText[1] <> ';') then begin
                sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
                New(CharName);
                FillChar(CharName^, SizeOf(TCharName), 0);
                CharName^ := sData;
                m_WizardObjectLevelList.AddObject(sLineText, TObject(CharName));
              end;
            end;
          end;
        end;
        nCode:= 12;
        if FileExists(sTaosHum) and (not IsFileInUse(sTaosHum)) then begin
          LoadList.Clear;
          LoadList.LoadFromFile(sTaosHum);
          nCode:= 13;
          if m_TaoistObjectLevelList.Count > 0 then begin//20080814
            for I := m_TaoistObjectLevelList.Count - 1 downto 0 do begin //20080814 可读文件,才清空原来的排行数据
              if pTCharName(m_TaoistObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTCharName(m_TaoistObjectLevelList.Objects[I]));
            end;
            m_TaoistObjectLevelList.Clear; //道士等级排行
          end;
          nCode:= 14;
          if LoadList.Count > 0 then begin//20090108
            for I := 0 to LoadList.Count - 1 do begin
              sLineText := LoadList.Strings[I];
              if (sLineText <> '') and (sLineText[1] <> ';') then begin
                sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
                New(CharName);
                FillChar(CharName^, SizeOf(TCharName), 0);
                CharName^ := sData;
                m_TaoistObjectLevelList.AddObject(sLineText, TObject(CharName));
              end;
            end;
          end;
        end;
        nCode:= 15;
        if FileExists(sMaster) and (not IsFileInUse(sMaster))  then begin
          LoadList.Clear;
          LoadList.LoadFromFile(sMaster);
          nCode:= 16;
          if m_PlayObjectMasterList.Count > 0 then begin//20080629
            for I := m_PlayObjectMasterList.Count - 1 downto 0 do begin
              if pTCharName(m_PlayObjectMasterList.Objects[I]) <> nil then
                 Dispose(pTCharName(m_PlayObjectMasterList.Objects[I]));
            end;
            m_PlayObjectMasterList.Clear; //徒弟数排行
          end;
          nCode:= 17;
          if LoadList.Count > 0 then begin//20090108
            for I := 0 to LoadList.Count - 1 do begin
              sLineText := LoadList.Strings[I];
              if (sLineText <> '') and (sLineText[1] <> ';') then begin
                sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
                New(CharName);
                FillChar(CharName^, SizeOf(TCharName), 0);
                CharName^ := sData;
                m_PlayObjectMasterList.AddObject(sLineText, TObject(CharName));
              end;
            end;
          end;
        end;
        nCode:= 18;
      {$IF HEROVERSION = 1}
        if FileExists(sAllHero) and (not IsFileInUse(sAllHero)) then begin
          LoadList.Clear;
          LoadList.LoadFromFile(sAllHero);
          nCode:= 19;
          if m_HeroObjectLevelList.Count > 0 then begin//20080629
            for I := m_HeroObjectLevelList.Count - 1 downto 0 do begin
              if pTHeroName(m_HeroObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTHeroName(m_HeroObjectLevelList.Objects[I]));
            end;
            m_HeroObjectLevelList.Clear; //英雄等级排行
          end;
          nCode:= 20;
          if LoadList.Count > 0 then begin//20090108
            for I := 0 to LoadList.Count - 1 do begin
              sLineText := LoadList.Strings[I];
              if (sLineText <> '') and (sLineText[1] <> ';') then begin
                sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
                sLineText := GetValidStrCap(sLineText, s_Master, [' ', #9]);
                New(HeroName);
                FillChar(HeroName^, SizeOf(THeroName), 0);
                HeroName^ := sData + #13 + s_Master;
                m_HeroObjectLevelList.AddObject(sLineText, TObject(HeroName));
              end;
            end;
          end;
        end;
        nCode:= 21;
        if FileExists(sWarrHero) and (not IsFileInUse(sWarrHero)) then begin
          LoadList.Clear;
          LoadList.LoadFromFile(sWarrHero);
          nCode:= 22;
          if m_WarrorHeroObjectLevelList.Count > 0 then begin//20090114
            for I := m_WarrorHeroObjectLevelList.Count - 1 downto 0 do begin
              if pTHeroName(m_WarrorHeroObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTHeroName(m_WarrorHeroObjectLevelList.Objects[I]));
            end;
            m_WarrorHeroObjectLevelList.Clear; //英雄战士等级排行
          end;
          nCode:= 23;
          if LoadList.Count > 0 then begin//20090108
            for I := 0 to LoadList.Count - 1 do begin
              sLineText := LoadList.Strings[I];
              if (sLineText <> '') and (sLineText[1] <> ';') then begin
                sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
                sLineText := GetValidStrCap(sLineText, s_Master, [' ', #9]);
                New(HeroName);
                FillChar(HeroName^, SizeOf(THeroName), 0);
                HeroName^ := sData + #13 + s_Master;
                m_WarrorHeroObjectLevelList.AddObject(sLineText, TObject(HeroName));
              end;
            end;
          end;
        end;
        nCode:= 24;
        if FileExists(sWizardHero) and (not IsFileInUse(sWizardHero)) then begin
          LoadList.Clear;
          LoadList.LoadFromFile(sWizardHero);
          nCode:= 25;
          if m_WizardHeroObjectLevelList.Count > 0 then begin//20090114
            for I := m_WizardHeroObjectLevelList.Count - 1 downto 0 do begin
              if pTHeroName(m_WizardHeroObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTHeroName(m_WizardHeroObjectLevelList.Objects[I]));
            end;
            m_WizardHeroObjectLevelList.Clear; //英雄法师等级排行
          end;
          nCode:= 26;
          if LoadList.Count > 0 then begin//20090108
            for I := 0 to LoadList.Count - 1 do begin
              sLineText := LoadList.Strings[I];
              if (sLineText <> '') and (sLineText[1] <> ';') then begin
                sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
                sLineText := GetValidStrCap(sLineText, s_Master, [' ', #9]);
                New(HeroName);
                FillChar(HeroName^, SizeOf(THeroName), 0);
                HeroName^ := sData + #13 + s_Master;
                m_WizardHeroObjectLevelList.AddObject(sLineText, TObject(HeroName));
              end;
            end;
          end;
        end;
        nCode:= 27;
        if FileExists(sTaosHero) and (not IsFileInUse(sTaosHero)) then begin
          LoadList.Clear;
          LoadList.LoadFromFile(sTaosHero);
          nCode:= 30;
          if m_TaoistHeroObjectLevelList.Count > 0 then begin//20090114
            nCode:= 31;
            for I := m_TaoistHeroObjectLevelList.Count - 1 downto 0 do begin
              nCode:= 32;
              if pTHeroName(m_TaoistHeroObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTHeroName(m_TaoistHeroObjectLevelList.Objects[I]));
            end;
            m_TaoistHeroObjectLevelList.Clear; //英雄道士等级排行
          end;
          nCode:= 29;
          if LoadList.Count > 0 then begin//20090108
            for I := 0 to LoadList.Count - 1 do begin
              sLineText := LoadList.Strings[I];
              if (sLineText <> '') and (sLineText[1] <> ';') then begin
                sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);
                sLineText := GetValidStrCap(sLineText, s_Master, [' ', #9]);
                New(HeroName);
                FillChar(HeroName^, SizeOf(THeroName), 0);
                HeroName^ := sData + #13 + s_Master;
                m_TaoistHeroObjectLevelList.AddObject(sLineText, TObject(HeroName));
              end;
            end;
          end;
        end;
      {$IFEND}
      except
        MainOutMessage('{异常} TUserEngine::GetPlayObjectLevelList Code:'+inttostr(nCode));
      end;
    finally
      LoadList.Free;
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
  finally
    LeaveCriticalSection(HumanSortCriticalSection);//20080926
    bo_ReadPlayLeveList:= False;
    dwGetOrderTick := GetTickCount;//重新记时读取间隔 200808029
  end;
end;
//------------------------------------------------------------------------------
(*procedure TUserEngine.GetHumanOrder(); //获取人物排行  20080527 注释
var
  I: Integer;
 // PlayObject: TPlayObject;
 // sCharName: string;
 // CharName: pTCharName;
 // HeroName: pTHeroName;
begin
  try
    EnterCriticalSection(HumanSortCriticalSection);
    for I := 0 to m_PlayObjectLevelList.Count - 1 do begin
      Dispose(pTCharName(m_PlayObjectLevelList.Objects[I]));
    end;
    m_PlayObjectLevelList.Clear; //人物等级总排行

    m_WarrorObjectLevelList.Clear; //战士等级排行
    m_WizardObjectLevelList.Clear; //法师等级排行
    m_TaoistObjectLevelList.Clear; //道士等级排行

    for I := 0 to m_PlayObjectMasterList.Count - 1 do begin
      Dispose(pTCharName(m_PlayObjectMasterList.Objects[I]));
    end;
    m_PlayObjectMasterList.Clear; //徒弟数排行
{$IF HEROVERSION = 1}
    for I := 0 to m_HeroObjectLevelList.Count - 1 do begin
      Dispose(pTHeroName(m_HeroObjectLevelList.Objects[I]));
    end;
    m_HeroObjectLevelList.Clear; //英雄等级排行
    m_WarrorHeroObjectLevelList.Clear; //英雄战士等级排行
    m_WizardHeroObjectLevelList.Clear; //英雄法师等级排行
    m_TaoistHeroObjectLevelList.Clear; //英雄道士等级排行
{$IFEND}
    try
      EnterCriticalSection(ProcessHumanCriticalSection);

      GetPlayObjectLevelList(); //20080220 读取排行榜文件
{      for I := 0 to m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if PlayObject.m_WAbil.Level >= g_Config.nLimitMinOrderLevel then begin //进入排行的最低等级
          New(CharName);
          FillChar(CharName^, SizeOf(TCharName), 0);
          CharName^ := PlayObject.m_sCharName;
          m_PlayObjectLevelList.AddObject(IntToStr(PlayObject.m_WAbil.Level), TObject(CharName));
          case PlayObject.m_btJob of
            0: m_WarrorObjectLevelList.AddObject(IntToStr(PlayObject.m_WAbil.Level), TObject(CharName));
            1: m_WizardObjectLevelList.AddObject(IntToStr(PlayObject.m_WAbil.Level), TObject(CharName));
            2: m_TaoistObjectLevelList.AddObject(IntToStr(PlayObject.m_WAbil.Level), TObject(CharName));
          end;
        end;
        if PlayObject.m_wMasterCount > 0 then begin
          New(CharName);
          FillChar(CharName^, SizeOf(TCharName), 0);
          CharName^ := PlayObject.m_sCharName;
          m_PlayObjectMasterList.AddObject(IntToStr(PlayObject.m_wMasterCount), TObject(CharName));
        end;     }
{$IF HEROVERSION = 1}
       { if (PlayObject.m_MyHero <> nil) and PlayObject.m_boHasHero then begin //英雄排行
          //if PlayObject.m_WAbil.Level >= g_Config.nLimitMinOrderLevel then begin //进入排行的最低等级
          New(HeroName);
          FillChar(HeroName^, SizeOf(THeroName), 0);
          HeroName^ := PlayObject.m_sCharName + #13 + THeroObject(PlayObject.m_MyHero).m_sCharName;
          m_HeroObjectLevelList.AddObject(IntToStr(THeroObject(PlayObject.m_MyHero).m_WAbil.Level), TObject(HeroName));
          case THeroObject(PlayObject.m_MyHero).m_btJob of
            0: m_WarrorHeroObjectLevelList.AddObject(IntToStr(THeroObject(PlayObject.m_MyHero).m_WAbil.Level), TObject(HeroName));
            1: m_WizardHeroObjectLevelList.AddObject(IntToStr(THeroObject(PlayObject.m_MyHero).m_WAbil.Level), TObject(HeroName));
            2: m_TaoistHeroObjectLevelList.AddObject(IntToStr(THeroObject(PlayObject.m_MyHero).m_WAbil.Level), TObject(HeroName));
          end;
          //end;
        end;  }
{$IFEND}      
      //end;    
    finally
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
{   m_PlayObjectLevelList.QuickSort(False); //人物等级排行
    m_WarrorObjectLevelList.QuickSort(False); //战士等级排行
    m_WizardObjectLevelList.QuickSort(False); //法师等级排行
    m_TaoistObjectLevelList.QuickSort(False); //道士等级排行
    m_PlayObjectMasterList.QuickSort(False); //徒弟数排行  }
{$IF HEROVERSION = 1}
   { m_HeroObjectLevelList.QuickSort(False); //英雄等级排行
    m_WarrorHeroObjectLevelList.QuickSort(False); //英雄战士等级排行
    m_WizardHeroObjectLevelList.QuickSort(False); //英雄法师等级排行
    m_TaoistHeroObjectLevelList.QuickSort(False); //英雄道士等级排行}
{$IFEND}
  finally
    LeaveCriticalSection(HumanSortCriticalSection);
  end;
end;  *)

procedure TUserEngine.Initialize;
var
  I: Integer;
  MonGen: pTMonGenInfo;
begin
  MerchantInitialize();
  NPCinitialize();
  if m_MonGenList.Count > 0 then begin//20081008
    for I := 0 to m_MonGenList.Count - 1 do begin
      MonGen := m_MonGenList.Items[I];
      if MonGen <> nil then begin
        MonGen.nRace := GetMonRace(MonGen.sMonName);
      end;
    end;
  end;
end;

function TUserEngine.AddMapMonGenCount(sMapName: string; nMonGenCount: Integer): Integer;
var
  I: Integer;
  MapMonGenCount: pTMapMonGenCount;
  boFound: Boolean;
begin
  Result := -1;
  boFound := False;
  if m_MapMonGenCountList.Count > 0 then begin//20081008
    for I := 0 to m_MapMonGenCountList.Count - 1 do begin
      MapMonGenCount := m_MapMonGenCountList.Items[I];
      if MapMonGenCount <> nil then begin
        if CompareText(MapMonGenCount.sMapName, sMapName) = 0 then begin
          Inc(MapMonGenCount.nMonGenCount, nMonGenCount);
          Result := MapMonGenCount.nMonGenCount;
          boFound := True;
        end;
      end;
    end;//for
  end;
  if not boFound then begin
    New(MapMonGenCount);
    MapMonGenCount.sMapName := sMapName;
    MapMonGenCount.nMonGenCount := nMonGenCount;
    MapMonGenCount.dwNotHumTimeTick := GetTickCount;
    MapMonGenCount.dwMakeMonGenTimeTick := GetTickCount;
    MapMonGenCount.nClearCount := 0;
    MapMonGenCount.boNotHum := True;
    m_MapMonGenCountList.Add(MapMonGenCount);
    Result := MapMonGenCount.nMonGenCount;
  end;
end;

function TUserEngine.GetMapMonGenCount(sMapName: string): pTMapMonGenCount;
var
  I: Integer;
  MapMonGenCount: pTMapMonGenCount;
begin
  Result := nil;
  if m_MapMonGenCountList.Count > 0 then begin//20081008
    for I := 0 to m_MapMonGenCountList.Count - 1 do begin
      MapMonGenCount := m_MapMonGenCountList.Items[I];
      if MapMonGenCount <> nil then begin
        if CompareText(MapMonGenCount.sMapName, sMapName) = 0 then begin
          Result := MapMonGenCount;
          Break;
        end;
      end;
    end;
  end;
end;
//取怪物的种族
function TUserEngine.GetMonRace(sMonName: string): Integer;
var
  I: Integer;
  MonInfo: pTMonInfo;
begin
  Result := -1;
  if MonsterList.Count > 0 then begin//20081008
    for I := 0 to MonsterList.Count - 1 do begin
      MonInfo := MonsterList.Items[I];
      if MonInfo <> nil then begin
        if CompareText(MonInfo.sName, sMonName) = 0 then begin
          Result := MonInfo.btRace;
          Break;
        end;
      end;
    end;
  end;
end;
{//20080313 取怪的种族图像
function TUserEngine.GetMonRaceImg(sMonName: string): Integer;
var
  I: Integer;
  MonInfo: pTMonInfo;
begin
  Result := -1;
  for I := 0 to MonsterList.Count - 1 do begin
    MonInfo := MonsterList.Items[I];
    if MonInfo <> nil then begin
      if CompareText(MonInfo.sName, sMonName) = 0 then begin
        Result := MonInfo.btRaceImg;
        Break;
      end;
    end;
  end;
end;
    if m_TargetCret <> nil then begin //20080313
      case UserEngine.GetMonRaceImg(m_sCharName) of
        70,71:begin
          if (abs(m_nCurrX - m_TargetCret.m_nCurrX) >= 3) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) >= 3) then
           SendRefMsg(RM_LIGHTING, 1 , m_nCurrX, m_nCurrY, Integer(m_TargetCret),'');
         end;
      end;
    end;
 }
//交易NPC初始化
procedure TUserEngine.MerchantInitialize;
var
  I: Integer;
  Merchant: TMerchant;
  sCaption: string;
begin
  sCaption := FrmMain.Caption;
  m_MerchantList.Lock;
  try
    for I := m_MerchantList.Count - 1 downto 0 do begin
      if m_MerchantList.Count <= 0 then Break;//20081008
      Merchant := TMerchant(m_MerchantList.Items[I]);
      if Merchant <> nil then begin
        Merchant.m_PEnvir := g_MapManager.FindMap(Merchant.m_sMapName);
        if Merchant.m_PEnvir <> nil then begin
          Merchant.Initialize;
          if Merchant.m_boAddtoMapSuccess and (not Merchant.m_boIsHide) then begin
            MainOutMessage('交易NPC 初始化失败...' + Merchant.m_sCharName + ' ' + Merchant.m_sMapName + '(' + IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY) + ')');
            m_MerchantList.Delete(I);
            Merchant.Free;
          end else begin
            Merchant.LoadNpcScript();
            Merchant.LoadNPCData();
          end;
        end else begin
          MainOutMessage(Merchant.m_sCharName + '交易NPC 初始化失败... (所在地图不存在)');
          m_MerchantList.Delete(I);
          Merchant.Free;
        end;
        FrmMain.Caption := sCaption + '[正在初始交易NPC(' + IntToStr(m_MerchantList.Count) + '/' + IntToStr(m_MerchantList.Count - I) + ')]';
        //Application.ProcessMessages;
      end;
    end;//for
  finally
    m_MerchantList.UnLock;
  end;
end;

procedure TUserEngine.NPCinitialize;
var
  I: Integer;
  NormNpc: TNormNpc;
begin
  for I := QuestNPCList.Count - 1 downto 0 do begin
    if QuestNPCList.Count <= 0 then Break;//20081008
    NormNpc := TNormNpc(QuestNPCList.Items[I]);
    if NormNpc <> nil then begin
      NormNpc.m_PEnvir := g_MapManager.FindMap(NormNpc.m_sMapName);
      if NormNpc.m_PEnvir <> nil then begin
        NormNpc.Initialize;
        if NormNpc.m_boAddtoMapSuccess and (not NormNpc.m_boIsHide) then begin
          MainOutMessage(NormNpc.m_sCharName + ' Npc 初始化失败... ');
          QuestNPCList.Delete(I);
          NormNpc.Free;
        end else begin
          NormNpc.LoadNpcScript();
        end;
      end else begin
        MainOutMessage(NormNpc.m_sCharName + ' Npc 初始化失败... (npc.PEnvir=nil) ');
        QuestNPCList.Delete(I);
        NormNpc.Free;
      end;
    end;
  end;
end;

function TUserEngine.GetLoadPlayCount: Integer;
begin
  Result := m_LoadPlayList.Count;
end;

function TUserEngine.GetOnlineHumCount: Integer;
begin
  Result := m_PlayObjectList.Count;
end;
//取玩家数量
function TUserEngine.GetUserCount: Integer;
begin
  Result := m_PlayObjectList.Count;
end;
//取自动挂机人物数量
function TUserEngine.GetAutoAddExpPlayCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    if m_PlayObjectList.Count > 0 then begin//20081008
      for I := 0 to m_PlayObjectList.Count - 1 do begin
        if TPlayObject(m_PlayObjectList.Objects[I]).m_boNotOnlineAddExp then Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TUserEngine.ProcessHumans;
  function IsLogined(sAccount, sChrName: string): Boolean;//是否是登录过的账号
  var
    I: Integer;
  begin
    Result := False;
    if FrontEngine.InSaveRcdList(sAccount, sChrName) then begin
      Result := True;
    end else begin
      if m_PlayObjectList.Count > 0 then begin//20081008
        for I := 0 to m_PlayObjectList.Count - 1 do begin
          if (CompareText(TPlayObject(m_PlayObjectList.Objects[I]).m_sUserID, sAccount) = 0) and
            (CompareText(m_PlayObjectList.Strings[I], sChrName) = 0) then begin
            Result := True;
            Break;
          end;
        end;//for
      end;
    end;
  end;

  function MakeNewHuman(UserOpenInfo: pTUserOpenInfo): TPlayObject; //制造新的人物
  var
    PlayObject: TPlayObject;
    Abil: pTAbility;
    Envir: TEnvirnoment;
    nC: Integer;
    SwitchDataInfo: pTSwitchDataInfo;
    Castle: TUserCastle;
  label
    ReGetMap;
  begin
    Result := nil;
    try
      PlayObject := TPlayObject.Create;
     { if not g_Config.boVentureServer then begin //未使用 20080408
        UserOpenInfo.sChrName := '';
        UserOpenInfo.LoadUser.nSessionID := 0;
        SwitchDataInfo := GetSwitchData(UserOpenInfo.sChrName, UserOpenInfo.LoadUser.nSessionID);
      end else SwitchDataInfo := nil;  }

      SwitchDataInfo := nil;

      if SwitchDataInfo = nil then begin
        GetHumData(PlayObject, UserOpenInfo.HumanRcd);
        PlayObject.m_btRaceServer := RC_PLAYOBJECT;
        if PlayObject.m_sHomeMap = '' then begin
          ReGetMap:
          PlayObject.m_sHomeMap := GetHomeInfo(PlayObject.m_nHomeX, PlayObject.m_nHomeY);
          PlayObject.m_sMapName := PlayObject.m_sHomeMap;
          PlayObject.m_nCurrX := GetRandHomeX(PlayObject);
          PlayObject.m_nCurrY := GetRandHomeY(PlayObject);
          if PlayObject.m_Abil.Level >= 0 then begin
            Abil := @PlayObject.m_Abil;
            Abil.Level := 1;
            Abil.AC := 0;
            Abil.MAC := 0;
            Abil.DC := MakeLong(1, 2);
            Abil.MC := MakeLong(1, 2);
            Abil.SC := MakeLong(1, 2);
            Abil.MP := 15;
            Abil.HP := 15;
            Abil.MaxHP := 15;
            Abil.MaxMP := 15;
            Abil.Exp := 10;
            Abil.MaxExp := 100;
            Abil.Weight := 100;
            Abil.MaxWeight := 100;
            PlayObject.m_boNewHuman := True;
          end;
        end;
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        if Envir <> nil then begin
          if Envir.m_boFight3Zone then begin //是否在行会战争地图死亡
            if (PlayObject.m_Abil.HP <= 0) and (PlayObject.m_nFightZoneDieCount < 3) then begin
              PlayObject.m_Abil.HP := PlayObject.m_Abil.MaxHP;
              PlayObject.m_Abil.MP := PlayObject.m_Abil.MaxMP;
              PlayObject.m_boDieInFight3Zone := True;
            end else PlayObject.m_nFightZoneDieCount := 0;
          end;
        end;

        PlayObject.m_MyGuild := g_GuildManager.MemberOfGuild(PlayObject.m_sCharName);//取玩家所属的行会
        Castle := g_CastleManager.InCastleWarArea(Envir, PlayObject.m_nCurrX, PlayObject.m_nCurrY);
        {
        if (Envir <> nil) and ((UserCastle.m_MapPalace = Envir) or
          (UserCastle.m_boUnderWar and UserCastle.InCastleWarArea(PlayObject.m_PEnvir,PlayObject.m_nCurrX,PlayObject.m_nCurrY))) then begin
        }
        if (Envir <> nil) and (Castle <> nil) and ((Castle.m_MapPalace = Envir) or Castle.m_boUnderWar) then begin
          Castle := g_CastleManager.IsCastleMember(PlayObject);

          //if not UserCastle.IsMember(PlayObject) then begin
          if Castle = nil then begin
            PlayObject.m_sMapName := PlayObject.m_sHomeMap;
            PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
            PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
          end else begin
            {
            if UserCastle.m_MapPalace = Envir then begin
              PlayObject.m_sMapName:=UserCastle.GetMapName();
              PlayObject.m_nCurrX:=UserCastle.GetHomeX;
              PlayObject.m_nCurrY:=UserCastle.GetHomeY;
            end;
            }
            if Castle.m_MapPalace = Envir then begin
              PlayObject.m_sMapName := Castle.GetMapName();
              PlayObject.m_nCurrX := Castle.GetHomeX;
              PlayObject.m_nCurrY := Castle.GetHomeY;
            end;
          end;
        end;

        {if (PlayObject.nC4 <= 1) and (PlayObject.m_Abil.Level >= 1) then//20081007 注释，nC4无实际用处
          PlayObject.nC4 := 2; }
        if g_MapManager.FindMap(PlayObject.m_sMapName) = nil then
          PlayObject.m_Abil.HP := 0;
        if PlayObject.m_Abil.HP <= 0 then begin
          PlayObject.ClearStatusTime();
          if PlayObject.PKLevel < 2 then begin//没有红名
            Castle := g_CastleManager.IsCastleMember(PlayObject);
            // if UserCastle.m_boUnderWar and (UserCastle.IsMember(PlayObject)) then begin
            if (Castle <> nil) and Castle.m_boUnderWar then begin
              PlayObject.m_sMapName := Castle.m_sHomeMap;
              PlayObject.m_nCurrX := Castle.GetHomeX;
              PlayObject.m_nCurrY := Castle.GetHomeY;
            end else begin
              PlayObject.m_sMapName := PlayObject.m_sHomeMap;
              PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
              PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
            end;
          end else begin
            PlayObject.m_sMapName := g_Config.sRedDieHomeMap {'3'};
            PlayObject.m_nCurrX := Random(13) + g_Config.nRedDieHomeX {839};
            PlayObject.m_nCurrY := Random(13) + g_Config.nRedDieHomeY {668};
          end;
          PlayObject.m_Abil.HP := 14;
        end;

        PlayObject.AbilCopyToWAbil();
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        if Envir = nil then begin
          PlayObject.m_nSessionID := UserOpenInfo.LoadUser.nSessionID;
          PlayObject.m_nSocket := UserOpenInfo.LoadUser.nSocket;
          PlayObject.m_nGateIdx := UserOpenInfo.LoadUser.nGateIdx;
          PlayObject.m_nGSocketIdx := UserOpenInfo.LoadUser.nGSocketIdx;
          PlayObject.m_WAbil := PlayObject.m_Abil;
          PlayObject.m_nServerIndex := g_MapManager.GetMapOfServerIndex(PlayObject.m_sMapName);
          SendSwitchData(PlayObject, PlayObject.m_nServerIndex);
          SendChangeServer(PlayObject, PlayObject.m_nServerIndex);
          //PlayObject.Free;
          FreeAndNil(PlayObject);
          Exit;
        end;
        nC := 0;
        while (True) do begin
          if Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) then Break;
          PlayObject.m_nCurrX := PlayObject.m_nCurrX - 3 + Random(6);
          PlayObject.m_nCurrY := PlayObject.m_nCurrY - 3 + Random(6);
          Inc(nC);
          if nC >= 5 then Break;
        end;

        if not Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) then begin
          PlayObject.m_sMapName := g_Config.sHomeMap;
          Envir := g_MapManager.FindMap(g_Config.sHomeMap);
          PlayObject.m_nCurrX := g_Config.nHomeX;
          PlayObject.m_nCurrY := g_Config.nHomeY;
        end;

        PlayObject.m_PEnvir := Envir;
        if PlayObject.m_PEnvir = nil then begin
          MainOutMessage('[错误] PlayObject.PEnvir = nil');
          goto ReGetMap;
        end else begin
          PlayObject.m_boReadyRun := False;
        end;
      end else begin
        GetHumData(PlayObject, UserOpenInfo.HumanRcd);
        PlayObject.m_sMapName := SwitchDataInfo.sMAP;
        PlayObject.m_nCurrX := SwitchDataInfo.wX;
        PlayObject.m_nCurrY := SwitchDataInfo.wY;
        PlayObject.m_Abil := SwitchDataInfo.Abil;
        PlayObject.m_WAbil := SwitchDataInfo.Abil;
        LoadSwitchData(SwitchDataInfo, PlayObject);
        DelSwitchData(SwitchDataInfo);
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        if Envir <> nil then begin
          PlayObject.m_sMapName := g_Config.sHomeMap;
          //Envir := g_MapManager.FindMap(g_Config.sHomeMap); //20080408 没有使用
          PlayObject.m_nCurrX := g_Config.nHomeX;
          PlayObject.m_nCurrY := g_Config.nHomeY;
        end else begin
          if not Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) then begin
            PlayObject.m_sMapName := g_Config.sHomeMap;
            Envir := g_MapManager.FindMap(g_Config.sHomeMap);
            PlayObject.m_nCurrX := g_Config.nHomeX;
            PlayObject.m_nCurrY := g_Config.nHomeY;
          end;
          PlayObject.AbilCopyToWAbil();
          PlayObject.m_PEnvir := Envir;
          if PlayObject.m_PEnvir = nil then begin
            MainOutMessage('[错误] PlayObject.PEnvir = nil');
            goto ReGetMap;
          end else begin
            PlayObject.m_boReadyRun := False;
            PlayObject.m_boLoginNoticeOK := True;
            PlayObject.bo6AB := True;
          end;
        end;
      end;
      PlayObject.m_sUserID := UserOpenInfo.LoadUser.sAccount;
      PlayObject.m_sIPaddr := UserOpenInfo.LoadUser.sIPaddr;
      PlayObject.m_sIPLocal := GetIPLocal(PlayObject.m_sIPaddr);
      PlayObject.m_nSocket := UserOpenInfo.LoadUser.nSocket;
      PlayObject.m_nGSocketIdx := UserOpenInfo.LoadUser.nGSocketIdx;
      PlayObject.m_nGateIdx := UserOpenInfo.LoadUser.nGateIdx;
      PlayObject.m_nSessionID := UserOpenInfo.LoadUser.nSessionID;
      PlayObject.m_nPayMent := UserOpenInfo.LoadUser.nPayMent;
      PlayObject.m_nPayMode := UserOpenInfo.LoadUser.nPayMode;
      //PlayObject.m_dwLoadTick := UserOpenInfo.LoadUser.dwNewUserTick; //未使用 20080329
      PlayObject.m_nSoftVersionDateEx := GetExVersionNO(UserOpenInfo.LoadUser.nSoftVersionDate, PlayObject.m_nSoftVersionDate);
      Result := PlayObject;
    except
      MainOutMessage('{异常} TUserEngine::MakeNewHuman');
    end;
  end;
//type //20080815 注释
//  TGetLicense = function(var nProVersion: Integer; var UserLicense: Integer; var ErrorCode: Integer): Integer; stdcall;
var
  dwUsrRotTime: LongWord;
  dwCheckTime: LongWord;
  dwCurTick: LongWord;
  nCheck30: Byte;
  boCheckTimeLimit: Boolean;
  nIdx: Integer;
  PlayObject: TPlayObject;
  I: Integer;
  UserOpenInfo: pTUserOpenInfo;
  GoldChangeInfo: pTGoldChangeInfo;
  LineNoticeMsg: string;
  //THeroDataInfo:pTHeroDataInfo;
(*nM2Crc: Integer;
  m_nUserLicense: Integer;//使用许可数
  m_nCheckServerCode: Integer;//检查服务器代码
  m_nErrorCode: Integer;
  m_nProVersion: Integer;
  sUserKey: string;
  sCheckCode: string;*)
begin
if m_boHumProcess then Exit;//20080717 检查过程是否重入
m_boHumProcess:= True;//20080717 检查过程是否重入
try
  nCheck30 := 0;
  dwCheckTime := GetTickCount();
  if (GetTickCount - m_dwProcessLoadPlayTick) > 200 then begin
    nCheck30 := 21;
    m_dwProcessLoadPlayTick := GetTickCount();
    try
      EnterCriticalSection(m_LoadPlaySection);
      try
        if m_LoadPlayList.Count > 0 then begin//20081008
          for I := 0 to m_LoadPlayList.Count - 1 do begin
            nCheck30 := 22;
            UserOpenInfo := pTUserOpenInfo(m_LoadPlayList.Objects[I]);
            if not UserOpenInfo.LoadUser.boIsHero then begin
              nCheck30 := 23;
              if not FrontEngine.IsFull and not IsLogined(UserOpenInfo.sAccount, m_LoadPlayList.Strings[I]) then begin
                nCheck30 := 24;
                PlayObject := MakeNewHuman(UserOpenInfo);//制造新的人物
                if PlayObject <> nil then begin
                  nCheck30 := 25;
                  PlayObject.m_boClientFlag := UserOpenInfo.LoadUser.boClinetFlag; //将客户端标志传到人物数据中
                  m_PlayObjectList.AddObject(m_LoadPlayList.Strings[I], PlayObject);
                  SendServerGroupMsg(SS_201, nServerIndex, PlayObject.m_sCharName);
                  nCheck30 := 26;
                  m_NewHumanList.Add(PlayObject);
                end;
              end else begin
                nCheck30 := 27;
                KickOnlineUser(m_LoadPlayList.Strings[I]);///踢出在线人物
                m_ListOfGateIdx.Add(Pointer(UserOpenInfo.LoadUser.nGateIdx));
                m_ListOfSocket.Add(Pointer(UserOpenInfo.LoadUser.nSocket));
              end;
            end else begin
  {$IF HEROVERSION = 1}
              nCheck30 := 28;
              if UserOpenInfo.LoadUser.PlayObject <> nil then begin //开始召唤英雄
                PlayObject := GetPlayObject(TBaseObject(UserOpenInfo.LoadUser.PlayObject));
                nCheck30 := 29;
                if PlayObject <> nil then begin
                  case UserOpenInfo.LoadUser.btLoadDBType of
                    0: begin //召唤
                        nCheck30 := 30;
                        if UserOpenInfo.nOpenStatus = 1 then begin
                          PlayObject.m_MyHero := PlayObject.MakeHero(PlayObject, UserOpenInfo.HumanRcd);
                          if PlayObject.m_MyHero <> nil then begin
                            nCheck30 := 31;
                            THeroObject(PlayObject.m_MyHero).Login;//英雄登录
                            PlayObject.m_MyHero.m_btAttatckMode:= PlayObject.m_btAttatckMode;//与主人的攻击模式一致，以修正宝宝可以正常攻击目标 20090113
                            PlayObject.m_MyHero.SendRefMsg(RM_CREATEHERO, PlayObject.m_MyHero.m_btDirection, PlayObject.m_MyHero.m_nCurrX, PlayObject.m_MyHero.m_nCurrY, 0, ''); //刷新客户端，创建英雄信息
                            PlayObject.SendMsg(PlayObject, RM_RECALLHERO, 0, Integer(PlayObject.m_MyHero), 0, 0, '');
                            PlayObject.n_myHeroTpye:= THeroObject(PlayObject.m_MyHero).n_HeroTpye;//20080515 英雄的类型
                            case THeroObject(PlayObject.m_MyHero).m_btStatus of
                              1: begin
                                  //THeroObject(PlayObject.m_MyHero).SysMsg('(英雄) 忠诚度为'+floattostr(THeroObject(PlayObject.m_MyHero).m_nLoyal / 100)+'%', c_Green, t_Hint);//20090114 取消忠城度提示
                                  THeroObject(PlayObject.m_MyHero).SysMsg( g_sHeroFollow, c_Green, t_Hint);//20080316
                                end;
                              0: begin
                                  //THeroObject(PlayObject.m_MyHero).SysMsg('(英雄) 忠诚度为'+floattostr(THeroObject(PlayObject.m_MyHero).m_nLoyal / 100)+'%', c_Green, t_Hint);//20090114 取消忠城度提示
                                  THeroObject(PlayObject.m_MyHero).SysMsg( g_sHeroAttack, c_Green, t_Hint);//20080316
                                end;
                              2: begin
                                  //THeroObject(PlayObject.m_MyHero).SysMsg('(英雄) 忠诚度为'+floattostr(THeroObject(PlayObject.m_MyHero).m_nLoyal / 100)+'%', c_Green, t_Hint);//20090114 取消忠城度提示
                                  THeroObject(PlayObject.m_MyHero).SysMsg( g_sHeroRest, c_Green, t_Hint);//20080316
                                end;
                            end;
                            THeroObject(PlayObject.m_MyHero).SysMsg(g_sHeroLoginMsg, c_Green, t_Hint);
                            if THeroObject(PlayObject.m_MyHero).m_boTrainingNG then begin//学过内功
                              THeroObject(PlayObject.m_MyHero).m_MaxExpSkill69:= THeroObject(PlayObject.m_MyHero).GetSkill69Exp(THeroObject(PlayObject.m_MyHero).m_NGLevel, THeroObject(PlayObject.m_MyHero).m_Skill69MaxNH);//登录重新取内功心法升级经验 20081002
                              THeroObject(PlayObject.m_MyHero).SendMsg(PlayObject.m_MyHero, RM_HEROMAGIC69SKILLEXP, 0, 0, 0, THeroObject(PlayObject.m_MyHero).m_NGLevel, EncodeString(Inttostr(THeroObject(PlayObject.m_MyHero).m_ExpSkill69)+'/'+Inttostr(THeroObject(PlayObject.m_MyHero).m_MaxExpSkill69)));
                              THeroObject(PlayObject.m_MyHero).SendMsg(PlayObject.m_MyHero, RM_MAGIC69SKILLNH, 0, THeroObject(PlayObject.m_MyHero).m_Skill69NH, THeroObject(PlayObject.m_MyHero).m_Skill69MaxNH, 0, ''); //内力值让别人看到 20081002
                            end;
                          end;
                        end;
                      end;
                    1: begin //新建
                        nCheck30 := 32;
                        case UserOpenInfo.nOpenStatus of
                          1: begin
                              case PlayObject.n_tempHeroTpye of//20080519
                                0:PlayObject.m_boHasHero := True;
                                1:PlayObject.m_boHasHeroTwo:= True;
                              end;
                              if g_FunctionNPC <> nil then begin
                                g_FunctionNPC.GotoLable(PlayObject, '@CreateHeroOK', False);
                              end;
                            end;
                          2: begin
                              case PlayObject.n_tempHeroTpye of//20080519
                                0:PlayObject.m_boHasHero := False;
                                1:PlayObject.m_boHasHeroTwo:= False;
                              end;
                              PlayObject.m_sHeroCharName := '';
                              if g_FunctionNPC <> nil then begin
                                g_FunctionNPC.GotoLable(PlayObject, '@HeroNameExists', False);
                              end;
                            end;
                          3: begin
                              case PlayObject.n_tempHeroTpye of//20080519
                                0:PlayObject.m_boHasHero := False;
                                1:PlayObject.m_boHasHeroTwo:= False;
                              end;
                              PlayObject.m_sHeroCharName := '';
                              if g_FunctionNPC <> nil then begin
                                g_FunctionNPC.GotoLable(PlayObject, '@HeroOverChrCount', False);
                              end;
                            end;
                        else begin
                            nCheck30 := 33;
                            case PlayObject.n_tempHeroTpye of//20080519
                              0:PlayObject.m_boHasHero := False;
                              1:PlayObject.m_boHasHeroTwo:= False;
                            end;
                            PlayObject.m_sHeroCharName := '';
                            if g_FunctionNPC <> nil then begin
                              g_FunctionNPC.GotoLable(PlayObject, '@CreateHeroFail', False);
                            end;
                          end;
                        end;
                      end;
                    2: begin //删除英雄
                        nCheck30 := 34;
                        if UserOpenInfo.nOpenStatus = 1 then begin
                          case PlayObject.n_myHeroTpye of//20080519
                            0: begin
                              PlayObject.m_boHasHero := False;
                            end;
                            1: begin
                              PlayObject.m_boHasHeroTwo:= False;
                            end;
                          end;
                          PlayObject.m_sHeroCharName := '';
                          PlayObject.n_myHeroTpye:= 3;//英雄的类型 20080515
                          if g_FunctionNPC <> nil then begin
                            g_FunctionNPC.GotoLable(PlayObject, '@DeleteHeroOK', False);
                          end;
                        end else begin
                          if g_FunctionNPC <> nil then begin
                            g_FunctionNPC.GotoLable(PlayObject, '@DeleteHeroFail', False);
                          end;
                        end;
                      end;
                    3: begin//查询英雄相关数据 20080514
                         nCheck30 := 35;
                         if UserOpenInfo.LoadUser.sMsg <> '' then begin
                           PlayObject.SendMsg(PlayObject, RM_GETHEROINFO, 0, 0, 0, 0, UserOpenInfo.LoadUser.sMsg);
                       end;
                     end;
                  end;
                  PlayObject.m_boWaitHeroDate := False;
                end;
              end;
  {$IFEND}
            end;
            nCheck30 := 36;
            Dispose(pTUserOpenInfo(m_LoadPlayList.Objects[I]));
          end;
          nCheck30 := 37;
          m_LoadPlayList.Clear;
        end;
        if m_ChangeHumanDBGoldList.Count > 0 then begin//20081008
          for I := 0 to m_ChangeHumanDBGoldList.Count - 1 do begin
            nCheck30 := 38;
            GoldChangeInfo := m_ChangeHumanDBGoldList.Items[I];
            PlayObject := GetPlayObject(GoldChangeInfo.sGameMasterName);
            if PlayObject <> nil then
              PlayObject.GoldChange(GoldChangeInfo.sGetGoldUser, GoldChangeInfo.nGold);
            nCheck30 := 39;
            Dispose(GoldChangeInfo);
          end;
          nCheck30 := 40;
          m_ChangeHumanDBGoldList.Clear;
        end;
      finally
        LeaveCriticalSection(m_LoadPlaySection);
      end;
      nCheck30 := 41;
      if m_NewHumanList.Count > 0 then begin//20081008
        for I := 0 to m_NewHumanList.Count - 1 do begin
          nCheck30 := 42;
          RunSocket.SetGateUserList(PlayObject.m_nGateIdx, PlayObject.m_nSocket, PlayObject);
        end;
        nCheck30 := 44;
        m_NewHumanList.Clear;
      end;
      nCheck30 := 45;
      if m_ListOfGateIdx.Count > 0 then begin//20081008
        for I := 0 to m_ListOfGateIdx.Count - 1 do begin
          nCheck30 := 46;
          RunSocket.CloseUser(Integer(m_ListOfGateIdx.Items[I]), Integer(m_ListOfSocket.Items[I])); //GateIdx,nSocket
        end;
        nCheck30 := 47;
        m_ListOfGateIdx.Clear;
      end;
      nCheck30 := 48;
      m_ListOfSocket.Clear;
    except
      on E: Exception do begin
        MainOutMessage('{异常} TUserEngine::ProcessHumans -> Ready, Save, Load... Code:'+IntToStr(nCheck30));
      end;
    end;
  end;
  try
    if m_PlayObjectFreeList.Count > 0 then begin//20081008
      for I := 0 to m_PlayObjectFreeList.Count - 1 do begin
        PlayObject := TPlayObject(m_PlayObjectFreeList.Items[I]);
        if (GetTickCount - PlayObject.m_dwGhostTick) > g_Config.dwHumanFreeDelayTime {5 * 60 * 1000} then begin
          try
            //TPlayObject(m_PlayObjectFreeList.Items[I]).Free;
            if PlayObject <> nil then begin//20080821 修改
              PlayObject.Free;
              PlayObject:= nil;
            end;
          except
            MainOutMessage('{异常} TUserEngine::ProcessHumans ClosePlayer.Delete - Free');
          end;
          m_PlayObjectFreeList.Delete(I);
          Break;
        end else begin
          if PlayObject.m_boSwitchData and (PlayObject.m_boRcdSaved) then begin
            if SendSwitchData(PlayObject, PlayObject.m_nServerIndex) or (PlayObject.m_nWriteChgDataErrCount > 20) then begin
              PlayObject.m_boSwitchData := False;
              PlayObject.m_boSwitchDataSended := True;
              PlayObject.m_dwChgDataWritedTick := GetTickCount();
            end else Inc(PlayObject.m_nWriteChgDataErrCount);
          end;
          if PlayObject.m_boSwitchDataSended and ((GetTickCount - PlayObject.m_dwChgDataWritedTick) > 100) then begin
            PlayObject.m_boSwitchDataSended := False;
            SendChangeServer(PlayObject, PlayObject.m_nServerIndex);
          end;
        end;
      end;//for
    end;
  except
    MainOutMessage('{异常} TUserEngine::ProcessHumans ClosePlayer.Delete');
  end;
  {===================================重新获取授权===============================}
  try
    if ((GetTickCount - m_dwSearchTick) > 3600000{1000 * 60 * 60}) or (m_TodayDate <> Date) then begin
      m_TodayDate := Date;
      HeroAddSkill(FrmMain.Caption);//20080603 //判断M2标题是否被破解修改
      m_dwSearchTick := GetTickCount;//GetTickCount()用于获取自windows启动以来经历的时间长度（毫秒）
(*      m_nCheckServerCode := 1000;
      m_nUserLicense := 0;
      nM2Crc := 0;          //20080210 实现免费版
      Inc(nCrackedLevel, 5);
      if (g_nGetLicenseInfo >= 0) and Assigned(PlugProcArray[g_nGetLicenseInfo].nProcAddr) then begin
{$IF TESTMODE = 1}
        MainOutMessage('nCrackedLevel_1 ' + IntToStr(nCrackedLevel));
{$IFEND}
        Dec(nCrackedLevel);
        m_nCheckServerCode := 1001;
        nM2Crc := TGetLicense(PlugProcArray[g_nGetLicenseInfo].nProcAddr)(m_nProVersion, m_nUserLicense, m_nErrorCode);//读取许可信息,即限制总人数,及使用次数或日期
        //Inc(nErrorLevel, m_nErrorCode); 20071229 去掉
        m_nCheckServerCode := 1002;
        m_nLimitNumber := LoWord(m_nUserLicense); //许可限制使用天数或次数
        m_nLimitUserCount := LoWord(m_nErrorCode); //20071110 许可用户数
        if (m_nProVersion = nProductVersion) and (nProductVersion <> 0) then Dec(nCrackedLevel);
        m_nCheckServerCode := 1003;
        if Decode(sUserQQKey, sUserKey) then Dec(nCrackedLevel);
        m_nCheckServerCode := 1004;
        if Str_ToInt(sUserKey, 0) = nUserLicense then Dec(nCrackedLevel);
        m_nCheckServerCode := 1005;
        if m_nCheckServerCode = 1005 then Dec(nCrackedLevel);
{$IF TESTMODE = 1}
        MainOutMessage('nM2Crc ' + IntToStr(nM2Crc));
        MainOutMessage('sUserKey ' + sUserKey);
        MainOutMessage('nCrackedLevel_2 ' + IntToStr(nCrackedLevel));
        MainOutMessage('m_nLimitNumber  ' + IntToStr(m_nLimitNumber));
        MainOutMessage('m_nLimitUserCount  ' + IntToStr(m_nLimitUserCount));
        MainOutMessage('m_nProVersion  ' + IntToStr(m_nProVersion));
        MainOutMessage('nErrorLevel  ' + IntToStr(nErrorLevel));
{$IFEND}
      end else begin
{$IF TESTMODE = 1}
        MainOutMessage('g_nGetLicenseInfo < 0');
{$IFEND}
      end;
{$IF TESTMODE = 1}
      MainOutMessage('nCrackedLevel ' + IntToStr(nCrackedLevel));
      MainOutMessage('nErrorLevel ' + IntToStr(nErrorLevel));
{$IFEND}
          *)
        m_nLimitNumber := 1000000; //20080210 实现免费版
        m_nLimitUserCount := 1000000; //20080210 实现免费版
    end;
  except
    MainOutMessage('{异常} TUserEngine::GetLicense');
  end;
{--------------------------------------------------------------------------------}
  boCheckTimeLimit := False;
  try
    dwCurTick := GetTickCount();
    nIdx := m_nProcHumIDx;
    while True do begin
      if m_PlayObjectList.Count <= nIdx then Break;
      PlayObject := TPlayObject(m_PlayObjectList.Objects[nIdx]);
      if PlayObject <> nil then begin
        if PlayObject.m_btRaceServer <> RC_PLAYOBJECT then Break;//20080901 不是人物则退出
        if Integer(dwCurTick - PlayObject.m_dwRunTick) > PlayObject.m_nRunTime then begin
          PlayObject.m_dwRunTick := dwCurTick;
          if not PlayObject.m_boGhost then begin
            if not PlayObject.m_boLoginNoticeOK then begin
              try
                PlayObject.RunNotice();//运行游戏忠告,即将进入游戏时的提示框
              except
                MainOutMessage('{异常} TUserEngine::ProcessHumans RunNotice');
              end;
            end else begin
              try
                if not PlayObject.m_boReadyRun then begin//是否进入游戏完成
                  PlayObject.m_boReadyRun := True;
                  //PlayObject.m_boNotOnlineAddExp := False;//20080522
                  PlayObject.UserLogon;//人物登录游戏
                  if PlayObject.m_boNotOnlineAddExp then begin//人物在挂机状态 20080523
                     PlayObject.m_boNotOnlineAddExp := False;
                     PlayObject.m_boPlayOffLine := False;//不下线触发 20080716
                     if g_ManageNPC <> nil then  g_ManageNPC.GotoLable(PlayObject, '@RESUME', False); //人物在挂机状态,让人物小退
                  end;
                end else begin
                  if (GetTickCount() - PlayObject.m_dwSearchTick) > PlayObject.m_dwSearchTime then begin
                    PlayObject.m_dwSearchTick := GetTickCount();
                    nCheck30 := 10;
                    PlayObject.SearchViewRange;//搜索对像
                    nCheck30 := 11;
                    PlayObject.GameTimeChanged;//游戏时间改变
                  end;
                end;
                if (GetTickCount() - PlayObject.m_dwShowLineNoticeTick) > g_Config.dwShowLineNoticeTime then begin
                  PlayObject.m_dwShowLineNoticeTick := GetTickCount();
                  if LineNoticeList.Count > PlayObject.m_nShowLineNoticeIdx then begin
                    LineNoticeMsg := g_ManageNPC.GetLineVariableText(PlayObject, LineNoticeList.Strings[PlayObject.m_nShowLineNoticeIdx]);
                    nCheck30 := 13;
                    case LineNoticeMsg[1] of
                      'R': PlayObject.SysMsg(Copy(LineNoticeMsg, 2, Length(LineNoticeMsg) - 1), c_Red, t_Notice);
                      'G': PlayObject.SysMsg(Copy(LineNoticeMsg, 2, Length(LineNoticeMsg) - 1), c_Green, t_Notice);
                      'B': PlayObject.SysMsg(Copy(LineNoticeMsg, 2, Length(LineNoticeMsg) - 1), c_Blue, t_Notice);
                      else PlayObject.SysMsg(LineNoticeMsg, TMsgColor(g_Config.nLineNoticeColor), t_Notice);
                    end;
                  end;
                  Inc(PlayObject.m_nShowLineNoticeIdx);
                  if (LineNoticeList.Count <= PlayObject.m_nShowLineNoticeIdx) then
                    PlayObject.m_nShowLineNoticeIdx := 0;
                end;
                nCheck30 := 14;
                PlayObject.Run();
                nCheck30 := 15;
                if not FrontEngine.IsFull and ((GetTickCount() - PlayObject.m_dwSaveRcdTick) > g_Config.dwSaveHumanRcdTime) then begin
                  nCheck30 := 16;
                  PlayObject.m_dwSaveRcdTick := GetTickCount();
                  nCheck30 := 17;
                  PlayObject.DealCancelA();
                  nCheck30 := 18;
                  SaveHumanRcd(PlayObject);
{$IF HEROVERSION = 1}
                  nCheck30 := 19;
                  SaveHeroRcd(PlayObject);//保存英雄数据
{$IFEND}
                end;
              except
                on E: Exception do begin
                  MainOutMessage('{异常} TUserEngine::ProcessHumans Human.Operate Code:'+inttostr(nCheck30)+' Name:'+PlayObject.m_sCharName);
                  PlayObject.KickException;//踢除异常 20090103
                end;
              end;
            end;
          end else begin //if not PlayObject.m_boGhost then begin
            try
              m_PlayObjectList.Delete(nIdx);
              nCheck30 := 2;
              PlayObject.Disappear();
              nCheck30 := 3;
            except
              on E: Exception do begin
                MainOutMessage('{异常} TUserEngine::ProcessHumans Human.Finalize Code:'+ IntToStr(nCheck30));
              end;
            end;
            try
              nCheck30 := 4;
              PlayObject.DealCancelA();
              nCheck30 := 5;
              SaveHumanRcd(PlayObject);
{$IF HEROVERSION = 1}
              nCheck30 := 6;
              SaveHeroRcd(PlayObject);//保存英雄数据
{$IFEND}
              AddToHumanFreeList(PlayObject);//20090106 换位置
              nCheck30 := 7;
              if (not PlayObject.m_boReconnection) then begin//20090102 非重新连接才关闭
                RunSocket.CloseUser(PlayObject.m_nGateIdx, PlayObject.m_nSocket);
              end;
            except
              MainOutMessage('{异常} TUserEngine::ProcessHumans RunSocket.CloseUser Code:'+ IntToStr(nCheck30));
            end;
            SendServerGroupMsg(SS_202, nServerIndex, PlayObject.m_sCharName);
            Continue;
          end;
        end; //if (dwTime14 - PlayObject.dw368) > PlayObject.dw36C then begin
        Inc(nIdx);
        if (GetTickCount - dwCheckTime) > g_dwHumLimit then begin
          boCheckTimeLimit := True;
          m_nProcHumIDx := nIdx;
          Break;
        end;
      end; //while True do begin
    end;
    if not boCheckTimeLimit then m_nProcHumIDx := 0;
  except
    MainOutMessage('{异常} TUserEngine::ProcessHumans');
  end;
  //Inc(nProcessHumanLoopTime);//20080815 注释
  //g_nProcessHumanLoopTime := nProcessHumanLoopTime;//20080815 注释
  Inc(g_nProcessHumanLoopTime);//20080815
  if m_nProcHumIDx = 0 then begin
    //nProcessHumanLoopTime := 0;//20080815 注释
    //g_nProcessHumanLoopTime := nProcessHumanLoopTime; //20080815 注释
    g_nProcessHumanLoopTime := 0;//20080815
    dwUsrRotTime := GetTickCount - g_dwUsrRotCountTick;
    dwUsrRotCountMin := dwUsrRotTime;
    g_dwUsrRotCountTick := GetTickCount();
    if dwUsrRotCountMax < dwUsrRotTime then dwUsrRotCountMax := dwUsrRotTime;
  end;
  g_nHumCountMin := GetTickCount - dwCheckTime;
  if g_nHumCountMax < g_nHumCountMin then g_nHumCountMax := g_nHumCountMin;
 finally 
   m_boHumProcess:= False;//20080717 检查过程是否重入
 end;
end;

{//是否是交易NPC(未使用)
function TUserEngine.InMerchantList(Merchant: TMerchant): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to m_MerchantList.Count - 1 do begin
    if (Merchant <> nil) and (TMerchant(m_MerchantList.Items[I]) = Merchant) then begin
      Result := True;
      Break;
    end;
  end;
end;}

procedure TUserEngine.ProcessMerchants;
var
  dwRunTick, dwCurrTick: LongWord;
  I: Integer;
  MerchantNPC: TMerchant;
  boProcessLimit: Boolean;
begin
  dwRunTick := GetTickCount();
  boProcessLimit := False;
  try
    dwCurrTick := GetTickCount();
    m_MerchantList.Lock;
    try
      I := nMerchantPosition;
      while True do begin // for i := nMerchantPosition to m_MerchantList.Count - 1 do begin
        if m_MerchantList.Count <= I then Break;
        MerchantNPC := m_MerchantList.Items[I];
        if MerchantNPC <> nil then begin
          if not MerchantNPC.m_boGhost then begin
            if Integer(dwCurrTick - MerchantNPC.m_dwRunTick) > MerchantNPC.m_nRunTime then begin
              if (GetTickCount - MerchantNPC.m_dwSearchTick) > MerchantNPC.m_dwSearchTime then begin
                MerchantNPC.m_dwSearchTick := GetTickCount();
                MerchantNPC.SearchViewRange();
              end;
              if Integer(dwCurrTick - MerchantNPC.m_dwRunTick) > MerchantNPC.m_nRunTime then begin
                MerchantNPC.m_dwRunTick := dwCurrTick;
                MerchantNPC.Run;
              end;
            end;
          end else begin
            if (GetTickCount - MerchantNPC.m_dwGhostTick) > 60000{60 * 1000} then begin
              MerchantNPC.Free;
              m_MerchantList.Delete(I);
              Break;
            end;
          end;
        end;
        if (GetTickCount - dwRunTick) > g_dwNpcLimit then begin
          nMerchantPosition := I;
          boProcessLimit := True;
          Break;
        end;
        Inc(I);
      end;
    finally
      m_MerchantList.UnLock;
    end;
    if not boProcessLimit then  nMerchantPosition := 0;
  except
    MainOutMessage('{异常} TUserEngine::ProcessMerchants');
  end;
  dwProcessMerchantTimeMin := GetTickCount - dwRunTick;
  if dwProcessMerchantTimeMin > dwProcessMerchantTimeMax then dwProcessMerchantTimeMax := dwProcessMerchantTimeMin;
  if dwProcessNpcTimeMin > dwProcessNpcTimeMax then dwProcessNpcTimeMax := dwProcessNpcTimeMin;
end;

function TUserEngine.InsMonstersList(MonGen: pTMonGenInfo; Monster: TAnimalObject): Boolean;
var
  I, II: Integer;
  MonGenInfo: pTMonGenInfo;
begin
  Result := False;
  if m_MonGenList.Count > 0 then begin//20081008
    for I := 0 to m_MonGenList.Count - 1 do begin
      MonGenInfo := m_MonGenList.Items[I];
      if (MonGenInfo <> nil) and (MonGenInfo.CertList <> nil) and (MonGen <> nil) and (MonGen = MonGenInfo) then begin
        if MonGenInfo.CertList.Count > 0 then begin
          for II := 0 to MonGenInfo.CertList.Count - 1 do begin
            if (Monster <> nil) and (TBaseObject(MonGenInfo.CertList.Items[II]) = Monster) then begin
              Result := True;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;
//清除怪物
function TUserEngine.ClearMonsters(sMapName: string): Boolean;
var
  I, II: Integer;
  {MonGenInfo: pTMonGenInfo;
  Monster: TAnimalObject; }
  MonList: TList;
  Envir: TEnvirnoment;
  BaseObject: TBaseObject;
begin
  Result := False;
  MonList := TList.Create;
  try
    if g_MapManager.Count > 0 then begin//20081008
      for I := 0 to g_MapManager.Count - 1 do begin
        Envir := TEnvirnoment(g_MapManager.Items[I]);
        if (Envir <> nil) and ((CompareText(Envir.sMapName, sMapName) = 0)) then begin
          UserEngine.GetMapMonster(Envir, MonList);
          if MonList.Count > 0 then begin//20081008
            for II := 0 to MonList.Count - 1 do begin
              BaseObject := TBaseObject(MonList.Items[II]);
              if BaseObject <> nil then begin
                if (BaseObject.m_btRaceServer <> 110) and (BaseObject.m_btRaceServer <> 111) and
                   (BaseObject.m_btRaceServer <> RC_GUARD) and (BaseObject.m_btRaceServer <> RC_ARCHERGUARD) and
                   (BaseObject.m_btRaceServer <> 55) then begin
                  BaseObject.m_boNoItem := True;
                  BaseObject.m_WAbil.HP := 0;
                end;
              end;
            end;
          end;
        end;
      end;//for
    end;
  finally
    MonList.Free;
  end;

  {for i := 0 to m_MonGenList.Count - 1 do begin
    MonGenInfo := m_MonGenList.Items[i];
    if MonGenInfo = nil then Continue;
    if CompareText(MonGenInfo.sMapName, sMapName) = 0 then begin
      if (MonGenInfo.CertList <> nil) and (MonGenInfo.CertList.Count > 0) then begin
        for ii := 0 to MonGenInfo.CertList.Count - 1 do begin
          Monster := TAnimalObject(MonGenInfo.CertList.Items[ii]);
          if Monster <> nil then begin
            if (Monster.m_btRaceServer <> 110) and (Monster.m_btRaceServer <> 111) and
              (Monster.m_btRaceServer <> 111) and (Monster.m_btRaceServer <> RC_GUARD) and
              (Monster.m_btRaceServer <> RC_ARCHERGUARD) and (Monster.m_btRaceServer <> 55) then begin
              Monster.Free;
              if nMonsterCount > 0 then Dec(nMonsterCount);
              //DisPose();
            end;
          end;
          if MonGenInfo.CertList.Count <= 0 then begin
            MonGenInfo.CertList.Clear;
          end;
        end;
      end;
    end;
  end;}
  Result := True;
end;
//怪物过程
procedure TUserEngine.ProcessMonsters;
  function GetZenTime(dwTime: LongWord): LongWord;
  var
    d10: Double;
  begin
    if dwTime < 1800000{30 * 60 * 1000} then begin
      d10 := (GetUserCount - g_Config.nUserFull {1000}) / g_Config.nZenFastStep {300};
      if d10 > 0 then begin
        if d10 > 6 then d10 := 6;
        Result := dwTime - Round((dwTime / 10) * d10)
      end else begin
        Result := dwTime;
      end;
    end else begin
      Result := dwTime;
    end;
  end;
var
  dwCurrentTick: LongWord;
  dwRunTick: LongWord;
  dwMonProcTick: LongWord;
  MonGen: pTMonGenInfo;
  nGenCount: Integer;
  nGenModCount: Integer;
  boProcessLimit: Boolean;
  boRegened: Boolean;
  I: Integer;
  nProcessPosition: Integer;
  Monster: TAnimalObject;
  tCode: Integer;
  nMakeMonsterCount: Integer;
  boCanCreate: Boolean;//20080525
//  nActiveMonsterCount: Integer;
//  nActiveHumCount: Integer;
//  MapMonGenCount: pTMapMonGenCount;
begin
  tCode := 0;
  dwRunTick := GetTickCount();
  try
    tCode := 1;
    boProcessLimit := False;
    dwCurrentTick := GetTickCount();
    MonGen := nil;                                                                 
    //刷新怪物开始,判断是否超过刷怪的间隔
    if ((GetTickCount - dwRegenMonstersTick) > g_Config.dwRegenMonstersTime) then begin
      tCode := 2;
      dwRegenMonstersTick := GetTickCount();
      if m_nCurrMonGen < m_MonGenList.Count then begin
        tCode := 25;
        MonGen := m_MonGenList.Items[m_nCurrMonGen];//取得当前刷怪的索引
        tCode := 26;
        if MonGen <> nil then begin//20081222
          tCode := 27;
          if MonGen.nCurrMonGen = 0 then MonGen.nCurrMonGen:= m_nCurrMonGen;//刷怪索引 20080830
        end;  
      end;
      tCode := 3;
      if m_nCurrMonGen < m_MonGenList.Count - 1 then begin
        Inc(m_nCurrMonGen);
      end else begin
        m_nCurrMonGen := 0;
      end;
      tCode := 4;
      if (MonGen <> nil) then begin
        if (MonGen.sMonName <> '') and (not g_Config.boVentureServer) then begin
          if (MonGen.dwStartTick = 0) or ((GetTickCount - MonGen.dwStartTick) > GetZenTime(MonGen.dwZenTime)) then begin
            tCode := 5;
            nGenCount := GetGenMonCount(MonGen);
            boRegened := True;
            if g_Config.nMonGenRate <= 0 then g_Config.nMonGenRate := 10; //防止除法错误
            nGenModCount := _MAX(1, Round(_MAX(1, MonGen.nCount) / (g_Config.nMonGenRate / 10)));
            nMakeMonsterCount := nGenModCount - nGenCount;
            if nMakeMonsterCount < 0 then nMakeMonsterCount := 0;
            tCode := 6;
            if MonGen.Envir <> nil then begin//20081005
              tCode := 7;
              if MonGen.Envir.m_boNoManNoMon then begin//没人不刷怪 20080712
                if (MonGen.Envir.HumCount > 0) then boCanCreate := True
                else boCanCreate := False;
              end else boCanCreate := True;
            end else boCanCreate := True;

            //nGenModCount 需要刷怪数
            //nGenCount 已经刷怪数}
            //nMakeMonsterCount 当前需制造怪物的数量
            //===============================智能刷怪========================================
           (* if (MonGen.Envir <> nil) and boCanCreate then begin
              if (MonGen.nRace <> 110) and (MonGen.nRace <> 111) and (MonGen.nRace <> RC_GUARD) and
                 (MonGen.nRace <> RC_ARCHERGUARD) and(MonGen.nRace <> 55) then begin

                MapMonGenCount := GetMapMonGenCount(MonGen.sMapName);
                if MapMonGenCount <> nil then begin
                  nActiveHumCount := GetMapHuman(MonGen.sMapName);
                  nActiveMonsterCount := GetMapMonster(MonGen.Envir, nil);//地图怪物数量
                  if (nActiveHumCount > 0) and (not MapMonGenCount.boNotHum) then begin
                    MapMonGenCount.boNotHum := True;
                  end else
                    if (nActiveHumCount <= 0) and (MapMonGenCount.boNotHum) then begin
                    MapMonGenCount.boNotHum := False;
                    MapMonGenCount.dwNotHumTimeTick := GetTickCount;
                  end;
                  //如果地图无人,30分钟清怪
                  if (GetTickCount - MapMonGenCount.dwNotHumTimeTick > 1800000{1000 * 60 * 30}) and not MapMonGenCount.boNotHum then begin
                    MapMonGenCount.dwNotHumTimeTick := GetTickCount;
                    if nActiveMonsterCount > 0 then begin
                      if ClearMonsters(MonGen.sMapName) then begin
                        //MainOutMessage('智能清怪物:'+MonGen.sMonName+'  数量:'+inttostr(nActiveMonsterCount)+'  地图人物数量:'+inttostr(nActiveHumCount));
                        Inc(MapMonGenCount.nClearCount);
                      end;
                    end;
                    nMakeMonsterCount := 0;
                  end;
                 { //刷怪
                  if MapMonGenCount.boNotHum then begin

                  end;   }
                end;
              end;
            end;  *)
            tCode := 8;
            if (nMakeMonsterCount > 0) and (boCanCreate) then begin //0806 增加 控制刷怪数量比例
              if (nErrorLevel = 0) and (nCrackedLevel = 0) then begin
                boRegened := RegenMonsters(MonGen, nMakeMonsterCount);//创建怪物对象 RegenMonsters()
              end else
              if dwStartTime < 36000{60 * 60 * 10} then begin //破解后在10小时以内正常刷怪
                boRegened := RegenMonsters(MonGen, nMakeMonsterCount);
              end;
            end;
            if boRegened then MonGen.dwStartTick := GetTickCount();
          end;
          g_sMonGenInfo1 := MonGen.sMonName + ',' + IntToStr(m_nCurrMonGen) + '/' + IntToStr(m_MonGenList.Count);
        end;
      end;
    end;
    tCode := 9;
    g_nMonGenTime := GetTickCount - dwCurrentTick;
    if g_nMonGenTime > g_nMonGenTimeMin then g_nMonGenTimeMin := g_nMonGenTime;
    if g_nMonGenTime > g_nMonGenTimeMax then g_nMonGenTimeMax := g_nMonGenTime;
    //刷新怪物结束
    dwMonProcTick := GetTickCount();
    nMonsterProcessCount := 0;
    tCode := 10;
    if m_MonGenList.Count > 0 then begin//20080629
      for I := m_nMonGenListPosition to m_MonGenList.Count - 1 do begin
        tCode := 11;
        MonGen := m_MonGenList.Items[I];
        if m_nMonGenCertListPosition < MonGen.CertList.Count then begin
          tCode := 12;
          nProcessPosition := m_nMonGenCertListPosition;
        end else begin
          nProcessPosition := 0;
        end;
        m_nMonGenCertListPosition := 0;
         while (True) do begin
          if nProcessPosition >= MonGen.CertList.Count then Break;
          tCode := 13;
          Monster := MonGen.CertList.Items[nProcessPosition];
          if Monster <> nil then begin
            tCode := 14;
            if not Monster.m_boGhost then begin
              tCode := 15;
              if Integer(dwCurrentTick - Monster.m_dwRunTick) > Monster.m_nRunTime then begin
                tCode := 16;
                Monster.m_dwRunTick := dwRunTick;
                if (dwCurrentTick - Monster.m_dwSearchTick) > Monster.m_dwSearchTime then begin
                  tCode := 17;
                  Monster.m_dwSearchTick := GetTickCount();
                  Monster.SearchViewRange();//怪多,占CUP
                end;
                if not Monster.m_boIsVisibleActive and (Monster.m_nProcessRunCount < g_Config.nProcessMonsterInterval) then begin
                  Inc(Monster.m_nProcessRunCount);
                end else begin
                  if Monster <> nil then begin //20080526 增加
                    Monster.m_nProcessRunCount := 0;
                    tCode := 18;
                    Monster.Run;
                  end;
                end;
                Inc(nMonsterProcessCount);
              end;
              Inc(nMonsterProcessPostion);
            end else begin
              if (GetTickCount - Monster.m_dwGhostTick) > 300000{5 * 60 * 1000} then begin
                tCode := 19;
                MonGen.CertList.Delete(nProcessPosition);
                tCode := 20;
                if Monster <> nil then FreeAndNil(Monster);//20081130
                //Monster.Free;
                tCode := 24;
                Continue;
              end;
            end;
          end;
          Inc(nProcessPosition);
          if (GetTickCount - dwMonProcTick) > g_dwMonLimit then begin
            tCode := 21;
            g_sMonGenInfo2 := Monster.m_sCharName + '/' + IntToStr(I) + '/' + IntToStr(nProcessPosition);
            tCode := 22;
            boProcessLimit := True;
            m_nMonGenCertListPosition := nProcessPosition;
            Break;
          end;
        end; //while (True) do begin 
        if boProcessLimit then Break;
      end; //for I:= m_nMonGenListPosition to MonGenList.Count -1 do begin
    end;  
    tCode := 23;
    if m_MonGenList.Count <= I then begin
      m_nMonGenListPosition := 0;
      nMonsterCount := nMonsterProcessPostion;
      nMonsterProcessPostion := 0;
    end;
    if not boProcessLimit then begin
      m_nMonGenListPosition := 0;
    end else begin
      m_nMonGenListPosition := I;
    end;
    g_nMonProcTime := GetTickCount - dwMonProcTick;
    if g_nMonProcTime > g_nMonProcTimeMin then g_nMonProcTimeMin := g_nMonProcTime;
    if g_nMonProcTime > g_nMonProcTimeMax then g_nMonProcTimeMax := g_nMonProcTime;
  except
    on E: Exception do begin
      if Monster <> nil then begin
        MainOutMessage(Format('{异常} TUserEngine::ProcessMonsters %d %s', [tCode, Monster.m_sCharName]));
        Monster.KickException;//踢除异常 20090103
      end else begin
        MainOutMessage(Format('{异常} TUserEngine::ProcessMonsters %d %s', [tCode, '']));
      end;
    end;
  end;             
  g_nMonTimeMin := GetTickCount - dwRunTick;
  if g_nMonTimeMax < g_nMonTimeMin then g_nMonTimeMax := g_nMonTimeMin;
end;

function TUserEngine.GetGenMonCount(MonGen: pTMonGenInfo): Integer;
var
  I: Integer;
  nCount: Integer;
  BaseObject: TBaseObject;
begin
  nCount := 0;
  if MonGen.CertList.Count > 0 then begin
    for I := 0 to MonGen.CertList.Count - 1 do begin
      BaseObject := TBaseObject(MonGen.CertList.Items[I]);
      if BaseObject <> nil then begin
        if not BaseObject.m_boDeath and not BaseObject.m_boGhost then Inc(nCount);
      end;
    end;
  end;
  Result := nCount;
end;
{//未使用的函数  20080422
function TUserEngine.InQuestNPCList(NPC: TNormNpc): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to QuestNPCList.Count - 1 do begin
    if (NPC <> nil) and (TNormNpc(QuestNPCList.Items[I]) = NPC) then begin
      Result := True;
      Break;
    end;
  end;
end;  }

procedure TUserEngine.ProcessNpcs;
var
  dwRunTick, dwCurrTick: LongWord;
  I: Integer;
  NPC: TNormNpc;
  boProcessLimit: Boolean;
begin
  dwRunTick := GetTickCount();
  boProcessLimit := False;
  try
    dwCurrTick := GetTickCount();
    for I := nNpcPosition to QuestNPCList.Count - 1 do begin
      NPC := QuestNPCList.Items[I];
      if NPC <> nil then begin
        if not NPC.m_boGhost then begin
          if Integer(dwCurrTick - NPC.m_dwRunTick) > NPC.m_nRunTime then begin
            if (GetTickCount - NPC.m_dwSearchTick) > NPC.m_dwSearchTime then begin
              NPC.m_dwSearchTick := GetTickCount();
              NPC.SearchViewRange();
            end;
            if Integer(dwCurrTick - NPC.m_dwRunTick) > NPC.m_nRunTime then begin
              NPC.m_dwRunTick := dwCurrTick;
              NPC.Run;
            end;
          end;
        end else begin
          if (GetTickCount - NPC.m_dwGhostTick) > 60000{60 * 1000} then begin
            NPC.Free;
            QuestNPCList.Delete(I);
            Break;
          end;
        end;
      end;
      if (GetTickCount - dwRunTick) > g_dwNpcLimit then begin
        nNpcPosition := I;
        boProcessLimit := True;
        Break;
      end;
    end;//for
    if not boProcessLimit then  nNpcPosition := 0;
  except
    MainOutMessage('{异常} TUserEngine.ProcessNpcs');
  end;
  dwProcessNpcTimeMin := GetTickCount - dwRunTick;
  if dwProcessNpcTimeMin > dwProcessNpcTimeMax then dwProcessNpcTimeMax := dwProcessNpcTimeMin;
end;

function TUserEngine.RegenMonsterByName(sMAP: string; nX, nY: Integer; sMonName: string): TBaseObject;
var
  nRace: Integer;
  BaseObject: TBaseObject;
  n18: Integer;
  MonGen: pTMonGenInfo;
begin
  nRace := GetMonRace(sMonName);
  BaseObject := AddBaseObject(sMAP, nX, nY, nRace, sMonName);
  if BaseObject <> nil then begin
    n18 := m_MonGenList.Count - 1;
    if n18 < 0 then n18 := 0;
    MonGen := m_MonGenList.Items[n18];
    if MonGen <> nil then begin
      MonGen.CertList.Add(BaseObject);
      BaseObject.m_PEnvir.AddObject(1);
      BaseObject.m_boAddToMaped := True;
    end;
  end;
  Result := BaseObject;
end;

function TUserEngine.RegenPlayByName(PlayObject: TPlayObject; nX, nY: Integer;
  sMonName: string): TBaseObject;
var
  BaseObject: TBaseObject;
  n18: Integer;
  MonGen: pTMonGenInfo;
begin
  BaseObject := AddPlayObject(PlayObject, nX, nY, sMonName);
  if BaseObject <> nil then begin
    n18 := m_MonGenList.Count - 1;
    if n18 < 0 then n18 := 0;
    MonGen := m_MonGenList.Items[n18];
    MonGen.CertList.Add(BaseObject);
    BaseObject.m_PEnvir.AddObject(1);
    BaseObject.m_boAddToMaped := True;
  end;
  Result := BaseObject;
end;

procedure TUserEngine.AddObjectToMonList(BaseObject: TBaseObject);
var
  n18: Integer;
  MonGen: pTMonGenInfo;
begin
  n18 := m_MonGenList.Count - 1;
  if n18 < 0 then n18 := 0;
  MonGen := m_MonGenList.Items[n18];
  MonGen.CertList.Add(BaseObject);
  BaseObject.m_PEnvir.AddObject(1);
  BaseObject.m_boAddToMaped := True;
end;

function TUserEngine.RegenMyHero(PlayObject: TPlayObject; nX, nY: Integer;
  HumanRcd: THumDataInfo): TBaseObject;
var
  BaseObject: TBaseObject;
  n18: Integer;
  MonGen: pTMonGenInfo;
begin
  BaseObject := AddHeroObject(PlayObject, nX, nY, HumanRcd);
  if BaseObject <> nil then begin
    n18 := m_MonGenList.Count - 1;
    if n18 < 0 then n18 := 0;
    MonGen := m_MonGenList.Items[n18];
    MonGen.CertList.Add(BaseObject);
    BaseObject.m_PEnvir.AddObject(1);
    BaseObject.m_boAddToMaped := True;
  end;
  Result := BaseObject;
end;

procedure TUserEngine.Run;
  procedure ShowOnlineCount();//取在线人数
  var
    nOnlineCount: Integer;
    nOnlineCount2: Integer;
    nAutoAddExpPlayCount: Integer;
  begin
    nOnlineCount := GetUserCount;
    nAutoAddExpPlayCount := GetAutoAddExpPlayCount;//挂机人物
    nOnlineCount2 := nOnlineCount - nAutoAddExpPlayCount;//真正在线人数
    MainOutMessage(Format('在线数: %d (%d/%d)', [ nOnlineCount, nOnlineCount2, nAutoAddExpPlayCount]));
  end;
begin
  try
    if (GetTickCount() - dwShowOnlineTick) > g_Config.dwConsoleShowUserCountTime then begin
      dwShowOnlineTick := GetTickCount();
      //NoticeManager.LoadingNotice;//读取公告  20080815 注释 移动到程序启动时加载
      ShowOnlineCount();//取在线人数 
      //MainOutMessage('在线数: ' + IntToStr(GetUserCount));//20080815 修改
      g_CastleManager.Save;
    end;
    if (GetTickCount() - dwSendOnlineHumTime) > 15000{10000} then begin
      dwSendOnlineHumTime := GetTickCount();
      FrmIDSoc.SendOnlineHumCountMsg(GetOnlineHumCount);
    end;
    {if Assigned(zPlugOfEngine.UserEngineRun) then begin//20080813 注释
      try
        zPlugOfEngine.UserEngineRun(Self);
      except
      end;
    end;}
  except
    on E: Exception do begin
      MainOutMessage('{异常} TUserEngine::Run');
    end;
  end;
end;

function TUserEngine.GetStdItem(nItemIdx: Integer): pTStdItem;
begin
  Result := nil;
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    Result := StdItemList.Items[nItemIdx];
    if Result.Name = '' then Result := nil;
  end;
end;

function TUserEngine.GetStdItem(sItemName: string): pTStdItem;
var
  I: Integer;
  StdItem: pTStdItem;
begin
  Result := nil;
  if sItemName = '' then Exit;
  if StdItemList.Count > 0 then begin//20081008
    for I := 0 to StdItemList.Count - 1 do begin
      StdItem := StdItemList.Items[I];
      if StdItem <> nil then begin//20090128
        if CompareText(StdItem.Name, sItemName) = 0 then begin
          Result := StdItem;
          Break;
        end;
      end;
    end;
  end;
end;
//(酿酒)通过材料Anicount得到对应酒的函数  20080620
function TUserEngine.GetMakeWineStdItem(Anicount: Integer): pTStdItem;
var
  I: Integer;
  StdItem: pTStdItem;
begin
  Result := nil;
  if Anicount < 0 then Exit;
  if StdItemList.Count > 0 then begin
    for I := 0 to StdItemList.Count - 1 do begin
      StdItem := StdItemList.Items[I];
      if StdItem <> nil then begin//20090128
        if (StdItem.Shape = Anicount) and (StdItem.StdMode = 60) then begin
          Result := StdItem;
          Break;
        end;
      end;
    end;
  end;
end;

//通过酒Shape得到对应酒曲的函数  20080621
function TUserEngine.GetMakeWineStdItem1(Shape: Integer): pTStdItem;
var
  I: Integer;
  StdItem: pTStdItem;
begin
  Result := nil;
  if Shape < 0 then Exit;
  if StdItemList.Count > 0 then begin
    for I := 0 to StdItemList.Count - 1 do begin
      StdItem := StdItemList.Items[I];
      if StdItem <> nil then begin//20090128
        if (StdItem.Shape = Shape) and (StdItem.StdMode = 13) then begin
          Result := StdItem;
          Break;
        end;
      end;
    end;
  end;
end;
//通过索引取物品重量
function TUserEngine.GetStdItemWeight(nItemIdx: Integer): Integer;
var
  StdItem: pTStdItem;
begin
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    StdItem := StdItemList.Items[nItemIdx];
    if StdItem <> nil then begin//20090128
      Result := StdItem.Weight;
    end;
  end else begin
    Result := 0;
  end;
end;
//通过索引取物品名字
function TUserEngine.GetStdItemName(nItemIdx: Integer): string;
begin
  Result := '';
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    Result := pTStdItem(StdItemList.Items[nItemIdx]).Name;
  end else Result := '';
end;

//查找其它服务器上的角色 暂时无效
function TUserEngine.FindOtherServerUser(sName: string;
  var nServerIndex): Boolean;
begin
  Result := False;
end;
//黄字喊话
procedure TUserEngine.CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY,
  nWide: Integer; btFColor, btBColor: Byte; sMsg: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if not PlayObject.m_boGhost and
        (PlayObject.m_PEnvir = pMap) and
        (PlayObject.m_boBanShout) and //允许群组聊天
        (PlayObject.m_boBanGmMsg)and //20080211  拒绝接收喊话信息
        (abs(PlayObject.m_nCurrX - nX) < nWide) and
        (abs(PlayObject.m_nCurrY - nY) < nWide) then begin
        //PlayObject.SendMsg(nil,wIdent,0,0,$FFFF,0,sMsg);
        PlayObject.SendMsg(PlayObject, wIdent, 0, btFColor, btBColor, 0, sMsg);
      end;
    end;
  end;
end;

//获取怪物爆率物品  20080523
function TUserEngine.MonGetRandomItems(mon: TBaseObject): Integer;
var
  I: Integer;
  ItemList: TList;
  iname: string;
  MonItem: pTMonItemInfo;
  UserItem: pTUserItem;
  Monster: pTMonInfo;
  StdItem: pTStdItem;
  nCode: Byte;//20090113
begin
  nCode:=0;
  try
    ItemList := nil;
    if mon = nil then Exit;//20090113
    nCode:=1;
    if MonsterList.Count > 0 then begin//20081008
      for I := 0 to MonsterList.Count - 1 do begin
        Monster := MonsterList.Items[I];
        nCode:=2;
        if Monster <> nil then begin//20090113
          if CompareText(Monster.sName, mon.m_sCharName) = 0 then begin
            ItemList := Monster.ItemList;
            Break;
          end;
        end;
      end;
    end;
    nCode:=3;
    if ItemList <> nil then begin
      if ItemList.Count > 0 then begin//20080627
        for I := 0 to ItemList.Count - 1 do begin
          MonItem := pTMonItemInfo(ItemList[I]);
          nCode:=4;
          if MonItem <> nil then begin//20090113
            if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin//计算机率 1/10 随机10<=1 即为所得的物品
              nCode:=5;
              if CompareText(MonItem.ItemName, sSTRING_GOLDNAME) = 0 then begin  //如果是金币
                mon.m_nGold := mon.m_nGold + (MonItem.Count div 2) + Random(MonItem.Count);
              end else begin
                iname := '';
                if iname = '' then iname := MonItem.ItemName;
                nCode:=6;
                New(UserItem);
                if CopyToUserItemFromName(iname, UserItem) then begin
                  UserItem.Dura := Round((UserItem.DuraMax / 100) * (20 + Random(80)));
                  if Random(g_Config.nMonRandomAddValue) = 0 then RandomUpgradeItem(UserItem);

                  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
                  if StdItem <> nil then begin
                    Case StdItem.StdMode of
                      2:begin
                        if StdItem.AniCount = 21 then UserItem.Dura:=0;//是魔令包和祝福罐,则把当前持久设置为0
                      end;
                      8:begin//是酿酒材料 20080702
                         case StdItem.Source of
                           0: UserItem.btValue[0]:= Random(3)+ 1;//随机给材料的品质
                           1: UserItem.btValue[0]:= Random(3)+ 5;
                         end;
                      end;
                      51:begin
                        if (StdItem.Shape = 0) then UserItem.Dura:= 0;//聚灵珠则清空当前持久 20081108
                      end;
                    end;//case
                  end;
                  nCode:=7;
                  mon.m_ItemList.Add(UserItem)
                end else
                  Dispose(UserItem);
              end;
            end;
          end;
        end;
      end;
    end;
    Result := 1;
  except
    MainOutMessage('{异常} TUserEngine.MonGetRandomItems Code:'+inttostr(nCode));
  end;
end;
//随机升级物品(极品属性)
procedure TUserEngine.RandomUpgradeItem(Item: pTUserItem);
var
  StdItem: pTStdItem;
begin
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    5, 6: ItemUnit.RandomUpgradeWeapon(Item);//武器
    10, 11: ItemUnit.RandomUpgradeDress(Item);//衣服
    19: ItemUnit.RandomUpgrade19(Item);//项链(幸运型)
    20, 21, 24: ItemUnit.RandomUpgrade202124(Item);//项链(准确敏捷型、体力魔法恢复型)、手镯(特别型)
    26: ItemUnit.RandomUpgrade26(Item);//手套手镯
    22: ItemUnit.RandomUpgrade22(Item);//戒指
    23: ItemUnit.RandomUpgrade23(Item);//戒指(特别型)
    15,16: ItemUnit.RandomUpgradeHelMet(Item);//头盔,斗笠
    52,54,62,64: ItemUnit.RandomUpgradeBoots(Item);//20080503 鞋子，腰带
  end;
end;

procedure TUserEngine.GetUnknowItemValue(Item: pTUserItem);
var
  StdItem: pTStdItem;
begin
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    15, 16: ItemUnit.UnknowHelmet(Item); //神秘头盔,斗笠
    22, 23: ItemUnit.UnknowRing(Item);//神秘戒指
    24, 26: ItemUnit.UnknowNecklace(Item);//神秘手套手镯
  end;
end;

function TUserEngine.CopyToUserItemFromName(sItemName: string; Item: pTUserItem): Boolean;
var
  I: Integer;
  StdItem: pTStdItem;
begin
  Result := False;
  try
    if sItemName <> '' then begin
      if StdItemList.Count > 0 then begin//20081008
        for I := 0 to StdItemList.Count - 1 do begin
          //StdItem := StdItemList.Items[I];
          StdItem := pTStdItem(StdItemList.Items[I]);//20080725
          if StdItem <> nil then begin//20080725
            if CompareText(StdItem.Name, sItemName) = 0 then begin
              FillChar(Item^, SizeOf(TUserItem), #0);
              //FillChar(Item^.btValue, SizeOf(Item^.btValue), 0);//20080812 增加
              Item.wIndex := I + 1;
              Item.MakeIndex := GetItemNumber();
              Item.Dura := StdItem.DuraMax;
              Item.DuraMax := StdItem.DuraMax;
              case StdItem.StdMode of //是魔令包和祝福罐,则把当前持久设置为0  20080305
                15,16, 19..24, 26:begin
                   if (StdItem.Shape = 130) or (StdItem.Shape = 131) or (StdItem.Shape = 132) then
                    UserEngine.GetUnknowItemValue(Item);
                 end;
                2:begin
                   if StdItem.AniCount = 21 then Item.Dura:=0;//是魔令包和祝福罐,则把当前持久设置为0
                 end;
                51:begin//20080221 聚灵珠
                   if StdItem.Shape = 0  then Item.Dura:=0;//是聚灵珠,则把当前持久设置为0
                 end;
                60: begin//酒类,除烧酒外 20080806
                  if StdItem.shape <> 0 then begin
                    Item.btValue[1]:= Random(40) + 10;//酒的酒精度
                    Item.btValue[0]:= Random(8);//酒的品质
                    if StdItem.Anicount = 2 then Item.btValue[2]:= Random(4) + 1;//药力值 20081210
                  end;
                end;//60
              end;
              Result := True;
              Break;
            end;
          end;
        end;//for
      end;
    end;
  except
    MainOutMessage('{异常} TUserEngine.CopyToUserItemFromName');
  end;
end;

procedure TUserEngine.ProcessUserMessage(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; Buff: PChar);
var
  sMsg{,sTemp,sTemp1}: string;
//  NewBuff: array[0..DATA_BUFSIZE2 - 1] of Char;
//  sDefMsg: string;
resourcestring
  sExceptionMsg = '{异常} TUserEngine::ProcessUserMessage..';
begin
  if (DefMsg = nil) or (PlayObject = nil) then Exit;
  try
    if Buff = nil then sMsg := ''
    else sMsg := StrPas(Buff);

    if DefMsg.nSessionID <> PlayObject.m_nSessionID then begin//20081210 检查客户端会话ID是否正确, DefMsg.nSessionID客户端发来的值
      Exit;
    end;

    case DefMsg.Ident of
      CM_SPELL: begin //3017
          //if PlayObject.GetSpellMsgCount <=2 then  //如果队排里有超过二个魔法操作，则不加入队排
          if g_Config.boSpellSendUpdateMsg then begin //使用UpdateMsg 可以防止消息队列里有多个操作
            PlayObject.SendUpdateMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog),
              HiWord(DefMsg.Recog),
              MakeLong(DefMsg.Param,
              DefMsg.Series),
              '');
          end else begin
            PlayObject.SendMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog),
              HiWord(DefMsg.Recog),
              MakeLong(DefMsg.Param,
              DefMsg.Series),
              '');
          end;
        end;

      CM_QUERYUSERNAME, CM_HEROATTACKTARGET, CM_HEROPROTECT: begin //80
          PlayObject.SendMsg(PlayObject, DefMsg.Ident, 0, DefMsg.Recog, DefMsg.Param {x}, DefMsg.Tag {y}, '');
        end;
      CM_DROPITEM,
        CM_HERODROPITEM,
        CM_TAKEONITEM,
        CM_TAKEOFFITEM,
        CM_1005,

      CM_MERCHANTDLGSELECT,
      CM_PlAYDRINKDLGSELECT,
        CM_MERCHANTQUERYSELLPRICE,
        CM_USERSELLITEM,
        CM_USERBUYITEM,
        CM_USERGETDETAILITEM,

      CM_SENDSELLOFFITEM,
        CM_SENDSELLOFFITEMLIST, //拍卖
        CM_SENDQUERYSELLOFFITEM, //拍卖
        CM_SENDBUYSELLOFFITEM, //拍卖

      CM_HEROTAKEONITEM,
        CM_HEROTAKEOFFITEM,

      CM_TAKEOFFITEMHEROBAG, //装备脱下到英雄包裹
        CM_TAKEOFFITEMTOMASTERBAG, //装备脱下到主人包裹

      CM_SENDITEMTOMASTERBAG, //主人包裹到英雄包裹
        CM_SENDITEMTOHEROBAG, //英雄包裹到主人包裹

      CM_HEROTAKEONITEMFORMMASTERBAG, //从主人包裹穿装备到英雄包裹
      CM_TAKEONITEMFORMHEROBAG, //从英雄包裹穿装备到主人包裹
      CM_REPAIRFIRDRAGON,//接收客户发来的:修补火龙之心

      CM_REPAIRDRAGON,//修补祝福罐.魔令包 20080102
      CM_REPAIRFINEITEM,//修补火云石

      CM_CREATEGROUP,
      CM_ADDGROUPMEMBER,
      CM_DELGROUPMEMBER,
      CM_USERREPAIRITEM,
      CM_MERCHANTQUERYREPAIRCOST,
      CM_DEALTRY,
      CM_DEALADDITEM,
      CM_DEALDELITEM,
      CM_CHALLENGETRY,//客户端点挑战 20080705
      CM_CHALLENGEADDITEM,//玩家把物品放到挑战框中
      CM_CHALLENGEDELITEM,//玩家从挑战框中取回物品
      CM_CHALLENGECANCEL,//玩家取消挑战
      CM_CHALLENGECHGGOLD,//客户端把金币放到挑战框中
      CM_CHALLENGECHGDIAMOND,//客户端把金刚石放到挑战框中
      CM_CHALLENGEEND,//挑战抵押物品结束
      CM_SELLOFFADDITEM,//元宝寄售系统 客户端往出售物品窗口里加物品  20080316
      CM_SELLOFFDELITEM,//客户端删除出售物品窗里的物品  20080316
      CM_SELLOFFCANCEL,//客户端取消元宝寄售  20080316
      CM_SELLOFFEND, //客户端元宝寄售结束  20080316
      CM_CANCELSELLOFFITEMING, //取消正在寄售的物品 20080318(出售人)
      CM_SELLOFFBUYCANCEL,//取消寄售 物品购买 20080318(购买人)
      CM_SELLOFFBUY,//确定购买寄售物品 20080318
      CM_REFINEITEM, //客户端发送粹练物品 20080507

      CM_USERSTORAGEITEM,
      CM_USERPLAYDRINKITEM, //请酒框 20080515
      CM_USERTAKEBACKSTORAGEITEM,
        //      CM_WANTMINIMAP,
      CM_USERMAKEDRUGITEM,
      //      CM_GUILDHOME,
      CM_GUILDADDMEMBER,
      CM_GUILDDELMEMBER,
      CM_GUILDUPDATENOTICE,
      CM_OPENBOXS,
      CM_MOVEBOXS, //转动宝箱
      CM_GETBOXS, //取得宝箱物品
      CM_SELGETHERO, //取回英雄 20080514
      CM_PlAYDRINKGAME, //猜拳码数
      CM_BEGINMAKEWINE,//开始酿酒(即把材料全放上窗口) 20080620
      CM_CLICKSIGHICON, //点击感叹号
      CM_CLICKCRYSTALEXPTOP, //点击天地结晶获得经验 20090202
      CM_DrinkUpdateValue,
      CM_USERPLAYDRINK,
      CM_GUILDUPDATERANKINFO: begin
          PlayObject.SendMsg(PlayObject,   //把消息数据传给ObjBase单元
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            DeCodeString(sMsg));
        end;
      CM_PASSWORD,
        CM_CHGPASSWORD,
        CM_SETPASSWORD: begin
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Param,
            DefMsg.Recog,
            DefMsg.Series,
            DefMsg.Tag,
            DeCodeString(sMsg));
        end;
      CM_ADJUST_BONUS: begin //1043
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            sMsg);
        end;
      CM_HORSERUN,
        CM_TURN,
        CM_WALK,
        CM_SITDOWN,
        CM_RUN,
        CM_HIT,
        CM_HEAVYHIT,
        CM_BIGHIT,

      CM_POWERHIT,
        CM_LONGHIT,
        CM_CRSHIT,
        CM_TWNHIT,{开天斩重击}
        CM_QTWINHIT,{开天斩轻击 20080212}
        CM_CIDHIT,{龙影剑法}
        CM_WIDEHIT,
        CM_PHHIT,
        CM_DAILY,//逐日剑法 20080511
        CM_FIREHIT,{烈火}
        CM_4FIREHIT{4级烈火 20080112}: begin
          if g_Config.boActionSendActionMsg then begin //使用UpdateMsg 可以防止消息队列里有多个操作
            PlayObject.SendActionMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog), {x}
              HiWord(DefMsg.Recog), {y}
              0,
              '');
          end else begin
            PlayObject.SendMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog), {x}
              HiWord(DefMsg.Recog), {y}
              0,
              '');
          end;
        end;
      CM_SAY: begin
          if DefMsg.Recog > 0 then begin
            PlayObject.m_btHearMsgFColor := LoByte(DefMsg.Param);
            PlayObject.m_btWhisperMsgFColor := HiByte(DefMsg.Param);
          end else begin
            PlayObject.m_btHearMsgFColor := g_Config.btHearMsgFColor;
            PlayObject.m_btWhisperMsgFColor := g_Config.btWhisperMsgFColor;
          end;
          PlayObject.SendMsg(PlayObject, CM_SAY, 0, 0, 0, 0, DeCodeString(sMsg));
        end;
      CM_QUERYUSERLEVELSORT: begin
          PlayObject.SendUpdateMsg(PlayObject, DefMsg.Ident, 0, DefMsg.Param, DefMsg.Tag, DefMsg.Recog, '');
        end;
      CM_HEROGOTETHERUSESPELL: begin
          PlayObject.SendUpdateMsg(PlayObject, DefMsg.Ident, 0, 0, 0, 0, '');
        end;
      CM_OPENSHOP: begin
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            '');
        end;
      CM_BUYSHOPITEMGIVE,CM_EXCHANGEGAMEGIRD: begin  //赠送,灵符兑换 20080302
         PlayObject.SendUpdateMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,sMsg);
      end;
      CM_BUYSHOPITEM: begin
          PlayObject.SendUpdateMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            DeCodeString(sMsg));
        end;
    else begin
        {if Assigned(zPlugOfEngine.ObjectClientMsg) then begin //20080813 注释
          zPlugOfEngine.ObjectClientMsg(PlayObject, DefMsg, Buff, @NewBuff);
          if @NewBuff = nil then sMsg := ''
          else sMsg := StrPas(@NewBuff);
        end;}
        PlayObject.SendMsg(PlayObject, DefMsg.Ident, DefMsg.Series, DefMsg.Recog,
          DefMsg.Param, DefMsg.Tag, sMsg);
      end;
    end;
    if PlayObject.m_boReadyRun then begin
      case DefMsg.Ident of
        CM_TURN, CM_WALK, CM_SITDOWN, CM_RUN, CM_HIT, CM_HEAVYHIT, CM_BIGHIT, CM_POWERHIT, CM_LONGHIT,
        CM_WIDEHIT{半月}, CM_FIREHIT{烈火}, CM_4FIREHIT{4级烈火}, CM_CRSHIT{抱月刀},CM_DAILY{逐日剑法 20080511},
        CM_PHHIT{破魂斩},CM_TWNHIT{开天斩重击}, CM_QTWINHIT{开天斩轻击 20080212},CM_CIDHIT{龙影剑法}: begin
            Dec(PlayObject.m_dwRunTick, 100);
          end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TUserEngine.SendServerGroupMsg(nCode, nServerIdx: Integer;
  sMsg: string);
begin
  if nServerIndex = 0 then begin
    FrmSrvMsg.SendSocketMsg(IntToStr(nCode) + '/' + EncodeString(IntToStr(nServerIdx)) + '/' + EncodeString(sMsg));
  end else begin
    FrmMsgClient.SendSocket(IntToStr(nCode) + '/' + EncodeString(IntToStr(nServerIdx)) + '/' + EncodeString(sMsg));
  end;
end;

function TUserEngine.AddHeroObject(PlayObject: TPlayObject; nX, nY: Integer; HumanRcd: THumDataInfo): TBaseObject;
var
  Map: TEnvirnoment;
  Cert: THeroObject;
  n1C, n20, n24: Integer;
  p28: Pointer;
begin
  Result := nil;
  //Cert := nil;//20080408 未使用
  Map := g_MapManager.FindMap(PlayObject.m_sMapName);
  if Map = nil then Exit;
  Cert := THeroObject.Create;
  if Cert <> nil then begin
    //MonInitialize(Cert, sMonName);
    GetHeroData(Cert, HumanRcd); //取英雄的数据
    if Cert.m_sHomeMap = '' then begin //第一次召唤
      Cert.m_sHomeMap := PlayObject.m_sHomeMap;
      Cert.m_nHomeX := PlayObject.m_nHomeX;
      Cert.m_nHomeY := PlayObject.m_nHomeY;
      case Cert.n_HeroTpye of
        0:Cert.m_Abil.Level := g_Config.nHeroStartLevel;
        1:Cert.m_Abil.Level := g_Config.nDrinkHeroStartLevel;
      end;
      Cert.m_boNewHuman := True;
    end else begin
      Cert.m_sHomeMap := PlayObject.m_sHomeMap;
      Cert.m_nHomeX := PlayObject.m_nHomeX;
      Cert.m_nHomeY := PlayObject.m_nHomeY;
      Cert.m_boNewHuman := False;
    end;
    Cert.m_PEnvir := Map;
    Cert.m_sMapName := PlayObject.m_sMapName;
    Cert.m_nCurrX := nX;
    Cert.m_nCurrY := nY;
    Cert.m_btDirection := Random(8);
    if Cert.m_Abil.Exp <= 0 then Cert.m_Abil.Exp := 1;
    if Cert.m_Abil.MaxExp <= 0 then begin
      Cert.m_Abil.MaxExp := Cert.GetLevelExp(Cert.m_Abil.Level);
    end;
    Cert.GetBagItemCount;
    Cert.m_btRaceImg := PlayObject.m_btRaceImg;
    Cert.RecalcLevelAbilitys;
    Cert.RecalcAbilitys;

    if Random(100) < Cert.m_btCoolEye then Cert.m_boCoolEye := True;
    Cert.Initialize();
    if Cert.m_boAddtoMapSuccess then begin
      p28 := nil;
      if Cert.m_PEnvir.m_nWidth < 50 then n20 := 2
      else n20 := 3;
      if (Cert.m_PEnvir.m_nHeight < 250) then begin
        if (Cert.m_PEnvir.m_nHeight < 30) then n24 := 2
        else n24 := 20;
      end else n24 := 50;
      n1C := 0;
      while (True) do begin
        if not Cert.m_PEnvir.CanWalk(Cert.m_nCurrX, Cert.m_nCurrY, False) then begin
          if (Cert.m_PEnvir.m_nWidth - n24 - 1) > Cert.m_nCurrX then begin
            Inc(Cert.m_nCurrX, n20);
          end else begin
            Cert.m_nCurrX := Random(Cert.m_PEnvir.m_nWidth div 2) + n24;
            if Cert.m_PEnvir.m_nHeight - n24 - 1 > Cert.m_nCurrY then begin
              Inc(Cert.m_nCurrY, n20);
            end else begin
              Cert.m_nCurrY := Random(Cert.m_PEnvir.m_nHeight div 2) + n24;
            end;
          end;
        end else begin
          p28 := Cert.m_PEnvir.AddToMap(Cert.m_nCurrX, Cert.m_nCurrY, OS_MOVINGOBJECT, Cert);
          Break;
        end;
        Inc(n1C);
        if n1C >= 31 then Break;
      end;
      if p28 = nil then begin
        Cert.Free;
        Cert := nil;
      end;
    end;
  end;
  Result := Cert;
end;

function TUserEngine.AddPlayObject(PlayObject: TPlayObject; nX, nY: Integer; sMonName: string): TBaseObject;
var
  Map: TEnvirnoment;
  Cert: TBaseObject;
  n1C, n20, n24: Integer;
  p28: Pointer;
  UserItem: pTUserItem;
  UserMagic: pTUserMagic;
  MonsterMagic: pTUserMagic;
  I: Integer;
  StdItem: pTStdItem;
begin
  Result := nil;
 // Cert := nil;//未使用 20080408
  Map := g_MapManager.FindMap(PlayObject.m_sMapName);
  if Map = nil then Exit;
  Cert := TPlayMonster.Create;
  if Cert <> nil then begin
    //MonInitialize(Cert, sMonName);
    Cert.m_PEnvir := Map;
    Cert.m_sMapName := PlayObject.m_sMapName;
    Cert.m_nCurrX := nX;
    Cert.m_nCurrY := nY;
    Cert.m_btDirection := Random(8);
    Cert.m_sCharName := sMonName;
    Cert.m_Abil := PlayObject.m_Abil;
    Cert.m_Abil.HP := Cert.m_Abil.MaxHP;
    Cert.m_Abil.MP := Cert.m_Abil.MaxMP;
    //TPlayMonster(Cert).GetAbility(PlayObject.m_Abil);
    //Cert.m_WAbil := Cert.m_Abil;// 20080418 注释
    Cert.m_WAbil := PlayObject.m_WAbil;//20080418
    Cert.m_btJob := PlayObject.m_btJob;
    Cert.m_btGender := PlayObject.m_btGender;
    Cert.m_btHair := PlayObject.m_btHair;
    Cert.m_btRaceImg := PlayObject.m_btRaceImg;
    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if PlayObject.m_UseItems[I].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[I].wIndex);
        if StdItem <> nil then begin
          New(UserItem);
          if UserEngine.CopyToUserItemFromName(StdItem.Name, UserItem) then begin
            UserItem^.btValue:= PlayObject.m_UseItems[I].btValue;//20080418  让分身可以支持极品装备
            UserItem^.Dura:= PlayObject.m_UseItems[I].Dura;//20090203 分身的装备持久与主体的一致
            TPlayMonster(Cert).AddItems(UserItem, I);
          end else Dispose(UserItem);//20080820 修改
        end;
      end;
    end;

    if PlayObject.m_MagicList.Count > 0 then begin//20080629
      for I := 0 to PlayObject.m_MagicList.Count - 1 do begin //添加魔法
        UserMagic := PlayObject.m_MagicList.Items[I];
        if UserMagic <> nil then begin
          New(MonsterMagic);
          MonsterMagic.MagicInfo := UserMagic.MagicInfo;
          MonsterMagic.wMagIdx := UserMagic.wMagIdx;
          MonsterMagic.btLevel := UserMagic.btLevel;
          MonsterMagic.btKey := UserMagic.btKey;
          MonsterMagic.nTranPoint := UserMagic.nTranPoint;
          Cert.m_MagicList.Add(MonsterMagic);
        end;
      end;
    end;

    TPlayMonster(Cert).InitializeMonster; {初始化}

    Cert.RecalcAbilitys;

    if Random(100) < Cert.m_btCoolEye then Cert.m_boCoolEye := True;
    Cert.Initialize();
    if Cert.m_boAddtoMapSuccess then begin
      p28 := nil;
      if Cert.m_PEnvir.m_nWidth < 50 then n20 := 2
      else n20 := 3;
      if (Cert.m_PEnvir.m_nHeight < 250) then begin
        if (Cert.m_PEnvir.m_nHeight < 30) then n24 := 2
        else n24 := 20;
      end else n24 := 50;
      n1C := 0;
      while (True) do begin
        if not Cert.m_PEnvir.CanWalk(Cert.m_nCurrX, Cert.m_nCurrY, False) then begin
          if (Cert.m_PEnvir.m_nWidth - n24 - 1) > Cert.m_nCurrX then begin
            Inc(Cert.m_nCurrX, n20);
          end else begin
            Cert.m_nCurrX := Random(Cert.m_PEnvir.m_nWidth div 2) + n24;
            if Cert.m_PEnvir.m_nHeight - n24 - 1 > Cert.m_nCurrY then begin
              Inc(Cert.m_nCurrY, n20);
            end else begin
              Cert.m_nCurrY := Random(Cert.m_PEnvir.m_nHeight div 2) + n24;
            end;
          end;
        end else begin
          p28 := Cert.m_PEnvir.AddToMap(Cert.m_nCurrX, Cert.m_nCurrY, OS_MOVINGOBJECT, Cert);
          Break;
        end;
        Inc(n1C);
        if n1C >= 31 then Break;
      end;
      if p28 = nil then begin
        Cert.Free;
        Cert := nil;
      end;
    end;
  end;
  Result := Cert;
end;

function TUserEngine.AddBaseObject(sMapName: string; nX, nY: Integer; nMonRace: Integer; sMonName: string): TBaseObject; //004AD56C
var
  Map: TEnvirnoment;
  Cert: TBaseObject;
  n1C, n20, n24: Integer;
  p28: Pointer;
  nCode:byte;
begin
  Result := nil;
  Cert := nil;
  nCode:= 0;
  try
    Map := g_MapManager.FindMap(sMapName);
    nCode:= 1;
    if Map = nil then Exit;
    case nMonRace of
      11: Cert := TSuperGuard.Create; //大刀卫士
      20: Cert := TArcherPolice.Create; //没有  清清 2007.11.26
      51: begin                       //鸡和神鹰  清清 2007.11.26
          Cert := TMonster.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(3500) + 3000;
          Cert.m_nBodyLeathery := 50;
        end;
      52: begin                      //鹿，羊，守卫   清清 2007.11.26
          if Random(30) = 0 then begin
            Cert := TChickenDeer.Create;
            Cert.m_boAnimal := True;
            Cert.m_nMeatQuality := Random(20000) + 10000;
            Cert.m_nBodyLeathery := 150;
          end else begin
            Cert := TMonster.Create;
            Cert.m_boAnimal := True;
            Cert.m_nMeatQuality := Random(8000) + 8000;
            Cert.m_nBodyLeathery := 150;
          end;
        end;
      53: begin                   //狼  清清 2007.11.26
          Cert := TATMonster.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(8000) + 8000;
          Cert.m_nBodyLeathery := 150;
        end;
      55: begin                  //练功师
          Cert := TTrainer.Create;
          Cert.m_btRaceServer := 55;
        end;
      80: Cert := TMonster.Create;      //可能是  Tmonster主类 初始化  清清 2007.11.26
      81: Cert := TATMonster.Create;    //物理攻击类的怪物,进入范围自动攻击
      82: Cert := TSpitSpider.Create;   //攻击的时候吐毒的怪物  2x2范围内毒液攻击-弱
      83: Cert := TSlowATMonster.Create; //也是物理攻击的  其中有  蛤蟆 半兽人
      84: Cert := TScorpion.Create;      //蝎子
      85: Cert := TStickMonster.Create;  //食人花
      86: Cert := TATMonster.Create;     //骷髅
      87: Cert := TDualAxeMonster.Create;//投斧头那种怪物 (远程攻击)
      88: Cert := TATMonster.Create;     //骷髅战士
      89: Cert := TATMonster.Create;     //骷髅战将   骷髅精灵   跟上面的一样类
      90: Cert := TGasAttackMonster.Create;//洞蛆
      91: Cert := TMagCowMonster.Create;   //火焰沃玛
      92: Cert := TCowKingMonster.Create;  //沃玛教主  其中攻击属于魔法(遇到攻击对象在范围外时会瞬移)
      93: Cert := TThornDarkMonster.Create;//暗黑战士  跟投斧差不多  也是远程攻击
      94: Cert := TLightingZombi.Create;   //电僵尸
      95: begin                            //石墓尸王   从地下冒出来的怪
          Cert := TDigOutZombi.Create;
          if Random(2) = 0 then Cert.bo2BA := True;
        end;
      96: begin                           //这个 有代研究
          Cert := TZilKinZombi.Create;
          if Random(4) = 0 then Cert.bo2BA := True;//不进入火墙
        end;
      97: begin
          Cert := TCowMonster.Create;    //沃玛战士   沃玛勇士  那类的  物理攻击
          if Random(2) = 0 then Cert.bo2BA := True;
        end;
      98: Cert := TSwordsmanMon.Create; //灵魂收割者,蓝影刀客 2格内可以攻击的怪 20090123

      100: Cert := TWhiteSkeleton.Create;  //变异骷髅    道士召唤的宝宝
      101: begin                           //祖玛雕像  祖玛卫士 怪物刚开始是黑的(进入范围会从石像状态激活)
          Cert := TScultureMonster.Create;
          Cert.bo2BA := True;
        end;
      102: Cert := TScultureKingMonster.Create;//祖玛教主
      103: Cert := TBeeQueen.Create;//有代分析
      104: Cert := TArcherMonster.Create;//祖玛弓箭手  魔龙弓箭手 那类的
      105: Cert := TGasMothMonster.Create;//楔蛾
      106: Cert := TGasDungMonster.Create;//粪虫
      107: Cert := TCentipedeKingMonster.Create; //触龙神  不能动的怪物？
      108: begin
         Cert := TFairyMonster.Create;   //月灵
         Cert.bo2BA := True;//不进入火墙 20080327
        end;
      110: Cert := TCastleDoor.Create;  //沙巴克的 城门
      111: Cert := TWallStructure.Create; //沙巴克的 左墙,中，右
      112: Cert := TArcherGuard.Create;  //弓箭手那类的 NPC
      113: Cert := TElfMonster.Create;   //神兽
      114: Cert := TElfWarriorMonster.Create; //神兽1
      115: Cert := TBigHeartMonster.Create;   //赤月恶魔  千年树妖  从地下冒刺的  不能动的怪
      116: Cert := TSpiderHouseMonster.Create; //属于可以 怪生怪的 怪
      117: Cert := TExplosionSpider.Create;   //幻影蜘蛛
      118: Cert := THighRiskSpider.Create;   //天狼蜘蛛
      119: Cert := TBigPoisionSpider.Create; //花吻蜘蛛
      120: Cert := TSoccerBall.Create;       //飞火流星   其实就是足球
      121: Cert := TGiantSickleSpiderATMonster.Create;//巨镰蜘蛛 20080809
      122: Cert := TSalamanderATMonster.Create;//狂热火蜥蜴 20080809
      123: Cert := TTempleGuardian.Create;//圣殿卫士 20080809
      124: Cert := TheCrutchesSpider.Create;//金杖蜘蛛 20080809
      125: Cert := TYanLeiWangSpider.Create;//雷炎蛛王 20080811
      126: Cert := TSnowyFireDay.Create;//雪域灭天魔 用灭天火,会施放红毒 20090113
      127: Cert := TDevilBat.Create;//恶魔蝙蝠 20090112 施毒术,气功波,抗拒,野蛮对它无效,只有道士捆魔咒可以捆住,只有战士刺杀的第2格能攻击到,攻击方式靠近人物自爆攻击
      128: Cert := TFireDragon.Create;//火龙魔兽 20090111
      129: Cert := TFireDragonGuard.Create;//火龙守护兽 20090111
      130: Cert := TSnowyHanbing.Create;//雪域寒冰魔:冰咆哮，会施放绿毒 20090113
      131: Cert := TSnowyWuDu.Create;//雪域五毒魔:寒冰掌,治疗术 20090113

      135: Cert := TArcherGuardMon.Create; //类似弓箭手的怪,只打怪物 20080121
      136: Cert := TArcherGuardMon1.Create; //不会移动,不会攻击的怪 20080122 魔王岭的怪
      150: Cert := TPlayMonster.Create;//人形怪
      200: Cert := TElectronicScolpionMon.Create; //有代研究
    end;
    nCode:= 2;
    if Cert <> nil then begin
      nCode:= 3;
      MonInitialize(Cert, sMonName);
      nCode:= 4;
      Cert.m_PEnvir := Map;
      Cert.m_sMapName := sMapName;
      Cert.m_nCurrX := nX;
      Cert.m_nCurrY := nY;
      Cert.m_btDirection := Random(8);
      Cert.m_sCharName := sMonName;
      Cert.m_WAbil := Cert.m_Abil;
      nCode:= 5;
      if Random(100) < Cert.m_btCoolEye then Cert.m_boCoolEye := True;
      nCode:= 6;
      MonGetRandomItems(Cert);//取得怪物可以爆物品
      nCode:= 7;
      Cert.Initialize();
      nCode:= 8;
      case nMonRace of
        108: begin
           TFairyMonster(Cert).nWalkSpeed:= Cert.m_nWalkSpeed;//保存月灵DB设置的走路速度 20090105
         end;
        121: TGiantSickleSpiderATMonster(Cert).AddItemsFromConfig;//巨镰蜘蛛(读取可探索物品) 20080810
        122: TSalamanderATMonster(Cert).AddItemsFromConfig;//狂热火蜥蜴(读取可探索物品) 20080810
        123: TTempleGuardian(Cert).AddItemsFromConfig;//圣殿卫士(读取可探索物品) 20080810
        124: TheCrutchesSpider(Cert).AddItemsFromConfig;//金杖蜘蛛(读取可探索物品) 20080810
        125: TYanLeiWangSpider(Cert).AddItemsFromConfig;//雷炎蛛王(读取可探索物品) 20080815
        136:begin//20080124 136怪自动走动 魔王岭怪
           if {(CompareText(Cert.m_sMapName, m_sMapName_136) = 0) and }//20090204
              (m_nCurrX_136 <> 0) and (m_nCurrY_136 <> 0) then begin
              Cert.m_nCurrX := m_nCurrX_136;
              Cert.m_nCurrY := m_nCurrY_136;
              TArcherGuardMon1(Cert).m_NewCurrX:= m_NewCurrX_136;
              TArcherGuardMon1(Cert).m_NewCurrY:= m_NewCurrY_136;
              TArcherGuardMon1(Cert).m_boWalk:= True;
            end;
         end;
        150:begin//人型怪
           Cert.m_nCopyHumanLevel := 0;
           Cert.m_Abil.MP := Cert.m_Abil.MaxMP;
           Cert.m_Abil.HP := Cert.m_Abil.MaxHP; //数据库HP为0,使怪一出来就死 20080120
           Cert.m_WAbil := Cert.m_Abil;
           TPlayMonster(Cert).InitializeMonster; //初始化人形怪物,读文件配置(技能,装备)
           Cert.RecalcAbilitys;
         end;
      end;//case
      nCode:= 9;
      if Cert.m_boAddtoMapSuccess then begin
        p28 := nil;
        if Cert.m_PEnvir.m_nWidth < 50 then n20 := 2
        else n20 := 3;
        if (Cert.m_PEnvir.m_nHeight < 250) then begin
          if (Cert.m_PEnvir.m_nHeight < 30) then n24 := 2
          else n24 := 20;
        end else n24 := 50;
        n1C := 0;
        while (True) do begin
          if not Cert.m_PEnvir.CanWalk(Cert.m_nCurrX, Cert.m_nCurrY, False) then begin
            if (Cert.m_PEnvir.m_nWidth - n24 - 1) > Cert.m_nCurrX then begin
              Inc(Cert.m_nCurrX, n20);
            end else begin
              Cert.m_nCurrX := Random(Cert.m_PEnvir.m_nWidth div 2) + n24;
              if Cert.m_PEnvir.m_nHeight - n24 - 1 > Cert.m_nCurrY then begin
                Inc(Cert.m_nCurrY, n20);
              end else begin
                Cert.m_nCurrY := Random(Cert.m_PEnvir.m_nHeight div 2) + n24;
              end;
            end;
          end else begin
            p28 := Cert.m_PEnvir.AddToMap(Cert.m_nCurrX, Cert.m_nCurrY, OS_MOVINGOBJECT, Cert);
            Break;
          end;
          Inc(n1C);
          if n1C >= 31 then Break;
        end;
        if p28 = nil then begin
          Cert.Free;
          Cert := nil;
        end;
        if Cert <> nil then begin
          Inc(Cert.m_nViewRange, 2); //2006-12-30 怪物视觉+2
        end;
      end;
    end;
    nCode:= 10;
    if Cert <> nil then begin
      if Cert.m_btRaceServer = 150 then begin//20090203 取守护坐标
        TPlayMonster(Cert).m_nProtectTargetX:= Cert.m_nCurrX;//守护坐标
        TPlayMonster(Cert).m_nProtectTargetY:= Cert.m_nCurrY;//守护坐标
      end;
    end;
    Result := Cert;
  except
    MainOutMessage('{异常} TUserEngine.AddBaseObject MonRace:'+ inttostr(nMonRace)+' Code:'+inttostr(nCode));
  end;
end;
//====================================================
//功能:创建怪物对象
//返回值：在指定时间内创建完对象，则返加TRUE，如果超过指定时间则返回FALSE
//====================================================
function TUserEngine.RegenMonsters(MonGen: pTMonGenInfo; nCount: Integer): Boolean;
var
  dwStartTick: LongWord;
  nX: Integer;
  nY: Integer;
  I: Integer;
  Cert: TBaseObject;
resourcestring
  sExceptionMsg = '{异常} TUserEngine::RegenMonsters';
begin
  Result := True;
  dwStartTick := GetTickCount();
  try
    if MonGen <> nil then begin
      if MonGen.nRace > 0 then begin
        if nCount <= 0 then nCount:=1;//20081008
        if Random(100) < MonGen.nMissionGenRate then begin//是否集中刷怪
          nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          for I := 0 to nCount - 1 do begin
            Cert := AddBaseObject(MonGen.sMapName, ((nX - 10) + Random(20)), ((nY - 10) + Random(20)), MonGen.nRace, MonGen.sMonName);
            if Cert <> nil then begin
              Cert.m_nChangeColorType := MonGen.nChangeColorType; //是否变色
              Cert.m_btNameColor:= MonGen.nNameColor;//自定义名字的颜色 20080810
              if MonGen.nNameColor <> 255 then Cert.m_boSetNameColor:= True;//20081001 自定义名字颜色
              Cert.m_boIsNGMonster:= MonGen.boIsNGMon;//内功怪,打死可以增加内力值 20081001
              MonGen.CertList.Add(Cert);
            end;
            if (GetTickCount - dwStartTick) > g_dwZenLimit then begin
              Result := False;
              Break;
            end;
          end;//for
        end else begin
          for I := 0 to nCount - 1 do begin
            nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
            nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
            Cert := AddBaseObject(MonGen.sMapName, nX, nY, MonGen.nRace, MonGen.sMonName);
            if Cert <> nil then begin
              Cert.m_nChangeColorType := MonGen.nChangeColorType; //是否变色
              Cert.m_btNameColor:= MonGen.nNameColor;//自定义怪物名字颜色 20080810
              if MonGen.nNameColor <> 255 then Cert.m_boSetNameColor:= True;//20081001 自定义名字颜色
              Cert.m_boIsNGMonster:= MonGen.boIsNGMon;//内功怪,打死可以增加内力值 20081001
              MonGen.CertList.Add(Cert);
            end;
            if (GetTickCount - dwStartTick) > g_dwZenLimit then begin
              Result := False;
              Break;
            end;
          end;//for
        end;
      end;
    end;  
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

//取师傅类 20080512
function TUserEngine.GetMasterObject(sName: string): TPlayObject;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := nil;
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then begin
        if (not PlayObject.m_boGhost) then begin
          if not (PlayObject.m_boPasswordLocked and PlayObject.m_boObMode and PlayObject.m_boAdminMode) then begin
            if CompareText(PlayObject.m_sMasterName, sName) = 0 then begin
               Result := PlayObject;
               Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TUserEngine.GetPlayObject(sName: string): TPlayObject;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := nil;
  if m_PlayObjectList.Count > 0 then begin
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      if CompareText(m_PlayObjectList.Strings[I], sName) = 0 then begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if PlayObject <> nil then begin
          if (not PlayObject.m_boGhost) then begin
            if not (PlayObject.m_boPasswordLocked and PlayObject.m_boObMode and PlayObject.m_boAdminMode) then
              Result := PlayObject;
          end;
          Break;
        end;
      end;
    end;
  end;
end;

function TUserEngine.GetPlayObject(PlayObject: TBaseObject): TPlayObject;
var
  I: Integer;
begin
  Result := nil;
  if m_PlayObjectList.Count > 0 then begin
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      if (PlayObject <> nil) and (PlayObject = TPlayObject(m_PlayObjectList.Objects[I])) then begin
        Result := TPlayObject(m_PlayObjectList.Objects[I]);
        Break;
      end;
    end;
  end;
end;
//20071227 按英雄名字查找英雄
function TUserEngine.GetHeroObject(sName: string): TBaseObject;
var
  I: Integer;
  PlayObject: TBaseObject;
begin
  Result := nil;
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]).m_MyHero;
      if PlayObject <> nil then begin
        if CompareText(PlayObject.m_sCharName, sName) = 0 then begin
            Result := PlayObject;
            Break;
        end;
      end;
    end;
  end;
end;

function TUserEngine.GetHeroObject(HeroObject: TBaseObject): TPlayObject;
var
  I: Integer;
begin
  Result := nil;
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      if (HeroObject <> nil) and (HeroObject = TPlayObject(m_PlayObjectList.Objects[I]).m_MyHero) then begin
        Result := TPlayObject(m_PlayObjectList.Objects[I]);
        Break;
      end;
    end;
  end;
end;
//踢出人物
procedure TUserEngine.KickPlayObjectEx(sAccount, sName: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    if m_PlayObjectList.Count > 0 then begin
      for I := 0 to m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if PlayObject <> nil then begin
          if (CompareText(PlayObject.m_sUserID, sAccount) = 0) and
            (CompareText(m_PlayObjectList.Strings[I], sName) = 0) then begin
            PlayObject.m_boEmergencyClose := True;
            PlayObject.m_boPlayOffLine := False;
            Break;
          end;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TUserEngine.GetPlayObjectEx(sAccount, sName: string): TPlayObject;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := nil;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    if m_PlayObjectList.Count > 0 then begin//20081008
      for I := 0 to m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if PlayObject <> nil then begin
          if (CompareText(PlayObject.m_sUserID, sAccount) = 0) and
            (CompareText(m_PlayObjectList.Strings[I], sName) = 0) then begin
            {if PlayObject.m_boNotOnlineAddExp then begin
              PlayObject.m_boNotOnlineAddExp := False;
            end else begin
              Result := PlayObject;
            end;}
            Result := PlayObject; //20080716 替换
            Break;
          end;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;
//获取离线挂人物
function TUserEngine.GetPlayObjectExOfAutoGetExp(sAccount: string): TPlayObject;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := nil;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    if m_PlayObjectList.Count > 0 then begin//20081008
      for I := 0 to m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if PlayObject <> nil then begin
          if (CompareText(PlayObject.m_sUserID, sAccount) = 0) and PlayObject.m_boNotOnlineAddExp then begin
            Result := PlayObject;
            Break;
          end;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;
//查找交易NPC
function TUserEngine.FindMerchant(Merchant: TObject): TMerchant;
var
  I: Integer;
begin
  Result := nil;
  m_MerchantList.Lock;
  try
    if m_MerchantList.Count > 0 then begin//20081008
      for I := 0 to m_MerchantList.Count - 1 do begin
        if (TObject(m_MerchantList.Items[I]) <> nil) and (TObject(m_MerchantList.Items[I]) = Merchant) then begin
          Result := TMerchant(m_MerchantList.Items[I]);
          Break;
        end;
      end;
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

function TUserEngine.FindNPC(GuildOfficial: TObject): TGuildOfficial;
var
  I: Integer;
begin
  Result := nil;
  if QuestNPCList.Count > 0 then begin//20081008
    for I := 0 to QuestNPCList.Count - 1 do begin
      if (TObject(QuestNPCList.Items[I]) <> nil) and (TObject(QuestNPCList.Items[I]) = GuildOfficial) then begin
        Result := TGuildOfficial(QuestNPCList.Items[I]);
        Break;
      end;
    end;
  end;
end;

function TUserEngine.GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY,
  nRange: Integer): Integer;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then begin
        if not PlayObject.m_boGhost and (PlayObject.m_PEnvir = Envir) then begin
          if (abs(PlayObject.m_nCurrX - nX) < nRange) and (abs(PlayObject.m_nCurrY - nY) < nRange) then Inc(Result);
        end;
      end;
    end;
  end;
end;
//取人物权限
function TUserEngine.GetHumPermission(sUserName: string; var sIPaddr: string; var btPermission: Byte): Boolean; //4AE590
var
  I: Integer;
  AdminInfo: pTAdminInfo;
begin
  Result := False;
  btPermission := g_Config.nStartPermission;
  m_AdminList.Lock;
  try
    if m_AdminList.Count > 0 then begin//20081008
      for I := 0 to m_AdminList.Count - 1 do begin
        AdminInfo := m_AdminList.Items[I];
        if AdminInfo <> nil then begin
          if CompareText(AdminInfo.sChrName, sUserName) = 0 then begin
            btPermission := AdminInfo.nLv;
            sIPaddr := AdminInfo.sIPaddr;
            Result := True;
            Break;
          end;
        end;
      end;
    end;
  finally
    m_AdminList.UnLock;
  end;
end;
{//20080522 注释
procedure TUserEngine.GenShiftUserData;
begin

end;}

procedure TUserEngine.AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
begin
  EnterCriticalSection(m_LoadPlaySection);
  try
    m_LoadPlayList.AddObject(UserOpenInfo.sChrName, TObject(UserOpenInfo));
  finally
    LeaveCriticalSection(m_LoadPlaySection);
  end;
end;
//踢出在线人物
procedure TUserEngine.KickOnlineUser(sChrName: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then begin
        if CompareText(PlayObject.m_sCharName, sChrName) = 0 then begin
          PlayObject.m_boKickFlag := True;
          Break;
        end;
      end;
    end;
  end;
end;

function TUserEngine.SendSwitchData(PlayObject: TPlayObject; nServerIndex: Integer): Boolean;
begin
  Result := True;
end;

procedure TUserEngine.SendChangeServer(PlayObject: TPlayObject; nServerIndex: Integer);
var
  sIPaddr: string;
  nPort: Integer;
resourcestring
  sMsg = '%s/%d';
begin
  if GetMultiServerAddrPort(nServerIndex, sIPaddr, nPort) then begin
    PlayObject.SendDefMessage(SM_RECONNECT, 0, 0, 0, 0, Format(sMsg, [sIPaddr, nPort]));
  end;
end;
//保存人数数据
procedure TUserEngine.SaveHumanRcd(PlayObject: TPlayObject);
var
  SaveRcd: pTSaveRcd;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if PlayObject <> nil then begin//20090104
      if PlayObject.m_boOperationItemList then Exit;//20080928 防止同时操作背包列表时保存
      if PlayObject.m_boRcdSaveding then Exit;//是否正在保存数据 20090106 防止同进入过程
      PlayObject.m_boRcdSaveding:= True;
      try
        New(SaveRcd);
        FillChar(SaveRcd^, SizeOf(TSaveRcd), #0);
        nCode:= 1;
        SaveRcd.sAccount := PlayObject.m_sUserID;
        SaveRcd.sChrName := PlayObject.m_sCharName;
        SaveRcd.nSessionID := PlayObject.m_nSessionID;
        SaveRcd.PlayObject := PlayObject;
        SaveRcd.nReTryCount := 0;
        SaveRcd.dwSaveTick := GetTickCount;
        SaveRcd.boIsHero := False;
        nCode:= 2;
        PlayObject.MakeSaveRcd(SaveRcd.HumanRcd);
        nCode:= 3;
        if FrontEngine.UpDataSaveRcdList(SaveRcd) then Dispose(SaveRcd);
      finally
        PlayObject.m_boRcdSaveding:= False;
      end;
    end;
  except
    MainOutMessage('{异常} TUserEngine.SaveHumanRcd Code:'+inttostr(nCode));
  end;
end;

procedure TUserEngine.SaveHeroRcd(PlayObject: TPlayObject);
var
  SaveRcd: pTSaveRcd;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if PlayObject <> nil then begin//20090106
      nCode:= 1;
      if PlayObject.m_boOperationItemList then Exit;//20080928 防止同时操作背包列表时保存
      nCode:= 2;
      if PlayObject.m_MyHero <> nil then begin
        if PlayObject.m_boRcdSaveding then Exit;//是否正在保存数据 20090106 防止同进入过程
        PlayObject.m_boRcdSaveding:= True;
        try
          New(SaveRcd);
          FillChar(SaveRcd^, SizeOf(TSaveRcd), #0);
          SaveRcd.sAccount := PlayObject.m_sUserID;
          nCode:= 3;
          SaveRcd.sChrName := PlayObject.m_MyHero.m_sCharName;
          SaveRcd.nSessionID := PlayObject.m_nSessionID;
          SaveRcd.PlayObject := PlayObject;
          SaveRcd.nReTryCount := 0;
          SaveRcd.dwSaveTick := GetTickCount;
          SaveRcd.boIsHero := True;
          nCode:= 4;
          THeroObject(PlayObject.m_MyHero).MakeSaveRcd(SaveRcd.HumanRcd);
          nCode:= 5;
          if FrontEngine.UpDataSaveRcdList(SaveRcd) then Dispose(SaveRcd);
        finally
          PlayObject.m_boRcdSaveding:= False;
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TUserEngine.SaveHeroRcd Code:'+inttostr(nCode));
  end;
end;
//加入销毁列表
procedure TUserEngine.AddToHumanFreeList(PlayObject: TPlayObject);
begin
  PlayObject.m_dwGhostTick := GetTickCount();
  m_PlayObjectFreeList.Add(PlayObject);
end;
{//20080522 注释
function TUserEngine.GetSwitchData(sChrName: string; nCode: Integer): pTSwitchDataInfo;
var
  I: Integer;
  SwitchData: pTSwitchDataInfo;
begin
  Result := nil;
  for I := 0 to m_ChangeServerList.Count - 1 do begin
    SwitchData := m_ChangeServerList.Items[I];
    if SwitchData <> nil then begin
      if (CompareText(SwitchData.sChrName, sChrName) = 0) and (SwitchData.nCode = nCode) then begin
        Result := SwitchData;
        Break;
      end;
    end;
  end;
end;  }
//取数据库人物的数据
procedure TUserEngine.GetHumData(PlayObject: TPlayObject; var HumanRcd: THumDataInfo);
var
  HumData: pTHumData;
  HumItems: pTHumItems;
  HumAddItems: pTHumAddItems;
  BagItems: pTBagItems;
  UserItem: pTUserItem;
  HumMagics: pTHumMagics;
  HumNGMagics: pTHumNGMagics;//20081001
  UserMagic: pTUserMagic;
  MagicInfo: pTMagic;
  StorageItems: pTStorageItems;
  I: Integer;
  IniFile: TIniFile;
  sFileName, sMap, sX, sY: String;
begin
  HumData := @HumanRcd.Data;
  PlayObject.m_sCharName := HumData.sChrName;
  PlayObject.m_sMapName := HumData.sCurMap;
  PlayObject.m_nCurrX := HumData.wCurX;
  PlayObject.m_nCurrY := HumData.wCurY;
  PlayObject.m_btDirection := HumData.btDir;
  PlayObject.m_btHair := HumData.btHair;
  PlayObject.m_btGender := HumData.btSex;
  PlayObject.m_btJob := HumData.btJob;
  PlayObject.m_nGold := HumData.nGold;

  PlayObject.m_sLastMapName := PlayObject.m_sMapName; //2006-01-12增加人物上次退出地图
  PlayObject.m_nLastCurrX := PlayObject.m_nCurrX; //2006-01-12增加人物上次退出所在座标X
  PlayObject.m_nLastCurrY := PlayObject.m_nCurrY; //2006-01-12增加人物上次退出所在座标Y

  PlayObject.m_Abil.Level := HumData.Abil.Level;

  PlayObject.m_Abil.HP := HumData.Abil.HP;
  PlayObject.m_Abil.MP := HumData.Abil.MP;
  PlayObject.m_Abil.MaxHP := HumData.Abil.MaxHP;
  PlayObject.m_Abil.MaxMP := HumData.Abil.MaxMP;
  PlayObject.m_Abil.Exp := HumData.Abil.Exp;
  PlayObject.m_Abil.MaxExp := HumData.Abil.MaxExp;
  PlayObject.m_Abil.Weight := HumData.Abil.Weight;
  PlayObject.m_Abil.MaxWeight := HumData.Abil.MaxWeight;
  PlayObject.m_Abil.WearWeight := HumData.Abil.WearWeight;
  PlayObject.m_Abil.MaxWearWeight := HumData.Abil.MaxWearWeight;
  PlayObject.m_Abil.HandWeight := HumData.Abil.HandWeight;
  PlayObject.m_Abil.MaxHandWeight := HumData.Abil.MaxHandWeight;
  PlayObject.m_Abil.Alcohol:= HumData.n_Reserved;//酒量 20080622
  PlayObject.m_Abil.MaxAlcohol:=  HumData.n_Reserved1;//酒量上限 20080622
  if PlayObject.m_Abil.MaxAlcohol < g_Config.nMaxAlcoholValue then PlayObject.m_Abil.MaxAlcohol:= g_Config.nMaxAlcoholValue;//酒量上限小限初始值时,则修改 20080623
  PlayObject.m_Abil.WineDrinkValue := HumData.n_Reserved2;//醉酒度 2008623
  PlayObject.n_DrinkWineQuality := HumData.btUnKnow2[2];//饮酒时酒的品质
  PlayObject.n_DrinkWineAlcohol := HumData.UnKnow[4];//饮酒时酒的度数 20080624
  PlayObject.m_btMagBubbleDefenceLevel := HumData.UnKnow[5];//魔法盾等级 20080811

  PlayObject.m_Abil.MedicineValue:= HumData.nReserved1; //当前药力值 20080623
  PlayObject.m_Abil.MaxMedicineValue:= HumData.nReserved2; //药力值上限 20080623
  PlayObject.n_DrinkWineDrunk:=  HumData.boReserved3;//人是否喝酒醉了 20080627

  PlayObject.dw_UseMedicineTime:= HumData.nReserved3; //使用药酒时间,计算长时间没使用药酒 20080623
  PlayObject.n_MedicineLevel:= HumData.n_Reserved3;  //药力值等级 20080623
  if PlayObject.n_MedicineLevel <= 0 then PlayObject.n_MedicineLevel:=1;//如果药力值等级为0,则设置为1 20080624
  if PlayObject.m_Abil.MaxMedicineValue <= 0 then
      PlayObject.m_Abil.MaxMedicineValue:= PlayObject.GetMedicineExp(PlayObject.n_MedicineLevel);

  PlayObject.m_Exp68 := HumData.Exp68;//酒气护体当前经验 20080625
  PlayObject.m_MaxExp68 := HumData.MaxExp68;//酒气护体升级经验 20080625

  PlayObject.m_boTrainingNG := HumData.UnKnow[6] <> 0;//是否学习过内功 20081002
  if PlayObject.m_boTrainingNG then PlayObject.m_NGLevel := HumData.UnKnow[7]//内功等级 20081204
  else PlayObject.m_NGLevel := 0;
  PlayObject.m_ExpSkill69 := HumData.nExpSkill69;//内功当前经验 20080930
  PlayObject.m_Skill69NH := HumData.Abil.NG;//内功当前内力值 20080930
  PlayObject.m_Skill69MaxNH := HumData.Abil.MaxNG;//内力值上限 20081001

  if PlayObject.m_Abil.Exp <= 0 then PlayObject.m_Abil.Exp := 1;
  if PlayObject.m_Abil.MaxExp <= 0 then begin
    PlayObject.m_Abil.MaxExp := PlayObject.GetLevelExp(PlayObject.m_Abil.Level);
  end;

  PlayObject.m_wStatusTimeArr := HumData.wStatusTimeArr;
  PlayObject.m_sHomeMap := HumData.sHomeMap;
  PlayObject.m_nHomeX := HumData.wHomeX;
  PlayObject.m_nHomeY := HumData.wHomeY;
  PlayObject.m_BonusAbil := HumData.BonusAbil; // 08/09
  PlayObject.m_nBonusPoint := HumData.nBonusPoint; // 08/09
  PlayObject.m_btCreditPoint := HumData.btCreditPoint;
  PlayObject.m_btReLevel := HumData.btReLevel;

  PlayObject.m_sMasterName := HumData.sMasterName;
  PlayObject.m_boMaster := HumData.boMaster;
  if PlayObject.m_boMaster or (PlayObject.m_sMasterName <> '') then PlayObject.GetMasterNoList();//20080530 取师徒数据
  PlayObject.m_sDearName := HumData.sDearName;

  PlayObject.m_sStoragePwd := HumData.sStoragePwd;
  if PlayObject.m_sStoragePwd <> '' then PlayObject.m_boPasswordLocked := True;

  PlayObject.m_nGameGold := HumData.nGameGold;
  PlayObject.m_nGameDiaMond:= HumData.nGameDiaMond; //20071226 金刚石
  PlayObject.m_nGameGird:= HumData.nGameGird; //20071226 灵符

 // if g_Config.boSaveExpRate then begin //是否保存双倍经验时间 20080412
    PlayObject.m_nKillMonExpRate:= HumData.nEXPRATE; //20071230 经验倍数
    PlayObject.m_dwKillMonExpRateTime:= HumData.nExpTime; //20071230 经验倍数时间
    PlayObject.m_nOldKillMonExpRate := PlayObject.m_nKillMonExpRate;//20080607
    if PlayObject.m_nKillMonExpRate <= 0 then PlayObject.m_nKillMonExpRate:= 100;//20081229
 // end;

  PlayObject.m_nGamePoint := HumData.nGamePoint;
  PlayObject.m_nPayMentPoint := HumData.nPayMentPoint;

  PlayObject.m_btGameGlory := HumData.btGameGlory; //荣誉 20080511

  PlayObject.m_nPkPoint := HumData.nPKPOINT;
  if HumData.btAllowGroup > 0 then PlayObject.m_boAllowGroup := True
  else PlayObject.m_boAllowGroup := False;
  PlayObject.btB2 := HumData.btF9;
  PlayObject.m_btAttatckMode := HumData.btAttatckMode;
  PlayObject.m_nIncHealth := HumData.btIncHealth;
  PlayObject.m_nIncSpell := HumData.btIncSpell;
  PlayObject.m_nIncHealing := HumData.btIncHealing;
  PlayObject.m_nFightZoneDieCount := HumData.btFightZoneDieCount;
  PlayObject.m_sUserID := HumData.sAccount;
  //PlayObject.nC4 := HumData.btEE;//20081007 注释，nC4无实际用处
  PlayObject.m_boLockLogon := HumData.boLockLogon;

  PlayObject.m_wContribution := HumData.wContribution;
  PlayObject.m_nHungerStatus := HumData.nHungerStatus;
  PlayObject.m_boAllowGuildReCall := HumData.boAllowGuildReCall;
  PlayObject.m_wGroupRcallTime := HumData.wGroupRcallTime;
  PlayObject.m_dBodyLuck := HumData.dBodyLuck;
  PlayObject.m_boAllowGroupReCall := HumData.boAllowGroupReCall;
  {PlayObject.m_QuestUnitOpen := HumData.QuestUnitOpen;
  PlayObject.m_QuestUnit := HumData.QuestUnit; }
  PlayObject.m_btLastOutStatus := HumData.btLastOutStatus; //退出状态 1为死亡
  PlayObject.m_wMasterCount := HumData.wMasterCount; //出师徒弟数
  PlayObject.bo_YBDEAL:= HumData.btUnKnow2[0]= 1;//是否开通元宝寄售 20080316
  PlayObject.m_nWinExp := HumData.n_WinExp;//20080221 聚灵珠  累计经验
  PlayObject.n_UsesItemTick:= HumData.n_UsesItemTick ;//聚灵珠聚集时间 20080221
  PlayObject.m_QuestFlag := HumData.QuestFlag;
  PlayObject.m_boHasHero := HumData.boHasHero;
  PlayObject.m_boHasHeroTwo := HumData.boReserved1;//20080519 是否有卧龙英雄
  PlayObject.m_sHeroCharName := HumData.sHeroChrName;
  PlayObject.n_HeroSave := HumData.btUnKnow2[1];//是否保存英雄 20080513
  PlayObject.n_myHeroTpye := HumData.btEF;//角色身上带的英雄所属的类型  20080515
  PlayObject.m_boPlayDrink:= HumData.boReserved;//是否请过酒 T-请过酒 20080515

  PlayObject.m_GiveGuildFountationDate:=HumData.m_GiveDate;//人物领取行会酒泉日期 20080625
  PlayObject.m_boMakeWine:= HumData.boReserved2;//是否酿酒 20080620
  PlayObject.m_MakeWineTime:= HumData.nReserved;//酿酒的时间,即还有多长时间可以取回酒 20080620
  PlayObject.n_MakeWineItmeType:=HumData.UnKnow[0];//酿酒后,应该可以得到酒的类型 2008020
  PlayObject.n_MakeWineType:= HumData.UnKnow[1];//酿酒的类型 1-普通酒 2-药酒  20080620
  PlayObject.n_MakeWineQuality:= HumData.UnKnow[2];//酿酒后,应该可以得到酒的品质 20080620
  PlayObject.n_MakeWineAlcohol:= HumData.UnKnow[3];//酿酒后,应该可以得到酒的酒精度 20080620

  HumItems := @HumanRcd.Data.HumItems;

  PlayObject.m_UseItems[U_DRESS] := HumItems[U_DRESS];
  PlayObject.m_UseItems[U_WEAPON] := HumItems[U_WEAPON];
  PlayObject.m_UseItems[U_RIGHTHAND] := HumItems[U_RIGHTHAND];
  PlayObject.m_UseItems[U_NECKLACE] := HumItems[U_HELMET];
  PlayObject.m_UseItems[U_HELMET] := HumItems[U_NECKLACE];
  PlayObject.m_UseItems[U_ARMRINGL] := HumItems[U_ARMRINGL];
  PlayObject.m_UseItems[U_ARMRINGR] := HumItems[U_ARMRINGR];
  PlayObject.m_UseItems[U_RINGL] := HumItems[U_RINGL];
  PlayObject.m_UseItems[U_RINGR] := HumItems[U_RINGR];

  HumAddItems := @HumanRcd.Data.HumAddItems;
  PlayObject.m_UseItems[U_BUJUK] := HumAddItems[U_BUJUK];
  PlayObject.m_UseItems[U_BELT] := HumAddItems[U_BELT];
  PlayObject.m_UseItems[U_BOOTS] := HumAddItems[U_BOOTS];
  PlayObject.m_UseItems[U_CHARM] := HumAddItems[U_CHARM];
  PlayObject.m_UseItems[U_ZHULI] := HumAddItems[U_ZHULI];//20080416 斗笠

  BagItems := @HumanRcd.Data.BagItems;
  for I := Low(TBagItems) to High(TBagItems) do begin
    if BagItems[I].wIndex > 0 then begin
      New(UserItem);
      FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 增加
      //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 增加
      UserItem^ := BagItems[I];
      PlayObject.m_ItemList.Add(UserItem);
    end;
  end;
  HumMagics := @HumanRcd.Data.HumMagics;
  for I := Low(THumMagics) to High(THumMagics) do begin
    MagicInfo := UserEngine.FindMagic(HumMagics[I].wMagIdx);
    if MagicInfo <> nil then begin
      New(UserMagic);
      UserMagic.MagicInfo := MagicInfo;
      UserMagic.wMagIdx := HumMagics[I].wMagIdx;
      UserMagic.btLevel := HumMagics[I].btLevel;
      UserMagic.btKey := HumMagics[I].btKey;
      UserMagic.nTranPoint := HumMagics[I].nTranPoint;
      PlayObject.m_MagicList.Add(UserMagic);
    end;
  end;
  HumNGMagics:= @HumanRcd.Data.HumNGMagics;//20081001 内功技能
  for I := Low(THumNGMagics) to High(THumNGMagics) do begin//内功技能 20081001
    MagicInfo := UserEngine.FindMagic(HumNGMagics[I].wMagIdx);
    if MagicInfo <> nil then begin
      New(UserMagic);
      UserMagic.MagicInfo := MagicInfo;
      UserMagic.wMagIdx := HumNGMagics[I].wMagIdx;
      UserMagic.btLevel := HumNGMagics[I].btLevel;
      UserMagic.btKey := HumNGMagics[I].btKey;
      UserMagic.nTranPoint := HumNGMagics[I].nTranPoint;
      PlayObject.m_MagicList.Add(UserMagic);
    end;
  end;
  StorageItems := @HumanRcd.Data.StorageItems;
  for I := Low(TStorageItems) to High(TStorageItems) do begin//仓库物品
    if StorageItems[I].wIndex > 0 then begin
      New(UserItem);
      FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 增加
      //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 增加
      UserItem^ := StorageItems[I];
      PlayObject.m_StorageItemList.Add(UserItem);
    end;
  end;
  PlayObject.m_BigStorageItemList := g_Storage.GetUserBigStorageList(PlayObject.m_sCharName);//获取无限仓库数据

  //读取记路标石记录的地图及XY值 20081019
  sFileName := g_Config.sEnvirDir + 'UserData\HumRecallPoint.txt';
  if FileExists(sFileName) then begin
    IniFile := TIniFile.Create(sFileName);
    Try
      for I:= 1 to 6 do begin
        sY:= IniFile.ReadString( PlayObject.m_sCharName , '记录'+inttostr(I), '');
        sY := GetValidStr3(sY, sMap, [',']);
        if sMap <> '' then begin
          sY := GetValidStr3(sY, sX, [',']);
          PlayObject.m_TagMapInfos[I].TagMapName:= sMap;
          PlayObject.m_TagMapInfos[I].TagX:= Str_ToInt(sX, 0);
          PlayObject.m_TagMapInfos[I].TagY:= Str_ToInt(sY, 0);
        end;
      end;
    finally
      IniFile.Free;
    end;
  end;
end;
//取英雄数据
procedure TUserEngine.GetHeroData(BaseObject: TBaseObject; var HumanRcd: THumDataInfo);
var
  HumData: pTHumData;
  HumItems: pTHumItems;
  HumAddItems: pTHumAddItems;
  BagItems: pTBagItems;
  UserItem: pTUserItem;
  HumMagics: pTHumMagics;
  HumNGMagics: pTHumNGMagics;//20081001
  UserMagic: pTUserMagic;
  MagicInfo: pTMagic;
  //StorageItems: pTStorageItems;
  I: Integer;
  HeroObject: THeroObject;
begin
  HeroObject := THeroObject(BaseObject);
  HumData := @HumanRcd.Data;
  HeroObject.m_sCharName := HumData.sChrName;
  HeroObject.m_sMapName := HumData.sCurMap;
  HeroObject.m_nCurrX := HumData.wCurX;
  HeroObject.m_nCurrY := HumData.wCurY;
  HeroObject.m_btDirection := HumData.btDir;
  HeroObject.m_btHair := HumData.btHair;
  HeroObject.m_btGender := HumData.btSex;
  HeroObject.m_btJob := HumData.btJob;
  HeroObject.m_nFirDragonPoint := HumData.nGold;//金币数变量用来保存怒气值 20080419
  //PlayObject.m_nGold := HumData.nGold;

  //HeroObject.m_sLastMapName := PlayObject.m_sMapName; //2006-01-12增加人物上次退出地图
  //HeroObject.m_nLastCurrX := HeroObject.m_nCurrX; //2006-01-12增加人物上次退出所在座标X
  //HeroObject.m_nLastCurrY := HeroObject.m_nCurrY; //2006-01-12增加人物上次退出所在座标Y

  HeroObject.m_Abil.Level := HumData.Abil.Level;
  HeroObject.m_Abil.HP := HumData.Abil.HP;
  HeroObject.m_Abil.MP := HumData.Abil.MP;
  HeroObject.m_Abil.MaxHP := HumData.Abil.MaxHP;
  HeroObject.m_Abil.MaxMP := HumData.Abil.MaxMP;
  HeroObject.m_Abil.Exp := HumData.Abil.Exp;
  HeroObject.m_Abil.MaxExp := HumData.Abil.MaxExp;
  HeroObject.m_Abil.Weight := HumData.Abil.Weight;
  HeroObject.m_Abil.MaxWeight := HumData.Abil.MaxWeight;
  HeroObject.m_Abil.WearWeight := HumData.Abil.WearWeight;
  HeroObject.m_Abil.MaxWearWeight := HumData.Abil.MaxWearWeight;
  HeroObject.m_Abil.HandWeight := HumData.Abil.HandWeight;
  HeroObject.m_Abil.MaxHandWeight := HumData.Abil.MaxHandWeight;
  HeroObject.m_Abil.Alcohol:= HumData.n_Reserved;//酒量 20080622
  HeroObject.m_Abil.MaxAlcohol:=  HumData.n_Reserved1;//酒量上限 20080622
  if HeroObject.m_Abil.MaxAlcohol < g_Config.nMaxAlcoholValue then HeroObject.m_Abil.MaxAlcohol:= g_Config.nMaxAlcoholValue;//酒量上限小限初始值时,则修改 20080623
  HeroObject.m_Abil.WineDrinkValue := HumData.n_Reserved2;//醉酒度 2008623
  HeroObject.n_DrinkWineQuality := HumData.btUnKnow2[2];//饮酒时酒的品质
  HeroObject.n_DrinkWineAlcohol:= HumData.UnKnow[4];//饮酒时酒的度数 20080624
  HeroObject.m_btMagBubbleDefenceLevel := HumData.UnKnow[5];//魔法盾等级 20080811

  HeroObject.m_Exp68:= HumData.Exp68;//酒气护体当前经验 20080925
  HeroObject.m_MaxExp68:= HumData.MaxExp68;//酒气护体升级经验 20080925

  HeroObject.m_boTrainingNG := HumData.UnKnow[6] <> 0;//是否学习过内功 20081002
  if HeroObject.m_boTrainingNG then HeroObject.m_NGLevel := HumData.UnKnow[7]//内功等级 20081002
  else HeroObject.m_NGLevel := 0;
  HeroObject.m_ExpSkill69 := HumData.nExpSkill69;//内功当前经验 20080930
  HeroObject.m_Skill69NH := HumData.Abil.NG;//内功当前内力值 20080930
  HeroObject.m_Skill69MaxNH := HumData.Abil.MaxNG;//内力值上限 20081001

  HeroObject.m_Abil.MedicineValue:= HumData.nReserved1; //当前药力值 20080623
  HeroObject.m_Abil.MaxMedicineValue:= HumData.nReserved2; //药力值上限 20080623
  HeroObject.n_DrinkWineDrunk:=  HumData.boReserved3;//人是否喝酒醉了 20080627
  HeroObject.dw_UseMedicineTime:= HumData.nReserved3; //使用药酒时间,计算长时间没使用药酒 20080623
  HeroObject.n_MedicineLevel:= HumData.n_Reserved3;  //药力值等级 20080623
  if HeroObject.n_MedicineLevel <= 0 then HeroObject.n_MedicineLevel:=1;//如果药力值等级为0,则设置为1 20080624
  if HeroObject.m_Abil.MaxMedicineValue <= 0 then//药力值经验为0时,取设置的经验 20080624
      HeroObject.m_Abil.MaxMedicineValue:= HeroObject.GetMedicineExp(HeroObject.n_MedicineLevel);

  {if HeroObject.m_Abil.Exp <= 0 then HeroObject.m_Abil.Exp := 1;
  if HeroObject.m_Abil.MaxExp <= 0 then begin
    HeroObject.m_Abil.MaxExp := HeroObject.GetLevelExp(HeroObject.m_Abil.Level);
  end;}
  //PlayObject.m_Abil:=HumData.Abil;

  HeroObject.m_wStatusTimeArr := HumData.wStatusTimeArr;
  HeroObject.m_sHomeMap := HumData.sHomeMap;
  HeroObject.m_nHomeX := HumData.wHomeX;
  HeroObject.m_nHomeY := HumData.wHomeY;
  HeroObject.m_BonusAbil := HumData.BonusAbil;//20081126 英雄永久属性
  HeroObject.m_nBonusPoint := HumData.nBonusPoint; // 08/09
  HeroObject.m_btCreditPoint := HumData.btCreditPoint;
  HeroObject.m_btReLevel := HumData.btReLevel;

  HeroObject.m_nWinExp :=HumData.n_WinExp;//英雄累计经验值 20080110
  HeroObject.m_nLoyal :=HumData.nLoyal;
  if HeroObject.m_nLoyal >10000 then HeroObject.m_nLoyal :=10000;
  
  HeroObject.m_btLastOutStatus := HumData.btLastOutStatus; //退出状态 1为死亡
  //HeroObject.m_sMasterName := m_Master.;
  //HeroObject.m_boMaster := HumData.boMaster;
  //HeroObject.m_sDearName := HumData.sDearName;

  {HeroObject.m_sStoragePwd := HumData.sStoragePwd;
  if PlayObject.m_sStoragePwd <> '' then
    PlayObject.m_boPasswordLocked := True; }

  {PlayObject.m_nGameGold := HumData.nGameGold;
  PlayObject.m_nGamePoint := HumData.nGamePoint;
  PlayObject.m_nPayMentPoint := HumData.nPayMentPoint; }

  HeroObject.m_nPkPoint := HumData.nPKPOINT;
  {if HumData.btAllowGroup > 0 then PlayObject.m_boAllowGroup := True
  else PlayObject.m_boAllowGroup := False; }
  HeroObject.btB2 := HumData.btF9;
  HeroObject.m_btAttatckMode := HumData.btAttatckMode;
  HeroObject.m_nIncHealth := HumData.btIncHealth;
  HeroObject.m_nIncSpell := HumData.btIncSpell;
  HeroObject.m_nIncHealing := HumData.btIncHealing;
  HeroObject.m_nFightZoneDieCount := HumData.btFightZoneDieCount;
  //HeroObject.m_sUserID := HumData.sAccount;
  //HeroObject.nC4 := HumData.btEE;//20081007 注释，nC4无实际用处
  HeroObject.n_HeroTpye:= HumData.btEF;//英雄类型 0-白日门英雄 1-卧龙英雄 20080514
  //HeroObject.m_boLockLogon := HumData.boLockLogon;

  //HeroObject.m_wContribution := HumData.wContribution;
  //HeroObject.m_nHungerStatus := HumData.nHungerStatus;
  //HeroObject.m_boAllowGuildReCall := HumData.boAllowGuildReCall;
  //HeroObject.m_wGroupRcallTime := HumData.wGroupRcallTime;
  HeroObject.m_dBodyLuck := HumData.dBodyLuck;
  //HeroObject.m_boAllowGroupReCall := HumData.boAllowGroupReCall;

  //PlayObject.m_wMasterCount := HumData.wMasterCount; //出师徒弟数

  HeroObject.m_QuestFlag := HumData.QuestFlag;
  //HeroObject.m_boHasHero := HumData.boHasHero;
  HeroObject.m_btStatus := HumData.btStatus; //英雄的状态 20080717
  if HeroObject.m_Abil.Level <= 22 then HeroObject.m_btStatus := 1;//20080710 22级之前,默认跟随

  HumItems := @HumanRcd.Data.HumItems;
  HeroObject.m_UseItems[U_DRESS] := HumItems[U_DRESS];
  HeroObject.m_UseItems[U_WEAPON] := HumItems[U_WEAPON];
  HeroObject.m_UseItems[U_RIGHTHAND] := HumItems[U_RIGHTHAND];
  HeroObject.m_UseItems[U_NECKLACE] := HumItems[U_HELMET];
  HeroObject.m_UseItems[U_HELMET] := HumItems[U_NECKLACE];
  HeroObject.m_UseItems[U_ARMRINGL] := HumItems[U_ARMRINGL];
  HeroObject.m_UseItems[U_ARMRINGR] := HumItems[U_ARMRINGR];
  HeroObject.m_UseItems[U_RINGL] := HumItems[U_RINGL];
  HeroObject.m_UseItems[U_RINGR] := HumItems[U_RINGR];

  HumAddItems := @HumanRcd.Data.HumAddItems;
  HeroObject.m_UseItems[U_BUJUK] := HumAddItems[U_BUJUK];
  HeroObject.m_UseItems[U_BELT] := HumAddItems[U_BELT];
  HeroObject.m_UseItems[U_BOOTS] := HumAddItems[U_BOOTS];
  HeroObject.m_UseItems[U_CHARM] := HumAddItems[U_CHARM];
  HeroObject.m_UseItems[U_ZHULI] := HumAddItems[U_ZHULI];//20080416 斗笠
  BagItems := @HumanRcd.Data.BagItems;
  for I := Low(TBagItems) to High(TBagItems) do begin
    if BagItems[I].wIndex > 0 then begin
      New(UserItem);
      FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 增加
      //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 增加
      UserItem^ := BagItems[I];
      HeroObject.m_ItemList.Add(UserItem);
    end;
  end;
  HumMagics := @HumanRcd.Data.HumMagics;
  for I := Low(THumMagics) to High(THumMagics) do begin
    MagicInfo := UserEngine.FindHeroMagic(HumMagics[I].wMagIdx);
    if MagicInfo <> nil then begin
      New(UserMagic);
      UserMagic.MagicInfo := MagicInfo;
      UserMagic.wMagIdx := HumMagics[I].wMagIdx;
      UserMagic.btLevel := HumMagics[I].btLevel;
      UserMagic.btKey := HumMagics[I].btKey;//魔法快捷键(即魔法开关)
      UserMagic.nTranPoint := HumMagics[I].nTranPoint;
      HeroObject.m_MagicList.Add(UserMagic);
    end;
  end;
  HumNGMagics:= @HumanRcd.Data.HumNGMagics;//20081001 内功技能
  for I := Low(THumNGMagics) to High(THumNGMagics) do begin//内功技能 20081001
    MagicInfo := UserEngine.FindMagic(HumNGMagics[I].wMagIdx);
    if MagicInfo <> nil then begin
      New(UserMagic);
      UserMagic.MagicInfo := MagicInfo;
      UserMagic.wMagIdx := HumNGMagics[I].wMagIdx;
      UserMagic.btLevel := HumNGMagics[I].btLevel;
      UserMagic.btKey := HumNGMagics[I].btKey;
      UserMagic.nTranPoint := HumNGMagics[I].nTranPoint;
      HeroObject.m_MagicList.Add(UserMagic);
    end;
  end;
end;
//取回城数据
function TUserEngine.GetHomeInfo(var nX, nY: Integer): string;
var
  I: Integer;
//  nXY: Integer;
begin
  g_StartPointList.Lock;
  try
    if g_StartPointList.Count > 0 then begin
      if g_StartPointList.Count > g_Config.nStartPointSize {1} then I := Random(g_Config.nStartPointSize {2})
      else I := 0;
      Result := GetStartPointInfo(I, nX, nY); //g_StartPointList.Strings[i];
    end else begin
      Result := g_Config.sHomeMap;
      nX := g_Config.nHomeX;
      nX := g_Config.nHomeY;
    end;
  finally
    g_StartPointList.UnLock;
  end;
end;

function TUserEngine.GetRandHomeX(PlayObject: TPlayObject): Integer;
begin
  Result := Random(3) + (PlayObject.m_nHomeX - 2);
end;

function TUserEngine.GetRandHomeY(PlayObject: TPlayObject): Integer;
begin
  Result := Random(3) + (PlayObject.m_nHomeY - 2);
end;

procedure TUserEngine.LoadSwitchData(SwitchData: pTSwitchDataInfo; var
  PlayObject: TPlayObject);
var
  nCount: Integer;
  SlaveInfo: pTSlaveInfo;
begin
  if SwitchData.boC70 then begin

  end;
  PlayObject.m_boBanShout := SwitchData.boBanShout;
  PlayObject.m_boHearWhisper := SwitchData.boHearWhisper;
  PlayObject.m_boBanGuildChat := SwitchData.boBanGuildChat;
  PlayObject.m_boBanGuildChat := SwitchData.boBanGuildChat;
  PlayObject.m_boAdminMode := SwitchData.boAdminMode;
  PlayObject.m_boObMode := SwitchData.boObMode;
  nCount := 0;
  while (True) do begin
    if SwitchData.BlockWhisperArr[nCount] = '' then Break;
    PlayObject.m_BlockWhisperList.Add(SwitchData.BlockWhisperArr[nCount]);
    Inc(nCount);
    if nCount >= High(SwitchData.BlockWhisperArr) then Break;
  end;
  nCount := 0;
  while (True) do begin
    if SwitchData.SlaveArr[nCount].sSalveName = '' then Break;
    New(SlaveInfo);
    SlaveInfo^ := SwitchData.SlaveArr[nCount];
    PlayObject.SendDelayMsg(PlayObject, RM_10401, 0, Integer(SlaveInfo), 0, 0, '', 500);
    Inc(nCount);
    if nCount >= 5 then Break;
  end;
  nCount := 0;
  while (True) do begin
    PlayObject.m_wStatusArrValue[nCount] := SwitchData.StatusValue[nCount];
    PlayObject.m_dwStatusArrTimeOutTick[nCount] := SwitchData.StatusTimeOut[nCount];
    Inc(nCount);
    if nCount >= 6 then Break;
  end;
end;

procedure TUserEngine.DelSwitchData(SwitchData: pTSwitchDataInfo);
var
  I: Integer;
  SwitchDataInfo: pTSwitchDataInfo;
begin
  I := 0;
  while True do begin //for i := 0 to m_ChangeServerList.Count - 1 do begin
    if I >= m_ChangeServerList.Count then Break;
    if m_ChangeServerList.Count <= 0 then Break;
    SwitchDataInfo := m_ChangeServerList.Items[I];
    if (SwitchDataInfo <> nil) and (SwitchDataInfo = SwitchData) then begin
      Dispose(SwitchDataInfo);
      m_ChangeServerList.Delete(I);
      Break;
    end;
    Inc(I);
  end; // for
end;
//查找魔法
function TUserEngine.FindMagic(nMagIdx: Integer): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
  MagicList: TList;
begin
  Result := nil;
  if (m_boStartLoadMagic) and (OldMagicList.Count > 0) then begin
    MagicList := TList(OldMagicList.Items[OldMagicList.Count - 1]);
    if MagicList <> nil then begin
      if MagicList.Count > 0 then begin//20081008
        for I := 0 to MagicList.Count - 1 do begin
          Magic := MagicList.Items[I];
          if (Magic <> nil) and ((Magic.sDescr = '') or (Magic.sDescr = '内功')) then begin
            if Magic.wMagicId = nMagIdx then begin
              Result := Magic;
              Break;
            end;
          end;
        end;//for
      end;
    end;
  end else begin
    if m_MagicList.Count > 0 then begin//20081008
      for I := 0 to m_MagicList.Count - 1 do begin
        Magic := m_MagicList.Items[I];
        if (Magic <> nil) and ((Magic.sDescr = '') or (Magic.sDescr = '内功')) then begin
          if Magic.wMagicId = nMagIdx then begin
            Result := Magic;
            Break;
          end;
        end;
      end;//for
    end;
  end;
end;

function TUserEngine.FindHeroMagic(nMagIdx: Integer): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
  MagicList: TList;
begin
  Result := nil;
  if (m_boStartLoadMagic) and (OldMagicList.Count > 0) then begin
    MagicList := TList(OldMagicList.Items[OldMagicList.Count - 1]);
    if MagicList <> nil then begin
      if MagicList.Count > 0 then begin//20081008
        for I := 0 to MagicList.Count - 1 do begin
          Magic := MagicList.Items[I];
          if (Magic <> nil) and ((Magic.sDescr = '英雄') or (Magic.sDescr = '内功')) then begin
            if Magic.wMagicId = nMagIdx then begin
              Result := Magic;
              Break;
            end;
          end;
        end;//for
      end;
    end;
  end else begin
    if m_MagicList.Count > 0 then begin//20081008
      for I := 0 to m_MagicList.Count - 1 do begin
        Magic := m_MagicList.Items[I];
        if (Magic <> nil) and ((Magic.sDescr = '英雄') or (Magic.sDescr = '内功')) then begin
          if Magic.wMagicId = nMagIdx then begin
            Result := Magic;
            Break;
          end;
        end;
      end;//for
    end;
  end;
end;
//怪物初始化
procedure TUserEngine.MonInitialize(BaseObject: TBaseObject; sMonName: string);
var
  I: Integer;
  Monster: pTMonInfo;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if MonsterList.Count > 0 then begin
      nCode:= 1;
      for I := 0 to MonsterList.Count - 1 do begin
        Monster := MonsterList.Items[I];
        nCode:= 2;
        if Monster <> nil then begin
          nCode:= 3;
          if (CompareText(Monster.sName, sMonName) = 0) and (BaseObject <> nil) then begin
            nCode:= 4;
            BaseObject.m_btRaceServer := Monster.btRace;
            BaseObject.m_btRaceImg := Monster.btRaceImg;
            BaseObject.m_wAppr := Monster.wAppr;
            BaseObject.m_Abil.Level := Monster.wLevel;
            BaseObject.m_btLifeAttrib := Monster.btLifeAttrib;//不死系
            BaseObject.m_btCoolEye := Monster.wCoolEye;//可视范围
            BaseObject.m_dwFightExp := Monster.dwExp;
            BaseObject.m_Abil.HP := Monster.wHP;
            BaseObject.m_Abil.MaxHP := Monster.wHP;
            nCode:= 5;
            BaseObject.m_btMonsterWeapon := LoByte(Monster.wMP);
            //BaseObject.m_Abil.MP:=Monster.wMP;
            BaseObject.m_Abil.MP := 0;
            BaseObject.m_Abil.MaxMP := Monster.wMP;
            nCode:= 6;
            BaseObject.m_Abil.AC := MakeLong(Monster.wAC, Monster.wAC);
            BaseObject.m_Abil.MAC := MakeLong(Monster.wMAC, Monster.wMAC);
            BaseObject.m_Abil.DC := MakeLong(Monster.wDC, Monster.wMaxDC);
            BaseObject.m_Abil.MC := MakeLong(Monster.wMC, Monster.wMC);
            BaseObject.m_Abil.SC := MakeLong(Monster.wSC, Monster.wSC);
            nCode:= 7;
            BaseObject.m_btSpeedPoint := _MIN(High(Byte),Monster.wSpeed);//20081204 由于 m_btSpeedPoint为Byte，所以需判断
            nCode:= 8;
            BaseObject.m_btHitPoint := _MIN(High(Byte),Monster.wHitPoint);//20081204 由于 m_btHitPoint为Byte，所以需判断
            nCode:= 9;
            BaseObject.m_nWalkSpeed := Monster.wWalkSpeed;//行走速度
            BaseObject.m_nWalkStep := Monster.wWalkStep;
            BaseObject.m_dwWalkWait := Monster.wWalkWait;
            BaseObject.m_nNextHitTime := Monster.wAttackSpeed;//攻击速度
            nCode:= 10;
            Break;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TUserEngine.MonInitialize Name:'+ sMonName+' Code:'+Inttostr(nCode));
  end;
end;
//打开门
function TUserEngine.OpenDoor(Envir: TEnvirnoment; nX,
  nY: Integer): Boolean;
var
  Door: pTDoorInfo;
begin
  Result := False;
  Door := Envir.GetDoor(nX, nY);
  if (Door <> nil) and not Door.Status.boOpened and not Door.Status.bo01 then begin
    Door.Status.boOpened := True;
    Door.Status.dwOpenTick := GetTickCount();
    SendDoorStatus(Envir, nX, nY, RM_DOOROPEN, 0, nX, nY, 0, '');
    Result := True;
  end;
end;
//关闭门
function TUserEngine.CloseDoor(Envir: TEnvirnoment; Door: pTDoorInfo): Boolean;
begin
  Result := False;
  if (Door <> nil) and (Door.Status.boOpened) then begin
    Door.Status.boOpened := False;
    SendDoorStatus(Envir, Door.nX, Door.nY, RM_DOORCLOSE, 0, Door.nX, Door.nY, 0, '');
    Result := True;
  end;
end;
//发送门的状态
procedure TUserEngine.SendDoorStatus(Envir: TEnvirnoment; nX, nY: Integer;
  wIdent, wX: Word; nDoorX, nDoorY, nA: Integer; sStr: string);
var
  I: Integer;
  n10, n14: Integer;
  n1C, n20, n24, n28: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  n1C := nX - 12;
  n24 := nX + 12;
  n20 := nY - 12;
  n28 := nY + 12;
  if n1C < 0 then n1C:= 0;//20080629
  if n20 < 0 then n20:= 0;//20080629
  if Envir <> nil then begin
    for n10 := n1C to n24 do begin
      for n14 := n20 to n28 do begin
        if Envir.GetMapCellInfo(n10, n14, MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          if MapCellInfo.ObjList.Count > 0 then begin//20080629
            for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              OSObject := pTOSObject(MapCellInfo.ObjList.Items[I]);
              if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
                BaseObject := TBaseObject(OSObject.CellObj);
                if (BaseObject <> nil) and
                  (not BaseObject.m_boGhost) and
                  (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                  BaseObject.SendMsg(BaseObject, wIdent, wX, nDoorX, nDoorY, nA, sStr);
                end;
              end;
            end;//for
          end;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessMapDoor;
var
  I: Integer;
  II: Integer;
  Envir: TEnvirnoment;
  Door: pTDoorInfo;
begin
  if g_MapManager.Count > 0 then begin//20081008
    for I := 0 to g_MapManager.Count - 1 do begin
      Envir := TEnvirnoment(g_MapManager.Items[I]);
      if Envir <> nil then begin
        if Envir.m_DoorList.Count > 0 then begin//20081008
          for II := 0 to Envir.m_DoorList.Count - 1 do begin
            Door := Envir.m_DoorList.Items[II];
            if Door <> nil then begin
              if Door.Status.boOpened then begin
                if (GetTickCount - Door.Status.dwOpenTick) > 5000{5 * 1000} then CloseDoor(Envir, Door);
              end;
            end;
          end;//for
        end;
      end;
    end;
  end;
end;
//-----------------------------------------------------------------------------
//闪电  地上冒岩浆 20080327
procedure TUserEngine.ProcessEffects; //20080327
var
  I , II{, III}, X, Y:Integer;
  Envir :TEnvirnoment;
  Amount:Integer;
begin
  if m_boProcessEffects then Exit;
  m_boProcessEffects:=True;
  try
    try
      if EffectList.Count > 0 then begin//20080629
        for I:= 0 to EffectList.Count - 1 do begin
          Envir:= TEnvirnoment(EffectList.Items[I]);
          if Envir <> nil then begin
            if (Envir.nThunder <> 0) or (Envir.nLava <> 0) then begin //闪电,岩浆效果
              Amount:= GetMapHuman(Envir.sMapName);//取地图人物数
              if Amount = 0 then  Continue;
              //Amount:=(Amount * 2) * ((Envir.m_nWidth * Envir.m_nHeight) div {2500}3500);
              Amount:={Amount * }(Envir.m_nWidth * Envir.m_nHeight) div 3200;

              for II:= 0 to Amount do begin //0-50
                x:= Random(Envir.m_nWidth);
                y:= Random(Envir.m_nHeight);
                {III:=0;
                while (Envir.CanWalk(x,y,TRUE) = TRUE) and (III <= 9) do
                begin
                  Inc(III);
                end;}
                if Envir.CanWalk(x,y,TRUE) then EffectTarget(x,y,Envir);
              end;
            end;
          end;
        end;//20080408
        //envir:=nil;//20080408 未使用
      end;
    except
      MainOutMessage('{异常} TUserEngine.ProcessEffects');
    end;
  finally
    m_boProcessEffects:= False;
  end;
end;

procedure TUserEngine.EffectTarget(x,y:Integer;Envir:TEnvirnoment);
var
  Target,BaseObject:TBaseObject;
  Dmg , magpwr:Integer;
  i:Integer;
  freshbaseobject:TBaseObject;
  nCode: byte;
begin
  Dmg:= 0;//20080522
  nCode:= 0;
  try
    Target:= FindNearbyTarget(x,y,Envir,m_TargetList);//查找目标
    nCode:= 22;
    if (Target = nil) then Exit;
    nCode:= 1;
    if Random(3) = 0 then begin
      x:=Target.m_nCurrX;
      y:=Target.m_nCurrY;
    end else begin//20080726 增加
      Envir.GetNextPosition(Target.m_nCurrX,Target.m_nCurrY, Random(8),Random(4)+1, X, Y);
    end;
    nCode:= 2;
    //xTargetList := TList.Create;
    m_TargetList.Clear;
    if (Envir.nThunder <> 0) and (Envir.nLava <> 0) then begin
      case Random(2) of
        0:begin
          nCode:= 3;
          If Envir.nThunder <> 0 then begin
            nCode:= 4;
            Target.SendRefMsg(RM_10205,0,x,y,10,'');
            nCode:= 5;
            Dmg:=Envir.nThunder;
            nCode:= 6;
            Envir.GetBaseObjects(x,y,True,m_TargetList);
          end;
        end;
        1:begin
          if Envir.nLava <> 0 then begin
            nCode:= 7;
            Target.SendRefMsg(RM_10205,0,x,y,11,'');
            nCode:= 8;
            Dmg:=Envir.nLava;
            nCode:= 9;
            Envir.GetRangeBaseObject(x,y,1,True,m_TargetList)
          end;
         end;
      end;//case Random(2) of
    end else begin
      If Envir.nThunder <> 0 then begin
        nCode:= 10;
        Target.SendRefMsg(RM_10205,0,x,y,10,'');
        nCode:= 11;
        Dmg:= Envir.nThunder;
        nCode:= 12;
        Envir.GetBaseObjects(x,y,True,m_TargetList);
      end;
      if Envir.nLava <> 0 then begin
        nCode:= 13;
        Target.SendRefMsg(RM_10205,0,x,y,11,'');
        nCode:= 14;
        Dmg:=Envir.nLava;
        nCode:= 15;
        Envir.GetRangeBaseObject(x,y,1,True,m_TargetList);
      end;
    end;

    FreshBaseObject:=TBaseObject.Create();
    if (m_TargetList.Count > 0) then begin
      for i:= m_TargetList.Count-1 downto 0 do begin
        nCode:= 17;
        BaseObject := TBaseObject(m_TargetList.Items[i]);
        if (BaseObject <> nil) then begin
          if {(Target.IsProperFriend(BaseObject) or (Target = BaseObject))}((BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_Master <> nil)) and (BaseObject.m_PEnvir = Envir) then begin
            nCode:= 18;
            magpwr:=(Dmg -(Dmg div 3))+ Random(Dmg div 3);//20080412 损害值
            nCode:= 19;
            BaseObject.SendDelayMsg(FreshBaseObject, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
          end;
          m_TargetList.Delete(i);
        end;
      end;
    end;
    nCode:= 20;
  //  xTargetList.Free;
    FreshBaseObject.Destroy;
    nCode:= 21;
  except
    MainOutMessage('{异常} TUserEngine.EffectTarget Code:'+inttostr(nCode));
  end;
end;

function TUserEngine.FindNearbyTarget(x,y:Integer;Envir:TEnvirnoment;xTargetList:TList): TBaseObject;
var
//  xTargetList:TList;
//  dist:Integer;
  BaseObject:TBaseObject;
  nRage:Integer;
  i:Integer;
begin
 // dist:= 999;
  nRage:=11;

  result:=nil;
  try
    xTargetList.Clear;
  //xTargetList := TList.Create;
    Envir.GetRangeBaseObject(x,y,nRage,TRUE,xTargetList);//不包括死的对像
    if xTargetList.count > 0 then begin//20080629
      for i:=0 to xTargetList.count - 1 do begin
        BaseObject:= TBaseObject(xTargetList.Items[i]);
        if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_Master <> nil) then begin //20080418 增加or (BaseObject.m_Master <> nil)
          //if abs(BaseObject.m_nCurrX - x) + abs(BaseObject.m_nCurrY - y) < dist then begin
            //dist := abs(BaseObject.m_nCurrX - x)+ abs(BaseObject.m_nCurrY - y);//20080726
            result:= BaseObject;
            //if (BaseObject.m_nCurrX = x) and (BaseObject.m_nCurrY = y) then exit;//20080726
            Break;//20080726
          //end;
        end;
      end;
    end;
  //xTargetList.Free;
  except
  end;
end;
//-----------------------------------------------------------------------------
procedure TUserEngine.ProcessEvents;
var
  I, II, III: Integer;
  MagicEvent: pTMagicEvent;
  BaseObject: TBaseObject;
begin
  for I := m_MagicEventList.Count - 1 downto 0 do begin
    if m_MagicEventList.Count <= 0 then Break;
    MagicEvent := m_MagicEventList.Items[I];
    if (MagicEvent <> nil) then begin
      if (MagicEvent.BaseObjectList <> nil) then begin
        for II := MagicEvent.BaseObjectList.Count - 1 downto 0 do begin
          if MagicEvent.BaseObjectList.Count <= 0 then Break;//20081008
          BaseObject := TBaseObject(MagicEvent.BaseObjectList.Items[II]);
          if BaseObject <> nil then begin
            if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (not BaseObject.m_boHolySeize) then begin
              MagicEvent.BaseObjectList.Delete(II);
            end;
          end;
        end;//for
        if (MagicEvent.BaseObjectList.Count <= 0) or
          ((GetTickCount - MagicEvent.dwStartTick) > MagicEvent.dwTime) or
          ((GetTickCount - MagicEvent.dwStartTick) > 180000) then begin
          MagicEvent.BaseObjectList.Free;
          III := 0;
          while (True) do begin
            if MagicEvent.Events[III] <> nil then begin
              TEvent(MagicEvent.Events[III]).Close();
            end;
            Inc(III);
            if III >= 8 then Break;
          end;
          Dispose(MagicEvent);
          m_MagicEventList.Delete(I);
        end;
      end;
    end;
  end;
end;

function TUserEngine.AddMagic(Magic: pTMagic): Boolean;
var
  UserMagic: pTMagic;
begin
  Result := False;
  New(UserMagic);
  UserMagic.wMagicId := Magic.wMagicId;
  UserMagic.sMagicName := Magic.sMagicName;
  UserMagic.btEffectType := Magic.btEffectType;
  UserMagic.btEffect := Magic.btEffect;
  //UserMagic.bt11 := Magic.bt11;
  UserMagic.wSpell := Magic.wSpell;
  UserMagic.wPower := Magic.wPower;
  UserMagic.TrainLevel := Magic.TrainLevel;
  //UserMagic.w02 := Magic.w02;
  UserMagic.MaxTrain := Magic.MaxTrain;
  UserMagic.btTrainLv := Magic.btTrainLv;
  UserMagic.btJob := Magic.btJob;
  //UserMagic.wMagicIdx := Magic.wMagicIdx;
  UserMagic.dwDelayTime := Magic.dwDelayTime;
  UserMagic.btDefSpell := Magic.btDefSpell;
  UserMagic.btDefPower := Magic.btDefPower;
  UserMagic.wMaxPower := Magic.wMaxPower;
  UserMagic.btDefMaxPower := Magic.btDefMaxPower;
  UserMagic.sDescr := Magic.sDescr;
  m_MagicList.Add(UserMagic);
  Result := True;
end;

function TUserEngine.DelMagic(wMagicId: Word): Boolean;
var
  I: Integer;
  Magic: pTMagic;
begin
  Result := False;
  for I := m_MagicList.Count - 1 downto 0 do begin
    if m_MagicList.Count <= 0 then Break;
    Magic := pTMagic(m_MagicList.Items[I]);
    if Magic <> nil then begin
      if Magic.wMagicId = wMagicId then begin
        Dispose(Magic);
        m_MagicList.Delete(I);
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TUserEngine.FindHeroMagic(sMagicName: string): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
  MagicList: TList;
begin
  Result := nil;
  if (m_boStartLoadMagic) and (OldMagicList.Count > 0) then begin
    MagicList := TList(OldMagicList.Items[OldMagicList.Count - 1]);
    if MagicList <> nil then begin
      if MagicList.Count > 0 then begin//20081008
        for I := 0 to MagicList.Count - 1 do begin
          Magic := MagicList.Items[I];
          if (Magic <> nil) and ((Magic.sDescr = '英雄') or (Magic.sDescr = '内功')) then begin
            if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
              Result := Magic;
              Break;
            end;
          end;
        end;//for
      end;
    end;
  end else begin
    if m_MagicList.Count > 0 then begin//20081008
      for I := 0 to m_MagicList.Count - 1 do begin
        Magic := m_MagicList.Items[I];
        if (Magic <> nil) and ((Magic.sDescr = '英雄') or (Magic.sDescr = '内功')) then begin
          if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
            Result := Magic;
            Break;
          end;
        end;
      end;//fof
    end;
  end;
end;

function TUserEngine.FindMagic(sMagicName: string): pTMagic;
var
  I: Integer;
  Magic: pTMagic;
  MagicList: TList;
begin
  Result := nil;
  if (m_boStartLoadMagic) and (OldMagicList.Count > 0) then begin
    MagicList := TList(OldMagicList.Items[OldMagicList.Count - 1]);
    if MagicList <> nil then begin
      if MagicList.Count > 0 then begin//20081008
        for I := 0 to MagicList.Count - 1 do begin
          Magic := MagicList.Items[I];
          if (Magic <> nil) and ((Magic.sDescr = '') or (Magic.sDescr = '内功')) then begin
            if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
              Result := Magic;
              Break;
            end;
          end;
        end;//for
      end;
    end;
  end else begin
    if m_MagicList.Count > 0 then begin//20081008
      for I := 0 to m_MagicList.Count - 1 do begin
        Magic := m_MagicList.Items[I];
        if (Magic <> nil) and ((Magic.sDescr = '') or (Magic.sDescr = '内功')) then begin
          if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
            Result := Magic;
            Break;
          end;
        end;
      end;//for
    end;
  end;
end;
//取地图范围内有怪
function TUserEngine.GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange: Integer; List: TList): Integer;
var
  I, II: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TBaseObject;
begin
  Result := 0;
  if Envir = nil then Exit;
  if m_MonGenList.Count > 0 then begin//20081008
    for I := 0 to m_MonGenList.Count - 1 do begin
      MonGen := m_MonGenList.Items[I];
      if (MonGen.Envir <> nil) and (MonGen.Envir <> Envir) then Continue;
      if MonGen.CertList.Count > 0 then begin//20081008
        for II := 0 to MonGen.CertList.Count - 1 do begin
          BaseObject := TBaseObject(MonGen.CertList.Items[II]);
          if BaseObject <> nil then begin
            if not BaseObject.m_boDeath and not BaseObject.m_boGhost and (BaseObject.m_PEnvir = Envir)
              and (abs(BaseObject.m_nCurrX - nX) <= nRange) and (abs(BaseObject.m_nCurrY - nY) <= nRange) then begin
              if List <> nil then List.Add(BaseObject);
              Inc(Result);
            end;
          end;
        end;//for
      end;
    end;
  end;
end;
//增加交易NPC
procedure TUserEngine.AddMerchant(Merchant: TMerchant);
begin
  UserEngine.m_MerchantList.Lock;
  try
    UserEngine.m_MerchantList.Add(Merchant);
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
end;
//取交易NPC列表
function TUserEngine.GetMerchantList(Envir: TEnvirnoment; nX, nY,
  nRange: Integer; TmpList: TList): Integer;
var
  I: Integer;
  Merchant: TMerchant;
begin
  m_MerchantList.Lock;
  try
    if m_MerchantList.Count > 0 then begin//20081008
      for I := 0 to m_MerchantList.Count - 1 do begin
        Merchant := TMerchant(m_MerchantList.Items[I]);
        if Merchant <> nil then begin
          if (Merchant.m_PEnvir = Envir) and
            (abs(Merchant.m_nCurrX - nX) <= nRange) and
            (abs(Merchant.m_nCurrY - nY) <= nRange) then begin
            TmpList.Add(Merchant);
          end;
        end;
      end; // for
    end;
  finally
    m_MerchantList.UnLock;
  end;
  Result := TmpList.Count;
end;
//取NPC列表
function TUserEngine.GetNpcList(Envir: TEnvirnoment; nX, nY,
  nRange: Integer; TmpList: TList): Integer;
var
  I: Integer;
  NPC: TNormNpc;
begin
  if QuestNPCList.Count > 0 then begin//20081008
    for I := 0 to QuestNPCList.Count - 1 do begin
      NPC := TNormNpc(QuestNPCList.Items[I]);
      if NPC <> nil then begin
        if (NPC.m_PEnvir = Envir) and
          (abs(NPC.m_nCurrX - nX) <= nRange) and
          (abs(NPC.m_nCurrY - nY) <= nRange) then begin
          TmpList.Add(NPC);
        end;
      end;
    end; // for
  end;
  Result := TmpList.Count;
end;
//重新加载NPC列表
procedure TUserEngine.ReloadMerchantList();
var
  I: Integer;
  Merchant: TMerchant;
begin
  m_MerchantList.Lock;
  try
    if m_MerchantList.Count > 0 then begin//20081008
      for I := 0 to m_MerchantList.Count - 1 do begin
        Merchant := TMerchant(m_MerchantList.Items[I]);
        if Merchant <> nil then begin
          if not Merchant.m_boGhost then begin
            Merchant.ClearScript;
            Merchant.LoadNpcScript;
          end;
        end;
      end; // for
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;
//重读NPC脚本
procedure TUserEngine.ReloadNpcList();
var
  I: Integer;
  NPC: TNormNpc;
begin
  if QuestNPCList.Count > 0 then begin//20081008
    for I := 0 to QuestNPCList.Count - 1 do begin
      NPC := TNormNpc(QuestNPCList.Items[I]);
      if NPC <> nil then begin
        NPC.ClearScript;
        NPC.LoadNpcScript;
      end;
    end;
  end;
end;
//取地图怪物数量 20080123
function TUserEngine.GetMapMonster(Envir: TEnvirnoment; List: TList): Integer;
var
  I, II: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TBaseObject;
begin
  Result := 0;
  if Envir = nil then Exit;
  if m_MonGenList.Count > 0 then begin//20081008
    for I := 0 to m_MonGenList.Count - 1 do begin
      MonGen := m_MonGenList.Items[I];
      if MonGen = nil then Continue;
      if MonGen.CertList.Count > 0 then begin//20081008
        for II := 0 to MonGen.CertList.Count - 1 do begin
          BaseObject := TBaseObject(MonGen.CertList.Items[II]);
          if BaseObject <> nil then begin
            if (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) and (BaseObject.m_PEnvir = Envir)  then begin
              if List <> nil then List.Add(BaseObject);
              Inc(Result);
            end;
          end;
        end;
      end;
    end;//for
  end;
end;

//20080123 检查地图指定坐标指定名称怪物数量
function TUserEngine.GetMapMonsterCount(Envir: TEnvirnoment; nX, nY, nRange:Integer; Name:string): Integer;
var
  I, II,nC: Integer;
  MonGen: pTMonGenInfo;
  BaseObject: TBaseObject;
begin
  Result := 0;
  nC := nRange;
  if Envir = nil then Exit;
  if m_MonGenList.Count > 0 then begin//20081008
    for I := 0 to m_MonGenList.Count - 1 do begin
      MonGen := m_MonGenList.Items[I];
      if MonGen = nil then Continue;
      if MonGen.CertList.Count > 0 then begin//20081008
        for II := 0 to MonGen.CertList.Count - 1 do begin
          BaseObject := TBaseObject(MonGen.CertList.Items[II]);
          if BaseObject <> nil then begin
            if not BaseObject.m_boDeath and not BaseObject.m_boGhost and (BaseObject.m_PEnvir = Envir)
             and (CompareText(BaseObject.m_sCharName, Name) = 0)  then begin
              //nC := abs(nX - BaseObject.m_nCurrX) + abs(nY - BaseObject.m_nCurrY);
              //if nC <= 5  then Inc(Result); //20080323 修改 <=5
              if (abs(nX - BaseObject.m_nCurrX) <= nC) and (abs(nY - BaseObject.m_nCurrY) <= nC) then begin//20081217 修改
                Inc(Result);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//取有人才刷怪地图,刷怪索引 20080830
function TUserEngine.GetMapMonGenIdx(Envir: TEnvirnoment;var Idx:integer): Integer;
var
  I: Integer;
  MonGen: pTMonGenInfo;
begin
  Result := 0;
  Try
    if Envir = nil then Exit;
    if Envir.MonCount = 0 then begin
      if m_MonGenList.Count > 0 then begin//20081008
        for I := 0 to m_MonGenList.Count - 1 do begin
          MonGen := m_MonGenList.Items[I];
          if MonGen = nil then Continue;
          if (MonGen.Envir = Envir) and (MonGen.nCurrMonGen <> 0) then begin
            if Result = 0 then begin
              Result:= 1;
              Idx := MonGen.nCurrMonGen;
            end;
            MonGen.dwStartTick:= 0;
          end;
        end;//for
      end;
    end;
  except
  end;
end;

procedure TUserEngine.HumanExpire(sAccount: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  if not g_Config.boKickExpireHuman then Exit;
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then begin
        if CompareText(PlayObject.m_sUserID, sAccount) = 0 then begin
          PlayObject.m_boExpire := True;
          Break;
        end;
      end;
    end;
  end;
end;
//取地图人数
function TUserEngine.GetMapHuman(sMapName: string): Integer;
var
  I: Integer;
  Envir: TEnvirnoment;
  PlayObject: TPlayObject;
begin
  Result := 0;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then Exit;
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then begin
        if not PlayObject.m_boDeath and not PlayObject.m_boGhost and
          (PlayObject.m_PEnvir = Envir) then
          Inc(Result);
      end;
    end;
  end;
end;
//取地图范围内的人物
function TUserEngine.GetMapRageHuman(Envir: TEnvirnoment; nRageX,
  nRageY, nRage: Integer; List: TList): Integer;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  Result := 0;
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then begin
        if not PlayObject.m_boDeath and
          not PlayObject.m_boGhost and
          (PlayObject.m_PEnvir = Envir) and
          (abs(PlayObject.m_nCurrX - nRageX) <= nRage) and
          (abs(PlayObject.m_nCurrY - nRageY) <= nRage) then begin
          List.Add(PlayObject);
          Inc(Result);
        end;
      end;
    end;
  end;
end;
{//判断怪物坐标范围内是否有玩家 20080520
function TUserEngine.IsMapRageHuman(sMapName: string; nRageX, nRageY, nRage: Integer): Boolean;
var
  I: Integer;
  PlayObject: TPlayObject;
  Envir: TEnvirnoment;
begin
  Result := False;
  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (m_PlayObjectList.Count = 0) then Exit;
  for I := 0 to m_PlayObjectList.Count - 1 do begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if PlayObject <> nil then begin
      if not PlayObject.m_boDeath and
        not PlayObject.m_boGhost and
        (PlayObject.m_PEnvir = Envir) and
        (abs(PlayObject.m_nCurrX - nRageX) <= nRage) and
        (abs(PlayObject.m_nCurrY - nRageY) <= nRage) then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;  }

function TUserEngine.GetStdItemIdx(sItemName: string): Integer;
var
  I: Integer;
  StdItem: pTStdItem;
begin
  Result := -1;
  if sItemName = '' then Exit;
  if StdItemList.Count > 0 then begin//20081008
    for I := 0 to StdItemList.Count - 1 do begin
      StdItem := StdItemList.Items[I];
      if StdItem <> nil then begin
        if CompareText(StdItem.Name, sItemName) = 0 then begin
          Result := I + 1;
          Break;
        end;
      end;
    end;
  end;
end;
//==========================================
//向每个人物发送消息
//线程安全
//==========================================
procedure TUserEngine.SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    if m_PlayObjectList.Count > 0 then begin//20081008
      for I := 0 to m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if PlayObject <> nil then begin
          if not PlayObject.m_boGhost then PlayObject.SysMsg(sMsg, c_Red, MsgType);
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TUserEngine.SendBroadCastMsg(sMsg: string; MsgType: TMsgType);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then begin
        if not PlayObject.m_boGhost then PlayObject.SysMsg(sMsg, c_Red, MsgType);
      end;
    end;
  end;
end;
//加强版文件信息发送函数(供NPC命令-SendMsg使用) 20081214
procedure TUserEngine.SendBroadCastMsg1(sMsg: string; MsgType: TMsgType; FColor, BColor: Byte);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  if m_PlayObjectList.Count > 0 then begin
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then begin
        if not PlayObject.m_boGhost then
          PlayObject.SysMsg1(sMsg, c_Red, MsgType, FColor, BColor);
      end;
    end;
  end;
end;

procedure TUserEngine.Execute;
begin
  Run;
end;

procedure TUserEngine.sub_4AE514(GoldChangeInfo: pTGoldChangeInfo);
var
  GoldChange: pTGoldChangeInfo;
begin
  if GoldChangeInfo <> nil then begin//20090202
    New(GoldChange);
    GoldChange^ := GoldChangeInfo^;
    EnterCriticalSection(m_LoadPlaySection);
    try
      m_ChangeHumanDBGoldList.Add(GoldChange);
    finally
      LeaveCriticalSection(m_LoadPlaySection);
    end;
  end;
end;

procedure TUserEngine.ClearMonSayMsg;
var
  I, II: Integer;
  MonGen: pTMonGenInfo;
  MonBaseObject: TBaseObject;
begin
  if m_MonGenList.Count > 0 then begin//20081008
    for I := 0 to m_MonGenList.Count - 1 do begin
      MonGen := m_MonGenList.Items[I];
      if (MonGen <> nil) and (MonGen.CertList <> nil) then begin
        if MonGen.CertList.Count > 0 then begin//20081008
          for II := 0 to MonGen.CertList.Count - 1 do begin
            MonBaseObject := TBaseObject(MonGen.CertList.Items[II]);
            if MonBaseObject <> nil then MonBaseObject.m_SayMsgList := nil;
          end;
        end;
      end;
    end;
  end;
end;
//M2所有主要过程,CPU 内存的占用大部分这过程
procedure TUserEngine.PrcocessData;
var
  dwUsrTimeTick: LongWord;
  sMsg: string;
  nCode: Byte;
begin
  if m_boPrcocessData then Exit;
  m_boPrcocessData:=True;
  //sleep(1);
  nCode:= 0;
  try
    try
      dwUsrTimeTick := GetTickCount();

      ProcessHumans();
      nCode:= 1;
      if (GetTickCount - dwGetOrderTick > 150000{1000 * 60 * 2}) and (not bo_ReadPlayLeveList) then begin //20080926 修改,每2.5分钟读取一次排行文件
        dwGetOrderTick := GetTickCount;
        nCode:= 2;
        //GetHumanOrder(); //获取人物等级排序 20080527
        GetPlayObjectLevelList();//获取人物等级排序 20080527
      end;
      nCode:= 3;
      if g_Config.boSendOnlineCount and (GetTickCount - g_dwSendOnlineTick > g_Config.dwSendOnlineTime) then begin
        g_dwSendOnlineTick := GetTickCount();
        nCode:= 4;
        sMsg := AnsiReplaceText(g_sSendOnlineCountMsg, '%c', IntToStr(Round(GetOnlineHumCount * (g_Config.nSendOnlineCountRate / 10))));
        SendBroadCastMsg(sMsg, t_System)
      end;
      nCode:= 5;
      ProcessMonsters();
      nCode:= 6;
      ProcessMerchants();
      nCode:= 7;
      ProcessNpcs();

      if (GetTickCount() - dwProcessMissionsTime) > 1000 then begin
        dwProcessMissionsTime := GetTickCount();
        nCode:= 8;
        ProcessEvents();
        nCode:= 9;
        ProcessEffects(); //20080327 闪电(雷炎洞魔法效果)
      end; 
      nCode:= 10;
      if (GetTickCount() - dwProcessMapDoorTick) > 500 then begin
        dwProcessMapDoorTick := GetTickCount();
        nCode:= 11;
        ProcessMapDoor();
      end;
      nCode:= 12;
      g_nUsrTimeMin := GetTickCount() - dwUsrTimeTick;
      if g_nUsrTimeMax < g_nUsrTimeMin then g_nUsrTimeMax := g_nUsrTimeMin;  
    except
      MainOutMessage('{异常} TUserEngine::ProcessData Code:'+inttostr(nCode));
    end;
  finally
    m_boPrcocessData:= False;
  end;
end;

function TUserEngine.MapRageHuman(sMapName: string; nMapX, nMapY,
  nRage: Integer): Boolean;
var
  nX, nY: Integer;
  Envir: TEnvirnoment;
begin
  Result := False;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir <> nil then begin
    for nX := nMapX - nRage to nMapX + nRage do begin
      for nY := nMapY - nRage to nMapY + nRage do begin
        if Envir.GetXYHuman(nMapX, nMapY) then begin
          Result := True;
          Exit;
        end;
      end;
    end;
  end;
end;    

procedure TUserEngine.SendQuestMsg(sQuestName: string);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  if m_PlayObjectList.Count > 0 then begin//20081008
    for I := 0 to m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then begin
        if not PlayObject.m_boDeath and not PlayObject.m_boGhost then
          g_ManageNPC.GotoLable(PlayObject, sQuestName, False);
      end;
    end;
  end;
end;

procedure TUserEngine.ClearItemList();
var
  I: Integer;
begin
  I := 0;
  while (True) do begin
    StdItemList.Exchange(Random(StdItemList.Count), StdItemList.Count - 1);
    Inc(I);
    if I >= StdItemList.Count then Break;
  end;
  ClearMerchantData();//清空交易NPC临时数据
end;

procedure TUserEngine.SwitchMagicList();
//var
//  I: Integer;
//  MagicList: TList;
begin
  if m_MagicList.Count > 0 then begin
    OldMagicList.Add(m_MagicList);
    m_MagicList := TList.Create;
  end;
  m_boStartLoadMagic := True;
end;
//清空交易NPC数据
procedure TUserEngine.ClearMerchantData();
var
  I: Integer;
  Merchant: TMerchant;
begin
  m_MerchantList.Lock;
  try
    if m_MerchantList.Count > 0 then begin//20081008
      for I := 0 to m_MerchantList.Count - 1 do begin
        Merchant := TMerchant(m_MerchantList.Items[I]);
        if Merchant <> nil then Merchant.ClearData();
      end;
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

//取商铺物品
function TUserEngine.GetShopStdItem(sItemName: string): pTStdItem;
var
  I: Integer;
  ShopInfo: pTShopInfo;
begin
  Result := nil;
  Try
    if sItemName = '' then Exit;
    if g_ShopItemList.Count > 0 then begin//20080629
      for I := 0 to g_ShopItemList.Count - 1 do begin
        ShopInfo := g_ShopItemList.Items[I];
        if CompareText(ShopInfo.StdItem.Name, sItemName) = 0 then begin
          Result := @ShopInfo.StdItem;
          break;
        end;
      end;
    end;
  except
    MainOutMessage('{异常} TUserEngine.GetShopStdItem');
  end;
end;
end.



unit UsrEngn;

interface
uses
  Windows, Classes, SysUtils, StrUtils, Controls, Forms, ObjBase, ObjNpc, Envir,
  Grobal2, SDK,ObjHero;
  
type
  TMonGenInfo = record//ˢ����
    sMapName: string[14];//��ͼ��
    nRace: Integer;
    nRange: Integer;//��Χ
    nMissionGenRate: Integer;//��������ˢ�»��� 1 -100
    dwStartTick: LongWord;//ˢ�ּ��
    nX: Integer;//X����
    nY: Integer;//Y����
    sMonName: string[14];//������
    nAreaX: Integer;
    nAreaY: Integer;
    nCount: Integer;//��������
    dwZenTime: LongWord;//ˢ��ʱ��
    dwStartTime: LongWord;//����ʱ��
    boIsNGMon: Boolean;//�ڹ���,����������������ֵ 20081001
    nNameColor: Byte; //�Զ������ֵ���ɫ 20080810
    nChangeColorType: Integer; //2007-02- 01 ����  0�Զ���ɫ >0�ı���ɫ -1���ı�
    CertList: TList;
    Envir: TEnvirnoment;
    nCurrMonGen: Integer;//ˢ������ 20080830
  end;
  pTMonGenInfo = ^TMonGenInfo;

  TMapMonGenCount = record
    sMapName: string[14];//��ͼ����
    nMonGenCount: Integer;//ˢ������
    dwNotHumTimeTick: LongWord;//û��ҵļ��
    nClearCount: Integer;//�������
    boNotHum: Boolean;//�Ƿ������
    dwMakeMonGenTimeTick: LongWord;//ˢ�ֵļ��
    nMonGenRate: Integer; //ˢ�ֱ���  10
    dwRegenMonstersTime: LongWord; //ˢ���ٶ�    200
  end;
  pTMapMonGenCount = ^TMapMonGenCount;

  TUserEngine = class
    m_LoadPlaySection: TRTLCriticalSection;
    m_LoadPlayList: TStringList; //��DB��ȡ��������
    m_PlayObjectList: TStringList; //���߽�ɫ�б�
    m_PlayObjectFreeList: TList; //0x10
    m_MonObjectList: TList;//�������е��ػ��� 20090111
    m_ChangeHumanDBGoldList: TList; //0x14
    dwShowOnlineTick: LongWord; //��ʾ�����������
    dwSendOnlineHumTime: LongWord; //���������������
    dwProcessMapDoorTick: LongWord; //0x20
    dwProcessMissionsTime: LongWord; //0x24
    dwRegenMonstersTick: LongWord; //0x28
    m_dwProcessLoadPlayTick: LongWord; //0x30
    m_nCurrMonGen: Integer; //ˢ������
    m_nMonGenListPosition: Integer; //0x3C
    m_nMonGenCertListPosition: Integer; //0x40
    m_nProcHumIDx: Integer; //0x44 �������￪ʼ������ÿ�δ������������ƣ�
    //nProcessHumanLoopTime: Integer; //20080815 ע��
    nMerchantPosition: Integer; //0x4C
    nNpcPosition: Integer; //0x50
    StdItemList: TList; //��Ʒ�б�(�����ݿ��е�����)
    MonsterList: TList; //�����б�
    m_MonGenList: TList; //�����б�(MonGen.txt�ļ��������)
    m_MagicList: TList; //ħ���б�
    m_MapMonGenCountList: TList;
    m_AdminList: TGList; //����Ա�б�
    m_MerchantList: TGList; //List_68 NPC�б�(Merchant.txt)
    QuestNPCList: TList; //0x6C
    m_ChangeServerList: TList;
    m_MagicEventList: TList;

    nMonsterCount: Integer; //��������
    nMonsterProcessPostion: Integer; //0x80�����������λ�ã����ڼ����������
    nMonsterProcessCount: Integer; //0x88���������������ͳ�ƴ���������
    boItemEvent: Boolean; //ItemEvent
    //dwProcessMonstersTick: LongWord;//20080815 ע��
    dwProcessMerchantTimeMin: Integer;
    dwProcessMerchantTimeMax: Integer;
    dwProcessNpcTimeMin: LongWord;
    dwProcessNpcTimeMax: LongWord;
    m_NewHumanList: TList;
    m_ListOfGateIdx: TList;
    m_ListOfSocket: TList;
    OldMagicList: TList;
    EffectList: TList;//��ͼЧ���б�
    m_TargetList: TList;//���׵�ͼ(��ħ���Ķ���) 20080726
    m_nLimitUserCount: Integer; //�����û���
    m_nLimitNumber: Integer; //����ʹ�����������
    m_boStartLoadMagic: Boolean;//��ʼ��ȡħ��
    m_dwSearchTick: LongWord;//
    m_dwGetTodyDayDateTick: LongWord;
    m_TodayDate: TDate;//��������

    m_PlayObjectLevelList: TSStringList; //����ȼ�����
    m_WarrorObjectLevelList: TSStringList; //սʿ�ȼ�����
    m_WizardObjectLevelList: TSStringList; //��ʦ�ȼ�����
    m_TaoistObjectLevelList: TSStringList; //��ʿ�ȼ�����
    m_PlayObjectMasterList: TSStringList; //ͽ��������

    m_HeroObjectLevelList: TSStringList; //Ӣ�۵ȼ�����
    m_WarrorHeroObjectLevelList: TSStringList; //Ӣ��սʿ�ȼ�����
    m_WizardHeroObjectLevelList: TSStringList; //Ӣ�۷�ʦ�ȼ�����
    m_TaoistHeroObjectLevelList: TSStringList; //Ӣ�۵�ʿ�ȼ�����
    dwGetOrderTick: LongWord;//ȡ����ȼ����еļ��

    m_nCurrX_136: Integer; //��ʼ����X 20080124
    m_nCurrY_136: Integer; //��ʼ����Y 20080124
    m_NewCurrX_136: Integer;//��ֹ����X 20080124
    m_NewCurrY_136: Integer;//��ֹ����Y 20080124
    //m_sMapName_136: string[MAPNAMELEN]; //��ͼ���� 20080124  20090204
    bo_ReadPlayLeveList: Boolean;//�Ƿ����ڶ�ȡ�����ļ� 20080829
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
    function RegenMonsters(MonGen: pTMonGenInfo; nCount: Integer): Boolean;//�����������
    //procedure WriteShiftUserData;//δʹ�� 20080522
    function GetGenMonCount(MonGen: pTMonGenInfo): Integer;
    function AddBaseObject(sMapName: string; nX, nY: Integer; nMonRace: Integer; sMonName: string): TBaseObject;
    function AddPlayObject(PlayObject: TPlayObject; nX, nY: Integer; sMonName: string): TBaseObject; //��������
    //procedure GenShiftUserData();//20080522 ע��
    procedure KickOnlineUser(sChrName: string);
    function SendSwitchData(PlayObject: TPlayObject; nServerIndex: Integer): Boolean;
    procedure SendChangeServer(PlayObject: TPlayObject; nServerIndex: Integer);
    procedure AddToHumanFreeList(PlayObject: TPlayObject);
    procedure GetHumData(PlayObject: TPlayObject; var HumanRcd: THumDataInfo);//ȡ��ɫ������
    procedure GetHeroData(BaseObject: TBaseObject; var HumanRcd: THumDataInfo); //ȡӢ�۵�����

    function GetHomeInfo(var nX: Integer; var nY: Integer): string;
    function GetRandHomeX(PlayObject: TPlayObject): Integer;
    function GetRandHomeY(PlayObject: TPlayObject): Integer;
    //function GetSwitchData(sChrName: string; nCode: Integer): pTSwitchDataInfo;//20080522 ע��
    procedure LoadSwitchData(SwitchData: pTSwitchDataInfo; var PlayObject: TPlayObject);
    procedure DelSwitchData(SwitchData: pTSwitchDataInfo);
    procedure MonInitialize(BaseObject: TBaseObject; sMonName: string);
    function MapRageHuman(sMapName: string; nMapX, nMapY, nRage: Integer): Boolean;
    function GetOnlineHumCount(): Integer;
    function GetUserCount(): Integer;
    function GetLoadPlayCount(): Integer;
    function GetAutoAddExpPlayCount: Integer;
    //procedure GetHumanOrder(); 20080527 ע��
    procedure GetPlayObjectLevelList();//20080220 ��ȡ���а��ļ�
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
    function AddHeroObject(PlayObject: TPlayObject; nX, nY: Integer; HumanRcd: THumDataInfo): TBaseObject; //����Ӣ��
    procedure SaveHeroRcd(PlayObject: TPlayObject);
    procedure SaveHumanRcd(PlayObject: TPlayObject);

    procedure AddObjectToMonList(BaseObject: TBaseObject);
    function GetStdItem(nItemIdx: Integer): pTStdItem; overload;
    function GetStdItem(sItemName: string): pTStdItem; overload;
    function GetMakeWineStdItem(Anicount: Integer): pTStdItem;//(���)ͨ������Anicount�õ���Ӧ�Ƶĺ���  20080620
    function GetMakeWineStdItem1(Shape: Integer): pTStdItem;//(���)ͨ����Shape�õ���Ӧ�����ĺ���  20080621
    function GetStdItemWeight(nItemIdx: Integer): Integer;
    function GetStdItemName(nItemIdx: Integer): string;
    function GetStdItemIdx(sItemName: string): Integer;
    function FindOtherServerUser(sName: string; var nServerIndex): Boolean;
    procedure CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY, nWide: Integer; btFColor, btBColor: Byte; sMsg: string);
    procedure ProcessUserMessage(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; Buff: PChar);
    procedure SendServerGroupMsg(nCode, nServerIdx: Integer; sMsg: string);
    function GetMonRace(sMonName: string): Integer;
    //function GetMonRaceImg(sMonName: string): Integer;//20080313 ȡ�ֵ�ͼ
    function InsMonstersList(MonGen: pTMonGenInfo; Monster: TAnimalObject): Boolean;
    function GetHeroObject(HeroObject: TBaseObject): TPlayObject;overload;
    function GetHeroObject(sName: string): TBaseObject;overload; //20071227 �������ֲ���Ӣ����

    function GetMasterObject(sName: string): TPlayObject;//ȡʦ���� 20080512

    function GetPlayObject(sName: string): TPlayObject; overload;
    function GetPlayObject(PlayObject: TBaseObject): TPlayObject; overload;
    function GetPlayObjectEx(sAccount, sName: string): TPlayObject;
    function GetPlayObjectExOfAutoGetExp(sAccount: string): TPlayObject;
    procedure KickPlayObjectEx(sAccount, sName: string);
    function FindMerchant(Merchant: TObject): TMerchant;
    function FindNPC(GuildOfficial: TObject): TGuildOfficial;
    //function InMerchantList(Merchant: TMerchant): Boolean;//�Ƿ��ǽ���NPC,δʹ�� 20080406
    //function InQuestNPCList(NPC: TNormNpc): Boolean;//δʹ�õĺ���  20080422
    function CopyToUserItemFromName(sItemName: string; Item: pTUserItem): Boolean;
    function GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY, nRange: Integer): Integer;
    function GetHumPermission(sUserName: string; var sIPaddr: string; var btPermission: Byte): Boolean;
    procedure AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
    procedure RandomUpgradeItem(Item: pTUserItem);//���������Ʒ
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
   // function IsMapRageHuman(sMapName: string; nRageX, nRageY, nRage: Integer): Boolean;//�жϹ������귶Χ���Ƿ������ 20080520
    function GetMapMonsterCount(Envir: TEnvirnoment; nX, nY, nRange:Integer; Name:string): Integer;//20081217 ����ͼָ������ָ�����ƹ�������
    function GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange: Integer; List: TList): Integer;
    function GetMapHuman(sMapName: string): Integer;
    function GetMapRageHuman(Envir: TEnvirnoment; nRageX, nRageY, nRage: Integer; List: TList): Integer;
    procedure SendBroadCastMsg(sMsg: string; MsgType: TMsgType);
    procedure SendBroadCastMsg1(sMsg: string; MsgType: TMsgType; FColor, BColor: Byte);//��ǿ���ļ���Ϣ���ͺ���(��NPC����-SendMsgʹ��) 20081214
    procedure SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType);
    procedure sub_4AE514(GoldChangeInfo: pTGoldChangeInfo);
    procedure ClearMonSayMsg();
    procedure SendQuestMsg(sQuestName: string);
    procedure ClearMerchantData();
    function GetMapMonGenCount(sMapName: string): pTMapMonGenCount;
    function AddMapMonGenCount(sMapName: string; nMonGenCount: Integer): Integer;
    function ClearMonsters(sMapName: string): Boolean;

    property MonsterCount: Integer read nMonsterCount;//��������
    property OnlinePlayObject: Integer read GetOnlineHumCount;//��������
    property PlayObjectCount: Integer read GetUserCount;//������
    property AutoAddExpPlayCount: Integer read GetAutoAddExpPlayCount;//�Զ��һ�����
    property LoadPlayCount: Integer read GetLoadPlayCount;
    function GetShopStdItem(sItemName: string): pTStdItem;//20080801 ȡ������Ʒ

    function GetMapMonGenIdx(Envir: TEnvirnoment;var Idx:integer): Integer;//ȡ���˲�ˢ�ֵ�ͼ,ˢ������ 20080830
  end;
var
  g_dwEngineTick: LongWord;
  g_dwEngineRunTime: LongWord;
  m_boHumProcess: Boolean = False;//20080717 �������Ƿ�����
  m_boProcessEffects: Boolean = False;////20080726 �������Ч�������Ƿ�����
  m_boPrcocessData: Boolean = False;
implementation

//{$R+}//20081204 �������Խ��

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
  m_MonObjectList := TList.Create;//�������е��ػ��� 20090111
  m_ChangeHumanDBGoldList := TList.Create;
  dwShowOnlineTick := GetTickCount;
  dwSendOnlineHumTime := GetTickCount;
  dwProcessMapDoorTick := GetTickCount;
  dwProcessMissionsTime := GetTickCount;
  //dwProcessMonstersTick := GetTickCount;//20080815 ע��
  dwRegenMonstersTick := GetTickCount;
  m_dwProcessLoadPlayTick := GetTickCount;
  m_nCurrMonGen := 0;
  m_nMonGenListPosition := 0;
  m_nMonGenCertListPosition := 0;
  m_nProcHumIDx := 0;
  //nProcessHumanLoopTime := 0; //20080815 ע��
  nMerchantPosition := 0;
  nNpcPosition := 0;

{$IF UserMode1 = 1}
  m_nLimitNumber := {1000000}0;//20080630(ע��)
  m_nLimitUserCount := {1000000}0;//20080630(ע��)
{$ELSE}
  m_nLimitNumber := 1000000;//20080630(ע��)
  m_nLimitUserCount := 1000000;//20080630(ע��)
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
  m_TargetList:= TList.Create;//���׵�ͼ(��ħ���Ķ���) 20080726
  m_boStartLoadMagic := False;
  m_dwSearchTick := GetTickCount;
  m_dwGetTodyDayDateTick := GetTickCount;
  m_TodayDate := 0;

  m_PlayObjectLevelList := TSStringList.Create; //�������� �ȼ�
  m_WarrorObjectLevelList := TSStringList.Create; //սʿ�ȼ�����
  m_WizardObjectLevelList := TSStringList.Create; //��ʦ�ȼ�����
  m_TaoistObjectLevelList := TSStringList.Create; //��ʿ�ȼ�����
  m_PlayObjectMasterList := TSStringList.Create; //ͽ��������

  m_HeroObjectLevelList := TSStringList.Create; //Ӣ�۵ȼ�����
  m_WarrorHeroObjectLevelList := TSStringList.Create; //Ӣ��սʿ�ȼ�����
  m_WizardHeroObjectLevelList := TSStringList.Create; //Ӣ�۷�ʦ�ȼ�����
  m_TaoistHeroObjectLevelList := TSStringList.Create; //Ӣ�۵�ʿ�ȼ�����
  //dwGetOrderTick := GetTickCount; //20080220 ע��
  bo_ReadPlayLeveList:= False;//�Ƿ����ڶ�ȡ�����ļ� 20080829
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

  if m_MonObjectList.Count > 0 then begin//�������е��ػ��� 20090111
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
  Effectlist.Free; //�׵� �ҽ���ͼ //20080408
  m_TargetList.Free;//���׵�ͼ(��ħ���Ķ���) 20080726

  if m_PlayObjectLevelList.Count > 0 then begin//20080629
    for I := 0 to m_PlayObjectLevelList.Count - 1 do begin
      if pTCharName(m_PlayObjectLevelList.Objects[I]) <> nil then
         Dispose(pTCharName(m_PlayObjectLevelList.Objects[I]));
    end;
  end;
  m_PlayObjectLevelList.Free; //�������� �ȼ�

  if m_WarrorObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_WarrorObjectLevelList.Count - 1 do begin
      if pTCharName(m_WarrorObjectLevelList.Objects[I]) <> nil then
         Dispose(pTCharName(m_WarrorObjectLevelList.Objects[I]));
    end;
  end;
  m_WarrorObjectLevelList.Free; //սʿ�ȼ�����

  if m_WizardObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_WizardObjectLevelList.Count - 1 do begin
      if pTCharName(m_WizardObjectLevelList.Objects[I]) <> nil then
         Dispose(pTCharName(m_WizardObjectLevelList.Objects[I]));
    end;
  end;
  m_WizardObjectLevelList.Free; //��ʦ�ȼ�����

  if m_TaoistObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_TaoistObjectLevelList.Count - 1 do begin
      if pTCharName(m_TaoistObjectLevelList.Objects[I]) <> nil then
         Dispose(pTCharName(m_TaoistObjectLevelList.Objects[I]));
    end;
  end;
  m_TaoistObjectLevelList.Free; //��ʿ�ȼ�����
  
  if m_PlayObjectMasterList.Count > 0 then begin//20080629
    for I := 0 to m_PlayObjectMasterList.Count - 1 do begin
      if pTCharName(m_PlayObjectMasterList.Objects[I]) <> nil then
         Dispose(pTCharName(m_PlayObjectMasterList.Objects[I]));
    end;
  end;
  m_PlayObjectMasterList.Free; //ͽ��������

  if m_HeroObjectLevelList.Count > 0 then begin//20080629
    for I := 0 to m_HeroObjectLevelList.Count - 1 do begin
      if pTHeroName(m_HeroObjectLevelList.Objects[I]) <> nil then
         Dispose(pTHeroName(m_HeroObjectLevelList.Objects[I]));
    end;
  end;
  m_HeroObjectLevelList.Free; //Ӣ�۵ȼ�����

  if m_WarrorHeroObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_WarrorHeroObjectLevelList.Count - 1 do begin
      if pTHeroName(m_WarrorHeroObjectLevelList.Objects[I]) <> nil then
         Dispose(pTHeroName(m_WarrorHeroObjectLevelList.Objects[I]));
    end;
  end;
  m_WarrorHeroObjectLevelList.Free; //Ӣ��սʿ�ȼ�����

  if m_WizardHeroObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_WizardHeroObjectLevelList.Count - 1 do begin
      if pTHeroName(m_WizardHeroObjectLevelList.Objects[I]) <> nil then
         Dispose(pTHeroName(m_WizardHeroObjectLevelList.Objects[I]));
    end;
  end;
  m_WizardHeroObjectLevelList.Free; //Ӣ�۷�ʦ�ȼ�����

  if m_TaoistHeroObjectLevelList.Count > 0 then begin//20080814
    for I := 0 to m_TaoistHeroObjectLevelList.Count - 1 do begin
      if pTHeroName(m_TaoistHeroObjectLevelList.Objects[I]) <> nil then
         Dispose(pTHeroName(m_TaoistHeroObjectLevelList.Objects[I]));
    end;
  end;
  m_TaoistHeroObjectLevelList.Free; //Ӣ�۵�ʿ�ȼ�����
  
  DeleteCriticalSection(m_LoadPlaySection);
  inherited;
end;
//------------------------------------------------------------------------------
//20080220 ��ȡ���а��ļ�
procedure TUserEngine.GetPlayObjectLevelList();
  function IsFileInUse(fName : string) : boolean;//�ж��ļ��Ƿ���ʹ��
  //var
  //   HFileRes : HFILE;
  begin
     Result := false; //����ֵΪ��(���ļ�����ʹ��)
     //20080914 ע��,��ʹ�ú���
    (* if not FileExists(fName) then exit; //����ļ����������˳�
     HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0 , nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
     Result := (HFileRes = INVALID_HANDLE_VALUE); //���CreateFile����ʧ�� ��ôResultΪ��(���ļ����ڱ�ʹ��)
     {if not Result then }CloseHandle(HFileRes);//��ô�رվ�� *)
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
        if FileExists(sHumDBFile) and (not IsFileInUse(sHumDBFile)) then begin//����ȼ�������
          LoadList.LoadFromFile(sHumDBFile);
          nCode:= 3;
          if m_PlayObjectLevelList.Count > 0 then begin//20080629
            nCode:= 4;
            for I := m_PlayObjectLevelList.Count - 1 downto 0 do begin //20080527 �ɶ��ļ�,�����ԭ������������
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
            for I := m_WarrorObjectLevelList.Count - 1 downto 0 do begin //20080814 �ɶ��ļ�,�����ԭ������������
              if pTCharName(m_WarrorObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTCharName(m_WarrorObjectLevelList.Objects[I]));
            end;
            m_WarrorObjectLevelList.Clear; //սʿ�ȼ�����
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
            for I := m_WizardObjectLevelList.Count - 1 downto 0  do begin //20080814 �ɶ��ļ�,�����ԭ������������
              if pTCharName(m_WizardObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTCharName(m_WizardObjectLevelList.Objects[I]));
            end;
            m_WizardObjectLevelList.Clear; //��ʦ�ȼ�����
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
            for I := m_TaoistObjectLevelList.Count - 1 downto 0 do begin //20080814 �ɶ��ļ�,�����ԭ������������
              if pTCharName(m_TaoistObjectLevelList.Objects[I]) <> nil then
                 Dispose(pTCharName(m_TaoistObjectLevelList.Objects[I]));
            end;
            m_TaoistObjectLevelList.Clear; //��ʿ�ȼ�����
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
            m_PlayObjectMasterList.Clear; //ͽ��������
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
            m_HeroObjectLevelList.Clear; //Ӣ�۵ȼ�����
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
            m_WarrorHeroObjectLevelList.Clear; //Ӣ��սʿ�ȼ�����
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
            m_WizardHeroObjectLevelList.Clear; //Ӣ�۷�ʦ�ȼ�����
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
            m_TaoistHeroObjectLevelList.Clear; //Ӣ�۵�ʿ�ȼ�����
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
        MainOutMessage('{�쳣} TUserEngine::GetPlayObjectLevelList Code:'+inttostr(nCode));
      end;
    finally
      LoadList.Free;
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
  finally
    LeaveCriticalSection(HumanSortCriticalSection);//20080926
    bo_ReadPlayLeveList:= False;
    dwGetOrderTick := GetTickCount;//���¼�ʱ��ȡ��� 200808029
  end;
end;
//------------------------------------------------------------------------------
(*procedure TUserEngine.GetHumanOrder(); //��ȡ��������  20080527 ע��
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
    m_PlayObjectLevelList.Clear; //����ȼ�������

    m_WarrorObjectLevelList.Clear; //սʿ�ȼ�����
    m_WizardObjectLevelList.Clear; //��ʦ�ȼ�����
    m_TaoistObjectLevelList.Clear; //��ʿ�ȼ�����

    for I := 0 to m_PlayObjectMasterList.Count - 1 do begin
      Dispose(pTCharName(m_PlayObjectMasterList.Objects[I]));
    end;
    m_PlayObjectMasterList.Clear; //ͽ��������
{$IF HEROVERSION = 1}
    for I := 0 to m_HeroObjectLevelList.Count - 1 do begin
      Dispose(pTHeroName(m_HeroObjectLevelList.Objects[I]));
    end;
    m_HeroObjectLevelList.Clear; //Ӣ�۵ȼ�����
    m_WarrorHeroObjectLevelList.Clear; //Ӣ��սʿ�ȼ�����
    m_WizardHeroObjectLevelList.Clear; //Ӣ�۷�ʦ�ȼ�����
    m_TaoistHeroObjectLevelList.Clear; //Ӣ�۵�ʿ�ȼ�����
{$IFEND}
    try
      EnterCriticalSection(ProcessHumanCriticalSection);

      GetPlayObjectLevelList(); //20080220 ��ȡ���а��ļ�
{      for I := 0 to m_PlayObjectList.Count - 1 do begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
        if PlayObject.m_WAbil.Level >= g_Config.nLimitMinOrderLevel then begin //�������е���͵ȼ�
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
       { if (PlayObject.m_MyHero <> nil) and PlayObject.m_boHasHero then begin //Ӣ������
          //if PlayObject.m_WAbil.Level >= g_Config.nLimitMinOrderLevel then begin //�������е���͵ȼ�
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
{   m_PlayObjectLevelList.QuickSort(False); //����ȼ�����
    m_WarrorObjectLevelList.QuickSort(False); //սʿ�ȼ�����
    m_WizardObjectLevelList.QuickSort(False); //��ʦ�ȼ�����
    m_TaoistObjectLevelList.QuickSort(False); //��ʿ�ȼ�����
    m_PlayObjectMasterList.QuickSort(False); //ͽ��������  }
{$IF HEROVERSION = 1}
   { m_HeroObjectLevelList.QuickSort(False); //Ӣ�۵ȼ�����
    m_WarrorHeroObjectLevelList.QuickSort(False); //Ӣ��սʿ�ȼ�����
    m_WizardHeroObjectLevelList.QuickSort(False); //Ӣ�۷�ʦ�ȼ�����
    m_TaoistHeroObjectLevelList.QuickSort(False); //Ӣ�۵�ʿ�ȼ�����}
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
//ȡ���������
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
{//20080313 ȡ�ֵ�����ͼ��
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
//����NPC��ʼ��
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
            MainOutMessage('����NPC ��ʼ��ʧ��...' + Merchant.m_sCharName + ' ' + Merchant.m_sMapName + '(' + IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY) + ')');
            m_MerchantList.Delete(I);
            Merchant.Free;
          end else begin
            Merchant.LoadNpcScript();
            Merchant.LoadNPCData();
          end;
        end else begin
          MainOutMessage(Merchant.m_sCharName + '����NPC ��ʼ��ʧ��... (���ڵ�ͼ������)');
          m_MerchantList.Delete(I);
          Merchant.Free;
        end;
        FrmMain.Caption := sCaption + '[���ڳ�ʼ����NPC(' + IntToStr(m_MerchantList.Count) + '/' + IntToStr(m_MerchantList.Count - I) + ')]';
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
          MainOutMessage(NormNpc.m_sCharName + ' Npc ��ʼ��ʧ��... ');
          QuestNPCList.Delete(I);
          NormNpc.Free;
        end else begin
          NormNpc.LoadNpcScript();
        end;
      end else begin
        MainOutMessage(NormNpc.m_sCharName + ' Npc ��ʼ��ʧ��... (npc.PEnvir=nil) ');
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
//ȡ�������
function TUserEngine.GetUserCount: Integer;
begin
  Result := m_PlayObjectList.Count;
end;
//ȡ�Զ��һ���������
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
  function IsLogined(sAccount, sChrName: string): Boolean;//�Ƿ��ǵ�¼�����˺�
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

  function MakeNewHuman(UserOpenInfo: pTUserOpenInfo): TPlayObject; //�����µ�����
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
     { if not g_Config.boVentureServer then begin //δʹ�� 20080408
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
          if Envir.m_boFight3Zone then begin //�Ƿ����л�ս����ͼ����
            if (PlayObject.m_Abil.HP <= 0) and (PlayObject.m_nFightZoneDieCount < 3) then begin
              PlayObject.m_Abil.HP := PlayObject.m_Abil.MaxHP;
              PlayObject.m_Abil.MP := PlayObject.m_Abil.MaxMP;
              PlayObject.m_boDieInFight3Zone := True;
            end else PlayObject.m_nFightZoneDieCount := 0;
          end;
        end;

        PlayObject.m_MyGuild := g_GuildManager.MemberOfGuild(PlayObject.m_sCharName);//ȡ����������л�
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

        {if (PlayObject.nC4 <= 1) and (PlayObject.m_Abil.Level >= 1) then//20081007 ע�ͣ�nC4��ʵ���ô�
          PlayObject.nC4 := 2; }
        if g_MapManager.FindMap(PlayObject.m_sMapName) = nil then
          PlayObject.m_Abil.HP := 0;
        if PlayObject.m_Abil.HP <= 0 then begin
          PlayObject.ClearStatusTime();
          if PlayObject.PKLevel < 2 then begin//û�к���
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
          MainOutMessage('[����] PlayObject.PEnvir = nil');
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
          //Envir := g_MapManager.FindMap(g_Config.sHomeMap); //20080408 û��ʹ��
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
            MainOutMessage('[����] PlayObject.PEnvir = nil');
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
      //PlayObject.m_dwLoadTick := UserOpenInfo.LoadUser.dwNewUserTick; //δʹ�� 20080329
      PlayObject.m_nSoftVersionDateEx := GetExVersionNO(UserOpenInfo.LoadUser.nSoftVersionDate, PlayObject.m_nSoftVersionDate);
      Result := PlayObject;
    except
      MainOutMessage('{�쳣} TUserEngine::MakeNewHuman');
    end;
  end;
//type //20080815 ע��
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
  m_nUserLicense: Integer;//ʹ�������
  m_nCheckServerCode: Integer;//������������
  m_nErrorCode: Integer;
  m_nProVersion: Integer;
  sUserKey: string;
  sCheckCode: string;*)
begin
if m_boHumProcess then Exit;//20080717 �������Ƿ�����
m_boHumProcess:= True;//20080717 �������Ƿ�����
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
                PlayObject := MakeNewHuman(UserOpenInfo);//�����µ�����
                if PlayObject <> nil then begin
                  nCheck30 := 25;
                  PlayObject.m_boClientFlag := UserOpenInfo.LoadUser.boClinetFlag; //���ͻ��˱�־��������������
                  m_PlayObjectList.AddObject(m_LoadPlayList.Strings[I], PlayObject);
                  SendServerGroupMsg(SS_201, nServerIndex, PlayObject.m_sCharName);
                  nCheck30 := 26;
                  m_NewHumanList.Add(PlayObject);
                end;
              end else begin
                nCheck30 := 27;
                KickOnlineUser(m_LoadPlayList.Strings[I]);///�߳���������
                m_ListOfGateIdx.Add(Pointer(UserOpenInfo.LoadUser.nGateIdx));
                m_ListOfSocket.Add(Pointer(UserOpenInfo.LoadUser.nSocket));
              end;
            end else begin
  {$IF HEROVERSION = 1}
              nCheck30 := 28;
              if UserOpenInfo.LoadUser.PlayObject <> nil then begin //��ʼ�ٻ�Ӣ��
                PlayObject := GetPlayObject(TBaseObject(UserOpenInfo.LoadUser.PlayObject));
                nCheck30 := 29;
                if PlayObject <> nil then begin
                  case UserOpenInfo.LoadUser.btLoadDBType of
                    0: begin //�ٻ�
                        nCheck30 := 30;
                        if UserOpenInfo.nOpenStatus = 1 then begin
                          PlayObject.m_MyHero := PlayObject.MakeHero(PlayObject, UserOpenInfo.HumanRcd);
                          if PlayObject.m_MyHero <> nil then begin
                            nCheck30 := 31;
                            THeroObject(PlayObject.m_MyHero).Login;//Ӣ�۵�¼
                            PlayObject.m_MyHero.m_btAttatckMode:= PlayObject.m_btAttatckMode;//�����˵Ĺ���ģʽһ�£�����������������������Ŀ�� 20090113
                            PlayObject.m_MyHero.SendRefMsg(RM_CREATEHERO, PlayObject.m_MyHero.m_btDirection, PlayObject.m_MyHero.m_nCurrX, PlayObject.m_MyHero.m_nCurrY, 0, ''); //ˢ�¿ͻ��ˣ�����Ӣ����Ϣ
                            PlayObject.SendMsg(PlayObject, RM_RECALLHERO, 0, Integer(PlayObject.m_MyHero), 0, 0, '');
                            PlayObject.n_myHeroTpye:= THeroObject(PlayObject.m_MyHero).n_HeroTpye;//20080515 Ӣ�۵�����
                            case THeroObject(PlayObject.m_MyHero).m_btStatus of
                              1: begin
                                  //THeroObject(PlayObject.m_MyHero).SysMsg('(Ӣ��) �ҳ϶�Ϊ'+floattostr(THeroObject(PlayObject.m_MyHero).m_nLoyal / 100)+'%', c_Green, t_Hint);//20090114 ȡ���ҳǶ���ʾ
                                  THeroObject(PlayObject.m_MyHero).SysMsg( g_sHeroFollow, c_Green, t_Hint);//20080316
                                end;
                              0: begin
                                  //THeroObject(PlayObject.m_MyHero).SysMsg('(Ӣ��) �ҳ϶�Ϊ'+floattostr(THeroObject(PlayObject.m_MyHero).m_nLoyal / 100)+'%', c_Green, t_Hint);//20090114 ȡ���ҳǶ���ʾ
                                  THeroObject(PlayObject.m_MyHero).SysMsg( g_sHeroAttack, c_Green, t_Hint);//20080316
                                end;
                              2: begin
                                  //THeroObject(PlayObject.m_MyHero).SysMsg('(Ӣ��) �ҳ϶�Ϊ'+floattostr(THeroObject(PlayObject.m_MyHero).m_nLoyal / 100)+'%', c_Green, t_Hint);//20090114 ȡ���ҳǶ���ʾ
                                  THeroObject(PlayObject.m_MyHero).SysMsg( g_sHeroRest, c_Green, t_Hint);//20080316
                                end;
                            end;
                            THeroObject(PlayObject.m_MyHero).SysMsg(g_sHeroLoginMsg, c_Green, t_Hint);
                            if THeroObject(PlayObject.m_MyHero).m_boTrainingNG then begin//ѧ���ڹ�
                              THeroObject(PlayObject.m_MyHero).m_MaxExpSkill69:= THeroObject(PlayObject.m_MyHero).GetSkill69Exp(THeroObject(PlayObject.m_MyHero).m_NGLevel, THeroObject(PlayObject.m_MyHero).m_Skill69MaxNH);//��¼����ȡ�ڹ��ķ��������� 20081002
                              THeroObject(PlayObject.m_MyHero).SendMsg(PlayObject.m_MyHero, RM_HEROMAGIC69SKILLEXP, 0, 0, 0, THeroObject(PlayObject.m_MyHero).m_NGLevel, EncodeString(Inttostr(THeroObject(PlayObject.m_MyHero).m_ExpSkill69)+'/'+Inttostr(THeroObject(PlayObject.m_MyHero).m_MaxExpSkill69)));
                              THeroObject(PlayObject.m_MyHero).SendMsg(PlayObject.m_MyHero, RM_MAGIC69SKILLNH, 0, THeroObject(PlayObject.m_MyHero).m_Skill69NH, THeroObject(PlayObject.m_MyHero).m_Skill69MaxNH, 0, ''); //����ֵ�ñ��˿��� 20081002
                            end;
                          end;
                        end;
                      end;
                    1: begin //�½�
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
                    2: begin //ɾ��Ӣ��
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
                          PlayObject.n_myHeroTpye:= 3;//Ӣ�۵����� 20080515
                          if g_FunctionNPC <> nil then begin
                            g_FunctionNPC.GotoLable(PlayObject, '@DeleteHeroOK', False);
                          end;
                        end else begin
                          if g_FunctionNPC <> nil then begin
                            g_FunctionNPC.GotoLable(PlayObject, '@DeleteHeroFail', False);
                          end;
                        end;
                      end;
                    3: begin//��ѯӢ��������� 20080514
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
        MainOutMessage('{�쳣} TUserEngine::ProcessHumans -> Ready, Save, Load... Code:'+IntToStr(nCheck30));
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
            if PlayObject <> nil then begin//20080821 �޸�
              PlayObject.Free;
              PlayObject:= nil;
            end;
          except
            MainOutMessage('{�쳣} TUserEngine::ProcessHumans ClosePlayer.Delete - Free');
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
    MainOutMessage('{�쳣} TUserEngine::ProcessHumans ClosePlayer.Delete');
  end;
  {===================================���»�ȡ��Ȩ===============================}
  try
    if ((GetTickCount - m_dwSearchTick) > 3600000{1000 * 60 * 60}) or (m_TodayDate <> Date) then begin
      m_TodayDate := Date;
      HeroAddSkill(FrmMain.Caption);//20080603 //�ж�M2�����Ƿ��ƽ��޸�
      m_dwSearchTick := GetTickCount;//GetTickCount()���ڻ�ȡ��windows��������������ʱ�䳤�ȣ����룩
(*      m_nCheckServerCode := 1000;
      m_nUserLicense := 0;
      nM2Crc := 0;          //20080210 ʵ����Ѱ�
      Inc(nCrackedLevel, 5);
      if (g_nGetLicenseInfo >= 0) and Assigned(PlugProcArray[g_nGetLicenseInfo].nProcAddr) then begin
{$IF TESTMODE = 1}
        MainOutMessage('nCrackedLevel_1 ' + IntToStr(nCrackedLevel));
{$IFEND}
        Dec(nCrackedLevel);
        m_nCheckServerCode := 1001;
        nM2Crc := TGetLicense(PlugProcArray[g_nGetLicenseInfo].nProcAddr)(m_nProVersion, m_nUserLicense, m_nErrorCode);//��ȡ�����Ϣ,������������,��ʹ�ô���������
        //Inc(nErrorLevel, m_nErrorCode); 20071229 ȥ��
        m_nCheckServerCode := 1002;
        m_nLimitNumber := LoWord(m_nUserLicense); //�������ʹ�����������
        m_nLimitUserCount := LoWord(m_nErrorCode); //20071110 ����û���
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
        m_nLimitNumber := 1000000; //20080210 ʵ����Ѱ�
        m_nLimitUserCount := 1000000; //20080210 ʵ����Ѱ�
    end;
  except
    MainOutMessage('{�쳣} TUserEngine::GetLicense');
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
        if PlayObject.m_btRaceServer <> RC_PLAYOBJECT then Break;//20080901 �����������˳�
        if Integer(dwCurTick - PlayObject.m_dwRunTick) > PlayObject.m_nRunTime then begin
          PlayObject.m_dwRunTick := dwCurTick;
          if not PlayObject.m_boGhost then begin
            if not PlayObject.m_boLoginNoticeOK then begin
              try
                PlayObject.RunNotice();//������Ϸ�Ҹ�,����������Ϸʱ����ʾ��
              except
                MainOutMessage('{�쳣} TUserEngine::ProcessHumans RunNotice');
              end;
            end else begin
              try
                if not PlayObject.m_boReadyRun then begin//�Ƿ������Ϸ���
                  PlayObject.m_boReadyRun := True;
                  //PlayObject.m_boNotOnlineAddExp := False;//20080522
                  PlayObject.UserLogon;//�����¼��Ϸ
                  if PlayObject.m_boNotOnlineAddExp then begin//�����ڹһ�״̬ 20080523
                     PlayObject.m_boNotOnlineAddExp := False;
                     PlayObject.m_boPlayOffLine := False;//�����ߴ��� 20080716
                     if g_ManageNPC <> nil then  g_ManageNPC.GotoLable(PlayObject, '@RESUME', False); //�����ڹһ�״̬,������С��
                  end;
                end else begin
                  if (GetTickCount() - PlayObject.m_dwSearchTick) > PlayObject.m_dwSearchTime then begin
                    PlayObject.m_dwSearchTick := GetTickCount();
                    nCheck30 := 10;
                    PlayObject.SearchViewRange;//��������
                    nCheck30 := 11;
                    PlayObject.GameTimeChanged;//��Ϸʱ��ı�
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
                  SaveHeroRcd(PlayObject);//����Ӣ������
{$IFEND}
                end;
              except
                on E: Exception do begin
                  MainOutMessage('{�쳣} TUserEngine::ProcessHumans Human.Operate Code:'+inttostr(nCheck30)+' Name:'+PlayObject.m_sCharName);
                  PlayObject.KickException;//�߳��쳣 20090103
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
                MainOutMessage('{�쳣} TUserEngine::ProcessHumans Human.Finalize Code:'+ IntToStr(nCheck30));
              end;
            end;
            try
              nCheck30 := 4;
              PlayObject.DealCancelA();
              nCheck30 := 5;
              SaveHumanRcd(PlayObject);
{$IF HEROVERSION = 1}
              nCheck30 := 6;
              SaveHeroRcd(PlayObject);//����Ӣ������
{$IFEND}
              AddToHumanFreeList(PlayObject);//20090106 ��λ��
              nCheck30 := 7;
              if (not PlayObject.m_boReconnection) then begin//20090102 ���������ӲŹر�
                RunSocket.CloseUser(PlayObject.m_nGateIdx, PlayObject.m_nSocket);
              end;
            except
              MainOutMessage('{�쳣} TUserEngine::ProcessHumans RunSocket.CloseUser Code:'+ IntToStr(nCheck30));
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
    MainOutMessage('{�쳣} TUserEngine::ProcessHumans');
  end;
  //Inc(nProcessHumanLoopTime);//20080815 ע��
  //g_nProcessHumanLoopTime := nProcessHumanLoopTime;//20080815 ע��
  Inc(g_nProcessHumanLoopTime);//20080815
  if m_nProcHumIDx = 0 then begin
    //nProcessHumanLoopTime := 0;//20080815 ע��
    //g_nProcessHumanLoopTime := nProcessHumanLoopTime; //20080815 ע��
    g_nProcessHumanLoopTime := 0;//20080815
    dwUsrRotTime := GetTickCount - g_dwUsrRotCountTick;
    dwUsrRotCountMin := dwUsrRotTime;
    g_dwUsrRotCountTick := GetTickCount();
    if dwUsrRotCountMax < dwUsrRotTime then dwUsrRotCountMax := dwUsrRotTime;
  end;
  g_nHumCountMin := GetTickCount - dwCheckTime;
  if g_nHumCountMax < g_nHumCountMin then g_nHumCountMax := g_nHumCountMin;
 finally 
   m_boHumProcess:= False;//20080717 �������Ƿ�����
 end;
end;

{//�Ƿ��ǽ���NPC(δʹ��)
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
    MainOutMessage('{�쳣} TUserEngine::ProcessMerchants');
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
//�������
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
//�������
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
    //ˢ�¹��￪ʼ,�ж��Ƿ񳬹�ˢ�ֵļ��
    if ((GetTickCount - dwRegenMonstersTick) > g_Config.dwRegenMonstersTime) then begin
      tCode := 2;
      dwRegenMonstersTick := GetTickCount();
      if m_nCurrMonGen < m_MonGenList.Count then begin
        tCode := 25;
        MonGen := m_MonGenList.Items[m_nCurrMonGen];//ȡ�õ�ǰˢ�ֵ�����
        tCode := 26;
        if MonGen <> nil then begin//20081222
          tCode := 27;
          if MonGen.nCurrMonGen = 0 then MonGen.nCurrMonGen:= m_nCurrMonGen;//ˢ������ 20080830
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
            if g_Config.nMonGenRate <= 0 then g_Config.nMonGenRate := 10; //��ֹ��������
            nGenModCount := _MAX(1, Round(_MAX(1, MonGen.nCount) / (g_Config.nMonGenRate / 10)));
            nMakeMonsterCount := nGenModCount - nGenCount;
            if nMakeMonsterCount < 0 then nMakeMonsterCount := 0;
            tCode := 6;
            if MonGen.Envir <> nil then begin//20081005
              tCode := 7;
              if MonGen.Envir.m_boNoManNoMon then begin//û�˲�ˢ�� 20080712
                if (MonGen.Envir.HumCount > 0) then boCanCreate := True
                else boCanCreate := False;
              end else boCanCreate := True;
            end else boCanCreate := True;

            //nGenModCount ��Ҫˢ����
            //nGenCount �Ѿ�ˢ����}
            //nMakeMonsterCount ��ǰ��������������
            //===============================����ˢ��========================================
           (* if (MonGen.Envir <> nil) and boCanCreate then begin
              if (MonGen.nRace <> 110) and (MonGen.nRace <> 111) and (MonGen.nRace <> RC_GUARD) and
                 (MonGen.nRace <> RC_ARCHERGUARD) and(MonGen.nRace <> 55) then begin

                MapMonGenCount := GetMapMonGenCount(MonGen.sMapName);
                if MapMonGenCount <> nil then begin
                  nActiveHumCount := GetMapHuman(MonGen.sMapName);
                  nActiveMonsterCount := GetMapMonster(MonGen.Envir, nil);//��ͼ��������
                  if (nActiveHumCount > 0) and (not MapMonGenCount.boNotHum) then begin
                    MapMonGenCount.boNotHum := True;
                  end else
                    if (nActiveHumCount <= 0) and (MapMonGenCount.boNotHum) then begin
                    MapMonGenCount.boNotHum := False;
                    MapMonGenCount.dwNotHumTimeTick := GetTickCount;
                  end;
                  //�����ͼ����,30�������
                  if (GetTickCount - MapMonGenCount.dwNotHumTimeTick > 1800000{1000 * 60 * 30}) and not MapMonGenCount.boNotHum then begin
                    MapMonGenCount.dwNotHumTimeTick := GetTickCount;
                    if nActiveMonsterCount > 0 then begin
                      if ClearMonsters(MonGen.sMapName) then begin
                        //MainOutMessage('���������:'+MonGen.sMonName+'  ����:'+inttostr(nActiveMonsterCount)+'  ��ͼ��������:'+inttostr(nActiveHumCount));
                        Inc(MapMonGenCount.nClearCount);
                      end;
                    end;
                    nMakeMonsterCount := 0;
                  end;
                 { //ˢ��
                  if MapMonGenCount.boNotHum then begin

                  end;   }
                end;
              end;
            end;  *)
            tCode := 8;
            if (nMakeMonsterCount > 0) and (boCanCreate) then begin //0806 ���� ����ˢ����������
              if (nErrorLevel = 0) and (nCrackedLevel = 0) then begin
                boRegened := RegenMonsters(MonGen, nMakeMonsterCount);//����������� RegenMonsters()
              end else
              if dwStartTime < 36000{60 * 60 * 10} then begin //�ƽ����10Сʱ��������ˢ��
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
    //ˢ�¹������
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
                  Monster.SearchViewRange();//�ֶ�,ռCUP
                end;
                if not Monster.m_boIsVisibleActive and (Monster.m_nProcessRunCount < g_Config.nProcessMonsterInterval) then begin
                  Inc(Monster.m_nProcessRunCount);
                end else begin
                  if Monster <> nil then begin //20080526 ����
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
        MainOutMessage(Format('{�쳣} TUserEngine::ProcessMonsters %d %s', [tCode, Monster.m_sCharName]));
        Monster.KickException;//�߳��쳣 20090103
      end else begin
        MainOutMessage(Format('{�쳣} TUserEngine::ProcessMonsters %d %s', [tCode, '']));
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
{//δʹ�õĺ���  20080422
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
    MainOutMessage('{�쳣} TUserEngine.ProcessNpcs');
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
  procedure ShowOnlineCount();//ȡ��������
  var
    nOnlineCount: Integer;
    nOnlineCount2: Integer;
    nAutoAddExpPlayCount: Integer;
  begin
    nOnlineCount := GetUserCount;
    nAutoAddExpPlayCount := GetAutoAddExpPlayCount;//�һ�����
    nOnlineCount2 := nOnlineCount - nAutoAddExpPlayCount;//������������
    MainOutMessage(Format('������: %d (%d/%d)', [ nOnlineCount, nOnlineCount2, nAutoAddExpPlayCount]));
  end;
begin
  try
    if (GetTickCount() - dwShowOnlineTick) > g_Config.dwConsoleShowUserCountTime then begin
      dwShowOnlineTick := GetTickCount();
      //NoticeManager.LoadingNotice;//��ȡ����  20080815 ע�� �ƶ�����������ʱ����
      ShowOnlineCount();//ȡ�������� 
      //MainOutMessage('������: ' + IntToStr(GetUserCount));//20080815 �޸�
      g_CastleManager.Save;
    end;
    if (GetTickCount() - dwSendOnlineHumTime) > 15000{10000} then begin
      dwSendOnlineHumTime := GetTickCount();
      FrmIDSoc.SendOnlineHumCountMsg(GetOnlineHumCount);
    end;
    {if Assigned(zPlugOfEngine.UserEngineRun) then begin//20080813 ע��
      try
        zPlugOfEngine.UserEngineRun(Self);
      except
      end;
    end;}
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} TUserEngine::Run');
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
//(���)ͨ������Anicount�õ���Ӧ�Ƶĺ���  20080620
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

//ͨ����Shape�õ���Ӧ�����ĺ���  20080621
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
//ͨ������ȡ��Ʒ����
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
//ͨ������ȡ��Ʒ����
function TUserEngine.GetStdItemName(nItemIdx: Integer): string;
begin
  Result := '';
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then begin
    Result := pTStdItem(StdItemList.Items[nItemIdx]).Name;
  end else Result := '';
end;

//���������������ϵĽ�ɫ ��ʱ��Ч
function TUserEngine.FindOtherServerUser(sName: string;
  var nServerIndex): Boolean;
begin
  Result := False;
end;
//���ֺ���
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
        (PlayObject.m_boBanShout) and //����Ⱥ������
        (PlayObject.m_boBanGmMsg)and //20080211  �ܾ����պ�����Ϣ
        (abs(PlayObject.m_nCurrX - nX) < nWide) and
        (abs(PlayObject.m_nCurrY - nY) < nWide) then begin
        //PlayObject.SendMsg(nil,wIdent,0,0,$FFFF,0,sMsg);
        PlayObject.SendMsg(PlayObject, wIdent, 0, btFColor, btBColor, 0, sMsg);
      end;
    end;
  end;
end;

//��ȡ���ﱬ����Ʒ  20080523
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
            if Random(MonItem.MaxPoint) <= MonItem.SelPoint then begin//������� 1/10 ���10<=1 ��Ϊ���õ���Ʒ
              nCode:=5;
              if CompareText(MonItem.ItemName, sSTRING_GOLDNAME) = 0 then begin  //����ǽ��
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
                        if StdItem.AniCount = 21 then UserItem.Dura:=0;//��ħ�����ף����,��ѵ�ǰ�־�����Ϊ0
                      end;
                      8:begin//����Ʋ��� 20080702
                         case StdItem.Source of
                           0: UserItem.btValue[0]:= Random(3)+ 1;//��������ϵ�Ʒ��
                           1: UserItem.btValue[0]:= Random(3)+ 5;
                         end;
                      end;
                      51:begin
                        if (StdItem.Shape = 0) then UserItem.Dura:= 0;//����������յ�ǰ�־� 20081108
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
    MainOutMessage('{�쳣} TUserEngine.MonGetRandomItems Code:'+inttostr(nCode));
  end;
end;
//���������Ʒ(��Ʒ����)
procedure TUserEngine.RandomUpgradeItem(Item: pTUserItem);
var
  StdItem: pTStdItem;
begin
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    5, 6: ItemUnit.RandomUpgradeWeapon(Item);//����
    10, 11: ItemUnit.RandomUpgradeDress(Item);//�·�
    19: ItemUnit.RandomUpgrade19(Item);//����(������)
    20, 21, 24: ItemUnit.RandomUpgrade202124(Item);//����(׼ȷ�����͡�����ħ���ָ���)������(�ر���)
    26: ItemUnit.RandomUpgrade26(Item);//��������
    22: ItemUnit.RandomUpgrade22(Item);//��ָ
    23: ItemUnit.RandomUpgrade23(Item);//��ָ(�ر���)
    15,16: ItemUnit.RandomUpgradeHelMet(Item);//ͷ��,����
    52,54,62,64: ItemUnit.RandomUpgradeBoots(Item);//20080503 Ь�ӣ�����
  end;
end;

procedure TUserEngine.GetUnknowItemValue(Item: pTUserItem);
var
  StdItem: pTStdItem;
begin
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then Exit;
  case StdItem.StdMode of
    15, 16: ItemUnit.UnknowHelmet(Item); //����ͷ��,����
    22, 23: ItemUnit.UnknowRing(Item);//���ؽ�ָ
    24, 26: ItemUnit.UnknowNecklace(Item);//������������
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
              //FillChar(Item^.btValue, SizeOf(Item^.btValue), 0);//20080812 ����
              Item.wIndex := I + 1;
              Item.MakeIndex := GetItemNumber();
              Item.Dura := StdItem.DuraMax;
              Item.DuraMax := StdItem.DuraMax;
              case StdItem.StdMode of //��ħ�����ף����,��ѵ�ǰ�־�����Ϊ0  20080305
                15,16, 19..24, 26:begin
                   if (StdItem.Shape = 130) or (StdItem.Shape = 131) or (StdItem.Shape = 132) then
                    UserEngine.GetUnknowItemValue(Item);
                 end;
                2:begin
                   if StdItem.AniCount = 21 then Item.Dura:=0;//��ħ�����ף����,��ѵ�ǰ�־�����Ϊ0
                 end;
                51:begin//20080221 ������
                   if StdItem.Shape = 0  then Item.Dura:=0;//�Ǿ�����,��ѵ�ǰ�־�����Ϊ0
                 end;
                60: begin//����,���վ��� 20080806
                  if StdItem.shape <> 0 then begin
                    Item.btValue[1]:= Random(40) + 10;//�Ƶľƾ���
                    Item.btValue[0]:= Random(8);//�Ƶ�Ʒ��
                    if StdItem.Anicount = 2 then Item.btValue[2]:= Random(4) + 1;//ҩ��ֵ 20081210
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
    MainOutMessage('{�쳣} TUserEngine.CopyToUserItemFromName');
  end;
end;

procedure TUserEngine.ProcessUserMessage(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; Buff: PChar);
var
  sMsg{,sTemp,sTemp1}: string;
//  NewBuff: array[0..DATA_BUFSIZE2 - 1] of Char;
//  sDefMsg: string;
resourcestring
  sExceptionMsg = '{�쳣} TUserEngine::ProcessUserMessage..';
begin
  if (DefMsg = nil) or (PlayObject = nil) then Exit;
  try
    if Buff = nil then sMsg := ''
    else sMsg := StrPas(Buff);

    if DefMsg.nSessionID <> PlayObject.m_nSessionID then begin//20081210 ���ͻ��˻ỰID�Ƿ���ȷ, DefMsg.nSessionID�ͻ��˷�����ֵ
      Exit;
    end;

    case DefMsg.Ident of
      CM_SPELL: begin //3017
          //if PlayObject.GetSpellMsgCount <=2 then  //����������г�������ħ���������򲻼������
          if g_Config.boSpellSendUpdateMsg then begin //ʹ��UpdateMsg ���Է�ֹ��Ϣ�������ж������
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
        CM_SENDSELLOFFITEMLIST, //����
        CM_SENDQUERYSELLOFFITEM, //����
        CM_SENDBUYSELLOFFITEM, //����

      CM_HEROTAKEONITEM,
        CM_HEROTAKEOFFITEM,

      CM_TAKEOFFITEMHEROBAG, //װ�����µ�Ӣ�۰���
        CM_TAKEOFFITEMTOMASTERBAG, //װ�����µ����˰���

      CM_SENDITEMTOMASTERBAG, //���˰�����Ӣ�۰���
        CM_SENDITEMTOHEROBAG, //Ӣ�۰��������˰���

      CM_HEROTAKEONITEMFORMMASTERBAG, //�����˰�����װ����Ӣ�۰���
      CM_TAKEONITEMFORMHEROBAG, //��Ӣ�۰�����װ�������˰���
      CM_REPAIRFIRDRAGON,//���տͻ�������:�޲�����֮��

      CM_REPAIRDRAGON,//�޲�ף����.ħ��� 20080102
      CM_REPAIRFINEITEM,//�޲�����ʯ

      CM_CREATEGROUP,
      CM_ADDGROUPMEMBER,
      CM_DELGROUPMEMBER,
      CM_USERREPAIRITEM,
      CM_MERCHANTQUERYREPAIRCOST,
      CM_DEALTRY,
      CM_DEALADDITEM,
      CM_DEALDELITEM,
      CM_CHALLENGETRY,//�ͻ��˵���ս 20080705
      CM_CHALLENGEADDITEM,//��Ұ���Ʒ�ŵ���ս����
      CM_CHALLENGEDELITEM,//��Ҵ���ս����ȡ����Ʒ
      CM_CHALLENGECANCEL,//���ȡ����ս
      CM_CHALLENGECHGGOLD,//�ͻ��˰ѽ�ҷŵ���ս����
      CM_CHALLENGECHGDIAMOND,//�ͻ��˰ѽ��ʯ�ŵ���ս����
      CM_CHALLENGEEND,//��ս��Ѻ��Ʒ����
      CM_SELLOFFADDITEM,//Ԫ������ϵͳ �ͻ�����������Ʒ���������Ʒ  20080316
      CM_SELLOFFDELITEM,//�ͻ���ɾ��������Ʒ�������Ʒ  20080316
      CM_SELLOFFCANCEL,//�ͻ���ȡ��Ԫ������  20080316
      CM_SELLOFFEND, //�ͻ���Ԫ�����۽���  20080316
      CM_CANCELSELLOFFITEMING, //ȡ�����ڼ��۵���Ʒ 20080318(������)
      CM_SELLOFFBUYCANCEL,//ȡ������ ��Ʒ���� 20080318(������)
      CM_SELLOFFBUY,//ȷ�����������Ʒ 20080318
      CM_REFINEITEM, //�ͻ��˷��ʹ�����Ʒ 20080507

      CM_USERSTORAGEITEM,
      CM_USERPLAYDRINKITEM, //��ƿ� 20080515
      CM_USERTAKEBACKSTORAGEITEM,
        //      CM_WANTMINIMAP,
      CM_USERMAKEDRUGITEM,
      //      CM_GUILDHOME,
      CM_GUILDADDMEMBER,
      CM_GUILDDELMEMBER,
      CM_GUILDUPDATENOTICE,
      CM_OPENBOXS,
      CM_MOVEBOXS, //ת������
      CM_GETBOXS, //ȡ�ñ�����Ʒ
      CM_SELGETHERO, //ȡ��Ӣ�� 20080514
      CM_PlAYDRINKGAME, //��ȭ����
      CM_BEGINMAKEWINE,//��ʼ���(���Ѳ���ȫ���ϴ���) 20080620
      CM_CLICKSIGHICON, //�����̾��
      CM_CLICKCRYSTALEXPTOP, //�����ؽᾧ��þ��� 20090202
      CM_DrinkUpdateValue,
      CM_USERPLAYDRINK,
      CM_GUILDUPDATERANKINFO: begin
          PlayObject.SendMsg(PlayObject,   //����Ϣ���ݴ���ObjBase��Ԫ
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
        CM_TWNHIT,{����ն�ػ�}
        CM_QTWINHIT,{����ն��� 20080212}
        CM_CIDHIT,{��Ӱ����}
        CM_WIDEHIT,
        CM_PHHIT,
        CM_DAILY,//���ս��� 20080511
        CM_FIREHIT,{�һ�}
        CM_4FIREHIT{4���һ� 20080112}: begin
          if g_Config.boActionSendActionMsg then begin //ʹ��UpdateMsg ���Է�ֹ��Ϣ�������ж������
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
      CM_BUYSHOPITEMGIVE,CM_EXCHANGEGAMEGIRD: begin  //����,����һ� 20080302
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
        {if Assigned(zPlugOfEngine.ObjectClientMsg) then begin //20080813 ע��
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
        CM_WIDEHIT{����}, CM_FIREHIT{�һ�}, CM_4FIREHIT{4���һ�}, CM_CRSHIT{���µ�},CM_DAILY{���ս��� 20080511},
        CM_PHHIT{�ƻ�ն},CM_TWNHIT{����ն�ػ�}, CM_QTWINHIT{����ն��� 20080212},CM_CIDHIT{��Ӱ����}: begin
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
  //Cert := nil;//20080408 δʹ��
  Map := g_MapManager.FindMap(PlayObject.m_sMapName);
  if Map = nil then Exit;
  Cert := THeroObject.Create;
  if Cert <> nil then begin
    //MonInitialize(Cert, sMonName);
    GetHeroData(Cert, HumanRcd); //ȡӢ�۵�����
    if Cert.m_sHomeMap = '' then begin //��һ���ٻ�
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
 // Cert := nil;//δʹ�� 20080408
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
    //Cert.m_WAbil := Cert.m_Abil;// 20080418 ע��
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
            UserItem^.btValue:= PlayObject.m_UseItems[I].btValue;//20080418  �÷������֧�ּ�Ʒװ��
            UserItem^.Dura:= PlayObject.m_UseItems[I].Dura;//20090203 �����װ���־��������һ��
            TPlayMonster(Cert).AddItems(UserItem, I);
          end else Dispose(UserItem);//20080820 �޸�
        end;
      end;
    end;

    if PlayObject.m_MagicList.Count > 0 then begin//20080629
      for I := 0 to PlayObject.m_MagicList.Count - 1 do begin //���ħ��
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

    TPlayMonster(Cert).InitializeMonster; {��ʼ��}

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
      11: Cert := TSuperGuard.Create; //����ʿ
      20: Cert := TArcherPolice.Create; //û��  ���� 2007.11.26
      51: begin                       //������ӥ  ���� 2007.11.26
          Cert := TMonster.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(3500) + 3000;
          Cert.m_nBodyLeathery := 50;
        end;
      52: begin                      //¹��������   ���� 2007.11.26
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
      53: begin                   //��  ���� 2007.11.26
          Cert := TATMonster.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(8000) + 8000;
          Cert.m_nBodyLeathery := 150;
        end;
      55: begin                  //����ʦ
          Cert := TTrainer.Create;
          Cert.m_btRaceServer := 55;
        end;
      80: Cert := TMonster.Create;      //������  Tmonster���� ��ʼ��  ���� 2007.11.26
      81: Cert := TATMonster.Create;    //��������Ĺ���,���뷶Χ�Զ�����
      82: Cert := TSpitSpider.Create;   //������ʱ���¶��Ĺ���  2x2��Χ�ڶ�Һ����-��
      83: Cert := TSlowATMonster.Create; //Ҳ����������  ������  ��� ������
      84: Cert := TScorpion.Create;      //Ы��
      85: Cert := TStickMonster.Create;  //ʳ�˻�
      86: Cert := TATMonster.Create;     //����
      87: Cert := TDualAxeMonster.Create;//Ͷ��ͷ���ֹ��� (Զ�̹���)
      88: Cert := TATMonster.Create;     //����սʿ
      89: Cert := TATMonster.Create;     //����ս��   ���þ���   �������һ����
      90: Cert := TGasAttackMonster.Create;//����
      91: Cert := TMagCowMonster.Create;   //��������
      92: Cert := TCowKingMonster.Create;  //�������  ���й�������ħ��(�������������ڷ�Χ��ʱ��˲��)
      93: Cert := TThornDarkMonster.Create;//����սʿ  ��Ͷ�����  Ҳ��Զ�̹���
      94: Cert := TLightingZombi.Create;   //�罩ʬ
      95: begin                            //ʯĹʬ��   �ӵ���ð�����Ĺ�
          Cert := TDigOutZombi.Create;
          if Random(2) = 0 then Cert.bo2BA := True;
        end;
      96: begin                           //��� �д��о�
          Cert := TZilKinZombi.Create;
          if Random(4) = 0 then Cert.bo2BA := True;//�������ǽ
        end;
      97: begin
          Cert := TCowMonster.Create;    //����սʿ   ������ʿ  �����  ������
          if Random(2) = 0 then Cert.bo2BA := True;
        end;
      98: Cert := TSwordsmanMon.Create; //����ո���,��Ӱ���� 2���ڿ��Թ����Ĺ� 20090123

      100: Cert := TWhiteSkeleton.Create;  //��������    ��ʿ�ٻ��ı���
      101: begin                           //�������  ������ʿ ����տ�ʼ�Ǻڵ�(���뷶Χ���ʯ��״̬����)
          Cert := TScultureMonster.Create;
          Cert.bo2BA := True;
        end;
      102: Cert := TScultureKingMonster.Create;//�������
      103: Cert := TBeeQueen.Create;//�д�����
      104: Cert := TArcherMonster.Create;//���깭����  ħ�������� �����
      105: Cert := TGasMothMonster.Create;//Ш��
      106: Cert := TGasDungMonster.Create;//���
      107: Cert := TCentipedeKingMonster.Create; //������  ���ܶ��Ĺ��
      108: begin
         Cert := TFairyMonster.Create;   //����
         Cert.bo2BA := True;//�������ǽ 20080327
        end;
      110: Cert := TCastleDoor.Create;  //ɳ�Ϳ˵� ����
      111: Cert := TWallStructure.Create; //ɳ�Ϳ˵� ��ǽ,�У���
      112: Cert := TArcherGuard.Create;  //����������� NPC
      113: Cert := TElfMonster.Create;   //����
      114: Cert := TElfWarriorMonster.Create; //����1
      115: Cert := TBigHeartMonster.Create;   //���¶�ħ  ǧ������  �ӵ���ð�̵�  ���ܶ��Ĺ�
      116: Cert := TSpiderHouseMonster.Create; //���ڿ��� �����ֵ� ��
      117: Cert := TExplosionSpider.Create;   //��Ӱ֩��
      118: Cert := THighRiskSpider.Create;   //����֩��
      119: Cert := TBigPoisionSpider.Create; //����֩��
      120: Cert := TSoccerBall.Create;       //�ɻ�����   ��ʵ��������
      121: Cert := TGiantSickleSpiderATMonster.Create;//����֩�� 20080809
      122: Cert := TSalamanderATMonster.Create;//���Ȼ����� 20080809
      123: Cert := TTempleGuardian.Create;//ʥ����ʿ 20080809
      124: Cert := TheCrutchesSpider.Create;//����֩�� 20080809
      125: Cert := TYanLeiWangSpider.Create;//�������� 20080811
      126: Cert := TSnowyFireDay.Create;//ѩ������ħ �������,��ʩ�ź춾 20090113
      127: Cert := TDevilBat.Create;//��ħ���� 20090112 ʩ����,������,����,Ұ��������Ч,ֻ�е�ʿ��ħ�������ס,ֻ��սʿ��ɱ�ĵ�2���ܹ�����,������ʽ���������Ա�����
      128: Cert := TFireDragon.Create;//����ħ�� 20090111
      129: Cert := TFireDragonGuard.Create;//�����ػ��� 20090111
      130: Cert := TSnowyHanbing.Create;//ѩ�򺮱�ħ:����������ʩ���̶� 20090113
      131: Cert := TSnowyWuDu.Create;//ѩ���嶾ħ:������,������ 20090113

      135: Cert := TArcherGuardMon.Create; //���ƹ����ֵĹ�,ֻ����� 20080121
      136: Cert := TArcherGuardMon1.Create; //�����ƶ�,���ṥ���Ĺ� 20080122 ħ����Ĺ�
      150: Cert := TPlayMonster.Create;//���ι�
      200: Cert := TElectronicScolpionMon.Create; //�д��о�
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
      MonGetRandomItems(Cert);//ȡ�ù�����Ա���Ʒ
      nCode:= 7;
      Cert.Initialize();
      nCode:= 8;
      case nMonRace of
        108: begin
           TFairyMonster(Cert).nWalkSpeed:= Cert.m_nWalkSpeed;//��������DB���õ���·�ٶ� 20090105
         end;
        121: TGiantSickleSpiderATMonster(Cert).AddItemsFromConfig;//����֩��(��ȡ��̽����Ʒ) 20080810
        122: TSalamanderATMonster(Cert).AddItemsFromConfig;//���Ȼ�����(��ȡ��̽����Ʒ) 20080810
        123: TTempleGuardian(Cert).AddItemsFromConfig;//ʥ����ʿ(��ȡ��̽����Ʒ) 20080810
        124: TheCrutchesSpider(Cert).AddItemsFromConfig;//����֩��(��ȡ��̽����Ʒ) 20080810
        125: TYanLeiWangSpider(Cert).AddItemsFromConfig;//��������(��ȡ��̽����Ʒ) 20080815
        136:begin//20080124 136���Զ��߶� ħ�����
           if {(CompareText(Cert.m_sMapName, m_sMapName_136) = 0) and }//20090204
              (m_nCurrX_136 <> 0) and (m_nCurrY_136 <> 0) then begin
              Cert.m_nCurrX := m_nCurrX_136;
              Cert.m_nCurrY := m_nCurrY_136;
              TArcherGuardMon1(Cert).m_NewCurrX:= m_NewCurrX_136;
              TArcherGuardMon1(Cert).m_NewCurrY:= m_NewCurrY_136;
              TArcherGuardMon1(Cert).m_boWalk:= True;
            end;
         end;
        150:begin//���͹�
           Cert.m_nCopyHumanLevel := 0;
           Cert.m_Abil.MP := Cert.m_Abil.MaxMP;
           Cert.m_Abil.HP := Cert.m_Abil.MaxHP; //���ݿ�HPΪ0,ʹ��һ�������� 20080120
           Cert.m_WAbil := Cert.m_Abil;
           TPlayMonster(Cert).InitializeMonster; //��ʼ�����ι���,���ļ�����(����,װ��)
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
          Inc(Cert.m_nViewRange, 2); //2006-12-30 �����Ӿ�+2
        end;
      end;
    end;
    nCode:= 10;
    if Cert <> nil then begin
      if Cert.m_btRaceServer = 150 then begin//20090203 ȡ�ػ�����
        TPlayMonster(Cert).m_nProtectTargetX:= Cert.m_nCurrX;//�ػ�����
        TPlayMonster(Cert).m_nProtectTargetY:= Cert.m_nCurrY;//�ػ�����
      end;
    end;
    Result := Cert;
  except
    MainOutMessage('{�쳣} TUserEngine.AddBaseObject MonRace:'+ inttostr(nMonRace)+' Code:'+inttostr(nCode));
  end;
end;
//====================================================
//����:�����������
//����ֵ����ָ��ʱ���ڴ���������򷵼�TRUE���������ָ��ʱ���򷵻�FALSE
//====================================================
function TUserEngine.RegenMonsters(MonGen: pTMonGenInfo; nCount: Integer): Boolean;
var
  dwStartTick: LongWord;
  nX: Integer;
  nY: Integer;
  I: Integer;
  Cert: TBaseObject;
resourcestring
  sExceptionMsg = '{�쳣} TUserEngine::RegenMonsters';
begin
  Result := True;
  dwStartTick := GetTickCount();
  try
    if MonGen <> nil then begin
      if MonGen.nRace > 0 then begin
        if nCount <= 0 then nCount:=1;//20081008
        if Random(100) < MonGen.nMissionGenRate then begin//�Ƿ���ˢ��
          nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          for I := 0 to nCount - 1 do begin
            Cert := AddBaseObject(MonGen.sMapName, ((nX - 10) + Random(20)), ((nY - 10) + Random(20)), MonGen.nRace, MonGen.sMonName);
            if Cert <> nil then begin
              Cert.m_nChangeColorType := MonGen.nChangeColorType; //�Ƿ��ɫ
              Cert.m_btNameColor:= MonGen.nNameColor;//�Զ������ֵ���ɫ 20080810
              if MonGen.nNameColor <> 255 then Cert.m_boSetNameColor:= True;//20081001 �Զ���������ɫ
              Cert.m_boIsNGMonster:= MonGen.boIsNGMon;//�ڹ���,����������������ֵ 20081001
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
              Cert.m_nChangeColorType := MonGen.nChangeColorType; //�Ƿ��ɫ
              Cert.m_btNameColor:= MonGen.nNameColor;//�Զ������������ɫ 20080810
              if MonGen.nNameColor <> 255 then Cert.m_boSetNameColor:= True;//20081001 �Զ���������ɫ
              Cert.m_boIsNGMonster:= MonGen.boIsNGMon;//�ڹ���,����������������ֵ 20081001
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

//ȡʦ���� 20080512
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
//20071227 ��Ӣ�����ֲ���Ӣ��
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
//�߳�����
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
            Result := PlayObject; //20080716 �滻
            Break;
          end;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;
//��ȡ���߹�����
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
//���ҽ���NPC
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
//ȡ����Ȩ��
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
{//20080522 ע��
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
//�߳���������
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
//������������
procedure TUserEngine.SaveHumanRcd(PlayObject: TPlayObject);
var
  SaveRcd: pTSaveRcd;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if PlayObject <> nil then begin//20090104
      if PlayObject.m_boOperationItemList then Exit;//20080928 ��ֹͬʱ���������б�ʱ����
      if PlayObject.m_boRcdSaveding then Exit;//�Ƿ����ڱ������� 20090106 ��ֹͬ�������
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
    MainOutMessage('{�쳣} TUserEngine.SaveHumanRcd Code:'+inttostr(nCode));
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
      if PlayObject.m_boOperationItemList then Exit;//20080928 ��ֹͬʱ���������б�ʱ����
      nCode:= 2;
      if PlayObject.m_MyHero <> nil then begin
        if PlayObject.m_boRcdSaveding then Exit;//�Ƿ����ڱ������� 20090106 ��ֹͬ�������
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
    MainOutMessage('{�쳣} TUserEngine.SaveHeroRcd Code:'+inttostr(nCode));
  end;
end;
//���������б�
procedure TUserEngine.AddToHumanFreeList(PlayObject: TPlayObject);
begin
  PlayObject.m_dwGhostTick := GetTickCount();
  m_PlayObjectFreeList.Add(PlayObject);
end;
{//20080522 ע��
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
//ȡ���ݿ����������
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

  PlayObject.m_sLastMapName := PlayObject.m_sMapName; //2006-01-12���������ϴ��˳���ͼ
  PlayObject.m_nLastCurrX := PlayObject.m_nCurrX; //2006-01-12���������ϴ��˳���������X
  PlayObject.m_nLastCurrY := PlayObject.m_nCurrY; //2006-01-12���������ϴ��˳���������Y

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
  PlayObject.m_Abil.Alcohol:= HumData.n_Reserved;//���� 20080622
  PlayObject.m_Abil.MaxAlcohol:=  HumData.n_Reserved1;//�������� 20080622
  if PlayObject.m_Abil.MaxAlcohol < g_Config.nMaxAlcoholValue then PlayObject.m_Abil.MaxAlcohol:= g_Config.nMaxAlcoholValue;//��������С�޳�ʼֵʱ,���޸� 20080623
  PlayObject.m_Abil.WineDrinkValue := HumData.n_Reserved2;//��ƶ� 2008623
  PlayObject.n_DrinkWineQuality := HumData.btUnKnow2[2];//����ʱ�Ƶ�Ʒ��
  PlayObject.n_DrinkWineAlcohol := HumData.UnKnow[4];//����ʱ�ƵĶ��� 20080624
  PlayObject.m_btMagBubbleDefenceLevel := HumData.UnKnow[5];//ħ���ܵȼ� 20080811

  PlayObject.m_Abil.MedicineValue:= HumData.nReserved1; //��ǰҩ��ֵ 20080623
  PlayObject.m_Abil.MaxMedicineValue:= HumData.nReserved2; //ҩ��ֵ���� 20080623
  PlayObject.n_DrinkWineDrunk:=  HumData.boReserved3;//���Ƿ�Ⱦ����� 20080627

  PlayObject.dw_UseMedicineTime:= HumData.nReserved3; //ʹ��ҩ��ʱ��,���㳤ʱ��ûʹ��ҩ�� 20080623
  PlayObject.n_MedicineLevel:= HumData.n_Reserved3;  //ҩ��ֵ�ȼ� 20080623
  if PlayObject.n_MedicineLevel <= 0 then PlayObject.n_MedicineLevel:=1;//���ҩ��ֵ�ȼ�Ϊ0,������Ϊ1 20080624
  if PlayObject.m_Abil.MaxMedicineValue <= 0 then
      PlayObject.m_Abil.MaxMedicineValue:= PlayObject.GetMedicineExp(PlayObject.n_MedicineLevel);

  PlayObject.m_Exp68 := HumData.Exp68;//�������嵱ǰ���� 20080625
  PlayObject.m_MaxExp68 := HumData.MaxExp68;//���������������� 20080625

  PlayObject.m_boTrainingNG := HumData.UnKnow[6] <> 0;//�Ƿ�ѧϰ���ڹ� 20081002
  if PlayObject.m_boTrainingNG then PlayObject.m_NGLevel := HumData.UnKnow[7]//�ڹ��ȼ� 20081204
  else PlayObject.m_NGLevel := 0;
  PlayObject.m_ExpSkill69 := HumData.nExpSkill69;//�ڹ���ǰ���� 20080930
  PlayObject.m_Skill69NH := HumData.Abil.NG;//�ڹ���ǰ����ֵ 20080930
  PlayObject.m_Skill69MaxNH := HumData.Abil.MaxNG;//����ֵ���� 20081001

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
  if PlayObject.m_boMaster or (PlayObject.m_sMasterName <> '') then PlayObject.GetMasterNoList();//20080530 ȡʦͽ����
  PlayObject.m_sDearName := HumData.sDearName;

  PlayObject.m_sStoragePwd := HumData.sStoragePwd;
  if PlayObject.m_sStoragePwd <> '' then PlayObject.m_boPasswordLocked := True;

  PlayObject.m_nGameGold := HumData.nGameGold;
  PlayObject.m_nGameDiaMond:= HumData.nGameDiaMond; //20071226 ���ʯ
  PlayObject.m_nGameGird:= HumData.nGameGird; //20071226 ���

 // if g_Config.boSaveExpRate then begin //�Ƿ񱣴�˫������ʱ�� 20080412
    PlayObject.m_nKillMonExpRate:= HumData.nEXPRATE; //20071230 ���鱶��
    PlayObject.m_dwKillMonExpRateTime:= HumData.nExpTime; //20071230 ���鱶��ʱ��
    PlayObject.m_nOldKillMonExpRate := PlayObject.m_nKillMonExpRate;//20080607
    if PlayObject.m_nKillMonExpRate <= 0 then PlayObject.m_nKillMonExpRate:= 100;//20081229
 // end;

  PlayObject.m_nGamePoint := HumData.nGamePoint;
  PlayObject.m_nPayMentPoint := HumData.nPayMentPoint;

  PlayObject.m_btGameGlory := HumData.btGameGlory; //���� 20080511

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
  //PlayObject.nC4 := HumData.btEE;//20081007 ע�ͣ�nC4��ʵ���ô�
  PlayObject.m_boLockLogon := HumData.boLockLogon;

  PlayObject.m_wContribution := HumData.wContribution;
  PlayObject.m_nHungerStatus := HumData.nHungerStatus;
  PlayObject.m_boAllowGuildReCall := HumData.boAllowGuildReCall;
  PlayObject.m_wGroupRcallTime := HumData.wGroupRcallTime;
  PlayObject.m_dBodyLuck := HumData.dBodyLuck;
  PlayObject.m_boAllowGroupReCall := HumData.boAllowGroupReCall;
  {PlayObject.m_QuestUnitOpen := HumData.QuestUnitOpen;
  PlayObject.m_QuestUnit := HumData.QuestUnit; }
  PlayObject.m_btLastOutStatus := HumData.btLastOutStatus; //�˳�״̬ 1Ϊ����
  PlayObject.m_wMasterCount := HumData.wMasterCount; //��ʦͽ����
  PlayObject.bo_YBDEAL:= HumData.btUnKnow2[0]= 1;//�Ƿ�ͨԪ������ 20080316
  PlayObject.m_nWinExp := HumData.n_WinExp;//20080221 ������  �ۼƾ���
  PlayObject.n_UsesItemTick:= HumData.n_UsesItemTick ;//������ۼ�ʱ�� 20080221
  PlayObject.m_QuestFlag := HumData.QuestFlag;
  PlayObject.m_boHasHero := HumData.boHasHero;
  PlayObject.m_boHasHeroTwo := HumData.boReserved1;//20080519 �Ƿ�������Ӣ��
  PlayObject.m_sHeroCharName := HumData.sHeroChrName;
  PlayObject.n_HeroSave := HumData.btUnKnow2[1];//�Ƿ񱣴�Ӣ�� 20080513
  PlayObject.n_myHeroTpye := HumData.btEF;//��ɫ���ϴ���Ӣ������������  20080515
  PlayObject.m_boPlayDrink:= HumData.boReserved;//�Ƿ������ T-����� 20080515

  PlayObject.m_GiveGuildFountationDate:=HumData.m_GiveDate;//������ȡ�л��Ȫ���� 20080625
  PlayObject.m_boMakeWine:= HumData.boReserved2;//�Ƿ���� 20080620
  PlayObject.m_MakeWineTime:= HumData.nReserved;//��Ƶ�ʱ��,�����ж೤ʱ�����ȡ�ؾ� 20080620
  PlayObject.n_MakeWineItmeType:=HumData.UnKnow[0];//��ƺ�,Ӧ�ÿ��Եõ��Ƶ����� 2008020
  PlayObject.n_MakeWineType:= HumData.UnKnow[1];//��Ƶ����� 1-��ͨ�� 2-ҩ��  20080620
  PlayObject.n_MakeWineQuality:= HumData.UnKnow[2];//��ƺ�,Ӧ�ÿ��Եõ��Ƶ�Ʒ�� 20080620
  PlayObject.n_MakeWineAlcohol:= HumData.UnKnow[3];//��ƺ�,Ӧ�ÿ��Եõ��Ƶľƾ��� 20080620

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
  PlayObject.m_UseItems[U_ZHULI] := HumAddItems[U_ZHULI];//20080416 ����

  BagItems := @HumanRcd.Data.BagItems;
  for I := Low(TBagItems) to High(TBagItems) do begin
    if BagItems[I].wIndex > 0 then begin
      New(UserItem);
      FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 ����
      //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 ����
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
  HumNGMagics:= @HumanRcd.Data.HumNGMagics;//20081001 �ڹ�����
  for I := Low(THumNGMagics) to High(THumNGMagics) do begin//�ڹ����� 20081001
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
  for I := Low(TStorageItems) to High(TStorageItems) do begin//�ֿ���Ʒ
    if StorageItems[I].wIndex > 0 then begin
      New(UserItem);
      FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 ����
      //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 ����
      UserItem^ := StorageItems[I];
      PlayObject.m_StorageItemList.Add(UserItem);
    end;
  end;
  PlayObject.m_BigStorageItemList := g_Storage.GetUserBigStorageList(PlayObject.m_sCharName);//��ȡ���޲ֿ�����

  //��ȡ��·��ʯ��¼�ĵ�ͼ��XYֵ 20081019
  sFileName := g_Config.sEnvirDir + 'UserData\HumRecallPoint.txt';
  if FileExists(sFileName) then begin
    IniFile := TIniFile.Create(sFileName);
    Try
      for I:= 1 to 6 do begin
        sY:= IniFile.ReadString( PlayObject.m_sCharName , '��¼'+inttostr(I), '');
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
//ȡӢ������
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
  HeroObject.m_nFirDragonPoint := HumData.nGold;//�����������������ŭ��ֵ 20080419
  //PlayObject.m_nGold := HumData.nGold;

  //HeroObject.m_sLastMapName := PlayObject.m_sMapName; //2006-01-12���������ϴ��˳���ͼ
  //HeroObject.m_nLastCurrX := HeroObject.m_nCurrX; //2006-01-12���������ϴ��˳���������X
  //HeroObject.m_nLastCurrY := HeroObject.m_nCurrY; //2006-01-12���������ϴ��˳���������Y

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
  HeroObject.m_Abil.Alcohol:= HumData.n_Reserved;//���� 20080622
  HeroObject.m_Abil.MaxAlcohol:=  HumData.n_Reserved1;//�������� 20080622
  if HeroObject.m_Abil.MaxAlcohol < g_Config.nMaxAlcoholValue then HeroObject.m_Abil.MaxAlcohol:= g_Config.nMaxAlcoholValue;//��������С�޳�ʼֵʱ,���޸� 20080623
  HeroObject.m_Abil.WineDrinkValue := HumData.n_Reserved2;//��ƶ� 2008623
  HeroObject.n_DrinkWineQuality := HumData.btUnKnow2[2];//����ʱ�Ƶ�Ʒ��
  HeroObject.n_DrinkWineAlcohol:= HumData.UnKnow[4];//����ʱ�ƵĶ��� 20080624
  HeroObject.m_btMagBubbleDefenceLevel := HumData.UnKnow[5];//ħ���ܵȼ� 20080811

  HeroObject.m_Exp68:= HumData.Exp68;//�������嵱ǰ���� 20080925
  HeroObject.m_MaxExp68:= HumData.MaxExp68;//���������������� 20080925

  HeroObject.m_boTrainingNG := HumData.UnKnow[6] <> 0;//�Ƿ�ѧϰ���ڹ� 20081002
  if HeroObject.m_boTrainingNG then HeroObject.m_NGLevel := HumData.UnKnow[7]//�ڹ��ȼ� 20081002
  else HeroObject.m_NGLevel := 0;
  HeroObject.m_ExpSkill69 := HumData.nExpSkill69;//�ڹ���ǰ���� 20080930
  HeroObject.m_Skill69NH := HumData.Abil.NG;//�ڹ���ǰ����ֵ 20080930
  HeroObject.m_Skill69MaxNH := HumData.Abil.MaxNG;//����ֵ���� 20081001

  HeroObject.m_Abil.MedicineValue:= HumData.nReserved1; //��ǰҩ��ֵ 20080623
  HeroObject.m_Abil.MaxMedicineValue:= HumData.nReserved2; //ҩ��ֵ���� 20080623
  HeroObject.n_DrinkWineDrunk:=  HumData.boReserved3;//���Ƿ�Ⱦ����� 20080627
  HeroObject.dw_UseMedicineTime:= HumData.nReserved3; //ʹ��ҩ��ʱ��,���㳤ʱ��ûʹ��ҩ�� 20080623
  HeroObject.n_MedicineLevel:= HumData.n_Reserved3;  //ҩ��ֵ�ȼ� 20080623
  if HeroObject.n_MedicineLevel <= 0 then HeroObject.n_MedicineLevel:=1;//���ҩ��ֵ�ȼ�Ϊ0,������Ϊ1 20080624
  if HeroObject.m_Abil.MaxMedicineValue <= 0 then//ҩ��ֵ����Ϊ0ʱ,ȡ���õľ��� 20080624
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
  HeroObject.m_BonusAbil := HumData.BonusAbil;//20081126 Ӣ����������
  HeroObject.m_nBonusPoint := HumData.nBonusPoint; // 08/09
  HeroObject.m_btCreditPoint := HumData.btCreditPoint;
  HeroObject.m_btReLevel := HumData.btReLevel;

  HeroObject.m_nWinExp :=HumData.n_WinExp;//Ӣ���ۼƾ���ֵ 20080110
  HeroObject.m_nLoyal :=HumData.nLoyal;
  if HeroObject.m_nLoyal >10000 then HeroObject.m_nLoyal :=10000;
  
  HeroObject.m_btLastOutStatus := HumData.btLastOutStatus; //�˳�״̬ 1Ϊ����
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
  //HeroObject.nC4 := HumData.btEE;//20081007 ע�ͣ�nC4��ʵ���ô�
  HeroObject.n_HeroTpye:= HumData.btEF;//Ӣ������ 0-������Ӣ�� 1-����Ӣ�� 20080514
  //HeroObject.m_boLockLogon := HumData.boLockLogon;

  //HeroObject.m_wContribution := HumData.wContribution;
  //HeroObject.m_nHungerStatus := HumData.nHungerStatus;
  //HeroObject.m_boAllowGuildReCall := HumData.boAllowGuildReCall;
  //HeroObject.m_wGroupRcallTime := HumData.wGroupRcallTime;
  HeroObject.m_dBodyLuck := HumData.dBodyLuck;
  //HeroObject.m_boAllowGroupReCall := HumData.boAllowGroupReCall;

  //PlayObject.m_wMasterCount := HumData.wMasterCount; //��ʦͽ����

  HeroObject.m_QuestFlag := HumData.QuestFlag;
  //HeroObject.m_boHasHero := HumData.boHasHero;
  HeroObject.m_btStatus := HumData.btStatus; //Ӣ�۵�״̬ 20080717
  if HeroObject.m_Abil.Level <= 22 then HeroObject.m_btStatus := 1;//20080710 22��֮ǰ,Ĭ�ϸ���

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
  HeroObject.m_UseItems[U_ZHULI] := HumAddItems[U_ZHULI];//20080416 ����
  BagItems := @HumanRcd.Data.BagItems;
  for I := Low(TBagItems) to High(TBagItems) do begin
    if BagItems[I].wIndex > 0 then begin
      New(UserItem);
      FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 ����
      //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 ����
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
      UserMagic.btKey := HumMagics[I].btKey;//ħ����ݼ�(��ħ������)
      UserMagic.nTranPoint := HumMagics[I].nTranPoint;
      HeroObject.m_MagicList.Add(UserMagic);
    end;
  end;
  HumNGMagics:= @HumanRcd.Data.HumNGMagics;//20081001 �ڹ�����
  for I := Low(THumNGMagics) to High(THumNGMagics) do begin//�ڹ����� 20081001
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
//ȡ�س�����
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
//����ħ��
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
          if (Magic <> nil) and ((Magic.sDescr = '') or (Magic.sDescr = '�ڹ�')) then begin
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
        if (Magic <> nil) and ((Magic.sDescr = '') or (Magic.sDescr = '�ڹ�')) then begin
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
          if (Magic <> nil) and ((Magic.sDescr = 'Ӣ��') or (Magic.sDescr = '�ڹ�')) then begin
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
        if (Magic <> nil) and ((Magic.sDescr = 'Ӣ��') or (Magic.sDescr = '�ڹ�')) then begin
          if Magic.wMagicId = nMagIdx then begin
            Result := Magic;
            Break;
          end;
        end;
      end;//for
    end;
  end;
end;
//�����ʼ��
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
            BaseObject.m_btLifeAttrib := Monster.btLifeAttrib;//����ϵ
            BaseObject.m_btCoolEye := Monster.wCoolEye;//���ӷ�Χ
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
            BaseObject.m_btSpeedPoint := _MIN(High(Byte),Monster.wSpeed);//20081204 ���� m_btSpeedPointΪByte���������ж�
            nCode:= 8;
            BaseObject.m_btHitPoint := _MIN(High(Byte),Monster.wHitPoint);//20081204 ���� m_btHitPointΪByte���������ж�
            nCode:= 9;
            BaseObject.m_nWalkSpeed := Monster.wWalkSpeed;//�����ٶ�
            BaseObject.m_nWalkStep := Monster.wWalkStep;
            BaseObject.m_dwWalkWait := Monster.wWalkWait;
            BaseObject.m_nNextHitTime := Monster.wAttackSpeed;//�����ٶ�
            nCode:= 10;
            Break;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TUserEngine.MonInitialize Name:'+ sMonName+' Code:'+Inttostr(nCode));
  end;
end;
//����
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
//�ر���
function TUserEngine.CloseDoor(Envir: TEnvirnoment; Door: pTDoorInfo): Boolean;
begin
  Result := False;
  if (Door <> nil) and (Door.Status.boOpened) then begin
    Door.Status.boOpened := False;
    SendDoorStatus(Envir, Door.nX, Door.nY, RM_DOORCLOSE, 0, Door.nX, Door.nY, 0, '');
    Result := True;
  end;
end;
//�����ŵ�״̬
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
//����  ����ð�ҽ� 20080327
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
            if (Envir.nThunder <> 0) or (Envir.nLava <> 0) then begin //����,�ҽ�Ч��
              Amount:= GetMapHuman(Envir.sMapName);//ȡ��ͼ������
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
        //envir:=nil;//20080408 δʹ��
      end;
    except
      MainOutMessage('{�쳣} TUserEngine.ProcessEffects');
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
    Target:= FindNearbyTarget(x,y,Envir,m_TargetList);//����Ŀ��
    nCode:= 22;
    if (Target = nil) then Exit;
    nCode:= 1;
    if Random(3) = 0 then begin
      x:=Target.m_nCurrX;
      y:=Target.m_nCurrY;
    end else begin//20080726 ����
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
            magpwr:=(Dmg -(Dmg div 3))+ Random(Dmg div 3);//20080412 ��ֵ
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
    MainOutMessage('{�쳣} TUserEngine.EffectTarget Code:'+inttostr(nCode));
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
    Envir.GetRangeBaseObject(x,y,nRage,TRUE,xTargetList);//���������Ķ���
    if xTargetList.count > 0 then begin//20080629
      for i:=0 to xTargetList.count - 1 do begin
        BaseObject:= TBaseObject(xTargetList.Items[i]);
        if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_Master <> nil) then begin //20080418 ����or (BaseObject.m_Master <> nil)
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
          if (Magic <> nil) and ((Magic.sDescr = 'Ӣ��') or (Magic.sDescr = '�ڹ�')) then begin
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
        if (Magic <> nil) and ((Magic.sDescr = 'Ӣ��') or (Magic.sDescr = '�ڹ�')) then begin
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
          if (Magic <> nil) and ((Magic.sDescr = '') or (Magic.sDescr = '�ڹ�')) then begin
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
        if (Magic <> nil) and ((Magic.sDescr = '') or (Magic.sDescr = '�ڹ�')) then begin
          if CompareText(Magic.sMagicName, sMagicName) = 0 then begin
            Result := Magic;
            Break;
          end;
        end;
      end;//for
    end;
  end;
end;
//ȡ��ͼ��Χ���й�
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
//���ӽ���NPC
procedure TUserEngine.AddMerchant(Merchant: TMerchant);
begin
  UserEngine.m_MerchantList.Lock;
  try
    UserEngine.m_MerchantList.Add(Merchant);
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
end;
//ȡ����NPC�б�
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
//ȡNPC�б�
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
//���¼���NPC�б�
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
//�ض�NPC�ű�
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
//ȡ��ͼ�������� 20080123
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

//20080123 ����ͼָ������ָ�����ƹ�������
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
              //if nC <= 5  then Inc(Result); //20080323 �޸� <=5
              if (abs(nX - BaseObject.m_nCurrX) <= nC) and (abs(nY - BaseObject.m_nCurrY) <= nC) then begin//20081217 �޸�
                Inc(Result);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//ȡ���˲�ˢ�ֵ�ͼ,ˢ������ 20080830
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
//ȡ��ͼ����
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
//ȡ��ͼ��Χ�ڵ�����
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
{//�жϹ������귶Χ���Ƿ������ 20080520
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
//��ÿ�����﷢����Ϣ
//�̰߳�ȫ
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
//��ǿ���ļ���Ϣ���ͺ���(��NPC����-SendMsgʹ��) 20081214
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
//M2������Ҫ����,CPU �ڴ��ռ�ô󲿷������
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
      if (GetTickCount - dwGetOrderTick > 150000{1000 * 60 * 2}) and (not bo_ReadPlayLeveList) then begin //20080926 �޸�,ÿ2.5���Ӷ�ȡһ�������ļ�
        dwGetOrderTick := GetTickCount;
        nCode:= 2;
        //GetHumanOrder(); //��ȡ����ȼ����� 20080527
        GetPlayObjectLevelList();//��ȡ����ȼ����� 20080527
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
        ProcessEffects(); //20080327 ����(���׶�ħ��Ч��)
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
      MainOutMessage('{�쳣} TUserEngine::ProcessData Code:'+inttostr(nCode));
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
  ClearMerchantData();//��ս���NPC��ʱ����
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
//��ս���NPC����
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

//ȡ������Ʒ
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
    MainOutMessage('{�쳣} TUserEngine.GetShopStdItem');
  end;
end;
end.



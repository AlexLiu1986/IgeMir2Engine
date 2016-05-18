unit ObjNpc;

interface
uses
  Windows, Classes, SysUtils, StrUtils, ObjBase, Grobal2, SDK, IniFiles;
type
  TUpgradeInfo = record
    sUserName: string[14];//������Ʒ��������
    UserItem: TUserItem;
    btDc: Byte;
    btSc: Byte;
    btMc: Byte;
    btDura: Byte;
    n2C: Integer;//δʹ��
    dtTime: TDateTime;
    dwGetBackTick: LongWord;
    n3C: Integer;//δʹ��
  end;
  pTUpgradeInfo = ^TUpgradeInfo;
  TItemPrice = record
    wIndex: Word;
    nPrice: Integer;
  end;
  pTItemPrice = ^TItemPrice;
  TGoods = record
    sItemName: string[14];
    nCount: Integer;
    dwRefillTime: LongWord;
    dwRefillTick: LongWord;
  end;
  pTGoods = ^TGoods;

  TSellItemPrice = record
    wIndex: Word;
    nPrice: Integer;
  end;
  pTSellItemPrice = ^TSellItemPrice;

  TQuestActionInfo = record
    nCMDCode: Integer;
    sParam1: string;
    nParam1: Integer;
    sParam2: string;
    nParam2: Integer;
    sParam3: string;
    nParam3: Integer;
    sParam4: string;
    nParam4: Integer;
    sParam5: string;
    nParam5: Integer;
    sParam6: string;
    nParam6: Integer;
    sParam7: string;
    nParam7: Integer;
  end;
  pTQuestActionInfo = ^TQuestActionInfo;
  TQuestConditionInfo = record
    nCMDCode: Integer;
    sParam1: string;
    nParam1: Integer;
    sParam2: string;
    nParam2: Integer;
    sParam3: string;
    nParam3: Integer;
    sParam4: string;
    nParam4: Integer;
    sParam5: string;
    nParam5: Integer;
    sParam6: string;
    nParam6: Integer;
    sParam7: string;
    nParam7: Integer;
  end;
  pTQuestConditionInfo = ^TQuestConditionInfo;
  TSayingProcedure = record
    ConditionList: TList;
    ActionList: TList;
    sSayMsg: string;
    ElseActionList: TList;
    sElseSayMsg: string;
  end;
  pTSayingProcedure = ^TSayingProcedure;
  TSayingRecord = record
    sLabel: string;
    ProcedureList: TList;
    boExtJmp: Boolean; //�Ƿ������ⲿ��ת
  end;
  pTSayingRecord = ^TSayingRecord;
  TNormNpc = class(TAnimalObject)
    m_nFlag: ShortInt;//���ڱ�ʶ��NPC�Ƿ���Ч���������¼���NPC�б�(-1 Ϊ��Ч)
    m_ScriptList: TList; //
    m_sFilePath: string; //�ű��ļ�����Ŀ¼
    m_boIsHide: Boolean; //��NPC�Ƿ������صģ�����ʾ�ڵ�ͼ��
    m_boIsQuest: Boolean; //NPC����Ϊ��ͼ�����͵ģ����ؽű�ʱ�Ľű��ļ���Ϊ ��ɫ��-��ͼ��.txt
    m_sPath: string;
    m_boNpcAutoChangeColor: Boolean;//�Ƿ��ɫ
    m_dwNpcAutoChangeColorTick: LongWord;//��ɫ���
    m_dwNpcAutoChangeColorTime: LongWord;//��ɫʱ��
    m_nNpcAutoChangeIdx: Integer;
    m_boGotoCount: Word;//ִ��Goto�Ĵ��� 20080927
  private
    procedure ScriptActionError(PlayObject: TPlayObject; sErrMsg: string; QuestActionInfo: pTQuestActionInfo; sCmd: string);
    procedure ScriptConditionError(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo; sCmd: string);
    procedure ExeAction(PlayObject: TPlayObject; sParam1, sParam2, sParam3: string; nParam1, nParam2, nParam3: Integer);
    procedure ActionOfChangeLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUnMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUnMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGiveItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGetMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGetMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelNoJobSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//���Ӽ���  ֧��Ӣ��
    procedure ActionOfADDGUILDMEMBER(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//����л��Ա//20080427
    procedure ActionOfDELGUILDMEMBER(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//ɾ���л��Ա��ɾ��������Ч��//20080427
    procedure ActionOfSkillLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�������＼�ܵȼ�
    procedure ActionOfHeroSkillLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//����Ӣ�ۼ��ܵȼ� 20080415
    procedure ActionOfChangePkPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeExp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeNGExp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�����ڹ����� 20081002
    procedure ActionOfCHANGENGLEVEL(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�����ڹ��ȼ� 20081004
    procedure ActionOfOPENEXPCRYSTAL(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�ͻ�����ʾ��ؽᾧ 20090131
    procedure ActionOfCLOSEEXPCRYSTAL(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�ͻ��˹ر���ؽᾧ 20090131
    procedure ActionOfGETEXPTOCRYSTAL(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//ȡ����ؽᾧ�еľ���(ֻ��ȡ����ȡ�ľ���) 20090202
    procedure ActionOfSENDTIMEMSG(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//ʱ�䵽����QF��(�ͻ�����ʾ��Ϣ) 20090124
    procedure ActionOfSENDMSGWINDOWS(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//ʱ�䵽����QF�� 20090124
    procedure ActionOfCLOSEMSGWINDOWS(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�رտͻ���'!'ͼ�����ʾ 20090126
    procedure ActionOfGETGROUPCOUNT(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//ȡ��ӳ�Ա�� 20090125
    procedure ActionOfChangeCreditPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCHANGEGUILDMEMBERCOUNT(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�����л��Ա���� 20090115
    procedure ActionOfCHANGEGUILDFOUNTAIN(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�����л��Ȫ 20081007
    procedure ActionOfTAGMAPINFO(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//��·��ʯ 20081019
    procedure ActionOfTAGMAPMOVE(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�ƶ�����·��ʯ��¼�ĵ�ͼXY  20081019
    procedure ActionOfChangeCreditGlory(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeJob(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearNameList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobPlace(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo; nX, nY, nCount, nRange: Integer);
    procedure ActionOfSetMemberType(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetMemberLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGameGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);

    procedure ActionOfGameDiaMond(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo); //�������ʯ���� 20071226
    procedure ActionOfGameGird(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo); //�����������  20071226
    procedure ActionOfHeroLoyal(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo); //����Ӣ�۵��ҳ϶�  20080109
    procedure ActionOfCHANGEHEROTRANPOINT(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//����Ӣ�ۼ����������� 20080512
    procedure ActionOfCHANGEHUMABILITY(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//������������ 20080609
//-------------------------�ƹ����---------------------------------------------
    procedure ActionOfSAVEHERO(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//�ķ�Ӣ��
    procedure ActionOfGETHERO(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//ȡ��Ӣ��
    procedure ActionOfCLOSEDRINK(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//�رն��ƴ���
    procedure ActionOfPLAYDRINKMSG(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//���ƴ���˵����Ϣ 20080514
    procedure ActionOfOPENPLAYDRINK(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//ָ������Ⱦ� 20080514
//------------------------------------------------------------------------------
    procedure ActionOfGamePoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAutoAddGameGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
    procedure ActionOfAutoSubGameGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
    procedure ActionOfChangeHairStyle(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfLineMsg(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCreateFile(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//�����ı��ļ� 20081226
//------------------------------------------------------------------------------
//20080105 ���⹫��
    procedure ActionOfSendTopMsg(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//���˹�������
    procedure ActionOfSendCenterMsg(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//��Ļ������ʾ����
    procedure ActionOfSendEditTopMsg(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//����򶥶˹���
//------------------------------------------------------------------------------
    procedure ActionOfOPENMAKEWINE(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//����ƴ��� 20080619
    procedure ActionOfGETGOODMAKEWINE(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//ȡ����õľ� 20080620
    procedure ActionOfDECMAKEWINETIME(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//������Ƶ�ʱ�� 20080620
    procedure ActionOfREADSKILLNG(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//ѧϰ�ڹ�
    procedure ActionOfMAKEWINENPCMOVE(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//���NPC���߶� 20080621
    procedure ActionOfFOUNTAIN(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//����Ȫˮ�緢 20080624
    procedure ActionOfSETGUILDFOUNTAIN(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//����/�ر��л�Ȫˮ�ֿ�20080625
    procedure ActionOfGIVEGUILDFOUNTAIN(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//��ȡ�л��ˮ 20080625
//------------------------------------------------------------------------------
    procedure ActionOfCHALLENGMAPMOVE(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//��ս��ͼ�ƶ� 20080705
    procedure ActionOfGETCHALLENGEBAKITEM(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//û����ս��ͼ���ƶ�,���˻ص�Ѻ����Ʒ 20080705
//------------------------------------------------------------------------------
    procedure ActionOfHEROLOGOUT(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//����Ӣ������ 20080716
    procedure ActionOfGETSORTNAME(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//ȡָ�����а�ָ��������������� 20080531
    procedure ActionOfWEBBROWSER(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//����ָ����վ��ַ 20080602
    procedure ActionOfADDATTACKSABUKALL(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//���������лṥ�� 20080609
    procedure ActionOfKICKALLPLAY(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//�߳��������������� 20080609
    procedure ActionOfREPAIRALL(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//����ȫ��װ�� 20080613
    procedure ActionOfCHANGESKILL(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//�޸�ħ��ID 20080624
    procedure ActionOfAUTOGOTOXY(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//�Զ�Ѱ· 20080617
    procedure ActionOfOPENBOOKS(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//���� 20080119
    procedure ActionOfOPENYBDEAL(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//��ͨԪ������ 20080316
    procedure ActionOfQUERYYBSELL(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//��ѯ���ڳ��۵���Ʒ 20080317
    procedure ActionOfQUERYYBDEAL(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//��ѯ���ԵĹ�����Ʒ 20080317

    procedure ActionOfTHROUGHHUM(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//�ı䴩��ģʽ 20080221
    procedure ActionOfSetItemsLight(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//װ���������� 20080223
    procedure ActionOfOpenDragonBox(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//���������� 20080306
    procedure ActionOfQUERYREFINEITEM(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//�򿪴������� 20080502
    procedure ActionOfGOHOME(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//�ƶ����سǵ� 20080503
    procedure ActionOfTHROWITEM(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//��ָ����Ʒˢ�µ�ָ����ͼ���귶Χ�� 20080508
    procedure ActionOfCLEARCODELIST(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);//ɾ��ָ���ı���ı��� 20080410
    procedure ActionOfGetRandomName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//���ļ������ȡ�ı� 20080126
    procedure ActionOfHCall(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//ͨ���ű������ñ���ִ��QManage.txt�еĽű� 20080422
    procedure ActionOfINCASTLEWARAY(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//��������Ƿ��ڹ����ڼ�ķ�Χ�ڣ�����BB�ѱ� 20080422
    procedure ActionOfGIVESTATEITEM(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�������״̬װ�� 20080312
    procedure ActionOfSETITEMSTATE(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//����װ����״̬ 20080312
    procedure ActionOfChangeNameColor(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearPassword(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfReNewLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeGender(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKillSlave(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKillMonExpRate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPowerRate(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//���ù���������
    procedure ActionOfChangeMode(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�ı����ģʽ
    procedure ActionOfChangePerMission(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKick(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRestReNewLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelMarry(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearNeedItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearMakeItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpgradeItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUpgradeItemsEx(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMonGenEx(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearMapMon(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetMapMode(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfPkZone(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRestBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTakeCastleGold(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfHumanHP(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfHumanMP(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildBuildPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildAuraePoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildstabilityPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildFlourishPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfOpenMagicBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetRankLevelName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGmExecute(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGuildChiefItemCount(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAddNameDateList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDelNameDateList(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMobFireBurn(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfMessageBox(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSetScriptFlag(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfAutoGetExp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRecallmob(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//�ű��ٻ�����
    procedure ActionOfRECALLMOBEX(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//20080122 �ٻ�����
    procedure ActionOfMOVEMOBTO(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//20080123 ��ָ������Ĺ����ƶ���������
    procedure ActionOfCLEARITEMMAP(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//20080124 �����ͼ��Ʒ
    procedure ActionOfVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfLoadVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfSaveVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCalcVar(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfNotLineAddPiont(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfKickNotLineAddPiont(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfStartTakeGold(PlayObject: TPlayObject);
    procedure ActionOfAnsiReplaceText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfEncodeText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfUseBonusPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfRepairItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTakeOnItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfTakeOffItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfCreateHero(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfDeleteHero(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeHeroLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeHeroJob(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfClearHeroSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeHeroPKPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfChangeHeroExp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
    procedure ActionOfGIVEMINE(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//����ʯ 20080330

    function ConditionOfCheckGroupCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseDir(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseGender(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseMarry(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckLevelEx(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//�����ҵȼ�
    function ConditionOfCheckSlaveCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckBonusPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckAccountIPList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameIPList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMarry(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMarryCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfHaveMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfPoseHaveMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPoseIsMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHaveGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsGuildMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsCastleaGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsCastleMaster(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMemberType(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMemBerLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGameGold(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCHECKSTRINGLENGTH(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;//����ַ����ĳ��� 20090105
    //�����ʯ���� 20071227
    function ConditionOfCheckGameDiaMond(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //���������� 20071227
    function ConditionOfCheckGameGird(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //�������ֵ 20080511
    function ConditionOfCheckGameGLORY(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //��鼼�ܵȼ� 20080512
    function ConditionOfCHECKSKILLLEVEL(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //����ͼָ������ָ�����ƹ������� 20080123
    function ConditionOfCHECKMAPMOBCOUNT(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //���������Χ�Լ��������� 20080425
    function ConditionOfCHECKSIDESLAVENAME(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //��⵱ǰ�����Ƿ�С�ڴ��ڵ���ָ�������� 20080416
    function ConditionOfCHECKCURRENTDATE(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //���ʦ������ͽ�ܣ��Ƿ����� 20080416
    function ConditionOfCHECKMASTERONLINE(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //������һ���Ƿ����� 20080416
    function ConditionOfCHECKDEARONLINE(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //���ʦ������ͽ�ܣ��Ƿ���ָ����ͼ 20080416
    function ConditionOfCHECKMASTERONMAP(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //������һ���Ƿ���ָ����ͼ 20080416
    function ConditionOfCHECKDEARONMAP(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //�������Ƿ�Ϊ�Լ���ͽ�� 20080416
    function ConditionOfCHECKPOSEISPRENTICE(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //����Ƿ��ڹ����ڼ� 20080422
    function ConditionOfCHECKCASTLEWAR(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfFINDMAPPATH(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean; //���õ�ͼ������XYֵ 20080124
    //���Ӣ�۵��ҳ϶� 20080109
    function ConditionOfCHECKHEROLOYAL(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //�ж��Ƿ��������־� 20080620
    function ConditionOfISONMAKEWINE(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //�ж��Ƿ����л�Ȫˮ�ֿ� 20080625
    function ConditionOfCHECKGUILDFOUNTAIN(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCheckGamePoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameListPostion(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckReNewLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSlaveLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSlaveName(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCreditPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckOfGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPayMent(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckUseItem(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckBagSize(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckDC(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMC(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSC(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHP(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMP(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckItemType(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckExp(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleGold(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPasswordErrorCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfIsLockPassword(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfIsLockStorage(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildBuildPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckGuildAuraePoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckStabilityPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckFlourishPoint(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckContribution(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckRangeMonCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //����ͼ����  20080426
    function ConditionOfISONMAP(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    //�������������Ʒ�ĸ�������ֵ  20080426
    function ConditionOfCheckItemAddValue(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckInMapRange(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsAttackGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsDefenseGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleDoorStatus(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsAttackAllyGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckIsDefenseAllyGuild(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleChageDay(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckCastleWarDay(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckOnlineLongMin(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckChiefItemCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckNameDateList(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapHumanCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapMonCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckVar(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckServerName(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMapName(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSafeZone(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckSkill(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//������＼��
    function ConditionOfHEROCHECKSKILL(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//���Ӣ�ۼ��� 20080423
    function ConditionOfAnsiContainsText(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCompareText(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckMonMapCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckStationTime(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHasHero(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHeroOnline(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckHeroLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCHECKMINE(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//���󴿶� 20080324

    function ConditionOfCHECKOnlinePlayCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPlaylvl(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPlayJob(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCheckPlaySex(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;

    function ConditionOfCHECKITEMLEVEL(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//���װ���������� 20080816
    function ConditionOfCHECKMAKEWINE(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//���Ƶ�Ʒ�� 20080806
    function ConditionOfCHECKHEROPKPOINT(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//���Ӣ��PKֵ  20080304
    function ConditionOfCHECKPKPOINT(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//���PKֵ  20080506
    function ConditionOfCHECKCODELIST(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//����ı���ı���  20080410
    function ConditionOfCHECKITEMSTATE(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//���װ����״̬  20080312
    function ConditionOfCHECKITEMSNAME(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//���ָ��װ��λ���Ƿ����ָ������Ʒ 20080825
    function ConditionOfCHECKGUILDMEMBERCOUNT(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//����л��Ա���� 20090115
    function ConditionOfCHECKGUILDFOUNTAINValue(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//����л��Ȫ�� 20081017
    function ConditionOfCHECKNGLEVEL(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//����ɫ�ڹ��ȼ� 20081223
    function ConditionOfISHIGH(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//�����������������������  20080313
    function ConditionOfCheckHeroJob(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
    function ConditionOfCHANGREADNG(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;//����Ƿ�ѧ���ڹ� 20081002
    function GetDynamicVarList(PlayObject: TPlayObject; sType: string; var sName: string): TList;
    function GetValValue(PlayObject: TPlayObject; sMsg: string; var sValue: string): Boolean; overload;
    function GetValValue(PlayObject: TPlayObject; sMsg: string; var nValue: Integer): Boolean; overload;

    function SetValValue(PlayObject: TPlayObject; sMsg: string; sValue: string): Boolean; overload;
    function SetValValue(PlayObject: TPlayObject; sMsg: string; nValue: Integer): Boolean; overload;
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Initialize(); override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
    procedure Click(PlayObject: TPlayObject); virtual;
    procedure UserSelect(PlayObject: TPlayObject; sData: string); virtual;
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); virtual;
    function GetLineVariableText(PlayObject: TPlayObject; sMsg: string): string;
    procedure GotoLable(PlayObject: TPlayObject; sLabel: string; boExtJmp: Boolean);
    function sub_49ADB8(sMsg, sStr, sText: string): string;
    procedure LoadNpcScript();
    procedure ClearScript(); virtual;
    procedure SendMsgToUser(PlayObject: TPlayObject; sMsg: string);
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); virtual;
  end;
  TMerchant = class(TNormNpc)
    m_sScript: string;
    m_nPriceRate: Integer; //��Ʒ�۸��� Ĭ��Ϊ 100%
    m_boCastle: Boolean;//�Ƿ����ڳǱ�
    dwRefillGoodsTick: LongWord;
    dwClearExpreUpgradeTick: LongWord;
    m_ItemTypeList: TList; //NPC������Ʒ�����б��ű���ǰ��� +1 +30 ֮���
    m_RefillGoodsList: TList;
    m_GoodsList: TList;
    m_ItemPriceList: TList;//��Ʒ�۸��б�

    m_UpgradeWeaponList: TList;//���������б�
    m_boCanMove: Boolean;//�Ƿ�����ƶ�
    m_dwMoveTime: LongWord;//�ƶ�ʱ��
    m_dwMoveTick: LongWord;//�ƶ����
    m_boBuy: Boolean;//�Ƿ������
    m_boSell: Boolean;//NPC�Ƿ���� �������Ʒ
    m_boMakeDrug: Boolean;
    m_boPrices: Boolean;
    m_boStorage: Boolean;
    m_boGetback: Boolean;//���Բֿ�ȡ����Ʒ
    m_boBigStorage: Boolean;
    m_boBigGetBack: Boolean;

    m_boUserLevelOrder: Boolean;
    m_boWarrorLevelOrder: Boolean;
    m_boWizardLevelOrder: Boolean;
    m_boTaoistLevelOrder: Boolean;
    m_boMasterCountOrder: Boolean;

    m_boGetNextPage: Boolean;
    m_boGetPreviousPage: Boolean;
    m_boCqFirHero: Boolean;//NPC Ӣ�����NPC
    m_boBuHero: Boolean;//�ƹ�Ӣ�����NPC 20080514
    m_boPlayMakeWine: Boolean;//���NPC
    m_boPlayDrink: Boolean;//�����NPC���,���� 20080515
    m_boYBDeal: Boolean;//NPC Ԫ���������� 20080316

    m_boUpgradenow: Boolean;
    m_boGetBackupgnow: Boolean;
    m_boRepair: Boolean;
    m_boS_repair: Boolean;
    m_boSendmsg: Boolean;
    m_boGetMarry: Boolean;
    m_boGetMaster: Boolean;
    m_boUseItemName: Boolean;

    //m_boGetSellGold: Boolean;//20080416 ȥ����������
    //m_boSellOff: Boolean;//20080416 ȥ����������
    //m_boBuyOff: Boolean;//20080416 ȥ����������
    m_boofflinemsg: Boolean;
    m_boDealGold: Boolean;
  private
    procedure ClearExpreUpgradeListData();
    function GetRefillList(nIndex: Integer): TList;
    procedure AddItemPrice(nIndex, nPrice: Integer);
    function GetSellItemPrice(nPrice: Integer): Integer;
    function AddItemToGoodsList(UserItem: pTUserItem): Boolean;
    procedure GetBackupgWeapon(User: TPlayObject);
    procedure UpgradeWapon(User: TPlayObject);
    procedure ChangeUseItemName(PlayObject: TPlayObject; sLabel, sItemName: string);
    procedure SaveUpgradingList;
    //procedure GetMarry(PlayObject: TPlayObject; sDearName: string); //δʹ�� 20080411
    //procedure GetMaster(PlayObject: TPlayObject; sMasterName: string);//ȡ���� δʹ�� 20080411
  public
    constructor Create(); override;
    destructor Destroy; override;
    function GetItemPrice(nIndex: Integer): Integer;
    function GetUserPrice(PlayObject: TPlayObject; nPrice: Integer): Integer;
    function CheckItemType(nStdMode: Integer): Boolean;
    procedure CheckItemPrice(nIndex: Integer);
    function GetUserItemPrice(UserItem: pTUserItem): Integer;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    procedure LoadNPCData();
    procedure SaveNPCData();
    procedure LoadUpgradeList();
    procedure RefillGoods();
    procedure LoadNpcScript();
    procedure Click(PlayObject: TPlayObject); override;
    procedure ClearScript(); override;
    procedure ClearData();
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); override; //FFE9
    procedure ClientBuyItem(PlayObject: TPlayObject; sItemName: string; nInt: Integer);
    procedure ClientGetDetailGoodsList(PlayObject: TPlayObject; sItemName: string; nInt: Integer);
    procedure ClientQuerySellPrice(PlayObject: TPlayObject; UserItem: pTUserItem);
    function ClientSellItem(PlayObject: TPlayObject; UserItem: pTUserItem): Boolean;
    procedure ClientMakeDrugItem(PlayObject: TPlayObject; sItemName: string);
    procedure ClientQueryRepairCost(PlayObject: TPlayObject; UserItem: pTUserItem);
    function ClientRepairItem(PlayObject: TPlayObject; UserItem: pTUserItem): Boolean;
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;    
      //20080416 ȥ����������
    {procedure ClientGetDetailSellGoodsList(PlayObject: TPlayObject; sItemName: string; nInt: Integer); //004A26F0
    function ClientSellOffItem(PlayObject: TPlayObject; SellOffInfo: pTSellOffInfo; sName: string): Boolean; //004A1CD8
    procedure ClientBuySellOffItem(PlayObject: TPlayObject; sItemName: string; nInt: Integer); //004A2334 }
  end;
  TGuildOfficial = class(TNormNpc)
  private
    function ReQuestBuildGuild(PlayObject: TPlayObject; sGuildName: string): Integer;
    function ReQuestGuildWar(PlayObject: TPlayObject; sGuildName: string): Integer;
    procedure DoNate(PlayObject: TPlayObject);
    procedure ReQuestCastleWar(PlayObject: TPlayObject; sIndex: string);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); override; //FFE9
    procedure Run; override; //FFFB
    procedure Click(PlayObject: TPlayObject); override; //FFEB
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override; //FFEA
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;
  TTrainer = class(TNormNpc) //����ʦ
    m_dw568: LongWord;
    n56C: Integer;//����ʦ�ܹ���ʱͳ�����ƻ���
    n570: Integer;
  private
  public
    constructor Create(); override;
    destructor Destroy; override;
    function Operate(ProcessMsg: pTProcessMessage): Boolean; override;
    procedure Run; override;
  end;
  //  TCastleManager = class(TMerchant)
  TCastleOfficial = class(TMerchant)
  private
    procedure HireArcher(sIndex: string; PlayObject: TPlayObject);
    procedure HireGuard(sIndex: string; PlayObject: TPlayObject);
    procedure RepairDoor(PlayObject: TPlayObject);
    procedure RepairWallNow(nWallIndex: Integer; PlayObject: TPlayObject);
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Click(PlayObject: TPlayObject); override;
    procedure UserSelect(PlayObject: TPlayObject; sData: string); override;
    procedure GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string); override;
    procedure SendCustemMsg(PlayObject: TPlayObject; sMsg: string); override;
  end;
implementation

uses Castle, M2Share, HUtil32, LocalDB, Envir, Guild, EDcode, ObjMon2,
  Event, PlugIn, ObjPlayMon, ObjHero,PlugOfEngine,svMain;
 


procedure TCastleOfficial.Click(PlayObject: TPlayObject);
begin
  try
    if m_Castle = nil then begin
      PlayObject.SysMsg('NPC�����ڳǱ�������', c_Red, t_Hint);
      Exit;
    end;
    if TUserCastle(m_Castle).IsMasterGuild(TGUild(PlayObject.m_MyGuild)) or (PlayObject.m_btPermission >= 3) then
      inherited;
  except
    MainOutMessage('{�쳣} TCastleOfficial.Click');
  end;
end;

procedure TCastleOfficial.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string);
var
  sText: string;
  CastleDoor: TCastleDoor;
begin
try
  inherited;
  if m_Castle = nil then begin
    sMsg := '????';
    Exit;
  end;
  if sVariable = '$CASTLEGOLD' then begin
    sText := IntToStr(TUserCastle(m_Castle).m_nTotalGold);
    sMsg := sub_49ADB8(sMsg, '<$CASTLEGOLD>', sText);
  end else
    if sVariable = '$TODAYINCOME' then begin
    sText := IntToStr(TUserCastle(m_Castle).m_nTodayIncome);
    sMsg := sub_49ADB8(sMsg, '<$TODAYINCOME>', sText);
  end else
    if sVariable = '$CASTLEDOORSTATE' then begin
    CastleDoor := TCastleDoor(TUserCastle(m_Castle).m_MainDoor.BaseObject);
    if CastleDoor.m_boDeath then sText := '��'
    else if CastleDoor.m_boOpened then sText := '����'
    else sText := '�ر�';
    sMsg := sub_49ADB8(sMsg, '<$CASTLEDOORSTATE>', sText);
  end else
    if sVariable = '$REPAIRDOORGOLD' then begin
    sText := IntToStr(g_Config.nRepairDoorPrice);
    sMsg := sub_49ADB8(sMsg, '<$REPAIRDOORGOLD>', sText);
  end else
    if sVariable = '$REPAIRWALLGOLD' then begin
    sText := IntToStr(g_Config.nRepairWallPrice);
    sMsg := sub_49ADB8(sMsg, '<$REPAIRWALLGOLD>', sText);
  end else
    if sVariable = '$GUARDFEE' then begin
    sText := IntToStr(g_Config.nHireGuardPrice);
    sMsg := sub_49ADB8(sMsg, '<$GUARDFEE>', sText);
  end else
    if sVariable = '$ARCHERFEE' then begin
    sText := IntToStr(g_Config.nHireArcherPrice);
    sMsg := sub_49ADB8(sMsg, '<$ARCHERFEE>', sText);
  end else
    if sVariable = '$GUARDRULE' then begin
    sText := '��Ч';
    sMsg := sub_49ADB8(sMsg, '<$GUARDRULE>', sText);
  end;
except
  MainOutMessage('{�쳣} TCastleOfficial.GetVariableText');
end;
end;

procedure TCastleOfficial.UserSelect(PlayObject: TPlayObject; sData: string);
var
  s18, s20, sMsg, sLabel: string;
  boCanJmp: Boolean;
resourcestring
  sExceptionMsg = '{�쳣} TCastleManager::UserSelect... ';
begin
  inherited;
  try
    //    PlayObject.m_nScriptGotoCount:=0;
    if m_Castle = nil then begin
      PlayObject.SysMsg('NPC�����ڳǱ�������', c_Red, t_Hint);
      Exit;
    end;
    if (sData <> '') and (sData[1] = '@') then begin
      sMsg := GetValidStr3(sData, sLabel, [#13]);
      s18 := '';
      PlayObject.m_sScriptLable := sData;
      if TUserCastle(m_Castle).IsMasterGuild(TGUild(PlayObject.m_MyGuild)) {and (PlayObject.IsGuildMaster)} then begin//20080803 �޸�
        boCanJmp := PlayObject.LableIsCanJmp(sLabel);
        if CompareText(sLabel, sSL_SENDMSG) = 0 then begin
          if sMsg = '' then Exit;
        end;
        GotoLable(PlayObject, sLabel, not boCanJmp);
        //GotoLable(PlayObject,sLabel,not PlayObject.LableIsCanJmp(sLabel));
        if not boCanJmp then Exit;
        if CompareText(sLabel, sSL_SENDMSG) = 0 then begin
          SendCustemMsg(PlayObject, sMsg);
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
        end else
          if CompareText(sLabel, sCASTLENAME) = 0 then begin
            if PlayObject.IsGuildMaster then begin//20080803 ����
              sMsg := Trim(sMsg);
              if sMsg <> '' then begin
                TUserCastle(m_Castle).m_sName := sMsg;
                TUserCastle(m_Castle).Save;
                TUserCastle(m_Castle).m_MasterGuild.RefMemberName;
                s18 := '�Ǳ����Ƹ��ĳɹ�...';
              end else begin
                s18 := '�Ǳ����Ƹ���ʧ�ܣ�����';
              end;
              PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
            end;
        end else
          if CompareText(sLabel, sWITHDRAWAL) = 0 then begin//ȡ�ؽ��
          case TUserCastle(m_Castle).WithDrawalGolds(PlayObject, Str_ToInt(sMsg, 0)) of
            -4: s18 := '����Ľ��������ȷ������';
            -3: s18 := '���޷�Я������Ķ����ˡ�';
            -2: s18 := '�ó���û����ô����.';
            -1: s18 := 'ֻ���л� ' + TUserCastle(m_Castle).m_sOwnGuild + ' �������˲���ʹ�ã�����';
            1: GotoLable(PlayObject, sMAIN, False);
          end;
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
        end else
          if CompareText(sLabel, sRECEIPTS) = 0 then begin//ɳ�Ϳ˴��ʽ�
          case TUserCastle(m_Castle).ReceiptGolds(PlayObject, Str_ToInt(sMsg, 0)) of
            -4: s18 := '����Ľ��������ȷ������';
            -3: s18 := '���Ѿ��ﵽ�ڳ��ڴ�Ż���������ˡ�';
            -2: s18 := '��û����ô����.';
            -1: s18 := 'ֻ���л� ' + TUserCastle(m_Castle).m_sOwnGuild + ' �������˲���ʹ�ã�����';
            1: GotoLable(PlayObject, sMAIN, False);
          end;
          PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
        end else
          if CompareText(sLabel, sOPENMAINDOOR) = 0 then begin//�򿪳���
          if PlayObject.IsGuildMaster then TUserCastle(m_Castle).MainDoorControl(False);//20080803 ����
        end else
          if CompareText(sLabel, sCLOSEMAINDOOR) = 0 then begin//�رճ���
          if PlayObject.IsGuildMaster then TUserCastle(m_Castle).MainDoorControl(True);//20080803 ����
        end else
          if CompareText(sLabel, sREPAIRDOORNOW) = 0 then begin//�����޸�����
            if PlayObject.IsGuildMaster then begin//20080803 ����
              RepairDoor(PlayObject);
              GotoLable(PlayObject, sMAIN, False);
            end;
        end else
          if CompareText(sLabel, sREPAIRWALLNOW1) = 0 then begin//�޳�ǽһ
            if PlayObject.IsGuildMaster then begin//20080803 ����
              RepairWallNow(1, PlayObject);
              GotoLable(PlayObject, sMAIN, False);
            end;
        end else
          if CompareText(sLabel, sREPAIRWALLNOW2) = 0 then begin//�޳�ǽ��
            if PlayObject.IsGuildMaster then begin//20080803 ����
              RepairWallNow(2, PlayObject);
              GotoLable(PlayObject, sMAIN, False);
            end;
        end else
          if CompareText(sLabel, sREPAIRWALLNOW3) = 0 then begin//�޳�ǽ��
            if PlayObject.IsGuildMaster then begin//20080803 ����
              RepairWallNow(3, PlayObject);
              GotoLable(PlayObject, sMAIN, False);
            end;
        end else
          if CompareLStr(sLabel, sHIREGUARDNOW, 13{Length(sHIREGUARDNOW)}) then begin
            if PlayObject.IsGuildMaster then begin//20080803 ����
              s20 := Copy(sLabel, Length(sHIREGUARDNOW) + 1, Length(sLabel));
              HireGuard(s20, PlayObject);
              PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, '');
              //GotoLable(PlayObject,sHIREGUARDOK,False);
            end;
        end else
          if CompareLStr(sLabel, sHIREARCHERNOW, 14{Length(sHIREARCHERNOW)}) then begin
            if PlayObject.IsGuildMaster then begin//20080803 ����
              s20 := Copy(sLabel, Length(sHIREARCHERNOW) + 1, Length(sLabel));
              HireArcher(s20, PlayObject);
              PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, '');
            end;
        end else
          if CompareText(sLabel, sEXIT) = 0 then begin
          PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
        end else
          if CompareText(sLabel, sBACK) = 0 then begin
          if PlayObject.m_sScriptGoBackLable = '' then PlayObject.m_sScriptGoBackLable := sMAIN;
          GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
        end;
      end else begin
        s18 := '��û��Ȩ��ʹ��';
        PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(Self), 0, 0, s18);
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
  //  inherited;
end;

procedure TCastleOfficial.HireGuard(sIndex: string; PlayObject: TPlayObject);
var
  n10: Integer;
  ObjUnit: pTObjUnit;
begin
try
  if m_Castle = nil then begin
    PlayObject.SysMsg('NPC�����ڳǱ�������', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nHireGuardPrice then begin
    n10 := Str_ToInt(sIndex, 0) - 1;
    if n10 <= MAXCALSTEGUARD then begin
      if TUserCastle(m_Castle).m_Guard[n10].BaseObject = nil then begin
        if not TUserCastle(m_Castle).m_boUnderWar then begin
          ObjUnit := @TUserCastle(m_Castle).m_Guard[n10];
          ObjUnit.BaseObject := UserEngine.RegenMonsterByName(TUserCastle(m_Castle).m_sMapName,
            ObjUnit.nX,
            ObjUnit.nY,
            ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nHireGuardPrice);
            ObjUnit.BaseObject.m_Castle := TUserCastle(m_Castle);
            TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
            PlayObject.SysMsg('��Ӷ�ɹ�.', c_Green, t_Hint);
          end;
        end else begin
          PlayObject.SysMsg('�����޷���Ӷ������', c_Red, t_Hint);
        end;
      end else begin
         PlayObject.SysMsg('���ѹ�Ӷ������', c_Red, t_Hint);//20080803 ����
      end;
    end else begin
      PlayObject.SysMsg('ָ����󣡣���', c_Red, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('�����ʽ��㣡����', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nHireGuardPrice then begin
    n10:=Str_ToInt(sIndex,0) - 1;
    if n10 <= MAXCALSTEGUARD then begin
      if UserCastle.m_Guard[n10].BaseObject = nil then begin
        if not UserCastle.m_boUnderWar then begin
          ObjUnit:=@UserCastle.m_Guard[n10];
          ObjUnit.BaseObject:=UserEngine.RegenMonsterByName(UserCastle.m_sMapName,
                                                          ObjUnit.nX,
                                                          ObjUnit.nY,
                                                          ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(UserCastle.m_nTotalGold,g_Config.nHireGuardPrice);
            ObjUnit.BaseObject.m_Castle:=UserCastle;
            TGuardUnit(ObjUnit.BaseObject).m_nX550:=ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554:=ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_n558:=3;
            PlayObject.SysMsg('��Ӷ�ɹ�.',c_Green,t_Hint);
          end;

        end else begin
          PlayObject.SysMsg('�����޷���Ӷ������',c_Red,t_Hint);
        end;
      end
    end else begin
      PlayObject.SysMsg('ָ����󣡣���',c_Red,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('�����ʽ��㣡����',c_Red,t_Hint);
  end;
  }
except
  MainOutMessage('{�쳣} TCastleOfficial.HireGuard');
end;
end;

procedure TCastleOfficial.HireArcher(sIndex: string; PlayObject: TPlayObject);
var
  n10: Integer;
  ObjUnit: pTObjUnit;
begin
try
  if m_Castle = nil then begin
    PlayObject.SysMsg('NPC�����ڳǱ�������', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nHireArcherPrice then begin
    n10 := Str_ToInt(sIndex, 0) - 1;
    if n10 <= MAXCASTLEARCHER then begin
      if TUserCastle(m_Castle).m_Archer[n10].BaseObject = nil then begin
        if not TUserCastle(m_Castle).m_boUnderWar then begin
          ObjUnit := @TUserCastle(m_Castle).m_Archer[n10];
          ObjUnit.BaseObject := UserEngine.RegenMonsterByName(TUserCastle(m_Castle).m_sMapName,
            ObjUnit.nX,
            ObjUnit.nY,
            ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nHireArcherPrice);
            ObjUnit.BaseObject.m_Castle := TUserCastle(m_Castle);
            TGuardUnit(ObjUnit.BaseObject).m_nX550 := ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554 := ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_nDirection := 3;
            PlayObject.SysMsg('��Ӷ�ɹ�.', c_Green, t_Hint);
          end;
        end else begin
          PlayObject.SysMsg('�����޷���Ӷ������', c_Red, t_Hint);
        end;
      end else begin
        PlayObject.SysMsg('���ѹ�Ӷ������', c_Red, t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('ָ����󣡣���', c_Red, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('�����ʽ��㣡����', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nHireArcherPrice then begin
    n10:=Str_ToInt(sIndex,0) - 1;
    if n10 <= MAXCASTLEARCHER then begin
      if UserCastle.m_Archer[n10].BaseObject = nil then begin
        if not UserCastle.m_boUnderWar then begin
          ObjUnit:=@UserCastle.m_Archer[n10];
          ObjUnit.BaseObject:=UserEngine.RegenMonsterByName(UserCastle.m_sMapName,
                                                          ObjUnit.nX,
                                                          ObjUnit.nY,
                                                          ObjUnit.sName);
          if ObjUnit.BaseObject <> nil then begin
            Dec(UserCastle.m_nTotalGold,g_Config.nHireArcherPrice);
            ObjUnit.BaseObject.m_Castle:=UserCastle;
            TGuardUnit(ObjUnit.BaseObject).m_nX550:=ObjUnit.nX;
            TGuardUnit(ObjUnit.BaseObject).m_nY554:=ObjUnit.nY;
            TGuardUnit(ObjUnit.BaseObject).m_n558:=3;
            PlayObject.SysMsg('��Ӷ�ɹ�.',c_Green,t_Hint);
          end;

        end else begin
          PlayObject.SysMsg('�����޷���Ӷ������',c_Red,t_Hint);
        end;
      end else begin
        PlayObject.SysMsg('���ѹ�Ӷ������',c_Red,t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('ָ����󣡣���',c_Red,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('�����ʽ��㣡����',c_Red,t_Hint);
  end;
  }
except
  MainOutMessage('{�쳣} TCastleOfficial.HireArcher');
end;
end;
{ TMerchant }
//������Ʒ�۸�
procedure TMerchant.AddItemPrice(nIndex: Integer; nPrice: Integer);
var
  ItemPrice: pTItemPrice;
begin
try
  New(ItemPrice);
  ItemPrice.wIndex := nIndex;
  ItemPrice.nPrice := nPrice;
  m_ItemPriceList.Add(ItemPrice);
  FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
except
  MainOutMessage('{�쳣} TMerchant.AddItemPrice');
end;
end;
//�����Ʒ�۸�
procedure TMerchant.CheckItemPrice(nIndex: Integer);
var
  I: Integer;
  ItemPrice: pTItemPrice;
  n10: Integer;
  StdItem: pTStdItem;
begin
try
  if m_ItemPriceList.Count > 0 then begin//20080629
    for I := 0 to m_ItemPriceList.Count - 1 do begin
      ItemPrice := m_ItemPriceList.Items[I];
      if ItemPrice = nil then Continue;
      if ItemPrice.wIndex = nIndex then begin
        n10 := ItemPrice.nPrice;
        if Round(n10 * 1.1) > n10 then begin
          n10 := Round(n10 * 1.1);
        end else Inc(n10);
        Exit;
      end;
    end;
  end;
  StdItem := UserEngine.GetStdItem(nIndex);
  if StdItem <> nil then begin
    AddItemPrice(nIndex, Round(StdItem.Price * 1.1));//��Ʒ�۸�ΪDB���1.1��
  end;
except
  MainOutMessage('{�쳣} TMerchant.CheckItemPrice');
end;
end;

function TMerchant.GetRefillList(nIndex: Integer): TList;
var
  I: Integer;
  List: TList;
begin
  Result := nil;
  try  
    if nIndex <= 0 then Exit;
    if m_GoodsList.Count > 0 then begin//20080629
      for I := 0 to m_GoodsList.Count - 1 do begin
        List := TList(m_GoodsList.Items[I]);
        if List = nil then Continue;
        if List.Count > 0 then begin
          if pTUserItem(List.Items[0]).wIndex = nIndex then begin
            Result := List;
            Break;
          end;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TMerchant.GetRefillList');
  end;
end;
//ˢ��NPC������Ʒ�б�
procedure TMerchant.RefillGoods;
  procedure RefillItems(var List: TList; sItemName: string; nInt: Integer);
  var
    I: Integer;
    UserItem: pTUserItem;
  begin
    if List = nil then begin
      List := TList.Create;
      m_GoodsList.Add(List);
    end;
    if nInt <= 0 then nInt:= 1;//20081008
    for I := 0 to nInt - 1 do begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
        List.Insert(0, UserItem);
      end else Dispose(UserItem);
    end;
  end;
  procedure DelReFillItem(var List: TList; nInt: Integer);
  var
    I: Integer;
  begin
    for I := List.Count - 1 downto 0 do begin
      if nInt <= 0 then Break;
      if List.Count <= 0 then Break;//20081008
      if pTUserItem(List.Items[I]) <> nil then begin
        Dispose(pTUserItem(List.Items[I]));
      end;
      List.Delete(I);
      Dec(nInt);
    end;
  end;
var
  I, II: Integer;
  Goods: pTGoods;
  nIndex, nRefillCount: Integer;
  RefillList, RefillList20: TList;
  bo21: Boolean;
  nCode: Byte;//20090129
resourcestring
  sExceptionMsg = '{�쳣} TMerchant::RefillGoods %s/%d:%d [%s] Code:%d';
begin
  nCode:= 0;
  try
    if m_RefillGoodsList.Count > 0 then begin//20081008
      for I := 0 to m_RefillGoodsList.Count - 1 do begin
        nCode:= 1;
        Goods := m_RefillGoodsList.Items[I];
        if Goods = nil then Continue;
        if (GetTickCount - Goods.dwRefillTick) > Goods.dwRefillTime * 60000{60 * 1000} then begin
          nCode:= 2;
          Goods.dwRefillTick := GetTickCount();
          nIndex := UserEngine.GetStdItemIdx(Goods.sItemName);
          nCode:= 3;
          if nIndex >= 0 then begin
            nCode:= 4;
            RefillList := GetRefillList(nIndex);
            nRefillCount := 0;
            if RefillList <> nil then nRefillCount := RefillList.Count;
            if Goods.nCount > nRefillCount then begin
              nCode:= 5;
              CheckItemPrice(nIndex);
              nCode:= 6;
              RefillItems(RefillList, Goods.sItemName, Goods.nCount - nRefillCount);
              nCode:= 7;
              FrmDB.SaveGoodRecord(Self, m_sScript + '-' + m_sMapName);
              nCode:= 8;
              FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
            end;
            nCode:= 9;
            if Goods.nCount < nRefillCount then begin
              nCode:= 10;
              DelReFillItem(RefillList, nRefillCount - Goods.nCount);
              nCode:= 11;
              FrmDB.SaveGoodRecord(Self, m_sScript + '-' + m_sMapName);
              nCode:= 12;
              FrmDB.SaveGoodPriceRecord(Self, m_sScript + '-' + m_sMapName);
            end;
          end;
        end;
      end;//for
    end;
    nCode:= 13;
    if m_GoodsList.Count > 0 then begin//20081008
      for I := 0 to m_GoodsList.Count - 1 do begin
        nCode:= 14;
        RefillList20 := TList(m_GoodsList.Items[I]);
        if RefillList20 = nil then Continue;
        nCode:= 15;
        if RefillList20.Count > 1000 then begin
          bo21 := False;
          if m_RefillGoodsList.Count > 0 then begin//20081008
            nCode:= 16;
            for II := 0 to m_RefillGoodsList.Count - 1 do begin
              nCode:= 17;
              Goods := m_RefillGoodsList.Items[II];
              if Goods = nil then Continue;
              nCode:= 18;
              nIndex := UserEngine.GetStdItemIdx(Goods.sItemName);
              nCode:= 19;
              if (pTItemPrice(RefillList20.Items[0]) <> nil) then begin//20090129 �޸�
                nCode:= 20;
                if (pTItemPrice(RefillList20.Items[0]).wIndex = nIndex) then begin
                  bo21 := True;
                  Break;
                end;
              end;
            end;
          end;
          if not bo21 then begin
            nCode:= 21;
            DelReFillItem(RefillList20, RefillList20.Count - 1000);
          end else begin
            nCode:= 22;
            DelReFillItem(RefillList20, RefillList20.Count - 5000);
          end;
        end;
      end;//for
    end;
  except
    on E: Exception do
      MainOutMessage(Format(sExceptionMsg, [m_sCharName, m_nCurrX, m_nCurrY, E.Message, nCode]));
  end;
end;
//�����Ʒ����
function TMerchant.CheckItemType(nStdMode: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  try
    if m_ItemTypeList.Count > 0 then begin//20080629
      for I := 0 to m_ItemTypeList.Count - 1 do begin
        if Integer(m_ItemTypeList.Items[I]) = nStdMode then begin
          Result := True;
          Break;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TMerchant.CheckItemType');
  end;
end;
//ȡ��Ʒ�۸�
function TMerchant.GetItemPrice(nIndex: Integer): Integer;
var
  I: Integer;
  ItemPrice: pTItemPrice;
  StdItem: pTStdItem;
begin
  Result := -1;
  try
    if m_ItemPriceList.Count > 0 then begin//20080629
      for I := 0 to m_ItemPriceList.Count - 1 do begin
        ItemPrice := m_ItemPriceList.Items[I];
        if ItemPrice = nil then Continue;
        if ItemPrice.wIndex = nIndex then begin
          Result := ItemPrice.nPrice;
          Break;
        end;
      end; // for
    end;
    if Result < 0 then begin
      StdItem := UserEngine.GetStdItem(nIndex);
      if StdItem <> nil then begin
        if CheckItemType(StdItem.StdMode) then Result := StdItem.Price;
      end;
    end;
  except
    MainOutMessage('{�쳣} TMerchant.GetItemPrice');
  end;
end;
//�������������б�
procedure TMerchant.SaveUpgradingList();
begin
  try
    FrmDB.SaveUpgradeWeaponRecord(m_sScript + '-' + m_sMapName, m_UpgradeWeaponList);
  except
    MainOutMessage('���������б�ʧ�� - ' + m_sCharName);
  end;
end;
//��������
procedure TMerchant.UpgradeWapon(User: TPlayObject);
  procedure sub_4A0218(ItemList: TList; var btDc: Byte; var btSc: Byte; var btMc: Byte; var btDura: Byte);
  var
    I, II: Integer;
    DuraList: TList;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    StdItem80: TStdItem;
    DelItemList: TStringList;
    nDc, nSc, nMc, nDcMin, nDcMax, nScMin, nScMax, nMcMin, nMcMax, nDura, nItemCount: Integer;
  begin
    nDcMin := 0;
    nDcMax := 0;
    nScMin := 0;
    nScMax := 0;
    nMcMin := 0;
    nMcMax := 0;
    nDura := 0;
    nItemCount := 0;
    DelItemList := nil;
    DuraList := TList.Create;
    if ItemList.Count > 0 then begin//20080627
      for I := ItemList.Count - 1 downto 0 do begin
        UserItem := ItemList.Items[I];
        if UserEngine.GetStdItemName(UserItem.wIndex) = g_Config.sBlackStone then begin
          DuraList.Add(Pointer(Round(UserItem.Dura / 1.0E3)));
          if DelItemList = nil then DelItemList := TStringList.Create;
          DelItemList.AddObject(g_Config.sBlackStone, TObject(UserItem.MakeIndex));
          Dispose(UserItem);
          ItemList.Delete(I);
        end else begin
          if IsUseItem(UserItem.wIndex) then begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem <> nil then begin
              StdItem80 := StdItem^;
              ItemUnit.GetItemAddValue(UserItem, StdItem80);
              nDc := 0;
              nSc := 0;
              nMc := 0;
              case StdItem80.StdMode of
                19, 20, 21: begin
                    nDc := HiWord(StdItem80.DC) + LoWord(StdItem80.DC);
                    nSc := HiWord(StdItem80.SC) + LoWord(StdItem80.SC);
                    nMc := HiWord(StdItem80.MC) + LoWord(StdItem80.MC);
                  end;
                22, 23: begin
                    nDc := HiWord(StdItem80.DC) + LoWord(StdItem80.DC);
                    nSc := HiWord(StdItem80.SC) + LoWord(StdItem80.SC);
                    nMc := HiWord(StdItem80.MC) + LoWord(StdItem80.MC);
                  end;
                24, 26: begin
                    nDc := HiWord(StdItem80.DC) + LoWord(StdItem80.DC) + 1;
                    nSc := HiWord(StdItem80.SC) + LoWord(StdItem80.SC) + 1;
                    nMc := HiWord(StdItem80.MC) + LoWord(StdItem80.MC) + 1;
                  end;
              end;
              if nDcMin < nDc then begin
                nDcMax := nDcMin;
                nDcMin := nDc;
              end else begin
                if nDcMax < nDc then nDcMax := nDc;
              end;
              if nScMin < nSc then begin
                nScMax := nScMin;
                nScMin := nSc;
              end else begin
                if nScMax < nSc then nScMax := nSc;
              end;
              if nMcMin < nMc then begin
                nMcMax := nMcMin;
                nMcMin := nMc;
              end else begin
                if nMcMax < nMc then nMcMax := nMc;
              end;
              if DelItemList = nil then DelItemList := TStringList.Create;
              DelItemList.AddObject(StdItem.Name, TObject(UserItem.MakeIndex));
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('26' + #9 + User.m_sMapName + #9 +
                  IntToStr(User.m_nCurrX) + #9 + IntToStr(User.m_nCurrY) + #9 +
                  User.m_sCharName + #9 +StdItem.Name + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                  '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                  '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                  '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                  '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                  IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                  IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                  IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                  IntToStr(UserItem.btValue[14])+ #9 + m_sCharName);
              Dispose(UserItem);
              ItemList.Delete(I);
            end;
          end;
        end;
      end; // for
    end;
    for I := 0 to DuraList.Count - 1 do begin
      if DuraList.Count <= 0 then Break;
      for II := DuraList.Count - 1 downto I + 1 do begin
        if Integer(DuraList.Items[II]) > Integer(DuraList.Items[II - 1]) then
          DuraList.Exchange(II, II - 1);
      end; // for
    end; // for
    if DuraList.Count > 0 then begin//20080627
      for I := 0 to DuraList.Count - 1 do begin
        nDura := nDura + Integer(DuraList.Items[I]);
        Inc(nItemCount);
        if nItemCount >= 5 then Break;
      end;
    end;
    btDura := Round(_MIN(5, nItemCount) + _MIN(5, nItemCount) * ((nDura / nItemCount) / 5.0));
    btDc := nDcMin div 5 + nDcMax div 3;
    btSc := nScMin div 5 + nScMax div 3;
    btMc := nMcMin div 5 + nMcMax div 3;
    if DelItemList <> nil then
      User.SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(DelItemList), 0, 0, '');
    if DuraList <> nil then DuraList.Free;
  end;
var
  I: Integer;
  bo0D: Boolean;
  UpgradeInfo: pTUpgradeInfo;
  StdItem: pTStdItem;
begin
try
  bo0D := False;
  if m_UpgradeWeaponList.Count > 0 then begin//20080629
    for I := 0 to m_UpgradeWeaponList.Count - 1 do begin
      UpgradeInfo := m_UpgradeWeaponList.Items[I];
      if UpgradeInfo.sUserName = User.m_sCharName then begin
        GotoLable(User, sUPGRADEING, False);
        Exit;
      end;
    end;
  end;
  if (User.m_UseItems[U_WEAPON].wIndex <> 0) and (User.m_nGold >= g_Config.nUpgradeWeaponPrice) and
    (User.CheckItems(g_Config.sBlackStone) <> nil) then begin
    User.DecGold(g_Config.nUpgradeWeaponPrice);
    //    if m_boCastle or g_Config.boGetAllNpcTax then UserCastle.IncRateGold(g_Config.nUpgradeWeaponPrice);
    if m_boCastle or g_Config.boGetAllNpcTax then begin
      if m_Castle <> nil then begin
        TUserCastle(m_Castle).IncRateGold(g_Config.nUpgradeWeaponPrice);
      end else
        if g_Config.boGetAllNpcTax then begin
        g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
      end;
    end;
    User.GoldChanged();
    New(UpgradeInfo);
    FillChar(UpgradeInfo^, SizeOf(TUpgradeInfo), #0);//20080724 ����
    UpgradeInfo.sUserName := User.m_sCharName;
    UpgradeInfo.UserItem := User.m_UseItems[U_WEAPON];
    StdItem := UserEngine.GetStdItem(User.m_UseItems[U_WEAPON].wIndex);

    if StdItem.NeedIdentify = 1 then
      AddGameDataLog('25' + #9 +
        User.m_sMapName + #9 +
        IntToStr(User.m_nCurrX) + #9 + IntToStr(User.m_nCurrY) + #9 +
        User.m_sCharName + #9 + StdItem.Name + #9 +
        IntToStr(User.m_UseItems[U_WEAPON].MakeIndex) + #9 +
        '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
        '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
        '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
        '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
        '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
        IntToStr(User.m_UseItems[U_WEAPON].btValue[0])+'/'+IntToStr(User.m_UseItems[U_WEAPON].btValue[1])+'/'+IntToStr(User.m_UseItems[U_WEAPON].btValue[2])+'/'+
        IntToStr(User.m_UseItems[U_WEAPON].btValue[3])+'/'+IntToStr(User.m_UseItems[U_WEAPON].btValue[4])+'/'+IntToStr(User.m_UseItems[U_WEAPON].btValue[5])+'/'+
        IntToStr(User.m_UseItems[U_WEAPON].btValue[6])+'/'+IntToStr(User.m_UseItems[U_WEAPON].btValue[7])+'/'+IntToStr(User.m_UseItems[U_WEAPON].btValue[8])+'/'+
        IntToStr(User.m_UseItems[U_WEAPON].btValue[14])+ #9 + IntToStr(User.m_UseItems[U_WEAPON].Dura)+'/'+IntToStr(User.m_UseItems[U_WEAPON].DuraMax));
    User.ClearCopyItem(0, User.m_UseItems[U_WEAPON].wIndex, User.m_UseItems[U_WEAPON].MakeIndex);//��������Ͳֿ⸴����Ʒ 20080816
    User.SendDelItems(@User.m_UseItems[U_WEAPON]);
    User.m_UseItems[U_WEAPON].wIndex := 0;
    User.RecalcAbilitys();
    User.CompareSuitItem(False);//200080729 ��װ
    User.FeatureChanged();
    User.SendMsg(User, RM_ABILITY, 0, 0, 0, 0, '');
    sub_4A0218(User.m_ItemList, UpgradeInfo.btDc, UpgradeInfo.btSc, UpgradeInfo.btMc, UpgradeInfo.btDura);
    UpgradeInfo.dtTime := Now();
    UpgradeInfo.dwGetBackTick := GetTickCount();
    m_UpgradeWeaponList.Add(UpgradeInfo);
    SaveUpgradingList();//�������������б�
    bo0D := True;
  end;
  if bo0D then GotoLable(User, sUPGRADEOK, False)
  else GotoLable(User, sUPGRADEFAIL, False);
except
  MainOutMessage('{�쳣} TMerchant.UpgradeWapon');
end;
end;
//��������,ȡ������
procedure TMerchant.GetBackupgWeapon(User: TPlayObject);
var
  I: Integer;
  UpgradeInfo: pTUpgradeInfo;
  n10, n18, n1C, n90: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
  try
    n18 := 0;
    UpgradeInfo := nil;
    if not User.IsEnoughBag then begin//�����Ѿ���
      GotoLable(User, sGETBACKUPGFULL, False);
      Exit;
    end;
    for I := m_UpgradeWeaponList.Count - 1 downto 0 do begin
      if m_UpgradeWeaponList.Count <= 0 then Break;
      if pTUpgradeInfo(m_UpgradeWeaponList.Items[I]).sUserName = User.m_sCharName then begin
        n18 := 1;
        if ((GetTickCount - pTUpgradeInfo(m_UpgradeWeaponList.Items[I]).dwGetBackTick) > g_Config.dwUPgradeWeaponGetBackTime) or (User.m_btPermission >= 4) then begin
          UpgradeInfo := m_UpgradeWeaponList.Items[I];
          m_UpgradeWeaponList.Delete(I);
          SaveUpgradingList();//�������������б�
          n18 := 2;
          Break;
        end;
      end;
    end;//for

    if (UpgradeInfo <> nil) and (n18 = 2) then begin//20080915 �޸�
      case UpgradeInfo.btDura of //
        0..8: begin 
            //n14:=_MAX(3000,UpgradeInfo.UserItem.DuraMax shr 1);
            if UpgradeInfo.UserItem.DuraMax > 3000 then begin
              Dec(UpgradeInfo.UserItem.DuraMax, 3000);
            end else begin
              UpgradeInfo.UserItem.DuraMax := UpgradeInfo.UserItem.DuraMax shr 1;
            end;
            if UpgradeInfo.UserItem.Dura > UpgradeInfo.UserItem.DuraMax then
              UpgradeInfo.UserItem.Dura := UpgradeInfo.UserItem.DuraMax;
          end;
        9..15: begin 
            if Random(UpgradeInfo.btDura) < 6 then begin
              if UpgradeInfo.UserItem.DuraMax > 1000 then
                Dec(UpgradeInfo.UserItem.DuraMax, 1000);
              if UpgradeInfo.UserItem.Dura > UpgradeInfo.UserItem.DuraMax then
                UpgradeInfo.UserItem.Dura := UpgradeInfo.UserItem.DuraMax;
            end;
          end;
        18..255: begin
            case Random(UpgradeInfo.btDura - 18) of
              1..4: Inc(UpgradeInfo.UserItem.DuraMax, 1000);
              5..7: Inc(UpgradeInfo.UserItem.DuraMax, 2000);
              8..255: Inc(UpgradeInfo.UserItem.DuraMax, 4000)
            end;
          end;
      end; // case
      if (UpgradeInfo.btDc = UpgradeInfo.btMc) and (UpgradeInfo.btMc = UpgradeInfo.btSc) then begin
        n1C := Random(3);
      end else begin
        n1C := -1;
      end;
      if ((UpgradeInfo.btDc >= UpgradeInfo.btMc) and (UpgradeInfo.btDc >= UpgradeInfo.btSc)) or
        (n1C = 0) then begin
        n90 := _MIN(11, UpgradeInfo.btDc);
        n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);
        //      n10:=_MIN(85,n90 * 8 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

        if Random(g_Config.nUpgradeWeaponDCRate) < n10 then begin //if Random(100) < n10 then begin
          UpgradeInfo.UserItem.btValue[10] := 10;

          if (n10 > 63) and (Random(g_Config.nUpgradeWeaponDCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 11;

          if (n10 > 79) and (Random(g_Config.nUpgradeWeaponDCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 12;
        end else UpgradeInfo.UserItem.btValue[10] := 1; 
      end;
      if ((UpgradeInfo.btMc >= UpgradeInfo.btDc) and (UpgradeInfo.btMc >= UpgradeInfo.btSc)) or (n1C = 1) then begin
        n90 := _MIN(11, UpgradeInfo.btMc);
        n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

        if Random(g_Config.nUpgradeWeaponMCRate) < n10 then begin //if Random(100) < n10 then begin
          UpgradeInfo.UserItem.btValue[10] := 20;

          if (n10 > 63) and (Random(g_Config.nUpgradeWeaponMCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 21;

          if (n10 > 79) and (Random(g_Config.nUpgradeWeaponMCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 22;
        end else UpgradeInfo.UserItem.btValue[10] := 1;
      end;
      if ((UpgradeInfo.btSc >= UpgradeInfo.btMc) and (UpgradeInfo.btSc >= UpgradeInfo.btDc)) or (n1C = 2) then begin
        n90 := _MIN(11, UpgradeInfo.btMc);
        n10 := _MIN(85, n90 shl 3 - n90 + 10 + UpgradeInfo.UserItem.btValue[3] - UpgradeInfo.UserItem.btValue[4] + User.m_nBodyLuckLevel);

        if Random(g_Config.nUpgradeWeaponSCRate) < n10 then begin //if Random(100) < n10 then begin
          UpgradeInfo.UserItem.btValue[10] := 30;

          if (n10 > 63) and (Random(g_Config.nUpgradeWeaponSCTwoPointRate) = 0) then //if (n10 > 63) and (Random(30) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 31;

          if (n10 > 79) and (Random(g_Config.nUpgradeWeaponSCThreePointRate) = 0) then //if (n10 > 79) and (Random(200) = 0) then
            UpgradeInfo.UserItem.btValue[10] := 32;
        end else UpgradeInfo.UserItem.btValue[10] := 1;
      end;
      New(UserItem);
      FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 ����
      //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 ����
      UserItem^ := UpgradeInfo.UserItem;
      UserItem.btValue[9] := _MIN(255, UserItem.btValue[9] + 1);//�ۻ��������� 20080816
      Dispose(UpgradeInfo);
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);

      if StdItem.NeedIdentify = 1 then
        AddGameDataLog('24' + #9 + User.m_sMapName + #9 +
          IntToStr(User.m_nCurrX) + #9 + IntToStr(User.m_nCurrY) + #9 +
          User.m_sCharName + #9 + StdItem.Name + #9 + IntToStr(UserItem.MakeIndex) + #9 +
          '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
          '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
          '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
          '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
          '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
          IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
          IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
          IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
          IntToStr(UserItem.btValue[14])+ #9 + IntToStr(UserItem.Dura)+'/'+IntToStr(UserItem.DuraMax));
      User.ClearCopyItem(0, UserItem.wIndex, UserItem.MakeIndex);//��������Ͳֿ⸴����Ʒ 20080816
      User.AddItemToBag(UserItem);
      User.SendAddItem(UserItem);
    end;
    case n18 of //
      0: GotoLable(User, sGETBACKUPGFAIL, False);
      1: GotoLable(User, sGETBACKUPGING, False);
      2: GotoLable(User, sGETBACKUPGOK, False);
    end; // case
  except
    MainOutMessage('{�쳣} TMerchant.GetBackupgWeapon');
  end;
end;
//ȡ�û��۸�
function TMerchant.GetUserPrice(PlayObject: TPlayObject; nPrice: Integer): Integer; //0049F6E0
var
  n14: Integer;
begin
  {
  if m_boCastle then begin
    if UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild)) then begin
      n14:=_MAX(60,ROUND(m_nPriceRate * 8.0000000000000000001e-1));//80%
      Result:=ROUND(nPrice / 1.0e2 * n14); //100
    end else begin
      Result:=ROUND(nPrice / 1.0e2 * m_nPriceRate);
    end;
  end else begin
    Result:=ROUND(nPrice / 1.0e2 * m_nPriceRate);
  end;
  }
  if m_boCastle then begin
    //    if UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild)) then begin
    if (m_Castle <> nil) and TUserCastle(m_Castle).IsMasterGuild(TGUild(PlayObject.m_MyGuild)) then begin
      n14 := _MAX(60, Round(m_nPriceRate * (g_Config.nCastleMemberPriceRate / 100))); //80%
      Result := Round(nPrice / 100 * n14); //100
    end else begin
      Result := Round(nPrice / 100 * m_nPriceRate);
    end;
  end else begin
    Result := Round(nPrice / 100 * m_nPriceRate);
  end;
end;

procedure TMerchant.UserSelect(PlayObject: TPlayObject; sData: string);
  procedure SuperRepairItem(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_SENDUSERSREPAIR, 0, Integer(Self), 0, 0, '');
  end;
  procedure BuyItem(User: TPlayObject; nInt: Integer);//NPC����Ʒ
  var
    I, n10, nStock, nPrice: Integer;
    nSubMenu: ShortInt;
    sSENDMSG, sName: string;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    List14: TList;
  begin
    sSENDMSG := '';
    n10 := 0;
    if m_GoodsList.Count > 0 then begin//20080629
      for I := 0 to m_GoodsList.Count - 1 do begin
        List14 := TList(m_GoodsList.Items[I]);
        if List14 = nil then Continue;
        UserItem := List14.Items[0];
        if UserItem = nil then Continue;
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem <> nil then begin
          //ȡ�Զ�����Ʒ����
          sName := '';
          if UserItem.btValue[13] = 1 then
            sName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
          if sName = '' then
            sName := StdItem.Name;

          nPrice := GetUserPrice(User, GetItemPrice(UserItem.wIndex));
          if nPrice <= 0 then Continue;//���˼۸�Ϊ0����Ʒ 20081130
          nStock := List14.Count;
          if (StdItem.StdMode <= 4) or
            (StdItem.StdMode = 42) or
            (StdItem.StdMode = 31) then nSubMenu := 0
          else nSubMenu := 1;
          sSENDMSG := sSENDMSG + sName + '/' + IntToStr(nSubMenu) + '/' + IntToStr(nPrice) + '/' + IntToStr(nStock) + '/';
          Inc(n10);
        end;
      end; // for
    end;
    User.SendMsg(Self, RM_SENDGOODSLIST, 0, Integer(Self), n10, 0, sSENDMSG);
  end;

 { procedure BuySellItem(User: TPlayObject); //������Ʒ�б�   //20080416 ȥ����������
  var
    I, n18, nStock, nSubMenu, nSellGold: Integer;
    List20: TList;
    s1C, sName: string;
    SellOffInfo: pTSellOffInfo;
    StdItem: pTStdItem;
  begin
    s1C := '';
    n18 := 0;
    List20 := TList.Create;
    g_SellOffGoodList.GetSellOffGoodList(List20);
    for I := 0 to List20.Count - 1 do begin
      if List20.Count <= 0 then Break;
      SellOffInfo := List20.Items[I];
      if SellOffInfo = nil then Continue;
      StdItem := UserEngine.GetStdItem(SellOffInfo.UseItems.wIndex);
      if StdItem <> nil then begin
        //ȡ�Զ�����Ʒ����
        sName := '';
        if SellOffInfo.UseItems.btValue[13] = 1 then
          sName := ItemUnit.GetCustomItemName(SellOffInfo.UseItems.MakeIndex, SellOffInfo.UseItems.wIndex);
        if sName = '' then
          sName := StdItem.Name;
        nStock := List20.Count;
        if (StdItem.StdMode <= 4) or
          (StdItem.StdMode = 42) or
          (StdItem.StdMode = 31) then nSubMenu := 0
        else nSubMenu := 1;
        if CompareText(SellOffInfo.sCharName, User.m_sCharName) = 0 then nSellGold := -SellOffInfo.nSellGold else nSellGold := SellOffInfo.nSellGold;
        s1C := s1C + sName + '/' + IntToStr(nSubMenu) + '/' + IntToStr(nSellGold) + '/' + IntToStr(nStock) + '/';
        Inc(n18);
      end;
    end;
    User.SendMsg(Self, RM_SENDSELLOFFGOODSLIST, 0, Integer(Self), n18, 0, s1C);
    List20.Free;
  end;  }

 { procedure GetSellGold(User: TPlayObject);//������Ʒ�۸�  //20080416 ȥ����������
  var
    I: Integer;
    nSellGold: Integer;
    nRate: Integer;
    nSellGoldCount: Integer;
    nRateCount: Integer;
    s1C: string;
    SellOffInfo: pTSellOffInfo;
    n18: Integer;
    List20: TList;
//    bo01: Boolean;
  begin
    nSellGoldCount := 0;
    nRateCount := 0;
    s1C := '';
    List20 := TList.Create;
    g_SellOffGoldList.GetUserSellOffGoldListByChrName(User.m_sCharName, List20);
    for I := 0 to List20.Count - 1 do begin
      if List20.Count <= 0 then Break;
      SellOffInfo := pTSellOffInfo(List20.Items[I]);
      if SellOffInfo = nil then Continue;
      if g_Config.nUserSellOffTax > 0 then begin
        nRate := SellOffInfo.nSellGold * g_Config.nUserSellOffTax div 100;
        nSellGold := SellOffInfo.nSellGold - nRate;
      end else begin
        nSellGold := SellOffInfo.nSellGold;
        nRate := 0;
      end;
      s1C := '��Ʒ:' + UserEngine.GetStdItemName(SellOffInfo.UseItems.wIndex) + ' ���:' + IntToStr(nSellGold) + ' ˰:' + IntToStr(nRate) + g_Config.sGameGoldName + ' ��������:' + DateTimeToStr(SellOffInfo.dSellDateTime);
      User.SysMsg(s1C, c_Green, t_Hint);
      Inc(User.m_nGameGold, nSellGold);
      Inc(nSellGoldCount, nSellGold);
      User.GameGoldChanged;
      Inc(nRateCount, nRate);
      Inc(n18);
      g_SellOffGoldList.DelSellOffGoldItem(SellOffInfo.UseItems.MakeIndex);
    end;
    if n18 > 0 then begin
      s1C := '�ܽ��:' + IntToStr(nSellGoldCount) + ' ˰:' + IntToStr(nRateCount) + g_Config.sGameGoldName;
      User.SysMsg(s1C, c_Green, t_Hint);
    end;
    //g_SellOffGoldList.SaveSellOffGoldList();
    //MainOutMessage('List20.Count:'+IntToStr(List20.Count));
    List20.Free;
  end;  }

  procedure RemoteMsg(User: TPlayObject; sLabel, sMsg: string); //���ܸ���
  var
    sSENDMSG: string;
    TargetObject: TPlayObject;
  begin
    sMsg := Trim(sMsg);
    if sMsg <> '' then begin
      TargetObject := UserEngine.GetPlayObject(sMsg);
      if TargetObject <> nil then begin
        if TargetObject.m_boRemoteMsg then begin
          sLabel := Copy(sLabel, 2, Length(sLabel) - 1);
          sSENDMSG := '���ĺ��� ' + User.m_sCharName + ' ������������\ \<���Ÿ���/' + sLabel + '>\';
          SendMsgToUser(TargetObject, sSENDMSG);
        end else begin
          User.SysMsg(sMsg + '���ĺ��� ' + TargetObject.m_sCharName + ' �ܾ����ܸ���������', c_Red, t_Hint);
        end;
      end else begin
        User.SysMsg(sMsg + g_sUserNotOnLine {'  û�����ߣ�����'}, c_Red, t_Hint);
      end;
    end;
  end;
 //�һ�����
  procedure AutoGetExp(User: TPlayObject; sMsg: string);
  begin
    User.m_sAutoSendMsg := sMsg;
  end;

  procedure DealGold(User: TPlayObject; sMsg: string);
  var
    PoseHuman: TPlayObject;
    nGameGold: Integer;
  begin
    nGameGold := Str_ToInt(sMsg, -1);
    if User.m_nDealGoldPose <> 1 then begin
      GotoLable(User, '@dealgoldPlayError', False);
      Exit;
    end;
    User.m_nDealGoldPose := 2;
    if nGameGold <= 0 then begin
      GotoLable(User, '@dealgoldInputFail', False);
    end else begin
      if User.m_nGameGold >= nGameGold then begin
        PoseHuman := TPlayObject(User.GetPoseCreate());
        if (PoseHuman <> nil) and (TPlayObject(PoseHuman.GetPoseCreate) = User) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
          Inc(PoseHuman.m_nGameGold, nGameGold);
          Dec(User.m_nGameGold, nGameGold);
          PoseHuman.GameGoldChanged;
          User.GameGoldChanged;
          if g_boGameLogGameGold then
            AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GAMEGOLD,
                PoseHuman.m_sMapName,
                PoseHuman.m_nCurrX,
                PoseHuman.m_nCurrY,
                PoseHuman.m_sCharName,
                g_Config.sGameGoldName,
                PoseHuman.m_nGameGold,
                'ת��'+'('+inttostr(nGameGold)+')',
                User.m_sCharName]));
          SendMsgToUser(User, 'ת�ʳɹ���' + #10 + 'ת��' + g_Config.sGameGoldName + '��' + IntToStr(nGameGold) + #9 + '��ǰ' + g_Config.sGameGoldName + '��' + IntToStr(User.m_nGameGold));
          SendMsgToUser(PoseHuman, 'ת�ʳɹ���' + #10 + '����' + g_Config.sGameGoldName + '��' + IntToStr(nGameGold) + #9 + '��ǰ' + g_Config.sGameGoldName + '��' + IntToStr(PoseHuman.m_nGameGold));
        end else begin
          GotoLable(User, '@dealgoldpost', False);
        end;
      end else begin
        GotoLable(User, '@dealgoldFail', False);
      end;
    end;
  end;

  procedure SellItem(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_SENDUSERSELL, 0, Integer(Self), 0, 0, '');
  end;
  procedure SellSellItem(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_SENDUSERSELLOFFITEM, 0, Integer(Self), 0, 0, '');
  end;

  procedure RepairItem(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_SENDUSERREPAIR, 0, Integer(Self), 0, 0, '');
  end;
  procedure MakeDurg(User: TPlayObject);
  var
    I: Integer;
    List14: TList;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    sSENDMSG: string;
  begin
    sSENDMSG := '';
    if m_GoodsList.Count > 0 then begin//20080629
      for I := 0 to m_GoodsList.Count - 1 do begin
        List14 := TList(m_GoodsList.Items[I]);
        if List14.Count <= 0 then Continue; //0807 ���ӣ���ֹ����ҩ��Ʒ�б�Ϊ��ʱ����
        UserItem := List14.Items[0];
        if UserItem = nil then Continue;
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem <> nil then begin
          sSENDMSG := sSENDMSG + StdItem.Name + '/' + IntToStr(0) + '/' + IntToStr(g_Config.nMakeDurgPrice) + '/' + IntToStr(1) + '/';
        end;
      end;
    end;
    if sSENDMSG <> '' then
      User.SendMsg(Self, RM_USERMAKEDRUGITEMLIST, 0, Integer(Self), 0, 0, sSENDMSG);
  end;
  procedure ItemPrices(User: TPlayObject); //
  begin

  end;
  procedure Storage(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_USERSTORAGEITEM, 0, Integer(Self), 0, 0, '');
  end;
  procedure GetBack(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_USERGETBACKITEM, 0, Integer(Self), 0, 0, '');
  end;
  procedure BigStorage(User: TPlayObject);
  begin
    User.SendMsg(Self, RM_USERSTORAGEITEM, 0, Integer(Self), 0, 0, '');
  end;
  procedure BigGetBack(User: TPlayObject);
  begin
    User.m_nBigStoragePage := 0;
    User.SendMsg(Self, RM_USERBIGGETBACKITEM, User.m_nBigStoragePage, Integer(Self), 0, 0, '');
  end;
  procedure GetPreviousPage(User: TPlayObject);
  begin
    if User.m_nBigStoragePage > 0 then
      Dec(User.m_nBigStoragePage)
    else User.m_nBigStoragePage := 0;
    User.SendMsg(Self, RM_USERBIGGETBACKITEM, User.m_nBigStoragePage, Integer(Self), 0, 0, '');
  end;
  procedure GetNextPage(User: TPlayObject);
  begin
    Inc(User.m_nBigStoragePage);
    User.SendMsg(Self, RM_USERBIGGETBACKITEM, User.m_nBigStoragePage, Integer(Self), 0, 0, '');
  end;

  procedure UserLevelOrder(User: TPlayObject);
  begin
    User.m_nSelPlayOrderType := 0;
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure WarrorLevelOrder(User: TPlayObject);
  begin
    User.m_nSelPlayOrderType := 1;
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure WizardLevelOrder(User: TPlayObject);
  begin
    User.m_nSelPlayOrderType := 2;
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure TaoistLevelOrder(User: TPlayObject);
  begin
    User.m_nSelPlayOrderType := 3;
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure MasterCountOrder(User: TPlayObject);
  begin
    User.m_nSelPlayOrderType := 4;
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure LevelOrderHomePage(User: TPlayObject);
  begin
    User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure LevelOrderPreviousPage(User: TPlayObject);
  begin
    if User.m_nPlayOrderPage > 0 then
      Dec(User.m_nPlayOrderPage)
    else
      User.m_nPlayOrderPage := 0;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure LevelOrderNextPage(User: TPlayObject);
  var
    PlayObjectList: TStringList;
  begin
    PlayObjectList := GetPlayObjectOrderList(User.m_nSelPlayOrderType);
    if PlayObjectList <> nil then begin
      if GetPageCount(PlayObjectList.Count) > User.m_nPlayOrderPage then begin
        Inc(User.m_nPlayOrderPage);
      end;
      User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
    end;
  end;

  procedure LevelOrderLastPage(User: TPlayObject);
  var
    PlayObjectList: TStringList;
  begin
    PlayObjectList := GetPlayObjectOrderList(User.m_nSelPlayOrderType);
    if PlayObjectList <> nil then begin
      User.m_nPlayOrderPage := GetPageCount(PlayObjectList.Count);
      User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
    end;
  end;

  procedure MyLevelOrder(User: TPlayObject);
  begin
    User.m_boGetMyLevelOrder := True;
    User.SendDelayMsg(Self, RM_USERLEVELORDER, 0, 0, 0, 0, '', 100);
  end;

  procedure MakeHeroName(User: TPlayObject; sLabel, sMsg: string);//����Ӣ������(������) 20080315
  var
    sGotoLabel: string;
    //sSrcMsg: string;
    //DestMsg: array[0..256] of Char;
  begin
    if User.m_boWaitHeroDate then Exit;
    if (User.m_boHasHero) or (User.m_sHeroCharName <> '') then begin//20080521
      GotoLable(User, '@HaveHero', False);
    end else begin
      if (Length(sMsg) > 0) and (Length(sMsg) < 15) then begin
        if not IsFilterMsg(sMsg) then begin //���ֹ��� 20080729
          User.m_sTempHeroCharName :='';
          GotoLable(User, '@HeroNameFilter', False);
          Exit;
        end;
        {if Assigned(zPlugOfEngine.PlayObjectFilterMsg) then begin
          sSrcMsg := Trim(sMsg);
          FillChar(DestMsg, SizeOf(DestMsg), 0);//20080524
          if zPlugOfEngine.PlayObjectFilterMsg(User, PChar(sSrcMsg), @DestMsg) then begin//���ֹ���
              sMsg := StrPas(PChar(@DestMsg));//20080524
          end else begin
            User.m_sTempHeroCharName :='';
            GotoLable(User, '@HeroNameFilter', False);
            Exit;
          end;
        end; }
        User.m_sTempHeroCharName := Trim(sMsg);
        sGotoLabel := Copy(sLabel, 2, Length(sLabel) - 1);
        GotoLable(User, sGotoLabel, False);//��ת������Ӣ�۱�ǩ
      end else begin
        User.m_sHeroCharName := '';
        GotoLable(User, '@HeroNameFilter', False);
      end;
    end;
  end;
  //��������Ӣ������ 20080514 
  procedure MakeBuHeroName(User: TPlayObject; sLabel, sMsg: string);
  var
    sGotoLabel: string;
    //sSrcMsg: string;
    //DestMsg: array[0..256] of Char;
  begin
    if User.m_boWaitHeroDate then Exit;
    if (User.m_boHasHeroTwo) or (User.m_sHeroCharName <> '') then begin//20080521
      GotoLable(User, '@HaveHero', False);
    end else begin
      if (Length(sMsg) > 0) and (Length(sMsg) < 15) then begin
        if not IsFilterMsg(sMsg) then begin //���ֹ��� 20080729
          User.m_sTempHeroCharName := '';
          GotoLable(User, '@HeroNameFilter', False);
          Exit;
        end;
        {if Assigned(zPlugOfEngine.PlayObjectFilterMsg) then begin
          sSrcMsg := Trim(sMsg);
          FillChar(DestMsg, SizeOf(DestMsg), 0);//20080524
          if zPlugOfEngine.PlayObjectFilterMsg(User, PChar(sSrcMsg), @DestMsg) then begin//���ֹ���
              sMsg := StrPas(PChar(@DestMsg));//20080524
           end else begin
              User.m_sTempHeroCharName := '';
              GotoLable(User, '@HeroNameFilter', False);
              Exit;
          end;
        end;}
        User.m_sTempHeroCharName := sMsg;
        sGotoLabel := sLabel{Copy(sLabel, 2, Length(sLabel) - 1)};
        GotoLable(User, sGotoLabel, False);//��ת������Ӣ�۱�ǩ
      end else begin
        User.m_sHeroCharName := '';
        GotoLable(User, '@HeroNameFilter', False);
      end;
    end;
  end;
  procedure PlayDrink(User: TPlayObject);//���,���� 20080515
  begin
    User.SendMsg(Self, RM_SENDUSERPLAYDRINK, 0, Integer(Self), 0, 0, '');
  end;
  procedure OpenDealOffForm(User: TPlayObject);//�򿪳�����Ʒ���� 20080316
  begin
    if User.bo_YBDEAL then begin
      if not User.SellOffInTime(0) then begin
        User.SendMsg(Self, RM_SENDDEALOFFFORM, 0, Integer(Self), 0, 0, '');
        User.GetBackSellOffItems();
      end else User.SendMsg(self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/������Ԫ���������ڽ��У���\ \<����/@main>');
    end else User.SendMsg(self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/��δ��ͨԪ������,���ȿ�ͨԪ�����񣡣�\ \<����/@main>');
  end;
  procedure PlugOfPlayObjectUserSelect(PlayObject: TPlayObject; pszLabel, pszData: String);//20080729
  var
    sLabel, sData: string;
    nData, nData1: Integer;
    nLength: Integer;
  begin
    try
      if CompareLStr(pszLabel,'@@InPutString',13) then begin
        nLength := CompareText(pszLabel, '@@InPutString');
        if nLength > 0 then begin
          sLabel := Copy(pszLabel, length('@@InPutString') + 1, nLength);
          sData := pszData;
          if {not}IsFilterMsg(sData) then begin//������Ϣ 20080808
            nData:= Str_ToInt(sLabel, 0);
            if (nData > 99) or (nData < 0) then nData:= 0;
            PlayObject.m_sString[nData] := sData;
            GotoLable(PlayObject, '@InPutString' + inttostr(nData), False);
          end else begin
            GotoLable( PlayObject, '@MsgFilter', False);
          end;
          Exit;
        end;
      end else
      if CompareLStr(pszLabel, '@@InPutInteger',14) then begin
        nLength := CompareText(pszLabel, '@@InPutInteger');
        if nLength > 0 then begin
          sLabel := Copy(pszLabel, length('@@InPutInteger') + 1, nLength);
          nData := Str_ToInt(pszData, -1);
          nData1:= Str_ToInt(sLabel, 0);
          if (nData1 > 99) or (nData1 < 0) then nData1:= 0;//20081008
          PlayObject.m_nInteger[nData1] := nData;
          GotoLable(PlayObject, '@InPutInteger' + sLabel, False);
        end;
      end;
    except
      MainOutMessage('{�쳣} PlugOfPlayObjectUserSelect');
    end;
  end;
var
  sLabel, s18, sMsg: string;
  boCanJmp: Boolean;
  sChangeUseItemName: string;
  nCode: Integer;
resourcestring
  sExceptionMsg = '{�쳣} TMerchant::UserSelect... Data: %s Code:%d';
begin
  inherited;
  if not (ClassNameIs(TMerchant.ClassName)) then Exit; //����������� TMerchant ��ִ�����´�����
  nCode:= 39;
  try
    if not m_boCastle or not ((m_Castle <> nil) and TUserCastle(m_Castle).m_boUnderWar) and (PlayObject <> nil) then begin
      nCode:= 40;
      if not PlayObject.m_boDeath and (sData <> '') and (sData[1] = '@') then begin
        nCode:= 41;
        sMsg := GetValidStr3(sData, sLabel, [#13]);
        s18 := '';
        PlayObject.m_sScriptLable := sData;
        nCode:= 42;
        boCanJmp := PlayObject.LableIsCanJmp(sLabel);
        nCode:= 43;
        if CompareText(sLabel, sSL_SENDMSG) = 0 then begin
          nCode:= 1;
          if sMsg = '' then Exit;
        end;
        if CompareLStr(sLabel, sUSEITEMNAME, 13{Length(sUSEITEMNAME)}) then begin //���װ��
          nCode:= 2;
          if sMsg <> '' then begin
            if g_Config.boChangeUseItemNameByPlayName then begin
              sChangeUseItemName := PlayObject.m_sCharName + '��' + sMsg;
            end else begin
              sChangeUseItemName := g_Config.sChangeUseItemName + sMsg;
            end;
            if Length(sChangeUseItemName) > 14 then begin
              SendMsgToUser(PlayObject, '[ʧ��] ����̫��������');
              Exit;
            end;
          end;
        end;
        nCode:= 44;
        if PlayObject= nil then Exit;//20080908 ����
        nCode:= 47;
        if PlayObject.m_boGhost then Exit;//20080826 ����
        nCode:= 45;
        GotoLable(PlayObject, sLabel, not boCanJmp);
        nCode:= 46;
        if not boCanJmp then Exit;
        s18 := Copy(sLabel, 1, Length(sRMST));
        if CompareText(sLabel, sSL_SENDMSG) = 0 then begin
          nCode:= 3;
          if m_boSendmsg then SendCustemMsg(PlayObject, sMsg);
        end else
          if CompareText(sLabel, sSUPERREPAIR) = 0 then begin
          nCode:= 4;
          if m_boS_repair then SuperRepairItem(PlayObject);
        end else
          if CompareText(sLabel, sBUY) = 0 then begin
          nCode:= 5;
          if m_boBuy then BuyItem(PlayObject, 0);
        end else
          if CompareText(s18, sRMST) = 0 then begin //���ܸ���
          nCode:= 6;
          if m_boofflinemsg then RemoteMsg(PlayObject, sLabel, sMsg);
        end else
          if CompareText(sLabel, sofflinemsg) = 0 then begin //���߹һ�
          nCode:= 7;
          if m_boofflinemsg then AutoGetExp(PlayObject, sMsg);
        end else
        {  if CompareText(sLabel, sGETSELLGOLD) = 0 then begin  //20080416 ȥ����������
          if m_boGetSellGold then GetSellGold(PlayObject);
        end else  
          if CompareText(sLabel, sBUYOFF) = 0 then begin
          if m_boBuyOff then BuySellItem(PlayObject);
        end else
          if CompareText(sLabel, sSELLOFF) = 0 then begin
          if m_boBuyOff then SellSellItem(PlayObject);
        end else  }
          if CompareText(sLabel, sdealgold) = 0 then begin
          nCode:= 8;
          if m_boDealGold then DealGold(PlayObject, sMsg);
        end else
          if CompareText(sLabel, sSELL) = 0 then begin//�����NPC����Ʒ 
          nCode:= 9;
          if m_boSell then SellItem(PlayObject);
        end else
          if CompareText(sLabel, sREPAIR) = 0 then begin
          nCode:= 10;
          if m_boRepair then RepairItem(PlayObject);
        end else
          if CompareText(sLabel, sMAKEDURG) = 0 then begin
          nCode:= 11;
          if m_boMakeDrug then MakeDurg(PlayObject);
        end else
          if CompareText(sLabel, sPRICES) = 0 then begin
          nCode:= 12;
          if m_boPrices then ItemPrices(PlayObject);
        end else
          if CompareText(sLabel, sSTORAGE) = 0 then begin
          nCode:= 13;
          if m_boStorage then Storage(PlayObject);
        end else
          if CompareText(sLabel, sGETBACK) = 0 then begin
          nCode:= 14;
          if m_boGetback then GetBack(PlayObject);
        end else
          if CompareText(sLabel, sBIGSTORAGE) = 0 then begin
          nCode:= 15;
          if m_boBigStorage then BigStorage(PlayObject);
        end else
          if CompareText(sLabel, sBIGGETBACK) = 0 then begin
          nCode:= 16;
          if m_boBigGetBack then BigGetBack(PlayObject);
        end else
          if CompareText(sLabel, sGETPREVIOUSPAGE) = 0 then begin
          nCode:= 17;
          if m_boBigGetBack then GetPreviousPage(PlayObject);
        end else
          if CompareText(sLabel, sGETNEXTPAGE) = 0 then begin
          nCode:= 18;
          if m_boBigGetBack then GetNextPage(PlayObject);
        end else
          if CompareText(sLabel, sUserLevelOrder) = 0 then begin
          nCode:= 19;
          if m_boUserLevelOrder then UserLevelOrder(PlayObject);
        end else
          if CompareText(sLabel, sWarrorLevelOrder) = 0 then begin
          nCode:= 20;
          if m_boWarrorLevelOrder then WarrorLevelOrder(PlayObject);
        end else
          if CompareText(sLabel, sWizardLevelOrder) = 0 then begin
          nCode:= 21;
          if m_boWizardLevelOrder then WizardLevelOrder(PlayObject);
        end else
          if CompareText(sLabel, sTaoistLevelOrder) = 0 then begin
          nCode:= 22;
          if m_boTaoistLevelOrder then TaoistLevelOrder(PlayObject);
        end else
          if CompareText(sLabel, sMasterCountOrder) = 0 then begin
          nCode:= 23;
          if m_boMasterCountOrder then MasterCountOrder(PlayObject);
        end else
          if CompareText(sLabel, sLevelOrderHomePage) = 0 then begin
          nCode:= 24;
          LevelOrderHomePage(PlayObject);
        end else
          if CompareText(sLabel, sLevelOrderPreviousPage) = 0 then begin
          nCode:= 25;
          LevelOrderPreviousPage(PlayObject);
        end else
          if CompareText(sLabel, sLevelOrderNextPage) = 0 then begin
          nCode:= 26;
          LevelOrderNextPage(PlayObject);
        end else
          if CompareText(sLabel, sLevelOrderLastPage) = 0 then begin
          nCode:= 27;
          LevelOrderLastPage(PlayObject);
        end else
          if CompareText(sLabel, sMyLevelOrder) = 0 then begin
          nCode:= 28;
          MyLevelOrder(PlayObject);
        end else
          if CompareText(sLabel, sDealYBme) = 0 then begin //Ԫ������:������Ʒ 20080316
          nCode:= 29;
          if m_boYBDeal then OpenDealOffForm(PlayObject);//�򿪳�����Ʒ����
        end else
{$IF HEROVERSION = 1}
          if CompareText(sLabel, sLyCreateHero) = 0 then begin
          nCode:= 30;
          if m_boCqFirHero then MakeHeroName(PlayObject, sLabel, sMsg);
        end else
          if CompareText(sLabel, sBuHero) = 0 then begin //�ƹ�Ӣ��NPC 20080514
          nCode:= 39;
          if m_boBuHero then MakeBuHeroName(PlayObject, sLabel, sMsg);
        end else
          if CompareText(sLabel, sPlayDrink) = 0 then begin//�����NPC���,���� 20080515
          nCode:= 40;
          if m_boPlayDrink then PlayDrink(PlayObject);
        end else
{$IFEND}
          if CompareText(sLabel, sUPGRADENOW) = 0 then begin
          nCode:= 31;
          if m_boUpgradenow then UpgradeWapon(PlayObject);
        end else
          if CompareText(sLabel, sGETBACKUPGNOW) = 0 then begin
          nCode:= 32;
          if m_boGetBackupgnow then GetBackupgWeapon(PlayObject);
        end else
          if CompareText(sLabel, sGETMARRY) = 0 then begin
          nCode:= 33;
          if m_boGetMarry then GetBackupgWeapon(PlayObject);
        end else
          if CompareText(sLabel, sGETMASTER) = 0 then begin
          nCode:= 34;
          if m_boGetMaster then GetBackupgWeapon(PlayObject);
        end else
          if CompareLStr(sLabel, sUSEITEMNAME, 13{Length(sUSEITEMNAME)}) then begin
          nCode:= 35;
          if m_boUseItemName then ChangeUseItemName(PlayObject, sLabel, sMsg);
        end else
          if CompareText(sLabel, sEXIT) = 0 then begin
          nCode:= 36;
          PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
        end else
          if CompareText(sLabel, sBACK) = 0 then begin
          nCode:= 37;
          if PlayObject.m_sScriptGoBackLable = '' then PlayObject.m_sScriptGoBackLable := sMAIN;
          GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
        end else begin
          {if Assigned(zPlugOfEngine.PlayObjectUserSelect) then begin
            nCode:= 38;
            zPlugOfEngine.PlayObjectUserSelect(Self, PlayObject, PChar(sLabel), PChar(sMsg));
          end; }
          nCode:= 38;
          PlugOfPlayObjectUserSelect(PlayObject, PChar(sLabel), PChar(sMsg));//20080729
        end;
      end;
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [sData,nCode]));
  end;
end;

procedure TMerchant.Run();
var
  nCheckCode: Integer;
resourcestring
  sExceptionMsg1 = '{�쳣} TMerchant::Run... Code = %d';
  sExceptionMsg2 = '{�쳣} TMerchant::Run -> Move Code = %d';
begin
  nCheckCode := 0;
  try
    if (GetTickCount - dwRefillGoodsTick) > 30000 then begin
      dwRefillGoodsTick := GetTickCount();
      RefillGoods();//ˢ��NPC������Ʒ�б�
    end;

    nCheckCode := 1;
    if (GetTickCount - dwClearExpreUpgradeTick) > 600000{10 * 60 * 1000} then begin
      dwClearExpreUpgradeTick := GetTickCount();
      ClearExpreUpgradeListData();
    end;
    nCheckCode := 2;
    if Random(50) = 0 then begin
      TurnTo(Random(8));
    end else begin
      if Random(50) = 0 then
        SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end;
    nCheckCode := 3;
    if m_boCastle and (m_Castle <> nil) and TUserCastle(m_Castle).m_boUnderWar then begin
      if not m_boFixedHideMode then begin
        SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
        m_boFixedHideMode := True;
      end;
    end else begin
      if m_boFixedHideMode then begin
        m_boFixedHideMode := False;
        SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
      end;
    end;
    nCheckCode := 4;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg1, [nCheckCode]));
    end;
  end;
  try
    if m_boCanMove and (GetTickCount - m_dwMoveTick > m_dwMoveTime * 1000) then begin//NPC�ƶ�
      m_dwMoveTick := GetTickCount();
      SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      MapRandomMove(m_sMapName, 0);
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format(sExceptionMsg2, [nCheckCode]));
    end;
  end;
  inherited;
end;

function TMerchant.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TMerchant.LoadNPCData;
var
  sFile: string;
begin
try
  sFile := m_sScript + '-' + m_sMapName;
  FrmDB.LoadGoodRecord(Self, sFile);
  FrmDB.LoadGoodPriceRecord(Self, sFile);
  LoadUpgradeList();
except
  MainOutMessage('{�쳣} TMerchant.LoadNPCData');
end;
end;

procedure TMerchant.SaveNPCData;
var
  sFile: string;
begin
try
  sFile := m_sScript + '-' + m_sMapName;
  FrmDB.SaveGoodRecord(Self, sFile);
  FrmDB.SaveGoodPriceRecord(Self, sFile);
except
  MainOutMessage('{�쳣} TMerchant.SaveNPCData');
end;
end;

constructor TMerchant.Create;
begin
  inherited;
  m_btRaceImg := RCC_MERCHANT;//��ɫ���
  m_wAppr := 0;
  m_nPriceRate := 100;
  m_boCastle := False;
  m_ItemTypeList := TList.Create;
  m_RefillGoodsList := TList.Create;
  m_GoodsList := TList.Create;
  m_ItemPriceList := TList.Create;
  m_UpgradeWeaponList := TList.Create;

  dwRefillGoodsTick := GetTickCount();
  dwClearExpreUpgradeTick := GetTickCount();
  m_boBuy := False;
  m_boSell := False;
  m_boMakeDrug := False;
  m_boPrices := False;
  m_boStorage := False;
  m_boGetback := False;
  m_boBigStorage := False;
  m_boBigGetBack := False;
  m_boGetNextPage := False;
  m_boGetPreviousPage := False;
  m_boCqFirHero := False;
  m_boBuHero := False;//20080514
  m_boPlayMakeWine:= False;//���NPC 20080619

  m_boUserLevelOrder := False;
  m_boWarrorLevelOrder := False;
  m_boWizardLevelOrder := False;
  m_boTaoistLevelOrder := False;
  m_boMasterCountOrder := False;

  m_boUpgradenow := False;
  m_boGetBackupgnow := False;
  m_boRepair := False;
  m_boS_repair := False;
  m_boGetMarry := False;
  m_boGetMaster := False;
  m_boUseItemName := False;

  //m_boGetSellGold := False;//20080416 ȥ����������
  //m_boSellOff := False;//20080416 ȥ����������
  //m_boBuyOff := False;//20080416 ȥ����������
  m_boofflinemsg := False;
  m_boDealGold := False;
  m_dwMoveTick := GetTickCount();
end;

destructor TMerchant.Destroy;
var
  I: Integer;
  II: Integer;
  List: TList;
  nCode: Byte;//20080727
begin
  nCode:= 0;
  try
    nCode:= 1;
    m_ItemTypeList.Free;
    nCode:= 2;
    if m_RefillGoodsList.Count > 0 then begin//20080629
      for I := 0 to m_RefillGoodsList.Count - 1 do begin
        if pTGoods(m_RefillGoodsList.Items[I]) <> nil then
          Dispose(pTGoods(m_RefillGoodsList.Items[I]));
      end;
    end;
    m_RefillGoodsList.Free;

    nCode:= 3;
    if m_GoodsList.Count > 0 then begin//20080629
      for I := 0 to m_GoodsList.Count - 1 do begin
        List := TList(m_GoodsList.Items[I]);
        if List.Count > 0 then begin//20080629
          for II := 0 to List.Count - 1 do begin
            if pTUserItem(List.Items[II]) <> nil then Dispose(pTUserItem(List.Items[II]));
          end;
        end;
        List.Free;
      end;
    end;
    m_GoodsList.Free;

    nCode:= 4;
    if m_ItemPriceList.Count > 0 then begin//20080629
      for I := 0 to m_ItemPriceList.Count - 1 do begin
        if pTItemPrice(m_ItemPriceList.Items[I]) <> nil then
          Dispose(pTItemPrice(m_ItemPriceList.Items[I]));
      end;
    end;
    m_ItemPriceList.Free;

    nCode:= 5;
    if m_UpgradeWeaponList.Count > 0 then begin//20080629
      for I := 0 to m_UpgradeWeaponList.Count - 1 do begin
        if pTUpgradeInfo(m_UpgradeWeaponList.Items[I]) <> nil then
          Dispose(pTUpgradeInfo(m_UpgradeWeaponList.Items[I]));
      end;
    end;
    m_UpgradeWeaponList.Free;

    inherited;
  except
    MainOutMessage('{�쳣} TMerchant.Destroy Code:' + Inttostr(nCode));
  end;
end;

procedure TMerchant.ClearExpreUpgradeListData;
var
  I: Integer;
  UpgradeInfo: pTUpgradeInfo;
begin
try
  for I := m_UpgradeWeaponList.Count - 1 downto 0 do begin
    if m_UpgradeWeaponList.Count <= 0 then Break;
    UpgradeInfo := m_UpgradeWeaponList.Items[I];
    if UpgradeInfo = nil then Continue;
    if Integer(Round(Now - UpgradeInfo.dtTime)) >= g_Config.nClearExpireUpgradeWeaponDays then begin
      Dispose(UpgradeInfo);
      m_UpgradeWeaponList.Delete(I);
    end;
  end;
except
  MainOutMessage('{�쳣} TMerchant.ClearExpreUpgradeListData');
end;
end;

procedure TMerchant.LoadNpcScript;
var
  SC: string;
begin
  try
    m_ItemTypeList.Clear;
    m_sPath := sMarket_Def;
    SC := m_sScript + '-' + m_sMapName;
    FrmDB.LoadScriptFile(Self, sMarket_Def, SC, True);
  except
    MainOutMessage('{�쳣} TMerchant.LoadNpcScript');
  end;
end;

procedure TMerchant.Click(PlayObject: TPlayObject);
begin
  try
    if (not m_boGhost) then begin//20090101
      if PlayObject <> nil then begin
        if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin//20090102 ����
          inherited;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TMerchant.Click');
  end;
end;

procedure TMerchant.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string);
var
  sText: string;
begin
  inherited;
  try
    if sVariable = '$PRICERATE' then begin
      sText := IntToStr(m_nPriceRate);
      sMsg := sub_49ADB8(sMsg, '<$PRICERATE>', sText);
    end;
    if sVariable = '$UPGRADEWEAPONFEE' then begin
      sText := IntToStr(g_Config.nUpgradeWeaponPrice);
      sMsg := sub_49ADB8(sMsg, '<$UPGRADEWEAPONFEE>', sText);
    end;
    if sVariable = '$USERWEAPON' then begin
      if PlayObject.m_UseItems[U_WEAPON].wIndex <> 0 then begin
        sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
      end else begin
        sText := '��';
      end;
      sMsg := sub_49ADB8(sMsg, '<$USERWEAPON>', sText);
    end;
  except
    MainOutMessage('{�쳣} TMerchant.GetVariableText');
  end;
end;
//ȡʹ����Ʒ�ļ۸�
function TMerchant.GetUserItemPrice(UserItem: pTUserItem): Integer;
var
  n10: Integer;
  StdItem: pTStdItem;
  n20: real;
  nC: Integer;
  n14: Integer;
begin
try
  n10 := GetItemPrice(UserItem.wIndex);
  if n10 > 0 then begin
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) then begin//20090203
      if  (StdItem.StdMode > 4) and
        (StdItem.DuraMax > 0) and
        (UserItem.DuraMax > 0) then begin
        if StdItem.StdMode = 40 then begin //��
          if UserItem.Dura <= UserItem.DuraMax then begin
            n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
            n10 := _MAX(2, Round(n10 - n20));
          end else begin
            n10 := n10 + Round(n10 / UserItem.DuraMax * 2.0 * (UserItem.DuraMax - UserItem.Dura));
          end;
        end;
        if (StdItem.StdMode = 43) then begin//��ʯ
          if UserItem.DuraMax < 10000 then UserItem.DuraMax := 10000;
         { if UserItem.Dura <= UserItem.DuraMax then begin
            n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
            n10 := _MAX(2, Round(n10 - n20));
          end else begin
            n10 := n10 + Round(n10 / UserItem.DuraMax * 1.3 * (UserItem.DuraMax - UserItem.Dura));
          end; }
          //20090203 �޸ģ�������ǰ�־ô������־�ʱ���۸��С���ȵĿ�ʯ����
          n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
          n10 := _MAX(2, Round(n10 - n20));
        end;
        if StdItem.StdMode > 4 then begin
          n14 := 0;
          nC := 0;
          while (True) do begin
            if (StdItem.StdMode = 5) or (StdItem.StdMode = 6) then begin
              if (nC <> 4) or (nC <> 9) then begin
                if nC = 6 then begin
                  if UserItem.btValue[nC] > 10 then begin
                    n14 := n14 + (UserItem.btValue[nC] - 10) * 2;
                  end;
                end else begin
                  n14 := n14 + UserItem.btValue[nC];
                end;
              end;
            end else begin
              Inc(n14, UserItem.btValue[nC]);
            end;
            Inc(nC);
            if nC >= 8 then Break;
          end;
          if n14 > 0 then begin
            n10 := n10 div 5 * n14;
          end;
          n10 := Round(n10 / StdItem.DuraMax * UserItem.DuraMax);
          n20 := (n10 / 2.0 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
          n10 := _MAX(2, Round(n10 - n20));
        end;
      end;
    end;
  end;
  Result := n10;
except
  MainOutMessage('{�쳣} TMerchant.GetUserItemPrice');
end;
end;
//�ͻ��˹�����Ʒ
procedure TMerchant.ClientBuyItem(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer);
var
  I, II: Integer;
  bo29: Boolean;
  List20: TList;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  n1C, nPrice: Integer;
  sUserItemName: string;
begin
  try
    bo29 := False;
    n1C := 1;
    //I := 0;
    //while True do begin //for i := 0 to m_GoodsList.Count - 1 do begin
    if m_GoodsList.Count > 0 then begin
      for I := 0 to m_GoodsList.Count - 1 do begin//20081008 �滻
        //if I >= m_GoodsList.Count then Break;
        //if m_GoodsList.Count <= 0 then Break;
        if bo29 then Break;
        List20 := TList(m_GoodsList.Items[I]);
        if List20 = nil then Continue;
        if List20.Count <= 0 then Continue;
        UserItem := List20.Items[0];
        if CheckIsOKItem(UserItem, 0) then Break;//����̬��Ʒ 20081008
        //ȡ�Զ�����Ʒ����
        sUserItemName := '';
        if UserItem.btValue[13] = 1 then
          sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
        if sUserItemName = '' then
          sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);

        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem <> nil then begin
          if UserItem.btValue[12] = 1 then StdItem.Reserved1:=1 //��Ʒ���� 20080223
             else StdItem.Reserved1:= 0;
          if PlayObject.IsAddWeightAvailable(StdItem.Weight) then begin
            if sUserItemName = sItemName then begin
              //II := 0;
              //while True do begin //for ii := 0 to List20.Count - 1 do begin
              if List20.Count > 0 then begin
                for II := 0 to List20.Count - 1 do begin
                  //if II >= List20.Count then Break;
                  if List20.Count <= 0 then Break;
                  UserItem := List20.Items[II];
                  if (StdItem.StdMode <= 4) or
                    (StdItem.StdMode = 42) or
                    (StdItem.StdMode = 31) or
                    (UserItem.MakeIndex = nInt) then begin

                    nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
                    if (PlayObject.m_nGold >= nPrice) and (nPrice > 0) then begin
                      PlayObject.ClearCopyItem(0, UserItem.wIndex, UserItem.MakeIndex);//��������Ͳֿ⸴����Ʒ 20080816
                      if PlayObject.AddItemToBag(UserItem) then begin
                        Dec(PlayObject.m_nGold, nPrice);
                        if m_boCastle or g_Config.boGetAllNpcTax then begin
                          if m_Castle <> nil then begin
                            TUserCastle(m_Castle).IncRateGold(nPrice);
                          end else
                            if g_Config.boGetAllNpcTax then begin
                            g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
                          end;
                        end;
                        {if m_boCastle or g_Config.boGetAllNpcTax then
                          UserCastle.IncRateGold(nPrice); }
                        if (StdItem.StdMode = 2) and (StdItem.AniCount = 21) then  UserItem.Dura:=0; //20080211  ħ�����ף����,��ѵ�ǰ�־�����Ϊ0
                        if (StdItem.StdMode = 51) and (StdItem.Shape = 0) then UserItem.Dura:=0; //20080221  ������,��ѵ�ǰ�־�����Ϊ0
                        PlayObject.SendAddItem(UserItem);
                        if StdItem.NeedIdentify = 1 then
                          AddGameDataLog('9' + #9 + PlayObject.m_sMapName + #9 +
                            IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
                            PlayObject.m_sCharName + #9 + StdItem.Name + #9 +
                            IntToStr(UserItem.MakeIndex) + #9 +
                            '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                            '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                            '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                            '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                            '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                            IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                            IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                            IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                            IntToStr(UserItem.btValue[14])+ #9 + m_sCharName);

                        List20.Delete(II);
                        if List20.Count <= 0 then begin
                          List20.Free;
                          m_GoodsList.Delete(I);
                        end;
                        n1C := 0;
                      end else n1C := 2;
                    end else n1C := 3;
                    bo29 := True;
                    Break;
                  end;
                  //Inc(II);
                end;
              end;
            end;
          end else n1C := 2; //004A2639
        end;
        //Inc(I);
      end; // for
    end;
    if n1C = 0 then begin
      PlayObject.SendMsg(Self, RM_BUYITEM_SUCCESS, 0, PlayObject.m_nGold, nInt, 0, '');
      PlayObject.GoldChanged(); //���¿ͻ��˽�� 20080417
    end else begin
      PlayObject.SendMsg(Self, RM_BUYITEM_FAIL, 0, n1C, 0, 0, '');
    end;
  except
    MainOutMessage('{�쳣} TMerchant.ClientBuyItem');
  end;
end;

procedure TMerchant.ClientGetDetailGoodsList(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer);
var
  I, II, n18: Integer;
  List20: TList;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  ClientItem: TClientItem;
  OClientItem: TOClientItem;
  s1C: string;
  nCode: Byte;//20081009
begin
  Try
    nCode:= 0;
    if PlayObject.m_nSoftVersionDateEx = 0 then begin
      n18 := 0;
      if m_GoodsList.Count > 0 then begin//20080629
        for I := 0 to m_GoodsList.Count - 1 do begin
          List20 := TList(m_GoodsList.Items[I]);
          if List20 = nil then Continue;
          if List20.Count <= 0 then Continue;
          nCode:= 1;
          UserItem := List20.Items[0];
          if UserItem = nil then Continue;
          nCode:= 2;
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if (StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0) then begin
            if (List20.Count - 1) < nInt then begin
              nInt := _MAX(0, List20.Count - 10);
            end;
            nCode:= 3;
            for II := List20.Count - 1 downto 0 do begin
              if List20.Count <= 0 then Break;
              UserItem := List20.Items[II];
              nCode:= 4;
              if UserItem <> nil then begin
                nCode:= 5;
                CopyStdItemToOStdItem(StdItem, @OClientItem.s);
                nCode:= 6;
                OClientItem.Dura := UserItem.Dura;
                OClientItem.DuraMax := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
                OClientItem.MakeIndex := UserItem.MakeIndex;
                s1C := s1C + EncodeBuffer(@OClientItem, SizeOf(TOClientItem)) + '/';
                Inc(n18);
                if n18 >= 10 then Break;
              end;
            end;
            Break;
          end;
        end;//for
      end;
      nCode:= 7;
      PlayObject.SendMsg(Self, RM_SENDDETAILGOODSLIST, 0, Integer(Self), n18, nInt, s1C);
    end else begin
      nCode:= 8;
      n18 := 0;
      if m_GoodsList.Count > 0 then begin//20080629
        for I := 0 to m_GoodsList.Count - 1 do begin
          List20 := TList(m_GoodsList.Items[I]);
          if List20 = nil then Continue;
          if List20.Count <= 0 then Continue;
          nCode:= 9;
          UserItem := List20.Items[0];
          if UserItem = nil then Continue;
          nCode:= 10;
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if (StdItem <> nil) and (StdItem.Name = sItemName) then begin
            if (List20.Count - 1) < nInt then begin
              nInt := _MAX(0, List20.Count - 10);
            end;
            nCode:= 11;
            for II := List20.Count - 1 downto 0 do begin
              if List20.Count <= 0 then Break;
              UserItem := List20.Items[II];
              nCode:= 12;
              if CheckIsOKItem(UserItem, 0) then Continue;//����̬��Ʒ 20081009
              nCode:= 13;
              if UserItem <> nil then begin
                nCode:= 14;
                ClientItem.s := StdItem^;
                ClientItem.Dura := UserItem.Dura;
                ClientItem.DuraMax := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
                ClientItem.MakeIndex := UserItem.MakeIndex;
                s1C := s1C + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
                Inc(n18);
                if n18 >= 10 then Break;
              end;
            end;
            Break;
          end;
        end;//for
      end;
      nCode:= 15;
      PlayObject.SendMsg(Self, RM_SENDDETAILGOODSLIST, 0, Integer(Self), n18, nInt, s1C);
    end;
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} TMerchant.ClientGetDetailGoodsList Code:' + IntToStr(nCode));
    end;  
  end;
end;

procedure TMerchant.ClientQuerySellPrice(PlayObject: TPlayObject;
  UserItem: pTUserItem);
var
  nC: Integer;
begin
try
  nC := GetSellItemPrice(GetUserItemPrice(UserItem));
  if (nC >= 0) then begin
    PlayObject.SendMsg(Self, RM_SENDBUYPRICE, 0, nC, 0, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_SENDBUYPRICE, 0, 0, 0, 0, '');
  end;
except
  MainOutMessage('{�쳣} TMerchant.ClientQuerySellPrice');
end;
end;
//ȡ������Ʒ�ļ۸�
function TMerchant.GetSellItemPrice(nPrice: Integer): Integer;
begin
  Result := Round(nPrice / 2.0);
end;
//�ͻ��˳�����Ʒ
function TMerchant.ClientSellItem(PlayObject: TPlayObject; UserItem: pTUserItem): Boolean;
  function sub_4A1C84(UserItem: pTUserItem): Boolean;
  var
    StdItem: pTStdItem;
  begin
    Result := True;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and ((StdItem.StdMode = 25) or (StdItem.StdMode = 30)) then begin
      if UserItem.Dura < 4000 then Result := False;
    end;
  end;
var
  nPrice: Integer;
  StdItem: pTStdItem;
begin
  try
    Result := False;
    nPrice := GetSellItemPrice(GetUserItemPrice(UserItem));
    if (nPrice > 0) and sub_4A1C84(UserItem) then begin
      if PlayObject.IncGold(nPrice) then begin
       { if m_boCastle or g_Config.boGetAllNpcTax then
          UserCastle.IncRateGold(nPrice);  }
        if m_boCastle or g_Config.boGetAllNpcTax then begin
          if m_Castle <> nil then begin
            TUserCastle(m_Castle).IncRateGold(nPrice);
          end else
            if g_Config.boGetAllNpcTax then begin
            g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
          end;
        end;
        PlayObject.SendMsg(Self, RM_USERSELLITEM_OK, 0, PlayObject.m_nGold, 0, 0, '');
        PlayObject.GoldChanged(); //���¿ͻ��˽�� 20080417
        AddItemToGoodsList(UserItem);
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem.NeedIdentify = 1 then
          AddGameDataLog('10' + #9 + PlayObject.m_sMapName + #9 +
            IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
            PlayObject.m_sCharName + #9 + StdItem.Name + #9 +
            IntToStr(UserItem.MakeIndex) + #9 +
            '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
            '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
            '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
            '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
            '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
            IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
            IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
            IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
            IntToStr(UserItem.btValue[14])+ #9 + m_sCharName);
        Result := True;
      end else begin
        PlayObject.SendMsg(Self, RM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
      end;
    end else begin
      PlayObject.SendMsg(Self, RM_USERSELLITEM_FAIL, 0, 0, 0, 0, '');
    end;
  except
    MainOutMessage('{�쳣} TMerchant.ClientSellItem');
  end;
end;
//������Ʒ�����۱���
function TMerchant.AddItemToGoodsList(UserItem: pTUserItem): Boolean;
var
  ItemList: TList;
begin
try
  Result := False;           //����̬��Ʒ 20081010
  if (UserItem.Dura <= 0) or CheckIsOKItem(UserItem,0) then Exit;
  ItemList := GetRefillList(UserItem.wIndex);
  if ItemList = nil then begin
    ItemList := TList.Create;
    m_GoodsList.Add(ItemList);
  end;
  ItemList.Insert(0, UserItem);
  Result := True;
except
  MainOutMessage('{�쳣} TMerchant.AddItemToGoodsList');
end;
end;
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////����/////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
(*//������Ʒ���� �־��Ƿ����0  �۸�������Լ���Ϊ��  ����   //20080416 ȥ����������
procedure TMerchant.ClientGetDetailSellGoodsList(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer); //004A26F0
var
  {I,} II, n18: Integer;
  List20: TList;
  StdItem: pTStdItem;
  ClientItem: TClientItem;
  OClientItem: TOClientItem;
  s1C: string;
  SellOffInfo: pTSellOffInfo;
//  nPrice: Integer;
begin
  if PlayObject.m_nSoftVersionDateEx = 0 then begin
    n18 := 0;
    s1C := '';
    g_SellOffGoodList.GetUserSellOffGoodListByItemName(sItemName, List20);
    if List20 <> nil then begin
      SellOffInfo := List20.Items[0];
      if SellOffInfo = nil then Exit;
      StdItem := UserEngine.GetStdItem(SellOffInfo.UseItems.wIndex);
      if StdItem <> nil then begin
        if (List20.Count - 1) < nInt then begin
          nInt := _MAX(0, List20.Count - 10);
        end;
        for II := List20.Count - 1 downto 0 do begin
          if List20.Count <= 0 then Break;
          SellOffInfo := pTSellOffInfo(List20.Items[II]);
          if SellOffInfo = nil then Continue;
          CopyStdItemToOStdItem(StdItem, @OClientItem.s);
          if CompareText(PlayObject.m_sCharName, SellOffInfo.sCharName) = 0 then begin
            OClientItem.s.Price := -SellOffInfo.nSellGold;
          end else begin
            OClientItem.s.Price := SellOffInfo.nSellGold;
          end;
          OClientItem.Dura := SellOffInfo.UseItems.Dura;
          OClientItem.DuraMax := SellOffInfo.UseItems.DuraMax;
          OClientItem.MakeIndex := SellOffInfo.UseItems.MakeIndex;
          s1C := s1C + EncodeBuffer(@OClientItem, SizeOf(TOClientItem)) + '/';
          Inc(n18);
        end;
      end;
    end;
    PlayObject.SendMsg(Self, RM_SENDSELLOFFITEMLIST, 0, Integer(Self), n18, nInt, s1C);
  end else begin
    n18 := 0;
    s1C := '';
    g_SellOffGoodList.GetUserSellOffGoodListByItemName(sItemName, List20);
    if List20 <> nil then begin
      SellOffInfo := List20.Items[0];
      if SellOffInfo = nil then Exit;
      StdItem := UserEngine.GetStdItem(SellOffInfo.UseItems.wIndex);
      if StdItem <> nil then begin
        if (List20.Count - 1) < nInt then begin
          nInt := _MAX(0, List20.Count - 10);
        end;
        for II := List20.Count - 1 downto 0 do begin
          if List20.Count <= 0 then Break;
          SellOffInfo := List20.Items[II];
          ClientItem.s := StdItem^;
          if SellOffInfo = nil then Continue;
          if CompareText(PlayObject.m_sCharName, SellOffInfo.sCharName) = 0 then begin
            ClientItem.s.Price := -SellOffInfo.nSellGold;
          end else begin
            ClientItem.s.Price := SellOffInfo.nSellGold;
          end;
          ClientItem.Dura := SellOffInfo.UseItems.Dura;
          ClientItem.DuraMax := SellOffInfo.UseItems.DuraMax;
          ClientItem.MakeIndex := SellOffInfo.UseItems.MakeIndex;
          s1C := s1C + EncodeBuffer(@ClientItem, SizeOf(TClientItem)) + '/';
          Inc(n18);
        end;
      end;
    end;
  end;
  PlayObject.SendMsg(Self, RM_SENDSELLOFFITEMLIST, 0, Integer(Self), n18, nInt, s1C);
end;

procedure TMerchant.ClientBuySellOffItem(PlayObject: TPlayObject; sItemName: string;
  nInt: Integer);
var
//  I, II: Integer;
  bo29: Boolean;
//  List20: TList;
//  ItemPrice: pTItemPrice;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  n1C{, nPrice}: Integer;
//  sUserItemName: string;
  SellOffInfo: pTSellOffInfo;
  AddSellOffInfo: pTSellOffInfo;
  OnlinePlayObject: TPlayObject;
begin
  //n1C = 1 ��Ʒ�Ѿ�������  n1C = 2 �޷�Я���������Ʒ n1C = 3 û���㹻��Ԫ��������Ʒ
  bo29 := False;
  n1C := 1;
  if (bo29) then Exit;
  g_SellOffGoodList.GetUserSellOffItem(sItemName, nInt, SellOffInfo, StdItem);
  if (SellOffInfo <> nil) and (StdItem <> nil) then begin
    if PlayObject.IsAddWeightAvailable(StdItem.Weight) then begin
      if CompareText(PlayObject.m_sCharName, SellOffInfo.sCharName) = 0 then begin
        New(UserItem);
        UserItem^ := SellOffInfo.UseItems;
        {UserItem^.MakeIndex := SellOffInfo.UseItems.MakeIndex;
        UserItem^.wIndex := SellOffInfo.UseItems.MakeIndex;
        UserItem^.Dura := SellOffInfo.UseItems.Dura;
        UserItem^.DuraMax := SellOffInfo.UseItems.DuraMax;
        UserItem^.btValue := SellOffInfo.UseItems.btValue; }
        if PlayObject.AddItemToBag(UserItem) then begin
          PlayObject.SendAddItem(UserItem);
          g_SellOffGoodList.DelSellOffItem(UserItem.MakeIndex);
          bo29 := True;
          n1C := 0;
        end else n1C := 2;
      end else
        if (PlayObject.m_nGameGold >= SellOffInfo.nSellGold) and (SellOffInfo.nSellGold > 0) then begin
        New(UserItem);
        UserItem^ := SellOffInfo.UseItems;
        {UserItem.MakeIndex := SellOffInfo.UseItems.MakeIndex;
        UserItem.wIndex := SellOffInfo.UseItems.MakeIndex;
        UserItem.Dura := SellOffInfo.UseItems.Dura;
        UserItem.DuraMax := SellOffInfo.UseItems.DuraMax;
        UserItem.btValue := SellOffInfo.UseItems.btValue; }
        if PlayObject.AddItemToBag(UserItem) then begin
          Dec(PlayObject.m_nGameGold, SellOffInfo.nSellGold);
          PlayObject.SendAddItem(UserItem);
          New(AddSellOffInfo);
          AddSellOffInfo^ := SellOffInfo^;
          {AddSellOffInfo.sCharName := SellOffInfo.sCharName;
          AddSellOffInfo.dSellDateTime := SellOffInfo.dSellDateTime;
          AddSellOffInfo.nSellGold := SellOffInfo.nSellGold;
          AddSellOffInfo.n := SellOffInfo.n;
          AddSellOffInfo.UseItems := SellOffInfo.UseItems;
          AddSellOffInfo.n1 := SellOffInfo.n1;  }
          g_SellOffGoldList.AddItemToSellOffGoldList(AddSellOffInfo);
          g_SellOffGoodList.DelSellOffItem(UserItem.MakeIndex);
          PlayObject.GameGoldChanged;
          OnlinePlayObject := UserEngine.GetPlayObject(SellOffInfo.sCharName);
          if OnlinePlayObject <> nil then begin
            OnlinePlayObject.SysMsg(PlayObject.m_sCharName + ' ��������� ' + sItemName, c_Red, t_Hint);
          end;
          n1C := 0;
        end else n1C := 2;
      end else n1C := 3;
      bo29 := True;
    end else n1C := 2;
  end;
  if n1C = 0 then begin
    PlayObject.SendMsg(Self, RM_SENDBUYSELLOFFITEM_OK, 0, PlayObject.m_nGameGold, nInt, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_SENDBUYSELLOFFITEM_FAIL, 0, n1C, 0, 0, '');
  end;
end;
//�ͻ��˼�����Ʒ
function TMerchant.ClientSellOffItem(PlayObject: TPlayObject;
  SellOffInfo: pTSellOffInfo; sName: string): Boolean;
  function sub_4A1C84(UserItem: pTUserItem): Boolean;
  var
    StdItem: pTStdItem;
  begin
    Result := True;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and ((StdItem.StdMode = 25) or (StdItem.StdMode = 30)) then begin
      if UserItem.Dura < 4000 then Result := False;
    end;
  end;
//var
//  nPrice: Integer;
//  StdItem: pTStdItem;
begin
  Result := False;
  if not CanSellOffItem(sName) then begin
    PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_FAIL, 0, -4, 0, 0, ''); //����������
    Dispose(SellOffInfo);
    Exit;
  end;
  if g_SellOffGoodList.GetUserLimitSellOffCount(SellOffInfo.sCharName) then begin //������������
    PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_FAIL, 0, -3, 0, 0, ''); //������������
    Dispose(SellOffInfo);
    Exit;
  end;
  if sub_4A1C84(@SellOffInfo.UseItems) then begin
    if g_SellOffGoodList.AddItemToSellOffGoodsList(SellOffInfo) then begin
      PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_OK, 0, 0, 0, 0, '');
      //g_SellOffGoodList.SaveSellOffGoodList();
      Result := True;
    end else begin
      PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_FAIL, 0, -1, 0, 0, '');
    end;
  end else begin //004A1EA0
    PlayObject.SendMsg(Self, RM_SENDUSERSELLOFFITEM_FAIL, 0, -2, 0, 0, '');
  end;
end;
///////////////////////////////////////����///////////////////////////////////// *)
//�ͻ���ȡ�����ҩƷ,���춾ҩ(������Ʒ)
procedure TMerchant.ClientMakeDrugItem(PlayObject: TPlayObject; sItemName: string);
  function sub_4A28FC(PlayObject: TPlayObject; sItemName: string): Boolean;
  var
    I, II, n1C: Integer;
    List10: TStringList;
    s20: string;
    List28: TStringList;
    UserItem: pTUserItem;
  begin
    Result := False;
    List10 := GetMakeItemInfo(sItemName);
    if List10 = nil then Exit;
    Result := True;
    if List10.Count > 0 then begin//20080629
      for I := 0 to List10.Count - 1 do begin
        s20 := List10.Strings[I];
        n1C := Integer(List10.Objects[I]);
        if PlayObject.m_ItemList.Count > 0 then begin
          for II := 0 to PlayObject.m_ItemList.Count - 1 do begin
            if UserEngine.GetStdItemName(pTUserItem(PlayObject.m_ItemList.Items[II]).wIndex) = s20 then Dec(n1C);
          end;
        end;
        if n1C > 0 then begin
          Result := False;
          Break;
        end;
      end; // for
    end;
    if Result then begin
      List28 := nil;
      if List10.Count > 0 then begin//20080629
        for I := 0 to List10.Count - 1 do begin
          s20 := List10.Strings[I];
          n1C := Integer(List10.Objects[I]);
          if PlayObject.m_ItemList.Count > 0 then begin//20081008
            for II := PlayObject.m_ItemList.Count - 1 downto 0 do begin
              if n1C <= 0 then Break;
              if PlayObject.m_ItemList.Count <= 0 then Break;
              UserItem := PlayObject.m_ItemList.Items[II];
              if UserItem = nil then Continue;
              if UserEngine.GetStdItemName(UserItem.wIndex) = s20 then begin
                if List28 = nil then List28 := TStringList.Create;
                List28.AddObject(s20, TObject(UserItem.MakeIndex));
                Dispose(UserItem);
                PlayObject.m_ItemList.Delete(II);
                Dec(n1C);
              end;
            end;
          end;
        end;//for
      end;
      if List28 <> nil then begin
        PlayObject.SendMsg(Self, RM_SENDDELITEMLIST, 0, Integer(List28), 0, 0, '');
      end;
    end;
  end;
var
  I: Integer;
  List1C: TList;
  MakeItem, UserItem: pTUserItem;
  StdItem: pTStdItem;
  n14: Integer;
begin
try
  n14 := 1;
  if m_GoodsList.Count > 0 then begin//20080629
    for I := 0 to m_GoodsList.Count - 1 do begin
      List1C := TList(m_GoodsList.Items[I]);
      if List1C = nil then Continue;
      if List1C.Count <= 0 then Continue;
      MakeItem := List1C.Items[0];
      if MakeItem = nil then Continue;
      StdItem := UserEngine.GetStdItem(MakeItem.wIndex);
      if (StdItem <> nil) and (StdItem.Name = sItemName) then begin
        if PlayObject.m_nGold >= g_Config.nMakeDurgPrice then begin
          if sub_4A28FC(PlayObject, sItemName) then begin
            New(UserItem);
            UserEngine.CopyToUserItemFromName(sItemName, UserItem);
            PlayObject.ClearCopyItem(0, UserItem.wIndex, UserItem.MakeIndex);//��������Ͳֿ⸴����Ʒ 20080816
            if PlayObject.AddItemToBag(UserItem) then begin
              Dec(PlayObject.m_nGold, g_Config.nMakeDurgPrice);
              PlayObject.SendAddItem(UserItem);
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('2' + #9 + PlayObject.m_sMapName + #9 +
                  IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
                  PlayObject.m_sCharName + #9 + StdItem.Name + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                  '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                  '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                  '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                  '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                  IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                  IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                  IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                  IntToStr(UserItem.btValue[14])+ #9 + m_sCharName);
              n14 := 0;
              Break;
            end else begin
              Dispose(UserItem);
              n14 := 2;
            end;
          end else n14 := 4;
        end else n14 := 3;
      end;
    end; // for
  end;
  if n14 = 0 then begin
    PlayObject.SendMsg(Self, RM_MAKEDRUG_SUCCESS, 0, PlayObject.m_nGold, 0, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_MAKEDRUG_FAIL, 0, n14, 0, 0, '');
  end;
except
  MainOutMessage('{�쳣} TMerchant.ClientMakeDrugItem');
end;
end;
//�ͻ���ѯ�޸�����ɱ�
procedure TMerchant.ClientQueryRepairCost(PlayObject: TPlayObject; UserItem: pTUserItem);
var
  nPrice, nRepairPrice: Integer;
begin
try
  nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
  if (nPrice > 0) and (UserItem.DuraMax > UserItem.Dura) then begin
    if UserItem.DuraMax > 0 then begin
      nRepairPrice := Round(nPrice div 3 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
    end else begin
      nRepairPrice := nPrice;
    end;
    if (PlayObject.m_sScriptLable = sSUPERREPAIR) then begin
      if m_boS_repair then nRepairPrice := nRepairPrice * g_Config.nSuperRepairPriceRate {3}
      else nRepairPrice := -1;
    end else begin
      if not m_boRepair then nRepairPrice := -1;
    end;
    PlayObject.SendMsg(Self, RM_SENDREPAIRCOST, 0, nRepairPrice, 0, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_SENDREPAIRCOST, 0, -1, 0, 0, '');
  end;
except
  MainOutMessage('{�쳣} TMerchant.ClientQueryRepairCost');
end;
end;
//������Ʒ
function TMerchant.ClientRepairItem(PlayObject: TPlayObject; UserItem: pTUserItem): Boolean;
var
  nPrice, nRepairPrice: Integer;
  StdItem: pTStdItem;
  boCanRepair: Boolean;
begin
try
  Result := False;
  boCanRepair := True;
  if (PlayObject.m_sScriptLable = sSUPERREPAIR) and not m_boS_repair then begin
    boCanRepair := False;
  end;
  if (PlayObject.m_sScriptLable <> sSUPERREPAIR) and not m_boRepair then begin
    boCanRepair := False;
  end;
  if PlayObject.m_sScriptLable = '@fail_s_repair' then begin
    SendMsgToUser(PlayObject, '�Բ���, �Ҳ����޸������Ʒ\ \ \<Main/@main>');
    PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
    Exit;
  end;
  nPrice := GetUserPrice(PlayObject, GetUserItemPrice(UserItem));
  if PlayObject.m_sScriptLable = sSUPERREPAIR then begin
    nPrice := nPrice * g_Config.nSuperRepairPriceRate {3};
  end;
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem <> nil then begin
    if boCanRepair and (nPrice > 0) and (UserItem.DuraMax > UserItem.Dura) and (StdItem.StdMode <> 43) then begin
      if UserItem.DuraMax > 0 then begin
        nRepairPrice := Round(nPrice div 3 / UserItem.DuraMax * (UserItem.DuraMax - UserItem.Dura));
      end else begin
        nRepairPrice := nPrice;
      end;
      if PlayObject.DecGold(nRepairPrice) then begin
        //if m_boCastle or g_Config.boGetAllNpcTax then UserCastle.IncRateGold(nRepairPrice);
        if m_boCastle or g_Config.boGetAllNpcTax then begin
          if m_Castle <> nil then begin
            TUserCastle(m_Castle).IncRateGold(nRepairPrice);
          end else
            if g_Config.boGetAllNpcTax then begin
            g_CastleManager.IncRateGold(g_Config.nUpgradeWeaponPrice);
          end;
        end;
        if PlayObject.m_sScriptLable = sSUPERREPAIR then begin
          UserItem.Dura := UserItem.DuraMax;
          PlayObject.SendMsg(Self, RM_USERREPAIRITEM_OK, 0, PlayObject.m_nGold, UserItem.Dura, UserItem.DuraMax, '');
          PlayObject.GoldChanged(); //���¿ͻ��˽�� 20080417
          GotoLable(PlayObject, sSUPERREPAIROK, False);
        end else begin
          Dec(UserItem.DuraMax, (UserItem.DuraMax - UserItem.Dura) div g_Config.nRepairItemDecDura {30});
          UserItem.Dura := UserItem.DuraMax;
          PlayObject.SendMsg(Self, RM_USERREPAIRITEM_OK, 0, PlayObject.m_nGold, UserItem.Dura, UserItem.DuraMax, '');
          PlayObject.GoldChanged(); //���¿ͻ��˽�� 20080417
          GotoLable(PlayObject, sREPAIROK, False);
        end;
        Result := True;
      end else PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
    end else PlayObject.SendMsg(Self, RM_USERREPAIRITEM_FAIL, 0, 0, 0, 0, '');
  end;
except
  MainOutMessage('{�쳣} TMerchant.ClientRepairItem');
end;
end;

procedure TMerchant.ClearScript;
begin
  m_boBuy := False;
  m_boSell := False;
  m_boMakeDrug := False;
  m_boPrices := False;
  m_boStorage := False;
  m_boGetback := False;
  m_boBigStorage := False;
  m_boBigGetBack := False;
  m_boGetNextPage := False;
  m_boGetPreviousPage := False;
  m_boCqFirHero := False;
  m_boBuHero := False;//20080514
  m_boPlayMakeWine:= False;//���NPC 20080619
  m_boUserLevelOrder := False;
  m_boWarrorLevelOrder := False;
  m_boWizardLevelOrder := False;
  m_boTaoistLevelOrder := False;
  m_boMasterCountOrder := False;

  m_boUpgradenow := False;
  m_boGetBackupgnow := False;
  m_boRepair := False;
  m_boS_repair := False;
  m_boGetMarry := False;
  m_boGetMaster := False;
  m_boUseItemName := False;

  //m_boGetSellGold := False;//20080416 ȥ����������
  //m_boSellOff := False;//20080416 ȥ����������
  //m_boBuyOff := False;//20080416 ȥ����������
  m_boofflinemsg := False;
  m_boDealGold := False;
  inherited;
end;

procedure TMerchant.LoadUpgradeList;
var
  I: Integer;
begin
  try
    if m_UpgradeWeaponList.Count > 0 then begin//20080629
      for I := 0 to m_UpgradeWeaponList.Count - 1 do begin
        if pTUpgradeInfo(m_UpgradeWeaponList.Items[I]) <> nil then
          Dispose(pTUpgradeInfo(m_UpgradeWeaponList.Items[I]));
      end; // for
    end;
    m_UpgradeWeaponList.Clear;

    FrmDB.LoadUpgradeWeaponRecord(m_sScript + '-' + m_sMapName, m_UpgradeWeaponList);
  except
    MainOutMessage('��ȡ���������б�ʧ�� - ' + m_sCharName);
  end;
end;
{δʹ�� 20080411
procedure TMerchant.GetMarry(PlayObject: TPlayObject; sDearName: string);
var
  MarryHuman: TPlayObject;
begin
  MarryHuman := UserEngine.GetPlayObject(sDearName);
  if (MarryHuman <> nil) and
    (MarryHuman.m_PEnvir = PlayObject.m_PEnvir) and
    (abs(PlayObject.m_nCurrX - MarryHuman.m_nCurrX) < 5) and
    (abs(PlayObject.m_nCurrY - MarryHuman.m_nCurrY) < 5) then begin
    SendMsgToUser(MarryHuman, PlayObject.m_sCharName + ' ������飬���Ƿ�Ը��޸���Ϊ�ޣ�');
  end else begin
    Self.SendMsgToUser(PlayObject, sDearName + ' û��������ߣ����������Ч������');
  end;
end; }
{δʹ�� 20080411
procedure TMerchant.GetMaster(PlayObject: TPlayObject; sMasterName: string);
begin

end;}

procedure TMerchant.SendCustemMsg(PlayObject: TPlayObject; sMsg: string);
begin
  inherited;
end;

//�����ʱ�ļ����������׿�棬�۸��
procedure TMerchant.ClearData;
var
  I, II: Integer;
  UserItem: pTUserItem;
  ItemList: TList;
  ItemPrice: pTItemPrice;
resourcestring
  sExceptionMsg = '{�쳣} TMerchant::ClearData';
begin
  try
    if m_GoodsList.Count > 0 then begin//20080629
      for I := 0 to m_GoodsList.Count - 1 do begin
        ItemList := TList(m_GoodsList.Items[I]);
        if ItemList = nil then Continue;
        if ItemList.Count > 0 then begin//20080627
          for II := 0 to ItemList.Count - 1 do begin
            UserItem := ItemList.Items[II];
            if UserItem <> nil then Dispose(UserItem);
          end;
        end;
        ItemList.Free;
      end;//for
    end;
    m_GoodsList.Clear;
    if m_ItemPriceList.Count > 0 then begin//20080627
      for I := 0 to m_ItemPriceList.Count - 1 do begin
        ItemPrice := m_ItemPriceList.Items[I];
        if ItemPrice <> nil then Dispose(ItemPrice);
      end;
    end;
    m_ItemPriceList.Clear;
    SaveNPCData();
  except
    on E: Exception do begin
      MainOutMessage(sExceptionMsg);
      //MainOutMessage(E.Message);
    end;
  end;
end;

procedure TMerchant.ChangeUseItemName(PlayObject: TPlayObject; sLabel, sItemName: string);
var
  sWhere: string;
  btWhere: Byte;
  UserItem: pTUserItem;
  sMsg: string;
  sChangeUseItemName: string;
begin
  try
    if not PlayObject.m_boChangeItemNameFlag then begin
      Exit;
    end;
    PlayObject.m_boChangeItemNameFlag := False;
    sWhere := Copy(sLabel, 14{Length(sUSEITEMNAME) + 1}, Length(sLabel) - 13{Length(sUSEITEMNAME)});
    btWhere := Str_ToInt(sWhere, -1);
    if btWhere in [Low(THumanUseItems)..High(THumanUseItems)] then begin
      UserItem := @PlayObject.m_UseItems[btWhere];
      if UserItem.wIndex = 0 then begin
        sMsg := Format(g_sYourUseItemIsNul, [GetUseItemName(btWhere)]);
        PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, sMsg);
        Exit;
      end;
      if UserItem.btValue[13] = 1 then begin
        ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
      end;
      if sItemName <> '' then begin
        if g_Config.boChangeUseItemNameByPlayName then begin
          sChangeUseItemName := PlayObject.m_sCharName + '��' + sItemName;
        end else begin
          sChangeUseItemName := g_Config.sChangeUseItemName + sItemName;
        end;
        ItemUnit.AddCustomItemName(UserItem.MakeIndex, UserItem.wIndex, sChangeUseItemName);
        UserItem.btValue[13] := 1;
      end else begin
        ItemUnit.DelCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
        UserItem.btValue[13] := 0;
      end;
      ItemUnit.SaveCustomItemName();
      PlayObject.SendMsg(PlayObject, RM_SENDUSEITEMS, 0, 0, 0, 0, '');
      PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, '');
    end;
  except
    MainOutMessage('{�쳣} TMerchant.ChangeUseItemName');
  end;
end;

{ TTrainer ����ʦ}

constructor TTrainer.Create;
begin
  inherited;
  m_dw568 := GetTickCount();
  m_btAntiPoison := 0;//20080826 ����
  n56C := 0;
  n570 := 0;
end;

destructor TTrainer.Destroy;
begin
  inherited;
end;

function TTrainer.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  try
    Result := False;
    if (ProcessMsg.wIdent = RM_STRUCK) or (ProcessMsg.wIdent = RM_MAGSTRUCK) then begin
    //if (ProcessMsg.wIdent = RM_10101) or (ProcessMsg.wIdent = RM_MAGSTRUCK) then begin
      if (ProcessMsg.BaseObject = Self) { and (ProcessMsg.nParam3 <> 0)} then begin
        Inc(n56C, ProcessMsg.wParam);
        m_dw568 := GetTickCount();
        Inc(n570);
        ProcessSayMsg('�ƻ���Ϊ ' + IntToStr(ProcessMsg.wParam) + ',ƽ��ֵΪ ' + IntToStr(n56C div n570));
      end;
    end;
    if ProcessMsg.wIdent = RM_MAGSTRUCK then Result := inherited Operate(ProcessMsg);
  except
    MainOutMessage('{�쳣} TTrainer.Operate');
  end;
end;

procedure TTrainer.Run;
begin
  m_WAbil.HP := m_WAbil.MaxHP;
  if n570 > 0 then begin
    if (GetTickCount - m_dw568) > 3000{3 * 1000} then begin
      ProcessSayMsg('���ƻ���Ϊ  ' + IntToStr(n56C) + ',ƽ��ֵΪ ' + IntToStr(n56C div n570));
      n570 := 0;
      n56C := 0;
    end;
  end;
  inherited;
end;
{ TNormNpc }

procedure TNormNpc.ActionOfAddNameDateList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  boFound: Boolean;
  sListFileName, sLineText, sHumName, sDate: string;
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('�ļ���ȡʧ��.... => ' + sListFileName);
    end;
  end;
  try
    boFound := False;
    if LoadList.Count > 0 then begin//20080629
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := Trim(LoadList.Strings[I]);
        sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
        if CompareText(sHumName, PlayObject.m_sCharName) = 0 then begin
          LoadList.Strings[I] := PlayObject.m_sCharName + #9 + DateToStr(Date);
          boFound := True;
          Break;
        end;
      end;
    end;
    if not boFound then LoadList.Add(PlayObject.m_sCharName + #9 + DateToStr(Date));

    LoadList.SaveToFile(sListFileName);
  except
    MainOutMessage('�ļ�����ʧ�� => ' + sListFileName);
  end;
  LoadList.Free;
end;

procedure TNormNpc.ActionOfDelNameDateList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  sLineText, sListFileName, sHumName, sDate: string;
  boFound: Boolean;
begin
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam1;
  LoadList := TStringList.Create;
  if FileExists(sListFileName) then begin
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('�ļ���ȡʧ��.... => ' + sListFileName);
      LoadList.Free;
      Exit;
    end;
  end;
  boFound := False;
  if LoadList.Count > 0 then begin//20080629
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
      if CompareText(sHumName, PlayObject.m_sCharName) = 0 then begin
        LoadList.Delete(I);
        boFound := True;
        Break;
      end;
    end;
  end;
  if boFound then begin
    try
      LoadList.SaveToFile(sListFileName);
    except
      MainOutMessage('�ļ�����ʧ��  => ' + sListFileName);
    end;
  end;
  LoadList.Free;
end;
//���ܣ��ű����Ӽ��ܡ�
//��ʽ��ADDSKILL �������� ���ܵȼ� HERO  (�Ӳ���HERO,��������Ӣ�ۼ���)
procedure TNormNpc.ActionOfAddSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
begin
try
  nLevel := _MIN(3, Str_ToInt(QuestActionInfo.sParam2, 0));
  if CompareText(QuestActionInfo.sParam3, 'HERO') = 0 then begin
    if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDSKILL);
      Exit;
    end;
    Magic := UserEngine.FindHeroMagic(QuestActionInfo.sParam1);
    if Magic <> nil then begin
      if PlayObject.m_MyHero <> nil then begin
        if not PlayObject.m_MyHero.IsTrainingSkill(Magic.wMagicId) then begin
          if (Magic.sDescr = '�ڹ�') and (not THeroObject(PlayObject.m_MyHero).m_boTrainingNG) then Exit;//û���ڹ��ķ�,����ѧ�ڹ����� 20081001
          New(UserMagic);
          UserMagic.MagicInfo := Magic;
          UserMagic.wMagIdx := Magic.wMagicId;
          UserMagic.btKey := 0;
          UserMagic.btLevel := nLevel;
          UserMagic.nTranPoint := 0;
          PlayObject.m_MyHero.m_MagicList.Add(UserMagic);
          THeroObject(PlayObject.m_MyHero).SendAddMagic(UserMagic);
          THeroObject(PlayObject.m_MyHero).RecalcAbilitys();//20081213 �޸�
          PlayObject.m_MyHero.CompareSuitItem(False);//200080729 ��װ
          PlayObject.HeroAddSkillFunc(Magic.wMagicId);//Ӣ��ѧ���ܴ���  20080828
          if g_Config.boShowScriptActionMsg then begin
            THeroObject(PlayObject.m_MyHero).SysMsg('[Ӣ��] '+Magic.sMagicName + '��ϰ�ɹ���', c_Green, t_Hint);
          end;
        end;
      end else begin

      end;
    end else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDSKILL);
    end;
  end else begin
    Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
    if Magic <> nil then begin
      if not PlayObject.IsTrainingSkill(Magic.wMagicId) then begin
        if (Magic.sDescr = '�ڹ�') and (not PlayObject.m_boTrainingNG) then Exit;//û���ڹ��ķ�,����ѧ�ڹ����� 20081001
        New(UserMagic);
        UserMagic.MagicInfo := Magic;
        UserMagic.wMagIdx := Magic.wMagicId;
        UserMagic.btKey := 0;
        UserMagic.btLevel := nLevel;
        UserMagic.nTranPoint := 0;
        PlayObject.m_MagicList.Add(UserMagic);
        PlayObject.SendAddMagic(UserMagic);
        PlayObject.RecalcAbilitys();
        PlayObject.CompareSuitItem(False);//200080828 ��װ
        PlayObject.AddSkillFunc(Magic.wMagicId);//����ѧ���ܴ���  20080828
        if g_Config.boShowScriptActionMsg then begin
          PlayObject.SysMsg(Magic.sMagicName + '��ϰ�ɹ���', c_Green, t_Hint);
        end;
      end;
    end else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDSKILL);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfAddSkill');
end;
end;

//���ܣ�����л��Ա  20080427
//��ʽ��ADDGUILDMEMBER �л����� ��������
procedure TNormNpc.ActionOfADDGUILDMEMBER(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sGuildName,UserName:String;
  Guild: TGuild;
  PlayHum: TPlayObject;
begin
try
  sGuildName:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);
  UserName:= GetLineVariableText(PlayObject, QuestActionInfo.sParam2);
  if (sGuildName = '') or (UserName = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDGUILDMEMBER);
    Exit;
  end;

  PlayHum := UserEngine.GetPlayObject(UserName);
  Guild:= g_GuildManager.FindGuild(sGuildName);
  if Guild <> nil then begin
    if (PlayHum <> nil) and (not PlayHum.m_boNotOnlineAddExp){ and (PlayHum.m_boAllowGuild) }then begin //�������,�������߹һ�,��������л�
      if not Guild.IsMember(UserName) then begin //�����л��Ա
        if (PlayHum.m_MyGuild = nil) and (Guild.m_RankList.Count < Guild.m_nGuildMemberCount) then begin//����û���л�,����Ҫ������л���Աû����
           Guild.AddMember(PlayHum);
           UserEngine.SendServerGroupMsg(SS_207, nServerIndex, Guild.sGuildName);
           PlayHum.m_MyGuild := Guild;
           PlayHum.m_sGuildRankName := Guild.GetRankName(PlayHum, PlayHum.m_nGuildRankNo);
           PlayHum.RefShowName();
           PlayHum.SysMsg('���Ѽ����л�: ' + Guild.sGuildName + ' ��ǰ���Ϊ: ' + PlayHum.m_sGuildRankName, c_Green, t_Hint);
        end;
      end;
    end;
  end else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ADDGUILDMEMBER);
    Exit;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfADDGUILDMEMBER');
end;
end;

//���ܣ�ɾ���л��Ա��ɾ��������Ч��//20080427
//��ʽ��DELGUILDMEMBER �л����� ��������
procedure TNormNpc.ActionOfDELGUILDMEMBER(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sGuildName,UserName:String;
  Guild: TGuild;
  PlayHum: TPlayObject;
begin
try
  sGuildName:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);
  UserName:= GetLineVariableText(PlayObject, QuestActionInfo.sParam2);
  if (sGuildName = '') or (UserName = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELGUILDMEMBER);
    Exit;
  end;

  PlayHum := UserEngine.GetPlayObject(UserName);
  Guild:= g_GuildManager.FindGuild(sGuildName);
  if Guild <> nil then begin
    if (PlayHum <> nil) and (not PlayHum.m_boNotOnlineAddExp){ and (PlayHum.m_boAllowGuild) }then begin //�������,�������߹һ�,��������л�
      if Guild.IsMember(UserName) and (PlayHum.m_nGuildRankNo <> 1) then begin //���л��Ա
        if Guild.DelMember(UserName) then begin
          PlayHum.m_MyGuild := nil;
          PlayHum.RefRankInfo(0, '');
          PlayHum.RefShowName();
          UserEngine.SendServerGroupMsg(SS_207, nServerIndex, Guild.sGuildName);
        end;
      end;
    end;
  end else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELGUILDMEMBER);
    Exit;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfDELGUILDMEMBER');
end;
end;

procedure TNormNpc.ActionOfAutoAddGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
begin
try
  if CompareText(QuestActionInfo.sParam1, 'START') = 0 then begin
    if (nPoint > 0) and (nTime > 0) then begin
      PlayObject.m_nIncGameGold := nPoint;
      PlayObject.m_dwIncGameGoldTime := LongWord(nTime * 1000);
      PlayObject.m_dwIncGameGoldTick := GetTickCount();
      PlayObject.m_boIncGameGold := True;
      Exit;
    end;
  end;
  if CompareText(QuestActionInfo.sParam1, 'STOP') = 0 then begin
    PlayObject.m_boIncGameGold := False;
    Exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOADDGAMEGOLD);
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfAutoAddGameGold');
end;
end;

//SETAUTOGETEXP ʱ�� ���� �Ƿ�ȫ�� ��ͼ��
procedure TNormNpc.ActionOfAutoGetExp(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nTime, nPoint: Integer;
  boIsSafeZone: Boolean;
  sMAP: string;
  Envir: TEnvirnoment;
begin
  try
    Envir := nil;
    nTime := Str_ToInt(QuestActionInfo.sParam1, -1);
    nPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
    boIsSafeZone := QuestActionInfo.sParam3[1] = '1';
    sMAP := QuestActionInfo.sParam4;
    if sMAP <> '' then begin
      Envir := g_MapManager.FindMap(sMAP);
    end;
    if (nTime <= 0) or (nPoint <= 0) or ((sMAP <> '') and (Envir = nil)) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETAUTOGETEXP);
      Exit;
    end;
    PlayObject.m_boAutoGetExpInSafeZone := boIsSafeZone;
    PlayObject.m_AutoGetExpEnvir := Envir;
    PlayObject.m_nAutoGetExpTime := nTime * 1000;
    PlayObject.m_nAutoGetExpPoint := nPoint;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfAutoGetExp');
  end;
end;

procedure TNormNpc.ActionOfAutoSubGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nPoint, nTime: Integer);
begin
try
  if CompareText(QuestActionInfo.sParam1, 'START') = 0 then begin
    if (nPoint > 0) and (nTime > 0) then begin
      PlayObject.m_nDecGameGold := nPoint;
      PlayObject.m_dwDecGameGoldTime := LongWord(nTime * 1000);
      PlayObject.m_dwDecGameGoldTick := 0;
      PlayObject.m_boDecGameGold := True;
      Exit;
    end;
  end;
  if CompareText(QuestActionInfo.sParam1, 'STOP') = 0 then begin
    PlayObject.m_boDecGameGold := False;
    Exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AUTOSUBGAMEGOLD);
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfAutoSubGameGold');
end;
end;

//����:��·��ʯ 20081019
//��ʽ:TAGMAPINFO ��·(1-6)
procedure TNormNpc.ActionOfTAGMAPINFO(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTpye, I:Byte;
  IniFile: TIniFile;//Ini�ļ�
  sFileName: String;
begin
try
  nTpye:= QuestActionInfo.nParam1;
  if (nTpye <= 0) or (nTpye > 6) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAGMAPINFO);
    Exit;
  end;
  PlayObject.m_TagMapInfos[nTpye].TagMapName:= PlayObject.m_sMapName;
  PlayObject.m_TagMapInfos[nTpye].TagX:= PlayObject.m_nCurrX;
  PlayObject.m_TagMapInfos[nTpye].TagY:= PlayObject.m_nCurrY;
  //���浽�ļ���
  sFileName :=  g_Config.sEnvirDir + 'UserData';
  if not DirectoryExists(sFileName) then CreateDir(sFileName); //Ŀ¼������,�򴴽�
  sFileName := sFileName+'\HumRecallPoint.txt';
  IniFile := TIniFile.Create(sFileName);
  Try
    for I:= 1 to 6 do begin
      IniFile.Writestring(PlayObject.m_sCharName,'��¼'+inttostr(I),
                         PlayObject.m_TagMapInfos[I].TagMapName+','+
                         IntToStr(PlayObject.m_TagMapInfos[I].TagX)+','+
                         IntToStr(PlayObject.m_TagMapInfos[I].TagY));
    end;
  finally
    IniFile.Free;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfTAGMAPINFO');
end;
end;

//����:�ƶ�����·��ʯ��¼�ĵ�ͼXY  20081019
//��ʽ: TAGMAPMOVE ��·(1-6)
procedure TNormNpc.ActionOfTAGMAPMOVE(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTpye:Byte;
  Envir: TEnvirnoment;
begin
try
  nTpye:= QuestActionInfo.nParam1;
  if (nTpye <= 0) or (nTpye > 6) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAGMAPMOVE);
    Exit;
  end;

  if (PlayObject.m_TagMapInfos[nTpye].TagX <> 0) or (PlayObject.m_TagMapInfos[nTpye].TagY <> 0) then begin
    Envir := g_MapManager.FindMap(PlayObject.m_TagMapInfos[nTpye].TagMapName);
    if Envir <> nil then begin
      if Envir.CanWalk(PlayObject.m_TagMapInfos[nTpye].TagX, PlayObject.m_TagMapInfos[nTpye].TagY, True) then begin
        PlayObject.SpaceMove(PlayObject.m_TagMapInfos[nTpye].TagMapName, PlayObject.m_TagMapInfos[nTpye].TagX, PlayObject.m_TagMapInfos[nTpye].TagY, 0);
      end else begin
        PlayObject.SysMsg(Format(g_sGameCommandPositionMoveCanotMoveToMap1,
                         [PlayObject.m_TagMapInfos[nTpye].TagMapName, PlayObject.m_TagMapInfos[nTpye].TagX, PlayObject.m_TagMapInfos[nTpye].TagY]), c_Green, t_Hint);
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfTAGMAPMOVE');
end;
end;
//���ܣ������л��Ա����
//��ʽ��CHANGEGUILDMEMBERCOUNT +\-\= ����(65535)
procedure TNormNpc.ActionOfCHANGEGUILDMEMBERCOUNT(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMemberCount: Integer;
  cMethod: Char;
begin
  try
    nMemberCount:=Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),-1);
    if (nMemberCount < 0) or (nMemberCount > 65535) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGUILDMEMBERCOUNT);
      Exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    if PlayObject.m_MyGuild <> nil then begin
      case cMethod of
        '=': begin
            if nMemberCount >= 0 then begin
              TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount := nMemberCount;
              TGUild(PlayObject.m_MyGuild).SaveGuildInfoFile;//�����л��ļ�
            end;
          end;
        '-': begin
            if TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount > nMemberCount then begin
              Dec(TGUild(PlayObject.m_MyGuild).m_nGuildFountain, nMemberCount);
            end else begin
              TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount := 0;
            end;
            TGUild(PlayObject.m_MyGuild).SaveGuildInfoFile;//�����л��ļ�
          end;
        '+': begin
            if TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount + nMemberCount > High(Word) then begin
              TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount:= High(Word);
            end else Inc(TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount, nMemberCount);
            TGUild(PlayObject.m_MyGuild).SaveGuildInfoFile;//�����л��ļ�
          end;
      else begin
          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGUILDMEMBERCOUNT);
          Exit;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfCHANGEGUILDMEMBERCOUNT');
  end;
end;

//���ܣ��л��Ȫ���ݵĵ���
//��ʽ��CHANGEGUILDFOUNTAIN +\-\= ����
procedure TNormNpc.ActionOfCHANGEGUILDFOUNTAIN(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPoint: Integer;
  cMethod: Char;
begin
try
  nPoint:=Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),-1);
  if (nPoint < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGUILDFOUNTAIN);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  if PlayObject.m_MyGuild <> nil then begin
    //if TGUild(PlayObject.m_MyGuild).boGuildFountainOpen then begin//�л�Ȫˮ�ֿ⿪��
      case cMethod of
        '=': begin
            if nPoint >= 0 then begin
              TGUild(PlayObject.m_MyGuild).m_nGuildFountain := nPoint;
              TGUild(PlayObject.m_MyGuild).SaveGuildInfoFile;//�����л��ļ� 20090101
            end;
          end;
        '-': begin
            if TGUild(PlayObject.m_MyGuild).m_nGuildFountain > nPoint then begin
              Dec(TGUild(PlayObject.m_MyGuild).m_nGuildFountain, nPoint);
            end else begin
              TGUild(PlayObject.m_MyGuild).m_nGuildFountain := 0;
            end;
            TGUild(PlayObject.m_MyGuild).SaveGuildInfoFile;//�����л��ļ� 20090101
          end;
        '+': begin
            Inc(TGUild(PlayObject.m_MyGuild).m_nGuildFountain, nPoint);
            TGUild(PlayObject.m_MyGuild).SaveGuildInfoFile;//�����л��ļ� 20090101
          end;
      else begin
          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGUILDFOUNTAIN);
          Exit;
        end;
      end;

    //end else GotoLable(PlayObject, '@GIVEFOUNTAINColse', False);//�л��Ȫ�ر�
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfCHANGEGUILDFOUNTAIN');
end;
end;

//�������� 20080118
procedure TNormNpc.ActionOfChangeCreditPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nCreditPoint: Integer;
  cMethod: Char;
begin
try
  nCreditPoint:=Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),-1);//20080430

  if (nCreditPoint < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nCreditPoint)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREDITPOINT);
    Exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if nCreditPoint >= 0 then PlayObject.m_btCreditPoint := nCreditPoint;
      end;
    '-': begin
        if PlayObject.m_btCreditPoint > nCreditPoint then begin
          Dec(PlayObject.m_btCreditPoint, nCreditPoint);
        end else begin
          PlayObject.m_btCreditPoint := 0;
        end;
      end;
    '+': begin
          Inc(PlayObject.m_btCreditPoint, nCreditPoint);
      end;
  else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREDITPOINT);
      Exit;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfChangeCreditPoint');
end;
end;

//��������ֵ 20080511
procedure TNormNpc.ActionOfChangeCreditGlory(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGameGlory: Integer;
  nOldGameGlory: Integer;
  cMethod: Char;
begin
  try
    nOldGameGlory := PlayObject.m_btGameGlory;
    nGameGlory:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),-1);//20080430
    if (nGameGlory < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nGameGlory)) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEGLORY);
      Exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=': begin
          if (nGameGlory >= 0) then begin
            //nGameGlory := _MIN(High(PlayObject.m_btGameGlory), nGameGlory);//20080512 //20080809 �޸�
            PlayObject.m_btGameGlory := nGameGlory;
          end;
        end;
      '-': begin
          //nGameGlory := _MAX(0, PlayObject.m_btGameGlory - nGameGlory);
          //nGameGlory := _MIN(High(PlayObject.m_btGameGlory), nGameGlory);//20080512
          //PlayObject.m_btGameGlory := nGameGlory;
          PlayObject.m_btGameGlory := _MAX(0, PlayObject.m_btGameGlory - nGameGlory); //20080809 �޸�
        end;
      '+': begin
          //nGameGlory := _MAX(0, PlayObject.m_btGameGlory + nGameGlory);
          //nGameGlory := _MIN(High(PlayObject.m_btGameGlory), nGameGlory);//20080512
          //PlayObject.m_btGameGlory := nGameGlory;
          PlayObject.m_btGameGlory := _MIN(High(PlayObject.m_btGameGlory), PlayObject.m_btGameGlory + nGameGlory); //20080809 �޸�
        end;
    end;
    //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
    if g_boGameLogGameGlory then begin
      AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GameGlory,
        PlayObject.m_sMapName,
          PlayObject.m_nCurrX,
          PlayObject.m_nCurrY,
          PlayObject.m_sCharName,
          g_Config.sGameGlory,
          PlayObject.m_btGameGlory,
          cMethod+'('+inttostr(nGameGlory)+')',
          m_sCharName]));
    end;
    if nOldGameGlory <> PlayObject.m_btGameGlory then PlayObject.GameGloryChanged;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfChangeCreditGlory');
  end;
end;

//�������� Ӣ�۴���,�򰴱���־����Ӣ��  20080320
procedure TNormNpc.ActionOfChangeExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nExp: LongWord;//20081229 �޸�
  cMethod: Char;
  dwInt: LongWord;
  nCode:Byte;//20081109
begin
  nCode:= 0;
  Try
    if PlayObject = nil then Exit;//20081109
    nCode:= 1;
    nExp:= Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1); //20080430
    if (nExp < 0) {and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nExp))} then begin //20081229
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEEXP);
      Exit;
    end;
    nCode:= 2;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=': begin
          nCode:= 3;
          if nExp >= 0 then begin
            if PlayObject.m_Abil.Level < g_Config.nLimitExpLevel then begin//�Ƿ񳬹����Ƶȼ�20080715
              nCode:= 4;
              PlayObject.m_Abil.Exp := LongWord(nExp);
            end else begin
              nCode:= 5;
              PlayObject.m_Abil.Exp := g_Config.nLimitExpValue;
            end;
          end;
        end;
      '-': begin
          nCode:= 6;
          if PlayObject.m_Abil.Exp > LongWord(nExp) then begin
            nCode:= 7;
            Dec(PlayObject.m_Abil.Exp, LongWord(nExp));
          end else begin
            nCode:= 8;
            PlayObject.m_Abil.Exp := 0;
          end;
        end;
      '+': begin
          nCode:= 9;
          if PlayObject.m_Abil.Level < g_Config.nLimitExpLevel then begin//�Ƿ񳬹����Ƶȼ�
            nCode:= 10;
            dwInt := LongWord(nExp);
            if PlayObject.m_Abil.Exp >= LongWord(nExp) then begin//20090101
              if (High(LongWord) - PlayObject.m_Abil.Exp) < LongWord(nExp) then begin
                dwInt := High(LongWord) - PlayObject.m_Abil.Exp;
              end;
            end else begin
               if (High(LongWord) - LongWord(nExp)) < PlayObject.m_Abil.Exp then begin
                dwInt := High(LongWord) - LongWord(nExp);
               end;
            end;
          end else dwInt := g_Config.nLimitExpValue;

          nCode:= 11;
          PlayObject.GetExpToItem(dwInt);
          nCode:= 12;
          if PlayObject.m_MyHero <> nil then begin
            nCode:= 13;
            THeroObject(PlayObject.m_MyHero).GetExp(abs(Round((g_Config.nHeroNoKillMonExpRate / 100) * dwInt)));//20081018 �޸�
            nCode:= 14;
            dwInt:= abs(Round(((100 - g_Config.nHeroNoKillMonExpRate) / 100) * dwInt));//20081018 �޸�
          end;
          nCode:= 15;
          PlayObject.m_GetExp:= dwInt;//����ȡ�õľ���,$GetExp����ʹ�� 20090102
          if g_FunctionNPC <> nil then begin//ȡ���鴥�� 20090102
            g_FunctionNPC.GotoLable(PlayObject, '@GetExp', False);
          end;
          Inc(PlayObject.m_Abil.Exp, dwInt);
          PlayObject.SendMsg(PlayObject, RM_WINEXP, 0, dwInt, 0, 0, '');
          PlayObject.GetExpToCrystal(dwInt, 0);//ȡ���鵽��ؽᾧ�� 20090202
          nCode:= 16;
          if PlayObject.m_Abil.Exp >= PlayObject.m_Abil.MaxExp then begin//20080825
            Dec(PlayObject.m_Abil.Exp, PlayObject.m_Abil.MaxExp);
            nCode:= 17;
            if (PlayObject.m_Abil.Level < MAXUPLEVEL) and (PlayObject.m_Abil.Level < g_Config.nLimitExpLevel) then Inc(PlayObject.m_Abil.Level);//�������Ƶȼ�
            if PlayObject.m_Abil.Level < g_Config.nLimitExpLevel then PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);//�������Ƶȼ�
            AddGameDataLog('12' + #9 + PlayObject.m_sMapName + #9 + //����������¼��־
              IntToStr(PlayObject.m_Abil.Level) + #9 +
              IntToStr(PlayObject.m_Abil.Exp)+'/'+IntToStr(PlayObject.m_Abil.MaxExp) + #9 +
              m_sCharName + #9 + '0' + #9 + '0' + #9 + '1' + #9 + '(��������)');
          end;
          nCode:= 18;
          if PlayObject.m_Magic68Skill <> nil then begin//ѧ���������� 20080825
            if PlayObject.m_Magic68Skill.btLevel < 100 then Inc(PlayObject.m_Exp68, dwInt);
            nCode:= 19;
            if PlayObject.m_Exp68 >= PlayObject.m_MaxExp68 then begin//������������,����������
              Dec(PlayObject.m_Exp68, PlayObject.m_MaxExp68);
              nCode:= 20;
              if PlayObject.m_Magic68Skill.btLevel < 100 then Inc(PlayObject.m_Magic68Skill.btLevel);
              PlayObject.m_MaxExp68 := PlayObject.GetSkill68Exp(PlayObject.m_Magic68Skill.btLevel);
              PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0, PlayObject.m_Magic68Skill.MagicInfo.wMagicId, PlayObject.m_Magic68Skill.btLevel, PlayObject.m_Magic68Skill.nTranPoint, '', 100);
            end;
            nCode:= 21;
            if PlayObject.m_Magic68Skill.btLevel < 100 then//20080830 ����
              PlayObject.SendMsg(PlayObject, RM_MAGIC68SKILLEXP, 0, 0, 0, 0, EncodeString(Inttostr(PlayObject.m_Exp68)+'/'+Inttostr(PlayObject.m_MaxExp68)));//���;������徭��
          end;
        end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfChangeExp Code:'+ IntToStr(nCode));
  end;
end;

//����:�����ڹ����� 20081002
//��ʽ:CHANGENGEXP ���Ʒ�(=,+,-) ������� Hero
procedure TNormNpc.ActionOfChangeNGExp(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nExp: LongWord;
  cMethod: Char;
  dwInt: LongWord;
begin
  try
    nExp:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);
    if (nExp < 0) {and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nExp))} then begin//20081230
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ChangeNGExp);
      Exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    if CompareText(QuestActionInfo.sParam3, 'HERO') = 0 then begin
      if PlayObject.m_MyHero <> nil then begin
        if not THeroObject(PlayObject.m_MyHero).m_boTrainingNG then Exit;
        case cMethod of
          '=': begin
              if nExp >= 0 then THeroObject(PlayObject.m_MyHero).m_ExpSkill69 := nExp;
              PlayObject.m_MyHero.SendNGData;//�����ڹ����� 20081204
            end;
          '-': begin
              if THeroObject(PlayObject.m_MyHero).m_ExpSkill69 > LongWord(nExp) then begin
                Dec(THeroObject(PlayObject.m_MyHero).m_ExpSkill69, LongWord(nExp));
              end else begin
                THeroObject(PlayObject.m_MyHero).m_ExpSkill69 := 0;
              end;
              PlayObject.m_MyHero.SendNGData;//�����ڹ����� 20081204
            end;
          '+': begin
              dwInt := LongWord(nExp);
              THeroObject(PlayObject.m_MyHero).GetNGExp(dwInt, 1);
            end;
        end;//case
      end;
    end else begin
      if not PlayObject.m_boTrainingNG then Exit;
      case cMethod of
        '=': begin
            if nExp >= 0 then PlayObject.m_ExpSkill69 := nExp;
            PlayObject.SendNGData;//�����ڹ����� 20081204
          end;
        '-': begin
            if PlayObject.m_ExpSkill69 > LongWord(nExp) then begin
              Dec(PlayObject.m_ExpSkill69, LongWord(nExp));
            end else begin
              PlayObject.m_ExpSkill69 := 0;
            end;
            PlayObject.SendNGData;//�����ڹ����� 20081204
          end;
        '+': begin
            dwInt := LongWord(nExp);
            PlayObject.GetNGExp(dwInt,1);
          end;
      end;//case
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfChangeNGExp');
  end;
end;

//����:�������������ȼ� 20081004
//��ʽ:CHANGENGLEVEL ���Ʒ�(=,+,-) �ȼ���(1-255) Hero
procedure TNormNpc.ActionOfCHANGENGLEVEL(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nLv, nLEVEL: Byte;
  boChgOK: Boolean;
  cMethod: Char;
begin
try
  boChgOK := False;
  nLEVEL:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);
  if (nLEVEL < 0) or (nLEVEL > 255) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGENGLEVEL);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  if CompareText(QuestActionInfo.sParam3, 'HERO') = 0 then begin
    if PlayObject.m_MyHero <> nil then begin
      if not THeroObject(PlayObject.m_MyHero).m_boTrainingNG then Exit;
      case cMethod of
        '=': begin
            if (nLevel > 0) and (nLevel <= 255) then begin
              THeroObject(PlayObject.m_MyHero).m_NGLevel := nLEVEL;
              boChgOK := True;
            end;
          end;
        '-': begin
            nLv := _MAX(0, THeroObject(PlayObject.m_MyHero).m_NGLevel - nLevel);
            THeroObject(PlayObject.m_MyHero).m_NGLevel := nLv;
            boChgOK := True;
          end;
        '+': begin
            nLv := _MIN(255, THeroObject(PlayObject.m_MyHero).m_NGLevel + nLevel);
            THeroObject(PlayObject.m_MyHero).m_NGLevel := nLv;
            boChgOK := True;
          end;
      end;//case
      if boChgOK then begin
        PlayObject.m_MyHero.SendNGData;//�����ڹ����� 20081005
        AddGameDataLog('17' + #9 + PlayObject.m_MyHero.m_sMapName + #9 + //�ȼ�������¼��־
          IntToStr(PlayObject.m_MyHero.m_nCurrX) + #9 +
          IntToStr(PlayObject.m_MyHero.m_nCurrY)+ #9 +
          PlayObject.m_MyHero.m_sCharName + #9 +
          IntToStr(THeroObject(PlayObject.m_MyHero).m_NGLevel) + #9 +
          'Ӣ���ڹ�' + #9 +
          cMethod+'('+IntToStr(nLevel)+')' + #9 +
          m_sCharName);
      end;
    end;
  end else begin
    if not PlayObject.m_boTrainingNG then Exit;
    case cMethod of
      '=': begin
          if (nLevel > 0) and (nLevel <= 255) then begin
            PlayObject.m_NGLevel := nLEVEL;
            boChgOK := True;
          end;
        end;
      '-': begin
          nLv := _MAX(0, PlayObject.m_NGLevel - nLevel);
          PlayObject.m_NGLevel := nLv;
          boChgOK := True;
        end;
      '+': begin
          nLv := _MIN(255, PlayObject.m_NGLevel + nLevel);
          PlayObject.m_NGLevel := nLv;
          boChgOK := True;
        end;
    end;//case
    if boChgOK then begin
      PlayObject.SendNGData;//�����ڹ����� 20081005
      AddGameDataLog('17' + #9 + PlayObject.m_sMapName + #9 + //�ȼ�������¼��־
        IntToStr(PlayObject.m_nCurrX) + #9 +
        IntToStr(PlayObject.m_nCurrY)+ #9 +
        PlayObject.m_sCharName + #9 +
        IntToStr(PlayObject.m_NGLevel) + #9 +
        '�ڹ�' + #9 +
        cMethod+'('+IntToStr(nLevel)+')' + #9 +
        m_sCharName);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfCHANGENGLEVEL');
end;
end;

//���ܣ��ͻ�����ʾ��ؽᾧͼ��
//��ʽ��OPENEXPCRYSTAL
procedure TNormNpc.ActionOfOPENEXPCRYSTAL(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    PlayObject.m_boShowExpCrystal:= True;//�Ƿ���ʾ��ؽᾧͼ�� 20090131
    PlayObject.m_CrystalLevel:= 1;//��ؽᾧ�ȼ� 20090131
    PlayObject.m_CrystalExp:= 0;//��ؽᾧ��ǰ���� 20090131
    PlayObject.m_CrystalMaxExp:= 0;//��ؽᾧ�������� 20090131
    PlayObject.m_CrystalNGExp:= 0;//��ؽᾧ��ǰ�ڹ����� 20090131
    PlayObject.m_CrystalNGMaxExp:= 0;//��ؽᾧ�ڹ��������� 20090131
    PlayObject.m_boGetExpCrystalExp := False;//�Ƿ������ȡ���� 20090201
    PlayObject.m_nGetCrystalExp:= 0;//����ȡ��ؽᾧ���� 20090201
    PlayObject.m_nGetCrystalNGExp:= 0;//�����ȡ�ؽᾧ�ڹ����� 20090201
    //����Ϣ��ʾ��ؽᾧͼ��
    PlayObject.SendMsg(PlayObject, RM_OPENEXPCRYSTAL, 0, 2, 0, 0, '');
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfOPENEXPCRYSTAL');
  end;
end;

//���ܣ��ͻ��˹ر���ؽᾧͼ��
//��ʽ��CLOSEEXPCRYSTAL
procedure TNormNpc.ActionOfCLOSEEXPCRYSTAL(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    if PlayObject.m_boShowExpCrystal then begin
      PlayObject.m_boShowExpCrystal:= False;//�Ƿ���ʾ��ؽᾧͼ�� 20090131
      PlayObject.m_CrystalLevel:= 1;//��ؽᾧ�ȼ� 20090131
      PlayObject.m_CrystalExp:= 0;//��ؽᾧ��ǰ���� 20090131
      PlayObject.m_CrystalMaxExp:= 0;//��ؽᾧ�������� 20090131
      PlayObject.m_CrystalNGExp:= 0;//��ؽᾧ��ǰ�ڹ����� 20090131
      PlayObject.m_CrystalNGMaxExp:= 0;//��ؽᾧ�ڹ��������� 20090131
      PlayObject.m_boGetExpCrystalExp := False;//�Ƿ������ȡ���� 20090201
      PlayObject.m_nGetCrystalExp:= 0;//����ȡ��ؽᾧ���� 20090201
      PlayObject.m_nGetCrystalNGExp:= 0;//�����ȡ�ؽᾧ�ڹ����� 20090201
      //����Ϣ�ر���ؽᾧͼ��
      PlayObject.SendMsg(PlayObject, RM_OPENEXPCRYSTAL, 0, 1, 0, 0, '');
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfCLOSEEXPCRYSTAL');
  end;
end;
//���ܣ�ȡ����ؽᾧ�еľ���(ֻ��ȡ����ȡ�ľ���)
//��ʽ��GETEXPTOCRYSTAL
procedure TNormNpc.ActionOfGETEXPTOCRYSTAL(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    PlayObject.ClientGetExpTCrystal;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfGETEXPTOCRYSTAL');
  end;
end;

//���ܣ�ʱ�䵽����QF�� 20090124
//��ʽ��SENDTIMEMSG ��Ϣ���� ʱ�� ����ɫ QF������
//����SENDTIMEMSG ����������ʣ%s�����... 300 251 @��������
//˵����300����ʱ��(��)  251������ɫ @�������� ����QFunction-0.txt
procedure TNormNpc.ActionOfSENDTIMEMSG(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTime, nTime1: Integer;
  FColor: Byte;
  sQFStr, sMsg: string;
  boForMapShowHint: Boolean;
begin
  try
    sMsg:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);
    nTime:= Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2), -1);//ʱ��(��)
    FColor:= _MIN(255, Str_ToInt(QuestActionInfo.sParam3, 0));//����ɫ
    sQFStr:= GetLineVariableText(PlayObject,QuestActionInfo.sParam4);//����QFunction-0.txt��
    boForMapShowHint:= Str_ToInt(QuestActionInfo.sParam5, 0) <> 0;//����ͼ�Ƿ���ʾ����ʱ��Ϣ 20090128
    if (sMsg = '') or (sQFStr = '') or (nTime < 0) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SENDTIMEMSG);
      Exit;
    end;
    //���������ʱ��
    {if nTime >= 360 then begin
      nTime1:= nTime div 360;
      PlayObject.m_dwUserTick[0]:= nTime - nTime1;//����M2��ͻ��˼�ʱ��������M2����ʱ��ֵ���Ա���ͻ��˼�ʱһ��
    end else} PlayObject.m_dwUserTick[0]:= nTime;
    PlayObject.m_sMapQFStr:= sQFStr;//SENDTIMEMSG�������õĴ����� 20090124
    PlayObject.m_boForMapShowHint:= boForMapShowHint;//����ͼ�Ƿ���ʾ����ʱ��Ϣ 20090128
    PlayObject.m_dwUserTick[3]:= 0;//20090129 
    //������ʾ��Ϣ���ͻ���
    PlayObject.SendMsg(PlayObject, RM_MOVEMESSAGE, 2{����ʱ��Ϣ}, FColor, 0, nTime, sMsg);//�ͻ�����ʾ����ʱ(��ݼ��Ϸ���ʾ) 20090126
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfSENDTIMEMSG');
  end;
end;

//���ܣ�ʱ�䵽�����QFunction-0.txt ָ���Ĵ�����,����Ϣ���ͻ�����ʾ'!'��ͼ��
//��ʽ��SENDMSGWINDOWS ʱ��  QF�ⷢ��
//����  SENDMSGWINDOWS 300 @��ʾ���Ĵ���
//˵����300����ʱ��(��)  @��ʾ���Ĵ��� ����QFunction-0.txt
procedure TNormNpc.ActionOfSENDMSGWINDOWS(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTime: Integer;
  sQFStr: string;
begin
  try
    nTime:= Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam1), -1);//ʱ��(��)
    sQFStr:= GetLineVariableText(PlayObject,QuestActionInfo.sParam2);//����QFunction-0.txt��
    if (sQFStr = '') or (nTime < 0) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SENDMSGWINDOWS);
      Exit;
    end;
    //���������ʱ��
    PlayObject.m_dwUserTick[2]:= nTime;
    PlayObject.m_sMapQFStr1:= sQFStr;//SENDMSGWINDOWS�������õĴ����� 20090124
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfSENDMSGWINDOWS');
  end;
end;

//���ܣ��رտͻ���'!'ͼ�����ʾ 20090126
//��ʽ��CLOSEMSGWINDOWS
procedure TNormNpc.ActionOfCLOSEMSGWINDOWS(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.SendMsg(PlayObject, RM_HIDESIGHICON, 0, 0, 0, 0, '');
  //����Ϣ���ͻ��˹ر�ͼ�����ʾ
end;

//���ܣ�ȡ��ӳ�Ա��
//��ʽ��GETGROUPCOUNT ����
procedure TNormNpc.ActionOfGETGROUPCOUNT(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
 nGroupCount: Integer;
begin
  try
    if (PlayObject.m_GroupOwner <> nil) then begin//�����
      if PlayObject.m_GroupOwner.m_GroupMembers.Count > 0 then begin
        nGroupCount:= PlayObject.m_GroupOwner.m_GroupMembers.Count;
      end;
    end;
    SetValValue(PlayObject, QuestActionInfo.sParam1, nGroupCount);
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfGETGROUPCOUNT');
  end;
end;

//�ı䷢��
procedure TNormNpc.ActionOfChangeHairStyle(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nHair: Integer;
begin
try
  nHair := Str_ToInt(QuestActionInfo.sParam1, -1);
  if (QuestActionInfo.sParam1 <> '') and (nHair >= 0) then begin
    PlayObject.m_btHair := nHair;
    PlayObject.FeatureChanged;
  end else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HAIRSTYLE);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfChangeHairStyle');
end;
end;
//�ı�ְҵ
procedure TNormNpc.ActionOfChangeJob(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nJob: Integer;
begin
try
  nJob := -1;
  if CompareLStr(QuestActionInfo.sParam1, 'WARRIOR'{sWARRIOR}, 3) then nJob := 0;
  if CompareLStr(QuestActionInfo.sParam1, 'WIZARD'{sWIZARD}, 3) then nJob := 1;
  if CompareLStr(QuestActionInfo.sParam1, 'TAOIST'{sTAOS}, 3) then nJob := 2;
  //if CompareLStr(QuestActionInfo.sParam1, 'ASSASSIN', 3) then nJob := 3;//�̿� 20080929

  if nJob < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEJOB);
    Exit;
  end;

  if PlayObject.m_btJob <> nJob then begin
    PlayObject.m_btJob := nJob;
    PlayObject.HasLevelUp(0);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfChangeJob');
end;
end;
//�ı�ȼ�
procedure TNormNpc.ActionOfChangeLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boChgOK: Boolean;
  nLevel: Integer;
  nLv: Integer;
  nOldLevel: Integer;
  cMethod: Char;
begin
try
  boChgOK := False;
  nOldLevel := PlayObject.m_Abil.Level;
  nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nLevel < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nLevel)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGELEVEL);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if (nLevel > 0) and (nLevel <= MAXLEVEL) then begin
          PlayObject.m_Abil.Level := nLevel;
          boChgOK := True;
        end;
      end;
    '-': begin
        nLv := _MAX(0, PlayObject.m_Abil.Level - nLevel);
        nLv := _MIN(MAXLEVEL, nLv);
        PlayObject.m_Abil.Level := nLv;
        boChgOK := True;
      end;
    '+': begin
        nLv := _MAX(0, PlayObject.m_Abil.Level + nLevel);
        nLv := _MIN(MAXLEVEL, nLv);
        PlayObject.m_Abil.Level := nLv;
        boChgOK := True;
      end;
  end;
  if boChgOK then begin
    PlayObject.HasLevelUp(nOldLevel);
    AddGameDataLog('17' + #9 + PlayObject.m_sMapName + #9 + //�ȼ�������¼��־ 20080911
      IntToStr(PlayObject.m_nCurrX) + #9 +
      IntToStr(PlayObject.m_nCurrY)+ #9 +
      PlayObject.m_sCharName + #9 +
      IntToStr(PlayObject.m_Abil.Level) + #9 +
      '0' + #9 +
      cMethod+'('+IntToStr(nLevel)+')' + #9 +
      m_sCharName);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfChangeLevel');
end;
end;
//����PKֵ
procedure TNormNpc.ActionOfChangePkPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPKPOINT: Integer;
  nPoint: Integer;
  nOldPKLevel: Integer;
  cMethod: Char;
begin
try
  nOldPKLevel := PlayObject.PKLevel;
  nPKPOINT:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080430

  if (nPKPOINT < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nPKPOINT)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEPKPOINT);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if (nPKPOINT >= 0) then begin
          PlayObject.m_nPkPoint := nPKPOINT;
        end;
      end;
    '-': begin
        nPoint := _MAX(0, PlayObject.m_nPkPoint - nPKPOINT);
        PlayObject.m_nPkPoint := nPoint;
      end;
    '+': begin
        nPoint := _MAX(0, PlayObject.m_nPkPoint + nPKPOINT);
        PlayObject.m_nPkPoint := nPoint;
      end;
  end;
  if nOldPKLevel <> PlayObject.PKLevel then PlayObject.RefNameColor;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfChangePkPoint');
end;
end;
//�����ͼ���� 
procedure TNormNpc.ActionOfClearMapMon(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  MonList: TList;
  mon: TBaseObject;
  II: Integer;
  sMap: String;
begin
try
  MonList := TList.Create;
  try
    sMap:= QuestActionInfo.sParam1;
    if (sMap <> '') and (sMap[1] = '<') and (sMap[2] = '$') then//����֧��<$Str()> 20080422
       sMap := GetLineVariableText(PlayObject, QuestActionInfo.sParam1)
    else GetValValue(PlayObject, QuestActionInfo.sParam1, sMap);
   // sMap:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1); //��ͼ֧�ֱ��� 20080419
    UserEngine.GetMapMonster(g_MapManager.FindMap(sMap), MonList);
    if MonList.Count > 0 then begin//20080629
      for II := 0 to MonList.Count - 1 do begin
        mon := TBaseObject(MonList.Items[II]);
        if (mon.m_Master <> nil) and (mon.m_btRaceServer <> 135) then Continue;//20080419 135�ı���ҲҪ���
        if GetNoClearMonList(mon.m_sCharName) then Continue;

        mon.m_boNoItem := True;
        mon.m_Abil.HP:= 0; //20080419
        mon.MakeGhost;
      end;
    end;
  finally
    MonList.Free;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfClearMapMon');
end;
end;
//����ļ�����(���������ļ�)
procedure TNormNpc.ActionOfClearNameList(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  LoadList: TStringList;
  sListFileName,s01: string;
begin
  s01 := GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//20080602 ·��֧�ֱ���
  if s01[1] = '\' then s01 := Copy(s01, 2, Length(s01) - 1);
  if s01[2] = '\' then s01 := Copy(s01, 3, Length(s01) - 2);
  if s01[3] = '\' then s01 := Copy(s01, 4, Length(s01) - 3);

  sListFileName := g_Config.sEnvirDir {+ m_sPath} + s01;//20090102
  LoadList := TStringList.Create;
  try
    {if FileExists(sListFileName) then begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('�ļ���ȡʧ��.... => ' + sListFileName);
      end;
    end; }
    LoadList.Clear;
    try
      LoadList.SaveToFile(sListFileName);
    except
      MainOutMessage('�ļ�����ʧ�� => ' + sListFileName);
    end;
  finally
    LoadList.Free;
  end;
end;
//���ܣ������������м��ܡ�  20080423
//��ʽ��CLEARSKILL  (�Ӳ���HERO,����ɾ��Ӣ�ۼ���,���������＼��)
procedure TNormNpc.ActionOfClearSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
try
  if CompareText(QuestActionInfo.sParam1, 'HERO') = 0 then begin
    if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARSKILL);
      Exit;
    end;
    if PlayObject.m_MyHero <> nil then begin
      for I := PlayObject.m_MyHero.m_MagicList.Count - 1 downto 0 do begin
        if PlayObject.m_MyHero.m_MagicList.Count <= 0 then Break;
        UserMagic := PlayObject.m_MyHero.m_MagicList.Items[I];
        //ѧ����������,�����ر�����ʼ�� 20080925
        if (UserMagic.MagicInfo.wMagicId = 68) and ((THeroObject(PlayObject.m_MyHero).m_MaxExp68 <> 0) or (THeroObject(PlayObject.m_MyHero).m_Exp68 <> 0)) then begin
          THeroObject(PlayObject.m_MyHero).m_MaxExp68:= 0;
          THeroObject(PlayObject.m_MyHero).m_Exp68:= 0;
        end;
        PlayObject.m_MyHero.m_MagicList.Delete(I);
        THeroObject(PlayObject.m_MyHero).SendDelMagic(UserMagic);
        Dispose(UserMagic);
      end;
      THeroObject(PlayObject.m_MyHero).RecalcAbilitys();//20081213 �޸�
      PlayObject.m_MyHero.CompareSuitItem(False);//200080729 ��װ
    end;
  end else begin
    for I := PlayObject.m_MagicList.Count - 1 downto 0 do begin
      if PlayObject.m_MagicList.Count <= 0 then Break;//20080917
      UserMagic := PlayObject.m_MagicList.Items[I];
      if (UserMagic.MagicInfo.wMagicId = 68) and ((PlayObject.m_MaxExp68 <> 0) or (PlayObject.m_Exp68 <> 0)) then begin//�Ǿ������� 20080625
        PlayObject.m_MaxExp68:= 0;
        PlayObject.m_Exp68:= 0;
      end;
      PlayObject.SendDelMagic(UserMagic);
      Dispose(UserMagic);
      PlayObject.m_MagicList.Delete(I);
    end;
    PlayObject.RecalcAbilitys();
    PlayObject.CompareSuitItem(False);//200080729 ��װ
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfClearSkill');
end;
end;
//�������Ǳ�ְҵ�����м���
//��ʽ��DELNOJOBSKILL    (�Ӳ���HERO,����ɾ��Ӣ�ۼ���,���������＼��)
procedure TNormNpc.ActionOfDelNoJobSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
try
  if CompareText(QuestActionInfo.sParam1, 'HERO') = 0 then begin
    if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELNOJOBSKILL);
      Exit;
    end;
    if PlayObject.m_MyHero <> nil then begin
      for I := PlayObject.m_MyHero.m_MagicList.Count - 1 downto 0 do begin
        if PlayObject.m_MyHero.m_MagicList.Count <= 0 then Break;
        UserMagic := PlayObject.m_MyHero.m_MagicList.Items[I];
        if UserMagic.MagicInfo.btJob <> PlayObject.m_MyHero.m_btJob then begin
          //ѧ����������,�����ر�����ʼ�� 20080925
          if (UserMagic.MagicInfo.wMagicId = 68) and ((THeroObject(PlayObject.m_MyHero).m_MaxExp68 <> 0) or (THeroObject(PlayObject.m_MyHero).m_Exp68 <> 0)) then begin
            THeroObject(PlayObject.m_MyHero).m_MaxExp68:= 0;
            THeroObject(PlayObject.m_MyHero).m_Exp68:= 0;
          end;
          PlayObject.m_MyHero.m_MagicList.Delete(I);
          THeroObject(PlayObject.m_MyHero).SendDelMagic(UserMagic);
          Dispose(UserMagic);
        end;
      end;//for
      THeroObject(PlayObject.m_MyHero).RecalcAbilitys();//20080430
      PlayObject.m_MyHero.CompareSuitItem(False);//200080729 ��װ
    end;
  end else begin
    for I := PlayObject.m_MagicList.Count - 1 downto 0 do begin
      if PlayObject.m_MagicList.Count <= 0 then Break;
      UserMagic := PlayObject.m_MagicList.Items[I];
      if UserMagic.MagicInfo.btJob <> PlayObject.m_btJob then begin
        if (UserMagic.MagicInfo.wMagicId = 68) and ((PlayObject.m_MaxExp68 <> 0) or (PlayObject.m_Exp68 <> 0)) then begin//�Ǿ������� 20080625
          PlayObject.m_MaxExp68:= 0;
          PlayObject.m_Exp68:= 0;
        end;
        PlayObject.SendDelMagic(UserMagic);
        Dispose(UserMagic);
        PlayObject.m_MagicList.Delete(I);
      end;
    end;//for
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfDelNoJobSkill');
end;
end;
//ɾ������ 20080223
//��ʽ��DELSKILL �������� HERO  (�Ӳ���HERO,����ɾ��Ӣ�ۼ���)
procedure TNormNpc.ActionOfDelSkill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMagicName: string;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
begin
try
  sMagicName := QuestActionInfo.sParam1;
  if CompareText(QuestActionInfo.sParam2, 'HERO') = 0 then begin
    if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELSKILL);
      Exit;
    end;
    Magic := UserEngine.FindHeroMagic(sMagicName);
    if Magic = nil then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELSKILL);
      Exit;
    end;
    if PlayObject.m_MyHero <> nil then begin
      for I := PlayObject.m_MyHero.m_MagicList.Count - 1 downto 0 do begin
        if PlayObject.m_MyHero.m_MagicList.Count <= 0 then Break;
        UserMagic := PlayObject.m_MyHero.m_MagicList.Items[I];
        if UserMagic.MagicInfo = Magic then begin
          PlayObject.m_MyHero.m_MagicList.Delete(I);
          THeroObject(PlayObject.m_MyHero).SendDelMagic(UserMagic);
          Dispose(UserMagic);
          Break;
        end;
      end;//for
      THeroObject(PlayObject.m_MyHero).RecalcAbilitys();//20081213
      PlayObject.m_MyHero.CompareSuitItem(False);//200080729 ��װ
    end;
  end else begin
    Magic := UserEngine.FindMagic(sMagicName);
    if Magic = nil then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DELSKILL);
      Exit;
    end;
    for I := PlayObject.m_MagicList.Count - 1 downto 0 do begin
      if PlayObject.m_MagicList.Count <= 0 then Break;
      UserMagic := PlayObject.m_MagicList.Items[I];
      if UserMagic.MagicInfo = Magic then begin
        PlayObject.m_MagicList.Delete(I);
        PlayObject.SendDelMagic(UserMagic);
        Dispose(UserMagic);
        Break;
      end;
    end;//for
    PlayObject.RecalcAbilitys();
    PlayObject.CompareSuitItem(False);//200080729 ��װ
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfDelSkill');
end;
end;
//������Ϸ��(Ԫ��)
procedure TNormNpc.ActionOfGameGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGameGold: Integer;
  nOldGameGold: Integer;
  cMethod: Char;
begin
try
  nOldGameGold := PlayObject.m_nGameGold;
  nGameGold:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080430

  if (nGameGold < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nGameGold)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEGOLD);
    Exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if (nGameGold >= 0) then begin
          PlayObject.m_nGameGold := nGameGold;
        end;
      end;
    '-': begin
        PlayObject.m_nGameGold := _MAX(0, PlayObject.m_nGameGold - nGameGold);//20080809 �޸�
      end;
    '+': begin
        PlayObject.m_nGameGold :=_MIN(High(PlayObject.m_nGameGold), PlayObject.m_nGameGold + nGameGold);//20080809 �޸�
      end;
  end;
  //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
  if g_boGameLogGameGold then begin
    AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GAMEGOLD, PlayObject.m_sMapName,
        PlayObject.m_nCurrX, PlayObject.m_nCurrY, PlayObject.m_sCharName,
        g_Config.sGameGoldName, PlayObject.m_nGameGold,
        cMethod+'('+inttostr(nGameGold)+')', m_sCharName]));
  end;
  if nOldGameGold <> PlayObject.m_nGameGold then PlayObject.GameGoldChanged;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGameGold');
end;
end;
//�������ʯ���� 20071226
procedure TNormNpc.ActionOfGameDiaMond(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGameDiaMond: Integer;
  nOldGameDiaMond: Integer;
  cMethod: Char;
begin
try
  nOldGameDiaMond := PlayObject.m_nGameDiaMond;
  //nGameDiaMond := Str_ToInt(QuestActionInfo.sParam2, -1); //20080315
  nGameDiaMond:=Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),-1);//20080430
  
  if (nGameDiaMond < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nGameDiaMond)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEDIAMOND);
    Exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if (nGameDiaMond >= 0) then begin
          PlayObject.m_nGameDiaMond := nGameDiaMond;
        end;
      end;
    '-': begin
        //nGameDiaMond := _MAX(0, PlayObject.m_nGameDiaMond - nGameDiaMond);
        //PlayObject.m_nGameDiaMond := nGameDiaMond;
        PlayObject.m_nGameDiaMond := _MAX(0, PlayObject.m_nGameDiaMond - nGameDiaMond);//20080809 �޸�
      end;
    '+': begin
        //nGameDiaMond := _MAX(0, PlayObject.m_nGameDiaMond + nGameDiaMond);
        //PlayObject.m_nGameDiaMond := nGameDiaMond;
        PlayObject.m_nGameDiaMond := _MIN(High(PlayObject.m_nGameDiaMond), PlayObject.m_nGameDiaMond + nGameDiaMond);//20080809 �޸�
      end;
  end;
  //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
  if g_boGameLogGameDiaMond then begin
    AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GameDiaMond,
      PlayObject.m_sMapName,
        PlayObject.m_nCurrX,
        PlayObject.m_nCurrY,
        PlayObject.m_sCharName,
        g_Config.sGameDiaMond,
        PlayObject.m_nGameDiaMond,
        cMethod+'('+inttostr(nGameDiaMond)+')',
        m_sCharName]));
  end;
  if nOldGameDiaMond <> PlayObject.m_nGameDiaMond then PlayObject.GameGoldChanged;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGameDiaMond');
end;
end;
//�����������  20071226
procedure TNormNpc.ActionOfGameGird(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGameGird: Integer;
  nOldGameGird: Integer;
  cMethod: Char;
begin
  try
    nOldGameGird := PlayObject.m_nGameGird;
    nGameGird:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),-1);//20080430

    if (nGameGird < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nGameGird)) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GameGird);
      Exit;
    end;

    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=': begin
          if (nGameGird >= 0) then begin
            PlayObject.m_nGameGird := nGameGird;
          end;
        end;
      '-': begin
          PlayObject.m_nGameGird := _MAX(0, PlayObject.m_nGameGird - nGameGird);//20080809 �޸�
          PlayObject.m_UseGameGird := nGameGird;//20090108 ���ʹ�ü���
          if g_FunctionNPC <> nil then begin//���ʹ�ô��� 20090108
            g_FunctionNPC.GotoLable(PlayObject, '@USEGAMEGIRD', False);
          end;
        end;
      '+': begin
          PlayObject.m_nGameGird :=_MIN(High(PlayObject.m_nGameGird), PlayObject.m_nGameGird + nGameGird);//20080809 �޸�
        end;
    end;
    //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
    if g_boGameLogGameGird then begin
      AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GameGird,
        PlayObject.m_sMapName,
          PlayObject.m_nCurrX,
          PlayObject.m_nCurrY,
          PlayObject.m_sCharName,
          g_Config.sGameGird,
          PlayObject.m_nGameGird,
          cMethod+'('+inttostr(nGameGird)+')',
          m_sCharName]));
    end;
    if nOldGameGird <> PlayObject.m_nGameGird then PlayObject.GameGoldChanged;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfGameGird');
  end;
end;
//---------------------------------------------------------------------------
//����Ӣ�ۼ����������� 20080512
//��ʽ:ChangeHeroTranPoint ������ ������(+ - =) ��ֵ
procedure TNormNpc.ActionOfCHANGEHEROTRANPOINT(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTranPoint, nOldTranPoint: Integer;
  sMagicName: String;
  cMethod: Char;
  UserMagic: pTUserMagic;
begin
try
  if PlayObject.m_MyHero = nil then Exit;
  sMagicName:= GetLineVariableText(PlayObject,QuestActionInfo.sParam1);
  nTranPoint:=Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3),-1);
  if (nTranPoint < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam3, nTranPoint)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROTRANPOINT);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam2[1];
  if (sMagicName = '') and (cMethod = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROTRANPOINT);
    Exit;
  end;
  UserMagic:= TPlayObject(PlayObject.m_MyHero).GetMagicInfo(sMagicName);
  if UserMagic <> nil then begin
    nOldTranPoint:= UserMagic.nTranPoint;
    case cMethod of
      '=': begin
        if (nTranPoint >= 0) then UserMagic.nTranPoint := nTranPoint;
       end;
      '-': begin
         nTranPoint := _MAX(0, UserMagic.nTranPoint - nTranPoint);
         if nTranPoint < 0 then nTranPoint := 0;
         UserMagic.nTranPoint := nTranPoint;
       end;
      '+': begin
         if (UserMagic.btLevel < 3) and (UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <= PlayObject.m_MyHero.m_Abil.Level) then begin
           nTranPoint := _MAX(0, UserMagic.nTranPoint + nTranPoint);
           UserMagic.nTranPoint := nTranPoint;
         end;
       end;
    end;//case cMethod of
    if nOldTranPoint <> UserMagic.nTranPoint then begin
      if not THeroObject(PlayObject.m_MyHero).CheckMagicLevelup(UserMagic) then begin
        THeroObject(PlayObject.m_MyHero).SendDelayMsg(PlayObject.m_MyHero, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 500);
      end;
    end;
  end;//if UserMagic <> nil then begin
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfCHANGEHEROTRANPOINT');
end;
end;
//---------------------------------------------------------------------------
//----------------------------�ƹ�ϵͳ---------------------------------------
//�ķ�Ӣ��  20080513
//Ӣ�۱���Ҫ����,�ɹ���,Ӣ���˳�,���ٻ�Ӣ��,û����ʾ
procedure TNormNpc.ActionOfSAVEHERO(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
begin
try
  if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519 //���û��Ӣ��
    if PlayObject.m_boPlayDrink then
       GotoLable(PlayObject, '~PlayDrink_Already_NotHero', False)
    else GotoLable(PlayObject, '~PlayDrink_NotHero', False);
    Exit;
  end;
  if PlayObject.m_MyHero <> nil then begin //Ӣ������,���ܽ��ķ�
    PlayObject.m_sHeroCharName:='';//�����˵�Ӣ�������,�ﵽ�����ٻ�Ӣ�۵�Ŀ��
    PlayObject.n_HeroSave := 1;//�ķ�Ӣ�۱�ʶ
    PlayObject.ClientHeroLogOut(1); //Ӣ���˳�,û����ʾ
    GotoLable(PlayObject, '~PlayDrink_HeroOk', False);
  end else begin //Ӣ�۲�����
    if PlayObject.m_boPlayDrink then
      GotoLable(PlayObject, '~PlayDrink_Already_HeroBegin', False)
    else GotoLable(PlayObject, '~PlayDrink_HeroBegin', False);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSAVEHERO');
end;
end;
//ȡ��Ӣ�� 20080513
//������Ӣ��ʱ,��ȫ�ķź�,����ȡ��һ��Ӣ��
procedure TNormNpc.ActionOfGETHERO(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
begin
try
  //if PlayObject.n_HeroSave = 1 then begin//20080519
    if (PlayObject.m_sHeroCharName = '') and (PlayObject.m_boHasHero or PlayObject.m_boHasHeroTwo) then begin//����û��Ӣ�۲���ȡ��
       //����Ϣ,��ʾȡ��Ӣ�۵Ĵ���,ѡ���,�ı����˱���,
       FrontEngine.AddToLoadHeroRcdList(PlayObject.m_sCharName, '', PlayObject, 3);
    end else begin
      if g_FunctionNPC <> nil then
         g_FunctionNPC.GotoLable(PlayObject, '@GetHeroBak', False);
    end;
 //end else begin//û�д��Ӣ��
 // end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGETHERO');
end;
end;

//�رն���,��ƴ��� 20080514
procedure TNormNpc.ActionOfCLOSEDRINK(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
begin
try
  PlayObject.SendMsg(Self, RM_CLOSEDRINK, 0, 0, 0, 0, '');
  PlayObject.n_DrinkValue[0]:=0;//�ȾƵ����ֵ 0-NPC 1-��� 20080517
  PlayObject.n_DrinkValue[1]:=0;
  PlayObject.n_DrinkCount:= 0;//�ȾƵĴ���(����һ�����6��) 20080517
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfCLOSEDRINK');
end;
end;

//���ƴ���˵����Ϣ 20080514
//��ʽ:PLAYDRINKMSG ���� ˵����Ϣ
//(���������ʾ����) PLAYDRINKMSG ��Ϣλ��(1[����],2[����]) ��Ϣ����(��#sayһ��)
procedure TNormNpc.ActionOfPLAYDRINKMSG(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nDisplay: Byte;//��Ϣ��ʾ��λ��
  sMsg: String;//��Ϣ����
begin
try
  nDisplay := Str_ToInt(QuestActionInfo.sParam1, -1);
  sMsg := GetLineVariableText(PlayObject, QuestActionInfo.sParam2);
  if (not nDisplay in [1,2]) or ( sMsg='') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PLAYDRINKMSG);
    Exit;
  end;
  PlayObject.SendMsg(Self, RM_PLAYDRINKSAY, 0, 0, 0, nDisplay, sMsg);
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfPLAYDRINKMSG');
end;
end;

//�򿪾ƽ��� 20080514
//��ʽ:OPENPLAYDRINK ����ͷ��(0,1,2) ��������(0:����,1:����,2:Ӱ��)----(����ƽ���)
//��ʽ:OPENPLAYDRINK ����ͷ��(0,1,2) ��������(0:����,1:����,2:Ӱ��)  DRINK----(�򿪶��ƽ���)
procedure TNormNpc.ActionOfOPENPLAYDRINK(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nIcon: Integer;//����ͷ��
  sName: String;//��������
begin
try
  nIcon := Str_ToInt(QuestActionInfo.sParam1, -1);
  sName := GetLineVariableText(PlayObject, QuestActionInfo.sParam2);
  if nIcon < 0 then GetValValue(PlayObject, QuestActionInfo.sParam1, nIcon); //���ӱ���֧��

  if (nIcon < 0) or (nIcon > 3) or ( sName='') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENPLAYDRINK);
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam3, 'DRINK') = 0 then begin//�򿪶��ƽ���
     PlayObject.SendMsg(Self, RM_OPENPLAYDRINK, 0, 0, 1, nIcon, sName);
     PlayObject.n_DrinkValue[0]:=0;//�ȾƵ����ֵ 0-NPC 1-��� 20080517
     PlayObject.n_DrinkValue[1]:=0;
     PlayObject.n_DrinkCount:= 0;//�ȾƵĴ���(����һ�����6��) 20080517
  end else begin//����ƽ���
    if PlayObject.m_boPlayDrink then begin//������Ƶ�ֱ�Ӳ���
       GotoLable(PlayObject, '@SaveHero', False);
    end else begin//û����Ƶ�,����ƽ���
       PlayObject.SendMsg(Self, RM_OPENPLAYDRINK, 0, 0, 2, nIcon, sName);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfOPENPLAYDRINK');
end;
end;
//---------------------------------------------------------------------------
//���ܣ������������� 20080609
//��ʽ��CHANGEHUMABILITY ����(0-8) ������(=/-/+) ����ֵ(1-65535) ʱ��(��)
//ע��:�����������Ч��ֻ����������ʱ��Ч
procedure TNormNpc.ActionOfCHANGEHUMABILITY(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nValue: Byte;
  cMethod: Char;
  nTime: Integer;
  nValeu1: Word;
begin
try
  nValue := Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1),-1);
  nValeu1 := Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3),0);
  nTime := Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam4),0);
  if (nValue > 9) or (nValue < 0) or (nValeu1 = 0) or (nTime = 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHUMABILITY);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam2[1];
  case cMethod of
    '=': begin
        PlayObject.m_wStatusArrValue[nValue]:= nValeu1;
        PlayObject.m_dwStatusArrTimeOutTick[nValue]:=GetTickCount + nTime * 1000;
      end;
    '-': begin
        PlayObject.m_wStatusArrValue[nValue] := _MAX(0,  PlayObject.m_wStatusArrValue[nValue] - nValeu1);
        PlayObject.m_dwStatusArrTimeOutTick[nValue]:=GetTickCount + nTime * 1000;
      end;
    '+': begin
        PlayObject.m_wStatusArrValue[nValue]:= PlayObject.m_wStatusArrValue[nValue] + nValeu1;
        PlayObject.m_dwStatusArrTimeOutTick[nValue]:=GetTickCount + nTime * 1000;
      end;
  end;
  if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
     THeroObject(PlayObject).RecalcAbilitys();
     PlayObject.CompareSuitItem(False);//200080729 ��װ
     THeroObject(PlayObject).SendMsg(PlayObject{m_Master}, RM_HEROABILITY, 0, 0, 0, 0, ''); //����Ӣ������ 20090107�޸�
  end else begin
     PlayObject.RecalcAbilitys();
     PlayObject.CompareSuitItem(False);//200080729 ��װ
     PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfCHANGEHUMABILITY');
end;
end;
//---------------------------------------------------------------------------
//����Ӣ�۵��ҳ϶�  20080110
procedure TNormNpc.ActionOfHeroLoyal(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nLoyal: Integer;
  nOldLoyal: Integer;
  cMethod: Char;
begin
try
  if PlayObject.m_MyHero = nil then Exit;
  nOldLoyal := THeroObject(PlayObject.m_MyHero).m_nLoyal;
  nLoyal := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nLoyal < 0)and (nLoyal > 10000) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nLoyal)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROLOYAL);
    Exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if (nLoyal >= 0) then begin
          THeroObject(PlayObject.m_MyHero).m_nLoyal := nLoyal;
        end;
      end;
    '-': begin
        nLoyal := _MAX(0, THeroObject(PlayObject.m_MyHero).m_nLoyal - nLoyal);
        if nLoyal < 0 then nLoyal := 0; //20080312
        THeroObject(PlayObject.m_MyHero).m_nLoyal := nLoyal;
      end;
    '+': begin
        nLoyal := _MAX(0, THeroObject(PlayObject.m_MyHero).m_nLoyal + nLoyal); //20080312
        if nLoyal > 10000 then nLoyal := 10000;//20080312 ����NPC���ҳ϶ȳ������ֵ
        THeroObject(PlayObject.m_MyHero).m_nLoyal := nLoyal;
      end;
  end;
  if nOldLoyal <> THeroObject(PlayObject.m_MyHero).m_nLoyal then begin
    PlayObject.GameGoldChanged;
    m_DefMsg := MakeDefaultMsg(SM_HEROABILITY, THeroObject(PlayObject.m_MyHero).m_btGender, 0, THeroObject(PlayObject.m_MyHero).m_btJob, THeroObject(PlayObject.m_MyHero).m_nLoyal, 0);//20080312
    THeroObject(PlayObject.m_MyHero).SendSocket(@m_DefMsg, EncodeBuffer(@THeroObject(PlayObject.m_MyHero).m_WAbil, SizeOf(TAbility)));//20080312
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfHeroLoyal');
end;
end;
//�����ݵ�
procedure TNormNpc.ActionOfGamePoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGamePoint: Integer;
  nOldGamePoint: Integer;
  cMethod: Char;
begin
try
  nOldGamePoint := PlayObject.m_nGamePoint;
  //nGamePoint := Str_ToInt(QuestActionInfo.sParam2, -1); //20080320
  nGamePoint:=Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),-1);//20080430

  if (nGamePoint < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nGamePoint)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GAMEPOINT);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        if (nGamePoint >= 0) then begin
          PlayObject.m_nGamePoint := nGamePoint;
        end;
      end;
    '-': begin
        nGamePoint := _MAX(0, PlayObject.m_nGamePoint - nGamePoint);
        PlayObject.m_nGamePoint := nGamePoint;
      end;
    '+': begin
        nGamePoint := _MAX(0, PlayObject.m_nGamePoint + nGamePoint);
        PlayObject.m_nGamePoint := nGamePoint;
      end;
  end;
  //'%d'#9'%s'#9'%d'#9'%d'#9'%s'#9'%s'#9'%d'#9'%s'#9'%s'
  if g_boGameLogGamePoint then begin
    AddGameDataLog(Format(g_sGameLogMsg1, [LOG_GAMEPOINT,
      PlayObject.m_sMapName,
        PlayObject.m_nCurrX,
        PlayObject.m_nCurrY,
        PlayObject.m_sCharName,
        g_Config.sGamePointName,
        PlayObject.m_nGamePoint,
        cMethod+'('+inttostr(nGamePoint)+')',
        m_sCharName]));
  end;
  if nOldGamePoint <> PlayObject.m_nGamePoint then PlayObject.GameGoldChanged;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGamePoint');
end;
end;

procedure TNormNpc.ActionOfGetMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseBaseObject: TBaseObject;
begin
try
  PoseBaseObject := PlayObject.GetPoseCreate();
  if (PoseBaseObject <> nil) and (PoseBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (PoseBaseObject.m_btGender <> PlayObject.m_btGender) then begin
    PlayObject.m_sDearName := PoseBaseObject.m_sCharName;
    PlayObject.RefShowName;
    PoseBaseObject.RefShowName;
  end else begin
    GotoLable(PlayObject, '@MarryError', False);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGetMarry');
end;
end;

procedure TNormNpc.ActionOfGetMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseBaseObject: TBaseObject;
begin
try
  PoseBaseObject := PlayObject.GetPoseCreate();
  if (PoseBaseObject <> nil) and (PoseBaseObject.m_btRaceServer = RC_PLAYOBJECT) and (PoseBaseObject.m_btGender <> PlayObject.m_btGender) then begin
    PlayObject.m_sMasterName := PoseBaseObject.m_sCharName;
    PlayObject.RefShowName;
    PoseBaseObject.RefShowName;
  end else begin
    GotoLable(PlayObject, '@MasterError', False);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGetMaster');
end;
end;
//���ܣ�����NPC������Ϣ 20081214 ֧���Զ�����ɫ
//��ʽ: SENDMSG ��Ϣ���ʹ��� %s��Ϣ����%d ������ɫ(0-255) ������ɫ(0-255)
procedure TNormNpc.ActionOfLineMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg: string;
  sParam2: string;
  FColor, BColor: Byte;
  boIsCustom: Boolean;
begin
  try
    boIsCustom:= False;
    sParam2 := QuestActionInfo.sParam2;
    if (QuestActionInfo.sParam3 <> '') and (QuestActionInfo.sParam4 <> '') then begin//���������Զ�����ɫʱ
      FColor:= _MIN(255, Str_ToInt(QuestActionInfo.sParam3, 0));
      BColor:= _MIN(255, Str_ToInt(QuestActionInfo.sParam4, 0));
      boIsCustom:= True;
    end;
    GetValValue(PlayObject, QuestActionInfo.sParam2, sParam2);
    sMsg := GetLineVariableText(PlayObject, sParam2);
    sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
    sMsg := AnsiReplaceText(sMsg, '%x', IntToStr(PlayObject.m_nCurrX));
    sMsg := AnsiReplaceText(sMsg, '%y', IntToStr(PlayObject.m_nCurrY));
    if PlayObject.m_PEnvir <> nil then
      sMsg := AnsiReplaceText(sMsg, '%m', PlayObject.m_PEnvir.sMapDesc)
    else sMsg := AnsiReplaceText(sMsg, '%m', '????');
    sMsg := AnsiReplaceText(sMsg, '%d', m_sCharName);
    case QuestActionInfo.nParam1 of
      0: begin
        if not boIsCustom then UserEngine.SendBroadCastMsg(sMsg, t_System)
        else UserEngine.SendBroadCastMsg1(sMsg, t_System, FColor, BColor);
      end;//0
      1: begin
        if not boIsCustom then UserEngine.SendBroadCastMsg('(*) ' + sMsg, t_System)//������ͨ��ɫ�㲥��Ϣ
        else UserEngine.SendBroadCastMsg1('(*) ' + sMsg, t_System, FColor, BColor);
      end;//1
      2: begin
        if not boIsCustom then UserEngine.SendBroadCastMsg('[' + m_sCharName + ']' + sMsg, t_System)//������ͨ��ɫ�㲥��Ϣ������ʾNPC����
        else UserEngine.SendBroadCastMsg1('[' + m_sCharName + ']' + sMsg, t_System, FColor, BColor);
      end;//2
      3: begin
        if not boIsCustom then UserEngine.SendBroadCastMsg('[' + PlayObject.m_sCharName + ']' + sMsg, t_System)//������ͨ��ɫ�㲥��Ϣ��������NPC����
        else UserEngine.SendBroadCastMsg1('[' + PlayObject.m_sCharName + ']' + sMsg, t_System, FColor, BColor);
      end;//3
      4: begin
        if not boIsCustom then ProcessSayMsg(sMsg)//��NPCͷ������ʾ��ͨ˵����Ϣ
        else  ProcessSayMsg1(sMsg, FColor, BColor);
      end;//4
      5: begin
        if not boIsCustom then PlayObject.SysMsg(sMsg, c_Red, t_Say)//���ͺ�ɫ��Ϣ������
        else PlayObject.SysMsg1(sMsg, c_Red, t_Say, FColor, BColor);
      end;//5
      6: begin
        if not boIsCustom then PlayObject.SysMsg(sMsg, c_Green, t_Say)//������ɫ��Ϣ������
        else PlayObject.SysMsg1(sMsg, c_Green, t_Say, FColor, BColor);
      end;//6
      7: begin
        if not boIsCustom then PlayObject.SysMsg(sMsg, c_Blue, t_Say)//������ɫ��Ϣ������
        else PlayObject.SysMsg1(sMsg, c_Blue, t_Say, FColor, BColor);
      end;//7
      8: if PlayObject.m_MyGuild <> nil then begin
        if not boIsCustom then TGUild(PlayObject.m_MyGuild).SendGuildMsg(sMsg)//�����л���Ϣ
        else TGUild(PlayObject.m_MyGuild).SendGuildMsg1(sMsg, FColor, BColor);
      end;
      else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSENDMSG);
      end;  
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfLineMsg');
  end;
end;
//���ܣ������ı��ļ� 20081226
//��ʽ��CreateFile QuestDiary\NewFile.txt
procedure TNormNpc.ActionOfCreateFile(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  sFileName: string;
  SaveList: TStringList;
begin
  sFileName:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//�ı�·��
  if sFileName[1] = '\' then sFileName := Copy(sFileName, 2, Length(sFileName) - 1);
  if sFileName[2] = '\' then sFileName := Copy(sFileName, 3, Length(sFileName) - 2);
  if sFileName[3] = '\' then sFileName := Copy(sFileName, 4, Length(sFileName) - 3);
  sFileName:= g_Config.sEnvirDir + sFileName;

  SaveList := TStringList.Create;
  try
    if not FileExists(sFileName) then begin
      try
        SaveList.SaveToFile(sFileName);
      except
        MainOutMessage('�ļ�����ʧ�� => ' + sFileName);
      end;
    end;
  finally
    SaveList.Free;
  end;
end;
//-------------------------------------------------------------------------
//20080105 ���⹫��
//���˹�������
procedure TNormNpc.ActionOfSendTopMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg: string;
  sParam3: string;
  FColor,BColor:integer;
begin
try
  FColor:=QuestActionInfo.nParam1;
  BColor:=QuestActionInfo.nParam2;
  sParam3 := QuestActionInfo.sParam3;//��Ϣ����
  GetValValue(PlayObject, QuestActionInfo.sParam3, sParam3);
  sMsg := GetLineVariableText(PlayObject, sParam3);
  PlayObject.SendRefMsg(RM_MOVEMESSAGE, 0{0Ϊ����}, FColor, BColor, 0, sMsg);//20080704 �޸�,ʹ���˿��Կ�����Ϣ
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSendTopMsg');
end;
end;

//���ܣ���Ļ������ʾ���� 20081217
//��ʽ��SendCenterMsg ǰ��ɫ ����ɫ ��Ϣ���� ģʽ ��ʾʱ��(��)
//ģʽ 0�����Լ� 1���������� 2�����л� 3���͵�ǰ��ͼ
procedure TNormNpc.ActionOfSendCenterMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg, sParam3: string;
  I ,FColor, BColor, nTime, nMode: Integer;
  BaseObject: TPlayObject;
begin
  try
    nMode:= -1;
    FColor:=QuestActionInfo.nParam1;//ǰ��ɫ
    BColor:=QuestActionInfo.nParam2;//����ɫ
    if QuestActionInfo.sParam4 <> '' then nMode:= Str_ToInt(QuestActionInfo.sParam4, -1);//ģʽ
    nTime:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam5), 0);//ʱ��
    sParam3 := QuestActionInfo.sParam3;//��Ϣ����
    GetValValue(PlayObject, QuestActionInfo.sParam3, sParam3);
    sMsg := GetLineVariableText(PlayObject, sParam3);

    case nMode of
      0: PlayObject.SendMsg(PlayObject, RM_MOVEMESSAGE, 1{1Ϊ����}, FColor, BColor, nTime, sMsg);//��������
      1: begin
        if UserEngine.m_PlayObjectList.Count > 0 then begin
          for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
            BaseObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
            if BaseObject <> nil then begin
              if not BaseObject.m_boGhost then
                BaseObject.SendMsg(PlayObject, RM_MOVEMESSAGE, 1{1Ϊ����}, FColor, BColor, nTime, sMsg);
            end;
          end;
        end;
      end;//1
      2: begin//�����л�   
        if PlayObject.m_MyGuild <> nil then begin
          if UserEngine.m_PlayObjectList.Count > 0 then begin//20081008
            for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
              BaseObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
              if BaseObject <> nil then begin
                if not BaseObject.m_boDeath and not BaseObject.m_boGhost and
                  TGUild(PlayObject.m_MyGuild).IsMember(BaseObject.m_sCharName) then
                  BaseObject.SendMsg(PlayObject, RM_MOVEMESSAGE, 1{1Ϊ����}, FColor, BColor, nTime, sMsg);
              end;
            end;
          end;
        end;
      end;//2
      3: begin//��ǰ��ͼ
        if UserEngine.m_PlayObjectList.Count > 0 then begin//20081008
          for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
            BaseObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
            if BaseObject <> nil then begin
              if not BaseObject.m_boDeath and not BaseObject.m_boGhost and
                (BaseObject.m_PEnvir = PlayObject.m_PEnvir) then
                BaseObject.SendMsg(PlayObject, RM_MOVEMESSAGE, 1{1Ϊ����}, FColor, BColor, nTime, sMsg);
            end;
          end;
        end;
      end;//3
      else begin
        PlayObject.SendRefMsg(RM_MOVEMESSAGE, 1{1Ϊ����}, FColor, BColor, nTime, sMsg);//20080704 �޸�,ʹ���˿��Կ�����Ϣ
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfSendCenterMsg');
  end;
end;

//����򶥶˹���
procedure TNormNpc.ActionOfSendEditTopMsg(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMsg: string;
  sParam3: string;
  FColor,BColor:integer;
begin
try
  FColor:=QuestActionInfo.nParam1;
  BColor:=QuestActionInfo.nParam2;
  sParam3 := QuestActionInfo.sParam3;
  GetValValue(PlayObject, QuestActionInfo.sParam3, sParam3);
  sMsg := GetLineVariableText(PlayObject, sParam3);
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSendEditTopMsg');
end;
end;
//------------------------------���ϵͳ---------------------------------------
//����:����ƴ��� 20080619
//��ʽ:OPENMAKEWINE X(0,1) 0-������ͨ�� 1-����ҩ��
procedure TNormNpc.ActionOfOPENMAKEWINE(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nCode: Byte;
  I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  boIsCanOpenMakeWine: Boolean;
begin
try
  if TMerchant(self).m_boPlayMakeWine then begin//���NPC��ʶ
    nCode:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1), 2);//�򿪴��ڱ�ʶ
    if not nCode in [0,1] then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sOPENMAKEWINE);
      Exit;
    end;
    boIsCanOpenMakeWine:= False;//�Ƿ�������
    if PlayObject.m_ItemList.Count > 0 then begin
      for I := 0 to PlayObject.m_ItemList.Count - 1 do begin//�ж���Ұ����Ƿ��о���,����ɽ���,û���򷵻�
        UserItem := PlayObject.m_ItemList.Items[I];
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if (StdItem <> nil) and (StdItem.StdMode = 12) then begin//�о���
          boIsCanOpenMakeWine:= True;
          Break;
        end;
      end;
    end;
    if boIsCanOpenMakeWine then begin
      PlayObject.SendMsg(Self, RM_OPENMAKEWINE, 0, nCode, 0, 0, m_sCharName);
    end else begin
      GotoLable(PlayObject, '@NoCanMakeWine', False);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfOPENMAKEWINE');
end;
end;

//����:ȡ����õľ� 20080620
//��ʽ:GETGOODMAKEWINE
procedure TNormNpc.ActionOfGETGOODMAKEWINE(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  UserItem,UserItem1: pTUserItem;
  StdItem,StdItem1: pTStdItem;
begin
  PlayObject.bo_NPCMove:= False;//�Ƿ���,��NPC�߶� 20080704
  try
    if TMerchant(self).m_boPlayMakeWine then begin//���NPC��ʶ
      if PlayObject.m_boMakeWine then begin//��NPC���������
        //�ж����ʱ���Ƿ�,�����ʱ�������Ҷ�Ӧ�ľ�,���ҵ�����Ϊ0ʱ
        if (PlayObject.m_MakeWineTime = 0) and (PlayObject.n_MakeWineItmeType <> 0) then begin
           StdItem := UserEngine.GetMakeWineStdItem(PlayObject.n_MakeWineItmeType);
           if (StdItem <> nil) and (StdItem.AniCount = PlayObject.n_MakeWineType) then begin
             New(UserItem);
             if UserEngine.CopyToUserItemFromName(StdItem.Name, UserItem) then begin
                PlayObject.m_boMakeWine:= False;//�ı��ʶ,���ܰ������� 20081109
                if PlayObject.IsEnoughBag and PlayObject.IsAddWeightAvailable(StdItem.Weight) then begin//������λ����ŵ�������,û�����ӳ���Ʒ
                  //�ı�Ʒ�ʼ��ƾ���
                  UserItem.btValue[0]:= PlayObject.n_MakeWineQuality;//�Ƶ�Ʒ��
                  UserItem.btValue[1]:= PlayObject.n_MakeWineAlcohol;//�ƾ���
                  if PlayObject.n_MakeWineType = 2 then begin//ҩ��,��ҩ��ֵ
                    UserItem.btValue[2]:= _MAX( 1,PlayObject.n_MakeWineQuality - 5);//ҩ�����ٿ�������1��ҩ��ֵ 20081210
                  end;

                  if StdItem.NeedIdentify = 1 then
                    AddGameDataLog('38' + #9 +m_sMapName + #9 + IntToStr(m_nCurrX) + #9 +
                      IntToStr(m_nCurrY) + #9 + PlayObject.m_sCharName + #9 +StdItem.Name + #9 +
                      IntToStr(UserItem.MakeIndex) + #9 +IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1]) + #9 + m_sCharName);

                  PlayObject.m_ItemList.Add(UserItem);
                  if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
                    PlayObject.SendAddItem(UserItem);
                    PlayObject.SendUpdateItem(UserItem);//������Ʒ
                  end;

                  Randomize(); //�������
                  if (Random(g_Config.nMakeWineRate) = 0) and (PlayObject.n_MakeWineType=1) then begin//һ�����ʻ�þ��� 20080621
                     StdItem1 := UserEngine.GetMakeWineStdItem1(StdItem.Shape);//ͨ���Ƶ�Shape�õ�����
                     if StdItem1 <> nil then begin
                       New(UserItem1);
                       if UserEngine.CopyToUserItemFromName(StdItem1.Name, UserItem1) then begin
                          if PlayObject.IsEnoughBag and PlayObject.IsAddWeightAvailable(StdItem1.Weight) then begin
                            if StdItem1.NeedIdentify = 1 then
                              AddGameDataLog('38' + #9 +m_sMapName + #9 + IntToStr(m_nCurrX) + #9 +
                                IntToStr(m_nCurrY) + #9 + PlayObject.m_sCharName + #9 +StdItem1.Name + #9 +
                                IntToStr(UserItem1.MakeIndex) + #9 +'1' + #9 + m_sCharName);
                            PlayObject.m_ItemList.Add(UserItem1);
                            if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
                              PlayObject.SendAddItem(UserItem1);
                              PlayObject.SendUpdateItem(UserItem1);//������Ʒ
                            end;
                          end;
                       end else Dispose(UserItem1);
                     end;
                  end;
                  PlayObject.m_MakeWineTime := 0;
                  PlayObject.n_MakeWineItmeType:= 0;
                  PlayObject.n_MakeWineQuality:= 0;//��ƺ�,Ӧ�ÿ��Եõ��Ƶ�Ʒ�� 20080620
                  PlayObject.n_MakeWineAlcohol:= 0;//��ƺ�,Ӧ�ÿ��Եõ��Ƶľƾ��� 20080620
                  if PlayObject.m_PEnvir = m_PEnvir then GotoLable(PlayObject, '@EndMakeWine', False);//������ 20080711
                end else begin//�ӳ���Ʒ
                  PlayObject.DropItemDown(UserItem, 3, False,False, PlayObject, PlayObject);
                end;
             end else Dispose(UserItem);
           end;
        end;
        if (PlayObject.m_MakeWineTime > 0) and (PlayObject.m_PEnvir = m_PEnvir) then GotoLable(PlayObject, '@NoMakeWineTimeOver', False);//ʱ�仹û�е� 20080711
      end else begin
       if PlayObject.m_PEnvir = m_PEnvir then GotoLable(PlayObject, '@NoMakeWine', False);//û����� 20080711
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfGETGOODMAKEWINE');
  end;
end;

//����:������Ƶ�ʱ�� 20080620
//��ʽ:DECMAKEWINETIME N(��) D(1,2) X(0,1)
//����:D-1��ͨ�� 2-ҩ��
//     X-0��ָ��ֵ����,1-����ʱ����1������
procedure TNormNpc.ActionOfDECMAKEWINETIME(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nMakeWineType,nCode:Byte;
  mMakeWineTime: LongWord;
begin
  mMakeWineTime:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1), 0);//����ʱ��
  nMakeWineType:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2), 0);//������
  nCode:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3), 0);//��������
  try
  if TMerchant(self).m_boPlayMakeWine then begin//���NPC��ʶ
    if PlayObject.m_boMakeWine then begin//��NPC���������
      if PlayObject.n_MakeWineType = nMakeWineType then begin//�Ƶ�����һ��
         case nCode of
           0:begin//��ָ����ֵ����ʱ��
             PlayObject.m_MakeWineTime:=_MAX(0, PlayObject.m_MakeWineTime - mMakeWineTime);
             GotoLable(PlayObject, '@DecMakeWineTimeOK', False);
           end;
           1:begin//ʱ��������һ������
             PlayObject.m_MakeWineTime:= 60 - Random(10);
             GotoLable(PlayObject, '@DecMakeWineTimeOK', False);
           end;
         end;
      end else begin
        GotoLable(PlayObject, '@NoIsInMakeWine', False);//û�����
      end;
    end else begin
      GotoLable(PlayObject, '@NoIsInMakeWine', False);//û�����
    end;
  end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfDECMAKEWINETIME');
  end;
end;

//����:���NPC���߶� 20080621
//��ʽ:MAKEWINENPCMOVE
procedure TNormNpc.ActionOfMAKEWINENPCMOVE(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
begin
try
  if not PlayObject.bo_NPCMove then begin//�Ƿ���,��NPC�߶�(��ֹ��ͣ�ĵ��) 20080704
    if PlayObject.m_boMakeWine then begin//��NPC��������� 20080914
      PlayObject.bo_NPCMove:= True;
      SendRefMsg(RM_NPCWALK, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
    end else begin
      GotoLable(PlayObject, '@NoIsInMakeWine', False);//û�����
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfMAKEWINENPCMOVE');
end;
end;

//����:����Ȫˮ�緢
//��ʽ:FOUNTAIN ��ͼ X Y ʱ��(��)
procedure TNormNpc.ActionOfFOUNTAIN(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nX, nY, nTime:Integer;
  Envir: TEnvirnoment;
  sMap: String;
  FlowerEvent: TFlowerEvent;
begin
  try
    sMap:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1); //��ͼID ֧�ֱ���
    nX:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2), 0);//X
    nY:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3), 0);//Y
    nTime:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam4), 0);//Time
    if sMap ='' then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sFOUNTAIN);
      Exit;
    end;

    Envir := g_MapManager.FindMap(sMap);//���ҵ�ͼ����
    if Envir <> nil then begin
      if g_EventManager.GetEvent(Envir, nX, nY, ET_FOUNTAIN) <> nil then Exit;//����г�����,��ֱ���˳�
      FlowerEvent := TFlowerEvent.Create(Envir, nX, nY, ET_FOUNTAIN, nTime * 1000);
      g_EventManager.AddEvent(FlowerEvent);
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfFOUNTAIN');
  end;
end;

//����:����/�ر��л�Ȫˮ�ֿ� 20080625
//��ʽ:SETGUILDFOUNTAIN 0/1 (0-��,1-��)
procedure TNormNpc.ActionOfSETGUILDFOUNTAIN(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nCode:Byte;
begin
try
  nCode:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1), -1);
  if (nCode < 0) and (not nCode in [0,1]) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSETGUILDFOUNTAIN);
    Exit;
  end;
  if (PlayObject.m_MyGuild <> nil) and (PlayObject.m_nGuildRankNo = 1) then begin
    Case nCode of
      0:begin
         TGUild(PlayObject.m_MyGuild).boChanged:=True;
         TGUild(PlayObject.m_MyGuild).boGuildFountainOpen:= True;
         GotoLable(PlayObject, '@OpenGuildFountain', False);
      end;
      1:begin
        TGUild(PlayObject.m_MyGuild).boChanged:=True;
        TGUild(PlayObject.m_MyGuild).boGuildFountainOpen:= False;
        GotoLable(PlayObject, '@CloseGuildFountain', False);
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSETGUILDFOUNTAIN');
end;
end;

//����:��ȡ�л�Ȫˮ  20080625
//��ʽ:GIVEGUILDFOUNTAIN ��Ʒ�� ����
procedure TNormNpc.ActionOfGIVEGUILDFOUNTAIN(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  sItemName: string;
  nItemCount: Integer;
  I,nDate: Integer;
begin
try
  sItemName := GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//���ӱ���֧��
  nItemCount:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2), -1);//���� ֧�ֱ���
  if nItemCount < 0 then nItemCount := QuestActionInfo.nParam2;

  nDate:=Strtoint(FormatDatetime('YYYYMMDD',date));//��ǰ������
  if PlayObject.m_MyGuild <> nil then begin
    if TGUild(PlayObject.m_MyGuild).boGuildFountainOpen then begin//�л�Ȫˮ�ֿ⿪��
       if PlayObject.m_GiveGuildFountationDate <> nDate then begin
         if TGUild(PlayObject.m_MyGuild).m_nGuildFountain >=g_Config.nMinGuildFountain then begin//�л�������������ָ��ֵ
            TGUild(PlayObject.m_MyGuild).boChanged:=True;
            TGUild(PlayObject.m_MyGuild).m_nGuildFountain:= _MAX(0, TGUild(PlayObject.m_MyGuild).m_nGuildFountain - g_Config.nDecGuildFountain);
            PlayObject.m_GiveGuildFountationDate := nDate;//��ȡȪˮ������
            if UserEngine.GetStdItemIdx(sItemName) > 0 then begin
              if not (nItemCount in [1..50]) then nItemCount := 1; //12.28 ����һ��
              for I := 0 to nItemCount - 1 do begin //nItemCount Ϊ0ʱ����ѭ��
                if PlayObject.IsEnoughBag then begin
                  New(UserItem);
                  if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
                    PlayObject.m_ItemList.Add((UserItem));
                    PlayObject.SendAddItem(UserItem);
                    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
                    if StdItem.NeedIdentify = 1 then
                      AddGameDataLog('35' + #9 + PlayObject.m_sMapName + #9 +IntToStr(PlayObject.m_nCurrX) + #9 +
                        IntToStr(PlayObject.m_nCurrY) + #9 +PlayObject.m_sCharName + #9 +sItemName + #9 +
                        IntToStr(UserItem.MakeIndex) + #9 +'1' + #9 +m_sCharName);
                  end else Dispose(UserItem);
                end else begin
                  New(UserItem);
                  if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
                    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
                    if StdItem.NeedIdentify = 1 then
                      AddGameDataLog('35' + #9 + PlayObject.m_sMapName + #9 +IntToStr(PlayObject.m_nCurrX) + #9 +
                        IntToStr(PlayObject.m_nCurrY) + #9 + PlayObject.m_sCharName + #9 + sItemName + #9 +
                        IntToStr(UserItem.MakeIndex) + #9 +'1' + #9 + m_sCharName);
                    PlayObject.DropItemDown(UserItem, 3, False, False, PlayObject, PlayObject);
                  end;
                  Dispose(UserItem);
                end;
              end;
            end;
            GotoLable(PlayObject, '@GIVEFOUNTAIN_OK', False);//��ȡ�ɹ�
         end else GotoLable(PlayObject, '@NOGIVEFOUNTAIN', False);//�л�Ȫˮ������
      end else GotoLable(PlayObject, '@NOGIVEFOUNTAIN1', False);//����ȡ��Ȫˮ
    end else GotoLable(PlayObject, '@GIVEFOUNTAINColse', False);//�л��Ȫ�ر�
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGIVEGUILDFOUNTAIN');
end;
end;
//-----------------------------------------------------------------------------
//����:NPCѧϰ�ڹ� 20081002
//��ʽ:READSKILLNG Hero
procedure TNormNpc.ActionOfREADSKILLNG(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
begin
try
  if CompareText(QuestActionInfo.sParam1, 'HERO') = 0 then begin//Ӣ��ѧϰ
    if (PlayObject.m_MyHero <> nil) and (PlayObject.m_boTrainingNG) then begin//����ѧ��,Ӣ�۲���ѧϰ
      if not THeroObject(PlayObject.m_MyHero).m_boTrainingNG then begin//ûѧ���ڹ�
        THeroObject(PlayObject.m_MyHero).m_boTrainingNG:= True;
        THeroObject(PlayObject.m_MyHero).m_NGLevel := 1;
        THeroObject(PlayObject.m_MyHero).m_ExpSkill69 := 0;//�ڹ���ǰ���� 20081204
        PlayObject.m_MyHero.SendNGData;//�����ڹ����� 20081005
        PlayObject.m_MyHero.SendRefMsg(RM_MYSHOW, ET_OBJECTLEVELUP,0, 0, 0, ''); //������������  20081221
        GotoLable(PlayObject, '@ReadNGHeroOK', False);
      end else GotoLable(PlayObject, '@ReadNGHeroFail', False);
    end else GotoLable(PlayObject, '@ReadNGHeroFail', False);
  end else begin
    if not PlayObject.m_boTrainingNG then begin//ûѧ���ڹ�
      PlayObject.m_boTrainingNG:= True;
      PlayObject.m_NGLevel := 1;
      PlayObject.m_ExpSkill69 := 0;//�ڹ���ǰ���� 20081204
      PlayObject.SendNGData;//�����ڹ����� 20081005
      PlayObject.SendRefMsg(RM_MYSHOW, ET_OBJECTLEVELUP,0, 0, 0, ''); //������������  20081221
      GotoLable(PlayObject, '@ReadNGOK', False);
    end else GotoLable(PlayObject, '@ReadNGFail', False);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfREADSKILLNG');
end;
end;
//-----------------------------------------------------------------------------
//����:��ս��ͼ�ƶ� 20080705
//��ʽ:CHALLENGMAPMOVE ��ͼ�� X Y
procedure TNormNpc.ActionOfCHALLENGMAPMOVE(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nX, nY :Integer;
  Envir: TEnvirnoment;
  sMap: String;
  m_boMoveOK: Boolean;
begin
  try
    if (PlayObject.m_ChallengeCreat = nil) or (not PlayObject.m_boChallengeing) then Exit;
    m_boMoveOK:= False;
    sMap:=GetLineVariableText(PlayObject, QuestActionInfo.sParam1); //��ͼID ֧�ֱ���
    nX:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2), 0);//X
    nY:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3), 0);//Y
    if sMap ='' then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sCHALLENGMAPMOVE);
      Exit;
    end;

    Envir := g_MapManager.FindMap(sMap);//���ҵ�ͼ����
    if Envir <> nil then begin//�жϵ�ͼ�Ƿ����,
      m_boMoveOK:= True;
      if Envir.m_boFight4Zone then begin//��������ս��ͼ
         if PlayObject.m_ChallengeCreat.m_MyHero <> nil then  PlayObject.m_ChallengeCreat.ClientHeroLogOut(1); //Ӣ���˳�,û����ʾ
         if PlayObject.m_MyHero <> nil then  PlayObject.ClientHeroLogOut(1); //Ӣ���˳�,û����ʾ
         PlayObject.m_sLastMapName := PlayObject.m_sMapName;//20080706
         PlayObject.m_ChallengeCreat.m_sLastMapName := PlayObject.m_ChallengeCreat.m_sMapName;//20080706
         PlayObject.m_ChallengeCreat.MapRandomMove(sMap, 0);
         PlayObject.MapRandomMove(sMap, 0);
         PlayObject.m_ChallengeTime:= g_Config.nChallengeTime;//��ս��ʱ 20080705
         PlayObject.m_ChallengeCreat.m_ChallengeTime:= g_Config.nChallengeTime;//��ս��ʱ 20080705
      end;//if Envir.m_boFight4Zone
    end else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sCHALLENGMAPMOVE);
      Exit;
    end;
    if not m_boMoveOK then begin
       if g_FunctionNPC <> nil then g_FunctionNPC.GotoLable(PlayObject, '@Challenge_Fail', False);
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfCHALLENGMAPMOVE');
  end;
end;
//����:û����ս��ͼ���ƶ�,���˻ص�Ѻ����Ʒ
//��ʽ:GETCHALLENGEBAKITEM
procedure TNormNpc.ActionOfGETCHALLENGEBAKITEM(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
begin
  try
    if (PlayObject.m_ChallengeCreat = nil) or (not PlayObject.m_boChallengeing) then Exit;
    PlayObject.m_boChallengeing := False;
    if PlayObject.m_ChallengeCreat <> nil then begin
       PlayObject.m_ChallengeCreat.m_boChallengeing := False;
       PlayObject.m_ChallengeCreat.GetBackChallengeItems();
       PlayObject.m_ChallengeCreat.m_ChallengeCreat:=nil;
       PlayObject.m_ChallengeCreat.m_ChallengeLastTick := GetTickCount();
    end;
    PlayObject.m_ChallengeCreat := nil;
    PlayObject.GetBackChallengeItems();
    PlayObject.m_ChallengeLastTick := GetTickCount();
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfGETCHALLENGEBAKITEM');
  end;
end;
//-----------------------------------------------------------------------------
//����:��������Ӣ������  20080716
//��ʽ:HEROLOGOUT
procedure TNormNpc.ActionOfHEROLOGOUT(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
begin
  PlayObject.ClientHeroLogOut(0); //Ӣ���˳�
end;
//-----------------------------------------------------------------------------
//����:�޸�ħ��ID,���ҵȼ�Ϊ4 20080624
//��ʽ:CHANGESKILL ԭħ��ID ��ħ��ID Hero
procedure TNormNpc.ActionOfCHANGESKILL(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  Magic: pTMagic;
  UserMagic,UserMagic1: pTUserMagic;
  oldMagic,NewMagic: Word;
  I: Integer;
begin
try
  OldMagic:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1), 0);
  NewMagic:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2), 0);
  if CompareText(QuestActionInfo.sParam3, 'HERO') = 0 then begin
    if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then Exit;
    Magic := UserEngine.FindHeroMagic(NewMagic);
    if Magic <> nil then begin
      if PlayObject.m_MyHero <> nil then begin
        if not PlayObject.m_MyHero.IsTrainingSkill(Magic.wMagicId) then begin
          for I := PlayObject.m_MyHero.m_MagicList.Count - 1 downto 0 do begin//20080916 �޸�
            if PlayObject.m_MyHero.m_MagicList.Count <= 0 then Break;//20080916
            UserMagic := PlayObject.m_MyHero.m_MagicList.Items[I];
            if UserMagic <> nil then begin
              if UserMagic.MagicInfo.wMagicId = OldMagic then begin
                New(UserMagic1);
                UserMagic1.MagicInfo := Magic;
                UserMagic1.wMagIdx := Magic.wMagicId;
                UserMagic1.btKey := UserMagic.btKey;
                UserMagic1.btLevel := 4;
                UserMagic1.MagicInfo.btTrainLv := 3;
                UserMagic1.nTranPoint := UserMagic1.MagicInfo.MaxTrain[3];
                PlayObject.m_MyHero.m_MagicList.Delete(I);
                THeroObject(PlayObject.m_MyHero).SendDelMagic(UserMagic);
                PlayObject.m_MyHero.m_MagicList.Add(UserMagic1);
                THeroObject(PlayObject.m_MyHero).SendAddMagic(UserMagic1);
                THeroObject(PlayObject.m_MyHero).RecalcAbilitys();//20081213
                PlayObject.m_MyHero.CompareSuitItem(False);//200080729 ��װ
                Break;
              end;
            end;
          end;//for
        end;
      end;
    end;
  end else begin
    Magic := UserEngine.FindMagic(NewMagic);
    if Magic <> nil then begin
      if not PlayObject.IsTrainingSkill(Magic.wMagicId) then begin
        for I := PlayObject.m_MagicList.Count - 1 downto 0 do begin//20080916 �޸�
          if  PlayObject.m_MagicList.Count <= 0 then Break;//20080916
          UserMagic := PlayObject.m_MagicList.Items[I];
          if UserMagic <> nil then begin
            if UserMagic.MagicInfo.wMagicId = OldMagic then begin
              New(UserMagic1);
              UserMagic1.MagicInfo := Magic;
              UserMagic1.wMagIdx := Magic.wMagicId;
              UserMagic1.btKey := UserMagic.btKey;
              UserMagic1.btLevel := 4;
              UserMagic1.MagicInfo.btTrainLv := 3;
              UserMagic1.nTranPoint := UserMagic1.MagicInfo.MaxTrain[3];
              PlayObject.m_MagicList.Delete(I);
              PlayObject.SendDelMagic(UserMagic);
              PlayObject.m_MagicList.Add(UserMagic1);
              PlayObject.SendAddMagic(UserMagic1);
              PlayObject.RecalcAbilitys();
              PlayObject.CompareSuitItem(False);//200080729 ��װ
              Break;
            end;
          end;
        end;//for
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfCHANGESKILL');
end;
end;
//-----------------------------------------------------------------------------
//����:�Զ�Ѱ· 20080617
//��ʽ:AUTOGOTOXY X Y
procedure TNormNpc.ActionOfAUTOGOTOXY(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nX, nY:Integer;
begin
try
  nX:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1), 0);//X
  nY:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2), 0);//Y
  PlayObject.SendMsg(Self, RM_AUTOGOTOXY, 0, nX, nY, 0, '');
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfAUTOGOTOXY');
end;
end;
//-----------------------------------------------------------------------------
//����ȫ��װ�� 20080613
//��ʽ��RepairAll (HERO)
procedure TNormNpc.ActionOfRepairAll(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nWhere: Integer;
  sCheckItemName: string;
  StdItem: pTStdItem;
begin
try
  if CompareText(QuestActionInfo.sParam1, 'HERO') = 0 then begin
    if PlayObject.m_MyHero <> nil then begin
      for nWhere := Low(THumanUseItems) to High(THumanUseItems) do begin
        if PlayObject.m_MyHero.m_UseItems[nWhere].wIndex > 0 then begin
          StdItem := UserEngine.GetStdItem(PlayObject.m_MyHero.m_UseItems[nWhere].wIndex);
          if StdItem <> nil then begin
            if ((PlayObject.m_MyHero.m_UseItems[nWhere].DuraMax div 1000) > (PlayObject.m_MyHero.m_UseItems[nWhere].Dura div 1000)) and (StdItem.StdMode<>7) and (StdItem.StdMode<>25) and (StdItem.StdMode<>43) and (StdItem.AniCount<>21) then begin
              if CheckItemValue(@PlayObject.m_MyHero.m_UseItems[nWhere], 3) then Continue //20080314 ��ֹ��
              else
              {if Assigned(zPlugOfEngine.CheckCanRepairItem) then begin
                sCheckItemName := StdItem.Name;
                if not zPlugOfEngine.CheckCanRepairItem(PlayObject, PChar(sCheckItemName)) then Continue;//����Ƿ��ǲ����޸�����Ʒ
              end;}
              if PlayObject.m_MyHero.PlugOfCheckCanItem(3, StdItem.Name, False, 0, 0) then Continue;//��ֹ��Ʒ����(����������) 20080729

              PlayObject.m_MyHero.m_UseItems[nWhere].Dura := PlayObject.m_MyHero.m_UseItems[nWhere].DuraMax;
              PlayObject.SendMsg(PlayObject.m_MyHero, RM_HERODURACHANGE, nWhere, PlayObject.m_MyHero.m_UseItems[nWhere].Dura, PlayObject.m_MyHero.m_UseItems[nWhere].DuraMax, 0, '');
            end;//if ((m_UseItems[nWhere].DuraMax div 1000)
          end;//if StdItem <> nil then begin
        end;
      end;
    end;
  end else begin
    for nWhere := Low(THumanUseItems) to High(THumanUseItems) do begin
      if PlayObject.m_UseItems[nWhere].wIndex > 0 then begin
        StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nWhere].wIndex);
        if StdItem <> nil then begin
          if ((PlayObject.m_UseItems[nWhere].DuraMax div 1000) > (PlayObject.m_UseItems[nWhere].Dura div 1000)) and (StdItem.StdMode<>7) and (StdItem.StdMode<>25) and (StdItem.StdMode<>43) and (StdItem.AniCount<>21) then begin
            if CheckItemValue(@PlayObject.m_UseItems[nWhere], 3) then Continue //20080314 ��ֹ��
            else
            {if Assigned(zPlugOfEngine.CheckCanRepairItem) then begin
              sCheckItemName := StdItem.Name;
              if not zPlugOfEngine.CheckCanRepairItem(PlayObject, PChar(sCheckItemName)) then Continue;//����Ƿ��ǲ����޸�����Ʒ
            end; }
            if PlayObject.PlugOfCheckCanItem(3, StdItem.Name, False, 0, 0) then Continue;//��ֹ��Ʒ����(����������) 20080729

            PlayObject.m_UseItems[nWhere].Dura := PlayObject.m_UseItems[nWhere].DuraMax;
            PlayObject.SendMsg(PlayObject, RM_DURACHANGE, nWhere, PlayObject.m_UseItems[nWhere].Dura, PlayObject.m_UseItems[nWhere].DuraMax, 0, '');
          end;//if ((m_UseItems[nWhere].DuraMax div 1000)
        end;//if StdItem <> nil then begin
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfRepairAll');
end;
end;
//-----------------------------------------------------------------------------
//�߳��������������� 20080609
//��ʽ:KICKALLPLAY
procedure TNormNpc.ActionOfKICKALLPLAY(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
begin
try
  if UserEngine.m_PlayObjectList.Count > 0 then begin//20080629
    for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
      TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_boKickFlag := True;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfKICKALLPLAY');
end;
end;
//-----------------------------------------------------------------------------
//���ܣ����������лṥ�� 20080609
//��ʽ��ADDATTACKSABUKALL �Ǳ���
procedure TNormNpc.ActionOfADDATTACKSABUKALL(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  Castle: TUserCastle;
  nIndex, I: Integer;
  Guild: TGUild;
begin
  try
    nIndex:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1), 0);//�Ǳ�ID
    Castle := g_CastleManager.GetCastle(nIndex);

    if g_GuildManager.GuildList.Count > 0 then begin//20080629
      for I := 0 to g_GuildManager.GuildList.Count - 1 do begin
        Guild := TGUild(g_GuildManager.GuildList.Items[I]);
        Castle.AddAttackerInfo(Guild,1);
        //Castle.m_AttackGuildList.Add(Guild);//���뵱ǰ�����б� 20080816
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfADDATTACKSABUKALL');
  end;
end;
//-----------------------------------------------------------------------------
//����:����ָ����վ��ַ 20080602
//��ʽ:WebBrowser http://www.zhaopk.net
procedure TNormNpc.ActionOfWEBBROWSER(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  Url: string;
begin
try
  Url := GetLineVariableText(PlayObject, QuestActionInfo.sParam1);
  if Url ='' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sWEBBROWSER);
    Exit;
  end;
  if pos('http://', Url) = 0 then Url := 'http://'+Url;
  PlayObject.SendMsg(Self, RM_Browser, 0, 0, 0, 0, Url);
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfWEBBROWSER');
end;
end;

//ȡָ�����а�ָ��������������� 20080531
//��ʽ:GETSORTNAME ���� Type(���а�) ����
//nType 1-�ȼ��� 2-սʿ�� 3-��ʦ�� 4-��ʿ��
procedure TNormNpc.ActionOfGETSORTNAME(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nType: Byte;
  nIndex,n14: Integer;
  StringList: TStringList;
  CharName: pTCharName;
begin
try
  n14 := GetValNameNo(QuestActionInfo.sParam1);//����
  nType:= QuestActionInfo.nParam2;//���а�����
  nIndex:= QuestActionInfo.nParam3;//����
  if (n14 < 600) or (not nType in [1..4]) or (nIndex <= 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sGETSORTNAME);
    Exit;
  end;
  EnterCriticalSection(HumanSortCriticalSection);
  try
  case nType of
    1: StringList := UserEngine.m_PlayObjectLevelList;
    2: StringList := UserEngine.m_WarrorObjectLevelList;
    3: StringList := UserEngine.m_WizardObjectLevelList;
    4: StringList := UserEngine.m_TaoistObjectLevelList;
  end;
  if StringList <> nil then begin
    if (nIndex -1) <= StringList.Count then begin
       CharName := pTCharName(StringList.Objects[nIndex - 1]);
       if n14 >= 600 then begin
         case n14 of
           600..699: PlayObject.m_sString[n14 - 600] := CharName^;
           700..799: g_Config.GlobalAVal[n14 - 700] := CharName^;
           1200..1599: g_Config.GlobalAVal[n14 - 1100] := CharName^;
         end;
       end;
    end;
  end;
  finally
    LeaveCriticalSection(HumanSortCriticalSection);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGETSORTNAME');
end;
end;

//���� 20080119
procedure TNormNpc.ActionOfOPENBOOKS(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
try
  if QuestActionInfo.nParam1 in [0..5] then
    PlayObject.SendMsg(Self, RM_OPENBOOKS, 0, QuestActionInfo.nParam1{����}, 0, 0, '');
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfOPENBOOKS');
end;
end;
//=========================Ԫ������ϵͳ=========================================
//��ͨԪ������ 20080316
procedure TNormNpc.ActionOfOPENYBDEAL(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGameGold:Integer;
begin
try
  if PlayObject.bo_YBDEAL then begin
    PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName+'/���ѿ�ͨ���۷���,����Ҫ�ٿ�ͨ������\ \<����/@main>');
    Exit;//���ѿ�ͨԪ���������˳�
  end;
  nGameGold := Str_ToInt(QuestActionInfo.sParam1, 0);
  if not (nGameGold > 0) then nGameGold:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam1), 0);
  if PlayObject.m_nGameGold >= nGameGold then begin//��ҵ�Ԫ�������ڻ���ڿ�ͨ�����Ԫ����
    Dec(PlayObject.m_nGameGold,nGameGold);
    PlayObject.bo_YBDEAL:=True;
    PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName+'/��ͨ���۷���ɹ�������\ \<����/@main>');
  end else PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName+'/������û��'+g_Config.sGameGoldName+',��'+g_Config.sGameGoldName+'������������\ \<����/@main>');
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfOPENYBDEAL');
end;
end;

//(Ԫ��)��ѯ���ڳ��۵���Ʒ 20080317
procedure TNormNpc.ActionOfQUERYYBSELL(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I,K: Integer;
  DealOffInfo: TDealOffInfo;
  sSendStr, sUserItemName: String;
  sClientDealOffInfo: TClientDealOffInfo;
  StdItem: pTStdItem;
  StdItem80: TStdItem;
  bo12: Boolean;
begin
try
  bo12:= False;
  if PlayObject.bo_YBDEAL then begin //�ѿ�ͨԪ������
    if PlayObject.SellOffInTime(0) then begin
      if sSellOffItemList.Count > 0 then begin//20080629
        for I := 0 to sSellOffItemList.Count - 1 do begin
          DealOffInfo:= pTDealOffInfo(sSellOffItemList.Items[I])^;
          if (CompareText(DealOffInfo.sDealCharName, PlayObject.m_sCharName) = 0 ) and (DealOffInfo.N in [0,3]) then begin
              for K:=0 to 9 do begin
                StdItem := UserEngine.GetStdItem(DealOffInfo.UseItems[K].wIndex);
                if (StdItem = nil) then begin
                  if not bo12 and (DealOffInfo.UseItems[K].MakeIndex > 0 ) and (DealOffInfo.UseItems[K].wIndex=High(Word)) and  //�ǽ��ʯ
                   (DealOffInfo.UseItems[K].Dura = High(Word)) and (DealOffInfo.UseItems[K].DuraMax = High(Word)) then begin
                     with sClientDealOffInfo.UseItems[K] do begin
                       s.Name:= g_Config.sGameDiaMond{'���ʯ'}+'('+Inttostr(DealOffInfo.UseItems[K].MakeIndex)+')';
                       s.Price:= DealOffInfo.UseItems[K].MakeIndex;//���ʯ����
                       Dura := High(Word); //�ͻ��˽��ʯ���� 20080319
                       s.DuraMax := High(Word); //�ͻ��˽��ʯ���� 20080319
                       s.Looks:= High(Word);//����ʾͼƬ 20080319
                       bo12:= True;
                     end;
                  end else sClientDealOffInfo.UseItems[K].s.Name :='';
                  Continue;
                end;
                StdItem80:=StdItem^;
                ItemUnit.GetItemAddValue(@DealOffInfo.UseItems[K], StdItem80);
                Move(StdItem80, sClientDealOffInfo.UseItems[K].s, SizeOf(TStdItem));
             
                //ȡ�Զ�����Ʒ����
                sUserItemName := '';
                if DealOffInfo.UseItems[K].btValue[13] = 1 then
                  sUserItemName := ItemUnit.GetCustomItemName(DealOffInfo.UseItems[K].MakeIndex, DealOffInfo.UseItems[K].wIndex);
                if DealOffInfo.UseItems[K].btValue[12] = 1 then sClientDealOffInfo.UseItems[K].s.Reserved1:=1 //��Ʒ���� 20080223
                 else sClientDealOffInfo.UseItems[K].s.Reserved1:= 0;

                if sUserItemName <> '' then
                  sClientDealOffInfo.UseItems[K].s.Name := sUserItemName;

                sClientDealOffInfo.UseItems[K].MakeIndex := DealOffInfo.UseItems[K].MakeIndex;
                sClientDealOffInfo.UseItems[K].Dura := DealOffInfo.UseItems[K].Dura;
                sClientDealOffInfo.UseItems[K].DuraMax := DealOffInfo.UseItems[K].DuraMax;
                //if StdItem.StdMode = 50 then //20080808 ע��
                //  sClientDealOffInfo.UseItems[K].s.Name := sClientDealOffInfo.UseItems[K].s.Name + ' #' + IntToStr(DealOffInfo.UseItems[K].Dura);

                Case StdItem.StdMode of
                  15, 19..24, 26:begin
                    if DealOffInfo.UseItems[K].btValue[8] <> 0 then sClientDealOffInfo.UseItems[K].s.Shape := 130;
                  end;
                  60:begin
                    if (StdItem.shape <> 0) then begin//����,���վ��� 20080622
                      if DealOffInfo.UseItems[K].btValue[0] <> 0 then sClientDealOffInfo.UseItems[K].s.AC:=DealOffInfo.UseItems[K].btValue[0];//�Ƶ�Ʒ��
                      if DealOffInfo.UseItems[K].btValue[1] <> 0 then sClientDealOffInfo.UseItems[K].s.MAC:=DealOffInfo.UseItems[K].btValue[1];//�Ƶľƾ���
                    end;
                  end;
                end;
              end;
              sClientDealOffInfo.sDealCharName:= DealOffInfo.sDealCharName;
              sClientDealOffInfo.sBuyCharName:= DealOffInfo.sBuyCharName;
              sClientDealOffInfo.dSellDateTime:= DealOffInfo.dSellDateTime;
              sClientDealOffInfo.nSellGold:= DealOffInfo.nSellGold;
              sClientDealOffInfo.N:= DealOffInfo.N;
              sSendStr := EncodeBuffer(@sClientDealOffInfo, SizeOf(TClientDealOffInfo));
              PlayObject.SendMsg(Self, RM_QUERYYBSELL, 0, 0, 0, 0, sSendStr);
              Break;
          end;
        end;//for
      end;
    end else GotoLable(PlayObject, '@AskYBSellFail', False);
  end else PlayObject.SendMsg(PlayObject, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, '��δ��ͨԪ�����۷���,���ȿ�ͨ������');
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfQUERYYBSELL');
end;
end;

//(Ԫ��)��ѯ���ԵĹ�����Ʒ 20080317
procedure TNormNpc.ActionOfQUERYYBDEAL(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I, K: Integer;
  DealOffInfo: TDealOffInfo;
  sSendStr, sUserItemName: String;
  sClientDealOffInfo: TClientDealOffInfo;
  StdItem: pTStdItem;
  StdItem80: TStdItem;
  bo12: Boolean;
begin
try
  bo12:= False;
  if PlayObject.bo_YBDEAL then begin //�ѿ�ͨԪ������
    if PlayObject.SellOffInTime(1) then begin
      if sSellOffItemList.Count > 0 then begin//20080629
        for I := 0 to sSellOffItemList.Count - 1 do begin
          DealOffInfo:= pTDealOffInfo(sSellOffItemList.Items[I])^;
          if (CompareText(DealOffInfo.sBuyCharName, PlayObject.m_sCharName) = 0 ) and (DealOffInfo.N = 0) then begin
              for K:=0 to 9 do begin
                StdItem := UserEngine.GetStdItem(DealOffInfo.UseItems[K].wIndex);
                if StdItem = nil then begin
                  if not bo12 and (DealOffInfo.UseItems[K].MakeIndex > 0 ) and (DealOffInfo.UseItems[K].wIndex=High(Word)) and  //�ǽ��ʯ
                   (DealOffInfo.UseItems[K].Dura = High(Word)) and (DealOffInfo.UseItems[K].DuraMax = High(Word)) then begin
                     with sClientDealOffInfo.UseItems[K] do begin
                       s.Name:= g_Config.sGameDiaMond{'���ʯ'}+'('+Inttostr(DealOffInfo.UseItems[K].MakeIndex)+')';
                       s.Price:= DealOffInfo.UseItems[K].MakeIndex;//���ʯ����
                       Dura := High(Word); //�ͻ��˽��ʯ���� 20080319
                       s.DuraMax := High(Word); //�ͻ��˽��ʯ���� 20080319
                       s.Looks:= High(Word);//����ʾͼƬ 20080319
                       bo12:= True;
                     end;
                  end else sClientDealOffInfo.UseItems[K].s.Name :='';
                  Continue;
                end;
                StdItem80:=StdItem^;
                ItemUnit.GetItemAddValue(@DealOffInfo.UseItems[K],StdItem80);
                Move(StdItem80, sClientDealOffInfo.UseItems[K].s, SizeOf(TStdItem));

                //ȡ�Զ�����Ʒ����
                sUserItemName := '';
                if DealOffInfo.UseItems[K].btValue[13] = 1 then
                  sUserItemName := ItemUnit.GetCustomItemName(DealOffInfo.UseItems[K].MakeIndex, DealOffInfo.UseItems[K].wIndex);
                if DealOffInfo.UseItems[K].btValue[12] = 1 then sClientDealOffInfo.UseItems[K].s.Reserved1:=1 //��Ʒ���� 20080223
                 else sClientDealOffInfo.UseItems[K].s.Reserved1:= 0;

                if sUserItemName <> '' then
                  sClientDealOffInfo.UseItems[K].s.Name := sUserItemName;

                sClientDealOffInfo.UseItems[K].MakeIndex := DealOffInfo.UseItems[K].MakeIndex;
                sClientDealOffInfo.UseItems[K].Dura := DealOffInfo.UseItems[K].Dura;
                sClientDealOffInfo.UseItems[K].DuraMax := DealOffInfo.UseItems[K].DuraMax;
                //if StdItem.StdMode = 50 then//20080808 ע��
                //  sClientDealOffInfo.UseItems[K].s.Name := sClientDealOffInfo.UseItems[K].s.Name + ' #' + IntToStr(DealOffInfo.UseItems[K].Dura);

                Case StdItem.StdMode of
                  15, 19..24, 26:begin
                    if DealOffInfo.UseItems[K].btValue[8] <> 0 then sClientDealOffInfo.UseItems[K].s.Shape := 130;
                  end;
                  60:begin
                    if (StdItem.shape <> 0) then begin//����,���վ��� 20080622
                      if DealOffInfo.UseItems[K].btValue[0] <> 0 then sClientDealOffInfo.UseItems[K].s.AC:=DealOffInfo.UseItems[K].btValue[0];//�Ƶ�Ʒ��
                      if DealOffInfo.UseItems[K].btValue[1] <> 0 then sClientDealOffInfo.UseItems[K].s.MAC:=DealOffInfo.UseItems[K].btValue[1];//�Ƶľƾ���
                    end;
                  end;
                end;
              end;
              sClientDealOffInfo.sDealCharName:= DealOffInfo.sDealCharName;
              sClientDealOffInfo.sBuyCharName:= DealOffInfo.sBuyCharName;
              sClientDealOffInfo.dSellDateTime:= DealOffInfo.dSellDateTime;
              sClientDealOffInfo.nSellGold:= DealOffInfo.nSellGold;
              sClientDealOffInfo.N:= DealOffInfo.N;
              sSendStr := EncodeBuffer(@sClientDealOffInfo, SizeOf(TClientDealOffInfo));
              PlayObject.SendMsg(Self, RM_QUERYYBDEAL, 0, 0, 0, 0, sSendStr);
              Break;
          end;
        end;//for
      end;
    end else GotoLable(PlayObject, '@AskYBDealFail', False);
  end else PlayObject.SendMsg(PlayObject, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, '��δ��ͨԪ�����۷���,���ȿ�ͨ������');
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfQUERYYBDEAL');
end;
end;
//==============================================================================
//�ı䴩��ģʽ 20080221    THROUGHHUM M S //M:ģʽ[-1=�ָ�/0=���˴���/1=����/2=����] S:ʱ��(��)
procedure TNormNpc.ActionOfTHROUGHHUM(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nMode:Integer;
begin
try
  nMode:= QuestActionInfo.nParam1;//ģʽ[-1=�ָ�/0=���˴���/1=����/2=����]
  PlayObject.dwRunHumanModeTime:= QuestActionInfo.nParam2 * 1000; //ʱ��(��)

  case nMode of
    -1: begin
        g_Config.boRUNHUMAN := Config.ReadBool('Setup', 'RunHuman', g_Config.boRUNHUMAN);
        g_Config.boRUNMON := Config.ReadBool('Setup', 'RunMon', g_Config.boRUNMON);
      end;
     0: begin
       g_Config.boRUNHUMAN:= True;//����
       g_Config.boRUNMON:= True;//����
       PlayObject.dwRunHumanModeTick:= GetTickCount();
       PlayObject.m_boRunHumanMode:= True;
      end;
     1: begin
       g_Config.boRUNMON:= True;//����
       PlayObject.dwRunHumanModeTick:= GetTickCount();
       PlayObject.m_boRunHumanMode:= True;
      end;
     2: begin
       g_Config.boRUNHUMAN:= True;//����
       PlayObject.dwRunHumanModeTick:= GetTickCount();
       PlayObject.m_boRunHumanMode:= True;
      end;
  end;
  PlayObject.SendServerConfig;//����������Ϣ���ͻ���
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfTHROUGHHUM');
end;
end;
//-----------------------------------------------------------------------------
//װ���������� 20080223   ��ʽ:SetItemsLight װ��λ��(0-12) �Ƿ񷢹�(1���⣬0������)
procedure TNormNpc.ActionOfSetItemsLight(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nItem, nLight:Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
try
  nItem:= Str_ToInt(QuestActionInfo.sParam1, -1);//װ��λ��
  nLight:= Str_ToInt(QuestActionInfo.sParam2, 0);//�Ƿ񷢹�
  if nItem < 0 then GetValValue(PlayObject, QuestActionInfo.sParam1, nItem); //���ӱ���֧��
  if nLight < 0 then GetValValue(PlayObject, QuestActionInfo.sParam2, nLight); //���ӱ���֧��
  if (nItem < 0) or (nItem > High(THumanUseItems)) or (not nLight in [0,1]) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSETITEMSLIGHT);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nItem];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    //PlayObject.SysMsg('������û�д�ָ����Ʒ������', c_Red, t_Hint);
    Exit;
  end;
   //��ֵ����
  UserItem.btValue[12] := nLight;
  PlayObject.SendUpdateItem(UserItem);//������Ʒ
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSetItemsLight');
end;
end;
//-----------------------------------------------------------------------------
//���������� 20080306   ��ʽ:OpenDragonBoxs 5  ��5���͵ı���
procedure TNormNpc.ActionOfOpenDragonBox(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  nItem: Integer;
begin
try
  nItem:= Str_ToInt(QuestActionInfo.sParam1, -1);//��������
  if nItem < 0 then GetValValue(PlayObject, QuestActionInfo.sParam1, nItem); //���ӱ���֧��
  if nItem < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sOpenDragonBox);
    Exit;
  end;

  if PlayObject.ClientOpenBoxs(nItem) then //���俪��
     PlayObject.SendMsg(Self, RM_OPENDRAGONBOXS, 0, 0, 0, 0, '');
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfOpenDragonBox');
end;
end;
//-----------------------------------------------------------------------------
//���ܣ��򿪴������ܴ���
//��ʽ:QUERYREFINEITEM
procedure TNormNpc.ActionOfQUERYREFINEITEM(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
begin
try
  if (not PlayObject.m_boDeath) and (not PlayObject.m_boGhost) then begin
    PlayObject.SendMsg(Self, RM_QUERYREFINEITEM, 0, 0, 0, 0, '');
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfQUERYREFINEITEM');
end;
end;
//-----------------------------------------------------------------------------
//���ܣ��ƶ����سǵ� 20080503
//��ʽ:GOHOME
procedure TNormNpc.ActionOfGOHOME(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
begin
try
  if (not PlayObject.m_boDeath) and (not PlayObject.m_boGhost) then begin
     PlayObject.MoveToHome();//�ƶ����سǵ�
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGOHOME');
end;
end;
//-----------------------------------------------------------------------------
//���ܣ���ָ����Ʒˢ�µ�ָ����ͼ���귶Χ�� 20080508
//��ʽ�� THROWITEM ��ͼ X Y ��Χ ��Ʒ���� ����
procedure TNormNpc.ActionOfTHROWITEM(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
  function GetDropRandomPosition(nOrgX, nOrgY, nRange: Integer; var nDX: Integer; var nDY: Integer): Boolean;
  var
    I, II, III: Integer;
    nItemCount, n24, n28, n2C: Integer;
  begin
    n24 := 999;
    Result := False;
    n28 := 0; //09/10
    n2C := 0; //09/10
    for I := 1 to nRange do begin
      for II := -I to I do begin
        for III := -I to I do begin
          nDX := nOrgX + Random(nRange) + III;
          nDY := nOrgY + Random(nRange) + II;
          if m_PEnvir.GetItemEx(nDX, nDY, nItemCount) = nil then begin
            if m_PEnvir.bo2C then begin
              Result := True;
              Break;
            end;
          end else begin
            if m_PEnvir.bo2C and (n24 > nItemCount) then begin
              n24 := nItemCount;
              n28 := nDX;
              n2C := nDY;
            end;
          end;
        end;
        if Result then Break;
      end;
      if Result then Break;
    end;
    if not Result then begin
      if n24 < 8 then begin
        nDX := n28;
        nDY := n2C;
      end else begin
        nDX := nOrgX;
        nDY := nOrgY;
      end;
    end;
  end;
var
  sMap, sItemName, sUserItemName: string;
  I, idura, nX, nY, nRange, nCount, dX, dY: Integer;
  Envir: TEnvirnoment;
  MapItem, pr: PTMapItem;
  StdItem: pTStdItem;
  UserItem: pTUserItem;
begin
try
  sMap:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1); //��ͼ ֧�ֱ���
  nX:= Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2), -1);//X ֧�ֱ���
  nY:= Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam3), -1);//Y ֧�ֱ���
  nRange:= Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam4), -1);//��Χ ֧�ֱ���
  sItemName:= GetLineVariableText(PlayObject,QuestActionInfo.sParam5);//��Ʒ���� ֧�ֱ���
  nCount:= Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam6), -1);//���� ֧�ֱ���

  if (sMap = '') or (nX < 0) or (nY < 0) or (nRange < 0) or (sItemName = '') or (nCount <= 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sTHROWITEM);
    Exit;
  end;
  
  //if not CanMakeItem(sItemName) then Exit;//�Ƿ��ǽ�ֹ�������Ʒ 20080509
  Envir:= g_MapManager.FindMap(sMap);//���ҵ�ͼ,��ͼ���������˳�
  if Envir = nil then Exit;
  
  if nCount <= 0 then nCount:= 1;//20081008
  for I := 0 to nCount - 1 do begin
    New(UserItem);
    if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
      if CheckItemValue( UserItem,5) then Exit;//�Ƿ��ֹ����
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then begin
        if StdItem.StdMode = 40 then begin
          idura := UserItem.Dura;
          idura := idura - 2000;
          if idura < 0 then idura := 0;
          UserItem.Dura := idura;
        end;
        New(MapItem);
        MapItem.UserItem := UserItem^;
        MapItem.Name := StdItem.Name;

        //ȡ�Զ�����Ʒ����
        sUserItemName := '';
        if UserItem.btValue[13] = 1 then begin
          sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
          if sUserItemName <> '' then MapItem.Name := sUserItemName;
        end;
        MapItem.Looks := StdItem.Looks;
        if StdItem.StdMode = 45 then  MapItem.Looks := GetRandomLook(MapItem.Looks, StdItem.Shape);
        MapItem.AniCount := StdItem.AniCount;
        MapItem.Reserved := 0;
        MapItem.Count := 1;
        MapItem.OfBaseObject := nil;
        MapItem.dwCanPickUpTick := GetTickCount();
        MapItem.DropBaseObject := nil;
        
        //GetDropPosition(nX, nY, nRange, dx, dy);//ȡ����Ʒ��λ��
        GetDropRandomPosition(nX, nY, nRange, dx, dy);
        pr := Envir.AddToMap(dx, dy, OS_ITEMOBJECT, TObject(MapItem));
        if pr = MapItem then begin
          SendRefMsg(RM_ITEMSHOW, MapItem.Looks, Integer(MapItem), dx, dy, MapItem.Name);
        end else begin
          Dispose(MapItem);
          Break;
        end;
      end;//if StdItem <> nil then begin
    end;//if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
  end;//for I := 0 to nCount - 1 do begin
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfTHROWITEM');
end;
end;
//-----------------------------------------------------------------------------
//����:ɾ��ָ���ı���ı��� 20080410
//��ʽ:CLEARCODELIST ��ұ��� �ı�·��
//����:CLEARCODELIST <$STR(S1)> ..\questdiary\��ֵ\500Ԫ����.txt
procedure TNormNpc.ActionOfCLEARCODELIST(PlayObject: TPlayObject;QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  LoadList: TStringList;
  sPlayID , sLine, sFileName: string;
begin
try
  try
    sPlayID := GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//���ӱ���֧�� 20080410 �û��ı���,��������ַ�
    if (sPlayID = '') then  GetValValue(PlayObject, QuestActionInfo.sParam1, sPlayID);//20080502
    sFileName:= QuestActionInfo.sParam2;//�ı�·��
    if sFileName[1] = '\' then sFileName := Copy(sFileName, 2, Length(sFileName) - 1);
    if sFileName[2] = '\' then sFileName := Copy(sFileName, 3, Length(sFileName) - 2);
    if sFileName[3] = '\' then sFileName := Copy(sFileName, 4, Length(sFileName) - 3);
    sFileName:= g_Config.sEnvirDir + sFileName;

    LoadList := TStringList.Create;
    if FileExists(sFileName) then begin
      LoadList.LoadFromFile(sFileName);
      if LoadList.Count > 0 then begin//20080629
        for I := 0 to LoadList.Count - 1 do begin
          sLine := Trim(LoadList.Strings[I]);
          if (sLine = '') or (sLine[1] = ';') then Continue;
          if CompareText(sLine, sPlayID) = 0 then begin
            LoadList.Delete(I);
            LoadList.SaveToFile(sFileName);
            Break;
          end;
        end;
      end;
    end else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sCLEARCODELIST);
    end;
  finally
    LoadList.Free;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfCLEARCODELIST');
end;
end;
//-----------------------------------------------------------------------------
//���ļ������ȡ�ı�   ��ʽ��GetRandomName �ı�(ȫ·��) �ַ�������  20080126
procedure TNormNpc.ActionOfGetRandomName(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
    function GetValNameValue(sVarName: string; var sValue: string; var nValue: Integer; var nDataType: Integer): Boolean;
    var
      n100: Integer;
    begin
      nValue := -1;
      sValue := '';
      nDataType := -1;
      n100 := GetValNameNo(sVarName);
      if n100 >= 0 then begin
        case n100 of
          0..99: begin
              nValue := PlayObject.m_nVal[n100];
              nDataType := 1;
              Result := True;
            end;
          100..199: begin
              nValue := g_Config.GlobalVal[n100 - 100];
              nDataType := 1;
              Result := True;
            end;
          200..299: begin
              nValue := PlayObject.m_DyVal[n100 - 200];
              nDataType := 1;
              Result := True;
            end;
          300..399: begin
              nValue := PlayObject.m_nMval[n100 - 300];
              nDataType := 1;
              Result := True;
            end;
          400..499: begin
              nValue := g_Config.GlobaDyMval[n100 - 400];
              nDataType := 1;
              Result := True;
            end;
          500..599: begin
              nValue := PlayObject.m_nInteger[n100 - 500];
              nDataType := 1;
              Result := True;
            end;
          600..699: begin
              sValue := PlayObject.m_sString[n100 - 600];
              nDataType := 0;
              Result := True;
            end;
          700..799: begin
              sValue := g_Config.GlobalAVal[n100 - 700];
              nDataType := 0;
              Result := True;
            end;
          800..1199:begin//20080903 G����(100-499)
              nValue := g_Config.GlobalVal[n100 - 700];
              nDataType := 1;
              Result := True;
            end;
          1200..1599:begin//20080903 A����(100-499)
              sValue := g_Config.GlobalAVal[n100 - 1100];
              nDataType := 0;
              Result := True;
            end;
        else begin
            Result := False;
          end;
        end;
      end else Result := False;
    end;

    function SetValNameValue(sVarName: string; sValue: string; nValue: Integer; nDataType: Integer): Boolean;
    var
      n100: Integer;
    begin
      n100 := GetValNameNo(sVarName);
      if n100 >= 0 then begin
        case nDataType of
          1: begin
              case n100 of
                0..99: begin
                    PlayObject.m_nVal[n100] := nValue;
                    Result := True;
                  end;
                100..199: begin
                    g_Config.GlobalVal[n100 - 100] := nValue;
                    Result := True;
                  end;
                200..299: begin
                    PlayObject.m_DyVal[n100 - 200] := nValue;
                    Result := True;
                  end;
                300..399: begin
                    PlayObject.m_nMval[n100 - 300] := nValue;
                    Result := True;
                  end;
                400..499: begin
                    g_Config.GlobaDyMval[n100 - 400] := nValue;
                    Result := True;
                  end;
                500..599: begin
                    PlayObject.m_nInteger[n100 - 500] := nValue;
                    Result := True;
                  end;
                800..1199:begin//20080903 G����
                    g_Config.GlobalVal[n100 - 700] :=  nValue;
                    Result := True;
                  end;
              else begin
                  Result := False;
                end;
              end;
            end;
          0: begin
              case n100 of
                600..699: begin
                    PlayObject.m_sString[n100 - 600] := sValue;
                    Result := True;
                  end;
                700..799: begin
                    g_Config.GlobalAVal[n100 - 700] := sValue;
                    Result := True;
                  end;
                1200..1599:begin//20080903 A����(100-499)
                    g_Config.GlobalAVal[n100 - 1100] := sValue;
                    Result := True;
                  end;
              else begin
                  Result := False;
                end;
              end;
            end;
          3: begin
              case n100 of
                0..99: begin
                    PlayObject.m_nVal[n100] := nValue;
                    Result := True;
                  end;
                100..199: begin
                    g_Config.GlobalVal[n100 - 100] := nValue;
                    Result := True;
                  end;
                200..299: begin
                    PlayObject.m_DyVal[n100 - 200] := nValue;
                    Result := True;
                  end;
                300..399: begin
                    PlayObject.m_nMval[n100 - 300] := nValue;
                    Result := True;
                  end;
                400..499: begin
                    g_Config.GlobaDyMval[n100 - 400] := nValue;
                    Result := True;
                  end;
                500..599: begin
                    PlayObject.m_nInteger[n100 - 500] := nValue;
                    Result := True;
                  end;
                600..699: begin
                    PlayObject.m_sString[n100 - 600] := sValue;
                    Result := True;
                  end;
                700..799: begin
                    g_Config.GlobalAVal[n100 - 700] := sValue;
                    Result := True;
                  end;
                800..1199:begin//20080903 G����
                    g_Config.GlobalVal[n100 - 700] :=  nValue;
                    Result := True;
                  end;
                1200..1599:begin//20080903 A����(100-499)
                    g_Config.GlobalAVal[n100 - 1100] := sValue;
                    Result := True;
                  end;
              else begin
                  Result := False;
                end;
              end;
            end;
        end;

      end else Result := False;
    end;
var
  LoadList: TStringList;
  sFileName, MonName, sValue, sParam2: string;
  I,K, nValue, nDataType: Integer;
begin
try
  MonName:='';
  if CompareLStr(QuestActionInfo.sParam2, '<$STR(', 6) then  //20090102 ֧���ַ�������
    ArrestStringEx(QuestActionInfo.sParam2, '(', ')', sParam2)
  else sParam2 := QuestActionInfo.sParam2;

  sFileName := QuestActionInfo.sParam1;//�ı�(ȫ·��)
  if sFileName[1] = '\' then sFileName := Copy(sFileName, 2, Length(sFileName) - 1);
  if sFileName[2] = '\' then sFileName := Copy(sFileName, 3, Length(sFileName) - 2);
  if sFileName[3] = '\' then sFileName := Copy(sFileName, 4, Length(sFileName) - 3);
  sFileName := GetLineVariableText(PlayObject,sFileName);//�ļ�·��֧�ֱ��� 20080602
  sFileName := g_Config.sEnvirDir + sFileName;
  if FileExists(sFileName) then begin
     LoadList := TStringList.Create;
     try
       LoadList.LoadFromFile(sFileName);
       Randomize;//�����������
       if LoadList.Count > 0 then begin//20080629
         for I := 0 to LoadList.Count - 1 do begin
           K:= Random(LoadList.Count);
           MonName:= LoadList.Strings[K];
           if MonName <> '' then break;
         end;
       end;
     finally
       LoadList.Free;
     end;
  end;
  if MonName <>'' then begin //��ֵ����
    if GetValNameValue(sParam2, sValue, nValue, nDataType) then begin
      if not SetValNameValue(sParam2, MonName, nValue, nDataType) then
        ScriptActionError(PlayObject, '', QuestActionInfo, sGetRandomName);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGetRandomName');
end;
end;
//-----------------------------------------------------------------------------
//ͨ���ű������ñ���ִ��QManage.txt�еĽű� 20080422
//��ʽ��HCall �������� ��ǩ
procedure TNormNpc.ActionOfHCall(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  User:TPlayObject;
  UserName, sLable: String;
begin
try
  UserName:=GetLineVariableText(PlayObject,QuestActionInfo.sParam1);//�������� ֧�ֱ���
  sLable:=GetLineVariableText(PlayObject,QuestActionInfo.sParam2);//��ǩ ֧�ֱ���
  if (UserName ='') or (sLable ='') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sHCall);
    Exit;
  end;

  User :=UserEngine.GetPlayObject(UserName);
  if User <> nil then begin
    if g_ManageNPC <> nil then g_ManageNPC.GotoLable(User, sLable, False);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfHCall');
end;
end;
//-----------------------------------------------------------------------------
//��������Ƿ��ڹ����ڼ�ķ�Χ�ڣ�����BB�ѱ� 20080422
//��ʽ��INCASTLEWARAY
procedure TNormNpc.ActionOfINCASTLEWARAY(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Castle: TUserCastle;
  I: Integer;
begin
try
  Castle := g_CastleManager.InCastleWarArea(PlayObject);
  if (Castle <> nil) and Castle.m_boUnderWar then begin
    if PlayObject.m_SlaveList.Count > 0 then begin//20080629
      for I := PlayObject.m_SlaveList.Count - 1 downto 0 do begin
        if PlayObject.m_SlaveList.Count <= 0 then Break;
        if TBaseObject(PlayObject.m_SlaveList.Items[I]).m_btRaceServer <> RC_PLAYMOSTER then //�����ѱ�
           TBaseObject(PlayObject.m_SlaveList.Items[I]).m_dwMasterRoyaltyTick := 0;//�ѱ�ʱ��
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfINCASTLEWARAY');
end;
end;
//-----------------------------------------------------------------------------
//���ܣ��������״̬װ������Ҫ�������ò��������װ����״̬
//��ʽ�� GIVESTATEITEM ��Ʒ���� ��Ŀ1 ��Ŀ2 ��Ŀ3 ��Ŀ4 ��Ŀ5 ��Ŀ6(0Ϊ����,1Ϊ��)   20080312
//��Ŀ1--�����ֹ�ӣ���Ŀ2--��ֹ���ף���Ŀ3--��ֹ�棬��Ŀ4--��ֹ�ޣ���Ŀ5--��ֹ����,��Ŀ6--��ֹ������װ��
procedure TNormNpc.ActionOfGIVESTATEITEM(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sItmeName: String;
  n1,n2,n3,n4,n5,n6: Byte;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  I: Integer;
begin
try
  sItmeName:=GetLineVariableText(PlayObject,QuestActionInfo.sParam1);//��Ʒ���� ֧�ֱ���
  n1:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2), -1);//��Ŀ1 ֧�ֱ���
  n2:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam3), -1);//��Ŀ2 ֧�ֱ���
  n3:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam4), -1);//��Ŀ3 ֧�ֱ���
  n4:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam5), -1);//��Ŀ4 ֧�ֱ���
  n5:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam6), -1);//��Ŀ5 ֧�ֱ���
  n6:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam7), -1);//��Ŀ6 ֧�ֱ���

  if (not (n1 in [0, 1])) or (not (n2 in [0, 1])) or (not (n3 in [0, 1])) or
    (not (n4 in [0, 1])) or (not (n5 in [0, 1])) or (not (n6 in [0, 1])) or (sItmeName ='') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sGIVESTATEITEM);
    Exit;
  end;
  if PlayObject.m_ItemList.Count > 0 then begin//20080628
    for I := 0 to PlayObject.m_ItemList.Count - 1 do begin //���������Ϊ��
      UserItem := PlayObject.m_ItemList.Items[I];
      StdItem:= UserEngine.GetStdItem(sItmeName);
      if (StdItem <> nil) and (UserItem.wIndex > 0) then begin
        UserItem.btValue[14] := n1;
        UserItem.btValue[15] := n2;
        UserItem.btValue[16] := n3;
        UserItem.btValue[17] := n4;
        UserItem.btValue[18] := n5;
        UserItem.btValue[19] := n6;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGIVESTATEITEM');
end;
end;
//-----------------------------------------------------------------------------
//���ܣ�����װ����״̬��
//��ʽ��SETITEMSTATE λ��(0-13) ��Ŀ(0-5) ����(0Ϊ����,1Ϊ��) 20080312
//��Ŀ: 0 ��ֹ��1 ��ֹ���� 2 ��ֹ�� 3 ��ֹ�� 4 ��ֹ���� 5 ��ֹ����
procedure TNormNpc.ActionOfSETITEMSTATE(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  n1,n2,n3: Byte;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
try
  n1:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam1), -1);//λ�� ֧�ֱ���
  n2:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2), -1);//��Ŀ ֧�ֱ���
  n3:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam3), -1);//���� ֧�ֱ���

  if (not (n1 in [0..13])) or (not (n2 in [0..5])) or (not (n3 in [0, 1]))then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSETITEMSTATE);
    Exit;
  end;

  UserItem := @PlayObject.m_UseItems[n1];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    //PlayObject.SysMsg('������û�д�ָ����Ʒ������', c_Red, t_Hint);
    Exit;
  end;

  case n2 of //��Ŀ
    0:UserItem.btValue[14] := n3;
    1:UserItem.btValue[15] := n3;
    2:UserItem.btValue[16] := n3;
    3:UserItem.btValue[17] := n3;
    4:UserItem.btValue[18] := n3;
    5:UserItem.btValue[19] := n3;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSETITEMSTATE');
end;
end;
//-----------------------------------------------------------------------------
procedure TNormNpc.ActionOfMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  sSayMsg: string;
begin
try
  if PlayObject.m_sDearName <> '' then Exit;
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
  if PoseHuman = nil then begin
    GotoLable(PlayObject, '@MarryCheckDir', False);
    Exit;
  end;
  if QuestActionInfo.sParam1 = '' then begin
    if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then begin
      GotoLable(PlayObject, '@HumanTypeErr', False);
      Exit;
    end;
    if PoseHuman.GetPoseCreate = PlayObject then begin
      if PlayObject.m_btGender <> PoseHuman.m_btGender then begin
        GotoLable(PlayObject, '@StartMarry', False);
        GotoLable(PoseHuman, '@StartMarry', False);
        if (PlayObject.m_btGender = 0) and (PoseHuman.m_btGender = 1) then begin
          sSayMsg := AnsiReplaceText(g_sStartMarryManMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sStartMarryManAskQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        end else if (PlayObject.m_btGender = 1) and (PoseHuman.m_btGender = 0) then begin
          sSayMsg := AnsiReplaceText(g_sStartMarryWoManMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sStartMarryWoManAskQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        end;
        PlayObject.m_boStartMarry := True;
        PoseHuman.m_boStartMarry := True;
      end else begin
        GotoLable(PoseHuman, '@MarrySexErr', False);
        GotoLable(PlayObject, '@MarrySexErr', False);
      end;
    end else begin
      GotoLable(PlayObject, '@MarryDirErr', False);
      GotoLable(PoseHuman, '@MarryCheckDir', False);
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'REQUESTMARRY' {sREQUESTMARRY}) = 0 then begin
    if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then begin
      if (PlayObject.m_btGender = 0) and (PoseHuman.m_btGender = 1) then begin
        sSayMsg := AnsiReplaceText(g_sMarryManAnswerQuestionMsg, '%n', m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
        UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        sSayMsg := AnsiReplaceText(g_sMarryManAskQuestionMsg, '%n', m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
        sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
        UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        GotoLable(PlayObject, '@WateMarry', False);
        GotoLable(PoseHuman, '@RevMarry', False);
      end;
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'RESPONSEMARRY' {sRESPONSEMARRY}) = 0 then begin
    if (PlayObject.m_btGender = 1) and (PoseHuman.m_btGender = 0) then begin
      if CompareText(QuestActionInfo.sParam2, 'OK') = 0 then begin
        if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then begin
          sSayMsg := AnsiReplaceText(g_sMarryWoManAnswerQuestionMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sMarryWoManGetMarryMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          GotoLable(PlayObject, '@EndMarry', False);
          GotoLable(PoseHuman, '@EndMarry', False);
          PlayObject.m_boStartMarry := False;
          PoseHuman.m_boStartMarry := False;
          PlayObject.m_sDearName := PoseHuman.m_sCharName;
          PlayObject.m_DearHuman := PoseHuman;
          PoseHuman.m_sDearName := PlayObject.m_sCharName;
          PoseHuman.m_DearHuman := PlayObject;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
        end;
      end else begin
        if PlayObject.m_boStartMarry and PoseHuman.m_boStartMarry then begin
          GotoLable(PlayObject, '@EndMarryFail', False);
          GotoLable(PoseHuman, '@EndMarryFail', False);
          PlayObject.m_boStartMarry := False;
          PoseHuman.m_boStartMarry := False;
          sSayMsg := AnsiReplaceText(g_sMarryWoManDenyMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
          sSayMsg := AnsiReplaceText(g_sMarryWoManCancelMsg, '%n', m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%s', PlayObject.m_sCharName);
          sSayMsg := AnsiReplaceText(sSayMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sSayMsg, t_Say);
        end;
      end;
    end;
    Exit;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfMarry');
end;
end;
//��ͽ���ʦ
procedure TNormNpc.ActionOfMaster(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
begin
try
  if PlayObject.m_sMasterName <> '' then Exit;
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
  if PoseHuman = nil then begin
    GotoLable(PlayObject, '@MasterCheckDir', False);
    Exit;
  end;
  if QuestActionInfo.sParam1 = '' then begin
    if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then begin
      GotoLable(PlayObject, '@HumanTypeErr', False);
      Exit;
    end;
    if PoseHuman.GetPoseCreate = PlayObject then begin
      GotoLable(PlayObject, '@StartGetMaster', False);
      GotoLable(PoseHuman, '@StartMaster', False);
      PlayObject.m_boStartMaster := True;
      PoseHuman.m_boStartMaster := True;
    end else begin
      GotoLable(PlayObject, '@MasterDirErr', False);
      GotoLable(PoseHuman, '@MasterCheckDir', False);
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'REQUESTMASTER') = 0 then begin
    if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then begin
      PlayObject.m_PoseBaseObject := PoseHuman;
      PoseHuman.m_PoseBaseObject := PlayObject;
      GotoLable(PlayObject, '@WateMaster', False);
      GotoLable(PoseHuman, '@RevMaster', False);
    end;
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam1, 'RESPONSEMASTER') = 0 then begin
    if CompareText(QuestActionInfo.sParam2, 'OK') = 0 then begin
      if (PlayObject.m_PoseBaseObject = PoseHuman) and (PoseHuman.m_PoseBaseObject = PlayObject) then begin
        if (PlayObject.m_MasterNoList.Count >= g_Config.nMasterCount) then begin //��������ͽ����,���˳� 20080530
           GotoLable(PoseHuman, '@EndMasterFail', False);//��ʾ��ʦʧ��
           GotoLable(PlayObject,'@EndMasterFail', False);//��ʾ��ʦʧ��
           Exit;
        end;
        if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then begin
          GotoLable(PlayObject, '@EndMaster', False);
          GotoLable(PoseHuman, '@EndMaster', False);
          PlayObject.m_boStartMaster := False;
          PoseHuman.m_boStartMaster := False;
          {if PlayObject.m_sMasterName = '' then begin
            PlayObject.m_sMasterName := PoseHuman.m_sCharName;
            PlayObject.m_boMaster := True;
          end;}
          PlayObject.m_boMaster := True;//20080512
          PlayObject.AddMaster(PoseHuman.m_sCharName);//20080530 ��ͽ
          PlayObject.m_MasterList.Add(PoseHuman);
          PoseHuman.m_sMasterName := PlayObject.m_sCharName;
          PoseHuman.m_boMaster := False;
          PoseHuman.GetMasterNoList;//20080530 ȡ����
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
        end;
      end;
    end else begin
      if PlayObject.m_boStartMaster and PoseHuman.m_boStartMaster then begin
        GotoLable(PlayObject, '@EndMasterFail', False);
        GotoLable(PoseHuman, '@EndMasterFail', False);
        PlayObject.m_boStartMaster := False;
        PoseHuman.m_boStartMaster := False;
      end;
    end;
    Exit;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfMaster');
end;
end;

procedure TNormNpc.ActionOfMessageBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sParam1,Str: string;
begin
  try
    sParam1 := QuestActionInfo.sParam1;
    GetValValue(PlayObject, QuestActionInfo.sParam1, sParam1);
    Str:= GetLineVariableText(PlayObject, sParam1);
    if (QuestActionInfo.sParam2 <> '') and (pos('@',QuestActionInfo.sParam2) > 0) then begin//20090126
      Str:= Str+'/'+QuestActionInfo.sParam2;
    end;
    if (QuestActionInfo.sParam3 <> '') and (pos('@',QuestActionInfo.sParam3) > 0) then begin//20090126
      Str:= Str+'/'+QuestActionInfo.sParam3;
    end;
    PlayObject.SendMsg(Self, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, Str);
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfMessageBox');
  end;
end;

procedure TNormNpc.ActionOfMission(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
  try
    if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.nParam2 > 0) and (QuestActionInfo.nParam3 > 0) then begin
      g_sMissionMap := GetLineVariableText(PlayObject,QuestActionInfo.sParam1);//20080507
      g_nMissionX := QuestActionInfo.nParam2;
      g_nMissionY := QuestActionInfo.nParam3;
    end else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MISSION);
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfMission');
  end;
end;

//MOBFIREBURN MAP X Y TYPE TIME POINT

procedure TNormNpc.ActionOfMobFireBurn(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sMAP: string;
  nX, nY, nType, nTime, nPoint: Integer;
  FireBurnEvent: TFireBurnEvent;
  Envir: TEnvirnoment;
  OldEnvir: TEnvirnoment;
begin
try
  sMAP := QuestActionInfo.sParam1;
  nX := Str_ToInt(QuestActionInfo.sParam2, -1);
  nY := Str_ToInt(QuestActionInfo.sParam3, -1);
  nType := Str_ToInt(QuestActionInfo.sParam4, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam5, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam6, -1);
  if (sMAP = '') or (nX < 0) or (nY < 0) or (nType < 0) or (nTime < 0) or (nPoint < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBFIREBURN);
    Exit;
  end;
  Envir := g_MapManager.FindMap(sMAP);
  if Envir <> nil then begin
    OldEnvir := PlayObject.m_PEnvir;
    PlayObject.m_PEnvir := Envir;
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, nType, nTime * 1000, nPoint);
    g_EventManager.AddEvent(FireBurnEvent);
    PlayObject.m_PEnvir := OldEnvir;
    Exit;
  end;
  ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBFIREBURN);
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfMobFireBurn');
end;
end;
//���ù���������е㼯��
//�����ʽ: MobPlace �������� �Ƿ��ڹ��� ģʽ(0/1 1-ħ������ģʽ)
procedure TNormNpc.ActionOfMobPlace(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo; nX, nY, nCount, nRange: Integer);
var
  I: Integer;
  nRandX, nRandY: Integer;
  mon: TBaseObject;
  sMonName: string;//20080126
  boIsNGMon: Boolean;//20081001    
  boMode: Boolean;//�Ƿ���ģʽ
begin
  try
    sMonName:= GetLineVariableText(PlayObject,QuestActionInfo.sParam1);//20080126 ������,֧�ֱ���
    boIsNGMon:= Str_ToInt(QuestActionInfo.sParam2 , 0) <> 0;//20081001
    if QuestActionInfo.sParam3 <> '' then boMode:= True;
    if nCount <= 0 then nCount:=1;//20080629
    for I := 0 to nCount - 1 do begin
      if boMode and (PlayObject.m_sMapName136 <> '') then begin//20090204 ħ����ʹ��
        mon := UserEngine.RegenMonsterByName(PlayObject.m_sMapName136, UserEngine.m_nCurrX_136, UserEngine.m_nCurrY_136, sMonName);
      end else begin
        nRandX := Random(nRange * 2 + 1) + (nX - nRange);
        nRandY := Random(nRange * 2 + 1) + (nY - nRange);
        mon := UserEngine.RegenMonsterByName(g_sMissionMap, nRandX, nRandY, sMonName);
      end;
      if mon <> nil then begin
        mon.m_boIsNGMonster := boIsNGMon;//20081001
        if not boMode then begin
          mon.m_boMission := True;
          mon.m_nMissionX := g_nMissionX;
          mon.m_nMissionY := g_nMissionY;
        end;
      end else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MOBPLACE);
        Break;
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfMobPlace');
  end;
end;

procedure TNormNpc.ActionOfSetRankLevelName(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
  function SubStrConut(mStr:string;mSub:string):Integer;//�ж�'<$Str('�ַ������ַ����еĴ���
  begin
    Result:= (Length(mStr) - Length(StringReplace(mStr,mSub, '', [rfReplaceAll])))  div  Length(mSub);
  end;
var
  I, K: Integer;
  DynamicVar: pTDynamicVar;
  DynamicVarList: TList;
  sName: string;
  boVarFound: Boolean;
  sRankLevelName,sTemp,sTemp1: string;
  n10: Integer;
resourcestring
  sVarFound = '����%s�����ڣ���������:%s';
  sVarTypeError = '�������ʹ��󣬴�������:%s ��ǰ֧������(HUMAN��GUILD��GLOBAL)';
begin
try
  sRankLevelName := QuestActionInfo.sParam1;
  if sRankLevelName = '' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETRANKLEVELNAME);
    Exit;
  end;
  if QuestActionInfo.sParam2 <> '' then begin
    boVarFound := False;
    DynamicVarList := GetDynamicVarList(PlayObject, sRankLevelName, sName);
    if DynamicVarList = nil then begin
      ScriptActionError(PlayObject, Format(sVarTypeError, [sRankLevelName]), QuestActionInfo, sSC_SETRANKLEVELNAME);
      Exit;
    end;
    if DynamicVarList.Count > 0 then begin//20080629
      for I := 0 to DynamicVarList.Count - 1 do begin
        DynamicVar := DynamicVarList.Items[I];
        if CompareText(DynamicVar.sName, QuestActionInfo.sParam2) = 0 then begin
          case DynamicVar.VarType of
            vInteger: begin
                sRankLevelName := IntToStr(DynamicVar.nInternet);//20080929 ����
              end;
            vString: begin
                sRankLevelName := DynamicVar.sString;
              end;
          end;
          boVarFound := True;
          Break;
        end;
      end;//for
    end;
    if not boVarFound then begin
      ScriptActionError(PlayObject, Format(sVarFound, [QuestActionInfo.sParam2, QuestActionInfo.sParam1]), QuestActionInfo, sSC_SETRANKLEVELNAME);
      Exit;
    end;
  end else begin
    I:= SubStrConut(sRankLevelName,'<$STR(');//20080429 �޸�
    if I > 0 then begin
      sTemp:= sRankLevelName;
      sRankLevelName:='';
      for K:=0 to I - 1 do begin
        sTemp:=ArrestStringEx(sTemp, '(', ')', sTemp1);
        n10 := GetValNameNo(sTemp1);
        if n10 >= 0 then begin
          case n10 of
            600..699: begin
                if PlayObject.m_sString[n10 - 600] <> '' then begin
                  if sRankLevelName <> '' then sRankLevelName:=sRankLevelName+'\';
                  sRankLevelName := sRankLevelName + PlayObject.m_sString[n10 - 600];
                end;
              end;
            700..799: begin
                if g_Config.GlobalAVal[n10 - 700] <> '' then begin
                  if sRankLevelName <> '' then sRankLevelName:=sRankLevelName+'\';
                  sRankLevelName := sRankLevelName + g_Config.GlobalAVal[n10 - 700];
                end;
              end;
            1200..1599:begin//20080903 A����(100-499)
                if g_Config.GlobalAVal[n10 - 1100] <> '' then begin
                  if sRankLevelName <> '' then sRankLevelName:=sRankLevelName+'\';
                  sRankLevelName := sRankLevelName + g_Config.GlobalAVal[n10 - 1100];
                end;
              end;
          end;
        end;
      end;
    end else begin
      n10 := GetValNameNo(sRankLevelName);
      if n10 >= 0 then begin
        case n10 of
          600..699: begin
              sRankLevelName := PlayObject.m_sString[n10 - 600];
            end;
          700..799: begin
              sRankLevelName := g_Config.GlobalAVal[n10 - 700];
            end;
          1200..1599:begin//20080903 A����(100-499)
              sRankLevelName := g_Config.GlobalAVal[n10 - 1100];
            end;
        end;
      end;
    end;
  end;
  if sRankLevelName = '' then begin
    sRankLevelName := g_sRankLevelName;
  end else
    if Pos('%s', sRankLevelName) <= 0 then begin
    sRankLevelName := '%s\' + sRankLevelName;
  end;
  PlayObject.m_sRankLevelName := sRankLevelName;
  PlayObject.RefShowName;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSetRankLevelName');
end;
end;

procedure TNormNpc.ActionOfSetScriptFlag(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boFlag: Boolean;
  nWhere: Integer;
begin
try
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  boFlag := Str_ToInt(QuestActionInfo.sParam2, -1) = 1;
  case nWhere of
    0: begin
        PlayObject.m_boSendMsgFlag := boFlag;
      end;
    1: begin
        PlayObject.m_boChangeItemNameFlag := boFlag;
      end;
  else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETSCRIPTFLAG);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSetScriptFlag');
end;
end;

procedure TNormNpc.ActionOfSkillLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
  cMethod: Char;
begin
try
  nLevel := Str_ToInt(QuestActionInfo.sParam3, 0);
  if nLevel < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SKILLLEVEL);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam2[1];
  Magic := UserEngine.FindMagic(QuestActionInfo.sParam1);
  if Magic <> nil then begin
    if PlayObject.m_MagicList.Count > 0 then begin//20080629
      for I := 0 to PlayObject.m_MagicList.Count - 1 do begin
        UserMagic := PlayObject.m_MagicList.Items[I];
        if UserMagic.MagicInfo = Magic then begin
          case cMethod of
            '=': begin
                if nLevel >= 0 then begin
                  nLevel := _MAX(3, nLevel);
                  UserMagic.btLevel := nLevel;
                end;
              end;
            '-': begin
                if UserMagic.btLevel >= nLevel then begin
                  Dec(UserMagic.btLevel, nLevel);
                end else begin
                  UserMagic.btLevel := 0;
                end;
              end;
            '+': begin
                if UserMagic.btLevel + nLevel <= 3 then begin
                  Inc(UserMagic.btLevel, nLevel);
                end else begin
                  UserMagic.btLevel := 3;
                end;
              end;
          end;
          PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 100);
          Break;
        end;
      end;//for
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSkillLevel');
end;
end;
//����Ӣ�ۼ��ܵȼ� 20080415
procedure TNormNpc.ActionOfHeroSkillLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  Magic: pTMagic;
  UserMagic: pTUserMagic;
  nLevel: Integer;
  cMethod: Char;
  isMagic4: Boolean;
begin
try
  isMagic4:= False;
  nLevel := Str_ToInt(QuestActionInfo.sParam3, 0);
  if nLevel < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HeroSkillLevel);
    Exit;
  end;
  cMethod := QuestActionInfo.sParam2[1];

  if PlayObject.m_MyHero <> nil then begin
  Magic := UserEngine.FindHeroMagic(QuestActionInfo.sParam1);
  if Magic <> nil then begin
    if Magic.wMagicId in [13,26,45] then isMagic4:= True;
    if PlayObject.m_MyHero.m_MagicList.Count > 0 then begin//20080629
      for I := 0 to PlayObject.m_MyHero.m_MagicList.Count - 1 do begin
        UserMagic := PlayObject.m_MyHero.m_MagicList.Items[I];
        if UserMagic.MagicInfo = Magic then begin
          case cMethod of
            '=': begin
                if nLevel >= 0 then begin
                  if isMagic4 then
                    nLevel := _MAX(4, nLevel)
                  else nLevel := _MAX(3, nLevel);
                  UserMagic.btLevel := nLevel;
                end;
              end;
            '-': begin
                if UserMagic.btLevel >= nLevel then begin
                  Dec(UserMagic.btLevel, nLevel);
                end else begin
                  UserMagic.btLevel := 0;
                end;
              end;
            '+': begin
                if isMagic4 then begin
                  if UserMagic.btLevel + nLevel <= 4 then begin
                    Inc(UserMagic.btLevel, nLevel);
                  end else begin
                    UserMagic.btLevel := 4;
                  end;
                end else begin
                  if UserMagic.btLevel + nLevel <= 3 then begin
                    Inc(UserMagic.btLevel, nLevel);
                  end else begin
                    UserMagic.btLevel := 3;
                  end;
                end;
              end;
          end;
          PlayObject.SendDelayMsg(PlayObject, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 100);
          Break;
        end;
      end;//for
    end;
  end;
  end else begin//Ӣ�۲�����
   PlayObject.SysMsg('Ӣ�۲�����!', c_Red, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfHeroSkillLevel');
end;
end;

procedure TNormNpc.ActionOfTakeCastleGold(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGold: Integer;
begin
try
  nGold := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nGold < 0 then
    GetValValue(PlayObject, QuestActionInfo.sParam1, nGold);
  if (nGold < 0) or (m_Castle = nil) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAKECASTLEGOLD);
    Exit;
  end;
  if nGold <= TUserCastle(m_Castle).m_nTotalGold then begin
    Dec(TUserCastle(m_Castle).m_nTotalGold, nGold);
  end else begin
    TUserCastle(m_Castle).m_nTotalGold := 0;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfTakeCastleGol');
end;
end;
//���߹һ�
procedure TNormNpc.ActionOfNotLineAddPiont(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  dwAutoGetExpTime: LongWord;
  nAutoGetExpPoint: Integer;
begin
try
  if not PlayObject.m_boNotOnlineAddExp then begin
    dwAutoGetExpTime := Str_ToInt(QuestActionInfo.sParam1, 0);
    nAutoGetExpPoint := Str_ToInt(QuestActionInfo.sParam2, 0);
    if dwAutoGetExpTime * 60 > High(LongWord) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sOFFLINEPLAY);
      Exit;
    end;
    PlayObject.m_dwNotOnlineAddExpTime := dwAutoGetExpTime * 60{60};//20080812 �޸�
    PlayObject.m_nNotOnlineAddExpPoint := nAutoGetExpPoint;
    PlayObject.m_boNotOnlineAddExp := True;//�����߹һ�
    PlayObject.m_boStartAutoAddExpPoint := True;//�Ƿ��Զ����Ӿ���
    PlayObject.m_dwAutoAddExpPointTimeTick := GetTickCount;
    PlayObject.m_dwAutoAddExpPointTick := GetTickCount;
    PlayObject.m_boKickAutoAddExpUser := False;
    PlayObject.m_boAllowDeal := False; //��ֹ����
    PlayObject.m_boAllowGuild := False; //��ֹ�����л�
    PlayObject.m_boAllowGroup := False; //��ֹ���
    PlayObject.m_boCanMasterRecall := False; //��ֹʦͽ����
    PlayObject.m_boCanDearRecall := False; //��ֹ���޴���
    PlayObject.m_boAllowGuildReCall := False; //��ֹ�л��һ
    PlayObject.m_boAllowGroupReCall := False; //��ֹ��غ�һ
    PlayObject.m_boOpenBox:= False;//�����ʼ�� 20080415
    PlayObject.ClearViewRange;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfNotLineAddPiont');
end;
end;

procedure TNormNpc.ActionOfKickNotLineAddPiont(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
try
  if PlayObject.m_boNotOnlineAddExp then begin
    PlayObject.m_boPlayOffLine := False;
    PlayObject.m_boReconnection := False;
    PlayObject.m_boSoftClose := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfKickNotLineAddPiont');
end;
end;

procedure TNormNpc.ActionOfUnMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  LoadList: TStringList;
  sUnMarryFileName: string;
begin
try
  if PlayObject.m_sDearName = '' then begin
    GotoLable(PlayObject, '@ExeMarryFail', False);
    Exit;
  end;
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate);
  if PoseHuman = nil then begin
    GotoLable(PlayObject, '@UnMarryCheckDir', False);
  end;
  if PoseHuman <> nil then begin
    if QuestActionInfo.sParam1 = '' then begin
      if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then begin
        GotoLable(PlayObject, '@UnMarryTypeErr', False);
        Exit;
      end;
      if PoseHuman.GetPoseCreate = PlayObject then begin
        if (PlayObject.m_sDearName = PoseHuman.m_sCharName) {and (PosHum.AddInfo.sDearName = Hum.sName)} then begin
          GotoLable(PlayObject, '@StartUnMarry', False);
          GotoLable(PoseHuman, '@StartUnMarry', False);
          Exit;
        end;
      end;
    end;
  end;
  if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMARRY' {sREQUESTUNMARRY}) = 0) then begin
    if (QuestActionInfo.sParam2 = '') then begin
      if PoseHuman <> nil then begin
        PlayObject.m_boStartUnMarry := True;
        if PlayObject.m_boStartUnMarry and PoseHuman.m_boStartUnMarry then begin
          UserEngine.SendBroadCastMsg('[' + m_sCharName + ']: ' + '������' {sUnMarryMsg8} + PoseHuman.m_sCharName + ' ' + '��' {sMarryMsg0} + PlayObject.m_sCharName + ' ' + ' ' + '��ʽ������޹�ϵ��' {sUnMarryMsg9}, t_Say);
          PlayObject.m_sDearName := '';
          PoseHuman.m_sDearName := '';
          Inc(PlayObject.m_btMarryCount);
          Inc(PoseHuman.m_btMarryCount);
          PlayObject.m_boStartUnMarry := False;
          PoseHuman.m_boStartUnMarry := False;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
          GotoLable(PlayObject, '@UnMarryEnd', False);
          GotoLable(PoseHuman, '@UnMarryEnd', False);
        end else begin
          GotoLable(PlayObject, '@WateUnMarry', False);
          //          GotoLable(PoseHuman,'@RevUnMarry',False);
        end;
      end;
      Exit;
    end else begin
      //ǿ�����
      if (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then begin
        UserEngine.SendBroadCastMsg('[' + m_sCharName + ']: ' + '������' {sUnMarryMsg8} + PlayObject.m_sCharName + ' ' + '��' {sMarryMsg0} + PlayObject.m_sDearName + ' ' + ' ' + '�Ѿ���ʽ������޹�ϵ������' {sUnMarryMsg9}, t_Say);
        PoseHuman := UserEngine.GetPlayObject(PlayObject.m_sDearName);
        if PoseHuman <> nil then begin
          PoseHuman.m_sDearName := '';
          Inc(PoseHuman.m_btMarryCount);
          PoseHuman.RefShowName;
        end else begin
          sUnMarryFileName := g_Config.sEnvirDir + 'UnMarry.txt';
          LoadList := TStringList.Create;
          if FileExists(sUnMarryFileName) then begin
            LoadList.LoadFromFile(sUnMarryFileName);
          end;
          LoadList.Add(PlayObject.m_sDearName);
          LoadList.SaveToFile(sUnMarryFileName);
          LoadList.Free;
        end;
        PlayObject.m_sDearName := '';
        Inc(PlayObject.m_btMarryCount);
        GotoLable(PlayObject, '@UnMarryEnd', False);
        PlayObject.RefShowName;
      end;
      Exit;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfUnMarry');
end;
end;

procedure TNormNpc.ActionOfStartTakeGold(PlayObject: TPlayObject);
var
  PoseHuman: TPlayObject;
begin
try
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
  if (PoseHuman <> nil) and (PoseHuman.GetPoseCreate = PlayObject) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    PlayObject.m_nDealGoldPose := 1;
    GotoLable(PlayObject, '@startdealgold', False);
  end else begin
    GotoLable(PlayObject, '@dealgoldpost', False);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfStartTakeGold');
end;
end;

procedure TNormNpc.ClearScript;
var
  III, IIII: Integer;
  I, II: Integer;
  Script: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
begin
try
  if m_ScriptList.Count > 0 then begin//20080629
    for I := 0 to m_ScriptList.Count - 1 do begin
      Script := m_ScriptList.Items[I];
      if Script.RecordList.Count > 0 then begin//20080629
        for II := 0 to Script.RecordList.Count - 1 do begin
          SayingRecord := Script.RecordList.Items[II];
          if SayingRecord.ProcedureList.Count > 0 then begin//20080629
            for III := 0 to SayingRecord.ProcedureList.Count - 1 do begin
              SayingProcedure := SayingRecord.ProcedureList.Items[III];
              if SayingProcedure.ConditionList.Count > 0 then begin//20080629
                for IIII := 0 to SayingProcedure.ConditionList.Count - 1 do begin
                  if pTQuestConditionInfo(SayingProcedure.ConditionList.Items[IIII])<> nil then
                    Dispose(pTQuestConditionInfo(SayingProcedure.ConditionList.Items[IIII]));
                end;
              end;
              if SayingProcedure.ActionList.Count > 0 then begin//20080629
                for IIII := 0 to SayingProcedure.ActionList.Count - 1 do begin
                  if pTQuestActionInfo(SayingProcedure.ActionList.Items[IIII]) <> nil then
                    Dispose(pTQuestActionInfo(SayingProcedure.ActionList.Items[IIII]));
                end;
              end;
              if  SayingProcedure.ElseActionList.Count > 0 then begin//20080629
                for IIII := 0 to SayingProcedure.ElseActionList.Count - 1 do begin
                  if pTQuestActionInfo(SayingProcedure.ElseActionList.Items[IIII]) <> nil then
                    Dispose(pTQuestActionInfo(SayingProcedure.ElseActionList.Items[IIII]));
                end;
              end;
              SayingProcedure.ConditionList.Free;
              SayingProcedure.ActionList.Free;
              SayingProcedure.ElseActionList.Free;
              Dispose(SayingProcedure);
            end; // for
          end;
          SayingRecord.ProcedureList.Free;
          Dispose(SayingRecord);
        end; // for
      end;
      Script.RecordList.Free;
      Dispose(Script);
    end; // for
  end;
  m_ScriptList.Clear;
except
  MainOutMessage('{�쳣} TNormNpc.ClearScript');
end;
end;

procedure TNormNpc.Click(PlayObject: TPlayObject); //0049EC18
begin
  try
    if not m_boGhost then begin//20081024 ����
      if PlayObject <> nil then begin//20080827 ����
        PlayObject.m_nScriptGotoCount := 0;
        PlayObject.m_sScriptGoBackLable := '';
        PlayObject.m_sScriptCurrLable := '';
        GotoLable(PlayObject, '@main', False);
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.Click');
  end;
end;

function TNormNpc.ConditionOfCheckAccountIPList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  sCharAccount: string;
  sCharIPaddr: string;
  sLine: string;
  sName: string;
  sIPaddr: string;
begin
try
  Result := False;
  LoadList := TStringList.Create;
  try
    sCharName := PlayObject.m_sCharName;
    sCharAccount := PlayObject.m_sUserID;
    sCharIPaddr := PlayObject.m_sIPaddr;
    if FileExists(g_Config.sEnvirDir + QuestConditionInfo.sParam1) then begin
      LoadList.LoadFromFile(g_Config.sEnvirDir + QuestConditionInfo.sParam1);
      if LoadList.Count > 0 then begin//20080629
        for I := 0 to LoadList.Count - 1 do begin
          sLine := LoadList.Strings[I];
          if sLine[1] = ';' then Continue;
          sIPaddr := GetValidStr3(sLine, sName, [' ', '/', #9]);
          sIPaddr := Trim(sIPaddr);
          if (sName = sCharAccount) and (sIPaddr = sCharIPaddr) then begin
            Result := True;
            Break;
          end;
        end;
      end;
    end else begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKACCOUNTIPLIST);
    end;
  finally
    LoadList.Free
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckAccountIPList');
end;
end;
//���ܣ�������ﱳ���ո���,Hero���ж�Ӣ�۵ı���
//���CheckBagSize ���� Hero
function TNormNpc.ConditionOfCheckBagSize(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nSize: Integer;
begin
  try
    Result := False;
    if not GetValValue(PlayObject, QuestConditionInfo.sParam1, nSize) then begin //���ӱ���֧��
      nSize := QuestConditionInfo.nParam1;
    end;
    if (nSize <= 0) or (nSize > MAXHEROBAGITEM) then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKBAGSIZE);
      Exit;
    end;

    if CompareText(QuestConditionInfo.sParam2, 'HERO') = 0 then begin//20080822 �ж�Ӣ�۵ı���
      if PlayObject.m_MyHero <> nil then begin
        if PlayObject.m_MyHero.m_ItemList.Count + nSize <= MAXHEROBAGITEM then Result := True;
      end;
    end else begin
      if PlayObject.m_ItemList.Count + nSize <= MAXBAGITEM then Result := True;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckBagSize');
  end;
end;


function TNormNpc.ConditionOfCheckBonusPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nTotlePoint, nCount: Integer;
  cMethod: Char;
begin
try
  Result := False;
  nTotlePoint := PlayObject.m_BonusAbil.DC +
    PlayObject.m_BonusAbil.MC +
    PlayObject.m_BonusAbil.SC +
    PlayObject.m_BonusAbil.AC +
    PlayObject.m_BonusAbil.MAC +
    PlayObject.m_BonusAbil.HP +
    PlayObject.m_BonusAbil.MP +
    PlayObject.m_BonusAbil.Hit +
    PlayObject.m_BonusAbil.Speed +
    PlayObject.m_BonusAbil.X2;
  nTotlePoint := nTotlePoint + PlayObject.m_nBonusPoint;
  cMethod := QuestConditionInfo.sParam1[1];
  if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nCount) then begin //���ӱ���֧��
    nCount := QuestConditionInfo.nParam2;
  end;
  case cMethod of
    '=': if nTotlePoint = nCount then Result := True;
    '>': if nTotlePoint > nCount then Result := True;
    '<': if nTotlePoint < nCount then Result := True;
  else if nTotlePoint >= nCount then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckBonusPoint');
end;
end;

function TNormNpc.ConditionOfCheckHP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if PlayObject.m_WAbil.MaxHP = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if PlayObject.m_WAbil.MaxHP > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if PlayObject.m_WAbil.MaxHP < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if PlayObject.m_WAbil.MaxHP >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
try
  Result := False;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam1[3];
  nMIN := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHP);
    Exit;
  end;

  case cMethodMin of
    '=': begin
        if (m_WAbil.HP = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (PlayObject.m_WAbil.HP > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (PlayObject.m_WAbil.HP < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (PlayObject.m_WAbil.HP >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckHP');
end;
end;

function TNormNpc.ConditionOfCheckMP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if PlayObject.m_WAbil.MaxMP = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if PlayObject.m_WAbil.MaxMP > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if PlayObject.m_WAbil.MaxMP < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if PlayObject.m_WAbil.MaxMP >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
try
  Result := False;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam1[3];
  nMIN := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMP);
    Exit;
  end;
  case cMethodMin of
    '=': begin
        if (m_WAbil.MP = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (PlayObject.m_WAbil.MP > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (PlayObject.m_WAbil.MP < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (PlayObject.m_WAbil.MP >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMP');
end;
end;

function TNormNpc.ConditionOfCheckDC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if HiWord(PlayObject.m_WAbil.DC) = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if HiWord(PlayObject.m_WAbil.DC) > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if HiWord(PlayObject.m_WAbil.DC) < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if HiWord(PlayObject.m_WAbil.DC) >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
try
  Result := False;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam1[3];
  nMIN := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKDC);
    Exit;
  end;
  case cMethodMin of
    '=': begin
        if (LoWord(PlayObject.m_WAbil.DC) = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (LoWord(PlayObject.m_WAbil.DC) > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (LoWord(PlayObject.m_WAbil.DC) < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (LoWord(PlayObject.m_WAbil.DC) >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
  Result := False;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckDC');
end;
end;

function TNormNpc.ConditionOfCheckMC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if HiWord(PlayObject.m_WAbil.MC) = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if HiWord(PlayObject.m_WAbil.MC) > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if HiWord(PlayObject.m_WAbil.MC) < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if HiWord(PlayObject.m_WAbil.MC) >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
try
  Result := False;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam1[3];
  nMIN := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMC);
    Exit;
  end;

  case cMethodMin of
    '=': begin
        if (LoWord(PlayObject.m_WAbil.MC) = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (LoWord(PlayObject.m_WAbil.MC) > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (LoWord(PlayObject.m_WAbil.MC) < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (LoWord(PlayObject.m_WAbil.MC) >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMC');
end;
end;

function TNormNpc.ConditionOfCheckSC(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethodMin, cMethodMax: Char;
  nMIN, nMax: Integer;
  function CheckHigh(): Boolean;
  begin
    Result := False;
    case cMethodMax of
      '=': begin
          if HiWord(PlayObject.m_WAbil.SC) = nMax then begin
            Result := True;
          end;
        end;
      '>': begin
          if HiWord(PlayObject.m_WAbil.SC) > nMax then begin
            Result := True;
          end;
        end;
      '<': begin
          if HiWord(PlayObject.m_WAbil.SC) < nMax then begin
            Result := True;
          end;
        end;
    else begin
        if HiWord(PlayObject.m_WAbil.SC) >= nMax then begin
          Result := True;
        end;
      end;
    end;
  end;
begin
try
  Result := False;
  cMethodMin := QuestConditionInfo.sParam1[1];
  cMethodMax := QuestConditionInfo.sParam1[3];
  nMIN := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nMax := Str_ToInt(QuestConditionInfo.sParam4, -1);
  if (nMIN < 0) or (nMax < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSC);
    Exit;
  end;

  case cMethodMin of
    '=': begin
        if (LoWord(PlayObject.m_WAbil.SC) = nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '>': begin
        if (LoWord(PlayObject.m_WAbil.SC) > nMIN) then begin
          Result := CheckHigh;
        end;
      end;
    '<': begin
        if (LoWord(PlayObject.m_WAbil.SC) < nMIN) then begin
          Result := CheckHigh;
        end;
      end;
  else begin
      if (LoWord(PlayObject.m_WAbil.SC) >= nMIN) then begin
        Result := CheckHigh;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckSC');
end;
end;

function TNormNpc.ConditionOfCheckExp(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  dwExp: LongWord;
begin
try
  Result := False;
  dwExp := Str_ToInt(QuestConditionInfo.sParam2, 0);
  if dwExp = 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKEXP);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_Abil.Exp = dwExp then Result := True;
    '>': if PlayObject.m_Abil.Exp > dwExp then Result := True;
    '<': if PlayObject.m_Abil.Exp < dwExp then Result := True;
  else if PlayObject.m_Abil.Exp >= dwExp then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckExp');
end;
end;

function TNormNpc.ConditionOfCheckFlourishPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGUild;
begin
try
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nPoint) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKFLOURISHPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nFlourishing = nPoint then Result := True;
    '>': if Guild.nFlourishing > nPoint then Result := True;
    '<': if Guild.nFlourishing < nPoint then Result := True;
  else if Guild.nFlourishing >= nPoint then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckFlourishPoint');
end;
end;

function TNormNpc.ConditionOfCheckChiefItemCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
  Guild: TGUild;
begin
try
  Result := False;
  nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKFLOURISHPOINT);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nChiefItemCount = nCount then Result := True;
    '>': if Guild.nChiefItemCount > nCount then Result := True;
    '<': if Guild.nChiefItemCount < nCount then Result := True;
  else if Guild.nChiefItemCount >= nCount then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckChiefItemCount');
end;
end;

function TNormNpc.ConditionOfCheckGuildAuraePoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGUild;
begin
try
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nPoint) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKAURAEPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nAurae = nPoint then Result := True;
    '>': if Guild.nAurae > nPoint then Result := True;
    '<': if Guild.nAurae < nPoint then Result := True;
  else if Guild.nAurae >= nPoint then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckGuildAuraePoint');
end;
end;

function TNormNpc.ConditionOfCheckGuildBuildPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGUild;
begin
try
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nPoint) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKBUILDPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nBuildPoint = nPoint then Result := True;
    '>': if Guild.nBuildPoint > nPoint then Result := True;
    '<': if Guild.nBuildPoint < nPoint then Result := True;
  else if Guild.nBuildPoint >= nPoint then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckGuildBuildPoint');
end;
end;

function TNormNpc.ConditionOfCheckStabilityPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nPoint: Integer;
  Guild: TGUild;
begin
try
  Result := False;
  nPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nPoint < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nPoint) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSTABILITYPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if Guild.nStability = nPoint then Result := True;
    '>': if Guild.nStability > nPoint then Result := True;
    '<': if Guild.nStability < nPoint then Result := True;
  else if Guild.nStability >= nPoint then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckStabilityPoint');
end;
end;
//��鵱ǰ���������ж�����Ϸ��
function TNormNpc.ConditionOfCheckGameGold(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGameGold: Integer;
begin
try
  Result := False;
  nGameGold:=Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080430
  if nGameGold < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nGameGold) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEGOLD);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nGameGold = nGameGold then Result := True;
    '>': if PlayObject.m_nGameGold > nGameGold then Result := True;
    '<': if PlayObject.m_nGameGold < nGameGold then Result := True;
  else if PlayObject.m_nGameGold >= nGameGold then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckGameGold');
end;
end;
//���ܣ�����ַ����ĳ���
//��ʽ��CheckStringlength �ַ��� ������(<,>,=) λ��
function TNormNpc.ConditionOfCheckStringlength(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nLength: Integer;
  sMag: String;
begin
  Result := False;
  try
    nLength:=Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam3),-1);//λ��
    sMag:= GetLineVariableText(PlayObject, QuestConditionInfo.sParam1); //�ַ���
    if (nLength < 0) or (sMag = '') then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CheckStringlength);
      Exit;
    end;
    cMethod := QuestConditionInfo.sParam2[1];
    case cMethod of
      '=': if Length(sMag) = nLength then Result := True;
      '>': if Length(sMag) > nLength then Result := True;
      '<': if Length(sMag) < nLength then Result := True;
    else if Length(sMag) >= nLength then Result := True;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckStringlength');
  end;
end;

//�����ʯ���� 20071226
function TNormNpc.ConditionOfCheckGameDiaMond(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGameDiaMond: Integer;
begin
try
  Result := False;
  //nGameDiaMond := Str_ToInt(QuestConditionInfo.sParam2, -1); //20080430
  nGameDiaMond:=Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080430

  if nGameDiaMond < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nGameDiaMond) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEDIAMOND);
      Exit;
    end;
  end;

  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nGameDiaMond = nGameDiaMond then Result := True;
    '>': if PlayObject.m_nGameDiaMond > nGameDiaMond then Result := True;
    '<': if PlayObject.m_nGameDiaMond < nGameDiaMond then Result := True;
  else if PlayObject.m_nGameDiaMond >= nGameDiaMond then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckGameDiaMond');
end;
end;
//���������� 20071226
function TNormNpc.ConditionOfCheckGameGird(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGameGird: Integer;
begin
try
  Result := False;
  //nGameGird := Str_ToInt(QuestConditionInfo.sParam2, -1);//20080430
  nGameGird:=Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080430
  if nGameGird < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nGameGird) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEGIRD);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nGameGird = nGameGird then Result := True;
    '>': if PlayObject.m_nGameGird > nGameGird then Result := True;
    '<': if PlayObject.m_nGameGird < nGameGird then Result := True;
  else if PlayObject.m_nGameGird >= nGameGird then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckGameGird');
end;
end;
//�������ֵ 20080511
function TNormNpc.ConditionOfCheckGameGLORY(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGameGlory: Integer;
begin
try
  Result := False;
  nGameGlory:=Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080430
  if nGameGlory < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nGameGlory) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEGLORY);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btGameGlory = nGameGlory then Result := True;
    '>': if PlayObject.m_btGameGlory > nGameGlory then Result := True;
    '<': if PlayObject.m_btGameGlory < nGameGlory then Result := True;
  else if PlayObject.m_btGameGlory >= nGameGlory then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckGameGLORY');
end;
end;
//------------------------------------------------------------------------------
//��鼼�ܵȼ� 20080512
//CHECKSKILLLEVEL ������ ���Ʒ�(=,>,<) �ȼ���(0-3) HERO
function TNormNpc.ConditionOfCHECKSKILLLEVEL(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  UserMagic: pTUserMagic;
  nLevel: Integer;
  cMethod: Char;
  sMagicName: String;
begin
try
  Result := False;
  nLevel := _MIN(3, Str_ToInt(QuestConditionInfo.sParam3, 0));
  sMagicName:= GetLineVariableText(PlayObject,QuestConditionInfo.sParam1);
  cMethod := QuestConditionInfo.sParam2[1];
  if (nLevel < 0) or (sMagicName = '') and (cMethod = '')  then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSKILLLEVEL);
    Exit;
  end;
  if CompareText(QuestConditionInfo.sParam4, 'HERO') = 0 then begin
      if PlayObject.m_MyHero <> nil then begin
        UserMagic:= TPlayObject(PlayObject.m_MyHero).GetMagicInfo(sMagicName);
        if UserMagic <> nil then begin
          case cMethod of
            '=': if UserMagic.btLevel = nLevel then Result := True;
            '>': if UserMagic.btLevel > nLevel then Result := True;
            '<': if UserMagic.btLevel < nLevel then Result := True;
          else if UserMagic.btLevel >= nLevel then Result := True;
          end;
        end;
      end;
  end else begin
    UserMagic:= PlayObject.GetMagicInfo(sMagicName);
    if UserMagic <> nil then begin
      case cMethod of
        '=': if UserMagic.btLevel = nLevel then Result := True;
        '>': if UserMagic.btLevel > nLevel then Result := True;
        '<': if UserMagic.btLevel < nLevel then Result := True;
      else if UserMagic.btLevel >= nLevel then Result := True;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKSKILLLEVEL');
end;
end;
//------------------------------------------------------------------------------
//����ͼָ������ָ�����ƹ������� 20081217 �޸�
//CHECKMAPMOBCOUNT ��ͼ X Y ���� ><= ���� ��Χ
function TNormNpc.ConditionOfCHECKMAPMOBCOUNT(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount,MonCount: Integer;
  Envir: TEnvirnoment;
  sMap:String;
begin
  try
    Result := False;
    nCount:= Str_ToInt(QuestConditionInfo.sParam6, -1);//����
    sMap:=GetLineVariableText(PlayObject, QuestConditionInfo.sParam1); //��ͼID ֧�ֱ���

    Envir := g_MapManager.FindMap(sMap);
    MonCount:=UserEngine.GetMapMonsterCount(Envir, QuestConditionInfo.nParam2,QuestConditionInfo.nParam3, QuestConditionInfo.nParam7, Trim(QuestConditionInfo.sParam4));

    cMethod := QuestConditionInfo.sParam5[1];
    case cMethod of //�ȽϹ�������
      '=': if MonCount = nCount then Result := True;
      '>': if MonCount > nCount then Result := True;
      '<': if MonCount < nCount then Result := True;
    else if MonCount >= nCount then Result := True;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKMAPMOBCOUNT');
  end;
end;
//------------------------------------------------------------------------------
//���������Χ�Լ��������� 20080425
//��ʽ��CHECKSIDESLAVENAME ��������(*��������) ��Χ (>,<,=) ����
function TNormNpc.ConditionOfCHECKSIDESLAVENAME(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sMonName: String;
  cMethod: Char;
  nCount,nRange,slavCount,I ,K: Integer;
  MonList: TList;
  MoveMon,Slave: TBaseObject;
  boAllSlave: Boolean;
begin
try
  Result := False;
  boAllSlave:= False;
  SlavCount:= 0;
  sMonName:= GetLineVariableText(PlayObject, QuestConditionInfo.sParam1); //��������
  nRange:=Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2), -1);//��Χ ֧�ֱ���
  nCount:=Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam4), -1);//���� ֧�ֱ���
  cMethod := QuestConditionInfo.sParam3[1];//������
  if  sMonName='*' then boAllSlave:= True;

  MonList := TList.Create;
  try
    UserEngine.GetMapRangeMonster(PlayObject.m_PEnvir, PlayObject.m_nCurrX, PlayObject.m_nCurrY, nRange, MonList);//��ָ��XY��Χ�ڵĹ�
    if MonList.Count > 0 then begin//20080629
      for I := 0 to MonList.Count - 1 do begin
        MoveMon := TBaseObject(MonList.Items[I]);
        if PlayObject.m_SlaveList.Count > 0 then begin//20080629
          for K:=0 to PlayObject.m_SlaveList.Count - 1 do begin
            Slave:= TBaseObject(PlayObject.m_SlaveList.Items[K]);
            if (Slave <> nil) then begin
              if not boAllSlave then begin
                if (CompareText(Slave.m_sCharName,sMonName)= 0) and (Slave = MoveMon) then Inc(SlavCount);
              end else
                if (Slave = MoveMon) then Inc(SlavCount);
            end;
          end;//for
        end;
      end;//for
    end;
  finally
    MonList.Free;
  end;

  case cMethod of //�ȽϹ�������
    '=': if SlavCount = nCount then Result := True;
    '>': if SlavCount > nCount then Result := True;
    '<': if SlavCount < nCount then Result := True;
  else if SlavCount >= nCount then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKSIDESLAVENAME');
end;
end;
//------------------------------------------------------------------------------
//��⵱ǰ�����Ƿ�С�ڴ��ڵ���ָ��������,�������ڲ����������M0��   20080416
//CHECKCURRENTDATE ><= ����
function TNormNpc.ConditionOfCHECKCURRENTDATE(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;//������
  sDate:String;//ָ��������
begin
try
  Result := False;
  sDate:= QuestConditionInfo.sParam2;//ָ��������
  cMethod := QuestConditionInfo.sParam1[1];

  case cMethod of //�Ƚ�ָ������д��ǰ����
    '=': if Trunc(Date) = Trunc(StrToDate(sDate)) then Result := True;
    '>': if Date > StrToDate(sDate) then Result := True;
    '<': if Date < StrToDate(sDate) then Result := True;
  end;

  if Date < StrToDate(sDate) then
     PlayObject.m_nMval[0]:= Trunc(Date - StrToDate(sDate))
  else
  if Date > StrToDate(sDate) then
     PlayObject.m_nMval[0]:= - Trunc(Date - StrToDate(sDate))//����
  else
  if Trunc(Date) = Trunc(StrToDate(sDate)) then PlayObject.m_nMval[0]:= 0;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKCURRENTDATE');
end;
end;
//------------------------------------------------------------------------------
//����Ƿ��ڹ����ڼ� 20080422
//��ʽ:CHECKCASTLEWAR �Ǳ�����
function TNormNpc.ConditionOfCHECKCASTLEWAR(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  Castle: TUserCastle;
  CastleName: String;
begin
  try
    Result := False;
    CastleName:= GetLineVariableText(PlayObject, QuestConditionInfo.sParam1); //�Ǳ����� ֧�ֱ���
    Castle:= g_CastleManager.Find(CastleName);
    if Castle <> nil then begin
      if Castle.m_boUnderWar then Result := True;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKCASTLEWAR');
  end;
end;
//------------------------------------------------------------------------------
//���ʦ������ͽ�ܣ��Ƿ����� 20080416
//��ʽ:CHECKMASTERONLINE
function TNormNpc.ConditionOfCHECKMASTERONLINE(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  m_MasterHuman: TPlayObject;
begin
try
  Result := False;
  if PlayObject.m_boMaster then begin //��ͽ��
    //m_MasterHuman := UserEngine.GetPlayObject(PlayObject.m_sMasterName);
    m_MasterHuman := UserEngine.GetMasterObject(PlayObject.m_sCharName);//20080512
    if m_MasterHuman <> nil then Result := True;
  end else
    if PlayObject.m_sMasterName <> '' then begin
      m_MasterHuman := UserEngine.GetPlayObject(PlayObject.m_sMasterName);
      if m_MasterHuman <> nil then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKMASTERONLINE');
end;
end;
//------------------------------------------------------------------------------
//������һ���Ƿ����� 20080416
//��ʽ:CHECKDEARONLINE
function TNormNpc.ConditionOfCHECKDEARONLINE(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if PlayObject.m_DearHuman <> nil then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKDEARONLINE');
end;
end;
//------------------------------------------------------------------------------
//���ʦ��(��ͽ��)�Ƿ���XXX��ͼ,֧��SELF(�Ƿ�ͬһ��ͼ) 20080416
//��ʽ:CHECKMASTERONMAP XXX
function TNormNpc.ConditionOfCHECKMASTERONMAP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  m_MasterHuman: TPlayObject;
  sMapName: string;
begin
try
  Result := False;
  if CompareText(QuestConditionInfo.sParam1, 'Self') = 0 then begin
    sMapName := PlayObject.m_sMapName;
  end else begin
    sMapName := QuestConditionInfo.sParam1;
    GetValValue(PlayObject, QuestConditionInfo.sParam1, sMapName);
  end;

  if PlayObject.m_boMaster then begin //��ͽ��
    //m_MasterHuman := UserEngine.GetPlayObject(PlayObject.m_sMasterName);
    m_MasterHuman := UserEngine.GetMasterObject(PlayObject.m_sCharName);//20080512
    if (m_MasterHuman <> nil) and (CompareText(m_MasterHuman.m_sMapName , sMapName)= 0) then Result := True;
  end else
    if PlayObject.m_sMasterName <> '' then begin
      m_MasterHuman := UserEngine.GetPlayObject(PlayObject.m_sMasterName);
      if (m_MasterHuman <> nil) and (CompareText(m_MasterHuman.m_sMapName,sMapName)= 0) then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKMASTERONMAP');
end;
end;
//------------------------------------------------------------------------------
//������һ���Ƿ���XXX��ͼ,֧��SELF(�Ƿ�ͬһ��ͼ) 20080416
//��ʽ:CHECKDEARONMAP XXX
function TNormNpc.ConditionOfCHECKDEARONMAP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sMapName: string;
begin
try
  Result := False;
  if CompareText(QuestConditionInfo.sParam1, 'Self') = 0 then begin
    sMapName := PlayObject.m_sMapName;
  end else begin
    sMapName := QuestConditionInfo.sParam1;
    GetValValue(PlayObject, QuestConditionInfo.sParam1, sMapName);
  end;
  if (PlayObject.m_DearHuman <> nil) and (CompareText(PlayObject.m_DearHuman.m_sMapName,sMapName)=0) then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKDEARONMAP');
end;
end;
//------------------------------------------------------------------------------
//�������Ƿ�Ϊ�Լ���ͽ�� 20080416
//��ʽ:CHECKPOSEISPRENTICE
function TNormNpc.ConditionOfCHECKPOSEISPRENTICE(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  BaseObject: TBaseObject;
begin
try
  Result := False;
  BaseObject := GetPoseCreate();//�ж�������Ƿ�������
  if BaseObject <> nil then begin
    if TPlayObject(BaseObject).m_boMaster then begin //��ͽ��
      if CompareText(TPlayObject(BaseObject).m_sMasterName , PlayObject.m_sCharName)= 0 then Result := True;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKPOSEISPRENTICE');
end;
end;
//------------------------------------------------------------------------------
//�ű����� FINDMAPPATH ��ͼ ��X ��Y �յ�X �յ�Y (ֻҪʹ��һ�μȿ�) 20080124
function TNormNpc.ConditionOfFINDMAPPATH(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sMap: string;
  nX,nY,nXX,nYY: Integer;
  Envir: TEnvirnoment;
begin
try
  Result := False;
  sMap:= GetLineVariableText(PlayObject, QuestConditionInfo.sParam1); //��ͼ֧�ֱ���
  nX:=Str_ToInt(QuestConditionInfo.sParam2, -1);//��X
  nY:=Str_ToInt(QuestConditionInfo.sParam3, -1);//��Y
  nXX:=Str_ToInt(QuestConditionInfo.sParam4, -1);//�յ�X
  nYY:=Str_ToInt(QuestConditionInfo.sParam5, -1);//�յ�Y
  if sMap='' then Exit;

  Envir := g_MapManager.FindMap(sMap);//���ҵ�ͼ
  if Envir <> nil then begin
    //UserEngine.m_sMapName_136:=sMap;//20090204
    UserEngine.m_nCurrX_136:=nX;
    UserEngine.m_nCurrY_136:=nY;
    UserEngine.m_NewCurrX_136:=nXX;
    UserEngine.m_NewCurrY_136:=nYY;
    PlayObject.m_sMapName136:= sMap; //ħ�����ͼ���� 20090204

    {g_boMission := True; //���ù��Ｏ�е�  20090204
    g_sMissionMap := sMap;
    g_nMissionX := nX;
    g_nMissionY := nY;}

    Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfFINDMAPPATH');
end;
end;
//-------------------------------------------------------------------------
//���Ӣ�۵��ҳ϶� 20080109
function TNormNpc.ConditionOfCHECKHEROLOYAL(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nLoyal: Integer;
begin
try
  Result := False;
  if PlayObject.m_MyHero =nil then  Exit;
  nLoyal := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nLoyal < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nLoyal) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHEROLOYAL);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if THeroObject(PlayObject.m_MyHero).m_nLoyal = nLoyal then Result := True;
    '>': if THeroObject(PlayObject.m_MyHero).m_nLoyal > nLoyal then Result := True;
    '<': if THeroObject(PlayObject.m_MyHero).m_nLoyal < nLoyal then Result := True;
  else if THeroObject(PlayObject.m_MyHero).m_nLoyal >= nLoyal then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKHEROLOYAL');
end;
end;
//------------------------------------------------------------------------------
//�ж��Ƿ��������־� 20080620
//��ʽ:ISONMAKEWINE X(1,2)  X-1��ͨ�� 2-ҩ��
function TNormNpc.ConditionOfISONMAKEWINE(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nMakeWineType:Byte;
begin
try
  Result := False;
  nMakeWineType:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam1), 0);
  if not nMakeWineType in [1,2] then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sISONMAKEWINE);
    Exit;
  end;
  if PlayObject.m_boMakeWine then begin//��NPC���������
     if PlayObject.n_MakeWineType = nMakeWineType then Result := True;//�Ƶ�����һ��
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfISONMAKEWINE');
end;
end;
//------------------------------------------------------------------------------
//����:�ж��Ƿ����л�Ȫˮ�ֿ� 20080625
//��ʽ:CHECKGUILDFOUNTAIN
function TNormNpc.ConditionOfCHECKGUILDFOUNTAIN(PlayObject: TPlayObject;QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if PlayObject.m_MyGuild <> nil then begin
    if TGUild(PlayObject.m_MyGuild).boGuildFountainOpen then Result:=True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKGUILDFOUNTAIN');
end;
end;
//------------------------------------------------------------------------------
//���������
function TNormNpc.ConditionOfCheckGamePoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGamePoint: Integer;
begin
try
  Result := False;
  nGamePoint:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2), -1);//20080519
  if nGamePoint < 0 then nGamePoint := QuestConditionInfo.nParam2;
  //nGamePoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nGamePoint < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nGamePoint) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGAMEPOINT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nGamePoint = nGamePoint then Result := True;
    '>': if PlayObject.m_nGamePoint > nGamePoint then Result := True;
    '<': if PlayObject.m_nGamePoint < nGamePoint then Result := True;
  else if PlayObject.m_nGamePoint >= nGamePoint then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckGamePoint');
end;
end;

function TNormNpc.ConditionOfCheckGroupCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
begin
try
  Result := False;
  if PlayObject.m_GroupOwner = nil then Exit;

  //nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nCount:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nCount < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nCount) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKGROUPCOUNT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_GroupOwner.m_GroupMembers.Count = nCount then Result := True;
    '>': if PlayObject.m_GroupOwner.m_GroupMembers.Count > nCount then Result := True;
    '<': if PlayObject.m_GroupOwner.m_GroupMembers.Count < nCount then Result := True;
  else if PlayObject.m_GroupOwner.m_GroupMembers.Count >= nCount then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckGroupCount');
end;
end;

function TNormNpc.ConditionOfCheckHaveGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := PlayObject.m_MyGuild <> nil; // 01-16 �������������
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckHaveGuild');
end;
end;

function TNormNpc.ConditionOfCheckInMapRange(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sMapName: string;
  nX, nY, nRange: Integer;
begin
try
  Result := False;
  {sMapName := QuestConditionInfo.sParam1;
  nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);}
  sMapName := GetLineVariableText(PlayObject,QuestConditionInfo.sParam1);//20080501
  nX:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  nY:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam3),-1);//20080501
  nRange:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam4),-1);//20080501
  if nX < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam2, nX); //���ӱ���֧��
  end;
  if nY < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam3, nY); //���ӱ���֧��
  end;
  if nRange < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam4, nRange); //���ӱ���֧��
  end;
  if (sMapName = '') or (nX < 0) or (nY < 0) or (nRange < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKINMAPRANGE);
    Exit;
  end;
  if CompareText(PlayObject.m_sMapName, sMapName) <> 0 then Exit;
  if (abs(PlayObject.m_nCurrX - nX) <= nRange) and (abs(PlayObject.m_nCurrY - nY) <= nRange) then
    Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckInMapRange');
end;
end;

function TNormNpc.ConditionOfCheckIsAttackGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISATTACKGUILD);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then Exit;
  Result := TUserCastle(m_Castle).IsAttackGuild(TGUild(PlayObject.m_MyGuild));
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckIsAttackGuild');
end;
end;

function TNormNpc.ConditionOfCheckCastleChageDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  cMethod: Char;
  nChangeDay: Integer;
begin
try
  Result := False;
  //nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nDay:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nDay < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam2, nDay); //���ӱ���֧��
  end;
  if (nDay < 0) or (m_Castle = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CASTLECHANGEDAY);
    Exit;
  end;
  nChangeDay := GetDayCount(Now, TUserCastle(m_Castle).m_ChangeDate);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nChangeDay = nDay then Result := True;
    '>': if nChangeDay > nDay then Result := True;
    '<': if nChangeDay < nDay then Result := True;
  else if nChangeDay >= nDay then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckCastleChageDay');
end;
end;

function TNormNpc.ConditionOfCheckCastleWarDay(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  cMethod: Char;
  nWarDay: Integer;
begin
try
  Result := False;
  //nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nDay:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nDay < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam2, nDay); //���ӱ���֧��
  end;
  if (nDay < 0) or (m_Castle = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CASTLEWARDAY);
    Exit;
  end;
  nWarDay := GetDayCount(Now, TUserCastle(m_Castle).m_WarDate);
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nWarDay = nDay then Result := True;
    '>': if nWarDay > nDay then Result := True;
    '<': if nWarDay < nDay then Result := True;
  else if nWarDay >= nDay then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckCastleWarDay');
end;
end;

function TNormNpc.ConditionOfCheckCastleDoorStatus(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nDay: Integer;
  nDoorStatus: Integer;
  CastleDoor: TCastleDoor;
begin
try
  Result := False;
  //nDay := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nDay:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nDay < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam2, nDay); //���ӱ���֧��
  end;
  nDoorStatus := -1;
  if CompareText(QuestConditionInfo.sParam1, '��') = 0 then nDoorStatus := 0;
  if CompareText(QuestConditionInfo.sParam1, '����') = 0 then nDoorStatus := 1;
  if CompareText(QuestConditionInfo.sParam1, '�ر�') = 0 then nDoorStatus := 2;

  if (nDay < 0) or (m_Castle = nil) or (nDoorStatus < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLEDOOR);
    Exit;
  end;
  CastleDoor := TCastleDoor(TUserCastle(m_Castle).m_MainDoor.BaseObject);

  case nDoorStatus of
    0: if CastleDoor.m_boDeath then Result := True;
    1: if CastleDoor.m_boOpened then Result := True;
    2: if not CastleDoor.m_boOpened then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckCastleDoorStatus');
end;
end;

function TNormNpc.ConditionOfCheckIsAttackAllyGuild( PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISATTACKALLYGUILD);
    Exit;
  end;
  if PlayObject.m_MyGuild = nil then Exit;
  Result := TUserCastle(m_Castle).IsAttackAllyGuild(TGUild(PlayObject.m_MyGuild));
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckIsAttackAllyGuild');
end;
end;

function TNormNpc.ConditionOfCheckIsDefenseAllyGuild( PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISDEFENSEALLYGUILD);
    Exit;
  end;

  if PlayObject.m_MyGuild = nil then Exit;
  Result := TUserCastle(m_Castle).IsDefenseAllyGuild(TGUild(PlayObject.m_MyGuild));
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckIsDefenseAllyGuild');
end;
end;

function TNormNpc.ConditionOfCheckIsDefenseGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if m_Castle = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISDEFENSEGUILD);
    Exit;
  end;

  if PlayObject.m_MyGuild = nil then Exit;
  Result := TUserCastle(m_Castle).IsDefenseGuild(TGUild(PlayObject.m_MyGuild));
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckIsDefenseGuild');
end;
end;

function TNormNpc.ConditionOfCheckIsCastleaGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  //  if (PlayObject.m_MyGuild <> nil) and (UserCastle.m_MasterGuild = PlayObject.m_MyGuild) then
  if g_CastleManager.IsCastleMember(PlayObject) <> nil then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckIsCastleaGuild');
end;
end;

function TNormNpc.ConditionOfCheckIsCastleMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  //if PlayObject.IsGuildMaster and (UserCastle.m_MasterGuild = PlayObject.m_MyGuild) then
  if PlayObject.IsGuildMaster and (g_CastleManager.IsCastleMember(PlayObject) <> nil) then
    Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckIsCastleMaster');
end;
end;

function TNormNpc.ConditionOfCheckIsGuildMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := PlayObject.IsGuildMaster;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckIsGuildMaster');
end;
end;
//����ǲ��Ǳ��˵�ʦ�� 20080608
function TNormNpc.ConditionOfCheckIsMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if {(PlayObject.m_sMasterName <> '') and} (PlayObject.m_boMaster) then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckIsMaster');
end;
end;

//�����Ʒ���ӵĸ�������
function TNormNpc.ConditionOfCheckItemAddValue(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere: Integer;
  nAddAllValue, nAddValue: Integer;
  UserItem: pTUserItem;
  cMethod: Char;
  nValType: Integer;
begin
try
  Result := False;
  //nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
  //nValType := Str_ToInt(QuestConditionInfo.sParam2, -1);
  //nAddValue := Str_ToInt(QuestConditionInfo.sParam4, -1);
  nWhere:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam1),-1);//20080501
  if nWhere < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam1, nWhere);
  end;
  nValType:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nValType < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam2, nValType);
  end;
  nAddValue:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam4),-1);//20080501
  if nAddValue < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam4, nAddValue);
  end;

  cMethod := QuestConditionInfo.sParam3[1];
  if (nValType < 0) or (nValType > 15) or (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nAddValue < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMADDVALUE);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  if UserItem.wIndex = 0 then Exit;
  //nAddAllValue := 0;
  {for i := Low(UserItem.btValue) to High(UserItem.btValue) do begin
    Inc(nAddAllValue, UserItem.btValue[i]);
  end;}
  if nValType = 15 then nValType := 20;//20081103 15������������
  if nValType = 14 then nAddAllValue := UserItem.DuraMax
  else nAddAllValue := UserItem.btValue[nValType];
  case cMethod of
    '=': if nAddAllValue = nAddValue then Result := True;
    '>': if nAddAllValue > nAddValue then Result := True;
    '<': if nAddAllValue < nAddValue then Result := True;
  else if nAddAllValue >= nAddValue then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckItemAddValue');
end;
end;

function TNormNpc.ConditionOfCheckItemType(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere: Integer;
  nType: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
try
  Result := False;
  //nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
  //nType := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nWhere:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam1),-1);//20080501
  nType:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nWhere < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam1, nWhere); //���ӱ���֧��
  end;
  if nType < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam2, nType); //���ӱ���֧��
  end;
  if not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)]) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMTYPE);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  if UserItem.wIndex = 0 then Exit;
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (StdItem <> nil) and (StdItem.StdMode = nType) then begin
    Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckItemType');
end;
end;
//�����ҵȼ�
function TNormNpc.ConditionOfCheckLevelEx(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
try
  Result := False;
  //nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nLevel:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nLevel < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nLevel) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKLEVELEX);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_Abil.Level = nLevel then Result := True;
    '>': if PlayObject.m_Abil.Level > nLevel then Result := True;
    '<': if PlayObject.m_Abil.Level < nLevel then Result := True;
  else if PlayObject.m_Abil.Level >= nLevel then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckLevelEx');
end;
end;

function TNormNpc.ConditionOfCheckNameListPostion(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  nNamePostion, nPostion: Integer;
  sLine: string;
  cMethod: Char;
begin
try
  Result := False;
  nNamePostion := -1;
  try
    sCharName := PlayObject.m_sCharName;
    LoadList := TStringList.Create;
    if FileExists(g_Config.sEnvirDir + QuestConditionInfo.sParam1) then begin
      LoadList.LoadFromFile(g_Config.sEnvirDir + QuestConditionInfo.sParam1);
      if LoadList.Count > 0 then begin//20080629
        for I := 0 to LoadList.Count - 1 do begin
          sLine := Trim(LoadList.Strings[I]);
          if (sLine = '') or (sLine[1] = ';') then Continue;
          if CompareText(sLine, sCharName) = 0 then begin
            nNamePostion := I + 1;
            Break;
          end;
        end;
      end;
    end else begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMELISTPOSITION);
    end;
  finally
    LoadList.Free
  end;
  cMethod := QuestConditionInfo.sParam2[1];
  //nPostion := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nPostion:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam3),-1);//20080501
  if nPostion < 0 then begin
    GetValValue(PlayObject, QuestConditionInfo.sParam3, nPostion); //���ӱ���֧��
  end;

  SetValValue(PlayObject, QuestConditionInfo.sParam4, nNamePostion);
  if nPostion < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMELISTPOSITION);
    Exit;
  end;
  case cMethod of
    '=': if nNamePostion = nPostion then Result := True;
    '>': if nNamePostion > nPostion then Result := True;
    '<': if nNamePostion < nPostion then Result := True;
  else if nNamePostion >= nPostion then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckNameListPostion');
end;
end;

function TNormNpc.ConditionOfCheckMarry(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if PlayObject.m_sDearName <> '' then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMarry');
end;
end;

function TNormNpc.ConditionOfCheckMarryCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
try
  Result := False;
  //nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nCount:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nCount < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nCount) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMARRYCOUNT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btMarryCount = nCount then Result := True;
    '>': if PlayObject.m_btMarryCount > nCount then Result := True;
    '<': if PlayObject.m_btMarryCount < nCount then Result := True;
  else if PlayObject.m_btMarryCount >= nCount then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMarryCount');
end;
end;

function TNormNpc.ConditionOfCheckMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if (PlayObject.m_sMasterName <> '') and (not PlayObject.m_boMaster) then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMaster');
end;
end;

function TNormNpc.ConditionOfCheckMemBerLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
try
  Result := False;
  //nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nLevel:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nLevel < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nLevel) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMEMBERLEVEL);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nMemberLevel = nLevel then Result := True;
    '>': if PlayObject.m_nMemberLevel > nLevel then Result := True;
    '<': if PlayObject.m_nMemberLevel < nLevel then Result := True;
  else if PlayObject.m_nMemberLevel >= nLevel then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMemBerLevel');
end;
end;

function TNormNpc.ConditionOfCheckMemberType(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nType: Integer;
  cMethod: Char;
begin
try
  Result := False;
  //nType := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nType:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nType < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nType) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMEMBERTYPE);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nMemberType = nType then Result := True;
    '>': if PlayObject.m_nMemberType > nType then Result := True;
    '<': if PlayObject.m_nMemberType < nType then Result := True;
  else if PlayObject.m_nMemberType >= nType then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMemberType');
end;
end;

function TNormNpc.ConditionOfCheckNameIPList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sCharName: string;
  sCharAccount: string;
  sCharIPaddr: string;
  sLine: string;
  sName: string;
  sIPaddr: string;
begin
try
  Result := False;
  try
    sCharName := PlayObject.m_sCharName;
    sCharAccount := PlayObject.m_sUserID;
    sCharIPaddr := PlayObject.m_sIPaddr;
    LoadList := TStringList.Create;
    if FileExists(g_Config.sEnvirDir + QuestConditionInfo.sParam1) then begin
      LoadList.LoadFromFile(g_Config.sEnvirDir + QuestConditionInfo.sParam1);
      if LoadList.Count > 0 then begin//20080629
        for I := 0 to LoadList.Count - 1 do begin
          sLine := LoadList.Strings[I];
          if sLine[1] = ';' then Continue;
          sIPaddr := GetValidStr3(sLine, sName, [' ', '/', #9]);
          sIPaddr := Trim(sIPaddr);
          if (sName = sCharName) and (sIPaddr = sCharIPaddr) then begin
            Result := True;
            Break;
          end;
        end;
      end;
    end else begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMEIPLIST);
    end;
  finally
    LoadList.Free;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckNameIPList');
end;
end;
//���ܣ����Լ���������վ��λ���Ա�Ҫ������棩
//��ʽ��CHECKPOSEDIR ���Ʒ�(1,2)
function TNormNpc.ConditionOfCheckPoseDir(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
try
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.GetPoseCreate = PlayObject) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    case QuestConditionInfo.nParam1 of
      1: if PoseHuman.m_btGender = PlayObject.m_btGender then Result := True; //Ҫ����ͬ�Ա�
      2: if PoseHuman.m_btGender <> PlayObject.m_btGender then Result := True; //Ҫ��ͬ�Ա�
    else Result := True; //�޲���ʱ���б��Ա�
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPoseDir');
end;
end;

function TNormNpc.ConditionOfCheckPoseGender(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
  btSex: Byte;
begin
try
  Result := False;
  btSex := 0;
  if CompareText(QuestConditionInfo.sParam1, 'MAN') = 0 then begin
    btSex := 0;
  end else
    if CompareText(QuestConditionInfo.sParam1, '��') = 0 then begin
    btSex := 0;
  end else
    if CompareText(QuestConditionInfo.sParam1, 'WOMAN') = 0 then begin
    btSex := 1;
  end else
    if CompareText(QuestConditionInfo.sParam1, 'Ů') = 0 then begin
    btSex := 1;
  end;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if PoseHuman.m_btGender = btSex then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPoseGender');
end;
end;

function TNormNpc.ConditionOfCheckPoseIsMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
try
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if (TPlayObject(PoseHuman).m_sMasterName <> '') and (TPlayObject(PoseHuman).m_boMaster) then
      Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPoseIsMaster');
end;
end;

function TNormNpc.ConditionOfCheckPoseLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  PoseHuman: TBaseObject;
  cMethod: Char;
begin
try
  Result := False;
  //nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nLevel := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nLevel < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nLevel) then begin //����֧�ֱ���
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKPOSELEVEL);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    case cMethod of
      '=': if PoseHuman.m_Abil.Level = nLevel then Result := True;
      '>': if PoseHuman.m_Abil.Level > nLevel then Result := True;
      '<': if PoseHuman.m_Abil.Level < nLevel then Result := True;
    else if PoseHuman.m_Abil.Level >= nLevel then Result := True;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPoseLevel');
end;
end;

function TNormNpc.ConditionOfCheckPoseMarry(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
try
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if TPlayObject(PoseHuman).m_sDearName <> '' then
      Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPoseMarry');
end;
end;

function TNormNpc.ConditionOfCheckPoseMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
try
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if (TPlayObject(PoseHuman).m_sMasterName <> '') and not (TPlayObject(PoseHuman).m_boMaster) then
      Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPoseMaster');
end;
end;

function TNormNpc.ConditionOfCheckServerName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if QuestConditionInfo.sParam1 = g_Config.sServerName then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckServerName');
end;
end;

function TNormNpc.ConditionOfCheckSlaveCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
try
  Result := False;
  //nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nCount < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nCount) then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSLAVECOUNT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_SlaveList.Count = nCount then Result := True;
    '>': if PlayObject.m_SlaveList.Count > nCount then Result := True;
    '<': if PlayObject.m_SlaveList.Count < nCount then Result := True;
  else if PlayObject.m_SlaveList.Count >= nCount then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckSlaveCount');
end;
end;

function TNormNpc.ConditionOfCheckSafeZone(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := PlayObject.InSafeZone;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckSafeZone');
end;
end;
//��鵱ǰ���ڵ�ͼ������
//��ʽ:CHECKMAPNAME ����(self) ��ͼ��
function TNormNpc.ConditionOfCheckMapName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sCharName: string;
  sMapName: string;
  OnlinePlayObject: TPlayObject;
begin
try
  Result := False;
  if CompareText(QuestConditionInfo.sParam1, 'Self') = 0 then begin
    sCharName := PlayObject.m_sCharName;
  end else begin
   //sCharName := QuestConditionInfo.sParam1;
   // GetValValue(PlayObject, QuestConditionInfo.sParam1, sCharName);
    sCharName := GetLineVariableText(PlayObject,QuestConditionInfo.sParam1);//20080501
  end;
  //sMapName := QuestConditionInfo.sParam2;
  //GetValValue(PlayObject, QuestConditionInfo.sParam2, sMapName);
  sMapName := GetLineVariableText(PlayObject,QuestConditionInfo.sParam2);//20080501

  if sCharName = PlayObject.m_sCharName then begin
    if sMapName = PlayObject.m_sMapName then Result := True;
  end else begin
    OnlinePlayObject := UserEngine.GetPlayObject(sCharName);
    if OnlinePlayObject <> nil then begin
      if OnlinePlayObject.m_sMapName = sMapName then Result := True;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMapName');
end;
end;
//���ܣ�������＼�ܵȼ�
//CHECKSKILL �������� ���Ʒ�(=,>,<)  �����ȼ�
function TNormNpc.ConditionOfCheckSkill(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nSkillLevel: Integer;
  cMethod: Char;
  UserMagic: pTUserMagic;
begin
try
  Result := False;
  //nSkillLevel := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nSkillLevel:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam3),-1);//20080501
  if nSkillLevel < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam3, nSkillLevel) then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sCHECKSKILL);
      Exit;
    end;
  end;
  UserMagic := nil;
  UserMagic := TPlayObject(PlayObject).GetMagicInfo(QuestConditionInfo.sParam1);
  if UserMagic = nil then Exit;
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=': if UserMagic.btLevel = nSkillLevel then Result := True;
    '>': if UserMagic.btLevel > nSkillLevel then Result := True;
    '<': if UserMagic.btLevel < nSkillLevel then Result := True;
  else if UserMagic.btLevel >= nSkillLevel then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckSkill');
end;
end;
//���ܣ����Ӣ�ۼ��� 20080423
//HEROCHECKSKILL �������� ���Ʒ�(=,>,<)  �����ȼ�
function TNormNpc.ConditionOfHEROCHECKSKILL(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nSkillLevel: Integer;
  cMethod: Char;
  UserMagic: pTUserMagic;
begin
try
  Result := False;
  //nSkillLevel := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nSkillLevel:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam3),-1);//20080501
  if nSkillLevel < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam3, nSkillLevel) then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sHEROCHECKSKILL);
      Exit;
    end;
  end;
  if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
    ScriptConditionError(PlayObject, QuestConditionInfo, sHEROCHECKSKILL);
    Exit;
  end;
  if PlayObject.m_MyHero <> nil then begin
    UserMagic := nil;
    UserMagic := TPlayObject(PlayObject.m_MyHero).GetMagicInfo(QuestConditionInfo.sParam1);
    if UserMagic = nil then Exit;
    cMethod := QuestConditionInfo.sParam2[1];
    case cMethod of
      '=': if UserMagic.btLevel = nSkillLevel then Result := True;
      '>': if UserMagic.btLevel > nSkillLevel then Result := True;
      '<': if UserMagic.btLevel < nSkillLevel then Result := True;
    else if UserMagic.btLevel >= nSkillLevel then Result := True;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfHEROCHECKSKILL');
end;
end;


function TNormNpc.ConditionOfAnsiContainsText(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sValue1: string;
  sValue2: string;
begin
try
  Result := False;
  {sValue1 := QuestConditionInfo.sParam1;
  sValue2 := QuestConditionInfo.sParam2;
  GetValValue(PlayObject, QuestConditionInfo.sParam1, sValue1);
  GetValValue(PlayObject, QuestConditionInfo.sParam2, sValue2);}
  sValue1 := GetLineVariableText(PlayObject,QuestConditionInfo.sParam1);//20080501
  sValue2 := GetLineVariableText(PlayObject,QuestConditionInfo.sParam2);//20080501
  if AnsiContainsText(sValue1, sValue2) then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfAnsiContainsText');
end;
end;
//�Ƚ��ַ����Ƿ�һ��
function TNormNpc.ConditionOfCompareText(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sValue1: string;
  sValue2: string;
begin
try
  Result := False;
 { sValue1 := QuestConditionInfo.sParam1;
  sValue2 := QuestConditionInfo.sParam2;
  GetValValue(PlayObject, QuestConditionInfo.sParam1, sValue1);
  GetValValue(PlayObject, QuestConditionInfo.sParam2, sValue2);}
  sValue1 := GetLineVariableText(PlayObject,QuestConditionInfo.sParam1);//20080501
  sValue2 := GetLineVariableText(PlayObject,QuestConditionInfo.sParam2);//20080501
  if CompareText(sValue1, sValue2) = 0 then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCompareText');
end;
end;

function TNormNpc.ConditionOfCheckStationTime(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount: Integer;
  cMethod: Char;
begin
try
  Result := False;
  //nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nCount < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nCount) then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSTATIONTIME);
      Exit;
    end;
  end;
  nCount := nCount * 60000{60 * 1000};
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if GetTickCount - PlayObject.m_dwStationTick = nCount then Result := True;
    '>': if GetTickCount - PlayObject.m_dwStationTick > nCount then Result := True;
    '<': if GetTickCount - PlayObject.m_dwStationTick < nCount then Result := True;
  else if GetTickCount - PlayObject.m_dwStationTick >= nCount then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckStationTime');
end;
end;
//�ж������Ƿ���Ӣ��  20080521
//��ʽ:HAVEHERO TRUE ��TRUE��������,�ж��Ƿ�������Ӣ��,������ʾ�ж��Ƿ��а�����Ӣ��
function TNormNpc.ConditionOfCheckHasHero(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if CompareText(QuestConditionInfo.sParam1, 'TRUE') = 0 then begin//�Ƿ�������Ӣ��
    if PlayObject.m_boHasHeroTwo and (PlayObject.m_sHeroCharName <> '') then Result := True;
  end else begin//�Ƿ��а�����Ӣ��
    if PlayObject.m_boHasHero and (PlayObject.m_sHeroCharName <> '') then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckHasHero');
end;
end;
//���Ӣ���Ƿ�����
function TNormNpc.ConditionOfCheckHeroOnline(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := PlayObject.m_MyHero <> nil;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckHeroOnline');
end;
end;
//���Ӣ�۵ĵȼ�
function TNormNpc.ConditionOfCheckHeroLevel(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nHeroLevel, nLevel: Integer;
  cMethod: Char;
begin
try
  Result := False;
  if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHEROLEVEL);
    Exit;
  end;

  //nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nLevel := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nLevel < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nLevel) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHEROLEVEL);
      Exit;
    end;
  end;

  if PlayObject.m_MyHero <> nil then begin
    nHeroLevel := PlayObject.m_MyHero.m_Abil.Level;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if nHeroLevel = nLevel then Result := True;
      '>': if nHeroLevel > nLevel then Result := True;
      '<': if nHeroLevel < nLevel then Result := True;
    else if nHeroLevel >= nLevel then Result := True;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckHeroLevel');
end;
end;
//���󴿶� 20080324
//�����ʽ:CHECKMINE ������ ���� ����
function TNormNpc.ConditionOfCHECKMINE(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sMineName: String;
  nMineCount, nDura, nCount, I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
try
  Result := False;
  nCount:= 0;
  sMineName:=GetLineVariableText(PlayObject, QuestConditionInfo.sParam1); //��ʯ��
  nMineCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//���� 20080501
  nDura := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam3),-1); //����20080501
  if nMineCount < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nMineCount) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMINE);
      Exit;
    end;
  end;
  if nDura < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam3, nDura) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMINE);
      Exit;
    end;
  end;

  if (sMineName='') or (nMineCount < 0) or (nDura < 0) or (nDura > 100) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMINE);
    Exit;
  end;
  if PlayObject.m_ItemList.Count > 0 then begin//20080628
    for I:=0 to PlayObject.m_ItemList.Count - 1 do begin
      UserItem := PlayObject.m_ItemList.Items[I];
      if UserItem <> nil then begin//20090203
        StdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if (StdItem <> nil) then begin//20090203
          if (StdItem.StdMode = 43) and (CompareText(StdItem.Name, sMineName) = 0) then begin
            if UserItem.Dura >= nDura * 1000 then Inc(nCount);
            if nCount >= nMineCount then begin
              Result := True;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKMINE');
end;
end;

//����:�����������
//��ʽ:CHECKONLINEPLAYCOUNT ������(<,>,=) ����
function TNormNpc.ConditionOfCHECKOnlinePlayCount(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
begin
try
  Result := False;
  nCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);
  if (nCount < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKONLINEPLAYCOUNT);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];//������
  case cMethod of
    '=': if UserEngine.PlayObjectCount = nCount then Result := TRUE;
    '>': if UserEngine.PlayObjectCount > nCount then Result := TRUE;
    '<': if UserEngine.PlayObjectCount < nCount then Result := TRUE;
    else if UserEngine.PlayObjectCount >= nCount then Result := TRUE;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKOnlinePlayCount');
end;
end;
//����:����������(��ɱ�����)�ȼ�
//��ʽ:CHECKPLAYDIELVL ������(<,>,=) �ȼ�
//     CHECKKILLPLAYLVL ������(<,>,=) �ȼ�
function TNormNpc.ConditionOfCheckPlaylvl(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nCount: Integer;
begin
try
  Result := False;
  nCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),0);
  if PlayObject.m_LastHiter <> nil then begin
    if PlayObject.m_LastHiter.m_btRaceServer = RC_PLAYOBJECT then begin
      cMethod := QuestConditionInfo.sParam1[1];//������
      case cMethod of
        '=': if PlayObject.m_LastHiter.m_WAbil.Level = nCount then Result := TRUE;
        '>': if PlayObject.m_LastHiter.m_WAbil.Level > nCount then Result := TRUE;
        '<': if PlayObject.m_LastHiter.m_WAbil.Level < nCount then Result := TRUE;
        else if PlayObject.m_LastHiter.m_WAbil.Level >= nCount then Result := TRUE;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPlaylvl');
end;
end;

//����:����������(��ɱ�����)ְҵ
//��ʽ:CHECKPLAYDIEJOB WARRIOR/WIZARD/TAOIST/ASSASSIN
//     CHECKKILLPLAYJOB WARRIOR/WIZARD/TAOIST/ASSASSIN
function TNormNpc.ConditionOfCheckPlayJob(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sParam1: string;
begin
try
  Result := False;
  if PlayObject.m_LastHiter <> nil then begin
    if PlayObject.m_LastHiter.m_btRaceServer = RC_PLAYOBJECT then begin
      sParam1 :=GetLineVariableText(PlayObject, QuestConditionInfo.sParam1);
      case PlayObject.m_LastHiter.m_btJob of
        0: if CompareText(sParam1, 'WARRIOR') = 0 then Result := TRUE;
        1: if CompareText(sParam1, 'WIZARD') = 0 then Result := TRUE;
        2: if CompareText(sParam1, 'TAOIST') = 0 then Result := TRUE;
        //3: if CompareText(sParam1, 'ASSASSIN') = 0 then Result := TRUE;//�̿�
        else Result := False;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPlayJob');
end;
end;

//����:����������(��ɱ�����)�Ա�
//��ʽ:CHECKKILLPLAYSEX MAN/WOMAN
//     CHECKPLAYDIESEX MAN/WOMAN
function TNormNpc.ConditionOfCheckPlaySex(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sParam1: string;
begin
try
  Result := False;
  if PlayObject.m_LastHiter <> nil then begin
    if PlayObject.m_LastHiter.m_btRaceServer = RC_PLAYOBJECT then begin
      sParam1 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1);
      case PlayObject.m_LastHiter.m_btGender of
        0: if CompareText(sParam1, 'MAN') = 0 then Result := TRUE;
        1: if CompareText(sParam1, 'WOMAN') = 0 then Result := TRUE;
        else Result := False;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPlaySex');
end;
end;
//���ܣ����װ������������
//��ʽ��CHECKITEMLEVEL ��Ʒλ��(0-13) (���� < > =) ֵ
function TNormNpc.ConditionOfCHECKITEMLEVEL(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere, nPoint: Integer;
  UserItem: pTUserItem;
  cMethod: Char;
begin
try
  Result := False;
  nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);//��Ʒλ��
  nPoint := Str_ToInt(QuestConditionInfo.sParam3, -1);//ֵ
  if (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nPoint < 0) or (nPoint > 255) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKITEMLEVEL);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  if UserItem.wIndex <= 0 then Exit;
  cMethod := QuestConditionInfo.sParam2[1];//������
  case cMethod of
    '=': if UserItem.btValue[9] = nPoint then Result := True;
    '>': if UserItem.btValue[9] > nPoint then Result := True;
    '<': if UserItem.btValue[9] < nPoint then Result := True;
    else if UserItem.btValue[9] >= nPoint then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKITEMLEVEL');
end;
end;

//����:���Ƶ�Ʒ�� 20080806
//��ʽ:CHECKMAKEWINE ������ ������(<,>,=) Ʒ��(0-10)
function TNormNpc.ConditionOfCHECKMAKEWINE(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sItmeName: String;
  nDura, I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  cMethod: Char;
begin
try
  Result := False;
  sItmeName:=GetLineVariableText(PlayObject, QuestConditionInfo.sParam1); //������
  nDura := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam3),-1);//��Ʒ��

  if nDura < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam3, nDura) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAKEWINE);
      Exit;
    end;
  end;

  if (sItmeName='') or (nDura < 0) or (nDura > 10) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAKEWINE);
    Exit;
  end;

  cMethod := QuestConditionInfo.sParam2[1];//������
  if PlayObject.m_ItemList.Count > 0 then begin
    for I:=0 to PlayObject.m_ItemList.Count - 1 do begin
      UserItem := PlayObject.m_ItemList.Items[I];
      StdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (StdItem <> nil) and (StdItem.StdMode = 60) and (StdItem.shape <> 0) and (CompareText(StdItem.Name, sItmeName) = 0) then begin
        case cMethod of
          '=': if UserItem.btValue[0] = nDura then Result := True;
          '>': if UserItem.btValue[0] > nDura then Result := True;
          '<': if UserItem.btValue[0] < nDura then Result := True;
          else if UserItem.btValue[0] >= nDura then Result := True;
        end;
        if Result then Break;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKMAKEWINE');
end;
end;

//���PKֵ 20080520
Function TNormNpc.ConditionOfCHECKPKPOINT(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nPKPOINT: Integer;
  cMethod: Char;
begin
try
  Result := False;
  nPKPOINT := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nPKPOINT < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nPKPOINT) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sCHECKPKPOINT);
      Exit;
    end;
  end;

  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_nPkPoint = nPKPOINT then Result := True;
    '>': if PlayObject.m_nPkPoint > nPKPOINT then Result := True;
    '<': if PlayObject.m_nPkPoint < nPKPOINT then Result := True;
    else if PlayObject.m_nPkPoint >= nPKPOINT then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKPKPOINT');
end;
end;
//���Ӣ��PKֵ 20080304
function TNormNpc.ConditionOfCHECKHEROPKPOINT(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  n_mHEROPKPOINT, nHEROPKPOINT: Integer;
  cMethod: Char;
begin
try
  Result := False;
  if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHEROPKPOINT);
    Exit;
  end;

  //nHEROPKPOINT := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nHEROPKPOINT := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nHEROPKPOINT < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nHEROPKPOINT) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHEROPKPOINT);
      Exit;
    end;
  end;

  if PlayObject.m_MyHero <> nil then begin
    n_mHEROPKPOINT := PlayObject.m_MyHero.m_nPkPoint;
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if n_mHEROPKPOINT = nHEROPKPOINT then Result := True;
      '>': if n_mHEROPKPOINT > nHEROPKPOINT then Result := True;
      '<': if n_mHEROPKPOINT < nHEROPKPOINT then Result := True;
    else if n_mHEROPKPOINT >= nHEROPKPOINT then Result := True;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKHEROPKPOINT');
end;
end;
//-----------------------------------------------------------------------------
//���ܣ�����ı���ı����Ƿ���� 20080410
//��ʽ��CHECKCODELIST ��ұ��� �ļ�·��
//����: CHECKCODELIST <$STR(S1)> ..\questdiary\��ֵ\500Ԫ����.txt
function TNormNpc.ConditionOfCHECKCODELIST(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sPlayID, sLine, sFileName: string;
begin
try
  Result := False;
  try
    sPlayID := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1);//���ӱ���֧�� 20080410 �û��ı���,��������ַ�
    LoadList := TStringList.Create;
    sFileName:= QuestConditionInfo.sParam2;//�ı�·��
    if sFileName[1] = '\' then sFileName := Copy(sFileName, 2, Length(sFileName) - 1);
    if sFileName[2] = '\' then sFileName := Copy(sFileName, 3, Length(sFileName) - 2);
    if sFileName[3] = '\' then sFileName := Copy(sFileName, 4, Length(sFileName) - 3);
    sFileName:= g_Config.sEnvirDir + sFileName;

    if FileExists(sFileName) then begin
      LoadList.LoadFromFile(sFileName);
      if LoadList.Count > 0 then begin//20080629
        for I := 0 to LoadList.Count - 1 do begin
          sLine := Trim(LoadList.Strings[I]);
          if (sLine = '') or (sLine[1] = ';') then Continue;
          if CompareText(sLine, sPlayID) = 0 then begin
            Result := True;
            Break;
          end;
        end;
      end;
    end else begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCODELIST);
    end;
  finally
    LoadList.Free;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKCODELIST');
end;
end;
//-----------------------------------------------------------------------------
//���ܣ�����л��Ա����
//��ʽ��CHECKGUILDMEMBERCOUNT <,>,= ����(65535)
function TNormNpc.ConditionOfCHECKGUILDMEMBERCOUNT(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nMemberCount: Word;
  cMethod: Char;
begin
  try
    Result := False;
    if PlayObject.m_MyGuild <> nil then begin
      nMemberCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),0);
      cMethod := QuestConditionInfo.sParam1[1];
      case cMethod of
        '=': if TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount = nMemberCount then Result := True;
        '>': if TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount > nMemberCount then Result := True;
        '<': if TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount < nMemberCount then Result := True;
      else if TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount >= nMemberCount then Result := True;
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKGUILDMEMBERCOUNT');
  end;
end;
//-----------------------------------------------------------------------------
//���ܣ�����л��Ȫ��
//��ʽ��CHECKGUILDFOUNTAINVALUE <,>,= ����
function TNormNpc.ConditionOfCHECKGUILDFOUNTAINValue(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nPoint: Integer;
  cMethod: Char;
begin
try
  Result := False;
  if PlayObject.m_MyGuild <> nil then begin
    nPoint := Str_ToInt(QuestConditionInfo.sParam2, 0);
    cMethod := QuestConditionInfo.sParam1[1];
    case cMethod of
      '=': if TGUild(PlayObject.m_MyGuild).m_nGuildFountain = nPoint then Result := True;
      '>': if TGUild(PlayObject.m_MyGuild).m_nGuildFountain > nPoint then Result := True;
      '<': if TGUild(PlayObject.m_MyGuild).m_nGuildFountain < nPoint then Result := True;
    else if TGUild(PlayObject.m_MyGuild).m_nGuildFountain >= nPoint then Result := True;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKGUILDFOUNTAINValue');
end;
end;
//-----------------------------------------------------------------------------
//����:����ɫ�ڹ��ȼ�
//��ʽ:CHECKNGLEVEL ������(<,>,=) �ȼ���(1-255) Hero
function TNormNpc.ConditionOfCHECKNGLEVEL(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Byte;
  cMethod: Char;
begin
  try
    Result := False;
    nLEVEL:= Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),0);
    if (nLEVEL <= 0) or (nLEVEL > 255) then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sCHECKNGLEVEL);
      Exit;
    end;
    cMethod := QuestConditionInfo.sParam1[1];
    if CompareText(QuestConditionInfo.sParam3, 'HERO') = 0 then begin
      if PlayObject.m_MyHero <> nil then begin
        if THeroObject(PlayObject.m_MyHero).m_boTrainingNG then begin
          case cMethod of
            '=': if THeroObject(PlayObject.m_MyHero).m_NGLevel = nLevel then Result := True;
            '>': if THeroObject(PlayObject.m_MyHero).m_NGLevel > nLevel then Result := True;
            '<': if THeroObject(PlayObject.m_MyHero).m_NGLevel < nLevel then Result := True;
          else if THeroObject(PlayObject.m_MyHero).m_NGLevel >= nLevel then Result := True;
          end;
        end;
      end;
    end else begin
      if PlayObject.m_boTrainingNG then begin
        case cMethod of
          '=': if PlayObject.m_NGLevel = nLevel then Result := True;
          '>': if PlayObject.m_NGLevel > nLevel then Result := True;
          '<': if PlayObject.m_NGLevel < nLevel then Result := True;
        else if PlayObject.m_NGLevel >= nLevel then Result := True;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKNGLEVEL');
  end;
end;
//-----------------------------------------------------------------------------
//����:���ָ��װ��λ���Ƿ����ָ������Ʒ
//��ʽ:CHECKITEMSNAME λ��(0-13) ��Ʒ����
function TNormNpc.ConditionOfCHECKITEMSNAME(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  n1: Integer;
  sName: String;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
try
  Result := False;
  n1 := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam1),-1);//λ��
  sName:= GetLineVariableText(PlayObject,QuestConditionInfo.sParam2);//��Ʒ����
  if (not (n1 in [0..13])) or (sName = '') then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sCHECKITEMSNAME);
    Exit;
  end;

  UserItem := @PlayObject.m_UseItems[n1];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    //PlayObject.SysMsg('������û�д�ָ����Ʒ������', c_Red, t_Hint);
    Exit;
  end;
  if CompareText(StdItem.Name, sName) = 0 then  Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKITEMSNAME');
end;
end;
//-----------------------------------------------------------------------------
//���ܣ����װ����״̬   20080312
//��ʽ��CHECKITEMSTATE װ��λ��(0-13) ��Ŀ(0-5)
//��Ŀ: 0 ��ֹ��1 ��ֹ���� 2 ��ֹ�� 3 ��ֹ�� 4 ��ֹ���� 5 ��ֹ����
function TNormNpc.ConditionOfCHECKITEMSTATE(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  n1,n2: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
try
  Result := False;
 { n1:=Str_ToInt(QuestConditionInfo.sParam1, -1);//λ��
  n2:=Str_ToInt(QuestConditionInfo.sParam2, -1);//��Ŀ }
  n1 := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam1),-1);//20080501
  n2 := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if n1 < 0 then GetValValue(PlayObject, QuestConditionInfo.sParam1, n1); //֧�ֱ���
  if n2 < 0 then GetValValue(PlayObject, QuestConditionInfo.sParam2, n2); //֧�ֱ���

  if (not (n1 in [0..13])) or (not (n2 in [0..5])) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sCHECKITEMSTATE);
    Exit;
  end;

  UserItem := @PlayObject.m_UseItems[n1];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    //PlayObject.SysMsg('������û�д�ָ����Ʒ������', c_Red, t_Hint);
    Exit;
  end;

  case n2 of //��Ŀ
    0: if UserItem.btValue[14] = 1 then Result := True;
    1: if UserItem.btValue[15] = 1 then Result := True;
    2: if UserItem.btValue[16] = 1 then Result := True;
    3: if UserItem.btValue[17] = 1 then Result := True;
    4: if UserItem.btValue[18] = 1 then Result := True;
    5: if UserItem.btValue[19] = 1 then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHECKITEMSTATE');
end;
end;
//-----------------------------------------------------------------------------
//���ܣ������������������������  20080427 �޸�
//��ʽ��ISHIGH ��Ŀ(L P D M S)
//��Ŀ: L--�ȼ�  P--PKֵ  D--������  M--ħ����  S--����
function TNormNpc.ConditionOfISHIGH(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  str:string;
begin
try
  Result := False;
  //str:=QuestConditionInfo.sParam1;//������Ŀ
  str:= GetLineVariableText(PlayObject,QuestConditionInfo.sParam1);//20080501
  if (Str ='') or (length(Str) > 2) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sISHIGH);
    Exit;
  end;
  if PlayObject.m_btPermission < 6 then begin //����Ȩ��С��6
    if CompareText(Str, 'L') = 0 then begin//���ȼ�
      if g_HighLevelHuman <> nil then begin
        if PlayObject.m_Abil.Level > TPlayObject(g_HighLevelHuman).m_Abil.Level then Result := True;
      end else Result := True;
    end else
    if CompareText(Str, 'P') = 0 then begin//���PKֵ
      if g_HighPKPointHuman <> nil then begin
        if PlayObject.m_nPkPoint > TPlayObject(g_HighPKPointHuman).m_nPkPoint then Result := True;
      end else Result := True;
    end else
    if CompareText(Str, 'D') = 0 then begin//��鹥����
      if g_HighDCHuman <> nil then begin
        if HiWord(PlayObject.m_WAbil.DC) > HiWord(TPlayObject(g_HighDCHuman).m_WAbil.DC) then Result := True;
      end else Result := True;
    end else
    if CompareText(Str, 'M') = 0 then begin//���ħ����
      if g_HighMCHuman <> nil then begin
        if HiWord(PlayObject.m_WAbil.MC) > HiWord(TPlayObject(g_HighMCHuman).m_WAbil.MC) then Result := True;
      end else Result := True;
    end else
    if CompareText(Str, 'S') = 0 then begin//������
      if g_HighSCHuman <> nil then begin
        if HiWord(PlayObject.m_WAbil.SC) > HiWord(TPlayObject(g_HighSCHuman).m_WAbil.SC) then Result := True;
      end else Result := True;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfISHIGH');
end;
end;
//-----------------------------------------------------------------------------
//���Ӣ��ְҵ 
function TNormNpc.ConditionOfCheckHeroJob(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  btJob: Byte;
begin
try
  Result := False;
  if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKHEROJOB);
    Exit;
  end;
  if PlayObject.m_MyHero <> nil then begin
    btJob := PlayObject.m_MyHero.m_btJob;
    if CompareLStr(QuestConditionInfo.sParam1, 'WARRIOR'{sWARRIOR}, 3) then begin
      Result := True;//20080423
      if btJob <> 0 then Result := False;
    end;
    if CompareLStr(QuestConditionInfo.sParam1, 'WIZARD'{sWIZARD}, 3) then begin
      Result := True;//20080423
      if btJob <> 1 then Result := False;
    end;
    if CompareLStr(QuestConditionInfo.sParam1, 'TAOIST'{sTAOS}, 3) then begin
      Result := True;//20080423
      if btJob <> 2 then Result := False;
    end;
    {if CompareLStr(QuestConditionInfo.sParam1, 'ASSASSIN', 3) then begin
      Result := True;
      if btJob <> 3 then Result := False;//�̿�
    end;}
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckHeroJob');
end;
end;
//����:����ɫ�Ƿ�ѧ���ڹ� 20081002
//��ʽ:CHANGREADNG Hero
function TNormNpc.ConditionOfCHANGREADNG(PlayObject: TPlayObject; QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if CompareText(QuestConditionInfo.sParam1, 'HERO') = 0 then begin
    if PlayObject.m_MyHero <> nil then begin
      if THeroObject(PlayObject.m_MyHero).m_boTrainingNG then Result := True;
    end;
  end else begin
    if PlayObject.m_boTrainingNG then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCHANGREADNG');
end;
end;

function TNormNpc.GetValValue(PlayObject: TPlayObject;
  sMsg: string; var nValue: Integer): Boolean;
var
  n01: Integer;
begin
try
  Result := False;
  if sMsg = '' then Exit;
  n01 := GetValNameNo(sMsg);
  if n01 >= 0 then begin
    case n01 of
      0..99: begin
          nValue := PlayObject.m_nVal[n01];
          Result := True;
        end;
      100..199: begin
          nValue := g_Config.GlobalVal[n01 - 100];
          Result := True;
        end;
      200..299: begin
          nValue := PlayObject.m_DyVal[n01 - 200];
          Result := True;
        end;
      300..399: begin
          nValue := PlayObject.m_nMval[n01 - 300];
          Result := True;
        end;
      400..499: begin
          nValue := g_Config.GlobaDyMval[n01 - 400];
          Result := True;
        end;
      500..599: begin
          nValue := PlayObject.m_nInteger[n01 - 500];
          Result := True;
        end;
      800..1199:begin//20080903 G����
          nValue := g_Config.GlobalVal[n01 - 700];
          Result := True;
        end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.GetValValue1');
end;
end;

function TNormNpc.GetValValue(PlayObject: TPlayObject;
  sMsg: string; var sValue: string): Boolean;
var
  n01: Integer;
begin
try
  Result := False;
  if sMsg = '' then Exit;
  n01 := GetValNameNo(sMsg);
  if n01 >= 0 then begin
    case n01 of
      600..699: begin
          sValue := PlayObject.m_sString[n01 - 600];
          Result := True;
        end;
      700..799: begin
          sValue := g_Config.GlobalAVal[n01 - 700];
          Result := True;
        end;
      1200..1599:begin//20080903 A����(100-499)
          sValue := g_Config.GlobalAVal[n01 - 1100];
          Result := True;
        end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.GetValValue2');
end;
end;

function TNormNpc.SetValValue(PlayObject: TPlayObject;
  sMsg: string; nValue: Integer): Boolean;
var
  n01: Integer;
begin
try
  Result := False;
  if sMsg = '' then Exit;
  n01 := GetValNameNo(sMsg);
  if n01 >= 0 then begin
    case n01 of
      0..99: begin
          PlayObject.m_nVal[n01] := nValue;
          Result := True;
        end;
      100..199: begin
          g_Config.GlobalVal[n01 - 100] := nValue;
          Result := True;
        end;
      200..299: begin
          PlayObject.m_DyVal[n01 - 200] := nValue;
          Result := True;
        end;
      300..399: begin
          PlayObject.m_nMval[n01 - 300] := nValue;
          Result := True;
        end;
      400..499: begin
          g_Config.GlobaDyMval[n01 - 400] := nValue;
          Result := True;
        end;
      500..599: begin
          PlayObject.m_nInteger[n01 - 500] := nValue;
          Result := True;
        end;
      800..1199:begin//20080903 G����
          g_Config.GlobalVal[n01 - 700] := nValue;
          Result := True;
        end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.SetValValue1');
end;
end;

function TNormNpc.SetValValue(PlayObject: TPlayObject;
  sMsg: string; sValue: string): Boolean;
var
  n01: Integer;
begin
try
  Result := False;
  if sMsg = '' then Exit;
  n01 := GetValNameNo(sMsg);
  if n01 >= 0 then begin
    case n01 of
      600..699: begin
          PlayObject.m_sString[n01 - 600] := sValue;
          Result := True;
        end;
      700..799: begin
          g_Config.GlobalAVal[n01 - 700] := sValue;
          Result := True;
        end;
      1200..1599:begin//20080903 A����(100-499)
          g_Config.GlobalAVal[n01 - 1100] := sValue;
          Result := True;
        end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.SetValValue2');
end;
end;

procedure TNormNpc.ActionOfAnsiReplaceText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sValue1: string;
  sValue2: string;
  sValue3: string;
  n01: Integer;
begin
try
  sValue1 := QuestActionInfo.sParam1;
  sValue2 := QuestActionInfo.sParam2;
  sValue3 := QuestActionInfo.sParam3;
  if (sValue1 = '') or (sValue2 = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ANSIREPLACETEXT);
    Exit;
  end;
  GetValValue(PlayObject, QuestActionInfo.sParam2, sValue2);
  GetValValue(PlayObject, QuestActionInfo.sParam3, sValue3);
  n01 := GetValNameNo(sValue1);
  if n01 >= 0 then begin
    case n01 of
      600..699: begin
          sValue1 := PlayObject.m_sString[n01 - 600];
          if AnsiContainsText(sValue1, sValue2) then
            PlayObject.m_sString[n01 - 600] := AnsiReplaceText(sValue1, sValue2, sValue3);
        end;
      700..799: begin
          sValue1 := g_Config.GlobalAVal[n01 - 700];
          if AnsiContainsText(sValue1, sValue2) then
            g_Config.GlobalAVal[n01 - 700] := AnsiReplaceText(sValue1, sValue2, sValue3);
        end;
      1200..1599:begin//20080903 A����(100-499)
          sValue1 := g_Config.GlobalAVal[n01 - 1100];
          if AnsiContainsText(sValue1, sValue2) then
            g_Config.GlobalAVal[n01 - 1100] := AnsiReplaceText(sValue1, sValue2, sValue3);
        end;
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ANSIREPLACETEXT);
      end;
    end;
  end else ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ANSIREPLACETEXT);
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfAnsiReplaceText');
end;
end;

procedure TNormNpc.ActionOfEncodeText(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  sNewValue: string;
  sValue1: string;
  sValue2: string;
  sValue3: string;
  sValue4: string;
  sValue5: string;
  sValue6: string;
  n01: Integer;
  function GetHumanInfoValue(sVariable: string; var sValue: string): Boolean;
  var
    sMsg, s10: string;
  begin
    Result := False;
    if sVariable = '' then Exit;
    sMsg := sVariable;
    ArrestStringEx(sMsg, '<', '>', s10);
    if s10 = '' then Exit;
    sVariable := s10;
    //������Ϣ
    if sVariable = '$USERNAME' then begin
      sValue := PlayObject.m_sCharName;
      Result := True;
      Exit;
    end;
    if sVariable = '$USERALLNAME' then begin//ȫ��  200080419
      sValue := PlayObject.GetShowName;
      Result := True;
      Exit;
    end;
    if sVariable = '$SFNAME' then begin//ʦ����  200080603
      sValue := PlayObject.m_sMasterName;
      Result := True;
      Exit;
    end;
    if sVariable = '$KILLER' then begin//ɱ���߱��� 20080826
      if PlayObject.m_boDeath and (PlayObject.m_LastHiter <> nil) then begin
        if (PlayObject.m_LastHiter.m_btRaceServer = RC_PLAYOBJECT) then begin
          sValue := PlayObject.m_LastHiter.m_sCharName;
        end else
        if (PlayObject.m_LastHiter.m_btRaceServer = RC_HEROOBJECT) then begin
           if PlayObject.m_LastHiter.m_Master <> nil then
             sValue := PlayObject.m_LastHiter.m_Master.m_sCharName
           else sValue := 'δ֪';
        end;
      end else sValue := 'δ֪';
      Result := True;
      Exit;
    end;
    if sVariable = '$MONKILLER' then begin//ɱ�˵Ĺ������ 20080826
      if PlayObject.m_boDeath and (PlayObject.m_LastHiter <> nil) then begin
        if (PlayObject.m_LastHiter.m_btRaceServer <> RC_PLAYOBJECT) and (PlayObject.m_LastHiter.m_btRaceServer <> RC_HEROOBJECT) then begin
          sValue := PlayObject.m_LastHiter.m_sCharName;
        end;
      end else sValue := 'δ֪';
      Result := True;
      Exit;
    end;
    if sVariable = '$MAP' then begin
      sValue := PlayObject.m_PEnvir.sMapName;
      Result := True;
      Exit;
    end;
    if sVariable = '$GUILDNAME' then begin//�л�����
      if PlayObject.m_MyGuild <> nil then begin
        sValue := TGUild(PlayObject.m_MyGuild).sGuildName;
      end else begin
        sValue := '';
      end;
      Result := True;
      Exit;
    end;
    if sVariable = '$RANKNAME' then begin
      sValue := PlayObject.m_sGuildRankName;
      Result := True;
      Exit;
    end;
    if sVariable = '$DRESS' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_DRESS].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$WEAPON' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$RIGHTHAND' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RIGHTHAND].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$HELMET' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HELMET].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$NECKLACE' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_NECKLACE].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$RING_R' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGR].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$RING_L' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGL].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$ARMRING_R' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$ARMRING_L' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$BUJUK' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BUJUK].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$BELT' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BELT].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$BOOTS' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BOOTS].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$CHARM' then begin
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CHARM].wIndex);
      Result := True;
      Exit;
    end else
    if sVariable = '$ZHULI' then begin //20080416 ����
      sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ZHULI].wIndex);
      Result := True;
      Exit;
    end else
      if sVariable = '$IPADDR' then begin
      sValue := PlayObject.m_sIPaddr;
      Result := True;
      Exit;
    end else
      if sVariable = '$IPLOCAL' then begin
      sValue := PlayObject.m_sIPLocal; // GetIPLocal(PlayObject.m_sIPaddr);
      Result := True;
      Exit;
    end;
  end;
  procedure SetEncodeText(sValName, sValue: string);
  begin
    n01 := GetValNameNo(sValName);
    if n01 >= 0 then begin
      case n01 of
        600..699: begin
            PlayObject.m_sString[n01 - 600] := sValue;
          end;
        700..799: begin
            g_Config.GlobalAVal[n01 - 700] := sValue;
          end;
        1200..1599:begin//20080903 A����(100-499)
            g_Config.GlobalAVal[n01 - 1100] := sValue;
          end;
      else begin
          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ENCODETEXT);
        end;
      end;
    end else ScriptActionError(PlayObject, '', QuestActionInfo, sSC_ENCODETEXT);
  end;
begin
try
  sValue1 := QuestActionInfo.sParam1;
  sValue2 := QuestActionInfo.sParam2;
  sValue3 := QuestActionInfo.sParam3;
  sValue4 := QuestActionInfo.sParam4;
  sValue5 := QuestActionInfo.sParam5;
  sValue6 := QuestActionInfo.sParam6;
  if (sValue2 <> '') and (sValue2[1] = '<') and (sValue2[Length(sValue2)] = '>') then begin
    GetHumanInfoValue(sValue2, sValue2);
  end else begin
    GetValValue(PlayObject, sValue2, sValue2);
  end;
  if (sValue3 <> '') and (sValue3[1] = '<') and (sValue3[Length(sValue3)] = '>') then begin
    GetHumanInfoValue(sValue3, sValue3);
  end else begin
    GetValValue(PlayObject, sValue3, sValue3);
  end;
  if (sValue4 <> '') and (sValue4[1] = '<') and (sValue4[Length(sValue4)] = '>') then begin
    GetHumanInfoValue(sValue4, sValue4);
  end else begin
    GetValValue(PlayObject, sValue4, sValue4);
  end;
  if (sValue5 <> '') and (sValue5[1] = '<') and (sValue5[Length(sValue5)] = '>') then begin
    GetHumanInfoValue(sValue5, sValue5);
  end else begin
    GetValValue(PlayObject, sValue5, sValue5);
  end;
  if (sValue6 <> '') and (sValue6[1] = '<') and (sValue6[Length(sValue6)] = '>') then begin
    GetHumanInfoValue(sValue6, sValue6);
  end else begin
    GetValValue(PlayObject, sValue6, sValue6);
  end;
  sNewValue := sValue2 + sValue3 + sValue4 + sValue5 + sValue6;
  SetEncodeText(sValue1, sNewValue);
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfEncodeText');
end;
end;

//������Ʒ
procedure TNormNpc.ActionOfTakeOnItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  I, nItemIdx: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  sItemName, sUserItemName: string;
  nWhere: Integer;
  boFound: Boolean;
begin
try
  sItemName := QuestActionInfo.sParam1;
  nWhere := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (sItemName = '') or (not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)])) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAKEONITEM);
    Exit;
  end;
  nItemIdx := -1;
  boFound := False;
  if CompareText(QuestActionInfo.sParam3, 'HERO') = 0 then begin//20080805
    if PlayObject.m_MyHero <> nil then begin
      if PlayObject.m_MyHero.m_ItemList.Count > 0 then begin //20080628
        for I := 0 to PlayObject.m_MyHero.m_ItemList.Count - 1 do begin
          UserItem := PlayObject.m_MyHero.m_ItemList.Items[I];
          if UserItem <> nil then begin
            //ȡ�Զ�����Ʒ����
            sUserItemName := '';
            if UserItem.btValue[13] = 1 then
              sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
            if sUserItemName = '' then
              sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem <> nil then begin
              if CompareText(sUserItemName, sItemName) = 0 then begin
                boFound := True;
                nItemIdx := UserItem.MakeIndex;
                Break;
              end;
            end;
          end;
        end;
      end;
      if (nItemIdx >= 0) and boFound then begin
        PlayObject.ClientHeroTakeOnItems(nWhere, nItemIdx, sItemName);
        THeroObject(PlayObject.m_MyHero).SendUseitems();//����ʹ�õ���Ʒ
        THeroObject(PlayObject.m_MyHero).ClientQueryBagItems;
      end;
    end;
  end else begin
    if PlayObject.m_ItemList.Count > 0 then begin //20080628
      for I := 0 to PlayObject.m_ItemList.Count - 1 do begin
        UserItem := PlayObject.m_ItemList.Items[I];
        if UserItem <> nil then begin
          //ȡ�Զ�����Ʒ����
          sUserItemName := '';
          if UserItem.btValue[13] = 1 then
            sUserItemName := ItemUnit.GetCustomItemName(UserItem.MakeIndex, UserItem.wIndex);
          if sUserItemName = '' then
            sUserItemName := UserEngine.GetStdItemName(UserItem.wIndex);
          StdItem := UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem <> nil then begin
            if CompareText(sUserItemName, sItemName) = 0 then begin
              boFound := True;
              nItemIdx := UserItem.MakeIndex;
              Break;
            end;
          end;
        end;
      end;
    end;
    if (nItemIdx >= 0) and boFound then begin
      PlayObject.ClientTakeOnItems(nWhere, nItemIdx, sItemName);
      PlayObject.SendUseitems();//����ʹ�õ���Ʒ 20080426
      PlayObject.ClientQueryBagItems;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfTakeOnItem');
end;
end;
//����װ��
procedure TNormNpc.ActionOfTakeOffItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nItemIdx: Integer;
  sItemName, sUserItemName: string;
  nWhere: Integer;
begin
try
  sItemName := QuestActionInfo.sParam1;
  nWhere := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (sItemName = '') or (not (nWhere in [Low(THumanUseItems)..High(THumanUseItems)])) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_TAKEONITEM);
    Exit;
  end;
  if CompareText(QuestActionInfo.sParam3, 'HERO') = 0 then begin//20080805
    if PlayObject.m_MyHero <> nil then begin
      if PlayObject.m_MyHero.m_UseItems[nWhere].wIndex > 0 then begin
        sUserItemName := '';
        if PlayObject.m_MyHero.m_UseItems[nWhere].btValue[13] = 1 then
          sUserItemName := ItemUnit.GetCustomItemName(PlayObject.m_MyHero.m_UseItems[nWhere].MakeIndex, PlayObject.m_MyHero.m_UseItems[nWhere].wIndex);
        if sUserItemName = '' then
          sUserItemName := UserEngine.GetStdItemName(PlayObject.m_MyHero.m_UseItems[nWhere].wIndex);
        if CompareText(sUserItemName, sItemName) = 0 then begin
          nItemIdx := PlayObject.m_MyHero.m_UseItems[nWhere].MakeIndex;
          PlayObject.ClientHeroTakeOffItems(nWhere, nItemIdx, sItemName);
          THeroObject(PlayObject.m_MyHero).SendUseitems();//����ʹ�õ���Ʒ
        end;
      end;
    end;
  end else begin
    if PlayObject.m_UseItems[nWhere].wIndex > 0 then begin
      sUserItemName := '';
      if PlayObject.m_UseItems[nWhere].btValue[13] = 1 then
        sUserItemName := ItemUnit.GetCustomItemName(PlayObject.m_UseItems[nWhere].MakeIndex, PlayObject.m_UseItems[nWhere].wIndex);
      if sUserItemName = '' then
        sUserItemName := UserEngine.GetStdItemName(PlayObject.m_UseItems[nWhere].wIndex);
      if CompareText(sUserItemName, sItemName) = 0 then begin
        nItemIdx := PlayObject.m_UseItems[nWhere].MakeIndex;
        PlayObject.ClientTakeOffItems(nWhere, nItemIdx, sItemName);
        PlayObject.SendUseitems();//����ʹ�õ���Ʒ
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfTakeOffItem');
end;
end;
//����Ӣ������
//��ʽ:CREATEHERO 2 1 TRUE ʹ�÷�����ԭ����һ����ֻ�Ǻ���Ӹ�����TRUE������Ϊ�����ڶ���Ӣ�� 20080514
procedure TNormNpc.ActionOfCreateHero(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nJob: Integer;
  nSex: Integer;
  nHair: Integer;
  sMsg, sAccount, sChrName, sHair, sJob, sSex, sLevel, sHeroType: string;
begin
try
  nJob := Str_ToInt(QuestActionInfo.sParam1, -1);//ְҵ
  nSex := Str_ToInt(QuestActionInfo.sParam2, -1);//�Ա�
  if (nJob < 0) or (nSex < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CREATEHERO);
    Exit;
  end;

  if CompareText(QuestActionInfo.sParam3, 'TRUE') = 0 then begin//��������Ӣ��
    if (Trim(PlayObject.m_sTempHeroCharName) <> '') and (not PlayObject.m_boHasHeroTwo) then begin
      case nSex of
        0: nHair := 2;
        1: begin
            case Random(2) of
              0: nHair := 1;
              1: nHair := 3;
            end;
          end;
      end;
      sAccount := PlayObject.m_sUserID;
      PlayObject.m_sHeroCharName:= Trim(PlayObject.m_sTempHeroCharName);
      sChrName := PlayObject.m_sHeroCharName;
      PlayObject.m_sTempHeroCharName:='';
      sHair := IntToStr(nHair);
      sJob := IntToStr(nJob);
      sSex := IntToStr(nSex);
      sLevel := IntToStr(g_Config.nDrinkHeroStartLevel);
      sHeroType:= IntToStr(1);//Ӣ������
      PlayObject.n_tempHeroTpye:= 1;//20080519
      sMsg := sAccount + '/' + sChrName + '/' + sHair + '/' + sJob + '/' + sSex + '/' + sLevel+'/'+PlayObject.m_sCharName+'/'+ sHeroType;//�������˵����� 20080408
      FrontEngine.AddToLoadHeroRcdList(sChrName, sMsg, PlayObject, 1);
    end else begin
      GotoLable(PlayObject, '@CreateHeroFailEx', False);
    end;
  end else begin//������Ӣ��
    if (Trim(PlayObject.m_sTempHeroCharName) <> '') and (not PlayObject.m_boHasHero) then begin
      case nSex of
        0: nHair := 2;
        1: begin
            case Random(2) of
              0: nHair := 1;
              1: nHair := 3;
            end;
          end;
      end;
      sAccount := PlayObject.m_sUserID;
      PlayObject.m_sHeroCharName:= Trim(PlayObject.m_sTempHeroCharName);
      sChrName := PlayObject.m_sHeroCharName;
      PlayObject.m_sTempHeroCharName:='';
      sHair := IntToStr(nHair);
      sJob := IntToStr(nJob);
      sSex := IntToStr(nSex);
      sLevel := IntToStr(g_Config.nHeroStartLevel);
      sHeroType:= IntToStr(0);//Ӣ������
      PlayObject.n_tempHeroTpye:= 0;//20080519
      sMsg := sAccount + '/' + sChrName + '/' + sHair + '/' + sJob + '/' + sSex + '/' + sLevel+'/'+PlayObject.m_sCharName+'/'+ sHeroType;//�������˵����� 20080408
      FrontEngine.AddToLoadHeroRcdList(sChrName, sMsg, PlayObject, 1);
    end else begin
      GotoLable(PlayObject, '@CreateHeroFailEx', False);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfCreateHero');
end;
end;
//ɾ��Ӣ�� ��Ӧ��NPC����ɾ����Ӧ��Ӣ��
procedure TNormNpc.ActionOfDeleteHero(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
begin
try
  if TMerchant(self).m_boBuHero then begin//����Ӣ��NPC
    if (PlayObject.m_boHasHeroTwo) and (PlayObject.n_myHeroTpye = 1) then begin
      if (PlayObject.m_MyHero <> nil) and (not PlayObject.m_MyHero.m_boDeath) then begin
        GotoLable(PlayObject, '@LogOutHeroFirst', False);
      end else begin
        FrontEngine.AddToLoadHeroRcdList(PlayObject.m_sHeroCharName, '', PlayObject, 2);
      end;
    end else begin
      GotoLable(PlayObject, '@NotHaveHero', False);
    end;
  end else begin//������Ӣ��NPC
    if (PlayObject.m_boHasHero) and (PlayObject.n_myHeroTpye = 0) then begin
      if (PlayObject.m_MyHero <> nil) and (not PlayObject.m_MyHero.m_boDeath) then begin
        GotoLable(PlayObject, '@LogOutHeroFirst', False);
      end else begin
        FrontEngine.AddToLoadHeroRcdList(PlayObject.m_sHeroCharName, '', PlayObject, 2);
      end;
    end else begin
      GotoLable(PlayObject, '@NotHaveHero', False);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfDeleteHero');
end;
end;
//�ı�Ӣ�۵ȼ�
procedure TNormNpc.ActionOfChangeHeroLevel(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  boChgOK: Boolean;
  nLevel: Integer;
  nLv: Integer;
  nOldLevel: Integer;
  cMethod: Char;
begin
try
  if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROLEVEL);
    Exit;
  end;
  if PlayObject.m_MyHero <> nil then begin
    boChgOK := False;
    nOldLevel := PlayObject.m_MyHero.m_Abil.Level;
    nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nLevel < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nLevel)) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROLEVEL);
      Exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=': begin
          if (nLevel > 0) and (nLevel <= MAXLEVEL) then begin
            PlayObject.m_MyHero.m_Abil.Level := nLevel;
            boChgOK := True;
          end;
        end;
      '-': begin
          nLv := _MAX(0, PlayObject.m_MyHero.m_Abil.Level - nLevel); //20080321 �޸�
          nLv := _MIN(MAXLEVEL, nLv);
          PlayObject.m_MyHero.m_Abil.Level := nLv;
          boChgOK := True;
        end;
      '+': begin
          nLv := _MAX(0, PlayObject.m_MyHero.m_Abil.Level + nLevel);//20080321 �޸�
          nLv := _MIN(MAXLEVEL, nLv);
          PlayObject.m_MyHero.m_Abil.Level := nLv;
          boChgOK := True;
        end;
    end;
    if boChgOK then begin
      PlayObject.m_MyHero.HasLevelUp(nOldLevel);
      AddGameDataLog('17' + #9 + PlayObject.m_MyHero.m_sMapName + #9 + //�ȼ�������¼��־ 20080911
        IntToStr(PlayObject.m_MyHero.m_nCurrX) + #9 +
        IntToStr(PlayObject.m_MyHero.m_nCurrY)+ #9 +
        PlayObject.m_MyHero.m_sCharName + #9 +
        IntToStr(PlayObject.m_MyHero.m_Abil.Level) + #9 +
        '1' + #9 +
        cMethod+'('+IntToStr(nLv)+')' + #9 +
        m_sCharName);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfChangeHeroLevel');
end;
end;
//�ı�Ӣ��ְҵ
procedure TNormNpc.ActionOfChangeHeroJob(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nJob: Integer;
begin
try
  if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROJOB);
    Exit;
  end;
  nJob := -1;
  if CompareLStr(QuestActionInfo.sParam1, 'WARRIOR'{sWARRIOR}, 3) then nJob := 0;
  if CompareLStr(QuestActionInfo.sParam1, 'WIZARD'{sWIZARD}, 3) then nJob := 1;
  if CompareLStr(QuestActionInfo.sParam1, 'TAOIST'{sTAOS}, 3) then nJob := 2;
  //if CompareLStr(QuestActionInfo.sParam1, 'ASSASSIN', 3) then nJob := 3;//�̿�

  if nJob < 0 then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROJOB);
    Exit;
  end;
  if PlayObject.m_MyHero <> nil then begin
    if PlayObject.m_MyHero.m_btJob <> nJob then begin
      PlayObject.m_MyHero.m_btJob := nJob;
      PlayObject.m_MyHero.HasLevelUp(0);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfChangeHeroJob');
end;
end;

//���Ӣ�ۼ��� 20080107
procedure TNormNpc.ActionOfClearHeroSkill(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  UserMagic: pTUserMagic;
begin
try
  if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARHEROSKILL);
    Exit;
  end;
  if PlayObject.m_MyHero <> nil then begin
     if QuestActionInfo.sParam1 <> '' then begin//ָ����������,��ɾ��ָ���ļ���
       for I := PlayObject.m_MyHero.m_MagicList.Count - 1 downto 0 do begin//20080916 �޸�
         if PlayObject.m_MyHero.m_MagicList.Count <=0 then Break;//20080916
         UserMagic:= PlayObject.m_MyHero.m_MagicList.Items[i];
          if UserMagic <> nil then begin
            if  CompareText(UserMagic.MagicInfo.sMagicName, QuestActionInfo.sParam1) = 0  then begin
              THeroObject(PlayObject.m_MyHero).SendDelMagic(UserMagic);
              Dispose(UserMagic);
              PlayObject.m_MyHero.m_MagicList.Delete(I);
              break;
            end;
          end;
        end;//for
     end else begin //û��ָ����������,��ɾ��ȫ������
       for I := PlayObject.m_MyHero.m_MagicList.Count - 1 downto 0 do begin
         if PlayObject.m_MyHero.m_MagicList.Count <=0 then Break;//20080916
         UserMagic := PlayObject.m_MyHero.m_MagicList.Items[I];
         THeroObject(PlayObject.m_MyHero).SendDelMagic(UserMagic);
         Dispose(UserMagic);
         PlayObject.m_MyHero.m_MagicList.Delete(I);
       end;//for
     end;
    THeroObject(PlayObject.m_MyHero).RecalcAbilitys();//20081213
    PlayObject.m_MyHero.CompareSuitItem(False);//200080729 ��װ
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfClearHeroSkill');
end;
end;

procedure TNormNpc.ActionOfChangeHeroPKPoint(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nPKPOINT: Integer;
  nPoint: Integer;
  nOldPKLevel: Integer;
  cMethod: Char;
begin
try
  if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROPKPOINT);
    Exit;
  end;
  if PlayObject.m_MyHero <> nil then begin
    nOldPKLevel := PlayObject.m_MyHero.PKLevel;
    nPKPOINT := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nPKPOINT < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nPKPOINT)) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROPKPOINT);
      Exit;
    end;
    cMethod := QuestActionInfo.sParam1[1];
    case cMethod of
      '=': begin
          if (nPKPOINT >= 0) then begin
            PlayObject.m_MyHero.m_nPkPoint := nPKPOINT;
          end;
        end;
      '-': begin
          nPoint := _MAX(0, PlayObject.m_MyHero.m_nPkPoint - nPKPOINT);
          PlayObject.m_MyHero.m_nPkPoint := nPoint;
        end;
      '+': begin
          nPoint := _MAX(0, PlayObject.m_MyHero.m_nPkPoint + nPKPOINT);
          PlayObject.m_MyHero.m_nPkPoint := nPoint;
        end;
    end;
    if nOldPKLevel <> PlayObject.m_MyHero.PKLevel then
      PlayObject.m_MyHero.RefNameColor;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfChangeHeroPKPoint');
end;
end;

//�����ʽ:GIVEMINE ������ ���� ����
//�紿�Ȳ���,�����������
procedure TNormNpc.ActionOfGIVEMINE(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);//����ʯ 20080330
var
  sMineName: String;
  nMineCount, nDura, I: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
try
  sMineName := QuestActionInfo.sParam1;//����
  nMineCount := Str_ToInt(QuestActionInfo.sParam2, -1);//����
  nDura:= Str_ToInt(QuestActionInfo.sParam3, -1);//����
  if (nMineCount <= 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nMineCount)) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GIVEMINE);
    Exit;
  end;
  if nDura < 0 then nDura:=Random(18)+ 3;
  if (sMineName='') or (nMineCount < 0) or (nDura < 0) or (nDura > 100) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GIVEMINE);
    Exit;
  end;

  if nMineCount > 0 then begin//20080629
    for I := 0 to nMineCount - 1 do begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sMineName, UserItem) then begin
         StdItem := UserEngine.GetStdItem(UserItem.wIndex);
         if (StdItem <> nil) then begin//20090203
           if (StdItem.StdMode = 43) then begin
             if IsAddWeightAvailable(StdItem.Weight * nMineCount) then begin
               UserItem.Dura:= nDura * 1000;
               if UserItem.Dura > UserItem.DuraMax then UserItem.Dura:= UserItem.DuraMax;
               if StdItem.NeedIdentify = 1 then//��¼��Ϸ��־
                 AddGameDataLog('39' + #9 +m_sMapName + #9 + IntToStr(m_nCurrX) + #9 +
                    IntToStr(m_nCurrY) + #9 + PlayObject.m_sCharName + #9 +StdItem.Name + #9 +
                    IntToStr(UserItem.MakeIndex) + #9 +IntToStr(UserItem.Dura)+'/'+inttostr(Useritem.DuraMax) + #9 + m_sCharName);

               PlayObject.m_ItemList.Add(UserItem);
               PlayObject.SendAddItem(UserItem);
             end;
           end;
         end;
       end else begin
         Dispose(UserItem);
         Break;
       end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGIVEMINE');
end;
end;
//�ı�Ӣ�۵ľ���
procedure TNormNpc.ActionOfChangeHeroExp(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  boChgOK: Boolean;
  nExp: Integer;
  cMethod: Char;
  dwInt: LongWord;
begin
  try
    if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROEXP);
      Exit;
    end;
    boChgOK := False;
    nExp := Str_ToInt(QuestActionInfo.sParam2, -1);
    if (nExp < 0) and (not GetValValue(PlayObject, QuestActionInfo.sParam2, nExp)) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEHEROEXP);
      Exit;
    end;
    if PlayObject.m_MyHero <> nil then begin
      cMethod := QuestActionInfo.sParam1[1];
      case cMethod of
        '=': begin
            if nExp >= 0 then begin
              PlayObject.m_MyHero.m_Abil.Exp := LongWord(nExp);
              dwInt := LongWord(nExp);
            end;
          end;
        '-': begin
            if PlayObject.m_MyHero.m_Abil.Exp > LongWord(nExp) then begin
              Dec(PlayObject.m_MyHero.m_Abil.Exp, LongWord(nExp));
            end else begin
              PlayObject.m_MyHero.m_Abil.Exp := 0;
            end;
          end;
        '+': begin
            if PlayObject.m_MyHero.m_Abil.Level < g_Config.nLimitExpLevel then begin//�Ƿ񳬹����Ƶȼ� //20090131 �޸�
              dwInt := LongWord(nExp);
              {if PlayObject.m_MyHero.m_Abil.Exp >= LongWord(nExp) then begin
                if (High(LongWord) - PlayObject.m_MyHero.m_Abil.Exp) < LongWord(nExp) then begin
                  dwInt := High(LongWord) - PlayObject.m_MyHero.m_Abil.Exp;
                end;
              end else begin
                 if (High(LongWord) - LongWord(nExp)) < PlayObject.m_MyHero.m_Abil.Exp then begin
                  dwInt := High(LongWord) - LongWord(nExp);
                 end;
              end;}
            end else dwInt := g_Config.nLimitExpValue;
            THeroObject(PlayObject.m_MyHero).GetExp(dwInt);

            {if PlayObject.m_MyHero.m_Abil.Exp >= LongWord(nExp) then begin
              if (PlayObject.m_MyHero.m_Abil.Exp - LongWord(nExp)) > (High(LongWord) - PlayObject.m_MyHero.m_Abil.Exp) then begin
                dwInt := High(LongWord) - PlayObject.m_MyHero.m_Abil.Exp;
              end else begin
                dwInt := LongWord(nExp);
              end;
            end else begin
              if (LongWord(nExp) - PlayObject.m_MyHero.m_Abil.Exp) > (High(LongWord) - LongWord(nExp)) then begin
                dwInt := High(LongWord) - LongWord(nExp);
              end else begin
                dwInt := LongWord(nExp);
              end;
            end;
            Inc(PlayObject.m_MyHero.m_Abil.Exp, dwInt);

            PlayObject.GetExp(dwInt);
            PlayObject.m_MyHero.SendMsg(PlayObject.m_MyHero, RM_HEROWINEXP, 0, dwInt, 0, 0, '');  }
          end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfChangeHeroExp');
  end;
end;

procedure TNormNpc.ActionOfRepairItem(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nWhere: Integer;
  StdItem: pTStdItem;
  //sCheckItemName: string;
begin
  try
    if Str_ToInt(QuestActionInfo.sParam1, -1) >= 0 then begin
      nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
      if (nWhere in [Low(THumanUseItems)..High(THumanUseItems)]) then begin
        if PlayObject.m_UseItems[nWhere].wIndex > 0 then begin
          StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nWhere].wIndex);
          if StdItem <> nil then begin
            if (PlayObject.m_UseItems[nWhere].DuraMax > PlayObject.m_UseItems[nWhere].Dura) and (StdItem.StdMode <> 43) then begin
              if CheckItemValue(@PlayObject.m_UseItems[nWhere], 3) then begin
                Exit; //20080314 ��ֹ��
              end else
             { if Assigned(zPlugOfEngine.CheckCanRepairItem) then begin
                sCheckItemName := StdItem.Name;
                if not zPlugOfEngine.CheckCanRepairItem(PlayObject, PChar(sCheckItemName)) then Exit;
              end;}
              if PlayObject.PlugOfCheckCanItem(3, StdItem.Name, False, 0, 0) then Exit;//��ֹ��Ʒ����(����������) 20080729

              PlayObject.m_UseItems[nWhere].Dura := PlayObject.m_UseItems[nWhere].DuraMax;
              PlayObject.SendMsg(PlayObject, RM_DURACHANGE, nWhere, PlayObject.m_UseItems[nWhere].Dura, PlayObject.m_UseItems[nWhere].DuraMax, 0, '');
            end;
          end;
        end;
      end else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_REPAIRITEM);
      end;
    end else
      if Str_ToInt(QuestActionInfo.sParam1, -1) < 0 then begin
      for nWhere := Low(THumanUseItems) to High(THumanUseItems) do begin
        if PlayObject.m_UseItems[nWhere].wIndex > 0 then begin
          StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nWhere].wIndex);
          if StdItem <> nil then begin
            if (PlayObject.m_UseItems[nWhere].DuraMax > PlayObject.m_UseItems[nWhere].Dura) and (StdItem.StdMode <> 43) then begin
              if CheckItemValue(@PlayObject.m_UseItems[nWhere], 3) then Continue //20080314 ��ֹ��
              else
              {if Assigned(zPlugOfEngine.CheckCanRepairItem) then begin
                sCheckItemName := StdItem.Name;
                if not zPlugOfEngine.CheckCanRepairItem(PlayObject, PChar(sCheckItemName)) then Continue;
              end; }
              if PlayObject.PlugOfCheckCanItem(3, StdItem.Name, False, 0, 0) then Continue;//��ֹ��Ʒ����(����������) 20080729

              PlayObject.m_UseItems[nWhere].Dura := PlayObject.m_UseItems[nWhere].DuraMax;
              PlayObject.SendMsg(PlayObject, RM_DURACHANGE, nWhere, PlayObject.m_UseItems[nWhere].Dura, PlayObject.m_UseItems[nWhere].DuraMax, 0, '');
            end;
          end;
        end;
      end;
    end else begin
      //ScriptActionError(PlayObject, '', QuestActionInfo, sSC_REPAIRITEM);
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfRepairItem');
  end;
end;

constructor TNormNpc.Create;
begin
  inherited;
  m_boSuperMan := True;
  m_btRaceServer := RC_NPC;
  m_nLight := 2;
  m_btAntiPoison := 99;
  m_ScriptList := TList.Create;
  m_boStickMode := True;
  m_sFilePath := '';
  m_boIsHide := False;
  m_boIsQuest := True;
  m_boNpcAutoChangeColor := False;
  m_dwNpcAutoChangeColorTick := GetTickCount;
  m_dwNpcAutoChangeColorTime := 0;
  m_nNpcAutoChangeIdx := 0;
  m_boGotoCount := 0;//ִ��Goto�Ĵ��� 20080927
end;

destructor TNormNpc.Destroy;
//var
//  I: Integer;
begin
  ClearScript();
  { for I := 0 to ScriptList.Count - 1 do begin
    Dispose(pTScript(ScriptList.Items[I]));
  end; }
  m_ScriptList.Free;
  inherited;
end;

procedure TNormNpc.ExeAction(PlayObject: TPlayObject; sParam1, sParam2,
  sParam3: string; nParam1, nParam2, nParam3: Integer);
var
  nInt1: Integer;
  dwInt: LongWord;
begin
try
  //================================================
  //�������ﵱǰ����ֵ
  //EXEACTION CHANGEEXP 0 ������  ����Ϊָ������ֵ
  //EXEACTION CHANGEEXP 1 ������  ����ָ������
  //EXEACTION CHANGEEXP 2 ������  ����ָ������
  //================================================
  if CompareText(sParam1, 'CHANGEEXP') = 0 then begin
    nInt1 := Str_ToInt(sParam2, -1);
    case nInt1 of //
      0: begin
          if nParam3 >= 0 then begin
            PlayObject.m_Abil.Exp := LongWord(nParam3);
            PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
          end;
        end;
      1: begin
          if PlayObject.m_Abil.Exp >= LongWord(nParam3) then begin
            if (PlayObject.m_Abil.Exp - LongWord(nParam3)) > (High(LongWord) - PlayObject.m_Abil.Exp) then begin
              dwInt := High(LongWord) - PlayObject.m_Abil.Exp;
            end else begin
              dwInt := LongWord(nParam3);
            end;
          end else begin
            if (LongWord(nParam3) - PlayObject.m_Abil.Exp) > (High(LongWord) - LongWord(nParam3)) then begin
              dwInt := High(LongWord) - LongWord(nParam3);
            end else begin
              dwInt := LongWord(nParam3);
            end;
          end;
          Inc(PlayObject.m_Abil.Exp, dwInt);
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
        end;
      2: begin
          if PlayObject.m_Abil.Exp > LongWord(nParam3) then begin
            Dec(PlayObject.m_Abil.Exp, LongWord(nParam3));
          end else begin
            PlayObject.m_Abil.Exp := 0;
          end;
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
        end;
    end;
    PlayObject.SysMsg('����ǰ�������Ϊ: ' + IntToStr(PlayObject.m_Abil.Exp) + '/' + IntToStr(PlayObject.m_Abil.MaxExp), c_Green, t_Hint);
    Exit;
  end;

  //================================================
  //�������ﵱǰ�ȼ�
  //EXEACTION CHANGELEVEL 0 �ȼ���  ����Ϊָ���ȼ�
  //EXEACTION CHANGELEVEL 1 �ȼ���  ����ָ���ȼ�
  //EXEACTION CHANGELEVEL 2 �ȼ���  ����ָ���ȼ�
  //================================================
  if CompareText(sParam1, 'CHANGELEVEL') = 0 then begin
    nInt1 := Str_ToInt(sParam2, -1);
    case nInt1 of //
      0: begin
          if nParam3 >= 0 then begin
            PlayObject.m_Abil.Level := LongWord(nParam3);
            PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
            AddGameDataLog('17' + #9 + PlayObject.m_sMapName + #9 + //�ȼ�������¼��־ 20080911
              IntToStr(PlayObject.m_nCurrX) + #9 +
              IntToStr(PlayObject.m_nCurrY)+ #9 +
              PlayObject.m_sCharName + #9 +
              IntToStr(PlayObject.m_Abil.Level) + #9 +
              '0' + #9 +
              '=('+IntToStr(LongWord(nParam3))+')' + #9 +
              m_sCharName);
          end;
        end;
      1: begin
          if PlayObject.m_Abil.Level >= LongWord(nParam3) then begin
            if (PlayObject.m_Abil.Level - LongWord(nParam3)) > (High(Word) - PlayObject.m_Abil.Level) then begin
              dwInt := High(Word) - PlayObject.m_Abil.Level;
            end else begin
              dwInt := LongWord(nParam3);
            end;
          end else begin
            if (LongWord(nParam3) - PlayObject.m_Abil.Level) > (High(Word) - LongWord(nParam3)) then begin
              dwInt := High(LongWord) - LongWord(nParam3);
            end else begin
              dwInt := LongWord(nParam3);
            end;
          end;
          Inc(PlayObject.m_Abil.Level, dwInt);
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
          AddGameDataLog('17' + #9 + PlayObject.m_sMapName + #9 + //�ȼ�������¼��־ 20080911
            IntToStr(PlayObject.m_nCurrX) + #9 +
            IntToStr(PlayObject.m_nCurrY)+ #9 +
            PlayObject.m_sCharName + #9 +
            IntToStr(PlayObject.m_Abil.Level) + #9 +
            '0' + #9 +
            '+('+IntToStr(dwInt)+')' + #9 +
            m_sCharName);
        end;
      2: begin
          if PlayObject.m_Abil.Level > LongWord(nParam3) then begin
            Dec(PlayObject.m_Abil.Level, LongWord(nParam3));
          end else begin
            PlayObject.m_Abil.Level := 0;
          end;
          PlayObject.HasLevelUp(PlayObject.m_Abil.Level - 1);
          AddGameDataLog('17' + #9 + PlayObject.m_sMapName + #9 + //�ȼ�������¼��־ 20080911
            IntToStr(PlayObject.m_nCurrX) + #9 +
            IntToStr(PlayObject.m_nCurrY)+ #9 +
            PlayObject.m_sCharName + #9 +
            IntToStr(PlayObject.m_Abil.Level) + #9 +
            '0' + #9 +
            '-('+IntToStr(LongWord(nParam3))+')' + #9 +
            m_sCharName);
        end;
    end;
    PlayObject.SysMsg('����ǰ�ȼ�Ϊ: ' + IntToStr(PlayObject.m_Abil.Level), c_Green, t_Hint);
    Exit;
  end;

  //================================================
  //ɱ������
  //EXEACTION KILL 0 ��������,����ʾ������Ϣ
  //EXEACTION KILL 1 ��������������Ʒ,����ʾ������Ϣ
  //EXEACTION KILL 2 ��������,��ʾ������ϢΪNPC
  //EXEACTION KILL 3 ��������������Ʒ,��ʾ������ϢΪNPC
  //================================================
  if CompareText(sParam1, 'KILL') = 0 then begin
    nInt1 := Str_ToInt(sParam2, -1);
    case nInt1 of //
      1: begin
          PlayObject.m_boNoItem := True;
          PlayObject.Die;
        end;
      2: begin
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
      3: begin
          PlayObject.m_boNoItem := True;
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
    else begin
        PlayObject.Die;
      end;
    end;
    Exit;
  end;

  //================================================
  //����������
  //EXEACTION KICK
  //================================================
  if CompareText(sParam1, 'KICK') = 0 then begin
    PlayObject.m_boKickFlag := True;
    Exit;
  end;
  //==============================================================================
except
  MainOutMessage('{�쳣} TNormNpc.ExeAction');
end;
end;

function TNormNpc.GetLineVariableText(PlayObject: TPlayObject; sMsg: string): string;
var
  nC: Integer;
  s10: string;
begin
try
  nC := 0;
  while (True) do begin
    if TagCount(sMsg, '>') < 1 then Break;
    ArrestStringEx(sMsg, '<', '>', s10);
    GetVariableText(PlayObject, sMsg, s10);
    Inc(nC);
    if nC >= 101 then Break;
  end;
  Result := sMsg;
except
  MainOutMessage('{�쳣} TNormNpc.GetLineVariableText');
end;
end;
//ȡ�����ı�
procedure TNormNpc.GetVariableText(PlayObject: TPlayObject; var sMsg: string; sVariable: string);
var
  sText, s14: string;
  I{, II}: Integer;
  n18{, n20}: Integer;
  wHour: Word;
  wMinute: Word;
  wSecond: Word;
  nSecond: Integer;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;

//  nSellGold: Integer;
//  nRate: Integer;
  s1C: string;
//  SellOffInfo: pTSellOffInfo;
//  Merchant: TMerchant;
//  List20: TList;
  PoseHuman: TPlayObject;
begin
try
  //��ʾ��������
  if sVariable = '$LEVELORDER' then begin
    s1C := '';
    if PlayObject.m_PlayOrderList.Count > 0 then begin
      for I := 0 to PlayObject.m_PlayOrderList.Count - 1 do begin
        s1C := s1C + PlayObject.m_PlayOrderList.Strings[I];
      end;
    end;
    sMsg := sub_49ADB8(sMsg, '<$LEVELORDER>', s1C);
    Exit;
  end;

 { //��ʾ������  //20080416 ȥ����������
  if sVariable = '$SELLOUTGOLD' then begin
    s1C := '';
    n18 := 0;
    List20 := TList.Create;
    g_SellOffGoldList.GetUserSellOffGoldListByChrName(PlayObject.m_sCharName, List20);
    for I := 0 to List20.Count - 1 do begin
      if List20.Count <= 0 then Break;
      SellOffInfo := pTSellOffInfo(List20.Items[I]);
      if g_Config.nUserSellOffTax > 0 then begin
        nRate := SellOffInfo.nSellGold * g_Config.nUserSellOffTax div 100;
        nSellGold := SellOffInfo.nSellGold - nRate;
      end else begin
        nSellGold := SellOffInfo.nSellGold;
        nRate := 0;
      end;
      s1C := s1C + '<��Ʒ:' + UserEngine.GetStdItemName(SellOffInfo.UseItems.wIndex) + ' ���:' + IntToStr(nSellGold) + ' ˰:' + IntToStr(nRate) + g_Config.sGameGoldName + ' ��������:' + DateTimeToStr(SellOffInfo.dSellDateTime) + '>\';
      Inc(n18);
      if n18 >= 7 then Break;
    end;
    if s1C = '' then s1C := g_sSellOffGoldInfo;
    sMsg := sub_49ADB8(sMsg, '<$SELLOUTGOLD>', s1C);
    List20.Free;
    Exit;
  end; }
 (*//��ʾ������Ʒ    //20080416 ȥ����������
  if sVariable = '$SELLOFFITEM' then begin
    s1C := '';
    n18 := 0;
    List20 := TList.Create;
    g_SellOffGoodList.GetUserSellOffGoodListByChrName(PlayObject.m_sCharName, List20);
    for I := 0 to List20.Count - 1 do begin
      if List20.Count <= 0 then Break;
      SellOffInfo := pTSellOffInfo(List20.Items[II]);
      s1C := s1C + '<��Ʒ:' + UserEngine.GetStdItemName(SellOffInfo.UseItems.wIndex) + ' ���:' + IntToStr(SellOffInfo.nSellGold) + g_Config.sGameGoldName + ' ��������:' + DateTimeToStr(SellOffInfo.dSellDateTime) + '>\';
      Inc(n18);
      if n18 >= 7 then Break;
      //n20:=n18 div 7;
      {if n20 >= 1 then begin
        n18:=0;
        s1C := s1C + '<��һҳ/@SELLOFFITEM'+IntToStr(n20)+'>\[@SELLOFFITEM'+IntToStr(n20)+']';
      end;}
    end;
    if s1C = '' then s1C := g_sSellOffItemInfo;
    sMsg := sub_49ADB8(sMsg, '<$SELLOFFITEM>', s1C);
    List20.Free;
    Exit;
  end; *)
  if sVariable = '$DEALGOLDPLAY' then begin
    PoseHuman := TPlayObject(PlayObject.GetPoseCreate());
    if (PoseHuman <> nil) and (TPlayObject(PoseHuman.GetPoseCreate) = PlayObject) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
      sMsg := sub_49ADB8(sMsg, '<$DEALGOLDPLAY>', PoseHuman.m_sCharName);
    end else begin
      sMsg := sub_49ADB8(sMsg, '<$DEALGOLDPLAY>', '????');
    end;
    Exit;
  end;
  //ȫ����Ϣ
  if sVariable = '$SERVERNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$SERVERNAME>', g_Config.sServerName);
    Exit;
  end;
  if sVariable = '$SERVERIP' then begin
    sMsg := sub_49ADB8(sMsg, '<$SERVERIP>', g_Config.sServerIPaddr);
    Exit;
  end;
  if sVariable = '$WEBSITE' then begin
    sMsg := sub_49ADB8(sMsg, '<$WEBSITE>', g_Config.sWebSite);
    Exit;
  end;
  if sVariable = '$BBSSITE' then begin
    sMsg := sub_49ADB8(sMsg, '<$BBSSITE>', g_Config.sBbsSite);
    Exit;
  end;
  if sVariable = '$CLIENTDOWNLOAD' then begin
    sMsg := sub_49ADB8(sMsg, '<$CLIENTDOWNLOAD>', g_Config.sClientDownload);
    Exit;
  end;
  if sVariable = '$QQ' then begin
    sMsg := sub_49ADB8(sMsg, '<$QQ>', g_Config.sQQ);
    Exit;
  end;
  if sVariable = '$PHONE' then begin
    sMsg := sub_49ADB8(sMsg, '<$PHONE>', g_Config.sPhone);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT0' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT0>', g_Config.sBankAccount0);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT1' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT1>', g_Config.sBankAccount1);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT2' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT2>', g_Config.sBankAccount2);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT3' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT3>', g_Config.sBankAccount3);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT4' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT4>', g_Config.sBankAccount4);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT5' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT5>', g_Config.sBankAccount5);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT6' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT6>', g_Config.sBankAccount6);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT7' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT7>', g_Config.sBankAccount7);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT8' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT8>', g_Config.sBankAccount8);
    Exit;
  end;
  if sVariable = '$BANKACCOUNT9' then begin
    sMsg := sub_49ADB8(sMsg, '<$BANKACCOUNT9>', g_Config.sBankAccount9);
    Exit;
  end;
  if sVariable = '$GAMEGOLDNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$GAMEGOLDNAME>', g_Config.sGameGoldName);
    Exit;
  end;
  if sVariable = '$GAMEDIAMONDNAME' then begin  //20071227 ���ʯ
    sMsg := sub_49ADB8(sMsg, '<$GAMEDIAMONDNAME>', g_Config.sGameDiaMond);
    Exit;
  end;
  if sVariable = '$GAMEGIRDNAME' then begin  //20071227 ���
    sMsg := sub_49ADB8(sMsg, '<$GAMEGIRDNAME>', g_Config.sGameGird);
    Exit;
  end;
  if sVariable = '$GAMEPOINTNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$GAMEPOINTNAME>', g_Config.sGamePointName);
    Exit;
  end;
  if sVariable = '$USERCOUNT' then begin
    sText := IntToStr(UserEngine.PlayObjectCount);
    sMsg := sub_49ADB8(sMsg, '<$USERCOUNT>', sText);
    Exit;
  end;
  if sVariable = '$MACRUNTIME' then begin
    sText := CurrToStr(GetTickCount / 86400000{(24 * 60 * 60 * 1000)});
    sMsg := sub_49ADB8(sMsg, '<$MACRUNTIME>', sText);
    Exit;
  end;
  if sVariable = '$SERVERRUNTIME' then begin
    nSecond := (GetTickCount() - g_dwStartTick) div 1000;
    wHour := nSecond div 3600;
    wMinute := (nSecond div 60) mod 60;
    wSecond := nSecond mod 60;
    sText := Format('%d:%d:%d', [wHour, wMinute, wSecond]);
    sMsg := sub_49ADB8(sMsg, '<$SERVERRUNTIME>', sText);
    Exit;
  end;
  if sVariable = '$DATETIME' then begin
    //sText := FormatDateTime('dddddd,dddd,hh:mm:nn', Now);
    sText := FormatDateTime('dddddd,ddd,hh:mm:nn', Now);//20090204 �޸�
    sMsg := sub_49ADB8(sMsg, '<$DATETIME>', sText);
    Exit;
  end;

  if sVariable = '$HIGHLEVELINFO' then begin //��ߵȼ���������
    if TPlayObject(g_HighLevelHuman) <> nil then begin
      sText := TPlayObject(g_HighLevelHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHLEVELINFO>', sText);
    Exit;
  end;
  if sVariable = '$HIGHPKINFO' then begin //���PKֵ��������
    if TPlayObject(g_HighPKPointHuman) <> nil then begin
      sText := TPlayObject(g_HighPKPointHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHPKINFO>', sText);
    Exit;
  end;
  if sVariable = '$HIGHDCINFO' then begin //��߹�������������
    if TPlayObject(g_HighDCHuman) <> nil then begin
      sText := TPlayObject(g_HighDCHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHDCINFO>', sText);
    Exit;
  end;
  if sVariable = '$HIGHMCINFO' then begin //���ħ������������
    if TPlayObject(g_HighMCHuman) <> nil then begin
      sText := TPlayObject(g_HighMCHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHMCINFO>', sText);
    Exit;
  end;
  if sVariable = '$HIGHSCINFO' then begin  //��ߵ�����������
    if TPlayObject(g_HighSCHuman) <> nil then begin
      sText := TPlayObject(g_HighSCHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHSCINFO>', sText);
    Exit;
  end;
  if sVariable = '$HIGHONLINEINFO' then begin//�������ʱ����������
    if TPlayObject(g_HighOnlineHuman) <> nil then begin
      sText := TPlayObject(g_HighOnlineHuman).GetMyInfo;
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HIGHONLINEINFO>', sText);
    Exit;
  end;

  //������Ϣ
  if sVariable = '$USERNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$USERNAME>', PlayObject.m_sCharName);
    Exit;
  end;
  if sVariable = '$USERALLNAME' then begin//ȫ�� 20080419
    sMsg := sub_49ADB8(sMsg, '<$USERALLNAME>', PlayObject.GetShowName);
    Exit;
  end;
  if sVariable = '$SFNAME' then begin//ʦ���� 20080603
    sMsg := sub_49ADB8(sMsg, '<$SFNAME>', PlayObject.m_sMasterName);
    Exit;
  end;
  if sVariable = '$MAPNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$MAPNAME>', PlayObject.m_PEnvir.sMapDesc);
    Exit;
  end;
  if sVariable = '$KILLER' then begin//ɱ���߱��� 20080826
    if PlayObject.m_boDeath and (PlayObject.m_LastHiter <> nil) then begin
      if (PlayObject.m_LastHiter.m_btRaceServer = RC_PLAYOBJECT) then begin
        sMsg := sub_49ADB8(sMsg, '<$KILLER>', PlayObject.m_LastHiter.m_sCharName);
      end else
      if (PlayObject.m_LastHiter.m_btRaceServer = RC_HEROOBJECT) then begin
        if PlayObject.m_LastHiter.m_Master <> nil then
          sMsg := sub_49ADB8(sMsg, '<$KILLER>', PlayObject.m_LastHiter.m_Master.m_sCharName)
        else sMsg := sub_49ADB8(sMsg, '<$KILLER>', 'δ֪');
      end;
    end else sMsg := sub_49ADB8(sMsg, '<$KILLER>', 'δ֪');
    Exit;
  end;
  if sVariable = '$MONKILLER' then begin//ɱ�˵Ĺ������ 20080826
    if PlayObject.m_boDeath and (PlayObject.m_LastHiter <> nil) then begin
      if (PlayObject.m_LastHiter.m_btRaceServer <> RC_PLAYOBJECT) and (PlayObject.m_LastHiter.m_btRaceServer <> RC_HEROOBJECT) then begin
        sMsg := sub_49ADB8(sMsg, '<$MONKILLER>', PlayObject.m_LastHiter.m_sCharName);
      end;
    end else sMsg := sub_49ADB8(sMsg, '<$MONKILLER>', 'δ֪');
    Exit;
  end;
  if sVariable = '$MAP' then begin//20080123 ���ӵ�ͼID����
    sMsg := sub_49ADB8(sMsg, '<$MAP>', PlayObject.m_PEnvir.sMapName);
    Exit;
  end;
  if sVariable = '$QUERYYBDEALLOG' then begin//�鿴Ԫ�����׼�¼  20080318
    sMsg := sub_49ADB8(sMsg, '<$QUERYYBDEALLOG>', PlayObject.SelectSellDate());
    Exit;
  end;
  if sVariable = '$GUILDNAME' then begin
    if PlayObject.m_MyGuild <> nil then begin
      sMsg := sub_49ADB8(sMsg, '<$GUILDNAME>', TGUild(PlayObject.m_MyGuild).sGuildName);
    end else begin
      sMsg := '��';
    end;
    Exit;
  end;

  if sVariable = '$TAGMAPNAME1' then begin//��·��ʯ��¼��ͼ�� 20081019
    sMsg := sub_49ADB8(sMsg, '<$TAGMAPNAME1>', PlayObject.m_TagMapInfos[1].TagMapName);
    Exit;
  end;
  if sVariable = '$TAGMAPNAME2' then begin
    sMsg := sub_49ADB8(sMsg, '<$TAGMAPNAME2>', PlayObject.m_TagMapInfos[2].TagMapName);
    Exit;
  end;
  if sVariable = '$TAGMAPNAME3' then begin
    sMsg := sub_49ADB8(sMsg, '<$TAGMAPNAME3>', PlayObject.m_TagMapInfos[3].TagMapName);
    Exit;
  end;
  if sVariable = '$TAGMAPNAME4' then begin
    sMsg := sub_49ADB8(sMsg, '<$TAGMAPNAME4>', PlayObject.m_TagMapInfos[4].TagMapName);
    Exit;
  end;
  if sVariable = '$TAGMAPNAME5' then begin
    sMsg := sub_49ADB8(sMsg, '<$TAGMAPNAME5>', PlayObject.m_TagMapInfos[5].TagMapName);
    Exit;
  end;
  if sVariable = '$TAGMAPNAME6' then begin
    sMsg := sub_49ADB8(sMsg, '<$TAGMAPNAME6>', PlayObject.m_TagMapInfos[6].TagMapName);
    Exit;
  end;

  if sVariable = '$TAGX1' then begin//��·��ʯ��¼X 20081019
    sText := IntToStr(PlayObject.m_TagMapInfos[1].TagX);
    sMsg := sub_49ADB8(sMsg, '<$TAGX1>',sText);
    Exit;
  end;
  if sVariable = '$TAGX2' then begin
    sText := IntToStr(PlayObject.m_TagMapInfos[2].TagX);
    sMsg := sub_49ADB8(sMsg, '<$TAGX2>',sText);
    Exit;
  end;
  if sVariable = '$TAGX3' then begin
    sText := IntToStr(PlayObject.m_TagMapInfos[3].TagX);
    sMsg := sub_49ADB8(sMsg, '<$TAGX3>',sText);
    Exit;
  end;
  if sVariable = '$TAGX4' then begin
    sText := IntToStr(PlayObject.m_TagMapInfos[4].TagX);
    sMsg := sub_49ADB8(sMsg, '<$TAGX4>',sText);
    Exit;
  end;
  if sVariable = '$TAGX5' then begin
    sText := IntToStr(PlayObject.m_TagMapInfos[5].TagX);
    sMsg := sub_49ADB8(sMsg, '<$TAGX5>',sText);
    Exit;
  end;
  if sVariable = '$TAGX6' then begin
    sText := IntToStr(PlayObject.m_TagMapInfos[6].TagX);
    sMsg := sub_49ADB8(sMsg, '<$TAGX6>',sText);
    Exit;
  end;

  if sVariable = '$TAGY1' then begin//��·��ʯ��¼Y 20081019
    sText := IntToStr(PlayObject.m_TagMapInfos[1].TagY);
    sMsg := sub_49ADB8(sMsg, '<$TAGY1>',sText);
    Exit;
  end;
  if sVariable = '$TAGY2' then begin
    sText := IntToStr(PlayObject.m_TagMapInfos[2].TagY);
    sMsg := sub_49ADB8(sMsg, '<$TAGY2>',sText);
    Exit;
  end;
  if sVariable = '$TAGY3' then begin
    sText := IntToStr(PlayObject.m_TagMapInfos[3].TagY);
    sMsg := sub_49ADB8(sMsg, '<$TAGY3>',sText);
    Exit;
  end;
  if sVariable = '$TAGY4' then begin
    sText := IntToStr(PlayObject.m_TagMapInfos[4].TagY);
    sMsg := sub_49ADB8(sMsg, '<$TAGY4>',sText);
    Exit;
  end;
  if sVariable = '$TAGY5' then begin
    sText := IntToStr(PlayObject.m_TagMapInfos[5].TagY);
    sMsg := sub_49ADB8(sMsg, '<$TAGY5>',sText);
    Exit;
  end;
  if sVariable = '$TAGY6' then begin
    sText := IntToStr(PlayObject.m_TagMapInfos[6].TagY);
    sMsg := sub_49ADB8(sMsg, '<$TAGY6>',sText);
    Exit;
  end;

  if sVariable = '$GUILDMEMBERCOUNT' then begin//�л��Ա���� 20090115
    if PlayObject.m_MyGuild <> nil then begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount);
      sMsg := sub_49ADB8(sMsg, '<$GUILDMEMBERCOUNT>', sText);
      Exit;
    end;
  end;
  if sVariable = '$GUILDFOUNTAIN' then begin//�л�Ȫˮ�ֿ� 20080625
    if PlayObject.m_MyGuild <> nil then begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).m_nGuildFountain);
      sMsg := sub_49ADB8(sMsg, '<$GUILDFOUNTAIN>', sText);
      Exit;
    end;
  end;
  if sVariable = '$ALCOHOL' then begin//���� 20080627
    sText := IntToStr(PlayObject.m_Abil.MaxAlcohol);
    sMsg := sub_49ADB8(sMsg, '<$$ALCOHOL>', sText);
    Exit;
  end;
  if sVariable = '$MEDICINEVALUE' then begin//ҩ��ֵ 20080627
    sText := IntToStr(PlayObject.m_Abil.MedicineValue);
    sMsg := sub_49ADB8(sMsg, '<$MEDICINEVALUE>', sText);
    Exit;
  end;
  if sVariable = '$RANKNAME' then begin
    sMsg := sub_49ADB8(sMsg, '<$RANKNAME>', PlayObject.m_sGuildRankName);
    Exit;
  end;
  if sVariable = '$LEVEL' then begin
    sText := IntToStr(PlayObject.m_Abil.Level);
    sMsg := sub_49ADB8(sMsg, '<$LEVEL>', sText);
    Exit;
  end;
  if sVariable = '$USEGAMEGIRD' then begin//ÿ��ʹ���������$USEGAMEGIRD����ʹ�� 20090108
    sText := IntToStr(PlayObject.m_UseGameGird);
    sMsg := sub_49ADB8(sMsg, '<$USEGAMEGIRD>', sText);
    Exit;
  end;
  if sVariable = '$BUYSHOP' then begin//ÿ�����̻���Ԫ������ 20090106
    sText := IntToStr(PlayObject.m_BuyShopPrice);
    sMsg := sub_49ADB8(sMsg, '<$BUYSHOP>', sText);
    Exit;
  end;
  if sVariable = '$GETCRYSTALEXP' then begin//��ؽᾧ����ȡ�ľ��� 20090202
    sText := IntToStr(PlayObject.m_nGetCrystalExp);
    sMsg := sub_49ADB8(sMsg, '<$GETCRYSTALEXP>', sText);
    Exit;
  end;
  if sVariable = '$GETCRYSTALNGEXP' then begin//��ؽᾧ����ȡ���ڹ����� 20090202
    sText := IntToStr(PlayObject.m_nGetCrystalNGExp);
    sMsg := sub_49ADB8(sMsg, '<$GETCRYSTALNGEXP>', sText);
    Exit;
  end;
  if sVariable = '$CRYSTALEXP' then begin//��ؽᾧ��ǰ�ľ��� 20090202
    sText := IntToStr(PlayObject.m_CrystalExp);
    sMsg := sub_49ADB8(sMsg, '<$CRYSTALEXP>', sText);
    Exit;
  end;
  if sVariable = '$CRYSTALNGEXP' then begin//��ؽᾧ��ǰ���ڹ����� 20090202
    sText := IntToStr(PlayObject.m_CrystalNGExp);
    sMsg := sub_49ADB8(sMsg, '<$CRYSTALNGEXP>', sText);
    Exit;
  end;
  if sVariable = '$CRYSTALLEVEL' then begin//��ؽᾧ�ȼ� 20090202
    sText := IntToStr(_MIN( 5,PlayObject.m_CrystalLevel));
    sMsg := sub_49ADB8(sMsg, '<$CRYSTALLEVEL>', sText);
    Exit;
  end;
  if sVariable = '$GETEXP' then begin//����ȡ�õľ��� 20081228
    sText := IntToStr(PlayObject.m_GetExp);
    sMsg := sub_49ADB8(sMsg, '<$GETEXP>', sText);
    Exit;
  end;
  if sVariable = '$HEROGETEXP' then begin//Ӣ��ȡ�õľ��� 20081228
    if PlayObject.m_MyHero <> nil then begin
      sText := IntToStr(THeroObject(PlayObject.m_MyHero).m_GetExp);
    end else sText := '????';
    sMsg := sub_49ADB8(sMsg, '<$HEROGETEXP>', sText);
    Exit;
  end;
  if sVariable = '$GLORYPOINT' then begin//��������ֵ  20080512
    sText := IntToStr(PlayObject.m_btGameGlory);
    sMsg := sub_49ADB8(sMsg, '<$GLORYPOINT>', sText);
    Exit;
  end;
  if sVariable = '$STATSERVERTIME' then begin //��ʾM2����ʱ��
    sText := FrmMain.LbRunTime.Caption;
    sMsg := sub_49ADB8(sMsg, '<$STATSERVERTIME>', sText);
    Exit;
  end;
  if sVariable = '$RUNDATETIME' then begin //�������ʱ��
    sText := FrmMain.LbTimeCount.Caption;
    sMsg := sub_49ADB8(sMsg, '<$RUNDATETIME>', sText);
    Exit;
  end;
  if sVariable = '$RANDOMNO' then begin //���ֵ����
    sText := IntToStr(Random(High(Integer)));
    sMsg := sub_49ADB8(sMsg, '<$RANDOMNO>', sText);
    Exit;
  end;
  if sVariable = '$USERID' then begin //��¼�˺�
    sText := PlayObject.m_sUserID;
    sMsg := sub_49ADB8(sMsg, '<$USERID>', sText);
    Exit;
  end;
  if sVariable = '$IPADDR' then begin //��¼IP
    sText := PlayObject.m_sIPaddr;
    sMsg := sub_49ADB8(sMsg, '<$IPADDR>', sText);
    Exit;
  end;
  if sVariable = '$X' then begin//����X����
    sText := IntToStr(PlayObject.m_nCurrX);
    sMsg := sub_49ADB8(sMsg, '<$X>', sText);
    Exit;
  end;
  if sVariable = '$Y' then begin//����Y����
    sText := IntToStr(PlayObject.m_nCurrY);
    sMsg := sub_49ADB8(sMsg, '<$Y>', sText);
    Exit;
  end;
  if sVariable = '$HP' then begin
    sText := IntToStr(PlayObject.m_WAbil.HP);
    sMsg := sub_49ADB8(sMsg, '<$HP>', sText);
    Exit;
  end;
  if sVariable = '$MAXHP' then begin
    sText := IntToStr(PlayObject.m_WAbil.MaxHP);
    sMsg := sub_49ADB8(sMsg, '<$MAXHP>', sText);
    Exit;
  end;

  if sVariable = '$MP' then begin
    sText := IntToStr(PlayObject.m_WAbil.MP);
    sMsg := sub_49ADB8(sMsg, '<$MP>', sText);
    Exit;
  end;
  if sVariable = '$MAXMP' then begin
    sText := IntToStr(PlayObject.m_WAbil.MaxMP);
    sMsg := sub_49ADB8(sMsg, '<$MAXMP>', sText);
    Exit;
  end;

  if sVariable = '$AC' then begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.AC));
    sMsg := sub_49ADB8(sMsg, '<$AC>', sText);
    Exit;
  end;
  if sVariable = '$MAXAC' then begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.AC));
    sMsg := sub_49ADB8(sMsg, '<$MAXAC>', sText);
    Exit;
  end;
  if sVariable = '$MAC' then begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.MAC));
    sMsg := sub_49ADB8(sMsg, '<$MAC>', sText);
    Exit;
  end;
  if sVariable = '$MAXMAC' then begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.MAC));
    sMsg := sub_49ADB8(sMsg, '<$MAXMAC>', sText);
    Exit;
  end;

  if sVariable = '$DC' then begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.DC));
    sMsg := sub_49ADB8(sMsg, '<$DC>', sText);
    Exit;
  end;
  if sVariable = '$MAXDC' then begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.DC));
    sMsg := sub_49ADB8(sMsg, '<$MAXDC>', sText);
    Exit;
  end;

  if sVariable = '$MC' then begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.MC));
    sMsg := sub_49ADB8(sMsg, '<$MC>', sText);
    Exit;
  end;
  if sVariable = '$MAXMC' then begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.MC));
    sMsg := sub_49ADB8(sMsg, '<$MAXMC>', sText);
    Exit;
  end;

  if sVariable = '$SC' then begin
    sText := IntToStr(LoWord(PlayObject.m_WAbil.SC));
    sMsg := sub_49ADB8(sMsg, '<$SC>', sText);
    Exit;
  end;
  if sVariable = '$MAXSC' then begin
    sText := IntToStr(HiWord(PlayObject.m_WAbil.SC));
    sMsg := sub_49ADB8(sMsg, '<$MAXSC>', sText);
    Exit;
  end;

  if sVariable = '$EXP' then begin
    sText := IntToStr(PlayObject.m_Abil.Exp);
    sMsg := sub_49ADB8(sMsg, '<$EXP>', sText);
    Exit;
  end;
  if sVariable = '$MAXEXP' then begin
    sText := IntToStr(PlayObject.m_Abil.MaxExp);
    sMsg := sub_49ADB8(sMsg, '<$MAXEXP>', sText);
    Exit;
  end;

  if sVariable = '$PKPOINT' then begin
    sText := IntToStr(PlayObject.m_nPkPoint);
    sMsg := sub_49ADB8(sMsg, '<$PKPOINT>', sText);
    Exit;
  end;
  if sVariable = '$CREDITPOINT' then begin
    sText := IntToStr(PlayObject.m_btCreditPoint);
    sMsg := sub_49ADB8(sMsg, '<$CREDITPOINT>', sText);
    Exit;
  end;

  if sVariable = '$HW' then begin
    sText := IntToStr(PlayObject.m_WAbil.HandWeight);
    sMsg := sub_49ADB8(sMsg, '<$HW>', sText);
    Exit;
  end;
  if sVariable = '$MAXHW' then begin
    sText := IntToStr(PlayObject.m_WAbil.MaxHandWeight);
    sMsg := sub_49ADB8(sMsg, '<$MAXHW>', sText);
    Exit;
  end;

  if sVariable = '$BW' then begin
    sText := IntToStr(PlayObject.m_WAbil.Weight);
    sMsg := sub_49ADB8(sMsg, '<$BW>', sText);
    Exit;
  end;
  if sVariable = '$MAXBW' then begin
    sText := IntToStr(PlayObject.m_WAbil.MaxWeight);
    sMsg := sub_49ADB8(sMsg, '<$MAXBW>', sText);
    Exit;
  end;

  if sVariable = '$WW' then begin
    sText := IntToStr(PlayObject.m_WAbil.WearWeight);
    sMsg := sub_49ADB8(sMsg, '<$WW>', sText);
    Exit;
  end;
  if sVariable = '$MAXWW' then begin
    sText := IntToStr(PlayObject.m_WAbil.MaxWearWeight);
    sMsg := sub_49ADB8(sMsg, '<$MAXWW>', sText);
    Exit;
  end;

  if sVariable = '$GOLDCOUNT' then begin
    sText := IntToStr(PlayObject.m_nGold) + '/' + IntToStr(PlayObject.m_nGoldMax);
    sMsg := sub_49ADB8(sMsg, '<$GOLDCOUNT>', sText);
    Exit;
  end;
  if sVariable = '$GAMEGOLD' then begin
    sText := IntToStr(PlayObject.m_nGameGold);
    sMsg := sub_49ADB8(sMsg, '<$GAMEGOLD>', sText);
    Exit;
  end;
  if sVariable = '$GAMEDIAMOND' then begin//20071227 ���ʯ Ҫע���Сд,��Ȼ�ͻ�����ʾ��������
    sText := IntToStr(PlayObject.m_nGAMEDIAMOND);
    sMsg := sub_49ADB8(sMsg, '<$GAMEDIAMOND>', sText);
    Exit;
  end;
  if sVariable = '$GAMEGIRD' then begin//20071227 ���
    sText := IntToStr(PlayObject.m_nGameGird);
    sMsg := sub_49ADB8(sMsg, '<$GAMEGIRD>', sText);
    Exit;
  end;
  if sVariable = '$GAMEPOINT' then begin
    sText := IntToStr(PlayObject.m_nGamePoint);
    sMsg := sub_49ADB8(sMsg, '<$GAMEPOINT>', sText);
    Exit;
  end;
  if sVariable = '$HUNGER' then begin
    sText := IntToStr(PlayObject.GetMyStatus);
    sMsg := sub_49ADB8(sMsg, '<$HUNGER>', sText);
    Exit;
  end;
  if sVariable = '$LOGINTIME' then begin
    sText := DateTimeToStr(PlayObject.m_dLogonTime);
    sMsg := sub_49ADB8(sMsg, '<$LOGINTIME>', sText);
    Exit;
  end;
  if sVariable = '$LOGINLONG' then begin
    sText := IntToStr((GetTickCount - PlayObject.m_dwLogonTick) div 60000) + '����';
    sMsg := sub_49ADB8(sMsg, '<$LOGINLONG>', sText);
    Exit;
  end;
  if sVariable = '$DRESS' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_DRESS].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$DRESS>', sText);
    Exit;
  end else
    if sVariable = '$WEAPON' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$WEAPON>', sText);
    Exit;
  end else
    if sVariable = '$RIGHTHAND' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RIGHTHAND].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$RIGHTHAND>', sText);
    Exit;
  end else
    if sVariable = '$HELMET' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HELMET].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$HELMET>', sText);
    Exit;
  end else
    if sVariable = '$ZHULI' then begin //20080416 ����
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ZHULI].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$ZHULI>', sText);
    Exit;
  end else
    if sVariable = '$NECKLACE' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_NECKLACE].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$NECKLACE>', sText);
    Exit;
  end else
    if sVariable = '$RING_R' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGR].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$RING_R>', sText);
    Exit;
  end else
    if sVariable = '$RING_L' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGL].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$RING_L>', sText);
    Exit;
  end else
    if sVariable = '$ARMRING_R' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$ARMRING_R>', sText);
    Exit;
  end else
    if sVariable = '$ARMRING_L' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$ARMRING_L>', sText);
    Exit;
  end else
    if sVariable = '$BUJUK' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BUJUK].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$BUJUK>', sText);
    Exit;
  end else
    if sVariable = '$BELT' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BELT].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$BELT>', sText);
    Exit;
  end else
    if sVariable = '$BOOTS' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BOOTS].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$BOOTS>', sText);
    Exit;
  end else
    if sVariable = '$CHARM' then begin
    sText := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CHARM].wIndex);
    sMsg := sub_49ADB8(sMsg, '<$CHARM>', sText);
    Exit;
  end else
    if sVariable = '$IPADDR' then begin
    sText := PlayObject.m_sIPaddr;
    sMsg := sub_49ADB8(sMsg, '<$IPADDR>', sText);
    Exit;
  end else
    if sVariable = '$IPLOCAL' then begin
    sText := PlayObject.m_sIPLocal; // GetIPLocal(PlayObject.m_sIPaddr);
    sMsg := sub_49ADB8(sMsg, '<$IPLOCAL>', sText);
    Exit;
  end else
    if sVariable = '$GUILDBUILDPOINT' then begin
    if PlayObject.m_MyGuild = nil then begin
      sText := '��';
    end else begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).nBuildPoint);
    end;
    sMsg := sub_49ADB8(sMsg, '<$GUILDBUILDPOINT>', sText);
    Exit;
  end else
    if sVariable = '$GUILDAURAEPOINT' then begin
    if PlayObject.m_MyGuild = nil then begin
      sText := '��';
    end else begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).nAurae);
    end;
    sMsg := sub_49ADB8(sMsg, '<$GUILDAURAEPOINT>', sText);
    Exit;
  end else
    if sVariable = '$GUILDSTABILITYPOINT' then begin
    if PlayObject.m_MyGuild = nil then begin
      sText := '��';
    end else begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).nStability);
    end;
    sMsg := sub_49ADB8(sMsg, '<$GUILDSTABILITYPOINT>', sText);
    Exit;
  end;
  if sVariable = '$GUILDFLOURISHPOINT' then begin
    if PlayObject.m_MyGuild = nil then begin
      sText := '��';
    end else begin
      sText := IntToStr(TGUild(PlayObject.m_MyGuild).nFlourishing);
    end;
    sMsg := sub_49ADB8(sMsg, '<$GUILDFLOURISHPOINT>', sText);
    Exit;
  end;

  //������Ϣ
  if sVariable = '$REQUESTCASTLEWARITEM' then begin
    sText := g_Config.sZumaPiece;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLEWARITEM>', sText);
    Exit;
  end;
  if sVariable = '$REQUESTCASTLEWARDAY' then begin
    sText := g_Config.sZumaPiece;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLEWARDAY>', sText);
    Exit;
  end;
  if sVariable = '$REQUESTBUILDGUILDITEM' then begin
    sText := g_Config.sWomaHorn;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTBUILDGUILDITEM>', sText);
    Exit;
  end;
  if sVariable = '$OWNERGUILD' then begin
    if m_Castle <> nil then begin
      sText := TUserCastle(m_Castle).m_sOwnGuild;
      if sText = '' then sText := '��Ϸ����';
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$OWNERGUILD>', sText);
    Exit;
  end; //0049AF32

  if sVariable = '$CASTLENAME' then begin
    if m_Castle <> nil then begin
      sText := TUserCastle(m_Castle).m_sName;
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLENAME>', sText);
    Exit;
  end;
  if sVariable = '$LORD' then begin
    if m_Castle <> nil then begin
      if TUserCastle(m_Castle).m_MasterGuild <> nil then begin
        sText := TUserCastle(m_Castle).m_MasterGuild.GetChiefName();
      end else sText := '����Ա';
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$LORD>', sText);
    Exit;
  end; //0049AF32

  if sVariable = '$GUILDWARFEE' then begin
    sMsg := sub_49ADB8(sMsg, '<$GUILDWARFEE>', IntToStr(g_Config.nGuildWarPrice));
    Exit;
  end;
  if sVariable = '$BUILDGUILDFEE' then begin
    sMsg := sub_49ADB8(sMsg, '<$BUILDGUILDFEE>', IntToStr(g_Config.nBuildGuildPrice));
    Exit;
  end;

  if sVariable = '$CASTLEWARDATE' then begin
    if m_Castle = nil then begin
      m_Castle := g_CastleManager.GetCastle(0);
    end;
    if m_Castle <> nil then begin
      if not TUserCastle(m_Castle).m_boUnderWar then begin
        sText := TUserCastle(m_Castle).GetWarDate();
        if sText <> '' then begin
          sMsg := sub_49ADB8(sMsg, '<$CASTLEWARDATE>', sText);
        end else sMsg := '��ʱû���лṥ�ǣ�����\ \<����/@main>';
      end else sMsg := '�����ڹ����У�����\ \<����/@main>';
    end else begin
      sText := '????';
    end;
    Exit;
  end;

  if sVariable = '$LISTOFWAR' then begin
    if m_Castle <> nil then begin
      sText := TUserCastle(m_Castle).GetAttackWarList();
    end else begin
      sText := '????';
    end;
    if sText <> '' then begin
      sMsg := sub_49ADB8(sMsg, '<$LISTOFWAR>', sText);
    end else sMsg := '����û���л����빥��ս\ \<����/@main>';
    Exit;
  end;

  if sVariable = '$CASTLECHANGEDATE' then begin
    if m_Castle <> nil then begin
      sText := DateTimeToStr(TUserCastle(m_Castle).m_ChangeDate);
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLECHANGEDATE>', sText);
    Exit;
  end;

  if sVariable = '$CASTLEWARLASTDATE' then begin
    if m_Castle <> nil then begin
      sText := DateTimeToStr(TUserCastle(m_Castle).m_WarDate);
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLEWARLASTDATE>', sText);
    Exit;
  end;
  if sVariable = '$CASTLEGETDAYS' then begin
    if m_Castle <> nil then begin
      sText := IntToStr(GetDayCount(Now, TUserCastle(m_Castle).m_ChangeDate));
    end else begin
      sText := '????';
    end;
    sMsg := sub_49ADB8(sMsg, '<$CASTLEGETDAYS>', sText);
    Exit;
  end;

  if sVariable = '$CMD_DATE' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_DATE>', g_GameCommand.Data.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_ALLOWMSG' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ALLOWMSG>', g_GameCommand.ALLOWMSG.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_LETSHOUT' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_LETSHOUT>', g_GameCommand.LETSHOUT.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_LETTRADE' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_LETTRADE>', g_GameCommand.LETTRADE.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_LETGUILD' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_LETGUILD>', g_GameCommand.LETGUILD.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_ENDGUILD' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ENDGUILD>', g_GameCommand.ENDGUILD.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_BANGUILDCHAT' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_BANGUILDCHAT>', g_GameCommand.BANGUILDCHAT.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_AUTHALLY' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_AUTHALLY>', g_GameCommand.AUTHALLY.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_AUTH' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_AUTH>', g_GameCommand.AUTH.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_AUTHCANCEL' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_AUTHCANCEL>', g_GameCommand.AUTHCANCEL.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_USERMOVE' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_USERMOVE>', g_GameCommand.USERMOVE.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_SEARCHING' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_SEARCHING>', g_GameCommand.SEARCHING.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_ALLOWGROUPCALL' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ALLOWGROUPCALL>', g_GameCommand.ALLOWGROUPCALL.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_GROUPRECALLL' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_GROUPRECALLL>', g_GameCommand.GROUPRECALLL.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_ATTACKMODE' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_ATTACKMODE>', g_GameCommand.ATTACKMODE.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_REST' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_REST>', g_GameCommand.REST.sCmd);
    Exit;
  end;

  if sVariable = '$CMD_STORAGESETPASSWORD' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGESETPASSWORD>', g_GameCommand.SETPASSWORD.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_STORAGECHGPASSWORD' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGECHGPASSWORD>', g_GameCommand.CHGPASSWORD.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_STORAGELOCK' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGELOCK>', g_GameCommand.Lock.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_STORAGEUNLOCK' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_STORAGEUNLOCK>', g_GameCommand.UNLOCKSTORAGE.sCmd);
    Exit;
  end;
  if sVariable = '$CMD_UNLOCK' then begin
    sMsg := sub_49ADB8(sMsg, '<$CMD_UNLOCK>', g_GameCommand.UnLock.sCmd);
    Exit;
  end;
  if CompareLStr(sVariable, '$HUMAN(', 7{Length('$HUMAN(')}) then begin
    ArrestStringEx(sVariable, '(', ')', s14);
    boFoundVar := False;
    if PlayObject.m_DynamicVarList.Count > 0 then begin//20080629
      for I := 0 to PlayObject.m_DynamicVarList.Count - 1 do begin
        DynamicVar := PlayObject.m_DynamicVarList.Items[I];
        if CompareText(DynamicVar.sName, s14) = 0 then begin
          case DynamicVar.VarType of
            vInteger: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
                boFoundVar := True;
              end;
            vString: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
                boFoundVar := True;
              end;
          end;
          Break;
        end;
      end;//for
    end;
    if not boFoundVar then sMsg := '??';
    Exit;
  end;
  if CompareLStr(sVariable, '$GUILD(', 7{Length('$GUILD(')}) then begin
    if PlayObject.m_MyGuild = nil then Exit;
    ArrestStringEx(sVariable, '(', ')', s14);
    boFoundVar := False;
    if TGUild(PlayObject.m_MyGuild).m_DynamicVarList.Count > 0 then begin//20080629
      for I := 0 to TGUild(PlayObject.m_MyGuild).m_DynamicVarList.Count - 1 do begin
        DynamicVar := TGUild(PlayObject.m_MyGuild).m_DynamicVarList.Items[I];
        if CompareText(DynamicVar.sName, s14) = 0 then begin
          case DynamicVar.VarType of
            vInteger: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
                boFoundVar := True;
              end;
            vString: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
                boFoundVar := True;
              end;
          end;
          Break;
        end;
      end;//for
    end;
    if not boFoundVar then sMsg := '??';
    Exit;
  end;
  if CompareLStr(sVariable, '$GLOBAL(', 8{Length('$GLOBAL(')}) then begin
    ArrestStringEx(sVariable, '(', ')', s14);
    boFoundVar := False;
    if g_DynamicVarList.Count > 0 then begin//20080629
      for I := 0 to g_DynamicVarList.Count - 1 do begin
        DynamicVar := g_DynamicVarList.Items[I];
        if CompareText(DynamicVar.sName, s14) = 0 then begin
          case DynamicVar.VarType of
            vInteger: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(DynamicVar.nInternet));
                boFoundVar := True;
              end;
            vString: begin
                sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', DynamicVar.sString);
                boFoundVar := True;
              end;
          end;
          Break;
        end;
      end;//for
    end;
    if not boFoundVar then sMsg := '??';
    Exit;
  end;
  if CompareLStr(sVariable, '$STR(', 5{Length('$STR(')}) then begin
    ArrestStringEx(sVariable, '(', ')', s14);
    n18 := GetValNameNo(s14);
    if n18 >= 0 then begin
      case n18 of
        0..99: begin //20080323 ԭΪ0..99
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nVal[n18]));
          end;
        100..199: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(g_Config.GlobalVal[n18 - 100]));
          end;
        200..299: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_DyVal[n18 - 200]));
          end;
        300..399: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nMval[n18 - 300]));
          end;
        400..499: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(g_Config.GlobaDyMval[n18 - 400]));
          end;
        500..599: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', IntToStr(PlayObject.m_nInteger[n18 - 500]));
          end;
        600..699: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', PlayObject.m_sString[n18 - 600]);
          end;
        700..799: begin
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.GlobalAVal[n18 - 700]);
          end;
        800..1199:begin//20080903 G����(100-499)
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>',  IntToStr(g_Config.GlobalVal[n18 - 700]));
          end;
        1200..1599:begin//20080903 A����(100-499)
            sMsg := sub_49ADB8(sMsg, '<' + sVariable + '>', g_Config.GlobalAVal[n18 - 1100]);
          end;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.GetVariableText');
end;
end;

procedure TNormNpc.GotoLable(PlayObject: TPlayObject; sLabel: string; boExtJmp: Boolean); //0049E584
var
  I, II, III: Integer;
  List1C: TStringList;
  bo11: Boolean;
  n18: Integer;
  n20: Integer;
  sSENDMSG: string;
  Script: pTScript;
  Script3C: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
  UserItem: pTUserItem;
  SC: string;
  m_DelayGoto: LongWord;//20081213
  nCode: Byte;//20081005
  function CheckQuestStatus(ScriptInfo: pTScript): Boolean; //0049BA00
  var
    I: Integer;
  begin
    Result := True;
    if not ScriptInfo.boQuest then Exit;
    I := 0;
    while (True) do begin
      if (ScriptInfo.QuestInfo[I].nRandRage > 0) and (Random(ScriptInfo.QuestInfo[I].nRandRage) <> 0) then begin
        Result := False;
        Break;
      end;
      if PlayObject.GetQuestFalgStatus(ScriptInfo.QuestInfo[I].wFlag) <> ScriptInfo.QuestInfo[I].btValue then begin
        Result := False;
        Break;
      end;
      Inc(I);
      if I >= 10 then Break;
    end; // while
  end;
  function CheckItemW(sItemType: string; nParam: Integer): pTUserItem; //0049BA7C
  var
    nCount: Integer;
  begin
    Result := nil;
    if CompareLStr(sItemType, '[NECKLACE]', 4) then begin
      if PlayObject.m_UseItems[U_NECKLACE].wIndex > 0 then begin
        Result := @PlayObject.m_UseItems[U_NECKLACE];
      end;
      Exit;
    end;
    if CompareLStr(sItemType, '[RING]', 4) then begin
      if PlayObject.m_UseItems[U_RINGL].wIndex > 0 then begin
        Result := @PlayObject.m_UseItems[U_RINGL];
      end;
      if PlayObject.m_UseItems[U_RINGR].wIndex > 0 then begin
        Result := @PlayObject.m_UseItems[U_RINGR];
      end;
      Exit;
    end;
    if CompareLStr(sItemType, '[ARMRING]', 4) then begin
      if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then begin
        Result := @PlayObject.m_UseItems[U_ARMRINGL];
      end;
      if PlayObject.m_UseItems[U_ARMRINGR].wIndex > 0 then begin
        Result := @PlayObject.m_UseItems[U_ARMRINGR];
      end;
      Exit;
    end;
    if CompareLStr(sItemType, '[WEAPON]', 4) then begin
      if PlayObject.m_UseItems[U_WEAPON].wIndex > 0 then begin
        Result := @PlayObject.m_UseItems[U_WEAPON];
      end;
      Exit;
    end;
    if CompareLStr(sItemType, '[HELMET]', 4) then begin
      if PlayObject.m_UseItems[U_HELMET].wIndex > 0 then begin
        Result := @PlayObject.m_UseItems[U_HELMET];
      end;
      Exit;
    end;
    if CompareLStr(sItemType, '[ZHULI]', 4) then begin //20080416 ����
      if PlayObject.m_UseItems[U_ZHULI].wIndex > 0 then begin
        Result := @PlayObject.m_UseItems[U_ZHULI];
      end;
      Exit;
    end;
    Result := PlayObject.sub_4C4CD4(sItemType, nCount);
    if nCount < nParam then Result := nil;
  end;
  function CheckAnsiContainsTextList(sTest, sListFileName: string): Boolean;
  var
    I: Integer;
    LoadList: TStringList;
  begin
    Result := False;
    sListFileName := g_Config.sEnvirDir + sListFileName;
    if FileExists(sListFileName) then begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('�ļ���ȡʧ��.... => ' + sListFileName);
      end;
      if LoadList.Count > 0 then begin//20080629
        for I := 0 to LoadList.Count - 1 do begin
          if AnsiContainsText(sTest, Trim(LoadList.Strings[I])) then begin
            Result := True;
            Break;
          end;
        end;
      end;
      LoadList.Free;
    end else begin
      MainOutMessage('�ļ�û���ҵ� => ' + sListFileName);
    end;
  end;

  function CheckTextInList(sTest, sListFileName: string): Boolean;//����ı����Ƿ���ָ�����ַ��� 200804028
  var
    I: Integer;
    LoadList: TStringList;
  begin
    Result := False;
    sListFileName := g_Config.sEnvirDir + sListFileName;
    if FileExists(sListFileName) then begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('�ļ���ȡʧ�� => ' + sListFileName);
      end;
      if LoadList.Count > 0 then begin//20080629
        for I := 0 to LoadList.Count - 1 do begin
          if AnsiContainsText(Trim(LoadList.Strings[I]), sTest) then begin
            Result := True;
            Break;
          end;
        end;
      end;
      LoadList.Free;
    end else begin
      MainOutMessage('�ļ�û���ҵ� => ' + sListFileName);
    end;
  end;

  function CheckStringList(sHumName, sListFileName: string): Boolean;
  var
    I: Integer;
    LoadList: TStringList;
  begin
    Result := False;
    sListFileName := g_Config.sEnvirDir + sListFileName;
    if FileExists(sListFileName) then begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('�ļ���ȡʧ�� => ' + sListFileName);
      end;
      if LoadList.Count > 0 then begin//20080629
        for I := 0 to LoadList.Count - 1 do begin
          if CompareText(Trim(LoadList.Strings[I]), sHumName) = 0 then begin
            Result := True;
            Break;
          end;
        end;
      end;
      LoadList.Free;
    end else begin
      MainOutMessage('�ļ�û���ҵ� => ' + sListFileName);
    end;
  end;

  function CheckVarNameNo(CheckQuestConditionInfo: pTQuestConditionInfo; var n140, n180: Integer): Boolean;
    function GetValValue(sValName: string; var nValue: Integer): Boolean;
    var
      n100: Integer;
    begin
      Result := False;
      nValue := 0;
      n100 := GetValNameNo(sValName);
      if n100 >= 0 then begin
        case n100 of
          0..99: begin //20080323 ԭΪ0..99
              nValue := PlayObject.m_nVal[n100];
              Result := True;
            end;
          100..199: begin
              nValue := g_Config.GlobalVal[n100 - 100];
              Result := True;
            end;
          200..299: begin //20080323 ԭΪ200..209
              nValue := PlayObject.m_DyVal[n100 - 200];
              Result := True;
            end;
          300..399: begin
              nValue := PlayObject.m_nMval[n100 - 300];
              Result := True;
            end;
          400..499: begin
              nValue := g_Config.GlobaDyMval[n100 - 400];
              Result := True;
            end;
          500..599: begin
              nValue := PlayObject.m_nInteger[n100 - 500];
              Result := True;
            end;
          600..699: begin//20080602 ����
              if IsStringNumber(PlayObject.m_sString[n100 - 600]) then begin//20081210
                nValue := Str_ToInt(PlayObject.m_sString[n100 - 600],0);
                Result := True;
              end;
            end;
          700..799: begin//20080602 ����
              if IsStringNumber(g_Config.GlobalAVal[n100 - 700]) then begin//20081210
                nValue := Str_ToInt(g_Config.GlobalAVal[n100 - 700],0);
                Result := True;
              end;
            end;
          800..1199:begin//20080903 G����
              nValue := g_Config.GlobalVal[n100 - 700];
              Result := True;
            end;
          1200..1599:begin//20080903 A����(100-499)
              if IsStringNumber(g_Config.GlobalAVal[n100 - 1100]) then begin//20081210
                nValue := Str_ToInt(g_Config.GlobalAVal[n100 - 1100],0);
                Result := True;
              end;
            end;
        end;
      end;
    end;

    function GetDynamicVarValue(sVarType, sValName: string; var nValue: Integer): Boolean;
    var
      III: Integer;
      DynamicVar: pTDynamicVar;
      DynamicVarList: TList;
      sName: string;
    begin
      Result := False;
      DynamicVarList := GetDynamicVarList(PlayObject, sVarType, sName);
      if DynamicVarList = nil then begin
        Exit;
      end else begin
        if DynamicVarList.Count > 0 then begin//20080629
          for III := 0 to DynamicVarList.Count - 1 do begin
            DynamicVar := DynamicVarList.Items[III];
            if DynamicVar <> nil then begin
              if CompareText(DynamicVar.sName, sValName) = 0 then begin
                case DynamicVar.VarType of
                  vInteger: begin
                      nValue := DynamicVar.nInternet;
                      Result := True;
                    end;
                  vString: begin
                    end;
                end;
                Break;
              end;
            end;
          end;//for
        end;
      end;
    end;
    function GetDataType: Integer; //
    var
      sParam1: string;
      sParam2: string;
      sParam3: string;
    begin
      Result := -1;
      if CompareLStr(CheckQuestConditionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
        ArrestStringEx(CheckQuestConditionInfo.sParam1, '(', ')', sParam1)
      else sParam1 := CheckQuestConditionInfo.sParam1;

      if CompareLStr(CheckQuestConditionInfo.sParam2, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
        ArrestStringEx(CheckQuestConditionInfo.sParam2, '(', ')', sParam2)
      else sParam2 := CheckQuestConditionInfo.sParam2;

      if CompareLStr(CheckQuestConditionInfo.sParam3, '<$STR(', 6{Length('<$STR(')}) then  //20080228 ֧���ַ�������
        ArrestStringEx(CheckQuestConditionInfo.sParam3, '(', ')', sParam3)
      else sParam3 := CheckQuestConditionInfo.sParam3;
      
      {sParam1 := CheckQuestConditionInfo.sParam1;//20080228
      sParam2 := CheckQuestConditionInfo.sParam2;
      sParam3 := CheckQuestConditionInfo.sParam3;}
      if IsVarNumber(sParam1) then begin
        if (sParam3 <> '') and (GetValNameNo(sParam3) >= 0) then begin
          Result := 0;
        end else
          if (sParam3 <> '') and IsStringNumber(sParam3) then begin
          Result := 1;
        end;
        Exit;
      end;
      if GetValNameNo(sParam1) >= 0 then begin
        if (sParam2 <> '') and (GetValNameNo(sParam2) >= 0) then begin
          Result := 2;
        end else
          if (sParam2 <> '') and IsVarNumber(sParam2) and (sParam3 <> '') then begin
          Result := 3;
        end else
          if (sParam2 <> '') and IsStringNumber(sParam2) then begin
          Result := 4;
        end;
      end;
    end;
  var
    sParam1: string;
    sParam2: string;
    sParam3: string;
  begin
    Result := False;
    n140 := -1;
    n180 := -1;

    if CompareLStr(CheckQuestConditionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
      ArrestStringEx(CheckQuestConditionInfo.sParam1, '(', ')', sParam1)
    else sParam1 := CheckQuestConditionInfo.sParam1;

    if CompareLStr(CheckQuestConditionInfo.sParam2, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
      ArrestStringEx(CheckQuestConditionInfo.sParam2, '(', ')', sParam2)
    else sParam2 := CheckQuestConditionInfo.sParam2;

    if CompareLStr(CheckQuestConditionInfo.sParam3, '<$STR(', 6{Length('<$STR(')}) then  //20080228 ֧���ַ�������
      ArrestStringEx(CheckQuestConditionInfo.sParam3, '(', ')', sParam3)
    else sParam3 := CheckQuestConditionInfo.sParam3;

    case GetDataType of
      0: begin
          if GetDynamicVarValue(sParam1, sParam2, n140) and
            GetValValue(sParam3, n180) then Result := True;
        end;
      1: begin
          n180 := CheckQuestConditionInfo.nParam3;
          if GetDynamicVarValue(sParam1, sParam2, n140) then Result := True;
        end;
      2: begin
          if GetValValue(sParam1, n140) and GetValValue(sParam2, n180) then Result := True;
        end;
      3: begin
          if GetValValue(sParam1, n140) and
            GetDynamicVarValue(sParam2, sParam3, n180) then Result := True;
        end;
      4: begin
          n180 := CheckQuestConditionInfo.nParam2;
          if GetValValue(sParam1, n140) then Result := True;
        end;
      5: begin

       end;
    end;
  end;

  function QuestCheckCondition(ConditionList: TList): Boolean;
  var
    I: Integer;
    QuestConditionInfo: pTQuestConditionInfo;
    n10, n14, n18, n1C, nMaxDura, nDura: Integer;
    Hour, Min, Sec, MSec: Word;
    StdItem: pTStdItem;
    s01, s02: string;
  begin
    Result := True;
    if ConditionList.Count > 0 then begin//20081008
      for I := 0 to ConditionList.Count - 1 do begin
        QuestConditionInfo := ConditionList.Items[I];
        case QuestConditionInfo.nCMDCode of
          nCHECK: begin//48
              n14 := Str_ToInt(QuestConditionInfo.sParam1, 0);
              n18 := Str_ToInt(QuestConditionInfo.sParam2, 0);
              n10 := PlayObject.GetQuestFalgStatus(n14);
              if n10 = 0 then begin
                if n18 <> 0 then Result := False;
              end else begin
                if n18 = 0 then Result := False;
              end;
            end;
          nRANDOM: begin//49
              if Random(QuestConditionInfo.nParam1) <> 0 then
                Result := False;
            end;
          nGENDER: begin//70  ����ɫ�Ա�
              if CompareText(QuestConditionInfo.sParam2, 'HERO') = 0 then begin//20081211 ���Ӽ��Ӣ���Ա�
                if PlayObject.m_MyHero <> nil then begin
                  if CompareText(QuestConditionInfo.sParam1, 'MAN'{sMAN}) = 0 then begin
                    if PlayObject.m_MyHero.m_btGender <> 0 then Result := False;
                  end else
                  if CompareText(QuestConditionInfo.sParam1, 'WOMAN') = 0 then begin
                    if PlayObject.m_MyHero.m_btGender <> 1 then Result := False;
                  end;
                end else Result := False;
              end else begin
                if CompareText(QuestConditionInfo.sParam1, 'MAN'{sMAN}) = 0 then begin
                  if PlayObject.m_btGender <> 0 then Result := False;
                end else begin
                  if PlayObject.m_btGender <> 1 then Result := False;
                end;
              end;
            end;
          nDAYTIME: begin
              if CompareText(QuestConditionInfo.sParam1, 'SUNRAISE'{sSUNRAISE}) = 0 then begin
                if g_nGameTime <> 0 then Result := False;
              end;
              if CompareText(QuestConditionInfo.sParam1, 'DAY'{sDAY}) = 0 then begin
                if g_nGameTime <> 1 then Result := False;
              end;
              if CompareText(QuestConditionInfo.sParam1, 'SUNSET'{sSUNSET}) = 0 then begin
                if g_nGameTime <> 2 then Result := False;
              end;
              if CompareText(QuestConditionInfo.sParam1, 'NIGHT'{sNIGHT}) = 0 then begin
                if g_nGameTime <> 3 then Result := False;
              end;
            end;
          nCHECKLEVEL: if PlayObject.m_Abil.Level < QuestConditionInfo.nParam1 then Result := False;
          nCHECKJOB: begin
              if CompareLStr(QuestConditionInfo.sParam1, 'WARRIOR'{sWARRIOR}, 3) then begin
                if PlayObject.m_btJob <> 0 then Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, 'WIZARD'{sWIZARD}, 3) then begin
                if PlayObject.m_btJob <> 1 then Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, 'TAOIST'{sTAOS}, 3) then begin
                if PlayObject.m_btJob <> 2 then Result := False;
              end;
              {if CompareLStr(QuestConditionInfo.sParam1, 'ASSASSIN', 3) then begin//�̿�
                if PlayObject.m_btJob <> 3 then Result := False;
              end;}
            end;
          nCHECKBBCOUNT: if PlayObject.m_SlaveList.Count < QuestConditionInfo.nParam1 then Result := False;
          nCHECKITEM: begin
              s01 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1);//20080601 ֧�ֱ���
              n14 := Str_ToInt(GetLineVariableText(PlayObject, QuestConditionInfo.sParam2),0);//20080601 ֧�ֱ���
              UserItem := PlayObject.QuestCheckItem(s01, n1C, nMaxDura, nDura);
              if n1C < n14 then Result := False;
            end;
          nCHECKITEMW: begin
              UserItem := CheckItemW(QuestConditionInfo.sParam1, QuestConditionInfo.nParam2);
              if UserItem = nil then
                Result := False;
            end;
          nCHECKGOLD: begin
              s01 := QuestConditionInfo.sParam1;
              if (s01 <> '') and (s01[1] = '<') and (s01[2] = '$') then//����֧��<$Str()>  20080506
                 n14 := Str_ToInt(GetLineVariableText(PlayObject, QuestConditionInfo.sParam1),0)
              else
              if not GetValValue(PlayObject, QuestConditionInfo.sParam1, n14) then begin //���ӱ���֧��
                n14 := QuestConditionInfo.nParam1;
              end;
              if PlayObject.m_nGold < n14 then Result := False;
            end;
          nISTAKEITEM: if SC <> QuestConditionInfo.sParam1 then Result := False;
          nCHECKDURA: begin
              UserItem := PlayObject.QuestCheckItem(QuestConditionInfo.sParam1, n1C, nMaxDura, nDura);
              if Round(nDura / 1000) < QuestConditionInfo.nParam2 then Result := False;
            end;
          nCHECKDURAEVA: begin
              UserItem := PlayObject.QuestCheckItem(QuestConditionInfo.sParam1, n1C, nMaxDura, nDura);
              if n1C > 0 then begin
                if Round(nMaxDura / n1C / 1000) < QuestConditionInfo.nParam2 then Result := False;
              end else Result := False;
            end;
          nDAYOFWEEK: begin
              if CompareLStr(QuestConditionInfo.sParam1, 'SUN'{sSUN}, 3{Length(sSUN)}) then begin
                if DayOfWeek(Now) <> 1 then Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, 'MON'{sMON}, 3{Length(sMON)}) then begin
                if DayOfWeek(Now) <> 2 then Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, 'TUE'{sTUE}, 3{Length(sTUE)}) then begin
                if DayOfWeek(Now) <> 3 then Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, 'WED'{sWED}, 3{Length(sWED)}) then begin
                if DayOfWeek(Now) <> 4 then Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, 'THU'{sTHU}, 3{Length(sTHU)}) then begin
                if DayOfWeek(Now) <> 5 then Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, 'FRI'{sFRI}, 3{Length(sFRI)}) then begin
                if DayOfWeek(Now) <> 6 then Result := False;
              end;
              if CompareLStr(QuestConditionInfo.sParam1, 'SAT'{sSAT}, 3{Length(sSAT)}) then begin
                if DayOfWeek(Now) <> 7 then Result := False;
              end;
            end;
          nHOUR: begin
              if (QuestConditionInfo.nParam1 <> 0) and (QuestConditionInfo.nParam2 = 0) then
                QuestConditionInfo.nParam2 := QuestConditionInfo.nParam1;
              DecodeTime(Time, Hour, Min, Sec, MSec);
              if (Hour < QuestConditionInfo.nParam1) or (Hour > QuestConditionInfo.nParam2) then
                Result := False;
            end;
          nMIN: begin
              if (QuestConditionInfo.nParam1 <> 0) and (QuestConditionInfo.nParam2 = 0) then
                QuestConditionInfo.nParam2 := QuestConditionInfo.nParam1;
              DecodeTime(Time, Hour, Min, Sec, MSec);
              if (Min < QuestConditionInfo.nParam1) or (Min > QuestConditionInfo.nParam2) then
                Result := False;
            end;
          nCHECKPKPOINT: if not ConditionOfCHECKPKPOINT(PlayObject, QuestConditionInfo) then Result := False;//20080506
           { begin
              if not GetValValue(PlayObject, QuestConditionInfo.sParam1, n14) then begin //���ӱ���֧��
                n14 := QuestConditionInfo.nParam1;
              end;
              if PlayObject.PKLevel < n14 then Result := False;
            end;}
          nCHECKLUCKYPOINT: if PlayObject.m_nBodyLuckLevel < QuestConditionInfo.nParam1 then Result := False;
          nCHECKMONMAP: if not ConditionOfCheckMonMapCount(PlayObject, QuestConditionInfo) then Result := False;
          nCHECKHUM: begin
              if not GetValValue(PlayObject, QuestConditionInfo.sParam2, n14) then begin //���ӱ���֧��
                n14 := QuestConditionInfo.nParam2;
              end;
              if UserEngine.GetMapHuman(QuestConditionInfo.sParam1) < n14 then Result := False;
            end;

          nCHECKBAGGAGE: begin
              if PlayObject.IsEnoughBag then begin
                if QuestConditionInfo.sParam1 <> '' then begin
                  Result := False;
                  if not GetValValue(PlayObject, QuestConditionInfo.sParam1, s01) then begin //���ӱ���֧��
                    s01 := QuestConditionInfo.sParam1;
                  end;
                  StdItem := UserEngine.GetStdItem(s01);
                  if StdItem <> nil then begin
                    if PlayObject.IsAddWeightAvailable(StdItem.Weight) then
                      Result := True;
                  end;
                end;
              end else Result := False;
            end;
          nCHECKNAMELIST: if not CheckStringList(PlayObject.m_sCharName, m_sPath + QuestConditionInfo.sParam1) then Result := False;
          nCHECKACCOUNTLIST: if not CheckStringList(PlayObject.m_sUserID, m_sPath + QuestConditionInfo.sParam1) then Result := False;
          nCHECKIPLIST: if not CheckStringList(PlayObject.m_sIPaddr, m_sPath + QuestConditionInfo.sParam1) then Result := False;
          nEQUAL: begin
              if CheckVarNameNo(QuestConditionInfo, n14, n18) then begin//�Ƚ���ֵ
                if n14 <> n18 then Result := False else Result := True;//20080519
              end else begin//�Ƚ��ַ���
                if not GetValValue(PlayObject, QuestConditionInfo.sParam1, s01) then
                   s01 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1);//20080604 ֧�ֱ���
                if not GetValValue(PlayObject, QuestConditionInfo.sParam2, s02) then
                   s02 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam2);//20080604 ֧�ֱ���
                if CompareText(s01,s02)= 0 then Result := True
                else Result := False;
              end;
            end;
          nLARGE: begin
              if CheckVarNameNo(QuestConditionInfo, n14, n18) then begin
                if n14 <= n18 then Result := False;
              end else Result := False;
            end;
          nSMALL: begin
              if CheckVarNameNo(QuestConditionInfo, n14, n18) then begin
                if n14 >= n18 then Result := False;
              end else Result := False;
            end;
          nSC_ISSYSOP: if not (PlayObject.m_btPermission >= 4) then Result := False;
          nSC_ISADMIN: if not (PlayObject.m_btPermission >= 6) then Result := False;
          nSC_CHECKGROUPCOUNT: if not ConditionOfCheckGroupCount(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKPOSEDIR: if not ConditionOfCheckPoseDir(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKPOSELEVEL: if not ConditionOfCheckPoseLevel(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKPOSEGENDER: if not ConditionOfCheckPoseGender(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKLEVELEX: if not ConditionOfCheckLevelEx(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKBONUSPOINT: if not ConditionOfCheckBonusPoint(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKMARRY: if not ConditionOfCheckMarry(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKPOSEMARRY: if not ConditionOfCheckPoseMarry(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKMARRYCOUNT: if not ConditionOfCheckMarryCount(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKMASTER: if not ConditionOfCheckMaster(PlayObject, QuestConditionInfo) then Result := False;
          nSC_HAVEMASTER: if not ConditionOfHaveMaster(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKPOSEMASTER: if not ConditionOfCheckPoseMaster(PlayObject, QuestConditionInfo) then Result := False;
          nSC_POSEHAVEMASTER: if not ConditionOfPoseHaveMaster(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKISMASTER: if not ConditionOfCheckIsMaster(PlayObject, QuestConditionInfo) then Result := False;
          nSC_HASGUILD: if not ConditionOfCheckHaveGuild(PlayObject, QuestConditionInfo) then Result := False;

          nSC_ISGUILDMASTER: if not ConditionOfCheckIsGuildMaster(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKCASTLEMASTER: if not ConditionOfCheckIsCastleMaster(PlayObject, QuestConditionInfo) then Result := False;
          nSC_ISCASTLEGUILD: if not ConditionOfCheckIsCastleaGuild(PlayObject, QuestConditionInfo) then Result := False;
          nSC_ISATTACKGUILD: if not ConditionOfCheckIsAttackGuild(PlayObject, QuestConditionInfo) then Result := False;
          nSC_ISDEFENSEGUILD: if not ConditionOfCheckIsDefenseGuild(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKCASTLEDOOR: if not ConditionOfCheckCastleDoorStatus(PlayObject, QuestConditionInfo) then Result := False;
          nSC_ISATTACKALLYGUILD: if not ConditionOfCheckIsAttackAllyGuild(PlayObject, QuestConditionInfo) then Result := False;
          nSC_ISDEFENSEALLYGUILD: if not ConditionOfCheckIsDefenseAllyGuild(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKPOSEISMASTER: if not ConditionOfCheckPoseIsMaster(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKNAMEIPLIST: if not ConditionOfCheckNameIPList(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKACCOUNTIPLIST: if not ConditionOfCheckAccountIPList(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKSLAVECOUNT: if not ConditionOfCheckSlaveCount(PlayObject, QuestConditionInfo) then Result := False;
          nSC_ISNEWHUMAN: if not PlayObject.m_boNewHuman then Result := False;
          nSC_CHECKMEMBERTYPE: if not ConditionOfCheckMemberType(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKMEMBERLEVEL: if not ConditionOfCheckMemBerLevel(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKGAMEGOLD: if not ConditionOfCheckGameGold(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKSTRINGLENGTH: if not ConditionOfCHECKSTRINGLENGTH(PlayObject, QuestConditionInfo) then Result := False;//����ַ����ĳ��� 20090105
          //�����ʯ 20071226
          nSC_CHECKGAMEDIAMOND: if not ConditionOfCHECKGAMEDIAMOND(PlayObject, QuestConditionInfo) then Result := False;
          //������ 20071226
          nSC_CHECKGAMEGIRD: if not ConditionOfCHECKGAMEGIRD(PlayObject, QuestConditionInfo) then Result := False;
          //�������ֵ 20080511
          nSC_CHECKGAMEGLORY: if not ConditionOfCheckGameGLORY(PlayObject, QuestConditionInfo) then Result := False;
          //��鼼�ܵȼ� 20080512
          nSC_CHECKSKILLLEVEL: if not ConditionOfCHECKSKILLLEVEL(PlayObject, QuestConditionInfo) then Result := False;
          //����ͼָ������ָ�����ƹ������� 20080123
          nSC_CHECKMAPMOBCOUNT: if not ConditionOfCHECKMAPMOBCOUNT(PlayObject, QuestConditionInfo) then Result := False;
          //���������Χ�Լ��������� 20080425
          nSC_CHECKSIDESLAVENAME: if not ConditionOfCHECKSIDESLAVENAME(PlayObject, QuestConditionInfo) then Result := False;
          //��⵱ǰ�����Ƿ�С�ڴ��ڵ���ָ�������� 20080416
          nSC_CHECKCURRENTDATE: if not ConditionOfCHECKCURRENTDATE(PlayObject, QuestConditionInfo) then Result := False;
          //���ʦ������ͽ�ܣ��Ƿ�����  20080416
          nSC_CHECKMASTERONLINE: if not ConditionOfCHECKMASTERONLINE(PlayObject, QuestConditionInfo) then Result := False;
          //������һ���Ƿ�����  20080416
          nSC_CHECKDEARONLINE: if not ConditionOfCHECKDEARONLINE(PlayObject, QuestConditionInfo) then Result := False;
          //���ʦ������ͽ�ܣ��Ƿ���XXX��ͼ��֧��SELF���Ƿ�ͬһ��ͼ��  20080416
          nSC_CHECKMASTERONMAP: if not ConditionOfCHECKMASTERONMAP(PlayObject, QuestConditionInfo) then Result := False;
          //������һ���Ƿ���XXX��ͼ��֧��SELF���Ƿ�ͬһ��ͼ��  20080416
          nSC_CHECKDEARONMAP: if not ConditionOfCHECKDEARONMAP(PlayObject, QuestConditionInfo) then Result := False;
          //�������Ƿ�Ϊ�Լ���ͽ��  20080416
          nSC_CHECKPOSEISPRENTICE: if not ConditionOfCHECKPOSEISPRENTICE(PlayObject, QuestConditionInfo) then Result := False;
          //����Ƿ��ڹ����ڼ� 20080422
          nSC_CHECKCASTLEWAR: if not ConditionOfCHECKCASTLEWAR(PlayObject, QuestConditionInfo) then Result := False;

          nSC_FINDMAPPATH: if not ConditionOfFINDMAPPATH(PlayObject, QuestConditionInfo) then Result := False;//���õ�ͼ������XYֵ 20080124
          //���Ӣ�۵��ҳ϶� 20080109
          nSC_CHECKHEROLOYAL: if not ConditionOfCHECKHEROLOYAL(PlayObject, QuestConditionInfo) then Result := False;
          //�ж��Ƿ��������־� 20080620
          nISONMAKEWINE: if not ConditionOfISONMAKEWINE(PlayObject, QuestConditionInfo) then Result := False;
          //�ж��Ƿ����л�Ȫˮ�ֿ�  20080625
          nCHECKGUILDFOUNTAIN: if not ConditionOfCHECKGUILDFOUNTAIN(PlayObject, QuestConditionInfo) then Result := False;

          nSC_CHECKGAMEPOINT: if not ConditionOfCheckGamePoint(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKNAMELISTPOSITION: if not ConditionOfCheckNameListPostion(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKGUILDLIST: begin
              if PlayObject.m_MyGuild <> nil then begin
                if not CheckStringList(TGUild(PlayObject.m_MyGuild).sGuildName, m_sPath + QuestConditionInfo.sParam1) then Result := False;
              end else Result := False;
            end;
          nSC_CHECKRENEWLEVEL: if not ConditionOfCheckReNewLevel(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKSLAVELEVEL: if not ConditionOfCheckSlaveLevel(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKSLAVENAME: if not ConditionOfCheckSlaveName(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKCREDITPOINT: if not ConditionOfCheckCreditPoint(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKOFGUILD: if not ConditionOfCheckOfGuild(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKPAYMENT: if not ConditionOfCheckPayMent(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKUSEITEM: if not ConditionOfCheckUseItem(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKBAGSIZE: if not ConditionOfCheckBagSize(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKDC: if not ConditionOfCheckDC(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKMC: if not ConditionOfCheckMC(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKSC: if not ConditionOfCheckSC(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKHP: if not ConditionOfCheckHP(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKMP: if not ConditionOfCheckMP(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKITEMTYPE: if not ConditionOfCheckItemType(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKEXP: if not ConditionOfCheckExp(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKCASTLEGOLD: if not ConditionOfCheckCastleGold(PlayObject, QuestConditionInfo) then Result := False;
          nSC_PASSWORDERRORCOUNT: if not ConditionOfCheckPasswordErrorCount(PlayObject, QuestConditionInfo) then Result := False;
          nSC_ISLOCKPASSWORD: if not ConditionOfIsLockPassword(PlayObject, QuestConditionInfo) then Result := False;
          nSC_ISLOCKSTORAGE: if not ConditionOfIsLockStorage(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKBUILDPOINT: if not ConditionOfCheckGuildBuildPoint(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKAURAEPOINT: if not ConditionOfCheckGuildAuraePoint(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKSTABILITYPOINT: if not ConditionOfCheckStabilityPoint(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKFLOURISHPOINT: if not ConditionOfCheckFlourishPoint(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKCONTRIBUTION: if not ConditionOfCheckContribution(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKRANGEMONCOUNT: if not ConditionOfCheckRangeMonCount(PlayObject, QuestConditionInfo) then Result := False;
          //����ͼ����  20080426
          nSC_ISONMAP: if not ConditionOfISONMAP(PlayObject, QuestConditionInfo) then Result := False;
          //�������������Ʒ�ĸ�������ֵ  20080426
          nSC_CHECKITEMADDVALUE: if not ConditionOfCheckItemAddValue(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKINMAPRANGE: if not ConditionOfCheckInMapRange(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CASTLECHANGEDAY: if not ConditionOfCheckCastleChageDay(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CASTLEWARDAY: if not ConditionOfCheckCastleWarDay(PlayObject, QuestConditionInfo) then Result := False;
          nSC_ONLINELONGMIN: if not ConditionOfCheckOnlineLongMin(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKGUILDCHIEFITEMCOUNT: if not ConditionOfCheckChiefItemCount(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKNAMEDATELIST, nSC_CHECKUSERDATE: if not ConditionOfCheckNameDateList(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKMAPHUMANCOUNT: if not ConditionOfCheckMapHumanCount(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKMAPMONCOUNT: if not ConditionOfCheckMapMonCount(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKVAR: if not ConditionOfCheckVar(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKSERVERNAME: if not ConditionOfCheckServerName(PlayObject, QuestConditionInfo) then Result := False;
          nCHECKMAPNAME: if not ConditionOfCheckMapName(PlayObject, QuestConditionInfo) then Result := False;
          nINSAFEZONE: if not ConditionOfCheckSafeZone(PlayObject, QuestConditionInfo) then Result := False;
          nCHECKSKILL: if not ConditionOfCheckSkill(PlayObject, QuestConditionInfo) then Result := False;
          nHEROCHECKSKILL: if not ConditionOfHEROCHECKSKILL(PlayObject, QuestConditionInfo) then Result := False;//���Ӣ�ۼ��� 20080423
          nSC_CHECKCONTAINSTEXT: if not ConditionOfAnsiContainsText(PlayObject, QuestConditionInfo) then Result := False;
          nSC_COMPARETEXT: if not ConditionOfCompareText(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKTEXTLIST: begin//20080929 �޸�
              s01 := QuestConditionInfo.sParam1;
              if (s01 <> '') and (s01[1] = '<') and (s01[2] = '$') then//����֧��<$Str()>  20081230
                 s01 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1)
              else GetValValue(PlayObject, QuestConditionInfo.sParam1, s01);
              s02 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam2);//20090102 ·��֧�ֱ���
              if s02[1] = '\' then s02 := Copy(s02, 2, Length(s02) - 1);
              if s02[2] = '\' then s02 := Copy(s02, 3, Length(s02) - 2);
              if s02[3] = '\' then s02 := Copy(s02, 4, Length(s02) - 3);
              if not CheckStringList(s01, {m_sPath +} s02) then Result := False;
            end;
          nSC_ISGROUPMASTER: begin
              if PlayObject.m_GroupOwner <> nil then begin
                if PlayObject.m_GroupOwner <> PlayObject then
                  Result := False;
              end else Result := False;
            end;
          nSC_CHECKCONTAINSTEXTLIST: begin//20080929 �޸� �ж��ַ����������ļ���
              s01 := QuestConditionInfo.sParam1;
              GetValValue(PlayObject, QuestConditionInfo.sParam1, s01);
              if QuestConditionInfo.sParam2[1] = '\' then s02 := Copy(QuestConditionInfo.sParam2, 2, Length(QuestConditionInfo.sParam2) - 1);
              if QuestConditionInfo.sParam2[2] = '\' then s02 := Copy(QuestConditionInfo.sParam2, 3, Length(QuestConditionInfo.sParam2) - 2);
              if QuestConditionInfo.sParam2[3] = '\' then s02 := Copy(QuestConditionInfo.sParam2, 4, Length(QuestConditionInfo.sParam2) - 3);
              s02 := GetLineVariableText(PlayObject, s02);//20090102 ·��֧�ֱ���
              if not CheckAnsiContainsTextList(s01, {m_sPath +} s02) then Result := False;
            end;
          nSC_CHECKLISTTEXT:begin //����ļ��Ƿ����ָ���ı� 20080428
              s01 := QuestConditionInfo.sParam2;
              if (s01 <> '') and (s01[1] = '<') and (s01[2] = '$') then//����֧��<$Str()>
                 s01 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam2)
              else GetValValue(PlayObject, QuestConditionInfo.sParam2, s01);
              if QuestConditionInfo.sParam1[1] = '\' then s02 := Copy(QuestConditionInfo.sParam1, 2, Length(QuestConditionInfo.sParam1) - 1);
              if QuestConditionInfo.sParam1[2] = '\' then s02 := Copy(QuestConditionInfo.sParam1, 3, Length(QuestConditionInfo.sParam1) - 2);
              if QuestConditionInfo.sParam1[3] = '\' then s02 := Copy(QuestConditionInfo.sParam1, 4, Length(QuestConditionInfo.sParam1) - 3);
              s02 := GetLineVariableText(PlayObject, s02);//20080602 ·��֧�ֱ���
              if not CheckTextInList(s01, s02) then Result := False;
            end;
          nSC_CHECKONLINE: begin//�������Ƿ�����
              s01 := QuestConditionInfo.sParam1;
              if (s01 <> '') and (s01[1] = '<') and (s01[2] = '$') then//����֧��<$Str()> 20080422
                 s01 := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1)
              else GetValValue(PlayObject, QuestConditionInfo.sParam1, s01);
              if (s01 = '') or (UserEngine.GetPlayObject(s01) = nil) then Result := False;
            end;
          nSC_ISDUPMODE: begin
              if PlayObject.m_PEnvir <> nil then begin
                if PlayObject.m_PEnvir.GetXYObjCount(PlayObject.m_nCurrX, PlayObject.m_nCurrY) <= 1 then Result := False;
              end else Result := False;
            end;
          nSC_ISOFFLINEMODE: begin //����Ƿ������߹һ�����
              if not PlayObject.m_boNotOnlineAddExp then Result := False;
            end;
          nSC_CHECKSTATIONTIME: if not ConditionOfCheckStationTime(PlayObject, QuestConditionInfo) then Result := False; //�������վ��ʱ��
          nSC_CHECKSIGNMAP: if PlayObject.m_btLastOutStatus <> 1 then Result := False; //�������˳�״̬
          //=================================Ӣ�����=====================================
          nSC_HAVEHERO: if not ConditionOfCheckHasHero(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKHEROONLINE: if not ConditionOfCheckHeroOnline(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKHEROLEVEL: if not ConditionOfCheckHeroLevel(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKMINE: if not ConditionOfCHECKMINE(PlayObject, QuestConditionInfo) then Result := False;//���󴿶�  20080324

          //������� 20080807
          nSC_CHECKONLINEPLAYCOUNT: if not ConditionOfCHECKONLINEPLAYCOUNT(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKPLAYDIELVL,nSC_CHECKKILLPLAYLVL: if not ConditionOfCheckPlaylvl(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKPLAYDIEJOB,nSC_CHECKKILLPLAYJOB: if not ConditionOfCheckPlayJob(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHECKPLAYDIESEX,nSC_CHECKKILLPLAYSEX: if not ConditionOfCheckPlaySex(PlayObject, QuestConditionInfo) then Result := False;

          nSC_CHECKITEMLEVEL: if not ConditionOfCHECKITEMLEVEL(PlayObject, QuestConditionInfo) then Result := False;//���װ���������� 20080816
          nSC_CHECKMAKEWINE: if not ConditionOfCHECKMAKEWINE(PlayObject, QuestConditionInfo) then Result := False;//���Ƶ�Ʒ��  20080806
          nSC_CHECKHEROPKPOINT: if not ConditionOfCHECKHEROPKPOINT(PlayObject, QuestConditionInfo) then Result := False;//���Ӣ��PKֵ  20080304
          nSC_CHECKCODELIST: if not ConditionOfCHECKCODELIST(PlayObject, QuestConditionInfo) then Result := False;//����ı���ı����Ƿ����  20080410
          nCHECKITEMSTATE: if not ConditionOfCHECKITEMSTATE(PlayObject, QuestConditionInfo) then Result := False;//���װ����״̬  20080312
          nCHECKITEMSNAME: if not ConditionOfCHECKITEMSNAME(PlayObject, QuestConditionInfo) then Result := False;//���ָ��װ��λ���Ƿ����ָ������Ʒ 20080825
          nCHECKGUILDMEMBERCOUNT: if not ConditionOfCHECKGUILDMEMBERCOUNT(PlayObject, QuestConditionInfo) then Result := False;//����л��Ա���� 20090115
          nCHECKGUILDFOUNTAINVALUE: if not ConditionOfCHECKGUILDFOUNTAINValue(PlayObject, QuestConditionInfo) then Result := False;//����л��Ȫ��
          nCHECKNGLEVEL: if not ConditionOfCHECKNGLEVEL(PlayObject, QuestConditionInfo) then Result := False;//����ɫ�ڹ��ȼ� 20081223
          nKILLBYHUM: begin//����Ƿ�������ɱ 20080826
              if PlayObject.m_boDeath and (PlayObject.m_LastHiter <> nil) then begin
                if (PlayObject.m_LastHiter.m_btRaceServer <> RC_PLAYOBJECT) and (PlayObject.m_LastHiter.m_btRaceServer <> RC_HEROOBJECT) then Result := False;
              end else Result := False;
            end;
          nISHIGH: if not ConditionOfISHIGH(PlayObject, QuestConditionInfo) then Result := False;//����������������������� 20080313
          nSC_CHECKHEROJOB: if not ConditionOfCheckHeroJob(PlayObject, QuestConditionInfo) then Result := False;
          nSC_CHANGREADNG: if not ConditionOfCHANGREADNG(PlayObject, QuestConditionInfo) then Result := False;//����Ƿ�ѧ���ڹ� 20081002
       { else begin
            if Assigned(zPlugOfEngine.ConditionScriptProcess) then begin
              try
                if not zPlugOfEngine.ConditionScriptProcess(Self,
                  PlayObject,
                  QuestConditionInfo.nCMDCode,
                  PChar(QuestConditionInfo.sParam1),
                  QuestConditionInfo.nParam1,
                  PChar(QuestConditionInfo.sParam2),
                  QuestConditionInfo.nParam2,
                  PChar(QuestConditionInfo.sParam3),
                  QuestConditionInfo.nParam3,
                  PChar(QuestConditionInfo.sParam4),
                  QuestConditionInfo.nParam4,
                  PChar(QuestConditionInfo.sParam5),
                  QuestConditionInfo.nParam5,
                  PChar(QuestConditionInfo.sParam6),
                  QuestConditionInfo.nParam6) then Result := False;
              except
                Result := False;
              end;
            end;
          end;}
        end;
        if not Result then Break;
      end;
    end;
  end;
  function JmpToLable(sLabel: string): Boolean;
  begin
    Result := False;
    Inc(PlayObject.m_nScriptGotoCount);
    if PlayObject.m_nScriptGotoCount > g_Config.nScriptGotoCountLimit {10} then Exit;
    GotoLable(PlayObject, sLabel, False);
    Result := True;
  end;
  procedure GoToQuest(nQuest: Integer);
  var
    I: Integer;
    Script: pTScript;
  begin
    if m_ScriptList.Count > 0 then begin//20080629
      for I := 0 to m_ScriptList.Count - 1 do begin
        Script := m_ScriptList.Items[I];
        if Script.nQuest = nQuest then begin
          PlayObject.m_Script := Script;
          PlayObject.m_NPC := Self;
          GotoLable(PlayObject, sMAIN, False);
          Break;
        end;
      end;
    end;
  end;

  procedure AddList(sHumName, sListFileName: string); //0049B620
  var
    I: Integer;
    LoadList: TStringList;
    s10: string;
    bo15: Boolean;
  begin
    sListFileName := g_Config.sEnvirDir + sListFileName;
    LoadList := TStringList.Create;
    try
      if FileExists(sListFileName) then begin
        try
          LoadList.LoadFromFile(sListFileName);
        except
          MainOutMessage('�ļ���ȡʧ�� => ' + sListFileName);
        end;
      end;
      bo15 := False;
      if LoadList.Count > 0 then begin//20080629
        for I := 0 to LoadList.Count - 1 do begin
          s10 := Trim(LoadList.Strings[I]);
          if CompareText(sHumName, s10) = 0 then begin
            bo15 := True;
            Break;
          end;
        end;
      end;
      if not bo15 then begin
        LoadList.Add(sHumName);
        try
          LoadList.SaveToFile(sListFileName);
        except
          MainOutMessage('�ļ�����ʧ�� => ' + sListFileName);
        end;
      end;
    finally
      LoadList.Free;
    end;
  end;

  procedure DelList(sHumName, sListFileName: string);
  var
    I: Integer;
    LoadList: TStringList;
    s10: string;
    bo15: Boolean;
  begin
    sListFileName := g_Config.sEnvirDir + sListFileName;
    LoadList := TStringList.Create;
    if FileExists(sListFileName) then begin
      try
        LoadList.LoadFromFile(sListFileName);
      except
        MainOutMessage('�ļ���ȡʧ��.... => ' + sListFileName);
      end;
    end;
    bo15 := False;
    if LoadList.Count > 0 then begin//20080629
      for I := 0 to LoadList.Count - 1 do begin
        if LoadList.Count <= 0 then Break;
        s10 := Trim(LoadList.Strings[I]);
        if CompareText(sHumName, s10) = 0 then begin
          LoadList.Delete(I);
          bo15 := True;
          Break;
        end;
      end;
    end;
    if bo15 then begin
      try
        LoadList.SaveToFile(sListFileName);
      except
        MainOutMessage('�ļ�����ʧ�� => ' + sListFileName);
      end;
    end;
    LoadList.Free;
  end;

  procedure TakeItem(sItemName: string; nItemCount: Integer; sVarNo: string);
  var
    I: Integer;
    UserItem: pTUserItem;
    StdItem: pTStdItem;
    nCount: Integer;
    sName: string;
  begin
    PlayObject.m_boCanQueryBag:= True;//NPC������Ʒʱ,����ˢ�°��� 20080917
    Try
      //nCount := nItemCount;
      //sName := sItemName;
      sName := GetLineVariableText(PlayObject, sItemName);//20080601 ֧�ֱ���
      nCount := Str_ToInt(GetLineVariableText(PlayObject, sVarNo),0);//20080601 ֧�ֱ���
      //GetValValue(PlayObject, sItemName, sName); //���ӱ���֧��
      //GetValValue(PlayObject, sVarNo, nCount); //���ӱ���֧��
      if nCount <= 0 then Exit;
      if CompareText(sName, sSTRING_GOLDNAME) = 0 then begin
        PlayObject.DecGold(nCount);
        PlayObject.GoldChanged();
        if g_boGameLogGold then
          AddGameDataLog('10' + #9 + PlayObject.m_sMapName + #9 +
            IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
            PlayObject.m_sCharName + #9 + sSTRING_GOLDNAME + #9 +
            IntToStr(nCount) + #9 +'1' + #9 + m_sCharName);
        Exit;
      end;
      try
        for I := PlayObject.m_ItemList.Count - 1 downto 0 do begin
          if nCount <= 0 then Break;
          if PlayObject.m_ItemList.Count <= 0 then Break;//20080917
          UserItem := PlayObject.m_ItemList.Items[I];
          if UserItem = nil then Continue;
          if CompareText(UserEngine.GetStdItemName(UserItem.wIndex), sName) = 0 then begin
            StdItem := UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem <> nil then begin  //20081006 �޸�
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('10' + #9 + PlayObject.m_sMapName + #9 +
                  IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
                  PlayObject.m_sCharName + #9 + sName + #9 + IntToStr(UserItem.MakeIndex) + #9 +
                  '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                  '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                  '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                  '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                  '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                  IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                  IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                  IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                  IntToStr(UserItem.btValue[14])+ #9 + m_sCharName);
              PlayObject.m_ItemList.Delete(I);
              PlayObject.SendDelItems(UserItem);
              SC := StdItem.Name{UserEngine.GetStdItemName(UserItem.wIndex)};//20081006 �޸�
              DisPoseAndNil(UserItem);
              Dec(nCount);
            end;//if StdItem <> nil
          end;
        end;
      except
        MainOutMessage('{�쳣} TakeItem');
      end;
    finally
      PlayObject.m_boCanQueryBag:= False;//NPC������Ʒʱ,����ˢ�°��� 20080917
    end;
  end;

  procedure TakeWItem(sItemName: string; nItemCount: Integer);
  var
    I: Integer;
    sName: string;
  begin
    if CompareLStr(sItemName, '[NECKLACE]', 4) then begin
      if PlayObject.m_UseItems[U_NECKLACE].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_NECKLACE]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_NECKLACE].wIndex);
        PlayObject.m_UseItems[U_NECKLACE].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[RING]', 4) then begin
      if PlayObject.m_UseItems[U_RINGL].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_RINGL]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGL].wIndex);
        PlayObject.m_UseItems[U_RINGL].wIndex := 0;
        Exit;
      end;
      if PlayObject.m_UseItems[U_RINGR].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_RINGR]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGR].wIndex);
        PlayObject.m_UseItems[U_RINGR].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[ARMRING]', 4) then begin
      if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
        PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
        Exit;
      end;
      if PlayObject.m_UseItems[U_ARMRINGR].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ARMRINGR]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
        PlayObject.m_UseItems[U_ARMRINGR].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[WEAPON]', 4) then begin
      if PlayObject.m_UseItems[U_WEAPON].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_WEAPON]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
        PlayObject.m_UseItems[U_WEAPON].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[HELMET]', 4) then begin
      if PlayObject.m_UseItems[U_HELMET].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_HELMET]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HELMET].wIndex);
        PlayObject.m_UseItems[U_HELMET].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[ZHULI]', 4) then begin //20080416 ����
      if PlayObject.m_UseItems[U_ZHULI].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_ZHULI]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ZHULI].wIndex);
        PlayObject.m_UseItems[U_ZHULI].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[DRESS]', 4) then begin
      if PlayObject.m_UseItems[U_DRESS].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_DRESS]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_DRESS].wIndex);
        PlayObject.m_UseItems[U_DRESS].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BUJUK]', 4) then begin
      if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_BUJUK]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BUJUK].wIndex);
        PlayObject.m_UseItems[U_BUJUK].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BELT]', 4) then begin
      if PlayObject.m_UseItems[U_BELT].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_BELT]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BELT].wIndex);
        PlayObject.m_UseItems[U_BELT].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_BOOTS]', 4) then begin
      if PlayObject.m_UseItems[U_BOOTS].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_BOOTS]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BOOTS].wIndex);
        PlayObject.m_UseItems[U_BOOTS].wIndex := 0;
        Exit;
      end;
    end;
    if CompareLStr(sItemName, '[U_CHARM]', 4) then begin
      if PlayObject.m_UseItems[U_CHARM].wIndex > 0 then begin
        PlayObject.SendDelItems(@PlayObject.m_UseItems[U_CHARM]);
        SC := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CHARM].wIndex);
        PlayObject.m_UseItems[U_CHARM].wIndex := 0;
        Exit;
      end;
    end;
    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if nItemCount <= 0 then Exit;
      if PlayObject.m_UseItems[I].wIndex > 0 then begin
        sName := UserEngine.GetStdItemName(PlayObject.m_UseItems[I].wIndex);
        if CompareText(sName, sItemName) = 0 then begin
          PlayObject.SendDelItems(@PlayObject.m_UseItems[I]);
          PlayObject.m_UseItems[I].wIndex := 0;
          Dec(nItemCount);
        end;
      end;
    end;
  end;

  procedure MovData(QuestActionInfo: pTQuestActionInfo);
    function GetHumanInfoValue(sVariable: string; var sValue: string; var nValue: Integer; var nDataType: Integer): Boolean;
    var
      sMsg, s10: string;
      sVarValue2: string;
      I, nSecond:Integer;
      DynamicVar: pTDynamicVar;
      wHour,wMinute,wSecond: Word;
    begin
      sValue := '';
      nValue := -1;
      nDataType := -1;
      Result := False;
      if sVariable = '' then Exit;
      sMsg := sVariable;
      ArrestStringEx(sMsg, '<', '>', s10);
      if s10 = '' then Exit;
      sVariable := s10;

      //ȫ����Ϣ
      if sVariable = '$SERVERNAME' then begin
        sValue := g_Config.sServerName;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$SERVERIP' then begin
        sValue :=  g_Config.sServerIPaddr;
        nDataType := 0;
        Result := True;
        Exit;
      end;
     if sVariable = '$WEBSITE' then begin
        sValue :=  g_Config.sWebSite;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BBSSITE' then begin
        sValue := g_Config.sBbsSite;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$CLIENTDOWNLOAD' then begin
        sValue := g_Config.sClientDownload;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$QQ' then begin
        sValue := g_Config.sQQ;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$PHONE' then begin
        sValue := g_Config.sPhone;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BANKACCOUNT0' then begin
        sValue := g_Config.sBankAccount0;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BANKACCOUNT1' then begin
        sValue := g_Config.sBankAccount1;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BANKACCOUNT2' then begin
        sValue := g_Config.sBankAccount2;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BANKACCOUNT3' then begin
        sValue := g_Config.sBankAccount3;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BANKACCOUNT4' then begin
        sValue := g_Config.sBankAccount4;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BANKACCOUNT5' then begin
        sValue := g_Config.sBankAccount5;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BANKACCOUNT6' then begin
        sValue := g_Config.sBankAccount6;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BANKACCOUNT7' then begin
        sValue := g_Config.sBankAccount7;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BANKACCOUNT8' then begin
        sValue := g_Config.sBankAccount8;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$BANKACCOUNT9' then begin
        sValue := g_Config.sBankAccount9;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$GAMEGOLDNAME' then begin
        sValue := g_Config.sGameGoldName;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$GAMEDIAMONDNAME' then begin
        sValue := g_Config.sGameDiaMond;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$GAMEGIRDNAME' then begin
        sValue := g_Config.sGameGird;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$GAMEPOINTNAME' then begin
        sValue := g_Config.sGamePointName;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$USERCOUNT' then begin
        sValue := IntToStr(UserEngine.PlayObjectCount);
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$MACRUNTIME' then begin
        sValue := CurrToStr(GetTickCount / 86400000{(24 * 60 * 60 * 1000)});
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$SERVERRUNTIME' then begin
        nSecond := (GetTickCount() - g_dwStartTick) div 1000;
        wHour := nSecond div 3600;
        wMinute := (nSecond div 60) mod 60;
        wSecond := nSecond mod 60;
        sValue := Format('%d:%d:%d', [wHour, wMinute, wSecond]);
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$DATETIME' then begin
        sValue := FormatDateTime('dddddd,dddd,hh:mm:nn', Now);
        nDataType := 0;
        Result := True;
        Exit;
      end;   

      //������Ϣ
      if sVariable = '$USERNAME' then begin
        sValue := PlayObject.m_sCharName;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$KILLER' then begin//ɱ���߱��� 20080826
        if PlayObject.m_boDeath and (PlayObject.m_LastHiter <> nil) then begin
          if (PlayObject.m_LastHiter.m_btRaceServer = RC_PLAYOBJECT) then begin
            sValue := PlayObject.m_LastHiter.m_sCharName;
          end else
          if (PlayObject.m_LastHiter.m_btRaceServer = RC_HEROOBJECT) then begin
            if PlayObject.m_LastHiter.m_Master <> nil then
              sValue := PlayObject.m_LastHiter.m_Master.m_sCharName
            else sValue := 'δ֪';
          end;
        end else sValue := 'δ֪';
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$MONKILLER' then begin//ɱ�˵Ĺ������ 20080826
        if PlayObject.m_boDeath and (PlayObject.m_LastHiter <> nil) then begin
          if (PlayObject.m_LastHiter.m_btRaceServer <> RC_PLAYOBJECT) and (PlayObject.m_LastHiter.m_btRaceServer <> RC_HEROOBJECT) then begin
            sValue := PlayObject.m_LastHiter.m_sCharName;
          end;
        end else sValue := 'δ֪';
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$USERALLNAME' then begin//ȫ��  200080419
        sValue := PlayObject.GetShowName;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$SFNAME' then begin//ʦ����  200080603
        sValue := PlayObject.m_sMasterName;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$STATSERVERTIME' then begin //��ʾM2����ʱ��
        sValue := FrmMain.LbRunTime.Caption;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$RUNDATETIME' then begin //�������ʱ��
        sValue := FrmMain.LbTimeCount.Caption;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$RANDOMNO' then begin //���ֵ����
        nValue := Random(High(Integer));
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$USERID' then begin //��¼�˺�
        sValue := PlayObject.m_sUserID;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$IPADDR' then begin //��¼IP
        sValue := PlayObject.m_sIPaddr;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$X' then begin//����X����
        nValue := PlayObject.m_nCurrX;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$Y' then begin//����Y����
        nValue := PlayObject.m_nCurrY;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAP' then begin
        sValue := PlayObject.m_PEnvir.sMapName;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$GUILDNAME' then begin
        if PlayObject.m_MyGuild <> nil then begin
          sValue := TGUild(PlayObject.m_MyGuild).sGuildName;
        end else begin
          sValue := '��';
        end;
        nDataType := 0;
        Result := True;
        Exit;
      end;

      if sVariable = '$GUILDMEMBERCOUNT' then begin//�л��Ա���� 20090115
        if PlayObject.m_MyGuild <> nil then begin
          nValue := TGUild(PlayObject.m_MyGuild).m_nGuildMemberCount;
          nDataType := 1;
          Result := True;
          Exit;
        end;
      end;
      if sVariable = '$GUILDFOUNTAIN' then begin//�л�Ȫˮ�ֿ� 20080625
        if PlayObject.m_MyGuild <> nil then begin
          nValue := TGUild(PlayObject.m_MyGuild).m_nGuildFountain;
          nDataType := 1;
          Result := True;
          Exit;
        end;
      end;
      if sVariable = '$ALCOHOL' then begin//���� 20080627
          nValue := PlayObject.m_Abil.MaxAlcohol;
          nDataType := 1;
          Result := True;
          Exit;
      end;
      if sVariable = '$MEDICINEVALUE' then begin//ҩ��ֵ 20080627
          nValue := PlayObject.m_Abil.MedicineValue;
          nDataType := 1;
          Result := True;
          Exit;
      end;
      if sVariable = '$RANKNAME' then begin
        sValue := PlayObject.m_sGuildRankName;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$LEVEL' then begin
        nValue := PlayObject.m_Abil.Level;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$USEGAMEGIRD' then begin//ÿ��ʹ���������$USEGAMEGIRD����ʹ�� 20090108
        nValue := PlayObject.m_UseGameGird;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$BUYSHOP' then begin//ÿ�����̻���Ԫ������ 20090106
        nValue := PlayObject.m_BuyShopPrice;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$GETCRYSTALEXP' then begin//��ؽᾧ����ȡ�ľ��� 20090202
        nValue := PlayObject.m_nGetCrystalExp;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$GETCRYSTALNGEXP' then begin//��ؽᾧ����ȡ���ڹ����� 20090202
        nValue := PlayObject.m_nGetCrystalNGExp;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$CRYSTALEXP' then begin//��ؽᾧ��ǰ�ľ��� 20090202
        nValue := PlayObject.m_CrystalExp;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$CRYSTALNGEXP' then begin//��ؽᾧ��ǰ���ڹ����� 20090202
        nValue := PlayObject.m_CrystalNGExp;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$CRYSTALLEVEL' then begin//��ؽᾧ�ȼ� 20090202
        nValue := _MIN(5, PlayObject.m_CrystalLevel);
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$GETEXP' then begin//����ȡ�õľ��� 20081228
        nValue := PlayObject.m_GetExp;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$HEROGETEXP' then begin//Ӣ��ȡ�õľ��� 20081228
        if PlayObject.m_MyHero <> nil then begin
          nValue := THeroObject(PlayObject.m_MyHero).m_GetExp;
        end else nValue := 0;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$GLORYPOINT' then begin//��������ֵ 20080512
        nValue := PlayObject.m_btGameGlory;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$HP' then begin
        nValue := PlayObject.m_WAbil.HP;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXHP' then begin
        nValue := PlayObject.m_WAbil.MaxHP;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MP' then begin
        nValue := PlayObject.m_WAbil.MP;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXMP' then begin
        nValue := PlayObject.m_WAbil.MaxMP;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$AC' then begin
        nValue := LoWord(PlayObject.m_WAbil.AC);
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXAC' then begin
        nValue := HiWord(PlayObject.m_WAbil.AC);
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAC' then begin
        nValue := LoWord(PlayObject.m_WAbil.MAC);
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXMAC' then begin
        nValue := HiWord(PlayObject.m_WAbil.MAC);
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$DC' then begin
        nValue := LoWord(PlayObject.m_WAbil.DC);
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXDC' then begin
        nValue := HiWord(PlayObject.m_WAbil.DC);
        nDataType := 1;
        Result := True;
        Exit;
      end;

      if sVariable = '$MC' then begin
        nValue := LoWord(PlayObject.m_WAbil.MC);
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXMC' then begin
        nValue := HiWord(PlayObject.m_WAbil.MC);
        nDataType := 1;
        Result := True;
        Exit;
      end;

      if sVariable = '$SC' then begin
        nValue := LoWord(PlayObject.m_WAbil.SC);
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXSC' then begin
        nValue := HiWord(PlayObject.m_WAbil.SC);
        nDataType := 1;
        Result := True;
        Exit;
      end;

      if sVariable = '$EXP' then begin
        nValue := PlayObject.m_Abil.Exp;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXEXP' then begin
        nValue := PlayObject.m_Abil.MaxExp;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$PKPOINT' then begin
        nValue := PlayObject.m_nPkPoint;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$CREDITPOINT' then begin
        nValue := PlayObject.m_btCreditPoint;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$HW' then begin
        nValue := PlayObject.m_WAbil.HandWeight;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXHW' then begin
        nValue := PlayObject.m_WAbil.MaxHandWeight;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$BW' then begin
        nValue := PlayObject.m_WAbil.Weight;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXBW' then begin
        nValue := PlayObject.m_WAbil.MaxWeight;
        nDataType := 1;
        Result := True;
        Exit;
      end;

      if sVariable = '$WW' then begin
        nValue := PlayObject.m_WAbil.WearWeight;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$MAXWW' then begin
        nValue := PlayObject.m_WAbil.MaxWearWeight;
        nDataType := 1;
        Result := True;
        Exit;
      end;

      if sVariable = '$GOLDCOUNT' then begin
        nValue := PlayObject.m_nGold;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$GAMEGOLD' then begin
        nValue := PlayObject.m_nGameGold;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$GAMEDIAMOND' then begin //20071226 ���ʯ
        nValue := PlayObject.m_nGameDiaMond;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$GAMEGIRD' then begin //20071226 ���
        nValue := PlayObject.m_nGameGird;
        nDataType := 1;
        Result := True;
        Exit;
      end;

      if CompareLStr(sVariable, '$HUMAN', 6{Length('$HUMAN')}) then begin //20080315 �������
        ArrestStringEx(sVariable, '(', ')', sVarValue2);
        if PlayObject.m_DynamicVarList.Count > 0 then begin//20080629
          for I := 0 to PlayObject.m_DynamicVarList.Count - 1 do begin
            DynamicVar := PlayObject.m_DynamicVarList.Items[I];
            if CompareText(DynamicVar.sName, sVarValue2) = 0 then begin
              case DynamicVar.VarType of
                vInteger:begin
                    nValue := DynamicVar.nInternet;
                    nDataType := 1;
                    Result := True;
                    Exit;
                   end;
                vString: ;
              end;
              Break;
            end;
          end;//for
        end;
      end;
      if sVariable = '$GAMEPOINT' then begin
        nValue := PlayObject.m_nGamePoint;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$HUNGER' then begin
        nValue := PlayObject.GetMyStatus;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$LOGINTIME' then begin
        sValue := DateTimeToStr(PlayObject.m_dLogonTime);
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$DATETIME' then begin
        sValue := FormatDateTime('dddddd,dddd,hh:mm:nn', Now);
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$LOGINLONG' then begin
        nValue := (GetTickCount - PlayObject.m_dwLogonTick) div 60000;
        nDataType := 1;
        Result := True;
        Exit;
      end;
      if sVariable = '$DRESS' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_DRESS].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$WEAPON' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_WEAPON].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$RIGHTHAND' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RIGHTHAND].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$HELMET' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_HELMET].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$ZHULI' then begin //20080416 ����
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ZHULI].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$NECKLACE' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_NECKLACE].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$RING_R' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGR].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$RING_L' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_RINGL].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$ARMRING_R' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGR].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$ARMRING_L' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$BUJUK' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BUJUK].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$BELT' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BELT].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$BOOTS' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_BOOTS].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$CHARM' then begin
        sValue := UserEngine.GetStdItemName(PlayObject.m_UseItems[U_CHARM].wIndex);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$IPADDR' then begin
        sValue := PlayObject.m_sIPaddr;
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$IPLOCAL' then begin
        sValue := PlayObject.m_sIPLocal; // GetIPLocal(PlayObject.m_sIPaddr);
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$GUILDBUILDPOINT' then begin
        if PlayObject.m_MyGuild <> nil then begin
          nValue := TGUild(PlayObject.m_MyGuild).nBuildPoint;
        end;
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$GUILDAURAEPOINT' then begin
        if PlayObject.m_MyGuild <> nil then begin
          nValue := TGUild(PlayObject.m_MyGuild).nAurae;
        end;
        nDataType := 0;
        Result := True;
        Exit;
      end else
        if sVariable = '$GUILDSTABILITYPOINT' then begin
        if PlayObject.m_MyGuild <> nil then begin
          nValue := TGUild(PlayObject.m_MyGuild).nStability;
        end;
        nDataType := 0;
        Result := True;
        Exit;
      end;
      if sVariable = '$GUILDFLOURISHPOINT' then begin
        if PlayObject.m_MyGuild <> nil then begin
          nValue := TGUild(PlayObject.m_MyGuild).nFlourishing;
        end;
        nDataType := 0;
        Result := True;
        Exit;
      end;
    end;

    function SetValNameValue(sVarName: string; sValue: string; nValue: Integer; nDataType: Integer): Boolean;
    var
      n100: Integer;
    begin
      n100 := GetValNameNo(sVarName);
      if n100 >= 0 then begin
        case nDataType of
          1: begin
              case n100 of
                0..99: begin //20080323 ԭΪ0..99
                    PlayObject.m_nVal[n100] := nValue;
                    Result := True;
                  end;
                100..199: begin
                    g_Config.GlobalVal[n100 - 100] := nValue;
                    Result := True;
                  end;
                200..299: begin //20080323 ԭΪ200..209
                    PlayObject.m_DyVal[n100 - 200] := nValue;
                    Result := True;
                  end;
                300..399: begin
                    PlayObject.m_nMval[n100 - 300] := nValue;
                    Result := True;
                  end;
                400..499: begin
                    g_Config.GlobaDyMval[n100 - 400] := nValue;
                    Result := True;
                  end;
                500..599: begin
                    PlayObject.m_nInteger[n100 - 500] := nValue;
                    Result := True;
                  end;
                600..699: begin //20080506 ����
                    PlayObject.m_sString[n100 - 600] := IntToStr(nValue);
                    Result := True;
                  end;
                700..799: begin //20080506 ����
                    g_Config.GlobalAVal[n100 - 700] := IntToStr(nValue);
                    Result := True;
                  end;
                800..1199:begin//20080903 G����
                    g_Config.GlobalVal[n100 - 700] := nValue;
                    Result := True;
                  end;
                1200..1599:begin//20080903 A����(100-499)
                    g_Config.GlobalAVal[n100 - 1100] := IntToStr(nValue);
                    Result := True;
                  end;
              else begin
                  Result := False;
                end;
              end;
            end;
          0: begin
              case n100 of
                0..99: begin //20090102 ����
                    PlayObject.m_nVal[n100] := Str_ToInt(sValue, 0);
                    Result := True;
                  end;
                100..199: begin
                    g_Config.GlobalVal[n100 - 100] := Str_ToInt(sValue, 0);
                    Result := True;
                  end;
                200..299: begin
                    PlayObject.m_DyVal[n100 - 200] := Str_ToInt(sValue, 0);
                    Result := True;
                  end;
                300..399: begin
                    PlayObject.m_nMval[n100 - 300] := Str_ToInt(sValue, 0);
                    Result := True;
                  end;
                400..499: begin
                    g_Config.GlobaDyMval[n100 - 400] := Str_ToInt(sValue, 0);
                    Result := True;
                  end;
                500..599: begin
                    PlayObject.m_nInteger[n100 - 500] := Str_ToInt(sValue, 0);
                    Result := True;
                  end;
                600..699: begin
                    PlayObject.m_sString[n100 - 600] := sValue;
                    Result := True;
                  end;
                700..799: begin
                    g_Config.GlobalAVal[n100 - 700] := sValue;
                    Result := True;
                  end;
                800..1199:begin
                    g_Config.GlobalVal[n100 - 700] := Str_ToInt(sValue, 0);
                    Result := True;
                  end;
                1200..1599:begin//20080903 A����(100-499)
                    g_Config.GlobalAVal[n100 - 1100] := sValue;
                    Result := True;
                  end;
              else begin
                  Result := False;
                end;
              end;
            end;
          3: begin
              case n100 of
                0..99: begin //20080323 ԭΪ0..99
                    PlayObject.m_nVal[n100] := nValue;
                    Result := True;
                  end;
                100..199: begin
                    g_Config.GlobalVal[n100 - 100] := nValue;
                    Result := True;
                  end;
                200..299: begin //20080323 ԭΪ200..209
                    PlayObject.m_DyVal[n100 - 200] := nValue;
                    Result := True;
                  end;
                300..399: begin
                    PlayObject.m_nMval[n100 - 300] := nValue;
                    Result := True;
                  end;
                400..499: begin
                    g_Config.GlobaDyMval[n100 - 400] := nValue;
                    Result := True;
                  end;
                500..599: begin
                    PlayObject.m_nInteger[n100 - 500] := nValue;
                    Result := True;
                  end;
                600..699: begin
                    PlayObject.m_sString[n100 - 600] := sValue;
                    Result := True;
                  end;
                700..799: begin
                    g_Config.GlobalAVal[n100 - 700] := sValue;
                    Result := True;
                  end;
                800..1199:begin//20080903 G����
                    g_Config.GlobalVal[n100 - 700] := nValue;
                    Result := True;
                  end;                  
                1200..1599:begin//20080903 A����(100-499)
                    g_Config.GlobalAVal[n100 - 1100] := sValue;
                    Result := True;
                  end;
              else begin
                  Result := False;
                end;
              end;
            end;
        end;
      end else Result := False;
    end;
    function GetValNameValue(sVarName: string; var sValue: string; var nValue: Integer; var nDataType: Integer): Boolean;
    var
      n100: Integer;
    begin
      nValue := -1;
      sValue := '';
      nDataType := -1;
      n100 := GetValNameNo(sVarName);
      if n100 >= 0 then begin
        case n100 of
          0..99: begin //20080323 ԭΪ0..99
              nValue := PlayObject.m_nVal[n100];
              nDataType := 1;
              Result := True;
            end;
          100..199: begin
              nValue := g_Config.GlobalVal[n100 - 100];
              nDataType := 1;
              Result := True;
            end;
          200..299: begin //20080323 ԭΪ200..209
              nValue := PlayObject.m_DyVal[n100 - 200];
              nDataType := 1;
              Result := True;
            end;
          300..399: begin
              nValue := PlayObject.m_nMval[n100 - 300];
              nDataType := 1;
              Result := True;
            end;
          400..499: begin
              nValue := g_Config.GlobaDyMval[n100 - 400];
              nDataType := 1;
              Result := True;
            end;
          500..599: begin
              nValue := PlayObject.m_nInteger[n100 - 500];
              nDataType := 1;
              Result := True;
            end;
          600..699: begin
              sValue := PlayObject.m_sString[n100 - 600];
              nDataType := 0;
              Result := True;
            end;
          700..799: begin
              sValue := g_Config.GlobalAVal[n100 - 700];
              nDataType := 0;
              Result := True;
            end;
          800..1199:begin//20080903 G����
              nValue := g_Config.GlobalVal[n100 - 700];
              nDataType := 1;
              Result := True;
            end;
          1200..1599:begin//20080903 A����(100-499)
              sValue := g_Config.GlobalAVal[n100 - 1100];
              nDataType := 0;
              Result := True;
            end;
        else begin
            Result := False;
          end;
        end;
      end else Result := False;
    end;

    function GetDynamicVarValue(sVarType, sVarName: string; var sValue: string; var nValue: Integer; var nDataType: Integer): Boolean;
    var
      V: Integer;
      DynamicVar: pTDynamicVar;
      DynamicVarList: TList;
      sName: string;
      boVarFound: Boolean;
    begin
      boVarFound := False;
      sValue := '';
      nValue := -1;
      nDataType := -1;
      DynamicVarList := GetDynamicVarList(PlayObject, sVarType, sName);
      if DynamicVarList = nil then begin
        Result := False;
        Exit;
      end;
      if DynamicVarList.Count > 0 then begin//20080629
        for V := 0 to DynamicVarList.Count - 1 do begin
          DynamicVar := DynamicVarList.Items[V];
          if CompareText(DynamicVar.sName, sVarName) = 0 then begin
            case DynamicVar.VarType of
              vInteger: begin
                  nValue := DynamicVar.nInternet;
                  nDataType := 1;
                end;
              vString: begin
                  sValue := DynamicVar.sString;
                  nDataType := 0;
                end;
            end;
            boVarFound := True;
            Break;
          end;
        end;//for
      end;
      if not boVarFound then Result := False else Result := True;
    end;

    function SetDynamicVarValue(sVarType, sVarName: string; sValue: string; nValue: Integer; nDataType: Integer): Boolean;
    var
      V: Integer;
      DynamicVar: pTDynamicVar;
      DynamicVarList: TList;
      sName: string;
      boVarFound: Boolean;
    begin
      boVarFound := False;
      DynamicVarList := GetDynamicVarList(PlayObject, sVarType, sName);
      if DynamicVarList = nil then begin
        Result := False;
        Exit;
      end;
      if DynamicVarList.Count > 0 then begin//20080629
        for V := 0 to DynamicVarList.Count - 1 do begin
          DynamicVar := DynamicVarList.Items[V];
          if CompareText(DynamicVar.sName, sVarName) = 0 then begin
            if nDataType = 1 then begin
              case DynamicVar.VarType of
                vInteger: begin
                    DynamicVar.nInternet := nValue;
                    boVarFound := True;
                    Break;
                  end;
              end;
            end else begin
              case DynamicVar.VarType of
                vString: begin
                    DynamicVar.sString := sValue;
                    boVarFound := True;
                    Break;
                  end;
              end;
            end;
          end;
        end;//for
      end;
      if not boVarFound then Result := False else Result := True;
    end;

    function GetDataType: Integer; //
    var
      sParam1: string;
      sParam2: string;
      sParam3: string;
      n01: Integer;
    begin
      Result := -1;
      if CompareLStr(QuestActionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
        ArrestStringEx(QuestActionInfo.sParam1, '(', ')', sParam1)
      else sParam1 := QuestActionInfo.sParam1;

      if CompareLStr(QuestActionInfo.sParam2, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
        ArrestStringEx(QuestActionInfo.sParam2, '(', ')', sParam2)
      else sParam2 := QuestActionInfo.sParam2;

      if CompareLStr(QuestActionInfo.sParam3, '<$STR(', 6{Length('<$STR(')}) then  //20080228 ֧���ַ�������
        ArrestStringEx(QuestActionInfo.sParam3, '(', ')', sParam3)
      else sParam3 := QuestActionInfo.sParam3;

     { sParam1 := QuestActionInfo.sParam1; //20080228
      sParam2 := QuestActionInfo.sParam2;
      sParam3 := QuestActionInfo.sParam3;}
      if IsVarNumber(sParam1) then begin
        if (sParam3 <> '') and (sParam3[1] = '<') and (sParam3[Length(sParam3)] = '>') {TagCount(sParam3, '>') > 0} then begin
          Result := 0;
        end else
          if (sParam3 <> '') and (GetValNameNo(sParam3) >= 0) then begin
          Result := 1;
        end else
          if (sParam3 <> '') and IsStringNumber(sParam3) then begin
          Result := 2;
        end else begin
          Result := 3;
        end;
        Exit;
      end;
      n01 := GetValNameNo(sParam1);
      if n01 >= 0 then begin
        if (sParam2 <> '') and (sParam2[1] = '<') and (sParam2[Length(sParam2)] = '>') then begin
          Result := 4;
        end else
          if (sParam2 <> '') and (GetValNameNo(sParam2) >= 0) then begin
          Result := 5;
        end else
          if (sParam2 <> '') and IsVarNumber(sParam2) then begin
          Result := 6;
        end else begin
          Result := 7;
        end;
        Exit;
      end;
    end;
  var
    sParam1: string;
    sParam2: string;
    sParam3: string;
    sValue: string;
    nValue: Integer;
    nDataType: Integer;
  resourcestring
    sVarFound = '����%s�����ڣ���������:%s';
    sVarTypeError = '�������ʹ��󣬴�������:%s ��ǰ֧������(HUMAN��GUILD��GLOBAL)';
    sDataTypeError = '�������Ͳ�һ�£���������:%s %s';
  begin
    if CompareLStr(QuestActionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
      ArrestStringEx(QuestActionInfo.sParam1, '(', ')', sParam1)
    else sParam1 := QuestActionInfo.sParam1;

    if CompareLStr(QuestActionInfo.sParam2, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
      ArrestStringEx(QuestActionInfo.sParam2, '(', ')', sParam2)
    else sParam2 := QuestActionInfo.sParam2;

    if CompareLStr(QuestActionInfo.sParam3, '<$STR(', 6{Length('<$STR(')}) then  //20080228 ֧���ַ�������
      ArrestStringEx(QuestActionInfo.sParam3, '(', ')', sParam3)
    else sParam3 := QuestActionInfo.sParam3;

    {sParam1 := QuestActionInfo.sParam1; //20080228
    sParam2 := QuestActionInfo.sParam2;
    sParam3 := QuestActionInfo.sParam3;}
    if sParam1 = '' then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
      Exit;
    end;
    case GetDataType of
      0: begin
          if GetHumanInfoValue(sParam3, sValue, nValue, nDataType) then begin
            if not SetDynamicVarValue(sParam1, sParam2, sValue, nValue, nDataType) then
              ScriptActionError(PlayObject, Format(sVarFound, [sParam1, sParam2]), QuestActionInfo, sMOV);
          end else begin
            ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
          end;
          Exit;
        end;
      1: begin
          if GetValNameValue(sParam3, sValue, nValue, nDataType) then begin
            if not SetDynamicVarValue(sParam1, sParam2, sValue, nValue, nDataType) then
              ScriptActionError(PlayObject, Format(sVarFound, [sParam1, sParam2]), QuestActionInfo, sMOV);
          end else begin
            ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
          end;
          Exit;
        end;
      2: begin
          if not SetDynamicVarValue(sParam1, sParam2, QuestActionInfo.sParam3, QuestActionInfo.nParam3, 1) then
            ScriptActionError(PlayObject, Format(sVarFound, [sParam1, sParam2]), QuestActionInfo, sMOV);
        end;
      3: begin
          if not SetDynamicVarValue(sParam1, sParam2, QuestActionInfo.sParam3, QuestActionInfo.nParam3, 0) then
            ScriptActionError(PlayObject, Format(sVarFound, [sParam1, sParam2]), QuestActionInfo, sMOV);
        end;
      //==============================================================================
      4: begin
          if GetHumanInfoValue(sParam2, sValue, nValue, nDataType) then begin
            if not SetValNameValue(sParam1, sValue, nValue, nDataType) then
              ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
          end else begin
            ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
          end;
          Exit;
        end;
      5: begin
          if GetValNameValue(sParam2, sValue, nValue, nDataType) then begin
            if not SetValNameValue(sParam1, sValue, nValue, nDataType) then
              ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
          end else begin
            ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
          end;
          Exit;
        end;
      6: begin
          if GetDynamicVarValue(sParam2, sParam3, sValue, nValue, nDataType) then begin
            if not SetValNameValue(sParam1, sValue, nValue, nDataType) then
              ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
          end else begin
            ScriptActionError(PlayObject, Format(sVarFound, [sParam2, sParam3]), QuestActionInfo, sMOV);
          end;
          Exit;
        end;
      7: begin
          if GetValNameValue(sParam1, sValue, nValue, nDataType) then begin
            if (sParam2 <> '') and (sParam2[1]= '<') and (sParam2[2]= '$') then begin //20080407 ֧��:MOV A14 <$USERALLNAME>\���µ�һսʿ �Ĵ�ֵ
              GetHumanInfoValue(sParam2, sValue, nValue, nDataType);//ȡ������Ϣ
              sValue :=sValue + copy(sParam2,pos('\',sParam2),length(sParam2)-pos('\',sParam2)+1);
              if not SetValNameValue(sParam1, sValue, nValue, nDataType) then begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
                Exit;
              end;
            end else begin
              if not SetValNameValue(sParam1, QuestActionInfo.sParam2, QuestActionInfo.nParam2, nDataType) then begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
                Exit;
              end;
            end;
          end else begin
            ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
          end;
        end;
      {8: begin
          if not SetValNameValue(sParam1, QuestActionInfo.sParam2, QuestActionInfo.nParam2, 0) then begin
            ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
          end else begin
            ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
          end;
          Exit;
        end;}
    else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sMOV);
      end;
    end;
  end;

  procedure IncInteger(QuestActionInfo: pTQuestActionInfo);
  var
    I, n14, n3C, n10: Integer;
    s01: string;
    DynamicVar: pTDynamicVar;
    DynamicVarList: TList;
    sName: string;
    boVarFound: Boolean;
    sParam1: string;
    sParam2: string;
    sParam3: string;
  resourcestring
    sVarFound = '����%s�����ڣ���������:%s';
    sVarTypeError = '�������ʹ��󣬴�������:%s ��ǰ֧������(HUMAN��GUILD��GLOBAL)';
  begin
    n10 := 0;
    if CompareLStr(QuestActionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then//20080228 ֧���ַ�������
      ArrestStringEx(QuestActionInfo.sParam1, '(', ')', sParam1)
    else sParam1 := QuestActionInfo.sParam1;

    if CompareLStr(QuestActionInfo.sParam2, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
      ArrestStringEx(QuestActionInfo.sParam2, '(', ')', sParam2)
    else sParam2 := QuestActionInfo.sParam2;

    if CompareLStr(QuestActionInfo.sParam3, '<$STR(', 6{Length('<$STR(')}) then  //20080228 ֧���ַ�������
      ArrestStringEx(QuestActionInfo.sParam3, '(', ')', sParam3)
    else sParam3 := QuestActionInfo.sParam3;

   { sParam1 := QuestActionInfo.sParam1;//20080228
    sParam2 := QuestActionInfo.sParam2;
    sParam3 := QuestActionInfo.sParam3;}
    if (sParam1 = '') or (sParam2 = '') then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
      Exit;
    end;
    if sParam3 <> '' then begin
      if (not IsVarNumber(sParam1)) and (IsVarNumber(sParam2)) then begin
        n10 := 1;
        boVarFound := False;
        DynamicVarList := GetDynamicVarList(PlayObject, sParam2, sName);
        if DynamicVarList = nil then begin
          ScriptActionError(PlayObject, Format(sVarTypeError, [sParam2]), QuestActionInfo, sINC);
          Exit;
        end;
        if DynamicVarList.Count > 0 then begin//20080629
          for I := 0 to DynamicVarList.Count - 1 do begin
            DynamicVar := DynamicVarList.Items[I];
            if CompareText(DynamicVar.sName, sParam3) = 0 then begin
              case DynamicVar.VarType of
                vInteger: begin
                    n3C := DynamicVar.nInternet;
                  end;
                vString: begin
                    s01 := DynamicVar.sString;
                  end;
              end;
              boVarFound := True;
              Break;
            end;
          end;//for
        end;
        if not boVarFound then begin
          ScriptActionError(PlayObject, Format(sVarFound, [sParam3, sParam2]), QuestActionInfo, sINC);
          Exit;
        end;
        n14 := GetValNameNo(sParam1);
        if n14 >= 0 then begin
          case n14 of
            0..99: begin //20080323 ԭΪ0..99
                if n3C > 1 then begin
                  Inc(PlayObject.m_nVal[n14], n3C);
                end else begin
                  Inc(PlayObject.m_nVal[n14]);
                end;
              end;
            100..199: begin
                if n3C > 1 then begin
                  Inc(g_Config.GlobalVal[n14 - 100], n3C);
                end else begin
                  Inc(g_Config.GlobalVal[n14 - 100]);
                end;
              end;
            200..299: begin //20080323 ԭΪ200..209
                if n3C > 1 then begin
                  Inc(PlayObject.m_DyVal[n14 - 200], n3C);
                end else begin
                  Inc(PlayObject.m_DyVal[n14 - 200]);
                end;
              end;
            300..399: begin
                if n3C > 1 then begin
                  Inc(PlayObject.m_nMval[n14 - 300], n3C);
                end else begin
                  Inc(PlayObject.m_nMval[n14 - 300]);
                end;
              end;
            400..499: begin
                if n3C > 1 then begin
                  Inc(g_Config.GlobaDyMval[n14 - 400], n3C);
                end else begin
                  Inc(g_Config.GlobaDyMval[n14 - 400]);
                end;
              end;
            500..599: begin
                if n3C > 1 then begin
                  Inc(PlayObject.m_nInteger[n14 - 500], n3C);
                end else begin
                  Inc(PlayObject.m_nInteger[n14 - 500]);
                end;
              end;
            600..699: begin
                PlayObject.m_sString[n14 - 600]:= PlayObject.m_sString[n14 - 600]+ s01;
              end;
            700..799: begin
                g_Config.GlobalAVal[n14 - 700]:= g_Config.GlobalAVal[n14 - 700]+ s01;
              end;
            800..1199:begin//20080903 G����
                if n3C > 1 then begin
                  Inc(g_Config.GlobalVal[n14 - 700], n3C);
                end else begin
                  Inc(g_Config.GlobalVal[n14 - 700]);
                end;
              end;
            1200..1599:begin//20080903 A����(100-499)
                g_Config.GlobalAVal[n14 - 1100]:= g_Config.GlobalAVal[n14 - 1100]+ s01;
              end;
          else begin
              ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
              Exit;
            end;
          end;
        end else begin
          ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
          Exit;
        end;
        Exit;
      end;
      if (IsVarNumber(sParam1)) and (not IsVarNumber(sParam2)) then begin
        if (sParam3 <> '') and (not IsStringNumber(sParam3)) then begin
          n10 := 1;
          n14 := GetValNameNo(sParam3);
          if n14 >= 0 then begin
            case n14 of
              0..99: begin //20080323 ԭΪ0..99
                  n3C := PlayObject.m_nVal[n14];
                end;
              100..199: begin
                  n3C := g_Config.GlobalVal[n14 - 100];
                end;
              200..299: begin //20080323 ԭΪ200..209
                  n3C := PlayObject.m_DyVal[n14 - 200];
                end;
              300..399: begin
                  n3C := PlayObject.m_nMval[n14 - 300];
                end;
              400..499: begin
                  n3C := g_Config.GlobaDyMval[n14 - 400];
                end;
              500..599: begin
                  n3C := PlayObject.m_nInteger[n14 - 500];
                end;
              600..699: begin
                  s01 := PlayObject.m_sString[n14 - 600];
                end;
              700..799: begin
                  s01 := g_Config.GlobalAVal[n14 - 700];
                end;
              800..1199:begin//20080903 G����
                  n3C := g_Config.GlobalVal[n14 - 700];
                end;
              1200..1599:begin//20080903 A����(100-499)
                  s01 := g_Config.GlobalAVal[n14 - 1100];
                end;
            else begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
                Exit;
              end;
            end;
          end else begin
            s01 := sParam3;//20080530
          end;
        end else n3C := QuestActionInfo.nParam3;
        boVarFound := False;
        DynamicVarList := GetDynamicVarList(PlayObject, sParam1, sName);
        if DynamicVarList = nil then begin
          ScriptActionError(PlayObject, Format(sVarTypeError, [sParam1]), QuestActionInfo, sINC);
          Exit;
        end;
        if DynamicVarList.Count > 0 then begin//20080629
          for I := 0 to DynamicVarList.Count - 1 do begin
            DynamicVar := DynamicVarList.Items[I];
            if CompareText(DynamicVar.sName, sParam2) = 0 then begin
              case DynamicVar.VarType of
                vInteger: begin
                    if n3C > 1 then begin
                      Inc(DynamicVar.nInternet, n3C);
                    end else begin
                      Inc(DynamicVar.nInternet);
                    end;
                  end;
                vString: begin
                    DynamicVar.sString:= DynamicVar.sString + s01;//20080530
                  end;
              end;
              boVarFound := True;
              Break;
            end;
          end;//for
        end;
        if not boVarFound then begin
          ScriptActionError(PlayObject, Format(sVarFound, [sParam2, sParam1]), QuestActionInfo, sINC);
          Exit;
        end;
        Exit;
      end;
      if n10 = 0 then
        ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
    end else begin
      if (sParam2 <> '') and (not IsStringNumber(sParam2)) then begin //��ȡ��2������ֵ
        n14 := GetValNameNo(sParam2);
        if n14 >= 0 then begin
          case n14 of
            0..99: begin //20080323 ԭΪ0..99
                n3C := PlayObject.m_nVal[n14];
              end;
            100..199: begin
                n3C := g_Config.GlobalVal[n14 - 100];
              end;
            200..299: begin //20080323 ԭΪ200..209
                n3C := PlayObject.m_DyVal[n14 - 200];
              end;
            300..399: begin
                n3C := PlayObject.m_nMval[n14 - 300];
              end;
            400..499: begin
                n3C := g_Config.GlobaDyMval[n14 - 400];
              end;
            500..599: begin
                n3C := PlayObject.m_nInteger[n14 - 500];
              end;
            600..699: begin
                s01 := PlayObject.m_sString[n14 - 600];
              end;
            700..799: begin
                s01 := g_Config.GlobalAVal[n14 - 700];
              end;
            800..1199:begin//20080903 G����
                n3C := g_Config.GlobalVal[n14 - 700];
              end;
            1200..1599:begin//20080903 A����(100-499)
                s01 := g_Config.GlobalAVal[n14 - 1100];
              end;
          else begin
              ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
              Exit;
            end;
          end;
        end else begin
           n3C := Str_ToInt(GetLineVariableText(PlayObject, sParam2),0);//20090111 �Ը��˱�����֧��
           s01 := sParam2;//20080530
        end;
      end else n3C := QuestActionInfo.nParam2;
      n14 := GetValNameNo(sParam1);
      if n14 >= 0 then begin
        case n14 of
          0..99: begin //20080323 ԭΪ0..99
              if n3C > 1 then begin
                Inc(PlayObject.m_nVal[n14], n3C);
              end else begin
                Inc(PlayObject.m_nVal[n14]);
              end;
            end;
          100..199: begin
              if n3C > 1 then begin
                Inc(g_Config.GlobalVal[n14 - 100], n3C);
              end else begin
                Inc(g_Config.GlobalVal[n14 - 100]);
              end;
            end;
          200..299: begin //20080323 ԭΪ200..209
              if n3C > 1 then begin
                Inc(PlayObject.m_DyVal[n14 - 200], n3C);
              end else begin
                Inc(PlayObject.m_DyVal[n14 - 200]);
              end;
            end;
          300..399: begin
              if n3C > 1 then begin
                Inc(PlayObject.m_nMval[n14 - 300], n3C);
              end else begin
                Inc(PlayObject.m_nMval[n14 - 300]);
              end;
            end;
          400..499: begin
              if n3C > 1 then begin
                Inc(g_Config.GlobaDyMval[n14 - 400], n3C);
              end else begin
                Inc(g_Config.GlobaDyMval[n14 - 400]);
              end;
            end;
          500..599: begin
              if n3C > 1 then begin
                Inc(PlayObject.m_nInteger[n14 - 500], n3C);
              end else begin
                Inc(PlayObject.m_nInteger[n14 - 500]);
              end;
            end;
          600..699: begin
              PlayObject.m_sString[n14 - 600]:= PlayObject.m_sString[n14 - 600]+ s01;
            end;
          700..799: begin
              g_Config.GlobalAVal[n14 - 700]:= g_Config.GlobalAVal[n14 - 700]+ s01;
            end;
          800..1199:begin//20080903 G����
              if n3C > 1 then begin
                Inc(g_Config.GlobalVal[n14 - 700], n3C);
              end else begin
                Inc(g_Config.GlobalVal[n14 - 700]);
              end;
            end;
          1200..1599:begin//20080903 A����(100-499)
              g_Config.GlobalAVal[n14 - 1100]:= g_Config.GlobalAVal[n14 - 1100]+ s01;
            end;
        else begin
            ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
            Exit;
          end;
        end;
      end else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sINC);
        Exit;
      end;
    end;
  end;

  procedure DecInteger(QuestActionInfo: pTQuestActionInfo);
  var
    I, n14, n3C, n10: Integer;
    DynamicVar: pTDynamicVar;
    DynamicVarList: TList;
    sName,s01,s02,s03: string;
    boVarFound: Boolean;
    sParam1: string;
    sParam2: string;
    sParam3: string;
  resourcestring
    sVarFound = '����%s�����ڣ���������:%s';
    sVarTypeError = '�������ʹ��󣬴�������:%s ��ǰ֧������(HUMAN��GUILD��GLOBAL)';
  begin
    n10 := 0;

    if CompareLStr(QuestActionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
      ArrestStringEx(QuestActionInfo.sParam1, '(', ')', sParam1)
    else sParam1 := QuestActionInfo.sParam1;

    if CompareLStr(QuestActionInfo.sParam2, '<$STR(', 6{Length('<$STR(')}) then //20080228 ֧���ַ�������
      ArrestStringEx(QuestActionInfo.sParam2, '(', ')', sParam2)
    else sParam2 := QuestActionInfo.sParam2;

    if CompareLStr(QuestActionInfo.sParam3, '<$STR(', 6{Length('<$STR(')}) then  //20080228 ֧���ַ�������
      ArrestStringEx(QuestActionInfo.sParam3, '(', ')', sParam3)
    else sParam3 := QuestActionInfo.sParam3;

   { sParam1 := QuestActionInfo.sParam1;
    sParam2 := QuestActionInfo.sParam2;
    sParam3 := QuestActionInfo.sParam3; }
    if (sParam1 = '') or (sParam2 = '') then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
      Exit;
    end;
    if sParam3 <> '' then begin
      if (not IsVarNumber(sParam1)) and (IsVarNumber(sParam2)) then begin
        n10 := 1;
        boVarFound := False;
        DynamicVarList := GetDynamicVarList(PlayObject, sParam2, sName);
        if DynamicVarList = nil then begin
          ScriptActionError(PlayObject, Format(sVarTypeError, [sParam2]), QuestActionInfo, sDEC);
          Exit;
        end;
        if DynamicVarList.Count > 0 then begin//20080629
          for I := 0 to DynamicVarList.Count - 1 do begin
            DynamicVar := DynamicVarList.Items[I];
            if CompareText(DynamicVar.sName, sParam3) = 0 then begin
              case DynamicVar.VarType of
                vInteger: begin
                    n3C := DynamicVar.nInternet;
                  end;
                vString: begin
                    s01 := DynamicVar.sString;//20080530
                  end;
              end;
              boVarFound := True;
              Break;
            end;
          end;//for
        end;
        if not boVarFound then begin
          ScriptActionError(PlayObject, Format(sVarFound, [sParam3, sParam2]), QuestActionInfo, sDEC);
          Exit;
        end;
        n14 := GetValNameNo(sParam1);
        if n14 >= 0 then begin
          case n14 of
            0..99: begin //20080323 ԭΪ0..99
                if n3C > 1 then begin
                  Dec(PlayObject.m_nVal[n14], n3C);
                end else begin
                  Dec(PlayObject.m_nVal[n14]);
                end;
              end;
            100..199: begin
                if n3C > 1 then begin
                  Dec(g_Config.GlobalVal[n14 - 100], n3C);
                end else begin
                  Dec(g_Config.GlobalVal[n14 - 100]);
                end;
              end;
            200..299: begin //20080323 ԭΪ200..209
                if n3C > 1 then begin
                  Dec(PlayObject.m_DyVal[n14 - 200], n3C);
                end else begin
                  Dec(PlayObject.m_DyVal[n14 - 200]);
                end;
              end;
            300..399: begin
                if n3C > 1 then begin
                  Dec(PlayObject.m_nMval[n14 - 300], n3C);
                end else begin
                  Dec(PlayObject.m_nMval[n14 - 300]);
                end;
              end;
            400..499: begin
                if n3C > 1 then begin
                  Dec(g_Config.GlobaDyMval[n14 - 400], n3C);
                end else begin
                  Dec(g_Config.GlobaDyMval[n14 - 400]);
                end;
              end;
            500..599: begin
                if n3C > 1 then begin
                  Dec(PlayObject.m_nInteger[n14 - 500], n3C);
                end else begin
                  Dec(PlayObject.m_nInteger[n14 - 500]);
                end;
              end;
            600..699: begin //20080530
                n10 := Pos(s01, PlayObject.m_sString[n14 - 600]);
                s02:= Copy(PlayObject.m_sString[n14 - 600], 1, n10 - 1);
                s03:= Copy(PlayObject.m_sString[n14 - 600], Length(s01) + n10, Length(PlayObject.m_sString[n14 - 600]));
                PlayObject.m_sString[n14 - 600] := s02 + s03;
              end;
            700..799: begin //20080530
                n10 := Pos(s01, g_Config.GlobalAVal[n14 - 700]);
                s02:= Copy(g_Config.GlobalAVal[n14 - 700], 1, n10 - 1);
                s03:= Copy(g_Config.GlobalAVal[n14 - 700], Length(s01) + n10, Length(g_Config.GlobalAVal[n14 - 700]));
                g_Config.GlobalAVal[n14 - 700] := s02 + s03;
              end;
            800..1199:begin//20080903 G����
                if n3C > 1 then begin
                  Dec(g_Config.GlobalVal[n14 - 700], n3C);
                end else begin
                  Dec(g_Config.GlobalVal[n14 - 700]);
                end;
              end;
            1200..1599:begin//20080903 A����(100-499)
                n10 := Pos(s01, g_Config.GlobalAVal[n14 - 1100]);
                s02:= Copy(g_Config.GlobalAVal[n14 - 1100], 1, n10 - 1);
                s03:= Copy(g_Config.GlobalAVal[n14 - 1100], Length(s01) + n10, Length(g_Config.GlobalAVal[n14 - 1100]));
                g_Config.GlobalAVal[n14 - 1100] := s02 + s03;
              end;
          else begin
              ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
              Exit;
            end;
          end;
        end else begin
          ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
          Exit;
        end;
        Exit;
      end;
      if (IsVarNumber(sParam1)) and (not IsVarNumber(sParam2)) then begin
        if (sParam3 <> '') and (not IsStringNumber(sParam3)) then begin
          n10 := 1;
          n14 := GetValNameNo(sParam3);
          if n14 >= 0 then begin
            case n14 of
              0..99: begin //20080323 ԭΪ0..99
                  n3C := PlayObject.m_nVal[n14];
                end;
              100..199: begin
                  n3C := g_Config.GlobalVal[n14 - 100];
                end;
              200..299: begin //20080323 ԭΪ200..209
                  n3C := PlayObject.m_DyVal[n14 - 200];
                end;
              300..399: begin
                  n3C := PlayObject.m_nMval[n14 - 300];
                end;
              400..499: begin
                  n3C := g_Config.GlobaDyMval[n14 - 400];
                end;
              500..599: begin
                  n3C := PlayObject.m_nInteger[n14 - 500];
                end;
              600..699: begin
                  s01 := PlayObject.m_sString[n14 - 600];
                end;
              700..799: begin
                  s01 := g_Config.GlobalAVal[n14 - 700];
                end;
              800..1199:begin//20080903 G����
                  n3C := g_Config.GlobalVal[n14 - 700];
                end;
              1200..1599:begin//20080903 A����(100-499)
                  s01 := g_Config.GlobalAVal[n14 - 1100];
                end;
            else begin
                ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
                Exit;
              end;
            end;
          end else begin
            s01 := sParam3;//20080530
          end;
        end else n3C := QuestActionInfo.nParam3;
        boVarFound := False;
        DynamicVarList := GetDynamicVarList(PlayObject, sParam1, sName);
        if DynamicVarList = nil then begin
          ScriptActionError(PlayObject, Format(sVarTypeError, [sParam1]), QuestActionInfo, sDEC);
          Exit;
        end;
        if DynamicVarList.Count > 0 then begin//20080629
          for I := 0 to DynamicVarList.Count - 1 do begin
            DynamicVar := DynamicVarList.Items[I];
            if CompareText(DynamicVar.sName, sParam2) = 0 then begin
              case DynamicVar.VarType of
                vInteger: begin
                    if n3C > 1 then begin
                      Dec(DynamicVar.nInternet, n3C);
                    end else begin
                      Dec(DynamicVar.nInternet);
                    end;
                  end;
                vString: begin//20080530
                    n10 := Pos(s01, DynamicVar.sString);
                    s02:= Copy(DynamicVar.sString, 1, n10 - 1);
                    s03:= Copy(DynamicVar.sString, Length(s01) + n10, Length(DynamicVar.sString));
                    DynamicVar.sString := s02 + s03;
                  end;
              end;
              boVarFound := True;
              Break;
            end;
          end;//for
        end;
        if not boVarFound then begin
          ScriptActionError(PlayObject, Format(sVarFound, [sParam2, sParam1]), QuestActionInfo, sDEC);
          Exit;
        end;
        Exit;
      end;
      if n10 = 0 then
        ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
    end else begin
      if (sParam2 <> '') and (not IsStringNumber(sParam2)) then begin //��ȡ��2������ֵ
        n14 := GetValNameNo(sParam2);
        if n14 >= 0 then begin
          case n14 of
            0..99: begin //20080323 ԭΪ0..99
                n3C := PlayObject.m_nVal[n14];
              end;
            100..199: begin
                n3C := g_Config.GlobalVal[n14 - 100];
              end;
            200..299: begin //20080323 ԭΪ200..209
                n3C := PlayObject.m_DyVal[n14 - 200];
              end;
            300..399: begin
                n3C := PlayObject.m_nMval[n14 - 300];
              end;
            400..499: begin
                n3C := g_Config.GlobaDyMval[n14 - 400];
              end;
            500..599: begin
                n3C := PlayObject.m_nInteger[n14 - 500];
              end;
            600..699: begin
                s01 := PlayObject.m_sString[n14 - 600];
              end;
            700..799: begin
                s01 := g_Config.GlobalAVal[n14 - 700];
              end;
            800..1199:begin//20080903 G����
                n3C := g_Config.GlobalVal[n14 - 700];
              end;
            1200..1599:begin//20080903 A����(100-499)
                s01 := g_Config.GlobalAVal[n14 - 1100];
              end;
          else begin
              ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
              Exit;
            end;
          end;
        end else begin
           n3C := Str_ToInt(GetLineVariableText(PlayObject, sParam2),0);//20090111 �Ը��˱�����֧��
           s01 := sParam2;//20080530
        end;
      end else n3C := QuestActionInfo.nParam2;
      n14 := GetValNameNo(sParam1);
      if n14 >= 0 then begin
        case n14 of
          0..99: begin //20080323 ԭΪ0..99
              if n3C > 1 then begin
                Dec(PlayObject.m_nVal[n14], n3C);
              end else begin
                Dec(PlayObject.m_nVal[n14]);
              end;
            end;
          100..199: begin
              if n3C > 1 then begin
                Dec(g_Config.GlobalVal[n14 - 100], n3C);
              end else begin
                Dec(g_Config.GlobalVal[n14 - 100]);
              end;
            end;
          200..299: begin //20080323 ԭΪ200..209
              if n3C > 1 then begin
                Dec(PlayObject.m_DyVal[n14 - 200], n3C);
              end else begin
                Dec(PlayObject.m_DyVal[n14 - 200]);
              end;
            end;
          300..399: begin
              if n3C > 1 then begin
                Dec(PlayObject.m_nMval[n14 - 300], n3C);
              end else begin
                Dec(PlayObject.m_nMval[n14 - 300]);
              end;
            end;
          400..499: begin
              if n3C > 1 then begin
                Dec(g_Config.GlobaDyMval[n14 - 400], n3C);
              end else begin
                Dec(g_Config.GlobaDyMval[n14 - 400]);
              end;
            end;
          500..599: begin
              if n3C > 1 then begin
                Dec(PlayObject.m_nInteger[n14 - 500], n3C);
              end else begin
                Dec(PlayObject.m_nInteger[n14 - 500]);
              end;
            end;
          600..699: begin //20080530
              n10 := Pos(s01, PlayObject.m_sString[n14 - 600]);
              s02:= Copy(PlayObject.m_sString[n14 - 600], 1, n10 - 1);
              s03:= Copy(PlayObject.m_sString[n14 - 600], Length(s01) + n10, Length(PlayObject.m_sString[n14 - 600]));
              PlayObject.m_sString[n14 - 600] := s02 + s03;
            end;
          700..799: begin //20080530
              n10 := Pos(s01, g_Config.GlobalAVal[n14 - 700]);
              s02:= Copy(g_Config.GlobalAVal[n14 - 700], 1, n10 - 1);
              s03:= Copy(g_Config.GlobalAVal[n14 - 700], Length(s01) + n10, Length(g_Config.GlobalAVal[n14 - 700]));
              g_Config.GlobalAVal[n14 - 700] := s02 + s03;
            end;
          800..1199:begin//20080903 G����
              if n3C > 1 then begin
                Dec(g_Config.GlobalVal[n14 - 700], n3C);
              end else begin
                Dec(g_Config.GlobalVal[n14 - 700]);
              end;
            end;
          1200..1599:begin//20080903 A����(100-499)
              n10 := Pos(s01, g_Config.GlobalAVal[n14 - 1100]);
              s02:= Copy(g_Config.GlobalAVal[n14 - 1100], 1, n10 - 1);
              s03:= Copy(g_Config.GlobalAVal[n14 - 1100], Length(s01) + n10, Length(g_Config.GlobalAVal[n14 - 1100]));
              g_Config.GlobalAVal[n14 - 1100] := s02 + s03;
            end;
        else begin
            ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
            Exit;
          end;
        end;
      end else begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sDEC);
        Exit;
      end;
    end;
  end;

  function QuestActionProcess(ActionList: TList): Boolean;
  var
    I, II, III: Integer;
    QuestActionInfo: pTQuestActionInfo;
    n14, n18, n1C, n28, n2C: Integer;
    n20X, n24Y, n34, n38, n3C, n40: Integer;
    s4C, s50: string;
    s34, s44, s48: string;
    Envir: TEnvirnoment;
    List58: TList;
    User: TPlayObject;
    DynamicVar: pTDynamicVar;
    DynamicVarList: TList;
    sName: string;
    OnlinePlayObject: TPlayObject;
    GuildRank: pTGuildRank;
    UserObject: TPlayObject;
    fun: string;
    CMDCode: Integer;
  begin
    Result := True;

    n18 := 0;
    n34 := 0;
    n38 := 0;
    n3C := 0;
    n40 := 0;
    try
      if ActionList = nil then Exit;//20090103 
      if ActionList.Count > 0 then begin//20081008
        for I := 0 to ActionList.Count - 1 do begin
          QuestActionInfo := ActionList.Items[I];
          if QuestActionInfo <> nil then begin//20090103
            CMDCode:= QuestActionInfo.nCMDCode;//20090103
            case QuestActionInfo.nCMDCode of
              nSET: begin
                  n28 := Str_ToInt(QuestActionInfo.sParam1, 0);
                  n2C := Str_ToInt(QuestActionInfo.sParam2, 0);
                  PlayObject.SetQuestFlagStatus(n28, n2C);
                end;
              nTAKE: TakeItem(QuestActionInfo.sParam1, QuestActionInfo.nParam2, QuestActionInfo.sParam2);
              nSC_GIVE: ActionOfGiveItem(PlayObject, QuestActionInfo);
              nTAKEW: begin
                  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam1[1] = '<') and (QuestActionInfo.sParam1[2] = '$') then
                    s4C:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1)//20081204
                  else
                  if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin //���ӱ���֧��
                    s4C := QuestActionInfo.sParam1;
                  end;

                  if (QuestActionInfo.sParam2 <> '') and (QuestActionInfo.sParam2[1] = '<') and (QuestActionInfo.sParam2[2] = '$') then//����֧��<$Str()> 20081204
                    n14 := Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),0)
                  else
                  if not GetValValue(PlayObject, QuestActionInfo.sParam2, n14) then begin //���ӱ���֧��
                    n14 := QuestActionInfo.nParam2;
                  end;
                  TakeWItem(s4C, n14);
                end;
              nCLOSE: PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
              nRESET: begin
                  if QuestActionInfo.nParam2 <= 0 then QuestActionInfo.nParam2:= 1;//20081008
                  for II := 0 to QuestActionInfo.nParam2 - 1 do begin
                    PlayObject.SetQuestFlagStatus(QuestActionInfo.nParam1 + II, 0);
                  end;
                end;
              nBREAK: begin
                  if QuestActionInfo.nParam1 <> 0 then begin //20080713
                    if (QuestActionInfo.nParam1= 1) or (QuestActionInfo.nParam1= 2) then Result := False;
                  end else Result := False;
                end;
              nTIMERECALL: begin
                  PlayObject.m_boTimeRecall := True;
                  PlayObject.m_sMoveMap := PlayObject.m_sMapName;
                  PlayObject.m_nMoveX := PlayObject.m_nCurrX;
                  PlayObject.m_nMoveY := PlayObject.m_nCurrY;
                  PlayObject.m_dwTimeRecallTick := GetTickCount + LongWord(QuestActionInfo.nParam1 * 60000{60 * 1000});
                end;
              nSC_PARAM1: begin //20080602 �޸�
                  n34:=Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1),0);
                  s44:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);
                  (*if CompareLStr(QuestActionInfo.sParam1, '<$MAP>', 6{Length('<$MAP>')}) then begin//20080321 ����֧��<$MAP>
                    n34 := Str_ToInt(PlayObject.m_PEnvir.sMapName,-1);
                    s44 := PlayObject.m_PEnvir.sMapName;
                  end else begin
                    n34 := QuestActionInfo.nParam1;
                    s44 := QuestActionInfo.sParam1;
                  end; *)
                end;
              nSC_PARAM2: begin
                  //n38 := QuestActionInfo.nParam1;
                  //s48 := QuestActionInfo.sParam1;
                  n38:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1),0);//20080923
                  s48:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//20080923
                end;
              nSC_PARAM3: begin
                  //n3C := QuestActionInfo.nParam1;
                  //s4C := QuestActionInfo.sParam1;
                  n3C:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1),0);//20080923
                  s4C:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//20080923
                end;
              nSC_PARAM4: begin
                  //n40 := QuestActionInfo.nParam1;
                  //s50 := QuestActionInfo.sParam1;
                  n40:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam1),0);//20080923
                  s50:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//20080923
                end;
              nSC_EXEACTION: begin
                  n40 := QuestActionInfo.nParam1;
                  s50 := QuestActionInfo.sParam1;
                  ExeAction(PlayObject, QuestActionInfo.sParam1, QuestActionInfo.sParam2, QuestActionInfo.sParam3, QuestActionInfo.nParam1, QuestActionInfo.nParam2, QuestActionInfo.nParam3);
                end;
              nMAPMOVE: begin
                  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam1[1] = '<') and (QuestActionInfo.sParam1[2] = '$') then//����֧��<$Str()> 20080609
                     s4C := GetLineVariableText(PlayObject, QuestActionInfo.sParam1)
                  else s4C := QuestActionInfo.sParam1;//20080915
                  {if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin //���ӱ���֧��
                    s4C := QuestActionInfo.sParam1;
                  end; }

                  if (QuestActionInfo.sParam2 <> '') and (QuestActionInfo.sParam2[1] = '<') and (QuestActionInfo.sParam2[2] = '$') then//����֧��<$Str()> 20080609
                     n14 := Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),0)
                  else
                  if not GetValValue(PlayObject, QuestActionInfo.sParam2, n14) then begin //���ӱ���֧��
                    n14 := QuestActionInfo.nParam2;
                  end;

                  if (QuestActionInfo.sParam3 <> '') and (QuestActionInfo.sParam3[1] = '<') and (QuestActionInfo.sParam3[2] = '$') then//����֧��<$Str()> 20080609
                     n40 := Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3),0)
                  else
                  if not GetValValue(PlayObject, QuestActionInfo.sParam3, n40) then begin //���ӱ���֧��
                    n40 := QuestActionInfo.nParam3;
                  end;
                  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                  PlayObject.SpaceMove(s4C, n14, n40, 0);
                  bo11 := True;
                end;
              nMAP: begin
                  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam1[1] = '<') and (QuestActionInfo.sParam1[2] = '$') then//����֧��<$Str()>
                     s4C := GetLineVariableText(PlayObject, QuestActionInfo.sParam1)
                  else s4C := QuestActionInfo.sParam1;//20080915
                  {if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin //���ӱ���֧��
                    s4C := QuestActionInfo.sParam1;
                  end;}
                  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                  PlayObject.MapRandomMove(s4C, 0);
                  bo11 := True;
                end;
              nTAKECHECKITEM: begin
                  if UserItem <> nil then begin
                    PlayObject.QuestTakeCheckItem(UserItem);
                  end else begin
                    ScriptActionError(PlayObject, '', QuestActionInfo, sTAKECHECKITEM);
                  end;
                end;
              nMONGEN: begin//20080602 ��չ֧�ֱ���
                  s34:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//������
                  n34:=Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3),0);//��Χ
                  n40:=Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),1);//���� 20080816 �޸�
                  for II := 0 to n40 - 1 do begin
                    n20X := Random(n34 * 2 + 1) + (n38 - n34);
                    n24Y := Random(n34 * 2 + 1) + (n3C - n34);
                    UserEngine.RegenMonsterByName(s44, n20X, n24Y, s34); //��ͼ,X,Y,����
                  end;
                end;
              nMONCLEAR: begin
                  List58 := TList.Create;
                  s34:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//20080602 ֧�ֱ���
                  UserEngine.GetMapMonster(g_MapManager.FindMap(s34{QuestActionInfo.sParam1}), List58);
                  if List58.Count > 0 then begin//20080629
                    for II := 0 to List58.Count - 1 do begin
                      TBaseObject(List58.Items[II]).m_boNoItem := True;
                      TBaseObject(List58.Items[II]).m_WAbil.HP := 0;
                    end;
                  end;
                  List58.Free;
                end;
              nMOV: MovData(QuestActionInfo);
              nINC: IncInteger(QuestActionInfo);
              nDEC: DecInteger(QuestActionInfo);
              nSUM: begin
                  n18 := 0;
                  if CompareLStr(QuestActionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then begin //20080228 SUM ֧���ַ�������
                    ArrestStringEx(QuestActionInfo.sParam1, '(', ')', s34);
                    n14 := GetValNameNo(s34);
                  end else n14 := GetValNameNo(QuestActionInfo.sParam1);

                  if n14 >= 0 then begin
                    case n14 of //
                      0..99: begin //20080323 ԭΪ0..99
                          n18 := PlayObject.m_nVal[n14];
                        end;
                      100..199: begin
                          n18 := g_Config.GlobalVal[n14 - 100];
                        end;
                      200..299: begin //20080323 ԭΪ200..209
                          n18 := PlayObject.m_DyVal[n14 - 200];
                        end;
                      300..399: begin
                          n18 := PlayObject.m_nMval[n14 - 300];
                        end;
                      400..499: begin
                          n18 := g_Config.GlobaDyMval[n14 - 400];
                        end;
                      500..599: begin
                          n18 := PlayObject.m_nInteger[n14 - 500];
                        end;
                      600..699: begin //20080411
                          s44 := PlayObject.m_sString[n14 - 600];
                        end;
                      700..799: begin //20080411
                          s44 := g_Config.GlobalAVal[n14 - 700];
                        end;
                      800..1199:begin//20080903 G����
                          n18 := g_Config.GlobalVal[n14 - 700];
                        end;
                      1200..1599:begin//20080903 A����(100-499)
                          s44 := g_Config.GlobalAVal[n14 - 1100];
                        end;
                    else begin
                        ScriptActionError(PlayObject, '', QuestActionInfo, sSUM);
                      end;
                    end; // case
                  end else begin
                    ScriptActionError(PlayObject, '', QuestActionInfo, sSUM);
                  end;
                  n1C := 0;

                  if CompareLStr(QuestActionInfo.sParam2, '<$STR(', 6{Length('<$STR(')}) then begin //20080228 SUM ֧���ַ�������
                    ArrestStringEx(QuestActionInfo.sParam2, '(', ')', s34);
                    n14 := GetValNameNo(s34);
                  end else n14 := GetValNameNo(QuestActionInfo.sParam2);

                  if n14 >= 0 then begin
                    case n14 of //
                      0..99: begin //20080323 ԭΪ0..99
                          n1C := PlayObject.m_nVal[n14];
                        end;
                      100..199: begin
                          n1C := g_Config.GlobalVal[n14 - 100];
                        end;
                      200..299: begin //20080323 ԭΪ200..209
                          n1C := PlayObject.m_DyVal[n14 - 200];
                        end;
                      300..399: begin
                          n1C := PlayObject.m_nMval[n14 - 300];
                        end;
                      400..499: begin
                          n1C := g_Config.GlobaDyMval[n14 - 400];
                        end;
                      500..599: begin
                          n1C := PlayObject.m_nInteger[n14 - 500];
                        end;
                      600..699: begin //20080411
                          s48 := PlayObject.m_sString[n14 - 600];
                        end;
                      700..799: begin //20080411
                          s48 := g_Config.GlobalAVal[n14 - 700];
                        end;
                      800..1199:begin//20080903 G����
                          n1C := g_Config.GlobalVal[n14 - 700];
                        end;
                      1200..1599:begin//20080903 A����(100-499)
                          s48 := g_Config.GlobalAVal[n14 - 1100];
                        end;
                    else begin
                        ScriptActionError(PlayObject, '', QuestActionInfo, sSUM);
                      end;
                    end;
                  end else begin
                    //ScriptActionError(PlayObject,'',QuestActionInfo,sSUM);
                  end;

                  if CompareLStr(QuestActionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then begin //20080228 SUM ֧���ַ�������
                    ArrestStringEx(QuestActionInfo.sParam1, '(', ')', s34);
                    n14 := GetValNameNo(s34);
                  end else n14 := GetValNameNo(QuestActionInfo.sParam1);
                  if n14 >= 0 then begin
                    case n14 of //
                      0..99: begin //20080323 ԭΪ0..99
                          PlayObject.m_nVal[n14] := {PlayObject.m_nVal[n14] +} n18 + n1C; //20080411
                        end;
                      100..199: begin
                          g_Config.GlobalVal[n14 - 100] := {g_Config.GlobalVal[n14 - 100] +} n18 + n1C;
                        end;
                      200..299: begin //20080323 ԭΪ200..209
                          PlayObject.m_DyVal[n14 - 200] := {PlayObject.m_DyVal[n14 - 200] +} n18 + n1C;
                        end;
                      300..399: begin
                          PlayObject.m_nMval[n14 - 300] := {PlayObject.m_nMval[n14 - 300] +} n18 + n1C;
                        end;
                      400..499: begin
                          g_Config.GlobaDyMval[n14 - 400] := {g_Config.GlobaDyMval[n14 - 400] +} n18 + n1C;
                        end;
                      500..599: begin
                          PlayObject.m_nInteger[n14 - 500] := {PlayObject.m_nInteger[n14 - 500] +} n18 + n1C;
                        end;
                       600..699: begin //20080411
                          PlayObject.m_sString[n14 - 600] := s44 + s48;
                        end;
                      700..799: begin //20080411
                          g_Config.GlobalAVal[n14 - 700] := s44 + s48;
                        end;
                      800..1199:begin//20080903 G����
                          g_Config.GlobalVal[n14 - 700] := {g_Config.GlobalVal[n14 - 700] +} n18 + n1C;
                        end;
                      1200..1599:begin//20080903 A����(100-499)
                          g_Config.GlobalAVal[n14 - 1100] := s44 + s48;
                        end;
                    end;
                  end;
                end;
      //------------------------------------------------------------------------------
             nSC_DIV: begin //20080410 �������� ����  ��ʽ: DIV N1 N2 N3 ��N1=N2/N3
                  n18 := 0;
                  n14:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),-1);//20080410
                  if n14 < 0 then begin
                  {if CompareLStr(QuestActionInfo.sParam1, '<$STR(', Length('<$STR(')) then begin //20080228  ֧���ַ�������
                    ArrestStringEx(QuestActionInfo.sParam1, '(', ')', s34);         //ȡ��һ������,����ֵ��n18
                    n14 := GetValNameNo(s34);
                  end else }n14 := GetValNameNo(QuestActionInfo.sParam2);
                    if n14 >= 0 then begin
                      case n14 of //
                        0..99: begin //20080323 ԭΪ0..99
                            n18 := PlayObject.m_nVal[n14];
                          end;
                        100..199: begin
                            n18 := g_Config.GlobalVal[n14 - 100];
                          end;
                        200..299: begin //20080323 ԭΪ200..209
                            n18 := PlayObject.m_DyVal[n14 - 200];
                          end;
                        300..399: begin
                            n18 := PlayObject.m_nMval[n14 - 300];
                          end;
                        400..499: begin
                            n18 := g_Config.GlobaDyMval[n14 - 400];
                          end;
                        500..599: begin
                            n18 := PlayObject.m_nInteger[n14 - 500];
                          end;
                        800..1199:begin//20080903 G����
                            n18 := g_Config.GlobalVal[n14 - 700];
                          end;
                        {1800..2799:begin//20080323 I����
                            n18 := g_Config.GlobaDyMval[n14 - 1800];
                          end; }
                      else begin
                          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DIV);
                        end;
                      end; // case
                    end else begin
                      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DIV);
                    end;
                  end else n18 := N14;

                  n1C := 0;
                  n14:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3),-1);//20080410
                  if n14 < 0 then begin
                  {if CompareLStr(QuestActionInfo.sParam2, '<$STR(', Length('<$STR(')) then begin //20080228  ֧���ַ�������
                    ArrestStringEx(QuestActionInfo.sParam2, '(', ')', s34);         //ȡ��һ������,����ֵ��n1C
                    n14 := GetValNameNo(s34);
                  end else} n14 := GetValNameNo(QuestActionInfo.sParam3);
                    if n14 >= 0 then begin
                      case n14 of //
                        0..99: begin //20080323 ԭΪ0..99
                            n1C := PlayObject.m_nVal[n14];
                          end;
                        100..199: begin
                            n1C := g_Config.GlobalVal[n14 - 100];
                          end;
                        200..299: begin //20080323 ԭΪ200..209
                            n1C := PlayObject.m_DyVal[n14 - 200];
                          end;
                        300..399: begin
                            n1C := PlayObject.m_nMval[n14 - 300];
                          end;
                        400..499: begin
                            n1C := g_Config.GlobaDyMval[n14 - 400];
                          end;
                        500..599: begin
                            n1C := PlayObject.m_nInteger[n14 - 500];
                          end;
                        800..1199:begin//20080903 G����
                            n1C := g_Config.GlobalVal[n14 - 700];
                          end;
                       {1800..2799:begin//20080323 I����
                            n1C := g_Config.GlobaDyMval[n14 - 1800];
                          end; }
                      else begin
                          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_DIV);
                        end;
                      end;
                    end else begin
                      //ScriptActionError(PlayObject,'',QuestActionInfo,sSC_DIV);
                    end;
                  end else n1C := n14;

                  if CompareLStr(QuestActionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then begin //20080228  ֧���ַ�������
                    ArrestStringEx(QuestActionInfo.sParam1, '(', ')', s34);
                    n14 := GetValNameNo(s34);
                  end else n14 := GetValNameNo(QuestActionInfo.sParam1);
                  if n14 >= 0 then begin
                    case n14 of //
                      0..99: begin //20080323 ԭΪ0..99
                          PlayObject.m_nVal[n14] := n18 div n1C;
                        end;
                      100..199: begin
                          g_Config.GlobalVal[n14 - 100] := n18 div n1C;
                        end;
                      200..299: begin //20080323 ԭΪ200..209
                           PlayObject.m_DyVal[n14 - 200] := n18 div n1C;
                        end;
                      300..399: begin
                           PlayObject.m_nMval[n14 - 300] := n18 div n1C;
                        end;
                      400..499: begin
                           g_Config.GlobaDyMval[n14 - 400] := n18 div n1C;
                        end;
                      500..599: begin
                           PlayObject.m_nInteger[n14 - 500] :=  n18 div n1C;
                        end;
                      800..1199:begin//20080903 G����
                          g_Config.GlobalVal[n14 - 700] := n18 div n1C;
                        end;
                     {1800..2799:begin//20080323 I����
                          g_Config.GlobaDyMval[999]:=  n18 div n1C;
                        end;}
                    end;
                  end;
                end;

             nSC_MUL: begin //20080410 �������� �˷�  ��ʽ: MUL N1 N2 N3 ��N1=N2*N3
                  n18 := 0;
                  n14:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),-1);//20080410
                  if n14 < 0 then begin
                     {if CompareLStr(QuestActionInfo.sParam2, '<$STR(', Length('<$STR(')) then begin //20080228  ֧���ַ�������
                       ArrestStringEx(QuestActionInfo.sParam2, '(', ')', s34);
                       n14 := GetValNameNo(s34);
                     end else} n14 := GetValNameNo(QuestActionInfo.sParam2);//20080410

                    if n14 >= 0 then begin
                      case n14 of //
                        0..99: begin //20080323 ԭΪ0..99
                            n18 := PlayObject.m_nVal[n14];
                          end;
                        100..199: begin
                            n18 := g_Config.GlobalVal[n14 - 100];
                          end;
                        200..299: begin //20080323 ԭΪ200..209
                            n18 := PlayObject.m_DyVal[n14 - 200];
                          end;
                        300..399: begin
                            n18 := PlayObject.m_nMval[n14 - 300];
                          end;
                        400..499: begin
                            n18 := g_Config.GlobaDyMval[n14 - 400];
                          end;
                        500..599: begin
                            n18 := PlayObject.m_nInteger[n14 - 500];
                          end;
                        600..699: begin//20081226
                            n18 := Str_ToInt(PlayObject.m_sString[n14 - 600], 1);
                          end;
                        700..799: begin//20081226
                            n18 := Str_ToInt(g_Config.GlobalAVal[n14 - 700] , 1);
                          end;
                        800..1199:begin//20080903 G����
                            n18 := g_Config.GlobalVal[n14 - 700];
                          end;
                        1200..1599:begin//20081226 A����(100-499)
                            n18 := Str_ToInt(g_Config.GlobalAVal[n14 - 1100] , 1);
                          end;
                      else begin
                          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MUL);
                        end;
                      end; // case
                    end else begin
                      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MUL);
                    end;
                  end else n18 := N14;
                  n1C := 0;

                  n14:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3),-1);//20080410
                  if n14 < 0 then begin
                     {if CompareLStr(QuestActionInfo.sParam3, '<$STR(', Length('<$STR(')) then begin //20080228  ֧���ַ�������
                       ArrestStringEx(QuestActionInfo.sParam3, '(', ')', s34);
                       n14 := GetValNameNo(s34);
                     end else} n14 := GetValNameNo(QuestActionInfo.sParam3);//20080410
                    if n14 >= 0 then begin
                      case n14 of //
                        0..99: begin //20080323 ԭΪ0..99
                            n1C := PlayObject.m_nVal[n14];
                          end;
                        100..199: begin
                            n1C := g_Config.GlobalVal[n14 - 100];
                          end;
                        200..299: begin //20080323 ԭΪ200..209
                            n1C := PlayObject.m_DyVal[n14 - 200];
                          end;
                        300..399: begin
                            n1C := PlayObject.m_nMval[n14 - 300];
                          end;
                        400..499: begin
                            n1C := g_Config.GlobaDyMval[n14 - 400];
                          end;
                        500..599: begin
                            n1C := PlayObject.m_nInteger[n14 - 500];
                          end;
                        600..699: begin//20081226
                            n1C := Str_ToInt(PlayObject.m_sString[n14 - 600], 1);
                          end;
                        700..799: begin//20081226
                            n1C := Str_ToInt(g_Config.GlobalAVal[n14 - 700] , 1);
                          end;
                        800..1199:begin//20080903 G����
                            n1C := g_Config.GlobalVal[n14 - 700];
                          end;
                        1200..1599:begin//20081226 A����(100-499)
                            n1C := Str_ToInt(g_Config.GlobalAVal[n14 - 1100] , 1);
                          end;
                      else begin
                          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MUL);
                        end;
                      end;
                    end else begin
                      //ScriptActionError(PlayObject,'',QuestActionInfo,sSC_MUL;
                    end;
                  end else n1C := n14;

                    if CompareLStr(QuestActionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then begin //20080228  ֧���ַ�������
                      ArrestStringEx(QuestActionInfo.sParam1, '(', ')', s34);
                      n14 := GetValNameNo(s34);
                    end else n14 := GetValNameNo(QuestActionInfo.sParam1);//ȡ��һ������,����ֵ��n18
                    if n14 >= 0 then begin
                      case n14 of //
                        0..99: begin //20080323 ԭΪ0..99
                            PlayObject.m_nVal[n14] := n18 * n1C;
                          end;
                        100..199: begin
                            g_Config.GlobalVal[n14 - 100] := n18 * n1C;
                          end;
                        200..299: begin //20080323 ԭΪ200..209
                             PlayObject.m_DyVal[n14 - 200] := n18 * n1C;
                          end;
                        300..399: begin
                             PlayObject.m_nMval[n14 - 300] := n18 * n1C;
                          end;
                        400..499: begin
                             g_Config.GlobaDyMval[n14 - 400] := n18 * n1C;
                          end;
                        500..599: begin
                             PlayObject.m_nInteger[n14 - 500] :=  n18 * n1C;
                          end;
                        600..699: begin//20081226
                            PlayObject.m_sString[n14 - 600] := IntToStr(n18 * n1C);
                          end;
                        700..799: begin//20081226
                            g_Config.GlobalAVal[n14 - 700] := IntToStr(n18 * n1C);
                          end;
                        800..1199:begin//20080903 G����
                            g_Config.GlobalVal[n14 - 700] := n18 * n1C;
                          end;
                        1200..1599:begin//20081226 A����(100-499)
                            g_Config.GlobalAVal[n14 - 1100]:= IntToStr(n18 * n1C);
                          end;
                      end;
                    end;
                end;

             nSC_PERCENT: begin //20080410 �������� �ٷֱ�  ��ʽ: PERCENT N1 N2 N3 ��N1=(N2/N3)*100
                  n18 := 0;
                  n14:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2),-1);//20080410
                  if n14 < 0 then begin
                  {if CompareLStr(QuestActionInfo.sParam1, '<$STR(', Length('<$STR(')) then begin //20080228  ֧���ַ�������
                    ArrestStringEx(QuestActionInfo.sParam1, '(', ')', s34);
                    n14 := GetValNameNo(s34);
                  end else} n14 := GetValNameNo(QuestActionInfo.sParam2);//ȡ��һ������,����ֵ��n18
                    if n14 >= 0 then begin
                      case n14 of //
                        0..99: begin //20080323 ԭΪ0..99
                            n18 := PlayObject.m_nVal[n14];
                          end;
                        100..199: begin
                            n18 := g_Config.GlobalVal[n14 - 100];
                          end;
                        200..299: begin //20080323 ԭΪ200..209
                            n18 := PlayObject.m_DyVal[n14 - 200];
                          end;
                        300..399: begin
                            n18 := PlayObject.m_nMval[n14 - 300];
                          end;
                        400..499: begin
                            n18 := g_Config.GlobaDyMval[n14 - 400];
                          end;
                        500..599: begin
                            n18 := PlayObject.m_nInteger[n14 - 500];
                          end;
                        800..1199:begin//20080903 G����
                            n18 := g_Config.GlobalVal[n14 - 700];
                          end;
                       {1800..2799:begin//20080323 I����
                            n18 := g_Config.GlobaDyMval[n14 - 1800];
                          end; }
                      else begin
                          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PERCENT);
                        end;
                      end; // case
                    end else begin
                      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PERCENT);
                    end;
                  end else n18 := n14;

                  n1C := 0;
                  n14:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3),-1);//20080410
                  if n14 < 0 then begin
                  {if CompareLStr(QuestActionInfo.sParam2, '<$STR(', Length('<$STR(')) then begin //20080228  ֧���ַ�������
                    ArrestStringEx(QuestActionInfo.sParam2, '(', ')', s34);
                    n14 := GetValNameNo(s34);
                  end else} n14 := GetValNameNo(QuestActionInfo.sParam3);//ȡ��һ������,����ֵ��n1C
                    if n14 >= 0 then begin
                      case n14 of //
                        0..99: begin //20080323 ԭΪ0..99
                            n1C := PlayObject.m_nVal[n14];
                          end;
                        100..199: begin
                            n1C := g_Config.GlobalVal[n14 - 100];
                          end;
                        200..299: begin //20080323 ԭΪ200..209
                            n1C := PlayObject.m_DyVal[n14 - 200];
                          end;
                        300..399: begin
                            n1C := PlayObject.m_nMval[n14 - 300];
                          end;
                        400..499: begin
                            n1C := g_Config.GlobaDyMval[n14 - 400];
                          end;
                        500..599: begin
                            n1C := PlayObject.m_nInteger[n14 - 500];
                          end;
                        800..1199:begin//20080903 G����
                            n1C := g_Config.GlobalVal[n14 - 700];
                          end;
                       {1800..2799:begin//20080323 I����
                            n1C := g_Config.GlobaDyMval[n14 - 1800];
                          end; }
                      else begin
                          ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PERCENT);
                        end;
                      end;
                    end else begin
                      //ScriptActionError(PlayObject,'',QuestActionInfo,sSC_PERCENT);
                    end;
                  end else n1C := n14;

                  if CompareLStr(QuestActionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then begin //20080228  ֧���ַ�������
                    ArrestStringEx(QuestActionInfo.sParam1, '(', ')', s34);
                    n14 := GetValNameNo(s34);
                  end else n14 := GetValNameNo(QuestActionInfo.sParam1);

                  if n14 >= 0 then begin
                    case n14 of //
                      0..99: begin //20080323 ԭΪ0..99
                          PlayObject.m_nVal[n14] := n18 div n1C * 100;
                        end;
                      100..199: begin
                          g_Config.GlobalVal[n14 - 100] := n18 div n1C * 100;
                        end;
                      200..299: begin //20080323 ԭΪ200..209
                           PlayObject.m_DyVal[n14 - 200] := n18 div n1C * 100;
                        end;
                      300..399: begin
                           PlayObject.m_nMval[n14 - 300] := n18 div n1C * 100;
                        end;
                      400..499: begin
                           g_Config.GlobaDyMval[n14 - 400] := n18 div n1C * 100;
                        end;
                      500..599: begin
                           PlayObject.m_nInteger[n14 - 500] :=  n18 div n1C * 100;
                        end;
                      600..699: begin
                          PlayObject.m_sString[n14 - 600] := IntToStr(n18 div n1C * 100)+'%';//20080606
                        end;
                      700..799: begin
                          g_Config.GlobalAVal[n14 - 700] := IntToStr(n18 div n1C * 100)+'%';//20080606
                        end;
                      800..1199:begin//20080903 G����
                          g_Config.GlobalVal[n14 - 700] := n18 div n1C * 100;
                        end;
                      1200..1599:begin//20080903 A����(100-499)
                          g_Config.GlobalAVal[n14 - 1100] := IntToStr(n18 div n1C * 100)+'%';
                        end;
                    end;
                  end;
                end;
      //------------------------------------------------------------------------------
              nBREAKTIMERECALL: PlayObject.m_boTimeRecall := False;

              {nCHANGEMODE: begin//�ı����ģʽ   //20090111 ע��
                  case QuestActionInfo.nParam1 of
                    1: PlayObject.CmdChangeAdminMode('', 10, '', Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
                    2: PlayObject.CmdChangeSuperManMode('', 10, '', Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
                    3: PlayObject.CmdChangeObMode('', 10, '', Str_ToInt(QuestActionInfo.sParam2, 0) = 1);
                  else begin
                      ScriptActionError(PlayObject, '', QuestActionInfo, sCHANGEMODE);
                    end;
                  end;
                end;}
              nPKPOINT: begin
                  if not GetValValue(PlayObject, QuestActionInfo.sParam1, n14) then begin //���ӱ���֧��
                    n14 := QuestActionInfo.nParam1;
                  end;
                  if n14 = 0 then begin
                    PlayObject.m_nPkPoint := 0;
                  end else begin
                    if n14 < 0 then begin
                      if (PlayObject.m_nPkPoint + n14) >= 0 then begin
                        Inc(PlayObject.m_nPkPoint, n14);
                      end else PlayObject.m_nPkPoint := 0;
                    end else begin
                      if (PlayObject.m_nPkPoint + n14) > 10000 then begin
                        PlayObject.m_nPkPoint := 10000;
                      end else begin
                        Inc(PlayObject.m_nPkPoint, n14);
                      end;
                    end;
                  end;
                  PlayObject.RefNameColor();
                end;

              nSC_RECALLMOB: ActionOfRecallmob(PlayObject, QuestActionInfo);
              nSC_RECALLMOBEX: ActionOfRECALLMOBEX(PlayObject, QuestActionInfo); //20080122 �ٻ�����
              nSC_MOVEMOBTO: ActionOfMOVEMOBTO(PlayObject, QuestActionInfo); //20080123 ��ָ������Ĺ����ƶ���������
              nSC_CLEARITEMMAP: ActionOfCLEARITEMMAP(PlayObject, QuestActionInfo); //20080124 �����ͼ��Ʒ
              nKICK: begin
                  PlayObject.m_boReconnection := True;
                  PlayObject.m_boSoftClose := True;
                  PlayObject.m_boPlayOffLine := False;
                  PlayObject.m_boNotOnlineAddExp := False;
                end;
              nMOVR: begin//ȡ���ֵ��������   ��չ�����������2������3֮�����
                  if CompareLStr(QuestActionInfo.sParam1, '<$STR(', 6{Length('<$STR(')}) then begin //20080228 ֧���ַ�������
                    ArrestStringEx(QuestActionInfo.sParam1, '(', ')', s34);
                    n14 := GetValNameNo(s34);
                  end else n14 := GetValNameNo(QuestActionInfo.sParam1);

                  if n14 >= 0 then begin
                    case n14 of //
                      0..99: begin //20080323 ԭΪ0..99
                          //PlayObject.m_nVal[n14] := Random(QuestActionInfo.nParam2);
                          if QuestActionInfo.nParam3 > QuestActionInfo.nParam2 then begin
                            PlayObject.m_nVal[n14] := QuestActionInfo.nParam2 + Random(QuestActionInfo.nParam3 - QuestActionInfo.nParam2);
                          end else PlayObject.m_nVal[n14] := Random(QuestActionInfo.nParam2);
                        end;
                      100..199: begin
                          //g_Config.GlobalVal[n14 - 100] := Random(QuestActionInfo.nParam2);
                          if QuestActionInfo.nParam3 > QuestActionInfo.nParam2 then begin
                             g_Config.GlobalVal[n14 - 100]:= QuestActionInfo.nParam2 + Random(QuestActionInfo.nParam3 - QuestActionInfo.nParam2);
                          end else g_Config.GlobalVal[n14 - 100] := Random(QuestActionInfo.nParam2);
                        end;
                      200..299: begin //20080323 ԭΪ200..209
                          //PlayObject.m_DyVal[n14 - 200] := Random(QuestActionInfo.nParam2);
                          if QuestActionInfo.nParam3 > QuestActionInfo.nParam2 then begin
                             PlayObject.m_DyVal[n14 - 200]:= QuestActionInfo.nParam2 + Random(QuestActionInfo.nParam3 - QuestActionInfo.nParam2);
                          end else PlayObject.m_DyVal[n14 - 200] := Random(QuestActionInfo.nParam2);
                        end;
                      300..399: begin
                          //PlayObject.m_nMval[n14 - 300] := Random(QuestActionInfo.nParam2);
                          if QuestActionInfo.nParam3 > QuestActionInfo.nParam2 then begin
                             PlayObject.m_nMval[n14 - 300]:= QuestActionInfo.nParam2 + Random(QuestActionInfo.nParam3 - QuestActionInfo.nParam2);
                          end else PlayObject.m_nMval[n14 - 300] := Random(QuestActionInfo.nParam2);
                        end;
                      400..499: begin
                          //g_Config.GlobaDyMval[n14 - 400] := Random(QuestActionInfo.nParam2);
                          if QuestActionInfo.nParam3 > QuestActionInfo.nParam2 then begin
                             g_Config.GlobaDyMval[n14 - 400] := QuestActionInfo.nParam2 + Random(QuestActionInfo.nParam3 - QuestActionInfo.nParam2);
                          end else g_Config.GlobaDyMval[n14 - 400] := Random(QuestActionInfo.nParam2);
                        end;
                      500..599: begin
                          //PlayObject.m_nInteger[n14 - 500] := Random(QuestActionInfo.nParam2);
                          if QuestActionInfo.nParam3 > QuestActionInfo.nParam2 then begin
                            PlayObject.m_nInteger[n14 - 500] :=QuestActionInfo.nParam2 + Random(QuestActionInfo.nParam3 - QuestActionInfo.nParam2);
                          end else PlayObject.m_nInteger[n14 - 500] := Random(QuestActionInfo.nParam2);
                        end;
                      800..1199:begin//20080903 G����
                          //g_Config.GlobalVal[n14 - 700] := Random(QuestActionInfo.nParam2);
                          if QuestActionInfo.nParam3 > QuestActionInfo.nParam2 then begin
                             g_Config.GlobalVal[n14 - 700]:= QuestActionInfo.nParam2 + Random(QuestActionInfo.nParam3 - QuestActionInfo.nParam2);
                          end else g_Config.GlobalVal[n14 - 700] := Random(QuestActionInfo.nParam2);
                        end;
                     {1800..2799:begin//20080323 I����
                          g_Config.GlobaDyMval[n14 - 1800]:= Random(QuestActionInfo.nParam2);
                        end; }
                    else begin
                        ScriptActionError(PlayObject, '', QuestActionInfo, sMOVR);
                      end;
                    end;
                  end else begin
                    ScriptActionError(PlayObject, '', QuestActionInfo, sMOVR);
                  end;
                end;
              nEXCHANGEMAP: begin//����ɫ������ͼ
                  if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin //���ӱ���֧��
                    s4C := QuestActionInfo.sParam1;//��ͼ����
                  end;
                  if CompareText(s4C, 'APPR') = 0 then begin//ʦͽ��ͼ���� 20080422
                     User :=UserEngine.GetPlayObject(PlayObject.m_sMasterName);
                     if User <> nil then begin
                       s4C:= User.m_sMapName;
                       User.MapRandomMove(PlayObject.m_sMapName, 0);
                       PlayObject.MapRandomMove(s4C, 0);
                     end;
                  end else
                  if CompareText(s4C, 'DEAR') = 0 then begin//���޵�ͼ���� 20080422
                     if PlayObject.m_DearHuman <> nil then begin
                        s4C:= PlayObject.m_DearHuman.m_sMapName;
                        PlayObject.m_DearHuman.MapRandomMove(PlayObject.m_sMapName, 0);
                        PlayObject.MapRandomMove(s4C, 0);
                     end;
                  end else begin
                    Envir := g_MapManager.FindMap(s4C);
                    if Envir <> nil then begin
                      List58 := TList.Create;
                      UserEngine.GetMapRageHuman(Envir, 0, 0, 1000, List58);
                      if List58.Count > 0 then begin
                        User := TPlayObject(List58.Items[0]);
                        User.MapRandomMove(Self.m_sMapName, 0);
                      end;
                      List58.Free;
                      PlayObject.MapRandomMove(s4C, 0);
                    end else begin
                      ScriptActionError(PlayObject, '', QuestActionInfo, sEXCHANGEMAP);
                    end;
                  end;
                end;
              nRECALLMAP: begin
                  if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin //���ӱ���֧��
                    s4C := QuestActionInfo.sParam1;
                  end;
                  Envir := g_MapManager.FindMap(s4C);
                  if Envir <> nil then begin
                    List58 := TList.Create;
                    UserEngine.GetMapRageHuman(Envir, 0, 0, 1000, List58);
                    if List58.Count > 0 then begin//20080629
                      for II := 0 to List58.Count - 1 do begin
                        User := TPlayObject(List58.Items[II]);
                        User.MapRandomMove(Self.m_sMapName, 0);
                        if II > 20 then Break;
                      end;
                    end;
                    List58.Free;
                  end else begin
                    ScriptActionError(PlayObject, '', QuestActionInfo, sRECALLMAP);
                  end;
                end;
              nADDBATCH: List1C.AddObject(QuestActionInfo.sParam1, TObject(n18));
              nBATCHDELAY: n18 := QuestActionInfo.nParam1 * 1000;
              nBATCHMOVE: begin
                  if List1C.Count > 0 then begin//20080629
                    for II := 0 to List1C.Count - 1 do begin
                      PlayObject.SendDelayMsg(Self, RM_10155, 0, 0, 0, 0, List1C.Strings[II], Integer(List1C.Objects[II]) + n20);
                      Inc(n20, Integer(List1C.Objects[II]));
                    end;
                  end;
                end;
              nPLAYDICE: begin
                  PlayObject.m_sPlayDiceLabel := QuestActionInfo.sParam2;
                  PlayObject.SendMsg(Self,
                    RM_PLAYDICE,
                    QuestActionInfo.nParam1,
                    MakeLong(MakeWord(PlayObject.m_DyVal[0], PlayObject.m_DyVal[1]), MakeWord(PlayObject.m_DyVal[2], PlayObject.m_DyVal[3])),
                    MakeLong(MakeWord(PlayObject.m_DyVal[4], PlayObject.m_DyVal[5]), MakeWord(PlayObject.m_DyVal[6], PlayObject.m_DyVal[7])),
                    MakeLong(MakeWord(PlayObject.m_DyVal[8], PlayObject.m_DyVal[9]), 0),
                    QuestActionInfo.sParam2);
                  bo11 := True;
                end;

              nSetOnTimer:Begin //���˶�ʱ��(����) 20080510
                 if PlayObject <> nil then begin
                  n28 := Str_ToInt(QuestActionInfo.sParam1, 0);
                  n2C := Str_ToInt(QuestActionInfo.sParam2, 0);
                  n28 := n28 mod 10;
                  if (n28 > 9) or (n28 < 0) then n28:= 0;//20081008
                  PlayObject.AutoTimerStatus[n28]:= n2c * 1000;
                  PlayObject.AutoTimerTick[n28]:= GetTickCount;
                 end;
              end;
              nSetOffTimer:Begin //ֹͣ��ʱ�� 20080510
                 if PlayObject <> nil then begin
                   n28 := Str_ToInt(QuestActionInfo.sParam1, 0);
                   n28 := n28 mod 10;
                   if (n28 > 9) or (n28 < 0) then n28:= 0;//20081008
                   PlayObject.AutoTimerStatus[n28]:= 0;
                 end;
              end;

              nADDNAMELIST: AddList(PlayObject.m_sCharName, m_sPath + QuestActionInfo.sParam1);
              nDELNAMELIST: DelList(PlayObject.m_sCharName, m_sPath + QuestActionInfo.sParam1);
              nADDGUILDLIST: if PlayObject.m_MyGuild <> nil then AddList(TGUild(PlayObject.m_MyGuild).sGuildName, m_sPath + QuestActionInfo.sParam1);
              nDELGUILDLIST: if PlayObject.m_MyGuild <> nil then DelList(TGUild(PlayObject.m_MyGuild).sGuildName, m_sPath + QuestActionInfo.sParam1);
              nSENDMSG: ActionOfLineMsg(PlayObject, QuestActionInfo);//����������Ϣ
              nCREATEFILE: ActionOfCreateFile(PlayObject, QuestActionInfo);//�����ı��ļ� 20081226
      //------------------------------------------------------------------------------------------------------------------
      //20080105 ���⹫��
              nSENDTOPMSG:ActionOfSendTopMsg(PlayObject, QuestActionInfo);//���˹�������
              nSENDCENTERMSG:ActionOfSendCenterMsg(PlayObject, QuestActionInfo);//��Ļ������ʾ����
              nSENDEDITTOPMSG:ActionOfSendEditTopMsg(PlayObject, QuestActionInfo);//����򶥶˹���
      //------------------------���ϵͳ----------------------------------------------
              nOPENMAKEWINE:ActionOfOPENMAKEWINE(PlayObject, QuestActionInfo);//����ƴ��� 20080619
              nGETGOODMAKEWINE:ActionOfGETGOODMAKEWINE(PlayObject, QuestActionInfo);//ȡ����õľ� 20080620
              nDECMAKEWINETIME:ActionOfDECMAKEWINETIME(PlayObject, QuestActionInfo);//������Ƶ�ʱ�� 20080620
              nREADSKILLNG:ActionOfREADSKILLNG(PlayObject, QuestActionInfo);//ѧϰ�ڹ� 20081001
              nMAKEWINENPCMOVE:ActionOfMAKEWINENPCMOVE(PlayObject, QuestActionInfo);//���NPC���߶� 20080621
              nFOUNTAIN:ActionOfFOUNTAIN(PlayObject, QuestActionInfo);//����Ȫˮ�緢 20080621
              nSETGUILDFOUNTAIN:ActionOfSETGUILDFOUNTAIN(PlayObject, QuestActionInfo);//����/�ر��л�Ȫˮ�ֿ� 20080625
              nGIVEGUILDFOUNTAIN:ActionOfGIVEGUILDFOUNTAIN(PlayObject, QuestActionInfo);//��ȡ�л��ˮ 20080625
      //------------------------------------------------------------------------------
              nCHALLENGMAPMOVE:ActionOfCHALLENGMAPMOVE(PlayObject, QuestActionInfo);//��ս��ͼ�ƶ� 20080705
              nGETCHALLENGEBAKITEM:ActionOfGETCHALLENGEBAKITEM(PlayObject, QuestActionInfo);//û����ս��ͼ���ƶ�,���˻ص�Ѻ����Ʒ 20080705
      //------------------------------------------------------------------------------
              nHEROLOGOUT:ActionOfHEROLOGOUT(PlayObject, QuestActionInfo);//��������Ӣ������ 20080716
              nGETSORTNAME:ActionOfGETSORTNAME(PlayObject, QuestActionInfo);//ȡָ�����а�ָ��������������� 20080531
              nWEBBROWSER:ActionOfWEBBROWSER(PlayObject, QuestActionInfo);//����ָ����վ��ַ 20080602
              nKICKALLPLAY:ActionOfKICKALLPLAY(PlayObject, QuestActionInfo);//�߳��������������� 20080609
              nREPAIRALL:ActionOfREPAIRALL(PlayObject, QuestActionInfo);//����ȫ��װ�� 20080613
              nCHANGESKILL:ActionOfCHANGESKILL(PlayObject, QuestActionInfo);//����:�޸�ħ��ID 20080624
              nAUTOGOTOXY:ActionOfAUTOGOTOXY(PlayObject, QuestActionInfo);//�Զ�Ѱ· 20080617
              nADDATTACKSABUKALL:ActionOfADDATTACKSABUKALL(PlayObject, QuestActionInfo);//���������лṥ�� 20080609
              nOPENBOOKS:ActionOfOPENBOOKS(PlayObject, QuestActionInfo);//���� 20080119
              nOPENYBDEAL:ActionOfOPENYBDEAL(PlayObject, QuestActionInfo);//��ͨԪ������ 20080316
              nQUERYYBSELL:ActionOfQUERYYBSELL(PlayObject, QuestActionInfo);//��ѯ���ڳ��۵���Ʒ 20080317
              nQUERYYBDEAL:ActionOfQUERYYBDEAL(PlayObject, QuestActionInfo);//��ѯ���ԵĹ�����Ʒ 20080317
              nTHROUGHHUM:ActionOfTHROUGHHUM(PlayObject, QuestActionInfo);//�ı䴩��ģʽ 20080221
              nSETITEMSLIGHT:ActionOfSetItemsLight(PlayObject, QuestActionInfo);//װ���������� 20080223
              nOPENDRAGONBOX:ActionOfOpenDragonBox(PlayObject, QuestActionInfo);//���������� 20080306
              nQUERYREFINEITEM:ActionOfQUERYREFINEITEM(PlayObject, QuestActionInfo);//�򿪴������� 20080502
              nGOHOME:ActionOfGOHOME(PlayObject, QuestActionInfo);//�ƶ����سǵ� 20080503
              nTHROWITEM:ActionOfTHROWITEM(PlayObject, QuestActionInfo);//��ָ����Ʒˢ�µ�ָ����ͼ���귶Χ�� 20080508
              nCLEARCODELIST:ActionOfCLEARCODELIST(PlayObject, QuestActionInfo);//ɾ��ָ���ı���ı��� 20080410
              nGETRANDOMNAME:ActionOfGetRandomName(PlayObject, QuestActionInfo);//���ļ������ȡ�ı� 20080126
              nHCall:ActionOfHCall(PlayObject, QuestActionInfo);//ͨ���ű������ñ���ִ��QManage.txt�еĽű� 20080422
              nINCASTLEWARAY:ActionOfINCASTLEWARAY(PlayObject, QuestActionInfo);//��������Ƿ��ڹ����ڼ�ķ�Χ�ڣ�����BB�ѱ� 20080422
              nGIVESTATEITEM:ActionOfGIVESTATEITEM(PlayObject, QuestActionInfo);//�������״̬װ�� 20080312
              nSETITEMSTATE:ActionOfSETITEMSTATE(PlayObject, QuestActionInfo);//����װ����״̬ 20080312
              nADDACCOUNTLIST: AddList(PlayObject.m_sUserID, m_sPath + QuestActionInfo.sParam1);
              nDELACCOUNTLIST: DelList(PlayObject.m_sUserID, m_sPath + QuestActionInfo.sParam1);
              nADDIPLIST: AddList(PlayObject.m_sIPaddr, m_sPath + QuestActionInfo.sParam1);
              nDELIPLIST: DelList(PlayObject.m_sIPaddr, m_sPath + QuestActionInfo.sParam1);
              nGOQUEST: GoToQuest(QuestActionInfo.nParam1);
              nENDQUEST: PlayObject.m_Script := nil;
              nGOTO: begin
                  if not JmpToLable(QuestActionInfo.sParam1) then begin
                    MainOutMessage('[�ű���ѭ��] NPC:' + m_sCharName +
                      ' λ��:' + m_sMapName + '(' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) + ')' +
                      ' ����:' + sGOTO + ' ' + QuestActionInfo.sParam1);
                    Result := False;
                    Exit;
                  end;
                end;

              nSC_HAIRSTYLE: ActionOfChangeHairStyle(PlayObject, QuestActionInfo);
              nSC_CLEARNAMELIST: ActionOfClearNameList(PlayObject, QuestActionInfo);
              nSC_CHANGELEVEL: ActionOfChangeLevel(PlayObject, QuestActionInfo);
              nSC_MARRY: ActionOfMarry(PlayObject, QuestActionInfo);
              nSC_MASTER: ActionOfMaster(PlayObject, QuestActionInfo);
              nSC_UNMASTER: ActionOfUnMaster(PlayObject, QuestActionInfo);
              nSC_UNMARRY: ActionOfUnMarry(PlayObject, QuestActionInfo);
              nSC_GETMARRY: ActionOfGetMarry(PlayObject, QuestActionInfo);
              nSC_GETMASTER: ActionOfGetMaster(PlayObject, QuestActionInfo);
              nSC_CLEARSKILL: ActionOfClearSkill(PlayObject, QuestActionInfo);
              nSC_DELNOJOBSKILL: ActionOfDelNoJobSkill(PlayObject, QuestActionInfo);
              nSC_DELSKILL: ActionOfDelSkill(PlayObject, QuestActionInfo);
              nSC_ADDSKILL: ActionOfAddSkill(PlayObject, QuestActionInfo);
              nSC_ADDGUILDMEMBER: ActionOfADDGUILDMEMBER(PlayObject, QuestActionInfo);//����л��Ա//20080427
              nSC_DELGUILDMEMBER: ActionOfDELGUILDMEMBER(PlayObject, QuestActionInfo);//ɾ���л��Ա��ɾ��������Ч��//20080427
              nSC_SKILLLEVEL: ActionOfSkillLevel(PlayObject, QuestActionInfo);//�������＼�ܵȼ�
              nSC_HEROSKILLLEVEL: ActionOfHeroSkillLevel(PlayObject, QuestActionInfo);//����Ӣ�ۼ��ܵȼ� 20080415
              nSC_CHANGEPKPOINT: ActionOfChangePkPoint(PlayObject, QuestActionInfo);
              nSC_CHANGEEXP: ActionOfChangeExp(PlayObject, QuestActionInfo);
              nSC_CHANGENGEXP: ActionOfChangeNGExp(PlayObject, QuestActionInfo);//�����ڹ����� 20081001
              nSC_CHANGENGLEVEL: ActionOfCHANGENGLEVEL(PlayObject, QuestActionInfo);//�����ڹ��ȼ� 20081004
              nSC_OPENEXPCRYSTAL: ActionOfOPENEXPCRYSTAL(PlayObject, QuestActionInfo);//�ͻ�����ʾ��ؽᾧ 20090131
              nSC_CLOSEEXPCRYSTAL: ActionOfCLOSEEXPCRYSTAL(PlayObject, QuestActionInfo);//�ͻ��˹ر���ؽᾧ 20090131
              nSC_GETEXPTOCRYSTAL: ActionOfGETEXPTOCRYSTAL(PlayObject, QuestActionInfo);//ȡ����ؽᾧ�еľ���(ֻ��ȡ����ȡ�ľ���) 20090202
              nSC_SENDTIMEMSG: ActionOfSENDTIMEMSG(PlayObject, QuestActionInfo);//ʱ�䵽�ⷢ�ű���(�ͻ�����ʾʱ��) 20090124
              nSC_SENDMSGWINDOWS: ActionOfSENDMSGWINDOWS(PlayObject, QuestActionInfo);//ʱ�䵽�ⷢ�ű��� 20090124
              nSC_CLOSEMSGWINDOWS: ActionOfCLOSEMSGWINDOWS(PlayObject, QuestActionInfo);//�رտͻ���'!'ͼ�����ʾ 20090126
              nSC_GETGROUPCOUNT: ActionOfGETGROUPCOUNT(PlayObject, QuestActionInfo);//ȡ��ӳ�Ա�� 20090125
              nSC_CHANGEJOB: ActionOfChangeJob(PlayObject, QuestActionInfo);
              nSC_MISSION: ActionOfMission(PlayObject, QuestActionInfo);
              nSC_MOBPLACE: ActionOfMobPlace(PlayObject, QuestActionInfo, n34, n38, n3C, n40);
              nSC_SETMEMBERTYPE: ActionOfSetMemberType(PlayObject, QuestActionInfo);
              nSC_SETMEMBERLEVEL: ActionOfSetMemberLevel(PlayObject, QuestActionInfo);
              nSC_GAMEGOLD: ActionOfGameGold(PlayObject, QuestActionInfo);
              nSC_GAMEDIAMOND: ActionOfGameDiaMond(PlayObject, QuestActionInfo);//���ʯ 20071226
              nSC_GAMEGIRD: ActionOfGameGird(PlayObject, QuestActionInfo); //��� 20071226
              nSC_CHANGEHUMABILITY: ActionOfCHANGEHUMABILITY(PlayObject, QuestActionInfo);//������������ 20080609
              nSC_CHANGEHEROLOYAL: ActionOfHEROLOYAL(PlayObject, QuestActionInfo); //����Ӣ�۵��ҳ϶� 20080109
              nSC_CHANGEHEROTRANPOINT: ActionOfCHANGEHEROTRANPOINT(PlayObject, QuestActionInfo); //����Ӣ�ۼ����������� 20080512
      //----------------------�ƹ�ϵͳ-----------------------------------------------
              nSC_SAVEHERO: ActionOfSAVEHERO(PlayObject, QuestActionInfo);//�ķ�Ӣ��
              nSC_GETHERO: ActionOfGETHERO(PlayObject, QuestActionInfo);//ȡ��Ӣ��
              nSC_CLOSEDRINK: ActionOfCLOSEDRINK(PlayObject, QuestActionInfo);//�رն��ƴ���
              nSC_PLAYDRINKMSG: ActionOfPLAYDRINKMSG(PlayObject, QuestActionInfo);//���ƴ���˵����Ϣ 20080514
              nSC_OPENPLAYDRINK: ActionOfOPENPLAYDRINK(PlayObject, QuestActionInfo);//ָ������Ⱦ� 20080514
      //-----------------------------------------------------------------------------
              nSC_GAMEPOINT: ActionOfGamePoint(PlayObject, QuestActionInfo);
              nSC_AUTOADDGAMEGOLD: ActionOfAutoAddGameGold(PlayObject, QuestActionInfo, n34, n38);
              nSC_AUTOSUBGAMEGOLD: ActionOfAutoSubGameGold(PlayObject, QuestActionInfo, n34, n38);
              nSC_CHANGENAMECOLOR: ActionOfChangeNameColor(PlayObject, QuestActionInfo);
              nSC_CLEARPASSWORD: ActionOfClearPassword(PlayObject, QuestActionInfo);
              nSC_RENEWLEVEL: ActionOfReNewLevel(PlayObject, QuestActionInfo);
              nSC_KILLSLAVE: ActionOfKillSlave(PlayObject, QuestActionInfo);
              nSC_CHANGEGENDER: ActionOfChangeGender(PlayObject, QuestActionInfo);
              nSC_KILLMONEXPRATE: ActionOfKillMonExpRate(PlayObject, QuestActionInfo);
              nSC_POWERRATE: ActionOfPowerRate(PlayObject, QuestActionInfo);//���ù���������
              nSC_CHANGEMODE: ActionOfChangeMode(PlayObject, QuestActionInfo);//�ı����ģʽ
              nSC_CHANGEPERMISSION: ActionOfChangePerMission(PlayObject, QuestActionInfo);
              nSC_KILL: ActionOfKill(PlayObject, QuestActionInfo);
              nSC_KICK: ActionOfKick(PlayObject, QuestActionInfo);
              nSC_BONUSPOINT: ActionOfBonusPoint(PlayObject, QuestActionInfo);
              nSC_RESTRENEWLEVEL: ActionOfRestReNewLevel(PlayObject, QuestActionInfo);
              nSC_DELMARRY: ActionOfDelMarry(PlayObject, QuestActionInfo);
              nSC_DELMASTER: ActionOfDelMaster(PlayObject, QuestActionInfo);
              nSC_CREDITPOINT: ActionOfChangeCreditPoint(PlayObject, QuestActionInfo);
              nSC_CHANGEGUILDMEMBERCOUNT: ActionOfCHANGEGUILDMEMBERCOUNT(PlayObject, QuestActionInfo);//�����л��Ա���� 20090115
              nSC_CHANGEGUILDFOUNTAIN: ActionOfCHANGEGUILDFOUNTAIN(PlayObject, QuestActionInfo);//�����л��Ȫ 20081007
              nSC_TAGMAPINFO: ActionOfTAGMAPINFO(PlayObject, QuestActionInfo);//��·��ʯ 20081019
              nSC_TAGMAPMOVE: ActionOfTAGMAPMOVE(PlayObject, QuestActionInfo);//�ƶ�����·��ʯ��¼�ĵ�ͼXY 20081019
              nSC_GAMEGLORY : ActionOfChangeCreditGlory(PlayObject, QuestActionInfo); //��������ֵ 20080511
              nSC_CLEARNEEDITEMS: ActionOfClearNeedItems(PlayObject, QuestActionInfo);
              nSC_CLEARMAEKITEMS: ActionOfClearMakeItems(PlayObject, QuestActionInfo);
              nSC_SETSENDMSGFLAG: PlayObject.m_boSendMsgFlag := True;
              nSC_UPGRADEITEMS: ActionOfUpgradeItems(PlayObject, QuestActionInfo);
              nSC_UPGRADEITEMSEX: ActionOfUpgradeItemsEx(PlayObject, QuestActionInfo);
              nSC_GIVEMINE: ActionOfGIVEMINE(PlayObject, QuestActionInfo);//20080330 ����ʯ
              nSC_MONGENEX: ActionOfMonGenEx(PlayObject, QuestActionInfo);
              nSC_CLEARMAPMON: ActionOfClearMapMon(PlayObject, QuestActionInfo);
              nSC_SETMAPMODE: ActionOfSetMapMode(PlayObject, QuestActionInfo);
              nSC_PKZONE: ActionOfPkZone(PlayObject, QuestActionInfo);
              nSC_RESTBONUSPOINT: ActionOfRestBonusPoint(PlayObject, QuestActionInfo);
              nSC_TAKECASTLEGOLD: ActionOfTakeCastleGold(PlayObject, QuestActionInfo);
              nSC_HUMANHP: ActionOfHumanHP(PlayObject, QuestActionInfo);
              nSC_HUMANMP: ActionOfHumanMP(PlayObject, QuestActionInfo);
              nSC_BUILDPOINT: ActionOfGuildBuildPoint(PlayObject, QuestActionInfo);
              nSC_AURAEPOINT: ActionOfGuildAuraePoint(PlayObject, QuestActionInfo);
              nSC_STABILITYPOINT: ActionOfGuildstabilityPoint(PlayObject, QuestActionInfo);
              nSC_FLOURISHPOINT: ActionOfGuildFlourishPoint(PlayObject, QuestActionInfo);
              nSC_OPENMAGICBOX: ActionOfOpenMagicBox(PlayObject, QuestActionInfo);
              nSC_SETRANKLEVELNAME: ActionOfSetRankLevelName(PlayObject, QuestActionInfo);
              nSC_GMEXECUTE: ActionOfGmExecute(PlayObject, QuestActionInfo);
              nSC_GUILDCHIEFITEMCOUNT: ActionOfGuildChiefItemCount(PlayObject, QuestActionInfo);
              nSC_ADDUSERDATE: ActionOfAddNameDateList(PlayObject, QuestActionInfo);
              nSC_DELUSERDATE: ActionOfDelNameDateList(PlayObject, QuestActionInfo);
              nSC_MOBFIREBURN: ActionOfMobFireBurn(PlayObject, QuestActionInfo);
              nSC_MESSAGEBOX: ActionOfMessageBox(PlayObject, QuestActionInfo);
              nSC_SETSCRIPTFLAG: ActionOfSetScriptFlag(PlayObject, QuestActionInfo);
              nSC_SETAUTOGETEXP: ActionOfAutoGetExp(PlayObject, QuestActionInfo);
              nSC_VAR: ActionOfVar(PlayObject, QuestActionInfo);
              nSC_LOADVAR: ActionOfLoadVar(PlayObject, QuestActionInfo);
              nSC_SAVEVAR: ActionOfSaveVar(PlayObject, QuestActionInfo);
              nSC_CALCVAR: ActionOfCalcVar(PlayObject, QuestActionInfo);
              nOFFLINEPLAY: ActionOfNotLineAddPiont(PlayObject, QuestActionInfo);
              nKICKOFFLINE: ActionOfKickNotLineAddPiont(PlayObject, QuestActionInfo);
              nSTARTTAKEGOLD: ActionOfStartTakeGold(PlayObject);
              nDELAYGOTO: begin //��ʱ��ת 20080402
                  PlayObject.m_boTimeGoto := True;
                  m_DelayGoto:= Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam1), 0);//20081213 ���ӱ�������
                  if m_DelayGoto = 0 then begin
                    GetValValue(PlayObject, QuestActionInfo.sParam1, n20);
                    m_DelayGoto:= n20;
                  end;
                  if m_DelayGoto > 0 then begin
                    PlayObject.m_dwTimeGotoTick := GetTickCount + LongWord(m_DelayGoto);
                  end else PlayObject.m_dwTimeGotoTick := GetTickCount + LongWord(QuestActionInfo.nParam1{ * 1000});//�ĳɺ��� 20080402
                  PlayObject.m_sTimeGotoLable := QuestActionInfo.sParam2;
                  PlayObject.m_TimeGotoNPC := Self;
                end;
              nCLEARDELAYGOTO: begin
                  PlayObject.m_boTimeGoto := False;
                  PlayObject.m_sTimeGotoLable := '';
                  PlayObject.m_TimeGotoNPC := nil;
                end;
              nSC_ANSIREPLACETEXT: ActionOfAnsiReplaceText(PlayObject, QuestActionInfo);
              nSC_ENCODETEXT: ActionOfEncodeText(PlayObject, QuestActionInfo);
              nSC_ADDTEXTLIST: begin//20080614 �޸�
                  s50 := GetLineVariableText(PlayObject,QuestActionInfo.sParam2);//�ļ�·��֧�ֱ��� 20080529
                  if s50[1] = '\' then s50 := Copy(s50, 2, Length(s50) - 1); //20081228 ����,�����ļ�·��
                  if s50[2] = '\' then s50 := Copy(s50, 3, Length(s50) - 2);
                  if s50[3] = '\' then s50 := Copy(s50, 4, Length(s50) - 3);
                  s4C := GetLineVariableText(PlayObject,QuestActionInfo.sParam1);
                  if s4C ='' then begin
                    if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin
                      s4C := QuestActionInfo.sParam1;
                    end;
                  end;
                  AddList(s4C, {m_sPath +}s50);//20081228
                end;
              nSC_DELTEXTLIST: begin//20080614 �޸�
                  s50 := GetLineVariableText(PlayObject,QuestActionInfo.sParam2);//�ļ�·��֧�ֱ��� 20080529
                  if s50[1] = '\' then s50 := Copy(s50, 2, Length(s50) - 1); //20081228 ����,�����ļ�·��
                  if s50[2] = '\' then s50 := Copy(s50, 3, Length(s50) - 2);
                  if s50[3] = '\' then s50 := Copy(s50, 4, Length(s50) - 3);
                  s4C := GetLineVariableText(PlayObject,QuestActionInfo.sParam1);//����
                  if s4C ='' then begin
                    if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin
                      s4C := QuestActionInfo.sParam1;
                    end;
                  end;
                  DelList(s4C, {m_sPath + }s50);//20081228
                end;
              nSC_GROUPMOVE: begin
                  s4C:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//20080516 ����
                  if s4C = '' then begin
                    if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin //���ӱ���֧��
                      s4C := QuestActionInfo.sParam1;
                    end;
                  end;
                  if (PlayObject.m_GroupOwner <> nil) and (PlayObject = PlayObject.m_GroupOwner) then begin
                    if PlayObject.m_GroupOwner.m_GroupMembers.Count > 0 then begin//20080629
                      for II := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
                        if (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boDeath) and
                          (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boGhost){ and (TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boAllowGroupReCall) }then begin
                          TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).MapRandomMove(s4C, 0);
                        end;
                      end;//for
                    end;
                    PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                    //PlayObject.MapRandomMove(s4C, 0);//20080615 ע��,�����ӳ��ظ����δ���
                    bo11 := True;
                  end;
                end;
              nSC_GROUPMAPMOVE: begin //��ഫ��,ֻ�жӳ�����ʹ��  ���Ӵ����Σ����г�Ա�ɴ���QFָ�������� 20090126
                  if (QuestActionInfo.sParam1 <> '') and (QuestActionInfo.sParam1[1] = '<') and (QuestActionInfo.sParam1[2] = '$') then
                    s4C:= GetLineVariableText(PlayObject, QuestActionInfo.sParam1)//20090113
                  else
                  if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin //��ͼ��
                    s4C := QuestActionInfo.sParam1;
                  end;

                  if (QuestActionInfo.sParam2 <> '') and (QuestActionInfo.sParam2[1] = '<') and (QuestActionInfo.sParam2[2] = '$') then
                    n14:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam2), 0)//20090113
                  else
                  if not GetValValue(PlayObject, QuestActionInfo.sParam2, n14) then begin //X
                    n14 := QuestActionInfo.nParam2;
                  end;

                  if (QuestActionInfo.sParam3 <> '') and (QuestActionInfo.sParam3[1] = '<') and (QuestActionInfo.sParam3[2] = '$') then
                    n40:= Str_ToInt(GetLineVariableText(PlayObject, QuestActionInfo.sParam3), 0)//20090113
                  else
                  if not GetValValue(PlayObject, QuestActionInfo.sParam3, n40) then begin //Y
                    n40 := QuestActionInfo.nParam3;
                  end;                                                  
                  if (PlayObject.m_GroupOwner <> nil) and (PlayObject = PlayObject.m_GroupOwner) then begin
                    if PlayObject.m_GroupOwner.m_GroupMembers.Count > 0 then begin//20080629
                      for II := 0 to PlayObject.m_GroupOwner.m_GroupMembers.Count - 1 do begin
                        if (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boDeath) and
                          (not TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boGhost){ and (TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).m_boAllowGroupReCall) }then begin
                            TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]).SpaceMove(s4C, n14, n40, 0);
                            if (QuestActionInfo.sParam4 <> '') then Begin//�Ƿ����ô����� 20090126
                              if (g_FunctionNPC <> nil) then begin
                                g_FunctionNPC.GotoLable(TPlayObject(PlayObject.m_GroupOwner.m_GroupMembers.Objects[II]), QuestActionInfo.sParam4, False);
                              end;
                            end;
                        end;
                      end;//for
                    end;
                    PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                    //PlayObject.SpaceMove(s4C, n14, n40, 0);//20080615 ע��,�����ӳ��ظ����δ���
                    bo11 := True;
                  end;
                end;
              nSC_RECALLHUMAN: begin
                  s4C := QuestActionInfo.sParam1;
                  GetValValue(PlayObject, QuestActionInfo.sParam1, s4C);
                  if s4C <> '' then begin
                    PlayObject.RecallHuman(s4C);
                  end;
                end;
              nSC_REGOTO: begin
                  s4C := QuestActionInfo.sParam1;
                  GetValValue(PlayObject, QuestActionInfo.sParam1, s4C);
                  if s4C <> '' then begin
                    OnlinePlayObject := UserEngine.GetPlayObject(s4C);
                    if PlayObject <> nil then begin
                      PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                      PlayObject.SpaceMove(OnlinePlayObject.m_PEnvir.sMapName, OnlinePlayObject.m_nCurrX, OnlinePlayObject.m_nCurrY, 0);
                      bo11 := True;
                    end;
                  end;
                end;
              nSC_INTTOSTR: begin
                  n40 := 0;
                  GetValValue(PlayObject, QuestActionInfo.sParam2, n40);
                  n14 := GetValNameNo(QuestActionInfo.sParam1);
                  if n14 >= 0 then begin
                    case n14 of
                      600..699: begin
                          PlayObject.m_sString[n14 - 600] := IntToStr(n40);
                        end;
                      700..799: begin
                          g_Config.GlobalAVal[n14 - 700] := IntToStr(n40);
                        end;
                      1200..1599:begin//20080903 A����(100-499)
                          g_Config.GlobalAVal[n14 - 1100] := IntToStr(n40);
                        end;
                    else begin
                        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_INTTOSTR);
                      end;
                    end;
                  end;
                end;
              nSC_STRTOINT: begin
                  GetValValue(PlayObject, QuestActionInfo.sParam1, s4C);
                  n14 := GetValNameNo(QuestActionInfo.sParam1);
                  if n14 >= 0 then begin
                    case n14 of
                      0..99: begin //20080323 ԭΪ0..99
                          PlayObject.m_nVal[n14] := Str_ToInt(s4C, 0);
                        end;
                      100..199: begin
                          g_Config.GlobalVal[n14 - 100] := Str_ToInt(s4C, 0);
                        end;
                      200..299: begin //20080323 ԭΪ200..209
                          PlayObject.m_DyVal[n14 - 200] := Str_ToInt(s4C, 0);
                        end;
                      300..399: begin
                          PlayObject.m_nMval[n14 - 300] := Str_ToInt(s4C, 0);
                        end;
                      400..499: begin
                          g_Config.GlobaDyMval[n14 - 400] := Str_ToInt(s4C, 0);
                        end;
                      500..599: begin
                          PlayObject.m_nInteger[n14 - 500] := Str_ToInt(s4C, 0);
                        end;
                      800..1199:begin//20080903 G����
                          g_Config.GlobalVal[n14 - 700] := Str_ToInt(s4C, 0);
                        end;
                     {1800..2799:begin//20080323 I����
                          g_Config.GlobaDyMval[n14 - 1800]:= Str_ToInt(s4C, 0);
                        end; }
                    else begin
                        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_STRTOINT);
                      end;
                    end;
                  end;
                end;
              nSC_GUILDMOVE: begin
                  if PlayObject.m_MyGuild = nil then Exit;
                  if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin //���ӱ���֧��
                    s4C := QuestActionInfo.sParam1;
                  end;
                  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                  PlayObject.MapRandomMove(s4C, 0);
                  if TGUild(PlayObject.m_MyGuild).m_RankList.Count > 0 then begin//20080629
                    for II := 0 to TGUild(PlayObject.m_MyGuild).m_RankList.Count - 1 do begin
                      GuildRank := TGUild(PlayObject.m_MyGuild).m_RankList.Items[II];
                      if GuildRank = nil then Continue;
                      if GuildRank.MemberList.Count > 0 then begin//20080629
                        for III := 0 to GuildRank.MemberList.Count - 1 do begin
                          UserObject := TPlayObject(GuildRank.MemberList.Objects[III]);
                          if UserObject = nil then Continue;
                          if (not UserObject.m_boDeath) and (not UserObject.m_boGhost) and (UserObject.m_boAllowGuildReCall) then
                            UserObject.MapRandomMove(s4C, 0);
                        end;
                      end;
                    end;//for
                  end;
                  bo11 := True;
                end;
              nSC_GUILDMAPMOVE: begin
                  if PlayObject.m_MyGuild = nil then Exit;
                  if not GetValValue(PlayObject, QuestActionInfo.sParam1, s4C) then begin //���ӱ���֧��
                    s4C := QuestActionInfo.sParam1;
                  end;
                  if not GetValValue(PlayObject, QuestActionInfo.sParam2, n14) then begin //���ӱ���֧��
                    n14 := QuestActionInfo.nParam2;
                  end;
                  if not GetValValue(PlayObject, QuestActionInfo.sParam3, n40) then begin //���ӱ���֧��
                    n40 := QuestActionInfo.nParam3;
                  end;
                  PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
                  PlayObject.SpaceMove(s4C, n14, n40, 0);
                  if TGUild(PlayObject.m_MyGuild).m_RankList.Count > 0 then begin//20080629
                    for II := 0 to TGUild(PlayObject.m_MyGuild).m_RankList.Count - 1 do begin
                      GuildRank := TGUild(PlayObject.m_MyGuild).m_RankList.Items[II];
                      if GuildRank = nil then Continue;
                      if GuildRank.MemberList.Count > 0 then begin//20080629
                        for III := 0 to GuildRank.MemberList.Count - 1 do begin
                          UserObject := TPlayObject(GuildRank.MemberList.Objects[III]);
                          if UserObject = nil then Continue;
                          if (not UserObject.m_boDeath) and (not UserObject.m_boGhost) and (UserObject.m_boAllowGuildReCall) then
                            UserObject.SpaceMove(s4C, n14, n40, 0);
                        end;
                      end;
                    end;//for
                  end;
                  bo11 := True;
                end;
              nSC_RANDOMMOVE: begin
                  PlayObject.RandomMove();
                  bo11 := True;
                end;
              nSC_USEBONUSPOINT: ActionOfUseBonusPoint(PlayObject, QuestActionInfo);
              nSC_REPAIRITEM: ActionOfRepairItem(PlayObject, QuestActionInfo);
              nSC_TAKEONITEM: ActionOfTakeOnItem(PlayObject, QuestActionInfo);//����װ��
              nSC_TAKEOFFITEM: ActionOfTakeOffItem(PlayObject, QuestActionInfo);//����װ��

              //=================================Ӣ�����=====================================
              nSC_CREATEHERO: ActionOfCreateHero(PlayObject, QuestActionInfo);
              nSC_DELETEHERO: ActionOfDeleteHero(PlayObject, QuestActionInfo);
              nSC_CHANGEHEROLEVEL: ActionOfChangeHeroLevel(PlayObject, QuestActionInfo);
              nSC_CHANGEHEROJOB: ActionOfChangeHeroJob(PlayObject, QuestActionInfo);
              nSC_CLEARHEROSKILL: ActionOfClearHeroSkill(PlayObject, QuestActionInfo); //���Ӣ�ۼ���
              nSC_CHANGEHEROPKPOINT: ActionOfChangeHeroPKPoint(PlayObject, QuestActionInfo);
              nSC_CHANGEHEROEXP: ActionOfChangeHeroExp(PlayObject, QuestActionInfo);

            {else begin
                if Assigned(zPlugOfEngine.ActionScriptProcess) then begin
                  zPlugOfEngine.ActionScriptProcess(Self,
                    PlayObject,
                    QuestActionInfo.nCMDCode,
                    PChar(QuestActionInfo.sParam1),
                    QuestActionInfo.nParam1,
                    PChar(QuestActionInfo.sParam2),
                    QuestActionInfo.nParam2,
                    PChar(QuestActionInfo.sParam3),
                    QuestActionInfo.nParam3,
                    PChar(QuestActionInfo.sParam4),
                    QuestActionInfo.nParam4,
                    PChar(QuestActionInfo.sParam5),
                    QuestActionInfo.nParam5,
                    PChar(QuestActionInfo.sParam6),
                    QuestActionInfo.nParam6);
                end;
              end;  }
            end;//Case
          end;
        end;//For
      end;
    except
      MainOutMessage('{�쳣} QuestActionProcess CMDCode:'+inttostr(CMDCode));
    end;
  end;
  procedure SendMerChantSayMsg(sMsg: string; boFlag: Boolean);
  var
    s10, s14: string;
    nC: Integer;
  begin
    s14 := sMsg;
    nC := 0;
    while (True) do begin
      if TagCount(s14, '>') < 1 then Break;
      s14 := ArrestStringEx(s14, '<', '>', s10);
      GetVariableText(PlayObject, sMsg, s10);
      Inc(nC);
      if nC >= 101 then Break;
    end;
    PlayObject.GetScriptLabel(sMsg);
    if boFlag then begin
      PlayObject.SendFirstMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/' + sMsg);
    end else begin
      PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/' + sMsg);
    end;
  end;
begin
  Inc(m_boGotoCount);
  if m_boGotoCount > 850 then begin//20081004 ��ֹM2���Ͻ���GoTo���ر�
    m_boGotoCount:= 0;
    MainOutMessage('[�ű��쳣] NPC:' + m_sCharName +
      ' λ��:' + m_sMapName + '(' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) + ')');
    Exit;
  end;
  Try
    Script := nil;        
    List1C := TStringList.Create;
    n20 := 0;
    nCode:= 0;//20081005
    Try
      if PlayObject.m_NPC <> Self then begin
        nCode:= 1;//20081005
        PlayObject.m_NPC := nil;
        PlayObject.m_Script := nil;
        FillChar(PlayObject.m_nVal, SizeOf(PlayObject.m_nVal), #0);
      end;
      if CompareText(sLabel, '@main') = 0 then begin
        if m_ScriptList.Count > 0 then begin//20080629
          for I := 0 to m_ScriptList.Count - 1 do begin
            nCode:= 2;//20081005
            Script3C := m_ScriptList.Items[I];
            if Script3C = nil then Continue;
            if Script3C.RecordList.Count > 0 then begin//20080629
              for II := 0 to Script3C.RecordList.Count - 1 do begin
                SayingRecord := Script3C.RecordList.Items[II];
                if SayingRecord = nil then Continue;
                if CompareText(sLabel, SayingRecord.sLabel) = 0 then begin
                  nCode:= 3;//20081005
                  Script := Script3C;
                  PlayObject.m_Script := Script;
                  PlayObject.m_NPC := Self;
                  Break;
                end;
                if Script <> nil then Break;
              end;
            end;
          end;//for
        end;
      end;
      nCode:= 4;//20081005
      if (Script = nil) then begin
        if (PlayObject.m_Script <> nil) then begin
          if m_ScriptList.Count > 0 then begin//20080629
            for I := m_ScriptList.Count - 1 downto 0 do begin
              if m_ScriptList.Count <= 0 then Break;
              if (m_ScriptList.Items[I] <> nil) and (m_ScriptList.Items[I] = PlayObject.m_Script) then begin
                Script := m_ScriptList.Items[I];
                if Script <> nil then Break;//20081005
              end;
            end;
          end;
        end;
        nCode:= 5;//20081005
        if (Script = nil) then begin
          if  m_ScriptList.Count > 0 then begin//20080629
            for I := m_ScriptList.Count - 1 downto 0 do begin
              if m_ScriptList.Count <= 0 then Break;
              if (pTScript(m_ScriptList.Items[I]) <> nil) and CheckQuestStatus(pTScript(m_ScriptList.Items[I])) then begin
                Script := m_ScriptList.Items[I];
                PlayObject.m_Script := Script;
                PlayObject.m_NPC := Self;
                if Script <> nil then Break;//20081005
              end;
            end;//for
          end;
        end;
      end;
      nCode:= 6;//20081005
      //��ת��ָ��ʾǩ��ִ��
      if (Script <> nil) then begin
        if Script.RecordList.Count > 0 then begin//20080629
          for II := 0 to Script.RecordList.Count - 1 do begin
            SayingRecord := Script.RecordList.Items[II];
            if SayingRecord = nil then Continue;
            if CompareText(sLabel, SayingRecord.sLabel) = 0 then begin
              if boExtJmp and not SayingRecord.boExtJmp then Break;
              sSENDMSG := '';
              if SayingRecord.ProcedureList.Count > 0 then begin//20080629
                for III := 0 to SayingRecord.ProcedureList.Count - 1 do begin
                  SayingProcedure := SayingRecord.ProcedureList.Items[III];
                  if SayingProcedure = nil then Continue;
                  bo11 := False;
                  nCode:= 7;//20081005
                  if QuestCheckCondition(SayingProcedure.ConditionList) then begin
                    sSENDMSG := sSENDMSG + SayingProcedure.sSayMsg;
                    nCode:= 8;//20081005
                    if not QuestActionProcess(SayingProcedure.ActionList) then Break;
                    nCode:= 9;//20081005
                    if bo11 then SendMerChantSayMsg(sSENDMSG, True);
                  end else begin
                    sSENDMSG := sSENDMSG + SayingProcedure.sElseSayMsg;
                    nCode:= 10;//20081005
                    if not QuestActionProcess(SayingProcedure.ElseActionList) then Break;
                    nCode:= 11;//20081005
                    if bo11 then SendMerChantSayMsg(sSENDMSG, True);
                  end;
                end;//for
              end;
              nCode:= 12;//20081005
              if sSENDMSG <> '' then SendMerChantSayMsg(sSENDMSG, False);
              Break;
            end;
          end;//for
        end;
      end;
    except
      MainOutMessage('{�쳣} TNormNpc.GotoLable Code:'+inttostr(nCode));
    end;
  finally
    m_boGotoCount:= 0;
    List1C.Free;
  end;
end;
//��ȡNPC�ű�
procedure TNormNpc.LoadNpcScript;
var
  s08: string;
begin
  if m_boIsQuest then begin
    m_sPath := sNpc_def;
    s08 := m_sCharName + '-' + m_sMapName;
    FrmDB.LoadNpcScript(Self, m_sFilePath, s08);
  end else begin
    m_sPath := m_sFilePath;
    FrmDB.LoadNpcScript(Self, m_sFilePath, m_sCharName);
  end;
end;

function TNormNpc.Operate(ProcessMsg: pTProcessMessage): Boolean;
begin
  Result := inherited Operate(ProcessMsg);
end;

procedure TNormNpc.Run;
var
  nInteger: Integer;
  nCode: Byte;
begin
  try
    nCode:= 0;
    if m_Master <> nil then m_Master := nil; //�������ٻ�Ϊ����
    nCode:= 1;
    //NPC��ɫ
    if (m_boNpcAutoChangeColor) and (m_dwNpcAutoChangeColorTime > 0) and (GetTickCount - m_dwNpcAutoChangeColorTick > m_dwNpcAutoChangeColorTime) then begin
      nCode:= 2;
      m_dwNpcAutoChangeColorTick := GetTickCount();
      case m_nNpcAutoChangeIdx of
        0: nInteger := STATE_TRANSPARENT;//8
        1: nInteger := POISON_STONE;//5
        2: nInteger := POISON_DONTMOVE;//4
        3: nInteger := POISON_68;//68
        4: nInteger := POISON_DECHEALTH;//0
        5: nInteger := POISON_LOCKSPELL;//2
        6: nInteger := POISON_DAMAGEARMOR;//1
      else begin
          m_nNpcAutoChangeIdx := 0;
          nInteger := STATE_TRANSPARENT;
        end;
      end;
      nCode:= 3;
      Inc(m_nNpcAutoChangeIdx);
      m_nCharStatus := (m_nCharStatusEx and $FFFFF) or (($80000000 shr nInteger) or 0);
      nCode:= 4;
      StatusChanged('');
    end;
    nCode:= 5;
    if m_boFixColor and (m_nFixStatus <> m_nCharStatus) then begin
      nCode:= 6;
      case m_nFixColorIdx of
        0: nInteger := STATE_TRANSPARENT;
        1: nInteger := POISON_STONE;
        2: nInteger := POISON_DONTMOVE;
        3: nInteger := POISON_68;
        4: nInteger := POISON_DECHEALTH;
        5: nInteger := POISON_LOCKSPELL;
        6: nInteger := POISON_DAMAGEARMOR;
      else begin
          m_nFixColorIdx := 0;
          nInteger := STATE_TRANSPARENT;
        end;
      end;
      nCode:= 7;
      m_nCharStatus := (m_nCharStatusEx and $FFFFF) or (($80000000 shr nInteger) or 0);
      m_nFixStatus := m_nCharStatus;
      nCode:= 8;
      StatusChanged('');
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.Run Code:'+inttostr(nCode));
  end;
  inherited;
end;
//�ű�������ʾ
procedure TNormNpc.ScriptActionError(PlayObject: TPlayObject; sErrMsg: string;
  QuestActionInfo: pTQuestActionInfo; sCmd: string);
var
  sMsg: string;
resourcestring
  sOutMessage = '[�ű�����] %s �ű�����:%s NPC����:%s ��ͼ:%s(%d:%d) ����1:%s ����2:%s ����3:%s ����4:%s ����5:%s ����6:%s';
begin
  sMsg := Format(sOutMessage, [sErrMsg,
      sCmd,
      m_sCharName,
      m_sMapName,
      m_nCurrX,
      m_nCurrY,
      QuestActionInfo.sParam1,
      QuestActionInfo.sParam2,
      QuestActionInfo.sParam3,
      QuestActionInfo.sParam4,
      QuestActionInfo.sParam5,
      QuestActionInfo.sParam6]);
  MainOutMessage(sMsg);
end;

procedure TNormNpc.ScriptConditionError(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo; sCmd: string);
var
  sMsg: string;
begin
  sMsg := 'Cmd:' + sCmd +
    ' NPC����:' + m_sCharName +
    ' ��ͼ:' + m_sMapName +
    ' ����:' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
    ' ����1:' + QuestConditionInfo.sParam1 +
    ' ����2:' + QuestConditionInfo.sParam2 +
    ' ����3:' + QuestConditionInfo.sParam3 +
    ' ����4:' + QuestConditionInfo.sParam4 +
    ' ����5:' + QuestConditionInfo.sParam5;
  MainOutMessage('[�ű���������ȷ] ' + sMsg);
end;

procedure TNormNpc.SendMsgToUser(PlayObject: TPlayObject; sMsg: string);
begin
  PlayObject.SendMsg(Self, RM_MERCHANTSAY, 0, 0, 0, 0, m_sCharName + '/' + sMsg);
end;

function TNormNpc.sub_49ADB8(sMsg, sStr, sText: string): string;
var
  n10: Integer;
  s14, s18: string;
begin
  n10 := Pos(sStr, sMsg);
  if n10 > 0 then begin
    s14 := Copy(sMsg, 1, n10 - 1);
    s18 := Copy(sMsg, Length(sStr) + n10, Length(sMsg));
    Result := s14 + sText + s18;
  end else Result := sMsg;
end;

procedure TNormNpc.UserSelect(PlayObject: TPlayObject; sData: string);
var
  sMsg, sLabel: string;
begin
try
  PlayObject.m_nScriptGotoCount := 0;
  //==============================================
  //����ű����� @back �����ϼ���ǩ����
  if (sData <> '') and (sData[1] = '@') then begin
    sMsg := GetValidStr3(sData, sLabel, [#13]);
    if sLabel = '@goHero1' then GotoLable(PlayObject, sLabel, False)  //֧�������ʼ��ƶ� 20080119
    else begin
      if (PlayObject.m_sScriptCurrLable <> sLabel) then begin
        if (sLabel <> sBACK) then begin
          PlayObject.m_sScriptGoBackLable := PlayObject.m_sScriptCurrLable;
          PlayObject.m_sScriptCurrLable := sLabel;
        end else begin
          if PlayObject.m_sScriptCurrLable <> '' then begin
            PlayObject.m_sScriptCurrLable := '';
          end else begin
            PlayObject.m_sScriptGoBackLable := '';
          end;
        end;
      end;
    end;
  end;
  //==============================================
except
  MainOutMessage('{�쳣} TNormNpc.UserSelect');
end;
end;
//�ı�������ɫ
procedure TNormNpc.ActionOfChangeNameColor(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nColor: Integer;
begin
try
  if not GetValValue(PlayObject, QuestActionInfo.sParam1, nColor) then begin //���ӱ���֧��
    nColor := QuestActionInfo.nParam1;
  end;
  if (nColor < 0) or (nColor > 255) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGENAMECOLOR);
    Exit;
  end;
  PlayObject.m_btNameColor := nColor;
  PlayObject.RefNameColor();
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfChangeNameColor');
end;
end;

procedure TNormNpc.ActionOfClearPassword(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
try
  PlayObject.m_sStoragePwd := '';
  PlayObject.m_boPasswordLocked := False;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfClearPassword');
end;
end;

//RECALLMOB �������� �ȼ� �ѱ�ʱ�� ��ɫ(0,1) �̶���ɫ(1-7) �Ƿ���ʾ��������(1--����ʾ,�ջ�����ֵ��ʾ)
//��ɫΪ0 ʱ�̶���ɫ��������
procedure TNormNpc.ActionOfRecallmob(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  mon: TBaseObject;
  I, nParam3: Integer;
begin
  try
    nParam3:= Str_ToInt(QuestActionInfo.sParam3, 0);
    if {QuestActionInfo.nParam3}nParam3 <= 1 then begin
      mon := PlayObject.MakeSlave(QuestActionInfo.sParam1, 3, Str_ToInt(QuestActionInfo.sParam2, 0), 100, 864000{10 * 24 * 60 * 60});
    end else begin
      mon := PlayObject.MakeSlave(QuestActionInfo.sParam1, 3, Str_ToInt(QuestActionInfo.sParam2, 0), 100, {QuestActionInfo.nParam3}nParam3 * 60);
    end;
    if mon <> nil then begin
      if (QuestActionInfo.sParam4 <> '') and (QuestActionInfo.sParam4[1] = '1') then begin
        mon.m_boAutoChangeColor := True;
      end else
        if QuestActionInfo.nParam5 > 0 then begin
          mon.m_boFixColor := True;
          mon.m_nFixColorIdx := QuestActionInfo.nParam5 - 1;
      end;
      if (QuestActionInfo.sParam6 <> '') and (QuestActionInfo.sParam6[1] = '1') then mon.m_nCopyHumanLevel:= 3;//����ʾ�������� 20080422
      if mon.m_btRaceServer = RC_PLAYMOSTER then begin //��������ι�
        mon.m_nCopyHumanLevel := 1;
        if (QuestActionInfo.sParam6 <> '') and (QuestActionInfo.sParam6[1] = '1') then mon.m_nCopyHumanLevel:= 3;//����ʾ�������� 20081029
        if m_ItemList.Count > 0 then begin//20080628
          for I := 0 to m_ItemList.Count - 1 do begin //�������
            Dispose(m_ItemList.Items[I]);
          end;
        end;
        m_ItemList.Clear;
        TPlayMonster(mon).InitializeMonster; //���ι����¼��ع�������
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfRecallmob');
  end;
end;
//-----------------------------------------------------------------------------
//RECALLMOBEX �������� ������ɫ ����X ����Y  20080122
//ע��ʹ�ø������ٳ��ı���������û�����˻��������˲���ͬһ��ͼ���Զ���ʧ
procedure TNormNpc.ActionOfRECALLMOBEX(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  mon: TBaseObject;
begin
try
  mon := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, Str_ToInt(QuestActionInfo.sParam3, 0), Str_ToInt(QuestActionInfo.sParam4, 0), QuestActionInfo.sParam1);
  if mon <> nil then begin
    mon.m_Master := PlayObject; //20080127
    mon.m_dwMasterRoyaltyTick := {GetTickCount + }86400000{24 * 60 * 60 * 1000};
    mon.m_dwMasterRoyaltyTime:= GetTickCount();//�����ѱ��ʱ 20080813
    mon.m_btSlaveMakeLevel := 3;
    mon.m_btSlaveExpLevel := 1;
    if mon.m_btRaceServer = 135 then begin
      mon.m_nCopyHumanLevel := 3;//20080419 135��,����ʾ��������
      mon.m_btSlaveExpLevel := SLAVEMAXLEVEL;//20080726 135��,���ı�������ɫ
    end;
    mon.m_btNameColor:= Str_ToInt(QuestActionInfo.sParam2, 0);

    mon.RecalcAbilitys();
    mon.RefNameColor();
    PlayObject.m_SlaveList.Add(mon);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfRECALLMOBEX');
end;
end;
//-----------------------------------------------------------------------------
//�����ʽ:2MOVEMOBTO �������� ԭ��ͼ ԭX ԭY �µ�ͼ ��X ��Y    20080123
//(��ָ������Ĺ����ƶ��������꣬����ΪALL���ƶ����������й�)
procedure TNormNpc.ActionOfMOVEMOBTO(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  boMoveAll: Boolean;
  sMonName,sMap1,sMap2: String;
  SrcEnvir, DenEnvir: TEnvirnoment;
  MonList: TList;
  nX,nY,OnX,OnY: Integer;
  MoveMon: TBaseObject;
  I: Integer;
begin
try
  boMoveAll:= False;
{  nX:=Str_ToInt(QuestActionInfo.sParam6, -1);//��X
  nY:=Str_ToInt(QuestActionInfo.sParam7, -1);//��Y
  OnX:=Str_ToInt(QuestActionInfo.sParam3, -1);//ԭX
  OnY:=Str_ToInt(QuestActionInfo.sParam4, -1);//ԭY  }
  nX:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam6), -1);//��X ֧�ֱ��� 20080125
  nY:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam7), -1);//��Y ֧�ֱ��� 20080125
  OnX:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam3), -1);//ԭX ֧�ֱ���20080125
  OnY:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam4), -1);//ԭY ֧�ֱ���20080125

  sMonName:=GetLineVariableText(PlayObject,QuestActionInfo.sParam1);//�������� ֧�ֱ���  20080126
  if sMonName = 'ALL' then boMoveAll:= True;

  sMap1:=GetLineVariableText(PlayObject, QuestActionInfo.sParam2); //��ͼ֧�ֱ���
  sMap2:=GetLineVariableText(PlayObject, QuestActionInfo.sParam5); //��ͼ֧�ֱ���
  SrcEnvir := g_MapManager.FindMap(sMap1);
  DenEnvir := g_MapManager.FindMap(sMap2);
  if (SrcEnvir = nil) or (DenEnvir = nil) then Exit;

  MonList := TList.Create;
  try
    if not boMoveAll then begin//ָ�����ƵĹ��ƶ�
     UserEngine.GetMapRangeMonster(SrcEnvir, OnX, OnY, 1 ,MonList);//��ָ��XY��Χ�ڵĹ� 20080422
      if MonList.Count > 0 then begin//20080629
        for I := 0 to MonList.Count - 1 do begin
          MoveMon := TBaseObject(MonList.Items[I]);
          if MoveMon <> Self then begin
            if CompareText(MoveMon.m_sCharName, sMonName) = 0 then //�Ƿ���ָ�����ƵĹ�
               MoveMon.SpaceMove(sMap2, nX, nY, 0);
          end;
        end;//for
      end;
    end else begin //���й��ƶ�
      UserEngine.GetMapRangeMonster(SrcEnvir, OnX, OnY, 1000,MonList);//��ָ��XY��Χ�ڵĹ�
      if MonList.Count > 0 then begin//20080629
        for I := 0 to MonList.Count - 1 do begin
          MoveMon := TBaseObject(MonList.Items[I]);
          if MoveMon <> Self then
            MoveMon.SpaceMove(sMap2, nX, nY, 0);
        end;//for
      end;
    end;
  finally
    MonList.Free;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfMOVEMOBTO');
end;
end;
//-----------------------------------------------------------------------------
//CLEARITEMMAP ��ͼ X Y ��Χ ��Ʒ����     20080124
//(�����ͼ��Ʒ����Ʒ����ΪALL���������)
procedure TNormNpc.ActionOfCLEARITEMMAP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sItmeName,sMap: string;
  I,nX,nY,nRange,nXX,nYY: Integer;
  boClearAll: Boolean;
  Envir: TEnvirnoment;
  MapItem: PTMapItem;
  ItemList:TList;
begin
try
  boClearAll:= False;
  sItmeName:= QuestActionInfo.sParam5;//��Ʒ����
  sMap:= QuestActionInfo.sParam1;
  if (sMap <> '') and (sMap[1] = '<') and (sMap[2] = '$') then//����֧��<$Str()> 20080422
     sMap := GetLineVariableText(PlayObject, QuestActionInfo.sParam1)
  else GetValValue(PlayObject, QuestActionInfo.sParam1, sMap);
  //sMap:=GetLineVariableText(PlayObject, QuestActionInfo.sParam1); //��ͼ֧�ֱ���
  nX:=Str_ToInt(QuestActionInfo.sParam2, -1);//X
  nY:=Str_ToInt(QuestActionInfo.sParam3, -1);//Y
  nRange:=Str_ToInt(QuestActionInfo.sParam4, -1);//��Χ

  if (sItmeName = 'ALL') or (sItmeName = '') then boClearAll:= True; //20080419
  Envir := g_MapManager.FindMap(sMap);//���ҵ�ͼ
  if Envir <> nil then begin
    ItemList:= TList.Create;
    Envir.GetMapItem(nX, nY, nRange,ItemList);//ȡ��ͼ��ָ����Χ����Ʒ
    if not boClearAll then begin///���ָ����Ʒ
      if ItemList.Count > 0 then begin//20080629
        for I := 0 to ItemList.Count - 1 do begin
        MapItem:= pTMapItem(ItemList.Items[I]);
          if (CompareText(MapItem.name, sItmeName) = 0) then begin
            for nXX := nX - nRange to nX + nRange do begin
              for nYY := nY - nRange to nY + nRange do begin
               Envir.DeleteFromMap(nXX, nYY, OS_ITEMOBJECT, TObject(MapItem));
               if TObject(MapItem)=nil then break;
              end;
            end;
          end;
        end;//for
      end;
    end else begin //���ȫ����Ʒ
      if ItemList.Count > 0 then begin//20080629
        for I := 0 to ItemList.Count - 1 do begin
          MapItem:= pTMapItem(ItemList.Items[I]);
          for nXX := nX - nRange to nX + nRange do begin
            for nYY := nY - nRange to nY + nRange do begin
             Envir.DeleteFromMap(nXX, nYY, OS_ITEMOBJECT, TObject(MapItem));
             if TObject(MapItem)=nil then break;
            end;
          end;
        end;//for
      end;
    end;
    ItemList.Free;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfCLEARITEMMAP');
end;
end;
//-----------------------------------------------------------------------------
procedure TNormNpc.ActionOfReNewLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nReLevel, nLevel: Integer;
  nBounsuPoint: Integer;
begin
try
  {nReLevel := Str_ToInt(QuestActionInfo.sParam1, -1);
  nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
  nBounsuPoint := Str_ToInt(QuestActionInfo.sParam3, -1); }
  nReLevel := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam1),-1);//20080501
  nLevel := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  nBounsuPoint := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam3),-1);//20080501
  if nReLevel < 0 then begin
    GetValValue(PlayObject, QuestActionInfo.sParam1, nReLevel); //���ӱ���֧��
  end;
  if nLevel < 0 then begin
    GetValValue(PlayObject, QuestActionInfo.sParam2, nLevel); //���ӱ���֧��
  end;
  if nBounsuPoint < 0 then begin
    GetValValue(PlayObject, QuestActionInfo.sParam3, nBounsuPoint); //���ӱ���֧��
  end;
  if (nReLevel < 0) or (nLevel < 0) or (nBounsuPoint < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_RENEWLEVEL);
    Exit;
  end;
  if (PlayObject.m_btReLevel + nReLevel) <= 255 then begin
    Inc(PlayObject.m_btReLevel, nReLevel);
    if nLevel > 0 then begin
      PlayObject.m_Abil.Level := nLevel;
      AddGameDataLog('17' + #9 + PlayObject.m_sMapName + #9 + //�ȼ�������¼��־ 20081102
        IntToStr(PlayObject.m_nCurrX) + #9 +
        IntToStr(PlayObject.m_nCurrY)+ #9 +
        PlayObject.m_sCharName + #9 +
        IntToStr(PlayObject.m_Abil.Level) + #9 +
        '0' + #9 +
        '=('+IntToStr(nLevel)+')' + #9 +
        m_sCharName+'(ת��)');
    end;  
    if g_Config.boReNewLevelClearExp then PlayObject.m_Abil.Exp := 0;
    Inc(PlayObject.m_nBonusPoint, nBounsuPoint);
    PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
    PlayObject.HasLevelUp(0);
    PlayObject.RefShowName();
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfReNewLevel');
end;
end;
//���ܣ��ı��ɫ�Ա�
//��ʽ��CHANGEGENDER �Ա�(0,1) Hero
procedure TNormNpc.ActionOfChangeGender(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nGENDER: Integer;
begin
  try
    nGENDER := Str_ToInt(QuestActionInfo.sParam1, -1);
    if not (nGENDER in [0, 1]) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGENDER);
      Exit;
    end;
    if CompareText(QuestActionInfo.sParam2, 'HERO') = 0 then begin
      if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin //20080519
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEGENDER);
        Exit;
      end;
      if PlayObject.m_MyHero <> nil then begin
        PlayObject.m_MyHero.m_btGender := nGENDER;
        //PlayObject.SendMsg(PlayObject, RM_HEROABILITY, 0, 0, 0, 0, ''); //����Ӣ������  20090107�޸�
        THeroObject(PlayObject.m_MyHero).SendMsg(PlayObject.m_MyHero, RM_HEROABILITY, 0, 0, 0, 0, ''); //����Ӣ������ 20090107
        PlayObject.m_MyHero.FeatureChanged;
      end;
    end else begin
      PlayObject.m_btGender := nGENDER;
      PlayObject.FeatureChanged;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfChangeGender');
  end;
end;

procedure TNormNpc.ActionOfKillSlave(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  Slave: TBaseObject;
begin
try
  if PlayObject.m_SlaveList.Count > 0 then begin//20080629
    for I := 0 to PlayObject.m_SlaveList.Count - 1 do begin
      Slave := TBaseObject(PlayObject.m_SlaveList.Items[I]);
      Slave.m_WAbil.HP := 0;
      Slave.MakeGhost;//20081005
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfKillSlave');
end;
end;
//�ı侭�鱶��
procedure TNormNpc.ActionOfKillMonExpRate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate: Integer;
  nTime: Integer;
  nCode: Byte;
begin
  nCode:=0;
  try
    if PlayObject <> nil then begin//20080612
      nRate := Str_ToInt(QuestActionInfo.sParam1, -1);
      nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
      if (nRate < 0) or (nTime < 0) then begin
        ScriptActionError(PlayObject, '', QuestActionInfo, sSC_KILLMONEXPRATE);
        Exit;
      end;
      nCode:=1;
      PlayObject.m_nKillMonExpRate := nRate;
      PlayObject.m_nOldKillMonExpRate := PlayObject.m_nKillMonExpRate;
      PlayObject.m_dwKillMonExpRateTime := LongWord(nTime);
      nCode:=2;
      if PlayObject.m_MyHero <> nil then begin//Ӣ��Ҳͬʱ˫������  20080406
         nCode:=3;
         THeroObject(PlayObject.m_MyHero).m_nKillMonExpRate:= nRate;
         THeroObject(PlayObject.m_MyHero).m_nOldKillMonExpRate:= THeroObject(PlayObject.m_MyHero).m_nKillMonExpRate;//ûʹ����װǰɱ�־��鱶��
      end;
      nCode:=4;
      if g_Config.boShowScriptActionMsg then begin
        nCode:=5;
        PlayObject.SysMsg(Format(g_sChangeKillMonExpRateMsg, [PlayObject.m_nKillMonExpRate / 100, PlayObject.m_dwKillMonExpRateTime]), c_Green, t_Hint);
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} TNormNpc.ActionOfKillMonExpRate Code:'+inttostr(nCode));
    end;
  end;
end;
//��ʽ:MONGENEX ��ͼ X Y ����|�Ƿ��ڹ���(0/1)|������ɫֵ ��Χ ����
procedure TNormNpc.ActionOfMonGenEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sMapName, sMonName ,sNGMon ,sNameColor: string;
  nMapX, nMapY, nRange, nCount: Integer;
  nRandX, nRandY: Integer;
  nNameColor: Byte;
  Monster: TBaseObject;
  sStr:string;
begin
  try
    sNGMon:= '';
    sNameColor:= '';
    sMapName := QuestActionInfo.sParam1;
    nMapX := Str_ToInt(QuestActionInfo.sParam2, -1);
    nMapY := Str_ToInt(QuestActionInfo.sParam3, -1);
    if Pos('|',QuestActionInfo.sParam4) > 0 then begin
      sStr := GetValidStr3(QuestActionInfo.sParam4, sMonName, ['|']);
      sNameColor := GetValidStr3(sStr, sNGMon, ['|']);
      if (sNameColor <> '') then nNameColor:= Str_ToInt(Trim(sNameColor), 255);//������ɫ
    end else sMonName := QuestActionInfo.sParam4;
    nRange := QuestActionInfo.nParam5;
    nCount := QuestActionInfo.nParam6;
    if (sMapName = '') or (nMapX <= 0) or (nMapY <= 0) or (sMapName = '') or (nRange <= 0) or (nCount <= 0) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_MONGENEX);
      Exit;
    end;

    for I := 0 to nCount - 1 do begin
      nRandX := Random(nRange * 2 + 1) + (nMapX - nRange);
      nRandY := Random(nRange * 2 + 1) + (nMapY - nRange);
      Monster:= UserEngine.RegenMonsterByName(sMapName, nRandX, nRandY, sMonName);
      if Monster = nil then begin
        //ScriptActionError(PlayObject,'',QuestActionInfo,sSC_MONGENEX);
        Break;
      end else begin
        if (sNGMon <> '') then  Monster.m_boIsNGMonster := sNGMon <> '0';
        if (sNameColor <> '') then begin
          Monster.m_btNameColor:= nNameColor;
          Monster.m_boSetNameColor:= True;//20081220
          Monster.RefNameColor;
        end;
      end;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfMonGenEx');
  end;
end;

procedure TNormNpc.ActionOfOpenMagicBox(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Monster: TBaseObject;
  sMonName: string;
  nX, nY: Integer;
begin
try
  sMonName := QuestActionInfo.sParam1;
  if sMonName = '' then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_OPENMAGICBOX);
    Exit;
  end;
  PlayObject.GetFrontPosition(nX, nY);
  Monster := UserEngine.RegenMonsterByName(PlayObject.m_PEnvir.sMapName, nX, nY, sMonName);
  if Monster = nil then Exit;
  Monster.Die;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfOpenMagicBox');
end;
end;

procedure TNormNpc.ActionOfPkZone(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nX, nY: Integer;
  FireBurnEvent: TFireBurnEvent;
  nMinX, nMaxX, nMinY, nMaxY: Integer;
  nRange, nType, nTime, nPoint: Integer;
begin
try
  nRange := Str_ToInt(QuestActionInfo.sParam1, -1);
  nType := Str_ToInt(QuestActionInfo.sParam2, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam3, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam4, -1);
  if (nRange < 0) or (nType < 0) or (nTime < 0) or (nPoint < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_PKZONE);
    Exit;
  end;
  {
  nMinX:=PlayObject.m_nCurrX - nRange;
  nMaxX:=PlayObject.m_nCurrX + nRange;
  nMinY:=PlayObject.m_nCurrY - nRange;
  nMaxY:=PlayObject.m_nCurrY + nRange;
  }
  nMinX := m_nCurrX - nRange;
  nMaxX := m_nCurrX + nRange;
  nMinY := m_nCurrY - nRange;
  nMaxY := m_nCurrY + nRange;
  for nX := nMinX to nMaxX do begin
    for nY := nMinY to nMaxY do begin
      if ((nX < nMaxX) and (nY = nMinY)) or
        ((nY < nMaxY) and (nX = nMinX)) or
        (nX = nMaxX) or (nY = nMaxY) then begin
        FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, nType, nTime * 1000, nPoint);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfPkZone');
end;
end;
//����:���ù���������
//��ʽ:POWERRATE ���� ��Чʱ��
//˵��:���� Ϊɱ��������������������100Ϊ�����ı���(200 Ϊ 2 �����飬150 Ϊ1.5��)
procedure TNormNpc.ActionOfPowerRate(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate: Integer;
  nTime: Integer;
begin
try
  nRate := Str_ToInt(QuestActionInfo.sParam1, -1);
  nTime := Str_ToInt(QuestActionInfo.sParam2, -1);
  if (nRate < 0) or (nTime < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_POWERRATE);
    Exit;
  end;

  PlayObject.m_nPowerRate := nRate;
  //PlayObject.m_dwPowerRateTime:=_MIN(High(Word),nTime);
  PlayObject.m_dwPowerRateTime := LongWord(nTime);
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sChangePowerRateMsg, [PlayObject.m_nPowerRate / 100, PlayObject.m_dwPowerRateTime]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfPowerRate');
end;
end;
//�ı����ģʽ
procedure TNormNpc.ActionOfChangeMode(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMode: Integer;
  boOpen: Boolean;
begin
  try
    nMode := QuestActionInfo.nParam1;
    boOpen := Str_ToInt(QuestActionInfo.sParam2, -1) = 1;
    if nMode in [1..3] then begin
      case nMode of //
        1: begin//����ģʽ
            PlayObject.m_boAdminMode := boOpen;
            if PlayObject.m_boAdminMode then PlayObject.SysMsg(sGameMasterMode, c_Green, t_Hint)
            else PlayObject.SysMsg(sReleaseGameMasterMode, c_Green, t_Hint);
          end;
        2: begin//�޵�ģʽ
            PlayObject.m_boSuperMan := boOpen;
            if PlayObject.m_boSuperMan then PlayObject.SysMsg(sSupermanMode, c_Green, t_Hint)
            else PlayObject.SysMsg(sReleaseSupermanMode, c_Green, t_Hint);
          end;
        3: begin//����ģʽ
            PlayObject.m_boObMode := boOpen;
            if PlayObject.m_boObMode then PlayObject.SysMsg(sObserverMode, c_Green, t_Hint)
            else PlayObject.SysMsg(g_sReleaseObserverMode, c_Green, t_Hint);
          end;
      end;
    end else begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEMODE);
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfChangeMode');
  end;
end;

procedure TNormNpc.ActionOfChangePerMission(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPermission: Integer;
begin
try
  nPermission := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nPermission in [0..10] then begin
    PlayObject.m_btPermission := nPermission;
  end else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CHANGEPERMISSION);
    Exit;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sChangePermissionMsg, [PlayObject.m_btPermission]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfChangePerMission');
end;
end;
//����Ʒ
procedure TNormNpc.ActionOfGiveItem(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I : Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  sItemName: string;
  nItemCount: Integer;
  boHero: Boolean;
begin
  Try
    sItemName := GetLineVariableText(PlayObject, QuestActionInfo.sParam1);//���ӱ���֧�� 20080409
    if sItemName ='' then sItemName := QuestActionInfo.sParam1;//20080409
    nItemCount:=Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2), -1);//���� ֧�ֱ���
    if nItemCount < 0 then nItemCount := QuestActionInfo.nParam2;

    if (sItemName = '') or (nItemCount <= 0) then begin
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GIVE);
      Exit;
    end;
    if nItemCount <= 0 then Exit;
    if CompareText(sItemName, sSTRING_GOLDNAME) = 0 then begin
      PlayObject.IncGold(nItemCount);
      PlayObject.GoldChanged();
      if g_boGameLogGold then
        AddGameDataLog('9' + #9 + PlayObject.m_sMapName + #9 +
          IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
          PlayObject.m_sCharName + #9 + sSTRING_GOLDNAME + #9 + IntToStr(nItemCount) + #9 +
          '1' + #9 + m_sCharName);
      Exit;
    end;

    boHero:= False;
    if CompareText(QuestActionInfo.sParam3, 'HERO') = 0 then begin//20080805
      if PlayObject.m_MyHero <> nil then boHero:= True;
    end;
  
    if UserEngine.GetStdItemIdx(sItemName) > 0 then begin
      //if not (nItemCount in [1..50]) then nItemCount := 1; //12.28 ����һ��
      if (nItemCount <= 0) or (nItemCount > 50) then nItemCount := 1;//20081006 �޸�
      for I := 0 to nItemCount - 1 do begin //nItemCount Ϊ0ʱ����ѭ��
        if boHero then begin
          if THeroObject(PlayObject.m_MyHero).IsEnoughBag then begin
            New(UserItem);
            if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
              PlayObject.m_MyHero.m_ItemList.Add((UserItem));
              THeroObject(PlayObject.m_MyHero).SendAddItem(UserItem);
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('9' + #9 + PlayObject.m_sMapName + #9 +
                  IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
                  PlayObject.m_MyHero.m_sCharName + #9 + sItemName + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                  '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                  '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                  '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                  '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                  IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                  IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                  IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                  IntToStr(UserItem.btValue[14])+ #9 + m_sCharName);
            end else Dispose(UserItem);
          end else begin//����ûλ�������
            boHero:= False;
            if PlayObject.IsEnoughBag then begin
              New(UserItem);
              if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
                PlayObject.m_ItemList.Add((UserItem));
                PlayObject.SendAddItem(UserItem);
                StdItem := UserEngine.GetStdItem(UserItem.wIndex);
                if StdItem.NeedIdentify = 1 then
                  AddGameDataLog('9' + #9 + PlayObject.m_sMapName + #9 +
                    IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
                    PlayObject.m_sCharName + #9 + sItemName + #9 +
                    IntToStr(UserItem.MakeIndex) + #9 +
                    '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                    '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                    '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                    '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                    '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                    IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                    IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                    IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                    IntToStr(UserItem.btValue[14])+ #9 + m_sCharName);
              end else Dispose(UserItem);
            end else begin
              New(UserItem);
              if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
                StdItem := UserEngine.GetStdItem(UserItem.wIndex);
                if StdItem.NeedIdentify = 1 then
                  AddGameDataLog('9' + #9 + PlayObject.m_sMapName + #9 +
                    IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
                    PlayObject.m_sCharName + #9 + sItemName + #9 +
                    IntToStr(UserItem.MakeIndex) + #9 +
                    '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                    '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                    '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                    '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                    '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                    IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                    IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                    IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                    IntToStr(UserItem.btValue[14])+ #9 + m_sCharName);
                PlayObject.DropItemDown(UserItem, 3, False, False, PlayObject, PlayObject{nil}); //20080519 ����M2����:{�쳣} TMerchant::UserSelect... Data: @XXXX Code:0
              end else Dispose(UserItem);//20081006 �޸�
            end;
          end;
        end else begin
          if PlayObject.IsEnoughBag then begin
            New(UserItem);
            if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
              PlayObject.m_ItemList.Add((UserItem));
              PlayObject.SendAddItem(UserItem);
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('9' + #9 + PlayObject.m_sMapName + #9 +
                  IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
                  PlayObject.m_sCharName + #9 + sItemName + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                  '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                  '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                  '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                  '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                  IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                  IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                  IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                  IntToStr(UserItem.btValue[14])+ #9 + m_sCharName);
            end else Dispose(UserItem);
          end else begin
            New(UserItem);
            if UserEngine.CopyToUserItemFromName(sItemName, UserItem) then begin
              StdItem := UserEngine.GetStdItem(UserItem.wIndex);
              if StdItem.NeedIdentify = 1 then
                AddGameDataLog('9' + #9 + PlayObject.m_sMapName + #9 +
                  IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
                  PlayObject.m_sCharName + #9 + sItemName + #9 +
                  IntToStr(UserItem.MakeIndex) + #9 +
                  '('+IntToStr(LoWord(StdItem.DC))+'/'+IntToStr(HiWord(StdItem.DC))+')'+
                  '('+IntToStr(LoWord(StdItem.MC))+'/'+IntToStr(HiWord(StdItem.MC))+')'+
                  '('+IntToStr(LoWord(StdItem.SC))+'/'+IntToStr(HiWord(StdItem.SC))+')'+
                  '('+IntToStr(LoWord(StdItem.AC))+'/'+IntToStr(HiWord(StdItem.AC))+')'+
                  '('+IntToStr(LoWord(StdItem.MAC))+'/'+IntToStr(HiWord(StdItem.MAC))+')'+
                  IntToStr(UserItem.btValue[0])+'/'+IntToStr(UserItem.btValue[1])+'/'+IntToStr(UserItem.btValue[2])+'/'+
                  IntToStr(UserItem.btValue[3])+'/'+IntToStr(UserItem.btValue[4])+'/'+IntToStr(UserItem.btValue[5])+'/'+
                  IntToStr(UserItem.btValue[6])+'/'+IntToStr(UserItem.btValue[7])+'/'+IntToStr(UserItem.btValue[8])+'/'+
                  IntToStr(UserItem.btValue[14])+ #9 + m_sCharName);
              PlayObject.DropItemDown(UserItem, 3, False, False, PlayObject, PlayObject{nil}); //20080519 ����M2����:{�쳣} TMerchant::UserSelect... Data: @XXXX Code:0
            end else Dispose(UserItem);//20081006 �޸�
          end;
        end;
      end;//for
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ActionOfGiveItem');
  end;
end;

procedure TNormNpc.ActionOfGmExecute(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  sData: string;
  btOldPermission: Byte;
  sParam1, sParam2, sParam3, sParam4, sParam5, sParam6: string;
  nParam2, nParam3, nParam4, nParam5, nParam6: Integer;
begin
try
  sParam1 := QuestActionInfo.sParam1;
  sParam2 := QuestActionInfo.sParam2;
  sParam3 := QuestActionInfo.sParam3;
  sParam4 := QuestActionInfo.sParam4;
  sParam5 := QuestActionInfo.sParam5;
  sParam6 := QuestActionInfo.sParam6;

  if (sParam2 <> '') and (sParam2[1] = '<') and (sParam2[2] = '$') then//����֧��<$Str()> 20080422
     sParam2 := GetLineVariableText(PlayObject, sParam2)
  else GetValValue(PlayObject, sParam2, sParam2);

  if (sParam3 <> '') and (sParam3[1] = '<') and (sParam3[2] = '$') then//����֧��<$Str()> 20080422
     sParam3 := GetLineVariableText(PlayObject, sParam3)
  else GetValValue(PlayObject, sParam3, sParam3);

  if (sParam4 <> '') and (sParam4[1] = '<') and (sParam4[2] = '$') then//����֧��<$Str()> 20080422
     sParam4 := GetLineVariableText(PlayObject, sParam4)
  else GetValValue(PlayObject, sParam4, sParam4);

  if (sParam5 <> '') and (sParam5[1] = '<') and (sParam5[2] = '$') then//����֧��<$Str()> 20080422
     sParam5 := GetLineVariableText(PlayObject, sParam5)
  else GetValValue(PlayObject, sParam5, sParam5);

  if (sParam6 <> '') and (sParam6[1] = '<') and (sParam6[2] = '$') then//����֧��<$Str()> 20080422
     sParam6 := GetLineVariableText(PlayObject, sParam6)
  else GetValValue(PlayObject, sParam6, sParam6);

// GetValValue(PlayObject, sParam2, sParam2);  //20080422 ע��
// GetValValue(PlayObject, sParam3, sParam3);
// GetValValue(PlayObject, sParam4, sParam4);
// GetValValue(PlayObject, sParam5, sParam5);
// GetValValue(PlayObject, sParam6, sParam6);
  if GetValValue(PlayObject, sParam2, nParam2) then sParam2 := IntToStr(nParam2);
  if GetValValue(PlayObject, sParam3, nParam3) then sParam3 := IntToStr(nParam3);
  if GetValValue(PlayObject, sParam4, nParam4) then sParam4 := IntToStr(nParam4);
  if GetValValue(PlayObject, sParam5, nParam5) then sParam5 := IntToStr(nParam5);
  if GetValValue(PlayObject, sParam6, nParam6) then sParam6 := IntToStr(nParam6);
  if CompareText(sParam2, 'Self') = 0 then sParam2 := PlayObject.m_sCharName;
  sData := Format('@%s %s %s %s %s %s', [sParam1, sParam2, sParam3, sParam4, sParam5, sParam6]);
  btOldPermission := PlayObject.m_btPermission;
  try
    PlayObject.m_btPermission := 10;
    PlayObject.ProcessUserLineMsg(sData);
  finally
    PlayObject.m_btPermission := btOldPermission;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGmExecute');
end;
end;

procedure TNormNpc.ActionOfGuildAuraePoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nAuraePoint: Integer;
  cMethod: Char;
  Guild: TGUild;
begin
try
  //nAuraePoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  nAuraePoint := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  if nAuraePoint < 0 then begin
    if not GetValValue(PlayObject, QuestActionInfo.sParam2, nAuraePoint) then begin //���ӱ���֧��
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_AURAEPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildAuraePointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nAurae := nAuraePoint;
      end;
    '-': begin
        if Guild.nAurae >= nAuraePoint then begin
          Guild.nAurae := Guild.nAurae - nAuraePoint;
        end else begin
          Guild.nAurae := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nAurae) >= nAuraePoint then begin
          Guild.nAurae := Guild.nAurae + nAuraePoint;
        end else begin
          Guild.nAurae := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptGuildAuraePointMsg, [Guild.nAurae]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGuildAuraePoint');
end;
end;

procedure TNormNpc.ActionOfGuildBuildPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nBuildPoint: Integer;
  cMethod: Char;
  Guild: TGUild;
begin
try
  //nBuildPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  nBuildPoint := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  if nBuildPoint < 0 then begin
    if not GetValValue(PlayObject, QuestActionInfo.sParam2, nBuildPoint) then begin //���ӱ���֧��
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BUILDPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildBuildPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nBuildPoint := nBuildPoint;
      end;
    '-': begin
        if Guild.nBuildPoint >= nBuildPoint then begin
          Guild.nBuildPoint := Guild.nBuildPoint - nBuildPoint;
        end else begin
          Guild.nBuildPoint := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nBuildPoint) >= nBuildPoint then begin
          Guild.nBuildPoint := Guild.nBuildPoint + nBuildPoint;
        end else begin
          Guild.nBuildPoint := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptGuildBuildPointMsg, [Guild.nBuildPoint]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGuildBuildPoint');
end;
end;

procedure TNormNpc.ActionOfGuildChiefItemCount(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nItemCount: Integer;
  cMethod: Char;
  Guild: TGUild;
begin
try
  //nItemCount := Str_ToInt(QuestActionInfo.sParam2, -1);
  nItemCount := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  if nItemCount < 0 then begin
    if not GetValValue(PlayObject, QuestActionInfo.sParam2, nItemCount) then begin //���ӱ���֧��
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_GUILDCHIEFITEMCOUNT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildFlourishPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nChiefItemCount := nItemCount;
      end;
    '-': begin
        if Guild.nChiefItemCount >= nItemCount then begin
          Guild.nChiefItemCount := Guild.nChiefItemCount - nItemCount;
        end else begin
          Guild.nChiefItemCount := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nChiefItemCount) >= nItemCount then begin
          Guild.nChiefItemCount := Guild.nChiefItemCount + nItemCount;
        end else begin
          Guild.nChiefItemCount := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptChiefItemCountMsg, [Guild.nChiefItemCount]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGuildChiefItemCount');
end;
end;

procedure TNormNpc.ActionOfGuildFlourishPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nFlourishPoint: Integer;
  cMethod: Char;
  Guild: TGUild;
begin
try
  //nFlourishPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  nFlourishPoint := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  if nFlourishPoint < 0 then begin
    if not GetValValue(PlayObject, QuestActionInfo.sParam2, nFlourishPoint) then begin //���ӱ���֧��
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_FLOURISHPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildFlourishPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nFlourishing := nFlourishPoint;
      end;
    '-': begin
        if Guild.nFlourishing >= nFlourishPoint then begin
          Guild.nFlourishing := Guild.nFlourishing - nFlourishPoint;
        end else begin
          Guild.nFlourishing := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nFlourishing) >= nFlourishPoint then begin
          Guild.nFlourishing := Guild.nFlourishing + nFlourishPoint;
        end else begin
          Guild.nFlourishing := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptGuildFlourishPointMsg, [Guild.nFlourishing]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGuildFlourishPoint');
end;
end;

procedure TNormNpc.ActionOfGuildstabilityPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nStabilityPoint: Integer;
  cMethod: Char;
  Guild: TGUild;
begin
try
  //nStabilityPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  nStabilityPoint := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  if nStabilityPoint < 0 then begin
    if not GetValValue(PlayObject, QuestActionInfo.sParam2, nStabilityPoint) then begin //���ӱ���֧��
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_STABILITYPOINT);
      Exit;
    end;
  end;
  if PlayObject.m_MyGuild = nil then begin
    PlayObject.SysMsg(g_sScriptGuildStabilityPointNoGuild, c_Red, t_Hint);
    Exit;
  end;
  Guild := TGUild(PlayObject.m_MyGuild);

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        Guild.nStability := nStabilityPoint;
      end;
    '-': begin
        if Guild.nStability >= nStabilityPoint then begin
          Guild.nStability := Guild.nStability - nStabilityPoint;
        end else begin
          Guild.nStability := 0;
        end;
      end;
    '+': begin
        if (High(Integer) - Guild.nStability) >= nStabilityPoint then begin
          Guild.nStability := Guild.nStability + nStabilityPoint;
        end else begin
          Guild.nStability := High(Integer);
        end;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptGuildStabilityPointMsg, [Guild.nStability]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfGuildstabilityPoint');
end;
end;

procedure TNormNpc.ActionOfHumanHP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nHP: Integer;
  cMethod: Char;
begin
try
  //nHP := Str_ToInt(QuestActionInfo.sParam2, -1);
  nHP := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  if nHP < 0 then begin
    if not GetValValue(PlayObject, QuestActionInfo.sParam2, nHP) then begin //���ӱ���֧��
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HUMANHP);
      Exit;
    end;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        PlayObject.m_WAbil.HP := nHP;
      end;
    '-': begin
        if PlayObject.m_WAbil.HP >= nHP then begin
          Dec(PlayObject.m_WAbil.HP, nHP);
        end else begin
          PlayObject.m_WAbil.HP := 0;
        end;
      end;
    '+': begin
        Inc(PlayObject.m_WAbil.HP, nHP);
        if PlayObject.m_WAbil.HP > PlayObject.m_WAbil.MaxHP then PlayObject.m_WAbil.HP := PlayObject.m_WAbil.MaxHP;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptChangeHumanHPMsg, [PlayObject.m_WAbil.MaxHP]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfHumanHP');
end;
end;

procedure TNormNpc.ActionOfHumanMP(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMP: Integer;
  cMethod: Char;
begin
try
  //nMP := Str_ToInt(QuestActionInfo.sParam2, -1);
  nMP := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  if nMP < 0 then begin
    if not GetValValue(PlayObject, QuestActionInfo.sParam2, nMP) then begin //���ӱ���֧��
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_HUMANMP);
      Exit;
    end;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        PlayObject.m_WAbil.MP := nMP;
      end;
    '-': begin
        if PlayObject.m_WAbil.MP >= nMP then begin
          Dec(PlayObject.m_WAbil.MP, nMP);
        end else begin
          PlayObject.m_WAbil.MP := 0;
        end;
      end;
    '+': begin
        Inc(PlayObject.m_WAbil.MP, nMP);
        if PlayObject.m_WAbil.MP > PlayObject.m_WAbil.MaxMP then PlayObject.m_WAbil.MP := PlayObject.m_WAbil.MaxMP;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sScriptChangeHumanMPMsg, [PlayObject.m_WAbil.MaxMP]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfHumanMP');
end;
end;
//����:���������������Ե㡣
//��ʽ:USEBONUSPOINT ����λ�ã�1-9�� ���Ʒ���+,-,=�� ����
procedure TNormNpc.ActionOfUseBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nPosition, nCount: Integer;
  cMethod: Char;
begin
try
  nPosition := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam1),-1);//20080501
  cMethod := QuestActionInfo.sParam2[1];
  nCount := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam3),-1);//20080501
  if (nPosition < 0) or (nCount < 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_USEBONUSPOINT);
    Exit;
  end;

  if CompareText(QuestActionInfo.sParam4, 'HERO') = 0 then begin
    if ((not PlayObject.m_boHasHero) or (not PlayObject.m_boHasHeroTwo)) and (PlayObject.m_sHeroCharName ='') then begin
      //ScriptActionError(PlayObject, '', QuestActionInfo, sSC_USEBONUSPOINT);
      Exit;
    end;
    if PlayObject.m_MyHero <> nil then begin
      case cMethod of
        '+': begin
            case nPosition of
              1: Inc(PlayObject.m_MyHero.m_BonusAbil.DC, nCount);
              2: Inc(PlayObject.m_MyHero.m_BonusAbil.MC, nCount);
              3: Inc(PlayObject.m_MyHero.m_BonusAbil.SC, nCount);
              4: Inc(PlayObject.m_MyHero.m_BonusAbil.AC, nCount);
              5: Inc(PlayObject.m_MyHero.m_BonusAbil.MAC, nCount);
              6: Inc(PlayObject.m_MyHero.m_BonusAbil.HP, nCount);
              7: Inc(PlayObject.m_MyHero.m_BonusAbil.MP, nCount);
              8: Inc(PlayObject.m_MyHero.m_BonusAbil.Hit, nCount);
              9: Inc(PlayObject.m_MyHero.m_BonusAbil.Speed, nCount);
            end;
          end;
        '-': begin
            case nPosition of
              1: Dec(PlayObject.m_MyHero.m_BonusAbil.DC, nCount);
              2: Dec(PlayObject.m_MyHero.m_BonusAbil.MC, nCount);
              3: Dec(PlayObject.m_MyHero.m_BonusAbil.SC, nCount);
              4: Dec(PlayObject.m_MyHero.m_BonusAbil.AC, nCount);
              5: Dec(PlayObject.m_MyHero.m_BonusAbil.MAC, nCount);
              6: Dec(PlayObject.m_MyHero.m_BonusAbil.HP, nCount);
              7: Dec(PlayObject.m_MyHero.m_BonusAbil.MP, nCount);
              8: Dec(PlayObject.m_MyHero.m_BonusAbil.Hit, nCount);
              9: Dec(PlayObject.m_MyHero.m_BonusAbil.Speed, nCount);
            end;
          end;
        '=': begin
            case nPosition of
              1: PlayObject.m_MyHero.m_BonusAbil.DC := nCount;
              2: PlayObject.m_MyHero.m_BonusAbil.MC := nCount;
              3: PlayObject.m_MyHero.m_BonusAbil.SC := nCount;
              4: PlayObject.m_MyHero.m_BonusAbil.AC := nCount;
              5: PlayObject.m_MyHero.m_BonusAbil.MAC := nCount;
              6: PlayObject.m_MyHero.m_BonusAbil.HP := nCount;
              7: PlayObject.m_MyHero.m_BonusAbil.MP := nCount;
              8: PlayObject.m_MyHero.m_BonusAbil.Hit := nCount;
              9: PlayObject.m_MyHero.m_BonusAbil.Speed := nCount;
            end;
          end;
      end;//case
      THeroObject(PlayObject.m_MyHero).RecalcAbilitys();//20081213
      PlayObject.m_MyHero.CompareSuitItem(False);//��װ
      THeroObject(PlayObject.m_MyHero).SendMsg({PlayObject}PlayObject.m_MyHero, RM_HEROABILITY, 0, 0, 0, 0, ''); //����Ӣ������  20090107�޸�
      THeroObject(PlayObject.m_MyHero).SendMsg({PlayObject}PlayObject.m_MyHero, RM_SUBABILITY, 0, 0, 0, 0, '');//20090107�޸�
    end;   
  end else begin
    case cMethod of
      '+': begin
          case nPosition of
            1: Inc(PlayObject.m_BonusAbil.DC, nCount);
            2: Inc(PlayObject.m_BonusAbil.MC, nCount);
            3: Inc(PlayObject.m_BonusAbil.SC, nCount);
            4: Inc(PlayObject.m_BonusAbil.AC, nCount);
            5: Inc(PlayObject.m_BonusAbil.MAC, nCount);
            6: Inc(PlayObject.m_BonusAbil.HP, nCount);
            7: Inc(PlayObject.m_BonusAbil.MP, nCount);
            8: Inc(PlayObject.m_BonusAbil.Hit, nCount);
            9: Inc(PlayObject.m_BonusAbil.Speed, nCount);
          end;
        end;
      '-': begin
          case nPosition of
            1: Dec(PlayObject.m_BonusAbil.DC, nCount);
            2: Dec(PlayObject.m_BonusAbil.MC, nCount);
            3: Dec(PlayObject.m_BonusAbil.SC, nCount);
            4: Dec(PlayObject.m_BonusAbil.AC, nCount);
            5: Dec(PlayObject.m_BonusAbil.MAC, nCount);
            6: Dec(PlayObject.m_BonusAbil.HP, nCount);
            7: Dec(PlayObject.m_BonusAbil.MP, nCount);
            8: Dec(PlayObject.m_BonusAbil.Hit, nCount);
            9: Dec(PlayObject.m_BonusAbil.Speed, nCount);
          end;
        end;
      '=': begin
          case nPosition of
            1: PlayObject.m_BonusAbil.DC := nCount;
            2: PlayObject.m_BonusAbil.MC := nCount;
            3: PlayObject.m_BonusAbil.SC := nCount;
            4: PlayObject.m_BonusAbil.AC := nCount;
            5: PlayObject.m_BonusAbil.MAC := nCount;
            6: PlayObject.m_BonusAbil.HP := nCount;
            7: PlayObject.m_BonusAbil.MP := nCount;
            8: PlayObject.m_BonusAbil.Hit := nCount;
            9: PlayObject.m_BonusAbil.Speed := nCount;
          end;
        end;
    end;
    PlayObject.RecalcAbilitys();
    PlayObject.CompareSuitItem(False);//200080729 ��װ
    PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
    PlayObject.SendMsg(PlayObject, RM_SUBABILITY, 0, 0, 0, 0, '');
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfUseBonusPoint');
end;
end;

procedure TNormNpc.ActionOfKick(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
try
  PlayObject.m_boKickFlag := True;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfKick');
end;
end;

procedure TNormNpc.ActionOfKill(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nMode: Integer;
begin
try
  nMode := Str_ToInt(QuestActionInfo.sParam1, -1);
  if nMode in [0..3] then begin
    case nMode of //
      1: begin
          PlayObject.m_boNoItem := True;
          PlayObject.Die;
        end;
      2: begin
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
      3: begin
          PlayObject.m_boNoItem := True;
          PlayObject.SetLastHiter(Self);
          PlayObject.Die;
        end;
    else begin
        PlayObject.Die;
      end;
    end;
  end else begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_KILL);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfKill');
end;
end;

procedure TNormNpc.ActionOfBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nBonusPoint: Integer;
  cMethod: Char;
begin
try
  //nBonusPoint := Str_ToInt(QuestActionInfo.sParam2, -1);
  nBonusPoint := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  if nBonusPoint < 0 then begin
    GetValValue(PlayObject, QuestActionInfo.sParam2, nBonusPoint); //���ӱ���֧��
  end;
  if (nBonusPoint < 0) or (nBonusPoint > 10000) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_BONUSPOINT);
    Exit;
  end;

  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        FillChar(PlayObject.m_BonusAbil, SizeOf(TNakedAbility), #0);
        PlayObject.HasLevelUp(0);
        PlayObject.m_nBonusPoint := nBonusPoint;
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
    '-': begin
        if PlayObject.m_nBonusPoint >= nBonusPoint then begin
          Dec(PlayObject.m_nBonusPoint, nBonusPoint);
        end else begin
          PlayObject.m_nBonusPoint := 0;
        end;
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
    '+': begin
        Inc(PlayObject.m_nBonusPoint, nBonusPoint);
        PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfBonusPoint');
end;
end;

procedure TNormNpc.ActionOfDelMarry(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
try
  PlayObject.m_sDearName := '';
  PlayObject.RefShowName;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfDelMarry');
end;
end;

procedure TNormNpc.ActionOfDelMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
try
  PlayObject.m_sMasterName := '';
  PlayObject.RefShowName;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfDelMaster');
end;
end;

procedure TNormNpc.ActionOfRestBonusPoint(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nTotleUsePoint: Integer;
begin
try
  nTotleUsePoint := PlayObject.m_BonusAbil.DC +
    PlayObject.m_BonusAbil.MC +
    PlayObject.m_BonusAbil.SC +
    PlayObject.m_BonusAbil.AC +
    PlayObject.m_BonusAbil.MAC +
    PlayObject.m_BonusAbil.HP +
    PlayObject.m_BonusAbil.MP +
    PlayObject.m_BonusAbil.Hit +
    PlayObject.m_BonusAbil.Speed +
    PlayObject.m_BonusAbil.X2;
  FillChar(PlayObject.m_BonusAbil, SizeOf(TNakedAbility), #0);
  Inc(PlayObject.m_nBonusPoint, nTotleUsePoint);
  PlayObject.SendMsg(PlayObject, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
  PlayObject.HasLevelUp(0);
  PlayObject.SysMsg('��������Ѹ�λ������', c_Red, t_Hint);
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfRestBonusPoint');
end;
end;

procedure TNormNpc.ActionOfRestReNewLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
begin
try
  PlayObject.m_btReLevel := 0;
  PlayObject.HasLevelUp(0);
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfRestReNewLevel');
end;
end;

procedure TNormNpc.ActionOfSetMapMode(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  Envir: TEnvirnoment;
  sMapName: string;
  sMapMode, sParam1, sParam2 {,sParam3,sParam4}: string;
begin
try
  sMapName := QuestActionInfo.sParam1;
  sMapMode := QuestActionInfo.sParam2;
  sParam1 := QuestActionInfo.sParam3;
  sParam2 := QuestActionInfo.sParam4;
  //  sParam3:=QuestActionInfo.sParam5;
  //  sParam4:=QuestActionInfo.sParam6;

  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (sMapMode = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMAPMODE);
    Exit;
  end;
  if CompareText(sMapMode, 'SAFE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boSAFE := True;
    end else begin
      Envir.m_boSAFE := False;
    end;
  end else
    if CompareText(sMapMode, 'DARK') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boDARK := True;
    end else begin
      Envir.m_boDARK := False;
    end;
  end else
    if CompareText(sMapMode, 'DARK') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boDARK := True;
    end else begin
      Envir.m_boDARK := False;
    end;
  end else
    if CompareText(sMapMode, 'FIGHT') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boFightZone := True;
    end else begin
      Envir.m_boFightZone := False;
    end;
  end else
    if CompareText(sMapMode, 'FIGHT2') = 0 then begin//PK��װ����ͼ 20080525
    if (sParam1 <> '') then begin
      Envir.m_boFight2Zone := True;
    end else begin
      Envir.m_boFight2Zone := False;
    end;
  end else
    if CompareText(sMapMode, 'FIGHT3') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boFight3Zone := True;
    end else begin
      Envir.m_boFight3Zone := False;
    end;
  end else
    if CompareText(sMapMode, 'FIGHT4') = 0 then begin//��ս��ͼ 20080706
    if (sParam1 <> '') then begin
      Envir.m_boFight4Zone := True;
    end else begin
      Envir.m_boFight4Zone := False;
    end;
  end else
    if CompareText(sMapMode, 'DAY') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boDAY := True;
    end else begin
      Envir.m_boDAY := False;
    end;
  end else
    if CompareText(sMapMode, 'QUIZ') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boQUIZ := True;
    end else begin
      Envir.m_boQUIZ := False;
    end;
  end else
    if CompareText(sMapMode, 'NORECONNECT') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNORECONNECT := True;
      Envir.sNoReconnectMap := sParam1;
    end else begin
      Envir.m_boNORECONNECT := False;
    end;
  end else
    if CompareText(sMapMode, 'MUSIC') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boMUSIC := True;
      Envir.m_nMUSICID := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boMUSIC := False;
    end;
  end else
    if CompareText(sMapMode, 'EXPRATE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boEXPRATE := True;
      Envir.m_nEXPRATE := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boEXPRATE := False;
    end;
  end else
    if CompareText(sMapMode, 'PKWINLEVEL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKWINLEVEL := True;
      Envir.m_nPKWINLEVEL := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boPKWINLEVEL := False;
    end;
  end else
    if CompareText(sMapMode, 'PKWINEXP') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKWINEXP := True;
      Envir.m_nPKWINEXP := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boPKWINEXP := False;
    end;
  end else
    if CompareText(sMapMode, 'PKLOSTLEVEL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKLOSTLEVEL := True;
      Envir.m_nPKLOSTLEVEL := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boPKLOSTLEVEL := False;
    end;
  end else
    if CompareText(sMapMode, 'PKLOSTEXP') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boPKLOSTEXP := True;
      Envir.m_nPKLOSTEXP := Str_ToInt(sParam1, -1);
    end else begin
      Envir.m_boPKLOSTEXP := False;
    end;
  end else
    if CompareText(sMapMode, 'DECHP') = 0 then begin
    if (sParam1 <> '') and (sParam2 <> '') then begin
      Envir.m_boDECHP := True;
      Envir.m_nDECHPTIME := Str_ToInt(sParam1, -1);
      Envir.m_nDECHPPOINT := Str_ToInt(sParam2, -1);
    end else begin
      Envir.m_boDECHP := False;
    end;
  end else
    if CompareText(sMapMode, 'DECGAMEGOLD') = 0 then begin
    if (sParam1 <> '') and (sParam2 <> '') then begin
      Envir.m_boDecGameGold := True;
      Envir.m_nDECGAMEGOLDTIME := Str_ToInt(sParam1, -1);
      Envir.m_nDecGameGold := Str_ToInt(sParam2, -1);
    end else begin
      Envir.m_boDecGameGold := False;
    end;
  end else
    if CompareText(sMapMode, 'RUNHUMAN') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boRUNHUMAN := True;
    end else begin
      Envir.m_boRUNHUMAN := False;
    end;
  end else
    if CompareText(sMapMode, 'RUNMON') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boRUNMON := True;
    end else begin
      Envir.m_boRUNMON := False;
    end;
  end else
    if CompareText(sMapMode, 'NEEDHOLE') = 0 then begin//������Ҫ��
    if (sParam1 <> '') then begin
      Envir.m_boNEEDHOLE := True;
    end else begin
      Envir.m_boNEEDHOLE := False;
    end;
  end else
    if CompareText(sMapMode, 'NORECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNORECALL := True;
    end else begin
      Envir.m_boNORECALL := False;
    end;
  end else
    if CompareText(sMapMode, 'NOGUILDRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNOGUILDRECALL := True;
    end else begin
      Envir.m_boNOGUILDRECALL := False;
    end;
  end else
    if CompareText(sMapMode, 'NODEARRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNODEARRECALL := True;
    end else begin
      Envir.m_boNODEARRECALL := False;
    end;
  end else
    if CompareText(sMapMode, 'NOMASTERRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNOMASTERRECALL := True;
    end else begin
      Envir.m_boNOMASTERRECALL := False;
    end;
  end else
    if CompareText(sMapMode, 'NORANDOMMOVE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNORANDOMMOVE := True;
    end else begin
      Envir.m_boNORANDOMMOVE := False;
    end;
  end else
    if CompareText(sMapMode, 'NODRUG') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNODRUG := True;
    end else begin
      Envir.m_boNODRUG := False;
    end;
  end else
    if CompareText(sMapMode, 'MINE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boMINE := True;
    end else begin
      Envir.m_boMINE := False;
    end;
  end else
    if CompareText(sMapMode, 'NOPOSITIONMOVE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.m_boNOPOSITIONMOVE := True;
    end else begin
      Envir.m_boNOPOSITIONMOVE := False;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSetMapMode');
end;
end;

procedure TNormNpc.ActionOfSetMemberLevel(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nLevel: Integer;
  cMethod: Char;
begin
try
  //nLevel := Str_ToInt(QuestActionInfo.sParam2, -1);
  nLevel := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  if nLevel < 0 then begin
    if not GetValValue(PlayObject, QuestActionInfo.sParam2, nLevel) then begin //���ӱ���֧��
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMEMBERLEVEL);
      Exit;
    end;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        PlayObject.m_nMemberLevel := nLevel;
      end;
    '-': begin
        Dec(PlayObject.m_nMemberLevel, nLevel);
        if PlayObject.m_nMemberLevel < 0 then PlayObject.m_nMemberLevel := 0;
      end;
    '+': begin
        Inc(PlayObject.m_nMemberLevel, nLevel);
        if PlayObject.m_nMemberLevel > 65535 then PlayObject.m_nMemberLevel := 65535;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sChangeMemberLevelMsg, [PlayObject.m_nMemberLevel]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSetMemberLevel');
end;
end;

procedure TNormNpc.ActionOfSetMemberType(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nType: Integer;
  cMethod: Char;
begin
try
  //nType := Str_ToInt(QuestActionInfo.sParam2, -1);
  nType := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam2),-1);//20080501
  if nType < 0 then begin
    if not GetValValue(PlayObject, QuestActionInfo.sParam2, nType) then begin //���ӱ���֧��
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SETMEMBERTYPE);
      Exit;
    end;
  end;
  cMethod := QuestActionInfo.sParam1[1];
  case cMethod of
    '=': begin
        PlayObject.m_nMemberType := nType;
      end;
    '-': begin
        Dec(PlayObject.m_nMemberType, nType);
        if PlayObject.m_nMemberType < 0 then PlayObject.m_nMemberType := 0;
      end;
    '+': begin
        Inc(PlayObject.m_nMemberType, nType);
        if PlayObject.m_nMemberType > 65535 then PlayObject.m_nMemberType := 65535;
      end;
  end;
  if g_Config.boShowScriptActionMsg then begin
    PlayObject.SysMsg(Format(g_sChangeMemberTypeMsg, [PlayObject.m_nMemberType]), c_Green, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSetMemberType');
end;
end;
//���һ����ͼ�ڵĹ�������
function TNormNpc.ConditionOfCheckMonMapCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sMapName: string;
  nCount: Integer;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  MonList: TList;
  BaseObject: TBaseObject;
  nCode: Byte;
begin
  nCode:= 0;
  try
    Result := False;
    sMapName := QuestConditionInfo.sParam1;
    nCode:= 1;
    //nCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
    nCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
    if nCount < 0 then GetValValue(PlayObject, QuestConditionInfo.sParam2, nCount);
    nCode:= 2;
    Envir := g_MapManager.FindMap(sMapName);
    if (Envir = nil) or (nCount < 0) then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sCHECKMONMAP);
      Exit;
    end;
    nCode:= 3;
    MonList := TList.Create;
    try
      nCode:= 4;
      nMapRangeCount := UserEngine.GetMapMonster(Envir, MonList);
      nCode:= 5;
      for I := MonList.Count - 1 downto 0 do begin
        if MonList.Count <= 0 then Break;
        nCode:= 6;
        BaseObject := TBaseObject(MonList.Items[I]);
        if BaseObject <> nil then begin
          nCode:= 7;
          if (BaseObject.m_btRaceServer < RC_ANIMAL) or (BaseObject.m_btRaceServer = RC_ARCHERGUARD) or (BaseObject.m_Master <> nil) or (BaseObject.m_btRaceServer = RC_NPC) or (BaseObject.m_btRaceServer = RC_PEACENPC) then
            MonList.Delete(I);
        end;
      end;
      nCode:= 8;
      nMapRangeCount := MonList.Count;
      if nMapRangeCount >= nCount then Result := True;
    finally
      MonList.Free;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMonMapCount Code:'+inttostr(nCode));
  end;
end;
//-----------------------------------------------------------------------------
//����ͼ����  20080426
//��ʽ:ISONMAP ��ͼ
function TNormNpc.ConditionOfISONMAP(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sMapName: string;
  Envir: TEnvirnoment;
begin
try
  Result := False;
  sMapName:=GetLineVariableText(PlayObject, QuestConditionInfo.sParam1); //��ͼ֧�ֱ���
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ISONMAP);
    Exit;
  end;
  if PlayObject.m_PEnvir = Envir then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfISONMAP');
end;
end;
//-----------------------------------------------------------------------------
//���Լ��һ�����귶Χ�ڹ�������
//��ʽ��CheckRangeMonCount ��ͼ�� X���� Y���� ��Χ ���Ʒ�(=,>,<) ����
function TNormNpc.ConditionOfCheckRangeMonCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sMapName: string;
  nX, nY, nRange, nCount: Integer;
  cMethod: Char;
  nMapRangeCount: Integer;
  Envir: TEnvirnoment;
  MonList: TList;
  BaseObject: TBaseObject;
begin
try
  Result := False;
  //sMapName := QuestConditionInfo.sParam1;
  sMapName:=GetLineVariableText(PlayObject, QuestConditionInfo.sParam1); //��ͼ֧�ֱ��� 20080125
  //nX := Str_ToInt(QuestConditionInfo.sParam2, -1);
  //nY := Str_ToInt(QuestConditionInfo.sParam3, -1);
  //nRange := Str_ToInt(QuestConditionInfo.sParam4, -1);
  //nCount := Str_ToInt(QuestConditionInfo.sParam6, -1);
  nX := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  nY := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam3),-1);//20080501
  nRange := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam4),-1);//20080501
  nCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam6),-1);//20080501
  cMethod := QuestConditionInfo.sParam5[1];
  if nX < 0 then GetValValue(PlayObject, QuestConditionInfo.sParam2, nX);
  if nY < 0 then GetValValue(PlayObject, QuestConditionInfo.sParam3, nY);
  if nRange < 0 then GetValValue(PlayObject, QuestConditionInfo.sParam4, nRange);
  if nCount < 0 then GetValValue(PlayObject, QuestConditionInfo.sParam6, nCount);
  Envir := g_MapManager.FindMap(sMapName);
  if (Envir = nil) or (nX < 0) or (nY < 0) or (nRange < 0) or (nCount < 0) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKRANGEMONCOUNT);
    Exit;
  end;
  MonList := TList.Create;
  try
    nMapRangeCount := Envir.GetRangeBaseObject(nX, nY, nRange, True, MonList);
    for I := MonList.Count - 1 downto 0 do begin
      if MonList.Count <= 0 then Break;
      BaseObject := TBaseObject(MonList.Items[I]);
      if BaseObject <> nil then begin//20090116
        if (BaseObject.m_btRaceServer < RC_ANIMAL) or (BaseObject.m_btRaceServer = RC_ARCHERGUARD) or (BaseObject.m_Master <> nil) or (BaseObject.m_btRaceServer = RC_NPC) or (BaseObject.m_btRaceServer = RC_PEACENPC) then
          MonList.Delete(I);
      end;
    end;
    nMapRangeCount := MonList.Count;
    case cMethod of
      '=': if nMapRangeCount = nCount then Result := True;
      '>': if nMapRangeCount > nCount then Result := True;
      '<': if nMapRangeCount < nCount then Result := True;
    else if nMapRangeCount >= nCount then Result := True;
    end;
  finally
    MonList.Free;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckRangeMonCount');
end;
end;

function TNormNpc.ConditionOfCheckReNewLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nLevel: Integer;
  cMethod: Char;
begin
try
  Result := False;
  //nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nLevel := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nLevel < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nLevel) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKRENEWLEVEL);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btReLevel = nLevel then Result := True;
    '>': if PlayObject.m_btReLevel > nLevel then Result := True;
    '<': if PlayObject.m_btReLevel < nLevel then Result := True;
  else if PlayObject.m_btReLevel >= nLevel then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckReNewLevel');
end;
end;

function TNormNpc.ConditionOfCheckSlaveLevel(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  nLevel: Integer;
  cMethod: Char;
  BaseObject: TBaseObject;
  nSlaveLevel: Integer;
begin
try
  Result := False;
  //nLevel := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nLevel := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nLevel < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nLevel) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSLAVELEVEL);
      Exit;
    end;
  end;
  nSlaveLevel := -1;
  if PlayObject.m_SlaveList.Count > 0 then begin//20080629
    for I := 0 to PlayObject.m_SlaveList.Count - 1 do begin
      BaseObject := TBaseObject(PlayObject.m_SlaveList.Items[I]);
      if BaseObject.m_Abil.Level > nSlaveLevel then nSlaveLevel := BaseObject.m_Abil.Level;
    end;
  end;
  if nSlaveLevel < 0 then Exit;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nSlaveLevel = nLevel then Result := True;
    '>': if nSlaveLevel > nLevel then Result := True;
    '<': if nSlaveLevel < nLevel then Result := True;
  else if nSlaveLevel >= nLevel then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckSlaveLevel');
end;
end;
//�����������ָ����Ʒλ���Ƿ����ָ����Ʒ���ƣ�Ϊ��������������ָ��λ���Ƿ������Ʒ��
//��ʽ:CHECKUSEITEM ��Ʒλ��(0-13) ��Ʒ����
function TNormNpc.ConditionOfCheckUseItem(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nWhere: Integer;
  sItmeName: String;
  StdItem: pTStdItem;
begin
try
  Result := False;
  //nWhere := Str_ToInt(QuestConditionInfo.sParam1, -1);
  nWhere := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam1),-1);//20080501
  sItmeName := GetLineVariableText(PlayObject,QuestConditionInfo.sParam2);//20080605 ��Ʒ����
  if nWhere < 0 then GetValValue(PlayObject, QuestConditionInfo.sParam1, nWhere);
  if (nWhere < 0) or (nWhere > High(THumanUseItems)) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKUSEITEM);
    Exit;
  end;
  if sItmeName <> '' then begin
     StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nWhere].wIndex);
     if (StdItem <> nil) then begin
       if CompareText(StdItem.Name, sItmeName) = 0 then  Result := True;
     end;
  end else
  if PlayObject.m_UseItems[nWhere].wIndex > 0 then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckUseItem');
end;
end;

function TNormNpc.ConditionOfCheckVar(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sType: string;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sName: string;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '����%s�Ѵ��ڣ���������:%s';
  sVarTypeError = '�������ʹ��󣬴�������:%s ��ǰ֧������(HUMAN��GUILD��GLOBAL)';
begin
try
  Result := False;
  sType := QuestConditionInfo.sParam1;
  sVarName := QuestConditionInfo.sParam2;
  sMethod := QuestConditionInfo.sParam3;
  //nVarValue := Str_ToInt(QuestConditionInfo.sParam4, 0);
  //sVarValue := QuestConditionInfo.sParam4;  
  nVarValue := Str_ToInt(GetLineVariableText(PlayObject, QuestConditionInfo.sParam4),0);//20080601 ֧�ֱ���
  sVarValue := GetLineVariableText(PlayObject, QuestConditionInfo.sParam4);//20080601 ֧�ֱ���

  if (sType = '') or (sVarName = '') or (sMethod = '') then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKVAR);
    Exit;
  end;
  cMethod := sMethod[1];
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptConditionError(PlayObject {,format(sVarTypeError,[sType])}, QuestConditionInfo, sSC_CHECKVAR);
    Exit;
  end else begin
    if DynamicVarList.Count > 0 then begin//20080629
      for I := 0 to DynamicVarList.Count - 1 do begin
        DynamicVar := DynamicVarList.Items[I];
        if DynamicVar <> nil then begin
          if CompareText(DynamicVar.sName, sVarName) = 0 then begin
            case DynamicVar.VarType of
              vInteger: begin
                  case cMethod of
                    '=': if DynamicVar.nInternet = nVarValue then Result := True;
                    '>': if DynamicVar.nInternet > nVarValue then Result := True;
                    '<': if DynamicVar.nInternet < nVarValue then Result := True;
                  else if DynamicVar.nInternet >= nVarValue then Result := True;
                  end;
                end;
              vString: begin
                  case cMethod of//20080603 �����ַ����Ա�
                   '=':if CompareText(DynamicVar.sString, sVarValue) = 0 then Result := True;
                  end;
                end;
            end;
            boFoundVar := True;
            Break;
          end;
        end;
      end;//for
    end;
    if not boFoundVar then
      ScriptConditionError(PlayObject, {format(sVarFound,[sVarName,sType]),} QuestConditionInfo, sSC_CHECKVAR);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckVar');
end;
end;

(*function TNormNpc.ConditionOfCheckVar(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  i: Integer;
  sType: string;
  VarType: TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sVarValue2: string;
  nVarValue2: Integer;
  sName: string;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '����%s�Ѵ��ڣ���������:%s';
  sVarTypeError = '�������ʹ��󣬴�������:%s ��ǰ֧������(HUMAN��GUILD��GLOBAL)';
begin
  Result := False;
  sType := QuestConditionInfo.sParam1;
  sVarName := QuestConditionInfo.sParam2;
  sMethod := QuestConditionInfo.sParam3;
  sVarValue := QuestConditionInfo.sParam4;
  sVarValue2 := QuestConditionInfo.sParam5;
  if (sType = '') or (sVarName = '') or (sMethod = '') then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKVAR);
    Exit;
  end;
  boFoundVar := False;
  if (sVarValue <> '') and (sVarValue2 <> '') and (not IsStringNumber(sVarValue)) and (not IsStringNumber(sVarValue2)) then begin
    DynamicVarList := GetDynamicVarList(PlayObject, sVarValue, sName);
    if DynamicVarList = nil then begin
      DisPose(DynamicVar);
      ScriptConditionError(PlayObject {,format(sVarTypeError,[sType])}, QuestConditionInfo, sSC_CHECKVAR);
      Exit;
    end else begin
      for i := 0 to DynamicVarList.Count - 1 do begin
        DynamicVar := DynamicVarList.Items[i];
        if DynamicVar <> nil then begin
          if CompareText(DynamicVar.sName, sVarValue2) = 0 then begin
            case DynamicVar.VarType of
              vInteger: begin
                  nVarValue := DynamicVar.nInternet;
                end;
              vString: begin

                end;
            end;
            boFoundVar := True;
            break;
          end;
        end;
      end;
      if not boFoundVar then begin
        ScriptConditionError(PlayObject, {format(sVarFound,[sVarName,sType]),} QuestConditionInfo, sSC_CHECKVAR);
        Exit;
      end;
    end;
  end else nVarValue := Str_ToInt(QuestConditionInfo.sParam4, 0);
  cMethod := sMethod[1];
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptConditionError(PlayObject {,format(sVarTypeError,[sType])}, QuestConditionInfo, sSC_CHECKVAR);
    Exit;
  end;
  for i := 0 to DynamicVarList.Count - 1 do begin
    DynamicVar := DynamicVarList.Items[i];
    if CompareText(DynamicVar.sName, sVarName) = 0 then begin
      case DynamicVar.VarType of
        vInteger: begin
            case cMethod of
              '=': if DynamicVar.nInternet = nVarValue then Result := True;
              '>': if DynamicVar.nInternet > nVarValue then Result := True;
              '<': if DynamicVar.nInternet < nVarValue then Result := True;
              else if DynamicVar.nInternet >= nVarValue then Result := True;
            end;
          end;
        vString: ;
      end;
      boFoundVar := True;
      break;
    end;
  end;
  if not boFoundVar then
    ScriptConditionError(PlayObject, {format(sVarFound,[sVarName,sType]),} QuestConditionInfo, sSC_CHECKVAR);
end;*)

function TNormNpc.ConditionOfHaveMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := False;
  if PlayObject.m_sMasterName <> '' then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfHaveMaster');
end;
end;

function TNormNpc.ConditionOfPoseHaveMaster(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  PoseHuman: TBaseObject;
begin
try
  Result := False;
  PoseHuman := PlayObject.GetPoseCreate();
  if (PoseHuman <> nil) and (PoseHuman.m_btRaceServer = RC_PLAYOBJECT) then begin
    if (TPlayObject(PoseHuman).m_sMasterName <> '') then
      Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfPoseHaveMaster');
end;
end;

procedure TNormNpc.ActionOfUnMaster(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  PoseHuman: TPlayObject;
  sMsg: string;
begin
try
  if PlayObject.m_sMasterName = '' then begin
    GotoLable(PlayObject, '@ExeMasterFail', False);
    Exit;
  end;
  PoseHuman := TPlayObject(PlayObject.GetPoseCreate);
  if PoseHuman = nil then begin
    GotoLable(PlayObject, '@UnMasterCheckDir', False);
  end;
  if PoseHuman <> nil then begin
    if QuestActionInfo.sParam1 = '' then begin
      if PoseHuman.m_btRaceServer <> RC_PLAYOBJECT then begin
        GotoLable(PlayObject, '@UnMasterTypeErr', False);
        Exit;
      end;
      if PoseHuman.GetPoseCreate = PlayObject then begin
        if (PlayObject.m_sMasterName = PoseHuman.m_sCharName) then begin
          if PlayObject.m_boMaster then begin
            GotoLable(PlayObject, '@UnIsMaster', False);
            Exit;
          end;
          if PlayObject.m_sMasterName <> PoseHuman.m_sCharName then begin
            GotoLable(PlayObject, '@UnMasterError', False);
            Exit;
          end;

          GotoLable(PlayObject, '@StartUnMaster', False);
          GotoLable(PoseHuman, '@WateUnMaster', False);
          Exit;
        end;
      end;
    end;
  end;

  if (CompareText(QuestActionInfo.sParam1, 'REQUESTUNMASTER' {sREQUESTUNMARRY}) = 0) then begin//������ʦ
    if (QuestActionInfo.sParam2 = '') then begin
      if PoseHuman <> nil then begin //PoseHuman-ʦ�� PlayObject-ͽ��
        PlayObject.m_boStartUnMaster := True;
        if PlayObject.m_boStartUnMaster and PoseHuman.m_boStartUnMaster then begin
          sMsg := AnsiReplaceText(g_sNPCSayUnMasterOKMsg, '%n', m_sCharName);
          sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
          sMsg := AnsiReplaceText(sMsg, '%d', PoseHuman.m_sCharName);
          UserEngine.SendBroadCastMsg(sMsg, t_Say);
          PlayObject.m_sMasterName := '';
          PoseHuman.m_sMasterName := '';
          PlayObject.m_boStartUnMaster := False;
          PoseHuman.m_boStartUnMaster := False;
          PoseHuman.DelMaster(PlayObject.m_sCharName);//��ʦ 20080530
          if g_FunctionNPC <> nil then begin
            g_FunctionNPC.GotoLable(PoseHuman, '@UnMasterEnd', False);//ʦ������ 20080530
            g_FunctionNPC.GotoLable(PlayObject, '@UnMasterEnd1', False);//ͽ�ܴ��� 20080530
          end;
          PlayObject.RefShowName;
          PoseHuman.RefShowName;
          GotoLable(PlayObject, '@UnMasterEnd', False);
          GotoLable(PoseHuman, '@UnMasterEnd', False);
        end else begin
          GotoLable(PlayObject, '@WateUnMaster', False);
          GotoLable(PoseHuman, '@RevUnMaster', False);
        end;
      end;
      Exit;
    end else begin
      if (CompareText(QuestActionInfo.sParam2, 'FORCE') = 0) then begin //ǿ�г�ʦ
        sMsg := AnsiReplaceText(g_sNPCSayForceUnMasterMsg, '%n', m_sCharName);
        sMsg := AnsiReplaceText(sMsg, '%s', PlayObject.m_sCharName);
        sMsg := AnsiReplaceText(sMsg, '%d', PlayObject.m_sMasterName);
        UserEngine.SendBroadCastMsg(sMsg, t_Say);
        if g_FunctionNPC <> nil then g_FunctionNPC.GotoLable(PlayObject, '@UnMasterEnd1', False);//ͽ�ܴ��� 20080530

        PoseHuman := UserEngine.GetPlayObject(PlayObject.m_sMasterName);
        if PoseHuman <> nil then begin
          PoseHuman.m_sMasterName := '';
          PoseHuman.DelMaster(PlayObject.m_sCharName);//��ʦ 20080530
          if g_FunctionNPC <> nil then begin
            g_FunctionNPC.GotoLable(PoseHuman, '@UnMasterEnd', False);//ʦ������ 20080530
          end;
          PoseHuman.RefShowName;
        end else begin
          g_UnForceMasterList.Lock;
          try
            g_UnForceMasterList.Add(PlayObject.m_sMasterName+' '+PlayObject.m_sCharName);// 20080530
            SaveUnForceMasterList();
          finally
            g_UnForceMasterList.UnLock;
          end;
        end;
        PlayObject.m_sMasterName := '';
        GotoLable(PlayObject, '@UnMasterEnd', False);
        PlayObject.RefShowName;
      end;
      Exit;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfUnMaster');
end;
end;

function TNormNpc.ConditionOfCheckCastleGold(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nGold: Integer;
begin
try
  Result := False;
  //nGold := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nGold := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nGold < 0 then GetValValue(PlayObject, QuestConditionInfo.sParam2, nGold);
  if (nGold < 0) or (m_Castle = nil) then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCASTLEGOLD);
    Exit;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if TUserCastle(m_Castle).m_nTotalGold = nGold then Result := True;
    '>': if TUserCastle(m_Castle).m_nTotalGold > nGold then Result := True;
    '<': if TUserCastle(m_Castle).m_nTotalGold < nGold then Result := True;
  else if TUserCastle(m_Castle).m_nTotalGold >= nGold then Result := True;
  end;
  {
  Result:=False;
  nGold:=Str_ToInt(QuestConditionInfo.sParam2, -1);
  if nGold < 0 then begin
    ScriptConditionError(PlayObject,QuestConditionInfo,sSC_CHECKCASTLEGOLD);
    exit;
  end;
  cMethod:=QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if UserCastle.m_nTotalGold = nGold then Result:=True;
    '>': if UserCastle.m_nTotalGold > nGold then Result:=True;
    '<': if UserCastle.m_nTotalGold < nGold then Result:=True;
    else if UserCastle.m_nTotalGold >= nGold then Result:=True;
  end;
  }
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckCastleGold');
end;
end;


function TNormNpc.ConditionOfCheckContribution(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nContribution: Integer;
  cMethod: Char;
begin
try
  Result := False;
  //nContribution := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nContribution := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nContribution < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nContribution) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCONTRIBUTION);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_wContribution = nContribution then Result := True;
    '>': if PlayObject.m_wContribution > nContribution then Result := True;
    '<': if PlayObject.m_wContribution < nContribution then Result := True;
  else if PlayObject.m_wContribution >= nContribution then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckContribution');
end;
end;

function TNormNpc.ConditionOfCheckCreditPoint(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCreditPoint: Integer;
  cMethod: Char;
begin
try
  Result := False;
  //nCreditPoint := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nCreditPoint := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nCreditPoint < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nCreditPoint) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKCREDITPOINT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btCreditPoint = nCreditPoint then Result := True;
    '>': if PlayObject.m_btCreditPoint > nCreditPoint then Result := True;
    '<': if PlayObject.m_btCreditPoint < nCreditPoint then Result := True;
  else if PlayObject.m_btCreditPoint >= nCreditPoint then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckCreditPoint');
end;
end;

procedure TNormNpc.ActionOfClearNeedItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nNeed: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
try
  //nNeed := Str_ToInt(QuestActionInfo.sParam1, -1);
  nNeed := Str_ToInt(GetLineVariableText(PlayObject,QuestActionInfo.sParam1),-1);//20080501
  if (nNeed < 0) then begin
    if not GetValValue(PlayObject, QuestActionInfo.sParam1, nNeed) then begin //���ӱ���֧��
      ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARNEEDITEMS);
      Exit;
    end;
  end;
  for I := PlayObject.m_ItemList.Count - 1 downto 0 do begin
    if PlayObject.m_ItemList.Count <= 0 then Break;
    UserItem := PlayObject.m_ItemList.Items[I];
    if UserItem = nil then Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and (StdItem.Need = nNeed) then begin
      PlayObject.SendDelItems(UserItem);
      Dispose(UserItem);
      PlayObject.m_ItemList.Delete(I);
    end;
  end;

  for I := PlayObject.m_StorageItemList.Count - 1 downto 0 do begin
    if PlayObject.m_StorageItemList.Count <= 0 then Break;
    UserItem := PlayObject.m_StorageItemList.Items[I];
    if UserItem = nil then Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and (StdItem.Need = nNeed) then begin
      Dispose(UserItem);
      PlayObject.m_StorageItemList.Delete(I);
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfClearNeedItems');
end;
end;

procedure TNormNpc.ActionOfClearMakeItems(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  nMakeIndex: Integer;
  sItemName: string;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  boMatchName: Boolean;
begin
try
  sItemName := QuestActionInfo.sParam1;
  nMakeIndex := QuestActionInfo.nParam2;
  boMatchName := QuestActionInfo.sParam3 = '1';
  if (sItemName = '') or (nMakeIndex <= 0) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CLEARMAKEITEMS);
    Exit;
  end;

  for I := PlayObject.m_ItemList.Count - 1 downto 0 do begin
    if PlayObject.m_ItemList.Count <= 0 then Break;
    UserItem := PlayObject.m_ItemList.Items[I];
    if UserItem = nil then Continue;
    if UserItem.MakeIndex <> nMakeIndex then Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0)) then begin
      PlayObject.SendDelItems(UserItem);
      Dispose(UserItem);
      PlayObject.m_ItemList.Delete(I);
    end;
  end;

  for I := PlayObject.m_StorageItemList.Count - 1 downto 0 do begin
    if PlayObject.m_StorageItemList.Count <= 0 then Break;
    UserItem := PlayObject.m_ItemList.Items[I];
    if UserItem = nil then Continue;
    if UserItem.MakeIndex <> nMakeIndex then Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0)) then begin
      Dispose(UserItem);
      PlayObject.m_StorageItemList.Delete(I);
    end;
  end;

  for I := Low(PlayObject.m_UseItems) to High(PlayObject.m_UseItems) do begin
    UserItem := @PlayObject.m_UseItems[I];
    if UserItem.MakeIndex <> nMakeIndex then Continue;
    StdItem := UserEngine.GetStdItem(UserItem.wIndex);
    if not boMatchName or ((StdItem <> nil) and (CompareText(StdItem.Name, sItemName) = 0)) then begin
      UserItem.wIndex := 0;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfClearMakeItems');
end;
end;
//����ף����
procedure TNormNpc.SendCustemMsg(PlayObject: TPlayObject; sMsg: string);
begin
try
  if not g_Config.boSendCustemMsg then begin
    PlayObject.SysMsg(g_sSendCustMsgCanNotUseNowMsg, c_Red, t_Hint);
    Exit;
  end;
  if PlayObject.m_boSendMsgFlag then begin
    PlayObject.m_boSendMsgFlag := False;
    UserEngine.SendBroadCastMsg(PlayObject.m_sCharName + ': ' + sMsg, t_Cust);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.SendCustemMsg');
end;
end;

function TNormNpc.ConditionOfCheckOfGuild(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  sGuildName: string;
begin
try
  Result := False;
  if QuestConditionInfo.sParam1 = '' then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKOFGUILD);
    Exit;
  end;
  if (PlayObject.m_MyGuild <> nil) then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam1, sGuildName) then begin //���ӱ���֧��
      sGuildName := QuestConditionInfo.sParam1;
    end;
    if CompareText(TGUild(PlayObject.m_MyGuild).sGuildName, sGuildName) = 0 then begin
      Result := True;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckOfGuild');
end;
end;

function TNormNpc.ConditionOfCheckOnlineLongMin(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  cMethod: Char;
  nOnlineMin: Integer;
  nOnlineTime: Integer;
begin
try
  Result := False;
  //nOnlineMin := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nOnlineMin := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nOnlineMin < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nOnlineMin) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_ONLINELONGMIN);
      Exit;
    end;
  end;
  nOnlineTime := (GetTickCount - PlayObject.m_dwLogonTick) div 60000;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if nOnlineTime = nOnlineMin then Result := True;
    '>': if nOnlineTime > nOnlineMin then Result := True;
    '<': if nOnlineTime < nOnlineMin then Result := True;
  else if nOnlineTime >= nOnlineMin then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckOnlineLongMin');
end;
end;

function TNormNpc.ConditionOfCheckPasswordErrorCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nErrorCount: Integer;
  cMethod: Char;
begin
try
  Result := False;
  //nErrorCount := Str_ToInt(QuestConditionInfo.sParam2, -1);
  nErrorCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam2),-1);//20080501
  if nErrorCount < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam2, nErrorCount) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_PASSWORDERRORCOUNT);
      Exit;
    end;
  end;
  cMethod := QuestConditionInfo.sParam1[1];
  case cMethod of
    '=': if PlayObject.m_btPwdFailCount = nErrorCount then Result := True;
    '>': if PlayObject.m_btPwdFailCount > nErrorCount then Result := True;
    '<': if PlayObject.m_btPwdFailCount < nErrorCount then Result := True;
  else if PlayObject.m_btPwdFailCount >= nErrorCount then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPasswordErrorCount');
end;
end;

function TNormNpc.ConditionOfIsLockPassword(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := PlayObject.m_boPasswordLocked;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfIsLockPassword');
end;
end;

function TNormNpc.ConditionOfIsLockStorage(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
begin
try
  Result := not PlayObject.m_boCanGetBackItem;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfIsLockStorage');
end;
end;

function TNormNpc.ConditionOfCheckPayMent(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nPayMent: Integer;
begin
try
  Result := False;
  nPayMent := Str_ToInt(QuestConditionInfo.sParam1, -1);
  if nPayMent < 1 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam1, nPayMent) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKPAYMENT);
      Exit;
    end;
  end;
  if PlayObject.m_nPayMent = nPayMent then Result := True;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckPayMent');
end;
end;

function TNormNpc.ConditionOfCheckSlaveName(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  sSlaveName: string;
  BaseObject: TBaseObject;
begin
try
  Result := False;
  if QuestConditionInfo.sParam1 = '' then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKSLAVENAME);
    Exit;
  end;
  if not GetValValue(PlayObject, QuestConditionInfo.sParam1, sSlaveName) then begin //���ӱ���֧��
    sSlaveName := QuestConditionInfo.sParam1;
  end;
  if PlayObject.m_SlaveList.Count > 0 then begin//20080629
    for I := 0 to PlayObject.m_SlaveList.Count - 1 do begin
      BaseObject := TBaseObject(PlayObject.m_SlaveList.Items[I]);
      if CompareText(sSlaveName, BaseObject.m_sCharName) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckSlaveName');
end;
end;
//������Ʒ
procedure TNormNpc.ActionOfUpgradeItems(PlayObject: TPlayObject; QuestActionInfo: pTQuestActionInfo);
var
  nRate, nWhere, nValType, nPoint, nAddPoint: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
begin
try
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  nRate := Str_ToInt(QuestActionInfo.sParam2, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam3, -1);
  if nWhere < 0 then GetValValue(PlayObject, QuestActionInfo.sParam1, nWhere); //���ӱ���֧��
  if nRate < 0 then GetValValue(PlayObject, QuestActionInfo.sParam2, nRate); //���ӱ���֧��
  if nPoint < 0 then GetValValue(PlayObject, QuestActionInfo.sParam3, nPoint); //���ӱ���֧��
  if (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nRate < 0) or (nPoint < 0) or (nPoint > 255) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMS);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    PlayObject.SysMsg('������û�д�ָ����Ʒ������', c_Red, t_Hint);
    Exit;
  end;
  nRate := Random(nRate);
  nPoint := Random(nPoint);
  nValType := Random(16);//20080324
  if nRate <> 0 then begin
    PlayObject.SysMsg('װ������ʧ�ܣ�����', c_Red, t_Hint);
    Exit;
  end;

  UserItem.btValue[9] := _MIN(255, UserItem.btValue[9] + 1);//�ۻ��������� 20080816

  if (nValType = 15) and (StdItem.Shape = 188) then begin//�������� 20080324
    UserItem.btValue[20] := UserItem.btValue[20] + nPoint;
    if UserItem.btValue[20] > 100 then UserItem.btValue[20] := 100;
  end else
  if nValType = 14 then begin
    nAddPoint := (nPoint * 1000);
    if UserItem.DuraMax + nAddPoint > High(Word) then begin
      nAddPoint := High(Word) - UserItem.DuraMax;
    end;
    UserItem.DuraMax := UserItem.DuraMax + nAddPoint;
  end else begin
    nAddPoint := nPoint;
    if UserItem.btValue[nValType] + nAddPoint > High(Byte) then begin
      nAddPoint := High(Byte) - UserItem.btValue[nValType];
    end;
    UserItem.btValue[nValType] := UserItem.btValue[nValType] + nAddPoint;
   if StdItem.NeedIdentify = 1 then//20080613 װ��������־
      AddGameDataLog('31' + #9 +
        PlayObject.m_sMapName + #9 +
        IntToStr(PlayObject.m_nCurrX) + #9 + IntToStr(PlayObject.m_nCurrY) + #9 +
        PlayObject.m_sCharName + #9 + StdItem.Name + #9 +
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
  end;
  PlayObject.SendUpdateItem(UserItem);
  PlayObject.SysMsg('װ�������ɹ�', c_Green, t_Hint);
{  PlayObject.SysMsg(StdItem.Name + ': ' +  //20080914 ע��
    IntToStr(UserItem.Dura) + '/' +
    IntToStr(UserItem.DuraMax) + '/' +
    IntToStr(UserItem.btValue[0]) + '/' +
    IntToStr(UserItem.btValue[1]) + '/' +
    IntToStr(UserItem.btValue[2]) + '/' +
    IntToStr(UserItem.btValue[3]) + '/' +
    IntToStr(UserItem.btValue[4]) + '/' +
    IntToStr(UserItem.btValue[5]) + '/' +
    IntToStr(UserItem.btValue[6]) + '/' +
    IntToStr(UserItem.btValue[7]) + '/' +
    IntToStr(UserItem.btValue[8]) + '/' +
    IntToStr(UserItem.btValue[9]) + '/' +
    IntToStr(UserItem.btValue[10]) + '/' +
    IntToStr(UserItem.btValue[11]) + '/' +
    IntToStr(UserItem.btValue[12]) + '/' +
    IntToStr(UserItem.btValue[13]) + '/' +
    IntToStr(UserItem.btValue[20])//��������
    , c_Blue, t_Hint);  }
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfUpgradeItems');
end;
end;
//������Ʒ
procedure TNormNpc.ActionOfUpgradeItemsEx(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  nRate, nWhere, nValType, nPoint, nAddPoint: Integer;
  UserItem: pTUserItem;
  StdItem: pTStdItem;
  nUpgradeItemStatus: Integer;
  nRatePoint: Integer;
begin
try
  nWhere := Str_ToInt(QuestActionInfo.sParam1, -1);
  nValType := Str_ToInt(QuestActionInfo.sParam2, -1);
  nRate := Str_ToInt(QuestActionInfo.sParam3, -1);
  nPoint := Str_ToInt(QuestActionInfo.sParam4, -1);
  if nWhere < 0 then GetValValue(PlayObject, QuestActionInfo.sParam1, nWhere); //���ӱ���֧��
  if nValType < 0 then GetValValue(PlayObject, QuestActionInfo.sParam2, nValType); //���ӱ���֧��
  if nRate < 0 then GetValValue(PlayObject, QuestActionInfo.sParam3, nRate); //���ӱ���֧��
  if nPoint < 0 then GetValValue(PlayObject, QuestActionInfo.sParam4, nPoint); //���ӱ���֧��
  nUpgradeItemStatus := Str_ToInt(QuestActionInfo.sParam5, -1);
  if (nValType < 0) or (nValType > 15) or (nWhere < 0) or (nWhere > High(THumanUseItems)) or (nRate < 0) or (nPoint < 0) or (nPoint > 255) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_UPGRADEITEMSEX);
    Exit;
  end;
  UserItem := @PlayObject.m_UseItems[nWhere];
  StdItem := UserEngine.GetStdItem(UserItem.wIndex);
  if (UserItem.wIndex <= 0) or (StdItem = nil) then begin
    PlayObject.SysMsg('������û�д�ָ����Ʒ������', c_Red, t_Hint);
    Exit;
  end;
  nRatePoint := Random(nRate * 10);
  nPoint := _MAX(1, Random(nPoint));

  if not (nRatePoint in [0..10]) then begin
    case nUpgradeItemStatus of //
      0: begin
          PlayObject.SysMsg('װ������δ�ɹ�������', c_Red, t_Hint);
        end;
      1: begin
          PlayObject.SendDelItems(UserItem);
          UserItem.wIndex := 0;
          PlayObject.SysMsg('װ�����飡����', c_Red, t_Hint);
        end;
      2: begin
          PlayObject.SysMsg('װ������ʧ�ܣ�װ�����Իָ�Ĭ�ϣ�����', c_Red, t_Hint);
          if nValType <> 14 then UserItem.btValue[nValType] := 0;
          if (nValType = 15) and (StdItem.Shape = 188) then begin
            UserItem.btValue[20] := 0;
          end;
        end;
    end;
    Exit;
  end;
  UserItem.btValue[9] := _MIN(255, UserItem.btValue[9] + 1);//�ۻ��������� 20080816

  if (nValType = 15) and (StdItem.Shape = 188) then begin//�������� 20080324
    UserItem.btValue[20] := UserItem.btValue[20] + nPoint;
    if UserItem.btValue[20] > 100 then UserItem.btValue[20] := 100;
  end else
  if nValType = 14 then begin
    nAddPoint := (nPoint * 1000);
    if UserItem.DuraMax + nAddPoint > High(Word) then begin
      nAddPoint := High(Word) - UserItem.DuraMax;
    end;
    UserItem.DuraMax := UserItem.DuraMax + nAddPoint;
  end else begin
    nAddPoint := nPoint;
    if UserItem.btValue[nValType] + nAddPoint > High(Byte) then begin
      nAddPoint := High(Byte) - UserItem.btValue[nValType];
    end;
    UserItem.btValue[nValType] := UserItem.btValue[nValType] + nAddPoint;
  end;
  PlayObject.SendUpdateItem(UserItem);
  PlayObject.SysMsg('װ�������ɹ�', c_Green, t_Hint);
{  PlayObject.SysMsg(StdItem.Name + ': ' +   //20080914 ע��
    IntToStr(UserItem.Dura) + '/' +
    IntToStr(UserItem.DuraMax) + '-' +
    IntToStr(UserItem.btValue[0]) + '/' +
    IntToStr(UserItem.btValue[1]) + '/' +
    IntToStr(UserItem.btValue[2]) + '/' +
    IntToStr(UserItem.btValue[3]) + '/' +
    IntToStr(UserItem.btValue[4]) + '/' +
    IntToStr(UserItem.btValue[5]) + '/' +
    IntToStr(UserItem.btValue[6]) + '/' +
    IntToStr(UserItem.btValue[7]) + '/' +
    IntToStr(UserItem.btValue[8]) + '/' +
    IntToStr(UserItem.btValue[9]) + '/' +//����װ���ȼ� 
    IntToStr(UserItem.btValue[10]) + '/' +
    IntToStr(UserItem.btValue[11]) + '/' +
    IntToStr(UserItem.btValue[12]) + '/' +
    IntToStr(UserItem.btValue[13]) + '/' +
    IntToStr(UserItem.btValue[20])//��������
    , c_Blue, t_Hint);     }
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfUpgradeItemsEx');
end;
end;
//��������
//VAR ��������(Integer String) ����(HUMAN GUILD GLOBAL) ����ֵ
procedure TNormNpc.ActionOfVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  VarType: TVarType;
  sVarName: string;
  sVarValue: string;
  nVarValue: Integer;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '����%s�Ѵ��ڣ���������:%s';
  sVarTypeError = '�������ʹ��󣬴�������:%s ��ǰ֧������(HUMAN��GUILD��GLOBAL)';
begin
try
  sType := QuestActionInfo.sParam2;
  sVarName := QuestActionInfo.sParam3;
  sVarValue := QuestActionInfo.sParam4;
  nVarValue := Str_ToInt(QuestActionInfo.sParam4, 0);
  VarType := vNone;
  if CompareText(QuestActionInfo.sParam1, 'Integer') = 0 then VarType := vInteger;
  if CompareText(QuestActionInfo.sParam1, 'String') = 0 then VarType := vString;

  if (sType = '') or (sVarName = '') or (VarType = vNone) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_VAR);
    Exit;
  end;
  New(DynamicVar);
  DynamicVar.sName := sVarName;
  DynamicVar.VarType := VarType;
  DynamicVar.nInternet := nVarValue;
  DynamicVar.sString := sVarValue;
  boFoundVar := False;
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    Dispose(DynamicVar);
    ScriptActionError(PlayObject, Format(sVarTypeError, [sType]), QuestActionInfo, sSC_VAR);
    Exit;
  end;
  if DynamicVarList.Count > 0 then begin//20080629
    for I := 0 to DynamicVarList.Count - 1 do begin
      if CompareText(pTDynamicVar(DynamicVarList.Items[I]).sName, sVarName) = 0 then begin
        boFoundVar := True;
        Break;
      end;
    end;
  end;
  if not boFoundVar then begin
    DynamicVarList.Add(DynamicVar);
  end else begin
    Dispose(DynamicVar); //2006-12-10 Ҷ���Ʈ���ӷ�ֹ�ڴ�й¶
    ScriptActionError(PlayObject, Format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_VAR);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfVar');
end;
end;
//��ȡ����ֵ
//LOADVAR �������� ������ �ļ���
procedure TNormNpc.ActionOfLoadVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sFileName: string;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  IniFile: TIniFile;
resourcestring
  sVarFound = '����%s�����ڣ���������:%s';
  sVarTypeError = '�������ʹ��󣬴�������:%s ��ǰ֧������(HUMAN��GUILD��GLOBAL)';
begin
try
  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  //sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam3;
  sFileName := QuestActionInfo.sParam3;
  if sFileName[1] = '\' then sFileName := Copy(sFileName, 2, Length(sFileName) - 1); //20080430 ����,�����ļ�·��
  if sFileName[2] = '\' then sFileName := Copy(sFileName, 3, Length(sFileName) - 2);
  if sFileName[3] = '\' then sFileName := Copy(sFileName, 4, Length(sFileName) - 3);
  sFileName:= g_Config.sEnvirDir + sFileName;

  if (sType = '') or (sVarName = '') or not FileExists(sFileName) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_LOADVAR);
    Exit;
  end;
  boFoundVar := False;
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptActionError(PlayObject, Format(sVarTypeError, [sType]), QuestActionInfo, sSC_VAR);
    Exit;
  end else begin
    IniFile := TIniFile.Create(sFileName);
    try
      if DynamicVarList.Count > 0 then begin//20080629
        for I := 0 to DynamicVarList.Count - 1 do begin
          DynamicVar := DynamicVarList.Items[I];
          if DynamicVar <> nil then begin
            if CompareText(DynamicVar.sName, sVarName) = 0 then begin
              case DynamicVar.VarType of
                vInteger: DynamicVar.nInternet := IniFile.ReadInteger(sName, DynamicVar.sName, 0);
                vString: DynamicVar.sString := IniFile.ReadString(sName, DynamicVar.sName, '');
              end;
              boFoundVar := True;
              Break;
            end;
          end;
        end;//for
      end;
      if not boFoundVar then
        ScriptActionError(PlayObject, Format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_LOADVAR);
    finally
      IniFile.Free;
    end;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfLoadVar');
end;
end;

//�������ֵ
//SAVEVAR �������� ������ �ļ���
procedure TNormNpc.ActionOfSaveVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sFileName: string;
  sName: string;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
  IniFile: TIniFile;
resourcestring
  sVarFound = '����%s�����ڣ���������:%s';
  sVarTypeError = '�������ʹ��󣬴�������:%s ��ǰ֧������(HUMAN��GUILD��GLOBAL)';
begin
try
  sType := QuestActionInfo.sParam1;
  sVarName := QuestActionInfo.sParam2;
  //sFileName := g_Config.sEnvirDir + m_sPath + QuestActionInfo.sParam3;
  sFileName := QuestActionInfo.sParam3;
  if sFileName[1] = '\' then sFileName := Copy(sFileName, 2, Length(sFileName) - 1); //20080430 ����,�����ļ�·��
  if sFileName[2] = '\' then sFileName := Copy(sFileName, 3, Length(sFileName) - 2);
  if sFileName[3] = '\' then sFileName := Copy(sFileName, 4, Length(sFileName) - 3);
  sFileName:= g_Config.sEnvirDir + sFileName;
  
  if (sType = '') or (sVarName = '') or not FileExists(sFileName) then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_SAVEVAR);
    Exit;
  end;
  boFoundVar := False;
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptActionError(PlayObject, Format(sVarTypeError, [sType]), QuestActionInfo, sSC_VAR);
    Exit;
  end else begin
    IniFile := TIniFile.Create(sFileName);
    if DynamicVarList.Count > 0 then begin//20080629
      for I := 0 to DynamicVarList.Count - 1 do begin
        DynamicVar := DynamicVarList.Items[I];
        if DynamicVar <> nil then begin
          if CompareText(DynamicVar.sName, sVarName) = 0 then begin
            case DynamicVar.VarType of
              vInteger: IniFile.WriteInteger(sName, DynamicVar.sName, DynamicVar.nInternet);
              vString: IniFile.WriteString(sName, DynamicVar.sName, DynamicVar.sString);
            end;
            boFoundVar := True;
            Break;
          end;
        end;
      end;//for
    end;
    if not boFoundVar then
      ScriptActionError(PlayObject, Format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_SAVEVAR);
    IniFile.Free;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfSaveVar');
end;
end;
//�Ա�����������(+��-��*��/��=)
procedure TNormNpc.ActionOfCalcVar(PlayObject: TPlayObject;
  QuestActionInfo: pTQuestActionInfo);
var
  I: Integer;
  sType: string;
  sVarName: string;
  sName: string;
  sVarValue: string;
  sVarValue2: string;
  nVarValue: Integer;
  sMethod: string;
  cMethod: Char;
  DynamicVar: pTDynamicVar;
  boFoundVar: Boolean;
  DynamicVarList: TList;
resourcestring
  sVarFound = '����%s�����ڣ���������:%s';
  sVarTypeError = '�������ʹ��󣬴�������:%s ��ǰ֧������(HUMAN��GUILD��GLOBAL)';
begin
try
  sType := QuestActionInfo.sParam1;//����
  sVarName := QuestActionInfo.sParam2;//�Զ������
  sMethod := QuestActionInfo.sParam3;//������ +-*/=
  sVarValue := QuestActionInfo.sParam4;//����
  //sVarValue2 := QuestActionInfo.sParam5;

  if (sType = '') or (sVarName = '') or (sMethod = '') then begin
    ScriptActionError(PlayObject, '', QuestActionInfo, sSC_CALCVAR);
    Exit;
  end;
  boFoundVar := False;
  if (sVarValue <> '') {and (sVarValue2 <> '')} and (not IsStringNumber(sVarValue)){ and (not IsStringNumber(sVarValue2))} then begin
    if CompareLStr(sVarValue, '<$HUMAN(', 8{Length('<$HUMAN(')}) then begin //20080314 ����
      ArrestStringEx(sVarValue, '(', ')', sVarValue2);
      sVarValue := sVarValue2;
   { DynamicVarList := GetDynamicVarList(PlayObject, sVarValue, sName);
    if DynamicVarList = nil then begin
      ScriptActionError(PlayObject, Format(sVarTypeError, [sVarValue]), QuestActionInfo, sSC_CALCVAR);
      Exit;
    end;   }
    if  PlayObject.m_DynamicVarList.Count > 0 then begin//20080629
      for I := 0 to PlayObject.m_DynamicVarList.Count{DynamicVarList.Count} - 1 do begin
        DynamicVar := PlayObject.m_DynamicVarList.Items[I]{DynamicVarList.Items[I]};
        if CompareText(DynamicVar.sName, sVarValue{2}) = 0 then begin
          case DynamicVar.VarType of
            vInteger: nVarValue := DynamicVar.nInternet;
            vString:  sVarValue := DynamicVar.sString;
          end;
          boFoundVar := True;
          Break;
        end;
      end;//for
    end;
    if not boFoundVar then begin
      ScriptActionError(PlayObject, Format(sVarFound, [sVarValue{2}, sType{sVarValue}]), QuestActionInfo, sSC_CALCVAR);
      Exit;
    end;
   end else begin
     nVarValue:=Str_ToInt(GetLineVariableText(PlayObject,sVarValue),0);//20080314 ����
     sVarValue:=GetLineVariableText(PlayObject,sVarValue);//20080430
   end;
  end else nVarValue := Str_ToInt(QuestActionInfo.sParam4, 0);

  boFoundVar := False;
  cMethod := sMethod[1];
  DynamicVarList := GetDynamicVarList(PlayObject, sType, sName);
  if DynamicVarList = nil then begin
    ScriptActionError(PlayObject, Format(sVarTypeError, [sType]), QuestActionInfo, sSC_CALCVAR);
    Exit;
  end else begin
    if DynamicVarList.Count > 0 then begin//20080629
      for I := 0 to DynamicVarList.Count - 1 do begin
        DynamicVar := DynamicVarList.Items[I];
        if DynamicVar <> nil then begin
          if CompareText(DynamicVar.sName, sVarName) = 0 then begin
            case DynamicVar.VarType of
              vInteger: begin
                  case cMethod of
                    '=': DynamicVar.nInternet := nVarValue;
                    '+': DynamicVar.nInternet := DynamicVar.nInternet + nVarValue;
                    '-': DynamicVar.nInternet := DynamicVar.nInternet - nVarValue;
                    '*': DynamicVar.nInternet := DynamicVar.nInternet * nVarValue;
                    '/': DynamicVar.nInternet := DynamicVar.nInternet div nVarValue;
                  end;
                end;
              vString: begin
                  case cMethod of
                    '=': DynamicVar.sString := sVarValue;
                    '+': DynamicVar.sString := DynamicVar.sString + sVarValue;
                    '-':;
                  end;
                end;
            end;
            boFoundVar := True;
            Break;
          end;
        end;
      end;//for
    end;
    if not boFoundVar then
      ScriptActionError(PlayObject, Format(sVarFound, [sVarName, sType]), QuestActionInfo, sSC_CALCVAR);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ActionOfCalcVar');
end;
end;

procedure TNormNpc.Initialize;
begin
  inherited;
  m_Castle := g_CastleManager.InCastleWarArea(Self);
end;

function TNormNpc.ConditionOfCheckNameDateList(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sListFileName, sLineText, sHumName, sDate: string;
  boDeleteExprie, boNoCompareHumanName: Boolean;
  dOldDate: TDateTime;
  cMethod: Char;
  nValNo, nValNoDay, nDayCount, nDay: Integer;
begin
try
  Result := False;
  nDayCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nValNo := GetValNameNo(QuestConditionInfo.sParam4);
  nValNoDay := GetValNameNo(QuestConditionInfo.sParam5);
  boDeleteExprie := CompareText(QuestConditionInfo.sParam6, '����') = 0;
  boNoCompareHumanName := CompareText(QuestConditionInfo.sParam6, '1') = 0;
  cMethod := QuestConditionInfo.sParam2[1];
  if nDayCount < 0 then begin
    ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKNAMEDATELIST);
    Exit;
  end;
  sListFileName := g_Config.sEnvirDir + m_sPath + QuestConditionInfo.sParam1;
  if FileExists(sListFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sListFileName);
    except
      MainOutMessage('����ʧ��.... => ' + sListFileName);
    end;
    if  LoadList.Count > 0 then begin//20080629
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := Trim(LoadList.Strings[I]);
        sLineText := GetValidStr3(sLineText, sHumName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sDate, [' ', #9]);
        if (CompareText(sHumName, PlayObject.m_sCharName) = 0) or boNoCompareHumanName then begin
          nDay := High(Integer);
          if TryStrToDateTime(sDate, dOldDate) then
            nDay := GetDayCount(Now, dOldDate);
          case cMethod of
            '=': if nDay = nDayCount then Result := True;
            '>': if nDay > nDayCount then Result := True;
            '<': if nDay < nDayCount then Result := True;
          else if nDay >= nDayCount then Result := True;
          end;
          if nValNo >= 0 then begin
            case nValNo of
              0..99: begin
                  PlayObject.m_nVal[nValNo] := nDay;
                end;
              100..199: begin
                  g_Config.GlobalVal[nValNo - 100] := nDay;
                end;
              200..299: begin
                  PlayObject.m_DyVal[nValNo - 200] := nDay;
                end;
              300..399: begin
                  PlayObject.m_nMval[nValNo - 300] := nDay;
                end;
              400..499: begin
                  g_Config.GlobaDyMval[nValNo - 400] := nDay;
                end;
              500..599: begin
                  PlayObject.m_nInteger[nValNo - 500] := nDay;
                end;
              800..1199:begin//20080903 G����
                  g_Config.GlobalVal[nValNo - 700] := nDay;
                end;
            end;
          end;

          if nValNoDay >= 0 then begin
            case nValNoDay of
              0..99: begin
                  PlayObject.m_nVal[nValNoDay] := nDayCount - nDay;
                end;
              100..199: begin
                  g_Config.GlobalVal[nValNoDay - 100] := nDayCount - nDay;
                end;
              200..299: begin
                  PlayObject.m_DyVal[nValNoDay - 200] := nDayCount - nDay;
                end;
              300..399: begin
                  PlayObject.m_nMval[nValNoDay - 300] := nDayCount - nDay;
                end;
              400..499: begin
                  g_Config.GlobaDyMval[nValNo - 400] := nDayCount - nDay;
                end;
              500..599: begin
                  PlayObject.m_nInteger[nValNo - 500] := nDayCount - nDay;
                end;
              800..1199:begin//20080903 G����
                  g_Config.GlobalVal[nValNoDay - 700] := nDayCount - nDay;
                end;
            end;
          end;
          if not Result then begin
            if boDeleteExprie then begin
              LoadList.Delete(I);
              try
                LoadList.SaveToFile(sListFileName);
              except
                MainOutMessage('����ʧ��.... => ' + sListFileName);
              end;
            end;
          end;
          Break;
        end;
      end;//for
    end;
    LoadList.Free;
  end else begin
    MainOutMessage('�ļ�û���ҵ� => ' + sListFileName);
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckNameDateList');
end;
end;

function TNormNpc.ConditionOfCheckMapHumanCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount, nHumanCount: Integer;
  cMethod: Char;
  sMapName: string;
begin
try
  Result := False;
  //nCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
  nCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam3),-1);//20080501
  if nCount < 0 then begin
    if not GetValValue(PlayObject, QuestConditionInfo.sParam3, nCount) then begin //���ӱ���֧��
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAPHUMANCOUNT);
      Exit;
    end;
  end;
  if not GetValValue(PlayObject, QuestConditionInfo.sParam1, sMapName) then begin //���ӱ���֧��
    sMapName := QuestConditionInfo.sParam1;
  end;
  nHumanCount := UserEngine.GetMapHuman(sMapName);
  cMethod := QuestConditionInfo.sParam2[1];
  case cMethod of
    '=': if nHumanCount = nCount then Result := True;
    '>': if nHumanCount > nCount then Result := True;
    '<': if nHumanCount < nCount then Result := True;
  else if nHumanCount >= nCount then Result := True;
  end;
except
  MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMapHumanCount');
end;
end;

function TNormNpc.ConditionOfCheckMapMonCount(PlayObject: TPlayObject;
  QuestConditionInfo: pTQuestConditionInfo): Boolean;
var
  nCount, nMonCount, I: Integer;
  cMethod: Char;
  Envir: TEnvirnoment;
  sMap:string;
  MonList: TList;
  BaseObject: TBaseObject;
begin
  try
    Result := False;
    //nCount := Str_ToInt(QuestConditionInfo.sParam3, -1);
    nCount := Str_ToInt(GetLineVariableText(PlayObject,QuestConditionInfo.sParam3),-1);//20080501

    if CompareText(QuestConditionInfo.sParam1, 'Self') = 0 then begin//20081222
      sMap:=  PlayObject.m_sMapName;
    end else begin
      sMap:= QuestConditionInfo.sParam1;
      if (sMap <> '') and (sMap[1] = '<') and (sMap[2] = '$') then//����֧��<$Str()> 20081221
         sMap := GetLineVariableText(PlayObject, QuestConditionInfo.sParam1)
      else GetValValue(PlayObject, QuestConditionInfo.sParam1, sMap);
    end;
    Envir := g_MapManager.FindMap(sMap);
    
    //Envir := g_MapManager.FindMap(QuestConditionInfo.sParam1);
    if nCount < 0 then GetValValue(PlayObject, QuestConditionInfo.sParam3, nCount);
    if (nCount < 0) or (Envir = nil) then begin
      ScriptConditionError(PlayObject, QuestConditionInfo, sSC_CHECKMAPMONCOUNT);
      Exit;
    end;
    MonList := TList.Create;
    try
      UserEngine.GetMapMonster(Envir, MonList);
      for I := MonList.Count - 1 downto 0 do begin//20090113 ����
        if MonList.Count <= 0 then Break;
        BaseObject := TBaseObject(MonList.Items[I]);
        if (BaseObject.m_btRaceServer < RC_ANIMAL) or (BaseObject.m_btRaceServer = RC_ARCHERGUARD) or (BaseObject.m_Master <> nil) or (BaseObject.m_btRaceServer = RC_NPC) or (BaseObject.m_btRaceServer = RC_PEACENPC) then
          MonList.Delete(I);
      end;
      nMonCount := MonList.Count;
      cMethod := QuestConditionInfo.sParam2[1];
      case cMethod of
        '=': if nMonCount = nCount then Result := True;
        '>': if nMonCount > nCount then Result := True;
        '<': if nMonCount < nCount then Result := True;
      else if nMonCount >= nCount then Result := True;
      end;
    finally
      MonList.Free;
    end;
  except
    MainOutMessage('{�쳣} TNormNpc.ConditionOfCheckMapMonCount');
  end;
end;

function TNormNpc.GetDynamicVarList(PlayObject: TPlayObject;
  sType: string; var sName: string): TList;
begin
try
  Result := nil;
  if CompareLStr(sType, 'HUMAN', 5{Length('HUMAN')}) then begin
    Result := PlayObject.m_DynamicVarList;
    sName := PlayObject.m_sCharName;
  end else
    if CompareLStr(sType, 'GUILD', 5{Length('GUILD')}) then begin
    if PlayObject.m_MyGuild = nil then Exit;
    Result := TGUild(PlayObject.m_MyGuild).m_DynamicVarList;
    sName := TGUild(PlayObject.m_MyGuild).sGuildName;
  end else
    if CompareLStr(sType, 'GLOBAL', 6{Length('GLOBAL')}) then begin
    Result := g_DynamicVarList;
    sName := 'GLOBAL';
  end;
except
  MainOutMessage('{�쳣} TNormNpc.GetDynamicVarList');
end;
end;

{ TGuildOfficial }

procedure TGuildOfficial.Click(PlayObject: TPlayObject);
begin
  inherited;
end;

procedure TGuildOfficial.GetVariableText(PlayObject: TPlayObject;
  var sMsg: string; sVariable: string);
var
  I, II: Integer;
  sText: string;
  List: TStringList;
  sStr: string;
begin
  inherited;
try
  if sVariable = '$REQUESTCASTLELIST' then begin
    sText := '';
    List := TStringList.Create;
    g_CastleManager.GetCastleNameList(List);
    if List.Count > 0 then begin//20080629
      for I := 0 to List.Count - 1 do begin
        II := I + 1;
        if ((II div 2) * 2 = II) then sStr := '\'
        else sStr := '';
        sText := sText + Format('<%s/@requestcastlewarnow%d> %s', [List.Strings[I], I, sStr]);
      end;
    end;
    sText := sText + '\ \';
    List.Free;
    sMsg := sub_49ADB8(sMsg, '<$REQUESTCASTLELIST>', sText);
  end;
except
  MainOutMessage('{�쳣} TGuildOfficial.GetVariableText');
end;
end;

procedure TGuildOfficial.Run;
begin
  if Random(40) = 0 then begin
    TurnTo(Random(8));
  end else begin
    if Random(30) = 0 then
      SendRefMsg(RM_HIT, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
  end;
  inherited;
end;

procedure TGuildOfficial.UserSelect(PlayObject: TPlayObject; sData: string);
var
  sMsg, sLabel: string;
  boCanJmp: Boolean;
  nCode: Byte;
resourcestring
  sExceptionMsg = '{�쳣} TGuildOfficial:UserSelect Code:';
begin
  inherited;
  nCode:= 0;
  try
    //    PlayObject.m_nScriptGotoCount:=0;
    if (sData <> '') and (sData[1] = '@') then begin
      nCode:= 1;
      sMsg := GetValidStr3(sData, sLabel, [#13]);
      nCode:= 2;
      boCanJmp := PlayObject.LableIsCanJmp(sLabel);
      nCode:= 3;
      GotoLable(PlayObject, sLabel, not boCanJmp);

      //GotoLable(PlayObject,sLabel,not PlayObject.LableIsCanJmp(sLabel));
      if not boCanJmp then Exit;
      if CompareText(sLabel, sBUILDGUILDNOW) = 0 then begin
        nCode:= 4;
        ReQuestBuildGuild(PlayObject, sMsg);
      end else
        if CompareText(sLabel, sSCL_GUILDWAR) = 0 then begin
        nCode:= 5;
        ReQuestGuildWar(PlayObject, sMsg);
      end else
        if CompareText(sLabel, sDONATE) = 0 then begin
        nCode:= 6;
        DoNate(PlayObject);
      end else
        {if CompareText(sLabel,sREQUESTCASTLEWAR) = 0 then begin
          ReQuestCastleWar(PlayObject,sMsg);
        end else }
        if CompareLStr(sLabel, sREQUESTCASTLEWAR, 20{Length(sREQUESTCASTLEWAR)}) then begin
        nCode:= 7;
        ReQuestCastleWar(PlayObject, Copy(sLabel, 21{Length(sREQUESTCASTLEWAR) + 1}, Length(sLabel) - 20{Length(sREQUESTCASTLEWAR)}));
      end else
        if CompareText(sLabel, sEXIT) = 0 then begin
        nCode:= 8;
        PlayObject.SendMsg(Self, RM_MERCHANTDLGCLOSE, 0, Integer(Self), 0, 0, '');
      end else
        if CompareText(sLabel, sBACK) = 0 then begin
        nCode:= 9;
        if PlayObject.m_sScriptGoBackLable = '' then PlayObject.m_sScriptGoBackLable := sMAIN;
        GotoLable(PlayObject, PlayObject.m_sScriptGoBackLable, False);
      end;
    end;
  except
    MainOutMessage(sExceptionMsg+ sLabel + inttostr(nCode));
  end;
  //  inherited;
end;

function TGuildOfficial.ReQuestBuildGuild(PlayObject: TPlayObject; sGuildName: string): Integer;
var
  UserItem: pTUserItem;
begin
try
  Result := 0;
  sGuildName := Trim(sGuildName);
  UserItem := nil;
  if sGuildName = '' then begin
    Result := -4;
  end;
  if PlayObject.m_MyGuild = nil then begin
    if PlayObject.m_nGold >= g_Config.nBuildGuildPrice then begin
      UserItem := PlayObject.CheckItems(g_Config.sWomaHorn);
      if UserItem = nil then begin
        Result := -3; //'��û��׼������Ҫ��ȫ����Ʒ��'
      end;
    end else Result := -2; //'ȱ�ٴ������á�'
  end else Result := -1; //'���Ѿ����������лᡣ'
  if Result = 0 then begin
    if g_GuildManager.AddGuild(sGuildName, PlayObject.m_sCharName) then begin
      UserEngine.SendServerGroupMsg(SS_205, nServerIndex, sGuildName + '/' + PlayObject.m_sCharName);
      PlayObject.SendDelItems(UserItem);
      PlayObject.DelBagItem(UserItem.MakeIndex, g_Config.sWomaHorn);
      PlayObject.DecGold(g_Config.nBuildGuildPrice);
      PlayObject.GoldChanged();
      PlayObject.m_MyGuild := g_GuildManager.MemberOfGuild(PlayObject.m_sCharName);
      if PlayObject.m_MyGuild <> nil then begin
        PlayObject.m_sGuildRankName := TGUild(PlayObject.m_MyGuild).GetRankName(PlayObject, PlayObject.m_nGuildRankNo);
        RefShowName();
      end;
    end else Result := -4;
  end;
  if Result >= 0 then begin
    PlayObject.SendMsg(Self, RM_BUILDGUILD_OK, 0, 0, 0, 0, '');
  end else begin
    PlayObject.SendMsg(Self, RM_BUILDGUILD_FAIL, 0, Result, 0, 0, '');
  end;
except
  MainOutMessage('{�쳣} TGuildOfficial.ReQuestBuildGuild');
end;
end;
//���뿪���л�ս
function TGuildOfficial.ReQuestGuildWar(PlayObject: TPlayObject; sGuildName: string): Integer;
begin
try
  if g_GuildManager.FindGuild(sGuildName) <> nil then begin
    if PlayObject.m_nGold >= g_Config.nGuildWarPrice then begin
      PlayObject.DecGold(g_Config.nGuildWarPrice);
      PlayObject.GoldChanged();
      PlayObject.ReQuestGuildWar(sGuildName);
    end else begin
      PlayObject.SysMsg('��û���㹻�Ľ�ң�����', c_Red, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('�л� ' + sGuildName + ' �����ڣ�����', c_Red, t_Hint);
  end;
  Result := 1;
except
  MainOutMessage('{�쳣} TGuildOfficial.ReQuestGuildWar');
end;
end;

procedure TGuildOfficial.DoNate(PlayObject: TPlayObject);
begin
  PlayObject.SendMsg(Self, RM_DONATE_OK, 0, 0, 0, 0, '');
end;

procedure TGuildOfficial.ReQuestCastleWar(PlayObject: TPlayObject; sIndex: string);
var
  UserItem: pTUserItem;
  Castle: TUserCastle;
  nIndex: Integer;
begin
try
  //  if PlayObject.IsGuildMaster and
  //     (not UserCastle.IsMasterGuild(TGuild(PlayObject.m_MyGuild))) then begin
  nIndex := Str_ToInt(sIndex, -1);
  if nIndex < 0 then nIndex := 0;

  Castle := g_CastleManager.GetCastle(nIndex);
  if PlayObject.IsGuildMaster and
    not Castle.IsMember(PlayObject) then begin

    UserItem := PlayObject.CheckItems(g_Config.sZumaPiece);
    if UserItem <> nil then begin
      if Castle.AddAttackerInfo(TGUild(PlayObject.m_MyGuild),0) then begin
        PlayObject.SendDelItems(UserItem);
        PlayObject.DelBagItem(UserItem.MakeIndex, g_Config.sZumaPiece);
        GotoLable(PlayObject, '~@request_ok', False);
      end else begin
        PlayObject.SysMsg('�������޷����󹥳ǣ�����', c_Red, t_Hint);
      end;
    end else begin
      PlayObject.SysMsg('��û��' + g_Config.sZumaPiece + '������', c_Red, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('��������ȡ��������', c_Red, t_Hint);
  end;
except
  MainOutMessage('{�쳣} TGuildOfficial.ReQuestCastleWar');
end;
end;

procedure TCastleOfficial.RepairDoor(PlayObject: TPlayObject);
begin
try
  if m_Castle = nil then begin
    PlayObject.SysMsg('NPC�����ڳǱ�������', c_Red, t_Hint);
    Exit;
  end;
  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nRepairDoorPrice then begin
    if TUserCastle(m_Castle).RepairDoor then begin
      Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nRepairDoorPrice);
      PlayObject.SysMsg('����ɹ���', c_Green, t_Hint);
    end else begin
      PlayObject.SysMsg('���Ų���Ҫ��������', c_Green, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('�����ʽ��㣡����', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nRepairDoorPrice then begin
    if UserCastle.RepairDoor then begin
      Dec(UserCastle.m_nTotalGold,g_Config.nRepairDoorPrice);
      PlayObject.SysMsg('����ɹ���',c_Green,t_Hint);
    end else begin
      PlayObject.SysMsg('���Ų���Ҫ��������',c_Green,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('�����ʽ��㣡����',c_Red,t_Hint);
  end;
  }
except
  MainOutMessage('{�쳣} TGuildOfficial.RepairDoor');
end;
end;

procedure TCastleOfficial.RepairWallNow(nWallIndex: Integer;
  PlayObject: TPlayObject);
begin
try
  if m_Castle = nil then begin
    PlayObject.SysMsg('NPC�����ڳǱ�������', c_Red, t_Hint);
    Exit;
  end;

  if TUserCastle(m_Castle).m_nTotalGold >= g_Config.nRepairWallPrice then begin
    if TUserCastle(m_Castle).RepairWall(nWallIndex) then begin
      Dec(TUserCastle(m_Castle).m_nTotalGold, g_Config.nRepairWallPrice);
      PlayObject.SysMsg('����ɹ���', c_Green, t_Hint);
    end else begin
      PlayObject.SysMsg('���Ų���Ҫ��������', c_Green, t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('�����ʽ��㣡����', c_Red, t_Hint);
  end;
  {
  if UserCastle.m_nTotalGold >= g_Config.nRepairWallPrice then begin
    if UserCastle.RepairWall(nWallIndex) then begin
      Dec(UserCastle.m_nTotalGold,g_Config.nRepairWallPrice);
      PlayObject.SysMsg('����ɹ���',c_Green,t_Hint);
    end else begin
      PlayObject.SysMsg('���Ų���Ҫ��������',c_Green,t_Hint);
    end;
  end else begin
    PlayObject.SysMsg('�����ʽ��㣡����',c_Red,t_Hint);
  end;
  }
except
  MainOutMessage('{�쳣} TGuildOfficial.RepairWallNow');
end;
end;

constructor TCastleOfficial.Create;
begin
  inherited;
end;

destructor TCastleOfficial.Destroy;
begin
  inherited;
end;

constructor TGuildOfficial.Create;
begin
  inherited;
  m_btRaceImg := RCC_MERCHANT;
  m_wAppr := 8;
end;

destructor TGuildOfficial.Destroy;
begin
  inherited;
end;

procedure TGuildOfficial.SendCustemMsg(PlayObject: TPlayObject;
  sMsg: string);
begin
  inherited;
end;
//���ͳ����Ļ�
procedure TCastleOfficial.SendCustemMsg(PlayObject: TPlayObject;
  sMsg: string);
begin
try
  if not g_Config.boSubkMasterSendMsg then begin
    PlayObject.SysMsg(g_sSubkMasterMsgCanNotUseNowMsg, c_Red, t_Hint);
    Exit;
  end;
  if PlayObject.m_boSendMsgFlag then begin
    PlayObject.m_boSendMsgFlag := False;
    UserEngine.SendBroadCastMsg(PlayObject.m_sCharName + ': ' + sMsg, t_Castle);
  end;
except
  MainOutMessage('{�쳣} TGuildOfficial.SendCustemMsg');
end;
end;

end.


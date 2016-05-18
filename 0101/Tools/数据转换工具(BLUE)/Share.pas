unit Share;

interface

uses Windows;

type
//===============================Blue、LF格式===================================
  TLF_UserItem = record //=24
    MakeIndex: Integer; //+4
    wIndex: Word; //+2
    Dura: word; //+2
    DuraMax: Word; //+2
    btValue: array[0..13] of byte; //+14
  end;

  TLF_NakedAbility = packed record
    DC: Word;
    MC: Word;
    SC: Word;
    AC: Word;
    MAC: Word;
    HP: Word;
    MP: Word;
    Hit: Word;
    Speed: Word;
    X2: Word;
  end;

  TNakedAbility = packed record //Size 20  与TLF_NakedAbility一致，所以BLUE里改用TNakedAbility
    DC: Word;
    MC: Word;
    SC: Word;
    AC: Word;
    MAC: Word;
    HP: Word;
    MP: Word;
    Hit: Word;
    Speed: Word;
    X2: Word;
  end;

  TLF_OAbility = record      //Size 40
    Level: Word; //0x198
    AC: Word; //0x19A
    MAC: Word; //0x19C
    DC: Word; //0x19E
    MC: Word; //0x1A0
    SC: Word; //0x1A2
    HP: Word; //0x1A4
    MP: Word; //0x1A6
    MaxHP: Word; //0x1A8
    MaxMP: Word; //0x1AA
    GAMEDIAMOND: Word;//金刚石
    GAMEGIRD: Word;//灵符
    Exp: LongWord; //0x1B0
    MaxExp: LongWord; //0x1B4
    Weight: Word; //0x1B8
    MaxWeight: Word; //0x1BA
    WearWeight: Byte; //0x1BC
    MaxWearWeight: Byte; //0x1BD
    HandWeight: Byte; //0x1BE
    MaxHandWeight: Byte; //0x1BF
  end;

  TLF_HumRecordHeader = packed record
    boDeleted: boolean;
    nSelectID: Byte;
    bt2: Byte;
    bt3: Byte;
    //dCreateDate     :TDateTime;
    UpdateDate: TDateTime;
    sName: string[15];
  end;
  
  TLF_SaveUserMagic = record
    wMagIdx: word;
    btLevel: byte;
    btKey: byte;
    nTranPoint: integer;
  end;

  TLF_HumMagic = array[0..19] of TLF_SaveUserMagic;

  TLF_StatusTime = array[0..11] of Word;

  TLF_QuestFlag = array[0..99] of Byte;
  TLF_QuestOpen = array[0..12] of Byte;

  TLF_HumItems = array[0..8] of TLF_UserItem;
  TLF_BagItems = array[0..45] of TLF_UserItem;
  TLF_StorageItems = array[0..45] of TLF_UserItem;

  TLF_Hum2Items = array[0..3] of TLF_UserItem;

  TLF_HumData = packed record
    sChrName: string[14]; //*
    sCurMap: string[16]; //*
    wCurX: Word; //* NO
    wCurY: Word;//* NO
    btDir: Byte;//*
    btHair: Byte;//*
    btSex: Byte;//*
    btJob: Byte;//*
    nGold: Integer;//* NO
    Abil: TLF_OAbility;//* NO
    wStatusTimeArr: TLF_StatusTime;// NO
    sHomeMap: string[17];//* NO
    wHomeX: Word;//* NO
    wHomeY: Word;//* NO
    sDearName: string[14];//* NO
    sMasterName: string[14];//* NO
    boMaster: Boolean;//*
    btCreditPoint: Byte;//*
    UnKnow: word;// NO
    sStoragePwd: string[7];//* NO
    btReLevel: Byte;//*
    boLockLogon: Boolean;//*
    UnKnow2: word;// NO
    BonusAbil: TNakedAbility;//* NO
    nBonusPoint: Integer;//* NO
    nGameGold: Integer;//* NO
    nGamePoint: Integer;//* NO
    nPayMentPoint: Integer;//* NO
    UnKnow4: Integer;//  NO
    nPKPoint: Integer;//* NO
    btAllowGroup: Byte;//*
    btF9: Byte;//*
    btAttatckMode: Byte;//*
    btIncHealth: Byte;//*
    btIncSpell: Byte;//*
    btIncHealing: Byte;//*
    btFightZoneDieCount: Byte;//*
    sAccount: string[10];//* NO
    btEE: word;//*  NO
    wContribution: Word;//* NO
    nHungerStatus: Integer;//* NO
    boAllowGuildReCall: Boolean;//*
    UnKnow6: byte;
    wGroupRcallTime: Word;//* NO
    dBodyLuck: TDateTime;//*
    boAllowGroupReCall: Boolean;//*
    nTwoExp: integer;//经验倍数 * NO
    nTwoExpTime: integer;//经验倍数时间 * NO
    sHeroName: string[14];//英雄名 //* NO
    sMasterHeroName: string[14];//英雄的主人名 //* NO
    UnKnow7: array[0..10] of byte;
    sDieMap: string[16];//死亡地图  NO
    wDieX: Word;//死亡X坐标  NO
    wDieY: Word;//死亡Y坐标  NO
    UnKnow8: byte;
    QuestOpen: TLF_QuestOpen;
    QuestUnit: TLF_QuestOpen;
    QuestFlag: TLF_QuestFlag;//脚本变量 *
    HumItems: TLF_HumItems;//*
    BagItems: TLF_BagItems;//*
    Magic: TLF_HumMagic;//*
    StorageItems: TLF_StorageItems;//*
    HumItems2: TLF_Hum2Items;//*
  end;

  TLF_HumDataInfo = packed record
    Header: TLF_HumRecordHeader;
    Data: TLF_HumData;
  end;

  TLF_DBHum = packed record //Size 72  角色数据   //清清自己加的
    Header: TLF_HumRecordHeader;
    sChrName: string[14]; //0x14  //角色名称   44
    sAccount: string[10]; //账号
    boDeleted: Boolean; //是否删除
    bt1: Byte; //未使用
    dModDate: TDateTime;//操作日期
    btCount: Byte; //操作计次
    boSelected: Boolean; //是否是选择的人物
    n6: array[0..5] of Byte;//未使用
  end;

  TDBHeader = record
    sDesc       :String[$23]; //0x00
    n24         :Integer;    //0x24
    n28         :Integer;    //0x28
    n2C         :Integer;    //0x2C
    n30         :Integer;    //0x30
    n34         :Integer;    //0x34
    n38         :Integer;    //0x38
    n3C         :Integer;    //0x3C
    n40         :Integer;    //0x40
    n44         :Integer;    //0x44
    n48         :Integer;    //0x48
    n4C         :Integer;    //0x4C
    n50         :Integer;    //0x50
    n54         :Integer;    //0x54
    n58         :Integer;    //0x58
    nLastIndex  :Integer;    //0x5C
    dLastDate   :TDateTime;  //0x60
    nHumCount   :Integer;    //0x68
    n6C         :Integer;    //0x6C
    n70         :Integer;    //0x70
    dUpdateDate :TDateTime;  //0x74
  end;

  TDBHeader1 = packed record //Size 124
    sDesc: string[$23]; //0x00    36
    n24: Integer; //0x24
    n28: Integer; //0x28
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C
    dLastDate: TDateTime; //最后退登日期
    nHumCount: Integer; //0x68
    n6C: Integer; //0x6C
    n70: Integer; //0x70
    dUpdateDate: TDateTime; //更新日期
  end;
//=============================自己的数据库格式=================================
  TUserItem = record // 20080313 修改
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: array[0..20] of Byte;//附加属性  12-发光  13-自定义名称
  end;
  THumMagicInfo = record
    wMagIdx: Word;
    btLevel: Byte;
    btKey: Byte;
    nTranPoint: Integer; //当前持久值
  end;

  TStatusTime = array[0..11] of Word;
  TUnKnow = array[0..29] of Byte;
  TQuestFlag = array[0..127] of Byte;
  THumItems=Array[0..8] of TUserItem;
  TBagItems=Array[0..45] of TUserItem;
  THumMagic= Array[0..29] of THumMagicInfo;
  THumNGMagics = array[0..29] of THumMagicInfo;//内功技能 20081001
  TStorageItems=Array[0..45] of TUserItem; //20071115
  THumAddItems=Array[9..13] of TUserItem;//支持斗笠 20080416

  TOAbility = packed record
    Level: Word;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    HP: Word;
    MP: Word;
    MaxHP: Word;
    MaxMP: Word;
    {btReserved1: Byte;//20081001 注释
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;}
    NG: Word;//20081001 当前内力值
    MaxNG: Word;//20081001 内力值上限    
    Exp: LongWord;
    MaxExp: LongWord;
    Weight: Word;
    MaxWeight: Word; //背包
    WearWeight: Byte;
    MaxWearWeight: Byte; //负重
    HandWeight: Byte;
    MaxHandWeight: Byte; //腕力
  end;

  pTHumData = ^THumData;
  THumData = packed record //IGE的数据结构
    sChrName: string[14];
    sCurMap: string[16];
    wCurX: Word;
    wCurY: Word;
    btDir: Byte;
    btHair: Byte;
    btSex: Byte;
    btJob: Byte;
    nGold: Integer;
    Abil: TOAbility; //+40
    wStatusTimeArr: TStatusTime; //+24
    sHomeMap: string[16];
    //btUnKnow1: Byte;不使用,去掉
    wHomeX: Word;
    wHomeY: Word;
    sDearName: string[14];
    sMasterName: string[14];//师傅名字
    boMaster: Boolean;
    btCreditPoint: Integer;//声望点 20080118
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];
    btReLevel: Byte;
    btUnKnow2: array[0..2] of Byte;
    BonusAbil: TNakedAbility; //+20
    nBonusPoint: Integer;
    nGameGold: Integer;//游戏币
    nGameDiaMond: Integer;//金刚石 20071226
    nGameGird:Integer;//灵符 20071226
    nGamePoint: Integer;
    btGameGlory: Byte; //荣誉 20080511
    nPayMentPoint: Integer; //充值点
    nLoyal: Integer;//英雄的忠诚度(20080109)
    nPKPOINT: Integer;
    btAllowGroup: Byte;
    btF9: Byte;
    btAttatckMode: Byte;
    btIncHealth: Byte;
    btIncSpell: Byte;
    btIncHealing: Byte;
    btFightZoneDieCount: Byte;
    sAccount: string[10];
    //btEE: Byte;//不使用,去掉
    btEF: Byte;
    boLockLogon: Boolean;
    wContribution: Word;
    nHungerStatus: Integer;
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //2006-01-12增加 退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[14];
    UnKnow: TUnKnow;
    QuestFlag: TQuestFlag; //脚本变量
    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagic; //魔法
    StorageItems: TStorageItems; //仓库物品
    HumAddItems: THumAddItems; //新增4格 护身符 腰带 鞋子 宝石
    n_WinExp:longWord;//累计经验 20081001
    n_UsesItemTick: Integer;//聚灵珠聚集时间 20080221

    nReserved: Integer; //酿酒的时间,即还有多长时间可以取回酒 20080620
    nReserved1: Integer; //当前药力值 20080623
    nReserved2: Integer; //药力值上限 20080623
    nReserved3: Integer; //使用药酒时间,计算长时间没使用药酒 20080623
    n_Reserved: Word;   //当前酒量值 20080622
    n_Reserved1: Word;  //酒量上限 20080622
    n_Reserved2: Word;  //当前醉酒度 20080623
    n_Reserved3: Word;  //药力值等级 20080623
    boReserved: Boolean; //是否请过酒 T-请过酒
    boReserved1: Boolean;//是否有卧龙英雄 20080519
    boReserved2: Boolean;//是否酿酒 T-正在酿酒 20080620
    boReserved3: Boolean;//人是否喝酒醉了 20080627
    m_GiveDate:Integer;//人物领取行会酒泉日期 20080625
    Exp68: LongWord;//酒气护体当前经验 20080625
    MaxExp68: LongWord;//酒气护体升级经验 20080625
    nExpSkill69: Integer;//内功当前经验 20080930
    HumNGMagics: THumNGMagics;//内功技能 20081001
    m_nReserved1: Word;//保留
    m_nReserved2: Word;//保留
    m_nReserved3: Word;//保留
    m_nReserved4: LongWord;//保留
    m_nReserved5: LongWord;//保留
    m_nReserved6: Integer;//保留
    m_nReserved7: Integer;//保留
  end;




  TRecordHeader = packed record //Size 12
    boDeleted: Boolean; //是否删除
    nSelectID: Byte;   //ID
    boIsHero: Boolean; //是否英雄
    bt2: Byte;
    dCreateDate: TDateTime; //创建时间
    sName: string[15]; //0x15  //角色名称   28
  end;
  pTRecordHeader = ^TRecordHeader;

  TDBHum = packed record //Size 72  角色数据
    Header: TRecordHeader;
    sChrName: string[14]; //0x14  //角色名称   44
    sAccount: string[10]; //账号
    boDeleted: Boolean; //是否删除
    bt1: Byte; //未使用
    dModDate: TDateTime;//操作日期
    btCount: Byte; //操作计次
    boSelected: Boolean; //是否是选择的人物
    n6: array[0..5] of Byte;//未使用
  end;

  THumDataInfo = packed record //Size 3176
    Header: TRecordHeader;
    Data: THumData;
  end;
  pTHumDataInfo = ^THumDataInfo;
//==============================================================================
const
  DBFileDesc = '清客网络数据库文件 2008/10/06';
  sDBIdxHeaderDesc = '清客网络数据库索引文件 2008/10/06';
  g_sProductName = 'BF329B13CBE9010C52BD18E767E1337B1FE06EDB0131F7270D7F5D73905DAA27532F03D7A864C911'; //版权所有 (C) 2008-2010 IGE科技
  g_sURL1 = '9BECFDD8143865D36ED84E1462AA3F04DB7F1D649F9A10D276741565D9B98BDA'; //Http://Www.IGEM2.Com
  g_sURL2 = 'DE71C38C94563C0F6ED84E1462AA3F04DB7F1D649F9A10D27F779F085CC2961B'; //Http://Www.IGEM2.Com.Cn

var
  boDataDBReady: Boolean;
  HumDB_CS: TRTLCriticalSection;
implementation

initialization
  begin
    InitializeCriticalSection(HumDB_CS);
  end;

finalization
  begin
    DeleteCriticalSection(HumDB_CS);
  end;     
end.

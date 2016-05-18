unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
const
  ACTORNAMELEN = 14;
  MAPNAMELEN = 16;
  MAX_STATUS_ATTRIBUTE = 12;//20080626 修改
type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TOAbility = packed record
    Level: Word; //等级
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
    Exp: LongWord;//当前经验
    MaxExp: LongWord;//升级经验
    Weight: Word;
    MaxWeight: Word; //最大重量
    WearWeight: Byte;
    MaxWearWeight: Byte; //最大负重
    HandWeight: Byte;
    MaxHandWeight: Byte; //腕力
  end;
  pTOAbility = ^TOAbility;

  TNakedAbility = packed record //Size 20
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
  pTNakedAbility = ^TNakedAbility;
  TUserItem = record // 20080313 修改
    MakeIndex: Integer;
    wIndex: Word; //物品id
    Dura: Word; //当前持久值
    DuraMax: Word; //最大持久值
    btValue: array[0..20] of Byte;//附加属性:9-(升级次数)装备等级 12-发光(1为发光,0不发光,2聚灵珠不能聚集),13-自定义名称,14-禁止扔,15-禁止交易,16-禁止存,17-禁止修,18-禁止出售,19-禁止爆出 20-吸伤(聚灵珠,1-开始聚经验,2-聚结束)
  end ;                           //11-未使用 8-神秘物品 10-武器升级设置(1-破碎 10-12增加DC, 20-22增加MC，30-32增加SC)
  pTUserItem = ^TUserItem;
  THumMagic = record //人物技能  20080106
    wMagIdx: Word;//技能ID
    btLevel: Byte;//等级
    btKey: Byte;//技能快捷键
    nTranPoint: Integer; //当前修练值
  end;
  pTHumMagic = ^THumMagic;

  TStatusTime = array[0..MAX_STATUS_ATTRIBUTE - 1] of Word;
  TQuestFlag = array[0..127] of Byte;
  TBagItems = array[0..45] of TUserItem;//包裹物品
  TStorageItems = array[0..45] of TUserItem;

  TUnKnow = array[0..29{39}] of Byte;
  THumMagics = array[0..29{19}] of THumMagic;//人物技能
  THumNGMagics = array[0..29{19}] of THumMagic;//内功技能

  THumanUseItems = array[0..13] of TUserItem;//扩展支持斗笠 20080416
  THumItems = array[0..8] of TUserItem;//9格装备
  THumAddItems = array[9..13] of TUserItem;//新增4格装备 扩展支持斗笠 20080416

  pTHumData = ^THumData;
  THumData = packed record {人物数据类 Size = 4254 预留N个变量  4402}
    sChrName: string[ACTORNAMELEN];//姓名
    sCurMap: string[MAPNAMELEN];//地图
    wCurX: Word; //坐标X
    wCurY: Word; //坐标Y
    btDir: Byte; //方向
    btHair: Byte;//头发
    btSex: Byte; //性别
    btJob: Byte;//职业 0-战 1-法 2-道 3-刺客
    nGold: Integer;//金币数
    Abil: TOAbility;//+40 人物其它属性
    wStatusTimeArr: TStatusTime; //+24 人物状态属性值，一般是持续多少秒
    sHomeMap: string[MAPNAMELEN];//Home 家
    //btUnKnow1: Byte;//未使用 去掉
    wHomeX: Word;//Home X
    wHomeY: Word;//Home Y
    sDearName: string[ACTORNAMELEN]; //别名(配偶)
    sMasterName: string[ACTORNAMELEN];//师傅名字
    boMaster: Boolean;//是否有徒弟
    btCreditPoint: Integer;//声望点 20080118
    btDivorce: Byte; //是否结婚
    btMarryCount: Byte; //结婚次数
    sStoragePwd: string[7];//仓库密码
    btReLevel: Byte;//转生等级
    btUnKnow2: array[0..2] of Byte;//0-是否开通元宝寄售(1-开通) 1-是否寄存英雄(1-存有英雄) 2-饮酒时酒的品质
    BonusAbil: TNakedAbility; //+20 奖金
    nBonusPoint: Integer;//奖励点
    nGameGold: Integer;//游戏币
    nGameDiaMond: Integer;//金刚石 20071226
    nGameGird:Integer;//灵符 20071226
    nGamePoint: Integer;//声望
    btGameGlory: Byte; //荣誉 20080511
    nPayMentPoint: Integer; //充值点
    nLoyal: Integer;//英雄的忠诚度(20080109)
    nPKPOINT: Integer;//PK点数
    btAllowGroup: Byte;//允许组队
    btF9: Byte;
    btAttatckMode: Byte;//攻击模式
    btIncHealth: Byte;//增加健康数
    btIncSpell: Byte;//增加攻击点
    btIncHealing: Byte;//增加治愈点
    btFightZoneDieCount: Byte;//在行会占争地图中死亡次数
    sAccount: string[10];//登录帐号
    //btEE: Byte;//未使用  去掉
    btEF: Byte;//英雄类型 0-白日门英雄 1-卧龙英雄 20080514
    boLockLogon: Boolean;//是否锁定登陆
    wContribution: Word;//贡献值
    nHungerStatus: Integer;//饥饿状态
    boAllowGuildReCall: Boolean; //  是否允许行会合一
    wGroupRcallTime: Word; //队传送时间
    dBodyLuck: Double; //幸运度  8
    boAllowGroupReCall: Boolean; // 是否允许天地合一
    nEXPRATE: Integer; //经验倍数
    nExpTime: Integer; //经验倍数时间
    btLastOutStatus: Byte; //退出状态 1为死亡退出
    wMasterCount: Word; //出师徒弟数
    boHasHero: Boolean; //是否有白日门英雄
    boIsHero: Boolean; //是否是英雄
    btStatus: Byte; //状态
    sHeroChrName: string[ACTORNAMELEN];//英雄名称
    UnKnow: TUnKnow;//预留 array[0..29] of Byte; 0-3酿酒使用 20080620 4-饮酒时的度数 5-魔法盾等级 6-是否学过内功 7-内功等级
    QuestFlag: TQuestFlag; //脚本变量
    HumItems: THumItems; //9格装备 衣服  武器  蜡烛 头盔 项链 手镯 手镯 戒指 戒指
    BagItems: TBagItems; //包裹装备
    HumMagics: THumMagics; //魔法
    StorageItems: TStorageItems; //仓库物品
    HumAddItems: THumAddItems; //新增4格 护身符 腰带 鞋子 宝石
    n_WinExp: longWord;//累计经验 20081001
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

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
ShowMessage(IntToStr(SizeOf(THumData)));
end;

end.

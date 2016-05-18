unit PlugShare;

interface
uses
  Windows, Classes, EngineAPI, EngineType;
type
  TCheckItem = record
    szItemName: string[14];
    boCanDrop: Boolean;
    boCanDeal: Boolean;
    boCanStorage: Boolean;
    boCanRepair: Boolean;
    boCanDropHint: Boolean;
    boCanOpenBoxsHint: Boolean;
    boCanNoDropItem: Boolean;
    boCanButchHint: Boolean;
    boCanHeroUse: Boolean; //禁止英雄使用
    boPickUpItem: Boolean;//禁止捡起(除GM外) 20080611
    boDieDropItems: Boolean;//死亡掉落 20080614
  end;
  pTCheckItem = ^TCheckItem;

  TDisallowInfo = record //物品规则列表 20080418
    boDrop: Boolean; //丢弃
    boDeal: Boolean; //交易
    boStorage: Boolean; //存仓
    boRepair: Boolean;  //修理
    boDropHint: Boolean; //掉落提示
    boOpenBoxsHint: Boolean; //宝箱提示
    boNoDropItem: Boolean; //永不爆出
    boButchHint: Boolean; //挖取提示
    boHeroUse: Boolean; //禁止英雄使用
    boPickUpItem: Boolean;//禁止捡起(除GM外) 20080611
    boDieDropItems: Boolean;//死亡掉落 20080614
  end;
  pTDisallowInfo = ^TDisallowInfo;

  TUserCommand = record
    nIndex: Integer;
    sCommandName: string[100];
  end;
  pTUserCommand = ^TUserCommand;

  TFilterMsg = record
    sFilterMsg: string[100];
    sNewMsg: string[100];
  end;
  pTFilterMsg = ^TFilterMsg;

  TSockaddr = record
    nGateIdx: Integer;
    nSocket: Integer;
    sIPaddr: string[15];
    nAttackCount: Integer;
    dwStartAttackTick: LongWord;
  end;
  pTSockaddr = ^TSockaddr;

  TSessionInfo = record
    nGateIdx: Integer;
    nSocket: Integer;
    sRemoteAddr: string;
    dwConnctCheckTick: LongWord;
    dwReceiveTick: LongWord;
    dwReceiveTimeTick: LongWord;
    nReceiveLength: Integer;
  end;
  pTSessionInfo = ^TSessionInfo;



var
  PlugHandle: Integer;
  CurrIPaddrList: Classes.TList;
  AttackIPaddrList: Classes.TList;
  g_SessionList: Classes.TList;
  nIPCountLimit: Integer = 50;
  dwAttackTick: LongWord = 200;
  nAttackCount: Integer = 10;
  nReviceMsgLength: Integer = 100; //每MS允许接受的长度，超过即认为是攻击
  dwReviceTick: LongWord = 1000;
  nAttackLevel: Integer = 1;
  nMaxConnOfIPaddr: Integer = 50;
  dwKeepConnectTimeOut: LongWord = 1000 * 60 * 3;
  boKeepConnectTimeOut: Boolean = False;
  boCCAttack: Boolean = False;
  boDataAttack: Boolean = False;
  boStartAttack: Boolean = False;

  g_CheckItemList: Classes.TList;
  g_UserCmdList: Classes.TStringList;
  g_MsgFilterList: Classes.TList;
  nStartHPRock: Integer = 90;
  nStartMPRock: Integer = 90;
  nStartHPMPRock :Integer = 90;
  nHPRockSpell: Integer = 700;
  nMPRockSpell: Integer = 700;
  nHPMPRockSpell: Integer = 700;
  nRockAddHP: Integer = 10;
  nRockAddMP: Integer = 10;
  nRockAddHPMP: Integer = 10;
  nHPRockDecDura: Integer = 100;
  nMPRockDecDura: Integer = 100;
  nHPMPRockDecDura: Integer = 100;
  boStartHPRockMsg: Boolean = False;
  boStartMPRockMsg: Boolean = False;
  boStartHPMPRockMsg: Boolean = False;
  sStartHPRockMsg: string = '气血石启动！！！';
  sStartMPRockMsg: string = '幻魔石启动！！！';
  sStartHPMPRockMsg: string = '魔血石启动！！！';
  PlugClass: string = 'Config';
implementation

end.

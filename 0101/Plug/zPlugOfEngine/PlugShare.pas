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
    boCanHeroUse: Boolean; //��ֹӢ��ʹ��
    boPickUpItem: Boolean;//��ֹ����(��GM��) 20080611
    boDieDropItems: Boolean;//�������� 20080614
  end;
  pTCheckItem = ^TCheckItem;

  TDisallowInfo = record //��Ʒ�����б� 20080418
    boDrop: Boolean; //����
    boDeal: Boolean; //����
    boStorage: Boolean; //���
    boRepair: Boolean;  //����
    boDropHint: Boolean; //������ʾ
    boOpenBoxsHint: Boolean; //������ʾ
    boNoDropItem: Boolean; //��������
    boButchHint: Boolean; //��ȡ��ʾ
    boHeroUse: Boolean; //��ֹӢ��ʹ��
    boPickUpItem: Boolean;//��ֹ����(��GM��) 20080611
    boDieDropItems: Boolean;//�������� 20080614
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
  nReviceMsgLength: Integer = 100; //ÿMS������ܵĳ��ȣ���������Ϊ�ǹ���
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
  sStartHPRockMsg: string = '��Ѫʯ����������';
  sStartMPRockMsg: string = '��ħʯ����������';
  sStartHPMPRockMsg: string = 'ħѪʯ����������';
  PlugClass: string = 'Config';
implementation

end.

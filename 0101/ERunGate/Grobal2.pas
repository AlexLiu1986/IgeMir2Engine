unit Grobal2;

interface
uses
  Windows;
const
  DEFBLOCKSIZE = {16}22;//20081216
  BUFFERSIZE = 10000;

  CM_DROPITEM = 1000;
  CM_PICKUP = 1001;

  CM_THROW = 3005;
  CM_TURN = 3010;
  CM_WALK = 3011;
  CM_SITDOWN = 3012;
  CM_RUN = 3013;
  CM_HIT = 3014;
  CM_HEAVYHIT = 3015;
  CM_BIGHIT = 3016;
  CM_SPELL = 3017;
  CM_POWERHIT = 3018;
  CM_LONGHIT = 3019;

  CM_WIDEHIT = 3024;
  CM_FIREHIT = 3025;

  CM_SAY = 3030;

  RUNGATECODE = $AA55AA55;

  RUNGATEMAX = 20;
  // For Game Gate
  GM_OPEN = 1;
  GM_CLOSE = 2;
  GM_CHECKSERVER = 3; // Send check signal to Server
  GM_CHECKCLIENT = 4; // Send check signal to Client
  GM_DATA = 5;
  GM_SERVERUSERINDEX = 6;
  GM_RECEIVE_OK = 7;
  GM_TEST = 20;
  GM_KickConn = 21;//20081221 踢Rungate.exe对应的连接

  OS_MOVINGOBJECT = 1;
  OS_ITEMOBJECT = 2;
  OS_EVENTOBJECT = 3;
  OS_GATEOBJECT = 4;
  OS_SWITCHOBJECT = 5;
  OS_MAPEVENT = 6;
  OS_DOOR = 7;
  OS_ROON = 8;

  RC_PLAYOBJECT = 1;
  RC_MONSTER = 2;
  RC_ANIMAL = 6;
  RC_NPC = 8;
  RC_PEACENPC = 9; //jacky

type
  TDefaultMessage = record
    Recog: Integer;
    Ident: word;
    Param: word;
    Tag: word;
    Series: word;
    nSessionID: Integer;//20081210
  end;
  pTDefaultMessage = ^TDefaultMessage;

  TMsgHeader = record
    dwCode: LongWord; //0x00
    nSocket: Integer; //0x04
    wGSocketIdx: Word; //0x08
    wIdent: Word; //0x0A
    wUserListIndex: Word; //0x0C
    //    wTemp          :Word;    //0x0E
    nLength: Integer; //0x10
  end;
  pTMsgHeader = ^TMsgHeader;
implementation

end.

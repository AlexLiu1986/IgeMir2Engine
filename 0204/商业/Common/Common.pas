unit Common;

interface

type
  //代理的结构
  TDLUserInfo = record  //返回给客户端的
    sAccount: string[12];//账号
    sUserQQ: string[20]; //QQ
    sName: string[20]; //真实姓名
    CurYuE: Currency; //帐户余额
    CurXiaoShouE: Currency; //帐户销售额
    SAddrs: string[50]; //上次登陆地址
    dTimer: TDateTime; //上次登陆时间
  end;
  pTDLUserInfo = ^TDLUserInfo;
  TUserEntry1 = record   //添加用户的机构
    sAccount: string[12];//账号
    sUserQQ: string[20]; //QQ
    sGameListUrl: string[120];
    sBakGameListUrl: string[120];
    sPatchListUrl: string[120];
    sGameMonListUrl: string[120];
    sGameESystemUrl: string[120];
    sGatePass: string[30];
  end;
  //公用结构
  TUserSession = record
    sAccount: string[12];  //帐号
    sPassword: string[20]; //密码
    boLogined: Boolean;
  end;
  //普通用户的结构
  TUserInfo = record
    sAccount: string[12];//账号
    sUserQQ: string[20]; //QQ
    nDayMakeNum: Byte; //今日生成次数
    nMaxDayMakeNum: Byte; //最大生成次数
    sAddrs: string[50]; //上次登陆地址
    dTimer: TDateTime; //上次登陆时间
  end;
const
///////////////////////////授权相关/////////////////////////////////////////////
  //代理相关
  GM_LOGIN = 118;
  SM_LOGIN_SUCCESS = 119;
  SM_LOGIN_FAIL = 120;

  GM_GETUSER = 121;          //检测用户名是否存在
  SM_GETUSER_SUCCESS = 122;
  SM_GETUSER_FAIL = 123;

  GM_ADDUSER = 124;
  SM_ADDUSER_SUCCESS = 125;
  SM_ADDUSER_FAIL = 126;

  GM_CHANGEPASS = 127;         //修改密码
  SM_CHANGEPASS_SUCCESS = 128;
  SM_CHANGEPASS_FAIL = 129;

  //用户相关
  GM_USERLOGIN = 200;          //用户登陆
  SM_USERLOGIN_SUCCESS = 201;
  SM_USERLOGIN_FAIL = 202;

  GM_USERCHANGEPASS = 203;  //修改密码
  SM_USERCHANGEPASS_SUCCESS = 204;
  SM_USERCHANGEPASS_FAIL = 205;

  GM_USERCHECKMAKEKEYANDDAYMAKENUM = 206; //验证密钥匙和今日生成次数
  SM_USERCHECKMAKEKEYANDDAYMAKENUM_SUCCESS = 207;
  SM_USERCHECKMAKEKEYANDDAYMAKENUM_FAIL = 208;

  GM_USERMAKELOGIN = 209;    //生成登陆器
  SM_USERMAKELOGIN_SUCCESS = 210;
  SM_USERMAKELOGIN_FAIL = 211;

  GM_USERMAKEGATE = 212;     //生成网关
  SM_USERMAKEGATE_SUCCESS = 213;
  SM_USERMAKEGATE_FAIL = 214;

  SM_USERMAKEONETIME_FAIL = 215; //超过服务器最大用户同时生成人数
////////////////////////////////////////////////////////////////////////////////
  GS_QUIT = 2000; //关闭
  SG_FORMHANDLE = 1000; //服务器HANLD
  SG_STARTNOW = 1001; //正在启动服务器...
  SG_STARTOK = 1002; //服务器启动完成...
implementation

end.

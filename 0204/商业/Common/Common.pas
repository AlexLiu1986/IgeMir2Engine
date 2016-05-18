unit Common;

interface

type
  //����Ľṹ
  TDLUserInfo = record  //���ظ��ͻ��˵�
    sAccount: string[12];//�˺�
    sUserQQ: string[20]; //QQ
    sName: string[20]; //��ʵ����
    CurYuE: Currency; //�ʻ����
    CurXiaoShouE: Currency; //�ʻ����۶�
    SAddrs: string[50]; //�ϴε�½��ַ
    dTimer: TDateTime; //�ϴε�½ʱ��
  end;
  pTDLUserInfo = ^TDLUserInfo;
  TUserEntry1 = record   //����û��Ļ���
    sAccount: string[12];//�˺�
    sUserQQ: string[20]; //QQ
    sGameListUrl: string[120];
    sBakGameListUrl: string[120];
    sPatchListUrl: string[120];
    sGameMonListUrl: string[120];
    sGameESystemUrl: string[120];
    sGatePass: string[30];
  end;
  //���ýṹ
  TUserSession = record
    sAccount: string[12];  //�ʺ�
    sPassword: string[20]; //����
    boLogined: Boolean;
  end;
  //��ͨ�û��Ľṹ
  TUserInfo = record
    sAccount: string[12];//�˺�
    sUserQQ: string[20]; //QQ
    nDayMakeNum: Byte; //�������ɴ���
    nMaxDayMakeNum: Byte; //������ɴ���
    sAddrs: string[50]; //�ϴε�½��ַ
    dTimer: TDateTime; //�ϴε�½ʱ��
  end;
const
///////////////////////////��Ȩ���/////////////////////////////////////////////
  //�������
  GM_LOGIN = 118;
  SM_LOGIN_SUCCESS = 119;
  SM_LOGIN_FAIL = 120;

  GM_GETUSER = 121;          //����û����Ƿ����
  SM_GETUSER_SUCCESS = 122;
  SM_GETUSER_FAIL = 123;

  GM_ADDUSER = 124;
  SM_ADDUSER_SUCCESS = 125;
  SM_ADDUSER_FAIL = 126;

  GM_CHANGEPASS = 127;         //�޸�����
  SM_CHANGEPASS_SUCCESS = 128;
  SM_CHANGEPASS_FAIL = 129;

  //�û����
  GM_USERLOGIN = 200;          //�û���½
  SM_USERLOGIN_SUCCESS = 201;
  SM_USERLOGIN_FAIL = 202;

  GM_USERCHANGEPASS = 203;  //�޸�����
  SM_USERCHANGEPASS_SUCCESS = 204;
  SM_USERCHANGEPASS_FAIL = 205;

  GM_USERCHECKMAKEKEYANDDAYMAKENUM = 206; //��֤��Կ�׺ͽ������ɴ���
  SM_USERCHECKMAKEKEYANDDAYMAKENUM_SUCCESS = 207;
  SM_USERCHECKMAKEKEYANDDAYMAKENUM_FAIL = 208;

  GM_USERMAKELOGIN = 209;    //���ɵ�½��
  SM_USERMAKELOGIN_SUCCESS = 210;
  SM_USERMAKELOGIN_FAIL = 211;

  GM_USERMAKEGATE = 212;     //��������
  SM_USERMAKEGATE_SUCCESS = 213;
  SM_USERMAKEGATE_FAIL = 214;

  SM_USERMAKEONETIME_FAIL = 215; //��������������û�ͬʱ��������
////////////////////////////////////////////////////////////////////////////////
  GS_QUIT = 2000; //�ر�
  SG_FORMHANDLE = 1000; //������HANLD
  SG_STARTNOW = 1001; //��������������...
  SG_STARTOK = 1002; //�������������...
implementation

end.

unit Grobal2;//ȫ��(�������Ϳͻ���ͨ��)��Ϣ,���ݽṹ,������

interface                                                  

uses                                 
  Windows, Classes, JSocket{, Controls};
const
  HEROVERSION = 1; //1��Ӣ�۰�
  MAXPATHLEN = 255;                                                     
  DIRPATHLEN = 80;
  MAPNAMELEN = 16;
  ACTORNAMELEN = 14;
  DEFBLOCKSIZE = {16}22;//20081221 
  BUFFERSIZE = 10000; //���嶨��
  DATA_BUFSIZE2 = 16348; //8192;
  DATA_BUFSIZE = 8192; //8192;
  GROUPMAX = 11;
  BAGGOLD = 5000000;
  BODYLUCKUNIT = 10;
  MAX_STATUS_ATTRIBUTE = 12;//20080626 �޸�

//����������ֻ��8������,���Ǵ��,�ƶ����,��ӥ����16����
  DR_UP = 0;//����
  DR_UPRIGHT = 1;//������
  DR_RIGHT = 2; //��
  DR_DOWNRIGHT = 3;//������
  DR_DOWN = 4;//��
  DR_DOWNLEFT = 5;//������
  DR_LEFT = 6;//��
  DR_UPLEFT = 7;//������

//װ����Ŀ
  U_DRESS = 0; //�·�
  U_WEAPON = 1; //����
  U_RIGHTHAND = 2; //����
  U_NECKLACE = 3; //����
  U_HELMET = 4; //ͷ��
  U_ARMRINGL = 5; //��������,��
  U_ARMRINGR = 6;//��������
  U_RINGL = 7;  //���ָ
  U_RINGR = 8;//�ҽ�ָ
  U_BUJUK = 9; //��Ʒ
  U_BELT = 10; //����
  U_BOOTS = 11; //Ь
  U_CHARM = 12; //��ʯ
  U_ZHULI = 13;//����
  X_RepairFir = 20; //�޲�����֮��

  POISON_DECHEALTH = 0;//�ж����ͣ��̶�
  POISON_DAMAGEARMOR = 1;//�ж����ͣ��춾
  POISON_LOCKSPELL = 2;//���ܹ���
  POISON_DONTMOVE = 4;//�����ƶ�
  POISON_STONE = 5; //�ж�����:���

  STATE_STONE_MODE = 1;//��ʯ��
  STATE_LOCKRUN = 3;//�����ܶ�(������) 20080811
  STATE_ProtectionDEFENCE = 7;//������� 20080107
  STATE_TRANSPARENT = 8;//����
  STATE_DEFENCEUP = 9;//��ʥս����  ������
  STATE_MAGDEFENCEUP = 10;//�����  ħ����
  STATE_BUBBLEDEFENCEUP = 11;//ħ����

  USERMODE_PLAYGAME = 1;
  USERMODE_LOGIN = 2;
  USERMODE_LOGOFF = 3;
  USERMODE_NOTICE = 4;

  RUNGATEMAX = 20;

  RUNGATECODE = $AA55AA55;

  OS_MOVINGOBJECT = 1;
  OS_ITEMOBJECT = 2;
  OS_EVENTOBJECT = 3;
  OS_GATEOBJECT = 4;
  OS_SWITCHOBJECT = 5;
  OS_MAPEVENT = 6;
  OS_DOOR = 7;
  OS_ROON = 8;

  RC_PLAYOBJECT = 0;//����
  RC_PLAYMOSTER = 150; //���ι���
  RC_HEROOBJECT = 66; //Ӣ��
  RC_GUARD = 12; //������ 20080311
  RC_PEACENPC = 15;
  RC_ANIMAL = 50;
  RC_MONSTER = 80;
  RC_NPC = 10;//NPC
  RC_ARCHERGUARD = 112;//NPC ������


  RCC_USERHUMAN = RC_PLAYOBJECT;
  RCC_GUARD = RC_GUARD;
  RCC_MERCHANT = RC_ANIMAL;

  ISM_WHISPER = 1234;

  CM_QUERYCHR = 100;  //��¼�ɹ�,�ͻ����Գ����ҽ�ɫ����һ˲
  CM_NEWCHR = 101;      //������ɫ
  CM_DELCHR = 102;      //ɾ����ɫ
  CM_SELCHR = 103;      //ѡ���ɫ
  CM_SELECTSERVER = 104;//������,ע�ⲻ��ѡ��,ʢ��һ��������(����8��??group.dat������ôд��)��ֹһ���ķ�����
  CM_QUERYDELCHR = 105;//��ѯɾ�����Ľ�ɫ��Ϣ 20080706
  CM_RESDELCHR = 106;//�ָ�ɾ���Ľ�ɫ 20080706

  SM_RUSH = 6; //�ܶ��иı䷽��
  SM_RUSHKUNG = 7; //Ұ����ײ
  SM_FIREHIT = 8; //�һ�
  SM_4FIREHIT = 58; //4���һ� 20080112
  SM_BACKSTEP = 9; //����,Ұ��Ч��? //����ͳ�칫���ֹ�����ҵĺ���??axemon.pas��procedure   TDualAxeOma.Run
  SM_TURN = 10; //ת��
  SM_WALK = 11; //��
  SM_SITDOWN = 12;
  SM_RUN = 13; //��
  SM_HIT = 14; //��
  SM_HEAVYHIT = 15; //
  SM_BIGHIT = 16; //
  SM_SPELL = 17; //ʹ��ħ��
  SM_POWERHIT = 18;//��ɱ
  SM_LONGHIT = 19; //��ɱ
  SM_DIGUP = 20;//����һ"��"һ"��",�������ڶ�����"��"
  SM_DIGDOWN = 21;//�ڶ�����"��"
  SM_FLYAXE = 22;//�ɸ�,����ͳ��Ĺ�����ʽ?
  SM_LIGHTING = 23;//��������
  SM_WIDEHIT = 24; //����
  SM_CRSHIT = 25; //���µ�
  SM_TWINHIT = 26; //����ն�ػ�
  SM_QTWINHIT = 59; //����ն���
  SM_CIDHIT = 57; //��Ӱ����


  SM_ALIVE = 27; //����??�����ָ
  SM_MOVEFAIL = 28; //�ƶ�ʧ��,�߶����ܶ�
  SM_HIDE = 29; //����?
  SM_DISAPPEAR = 30;//������Ʒ��ʧ
  SM_STRUCK = 31; //�ܹ���
  SM_DEATH = 32; //��������
  SM_SKELETON = 33; //ʬ��
  SM_NOWDEATH = 34; //��ɱ?

  SM_ACTION_MIN = SM_RUSH;
  SM_ACTION_MAX = SM_WIDEHIT;
  SM_ACTION2_MIN = 65072;
  SM_ACTION2_MAX = 65073;

  SM_HEAR = 40;  //���˻���Ļ�
  SM_FEATURECHANGED = 41;
  SM_USERNAME = 42;
  SM_WINEXP = 44;//��þ���
  SM_LEVELUP = 45; //����,���Ͻǳ���ī�̵���������
  SM_DAYCHANGING = 46;//����������½ǵ�̫����������

  SM_LOGON = 50;//logon
  SM_NEWMAP = 51; //�µ�ͼ??
  SM_ABILITY = 52;//�����ԶԻ���,F11
  SM_HEALTHSPELLCHANGED = 53;//������ʹ�����������
  SM_MAPDESCRIPTION = 54;//��ͼ����,�л�ս��ͼ?��������?��ȫ����?
  SM_SPELL2 = 117;

//�Ի���Ϣ
  SM_MOVEMESSAGE = 99;
  SM_SYSMESSAGE = 100; //ϵͳ��Ϣ,ʢ��һ�����,˽������
  SM_GROUPMESSAGE = 101;//��������!!
  SM_CRY = 102; //����
  SM_WHISPER = 103;//˽��
  SM_GUILDMESSAGE = 104;  //�л�����!~

  SM_ADDITEM = 200;
  SM_BAGITEMS = 201;
  SM_DELITEM = 202;
  SM_UPDATEITEM = 203;
  SM_ADDMAGIC = 210;
  SM_SENDMYMAGIC = 211;
  SM_DELMAGIC = 212;

 //�������˷��͵����� SM:server msg,�������ͻ��˷��͵���Ϣ

//��¼�����ʺš��½�ɫ����ѯ��ɫ��  
  SM_CERTIFICATION_FAIL = 501;
  SM_ID_NOTFOUND = 502;
  SM_PASSWD_FAIL = 503;//��֤ʧ��,"��������֤ʧ��,��Ҫ���µ�¼"??
  SM_NEWID_SUCCESS = 504;//�������˺ųɹ�
  SM_NEWID_FAIL = 505; //�������˺�ʧ��
  SM_CHGPASSWD_SUCCESS = 506; //�޸�����ɹ�
  SM_CHGPASSWD_FAIL = 507;  //�޸�����ʧ��
  SM_GETBACKPASSWD_SUCCESS = 508; //�����һسɹ�
  SM_GETBACKPASSWD_FAIL = 509; //�����һ�ʧ��

  SM_QUERYCHR = 520; //���ؽ�ɫ��Ϣ���ͻ���
  SM_NEWCHR_SUCCESS = 521; //�½���ɫ�ɹ�
  SM_NEWCHR_FAIL = 522; //�½���ɫʧ��
  SM_DELCHR_SUCCESS = 523; //ɾ����ɫ�ɹ�
  SM_DELCHR_FAIL = 524; //ɾ����ɫʧ��
  SM_STARTPLAY = 525; //��ʼ������Ϸ����(���˽�����Ϸ�Ҹ�������Ϸ����)
  SM_STARTFAIL = 526; ////��ʼʧ��,�洫���������,��ʱѡ���ɫ,�㽡����Ϸ�Ҹ�����

  SM_QUERYCHR_FAIL = 527;//���ؽ�ɫ��Ϣ���ͻ���ʧ��
  SM_OUTOFCONNECTION = 528; //�������������,ǿ���û�����
  SM_PASSOK_SELECTSERVER = 529;  //������֤�����������ȷ,��ʼѡ��
  SM_SELECTSERVER_OK = 530;  //ѡ���ɹ�
  SM_NEEDUPDATE_ACCOUNT = 531;//��Ҫ����,ע����ID�ᷢ��ʲô�仯?˽���е���ͨID������ֵ??��������ͨID��Ϊ��ԱID,GM?
  SM_UPDATEID_SUCCESS = 532; //���³ɹ�
  SM_UPDATEID_FAIL = 533;  //����ʧ��

  SM_QUERYDELCHR = 534;//����ɾ�����Ľ�ɫ 20080706
  SM_QUERYDELCHR_FAIL = 535;//����ɾ�����Ľ�ɫʧ�� 20080706
  SM_RESDELCHR_SUCCESS = 536;//�ָ�ɾ����ɫ�ɹ� 20080706
  SM_RESDELCHR_FAIL = 537;//�ָ�ɾ����ɫʧ�� 20080706
  SM_NOCANRESDELCHR = 538;//��ֹ�ָ�ɾ����ɫ,�����ɲ鿴 200800706

  SM_DROPITEM_SUCCESS = 600;
  SM_DROPITEM_FAIL = 601;

  SM_ITEMSHOW = 610;
  SM_ITEMHIDE = 611;
  //  SM_DOOROPEN           = 612;
  SM_OPENDOOR_OK = 612; //ͨ�����ŵ�ɹ�
  SM_OPENDOOR_LOCK = 613;//���ֹ��ſ��Ƿ�����,��ǰʢ������ͨ��ȥ���µ���Ҫ5���ӿ�һ��
  SM_CLOSEDOOR = 614;//�û�����,�����йر�
  SM_TAKEON_OK = 615;
  SM_TAKEON_FAIL = 616;
  SM_TAKEOFF_OK = 619;
  SM_TAKEOFF_FAIL = 620;
  SM_SENDUSEITEMS = 621;
  SM_WEIGHTCHANGED = 622;
  SM_CLEAROBJECTS = 633;
  SM_CHANGEMAP = 634; //��ͼ�ı�,�����µ�ͼ
  SM_EAT_OK = 635;
  SM_EAT_FAIL = 636;
  SM_BUTCH = 637; //Ұ��?
  SM_MAGICFIRE = 638; //������,��ǽ??
  SM_MAGICFIRE_FAIL = 639;
  SM_MAGIC_LVEXP = 640;
  SM_DURACHANGE = 642;
  SM_MERCHANTSAY = 643;
  SM_MERCHANTDLGCLOSE = 644;
  SM_SENDGOODSLIST = 645;
  SM_SENDUSERSELL = 646;
  SM_SENDBUYPRICE = 647;
  SM_USERSELLITEM_OK = 648;
  SM_USERSELLITEM_FAIL = 649;
  SM_BUYITEM_SUCCESS = 650; //?
  SM_BUYITEM_FAIL = 651; //?
  SM_SENDDETAILGOODSLIST = 652;
  SM_GOLDCHANGED = 653;
  SM_CHANGELIGHT = 654; //���ظı�
  SM_LAMPCHANGEDURA = 655;//����־øı�
  SM_CHANGENAMECOLOR = 656;//������ɫ�ı�,����,����,����,����
  SM_CHARSTATUSCHANGED = 657;
  SM_SENDNOTICE = 658; //���ͽ�����Ϸ�Ҹ�(����)
  SM_GROUPMODECHANGED = 659;//���ģʽ�ı�
  SM_CREATEGROUP_OK = 660;
  SM_CREATEGROUP_FAIL = 661;
  SM_GROUPADDMEM_OK = 662;
  SM_GROUPDELMEM_OK = 663;
  SM_GROUPADDMEM_FAIL = 664;
  SM_GROUPDELMEM_FAIL = 665;
  SM_GROUPCANCEL = 666;
  SM_GROUPMEMBERS = 667;
  SM_SENDUSERREPAIR = 668;
  SM_USERREPAIRITEM_OK = 669;
  SM_USERREPAIRITEM_FAIL = 670;
  SM_SENDREPAIRCOST = 671;
  SM_DEALMENU = 673;
  SM_DEALTRY_FAIL = 674;
  SM_DEALADDITEM_OK = 675;
  SM_DEALADDITEM_FAIL = 676;
  SM_DEALDELITEM_OK = 677;
  SM_DEALDELITEM_FAIL = 678;
  SM_DEALCANCEL = 681;
  SM_DEALREMOTEADDITEM = 682;
  SM_DEALREMOTEDELITEM = 683;
  SM_DEALCHGGOLD_OK = 684;
  SM_DEALCHGGOLD_FAIL = 685;
  SM_DEALREMOTECHGGOLD = 686;
  SM_DEALSUCCESS = 687;
  SM_SENDUSERSTORAGEITEM = 700;
  SM_STORAGE_OK = 701;
  SM_STORAGE_FULL = 702;
  SM_STORAGE_FAIL = 703;
  SM_SAVEITEMLIST = 704;
  SM_TAKEBACKSTORAGEITEM_OK = 705;
  SM_TAKEBACKSTORAGEITEM_FAIL = 706;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;

  SM_AREASTATE = 708; //��Χ״̬
  SM_MYSTATUS = 766;//�ҵ�״̬,���һ������״̬,���Ƿ񱻶�,���˾�ǿ�ƻس�

  SM_DELITEMS = 709;
  SM_READMINIMAP_OK = 710;
  SM_READMINIMAP_FAIL = 711;
  SM_SENDUSERMAKEDRUGITEMLIST = 712;
  SM_MAKEDRUG_SUCCESS = 713;
  //  714
  //  716
  SM_MAKEDRUG_FAIL = 65036;

  SM_CHANGEGUILDNAME = 750;
  SM_SENDUSERSTATE = 751; //
  SM_SUBABILITY = 752; //���������ԶԻ���
  SM_OPENGUILDDLG = 753; //
  SM_OPENGUILDDLG_FAIL = 754; //
  SM_SENDGUILDMEMBERLIST = 756; //
  SM_GUILDADDMEMBER_OK = 757; //
  SM_GUILDADDMEMBER_FAIL = 758;
  SM_GUILDDELMEMBER_OK = 759;
  SM_GUILDDELMEMBER_FAIL = 760;
  SM_GUILDRANKUPDATE_FAIL = 761;
  SM_BUILDGUILD_OK = 762;
  SM_BUILDGUILD_FAIL = 763;
  SM_DONATE_OK = 764;
  SM_DONATE_FAIL = 765;

  SM_MENU_OK = 767; //?
  SM_GUILDMAKEALLY_OK = 768;
  SM_GUILDMAKEALLY_FAIL = 769;
  SM_GUILDBREAKALLY_OK = 770; //?
  SM_GUILDBREAKALLY_FAIL = 771; //?
  SM_DLGMSG = 772; //Jacky
  SM_SPACEMOVE_HIDE = 800;//��ʿ��һ������
  SM_SPACEMOVE_SHOW = 801;//��ʿ��һ���������Ϊ����
  SM_RECONNECT = 802; //�����������
  SM_GHOST = 803; //ʬ�����,��ħ��������Ч��?
  SM_SHOWEVENT = 804;//��ʾ�¼�
  SM_HIDEEVENT = 805;//�����¼�
  SM_SPACEMOVE_HIDE2 = 806;
  SM_SPACEMOVE_SHOW2 = 807;
  SM_TIMECHECK_MSG = 810; //ʱ�Ӽ��,����ͻ�������
  SM_ADJUST_BONUS = 811; //?


  SM_OPENHEALTH = 1100;
  SM_CLOSEHEALTH = 1101;

  SM_BREAKWEAPON = 1102; //��������
  SM_INSTANCEHEALGUAGE = 1103; //ʵʱ����
  SM_CHANGEFACE = 1104; //����,���͸ı�?
  SM_VERSION_FAIL = 1106; //�ͻ��˰汾��֤ʧ��

  SM_ITEMUPDATE = 1500;
  SM_MONSTERSAY = 1501;

  SM_EXCHGTAKEON_OK = 65023;
  SM_EXCHGTAKEON_FAIL = 65024;

  SM_TEST = 65037;
  SM_TESTHERO = 65038;
  SM_THROW = 65069;

  RM_DELITEMS = 9000; //Jacky
  RM_TURN = 10001;
  RM_WALK = 10002;
  RM_RUN = 10003;
  RM_HIT = 10004;
  RM_SPELL = 10007;
  RM_SPELL2 = 10008;
  RM_POWERHIT = 10009;
  RM_LONGHIT = 10011;
  RM_WIDEHIT = 10012;
  RM_PUSH = 10013;
  RM_FIREHIT = 10014;//�һ�
  RM_4FIREHIT = 10016;//4���һ� 20080112
  RM_RUSH = 10015;
  RM_STRUCK = 10020;//��������
  RM_DEATH = 10021;
  RM_DISAPPEAR = 10022;
  RM_MAGSTRUCK = 10025;
  RM_MAGHEALING = 10026;
  RM_STRUCK_MAG = 10027;//��ħ�����
  RM_MAGSTRUCK_MINE = 10028;
  RM_INSTANCEHEALGUAGE = 10029; //jacky
  RM_HEAR = 10030;//����
  RM_WHISPER = 10031;
  RM_CRY = 10032;
  RM_RIDE = 10033;
  RM_WINEXP = 10044;
  RM_USERNAME = 10043;
  RM_LEVELUP = 10045;
  RM_CHANGENAMECOLOR = 10046;

  RM_LOGON = 10050;
  RM_ABILITY = 10051;
  RM_HEALTHSPELLCHANGED = 10052;
  RM_DAYCHANGING = 10053;

  RM_MOVEMESSAGE = 10099;//��������   ���� 2007.11.13
  RM_SYSMESSAGE = 10100;
  RM_GROUPMESSAGE = 10102;
  RM_SYSMESSAGE2 = 10103;
  RM_GUILDMESSAGE = 10104;
  RM_SYSMESSAGE3 = 10105; //Jacky
  RM_ITEMSHOW = 10110;
  RM_ITEMHIDE = 10111;
  RM_DOOROPEN = 10112;
  RM_DOORCLOSE = 10113;
  RM_SENDUSEITEMS = 10114;//����ʹ�õ���Ʒ
  RM_WEIGHTCHANGED = 10115;

  RM_FEATURECHANGED = 10116;
  RM_CLEAROBJECTS = 10117;
  RM_CHANGEMAP = 10118;
  RM_BUTCH = 10119;//��
  RM_MAGICFIRE = 10120;
  RM_SENDMYMAGIC = 10122;//����ʹ�õ�ħ��
  RM_MAGIC_LVEXP = 10123;
  RM_SKELETON = 10024;
  RM_DURACHANGE = 10125;//�־øı�
  RM_MERCHANTSAY = 10126;
  RM_GOLDCHANGED = 10136;
  RM_CHANGELIGHT = 10137;
  RM_CHARSTATUSCHANGED = 10139;
  RM_DELAYMAGIC = 10154;

  RM_DIGUP = 10200;
  RM_DIGDOWN = 10201;
  RM_FLYAXE = 10202;
  RM_LIGHTING = 10204;
  RM_SUBABILITY = 10302;
  RM_TRANSPARENT = 10308;

  RM_SPACEMOVE_SHOW = 10331;
  RM_RECONNECTION = 11332;
  RM_SPACEMOVE_SHOW2 = 10332; //?
  RM_HIDEEVENT = 10333;//�����̻�
  RM_SHOWEVENT = 10334;//��ʾ�̻�
  RM_ZEN_BEE = 10337;

  RM_OPENHEALTH = 10410;
  RM_CLOSEHEALTH = 10411;
  RM_DOOPENHEALTH = 10412;
  RM_CHANGEFACE = 10415;

  RM_ITEMUPDATE = 11000;
  RM_MONSTERSAY = 11001;
  RM_MAKESLAVE = 11002;

  RM_MONMOVE = 21004;
  SS_200 = 200;
  SS_201 = 201;
  SS_202 = 202;
  SS_WHISPER = 203;
  SS_204 = 204;
  SS_205 = 205;
  SS_206 = 206;
  SS_207 = 207;
  SS_208 = 208;
  SS_209 = 219;
  SS_210 = 210;
  SS_211 = 211;
  SS_212 = 212;
  SS_213 = 213;
  SS_214 = 214;

  RM_10205 = 10205;
  RM_10101 = 10101;
  RM_ALIVE = 10153;//����
  RM_CHANGEGUILDNAME = 10301;
  RM_10414 = 10414;
  RM_POISON = 10300;
  LA_UNDEAD = 1; //����ϵ

  RM_DELAYPUSHED = 10555;

  CM_GETBACKPASSWORD = 2010; //�����һ�
  CM_SPELL = 3017; //ʩħ��
  CM_QUERYUSERNAME = 80; //������Ϸ,���������ؽ�ɫ�����ͻ���

  CM_DROPITEM = 1000;//�Ӱ������ӳ���Ʒ����ͼ,��ʱ��������ڰ�ȫ�����ܻ���ʾ��ȫ���������Ӷ���
  CM_PICKUP = 1001;//����
  CM_TAKEONITEM = 1003;//װ��װ�������ϵ�װ��λ��
  CM_TAKEOFFITEM = 1004; //������ĳ��װ��λ��ȡ��ĳ��װ��
  CM_EAT = 1006; //��ҩ
  CM_BUTCH = 1007;//��
  CM_MAGICKEYCHANGE = 1008;//ħ����ݼ��ı�
  CM_HEROMAGICKEYCHANGE = 1046;//Ӣ��ħ���������� 20080606
  CM_1005 = 1005;

//���̵�NPC�������
  CM_CLICKNPC = 1010; //�û������ĳ��NPC���н���
  CM_MERCHANTDLGSELECT = 1011; //��Ʒѡ��,����
  CM_MERCHANTQUERYSELLPRICE = 1012;//���ؼ۸�,��׼�۸�,����֪���̵��û��������Щ�������־û�������
  CM_USERSELLITEM = 1013; //�û�������
  CM_USERBUYITEM = 1014; //�û����붫��
  CM_USERGETDETAILITEM = 1015;//ȡ����Ʒ�嵥,������"���۽�ָ"����,�����һ�����۽�ָ����ѡ��
  CM_DROPGOLD = 1016; //�û����½�Ǯ������
  CM_LOGINNOTICEOK = 1018; //������Ϸ�Ҹ����ȷʵ,������Ϸ
  CM_GROUPMODE = 1019;   //���黹�ǿ���
  CM_CREATEGROUP = 1020; //�½����
  CM_ADDGROUPMEMBER = 1021;//��������
  CM_DELGROUPMEMBER = 1022; //����ɾ��
  CM_USERREPAIRITEM = 1023; //�û�������
  CM_MERCHANTQUERYREPAIRCOST = 1024; //�ͻ�����NPCȡ���������
  CM_DEALTRY = 1025;  //��ʼ����,���׿�ʼ
  CM_DEALADDITEM = 1026; //�Ӷ�����������Ʒ����
  CM_DEALDELITEM = 1027;//�ӽ�����Ʒ���ϳ��ض���???��������Ŷ
  CM_DEALCANCEL = 1028;  //ȡ������
  CM_DEALCHGGOLD = 1029; //�����������Ͻ�ǮΪ0,,���н�Ǯ����,����˫�������������Ϣ
  CM_DEALEND = 1030; //���׳ɹ�,��ɽ���
  CM_USERSTORAGEITEM = 1031; //�û��Ĵ涫��
  CM_USERTAKEBACKSTORAGEITEM = 1032;//�û��򱣹�Աȡ�ض���
  CM_WANTMINIMAP = 1033;  //�û������"С��ͼ"��ť
  CM_USERMAKEDRUGITEM = 1034; //�û����춾ҩ(������Ʒ)
  CM_OPENGUILDDLG = 1035; //�û������"�л�"��ť
  CM_GUILDHOME = 1036; //���"�л���ҳ"
  CM_GUILDMEMBERLIST = 1037; //���"��Ա�б�"
  CM_GUILDADDMEMBER = 1038; //���ӳ�Ա
  CM_GUILDDELMEMBER = 1039;//���˳��л�
  CM_GUILDUPDATENOTICE = 1040; //�޸��лṫ��
  CM_GUILDUPDATERANKINFO = 1041; //����������Ϣ(ȡ����������)
  CM_ADJUST_BONUS = 1043;  //�û��õ�����??˽���бȽ�����,С������ʱ��ó���Ǯ������,���Ǻ�ȷ��,//�󾭹����Եĸ��ֵ���֤
  CM_SPEEDHACKUSER = 10430; //�û��������׼��

  CM_PASSWORD = 1105;
  CM_CHGPASSWORD = 1221; //?
  CM_SETPASSWORD = 1222; //?

  CM_HORSERUN = 3009;

  CM_THROW = 3005;//�׷�
  
//��������1
  CM_TURN = 3010; //ת��(����ı�)
  CM_WALK = 3011; //��
  CM_SITDOWN = 3012;//��(����)
  CM_RUN = 3013; //��
  CM_HIT = 3014;   //��ͨ���������
  CM_HEAVYHIT = 3015;//��������Ķ���
  CM_BIGHIT = 3016;

  CM_POWERHIT = 3018; //��ɱ
  CM_LONGHIT = 3019;  //��ɱ

  CM_WIDEHIT = 3024; //����
  CM_FIREHIT = 3025; //�һ𹥻�
  CM_4FIREHIT = 3031; //4���һ𹥻�
  CM_CRSHIT = 3036; //���µ�
  CM_TWNHIT = 3037; //����ն�ػ�
  CM_QTWINHIT = 3041; //����ն���
  CM_CIDHIT = 3040; //��Ӱ����
  CM_TWINHIT = CM_TWNHIT;
  CM_PHHIT = 3038; //�ƻ�ն
  CM_DAILY = 3042; //���ս��� 20080511

  CM_SAY = 3030;    //��ɫ����
  CM_40HIT = 3026;
  CM_41HIT = 3027;
  CM_42HIT = 3029;
  CM_43HIT = 3028;
  RM_10401 = 10401;

  RM_MENU_OK = 10309; //�˵�
  RM_MERCHANTDLGCLOSE = 10127;
  RM_SENDDELITEMLIST = 10148;//����ɾ����Ŀ������
  RM_SENDUSERSREPAIR = 10141;//�����û�����
  RM_SENDGOODSLIST = 10128;//������Ʒ����
  RM_SENDUSERSELL = 10129;//�����û�����
  RM_SENDUSERREPAIR = 11139;//�����û�����
  RM_USERMAKEDRUGITEMLIST = 10149;//�û���ҩƷ��Ŀ������
  RM_USERSTORAGEITEM = 10146;//�û��ֿ���Ŀ
  RM_USERGETBACKITEM = 10147;//�û���ûصĲֿ���Ŀ

  RM_SPACEMOVE_FIRE2 = 11330;//�ռ��ƶ�
  RM_SPACEMOVE_FIRE = 11331;//�ռ��ƶ�

  RM_BUYITEM_SUCCESS = 10133;//������Ŀ�ɹ�
  RM_BUYITEM_FAIL = 10134;//������Ŀʧ��
  RM_SENDDETAILGOODSLIST = 10135; //������ϸ����Ʒ����
  RM_SENDBUYPRICE = 10130;//���͹���۸�
  RM_USERSELLITEM_OK = 10131;//�û����۳ɹ�
  RM_USERSELLITEM_FAIL = 10132;//�û�����ʧ��
  RM_MAKEDRUG_SUCCESS = 10150;//��ҩ�ɹ�
  RM_MAKEDRUG_FAIL = 10151;//��ҩʧ��
  RM_SENDREPAIRCOST = 10142;//��������ɱ�
  RM_USERREPAIRITEM_OK = 10143;//�û�������Ŀ�ɹ�
  RM_USERREPAIRITEM_FAIL = 10144;//�û�������Ŀʧ��

  MAXBAGITEM = 46;//���ﱳ���������
  MAXHEROBAGITEM = 40; //Ӣ�۰����������
  RM_10155 = 10155;
  RM_PLAYDICE = 10500;
  RM_ADJUST_BONUS = 10400;

  RM_BUILDGUILD_OK = 10303;
  RM_BUILDGUILD_FAIL = 10304;
  RM_DONATE_OK = 10305;

  RM_GAMEGOLDCHANGED = 10666;

  STATE_OPENHEATH = 1;
  POISON_68 = 68;

  RM_MYSTATUS = 10777;

  CM_QUERYUSERSTATE = 82;//��ѯ�û�״̬(�û���¼��ȥ,ʵ�����ǿͻ������������ȡ��ѯ���һ��,�˳�������ǰ��״̬�Ĺ���,
                         //�������Զ����û����һ������������Ϸ������һЩ��Ϣ���ص��ͻ���)

  CM_QUERYBAGITEMS = 81;  //��ѯ������Ʒ

  CM_QUERYUSERSET = 49999;

  CM_OPENDOOR = 1002;  //����,�����ߵ���ͼ��ĳ�����ŵ�ʱ
  CM_SOFTCLOSE = 1009;//�˳�����(��Ϸ����,��������Ϸ�д���,Ҳ����ʱѡ��ʱ�˳�)
  CM_1017 = 1017;
  CM_1042 = 1042;
  CM_GUILDALLY = 1044;
  CM_GUILDBREAKALLY = 1045;

  RM_HORSERUN = 11000;
  RM_HEAVYHIT = 10005;
  RM_BIGHIT = 10006;
  RM_MOVEFAIL = 10010;
  RM_CRSHIT = 11014;
  RM_RUSHKUNG = 11015;

  RM_41 = 41;
  RM_42 = 42;
  RM_43 = 43;
  RM_44 = 56;

  RM_MAGICFIREFAIL = 10121;
  RM_LAMPCHANGEDURA = 10138;
  RM_GROUPCANCEL = 10140;

  RM_DONATE_FAIL = 10306;

  RM_BREAKWEAPON = 10413;

  RM_PASSWORD = 10416;

  RM_PASSWORDSTATUS = 10601;

  SM_40 = 35;
  SM_41 = 36;
  SM_42 = 37;
  SM_43 = 38;
  SM_44 = 39; //��Ӱ����

  SM_HORSERUN = 5;
  SM_716 = 716;

  SM_PASSWORD = 3030;
  SM_PLAYDICE = 1200;

  SM_PASSWORDSTATUS = 20001;

  SM_GAMEGOLDNAME = 55; //��ͻ��˷�����Ϸ��,��Ϸ��,���ʯ,�������

  SM_SERVERCONFIG = 20002;
  SM_GETREGINFO = 20003;


  ET_DIGOUTZOMBI = 1;
  ET_PILESTONES = 3;
  ET_HOLYCURTAIN = 4;
  ET_FIRE = 5;
  ET_SCULPEICE = 6;
{6���̻�}
  ET_FIREFLOWER_1 = 7;//һ��һ��
  ET_FIREFLOWER_2 = 8;//������ӡ
  ET_FIREFLOWER_3 = 9;
  ET_FIREFLOWER_4 = 10;
  ET_FIREFLOWER_5 = 11;
  ET_FIREFLOWER_6 = 12;
  ET_FIREFLOWER_7 = 13;
  ET_FIREFLOWER_8 = 14;//û��ͼƬ
  ET_FOUNTAIN = 15;//��ȪЧ�� 20080624
  ET_DIEEVENT = 16; //����ׯ����������Ч�� 20080918

  CM_PROTOCOL = 2000;
  CM_IDPASSWORD = 2001; //�ͻ��������������ID������
  CM_ADDNEWUSER = 2002; //�½��û�,����ע�����˺�,��¼ʱѡ����"���û�"�������ɹ�
  CM_CHANGEPASSWORD = 2003;  //�޸�����
  CM_UPDATEUSER = 2004;  //����ע������??
  CM_RANDOMCODE = 2006;//ȡ��֤�� 20080612
  SM_RANDOMCODE = 2007;


  CLIENT_VERSION_NUMBER = 920080512;//9+�ͻ��˰汾�� 20080512
  CM_3037 = 3039;           //2007.10.15����ֵ  ��ǰ��  3037

  SM_NEEDPASSWORD = 8003;
  CM_POWERBLOCK = 0;

  //�������
  CM_OPENSHOP = 9000; //������
  SM_SENGSHOPITEMS = 9001; // SERIES 7 ÿҳ������    wParam ��ҳ��
  CM_BUYSHOPITEM = 9002;
  SM_BUYSHOPITEM_SUCCESS = 9003;
  SM_BUYSHOPITEM_FAIL = 9004;
  SM_SENGSHOPSPECIALLYITEMS = 9005; //��������
  CM_BUYSHOPITEMGIVE = 9006; //����
  SM_BUYSHOPITEMGIVE_FAIL = 9007;
  SM_BUYSHOPITEMGIVE_SUCCESS = 9008;

  RM_OPENSHOPSpecially = 30000;
  RM_OPENSHOP = 30001;
  RM_BUYSHOPITEM_FAIL = 30003;//���̹�����Ʒʧ��
  RM_BUYSHOPITEMGIVE_FAIL = 30004;
  RM_BUYSHOPITEMGIVE_SUCCESS = 30005;
  //==============================================================================
  CM_QUERYUSERLEVELSORT = 3500; //�û��ȼ�����
  RM_QUERYUSERLEVELSORT = 35000;
  SM_QUERYUSERLEVELSORT = 2500;
  //==============================������Ʒ����ϵͳ(����)==========================
  RM_SENDSELLOFFGOODSLIST = 21008;//����
  SM_SENDSELLOFFGOODSLIST = 20008;//����
  RM_SENDUSERSELLOFFITEM = 21005; //������Ʒ
  SM_SENDUSERSELLOFFITEM = 20005; //������Ʒ
  RM_SENDSELLOFFITEMLIST = 22009; //��ѯ�õ��ļ�����Ʒ
  CM_SENDSELLOFFITEMLIST = 20009; //��ѯ�õ��ļ�����Ʒ
  RM_SENDBUYSELLOFFITEM_OK = 21010; //���������Ʒ�ɹ�
  SM_SENDBUYSELLOFFITEM_OK = 20010; //���������Ʒ�ɹ�
  RM_SENDBUYSELLOFFITEM_FAIL = 21011; //���������Ʒʧ��
  SM_SENDBUYSELLOFFITEM_FAIL = 20011; //���������Ʒʧ��
  RM_SENDBUYSELLOFFITEM = 41005; //����ѡ�������Ʒ
  CM_SENDBUYSELLOFFITEM = 4005; //����ѡ�������Ʒ
  RM_SENDQUERYSELLOFFITEM = 41006; //��ѯѡ�������Ʒ
  CM_SENDQUERYSELLOFFITEM = 4006; //��ѯѡ�������Ʒ
  RM_SENDSELLOFFITEM = 41004; //���ܼ�����Ʒ
  CM_SENDSELLOFFITEM = 4004; //���ܼ�����Ʒ
  RM_SENDUSERSELLOFFITEM_FAIL = 2007; //R = -3  ������Ʒʧ��
  RM_SENDUSERSELLOFFITEM_OK = 2006; //������Ʒ�ɹ�
  SM_SENDUSERSELLOFFITEM_FAIL = 20007; //R = -3  ������Ʒʧ��
  SM_SENDUSERSELLOFFITEM_OK = 20006; //������Ʒ�ɹ�
//==============================Ԫ������ϵͳ(20080316)==========================
  RM_SENDDEALOFFFORM = 23000;//�򿪳�����Ʒ����
  SM_SENDDEALOFFFORM = 23001;//�򿪳�����Ʒ����
  CM_SELLOFFADDITEM  = 23002;//�ͻ�����������Ʒ���������Ʒ
  SM_SELLOFFADDITEM_OK = 23003;//�ͻ�����������Ʒ���������Ʒ �ɹ�
  RM_SELLOFFADDITEM_OK = 23004;
  SM_SellOffADDITEM_FAIL=23005;//�ͻ�����������Ʒ���������Ʒ ʧ��
  RM_SellOffADDITEM_FAIL=23006;
  CM_SELLOFFDELITEM = 23007;//�ͻ���ɾ��������Ʒ�������Ʒ
  SM_SELLOFFDELITEM_OK = 23008;//�ͻ���ɾ��������Ʒ�������Ʒ �ɹ�
  RM_SELLOFFDELITEM_OK = 23009;
  SM_SELLOFFDELITEM_FAIL = 23010;//�ͻ���ɾ��������Ʒ�������Ʒ ʧ��
  RM_SELLOFFDELITEM_FAIL = 23011;
  CM_SELLOFFCANCEL = 23012;//�ͻ���ȡ��Ԫ������
  RM_SELLOFFCANCEL = 23013; // Ԫ������ȡ������
  SM_SellOffCANCEL = 23014;//Ԫ������ȡ������
  CM_SELLOFFEND    = 23015; //�ͻ���Ԫ�����۽���
  SM_SELLOFFEND_OK = 23016; //�ͻ���Ԫ�����۽��� �ɹ�
  RM_SELLOFFEND_OK = 23017;
  SM_SELLOFFEND_FAIL= 23018; //�ͻ���Ԫ�����۽��� ʧ��
  RM_SELLOFFEND_FAIL= 23019;
  RM_QUERYYBSELL = 23020;//��ѯ���ڳ��۵���Ʒ
  SM_QUERYYBSELL = 23021;//��ѯ���ڳ��۵���Ʒ
  RM_QUERYYBDEAL = 23022;//��ѯ���ԵĹ�����Ʒ
  SM_QUERYYBDEAL = 23023;//��ѯ���ԵĹ�����Ʒ
  CM_CANCELSELLOFFITEMING = 23024; //ȡ�����ڼ��۵���Ʒ 20080318(������)
  //SM_CANCELSELLOFFITEMING_OK =23018;//ȡ�����ڼ��۵���Ʒ �ɹ�
  CM_SELLOFFBUYCANCEL = 23025; //ȡ������ ��Ʒ���� 20080318(������)
  CM_SELLOFFBUY = 23026; //ȷ�����������Ʒ 20080318
  SM_SELLOFFBUY_OK =23027;//����ɹ�
  RM_SELLOFFBUY_OK =23028;
  //SM_SELLOFFBUY_FAIL =23029;//����ʧ��
  //RM_SELLOFFBUY_FAIL =23030;
//==============================================================================
  //Ӣ��
  ////////////////////////////////////////////////////////////////////////////////
  CM_RECALLHERO = 5000; //�ٻ�Ӣ��
  SM_RECALLHERO = 5001;
  CM_HEROLOGOUT = 5002; //Ӣ���˳�
  SM_HEROLOGOUT = 5003;
  SM_CREATEHERO = 5004; //����Ӣ��

  SM_HERODEATH = 5005;  //��������
  CM_HEROCHGSTATUS = 5006; //�ı�Ӣ��״̬
  CM_HEROATTACKTARGET = 5007; //Ӣ������Ŀ��
  CM_HEROPROTECT = 5008; //�ػ�Ŀ��
  CM_HEROTAKEONITEM = 5009;  //����Ʒ��
  CM_HEROTAKEOFFITEM = 5010; //�ر���Ʒ��
  CM_TAKEOFFITEMHEROBAG = 5011; //װ�����µ�Ӣ�۰���
  CM_TAKEOFFITEMTOMASTERBAG = 5012; //װ�����µ����˰���
  CM_SENDITEMTOMASTERBAG = 5013; //���˰�����Ӣ�۰���
  CM_SENDITEMTOHEROBAG = 5014; //Ӣ�۰��������˰���
  SM_HEROTAKEON_OK = 5015;
  SM_HEROTAKEON_FAIL = 5016;
  SM_HEROTAKEOFF_OK = 5017;
  SM_HEROTAKEOFF_FAIL = 5018;
  SM_TAKEOFFTOHEROBAG_OK = 5019;
  SM_TAKEOFFTOHEROBAG_FAIL = 5020;
  SM_TAKEOFFTOMASTERBAG_OK = 5021;
  SM_TAKEOFFTOMASTERBAG_FAIL = 5022;
  CM_HEROTAKEONITEMFORMMASTERBAG = 5023; //�����˰�����װ����Ӣ�۰���
  CM_TAKEONITEMFORMHEROBAG = 5024; //��Ӣ�۰�����װ�������˰���
  SM_SENDITEMTOMASTERBAG_OK = 5025; //���˰�����Ӣ�۰����ɹ�
  SM_SENDITEMTOMASTERBAG_FAIL = 5026; //���˰�����Ӣ�۰���ʧ��
  SM_SENDITEMTOHEROBAG_OK = 5027; //Ӣ�۰��������˰���
  SM_SENDITEMTOHEROBAG_FAIL = 5028; //Ӣ�۰��������˰���
  CM_QUERYHEROBAGCOUNT = 5029; //�鿴Ӣ�۰�������
  SM_QUERYHEROBAGCOUNT = 5030; //�鿴Ӣ�۰�������
  CM_QUERYHEROBAGITEMS = 5031; //�鿴Ӣ�۰���
  SM_SENDHEROUSEITEMS = 5032;  //����Ӣ������װ��
  SM_HEROBAGITEMS = 5033;     //����Ӣ����Ʒ
  SM_HEROADDITEM = 5034;  //Ӣ�۰��������Ʒ
  SM_HERODELITEM = 5035;  //Ӣ�۰���ɾ����Ʒ
  SM_HEROUPDATEITEM = 5036; //Ӣ�۰���������Ʒ
  SM_HEROADDMAGIC = 5037;   //���Ӣ��ħ��
  SM_HEROSENDMYMAGIC = 5038; //����Ӣ�۵�ħ��
  SM_HERODELMAGIC = 5039;   //ɾ��Ӣ��ħ��
  SM_HEROABILITY = 5040;   //Ӣ������1
  SM_HEROSUBABILITY = 5041;//Ӣ������2
  SM_HEROWEIGHTCHANGED = 5042;
  CM_HEROEAT = 5043;       //�Զ���
  SM_HEROEAT_OK = 5044;    //�Զ����ɹ�
  SM_HEROEAT_FAIL = 5045; //�Զ���ʧ��
  SM_HEROMAGIC_LVEXP = 5046;//ħ���ȼ�
  SM_HERODURACHANGE = 5047;  //Ӣ�۳־øı�
  SM_HEROWINEXP = 5048;    //Ӣ�����Ӿ���
  SM_HEROLEVELUP = 5049;  //Ӣ������
  SM_HEROCHANGEITEM = 5050; //����û���ϣ�
  SM_HERODELITEMS = 5051;   //ɾ��Ӣ����Ʒ
  CM_HERODROPITEM = 5052;   //Ӣ������������Ʒ
  SM_HERODROPITEM_SUCCESS = 5053;//Ӣ������Ʒ�ɹ�
  SM_HERODROPITEM_FAIL = 5054;  //Ӣ������Ʒʧ��
  CM_HEROGOTETHERUSESPELL = 5055; //ʹ�úϻ�
  SM_GOTETHERUSESPELL = 5056; //ʹ�úϻ�
  SM_FIRDRAGONPOINT = 5057;   //Ӣ��ŭ��ֵ
  CM_REPAIRFIRDRAGON = 5058;  //�޲�����֮��
  SM_REPAIRFIRDRAGON_OK = 5059; //�޲�����֮�ĳɹ�
  SM_REPAIRFIRDRAGON_FAIL = 5060; //�޲�����֮��ʧ��
//---------------------------------------------------
//ף����.ħ������� 20080102
  CM_REPAIRDRAGON = 5061;  //ף����.ħ�������
  SM_REPAIRDRAGON_OK = 5062; //�޲�ף����.ħ����ɹ�
  SM_REPAIRDRAGON_FAIL = 5063; //�޲�ף����.ħ���ʧ��
//----------------------------------------------------

  RM_RECALLHERO = 19999;   //�ٻ�Ӣ��
  RM_HEROWEIGHTCHANGED = 20000;
  RM_SENDHEROUSEITEMS = 20001;
  RM_SENDHEROMYMAGIC = 20002;
  RM_HEROMAGIC_LVEXP = 20003;
  RM_QUERYHEROBAGCOUNT = 20004;
  RM_HEROABILITY = 20005;
  RM_HERODURACHANGE = 20006;
  RM_HERODEATH = 20007;
  RM_HEROLEVELUP = 20008;
  RM_HEROWINEXP = 20009;
  //RM_HEROLOGOUT = 20010;
  RM_CREATEHERO = 20011;
  RM_MAKEGHOSTHERO = 20012;
  RM_HEROSUBABILITY = 20013;


  RM_GOTETHERUSESPELL = 20014; //ʹ�úϻ�
  RM_FIRDRAGONPOINT = 20015;  //����Ӣ��ŭ��ֵ
  RM_CHANGETURN = 20016;
  //-----------------------------------�����ػ�
  RM_FAIRYATTACKRATE = 20017;
  SM_FAIRYATTACKRATE = 20018;
  //-----------------------------------
  SM_SERVERUNBIND = 20019;
  RM_DESTROYHERO = 20020;//Ӣ������
  SM_DESTROYHERO = 20021;//Ӣ������

  ET_PROTECTION_STRUCK = 20022; //�����ܹ���  20080108
  ET_PROTECTION_PIP = 20023;  //���屻��
  
  SM_MYSHOW = 20024; //��ʾ������
  RM_MYSHOW = 20025; //

  RM_OPENBOXS = 20026;//�򿪱��� 20080115
  SM_OPENBOXS = 5064;//�򿪱��� 20080115
  CM_OPENBOXS = 20027;//�򿪱��� 20080115 �����
  CM_MOVEBOXS = 20028;//ת������ 20080117
  RM_MOVEBOXS = 20029;//ת������ 20080117
  SM_MOVEBOXS = 20030;//ת������ 20080117
  CM_GETBOXS  = 20031;//�ͻ���ȡ�ñ�����Ʒ 20080118
  SM_GETBOXS  = 20032;
  RM_GETBOXS  = 20033;
  SM_OPENBOOKS  = 20034; //������NPC 20080119
  RM_OPENBOOKS  = 20035;
  RM_DRAGONPOINT = 20036;  //���ͻ�����ֵ 20080201
  SM_DRAGONPOINT = 20037;
  ET_OBJECTLEVELUP = 20038; //��������������ʾ 20080222
  RM_CHANGEATTATCKMODE = 20039; //�ı乥��ģʽ 20080228
  SM_CHANGEATTATCKMODE = 20040; //�ı乥��ģʽ 20080228
  CM_EXCHANGEGAMEGIRD = 20042; //���̶һ����  20080302
  SM_EXCHANGEGAMEGIRD_FAIL = 20043;//���̹�����Ʒʧ��
  SM_EXCHANGEGAMEGIRD_SUCCESS = 20044;
  RM_EXCHANGEGAMEGIRD_FAIL = 20045;
  RM_EXCHANGEGAMEGIRD_SUCCESS = 20046;
  RM_OPENDRAGONBOXS = 20047; //���������� 20080306
  SM_OPENDRAGONBOXS = 20048; //���������� 20080306
// SM_OPENBOXS_OK = 20047; //�򿪱���ɹ� 20080306
  RM_OPENBOXS_FAIL = 20049; //�򿪱���ʧ�� 20080306
  SM_OPENBOXS_FAIL = 20050; //�򿪱���ʧ�� 20080306

  RM_EXPTIMEITEMS = 20051;  //������ ����ʱ��ı���Ϣ 20080306
  SM_EXPTIMEITEMS = 20052;  //������ ����ʱ��ı���Ϣ 20080306

  ET_OBJECTBUTCHMON = 20053; //������ʬ��õ���Ʒ��ʾ 20080325

  //RM_CLOSEDRAGONPOINT = 20054;  //�ر���Ӱ���� 20080329
  //SM_CLOSEDRAGONPOINT = 20055;  //�ر���Ӱ���� 20080329
//---------------------------����ϵͳ------------------------------------------
  RM_QUERYREFINEITEM = 20056; //�򿪴������
  SM_QUERYREFINEITEM = 20057; //�򿪴������
  CM_REFINEITEM = 20058;//�ͻ��˷��ʹ�����Ʒ 20080507

  SM_UPDATERYREFINEITEM = 20059; //���´�����Ʒ 20080507
  CM_REPAIRFINEITEM = 20060; //�޲�����ʯ 20080507 20080507
  SM_REPAIRFINEITEM_OK = 20061; //�޲�����ʯ�ɹ�  20080507
  SM_REPAIRFINEITEM_FAIL = 20062; //�޲�����ʯʧ��  20080507
//-----------------------------------------------------------------------------
  RM_DAILY = 20063;//���ս��� 20080511
  SM_DAILY = 20064;//���ս��� 20080511
  RM_GLORY = 20065;//���͵��ͻ��� ����ֵ 20080511
  SM_GLORY = 20066;//���͵��ͻ��� ����ֵ 20080511

  RM_GETHEROINFO = 20067;
  SM_GETHEROINFO = 20068; //���Ӣ������
  CM_SELGETHERO  = 20069; //ȡ��Ӣ��
  RM_SENDUSERPLAYDRINK = 20070;//������ƶԻ��� 20080515
  SM_SENDUSERPLAYDRINK = 20071;//������ƶԻ��� 20080515
  CM_USERPLAYDRINKITEM = 20072;//��ƿ������Ʒ���͵�M2
  SM_USERPLAYDRINK_OK = 20073;  //��Ƴɹ�  20080515
  SM_USERPLAYDRINK_FAIL = 20074; //���ʧ�� 20080515
  RM_PLAYDRINKSAY = 20075;//
  SM_PLAYDRINKSAY = 20076;
  CM_PlAYDRINKDLGSELECT = 20077; //��Ʒѡ��,����
  RM_OPENPLAYDRINK = 20078;   //�򿪴���
  SM_OPENPLAYDRINK = 20079;   //�򿪴���
  CM_PlAYDRINKGAME = 20080;  //���Ͳ�ȭ���� 20080517
  RM_PlayDrinkToDrink = 20081; //���͵��ͻ���˭Ӯ˭��
  SM_PlayDrinkToDrink = 20082; //
  CM_DrinkUpdateValue = 20083; //���ͺȾ�
  RM_DrinkUpdateValue = 20084; //���غȾ�
  SM_DrinkUpdateValue = 20085; //���غȾ�
  RM_CLOSEDRINK = 20086;//�رն��ƣ���ƴ���
  SM_CLOSEDRINK = 20087;//�رն��ƣ���ƴ���
  CM_USERPLAYDRINK = 20088; //�ͻ��˷��������Ʒ
  SM_USERPLAYDRINKITEM_OK = 20089;  //�����Ʒ�ɹ�
  SM_USERPLAYDRINKITEM_FAIL = 20090; //�����Ʒʧ��
  RM_Browser = 20091;//����ָ����վ
  SM_Browser = 20092;

  RM_PIXINGHIT = 20093;//����նЧ�� 20080611
  SM_PIXINGHIT = 20094;

  RM_LEITINGHIT = 20095;//����һ��Ч�� 20080611
  SM_LEITINGHIT = 20096;

  CM_CHECKNUM = 20097;//�����֤�� 20080612
  SM_CHECKNUM_OK = 20098;
  CM_CHANGECHECKNUM = 20099;

  RM_AUTOGOTOXY = 20100;//�Զ�Ѱ·
  SM_AUTOGOTOXY = 20101;
//-----------------------���ϵͳ---------------------------------------------
  RM_OPENMAKEWINE =20102;//����ƴ���
  SM_OPENMAKEWINE =20103;//����ƴ���
  CM_BEGINMAKEWINE = 20104;//��ʼ���(���Ѳ���ȫ���ϴ���)
  RM_MAKEWINE_OK = 20105;//��Ƴɹ�
  SM_MAKEWINE_OK = 20106;//��Ƴɹ�
  RM_MAKEWINE_FAIL = 20107;//���ʧ��
  SM_MAKEWINE_FAIL = 20108;//���ʧ��
  RM_NPCWALK = 20109;//���NPC�߶�
  SM_NPCWALK = 20110;//���NPC�߶�
  RM_MAGIC68SKILLEXP = 20111;//�������弼�ܾ���
  SM_MAGIC68SKILLEXP = 20112;//�������弼�ܾ���
//------------------------��սϵͳ--------------------------------------------
  SM_CHALLENGE_FAIL = 20113;//��սʧ��
  SM_CHALLENGEMENU =20114;//����ս��Ѻ��Ʒ����
  CM_CHALLENGETRY = 20115;//��ҵ���ս

  CM_CHALLENGEADDITEM = 20116;//��Ұ���Ʒ�ŵ���ս����
  SM_CHALLENGEADDITEM_OK = 20117;//������ӵ�Ѻ��Ʒ�ɹ�
  SM_CHALLENGEADDITEM_FAIL = 20118;//������ӵ�Ѻ��Ʒʧ��
  SM_CHALLENGEREMOTEADDITEM = 20119;//�������ӵ�Ѻ����Ʒ��,���ͻ�����ʾ

  CM_CHALLENGEDELITEM = 20120;//��Ҵ���ս����ȡ����Ʒ
  SM_CHALLENGEDELITEM_OK= 20121;//���ɾ����Ѻ��Ʒ�ɹ�
  SM_CHALLENGEDELITEM_FAIL = 20122;//���ɾ����Ѻ��Ʒʧ��
  SM_CHALLENGEREMOTEDELITEM = 20123;//����ɾ����Ѻ����Ʒ��,���ͻ�����ʾ

  CM_CHALLENGECANCEL = 20124;//���ȡ����ս
  SM_CHALLENGECANCEL = 20125;//���ȡ����ս

  CM_CHALLENGECHGGOLD = 20126; //�ͻ��˰ѽ�ҷŵ���ս����
  SM_CHALLENCHGGOLD_FAIL = 20127; //�ͻ��˰ѽ�ҷŵ���ս����ʧ��
  SM_CHALLENCHGGOLD_OK = 20128; //�ͻ��˰ѽ�ҷŵ���ս���гɹ�
  SM_CHALLENREMOTECHGGOLD = 20129; //�ͻ��˰ѽ�ҷŵ���ս����,���ͻ�����ʾ

  CM_CHALLENGECHGDIAMOND = 20130; //�ͻ��˰ѽ��ʯ�ŵ���ս����
  SM_CHALLENCHGDIAMOND_FAIL = 20131; //�ͻ��˰ѽ��ʯ�ŵ���ս����ʧ��
  SM_CHALLENCHGDIAMOND_OK = 20132; //�ͻ��˰ѽ��ʯ�ŵ���ս���гɹ�
  SM_CHALLENREMOTECHGDIAMOND = 20133; //�ͻ��˰ѽ��ʯ�ŵ���ս����,���ͻ�����ʾ

  CM_CHALLENGEEND = 20134;//��ս��Ѻ��Ʒ����
  SM_CLOSECHALLENGE = 20135;//�ر���ս��Ѻ��Ʒ����
//----------------------------------------------------------------------------
  RM_PLAYMAKEWINEABILITY = 20136;//��2������� 20080804
  SM_PLAYMAKEWINEABILITY = 20137;//��2������� 20080804
  RM_HEROMAKEWINEABILITY = 20138;//��2������� 20080804
  SM_HEROMAKEWINEABILITY = 20139;//��2������� 20080804

  RM_CANEXPLORATION = 20140;//��̽�� 20080810
  SM_CANEXPLORATION = 20141;//��̽�� 20080810
//----------------------------------------------------------------------------
  SM_SENDLOGINKEY = 20142; //���ظ��ͻ��˻��½�����͵�½������� 20080901
  SM_GATEPASS_FAIL = 20143; //�����ص��������

  RM_HEROMAGIC68SKILLEXP = 20144;//Ӣ�۾������弼�ܾ���  20080925
  SM_HEROMAGIC68SKILLEXP = 20145;//Ӣ�۾������弼�ܾ���  20080925

  RM_USERBIGSTORAGEITEM = 20146;//�û����޲ֿ���Ŀ
  RM_USERBIGGETBACKITEM = 20147;//�û���ûص����޲ֿ���Ŀ
  RM_USERLEVELORDER = 20148;//�û��ȼ�����

  RM_HEROAUTOOPENDEFENCE = 20149;//Ӣ���ڹ��Զ��������� 20080930
  SM_HEROAUTOOPENDEFENCE = 20150;//Ӣ���ڹ��Զ��������� 20080930
  CM_HEROAUTOOPENDEFENCE = 20151;//Ӣ���ڹ��Զ��������� 20080930

  RM_MAGIC69SKILLEXP = 20152;//�ڹ��ķ�����
  SM_MAGIC69SKILLEXP = 20153;//�ڹ��ķ�����
  RM_HEROMAGIC69SKILLEXP = 20154;//Ӣ���ڹ��ķ�����  20080930
  SM_HEROMAGIC69SKILLEXP = 20155;//Ӣ���ڹ��ķ�����  20080930

  RM_MAGIC69SKILLNH = 20156;//����ֵ(����) 20081002
  SM_MAGIC69SKILLNH = 20157;//����ֵ(����) 20081002
  {RM_HEROMAGIC69SKILLNH = 20158;//Ӣ������ֵ(����) 20081002
  SM_HEROMAGIC69SKILLNH = 20159;//Ӣ������ֵ(����) 20081002  }
  RM_WINNHEXP = 20158;//ȡ���ڹ����� 20081007
  SM_WINNHEXP = 20159;//ȡ���ڹ����� 20081007
  RM_HEROWINNHEXP = 20160;//Ӣ��ȡ���ڹ����� 20081007
  SM_HEROWINNHEXP = 20161;//Ӣ��ȡ���ڹ����� 20081007
  ////////////////////////////////////////////////////////////////////////////////
  UNITX = 48;
  UNITY = 32;
  HALFX = 24;
  HALFY = 16;
  //MAXBAGITEM = 46; //�û������������
  //MAXMAGIC = 30{20}; //ԭ��54; 200081227 ע��
  MAXSTORAGEITEM = 50;
  LOGICALMAPUNIT = 40;
type
  TMonStatus = (s_KillHuman, s_UnderFire, s_Die, s_MonGen);
  TMsgColor = (c_Red, c_Green, c_Blue, c_White, c_Fuchsia{ǧ�ﴫ����ɫ},BB_Fuchsia{���������ʾ},C_HeroHint{Ӣ��״̬});
  TMsgType = (t_Notice{����}, t_Hint{��ʾ}, t_System{ϵͳ}, t_Say, t_Mon, t_GM, t_Cust, t_Castle{�Ǳ�});
  TDefaultMessage = record
    Recog: Integer;//ʶ����
    Ident: Word;
    Param: Word;
    Tag: Word;
    Series: Word;
    nSessionID: Integer;//�ͻ��˻ỰID 20081210
  end;
  pTDefaultMessage = ^TDefaultMessage;

  TItemType = (i_HPDurg,i_MPDurg,i_HPMPDurg,i_OtherDurg,i_Weapon,i_Dress,i_Helmet,i_Necklace,i_Armring,i_Ring,i_Belt,i_Boots,i_Charm,i_Book,i_PosionDurg,i_UseItem,i_Scroll,i_Stone,i_Gold,i_Other);
                              //  [ҩƷ] [����]      [�·�]    [ͷ��][����]     [����]      [��ָ] [����] [Ь��] [��ʯ]         [������][��ҩ]        [����Ʒ][����]
  TShowItem = record
    sItemName    :String;
   // ItemType     :TItemType;
    boAutoPickup :Boolean;
    boShowName   :Boolean;
    //nFColor      :Integer;
    //nBColor      :Integer;
  end;
  pTShowItem = ^TShowItem;


  TOSObject = record
    btType: Byte;
    CellObj: TObject;
    dwAddTime: LongWord;
    boObjectDisPose: Boolean;
  end;
  pTOSObject = ^TOSObject;

  TSendMessage = record
    wIdent: Word;
    wParam: Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    BaseObject: TObject;
    dwAddTime: LongWord;
    dwDeliveryTime: LongWord;
    boLateDelivery: Boolean;
    Buff: PChar;
  end;
  pTSendMessage = ^TSendMessage;

  TProcessMessage = record
    wIdent: Word;
    wParam: Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    BaseObject: TObject;
    boLateDelivery: Boolean;
    dwDeliveryTime: LongWord;
    sMsg: string;
  end;
  pTProcessMessage = ^TProcessMessage;

  TLoadHuman = record
    sAccount: string[12];
    sChrName: string[ACTORNAMELEN]; //14
    sUserAddr: string[15];
    nSessionID: Integer;
  end;

  TShortMessage = record
    Ident: Word;
    wMsg: Word;
  end;

  TMessageBodyW = record
    Param1: Word;
    Param2: Word;
    Tag1: Word;
    Tag2: Word;
  end;

  TMessageBodyWL = record
    lParam1: Integer;
    lParam2: Integer;
    lTag1: Integer;
    lTag2: Integer;
  end;

  TCharDesc = record
    feature: Integer;
    Status: Integer;
  end;

  TSessInfo = record //ȫ�ֻỰ
    sAccount: string[12];
    sIPaddr: string[15];
    nSessionID: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    nSessionStatus: Integer;
    dwStartTick: LongWord;
    dwActiveTick: LongWord;
    nRefCount: Integer;
  end;
  pTSessInfo = ^TSessInfo;

  TQuestInfo = record
    wFlag: Word;
    btValue: Byte;
    nRandRage: Integer;
  end;
  pTQuestInfo = ^TQuestInfo;

  TScript = record
    boQuest: Boolean;
    QuestInfo: array[0..9] of TQuestInfo;
    nQuest: Integer;
    RecordList: TList;
  end;
  pTScript = ^TScript;

  TMonItem = record
    n00: Integer;
    n04: Integer;
    sMonName: string;
    n18: Integer;
  end;
  pTMonItem = ^TMonItem;

  TItemName = record
    nItemIndex: Integer;
    nMakeIndex: Integer;
    sItemName: string;
  end;
  pTItemName = ^TItemName;

  TVarType = (vNone, vInteger, vString);

  TDynamicVar = record
    sName: string;
    VarType: TVarType;
    nInternet: Integer;
    sString: string;
  end;
  pTDynamicVar = ^TDynamicVar;

  TRecallMigic = record
    nHumLevel: Integer;
    sMonName: string;
    nCount: Integer;
    nLevel: Integer;
  end;

  TMonSayMsg = record
    nRate: Integer;
    sSayMsg: string;
    State: TMonStatus;
    Color: TMsgColor;
  end;
  pTMonSayMsg = ^TMonSayMsg;

  TMonDrop = record
    sItemName: string;
    nDropCount: Integer;
    nNoDropCount: Integer;
    nCountLimit: Integer;
  end;
  pTMonDrop = ^TMonDrop;

  TGameCmd = record
    sCmd: string[25];
    nPermissionMin: Integer;
    nPermissionMax: Integer;
  end;
  pTGameCmd = ^TGameCmd;

  TIPAddr = record
    dIPaddr: string[15];
    sIPaddr: string[15];
  end;
  pTIPAddr = ^TIPAddr;

  TSrvNetInfo = record
    sIPaddr: string[15];
    nPort: Integer;
  end;
  pTSrvNetInfo = ^TSrvNetInfo;

  TCheckCode = record
  end;

  TStdItem = packed record
    Name: string[14];//��Ʒ����
    StdMode: Byte; //��Ʒ���� 0/1/2/3��ҩ�� 5/6:������10/11�����ף�15��ͷ����22/23����ָ��24/26������19/20/21������
    Shape: Byte;//װ�����
    Weight: Byte;//����
    AniCount: Byte;
    Source: ShortInt;//Դ����
    Reserved: Byte; //����
    NeedIdentify: Byte; //��Ҫ��¼��־
    Looks: Word; //��ۣ���Items.WIL�е�ͼƬ����
    DuraMax: Word; //���־�
    Reserved1: Word;//��������
    AC: Integer; //0x1A
    MAC: Integer; //0x1C
    DC: Integer; //0x1E
    MC: Integer; //0x20
    SC: Integer; //0x22
    Need: Integer; //0x24
    NeedLevel: Integer; //0x25
    Price: Integer; //�۸�
    //Stock: Integer;//��� 20080610
    //sDesc:string[80];//��Ʒ˵�� 20080619
  end;
  pTStdItem = ^TStdItem;

  TOStdItem = packed record //OK
    Name: string[14];
    StdMode: Byte;
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: ShortInt;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks: Word;
    DuraMax: Word;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    Need: Byte;
    NeedLevel: Byte;
    w26: Word;
    Price: Integer;
  end;
  pTOStdItem = ^TOStdItem;

  TOClientItem = record //OK
    s: TOStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;
  end;
  pTOClientItem = ^TOClientItem;

  TClientItem = record //OK
    s: TStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;
  end;
  PTClientItem = ^TClientItem;

  TMonInfo = record
    sName: string[14];//������
    btRace: Byte;//����
    btRaceImg: Byte;//����ͼ��
    wAppr: Word;//�������
    wLevel: Word;
    btLifeAttrib: Byte;//����ϵ
    boUndead: Boolean;
    wCoolEye: Word;//���߷�Χ
    dwExp: LongWord;
    wMP: Word;
    wHP: Word;
    wAC: Word;
    wMAC: Word;
    wDC: Word;
    wMaxDC: Word;
    wMC: Word;
    wSC: Word;
    wSpeed: Word;
    wHitPoint: Word;//������
    wWalkSpeed: Word;//�����ٶ�
    wWalkStep: Word;//���߲���
    wWalkWait: Word;//���ߵȴ�
    wAttackSpeed: Word;//�����ٶ�
    ItemList: TList;
  end;
  pTMonInfo = ^TMonInfo;

  TMagic = record //������
    wMagicId: Word;//����ID
    sMagicName: string[12];//��������
    btEffectType: Byte;//����Ч��
    btEffect: Byte;//ħ��Ч��
    bt11: Byte;//δʹ�� 20080531
    wSpell: Word;//ħ������
    wPower: Word;//��������
    TrainLevel: array[0..3] of Byte;//���ܵȼ�
    w02: Word;//δʹ�� 20080531
    MaxTrain: array[0..3] of Integer;//�����ܵȼ����������
    btTrainLv: Byte;//�����ȼ�
    btJob: Byte;//ְҵ 0-ս 1-�� 2-�� 3-�̿�
    wMagicIdx: Word;//δʹ�� 20080531
    dwDelayTime: LongWord;//������ʱ
    btDefSpell: Byte;//����ħ��
    btDefPower: Byte;//��������
    wMaxPower: Word;//�������
    btDefMaxPower: Byte;//�����������
    sDescr: string[18];//��ע˵��
  end;
  pTMagic = ^TMagic;

  TClientMagic = record //84
    Key: Char;
    Level: Byte;
    CurTrain: Integer;
    Def: TMagic;
  end;
  PTClientMagic = ^TClientMagic;

  TShopInfo = record//������Ʒ
    StdItem: TSTDITEM;
    sIntroduce:array [0..200] of Char;
    Idx: string[1];
    ImgBegin: string[5];
    Imgend: string[5];
    Introduce1:string[20];
  end;
  pTShopInfo = ^TShopInfo;

  TUserMagic = record
    MagicInfo: pTMagic;
    wMagIdx: Word;//����ID
    btLevel: Byte;//�ȼ�
    btKey: Byte;//���ܿ�ݼ�
    nTranPoint: Integer;//��ǰ����ֵ
  end;
  pTUserMagic = ^TUserMagic;

  TMinMap = record
    sName: string;
    nID: Integer;
  end;
  pTMinMap = ^TMinMap;

  TMapRoute = record
    sSMapNO: string;
    nDMapX: Integer;
    nSMapY: Integer;
    sDMapNO: string;
    nSMapX: Integer;
    nDMapY: Integer;
  end;
  pTMapRoute = ^TMapRoute;

  TMapInfo = record
    sName: string;
    sMapNO: string;
    nL: Integer; //0x10
    nServerIndex: Integer; //0x24
    nNEEDONOFFFlag: Integer; //0x28
    boNEEDONOFFFlag: Boolean; //0x2C
    sShowName: string; //0x4C
    sReConnectMap: string; //0x50
    boSAFE: Boolean; //0x51
    boDARK: Boolean; //0x52
    boFIGHT: Boolean; //0x53
    boFIGHT3: Boolean; //0x54
    boDAY: Boolean; //0x55
    boQUIZ: Boolean; //0x56
    boNORECONNECT: Boolean; //0x57
    boNEEDHOLE: Boolean; //0x58
    boNORECALL: Boolean; //0x59
    boNORANDOMMOVE: Boolean; //0x5A
    boNODRUG: Boolean; //0x5B
    boMINE: Boolean; //0x5C
    boNOPOSITIONMOVE: Boolean; //0x5D
  end;
  pTMapInfo = ^TMapInfo;

  TUnbindInfo = record
    nUnbindCode: Integer;
    sItemName: string[14];
  end;
  pTUnbindInfo = ^TUnbindInfo;

  TQuestDiaryInfo = record
    QDDinfoList: TList;
  end;
  pTQuestDiaryInfo = ^TQuestDiaryInfo;

  TAdminInfo = record //����Ա��
    nLv: Integer;
    sChrName: string[ACTORNAMELEN];
    sIPaddr: string[15];
  end;
  pTAdminInfo = ^TAdminInfo;

  TMasterList = record //ͽ����������  20080530
    ID:integer;//����
    sChrName: string[ACTORNAMELEN];//ͽ����
  end;
  pTMasterList = ^TMasterList;

  THumMagic = record //���＼��  20080106
    wMagIdx: Word;//����ID
    btLevel: Byte;//�ȼ�
    btKey: Byte;//���ܿ�ݼ�
    nTranPoint: Integer; //��ǰ����ֵ
  end;
  pTHumMagic = ^THumMagic;

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

  TAbility = packed record//Size 40
    Level: Word; //
    AC: Integer; //����
    MAC: Integer; //ħ��
    DC: Integer; //������
    MC: Integer; //ħ��
    SC: Integer; //����
    HP: Word; //
    MP: Word; //
    MaxHP: Word; //
    MaxMP: Word; //
    Exp: LongWord; //
    MaxExp: LongWord; //
    Weight: Word; //
    MaxWeight: Word; // ����
    WearWeight: Word; //
    MaxWearWeight: Word; //����
    HandWeight: Word; //
    MaxHandWeight: Word; //����
    Alcohol:Word;//���� 20080622
    MaxAlcohol:Word;//�������� 20080622
    WineDrinkValue: Word;//��ƶ� 20080623
    MedicineValue: Word;//��ǰҩ��ֵ 20080623
    MaxMedicineValue: Word;//ҩ��ֵ���� 20080623
  end;
  pTAbility = ^TAbility;

  TOAbility = packed record
    Level: Word; //�ȼ�
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    HP: Word;
    MP: Word;
    MaxHP: Word;
    MaxMP: Word;
    {btReserved1: Byte;//20081001 ע��
    btReserved2: Byte;
    btReserved3: Byte;
    btReserved4: Byte;}
    NG: Word;//20081001 ��ǰ����ֵ
    MaxNG: Word;//20081001 ����ֵ����
    Exp: LongWord;//��ǰ����
    MaxExp: LongWord;//��������
    Weight: Word;
    MaxWeight: Word; //�������
    WearWeight: Byte;
    MaxWearWeight: Byte; //�����
    HandWeight: Byte;
    MaxHandWeight: Byte; //����
  end;
  pTOAbility = ^TOAbility;

  TAddAbility = record //OK    //Size 40
    wHP: Word;
    wMP: Word;
    wHitPoint: Word;
    wSpeedPoint: Word;
    wAC: Integer;//����
    wMAC: Integer;//ħ��
    wDC: Integer;
    wMC: Integer;
    wSC: Integer;
    bt1DF: Byte; //��ʥ
    bt035: Byte;
    wAntiPoison: Word;
    wPoisonRecover: Word;
    wHealthRecover: Word;
    wSpellRecover: Word;
    wAntiMagic: Word;
    btLuck: Byte;//����
    btUnLuck: Byte;//����
    nHitSpeed: Integer;
    btWeaponStrong: Byte;//ǿ��
    wWearWeight: Word;//���� 20080325
  end;
  pTAddAbility = ^TAddAbility;

  TWAbility = record
    dwExp: LongWord; //���ﾭ��ֵ(Dword)
    wHP: Word;
    wMP: Word;
    wMaxHP: Word;
    wMaxMP: Word
  end;

  TMerchantInfo = record
    sScript: string[14];
    sMapName: string[14];
    nX: Integer;
    nY: Integer;
    sNPCName: string[40];
    nFace: Integer;
    nBody: Integer;
    boCastle: Boolean;
  end;
  pTMerchantInfo = ^TMerchantInfo;

  TSocketBuff = record
    Buffer: PChar; //0x24
    nLen: Integer; //0x28
  end;
  pTSocketBuff = ^TSocketBuff;

  TSendBuff = record
    nLen: Integer;
    Buffer: array[0..DATA_BUFSIZE - 1] of Char;
  end;
  pTSendBuff = ^TSendBuff;

  TUserItem = record // 20080313 �޸�
    MakeIndex: Integer;
    wIndex: Word; //��Ʒid
    Dura: Word; //��ǰ�־�ֵ
    DuraMax: Word; //���־�ֵ
    btValue: array[0..20] of Byte;//��������:9-(��������)װ���ȼ� 12-����(1Ϊ����,0������,2�����鲻�ܾۼ�),13-�Զ�������,14-��ֹ��,15-��ֹ����,16-��ֹ��,17-��ֹ��,18-��ֹ����,19-��ֹ���� 20-����(������,1-��ʼ�۾���,2-�۽���)
  end ;                           //11-δʹ�� 8-������Ʒ 10-������������(1-���� 10-12����DC, 20-22����MC��30-32����SC)
  pTUserItem = ^TUserItem;
 //(��ָ)          0 AC2 ����  1 MAC2 ħ�� 2 DC2 ���� 3 MC2 ħ�� 4 SC2 ���� 6 ������� 7 ������� 8 Reserved 9-13 �ݲ�֪�� 14 �־�
 //(����)          0 DC2 1 MC2 2 SC2 3 ���� 4 ���� 5 ׼ȷ 6 �����ٶ� 7 ǿ�� 8-9 �ݲ�֪�� 10 �迪�� 11-13 �ݲ�֪�� 14 �־�
 //(�·�,ѥ��,����)0 ���� 1 ħ�� 2 ���� 3 ħ�� 4 ���� 5-13 ��Ч�� 14 �־�
 //(ͷ��)          0 ���� 1 ħ�� 2 ���� 3 ħ�� 4 ���� 5 ������� 6 ������� 7-13 ��Ч�� 14 �־�
 //(����,����)     0 AC2 1 MAC2 2 DC2 3 MC2 4 SC2 6 ������� 7 ������� 8 Reserved 9-13 �ݲ�֪�� 14 �־�
 //��              0 Ʒ�� 1 �ƾ��� 2 ҩ��ֵ
 //��Ʋ���        0 Ʒ��
  TMonItemInfo = record //���ﱬ��Ʒ��(MonItemsĿ¼��,����.txt)
    SelPoint: Integer;//���ֵ���
    MaxPoint: Integer;//�ܵ���
    ItemName: string;//��Ʒ����
    Count: Integer;//��Ʒ����
  end;
  pTMonItemInfo = ^TMonItemInfo;

  TMonsterInfo = record
    Name: string;
    ItemList: TList;
  end;
  PTMonsterInfo = ^TMonsterInfo;

  TMapItem = record //��ͼ��Ʒ
    Name: string;//����
    Looks: Word; //���
    AniCount: Byte;
    Reserved: Byte;
    Count: Integer;//����
    OfBaseObject: TObject;//��Ʒ˭���Լ���
    DropBaseObject: TObject;//˭�����
    dwCanPickUpTick: LongWord;
    UserItem: TUserItem;
  end;
  PTMapItem = ^TMapItem;

  TVisibleMapItem = record //�ɼ��ĵ�ͼ��Ʒ
    {wIdent: Word;
    nParam1: Integer;
    Buff: PChar;}
    MapItem: PTMapItem;
    nVisibleFlag: Integer;
    nX: Integer;
    nY: Integer;
    sName: string;
    wLooks: Word;
  end;
  pTVisibleMapItem = ^TVisibleMapItem;

  TVisibleMapEvent = record
    MapEvent: TObject;
    nVisibleFlag: Integer;
    nX: Integer;
    nY: Integer;
  end;
  pTVisibleMapEvent = ^TVisibleMapEvent;

  TVisibleBaseObject = record
    BaseObject: TObject;
    nVisibleFlag: Integer;
  end;
  pTVisibleBaseObject = ^TVisibleBaseObject;

  THumanRcd = record
    sUserID: string[10];
    sCharName: string[14];
    btJob: Byte;
    btGender: Byte;
    btLevel: Byte;
    btHair: Byte;
    sMapName: string[16];
    btAttackMode: Byte;
    btIsAdmin: Byte;
    nX: Integer;
    nY: Integer;
    nGold: Integer;
    dwExp: LongWord;
  end;
  pTHumanRcd = ^THumanRcd;

  TObjectFeature = record
    btGender: Byte;
    btWear: Byte;
    btHair: Byte;
    btWeapon: Byte;
  end;
  pTObjectFeature = ^TObjectFeature;

  TStatusInfo = record
    nStatus: Integer;
    dwStatusTime: LongWord;
    sm218: SmallInt;
    dwTime220: LongWord;
  end;

  TMsgHeader = record
    dwCode: LongWord;
    nSocket: Integer;
    wGSocketIdx: Word;
    wIdent: Word;
    wUserListIndex: Integer;
    nLength: Integer;
  end;
  pTMsgHeader = ^TMsgHeader;

  TUserInfo = record
    bo00: Boolean; //0x00
    bo01: Boolean; //0x01 ?
    bo02: Boolean; //0x02 ?
    bo03: Boolean; //0x03 ?
    n04: Integer; //0x0A ?
    n08: Integer; //0x0B ?
    bo0C: Boolean; //0x0C ?
    bo0D: Boolean; //0x0D
    bo0E: Boolean; //0x0E ?
    bo0F: Boolean; //0x0F ?
    n10: Integer; //0x10 ?
    n14: Integer; //0x14 ?
    n18: Integer; //0x18 ?
    sStr: string[20]; //0x1C
    nSocket: Integer; //0x34
    nGateIndex: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40 ?
    n44: Integer; //0x44
    List48: TList; //0x48
    Cert: TObject; //0x4C
    dwTime50: LongWord; //0x50
    bo54: Boolean; //0x54
  end;
  pTUserInfo = ^TUserInfo;

  TGlobaSessionInfo = record
    sAccount: string;//��¼�˺�
    sIPaddr: string;//IP��ַ
    nSessionID: Integer;//�ỰID
    n24: Integer;
    bo28: Boolean;
    boLoadRcd: Boolean;//�Ƿ��ȡ
    boStartPlay: Boolean;//�Ƿ�ʼ��Ϸ
    dwAddTick: LongWord;//�����б��ʱ��
    dAddDate: TDateTime;//�����б������
  end;
  pTGlobaSessionInfo = ^TGlobaSessionInfo;

  TUserStateInfo = record
    feature: Integer;
    UserName: string[ACTORNAMELEN];
    NAMECOLOR: Integer;
    GuildName: string[ACTORNAMELEN];
    GuildRankName: string[16];
    UseItems: array[0..13] of TClientItem;//20080417 ֧�ֶ���,0..12��0..13
  end;
  pTUserStateInfo = ^TUserStateInfo;

  TSellOffHeader = record
    nItemCount: Integer;
  end;
//------------------------------------------------------------------------------
  TBoxsInfo = record //�������ݽṹ
    SBoxsID:Integer;//�����ļ�
    nItemNum: Integer;//��Ʒ����
    nItemType: Integer;//��Ʒ����
    OpenBox: Boolean;//�Ƿ������(1Ϊ����)
    nGold: Integer;//��ʼ���
    nGameGold: Integer;//��ʼԪ��(��Ϸ��)
    nIncGold: Integer;//�������
    nIncGameGold: Integer;//����Ԫ��(��Ϸ��)
    nEffectiveGold: Integer;//��Ч�����
    nEffectiveGameGold: Integer;//��ЧԪ��(��Ϸ��)��
    nUses: Integer;//�������ʹ��ת�̴���
    StdItem: TClientItem;
  end;
  pTBoxsInfo = ^TBoxsInfo;
//------------------------------------------------------------------------------
  TSuitItem = packed record //��װ���ݽṹ  20080225
    ItemCount: Byte; //��װ��Ʒ����
    Note: String[30];//˵��
    Name: String;//��Ʒ����
    MaxHP: Word;//HP����
    MaxMP: Word;//MP����
    DC: Word;//������
    MaxDC: Word;
    MC: Word;//ħ��
    MaxMC: Word;
    SC: Word;//����
    MaxSC: Word;
    AC: Integer; //����
    MaxAC: Integer;
    MAC: Word; //ħ��
    MaxMAC: Word;
    HitPoint: Byte;//׼ȷ��
    SpeedPoint: Byte;//���ݶ�
    HealthRecover: ShortInt; //�����ָ�
    SpellRecover: ShortInt; //ħ���ָ�
    RiskRate: Integer; //���ʻ���
    btReserved: Byte; //��Ѫ(����)
    btReserved1: Byte; //����
    btReserved2: Byte; //����
    btReserved3: Byte; //����
    nEXPRATE: Integer;//���鱶��
    nPowerRate: Byte;//��������
    nMagicRate: Byte;//ħ������
    nSCRate: Byte;//��������
    nACRate: Byte;//��������
    nMACRate: Byte;//ħ������
    nAntiMagic: ShortInt; //ħ�����
    nAntiPoison: Byte; //������
    nPoisonRecover: ShortInt; //�ж��ָ�

    boTeleport : Boolean;//����  20080824
    boParalysis : Boolean;//���
    boRevival : Boolean;//����
    boMagicShield : Boolean;//����
    boUnParalysis : Boolean;//�����
  end;
  pTSuitItem = ^TSuitItem;
//------------------------------------------------------------------------------
  TDealOffInfo = packed record //   Ԫ���������ݽṹ  20080316
    sDealCharName: string[ACTORNAMELEN];//������
    sBuyCharName: string[ACTORNAMELEN];//������
    dSellDateTime: TDateTime;//����ʱ��
    nSellGold: Integer;//���׵�Ԫ����
    UseItems: array[0..9] of TUserItem;//��Ʒ
    N: Byte;//����ʶ�� 0-���� 1-����,��������δ�õ�Ԫ�� 2-������ȡ�� 3-���׽���(�õ�Ԫ��) 4-���ڲ�����
  end;
  pTDealOffInfo = ^TDealOffInfo;

  TClientDealOffInfo = packed record //   �ͻ���Ԫ���������ݽṹ  20080317
    sDealCharName: string[ACTORNAMELEN];//������
    sBuyCharName: string[ACTORNAMELEN];//������
    dSellDateTime: TDateTime;//����ʱ��
    nSellGold: Integer;//���׵�Ԫ����
    UseItems: array[0..9] of TClientItem;//��Ʒ
    N: Byte;//����ʶ��
  end;
  pTClientDealOffInfo = ^TClientDealOffInfo;
//------------------------------------------------------------------------------
  TAttribute = record //������Ʒ����
    nPoints: Byte;//�������������
    nDifficult: Byte;//�����Ѷ�
  end;

  TRefineItemInfo = packed record //Size 36 �������ݽṹ  20080502
    sItemName: string;//��Ʒ����
    nRefineRate: Byte;//�����ɹ���
    nReductionRate: Byte;//ʧ�ܻ�ԭ��
    boDisappear: Boolean;//����ʯ�Ƿ���ʧ 0-����1�־�,1-��ʧ
    nNeedRate: Byte;//��Ʒ����
    nAttribute: array[0..13] of TAttribute;//������Ʒ����
  end;
  pTRefineItemInfo = ^TRefineItemInfo;
//------------------------------------------------------------------------------
  TSellOffInfo = packed record //Size 59    �������ݽṹ
    sCharName: string[ACTORNAMELEN];//������
    dSellDateTime: TDateTime;//����ʱ��
    nSellGold: Integer;//���
    N: Integer;
    UseItems: TUserItem;//��Ʒ
    n1: Integer;
  end;
  pTSellOffInfo = ^TSellOffInfo;

  TItemCount = Integer;

  TBigStorage = packed record //���޲ֿ����ݽṹ
    boDelete: Boolean;
    sCharName: string[ACTORNAMELEN];
    SaveDateTime: TDateTime;
    UseItems: TUserItem;
    nCount: Integer;
  end;
  pTBigStorage = ^TBigStorage;

  TBindItem = record //�����Ʒ��
    sUnbindItemName: string[ACTORNAMELEN];//�����Ʒ����
    nStdMode: Integer;//��Ʒ����
    nShape: Integer;//װ�����
    btItemType: Byte;//����
  end;
  pTBindItem = ^TBindItem;

  TOUserStateInfo = packed record //OK
    feature: Integer;
    UserName: string[15]; // 15
    GuildName: string[14]; //14
    GuildRankName: string[16]; //15
    NAMECOLOR: Word;
    UseItems: array[0..8] of TOClientItem;
  end;

  TIDRecordHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    UpdateDate: TDateTime;
    sAccount: string[11];
  end;

  TRecordHeader = packed record //Size 12
    boDeleted: Boolean; //�Ƿ�ɾ��
    nSelectID: Byte;   //ID
    boIsHero: Boolean; //�Ƿ�Ӣ��
    bt2: Byte;
    dCreateDate: TDateTime; //����¼ʱ��
    sName: string[15]; //��ɫ����   28
  end;
  pTRecordHeader = ^TRecordHeader;

  TUnKnow = array[0..29] of Byte;
  //TQuestUnit = array[0..127] of Byte; //δʹ�� 20080329
  TQuestFlag = array[0..127] of Byte;
  TStatusTime = array[0..MAX_STATUS_ATTRIBUTE - 1] of Word;

  THumItems = array[0..8] of TUserItem;//9��װ�� 
  THumAddItems = array[9..13] of TUserItem;//����4��װ�� ��չ֧�ֶ��� 20080416
  TBagItems = array[0..45] of TUserItem;//������Ʒ
  TStorageItems = array[0..45] of TUserItem;
  THumMagics = array[0..29] of THumMagic;//���＼��
  THumNGMagics = array[0..29] of THumMagic;//�ڹ�����
  THumanUseItems = array[0..13] of TUserItem;//��չ֧�ֶ��� 20080416
  //THeroItems = array[0..12] of TUserItem;//δʹ�� 20080416
  //THeroBagItems = array[0..40 - 1] of TUserItem;//20081001 ע��
  PTPLAYUSEITEMS = ^THumanUseItems;

  //pTHeroItems = ^THeroItems;//δʹ�� 20080416
  pTHumItems = ^THumItems;
  pTBagItems = ^TBagItems;
  pTStorageItems = ^TStorageItems;
  pTHumAddItems = ^THumAddItems;
  pTHumMagics = ^THumMagics;
  pTHumNGMagics = ^THumNGMagics;//�ڹ����� 20081001
  //pTHeroBagItems = ^THeroBagItems; //20081001 ע��

{  pTHeroData = ^THeroData; //20081001 ע��
  THeroData = packed record //Size = 1514-40  Ӣ������
    sChrName: string[ACTORNAMELEN];//Ӣ������
    btHair: Byte;//ͷ��
    btSex: Byte;//�Ա�
    btJob: Byte;//ְҵ 0-ս 1-�� 2-�� 3-�̿�
    Abil: TOAbility; //+40
    //wStatusTimeArr: TStatusTime; //+24
    btReLevel: Byte; //ת���ȼ�
    btCreditPoint: Byte;//������
    nBagItemCount: Integer;//������Ʒ����
    nPKPOINT: Integer;//PK����

    btStatus: Byte; //״̬
    boProtectStatus: Boolean; //�Ƿ����ػ�״̬
    nProtectTargetX: Integer; //�ػ�����
    nProtectTargetY: Integer; //�ػ�����

    UnKnow: array[0..9] of Byte;
    HumItems: THumanUseItems; //12��װ�� �·�  ����  ���� ͷ�� ���� ���� ���� ��ָ ��ָ
    BagItems: THeroBagItems; //����װ��
    HumMagics: THumMagics; //ħ��
  end; }

  pTHumData = ^THumData;
  THumData = packed record {���������� Size = 4402 Ԥ��N������}
    sChrName: string[ACTORNAMELEN];//����
    sCurMap: string[MAPNAMELEN];//��ͼ
    wCurX: Word; //����X
    wCurY: Word; //����Y
    btDir: Byte; //����
    btHair: Byte;//ͷ��
    btSex: Byte; //�Ա�
    btJob: Byte;//ְҵ 0-ս 1-�� 2-�� 3-�̿�
    nGold: Integer;//�����
    Abil: TOAbility;//+40 ������������
    wStatusTimeArr: TStatusTime; //+24 ����״̬����ֵ��һ���ǳ���������
    sHomeMap: string[MAPNAMELEN];//Home ��
    //btUnKnow1: Byte;//δʹ��
    wHomeX: Word;//Home X
    wHomeY: Word;//Home Y
    sDearName: string[ACTORNAMELEN]; //����(��ż)
    sMasterName: string[ACTORNAMELEN];//ʦ������
    boMaster: Boolean;//�Ƿ���ͽ��
    btCreditPoint: Integer;//������ 20080118
    btDivorce: Byte; //�Ƿ���
    btMarryCount: Byte; //������
    sStoragePwd: string[7];//�ֿ�����
    btReLevel: Byte;//ת���ȼ�
    btUnKnow2: array[0..2] of Byte;//0-�Ƿ�ͨԪ������(1-��ͨ) 1-�Ƿ�Ĵ�Ӣ��(1-����Ӣ��) 2-����ʱ�Ƶ�Ʒ��
    BonusAbil: TNakedAbility; //+20 ����
    nBonusPoint: Integer;//������
    nGameGold: Integer;//��Ϸ��
    nGameDiaMond: Integer;//���ʯ 20071226
    nGameGird:Integer;//��� 20071226
    nGamePoint: Integer;//����
    btGameGlory: Byte; //���� 20080511
    nPayMentPoint: Integer; //��ֵ��
    nLoyal: Integer;//Ӣ�۵��ҳ϶�(20080109)
    nPKPOINT: Integer;//PK����
    btAllowGroup: Byte;//�������
    btF9: Byte;
    btAttatckMode: Byte;//����ģʽ
    btIncHealth: Byte;//���ӽ�����
    btIncSpell: Byte;//���ӹ�����
    btIncHealing: Byte;//����������
    btFightZoneDieCount: Byte;//���л�ռ����ͼ����������
    sAccount: string[10];//��¼�ʺ�
    //btEE: Byte;//δʹ��
    btEF: Byte;//Ӣ������ 0-������Ӣ�� 1-����Ӣ�� 20080514
    boLockLogon: Boolean;//�Ƿ�������½
    wContribution: Word;//����ֵ
    nHungerStatus: Integer;//����״̬
    boAllowGuildReCall: Boolean; //  �Ƿ������л��һ
    wGroupRcallTime: Word; //�Ӵ���ʱ��
    dBodyLuck: Double; //���˶�  8
    boAllowGroupReCall: Boolean; // �Ƿ�������غ�һ
    nEXPRATE: Integer; //���鱶��
    nExpTime: Integer; //���鱶��ʱ��
    btLastOutStatus: Byte; //�˳�״̬ 1Ϊ�����˳�
    wMasterCount: Word; //��ʦͽ����
    boHasHero: Boolean; //�Ƿ��а�����Ӣ��
    boIsHero: Boolean; //�Ƿ���Ӣ��
    btStatus: Byte; //״̬
    sHeroChrName: string[ACTORNAMELEN];//Ӣ������
    UnKnow: TUnKnow;//Ԥ�� array[0..39] of Byte; 0-3���ʹ�� 20080620 4-����ʱ�Ķ��� 5-ħ���ܵȼ� 6-�Ƿ�ѧ���ڹ� 7-�ڹ��ȼ�
    QuestFlag: TQuestFlag; //�ű�����
    HumItems: THumItems; //9��װ�� �·�  ����  ���� ͷ�� ���� ���� ���� ��ָ ��ָ
    BagItems: TBagItems; //����װ��
    HumMagics: THumMagics; //ħ��
    StorageItems: TStorageItems; //�ֿ���Ʒ
    HumAddItems: THumAddItems; //����4�� ����� ���� Ь�� ��ʯ
    n_WinExp: longWord;//�ۼƾ��� 20081001
    n_UsesItemTick: Integer;//������ۼ�ʱ�� 20080221
    nReserved: Integer; //��Ƶ�ʱ��,�����ж೤ʱ�����ȡ�ؾ� 20080620
    nReserved1: Integer; //��ǰҩ��ֵ 20080623
    nReserved2: Integer; //ҩ��ֵ���� 20080623
    nReserved3: Integer; //ʹ��ҩ��ʱ��,���㳤ʱ��ûʹ��ҩ�� 20080623
    n_Reserved: Word;   //��ǰ����ֵ 20080622
    n_Reserved1: Word;  //�������� 20080622
    n_Reserved2: Word;  //��ǰ��ƶ� 20080623
    n_Reserved3: Word;  //ҩ��ֵ�ȼ� 20080623
    boReserved: Boolean; //�Ƿ������ T-�����
    boReserved1: Boolean;//�Ƿ�������Ӣ�� 20080519
    boReserved2: Boolean;//�Ƿ���� T-������� 20080620

    boReserved3: Boolean;//���Ƿ�Ⱦ����� 20080627
    m_GiveDate:Integer;//������ȡ�л��Ȫ���� 20080625
    Exp68: LongWord;//�������嵱ǰ���� 20080625
    MaxExp68: LongWord;//���������������� 20080625
    nExpSkill69: Integer;//�ڹ���ǰ���� 20080930
    HumNGMagics: THumNGMagics;//�ڹ����� 20081001
    m_nReserved1: Word;//����
    m_nReserved2: Word;//����
    m_nReserved3: Word;//����
    m_nReserved4: LongWord;//����
    m_nReserved5: LongWord;//����
    m_nReserved6: Integer;//����
    m_nReserved7: Integer;//����
  end;

  THumDataInfo = packed record //Size 4430
    Header: TRecordHeader;
    Data: THumData;
  end;
  pTHumDataInfo = ^THumDataInfo;

  THeroDataInfo = packed record //20080514 ��ѯӢ������
    sChrName: string[ACTORNAMELEN];//����
    Level: Word; //�ȼ�
    btSex: Byte; //�Ա�
    btJob: Byte;//ְҵ 0-ս 1-�� 2-�� 3-�̿�
    btType: Byte;//Ӣ������ 0-������Ӣ�� 1-����Ӣ��
  end;
  pTHeroDataInfo = ^THeroDataInfo;

  TSaveRcd = record
    sAccount: string[12];
    sChrName: string[ACTORNAMELEN];
    nSessionID: Integer;
    nReTryCount: Integer;
    dwSaveTick: LongWord; //2006-11-12 ���� ��������´α���TICK
    PlayObject: TObject;
    HumanRcd: THumDataInfo;
    boIsHero: Boolean;
  end;
  pTSaveRcd = ^TSaveRcd;

  TLoadDBInfo = record
    sAccount: string[12];//�˺�
    sCharName: string[ACTORNAMELEN];//��ɫ����
    sIPaddr: string[15];//IP��ַ
    sMsg: string;
    nSessionID: Integer;
    nSoftVersionDate: Integer;//�ͻ��˰汾��
    nPayMent: Integer;
    nPayMode: Integer;//���ģʽ
    nSocket: Integer;//�˿�
    nGSocketIdx: Integer;
    nGateIdx: Integer;
    boClinetFlag: Boolean;
    dwNewUserTick: LongWord;
    PlayObject: TObject;
    nReLoadCount: Integer;
    boIsHero: Boolean;//�Ƿ�Ӣ��
    btLoadDBType: Byte;
  end;
  pTLoadDBInfo = ^TLoadDBInfo;

  TUserOpenInfo = record
    sAccount: string[12];
    sChrName: string[ACTORNAMELEN];
    LoadUser: TLoadDBInfo;
    HumanRcd: THumDataInfo;
    nOpenStatus: Integer;
  end;
  pTUserOpenInfo = ^TUserOpenInfo;

  TLoadUser = record
    sAccount: string[12];
    sChrName: string[ACTORNAMELEN];
    sIPaddr: string[15];
    nSessionID: Integer;
    nSocket: Integer;
    nGateIdx: Integer;
    nGSocketIdx: Integer;
    nPayMent: Integer;
    nPayMode: Integer;
    dwNewUserTick: LongWord;
    nSoftVersionDate: Integer;
  end;
  pTLoadUser = ^TLoadUser;

  TDoorStatus = record
    bo01: Boolean;
    boOpened: Boolean;
    dwOpenTick: LongWord;
    nRefCount: Integer;
    n04: Integer;
  end;
  pTDoorStatus = ^TDoorStatus;

  TDoorInfo = record
    nX: Integer;
    nY: Integer;
    n08: Integer;
    Status: pTDoorStatus;
  end;
  pTDoorInfo = ^TDoorInfo;

  TSlaveInfo = record
    sSalveName: string;
    btSalveLevel: Byte;
    btSlaveExpLevel: Byte;
    dwRoyaltySec: LongWord;
    nKillCount: Integer;
    nHP: Integer;
    nMP: Integer;
  end;
  pTSlaveInfo = ^TSlaveInfo;

  TSwitchDataInfo = record
    sChrName: string[ACTORNAMELEN];
    sMAP: string[MAPNAMELEN];
    wX: Word;
    wY: Word;
    Abil: TAbility;
    nCode: Integer;
    boC70: Boolean;//δʹ��
    boBanShout: Boolean;
    boHearWhisper: Boolean;
    boBanGuildChat: Boolean;
    boAdminMode: Boolean;
    boObMode: Boolean;
    BlockWhisperArr: array[0..5] of string;
    SlaveArr: array[0..10] of TSlaveInfo;
    StatusValue: array[0..5] of Word;
    StatusTimeOut: array[0..5] of LongWord;
  end;
  pTSwitchDataInfo = ^TSwitchDataInfo;

  TGoldChangeInfo = record
    sGameMasterName: string;
    sGetGoldUser: string;
    nGold: Integer;
  end;
  pTGoldChangeInfo = ^TGoldChangeInfo;

  TGateInfo = record
    Socket: TCustomWinSocket;
    boUsed: Boolean;
    sAddr: string[15];
    nPort: Integer;
    n520: Integer;
    UserList: TList;
    nUserCount: Integer; //��������
    Buffer: PChar;
    nBuffLen: Integer;
    BufferList: TList;
    boSendKeepAlive: Boolean;
    nSendChecked: Integer;
    nSendBlockCount: Integer;
    dwTime544: LongWord;
    nSendMsgCount: Integer;
    nSendRemainCount: Integer;
    dwSendTick: LongWord;
    nSendMsgBytes: Integer;
    nSendBytesCount: Integer;
    nSendedMsgCount: Integer;
    nSendCount: Integer;
    dwSendCheckTick: LongWord;
  end;
  pTGateInfo = ^TGateInfo;

  TStartPoint = record //��ȫ���سǵ� ���ӹ⻷Ч��
    m_sMapName: string[MAPNAMELEN];
    m_nCurrX: Integer; //����X(4�ֽ�)
    m_nCurrY: Integer; //����Y(4�ֽ�)
    m_boNotAllowSay: Boolean;
    m_nRange: Integer;
    m_nType: Integer;//����
    m_nPkZone: Integer;
    m_nPkFire: Integer;
    m_btShape: Byte;
  end;
  pTStartPoint = ^TStartPoint;

  //��ͼ�¼������������
  TQuestUnitStatus = record
    nQuestUnit: Integer;
    boOpen: Boolean;
  end;
  pTQuestUnitStatus = ^TQuestUnitStatus;

  TMapCondition = record
    nHumStatus: Integer;//�˵�״̬
    sItemName: string[14];//��Ʒ
    boNeedGroup: Boolean;//�Ƿ���Ҫ���
  end;
  pTMapCondition = ^TMapCondition;

  TStartScript = record
    nLable: Integer;
    sLable: string[100];
  end;

  TMapEvent = record
    m_sMapName: string[MAPNAMELEN];//��ͼ
    m_nCurrX: Integer;//X
    m_nCurrY: Integer;//Y
    m_nRange: Integer;//��Χ
    m_MapFlag: TQuestUnitStatus;
    m_nRandomCount: Integer; //����(0 - 999999) 0 �Ļ���Ϊ100% ; ����Խ�󣬻���Խ��
    m_Condition: TMapCondition; //��������
    m_StartScript: TStartScript;
  end;
  pTMapEvent = ^TMapEvent;

  TItemEvent = record
    m_sItemName: string[ACTORNAMELEN];
    m_nMakeIndex: Integer;
    m_sMapName: string[MAPNAMELEN];
    m_nCurrX: Integer;
    m_nCurrY: Integer;
  end;
  pTItemEvent = ^TItemEvent;

  TSendUserData = record
    nSocketIndx: Integer;
    nSocketHandle: Integer;
    sMsg: string;
  end;
  pTSendUserData = ^TSendUserData;

  TCheckVersion = record
  end;
  pTCheckVersion = ^TCheckVersion;

  TRecordDeletedHeader = packed record
    boDeleted: Boolean;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    CreateDate: TDateTime;
    LastLoginDate: TDateTime;
    n14: Integer;
    nNextDeletedIdx: Integer;
    //    sAccount   :String[11];//0x14
  end;

  TUserEntry = packed record
    sAccount: string[10];//�˺�
    sPassword: string[10];//����
    sUserName: string[20];//�û�����
    sSSNo: string[14];//���֤
    sPhone: string[14];//�绰
    sQuiz: string[20];//����1
    sAnswer: string[12];//��1
    sEMail: string[40];//����
  end;
  TUserEntryAdd = packed record
    sQuiz2: string[20];//����2
    sAnswer2: string[12];//��2
    sBirthDay: string[10];//����
    sMobilePhone: string[13];//�ƶ��绰
    sMemo: string[20];//��עһ
    sMemo2: string[20];//��ע��
  end;

  TAccountDBRecord = packed record
    Header: TIDRecordHeader;
    UserEntry: TUserEntry;
    UserEntryAdd: TUserEntryAdd;
    nErrorCount: Integer;
    dwActionTick: LongWord;
    N: array[0..38] of Byte;
  end;

  TMapFlag = record //��ͼ����
    boSAFE: Boolean;
    boDARK: Boolean;
    boFIGHT: Boolean;
    boFIGHT2: Boolean;//��PK��ͼ������pk������װ�� 20080525
    boFIGHT3: Boolean;
    boFIGHT4: Boolean;//��ս��ͼ 20080706
    boDAY: Boolean;
    boQUIZ: Boolean;
    boNORECONNECT: Boolean;
    boMUSIC: Boolean;
    boEXPRATE: Boolean;
    boPKWINLEVEL: Boolean;
    boPKWINEXP: Boolean;
    boPKLOSTLEVEL: Boolean;
    boPKLOSTEXP: Boolean;
    boDECHP: Boolean;
    boINCHP: Boolean;
    boDECGAMEGOLD: Boolean;
    boDECGAMEPOINT: Boolean;//�Զ�����Ϸ��
    boINCGAMEGOLD: Boolean;
    boINCGAMEPOINT: Boolean;//�Զ�����Ϸ��
    boNoCALLHERO: Boolean;//��ֹ�ٻ�Ӣ�� 20080124
    
    boNEEDLEVELTIME: Boolean;//ѩ���ͼ����,�жϵȼ�,��ͼʱ�� 20081228
    nNEEDLEVELPOINT: Integer;//��ѩ���ͼ��͵ȼ�
    boMoveToHome: Boolean;//�Ƿ��赹��ʱ���͵�ָ����(ѩ��) 20081230
    sMoveToHomeMap: string;//���͵ĵ�ͼ��
    nMoveToHomeX : Integer;//���͵ĵ�ͼX
    nMoveToHomeY : Integer;//���͵ĵ�ͼY

    boNOHEROPROTECT: Boolean;//��ֹӢ���ػ� 20080629
    boNODROPITEM: Boolean;//��ֹ��������Ʒ 20080503
    boMISSION: Boolean;//������ʹ���κ���Ʒ�ͼ��� 20080124
    boRUNHUMAN: Boolean;
    boRUNMON: Boolean;
    boNEEDHOLE: Boolean;
    boNORECALL: Boolean;
    boNOGUILDRECALL: Boolean;
    boNODEARRECALL: Boolean;
    boNOMASTERRECALL: Boolean;
    boNORANDOMMOVE: Boolean;
    boNODRUG: Boolean;
    boMINE: Boolean;
    boNOPOSITIONMOVE: Boolean;
    boNoManNoMon: Boolean;//����ˢ��,���˲�����ˢ�� 20080525
    boKILLFUNC: Boolean;//��ͼɱ�˴��� 20080415
    nKILLFUNC: Integer;//��ͼɱ�˴��� 20080415 

   //nL: Integer;//20080815 ע��
    nNEEDSETONFlag: Integer;
    nNeedONOFF: Integer;
    nMUSICID: Integer;

    nPKWINLEVEL: Integer;
    nEXPRATE: Integer;
    nPKWINEXP: Integer;
    nPKLOSTLEVEL: Integer;
    nPKLOSTEXP: Integer;
    nDECHPPOINT: Integer;
    nDECHPTIME: Integer;
    nINCHPPOINT: Integer;
    nINCHPTIME: Integer;
    nDECGAMEGOLD: Integer;
    nDECGAMEGOLDTIME: Integer;
    nDECGAMEPOINT: Integer;
    nDECGAMEPOINTTIME: Integer;
    nINCGAMEGOLD: Integer;
    nINCGAMEGOLDTIME: Integer;
    nINCGAMEPOINT: Integer;
    nINCGAMEPOINTTIME: Integer;
    sReConnectMap: string;
    sMUSICName: string;
    boUnAllowStdItems: Boolean;
    sUnAllowStdItemsText: string;//��ͼ������Ʒ
    sUnAllowMagicText: string; //������ħ��
    boNOTALLOWUSEMAGIC: Boolean; //������ħ��
    boAutoMakeMonster: Boolean;
    boFIGHTPK: Boolean; //PK���Ա�װ��������
    nThunder:Integer;//���� 20080327
    nLava:Integer;//����ð�ҽ� 20080327
  end;
  pTMapFlag = ^TMapFlag;


  TUserLevelSort = record //����ȼ�����
    nIndex: Integer;
    wLevel: Word;
    sChrName: string[ACTORNAMELEN];
  end;
  pTUserLevelSort = ^TUserLevelSort;

  THeroLevelSort = record //Ӣ�۵ȼ�����
    nIndex: Integer;
    wLevel: Word;
    sChrName: string[ACTORNAMELEN];
    sHeroName: string[ACTORNAMELEN];
  end;
  pTHeroLevelSort = ^THeroLevelSort;

  TUserMasterSort = record //ͽ����������
    nIndex: Integer;
    nMasterCount: Integer;
    sChrName: string[ACTORNAMELEN];
  end;
  pTUserMasterSort = ^TUserMasterSort;

  TCharName = string[ACTORNAMELEN + 1];
  pTCharName = ^TCharName;

  THeroName = string[ACTORNAMELEN * 2 + 2];
  pTHeroName = ^THeroName;

  TChrMsg = record
    Ident: Integer;
    x: Integer;
    y: Integer;
    dir: Integer;
    State: Integer;
    feature: Integer;
    saying: string;
    sound: Integer;
  end;
  pTChrMsg = ^TChrMsg;

  TRegInfo = record
    sKey: string;
    sServerName: string;
    sRegSrvIP: string[15];
    nRegPort: Integer;
  end;

  TDropItem = record
    x: Integer;
    y: Integer;
    id: Integer;
    Looks: Integer;
    Name: string;
    FlashTime: DWord;
    FlashStepTime: DWord;
    FlashStep: Integer;
    BoFlash: Boolean;
  end;
  pTDropItem = ^TDropItem;

  TUserCharacterInfo = record
    Name: string[19];
    Job: Byte;
    HAIR: Byte;
    Level: Word;
    sex: Byte;
  end;

  TClientGoods = record
    Name: string;
    SubMenu: Integer;
    Price: Integer;
    Stock: Integer;
    Grade: Integer;
  end;
  PTClientGoods = ^TClientGoods;

  TClientConf = record
    //boClientCanSet: Boolean;//20080413 δʹ��
    boRUNHUMAN: Boolean;
    boRUNMON: Boolean;
    boRunNpc: Boolean;
    boWarRunAll: Boolean;
    btDieColor: Byte;
    wSpellTime: Word;
    wHitIime: Word;
    wItemFlashTime: Word;
    btItemSpeed: Byte;
    boParalyCanRun: Boolean;
    boParalyCanWalk: Boolean;
    boParalyCanHit: Boolean;//����ܹ���
    boParalyCanSpell: Boolean;
    boShowJobLevel: Boolean;
    boDuraAlert: Boolean;
    boSkill31Effect: Boolean;//ħ����Ч�� T-��ɫЧ�� F-ʢ��Ч�� 20080808
    //boMagicLock: Boolean;

    //�ڹ�
    {boShowRedHPLable: Boolean;
    boShowGroupMember: Boolean;
    boShowAllItem: Boolean;
    boShowBlueMpLable: Boolean;
    boShowName: Boolean;
    boAutoPuckUpItem: Boolean;
    boShowHPNumber: Boolean;
    boShowAllName: Boolean;
    boForceNotViewFog: Boolean;

    boParalyCan: Boolean;
    boMoveSlow: Boolean;
    boCanStartRun: Boolean;
    boAutoMagic: Boolean;
    boMoveRedShow: Boolean;
    boMagicLock: Boolean;
    nMoveTime: Integer;
    nHitTime: Integer;
    nSpellTime: Integer;
    nClientWgInfo: Integer; }
    //�ڹҽ���
  end;

  pTPowerBlock = ^TPowerBlock;
  TPowerBlock = array[0..100 - 1] of Word;

  TShowRemoteMessage = record
    btMessageType: Byte;
    boShow: Boolean;
    BeginDateTime: TDateTime;
    EndDateTime: TDateTime;
    dwShowTime: LongWord;
    dwShowTick: LongWord;
    boSuperUserShow: Boolean;
    sMsg: string;
  end;
  pTShowRemoteMessage = ^TShowRemoteMessage;

  TDisallowInfo = record //��ֹ��Ʒ���� 20080418
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

  TFilterMsg = record//��Ϣ���� 
    sFilterMsg: string[100];
    sNewMsg: string[100];
  end;
  pTFilterMsg = ^TFilterMsg;

  TagMapInfo = record //��·��ʯ 20081019
    TagMapName: String[MAPNAMELEN];
    TagX: Integer;
    TagY: Integer;
  end;
  TagMapInfos = array[1..6] of TagMapInfo;//��·��ʯ 20081019

function APPRfeature(cfeature: Integer): Word;
function RACEfeature(cfeature: Integer): Byte;
function HAIRfeature(cfeature: Integer): Byte;
function DRESSfeature(cfeature: Integer): Byte;
function WEAPONfeature(cfeature: Integer): Byte;
function Horsefeature(cfeature: Integer): Byte;
function Effectfeature(cfeature: Integer): Byte;
function MakeHumanFeature(btRaceImg, btDress, btWeapon, btHair: Byte): Integer;
function MakeMonsterFeature(btRaceImg, btWeapon: Byte; wAppr: Word): Integer;
implementation

function WEAPONfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(cfeature);
end;
function DRESSfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(HiWord(cfeature));
end;
function APPRfeature(cfeature: Integer): Word;
begin
  Result := HiWord(cfeature);
end;
function HAIRfeature(cfeature: Integer): Byte;
begin
  Result := HiWord(cfeature);
end;

function RACEfeature(cfeature: Integer): Byte;
begin
  Result := cfeature;
end;

function Horsefeature(cfeature: Integer): Byte;
begin
  Result := LoByte(LoWord(cfeature));
end;
function Effectfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(LoWord(cfeature));
end;

function MakeHumanFeature(btRaceImg, btDress, btWeapon, btHair: Byte): Integer;
begin
  Result := MakeLong(MakeWord(btRaceImg, btWeapon), MakeWord(btHair, btDress));
end;
function MakeMonsterFeature(btRaceImg, btWeapon: Byte; wAppr: Word): Integer;
begin
  Result := MakeLong(MakeWord(btRaceImg, btWeapon), wAppr);
end;
end.

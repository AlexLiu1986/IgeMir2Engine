unit GameLoginShare;

interface
uses
  Common;
//���IP��ַ��ʽ
//function CheckIsIpAddr(Name: string): Boolean;
{//��ȡ��ǰ��Ӳ�����е��̷�
procedure GetdriveName(var sList: TStringList);
{function decrypt(const s:string; skey:string):string;
function encrypt(const s:string; skey:string):string;
function CertKey(key: string): string;  }
const
  FilterItemNameList ='FilterItemNameList.txt';
  BakFileName = '56Dlq.Bak'; //�������ǰ���ݵ��ļ���
  //0Ϊ����  1Ϊ��ʽ
  Version = 1;

var
  {$if Version = 1}
  g_boGameMon: Boolean;
  {$ifend}
  LnkName, GameESystemURL,{$if Version = 1}GameListURL, BakGameListURL, GameMonListURL, PatchListURL,{$ifend} ClientFileName:String;
  m_SelServerInfo : pTServerInfo = nil;
  code: byte = 1;
  m_sMirClient: string;
  SDir: string; //���º����еĵ�½��
  g_boIsUpdateSelf: Boolean = False; //�Ƿ��������
  g_boGatePassWord: Boolean = False; //�Ƿ�ͨ����������֤
  g_sGatePassWord: string = '';
  sSourceFileSize: Int64;
  //g_boIsGamePath: Boolean = False;
  MyRecInfo: TRecInfo;
implementation






end.


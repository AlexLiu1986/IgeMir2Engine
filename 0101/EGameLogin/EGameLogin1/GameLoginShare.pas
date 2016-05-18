unit GameLoginShare;

interface
uses
  Classes, Common;
//检查IP地址格式
//function CheckIsIpAddr(Name: string): Boolean;
{//获取当前的硬盘所有的盘符
procedure GetdriveName(var sList: TStringList);
{function decrypt(const s:string; skey:string):string;
function encrypt(const s:string; skey:string):string;
function CertKey(key: string): string;  }

const
  FilterItemNameList ='FilterItemNameList.txt';
  BakFileName = '56Dlq.Bak'; //自身更新前备份的文件名
  //0为测试  1为正式
  Version = 1;

var
  g_LocalServerList: TList;
  {$if Version = 1}
  g_boGameMon: Boolean;
  {$ifend}
  LnkName, GameESystemURL,{$if Version = 1}GameListURL, GameMonListURL, PatchListURL,{$ifend} ClientFileName, m_sLocalGameListName:String;
  m_SelServerInfo : pTServerInfo = nil;
  code: byte = 1;
  m_sMirClient: string;
  SDir: string; //更新后运行的登陆器
  g_boIsUpdateSelf: Boolean = False; //是否更新自身
  //g_boIsGamePath: Boolean = False;

implementation






end.


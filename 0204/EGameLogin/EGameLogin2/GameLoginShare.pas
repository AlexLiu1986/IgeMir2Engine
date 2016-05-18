unit GameLoginShare;

interface

const
  //0为测试  1为正式
  Version = 1;
  FilterItemNameList ='FilterItemNameList.txt';
  BakFileName = '56Dlq.Bak'; //自身更新前备份的文件名
var
{$if Version = 1}
  g_boGameMon: Boolean;
  {$ifend}
  LnkName, GameESystemURL,{$if Version = 1}GameListURL, GameMonListURL, PatchListURL,{$ifend} ClientFileName, m_sLocalGameListName:String;
  m_sMirClient: string;
  SDir: string; //更新后运行的登陆器
  g_boIsUpdateSelf: Boolean = False; //是否更新自身
implementation

end.

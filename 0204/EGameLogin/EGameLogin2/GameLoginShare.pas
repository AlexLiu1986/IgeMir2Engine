unit GameLoginShare;

interface

const
  //0Ϊ����  1Ϊ��ʽ
  Version = 1;
  FilterItemNameList ='FilterItemNameList.txt';
  BakFileName = '56Dlq.Bak'; //�������ǰ���ݵ��ļ���
var
{$if Version = 1}
  g_boGameMon: Boolean;
  {$ifend}
  LnkName, GameESystemURL,{$if Version = 1}GameListURL, GameMonListURL, PatchListURL,{$ifend} ClientFileName, m_sLocalGameListName:String;
  m_sMirClient: string;
  SDir: string; //���º����еĵ�½��
  g_boIsUpdateSelf: Boolean = False; //�Ƿ��������
implementation

end.

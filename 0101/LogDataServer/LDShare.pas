unit LDShare;

interface
uses
  Windows,Messages,SysUtils;
var
  sBaseDir       :String = '.\LogBase';
  sServerName    :String = '����';
  sCaption       :String = 'IGE�Ƽ�������־������';

  nServerPort    :Integer = 10000;
  g_dwGameCenterHandle:THandle;
const
  g_sProductName = '62C35DC3F705DB36D8B523AF7DA7B091CFA5313C50C50CE4'; //IGE�Ƽ���־��¼����
  g_sVersion = 'D0C3641FA053A0C32F344FC7EADF5DF9ABABBC28C73FEB4D';  //2.00 Build 20081129
  g_sUpDateTime = '8076DE13F2070953D2CA60CF32F6DA5D'; //��������: 2008/11/29
  g_sProgram = 'C0CB995DE0C2A55814577F81CCE3A3BD'; //IGE�Ƽ�
  g_sWebSite = 'E14A1EC77CDEF28A670B57F56B07D834D8758E442B312AF440574B5A981AB1752C73BF5C6670B79C'; // http://www.IGEM2.com(����վ)
  g_sBbsSite = '2E5A58E761D583C119D6606E0F38D7A9D8758E442B312AF440574B5A981AB17538E97FF2F0C39555'; //http://www.IGEM2.com.cn(����վ)
  //g_sProductInfo = '8DFDF45695C4099770F02197A7BCE1C5B07D1DD7CD1455D1783D523EA941CBFB'; //��ӭʹ��IGE����ϵ�����:
  //g_sSellInfo1 = '71043F0BD11D04C7BA0E09F9A2EF83B7B936E13B070575B9';//��ϵ(QQ):228589790

  tLogServer=2;
  procedure SendGameCenterMsg(wIdent:Word;sSendMsg:String);
implementation

uses Grobal2, HUtil32;
procedure SendGameCenterMsg(wIdent:Word;sSendMsg:String);
var
  SendData:TCopyDataStruct;
  nParam:Integer;
begin
  nParam:=MakeLong(Word(tLogServer),wIdent);
  SendData.cbData:=Length (sSendMsg) + 1;
  GetMem(SendData.lpData,SendData.cbData);
  StrCopy (SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle,WM_COPYDATA,nParam,Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

end.

unit Share;

interface
uses Common;

const
  g_sProductName = '928E921DCF86C283FFBB312541A1E85D1AD2D955BF9741EF6959625C7695767C'; //IGE�Ƽ�����ͻ���(Client)
  g_sVersion = 'AA4D9E73FFFD56492F344FC7EADF5DF9B7C712C787D31A50';  //1.00 Build 20081130
  g_sUpDateTime = '113E143B38ED28EBB9582809A7B375AA'; //2008/11/30
  g_sProgram = 'C0CB995DE0C2A55814577F81CCE3A3BD'; //IGE�Ƽ�
  g_sWebSite = 'E14A1EC77CDEF28A670B57F56B07D834D8758E442B312AF440574B5A981AB1752C73BF5C6670B79C'; // http://www.IGEM2.com(����վ)
  g_sBbsSite = '2E5A58E761D583C119D6606E0F38D7A9D8758E442B312AF440574B5A981AB17538E97FF2F0C39555'; //http://www.IGEM2.com.cn(����վ)
  g_sServerAdd = 'A4A488F2C30983EA832726B3D36A30419C771FFC19B5169D'; //56m2vip.vicp.net

//  _sProductAddress ='B1A6AE5FFAB8A3F85097BCBFAA67893D17672C9BED267D3E40574B5A981AB17576B4B91637D6C0B2';//http://www.66h6.net/ver2.txt ������ָ����ı�
//  _sProductAddress1 ='{{{"5>a>"oca"ob';//www.92m2.com.cn //�İ�Ȩָ��(�ı��������),����վ�ı���һ������
  (*�ı�����
{{{"5>a>"oca"ob
��վ��վ�Ѿ��޸ĳ�XXXXXX|��½����ȥ���û��������վ����������ҵ������
*)
var
  g_MySelf: TDLUserInfo;
  g_boConnect: Boolean = False;
  g_boLogined: Boolean = False;
  g_sRecvMsg: string;
  g_sRecvGameMsg: string;
  g_boBusy: Boolean;
  btCode: Byte = 1;
  g_sAccount: string;
  g_sPassword: string;
implementation

end.

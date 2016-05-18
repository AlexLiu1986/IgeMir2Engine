unit Share;

interface
uses Common, Classes, DBTables, Windows;
type
  TStdItem = packed record
    Name: string[14];//��Ʒ����
    StdMode: Byte; //0/1/2/3��ҩ�� 5/6:������10/11�����ף�15��ͷ����22/23����ָ��24/26������19/20/21������
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: ShortInt;
    Reserved: Byte; //0x14
    NeedIdentify: Byte; //0x15 ��Ҫ
    Looks: Word; //0x16 ��ۣ���Items.WIL�е�ͼƬ����
    DuraMax: Word; //0x18  ���־�
    Reserved1: Word;
    AC: Integer; //0x1A
    MAC: Integer; //0x1C
    DC: Integer; //0x1E
    MC: Integer; //0x20
    SC: Integer; //0x22
    Need: Integer; //0x24
    NeedLevel: Integer; //0x25
    Price: Integer; //0x28
  end;
  pTStdItem = ^TStdItem;
const
  GameMonName = 'QKGameMonList.txt';
  FilterFileName = 'GameFilterItemNameList.txt';

  g_sProductName = '4BA8CAFEFD5694CDB3D798FEA5C7F363E4CD8B1C084A3260AD4350D2F1F3C7FC'; //IGE�Ƽ���½���ͻ���(Client)
  g_sVersion = '480317B2D917A24A2F344FC7EADF5DF90CB049B5C15AFEE8';  //1.00 Build 20081130
  g_sUpDateTime = '0F5FC1F777D336933EFB2AAFA12355F8'; //2008/06/03
  g_sProgram = 'C0CB995DE0C2A55814577F81CCE3A3BD'; //IGE�Ƽ�
  g_sWebSite = 'E14A1EC77CDEF28A670B57F56B07D834D8758E442B312AF440574B5A981AB1752C73BF5C6670B79C'; // http://www.IGEM2.com(����վ)
  g_sBbsSite = '2E5A58E761D583C119D6606E0F38D7A9D8758E442B312AF440574B5A981AB17538E97FF2F0C39555'; //http://www.IGEM2.com.cn(����վ)
  g_sServerAdd = 'A4A488F2C30983EA832726B3D36A30419C771FFC19B5169D'; //56m2vip.vicp.net
  g_sFtpServerAdd = '83D7FD6174C8CE82BB159BA29AC7242F16C41B949FD21F29'; //ftp.igem2.com
  g_sFtpUser = 'AA6591AB908100721CCB18FD84556EED';//56m2vip
  g_sFtpPass = '8F618E113AFF24F7AEB6A37AADB5343181065F6527D024AA'; //werks%*&@&@#

//  _sProductAddress ='B1A6AE5FFAB8A3F8476A0071DCA6679A17672C9BED267D3E40574B5A981AB175AC9C4E63F0B12F0D';//http://www.66h6.net/ver1.txt ������ָ����ı�
//  _sProductAddress1 ='{{{"5>a>"oca"ob';//www.92m2.com.cn //�İ�Ȩָ��(�ı��������),����վ�ı���һ������

  (*�ı�����
{{{"5>a>"oca"ob
��վ��վ�Ѿ��޸ĳ�XXXXXX|��½����ȥ���û��������վ����������ҵ������
*)
var
  g_MySelf: TUserInfo;
  g_boConnect: Boolean = False;
  g_boLogined: Boolean = False;
  g_sRecvMsg: string;
  g_sRecvGameMsg: string;
  g_boBusy: Boolean;
  btCode: Byte = 1;
  g_sAccount: string;
  g_sPassword: string;
  g_boFirstOpen: Boolean = False;
  StdItemList: TList; //List_54
  Query: TQuery;
  MakeType: Byte = 0;
function LoadItemsDB: Integer;
implementation

function LoadItemsDB: Integer;
var
  I, Idx: Integer;
  StdItem: pTStdItem;
resourcestring
  sSQLString = 'select * from StdItems';
begin
    try
      for I := 0 to StdItemList.Count - 1 do begin
        Dispose(pTStdItem(StdItemList.Items[I]));
      end;
      StdItemList.Clear;
      Result := -1;
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
        try
          Query.Open;
        finally
          Result := -2;
        end;
      for I := 0 to Query.RecordCount - 1 do begin
        New(StdItem);
        Idx := Query.FieldByName('Idx').AsInteger;
        StdItem.Name := Query.FieldByName('Name').AsString;
        StdItem.StdMode := Query.FieldByName('StdMode').AsInteger;
        StdItem.Shape := Query.FieldByName('Shape').AsInteger;
        StdItem.Weight := Query.FieldByName('Weight').AsInteger;
        StdItem.AniCount := Query.FieldByName('AniCount').AsInteger;
        StdItem.Source := Query.FieldByName('Source').AsInteger;
        StdItem.Reserved := Query.FieldByName('Reserved').AsInteger;
        StdItem.Looks := Query.FieldByName('Looks').AsInteger;
        StdItem.DuraMax := Word(Query.FieldByName('DuraMax').AsInteger);
        StdItem.AC := MakeLong(Round(Query.FieldByName('Ac').AsInteger * (10 / 10)), Round(Query.FieldByName('Ac2').AsInteger * (10 / 10)));
        StdItem.MAC := MakeLong(Round(Query.FieldByName('Mac').AsInteger * (10 / 10)), Round(Query.FieldByName('MAc2').AsInteger * (10 / 10)));
        StdItem.DC := MakeLong(Round(Query.FieldByName('Dc').AsInteger * (10 / 10)), Round(Query.FieldByName('Dc2').AsInteger * (10 / 10)));
        StdItem.MC := MakeLong(Round(Query.FieldByName('Mc').AsInteger * (10 / 10)), Round(Query.FieldByName('Mc2').AsInteger * (10 / 10)));
        StdItem.SC := MakeLong(Round(Query.FieldByName('Sc').AsInteger * (10 / 10)), Round(Query.FieldByName('Sc2').AsInteger * (10 / 10)));
        StdItem.Need := Query.FieldByName('Need').AsInteger;
        StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;
        StdItem.Price := Query.FieldByName('Price').AsInteger;
        //StdItem.NeedIdentify := GetGameLogItemNameList(StdItem.Name);
        if StdItemList.Count = Idx then begin
          StdItemList.Add(StdItem);
          Result := 1;
        end else begin
          //Memo.Lines.Add(Format('������Ʒ(Idx:%d Name:%s)����ʧ�ܣ�����', [Idx, StdItem.Name]));
          Result := -100;
          Exit;
        end;
        Query.Next;
      end;
    finally
      Query.Close;
    end;
end;
initialization
begin
  StdItemList := TList.Create;
  Query := TQuery.Create(nil);
end;
finalization
begin
  //StdItemList.Free;  ��֪��Ϊʲô һ�ͷžͳ���
  Query.Free;
end;
end.

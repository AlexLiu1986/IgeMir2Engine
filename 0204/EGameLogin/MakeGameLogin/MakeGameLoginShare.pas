unit MakeGameLoginShare;

interface
uses windows,messages,classes,DBTables,SysUtils;
Type
  TRecinfo = record
    GameListURL: string[120];
    PatchListURL: string[120];
    GameMonListURL: string[120];
    GameESystemUrl: string[120];
    boGameMon :Boolean;
    lnkName: string[20];
    ClientFileName: string[20];
    ClientLocalFileName: string[20];
    GameSdoFilter: array[0..50000] of char;
  end;

  TStdItem = packed record
    Name: string[14];//物品名称
    StdMode: Byte; //0/1/2/3：药， 5/6:武器，10/11：盔甲，15：头盔，22/23：戒指，24/26：手镯，19/20/21：项链
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: ShortInt;
    Reserved: Byte; //0x14
    NeedIdentify: Byte; //0x15 需要
    Looks: Word; //0x16 外观，即Items.WIL中的图片索引
    DuraMax: Word; //0x18  最大持久
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

procedure ReleaseRes(const ResName, ResType, FileName: PChar);
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
function LoadItemsDB: Integer;
function RandomGetName():string;
function encrypt(const s:string; skey:string):string;
function CertKey(key: string): string;

const
RecInfoSize = Sizeof(TRecinfo);  //返回被TRecinfo所占用的字节数
FilterFileName = 'GameFilterItemNameList.txt';
GameMonName = 'QKGameMonList.txt';

  g_sProductName = '00E3CAEC957BD70E4170DADD828CA8D248EB918C96CB68723EC633BB10CEDD31B422E21304D2EE5A'; //网蓝科技登陆器生成器(反外挂版)
  g_sVersion = 'AF7BE30A93DDA7B52F344FC7EADF5DF9BDCF5B8070D2B211'; //2.00 Build 20080606
  g_sUpDateTime = '06B8C6D3CEBD9FAD41CB00DED3803788'; //更新日期: 2008/06/06
  g_sProgram = '75179905DCA2BD5814577F81CCE3A3BD'; //网蓝科技
  g_sWebSite = 'E14A1EC77CDEF28A670B57F56B07D834D8758E442B312AF440574B5A981AB1752C73BF5C6670B79C'; // http://www.56m2.com(官网站)
  g_sBbsSite = '2E5A58E761D583C119D6606E0F38D7A9D8758E442B312AF440574B5A981AB17538E97FF2F0C39555'; //http://www.56m2.com.cn(程序站)
  g_sProductInfo = '8DFDF45695C4099754D8F52B87B0110AB07D1DD7CD1455D1783D523EA941CBFB'; //欢迎使用网蓝科技系列软件:
  g_sSellInfo1 = '71043F0BD11D04C7BA0E09F9A2EF83B7B936E13B070575B9'; //联系(QQ):357001001 电话:400-6585-722
var
  StdItemList: TList; //List_54
  Query: TQuery;

implementation
//释放资源文件
procedure ReleaseRes(const ResName, ResType, FileName: PChar);
var
  HResource, HGlobal, HFile: THandle;
  FSize, WSize: DWORD;
  FMemory: Pointer;
begin
  HResource := FindResource(HInstance, ResName, ResType);
  if (HResource = 0) then Exit;
  HGlobal := LoadResource(HInstance, HResource);
  if (HGlobal = 0) then Exit;
  FMemory := LockResource(HGlobal);
  if (FMemory = nil) then
  begin
    FreeResource(HGlobal);
    Exit;
  end;
  HFile := CreateFile(FileName, GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if (HFile = INVALID_HANDLE_VALUE) then
  begin
    UnlockResource(HGlobal);
    FreeResource(HGlobal);
    Exit;
  end;
  FSize := SizeOfResource(HInstance, HResource);
  WriteFile(HFile, FMemory^, FSize, Wsize, nil);
  if (FSize <> Wsize) then
  begin
    UnlockResource(HGlobal);
    FreeResource(HGlobal);
    Exit;
  end;
  SetEndofFile(HFile);
  CloseHandle(HFile);
  UnlockResource(HGlobal);
  FreeResource(HGlobal);
end;

//将输入的信息写入登陆器
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
var
  TargetFile: file;
begin
  try
    Result := True;
    AssignFile(TargetFile, FilePath);
    FileMode := 2;
    Reset(TargetFile, 1);
    Seek(TargetFile, FileSize(TargetFile));
    BlockWrite(TargetFile, MyRecInfo, RecInfoSize);
    CloseFile(TargetFile);
  except
    Result := False;
  end;
end;

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
          //Memo.Lines.Add(Format('加载物品(Idx:%d Name:%s)数据失败！！！', [Idx, StdItem.Name]));
          Result := -100;
          Exit;
        end;
        Query.Next;
      end;
    finally
      Query.Close;
    end;
end;
//随机取名
function RandomGetName():string;
var
  s,s1:string;
  I,i0:integer;
begin
    s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
    s1:='';
    for i:=0 to 6 do begin
      i0:=random(35);
      s1:=s1+copy(s,i0,1);
    end;
    Result := s1;
end;
{******************************************************************************}
//加密字符串函数
function myStrtoHex(s: string): string;
var tmpstr:string;
    i:integer;
begin
    tmpstr := '';
    for i:=1 to length(s) do
    begin
        tmpstr := tmpstr + inttoHex(ord(s[i]),2);
    end;
    result := tmpstr;
end;

function myHextoStr(S: string): string;
var hexS,tmpstr:string;
    i:integer;
    a:byte;
begin
    hexS  :=s;//应该是该字符串
    if length(hexS) mod 2=1 then
    begin
        hexS:=hexS+'0';
    end;
    tmpstr:='';
    for i:=1 to (length(hexS) div 2) do
    begin
        a:=strtoint('$'+hexS[2*i-1]+hexS[2*i]);
        tmpstr := tmpstr+chr(a);
    end;
    result :=tmpstr;
end;

//加密
function encrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
    hexS   :=myStrtoHex(s);
    hexskey:=myStrtoHex(skey);
    midS   :=hexS;
    for i:=1 to (length(hexskey) div 2)   do
    begin
        if i<>1 then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do
        begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := tmpstr;
end;
{******************************************************************************}
//解密密钥
function CertKey(key: string): string;
var i: Integer;
begin
  for i:=1 to length(key) do
    result := result + chr(ord(key[i]) xor length(key)*i*i)
end;
{******************************************************************************}
end.

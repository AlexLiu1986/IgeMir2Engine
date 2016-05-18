unit UnitMainWork;

interface

uses Windows, SysUtils, Classes, UniTypes, RzRadChk, RzListVw,IniFiles;

const
  THREADWORK    = TRUE;

type
  TMainWorkThread = class{$IF THREADWORK}(TThread){$IFEND}
    m_MainHumLists    : TListArray;
    m_MainIDLists     : TListArray;
    m_SubIDLists      : TListArray;

    m_sWorkingFor     : string;
    m_nTotalMax       : Integer;//最大总数
    m_nTotalPostion   : Integer;
    m_nCurMax         : Integer;
    m_nCurPostion     : Integer;
    m_nFailed         : Integer;
    m_sMainRoot       : string;//文件路径
    m_sMainGuildList  : TStrings;
    m_sGuildChangedList:TStrings;
  private
    m_sCurMessage: string;
    m_WorkRoots: TStrings;
    m_nNewItemIndex: Integer;
    IDChangedLists: TListArray;
    IDOldLists: TListArray;//TStrings;
    NameChangedList: TStrings;
    NameOldList: TStrings;
    OldSellOffItemList: TList;//元宝寄售列表
    m_StorageList:TList;//无限仓库列表
    g_MainTxtList:TList;//主库文本列表 20080703
    g_DeputyTxtList:TList;//从库文本列表 20080703
    f_MainIDH: THandle;
    f_MainHumH: THandle;
    f_MainMirH: THandle;
    procedure OutMessage;//输出信息
    procedure LoadHumDB(const sRoot: string; ListArray: TListArray);//读取人物数据
    procedure LoadIDDB(const sRoot: string; ListArray: TListArray);//读取ID数据
    procedure LoadSellOffItemList(const sRoot: string; SellOffItemList:TList);//读取元宝寄售数据
    procedure SaveSellOffItemList(const sRoot: string; SellOffItemList:TList);//保存元宝寄售数据
    procedure LoadBigStorageList(const sRoot: string; m_StorageList:TList);//读取无限仓库数据
    procedure SaveBigStorageList(const sRoot: string; m_StorageList:TList);  //保存无限仓库数据
    function  GetMaxWorkCount : Integer;//取最大的工作数量
    function  GetFileSize(const sFile: string; const OffSet: Integer; const DefSize: Integer): Integer;//取文件大小
    procedure SaveIDChangeList;//保存ID改变的列表
    procedure SaveNameChangeList;//保存名字改变的列表
    procedure MakeInOne(sRoot: string);//合并数据
    procedure ReSetItemsIndex;//重新编写物品制造ID

    procedure LoadTxtDataToList(ListView: TRzListView ; m_Txt:TList);//读取文本内存到列表 20080703
    procedure UpdateTxtDataToList(const sHumName,sNewHumName: string; m_Txt:TList);//修改名字到文本内容列表 20080703
    procedure SaveListToTxt(sRoot: string; m_MainTxt, DeputyTxt:TList);//保存文本内容 20080703
  protected
    procedure Execute; {$IF THREADWORK}override;{$IFEND}
  public
    constructor Create(CreateSupsbended: Boolean = True);reintroduce;
    destructor  Destroy;override;
    procedure   SetWorkRoots(SL:String);
    {$IF NOT THREADWORK}
    procedure   Run;
    {$IFEND}
  end;

  TMainOutProcList    = procedure (const smsg: string) of Object;

  var
    MainOutInforProc  : TMainOutProcList;
    MainWorkThread    : TMainWorkThread;
{$IF not THREADWORK}
    g_Terminated      : Boolean = False;
{$IFEND}

implementation

uses Forms,Main,HumDB;

{ TMainWorkThread }

constructor TMainWorkThread.Create(CreateSupsbended: Boolean);
var
  I: Integer;
begin
  Inherited Create{$IF THREADWORK}(CreateSupsbended){$IFEND};
  for I := Low(m_MainHumLists) to High(m_MainHumLists) do
    m_MainHumLists[I] := TStringList.Create;
  for I := Low(m_MainIDLists) to High(m_MainIDLists) do
    m_MainIDLists[I]  := TStringList.Create;
  for I := Low(m_SubIDLists) to High(m_SubIDLists) do
    m_SubIDLists[I] := TStringList.Create;

  m_nTotalMax     := 0;
  m_nTotalPostion := 0;
  m_nCurMax       := 0;
  m_nCurPostion   := 0;
  m_nFailed       := 0;
  m_nNewItemIndex := 0;
  f_MainIDH       := 0;
  f_MainHumH      := 0;
  f_MainMirH      := 0;

  for I := Low(IDChangedLists) to High(IDChangedLists) do
    IDChangedLists[I]   := TStringList.Create;
  for I := Low(IDOldLists) to High(IDOldLists) do
    IDOldLists[I]       := TStringList.Create;

  OldSellOffItemList:= TList.Create;//旧的元宝寄售数据 20080601
  m_StorageList:= TList.Create;//无限仓库列表 20080601
  g_MainTxtList:= TList.Create;//主库文本列表 20080703
  g_DeputyTxtList:= TList.Create;//从库文本列表 20080703
  NameChangedList := TStringList.Create;
  NameOldList     := TStringList.Create;
  m_sMainGuildList:= TStringList.Create;
  m_sGuildChangedList := TStringList.Create;
end;

destructor TMainWorkThread.Destroy;
var
  I,II: Integer;
begin
  for I := Low(m_MainHumLists) to High(m_MainHumLists) do FreeAndNil(m_MainHumLists[I]);
  for I := Low(m_MainIDLists) to High(m_MainIDLists) do FreeAndNil(m_MainIDLists[I]);
  for I := Low(m_SubIDLists) to High(m_SubIDLists) do FreeAndNil(m_SubIDLists[I]);

  for I := Low(IDChangedLists) to High(IDChangedLists) do FreeAndNil(IDChangedLists[I]);
  for I := Low(IDOldLists) to High(IDOldLists) do FreeAndNil(IDOldLists[I]);

  for I:=0 to OldSellOffItemList.count -1 do begin//旧的元宝寄售数据 20080601
    Dispose(pTDealOffInfo(OldSellOffItemList.Items[I]));
  end;
  FreeAndNil(OldSellOffItemList);

  for I:=0 to m_StorageList.count -1 do begin//无限仓库列表 20080601
    Dispose(pTBigStorage(m_StorageList.Items[I]));
  end;
  FreeAndNil(m_StorageList);

  for I:=0 to g_MainTxtList.Count -1 do begin
    if pTTxtData(g_MainTxtList.Items[I]) <> nil then begin
       if pTTxtData(g_MainTxtList.Items[I]).sData.Count > 0 then begin
         for II:= 0 to pTTxtData(g_MainTxtList.Items[I]).sData.Count - 1 do begin
           Dispose(pTTxtInfo(pTTxtData(g_MainTxtList.Items[I]).sData.Items[II]));
         end;
       end;
       pTTxtData(g_MainTxtList.Items[I]).sData.Free;
       Dispose(pTTxtData(g_MainTxtList.Items[I]));
    end;//pTTxtData
  end;
  FreeAndNil(g_MainTxtList);//主库文本列表 20080703

  for I:=0 to g_DeputyTxtList.Count -1 do begin
    if pTTxtData(g_DeputyTxtList.Items[I]) <> nil then begin
       if pTTxtData(g_DeputyTxtList.Items[I]).sData.Count > 0 then begin
         for II:= 0 to pTTxtData(g_DeputyTxtList.Items[I]).sData.Count - 1 do begin
           Dispose(pTTxtInfo(pTTxtData(g_DeputyTxtList.Items[I]).sData.Items[II]));
         end;
       end;
       pTTxtData(g_DeputyTxtList.Items[I]).sData.Free;
       Dispose(pTTxtData(g_DeputyTxtList.Items[I]));
    end;//pTTxtData
  end;
  FreeAndNil(g_DeputyTxtList);//从库文本列表 20080703

  FreeAndNil(NameChangedList);
  FreeAndNil(NameOldList);
  FreeAndNil(m_sMainGuildList);
  FreeAndNil(m_sGuildChangedList);
  inherited Destroy;
end;

procedure TMainWorkThread.Execute;
var
  I: Integer;
begin
  inherited;
  m_sWorkingFor:= '正在读取数据...';
  m_nTotalMax:= GetMaxWorkCount {* 2};
  m_nTotalPostion := 0;

  m_sCurMessage := '正在读取主库数据...';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};

  LoadIDDB(m_sMainRoot + '\LoginSrv\IDDB\ID.DB', m_MainIDLists);
  LoadHumDB(m_sMainRoot + '\DBServer\FDB\Hum.DB', m_MainHumLists);

  if boSellOffItem then LoadSellOffItemList(FrmMain.Envir2.text+'\UserData\UserData.dat' ,OldSellOffItemList);//读取从库元宝寄售数据 20080601
  if boBigStorage then LoadBigStorageList(FrmMain.Envir2.text+'\Market_Storage\UserStorage.db', m_StorageList);//读取从库无限仓库数据 20080601

  if FileExists(m_sMainRoot + '\Mir200\GuildBase\GuildList.txt') then begin
     m_sMainGuildList.LoadFromFile(m_sMainRoot + '\Mir200\GuildBase\GuildList.txt');
    (m_sMainGuildList as TStringList).Sort;
  end;

  LoadTxtDataToList(FrmMain.ListViewTxt1,g_MainTxtList);//读取主库文本内存到列表 20080703
  LoadTxtDataToList(FrmMain.ListViewTxt2,g_DeputyTxtList);//读取从库文本内存到列表 20080703
  //m_nTotalPostion := 0;
  Sleep(1);

  m_sWorkingFor := '正在合并数据...';
  m_sCurMessage := '正在读取数据';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  //LoadIDDB(m_WorkRoots[I] + '\LoginSrv\IDDB', m_SubIDLists);
  LoadIDDB(FrmMain.ID_DB2.text, m_SubIDLists);

  m_sCurMessage := '正在合并数据......';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  //合并
  MakeInOne(FrmMain.GuildBase2.text);

  m_sWorkingFor := '重排物品编号...';
  ReSetItemsIndex;//重新编写物品编号
  for I := Low(IDChangedLists) to High(IDChangedLists) do
    if IDChangedLists[I].Count  > 0 then begin
      SaveIDChangeList;//保存ID变更记录
      Break;
    end;
      
  if NameChangedList.Count > 0 then SaveNameChangeList;//保存名字变更记录
  if m_sMainGuildList.Count > 0 then m_sMainGuildList.SaveToFile(m_sMainRoot + '\Mir200\GuildBase\GuildList.txt');//保存行会数据
  if m_sGuildChangedList.Count > 0 then m_sGuildChangedList.SaveToFile(ExtRactFilePath(Application.ExeName) + '行会变更.txt');
  if f_MainMirH > 0 then FileClose(f_MainMirH);
  m_sWorkingFor := '合区完成!';

  m_sCurMessage := '合区完成';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  FrmMain.Button3.Enabled := True;
end;

function TMainWorkThread.GetFileSize(const sFile: string; const OffSet,
  DefSize: Integer): Integer;
var
  Sc: TSearchRec;
begin
  if FindFirst(sFile, faAnyFile, Sc) = 0 then
    Result  := (Sc.Size - OffSet) div DefSize
    else Result  := 0;
  if Result < 0 then
    Result  := 0;
end;

function TMainWorkThread.GetMaxWorkCount: Integer;
var
  {I,} nC: Integer;
begin
  m_sCurMessage := '正在统计数据...';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  nC  := 0;
{  Inc(nC, GetFileSize(m_sMainRoot + '\IDDB\ID.DB', 120, Sizeof(TMirID)));
  Inc(nC, GetFileSize(m_sMainRoot + '\FDB\HUM.db', Sizeof(TDBFileHeader), Sizeof(TDBHum)));
  Inc(nC, GetFileSize(m_sMainRoot + '\FDB\MIR.DB', Sizeof(TDBFileHeader), Sizeof(THumData)));   }

    begin
      //Inc(nC,GetFileSize( m_WorkRoots[I] + '\IDDB\ID.DB', 120, Sizeof(TMirID)));
      Inc(nC, GetFileSize(FrmMain.{Edit1}Hum_db2.text+ '\DBServer\FDB\HUM.db', Sizeof(TDBHeader), Sizeof(TDBHum)));
      //Inc(nC, GetFileSize(m_WorkRoots[I] + '\FDB\MIR.DB', Sizeof(TDBFileHeader), Sizeof(THumData)));
      Sleep(1);
    end;
  Result  := nC;
end;
//读取人物数据 20071122
procedure TMainWorkThread.LoadHumDB(const sRoot: string; ListArray: TListArray);
var
  f_H: THandle;
  DBHum: TDBHum;
  nCIDX, nC: Integer;
begin
  if not FileExists(sRoot) then begin
    //Raise Exception.Create('找不到文件:'+sRoot);
    m_sCurMessage := '找不到文件:' + sRoot ;
   {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  end;
  f_H := FileOpen(sRoot, 0);
  if f_H <= 0 then begin
    // Raise Exception.Create('打开文件失败! ' + #13 + sRoot);
    m_sCurMessage := '打开文件失败!' + sRoot ;
   {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  end;
  m_sCurMessage := '正在读取: ' + sRoot ;
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  FileSeek(f_H, Sizeof(TDBHeader1), 0);
  nC  := 0;
  m_nCurMax := GetFileSize(sRoot, Sizeof(TDBHeader1), Sizeof(TDBHum));
  while FileRead(f_H, DBHum, Sizeof(DBHum)) = Sizeof(DBHum) do
    begin
      nCIDX :=  GetWWIndex(DBHum.sChrName);
      ListArray[nCIDX].AddObject(DBHum.sChrName, TObject(nC));
      Inc(nC);

      //m_sCurMessage := '角色名('+IntToStr(nC)+'): ' + DBHum.sChrName;
      //{$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};

      //Inc(m_nCurPostion);
      //Inc(m_nTotalPostion);
      {$IF THREADWORK}if Self.Terminated then Break;
      {$ELSE}
        if g_Terminated then Break;
        Application.ProcessMessages;
      {$IFEND}
    end;
  m_sCurMessage := '已读取 ' + IntToStr(nC) + ' 个人物';
  for nC := Low(ListArray) to High(ListArray) do
    (ListArray[nC] as TStringList).Sort;
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  FileClose(f_H);
end;

//读取ID.db数据  20071122
procedure TMainWorkThread.LoadIDDB(const sRoot: string; ListArray: TListArray);
var
  f_H: THandle;
  ID: TAccountDBRecord;
  nCIDX, nC: Integer;
begin
  if not FileExists(sRoot) then begin
    //Raise Exception.Create('找不到文件:'+sRoot );
    m_sCurMessage := '找不到文件: ' + sRoot;
   {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  end;
  f_H := FileOpen(sRoot, 0);
  if f_H <= 0 then begin
    //Raise Exception.Create('打开文件失败! ' + #13 + sRoot);
    m_sCurMessage := '打开文件失败! ' + sRoot;
   {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  end;

  m_sCurMessage := '正在读取: ' + sRoot;
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};

  FileSeek(f_H,Sizeof(TDBHeader), 0);
  nC  := 0;
  m_nCurMax := GetFileSize(sRoot, Sizeof(TDBHeader), Sizeof(TAccountDBRecord));
  m_nCurPostion := 0;

  while FileRead(f_H, ID, Sizeof(ID)) = Sizeof(ID) do
    begin
      nCIDX :=  GetWWIndex(ID.UserEntry.sAccount);
      ListArray[nCIDX].AddObject(ID.UserEntry.sAccount, TObject(nC));
      Inc(nC);
      
      //m_sCurMessage := '正在读取账号('+IntToStr(nC)+'): ' +ID.UserEntry.sAccount;
      //{$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};

      {$IF THREADWORK}if Self.Terminated then Break;
      {$ELSE}
        if g_Terminated then Break;
        Application.ProcessMessages;
      {$IFEND}
    end;
  m_sCurMessage := '已读取 ' + IntToStr(nC) + ' 个ID';
  for nC := Low(ListArray) to High(ListArray) do
    (ListArray[nC] as TStringList).Sort;
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  FileClose(f_H);
end;
//读取元宝寄售数据
procedure TMainWorkThread.LoadSellOffItemList(const sRoot: string; SellOffItemList:TList);
var
  f_H: THandle;
  DealOffInfo: pTDealOffInfo;
  sDealOffInfo: TDealOffInfo;
begin
  if not FileExists(sRoot) then  Exit{Raise Exception.Create('找不到文件:'+sRoot )};
  f_H := FileOpen(sRoot, fmOpenRead or fmShareDenyNone);
  if f_H <= 0 then Raise Exception.Create('打开文件失败! ' + #13 + sRoot);
  if SellOffItemList = nil then Exit;
  if f_H > 0 then begin
    try
      while FileRead(f_H, sDealOffInfo, Sizeof(TDealOffInfo)) = Sizeof(TDealOffInfo) do begin// 循环读出人物数据
        New(DealOffInfo);
        DealOffInfo.sDealCharName:= sDealOffInfo.sDealCharName;
        DealOffInfo.sBuyCharName:= sDealOffInfo.sBuyCharName;
        DealOffInfo.dSellDateTime:= sDealOffInfo.dSellDateTime;
        DealOffInfo.nSellGold:= sDealOffInfo.nSellGold;
        DealOffInfo.UseItems:= sDealOffInfo.UseItems;
        DealOffInfo.N:= sDealOffInfo.N;
        SellOffItemList.Add(DealOffInfo);
      end;
    except
    end;
    FileClose(f_H);
  end;
end;

//保存元宝寄售数据
procedure TMainWorkThread.SaveSellOffItemList(const sRoot: string; SellOffItemList:TList);
var
  FileHandle: Integer;
  DealOffInfo: pTDealOffInfo;
  I: Integer;
begin
  if FileExists(sRoot) then DeleteFile(sRoot);
  FileHandle := FileCreate(sRoot);
  FileClose(FileHandle);
  if FileExists(sRoot) then begin
    FileHandle := FileOpen(sRoot, fmOpenWrite or fmShareDenyNone);
    if FileHandle > 0 then begin
     FileSeek(FileHandle, 0, 0);
     try
       for I:= 0 to SellOffItemList.Count -1 do begin
         DealOffInfo:=pTDealOffInfo(SellOffItemList.Items[I]);
         FileWrite(FileHandle, DealOffInfo^, SizeOf(TDealOffInfo));
       end;
      except
      end;
      FileClose(FileHandle);
    end;
  end;
end;

//读取无限仓库数据
procedure TMainWorkThread.LoadBigStorageList(const sRoot: string; m_StorageList:TList);
var
  f_H: THandle;
  BigStorage: pTBigStorage;
  sTBigStorage: TBigStorage;
begin
  if not FileExists(sRoot) then  Exit;{Raise Exception.Create('找不到文件:'+sRoot )};
  f_H := FileOpen(sRoot, fmOpenRead or fmShareDenyNone);
  if f_H <= 0 then Raise Exception.Create('打开文件失败! ' + #13 + sRoot);
  if m_StorageList = nil then Exit;
  if f_H > 0 then begin
   try
    while FileRead(f_H, sTBigStorage, Sizeof(TBigStorage)) = Sizeof(TBigStorage) do begin// 循环读出数据
      New(BigStorage);
      BigStorage.boDelete:= sTBigStorage.boDelete;
      BigStorage.sCharName:= sTBigStorage.sCharName;
      BigStorage.SaveDateTime:= sTBigStorage.SaveDateTime;
      BigStorage.UseItems:= sTBigStorage.UseItems;
      BigStorage.nCount:= sTBigStorage.nCount;
      m_StorageList.Add(BigStorage);
    end;
    except
    end;
    FileClose(f_H);
  end;
end;

//保存无限仓库数据
procedure TMainWorkThread.SaveBigStorageList(const sRoot: string; m_StorageList:TList);
var
  FileHandle: Integer;
  BigStorage: pTBigStorage;
  I: Integer;
begin
  if FileExists(sRoot) then DeleteFile(sRoot);
  FileHandle := FileCreate(sRoot);
  FileClose(FileHandle);
  if FileExists(sRoot) then begin
    FileHandle := FileOpen(sRoot, fmOpenWrite or fmShareDenyNone);
    if FileHandle > 0 then begin
     FileSeek(FileHandle, 0, 0);
     try
       for I:= 0 to m_StorageList.Count -1 do begin
         BigStorage:=pTBigStorage(m_StorageList.Items[I]);
         FileWrite(FileHandle, BigStorage^, SizeOf(TBigStorage));
       end;
      except
      end;
      FileClose(FileHandle);
    end;
  end;
end;

//截取字符串
//例 ArrestStringEx('[1234]','[',']',str)    str=1234
function ArrestStringEx(Source, SearchAfter, ArrestBefore: string; var ArrestStr: string): string;
var
  srclen: Integer;
  GoodData : Boolean;
  I, N: Integer;
begin
  ArrestStr := ''; {result string}
  if Source = '' then begin
    Result := '';
    Exit;
  end;

  try
    srclen := Length(Source);
    GoodData := False;
    if srclen >= 2 then
      if Source[1] = SearchAfter then begin
        Source := Copy(Source, 2, srclen - 1);
        srclen := Length(Source);
        GoodData := True;
      end else begin
        N := Pos(SearchAfter, Source);
        if N > 0 then begin
          Source := Copy(Source, N + 1, srclen - (N));
          srclen := Length(Source);
          GoodData := True;
        end;
      end;
    if GoodData then begin
      N := Pos(ArrestBefore, Source);
      if N > 0 then begin
        ArrestStr := Copy(Source, 1, N - 1);
        Result := Copy(Source, N + 1, srclen - N);
      end else begin
        Result := SearchAfter + Source;
      end;
    end else begin
      for I := 1 to srclen do begin
        if Source[I] = SearchAfter then begin
          Result := Copy(Source, I, srclen - I + 1);
          Break;
        end;
      end;
    end;
  except
    ArrestStr := '';
    Result := '';
  end;
end;

function GetValidStr3(Str: string; var Dest: string; const Divider: array of Char): string;
const
  BUF_SIZE = 20480; //$7FFF;
var
  buf: array[0..BUF_SIZE] of Char;
  BufCount, Count, srclen, I, ArrCount: LongInt;
  Ch: Char;
label
  CATCH_DIV;
begin
  Ch := #0; //Jacky
  try
    srclen := Length(Str);
    BufCount := 0;
    Count := 1;

    if srclen >= BUF_SIZE - 1 then begin
      Result := '';
      Dest := '';
      Exit;
    end;

    if Str = '' then begin
      Dest := '';
      Result := Str;
      Exit;
    end;
    ArrCount := SizeOf(Divider) div SizeOf(Char);

    while True do begin
      if Count <= srclen then begin
        Ch := Str[Count];
        for I := 0 to ArrCount - 1 do
          if Ch = Divider[I] then
            goto CATCH_DIV;
      end;
      if (Count > srclen) then begin
        CATCH_DIV:
        if (BufCount > 0) then begin
          if BufCount < BUF_SIZE - 1 then begin
            buf[BufCount] := #0;
            Dest := string(buf);
            Result := Copy(Str, Count + 1, srclen - Count);
          end;
          Break;
        end else begin
          if (Count > srclen) then begin
            Dest := '';
            Result := Copy(Str, Count + 2, srclen - 1);
            Break;
          end;
        end;
      end else begin
        if BufCount < BUF_SIZE - 1 then begin
          buf[BufCount] := Ch;
          Inc(BufCount);
        end; // else
      end;
      Inc(Count);
    end;
  except
    Dest := '';
    Result := '';
  end;
end;

//读取文本内存到列表 20080703
procedure TMainWorkThread.LoadTxtDataToList(ListView: TRzListView ; m_Txt:TList);
var
  I,K: Integer;
  TxtData:pTTxtData;
  TxtInfo:pTTxtInfo;
  LoadList: TStringList;
  sFileName, s18: string;
  nTxtTpye: Byte;//文本类型
  s11,s12,s13:string;
begin
try
  if ListView.Items.Count > 0 then begin
    LoadList := TStringList.Create;
    try
    for I:=0 to ListView.Items.Count - 1 do begin
      sFileName := ListView.Items.Item[I].Caption;
      LoadList.LoadFromFile(sFileName);
        if (LoadList.Text <> '') then begin //区别文本类型
          s18 := LoadList.Strings[0];
          nTxtTpye:= 0;
          if s18[1] = '[' then nTxtTpye:= 1;
          new(TxtData);
          TxtData.nTxtTpye:= nTxtTpye;//文本类型
          TxtData.sFileName:=ExtractFileName(sFileName);//文件名
          TxtData.sData:= TList.Create ;
          TxtData.boMakeOne := False;

          for K:= 0 to LoadList.Count - 1 do begin
            s18 := LoadList.Strings[K];
            if (Trim(s18) <> '') and (s18[1] <> ';') then begin
              Case TxtData.nTxtTpye of
                0:begin
                    New(TxtInfo);
                    TxtInfo.sHumName := s18;
                    TxtInfo.sKeyword:='';
                    TxtInfo.sIniValue:='';
                    if (TxtData.sData <> nil) and (TxtInfo <> nil) then TxtData.sData.Add(TxtInfo);
                 end;
                1:begin
                    if s18[1]= '[' then begin//节点
                       ArrestStringEx(s18, '[', ']', s11);//S11-[]里的内容
                       Continue;
                    end;
                   if pos('=',s18)> 0 then begin
                       s13:=GetValidStr3(s18, s12, ['=']);
                       New(TxtInfo);
                       TxtInfo.sHumName:= S11;//节点名
                       TxtInfo.sKeyword:=Trim(s12);
                       TxtInfo.sIniValue:=Trim(s13);
                       if (TxtData.sData <> nil) and (TxtInfo <> nil) then TxtData.sData.Add(TxtInfo);  //
                    end;
                end;//1
              end;//case
            end;
          end;//for K
          if TxtData <> nil then  m_Txt.Add(TxtData);
        end else copyfile(pchar(sFileName), pchar(FrmMain.Edit1.text+'\NEW文本数据\'+ExtractFileName(sFileName)), false);
    end;//for I
    finally
    LoadList.Free;
    end;
  end;
  except
  end;
end;

//修改名字到文本内容列表 20080703
procedure TMainWorkThread.UpdateTxtDataToList(const sHumName,sNewHumName: string; m_Txt:TList);
var
  I,K: Integer;
  TxtData:pTTxtData;
  TxtInfo:pTTxtInfo;
begin
  if m_Txt.Count <= 0 then Exit;
  Try
   for I:= 0 to m_Txt.Count -1 do begin
     TxtData := pTTxtData(m_Txt.Items[I]);
     if TxtData <> nil then begin
        if TxtData.sData.Count > 0 then begin
          for K:= 0 to TxtData.sData.Count -1 do begin
            TxtInfo:=pTTxtInfo(TxtData.sData.Items[K]);
            if TxtInfo <> nil then begin
               if CompareText(Trim(TxtInfo.sHumName), Trim(sHumName))= 0 then begin
                 TxtInfo.sHumName:= sNewHumName;
               end;
            end;
          end;
        end;
     end;//if TxtData <> nil
   end;
  except
  end;
end;

//保存文本内容 20080703
procedure TMainWorkThread.SaveListToTxt(sRoot: string; m_MainTxt, DeputyTxt:TList);
var
  I,K,J: Integer;
  TxtData,TxtData1:pTTxtData;
  TxtInfo1:pTTxtInfo;
  SaveList: TStringList;//普通文件保存
  IniFile: TIniFile;//Ini文件
  nCode:Byte;
begin
  SaveList:= TStringList.Create ;
  nCode:=0;
  try
    if DeputyTxt.Count > 0 then begin
      if m_MainTxt.Count > 0 then begin
        for I:= 0 to m_MainTxt.Count -1 do begin
          if pTTxtData(m_MainTxt.Items[I]) <> nil then begin
            TxtData:=pTTxtData(m_MainTxt.Items[I]);
            if TxtData.nTxtTpye <> 0 then Continue;
            for K:= 0 to DeputyTxt.Count -1 do begin
              TxtData1:=pTTxtData(DeputyTxt.Items[K]);
              if TxtData1 <> nil then begin
                if (CompareText(Trim(TxtData.sFileName), Trim(TxtData1.sFileName))= 0) then begin
                   if TxtData1.sData.Count > 0 then begin
                      for J:=0 to TxtData1.sData.Count - 1 do begin
                         TxtInfo1:= pTTxtInfo(TxtData1.sData.Items[J]);
                         if TxtInfo1 <> nil then TxtData.sData.Add(TxtInfo1);
                      end;//for J
                   end;
                   TxtData1.boMakeOne := True;
                end;
              end;//TxtData1 <> nil
            end;//for K
          end;
        end;//for I   
      end;//if m_MainTxt.Count > 0
     nCode:=10;
      for I:=0 to DeputyTxt.Count -1 do begin
        nCode:=11;
        if pTTxtData(DeputyTxt.Items[I])<> nil then begin
           TxtData1:=pTTxtData(DeputyTxt.Items[I]);
           nCode:=12;
           if TxtData1.boMakeOne then Continue;
           case TxtData1.nTxtTpye of
             0:begin//普通文件
                SaveList.Clear;
                nCode:=13;
                if TxtData1.sData.Count > 0 then begin
                  nCode:=14;
                  for K:= 0 to TxtData1.sData.Count -1 do begin
                    nCode:=15;
                    TxtInfo1:=pTTxtInfo(TxtData1.sData.Items[K]);
                    SaveList.Add(TxtInfo1.sHumName);
                  end;
                end;
                nCode:=16;
                SaveList.SaveToFile(sRoot+'\'+TxtData1.sFileName);
             end;
             1:begin
                nCode:=17;
                IniFile := TIniFile.Create(sRoot+'\'+TxtData1.sFileName);
                nCode:=18;
                if TxtData1.sData.Count > 0 then begin
                  nCode:=19;
                  for K:= 0 to TxtData1.sData.Count -1 do begin
                    nCode:=20;
                    TxtInfo1:=pTTxtInfo(TxtData1.sData.Items[K]);
                    IniFile.Writestring(TxtInfo1.sHumName, TxtInfo1.sKeyword, TxtInfo1.sIniValue);
                  end;
                end;
                IniFile.free;
             end;//1
           end;//case
        end;
      end;//for I
    end;

    if m_MainTxt.Count > 0 then begin
     nCode:=21;
      for I:=0 to m_MainTxt.Count -1 do begin
        nCode:=22;
        TxtData1:=pTTxtData(m_MainTxt.Items[I]);
        if TxtData1 <> nil then begin
          nCode:=23;
          if (TxtData1<> nil) then begin
             case TxtData1.nTxtTpye of
               0:begin//普通文件
                  SaveList.Clear;
                  nCode:=24;
                  if TxtData1.sData.Count > 0 then begin
                    nCode:=25;
                    for K:= 0 to TxtData1.sData.Count -1 do begin
                      nCode:=26;
                      TxtInfo1:=pTTxtInfo(TxtData1.sData.Items[K]);
                      nCode:=27;
                      SaveList.Add(TxtInfo1.sHumName);
                    end;
                  end;
                  SaveList.SaveToFile(sRoot+'\'+TxtData1.sFileName);
               end;
               1:begin
                 nCode:=28;
                  IniFile := TIniFile.Create(sRoot+'\'+TxtData1.sFileName);
                  nCode:=34;
                  if TxtData1.sData.Count > 0 then begin
                    nCode:=30;
                    for K:= 0 to TxtData1.sData.Count -1 do begin
                      nCode:=31;
                      TxtInfo1:=pTTxtInfo(TxtData1.sData.Items[K]);
                      nCode:=32;
                      IniFile.Writestring(TxtInfo1.sHumName, TxtInfo1.sKeyword, TxtInfo1.sIniValue);
                    end;
                  end;
                  IniFile.Free;
               end;//1
             end;//case
          end;
        end;
      end;//for I
    end;//if m_MainTxt.Count > 0    }
  except
    m_sCurMessage := '[异常] 文本合并'+ inttostr(nCode);
    {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  end;
  SaveList.Free;
end;

//合并数据
procedure TMainWorkThread.MakeInOne(sRoot: string);
var
  IDCount1,IDCount2,IDCount3:integer;//ID数量
  m_Header: TDBHeader; //ID数据库头
  m_Header1,m_Header2: TDBHeader1; //人物数据库头
  
  f_IDH, f_HumH, f_MirH: THandle;
  ID: TAccountDBRecord;
  DBHum: TDBHum;
  HumData:THumDataInfo;
  nCIDX, I, J, nStep, nC_01 : Integer;
  sName, sAccount: string;
  boReNameOK,boMirOK: Boolean;
  GuildList, HeroTempNameList : TStrings;
  TempIDLists: TListArray;

  DearDataList, MasterDataList, HeroDataList: TList;
  TDearData: pTDearData;
  TMasterData: PTMasterData;
  THeroData: pTHeroData;
  sFileName1, s001, s002, s003: string;
  LoadList: TStringList;
  sTempName: string;
  procedure ReThisHumInName(const sHumName: string; sNewHumName: string; nCode: Byte);//更新原库中配偶及师傅名 20080601
  var
    HumData:THumDataInfo;
    I, J: Integer;
    SearchRec: TSearchRec;
    sFileName, s01, s02: string;
    DealOffInfo: pTDealOffInfo;
    TMasterData: PTMasterData;
    BigStorage:pTBigStorage;
  begin
    //修改元宝寄售数据
    if boSellOffItem then begin
      if OldSellOffItemList.count > 0 then begin
        for I:=0 to OldSellOffItemList.Count - 1 do begin
          DealOffInfo:= pTDealOffInfo(OldSellOffItemList.Items[I]);
          if DealOffInfo <> nil then begin
            if CompareText(DealOffInfo.sDealCharName , sHumName)= 0 then begin
              DealOffInfo.sDealCharName:= sNewHumName;
              Break;
            end else
            if CompareText(DealOffInfo.sBuyCharName , sHumName)= 0 then begin
              DealOffInfo.sBuyCharName:= sNewHumName;
              Break;
            end;
          end;
        end;
      end;
    end;
    //修改无限仓库
    if boBigStorage then begin
      if m_StorageList.count > 0 then begin
        for I:=0 to m_StorageList.Count - 1 do begin
          BigStorage:= pTBigStorage(m_StorageList.Items[I]);
          if BigStorage <> nil then begin
            if CompareText(BigStorage.sCharName , sHumName)= 0 then begin
              BigStorage.sCharName:= sNewHumName;
              Break;
            end;
          end;
        end;
      end;
    end;
    sFileName:= FrmMain.Envir2.text+'\MasterNo\';
    if DirectoryExists(sFileName) then begin//判断目录是否存在 20080703
      if FindFirst(sFileName+ sHumName+'.txt', 1, SearchRec)= 0 then begin //师徒文件存在,则改名
        Renamefile(sFileName+ sHumName+'.txt',sFileName+ sNewHumName+'.txt');//文件更名
        LoadList := TStringList.Create;
        LoadList.LoadFromFile(sFileName+ sNewHumName +'.txt');
        for J := 0 to LoadList.Count - 1 do begin
          s01 := Trim(LoadList.Strings[J]);
          if (s01 <> '') and (s01[1] <> ';') then begin
            s01 := GetValidStr3(s01, s02, [' ', #9]);//徒弟名
            try
              if HumDataDB1.OpenEx then begin
                I := HumDataDB1.Index(s02);
                if I >= 0 then begin
                  if HumDataDB1.Get(I, HumData) >= 0 then begin
                    if HumData.Data.sMasterName <> '' then begin
                      New(TMasterData);
                      TMasterData.sName:= HumData.Data.sChrName;
                      TMasterData.sMasterName:= sNewHumName;
                      TMasterData.sNewHumName:= HumData.Data.sChrName;
                      MasterDataList.Add(TMasterData);
                    end;
                  end;
                end;
              end;
            finally
              HumDataDB1.Close;
            end;
          end;
        end;
        LoadList.Free;
      end;
    end;
  end;
  procedure ReDearList(const sHumName: string; sNewHumName: string);//修改配偶列表
  var
    I: Integer;
    TDearData: pTDearData;
    boIsDear: Boolean;
    HumData:THumDataInfo;
  begin
    boIsDear:= False;
    if DearDataList.Count > 0 then begin
      for I:=0 to DearDataList.Count - 1 do begin
        TDearData:= pTDearData(DearDataList.Items[I]);
        if CompareText(TDearData.sDearName, sHumName)= 0 then begin
          TDearData.sDearName:= sNewHumName;
          boIsDear:= True;
          Break;
        end;
      end;
    end;
    if not boIsDear then begin
      try
        if HumDataDB1.OpenEx then begin
          I := HumDataDB1.Index(sHumName);
          if I >= 0 then begin
            HumDataDB1.Get(I, HumData);
            if HumData.Data.sDearName <> '' then begin//有配偶
              New(TDearData);
              TDearData.sDearName:= HumData.Data.sDearName{sHumName};
              TDearData.sNewHumName:= sNewHumName;
              DearDataList.Add(TDearData);
            end;
          end;
        end;
      finally
        HumDataDB1.Close;
      end;
    end;
  end;
  procedure ReHeroList(const sHumName: string; sNewHumName: string; nCode:Byte);//修改英雄列表
  var
    HumData:THumDataInfo;
    I: Integer;
    THeroData: pTHeroData;
    boIsHero: Boolean;
  begin
    boIsHero:= False;
    Case nCode of
      0:begin
        if HeroDataList.Count > 0 then begin
          for I:=0 to HeroDataList.Count - 1 do begin
            THeroData:= pTHeroData(HeroDataList.Items[I]);
            if CompareText(THeroData.sHeroName , sHumName)= 0 then begin
              THeroData.sNewHumName:= sNewHumName;
              boIsHero:= True;
              Break;
            end;
          end;
        end;
        if not boIsHero then begin
          try
            if HumDataDB1.OpenEx then begin
              I := HumDataDB1.Index(sHumName);
              if I >= 0 then begin
                HumDataDB1.Get(I, HumData);
                if CompareText(HumData.Data.sChrName, sHumName)= 0 then begin//英雄名相同
                   New(THeroData);
                   THeroData.sHeroName:= sHumName;
                   THeroData.sNewHumName:= sNewHumName;
                   THeroData.sMasterName:= HumData.Data.sMasterName;
                   HeroDataList.Add(THeroData);
                end;
              end;
            end;
          finally
            HumDataDB1.Close;
          end;
        end;
      end;//0
      1: begin
        if HeroDataList.Count > 0 then begin
          for I:=0 to HeroDataList.Count - 1 do begin
            THeroData:= pTHeroData(HeroDataList.Items[I]);
            if CompareText(THeroData.sMasterName , sHumName)= 0 then begin
              THeroData.sMasterName:= sNewHumName;
            end;
          end;
        end;
      end;//1
    end;//case
  end;
  procedure ReThisHumInMasterNo(const sHumName: string; sNewHumName: string);
  var
    HumData:THumDataInfo;
    I: Integer;
    boIsMasterNo: Boolean;
  begin
    boIsMasterNo:= False;
    if MasterDataList.Count > 0 then begin
      for I:= 0 to MasterDataList.Count - 1 do begin
        TMasterData:= PTMasterData(MasterDataList.Items[I]);
        if CompareText(Trim(TMasterData.sMasterName), sHumName)= 0 then begin//师傅改名
          TMasterData.sMasterName:= sNewHumName;
          boIsMasterNo:= True;
          Break;
        end;
        if CompareText(Trim(TMasterData.sName), sHumName)= 0 then begin//徒弟改名
          TMasterData.sNewHumName:= sNewHumName;
          boIsMasterNo:= True;
          Break;
        end;
      end;
    end;
    if not boIsMasterNo then begin
      try
        if HumDataDB1.OpenEx then begin
          I := HumDataDB1.Index(sHumName);
          if I >= 0 then begin
            HumDataDB1.Get(I, HumData);
            if (HumData.Data.sMasterName <> '') and (not HumData.Data.boIsHero) then begin//是徒弟
              New(TMasterData);
              TMasterData.sName:= sHumName;
              TMasterData.sMasterName:= HumData.Data.sMasterName;
              TMasterData.sNewHumName:= sNewHumName;
              MasterDataList.Add(TMasterData);
            end;
          end;
        end;
      finally
        HumDataDB1.Close;
      end;
    end;
  end;
  procedure ReThisHumInGuild(const sHumName: string; sNewHumName: string);
  var
    SL: TStrings;
    Sc: TSearchRec;
    n_0023C : Integer;
  begin
    SL  := TStringList.Create;
    if FindFirst(sRoot + '\Guilds\*.txt', faAnyFile, Sc) = 0 then begin
      SL.LoadFromFile(sRoot + '\Guilds\' + Sc.Name);
      n_0023C := SL.IndexOf('+' + sHumName);
      if n_0023C > -1 then begin
        SL.Strings[n_0023C] := '+' + sNewHumName;
        SL.SaveToFile(sRoot + '\Guilds\' + Sc.Name);
        SL.Free;
        Exit;
      end;
    end;
    while FindNext(Sc) = 0 do begin
      SL.LoadFromFile(sRoot + '\Guilds\' + Sc.Name);
      n_0023C := SL.IndexOf('+' + sHumName);
      if n_0023C > -1 then begin
        SL.Strings[n_0023C] := sNewHumName;
        SL.SaveToFile(sRoot + '\Guilds\' + Sc.Name);
        SL.Free;
        Exit;
      end;
      Application.ProcessMessages;
    end;
    SL.Free;
  end;
begin
  Copyfile(pchar(FrmMain.Mir_db2.text), pchar(ExtractFilePath(FrmMain.Mir_db2.text)+'Mir1.DB'), false);//20081019
  HumDataDB1 := TFileDB.Create(ExtractFilePath(FrmMain.Mir_db2.text)+'Mir1.DB');//20081019 建立从库索引文件

  DearDataList:= TList.Create;
  MasterDataList:= TList.Create;
  HeroDataList:= TList.Create;

  IDCount1:=0;
  IDCount2:=0;
  IDCount3:=0;
  if f_MainIDH = 0 then f_MainIDH := FileOpen(Self.m_sMainRoot + '\LoginSrv\IDDB\Id.db', fmOpenReadWrite);
  if f_MainHumH = 0 then f_MainHumH  := FileOpen(Self.m_sMainRoot + '\DBServer\FDB\Hum.db', fmOpenReadWrite);
  if f_MainMirH = 0 then f_MainMirH  := FileOpen(Self.m_sMainRoot + '\DBServer\FDB\Mir.db', fmOpenReadWrite);
//打开从库数据文件  20071122
  f_IDH := FileOpen(FrmMain.ID_DB2.text, 0);
  f_HumH  := FileOpen(FrmMain.Hum_db2.text, 0);
  f_MirH  := FileOpen(FrmMain.Mir_db2.text, fmOpenReadWrite);//20080601 修改从库数据

  FileSeek(f_MainIDH, 0, 0);
  if FileRead(f_MainIDH, m_Header, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then IDCount1 := m_Header.nIDCount;
  FileSeek(f_MainHumH, 0, 0);
  if FileRead(f_MainHumH, m_Header1, SizeOf(TDBHeader1)) = SizeOf(TDBHeader1) then IDCount2 := m_Header1.nHumCount;
  FileSeek(f_MainMirH, 0, 0);
  if FileRead(f_MainMirH, m_Header2, SizeOf(TDBHeader1)) = SizeOf(TDBHeader1) then IDCount3 := m_Header2.nHumCount;

  m_nCurMax  := GetFileSize(FrmMain.Hum_db2.text, Sizeof(TDBHeader1), Sizeof(TDBHum));
  
  m_nCurPostion := 0;
  for I := Low(TempIDLists) to HIgh(TempIDLists) do TempIDLists[I]:= TStringList.Create;

//----------------------------英雄先合------------------------------------------
  HeroTempNameList := TStringList.Create;//20081129
  FileSeek(f_HumH, Sizeof(TDBHeader1), 0);//0---从文件头开始定位
  while FileRead(f_HumH, DBHum, Sizeof(DBHum)) = Sizeof(DBHum) do begin //T 循环读出人物数据
    if boDelDenyChr and DBHum.boDeleted then Continue;//清除人物(已删除)
    if not DBHum.Header.boIsHero then Continue;//不是英雄跳过
    nStep := 0;
    try
      FillChar(HumData, SizeOf(THumDataInfo), #0);//20081128 增加
      sName := DBHum.sChrName;
      nCIDX := GetWWIndex(DBHum.sChrName);
      nStep := 1;

      if m_MainHumLists[nCIDX].IndexOf(sName) > -1 then begin//T
        nStep := 2;
        boReNameOK  := False;
        for I := Ord('a') to Ord('z') do begin
          sTempName := _Max14ReName(sName, Chr(I));
          if not (m_MainHumLists[nCIDX].IndexOf(sTempName) > -1) then begin
            boReNameOK := True;
            sName:= sTempName;
            m_MainHumLists[nCIDX].Add(sName);
            Break;
          end;
        end;
        if not boReNameOK then
          while True do begin
            sName := IntToHex(Random(MaxInt), 14);
            if not (m_MainHumLists[nCIDX].IndexOf(sName) > -1) then begin
              m_MainHumLists[nCIDX].Add(sName);
              Break;
            end;
          end;
        nStep := 3;
        ReHeroList(DBHum.sChrName, sName, 0);
        Self.NameChangedList.Add(sName);//写入改名列表
        Self.NameOldList.Add(DBHum.sChrName);//写入旧的名字列表
      end;
      nStep := 4;

      try
        if HumDataDB1.OpenEx then begin
          I := HumDataDB1.Index(DBHum.sChrName);
          if I >= 0 then begin
            HumDataDB1.Get(I, HumData);
          end else begin
            m_sCurMessage := '错误(保存英雄失败):'+ DBHum.sChrName + '  数据不匹配!';
            {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
            Inc(m_nFailed);
            Inc(m_nTotalPostion);
            Inc(m_nCurPostion);
            Continue;
          end;
        end;
      finally
        HumDataDB1.Close;
      end;
      
      HeroTempNameList.Add(DBHum.sChrName);//把英雄原名写入临时列表中，以加速人物合并时的速度 20081129
      DBHum.Header.sName  := sName;
      DBHum.sChrName      := sName;
      HumData.Data.sChrName:= sName;
      HumData.Header.sName:=sName;
      nStep := 5;
      nCIDX := GetWWIndex(DBHum.sAccount);
      J := m_SubIDLists[nCIDX].IndexOf(DBHum.sAccount);
      if J < 0 then begin //T
        m_sCurMessage := '错误(保存英雄失败):' + DBHum.sChrName + ' 没有匹配的帐号!';
        {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
        Inc(m_nFailed);
        Inc(m_nTotalPostion);
        Inc(m_nCurPostion);
        Continue;
      end;
      nStep := 6;
      FileSeek(f_IDH, Sizeof(TDBHeader) + Sizeof(TAccountDBRecord) * Integer(m_SubIDLists[nCIDX].Objects[J]), 0);
      FileRead(f_IDH, ID, Sizeof(ID));
      sAccount  := ID.UserEntry.sAccount;
      //1
      if CompareText(sAccount, DBHum.sAccount) <> 0 then  begin //T
        m_sCurMessage := '错误(保存英雄失败):' + DBHum.sChrName + ' 帐号不匹配!';
        {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
        Inc(m_nFailed);
        Inc(m_nTotalPostion);
        Inc(m_nCurPostion);
        Continue;
      end;
      nStep := 7;
      //2
      nC_01 := IDOldLists[nCIDX].IndexOf(sAccount);
      if nC_01 > -1 then begin
        sAccount  := IDChangedLists[nCIDX].Strings[nC_01];
      end else begin
        if not (TempIDLists[nCIDX].IndexOf(sAccount) > - 1) then begin
          TempIDLists[nCIDX].Add(sAccount);
          if m_MainIDLists[nCIDX].IndexOf(sAccount) > -1 then begin
            boReNameOK  := False;
            nStep := 8;
            for I := Ord('a') to Ord('z') do begin
              sTempName := _Max10ReName(sAccount, Chr(I));
              if not (m_MainIDLists[nCIDX].IndexOf(sTempName) > -1) then begin
                boReNameOK := True;
                sAccount := sTempName;
                Break;
              end;
            end;
            if not boReNameOK then
              while True do begin
                sAccount := IntToHex(Random(MaxInt), 10);
                nCIDX    := GetWWIndex(sAccount);
                if not (m_MainIDLists[nCIDX].IndexOf(sAccount) > -1) then Break;
              end;
            nStep:= 9;
            Self.IDChangedLists[nCIDX].Add(sAccount);
            Self.IDOldLists[nCIDX].Add(ID.UserEntry.sAccount);
          end;
        end;//if not (TempIDLists[nCIDX].IndexOf(sAccount) > - 1) then begin
      end;

      nStep := 10;
      DBHum.sAccount := sAccount;
      HumData.Data.sAccount := sAccount;
      Inc(IDCount2);
      Inc(IDCount3);
      nStep := 12;

      FileSeek(f_MainHumH, 0, 0);
      m_Header1.sDesc:=DBFileDesc;
      m_Header1.dLastDate := Now();
      m_Header1.dUpdateDate := Now();
      m_Header1.nHumCount:=IDCount2;
      FileWrite(f_MainHumH, m_Header1, SizeOf(TDBHeader1));
      FileSeek(f_MainHumH, 0, 2);//2---从文件尾部定位
      FileWrite(f_MainHumH, DBHum, Sizeof(DBHum));//写入Hum.DB文件

      nStep := 15;
      FileSeek(f_MainMirH, 0, 0);
      m_Header2.sDesc:=DBFileDesc;
      m_Header2.nHumCount:=IDCount3;
      FileWrite(f_MainMirH, m_Header2, SizeOf(TDBHeader1));
      FileSeek(f_MainMirH, 0, 2);//2---从文件尾部定位
      FileWrite(f_MainMirH, HumData, Sizeof(THumDataInfo));//写入Mir.DB文件
    except
      On E: Exception do begin
        m_sCurMessage := '保存英雄异常:' + sName + ' Step:' + IntToStr(nStep);
        {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
        m_sCurMessage := E.Message;
        {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
      end;
    end;
    //f_MainIDH
    Inc(m_nTotalPostion);
    Inc(m_nCurPostion);
    {$IF THREADWORK}if Self.Terminated then Break;
    {$ELSE}
      if g_Terminated then Break;
      Application.ProcessMessages;
    {$IFEND}
  end;
//-------------------------合并人物--------------------------------------------
  FileSeek(f_HumH, Sizeof(TDBHeader1), 0);//0---从文件头开始定位
  while FileRead(f_HumH, DBHum, Sizeof(DBHum)) = Sizeof(DBHum) do begin //T 循环读出人物数据
    if boDelDenyChr and DBHum.boDeleted then Continue;//清除人物(已删除)
    if (DBHum.Header.boIsHero) then Continue;//是英雄跳过
    if HeroTempNameList.IndexOf(DBHum.sChrName) >= 0 then Continue;//名字在英雄名临时列表中存在则认为是英雄，跳过 20081129
    nStep := 0;
    try
      FillChar(HumData, SizeOf(THumDataInfo), #0);//20081128 增加
      FillChar(ID, SizeOf(TAccountDBRecord), #0);//20081224 增加
      sName := DBHum.sChrName;
      nCIDX := GetWWIndex(DBHum.sChrName);
      nStep := 1;

      if m_MainHumLists[nCIDX].IndexOf(sName) > -1 then begin//T
        nStep := 2;
        boReNameOK  := False;
        for I := Ord('a') to Ord('z') do begin
          sTempName := _Max14ReName(sName, Chr(I));
          if not (m_MainHumLists[nCIDX].IndexOf(sTempName) > -1) then begin
            boReNameOK := True;
            sName:= sTempName;
            Break;
          end;
        end;
        if not boReNameOK then
          while True do begin
            sName := IntToHex(Random(MaxInt), 14);
            if not (m_MainHumLists[nCIDX].IndexOf(sName) > -1) then Break;
          end;
        nStep := 3;
        ReThisHumInName(DBHum.sChrName, sName, 0);//修改寄售,师徒文件 
        ReHeroList(DBHum.sChrName, sName, 1);//修改英雄列表
        ReDearList(DBHum.sChrName, sName);//修改配偶列表
        ReThisHumInGuild(DBHum.sChrName, sName);//更新改名后的行会信息
        ReThisHumInMasterNo(DBHum.sChrName, sName);//更新师徒文件 20080601
        UpdateTxtDataToList(DBHum.sChrName, sName, g_DeputyTxtList);//更新从库文本内容的名字信息 20080703

        Self.NameChangedList.Add(sName);//写入改名列表
        Self.NameOldList.Add(DBHum.sChrName);//写入旧的名字列表
      end;
      nStep := 4;

      try
        if HumDataDB1.OpenEx then begin
          I := HumDataDB1.Index(DBHum.sChrName);
          if I >= 0 then begin
            HumDataDB1.Get(I, HumData);
          end else begin
            m_sCurMessage := '错误(保存人物失败):'+ DBHum.sChrName + '  数据不匹配!';
            {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
            Inc(m_nFailed);
            Inc(m_nTotalPostion);
            Inc(m_nCurPostion);
            Continue;
          end;
        end;
      finally
        HumDataDB1.Close;
      end;

      DBHum.Header.sName  := sName;
      DBHum.sChrName      := sName;
      HumData.Data.sChrName:= sName;
      HumData.Header.sName:=sName;
      if not HumData.Data.boIsHero then m_MainHumLists[nCIDX].Add(sName);//20080916 英雄改名不在保存到列表
      nStep := 5;
      nCIDX := GetWWIndex(DBHum.sAccount);
      J := m_SubIDLists[nCIDX].IndexOf(DBHum.sAccount);
      if J < 0 then begin //T
        m_sCurMessage := '错误(保存人物失败):' + DBHum.sChrName + ' 没有匹配的帐号!';
        {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
        Inc(m_nFailed);
        Inc(m_nTotalPostion);
        Inc(m_nCurPostion);
        Continue;
      end;
      nStep := 6;
      FileSeek(f_IDH, Sizeof(TDBHeader) + Sizeof(TAccountDBRecord) * Integer(m_SubIDLists[nCIDX].Objects[J]), 0);
      FileRead(f_IDH, ID, Sizeof(ID));
      sAccount  := ID.UserEntry.sAccount;
      //1
      if (CompareText(sAccount, DBHum.sAccount) <> 0) then  begin //T
        m_sCurMessage := '错误(保存人物失败):' + DBHum.sChrName + ' 帐号不匹配!';
        {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
        Inc(m_nFailed);
        Inc(m_nTotalPostion);
        Inc(m_nCurPostion);
        Continue;
      end;
      nStep := 7;
      //2
      nC_01 := IDOldLists[nCIDX].IndexOf(sAccount);
      if nC_01 > -1 then begin
        sAccount  := IDChangedLists[nCIDX].Strings[nC_01];
      end else begin
        if not (TempIDLists[nCIDX].IndexOf(sAccount) > - 1) then begin
          TempIDLists[nCIDX].Add(sAccount);
          if m_MainIDLists[nCIDX].IndexOf(sAccount) > -1 then begin
            boReNameOK  := False;
            nStep := 8;
            for I := Ord('a') to Ord('z') do begin
              sTempName := _Max10ReName(sAccount, Chr(I));
              if not (m_MainIDLists[nCIDX].IndexOf(sTempName) > -1) then begin
                boReNameOK := True;
                sAccount:= sTempName;
                Break;
              end;
            end;
            if not boReNameOK then
              while True do begin
                sAccount := IntToHex(Random(MaxInt), 10);
                nCIDX    := GetWWIndex(sAccount);
                if not (m_MainIDLists[nCIDX].IndexOf(sAccount) > -1) then Break;
              end;
            nStep:= 9;
            Self.IDChangedLists[nCIDX].Add(sAccount);
            Self.IDOldLists[nCIDX].Add(ID.UserEntry.sAccount);
          end;
        end;//if not (TempIDLists[nCIDX].IndexOf(sAccount) > - 1) then begin
      end;

      nStep := 10;
      ID.Header.sAccount    := sAccount;
      ID.UserEntry.sAccount := sAccount;
      DBHum.sAccount        := sAccount;
      HumData.Data.sAccount := sAccount;

      Inc(IDCount1);
      Inc(IDCount2);
      Inc(IDCount3);
      nStep := 12;                       //20081224 检查账号是否存在
      if (not HumData.Header.boIsHero) and (not (m_MainIDLists[nCIDX].IndexOf(ID.Header.sAccount) > -1)) then begin //写入ID.DB,即ID信息(英雄角色,则不写入ID.DB)
        m_MainIDLists[nCIDX].Add(sAccount);//20081224 不存在，则写入文件中
        FileSeek(f_MainIDH, 0, 0);
        nStep := 19;
        m_Header.sDesc:=DBFileDesc;
        m_Header.nDeletedIdx:=-1;
        m_Header.dLastDate := Now();
        m_Header.dUpdateDate := Now();
        nStep := 20;
        m_Header.nLastIndex := IDCount1;//20080615 修改

        m_Header.nIDCount:=IDCount1;
        FileWrite(f_MainIDH, m_Header, SizeOf(TDBHeader));
        FileSeek(f_MainIDH, 0, 2);//2---从文件尾部定位
        nStep := 13;
        FileWrite(f_MainIDH, ID, Sizeof(ID));//写入ID.DB文件
      end;

      nStep := 14;
      FileSeek(f_MainHumH, 0, 0);
      m_Header1.sDesc:=DBFileDesc;
      m_Header1.dLastDate := Now();
      m_Header1.dUpdateDate := Now();
      m_Header1.nHumCount:=IDCount2;
      FileWrite(f_MainHumH, m_Header1, SizeOf(TDBHeader1));
      FileSeek(f_MainHumH, 0, 2);//2---从文件尾部定位
      FileWrite(f_MainHumH, DBHum, Sizeof(DBHum));//写入Hum.DB文件

      {nStep := 16;
      if HumData.Data.sMasterName <> '' then begin
        if MasterDataList.Count > 0 then begin
          for I:= 0 to MasterDataList.Count - 1 do begin
            TMasterData:= PTMasterData(MasterDataList.Items[I]);
            if CompareText(Trim(TMasterData.sName), Trim(HumData.Data.sMasterName))= 0 then begin
              HumData.Data.sMasterName:= TMasterData.sNewHumName;
              //MasterDataList.Delete(I);
              Break;
            end;
          end;
        end;
      end; }
      nStep := 17;
      if HumData.Data.sHeroChrName <> '' then begin
        if HeroDataList.Count > 0 then begin
          for I:= 0 to HeroDataList.Count - 1 do begin
            THeroData:= PTHeroData(HeroDataList.Items[I]);
            if (CompareText(Trim(THeroData.sHeroName), Trim(HumData.Data.sHeroChrName))= 0) and (not HumData.Header.boIsHero) then begin
              HumData.Data.sHeroChrName:= THeroData.sNewHumName;
              THeroData.sMasterName:= HumData.Data.sChrName;
              //HeroDataList.Delete(I);
              //Break;
            end;
          end;
        end;  
      end;

      nStep := 18;
      FileSeek(f_MainMirH, 0, 0);
      m_Header2.sDesc:=DBFileDesc;
      m_Header2.nHumCount:=IDCount3;
      FileWrite(f_MainMirH, m_Header2, SizeOf(TDBHeader1));
      FileSeek(f_MainMirH, 0, 2);//2---从文件尾部定位
      FileWrite(f_MainMirH, HumData, Sizeof(THumDataInfo));//写入Mir.DB文件
    except
      On E: Exception do begin
        m_sCurMessage := '保存人物异常:' + sName + ' Step:' + IntToStr(nStep);
        {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
        m_sCurMessage := E.Message;
        {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
      end;
    end;
    //f_MainIDH
    Inc(m_nTotalPostion);
    Inc(m_nCurPostion);
    {$IF THREADWORK}if Self.Terminated then Break;
    {$ELSE}
      if g_Terminated then Break;
      Application.ProcessMessages;
    {$IFEND}
  end;

  GuildList := TStringList.Create;
  if FileExists(FrmMain.GuildBase2.text+'\GuildList.txt') then begin//20081230
    GuildList.LoadFromFile(FrmMain.GuildBase2.text+'\GuildList.txt');//20071122
    (GuildList as TStringList).Sort;
    while GuildList.Count > 0 do begin
      try
        sName := GuildList.Strings[0];
        if Self.m_sMainGuildList.IndexOf(sName) > -1 then begin
          boReNameOK  := False;
          for I := Ord('a') to Ord('z') do begin
            sTempName :=  sName + Chr(I);
            if not (Self.m_sMainGuildList.IndexOf(sTempName) > -1) then begin
              boReNameOK  := True;
              sName:= sTempName;
              Break;
            end;
          end;
          if not boReNameOK then
            while True do begin
              sName := IntToHex(Random(MaxInt), 32);
              if not (m_sMainGuildList.IndexOf(sName) > -1) then Break;
            end;
        end;
        if sName <> GuildList.Strings[0] then
          Self.m_sGuildChangedList.Add('"' + GuildList.Strings[0] + '"' + #9#9#9#9 + '"' + sName + '"');
        Windows.CopyFile(PChar(sRoot + '\Guilds\' + GuildList.Strings[0] + '.txt'),
                         PChar(m_sMainRoot + '\Mir200\GuildBase\Guilds\' + sName + '.txt'),
                         True);
        Windows.CopyFile(PChar(sRoot + '\Guilds\' + GuildList.Strings[0] + '.ini'),
                         PChar(m_sMainRoot + '\Mir200\GuildBase\Guilds\' + sName + '.ini'),
                         True);
        m_sMainGuildList.Add(sName);
        GuildList.Delete(0);
      Except
        On E: Exception do begin
          m_sCurMessage := E.Message;
          {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
        end;
      end;
     Application.ProcessMessages;
    end;
  end;
  try
    if boSellOffItem then begin
      LoadSellOffItemList(FrmMain.Envir1.text+'\UserData\UserData.dat' ,OldSellOffItemList);//读取主库元宝寄售数据 20080601
      SaveSellOffItemList(FrmMain.Edit1.Text+'\Mir200\Envir\UserData\UserData.dat',OldSellOffItemList);//保存文件
    end;
    if boBigStorage then begin
      LoadBigStorageList(FrmMain.Envir1.text+'\Market_Storage\UserStorage.db' ,m_StorageList);//读取主库无限仓库数据 20080601
      SaveBigStorageList(FrmMain.Edit1.text+'\Mir200\Envir\Market_Storage\UserStorage.db',m_StorageList);//保存无限仓库数据
    end;
    if DirectoryExists(FrmMain.Envir2.text+'\MasterNo\') then
      FrmMain.CopyDirAll(FrmMain.Envir2.text+'\MasterNo\',FrmMain.Edit1.Text+'\Mir200\Envir\MasterNo');//复制整个目录
    SaveListToTxt(FrmMain.Edit1.text+'\NEW文本数据', g_MainTxtList, g_DeputyTxtList);//保存文本列表 20080703
  Except
    On E: Exception do begin
      m_sCurMessage := '保存寄售数据异常！';
      {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
      m_sCurMessage := E.Message;
      {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
    end;
  end;

  FileClose(f_IDH);
  FileClose(f_HumH);
  FileClose(f_MirH);
  if f_MainIDH > 0 then FileClose(f_MainIDH);
  if f_MainHumH > 0 then FileClose(f_MainHumH);

  m_sCurMessage := '正在保存文件...';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};

  if MasterDataList.Count > 0 then begin
    for I:= 0 to MasterDataList.Count - 1 do begin
      TMasterData:= PTMasterData(MasterDataList.Items[I]);
      sFileName1 := Self.m_sMainRoot + '\Mir200\Envir\MasterNo\'+TMasterData.sMasterName+'.txt';
      if FileExists(sFileName1) then begin
        LoadList := TStringList.Create;
        LoadList.LoadFromFile(sFileName1);
        for J := 0 to LoadList.Count - 1 do begin
          s001 := Trim(LoadList.Strings[J]);
          if (s001 <> '') and (s001[1] <> ';') then begin
             s001 := GetValidStr3(s001, s002, [' ', #9]);//徒弟名
             s001 := GetValidStr3(s001, s003, [' ', #9]);//排行
             if CompareText(s002, TMasterData.sName)= 0 then begin
               LoadList.Strings[J]:= TMasterData.sNewHumName+' '+s003;
               LoadList.SaveToFile(sFileName1);
               Break;
             end;
          end;
        end;
        LoadList.Free;
      end;
    end;
  end;

  Try
    HumDataDB := TFileDB.Create(Self.m_sMainRoot + '\DBServer\FDB\Mir.db');
    HumChrDB := TFileHumDB.Create(Self.m_sMainRoot + '\DBServer\FDB\Hum.db');//20081220
    try
      if HumDataDB.Open then begin
        if HeroDataList.Count > 0 then begin
          for I:= 0 to HeroDataList.Count - 1 do begin
            THeroData:= pTHeroData(HeroDataList.Items[I]);
            if THeroData.sMasterName <> '' then begin
              J := HumDataDB.Index(THeroData.sNewHumName);
              if (J >= 0) then begin
                if HumDataDB.Get(J, HumData) >= 0 then begin
                  HumData.Data.sMasterName:= THeroData.sMasterName;
                  HumDataDB.Update(J, HumData);
                end;
              end;
            end;
          end;
        end;
        if DearDataList.Count > 0 then begin
          for I:= 0 to DearDataList.Count - 1 do begin
            TDearData:= PTDearData(DearDataList.Items[I]);
            if TDearData.sNewHumName <> '' then begin
              J := HumDataDB.Index(TDearData.sNewHumName);
              if (J >= 0) then begin
                if HumDataDB.Get(J, HumData) >= 0 then begin
                  HumData.Data.sDearName:= TDearData.sDearName;
                  HumDataDB.Update(J, HumData);
                end;
              end;
            end;
            if TDearData.sDearName <> '' then begin
              J := HumDataDB.Index(TDearData.sDearName);
              if (J >= 0) then begin
                if HumDataDB.Get(J, HumData) >= 0 then begin
                  HumData.Data.sDearName:= TDearData.sNewHumName;
                  HumDataDB.Update(J, HumData);
                end;
              end;
            end;
          end;
        end;
        if MasterDataList.Count > 0 then begin
          for I:= 0 to MasterDataList.Count - 1 do begin
            TMasterData:= PTMasterData(MasterDataList.Items[I]);
            J := HumDataDB.Index(TMasterData.sNewHumName);
            if (J >= 0) then begin
              if HumDataDB.Get(J, HumData) >= 0 then begin
                HumData.Data.sMasterName:= TMasterData.sMasterName;
                HumDataDB.Update(J, HumData);
              end;
            end;
          end;
        end;

        //检查mir.db登录账号是否与hum.db一致,不一致则修改一致 20081220
        try
          if HumChrDB.Open then begin
            for I := 0 to HumChrDB.m_QuickList.Count - 1 do begin
              if HumChrDB.GetBy(I, DBHum) then begin
                J := HumDataDB.Index(DBHum.sChrName);
                if J >= 0 then begin
                  if HumDataDB.Get(J, HumData) >= 0 then begin
                    if (HumData.Data.sChrName = '') then Continue;
                    if CompareText(DBHum.sAccount , HumData.Data.sAccount) <> 0 then begin
                      HumData.Data.sAccount:= DBHum.sAccount;
                      HumDataDB.Update(J, HumData);
                    end;
                  end;
                end;
              end;
            end;
          end;
        finally
          HumChrDB.Close;
        end;
      end;//if HumDataDB.Open then begin
    finally
      HumDataDB.Close;
    end;
  finally
    HumDataDB.Free;
    HumChrDB.Free;//20081220
  end;

  for I := Low(TempIDLists) to High(TempIDLists) do TempIDLists[I].Free;

  for I:=0 to DearDataList.Count - 1 do Dispose(pTDearData(DearDataList.Items[I]));
  FreeAndNil(DearDataList);
  for I:=0 to MasterDataList.Count - 1 do Dispose(pTMasterData(MasterDataList.Items[I]));
  FreeAndNil(MasterDataList);
  for I:=0 to HeroDataList.Count - 1 do Dispose(pTHeroData(HeroDataList.Items[I]));
  FreeAndNil(HeroDataList);
  if HumDataDB1 <> nil then HumDataDB1.Free;

  if FileExists(PChar(ExtractFilePath(FrmMain.Mir_db2.text)+'Mir1.DB')) then DeleteFile(PChar(ExtractFilePath(FrmMain.Mir_db2.text)+'Mir1.DB'));
  if FileExists(PChar(ExtractFilePath(FrmMain.Mir_db2.text)+'Mir1.DB.idx')) then DeleteFile(PChar(ExtractFilePath(FrmMain.Mir_db2.text)+'Mir1.DB.idx'));
  if HeroTempNameList <> nil then HeroTempNameList.Free;//20081129
  if GuildList <> nil then GuildList.Free;//20081129
end;

procedure TMainWorkThread.OutMessage;
begin
  if Assigned(MainOutInforProc) then MainOutInforProc(m_sCurMessage);
end;
//重新编写物品编号
procedure TMainWorkThread.ReSetItemsIndex;
var
 HumData:THumDatainfo;
 I: Integer;
begin
  if f_MainMirH > 0 then begin//20081225
    m_nCurMax := (FileSeek(f_MainMirH, 0, 2) - Sizeof(TDBHeader)) div Sizeof(THumDataInfo);
    FileSeek(f_MainMirH, Sizeof(TDBHeader), 0);
    m_nCurPostion := 0;
    while FileRead(f_MainMirH, HumData, Sizeof(THumDataInfo)) = Sizeof(THumDataInfo) do
      begin
        for I := Low(HumData.data.HumItems) to High(HumData.data.HumItems) do
          if HumData.data.HumItems[I].wIndex > 0 then
            begin
              HumData.data.HumItems[I].MakeIndex := m_nNewItemIndex;
              Inc(m_nNewItemIndex);
            end;

        for I := Low(HumData.data.BagItems) to High(HumData.data.BagItems) do
          if HumData.data.BagItems[I].wIndex > 0 then
            begin
              HumData.data.BagItems[I].MakeIndex := m_nNewItemIndex;
              Inc(m_nNewItemIndex);
            end;

        for I := Low(HumData.data.StorageItems) to High(HumData.data.StorageItems) do
          if HumData.data.StorageItems[I].wIndex > 0 then
            begin
              HumData.data.StorageItems[I].MakeIndex := m_nNewItemIndex;
              Inc(m_nNewItemIndex);
            end;

        for I := Low(HumData.data.HumAddItems) to High(HumData.data.HumAddItems) do
          if HumData.data.HumAddItems[I].wIndex > 0 then
            begin
              HumData.data.HumAddItems[I].MakeIndex := m_nNewItemIndex;
              Inc(m_nNewItemIndex);
            end;
        FileSeek(f_MainMirH, Sizeof(TDBHeader) + Sizeof(THumDataInfo) * m_nCurPostion, 0);
        FileWrite(f_MainMirH, HumData, Sizeof(THumDataInfo));
        Inc(m_nTotalPostion);
        Inc(m_nCurPostion);
        {$IF THREADWORK}if Self.Terminated then Break;
        {$ELSE}
          if g_Terminated then Break;
          Application.ProcessMessages;
        {$IFEND}
      end;
    m_sCurMessage := '新的物品编号从 0 开始 到 ' + IntToStr(m_nNewItemIndex);
    {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  end;
end;

{$IF not THREADWORK}
procedure TMainWorkThread.Run;
begin
  g_Terminated  := False;
  Execute;
end;
{$IFEND}

procedure TMainWorkThread.SaveIDChangeList;
var
  I, J: Integer;
  SL  : TStrings;
begin
  SL  := TStringList.Create;
  for J := Low(IDChangedLists) to High(IDChangedLists) do
    for I := 0 to IDChangedLists[J].Count - 1 do
      begin
        SL.Add('"' + IDOldLists[J].Strings[I] + '"' + #9#9#9 + '"' + IDChangedLists[J].Strings[I] + '"');
      end;
  (SL as TStringList).Sort;
  SL.SaveToFile(ExtRactFilePath(Application.ExeName) + 'ID变更.txt');
  SL.Free;
end;

procedure TMainWorkThread.SaveNameChangeList;
var
  I: Integer;
  SL  : TStrings;
begin
  SL  := TStringList.Create;
  for I := 0 to NameChangedList.Count - 1 do begin
    SL.Add('"' + NameOldList.Strings[I] + '"' + #9#9#9 + '"' + NameChangedList.Strings[I] + '"');
  end;
  (SL as TStringList).Sort;
  SL.SaveToFile(ExtRactFilePath(Application.ExeName) + '名字变更.txt');
  SL.Free;
end;

//20071122
procedure TMainWorkThread.SetWorkRoots(SL:String);
begin
  m_WorkRoots.Add(sl);
end;

end.

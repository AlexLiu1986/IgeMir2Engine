unit Unit3;

interface

uses Windows, SysUtils, Classes, UniTypes;

const
  THREADWORK    = TRUE;

type
  TMainWorkThread1 = class{$IF THREADWORK}(TThread){$IFEND}
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
    m_sCurMessage     : string;
    m_WorkRoots       : TStrings;
    m_nNewItemIndex   : Integer;
    IDChangedLists    : TListArray;
    IDOldLists        : TListArray;//TStrings;
    NameChangedList   : TStrings;
    NameOldList       : TStrings;
    //f_MainIDH         : THandle;
    //f_MainHumH        : THandle;
    f_MainMirH        : THandle;
    procedure OutMessage;
    procedure LoadHumDB(const sRoot: string; ListArray: TListArray);
    function  GetMaxWorkCount : Integer;
    function  GetFileSize(const sFile: string; const OffSet: Integer; const DefSize: Integer): Integer;
    procedure SaveIDChangeList;
    procedure MakeInOne(); //合并数据
    procedure ReSetItemsIndex;
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
    MainOutInforProc1  : TMainOutProcList;
    MainWorkThread1    : TMainWorkThread1;
{$IF not THREADWORK}
    g_Terminated1      : Boolean = False;
{$IFEND}

implementation

uses Forms,unit1;

{ TMainWorkThread }

constructor TMainWorkThread1.Create(CreateSupsbended: Boolean);
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
  //f_MainHumH      := 0;
  f_MainMirH      := 0;

  for I := Low(IDChangedLists) to High(IDChangedLists) do
    IDChangedLists[I]   := TStringList.Create;
  for I := Low(IDOldLists) to High(IDOldLists) do
    IDOldLists[I]       := TStringList.Create;

  NameChangedList := TStringList.Create;
  NameOldList     := TStringList.Create;
  m_sMainGuildList:= TStringList.Create;
  m_sGuildChangedList := TStringList.Create;
end;

destructor TMainWorkThread1.Destroy;
var
  I: Integer;
begin
  for I := Low(m_MainHumLists) to High(m_MainHumLists) do
    FreeAndNil(m_MainHumLists[I]);
  for I := Low(m_MainIDLists) to High(m_MainIDLists) do
    FreeAndNil(m_MainIDLists[I]);
  for I := Low(m_SubIDLists) to High(m_SubIDLists) do
    FreeAndNil(m_SubIDLists[I]);


  for I := Low(IDChangedLists) to High(IDChangedLists) do
    FreeAndNil(IDChangedLists[I]);
  for I := Low(IDOldLists) to High(IDOldLists) do
    FreeAndNil(IDOldLists[I]);

  FreeAndNil(NameChangedList);
  FreeAndNil(NameOldList);
  FreeAndNil(m_sMainGuildList);
  FreeAndNil(m_sGuildChangedList);
  //if f_MainHumH > 0 then FileClose(f_MainHumH);
  if f_MainMirH > 0 then FileClose(f_MainMirH);
  inherited Destroy;
end;

procedure TMainWorkThread1.Execute;
var
  I: Integer;
begin
  inherited;
  m_sWorkingFor:= '正在读取数据...';
  m_nTotalMax     := GetMaxWorkCount * 2;
  m_nTotalPostion := 0;

  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};

  //LoadIDDB(m_sMainRoot + '\LoginSrv\IDDB\ID.DB', m_MainIDLists);
  LoadHumDB(Form1.Hum_db2.Text , m_MainHumLists);

  m_sWorkingFor := '正在数据转换...';
  m_sCurMessage := '正在读取数据';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  //LoadIDDB(m_WorkRoots[I] + '\LoginSrv\IDDB', m_SubIDLists);
  //LoadIDDB(FrmMain.ID_DB2.text, m_SubIDLists);
  m_sCurMessage := '正在数据转换......';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  //合并
  MakeInOne();

  m_sWorkingFor := '数据转换完成!';

  m_sCurMessage := '数据转换完成';
{$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};

end;

function TMainWorkThread1.GetFileSize(const sFile: string; const OffSet,
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

function TMainWorkThread1.GetMaxWorkCount: Integer;
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
      Inc(nC, GetFileSize(Form1.Hum_db1.text+ '\DBServer\FDB\HUM.db', Sizeof(TDBHeader), Sizeof(TDBHum)));
      //Inc(nC, GetFileSize(m_WorkRoots[I] + '\FDB\MIR.DB', Sizeof(TDBFileHeader), Sizeof(THumData)));
      Sleep(1);
    end;
  Result  := nC;
end;
//读取人物数据 20071122
procedure TMainWorkThread1.LoadHumDB(const sRoot: string; ListArray: TListArray);
var
  f_H: THandle;
  DBHum: TDBHum;
  nCIDX, nC: Integer;
begin
  if not FileExists(sRoot) then
    Raise Exception.Create('找不到文件:'+sRoot);
  f_H := FileOpen(sRoot, 0);
  if f_H <= 0 then Raise Exception.Create('打开文件失败! ' + #13 + sRoot);
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

procedure Log( s : PChar);stdcall;
var
  F : TextFile;
begin
  assignfile(f,'c:\记事本.txt');
  if fileexists('c:\记事本.txt') then append(f)
  else rewrite(f);
  writeln(f,s);
  closefile(f);
end;

procedure TMainWorkThread1.MakeInOne();
var
  IDCount2,IDCount3:integer;
  m_Header: TDBHeader; //0x2C ID数据库头
  m_Header1,m_Header2: TDBHeader1; //0x2C 人物数据库头
  
  f_IDH, f_HumH, f_MirH: THandle;
  ID: TAccountDBRecord;
  DBHum: TDBHum;
  HumData:THumDataInfo1;
  NewHumData:TNewHumDataInfo;
  nCIDX, I, J, nStep, nC_01 : Integer;
  sName, sAccount : string;
  boReNameOK: Boolean;
  GuildList : TStrings;
  TempIDLists: TListArray;
begin
  //IDCount2:=0;//20080302
  IDCount3:=0;//20080302
  if f_MainMirH = 0 then
    f_MainMirH  := FileCreate(Self.m_sMainRoot + '\DBServer\FDB\NewMir.db', fmOpenReadWrite or fmShareDenyNone);

//打开从库数据文件  20071122
  f_HumH  := FileOpen(Form1.Hum_db2.text, 0);
  f_MirH  := FileOpen(Form1.Mir_db2.text, 0);
////////////////////////////////////////////////////////////////
//20071120增加
{FileSeek(f_MainHumH, 0, 0);
if FileRead(f_MainHumH, m_Header1, SizeOf(TDBHeader1)) = SizeOf(TDBHeader1) then
begin
  IDCount2 := m_Header1.nHumCount;
end;  }

FileSeek(f_MainMirH, 0, 0);
if FileRead(f_MainMirH, m_Header2, SizeOf(TDBHeader1)) = SizeOf(TDBHeader1) then
begin
  IDCount3 := m_Header2.nHumCount;
end;

//////////////////////////////////////////////////////////////////

  m_nCurMax  := GetFileSize({sRoot + '\DBServer\FDB\Hum.db'}Form1.Hum_db2.text, Sizeof(TDBHeader1), Sizeof(TDBHum)); //FileSeek(f_HumH, Sizeof(TDBFileHeader), 2) div Sizeof(DBHum);
  FileSeek(f_HumH, Sizeof(TDBHeader1), 0);//0---从文件头开始定位

  m_nCurPostion := 0;
  
  while FileRead(f_HumH, DBHum, Sizeof(DBHum)) = Sizeof(DBHum) do  //T 循环读出人物数据
    begin
      nStep := 4;

      FileSeek(f_MirH, Sizeof(TDBHeader1)+ Sizeof(THumDataInfo1) * m_nCurPostion, 0);
      FileRead(f_MirH, HumData, Sizeof(THumDataInfo1));

///////////////////////////////////////////////
{20071119增加,先更新数据头,再写入数据}
      Inc(IDCount3);

      FileSeek(f_MainMirH, 0, 0);
      m_Header2.sDesc:=DBFileDesc;
      m_Header2.nHumCount:=IDCount3;
      FileWrite(f_MainMirH, m_Header2, SizeOf(TDBHeader1));
      FileSeek(f_MainMirH, 0, 2);//2---从文件尾部定位
      
      NewHumData.Header:=HumData.Header;
      NewHumData.Data.sChrName:=HumData.Data.sChrName;
      NewHumData.Data.sCurMap:=HumData.Data.sCurMap;
      NewHumData.Data.wCurX:=HumData.Data.wCurX;
      NewHumData.Data.wCurY:=HumData.Data.wCurY;
      NewHumData.Data.btDir:=HumData.Data.btDir;
      NewHumData.Data.btHair:=HumData.Data.btHair;
      NewHumData.Data.btSex:=HumData.Data.btSex;
      NewHumData.Data.btJob:=HumData.Data.btJob;
      NewHumData.Data.nGold:=HumData.Data.nGold;
      //NewHumData.Data.Abil:=HumData.Data.Abil;

      NewHumData.Data.Abil.Level:=HumData.Data.Abil.Level;
      NewHumData.Data.Abil.AC:=HumData.Data.Abil.AC;
      NewHumData.Data.Abil.MAC:=HumData.Data.Abil.MAC;
      NewHumData.Data.Abil.DC:=HumData.Data.Abil.DC;
      NewHumData.Data.Abil.MC:=HumData.Data.Abil.MC;
      NewHumData.Data.Abil.SC:=HumData.Data.Abil.SC;
      NewHumData.Data.Abil.HP:=HumData.Data.Abil.HP;
      NewHumData.Data.Abil.MP:=HumData.Data.Abil.MP;
      NewHumData.Data.Abil.MaxHP:=HumData.Data.Abil.MaxHP;
      NewHumData.Data.Abil.MaxMP:=HumData.Data.Abil.MaxMP;
      NewHumData.Data.Abil.btReserved1:=HumData.Data.Abil.btReserved1;
      NewHumData.Data.Abil.btReserved2:=HumData.Data.Abil.btReserved2;
      NewHumData.Data.Abil.btReserved3:=HumData.Data.Abil.btReserved3;
      NewHumData.Data.Abil.btReserved4:=HumData.Data.Abil.btReserved4;
      NewHumData.Data.Abil.Exp:=HumData.Data.Abil.Exp;
      NewHumData.Data.Abil.MaxExp:=HumData.Data.Abil.MaxExp;
      NewHumData.Data.Abil.Weight:=HumData.Data.Abil.Weight;
      NewHumData.Data.Abil.MaxWeight:=HumData.Data.Abil.MaxWeight; //背包
      NewHumData.Data.Abil.WearWeight:=HumData.Data.Abil.WearWeight;
      NewHumData.Data.Abil.MaxWearWeight:=HumData.Data.Abil.MaxWearWeight; //负重
      NewHumData.Data.Abil.HandWeight:=HumData.Data.Abil.HandWeight;
      NewHumData.Data.Abil.MaxHandWeight:=HumData.Data.Abil.MaxHandWeight; //腕力

      NewHumData.Data.wStatusTimeArr:=HumData.Data.wStatusTimeArr;
      NewHumData.Data.sHomeMap:=HumData.Data.sHomeMap;
      NewHumData.Data.btUnKnow1:=HumData.Data.btUnKnow1;
      NewHumData.Data.wHomeX:=HumData.Data.wHomeX;
      NewHumData.Data.wHomeY:=HumData.Data.wHomeY;
      NewHumData.Data.sDearName:=HumData.Data.sDearName;
      NewHumData.Data.sMasterName:=HumData.Data.sMasterName;
      NewHumData.Data.boMaster:=HumData.Data.boMaster;
      NewHumData.Data.btCreditPoint:=HumData.Data.btCreditPoint;
      NewHumData.Data.btDivorce:=HumData.Data.btDivorce;
      NewHumData.Data.btMarryCount:=HumData.Data.btMarryCount;
      NewHumData.Data.sStoragePwd:=HumData.Data.sStoragePwd;
      NewHumData.Data.btReLevel:=HumData.Data.btReLevel;
      NewHumData.Data.btUnKnow2[0]:=HumData.Data.btUnKnow2[0];
      NewHumData.Data.btUnKnow2[1]:=HumData.Data.btUnKnow2[1];
      NewHumData.Data.btUnKnow2[2]:=HumData.Data.btUnKnow2[2];
      NewHumData.Data.BonusAbil:=HumData.Data.BonusAbil;
      NewHumData.Data.nBonusPoint:=HumData.Data.nBonusPoint;
      NewHumData.Data.nGameGold:=HumData.Data.nGameGold;
      NewHumData.Data.nGameDiaMond:=HumData.Data.nGameDiaMond;
      NewHumData.Data.nGameGird:=HumData.Data.nGameGird;
      NewHumData.Data.nGamePoint:=HumData.Data.nGamePoint;
      NewHumData.Data.btGameGlory:=HumData.Data.btGameGlory;
      NewHumData.Data.nPayMentPoint:=HumData.Data.nPayMentPoint;
      NewHumData.Data.N:=HumData.Data.N;
      NewHumData.Data.nPKPOINT:=HumData.Data.nPKPOINT;
      NewHumData.Data.btAllowGroup:=HumData.Data.btAllowGroup;
      NewHumData.Data.btF9:=HumData.Data.btF9;
      NewHumData.Data.btAttatckMode:=HumData.Data.btAttatckMode;
      NewHumData.Data.btIncHealth:=HumData.Data.btIncHealth ;
      NewHumData.Data.btIncSpell:=HumData.Data.btIncSpell ;
      NewHumData.Data.btIncHealing:=HumData.Data.btIncHealing ;
      NewHumData.Data.btFightZoneDieCount:=HumData.Data.btFightZoneDieCount;
      NewHumData.Data.sAccount:=HumData.Data.sAccount;
      NewHumData.Data.btEE:=HumData.Data.btEE ;
      NewHumData.Data.btEF:=HumData.Data.btEF;
      NewHumData.Data.boLockLogon:=HumData.Data.boLockLogon;
      NewHumData.Data.wContribution:=HumData.Data.wContribution;
      NewHumData.Data.nHungerStatus:=HumData.Data.nHungerStatus;
      NewHumData.Data.boAllowGuildReCall:=HumData.Data.boAllowGuildReCall;
      NewHumData.Data.wGroupRcallTime:=HumData.Data.wGroupRcallTime ;
      NewHumData.Data.dBodyLuck:=HumData.Data.dBodyLuck;
      NewHumData.Data.boAllowGroupReCall:=HumData.Data.boAllowGroupReCall;
      NewHumData.Data.nEXPRATE:=HumData.Data.nEXPRATE;
      NewHumData.Data.nExpTime:=HumData.Data.nExpTime;
      NewHumData.Data.btLastOutStatus:=HumData.Data.btLastOutStatus;
      NewHumData.Data.wMasterCount:=HumData.Data.wMasterCount;
      NewHumData.Data.boHasHero:=HumData.Data.boHasHero;
      NewHumData.Data.boIsHero:=HumData.Data.boIsHero;
      NewHumData.Data.btStatus:=HumData.Data.btStatus;
      NewHumData.Data.sHeroChrName:=HumData.Data.sHeroChrName;
      NewHumData.Data.UnKnow:=HumData.Data.UnKnow;
      NewHumData.Data.QuestFlag:=HumData.Data.QuestFlag;
      NewHumData.Data.HumItems:=HumData.Data.HumItems;
      NewHumData.Data.BagItems:=HumData.Data.BagItems;
      NewHumData.Data.HumMagics:=HumData.Data.HumMagics;
      NewHumData.Data.StorageItems:=HumData.Data.StorageItems;
      NewHumData.Data.HumAddItems:=HumData.Data.HumAddItems;
      NewHumData.Data.n_WinExp:=HumData.Data.n_WinExp;
      NewHumData.Data.n_UsesItemTick:=HumData.Data.n_UsesItemTick;

      FileWrite(f_MainMirH, NewHumData, Sizeof(TNewHumDataInfo));//写入Mir.DB文件
////////////////////////////////////////////////
      //f_MainIDH
      Inc(m_nTotalPostion);
      Inc(m_nCurPostion);
      {$IF THREADWORK}if Self.Terminated then Break;
      {$ELSE}
        if g_Terminated then Break;
        Application.ProcessMessages;
      {$IFEND}
    end;

  for I := Low(TempIDLists) to High(TempIDLists) do
    TempIDLists[I].Free;
  FileClose(f_HumH);
  FileClose(f_MirH);
end;

procedure TMainWorkThread1.OutMessage;
begin
  if Assigned(MainOutInforProc1) then
    MainOutInforProc1(m_sCurMessage);
end;

procedure TMainWorkThread1.ReSetItemsIndex;
var
 // HumData: THumData;
 HumData:THumDatainfo;
  I      : Integer;
begin

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

{$IF not THREADWORK}
procedure TMainWorkThread1.Run;
begin
  g_Terminated  := False;
  Execute;
end;
{$IFEND}

procedure TMainWorkThread1.SaveIDChangeList;
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

//20071122
procedure TMainWorkThread1.SetWorkRoots(SL:String);
begin
  m_WorkRoots.Add(sl);
end;

end.
 
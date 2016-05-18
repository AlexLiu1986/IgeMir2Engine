unit work1219;
//1219->1231

interface

uses Windows, SysUtils, Classes, UniTypes;

const
  THREADWORK    = TRUE;

type
  TMainWorkThread1219 = class{$IF THREADWORK}(TThread){$IFEND}
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
  private
    m_sCurMessage     : string;
    m_WorkRoots       : TStrings;
    m_nNewItemIndex   : Integer;
    IDChangedLists    : TListArray;
    IDOldLists        : TListArray;//TStrings;
    NameChangedList   : TStrings;
    NameOldList       : TStrings;
    f_MainMirH        : THandle;
    procedure OutMessage;
    procedure LoadHumDB(const sRoot: string; ListArray: TListArray);
    function  GetMaxWorkCount : Integer;
    function  GetFileSize(const sFile: string; const OffSet: Integer; const DefSize: Integer): Integer;
    procedure MakeInOne(); //合并数据
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
    MainOutInforProc1219  : TMainOutProcList;
    Work_1219    : TMainWorkThread1219;
{$IF not THREADWORK}
    g_Terminated      : Boolean = False;
{$IFEND}

implementation

uses Forms,Main;

{ TMainWorkThread }

constructor TMainWorkThread1219.Create(CreateSupsbended: Boolean);
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
  f_MainMirH      := 0;

  for I := Low(IDChangedLists) to High(IDChangedLists) do
    IDChangedLists[I]   := TStringList.Create;
  for I := Low(IDOldLists) to High(IDOldLists) do
    IDOldLists[I]       := TStringList.Create;

  NameChangedList := TStringList.Create;
  NameOldList     := TStringList.Create;
  m_sMainGuildList:= TStringList.Create;
end;

destructor TMainWorkThread1219.Destroy;
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
  if f_MainMirH > 0 then FileClose(f_MainMirH);
  inherited Destroy;
end;

procedure TMainWorkThread1219.Execute;
//var
//  I: Integer;
begin
  inherited;
  m_sWorkingFor:= '正在读取数据...';
  m_nTotalMax     := GetMaxWorkCount * 2;
  m_nTotalPostion := 0;

  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};

  LoadHumDB(FrmMain.Hum_db1219.Text , m_MainHumLists);//需要修改

  m_sWorkingFor := '正在数据转换...';
  m_sCurMessage := '正在读取数据';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};

  m_sCurMessage := '正在数据转换......';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  //合并
  MakeInOne();

  m_sWorkingFor := '数据转换完成!';

  m_sCurMessage := '数据转换完成';
  with FrmMain do begin //需要修改
    Hum_db1219.Enabled := True;
    Mir_db1219.Enabled := True;
    SpeedButton10.Enabled := True;
    SpeedButton11.Enabled := True;
    SpeedButton12.Enabled := True;
    Edit1219.Enabled := True;
    Button7.Enabled := True;
  end;
{$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};

end;

function TMainWorkThread1219.GetFileSize(const sFile: string; const OffSet,
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

function TMainWorkThread1219.GetMaxWorkCount: Integer;
var
  {I,} nC: Integer;
begin
  m_sCurMessage := '正在统计数据...';
  {$IF THREADWORK}Synchronize({$IFEND}OutMessage{$IF THREADWORK}){$IFEND};
  nC  := 0;
    begin//需要修改
      Inc(nC, GetFileSize(FrmMain.Hum_db1219.text+ '\DBServer\FDB\HUM.db', Sizeof(TDBHeader), Sizeof(TDBHum)));
      Sleep(1);
    end;
  Result  := nC;
end;
//读取人物数据 20071122
procedure TMainWorkThread1219.LoadHumDB(const sRoot: string; ListArray: TListArray);
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

procedure TMainWorkThread1219.MakeInOne();
var
  IDCount3:integer;
  m_Header2: TDBHeader1; //0x2C 人物数据库头
  
  f_HumH, f_MirH: THandle;
  DBHum: TDBHum;
  HumData:THumDataInfo1219;
  NewHumData:TNewHumDataInfo;
  J: Integer;
begin
  IDCount3:=0;//20080302
  if f_MainMirH = 0 then
    f_MainMirH  := FileCreate(Self.m_sMainRoot + '\DBServer\FDB\NewMir.db', fmOpenReadWrite or fmShareDenyNone);

//打开从库数据文件  20071122
  f_HumH  := FileOpen(FrmMain.Hum_db1219.text, 0);//需要修改
  f_MirH  := FileOpen(FrmMain.Mir_db1219.text, 0);//需要修改

  FileSeek(f_MainMirH, 0, 0);
  if FileRead(f_MainMirH, m_Header2, SizeOf(TDBHeader1)) = SizeOf(TDBHeader1) then
  begin
    IDCount3 := m_Header2.nHumCount;
  end;

//////////////////////////////////////////////////////////////////
                                                                     //需要修改
  m_nCurMax  := GetFileSize({sRoot + '\DBServer\FDB\Hum.db'}FrmMain.Hum_db1219.text, Sizeof(TDBHeader1), Sizeof(TDBHum)); //FileSeek(f_HumH, Sizeof(TDBFileHeader), 2) div Sizeof(DBHum);
  FileSeek(f_HumH, Sizeof(TDBHeader1), 0);//0---从文件头开始定位

  m_nCurPostion := 0;

  while FileRead(f_HumH, DBHum, Sizeof(DBHum)) = Sizeof(DBHum) do  //T 循环读出人物数据
    begin
      FileSeek(f_MirH, Sizeof(TDBHeader1)+ Sizeof(THumDataInfo1219) * m_nCurPostion, 0);//需要修改
      FileRead(f_MirH, HumData, Sizeof(THumDataInfo1219));//需要修改

///////////////////////////////////////////////
{20071119增加,先更新数据头,再写入数据}
      Inc(IDCount3);

      FileSeek(f_MainMirH, 0, 0);
      m_Header2.sDesc:=DBFileDesc;
      m_Header2.nHumCount:=IDCount3;
      FileWrite(f_MainMirH, m_Header2, SizeOf(TDBHeader1));
      FileSeek(f_MainMirH, 0, 2);//2---从文件尾部定位

      FillChar(NewHumData, SizeOf(NewHumData), #0);
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
      NewHumData.Data.Abil.NG:=HumData.Data.Abil.NG;
      NewHumData.Data.Abil.MaxNG:=HumData.Data.Abil.MaxNG;

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
      //NewHumData.Data.btUnKnow1:=HumData.Data.btUnKnow1;
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
      NewHumData.Data.btGameGlory:=HumData.Data.btGameGlory;//荣誉 20080511
      NewHumData.Data.nPayMentPoint:=HumData.Data.nPayMentPoint;
      NewHumData.Data.nLoyal:= HumData.Data.nLoyal;

      NewHumData.Data.nPKPOINT:=HumData.Data.nPKPOINT;
      NewHumData.Data.btAllowGroup:=HumData.Data.btAllowGroup;
      NewHumData.Data.btF9:=HumData.Data.btF9;
      NewHumData.Data.btAttatckMode:=HumData.Data.btAttatckMode;
      NewHumData.Data.btIncHealth:=HumData.Data.btIncHealth ;
      NewHumData.Data.btIncSpell:=HumData.Data.btIncSpell ;
      NewHumData.Data.btIncHealing:=HumData.Data.btIncHealing ;
      NewHumData.Data.btFightZoneDieCount:=HumData.Data.btFightZoneDieCount;
      NewHumData.Data.sAccount:=HumData.Data.sAccount;
      //NewHumData.Data.btEE:=HumData.Data.btEE ;
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
      NewHumData.Data.sHeroChrName:= HumData.Data.sHeroChrName;
      for J:= Low(TUnKnow1) to High(TUnKnow1) do begin
        NewHumData.Data.UnKnow[J]:=HumData.Data.UnKnow[J];
      end;
      NewHumData.Data.QuestFlag:=HumData.Data.QuestFlag;
      NewHumData.Data.HumItems:=HumData.Data.HumItems;
      NewHumData.Data.BagItems:=HumData.Data.BagItems;

      for J:= Low(THumMagic) to High(THumMagic) do begin
        NewHumData.Data.HumMagics[J]:=HumData.Data.HumMagics[J];
      end;

      NewHumData.Data.StorageItems:=HumData.Data.StorageItems;
      NewHumData.Data.HumAddItems:=HumData.Data.HumAddItems;
      NewHumData.Data.n_WinExp:=HumData.Data.n_WinExp;
      NewHumData.Data.n_UsesItemTick:=HumData.Data.n_UsesItemTick;

      NewHumData.Data.nReserved:=HumData.Data.nReserved; //酿酒的时间,即还有多长时间可以取回酒 20080620
      NewHumData.Data.nReserved1:=HumData.Data.nReserved1; //当前药力值 20080623
      NewHumData.Data.nReserved2:=HumData.Data.nReserved2; //药力值上限 20080623
      NewHumData.Data.nReserved3:=HumData.Data.nReserved3; //使用药酒时间,计算长时间没使用药酒 20080623
      NewHumData.Data.n_Reserved:=HumData.Data.n_Reserved;   //当前酒量值 20080622
      NewHumData.Data.n_Reserved1:=HumData.Data.n_Reserved1;  //酒量上限 20080622
      NewHumData.Data.n_Reserved2:=HumData.Data.n_Reserved2;  //当前醉酒度 20080623
      NewHumData.Data.n_Reserved3:=HumData.Data.n_Reserved3;  //药力值等级 20080623
      NewHumData.Data.boReserved:=HumData.Data.boReserved; //是否请过酒 T-请过酒
      NewHumData.Data.boReserved1:=HumData.Data.boReserved1;//是否有卧龙英雄 20080519
      NewHumData.Data.boReserved2:=HumData.Data.boReserved2;//是否酿酒 T-正在酿酒 20080620
      NewHumData.Data.boReserved3:=HumData.Data.boReserved3;//人是否喝酒醉了 20080627
      NewHumData.Data.m_GiveDate:=HumData.Data.m_GiveDate;//人物领取行会酒泉日期 20080625
      NewHumData.Data.Exp68:=HumData.Data.Exp68;//酒气护体当前经验 20080625
      NewHumData.Data.MaxExp68:=HumData.Data.MaxExp68;//酒气护体升级经验 20080625
      
      NewHumData.Data.nExpSkill69:=HumData.Data.nExpSkill69;//内功当前经验
      //NewHumData.Data.HumNGMagics:=HumData.Data;//内功技能 需循环
      for J:= Low(THumNGMagics) to High(THumNGMagics) do begin
        NewHumData.Data.HumNGMagics[J]:=HumData.Data.HumNGMagics[J];
      end;

      NewHumData.Data.m_nReserved1:=HumData.Data.m_nReserved1;//保留
      NewHumData.Data.m_nReserved2:=HumData.Data.m_nReserved2;//保留
      NewHumData.Data.m_nReserved3:=HumData.Data.m_nReserved3;//保留
      NewHumData.Data.m_nReserved4:=HumData.Data.m_nReserved4;//保留
      NewHumData.Data.m_nReserved5:=HumData.Data.m_nReserved5;//保留
      NewHumData.Data.m_nReserved6:=HumData.Data.m_nReserved6;//保留
      NewHumData.Data.m_nReserved7:=HumData.Data.m_nReserved7;//保留

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

  FileClose(f_HumH);
  FileClose(f_MirH);
end;

procedure TMainWorkThread1219.OutMessage;
begin
  if Assigned(MainOutInforProc1219) then
    MainOutInforProc1219(m_sCurMessage);
end;

{$IF not THREADWORK}
procedure TMainWorkThread1219.Run;
begin
  g_Terminated  := False;
  Execute;
end;
{$IFEND}

procedure TMainWorkThread1219.SetWorkRoots(SL:String);
begin
  m_WorkRoots.Add(sl);
end;

end.



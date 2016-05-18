unit LocalDB;

interface

uses
  Windows, SysUtils, Classes, ActiveX,
  M2Share, {$IF DBTYPE = BDE}DBTables{$ELSE}ADODB{$IFEND}, DB, HUtil32, Grobal2, SDK,
  ObjNpc, UsrEngn;

type
  TDefineInfo = record
    sName: string;
    sText: string;
  end;
  pTDefineInfo = ^TDefineInfo;

  TQDDinfo = record
    n00: Integer;
    s04: string;
    sList: TStringList;
  end;
  pTQDDinfo = ^TQDDinfo;

  TGoodFileHeader = record
    nItemCount: Integer;
    Resv: array[0..251] of Integer;
  end;

  TFrmDB = class {(TForm)}
  private
    procedure DeCodeStringList(StringList: TStringList);
    procedure SetStringList(StringList: TStringList);//脚本插件注册后,则可使用此函数 20081017
    { Private declarations }
  public
{$IF DBTYPE = BDE}
    Query: TQuery;
{$ELSE}
    Query: TADOQuery;
{$IFEND}
    constructor Create();
    destructor Destroy; override;
    function LoadMonitems(MonName: string; var ItemList: TList): Integer;
    function LoadItemsDB(): Integer;
    function LoadMinMap(): Integer;
    function LoadMapInfo(): Integer;
    function LoadMonsterDB(): Integer;
    function LoadMagicDB(): Integer;
    function LoadMonGen(): Integer;
    function LoadUnbindList(): Integer;
    function LoadMapQuest(): Integer;
    function LoadQuestDiary(): Integer;
    function LoadAdminList(): Boolean;
    function LoadMerchant(): Integer;
    function LoadGuardList(): Integer;
    function LoadNpcs(): Integer;
    procedure QMangeNPC;
    procedure QFunctionNPC;
    procedure RobotNPC();

    function LoadMakeItem(): Integer;
    function LoadStartPoint(): Integer;
    function LoadNpcScript(NPC: TNormNpc; sPatch, sScritpName: string): Integer;
    function LoadScriptFile(NPC: TNormNpc; sPatch, sScritpName: string; boFlag: Boolean): Integer;
    function LoadGoodRecord(NPC: TMerchant; sFile: string): Integer;
    function LoadGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;

    function SaveGoodRecord(NPC: TMerchant; sFile: string): Integer;
    function SaveGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;

    function LoadUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
    function SaveUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
    procedure ReLoadMerchants();
    procedure ReLoadNpc();

    procedure LoadBoxsList;//读取宝箱列表 20080114
    procedure LoadSuitItemList();//读取套装装备数据 20080225
    procedure LoadSellOffItemList(); //读取元宝寄售列表 20080316
    procedure SaveSellOffItemList();//保存元宝寄售列表 20080317
    procedure LoadRefineItem();//读取淬炼配置数据 20080502

    function LoadMapEvent(): Integer;
    { Public declarations }
  end;

var
  FrmDB: TFrmDB;
implementation

uses ObjBase, Envir,EDcodeUnit;
//{$R *.dfm}

{ TFrmDB }
function TFrmDB.LoadAdminList(): Boolean;
var
  sFileName: string;
  sLineText: string;
  sIPaddr: string;
  sCharName: string;
  sData: string;
  LoadList: TStringList;
  AdminInfo: pTAdminInfo;
  I: Integer;
  nLv: Integer;
begin
  Result := False; ;
  sFileName := g_Config.sEnvirDir + 'AdminList.txt';
  if not FileExists(sFileName) then Exit;
  UserEngine.m_AdminList.Lock;
  try
    UserEngine.m_AdminList.Clear;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      nLv := -1;
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        if sLineText[1] = '*' then nLv := 10
        else if sLineText[1] = '1' then nLv := 9
        else if sLineText[1] = '2' then nLv := 8
        else if sLineText[1] = '3' then nLv := 7
        else if sLineText[1] = '4' then nLv := 6
        else if sLineText[1] = '5' then nLv := 5
        else if sLineText[1] = '6' then nLv := 4
        else if sLineText[1] = '7' then nLv := 3
        else if sLineText[1] = '8' then nLv := 2
        else if sLineText[1] = '9' then nLv := 1;
        if nLv > 0 then begin
          sLineText := GetValidStrCap(sLineText, sData, ['/', '\', ' ', #9]);
          sLineText := GetValidStrCap(sLineText, sCharName, ['/', '\', ' ', #9]);
          sLineText := GetValidStrCap(sLineText, sIPaddr, ['/', '\', ' ', #9]);
{$IF VEROWNER = WL}
          if (sCharName <= '') or (sIPaddr = '') then Continue;
{$IFEND}
          New(AdminInfo);
          AdminInfo.nLv := nLv;
          AdminInfo.sChrName := sCharName;
          AdminInfo.sIPaddr := sIPaddr;
          UserEngine.m_AdminList.Add(AdminInfo);
        end;
      end;
    end;//for
    LoadList.Free;
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  Result := True;
end;
//00488A68
function TFrmDB.LoadGuardList(): Integer;
var
  sFileName, s14, s1C, s20, s24, s28, s2C: string;
  tGuardList: TStringList;
  I: Integer;
  tGuard: TBaseObject;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + 'GuardList.txt';
  if FileExists(sFileName) then begin
    tGuardList := TStringList.Create;
    tGuardList.LoadFromFile(sFileName);
    if tGuardList.Count > 0 then begin//20080629
      for I := 0 to tGuardList.Count - 1 do begin
        s14 := tGuardList.Strings[I];
        if (s14 <> '') and (s14[1] <> ';') then begin
          s14 := GetValidStrCap(s14, s1C, [' ']);
          if (s1C <> '') and (s1C[1] = '"') then
            ArrestStringEx(s1C, '"', '"', s1C);
          s14 := GetValidStr3(s14, s20, [' ']);
          s14 := GetValidStr3(s14, s24, [' ', ',']);
          s14 := GetValidStr3(s14, s28, [' ', ',', ':']);
          s14 := GetValidStr3(s14, s2C, [' ', ':']);
          if (s1C <> '') and (s20 <> '') and (s2C <> '') then begin
            tGuard := UserEngine.RegenMonsterByName(s20, Str_ToInt(s24, 0), Str_ToInt(s28, 0), s1C);
            //sMapName,nX,nY,sName
            if tGuard <> nil then tGuard.m_btDirection := Str_ToInt(s2C, 0);
          end;
        end;
      end;//for
    end;
    tGuardList.Free;
    Result := 1;
  end;
end;
//读取物品数据
function TFrmDB.LoadItemsDB: Integer;
var
  I, Idx: Integer;
  StdItem: pTStdItem;
resourcestring
sSQLString = 'select Idx,Name,StdMode,Shape,Weight,AniCount,Source,Reserved,Looks,DuraMax,Ac,Ac2,Mac,Mac2,Dc,DC2,Mc,Mc2,Sc,Sc2,Need,NeedLevel,Price from StdItems';
// sSQLString = 'select * from StdItems';
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    try
      if UserEngine.StdItemList.Count > 0 then begin//20080629
        for I := 0 to UserEngine.StdItemList.Count - 1 do begin
          if pTStdItem(UserEngine.StdItemList.Items[I]) <> nil then
            Dispose(pTStdItem(UserEngine.StdItemList.Items[I]));
        end;
        UserEngine.StdItemList.Clear;
      end;
      Result := -1;
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      try
        Query.Open;
      finally
        Result := -2;
      end;
      if Query.RecordCount > 0 then begin//20080629
        for I := 0 to Query.RecordCount - 1 do begin
          New(StdItem);
          Idx := Query.FieldByName('Idx').AsInteger;//序号
          StdItem.Name := Query.FieldByName('Name').AsString;//名称
          StdItem.StdMode := Query.FieldByName('StdMode').AsInteger;//分类号
          StdItem.Shape := Query.FieldByName('Shape').AsInteger;//装备外观
          StdItem.Weight := Query.FieldByName('Weight').AsInteger;//重量
          StdItem.AniCount := Query.FieldByName('AniCount').AsInteger;
          StdItem.Source := Query.FieldByName('Source').AsInteger;
          StdItem.Reserved := Query.FieldByName('Reserved').AsInteger;//保留
          StdItem.Looks := Query.FieldByName('Looks').AsInteger;//物品外观
          StdItem.DuraMax := Word(Query.FieldByName('DuraMax').AsInteger);//持久力
          StdItem.AC := MakeLong(Round(Query.FieldByName('Ac').AsInteger * (g_Config.nItemsACPowerRate / 10)), Round(Query.FieldByName('Ac2').AsInteger * (g_Config.nItemsACPowerRate / 10)));
          StdItem.MAC := MakeLong(Round(Query.FieldByName('Mac').AsInteger * (g_Config.nItemsACPowerRate / 10)), Round(Query.FieldByName('MAc2').AsInteger * (g_Config.nItemsACPowerRate / 10)));
          StdItem.DC := MakeLong(Round(Query.FieldByName('Dc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Dc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
          StdItem.MC := MakeLong(Round(Query.FieldByName('Mc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Mc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
          StdItem.SC := MakeLong(Round(Query.FieldByName('Sc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Sc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
          StdItem.Need := Query.FieldByName('Need').AsInteger;//附加条件
          StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;//需要等级
          StdItem.Price := Query.FieldByName('Price').AsInteger;//价格
          //StdItem.Stock := Query.FieldByName('Stock').AsInteger;//库存 20080610
          StdItem.NeedIdentify := GetGameLogItemNameList(StdItem.Name);
          //if Query.FindField('Desc') <> nil then //20080805 注释
          //   StdItem.sDesc:= Trim(Query.FieldByName('Desc').AsString);//物品说明 20080702
          if UserEngine.StdItemList.Count = Idx then begin
            UserEngine.StdItemList.Add(StdItem);
            Result := 1;
          end else begin
            Memo.Lines.Add(Format('加载物品(Idx:%d Name:%s)数据失败！！！', [Idx, StdItem.Name]));
            Result := -100;
            Exit;
          end;
          Query.Next;
        end;//for
      end;
      g_boGameLogGold := GetGameLogItemNameList(sSTRING_GOLDNAME) = 1;
      g_boGameLogHumanDie := GetGameLogItemNameList(g_sHumanDieEvent) = 1;
      g_boGameLogGameGold := GetGameLogItemNameList(g_Config.sGameGoldName) = 1;
      g_boGameLogGameDiaMond := GetGameLogItemNameList(g_Config.sGameDiaMond) = 1;//是否写入日志(调整金刚石) 20071226
      g_boGameLogGameGird := GetGameLogItemNameList(g_Config.sGameGird) = 1;//是否写入日志(调整灵符) 20071226
      g_boGameLogGameGlory := GetGameLogItemNameList(g_Config.sGameGlory) = 1;//是否写入日志(调整荣誉值) 20080511
      g_boGameLogGamePoint := GetGameLogItemNameList(g_Config.sGamePointName) = 1;
    finally
      Query.Close;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMagicDB(): Integer;
var
  I: Integer;
  Magic, OldMagic: pTMagic;
  OldMagicList: TList;
resourcestring
  //sSQLString = 'select * from Magic';
sSQLString = 'select MagId,MagName,EffectType,Effect,Spell,Power,MaxPower,Job,'+
             'NeedL1,NeedL2,NeedL3,L1Train,L2Train,L3Train,Delay,DefSpell,DefPower,DefMaxPower,Descr from Magic';
begin
  Result := -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    UserEngine.SwitchMagicList();
    if UserEngine.m_MagicList.Count > 0 then begin//20080629
      for I := 0 to UserEngine.m_MagicList.Count - 1 do begin
        if pTMagic(UserEngine.m_MagicList.Items[I]) <> nil then
           Dispose(pTMagic(UserEngine.m_MagicList.Items[I]));
      end;
      UserEngine.m_MagicList.Clear;
    end;
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -2;
    end;
    if Query.RecordCount > 0 then begin//20080629
      for I := 0 to Query.RecordCount - 1 do begin
        New(Magic);
        Magic.wMagicId := Query.FieldByName('MagId').AsInteger;
        Magic.sMagicName := Query.FieldByName('MagName').AsString;
        Magic.btEffectType := Query.FieldByName('EffectType').AsInteger;
        Magic.btEffect := Query.FieldByName('Effect').AsInteger;
        Magic.wSpell := Query.FieldByName('Spell').AsInteger;
        Magic.wPower := Query.FieldByName('Power').AsInteger;
        Magic.wMaxPower := Query.FieldByName('MaxPower').AsInteger;
        Magic.btJob := Query.FieldByName('Job').AsInteger;
        Magic.TrainLevel[0] := Query.FieldByName('NeedL1').AsInteger;
        Magic.TrainLevel[1] := Query.FieldByName('NeedL2').AsInteger;
        Magic.TrainLevel[2] := Query.FieldByName('NeedL3').AsInteger;
        Magic.TrainLevel[3] := Query.FieldByName('NeedL3').AsInteger;
        Magic.MaxTrain[0] := Query.FieldByName('L1Train').AsInteger;
        Magic.MaxTrain[1] := Query.FieldByName('L2Train').AsInteger;
        Magic.MaxTrain[2] := Query.FieldByName('L3Train').AsInteger;
        Magic.MaxTrain[3] := Magic.MaxTrain[2];
        Magic.btTrainLv := 3;
        Magic.dwDelayTime := Query.FieldByName('Delay').AsInteger;
        Magic.btDefSpell := Query.FieldByName('DefSpell').AsInteger;
        Magic.btDefPower := Query.FieldByName('DefPower').AsInteger;
        Magic.btDefMaxPower := Query.FieldByName('DefMaxPower').AsInteger;
        Magic.sDescr := Query.FieldByName('Descr').AsString;
        if Magic.wMagicId > 0 then begin
          UserEngine.m_MagicList.Add(Magic);
        end else begin
          Dispose(Magic);
        end;
        Result := 1;
        Query.Next;
      end;//for
    end;
    Query.Close;
    if UserEngine.OldMagicList.Count > 0 then begin
      OldMagicList := TList(UserEngine.OldMagicList.Items[UserEngine.OldMagicList.Count - 1]);
      if OldMagicList.Count > 0 then begin//20080629
        for I := 0 to OldMagicList.Count - 1 do begin
          OldMagic := pTMagic(OldMagicList.Items[I]);
          if OldMagic.wMagicId >= 100 then begin
            New(Magic);
            Magic.wMagicId := OldMagic.wMagicId;
            Magic.sMagicName := OldMagic.sMagicName;
            Magic.btEffectType := OldMagic.btEffectType;
            Magic.btEffect := OldMagic.btEffect;
            //Magic.bt11 := OldMagic.bt11;
            Magic.wSpell := OldMagic.wSpell;
            Magic.wPower := OldMagic.wPower;
            Magic.TrainLevel := OldMagic.TrainLevel;
            //Magic.w02 := OldMagic.w02;
            Magic.MaxTrain := OldMagic.MaxTrain;
            Magic.btTrainLv := OldMagic.btTrainLv;
            Magic.btJob := OldMagic.btJob;
            //Magic.wMagicIdx := OldMagic.wMagicIdx;
            Magic.dwDelayTime := OldMagic.dwDelayTime;
            Magic.btDefSpell := OldMagic.btDefSpell;
            Magic.btDefPower := OldMagic.btDefPower;
            Magic.wMaxPower := OldMagic.wMaxPower;
            Magic.btDefMaxPower := OldMagic.btDefMaxPower;
            Magic.sDescr := OldMagic.sDescr;
            UserEngine.m_MagicList.Add(Magic);
          end;
        end;//for
      end;
      UserEngine.m_boStartLoadMagic := False;
      { for i := 0 to OldMagicList.Count - 1 do begin
         DisPose(pTMagic(OldMagicList.Items[i]));
       end;
       OldMagicList.Free;
       UserEngine.OldMagicList.Clear;  }
    end;
    UserEngine.m_boStartLoadMagic := False;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMakeItem(): Integer;
var
  I, n14: Integer;
  s18, s20, s24: string;
  LoadList: TStringList;
  sFileName: string;
  List28: TStringList;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + 'MakeItem.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    List28 := nil;
    s24 := '';
    for I := 0 to LoadList.Count - 1 do begin
      s18 := Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        if s18[1] = '[' then begin
          if List28 <> nil then
            g_MakeItemList.AddObject(s24, List28);
          List28 := TStringList.Create;
          ArrestStringEx(s18, '[', ']', s24);
        end else begin
          if List28 <> nil then begin
            s18 := GetValidStr3(s18, s20, [' ', #9]);
            n14 := Str_ToInt(Trim(s18), 1);
            List28.AddObject(s20, TObject(n14));
          end;
        end;
      end;
    end; // for
    if List28 <> nil then g_MakeItemList.AddObject(s24, List28);
    LoadList.Free;
    Result := 1;
  end;
end;

function TFrmDB.LoadMapInfo: Integer;
  function LoadMapQuest(sName: string): TMerchant;
  var
    QuestNPC: TMerchant;
  begin
    QuestNPC := TMerchant.Create;
    QuestNPC.m_sMapName := '0';
    QuestNPC.m_nCurrX := 0;
    QuestNPC.m_nCurrY := 0;
    QuestNPC.m_sCharName := sName;
    QuestNPC.m_nFlag := 0;
    QuestNPC.m_wAppr := 0;
    QuestNPC.m_sFilePath := 'MapQuest_def\';
    QuestNPC.m_boIsHide := True;
    QuestNPC.m_boIsQuest := False;
    UserEngine.QuestNPCList.Add(QuestNPC);
    Result := QuestNPC;
  end;
  procedure LoadSubMapInfo(LoadList: TStringList; sFileName: string);
  var
    I: Integer;
    sFilePatchName, sFileDir: string;
    LoadMapList: TStringList;
  begin
    sFileDir := g_Config.sEnvirDir + 'MapInfo\';
    if not DirectoryExists(sFileDir) then CreateDir(sFileDir);
    sFilePatchName := sFileDir + sFileName;
    if FileExists(sFilePatchName) then begin
      LoadMapList := TStringList.Create;
      LoadMapList.LoadFromFile(sFilePatchName);
      for I := 0 to LoadMapList.Count - 1 do LoadList.Add(LoadMapList.Strings[I]);
      LoadMapList.Free;
    end;
  end;
  function IsStrCount(str:string):Integer;//判断有几个')'号 20080727
  var
    i:integer;
  begin
    Result:=0;
    if length(str) <= 0 then Exit;
    for i:=1 to length(str) do
      if  (str[i] in [')']) then Inc(Result);
  end;
var
  sFileName: string;
  LoadList: TStringList;
  I: Integer;
  s30, s34, s38, sMapName, sMainMapName, s44, sMapDesc, s4C, sReConnectMap: string;
  n14, n18, n1C, n20 : Integer;
  nServerIndex: Integer;

  MapFlag: TMapFlag;
  QuestNPC: TMerchant;
  sMapInfoFile: string;
begin
  Result := -1;
  sFileName := g_Config.sEnvirDir + 'MapInfo.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    if LoadList.Count < 0 then begin
      LoadList.Free;
      Exit;
    end;
    I := 0;
    while (True) do begin
      if I >= LoadList.Count then Break;
      s34 := LoadList.Strings[I];
      if (s34 <> '') and (s34[1] <> '[') and (s34[1] <> ';') then begin
        if CompareLStr('loadmapinfo', s34{LoadList.Strings[I]}, 11{Length('loadmapinfo')}) then begin
          sMapInfoFile := GetValidStr3(s34{LoadList.Strings[I]}, s30, [' ', #9]);
          LoadList.Delete(I);
          if sMapInfoFile <> '' then  LoadSubMapInfo(LoadList, sMapInfoFile);
        end;
      end;
      Inc(I);
    end;
    Result := 1;
    //加载地图设置
    for I := 0 to LoadList.Count - 1 do begin
      s30 := LoadList.Strings[I];
      if (s30 <> '') and (s30[1] = '[') then begin
        sMapName := '';
        MapFlag.boSAFE := False;
        s30 := ArrestStringEx(s30, '[', ']', sMapName);
        sMapDesc := GetValidStrCap(sMapName, sMapName, [' ', ',', #9]);
        sMainMapName := Trim(GetValidStr3(sMapName, sMapName, ['|', '/', '\', #9])); //获取重复利用地图
        if (sMapDesc <> '') and (sMapDesc[1] = '"') then ArrestStringEx(sMapDesc, '"', '"', sMapDesc);
        s4C := Trim(GetValidStr3(sMapDesc, sMapDesc, [' ', ',', #9]));
        nServerIndex := Str_ToInt(s4C, 0);
        if sMapName = '' then Continue;
        FillChar(MapFlag, SizeOf(TMapFlag), #0);
        //MapFlag.nL := 1;//20080815 注释
        QuestNPC := nil;
        MapFlag.nNEEDSETONFlag := -1;
        MapFlag.nNeedONOFF := -1;
        MapFlag.sUnAllowStdItemsText := '';
        MapFlag.sUnAllowMagicText := '';
        MapFlag.boAutoMakeMonster := False;
        MapFlag.boNOTALLOWUSEMAGIC := False;
        MapFlag.boFIGHTPK := False;
        while (True) do begin
          if s30 = '' then Break;
          s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
          if s34 = '' then Break;
          MapFlag.nMUSICID := -1;
          MapFlag.sMUSICName := '';
          if CompareText(s34, 'SAFE') = 0 then begin
            MapFlag.boSAFE := True;
            Continue;
          end;
          if CompareText(s34, 'DARK') = 0 then begin
            MapFlag.boDARK := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT') = 0 then begin
            MapFlag.boFIGHT := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT2') = 0 then begin//PK掉装备地图 20080525
            MapFlag.boFIGHT2 := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT3') = 0 then begin
            MapFlag.boFIGHT3 := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT4') = 0 then begin//挑战地图 20080706
            MapFlag.boFIGHT4 := True;
            Continue;
          end;
          if CompareText(s34, 'DAY') = 0 then begin
            MapFlag.boDAY := True;
            Continue;
          end;
          if CompareText(s34, 'QUIZ') = 0 then begin
            MapFlag.boQUIZ := True;
            Continue;
          end;
          if CompareLStr(s34, 'NORECONNECT', 11{Length('NORECONNECT')}) then begin
            MapFlag.boNORECONNECT := True;
            ArrestStringEx(s34, '(', ')', sReConnectMap);
            MapFlag.sReConnectMap := sReConnectMap;
            if MapFlag.sReConnectMap = '' then Result := -11;
            Continue;
          end;
          if CompareLStr(s34, 'CHECKQUEST', 10{Length('CHECKQUEST')}) then begin
            ArrestStringEx(s34, '(', ')', s38);
            QuestNPC := LoadMapQuest(s38);
            Continue;
          end;
          if CompareLStr(s34, 'NEEDSET_ON', 10{Length('NEEDSET_ON')}) then begin
            MapFlag.nNeedONOFF := 1;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nNEEDSETONFlag := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'NEEDSET_OFF', 11{Length('NEEDSET_OFF')}) then begin
            MapFlag.nNeedONOFF := 0;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nNEEDSETONFlag := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'MUSIC', 5{Length('MUSIC')}) then begin
            MapFlag.boMUSIC := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nMUSICID := Str_ToInt(s38, -1);
            MapFlag.sMUSICName := s38;
            Continue;
          end;
          if CompareLStr(s34, 'EXPRATE', 7{Length('EXPRATE')}) then begin
            MapFlag.boEXPRATE := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nEXPRATE := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKWINLEVEL', 10{Length('PKWINLEVEL')}) then begin
            MapFlag.boPKWINLEVEL := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKWINLEVEL := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKWINEXP', 8{Length('PKWINEXP')}) then begin
            MapFlag.boPKWINEXP := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKWINEXP := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKLOSTLEVEL', 11{Length('PKLOSTLEVEL')}) then begin
            MapFlag.boPKLOSTLEVEL := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKLOSTLEVEL := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'PKLOSTEXP', 9{Length('PKLOSTEXP')}) then begin
            MapFlag.boPKLOSTEXP := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nPKLOSTEXP := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECHP', 5{Length('DECHP')}) then begin
            MapFlag.boDECHP := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nDECHPPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECHPTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCHP', 5{Length('INCHP')}) then begin
            MapFlag.boINCHP := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nINCHPPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCHPTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECGAMEGOLD', 11{Length('DECGAMEGOLD')}) then begin
            MapFlag.boDECGAMEGOLD := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nDECGAMEGOLD := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECGAMEGOLDTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'DECGAMEPOINT', 12{Length('DECGAMEPOINT')}) then begin
            MapFlag.boDECGAMEPOINT := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nDECGAMEPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nDECGAMEPOINTTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'KILLFUNC', 8{Length('KILLFUNC')}) then begin//20080415 地图杀人触发
            MapFlag.boKILLFUNC := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nKILLFUNC := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCGAMEGOLD', 11{Length('INCGAMEGOLD')}) then begin
            MapFlag.boINCGAMEGOLD := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nINCGAMEGOLD := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCGAMEGOLDTIME := Str_ToInt(s38, -1);
            Continue;
          end;
          if CompareLStr(s34, 'INCGAMEPOINT', 12{Length('INCGAMEPOINT')}) then begin
            MapFlag.boINCGAMEPOINT := True;
            ArrestStringEx(s34, '(', ')', s38);

            MapFlag.nINCGAMEPOINT := Str_ToInt(GetValidStr3(s38, s38, ['/']), -1);
            MapFlag.nINCGAMEPOINTTIME := Str_ToInt(s38, -1);
            Continue;
          end;
//------------------------------------------------------------------------------
          if CompareLStr(s34, 'NEEDLEVELTIME', 13) then begin//雪域地图传送,判断等级,地图时间 20081228
            MapFlag.boNEEDLEVELTIME := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nNEEDLEVELPOINT := Str_ToInt(s38, 0);//进地图最低等级
            Continue;
          end;
          //时间到传送回指定地图坐标上 20081230 雪域地图
          if CompareLStr(s34, 'TIMEMOVEHOME', 12) then begin
            MapFlag.boMoveToHome := True;
            ArrestStringEx(s34, '(', ')', s38);
            s38:= GetValidStr3(s38, s4C, ['/']);
            MapFlag.sMoveToHomeMap := s4C;//传送的地图名
            s38:= GetValidStr3(s38, s4C, ['/']);
            MapFlag.nMoveToHomeX := Str_ToInt(s4c, 0);//传送的地图X
            MapFlag.nMoveToHomeY:= Str_ToInt(s38, 0);//传送的地图Y
            Continue;
          end;
//地图参数 NOCALLHERO (禁止召唤英雄，已召唤英雄将自动消失)  20080124
          if CompareText(s34, 'NOCALLHERO') = 0 then begin
            MapFlag.boNoCALLHERO := True;
            Continue;
          end;
//禁止英雄守护 20080629
          if CompareText(s34, 'NOHEROPROTECT') = 0 then begin
            MapFlag.boNoHeroPROTECT := True;
            Continue;
          end;
//地图参数 NODROPITEM 禁止死亡掉物品 20080503
          if CompareText(s34, 'NODROPITEM') = 0 then begin
            MapFlag.boNODROPITEM := True;
            Continue;
          end;
//地图参数 MISSION (不允许使用任何物品和技能，并且宝宝在该地图会自动消失，不能攻击)  20080124
          if CompareText(s34, 'MISSION') = 0 then begin 
            MapFlag.boMISSION := True;
            Continue;
          end;
//------------------------------------------------------------------------------
          if CompareText(s34, 'RUNHUMAN') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'RUNHUMAN', 8{Length('RUNHUMAN')}) then begin
            MapFlag.boRUNHUMAN := True;
            Continue;
          end;
          if CompareText(s34, 'RUNMON') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'RUNMON', 6{Length('RUNMON')}) then begin
            MapFlag.boRUNMON := True;
            Continue;
          end;
          if CompareText(s34, 'NEEDHOLE') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'NEEDHOLE', 8{Length('NEEDHOLE')}) then begin
            MapFlag.boNEEDHOLE := True;
            Continue;
          end;
          if CompareText(s34, 'NORECALL') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'NORECALL', 8{Length('NORECALL')}) then begin
            MapFlag.boNORECALL := True;
            Continue;
          end;
          if CompareText(s34, 'NOGUILDRECALL') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'NOGUILDRECALL', 13{Length('NOGUILDRECALL')}) then begin
            MapFlag.boNOGUILDRECALL := True;
            Continue;
          end;
          if CompareText(s34, 'NODEARRECALL') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'NODEARRECALL', 12{Length('NODEARRECALL')}) then begin
            MapFlag.boNODEARRECALL := True;
            Continue;
          end;
          if CompareText(s34, 'NOMASTERRECALL') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'NOMASTERRECALL', 14{Length('NOMASTERRECALL')}) then begin
            MapFlag.boNOMASTERRECALL := True;
            Continue;
          end;
          if CompareText(s34, 'NORANDOMMOVE') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'NORANDOMMOVE', 12{Length('NORANDOMMOVE')}) then begin
            MapFlag.boNORANDOMMOVE := True;
            Continue;
          end;
          if CompareText(s34, 'NODRUG') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'NODRUG', 6{Length('NODRUG')}) then begin
            MapFlag.boNODRUG := True;
            Continue;
          end;
          if CompareText(s34, 'NOMANNOMON') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'NOMANNOMON', 10{length('NOMANNOMON')}) then  begin//没有人就不刷怪 20080525
            MapFlag.boNoManNoMon := True;
            Continue;
          end;
          if CompareText(s34, 'MINE') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'MINE', 4{Length('MINE')}) then begin
            MapFlag.boMINE := True;
            Continue;
          end;
          if CompareText(s34, 'NOPOSITIONMOVE') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'NOPOSITIONMOVE', 14{Length('NOPOSITIONMOVE')}) then begin
            MapFlag.boNOPOSITIONMOVE := True;
            Continue;
          end;
          if CompareText(s34, 'AUTOMAKEMONSTER') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'AUTOMAKEMONSTER', 15{Length('AUTOMAKEMONSTER')}) then begin
            MapFlag.boAutoMakeMonster := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHTPK') = 0 then begin //20080815 修改
          //if CompareLStr(s34, 'FIGHTPK', 7{Length('FIGHTPK')}) then begin //PK可以爆装备不红名
            MapFlag.boFIGHTPK := True;
            Continue;
          end;

          if CompareLStr(s34,'THUNDER',7{length('THUNDER')}) then begin//20080327 闪电
            ArrestStringEx(s34,'(',')',s38);
            MapFlag.nThunder := Str_ToInt(s38,-1);
            Continue;
          end;
          if CompareLStr(s34,'LAVA',4{length('LAVA')}) then begin//20080327 地上冒岩浆
            ArrestStringEx(s34,'(',')',s38);
            MapFlag.nLava := Str_ToInt(s38,-1);
            Continue;
          end;

          if CompareLStr(s34, 'NOTALLOWUSEMAGIC', 16{Length('NOTALLOWUSEMAGIC')}) then begin //增加不允许使用魔法
            MapFlag.boNOTALLOWUSEMAGIC := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.sUnAllowMagicText := Trim(s38);
            Continue;
          end;

          if CompareLStr(s34, 'NOTALLOWUSEITEMS', 16{Length('NOTALLOWUSEITEMS')}) then begin //增加不允许使用物品
            MapFlag.boUnAllowStdItems := True;
            if IsStrCount(s34) > 1 then begin//判断有几个')' 20080727
              s38:=Copy(s34, pos('(',s34)+ 1, Length(s34)-(pos('(',s34)+ 1));
            end else ArrestStringEx(s34, '(', ')', s38);
            MapFlag.sUnAllowStdItemsText := Trim(s38);
            Continue;
          end;
          {if (s34[1] = 'L') then begin //20080815 注释
            MapFlag.nL := Str_ToInt(Copy(s34, 2, Length(s34) - 1), 1);
          end;}
        end;
        if g_MapManager.AddMapInfo(sMapName, sMainMapName, sMapDesc, nServerIndex, @MapFlag, QuestNPC) = nil then Result := -10;
      end else begin  //20080520 修改
        //加载地图连接点
        if (s30 <> '') and (s30[1] <> '[') and (s30[1] <> ';') then begin
          s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
          sMapName := s34;
          s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
          n14 := Str_ToInt(s34, 0);
          s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
          n18 := Str_ToInt(s34, 0);
          s30 := GetValidStr3(s30, s34, [' ', ',', '-', '>', #9]);
          s44 := s34;
          s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
          n1C := Str_ToInt(s34, 0);
          s30 := GetValidStr3(s30, s34, [' ', ',', ';', #9]);
          n20 := Str_ToInt(s34, 0);
          g_MapManager.AddMapRoute(sMapName, n14, n18, s44, n1C, n20);
          //sSMapNO,nSMapX,nSMapY,sDMapNO,nDMapX,nDMapY
        end;
      end;
    end;//for
{    //加载地图连接点
    for I := 0 to LoadList.Count - 1 do begin
      s30 := LoadList.Strings[I];
      if (s30 <> '') and (s30[1] <> '[') and (s30[1] <> ';') then begin
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        sMapName := s34;
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n14 := Str_ToInt(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n18 := Str_ToInt(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', '-', '>', #9]);
        s44 := s34;
        s30 := GetValidStr3(s30, s34, [' ', ',', #9]);
        n1C := Str_ToInt(s34, 0);
        s30 := GetValidStr3(s30, s34, [' ', ',', ';', #9]);
        n20 := Str_ToInt(s34, 0);
        g_MapManager.AddMapRoute(sMapName, n14, n18, s44, n1C, n20);
        //sSMapNO,nSMapX,nSMapY,sDMapNO,nDMapX,nDMapY
      end;
    end; }
    LoadList.Free;
  end;
end;

procedure TFrmDB.QFunctionNPC;
var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string;
begin
  try
    sScriptFile := g_Config.sEnvirDir + sMarket_Def + 'QFunction-0.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir + sMarket_Def;
    if not DirectoryExists(sScritpDir) then MkDir(PChar(sScritpDir));

    if not FileExists(sScriptFile) then begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为功能脚本，用于实现各种与脚本有关的功能');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    if FileExists(sScriptFile) then begin
      g_FunctionNPC := TMerchant.Create;
      g_FunctionNPC.m_sMapName := '0';
      g_FunctionNPC.m_nCurrX := 0;
      g_FunctionNPC.m_nCurrY := 0;
      g_FunctionNPC.m_sCharName := 'QFunction';
      g_FunctionNPC.m_nFlag := 0;
      g_FunctionNPC.m_wAppr := 0;
      g_FunctionNPC.m_sFilePath := sMarket_Def;
      g_FunctionNPC.m_sScript := 'QFunction';
      g_FunctionNPC.m_boIsHide := True;
      g_FunctionNPC.m_boIsQuest := False;
      UserEngine.AddMerchant(g_FunctionNPC);
    end else begin
      g_FunctionNPC := nil;
    end;
  except
    g_FunctionNPC := nil;
  end;
end;

procedure TFrmDB.QMangeNPC();
var
  sScriptFile: string;
  sScritpDir: string;
  SaveList: TStringList;
  sShowFile: string;
begin
  try
    sScriptFile := g_Config.sEnvirDir + 'MapQuest_def\' + 'QManage.txt';
    sShowFile := ReplaceChar(sScriptFile, '\', '/');
    sScritpDir := g_Config.sEnvirDir + 'MapQuest_def\';
    if not DirectoryExists(sScritpDir) then MkDir(PChar(sScritpDir));

    if not FileExists(sScriptFile) then begin
      SaveList := TStringList.Create;
      SaveList.Add(';此脚为登录脚本，人物每次登录时都会执行此脚本，所有人物初始设置都可以放在此脚本中。');
      SaveList.Add(';修改脚本内容，可用@ReloadManage命令重新加载该脚本，不须重启程序。');
      SaveList.Add('[@Login]');
      SaveList.Add('#if');
      SaveList.Add('#act');
      //    tSaveList.Add(';设置10倍杀怪经验');
      //    tSaveList.Add(';CANGETEXP 1 10');
      SaveList.Add('#say');
      SaveList.Add('IGE科技登录脚本运行成功，欢迎进入本游戏！！！\ \');
      SaveList.Add('<关闭/@exit> \ \');
      SaveList.Add('登录脚本文件位于: \');
      SaveList.Add(sShowFile + '\');
      SaveList.Add('脚本内容请自行按自己的要求修改。');
      SaveList.SaveToFile(sScriptFile);
      SaveList.Free;
    end;
    if FileExists(sScriptFile) then begin
      g_ManageNPC := TMerchant.Create;
      g_ManageNPC.m_sMapName := '0';
      g_ManageNPC.m_nCurrX := 0;
      g_ManageNPC.m_nCurrY := 0;
      g_ManageNPC.m_sCharName := 'QManage';
      g_ManageNPC.m_nFlag := 0;
      g_ManageNPC.m_wAppr := 0;
      g_ManageNPC.m_sFilePath := 'MapQuest_def\';
      g_ManageNPC.m_boIsHide := True;
      g_ManageNPC.m_boIsQuest := False;
      UserEngine.QuestNPCList.Add(g_ManageNPC);
    end else begin
      g_ManageNPC := nil;
    end;
  except
    g_ManageNPC := nil;
  end;
end;

procedure TFrmDB.RobotNPC();
var
  sScriptFile: string;
  sScritpDir: string;
  tSaveList: TStringList;
begin
  try
    sScriptFile := g_Config.sEnvirDir + 'Robot_def\' + 'RobotManage.txt';
    sScritpDir := g_Config.sEnvirDir + 'Robot_def\';
    if not DirectoryExists(sScritpDir) then MkDir(PChar(sScritpDir));

    if not FileExists(sScriptFile) then begin
      tSaveList := TStringList.Create;
      tSaveList.Add(';此脚为机器人专用脚本，用于机器人处理功能用的脚本。');
      tSaveList.SaveToFile(sScriptFile);
      tSaveList.Free;
    end;
    if FileExists(sScriptFile) then begin
      g_RobotNPC := TMerchant.Create;
      g_RobotNPC.m_sMapName := '0';
      g_RobotNPC.m_nCurrX := 0;
      g_RobotNPC.m_nCurrY := 0;
      g_RobotNPC.m_sCharName := 'RobotManage';
      g_RobotNPC.m_nFlag := 0;
      g_RobotNPC.m_wAppr := 0;
      g_RobotNPC.m_sFilePath := 'Robot_def\';
      g_RobotNPC.m_boIsHide := True;
      g_RobotNPC.m_boIsQuest := False;
      UserEngine.QuestNPCList.Add(g_RobotNPC);
    end else begin
      g_RobotNPC := nil;
    end;
  except
    g_RobotNPC := nil;
  end;
end;

function TFrmDB.LoadMapEvent(): Integer;
var
  sFileName, tStr: string;
  tMapEventList: TStringList;
  I: Integer;
  s18, s1C, s20, s24, s28, s2C, s30, s34, s36, s38, s40, s42, s44, s46, sRange: string;
  MapEvent: pTMapEvent;
  Map: TEnvirnoment;
begin
  Result := 1;
  sFileName := g_Config.sEnvirDir + 'MapEvent.txt';
  if FileExists(sFileName) then begin
    tMapEventList := TStringList.Create;
    tMapEventList.LoadFromFile(sFileName);
    if tMapEventList.Count > 0 then begin//20080629
      for I := 0 to tMapEventList.Count - 1 do begin
        tStr := tMapEventList.Strings[I];
        if (tStr <> '') and (tStr[1] <> ';') then begin
          tStr := GetValidStr3(tStr, s18, [' ', #9]);
          tStr := GetValidStr3(tStr, s1C, [' ', #9]);
          tStr := GetValidStr3(tStr, s20, [' ', #9]);
          tStr := GetValidStr3(tStr, sRange, [' ', #9]);
          tStr := GetValidStr3(tStr, s24, [' ', #9]);
          tStr := GetValidStr3(tStr, s28, [' ', #9]);
          tStr := GetValidStr3(tStr, s2C, [' ', #9]);
          tStr := GetValidStr3(tStr, s30, [' ', #9]);
          if (s18 <> '') and (s1C <> '') and (s20 <> '') and (s30 <> '') then begin
            Map := g_MapManager.FindMap(s18);
            if Map <> nil then begin
              New(MapEvent);
              FillChar(MapEvent.m_MapFlag, SizeOf(TQuestUnitStatus), 0);
              FillChar(MapEvent.m_Condition, SizeOf(TMapCondition), #0);
              FillChar(MapEvent.m_StartScript, SizeOf(TStartScript), #0);
              MapEvent.m_sMapName := Trim(s18);
              MapEvent.m_nCurrX := Str_ToInt(s1C, 0);
              MapEvent.m_nCurrY := Str_ToInt(s20, 0);
              MapEvent.m_nRange := Str_ToInt(sRange, 0);
              s24 := GetValidStr3(s24, s34, [':', #9]);
              s24 := GetValidStr3(s24, s36, [':', #9]);
              MapEvent.m_MapFlag.nQuestUnit := Str_ToInt(s34, 0);
              if Str_ToInt(s36, 0) <> 0 then MapEvent.m_MapFlag.boOpen := True
              else MapEvent.m_MapFlag.boOpen := False;
              s28 := GetValidStr3(s28, s38, [':', #9]);
              s28 := GetValidStr3(s28, s40, [':', #9]);
              s28 := GetValidStr3(s28, s42, [':', #9]);
              MapEvent.m_Condition.nHumStatus := Str_ToInt(s38, 0);
              MapEvent.m_Condition.sItemName := Trim(s40);
              if Str_ToInt(s42, 0) <> 0 then MapEvent.m_Condition.boNeedGroup := True
              else MapEvent.m_Condition.boNeedGroup := False;
              MapEvent.m_nRandomCount := Str_ToInt(s2C, 999999);
              s30 := GetValidStr3(s30, s44, [':', #9]);
              s30 := GetValidStr3(s30, s46, [':', #9]);
              MapEvent.m_StartScript.nLable := Str_ToInt(s44, 0);
              MapEvent.m_StartScript.sLable := Trim(s46);
              case MapEvent.m_Condition.nHumStatus of
                1: g_MapEventListOfDropItem.Add(MapEvent);
                2: g_MapEventListOfPickUpItem.Add(MapEvent);
                3: g_MapEventListOfMine.Add(MapEvent);
                4: g_MapEventListOfWalk.Add(MapEvent);
                5: g_MapEventListOfRun.Add(MapEvent);
              else begin
                  Dispose(MapEvent);
                end;
              end;
            end else Result := -I;
          end;
        end;
      end;//for
    end;
    tMapEventList.Free;//20080117
  end;
end;

function TFrmDB.LoadMapQuest(): Integer;
var
  sFileName, tStr: string;
  tMapQuestList: TStringList;
  I: Integer;
  s18, s1C, s20, s24, s28, s2C, s30, s34: string;
  n38, n3C: Integer;
  boGrouped: Boolean;
  Map: TEnvirnoment;
begin
  Result := 1;
  sFileName := g_Config.sEnvirDir + 'MapQuest.txt';
  if FileExists(sFileName) then begin
    tMapQuestList := TStringList.Create;
    tMapQuestList.LoadFromFile(sFileName);
    if tMapQuestList.Count > 0 then begin //20080629
      for I := 0 to tMapQuestList.Count - 1 do begin
        tStr := tMapQuestList.Strings[I];
        if (tStr <> '') and (tStr[1] <> ';') then begin
          tStr := GetValidStr3(tStr, s18, [' ', #9]);
          tStr := GetValidStr3(tStr, s1C, [' ', #9]);
          tStr := GetValidStr3(tStr, s20, [' ', #9]);
          tStr := GetValidStr3(tStr, s24, [' ', #9]);
          if (s24 <> '') and (s24[1] = '"') then ArrestStringEx(s24, '"', '"', s24);
          tStr := GetValidStr3(tStr, s28, [' ', #9]);
          if (s28 <> '') and (s28[1] = '"') then ArrestStringEx(s28, '"', '"', s28);
          tStr := GetValidStr3(tStr, s2C, [' ', #9]);
          tStr := GetValidStr3(tStr, s30, [' ', #9]);
          if (s18 <> '') and (s24 <> '') and (s2C <> '') then begin
            Map := g_MapManager.FindMap(s18);
            if Map <> nil then begin
              ArrestStringEx(s1C, '[', ']', s34);
              n38 := Str_ToInt(s34, 0);
              n3C := Str_ToInt(s20, 0);
              if CompareLStr(s30, 'GROUP', 5{Length('GROUP')}) then boGrouped := True
              else boGrouped := False;
              if not Map.CreateQuest(n38, n3C, s24, s28, s2C, boGrouped) then Result := -I;
              //nFlag,boFlag,Monster,Item,Quest,boGrouped
            end else Result := -I;
          end else Result := -I;
        end;
      end;//for
    end;
    tMapQuestList.Free;
  end;
  QMangeNPC();
  QFunctionNPC();
  RobotNPC();
end;
//脚本   地图     坐标X   坐标Y   NPC显示名   标识   种类  是否城堡  能否移动 是否变色 变色时间
function TFrmDB.LoadMerchant(): Integer;
var
  sFileName, sLineText, sScript, sMapName, sX, sY, sName, sFlag, sAppr, sIsCalste, sCanMove, sMoveTime, sAutoChangeColor, sAutoChangeColorTime: string;
  tMerchantList: TStringList;
  tMerchantNPC: TMerchant;
  I: Integer;
begin
  sFileName := g_Config.sEnvirDir + 'Merchant.txt';
  if FileExists(sFileName) then begin
    tMerchantList := TStringList.Create;
    tMerchantList.LoadFromFile(sFileName);
    if tMerchantList.Count > 0 then begin//20080629
      for I := 0 to tMerchantList.Count - 1 do begin
        sLineText := Trim(tMerchantList.Strings[I]);
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sLineText := GetValidStr3(sLineText, sScript, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sMapName, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sX, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sY, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sName, [' ', #9]);
          if (sName <> '') and (sName[1] = '"') then
            ArrestStringEx(sName, '"', '"', sName);
          sLineText := GetValidStr3(sLineText, sFlag, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sAppr, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sIsCalste, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sCanMove, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sMoveTime, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sAutoChangeColor, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sAutoChangeColorTime, [' ', #9]);

          if (sScript <> '') and (sMapName <> '') and (sAppr <> '') then begin
            tMerchantNPC := TMerchant.Create;
            tMerchantNPC.m_sScript := sScript;
            tMerchantNPC.m_sMapName := sMapName;
            tMerchantNPC.m_nCurrX := Str_ToInt(sX, 0);
            tMerchantNPC.m_nCurrY := Str_ToInt(sY, 0);
            tMerchantNPC.m_sCharName := sName;//NPC名字
            tMerchantNPC.m_nFlag := Str_ToInt(sFlag, 0);
            tMerchantNPC.m_wAppr := Str_ToInt(sAppr, 0);
            tMerchantNPC.m_dwMoveTime := Str_ToInt(sMoveTime, 0);
            tMerchantNPC.m_dwNpcAutoChangeColorTime := Str_ToInt(sAutoChangeColorTime, 0) * 1000;
            if Str_ToInt(sIsCalste, 0) <> 0 then tMerchantNPC.m_boCastle := True;
            if (Str_ToInt(sCanMove, 0) <> 0) and (tMerchantNPC.m_dwMoveTime > 0) then
              tMerchantNPC.m_boCanMove := True;
            if Str_ToInt(sAutoChangeColor, 0) <> 0 then tMerchantNPC.m_boNpcAutoChangeColor := True;
            UserEngine.AddMerchant(tMerchantNPC);
          end;
        end;
      end;//for
    end;
    tMerchantList.Free;
  end;
  Result := 1;
end;

function TFrmDB.LoadMinMap: Integer;
var
  sFileName, tStr, sMapNO, sMapIdx: string;
  tMapList: TStringList;
  I, nIdx: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'MiniMap.txt';
  if FileExists(sFileName) then begin
    if MiniMapList.Count > 0 then MiniMapList.Clear;//20080831 修改
    tMapList := TStringList.Create;
    tMapList.LoadFromFile(sFileName);
    for I := 0 to tMapList.Count - 1 do begin
      tStr := tMapList.Strings[I];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr := GetValidStr3(tStr, sMapNO, [' ', #9]);
        tStr := GetValidStr3(tStr, sMapIdx, [' ', #9]);
        nIdx := Str_ToInt(sMapIdx, 0);
        if nIdx > 0 then MiniMapList.AddObject(sMapNO, TObject(nIdx));
      end;
    end;//for
    tMapList.Free;
  end;
end;

function TFrmDB.LoadMonGen(): Integer;
  procedure LoadMapGen(MonGenList: TStringList; sFileName: string);
  var
    I: Integer;
    sFilePatchName: string;
    sFileDir: string;
    LoadList: TStringList;
  begin
    sFileDir := g_Config.sEnvirDir + 'MonGen\';
    if not DirectoryExists(sFileDir) then begin
      CreateDir(sFileDir);
    end;

    sFilePatchName := sFileDir + sFileName;
    if FileExists(sFilePatchName) then begin
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(sFilePatchName);
      for I := 0 to LoadList.Count - 1 do  MonGenList.Add(LoadList.Strings[I]);
      LoadList.Free;
    end;
  end;
var
  sFileName, sLineText, sData: string;
  MonGenInfo: pTMonGenInfo;
  LoadList: TStringList;
  sMapGenFile: string;
  I: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'MonGen.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    I := 0;
    while (True) do begin
      if I >= LoadList.Count then Break;
      if CompareLStr('loadgen', LoadList.Strings[I], 7{Length('loadgen')}) then begin
        sMapGenFile := GetValidStr3(LoadList.Strings[I], sLineText, [' ', #9]);
        LoadList.Delete(I);
        if sMapGenFile <> '' then LoadMapGen(LoadList, sMapGenFile);
      end;
      Inc(I);
    end;

    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        New(MonGenInfo);
        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//地图代码
        MonGenInfo.sMapName := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//X
        MonGenInfo.nX := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//Y
        MonGenInfo.nY := Str_ToInt(sData, 0);

        sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);//怪物名
        if (sData <> '') and (sData[1] = '"') then ArrestStringEx(sData, '"', '"', sData);

        MonGenInfo.sMonName := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//范围
        MonGenInfo.nRange := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//数量
        MonGenInfo.nCount := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//时间
        //MonGenInfo.dwZenTime := Str_ToInt(sData, -1) * 60000{60 * 1000};
        MonGenInfo.dwZenTime := Str_ToInt(sData, 1) * 60000{60 * 1000};//20081009 修改

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//内功怪,打死可以增加内力值 20081001
        MonGenInfo.boIsNGMon := Str_ToInt(sData, 0) <> 0 ;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//自定义名字的颜色 20080810
        MonGenInfo.nNameColor := Str_ToInt(sData, 255);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nMissionGenRate := Str_ToInt(sData, 0); //集中座标刷新机率 1 -100

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nChangeColorType := Str_ToInt(sData, -1); //变色2007-02-01增加

        if (MonGenInfo.sMapName <> '') and
          (MonGenInfo.sMonName <> '') and
          (MonGenInfo.dwZenTime <> 0) and
          (g_MapManager.GetMapInfo(nServerIndex, MonGenInfo.sMapName) <> nil) then begin
          MonGenInfo.CertList := TList.Create;
          MonGenInfo.Envir := g_MapManager.FindMap(MonGenInfo.sMapName);
          if MonGenInfo.Envir <> nil then begin
            UserEngine.m_MonGenList.Add(MonGenInfo);
            UserEngine.AddMapMonGenCount(MonGenInfo.sMapName, MonGenInfo.nCount);
          end else begin
            Dispose(MonGenInfo);
          end;
        end;
        //tMonGenInfo.nRace:=UserEngine.GetMonRace(tMonGenInfo.sMonName);
      end;
    end;//for

    New(MonGenInfo);
    MonGenInfo.sMapName := '';
    MonGenInfo.sMonName := '';
    MonGenInfo.CertList := TList.Create;
    MonGenInfo.Envir := nil;
    UserEngine.m_MonGenList.Add(MonGenInfo);

    LoadList.Free;
    Result := 1;
  end;
end;

function TFrmDB.LoadMonsterDB(): Integer;
var
  I: Integer;
  Monster: pTMonInfo;
resourcestring
  //sSQLString = 'select * from Monster';
  sSQLString = 'select NAME,Race,RaceImg,Appr,Lvl,Undead,CoolEye,Exp,HP,MP,AC,MAC,'+
               'DC,DCMAX,MC,SC,SPEED,HIT,WALK_SPD,WalkStep,WalkWait,ATTACK_SPD from Monster';
begin
  Result := 0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    if UserEngine.MonsterList.Count > 0 then begin//20080629
      for I := 0 to UserEngine.MonsterList.Count - 1 do begin
        if pTMonInfo(UserEngine.MonsterList.Items[I]) <> nil then
           Dispose(pTMonInfo(UserEngine.MonsterList.Items[I]));
      end;
      UserEngine.MonsterList.Clear;
    end;
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
      Result := -1;
    end;
    if Query.RecordCount > 0 then begin//20080629
      for I := 0 to Query.RecordCount - 1 do begin
        New(Monster);
        Monster.ItemList := TList.Create;
        Monster.sName := Trim(Query.FieldByName('NAME').AsString);
        Monster.btRace := Query.FieldByName('Race').AsInteger;
        Monster.btRaceImg := Query.FieldByName('RaceImg').AsInteger;
        Monster.wAppr := Query.FieldByName('Appr').AsInteger;
        Monster.wLevel := Query.FieldByName('Lvl').AsInteger;
        Monster.btLifeAttrib := Query.FieldByName('Undead').AsInteger;//不死系 1-不死系
        Monster.wCoolEye := Query.FieldByName('CoolEye').AsInteger;
        Monster.dwExp := Query.FieldByName('Exp').AsInteger;
        //城门或城墙的状态跟HP值有关，如果HP异常，将导致城墙显示不了
        if (Monster.btRace=110) or (Monster.btRace=111) then begin //如果为城墙或城门由HP不加倍 20080829
          Monster.wHP := Query.FieldByName('HP').AsInteger;
        end else begin
          Monster.wHP := Round(Query.FieldByName('HP').AsInteger * (g_Config.nMonsterPowerRate / 10));
        end;

        Monster.wMP := Round(Query.FieldByName('MP').AsInteger * (g_Config.nMonsterPowerRate / 10));
        Monster.wAC := Round(Query.FieldByName('AC').AsInteger * (g_Config.nMonsterPowerRate / 10));
        Monster.wMAC := Round(Query.FieldByName('MAC').AsInteger * (g_Config.nMonsterPowerRate / 10));
        Monster.wDC := Round(Query.FieldByName('DC').AsInteger * (g_Config.nMonsterPowerRate / 10));
        Monster.wMaxDC := Round(Query.FieldByName('DCMAX').AsInteger * (g_Config.nMonsterPowerRate / 10));
        Monster.wMC := Round(Query.FieldByName('MC').AsInteger * (g_Config.nMonsterPowerRate / 10));
        Monster.wSC := Round(Query.FieldByName('SC').AsInteger * (g_Config.nMonsterPowerRate / 10));
        Monster.wSpeed := Query.FieldByName('SPEED').AsInteger;
        Monster.wHitPoint := Query.FieldByName('HIT').AsInteger;
        Monster.wWalkSpeed := _MAX(200, Query.FieldByName('WALK_SPD').AsInteger);
        Monster.wWalkStep := _MAX(1, Query.FieldByName('WalkStep').AsInteger);
        Monster.wWalkWait := Query.FieldByName('WalkWait').AsInteger;
        Monster.wAttackSpeed := Query.FieldByName('ATTACK_SPD').AsInteger;

        if Monster.wWalkSpeed < 200 then Monster.wWalkSpeed := 200;
        if Monster.wAttackSpeed < 200 then Monster.wAttackSpeed := 200;
        Monster.ItemList := nil;
        LoadMonitems(Monster.sName, Monster.ItemList);
        UserEngine.MonsterList.Add(Monster);
        Result := 1;
        Query.Next;
      end;
    end;
    Query.Close;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;
//读取怪物爆率文件
function TFrmDB.LoadMonitems(MonName: string; var ItemList: TList): Integer;
var
  I: Integer;
  s24: string;
  LoadList: TStringList;
  MonItem: pTMonItem;
  s28, s2C, s30: string;
  n18, n1C, n20: Integer;
begin
  Result := 0;
  s24 := g_Config.sEnvirDir + 'MonItems\' + MonName + '.txt';
  if FileExists(s24) then begin
    if ItemList <> nil then begin
      if ItemList.Count > 0 then begin
        for I := 0 to ItemList.Count - 1 do begin
          if pTMonItem(ItemList.Items[I]) <> nil then
             Dispose(pTMonItem(ItemList.Items[I]));
        end;
      end;
      ItemList.Clear;
    end;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(s24);
    for I := 0 to LoadList.Count - 1 do begin
      s28 := LoadList.Strings[I];
      if (s28 <> '') and (s28[1] <> ';') then begin
        s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
        n18 := Str_ToInt(s30, -1);
        s28 := GetValidStr3(s28, s30, [' ', '/', #9]);
        n1C := Str_ToInt(s30, -1);
        s28 := GetValidStr3(s28, s30, [' ', #9]);
        if s30 <> '' then begin
          if s30[1] = '"' then
            ArrestStringEx(s30, '"', '"', s30);
        end;
        s2C := s30;
        s28 := GetValidStr3(s28, s30, [' ', #9]);
        n20 := Str_ToInt(s30, 1);
        if (n18 > 0) and (n1C > 0) and (s2C <> '') then begin
          if ItemList = nil then ItemList := TList.Create;
          New(MonItem);
          MonItem.n00 := n18 - 1;
          MonItem.n04 := n1C;
          MonItem.sMonName := s2C;
          MonItem.n18 := n20;
          ItemList.Add(MonItem);
          Inc(Result);
        end;
      end;
    end;//for
    LoadList.Free;
  end;
end;
//;名称  代码  地图   x   y  范围  图标 是否变色 变色时间 
function TFrmDB.LoadNpcs(): Integer;
var
  sFileName, s18, s20, s24, s28, s2C, s30, s34, s38, s40, s42: string;
  LoadList: TStringList;
  NPC: TNormNpc;
  I: Integer;
begin
  sFileName := g_Config.sEnvirDir + 'Npcs.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      s18 := Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        s18 := GetValidStrCap(s18, s20, [' ', #9]);//名字
        if (s20 <> '') and (s20[1] = '"') then ArrestStringEx(s20, '"', '"', s20);
        s18 := GetValidStr3(s18, s24, [' ', #9]);//NPC类型
        s18 := GetValidStr3(s18, s28, [' ', #9]);//地图
        s18 := GetValidStr3(s18, s2C, [' ', #9]);//X
        s18 := GetValidStr3(s18, s30, [' ', #9]);//Y
        s18 := GetValidStr3(s18, s34, [' ', #9]);//范围
        s18 := GetValidStr3(s18, s38, [' ', #9]);//图标
        s18 := GetValidStr3(s18, s40, [' ', #9]);//是否变色
        s18 := GetValidStr3(s18, s42, [' ', #9]);//变色时间
        if (s20 <> '') and (s28 <> '') and (s38 <> '') then begin
          NPC := nil;
          case Str_ToInt(s24, 0) of
            0: NPC := TMerchant.Create;//普通NPC
            1: NPC := TGuildOfficial.Create;//行会NPC
            2: NPC := TCastleOfficial.Create;//城堡NPC
          end;
          if NPC <> nil then begin
            NPC.m_sMapName := s28;
            NPC.m_nCurrX := Str_ToInt(s2C, 0);
            NPC.m_nCurrY := Str_ToInt(s30, 0);
            NPC.m_sCharName := s20;
            NPC.m_nFlag := Str_ToInt(s34, 0);
            NPC.m_wAppr := Str_ToInt(s38, 0);
            if Str_ToInt(s40, 0) <> 0 then NPC.m_boNpcAutoChangeColor := True;
            NPC.m_dwNpcAutoChangeColorTime := Str_ToInt(s42, 0) * 1000;
            UserEngine.QuestNPCList.Add(NPC);
          end;
        end;
      end;
    end;//for
    LoadList.Free;
  end;
  Result := 1;
end;

function TFrmDB.LoadQuestDiary(): Integer;
  function sub_48978C(nIndex: Integer): string;
  begin
    if nIndex >= 1000 then begin
      Result := IntToStr(nIndex);
      Exit;
    end;
    if nIndex >= 100 then begin
      Result := IntToStr(nIndex) + '0';
      Exit;
    end;
    Result := IntToStr(nIndex) + '00';
  end;
var
  I, II: Integer;
  QDDinfoList: TList;
  QDDinfo: pTQDDinfo;
  s14, s18, s1C, s20: string;
  bo2D: Boolean;
  nC: Integer;
  LoadList: TStringList;
begin
  Result := 1;
  if QuestDiaryList.Count > 0 then begin//20080629
    for I := 0 to QuestDiaryList.Count - 1 do begin
      QDDinfoList := QuestDiaryList.Items[I];
      if QDDinfoList.Count > 0 then begin//20080629
        for II := 0 to QDDinfoList.Count - 1 do begin
          QDDinfo := QDDinfoList.Items[II];
          QDDinfo.sList.Free;
          Dispose(QDDinfo);
        end;
      end;
      QDDinfoList.Free;
    end;
    QuestDiaryList.Clear;
  end;
  bo2D := False;
  nC := 1;
  while (True) do begin
    QDDinfoList := nil;
    s14 := 'QuestDiary\' + sub_48978C(nC) + '.txt';
    if FileExists(s14) then begin
      s18 := '';
      QDDinfo := nil;
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(s14);
      for I := 0 to LoadList.Count - 1 do begin
        s1C := LoadList.Strings[I];
        if (s1C <> '') and (s1C[1] <> ';') then begin
          if (s1C[1] = '[') and (Length(s1C) > 2) then begin
            if s18 = '' then begin
              ArrestStringEx(s1C, '[', ']', s18);
              QDDinfoList := TList.Create;
              New(QDDinfo);
              QDDinfo.n00 := nC;
              QDDinfo.s04 := s18;
              QDDinfo.sList := TStringList.Create;
              QDDinfoList.Add(QDDinfo);
              bo2D := True;
            end else begin
              if s1C[1] <> '@' then begin
                s1C := GetValidStr3(s1C, s20, [' ', #9]);
                ArrestStringEx(s20, '[', ']', s20);
                New(QDDinfo);
                QDDinfo.n00 := Str_ToInt(s20, 0);
                QDDinfo.s04 := s1C;
                QDDinfo.sList := TStringList.Create;
                QDDinfoList.Add(QDDinfo);
                bo2D := True;
              end else bo2D := False;
            end;
          end else begin
            if bo2D then QDDinfo.sList.Add(s1C);
          end;
        end;
      end;//for
      LoadList.Free;
    end;
    if QDDinfoList <> nil then QuestDiaryList.Add(QDDinfoList)
    else QuestDiaryList.Add(nil);
    Inc(nC);
    if nC >= 105 then Break;
  end;
end;

function TFrmDB.LoadStartPoint(): Integer;
var
  sFileName, tStr, s18, s1C, s20, s22, s24, s26, s28, s30: string;
  LoadList: TStringList;
  I: Integer;
  StartPoint: pTStartPoint;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'StartPoint.txt';
  if FileExists(sFileName) then begin
    try
      g_StartPointList.Lock;
      g_StartPointList.Clear;
      LoadList := TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        tStr := Trim(LoadList.Strings[I]);
        if (tStr <> '') and (tStr[1] <> ';') then begin
          tStr := GetValidStr3(tStr, s18, [' ', #9]);
          tStr := GetValidStr3(tStr, s1C, [' ', #9]);
          tStr := GetValidStr3(tStr, s20, [' ', #9]);
          tStr := GetValidStr3(tStr, s22, [' ', #9]);
          tStr := GetValidStr3(tStr, s24, [' ', #9]);
          tStr := GetValidStr3(tStr, s26, [' ', #9]);
          tStr := GetValidStr3(tStr, s28, [' ', #9]);
          tStr := GetValidStr3(tStr, s30, [' ', #9]);
          if (s18 <> '') and (s1C <> '') and (s20 <> '') then begin
            New(StartPoint);
            StartPoint.m_sMapName := s18;
            StartPoint.m_nCurrX := Str_ToInt(s1C, 0);
            StartPoint.m_nCurrY := Str_ToInt(s20, 0);
            StartPoint.m_boNotAllowSay := Boolean(Str_ToInt(s22, 0));
            StartPoint.m_nRange := Str_ToInt(s24, 0);
            StartPoint.m_nType := Str_ToInt(s26, 0);
            StartPoint.m_nPkZone := Str_ToInt(s28, 0);
            StartPoint.m_nPkFire := Str_ToInt(s30, 0);
            g_StartPointList.AddObject(s18, TObject(StartPoint));
            //g_StartPointList.AddObject(s18, TObject(MakeLong(Str_ToInt(s1C, 0), Str_ToInt(s20, 0))));
            Result := 1;
          end;
        end;
      end;//for
      LoadList.Free;
    finally
      g_StartPointList.UnLock;
    end;
  end;
end;
//读取解包物品文件
function TFrmDB.LoadUnbindList(): Integer;
var
  sFileName, tStr, sData, s20: string;
  //tUnbind: pTUnbindInfo;
  LoadList: TStringList;
  I: Integer;
  n10: Integer;
begin
  Result := 0;
  sFileName := g_Config.sEnvirDir + 'UnbindList.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      tStr := LoadList.Strings[I];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        //New(tUnbind);
        tStr := GetValidStr3(tStr, sData, [' ', #9]);
        tStr := GetValidStrCap(tStr, s20, [' ', #9]);
        if (s20 <> '') and (s20[1] = '"') then
          ArrestStringEx(s20, '"', '"', s20);

        n10 := Str_ToInt(sData, 0);
        if n10 > 0 then g_UnbindList.AddObject(s20, TObject(n10))
        else begin
          Result := -I; //需要取负数
          Break;
        end;
      end;
    end;//for
    LoadList.Free;
  end;
end;

function TFrmDB.LoadNpcScript(NPC: TNormNpc; sPatch,
  sScritpName: string): Integer;
begin
  if sPatch = '' then sPatch := sNpc_def;
  Result := LoadScriptFile(NPC, sPatch, sScritpName, False);
end;
//读取脚本文件
function TFrmDB.LoadScriptFile(NPC: TNormNpc; sPatch, sScritpName: string;
  boFlag: Boolean): Integer;
var
  nQuestIdx, I, n1C, n20, n24, nItemType, nPriceRate: Integer;
  n6C, n70: Integer;
  sScritpFileName, s30, s34, s38, s3C, s40, s44, s48, s4C, s50: string;
  LoadList: TStringList;
  DefineList: TList;
  s54, s58, s5C, s74: string;
  DefineInfo: pTDefineInfo;
  bo8D: Boolean;
  Script: pTScript;
  SayingRecord: pTSayingRecord;
  SayingProcedure: pTSayingProcedure;
  QuestConditionInfo: pTQuestConditionInfo;
  QuestActionInfo: pTQuestActionInfo;
  Goods: pTGoods;
  function LoadCallScript(sFileName, sLabel: string; var List: TStringList): Boolean;
  var
    I: Integer;
    LoadStrList: TStringList;
    bo1D: Boolean;
    s18: string;
  begin
    Result := False;
    if FileExists(sFileName) then begin
      LoadStrList := TStringList.Create;
      LoadStrList.LoadFromFile(sFileName);
      DeCodeStringList(LoadStrList);
      sLabel := '[' + sLabel + ']';
      bo1D := False;
      if LoadStrList.Count > 0 then begin//20080629
        for I := 0 to LoadStrList.Count - 1 do begin
          s18 := Trim(LoadStrList.Strings[I]);
          if s18 <> '' then begin
            if not bo1D then begin
              if (s18[1] = '[') and (CompareText(s18, sLabel) = 0) then begin
                bo1D := True;
                List.Add(s18);
              end;
            end else begin
              if s18[1] <> '{' then begin
                if s18[1] = '}' then begin
                  //bo1D := False;//未使用 20080723
                  Result := True;
                  Break;
                end else begin
                  List.Add(s18);
                end;
              end;
            end;
          end; //00489CE4 if s18 <> '' then begin
        end; // for I := 0 to LoadStrList.Count - 1 do begin
      end;
      LoadStrList.Free;
    end;
  end;
(*  //读取远程脚本 20080706
  function LoadUrlCallScript(sFileName, sLabel: string; var List: TStringList): Boolean;
  var
    I: Integer;
    LoadStrList: TStringList;
    bo1D: Boolean;
    s18: string;
  begin
    Result := False;
    if pos('http://', sFileName) > 0 then begin
      try
        LoadStrList := TStringList.Create;
        try
          LoadStrList.Text := FrmMain.IdHTTP1.Get(sFileName);
          DeCodeStringList(LoadStrList);
          sLabel := '[' + sLabel + ']';
          bo1D := False;
          if LoadStrList.Count > 0 then begin
            for I := 0 to LoadStrList.Count - 1 do begin
              s18 := Trim(LoadStrList.Strings[I]);
              if s18 <> '' then begin
                if not bo1D then begin
                  if (s18[1] = '[') and (CompareText(s18, sLabel) = 0) then begin
                    bo1D := True;
                    List.Add(s18);
                  end;
                end else begin
                  if s18[1] <> '{' then begin
                    if s18[1] = '}' then begin
                      bo1D := False;
                      Result := True;
                      Break;
                    end else begin
                      List.Add(s18);
                    end;
                  end;
                end;
              end; //if s18 <> '' then begin
            end; // for I := 0 to LoadStrList.Count - 1 do begin
          end;
        finally
          LoadStrList.Free;
        end;
      except
      end;
    end;
  end;        *)

  procedure LoadScriptcall(var LoadList: TStringList);
  var
    I: Integer;
    s14, s18, s1C, s20, s34: string;
  begin
    for I := 0 to LoadList.Count - 1 do begin
      s14 := Trim(LoadList.Strings[I]);
      if (s14 <> '') and (s14[1] = '#') then begin
        if CompareLStr(s14, '#CALL', 5) then begin
          s14 := ArrestStringEx(s14, '[', ']', s1C);
          s20 := Trim(s1C);
          s18 := Trim(s14);
          if s20[1] = '\' then s20 := Copy(s20, 2, Length(s20) - 1);
          if s20[2] = '\' then s20 := Copy(s20, 3, Length(s20) - 2);
          s34 := g_Config.sEnvirDir + 'QuestDiary\' + s20;
          if LoadCallScript(s34, s18, LoadList) then begin
            LoadList.Strings[I] := '#ACT';
            LoadList.Insert(I + 1, 'goto ' + s18);
          end else begin
            MainOutMessage('脚本错误, 加载失败: ' + s20 +'  '+ s18);
          end;
        end;
       (* if CompareLStr(s14, '#URLCALL', 8) then begin//20080706 读取远程脚本
          s14 := ArrestStringEx(s14, '[', ']', s1C);
          s20 := Trim(s1C);//取得远程脚本HTTP
          s18 := Trim(s14);
          if LoadUrlCallScript(s20, s18, LoadList) then begin
            LoadList.Strings[I] := '#ACT';
            LoadList.Insert(I + 1, 'goto ' + s18);
          end else begin
            MainOutMessage('脚本错误, 加载失败: ' + s20 +'  '+ s18);
          end;
        end;   *)
      end;//if (s14 <> '') and (s14[1] = '#')
    end;//for
  end;

  function LoadDefineInfo(var LoadList: TStringList; var List: TList): string;
  var
    I: Integer;
    s14, s28, s1C, s20, s24: string;
    DefineInfo: pTDefineInfo;
    LoadStrList: TStringList;
  begin
    for I := 0 to LoadList.Count - 1 do begin
      s14 := Trim(LoadList.Strings[I]);
      if (s14 <> '') and (s14[1] = '#') then begin
        if CompareLStr(s14, '#SETHOME', 8{Length('#SETHOME')}) then begin
          Result := Trim(GetValidStr3(s14, s1C, [' ', #9]));
          LoadList.Strings[I] := '';
        end;
        if CompareLStr(s14, '#DEFINE', 7{Length('#DEFINE')}) then begin
          s14 := (GetValidStr3(s14, s1C, [' ', #9]));
          s14 := (GetValidStr3(s14, s20, [' ', #9]));
          s14 := (GetValidStr3(s14, s24, [' ', #9]));
          New(DefineInfo);
          DefineInfo.sName := UpperCase(s20);
          DefineInfo.sText := s24;
          List.Add(DefineInfo);
          LoadList.Strings[I] := '';
        end;
        if CompareLStr(s14, '#INCLUDE', 8{Length('#INCLUDE')}) then begin
          s28 := Trim(GetValidStr3(s14, s1C, [' ', #9]));
          s28 := g_Config.sEnvirDir + 'Defines\' + s28;
          if FileExists(s28) then begin
            LoadStrList := TStringList.Create;
            LoadStrList.LoadFromFile(s28);
            Result := LoadDefineInfo(LoadStrList, List);
            LoadStrList.Free;
          end else begin
            MainOutMessage('脚本错误, 加载失败: ' + s28);
          end;
          LoadList.Strings[I] := '';
        end;
      end;
    end;//for
  end;
  function MakeNewScript(): pTScript;
  var
    ScriptInfo: pTScript;
  begin
    New(ScriptInfo);
    ScriptInfo.boQuest := False;
    FillChar(ScriptInfo.QuestInfo, SizeOf(TQuestInfo) * 10, #0);
    nQuestIdx := 0;
    ScriptInfo.RecordList := TList.Create;
    NPC.m_ScriptList.Add(ScriptInfo);
    Result := ScriptInfo;
  end;
  function QuestCondition(sText: string; var QuestConditionInfo: pTQuestConditionInfo): Boolean; //00489DDC
  var
    sCmd, sParam1, sParam2, sParam3, sParam4, sParam5, sParam6, sParam7: string;
    nCMDCode: Integer;
  label L001;
  begin
    Result := False;
    sText := GetValidStrCap(sText, sCmd, [' ', #9]);
    sText := GetValidStrCap(sText, sParam1, [' ', #9]);
    sText := GetValidStrCap(sText, sParam2, [' ', #9]);
    sText := GetValidStrCap(sText, sParam3, [' ', #9]);
    sText := GetValidStrCap(sText, sParam4, [' ', #9]);
    sText := GetValidStrCap(sText, sParam5, [' ', #9]);
    sText := GetValidStrCap(sText, sParam6, [' ', #9]);
    sText := GetValidStrCap(sText, sParam7, [' ', #9]);
    sCmd := UpperCase(sCmd);
    nCMDCode := 0;
    if sCmd = sCHECK then begin
      nCMDCode := nCHECK;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
      goto L001;
    end;
    if sCmd = sCHECKOPEN then begin
      nCMDCode := nCHECKOPEN;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
      goto L001;
    end;   
    if sCmd = sCHECKUNIT then begin
      nCMDCode := nCHECKUNIT;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
      goto L001;
    end; 
    if sCmd = sCHECKPKPOINT then begin
      nCMDCode := nCHECKPKPOINT;
      goto L001;
    end;
    if sCmd = sCHECKGOLD then begin
      nCMDCode := nCHECKGOLD;
      goto L001;
    end;
    if sCmd = sCHECKLEVEL then begin
      nCMDCode := nCHECKLEVEL;
      goto L001;
    end;
    if sCmd = sCHECKJOB then begin
      nCMDCode := nCHECKJOB;
      goto L001;
    end;
    if sCmd = sRANDOM then begin
      nCMDCode := nRANDOM;
      goto L001;
    end;
    if sCmd = sCHECKITEM then begin
      nCMDCode := nCHECKITEM;
      goto L001;
    end;
    if sCmd = sGENDER then begin
      nCMDCode := nGENDER;
      goto L001;
    end;
    if sCmd = sCHECKBAGGAGE then begin
      nCMDCode := nCHECKBAGGAGE;
      goto L001;
    end;

    if sCmd = sCHECKNAMELIST then begin
      nCMDCode := nCHECKNAMELIST;
      goto L001;
    end;
    if sCmd = sSC_HASGUILD then begin
      nCMDCode := nSC_HASGUILD;
      goto L001;
    end;

    if sCmd = sSC_ISGUILDMASTER then begin
      nCMDCode := nSC_ISGUILDMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEMASTER then begin
      nCMDCode := nSC_CHECKCASTLEMASTER;
      goto L001;
    end;
    if sCmd = sSC_ISNEWHUMAN then begin
      nCMDCode := nSC_ISNEWHUMAN;
      goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERTYPE then begin
      nCMDCode := nSC_CHECKMEMBERTYPE;
      goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERLEVEL then begin
      nCMDCode := nSC_CHECKMEMBERLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGOLD then begin
      nCMDCode := nSC_CHECKGAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEDIAMOND then begin //检查金刚石数量 20071227
      nCMDCode := nSC_CHECKGAMEDIAMOND;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGIRD then begin //检查灵符数量 20071227
      nCMDCode := nSC_CHECKGAMEGIRD;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGLORY then begin //检查荣誉值 20080511
      nCMDCode := nSC_CHECKGAMEGLORY;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKSKILLLEVEL then begin //检查技能等级 20080512
      nCMDCode := nSC_CHECKSKILLLEVEL;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKMAPMOBCOUNT then begin //检查地图指定坐标指定名称怪物数量 20080123
      nCMDCode := nSC_CHECKMAPMOBCOUNT;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKSIDESLAVENAME then begin //检查人物周围自己宝宝数量 20080425
      nCMDCode := nSC_CHECKSIDESLAVENAME;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKLISTTEXT then begin //检查文件是否包含指定文本 20080427
      nCMDCode := nSC_CHECKLISTTEXT;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKCURRENTDATE then begin //检测当前日期是否小于大于等于指定的日期 20080416
      nCMDCode := nSC_CHECKCURRENTDATE;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKMASTERONLINE then begin //检测师傅（或徒弟）是否在线 20080416
      nCMDCode := nSC_CHECKMASTERONLINE;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKDEARONLINE then begin //检测夫妻一方是否在线 20080416
      nCMDCode := nSC_CHECKDEARONLINE;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKMASTERONMAP then begin //检测师傅(或徒弟)是否在指定的地图上 20080416
      nCMDCode := nSC_CHECKMASTERONMAP;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKDEARONMAP then begin //检测夫妻一方是否在指定的地图上 20080416
      nCMDCode := nSC_CHECKDEARONMAP;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKPOSEISPRENTICE then begin //检测对面是否为自己的徒弟 20080416
      nCMDCode := nSC_CHECKPOSEISPRENTICE;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKCASTLEWAR then begin //检查是否在攻城期间 20080422
      nCMDCode := nSC_CHECKCASTLEWAR;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_FINDMAPPATH then begin //设置地图的起终XY值 20080124
      nCMDCode := nSC_FINDMAPPATH;
      goto L001;
    end;
//--------------------------------------------------------------------------
    if sCmd = sSC_CHECKHEROLOYAL then begin //检测英雄的忠诚度 20080109
      nCMDCode := nSC_CHECKHEROLOYAL;
      goto L001;
    end;
//--------------------------------------------------------------------------
    if sCmd = sISONMAKEWINE then begin//判断是否在酿哪种酒 20080620
      nCMDCode := nISONMAKEWINE;
      goto L001;
    end;
//--------------------------------------------------------------------------
    if sCmd = sCHECKGUILDFOUNTAIN  then begin//判断是否开启行会泉水仓库 20080624
      nCMDCode := nCHECKGUILDFOUNTAIN;
      goto L001;
    end;
//--------------------------------------------------------------------------
    if sCmd = sSC_CHECKGAMEPOINT then begin
      nCMDCode := nSC_CHECKGAMEPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMELISTPOSITION then begin
      nCMDCode := nSC_CHECKNAMELISTPOSITION;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDLIST then begin
      nCMDCode := nSC_CHECKGUILDLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKRENEWLEVEL then begin
      nCMDCode := nSC_CHECKRENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVELEVEL then begin
      nCMDCode := nSC_CHECKSLAVELEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVENAME then begin
      nCMDCode := nSC_CHECKSLAVENAME;
      goto L001;
    end;
    if sCmd = sSC_CHECKCREDITPOINT then begin
      nCMDCode := nSC_CHECKCREDITPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKOFGUILD then begin
      nCMDCode := nSC_CHECKOFGUILD;
      goto L001;
    end;
    if sCmd = sSC_CHECKPAYMENT then begin
      nCMDCode := nSC_CHECKPAYMENT;
      goto L001;
    end;
    if sCmd = sSC_CHECKUSEITEM then begin
      nCMDCode := nSC_CHECKUSEITEM;
      goto L001;
    end;
    if sCmd = sSC_CHECKBAGSIZE then begin
      nCMDCode := nSC_CHECKBAGSIZE;
      goto L001;
    end;
    if sCmd = sSC_CHECKDC then begin
      nCMDCode := nSC_CHECKDC;
      goto L001;
    end;
    if sCmd = sSC_CHECKMC then begin
      nCMDCode := nSC_CHECKMC;
      goto L001;
    end;
    if sCmd = sSC_CHECKSC then begin
      nCMDCode := nSC_CHECKSC;
      goto L001;
    end;
    if sCmd = sSC_CHECKHP then begin
      nCMDCode := nSC_CHECKHP;
      goto L001;
    end;
    if sCmd = sSC_CHECKMP then begin
      nCMDCode := nSC_CHECKMP;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMTYPE then begin
      nCMDCode := nSC_CHECKITEMTYPE;
      goto L001;
    end;
    if sCmd = sSC_CHECKEXP then begin
      nCMDCode := nSC_CHECKEXP;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEGOLD then begin
      nCMDCode := nSC_CHECKCASTLEGOLD;
      goto L001;
    end;
    if sCmd = sSC_PASSWORDERRORCOUNT then begin
      nCMDCode := nSC_PASSWORDERRORCOUNT;
      goto L001;
    end;
    if sCmd = sSC_ISLOCKPASSWORD then begin
      nCMDCode := nSC_ISLOCKPASSWORD;
      goto L001;
    end;
    if sCmd = sSC_ISLOCKSTORAGE then begin
      nCMDCode := nSC_ISLOCKSTORAGE;
      goto L001;
    end;
    if sCmd = sSC_CHECKBUILDPOINT then begin
      nCMDCode := nSC_CHECKBUILDPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKAURAEPOINT then begin
      nCMDCode := nSC_CHECKAURAEPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKSTABILITYPOINT then begin
      nCMDCode := nSC_CHECKSTABILITYPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKFLOURISHPOINT then begin
      nCMDCode := nSC_CHECKFLOURISHPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKCONTRIBUTION then begin
      nCMDCode := nSC_CHECKCONTRIBUTION;
      goto L001;
    end;
    if sCmd = sSC_CHECKRANGEMONCOUNT then begin
      nCMDCode := nSC_CHECKRANGEMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_ISONMAP then begin//检测地图命令  20080426
      nCMDCode := nSC_ISONMAP;
      goto L001;
    end;
    if sCmd = sSC_CHECKITEMADDVALUE then begin
      nCMDCode := nSC_CHECKITEMADDVALUE;
      goto L001;
    end;
    if sCmd = sSC_CHECKINMAPRANGE then begin
      nCMDCode := nSC_CHECKINMAPRANGE;
      goto L001;
    end;
    if sCmd = sSC_CASTLECHANGEDAY then begin
      nCMDCode := nSC_CASTLECHANGEDAY;
      goto L001;
    end;
    if sCmd = sSC_CASTLEWARDAY then begin
      nCMDCode := nSC_CASTLEWARDAY;
      goto L001;
    end;
    if sCmd = sSC_ONLINELONGMIN then begin
      nCMDCode := nSC_ONLINELONGMIN;
      goto L001;
    end;
    if sCmd = sSC_CHECKGUILDCHIEFITEMCOUNT then begin
      nCMDCode := nSC_CHECKGUILDCHIEFITEMCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMEDATELIST then begin
      nCMDCode := nSC_CHECKNAMEDATELIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAPHUMANCOUNT then begin
      nCMDCode := nSC_CHECKMAPHUMANCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMAPMONCOUNT then begin
      nCMDCode := nSC_CHECKMAPMONCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKVAR then begin
      nCMDCode := nSC_CHECKVAR;
      goto L001;
    end;
    if sCmd = sSC_CHECKSERVERNAME then begin
      nCMDCode := nSC_CHECKSERVERNAME;
      goto L001;
    end;
    if sCmd = sSC_ISATTACKGUILD then begin
      nCMDCode := nSC_ISATTACKGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISDEFENSEGUILD then begin
      nCMDCode := nSC_ISDEFENSEGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISATTACKALLYGUILD then begin
      nCMDCode := nSC_ISATTACKALLYGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISDEFENSEALLYGUILD then begin
      nCMDCode := nSC_ISDEFENSEALLYGUILD;
      goto L001;
    end;
    if sCmd = sSC_ISCASTLEGUILD then begin
      nCMDCode := nSC_ISCASTLEGUILD;
      goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEDOOR then begin
      nCMDCode := nSC_CHECKCASTLEDOOR;
      goto L001;
    end;
    if sCmd = sSC_ISSYSOP then begin
      nCMDCode := nSC_ISSYSOP;
      goto L001;
    end;
    if sCmd = sSC_ISADMIN then begin
      nCMDCode := nSC_ISADMIN;
      goto L001;
    end;
    if sCmd = sSC_CHECKGROUPCOUNT then begin
      nCMDCode := nSC_CHECKGROUPCOUNT;
      goto L001;
    end;
    if sCmd = sCHECKACCOUNTLIST then begin
      nCMDCode := nCHECKACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sCHECKIPLIST then begin
      nCMDCode := nCHECKIPLIST;
      goto L001;
    end;
    if sCmd = sCHECKBBCOUNT then begin
      nCMDCode := nCHECKBBCOUNT;
      goto L001;
    end;
    if sCmd = sDAYTIME then begin
      nCMDCode := nDAYTIME;
      goto L001;
    end;
    if sCmd = sCHECKITEMW then begin
      nCMDCode := nCHECKITEMW;
      goto L001;
    end;
    if sCmd = sISTAKEITEM then begin
      nCMDCode := nISTAKEITEM;
      goto L001;
    end;
    if sCmd = sCHECKDURA then begin
      nCMDCode := nCHECKDURA;
      goto L001;
    end;
    if sCmd = sCHECKDURAEVA then begin
      nCMDCode := nCHECKDURAEVA;
      goto L001;
    end;
    if sCmd = sDAYOFWEEK then begin
      nCMDCode := nDAYOFWEEK;
      goto L001;
    end;
    if sCmd = sHOUR then begin
      nCMDCode := nHOUR;
      goto L001;
    end;
    if sCmd = sMIN then begin
      nCMDCode := nMIN;
      goto L001;
    end;
    if sCmd = sCHECKLUCKYPOINT then begin
      nCMDCode := nCHECKLUCKYPOINT;
      goto L001;
    end;
    if sCmd = sCHECKMONMAP then begin
      nCMDCode := nCHECKMONMAP;
      goto L001;
    end;
    if sCmd = sCHECKHUM then begin
      nCMDCode := nCHECKHUM;
      goto L001;
    end;
    if sCmd = sEQUAL then begin
      nCMDCode := nEQUAL;
      goto L001;
    end;
    if sCmd = sLARGE then begin
      nCMDCode := nLARGE;
      goto L001;
    end;
    if sCmd = sSMALL then begin
      nCMDCode := nSMALL;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEDIR then begin
      nCMDCode := nSC_CHECKPOSEDIR;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSELEVEL then begin
      nCMDCode := nSC_CHECKPOSELEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEGENDER then begin
      nCMDCode := nSC_CHECKPOSEGENDER;
      goto L001;
    end;
    if sCmd = sSC_CHECKLEVELEX then begin
      nCMDCode := nSC_CHECKLEVELEX;
      goto L001;
    end;
    if sCmd = sSC_CHECKBONUSPOINT then begin
      nCMDCode := nSC_CHECKBONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMARRY then begin
      nCMDCode := nSC_CHECKMARRY;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMARRY then begin
      nCMDCode := nSC_CHECKPOSEMARRY;
      goto L001;
    end;
    if sCmd = sSC_CHECKMARRYCOUNT then begin
      nCMDCode := nSC_CHECKMARRYCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKMASTER then begin
      nCMDCode := nSC_CHECKMASTER;
      goto L001;
    end;
    if sCmd = sSC_HAVEMASTER then begin
      nCMDCode := nSC_HAVEMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMASTER then begin
      nCMDCode := nSC_CHECKPOSEMASTER;
      goto L001;
    end;
    if sCmd = sSC_POSEHAVEMASTER then begin
      nCMDCode := nSC_POSEHAVEMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKISMASTER then begin
      nCMDCode := nSC_CHECKISMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKPOSEISMASTER then begin
      nCMDCode := nSC_CHECKPOSEISMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKNAMEIPLIST then begin
      nCMDCode := nSC_CHECKNAMEIPLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKACCOUNTIPLIST then begin
      nCMDCode := nSC_CHECKACCOUNTIPLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKSLAVECOUNT then begin
      nCMDCode := nSC_CHECKSLAVECOUNT;
      goto L001;
    end;
    if sCmd = sCHECKMAPNAME then begin
      nCMDCode := nCHECKMAPNAME;
      goto L001;
    end;
    if sCmd = sINSAFEZONE then begin
      nCMDCode := nINSAFEZONE;
      goto L001;
    end;
    if sCmd = sCHECKSKILL then begin
      nCMDCode := nCHECKSKILL;
      goto L001;
    end;
    if sCmd = sHEROCHECKSKILL then begin //检查英雄技能 20080423
      nCMDCode := nHEROCHECKSKILL;
      goto L001;
    end;
    if sCmd = sSC_CHECKUSERDATE then begin
      nCMDCode := nSC_CHECKUSERDATE;
      goto L001;
    end;
    if sCmd = sSC_CHECKCONTAINSTEXT then begin
      nCMDCode := nSC_CHECKCONTAINSTEXT;
      goto L001;
    end;
    if sCmd = sSC_COMPARETEXT then begin
      nCMDCode := nSC_COMPARETEXT;
      goto L001;
    end;
    if sCmd = sSC_CHECKTEXTLIST then begin
      nCMDCode := nSC_CHECKTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_CHECKCONTAINSTEXTLIST then begin
      nCMDCode := nSC_CHECKCONTAINSTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_ISGROUPMASTER then begin
      nCMDCode := nSC_ISGROUPMASTER;
      goto L001;
    end;
    if sCmd = sSC_CHECKONLINE then begin
      nCMDCode := nSC_CHECKONLINE;
      goto L001;
    end;
    if sCmd = sSC_ISDUPMODE then begin
      nCMDCode := nSC_ISDUPMODE;
      goto L001;
    end;
    if sCmd = sSC_ISOFFLINEMODE then begin
      nCMDCode := nSC_ISOFFLINEMODE;
      goto L001;
    end;
    if sCmd = sSC_CHECKSTATIONTIME then begin
      nCMDCode := nSC_CHECKSTATIONTIME;
      goto L001;
    end;
    if sCmd = sSC_CHECKSIGNMAP then begin
      nCMDCode := nSC_CHECKSIGNMAP;
      goto L001;
    end;
    if sCmd = sSC_HAVEHERO then begin
      nCMDCode := nSC_HAVEHERO;
      goto L001;
    end;
    if sCmd = sSC_CHECKHEROONLINE then begin
      nCMDCode := nSC_CHECKHEROONLINE;
      goto L001;
    end;
    if sCmd = sSC_CHECKHEROLEVEL then begin
      nCMDCode := nSC_CHECKHEROLEVEL;
      goto L001;
    end;

    if sCmd = sSC_CHECKMINE then begin //检测矿纯度  20080324
      nCMDCode := nSC_CHECKMINE;
      goto L001;
    end;

    if sCmd = sSC_CHECKMAKEWINE then begin //检测酒的品质 20080806
      nCMDCode := nSC_CHECKMAKEWINE;
      goto L001;
    end;

    if sCmd = sSC_CHECKITEMLEVEL then begin //检查装备升级次数 20080816
      nCMDCode := nSC_CHECKITEMLEVEL;
      goto L001;
    end;
//------------------------插件命令-----------------------------------
    if sCmd = sSC_CHECKONLINEPLAYCOUNT then begin //20080807
      nCMDCode := nSC_CHECKONLINEPLAYCOUNT;
      goto L001;
    end;
    if sCmd = sSC_CHECKPLAYDIELVL then begin //20080807
      nCMDCode := nSC_CHECKPLAYDIELVL;
      goto L001;
    end;
    if sCmd = sSC_CHECKPLAYDIEJOB then begin //20080807
      nCMDCode := nSC_CHECKPLAYDIEJOB;
      goto L001;
    end;
    if sCmd = sSC_CHECKPLAYDIESEX then begin //20080807
      nCMDCode := nSC_CHECKPLAYDIESEX;
      goto L001;
    end;
    if sCmd = sSC_CHECKKILLPLAYLVL then begin //20080807
      nCMDCode := nSC_CHECKKILLPLAYLVL;
      goto L001;
    end;
    if sCmd = sSC_CHECKKILLPLAYJOB then begin //20080807
      nCMDCode := nSC_CHECKKILLPLAYJOB;
      goto L001;
    end;
    if sCmd = sSC_CHECKKILLPLAYSEX then begin //20080807
      nCMDCode := nSC_CHECKKILLPLAYSEX;
      goto L001;
    end;
//------------------------------------------------------------------
    if sCmd = sSC_CHECKHEROPKPOINT then begin //检测英雄PK值  20080304
      nCMDCode := nSC_CHECKHEROPKPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKCODELIST then begin //检测文件里的编码  20080410
      nCMDCode := nSC_CHECKCODELIST;
      goto L001;
    end;
    if sCmd = sCHECKITEMSTATE then begin //检查装备绑定状态 20080312
      nCMDCode := nCHECKITEMSTATE;
      goto L001;
    end;
    if sCmd = sCHECKITEMSNAME then begin //检查指定装备位置物品名称 20080825
      nCMDCode := nCHECKITEMSNAME;
      goto L001;
    end;
    if sCmd = sCHECKGUILDFOUNTAINVALUE then begin//检测行会酒泉数 20081017
      nCMDCode := nCHECKGUILDFOUNTAINVALUE;
      goto L001;
    end;
    if sCmd = sCHECKNGLEVEL then begin//检查角色内功等级 20081223
      nCMDCode := nCHECKNGLEVEL;
      goto L001;
    end;
    if sCmd = sKILLBYHUM then begin //检测是否被人物所杀 20080826
      nCMDCode := nKILLBYHUM;
      goto L001;
    end;
    if sCmd = sISHIGH then begin //检测服务器最高属性人物命令 20080313
      nCMDCode := nISHIGH;
      goto L001;
    end;
    if sCmd = sSC_CHECKHEROJOB then begin
      nCMDCode := nSC_CHECKHEROJOB;
      goto L001;
    end;
    if sCmd = sSC_CHANGREADNG then begin//检查角色是否学过内功 20081002
      nCMDCode := nSC_CHANGREADNG;
      goto L001;
    end;
   { if nCMDCode <= 0 then begin //20080813 注释
      if Assigned(zPlugOfEngine.QuestConditionScriptCmd) then begin
        nCMDCode := zPlugOfEngine.QuestConditionScriptCmd(PChar(sCmd));
        goto L001;
      end;
    end; }

    L001:
    if nCMDCode > 0 then begin
      QuestConditionInfo.nCMDCode := nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then begin
        ArrestStringEx(sParam1, '"', '"', sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then begin
        ArrestStringEx(sParam2, '"', '"', sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then begin
        ArrestStringEx(sParam3, '"', '"', sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then begin
        ArrestStringEx(sParam4, '"', '"', sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then begin
        ArrestStringEx(sParam5, '"', '"', sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then begin
        ArrestStringEx(sParam6, '"', '"', sParam6);
      end;
      if (sParam7 <> '') and (sParam7[1] = '"') then begin
        ArrestStringEx(sParam7, '"', '"', sParam7);
      end;
      QuestConditionInfo.sParam1 := sParam1;
      QuestConditionInfo.sParam2 := sParam2;
      QuestConditionInfo.sParam3 := sParam3;
      QuestConditionInfo.sParam4 := sParam4;
      QuestConditionInfo.sParam5 := sParam5;
      QuestConditionInfo.sParam6 := sParam6;
      QuestConditionInfo.sParam7 := sParam7;
      if IsStringNumber(sParam1) then
        QuestConditionInfo.nParam1 := Str_ToInt(sParam1, 0);
      if IsStringNumber(sParam2) then
        QuestConditionInfo.nParam2 := Str_ToInt(sParam2, 0);
      if IsStringNumber(sParam3) then
        QuestConditionInfo.nParam3 := Str_ToInt(sParam3, 0);
      if IsStringNumber(sParam4) then
        QuestConditionInfo.nParam4 := Str_ToInt(sParam4, 0);
      if IsStringNumber(sParam5) then
        QuestConditionInfo.nParam5 := Str_ToInt(sParam5, 0);
      if IsStringNumber(sParam6) then
        QuestConditionInfo.nParam6 := Str_ToInt(sParam6, 0);
      if IsStringNumber(sParam7) then
        QuestConditionInfo.nParam7 := Str_ToInt(sParam7, 0);
      Result := True;
    end;
  end;

  function QuestAction(sText: string; var QuestActionInfo: pTQuestActionInfo): Boolean;
  var
    sCmd, sParam1, sParam2, sParam3, sParam4, sParam5, sParam6 ,sParam7: string;
    nCMDCode: Integer;
  label L001;
  begin
    Result := False;
    sText := GetValidStrCap(sText, sCmd, [' ', #9]);
    sText := GetValidStrCap(sText, sParam1, [' ', #9]);
    sText := GetValidStrCap(sText, sParam2, [' ', #9]);
    sText := GetValidStrCap(sText, sParam3, [' ', #9]);
    sText := GetValidStrCap(sText, sParam4, [' ', #9]);
    sText := GetValidStrCap(sText, sParam5, [' ', #9]);
    sText := GetValidStrCap(sText, sParam6, [' ', #9]);
    sText := GetValidStrCap(sText, sParam7, [' ', #9]);
    sCmd := UpperCase(sCmd);
    nCMDCode := 0;
    if sCmd = sSET then begin
      nCMDCode := nSET;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
    end;

    if sCmd = sRESET then begin
      nCMDCode := nRESET;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
    end;
    if sCmd = sSETOPEN then begin
      nCMDCode := nSETOPEN;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
    end;
    if sCmd = sSETUNIT then begin
      nCMDCode := nSETUNIT;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
    end;
    if sCmd = sRESETUNIT then begin
      nCMDCode := nRESETUNIT;
      ArrestStringEx(sParam1, '[', ']', sParam1);
      if not IsStringNumber(sParam1) then nCMDCode := 0;
      if not IsStringNumber(sParam2) then nCMDCode := 0;
    end; 
    if sCmd = sTAKE then begin
      nCMDCode := nTAKE;
      goto L001;
    end;
    if sCmd = sSC_GIVE then begin
      nCMDCode := nSC_GIVE;
      goto L001;
    end;
    if sCmd = sCLOSE then begin
      nCMDCode := nCLOSE;
      goto L001;
    end;
    if sCmd = sBREAK then begin
      nCMDCode := nBREAK;
      goto L001;
    end;
    if sCmd = sGOTO then begin
      nCMDCode := nGOTO;
      goto L001;
    end;
    if sCmd = sADDNAMELIST then begin
      nCMDCode := nADDNAMELIST;
      goto L001;
    end;
    if sCmd = sDELNAMELIST then begin
      nCMDCode := nDELNAMELIST;
      goto L001;
    end;
    if sCmd = sADDGUILDLIST then begin
      nCMDCode := nADDGUILDLIST;
      goto L001;
    end;
    if sCmd = sDELGUILDLIST then begin
      nCMDCode := nDELGUILDLIST;
      goto L001;
    end;
    if sCmd = sADDACCOUNTLIST then begin
      nCMDCode := nADDACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sDELACCOUNTLIST then begin
      nCMDCode := nDELACCOUNTLIST;
      goto L001;
    end;
    if sCmd = sADDIPLIST then begin
      nCMDCode := nADDIPLIST;
      goto L001;
    end;
    if sCmd = sDELIPLIST then begin
      nCMDCode := nDELIPLIST;
      goto L001;
    end;
    if sCmd = sSENDMSG then begin
      nCMDCode := nSENDMSG;
      goto L001;
    end;
    if sCmd = sCREATEFILE then begin//创建文本文件 20081226
      nCMDCode := nCREATEFILE;
      goto L001;
    end;
    if sCmd = sSENDTOPMSG then begin //顶端滚动公告
      nCMDCode := nSENDTOPMSG;
      goto L001;
    end;
    if sCmd = sSENDCENTERMSG then begin //屏幕居中显示公告
      nCMDCode := nSENDCENTERMSG;
      goto L001;
    end;
    if sCmd = sSENDEDITTOPMSG then begin //聊天框顶端公告
      nCMDCode := nSENDEDITTOPMSG;
      goto L001;
    end;
    if sCmd = sOPENBOOKS then begin //卧龙命令 20080119
      nCMDCode := nOPENBOOKS;
      goto L001;
    end;
    if sCmd = sOPENYBDEAL then begin //开通元宝交易 20080316
      nCMDCode := nOPENYBDEAL;
      goto L001;
    end;
    if sCmd = sQUERYYBSELL then begin //查询正在元宝寄售出售的物品20080317
      nCMDCode := nQUERYYBSELL;
      goto L001;
    end;
    if sCmd = sQUERYYBDEAL then begin //查询可以的购买物品 20080317
      nCMDCode := nQUERYYBDEAL;
      goto L001;
    end;
    if sCmd = sTHROUGHHUM then begin //改变穿人模式 20080221
      nCMDCode := nTHROUGHHUM;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sSetOnTimer then begin//个人定时器(启动) 20080510
      nCMDCode := nSetOnTimer;
      goto L001;
    end;
    if sCmd = sSetOffTimer then begin//停止定时器 20080510
      nCMDCode := nSetOffTimer;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sGETSORTNAME then begin//取指定排行榜指定排名的玩家名字 20080531
      nCMDCode := nGETSORTNAME;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sWEBBROWSER then begin//连接指定网站网址 20080602
      nCMDCode := nWEBBROWSER;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sADDATTACKSABUKALL then begin//设置所有行会攻城 20080609
      nCMDCode := nADDATTACKSABUKALL;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sKICKALLPLAY then begin//踢除服务器所有人物 20080609
      nCMDCode := nKICKALLPLAY;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sREPAIRALL then begin//修理全身装备 20080613
      nCMDCode := nREPAIRALL;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sAUTOGOTOXY then begin//自动寻路 20080617
      nCMDCode := nAUTOGOTOXY;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sCHANGESKILL then begin//修改魔法ID 20080624
      nCMDCode := nCHANGESKILL;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sOPENMAKEWINE then begin//打开酿酒窗口 20080619
      nCMDCode := nOPENMAKEWINE;
      goto L001;
    end;
    if sCmd = sGETGOODMAKEWINE then begin//取回酿好的酒 20080620
      nCMDCode := nGETGOODMAKEWINE;
      goto L001;
    end;
    if sCmd = sDECMAKEWINETIME then begin//减少酿酒的时间 20080620
      nCMDCode := nDECMAKEWINETIME;
      goto L001;
    end;
    if sCmd = sREADSKILLNG then begin//学习内功 20081002
      nCMDCode := nREADSKILLNG;
      goto L001;
    end;
    if sCmd = sMAKEWINENPCMOVE then begin//酿酒NPC的走动 20080621
      nCMDCode := nMAKEWINENPCMOVE;
      goto L001;
    end;
    if sCmd = sFOUNTAIN then begin//设置泉水喷发 20080624
      nCMDCode := nFOUNTAIN;
      goto L001;
    end;
    if sCmd = sSETGUILDFOUNTAIN then begin//开启/关闭行会泉水仓库 20080625
      nCMDCode := nSETGUILDFOUNTAIN;
      goto L001;
    end;
    if sCmd = sGIVEGUILDFOUNTAIN then begin//领取行会酒水 20080625
      nCMDCode := nGIVEGUILDFOUNTAIN;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sCHALLENGMAPMOVE then begin//挑战地图移动 20080705
      nCMDCode := nCHALLENGMAPMOVE;
      goto L001;
    end;
    if sCmd = sGETCHALLENGEBAKITEM then begin//没有挑战地图可移动,则退回抵押的物品 20080705
      nCMDCode := nGETCHALLENGEBAKITEM;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sHEROLOGOUT then begin//英雄下线 20080716
      nCMDCode := nHEROLOGOUT;
      goto L001;
    end;
    if sCmd = sSETITEMSLIGHT then begin //装备发光设置 20080223
      nCMDCode := nSETITEMSLIGHT;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sQUERYREFINEITEM then begin //打开粹练窗口 20080503
      nCMDCode := nQUERYREFINEITEM;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sGOHOME then begin //移动到回城点 20080503
      nCMDCode := nGOHOME;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sTHROWITEM then begin //将指定物品刷新到指定地图坐标范围内 20080508
      nCMDCode := nTHROWITEM;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sOpenDragonBox then begin //打开粹练窗口 20080502
      nCMDCode := nOpenDragonBox;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sCLEARCODELIST then begin //删除指定文本里的编码 20080410
      nCMDCode := nCLEARCODELIST;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sGetRandomName then begin //随机取文件名称 20080126
      nCMDCode := nGetRandomName;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sHCall then begin //通过脚本命令让别人执行QManage.txt中的脚本 20080422
      nCMDCode := nHCall;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sINCASTLEWARAY then begin //检测人物是否在攻城期间的范围内，在则BB叛变 20080422
      nCMDCode := nINCASTLEWARAY;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sGIVESTATEITEM then begin //给予带绑定状态装备 20080312
      nCMDCode := nGIVESTATEITEM;
      goto L001;
    end;
    if sCmd = sSETITEMSTATE then begin //设置装备绑定状态 20080312
      nCMDCode := nSETITEMSTATE;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sCHANGEMODE then begin
      nCMDCode := nCHANGEMODE;
      goto L001;
    end;
    if sCmd = sPKPOINT then begin
      nCMDCode := nPKPOINT;
      goto L001;
    end;
    if sCmd = sSC_RECALLMOB then begin
      nCMDCode := nSC_RECALLMOB;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sSC_RECALLMOBEX then begin //新增召出的宝宝命令 20080122
      nCMDCode := nSC_RECALLMOBEX;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sSC_MOVEMOBTO then begin //将指定坐标的怪物移动到新坐标 20080123
      nCMDCode := nSC_MOVEMOBTO;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sSC_CLEARITEMMAP then begin //清除地图物品 20080124
      nCMDCode := nSC_CLEARITEMMAP;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sKICK then begin
      nCMDCode := nKICK;
      goto L001;
    end;
    if sCmd = sTAKEW then begin
      nCMDCode := nTAKEW;
      goto L001;
    end;
    if sCmd = sTIMERECALL then begin
      nCMDCode := nTIMERECALL;
      goto L001;
    end;
    if sCmd = sSC_PARAM1 then begin
      nCMDCode := nSC_PARAM1;
      goto L001;
    end;
    if sCmd = sSC_PARAM2 then begin
      nCMDCode := nSC_PARAM2;
      goto L001;
    end;
    if sCmd = sSC_PARAM3 then begin
      nCMDCode := nSC_PARAM3;
      goto L001;
    end;
    if sCmd = sSC_PARAM4 then begin
      nCMDCode := nSC_PARAM4;
      goto L001;
    end;
    if sCmd = sSC_EXEACTION then begin
      nCMDCode := nSC_EXEACTION;
      goto L001;
    end;
    if sCmd = sMAPMOVE then begin
      nCMDCode := nMAPMOVE;
      goto L001;
    end;
    if sCmd = sMAP then begin
      nCMDCode := nMAP;
      goto L001;
    end;
    if sCmd = sTAKECHECKITEM then begin
      nCMDCode := nTAKECHECKITEM;
      goto L001;
    end;
    if sCmd = sMONGEN then begin
      nCMDCode := nMONGEN;
      goto L001;
    end;
    if sCmd = sMONCLEAR then begin
      nCMDCode := nMONCLEAR;
      goto L001;
    end;
    if sCmd = sMOV then begin
      nCMDCode := nMOV;
      goto L001;
    end;
    if sCmd = sINC then begin
      nCMDCode := nINC;
      goto L001;
    end;
    if sCmd = sDEC then begin
      nCMDCode := nDEC;
      goto L001;
    end;
    if sCmd = sSUM then begin
      nCMDCode := nSUM;
      goto L001;
    end;
//-------------------------------------------------------
//20080220 变量运算
    if sCmd = sSC_DIV then begin //除法
      nCMDCode := nSC_DIV;
      goto L001;
    end;
    if sCmd = sSC_MUL then begin //乘法
      nCMDCode := nSC_MUL;
      goto L001;
    end;
    if sCmd = sSC_PERCENT then begin //百分比
      nCMDCode := nSC_PERCENT;
      goto L001;
    end;
//--------------------------------------------------------    
    if sCmd = sBREAKTIMERECALL then begin
      nCMDCode := nBREAKTIMERECALL;
      goto L001;
    end;
    if sCmd = sMOVR then begin
      nCMDCode := nMOVR;
      goto L001;
    end;
    if sCmd = sEXCHANGEMAP then begin
      nCMDCode := nEXCHANGEMAP;
      goto L001;
    end;
    if sCmd = sRECALLMAP then begin
      nCMDCode := nRECALLMAP;
      goto L001;
    end;
    if sCmd = sADDBATCH then begin
      nCMDCode := nADDBATCH;
      goto L001;
    end;
    if sCmd = sBATCHDELAY then begin
      nCMDCode := nBATCHDELAY;
      goto L001;
    end;
    if sCmd = sBATCHMOVE then begin
      nCMDCode := nBATCHMOVE;
      goto L001;
    end;
    if sCmd = sPLAYDICE then begin
      nCMDCode := nPLAYDICE;
      goto L001;
    end;
    if sCmd = sGOQUEST then begin
      nCMDCode := nGOQUEST;
      goto L001;
    end;
    if sCmd = sENDQUEST then begin
      nCMDCode := nENDQUEST;
      goto L001;
    end;
    if sCmd = sSC_HAIRSTYLE then begin
      nCMDCode := nSC_HAIRSTYLE;
      goto L001;
    end;
    if sCmd = sSC_CHANGELEVEL then begin
      nCMDCode := nSC_CHANGELEVEL;
      goto L001;
    end;
    if sCmd = sSC_MARRY then begin
      nCMDCode := nSC_MARRY;
      goto L001;
    end;
    if sCmd = sSC_UNMARRY then begin
      nCMDCode := nSC_UNMARRY;
      goto L001;
    end;
    if sCmd = sSC_GETMARRY then begin
      nCMDCode := nSC_GETMARRY;
      goto L001;
    end;
    if sCmd = sSC_GETMASTER then begin
      nCMDCode := nSC_GETMASTER;
      goto L001;
    end;
    if sCmd = sSC_CLEARSKILL then begin
      nCMDCode := nSC_CLEARSKILL;
      goto L001;
    end;
    if sCmd = sSC_DELNOJOBSKILL then begin
      nCMDCode := nSC_DELNOJOBSKILL;
      goto L001;
    end;
    if sCmd = sSC_DELSKILL then begin
      nCMDCode := nSC_DELSKILL;
      goto L001;
    end;
    if sCmd = sSC_ADDSKILL then begin
      nCMDCode := nSC_ADDSKILL;
      goto L001;
    end;
    if sCmd = sSC_ADDGUILDMEMBER then begin//添加行会成员//20080427
      nCMDCode := nSC_ADDGUILDMEMBER;
      goto L001;
    end;
    if sCmd = sSC_DELGUILDMEMBER then begin//删除行会成员（删除掌门无效）//20080427
      nCMDCode := nSC_DELGUILDMEMBER;
      goto L001;
    end;
    if sCmd = sSC_SKILLLEVEL then begin
      nCMDCode := nSC_SKILLLEVEL;
      goto L001;
    end;
    if sCmd = sSC_HEROSKILLLEVEL then begin//调整英雄技能等级 20080415
      nCMDCode := nSC_HEROSKILLLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEPKPOINT then begin
      nCMDCode := nSC_CHANGEPKPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEEXP then begin//调整角色经验
      nCMDCode := nSC_CHANGEEXP;
      goto L001;
    end;
    if sCmd = sSC_CHANGENGEXP then begin//调整角色内功经验 20081002
      nCMDCode := nSC_CHANGENGEXP;
      goto L001;
    end;
    if sCmd = sSC_CHANGENGLEVEL then begin//调整角色内功等级 20081004
      nCMDCode := nSC_CHANGENGLEVEL;
      goto L001;
    end;
    if sCmd = sSC_WAPMOVETOTIME then begin//雪域地图传送，时间到传送回城点 20081230
      nCMDCode := nSC_WAPMOVETOTIME;
      goto L001;
    end;
    if sCmd = sSC_CHANGEJOB then begin
      nCMDCode := nSC_CHANGEJOB;
      goto L001;
    end;
    if sCmd = sSC_MISSION then begin
      nCMDCode := nSC_MISSION;
      goto L001;
    end;
    if sCmd = sSC_MOBPLACE then begin
      nCMDCode := nSC_MOBPLACE;
      goto L001;
    end;
    if sCmd = sSC_SETMEMBERTYPE then begin
      nCMDCode := nSC_SETMEMBERTYPE;
      goto L001;
    end;
    if sCmd = sSC_SETMEMBERLEVEL then begin
      nCMDCode := nSC_SETMEMBERLEVEL;
      goto L001;
    end;
    if sCmd = sSC_GAMEGOLD then begin //调整游戏币的命令
      nCMDCode := nSC_GAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_GAMEDIAMOND then begin //调整金刚石数量 20071226
      nCMDCode := nSC_GAMEDIAMOND;
      goto L001;
    end;
    if sCmd = sSC_GAMEGIRD then begin //调整灵符数量 20071226
      nCMDCode := nSC_GAMEGIRD;
      goto L001;
    end;
    if sCmd = sSC_GAMEGLORY then begin //调整荣誉值 20080511
      nCMDCode := nSC_GAMEGLORY;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHEROLOYAL then begin //调整英雄的忠诚度 20080109
      nCMDCode := nSC_CHANGEHEROLOYAL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHUMABILITY then begin //调整人物属性 20080609
      nCMDCode := nSC_CHANGEHUMABILITY;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHEROTRANPOINT then begin //调整英雄技能升级点数 20080512
      nCMDCode := nSC_CHANGEHEROTRANPOINT;
      goto L001;
    end;
//--------------------酒馆系统------------------------------------------------
    if sCmd = sSC_SAVEHERO then begin //寄放英雄 20080513
      nCMDCode := nSC_SAVEHERO;
      goto L001;
    end;
    if sCmd = sSC_GETHERO then begin //取回英雄 20080513
      nCMDCode := nSC_GETHERO;
      goto L001;
    end;
    if sCmd = sSC_CLOSEDRINK then begin //关闭斗酒窗口 20080514
      nCMDCode := nSC_CLOSEDRINK;
      goto L001;
    end;
    if sCmd = sSC_PLAYDRINKMSG then begin //斗酒窗口说话信息 20080514
      nCMDCode := nSC_PLAYDRINKMSG;
      goto L001;
    end;
    if sCmd = sSC_OPENPLAYDRINK then begin //指定人物喝酒 20080514
      nCMDCode := nSC_OPENPLAYDRINK;
      goto L001;
    end;
//----------------------------------------------------------------------------
    if sCmd = sSC_GAMEPOINT then begin
      nCMDCode := nSC_GAMEPOINT;
      goto L001;
    end;
    if sCmd = sSC_PKZONE then begin
      nCMDCode := nSC_PKZONE;
      goto L001;
    end;
    if sCmd = sSC_RESTBONUSPOINT then begin
      nCMDCode := nSC_RESTBONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_TAKECASTLEGOLD then begin
      nCMDCode := nSC_TAKECASTLEGOLD;
      goto L001;
    end;
    if sCmd = sSC_HUMANHP then begin
      nCMDCode := nSC_HUMANHP;
      goto L001;
    end;
    if sCmd = sSC_HUMANMP then begin
      nCMDCode := nSC_HUMANMP;
      goto L001;
    end;
    if sCmd = sSC_BUILDPOINT then begin
      nCMDCode := nSC_BUILDPOINT;
      goto L001;
    end;
    if sCmd = sSC_AURAEPOINT then begin
      nCMDCode := nSC_AURAEPOINT;
      goto L001;
    end;
    if sCmd = sSC_STABILITYPOINT then begin
      nCMDCode := nSC_STABILITYPOINT;
      goto L001;
    end;
    if sCmd = sSC_FLOURISHPOINT then begin
      nCMDCode := nSC_FLOURISHPOINT;
      goto L001;
    end;
    if sCmd = sSC_OPENMAGICBOX then begin
      nCMDCode := nSC_OPENMAGICBOX;
      goto L001;
    end;
    if sCmd = sSC_SETRANKLEVELNAME then begin
      nCMDCode := nSC_SETRANKLEVELNAME;
      goto L001;
    end;
    if sCmd = sSC_GMEXECUTE then begin
      nCMDCode := nSC_GMEXECUTE;
      goto L001;
    end;
    if sCmd = sSC_GUILDCHIEFITEMCOUNT then begin
      nCMDCode := nSC_GUILDCHIEFITEMCOUNT;
      goto L001;
    end;
    if sCmd = sSC_MOBFIREBURN then begin
      nCMDCode := nSC_MOBFIREBURN;
      goto L001;
    end;
    if sCmd = sSC_MESSAGEBOX then begin
      nCMDCode := nSC_MESSAGEBOX;
      goto L001;
    end;
    if sCmd = sSC_SETSCRIPTFLAG then begin
      nCMDCode := nSC_SETSCRIPTFLAG;
      goto L001;
    end;
    if sCmd = sSC_SETAUTOGETEXP then begin
      nCMDCode := nSC_SETAUTOGETEXP;
      goto L001;
    end;
    if sCmd = sSC_VAR then begin
      nCMDCode := nSC_VAR;
      goto L001;
    end;
    if sCmd = sSC_LOADVAR then begin
      nCMDCode := nSC_LOADVAR;
      goto L001;
    end;
    if sCmd = sSC_SAVEVAR then begin
      nCMDCode := nSC_SAVEVAR;
      goto L001;
    end;
    if sCmd = sSC_CALCVAR then begin
      nCMDCode := nSC_CALCVAR;
      goto L001;
    end;
    if sCmd = sSC_AUTOADDGAMEGOLD then begin
      nCMDCode := nSC_AUTOADDGAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_AUTOSUBGAMEGOLD then begin
      nCMDCode := nSC_AUTOSUBGAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_CLEARNAMELIST then begin
      nCMDCode := nSC_CLEARNAMELIST;
      goto L001;
    end;
    if sCmd = sSC_CHANGENAMECOLOR then begin
      nCMDCode := nSC_CHANGENAMECOLOR;
      goto L001;
    end;
    if sCmd = sSC_CLEARPASSWORD then begin
      nCMDCode := nSC_CLEARPASSWORD;
      goto L001;
    end;
    if sCmd = sSC_RENEWLEVEL then begin
      nCMDCode := nSC_RENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_KILLMONEXPRATE then begin
      nCMDCode := nSC_KILLMONEXPRATE;
      goto L001;
    end;
    if sCmd = sSC_POWERRATE then begin
      nCMDCode := nSC_POWERRATE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEMODE then begin
      nCMDCode := nSC_CHANGEMODE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEPERMISSION then begin
      nCMDCode := nSC_CHANGEPERMISSION;
      goto L001;
    end;
    if sCmd = sSC_KILL then begin
      nCMDCode := nSC_KILL;
      goto L001;
    end;
    if sCmd = sSC_KICK then begin
      nCMDCode := nSC_KICK;
      goto L001;
    end;
    if sCmd = sSC_BONUSPOINT then begin
      nCMDCode := nSC_BONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_RESTRENEWLEVEL then begin
      nCMDCode := nSC_RESTRENEWLEVEL;
      goto L001;
    end;
    if sCmd = sSC_DELMARRY then begin
      nCMDCode := nSC_DELMARRY;
      goto L001;
    end;
    if sCmd = sSC_DELMASTER then begin
      nCMDCode := nSC_DELMASTER;
      goto L001;
    end;
    if sCmd = sSC_MASTER then begin
      nCMDCode := nSC_MASTER;
      goto L001;
    end;
    if sCmd = sSC_UNMASTER then begin
      nCMDCode := nSC_UNMASTER;
      goto L001;
    end;
    if sCmd = sSC_CREDITPOINT then begin
      nCMDCode := nSC_CREDITPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEGUILDFOUNTAIN then begin//调整行会酒泉 20081007
      nCMDCode := nSC_CHANGEGUILDFOUNTAIN;
      goto L001;
    end;
    if sCmd = sSC_TAGMAPINFO then begin//记路标石 20081019
      nCMDCode := nSC_TAGMAPINFO;
      goto L001;
    end;
    if sCmd = sSC_TAGMAPMOVE then begin//移动到记路标石记录的XY 20081019
      nCMDCode := nSC_TAGMAPMOVE;
      goto L001;
    end;
    if sCmd = sSC_CLEARNEEDITEMS then begin
      nCMDCode := nSC_CLEARNEEDITEMS;
      goto L001;
    end;
    if sCmd = sSC_CLEARMAKEITEMS then begin
      nCMDCode := nSC_CLEARMAEKITEMS;
      goto L001;
    end;
    if sCmd = sSC_SETSENDMSGFLAG then begin
      nCMDCode := nSC_SETSENDMSGFLAG;
      goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMS then begin
      nCMDCode := nSC_UPGRADEITEMS;
      goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMSEX then begin
      nCMDCode := nSC_UPGRADEITEMSEX;
      goto L001;
    end;
    if sCmd = sSC_GIVEMINE then begin //给矿石  20080330
      nCMDCode := nSC_GIVEMINE;
      goto L001;
    end;
    if sCmd = sSC_MONGENEX then begin
      nCMDCode := nSC_MONGENEX;
      goto L001;
    end;
    if sCmd = sSC_CLEARMAPMON then begin
      nCMDCode := nSC_CLEARMAPMON;
      goto L001;
    end;
    if sCmd = sSC_SETMAPMODE then begin
      nCMDCode := nSC_SETMAPMODE;
      goto L001;
    end;
    if sCmd = sSC_KILLSLAVE then begin
      nCMDCode := nSC_KILLSLAVE;
      goto L001;
    end;
    if sCmd = sSC_CHANGEGENDER then begin
      nCMDCode := nSC_CHANGEGENDER;
      goto L001;
    end;
    if sCmd = sOFFLINEPLAY then begin
      nCMDCode := nOFFLINEPLAY;
      goto L001;
    end;
    if sCmd = sKICKOFFLINE then begin
      nCMDCode := nKICKOFFLINE;
      goto L001;
    end;
    if sCmd = sSTARTTAKEGOLD then begin
      nCMDCode := nSTARTTAKEGOLD;
      goto L001;
    end;
    if sCmd = sDELAYGOTO then begin
      nCMDCode := nDELAYGOTO;
      goto L001;
    end;
    if sCmd = sCLEARDELAYGOTO then begin
      nCMDCode := nCLEARDELAYGOTO;
      goto L001;
    end;
    if sCmd = sSC_ADDUSERDATE then begin
      nCMDCode := nSC_ADDUSERDATE;
      goto L001;
    end;
    if sCmd = sSC_DELUSERDATE then begin
      nCMDCode := nSC_DELUSERDATE;
      goto L001;
    end;
    if sCmd = sSC_ANSIREPLACETEXT then begin
      nCMDCode := nSC_ANSIREPLACETEXT;
      goto L001;
    end;
    if sCmd = sSC_ENCODETEXT then begin
      nCMDCode := nSC_ENCODETEXT;
      goto L001;
    end;
    if sCmd = sSC_ADDTEXTLIST then begin
      nCMDCode := nSC_ADDTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_DELTEXTLIST then begin
      nCMDCode := nSC_DELTEXTLIST;
      goto L001;
    end;
    if sCmd = sSC_GROUPMOVE then begin//20080516
      nCMDCode := nSC_GROUPMOVE;
      goto L001;
    end;
    if sCmd = sSC_GROUPMAPMOVE then begin
      nCMDCode := nSC_GROUPMAPMOVE;
      goto L001;
    end;
    if sCmd = sSC_RECALLHUMAN then begin
      nCMDCode := nSC_RECALLHUMAN;
      goto L001;
    end;
    if sCmd = sSC_REGOTO then begin
      nCMDCode := nSC_REGOTO;
      goto L001;
    end;
    if sCmd = sSC_INTTOSTR then begin
      nCMDCode := nSC_INTTOSTR;
      goto L001;
    end;
    if sCmd = sSC_STRTOINT then begin
      nCMDCode := nSC_STRTOINT;
      goto L001;
    end;
    if sCmd = sSC_GUILDMOVE then begin
      nCMDCode := nSC_GUILDMOVE;
      goto L001;
    end;
    if sCmd = sSC_GUILDMAPMOVE then begin
      nCMDCode := nSC_GUILDMAPMOVE;
      goto L001;
    end;
    if sCmd = sSC_RANDOMMOVE then begin
      nCMDCode := nSC_RANDOMMOVE;
      goto L001;
    end;
    if sCmd = sSC_USEBONUSPOINT then begin
      nCMDCode := nSC_USEBONUSPOINT;
      goto L001;
    end;
    if sCmd = sSC_REPAIRITEM then begin
      nCMDCode := nSC_REPAIRITEM;
      goto L001;
    end;
    if sCmd = sSC_TAKEONITEM then begin
      nCMDCode := nSC_TAKEONITEM;
      goto L001;
    end;
    if sCmd = sSC_TAKEOFFITEM then begin
      nCMDCode := nSC_TAKEOFFITEM;
      goto L001;
    end;
    if sCmd = sSC_CREATEHERO then begin
      nCMDCode := nSC_CREATEHERO;
      goto L001;
    end;
    if sCmd = sSC_DELETEHERO then begin
      nCMDCode := nSC_DELETEHERO;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHEROLEVEL then begin
      nCMDCode := nSC_CHANGEHEROLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHEROJOB then begin
      nCMDCode := nSC_CHANGEHEROJOB;
      goto L001;
    end;
    if sCmd = sSC_CLEARHEROSKILL then begin
      nCMDCode := nSC_CLEARHEROSKILL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHEROPKPOINT then begin
      nCMDCode := nSC_CHANGEHEROPKPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHEROEXP then begin
      nCMDCode := nSC_CHANGEHEROEXP;
      goto L001;
    end;

   { if nCMDCode <= 0 then begin //20080813 注释
      if Assigned(zPlugOfEngine.QuestActionScriptCmd) then begin
        nCMDCode := zPlugOfEngine.QuestActionScriptCmd(PChar(sCmd));
        goto L001;
      end;
    end; }
    L001:
    if nCMDCode > 0 then begin
      QuestActionInfo.nCMDCode := nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then begin
        ArrestStringEx(sParam1, '"', '"', sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then begin
        ArrestStringEx(sParam2, '"', '"', sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then begin
        ArrestStringEx(sParam3, '"', '"', sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then begin
        ArrestStringEx(sParam4, '"', '"', sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then begin
        ArrestStringEx(sParam5, '"', '"', sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then begin
        ArrestStringEx(sParam6, '"', '"', sParam6);
      end;
      if (sParam7 <> '') and (sParam7[1] = '"') then begin
        ArrestStringEx(sParam7, '"', '"', sParam7);
      end;
      QuestActionInfo.sParam1 := sParam1;
      QuestActionInfo.sParam2 := sParam2;
      QuestActionInfo.sParam3 := sParam3;
      QuestActionInfo.sParam4 := sParam4;
      QuestActionInfo.sParam5 := sParam5;
      QuestActionInfo.sParam6 := sParam6;
      QuestActionInfo.sParam7 := sParam7;
      if IsStringNumber(sParam1) then
        QuestActionInfo.nParam1 := Str_ToInt(sParam1, 0);
      if IsStringNumber(sParam2) then
        QuestActionInfo.nParam2 := Str_ToInt(sParam2, 1);
      if IsStringNumber(sParam3) then
        QuestActionInfo.nParam3 := Str_ToInt(sParam3, 1);
      if IsStringNumber(sParam4) then
        QuestActionInfo.nParam4 := Str_ToInt(sParam4, 0);
      if IsStringNumber(sParam5) then
        QuestActionInfo.nParam5 := Str_ToInt(sParam5, 0);
      if IsStringNumber(sParam6) then
        QuestActionInfo.nParam6 := Str_ToInt(sParam6, 0);
      if IsStringNumber(sParam7) then
        QuestActionInfo.nParam7 := Str_ToInt(sParam7, 0);
      Result := True;
    end;
  end;
begin
  Result := -1;
  n6C := 0;
  n70 := 0;
  bo8D := False;//20080521
  sScritpFileName := g_Config.sEnvirDir + sPatch + sScritpName + '.txt';
  if FileExists(sScritpFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sScritpFileName);
      DeCodeStringList(LoadList);//脚本解密
    except
      LoadList.Free;
      Exit;
    end;
    I := 0;

    while (True) do begin
      LoadScriptcall(LoadList);
      Inc(I);
      if I >= 10 then Break;
    end;

    DefineList := TList.Create;

    s54 := LoadDefineInfo(LoadList, DefineList);
    New(DefineInfo);
    DefineInfo.sName := '@HOME';
    if s54 = '' then s54 := '@main';
    DefineInfo.sText := s54;
    DefineList.Add(DefineInfo);
    // 常量处理
    for I := 0 to LoadList.Count - 1 do begin
      s34 := Trim(LoadList.Strings[I]);
      if (s34 <> '') then begin
        if (s34[1] = '[') then begin
          bo8D := False;
        end else begin //0048B83F
          if (s34[1] = '#') and
            (CompareLStr(s34, '#IF', 3{Length('#IF')}) or
            CompareLStr(s34, '#ACT', 4{Length('#ACT')}) or
            CompareLStr(s34, '#ELSEACT', 8{Length('#ELSEACT')})) then begin
            bo8D := True;
          end else begin //0048B895
            if bo8D then begin
              // 将Define 好的常量换成指定值
              for n20 := 0 to DefineList.Count - 1 do begin
                DefineInfo := DefineList.Items[n20];
                n1C := 0;
                while (True) do begin
                  n24 := Pos(DefineInfo.sName, UpperCase(s34));
                  if n24 <= 0 then Break;
                  s58 := Copy(s34, 1, n24 - 1);
                  s5C := Copy(s34, Length(DefineInfo.sName) + n24, 256);
                  s34 := s58 + DefineInfo.sText + s5C;
                  LoadList.Strings[I] := s34;
                  Inc(n1C);
                  if n1C >= 10 then Break;
                end;
              end; // 将Define 好的常量换成指定值
            end;
          end;
        end;
      end;
    end;//for
    // 常量处理

    //释放常量定义内容
    if DefineList.Count > 0 then begin//20080629
      for I := 0 to DefineList.Count - 1 do begin
        if pTDefineInfo(DefineList.Items[I]) <> nil then
           Dispose(pTDefineInfo(DefineList.Items[I]));
      end;
    end;
    DefineList.Free;
    //释放常量定义内容

    Script := nil;
    SayingRecord := nil;
    nQuestIdx := 0;
    for I := 0 to LoadList.Count - 1 do begin //0048B9FC
      s34 := Trim(LoadList.Strings[I]);
      if (s34 = '') or (s34[1] = ';') or (s34[1] = '/') then Continue;
      if (n6C = 0) and (boFlag) then begin
        //物品价格倍率
        if s34[1] = '%' then begin //0048BA57
          s34 := Copy(s34, 2, Length(s34) - 1);
          nPriceRate := Str_ToInt(s34, -1);
          if nPriceRate >= 55 then begin
            TMerchant(NPC).m_nPriceRate := nPriceRate;
          end;
          Continue;
        end;
        //物品交易类型
        if s34[1] = '+' then begin
          s34 := Copy(s34, 2, Length(s34) - 1);
          nItemType := Str_ToInt(s34, -1);
          if nItemType >= 0 then begin
            TMerchant(NPC).m_ItemTypeList.Add(Pointer(nItemType));
          end;
          Continue;
        end;
        //增加处理NPC可执行命令设置
        if s34[1] = '(' then begin
          ArrestStringEx(s34, '(', ')', s34);
          if s34 <> '' then begin
            while (s34 <> '') do begin
              s34 := GetValidStr3(s34, s30, [' ', ',', #9]);
              if CompareText(s30, sBUY) = 0 then begin
                TMerchant(NPC).m_boBuy := True;
                Continue;
              end;
              if CompareText(s30, sSELL) = 0 then begin
                TMerchant(NPC).m_boSell := True;
                Continue;
              end;
              if CompareText(s30, sMAKEDURG) = 0 then begin
                TMerchant(NPC).m_boMakeDrug := True;
                Continue;
              end;
              if CompareText(s30, sPRICES) = 0 then begin
                TMerchant(NPC).m_boPrices := True;
                Continue;
              end;
              if CompareText(s30, sSTORAGE) = 0 then begin
                TMerchant(NPC).m_boStorage := True;
                Continue;
              end;
              if CompareText(s30, sGETBACK) = 0 then begin
                TMerchant(NPC).m_boGetback := True;
                Continue;
              end;
              if CompareText(s30, sUPGRADENOW) = 0 then begin
                TMerchant(NPC).m_boUpgradenow := True;
                Continue;
              end;
              if CompareText(s30, sGETBACKUPGNOW) = 0 then begin
                TMerchant(NPC).m_boGetBackupgnow := True;
                Continue;
              end;
              if CompareText(s30, sREPAIR) = 0 then begin
                TMerchant(NPC).m_boRepair := True;
                Continue;
              end;
              if CompareText(s30, sSUPERREPAIR) = 0 then begin
                TMerchant(NPC).m_boS_repair := True;
                Continue;
              end;
              if CompareText(s30, sSL_SENDMSG) = 0 then begin
                TMerchant(NPC).m_boSendmsg := True;
                Continue;
              end;
              if CompareText(s30, sUSEITEMNAME) = 0 then begin
                TMerchant(NPC).m_boUseItemName := True;
                Continue;
              end;
             { if CompareText(s30, sGETSELLGOLD) = 0 then begin  //20080416 去掉拍卖功能
                TMerchant(NPC).m_boGetSellGold := True;
                Continue;
              end; 
              if CompareText(s30, sSELLOFF) = 0 then begin
                TMerchant(NPC).m_boSellOff := True;
                Continue;
              end;
              if CompareText(s30, sBUYOFF) = 0 then begin
                TMerchant(NPC).m_boBuyOff := True;
                Continue;
              end; }
              if CompareText(s30, sofflinemsg) = 0 then begin
                TMerchant(NPC).m_boofflinemsg := True;
                Continue;
              end;
              if CompareText(s30, sdealgold) = 0 then begin
                TMerchant(NPC).m_boDealGold := True;
                Continue;
              end;
              if CompareText(s30, sBIGSTORAGE) = 0 then begin
                TMerchant(NPC).m_boBigStorage := True;
                Continue;
              end;
              if CompareText(s30, sBIGGETBACK) = 0 then begin
                TMerchant(NPC).m_boBigGetBack := True;
                Continue;
              end;
              if CompareText(s30, sGETPREVIOUSPAGE) = 0 then begin
                TMerchant(NPC).m_boGetPreviousPage := True;
                Continue;
              end;
              if CompareText(s30, sGETNEXTPAGE) = 0 then begin
                TMerchant(NPC).m_boGetNextPage := True;
                Continue;
              end;

              if CompareText(s30, sUserLevelOrder) = 0 then begin
                TMerchant(NPC).m_boUserLevelOrder := True;
                Continue;
              end;
              if CompareText(s30, sWarrorLevelOrder) = 0 then begin
                TMerchant(NPC).m_boWarrorLevelOrder := True;
                Continue;
              end;
              if CompareText(s30, sWizardLevelOrder) = 0 then begin
                TMerchant(NPC).m_boWizardLevelOrder := True;
                Continue;
              end;
              if CompareText(s30, sTaoistLevelOrder) = 0 then begin
                TMerchant(NPC).m_boTaoistLevelOrder := True;
                Continue;
              end;
              if CompareText(s30, sMasterCountOrder) = 0 then begin
                TMerchant(NPC).m_boMasterCountOrder := True;
                Continue;
              end;
              if CompareText(s30, sLyCreateHero) = 0 then begin
                TMerchant(NPC).m_boCqFirHero := True;
                Continue;
              end;
              if CompareText(s30, sBuHero) = 0 then begin//酒馆英雄NPC 20080514
                TMerchant(NPC).m_boBuHero := True;
                Continue;
              end;
              if CompareText(s30, sPlayMakeWine) = 0 then begin//酿酒NPC 20080619
                TMerchant(NPC).m_boPlayMakeWine := True;
                Continue;
              end;
              if CompareText(s30, sPlayDrink) = 0 then begin//请酒,斗酒NPC 20080515
                TMerchant(NPC).m_boPlayDrink := True;
                Continue;
              end;
              if CompareText(s30, sybdeal) = 0 then begin //元宝寄售NPC属性 20080316
                TMerchant(NPC).m_boYBDeal := True;
                Continue;
              end;
            end;
          end;
          Continue;
        end
      end;

      if s34[1] = '{' then begin
        if CompareLStr(s34, '{Quest', 6{Length('{Quest')}) then begin
          s38 := GetValidStr3(s34, s3C, [' ', '}', #9]);
          GetValidStr3(s38, s3C, [' ', '}', #9]);
          n70 := Str_ToInt(s3C, 0);
          Script := MakeNewScript();
          Script.nQuest := n70;
          Inc(n70);
        end; //0048BBA4
        if CompareLStr(s34, '{~Quest', 7{Length('{~Quest')}) then Continue;
      end; //0048BBBE

      if (n6C = 1) and (Script <> nil) and (s34[1] = '#') then begin
        s38 := GetValidStr3(s34, s3C, ['=', ' ', #9]);
        Script.boQuest := True;
        if CompareLStr(s34, '#IF', 3{Length('#IF')}) then begin
          ArrestStringEx(s34, '[', ']', s40);
          Script.QuestInfo[nQuestIdx].wFlag := Str_ToInt(s40, 0);
          GetValidStr3(s38, s44, ['=', ' ', #9]);
          n24 := Str_ToInt(s44, 0);
          if n24 <> 0 then n24 := 1;
          Script.QuestInfo[nQuestIdx].btValue := n24;
        end;

        if CompareLStr(s34, '#RAND', 5{Length('#RAND')}) then begin
          Script.QuestInfo[nQuestIdx].nRandRage := Str_ToInt(s44, 0);
        end;
        Continue;
      end;

      if s34[1] = '[' then begin
        n6C := 10;
        if Script = nil then begin
          Script := MakeNewScript();
          Script.nQuest := n70;
        end;
        if CompareText(s34, '[goods]') = 0 then begin
          n6C := 20;
          Continue;
        end;
        s34 := ArrestStringEx(s34, '[', ']', s74);
        New(SayingRecord);
        SayingRecord.ProcedureList := TList.Create;
        SayingRecord.sLabel := s74;
        s34 := GetValidStrCap(s34, s74, [' ', #9]);
        if CompareText(s74, 'TRUE') = 0 then begin
          SayingRecord.boExtJmp := True;
        end else begin
          SayingRecord.boExtJmp := False;
        end;
        New(SayingProcedure);
        SayingRecord.ProcedureList.Add(SayingProcedure);
        SayingProcedure.ConditionList := TList.Create;
        SayingProcedure.ActionList := TList.Create;
        SayingProcedure.sSayMsg := '';
        SayingProcedure.ElseActionList := TList.Create;
        SayingProcedure.sElseSayMsg := '';
        Script.RecordList.Add(SayingRecord);
        Continue;
      end;
      if (Script <> nil) and (SayingRecord <> nil) then begin
        if (n6C >= 10) and (n6C < 20) and (s34[1] = '#') then begin
          if CompareText(s34, '#IF') = 0 then begin
            if (SayingProcedure.ConditionList.Count > 0) or (SayingProcedure.sSayMsg <> '') then begin //0048BE53
              New(SayingProcedure);
              SayingRecord.ProcedureList.Add(SayingProcedure);
              SayingProcedure.ConditionList := TList.Create;
              SayingProcedure.ActionList := TList.Create;
              SayingProcedure.sSayMsg := '';
              SayingProcedure.ElseActionList := TList.Create;
              SayingProcedure.sElseSayMsg := '';
            end;
            n6C := 11;
          end;
          if CompareText(s34, '#ACT') = 0 then n6C := 12;
          if CompareText(s34, '#SAY') = 0 then n6C := 10;
          if CompareText(s34, '#ELSEACT') = 0 then n6C := 13;
          if CompareText(s34, '#ELSESAY') = 0 then n6C := 14;
          Continue;
        end; //0048BF3E
        if (n6C = 10) and (SayingProcedure <> nil) then 
          SayingProcedure.sSayMsg := SayingProcedure.sSayMsg + s34;

        if (n6C = 11) then begin
          New(QuestConditionInfo);
          FillChar(QuestConditionInfo^, SizeOf(TQuestConditionInfo), #0);
          if QuestCondition(Trim(s34), QuestConditionInfo) then begin
            SayingProcedure.ConditionList.Add(QuestConditionInfo);
          end else begin
            Dispose(QuestConditionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(I) + ' 行: ' + sScritpFileName);
          end;
        end; //0048C004
        if (n6C = 12) then begin
          New(QuestActionInfo);
          FillChar(QuestActionInfo^, SizeOf(TQuestActionInfo), #0);
          if QuestAction(Trim(s34), QuestActionInfo) then begin
            SayingProcedure.ActionList.Add(QuestActionInfo);
          end else begin
            Dispose(QuestActionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(I) + ' 行: ' + sScritpFileName);
          end;
        end;
        if (n6C = 13) then begin
          New(QuestActionInfo);
          FillChar(QuestActionInfo^, SizeOf(TQuestActionInfo), #0);
          if QuestAction(Trim(s34), QuestActionInfo) then begin
            SayingProcedure.ElseActionList.Add(QuestActionInfo);
          end else begin
            Dispose(QuestActionInfo);
            MainOutMessage('脚本错误: ' + s34 + ' 第:' + IntToStr(I) + ' 行: ' + sScritpFileName);
          end;
        end;
        if (n6C = 14) then
          SayingProcedure.sElseSayMsg := SayingProcedure.sElseSayMsg + s34;
      end;
      if (n6C = 20) and boFlag then begin
        s34 := GetValidStrCap(s34, s48, [' ', #9]);
        s34 := GetValidStrCap(s34, s4C, [' ', #9]);
        s34 := GetValidStrCap(s34, s50, [' ', #9]);
        if (s48 <> '') and (s50 <> '') then begin
          New(Goods);
          if (s48 <> '') and (s48[1] = '"') then begin
            ArrestStringEx(s48, '"', '"', s48);
          end;
          Goods.sItemName := s48;
          Goods.nCount := Str_ToInt(s4C, 0);
          Goods.dwRefillTime := Str_ToInt(s50, 0);
          Goods.dwRefillTick := 0;
          TMerchant(NPC).m_RefillGoodsList.Add(Goods);
        end; //0048C2D2
      end; //0048C2D2
    end; // for
    LoadList.Free;
  end else begin //0048C2EB
    MainOutMessage('脚本文件未找到: ' + sScritpFileName);
  end;
  Result := 1;
end;

function TFrmDB.SaveGoodRecord(NPC: TMerchant; sFile: string): Integer;
var
  I, II: Integer;
  sFileName: string;
  FileHandle: Integer;
  UserItem: pTUserItem;
  List: TList;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Saved\' + sFile + '.sav';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle := FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FillChar(Header420, SizeOf(TGoodFileHeader), #0);
    if NPC.m_GoodsList.Count > 0 then begin//20080629
      for I := 0 to NPC.m_GoodsList.Count - 1 do begin
        List := TList(NPC.m_GoodsList.Items[I]);
        Inc(Header420.nItemCount, List.Count);
      end;
    end;
    FileWrite(FileHandle, Header420, SizeOf(TGoodFileHeader));
    if NPC.m_GoodsList.Count > 0 then begin//20080629
      for I := 0 to NPC.m_GoodsList.Count - 1 do begin
        List := TList(NPC.m_GoodsList.Items[I]);
        if List.Count > 0 then begin//20080629
          for II := 0 to List.Count - 1 do begin
            UserItem := List.Items[II];
            FileWrite(FileHandle, UserItem^, SizeOf(TUserItem));
          end;
        end;
      end;
    end;
    FileClose(FileHandle);
    Result := 1;
  end;
end;

function TFrmDB.SaveGoodPriceRecord(NPC: TMerchant; sFile: string): Integer;
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  ItemPrice: pTItemPrice;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Prices\' + sFile + '.prc';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle := FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FillChar(Header420, SizeOf(TGoodFileHeader), #0);
    Header420.nItemCount := NPC.m_ItemPriceList.Count;
    FileWrite(FileHandle, Header420, SizeOf(TGoodFileHeader));
    if NPC.m_ItemPriceList.Count > 0 then begin//20080629
      for I := 0 to NPC.m_ItemPriceList.Count - 1 do begin
        ItemPrice := NPC.m_ItemPriceList.Items[I];
        FileWrite(FileHandle, ItemPrice^, SizeOf(TItemPrice));
      end;
    end;
    FileClose(FileHandle);
    Result := 1;
  end;
end;

//重新读取管理NPC
procedure TFrmDB.ReLoadNpc;
var
  sFileName, s18, s20, s24, s28, s2C, s30, s34, s38, s40, s42: string;
  LoadList: TStringList;
  NPC: TNormNpc;
  I,II, nX, nY: Integer;
  boNewNpc: Boolean;
begin
  Try
    sFileName := g_Config.sEnvirDir + 'Npcs.txt';
    if not FileExists(sFileName) then Exit;
    if UserEngine.QuestNPCList.Count > 0 then begin//20080629
      for I := 0 to UserEngine.QuestNPCList.Count - 1 do begin
        NPC := TNormNpc(UserEngine.QuestNPCList.Items[I]);
        if (NPC <> g_ManageNPC) and (NPC <> g_RobotNPC) and (NPC <> g_FunctionNPC) and (not NPC.m_boIsQuest) then NPC.m_nFlag := -1;
      end;
    end;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      s18 := Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        s18 := GetValidStrCap(s18, s20, [' ', #9]);
        if (s20 <> '') and (s20[1] = '"') then ArrestStringEx(s20, '"', '"', s20);
        s18 := GetValidStr3(s18, s24, [' ', #9]);
        s18 := GetValidStr3(s18, s28, [' ', #9]);
        s18 := GetValidStr3(s18, s2C, [' ', #9]);
        s18 := GetValidStr3(s18, s30, [' ', #9]);
        s18 := GetValidStr3(s18, s34, [' ', #9]);
        s18 := GetValidStr3(s18, s38, [' ', #9]);
        s18 := GetValidStr3(s18, s40, [' ', #9]);
        s18 := GetValidStr3(s18, s42, [' ', #9]);
        if (s20 <> '') and (s28 <> '') and (s38 <> '') then begin
         nX := Str_ToInt(s2C, 0);
         nY := Str_ToInt(s30, 0);
          boNewNpc := True;
          if UserEngine.QuestNPCList.Count > 0 then begin
            for II := 0 to UserEngine.QuestNPCList.Count - 1 do begin
              NPC := TNormNpc(UserEngine.QuestNPCList.Items[II]);
              if (NPC.m_sMapName = s28) and (NPC.m_nCurrX = nX) and (NPC.m_nCurrY = nY) then begin
                boNewNpc := False;
                NPC.m_sCharName := s20;
                NPC.m_nFlag := Str_ToInt(s34, 0);
                NPC.m_wAppr := Str_ToInt(s38, 0);
                if Str_ToInt(s40, 0) <> 0 then NPC.m_boNpcAutoChangeColor := True;
                NPC.m_dwNpcAutoChangeColorTime := Str_ToInt(s42, 0) * 1000;
                Break;
              end;
            end;//for
          end;
          if boNewNpc then begin
            NPC := nil;
            case Str_ToInt(s24, 0) of
              0: NPC := TMerchant.Create;
              1: NPC := TGuildOfficial.Create;
              2: NPC := TCastleOfficial.Create;
            end;
            if NPC <> nil then begin
              NPC.m_sMapName := s28;
              NPC.m_nCurrX := {Str_ToInt(s2C, 0)}nX;
              NPC.m_nCurrY := {Str_ToInt(s30, 0)}nY;
              NPC.m_sCharName := s20;
              NPC.m_nFlag := Str_ToInt(s34, 0);
              NPC.m_wAppr := Str_ToInt(s38, 0);
              if Str_ToInt(s40, 0) <> 0 then NPC.m_boNpcAutoChangeColor := True;
              NPC.m_dwNpcAutoChangeColorTime := Str_ToInt(s42, 0) * 1000;
              UserEngine.QuestNPCList.Add(NPC);
            end;
          end;
        end;
      end;
    end;//for
    LoadList.Free;
    if UserEngine.QuestNPCList.Count > 0 then begin
      for I := UserEngine.QuestNPCList.Count - 1 downto 0 do begin
        NPC := TNormNpc(UserEngine.QuestNPCList.Items[I]);
        if NPC.m_nFlag = -1 then begin
          NPC.m_boGhost := True;
          NPC.m_dwGhostTick := GetTickCount();
        end;
      end;
    end;
  except
  end;
end;
//重新读取交易NPC
procedure TFrmDB.ReLoadMerchants;
var
  I, II, nX, nY: Integer;
  sLineText, sFileName, sScript, sMapName, sX, sY, sCharName, sFlag, sAppr, sCastle, sCanMove, sMoveTime: string;
  Merchant: TMerchant;
  LoadList: TStringList;
  boNewNpc: Boolean;
begin
  sFileName := g_Config.sEnvirDir + 'Merchant.txt';
  if not FileExists(sFileName) then Exit;
  UserEngine.m_MerchantList.Lock;
  try
    if UserEngine.m_MerchantList.Count > 0 then begin//20080629
      for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
        Merchant := TMerchant(UserEngine.m_MerchantList.Items[I]);
        if Merchant <> g_FunctionNPC then
        Merchant.m_nFlag := -1;
      end;
    end;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sLineText := GetValidStr3(sLineText, sScript, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMapName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sX, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sY, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCharName, [' ', #9]);
        if (sCharName <> '') and (sCharName[1] = '"') then
          ArrestStringEx(sCharName, '"', '"', sCharName);
        sLineText := GetValidStr3(sLineText, sFlag, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sAppr, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCastle, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sCanMove, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sMoveTime, [' ', #9]);
        nX := Str_ToInt(sX, 0);
        nY := Str_ToInt(sY, 0);
        boNewNpc := True;
        if UserEngine.m_MerchantList.Count > 0 then begin//20080629
          for II := 0 to UserEngine.m_MerchantList.Count - 1 do begin
            Merchant := TMerchant(UserEngine.m_MerchantList.Items[II]);
            if (Merchant.m_sMapName = sMapName) and
              (Merchant.m_nCurrX = nX) and
              (Merchant.m_nCurrY = nY) then begin
              boNewNpc := False;
              Merchant.m_sScript := sScript;
              Merchant.m_sCharName := sCharName;
              Merchant.m_nFlag := Str_ToInt(sFlag, 0);
              Merchant.m_wAppr := Str_ToInt(sAppr, 0);
              Merchant.m_dwMoveTime := Str_ToInt(sMoveTime, 0);
              if Str_ToInt(sCastle, 0) <> {1}0 then Merchant.m_boCastle := True//20080820 修改
              else Merchant.m_boCastle := False;
              if (Str_ToInt(sCanMove, 0) <> 0) and (Merchant.m_dwMoveTime > 0) then
                Merchant.m_boCanMove := True;
              Break;
            end;
          end;
        end;
        if boNewNpc then begin
          Merchant := TMerchant.Create;
          Merchant.m_sMapName := sMapName;
          Merchant.m_PEnvir := g_MapManager.FindMap(Merchant.m_sMapName);
          if Merchant.m_PEnvir <> nil then begin
            Merchant.m_sScript := sScript;
            Merchant.m_nCurrX := nX;
            Merchant.m_nCurrY := nY;
            Merchant.m_sCharName := sCharName;
            Merchant.m_nFlag := Str_ToInt(sFlag, 0);
            Merchant.m_wAppr := Str_ToInt(sAppr, 0);
            Merchant.m_dwMoveTime := Str_ToInt(sMoveTime, 0);
            if Str_ToInt(sCastle, 0) <> {1}0 then Merchant.m_boCastle := True//20080820 修改
            else Merchant.m_boCastle := False;
            if (Str_ToInt(sCanMove, 0) <> 0) and (Merchant.m_dwMoveTime > 0) then
              Merchant.m_boCanMove := True;
            UserEngine.m_MerchantList.Add(Merchant);
            Merchant.Initialize;
          end else Merchant.Free;
        end;
      end;
    end; // for
    LoadList.Free;
    if UserEngine.m_MerchantList.Count > 0 then begin//20080629
      for I := UserEngine.m_MerchantList.Count - 1 downto 0 do begin
        Merchant := TMerchant(UserEngine.m_MerchantList.Items[I]);
        if Merchant.m_nFlag = -1 then begin
          Merchant.m_boGhost := True;
          Merchant.m_dwGhostTick := GetTickCount();
          //UserEngine.MerchantList.Delete(I);
        end;
      end;
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
end;

function TFrmDB.LoadUpgradeWeaponRecord(sNPCName: string;
  DataList: TList): Integer;
var
  I: Integer;
  FileHandle: Integer;
  sFileName,Str: string;
  UpgradeInfo: pTUpgradeInfo;
  UpgradeRecord: TUpgradeInfo;
  nRecordCount: Integer;
begin
  Result := -1;
  if Pos('/',sNPCName) > 0 then begin;//20081223 检查文件名是否包含'/',有则替换为'_'
    sNPCName := GetValidStr3(sNPCName, str, ['/']);
    sNPCName := str +'_'+ sNPCName;
  end;
  sFileName := '.\Envir\Market_Upg\' + sNPCName + '.upg';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      FileRead(FileHandle, nRecordCount, SizeOf(Integer));
      if nRecordCount > 0 then begin//20080629
        for I := 0 to nRecordCount - 1 do begin
          if FileRead(FileHandle, UpgradeRecord, SizeOf(TUpgradeInfo)) = SizeOf(TUpgradeInfo) then begin
            New(UpgradeInfo);
            UpgradeInfo^ := UpgradeRecord;
            UpgradeInfo.dwGetBackTick := 0;
            DataList.Add(UpgradeInfo);
          end;
        end;
      end;
      FileClose(FileHandle);
      Result := 1;
    end;
  end;
end;

function TFrmDB.SaveUpgradeWeaponRecord(sNPCName: string; DataList: TList): Integer;
var
  I: Integer;
  FileHandle: Integer;
  sFileName, Str: string;
  UpgradeInfo: pTUpgradeInfo;
begin
  Result := -1;
  if Pos('/',sNPCName) > 0 then begin;//20081223 检查文件名是否包含'/',有则替换为'_'
    sNPCName := GetValidStr3(sNPCName, str, ['/']);
    sNPCName := str +'_'+ sNPCName;
  end;
  sFileName := '.\Envir\Market_Upg\' + sNPCName + '.upg';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle := FileCreate(sFileName);
  end;

  if FileHandle > 0 then begin
    FileWrite(FileHandle, DataList.Count, SizeOf(Integer));
    if DataList.Count > 0 then begin//20080629
      for I := 0 to DataList.Count - 1 do begin
        UpgradeInfo := DataList.Items[I];
        FileWrite(FileHandle, UpgradeInfo^, SizeOf(TUpgradeInfo));
      end;
    end;
    FileClose(FileHandle);
    Result := 1;
  end;
end;

function TFrmDB.LoadGoodRecord(NPC: TMerchant; sFile: string): Integer; //0048C574
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  UserItem: pTUserItem;
  List: TList;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Saved\' + sFile + '.sav';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    List := nil;
    if FileHandle > 0 then begin
      if FileRead(FileHandle, Header420, SizeOf(TGoodFileHeader)) = SizeOf(TGoodFileHeader) then begin
        if Header420.nItemCount > 0 then begin//20080629
          for I := 0 to Header420.nItemCount - 1 do begin
            New(UserItem);
            FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 增加
            if FileRead(FileHandle, UserItem^, SizeOf(TUserItem)) = SizeOf(TUserItem) then begin
              //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 增加
              if List = nil then begin
                List := TList.Create;
                List.Add(UserItem)
              end else begin
                if pTUserItem(List.Items[0]).wIndex = UserItem.wIndex then begin
                  List.Add(UserItem);
                end else begin
                  NPC.m_GoodsList.Add(List);
                  List := TList.Create;
                  List.Add(UserItem);
                end;
              end;
            end else begin
              DisPoseAndNil(UserItem);
            end;
          end;//for
        end;
        if List <> nil then NPC.m_GoodsList.Add(List);
        FileClose(FileHandle);
        Result := 1;
      end;
    end;
  end;
end;

function TFrmDB.LoadGoodPriceRecord(NPC: TMerchant; sFile: string): Integer; //0048C918
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  ItemPrice: pTItemPrice;
  Header420: TGoodFileHeader;
begin
  Result := -1;
  sFileName := '.\Envir\Market_Prices\' + sFile + '.prc';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      if FileRead(FileHandle, Header420, SizeOf(TGoodFileHeader)) = SizeOf(TGoodFileHeader) then begin
        if Header420.nItemCount > 0 then begin//20080629
          for I := 0 to Header420.nItemCount - 1 do begin
            New(ItemPrice);
            if FileRead(FileHandle, ItemPrice^, SizeOf(TItemPrice)) = SizeOf(TItemPrice) then begin
              NPC.m_ItemPriceList.Add(ItemPrice);
            end else begin
              Dispose(ItemPrice);
              Break;
            end;
          end;//for
        end;
      end;
      FileClose(FileHandle);
      Result := 1;
    end;
  end;
end;
//------------------------------------------------------------------------------
//读取宝箱 20080114
procedure TFrmDB.LoadBoxsList;
  function IsNum(str:string):boolean; //判断一个字符串是否为数字
  var
    i:integer;
  begin
    for i:=1 to length(str) do
      if not (str[i] in ['0'..'9']) then begin
        Result:=false;
        exit;
      end;
    Result:=true;
  end;
  function IsNum1(str:string):Integer;//判断有几个'('号
  var
    i:integer;
  begin
    Result:=0;
    if length(str) <= 0 then Exit;
    for i:=1 to length(str) do
      if  (str[i] in ['(']) then inc(Result);
  end;
var
  LoadList,tSaveList: TStringList;
  sBoxsDir,BoxsFile: string;
  I,K,j: Integer;
  SBoxsID,sItemName,nItemNum,nItemType,OpenBox,nGold,nGameGold,nIncGold,nIncGameGold,nEffectiveGold,nEffectiveGameGold,nUses:string;
  BoxsInfo: pTBoxsInfo;
  StdItem: PTStdItem;
  sTemp: string;
begin
  if not DirectoryExists(g_Config.sBoxsDir) then begin //目录不存在,则创建
    CreateDir(g_Config.sBoxsDir);
  end;
  if not FileExists(g_Config.sBoxsFile) then begin //BoxsList.txt文件不存在,则创建文件
    tSaveList := TStringList.Create;
    tSaveList.Add(';此为宝箱序列号文件');
    tSaveList.Add(';如何设置请查看帮助文档');
    tSaveList.Add(';理论上是可以增加无限个宝箱，不再局限于只能设置五个宝箱的内容');
    tSaveList.SaveToFile(g_Config.sBoxsFile);
    tSaveList.Free;
  end;

  if FileExists(g_Config.sBoxsFile) then begin
    BoxsList.Clear;
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(g_Config.sBoxsFile);
    for I := 0 to LoadList.Count - 1 do begin
      sBoxsDir := Trim(LoadList.Strings[I]);
      if (sBoxsDir <> '') and (sBoxsDir[1] <> ';') then begin
         if FileExists(g_Config.sBoxsDir+sBoxsDir+'.txt') then begin
          tSaveList := TStringList.Create;
          tSaveList.LoadFromFile(g_Config.sBoxsDir+sBoxsDir+'.txt');
          if tSaveList.Text='' then Continue;//继续 如果文件内容为空则跳至下一文件 20080115
          BoxsFile:=Trim(tSaveList.Strings[0]); //取第一行数据
          if BoxsFile <> '' then begin
            SBoxsID := sBoxsDir;
            BoxsFile := GetValidStr3(BoxsFile, OpenBox, ['	',' ',#9]);
            BoxsFile := GetValidStr3(BoxsFile, nGold, ['	',' ',#9]);
            BoxsFile := GetValidStr3(BoxsFile, nGameGold, ['	',' ',#9]);
            BoxsFile := GetValidStr3(BoxsFile, nIncGold, ['	',' ',#9]);
            BoxsFile := GetValidStr3(BoxsFile, nIncGameGold, ['	',' ',#9]);
            BoxsFile := GetValidStr3(BoxsFile, nEffectiveGold, ['	',' ',#9]);
            BoxsFile := GetValidStr3(BoxsFile, nEffectiveGameGold, ['	',' ',#9]);
            BoxsFile := GetValidStr3(BoxsFile, nUses, ['	',' ',#9]);
          end;

         for K := 1 to tSaveList.Count - 1 do begin
           BoxsFile:= Trim(tSaveList.Strings[K]);
            if (BoxsFile <> '') and (BoxsFile[1] <> ';') then begin
             J:=IsNum1(BoxsFile);
             case J of
               0:begin
                   ArrestStringEx(BoxsFile, '(', ')', nItemNum);//物品数量
                   BoxsFile := GetValidStr3(BoxsFile, sItemName, ['	',' ',#9]);
                   BoxsFile := GetValidStr3(BoxsFile, nItemType, ['	',' ',#9]);//物品类型
                end;
               1:begin
                   ArrestStringEx(BoxsFile, '(', ')', nItemNum);//物品数量
                   BoxsFile := GetValidStr3(BoxsFile, sItemName, ['	',' ',#9]);
                   if IsNum(nItemNum) and (nItemNum <> '') then GetValidStr3(sItemName, sItemName, ['(']) //物品名字
                     else nItemNum:='';
                   BoxsFile := GetValidStr3(BoxsFile, nItemType, ['	',' ',#9]);//物品类型
               end;
               2:begin
                  ArrestStringEx(BoxsFile, '(', ')', nItemNum);//物品数量
                  if nItemNum <> '' then begin
                    if not IsNum(nItemNum) then begin
                      sTemp:=GetValidStr3(BoxsFile, sItemName, [')']);
                      if sItemName <> '' then sItemName:= sItemName+')';
                      ArrestStringEx(sTemp, '(', ')', nItemNum);
                      nItemType:=GetValidStr3(sTemp, nItemType, ['	',' ',#9]);//物品类型
                    end;
                  end;
               end;
             end;
            end;
           if (sItemName = '') and (nItemType='') then Continue;//20080227
           if (sItemName<> '') and (nItemType<> '') then begin
            StdItem := UserEngine.GetStdItem(sItemName);
             if StdItem <> nil then begin//判断是否是数据库里的物品
               New(BoxsInfo);
               BoxsInfo.SBoxsID:= StrToInt(SBoxsID);
               if nItemNum <> '' then
                 BoxsInfo.nItemNum:= StrToInt(nItemNum)
               else BoxsInfo.nItemNum:=1;
               BoxsInfo.nItemType:= StrToInt(nItemType);
               BoxsInfo.StdItem.MakeIndex:=Integer(BoxsInfo);
               if StrToInt(OpenBox)=1 then
                 BoxsInfo.OpenBox:=True
               else BoxsInfo.OpenBox:=False;
               BoxsInfo.nGold:= StrToInt(nGold);
               BoxsInfo.nGameGold:= StrToInt(nGameGold);
               BoxsInfo.nIncGold:= StrToInt(nIncGold);
               BoxsInfo.nIncGameGold:= StrToInt(nIncGameGold);
               BoxsInfo.nEffectiveGold:= StrToInt(nEffectiveGold);
               BoxsInfo.nEffectiveGameGold:= StrToInt(nEffectiveGameGold);
               BoxsInfo.nUses:= StrToInt(nUses);
               BoxsInfo.StdItem.Dura := Round((StdItem.DuraMax / 100) * (20 + Random(80)));//当前持久 20080324
               BoxsInfo.StdItem.DuraMax := StdItem.DuraMax;//最大持久 20080324
               BoxsInfo.StdItem.S:=StdItem^;
               BoxsList.Add(BoxsInfo);
              end else  begin //如果是经验 声望 金刚石
                if (Trim(sItemName)='经验') or (Trim(sItemName)='声望') or (Trim(sItemName)=g_Config.sGameDiaMond{'金刚石'}) then begin
                   New(BoxsInfo);
                   BoxsInfo.SBoxsID:= StrToInt(SBoxsID);
                   BoxsInfo.StdItem.S.Name:= sItemName;//20080116
                   BoxsInfo.StdItem.S.StdMode:=0;//20080116
                   BoxsInfo.StdItem.S.Shape:=0;//20080116
                   BoxsInfo.StdItem.MakeIndex:=Integer(BoxsInfo);
                   if nItemNum <> '' then
                     BoxsInfo.nItemNum:= StrToInt(nItemNum)
                   else BoxsInfo.nItemNum:=1;
                   BoxsInfo.nItemType:= StrToInt(nItemType);
                   if StrToInt(OpenBox)=1 then
                     BoxsInfo.OpenBox:=True
                   else BoxsInfo.OpenBox:=False;
                   BoxsInfo.nGold:= StrToInt(nGold);
                   BoxsInfo.nGameGold:= StrToInt(nGameGold);
                   BoxsInfo.nIncGold:= StrToInt(nIncGold);
                   BoxsInfo.nIncGameGold:= StrToInt(nIncGameGold);
                   BoxsInfo.nEffectiveGold:= StrToInt(nEffectiveGold);
                   BoxsInfo.nEffectiveGameGold:= StrToInt(nEffectiveGameGold);
                   BoxsInfo.nUses:= StrToInt(nUses);
                   BoxsList.Add(BoxsInfo);
                end else MainOutMessage('提示:'+g_Config.sBoxsDir+sBoxsDir+'.txt 文件中物品('+sItemName+')数据库中不存在...');
             end;
           end;
          end;// for K := 1 to tSaveList.Count - 1 do begin
           tSaveList.free;
         end else MainOutMessage('宝箱配置文件:'+g_Config.sBoxsDir+sBoxsDir+'.txt 文件不存在...');
      end;
    end;//for
    LoadList.Free;
  end;
end;
//------------------------------------------------------------------------------
//读取元宝寄售列表 20080316
procedure TFrmDB.LoadSellOffItemList();
var
  sFileName: string;
  FileHandle: Integer;
  DealOffInfo: pTDealOffInfo;
  sDealOffInfo: TDealOffInfo;
begin
  sFileName :=  g_Config.sEnvirDir + 'UserData';
  if not DirectoryExists(sFileName) then CreateDir(sFileName); //目录不存在,则创建
  sFileName := sFileName+'\UserData.dat';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      try
        while FileRead(FileHandle, sDealOffInfo, Sizeof(TDealOffInfo)) = Sizeof(TDealOffInfo) do begin// 循环读出人物数据
          if (sDealOffInfo.sDealCharName <>'') and (sDealOffInfo.sBuyCharName <> '') and (sDealOffInfo.N < 4) then begin//判断数据的有效性 20081021
            New(DealOffInfo);
            DealOffInfo.sDealCharName:= sDealOffInfo.sDealCharName;
            DealOffInfo.sBuyCharName:= sDealOffInfo.sBuyCharName;
            DealOffInfo.dSellDateTime:= sDealOffInfo.dSellDateTime;
            DealOffInfo.nSellGold:= sDealOffInfo.nSellGold;
            DealOffInfo.UseItems:= sDealOffInfo.UseItems;
            DealOffInfo.N:= sDealOffInfo.N;
            sSellOffItemList.Add(DealOffInfo);
          end;
        end;
      except
      end;
      FileClose(FileHandle);
    end;
  end else begin
    FileHandle := FileCreate(sFileName);
    FileClose(FileHandle);
  end;
end;
//保存元宝寄售列表 20080317
procedure TFrmDB.SaveSellOffItemList();
var
  sFileName: string;
  FileHandle: Integer;
  DealOffInfo: pTDealOffInfo;
  I: Integer;
begin
  sFileName :=  g_Config.sEnvirDir + 'UserData\UserData.dat';
  if FileExists(sFileName) then DeleteFile(sFileName);
  FileHandle := FileCreate(sFileName);
  FileClose(FileHandle);
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
    if FileHandle > 0 then begin
      FileSeek(FileHandle, 0, 0);
      try
        if sSellOffItemList.Count > 0 then begin//20080629
          for I:= 0 to sSellOffItemList.Count -1 do begin
            DealOffInfo:=pTDealOffInfo(sSellOffItemList.Items[I]);
            FileWrite(FileHandle, DealOffInfo^, SizeOf(TDealOffInfo));
          end;
        end;
      except
      end;
      FileClose(FileHandle);
    end;
  end;
end;
//------------------------------------------------------------------------------
//读取套装装备数据 20080225
procedure TFrmDB.LoadSuitItemList();
var
  sFileName, sLineText: string;
  ItemCount,Note,Name,MaxHP,MaxMP,DC,MaxDC: string;
  MC,MaxMC,SC,MaxSC,AC,MaxAC,MAC,MaxMAC,HitPoint,SpeedPoint: string;
  HealthRecover,SpellRecover,RiskRate,btReserved,btReserved1: string;
  btReserved2,btReserved3,nEXPRATE,nPowerRate,nMagicRate: string;
  nSCRate,nACRate,nMACRate,nAntiMagic,nAntiPoison,nPoisonRecover: string;
  sboTeleport, sboParalysis, sboRevival, sboMagicShield, sboUnParalysis: String;//20080824
  LoadList: TStringList;
  SuitItem: pTSuitItem;
  I: Integer;
begin
  sFileName :=  g_Config.sEnvirDir + 'SuitItemList.txt';
  LoadList := TStringList.Create;
try
  if FileExists(sFileName) then begin
    SuitItemList.Clear;
    LoadList.LoadFromFile(sFileName);
    if LoadList.Count > 0 then begin//20080704
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := LoadList.Strings[I];
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sLineText := GetValidStr3(sLineText, ItemCount, [' ']);
          sLineText := GetValidStr3(sLineText, Note, [' ']);
          sLineText := GetValidStr3(sLineText, Name, [' ']);
          sLineText := GetValidStr3(sLineText, MaxHP, [' ']);
          sLineText := GetValidStr3(sLineText, MaxMP, [' ']);
          sLineText := GetValidStr3(sLineText, DC, [' ']);
          sLineText := GetValidStr3(sLineText, MaxDC, [' ']);
          sLineText := GetValidStr3(sLineText, MC, [' ']);
          sLineText := GetValidStr3(sLineText, MaxMC, [' ']);
          sLineText := GetValidStr3(sLineText, SC, [' ']);
          sLineText := GetValidStr3(sLineText, MaxSC, [' ']);
          sLineText := GetValidStr3(sLineText, AC, [' ']);
          sLineText := GetValidStr3(sLineText, MaxAC, [' ']);
          sLineText := GetValidStr3(sLineText, MAC, [' ']);
          sLineText := GetValidStr3(sLineText, MaxMAC, [' ']);
          sLineText := GetValidStr3(sLineText, HitPoint, [' ']);
          sLineText := GetValidStr3(sLineText, SpeedPoint, [' ']);
          sLineText := GetValidStr3(sLineText, HealthRecover, [' ']);
          sLineText := GetValidStr3(sLineText, SpellRecover, [' ']);
          sLineText := GetValidStr3(sLineText, RiskRate, [' ']);
          sLineText := GetValidStr3(sLineText, btReserved, [' ']);
          sLineText := GetValidStr3(sLineText, btReserved1, [' ']);
          sLineText := GetValidStr3(sLineText, btReserved2, [' ']);
          sLineText := GetValidStr3(sLineText, btReserved3, [' ']);
          sLineText := GetValidStr3(sLineText, nEXPRATE, [' ']);
          sLineText := GetValidStr3(sLineText, nPowerRate, [' ']);
          sLineText := GetValidStr3(sLineText, nMagicRate, [' ']);
          sLineText := GetValidStr3(sLineText, nSCRate, [' ']);
          sLineText := GetValidStr3(sLineText, nACRate, [' ']);
          sLineText := GetValidStr3(sLineText, nMACRate, [' ']);
          sLineText := GetValidStr3(sLineText, nAntiMagic, [' ']);
          sLineText := GetValidStr3(sLineText, nAntiPoison, [' ']);
          sLineText := GetValidStr3(sLineText, nPoisonRecover, [' ']);

          sLineText := GetValidStr3(sLineText, sboTeleport, [' ']);
          sLineText := GetValidStr3(sLineText, sboParalysis, [' ']);
          sLineText := GetValidStr3(sLineText, sboRevival, [' ']);
          sLineText := GetValidStr3(sLineText, sboMagicShield, [' ']);
          sLineText := GetValidStr3(sLineText, sboUnParalysis, [' ']);

          if (ItemCount <= '') or (Name = '') then Continue;

          New(SuitItem);
          SuitItem.ItemCount := StrToInt(ItemCount);
          SuitItem.Note := Note;
          SuitItem.Name := Name;
          SuitItem.MaxHP:= _MIN(100, Str_ToInt(MaxHP,0));//20080908
          SuitItem.MaxMP:= _MIN(100, Str_ToInt(MaxMP,0));//20080908
          SuitItem.DC:= Str_ToInt(DC,0);//攻击力
          SuitItem.MaxDC:= Str_ToInt(MaxDC,0);
          SuitItem.MC:= Str_ToInt(MC,0);//魔法
          SuitItem.MaxMC:= Str_ToInt(MaxMC,0);
          SuitItem.SC:= Str_ToInt(SC,0);//道术
          SuitItem.MaxSC:= Str_ToInt(MaxSC,0);
          SuitItem.AC:= Str_ToInt(AC,0);//防御
          SuitItem.MaxAC:= Str_ToInt(MaxAC,0);
          SuitItem.MAC:= Str_ToInt(MAC,0);//魔防
          SuitItem.MaxMAC:= Str_ToInt(MaxMAC,0);
          SuitItem.HitPoint:= Str_ToInt(HitPoint,0);//精确度
          SuitItem.SpeedPoint:= Str_ToInt(SpeedPoint,0);//敏捷度
          SuitItem.HealthRecover:= Str_ToInt(HealthRecover,0); //体力恢复
          SuitItem.SpellRecover:= Str_ToInt(SpellRecover,0); //魔法恢复
          SuitItem.RiskRate:= Str_ToInt(RiskRate,0); //爆率机率
          SuitItem.btReserved:= Str_ToInt(btReserved,0);//吸血(虹吸)
          SuitItem.btReserved1:= Str_ToInt(btReserved1,0); //保留
          SuitItem.btReserved2:= Str_ToInt(btReserved2,0); //保留
          SuitItem.btReserved3:= Str_ToInt(btReserved3,0); //保留
          SuitItem.nEXPRATE:= Str_ToInt(nEXPRATE,1);//经验倍数
          SuitItem.nPowerRate:= Str_ToInt(nPowerRate,1);//攻击倍数
          SuitItem.nMagicRate:= Str_ToInt(nMagicRate,1);//魔法倍数
          SuitItem.nSCRate:= Str_ToInt(nSCRate,1);//道术倍数
          SuitItem.nACRate:= Str_ToInt(nACRate,1);//防御倍数
          SuitItem.nMACRate:= Str_ToInt(nMACRate,1);//魔御倍数
          SuitItem.nAntiMagic:= Str_ToInt(nAntiMagic,0); //魔法躲避
          SuitItem.nAntiPoison:= Str_ToInt(nAntiPoison,0); //毒物躲避
          SuitItem.nPoisonRecover:= Str_ToInt(nPoisonRecover,0);//中毒恢复

          SuitItem.boTeleport := sboTeleport <> '0';//传送  20080824
          SuitItem.boParalysis := sboParalysis <> '0';//麻痹
          SuitItem.boRevival := sboRevival <> '0';//复活
          SuitItem.boMagicShield := sboMagicShield <> '0';//护身
          SuitItem. boUnParalysis := sboUnParalysis <> '0';//防麻痹
          SuitItemList.Add(SuitItem);
        end;
      end;//for
    end;
  end else begin
    LoadList.SaveToFile(sFileName);
  end;
  finally
  LoadList.Free;
  end;
end;
//------------------------------------------------------------------------------
//读取淬炼配置数据 20080502
procedure TFrmDB.LoadRefineItem();
var
  I: Integer;
  n1,n11,n2,n22,n3,n33,n4,n44,n5,n55,n6,n66,n7,n77,n8,n88,n9,n99,nA,nAA,nB,nBB,nC,nCC,nD,nDD,nE,nEE: string;
  s18, s20, s24, s25, s26, s27, s28: string;
  LoadList: TStringList;
  sFileName: string;
  List28: TList;
  TRefineItemInfo:pTRefineItemInfo;
begin
  sFileName :=g_Config.sEnvirDir +'RefineItem.txt';
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    g_RefineItemList.Clear;
    LoadList.LoadFromFile(sFileName);
    List28 := nil;
    s24 := '';
    for I := 0 to LoadList.Count - 1 do begin
      s18 := Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        if s18[1] = '[' then begin
          if List28 <> nil then g_RefineItemList.AddObject(s24, List28);
          List28 := TList.Create;
          ArrestStringEx(s18, '[', ']', s24);//S24-[]里的内容
        end else begin
          if List28 <> nil then begin
            s18 := GetValidStr3(s18, s20, [' ', #9]);//S20-物品名称 N14-数量
            s18 := GetValidStr3(s18, s25, [' ', #9]);//淬炼成功率
            s18 := GetValidStr3(s18, s26, [' ', #9]);//失败还原率
            s18 := GetValidStr3(s18, s27, [' ', #9]);//火云石是否消失 0-减少1持久,1-消失
            s18 := GetValidStr3(s18, s28, [' ', #9]);//极品机率

            s18 := GetValidStr3(s18, n1,  ['-',',', #9]);//各属性值及难度
            s18 := GetValidStr3(s18, n11, ['-',',', #9]);
            s18 := GetValidStr3(s18, n2,  ['-',',', #9]);
            s18 := GetValidStr3(s18, n22, ['-',',', #9]);
            s18 := GetValidStr3(s18, n3,  ['-',',', #9]);
            s18 := GetValidStr3(s18, n33, ['-',',', #9]);
            s18 := GetValidStr3(s18, n4,  ['-',',', #9]);
            s18 := GetValidStr3(s18, n44, ['-',',', #9]);
            s18 := GetValidStr3(s18, n5,  ['-',',', #9]);
            s18 := GetValidStr3(s18, n55, ['-',',', #9]);
            s18 := GetValidStr3(s18, n6,  ['-',',', #9]);
            s18 := GetValidStr3(s18, n66, ['-',',', #9]);
            s18 := GetValidStr3(s18, n7,  ['-',',', #9]);
            s18 := GetValidStr3(s18, n77, ['-',',', #9]);
            s18 := GetValidStr3(s18, n8,  ['-',',', #9]);
            s18 := GetValidStr3(s18, n88, ['-',',', #9]);
            s18 := GetValidStr3(s18, n9,  ['-',',', #9]);
            s18 := GetValidStr3(s18, n99, ['-',',', #9]);
            s18 := GetValidStr3(s18, nA,  ['-',',', #9]);
            s18 := GetValidStr3(s18, nAA, ['-',',', #9]);
            s18 := GetValidStr3(s18, nB,  ['-',',', #9]);
            s18 := GetValidStr3(s18, nBB, ['-',',', #9]);
            s18 := GetValidStr3(s18, nC,  ['-',',', #9]);
            s18 := GetValidStr3(s18, nCC, ['-',',', #9]);
            s18 := GetValidStr3(s18, nD,  ['-',',', #9]);
            s18 := GetValidStr3(s18, nDD, ['-',',', #9]);
            s18 := GetValidStr3(s18, nE,  ['-',',', #9]);
            s18 := GetValidStr3(s18, nEE, ['-',',', #9]);

            if s20 <> '' then begin
              New(TRefineItemInfo);
              TRefineItemInfo.sItemName:= s20;
              TRefineItemInfo.nRefineRate:= Str_ToInt(Trim(s25), 0);
              TRefineItemInfo.nReductionRate:= Str_ToInt(Trim(s26), 0);
              TRefineItemInfo.boDisappear:= Str_ToInt(Trim(s27), 0) = 0;//0-减持久 1-消失
              TRefineItemInfo.nNeedRate:= Str_ToInt(Trim(s28), 0);
              TRefineItemInfo.nAttribute[0].nPoints:=Str_ToInt(Trim(n1), 0);
              TRefineItemInfo.nAttribute[0].nDifficult:=Str_ToInt(Trim(n11), 0);
              TRefineItemInfo.nAttribute[1].nPoints:=Str_ToInt(Trim(n2), 0);
              TRefineItemInfo.nAttribute[1].nDifficult:=Str_ToInt(Trim(n22), 0);
              TRefineItemInfo.nAttribute[2].nPoints:=Str_ToInt(Trim(n3), 0);
              TRefineItemInfo.nAttribute[2].nDifficult:=Str_ToInt(Trim(n33), 0);
              TRefineItemInfo.nAttribute[3].nPoints:=Str_ToInt(Trim(n4), 0);
              TRefineItemInfo.nAttribute[3].nDifficult:=Str_ToInt(Trim(n44), 0);
              TRefineItemInfo.nAttribute[4].nPoints:=Str_ToInt(Trim(n5), 0);
              TRefineItemInfo.nAttribute[4].nDifficult:=Str_ToInt(Trim(n55), 0);
              TRefineItemInfo.nAttribute[5].nPoints:=Str_ToInt(Trim(n6), 0);
              TRefineItemInfo.nAttribute[5].nDifficult:=Str_ToInt(Trim(n66), 0);
              TRefineItemInfo.nAttribute[6].nPoints:=Str_ToInt(Trim(n7), 0);
              TRefineItemInfo.nAttribute[6].nDifficult:=Str_ToInt(Trim(n77), 0);
              TRefineItemInfo.nAttribute[7].nPoints:=Str_ToInt(Trim(n8), 0);
              TRefineItemInfo.nAttribute[7].nDifficult:=Str_ToInt(Trim(n88), 0);
              TRefineItemInfo.nAttribute[8].nPoints:=Str_ToInt(Trim(n9), 0);
              TRefineItemInfo.nAttribute[8].nDifficult:=Str_ToInt(Trim(n99), 0);
              TRefineItemInfo.nAttribute[9].nPoints:=Str_ToInt(Trim(nA), 0);
              TRefineItemInfo.nAttribute[9].nDifficult:=Str_ToInt(Trim(nAA), 0);
              TRefineItemInfo.nAttribute[10].nPoints:=Str_ToInt(Trim(nB), 0);
              TRefineItemInfo.nAttribute[10].nDifficult:=Str_ToInt(Trim(nBB), 0);
              TRefineItemInfo.nAttribute[11].nPoints:=Str_ToInt(Trim(nC), 0);
              TRefineItemInfo.nAttribute[11].nDifficult:=Str_ToInt(Trim(nCC), 0);
              TRefineItemInfo.nAttribute[12].nPoints:=Str_ToInt(Trim(nD), 0);
              TRefineItemInfo.nAttribute[12].nDifficult:=Str_ToInt(Trim(nDD), 0);
              TRefineItemInfo.nAttribute[13].nPoints:=Str_ToInt(Trim(nE), 0);
              TRefineItemInfo.nAttribute[13].nDifficult:=Str_ToInt(Trim(nEE), 0);
              List28.Add(TRefineItemInfo);
            end;
          end;
        end;
      end;
    end; // for
    if List28 <> nil then g_RefineItemList.AddObject(s24, List28);
  end else begin
    LoadList.Add(';此为淬炼配置文件');
    LoadList.Add(';如何设置请查看帮助文档');
    LoadList.Add(';淬炼后的物品 淬炼成功几率 失败还原几率 火云石是否消失 淬炼极品属性几率 淬炼极品属性设置');
    LoadList.Add(';[火云石+黑铁头盔+雷霆战戒]');
    LoadList.Add(';星王魔戒 30 30 0 1 0-5,0-5,0-5,4-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,');
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;
//------------------------------------------------------------------------------

//假字符串加解密函数,实际没有使用这个算法 20071225
Function EncryptText(Text: String): String;
  function EncryptKey(key: string): string;//加密函数
  var i: Integer;
  begin
    for i:=1 to length(key) do
      result := result + chr(ord(key[i]) xor length(key)*i*i)
  end;
Var str: string;
Begin
  Str:=EncryptKey(Text);
  Result := Text;
End;

function DeCodeString(sSrc: string): string;
var
  Dest: array[0..1024 * 2] of Char;
begin
  if (sSrc = '') or (Length(sSrc) > 2048) then Exit;//20081203 防止组数越界
  if (nDeCryptString >= 0) and Assigned(PlugProcArray[nDeCryptString].nProcAddr) then begin
    FillChar(Dest, SizeOf(Dest), 0);
    TDeCryptString(PlugProcArray[nDeCryptString].nProcAddr)(@sSrc[1], @Dest, Length(sSrc));
    Result := StrPas(PChar(@Dest));
    Exit;
  end;
  Result := sSrc;
end;

procedure TFrmDB.DeCodeStringList(StringList: TStringList);
var
  I: Integer;
  sLine: string;
begin
  if StringList.Count > 0 then begin
    sLine := StringList.Strings[0];
    if not CompareLStr(sLine, sENCYPTSCRIPTFLAG, 18{Length(sENCYPTSCRIPTFLAG)}) then begin
      Exit;
    end;
  end;

  for I := 0 to StringList.Count - 1 do begin
    sLine := StringList.Strings[I];
    sLine := DeCodeString(sLine);
    sLine := EncryptText(sLine);
    sLine := addStringList(sLine);//20080217 脚本解密函数,SystemModule.dll输出
    StringList.Strings[I] := sLine;
  end;
end;

//脚本插件注册后,则可使用此函数 20081017
procedure TFrmDB.SetStringList(StringList: TStringList);
var
  I: Integer;
  sLine: string;
begin
  if StringList.Count > 0 then begin
    sLine := StringList.Strings[0];
    if not CompareLStr(sLine, sENCYPTSCRIPTFLAG, 18) then begin
      Exit;
    end;
  end;
  if (nGetIPString >= 0) and Assigned(PlugProcArray[nGetIPString].nProcAddr) then begin
    if TGetIPString(PlugProcArray[nGetIPString].nProcAddr) then begin//注册过的
      for I := 0 to StringList.Count - 1 do begin
        sLine := StringList.Strings[I];
        sLine := DeCodeString(sLine);
        sLine := EncryptText(sLine);
        sLine := addStringList(sLine);//脚本解密函数,SystemModule.dll输出
        StringList.Strings[I] := sLine;
      end;
    end;
  end;
end;

constructor TFrmDB.Create();
begin
  CoInitialize(nil);

{$IF DBTYPE = BDE}
  Query := TQuery.Create(nil);
{$ELSE}
  Query := TADOQuery.Create(nil);
{$IFEND}
end;

destructor TFrmDB.Destroy;
begin
  Query.Free;
  CoUnInitialize;
  inherited;
end;

initialization
  begin
    nDeCryptString := AddToPulgProcTable(Base64DecodeStr('RGVDcnlwdFN0cmluZw=='),0);//DeCryptString  20080303
    nGetIPString := AddToPulgProcTable(Base64DecodeStr('R2V0SVBIYW5kbGU='),7);//GetIPHandle 检测脚本插件是否注册 20081016
  end;

finalization
  begin

  end;

end.

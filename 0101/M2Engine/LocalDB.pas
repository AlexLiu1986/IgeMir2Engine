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
    procedure SetStringList(StringList: TStringList);//�ű����ע���,���ʹ�ô˺��� 20081017
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

    procedure LoadBoxsList;//��ȡ�����б� 20080114
    procedure LoadSuitItemList();//��ȡ��װװ������ 20080225
    procedure LoadSellOffItemList(); //��ȡԪ�������б� 20080316
    procedure SaveSellOffItemList();//����Ԫ�������б� 20080317
    procedure LoadRefineItem();//��ȡ������������ 20080502

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
//��ȡ��Ʒ����
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
          Idx := Query.FieldByName('Idx').AsInteger;//���
          StdItem.Name := Query.FieldByName('Name').AsString;//����
          StdItem.StdMode := Query.FieldByName('StdMode').AsInteger;//�����
          StdItem.Shape := Query.FieldByName('Shape').AsInteger;//װ�����
          StdItem.Weight := Query.FieldByName('Weight').AsInteger;//����
          StdItem.AniCount := Query.FieldByName('AniCount').AsInteger;
          StdItem.Source := Query.FieldByName('Source').AsInteger;
          StdItem.Reserved := Query.FieldByName('Reserved').AsInteger;//����
          StdItem.Looks := Query.FieldByName('Looks').AsInteger;//��Ʒ���
          StdItem.DuraMax := Word(Query.FieldByName('DuraMax').AsInteger);//�־���
          StdItem.AC := MakeLong(Round(Query.FieldByName('Ac').AsInteger * (g_Config.nItemsACPowerRate / 10)), Round(Query.FieldByName('Ac2').AsInteger * (g_Config.nItemsACPowerRate / 10)));
          StdItem.MAC := MakeLong(Round(Query.FieldByName('Mac').AsInteger * (g_Config.nItemsACPowerRate / 10)), Round(Query.FieldByName('MAc2').AsInteger * (g_Config.nItemsACPowerRate / 10)));
          StdItem.DC := MakeLong(Round(Query.FieldByName('Dc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Dc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
          StdItem.MC := MakeLong(Round(Query.FieldByName('Mc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Mc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
          StdItem.SC := MakeLong(Round(Query.FieldByName('Sc').AsInteger * (g_Config.nItemsPowerRate / 10)), Round(Query.FieldByName('Sc2').AsInteger * (g_Config.nItemsPowerRate / 10)));
          StdItem.Need := Query.FieldByName('Need').AsInteger;//��������
          StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;//��Ҫ�ȼ�
          StdItem.Price := Query.FieldByName('Price').AsInteger;//�۸�
          //StdItem.Stock := Query.FieldByName('Stock').AsInteger;//��� 20080610
          StdItem.NeedIdentify := GetGameLogItemNameList(StdItem.Name);
          //if Query.FindField('Desc') <> nil then //20080805 ע��
          //   StdItem.sDesc:= Trim(Query.FieldByName('Desc').AsString);//��Ʒ˵�� 20080702
          if UserEngine.StdItemList.Count = Idx then begin
            UserEngine.StdItemList.Add(StdItem);
            Result := 1;
          end else begin
            Memo.Lines.Add(Format('������Ʒ(Idx:%d Name:%s)����ʧ�ܣ�����', [Idx, StdItem.Name]));
            Result := -100;
            Exit;
          end;
          Query.Next;
        end;//for
      end;
      g_boGameLogGold := GetGameLogItemNameList(sSTRING_GOLDNAME) = 1;
      g_boGameLogHumanDie := GetGameLogItemNameList(g_sHumanDieEvent) = 1;
      g_boGameLogGameGold := GetGameLogItemNameList(g_Config.sGameGoldName) = 1;
      g_boGameLogGameDiaMond := GetGameLogItemNameList(g_Config.sGameDiaMond) = 1;//�Ƿ�д����־(�������ʯ) 20071226
      g_boGameLogGameGird := GetGameLogItemNameList(g_Config.sGameGird) = 1;//�Ƿ�д����־(�������) 20071226
      g_boGameLogGameGlory := GetGameLogItemNameList(g_Config.sGameGlory) = 1;//�Ƿ�д����־(��������ֵ) 20080511
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
  function IsStrCount(str:string):Integer;//�ж��м���')'�� 20080727
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
    //���ص�ͼ����
    for I := 0 to LoadList.Count - 1 do begin
      s30 := LoadList.Strings[I];
      if (s30 <> '') and (s30[1] = '[') then begin
        sMapName := '';
        MapFlag.boSAFE := False;
        s30 := ArrestStringEx(s30, '[', ']', sMapName);
        sMapDesc := GetValidStrCap(sMapName, sMapName, [' ', ',', #9]);
        sMainMapName := Trim(GetValidStr3(sMapName, sMapName, ['|', '/', '\', #9])); //��ȡ�ظ����õ�ͼ
        if (sMapDesc <> '') and (sMapDesc[1] = '"') then ArrestStringEx(sMapDesc, '"', '"', sMapDesc);
        s4C := Trim(GetValidStr3(sMapDesc, sMapDesc, [' ', ',', #9]));
        nServerIndex := Str_ToInt(s4C, 0);
        if sMapName = '' then Continue;
        FillChar(MapFlag, SizeOf(TMapFlag), #0);
        //MapFlag.nL := 1;//20080815 ע��
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
          if CompareText(s34, 'FIGHT2') = 0 then begin//PK��װ����ͼ 20080525
            MapFlag.boFIGHT2 := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT3') = 0 then begin
            MapFlag.boFIGHT3 := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHT4') = 0 then begin//��ս��ͼ 20080706
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
          if CompareLStr(s34, 'KILLFUNC', 8{Length('KILLFUNC')}) then begin//20080415 ��ͼɱ�˴���
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
          if CompareLStr(s34, 'NEEDLEVELTIME', 13) then begin//ѩ���ͼ����,�жϵȼ�,��ͼʱ�� 20081228
            MapFlag.boNEEDLEVELTIME := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.nNEEDLEVELPOINT := Str_ToInt(s38, 0);//����ͼ��͵ȼ�
            Continue;
          end;
          //ʱ�䵽���ͻ�ָ����ͼ������ 20081230 ѩ���ͼ
          if CompareLStr(s34, 'TIMEMOVEHOME', 12) then begin
            MapFlag.boMoveToHome := True;
            ArrestStringEx(s34, '(', ')', s38);
            s38:= GetValidStr3(s38, s4C, ['/']);
            MapFlag.sMoveToHomeMap := s4C;//���͵ĵ�ͼ��
            s38:= GetValidStr3(s38, s4C, ['/']);
            MapFlag.nMoveToHomeX := Str_ToInt(s4c, 0);//���͵ĵ�ͼX
            MapFlag.nMoveToHomeY:= Str_ToInt(s38, 0);//���͵ĵ�ͼY
            Continue;
          end;
//��ͼ���� NOCALLHERO (��ֹ�ٻ�Ӣ�ۣ����ٻ�Ӣ�۽��Զ���ʧ)  20080124
          if CompareText(s34, 'NOCALLHERO') = 0 then begin
            MapFlag.boNoCALLHERO := True;
            Continue;
          end;
//��ֹӢ���ػ� 20080629
          if CompareText(s34, 'NOHEROPROTECT') = 0 then begin
            MapFlag.boNoHeroPROTECT := True;
            Continue;
          end;
//��ͼ���� NODROPITEM ��ֹ��������Ʒ 20080503
          if CompareText(s34, 'NODROPITEM') = 0 then begin
            MapFlag.boNODROPITEM := True;
            Continue;
          end;
//��ͼ���� MISSION (������ʹ���κ���Ʒ�ͼ��ܣ����ұ����ڸõ�ͼ���Զ���ʧ�����ܹ���)  20080124
          if CompareText(s34, 'MISSION') = 0 then begin 
            MapFlag.boMISSION := True;
            Continue;
          end;
//------------------------------------------------------------------------------
          if CompareText(s34, 'RUNHUMAN') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'RUNHUMAN', 8{Length('RUNHUMAN')}) then begin
            MapFlag.boRUNHUMAN := True;
            Continue;
          end;
          if CompareText(s34, 'RUNMON') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'RUNMON', 6{Length('RUNMON')}) then begin
            MapFlag.boRUNMON := True;
            Continue;
          end;
          if CompareText(s34, 'NEEDHOLE') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'NEEDHOLE', 8{Length('NEEDHOLE')}) then begin
            MapFlag.boNEEDHOLE := True;
            Continue;
          end;
          if CompareText(s34, 'NORECALL') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'NORECALL', 8{Length('NORECALL')}) then begin
            MapFlag.boNORECALL := True;
            Continue;
          end;
          if CompareText(s34, 'NOGUILDRECALL') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'NOGUILDRECALL', 13{Length('NOGUILDRECALL')}) then begin
            MapFlag.boNOGUILDRECALL := True;
            Continue;
          end;
          if CompareText(s34, 'NODEARRECALL') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'NODEARRECALL', 12{Length('NODEARRECALL')}) then begin
            MapFlag.boNODEARRECALL := True;
            Continue;
          end;
          if CompareText(s34, 'NOMASTERRECALL') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'NOMASTERRECALL', 14{Length('NOMASTERRECALL')}) then begin
            MapFlag.boNOMASTERRECALL := True;
            Continue;
          end;
          if CompareText(s34, 'NORANDOMMOVE') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'NORANDOMMOVE', 12{Length('NORANDOMMOVE')}) then begin
            MapFlag.boNORANDOMMOVE := True;
            Continue;
          end;
          if CompareText(s34, 'NODRUG') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'NODRUG', 6{Length('NODRUG')}) then begin
            MapFlag.boNODRUG := True;
            Continue;
          end;
          if CompareText(s34, 'NOMANNOMON') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'NOMANNOMON', 10{length('NOMANNOMON')}) then  begin//û���˾Ͳ�ˢ�� 20080525
            MapFlag.boNoManNoMon := True;
            Continue;
          end;
          if CompareText(s34, 'MINE') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'MINE', 4{Length('MINE')}) then begin
            MapFlag.boMINE := True;
            Continue;
          end;
          if CompareText(s34, 'NOPOSITIONMOVE') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'NOPOSITIONMOVE', 14{Length('NOPOSITIONMOVE')}) then begin
            MapFlag.boNOPOSITIONMOVE := True;
            Continue;
          end;
          if CompareText(s34, 'AUTOMAKEMONSTER') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'AUTOMAKEMONSTER', 15{Length('AUTOMAKEMONSTER')}) then begin
            MapFlag.boAutoMakeMonster := True;
            Continue;
          end;
          if CompareText(s34, 'FIGHTPK') = 0 then begin //20080815 �޸�
          //if CompareLStr(s34, 'FIGHTPK', 7{Length('FIGHTPK')}) then begin //PK���Ա�װ��������
            MapFlag.boFIGHTPK := True;
            Continue;
          end;

          if CompareLStr(s34,'THUNDER',7{length('THUNDER')}) then begin//20080327 ����
            ArrestStringEx(s34,'(',')',s38);
            MapFlag.nThunder := Str_ToInt(s38,-1);
            Continue;
          end;
          if CompareLStr(s34,'LAVA',4{length('LAVA')}) then begin//20080327 ����ð�ҽ�
            ArrestStringEx(s34,'(',')',s38);
            MapFlag.nLava := Str_ToInt(s38,-1);
            Continue;
          end;

          if CompareLStr(s34, 'NOTALLOWUSEMAGIC', 16{Length('NOTALLOWUSEMAGIC')}) then begin //���Ӳ�����ʹ��ħ��
            MapFlag.boNOTALLOWUSEMAGIC := True;
            ArrestStringEx(s34, '(', ')', s38);
            MapFlag.sUnAllowMagicText := Trim(s38);
            Continue;
          end;

          if CompareLStr(s34, 'NOTALLOWUSEITEMS', 16{Length('NOTALLOWUSEITEMS')}) then begin //���Ӳ�����ʹ����Ʒ
            MapFlag.boUnAllowStdItems := True;
            if IsStrCount(s34) > 1 then begin//�ж��м���')' 20080727
              s38:=Copy(s34, pos('(',s34)+ 1, Length(s34)-(pos('(',s34)+ 1));
            end else ArrestStringEx(s34, '(', ')', s38);
            MapFlag.sUnAllowStdItemsText := Trim(s38);
            Continue;
          end;
          {if (s34[1] = 'L') then begin //20080815 ע��
            MapFlag.nL := Str_ToInt(Copy(s34, 2, Length(s34) - 1), 1);
          end;}
        end;
        if g_MapManager.AddMapInfo(sMapName, sMainMapName, sMapDesc, nServerIndex, @MapFlag, QuestNPC) = nil then Result := -10;
      end else begin  //20080520 �޸�
        //���ص�ͼ���ӵ�
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
{    //���ص�ͼ���ӵ�
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
      SaveList.Add(';�˽�Ϊ���ܽű�������ʵ�ָ�����ű��йصĹ���');
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
      SaveList.Add(';�˽�Ϊ��¼�ű�������ÿ�ε�¼ʱ����ִ�д˽ű������������ʼ���ö����Է��ڴ˽ű��С�');
      SaveList.Add(';�޸Ľű����ݣ�����@ReloadManage�������¼��ظýű���������������');
      SaveList.Add('[@Login]');
      SaveList.Add('#if');
      SaveList.Add('#act');
      //    tSaveList.Add(';����10��ɱ�־���');
      //    tSaveList.Add(';CANGETEXP 1 10');
      SaveList.Add('#say');
      SaveList.Add('IGE�Ƽ���¼�ű����гɹ�����ӭ���뱾��Ϸ������\ \');
      SaveList.Add('<�ر�/@exit> \ \');
      SaveList.Add('��¼�ű��ļ�λ��: \');
      SaveList.Add(sShowFile + '\');
      SaveList.Add('�ű����������а��Լ���Ҫ���޸ġ�');
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
      tSaveList.Add(';�˽�Ϊ������ר�ýű������ڻ����˴������õĽű���');
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
//�ű�   ��ͼ     ����X   ����Y   NPC��ʾ��   ��ʶ   ����  �Ƿ�Ǳ�  �ܷ��ƶ� �Ƿ��ɫ ��ɫʱ��
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
            tMerchantNPC.m_sCharName := sName;//NPC����
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
    if MiniMapList.Count > 0 then MiniMapList.Clear;//20080831 �޸�
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
        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//��ͼ����
        MonGenInfo.sMapName := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//X
        MonGenInfo.nX := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//Y
        MonGenInfo.nY := Str_ToInt(sData, 0);

        sLineText := GetValidStrCap(sLineText, sData, [' ', #9]);//������
        if (sData <> '') and (sData[1] = '"') then ArrestStringEx(sData, '"', '"', sData);

        MonGenInfo.sMonName := sData;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//��Χ
        MonGenInfo.nRange := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//����
        MonGenInfo.nCount := Str_ToInt(sData, 0);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//ʱ��
        //MonGenInfo.dwZenTime := Str_ToInt(sData, -1) * 60000{60 * 1000};
        MonGenInfo.dwZenTime := Str_ToInt(sData, 1) * 60000{60 * 1000};//20081009 �޸�

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//�ڹ���,����������������ֵ 20081001
        MonGenInfo.boIsNGMon := Str_ToInt(sData, 0) <> 0 ;

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);//�Զ������ֵ���ɫ 20080810
        MonGenInfo.nNameColor := Str_ToInt(sData, 255);

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nMissionGenRate := Str_ToInt(sData, 0); //��������ˢ�»��� 1 -100

        sLineText := GetValidStr3(sLineText, sData, [' ', #9]);
        MonGenInfo.nChangeColorType := Str_ToInt(sData, -1); //��ɫ2007-02-01����

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
        Monster.btLifeAttrib := Query.FieldByName('Undead').AsInteger;//����ϵ 1-����ϵ
        Monster.wCoolEye := Query.FieldByName('CoolEye').AsInteger;
        Monster.dwExp := Query.FieldByName('Exp').AsInteger;
        //���Ż��ǽ��״̬��HPֵ�йأ����HP�쳣�������³�ǽ��ʾ����
        if (Monster.btRace=110) or (Monster.btRace=111) then begin //���Ϊ��ǽ�������HP���ӱ� 20080829
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
//��ȡ���ﱬ���ļ�
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
//;����  ����  ��ͼ   x   y  ��Χ  ͼ�� �Ƿ��ɫ ��ɫʱ�� 
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
        s18 := GetValidStrCap(s18, s20, [' ', #9]);//����
        if (s20 <> '') and (s20[1] = '"') then ArrestStringEx(s20, '"', '"', s20);
        s18 := GetValidStr3(s18, s24, [' ', #9]);//NPC����
        s18 := GetValidStr3(s18, s28, [' ', #9]);//��ͼ
        s18 := GetValidStr3(s18, s2C, [' ', #9]);//X
        s18 := GetValidStr3(s18, s30, [' ', #9]);//Y
        s18 := GetValidStr3(s18, s34, [' ', #9]);//��Χ
        s18 := GetValidStr3(s18, s38, [' ', #9]);//ͼ��
        s18 := GetValidStr3(s18, s40, [' ', #9]);//�Ƿ��ɫ
        s18 := GetValidStr3(s18, s42, [' ', #9]);//��ɫʱ��
        if (s20 <> '') and (s28 <> '') and (s38 <> '') then begin
          NPC := nil;
          case Str_ToInt(s24, 0) of
            0: NPC := TMerchant.Create;//��ͨNPC
            1: NPC := TGuildOfficial.Create;//�л�NPC
            2: NPC := TCastleOfficial.Create;//�Ǳ�NPC
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
//��ȡ�����Ʒ�ļ�
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
          Result := -I; //��Ҫȡ����
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
//��ȡ�ű��ļ�
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
                  //bo1D := False;//δʹ�� 20080723
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
(*  //��ȡԶ�̽ű� 20080706
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
            MainOutMessage('�ű�����, ����ʧ��: ' + s20 +'  '+ s18);
          end;
        end;
       (* if CompareLStr(s14, '#URLCALL', 8) then begin//20080706 ��ȡԶ�̽ű�
          s14 := ArrestStringEx(s14, '[', ']', s1C);
          s20 := Trim(s1C);//ȡ��Զ�̽ű�HTTP
          s18 := Trim(s14);
          if LoadUrlCallScript(s20, s18, LoadList) then begin
            LoadList.Strings[I] := '#ACT';
            LoadList.Insert(I + 1, 'goto ' + s18);
          end else begin
            MainOutMessage('�ű�����, ����ʧ��: ' + s20 +'  '+ s18);
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
            MainOutMessage('�ű�����, ����ʧ��: ' + s28);
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
    if sCmd = sSC_CHECKGAMEDIAMOND then begin //�����ʯ���� 20071227
      nCMDCode := nSC_CHECKGAMEDIAMOND;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGIRD then begin //���������� 20071227
      nCMDCode := nSC_CHECKGAMEGIRD;
      goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGLORY then begin //�������ֵ 20080511
      nCMDCode := nSC_CHECKGAMEGLORY;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKSKILLLEVEL then begin //��鼼�ܵȼ� 20080512
      nCMDCode := nSC_CHECKSKILLLEVEL;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKMAPMOBCOUNT then begin //����ͼָ������ָ�����ƹ������� 20080123
      nCMDCode := nSC_CHECKMAPMOBCOUNT;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKSIDESLAVENAME then begin //���������Χ�Լ��������� 20080425
      nCMDCode := nSC_CHECKSIDESLAVENAME;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKLISTTEXT then begin //����ļ��Ƿ����ָ���ı� 20080427
      nCMDCode := nSC_CHECKLISTTEXT;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKCURRENTDATE then begin //��⵱ǰ�����Ƿ�С�ڴ��ڵ���ָ�������� 20080416
      nCMDCode := nSC_CHECKCURRENTDATE;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKMASTERONLINE then begin //���ʦ������ͽ�ܣ��Ƿ����� 20080416
      nCMDCode := nSC_CHECKMASTERONLINE;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKDEARONLINE then begin //������һ���Ƿ����� 20080416
      nCMDCode := nSC_CHECKDEARONLINE;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKMASTERONMAP then begin //���ʦ��(��ͽ��)�Ƿ���ָ���ĵ�ͼ�� 20080416
      nCMDCode := nSC_CHECKMASTERONMAP;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKDEARONMAP then begin //������һ���Ƿ���ָ���ĵ�ͼ�� 20080416
      nCMDCode := nSC_CHECKDEARONMAP;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKPOSEISPRENTICE then begin //�������Ƿ�Ϊ�Լ���ͽ�� 20080416
      nCMDCode := nSC_CHECKPOSEISPRENTICE;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_CHECKCASTLEWAR then begin //����Ƿ��ڹ����ڼ� 20080422
      nCMDCode := nSC_CHECKCASTLEWAR;
      goto L001;
    end;
//-------------------------------------------------------------------------
    if sCmd = sSC_FINDMAPPATH then begin //���õ�ͼ������XYֵ 20080124
      nCMDCode := nSC_FINDMAPPATH;
      goto L001;
    end;
//--------------------------------------------------------------------------
    if sCmd = sSC_CHECKHEROLOYAL then begin //���Ӣ�۵��ҳ϶� 20080109
      nCMDCode := nSC_CHECKHEROLOYAL;
      goto L001;
    end;
//--------------------------------------------------------------------------
    if sCmd = sISONMAKEWINE then begin//�ж��Ƿ��������־� 20080620
      nCMDCode := nISONMAKEWINE;
      goto L001;
    end;
//--------------------------------------------------------------------------
    if sCmd = sCHECKGUILDFOUNTAIN  then begin//�ж��Ƿ����л�Ȫˮ�ֿ� 20080624
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
    if sCmd = sSC_ISONMAP then begin//����ͼ����  20080426
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
    if sCmd = sHEROCHECKSKILL then begin //���Ӣ�ۼ��� 20080423
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

    if sCmd = sSC_CHECKMINE then begin //���󴿶�  20080324
      nCMDCode := nSC_CHECKMINE;
      goto L001;
    end;

    if sCmd = sSC_CHECKMAKEWINE then begin //���Ƶ�Ʒ�� 20080806
      nCMDCode := nSC_CHECKMAKEWINE;
      goto L001;
    end;

    if sCmd = sSC_CHECKITEMLEVEL then begin //���װ���������� 20080816
      nCMDCode := nSC_CHECKITEMLEVEL;
      goto L001;
    end;
//------------------------�������-----------------------------------
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
    if sCmd = sSC_CHECKHEROPKPOINT then begin //���Ӣ��PKֵ  20080304
      nCMDCode := nSC_CHECKHEROPKPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHECKCODELIST then begin //����ļ���ı���  20080410
      nCMDCode := nSC_CHECKCODELIST;
      goto L001;
    end;
    if sCmd = sCHECKITEMSTATE then begin //���װ����״̬ 20080312
      nCMDCode := nCHECKITEMSTATE;
      goto L001;
    end;
    if sCmd = sCHECKITEMSNAME then begin //���ָ��װ��λ����Ʒ���� 20080825
      nCMDCode := nCHECKITEMSNAME;
      goto L001;
    end;
    if sCmd = sCHECKGUILDFOUNTAINVALUE then begin//����л��Ȫ�� 20081017
      nCMDCode := nCHECKGUILDFOUNTAINVALUE;
      goto L001;
    end;
    if sCmd = sCHECKNGLEVEL then begin//����ɫ�ڹ��ȼ� 20081223
      nCMDCode := nCHECKNGLEVEL;
      goto L001;
    end;
    if sCmd = sKILLBYHUM then begin //����Ƿ�������ɱ 20080826
      nCMDCode := nKILLBYHUM;
      goto L001;
    end;
    if sCmd = sISHIGH then begin //����������������������� 20080313
      nCMDCode := nISHIGH;
      goto L001;
    end;
    if sCmd = sSC_CHECKHEROJOB then begin
      nCMDCode := nSC_CHECKHEROJOB;
      goto L001;
    end;
    if sCmd = sSC_CHANGREADNG then begin//����ɫ�Ƿ�ѧ���ڹ� 20081002
      nCMDCode := nSC_CHANGREADNG;
      goto L001;
    end;
   { if nCMDCode <= 0 then begin //20080813 ע��
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
    if sCmd = sCREATEFILE then begin//�����ı��ļ� 20081226
      nCMDCode := nCREATEFILE;
      goto L001;
    end;
    if sCmd = sSENDTOPMSG then begin //���˹�������
      nCMDCode := nSENDTOPMSG;
      goto L001;
    end;
    if sCmd = sSENDCENTERMSG then begin //��Ļ������ʾ����
      nCMDCode := nSENDCENTERMSG;
      goto L001;
    end;
    if sCmd = sSENDEDITTOPMSG then begin //����򶥶˹���
      nCMDCode := nSENDEDITTOPMSG;
      goto L001;
    end;
    if sCmd = sOPENBOOKS then begin //�������� 20080119
      nCMDCode := nOPENBOOKS;
      goto L001;
    end;
    if sCmd = sOPENYBDEAL then begin //��ͨԪ������ 20080316
      nCMDCode := nOPENYBDEAL;
      goto L001;
    end;
    if sCmd = sQUERYYBSELL then begin //��ѯ����Ԫ�����۳��۵���Ʒ20080317
      nCMDCode := nQUERYYBSELL;
      goto L001;
    end;
    if sCmd = sQUERYYBDEAL then begin //��ѯ���ԵĹ�����Ʒ 20080317
      nCMDCode := nQUERYYBDEAL;
      goto L001;
    end;
    if sCmd = sTHROUGHHUM then begin //�ı䴩��ģʽ 20080221
      nCMDCode := nTHROUGHHUM;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sSetOnTimer then begin//���˶�ʱ��(����) 20080510
      nCMDCode := nSetOnTimer;
      goto L001;
    end;
    if sCmd = sSetOffTimer then begin//ֹͣ��ʱ�� 20080510
      nCMDCode := nSetOffTimer;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sGETSORTNAME then begin//ȡָ�����а�ָ��������������� 20080531
      nCMDCode := nGETSORTNAME;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sWEBBROWSER then begin//����ָ����վ��ַ 20080602
      nCMDCode := nWEBBROWSER;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sADDATTACKSABUKALL then begin//���������лṥ�� 20080609
      nCMDCode := nADDATTACKSABUKALL;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sKICKALLPLAY then begin//�߳��������������� 20080609
      nCMDCode := nKICKALLPLAY;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sREPAIRALL then begin//����ȫ��װ�� 20080613
      nCMDCode := nREPAIRALL;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sAUTOGOTOXY then begin//�Զ�Ѱ· 20080617
      nCMDCode := nAUTOGOTOXY;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sCHANGESKILL then begin//�޸�ħ��ID 20080624
      nCMDCode := nCHANGESKILL;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sOPENMAKEWINE then begin//����ƴ��� 20080619
      nCMDCode := nOPENMAKEWINE;
      goto L001;
    end;
    if sCmd = sGETGOODMAKEWINE then begin//ȡ����õľ� 20080620
      nCMDCode := nGETGOODMAKEWINE;
      goto L001;
    end;
    if sCmd = sDECMAKEWINETIME then begin//������Ƶ�ʱ�� 20080620
      nCMDCode := nDECMAKEWINETIME;
      goto L001;
    end;
    if sCmd = sREADSKILLNG then begin//ѧϰ�ڹ� 20081002
      nCMDCode := nREADSKILLNG;
      goto L001;
    end;
    if sCmd = sMAKEWINENPCMOVE then begin//���NPC���߶� 20080621
      nCMDCode := nMAKEWINENPCMOVE;
      goto L001;
    end;
    if sCmd = sFOUNTAIN then begin//����Ȫˮ�緢 20080624
      nCMDCode := nFOUNTAIN;
      goto L001;
    end;
    if sCmd = sSETGUILDFOUNTAIN then begin//����/�ر��л�Ȫˮ�ֿ� 20080625
      nCMDCode := nSETGUILDFOUNTAIN;
      goto L001;
    end;
    if sCmd = sGIVEGUILDFOUNTAIN then begin//��ȡ�л��ˮ 20080625
      nCMDCode := nGIVEGUILDFOUNTAIN;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sCHALLENGMAPMOVE then begin//��ս��ͼ�ƶ� 20080705
      nCMDCode := nCHALLENGMAPMOVE;
      goto L001;
    end;
    if sCmd = sGETCHALLENGEBAKITEM then begin//û����ս��ͼ���ƶ�,���˻ص�Ѻ����Ʒ 20080705
      nCMDCode := nGETCHALLENGEBAKITEM;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sHEROLOGOUT then begin//Ӣ������ 20080716
      nCMDCode := nHEROLOGOUT;
      goto L001;
    end;
    if sCmd = sSETITEMSLIGHT then begin //װ���������� 20080223
      nCMDCode := nSETITEMSLIGHT;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sQUERYREFINEITEM then begin //�򿪴������� 20080503
      nCMDCode := nQUERYREFINEITEM;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sGOHOME then begin //�ƶ����سǵ� 20080503
      nCMDCode := nGOHOME;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sTHROWITEM then begin //��ָ����Ʒˢ�µ�ָ����ͼ���귶Χ�� 20080508
      nCMDCode := nTHROWITEM;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sOpenDragonBox then begin //�򿪴������� 20080502
      nCMDCode := nOpenDragonBox;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sCLEARCODELIST then begin //ɾ��ָ���ı���ı��� 20080410
      nCMDCode := nCLEARCODELIST;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sGetRandomName then begin //���ȡ�ļ����� 20080126
      nCMDCode := nGetRandomName;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sHCall then begin //ͨ���ű������ñ���ִ��QManage.txt�еĽű� 20080422
      nCMDCode := nHCall;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sINCASTLEWARAY then begin //��������Ƿ��ڹ����ڼ�ķ�Χ�ڣ�����BB�ѱ� 20080422
      nCMDCode := nINCASTLEWARAY;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sGIVESTATEITEM then begin //�������״̬װ�� 20080312
      nCMDCode := nGIVESTATEITEM;
      goto L001;
    end;
    if sCmd = sSETITEMSTATE then begin //����װ����״̬ 20080312
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
    if sCmd = sSC_RECALLMOBEX then begin //�����ٳ��ı������� 20080122
      nCMDCode := nSC_RECALLMOBEX;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sSC_MOVEMOBTO then begin //��ָ������Ĺ����ƶ��������� 20080123
      nCMDCode := nSC_MOVEMOBTO;
      goto L001;
    end;
//-----------------------------------------------------------------------------
    if sCmd = sSC_CLEARITEMMAP then begin //�����ͼ��Ʒ 20080124
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
//20080220 ��������
    if sCmd = sSC_DIV then begin //����
      nCMDCode := nSC_DIV;
      goto L001;
    end;
    if sCmd = sSC_MUL then begin //�˷�
      nCMDCode := nSC_MUL;
      goto L001;
    end;
    if sCmd = sSC_PERCENT then begin //�ٷֱ�
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
    if sCmd = sSC_ADDGUILDMEMBER then begin//����л��Ա//20080427
      nCMDCode := nSC_ADDGUILDMEMBER;
      goto L001;
    end;
    if sCmd = sSC_DELGUILDMEMBER then begin//ɾ���л��Ա��ɾ��������Ч��//20080427
      nCMDCode := nSC_DELGUILDMEMBER;
      goto L001;
    end;
    if sCmd = sSC_SKILLLEVEL then begin
      nCMDCode := nSC_SKILLLEVEL;
      goto L001;
    end;
    if sCmd = sSC_HEROSKILLLEVEL then begin//����Ӣ�ۼ��ܵȼ� 20080415
      nCMDCode := nSC_HEROSKILLLEVEL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEPKPOINT then begin
      nCMDCode := nSC_CHANGEPKPOINT;
      goto L001;
    end;
    if sCmd = sSC_CHANGEEXP then begin//������ɫ����
      nCMDCode := nSC_CHANGEEXP;
      goto L001;
    end;
    if sCmd = sSC_CHANGENGEXP then begin//������ɫ�ڹ����� 20081002
      nCMDCode := nSC_CHANGENGEXP;
      goto L001;
    end;
    if sCmd = sSC_CHANGENGLEVEL then begin//������ɫ�ڹ��ȼ� 20081004
      nCMDCode := nSC_CHANGENGLEVEL;
      goto L001;
    end;
    if sCmd = sSC_WAPMOVETOTIME then begin//ѩ���ͼ���ͣ�ʱ�䵽���ͻسǵ� 20081230
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
    if sCmd = sSC_GAMEGOLD then begin //������Ϸ�ҵ�����
      nCMDCode := nSC_GAMEGOLD;
      goto L001;
    end;
    if sCmd = sSC_GAMEDIAMOND then begin //�������ʯ���� 20071226
      nCMDCode := nSC_GAMEDIAMOND;
      goto L001;
    end;
    if sCmd = sSC_GAMEGIRD then begin //����������� 20071226
      nCMDCode := nSC_GAMEGIRD;
      goto L001;
    end;
    if sCmd = sSC_GAMEGLORY then begin //��������ֵ 20080511
      nCMDCode := nSC_GAMEGLORY;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHEROLOYAL then begin //����Ӣ�۵��ҳ϶� 20080109
      nCMDCode := nSC_CHANGEHEROLOYAL;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHUMABILITY then begin //������������ 20080609
      nCMDCode := nSC_CHANGEHUMABILITY;
      goto L001;
    end;
    if sCmd = sSC_CHANGEHEROTRANPOINT then begin //����Ӣ�ۼ����������� 20080512
      nCMDCode := nSC_CHANGEHEROTRANPOINT;
      goto L001;
    end;
//--------------------�ƹ�ϵͳ------------------------------------------------
    if sCmd = sSC_SAVEHERO then begin //�ķ�Ӣ�� 20080513
      nCMDCode := nSC_SAVEHERO;
      goto L001;
    end;
    if sCmd = sSC_GETHERO then begin //ȡ��Ӣ�� 20080513
      nCMDCode := nSC_GETHERO;
      goto L001;
    end;
    if sCmd = sSC_CLOSEDRINK then begin //�رն��ƴ��� 20080514
      nCMDCode := nSC_CLOSEDRINK;
      goto L001;
    end;
    if sCmd = sSC_PLAYDRINKMSG then begin //���ƴ���˵����Ϣ 20080514
      nCMDCode := nSC_PLAYDRINKMSG;
      goto L001;
    end;
    if sCmd = sSC_OPENPLAYDRINK then begin //ָ������Ⱦ� 20080514
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
    if sCmd = sSC_CHANGEGUILDFOUNTAIN then begin//�����л��Ȫ 20081007
      nCMDCode := nSC_CHANGEGUILDFOUNTAIN;
      goto L001;
    end;
    if sCmd = sSC_TAGMAPINFO then begin//��·��ʯ 20081019
      nCMDCode := nSC_TAGMAPINFO;
      goto L001;
    end;
    if sCmd = sSC_TAGMAPMOVE then begin//�ƶ�����·��ʯ��¼��XY 20081019
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
    if sCmd = sSC_GIVEMINE then begin //����ʯ  20080330
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

   { if nCMDCode <= 0 then begin //20080813 ע��
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
      DeCodeStringList(LoadList);//�ű�����
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
    // ��������
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
              // ��Define �õĳ�������ָ��ֵ
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
              end; // ��Define �õĳ�������ָ��ֵ
            end;
          end;
        end;
      end;
    end;//for
    // ��������

    //�ͷų�����������
    if DefineList.Count > 0 then begin//20080629
      for I := 0 to DefineList.Count - 1 do begin
        if pTDefineInfo(DefineList.Items[I]) <> nil then
           Dispose(pTDefineInfo(DefineList.Items[I]));
      end;
    end;
    DefineList.Free;
    //�ͷų�����������

    Script := nil;
    SayingRecord := nil;
    nQuestIdx := 0;
    for I := 0 to LoadList.Count - 1 do begin //0048B9FC
      s34 := Trim(LoadList.Strings[I]);
      if (s34 = '') or (s34[1] = ';') or (s34[1] = '/') then Continue;
      if (n6C = 0) and (boFlag) then begin
        //��Ʒ�۸���
        if s34[1] = '%' then begin //0048BA57
          s34 := Copy(s34, 2, Length(s34) - 1);
          nPriceRate := Str_ToInt(s34, -1);
          if nPriceRate >= 55 then begin
            TMerchant(NPC).m_nPriceRate := nPriceRate;
          end;
          Continue;
        end;
        //��Ʒ��������
        if s34[1] = '+' then begin
          s34 := Copy(s34, 2, Length(s34) - 1);
          nItemType := Str_ToInt(s34, -1);
          if nItemType >= 0 then begin
            TMerchant(NPC).m_ItemTypeList.Add(Pointer(nItemType));
          end;
          Continue;
        end;
        //���Ӵ���NPC��ִ����������
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
             { if CompareText(s30, sGETSELLGOLD) = 0 then begin  //20080416 ȥ����������
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
              if CompareText(s30, sBuHero) = 0 then begin//�ƹ�Ӣ��NPC 20080514
                TMerchant(NPC).m_boBuHero := True;
                Continue;
              end;
              if CompareText(s30, sPlayMakeWine) = 0 then begin//���NPC 20080619
                TMerchant(NPC).m_boPlayMakeWine := True;
                Continue;
              end;
              if CompareText(s30, sPlayDrink) = 0 then begin//���,����NPC 20080515
                TMerchant(NPC).m_boPlayDrink := True;
                Continue;
              end;
              if CompareText(s30, sybdeal) = 0 then begin //Ԫ������NPC���� 20080316
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
            MainOutMessage('�ű�����: ' + s34 + ' ��:' + IntToStr(I) + ' ��: ' + sScritpFileName);
          end;
        end; //0048C004
        if (n6C = 12) then begin
          New(QuestActionInfo);
          FillChar(QuestActionInfo^, SizeOf(TQuestActionInfo), #0);
          if QuestAction(Trim(s34), QuestActionInfo) then begin
            SayingProcedure.ActionList.Add(QuestActionInfo);
          end else begin
            Dispose(QuestActionInfo);
            MainOutMessage('�ű�����: ' + s34 + ' ��:' + IntToStr(I) + ' ��: ' + sScritpFileName);
          end;
        end;
        if (n6C = 13) then begin
          New(QuestActionInfo);
          FillChar(QuestActionInfo^, SizeOf(TQuestActionInfo), #0);
          if QuestAction(Trim(s34), QuestActionInfo) then begin
            SayingProcedure.ElseActionList.Add(QuestActionInfo);
          end else begin
            Dispose(QuestActionInfo);
            MainOutMessage('�ű�����: ' + s34 + ' ��:' + IntToStr(I) + ' ��: ' + sScritpFileName);
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
    MainOutMessage('�ű��ļ�δ�ҵ�: ' + sScritpFileName);
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

//���¶�ȡ����NPC
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
//���¶�ȡ����NPC
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
              if Str_ToInt(sCastle, 0) <> {1}0 then Merchant.m_boCastle := True//20080820 �޸�
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
            if Str_ToInt(sCastle, 0) <> {1}0 then Merchant.m_boCastle := True//20080820 �޸�
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
  if Pos('/',sNPCName) > 0 then begin;//20081223 ����ļ����Ƿ����'/',�����滻Ϊ'_'
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
  if Pos('/',sNPCName) > 0 then begin;//20081223 ����ļ����Ƿ����'/',�����滻Ϊ'_'
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
            FillChar(UserItem^, SizeOf(TUserItem), #0);//20080820 ����
            if FileRead(FileHandle, UserItem^, SizeOf(TUserItem)) = SizeOf(TUserItem) then begin
              //FillChar(UserItem^.btValue, SizeOf(UserItem^.btValue), 0);//20080820 ����
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
//��ȡ���� 20080114
procedure TFrmDB.LoadBoxsList;
  function IsNum(str:string):boolean; //�ж�һ���ַ����Ƿ�Ϊ����
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
  function IsNum1(str:string):Integer;//�ж��м���'('��
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
  if not DirectoryExists(g_Config.sBoxsDir) then begin //Ŀ¼������,�򴴽�
    CreateDir(g_Config.sBoxsDir);
  end;
  if not FileExists(g_Config.sBoxsFile) then begin //BoxsList.txt�ļ�������,�򴴽��ļ�
    tSaveList := TStringList.Create;
    tSaveList.Add(';��Ϊ�������к��ļ�');
    tSaveList.Add(';���������鿴�����ĵ�');
    tSaveList.Add(';�������ǿ����������޸����䣬���پ�����ֻ������������������');
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
          if tSaveList.Text='' then Continue;//���� ����ļ�����Ϊ����������һ�ļ� 20080115
          BoxsFile:=Trim(tSaveList.Strings[0]); //ȡ��һ������
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
                   ArrestStringEx(BoxsFile, '(', ')', nItemNum);//��Ʒ����
                   BoxsFile := GetValidStr3(BoxsFile, sItemName, ['	',' ',#9]);
                   BoxsFile := GetValidStr3(BoxsFile, nItemType, ['	',' ',#9]);//��Ʒ����
                end;
               1:begin
                   ArrestStringEx(BoxsFile, '(', ')', nItemNum);//��Ʒ����
                   BoxsFile := GetValidStr3(BoxsFile, sItemName, ['	',' ',#9]);
                   if IsNum(nItemNum) and (nItemNum <> '') then GetValidStr3(sItemName, sItemName, ['(']) //��Ʒ����
                     else nItemNum:='';
                   BoxsFile := GetValidStr3(BoxsFile, nItemType, ['	',' ',#9]);//��Ʒ����
               end;
               2:begin
                  ArrestStringEx(BoxsFile, '(', ')', nItemNum);//��Ʒ����
                  if nItemNum <> '' then begin
                    if not IsNum(nItemNum) then begin
                      sTemp:=GetValidStr3(BoxsFile, sItemName, [')']);
                      if sItemName <> '' then sItemName:= sItemName+')';
                      ArrestStringEx(sTemp, '(', ')', nItemNum);
                      nItemType:=GetValidStr3(sTemp, nItemType, ['	',' ',#9]);//��Ʒ����
                    end;
                  end;
               end;
             end;
            end;
           if (sItemName = '') and (nItemType='') then Continue;//20080227
           if (sItemName<> '') and (nItemType<> '') then begin
            StdItem := UserEngine.GetStdItem(sItemName);
             if StdItem <> nil then begin//�ж��Ƿ������ݿ������Ʒ
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
               BoxsInfo.StdItem.Dura := Round((StdItem.DuraMax / 100) * (20 + Random(80)));//��ǰ�־� 20080324
               BoxsInfo.StdItem.DuraMax := StdItem.DuraMax;//���־� 20080324
               BoxsInfo.StdItem.S:=StdItem^;
               BoxsList.Add(BoxsInfo);
              end else  begin //����Ǿ��� ���� ���ʯ
                if (Trim(sItemName)='����') or (Trim(sItemName)='����') or (Trim(sItemName)=g_Config.sGameDiaMond{'���ʯ'}) then begin
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
                end else MainOutMessage('��ʾ:'+g_Config.sBoxsDir+sBoxsDir+'.txt �ļ�����Ʒ('+sItemName+')���ݿ��в�����...');
             end;
           end;
          end;// for K := 1 to tSaveList.Count - 1 do begin
           tSaveList.free;
         end else MainOutMessage('���������ļ�:'+g_Config.sBoxsDir+sBoxsDir+'.txt �ļ�������...');
      end;
    end;//for
    LoadList.Free;
  end;
end;
//------------------------------------------------------------------------------
//��ȡԪ�������б� 20080316
procedure TFrmDB.LoadSellOffItemList();
var
  sFileName: string;
  FileHandle: Integer;
  DealOffInfo: pTDealOffInfo;
  sDealOffInfo: TDealOffInfo;
begin
  sFileName :=  g_Config.sEnvirDir + 'UserData';
  if not DirectoryExists(sFileName) then CreateDir(sFileName); //Ŀ¼������,�򴴽�
  sFileName := sFileName+'\UserData.dat';
  if FileExists(sFileName) then begin
    FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      try
        while FileRead(FileHandle, sDealOffInfo, Sizeof(TDealOffInfo)) = Sizeof(TDealOffInfo) do begin// ѭ��������������
          if (sDealOffInfo.sDealCharName <>'') and (sDealOffInfo.sBuyCharName <> '') and (sDealOffInfo.N < 4) then begin//�ж����ݵ���Ч�� 20081021
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
//����Ԫ�������б� 20080317
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
//��ȡ��װװ������ 20080225
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
          SuitItem.DC:= Str_ToInt(DC,0);//������
          SuitItem.MaxDC:= Str_ToInt(MaxDC,0);
          SuitItem.MC:= Str_ToInt(MC,0);//ħ��
          SuitItem.MaxMC:= Str_ToInt(MaxMC,0);
          SuitItem.SC:= Str_ToInt(SC,0);//����
          SuitItem.MaxSC:= Str_ToInt(MaxSC,0);
          SuitItem.AC:= Str_ToInt(AC,0);//����
          SuitItem.MaxAC:= Str_ToInt(MaxAC,0);
          SuitItem.MAC:= Str_ToInt(MAC,0);//ħ��
          SuitItem.MaxMAC:= Str_ToInt(MaxMAC,0);
          SuitItem.HitPoint:= Str_ToInt(HitPoint,0);//��ȷ��
          SuitItem.SpeedPoint:= Str_ToInt(SpeedPoint,0);//���ݶ�
          SuitItem.HealthRecover:= Str_ToInt(HealthRecover,0); //�����ָ�
          SuitItem.SpellRecover:= Str_ToInt(SpellRecover,0); //ħ���ָ�
          SuitItem.RiskRate:= Str_ToInt(RiskRate,0); //���ʻ���
          SuitItem.btReserved:= Str_ToInt(btReserved,0);//��Ѫ(����)
          SuitItem.btReserved1:= Str_ToInt(btReserved1,0); //����
          SuitItem.btReserved2:= Str_ToInt(btReserved2,0); //����
          SuitItem.btReserved3:= Str_ToInt(btReserved3,0); //����
          SuitItem.nEXPRATE:= Str_ToInt(nEXPRATE,1);//���鱶��
          SuitItem.nPowerRate:= Str_ToInt(nPowerRate,1);//��������
          SuitItem.nMagicRate:= Str_ToInt(nMagicRate,1);//ħ������
          SuitItem.nSCRate:= Str_ToInt(nSCRate,1);//��������
          SuitItem.nACRate:= Str_ToInt(nACRate,1);//��������
          SuitItem.nMACRate:= Str_ToInt(nMACRate,1);//ħ������
          SuitItem.nAntiMagic:= Str_ToInt(nAntiMagic,0); //ħ�����
          SuitItem.nAntiPoison:= Str_ToInt(nAntiPoison,0); //������
          SuitItem.nPoisonRecover:= Str_ToInt(nPoisonRecover,0);//�ж��ָ�

          SuitItem.boTeleport := sboTeleport <> '0';//����  20080824
          SuitItem.boParalysis := sboParalysis <> '0';//���
          SuitItem.boRevival := sboRevival <> '0';//����
          SuitItem.boMagicShield := sboMagicShield <> '0';//����
          SuitItem. boUnParalysis := sboUnParalysis <> '0';//�����
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
//��ȡ������������ 20080502
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
          ArrestStringEx(s18, '[', ']', s24);//S24-[]�������
        end else begin
          if List28 <> nil then begin
            s18 := GetValidStr3(s18, s20, [' ', #9]);//S20-��Ʒ���� N14-����
            s18 := GetValidStr3(s18, s25, [' ', #9]);//�����ɹ���
            s18 := GetValidStr3(s18, s26, [' ', #9]);//ʧ�ܻ�ԭ��
            s18 := GetValidStr3(s18, s27, [' ', #9]);//����ʯ�Ƿ���ʧ 0-����1�־�,1-��ʧ
            s18 := GetValidStr3(s18, s28, [' ', #9]);//��Ʒ����

            s18 := GetValidStr3(s18, n1,  ['-',',', #9]);//������ֵ���Ѷ�
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
              TRefineItemInfo.boDisappear:= Str_ToInt(Trim(s27), 0) = 0;//0-���־� 1-��ʧ
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
    LoadList.Add(';��Ϊ���������ļ�');
    LoadList.Add(';���������鿴�����ĵ�');
    LoadList.Add(';���������Ʒ �����ɹ����� ʧ�ܻ�ԭ���� ����ʯ�Ƿ���ʧ ������Ʒ���Լ��� ������Ʒ��������');
    LoadList.Add(';[����ʯ+����ͷ��+����ս��]');
    LoadList.Add(';����ħ�� 30 30 0 1 0-5,0-5,0-5,4-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,');
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;
//------------------------------------------------------------------------------

//���ַ����ӽ��ܺ���,ʵ��û��ʹ������㷨 20071225
Function EncryptText(Text: String): String;
  function EncryptKey(key: string): string;//���ܺ���
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
  if (sSrc = '') or (Length(sSrc) > 2048) then Exit;//20081203 ��ֹ����Խ��
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
    sLine := addStringList(sLine);//20080217 �ű����ܺ���,SystemModule.dll���
    StringList.Strings[I] := sLine;
  end;
end;

//�ű����ע���,���ʹ�ô˺��� 20081017
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
    if TGetIPString(PlugProcArray[nGetIPString].nProcAddr) then begin//ע�����
      for I := 0 to StringList.Count - 1 do begin
        sLine := StringList.Strings[I];
        sLine := DeCodeString(sLine);
        sLine := EncryptText(sLine);
        sLine := addStringList(sLine);//�ű����ܺ���,SystemModule.dll���
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
    nGetIPString := AddToPulgProcTable(Base64DecodeStr('R2V0SVBIYW5kbGU='),7);//GetIPHandle ���ű�����Ƿ�ע�� 20081016
  end;

finalization
  begin

  end;

end.

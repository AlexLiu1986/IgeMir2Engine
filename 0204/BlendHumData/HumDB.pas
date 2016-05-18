unit HumDB;

interface
uses
  Classes,UniTypes, MudUtil,Windows,  SysUtils, Forms, HUtil32{, Grobal2};

type
  TIdxHeader = packed record //Size 124
    sDesc: string[39]; //0x00
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    n5C: Integer; //0x5C
    n60: Integer; //0x60  95
    n70: Integer; //0x70  99
    nQuickCount: Integer; //0x74  100
    nHumCount: Integer; //0x78
    nDeleteCount: Integer; //0x7C
    nLastIndex: Integer; //0x80
    dUpdateDate: TDateTime; //更新日期
  end;
  pTIdxHeader = ^TIdxHeader;

  TIdxRecord = record
    sChrName: string[15];//人物名
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;

  TFileHumDB = class
    n4: Integer; //0x04
    m_nFileHandle: Integer; //0x08 文件句柄
    n0C: Integer; //0x0C
    m_OnChange: TNotifyEvent;
    m_boChanged: Boolean; //0x18
    m_Header: TDBHeader; //0x1C
    m_QuickList: TQuickList; //0x98
    m_QuickIDList: TQuickIDList; //0x9C
    m_DeletedList: TList; //0xA0 已被删除的记录号
    m_sDBFileName: string; //0xA4 数据库文件名
  private
    procedure LoadQuickList;
    procedure Lock;
    procedure UnLock;
    function UpdateRecord(nIndex: Integer; HumRecord: TDBHum; boNew: Boolean): Boolean;//更新记录
    function GetRecord(n08: Integer; var HumDBRecord: TDBHum): Boolean;//取得记录
  public
    constructor Create(sFileName: string);
    destructor Destroy; override;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
    function Index(sName: string): Integer;
    function Get(n08: Integer; var HumDBRecord: TDBHum): Integer;
    function GetBy(n08: Integer; var HumDBRecord: TDBHum): Boolean;
    function Update(nIndex: Integer; var HumDBRecord: TDBHum): Boolean;
    function UpdateBy(nIndex: Integer; var HumDBRecord: TDBHum): Boolean;
  end;

  TFileDB = class
    n4: Integer; //0x4
    m_nFileHandle: Integer; //0x08
    nC: Integer;
    m_OnChange: TNotifyEvent; //0x10
    m_boChanged: Boolean; //0x18
    m_nLastIndex: Integer; //0x1C
    m_dUpdateTime: TDateTime; //0x20
    m_Header: TDBHeader1; //0x28
    m_QuickList: TQuickList; //0xA4
    m_DeletedList: TList; //0xA8 已被删除的记录号
    m_sDBFileName: string; //0xAC
    m_sIdxFileName: string; //0xB0
  private
    procedure LoadQuickList;
    function LoadDBIndex(): Boolean;
    procedure SaveIndex();
    function GetRecord(nIndex: Integer; var HumanRCD: THumDataInfo): Boolean;//获得记录
    function UpdateRecord(nIndex: Integer; var HumanRCD: THumDataInfo; boNew: Boolean): Boolean;//修改记录
  public
    constructor Create(sFileName: string);
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
    function Index(sName: string): Integer;
    function Get(nIndex: Integer; var HumanRCD: THumDataInfo): Integer;
    function Update(nIndex: Integer; var HumanRCD: THumDataInfo): Boolean;
  end;

var
  HumDataDB, HumDataDB1: TFileDB;//'Mir.DB'
  HumChrDB: TFileHumDB;//'Hum.DB'
  
implementation

{ TFileHumDB }

constructor TFileHumDB.Create(sFileName: string);
begin
  m_sDBFileName := sFileName;
  m_QuickList := TQuickList.Create;
  m_QuickIDList := TQuickIDList.Create;
  m_DeletedList := TList.Create;
  boHumDBReady := False;
  LoadQuickList();
end;
destructor TFileHumDB.Destroy;
begin
  m_QuickList.Free;
  m_QuickIDList.Free;
  inherited;
end;
procedure TFileHumDB.Lock();
begin
  EnterCriticalSection(HumDB_CS);
end;
procedure TFileHumDB.UnLock(); //0x0048B888
begin
  LeaveCriticalSection(HumDB_CS);
end;

procedure TFileHumDB.LoadQuickList();
//0x48BA64
var
  nRecordIndex: Integer;
  nIndex: Integer;
  AccountList: TStringList;
  ChrNameList: TStringList;
  DBHeader: TDBHeader;
  DBRecord: TDBHum;
begin
  n4 := 0;
  m_QuickList.Clear;
  m_QuickIDList.Clear;
  m_DeletedList.Clear;
  nRecordIndex := 0;
  AccountList := TStringList.Create;
  ChrNameList := TStringList.Create;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        for nIndex := 0 to DBHeader.nIDCount - 1 do begin
          if FileRead(m_nFileHandle, DBRecord, SizeOf(TDBHum)) <> SizeOf(TDBHum) then begin
            break;
          end;
          if not DBRecord.Header.boDeleted then begin
            m_QuickList.AddObject(DBRecord.Header.sName, TObject(nRecordIndex));
            AccountList.AddObject(DBRecord.sAccount, TObject(DBRecord.Header.nSelectID));
            ChrNameList.AddObject(DBRecord.sChrName, TObject(nRecordIndex));
          end else begin //0x0048BC04
            m_DeletedList.Add(TObject(nIndex));
          end;
          Inc(nRecordIndex);
          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end; //0x0048BC52
    end;
  finally
    Close();
  end;
  for nIndex := 0 to AccountList.Count - 1 do begin
    m_QuickIDList.AddRecord(AccountList.Strings[nIndex],
      ChrNameList.Strings[nIndex],
      Integer(ChrNameList.Objects[nIndex]) ,
      Integer(AccountList.Objects[nIndex]), False);
    if (nIndex mod 100) = 0 then
      Application.ProcessMessages;
  end;
  //0x0048BCF4
  AccountList.Free;
  ChrNameList.Free;
  m_QuickList.SortString(0, m_QuickList.Count - 1);
  boHumDBReady := True;
end;
procedure TFileHumDB.Close; //0x0048BA24
begin
  FileClose(m_nFileHandle);
  if m_boChanged and Assigned(m_OnChange) then begin
    m_OnChange(Self);
  end;
  UnLock();
end;

function TFileHumDB.Open: Boolean; //0x0048B928
begin
  Lock();
  n4 := 0;
  m_boChanged := False;
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then  //如果文件存在，则读取数据
      FileRead(m_nFileHandle, m_Header, SizeOf(TDBHeader));
  end else begin //0x0048B999
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header.sDesc := DBFileDesc;
      m_Header.nIDCount := 0;
      m_Header.n6C := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

function TFileHumDB.OpenEx: Boolean; //0x0048B8A0
var
  DBHeader: TDBHeader;
begin
  Lock();
  m_boChanged := False;
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      m_Header := DBHeader;
    n4 := 0;
  end else Result := False;
end;

function TFileHumDB.Index(sName: string): Integer; //0x0048C384
begin
  Result := m_QuickList.GetIndex(sName);
end;

function TFileHumDB.Get(n08: Integer;
  var HumDBRecord: TDBHum): Integer; //0x0048C0CC
var
  nIndex: Integer;
begin
  nIndex := Integer(m_QuickList.Objects[n08]);
  if GetRecord(nIndex, HumDBRecord) then Result := nIndex
  else Result := -1;
end;

function TFileHumDB.GetRecord(n08: Integer;
  var HumDBRecord: TDBHum): Boolean;
{FileSeek(文件句柄,偏移量,起始位置)调整文件指针到新的位置,如果操作成功,
则返回新的文件位置,如果操作失败,返回-1;参数0表示从文件开头开始、1表示从当前位置开始}
begin
  if FileSeek(m_nFileHandle, SizeOf(TDBHum) * n08 + SizeOf(TDBHeader), 0) <> -1 then begin
    FileRead(m_nFileHandle, HumDBRecord, SizeOf(TDBHum)); //FileRead()从指定文件中读取变量
    FileSeek(m_nFileHandle, -SizeOf(TDBHum) * n08 + SizeOf(TDBHeader), 1);
    n4 := n08;
    Result := True;
  end else Result := False;
end;

function TFileHumDB.GetBy(n08: Integer;
  var HumDBRecord: TDBHum): Boolean; //0x0048C118
begin
  if n08 >= 0 then
    Result := GetRecord(n08, HumDBRecord)
  else Result := False;
end;

function TFileHumDB.UpdateRecord(nIndex: Integer; HumRecord: TDBHum;
  boNew: Boolean): Boolean; //0x0048BF5C
var
  HumRcd: TDBHum;
  nPosion, n10: Integer;
begin
  nPosion := nIndex * SizeOf(TDBHum) + SizeOf(TDBHeader);
  if FileSeek(m_nFileHandle, nPosion, 0) = nPosion then begin
    n10 := FileSeek(m_nFileHandle, 0, 1);
    if boNew and
      (FileRead(m_nFileHandle, HumRcd, SizeOf(TDBHum)) = SizeOf(TDBHum)) and
      (not HumRcd.Header.boDeleted) and (HumRcd.Header.sName <> '') then Result := True
    else begin
      //HumRecord.Header.boDeleted := False;//20080515 注释
      HumRecord.Header.dCreateDate := Now();
      m_Header.dUpdateDate := Now();
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
      FileSeek(m_nFileHandle, n10, 0);
      FileWrite(m_nFileHandle, HumRecord, SizeOf(TDBHum));
      FileSeek(m_nFileHandle, -SizeOf(TDBHum), 1);
      n4 := nIndex;
      m_boChanged := True;
      Result := True;
    end;
  end else Result := False;
end;

function TFileHumDB.Update(nIndex: Integer; var HumDBRecord: TDBHum): Boolean; //0x0048C14C
begin
  Result := False;
  if nIndex < 0 then Exit;
  if m_QuickList.Count <= nIndex then Exit;
  if UpdateRecord(Integer(m_QuickList.Objects[nIndex]), HumDBRecord, False) then Result := True;
end;

function TFileHumDB.UpdateBy(nIndex: Integer; var HumDBRecord: TDBHum): Boolean; //00048C1B4
begin
  Result := False;
  if UpdateRecord(nIndex, HumDBRecord, False) then Result := True;
end;

{ TFileDB }

constructor TFileDB.Create(sFileName: string); //0x0048A0F4
begin
  InitializeCriticalSection(HumDB_CS);
  n4 := 0;
  boDataDBReady := False;
  m_sDBFileName := sFileName;
  m_sIdxFileName := sFileName + '.idx';
  m_QuickList := TQuickList.Create;
  m_DeletedList := TList.Create;
  m_nLastIndex := -1;
  if LoadDBIndex then boDataDBReady := True
  else LoadQuickList();
end;
destructor TFileDB.Destroy;
begin
  if boDataDBReady then SaveIndex();
  DeleteCriticalSection(HumDB_CS);
  m_QuickList.Free;
  m_DeletedList.Free;
  inherited;
end;
function TFileDB.LoadDBIndex: Boolean; //0x0048AA6C
var
  nIdxFileHandle: Integer;
  IdxHeader: TIdxHeader;
  DBHeader: TDBHeader1;
  IdxRecord: TIdxRecord;
  HumRecord: THumDataInfo;
  i: Integer;
  n14: Integer;
begin
  Result := False;
  nIdxFileHandle := 0;
  FillChar(IdxHeader, SizeOf(TIdxHeader), #0);
  if FileExists(m_sIdxFileName) then
    nIdxFileHandle := FileOpen(m_sIdxFileName, fmOpenReadWrite or fmShareDenyNone);
  if nIdxFileHandle > 0 then begin
    Result := True;
    FileRead(nIdxFileHandle, IdxHeader, SizeOf(TIdxHeader));

    try
      if Open then begin
        FileSeek(m_nFileHandle, 0, 0);
        if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
          if IdxHeader.nHumCount <> DBHeader.nHumCount then
            Result := False;
          if IdxHeader.sDesc <> sDBIdxHeaderDesc then
            Result := False;
        end; //0x0048AB65
        if IdxHeader.nLastIndex <> DBHeader.nLastIndex then begin
          Result := False;
        end;
        if IdxHeader.nLastIndex > -1 then begin
          FileSeek(m_nFileHandle, IdxHeader.nLastIndex * SizeOf(THumDataInfo) + SizeOf(TDBHeader), 0);
          if FileRead(m_nFileHandle, HumRecord, SizeOf(THumDataInfo)) = SizeOf(THumDataInfo) then
            if IdxHeader.dUpdateDate <> HumRecord.Header.dCreateDate then
              Result := False;
        end;
      end; //0x0048ABD7
    finally
      Close();
    end;
    if Result then begin
      m_nLastIndex := IdxHeader.nLastIndex;
      m_dUpdateTime := IdxHeader.dUpdateDate;
      for i := 0 to IdxHeader.nQuickCount - 1 do begin
        if FileRead(nIdxFileHandle, IdxRecord, SizeOf(TIdxRecord)) = SizeOf(TIdxRecord) then begin
          m_QuickList.AddObject(IdxRecord.sChrName, TObject(IdxRecord.nIndex));
        end else begin
          Result := False;
          break;
        end;
      end; //0048AC7A
      for i := 0 to IdxHeader.nDeleteCount - 1 do begin
        if FileRead(nIdxFileHandle, n14, SizeOf(Integer)) = SizeOf(Integer) then
          m_DeletedList.Add(Pointer(n14))
        else begin
          Result := False;
          break;
        end;
      end;
    end; //0048ACC5
    FileClose(nIdxFileHandle);
  end; //0048ACCD
  if Result then begin
    m_QuickList.SortString(0, m_QuickList.Count - 1);
  end else m_QuickList.Clear;
end;

procedure TFileDB.LoadQuickList; //0x0048A440
var
  nIndex: Integer;
  DBHeader: TDBHeader1;
  RecordHeader: TRecordHeader;
begin
  n4 := 0;
  m_QuickList.Clear;
  m_DeletedList.Clear;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
        for nIndex := 0 to DBHeader.nHumCount - 1 do begin
          if FileSeek(m_nFileHandle, nIndex * SizeOf(THumDataInfo) + SizeOf(TDBHeader), 0) = -1 then break;
          if FileRead(m_nFileHandle, RecordHeader, SizeOf(TRecordHeader)) <> SizeOf(TRecordHeader) then break;
          if not RecordHeader.boDeleted then begin
            if RecordHeader.sName <> '' then begin
              m_QuickList.AddObject(RecordHeader.sName, TObject(nIndex));
            end else m_DeletedList.Add(TObject(nIndex));
          end else begin
            m_DeletedList.Add(TObject(nIndex));
          end;
          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Close();
  end;
  m_QuickList.SortString(0, m_QuickList.Count - 1);
  m_nLastIndex := m_Header.nLastIndex;
  m_dUpdateTime := m_Header.dLastDate;
  boDataDBReady := True;
end;

procedure TFileDB.Lock; //00048A254
begin
  EnterCriticalSection(HumDB_CS);
end;
procedure TFileDB.UnLock; //0048A268
begin
  LeaveCriticalSection(HumDB_CS);
end;

function TFileDB.Open: Boolean; //0048A304
begin
  Lock();
  n4 := 0;
  m_boChanged := False;
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TDBHeader));
  end else begin //0048B999
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header.sDesc := DBFileDesc;
      m_Header.nHumCount := 0;
      m_Header.n6C := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else Result := False;
end;

procedure TFileDB.Close; //0x0048A400
begin
  FileClose(m_nFileHandle);
  if m_boChanged and Assigned(m_OnChange) then begin
    m_OnChange(Self);
  end;
  UnLock();
end;

function TFileDB.OpenEx: Boolean; //0x0048A27C
var
  DBHeader: TDBHeader1;
begin
  Lock();
  m_boChanged := False;
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      m_Header := DBHeader;
    n4 := 0;
  end else Result := False;
end;  

function TFileDB.Index(sName: string): Integer; //0x0048B534
begin
  Result := m_QuickList.GetIndex(sName);
end;

function TFileDB.Get(nIndex: Integer; var HumanRCD: THumDataInfo): Integer; //0x0048B320
var
  nIdx: Integer;
begin
  nIdx := Integer(m_QuickList.Objects[nIndex]);
  if GetRecord(nIdx, HumanRCD) then Result := nIdx
  else Result := -1;
end;

function TFileDB.Update(nIndex: Integer;
  var HumanRCD: THumDataInfo): Boolean;
begin
  Result := False;
  if (nIndex >= 0) and (m_QuickList.Count > nIndex) then
    if UpdateRecord(Integer(m_QuickList.Objects[nIndex]), HumanRCD, False) then Result := True;
end;

function TFileDB.GetRecord(nIndex: Integer;
  var HumanRCD: THumDataInfo): Boolean;
begin
  if FileSeek(m_nFileHandle, nIndex * SizeOf(THumDataInfo) + SizeOf(TDBHeader), 0) <> -1 then begin
    FileRead(m_nFileHandle, HumanRCD, SizeOf(THumDataInfo));
    FileSeek(m_nFileHandle, -SizeOf(THumDataInfo), 1);
    n4 := nIndex;
    Result := True;
  end else Result := False;
end;

function TFileDB.UpdateRecord(nIndex: Integer;
  var HumanRCD: THumDataInfo; boNew: Boolean): Boolean;
var
  nPosion, n10: Integer;
  dt20: TDateTime;
  ReadRCD: THumDataInfo;
begin
  nPosion := nIndex * SizeOf(THumDataInfo) + SizeOf(TDBHeader);
  if FileSeek(m_nFileHandle, nPosion, 0) = nPosion then begin
    dt20 := Now();
    m_nLastIndex := nIndex;
    m_dUpdateTime := dt20;
    n10 := FileSeek(m_nFileHandle, 0, 1);
    if boNew
      and (FileRead(m_nFileHandle, ReadRCD, SizeOf(THumDataInfo)) = SizeOf(THumDataInfo))
      and not ReadRCD.Header.boDeleted and (ReadRCD.Header.sName <> '') then begin
      Result := False;
    end else begin
      //HumanRCD.Header.boDeleted := False;//20080515 注释
      HumanRCD.Header.dCreateDate := Now();
      m_Header.nLastIndex := m_nLastIndex;
      m_Header.dLastDate := m_dUpdateTime;
      m_Header.dUpdateDate := Now();
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
      FileSeek(m_nFileHandle, n10, 0);
      FileWrite(m_nFileHandle, HumanRCD, SizeOf(THumDataInfo));
      FileSeek(m_nFileHandle, -SizeOf(THumDataInfo), 1);
      n4 := nIndex;
      m_boChanged := True;
      Result := True;
    end;
  end else Result := False;
end;

procedure TFileDB.SaveIndex; //0x0048A83C
var
  IdxHeader: TIdxHeader;
  nIdxFileHandle: Integer;
  i: Integer;
  nDeletedIdx: Integer;
  IdxRecord: TIdxRecord;
begin
  FillChar(IdxHeader, SizeOf(TIdxHeader), #0);
  IdxHeader.sDesc := sDBIdxHeaderDesc;
  IdxHeader.nQuickCount := m_QuickList.Count;
  IdxHeader.nHumCount := m_Header.nHumCount;
  IdxHeader.nDeleteCount := m_DeletedList.Count;
  IdxHeader.nLastIndex := m_nLastIndex;
  IdxHeader.dUpdateDate := m_dUpdateTime;
  if FileExists(m_sIdxFileName) then
    nIdxFileHandle := FileOpen(m_sIdxFileName, fmOpenReadWrite or fmShareDenyNone)
  else nIdxFileHandle := FileCreate(m_sIdxFileName);

  if nIdxFileHandle > 0 then begin
    FileWrite(nIdxFileHandle, IdxHeader, SizeOf(TIdxHeader));
    for i := 0 to m_QuickList.Count - 1 do begin
      IdxRecord.sChrName := m_QuickList.Strings[i];
      IdxRecord.nIndex := Integer(m_QuickList.Objects[i]);
      FileWrite(nIdxFileHandle, IdxRecord, SizeOf(TIdxRecord));
    end;
    for i := 0 to m_DeletedList.Count - 1 do begin
      nDeletedIdx := Integer(m_DeletedList.Items[i]);
      FileWrite(nIdxFileHandle, nDeletedIdx, SizeOf(Integer));
    end;
    FileClose(nIdxFileHandle);
  end;
end;

end.

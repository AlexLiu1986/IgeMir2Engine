unit HumDB;

interface
uses
  Windows, Classes, SysUtils, Forms, Share, Mudutil;

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
    sChrName: string[15];
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;

  TFileDB = class{读取BLUE Mir.DB类,以提速对比}
    n4: Integer; //0x4
    m_nFileHandle: Integer; //0x08
    nC: Integer;
    m_OnChange: TNotifyEvent; //0x10
    m_boChanged: Boolean; //0x18
    m_nLastIndex: Integer; //0x1C
    m_dUpdateTime: TDateTime; //0x20
    m_Header: TDBHeader1; //0x28
    m_QuickList: TQuickList; //0xA4
    m_DeletedList: TList; //已被删除的记录号
    m_sDBFileName: string; //0xAC
    m_sIdxFileName: string; //0xB0
  private
    procedure LoadQuickList;
    function LoadDBIndex(): Boolean;
    procedure SaveIndex();
    function GetRecord(nIndex: Integer; var HumanRCD: TLF_HumDataInfo): Boolean;//获得记录
  public
    constructor Create(sFileName: string);
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
    function Open(): Boolean;
    function OpenEx(): Boolean;
    procedure Close();
    function Index(sName: string): Integer;
    function Get(nIndex: Integer; var HumanRCD: TLF_HumDataInfo): Integer;
  end;
var
  HumDataDB: TFileDB;//'Mir.DB'  
implementation

function CompareLStr(Src, targ: string; compn: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if compn <= 0 then Exit;
  if Length(Src) < compn then Exit;
  if Length(targ) < compn then Exit;
  Result := True;
  for I := 1 to compn do
    if UpCase(Src[I]) <> UpCase(targ[I]) then begin
      Result := False;
      Break;
    end;
end;

function FileCopy(Source, Dest: string): Boolean;
var
  fSrc, fDst, Len: Integer;
  Size: LongInt;
  Buffer: packed array[0..2047] of Byte;
begin
  Result := False; { Assume that it WONT work }
  if Source <> Dest then begin
    fSrc := FileOpen(Source, fmOpenRead);
    if fSrc >= 0 then begin
      Size := FileSeek(fSrc, 0, 2);
      FileSeek(fSrc, 0, 0);
      fDst := FileCreate(Dest);
      if fDst >= 0 then begin
        while Size > 0 do begin
          Len := FileRead(fSrc, Buffer, SizeOf(Buffer));
          FileWrite(fDst, Buffer, Len);
          Size := Size - Len;
        end;
        FileSetDate(fDst, FileGetDate(fSrc));
        FileClose(fDst);
        FileSetAttr(Dest, FileGetAttr(Source));
        Result := True;
      end;
      FileClose(fSrc);
    end;
  end;
end;


{TFileDB}
constructor TFileDB.Create(sFileName: string); //0x0048A0F4
begin
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
  HumRecord: TLF_HumDataInfo;
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
        if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader1)) = SizeOf(TDBHeader1) then begin
          if IdxHeader.nHumCount <> DBHeader.nHumCount then
            Result := False;
          if IdxHeader.sDesc <> sDBIdxHeaderDesc then
            Result := False;
        end; //0x0048AB65
        if IdxHeader.nLastIndex <> DBHeader.nLastIndex then begin
          Result := False;
        end;
        if IdxHeader.nLastIndex > -1 then begin
          FileSeek(m_nFileHandle, IdxHeader.nLastIndex * SizeOf(TLF_HumDataInfo) + SizeOf(TDBHeader1), 0);
          if FileRead(m_nFileHandle, HumRecord, SizeOf(TLF_HumDataInfo)) = SizeOf(TLF_HumDataInfo) then
            if IdxHeader.dUpdateDate <> HumRecord.Header.UpdateDate then
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
  RecordHeader: TLF_HumRecordHeader;
begin
  n4 := 0;
  m_QuickList.Clear;
  m_DeletedList.Clear;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader1)) = SizeOf(TDBHeader1) then begin
        for nIndex := 0 to DBHeader.nHumCount - 1 do begin
          if FileSeek(m_nFileHandle, nIndex * SizeOf(TLF_HumDataInfo) + SizeOf(TDBHeader1), 0) = -1 then break;
          if FileRead(m_nFileHandle, RecordHeader, SizeOf(TLF_HumRecordHeader)) <> SizeOf(TLF_HumRecordHeader) then break;
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
      FileRead(m_nFileHandle, m_Header, SizeOf(TDBHeader1));
  end else begin //0048B999
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header.sDesc := DBFileDesc;
      m_Header.nHumCount := 0;
      m_Header.n6C := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader1));
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
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader1)) = SizeOf(TDBHeader1) then
      m_Header := DBHeader;
    n4 := 0;
  end else Result := False;
end;

function TFileDB.Index(sName: string): Integer; //0x0048B534
begin
  Result := m_QuickList.GetIndex(sName);
end;

function TFileDB.Get(nIndex: Integer; var HumanRCD: TLF_HumDataInfo): Integer; //0x0048B320
var
  nIdx: Integer;
begin
  nIdx := Integer(m_QuickList.Objects[nIndex]);
  if GetRecord(nIdx, HumanRCD) then Result := nIdx
  else Result := -1;
end;

function TFileDB.GetRecord(nIndex: Integer;
  var HumanRCD: TLF_HumDataInfo): Boolean;
begin
  if FileSeek(m_nFileHandle, nIndex * SizeOf(TLF_HumDataInfo) + SizeOf(TDBHeader1), 0) <> -1 then begin
    FileRead(m_nFileHandle, HumanRCD, SizeOf(TLF_HumDataInfo));
    FileSeek(m_nFileHandle, -SizeOf(TLF_HumDataInfo), 1);
    n4 := nIndex;
    Result := True;
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

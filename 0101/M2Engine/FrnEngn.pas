unit FrnEngn;

interface

uses
  Windows, Classes, SysUtils, Grobal2, SDK;
type
  TFrontEngine = class(TThread)
    m_UserCriticalSection: TRTLCriticalSection;
    m_LoadRcdList: TList;
    m_SaveRcdList: TList;
    m_ChangeGoldList: TList;
  private
    m_LoadRcdTempList: TList;
    m_SaveRcdTempList: TList;
    procedure GetGameTime();
    procedure ProcessGameDate();
    function LoadHumFromDB(LoadUser: pTLoadDBInfo; var boReTry: Boolean): Boolean;
    function ChangeUserGoldInDB(GoldChangeInfo: pTGoldChangeInfo): Boolean;
    procedure Run();
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    function SaveListCount(): Integer;
    function IsIdle(): Boolean;
    function IsFull(): Boolean;
    procedure DeleteHuman(nGateIndex, nSocket: Integer);
    function InSaveRcdList(sAccount, sChrName: string): Boolean;
    procedure AddChangeGoldList(sGameMasterName, sGetGoldUserName: string; nGold: Integer);
    procedure AddToLoadRcdList(sAccount, sChrName, sIPaddr: string; boFlag: Boolean; nSessionID: Integer; nPayMent, nPayMode, nSoftVersionDate, nSocket, nGSocketIdx, nGateIdx: Integer);
    procedure AddToLoadHeroRcdList(sCharName, sMsg: string; PlayObject: TObject; btLoadType: Byte);
    procedure AddToSaveRcdList(SaveRcd: pTSaveRcd);
    function UpDataSaveRcdList(SaveRcd: pTSaveRcd): Boolean;
    function GetSaveRcd(sAccount, sCharName: string): pTSaveRcd;
  end;

implementation
uses M2Share, RunDB, ObjBase, HUtil32;


{ TFrontEngine }

constructor TFrontEngine.Create(CreateSuspended: Boolean);
begin
  inherited;
  InitializeCriticalSection(m_UserCriticalSection);
  m_LoadRcdList := TList.Create;
  m_SaveRcdList := TList.Create;
  m_ChangeGoldList := TList.Create;
  m_LoadRcdTempList := TList.Create;
  m_SaveRcdTempList := TList.Create;
  //FreeOnTerminate:=True;
  //AddToProcTable(@TFrontEngine.ProcessGameDate, 'TFrontEngine.ProcessGameDatea');
end;

destructor TFrontEngine.Destroy;
begin
  m_LoadRcdList.Free;
  m_SaveRcdList.Free;
  m_ChangeGoldList.Free;
  m_LoadRcdTempList.Free;
  m_SaveRcdTempList.Free;
  DeleteCriticalSection(m_UserCriticalSection);
  inherited;
end;

procedure TFrontEngine.Execute;
begin
  while not Terminated do begin
    try
      Run();
    except
      MainOutMessage('{异常} TFrontEngine::Execute');
    end;
    Sleep(1);
  end;
end;

procedure TFrontEngine.GetGameTime;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(Time, Hour, Min, Sec, MSec);
  case Hour of
    5, 6, 7, 8, 9, 10, 16, 17, 18, 19, 20, 21, 22: g_nGameTime := 1;
    11, 23: g_nGameTime := 2;
    4, 15: g_nGameTime := 0;
    0, 1, 2, 3, 12, 13, 14: g_nGameTime := 3;
  end;
end;

function TFrontEngine.IsIdle: Boolean;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SaveRcdList.Count = 0 then Result := True;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.SaveListCount: Integer;
begin
  Result := 0;
  EnterCriticalSection(m_UserCriticalSection);
  try
    Result := m_SaveRcdList.Count;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.ProcessGameDate;
var
  I: Integer;
  II: Integer;
  TempList: TList;
  ChangeGoldList: TList;
  LoadDBInfo: pTLoadDBInfo;
  SaveRcd: pTSaveRcd;
  GoldChangeInfo: pTGoldChangeInfo;
  boReTryLoadDB: Boolean;
  boSaveRcd: Boolean;
  nCode: Byte;
resourcestring
  sExceptionMsg = '{异常} TFrontEngine::ProcessGameDate Code:%d';
  sSaveExceptionMsg = '数据库服务器出现异常，请重新启动数据库服务器(DBServer.exe)！！！';
begin
  nCode := 0;
  try
    ChangeGoldList := nil;
    nCode := 17;
    if g_nSaveRcdErrorCount >= 10 then begin
      nCode := 18;
      if GetTickCount - g_dwShowSaveRcdErrorTick > 5000{1000} then begin//20081224 修改秒触发
        nCode := 19;
        g_dwShowSaveRcdErrorTick := GetTickCount;
        MainOutMessage(sSaveExceptionMsg);
      end;
    end;
    EnterCriticalSection(m_UserCriticalSection);
    try
      nCode := 20;
      if m_SaveRcdList.Count > 0 then begin//20081008
        nCode := 21;
        for I := 0 to m_SaveRcdList.Count - 1 do begin
          m_SaveRcdTempList.Add(m_SaveRcdList.Items[I]);
        end;
      end;
      nCode := 1;
      TempList := m_LoadRcdTempList;
      nCode := 2;
      m_LoadRcdTempList := m_LoadRcdList;
      nCode := 3;
      m_LoadRcdList := TempList;
      nCode := 4;
      if m_ChangeGoldList.Count > 0 then begin
        nCode := 22;
        ChangeGoldList := TList.Create;
        nCode := 23;
        for I := 0 to m_ChangeGoldList.Count - 1 do begin
          if m_ChangeGoldList.Items[I] <> nil then//20080808 增加
            ChangeGoldList.Add(m_ChangeGoldList.Items[I]);
        end;
      end;
    finally
      LeaveCriticalSection(m_UserCriticalSection);
    end;

    if m_SaveRcdTempList.Count > 0 then begin//20081008
      for I := 0 to m_SaveRcdTempList.Count - 1 do begin
        SaveRcd := m_SaveRcdTempList.Items[I];
        if (not DBSocketConnected) or (g_nSaveRcdErrorCount >= 10) then begin //DBS关闭 不保存
          if (SaveRcd.PlayObject <> nil) and (not SaveRcd.boIsHero) then begin
            TPlayObject(SaveRcd.PlayObject).m_boRcdSaved := True;
          end;
          EnterCriticalSection(m_UserCriticalSection);
          try
            for II := m_SaveRcdList.Count - 1 downto 0 do begin
              if m_SaveRcdList.Count <= 0 then Break;//20080917
              if m_SaveRcdList.Items[II] = SaveRcd then begin
                m_SaveRcdList.Delete(II);
                nCode := 5;
                DisPoseAndNil(SaveRcd);
                nCode := 6;
                Break;
              end;
            end;//for
          finally
            LeaveCriticalSection(m_UserCriticalSection);
          end;
        end else begin
          boSaveRcd := False;
          if SaveRcd.nReTryCount = 0 then begin
            boSaveRcd := True;
          end else
            if (SaveRcd.nReTryCount < 50) and (GetTickCount - SaveRcd.dwSaveTick > 5000) then begin //保存错误等待5秒后在保存
            boSaveRcd := True;
          end else
            if SaveRcd.nReTryCount >= 50 then begin //失败50次后不在保存
            if (SaveRcd.PlayObject <> nil) and (not SaveRcd.boIsHero) then begin
              TPlayObject(SaveRcd.PlayObject).m_boRcdSaved := True;
            end;
            EnterCriticalSection(m_UserCriticalSection);
            try
              for II := m_SaveRcdList.Count - 1 downto 0 do begin
                if m_SaveRcdList.Count <= 0 then Break;//20080917
                if m_SaveRcdList.Items[II] = SaveRcd then begin
                  m_SaveRcdList.Delete(II);
                  nCode := 7;
                  DisPoseAndNil(SaveRcd);
                  nCode := 8;
                  Break;
                end;
              end;//for
            finally
              LeaveCriticalSection(m_UserCriticalSection);
            end;
          end;
          if boSaveRcd then begin
            if SaveHumRcdToDB(SaveRcd.sAccount, SaveRcd.sChrName, SaveRcd.nSessionID, SaveRcd.boIsHero, SaveRcd.HumanRcd) then begin
              if (SaveRcd.PlayObject <> nil) and (not SaveRcd.boIsHero) then begin
                TPlayObject(SaveRcd.PlayObject).m_boRcdSaved := True;
              end;
              EnterCriticalSection(m_UserCriticalSection);
              try
                for II := m_SaveRcdList.Count - 1 downto 0 do begin
                  if m_SaveRcdList.Count <= 0 then Break;//20080917
                  if m_SaveRcdList.Items[II] = SaveRcd then begin
                    m_SaveRcdList.Delete(II);
                    nCode := 9;
                    DisPoseAndNil(SaveRcd);
                    nCode := 10;
                    Break;
                  end;
                end;
              finally
                LeaveCriticalSection(m_UserCriticalSection);
              end;
            end else begin //保存失败
              Inc(SaveRcd.nReTryCount);
              SaveRcd.dwSaveTick := GetTickCount;
            end;
          end;
        end;
      end;//for
      m_SaveRcdTempList.Clear;//20081008 换地方
      nCode := 11;
    end;

    if m_LoadRcdTempList.Count > 0 then begin//20080810 增加
      nCode := 17;
      for I := 0 to m_LoadRcdTempList.Count - 1 do begin
        nCode := 18;
        LoadDBInfo := m_LoadRcdTempList.Items[I];
        nCode := 19;
        if (not LoadHumFromDB(LoadDBInfo, boReTryLoadDB)) and (not LoadDBInfo.boIsHero) then
          RunSocket.CloseUser(LoadDBInfo.nGateIdx, LoadDBInfo.nSocket);
        if not boReTryLoadDB then begin
          DisPoseAndNil(LoadDBInfo);
        end else begin //如果读取人物数据失败(数据还没有保存),则重新加入队列
          EnterCriticalSection(m_UserCriticalSection);
          try
            m_LoadRcdList.Add(LoadDBInfo);
          finally
            LeaveCriticalSection(m_UserCriticalSection);
          end;
        end;
      end;//for
    end;
    m_LoadRcdTempList.Clear;
    nCode := 12;
    if ChangeGoldList <> nil then begin
      nCode := 121;
      if ChangeGoldList.Count > 0 then begin//20081008
        nCode := 122;
        for I := 0 to ChangeGoldList.Count - 1 do begin
          nCode := 123;
          GoldChangeInfo := ChangeGoldList.Items[I];
          nCode := 124;
          if GoldChangeInfo <> nil then begin//20081204 增加
            ChangeUserGoldInDB(GoldChangeInfo);
            nCode := 13;
            Dispose(GoldChangeInfo);
            nCode := 14;
          end;
        end;
      end;
      nCode := 15;
      ChangeGoldList.Free;
    end;
  except
    MainOutMessage(Format(sExceptionMsg, [nCode]));
  end;
end;

function TFrontEngine.IsFull: Boolean;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SaveRcdList.Count >= 2000 then begin
      Result := True;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;
//btLoadType 0-召唤 1-新建 2-删除 3-查询数据
procedure TFrontEngine.AddToLoadHeroRcdList(sCharName, sMsg: string; PlayObject: TObject; btLoadType: Byte);
var
  LoadRcdInfo: pTLoadDBInfo;
begin
  New(LoadRcdInfo);
  TPlayObject(PlayObject).m_boWaitHeroDate := True;
  LoadRcdInfo.sAccount := TPlayObject(PlayObject).m_sUserID;
  LoadRcdInfo.sCharName := sCharName;
  LoadRcdInfo.sIPaddr := TPlayObject(PlayObject).m_sIPaddr;
  LoadRcdInfo.boClinetFlag := TPlayObject(PlayObject).m_boClientFlag;
  LoadRcdInfo.nSessionID := TPlayObject(PlayObject).m_nSessionID;
  LoadRcdInfo.nSoftVersionDate := TPlayObject(PlayObject).m_nSoftVersionDate;
  LoadRcdInfo.nPayMent := TPlayObject(PlayObject).m_nPayMent;
  LoadRcdInfo.nPayMode := TPlayObject(PlayObject).m_nPayMode;
  LoadRcdInfo.nSocket := TPlayObject(PlayObject).m_nSocket;
  LoadRcdInfo.nGSocketIdx := TPlayObject(PlayObject).m_nGSocketIdx;
  LoadRcdInfo.nGateIdx := TPlayObject(PlayObject).m_nGateIdx;
  LoadRcdInfo.dwNewUserTick := GetTickCount();
  LoadRcdInfo.PlayObject := PlayObject;
  LoadRcdInfo.nReLoadCount := 0;
  LoadRcdInfo.boIsHero := True;
  LoadRcdInfo.btLoadDBType := btLoadType;
  LoadRcdInfo.sMsg := sMsg;
  EnterCriticalSection(m_UserCriticalSection);
  try
    m_LoadRcdList.Add(LoadRcdInfo);
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.AddToLoadRcdList(sAccount, sChrName, sIPaddr: string;
  boFlag: Boolean; nSessionID, nPayMent, nPayMode, nSoftVersionDate, nSocket, nGSocketIdx, nGateIdx: Integer);
var
  LoadRcdInfo: pTLoadDBInfo;
begin
  New(LoadRcdInfo);
  LoadRcdInfo.sAccount := sAccount;
  LoadRcdInfo.sCharName := sChrName;
  LoadRcdInfo.sIPaddr := sIPaddr;
  LoadRcdInfo.boClinetFlag := boFlag;
  LoadRcdInfo.nSessionID := nSessionID;
  LoadRcdInfo.nSoftVersionDate := nSoftVersionDate;
  LoadRcdInfo.nPayMent := nPayMent;
  LoadRcdInfo.nPayMode := nPayMode;
  LoadRcdInfo.nSocket := nSocket;
  LoadRcdInfo.nGSocketIdx := nGSocketIdx;
  LoadRcdInfo.nGateIdx := nGateIdx;
  LoadRcdInfo.dwNewUserTick := GetTickCount();
  LoadRcdInfo.PlayObject := nil;
  LoadRcdInfo.nReLoadCount := 0;
  LoadRcdInfo.boIsHero := False;

  EnterCriticalSection(m_UserCriticalSection);
  try
    m_LoadRcdList.Add(LoadRcdInfo);
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.LoadHumFromDB(LoadUser: pTLoadDBInfo; var boReTry: Boolean): Boolean; //004B4B10
var
  HumanRcd: THumDataInfo;
  UserOpenInfo: pTUserOpenInfo;
  nOpenStatus: Integer;
begin
  Result := False;
  boReTry := False;
  if (not LoadUser.boIsHero) or ((LoadUser.boIsHero) and (LoadUser.btLoadDBType = 0)) then begin
    if InSaveRcdList(LoadUser.sAccount, LoadUser.sCharName) then begin
      boReTry := True; //反回TRUE,则重新加入队列
      Exit;
    end;
  end;
  if not LoadUser.boIsHero then begin
    if (UserEngine.GetPlayObjectEx(LoadUser.sAccount, LoadUser.sCharName) <> nil) then begin
      UserEngine.KickPlayObjectEx(LoadUser.sAccount, LoadUser.sCharName);
      boReTry := True; //反回TRUE,则重新加入队列
      Exit;
    end;
  end;
  if not LoadUser.boIsHero then begin
    if not LoadHumRcdFromDB(LoadUser.sAccount, LoadUser.sCharName, LoadUser.sIPaddr, HumanRcd, LoadUser.nSessionID) then begin
      RunSocket.SendOutConnectMsg(LoadUser.nGateIdx, LoadUser.nSocket, LoadUser.nGSocketIdx);//强迫用户下线
    end else begin
      New(UserOpenInfo);
      UserOpenInfo.sAccount := LoadUser.sAccount;
      UserOpenInfo.sChrName := LoadUser.sCharName;
      UserOpenInfo.LoadUser := LoadUser^;
      UserOpenInfo.HumanRcd := HumanRcd;
      UserEngine.AddUserOpenInfo(UserOpenInfo);
      Result := True;
    end;
  end else begin
    nOpenStatus := -1;
    case LoadUser.btLoadDBType of
      0: if LoadHeroRcdFromDB(LoadUser.sAccount, LoadUser.sCharName, LoadUser.sIPaddr, HumanRcd, LoadUser.nSessionID) then nOpenStatus := 1;
      1: nOpenStatus := NewHeroRcd(LoadUser.sCharName, LoadUser.sMsg);
      2: if DelHeroRcd(LoadUser.sAccount, LoadUser.sCharName, LoadUser.sIPaddr, LoadUser.nSessionID) then nOpenStatus := 1;
      3: LoadUser.sMsg:= QueryHeroRcdFromDB(LoadUser.sAccount, LoadUser.sCharName, LoadUser.sIPaddr, LoadUser.sMsg, LoadUser.nSessionID);//20080514
      else nOpenStatus := 0;
    end;
    New(UserOpenInfo);
    UserOpenInfo.sAccount := LoadUser.sAccount;
    UserOpenInfo.sChrName := LoadUser.sCharName;
    UserOpenInfo.LoadUser := LoadUser^;
    UserOpenInfo.HumanRcd := HumanRcd;
    UserOpenInfo.nOpenStatus := nOpenStatus;
    UserEngine.AddUserOpenInfo(UserOpenInfo);
    Result := True;
  end;
end;

function TFrontEngine.InSaveRcdList(sAccount, sChrName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SaveRcdList.Count > 0 then begin//20081008
      for I := 0 to m_SaveRcdList.Count - 1 do begin
        if (pTSaveRcd(m_SaveRcdList.Items[I]).sAccount = sAccount) and
          (pTSaveRcd(m_SaveRcdList.Items[I]).sChrName = sChrName) then begin
          Result := True;
          Break;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.AddChangeGoldList(sGameMasterName, sGetGoldUserName: string;
  nGold: Integer);
var
  GoldInfo: pTGoldChangeInfo;
begin
  New(GoldInfo);
  GoldInfo.sGameMasterName := sGameMasterName;
  GoldInfo.sGetGoldUser := sGetGoldUserName;
  GoldInfo.nGold := nGold;
  m_ChangeGoldList.Add(GoldInfo);
end;

procedure TFrontEngine.AddToSaveRcdList(SaveRcd: pTSaveRcd);
begin
  EnterCriticalSection(m_UserCriticalSection);
  try
    m_SaveRcdList.Add(SaveRcd);
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.GetSaveRcd(sAccount, sCharName: string): pTSaveRcd;
var
  I: Integer;
  SaveRcd: pTSaveRcd;
begin
  Result := nil;
  EnterCriticalSection(m_UserCriticalSection);
  try
    if m_SaveRcdList.Count > 0 then begin
      for I := 0 to m_SaveRcdList.Count - 1 do begin
        SaveRcd := pTSaveRcd(m_SaveRcdList.Items[I]);
        if (SaveRcd.sAccount = sAccount) and
          (SaveRcd.sChrName = sCharName) then begin
          Result := SaveRcd;
          Break;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.UpDataSaveRcdList(SaveRcd: pTSaveRcd): Boolean; //2005-11-12 增加
var
  I: Integer;
  HumanRcd: pTSaveRcd;
begin
  Result := False;
  EnterCriticalSection(m_UserCriticalSection);
  try
    for I := m_SaveRcdList.Count - 1 downto 0 do begin
      if m_SaveRcdList.Count <= 0 then Break;//20080917
      HumanRcd := pTSaveRcd(m_SaveRcdList.Items[I]);
      if (HumanRcd.sAccount = SaveRcd.sAccount) and
        (HumanRcd.sChrName = SaveRcd.sChrName) then begin
        HumanRcd.HumanRcd := SaveRcd.HumanRcd;
        Result := True;  //清清改
       // m_SaveRcdList.Delete(I);
        //DisPoseAndNil(SaveRcd);
        Exit;
      end;
    end;
    m_SaveRcdList.Add(SaveRcd);
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

procedure TFrontEngine.DeleteHuman(nGateIndex, nSocket: Integer);
var
  I: Integer;
  LoadRcdInfo: pTLoadDBInfo;
begin
  EnterCriticalSection(m_UserCriticalSection);
  try
    for I := m_LoadRcdList.Count - 1 downto 0 do begin
      if m_LoadRcdList.Count <= 0 then Break;
      LoadRcdInfo := m_LoadRcdList.Items[I];
      if (LoadRcdInfo.nGateIdx = nGateIndex) and (LoadRcdInfo.nSocket = nSocket) then begin
        m_LoadRcdList.Delete(I);
        Dispose(LoadRcdInfo);
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(m_UserCriticalSection);
  end;
end;

function TFrontEngine.ChangeUserGoldInDB(GoldChangeInfo: pTGoldChangeInfo): Boolean;
var
  HumanRcd: THumDataInfo;
begin
  Result := False;
  if LoadHumRcdFromDB('1', GoldChangeInfo.sGetGoldUser, '1', HumanRcd, 1) then begin
    if ((HumanRcd.Data.nGold + GoldChangeInfo.nGold) > 0) and ((HumanRcd.Data.nGold + GoldChangeInfo.nGold) < 2000000000) then begin
      Inc(HumanRcd.Data.nGold, GoldChangeInfo.nGold);
      if SaveHumRcdToDB('1', GoldChangeInfo.sGetGoldUser, 1, False, HumanRcd) then begin
        UserEngine.sub_4AE514(GoldChangeInfo);
        Result := True;
      end;
    end;
  end;
end;

procedure TFrontEngine.Run;
begin
  Try
    ProcessGameDate();
    GetGameTime();
  except
    on E: Exception do begin
      MainOutMessage('{异常} TFrontEngine.Run');
    end;
  end;
end;

end.

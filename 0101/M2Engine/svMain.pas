//指针、数组等，越界后,程序会直接关闭无异常提示
unit svMain;

interface

uses
  Windows, Messages, SysUtils, Graphics, Controls, Forms, Dialogs,  Buttons,
  StdCtrls, IniFiles, M2Share, Grobal2, SDK, HUtil32, RunSock, Envir, ItmUnit,
  Magic, NoticeM, Guild, Event, Castle, FrnEngn, UsrEngn, Mudutil, Menus, ComCtrls, Grids,
  RzCommon, Common,RzEdit, RzPanel, RzSplit, RzGrids, Classes, JSocket, ExtCtrls,
  IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent, IdUDPBase,IdUDPClient;

type
  TFrmMain = class(TForm)
    Timer1: TTimer;
    RunTimer: TTimer;
    DBSocket: TClientSocket;
    ConnectTimer: TTimer;
    StartTimer: TTimer;
    SaveVariableTimer: TTimer;
    CloseTimer: TTimer;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    MENU_CONTROL_EXIT: TMenuItem;
    MENU_CONTROL_RELOAD_CONF: TMenuItem;
    MENU_CONTROL_CLEARLOGMSG: TMenuItem;
    MENU_HELP: TMenuItem;
    MENU_HELP_ABOUT: TMenuItem;
    MENU_MANAGE: TMenuItem;
    MENU_CONTROL_RELOAD: TMenuItem;
    MENU_CONTROL_RELOAD_ITEMDB: TMenuItem;
    MENU_CONTROL_RELOAD_MAGICDB: TMenuItem;
    MENU_CONTROL_RELOAD_MONSTERDB: TMenuItem;
    MENU_MANAGE_PLUG: TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_SERVERCONFIG: TMenuItem;
    MENU_OPTION_GAME: TMenuItem;
    MENU_OPTION_FUNCTION: TMenuItem;
    MENU_CONTROL_RELOAD_MONSTERSAY: TMenuItem;
    MENU_CONTROL_RELOAD_DISABLEMAKE: TMenuItem;
    MENU_CONTROL_GATE: TMenuItem;
    MENU_CONTROL_GATE_OPEN: TMenuItem;
    MENU_CONTROL_GATE_CLOSE: TMenuItem;                                        
    MENU_VIEW: TMenuItem;
    MENU_VIEW_SESSION: TMenuItem;
    MENU_VIEW_ONLINEHUMAN: TMenuItem;
    MENU_VIEW_LEVEL: TMenuItem;
    MENU_VIEW_LIST: TMenuItem;
    MENU_MANAGE_ONLINEMSG: TMenuItem;
    MENU_VIEW_KERNELINFO: TMenuItem;
    MENU_TOOLS: TMenuItem;
    MENU_TOOLS_MERCHANT: TMenuItem;
    MENU_TOOLS_NPC: TMenuItem;
    MENU_OPTION_ITEMFUNC: TMenuItem;
    MENU_TOOLS_MONGEN: TMenuItem;
    MENU_CONTROL_RELOAD_STARTPOINT: TMenuItem;
    G1: TMenuItem;
    MENU_OPTION_MONSTER: TMenuItem;
    MENU_TOOLS_IPSEARCH: TMenuItem;
    MENU_MANAGE_CASTLE: TMenuItem;
    MENU_HELP_REGKEY: TMenuItem;
    IdUDPClientLog: TIdUDPClient;
    RzSplitter: TRzSplitter;
    MemoLog: TRzMemo;
    RzSplitter1: TRzSplitter;
    Panel: TRzPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label5: TLabel;
    Lbcheck: TLabel;
    LbRunSocketTime: TLabel;
    LbRunTime: TLabel;
    LbTimeCount: TLabel;
    LbUserCount: TLabel;
    MemStatus: TLabel;
    GridGate: TRzStringGrid;
    QFunctionNPC: TMenuItem;
    LabelVersion: TLabel;
    QManageNPC: TMenuItem;
    RobotManageNPC: TMenuItem;
    MonItems: TMenuItem;
    MENU_OPTION_HERO: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    NPC1: TMenuItem;
    NPC2: TMenuItem;
    Timer2: TTimer;
    S1: TMenuItem;
    XXX1: TMenuItem;

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MemoLogChange(Sender: TObject);
    procedure MemoLogDblClick(Sender: TObject);
    procedure MENU_CONTROL_EXITClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_CONFClick(Sender: TObject);
    procedure MENU_CONTROL_CLEARLOGMSGClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_ITEMDBClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MAGICDBClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MONSTERDBClick(Sender: TObject);
    procedure MENU_HELP_ABOUTClick(Sender: TObject);
    procedure MENU_OPTION_SERVERCONFIGClick(Sender: TObject);
    procedure MENU_OPTION_GENERALClick(Sender: TObject);
    procedure MENU_OPTION_GAMEClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MENU_OPTION_FUNCTIONClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_MONSTERSAYClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_DISABLEMAKEClick(Sender: TObject);
    procedure MENU_CONTROL_GATE_OPENClick(Sender: TObject);
    procedure MENU_CONTROL_GATE_CLOSEClick(Sender: TObject);
    procedure MENU_CONTROLClick(Sender: TObject);
    procedure MENU_VIEW_GATEClick(Sender: TObject);
    procedure MENU_VIEW_SESSIONClick(Sender: TObject);
    procedure MENU_VIEW_ONLINEHUMANClick(Sender: TObject);
    procedure MENU_VIEW_LEVELClick(Sender: TObject);
    procedure MENU_VIEW_LISTClick(Sender: TObject);
    procedure MENU_MANAGE_ONLINEMSGClick(Sender: TObject);
    procedure MENU_VIEW_KERNELINFOClick(Sender: TObject);
    procedure MENU_TOOLS_MERCHANTClick(Sender: TObject);
    procedure MENU_OPTION_ITEMFUNCClick(Sender: TObject);
    procedure MENU_TOOLS_MONGENClick(Sender: TObject);
    procedure MENU_CONTROL_RELOAD_STARTPOINTClick(Sender: TObject);
    procedure MENU_MANAGE_PLUGClick(Sender: TObject);
    procedure G1Click(Sender: TObject);
    procedure MENU_OPTION_MONSTERClick(Sender: TObject);
    procedure MENU_TOOLS_IPSEARCHClick(Sender: TObject);
    procedure MENU_MANAGE_CASTLEClick(Sender: TObject);
    procedure MENU_HELP_REGKEYClick(Sender: TObject);
    procedure QFunctionNPCClick(Sender: TObject);
    procedure QManageNPCClick(Sender: TObject);
    procedure RobotManageNPCClick(Sender: TObject);
    procedure MonItemsClick(Sender: TObject);
    procedure MENU_OPTION_HEROClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure NPC1Click(Sender: TObject);
    procedure NPC2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure XXX1Click(Sender: TObject);
  private
    boServiceStarted: Boolean; //变量意思：服务开始
    procedure GateSocketClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);//客户边连接错误
    procedure GateSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket); //断开客户连接
    procedure GateSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);//客户端连接
    procedure GateSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);//客户端读取
    procedure DBSocketConnect(Sender: TObject; Socket: TCustomWinSocket);//数据库连接成功，显示远程IP及端口
    procedure DBSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);//数据库连接错误
    procedure DBSocketRead(Sender: TObject; Socket: TCustomWinSocket); //读取数据库数据

    procedure Timer1Timer(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure SaveVariableTimerTimer(Sender: TObject);
    procedure RunTimerTimer(Sender: TObject);
    procedure ConnectTimerTimer(Sender: TObject);

    procedure StartService();//起动服务器
    procedure StopService();//停止服务器
    procedure SaveItemNumber; //保存!Setup.txt内容
    function LoadClientFile(): Boolean;  //载入客户文件
    procedure StartEngine; //起动引擎
    procedure MakeStoneMines;//制造石矿
    procedure ReloadConfig(Sender: TObject);//再装载配置
    procedure ClearMemoLog(); //清除日志
    procedure CloseGateSocket(); //关闭连接
    procedure SaveItemsData;//保存数据 20080408
    { Private declarations }
  public
    GateSocket: TServerSocket;
    //procedure AppOnIdle(Sender: TObject; var Done: Boolean);//应用于空闲 //20080521 注释
    procedure OnProgramException(Sender: TObject; E: Exception);//在程序异常
    procedure SetMenu(); virtual;
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;  //响应 启动器的关闭消息
    procedure CreateParams(var Params:TCreateParams);override;//设置程序的类名 20080412
    { Public declarations }
  end;
  //procedure SaveItemsData;//20080408
  function LoadAbuseInformation(FileName: string): Boolean;  //载入滥用通知
  procedure LoadServerTable();//读取服务器IP及端口
  procedure WriteConLog(MsgList: TStringList); //写入日志
  procedure ChangeCaptionText(Msg: PChar; nLen: Integer); stdcall; //生成程序标题
  procedure UserEngineThread(ThreadInfo: pTThreadInfo); stdcall; //使用引擎线程
  procedure ProcessGameRun(); //游戏运行过程
  procedure TFrmMain_ChangeGateSocket(boOpenGateSocket: Boolean; nCRCA: Integer); stdcall;
var
  FrmMain: TFrmMain;
  g_GateSocket: TServerSocket;

implementation
uses
  LocalDB, InterServerMsg, InterMsgClient, IdSrvClient, FSrvValue, PlugIn,
  GeneralConfig, GameConfig, FunctionConfig, ObjRobot, ViewSession,
  ViewOnlineHuman, ViewLevel, ViewList, OnlineMsg, ViewKernelInfo,
  ConfigMerchant, ItemSet, ConfigMonGen, PlugInManage, EDcode, EDcodeUnit,
  GameCommand, MonsterConfig, RunDB, CastleManage, PlugOfEngine, {EngineRegister 注册窗口,}
  AboutUnit, HeroConfig, ViewList2;


var
  sCaption: string;
  l_dwRunTimeTick: LongWord;
  boRemoteOpenGateSocket: Boolean = False;
  boRemoteOpenGateSocketed: Boolean = False;
  boSaveData: Boolean = False;
  sChar: string = ' ?';
  sRun: string = 'Run';
  LogFile: TextFile;
  boBusy: Boolean = false;//20080715 增加判断TTimer 是否重入
  boBusy1: Boolean = false;//20080715 增加判断TTimer 是否重入
{$R *.dfm}


procedure ChangeCaptionText(Msg: PChar; nLen: Integer); stdcall; //生成程序标题
var
  sMsg: string;
begin
  if (nLen > 0) and (nLen < 50) then begin
    setlength(sMsg, nLen);
    Move(Msg^, sMsg[1], nLen);
    sCaptionExtText := sMsg;
  end;
end;
//判断是否加载M2注册插件(SystemModule.dll),如没有加载,则不让连接游戏网关 20071108
procedure TFrmMain_ChangeGateSocket(boOpenGateSocket: Boolean; nCRCA: Integer); stdcall;
begin
  //MainOutMessage ('g_Config.nServerFile_CRCA:'+inttostr(g_Config.nServerFile_CRCA)+'   '+inttostr(nCRCA));
  if g_Config.nServerFile_CRCA= nCRCA then//校对CRC码
    boRemoteOpenGateSocket := boOpenGateSocket;
end;
//加载文字过滤
function LoadAbuseInformation(FileName: string): Boolean;
var
  I: Integer;
  sText: string;
begin
  Result := False;
  if FileExists(FileName) then begin
    AbuseTextList.Clear;
    AbuseTextList.LoadFromFile(FileName);
    I := 0;
    while (True) do begin
      if AbuseTextList.Count <= I then Break;
      sText := Trim(AbuseTextList.Strings[I]);
      if sText = '' then begin
        AbuseTextList.Delete(I);
        Continue;//继续
      end;
      Inc(I);
    end;
    Result := True;
  end;
end;
//读取服务器IP及端口
procedure LoadServerTable();
var
  I, II: Integer;
  LoadList: TStringList;
  GateList: TStringList;
  sLineText, sGateMsg: string;
  sIPaddr, sPort: string;
begin
  if ServerTableList.Count > 0 then begin//20080629
    for I := 0 to ServerTableList.Count - 1 do begin
      TList(ServerTableList.Items[I]).Free;
    end;
  end;
  ServerTableList.Clear;
  if FileExists('.\!servertable.txt') then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile('.\!servertable.txt');
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[I]);
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sGateMsg := Trim(GetValidStr3(sLineText, sGateMsg, [' ', #9]));
        if sGateMsg <> '' then begin
          GateList := TStringList.Create;
          for II := 0 to 30 do begin
            if sGateMsg = '' then Break;
            sGateMsg := Trim(GetValidStr3(sGateMsg, sIPaddr, [' ', #9]));
            sGateMsg := Trim(GetValidStr3(sGateMsg, sPort, [' ', #9]));
            if (sIPaddr <> '') and (sPort <> '') then begin
              GateList.AddObject(sIPaddr, TObject(Str_ToInt(sPort, 0)));
            end;
          end;
          ServerTableList.Add(GateList);
          FreeAndNil(GateList);//20080117
        end;
      end;
    end;//for
    FreeAndNil(LoadList);
  end else begin
    ShowMessage('文件!servertable.txt未找到！！！');
  end;
end;
 //写入日志
procedure WriteConLog(MsgList: TStringList);
var
  I: Integer;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  sLogDir, sLogFileName: string;
begin
  if MsgList.Count <= 0 then Exit;
  DecodeDate(Date, Year, Month, Day);//根据日期值返回年、月、日值
  DecodeTime(Time, Hour, Min, Sec, MSec); //根据时间值返回时、分、秒、毫秒值
  if not DirectoryExists(g_Config.sConLogDir) then begin //DirectoryExists判断文件夹是否存在
    //CreateDirectory(PChar(g_Config.sConLogDir),nil);
    CreateDir(g_Config.sConLogDir);  //如无文件夹存在，则创建
  end;
  sLogDir := g_Config.sConLogDir + IntToStr(Year) + '-' + IntToStr2(Month) + '-' + IntToStr2(Day);
  if not DirectoryExists(sLogDir) then begin
    CreateDirectory(PChar(sLogDir), nil);
  end;
  sLogFileName := sLogDir + '\C-' + IntToStr(nServerIndex) + '-' + IntToStr2(Hour) + 'H' + IntToStr2((Min div 10 * 2) * 5) + 'M.txt';
  AssignFile(LogFile, sLogFileName);
  try//20081229
    if not FileExists(sLogFileName) then begin
      Rewrite(LogFile);
    end else begin
      Append(LogFile);
    end;
    if MsgList.Count > 0 then begin//20080629
      for I := 0 to MsgList.Count - 1 do begin
        Writeln(LogFile, '1' + #9 + MsgList.Strings[I]);
      end; // for
    end;
  finally//20081229
    CloseFile(LogFile);
  end;
end;
//保存!Setup.txt内容
procedure TFrmMain.SaveItemNumber();
var
  I: Integer;
begin
  try
    Config.WriteInteger('Setup', 'ItemNumber', g_Config.nItemNumber);
    Config.WriteInteger('Setup', 'ItemNumberEx', g_Config.nItemNumberEx);
    for I := Low(g_Config.GlobalVal) to High(g_Config.GlobalVal) do begin //保存系统变量
      {if g_Config.GlobalVal [I] > 0 then} Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(I), g_Config.GlobalVal[I]);//20090101 修改
    end;
    for I := Low(g_Config.GlobalAVal) to High(g_Config.GlobalAVal) do begin//保存系统变量 
      {if g_Config.GlobalAVal[I] <> '' then} Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(I), g_Config.GlobalAVal[I]);//20090101 修改
    end;
    Config.WriteInteger('Setup', 'WinLotteryCount', g_Config.nWinLotteryCount);
    Config.WriteInteger('Setup', 'NoWinLotteryCount', g_Config.nNoWinLotteryCount);
    Config.WriteInteger('Setup', 'WinLotteryLevel1', g_Config.nWinLotteryLevel1);
    Config.WriteInteger('Setup', 'WinLotteryLevel2', g_Config.nWinLotteryLevel2);
    Config.WriteInteger('Setup', 'WinLotteryLevel3', g_Config.nWinLotteryLevel3);
    Config.WriteInteger('Setup', 'WinLotteryLevel4', g_Config.nWinLotteryLevel4);
    Config.WriteInteger('Setup', 'WinLotteryLevel5', g_Config.nWinLotteryLevel5);
    Config.WriteInteger('Setup', 'WinLotteryLevel6', g_Config.nWinLotteryLevel6);
  except
  end;
end;

{procedure TFrmMain.AppOnIdle(Sender: TObject; var Done: Boolean); //20080521 注释
begin
  //   MainOutMessage ('空闲');
end;}

procedure TFrmMain.OnProgramException(Sender: TObject; E: Exception);
begin
  MainOutMessage(E.Message);
end;

procedure TFrmMain.DBSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;
//读取数据库数据,即DBserver.exe 回传的数据  20080219
procedure TFrmMain.DBSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var                   { UserDBSection:TRTLCriticalSection; //TRTLCriticalSection临界区类}
  tStr: string;
begin
  EnterCriticalSection(UserDBSection);//进入全局变量临界区
  try
    tStr := Socket.ReceiveText;  //ReceiveText表示收到的文本内容
    g_Config.sDBSocketRecvText := g_Config.sDBSocketRecvText + tStr;
    if not g_Config.boDBSocketWorking then begin
      g_Config.sDBSocketRecvText := '';
    end;
  finally
    LeaveCriticalSection(UserDBSection); //离开临界区
  end;
end;


procedure TFrmMain.Timer1Timer(Sender: TObject);
var
  I: Integer;
  nRow: Integer;
//sVerType: string;
//tTimeCount: Currency;
  GateInfo: pTGateInfo;
  nCode: Byte;
begin
  if boBusy1 then Exit;
  boBusy1:= True;
  nCode:= 0;
  try
    Try
      EnterCriticalSection(LogMsgCriticalSection);
      try
        nCode:= 1;
        if MemoLog.Lines.Count > 500 then MemoLog.Clear;
        if MainLogMsgList.Count > 0 then begin
          try
            nCode:= 2;
            if not FileExists(sLogFileName) then begin
              nCode:= 3;
              AssignFile(LogFile, sLogFileName);
              Rewrite(LogFile);
            end else begin
              nCode:= 4;
              AssignFile(LogFile, sLogFileName);
              Append(LogFile);
            end;
            nCode:= 5;
            for I := 0 to MainLogMsgList.Count - 1 do begin
              nCode:= 6;
              MemoLog.Lines.Add(MainLogMsgList.Strings[I]);
              Writeln(LogFile, MainLogMsgList.Strings[I]);
            end;
            nCode:= 7;
            MainLogMsgList.Clear;
            nCode:= 8;
            CloseFile(LogFile);
          except
            MemoLog.Lines.Add('保存日志信息出错！！！');
          end;
        end;
        nCode:= 9;
        if LogStringList.Count > 0 then begin
          for I := 0 to LogStringList.Count - 1 do begin
            try
              nCode:= 10;
              sCaption := '1' + #9 + IntToStr(g_Config.nServerNumber) + #9 + IntToStr(nServerIndex) + #9 + LogStringList.Strings[I];
              nCode:= 11;
              IdUDPClientLog.Send(sCaption); //发送游戏日志,文本内容
            except
              Continue;
            end;
          end;
          nCode:= 12;
          LogStringList.Clear;
        end;
        nCode:= 13;
        if LogonCostLogList.Count > 0 then begin
          nCode:= 14;
          WriteConLog(LogonCostLogList); //写入日志
          nCode:= 15;
          LogonCostLogList.Clear;
        end;
      finally
        LeaveCriticalSection(LogMsgCriticalSection);  //离开临界区
      end;

      {$IF SoftVersion = VERDEMO}
      sCaption := '[D]';
      {$ELSEIF SoftVersion = VERFREE}
      sCaption := '[F]';
      {$ELSEIF SoftVersion = VERSTD}
      sCaption := '[S]';
      {$ELSEIF SoftVersion = VEROEM}
      sCaption := '[O]';
      {$ELSEIF SoftVersion = VERPRO}
      sCaption := '[P]';
      {$ELSEIF SoftVersion = VERENT}
      sCaption := '[E]';
      {$IFEND}
      nCode:= 16;
      if nServerIndex = 0 then begin
        sCaption  := '[M]'+sCaption;
      end else begin
        if FrmMsgClient.MsgClient.Socket.Connected then begin
          sCaption  := '[S]'+sCaption;
        end else begin
          sCaption  := '[ ]'+sCaption;
        end;
      end;
      LabelVersion.Caption := sSoftVersionType;
      nCode:= 17;
      //GetTickCount()用于获取自windows启动以来经历的时间长度（毫秒）
      nRow := (GetTickCount() - g_dwStartTick) div 1000;
      LbRunTime.Caption := IntToStr(nRow div 3600) + ':' + IntToStr((nRow div 60) mod 60) + ':' + IntToStr(nRow mod 60) + ' ' + sCaption;
      LbUserCount.Caption := '怪物(' + IntToStr(UserEngine.MonsterCount) + ')     人物(' +
        IntToStr(UserEngine.OnlinePlayObject) + '/' +
        IntToStr(UserEngine.PlayObjectCount) + ')(' +
        IntToStr(UserEngine.LoadPlayCount) + '/' +
        IntToStr(UserEngine.m_PlayObjectFreeList.Count) + ')';
      nCode:= 18;
      Label1.Caption := Format('处理(%d/%d) 传输(%d/%d) 角色(%d/%d)', [nRunTimeMin, nRunTimeMax, g_nSockCountMin, g_nSockCountMax, g_nUsrTimeMin, g_nUsrTimeMax]);

      Label2.Caption := Format('人物(%d/%d) 循环(%d/%d) 交易(%d/%d) 管理(%d/%d) (%d)', [g_nHumCountMin,
          g_nHumCountMax,
          dwUsrRotCountMin,
          dwUsrRotCountMax,
          UserEngine.dwProcessMerchantTimeMin,
          UserEngine.dwProcessMerchantTimeMax,
          UserEngine.dwProcessNpcTimeMin,
          UserEngine.dwProcessNpcTimeMax,
          g_nProcessHumanLoopTime]);
      nCode:= 19;
      Label5.Caption := g_sMonGenInfo1 + ' - ' + g_sMonGenInfo2 + '    ';

      Label20.Caption := Format('刷新怪物(%d/%d/%d) 处理怪物(%d/%d/%d) 角色处理(%d/%d)', [g_nMonGenTime, g_nMonGenTimeMin, g_nMonGenTimeMax, g_nMonProcTime, g_nMonProcTimeMin, g_nMonProcTimeMax, g_nBaseObjTimeMin, g_nBaseObjTimeMax]);

      //MemStatus.Caption:='内存: ' + IntToStr(ROUND(AllocMemSize / 1024)) + 'KB';// + ' 内存块数: ' + IntToStr(AllocMemCount);
      //Lbcheck.Caption:='check' + IntToStr(g_CheckCode.dwThread0) + '/w' + IntToStr(g_ProcessMsg.wIdent) + '/' + IntToStr(g_ProcessMsg.nParam1) + '/' +  IntToStr(g_ProcessMsg.nParam2) + '/' +  IntToStr(g_ProcessMsg.nParam3) + '/' + g_ProcessMsg.sMsg;

      if dwStartTimeTick = 0 then dwStartTimeTick := GetTickCount;
      dwStartTime := (GetTickCount - dwStartTimeTick) div 1000;

      {  tTimeCount := GetTickCount() / 24 * 60 * 60 * 1000);
      if tTimeCount >= 36 then LbTimeCount.Font.Color := clRed
      else LbTimeCount.Font.Color := clBlack;
      LbTimeCount.Caption := CurrToStr(tTimeCount) + '天';}
      if (GetTickCount() / 86400000) >= 36 then LbTimeCount.Font.Color := clRed
      else LbTimeCount.Font.Color := clBlack;
      LbTimeCount.Caption := CurrToStr((GetTickCount() / 86400000)) + '天';
      nCode:= 20;
      // GridGate
      nRow := 1;
      for I := Low(g_GateArr) to High(g_GateArr) do begin
        GridGate.Cells[0, I + 1] := '';
        GridGate.Cells[1, I + 1] := '';
        GridGate.Cells[2, I + 1] := '';
        GridGate.Cells[3, I + 1] := '';
        GridGate.Cells[4, I + 1] := '';
        GridGate.Cells[5, I + 1] := '';
        GridGate.Cells[6, I + 1] := '';
        GateInfo := @g_GateArr[I];
        nCode:= 21;
        if GateInfo.boUsed and (GateInfo.Socket <> nil) then begin
          GridGate.Cells[0, nRow] := IntToStr(I);
          GridGate.Cells[1, nRow] := GateInfo.sAddr + ':' + IntToStr(GateInfo.nPort);
          GridGate.Cells[2, nRow] := IntToStr(GateInfo.nSendMsgCount);
          GridGate.Cells[3, nRow] := IntToStr(GateInfo.nSendedMsgCount);
          GridGate.Cells[4, nRow] := IntToStr(GateInfo.nSendRemainCount);
          if GateInfo.nSendMsgBytes < 1024 then begin
            GridGate.Cells[5, nRow] := IntToStr(GateInfo.nSendMsgBytes) + 'b';
          end else begin
            GridGate.Cells[5, nRow] := IntToStr(GateInfo.nSendMsgBytes div 1024) + 'kb';
          end;
          GridGate.Cells[6, nRow] := IntToStr(GateInfo.nUserCount) + '/' + IntToStr(GateInfo.UserList.Count);
          Inc(nRow);
        end;
      end;
      nCode:= 22;
      LbRunSocketTime.Caption := 'Soc' + IntToStr(g_nGateRecvMsgLenMin) + '/' + IntToStr(g_nGateRecvMsgLenMax) { + ' Ct' + IntToStr(CertCheck.Count) + '/' + IntToStr(EventCheck.Count)};
      Inc(nRunTimeMax);
      if g_nSockCountMax > 0 then Dec(g_nSockCountMax);
      if g_nUsrTimeMax > 0 then Dec(g_nUsrTimeMax);
      if g_nHumCountMax > 0 then Dec(g_nHumCountMax);
      if g_nMonTimeMax > 0 then Dec(g_nMonTimeMax);
      if dwUsrRotCountMax > 0 then Dec(dwUsrRotCountMax);
      if g_nMonGenTimeMin > 1 then Dec(g_nMonGenTimeMin, 2);
      if g_nMonProcTimeMin > 1 then Dec(g_nMonProcTimeMin, 2);
      if g_nBaseObjTimeMax > 0 then Dec(g_nBaseObjTimeMax);
    except
      on E: Exception do begin
        MainOutMessage('{异常} Timer1Timer Code:'+inttostr(nCode));
      end;
    end;
  finally
   boBusy1:= False;
  end;
end;

procedure TFrmMain.StartTimerTimer(Sender: TObject);
var
  nCode: Integer;
begin
  SendGameCenterMsg(SG_STARTNOW, '正在启动游戏主程序...');//发送游戏中心信息 与启动器的通信
  StartTimer.Enabled := False;
  FrmDB := TFrmDB.Create(); //生成数据库连接模块
  StartService(); //起动服务器
  try
    if SizeOf(THumDataInfo) <> SIZEOFTHUMAN then begin
      ShowMessage('sizeof(THuman) ' + IntToStr(SizeOf(THumDataInfo)) + ' <> SIZEOFTHUMAN ' + IntToStr(SIZEOFTHUMAN));
      Close;
      Exit;
    end;
    if not LoadClientFile then begin//如果没有加载客户端信息
      Close;
      Exit;
    end;
    if (nGetSysDate >= 0) and Assigned(PlugProcArray[nGetSysDate].nProcAddr) then begin//检查系统插件是否为IGE插件 20081203
      if PlugProcArray[nGetSysDate].nProcCode = 9 then begin
        Decode(addStringList('4?H;JH:=;8O4OI4>HJO8NIN>J;;O=5?J>;5HH;M:8O?;;I<>'), sCaptionExtText);//www.IGEM2.com 系统插件标识
        //Decode(addStringList('8<J8I84:IJ9:JNH4IO955<NI9:88=:<?'), sCaptionExtText);//一统内功版 标识：20081203
        if not TGetSysDate(PlugProcArray[nGetSysDate].nProcAddr)(Pchar(sCaptionExtText)) then Exit;
      end else Exit;
    end else Exit;
{$IF DBTYPE = BDE}  //设置Query的数据库连接属性
    FrmDB.Query.DatabaseName := sDBName;
{$ELSE}
    FrmDB.Query.ConnectionString := g_sADODBString;
{$IFEND}
    LoadGameLogItemNameList();//加载游戏日志物品名
    LoadDenyIPAddrList();  //加载IP过滤列表
    LoadDenyAccountList();   //加载登录帐号过滤列表
    LoadDenyChrNameList();//加载禁止登录人物列表
    LoadNoClearMonList();    //加载不清除怪物列表
    //g_Config.nServerFile_CRCB := CalcFileCRC(Application.ExeName); //未使用 20080504
    nCode := FrmDB.LoadItemsDB;
    if nCode < 0 then begin
      MemoLog.Lines.Add('物品数据库加载失败！！！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add(Format('加载物品数据库成功(%d)...', [UserEngine.StdItemList.Count]));
    end;

    nCode := FrmDB.LoadMinMap;
    if nCode < 0 then begin
      MemoLog.Lines.Add('小地图数据加载失败！！！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add('加载小地图数据成功...');
    end;

    nCode := FrmDB.LoadMapInfo;
    if nCode < 0 then begin
      MemoLog.Lines.Add('地图数据加载失败！！！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add(Format('加载地图数据成功(%d)...', [g_MapManager.Count]));
    end;

    nCode := FrmDB.LoadMonsterDB;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载怪物数据库失败！！！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add(Format('加载怪物数据库成功(%d)...', [UserEngine.MonsterList.Count]));
    end;

    nCode := FrmDB.LoadMagicDB;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载技能数据库失败！！！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add(Format('加载技能数据库成功(%d)...', [UserEngine.m_MagicList.Count]));
    end;

    nCode := FrmDB.LoadMonGen;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载怪物刷新配置信息失败！！！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add(Format('加载怪物刷新配置信息成功(%d)...', [UserEngine.m_MonGenList.Count]));
    end;

    if LoadMonSayMsg() then MemoLog.Lines.Add(Format('加载怪物说话配置信息成功(%d)...', [g_MonSayMsgList.Count]));

    LoadDisableTakeOffList(); //加载禁止取下物品列表
    LoadMonDropLimitList();   //加载怪物爆物品限制列表
    LoadDisableMakeItem();    //加载禁止制造物品列表
    LoadEnableMakeItem();     //加载可制造物品列表
    LoadDisableMoveMap;       //加载禁止移动地图列表
    ItemUnit.LoadCustomItemName();
    LoadDisableSendMsgList();  //加载禁止发信息名称列表
    LoadItemBindIPaddr();      //加载捆绑IP列表
    LoadItemBindAccount();
    LoadItemBindCharName();
    LoadItemBindDieNoDropName();//读取人物装备死亡不爆列表 20081127
    LoadUnMasterList();       //加载出师记录表
    LoadUnForceMasterList();  //加载强行出师记录表
    LoadItemDblClickList();

    LoadAllowPickUpItemList(); //加载允许捡取物品

    {LoadAllowSellOffItemList(); //加载允许出售列表  //20080416 去掉拍卖功能

    MemoLog.Lines.Add('正在加载寄售物品数据库...');
    g_SellOffGoldList.LoadSellOffGoldList();
    g_SellOffGoodList.LoadSellOffGoodList();
    MemoLog.Lines.Add(Format('加载寄售物品数据库成功(%d)...', [g_SellOffGoodList.RecCount])); }

    g_Storage.LoadBigStorageList(g_StorageFileName); //加载无限仓库数据
    //MemoLog.Lines.Add(Format('加载无限仓库数据库成功(%d/%d)...', [g_Storage.HumManCount, g_Storage.RecordCount]));

    nCode := FrmDB.LoadUnbindList;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载捆装物品信息失败！！！' + '代码: ' + IntToStr(nCode));
      Exit;
    end else begin
      MemoLog.Lines.Add('加载捆装物品信息成功...');
    end;

    LoadBindItemTypeFromUnbindList(); //加载捆装物品类型

    nCode := FrmDB.LoadMapQuest;
    if nCode > 0 then begin
      MemoLog.Lines.Add('加载任务地图信息成功...');
    end else begin
      MemoLog.Lines.Add('加载任务地图信息失败！！！');
      Exit;
    end;

    nCode := FrmDB.LoadMapEvent;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载地图触发事件信息失败！！！');
      Exit;
    end else begin
      MemoLog.Lines.Add('加载地图触发事件信息成功...');
    end;

    nCode := FrmDB.LoadQuestDiary;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载任务说明信息失败！！！');
      Exit;
    end else begin
      MemoLog.Lines.Add('加载任务说明信息成功...');
    end;

    if LoadAbuseInformation('.\!abuse.txt') then MemoLog.Lines.Add('加载文字过滤信息成功...');

    if LoadLineNotice(g_Config.sNoticeDir + 'LineNotice.txt') then begin
      MemoLog.Lines.Add('加载公告提示信息成功...');
    end else MemoLog.Lines.Add('加载公告提示信息失败！！！');

    LoadUserCmdList();//加载自定义命令 20080729
    LoadCheckItemList();//加载禁止物品规则 20080729
    LoadMsgFilterList();//加载消息过滤 20080729
    LoadShopItemList();//加载商铺配置 20080730

    FrmDB.LoadAdminList();//加载管理员列表
    g_GuildManager.LoadGuildInfo();//加载行会列表

    FrmDB.LoadBoxsList; //20080114
    MemoLog.Lines.Add('加载宝箱配置成功('+IntToStr(BoxsList.Count)+')...');

    FrmDB.LoadSuitItemList();//读取套装装备数据 20080225
    MemoLog.Lines.Add('加载套装配置成功('+IntToStr(SuitItemList.Count)+')...');

    FrmDB.LoadSellOffItemList();//读取元宝寄售列表 20080316
    MemoLog.Lines.Add('加载元宝寄售数据成功('+IntToStr(sSellOffItemList.Count)+')...');

    FrmDB.LoadRefineItem;//20080502
    MemoLog.Lines.Add('加载淬炼配置信息成功('+IntToStr(g_RefineItemList.Count)+')...');

    g_CastleManager.LoadCastleList();
    MemoLog.Lines.Add('加载城堡列表成功...');

    NoticeManager.LoadingNotice;//读取公告  20080815 从UserEngine.Run中移动到此处读取
    
    //UserCastle.Initialize;
    g_CastleManager.Initialize;
    MemoLog.Lines.Add('城堡城初始完成...');
    if (nServerIndex = 0) then FrmSrvMsg.StartMsgServer
    else FrmMsgClient.ConnectMsgServer;
    StartEngine();
    boStartReady := True;
    //Sleep(500);//20080520 注释

    ConnectTimer.Enabled := True;

    g_dwRunTick := GetTickCount();

    n4EBD1C := 0;
    g_dwUsrRotCountTick := GetTickCount();

    RunTimer.Enabled := True;
    SendGameCenterMsg(SG_STARTOK, '游戏主程序启动完成...');
    GateSocket.Address := g_Config.sGateAddr;
    GateSocket.Port := g_Config.nGatePort;
    g_GateSocket := GateSocket;
   // boRemoteOpenGateSocket:=True; //设置网关连接M2,但此代码是由插件SystemModule.dll,来判断,加载插件并注册M2,即可网关连接上M2  2007.10.11
   // if g_boMinimize then Application.Minimize;//启动完成后最小化
    Timer2.Enabled:=True;
    dwSaveDataTick := GetTickCount();//20080830 增加
    SendGameCenterMsg(SG_CHECKCODEADDR, IntToStr(Integer(@g_CheckCode)));
  except
    on E: Exception do
      MainOutMessage('服务器启动异常！！！' + E.Message);
  end;
end;
//开始运行引擎
procedure TFrmMain.StartEngine();
var
  nCode: Integer;
begin
  try
    HeroAddSkillToHum(sProductName1,sProgram1,sWebSite1,sBbsSite1,sProductInfo1,sSellInfo1);//20081018 判断是否需要显示指定的文本
{$IF IDSOCKETMODE = TIMERENGINE}
    FrmIDSoc.Initialize;
    MemoLog.Lines.Add('登录服务器连接初始化完成...');
{$IFEND}
    g_MapManager.LoadMapDoor;
    MemoLog.Lines.Add('加载地图环境成功...');

    MakeStoneMines();//制造矿物, 初始化有点久 20080520
    MemoLog.Lines.Add('矿物数据初始成功...');
    nCode := FrmDB.LoadMerchant;
    if nCode < 0 then begin
      MemoLog.Lines.Add('交易NPC列表加载失败 ！！！' + '错误码: ' + IntToStr(nCode));
      Exit;
    end else MemoLog.Lines.Add('加载交易NPC列表成功...');

    if not g_Config.boVentureServer then begin
      nCode := FrmDB.LoadGuardList;
      if nCode < 0 then begin
        MemoLog.Lines.Add('守卫列表加载失败 ！！！' + '错误码: ' + IntToStr(nCode));
      end else MemoLog.Lines.Add('加载守卫列表成功...');
    end;

    nCode := FrmDB.LoadNpcs;
    if nCode < 0 then begin
      MemoLog.Lines.Add('管理NPC列表加载失败 ！！！' + '错误码: ' + IntToStr(nCode));
      Exit;
    end else MemoLog.Lines.Add('加载管理NPC列表成功...');

    nCode := FrmDB.LoadMakeItem;
    if nCode < 0 then begin
      MemoLog.Lines.Add('炼制物品信息加载失败 ！！！' + '错误码: ' + IntToStr(nCode));
      Exit;
    end else MemoLog.Lines.Add('加载炼制物品信息成功...');

    nCode := FrmDB.LoadStartPoint;
    if nCode < 0 then begin
      MemoLog.Lines.Add('加载回城点配置时出现错误 ！！！(错误码: ' + IntToStr(nCode) + ')');
      Close;
    end else MemoLog.Lines.Add('加载回城点配置成功...');

    FrontEngine.Resume;
    MemoLog.Lines.Add('人物数据引擎启动成功...');

    UserEngine.Initialize;
    MemoLog.Lines.Add('游戏处理引擎初始化成功...');
    g_MapManager.MakeSafePkZone; //安全区光圈

    Decode(addStringList('5NJN4H4N>8O9N9<JHJO8NIN>J;;O=5?JJ5OH==JH;<O?4I9?'), sCaptionExtText);//www.IGEM2.com.cn
    Caption := sCaption + ' [' + sCaptionExtText + ']';//设置M2标题

    if not boShowSetTxt then begin
      Decode(addStringList(g_sProductInfo), sCaptionExtText);
      MainOutMessage(sCaptionExtText);

      Decode(addStringList(g_sWebSite), sCaptionExtText);
      MainOutMessage(sCaptionExtText);

      Decode(addStringList(g_sBbsSite), sCaptionExtText);
      MainOutMessage(sCaptionExtText);

      Decode(addStringList(g_sSellInfo1), sCaptionExtText);
      MainOutMessage(sCaptionExtText);
    end else begin
      MainOutMessage(sProductInfo1);
      MainOutMessage(sWebSite1);
      MainOutMessage(sBbsSite1);
      MainOutMessage(sSellInfo1);
    end;
    //20071106
    if (nStartModule >= 0) and Assigned(PlugProcArray[nStartModule].nProcAddr) then begin
      if PlugProcArray[nStartModule].nProcCode = 1 then TStartProc(PlugProcArray[nStartModule].nProcAddr);
    end;

    PlugInEngine.StartPlugMoudle;
    MemoLog.Lines.Add('引擎插件初始化成功...');
    boSaveData := True;//保存数据
    HeroAddSkill(FrmMain.Caption);//20080603 //判断M2标题是否被破解修改
    SaveVariableTimer.Enabled:=True;//20080831 增加
  except
    MainOutMessage('服务启动时出现异常错误 ！！！');
  end;
end;
//制造石矿
procedure TFrmMain.MakeStoneMines();
var
  I, nW, nH: Integer;
  Envir: TEnvirnoment;
begin
  for I := 0 to g_MapManager.Count - 1 do begin
    Envir := TEnvirnoment(g_MapManager.Items[I]);
    if Envir.m_boMINE then begin
      for nW := 0 to Envir.m_nWidth - 1 do begin
        for nH := 0 to Envir.m_nHeight - 1 do begin
          //if (nW mod 2 = 0) and (nH mod 2 = 0) then
          TStoneMineEvent.Create(Envir, nW, nH, ET_STONEMINE);
        end;
      end;
    end;
  end;//for
end;
//读取客户端版本信息
function TFrmMain.LoadClientFile(): Boolean;
begin
//  Result := True;
  if not (g_Config.sClientFile1 = '') then g_Config.nClientFile1_CRC := CalcFileCRC(g_Config.sClientFile1);
  //if not (g_Config.sClientFile2 = '') then g_Config.nClientFile2_CRC := CalcFileCRC(g_Config.sClientFile2);
  //if not (g_Config.sClientFile3 = '') then g_Config.nClientFile3_CRC := CalcFileCRC(g_Config.sClientFile3);
  if (g_Config.nClientFile1_CRC <> 0) {or (g_Config.nClientFile2_CRC <> 0) or (g_Config.nClientFile3_CRC <> 0)} then begin
    MemoLog.Lines.Add('加载客户端版本信息成功...');
    Result := True;
  end else begin
    MemoLog.Lines.Add('加载客户端版本信息失败！！！');
    Result := False;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  nX, nY: Integer;
begin
  Randomize;
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  nX := Str_ToInt(ParamStr(2), -1);
  nY := Str_ToInt(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  GridGate.RowCount := 21;
  GridGate.Cells[0, 0] := '网关';
  GridGate.Cells[1, 0] := '网关地址';
  GridGate.Cells[2, 0] := '队列数据';
  GridGate.Cells[3, 0] := '发送数据';
  GridGate.Cells[4, 0] := '剩余数据';
  GridGate.Cells[5, 0] := '平均流量';
  GridGate.Cells[6, 0] := '最高人数';

  GateSocket := TServerSocket.Create(Owner);
  GateSocket.OnClientConnect := GateSocketClientConnect;
  GateSocket.OnClientDisconnect := GateSocketClientDisconnect;
  GateSocket.OnClientError := GateSocketClientError;
  GateSocket.OnClientRead := GateSocketClientRead;

  DBSocket.OnConnect := DBSocketConnect;//写DBServer连接成功后,提示
  DBSocket.OnError := DBSocketError;
  DBSocket.OnRead := DBSocketRead;//接收DBserver.exe 回传的数据

  Timer1.OnTimer := Timer1Timer;
  RunTimer.OnTimer := RunTimerTimer;
  StartTimer.OnTimer := StartTimerTimer;
  SaveVariableTimer.OnTimer := SaveVariableTimerTimer;
  ConnectTimer.OnTimer := ConnectTimerTimer;
  CloseTimer.OnTimer := CloseTimerTimer;
  MemoLog.OnChange := MemoLogChange;  
  StartTimer.Enabled := True;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
resourcestring
  sCloseServerYesNo = '是否确认关闭游戏服务器？';
  sCloseServerTitle = '确认信息';
begin
  if not boServiceStarted then begin   //如果没有服务开始
    //    Application.Terminate;
    Exit;
  end;
  if g_boExitServer then begin
    boStartReady := False;
    Exit;
  end;
  CanClose := False;
  if Application.MessageBox(PChar(sCloseServerYesNo), PChar(sCloseServerTitle), MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    g_boExitServer := True;
    CloseGateSocket();
    g_Config.boKickAllUser := True;
    //RunSocket.CloseAllGate;
    //GateSocket.Close;
    CloseTimer.Enabled := True;
  end;
end;

procedure TFrmMain.CloseTimerTimer(Sender: TObject);
begin
  //FrmDB.SaveSellOffItemList;//保存元宝寄售列表 20080317
  Caption := Format('%s [正在关闭服务器(%s %d/%s %d)...]', [g_Config.sServerName, '人物', UserEngine.OnlinePlayObject, '数据', FrontEngine.SaveListCount]);
  if UserEngine.OnlinePlayObject = 0 then begin
    if FrontEngine.IsIdle then begin
      CloseTimer.Enabled := False;
      Caption := Format('%s [服务器已关闭]', [g_Config.sServerName]);
      boSaveData := False;
      dwSaveDataTick := GetTickCount() - 600000{1000 * 60 * 10};
      SaveItemsData;
      StopService;
      Close;
    end;
  end;
end;
//保存物品数据 20080408
procedure TFrmMain.SaveItemsData;
begin
  if GetTickCount() - dwSaveDataTick > 480000{1000 * 60 * 8} then begin
    dwSaveDataTick := GetTickCount();
    //if g_SellOffGoodList <> nil then g_SellOffGoodList.SaveSellOffGoodList(); //20080416 去掉拍卖功能
    //if g_SellOffGoldList <> nil then g_SellOffGoldList.SaveSellOffGoldList(); //20080416 去掉拍卖功能
    if (sSellOffItemList <> nil) and (sSellOffItemList.Count > 0) then FrmDB.SaveSellOffItemList();//保存元宝寄售数据  20080408
    if g_Storage <> nil then g_Storage.SaveToFile(g_StorageFileName);
    SaveItemNumber();//20080408
  end;
end;

procedure TFrmMain.SaveVariableTimerTimer(Sender: TObject);
begin
  Try
    //SaveItemNumber();//20080408
    if boSaveData then SaveItemsData;
  except
    on E: Exception do begin
      MainOutMessage('{异常} SaveVariableTimerTimer');
    end;
  end;
end;

procedure TFrmMain.GateSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  RunSocket.CloseErrGate(Socket, ErrorCode);
end;

procedure TFrmMain.GateSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  RunSocket.CloseGate(Socket);
end;

procedure TFrmMain.GateSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  RunSocket.AddGate(Socket);
end;

procedure TFrmMain.GateSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  RunSocket.SocketRead(Socket);
end;

procedure TFrmMain.RunTimerTimer(Sender: TObject);
begin
  if boBusy then Exit;
  boBusy:= True;
  try
    Try
      if boStartReady then begin
        RunSocket.Execute;
        FrmIDSoc.Run;
        UserEngine.Execute;//引擎启动
        ProcessGameRun();
        if nServerIndex = 0 then
          //FrmSrvMsg.Run//20080815 注释(反调试)
        else FrmMsgClient.Run;
      end;
      Inc(n4EBD1C);
      if (GetTickCount - g_dwRunTick) > 250 then begin
        g_dwRunTick := GetTickCount();
        nRunTimeMin := n4EBD1C;
        if nRunTimeMax > nRunTimeMin then nRunTimeMax := nRunTimeMin;
        n4EBD1C := 0;
      end;
      if boRemoteOpenGateSocket then begin
        if not boRemoteOpenGateSocketed then begin
          boRemoteOpenGateSocketed := True;
          try
            if Assigned(g_GateSocket) then begin
              g_GateSocket.Active := True; //打开网关端口
            end;
          except
            on E: Exception do begin
                MainOutMessage('{异常} TFrmMain.RunTimerTimer');
            end;
          end;
        end;
      end else begin
        if Assigned(g_GateSocket) then begin
          if g_GateSocket.Socket.Connected then g_GateSocket.Active := False;
        end;
      end;
    except
      on E: Exception do begin
        MainOutMessage('{异常} RunTimerTimer');
      end;
    end;
  finally
   boBusy:= False;
  end;
end;
//间隔三秒，检查DBS连接是否正常
procedure TFrmMain.ConnectTimerTimer(Sender: TObject);
begin
  Try
    if DBSocket.Active then Exit;
    DBSocket.Active := True;
  except
    on E: Exception do begin
      MainOutMessage('{异常} ConnectTimerTimer');
    end;
  end;
end;

procedure TFrmMain.ReloadConfig(Sender: TObject);
begin
  try
    LoadConfig();
    FrmIDSoc.Timer1Timer(Sender);
    if not (nServerIndex = 0) then begin
      if not FrmMsgClient.MsgClient.Active then begin
        FrmMsgClient.MsgClient.Active := True;
      end;
    end;
    IdUDPClientLog.Host := g_Config.sLogServerAddr;
    IdUDPClientLog.Port := g_Config.nLogServerPort;
    LoadServerTable();
    LoadClientFile();
  finally

  end;
end;

procedure TFrmMain.MemoLogChange(Sender: TObject);
begin
  if MemoLog.Lines.Count > 500 then MemoLog.Clear;
end;

procedure TFrmMain.MemoLogDblClick(Sender: TObject);
begin
  ClearMemoLog();
end;

procedure TFrmMain.MENU_CONTROL_EXITClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_CONFClick(Sender: TObject);
begin
  ReloadConfig(Sender);
end;

procedure TFrmMain.MENU_CONTROL_CLEARLOGMSGClick(Sender: TObject);
begin
  ClearMemoLog();
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
  ReloadConfig(Sender);
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_ITEMDBClick(Sender: TObject);
begin
  FrmDB.LoadItemsDB();
  MainOutMessage('重新加载物品数据库完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MAGICDBClick(Sender: TObject);
begin
  FrmDB.LoadMagicDB();
  MainOutMessage('重新加载技能数据库完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MONSTERDBClick(Sender: TObject);
begin
  FrmDB.LoadMonsterDB();
  MainOutMessage('重新加载怪物数据库完成...');
end;

procedure TFrmMain.StartService;
var
  TimeNow: TDateTime;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  Config: pTConfig;
  s, sTemp: string;
begin
  Config := @g_Config;
{初始化参数}
  nRunTimeMax := 99999;
  g_nSockCountMax := 0;
  g_nUsrTimeMax := 0;
  g_nHumCountMax := 0;
  g_nMonTimeMax := 0;
  g_nMonGenTimeMax := 0;
  g_nMonProcTime := 0;
  g_nMonProcTimeMin := 0;
  g_nMonProcTimeMax := 0;
  dwUsrRotCountMin := 0;
  dwUsrRotCountMax := 0;
  g_nProcessHumanLoopTime := 0;
  g_dwHumLimit := 30;
  g_dwMonLimit := 30;
  g_dwZenLimit := 5;
  g_dwNpcLimit := 5;
  g_dwSocLimit := 10;
  nDecLimit := 20;
  Config.sDBSocketRecvText := '';
  Config.boDBSocketWorking := False;
  Config.nLoadDBErrorCount := 0;
  Config.nLoadDBCount := 0;
  Config.nSaveDBCount := 0;
  Config.nDBQueryID := 0;
  Config.nItemNumber := 0;
  Config.nItemNumberEx := High(Integer) div 2;
  boStartReady := False;
  g_boExitServer := False;
  boFilterWord := True;
  Config.nWinLotteryCount := 0;
  Config.nNoWinLotteryCount := 0;
  Config.nWinLotteryLevel1 := 0;
  Config.nWinLotteryLevel2 := 0;
  Config.nWinLotteryLevel3 := 0;
  Config.nWinLotteryLevel4 := 0;
  Config.nWinLotteryLevel5 := 0;
  Config.nWinLotteryLevel6 := 0;
  FillChar(g_Config.GlobalVal, SizeOf(g_Config.GlobalVal), #0);//FillChar()给特定的数据填入指定的字符
  FillChar(g_Config.GlobaDyMval, SizeOf(g_Config.GlobaDyMval), #0);
  FillChar(g_Config.GlobalAVal, SizeOf(g_Config.GlobalAVal), #0);
(*{$IF USECODE = USEREMOTECODE} //如果使用代码来自远程代码  20080831 注释
  New(Config.Encode6BitBuf);
  Config.Encode6BitBuf^ := g_Encode6BitBuf;

  New(Config.Decode6BitBuf);
  Config.Decode6BitBuf^ := g_Decode6BitBuf;
{$IFEND}*)
  LoadConfig();
  Memo := MemoLog;
  nServerIndex := 0;
  PlugInEngine := TPlugInManage.Create;
  zPlugOfEngine := TPlugOfEngine.Create;
  RunSocket := TRunSocket.Create();
  MainLogMsgList := TStringList.Create;
  LogStringList := TStringList.Create;
  LogonCostLogList := TStringList.Create;
  g_MapManager := TMapManager.Create;
  ItemUnit := TItemUnit.Create;
  MagicManager := TMagicManager.Create;
  NoticeManager := TNoticeManager.Create;
  g_GuildManager := TGuildManager.Create;
  g_EventManager := TEventManager.Create;
  g_CastleManager := TCastleManager.Create;
  {  g_UserCastle        := TUserCastle.Create;
  CastleManager.Add(g_UserCastle); }
  FrontEngine := TFrontEngine.Create(True);
  UserEngine := TUserEngine.Create();
  RobotManage := TRobotManage.Create;
  g_MakeItemList := TStringList.Create;
  g_RefineItemList := TStringList.Create;//淬炼配置列表 20080502
  g_StartPointList := TGStringList.Create;
  ServerTableList := TList.Create;
  g_DenySayMsgList := TQuickList.Create;
  MiniMapList := TStringList.Create;
  g_UnbindList := TStringList.Create;
  LineNoticeList := TStringList.Create;
  g_UserCmdList:= TStringList.Create;//自定义命令列表 20080729
  g_CheckItemList:= TList.Create;//禁止物品规则 20080729
  g_MsgFilterList:= TList.Create;//消息过滤规则 20080729
  g_ShopItemList:= TList.Create;//商铺物品列表 20080730
  QuestDiaryList := TList.Create;
  BoxsList:= TList.Create;//20080114 宝箱
  SuitItemList:= TList.Create;//20080225 套装
  sSellOffItemList:= TList.Create;//元宝寄售列表 20080316
  ItemEventList := TStringList.Create;
  AbuseTextList := TStringList.Create;
  g_MonSayMsgList := TStringList.Create;
  g_DisableMakeItemList := TGStringList.Create;
  g_EnableMakeItemList := TGStringList.Create;
  g_DisableMoveMapList := TGStringList.Create;
  g_ItemNameList := TGList.Create;
  g_DisableSendMsgList := TGStringList.Create;
  g_MonDropLimitLIst := TGStringList.Create;
  g_DisableTakeOffList := TGStringList.Create;
  g_UnMasterList := TGStringList.Create;
  g_UnForceMasterList := TGStringList.Create;
  g_GameLogItemNameList := TGStringList.Create;
  g_DenyIPAddrList := TGStringList.Create;
  g_DenyChrNameList := TGStringList.Create;
  g_DenyAccountList := TGStringList.Create;
  g_NoClearMonList := TGStringList.Create;

  g_ItemBindIPaddr := TGList.Create;
  g_ItemBindAccount := TGList.Create;
  g_ItemBindCharName := TGList.Create;//物品人物绑定表(对应的玩家才能戴物品)
  g_ITemBindDieNoDropName := TGList.Create;//人物装备死亡不爆列表

 {g_AllowSellOffItemList := TGStringList.Create;//20080416 去掉拍卖功能
  g_SellOffGoodList := TSellOffGoodList.Create;//20080416 去掉拍卖功能
  g_SellOffGoldList := TSellOffGoldList.Create;//20080416 去掉拍卖功能 }
  g_Storage := TStorage.Create;

  g_MapEventListOfDropItem := TGList.Create;
  g_MapEventListOfPickUpItem := TGList.Create;
  g_MapEventListOfMine := TGList.Create;
  g_MapEventListOfWalk := TGList.Create;
  g_MapEventListOfRun := TGList.Create;

  InitializeCriticalSection(LogMsgCriticalSection);
  InitializeCriticalSection(ProcessMsgCriticalSection);
  InitializeCriticalSection(ProcessHumanCriticalSection);
  InitializeCriticalSection(HumanSortCriticalSection);
  InitializeCriticalSection(Config.UserIDSection);
  InitializeCriticalSection(UserDBSection);
  //CS_6 := TCriticalSection.Create;//未使用 20080407
  g_DynamicVarList := TList.Create;

  AddToProcTable(@TPlugOfEngine_SetUserLicense, PChar(Base64DecodeStr('U2V0VXNlckxpY2Vuc2U=')),5); //  SetUserLicense
  AddToProcTable(@TFrmMain_ChangeGateSocket, PChar(Base64DecodeStr('Q2hhbmdlR2F0ZVNvY2tldA==')),6); //ChangeGateSocket

  TimeNow := Now();
  DecodeDate(TimeNow, Year, Month, Day);
  DecodeTime(TimeNow, Hour, Min, Sec, MSec);
  if not DirectoryExists(g_Config.sLogDir) then begin
    CreateDir(Config.sLogDir);
  end;

  sLogFileName := g_Config.sLogDir {'.\Log\'} + IntToStr(Year) + '-' + IntToStr2(Month) + '-' + IntToStr2(Day) + '.' + IntToStr2(Hour) + '-' + IntToStr2(Min) + '.txt';
  AssignFile(LogFile, sLogFileName);
  Rewrite(LogFile);
  CloseFile(LogFile);
  Caption := '';
  PlugInEngine.LoadPlugIn();
  nShiftUsrDataNameNo := 1;

  DBSocket.Address := g_Config.sDBAddr;
  DBSocket.Port := g_Config.nDBPort;
  Caption := g_Config.sServerName;
  sCaption := g_Config.sServerName;
  LoadServerTable();
{$IF HEROVERSION = 1}
  sTemp:=addStringList(sSoftVersion_HERO);
  Decode(sTemp, sSoftVersionType); //英雄版
  MENU_OPTION_HERO.Visible := True;
{$ELSE}
  sTemp:=addStringList(sSoftVersion_VERENT);
  Decode(sTemp, sSoftVersionType); //企业版
  MENU_OPTION_HERO.Visible := False;
{$IFEND}
  if not Decode(sUserQQKey, s) then begin//判断是否被破解 20080603
    nCrackedLevel := Random(10000);
    nErrorLevel := Random(10000);
  end else begin
    if Str_ToInt(s, -1) <> nUserLicense then begin
      nCrackedLevel := Random(10000);
      nErrorLevel := Random(10000);
    end;
  end;
{$IF TESTMODE = 1}
  MainOutMessage('CrackedLevel_1:'+inttostr(nCrackedLevel)+'  ErrorLevel:'+inttostr(nErrorLevel));
{$IFEND}
  IdUDPClientLog.Host := g_Config.sLogServerAddr;
  IdUDPClientLog.Port := g_Config.nLogServerPort;

  //Application.OnIdle := AppOnIdle;//20080521 注释
  Application.OnException := OnProgramException;//测试注释
  //dwRunDBTimeMax := GetTickCount();//20080728 注释
  g_dwStartTick := GetTickCount();

  boServiceStarted := True;

  dwSaveDataTick := GetTickCount() + 300000{1000 * 60 * 5};
  g_StorageFileName := g_Config.sEnvirDir + '\Market_Storage\';
  if not DirectoryExists(g_StorageFileName) then begin
    ForceDirectories(g_StorageFileName);
  end;
  g_StorageFileName := g_StorageFileName + 'UserStorage.db';
  Timer1.Enabled := True;
end;

procedure TFrmMain.StopService;
var
  I, K: Integer;
  Config1: pTConfig;
begin
  try
    Config1 := @g_Config;
    Timer1.Enabled := False;
    RunTimer.Enabled := False;
    FrmIDSoc.Close;
    GateSocket.Close;
    Memo := nil;
    SaveItemNumber();//保存系统变量 20080903
    g_CastleManager.Free;
    FrontEngine.Terminate();
    FrontEngine.Free;
    MagicManager.Free;
    UserEngine.Free;

    RobotManage.Free;

    RunSocket.Free;

    ConnectTimer.Enabled := False;
    DBSocket.Close;
    FreeAndNil(MainLogMsgList);
    FreeAndNil(LogStringList);
    FreeAndNil(LogonCostLogList);
    ItemUnit.Free;

    NoticeManager.Free;
    g_GuildManager.Free;

    FreeAndNil(g_EventManager);//20080304
    FreeAndNil(ServerTableList);
    FreeAndNil(g_DenySayMsgList);
    FreeAndNil(MiniMapList);
    FreeAndNil(g_UnbindList);
    FreeAndNil(LineNoticeList);
    FreeAndNil(g_UserCmdList);//自定义命令列表 20080729
    FreeAndNil(QuestDiaryList);

    if g_CheckItemList.Count > 0 then begin//禁止物品规则 20080729
      for I := 0 to g_CheckItemList.Count - 1 do begin
        if pTCheckItem(g_CheckItemList.Items[I]) <> nil then Dispose(pTCheckItem(g_CheckItemList.Items[I]));
      end;
    end;
    FreeAndNil(g_CheckItemList);

    if g_MsgFilterList.Count > 0 then begin//消息过滤规则 20080729
      for I := 0 to g_MsgFilterList.Count - 1 do begin
        if pTFilterMsg(g_MsgFilterList.Items[I]) <> nil then Dispose(pTFilterMsg(g_MsgFilterList.Items[I]));
      end;
    end;
    FreeAndNil(g_MsgFilterList);

    if g_ShopItemList.Count > 0 then begin//商铺物品列表 20080730
      for I := 0 to g_ShopItemList.Count - 1 do begin
        if pTShopInfo(g_ShopItemList.Items[I]) <> nil then
          Dispose(pTShopInfo(g_ShopItemList.Items[I]));
      end;
    end;
    FreeAndNil(g_ShopItemList);

    if BoxsList.Count > 0 then begin//20080629
      for I := 0 to BoxsList.Count - 1 do begin //20080304 释放
        if pTBoxsInfo(BoxsList.Items[I]) <> nil then Dispose(pTBoxsInfo(BoxsList.Items[I]));
      end;
    end;
    FreeAndNil(BoxsList); //20080114 宝箱

    if SuitItemList.Count > 0 then begin//20080629
      for I := 0 to SuitItemList.Count - 1 do begin //20080304 释放
        if pTSuitItem(SuitItemList.Items[I])<> nil then Dispose(pTSuitItem(SuitItemList.Items[I]));
      end;
    end;
    FreeAndNil(SuitItemList); //20080225 套装

    if sSellOffItemList.Count > 0 then begin//20080629
      for I := 0 to sSellOffItemList.Count - 1 do begin //元宝寄售列表 20080316
        if pTDealOffInfo(sSellOffItemList.Items[I])<>nil then Dispose(pTDealOffInfo(sSellOffItemList.Items[I]));
      end;
    end;
    FreeAndNil(sSellOffItemList); //元宝寄售列表 20080316

    FreeAndNil(ItemEventList);
    FreeAndNil(AbuseTextList);
    FreeAndNil(g_MonSayMsgList);
    FreeAndNil(g_DisableMakeItemList);
    FreeAndNil(g_EnableMakeItemList);
    FreeAndNil(g_DisableMoveMapList);
    FreeAndNil(g_ItemNameList);
    FreeAndNil(g_DisableSendMsgList);
    FreeAndNil(g_MonDropLimitLIst);
    FreeAndNil(g_DisableTakeOffList);
    FreeAndNil(g_UnMasterList);
    FreeAndNil(g_UnForceMasterList);
    FreeAndNil(g_GameLogItemNameList);
    FreeAndNil(g_DenyIPAddrList);
    FreeAndNil(g_DenyChrNameList);
    FreeAndNil(g_DenyAccountList);
    FreeAndNil(g_NoClearMonList);
    {FreeAndNil(g_AllowSellOffItemList);//20080416 去掉拍卖功能

    g_SellOffGoodList.Free;
    g_SellOffGoldList.Free;}

    g_Storage.UnLoadBigStorageList;
    g_Storage.Free;

    if g_ItemBindIPaddr.Count > 0 then begin//20080629
      for I := 0 to g_ItemBindIPaddr.Count - 1 do begin
        if pTItemBind(g_ItemBindIPaddr.Items[I]) <> nil then Dispose(pTItemBind(g_ItemBindIPaddr.Items[I]));
      end;
    end;
    if g_ItemBindAccount.Count > 0 then begin//20080629
      for I := 0 to g_ItemBindAccount.Count - 1 do begin
        if pTItemBind(g_ItemBindAccount.Items[I])<> nil then Dispose(pTItemBind(g_ItemBindAccount.Items[I]));
      end;
    end;
    if g_ItemBindCharName.Count > 0 then begin//20080629
      for I := 0 to g_ItemBindCharName.Count - 1 do begin
        if pTItemBind(g_ItemBindCharName.Items[I]) <> nil then Dispose(pTItemBind(g_ItemBindCharName.Items[I]));
      end;
    end;
    FreeAndNil(g_ItemBindIPaddr);
    FreeAndNil(g_ItemBindAccount);
    FreeAndNil(g_ItemBindCharName);

    if g_ItemBindDieNoDropName.Count > 0 then begin//20081127
      for I := 0 to g_ItemBindDieNoDropName.Count - 1 do begin
        if pTItemBind(g_ItemBindDieNoDropName.Items[I]) <> nil then Dispose(pTItemBind(g_ItemBindDieNoDropName.Items[I]));
      end;
    end;
    FreeAndNil(g_ItemBindDieNoDropName);

    if g_MapEventListOfDropItem.Count > 0 then begin//20080629
    for I := 0 to g_MapEventListOfDropItem.Count - 1 do begin
      if pTMapEvent(g_MapEventListOfDropItem.Items[I]) <> nil then Dispose(pTMapEvent(g_MapEventListOfDropItem.Items[I]));
    end;
    end;
    FreeAndNil(g_MapEventListOfDropItem);

    if g_MapEventListOfPickUpItem.Count > 0 then begin//20080629
      for I := 0 to g_MapEventListOfPickUpItem.Count - 1 do begin
        if pTMapEvent(g_MapEventListOfPickUpItem.Items[I]) <> nil then
           Dispose(pTMapEvent(g_MapEventListOfPickUpItem.Items[I]));
      end;
    end;
    FreeAndNil(g_MapEventListOfPickUpItem);

    if g_MapEventListOfMine.Count > 0 then begin//20080629
      for I := 0 to g_MapEventListOfMine.Count - 1 do begin
        if pTMapEvent(g_MapEventListOfMine.Items[I]) <> nil then
          Dispose(pTMapEvent(g_MapEventListOfMine.Items[I]));
      end;
    end;
    FreeAndNil(g_MapEventListOfMine);

    if g_MapEventListOfWalk.Count > 0 then begin//20080629
      for I := 0 to g_MapEventListOfWalk.Count - 1 do begin
        if pTMapEvent(g_MapEventListOfWalk.Items[I]) <> nil then
          Dispose(pTMapEvent(g_MapEventListOfWalk.Items[I]));
      end;
    end;
    FreeAndNil(g_MapEventListOfWalk);

    if g_MapEventListOfRun.Count > 0 then begin//20080629
      for I := 0 to g_MapEventListOfRun.Count - 1 do begin
        if pTMapEvent(g_MapEventListOfRun.Items[I]) <> nil then
           Dispose(pTMapEvent(g_MapEventListOfRun.Items[I]));
      end;
    end;
    FreeAndNil(g_MapEventListOfRun);

    DeleteCriticalSection(LogMsgCriticalSection);
    DeleteCriticalSection(ProcessMsgCriticalSection);
    DeleteCriticalSection(ProcessHumanCriticalSection);
    DeleteCriticalSection(HumanSortCriticalSection);
    DeleteCriticalSection(Config1.UserIDSection);
    DeleteCriticalSection(UserDBSection);
    //CS_6.Free;//未使用 20080407
    if g_DynamicVarList.Count > 0 then begin//20080629
      for I := 0 to g_DynamicVarList.Count - 1 do begin
        if pTDynamicVar(g_DynamicVarList.Items[I]) <> nil then
           Dispose(pTDynamicVar(g_DynamicVarList.Items[I]));
      end;
    end;
    FreeAndNil(g_DynamicVarList);

    if g_BindItemTypeList <> nil then begin
      if g_BindItemTypeList.Count > 0 then begin//20080629
        for I := 0 to g_BindItemTypeList.Count - 1 do begin
          if pTBindItem(g_BindItemTypeList.Items[I]) <> nil then
            Dispose(pTBindItem(g_BindItemTypeList.Items[I]));
        end;
      end;
      FreeAndNil(g_BindItemTypeList);
    end;

    FreeAndNil(g_AllowPickUpItemList);

    if g_ItemDblClickList.Count > 0 then begin//20080629
      for I := 0 to g_ItemDblClickList.Count - 1 do begin
        if pTItemEvent(g_ItemDblClickList.Items[I]) <> nil then
          Dispose(pTItemEvent(g_ItemDblClickList.Items[I]));
      end;
    end;
    FreeAndNil(g_ItemDblClickList);

    if g_StartPointList.Count > 0 then begin//20080629
      for I := 0 to g_StartPointList.Count - 1 do begin
        if pTStartPoint(g_StartPointList.Objects[I]) <> nil then
           Dispose(pTStartPoint(g_StartPointList.Objects[I]));
      end;
    end;
    FreeAndNil(g_StartPointList);

    if g_MakeItemList.Count > 0 then begin//20080629
      for I := 0 to g_MakeItemList.Count - 1 do begin
        TStringList(g_MakeItemList.Objects[I]).Free;
      end;
    end;
    FreeAndNil(g_MakeItemList);

    if g_RefineItemList.Count > 0 then begin//20080629
      for I := 0 to g_RefineItemList.Count - 1 do begin //20080502
        if TList(g_RefineItemList.Objects[I]).Count > 0 then begin
          for K:=0 to TList(g_RefineItemList.Objects[I]).Count -1 do begin
            if pTRefineItemInfo(TList(g_RefineItemList.Objects[I]).Items[K]) <> nil then
              Dispose(pTRefineItemInfo(TList(g_RefineItemList.Objects[I]).Items[K]));
          end;
        end;
        TList(g_RefineItemList.Objects[I]).Free;
      end;
    end;
    FreeAndNil(g_RefineItemList);

    FrmDB.Free;//20080304
    PlugInEngine.Free;//必须在zPlugOfEngine前释放,不然DLL报错. 20080303
    zPlugOfEngine.Free;// 20071106
    g_MapManager.Free;//出现异常 20080722
    boServiceStarted := False;
  except
{   on E: Exception do begin  //测试时使用 20080303
      ShowMessage('错误信息:' + E.Message);
      Exit;
      raise;
    end;}
  end;
end;

procedure TFrmMain.MENU_HELP_ABOUTClick(Sender: TObject);
begin
  FrmAbout := TFrmAbout.Create(Owner);
  FrmAbout.Open();
  FrmAbout.Free;
end;

procedure TFrmMain.DBSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  MainOutMessage('数据库服务器(' + Socket.RemoteAddress + ':' + IntToStr(Socket.RemotePort) + ')连接成功...');
  g_nSaveRcdErrorCount := 0;
end;

procedure TFrmMain.MENU_OPTION_SERVERCONFIGClick(Sender: TObject);
begin
  FrmServerValue := TFrmServerValue.Create(Owner);
  FrmServerValue.Top := Self.Top + 20;
  FrmServerValue.Left := Self.Left;
  FrmServerValue.AdjuestServerConfig();
  FrmServerValue.Free;
end;

procedure TFrmMain.MENU_OPTION_GENERALClick(Sender: TObject);
begin
  frmGeneralConfig := TfrmGeneralConfig.Create(Owner);
  frmGeneralConfig.Top := Self.Top + 20;
  frmGeneralConfig.Left := Self.Left;
  frmGeneralConfig.Open();
  frmGeneralConfig.Free;
  Caption := g_Config.sServerName + ' [www.IGEM2.com.cn]';
end;

procedure TFrmMain.MENU_OPTION_GAMEClick(Sender: TObject);
begin
  frmGameConfig := TfrmGameConfig.Create(Owner);
  frmGameConfig.Top := Self.Top + 20;
  frmGameConfig.Left := Self.Left;
  frmGameConfig.Open;
  frmGameConfig.Free;
end;

procedure TFrmMain.MENU_OPTION_FUNCTIONClick(Sender: TObject);
begin
  frmFunctionConfig := TfrmFunctionConfig.Create(Owner);
  frmFunctionConfig.Top := Self.Top + 20;
  frmFunctionConfig.Left := Self.Left;
  frmFunctionConfig.Open;
  frmFunctionConfig.Free;
end;

procedure TFrmMain.G1Click(Sender: TObject);
begin
  frmGameCmd := TfrmGameCmd.Create(Owner);
  frmGameCmd.Top := Self.Top + 20;
  frmGameCmd.Left := Self.Left;
  frmGameCmd.Open;
  frmGameCmd.Free;
end;

procedure TFrmMain.MENU_OPTION_MONSTERClick(Sender: TObject);
begin
  frmMonsterConfig := TfrmMonsterConfig.Create(Owner);
  frmMonsterConfig.Top := Self.Top + 20;
  frmMonsterConfig.Left := Self.Left;
  frmMonsterConfig.Open;
  frmMonsterConfig.Free;
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_MONSTERSAYClick(Sender: TObject);
begin
  UserEngine.ClearMonSayMsg();
  LoadMonSayMsg();
  MainOutMessage('重新加载怪物说话配置完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_DISABLEMAKEClick(Sender: TObject);
begin
  LoadDisableTakeOffList();
  LoadDisableMakeItem();
  LoadEnableMakeItem();
  LoadDisableMoveMap();
  ItemUnit.LoadCustomItemName();
  LoadDisableSendMsgList();
  LoadGameLogItemNameList();
  LoadItemBindIPaddr();
  LoadItemBindAccount();
  LoadItemBindCharName();
  LoadItemBindDieNoDropName();//读取人物装备死亡不爆列表 20081127
  LoadUnMasterList();
  LoadUnForceMasterList();
  LoadDenyIPAddrList();
  LoadDenyAccountList();
  LoadDenyChrNameList();//加载禁止登录人物列表
  LoadNoClearMonList();
  //LoadAllowSellOffItemList();//20080416 去掉拍卖功能
  FrmDB.LoadAdminList();
  MainOutMessage('重新加载列表配置完成...');
end;

procedure TFrmMain.MENU_CONTROL_RELOAD_STARTPOINTClick(Sender: TObject);
begin
  FrmDB.LoadStartPoint();
  MainOutMessage('重新地图安全区列表完成...');
end;

procedure TFrmMain.MENU_CONTROL_GATE_OPENClick(Sender: TObject);
resourcestring
  sGatePortOpen = '游戏网关端口(%s:%d)已打开...';
begin
  if not GateSocket.Active then begin
    GateSocket.Active := True;
    MainOutMessage(Format(sGatePortOpen, [GateSocket.Address, GateSocket.Port]));
  end;
end;

procedure TFrmMain.MENU_CONTROL_GATE_CLOSEClick(Sender: TObject);
begin
  CloseGateSocket();
end;

procedure TFrmMain.CloseGateSocket;
var
  I: Integer;
resourcestring
  sGatePortClose = '游戏网关端口(%s:%d)已关闭...';
begin
  if GateSocket.Active then begin
    if GateSocket.Socket.ActiveConnections > 0 then begin//20080629
      for I := 0 to GateSocket.Socket.ActiveConnections - 1 do begin
        GateSocket.Socket.Connections[I].Close;
      end;
    end;
    GateSocket.Active := False;
    MainOutMessage(Format(sGatePortClose, [GateSocket.Address, GateSocket.Port]));
  end;
end;

procedure TFrmMain.MENU_CONTROLClick(Sender: TObject);
begin
  if GateSocket.Active then begin
    MENU_CONTROL_GATE_OPEN.Enabled := False;
    MENU_CONTROL_GATE_CLOSE.Enabled := True;
  end else begin
    MENU_CONTROL_GATE_OPEN.Enabled := True;
    MENU_CONTROL_GATE_CLOSE.Enabled := False;
  end;
end;

procedure UserEngineProcess(Config: pTConfig; ThreadInfo: pTThreadInfo);
var
  nRunTime: Integer;
  dwRunTick: LongWord;
begin
  l_dwRunTimeTick := 0;
  dwRunTick := GetTickCount();
  ThreadInfo.dwRunTick := dwRunTick;
  while not ThreadInfo.boTerminaled do begin
    nRunTime := GetTickCount - ThreadInfo.dwRunTick;
    if ThreadInfo.nRunTime < nRunTime then ThreadInfo.nRunTime := nRunTime;
    if ThreadInfo.nMaxRunTime < nRunTime then ThreadInfo.nMaxRunTime := nRunTime;
    if GetTickCount - dwRunTick >= 1000 then begin
      dwRunTick := GetTickCount();
      if ThreadInfo.nRunTime > 0 then Dec(ThreadInfo.nRunTime);
    end;

    ThreadInfo.dwRunTick := GetTickCount();
    ThreadInfo.boActived := True;
    ThreadInfo.nRunFlag := 125;
    if Config.boThreadRun then ProcessGameRun();
    Sleep(1);
  end;
end;

procedure UserEngineThread(ThreadInfo: pTThreadInfo); stdcall;
var
  nErrorCount: Integer;
resourcestring
  sExceptionMsg = '{异常} UserEngineThread ErrorCount = %d';
begin
  nErrorCount := 0;
  while True do begin
    try
      UserEngineProcess(ThreadInfo.Config, ThreadInfo);
      Break;
    except
      Inc(nErrorCount);
      if nErrorCount > 10 then Break;
      MainOutMessage(Format(sExceptionMsg, [nErrorCount]));
    end;
  end;
  ExitThread(0);
end;

procedure ProcessGameRun();
var
  I: Integer;
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    Try
      UserEngine.PrcocessData;
      g_EventManager.Run;
      RobotManage.Run;
      if GetTickCount - l_dwRunTimeTick > 10000 then begin
        l_dwRunTimeTick := GetTickCount();
        g_GuildManager.Run;
        g_CastleManager.Run;
        g_DenySayMsgList.Lock;
        try
          for I := g_DenySayMsgList.Count - 1 downto 0 do begin
            if g_DenySayMsgList.Count <= 0 then Break;//20080917
            if GetTickCount > LongWord(g_DenySayMsgList.Objects[I]) then begin
              g_DenySayMsgList.Delete(I);
            end;
          end;
        finally
          g_DenySayMsgList.UnLock;
        end;
      end;
    except
      on E: Exception do begin
        MainOutMessage('{异常} ProcessGameRun');
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TFrmMain.MENU_VIEW_GATEClick(Sender: TObject);
begin
  {MENU_VIEW_GATE.Checked := not MENU_VIEW_GATE.Checked;
  GridGate.Visible := MENU_VIEW_GATE.Checked; }
end;

procedure TFrmMain.MENU_VIEW_SESSIONClick(Sender: TObject);
begin
  frmViewSession := TfrmViewSession.Create(Owner);
  frmViewSession.Top := Top + 20;
  frmViewSession.Left := Left;
  frmViewSession.Open();
  frmViewSession.Free;
end;

procedure TFrmMain.MENU_VIEW_ONLINEHUMANClick(Sender: TObject);
begin
  frmViewOnlineHuman := TfrmViewOnlineHuman.Create(Owner);
  frmViewOnlineHuman.Top := Top + 20;
  frmViewOnlineHuman.Left := Left;
  frmViewOnlineHuman.Open();
  frmViewOnlineHuman.Free;
end;

procedure TFrmMain.MENU_VIEW_LEVELClick(Sender: TObject);
begin
  frmViewLevel := TfrmViewLevel.Create(Owner);
  frmViewLevel.Top := Top + 20;
  frmViewLevel.Left := Left;
  frmViewLevel.Open();
  frmViewLevel.Free;
end;

procedure TFrmMain.MENU_VIEW_LISTClick(Sender: TObject);
begin
  frmViewList := TfrmViewList.Create(Owner);
  frmViewList.Top := Top + 20;
  frmViewList.Left := Left;
  frmViewList.Open();
  frmViewList.Free;
end;

procedure TFrmMain.MENU_MANAGE_ONLINEMSGClick(Sender: TObject);
begin
  frmOnlineMsg := TfrmOnlineMsg.Create(Owner);
  frmOnlineMsg.Top := Top + 20;
  frmOnlineMsg.Left := Left;
  frmOnlineMsg.Open();
  frmOnlineMsg.Free;
end;

procedure TFrmMain.MENU_MANAGE_PLUGClick(Sender: TObject);
begin
  ftmPlugInManage := TftmPlugInManage.Create(Owner);
  ftmPlugInManage.Top := Top + 20;
  ftmPlugInManage.Left := Left;
  ftmPlugInManage.Open();
  ftmPlugInManage.Free;
end;

procedure TFrmMain.SetMenu;
begin
  FrmMain.Menu := MainMenu;
end;

procedure TFrmMain.MENU_VIEW_KERNELINFOClick(Sender: TObject);
begin
  frmViewKernelInfo := TfrmViewKernelInfo.Create(Owner);
  frmViewKernelInfo.Top := Top + 20;
  frmViewKernelInfo.Left := Left;
  frmViewKernelInfo.Open();
  frmViewKernelInfo.Free;
end;

procedure TFrmMain.MENU_TOOLS_MERCHANTClick(Sender: TObject);
begin
  frmConfigMerchant := TfrmConfigMerchant.Create(Owner);
  frmConfigMerchant.Top := Top + 20;
  frmConfigMerchant.Left := Left;
  frmConfigMerchant.Open();
  frmConfigMerchant.Free;
end;

procedure TFrmMain.MENU_OPTION_ITEMFUNCClick(Sender: TObject);
begin
  frmItemSet := TfrmItemSet.Create(Owner);
  frmItemSet.Top := Top + 20;
  frmItemSet.Left := Left;
  frmItemSet.Open();
  frmItemSet.Free;
end;

procedure TFrmMain.ClearMemoLog;
begin
  if Application.MessageBox('是否确定清除日志信息！！！', '提示信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    MemoLog.Clear;
  end;
end;

procedure TFrmMain.MENU_TOOLS_MONGENClick(Sender: TObject);
begin
  frmConfigMonGen := TfrmConfigMonGen.Create(Owner);
  frmConfigMonGen.Top := Top + 20;
  frmConfigMonGen.Left := Left;
  frmConfigMonGen.Open();
  frmConfigMonGen.Free;  
end;

procedure TFrmMain.MyMessage(var MsgData: TWmCopyData); //响应 启动器的关闭消息
var
  sData: string;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of
    GS_QUIT: begin
        g_boExitServer := True;
        CloseGateSocket();
        g_Config.boKickAllUser := True;
        CloseTimer.Enabled := True;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TFrmMain.MENU_TOOLS_IPSEARCHClick(Sender: TObject);
var
  sIPaddr: string;
begin
  try
    sIPaddr := '192.168.0.1';
    //sIPaddr := InputBox('IP所在地区查询', '输入IP地址:', '192.168.0.1');
    if not InputQuery('IP所在地区查询', '输入IP地址:', sIPaddr) then Exit;
    if not IsIPaddr(sIPaddr) then begin
      Application.MessageBox('输入的IP地址格式不正确！！！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
    MemoLog.Lines.Add(Format('%s:%s', [sIPaddr, GetIPLocal(sIPaddr)]));
  except
    MemoLog.Lines.Add(Format('%s:%s', [sIPaddr, GetIPLocal(sIPaddr)]));
  end;
end;

procedure TFrmMain.MENU_MANAGE_CASTLEClick(Sender: TObject);
begin
  frmCastleManage := TfrmCastleManage.Create(Owner);
  frmCastleManage.Top := Top + 20;
  frmCastleManage.Left := Left;
  frmCastleManage.Open();
  frmCastleManage.Free;
end;

procedure TFrmMain.MENU_HELP_REGKEYClick(Sender: TObject);
begin
{  FrmRegister := TFrmRegister.Create(Owner); //20080329 去掉注册窗口
  FrmRegister.Top := Top + 30;
  FrmRegister.Left := Left;
  FrmRegister.Open();
  FrmRegister.Free; }
end;

procedure TFrmMain.QFunctionNPCClick(Sender: TObject);
begin
  if g_FunctionNPC <> nil then begin
    g_FunctionNPC.ClearScript;
    g_FunctionNPC.LoadNpcScript;
    MainOutMessage('QFunction 脚本加载完成...');
  end;
end;

procedure TFrmMain.QManageNPCClick(Sender: TObject);
begin
  if g_ManageNPC <> nil then begin
    g_ManageNPC.ClearScript();
    g_ManageNPC.LoadNpcScript();
    MainOutMessage('重新加载登陆脚本完成...');
  end;
end;

procedure TFrmMain.RobotManageNPCClick(Sender: TObject);
begin
  if g_RobotNPC <> nil then begin
    RobotManage.RELOADROBOT();
    g_RobotNPC.ClearScript();
    g_RobotNPC.LoadNpcScript();
    MainOutMessage('重新加载机器人脚本完成...');
  end;
end;

procedure TFrmMain.MonItemsClick(Sender: TObject);
var
  I: Integer;
  Monster: pTMonInfo;
begin
  try
    if UserEngine.MonsterList.Count > 0 then begin//20080629
      for I := 0 to UserEngine.MonsterList.Count - 1 do begin
        Monster := UserEngine.MonsterList.Items[I];
        FrmDB.LoadMonitems(Monster.sName, Monster.ItemList);
      end;
    end;
    MainOutMessage('怪物爆物品列表重加载完成...');
  except
    MainOutMessage('怪物爆物品列表重加载失败！！！');
  end;
end;

procedure TFrmMain.MENU_OPTION_HEROClick(Sender: TObject);
begin
  frmHeroConfig := TfrmHeroConfig.Create(Owner);
  frmHeroConfig.Top := Top;
  frmHeroConfig.Left := Left;
  frmHeroConfig.Open();
  frmHeroConfig.Free;
end;

procedure TFrmMain.N3Click(Sender: TObject);
begin
  FrmDB.LoadBoxsList();//重新加载宝箱列表 20080115
  MainOutMessage('重新加载宝箱配置完成...');
end;

procedure TFrmMain.N1Click(Sender: TObject);
begin
  frmViewList2 := TfrmViewList2.Create(Owner);
  frmViewList2.Top := Top + 20;
  frmViewList2.Left := Left;
  frmViewList2.Open();
  frmViewList2.Free;
end;
//设置窗体类名 20080412
procedure TFrmMain.CreateParams(var Params:TCreateParams);
begin
  Inherited CreateParams(Params);
  Params.WinClassName:='www.IGEM2.com.cn';
end;  

procedure TFrmMain.N5Click(Sender: TObject);
begin
  if FrmDB.LoadMonGen > 0 then begin
    MainOutMessage('重新加载怪物刷新配置完成...');
  end;
end;

procedure TFrmMain.N6Click(Sender: TObject);
begin
  if LoadLineNotice(g_Config.sNoticeDir + 'LineNotice.txt') then begin
    MainOutMessage('重新加载公告提示信息完成...');
  end;
end;

procedure TFrmMain.N7Click(Sender: TObject);
begin
  FrmDB.LoadRefineItem;
  MainOutMessage('重新加载淬炼配置信息完成...');
end;

procedure TFrmMain.NPC1Click(Sender: TObject);
begin
  FrmDB.ReLoadMerchants();
  UserEngine.ReloadMerchantList();
  MainOutMessage('重新加载交易NPC配置信息完成...');
end;

procedure TFrmMain.NPC2Click(Sender: TObject);
begin
  FrmDB.ReLoadNpc;
  UserEngine.ReloadNpcList();
  MainOutMessage('重新加载管理NPC配置信息完成...');
end;

procedure TFrmMain.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled:=False;
  if g_boMinimize then Application.Minimize;//启动完成后最小化
end;

procedure TFrmMain.S1Click(Sender: TObject);
begin
  g_CastleManager.ReLoadCastle;
  MainOutMessage('重新加载城堡配置信息完成...');
end;

procedure TFrmMain.XXX1Click(Sender: TObject);
{var
  HumanRcd: THumDataInfo;
  nQueryID: Integer;
  nIdent: Integer;
  nRecog: Integer;
  sStr: string;   }
begin
  //判断脚本插件是否注册
 { if (nGetIPString >= 0) and Assigned(PlugProcArray[nGetIPString].nProcAddr) then begin
    MainOutMessage(boolToStr(TGetIPString(PlugProcArray[nGetIPString].nProcAddr)));
  end; }
  //测试与DBServer通讯
{  nQueryID := GetQueryID(@g_Config);
  SendDBSockMsg(nQueryID,EncodeMessage(MakeDefaultMsg(DB_SAVEHUMANRCD, 1, 0, 0, 0, 0)) + EncodeString('111') + '/' + EncodeString('2w3') + '/' + EncodeBuffer(@HumanRcd, SizeOf(THumDataInfo)));
}{  if GetDBSockMsg(nQueryID, nIdent, nRecog, sStr, g_Config.dwGetDBSockMsgTime , False,'SaveRcd') then begin
    if (nIdent = DBR_SAVEHUMANRCD) and (nRecog = 1) then;
  end; }
{  nQueryID := GetQueryID(@g_Config);
  SendDBSockMsg(nQueryID,EncodeMessage(MakeDefaultMsg(DB_SAVEHERORCD, 1, 0, 0, 0, 0)) + EncodeString('111') + '/' + EncodeString('32w3') + '/' + EncodeBuffer(@HumanRcd, SizeOf(THumDataInfo)));
  if GetDBSockMsg(nQueryID, nIdent, nRecog, sStr, g_Config.dwGetDBSockMsgTime, False,'SaveHeroRcd') then begin
    if (nIdent = DB_SAVEHERORCD) and (nRecog = 1) then;
  end; }
end;

initialization
  begin
    AddToProcTable(@ChangeCaptionText, Base64DecodeStr('Q2hhbmdlQ2FwdGlvblRleHQ=') {'ChangeCaptionText'},0); //加入函数列表
    nStartModule := AddToPulgProcTable(Base64DecodeStr('U3RhcnRNb2R1bGU='), 1); //StartModule  20071106
{$IF UserMode1 = 1}
    nGetRegisterName := AddToPulgProcTable(Base64DecodeStr('R2V0UmVnaXN0ZXJOYW1l'),3); //GetRegisterName 20080630(注册)
    nStartRegister := AddToPulgProcTable(Base64DecodeStr('UmVnaXN0ZXJMaWNlbnNl'),4); //StartRegister  20080630(注册)
{$IFEND}
    nGetDateIP := AddToPulgProcTable(Base64DecodeStr('R2V0RGF0ZUlQ'{'GetDateIP'}), 6); //脚本解密函数,SystemModule.dll输出 20080217
    nGetProductAddress := AddToPulgProcTable(Base64DecodeStr('R2V0UHJvZHVjdEFkZHJlc3M='{'GetProductAddress'}), 8);
    nGetSysDate := AddToPulgProcTable(Base64DecodeStr('R2V0U3lzRGF0ZQ=='{'GetSysDate'}), 9); //SystemModule.dll输出函数，检查是否为IGE的插件 20081203
  end;

finalization

end.


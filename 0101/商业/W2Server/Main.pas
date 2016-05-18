unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, RzPathBar, Menus, RzButton, Grids, RzGrids,
  StdCtrls, Share, RzEdit, RzSplit, IniFiles, JSocket, HUtil32, SyncObjs, Grobal2, ADODB, DB,
  AppEvnts;

type
  TFrmMain = class(TForm)
    RzSplitter: TRzSplitter;
    MemoLog: TRzMemo;
    RzSplitter1: TRzSplitter;
    Panel: TRzPanel;
    GridGate: TRzStringGrid;
    MainMenu: TMainMenu;
    T1: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    MENU_OPTION: TMenuItem;
    N1: TMenuItem;
    IP1: TMenuItem;
    N2: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    StartTimer: TTimer;
    ServerSocket: TServerSocket;
    DecodeTime: TTimer;
    Timer: TTimer;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    ClientSocket: TClientSocket;
    A1: TMenuItem;
    Label1: TLabel;
    LbRunTime: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure DecodeTimeTimer(Sender: TObject);
    procedure ShowMainMessage();
    procedure MemoLogDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure TimerTimer(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
  private
    dwReConnectServerTick: LongWord;
    dwSQLConnectTick: LongWord;
    procedure StartService;
    procedure StopService;
    procedure ClearMemoLog;
    procedure ProcessGate(Config: pTConfig);
    function KickUser(Config: pTConfig; UserInfo: pTM2UserInfo; nKickType: Integer): Boolean;
    procedure DecodeGateData(Config: pTConfig; GateInfo: pTLoginGateInfo);
    procedure DecodeUserData(Config: pTConfig; UserInfo: pTM2UserInfo; GateInfo: pTLoginGateInfo);
    procedure ProcessUserMsg(Config: pTConfig; UserInfo: pTM2UserInfo; GateInfo: pTLoginGateInfo; sMsg: string);
    procedure SendKeepAlivePacket(Socket: TCustomWinSocket);
    procedure ReceiveSendUser(Config: pTConfig; sSockIndex: string;
      GateInfo: pTLoginGateInfo; sData: string);
    procedure ReceiveOpenUser(Config: pTConfig; sSockIndex, sIPaddr: string;
      GateInfo: pTLoginGateInfo);
    procedure ReceiveCloseUser(Config: pTConfig; sSockIndex: string;
      GateInfo: pTLoginGateInfo);
   { procedure DLUserLogin(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure UserLogin(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure DLChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure ChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure MakeLogin(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure MakeGate(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure CheckMakeKeyAndDayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure AddUser(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
    procedure CheckAccount(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string); }

    function UpdateUserDayMakeNum(UserName: string): Integer;
    procedure SendGateKickMsg(Socket: TCustomWinSocket; sSockIndex: string);
  public
    //MaxNum: Integer;
    procedure MainOutMessage(sMsg: string);
    procedure SendGateMsg(Socket: TCustomWinSocket; sSockIndex, sMsg: string);
  end;

var
  FrmMain: TFrmMain;
  g_CriticalSection: TRTLCriticalSection;
  g_MainShowMsgList: TStringList;
  boStarted: Boolean;
  g_sServerAddr: string = '0.0.0.0';
  g_nServerPort: Integer = 37001;
  //MyCs: TRTLCriticalSection;
  MakeResultCs: TRTLCriticalSection;

implementation
uses EDcodeUnit, MD5EncodeStr, DM, EDcode, Common,ThreadQuery, BasicSet;

{$R *.dfm}
procedure TFrmMain.MainOutMessage(sMsg: string);
begin
  EnterCriticalSection(g_CriticalSection);
  try
    if g_MainShowMsgList = nil then g_MainShowMsgList := TStringList.Create;
    g_MainShowMsgList.Add('[' + DateTimeToStr(Now) + '] ' + sMsg);
  finally
    LeaveCriticalSection(g_CriticalSection);
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  //g_MainShowMsgList := TStringList.Create;
  GridGate.RowCount := 5;
  GridGate.Cells[0, 0] := '网关';
  GridGate.Cells[1, 0] := '网关地址';
  GridGate.Cells[2, 0] := '注册成功';
  GridGate.Cells[3, 0] := '注册失败';
  GridGate.Cells[4, 0] := '在线人数';
  g_boCanStart := True;
  g_dwServerStartTick := GetTickCount;
  StartTimer.Enabled := True;
end;

procedure TFrmMain.StartTimerTimer(Sender: TObject);
begin
  StartTimer.Enabled := False;
  if g_boCanStart then begin
    g_dwStartTick := GetTickCount();
    StartService();
    g_boCanStart := False;
  end else begin
    StopService();
    g_boCanStart := True;
    Close;
  end;
end;

procedure TFrmMain.StartService;
var
  Config: TIniFile;
  Conf: pTConfig;
begin
  if boStarted then Exit;
  //MainOutMessage('正在启动服务...');
  MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' +'正在启动服务...');
  boGateReady := False;
  boServiceStart := True;
  MENU_CONTROL_START.Enabled := False;
  MENU_CONTROL_STOP.Enabled := True;

  Config := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.ini');
  if Config <> nil then begin
    g_btMaxDayMakeNum := Config.ReadInteger('W2Server', 'MaxDayMakeNum', g_btMaxDayMakeNum);
    Config.Free;
  end;
  Conf := @g_Config;
  InitializeCriticalSection(Conf.GateCriticalSection);
  Conf.GateList := TList.Create;
  Conf.boShowDetailMsg := True;
  dwReConnectServerTick := GetTickCount - 25000{25 * 1000};
  dwSQLConnectTick:= GetTickCount - 25000;
{  if not DirectoryExists('.\Data') then begin //20080903
    if not CreateDir('.\Data') then begin
      MainOutMessage('创建数据库目录失败！');
      Exit;
    end;
  end; }
  //MemoLog.Lines.Add(EncodeString('sql.igem2.com'));
  //MemoLog.Lines.Add(EncodeString('8informaiton8'));
  if not FrmDm.ConnectedAccess('.\Data\Data.Mdb') then begin//连接数据库
    //MainOutMessage('连接数据库失败！');
    MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' +'连接数据库失败！');
    Exit;
  end;
  if not FrmDm.ConnectedAccess2 then begin
    //MainOutMessage('连接数据库失败2！');
    MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' +'连接数据库失败2！');
    Exit;
  end;
  //MainOutMessage('启动服务完成...');
  MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' +'启动服务完成...');
  ServerSocket.Active := False;
  ServerSocket.Address := g_sServerAddr;
  ServerSocket.Port := g_nServerPort;
  ServerSocket.Active := True;
  {ClientSocket.Active := False;
  ClientSocket.Address := '127.0.0.1';
  ClientSocket.Port := 37002;
  ClientSocket.Active := True;   }
  DecodeTime.Enabled := True;
  Timer.Enabled := True;
  g_dwServerStartTick := GetTickCount();
  boStarted := True;
end;

procedure TFrmMain.StopService;
var
  I: Integer;
  GateInfo: pTLoginGateInfo;
  Config: pTConfig;
begin
//  if boStarted then Exit;
  MainOutMessage('正在停止服务...');
  boGateReady := False;
  boServiceStart := False;
  MENU_CONTROL_START.Enabled := True;
  MENU_CONTROL_STOP.Enabled := False;
  //Timer.Enabled := False;
  DecodeTime.Enabled := False;
  ServerSocket.Active := False;
  Config := @g_Config;
  for I := 0 to Config.GateList.Count - 1 do begin
    GateInfo := Config.GateList.Items[I];
  end;
  Config.GateList.Free;
  DeleteCriticalSection(Config.GateCriticalSection);
  MainOutMessage('停止服务完成...');
  boStarted := False;
end;

function TFrmMain.UpdateUserDayMakeNum(UserName: string): Integer;
var
  Ado: TADOQuery;
  MaxNum: Integer;
begin
  //EnterCriticalSection(MyCs); //进入临界区
  try
    with FrmDm.ADOQuery1 do begin
       Close;
       SQL.Clear;
       //SQL.Add('Declare @MaxNum Int EXEC @return = UpdateMakeNum :a1,:a2 Select @MaxNum As Num');
       SQL.Add('EXEC UpdateMakeNum :a1,:a2');
       parameters.ParamByName('a1').DataType :=Ftstring;
       parameters.ParamByName('a1').Value := Trim(UserName);
       parameters.ParamByName('a2').DataType :=Ftinteger;
       parameters.ParamByName('a2').Value := g_btMaxDayMakeNum;
       open;
       Result := FieldByName('Num').AsInteger;
       Close;
    end;
  finally
    FrmDm.ADOconn2.Close;
    //LeaveCriticalSection(MyCs); //离开临界区
  end;
{  Result := 0;
  MaxNum := 0;
  EnterCriticalSection(MyCs); //进入临界区
  try
  with FrmDm.ADOQuery1 do begin
     Close;
     SQL.Clear;
     SQL.Add('SELECT DayMakeNum FROM UserInfo where [User]=:a2');
     parameters.ParamByName('a2').DataType :=Ftstring;
     parameters.ParamByName('a2').Value := Trim(UserName);
     Open;
     if RecordCount > 0 then begin
       MaxNum:= FieldByName('DayMakeNum').AsInteger;
       IF MaxNum < g_btMaxDayMakeNum then begin
          Close;
          SQL.Clear;
          SQL.Add('Update UserInfo set dayMakeNum=:a1 Where [User]=:a2');
          Inc(MaxNum);
          parameters.ParamByName('a1').DataType:=FtInteger;
          parameters.ParamByName('a1').Value := MaxNum;
          parameters.ParamByName('a2').DataType :=Ftstring;
          parameters.ParamByName('a2').Value := Trim(UserName);
          ExecSQL;
          Result := MaxNum;
       end;
     end;
  end;
  finally
    LeaveCriticalSection(MyCs); //离开临界区
  end;  }
end;

procedure TFrmMain.DecodeTimeTimer(Sender: TObject);
var
  Config: pTConfig;
  sProcessMsg: string;
  sSocketMsg: string;
  sSocketHandle: string;
  UserInfo: pTM2UserInfo;
  GateInfo: pTLoginGateInfo;
  I: Integer;
  II: Integer;
  sDataMsg, sDefMsg: string;
  DefMsg: TDefaultMessage;
begin
  Config := @g_Config;
  ProcessGate(Config);
  ShowMainMessage();
{----------------------生成器返回消息----------------------------}
  EnterCriticalSection(MakeResultCs);
  try
    while (True) do begin
      if MakeSockeMsgList.Count <= 0 then break;
      sProcessMsg := sProcMsg + MakeSockeMsgList.Strings[0];
      sProcMsg := '';
      MakeSockeMsgList.Delete(0);
      while (True) do begin
        if TagCount(sProcessMsg, '$') < 1 then break;
        sProcessMsg := ArrestStringEx(sProcessMsg, '%', '$', sSocketMsg);
        if sSocketMsg = '' then break;
        sSocketMsg := GetValidStr3(sSocketMsg, sSocketHandle, ['/']);
        if sSocketHandle = '' then Continue;
        sSocketMsg := Copy(sSocketMsg, 2, Length(sSocketMsg) - 1);
        for I:=0 to Config.GateList.Count - 1 do begin
          GateInfo := Config.GateList.Items[I];
          for II:=0 to GateInfo.UserList.Count - 1 do begin
            UserInfo := GateInfo.UserList.Items[II];
            if UserInfo.sSockIndex = sSocketHandle then begin
              sDefMsg := Copy(sSocketMsg, 1, DEFBLOCKSIZE); //
              sDataMsg := Copy(sSocketMsg, DEFBLOCKSIZE + 1, Length(sSocketMsg) - DEFBLOCKSIZE);
              DefMsg := DecodeMessage(sDefMsg);
              case DefMsg.Ident of
                SM_USERMAKEGATE_SUCCESS,//生成网关成功
                 SM_USERMAKELOGIN_SUCCESS: begin//DefMsg.Recog := UpdateUserDayMakeNum(UserInfo.sAccount); //生成登陆器成功
                     UpdateUserDayMakeNum1:= TUpdateUserDayMakeNumThread.Create(Owner);
                     UpdateUserDayMakeNum1.SQLText := sDataMsg;
                     UpdateUserDayMakeNum1.DefMsg := DefMsg;
                     UpdateUserDayMakeNum1.sLoginID:= UserInfo.sAccount;
                     UpdateUserDayMakeNum1.UserInfo := UserInfo;
                     UpdateUserDayMakeNum1.Resume;
                 end;
                 SM_USERMAKEONETIME_FAIL: SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex,sSocketMsg);  
              end;
              //sSocketMsg := EncodeMessage(DefMsg) + sDataMsg;
              //SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex,sSocketMsg);
            end;
          end;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(MakeResultCs);
  end;
end;
//显示日志
procedure TFrmMain.ShowMainMessage;
var
  I: Integer;
begin
  EnterCriticalSection(g_CriticalSection);
  try
    for I := 0 to g_MainShowMsgList.Count - 1 do begin
      MemoLog.Lines.Add(g_MainShowMsgList.Strings[I]);
    end;
    g_MainShowMsgList.Clear;
  finally
    LeaveCriticalSection(g_CriticalSection);
  end;
end; 


procedure TFrmMain.ClearMemoLog;
begin
  if Application.MessageBox('是否确定清除日志信息！！！', '提示信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    MemoLog.Clear;
  end;
end;

procedure TFrmMain.MemoLogDblClick(Sender: TObject);
begin
  ClearMemoLog();
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not g_boCanStart then begin
    if Application.MessageBox('是否确认停止代理服务器?', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
      if boServiceStart then begin
        StartTimer.Enabled := True;
        CanClose := False;
      end;
    end else CanClose := False;
  end;
end;

procedure TFrmMain.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  GateInfo: pTLoginGateInfo;
  Config: pTConfig;
begin
  New(GateInfo);
  GateInfo.Socket := Socket;
  GateInfo.sIPaddr := Socket.RemoteAddress;
  GateInfo.nPort := Socket.RemotePort;
  GateInfo.sReceiveMsg := '';
  GateInfo.UserList := TList.Create;
  GateInfo.dwKeepAliveTick := GetTickCount();
  GateInfo.nSuccesCount := 0;
  GateInfo.nFailCount := 0;
  Config := @g_Config;
  EnterCriticalSection(Config.GateCriticalSection);
  try
    Config.GateList.Add(GateInfo);
    MainOutMessage(Format('网关端口(%s:%d)已打开...', [Socket.RemoteAddress, Socket.RemotePort]));
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;
end;

procedure TFrmMain.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmMain.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  GateInfo: pTLoginGateInfo;
  Config: pTConfig;
begin
  Config := @g_Config;
  EnterCriticalSection(Config.GateCriticalSection);
  try
    for I := 0 to Config.GateList.Count - 1 do begin
      GateInfo := Config.GateList.Items[I];
      if GateInfo.Socket = Socket then begin
        GateInfo.sReceiveMsg := GateInfo.sReceiveMsg + Socket.ReceiveText;
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;  
end;

procedure TFrmMain.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  II: Integer;
  GateInfo: pTLoginGateInfo;
  UserInfo: pTM2UserInfo;
  Config: pTConfig;
begin
  Config := @g_Config;
  EnterCriticalSection(Config.GateCriticalSection);
  try
    for I := 0 to Config.GateList.Count - 1 do begin
      GateInfo := Config.GateList.Items[I];
      if GateInfo.Socket = Socket then begin
        for II := 0 to GateInfo.UserList.Count - 1 do begin //没有登陆用户不会提示关闭
          UserInfo := GateInfo.UserList.Items[II];
          if Config.boShowDetailMsg then MainOutMessage('关闭: ' + UserInfo.sUserIPaddr);
          Dispose(UserInfo);  //释放网关上的用户
        end;
        GateInfo.UserList.Free;
        Dispose(GateInfo);
        Config.GateList.Delete(I);
        if Config.boShowDetailMsg then  MainOutMessage(Format('网关(%s:%d)已关闭', [Socket.RemoteAddress, Socket.RemotePort]));
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;
end;

procedure TFrmMain.ProcessGate(Config: pTConfig);
var
  I: Integer;
  II: Integer;
  GateInfo: pTLoginGateInfo;
  UserInfo: pTM2UserInfo;
begin
  EnterCriticalSection(Config.GateCriticalSection);
  try
    Config.dwProcessGateTick := GetTickCount();
    I := 0;
    while (True) do begin
      if Config.GateList.Count <= I then Break;
      GateInfo := Config.GateList.Items[I];
      if GateInfo.sReceiveMsg <> '' then begin
        DecodeGateData(Config, GateInfo);
        //Config.sGateIPaddr := GateInfo.sIPaddr;
        II := 0;
        while (True) do begin
          if GateInfo.UserList.Count <= II then Break;
          UserInfo := GateInfo.UserList.Items[II];
          if UserInfo.sReceiveMsg <> '' then DecodeUserData(Config, UserInfo, GateInfo);
            {if GetTickCount - UserInfo.dwClientTick > 1000 * 60 then begin
              KickUser(Config, UserInfo, 0);
            end; }
          if UserInfo.boKick then begin
            if GetTickCount > UserInfo.dwKickTick then begin
              KickUser(Config, UserInfo, 0);
            end;
          end;
          Inc(II);
        end;
      end;
      Inc(I);
    end;
    if Config.dwProcessGateTime < Config.dwProcessGateTick then
      Config.dwProcessGateTime := GetTickCount - Config.dwProcessGateTick;
    if Config.dwProcessGateTime > 100 then Dec(Config.dwProcessGateTime, 100);
  finally
    LeaveCriticalSection(Config.GateCriticalSection);
  end;
end;

procedure TFrmMain.DecodeUserData(Config: pTConfig; UserInfo: pTM2UserInfo; GateInfo: pTLoginGateInfo);
var
  sMsg: string;
  nCount: Integer;
begin
  nCount := 0;
  try
    //if UserInfo = nil then nErrCode:=1;
    while (True) do begin
      if TagCount(UserInfo.sReceiveMsg, '!') <= 0 then Break;
      UserInfo.sReceiveMsg := ArrestStringEx(UserInfo.sReceiveMsg, '#', '!', sMsg);
      if sMsg <> '' then begin
        if Length(sMsg) >= DEFBLOCKSIZE + 1 then begin
          sMsg := Copy(sMsg, 2, Length(sMsg) - 1);
          ProcessUserMsg(Config, UserInfo, GateInfo, sMsg);
        end;
      end else begin
        if nCount >= 1 then UserInfo.sReceiveMsg := '';
        Inc(nCount);
      end;
      if UserInfo.sReceiveMsg = '' then Break;
    end;
  except
    MainOutMessage('[Exception] TFrmMain.DecodeUserData ');
  end;
end;


procedure TFrmMain.DecodeGateData(Config: pTConfig; GateInfo: pTLoginGateInfo);
var
  nCount: Integer;
  sMsg: string;
  sSockIndex: string;
  sData: string;
  Code: Char;
begin
  try
    nCount := 0;
    while (True) do begin
      if TagCount(GateInfo.sReceiveMsg, '$') <= 0 then Break;
      GateInfo.sReceiveMsg := ArrestStringEx(GateInfo.sReceiveMsg, '%', '$', sMsg);
      if sMsg <> '' then begin
        Code := sMsg[1];
        sMsg := Copy(sMsg, 2, Length(sMsg) - 1);
        case Code of
          '-': begin
              SendKeepAlivePacket(GateInfo.Socket);
              GateInfo.dwKeepAliveTick := GetTickCount();
            end;
          'D': begin
              sData := GetValidStr3(sMsg, sSockIndex, ['/']);
              ReceiveSendUser(Config, sSockIndex, GateInfo, sData);
            end;
          'N': begin  //此地方是 增加用户
              sData := GetValidStr3(sMsg, sSockIndex, ['/']);
              ReceiveOpenUser(Config, sSockIndex, sData, GateInfo);
            end;
          'C': begin
              sSockIndex := sMsg;
              ReceiveCloseUser(Config, sSockIndex, GateInfo);
            end;
        end;
      end else begin
        if nCount >= 1 then GateInfo.sReceiveMsg := '';
        Inc(nCount);
      end;
    end;
  except
    MainOutMessage('[Exception] TFrmMain.DecodeGateData');
  end;
end;

function TFrmMain.KickUser(Config: pTConfig; UserInfo: pTM2UserInfo;
  nKickType: Integer): Boolean;
resourcestring
  sKickMsg = '踢除: %s';
begin
  Result := False;
  if Config.boShowDetailMsg then
    MainOutMessage(Format(sKickMsg, [UserInfo.sUserIPaddr]));
    SendGateKickMsg(UserInfo.Socket, UserInfo.sSockIndex);
  {case nKickType of
    0: SendGateKickMsg(UserInfo.Socket, UserInfo.sSockIndex);
    1: SendGateAddTempBlockList(UserInfo.Socket, UserInfo.sSockIndex);
    2: SendGateAddBlockList(UserInfo.Socket, UserInfo.sSockIndex);
  end; }
  Result := True;
end;

procedure TFrmMain.ProcessUserMsg(Config: pTConfig; UserInfo: pTM2UserInfo;
  GateInfo: pTLoginGateInfo; sMsg: string);
var
  sDefMsg: string;
  sData: string;
  DefMsg: TDefaultMessage;
begin
  try
    sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
    sData := Copy(sMsg, DEFBLOCKSIZE + 1, Length(sMsg) - DEFBLOCKSIZE);
    DefMsg := DecodeMessage(sDefMsg);
    //MainOutMessage('Code: ' + IntToStr(DefMsg.Ident) + ' Msg: ' + sData);
    case DefMsg.Ident of
      GM_LOGIN:begin// DLUserLogin(Config, UserInfo, sData);//代理用户登陆
        DLUserLoginThread:= TDLUserLoginThread.Create(Owner);
        DLUserLoginThread.GateInfo := GateInfo;
        DLUserLoginThread.UserInfo:= UserInfo;
        DLUserLoginThread.SQLText:= sData;
        DLUserLoginThread.Resume;
      end;
      GM_ADDUSER: begin// AddUser(Config, UserInfo, sData);//代理添加用户
        UserMsgThread0:= TUserMsgThread.Create(Owner, 0);
        UserMsgThread0.UserInfo:= UserInfo;
        UserMsgThread0.Config:= Config;
        UserMsgThread0.SQLText:= sData;
        UserMsgThread0.Resume;
      end;
      GM_GETUSER: begin//CheckAccount(Config, UserInfo, sData);//代理检测用户是否存在
        UserMsgThread1:= TUserMsgThread.Create(Owner, 1);
        UserMsgThread1.UserInfo:= UserInfo;
        UserMsgThread1.Config:= Config;
        UserMsgThread1.SQLText:= sData;
        UserMsgThread1.Resume;
      end;
      GM_USERLOGIN:begin//UserLogin(Config, UserInfo, sData); //用户登陆
        QueryThread:= TQueryThread.Create(Owner);
        QueryThread.GateInfo := GateInfo;
        QueryThread.UserInfo:= UserInfo;
        QueryThread.SQLText:= sData;
        QueryThread.Resume;
      end;
      GM_CHANGEPASS: begin// DLChangePass(Config, UserInfo, sData); //代理修改密码
        UserMsgThread2:= TUserMsgThread.Create(Owner, 2);
        UserMsgThread2.UserInfo:= UserInfo;
        UserMsgThread2.Config:= Config;
        UserMsgThread2.SQLText:= sData;
        UserMsgThread2.Resume;
      end;
      GM_USERCHANGEPASS: begin// ChangePass(Config, UserInfo, sData);//用户修改密码
        UserMsgThread3:= TUserMsgThread.Create(Owner, 3);
        UserMsgThread3.UserInfo:= UserInfo;
        UserMsgThread3.Config:= Config;
        UserMsgThread3.SQLText:= sData;
        UserMsgThread3.Resume;
      end;
      GM_USERCHECKMAKEKEYANDDAYMAKENUM: begin//CheckMakeKeyAndDayMakeNum(Config, UserInfo, sData);//验证密钥匙和今日生成次数
        UserMsgThread4:= TUserMsgThread.Create(Owner, 4);
        UserMsgThread4.UserInfo:= UserInfo;
        UserMsgThread4.Config:= Config;
        UserMsgThread4.SQLText:= sData;
        UserMsgThread4.Resume;
      end;
      GM_USERMAKELOGIN: begin// MakeLogin(Config, UserInfo, sData); //生成登陆器
        UserMsgThread5:= TUserMsgThread.Create(Owner, 5);
        UserMsgThread5.UserInfo:= UserInfo;
        UserMsgThread5.Config:= Config;
        UserMsgThread5.SQLText:= sData;
        UserMsgThread5.Resume;
      end;
      GM_USERMAKEGATE: begin// MakeGate(Config, UserInfo, sData); //生成网关
        UserMsgThread6:= TUserMsgThread.Create(Owner, 6);
        UserMsgThread6.UserInfo:= UserInfo;
        UserMsgThread6.Config:= Config;
        UserMsgThread6.SQLText:= sData;
        UserMsgThread6.Resume;
      end;
    end;
  except
    MainOutMessage('[Exception] TFrmMain.ProcessUserMsg ' + 'wIdent: ' + IntToStr(DefMsg.Ident) + ' sData: ' + sData);
  end;
end;

procedure TFrmMain.SendKeepAlivePacket(Socket: TCustomWinSocket);
begin
  if Socket.Connected then Socket.SendText('%++$');
end;

procedure TFrmMain.ReceiveCloseUser(Config: pTConfig; sSockIndex: string;
  GateInfo: pTLoginGateInfo);
var
  UserInfo: pTM2UserInfo;
  I{, II}: Integer;
resourcestring
  sCloseMsg = '关闭: %s';
begin
  for I := 0 to GateInfo.UserList.Count - 1 do begin
    UserInfo := GateInfo.UserList.Items[I];
    if UserInfo.sSockIndex = sSockIndex then begin
      if Config.boShowDetailMsg then
        MainOutMessage(Format(sCloseMsg, [UserInfo.sUserIPaddr]));
      Dispose(UserInfo);
      GateInfo.UserList.Delete(I);
      Break;
    end;
  end;
end;

procedure TFrmMain.ReceiveOpenUser(Config: pTConfig; sSockIndex,
  sIPaddr: string; GateInfo: pTLoginGateInfo);
var
  UserInfo: pTM2UserInfo;
  I: Integer;
  sGateIPaddr: string;
  sUserIPaddr: string;
resourcestring
  sOpenMsg = '连接: %s/%s';
begin
  sIPaddr := GetValidStr3(sIPaddr, sUserIPaddr, ['/']);
  try
    for I := 0 to GateInfo.UserList.Count - 1 do begin
      UserInfo := GateInfo.UserList.Items[I];
      if UserInfo.sSockIndex = sSockIndex then begin
        UserInfo.sUserIPaddr := sUserIPaddr;
        UserInfo.sReceiveMsg := '';
        UserInfo.dwClientTick := GetTickCount();
        Exit;
      end;
    end;
    New(UserInfo);
    UserInfo.sUserIPaddr := sUserIPaddr;
    UserInfo.sSockIndex := sSockIndex;
    UserInfo.Socket := GateInfo.Socket;
    UserInfo.sReceiveMsg := '';
    //UserInfo.nRemoteAddr := MakeIPToInt(sUserIPaddr);
    UserInfo.dwClientTick := GetTickCount();
    UserInfo.boKick := False;
    UserInfo.boLogined := False;
    UserInfo.dwKickTick := GetTickCount + {1000 * 60 * 5}300000;
    //FillChar(UserInfo.SuperSession, SizeOf(TSuperSession), 0);
    GateInfo.UserList.Add(UserInfo);
    if Config.boShowDetailMsg then
      MainOutMessage(Format(sOpenMsg, [sUserIPaddr, sGateIPaddr]));
  except
    MainOutMessage('TFrmMain.ReceiveOpenUser');
  end;
end;

procedure TFrmMain.ReceiveSendUser(Config: pTConfig; sSockIndex: string;
  GateInfo: pTLoginGateInfo; sData: string);
var
  UserInfo: pTM2UserInfo;
  I: Integer;
begin
  try
    for I := 0 to GateInfo.UserList.Count - 1 do begin
      UserInfo := GateInfo.UserList.Items[I];
      if UserInfo.sSockIndex = sSockIndex then begin
        if Length(UserInfo.sReceiveMsg) < 4069 then begin
          UserInfo.sReceiveMsg := UserInfo.sReceiveMsg + sData;
        end;
        Break;
      end;
    end;
  except
    MainOutMessage('TFrmMain.ReceiveSendUser');
  end;
end;
{
procedure TFrmMain.DLUserLogin(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  DefMsg: TDefaultMessage;
  nCheckCode: Integer;
  sLoginID, sPassword: string;
  sSENDTEXT: string;
  sDest: string;
  DLUserInfo: TDLUserInfo;
begin
  nCheckCode := -1;
  if not UserInfo.boLogined then begin
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sPassword, ['/']);
    with FrmDm.ADOQueryLogin do begin
      try
        Close;
        SQL.Clear;
        SQL.Add('Select * From DLUserInfo Where [User]=:a1 and [Pass]=:a2') ;
        parameters.ParamByName('a1').DataType:=Ftstring;
        parameters.ParamByName('a1').Value := sLoginID;
        parameters.ParamByName('a2').DataType :=Ftstring;
        parameters.ParamByName('a2').Value :=sPassword;
        Open;
        if RecordCount = 0 then begin
          DefMsg := MakeDefaultMsg(SM_LOGIN_FAIL, 0, 0, 0, 0);
          SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
          UserInfo.boKick := True;
          UserInfo.dwKickTick := GetTickCount + 5000;
          Close;
          Exit;
        end else begin
          FillChar(DLUserInfo, SizeOf(TDLUserInfo), 0);
          //UserSession.sAccount := sLoginID;
          //UserSession.sPassword := sPassword;
          DLUserInfo.sAccount := sLoginID;
          DLUserInfo.sUserQQ := FieldByName('QQ').AsString;
          DLUserInfo.sName := FieldByName('Name').AsString;
          DLUserInfo.CurYuE := FieldByName('YuE').AsCurrency;
          DLUserInfo.curXiaoShouE := FieldByName('XiaoShouE').AsCurrency;
          DLUserInfo.sAddrs := FieldByName('IPAddress').AsString;
          DLUserInfo.dTimer := FieldByName('Timer').AsDateTime;
          UserInfo.sAccount := sLoginID;
          UserInfo.sPassword := sPassword;
          UserInfo.boLogined := True;
          DefMsg := MakeDefaultMsg(SM_LOGIN_SUCCESS, 0, 0, 0, 0);
          sSENDTEXT := EncryptBuffer(@DLUserInfo, SizeOf(TDLUserInfo));
          SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + sSENDTEXT);
          Close;
        end;
      except
      end;
      try
        Close;
        SQL.Clear;
        SQL.Add('Update DLUserInfo set IPAddress=:a1,Timer=:a2 Where [User]=:a3') ;
        parameters.ParamByName('a1').DataType:=Ftstring;
        parameters.ParamByName('a1').Value := UserInfo.sUserIPaddr;
        parameters.ParamByName('a2').DataType :=Ftdate;
        parameters.ParamByName('a2').Value := FormatDateTime('yyyy-mm-dd hh:nn:ss',Now());
        parameters.ParamByName('a3').DataType :=Ftstring;
        parameters.ParamByName('a3').Value :=sLoginID;
        ExecSQL;
        Close;
      except
      end;
    end;
  end;
end;         }
              
procedure TFrmMain.SendGateMsg(Socket: TCustomWinSocket; sSockIndex,
  sMsg: string);
var
  sSendMsg: string;
begin
  if (Socket <> nil) and Socket.Connected then begin
    sSendMsg := '%' + sSockIndex + '/#' + sMsg + '!$';
    Socket.SendText(sSendMsg);
  end;
end;

{//btCheckCode 1-注册成功  2-未登陆 3-用户已存在 4,5-出现异常
procedure TFrmMain.AddUser(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
  //随机取密码
  function RandomGetPass():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //随机种子
      for i:=0 to 14 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
  //随机取密码
  function RandomGetKey():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ-=|';
      s1:='';
      Randomize(); //随机种子
      for i:=0 to 99 do begin
        i0:=random(38);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
var
  UserSession: TUserEntry1;
  Judge: TADOQuery;
  YuE, XiaoShouE: Currency;
  btCheckCode: byte;
  sPass: string;
  sKey: string;
  DefMsg: TDefaultMessage;
  sSENDTEXT: string;
  I: Integer;
  GateInfo: pTLoginGateInfo;
begin
  if UserInfo.boLogined then begin  //如果代理用户已经登陆
     YuE := 0;
     btCheckCode := 0;
     Judge:=TADOQuery.Create(Nil);
     try
       Judge.Connection := FrmDm.ADOconn;
       with Judge do begin
         Close;
         SQL.Clear;
         SQL.Add('Select YuE,XiaoShouE From DLUserInfo');
         SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
         Parameters.ParamByName('a1').DataType:=Ftstring;
         Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
         Parameters.ParamByName('a2').DataType :=Ftstring;
         Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
         Open();
         if RecordCount > 0 then begin
           YuE := FieldByName('YuE').AsCurrency;
           XiaoShouE := FieldByName('XiaoShouE').AsCurrency;
         end;
         Close;
       end;
     finally
       Judge.Free;
     end;
     if YuE >= sPrice then btCheckCode := 1;
     if btCheckCode = 1 then begin
        FillChar(UserSession, SizeOf(TUserEntry1), #0);
        DecryptBuffer(sData, @UserSession, SizeOf(TUserEntry1));
        if (UserSession.sAccount <> '') and (UserSession.sGameListUrl <> '') and (UserSession.sBakGameListUrl <> '') and (UserSession.sPatchListUrl <> '') and (UserSession.sGameMonListUrl <> '') and (UserSession.sGatePass <> '') then begin
          if not CheckUserExist('UserInfo',UserSession.sAccount) then begin //如果帐号不存在
            Judge := TADOQuery.Create(nil);
            try
              Judge.Connection := FrmDm.ADOconn;
              with Judge do begin
                try
                  Close;
                  SQL.Clear;
                  SQL.Add('Insert Into UserInfo (ID,[User],Pass,QQ,');
                  SQL.Add('GameListUrl,BakGameListUrl,PatchListUrl,GameMonListUrl,GameESystemUrl,GatePass,MakeKey,Who,RegTimer,DayMakeNum)');
                  SQL.Add('  Values(:a12,:a0,:a1,:a2,:a3,:a4,:a5,:a6,:a7,:a8,:a9,:a10,:a11,:a12)');
                  Parameters.ParamByName('a12').DataType:=FtInteger;
                  Parameters.ParamByName('a12').Value := CheckMaXID('UserInfo');
                  Parameters.ParamByName('a0').DataType:=Ftstring;
                  Parameters.ParamByName('a0').Value :=Trim(UserSession.sAccount);
                  Parameters.ParamByName('a1').DataType:=Ftstring;
                  sPass := RandomGetPass;
                  Parameters.ParamByName('a1').Value := sPass;
                  Parameters.ParamByName('a2').DataType:=FtString;
                  Parameters.ParamByName('a2').Value := Trim(UserSession.sUserQQ);
                  Parameters.ParamByName('a3').DataType:=FtString;
                  Parameters.ParamByName('a3').Value := Trim(UserSession.sGameListUrl);
                  Parameters.ParamByName('a4').DataType:=FtString;
                  Parameters.ParamByName('a4').Value := Trim(UserSession.sBakGameListUrl);
                  Parameters.ParamByName('a5').DataType:=FtString;
                  Parameters.ParamByName('a5').Value := Trim(UserSession.sPatchListUrl);
                  Parameters.ParamByName('a6').DataType:=FtString;
                  Parameters.ParamByName('a6').Value := Trim(UserSession.sGameMonListUrl);
                  Parameters.ParamByName('a7').DataType:=FtString;
                  Parameters.ParamByName('a7').Value := Trim(UserSession.sGameESystemUrl);
                  Parameters.ParamByName('a8').DataType:=FtString;
                  Parameters.ParamByName('a8').Value := Trim(UserSession.sGatePass);
                  Parameters.ParamByName('a9').DataType:=FtString;
                  sKey := RandomGetKey;
                  Parameters.ParamByName('a9').Value := sKey;
                  Parameters.ParamByName('a10').DataType:=FtString;
                  Parameters.ParamByName('a10').Value := Trim(Userinfo.sAccount);
                  Parameters.ParamByName('a11').DataType:=FtDateTime;
                  Parameters.ParamByName('a11').Value := Now();
                  Parameters.ParamByName('a12').DataType:=FtInteger;
                  Parameters.ParamByName('a12').Value := 0;
                  ExecSQL;
                  YuE := MaxCurr(0, YuE - sPrice);
                  XiaoShouE := XiaoShouE + sPrice;
                  try
                    Close;
                    SQL.Clear;
                    //SQL.Add('Update DLUserInfo set [YuE]="'+ CurrToStr(YuE) +'", [XiaoShouE]="'+ CurrToStr(XiaoShouE) +'" Where [User]="'+ UserInfo.sAccount +'"');
                    SQL.Add('Update DLUserInfo set YuE=:a1,XiaoShouE=:a2 Where [User]=:a3') ;
                    parameters.ParamByName('a1').DataType:=FtCurrency;
                    parameters.ParamByName('a1').Value := CurrToStr(YuE);
                    parameters.ParamByName('a2').DataType :=FtCurrency;
                    parameters.ParamByName('a2').Value := CurrToStr(XiaoShouE);
                    parameters.ParamByName('a3').DataType :=Ftstring;
                    parameters.ParamByName('a3').Value := Trim(UserInfo.sAccount);
                    ExecSQL;
                    Close;
                  except
                    btCheckCode := 4;
                  end;
                except
                  btCheckCode := 5;
                end;
              end;
            finally
              Judge.Free;
            end;
          end else btCheckCode := 3; // 
        end;
     end;
  end else btCheckCode := 2;
  if btCheckCode = 1 then begin
    for I := 0 to Config.GateList.Count - 1 do begin
      GateInfo := Config.GateList.Items[I];
      if GateInfo.Socket <> nil then begin
        if GateInfo.Socket.RemotePort = UserInfo.Socket.RemotePort then begin
          Inc(GateInfo.nSuccesCount);//添加用户成功
          Break;
        end;
      end;
    end;
    DefMsg := MakeDefaultMsg(SM_ADDUSER_SUCCESS, btCheckCode, 0, 0, 0);
    sSENDTEXT := UserSession.sAccount+'/'+sPass+'/'+sKey+'/'+CurrToStr(YuE)+'/'+ CurrToStr(XiaoShouE);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + EncryptString(sSENDTEXT));
  end else begin
    for I := 0 to Config.GateList.Count - 1 do begin
      GateInfo := Config.GateList.Items[I];
      if GateInfo.Socket <> nil then begin
        if GateInfo.Socket.RemotePort = UserInfo.Socket.RemotePort then begin
          Inc(GateInfo.nFailCount);//添加用户失败
          Break;
        end;
      end;
    end;
    DefMsg := MakeDefaultMsg(SM_ADDUSER_FAIL, btCheckCode, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;    }
{
procedure TFrmMain.CheckAccount(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  sDest: string;
  btDeco: Byte;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin
    sDest := DecryptString(sData);
    if CheckUserExist('UserInfo',sDest) then
      btDeco := 0
    else btDeco := 1;
    DefMsg := MakeDefaultMsg(SM_GETUSER_SUCCESS, btDeco, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;    }
{
procedure TFrmMain.UserLogin(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  DefMsg: TDefaultMessage;
  nCheckCode: Integer;
//  nIndex: Integer;
  sLoginID, sPassword: string;
//  nRemoteAddr: Integer;
  sSENDTEXT: string;
  sDest: string;
  UserInfo1: TUserInfo;
begin
  nCheckCode := -1;
  if not UserInfo.boLogined then begin
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sPassword, ['/']);

    with FrmDm.ADOQueryLogin do begin
      try
        Close;
        SQL.Clear;
        //SQL.Add('Select * from UserInfo where [User]="'+ sLoginID +'" and [Pass]="'+ sPassword +'"');
        SQL.Add('Select * From UserInfo Where [User]=:a1 and [Pass]=:a2') ;
        parameters.ParamByName('a1').DataType:=Ftstring;
        parameters.ParamByName('a1').Value := Trim(sLoginID);
        parameters.ParamByName('a2').DataType :=Ftstring;
        parameters.ParamByName('a2').Value := Trim(sPassword);
        Open;
        if RecordCount = 0 then begin
          DefMsg := MakeDefaultMsg(SM_USERLOGIN_FAIL, 0, 0, 0, 0);
          SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
          UserInfo.boKick := True;
          UserInfo.dwKickTick := GetTickCount + 5000;
          Close;
          Exit;
        end else begin
          FillChar(UserInfo1, SizeOf(TUserInfo), 0);
          UserInfo1.sAccount := sLoginID;
          UserInfo1.sUserQQ := FieldByName('QQ').AsString;
          UserInfo1.nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
          UserInfo1.nMaxDayMakeNum := g_btMaxDayMakeNum;
          UserInfo1.sAddrs := FieldByName('IPAddress').AsString;
          UserInfo1.dTimer := FieldByName('Timer').AsDateTime;
          UserInfo.sAccount := sLoginID;
          UserInfo.sPassword := sPassword;
          UserInfo.boLogined := True;
          DefMsg := MakeDefaultMsg(SM_USERLOGIN_SUCCESS, 0, 0, 0, 0);
          sSENDTEXT := EncryptBuffer(@UserInfo1, SizeOf(TUserInfo));
          SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + sSENDTEXT);
          Close;
        end;
      except
      end;
      try
        CheckUserTime(sLoginID);
        Close;
        SQL.Clear;
        //SQL.Add('Update UserInfo set [IPAddress]="'+ UserInfo.sUserIPaddr +'", [Timer]="'+ FormatDateTime('yyyy-mm-dd hh:nn:ss',Now()) +'" Where [User]="'+ sLoginID +'"');
        SQL.Add('Update UserInfo set IPAddress=:a1,Timer=:a2 Where [User]=:a3') ;
        parameters.ParamByName('a1').DataType:=Ftstring;
        parameters.ParamByName('a1').Value := UserInfo.sUserIPaddr;
        parameters.ParamByName('a2').DataType :=Ftdate;
        parameters.ParamByName('a2').Value := FormatDateTime('yyyy-mm-dd hh:nn:ss',Now());
        parameters.ParamByName('a3').DataType :=Ftstring;
        parameters.ParamByName('a3').Value := Trim(sLoginID);
        ExecSQL;
        Close;
      except
      end;
    end;
  end;
end;     }

procedure TFrmMain.TimerTimer(Sender: TObject);
var
  I: Integer;
  GateInfo: pTLoginGateInfo;
  Config: pTConfig;
  nRow: Integer;
begin
  if boStarted then begin
    I := (GetTickCount() - g_dwStartTick) div 1000;
    LbRunTime.Caption :='运行时间:'+ IntToStr(I div 3600) + ':' + IntToStr((I div 60) mod 60) + ':' + IntToStr(I mod 60) ;

    if (GetTickCount() / 86400000) >= 36 then Label1.Font.Color := clRed
    else Label1.Font.Color := clBlack;
    Label1.Caption := CurrToStr((GetTickCount() / 86400000)) + '天';
    
    nRow := 1;
    Config := @g_Config;
    EnterCriticalSection(Config.GateCriticalSection);
    try
      if Config.GateList.Count > 0 then begin
        for I := 0 to Config.GateList.Count - 1 do begin
          GateInfo := Config.GateList.Items[I];
          GridGate.Cells[0, I + 1] := '';
          GridGate.Cells[1, I + 1] := '';
          GridGate.Cells[2, I + 1] := '';
          GridGate.Cells[3, I + 1] := '';
          GridGate.Cells[4, I + 1] := '';
          GridGate.Cells[0, nRow] := IntToStr(I);
          GridGate.Cells[1, nRow] := GateInfo.sIPaddr + ':' + IntToStr(GateInfo.nPort);
          GridGate.Cells[2, nRow] := IntToStr(GateInfo.nSuccesCount);
          GridGate.Cells[3, nRow] := IntToStr(GateInfo.nFailCount);
          GridGate.Cells[4, nRow] := IntToStr(GateInfo.UserList.Count);
          Inc(nRow);
        end;
      end else begin
        for I := 0 to GridGate.RowCount - 1 do begin
          for nRow := 0 to GridGate.ColCount - 1 do begin
            if Odd(i) then
            GridGate.Cells[nRow, i] := '';
          end;
        end;
      end;
    finally
      LeaveCriticalSection(Config.GateCriticalSection);
    end;
  end;
  if not boGateReady{是否和生成服务端连接} and (boServiceStart) then begin//与生成服务端断开,则自动连接
    if (GetTickCount - dwReConnectServerTick) > 1000 {30 * 1000} then begin
      dwReConnectServerTick := GetTickCount();
      ClientSocket.Active := False;
      ClientSocket.Address := '127.0.0.1';
      ClientSocket.Port := 37002;
      ClientSocket.Active := True;
    end;
  end;
  {if (GetTickCount - dwSQLConnectTick) > 2000  then begin
    dwSQLConnectTick := GetTickCount();
    try
      //FrmDm.ADOConn.Connected :=False;
      FrmDm.ADOConn.Connected :=True;
    except
      on E: Exception do begin
        MainOutMessage('XXX:'+IntToStr(FrmDm.ADOConn.Errors.Count));
        MainOutMessage(E.Message);
        FrmDm.ConnectedAccess('');
      end;
    end;
    try
      //FrmDm.ADOConn2.Connected :=False;
      FrmDm.ADOConn2.Connected :=True;
    except
      on E: Exception do begin
        MainOutMessage('@@@:'+IntToStr(FrmDm.ADOConn2.Errors.Count));
        MainOutMessage(E.Message);
        FrmDm.ConnectedAccess2;
      end;
    end;
  end;  }
end;

{
procedure TFrmMain.DLChangePass(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  sDest: string;
  sLoginID: string;
  sOldPass: string;
  sNewPass: string;
  AdoQuery: TADOQuery;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sOldPass, ['/']);
    sDest := GetValidStr3(sDest, sNewPass, ['/']);
    if sLoginID = UserInfo.sAccount then begin
      if sOldPass = UserInfo.sPassWord then begin
        AdoQuery := TADOQuery.Create(nil);
        try
          AdoQuery.Connection := FrmDm.ADOconn;
          with AdoQuery do begin
            Close;
            SQL.Clear;
            SQL.Add('Update DLUserInfo set Pass=:a1 Where [User]=:a3') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := Trim(sNewPass);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);
            try
              ExecSQL;
              nCheckCode := 1;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          AdoQuery.Free;
        end;
      end else nCheckCode := -3;
    end else nCheckCode := -2;
  end else nCheckCode := -1;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_CHANGEPASS_SUCCESS, 0, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_CHANGEPASS_FAIL, nCheckCode, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;  }
{
procedure TFrmMain.ChangePass(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  sDest: string;
  sLoginID: string;
  sOldPass: string;
  sNewPass: string;
  AdoQuery: TADOQuery;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sOldPass, ['/']);
    sDest := GetValidStr3(sDest, sNewPass, ['/']);
    if sLoginID = UserInfo.sAccount then begin
      if sOldPass = UserInfo.sPassWord then begin
        AdoQuery := TADOQuery.Create(nil);
        try
          AdoQuery.Connection := FrmDm.ADOconn;
          with AdoQuery do begin
            Close;
            SQL.Clear;
            //SQL.Add('Update UserInfo Set [Pass]="'+sNewPass+'" Where [User]="'+sLoginID+'"');
            SQL.Add('Update UserInfo set [Pass]=:a1 Where [User]=:a3') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := Trim(sNewPass);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);
            try
              ExecSQL;
              nCheckCode := 1;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          AdoQuery.Free;
        end;
      end else nCheckCode := -3;
    end else nCheckCode := -2;
  end else nCheckCode := -1;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHANGEPASS_SUCCESS, 0, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHANGEPASS_FAIL, nCheckCode, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;     }
{
procedure TFrmMain.MakeGate(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  Judge: TADOQuery;
  sDest: string;
  sUserKeyPass: string;
  sKeyPass: string;
  sGatePass: string;
  sSendData: string;
begin
  if UserInfo.boLogined then begin
    Judge:=TADOQuery.Create(Nil);
    try
      Judge.Connection := FrmDm.ADOconn;
      with Judge do begin
        Close;
        SQL.Clear;
        SQL.Add('Select MakeKey,GatePass From UserInfo Where [User]=:a1 and [Pass]=:a2');
        Parameters.ParamByName('a1').DataType:=Ftstring;
        Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
        Parameters.ParamByName('a2').DataType :=Ftstring;
        Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
        Open();
        if RecordCount > 0 then begin
         sKeyPass := FieldByName('MakeKey').AsString;
         sGatePass := FieldByName('GatePass').AsString;
        end;
        Close;
      end;
    finally
      Judge.Free;
    end;
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sUserKeyPass, ['/']);
    if (sUserKeyPass <> '') and (sGatePass <> '') and (Length(sGatePass) = 20) then begin
      if sUserKeyPass = sKeyPass then begin
        sSendData := UserInfo.sAccount + '/' + sGatePass + '/' + UserInfo.sSockIndex;
        ClientSocket.Socket.SendText('%G'+ EncryptString(sSendData) + '$');
      end;
    end;
  end;
end;

procedure TFrmMain.MakeLogin(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  Judge: TADOQuery;
  sGameListUrl: string;
  sBakGameListUrl: string;
  sPatchListUrl: string;
  sGameMonListUrl: string;
  sGameESystemUrl: string;
  sPass: string;
  sDest: string;
  sLoginName: string;
  sClientFileName: string;
  sLocalGameListName: string;
  sLoginSink: string;
  sboLoginMainImages: string;
  sboAssistantFilter: string;
  sSendData: string;
begin
  if UserInfo.boLogined then begin //如果已经登陆
    Judge:=TADOQuery.Create(Nil);
      try
       Judge.Connection := FrmDm.ADOconn;
       with Judge do begin
         Close;
         SQL.Clear;
         SQL.Add('Select GameListUrl,BakGameListUrl,PatchListUrl,GameMonListUrl,GameESystemUrl,GatePass From UserInfo');
         SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
         Parameters.ParamByName('a1').DataType:=Ftstring;
         Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
         Parameters.ParamByName('a2').DataType :=Ftstring;
         Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
         Open();
         if RecordCount > 0 then begin
           sGameListUrl := FieldByName('GameListUrl').AsString;
           sBakGameListUrl := FieldByName('BakGameListUrl').AsString;
           sPatchListUrl := FieldByName('PatchListUrl').AsString;
           sGameMonListUrl := FieldByName('GameMonListUrl').AsString;
           sGameESystemUrl := FieldByName('GameESystemUrl').AsString;
           sPass := FieldByName('GatePass').AsString;
         end;
         Close;
       end;
      finally
       Judge.Free;
      end;
      sDest := DecryptString(sData);
      sDest := GetValidStr3(sDest, sLoginName, ['/']);
      sDest := GetValidStr3(sDest, sClientFileName, ['/']);
      sDest := GetValidStr3(sDest, sLocalGameListName, ['/']);
      sDest := GetValidStr3(sDest, sLoginSink, ['/']);
      sDest := GetValidStr3(sDest, sboLoginMainImages, ['/']);
      sDest := GetValidStr3(sDest, sboAssistantFilter, ['/']);
      if (sLoginName <> '') and (sClientFileName <> '') and (sLocalGameListName <> '') and (sLoginSink <> '') and (sboLoginMainImages <> '') and (sboAssistantFilter <> '') then begin
        sSendData := UserInfo.sAccount + ',' + UserInfo.sSockIndex + ',' +
          sGameListUrl + ',' + sBakGameListUrl + ',' + sPatchListUrl + ',' + sGameMonListUrl + ',' +
          sGameESystemUrl + ',' + sPass + ',' + sLoginName + ',' + sClientFileName + ',' +
          sLocalGameListName + ',' + sLoginSink + ',' + sboLoginMainImages + ',' + sboAssistantFilter;
        ClientSocket.Socket.SendText('%L'+ EncryptString(sSendData) + '$');
      end;
  end;
end;

procedure TFrmMain.CheckMakeKeyAndDayMakeNum(Config: pTConfig;
  UserInfo: pTM2UserInfo; sData: string);
var
  sKey: string;
  nCheckCode: Integer;
  Judge: TADOQuery;
  sUserKey: string;
  nDayMakeNum: Integer;
  DefMsg: TDefaultMessage;
begin
  nCheckCode := -1;
  if UserInfo.boLogined then begin
    sKey := DecryptString(sData);
    if (sKey <> '') and (Length(sKey) = 100) then begin
      Judge:=TADOQuery.Create(Nil);
      try
       Judge.Connection := FrmDm.ADOconn;
       with Judge do begin
         Close;
         SQL.Clear;
         SQL.Add('Select MakeKey,DayMakeNum From UserInfo');
         SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
         Parameters.ParamByName('a1').DataType:=Ftstring;
         Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
         Parameters.ParamByName('a2').DataType :=Ftstring;
         Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
         Open();
         if RecordCount > 0 then begin
           sUserKey := FieldByName('MakeKey').AsString;
           nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
         end;
         Close;
       end;
      finally
       Judge.Free;
      end;
      if sUserKey = sKey then begin
        if nDayMakeNum < g_btMaxDayMakeNum then
          nCheckCode := 1
        else nCheckCode := -3;
      end else nCheckCode := -2;
    end else nCheckCode := -2;
  end else nCheckCode := -1;
  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEKEYANDDAYMAKENUM_SUCCESS, 0, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEKEYANDDAYMAKENUM_FAIL, nCheckCode, 0, 0, 0);
    SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end; }

procedure TFrmMain.N2Click(Sender: TObject);
begin
//  ClientSocket.Socket.SendText('%L'+ '11' + '$');
MainOutMessage(RivestStr('E10ADC3949BA59ABBE56E057F20F883E'));
end;

procedure TFrmMain.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sRecvMsg: string;
begin
  sRecvMsg := Socket.ReceiveText;
  MakeSockeMsgList.Add(sRecvMsg);
end;

procedure TFrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  boGateReady := True;
  MainOutMessage('生成服务器(' + Socket.RemoteAddress + ':' + IntToStr(Socket.RemotePort) + ')连接成功');
end;

procedure TFrmMain.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  boGateReady := False;
end;

procedure TFrmMain.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  Socket.Close;
  ErrorCode := 0;
  boGateReady := False;
end;

procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  StartService();
end;

procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认停止服务？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then
    StopService();
end;

procedure TFrmMain.N4Click(Sender: TObject);
begin
  StartTimer.Enabled := True;
end;

procedure TFrmMain.N8Click(Sender: TObject);
begin
  FrmBasicSet := TFrmBasicSet.Create(Owner);
  FrmBasicSet.Open();
  FrmBasicSet.Free;
end;

procedure TFrmMain.SendGateKickMsg(Socket: TCustomWinSocket;
  sSockIndex: string);
var
  sSendMsg: string;
begin
  if (Socket <> nil) and Socket.Connected then begin
    sSendMsg := '%+-' + sSockIndex + '$';
    Socket.SendText(sSendMsg);
  end;
end;

initialization
  begin
    g_MainShowMsgList := nil;
    g_MainShowMsgList := TStringList.Create;
    MakeSockeMsgList := TStringList.Create;
    InitializeCriticalSection(g_CriticalSection);
    InitializeCriticalSection(MakeResultCs);
  end;
finalization
  begin
    g_MainShowMsgList.Free;
    MakeSockeMsgList.Free;
    DeleteCriticalSection(g_CriticalSection);
    DeleteCriticalSection(MakeResultCs);
  end;
end.

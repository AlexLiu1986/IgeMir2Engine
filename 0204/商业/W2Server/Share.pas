unit Share;

interface
uses Windows, Classes, SysUtils, JSocket, Controls, ADODB, DB;

type
  TConfig = record
    sGateIPaddr: string[30];
    boShowDetailMsg: Boolean;
    GateCriticalSection: TRTLCriticalSection;
    dwProcessGateTick: LongWord;
    dwProcessGateTime: LongWord;
    GateList: TList;
  end;
  pTConfig = ^TConfig;

  TLoginGateInfo = record
    Socket: TCustomWinSocket;
    sIPaddr: string;
    nPort: Integer;
    sReceiveMsg: string;
    nSuccesCount: Integer;
    nFailCount: Integer;
    UserList: TList;
    dwKeepAliveTick: LongWord;
  end;
  pTLoginGateInfo = ^TLoginGateInfo;

  TM2UserInfo = record
    Socket: TCustomWinSocket;
    sUserIPaddr: string; //用户IP
    sSockIndex: string;  //通讯标实
    sReceiveMsg: string;//接收的信息
    dwClientTick: LongWord;
    dwKickTick: LongWord;
    boKick: Boolean;
    sAccount: string;
    sPassWord: string;
    boLogined: Boolean; //是否已经登陆
  end;
  pTM2UserInfo = ^TM2UserInfo;
const
  USERMAXSESSION = 1000; //用户的最大连接
  sPrice = 200; //代理注册登陆器价格
var
  g_boCanStart: Boolean;
  g_dwServerStartTick: LongWord;
  g_Config: pTConfig;
  UserSessionCount: Integer; //0x32C 用户连接会话数
  g_btMaxDayMakeNum: Integer = 10; //每日最大生成次数
  MakeSockeMsgList: TStringList; //生成器返回来的消息列表
  sProcMsg: string;
  boGateReady: Boolean = False;//是否与生成服务器连接
  boServiceStart: Boolean = False;//服务是否启动
  g_dwStartTick: LongWord; //启动间隔
function CheckUserExist (str, sAccount: string): Boolean;
function MaxCurr(Val1, Val2: Currency): Currency;
function CheckMaXID(Ado: TADOQuery; str: string): Integer;
function UserLogined(sLoginID: string; GateInfo: pTLoginGateInfo): Boolean;
//procedure CheckUserTime(UserName: string);
//procedure MainOutMessage(sMsg: string);

procedure AddUserTips(DLUserName,UserName,ZT: string; Yue: Currency);//增加日志
implementation
uses DM;
//检测用户是否存在
//str为表名
//返回值 True 为存在这个用户
function CheckUserExist (str, sAccount: string): Boolean;
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := FrmDm.ADOconn;
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('Select User from '+str+' where [User] =:a0');
       Parameters.ParamByName('a0').DataType:=Ftstring;
       Parameters.ParamByName('a0').Value :=Trim(sAccount);
       Open;
       if RecordCount <> 0 then Result := True
       else Result := False;
    end;
  finally
    Ado.Free;
    FrmDm.ADOconn.Close;
  end;
end;

//取表中ID号,
function CheckMaXID(Ado: TADOQuery; str: string): Integer;
begin
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('Select Max(ID) as a from '+str);
       Open;
       IF Ado.Fields[0].AsInteger=0 then Result := 1
       Else Result:=Ado.Fields[0].AsInteger+1;
    end;
  finally
  end;
end;
{//比较登陆时间,不为当前日期,则把每天生成次数初始
procedure CheckUserTime(UserName: string);
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := FrmDm.ADOconn;
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('SELECT * FROM UserInfo where (datediff(dd,Timer,:a1) = 0) and [User]=:a2 ');
       parameters.ParamByName('a1').DataType:=Ftstring;
       parameters.ParamByName('a1').Value := DateToStr(now);
       parameters.ParamByName('a2').DataType :=Ftstring;
       parameters.ParamByName('a2').Value := Trim(UserName);
       Open;
       IF Ado.RecordCount = 0 then begin
          Close;
          SQL.Clear;
          SQL.Add('Update UserInfo set dayMakeNum=:a1 Where [User]=:a2') ;
          parameters.ParamByName('a1').DataType:=FtInteger;
          parameters.ParamByName('a1').Value := 0;
          parameters.ParamByName('a2').DataType :=Ftstring;
          parameters.ParamByName('a2').Value := Trim(UserName);
          ExecSQL;
       end;
    end;
  finally
    Ado.Free;
  end;
end;  }

//增加日志
//ZT 1-修改代理人余额 2-用户生成程序 3-注册用户 4-注册代理 5-用户修改密码 6-代理修改密码
procedure AddUserTips(DLUserName,UserName,ZT: string; Yue: Currency);
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := FrmDm.ADOconn;
  try
    with Ado do begin
      Close;
      SQL.Clear;
      SQL.Add('EXEC ADDTips :a1,:a2,:a3,:a4') ;
      parameters.ParamByName('a1').DataType:=Ftstring;
      parameters.ParamByName('a1').Value := Trim(DLUserName);
      parameters.ParamByName('a2').DataType :=Ftstring;
      parameters.ParamByName('a2').Value := Trim(UserName);
      parameters.ParamByName('a3').DataType :=FtCurrency;
      parameters.ParamByName('a3').Value := Yue;
      parameters.ParamByName('a4').DataType :=Ftstring;
      parameters.ParamByName('a4').Value := ZT;
      ExecSQL;
    end;
  finally
    Ado.Free;
    FrmDm.ADOconn.Close;
  end;
end;

function MaxCurr(Val1, Val2: Currency): Currency;
begin
  if Val1>=Val2 then Result := Val1 else Result := Val2;
end;

function UserLogined(sLoginID: string; GateInfo: pTLoginGateInfo): Boolean;
var
  UserInfo: pTM2UserInfo;
  I{, II}: Integer;
begin
  Result := False;
  for I := 0 to GateInfo.UserList.Count - 1 do begin
    UserInfo := GateInfo.UserList.Items[I];
    if UserInfo.sAccount = sLoginID then begin
      Result := True;
    end;
  end;
end;

end.

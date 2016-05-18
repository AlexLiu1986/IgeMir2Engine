unit ThreadQuery;

interface
uses Windows,DB, ADODB,Classes,Dialogs, SysUtils,Grobal2, Share;

type
  TQueryThread = class(TThread)//用户登陆线程
  private
    FQuery:TADOQuery;
  protected
    procedure Execute;override;
  public
    GateInfo: pTLoginGateInfo;
    SQLText:String;
    sLoginID:string;
    sPassword:string;
    UserInfo: pTM2UserInfo;
    constructor Create(AOwner:TComponent);
    destructor  Destroy;override;
  end;

  TDLUserLoginThread = class(TThread)//代理登陆
  private
    FQuery:TADOQuery;
  protected
    procedure Execute;override;
  public
    GateInfo: pTLoginGateInfo;
    SQLText:String;
    sLoginID:string;
    sPassword:string;
    UserInfo: pTM2UserInfo;
    constructor Create(AOwner:TComponent);
    destructor  Destroy;override;
  end;

  TUserMsgThread = class(TThread)//其它消息处理线程
  private
    nCode:Byte;//操作类型
    FQuery:TADOQuery;
    procedure AddUser(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//增加用户
    procedure CheckAccount(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//代理检测用户是否存在
    procedure DLChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//代理修改密码
    procedure ChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//用户修改密码
    procedure CheckMakeKeyAndDayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//验证密钥匙和今日生成次数
    procedure MakeLogin(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//生成登陆器
    procedure MakeGate(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//生成网关
  protected
    procedure Execute;override;
  public
    SQLText:String;
    UserInfo: pTM2UserInfo;
    Config: pTConfig;
    constructor Create(AOwner:TComponent;Code:Byte);
    destructor  Destroy;override;
  end;

  TUpdateUserDayMakeNumThread = class(TThread)//修改生成次数线程
  private
    FQuery:TADOQuery;
  protected
    procedure Execute;override;
  public
    SQLText:string;
    sLoginID:string;
    UserInfo: pTM2UserInfo;
    DefMsg: TDefaultMessage;
    constructor Create(AOwner:TComponent);
    destructor  Destroy;override;
  end;
  
var
  QueryThread: TQueryThread;
  DLUserLoginThread: TDLUserLoginThread;
  UserMsgThread0,UserMsgThread1,UserMsgThread2,UserMsgThread3,UserMsgThread4,UserMsgThread5,UserMsgThread6: TUserMsgThread;
  UpdateUserDayMakeNum1: TUpdateUserDayMakeNumThread;
implementation
uses DM, Main, EDcode, Common, EDcodeUnit, HUtil32, MD5EncodeStr;

//----------------------用户登陆---------------------------------------------
constructor TQueryThread.Create(AOwner:TComponent);
begin
  FQuery := TADOQuery.Create(AOwner);
  FQuery.Connection:= FrmDm.ADOconn;

  FreeOnTerminate:= True;
  inherited  Create(True);
end;   

destructor TQueryThread.Destroy;
begin
  FQuery.Free;
end;

procedure TQueryThread.Execute;
Var
  UserInfo1: TUserInfo;
  sSENDTEXT,sDest: string;
  sTimer:TDateTime;
  DefMsg: TDefaultMessage;
  nCode: Byte;
begin
  try
    if not UserInfo.boLogined then begin
     nCode:= 0;
     sDest := DecryptString(SQLText);
     sDest := GetValidStr3(sDest, sLoginID, ['/']);
     sDest := GetValidStr3(sDest, sPassword, ['/']);
     sPassword:=RivestStr(sPassword);//20080909
     if not UserLogined(sLoginID, GateInfo) then begin
       nCode:= 1;
       try
        with FQuery do begin
          nCode:= 2;
          Close;
          SQL.Clear;
          SQL.Add('Select * From UserInfo Where [User]=:a1 and Pass=:a2') ;
          parameters.ParamByName('a1').DataType:=Ftstring;
          parameters.ParamByName('a1').Value := Trim(sLoginID);
          parameters.ParamByName('a2').DataType :=Ftstring;
          parameters.ParamByName('a2').Value := Trim(sPassword);
          Open;
          nCode:= 3;
          if RecordCount = 0 then begin
            nCode:= 4;
            DefMsg := MakeDefaultMsg(SM_USERLOGIN_FAIL, 0, 0, 0, 0);
            nCode:= 5;
            FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
            UserInfo.boKick := True;
            UserInfo.dwKickTick := GetTickCount + 5000;
          end else begin
            nCode:= 6;
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
            nCode:= 7;
            DefMsg := MakeDefaultMsg(SM_USERLOGIN_SUCCESS, 0, 0, 0, 0);
            sSENDTEXT := EncryptBuffer(@UserInfo1, SizeOf(TUserInfo));
            FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + sSENDTEXT);
            nCode:= 8;
            sTimer:= FieldByName('Timer').AsDateTime;
            if int(sTimer) <> int(Date()) then begin//日期不一致,则清0
              nCode:= 9;
              Close;
              SQL.Clear;
              SQL.Add('Update UserInfo set dayMakeNum=:a1,IPAddress=:a2,Timer=GetDate() Where [User]=:a4') ;
              parameters.ParamByName('a1').DataType:=FtInteger;
              parameters.ParamByName('a1').Value := 0;
              parameters.ParamByName('a2').DataType:=Ftstring;
              parameters.ParamByName('a2').Value := UserInfo.sUserIPaddr;
              parameters.ParamByName('a4').DataType :=Ftstring;
              parameters.ParamByName('a4').Value := Trim(sLoginID);
              nCode:= 10;
              ExecSQL;
            end else begin
              nCode:= 11;
              Close;
              SQL.Clear;
              SQL.Add('Update UserInfo set IPAddress=:a1,Timer=GetDate() Where [User]=:a3') ;
              parameters.ParamByName('a1').DataType:=Ftstring;
              parameters.ParamByName('a1').Value := UserInfo.sUserIPaddr;
              parameters.ParamByName('a3').DataType :=Ftstring;
              parameters.ParamByName('a3').Value := Trim(sLoginID);
              nCode:= 12;
              ExecSQL;
            end;
          end;
        end;
       finally
         FrmDm.ADOconn.Close;
       end;
     end else begin
        DefMsg := MakeDefaultMsg(SM_USERLOGIN_FAIL, 1, 0, 0, 0);
        FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
        UserInfo.boKick := True;
        UserInfo.dwKickTick := GetTickCount + 5000;
     end;
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] TQueryThread.Execute Code:'+IntToStr(nCode)+' '+booltostr(FrmDm.ADOconn.KeepConnection));
      FrmMain.MainOutMessage(E.Message);
    end;
  end;
end;

//-------------------------代理登陆---------------------------------------
constructor TDLUserLoginThread.Create(AOwner:TComponent);
begin
  FQuery := TADOQuery.Create(AOwner);
  FQuery.Connection:= FrmDm.ADOconn;

  FreeOnTerminate:= True;
  inherited  Create(True);
end;

destructor TDLUserLoginThread.Destroy;
begin
  FQuery.Free;
end;

procedure TDLUserLoginThread.Execute;
Var
  DLUserInfo: TDLUserInfo;
  sSENDTEXT,sDest: string;
  DefMsg: TDefaultMessage;
  nCode: Byte;
begin
  try
    if not UserInfo.boLogined then begin
     nCode:= 0;
     sDest := DecryptString(SQLText);
     sDest := GetValidStr3(sDest, sLoginID, ['/']);
     sDest := GetValidStr3(sDest, sPassword, ['/']);
     sPassword:=RivestStr(sPassword);//20080909     .
     if not UserLogined(sLoginID, GateInfo) then begin
       nCode:= 1;
       try
        with FQuery do begin
          Close;
          SQL.Clear;
          SQL.Add('Select * From DLUserInfo Where [User]=:a1 and Pass=:a2') ;
          parameters.ParamByName('a1').DataType:=Ftstring;
          parameters.ParamByName('a1').Value := Trim(sLoginID);
          parameters.ParamByName('a2').DataType :=Ftstring;
          parameters.ParamByName('a2').Value := Trim(sPassword);
          nCode:= 2;
          Open;
          if RecordCount = 0 then begin
            nCode:= 3;
            DefMsg := MakeDefaultMsg(SM_LOGIN_FAIL, 0, 0, 0, 0);
            nCode:= 4;
            FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
            UserInfo.boKick := True;
            UserInfo.dwKickTick := GetTickCount + 5000;
            nCode:= 5;
            Close;
          end else begin
            nCode:= 6;
            FillChar(DLUserInfo, SizeOf(TDLUserInfo), 0);
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
            nCode:= 7;
            DefMsg := MakeDefaultMsg(SM_LOGIN_SUCCESS, 0, 0, 0, 0);
            sSENDTEXT := EncryptBuffer(@DLUserInfo, SizeOf(TDLUserInfo));
            nCode:= 8;
            FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + sSENDTEXT);
            nCode:= 9;
            Close;
            SQL.Clear;
            SQL.Add('Update DLUserInfo set IPAddress=:a1,Timer=GetDate() Where [User]=:a3') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := UserInfo.sUserIPaddr;
            parameters.ParamByName('a3').DataType :=Ftstring;
            parameters.ParamByName('a3').Value :=sLoginID;
            nCode:= 10;
            ExecSQL;
          end;
        end;
        finally
          FrmDm.ADOconn.Close;
        end;
     end else begin
        DefMsg := MakeDefaultMsg(SM_LOGIN_FAIL, 1, 0, 0, 0);
        FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
        UserInfo.boKick := True;
        UserInfo.dwKickTick := GetTickCount + 5000;
     end;
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] TDLUserLoginThread.Execute Code:'+IntToStr(nCode)+'  '+booltostr(FrmDm.ADOconn.KeepConnection));
      FrmMain.MainOutMessage(E.Message);
    end;
  end;
end;

//-------------------------其它消息处理线程---------------------------------------
constructor TUserMsgThread.Create(AOwner:TComponent;Code:Byte);
begin
  FQuery := TADOQuery.Create(AOwner);
  FQuery.Connection:= FrmDm.ADOconn;
  nCode:= Code;
  FreeOnTerminate:= True;
  inherited  Create(True);
end;   

destructor TUserMsgThread.Destroy;
begin
  FQuery.Free;
end;

//增加用户      btCheckCode 1-注册成功  2-未登陆 3-用户已存在 4,5-出现异常
procedure TUserMsgThread.AddUser(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
  //随机取密码
  function RandomGetPass():string;
  var
    s,s1:string;
    I,i0:Byte;
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
    I,i0:Byte;
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
  YuE, XiaoShouE: Currency;
  btCheckCode: byte;
  sPass: string;
  sKey: string;
  DefMsg: TDefaultMessage;
  sSENDTEXT: string;
  I,ID: Integer;
  GateInfo: pTLoginGateInfo;
begin
  if UserInfo.boLogined then begin  //如果代理用户已经登陆
     YuE := 0;
     btCheckCode := 0;
    try
     with FQuery do begin
       Close;
       SQL.Clear;
       SQL.Add('Select YuE,XiaoShouE From DLUserInfo Where [User]=:a1 and Pass=:a2');
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

     if YuE >= sPrice then btCheckCode := 1;
     if btCheckCode = 1 then begin
        FillChar(UserSession, SizeOf(TUserEntry1), #0);
        DecryptBuffer(sData, @UserSession, SizeOf(TUserEntry1));
        if (UserSession.sAccount <> '') and (UserSession.sGameListUrl <> '') and (UserSession.sBakGameListUrl <> '') and (UserSession.sPatchListUrl <> '') and (UserSession.sGameMonListUrl <> '') and (UserSession.sGatePass <> '') then begin
          if not CheckUserExist('UserInfo',UserSession.sAccount) then begin //如果帐号不存在
              ID:= CheckMaXID(FQuery,'UserInfo');
              with FQuery do begin
                try
                  Close;
                  SQL.Clear;
                  SQL.Add('Insert Into UserInfo (ID,[User],Pass,QQ,');
                  SQL.Add('GameListUrl,BakGameListUrl,PatchListUrl,GameMonListUrl,GameESystemUrl,GatePass,MakeKey,Who,RegTimer,DayMakeNum)');
                  SQL.Add('  Values(:a13,:a0,:a1,:a2,:a3,:a4,:a5,:a6,:a7,:a8,:a9,:a10,:a11,:a12)');
                  Parameters.ParamByName('a13').DataType:=FtInteger;
                  Parameters.ParamByName('a13').Value := ID;
                  Parameters.ParamByName('a0').DataType:=Ftstring;
                  Parameters.ParamByName('a0').Value :=Trim(UserSession.sAccount);
                  Parameters.ParamByName('a1').DataType:=Ftstring;
                  sPass := RandomGetPass;
                  Parameters.ParamByName('a1').Value := RivestStr(sPass);
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
                    SQL.Add('Update DLUserInfo set YuE=:a1,XiaoShouE=:a2 Where [User]=:a3') ;
                    parameters.ParamByName('a1').DataType:=FtCurrency;
                    parameters.ParamByName('a1').Value := CurrToStr(YuE);
                    parameters.ParamByName('a2').DataType :=FtCurrency;
                    parameters.ParamByName('a2').Value := CurrToStr(XiaoShouE);
                    parameters.ParamByName('a3').DataType :=Ftstring;
                    parameters.ParamByName('a3').Value := Trim(UserInfo.sAccount);
                    ExecSQL;
                    Close;

                    Randomize(); //随机种子
                    if Random(2)=0 then
                    AddUserTips(Trim(UserInfo.sAccount),Trim(UserSession.sAccount),'3', sPrice);//添加日志
                  except
                    btCheckCode := 4;
                  end;
                except
                  btCheckCode := 5;
                end;
              end;
          end else btCheckCode := 3; //
        end;
     end;
   finally
    FrmDm.ADOconn.Close;
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
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + EncryptString(sSENDTEXT));
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
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//代理检测用户是否存在
procedure TUserMsgThread.CheckAccount(Config: pTConfig; UserInfo: pTM2UserInfo;
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
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//代理修改密码
procedure TUserMsgThread.DLChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sLoginID: string;
  sOldPass: string;
  sNewPass: string;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sOldPass, ['/']);
    sDest := GetValidStr3(sDest, sNewPass, ['/']);
    if sLoginID = UserInfo.sAccount then begin
      if RivestStr(Trim(sOldPass)) = UserInfo.sPassWord then begin
        try
          with FQuery do begin
            Close;
            SQL.Clear;
            SQL.Add('Update DLUserInfo set Pass=:a1 Where [User]=:a2') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := RivestStr(Trim(sNewPass));//20080909//Trim(sNewPass);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);
            try
              ExecSQL;
              AddUserTips(Trim(sLoginID),'','6', 0);//添加日志
              nCheckCode := 1;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          FrmDm.ADOconn.Close;
        end;
      end else nCheckCode := -3;
    end else nCheckCode := -2;
  end else nCheckCode := -1;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_CHANGEPASS_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_CHANGEPASS_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//用户修改密码
procedure TUserMsgThread.ChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sLoginID: string;
  sOldPass: string;
  sNewPass: string;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sOldPass, ['/']);
    sDest := GetValidStr3(sDest, sNewPass, ['/']);
    if sLoginID = UserInfo.sAccount then begin
      if RivestStr(Trim(sOldPass)) = UserInfo.sPassWord then begin
        try
          with FQuery do begin
            Close;
            SQL.Clear;
            SQL.Add('Update UserInfo set [Pass]=:a1 Where [User]=:a2') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := RivestStr(Trim(sNewPass));//20080909//Trim(sNewPass);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);
            try
              ExecSQL;
              AddUserTips('',Trim(sLoginID),'5', 0);//添加日志
              nCheckCode := 1;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          FrmDm.ADOconn.Close;
        end;
      end else nCheckCode := -3;
    end else nCheckCode := -2;
  end else nCheckCode := -1;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHANGEPASS_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHANGEPASS_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//验证密钥匙和今日生成次数
procedure TUserMsgThread.CheckMakeKeyAndDayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sKey: string;
  nCheckCode: Integer;
  sUserKey: string;
  nDayMakeNum: Integer;
  DefMsg: TDefaultMessage;
begin
  nCheckCode := -1;
  if UserInfo.boLogined then begin
    sKey := DecryptString(sData);
    if (sKey <> '') and (Length(sKey) = 100) then begin
      try
       with FQuery do begin
         Close;
         SQL.Clear;
         SQL.Add('Select MakeKey,DayMakeNum From UserInfo');
         SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
         Parameters.ParamByName('a1').DataType:=Ftstring;
         Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
         Parameters.ParamByName('a2').DataType :=Ftstring;
         Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
         Open();
         if RecordCount > 0 then begin
           sUserKey := FieldByName('MakeKey').AsString;
           nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
         end;
         Close;
       end;
      finally
        FrmDm.ADOconn.Close;
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
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEKEYANDDAYMAKENUM_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//生成登陆器
procedure TUserMsgThread.MakeLogin(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sGameListUrl: string;
  sBakGameListUrl: string;
  sPatchListUrl: string;
  sGameMonListUrl: string;
  sGameESystemUrl: string;
  sPass: string;
  sDest: string;
  sLoginName: string;
  sClientFileName: string;
  sLoginSink: string;
  sboLoginMainImages: string;
  sboAssistantFilter: string;
  sSendData: string;
begin
  if UserInfo.boLogined then begin //如果已经登陆
    try
       with FQuery do begin
         Close;
         SQL.Clear;
         SQL.Add('Select GameListUrl,BakGameListUrl,PatchListUrl,GameMonListUrl,GameESystemUrl,GatePass From UserInfo');
         SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
         Parameters.ParamByName('a1').DataType:=Ftstring;
         Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
         Parameters.ParamByName('a2').DataType :=Ftstring;
         Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
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
      FrmDm.ADOconn.Close;
    end;

      sDest := DecryptString(sData);
      sDest := GetValidStr3(sDest, sLoginName, ['/']);
      sDest := GetValidStr3(sDest, sClientFileName, ['/']);
      sDest := GetValidStr3(sDest, sLoginSink, ['/']);
      sDest := GetValidStr3(sDest, sboLoginMainImages, ['/']);
      sDest := GetValidStr3(sDest, sboAssistantFilter, ['/']);
      if (sLoginName <> '') and (sClientFileName <> '') and (sLoginSink <> '') and (sboLoginMainImages <> '') and (sboAssistantFilter <> '') then begin
        sSendData := UserInfo.sSockIndex + ',' +UserInfo.sAccount + ',' +
          sGameListUrl + ',' + sBakGameListUrl + ',' + sPatchListUrl + ',' + sGameMonListUrl + ',' +
          sGameESystemUrl + ',' + sPass + ',' + sLoginName + ',' + sClientFileName + ',' +
          sLoginSink + ',' + sboLoginMainImages + ',' + sboAssistantFilter;
        FrmMain.ClientSocket.Socket.SendText('%L'+ EncryptString(sSendData) + '$');
        AddUserTips('',Trim(UserInfo.sAccount),'2', 0);//添加日志
      end;
  end;
end;

//生成网关
procedure TUserMsgThread.MakeGate(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sUserKeyPass: string;
  sKeyPass: string;
  sGatePass: string;
  sSendData: string;
begin
  if UserInfo.boLogined then begin
    try
      with FQuery do begin
        Close;
        SQL.Clear;
        SQL.Add('Select MakeKey,GatePass From UserInfo Where [User]=:a1 and [Pass]=:a2');
        Parameters.ParamByName('a1').DataType:=Ftstring;
        Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
        Parameters.ParamByName('a2').DataType :=Ftstring;
        Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
        Open();
        if RecordCount > 0 then begin
          sKeyPass := FieldByName('MakeKey').AsString;
          sGatePass := FieldByName('GatePass').AsString;
        end;
        Close;
      end;
    finally
      FrmDm.ADOconn.Close;
    end;

    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sUserKeyPass, ['/']);
    if (sUserKeyPass <> '') and (sGatePass <> '') and (Length(sGatePass) = 20) then begin
      if sUserKeyPass = sKeyPass then begin
        sSendData := UserInfo.sSockIndex + '/' + UserInfo.sAccount + '/' + sGatePass;
        FrmMain.ClientSocket.Socket.SendText('%G'+ EncryptString(sSendData) + '$');
        AddUserTips('',Trim(UserInfo.sAccount),'2', 0);//添加日志
      end;
    end;
  end;
end;

procedure TUserMsgThread.Execute;
begin
  try
    case nCode of
      0: AddUser(Config, UserInfo, SQLText);//增加用户
      1: CheckAccount(Config, UserInfo, SQLText);//代理检测用户是否存在
      2: DLChangePass(Config, UserInfo, SQLText); //代理修改密码
      3: ChangePass(Config, UserInfo, SQLText); //用户修改密码
      4: CheckMakeKeyAndDayMakeNum(Config, UserInfo, SQLText);//验证密钥匙和今日生成次数
      5: MakeLogin(Config, UserInfo, SQLText); //生成登陆器
      6: MakeGate(Config, UserInfo, SQLText); //生成网关
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] TUserMsgThread.Execute Code:'+inttostr(nCode));
      FrmMain.MainOutMessage(E.Message);
    end;
  end;
end;

//-------------------------- 修改生成次数线程------------------------------
constructor TUpdateUserDayMakeNumThread.Create(AOwner:TComponent);
begin
  FQuery := TADOQuery.Create(AOwner);
  FQuery.Connection:= FrmDm.ADOconn2;

  FreeOnTerminate:= True;
  inherited  Create(True);
end;

destructor TUpdateUserDayMakeNumThread.Destroy;
begin
  FQuery.Free;
end;

procedure TUpdateUserDayMakeNumThread.Execute;
var
  sSocketMsg: string;
begin
try
  //EnterCriticalSection(MyCs); //进入临界区
  try
  with FQuery do begin
       Close;
       SQL.Clear;
       SQL.Add('EXEC UpdateMakeNum :a1,:a2');
       parameters.ParamByName('a1').DataType :=Ftstring;
       parameters.ParamByName('a1').Value := Trim(sLoginID);
       parameters.ParamByName('a2').DataType :=Ftinteger;
       parameters.ParamByName('a2').Value := g_btMaxDayMakeNum;
       open;
       DefMsg.Recog := FieldByName('Num').AsInteger;
       Close;
       sSocketMsg := EncodeMessage(DefMsg) + SQLText;
       FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, sSocketMsg);
     (*nCode:= 0;
     //FrmMain.MaxNum:=0;
     Close;
     SQL.Clear;
     SQL.Add('SELECT DayMakeNum FROM UserInfo where [User]=:a2');
     parameters.ParamByName('a2').DataType :=Ftstring;
     parameters.ParamByName('a2').Value := Trim(SQLText);
     nCode:= 1;
     Open;
     if RecordCount > 0 then begin
       nCode:= 2;
       {FrmMain.}MaxNum:= FieldByName('DayMakeNum').AsInteger;
       IF {FrmMain.}MaxNum < g_btMaxDayMakeNum then begin
          Close;
          SQL.Clear;
          SQL.Add('Update UserInfo set dayMakeNum=:a1 Where [User]=:a2');
          Inc({FrmMain.}MaxNum);
          parameters.ParamByName('a1').DataType:=FtInteger;
          parameters.ParamByName('a1').Value := {FrmMain.}MaxNum;
          parameters.ParamByName('a2').DataType :=Ftstring;
          parameters.ParamByName('a2').Value := Trim(SQLText);
          nCode:= 3;
          ExecSQL;
          Close;
       end;
     end;  *)
  end;
  finally
    //LeaveCriticalSection(MyCs); //离开临界区
    FrmDm.ADOconn2.Close;
  end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('TUpdateUserDayMakeNumThread.Execute');
      FrmMain.MainOutMessage(E.Message);
    end;
  end;
end;

end.

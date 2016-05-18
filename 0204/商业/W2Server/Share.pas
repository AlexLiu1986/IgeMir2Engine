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
    sUserIPaddr: string; //�û�IP
    sSockIndex: string;  //ͨѶ��ʵ
    sReceiveMsg: string;//���յ���Ϣ
    dwClientTick: LongWord;
    dwKickTick: LongWord;
    boKick: Boolean;
    sAccount: string;
    sPassWord: string;
    boLogined: Boolean; //�Ƿ��Ѿ���½
  end;
  pTM2UserInfo = ^TM2UserInfo;
const
  USERMAXSESSION = 1000; //�û����������
  sPrice = 200; //����ע���½���۸�
var
  g_boCanStart: Boolean;
  g_dwServerStartTick: LongWord;
  g_Config: pTConfig;
  UserSessionCount: Integer; //0x32C �û����ӻỰ��
  g_btMaxDayMakeNum: Integer = 10; //ÿ��������ɴ���
  MakeSockeMsgList: TStringList; //����������������Ϣ�б�
  sProcMsg: string;
  boGateReady: Boolean = False;//�Ƿ������ɷ���������
  boServiceStart: Boolean = False;//�����Ƿ�����
  g_dwStartTick: LongWord; //�������
function CheckUserExist (str, sAccount: string): Boolean;
function MaxCurr(Val1, Val2: Currency): Currency;
function CheckMaXID(Ado: TADOQuery; str: string): Integer;
function UserLogined(sLoginID: string; GateInfo: pTLoginGateInfo): Boolean;
//procedure CheckUserTime(UserName: string);
//procedure MainOutMessage(sMsg: string);

procedure AddUserTips(DLUserName,UserName,ZT: string; Yue: Currency);//������־
implementation
uses DM;
//����û��Ƿ����
//strΪ����
//����ֵ True Ϊ��������û�
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

//ȡ����ID��,
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
{//�Ƚϵ�½ʱ��,��Ϊ��ǰ����,���ÿ�����ɴ�����ʼ
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

//������־
//ZT 1-�޸Ĵ�������� 2-�û����ɳ��� 3-ע���û� 4-ע����� 5-�û��޸����� 6-�����޸�����
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

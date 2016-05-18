unit Globals;

interface
uses Windows, SysUtils, ADODB, DB, DBGridEh;

function CheckUserExist (str, sAccount: string): Boolean;
function CheckMaXID(str: string): Integer;//取表中ID号,
procedure AddUserTips(DLUserName,UserName,ZT: string; Yue: Currency);//增加日志
procedure MakeDBGridColumnsAutoFixItsWidth(objDBGrid:TDBGridEH);//使dbGrid的内容自动适应他的宽度
implementation

uses LoginFrm;

//检测用户是否存在
//str为表名
//返回值 True 为存在这个用户
function CheckUserExist (str, sAccount: string): Boolean;
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := LoginForm.ADOConn;
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('Select * from '+str+' where [User] =:a0');
       Parameters.ParamByName('a0').DataType:=Ftstring;
       Parameters.ParamByName('a0').Value :=Trim(sAccount);
       Open;
       if RecordCount <> 0 then Result := True
       else Result := False;
    end;
  finally
    Ado.Free;
  end;
end;

//取表中ID号,
function CheckMaXID(str: string): Integer;
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := LoginForm.ADOconn;
  try
    with Ado do begin
       Close;
       SQL.Clear;
       SQL.Add('Select Max(ID) from '+str);
       Open;
       IF Ado.Fields[0].AsInteger=0 then Result := 1
       Else Result:=Ado.Fields[0].AsInteger+1;
    end;
  finally
    Ado.Free;
  end;
end;

//增加日志
//ZT 1-修改代理人余额 2-用户生成程序 3-注册用户 4-注册代理 5-用户修改密码 6-代理修改密码
procedure AddUserTips(DLUserName,UserName,ZT: string; Yue: Currency);
var
  Ado: TADOQuery;
begin
  Ado := TADOQuery.Create(nil);
  Ado.Connection := LoginForm.ADOconn;
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
  end;
end;

//使dbGrid的内容自动适应他的宽度{如为DBGridEh则将改为：(objDBGrid:TDBGridEh);}
procedure MakeDBGridColumnsAutoFixItsWidth(objDBGrid:TDBGridEH);
var
  cc:integer;
  i,tmpLength:integer;
  objDataSet:TDataSet;
  aDgCLength:array of integer;
begin
  cc:=objDbGrid.Columns.Count-1;
  objDataSet:=objDbGrid.DataSource.DataSet;
  setlength(aDgCLength,cc+2);
  //取标题字段的长度
  for i:=0 to  cc do
  begin
    aDgCLength[i]:= length(objDbGrid.Columns[i].Title.Caption);
  end;

  objDataSet.First;
  while not objDataSet.Eof do
  begin
    //取列中每个字段的长度
    for i:=0 to  cc do
    begin
      tmpLength:=length(objDataSet.Fields.Fields[i].AsString);
      if tmpLength>aDgCLength[i]
      then aDgCLength[i]:=tmpLength;
    end;
    objDataSet.Next;
  end;

  for i:=0 to  cc do
  begin
    objDbGrid.Columns[i].Width:=aDgCLength[i]*8;
  end;
end;
end.

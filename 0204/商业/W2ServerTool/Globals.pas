unit Globals;

interface
uses Windows, SysUtils, ADODB, DB, DBGridEh;

function CheckUserExist (str, sAccount: string): Boolean;
function CheckMaXID(str: string): Integer;//ȡ����ID��,
procedure AddUserTips(DLUserName,UserName,ZT: string; Yue: Currency);//������־
procedure MakeDBGridColumnsAutoFixItsWidth(objDBGrid:TDBGridEH);//ʹdbGrid�������Զ���Ӧ���Ŀ��
implementation

uses LoginFrm;

//����û��Ƿ����
//strΪ����
//����ֵ True Ϊ��������û�
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

//ȡ����ID��,
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

//������־
//ZT 1-�޸Ĵ�������� 2-�û����ɳ��� 3-ע���û� 4-ע����� 5-�û��޸����� 6-�����޸�����
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

//ʹdbGrid�������Զ���Ӧ���Ŀ��{��ΪDBGridEh�򽫸�Ϊ��(objDBGrid:TDBGridEh);}
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
  //ȡ�����ֶεĳ���
  for i:=0 to  cc do
  begin
    aDgCLength[i]:= length(objDbGrid.Columns[i].Title.Caption);
  end;

  objDataSet.First;
  while not objDataSet.Eof do
  begin
    //ȡ����ÿ���ֶεĳ���
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

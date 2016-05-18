unit LogFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGridEh, DB, ADODB;

type
  TLogForm = class(TForm)
    Label1: TLabel;
    dt1: TDateTimePicker;
    Label2: TLabel;
    dt2: TDateTimePicker;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Button1: TButton;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogForm: TLogForm;

implementation

uses LoginFrm, Globals;

{$R *.dfm}
procedure AutoCount(ADOQuery:TADOquery;DBGridEH:TDBGridEH);
var I:integer;
begin
 DBGridEH.FooterRowCount:=1;
  For I:=0 to ADOQuery.FieldCount-1 do Begin
     IF I=0 then Begin
       DBGridEh.Columns[i].Footer.Value :='合计：' ;
       DBGridEh.Columns[i].Footer.ValueType :=fvtStaticText ;
     end;
     IF I=1 then Begin
      DBGridEh.Columns[i].Footer.ValueType :=fvtCount ;
     end;
     Case ADOQuery.Fields[i].DataType of
         ftUnknown, ftString,ftWord, ftBoolean, ftDate, ftTime,
         ftDateTime,ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle,
         ftDBaseOle, ftCursor, ftFixedChar,ftWideString, ftADT, ftArray,
         ftReference, ftOraBlob, ftOraClob, ftVariant, ftInterface,
         ftIDispatch, ftGuid, ftTimeStamp, ftFMTBcd: DBGridEh.Columns[i].Width :=185  ;
         Else Begin
          DBGridEh.Columns[i].Width :=120;
          DBGridEh.Columns[i].Footer.FieldName :=ADOQuery.Fields[i].FieldName ;
          DBGridEh.Columns[i].Footer.ValueType :=fvtSum ;
         end;
      end;
  end;
end;

procedure TLogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DBGridEh1.SumList.Active := False;
  Action := caFree;
end;

procedure TLogForm.FormDestroy(Sender: TObject);
begin
  LogForm:=nil;
end;

procedure TLogForm.Button1Click(Sender: TObject);
var
  StrSql, Zt:string;
begin
  StrSql:='';
  Zt:='';
  case ComboBox1.ItemIndex of
    0:begin//注册代理
      Zt:='4';
      StrSql:='select ID as '''+'编 号 '+''',cast(DLUserName as char(20)) '''+'代理人'+''',cast(userName as char(20)) '''+'注册人'+''',Yue '''+'注册金额 '+''',inputdate '''+'注册日期'+''' from tips where '+
              'DateDiff(DD,InputDate,:a1)<=0 and DateDiff(DD,InputDate,:a2)>=0 and status=:a3 order by ID';
    end;
    1:begin//代理充值
      Zt:='1';
      StrSql:='select ID as '''+'编 号 '+''',cast(DLUserName as char(20)) '''+'代理人'+''',cast(userName as char(20)) '''+'充值类型 '+''',Yue '''+'充值金额 '+''',inputdate '''+'充值日期'+''' from tips where '+
              'DateDiff(DD,InputDate,:a1)<=0 and DateDiff(DD,InputDate,:a2)>=0 and status=:a3 order by ID';
    end;
    2:begin//注册用户
      Zt:='3';
      StrSql:='select a.ID as '''+'编 号 '+''',cast(a.DLUserName as char(20)) '''+'代理人'+''',b.Name '''+'代理人姓名'+''','+
              ' cast(a.userName as char(20)) '''+'注册用户'+''',a.Yue '''+'注册金额 '+''',a.inputdate '''+'注册日期'+''' from tips a'+
              ' inner join DlUserInfo b on a.DLuserName=b.[user] where '+
              ' DateDiff(DD,InputDate,:a1)<=0 and DateDiff(DD,InputDate,:a2)>=0 and status=:a3 order by a.ID';
    end;
  end;
  if StrSql <> '' then begin
    With LoginForm.ADOTemp do Begin
      DataSource1.DataSet:= LoginForm.ADOTemp;
      Close;
      SQL.Clear;
      SQL.Add(StrSql);
      Parameters.ParamByName('a1').DataType :=FtDateTime;
      Parameters.ParamByName('a1').Value :=Dt1.Date;
      Parameters.ParamByName('a2').DataType :=FtDateTime;
      Parameters.ParamByName('a2').Value :=Dt2.date;
      Parameters.ParamByName('a3').DataType :=FtString;
      Parameters.ParamByName('a3').Value :=ZT;
      open;
      AutoCount(LoginForm.ADOTemp, DBGridEh1);
      MakeDBGridColumnsAutoFixItsWidth(DBGridEh1);
    end;
  end;
end;

procedure TLogForm.FormShow(Sender: TObject);
begin
  Dt2.DateTime := Now;
end;

end.

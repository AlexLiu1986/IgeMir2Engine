unit ModiUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBGridEh, DB, ADODB, ExtCtrls,
  ComCtrls, Buttons;

type
  TModiUserFrm = class(TForm)
    GroupBox4: TGroupBox;
    DBGridEh1: TDBGridEh;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit2: TEdit;
    Edit4: TEdit;
    Edit3: TEdit;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Edit5: TEdit;
    Label3: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
  private
    procedure Select;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModiUserFrm: TModiUserFrm;

implementation
uses LoginFrm, Globals;
{$R *.dfm}

procedure TModiUserFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TModiUserFrm.FormDestroy(Sender: TObject);
begin
  ModiUserFrm:=nil;
end;

procedure TModiUserFrm.Select;
begin
with ADOQuery1 do
begin
  Close;
  sql.clear;
  sql.add('select ID,[User],Name,YuE from DLUserInfo');
  open;
end;
end;

procedure TModiUserFrm.FormShow(Sender: TObject);
begin
  Select;
end;

procedure TModiUserFrm.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TModiUserFrm.DBGridEh1CellClick(Column: TColumnEh);
begin
  IF ADOQuery1.RecordCount > 0 then Begin
    Edit1.Text:=ADOQuery1.FieldByName('ID').AsString;
    Edit2.Text:=ADOQuery1.FieldByName('User').AsString;
    Edit3.Text:=ADOQuery1.FieldByName('Name').AsString;
    Edit4.Text:=IntToStr(ADOQuery1.FieldByName('YuE').AsInteger);
  end;
end;

procedure TModiUserFrm.BitBtn1Click(Sender: TObject);
begin
  if (Edit2.Text <> '') and (Edit1.Text <> '') or (Edit4.Text <> '') then begin
    try
      with LoginForm.ADOTemp do begin
        Close;
        SQL.Clear;
        SQL.Add('Update DLUserInfo set YuE=:a1 Where [User]=:a2 and ID=:a3') ;
        parameters.ParamByName('a1').DataType:=FtCurrency;
        parameters.ParamByName('a1').Value := strtocurr(Edit4.text)+strtocurr(Edit5.text);
        parameters.ParamByName('a2').DataType :=Ftstring;
        parameters.ParamByName('a2').Value := Trim(Edit2.Text);
        parameters.ParamByName('a3').DataType :=Ftstring;
        parameters.ParamByName('a3').Value := Trim(Edit1.Text);
        ExecSQL;
        Application.MessageBox('修改记录成功', '提示信息', mb_ok + MB_ICONINFORMATION);
        Select;
        if RadioButton1.Checked then
          AddUserTips(Trim(Edit2.Text),'正常充值','1', strtocurr(Edit5.text))//添加日志
        else if RadioButton2.Checked then AddUserTips(Trim(Edit2.Text),'奖励充值','1', strtocurr(Edit5.text));//添加日志
        Edit1.Text:='';
        Edit2.Text:='';
        Edit3.Text:='';
        Edit4.Text:='';
      end;  
      except
        Application.MessageBox('修改记录失败！', '提示信息', MB_OK + MB_ICONWARNING);
      end;
  end else begin
    Application.MessageBox('先选择记录！', '提示信息', MB_OK + MB_ICONWARNING);
  end;
end;

procedure TModiUserFrm.Edit5KeyPress(Sender: TObject; var Key: Char);
var
  i :Integer;
begin
  if not (Key in ['0'..'9',#8,#13,#46]) then
  begin
    key := #0;
    Abort;
  end;
  i := Pos('.',TEdit(Sender).Text);
  if i > 0 then
  begin
    if key = '.' then key := #0;
    if (Length(Copy(TEdit(Sender).Text,i,Length(TEdit(Sender).Text)-i))>=2)
    and not (Key in [#8,#13,#46]) then
       Key := #0;
  end; 

end;

end.

unit Rpt_ScriptFrm;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,ADODB,DB;

type
  TRpt_ScriptForm = class(TQuickRep)
    DetailBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText1: TQRDBText;
    SummaryBand1: TQRBand;
    QRLabel10: TQRLabel;
    QRExpr3: TQRExpr;
    QRShape1: TQRShape;
    TitleBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel8: TQRLabel;
    procedure QuickRepPreview(Sender: TObject);
    procedure showInfo(dt1, dt2: TDateTime);
  private

  public

  end;

var
  Rpt_ScriptForm: TRpt_ScriptForm;

implementation
uses previewt,LoginFrm, Rpt_DZSFrm;

{$R *.DFM}
procedure TRpt_ScriptForm.showInfo(dt1, dt2: TDateTime);
begin
  With LoginForm.ADOTemp do Begin
    Close;
    SQL.Clear ;
    SQL.Add('select ID,MachineCode,RegDate,Price,Notice from MakeScriptInfo where ');
    SQL.Add(' DateDiff(DD,RegDate,:a1)<=0 and DateDiff(DD,RegDate,:a2)>=0 ');
    SQL.Add(' order by ID');
    Parameters.ParamByName('a1').DataType :=FtDateTime;
    Parameters.ParamByName('a1').Value :=Dt1;
    Parameters.ParamByName('a2').DataType :=FtDateTime;
    Parameters.ParamByName('a2').Value :=Dt2;
    open;
  end;
  QRLabel1.Caption :='IGE科技脚本插件注册机销售明细表 ';
  QRLabel2.Caption :='统计日期：'+FormatDateTime('YYYY"年"MM"月"DD"日"',dt1)
                   +' 至 '+FormatDateTime('YYYY"年"MM"月"DD"日"',dt2);
  QRLabel8.Caption := '共 '+inttostr(LoginForm.ADOTemp.RecordCount)+' 条记录';
  Rpt_ScriptForm.Preview ;
end;

procedure TRpt_ScriptForm.QuickRepPreview(Sender: TObject);
begin
  application.CreateForm(Tprev,prev);
  prev.QRPreview.QRPrinter:=Rpt_ScriptForm.QRPrinter;
  prev.Show;
end;

end.

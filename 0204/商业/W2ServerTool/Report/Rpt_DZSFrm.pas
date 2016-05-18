unit Rpt_DZSFrm;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,ADODB,DB;

type
  TRpt_DZSForm = class(TQuickRep)
    DetailBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    BandG: TQRGroup;
    SummaryBand1: TQRBand;
    QRLabel10: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    TitleBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape1: TQRShape;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    procedure showInfo(dt1, dt2: TDateTime);
    procedure QuickRepPreview(Sender: TObject);
  private

  public

  end;

var
  Rpt_DZSForm: TRpt_DZSForm;

implementation
uses previewt,LoginFrm;
{$R *.DFM}

{ TRpt_DZSForm }

procedure TRpt_DZSForm.showInfo(dt1, dt2: TDateTime);
begin
  With LoginForm.ADOTemp do Begin
    Close;
    SQL.Clear ;
    //SQL.Add('select DLUserName,Count(*) SL,Sum(Yue) as Yue from Tips where ');
    //SQL.Add(' DateDiff(DD,InputDate,:a1)<=0 and DateDiff(DD,InputDate,:a2)>=0 and Status=:a3 ');
    //SQL.Add(' Group by  DLUserName');
    SQL.Add('EXEC Q_SUM :a1,:a2,:a3');
    Parameters.ParamByName('a1').DataType :=FtDateTime;
    Parameters.ParamByName('a1').Value :=Dt1;
    Parameters.ParamByName('a2').DataType :=FtDateTime;
    Parameters.ParamByName('a2').Value :=Dt2;
    Parameters.ParamByName('a3').DataType :=FtString;
    Parameters.ParamByName('a3').Value :='3';
    open;
  end;
  QRLabel1.Caption :='IGE科技登陆器销售汇总表 ';
  QRLabel2.Caption :='统计日期：'+FormatDateTime('YYYY"年"MM"月"DD"日"',dt1)
                   +' 至 '+FormatDateTime('YYYY"年"MM"月"DD"日"',dt2); 
  Rpt_DZSForm.Preview ;
end;

procedure TRpt_DZSForm.QuickRepPreview(Sender: TObject);
begin
  application.CreateForm(Tprev,prev);
  prev.QRPreview.QRPrinter:=Rpt_DZSForm.QRPrinter;
  prev.Show;
end;

end.

unit SXSum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TSXSumFrm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    nCode:Byte;
    { Public declarations }
  end;

var
  SXSumFrm: TSXSumFrm;

implementation

uses Rpt_DZSFrm, previewt, Rpt_ScriptFrm;

{$R *.dfm}

procedure TSXSumFrm.FormShow(Sender: TObject);
begin
  Dt2.DateTime := Now;
end;

procedure TSXSumFrm.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TSXSumFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=Cafree;
end;

procedure TSXSumFrm.BitBtn1Click(Sender: TObject);
begin
 case nCode of
   1:begin//登陆器报表
     Rpt_DZSForm:=TRpt_DZSForm.Create(self);
     Try
       Rpt_DZSForm.showInfo(dt1.DateTime,dt2.DateTime);
       prev.release;
     Finally
       Rpt_DZSForm.Free ;
     end;
     SXSumFrm.Close;
   end;//1
   2:begin//脚本插件报表
     Rpt_ScriptForm:=TRpt_ScriptForm.Create(self);
     Try
       Rpt_ScriptForm.showInfo(dt1.DateTime,dt2.DateTime);
       prev.release;
     Finally
       Rpt_ScriptForm.Free ;
     end;
     SXSumFrm.Close;
   end;//2
 end;//case
end;

end.

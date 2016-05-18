unit previewt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Quickrpt, ExtCtrls, qrprntr;

type
  Tprev = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    lbpageno: TLabel;
    lbpagecount: TLabel;
    QRPreview: TQRPreview;
    SpeedButton8: TSpeedButton;
    procedure QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  prev: Tprev;
  zoomi:integer;
implementation


{$R *.DFM}

procedure Tprev.QRPreviewPageAvailable(Sender: TObject;
  PageNum: Integer);
begin
lbpagecount.caption:='共'+inttostr(qrpreview.qrprinter.pagecount)+'页';
lbpageno.caption:='第'+inttostr(qrpreview.pagenumber)+'页';
qrpreview.zoom:=80;
end;

procedure Tprev.SpeedButton1Click(Sender: TObject);
begin
qrpreview.zoomtofit;
end;

procedure Tprev.SpeedButton2Click(Sender: TObject);
begin
qrpreview.zoom:=100;
end;

procedure Tprev.SpeedButton3Click(Sender: TObject);
begin
qrpreview.zoomtowidth;
end;

procedure Tprev.SpeedButton4Click(Sender: TObject);
begin
qrpreview.pagenumber:=1;
end;

procedure Tprev.SpeedButton5Click(Sender: TObject);
begin
if qrpreview.pagenumber>1 then
begin
qrpreview.pagenumber:=qrpreview.pagenumber-1;
lbpageno.caption:='第'+inttostr(qrpreview.pagenumber)+'页';
end;
end;

procedure Tprev.SpeedButton6Click(Sender: TObject);
begin
if qrpreview.pagenumber<qrpreview.qrprinter.pagecount then
begin
qrpreview.pagenumber:=qrpreview.pagenumber+1;
lbpageno.caption:='第'+inttostr(qrpreview.pagenumber)+'页';
end;

end;

procedure Tprev.SpeedButton7Click(Sender: TObject);
begin
 qrpreview.pagenumber:=qrpreview.qrprinter.pagecount;
 lbpageno.caption:='第'+inttostr(qrpreview.qrprinter.pagecount)+'页';
end;

procedure Tprev.SpeedButton8Click(Sender: TObject);
begin
{if opendialog1.Execute then
qrpreview.qrprinter.load(opendialog1.filename);}

   Close;
end;

procedure Tprev.SpeedButton9Click(Sender: TObject);
begin
if savedialog1.Execute then
qrpreview.qrprinter.save(savedialog1.filename);
end;

procedure Tprev.SpeedButton10Click(Sender: TObject);
begin
qrpreview.qrprinter.printsetup;
end;

procedure Tprev.SpeedButton11Click(Sender: TObject);
begin
qrpreview.qrprinter.print;
IF MessageBox(handle,'打印完毕，退出吗?',pchar(caption),mb_iconinformation+mb_YesNo)=mrYes then
close;
end;

procedure Tprev.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   prev.QRPreview.QRPrinter:=nil;
end;

procedure Tprev.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then
     close;
end;

procedure Tprev.FormCreate(Sender: TObject);
begin   
 zoomi:=100;
end;

procedure Tprev.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=vk_add then
begin
zoomi:=zoomi+10;
qrpreview.zoom:=zoomi;
end;
if key=vk_subtract then
begin
zoomi:=zoomi-10;
qrpreview.zoom:=zoomi;
end;
end;

end.

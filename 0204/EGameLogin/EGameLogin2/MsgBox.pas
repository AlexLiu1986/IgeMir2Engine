unit MsgBox;

interface

uses
  Windows, Messages, Classes, Controls, Forms,
  ExtCtrls, RzBmpBtn, RzLabel, Common, StdCtrls, jpeg;

type
  TFrmMessageBox = class(TForm)
    mainImage: TImage;
    BtnOK: TRzBmpButton;
    BtnCancel: TRzBmpButton;
    LabelHintMsg: TRzLabel;
    procedure mainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMessageBox: TFrmMessageBox;

implementation

uses Main;

{$R *.dfm}

procedure TFrmMessageBox.mainImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then ReleaseCapture;
  Perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmMessageBox.BtnOKClick(Sender: TObject);
begin
  if g_boIsGamePath then begin
    FrmMain.Timer2.Enabled:=True; //有升级文件，下载按钮可操作
    FrmMain.ComboBox1.Enabled := False;
  end;
  Close;
end;

procedure TFrmMessageBox.BtnCancelClick(Sender: TObject);
begin
  if g_boIsGamePath then begin
    FrmMain.RzLabelStatus.Caption:='请选择服务器登陆...';
    g_boIsGamePath := False;
    FrmMain.ComboBox1.Enabled := True;
  end;
  Close;
end;

end.

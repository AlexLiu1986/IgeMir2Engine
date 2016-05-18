unit Browser;

interface

uses
  Windows, Messages, Classes, Controls, Forms,
  OleCtrls, SHDocVw, StdCtrls, Buttons, ExtCtrls, AppEvnts, Share;

type
  TfrmBrowser = class(TForm)
    NavPanel: TPanel;
    SpeedButton1: TSpeedButton;
    lblProgress: TLabel;
    WebBrowser1: TWebBrowser;
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure WebBrowser1NewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    procedure Open(Web:string);
  end;

var
  frmBrowser: TfrmBrowser;

implementation

uses ClMain;

{$R *.dfm}

procedure TfrmBrowser.FormCreate(Sender: TObject);
begin
//ParentWindow := FrmMain.Handle;
Windows.SetParent(Handle, FrmMain.Handle);
Self.Height := SCREENHEIGHT;
Self.Width := SCREENWIDTH;
end;

procedure TfrmBrowser.Open(Web:string);
begin
  Self.Top := 0;//FrmMain.Top;
  Self.Left := 0;//FrmMain.Left;
  WebBrowser1.Navigate(Web);
  Self.Show;
end;
procedure TfrmBrowser.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmBrowser.WebBrowser1NewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
var
  NewApp: TfrmBrowser;
begin
  NewApp := TfrmBrowser.Create(Self);
  NewApp.ParentWindow := FrmBrowser.Handle;
  NewApp.Show;
  NewApp.SetFocus;
  ppDisp := NewApp.webbrowser1.Application;

end;

procedure TfrmBrowser.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if (Msg.message = wm_rbuttondown) or (Msg.message = wm_rbuttonup) or
      (msg.message = WM_RBUTTONDBLCLK)   then
  begin
      if IsChild(Webbrowser1.Handle, Msg.hwnd) then
        Handled := true;//如果有其他需要处理的，在这里加上你要处理的代码
  end;
end;
end.

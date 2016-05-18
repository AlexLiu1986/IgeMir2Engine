unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, SUIPopupMenu, CoolTrayIcon, ExtCtrls, jpeg;

type
  TForm1 = class(TForm)
    CoolTrayIcon1: TCoolTrayIcon;
    Timer1: TTimer;
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    procedure HotKeyDown(var Msg:Tmessage);message WM_HOTKEY;
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
  HotKeyid,HotKeyid1,HotKeyid2:Integer;
  pHwnd:Hwnd;
  style,exstyle:longint;
  devmode1:DEVMODE;
  bool:boolean;
implementation
uses Unit2;
{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);

begin
  bool:=false;
  form1.Hide;
  //GlobalAddAtom函数得到唯一标识
  HotKeyid2:=GlobalAddAtom('MyHotKey')-$C00;
  HotKeyid:=GlobalAddAtom('MyHotKey1')-$C00;
  //HotKeyId的合法取之范围是0x0000到0xBFFF之间， GlobalAddAtom函数得到的值
  //在0xC000到0xFFFF之间，所以减掉0xC000来满足调用要求。
  RegisterHotKey(Handle,HotKeyid,0,VK_F11);
  RegisterHotKey(Handle,HotKeyid1,0,VK_F9);
  //热键的辅助按键包括Mod_Ctrl 、Mod_Alt、Mod_Shift,对于Windows兼容键盘还支持Windows
  //键，即其键面上有Windows标志的那个键，其值为Mod_win。
  //上面 的代码注册了一个热键：ALT+F8。当然如果你希望象TAKEIT那样，只用F8, 就这么写：
  //RegisterHotKey(Handle, hotkeyid, 0, VK_F8);

end;
//按下定义的全局热键所响应的代码
procedure TForm1.HotKeyDown(var Msg:Tmessage);
begin
  if (Msg.LParamLo=0) and (Msg.LParamHi=VK_F11) then
  begin
     pHwnd:=GetForegroundWindow(); //得到在屏幕上最前端的窗口的句柄；也可以用其他API函数指定某个特定窗口
     //以下是把定义把屏幕变更为1024*768，32位色彩，刷新率为75赫兹
     if EnumDisplaySettings(0,0,devmode1) then
   begin
     devmode1.dmPelsWidth:=1024;
	   devmode1.dmPelsHeight:=768;
     devmode1.dmBitsPerPel:=32;
	   devmode1.dmDisplayFrequency:=75;
	 	 ChangeDisplaySettings(devmode1,0);
  end;
  //得到窗口原来的属性
  style:=GetWindowLong(pHwnd,GWL_STYLE);
  //定义新属性
  style:=WS_OVERLAPPEDWINDOW or WS_VISIBLE ;
  //更改窗口属性
  SetWindowLong(pHwnd,GWL_STYLE,style);
  //得到窗口扩展属性
  exstyle:=GetWindowLong(pHwnd,GWL_EXSTYLE);
  //定义新扩展属性
	exstyle:=WS_EX_APPWINDOW or WS_EX_WINDOWEDGE;
  //更改窗口扩展属性
	SetWindowLong(pHwnd,GWL_EXSTYLE,exstyle);
  //更改的屏幕以屏幕的0，0为坐标，大小为800*600
  SetWindowPos(pHwnd,HWND_NOTOPMOST,0,0,800,600,SWP_SHOWWINDOW);
   ShowWindow(pHwnd,SW_SHOWNORMAL);
  end;

if (Msg.LParamLo=0) and (Msg.LParamHi=VK_F9) then
    if bool=false then
      begin
       ShowWindow(pHwnd,SW_HIDE); //隐藏窗口
       bool:=true;
      end
     else
       begin
     //if (Msg.LParamLo=0) or (Msg.LParamHi=VK_F9) then
       ShowWindow(pHwnd,SW_RESTORE); //恢复窗口
       bool:=false;
      end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    UnRegisterHotKey(handle,HotKeyid);  //注销热键
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  UnRegisterHotKey(handle,HotKeyid);
  form1.Close;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  form2.show;
end;

end.

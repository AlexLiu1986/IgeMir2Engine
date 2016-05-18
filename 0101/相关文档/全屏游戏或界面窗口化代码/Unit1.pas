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
  //GlobalAddAtom�����õ�Ψһ��ʶ
  HotKeyid2:=GlobalAddAtom('MyHotKey')-$C00;
  HotKeyid:=GlobalAddAtom('MyHotKey1')-$C00;
  //HotKeyId�ĺϷ�ȡ֮��Χ��0x0000��0xBFFF֮�䣬 GlobalAddAtom�����õ���ֵ
  //��0xC000��0xFFFF֮�䣬���Լ���0xC000���������Ҫ��
  RegisterHotKey(Handle,HotKeyid,0,VK_F11);
  RegisterHotKey(Handle,HotKeyid1,0,VK_F9);
  //�ȼ��ĸ�����������Mod_Ctrl ��Mod_Alt��Mod_Shift,����Windows���ݼ��̻�֧��Windows
  //���������������Windows��־���Ǹ�������ֵΪMod_win��
  //���� �Ĵ���ע����һ���ȼ���ALT+F8����Ȼ�����ϣ����TAKEIT������ֻ��F8, ����ôд��
  //RegisterHotKey(Handle, hotkeyid, 0, VK_F8);

end;
//���¶����ȫ���ȼ�����Ӧ�Ĵ���
procedure TForm1.HotKeyDown(var Msg:Tmessage);
begin
  if (Msg.LParamLo=0) and (Msg.LParamHi=VK_F11) then
  begin
     pHwnd:=GetForegroundWindow(); //�õ�����Ļ����ǰ�˵Ĵ��ڵľ����Ҳ����������API����ָ��ĳ���ض�����
     //�����ǰѶ������Ļ���Ϊ1024*768��32λɫ�ʣ�ˢ����Ϊ75����
     if EnumDisplaySettings(0,0,devmode1) then
   begin
     devmode1.dmPelsWidth:=1024;
	   devmode1.dmPelsHeight:=768;
     devmode1.dmBitsPerPel:=32;
	   devmode1.dmDisplayFrequency:=75;
	 	 ChangeDisplaySettings(devmode1,0);
  end;
  //�õ�����ԭ��������
  style:=GetWindowLong(pHwnd,GWL_STYLE);
  //����������
  style:=WS_OVERLAPPEDWINDOW or WS_VISIBLE ;
  //���Ĵ�������
  SetWindowLong(pHwnd,GWL_STYLE,style);
  //�õ�������չ����
  exstyle:=GetWindowLong(pHwnd,GWL_EXSTYLE);
  //��������չ����
	exstyle:=WS_EX_APPWINDOW or WS_EX_WINDOWEDGE;
  //���Ĵ�����չ����
	SetWindowLong(pHwnd,GWL_EXSTYLE,exstyle);
  //���ĵ���Ļ����Ļ��0��0Ϊ���꣬��СΪ800*600
  SetWindowPos(pHwnd,HWND_NOTOPMOST,0,0,800,600,SWP_SHOWWINDOW);
   ShowWindow(pHwnd,SW_SHOWNORMAL);
  end;

if (Msg.LParamLo=0) and (Msg.LParamHi=VK_F9) then
    if bool=false then
      begin
       ShowWindow(pHwnd,SW_HIDE); //���ش���
       bool:=true;
      end
     else
       begin
     //if (Msg.LParamLo=0) or (Msg.LParamHi=VK_F9) then
       ShowWindow(pHwnd,SW_RESTORE); //�ָ�����
       bool:=false;
      end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    UnRegisterHotKey(handle,HotKeyid);  //ע���ȼ�
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

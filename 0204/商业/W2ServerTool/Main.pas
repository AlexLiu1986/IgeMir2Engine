unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, jpeg, ExtCtrls, Menus;

type
  TMainFrm = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    imgBackground: TImage;
    StatusBar1: TStatusBar;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainFrm: TMainFrm;

implementation
uses AddUser, LogFrm, ModiUser, SXSum, sMain;
{$R *.dfm}

procedure TMainFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.Terminate;  //÷’÷π≥Ã–Ú
end;

procedure TMainFrm.FormDestroy(Sender: TObject);
begin
  MainFrm  :=nil;
  application.Terminate ;
end;

procedure TMainFrm.N2Click(Sender: TObject);
begin
  FrmAddUser:= TFrmAddUser.Create(Application);
  FrmAddUser.ShowModal;
  FrmAddUser.FREE;
end;

procedure TMainFrm.N3Click(Sender: TObject);
begin
  LogForm:= TLogForm.Create(Application);
  LogForm.ShowModal;
  LogForm.FREE;
end;

procedure TMainFrm.N4Click(Sender: TObject);
begin
  ModiUserFrm:= TModiUserFrm.Create(Application);
  ModiUserFrm.ShowModal;
  ModiUserFrm.FREE;
end;

procedure TMainFrm.N7Click(Sender: TObject);
begin
  SXSumFrm := TSXSumFrm.Create(Application);
  SXSumFrm.nCode:= 1;
  SXSumFrm.ShowModal;
  SXSumFrm.Free;
end;

procedure TMainFrm.N9Click(Sender: TObject);
begin
  FrmMakeKey := TFrmMakeKey.Create(Application);
  FrmMakeKey.ShowModal;
  FrmMakeKey.Free;
end;

procedure TMainFrm.N10Click(Sender: TObject);
begin
  SXSumFrm := TSXSumFrm.Create(Application);
  SXSumFrm.nCode:= 2;
  SXSumFrm.ShowModal;
  SXSumFrm.Free;
end;

end.

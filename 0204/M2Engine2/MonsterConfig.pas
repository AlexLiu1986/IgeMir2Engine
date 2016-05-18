unit MonsterConfig;

interface

uses
  Classes, Controls, Forms, ComCtrls, StdCtrls, Spin;

type
  TfrmMonsterConfig = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox8: TGroupBox;
    Label23: TLabel;
    EditMonOneDropGoldCount: TSpinEdit;
    ButtonGeneralSave: TButton;
    CheckBoxDropGoldToPlayBag: TCheckBox;
    PageControl2: TPageControl;
    procedure ButtonGeneralSaveClick(Sender: TObject);
    procedure EditMonOneDropGoldCountChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxDropGoldToPlayBagClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefGeneralInfo();
    { Private declarations }
  public
    procedure Open;
    { Public declarations }
  end;

var
  frmMonsterConfig: TfrmMonsterConfig;

implementation

uses M2Share;

{$R *.dfm}

{ TfrmMonsterConfig }

procedure TfrmMonsterConfig.ModValue;
begin
  boModValued := True;
  ButtonGeneralSave.Enabled := True;
end;

procedure TfrmMonsterConfig.uModValue;
begin
  boModValued := False;
  ButtonGeneralSave.Enabled := False;
end;

procedure TfrmMonsterConfig.FormCreate(Sender: TObject);
begin
{$IF SoftVersion = VERDEMO}
  Caption := '��Ϸ����[��ʾ�汾���������õ�����Ч�������ܱ���]'
{$IFEND}
end;

procedure TfrmMonsterConfig.Open;
begin
  boOpened := False;
  uModValue();
  RefGeneralInfo();
  boOpened := True;
  PageControl1.ActivePageIndex := 0;
  ShowModal;
end;

procedure TfrmMonsterConfig.RefGeneralInfo;
begin
  EditMonOneDropGoldCount.Value := g_Config.nMonOneDropGoldCount;
  CheckBoxDropGoldToPlayBag.Checked := g_Config.boDropGoldToPlayBag;
end;


procedure TfrmMonsterConfig.ButtonGeneralSaveClick(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'MonOneDropGoldCount', g_Config.nMonOneDropGoldCount);
  Config.WriteBool('Setup', 'DropGoldToPlayBag', g_Config.boDropGoldToPlayBag);
  uModValue();
end;

procedure TfrmMonsterConfig.EditMonOneDropGoldCountChange(Sender: TObject);
begin
  if EditMonOneDropGoldCount.Text = '' then begin
    EditMonOneDropGoldCount.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMonOneDropGoldCount := EditMonOneDropGoldCount.Value;
  ModValue();
end;

procedure TfrmMonsterConfig.CheckBoxDropGoldToPlayBagClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boDropGoldToPlayBag := CheckBoxDropGoldToPlayBag.Checked;
  ModValue();
end;

procedure TfrmMonsterConfig.FormDestroy(Sender: TObject);
begin
  frmMonsterConfig:= nil;
end;

procedure TfrmMonsterConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

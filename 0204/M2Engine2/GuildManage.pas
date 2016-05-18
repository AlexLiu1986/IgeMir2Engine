unit GuildManage;
//�л����
interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Guild, Spin;

type
  TfrmGuildManage = class(TForm)
    GroupBox1: TGroupBox;
    ListViewGuild: TListView;
    GroupBox2: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditGuildName: TEdit;
    EditBuildPoint: TSpinEdit;
    EditAurae: TSpinEdit;
    EditStability: TSpinEdit;
    EditFlourishing: TSpinEdit;
    Label4: TLabel;
    EditChiefItemCount: TSpinEdit;
    Label5: TLabel;
    EditGuildFountain: TSpinEdit;
    Button1: TButton;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    EditGuildMemberCount: TSpinEdit;
    Button2: TButton;
    Label9: TLabel;
    SpinEditGuildMemberCount: TSpinEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewGuildClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EditBuildPointClick(Sender: TObject);
    procedure EditGuildMemberCountChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EditGuildMemberCountClick(Sender: TObject);
  private
    procedure RefGuildList;
    procedure RefGuildInfo;
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmGuildManage: TfrmGuildManage;
  CurGuild: TGUild;

implementation

uses M2Share;
var
  boRefing: Boolean;
{$R *.dfm}
procedure TfrmGuildManage.RefGuildList;
var
  I: Integer;
  Guild: TGUild;
  ListItem: TListItem;
begin
  if g_GuildManager.GuildList.Count > 0 then begin
    for I := 0 to g_GuildManager.GuildList.Count - 1 do begin
      Guild := TGUild(g_GuildManager.GuildList.Items[I]);
      ListItem := ListViewGuild.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(Guild.sGuildName, Guild);
      ListItem.SubItems.Add(Guild.sGuildName);
    end;
  end;
end;

procedure TfrmGuildManage.Open;
begin
  EditGuildMemberCount.Value := g_Config.nGuildMemberCount;
  RefGuildList();  
  ShowModal;
end;

procedure TfrmGuildManage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmGuildManage.FormDestroy(Sender: TObject);
begin
  frmGuildManage:= nil;
end;

procedure TfrmGuildManage.RefGuildInfo;
begin
  if CurGuild = nil then Exit;
  boRefing := True;
  EditGuildName.Text := CurGuild.sGuildName;
  EditBuildPoint.Value := CurGuild.nBuildPoint;//������
  EditAurae.Value := CurGuild.nAurae; //������
  EditStability.Value := CurGuild.nStability; //������
  EditFlourishing.Value := CurGuild.nFlourishing;//���ٶ�
  EditChiefItemCount.Value := CurGuild.nChiefItemCount;//�л���ȡװ������
  EditGuildFountain.Value := CurGuild.m_nGuildFountain;//�л�Ȫˮ�ֿ�
  SpinEditGuildMemberCount.Value := CurGuild.m_nGuildMemberCount;//�л��Ա����
  boRefing := False;
end;

procedure TfrmGuildManage.ListViewGuildClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewGuild.Selected;
  if ListItem = nil then Exit;
  CurGuild := TGUild(ListItem.SubItems.Objects[0]);
  RefGuildInfo();
end;

procedure TfrmGuildManage.Button1Click(Sender: TObject);
begin
  Try
    if CurGuild = nil then Exit;
    if EditGuildName.Text <> '' then begin
      if CompareText(CurGuild.sGuildName, EditGuildName.Text) = 0 then begin
        CurGuild.nBuildPoint := EditBuildPoint.Value;//������
        CurGuild.nAurae := EditAurae.Value; //������
        CurGuild.nStability := EditStability.Value; //������
        CurGuild.nFlourishing := EditFlourishing.Value;//���ٶ�
        CurGuild.nChiefItemCount := EditChiefItemCount.Value;//�л���ȡװ������
        CurGuild.m_nGuildFountain := EditGuildFountain.Value;//�л�Ȫˮ�ֿ�
        CurGuild.m_nGuildMemberCount := SpinEditGuildMemberCount.Value;//�л��Ա����
        CurGuild.SaveGuildInfoFile;
      end;
    end;
    Button1.Enabled:= False;
  Except
    MainOutMessage('{�쳣} TfrmGuildManage.Button1Click');
  end;
end;

procedure TfrmGuildManage.EditBuildPointClick(Sender: TObject);
begin
  Button1.Enabled:= True;
end;

procedure TfrmGuildManage.EditGuildMemberCountChange(Sender: TObject);
begin
  g_Config.nGuildMemberCount := EditGuildMemberCount.Value;
end;

procedure TfrmGuildManage.Button2Click(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'GuildMemberCount', g_Config.nGuildMemberCount);//�½��л��Ա����
  Button2.Enabled:= False;
end;

procedure TfrmGuildManage.EditGuildMemberCountClick(Sender: TObject);
begin
  Button2.Enabled:= True;
end;

end.

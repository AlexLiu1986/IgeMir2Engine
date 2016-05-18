unit IPaddrFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JSocket, WinSock, Menus, Spin, IniFiles, ComCtrls,
  RzTrkBar;

type
  TfrmIPaddrFilter = class(TForm)
    GroupBoxActive: TGroupBox;
    ListBoxActiveList: TListBox;
    GroupBox1: TGroupBox;
    ListBoxTempList: TListBox;
    ListBoxBlockList: TListBox;
    LabelTempList: TLabel;
    Label1: TLabel;
    BlockListPopupMenu: TPopupMenu;
    TempBlockListPopupMenu: TPopupMenu;
    ActiveListPopupMenu: TPopupMenu;
    APOPMENU_SORT: TMenuItem;
    APOPMENU_ADDTEMPLIST: TMenuItem;
    APOPMENU_BLOCKLIST: TMenuItem;
    APOPMENU_KICK: TMenuItem;
    TPOPMENU_SORT: TMenuItem;
    TPOPMENU_BLOCKLIST: TMenuItem;
    TPOPMENU_DELETE: TMenuItem;
    BPOPMENU_ADDTEMPLIST: TMenuItem;
    BPOPMENU_SORT: TMenuItem;
    BPOPMENU_DELETE: TMenuItem;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    EditMaxConnect: TSpinEdit;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    RadioAddBlockList: TRadioButton;
    RadioAddTempList: TRadioButton;
    RadioDisConnect: TRadioButton;
    APOPMENU_REFLIST: TMenuItem;
    ButtonOK: TButton;
    Label4: TLabel;
    TPOPMENU_REFLIST: TMenuItem;
    BPOPMENU_REFLIST: TMenuItem;
    Label7: TLabel;
    TPOPMENU_ADD: TMenuItem;
    BPOPMENU_ADD: TMenuItem;
    Label5: TLabel;
    TrackBarAttack: TTrackBar;
    CheckBoxChg: TCheckBox;
    CheckBoxAutoClearTempList: TCheckBox;
    SpinEdit2: TSpinEdit;
    CheckBoxReliefDefend: TCheckBox;
    SpinEdit3: TSpinEdit;
    SpinEdit1: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure ActiveListPopupMenuPopup(Sender: TObject);
    procedure APOPMENU_KICKClick(Sender: TObject);
    procedure APOPMENU_SORTClick(Sender: TObject);
    procedure APOPMENU_ADDTEMPLISTClick(Sender: TObject);
    procedure APOPMENU_BLOCKLISTClick(Sender: TObject);
    procedure TPOPMENU_SORTClick(Sender: TObject);
    procedure TPOPMENU_BLOCKLISTClick(Sender: TObject);
    procedure TPOPMENU_DELETEClick(Sender: TObject);
    procedure BPOPMENU_SORTClick(Sender: TObject);
    procedure BPOPMENU_ADDTEMPLISTClick(Sender: TObject);
    procedure BPOPMENU_DELETEClick(Sender: TObject);
    procedure TempBlockListPopupMenuPopup(Sender: TObject);
    procedure BlockListPopupMenuPopup(Sender: TObject);
    procedure EditMaxConnectChange(Sender: TObject);
    procedure RadioDisConnectClick(Sender: TObject);
    procedure RadioAddBlockListClick(Sender: TObject);
    procedure RadioAddTempListClick(Sender: TObject);
    procedure APOPMENU_REFLISTClick(Sender: TObject);
    procedure TPOPMENU_REFLISTClick(Sender: TObject);
    procedure BPOPMENU_REFLISTClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure TPOPMENU_ADDClick(Sender: TObject);
    procedure BPOPMENU_ADDClick(Sender: TObject);
    procedure TrackBarAttackChange(Sender: TObject);
    procedure CheckBoxChgClick(Sender: TObject);
    procedure CheckBoxAutoClearTempListClick(Sender: TObject);
    procedure CheckBoxReliefDefendClick(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);

  private
    { Private declarations }
    procedure ChgHint;
  public
    { Public declarations }
  end;

var
  frmIPaddrFilter: TfrmIPaddrFilter;

implementation

uses Main, GateShare, HUtil32;

{$R *.dfm}

procedure TfrmIPaddrFilter.ChgHint;
begin
  TrackBarAttack.Hint := '������Χ�ڣ�1-10���ֱ��ǣ��ϸ�-���ɡ��ȼ�Ϊ0ʱ�رչ�����������ǰ�ȼ���' + IntToStr(TrackBarAttack.Position);
  CheckBoxChg.Hint := '������' + IntToStr(g_nChgDefendLevel) + '�κ������ķ����ȼ�����1���������Զ�������ķ����ȼ�Ϊ1��';
  SpinEdit1.Hint := CheckBoxChg.Hint;
  CheckBoxAutoClearTempList.Hint := 'ÿ��' + IntToStr(g_dwClearTempList) + '���Զ������̬�����б��е�IP';
  SpinEdit2.Hint := CheckBoxAutoClearTempList.Hint;
  CheckBoxReliefDefend.Hint := '��û�й����󣬵ȴ�' + IntToStr(g_dwReliefDefend) + '����򽫷����ȼ���ԭ�������������';
  SpinEdit3.Hint := CheckBoxReliefDefend.Hint;
end;

procedure TfrmIPaddrFilter.FormCreate(Sender: TObject);
begin
  ListBoxActiveList.Clear;
  ListBoxTempList.Clear;
  ListBoxBlockList.Clear;
  ChgHint;
end;

procedure TfrmIPaddrFilter.ActiveListPopupMenuPopup(Sender: TObject);
var
  boCheck: Boolean;
begin
  APOPMENU_SORT.Enabled := ListBoxActiveList.Items.Count > 0;

  boCheck := (ListBoxActiveList.ItemIndex >= 0) and (ListBoxActiveList.ItemIndex < ListBoxActiveList.Items.Count);

  APOPMENU_ADDTEMPLIST.Enabled := boCheck;
  APOPMENU_BLOCKLIST.Enabled := boCheck;
  APOPMENU_KICK.Enabled := boCheck;
end;

procedure TfrmIPaddrFilter.APOPMENU_KICKClick(Sender: TObject);
begin
  if (ListBoxActiveList.ItemIndex >= 0) and (ListBoxActiveList.ItemIndex < ListBoxActiveList.Items.Count) then begin
    if Application.MessageBox(PChar('�Ƿ�ȷ�Ͻ������ӶϿ���'),
      PChar('ȷ����Ϣ - ' + ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex]), MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
    TCustomWinSocket(ListBoxActiveList.Items.Objects[ListBoxActiveList.ItemIndex]).Close;
    APOPMENU_REFLISTClick(Self);
  end;
end;

procedure TfrmIPaddrFilter.APOPMENU_SORTClick(Sender: TObject);
begin
  ListBoxActiveList.Sorted := True;
end;

procedure TfrmIPaddrFilter.APOPMENU_ADDTEMPLISTClick(Sender: TObject);
var
  sIPaddr: string;
begin
  if (ListBoxActiveList.ItemIndex >= 0) and (ListBoxActiveList.ItemIndex < ListBoxActiveList.Items.Count) then begin
    sIPaddr := ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex];
    if Application.MessageBox(PChar('�Ƿ�ȷ�Ͻ���IP���붯̬�����б��У���������б�󣬴�IP�������������ӽ���ǿ���жϡ�'),
      PChar('ȷ����Ϣ - ' + ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex]),
      MB_OKCANCEL + MB_ICONQUESTION
      ) <> IDOK then Exit;
    ListBoxTempList.Items.Add(sIPaddr);
    FrmMain.AddTempBlockIP(sIPaddr);
    FrmMain.CloseConnect(sIPaddr);
    APOPMENU_REFLISTClick(Self);
  end;
end;

procedure TfrmIPaddrFilter.APOPMENU_BLOCKLISTClick(Sender: TObject);
var
  sIPaddr: string;
begin
  if (ListBoxActiveList.ItemIndex >= 0) and (ListBoxActiveList.ItemIndex < ListBoxActiveList.Items.Count) then begin
    sIPaddr := ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex];
    if Application.MessageBox(PChar('�Ƿ�ȷ�Ͻ���IP�������ù����б��У���������б�󣬴�IP�������������ӽ���ǿ���жϡ�'),
      PChar('ȷ����Ϣ - ' + ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex]),
      MB_OKCANCEL + MB_ICONQUESTION
      ) <> IDOK then Exit;
    ListBoxBlockList.Items.Add(sIPaddr);
    FrmMain.AddBlockIP(sIPaddr);
    FrmMain.CloseConnect(sIPaddr);
    APOPMENU_REFLISTClick(Self);
  end;
end;

procedure TfrmIPaddrFilter.TPOPMENU_SORTClick(Sender: TObject);
begin
  ListBoxTempList.Sorted := True;
end;

procedure TfrmIPaddrFilter.TPOPMENU_BLOCKLISTClick(Sender: TObject);
var
  sIPaddr: string;
  I: Integer;
  nIPaddr: Integer;
begin
  if (ListBoxTempList.ItemIndex >= 0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count) then begin
    sIPaddr := ListBoxTempList.Items.Strings[ListBoxTempList.ItemIndex];
    ListBoxTempList.Items.Delete(ListBoxTempList.ItemIndex);
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to TempBlockIPList.Count - 1 do begin
      if pTSockaddr(TempBlockIPList.Items[I]).nIPaddr = nIPaddr then begin
        TempBlockIPList.Delete(I);
        break;
      end;
    end;
    ListBoxBlockList.Items.Add(sIPaddr);
    FrmMain.AddBlockIP(sIPaddr);
  end;
end;

procedure TfrmIPaddrFilter.TPOPMENU_DELETEClick(Sender: TObject);
var
  sIPaddr: string;
  I, nIPaddr: Integer;
begin
  if (ListBoxTempList.ItemIndex >= 0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count) then begin
    sIPaddr := ListBoxTempList.Items.Strings[ListBoxTempList.ItemIndex];
    ListBoxTempList.Items.Delete(ListBoxTempList.ItemIndex);
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to TempBlockIPList.Count - 1 do begin
      if pTSockaddr(TempBlockIPList.Items[I]).nIPaddr = nIPaddr then begin
        TempBlockIPList.Delete(I);
        break;
      end;
    end;
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_SORTClick(Sender: TObject);
begin
  ListBoxBlockList.Sorted := True;
end;

procedure TfrmIPaddrFilter.BPOPMENU_ADDTEMPLISTClick(Sender: TObject);
var
  sIPaddr: string;
  I: Integer;
  nIPaddr: Integer;
begin
  if (ListBoxBlockList.ItemIndex >= 0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count) then begin
    sIPaddr := ListBoxBlockList.Items.Strings[ListBoxBlockList.ItemIndex];
    ListBoxBlockList.Items.Delete(ListBoxBlockList.ItemIndex);
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to BlockIPList.Count - 1 do begin
      if pTSockaddr(BlockIPList.Items[I]).nIPaddr = nIPaddr then begin
        BlockIPList.Delete(I);
        break;
      end;
    end;
    ListBoxTempList.Items.Add(sIPaddr);
    FrmMain.AddTempBlockIP(sIPaddr);
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_DELETEClick(Sender: TObject);
var
  sIPaddr: string;
  I: Integer;
  nIPaddr: Integer;
begin
  if (ListBoxBlockList.ItemIndex >= 0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count) then begin
    sIPaddr := ListBoxBlockList.Items.Strings[ListBoxBlockList.ItemIndex];
    nIPaddr := inet_addr(PChar(sIPaddr));
    ListBoxBlockList.Items.Delete(ListBoxBlockList.ItemIndex);
    for I := 0 to BlockIPList.Count - 1 do begin
      if pTSockaddr(BlockIPList.Items[I]).nIPaddr = nIPaddr then begin
        BlockIPList.Delete(I);
        break;
      end;
    end;
  end;
end;

procedure TfrmIPaddrFilter.TempBlockListPopupMenuPopup(Sender: TObject);
var
  boCheck: Boolean;
begin
  TPOPMENU_SORT.Enabled := ListBoxTempList.Items.Count > 0;

  boCheck := (ListBoxTempList.ItemIndex >= 0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count);

  TPOPMENU_BLOCKLIST.Enabled := boCheck;
  TPOPMENU_DELETE.Enabled := boCheck;
end;

procedure TfrmIPaddrFilter.BlockListPopupMenuPopup(Sender: TObject);
var
  boCheck: Boolean;
begin
  BPOPMENU_SORT.Enabled := ListBoxBlockList.Items.Count > 0;

  boCheck := (ListBoxBlockList.ItemIndex >= 0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count);

  BPOPMENU_ADDTEMPLIST.Enabled := boCheck;
  BPOPMENU_DELETE.Enabled := boCheck;
end;

procedure TfrmIPaddrFilter.EditMaxConnectChange(Sender: TObject);
begin
  nMaxConnOfIPaddr := EditMaxConnect.Value;
end;



procedure TfrmIPaddrFilter.RadioDisConnectClick(Sender: TObject);
begin
  if RadioDisConnect.Checked then BlockMethod := mDisconnect;
  UseBlockMethod := BlockMethod;
end;

procedure TfrmIPaddrFilter.RadioAddBlockListClick(Sender: TObject);
begin
  if RadioAddBlockList.Checked then BlockMethod := mBlockList;
  UseBlockMethod := BlockMethod;
end;

procedure TfrmIPaddrFilter.RadioAddTempListClick(Sender: TObject);
begin
  if RadioAddTempList.Checked then BlockMethod := mBlock;
  UseBlockMethod := BlockMethod;
end;

procedure TfrmIPaddrFilter.APOPMENU_REFLISTClick(Sender: TObject);
var
  I: Integer;
  sIPaddr: string;
begin
  ListBoxActiveList.Clear;
  if FrmMain.ServerSocket.Active then
    for I := 0 to FrmMain.ServerSocket.Socket.ActiveConnections - 1 do begin
      sIPaddr := FrmMain.ServerSocket.Socket.Connections[I].RemoteAddress;
      if sIPaddr <> '' then
        ListBoxActiveList.Items.AddObject(sIPaddr, TObject(FrmMain.ServerSocket.Socket.Connections[I]));
    end;
end;

procedure TfrmIPaddrFilter.TPOPMENU_REFLISTClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxTempList.Clear;
  for I := 0 to TempBlockIPList.Count - 1 do begin
    frmIPaddrFilter.ListBoxTempList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(TempBlockIPList.Items[I]).nIPaddr))));
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_REFLISTClick(Sender: TObject);
var
  I: Integer;
  IPaddr: pTSockaddr;
begin
  ListBoxBlockList.Clear;
  for I := 0 to BlockIPList.Count - 1 do begin
    frmIPaddrFilter.ListBoxTempList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr))));
  end;
end;

procedure TfrmIPaddrFilter.ButtonOKClick(Sender: TObject);
var
  Conf: TIniFile;
  sFileName: string;
begin
  sFileName := '.\Config.ini';
  Conf := TIniFile.Create(sFileName);
  Conf.WriteInteger(GateClass, 'AttackLevel', nAttackLevel);
  Conf.WriteInteger(GateClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);
  Conf.WriteInteger(GateClass, 'MaxConnOfIPaddr', nMaxConnOfIPaddr);
  Conf.WriteInteger(GateClass, 'BlockMethod', Integer(BlockMethod));

  Conf.WriteBool(GateClass, 'ChgDefendLevel', g_boChgDefendLevel);
  Conf.WriteBool(GateClass, 'ClearTempList', g_boClearTempList);
  Conf.WriteBool(GateClass, 'ReliefDefend', g_boReliefDefend);
  Conf.WriteInteger(GateClass, 'ChgDefendLevelCount', g_nChgDefendLevel);
  Conf.WriteInteger(GateClass, 'ClearTempListTime', g_dwClearTempList);
  Conf.WriteInteger(GateClass, 'ReliefDefendTime', g_dwReliefDefend);

  Conf.Free;
  Close;
end;

procedure TfrmIPaddrFilter.TPOPMENU_ADDClick(Sender: TObject);
var
  sIPaddress: string;
begin
  sIPaddress := '';
  if not InputQuery('����IP����', '������һ���µ�IP��ַ: ', sIPaddress) then Exit;
  if not IsIPaddr(sIPaddress) then begin
    Application.MessageBox('����ĵ�ַ��ʽ���󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    Exit;
  end;
  ListBoxTempList.Items.Add(sIPaddress);
  FrmMain.AddTempBlockIP(sIPaddress);
end;

procedure TfrmIPaddrFilter.BPOPMENU_ADDClick(Sender: TObject);
var
  sIPaddress: string;
begin
  sIPaddress := '';
  if not InputQuery('����IP����', '������һ���µ�IP��ַ: ', sIPaddress) then Exit;
  if not IsIPaddr(sIPaddress) then begin
    if Application.MessageBox('����ĵ�ַ��ʽ���������Ƿ���ӣ�',
      '������Ϣ',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then
      Exit;
  end;
  ListBoxBlockList.Items.Add(sIPaddress);
  FrmMain.AddBlockIP(sIPaddress);
  SaveBlockIPList();
end;

procedure TfrmIPaddrFilter.TrackBarAttackChange(Sender: TObject);
begin
  nAttackLevel := TrackBarAttack.Position;
  nUseAttackLevel := nAttackLevel;
  ChgHint;
end;

procedure TfrmIPaddrFilter.CheckBoxChgClick(Sender: TObject);
begin
  g_boChgDefendLevel := CheckBoxChg.Checked;
end;

procedure TfrmIPaddrFilter.CheckBoxAutoClearTempListClick(Sender: TObject);
begin
  g_boClearTempList := CheckBoxAutoClearTempList.Checked;
end;

procedure TfrmIPaddrFilter.CheckBoxReliefDefendClick(Sender: TObject);
begin
  g_boReliefDefend := CheckBoxReliefDefend.Checked;
end;

procedure TfrmIPaddrFilter.SpinEdit1Change(Sender: TObject);
begin
  g_nChgDefendLevel := SpinEdit1.Value;
  ChgHint;
end;

procedure TfrmIPaddrFilter.SpinEdit2Change(Sender: TObject);
begin
  g_dwClearTempList := SpinEdit2.Value;
  ChgHint;
end;

procedure TfrmIPaddrFilter.SpinEdit3Change(Sender: TObject);
begin
  g_dwReliefDefend := SpinEdit3.Value;
  ChgHint;
end;

end.


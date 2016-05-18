unit MakeLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, RzEdit, RzBtnEdt, Buttons,
  RzLabel, ExtCtrls, RzPanel, RzRadGrp, Menus, IdAntiFreezeBase,
  IdAntiFreeze, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdFTP, ExtDlgs, Jpeg, IdFTPCommon, RzBHints, IniFiles;

type
  TFrmMakeLogin = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtLoginName: TEdit;
    EdtClientFileName: TEdit;
    GroupBox5: TGroupBox;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    EdtMakeKey: TEdit;
    BtnMakeLogin: TButton;
    BtnMakeGate: TButton;
    GroupBox6: TGroupBox;
    Label7: TLabel;
    ComboBox1: TComboBox;
    BtnAddArray: TButton;
    BtnDelArray: TButton;
    GroupBox7: TGroupBox;
    ListView1: TListView;
    Memo1: TMemo;
    GroupBox8: TGroupBox;
    GroupBox10: TGroupBox;
    ListViewDisallow: TListView;
    BtnGameListAdd: TSpeedButton;
    BtnGameListRea: TSpeedButton;
    BtnGameListDel: TSpeedButton;
    Button5: TButton;
    BtnSaveGameListConfig: TButton;
    ListViewGameMon: TListView;
    Label8: TLabel;
    GroupBox9: TGroupBox;
    Label9: TLabel;
    EdtGameMon: TEdit;
    BtnGameMonAdd: TSpeedButton;
    BtnChangeGameMon: TSpeedButton;
    BtnGameMonDel: TSpeedButton;
    RzLabel12: TRzLabel;
    GameMonTypeRadioGroup: TRzRadioGroup;
    Label10: TLabel;
    GroupBox11: TGroupBox;
    ListBoxitemList: TListBox;
    Button7: TButton;
    BtnSdoDel: TButton;
    BtnAllAdd: TButton;
    BtnSdoAllDel: TButton;
    FileTypeRadioGroup: TRzRadioGroup;
    Button11: TButton;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ComBoxDir: TComboBox;
    EdtFileName: TEdit;
    EdtDownUrl: TEdit;
    EdtMd5: TEdit;
    BtnOpenFile: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    BtnSaveGameMon: TButton;
    Button17: TButton;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Button3: TButton;
    IdFTP1: TIdFTP;
    IdAntiFreeze1: TIdAntiFreeze;
    ProgressBar1: TProgressBar;
    Label16: TLabel;
    RzRadioGroupMainImages: TRzRadioGroup;
    OpenPictureDialog1: TOpenPictureDialog;
    EdtAssistantFilter: TEdit;
    BtnAssistantFilter: TButton;
    EdtLoginMainImages: TEdit;
    BtnLoginMainImages: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    RzBalloonHints1: TRzBalloonHints;
    procedure BtnAddArrayClick(Sender: TObject);
    procedure BtnDelArrayClick(Sender: TObject);
    procedure BtnGameListAddClick(Sender: TObject);
    procedure BtnGameListReaClick(Sender: TObject);
    procedure BtnGameListDelClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BtnOpenFileClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure BtnGameMonAddClick(Sender: TObject);
    procedure BtnChangeGameMonClick(Sender: TObject);
    procedure BtnGameMonDelClick(Sender: TObject);
    procedure BtnSaveGameMonClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure BtnSdoDelClick(Sender: TObject);
    procedure BtnAllAddClick(Sender: TObject);
    procedure BtnSdoAllDelClick(Sender: TObject);
    procedure ListViewDisallowMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure BtnMakeLoginClick(Sender: TObject);
    procedure BtnAssistantFilterClick(Sender: TObject);
    procedure BtnLoginMainImagesClick(Sender: TObject);
    procedure IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdFTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure BtnMakeGateClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure BtnSaveGameListConfigClick(Sender: TObject);
  private
    function InGameMonList(sFilterMsg: string): Boolean;
    function  LoadGameFilterItemNameList(): Boolean; //��Ϸʢ��ҹ�����Ʒ��
    procedure ListBoxLoadItemDB();
    function InListBoxitemList(sItemName: string): Boolean;
    procedure LoadConfig();
  public
    procedure Open();
    procedure AddListView(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL, GameItemsUrl ,ServerGatePass:String);
    procedure ChangeListView(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL, GameItemsURL ,ServerGatePass:String);
    procedure UpFile();
    procedure MakeGate();
  end;

var
  FrmMakeLogin: TFrmMakeLogin;
  dwMakeTick: LongWord;
implementation

uses AddGameList, Md5, Share, Main, EDcodeUnit, HUtil32;

{$R *.dfm}
procedure TFrmMakeLogin.Open;
begin
  if not g_boFirstOpen then begin
    Query.DatabaseName := 'HeroDb';
    try
    LoadItemsDB();
    except
      Application.MessageBox('�����û������DBE��������������ΪHeroDB������' 
        + #13#10 + '�����������ô���ò���ʢ������ļ�������', 'Error', MB_OK
        + MB_ICONSTOP);
    end;
    ListBoxLoadItemDB();
    LoadConfig();
    LoadGameFilterItemNameList(); //��ȡ����listview�б�
    g_boFirstOpen := True;
  end;
  ShowModal;
end;
procedure TFrmMakeLogin.ListBoxLoadItemDB;
var
  List: Classes.TList;
  I: Integer;
  StdItem: pTStdItem;
begin
  ListBoxitemList.Items.Clear;
  if StdItemList <> nil then begin
    List := Classes.TList(TObject(StdItemList));
    for I := 0 to List.Count - 1 do begin
        StdItem := List.Items[I];
        ListBoxitemList.Items.AddObject(StdItem.Name, TObject(StdItem));
    end;
    List.Free;
  end;
end;
//==============================================================================
//��Ϸ�б���ش���
procedure TFrmMakeLogin.AddListView(ServerArray, ServerName, ServerIp,
  ServerPort, ServerNoticeURL, ServerHomeURL, GameItemsURL ,ServerGatePass: String);
var
  ListItem: TListItem;
begin
  ListView1.Items.BeginUpdate;
  try
    ListItem := ListView1.Items.Add;
    ListItem.Caption := ServerArray;
    ListItem.SubItems.Add(ServerName);
    ListItem.SubItems.Add(ServerIp);
    ListItem.SubItems.Add(ServerPort);
    ListItem.SubItems.Add(ServerNoticeURL);
    ListItem.SubItems.Add(ServerHomeURL);
    ListItem.SubItems.Add(GameItemsURL);
    ListItem.SubItems.Add(ServerGatePass);
  finally
    ListView1.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.BtnAddArrayClick(Sender: TObject);
var
  str: string;
  I: Integer;
begin
  str:= InputBox('����','��������Ҫ���ӵķ��������飺','');
  if str <> '' then begin
    for I:=0 to ComBoBox1.Items.Count-1 do begin
      if ComBoBox1.Items.Strings[I] = str then begin
        Application.MessageBox('�˷��������������б��У�����', 'Error', MB_OK 
          + MB_ICONSTOP);
        Exit;
      end;
    end;
  ComBoBox1.Items.Add(str);
  ComBoBox1.ItemIndex := ComBoBox1.Items.Count-1;
  end;
end;

procedure TFrmMakeLogin.BtnDelArrayClick(Sender: TObject);
begin
  if Application.MessageBox(Pchar('�Ƿ�ȷ��ɾ������ ['+ComBoBox1.items[ComBoBox1.ItemIndex]+'] ��Ϣ��'), '��ʾ', MB_YESNO + MB_ICONINFORMATION) = IDYES then begin
    ComBoBox1.Items.Delete(ComBoBox1.ItemIndex);
    ComBoBox1.ItemIndex:=ComBoBox1.ItemIndex-1;
  end;
end;


procedure TFrmMakeLogin.BtnGameListAddClick(Sender: TObject);
begin
  FrmAddGameList := TFrmAddGameList.Create(Owner);
  FrmAddGameList.Add;
  FrmAddGameList.Free;
end;

procedure TFrmMakeLogin.BtnGameListReaClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListView1.Selected;
  if ListItem <> nil then begin
    if FrmAddGameList = nil then FrmAddGameList := TFrmAddGameList.Create(Owner);
    FrmAddGameList.Change(ListItem.Caption,ListItem.SubItems.Strings[0],ListItem.SubItems.Strings[1],ListItem.SubItems.Strings[2],ListItem.SubItems.Strings[3],ListItem.SubItems.Strings[4],ListItem.SubItems.Strings[5],ListItem.SubItems.Strings[6]);
    FrmAddGameList.Free;
  end else Application.MessageBox('��ѡ����Ҫ�޸ĵ���Ϣ��', 'Error', MB_OK + 
    MB_ICONSTOP);
end;

procedure TFrmMakeLogin.BtnGameListDelClick(Sender: TObject);
begin
   ListView1.Items.BeginUpdate;
  try
    if ListView1.Selected <> nil then
      ListView1.DeleteSelected
      else Application.MessageBox('��ѡ����Ҫɾ������Ϣ��', 'Error', MB_OK + 
        MB_ICONSTOP);
  finally
    ListView1.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.ChangeListView(ServerArray, ServerName, ServerIp,
  ServerPort, ServerNoticeURL, ServerHomeURL, GameItemsURL ,ServerGatePass: String);
var
  nItemIndex: Integer;
  ListItem: TListItem;
begin
  try
    nItemIndex := ListView1.ItemIndex;
    ListItem := ListView1.Items.Item[nItemIndex];
    ListItem.Caption := ServerArray;
    ListItem.SubItems.Strings[0] := ServerName;
    ListItem.SubItems.Strings[1] := ServerIp;
    ListItem.SubItems.Strings[2] := ServerPort;
    ListItem.SubItems.Strings[3] := ServerNoticeURL;
    ListItem.SubItems.Strings[4] := ServerHomeURL;
    ListItem.SubItems.Strings[5] := GameItemsURL;
    ListItem.SubItems.Strings[6] := ServerGatePass;
  except
  end;
end;

procedure TFrmMakeLogin.Button5Click(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: Classes.TStringList;
  sServerArray, sServerName, sServerIP, sServerPort, sServerNoticeURL, sServerHomeURL, sGameItemsURL, sGatePass: String;
  sFileName, sLineText: String;
begin
  if ListView1.Items.Count <> 0 then begin
    sFileName := 'QKServerList.txt';
    SaveList := Classes.TStringList.Create();
    SaveList.Add(';����������'#9'��Ϸ����'#9'��ϷIP��ַ'#9'�˿�'#9'�����ַ'#9'��վ��ҳ'#9'װ��չʾ'#9'��������');
    ListView1.Items.BeginUpdate;
    try
      for I := 0 to ListView1.Items.Count - 1 do begin
        ListItem := ListView1.Items.Item[I];
        sServerArray     := ListItem.Caption;
        sServerName      := ListItem.SubItems.Strings[0];
        sServerIP        := ListItem.SubItems.Strings[1];
        sServerPort      := ListItem.SubItems.Strings[2];
        sServerNoticeURL := ListItem.SubItems.Strings[3];
        sServerHomeURL   := ListItem.SubItems.Strings[4];
        sGameItemsURL    := ListItem.SubItems.Strings[5];
        sGatePass        := ListItem.SubItems.Strings[6];
        sLineText := sServerArray + '|' + sServerName + '|' + sServerIP + '|' + sServerPort + '|' + sServerNoticeURL + '|' + sServerHomeURL + '|' + sGameItemsURL + '|' + sGatePass;
        SaveList.Add(sLineText);
      end;
    finally
      ListView1.Items.EndUpdate;
    end;
    SaveList.Text := Trim(SaveList.Text);
    SaveList.SaveToFile(ExtractFilePath(ParamStr(0))+sFileName);
    SaveList.Free;
    Application.MessageBox('��Ϸ�б����ɳɹ�' + #13#10 + 
      '�븴��Ŀ¼�µ� QKServerList.txt ���������վĿ¼�¼���', '��ʾ', MB_OK
      + MB_ICONINFORMATION);
  end else Application.MessageBox('�㻹û�������ϷŶ��', 'Error', MB_OK + 
    MB_ICONSTOP);
end;
//==============================================================================
//��Ϸ����������ش���
procedure TFrmMakeLogin.BtnOpenFileClick(Sender: TObject);
begin
  OpenDialog1.Filter := '��Ϸ�����ļ�|*.*';
  if OpenDialog1.Execute then begin
    EdtFileName.Text := ExtractFileName(OpenDialog1.FileName);
    EdtMd5.Text := RivestFile(OpenDialog1.FileName);
  end;
end;

procedure TFrmMakeLogin.Button11Click(Sender: TObject);
var
  Dir: String;
begin
  case ComBoxDir.ItemIndex of
    0:Dir := 'Data/';
    1:Dir := 'Map/';
    2:Dir := 'Wav/';
    3:Dir := './';
  end;
  if ComBoxDir.Text = '' then begin
      Application.MessageBox('��ѡ��ͻ��˸���Ŀ¼', 'Error', MB_OK + 
        MB_ICONSTOP);
      ComBoxDir.SetFocus;
      exit;
  end;
  if EdtFileName.Text = '' then begin
      Application.MessageBox('��ѡ���ļ�����ȡ�ļ���', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtFileName.SetFocus;
      exit;
  end;
  if EdtDownUrl.Text = '' then begin
      Application.MessageBox('���ص�ַ��ô�ܿգ�', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtDownUrl.SetFocus;
      exit;
  end;
  if EdtMd5.Text = '' then begin
      Application.MessageBox('��ѡ���ļ�����ȡ�ļ�MD5ֵ', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtMd5.SetFocus;
      Exit;
  end;
  Memo1.Lines.Add(IntToStr(FileTypeRadioGroup.ItemIndex) +#9+ Dir +#9+ EdtFileName.Text +#9+ EdtMd5.Text +#9+ EdtDownUrl.Text)
end;

procedure TFrmMakeLogin.Button13Click(Sender: TObject);
var
  sPatchFile: String;
  SaveList: Classes.TStringList;
begin
  sPatchFile := 'QKPatchList.txt';
  SaveList := Classes.TStringList.Create();
  SaveList.Text := Memo1.Lines.Text;
  SaveList.SaveToFile(ExtractFilePath(ParamStr(0))+sPatchFile);
  SaveList.Free;
  Application.MessageBox('��Ϸ�����б����ɳɹ�'+#13+'�븴��Ŀ¼�µ�'+' QKPatchList.txt '+'���������վĿ¼�¼���', '��ʾ', MB_OK +
    MB_ICONINFORMATION);
end;

procedure TFrmMakeLogin.Button14Click(Sender: TObject);
begin
  OpenDialog1.Filter := '��Ϸ�����ļ�(*.TxT)|*.Txt';
  if OpenDialog1.Execute then begin
     Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
     Application.MessageBox(PChar('��ȡ�����б��ļ� '+OpenDialog1.FileName+' �ɹ���'), '��ʾ', MB_OK +
       MB_ICONINFORMATION);
  end;
end;

procedure TFrmMakeLogin.Button15Click(Sender: TObject);
var
  sPatchFile: String;
begin
  sPatchFile := '���²�����¼.txt';
  Memo1.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+sPatchFile);
  Application.MessageBox('��Ϸ�����б���ɹ�'+#13+'�뱣�ܺ� ���²�����¼.txt�ļ� '+'�Ժ�༭���������ļ��༭�Ϳ����ˣ�', '��ʾ', MB_OK +
    MB_ICONINFORMATION);
end;
//==============================================================================
//�����������ش���


procedure TFrmMakeLogin.BtnGameMonAddClick(Sender: TObject);
var
  sGameMonName: string;
  ListItem: TListItem;
  sGameTyep: string;
begin
  sGameMonName := Trim(EdtGameMon.Text);
  if sGameMonName = '' then begin
    Application.MessageBox('����������������ƣ�', 'Error', MB_OK + 
      MB_ICONSTOP);
    Exit;
  end;
  if InGameMonList(sGameMonName) then begin
    Application.MessageBox('�������������������Ѿ����ڣ�����', 'Error', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  case GameMonTypeRadioGroup.ItemIndex of
    0: sGameTyep := '��������';
    1: sGameTyep := '��������';
    2: sGameTyep := 'ģ������';
  end;
  ListViewGameMon.Items.BeginUpdate;
  try
    ListItem := ListViewGameMon.Items.Add;
    ListItem.Caption := sGameTyep;
    ListItem.SubItems.Add(sGameMonName);
  finally
    ListViewGameMon.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.BtnChangeGameMonClick(Sender: TObject);
var
  sGameMonName: string;
  ListItem: TListItem;
  sGameTyep: string;
begin
  sGameMonName := Trim(EdtGameMon.Text);
  if sGameMonName = '' then begin
    Application.MessageBox('����������������ƣ�', 'Error', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  if InGameMonList(sGameMonName) then begin
    Application.MessageBox('�������������������Ѿ����ڣ�����', 'Error', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  case GameMonTypeRadioGroup.ItemIndex of
    0: sGameTyep := '��������';
    1: sGameTyep := '��������';
    2: sGameTyep := 'ģ������';
  end;
  ListViewGameMon.Items.BeginUpdate;
  try
    ListItem := ListViewGameMon.Items.Item[ListViewGameMon.ItemIndex];
    ListItem.Caption := sGameTyep;
    ListItem.SubItems.Strings[0] := (sGameMonName);
  finally
    ListViewGameMon.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.BtnGameMonDelClick(Sender: TObject);
begin
  try
    ListViewGameMon.DeleteSelected;
  except
  end;
end;

procedure TFrmMakeLogin.BtnSaveGameMonClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: TStringList;
  sGameMonName: string;
  sGameTyepName: string;
begin
  SaveList := TStringList.Create;
  SaveList.Add(';��������'#9'�������');
  ListViewGameMon.Items.BeginUpdate;
  try
    for I := 0 to ListViewGameMon.Items.Count - 1 do begin
      ListItem := ListViewGameMon.Items.Item[I];
      sGameTyepName := ListItem.Caption;
      sGameMonName := ListItem.SubItems.Strings[0];
      SaveList.Add(sGameTyepName + #9 + sGameMonName);
    end;
  finally
    ListViewGameMon.Items.EndUpdate;
  end;
  SaveList.SaveToFile(ExtractFilePath(ParamStr(0))+GameMonName);
  SaveList.Free;
  Application.MessageBox('������б����ɳɹ�'+#13+'�븴��Ŀ¼�µ�'+' QKGameMonList.txt '+'���������վĿ¼�¼���', '��ʾ', MB_OK +
    MB_ICONINFORMATION);
end;

function TFrmMakeLogin.InGameMonList(sFilterMsg: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  ListViewGameMon.Items.BeginUpdate;
  try
    for I := 0 to ListViewGameMon.Items.Count - 1 do begin
      ListItem := ListViewGameMon.Items.Item[I];
      if CompareText(sFilterMsg, ListItem.SubItems.Strings[0]) = 0 then begin
        Result := TRUE;
        break;
      end;
    end;
  finally
    ListViewGameMon.Items.EndUpdate;
  end;
end;



function TFrmMakeLogin.LoadGameFilterItemNameList: Boolean;
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sItemName: string;
  sCanPick: string;
  sCanShow: string;
  ListItem: TListItem;
begin
  Result := False;
  sFileName := FilterFileName;
  if not FileExists(sFileName) then begin
    Exit;
  end;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanPick, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanShow, [' ', #9]);
      ListViewDisallow.Items.BeginUpdate;
      try
        ListItem := ListViewDisallow.Items.Add;
        ListItem.Caption := sItemName;
        ListItem.SubItems.Add(sCanPick);
        ListItem.SubItems.Add(sCanShow);
      finally
        ListViewDisallow.Items.EndUpdate;
      end;
    end;
  end;
  Result := True;
  LoadList.Free;
end;


//==============================================================================
//�ڹҹ���������ش���
procedure TFrmMakeLogin.Button7Click(Sender: TObject);
var
  ListItem: TListItem;
  sItemName: string;
  I: Integer;
begin
  if ListBoxitemList.ItemIndex=-1 then exit;
  for i:=0 to (ListBoxitemList.Items.Count-1) do begin
    if ListBoxitemList.Selected[i] then begin
        sItemName := ListBoxitemList.items.Strings[i];
        if (sItemName <> '') then begin
          if InListBoxitemList(sItemName) then begin
            Application.MessageBox('��Ҫѡ�����Ʒ�Ѿ��ڹ�����Ʒ�б��У���ѡ��������Ʒ������', 
              'Error', MB_OK + MB_ICONSTOP);
            Exit;
          end;
          ListViewDisallow.Items.BeginUpdate;
          try
            ListItem := ListViewDisallow.Items.Add;
            ListItem.Caption := sItemName;
            ListItem.SubItems.Add('1');
            ListItem.SubItems.Add('1');
            if not BtnSdoDel.Enabled then BtnSdoDel.Enabled := True;
            if not BtnSdoAllDel.Enabled then BtnSdoAllDel.Enabled := True;
          finally
            ListViewDisallow.Items.EndUpdate;
          end;
        end;
    end;
  end;
end;

function TFrmMakeLogin.InListBoxitemList(sItemName: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  ListViewDisallow.Items.BeginUpdate;
  try
    for I := 0 to ListViewDisallow.Items.Count - 1 do begin
      ListItem := ListViewDisallow.Items.Item[I];
      if CompareText(sItemName, ListItem.Caption) = 0 then begin
        Result := TRUE;
        break;
      end;
    end;
  finally
    ListViewDisallow.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.BtnSdoDelClick(Sender: TObject);
begin
  try
    ListViewDisallow.DeleteSelected;
  except
  end;
end;

procedure TFrmMakeLogin.BtnAllAddClick(Sender: TObject);
var
  ListItem: TListItem;
  I: Integer;
begin
  ListViewDisallow.Items.Clear;
  ListViewDisallow.Items.BeginUpdate;
  try
  for I := 0 to ListBoxitemList.Items.Count - 1 do begin
    ListItem := ListViewDisallow.Items.Add;
    ListItem.Caption := ListBoxitemList.Items.Strings[I];
    ListItem.SubItems.Add('1');
    ListItem.SubItems.Add('1');
  end;
  if not BtnSdoDel.Enabled then BtnSdoDel.Enabled := True;
  if not BtnSdoAllDel.Enabled then BtnSdoAllDel.Enabled := True;
  //ModValue();
  finally
      ListViewDisallow.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.BtnSdoAllDelClick(Sender: TObject);
begin
  ListViewDisallow.Items.Clear;
  BtnSdoDel.Enabled := False;
  BtnSdoAllDel.Enabled := False;
end;

procedure TFrmMakeLogin.ListViewDisallowMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    PopupMenu1.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
  end;
end;

procedure TFrmMakeLogin.N1Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewDisallow.Selected;
  while(ListItem <> nil) do begin
      ListItem.SubItems.Strings[0] := '1';
      ListItem := ListViewDisallow.GetNextItem(ListItem,   sdAll,   [isSelected]);
  end;
end;

procedure TFrmMakeLogin.N2Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewDisallow.Selected;
  while(ListItem <> nil) do begin
      ListItem.SubItems.Strings[1] := '1';
      ListItem := ListViewDisallow.GetNextItem(ListItem,   sdAll,   [isSelected]);
  end;
end;

procedure TFrmMakeLogin.N3Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewDisallow.Selected;
  while(ListItem <> nil) do begin
      ListItem.SubItems.Strings[0] := '0';
      ListItem := ListViewDisallow.GetNextItem(ListItem,   sdAll,   [isSelected]);
  end;
end;

procedure TFrmMakeLogin.N4Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewDisallow.Selected;
  while(ListItem <> nil) do begin
      ListItem.SubItems.Strings[1] := '0';
      ListItem := ListViewDisallow.GetNextItem(ListItem,   sdAll,   [isSelected]);
  end;
end;

procedure TFrmMakeLogin.Button3Click(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: TStringList;
  sFileName, sLineText: string;
  sItemName: string;
  sCanPick, sCanShow: String;
begin
  if ListViewDisallow.Items.Count = 0 then
  begin
    Application.MessageBox('������Ʒ�б��ǿյ�Ŷ��', 'Error', MB_OK + 
      MB_ICONSTOP);
    Exit;
  end;

  sFileName := FilterFileName;
  SaveList := Classes.TStringList.Create();
  SaveList.Add(';IGE�����ڹҹ��������ļ�');
  SaveList.Add(';��Ʒ����'#9'�Ƿ�����Զ���ȡ'#9'�Ƿ������ʾ��Ʒ'#9'1Ϊ���� 0Ϊ��ֹ');
  ListViewDisallow.Items.BeginUpdate;
  try
    for I := 0 to ListViewDisallow.Items.Count - 1 do begin
      ListItem := ListViewDisallow.Items.Item[I];
      sItemName := ListItem.Caption;
      sCanPick := ListItem.SubItems.Strings[0];
      sCanShow := ListItem.SubItems.Strings[1];
      sLineText := sItemName + #9 + sCanPick + #9 + sCanShow;
      SaveList.Add(sLineText);
    end;
  finally
    ListViewDisallow.Items.EndUpdate;
  end;
  SaveList.SaveToFile(ExtractFilePath(ParamStr(0))+sFileName);
  Application.MessageBox('�ڹҹ����ļ����ɳɹ���',
    '��ʾ', MB_OK + MB_ICONINFORMATION);
  SaveList.Free;
end;
//==============================================================================
//���ɵ�½��������������ش���
procedure TFrmMakeLogin.Button17Click(Sender: TObject);
  //���ȡ��
  function RandomGetName():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //�������
      for i:=0 to 6 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
begin
  EdtClientFileName.Text := RandomGetName()+'.THG';
end;

procedure TFrmMakeLogin.BtnAssistantFilterClick(Sender: TObject);
begin
  OpenDialog1.Filter := '�ڹҹ����ļ�(*.TXT)|*.TXT';
  if OpenDialog1.Execute then begin
    EdtAssistantFilter.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmMakeLogin.BtnLoginMainImagesClick(Sender: TObject);
begin
  OpenPictureDialog1.Filter := '��½������ͼ(*.jpg)|*.jpg';
  if OpenPictureDialog1.Execute then begin
    EdtLoginMainImages.Text := OpenPictureDialog1.FileName;
  end;
end;

procedure TFrmMakeLogin.BtnMakeLoginClick(Sender: TObject);
begin
  if EdtLoginName.Text = '' then begin
    Application.MessageBox('��½�����Ʋ���Ϊ�գ�', 'Error', MB_OK +
      MB_ICONSTOP);
    EdtLoginName.SetFocus;
    Exit;  
  end;
  if Trim(EdtClientFileName.Text) = '' then begin
    Application.MessageBox('�ͻ����ļ����Ʋ���Ϊ�գ�', 'Error', MB_OK + 
      MB_ICONSTOP);
    EdtClientFileName.SetFocus;
    Exit;  
  end;
  if Trim(EdtMakeKey.Text) = '' then begin
    Application.MessageBox('������Կ����Ϊ�գ�', 'Error', MB_OK + MB_ICONSTOP);
    EdtMakeKey.SetFocus;
    Exit;
  end;
  if Length(EdtMakeKey.Text) <> 100 then begin
    Application.MessageBox('��Կ����ȷ��', 'Error', MB_OK + MB_ICONSTOP);
    EdtMakeKey.SetFocus;
    Exit;
  end;
  if GetTickCount - dwMakeTick < 5000 then begin
     Application.MessageBox('��������죬���Ժ������', 'Error', MB_OK +
        MB_ICONWARNING);
     Exit;
  end;
  dwMakeTick := GetTickCount();
  MakeType := 0;
  FrmMain.SendCheckMakeKeyAndDayMakeNum(Trim(EdtMakeKey.Text));
  BtnMakeLogin.Enabled := False;
  BtnMakeGate.Enabled := False;
end;

procedure TFrmMakeLogin.UpFile;
  function GetFileSize(const FileName: String): LongInt;
  var SearchRec: TSearchRec;
  begin
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
     Result := SearchRec.Size
    else
     Result := -1;
  end;
var
  boUpFileOK: Boolean;
  sSendData: string;
  sLoginName: string;
  sClientFileName: string;
 // sLocalGameListName: string;
  sboLoginMainImages: string;
  sboAssistantFilter: string;
  sServerAdd: string;
  sFtpUser: string;
  sFtpPass: string;
begin
  boUpFileOK := True;
  sboLoginMainImages := '0';
  sboAssistantFilter := '0';
  sLoginName := Trim(EdtLoginName.Text);
  sClientFileName := Trim(EdtClientFileName.Text);

  if (EdtAssistantFilter.Text <> '') or (EdtLoginMainImages.Text <> '') then begin
    Decode(g_sFtpServerAdd, sServerAdd);
    Decode(g_sFtpUser, sFtpUser);
    Decode(g_sFtpPass, sFtpPass);
    IdFTP1.Host := sServerAdd;
    IdFTP1.Username := sFtpUser;
    IdFTP1.Password := sFtpPass;
    IdFTP1.Port := 21;
    try
      IdFTP1.Connect;
    except
       Application.MessageBox('���ӷ�������������ϵ��������� Code=1',
         'Error', MB_OK + MB_ICONSTOP);
       boUpFileOK := False;
    end;
    if EdtAssistantFilter.Text <> '' then begin
      if CompareText(ExtractFileExt(EdtAssistantFilter.Text), '.Txt') = 0 then begin
        if GetFileSize(EdtAssistantFilter.Text) <= 25600 then begin
          if IdFTP1.Connected then begin
            IdFTP1.TransferType := ftBinary;
            try
              IdFTP1.Put(EdtAssistantFilter.Text,g_MySelf.sAccount+'_FilterItemList.txt');
              sboAssistantFilter := '1';
            except
              Application.MessageBox('�����ļ�����������ʧ�ܣ����Ժ����ԣ�', 'Error',
                MB_OK + MB_ICONSTOP);
              boUpFileOK := False;
            end;
          end;
        end else begin
          Application.MessageBox('�ڹҹ����ļ���С����С��25KB��', 'Error',
            MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
        end;
      end else begin
          Application.MessageBox('�����ļ���չ������ΪTXT��', 'Error',
            MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
      end;
    end;
    if (EdtLoginMainImages.Text <> '') and boUpFileOK then begin
      if CompareText(ExtractFileExt(EdtLoginMainImages.Text), '.Jpg') = 0 then begin
        if GetFileSize(EdtLoginMainImages.Text) <= 204800 then begin
          if IdFTP1.Connected then begin
            //IdFTP1.TransferType := ftBinary;
            try
              IdFTP1.Put(EdtLoginMainImages.Text,g_MySelf.sAccount+'_LoginMain.Jpg');
              sboLoginMainImages := '1';
            except
              Application.MessageBox('�����ļ�����������ʧ�ܣ����Ժ����ԣ�', 'Error',
                MB_OK + MB_ICONSTOP);
              boUpFileOK := False;
            end;
          end;
        end else begin
          Application.MessageBox('��½������ͼ�ļ���С����С��200KB��', 'Error',
            MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
        end;
      end else begin
          Application.MessageBox('��½������ͼ�ļ���չ������ΪJpg��', 'Error',
            MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
      end;
    end;
    if IdFTP1.Connected then begin
      IdFTP1.Quit;
    end;
  end;
  if boUpFileOK then begin
    //����
    if (sLoginName <> '') and (sClientFileName <> '') and (sboLoginMainImages <> '') and (sboAssistantFilter <> '') then begin
      sSendData := sLoginName + '/' + sClientFileName + '/' + IntToStr(RzRadioGroupMainImages.ItemIndex) + '/' + sboLoginMainImages + '/' + sboAssistantFilter;
      FrmMain.SendMakeLogin(sSendData);
    end;
  end else begin
    BtnMakeLogin.Enabled := True;
    BtnMakeGate.Enabled := True;
  end;
end;

procedure TFrmMakeLogin.IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  ProgressBar1.Position := AWorkCount;  
end;

procedure TFrmMakeLogin.IdFTP1WorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  ProgressBar1.Max := AWorkCountMax;
end;

procedure TFrmMakeLogin.BtnMakeGateClick(Sender: TObject);
begin
  if Trim(EdtMakeKey.Text) = '' then begin
    Application.MessageBox('������Կ����Ϊ�գ�', 'Error', MB_OK + MB_ICONSTOP);
    EdtMakeKey.SetFocus;
    Exit;
  end;
  if Length(EdtMakeKey.Text) <> 100 then begin
    Application.MessageBox('��Կ����ȷ��', 'Error', MB_OK + MB_ICONSTOP);
    EdtMakeKey.SetFocus;
    Exit;
  end;
  if GetTickCount - dwMakeTick < 5000 then begin
     Application.MessageBox('��������죬���Ժ������', 'Error', MB_OK +
        MB_ICONWARNING);
     Exit;
  end;
  dwMakeTick := GetTickCount();
  MakeType := 1;
  FrmMain.SendCheckMakeKeyAndDayMakeNum(Trim(EdtMakeKey.Text));
  BtnMakeLogin.Enabled := False;
  BtnMakeGate.Enabled := False;
end;

procedure TFrmMakeLogin.MakeGate();
begin
  FrmMain.SendMakeGate(Trim(EdtMakeKey.Text));
end;
procedure TFrmMakeLogin.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then begin
    BtnAssistantFilter.Enabled := True;
  end else begin
    BtnAssistantFilter.Enabled := False;
    EdtAssistantFilter.Text := '';
  end;
end;

procedure TFrmMakeLogin.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then begin
    BtnLoginMainImages.Enabled := True;
  end else begin
    BtnLoginMainImages.Enabled := False;
    EdtLoginMainImages.Text := '';
  end;
end;

procedure TFrmMakeLogin.BtnSaveGameListConfigClick(Sender: TObject);
var
  Inifile: TInifile;
  I: Integer;
begin
  Inifile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.ini');
  Inifile.WriteInteger('ServerList','GroupCount',ComboBox1.Items.Count);
  for I:=0 to ComboBox1.Items.Count -1 do begin
   Inifile.WriteString('ServerList','Group'+inttostr(I+1),ComboBox1.Items[I]);
  end;
  Inifile.WriteInteger('ServerList','ListCount',ListView1.Items.Count);
  for I:=0 to ListView1.Items.Count -1 do begin
   Inifile.WriteString('ServerList','ServerArray'+Inttostr(I+1),ListView1.Items.Item[I].Caption);
   Inifile.WriteString('ServerList','ServerName'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[0]);
   Inifile.WriteString('ServerList','ServerIP'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[1]);
   Inifile.WriteString('ServerList','ServerPort'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[2]);
   Inifile.WriteString('ServerList','ServerNoticeURL'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[3]);
   Inifile.WriteString('ServerList','ServerHomeURL'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[4]);
   Inifile.WriteString('ServerList','GameItemsURL'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[5]);
   Inifile.WriteString('ServerList','GatePass'+IntToStr(I+1),ListView1.Items.Item[I].SubItems.Strings[6]);
  end;
   Inifile.Free;
   Application.MessageBox('��Ϸ�б�������Ϣ�ѱ��棡', '��ʾ', MB_OK + 
     MB_ICONINFORMATION);
end;

procedure TFrmMakeLogin.LoadConfig;
var
  Conf: TIniFile;
  sConfigFileName: string;
  I,IEnd:Integer;
  II,IIEnd:Integer;
  ListItem: TListItem;
begin
  sConfigFileName := ExtractFilePath(ParamStr(0)) + 'Config.ini';
  if not FileExists(sConfigFileName) then begin
    ComboBox1.Items.Add('���ŷ�����');
    ComboBox1.Items.Add('��ͨ������');
  end else begin
    Conf := TIniFile.Create(sConfigFileName);
    IEnd:=Conf.ReadInteger('ServerList','GroupCount',0);
    IIEnd:=Conf.ReadInteger('ServerList','ListCount',0);
    ComboBox1.Items.Clear;
    for I:=1 to IEnd do begin
       ComboBox1.Items.Add(Conf.ReadString('ServerList','Group'+InttoStr(I),''));
    end;
    for II:=1 to IIEnd do begin
      ListView1.Items.BeginUpdate;
      try
        ListItem := ListView1.Items.Add;
        ListItem.Caption:=Conf.ReadString('ServerList','ServerArray'+InttoStr(II),'');
        ListItem.SubItems.Add(Conf.ReadString('ServerList','ServerName'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','ServerIP'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','ServerPort'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','ServerNoticeURL'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','ServerHomeURL'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','GameItemsURL'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','GatePass'+InttoStr(II),''));
      finally
          ListView1.Items.EndUpdate;
      end;
    end;
    Conf.Free;
  end;
  ComboBox1.ItemIndex := 0;
end;

end.

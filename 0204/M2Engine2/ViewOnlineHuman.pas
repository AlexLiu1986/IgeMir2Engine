unit ViewOnlineHuman;

interface

uses
  Windows, SysUtils, StrUtils, Classes, Controls, Forms,
  Grids, ExtCtrls, StdCtrls;

type
  TfrmViewOnlineHuman = class(TForm)
    PanelStatus: TPanel;
    GridHuman: TStringGrid;
    Timer: TTimer;
    Panel1: TPanel;
    ButtonRefGrid: TButton;
    Label1: TLabel;
    ComboBoxSort: TComboBox;
    EditSearchName: TEdit;
    ButtonSearch: TButton;
    ButtonView: TButton;
    Button1: TButton;
    ButtonKick: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonRefGridClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBoxSortClick(Sender: TObject);
    procedure GridHumanDblClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    procedure ButtonViewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    ViewList: TStringList;
    dwTimeOutTick: LongWord;
    procedure RefGridSession();
    procedure GetOnlineList();
    procedure SortOnlineList(nSort: Integer);//���������б�
    procedure ShowHumanInfo();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmViewOnlineHuman: TfrmViewOnlineHuman;

implementation

uses UsrEngn, M2Share, ObjBase, HUtil32, HumanInfo;

{$R *.dfm}

{ TfrmViewOnlineHuman }

procedure TfrmViewOnlineHuman.Open;
begin
  frmHumanInfo := TfrmHumanInfo.Create(Owner);
  dwTimeOutTick := GetTickCount();
  GetOnlineList();
  RefGridSession();
  Timer.Enabled := True;
  ShowModal;
  Timer.Enabled := False;
  frmHumanInfo.Free;
end;
//ȡ���������б�
procedure TfrmViewOnlineHuman.GetOnlineList;
var
  I: Integer;
begin
  ViewList.Clear;
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    if UserEngine <> nil then begin
      for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
        ViewList.AddObject(UserEngine.m_PlayObjectList.Strings[I], UserEngine.m_PlayObjectList.Objects[I]);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;
procedure TfrmViewOnlineHuman.RefGridSession;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  PanelStatus.Caption := '����ȡ������...';
  GridHuman.Visible := False;
  GridHuman.Cells[0, 1] := '';
  GridHuman.Cells[1, 1] := '';
  GridHuman.Cells[2, 1] := '';
  GridHuman.Cells[3, 1] := '';
  GridHuman.Cells[4, 1] := '';
  GridHuman.Cells[5, 1] := '';
  GridHuman.Cells[6, 1] := '';
  GridHuman.Cells[7, 1] := '';
  GridHuman.Cells[8, 1] := '';
  GridHuman.Cells[9, 1] := '';
  GridHuman.Cells[10, 1] := '';
  GridHuman.Cells[11, 1] := '';
  GridHuman.Cells[12, 1] := '';
  GridHuman.Cells[13, 1] := '';
  GridHuman.Cells[14, 1] := '';
  GridHuman.Cells[15, 1] := '';
  GridHuman.Cells[16, 1] := '';
  GridHuman.Cells[17, 1] := '';
  GridHuman.Cells[18, 1] := '';
  GridHuman.Cells[19, 1] := '';//20081204
  if ViewList.Count <= 0 then begin
    GridHuman.RowCount := 2;
    GridHuman.FixedRows := 1;
  end else begin
    GridHuman.RowCount := ViewList.Count + 1;
  end;
  for I := 0 to ViewList.Count - 1 do begin
    PlayObject := TPlayObject(ViewList.Objects[I]);
    if PlayObject <> nil then begin
      GridHuman.Cells[0, I + 1] := IntToStr(I);
      GridHuman.Cells[1, I + 1] := PlayObject.m_sCharName;
      GridHuman.Cells[2, I + 1] := IntToSex(PlayObject.m_btGender);
      GridHuman.Cells[3, I + 1] := IntToJob(PlayObject.m_btJob);
      GridHuman.Cells[4, I + 1] := IntToStr(PlayObject.m_Abil.Level);
      GridHuman.Cells[5, I + 1] := IntToStr(PlayObject.m_NGLevel);//�ڹ��ȼ�
      GridHuman.Cells[6, I + 1] := PlayObject.m_sMapName;
      GridHuman.Cells[7, I + 1] := IntToStr(PlayObject.m_nCurrX) + ':' + IntToStr(PlayObject.m_nCurrY);
      GridHuman.Cells[8, I + 1] := PlayObject.m_sUserID;
      GridHuman.Cells[9, I + 1] := PlayObject.m_sIPaddr;
      GridHuman.Cells[10, I + 1] := IntToStr(PlayObject.m_btPermission);
      GridHuman.Cells[11, I + 1] := PlayObject.m_sIPLocal; // GetIPLocal(PlayObject.m_sIPaddr);
      GridHuman.Cells[12, I + 1] := IntToStr(PlayObject.m_nGameGold);
      GridHuman.Cells[13, I + 1] := IntToStr(PlayObject.m_nGamePoint);
      GridHuman.Cells[14, I + 1] := IntToStr(PlayObject.m_nPayMentPoint);
      GridHuman.Cells[15, I + 1] := BooleanToStr(PlayObject.m_boNotOnlineAddExp);
      GridHuman.Cells[16, I + 1] := PlayObject.m_sAutoSendMsg;
      GridHuman.Cells[17, I + 1] := IntToStr(PlayObject.MessageCount);
      GridHuman.Cells[18, I + 1] := IntToStr(PlayObject.m_nGameDiaMond);
      GridHuman.Cells[19, I + 1] := IntToStr(PlayObject.m_nGameGird);
    end;
  end;
  GridHuman.Visible := True;
end;

procedure TfrmViewOnlineHuman.FormCreate(Sender: TObject);
begin
  ViewList := TStringList.Create;
  GridHuman.Cells[0, 0] := '���';
  GridHuman.Cells[1, 0] := '��������';
  GridHuman.Cells[2, 0] := '�Ա�';
  GridHuman.Cells[3, 0] := 'ְҵ';
  GridHuman.Cells[4, 0] := '�ȼ�';
  GridHuman.Cells[5, 0] := '�ڹ��ȼ�';//20081204
  GridHuman.Cells[6, 0] := '��ͼ';
  GridHuman.Cells[7, 0] := '����';
  GridHuman.Cells[8, 0] := '��¼�ʺ�';
  GridHuman.Cells[9, 0] := '��¼IP';
  GridHuman.Cells[10, 0] := 'Ȩ��';
  GridHuman.Cells[11, 0] := '���ڵ���';
  GridHuman.Cells[12, 0] := g_Config.sGameGoldName;
  GridHuman.Cells[13, 0] := g_Config.sGamePointName;
  GridHuman.Cells[14, 0] := g_Config.sPayMentPointName;
  GridHuman.Cells[15, 0] := '���߹һ�';
  GridHuman.Cells[16, 0] := '�Զ��ظ�';
  GridHuman.Cells[17, 0] := 'δ������Ϣ';
  GridHuman.Cells[18, 0] := g_Config.sGameDiaMond; //20071226 ���ʯ
  GridHuman.Cells[19, 0] := g_Config.sGameGird;//20071226 ���
  if UserEngine <> nil then  Caption := Format(' [����������%d]', [UserEngine.PlayObjectCount]);
end;

procedure TfrmViewOnlineHuman.ButtonRefGridClick(Sender: TObject);
begin
  dwTimeOutTick := GetTickCount();
  GetOnlineList();
  RefGridSession();
end;

procedure TfrmViewOnlineHuman.FormDestroy(Sender: TObject);
begin
  ViewList.Free;
  frmViewOnlineHuman:= nil;
end;

procedure TfrmViewOnlineHuman.ComboBoxSortClick(Sender: TObject);
begin
  if ComboBoxSort.ItemIndex < 0 then Exit;
  dwTimeOutTick := GetTickCount();
  GetOnlineList();
  SortOnlineList(ComboBoxSort.ItemIndex);
  RefGridSession();
end;

//�����ִ�С������ĺ��� 20090131
function DescCompareInt(List: TStringList; I1, I2: Integer): Integer;
begin
  I1 := StrToIntDef(List[I1], 0);
  I2 := StrToIntDef(List[I2], 0);
  if I1 > I2 then Result:=-1
  else if I1 < I2 then Result:=1
  else Result:=0;
end;
//�ַ�������  20081024
function StrSort_2(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := 0;
  try
    Result := CompareStr(List[Index1], List[Index2]);
  except
  end;
end;

procedure TfrmViewOnlineHuman.SortOnlineList(nSort: Integer);
var
  I: Integer;
  SortList: TStringList;
begin
  if (ViewList = nil) or (ViewList.Count = 0) then Exit;//20080503
  SortList := TStringList.Create;
  try
    case nSort of
      0: begin
          ViewList.Sort;
          Exit;
        end;
      1: begin
          for I := 0 to ViewList.Count - 1 do begin
            SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_btGender), ViewList.Objects[I]);
          end;
          SortList.CustomSort(DescCompareInt);//����ʱ�����Ǹ����� 20081023 OK
        end;
      2: begin
          for I := 0 to ViewList.Count - 1 do begin
            SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_btJob), ViewList.Objects[I]);
          end;
          SortList.CustomSort(DescCompareInt);//����ʱ�����Ǹ����� 20081023 OK
        end;
      3: begin
          for I := 0 to ViewList.Count - 1 do begin
            SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_Abil.Level), ViewList.Objects[I]);
          end;
          SortList.CustomSort(DescCompareInt);//����ʱ�����Ǹ����� 20081005 OK
        end;
      4: begin
          for I := 0 to ViewList.Count - 1 do begin
            SortList.AddObject(TPlayObject(ViewList.Objects[I]).m_sMapName, ViewList.Objects[I]);
          end;
          SortList.CustomSort(StrSort_2);//�������� 20081024
        end;
      5: begin
          for I := 0 to ViewList.Count - 1 do begin
            SortList.AddObject(TPlayObject(ViewList.Objects[I]).m_sIPaddr, ViewList.Objects[I]);
          end;
          SortList.CustomSort(StrSort_2);//�������� 20081024
        end;
      6: begin
          for I := 0 to ViewList.Count - 1 do begin
            SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_btPermission), ViewList.Objects[I]);
          end;
          SortList.CustomSort(DescCompareInt);//����ʱ�����Ǹ����� 20081005
        end;
      7: begin
          for I := 0 to ViewList.Count - 1 do begin
            SortList.AddObject(TPlayObject(ViewList.Objects[I]).m_sIPLocal, ViewList.Objects[I]);
          end;
          SortList.CustomSort(StrSort_2);//�������� 20081024
        end;
      8: begin//�ǹһ� 20080811
          for I := 0 to ViewList.Count - 1 do begin
            if not TPlayObject(ViewList.Objects[I]).m_boNotOnlineAddExp then begin
              SortList.AddObject(IntToStr(I), ViewList.Objects[I]);
            end;
          end;
        end;//8
      9: begin//Ԫ��
          for I := 0 to ViewList.Count - 1 do begin
            SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_nGameGold), ViewList.Objects[I]);
          end;
          SortList.CustomSort(DescCompareInt);//����ʱ�����Ǹ����� 20080928
        end;//9
      10:begin//�ڹ��ȼ�
          for I := 0 to ViewList.Count - 1 do begin
            SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_NGLevel), ViewList.Objects[I]);
          end;
          SortList.CustomSort(DescCompareInt);//����ʱ�����Ǹ�����
        end;//10
    end;
    //ViewList.Free;
    //ViewList := SortList; //20080503 �޸ĳ���������

    ViewList.Clear;
    for I := 0 to SortList.Count - 1 do begin
      ViewList.AddObject(IntToStr(I), SortList.Objects[I]);
    end;

    ViewList.Sort;
  finally
    SortList.Free;//20080117
  end;
end;

procedure TfrmViewOnlineHuman.GridHumanDblClick(Sender: TObject);
begin
  ShowHumanInfo();
end;

procedure TfrmViewOnlineHuman.TimerTimer(Sender: TObject);
begin
  if (GetTickCount - dwTimeOutTick > 30000) and (ViewList.Count > 0) then begin
    ViewList.Clear;
    RefGridSession();
  end;
end;

procedure TfrmViewOnlineHuman.ButtonSearchClick(Sender: TObject);
var
  I: Integer;
  sHumanName: string;
  PlayObject: TPlayObject;
begin
  sHumanName := Trim(EditSearchName.Text);
  if sHumanName = '' then begin
    Application.MessageBox('������һ���������ƣ�����', '������Ϣ', MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;
  if Sender = ButtonSearch then begin
    for I := 0 to ViewList.Count - 1 do begin
      PlayObject := TPlayObject(ViewList.Objects[I]);
      if CompareText(PlayObject.m_sCharName, sHumanName) = 0 then begin
        GridHuman.Row := I + 1;
        Exit;
      end;
    end;
    Application.MessageBox('����û�����ߣ�����', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if Sender = ButtonKick then begin
    for I := 0 to ViewList.Count - 1 do begin
      PlayObject := TPlayObject(ViewList.Objects[I]);
      if AnsiContainsText(PlayObject.m_sCharName, sHumanName) then begin
        PlayObject.m_boEmergencyClose := True;
        PlayObject.m_boNotOnlineAddExp := False;
        PlayObject.m_boPlayOffLine := False;
      end;
    end;
    dwTimeOutTick := GetTickCount();
    GetOnlineList();
    RefGridSession();
  end;
end;

procedure TfrmViewOnlineHuman.ButtonViewClick(Sender: TObject);
begin
  ShowHumanInfo();
end;

procedure TfrmViewOnlineHuman.ShowHumanInfo;
var
  nSelIndex: Integer;
  sPlayObjectName: string;
  PlayObject: TPlayObject;
begin
  nSelIndex := GridHuman.Row;
  Dec(nSelIndex);
  if (nSelIndex < 0) or (ViewList.Count <= nSelIndex) then begin
    Application.MessageBox('����ѡ��һ��Ҫ�鿴���������', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  sPlayObjectName := GridHuman.Cells[1, nSelIndex + 1];
  PlayObject := UserEngine.GetPlayObject(sPlayObjectName);
  if PlayObject = nil then begin
    Application.MessageBox('�������Ѿ������ߣ�����', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  frmHumanInfo.PlayObject := TPlayObject(ViewList.Objects[nSelIndex]);
  frmHumanInfo.Top := Self.Top + 20;
  frmHumanInfo.Left := Self.Left;
  frmHumanInfo.Open();
end;

procedure TfrmViewOnlineHuman.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
      if TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_boNotOnlineAddExp then begin
        TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_boNotOnlineAddExp := False;
        TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_boPlayOffLine := False;
        TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_boKickFlag := True;//20080815 ����
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  dwTimeOutTick := GetTickCount();
  GetOnlineList();
  RefGridSession();
end;

procedure TfrmViewOnlineHuman.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.


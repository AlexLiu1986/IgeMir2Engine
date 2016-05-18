unit OnLineHum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Main, ExtCtrls;

type
  TFrmOnLineHum = class(TForm)
    GroupBox1: TGroupBox;
    ButtonRef: TButton;
    ButtonKick: TButton;
    ButtonAddTempList: TButton;
    ButtonAddBlockList: TButton;
    ListViewOnLine: TListView;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure ButtonRefClick(Sender: TObject);
    procedure ListViewOnLineClick(Sender: TObject);
    procedure ButtonKickClick(Sender: TObject);
    procedure ButtonAddTempListClick(Sender: TObject);
    procedure ButtonAddBlockListClick(Sender: TObject);
  private
    { Private declarations }
    procedure RefOnlineHum();
    procedure RefReceiveLength();
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmOnLineHum: TFrmOnLineHum;
  sSelIPaddr: string;
implementation
uses GateShare;
{$R *.dfm}

function GetReceiveLength(SocketHandle: THandle): Integer;
var
  i: Integer;
  UserSession: pTSessionInfo;
begin
  Result := 0;
  for i := 0 to GATEMAXSESSION - 1 do begin
    UserSession := @SessionArray[i];
    if UserSession.Socket <> nil then begin
      if UserSession.nSckHandle = SocketHandle then begin
        Result := UserSession.nReceiveLength;
        Break;
      end;
    end;
  end;
end;

procedure TFrmOnLineHum.RefReceiveLength();
var
  ListItem: TListItem;
  nIndex: Integer;
  nSckHandle: Integer;
  sIPaddr: string;
begin
  for nIndex := 0 to ListViewOnLine.Items.Count - 1 do begin
    ListItem := ListViewOnLine.Items.Item[nIndex];
    sIPaddr := ListItem.SubItems.Strings[0];
    nSckHandle := StrToInt(ListItem.SubItems.Strings[1]);
    ListItem.SubItems.Strings[2] := IntToStr(GetReceiveLength(nSckHandle));
    ListItem.SubItems.Strings[3] := Format('%d/%d', [FrmMain.GetAttackIPCount(sIPaddr), FrmMain.GetConnectCountOfIP(sIPaddr)]);
  end;
end;

procedure TFrmOnLineHum.RefOnlineHum();
var
  i: Integer;
  sIPaddr: string;
  ListItem: TListItem;
  nIndex: Integer;
  nSckHandle: Integer;
begin
  if FrmMain.ServerSocket.Active then begin
    nIndex := 0;
    ListViewOnLine.Items.Clear;
    for i := 0 to FrmMain.ServerSocket.Socket.ActiveConnections - 1 do begin
      sIPaddr := FrmMain.ServerSocket.Socket.Connections[i].RemoteAddress;
      nSckHandle := FrmMain.ServerSocket.Socket.Connections[i].SocketHandle;
      if sIPaddr <> '' then begin
        ListViewOnLine.Items.BeginUpdate;
        try
          ListItem := ListViewOnLine.Items.Add;
          ListItem.Caption := IntToStr(nIndex);
          ListItem.SubItems.Add(sIPaddr);
          ListItem.SubItems.Add(IntToStr(nSckHandle));
          ListItem.SubItems.Add(IntToStr(GetReceiveLength(nSckHandle)));
          ListItem.SubItems.Add(Format('%d/%d', [FrmMain.GetAttackIPCount(sIPaddr), FrmMain.GetConnectCountOfIP(sIPaddr)]));
          Inc(nIndex);
        finally
          ListViewOnLine.Items.EndUpdate;
        end;
      end;
    end;
  end;
end;

procedure TFrmOnLineHum.Open();
begin
  RefOnlineHum();
  ButtonAddTempList.Enabled := False;
  ButtonAddBlockList.Enabled := False;
  Caption := Caption + ' [' + IntToStr(ListViewOnLine.Items.Count) + ']';
  ShowModal;
end;

procedure TFrmOnLineHum.Timer1Timer(Sender: TObject);
begin
  RefReceiveLength();
end;

procedure TFrmOnLineHum.ButtonRefClick(Sender: TObject);
begin
  RefOnlineHum();
end;

procedure TFrmOnLineHum.ListViewOnLineClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  try
    ListItem := ListViewOnLine.Selected;
    sSelIPaddr := ListItem.SubItems.Strings[0];
    ButtonKick.Enabled := True;
    ButtonAddTempList.Enabled := True;
    ButtonAddBlockList.Enabled := True;
  except
    sSelIPaddr := '';
    ButtonKick.Enabled := False;
    ButtonAddTempList.Enabled := False;
    ButtonAddBlockList.Enabled := False;
  end;
end;

procedure TFrmOnLineHum.ButtonKickClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('�Ƿ�ȷ�Ͻ������ӶϿ���'),
    PChar('ȷ����Ϣ - ' + sSelIPaddr), MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;

  ButtonKick.Enabled := False;
  FrmMain.CloseConnect(sSelIPaddr);
  RefOnlineHum();
  ButtonKick.Enabled := True;
end;

procedure TFrmOnLineHum.ButtonAddTempListClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('�Ƿ�ȷ�Ͻ���IP���붯̬�����б��У���������б�󣬴�IP�������������ӽ���ǿ���жϡ�'),
    PChar('ȷ����Ϣ - ' + sSelIPaddr),
    MB_OKCANCEL + MB_ICONQUESTION
    ) <> IDOK then Exit;
  FrmMain.AddTempBlockIP(sSelIPaddr,SearchIPLocal(sSelIPaddr));
end;

procedure TFrmOnLineHum.ButtonAddBlockListClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('�Ƿ�ȷ�Ͻ���IP�������ù����б��У���������б�󣬴�IP�������������ӽ���ǿ���жϡ�'),
    PChar('ȷ����Ϣ - ' + sSelIPaddr),
    MB_OKCANCEL + MB_ICONQUESTION
    ) <> IDOK then Exit;
  FrmMain.AddBlockIP(sSelIPaddr, SearchIPLocal(sSelIPaddr));
end;

end.


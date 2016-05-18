unit RouteManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmRouteManage = class(TForm)
    GroupBox1: TGroupBox;
    ListViewRoute: TListView;
    ButtonEdit: TButton;
    ButtonDelete: TButton;
    ButtonOK: TButton;
    ButtonAddRoute: TButton;
    procedure ButtonDeleteClick(Sender: TObject);
  private
    procedure RefShowRoute();
    procedure ProcessListViewDelete();
    procedure ProcessListViewSelect();
    procedure ProcessAddRoute();
    procedure ProcessEditRoute();
    procedure SaveAddrconfig; //������������ 20080427
    { Private declarations }
  public
    procedure Open;
    { Public declarations }
  end;

var
  frmRouteManage: TfrmRouteManage;

implementation

uses DBShare, RouteEdit;

{$R *.dfm}

{ TfrmRouteManage }

procedure TfrmRouteManage.Open;
begin
  RefShowRoute();

  ShowModal;
end;

procedure TfrmRouteManage.RefShowRoute;
var
  i, ii: Integer;
  ListItem: TListItem;
  RouteInfo: pTRouteInfo;
  sGameGate: string;
begin
  ListViewRoute.Clear;
  ButtonEdit.Enabled := False;
  ButtonDelete.Enabled := False;
  for i := Low(g_RouteInfo) to High(g_RouteInfo) do begin
    RouteInfo := @g_RouteInfo[i];
    if RouteInfo.nGateCount = 0 then break;
    sGameGate := '';
    ListItem := ListViewRoute.Items.Add;
    ListItem.Data := RouteInfo;
    ListItem.Caption := IntToStr(i);
    ListItem.SubItems.Add(RouteInfo.sSelGateIP);
    ListItem.SubItems.Add(IntToStr(RouteInfo.nGateCount));
    for ii := 0 to RouteInfo.nGateCount - 1 do begin
      sGameGate := format('%s %s:%d ', [sGameGate, RouteInfo.sGameGateIP[ii], RouteInfo.nGameGatePort[ii]]);
    end;
    ListItem.SubItems.Add(sGameGate);
  end;

end;

procedure TfrmRouteManage.ButtonDeleteClick(Sender: TObject);
begin
  if Sender = ButtonDelete then begin
    ProcessListViewDelete();
  end else
    if Sender = ListViewRoute then begin
    ProcessListViewSelect();
  end else
    if Sender = ButtonAddRoute then begin
    ProcessAddRoute();
  end else
    if Sender = ButtonEdit then begin
    ProcessEditRoute();
  end else
    if Sender = ButtonOK then begin //20080427 ������������
      SaveAddrconfig;
  end;

end;
//������������ 20080427
procedure TfrmRouteManage.SaveAddrconfig;
var
  i, ii: Integer;
  SaveList: TStringList;
  s14: string;
  RouteInfo: pTRouteInfo;
begin
  SaveList := TStringList.Create;
  for i := 0 to ListViewRoute.Items.Count - 1 do begin
    RouteInfo := @g_RouteInfo[I];
    s14 := RouteInfo.sSelGateIP;//Selgeat IP
    for II:=0 to RouteInfo.nGateCount - 1 do begin
      s14 := S14+' '+RouteInfo.sGameGateIP[I]+' '+IntToStr(RouteInfo.nGameGatePort[I])+' ';
    end;
    SaveList.Add(s14);
  end;
  try
    SaveList.SaveToFile(sGateConfFileName);
  except
    if boViewHackMsg then MainOutMessage('[�쳣] '+ sGateConfFileName + ' �����쳣������');
  end;
end;

procedure TfrmRouteManage.ProcessListViewSelect;
var
  ListItem: TListItem;
begin
  ListItem := ListViewRoute.Selected;
  if ListItem = nil then Exit;
  ButtonEdit.Enabled := True;
  ButtonDelete.Enabled := True;
end;

procedure TfrmRouteManage.ProcessListViewDelete;
var
  ii: Integer;
  ListItem: TListItem;
  RouteInfo: pTRouteInfo;
begin
  ListItem := ListViewRoute.Selected;
  if ListItem = nil then Exit;
  RouteInfo := ListItem.Data;
  RouteInfo.nGateCount := 0;
  RouteInfo.sSelGateIP := '';

  for ii := Low(RouteInfo.sGameGateIP) to High(RouteInfo.sGameGateIP) do begin
    RouteInfo.sGameGateIP[ii] := '';
    RouteInfo.nGameGatePort[ii] := 0;
  end;
  RefShowRoute();

end;

procedure TfrmRouteManage.ProcessAddRoute;
var
//  ListItem: TListItem;
  RouteInfo: pTRouteInfo;
  nNulIdx: Integer;
  AddRoute: TRouteInfo;
begin
  nNulIdx := ListViewRoute.Items.Count;
  if nNulIdx >= 20 then begin
    MessageBox(Handle, '·�������Ѿ��ﵽָ������,����������·�ɣ�����', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  RouteInfo := @g_RouteInfo[nNulIdx];
  frmRouteEdit.m_RouteInfo := RouteInfo^;
  frmRouteEdit.Caption := '��������·��';
  AddRoute := frmRouteEdit.Open;
  if AddRoute.nGateCount >= 1 then begin
    RouteInfo^ := AddRoute;
  end;
  RefShowRoute();
end;

procedure TfrmRouteManage.ProcessEditRoute;
var
  ListItem: TListItem;
  RouteInfo: pTRouteInfo;
  EditRoute: TRouteInfo;
begin
  ListItem := ListViewRoute.Selected;
  if ListItem = nil then Exit;
  RouteInfo := ListItem.Data;
  frmRouteEdit.m_RouteInfo := RouteInfo^;
  frmRouteEdit.Caption := '��������·��';
  EditRoute := frmRouteEdit.Open;
  if EditRoute.nGateCount >= 1 then begin
    RouteInfo^ := EditRoute;
  end;
  RefShowRoute();

end;

end.

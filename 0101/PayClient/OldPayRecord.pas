unit OldPayRecord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, Clipbrd;

type
  TFrmOldPayRecord = class(TForm)
    GroupBox1: TGroupBox;
    ListViewLog: TListView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    A1: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmOldPayRecord: TFrmOldPayRecord;

implementation
uses Share;
{$R *.dfm}

{ TFrmOldPayRecord }

procedure TFrmOldPayRecord.Open;
var
  sLineText: string;
  sPayUser: string; //点卡用户
  sMoney: string;//花销金额
  sTime: string; //购买时间
  sServerName: string; //服务器名
  sOnlyID: string; //充值的标实ID
  sFileName: string; //记录文件名
  LoadList: TStringList;
  ListView: TListItem;
  I: Integer;
begin
  ListViewLog.Clear;
  sFileName := '56Log.txt';
  if FileExists(ExtractFilePath(ParamStr(0))+sFileName) then begin
  LoadList := TStringList.Create();
  LoadList.LoadFromFile(ExtractFilePath(ParamStr(0))+sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if sLineText <> '' then begin
      sLineText := GetValidStr3(sLineText, sPayUser, ['|']);
      sLineText := GetValidStr3(sLineText, sMoney, ['|']);
      sLineText := GetValidStr3(sLineText, sServerName, ['|']);
      sLineText := GetValidStr3(sLineText, sTime, ['|']);
      sLineText := GetValidStr3(sLineText, sOnlyID, ['|']);
      if (sPayUser <> '') and (sMoney <> '') and (sServerName <> '') and (sTime <> '') and (sOnlyID <> '') then begin
        ListViewLog.Items.BeginUpdate;
        try
          ListView := ListViewLog.Items.Add;
          ListView.Caption := sPayUser;
          ListView.SubItems.Add(sServerName);
          ListView.SubItems.Add(sMoney);
          ListView.SubItems.Add(sTime);
          ListView.SubItems.Add(sOnlyID);
        finally
          ListViewLog.Items.EndUpdate;
        end;
      end;
    end;
  end;
  LoadList.Free;
  end;
  ShowModal;
end;

procedure TFrmOldPayRecord.N1Click(Sender: TObject);
var
  ListItem :TListItem;
  str :string;
begin
  ListItem := ListViewLog.Selected;
  while(ListItem <> nil) do begin
      str := str + ListItem.Caption + ' ' + ListItem.SubItems.Strings[0] + ' ' +
      ListItem.SubItems.Strings[1] + ' ' + ListItem.SubItems.Strings[2] + ' ' +
      ListItem.SubItems.Strings[3]+ #13 + #10;

      ListItem := ListViewLog.GetNextItem(ListItem,   sdAll,   [isSelected]);
  end;
  Clipbrd.Clipboard.AsText := str ;
end;

procedure TFrmOldPayRecord.A1Click(Sender: TObject);
begin
  ListViewLog.SelectAll;
end;

end.

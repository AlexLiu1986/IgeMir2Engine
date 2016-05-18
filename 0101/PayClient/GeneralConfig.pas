unit GeneralConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, JSocket, IniFiles;

type
  TFrmGeneralConfig = class(TForm)
    GroupBox1: TGroupBox;
    ListViewServer: TListView;
    BtnAddServer: TButton;
    BtnDelServer: TButton;
    ClientSocket: TClientSocket;
    Timer1: TTimer;
    procedure BtnAddServerClick(Sender: TObject);
    procedure BtnDelServerClick(Sender: TObject);
    procedure ListViewServerClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmGeneralConfig: TFrmGeneralConfig;
  boSendOk: Boolean;
  dwSendOKTick: LongWord;
implementation

uses AddServer, Share;

{$R *.dfm}

{ TFrmGeneralConfig }

procedure TFrmGeneralConfig.Open;
var
  sLineText: string;
  I: Integer;
  sServerName: string;
  sNpc: string;
  Conf: TIniFile;
  ListItem: TListItem;
begin
  boSendOk := True;
  Timer1.Enabled := True;
  BtnDelServer.Enabled := False;
  ListViewServer.Items.Clear;
  Conf := TIniFile.Create('.\Config.ini');
  for I:=0 to 99 do begin
      sLineText := Conf.ReadString('Game','Server'+InttoStr(I),'');
      if sLineText <> '' then begin
        sLineText := GetValidStr3(sLineText, sServerName, ['|']);
        sLineText := GetValidStr3(sLineText, sNpc, ['|']);
        if (sServerName <> '') and (sNpc<>'') then begin
          ListViewServer.Items.BeginUpdate;
          try
            ListItem := ListViewServer.Items.Add;
            ListItem.Caption:= IntToStr(I);
            ListItem.SubItems.Add(sServerName);
            ListItem.SubItems.Add(sNpc);
          finally
              ListViewServer.Items.EndUpdate;
          end;
        end;
      end;
  end;
  Conf.Free;
  ShowModal;
end;

procedure TFrmGeneralConfig.BtnAddServerClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  ClientSocket.Active := False;
  FrmAddServer.Open;
end;

procedure TFrmGeneralConfig.BtnDelServerClick(Sender: TObject);
begin
  if not ClientSocket.Active and not ClientSocket.Socket.Connected then begin
     Application.MessageBox('正在连接短信平台，请稍等几秒在点击！！！', '提示', MB_OK + MB_ICONASTERISK);
     Exit;
  end;
  ClientSocket.Socket.SendText(PChar(Utf8Encode('userverdel|' + ListViewServer.Items.Item[ListViewServer.ItemIndex].SubItems.Strings[0] + '|' + ListViewServer.Items.Item[ListViewServer.ItemIndex].SubItems.Strings[1] + '|' + sMyUser + '|' + sMyPass)));
  boSendOk := False;
  dwSendOKTick := GetTickCount;
end;

procedure TFrmGeneralConfig.ListViewServerClick(Sender: TObject);
begin
  if ListViewServer.Items.Item[ListViewServer.ItemIndex] = nil then
    BtnDelServer.Enabled := False
  else
    BtnDelServer.Enabled := True;
end;

procedure TFrmGeneralConfig.Timer1Timer(Sender: TObject);
begin
  if (ClientSocket.Address <> '') and not (ClientSocket.Active) then
  ClientSocket.Active := True;
  if not boSendOk then begin //没有发送成功
     if GetTickCount - dwSendOKTick > 10000 then begin  //如果没发成功 10秒后循环发送
       ClientSocket.Socket.SendText(PChar(Utf8Encode('userverdel|' + ListViewServer.Items.Item[ListViewServer.ItemIndex].SubItems.Strings[0] + '|' + ListViewServer.Items.Item[ListViewServer.ItemIndex].SubItems.Strings[1] + '|' + sMyUser + '|1')));
     end;
  end;
end;

procedure TFrmGeneralConfig.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sLineText: string;
  Conf: TIniFile;
  I: Integer;
  sServerName: string;
  sNpc: string;
  ListItem: TListItem;
begin
  if Socket.RemoteAddress <> ServerAddr then Exit; //不是服务器IP
  sLineText := Utf8Decode(Socket.ReceiveText);
  if sLineText = 'ok' then begin
    Conf := TIniFile.Create('.\Config.ini');
    Conf.EraseSection('Game');   //删除一个小节
    ListViewServer.Items.BeginUpdate;
    try
      ListViewServer.DeleteSelected;
    finally
      ListViewServer.Items.EndUpdate;
    end;
    for I:=0 to ListViewServer.Items.Count -1  do begin
      Conf.WriteString('Game','Server'+IntToStr(I), FrmGeneralConfig.ListViewServer.Items.Item[i].SubItems.Strings[0]+'|'+FrmGeneralConfig.ListViewServer.Items.Item[i].SubItems.Strings[1]+'|');
    end;
    boSendOk := True;
    ListViewServer.Items.Clear;
    for I:=0 to 99 do begin
      sLineText := Conf.ReadString('Game','Server'+InttoStr(I),'');
      if sLineText <> '' then begin
        sLineText := GetValidStr3(sLineText, sServerName, ['|']);
        sLineText := GetValidStr3(sLineText, sNpc, ['|']);
        if (sServerName <> '') and (sNpc<>'') then begin
          ListViewServer.Items.BeginUpdate;
          try
            ListItem := ListViewServer.Items.Add;
            ListItem.Caption:= IntToStr(I);
            ListItem.SubItems.Add(sServerName);
            ListItem.SubItems.Add(sNpc);
          finally
              ListViewServer.Items.EndUpdate;
          end;
        end;
      end;
    end;
    Conf.Free;
    Application.MessageBox('分区删除成功！！！', '提示', MB_OK + MB_ICONASTERISK);
  end;
  Socket.Close;
end;

procedure TFrmGeneralConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled := False;
end;

end.

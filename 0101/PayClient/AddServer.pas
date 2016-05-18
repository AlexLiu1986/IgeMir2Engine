unit AddServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, RzBtnEdt, ComCtrls, JSocket, ExtCtrls, IniFiles;

type
  TFrmAddServer = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EdtServerName: TEdit;
    BtnAddServer: TButton;
    Label2: TLabel;
    EdtNpc: TRzButtonEdit;
    ClientSocket: TClientSocket;
    Timer1: TTimer;
    procedure BtnAddServerClick(Sender: TObject);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtNpcButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmAddServer: TFrmAddServer;
  boSendOk: Boolean;
  dwSendOKTick: LongWord;
implementation

uses GeneralConfig, Main, Share;

{$R *.dfm}

{ TFrmAddServer }

procedure TFrmAddServer.Open;
begin
  boSendOk := True;
  Timer1.Enabled := True;
  ShowModal();
end;

procedure TFrmAddServer.BtnAddServerClick(Sender: TObject);
begin
  if not ClientSocket.Active and not ClientSocket.Socket.Connected then begin
     Application.MessageBox('正在连接短信平台，请稍等几秒在点击！！！', '提示', MB_OK + MB_ICONASTERISK);
     Exit;
  end;
  if EdtServerName.Text = '' then begin
    Application.MessageBox('请添写服务器名！！！', '错误信息', MB_OK + MB_ICONERROR);
    EdtServerName.SetFocus;
    Exit;
  end;
  if EdtNpc.Text = '' then begin
    Application.MessageBox('请选择分区路径！！！', '错误信息', MB_OK + MB_ICONERROR);
    EdtNpc.SetFocus;
    Exit;
  end;
  ClientSocket.Socket.SendText(PChar(Utf8Encode('userveradd|' + EdtServerName.Text + '|' + EdtNpc.Text + '|' + sMyUser + '|'+ sMyPass)));
  boSendOk := False;
  dwSendOKTick := GetTickCount;
end;

procedure TFrmAddServer.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sLineText: string;
  ListView: TListItem;
  Conf: TIniFile;
  I: Integer;
begin
  if Socket.RemoteAddress <> ServerAddr then Exit; //不是服务器IP
  sLineText := Utf8Decode(Socket.ReceiveText);
  if sLineText = 'ok' then begin
    with FrmGeneralConfig do begin
      ListViewServer.Items.BeginUpdate;
      try
        ListView := ListViewServer.Items.Add;
        ListView.Caption := IntToStr(ListViewServer.Items.Count);
        ListView.SubItems.Add(FrmAddServer.EdtServerName.Text);
        ListView.SubItems.Add(FrmAddServer.EdtNpc.Text);
      finally
        ListViewServer.Items.EndUpdate;
      end;
    end;
    boSendOk := True;
    Conf := TIniFile.Create('.\Config.ini');
    for I:=0 to FrmGeneralConfig.ListViewServer.Items.Count -1 do begin
      Conf.WriteString('Game', 'Server'+IntToStr(I), FrmGeneralConfig.ListViewServer.Items.Item[i].SubItems.Strings[0]+'|'+FrmGeneralConfig.ListViewServer.Items.Item[i].SubItems.Strings[1]+'|');
    end;
    Conf.Free;
    Application.MessageBox('分区添加成功！！！', '提示', MB_OK + MB_ICONASTERISK);
    Close;
  end;
  Socket.Close;
end;

procedure TFrmAddServer.Timer1Timer(Sender: TObject);
begin
  if (ClientSocket.Address <> '') and not (ClientSocket.Active) then
  ClientSocket.Active := True;
  if not boSendOk then begin //没有发送成功
     if GetTickCount - dwSendOKTick > 10000 then begin  //如果没发成功 10秒后循环发送
       ClientSocket.Socket.SendText(PChar(Utf8Encode('userveradd|' + EdtServerName.Text + '|' + EdtNpc.Text + '|' + sMyUser + '|1')));
     end;
  end;
end;

procedure TFrmAddServer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled := False;
  FrmGeneralConfig.Timer1.Enabled := True;
end;

procedure TFrmAddServer.EdtNpcButtonClick(Sender: TObject);
  //检查是否传奇服务端目录
  function CheckMirServerDir(DirName: string): Boolean;
  begin
    if (not DirectoryExists(DirName + 'Mir200')) or
      (not DirectoryExists(DirName + 'Mud2')) or
      (not DirectoryExists(DirName + 'DBServer')) or
      (not FileExists(DirName + 'Mir200\M2Server.exe')) then
      Result := FALSE else Result := True;
  end;
var
  dir: string;
begin
  if SelectDirectory('选择你分区的服务端目录'+#13+'例：X:\MirServer\', '选择目录', Dir, Handle) then begin
     EdtNpc.Text := Dir + '\';
     if not CheckMirServerDir(EdtNpc.Text) then begin
       Application.MessageBox('你选择的服务端目录是错的或这个文件夹不是传奇服务端文件夹'+#13+'提示：选择服务端的总目录就可以'+#13+'例子：X:\MirServer\', '提示', MB_OK + MB_ICONASTERISK);
       EdtNpc.Text:='';
       Exit;
     end;
  end;
end;

end.

unit Patch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImageButton, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, wininet,
  StdCtrls, ComCtrls, RzPrgres, RzTabs, VCLUnZip, VCLZip, RzPanel, GameLoginShare;

type
  TPatchFrm = class(TForm)
    Image1: TImage;
    CloseBtn: TImageButton;
    IdHTTP1: TIdHTTP;
    Memo1: TMemo;
    ListView1: TListView;
    RzProgressBar1: TRzProgressBar;
    RzProgressBar2: TRzProgressBar;
    Timer1: TTimer;
    VCLZip1: TVCLZip;
    Label1: TLabel;
    CloseTimer: TTimer;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
      procedure LoadPatchList();
      procedure AnalysisFile();
      function DownLoadFile(sURL,sFName: string): boolean;
      function ExtractFileFromZip(const DesPathName,ZipFileName: string): Boolean;
      procedure open();
  end;
var
 PatchFrm: TPatchFrm;
 CanBreak:Boolean;
 {$if Version = 0}
 GameListURL: pchar ='http://127.0.0.1/QKServerList.txt';
 PatchListURL: pchar ='http://127.0.0.1/QKPatchList.txt';
 {$ifend}
implementation
uses HUtil32, md5, Main;

{$R *.dfm}

procedure PatchSelf(aFileName:string);
var
  F:TextFile;
begin
  AssignFile(F,'PatchSelf.bat');
  Rewrite(F);
  WriteLn(F,'ping -n 10 127.1 >nul 2>nul');//��ʱ 10��
  WriteLn(F,'ren '+ExtractFileName(Paramstr(0))+' '+ExtractFileName(Paramstr(0))+'bak');
  WriteLn(F,'ren '+aFileName+' '+ExtractFileName(Paramstr(0)));
  WriteLn(F,ExtractFileName(Paramstr(0)));
  WriteLn(F,'del '+ExtractFileName(Paramstr(0))+'bak');
  WriteLn(F,'del %0');
  CloseFile(F);
  WinExec('PatchSelf.bat',SW_HIDE);//
end;

function AppPath: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

Function CheckUrl(url:string):boolean;
var
  hSession, hfile: hInternet;
  dwindex,dwcodelen :dword;
  dwcode:array[1..20] of char;
  res : pchar;
begin
    if pos('http://',lowercase(url))=0 then
       url := 'http://'+url;
    Result := false;
    hSession := InternetOpen('InetURL:/1.0',
         INTERNET_OPEN_TYPE_PRECONFIG,nil, nil, 0);
    if assigned(hsession) then
      begin
        hfile := InternetOpenUrl( 
             hsession,
             pchar(url), 
             nil, 
             0,
             INTERNET_FLAG_RELOAD, 
             0);
        dwIndex  := 0;
        dwCodeLen := 10;
        HttpQueryInfo(hfile, HTTP_QUERY_STATUS_CODE,
                @dwcode, dwcodeLen, dwIndex);
        res := pchar(@dwcode);
        result:= (res ='200') or (res ='302');
        if assigned(hfile) then
          InternetCloseHandle(hfile);
        InternetCloseHandle(hsession);
      end; 
end;

function TPatchFrm.DownLoadFile(sURL,sFName: string): boolean;
var //�����ļ�
  tStream: TMemoryStream;
begin
  tStream := TMemoryStream.Create;
 if CheckUrl(sURL) then  //�ж�URL�Ƿ���Ч
 begin
  try //��ֹ����Ԥ�ϴ�����
      if CanBreak then exit;
      IdHTTP1.Get(PChar(sURL),tStream); //���浽�ڴ���
      tStream.SaveToFile(PChar(sFName)); //����Ϊ�ļ�
      Result := True;
  except //��ķ�������ִ�еĴ���
    Result := False;
    tStream.Free;
  end;
 end
 else
 begin
  Result := False;
  tStream.Free;
 end;
end;

procedure TPatchFrm.LoadPatchList();
var
  I: Integer;
  sFileName, sLineText: string;
  LoadList: Classes.TStringList;
  LoadList1: Classes.TStringList;
  PatchInfo: pTPatchInfo;
  sPatchType, sPatchFileDir, sPatchName, sPatchMd5, sPatchDownAddress: string;
begin
  g_PatchList := Classes.TList.Create();
  sFileName := '.\QKPatchList.txt';
  if not FileExists(sFileName) then begin
    //Application.MessageBox();   //�б��ļ�������
  end;
  g_PatchList.Clear;
  LoadList := Classes.TStringList.Create();
  LoadList1 := Classes.TStringList.Create();
  LoadList1.LoadFromFile(sFileName);
  LoadList.Text := (decrypt(Trim(LoadList1.Text),CertKey('?-W��')));
  LoadList1.Free;
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sPatchType, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPatchFileDir, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPatchName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPatchMd5, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPatchDownAddress, [' ', #9]);
      if (sPatchType <> '') and (sPatchFileDir <> '') and (sPatchMd5 <> '') then begin
          New(PatchInfo);
          PatchInfo.PatchType := strtoint(sPatchType);
          PatchInfo.PatchFileDir := sPatchFileDir;
          PatchInfo.PatchName := sPatchName;
          PatchInfo.PatchMd5 := sPatchMd5;
          PatchInfo.PatchDownAddress := sPatchDownAddress;
          g_PatchList.Add(PatchInfo);
      end;
    end;
  end;
  //Dispose(PatchInfo);
  LoadList.Free;
  AnalysisFile();  //��ʱ
end;



procedure TPatchFrm.AnalysisFile();
var
  I,II: Integer;
  PatchInfo: pTPatchInfo;
  sTmpMd5 :string;
  ListItem: TListItem;
begin
{-------------------------------------------}
  Label1.Caption := '���������ļ�...';
  if Not Fileexists(AppPath + UpDateFile) then begin
    memo1.Lines.Clear;
    memo1.Lines.SaveToFile(AppPath + UpDateFile);
  end;
  memo1.Lines.LoadFromFile(AppPath + UpDateFile);
  for II := 0 to memo1.Lines.Count -1 do begin
    sTmpMd5 := memo1.Lines[II];
    for I := 0 to g_PatchList.Count - 1 do
    begin
       PatchInfo := pTPatchInfo(g_PatchList.Items[I]);
      if PatchInfo.PatchMd5 = sTmpMd5 then
        PatchInfo.PatchMd5 := '';
    end;
  end;
  
  try
     for I := 0 to g_PatchList.Count - 1 do
     begin
       PatchInfo := pTPatchInfo(g_PatchList.Items[I]);
       if PatchInfo.PatchMd5 <> '' then
       begin
          ListItem := ListView1.Items.Add;
          ListItem.Checked := True;
          //��������ļ���
          ListItem.Caption := inttostr(PatchInfo.PatchType);
          //��������ļ���С
          ListItem.SubItems.Add(PatchInfo.PatchFileDir);
          //��������ļ�����
          ListItem.SubItems.Add(PatchInfo.PatchName);
          //��������ļ����ص�ַ
          ListItem.SubItems.Add(PatchInfo.PatchMd5);
          ListItem.SubItems.Add(PatchInfo.PatchDownAddress);
       end;
     end;

    if ListView1.Items.Count = 0 then
      begin
      Label1.Caption:='��ǰû���°汾����';
      RzProgressBar2.Percent:=100;
      CloseTimer.Enabled := TRUE;
      end else begin
      Timer1.Enabled:=true; //�������ļ������ذ�ť�ɲ���
      end;
  finally
    g_PatchList.Free;
  end;
end;


procedure TPatchFrm.Timer1Timer(Sender: TObject);
var
  i: integer;
  aDownURL, aFileName, aDir, aFileType, aMd5: string;
  F:TEXTFILE;
  aTMPMD5:string;
begin
  Timer1.Enabled:=False;
  Application.ProcessMessages;
  if CanBreak then exit;
  RzProgressBar2.TotalParts := ListView1.Items.Count;
  for i := 0 to ListView1.Items.Count - 1 do
  begin
    if ListView1.Items.Item[i].Checked then //ѡ��������
    begin
      Label1.Caption:='��ʼ���ز���...';
      sleep(1000);
      //�õ����ص�ַ
      aDownURL := ListView1.Items.Item[i].SubItems.Strings[3];
      aFileType := ListView1.Items.Item[i].Caption;
      aDir := ListView1.Items.Item[i].SubItems.Strings[0];
      //�õ��ļ���
      aFileName := ListView1.Items.Item[i].SubItems.Strings[1];
      aMd5 := ListView1.Items.Item[i].SubItems.Strings[2];
      Label1.Caption:='���ڽ����ļ� '+aFileName;
      if not DirectoryExists(AppPath+aDir) then
        ForceDirectories(AppPath+aDir);
      if DownLoadFile(aDownURL, aDir+aFileName) then //��ʼ����
       begin
           aTMPMD5:=RivestFile(aDir+aFileName);
           case StrToInt(aFileType) of
             0:begin
               if aMd5 <> aTMPMD5 then begin
                  Label1.Caption:='���س���,����ϵ����Ա...';
                  EXIT;
               end;
             end;
             1:begin //�������
                if aMd5 <> aTMPMD5 then begin
                  Label1.Caption:='���س���,����ϵ����Ա...';
                  EXIT;
               end else begin
                CanBreak:=true;
                PatchSelf(aFileName);
                Application.Terminate;
               end;
             end;
             2:begin//ѹ���ļ�
                if aMd5 <> aTMPMD5 then begin
                  Label1.Caption:='���س���,����ϵ����Ա...';
                  EXIT;
               end else begin
                 if (aFileName <> '') and (AppPath <> '') then begin
                   ExtractFileFromZip(AppPath+aDir,AppPath+aDir+aFileName);
                   DeleteFile(AppPath+aDir+aFileName);
                 end;
               end;
             end;
           end;
          AssignFile(F,UpDateFile);
          if fileexists(UpDateFile) then append(f)
          else Rewrite(F);
          WriteLn(F,aMd5);
          CloseFile(F);
        end else begin
        Label1.Caption:='���س���,����ϵ����Ա...';
        Exit;
        end;
    end;
    RzProgressBar2.PartsComplete := (RzProgressBar2.PartsComplete) + 1;
    Application.ProcessMessages;
    Label1.Caption:='�������...';
    CloseTimer.Enabled := TRUE;
  end;
end;


procedure TPatchFrm.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;   

procedure TPatchFrm.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  RzProgressBar1.PartsComplete := AWorkCount;
  Application.ProcessMessages;
end;

procedure TPatchFrm.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
  RzProgressBar1.TotalParts := AWorkCountMax;
  RzProgressBar1.PartsComplete := 0;
end;

function TPatchFrm.ExtractFileFromZip(const DesPathName,ZipFileName: string): Boolean;
var
  AZip: TVCLZip;
begin
  AZip := TVCLZip.Create(nil);
  try
    with AZip do begin
     OverwriteMode := Always;
     ZipName := ZipFileName;
     ZipAction := zaReplace;
     DestDir := DesPathName;
     ReadZip;
     DoAll := True;
     RecreateDirs := True;
     RetainAttributes := True;
     ReplaceReadOnly := True;
     UnZip;
    end;
  finally
  FreeAndNil(AZip);
  end;
  Result := True;
end;
procedure TPatchFrm.open();
begin
  ShowModal;
end;
procedure TPatchFrm.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TPatchFrm.FormShow(Sender: TObject);
begin
  CanBreak:=FALSE;
  if DownLoadFile(GameListURL,AppPath+'QKServerList.txt') and DownLoadFile(PatchListURL,AppPath+'QKPatchList.txt') then
  begin
    LoadPatchList();
    MainFrm.LoadServerList();
  end else begin
    Label1.Caption:='�����ļ��б����,����ϵ����Ա...';
  end;
    MainFrm.LoadLocalGameList();
end;

procedure TPatchFrm.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Enabled := FALSE;
  Close;
end;

procedure TPatchFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MainFrm.TreeView1.Items.Count > 0 then MainFrm.TreeView1.Items[0].Selected := True;   //�Զ�ѡ���һ������
end;

end.

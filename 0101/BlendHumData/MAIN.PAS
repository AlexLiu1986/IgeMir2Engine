unit main;

interface
{$WARN UNIT_PLATFORM OFF}//uses FileCtrl;关掉跨平台的提示
uses
  Windows, SysUtils, Forms, RzEdit, RzBtnEdt, RzLabel, RzButton, ComCtrls,
  RzShellDialogs, Classes, Controls, RzTabs, RzPanel, ExtCtrls, StdCtrls,
  Mask, RzRadChk, RzListVw,FileCtrl;

type
  TFrmMain = class(TForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPageControl1: TRzPageControl;
    RzPanel3: TRzPanel;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    RzLabel1: TRzLabel;
    Edit1: TRzButtonEdit;
    RzGroupBox1: TRzGroupBox;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    ID_DB1: TRzButtonEdit;
    Hum_db1: TRzButtonEdit;
    Mir_db1: TRzButtonEdit;
    GuildBase1: TRzButtonEdit;
    Envir1: TRzButtonEdit;
    RzGroupBox2: TRzGroupBox;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    ID_DB2: TRzButtonEdit;
    Hum_db2: TRzButtonEdit;
    Mir_db2: TRzButtonEdit;
    GuildBase2: TRzButtonEdit;
    Envir2: TRzButtonEdit;
    RzGroupBox3: TRzGroupBox;
    Memo1: TRzMemo;
    Button3: TRzBitBtn;
    Button1: TRzBitBtn;
    BtnExit: TRzBitBtn;
    CheckBoxDelDenyChr: TRzCheckBox;
    CheckBoxSellOffItem: TRzCheckBox;
    CheckBoxBigStorage: TRzCheckBox;
    Label3: TRzLabel;
    Label6: TRzLabel;
    Label5: TRzLabel;
    Label4: TRzLabel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    RzOpenDialog1: TRzOpenDialog;
    RzSelectFolderDialog1: TRzSelectFolderDialog;
    LabelCopyright: TRzLabel;
    URLLabel1: TRzURLLabel;
    URLLabel2: TRzURLLabel;
    RzGroupBox4: TRzGroupBox;
    RzGroupBox5: TRzGroupBox;
    ListViewTxt1: TRzListView;
    ListViewTxt2: TRzListView;
    RzLabel12: TRzLabel;
    RzLabel13: TRzLabel;
    BtnLoadTxt1: TRzBitBtn;
    BtnLoadTxt2: TRzBitBtn;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    BtnClearTxt1: TRzBitBtn;
    BtnClearTxt2: TRzBitBtn;
    ListBox1: TListBox;
    RzLabel16: TRzLabel;
    Data1Edit1: TRzButtonEdit;
    RzLabel17: TRzLabel;
    Data2Edit1: TRzButtonEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBoxDelDenyChrClick(Sender: TObject);
    procedure CheckBoxSellOffItemClick(Sender: TObject);
    procedure CheckBoxBigStorageClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure ID_DB1ButtonClick(Sender: TObject);
    procedure Edit1ButtonClick(Sender: TObject);
    procedure GuildBase1ButtonClick(Sender: TObject);
    procedure Envir1ButtonClick(Sender: TObject);
    procedure GuildBase2ButtonClick(Sender: TObject);
    procedure Envir2ButtonClick(Sender: TObject);
    procedure Hum_db1ButtonClick(Sender: TObject);
    procedure Mir_db1ButtonClick(Sender: TObject);
    procedure ID_DB2ButtonClick(Sender: TObject);
    procedure Hum_db2ButtonClick(Sender: TObject);
    procedure Mir_db2ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnClearTxt1Click(Sender: TObject);
    procedure BtnClearTxt2Click(Sender: TObject);
    procedure BtnLoadTxt1Click(Sender: TObject);
    procedure BtnLoadTxt2Click(Sender: TObject);
    procedure Data1Edit1ButtonClick(Sender: TObject);
    procedure Data2Edit1ButtonClick(Sender: TObject);
    procedure ListViewTxt1DblClick(Sender: TObject);
    procedure ListViewTxt2DblClick(Sender: TObject);
  private
    procedure ShowInformation(const smsg: string);
    { Private declarations }
  public
    function CopyDirAll(sDirName:String;sToDirName:String):Boolean; //复制目录下的所有文件
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  boDelDenyChr: Boolean;
  boSellOffItem: Boolean;
  boBigStorage: Boolean;
implementation
uses log,UnitMainWork, UniTypes, Share, EDcodeUnit;

{$R *.dfm}

const
  g_InforTimerId  = 2001;

procedure GetWorkInformations;
begin
  if not Assigned(MainWorkThread) then Exit;
  FrmMain.ProgressBar1.Max:= MainWorkThread.m_nTotalMax;
  FrmMain.ProgressBar1.Position := MainWorkThread.m_nTotalPostion;
  FrmMain.ProgressBar2.Max:= MainWorkThread.m_nCurMax;
  FrmMain.ProgressBar2.Position:= MainWorkThread.m_nCurPostion;
  FrmMain.Label3.Caption:= MainWorkThread.m_sWorkingFor;
  FrmMain.Label4.Caption:= IntToStr(MainWorkThread.m_nTotalPostion) + '/' + IntToStr(MainWorkThread.m_nTotalMax);
  FrmMain.Label5.Caption:= '失败:' + IntToStr(MainWorkThread.m_nFailed);
  FrmMain.Label6.Caption := IntToStr(MainWorkThread.m_nCurPostion) + '/' + IntToStr(MainWorkThread.m_nCurMax);
end;

procedure TFrmMain.ShowInformation(const smsg: string);
begin
  Memo1.Lines.Add(smsg);
end;

//复制目录下的所有文件
function TFrmMain.CopyDirAll(sDirName:String;sToDirName:String):Boolean;
var
  hFindFile:Cardinal;      //拷贝整个目录(包括子目录)
  t,tfile:String; 
  sCurDir:String[255];
  FindFileData:WIN32_FIND_DATA;
begin
  //先保存当前目录
  sCurDir:=GetCurrentDir;
  ChDir(sDirName);
  hFindFile:=FindFirstFile('*.*',FindFileData);
  if hFindFile <> INVALID_HANDLE_VALUE then begin
    if not DirectoryExists(sToDirName) then ForceDirectories(sToDirName);
    repeat
      tfile:=FindFileData.cFileName;
      if (tfile='.') or (tfile='..') then Continue;
      if FindFileData.dwFileAttributes= FILE_ATTRIBUTE_DIRECTORY then begin
           t:=sToDirName+'\'+tfile;
           if not DirectoryExists(t) then ForceDirectories(t);
           if sDirName[Length(sDirName)]<>'\' then
              CopyDirAll(sDirName+'\'+tfile,t)
           else CopyDirAll(sDirName+tfile,sToDirName+tfile);
      end else begin
        t:=sToDirName+'\'+tFile;
        CopyFile(PChar(tfile),PChar(t),False);
      end;
    until FindNextFile(hFindFile,FindFileData)=false;

    Windows.FindClose(hFindFile);
  end else begin
    ChDir(sCurDir);
    result:=false;
    exit;
  end;
  //回到原来的目录下
  ChDir(sCurDir);
  result:=true;
end;

//合区日志
procedure TFrmMain.Button1Click(Sender: TObject);
begin
  FrmLog := TFrmLog.Create(Application);
  FrmLog.ShowModal;
end;

procedure TFrmMain.BtnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

//开始合区
procedure TFrmMain.Button3Click(Sender: TObject);
begin
  if (trim(edit1.text)='') or (trim(ID_DB1.text)='') or (trim(ID_DB2.text)='') or
     (trim(Hum_db1.text)='') or (trim(Hum_db2.text)='') or (trim(Mir_db1.text)='') or
     (trim(Mir_db2.text)='') or (trim(GuildBase1.text)='') or (trim(GuildBase2.text)='') or
     (trim(Envir1.text)='') or (trim(Envir2.text)='') then
  begin
    Application.MessageBox('请把相关的文件路径选择好！','提示',MB_ICONWARNING+MB_OK);
    exit;
  end;
  if Application.MessageBox('注意:合区前请备份原来的数据,是否开始合并数据吗？','提示', mb_YESNO + mb_IconQuestion) = ID_NO then Exit;
  if MainWorkThread = nil then begin
    Memo1.Lines.Add('数据初始处理...');
    Button3.Enabled := False;
    //复制主区数据到指定目录 20071122
    Memo1.Lines.Add('创建文件目录...');
    if not DirectoryExists(Edit1.Text+'\LoginSrv\IDDB') then ForceDirectories(Edit1.Text+'\LoginSrv\IDDB\');
    if not DirectoryExists(Edit1.Text+'\DBServer\FDB') then ForceDirectories(Edit1.Text+'\DBServer\FDB');
    if not DirectoryExists(Edit1.Text+'\Mir200\GuildBase') then ForceDirectories(Edit1.Text+'\Mir200\GuildBase');
    if not DirectoryExists(Edit1.Text+'\Mir200\Envir\UserData') then ForceDirectories(Edit1.Text+'\Mir200\Envir\UserData');
    if not DirectoryExists(Edit1.Text+'\Mir200\Envir\MasterNo') then ForceDirectories(Edit1.Text+'\Mir200\Envir\MasterNo');
    if not DirectoryExists(Edit1.Text+'\Mir200\Envir\Market_Storage') then ForceDirectories(Edit1.Text+'\Mir200\Envir\Market_Storage');
    if not DirectoryExists(Edit1.Text+'\NEW文本数据') then  ForceDirectories(Edit1.Text+'\NEW文本数据');//创建保存文本的目录 20080703

    Memo1.Lines.Add('复制主库文件(ID.DB)...');
    copyfile(pchar(ID_DB1.text), pchar(Edit1.Text+'\LoginSrv\IDDB\ID.DB'), false);
    Memo1.Lines.Add('复制主库文件(Hum.DB)...');
    copyfile(pchar(Hum_db1.text), pchar(Edit1.Text+'\DBServer\FDB\Hum.DB'), false);
    Memo1.Lines.Add('复制主库文件(Mir.DB)...');
    copyfile(pchar(Mir_db1.text), pchar(Edit1.Text+'\DBServer\FDB\Mir.DB'), false);
    Memo1.Lines.Add('复制主库行会文件(GuildBase)...');
    if DirectoryExists(GuildBase1.text) then CopyDirAll(GuildBase1.text, Edit1.Text+'\Mir200\GuildBase');
    if DirectoryExists(Envir1.text+'\MasterNo') then
      CopyDirAll(Envir1.text+'\MasterNo',Edit1.Text+'\Mir200\Envir\MasterNo');//复制整个目录

    MainWorkThread := TMainWorkThread.Create(True);
    MainWorkThread.m_sMainRoot  := Edit1.Text;//合区数据保存的目录
   // MainWorkThread.SetWorkRoots(Edit1.Text);// 20071122
    {$IF THREADWORK}
    MainWorkThread.Resume;
    {$ELSE}
    MainWorkThread.Run;
    {$IFEND}
  end;
end;

procedure TFrmMain.CheckBoxDelDenyChrClick(Sender: TObject);
begin
  boDelDenyChr:=CheckBoxDelDenyChr.Checked;//是否清理人物(已删除)
end;

procedure TFrmMain.CheckBoxSellOffItemClick(Sender: TObject);
begin
  boSellOffItem:= CheckBoxSellOffItem.Checked;
end;

procedure TFrmMain.CheckBoxBigStorageClick(Sender: TObject);
begin
  boBigStorage:= CheckBoxBigStorage.Checked;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  KillTimer(Application.Handle, g_InforTimerId);
  if MainWorkThread <> nil then begin
    {$IF THREADWORK}
    MainWorkThread.FreeOnTerminate  := True;
    MainWorkThread.Terminate;
    {$ELSE}
      g_Terminated  := True;
      MainWorkThread.Free;
    {$IFEND}
  end;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  MainOutInforProc  := Self.ShowInformation;
  SetTimer(Application.Handle, g_InforTimerId, 10, @GetWorkInformations);
end;

procedure TFrmMain.TabSheet1Show(Sender: TObject);
begin
  boDelDenyChr:=CheckBoxDelDenyChr.Checked;
  boSellOffItem:= CheckBoxSellOffItem.Checked;
  boBigStorage:= CheckBoxBigStorage.Checked;
end;

procedure TFrmMain.Edit1ButtonClick(Sender: TObject);
begin
  if RzSelectFolderDialog1.Execute then Edit1.Text:= RzSelectFolderDialog1.SelectedPathName;
end;

procedure TFrmMain.GuildBase1ButtonClick(Sender: TObject);
begin
  if RzSelectFolderDialog1.Execute then GuildBase1.Text:= RzSelectFolderDialog1.SelectedPathName;
end;

procedure TFrmMain.Envir1ButtonClick(Sender: TObject);
begin
 if RzSelectFolderDialog1.Execute then Envir1.Text:= RzSelectFolderDialog1.SelectedPathName;
end;

procedure TFrmMain.GuildBase2ButtonClick(Sender: TObject);
begin
  if RzSelectFolderDialog1.Execute then GuildBase2.Text:= RzSelectFolderDialog1.SelectedPathName;
end;

procedure TFrmMain.Envir2ButtonClick(Sender: TObject);
begin
  if RzSelectFolderDialog1.Execute then Envir2.Text:= RzSelectFolderDialog1.SelectedPathName;
end;

procedure TFrmMain.ID_DB1ButtonClick(Sender: TObject);
begin
  RzOpenDialog1.Filter := '数据文件(*.DB)|*.DB';
  if RzOpenDialog1.Execute then ID_DB1.Text:= RzOpenDialog1.FileName;
end;

procedure TFrmMain.Hum_db1ButtonClick(Sender: TObject);
begin
  RzOpenDialog1.Filter := '数据文件(*.DB)|*.DB';
  if RzOpenDialog1.Execute then Hum_db1.Text:= RzOpenDialog1.FileName;
end;

procedure TFrmMain.Mir_db1ButtonClick(Sender: TObject);
begin
  RzOpenDialog1.Filter := '数据文件(*.DB)|*.DB';
  if RzOpenDialog1.Execute then Mir_db1.Text:= RzOpenDialog1.FileName;
end;

procedure TFrmMain.ID_DB2ButtonClick(Sender: TObject);
begin
  RzOpenDialog1.Filter := '数据文件(*.DB)|*.DB';
  if RzOpenDialog1.Execute then ID_DB2.Text:= RzOpenDialog1.FileName;
end;

procedure TFrmMain.Hum_db2ButtonClick(Sender: TObject);
begin
  RzOpenDialog1.Filter := '数据文件(*.DB)|*.DB';
  if RzOpenDialog1.Execute then Hum_db2.Text:= RzOpenDialog1.FileName;
end;

procedure TFrmMain.Mir_db2ButtonClick(Sender: TObject);
begin
  RzOpenDialog1.Filter := '数据文件(*.DB)|*.DB';
  if RzOpenDialog1.Execute then Mir_db2.Text:= RzOpenDialog1.FileName;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  sProductName: string;
  sUrl1: string;
  sUrl2: string;
begin
  Decode(g_sProductName, sProductName);
  Decode(g_sUrl1, sUrl1);
  Decode(g_sUrl2, sUrl2);
  LabelCopyright.Caption := sProductName;
  URLLabel1.Caption := sUrl1;
  URLLabel1.URL := sUrl1;
  URLLabel2.Caption := sUrl2;
  URLLabel2.URL := sUrl2;
end;
{-------------------------------------------------------------------------------
以下代码为合文本代码  20080702
-------------------------------------------------------------------------------}

{-------------------------------------------------------------------------------
过程名:    FindFile 遍历文件夹及子文件夹
作者:      清清
日期:      2008.07.02
参数:      AList,APath,Ext   1.在某个里表里显示 2.路径 3.定义扩展名 4.是否遍历子目录  
返回值:    TStringList

   Eg：:= FindFile(ListBox1.Items, 'E:\极品飞车','*.exe',True) ;
-------------------------------------------------------------------------------}
function FindFile(AList: TRzListView; const APath: TFileName;
  const Ext: String; const Recurisive: Boolean): Integer;
var
  FSearchRec: TSearchRec;
  FPath: TFileName;
begin
  Result := -1;
  application.ProcessMessages;
  if Assigned(AList) then
  try
    FPath := IncludeTrailingPathDelimiter(APath);
    if FindFirst(FPath + '*.*', faAnyFile, FSearchRec) = 0 then
      repeat
        if (FSearchRec.Attr and faDirectory) = faDirectory then
        begin
          if Recurisive and (FSearchRec.Name <> '.') and (FSearchRec.Name <> '..') then
            FindFile(AList, FPath + FSearchRec.Name, Ext, Recurisive);
        end
        else if SameText(Ext, '.*') or
          SameText(LowerCase(Ext), LowerCase(ExtractFileExt(FSearchRec.Name))) then begin
              AList.Items.Add.Caption := FPath + FSearchRec.Name;
           end;
      until FindNext(FSearchRec) <> 0;
  finally
    SysUtils.FindClose(FSearchRec);
    Result := AList.Items.Count;
  end;
end;

//查找指定文件 20080912
function FindFile2(AList: TStrings; const APath: TFileName;
  const Ext: String; const Recurisive: Boolean): Integer;
var
  FSearchRec: TSearchRec;
  FPath: TFileName;
begin
  Result := -1;
  application.ProcessMessages;
  if Assigned(AList) then
  try
    FPath := IncludeTrailingPathDelimiter(APath);
    if FindFirst(FPath + '*.*', faAnyFile, FSearchRec) = 0 then
      repeat
        if (FSearchRec.Attr and faDirectory) = faDirectory then
        begin
          if Recurisive and (FSearchRec.Name <> '.') and (FSearchRec.Name <> '..') then
            FindFile2(AList, FPath + FSearchRec.Name, Ext, Recurisive);
          if SameText(Ext, FSearchRec.Name) then AList.Add(FPath + FSearchRec.Name);
        end
        else if SameText(LowerCase(Ext), LowerCase(ExtractFileName(FSearchRec.Name))) then begin
             AList.Add(FPath + FSearchRec.Name);
           end;
      until FindNext(FSearchRec) <> 0;
  finally
    SysUtils.FindClose(FSearchRec);
    Result := AList.Count;
  end;
end;


procedure TFrmMain.BtnClearTxt1Click(Sender: TObject);
begin
  ListViewTxt1.Clear;
  RzLabel14.Caption := '0';
end;

procedure TFrmMain.BtnClearTxt2Click(Sender: TObject);
begin
  ListViewTxt2.Clear;
  RzLabel15.Caption := '0'; 
end;


procedure TFrmMain.BtnLoadTxt1Click(Sender: TObject);
var
  Dir: string;
begin
  if SelectDirectory('请选择主数据文本目录', '选择目录', Dir) then begin
    RzLabel14.Caption := '正在搜索中……';
    ListViewTxt1.Clear;
    FindFile(ListViewTxt1,Dir,'.Txt',True);
    RzLabel14.Caption := IntToStr(ListViewTxt1.Items.Count);
  end;
end;

procedure TFrmMain.BtnLoadTxt2Click(Sender: TObject);
var
  Dir: string;
begin
  if SelectDirectory('请选择从数据文本目录', '选择目录', Dir) then begin
    RzLabel15.Caption := '正在搜索中……';
    ListViewTxt2.Clear;
    FindFile(ListViewTxt2,Dir,'.Txt',True);
    RzLabel15.Caption := IntToStr(ListViewTxt2.Items.Count);
  end;
end;

procedure TFrmMain.Data1Edit1ButtonClick(Sender: TObject);
var
  I:Integer;
begin
 if RzSelectFolderDialog1.Execute then begin
   Data1Edit1.Text:= RzSelectFolderDialog1.SelectedPathName;
   if Data1Edit1.Text <> '' then begin
     ListBox1.Clear;
     I:=FindFile2(ListBox1.Items, Data1Edit1.Text,'ID.DB',True);
     if (I > 0) and (I < 2) then ID_DB1.Text:=Trim(ListBox1.Items.Text);

     ListBox1.Clear;
     I:=FindFile2(ListBox1.Items, Data1Edit1.Text,'Hum.DB',True);
     if (I > 0) and (I < 2) then Hum_DB1.Text:=Trim(ListBox1.Items.Text);

     ListBox1.Clear;
     I:=FindFile2(ListBox1.Items, Data1Edit1.Text,'Mir.DB',True);
     if (I > 0) and (I < 2) then Mir_DB1.Text:=Trim(ListBox1.Items.Text);

     ListBox1.Clear;
     I:=FindFile2(ListBox1.Items, Data1Edit1.Text,'GuildBase',True);
     if (I > 0) and (I < 2) then GuildBase1.Text:=Trim(ListBox1.Items.Text);

     ListBox1.Clear;
     I:=FindFile2(ListBox1.Items, Data1Edit1.Text,'Envir',True);
     if (I > 0) and (I < 2) then Envir1.Text:=Trim(ListBox1.Items.Text);
   end;
 end;
end;

procedure TFrmMain.Data2Edit1ButtonClick(Sender: TObject);
var
  I:Integer;
begin
 if RzSelectFolderDialog1.Execute then begin
   Data2Edit1.Text:= RzSelectFolderDialog1.SelectedPathName;
   if Data2Edit1.Text <> '' then begin
     ListBox1.Clear;
     I:=FindFile2(ListBox1.Items, Data2Edit1.Text,'ID.DB',True);
     if (I > 0) and (I < 2) then ID_DB2.Text:=Trim(ListBox1.Items.Text);

     ListBox1.Clear;
     I:=FindFile2(ListBox1.Items, Data2Edit1.Text,'Hum.DB',True);
     if (I > 0) and (I < 2) then Hum_DB2.Text:=Trim(ListBox1.Items.Text);

     ListBox1.Clear;
     I:=FindFile2(ListBox1.Items, Data2Edit1.Text,'Mir.DB',True);
     if (I > 0) and (I < 2) then Mir_DB2.Text:=Trim(ListBox1.Items.Text);

     ListBox1.Clear;
     I:=FindFile2(ListBox1.Items, Data2Edit1.Text,'GuildBase',True);
     if (I > 0) and (I < 2) then GuildBase2.Text:=Trim(ListBox1.Items.Text);

     ListBox1.Clear;
     I:=FindFile2(ListBox1.Items, Data2Edit1.Text,'Envir',True);
     if (I > 0) and (I < 2) then Envir2.Text:=Trim(ListBox1.Items.Text);
   end;
 end;
end;

procedure TFrmMain.ListViewTxt1DblClick(Sender: TObject);
begin
  ListViewTxt1.Items.BeginUpdate;
  try
    ListViewTxt1.DeleteSelected;
  finally
    ListViewTxt1.Items.EndUpdate;
  end;
end;

procedure TFrmMain.ListViewTxt2DblClick(Sender: TObject);
begin
  ListViewTxt2.Items.BeginUpdate;
  try
    ListViewTxt2.DeleteSelected;
  finally
    ListViewTxt2.Items.EndUpdate;
  end;
end;

end.

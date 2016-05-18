{------------------------------------------------------------------------------}
{ ��Ԫ����: GClearServer.pas                                                   }
{                                                                              }
{ ��Ԫ����: ����                                                               }
{ ��������: 2008-02-22 20:30:00                                                }
{                                                                              }
{ ���ܽ���:                                                                    }
{   ʵ�ֿ�����շ���������                                                     }
{                                                                              }
{ ʹ��˵��:                                                                    }
{                                                                              }
{                                                                              }
{ ������ʷ:                                                                    }
{                                                                              }
{ �д�����:                                                                    }
{                                                                              }
{                                                                              }
{------------------------------------------------------------------------------}
unit GClearServer;

interface
uses StdCtrls, Windows, forms, Inifiles, SysUtils, GShare, GMain , Dialogs,ShellApi;

procedure ListBoxAdd(ListBox: TListBox; AddStr:string);  //����ListBox��¼
procedure ListBoxDel(ListBox: TListBox);   //ɾ��ListBoxĳ����¼
function ClearGlobal(FileName: string):Boolean;//��ȫ�ֱ���
function DeleteTree(s: string):Boolean;//ɾ��Ŀ¼
function ClearWriteINI(FileName,ini1,ini2,ini3:string):Boolean; //дINI�ļ�
procedure ClearTxt(TxtName: string); //���TXT�ļ�
procedure ListBoxClearTxtFile(ListBox: TListBox); //���ListBox���Txt�ļ�
procedure ListBoxDelFile(ListBox: TListBox);      //ɾ��ListBox����ļ�
function ListBoxDelDir(ListBox: TListBox):Boolean; //���ListBod���Ŀ¼
function Clear_IniConf(): Boolean;      //д������Ϣ
procedure Clear_LoadIniConf();  //��ȡ������Ϣ

procedure ClearModValue();  //ʹ���水ť����ʹ��

var
  GlobalVal:  array[0..999] of Integer;
  GlobalAVal: array[0..999] of string;
  rec_stack:  array [1..30] of TSearchRec;
  rec_pointer: Integer;
  g_sClearError: string;
implementation

procedure ClearModValue();
begin
  frmMain.ClearSaveBtn.Enabled := True;
end;

function ClearGlobal(FileName: string):Boolean;
var
  Config: TIniFile;
  I:integer;
begin
    Result := False;
    Config := TIniFile.Create(FileName);
    for I := Low(GlobalVal) to High(GlobalVal) do begin
      Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(I), 0);
    end;

    for I := Low(GlobalAVal) to High(GlobalAVal) do begin
      Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(I), '');
    end;
    Config.Free;
    //sleep(2000);
    Result := True;
end;

procedure ListBoxAdd(ListBox: TListBox; AddStr:string);
var i: Integer;
begin
    for i:=0 to ListBox.Items.Count - 1 do
    begin
      if ListBox.Items.Strings [i] = AddStr then
      begin
        application.MessageBox('���ļ�·�������б��У�������ѡ�񣡣�','��ʾ��Ϣ',MB_ICONASTERISK);
        Exit;
      end;
    end;
    ListBox.Items.Add(AddStr);
end;

procedure ListBoxDel(ListBox: TListBox);
begin
    ListBox.Items.BeginUpdate;
  try
    ListBox.DeleteSelected;
  finally
    ListBox.Items.EndUpdate;
  end;
end;


//ɾ��Ŀ¼������վ
function DeleteFileWithUndo(sFileName : string): boolean;
var
  T : TSHFileOpStruct;
begin 
  FillChar(T, SizeOf(T), 0 );
  with T do begin
   wFunc  := FO_DELETE;
   pFrom  := PChar(sFileName);
   fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
  end;
  Result := ( 0 = ShFileOperation(T));
end;

function DeleteTree(s: string):Boolean;
var searchRec:TSearchRec;
begin
  Result := True;
  if FindFirst(s+'\*.*', faAnyFile, SearchRec)=0 then
  repeat
  if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') then
  begin
    if (SearchRec.Attr and faDirectory >0) then
    begin
      rec_stack[rec_pointer]:=SearchRec;
      rec_pointer:=rec_pointer-1;
      DeleteTree(s+'\'+SearchRec.Name);
      rec_pointer:=rec_pointer+1;
      SearchRec:=rec_stack[rec_pointer];
    end else begin
      try
        FileSetAttr(s+'\'+SearchRec.Name,faArchive);
        //DeleteFile(s+'\'+SearchRec.Name);
        if not DeleteFileWithUndo(s+'\'+SearchRec.Name) then//�ٲ����ļ�û�������,�벻ͨ 20080928
        DeleteFile(s+'\'+SearchRec.Name);
      except
        g_sClearError := 'ɾ���ļ�:'+s+'\'+SearchRec.Name+'����!';
        Result := False;
      end;
    end;
  end;      
  until (FindNext(SearchRec)<>0);
  FindClose(SearchRec);
  if rec_pointer<30 then begin
    try
      FileSetAttr(s,faArchive);
      RemoveDir(s);
    except
      g_sClearError := 'ɾ��Ŀ¼:'+s+'\'+SearchRec.Name+'����!';
      Result := False;
    end;
  end;
end;

function ClearWriteINI(FileName,ini1,ini2,ini3:string):Boolean;
var
  Myinifile: TIniFile;
begin
  Result := False;
  Myinifile:=Tinifile.Create(FileName);
  Myinifile.WriteString(ini1,ini2,ini3);
  Myinifile.Free;
  //sleep(2000);
  Result := True;
end;

procedure ClearTxt(TxtName: string);
var
  f:textfile;
begin
  assignfile(f,TxtName);
  rewrite(f);
  closefile(f);
end;


procedure ListBoxClearTxtFile(ListBox: TListBox);
var
  I: Integer;
begin
  for I:=0 to ListBox.Items.Count -1 do
  begin
     ClearTxt(ListBox.Items.Strings [I]);
  end;
end;


procedure ListBoxDelFile(ListBox: TListBox);
var
  I: Integer;
begin
  for I:=0 to ListBox.Items.Count -1 do
  begin
     DeleteFile(ListBox.Items.Strings [I]);
  end;
end;

function ListBoxDelDir(ListBox: TListBox):Boolean;
var
  I: Integer;
begin
  Result := False;
  for I:=0 to ListBox.Items.Count -1 do
  begin
     DeleteTree(ListBox.Items.Strings [I]);
  end;
  Result := True;
end;

function Clear_IniConf(): Boolean;
var
  I: Integer;
begin
    Result := False;
    g_IniConf.WriteString('ClearServer', 'IDDB', frmMain.IDEd.Text);
    g_IniConf.WriteString('ClearServer', 'FDB', frmMain.DBed.Text);
    g_IniConf.WriteString('ClearServer', 'BaseDir', frmMain.LogEd.Text);
    g_IniConf.WriteString('ClearServer', 'Castle', frmMain.CsEd.Text);
    g_IniConf.WriteString('ClearServer', 'GuildBase', frmMain.CBed.Text);
    g_IniConf.WriteString('ClearServer', 'ConLog', frmMain.CLed.Text);
    g_IniConf.WriteString('ClearServer', 'market_upg', frmMain.upged.Text);
    g_IniConf.WriteString('ClearServer', 'Market_SellOff', frmMain.Soed.Text);
    g_IniConf.WriteString('ClearServer', 'ChrLog', frmMain.ChrLog.Text);
    g_IniConf.WriteString('ClearServer', 'CountLog', frmMain.CountLog.Text);
    g_IniConf.WriteString('ClearServer', 'Log', frmMain.M2Log.Text);
    g_IniConf.WriteString('ClearServer', 'Market_prices', frmMain.sred1.Text);
    g_IniConf.WriteString('ClearServer', 'Market_saved', frmMain.sred2.Text);
    g_IniConf.WriteString('ClearServer', 'Sort', frmMain.EdtSort.Text);
    g_IniConf.WriteBool('ClearServer', 'Global', frmMain.CheckBoxGlobal.Checked);
    g_IniConf.WriteBool('ClearServer', 'UserData', frmMain.CheckBoxUserData.Checked);
    g_IniConf.WriteBool('ClearServer', 'MasterNo', frmMain.CheckBoxMasterNo.Checked);
    g_IniConf.WriteInteger('ClearServer', 'MyGetTxtNum', frmMain.ListBoxMyGetTXT.Items.Count);
    if frmMain.ListBoxMyGetTXT.Items.Count <> 0 then begin
      for I:=0 to frmMain.ListBoxMyGetTXT.Items.Count - 1 do
      begin
        g_IniConf.WriteString('ClearServer','MyGetTxt'+IntToStr(i),frmMain.ListBoxMyGetTXT.Items.Strings[i]);
      end;
    end;

    g_IniConf.WriteInteger('ClearServer', 'MyGetFileNum', frmMain.ListBoxMyGetFile.Items.Count);
    if frmMain.ListBoxMyGetFile.Items.Count <> 0 then begin
      for I:=0 to frmMain.ListBoxMyGetFile.Items.Count -1 do
      begin
        g_IniConf.WriteString('ClearServer','MyGetFile'+IntToStr(i),frmMain.ListBoxMyGetFile.Items.Strings[i]);
      end;
    end;

    g_IniConf.WriteInteger('ClearServer', 'MyGetDirNum', frmMain.ListBoxMyGetDir.Items.Count);
    if frmMain.ListBoxMyGetDir.Items.Count <> 0 then begin
      for I:=0 to frmMain.ListBoxMyGetDir.Items.Count -1 do
      begin
        g_IniConf.WriteString('ClearServer','MyGetDir'+IntToStr(i),frmMain.ListBoxMyGetDir.Items.Strings[i]);
      end;
    end;
    Result := True;
end;

procedure Clear_LoadIniConf();
var
  nMyGetTxtNum, nMyGetFileNum, nMyGetDirNum, I: Integer;
begin
   frmMain.IDEd.Text := g_IniConf.ReadString('ClearServer', 'IDDB',frmMain.IDEd.Text);
   frmMain.DBed.Text := g_IniConf.ReadString('ClearServer', 'FDB', frmMain.DBed.Text);
   frmMain.LogEd.Text := g_IniConf.ReadString('ClearServer', 'BaseDir', frmMain.LogEd.Text);
   frmMain.CsEd.Text := g_IniConf.ReadString('ClearServer', 'Castle', frmMain.CsEd.Text);
   frmMain.CBed.Text := g_IniConf.ReadString('ClearServer', 'GuildBase', frmMain.CBed.Text);
   frmMain.CLed.Text := g_IniConf.ReadString('ClearServer', 'ConLog', frmMain.CLed.Text);
   frmMain.upged.Text := g_IniConf.ReadString('ClearServer', 'market_upg', frmMain.upged.Text);
   frmMain.Soed.Text := g_IniConf.ReadString('ClearServer', 'Market_SellOff', frmMain.Soed.Text);
   frmMain.ChrLog.Text := g_IniConf.ReadString('ClearServer', 'ChrLog', frmMain.ChrLog.Text);
   frmMain.CountLog.Text := g_IniConf.ReadString('ClearServer', 'CountLog', frmMain.CountLog.Text);
   frmMain.M2Log.Text := g_IniConf.ReadString('ClearServer', 'Log', frmMain.M2Log.Text);
   frmMain.sred1.Text := g_IniConf.ReadString('ClearServer', 'Market_prices', frmMain.sred1.Text);
   frmMain.sred2.Text := g_IniConf.ReadString('ClearServer', 'Market_saved', frmMain.sred2.Text);
   frmMain.EdtSort.Text := g_IniConf.ReadString('ClearServer', 'Sort', frmMain.EdtSort.Text);
   frmMain.CheckBoxGlobal.Checked := g_IniConf.ReadBool('ClearServer', 'Global', frmMain.CheckBoxGlobal.Checked);
   frmMain.CheckBoxUserData.Checked :=  g_IniConf.ReadBool('ClearServer', 'UserData', frmMain.CheckBoxUserData.Checked);
   frmMain.CheckBoxMasterNo.Checked :=  g_IniConf.ReadBool('ClearServer', 'MasterNo', frmMain.CheckBoxMasterNo.Checked);
   nMyGetTxtNum := g_IniConf.ReadInteger('ClearServer', 'MyGetTxtNum', 0);
   nMyGetFileNum := g_IniConf.ReadInteger('ClearServer', 'MyGetFileNum', 0);
   nMyGetDirNum := g_IniConf.ReadInteger('ClearServer', 'MyGetDirNum', 0);

   if nMyGetTxtNum <> 0 then begin
     frmMain.ListBoxMyGetTXT.Items.Clear;
     for I:=0 to nMyGetTxtNum - 1 do
     begin
        frmMain.ListBoxMyGetTXT.Items.Add(g_IniConf.ReadString('ClearServer','MyGetTxt'+IntToStr(I),'��ȡ�����ļ�����'));
     end;
   end;

   if nMyGetFileNum <> 0 then begin
     frmMain.ListBoxMyGetFile.Items.Clear;
     for I:=0 to nMyGetFileNum - 1 do
     begin
        frmMain.ListBoxMyGetFile.Items.Add(g_IniConf.ReadString('ClearServer','MyGetFile'+IntToStr(I),'��ȡ�����ļ�����'));
     end;
   end;
   if nMyGetDirNum <> 0 then begin
     frmMain.ListBoxMyGetDir.Items.Clear;
     for I:=0 to nMyGetDirNum - 1 do
     begin
        frmMain.ListBoxMyGetDir.Items.Add(g_IniConf.ReadString('ClearServer','MyGetDir'+IntToStr(I),'��ȡ�����ļ�����'));
     end;
   end;
end;

end.

unit Secrch;

interface
uses Classes, SysUtils, GameLoginShare, Forms, Main, Windows, FileCtrl, Reg, Common;
procedure SearchMirDir();
procedure SearchMirClient(); //���������ͻ���
function  DoSearchFile(path: string; var Files: TStringList): Boolean;
implementation
var
  boSearchFinish: Boolean = FALSE;
  boStopSearch: Boolean = FALSE;

procedure SearchMirDir();
begin
  boStopSearch := False;
  m_BoSearchFinish := False;
  if boSearchFinish then Exit;
  SearchMirClient();
end;

//���������ͻ���
procedure SearchMirClient();
var
  I, II: Integer;
  sList, sTempList, List01, List02: TStringList;
  MirDir: String;
begin
  boSearchFinish:=TRUE;
  sList := TStringList.Create;
  sTempList := TStringList.Create;
  List01 := TStringList.Create;
  List02 := TStringList.Create;
  GetdriveName(sList);
  for I := 0 to sList.Count - 1 do begin
    Application.ProcessMessages;
    if m_BoSearchFinish then break;
    if boStopSearch then break;
    FrmMain.RzLabelStatus.Font.Color := $0040BBF1;
    FrmMain.RzLabelStatus.Caption := '����������' + sList.Strings[I];
    if CheckMirDir(sList.Strings[I]) then begin
      m_sMirClient := sList.Strings[I];
      m_BoSearchFinish := True;
      break;
    end;
    if DoSearchFile(sList.Strings[I], sTempList) then begin
      if m_BoSearchFinish then break;
      if boStopSearch then break;
      for II := 0 to sTempList.Count - 1 do begin
        FrmMain.RzLabelStatus.Font.Color := $0040BBF1;
        FrmMain.RzLabelStatus.Caption := '����������' + sTempList.Strings[II];
        if CheckMirDir(sTempList.Strings[II]) then begin
          m_sMirClient := sTempList.Strings[II];
          m_BoSearchFinish := True;
          break;
        end;
      end;
    end;
  end;
  List01.AddStrings(sTempList);
  if (not m_BoSearchFinish) and (not boStopSearch) then begin
    I := 0;
    while True do begin              //��C�̵����һ���̷�������
      if m_BoSearchFinish then break;
      if boStopSearch then break;
      Application.ProcessMessages;
      if List01.Count <=0 then Break;
      sTempList.Clear;
      if DoSearchFile(List01.Strings[I], sTempList) then begin
        if m_BoSearchFinish then break;
        if boStopSearch then break;
        List02.AddStrings(sTempList);
        for II := 0 to sTempList.Count - 1 do begin
          if m_BoSearchFinish then break;
          if boStopSearch then break;
          FrmMain.RzLabelStatus.Font.Color := $0040BBF1;
          FrmMain.RzLabelStatus.Caption := '����������' + sTempList.Strings[II];
          if CheckMirDir(sTempList.Strings[II]) then begin
            m_sMirClient := sTempList.Strings[II];
            m_BoSearchFinish := True;
            break;
          end;
        end;
      end;
      Inc(I);
      if I > List01.Count - 1 then begin
        List01.Clear;
        List01.AddStrings(List02);
        List02.Clear;
        I := 0;
      end;
    end;
  end;
  if m_BoSearchFinish then begin
      FrmMain.RzLabelStatus.Font.Color := $0040BBF1;
      FrmMain.RzLabelStatus.Caption := '�ͻ���Ŀ¼���ҵ�����';
      FrmMain.SecrchTimer.Enabled := True;
  end else begin
     if Application.MessageBox('û���ҵ��ͻ��ˣ��Ƿ��ֶ����ң�',
        '��ʾ��Ϣ',MB_YESNO + MB_ICONQUESTION) = IDYES then begin
        if FileCtrl.SelectDirectory('��ѡ�����Ŀ¼' ,'��ѡ����Ŀ¼' ,MirDir) then begin
          if not CheckMirDir(PChar(MirDir)) then begin
             Application.MessageBox('��ѡ���Ŀ¼����ȷ������', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
             Application.Terminate;
             Exit;
          end else begin
            m_sMirClient := MirDir;
            AddValue2(HKEY_LOCAL_MACHINE,'SOFTWARE\BlueYue\Mir','Path',PChar(m_sMirClient));
            FrmMain.SecrchTimer.Enabled := True;
          end;
        end else begin
          Application.Terminate;
          Exit;
        end;
     end else begin
        Application.Terminate;
        Exit;
     end;
  end;
  sList.Free;
  sTempList.Free;
  List01.Free;
  List02.Free;
  boSearchFinish:=FALSE;
end;
//�����ļ�
function DoSearchFile(path: string; var Files: TStringList): Boolean;
var
  Info: TsearchRec;
  s01: string;
  function IsDir: Boolean;
  begin
    with Info do
      result := (Name <> '.') and (Name <> '..') and ((Attr and faDirectory) = faDirectory);
  end;
  function IsFile: Boolean;
  begin
    result := not ((Info.Attr and faDirectory) = faDirectory);
  end;
begin
  try
    result := FALSE;
    if findfirst(path + '*.*', faAnyFile, Info) = 0 then begin
      if IsDir then begin
        s01 := path + Info.Name;
        if s01[Length(s01)] <> '\' then s01 := s01 + '\';
        Files.Add(s01);
      end;
      while True do begin
        if m_BoSearchFinish then break;
        if boStopSearch then break;
        s01 := path + Info.Name;
        if s01[Length(s01)] <> '\' then s01 := s01 + '\';
        if IsDir then Files.Add(s01);
        Application.ProcessMessages;
        if findnext(Info) <> 0 then break;
      end;
    end;
    result := True;
  finally
    SysUtils.findclose(Info);
  end;
end;
end.

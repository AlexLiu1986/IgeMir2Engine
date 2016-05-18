unit Secrch1111;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinCtrls, StdCtrls, RzLabel, ExtCtrls, RzPanel, RzButton,
  GameLoginShare, bsSkinShellCtrls;

type
  TFrmSecrch = class(TForm)
    GroupBox1: TRzGroupBox;
    Label1: TLabel;
    GroupBox2: TRzGroupBox;
    Label2: TLabel;
    SecrchInfoLabel: TRzLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditPath: TEdit;
    Label5: TLabel;
    RzToolButtonSearch: TbsSkinButton;
    RzButtonSelDir: TbsSkinButton;
    StopButton: TbsSkinButton;
    SelectDirectoryDialog: TbsSkinSelectDirectoryDialog;
    procedure RzButtonSelDirClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure RzToolButtonSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure SearchMirClient(); //���������ͻ���
    function  DoSearchFile(path: string; var Files: TStringList): Boolean;
  public
    { Public declarations }
  end;

var
  FrmSecrch: TFrmSecrch;

implementation
uses Main, MsgBox;
var
  boStopSearch: Boolean = FALSE;
  boSearchFinish: Boolean = FALSE;
{$R *.dfm}
//�ֹ�ѡ��Ŀ¼
procedure TFrmSecrch.RzButtonSelDirClick(Sender: TObject);
begin
  if SelectDirectoryDialog.Execute then begin
    EditPath.Text := SelectDirectoryDialog.Directory;
    m_sMirClient := EditPath.Text;
    if m_sMirClient[Length(m_sMirClient)] <> '\' then m_sMirClient := m_sMirClient + '\';
    if CheckMirDir(m_sMirClient) then begin
      m_BoSearchFinish := True;
      Close;
    end else begin
      //MainFrm.bsSkinMessage1.MessageDlg('��ѡ��Ĳ��Ǵ���Ŀ¼��������ѡ�񣡣���',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '��ѡ��Ĳ��Ǵ���Ŀ¼��������ѡ�񣡣���';
    FrmMessageBox.ShowModal;
    end;
  end;
end;
//ȡ����ť
procedure TFrmSecrch.StopButtonClick(Sender: TObject);
begin
  boStopSearch := True;
  Sleep(100);
  Close;
end;
//����������ť
procedure TFrmSecrch.RzToolButtonSearchClick(Sender: TObject);
begin
  if boSearchFinish then Exit;
  RzButtonSelDir.Enabled:=False;
  SearchMirClient();
  RzButtonSelDir.Enabled:=TRUE;
  Close;
end;
//���������ͻ���
procedure TFrmSecrch.SearchMirClient();
var
  I, II: Integer;
  sList, sTempList, List01, List02: TStringList;
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
    SecrchInfoLabel.Caption := '����������' + sList.Strings[I];
    if CheckMirDir(sList.Strings[I]) then begin
      m_sMirClient := sList.Strings[I];
      m_BoSearchFinish := True;
      break;
    end;
    if DoSearchFile(sList.Strings[I], sTempList) then begin
      if m_BoSearchFinish then break;
      if boStopSearch then break;    
      for II := 0 to sTempList.Count - 1 do begin
        SecrchInfoLabel.Caption := '����������' + sTempList.Strings[II];
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
          SecrchInfoLabel.Caption := '����������' + sTempList.Strings[II];
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
  sList.Free;
  sTempList.Free;
  List01.Free;
  List02.Free;
  boSearchFinish:=FALSE;
end;
//�����ļ�
function TFrmSecrch.DoSearchFile(path: string; var Files: TStringList): Boolean;
var
  Info: TsearchRec;
  s01: string;
  procedure ProcessAFile(FileName: string);
  begin
   {if Assigned(PnlPanel) then
     PnlPanel.Caption := FileName;
   Label2.Caption := FileName;}
  end;
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
    findclose(Info);
  end;
end;
procedure TFrmSecrch.FormCreate(Sender: TObject);
begin
  boStopSearch := False;
  m_BoSearchFinish := False;
end;

end.

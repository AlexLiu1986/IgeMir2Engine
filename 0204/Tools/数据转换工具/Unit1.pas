unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Hum_db1: TEdit;
    Mir_db1: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    Button3: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Edit2: TEdit;
    Label2: TLabel;
    SpeedButton2: TSpeedButton;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label10: TLabel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Hum_db2: TEdit;
    Mir_db2: TEdit;
    GroupBox4: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Memo2: TMemo;
    ProgressBar3: TProgressBar;
    ProgressBar4: TProgressBar;
    Button1: TButton;
    Button4: TButton;
    Label15: TLabel;
    Label16: TLabel;
    procedure SpeedButton3Clik(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  procedure ShowInformation(const smsg: string);
  procedure ShowInformation1(const smsg: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses FileCtrl,UnitMainWork,unit3;
{$R *.dfm}
const
  g_InforTimerId  = 2001;
  g_InforTimerId1  = 2002;
  
procedure GetWorkInformations;
begin
  if not Assigned(MainWorkThread) then Exit;
  Form1.ProgressBar1.Max        := MainWorkThread.m_nTotalMax;
  Form1.ProgressBar1.Position   := MainWorkThread.m_nTotalPostion;
  Form1.ProgressBar2.Max        := MainWorkThread.m_nCurMax;
  Form1.ProgressBar2.Position   := MainWorkThread.m_nCurPostion;
  Form1.Label3.Caption          := MainWorkThread.m_sWorkingFor;
  Form1.Label4.Caption          := IntToStr(MainWorkThread.m_nTotalPostion) + '/' + IntToStr(MainWorkThread.m_nTotalMax);
  Form1.Label5.Caption          := '失败:' + IntToStr(MainWorkThread.m_nFailed);
  Form1.Label6.Caption          := IntToStr(MainWorkThread.m_nCurPostion) + '/' + IntToStr(MainWorkThread.m_nCurMax);
end;

procedure GetWorkInformations1;
begin
  if not Assigned(MainWorkThread1) then Exit;
  Form1.ProgressBar3.Max        := MainWorkThread1.m_nTotalMax;
  Form1.ProgressBar3.Position   := MainWorkThread1.m_nTotalPostion;
  Form1.ProgressBar4.Max        := MainWorkThread1.m_nCurMax;
  Form1.ProgressBar4.Position   := MainWorkThread1.m_nCurPostion;
  Form1.Label11.Caption          := MainWorkThread1.m_sWorkingFor;
  Form1.Label12.Caption          := IntToStr(MainWorkThread1.m_nTotalPostion) + '/' + IntToStr(MainWorkThread1.m_nTotalMax);
  Form1.Label13.Caption          := '失败:' + IntToStr(MainWorkThread1.m_nFailed);
  Form1.Label14.Caption          := IntToStr(MainWorkThread1.m_nCurPostion) + '/' + IntToStr(MainWorkThread1.m_nCurMax);
end;

procedure TForm1.SpeedButton3Clik(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then
  begin
   Hum_db1.Text:=opendialog1.filename;
  end;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then
  begin
   Mir_db1.Text:=opendialog1.filename;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  s: string;
begin
  if SelectDirectory('选择路径...', '', S) then
    Edit1.Text  := S;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if (trim(edit1.text)='') or (trim(Hum_db1.text)='') or (trim(Mir_db1.text)='')  then
   begin
     Application.MessageBox('请把相关的文件路径选择好！','提示信息',MB_ICONASTERISk+MB_OK);
     exit;
   end;
  if Application.MessageBox('是否确定已经将原数据备份并准备好了转换吗？',
                                '提示',
                                mb_YESNO + mb_IconQuestion) = ID_NO then Exit;
  if MainWorkThread = nil then
//复制主区数据到指定目录 20071122
if not DirectoryExists(Edit1.Text+'\DBServer\FDB') then ForceDirectories(Edit1.Text+'\DBServer\FDB');

  MainWorkThread := TMainWorkThread.Create(True);
  MainWorkThread.m_sMainRoot  := Edit1.Text;//合区数据保存的目录
 // MainWorkThread.SetWorkRoots(Edit1.Text);// 20071122
  {$IF THREADWORK}
  MainWorkThread.Resume;
  {$ELSE}
  MainWorkThread.Run;
  {$IFEND}
end;

procedure TForm1.ShowInformation(const smsg: string);
begin
  Memo1.Lines.Add(smsg);
end;
procedure TForm1.ShowInformation1(const smsg: string);
begin
  Memo2.Lines.Add(smsg);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MainOutInforProc  := Self.ShowInformation;
  MainOutInforProc1  := Self.ShowInformation1;
  SetTimer(Application.Handle, g_InforTimerId, 10, @GetWorkInformations);
  SetTimer(Application.Handle, g_InforTimerId1, 10, @GetWorkInformations1);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  KillTimer(Application.Handle, g_InforTimerId);
  KillTimer(Application.Handle, g_InforTimerId1);
  if MainWorkThread <> nil then
    begin
      {$IF THREADWORK}
      MainWorkThread.FreeOnTerminate  := True;
      MainWorkThread.Terminate;
      {$ELSE}
        g_Terminated  := True;
        MainWorkThread.Free;
      {$IFEND}
    end;
  if MainWorkThread1 <> nil then
    begin
      {$IF THREADWORK}
      MainWorkThread1.FreeOnTerminate  := True;
      MainWorkThread1.Terminate;
      {$ELSE}
        g_Terminated1  := True;
        MainWorkThread1.Free;
      {$IFEND}
    end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  s: string;
begin
  if SelectDirectory('选择路径...', '', S) then
    Edit2.Text  := S;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then
  begin
   Hum_db2.Text:=opendialog1.filename;
  end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then
  begin
   Mir_db2.Text:=opendialog1.filename;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
if (trim(edit2.text)='') or (trim(Hum_db2.text)='') or (trim(Mir_db2.text)='')  then
   begin
     Application.MessageBox('请把相关的文件路径选择好！','提示信息',MB_ICONASTERISk+MB_OK);
     exit;
   end;
  if Application.MessageBox('是否确定已经将原数据备份并准备好了转换吗？',
                                '提示',
                                mb_YESNO + mb_IconQuestion) = ID_NO then Exit;
  if MainWorkThread1 = nil then
//复制主区数据到指定目录 20071122
if not DirectoryExists(Edit2.Text+'\DBServer\FDB') then ForceDirectories(Edit2.Text+'\DBServer\FDB');

  MainWorkThread1 := TMainWorkThread1.Create(True);
  MainWorkThread1.m_sMainRoot  := Edit2.Text;//合区数据保存的目录
 // MainWorkThread.SetWorkRoots(Edit1.Text);// 20071122
  {$IF THREADWORK}
  MainWorkThread1.Resume;
  {$ELSE}
  MainWorkThread1.Run;
  {$IFEND}
end;

end.

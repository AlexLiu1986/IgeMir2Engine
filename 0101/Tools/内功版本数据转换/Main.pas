unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, XPman;

type
  TFrmMain = class(TForm)
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    Label17: TLabel;
    SpeedButton7: TSpeedButton;
    Label20: TLabel;
    Edit3: TEdit;
    GroupBox5: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Hum_db3: TEdit;
    Mir_db3: TEdit;
    GroupBox6: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Memo3: TMemo;
    ProgressBar5: TProgressBar;
    ProgressBar6: TProgressBar;
    Button5: TButton;
    Button6: TButton;
    OpenDialog1: TOpenDialog;
    TabSheet1: TTabSheet;
    Edit1: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Hum_db1014: TEdit;
    Mir_db1014: TEdit;
    Button1: TButton;
    Button2: TButton;
    TabSheet2: TTabSheet;
    Label9: TLabel;
    Edit2: TEdit;
    GroupBox3: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Hum_db1107: TEdit;
    Mir_db1107: TEdit;
    Label12: TLabel;
    GroupBox4: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Memo2: TMemo;
    ProgressBar3: TProgressBar;
    ProgressBar4: TProgressBar;
    Button3: TButton;
    Button4: TButton;
    SpeedButton6: TSpeedButton;
    TabSheet4: TTabSheet;
    Label25: TLabel;
    Edit1219: TEdit;
    SpeedButton10: TSpeedButton;
    GroupBox7: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    Hum_db1219: TEdit;
    Mir_db1219: TEdit;
    Label28: TLabel;
    GroupBox8: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Memo4: TMemo;
    ProgressBar7: TProgressBar;
    ProgressBar8: TProgressBar;
    Button7: TButton;
    Button8: TButton;
    procedure Button6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    procedure ShowInformation(const smsg: string);
    procedure ShowInformation1014(const smsg: string);
    procedure ShowInformation1107(const smsg: string);
    procedure ShowInformation1219(const smsg: string);
  public
    { Public declarations }
  end;
  
var
  FrmMain: TFrmMain;

implementation

uses FileCtrl,UnitMainWork, work1,work1107,work1219;

{$R *.dfm}
const
  g_InforTimerId  = 2001;
  g_InforTimerId1014  = 2002;
  g_InforTimerId1107  = 2003;
  g_InforTimerId1219  = 2003;

procedure GetWorkInformations;
begin
  if not Assigned(MainWorkThread) then Exit;
  FrmMain.ProgressBar5.Max:= MainWorkThread.m_nTotalMax;
  FrmMain.ProgressBar5.Position := MainWorkThread.m_nTotalPostion;
  FrmMain.ProgressBar6.Max:= MainWorkThread.m_nCurMax;
  FrmMain.ProgressBar6.Position:= MainWorkThread.m_nCurPostion;
  FrmMain.Label21.Caption:= MainWorkThread.m_sWorkingFor;
  FrmMain.Label22.Caption:= IntToStr(MainWorkThread.m_nTotalPostion) + '/' + IntToStr(MainWorkThread.m_nTotalMax);
  FrmMain.Label23.Caption:= '失败:' + IntToStr(MainWorkThread.m_nFailed);
  FrmMain.Label24.Caption := IntToStr(MainWorkThread.m_nCurPostion) + '/' + IntToStr(MainWorkThread.m_nCurMax);
end;

procedure GetWorkInformations1014;
begin
  if not Assigned(Work1014) then Exit;
  FrmMain.ProgressBar1.Max:= Work1014.m_nTotalMax;
  FrmMain.ProgressBar1.Position := Work1014.m_nTotalPostion;
  FrmMain.ProgressBar2.Max:= Work1014.m_nCurMax;
  FrmMain.ProgressBar2.Position:= Work1014.m_nCurPostion;
  FrmMain.Label3.Caption:= Work1014.m_sWorkingFor;
  FrmMain.Label4.Caption:= IntToStr(Work1014.m_nTotalPostion) + '/' + IntToStr(Work1014.m_nTotalMax);
  FrmMain.Label5.Caption:= '失败:' + IntToStr(Work1014.m_nFailed);
  FrmMain.Label6.Caption := IntToStr(Work1014.m_nCurPostion) + '/' + IntToStr(Work1014.m_nCurMax);
end;

procedure GetWorkInformations1107;
begin
  if not Assigned(Work_1107) then Exit;
  FrmMain.ProgressBar3.Max:= Work_1107.m_nTotalMax;
  FrmMain.ProgressBar3.Position := Work_1107.m_nTotalPostion;
  FrmMain.ProgressBar4.Max:= Work_1107.m_nCurMax;
  FrmMain.ProgressBar4.Position:= Work_1107.m_nCurPostion;
  FrmMain.Label13.Caption:= Work_1107.m_sWorkingFor;
  FrmMain.Label14.Caption:= IntToStr(Work_1107.m_nTotalPostion) + '/' + IntToStr(Work_1107.m_nTotalMax);
  FrmMain.Label15.Caption:= '失败:' + IntToStr(Work_1107.m_nFailed);
  FrmMain.Label16.Caption := IntToStr(Work_1107.m_nCurPostion) + '/' + IntToStr(Work_1107.m_nCurMax);
end;

procedure GetWorkInformations1219;
begin
  if not Assigned(Work_1219) then Exit;
  FrmMain.ProgressBar7.Max:= Work_1219.m_nTotalMax;
  FrmMain.ProgressBar7.Position := Work_1219.m_nTotalPostion;
  FrmMain.ProgressBar8.Max:= Work_1219.m_nCurMax;
  FrmMain.ProgressBar8.Position:= Work_1219.m_nCurPostion;
  FrmMain.Label29.Caption:= Work_1219.m_sWorkingFor;
  FrmMain.Label30.Caption:= IntToStr(Work_1219.m_nTotalPostion) + '/' + IntToStr(Work_1219.m_nTotalMax);
  FrmMain.Label31.Caption:= '失败:' + IntToStr(Work_1219.m_nFailed);
  FrmMain.Label32.Caption := IntToStr(Work_1219.m_nCurPostion) + '/' + IntToStr(Work_1219.m_nCurMax);
end;

procedure TFrmMain.ShowInformation(const smsg: string);
begin
  Memo3.Lines.Add(smsg);
end;

procedure TFrmMain.ShowInformation1014(const smsg: string);
begin
  Memo1.Lines.Add(smsg);
end;

procedure TFrmMain.ShowInformation1107(const smsg: string);
begin
  Memo2.Lines.Add(smsg);
end;

procedure TFrmMain.ShowInformation1219(const smsg: string);
begin
  Memo4.Lines.Add(smsg);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  MainOutInforProc  := Self.ShowInformation;
  SetTimer(Application.Handle, g_InforTimerId, 10, @GetWorkInformations);

  MainOutInforProc1014:= Self.ShowInformation1014;
  SetTimer(Application.Handle, g_InforTimerId1014, 10, @GetWorkInformations1014);

  MainOutInforProc1107:= Self.ShowInformation1107;
  SetTimer(Application.Handle, g_InforTimerId1107, 10, @GetWorkInformations1107);

  MainOutInforProc1219:= Self.ShowInformation1219;
  SetTimer(Application.Handle, g_InforTimerId1219, 10, @GetWorkInformations1219);
end;



procedure TFrmMain.Button6Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFrmMain.SpeedButton7Click(Sender: TObject);
var
  s: string;
begin
  if SelectDirectory('选择路径...', '', S) then Edit3.Text  := S;
end;

procedure TFrmMain.SpeedButton8Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then begin
    Hum_db3.Text:=opendialog1.filename;
  end;
end;

procedure TFrmMain.SpeedButton9Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then begin
    Mir_db3.Text:=opendialog1.filename;
  end;
end;

procedure TFrmMain.Button5Click(Sender: TObject);
begin
   if (trim(edit3.text)='') or (trim(Hum_db3.text)='') or (trim(Mir_db3.text)='')  then begin
     Application.MessageBox('请把相关的文件路径选择好！','提示信息',MB_ICONASTERISk+MB_OK);
     exit;
   end;
  if Application.MessageBox('是否确定已经将原数据备份并准备好了转换吗？', '提示',
                                mb_YESNO + mb_IconQuestion) = ID_NO then Exit;

  Hum_db3.Enabled := False;
  Mir_db3.Enabled := False;
  SpeedButton8.Enabled := False;
  SpeedButton9.Enabled := False;
  Edit3.Enabled := False;
  SpeedButton7.Enabled := False;
  Button5.Enabled := False;
  
  //复制主区数据到指定目录 20071122
  if not DirectoryExists(Edit3.Text+'\DBServer\FDB') then ForceDirectories(Edit3.Text+'\DBServer\FDB');
  if MainWorkThread = nil then
  MainWorkThread := TMainWorkThread.Create(True);
  MainWorkThread.m_sMainRoot  := Edit3.Text;//合区数据保存的目录
 // MainWorkThread.SetWorkRoots(Edit1.Text);// 20071122
  {$IF THREADWORK}
  MainWorkThread.Resume;
  {$ELSE}
  MainWorkThread.Run;
  {$IFEND}
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
var
  s: string;
begin
  if SelectDirectory('选择路径...', '', S) then Edit1.Text  := S;
end;

procedure TFrmMain.SpeedButton2Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then begin
    Hum_db1014.Text:=opendialog1.filename;
  end;
end;

procedure TFrmMain.SpeedButton3Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then begin
    Mir_db1014.Text:=opendialog1.filename;
  end;
end;
//1014->1231 转换
procedure TFrmMain.Button1Click(Sender: TObject);
begin
   if (trim(edit1.text)='') or (trim(Hum_db1014.text)='') or (trim(Mir_db1014.text)='')  then begin
     Application.MessageBox('请把相关的文件路径选择好！','提示信息',MB_ICONASTERISk+MB_OK);
     exit;
   end;
  if Application.MessageBox('是否确定已经将原数据备份并准备好了转换吗？', '提示',
                                mb_YESNO + mb_IconQuestion) = ID_NO then Exit;

  Hum_db1014.Enabled := False;
  Mir_db1014.Enabled := False;
  SpeedButton1.Enabled := False;
  SpeedButton2.Enabled := False;
  SpeedButton3.Enabled := False;
  Edit1.Enabled := False;
  Button1.Enabled := False;
  
  //复制主区数据到指定目录 20071122
  if not DirectoryExists(Edit1.Text+'\DBServer\FDB') then ForceDirectories(Edit1.Text+'\DBServer\FDB');
  if Work1014 = nil then
  Work1014 := TMainWorkThread1.Create(True);
  Work1014.m_sMainRoot  := Edit1.Text;//合区数据保存的目录

  {$IF THREADWORK}
  Work1014.Resume;
  {$ELSE}
  Work1014.Run;
  {$IFEND}
end;

procedure TFrmMain.SpeedButton6Click(Sender: TObject);
var
  s: string;
begin
  if SelectDirectory('选择路径...', '', S) then Edit2.Text  := S;
end;

procedure TFrmMain.SpeedButton4Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then begin
    Hum_db1107.Text:=opendialog1.filename;
  end;
end;

procedure TFrmMain.SpeedButton5Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then begin
    Mir_db1107.Text:=opendialog1.filename;
  end;
end;

//1107->1231
procedure TFrmMain.Button3Click(Sender: TObject);
begin
   if (trim(edit2.text)='') or (trim(Hum_db1107.text)='') or (trim(Mir_db1107.text)='')  then begin
     Application.MessageBox('请把相关的文件路径选择好！','提示信息',MB_ICONASTERISk+MB_OK);
     exit;
   end;
  if Application.MessageBox('是否确定已经将原数据备份并准备好了转换吗？', '提示',
                                mb_YESNO + mb_IconQuestion) = ID_NO then Exit;

  Hum_db1107.Enabled := False;
  Mir_db1107.Enabled := False;
  SpeedButton4.Enabled := False;
  SpeedButton5.Enabled := False;
  SpeedButton6.Enabled := False;
  Edit2.Enabled := False;
  Button3.Enabled := False;
  
  //复制主区数据到指定目录 20071122
  if not DirectoryExists(Edit2.Text+'\DBServer\FDB') then ForceDirectories(Edit2.Text+'\DBServer\FDB');
  if Work_1107 = nil then
  Work_1107 := TMainWorkThread1107.Create(True);
  Work_1107.m_sMainRoot  := Edit2.Text;//合区数据保存的目录

  {$IF THREADWORK}
  Work_1107.Resume;
  {$ELSE}
  Work_1107.Run;
  {$IFEND}
end;

procedure TFrmMain.SpeedButton10Click(Sender: TObject);
var
  s: string;
begin
  if SelectDirectory('选择路径...', '', S) then Edit1219.Text  := S;
end;

procedure TFrmMain.SpeedButton11Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then begin
    Hum_db1219.Text:=opendialog1.filename;
  end;
end;

procedure TFrmMain.SpeedButton12Click(Sender: TObject);
begin
  opendialog1.filter:='数据文件(*.DB)|*.DB';
  if opendialog1.Execute then begin
    Mir_db1219.Text:=opendialog1.filename;
  end;
end;

procedure TFrmMain.Button7Click(Sender: TObject);
begin
   if (trim(edit1219.text)='') or (trim(Hum_db1219.text)='') or (trim(Mir_db1219.text)='')  then begin
     Application.MessageBox('请把相关的文件路径选择好！','提示信息',MB_ICONASTERISk+MB_OK);
     exit;
   end;
  if Application.MessageBox('是否确定已经将原数据备份并准备好了转换吗？', '提示',
                                mb_YESNO + mb_IconQuestion) = ID_NO then Exit;

  Hum_db1219.Enabled := False;
  Mir_db1219.Enabled := False;
  SpeedButton10.Enabled := False;
  SpeedButton11.Enabled := False;
  SpeedButton12.Enabled := False;
  Edit1219.Enabled := False;
  Button7.Enabled := False;
  
  //复制主区数据到指定目录 20071122
  if not DirectoryExists(Edit1219.Text+'\DBServer\FDB') then ForceDirectories(Edit1219.Text+'\DBServer\FDB');
  if Work_1219 = nil then
  Work_1219 := TMainWorkThread1219.Create(True);
  Work_1219.m_sMainRoot  := Edit1219.Text;//合区数据保存的目录

  {$IF THREADWORK}
  Work_1219.Resume;
  {$ELSE}
  Work_1219.Run;
  {$IFEND}
end;

end.

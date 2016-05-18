unit GMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, INIFiles, ExtCtrls,
  Spin, JSocket, {����Ϊ���ݹ���}VCLUnZip, VCLZip, ShlObj, ActiveX, Buttons,
  RzPanel, RzSplit, RzSpnEdt, RzButton, RzShellDialogs, jpeg, RzBHints;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditGameDir: TEdit;
    Label2: TLabel;
    EditHeroDB: TEdit;
    ButtonNext1: TButton;
    ButtonNext2: TButton;
    GroupBox2: TGroupBox;
    ButtonPrv2: TButton;
    EditGameName: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditGameExtIPaddr: TEdit;
    GroupBox5: TGroupBox;
    EditM2ServerProgram: TEdit;
    EditDBServerProgram: TEdit;
    EditLoginSrvProgram: TEdit;
    EditLogServerProgram: TEdit;
    EditLoginGateProgram: TEdit;
    EditSelGateProgram: TEdit;
    EditRunGateProgram: TEdit;
    ButtonStartGame: TButton;
    CheckBoxM2Server: TCheckBox;
    CheckBoxDBServer: TCheckBox;
    CheckBoxLoginServer: TCheckBox;
    CheckBoxLogServer: TCheckBox;
    CheckBoxLoginGate: TCheckBox;
    CheckBoxSelGate: TCheckBox;
    CheckBoxRunGate: TCheckBox;
    CheckBoxRunGate1: TCheckBox;
    EditRunGate1Program: TEdit;
    CheckBoxRunGate2: TCheckBox;
    EditRunGate2Program: TEdit;
    TimerStartGame: TTimer;
    TimerStopGame: TTimer;
    TimerCheckRun: TTimer;
    MemoLog: TMemo;
    ButtonReLoadConfig: TButton;
    GroupBox7: TGroupBox;
    Label9: TLabel;
    EditLoginGate_MainFormX: TSpinEdit;
    Label10: TLabel;
    EditLoginGate_MainFormY: TSpinEdit;
    GroupBox3: TGroupBox;
    GroupBox8: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    EditSelGate_MainFormX: TSpinEdit;
    EditSelGate_MainFormY: TSpinEdit;
    TabSheet7: TTabSheet;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    EditLoginServer_MainFormX: TSpinEdit;
    EditLoginServer_MainFormY: TSpinEdit;
    TabSheet8: TTabSheet;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    EditDBServer_MainFormX: TSpinEdit;
    EditDBServer_MainFormY: TSpinEdit;
    TabSheet9: TTabSheet;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    EditLogServer_MainFormX: TSpinEdit;
    EditLogServer_MainFormY: TSpinEdit;
    TabSheet10: TTabSheet;
    GroupBox15: TGroupBox;
    GroupBox16: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    EditM2Server_MainFormX: TSpinEdit;
    EditM2Server_MainFormY: TSpinEdit;
    TabSheet11: TTabSheet;
    ButtonSave: TButton;
    ButtonGenGameConfig: TButton;
    ButtonPrv3: TButton;
    ButtonNext3: TButton;
    TabSheet12: TTabSheet;
    ButtonPrv4: TButton;
    ButtonNext4: TButton;
    ButtonPrv5: TButton;
    ButtonNext5: TButton;
    ButtonPrv6: TButton;
    ButtonNext6: TButton;
    ButtonPrv7: TButton;
    ButtonNext7: TButton;
    ButtonPrv8: TButton;
    ButtonNext8: TButton;
    ButtonPrv9: TButton;
    GroupBox17: TGroupBox;
    GroupBox18: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    EditRunGate_MainFormX: TSpinEdit;
    EditRunGate_MainFormY: TSpinEdit;
    GroupBox19: TGroupBox;
    Label23: TLabel;
    EditRunGate_Connt: TSpinEdit;
    TabSheet13: TTabSheet;
    CheckBoxTwoServer: TCheckBox;
    GroupBox20: TGroupBox;
    CheckBoxDisableAutoGame: TCheckBox;
    GroupBox22: TGroupBox;
    LabelRunGate_GatePort1: TLabel;
    EditRunGate_GatePort1: TEdit;
    LabelLabelRunGate_GatePort2: TLabel;
    EditRunGate_GatePort2: TEdit;
    LabelRunGate_GatePort3: TLabel;
    EditRunGate_GatePort3: TEdit;
    LabelRunGate_GatePort4: TLabel;
    EditRunGate_GatePort4: TEdit;
    LabelRunGate_GatePort5: TLabel;
    EditRunGate_GatePort5: TEdit;
    LabelRunGate_GatePort6: TLabel;
    EditRunGate_GatePort6: TEdit;
    LabelRunGate_GatePort7: TLabel;
    EditRunGate_GatePort7: TEdit;
    EditRunGate_GatePort8: TEdit;
    LabelRunGate_GatePort78: TLabel;
    ButtonRunGateDefault: TButton;
    ButtonSelGateDefault: TButton;
    ButtonGeneralDefalult: TButton;
    ButtonLoginGateDefault: TButton;
    ButtonLoginSrvDefault: TButton;
    ButtonDBServerDefault: TButton;
    ButtonLogServerDefault: TButton;
    ButtonM2ServerDefault: TButton;
    GroupBox23: TGroupBox;
    Label28: TLabel;
    EditLoginGate_GatePort: TEdit;
    GroupBox24: TGroupBox;
    Label29: TLabel;
    EditSelGate_GatePort: TEdit;
    GroupBox27: TGroupBox;
    CheckBoxboLoginGate_GetStart: TCheckBox;
    GroupBox28: TGroupBox;
    CheckBoxboSelGate_GetStart: TCheckBox;
    TabSheetDebug: TTabSheet;
    GroupBox29: TGroupBox;
    GroupBox30: TGroupBox;
    Label45: TLabel;
    EditM2CheckCodeAddr: TEdit;
    TimerCheckDebug: TTimer;
    Label46: TLabel;
    EditM2CheckCode: TEdit;
    ButtonM2Suspend: TButton;
    GroupBox31: TGroupBox;
    Label47: TLabel;
    Label48: TLabel;
    EditDBCheckCodeAddr: TEdit;
    EditDBCheckCode: TEdit;
    Button3: TButton;
    GroupBox32: TGroupBox;
    Label61: TLabel;
    Label62: TLabel;
    EditM2Server_TestLevel: TSpinEdit;
    EditM2Server_TestGold: TSpinEdit;
    Label49: TLabel;
    EditSelGate_GatePort1: TEdit;
    GroupBox33: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    EditLoginServerGatePort: TEdit;
    EditLoginServerServerPort: TEdit;
    GroupBox34: TGroupBox;
    CheckBoxboLoginServer_GetStart: TCheckBox;
    GroupBox35: TGroupBox;
    CheckBoxDBServerGetStart: TCheckBox;
    GroupBox36: TGroupBox;
    Label52: TLabel;
    Label53: TLabel;
    EditDBServerGatePort: TEdit;
    EditDBServerServerPort: TEdit;
    GroupBox37: TGroupBox;
    CheckBoxLogServerGetStart: TCheckBox;
    GroupBox38: TGroupBox;
    Label54: TLabel;
    EditLogServerPort: TEdit;
    GroupBox39: TGroupBox;
    Label55: TLabel;
    EditM2ServerGatePort: TEdit;
    GroupBox40: TGroupBox;
    CheckBoxM2ServerGetStart: TCheckBox;
    Label56: TLabel;
    EditM2ServerMsgSrvPort: TEdit;
    Label57: TLabel;
    EditDBCheckStr: TEdit;
    Label58: TLabel;
    EditM2CheckStr: TEdit;
    TabSheet16: TTabSheet;
    Label7: TLabel;
    GroupBox4: TGroupBox;
    ListViewBak: TListView;
    GroupBox42: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    EditData: TEdit;
    EditBak: TEdit;
    RadioBak1: TRadioButton;
    RadioBak2: TRadioButton;
    CheckBoxBakReduce: TCheckBox;
    CheckBoxBakAuto: TCheckBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Button4: TButton;
    Button5: TButton;
    ButBakAdd: TButton;
    ButBakDel: TButton;
    ButBakChg: TButton;
    ButBakSave: TButton;
    ButBakStart: TButton;
    TimerBak: TTimer;
    VCLZip1: TVCLZip;
    RadioButtonMainServer: TRadioButton;
    RadioButtonSinceServer: TRadioButton;
    Label8: TLabel;
    GroupBox6: TGroupBox;
    Label24: TLabel;
    CheckBoxDynamicIPMode: TCheckBox;
    Label25: TLabel;
    EditLoginServerMonPort: TEdit;
    TabSheet3: TTabSheet;
    Label27: TLabel;
    Label30: TLabel;
    PageControl4: TPageControl;
    TabSheet14: TTabSheet;
    GroupBox21: TGroupBox;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    IDEd: TEdit;
    DBed: TEdit;
    CsEd: TEdit;
    CBed: TEdit;
    CLed: TEdit;
    upged: TEdit;
    Soed: TEdit;
    LogEd: TEdit;
    sred1: TEdit;
    sred2: TEdit;
    GroupBox25: TGroupBox;
    CheckBoxGlobal: TCheckBox;
    Memo1: TMemo;
    TabSheet15: TTabSheet;
    ClearProgressBar: TProgressBar;
    RzSplitter1: TRzSplitter;
    GroupBox26: TGroupBox;
    Label26: TLabel;
    EditMyGetTXT: TEdit;
    ListBoxMyGetTXT: TListBox;
    Button1: TButton;
    RzSplitter2: TRzSplitter;
    GroupBox43: TGroupBox;
    Label41: TLabel;
    EditMyGetFile: TEdit;
    ListBoxMyGetFile: TListBox;
    Button7: TButton;
    GroupBox44: TGroupBox;
    Label42: TLabel;
    EditMyGetDir: TEdit;
    ListBoxMyGetDir: TListBox;
    Button2: TButton;
    BtnMyGetDirOpen: TRzRapidFireButton;
    BtnMyGetDirAdd: TRzRapidFireButton;
    BtnMyGetDirDel: TRzRapidFireButton;
    ClearSaveBtn: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    ClearServerOpenDialog: TOpenDialog;
    Label43: TLabel;
    Label44: TLabel;
    BtnMyGetTxtDel: TRzRapidFireButton;
    BtnMyGetTxtAdd: TRzRapidFireButton;
    BtnMyGetTxtOpen: TRzRapidFireButton;
    BtnMyGetFileOpen: TRzRapidFireButton;
    BtnMyGetFileAdd: TRzRapidFireButton;
    BtnMyGetFileDel: TRzRapidFireButton;
    Label68: TLabel;
    ChrLog: TEdit;
    Label69: TLabel;
    CountLog: TEdit;
    M2Log: TEdit;
    Label70: TLabel;
    Label59: TLabel;
    GroupBox41: TGroupBox;
    Label60: TLabel;
    GroupBox45: TGroupBox;
    Label63: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    EditProductName: TEdit;
    EditVersion: TEdit;
    EditUpDateTime: TEdit;
    EditProgram: TEdit;
    EditWebSite: TEdit;
    EditBbsSite: TEdit;
    EdtSort: TEdit;
    Label76: TLabel;
    RzBalloonHints1: TRzBalloonHints;
    CheckBoxUserData: TCheckBox;
    CheckBoxMasterNo: TCheckBox;
    CheckBoxRunGate3: TCheckBox;
    CheckBoxRunGate4: TCheckBox;
    CheckBoxRunGate5: TCheckBox;
    CheckBoxRunGate6: TCheckBox;
    CheckBoxRunGate7: TCheckBox;
    Label77: TLabel;
    Label78: TLabel;
    Edit1: TEdit;
    Image1: TImage;
    procedure ButtonNext1Click(Sender: TObject);
    procedure ButtonPrv2Click(Sender: TObject);
    procedure ButtonNext2Click(Sender: TObject);
    procedure ButtonPrv3Click(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonGenGameConfigClick(Sender: TObject);
    procedure ButtonStartGameClick(Sender: TObject);
    procedure TimerStartGameTimer(Sender: TObject);
    procedure CheckBoxDBServerClick(Sender: TObject);
    procedure CheckBoxLoginServerClick(Sender: TObject);
    procedure CheckBoxM2ServerClick(Sender: TObject);
    procedure CheckBoxLogServerClick(Sender: TObject);
    procedure CheckBoxLoginGateClick(Sender: TObject);
    procedure CheckBoxSelGateClick(Sender: TObject);
    procedure CheckBoxRunGateClick(Sender: TObject);
    procedure CheckBoxRunGate1Click(Sender: TObject);
    procedure CheckBoxRunGate2Click(Sender: TObject);
    procedure TimerStopGameTimer(Sender: TObject);
    procedure TimerCheckRunTimer(Sender: TObject);
    procedure ButtonReLoadConfigClick(Sender: TObject);
    procedure EditLoginGate_MainFormXChange(Sender: TObject);
    procedure EditLoginGate_MainFormYChange(Sender: TObject);
    procedure EditSelGate_MainFormXChange(Sender: TObject);
    procedure EditSelGate_MainFormYChange(Sender: TObject);
    procedure EditLoginServer_MainFormXChange(Sender: TObject);
    procedure EditLoginServer_MainFormYChange(Sender: TObject);
    procedure EditDBServer_MainFormXChange(Sender: TObject);
    procedure EditDBServer_MainFormYChange(Sender: TObject);
    procedure EditLogServer_MainFormXChange(Sender: TObject);
    procedure EditLogServer_MainFormYChange(Sender: TObject);
    procedure EditM2Server_MainFormXChange(Sender: TObject);
    procedure EditM2Server_MainFormYChange(Sender: TObject);
    procedure MemoLogChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonNext3Click(Sender: TObject);
    procedure ButtonNext4Click(Sender: TObject);
    procedure ButtonNext5Click(Sender: TObject);
    procedure ButtonNext6Click(Sender: TObject);
    procedure ButtonNext7Click(Sender: TObject);
    procedure ButtonPrv4Click(Sender: TObject);
    procedure ButtonPrv5Click(Sender: TObject);
    procedure ButtonPrv6Click(Sender: TObject);
    procedure ButtonPrv7Click(Sender: TObject);
    procedure ButtonPrv8Click(Sender: TObject);
    procedure ButtonNext8Click(Sender: TObject);
    procedure ButtonPrv9Click(Sender: TObject);
    procedure EditRunGate_ConntChange(Sender: TObject);
    procedure CheckBoxTwoServerClick(Sender: TObject);
    procedure CheckBoxDisableAutoGameClick(Sender: TObject);
    procedure ButtonRunGateDefaultClick(Sender: TObject);
    procedure ButtonGeneralDefalultClick(Sender: TObject);
    procedure ButtonLoginGateDefaultClick(Sender: TObject);
    procedure ButtonSelGateDefaultClick(Sender: TObject);
    procedure ButtonLoginSrvDefaultClick(Sender: TObject);
    procedure ButtonDBServerDefaultClick(Sender: TObject);
    procedure ButtonLogServerDefaultClick(Sender: TObject);
    procedure ButtonM2ServerDefaultClick(Sender: TObject);
    procedure CheckBoxboLoginGate_GetStartClick(Sender: TObject);
    procedure CheckBoxboSelGate_GetStartClick(Sender: TObject);
    procedure TimerCheckDebugTimer(Sender: TObject);
    procedure ButtonM2SuspendClick(Sender: TObject);
    procedure EditM2Server_TestLevelChange(Sender: TObject);
    procedure EditM2Server_TestGoldChange(Sender: TObject);
    procedure CheckBoxboLoginServer_GetStartClick(Sender: TObject);
    procedure CheckBoxDBServerGetStartClick(Sender: TObject);
    procedure CheckBoxLogServerGetStartClick(Sender: TObject);
    procedure CheckBoxM2ServerGetStartClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ButBakAddClick(Sender: TObject);
    procedure ListViewBakClick(Sender: TObject);
    procedure ButBakDelClick(Sender: TObject);
    procedure ButBakChgClick(Sender: TObject);
    procedure ButBakStartClick(Sender: TObject);
    procedure EditDataChange(Sender: TObject);
    procedure TimerBakTimer(Sender: TObject);
    procedure ButBakSaveClick(Sender: TObject);
    procedure RadioBak1Click(Sender: TObject);
    procedure RadioBak2Click(Sender: TObject);
    procedure ListViewBakDeletion(Sender: TObject; Item: TListItem);
    procedure CheckBoxDynamicIPModeClick(Sender: TObject);
    procedure RadioButtonMainServerClick(Sender: TObject);
    procedure RadioButtonSinceServerClick(Sender: TObject);
    procedure RzSplitter1CanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure RzSplitter2CanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure BtnMyGetDirOpenClick(Sender: TObject);
    procedure BtnMyGetFileAddClick(Sender: TObject);
    procedure BtnMyGetFileDelClick(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure ClearSaveBtnClick(Sender: TObject);
    procedure CheckBoxGlobalClick(Sender: TObject);
    procedure CheckBoxRunGate3Click(Sender: TObject);
    procedure CheckBoxRunGate4Click(Sender: TObject);
    procedure CheckBoxRunGate5Click(Sender: TObject);
    procedure CheckBoxRunGate6Click(Sender: TObject);
    procedure CheckBoxRunGate7Click(Sender: TObject);
  private
    m_boOpen: Boolean;
    m_nStartStatus: Integer;
    procedure RefGameConsole();
    procedure GenGameConfig();
    procedure GenDBServerConfig();
    procedure GenLoginServerConfig();
    procedure GenLogServerConfig();
    procedure GenM2ServerConfig();
    procedure GenLoginGateConfig();
    procedure GenSelGateConfig();
    procedure GenRunGateConfig;
    procedure StartGame();
    procedure StopGame();
    procedure MainOutMessage(sMsg: string);
    procedure ProcessDBServerMsg(wIdent: Word; sData: String);
    procedure ProcessLoginSrvMsg(wIdent: Word; sData: String);
    procedure ProcessLogServerMsg(wIdent: Word; sData: String);

    procedure ProcessLoginGateMsg(wIdent: Word; sData: String);
    procedure ProcessLoginGate1Msg(wIdent: Word; sData: String);

    procedure ProcessSelGateMsg(wIdent: Word; sData: String);
    procedure ProcessSelGate1Msg(wIdent: Word; sData: String);

    procedure ProcessRunGateMsg(wIdent: Word; sData: String);
    procedure ProcessRunGate1Msg(wIdent: Word; sData: String);
    procedure ProcessRunGate2Msg(wIdent: Word; sData: String);
    procedure ProcessRunGate3Msg(wIdent: Word; sData: String);
    procedure ProcessRunGate4Msg(wIdent: Word; sData: String);
    procedure ProcessRunGate5Msg(wIdent: Word; sData: String);
    procedure ProcessRunGate6Msg(wIdent: Word; sData: String);
    procedure ProcessRunGate7Msg(wIdent: Word; sData: String);


    procedure ProcessM2ServerMsg(wIdent: Word; sData: String);
    procedure GetMutRunGateConfing(nIndex: Integer);

    function StartService(): Boolean;
    procedure RefGameDebug();
    procedure GenMutSelGateConfig(nIndex: Integer);


    //���ݹ���
    procedure BakModValue();
    procedure AutoBackup();
    function  RunBak(Data, Bak: string):Boolean;
    procedure LoadBakConfig();
    { Private declarations }
  public
    procedure ProcessMessage(var Msg: TMsg; var Handled: Boolean);
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;

    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses GShare, HUtil32, Grobal2, EDcode, GClearServer, EDcodeUnit;

{$R *.dfm}

//��MEMO������ַ���
procedure TfrmMain.MainOutMessage(sMsg: string);
begin
  sMsg := '[' + DateTimeToStr(Now) + '] ' + sMsg;
  MemoLog.Lines.Add(sMsg);
end;

//��һ����ť
procedure TfrmMain.ButtonNext1Click(Sender: TObject);
var
  sGameDirectory: String;
  sHeroDBName: String;
  sGameName: String;
  sExtIPAddr: String;
begin
  sGameDirectory := Trim(EditGameDir.Text);
  sHeroDBName := Trim(EditHeroDB.Text);

  sGameName := Trim(EditGameName.Text);
  sExtIPAddr := Trim(EditGameExtIPaddr.Text);
  if sGameName = '' then begin
    Application.MessageBox('��Ϸ�������������벻��ȷ������', '��ʾ��Ϣ', MB_OK + MB_ICONEXCLAMATION);
    EditGameName.SetFocus;
    exit;
  end;
  if (sExtIPAddr = '') or not IsIPaddr(sExtIPAddr) then begin
    Application.MessageBox('��Ϸ�������ⲿIP��ַ���벻��ȷ������', '��ʾ��Ϣ', MB_OK + MB_ICONEXCLAMATION);
    EditGameExtIPaddr.SetFocus;
    exit;
  end;

  if (sGameDirectory = '') or not DirectoryExists(sGameDirectory) then begin
    Application.MessageBox('��ϷĿ¼���벻��ȷ������', '��ʾ��Ϣ', MB_OK + MB_ICONEXCLAMATION);
    EditGameDir.SetFocus;
    exit;
  end;
  if not (sGameDirectory[length(sGameDirectory)] = '\') then begin
    Application.MessageBox('��ϷĿ¼�������һ���ַ�����Ϊ"\"������', '��ʾ��Ϣ', MB_OK + MB_ICONEXCLAMATION);
    EditGameDir.SetFocus;
    exit;
  end;
  if sHeroDBName = '' then begin
    Application.MessageBox('��Ϸ���ݿ��������벻��ȷ������', '��ʾ��Ϣ', MB_OK + MB_ICONEXCLAMATION);
    EditHeroDB.SetFocus;
    exit;
  end;
  g_sGameDirectory := sGameDirectory;
  
  g_sHeroDBName := sHeroDBName;
  g_sGameName := sGameName;
  g_sExtIPaddr := sExtIPAddr;
  g_boDynamicIPMode := CheckBoxDynamicIPMode.Checked;

  PageControl3.ActivePageIndex := 1;
end;

procedure TfrmMain.ButtonPrv2Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 0;
end;

procedure TfrmMain.ButtonNext2Click(Sender: TObject);
var
  nPort: Integer;
begin
  nPort := Str_ToInt(Trim(EditLoginGate_GatePort.Text), -1);
  if (nPort < 0) or (nPort > 65535) then begin
    Application.MessageBox('���ض˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditLoginGate_GatePort.SetFocus;
    exit;
  end;
  g_nLoginGate_GatePort := nPort;
  PageControl3.ActivePageIndex := 2;
end;

procedure TfrmMain.ButtonPrv3Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 1;
end;
procedure TfrmMain.ButtonNext3Click(Sender: TObject);
var
  nPort: Integer;
begin
  nPort := Str_ToInt(Trim(EditSelGate_GatePort.Text), -1);
  if (nPort < 0) or (nPort > 65535) then begin
    Application.MessageBox('���ض˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditSelGate_GatePort.SetFocus;
    exit;
  end;
  g_nSeLGate_GatePort := nPort;

  nPort := Str_ToInt(Trim(EditSelGate_GatePort1.Text), -1);
  if (nPort < 0) or (nPort > 65535) then begin
    Application.MessageBox('���ض˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditSelGate_GatePort1.SetFocus;
    exit;
  end;
  g_nSeLGate_GatePort1 := nPort;
  PageControl3.ActivePageIndex := 3;
end;

procedure TfrmMain.ButtonNext4Click(Sender: TObject);
var
  nPort1, nPort2, nPort3, nPort4, nPort5, nPort6, nPort7, nPort8: Integer;
begin
  nPort1 := Str_ToInt(Trim(EditRunGate_GatePort1.Text), -1);
  nPort2 := Str_ToInt(Trim(EditRunGate_GatePort2.Text), -1);
  nPort3 := Str_ToInt(Trim(EditRunGate_GatePort3.Text), -1);
  nPort4 := Str_ToInt(Trim(EditRunGate_GatePort4.Text), -1);
  nPort5 := Str_ToInt(Trim(EditRunGate_GatePort5.Text), -1);
  nPort6 := Str_ToInt(Trim(EditRunGate_GatePort6.Text), -1);
  nPort7 := Str_ToInt(Trim(EditRunGate_GatePort7.Text), -1);
  nPort8 := Str_ToInt(Trim(EditRunGate_GatePort8.Text), -1);

  if (nPort1 < 0) or (nPort1 > 65535) then begin
    Application.MessageBox('����һ�˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort1.SetFocus;
    exit;
  end;
  if (nPort2 < 0) or (nPort2 > 65535) then begin
    Application.MessageBox('���ض��˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort2.SetFocus;
    exit;
  end;
  if (nPort3 < 0) or (nPort3 > 65535) then begin
    Application.MessageBox('�������˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort3.SetFocus;
    exit;
  end;
  if (nPort4 < 0) or (nPort4 > 65535) then begin
    Application.MessageBox('�����Ķ˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort4.SetFocus;
    exit;
  end;
  if (nPort5 < 0) or (nPort5 > 65535) then begin
    Application.MessageBox('������˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort5.SetFocus;
    exit;
  end;
  if (nPort6 < 0) or (nPort6 > 65535) then begin
    Application.MessageBox('�������˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort6.SetFocus;
    exit;
  end;
  if (nPort7 < 0) or (nPort7 > 65535) then begin
    Application.MessageBox('�����߶˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort7.SetFocus;
    exit;
  end;
  if (nPort8 < 0) or (nPort8 > 65535) then begin
    Application.MessageBox('���ذ˶˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditRunGate_GatePort8.SetFocus;
    exit;
  end;

  g_nRunGate_GatePort := nPort1;
  g_nRunGate1_GatePort := nPort2;
  g_nRunGate2_GatePort := nPort3;
  g_nRunGate3_GatePort := nPort4;
  g_nRunGate4_GatePort := nPort5;
  g_nRunGate5_GatePort := nPort6;
  g_nRunGate6_GatePort := nPort7;
  g_nRunGate7_GatePort := nPort8;

  PageControl3.ActivePageIndex := 4;
end;

procedure TfrmMain.ButtonNext5Click(Sender: TObject);
var
  nGatePort, nServerPort, nMonPort: Integer;
begin
  nGatePort := Str_ToInt(Trim(EditLoginServerGatePort.Text), -1);
  nServerPort := Str_ToInt(Trim(EditLoginServerServerPort.Text), -1);
  nMonPort := Str_ToInt(Trim(EditLoginServerMonPort.Text), -1);

  if (nMonPort < 0) or (nMonPort > 65535) then begin
    Application.MessageBox('��ض˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditLoginServerMonPort.SetFocus;
    exit;
  end;
  if (nGatePort < 0) or (nGatePort > 65535) then begin
    Application.MessageBox('���ض˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditLoginServerGatePort.SetFocus;
    exit;
  end;
  if (nServerPort < 0) or (nServerPort > 65535) then begin
    Application.MessageBox('ͨѶ�˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditLoginServerServerPort.SetFocus;
    exit;
  end;
  g_nLoginServer_GatePort := nGatePort;
  g_nLoginServer_ServerPort := nServerPort;
  g_nLoginServer_MonPort := nMonPort;
  PageControl3.ActivePageIndex := 5;
end;

procedure TfrmMain.ButtonNext6Click(Sender: TObject);
var
  nGatePort, nServerPort: Integer;
begin
  nGatePort := Str_ToInt(Trim(EditDBServerGatePort.Text), -1);
  nServerPort := Str_ToInt(Trim(EditDBServerServerPort.Text), -1);

  if (nGatePort < 0) or (nGatePort > 65535) then begin
    Application.MessageBox('���ض˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditDBServerGatePort.SetFocus;
    exit;
  end;
  if (nServerPort < 0) or (nServerPort > 65535) then begin
    Application.MessageBox('ͨѶ�˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditDBServerServerPort.SetFocus;
    exit;
  end;
  g_nDBServer_Config_GatePort := nGatePort;
  g_nDBServer_Config_ServerPort := nServerPort;
  PageControl3.ActivePageIndex := 6;
end;

procedure TfrmMain.ButtonNext7Click(Sender: TObject);
var
  nPort: Integer;
begin
  nPort := Str_ToInt(Trim(EditLogServerPort.Text), -1);
  if (nPort < 0) or (nPort > 65535) then begin
    Application.MessageBox('�˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditLogServerPort.SetFocus;
    exit;
  end;
  g_nLogServer_Port := nPort;
  PageControl3.ActivePageIndex := 7;
end;
procedure TfrmMain.ButtonNext8Click(Sender: TObject);
var
  nGatePort, nMsgSrvPort: Integer;
begin
  nGatePort := Str_ToInt(Trim(EditM2ServerGatePort.Text), -1);
  nMsgSrvPort := Str_ToInt(Trim(EditM2ServerMsgSrvPort.Text), -1);
  if (nGatePort < 0) or (nGatePort > 65535) then begin
    Application.MessageBox('���ض˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditM2ServerGatePort.SetFocus;
    exit;
  end;
  if (nMsgSrvPort < 0) or (nMsgSrvPort > 65535) then begin
    Application.MessageBox('ͨѶ�˿����ô��󣡣���', '������Ϣ', MB_OK + MB_ICONERROR);
    EditM2ServerMsgSrvPort.SetFocus;
    exit;
  end;
  g_nM2Server_GatePort := nGatePort;
  g_nM2Server_MsgSrvPort := nMsgSrvPort;
  PageControl3.ActivePageIndex := 8;
end;

procedure TfrmMain.ButtonPrv4Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 2;
end;

procedure TfrmMain.ButtonPrv5Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 3;
end;

procedure TfrmMain.ButtonPrv6Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 4;
end;

procedure TfrmMain.ButtonPrv7Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 5;
end;

procedure TfrmMain.ButtonPrv8Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 6;
end;

procedure TfrmMain.ButtonPrv9Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 7;
end;

procedure TfrmMain.ButtonSaveClick(Sender: TObject);
begin
  g_IniConf.WriteInteger('GameConf', 'dwStopTimeOut', g_dwStopTimeOut);
  g_IniConf.WriteString('GameConf', 'GameDirectory', g_sGameDirectory);
  g_IniConf.WriteString('GameConf', 'HeroDBName', g_sHeroDBName);
  g_IniConf.WriteString('GameConf', 'GameName', g_sGameName);
  g_IniConf.WriteString('GameConf', 'ExtIPaddr', g_sExtIPaddr);

  g_IniConf.WriteBool('GameConf', 'DynamicIPMode', g_boDynamicIPMode);
  g_IniConf.WriteBool('GameConf', 'TwoServer', g_boTwoServer);

  g_IniConf.WriteInteger('GameConf', 'ServerNum', g_nServerNum);


  g_IniConf.WriteInteger('DBServer', 'MainFormX', g_nDBServer_MainFormX);
  g_IniConf.WriteInteger('DBServer', 'MainFormY', g_nDBServer_MainFormY);
  g_IniConf.WriteInteger('DBServer', 'GatePort', g_nDBServer_Config_GatePort);
  g_IniConf.WriteInteger('DBServer', 'ServerPort', g_nDBServer_Config_ServerPort);
  g_IniConf.WriteBool('DBServer', 'DisableAutoGame', g_boDBServer_DisableAutoGame);
  g_IniConf.WriteBool('DBServer', 'GetStart', g_boDBServer_GetStart);

  g_IniConf.WriteInteger('M2Server', 'MainFormX', g_nM2Server_MainFormX);
  g_IniConf.WriteInteger('M2Server', 'MainFormY', g_nM2Server_MainFormY);
  g_IniConf.WriteInteger('M2Server', 'TestLevel', g_nM2Server_TestLevel);
  g_IniConf.WriteInteger('M2Server', 'TestGold', g_nM2Server_TestGold);

  g_IniConf.WriteInteger('M2Server', 'GatePort', g_nM2Server_GatePort);
  g_IniConf.WriteInteger('M2Server', 'MsgSrvPort', g_nM2Server_MsgSrvPort);
  g_IniConf.WriteBool('M2Server', 'GetStart', g_boM2Server_GetStart);

  g_IniConf.WriteInteger('RunGate', 'GatePort1', g_nRunGate_GatePort);
  g_IniConf.WriteInteger('RunGate', 'GatePort2', g_nRunGate1_GatePort);
  g_IniConf.WriteInteger('RunGate', 'GatePort3', g_nRunGate2_GatePort);
  g_IniConf.WriteInteger('RunGate', 'GatePort4', g_nRunGate3_GatePort);
  g_IniConf.WriteInteger('RunGate', 'GatePort5', g_nRunGate4_GatePort);
  g_IniConf.WriteInteger('RunGate', 'GatePort6', g_nRunGate5_GatePort);
  g_IniConf.WriteInteger('RunGate', 'GatePort7', g_nRunGate6_GatePort);
  g_IniConf.WriteInteger('RunGate', 'GatePort8', g_nRunGate7_GatePort);

  g_IniConf.WriteInteger('LoginGate', 'MainFormX', g_nLoginGate_MainFormX);
  g_IniConf.WriteInteger('LoginGate', 'MainFormY', g_nLoginGate_MainFormY);
  g_IniConf.WriteBool('LoginGate', 'GetStart', g_boLoginGate_GetStart);
  g_IniConf.WriteInteger('LoginGate', 'GatePort', g_nLoginGate_GatePort);


  g_IniConf.WriteInteger('SelGate', 'MainFormX', g_nSelGate_MainFormX);
  g_IniConf.WriteInteger('SelGate', 'MainFormY', g_nSelGate_MainFormY);
  g_IniConf.WriteBool('SelGate', 'GetStart', g_boSelGate_GetStart);

  g_IniConf.WriteInteger('SelGate', 'GatePort', g_nSeLGate_GatePort);
  g_IniConf.WriteInteger('SelGate', 'GatePort1', g_nSeLGate_GatePort1);


  g_IniConf.WriteInteger('RunGate', 'Count', g_nRunGate_Count);

  g_IniConf.WriteInteger('LoginServer', 'MainFormX', g_nLoginServer_MainFormX);
  g_IniConf.WriteInteger('LoginServer', 'MainFormY', g_nLoginServer_MainFormY);
  g_IniConf.WriteInteger('LoginServer', 'GatePort', g_nLoginServer_GatePort);
  g_IniConf.WriteInteger('LoginServer', 'MonPort', g_nLoginServer_MonPort);
  g_IniConf.WriteInteger('LoginServer', 'ServerPort', g_nLoginServer_ServerPort);
  g_IniConf.WriteBool('LoginServer', 'GetStart', g_boLoginServer_GetStart);


  g_IniConf.WriteInteger('LogServer', 'MainFormX', g_nLogServer_MainFormX);
  g_IniConf.WriteInteger('LogServer', 'MainFormY', g_nLogServer_MainFormY);

  g_IniConf.WriteInteger('LogServer', 'Port', g_nLogServer_Port);
  g_IniConf.WriteBool('LogServer', 'GetStart', g_boLogServer_GetStart);


  Application.MessageBox('�����ļ��Ѿ��������...', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
  if Application.MessageBox('�Ƿ������µ���Ϸ�����������ļ�...', '��ʾ��Ϣ', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    ButtonGenGameConfigClick(ButtonGenGameConfig);
  end;
  PageControl3.ActivePageIndex := 0;
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
  function GetDayOfWeek:string;
  begin
    case DayOfWeek(Date) of
      1:Result:='������';
      2:Result:='����һ';
      3:Result:='���ڶ�';
      4:Result:='������';
      5:Result:='������';
      6:Result:='������';
      7:Result:='������';
    end;
  end;
var
  sProductName: string;
  sVersion: string;
  sUpDateTime: string;
  sProgram: string;
  sWebSite: string;
  sBbsSite: string;
  Date: TDateTime;
begin
  Decode(g_sProductName, sProductName);
  Decode(g_sVersion, sVersion);
  Decode(g_sUpDateTime, sUpDateTime);
  Decode(g_sProgram, sProgram);
  Decode(g_sWebSite, sWebSite);
  Decode(g_sBbsSite, sBbsSite);
  EditProductName.Text := sProductName;
  EditVersion.Text := sVersion;
  EditUpDateTime.Text := sUpDateTime;
  EditProgram.Text := sProgram;
  EditWebSite.Text := sWebSite;
  EditBbsSite.Text := sBbsSite;
  Date := Now();
  Caption := Caption + ' ['+FormatDateTime('yyyy-mm-dd',Date)+' ' + GetDayOfWeek + ']';

  m_boOpen := False;

//  Application.OnMessage:=ProcessMessage;
  PageControl1.ActivePageIndex := 0;
  PageControl3.ActivePageIndex := 0;
  m_nStartStatus := 0;
  MemoLog.Clear;


  LoadConfig();
  
  if g_boTwoServer then begin
    CheckBoxTwoServer.Checked := True;
    GroupBox6.Visible := True;
  end;
  if g_nServerNum = 0 then
    RadioButtonMainServer.Checked := True
  else
    RadioButtonSinceServer.Checked := True;

  if not StartService() then exit;
  RefGameConsole();
  TabSheetDebug.TabVisible := False;
  if g_boShowDebugTab then begin
    TabSheetDebug.TabVisible := True;
    TimerCheckDebug.Enabled := True;
  end;

  m_boOpen := True;
 // MainOutMessage('��Ϸ�����������ɹ�...');
//  SetWindowPos(Self.Handle,HWND_TOPMOST,Self.Left,Self.Top,Self.Width,Self.Height,$40);

//���������
  Clear_LoadIniConf();

//���ݹ��ܴ���
  LoadBakConfig();
  if CheckBoxBakAuto.Checked then ButBakStart.Click;
  ButBakDel.Enabled := False;
  ButBakChg.Enabled := False;

  if CompareText(ParamStr(1), 'start') = 0 then StartGame();   //20080804 ���������� ֱ������
end;

procedure TfrmMain.ButtonGenGameConfigClick(Sender: TObject);
begin
  //  ButtonGenGameConfig.Enabled:=False;
  GenGameConfig();
  RefGameConsole();
  Application.MessageBox('IGE�Ƽ����������ļ��Ѿ��������...', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
end;
procedure TfrmMain.GenGameConfig;
begin
  GenDBServerConfig();
  GenLoginServerConfig();
  GenLogServerConfig();
  GenM2ServerConfig();
  GenLoginGateConfig();
  GenSelGateConfig();
  GenRunGateConfig();
end;

procedure TfrmMain.GenDBServerConfig;
var
  IniGameConf: TIniFile;
  sIniFile: String;
  SaveList: TStringList;
begin
  sIniFile := g_sGameDirectory + g_sDBServer_Directory;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  IniGameConf := TIniFile.Create(sIniFile + g_sDBServer_ConfigFile);

  IniGameConf.WriteString('Setup', 'ServerName', g_sGameName);
  IniGameConf.WriteString('Setup', 'ServerAddr', g_sDBServer_Config_ServerAddr);
  IniGameConf.WriteInteger('Setup', 'ServerPort', g_nDBServer_Config_ServerPort);
  IniGameConf.WriteString('Setup', 'MapFile', g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_EnvirDir + g_sDBServer_Config_MapFile);//20081214
  IniGameConf.WriteString('Setup', 'DBName', g_sHeroDBName);//20081214
  IniGameConf.WriteBool('Setup', 'ViewHackMsg', g_boDBServer_Config_ViewHackMsg);
  IniGameConf.WriteBool('Setup', 'DynamicIPMode', g_boDynamicIPMode);
  IniGameConf.WriteBool('Setup', 'DisableAutoGame', g_boDBServer_DisableAutoGame);
  IniGameConf.WriteString('Setup', 'GateAddr', g_sDBServer_Config_GateAddr);
  IniGameConf.WriteInteger('Setup', 'GatePort', g_nDBServer_Config_GatePort);

  IniGameConf.WriteString('Server', 'IDSAddr', g_sLoginServer_ServerAddr); //��¼������IP
  IniGameConf.WriteInteger('Server', 'IDSPort', g_nLoginServer_ServerPort); //��¼�������˿�

  IniGameConf.WriteInteger('DBClear', 'Interval', g_nDBServer_Config_Interval);
  IniGameConf.WriteInteger('DBClear', 'Level1', g_nDBServer_Config_Level1);
  IniGameConf.WriteInteger('DBClear', 'Level2', g_nDBServer_Config_Level2);
  IniGameConf.WriteInteger('DBClear', 'Level3', g_nDBServer_Config_Level3);
  IniGameConf.WriteInteger('DBClear', 'Day1', g_nDBServer_Config_Day1);
  IniGameConf.WriteInteger('DBClear', 'Day2', g_nDBServer_Config_Day2);
  IniGameConf.WriteInteger('DBClear', 'Day3', g_nDBServer_Config_Day3);
  IniGameConf.WriteInteger('DBClear', 'Month1', g_nDBServer_Config_Month1);
  IniGameConf.WriteInteger('DBClear', 'Month2', g_nDBServer_Config_Month2);
  IniGameConf.WriteInteger('DBClear', 'Month3', g_nDBServer_Config_Month3);

  IniGameConf.WriteString('DB', 'Dir', sIniFile + g_sDBServer_Config_Dir);
  IniGameConf.WriteString('DB', 'IdDir', sIniFile + g_sDBServer_Config_IdDir);
  IniGameConf.WriteString('DB', 'HumDir', sIniFile + g_sDBServer_Config_HumDir);
  IniGameConf.WriteString('DB', 'FeeDir', sIniFile + g_sDBServer_Config_FeeDir);
  IniGameConf.WriteString('DB', 'BackupDir', sIniFile + g_sDBServer_Config_BackupDir);
  IniGameConf.WriteString('DB', 'ConnectDir', sIniFile + g_sDBServer_Config_ConnectDir);
  IniGameConf.WriteString('DB', 'LogDir', sIniFile + g_sDBServer_Config_LogDir);
  IniGameConf.WriteString('DB', 'Sort', g_sGameDirectory + g_sM2Server_Directory + g_sDBServer_Config_SortDir);//20080617 ����

  IniGameConf.Free;

  SaveList := TStringList.Create;
  SaveList.Add(g_sLocalIPaddr);
  SaveList.Add(g_sExtIPaddr);
  SaveList.SaveToFile(sIniFile + g_sDBServer_AddrTableFile);

  SaveList.Clear;
  case g_nRunGate_Count of //
    1: SaveList.Add(format('%s %s %d', [g_sLocalIPaddr, g_sExtIPaddr, g_nRunGate_GatePort]));
    2: SaveList.Add(format('%s %s %d %s %d', [g_sLocalIPaddr, g_sExtIPaddr, g_nRunGate_GatePort, g_sExtIPaddr, g_nRunGate1_GatePort]));
    3: SaveList.Add(format('%s %s %d %s %d %s %d', [g_sLocalIPaddr, g_sExtIPaddr, g_nRunGate_GatePort, g_sExtIPaddr, g_nRunGate1_GatePort, g_sExtIPaddr, g_nRunGate2_GatePort]));
  else SaveList.Add(format('%s %s %d %s %d %s %d %s %d', [g_sLocalIPaddr, g_sExtIPaddr, g_nRunGate_GatePort, g_sExtIPaddr, g_nRunGate1_GatePort, g_sExtIPaddr, g_nRunGate2_GatePort, g_sExtIPaddr, g_nRunGate3_GatePort]));
  end;
  if g_nRunGate_Count > 4 then
    case g_nRunGate_Count of //
      5: SaveList.Add(format('%s %s %d', [g_sExtIPaddr, g_sExtIPaddr, g_nRunGate4_GatePort]));
      6: SaveList.Add(format('%s %s %d %s %d', [g_sExtIPaddr, g_sExtIPaddr, g_nRunGate4_GatePort, g_sExtIPaddr, g_nRunGate5_GatePort]));
      7: SaveList.Add(format('%s %s %d %s %d %s %d', [g_sExtIPaddr, g_sExtIPaddr, g_nRunGate4_GatePort, g_sExtIPaddr, g_nRunGate5_GatePort, g_sExtIPaddr, g_nRunGate6_GatePort]));
      8: SaveList.Add(format('%s %s %d %s %d %s %d %s %d', [g_sExtIPaddr, g_sExtIPaddr, g_nRunGate4_GatePort, g_sExtIPaddr, g_nRunGate5_GatePort, g_sExtIPaddr, g_nRunGate6_GatePort, g_sExtIPaddr, g_nRunGate7_GatePort]));
    end;

  SaveList.SaveToFile(sIniFile + g_sDBServer_ServerinfoFile);
  SaveList.Free;

  sIniFile := g_sGameDirectory + g_sDBServer_Directory + g_sDBServer_Config_Dir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sDBServer_Directory + g_sDBServer_Config_IdDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sDBServer_Directory + g_sDBServer_Config_HumDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sDBServer_Directory + g_sDBServer_Config_FeeDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sDBServer_Directory + g_sDBServer_Config_BackupDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sDBServer_Directory + g_sDBServer_Config_ConnectDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sDBServer_Directory + g_sDBServer_Config_LogDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
end;

procedure TfrmMain.GenLoginServerConfig;
var
  IniGameConf: TIniFile;
  sIniFile: String;
  SaveList: TStringList;
begin
  sIniFile := g_sGameDirectory + g_sLoginServer_Directory;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  IniGameConf := TIniFile.Create(sIniFile + g_sLoginServer_ConfigFile);
  IniGameConf.WriteInteger('Server', 'ReadyServers', g_sLoginServer_ReadyServers);

  IniGameConf.WriteString('Server', 'EnableMakingID', BoolToStr(g_sLoginServer_EnableMakingID));
  IniGameConf.WriteString('Server', 'EnableTrial', BoolToStr(g_sLoginServer_EnableTrial));
  IniGameConf.WriteString('Server', 'TestServer', BoolToStr(g_sLoginServer_TestServer));
  IniGameConf.WriteBool('Server', 'DynamicIPMode', g_boDynamicIPMode);
  IniGameConf.WriteString('Server', 'GateAddr', g_sLoginServer_GateAddr);
  IniGameConf.WriteInteger('Server', 'GatePort', g_nLoginServer_GatePort);
  IniGameConf.WriteString('Server', 'MonAddr', g_sLoginServer_MonAddr);
  IniGameConf.WriteInteger('Server', 'MonPort', g_nLoginServer_MonPort);
  IniGameConf.WriteString('Server', 'ServerAddr', g_sLoginServer_ServerAddr);
  IniGameConf.WriteString('Server', 'ServerName', g_sGameName);
  IniGameConf.WriteInteger('Server', 'ServerPort', g_nLoginServer_ServerPort);

  IniGameConf.WriteString('DB', 'IdDir', sIniFile + g_sLoginServer_IdDir);
  IniGameConf.WriteString('DB', 'FeedIDList', sIniFile + g_sLoginServer_FeedIDList);
  IniGameConf.WriteString('DB', 'FeedIPList', sIniFile + g_sLoginServer_FeedIPList);
  IniGameConf.WriteString('DB', 'CountLogDir', sIniFile + g_sLoginServer_CountLogDir);
  IniGameConf.WriteString('DB', 'WebLogDir', sIniFile + g_sLoginServer_WebLogDir);

  IniGameConf.Free;

  SaveList := TStringList.Create;
  if g_boRunGate4_GetStart then begin
    SaveList.Add(format('%s %s %s %s %s:%d %s:%d', [g_sGameName, 'Title1', g_sLocalIPaddr, g_sLocalIPaddr, g_sExtIPaddr, g_nSeLGate_GatePort, g_sExtIPaddr, g_nSeLGate_GatePort1]));
  end else begin
    SaveList.Add(format('%s %s %s %s %s:%d', [g_sGameName, 'Title1', g_sLocalIPaddr, g_sLocalIPaddr, g_sExtIPaddr, g_nSeLGate_GatePort]));
  end;

  SaveList.SaveToFile(sIniFile + g_sLoginServer_AddrTableFile);

  SaveList.Clear;
  SaveList.Add(g_sLocalIPaddr);
  SaveList.SaveToFile(sIniFile + g_sLoginServer_ServeraddrFile);

  SaveList.Clear;
  SaveList.Add(format('%s %s %d', [g_sGameName, g_sGameName, g_nLimitOnlineUser]));
  SaveList.SaveToFile(sIniFile + g_sLoginServerUserLimitFile);
  SaveList.Free;

  sIniFile := g_sGameDirectory + g_sLoginServer_Directory + g_sLoginServer_IdDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  sIniFile := g_sGameDirectory + g_sLoginServer_Directory + g_sLoginServer_CountLogDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  sIniFile := g_sGameDirectory + g_sLoginServer_Directory + g_sLoginServer_WebLogDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
end;

procedure TfrmMain.GenLogServerConfig;
var
  IniGameConf: TIniFile;
  sIniFile: String;
begin
  sIniFile := g_sGameDirectory + g_sLogServer_Directory;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  IniGameConf := TIniFile.Create(sIniFile + g_sLogServer_ConfigFile);
  IniGameConf.WriteString('Setup', 'ServerName', g_sGameName);
  IniGameConf.WriteInteger('Setup', 'Port', g_nLogServer_Port);
  IniGameConf.WriteString('Setup', 'BaseDir', sIniFile + g_sLogServer_BaseDir);

  sIniFile := sIniFile + g_sLogServer_BaseDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  IniGameConf.Free;
end;

procedure TfrmMain.GenM2ServerConfig;
var
  IniGameConf: TIniFile;
  sIniFile: String;
  SaveList: TStringList;
begin
  sIniFile := g_sGameDirectory + g_sM2Server_Directory;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  IniGameConf := TIniFile.Create(sIniFile + g_sM2Server_ConfigFile);

  IniGameConf.WriteString('Server', 'ServerName', g_sGameName);
  IniGameConf.WriteInteger('Server', 'ServerNumber', g_nM2Server_ServerNumber);
  IniGameConf.WriteInteger('Server', 'ServerIndex', g_nM2Server_ServerIndex);

  IniGameConf.WriteString('Server', 'VentureServer', BoolToStr(g_boM2Server_VentureServer));
  IniGameConf.WriteString('Server', 'TestServer', BoolToStr(g_boM2Server_TestServer));
  IniGameConf.WriteInteger('Server', 'TestLevel', g_nM2Server_TestLevel);
  IniGameConf.WriteInteger('Server', 'TestGold', g_nM2Server_TestGold);
  IniGameConf.WriteInteger('Server', 'TestServerUserLimit', g_nLimitOnlineUser);
  IniGameConf.WriteString('Server', 'ServiceMode', BoolToStr(g_boM2Server_ServiceMode));
  IniGameConf.WriteString('Server', 'NonPKServer', BoolToStr(g_boM2Server_NonPKServer));

  IniGameConf.WriteString('Server', 'DBAddr', g_sDBServer_Config_ServerAddr);
  IniGameConf.WriteInteger('Server', 'DBPort', g_nDBServer_Config_ServerPort);
  IniGameConf.WriteString('Server', 'IDSAddr', g_sLoginServer_ServerAddr);
  IniGameConf.WriteInteger('Server', 'IDSPort', g_nLoginServer_ServerPort);
  IniGameConf.WriteString('Server', 'MsgSrvAddr', g_sM2Server_MsgSrvAddr);
  IniGameConf.WriteInteger('Server', 'MsgSrvPort', g_nM2Server_MsgSrvPort);
  IniGameConf.WriteString('Server', 'LogServerAddr', g_sLogServer_ServerAddr);
  IniGameConf.WriteInteger('Server', 'LogServerPort', g_nLogServer_Port);
  IniGameConf.WriteString('Server', 'GateAddr', g_sM2Server_GateAddr);
  IniGameConf.WriteInteger('Server', 'GatePort', g_nM2Server_GatePort);

  IniGameConf.WriteString('Server', 'DBName', g_sHeroDBName);


  IniGameConf.WriteInteger('Server', 'UserFull', g_nLimitOnlineUser);

  IniGameConf.WriteString('Share', 'BaseDir', sIniFile + g_sM2Server_BaseDir);
  IniGameConf.WriteString('Share', 'GuildDir', sIniFile + g_sM2Server_GuildDir);
  IniGameConf.WriteString('Share', 'GuildFile', sIniFile + g_sM2Server_GuildFile);
  IniGameConf.WriteString('Share', 'VentureDir', sIniFile + g_sM2Server_VentureDir);
  IniGameConf.WriteString('Share', 'ConLogDir', sIniFile + g_sM2Server_ConLogDir);
  IniGameConf.WriteString('Share', 'LogDir', sIniFile + g_sM2Server_LogDir);

  IniGameConf.WriteString('Share', 'CastleDir', sIniFile + g_sM2Server_CastleDir);
  IniGameConf.WriteString('Share', 'SortDir', sIniFile + g_sDBServer_Config_SortDir);//20080617 ����
  IniGameConf.WriteString('Share', 'EnvirDir', sIniFile + g_sM2Server_EnvirDir);
  IniGameConf.WriteString('Share', 'MapDir', sIniFile + g_sM2Server_MapDir);
  IniGameConf.WriteString('Share', 'NoticeDir', sIniFile + g_sM2Server_NoticeDir);

  IniGameConf.WriteString('Share', 'PlugDir', sIniFile);//20081214
  IniGameConf.WriteString('Share', 'CastleFile', sIniFile + g_sM2Server_CastleFile);//20081214
  IniGameConf.WriteString('Share', 'BoxsDir', sIniFile + g_sM2Server_BoxsDir);//20081214
  IniGameConf.WriteString('Share', 'BoxsFile', sIniFile + g_sM2Server_BoxsFile);//20081214

  IniGameConf.Free;

  sIniFile := g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_BaseDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_GuildDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_VentureDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_ConLogDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_LogDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_CastleDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_EnvirDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_MapDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  sIniFile := g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_NoticeDir;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;

  sIniFile := g_sGameDirectory + g_sM2Server_Directory;
  SaveList := TStringList.Create;
  SaveList.Add('GM');
  SaveList.SaveToFile(sIniFile + g_sM2Server_AbuseFile);

  SaveList.Clear;
  SaveList.Add(g_sLocalIPaddr);
  SaveList.SaveToFile(sIniFile + g_sM2Server_RunAddrFile);

  SaveList.Clear;
  SaveList.Add(g_sLocalIPaddr);
  SaveList.SaveToFile(sIniFile + g_sM2Server_ServerTableFile);
  SaveList.Free;
end;

procedure TfrmMain.GenLoginGateConfig;
var
  IniGameConf: TIniFile;
  sIniFile: String;
begin
  sIniFile := g_sGameDirectory + g_sLoginGate_Directory;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  IniGameConf := TIniFile.Create(sIniFile + g_sLoginGate_ConfigFile);
  IniGameConf.WriteString('LoginGate', 'Title', g_sGameName);
  IniGameConf.WriteString('LoginGate', 'ServerAddr', g_sLoginGate_ServerAddr);
  IniGameConf.WriteInteger('LoginGate', 'ServerPort', g_nLoginServer_GatePort {g_nLoginGate_ServerPort});
  IniGameConf.WriteInteger('LoginGate', 'MonPort', g_nLoginServer_MonPort);
  IniGameConf.WriteString('LoginGate', 'GateAddr', g_sLoginGate_GateAddr);
  IniGameConf.WriteInteger('LoginGate', 'GatePort', g_nLoginGate_GatePort);
  IniGameConf.WriteInteger('LoginGate', 'ShowLogLevel', g_nLoginGate_ShowLogLevel);
  IniGameConf.WriteInteger('LoginGate', 'MaxConnOfIPaddr', g_nLoginGate_MaxConnOfIPaddr);
  IniGameConf.WriteInteger('LoginGate', 'BlockMethod', g_nLoginGate_BlockMethod);
  IniGameConf.WriteInteger('LoginGate', 'KeepConnectTimeOut', g_nLoginGate_KeepConnectTimeOut);
  IniGameConf.Free;
end;

procedure TfrmMain.GenSelGateConfig();
var
  IniGameConf: TIniFile;
  sIniFile: String;
begin
  sIniFile := g_sGameDirectory + g_sSelGate_Directory;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  IniGameConf := TIniFile.Create(sIniFile + g_sSelGate_ConfigFile);
  IniGameConf.WriteString('SelGate', 'Title', g_sGameName);
  IniGameConf.WriteString('SelGate', 'ServerAddr', g_sSelGate_ServerAddr);
  IniGameConf.WriteInteger('SelGate', 'ServerPort', g_nDBServer_Config_GatePort {g_nSelGate_ServerPort});
  IniGameConf.WriteString('SelGate', 'GateAddr', g_sSelGate_GateAddr);
  IniGameConf.WriteInteger('SelGate', 'GatePort', g_nSeLGate_GatePort);
  IniGameConf.WriteInteger('SelGate', 'ShowLogLevel', g_nSelGate_ShowLogLevel);
  IniGameConf.WriteInteger('SelGate', 'MaxConnOfIPaddr', g_nSelGate_MaxConnOfIPaddr);
  IniGameConf.WriteInteger('SelGate', 'BlockMethod', g_nSelGate_BlockMethod);
  IniGameConf.WriteInteger('SelGate', 'KeepConnectTimeOut', g_nSelGate_KeepConnectTimeOut);
  IniGameConf.Free;
end;

procedure TfrmMain.GenMutSelGateConfig(nIndex: Integer);
var
  IniGameConf: TIniFile;
  sIniFile: String;
  sGateAddr: String;
  nGatePort: Integer;
  sServerAddr: String;
begin
  case nIndex of //
    0: begin
        sGateAddr := g_sSelGate_GateAddr;
        nGatePort := g_nSeLGate_GatePort;
        sServerAddr := g_sLocalIPaddr;
      end;
    1: begin
        sGateAddr := g_sSelGate_GateAddr1;
        nGatePort := g_nSeLGate_GatePort1;
        sServerAddr := g_sExtIPaddr;
      end;
  end;
  sIniFile := g_sGameDirectory + g_sSelGate_Directory;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;  
  IniGameConf := TIniFile.Create(sIniFile + g_sSelGate_ConfigFile);
  IniGameConf.WriteString('SelGate', 'Title', g_sGameName);
  IniGameConf.WriteString('SelGate', 'ServerAddr', sServerAddr {g_sSelGate_ServerAddr});
  IniGameConf.WriteInteger('SelGate', 'ServerPort', {g_nSelGate_ServerPort}g_nDBServer_Config_GatePort);
  IniGameConf.WriteString('SelGate', 'GateAddr', sGateAddr);
  IniGameConf.WriteInteger('SelGate', 'GatePort', nGatePort);
  IniGameConf.WriteInteger('SelGate', 'ShowLogLevel', g_nSelGate_ShowLogLevel);
  IniGameConf.WriteInteger('SelGate', 'MaxConnOfIPaddr', g_nSelGate_MaxConnOfIPaddr);
  IniGameConf.WriteInteger('SelGate', 'BlockMethod', g_nSelGate_BlockMethod);
  IniGameConf.WriteInteger('SelGate', 'KeepConnectTimeOut', g_nSelGate_KeepConnectTimeOut);
  IniGameConf.Free;
end;

procedure TfrmMain.GenRunGateConfig;
var
  IniGameConf: TIniFile;
  sIniFile: String;
begin
  sIniFile := g_sGameDirectory + g_sRunGate_Directory;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  IniGameConf := TIniFile.Create(sIniFile + g_sRunGate_ConfigFile);
  IniGameConf.WriteString('server', 'Title', g_sGameName + '(' + IntToStr(g_nRunGate_GatePort) + ')');
  IniGameConf.WriteString('server', 'Server1', g_sRunGate_ServerAddr);
  IniGameConf.WriteInteger('server', 'ServerPort', g_nM2Server_GatePort {g_nRunGate_ServerPort});
  IniGameConf.WriteString('server', 'GateAddr', g_sRunGate_GateAddr);
  IniGameConf.WriteInteger('server', 'GatePort', g_nRunGate_GatePort);

  IniGameConf.Free;
end;

procedure TfrmMain.RefGameConsole;
begin
  m_boOpen := False;
  //EditM2ServerProgram.Text := g_sGameDirectory + g_sM2Server_Directory + g_sM2Server_ProgramFile;
  //EditDBServerProgram.Text := g_sGameDirectory + g_sDBServer_Directory + g_sDBServer_ProgramFile;

  EditLoginSrvProgram.Text := g_sGameDirectory + g_sLoginServer_Directory + g_sLoginServer_ProgramFile;
  EditLogServerProgram.Text := g_sGameDirectory + g_sLogServer_Directory + g_sLogServer_ProgramFile;
  EditLoginGateProgram.Text := g_sGameDirectory + g_sLoginGate_Directory + g_sLoginGate_ProgramFile;
  EditSelGateProgram.Text := g_sGameDirectory + g_sSelGate_Directory + g_sSelGate_ProgramFile;
  EditRunGateProgram.Text := g_sGameDirectory + g_sRunGate_Directory + g_sRunGate_ProgramFile;
  EditRunGate1Program.Text := g_sGameDirectory + g_sRunGate_Directory + g_sRunGate_ProgramFile;
  EditRunGate2Program.Text := g_sGameDirectory + g_sRunGate_Directory + g_sRunGate_ProgramFile;

  CheckBoxM2Server.Checked := g_boM2Server_GetStart;
  CheckBoxM2Server.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sM2Server_Directory, g_sM2Server_ProgramFile]);

  CheckBoxDBServer.Checked := g_boDBServer_GetStart;
  CheckBoxDBServer.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sDBServer_Directory, g_sDBServer_ProgramFile]);

  CheckBoxLoginServer.Checked := g_boLoginServer_GetStart;
  CheckBoxLoginServer.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sLoginServer_Directory, g_sLoginServer_ProgramFile]);

  CheckBoxLogServer.Checked := g_boLogServer_GetStart;
  CheckBoxLogServer.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sLogServer_Directory, g_sLogServer_ProgramFile]);

  CheckBoxLoginGate.Checked := g_boLoginGate_GetStart;
  CheckBoxLoginGate.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sLoginGate_Directory, g_sLoginGate_ProgramFile]);

  CheckBoxSelGate.Checked := g_boSelGate_GetStart;
  CheckBoxSelGate.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sSelGate_Directory, g_sSelGate_ProgramFile]);

  CheckBoxRunGate.Checked := g_boRunGate_GetStart;
  CheckBoxRunGate.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sRunGate_Directory, g_sRunGate_ProgramFile]);

  CheckBoxRunGate1.Checked := g_boRunGate1_GetStart;
  CheckBoxRunGate1.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sRunGate_Directory, g_sRunGate_ProgramFile]);

  CheckBoxRunGate2.Checked := g_boRunGate2_GetStart;
  CheckBoxRunGate2.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sRunGate_Directory, g_sRunGate_ProgramFile]);

  CheckBoxRunGate3.Checked := g_boRunGate3_GetStart;
  CheckBoxRunGate3.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sRunGate_Directory, g_sRunGate_ProgramFile]);

  CheckBoxRunGate4.Checked := g_boRunGate4_GetStart;
  CheckBoxRunGate4.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sRunGate_Directory, g_sRunGate_ProgramFile]);

  CheckBoxRunGate5.Checked := g_boRunGate5_GetStart;
  CheckBoxRunGate5.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sRunGate_Directory, g_sRunGate_ProgramFile]);

  CheckBoxRunGate6.Checked := g_boRunGate6_GetStart;
  CheckBoxRunGate6.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sRunGate_Directory, g_sRunGate_ProgramFile]);

  CheckBoxRunGate7.Checked := g_boRunGate7_GetStart;
  CheckBoxRunGate7.Hint := format('��������λ��: %s%s%s', [g_sGameDirectory, g_sRunGate_Directory, g_sRunGate_ProgramFile]);
  EditGameDir.Text := g_sGameDirectory;
  EditHeroDB.Text := g_sHeroDBName;
  EditGameName.Text := g_sGameName;
  EditGameExtIPaddr.Text := g_sExtIPaddr;
  CheckBoxTwoServer.Checked := g_boTwoServer;
  CheckBoxDynamicIPMode.Checked := g_boDynamicIPMode;
  EditGameExtIPaddr.Enabled := not g_boDynamicIPMode;

  EditLoginGate_MainFormX.Value := g_nLoginGate_MainFormX;
  EditLoginGate_MainFormY.Value := g_nLoginGate_MainFormY;
  CheckBoxboLoginGate_GetStart.Checked := g_boLoginGate_GetStart;
  EditLoginGate_GatePort.Text := IntToStr(g_nLoginGate_GatePort);

  EditSelGate_MainFormX.Value := g_nSelGate_MainFormX;
  EditSelGate_MainFormY.Value := g_nSelGate_MainFormY;
  CheckBoxboSelGate_GetStart.Checked := g_boSelGate_GetStart;
  EditSelGate_GatePort.Text := IntToStr(g_nSeLGate_GatePort);
  EditSelGate_GatePort1.Text := IntToStr(g_nSeLGate_GatePort1);

  EditRunGate_Connt.Value := g_nRunGate_Count;
  EditRunGate_GatePort1.Text := IntToStr(g_nRunGate_GatePort);
  EditRunGate_GatePort2.Text := IntToStr(g_nRunGate1_GatePort);
  EditRunGate_GatePort3.Text := IntToStr(g_nRunGate2_GatePort);
  EditRunGate_GatePort4.Text := IntToStr(g_nRunGate3_GatePort);
  EditRunGate_GatePort5.Text := IntToStr(g_nRunGate4_GatePort);
  EditRunGate_GatePort6.Text := IntToStr(g_nRunGate5_GatePort);
  EditRunGate_GatePort7.Text := IntToStr(g_nRunGate6_GatePort);
  EditRunGate_GatePort8.Text := IntToStr(g_nRunGate7_GatePort);

  EditLoginServer_MainFormX.Value := g_nLoginServer_MainFormX;
  EditLoginServer_MainFormY.Value := g_nLoginServer_MainFormY;
  EditLoginServerGatePort.Text := IntToStr(g_nLoginServer_GatePort);
  EditLoginServerMonPort.Text := IntToStr(g_nLoginServer_MonPort);
  EditLoginServerServerPort.Text := IntToStr(g_nLoginServer_ServerPort);
  CheckBoxboLoginServer_GetStart.Checked := g_boLoginServer_GetStart;

  EditDBServer_MainFormX.Value := g_nDBServer_MainFormX;
  EditDBServer_MainFormY.Value := g_nDBServer_MainFormY;
  EditDBServerGatePort.Text := IntToStr(g_nDBServer_Config_GatePort);
  EditDBServerServerPort.Text := IntToStr(g_nDBServer_Config_ServerPort);
  CheckBoxDisableAutoGame.Checked := g_boDBServer_DisableAutoGame;
  CheckBoxDBServerGetStart.Checked := g_boDBServer_GetStart;

  EditLogServer_MainFormX.Value := g_nLogServer_MainFormX;
  EditLogServer_MainFormY.Value := g_nLogServer_MainFormY;
  EditLogServerPort.Text := IntToStr(g_nLogServer_Port);
  CheckBoxLogServerGetStart.Checked := g_boLogServer_GetStart;

  EditM2Server_MainFormX.Value := g_nM2Server_MainFormX;
  EditM2Server_MainFormY.Value := g_nM2Server_MainFormY;
  EditM2Server_TestLevel.Value := g_nM2Server_TestLevel;
  EditM2Server_TestGold.Value := g_nM2Server_TestGold;
  EditM2ServerGatePort.Text := IntToStr(g_nM2Server_GatePort);
  EditM2ServerMsgSrvPort.Text := IntToStr(g_nM2Server_MsgSrvPort);

  CheckBoxM2ServerGetStart.Checked := g_boM2Server_GetStart;
  Edit1.Text:= ExtractFilePath(Paramstr(0));
  m_boOpen := True;
end;

procedure TfrmMain.CheckBoxDBServerClick(Sender: TObject);
begin
  g_boDBServer_GetStart := CheckBoxDBServer.Checked;
end;

procedure TfrmMain.CheckBoxLoginServerClick(Sender: TObject);
begin
  g_boLoginServer_GetStart := CheckBoxLoginServer.Checked;
end;

procedure TfrmMain.CheckBoxM2ServerClick(Sender: TObject);
begin
  g_boM2Server_GetStart := CheckBoxM2Server.Checked;
end;

procedure TfrmMain.CheckBoxLogServerClick(Sender: TObject);
begin
  g_boLogServer_GetStart := CheckBoxLogServer.Checked;
end;

procedure TfrmMain.CheckBoxLoginGateClick(Sender: TObject);
begin
  g_boLoginGate_GetStart := CheckBoxLoginGate.Checked;
end;

procedure TfrmMain.CheckBoxSelGateClick(Sender: TObject);
begin
  g_boSelGate_GetStart := CheckBoxSelGate.Checked;
end;

procedure TfrmMain.CheckBoxRunGateClick(Sender: TObject);
begin
  g_boRunGate_GetStart := CheckBoxRunGate.Checked;
end;

procedure TfrmMain.CheckBoxRunGate1Click(Sender: TObject);
begin
  g_boRunGate1_GetStart := CheckBoxRunGate1.Checked;
end;

procedure TfrmMain.CheckBoxRunGate2Click(Sender: TObject);
begin
  g_boRunGate2_GetStart := CheckBoxRunGate2.Checked;
end;

procedure TfrmMain.CheckBoxRunGate3Click(Sender: TObject);
begin
  g_boRunGate3_GetStart := CheckBoxRunGate3.Checked;
end;

procedure TfrmMain.CheckBoxRunGate4Click(Sender: TObject);
begin
  g_boRunGate4_GetStart := CheckBoxRunGate4.Checked;
end;

procedure TfrmMain.CheckBoxRunGate5Click(Sender: TObject);
begin
  g_boRunGate5_GetStart := CheckBoxRunGate5.Checked;
end;

procedure TfrmMain.CheckBoxRunGate6Click(Sender: TObject);
begin
  g_boRunGate6_GetStart := CheckBoxRunGate6.Checked;
end;

procedure TfrmMain.CheckBoxRunGate7Click(Sender: TObject);
begin
  g_boRunGate7_GetStart := CheckBoxRunGate7.Checked;
end;
procedure TfrmMain.ButtonStartGameClick(Sender: TObject);
begin
  SetWindowPos(Self.Handle, Self.Handle, Self.Left, Self.Top, Self.Width, Self.Height, $40);
  case m_nStartStatus of
    0: begin
        if Application.MessageBox('�Ƿ�ȷ��������Ϸ������ ?', 'ȷ����Ϣ', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
          StartGame();
        end;
      end;
    1: begin
        if Application.MessageBox('�Ƿ�ȷ����ֹ������Ϸ������ ?', 'ȷ����Ϣ', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
          TimerStartGame.Enabled := False;
          m_nStartStatus := 2;
          ButtonStartGame.Caption := g_sButtonStopGame;
        end;
      end;
    2: begin
        if Application.MessageBox('�Ƿ�ȷ��ֹͣ��Ϸ������ ?', 'ȷ����Ϣ', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
          StopGame();
        end;
      end;
    3: begin
        if Application.MessageBox('�Ƿ�ȷ����ֹ������Ϸ������ ?', 'ȷ����Ϣ', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
          TimerStopGame.Enabled := False;
          m_nStartStatus := 2;
          ButtonStartGame.Caption := g_sButtonStopGame;
        end;
      end;
  end;
  {
  if CreateProcess(nil,
                   PChar(sProgamFile),
                   nil,
                   nil,
                   False,
                   IDLE_PRIORITY_CLASS,
                   nil,
                   nil,
                   StartUpInfo,
                   ProcessInfo) then begin
  }
end;

procedure TfrmMain.StartGame;
begin
  FillChar(DBServer, SizeOf(TProgram), #0);
  DBServer.boGetStart := g_boDBServer_GetStart;
  DBServer.boReStart := True;
  DBServer.sDirectory := g_sGameDirectory + g_sDBServer_Directory;
  DBServer.sProgramFile := g_sDBServer_ProgramFile;
  DBServer.nMainFormX := g_nDBServer_MainFormX;
  DBServer.nMainFormY := g_nDBServer_MainFormY;

  FillChar(LoginServer, SizeOf(TProgram), #0);
  LoginServer.boGetStart := g_boLoginServer_GetStart;
  LoginServer.boReStart := True;
  LoginServer.sDirectory := g_sGameDirectory + g_sLoginServer_Directory;
  LoginServer.sProgramFile := g_sLoginServer_ProgramFile;
  LoginServer.nMainFormX := g_nLoginServer_MainFormX;
  LoginServer.nMainFormY := g_nLoginServer_MainFormY;

  FillChar(LogServer, SizeOf(TProgram), #0);
  LogServer.boGetStart := g_boLogServer_GetStart;
  LogServer.boReStart := True;
  LogServer.sDirectory := g_sGameDirectory + g_sLogServer_Directory;
  LogServer.sProgramFile := g_sLogServer_ProgramFile;
  LogServer.nMainFormX := g_nLogServer_MainFormX;
  LogServer.nMainFormY := g_nLogServer_MainFormY;

  FillChar(M2Server, SizeOf(TProgram), #0);
  M2Server.boGetStart := g_boM2Server_GetStart;
  M2Server.boReStart := True;
  M2Server.sDirectory := g_sGameDirectory + g_sM2Server_Directory;
  M2Server.sProgramFile := g_sM2Server_ProgramFile;
  M2Server.nMainFormX := g_nM2Server_MainFormX;
  M2Server.nMainFormY := g_nM2Server_MainFormY;

  FillChar(RunGate, SizeOf(TProgram), #0);
  RunGate.boGetStart := g_boRunGate_GetStart;
  RunGate.boReStart := True;
  RunGate.sDirectory := g_sGameDirectory + g_sRunGate_Directory;
  RunGate.sProgramFile := g_sRunGate_ProgramFile;

  FillChar(RunGate1, SizeOf(TProgram), #0);
  RunGate1.boGetStart := g_boRunGate1_GetStart;
  RunGate1.boReStart := True;
  RunGate1.sDirectory := g_sGameDirectory + g_sRunGate_Directory;
  RunGate1.sProgramFile := g_sRunGate_ProgramFile;

  FillChar(RunGate2, SizeOf(TProgram), #0);
  RunGate2.boGetStart := g_boRunGate2_GetStart;
  RunGate2.boReStart := True;
  RunGate2.sDirectory := g_sGameDirectory + g_sRunGate_Directory;
  RunGate2.sProgramFile := g_sRunGate_ProgramFile;

  FillChar(RunGate3, SizeOf(TProgram), #0);
  RunGate3.boGetStart := g_boRunGate3_GetStart;
  RunGate3.boReStart := True;
  RunGate3.sDirectory := g_sGameDirectory + g_sRunGate_Directory;
  RunGate3.sProgramFile := g_sRunGate_ProgramFile;

  FillChar(RunGate4, SizeOf(TProgram), #0);
  RunGate4.boGetStart := g_boRunGate4_GetStart;
  RunGate4.boReStart := True;
  RunGate4.sDirectory := g_sGameDirectory + g_sRunGate_Directory;
  RunGate4.sProgramFile := g_sRunGate_ProgramFile;

  FillChar(RunGate5, SizeOf(TProgram), #0);
  RunGate5.boGetStart := g_boRunGate5_GetStart;
  RunGate5.boReStart := True;
  RunGate5.sDirectory := g_sGameDirectory + g_sRunGate_Directory;
  RunGate5.sProgramFile := g_sRunGate_ProgramFile;

  FillChar(RunGate6, SizeOf(TProgram), #0);
  RunGate6.boGetStart := g_boRunGate6_GetStart;
  RunGate6.boReStart := True;
  RunGate6.sDirectory := g_sGameDirectory + g_sRunGate_Directory;
  RunGate6.sProgramFile := g_sRunGate_ProgramFile;

  FillChar(RunGate7, SizeOf(TProgram), #0);
  RunGate7.boGetStart := g_boRunGate7_GetStart;
  RunGate7.boReStart := True;
  RunGate7.sDirectory := g_sGameDirectory + g_sRunGate_Directory;
  RunGate7.sProgramFile := g_sRunGate_ProgramFile;

  FillChar(SelGate, SizeOf(TProgram), #0);
  SelGate.boGetStart := g_boSelGate_GetStart;
  SelGate.boReStart := True;
  SelGate.sDirectory := g_sGameDirectory + g_sSelGate_Directory;
  SelGate.sProgramFile := g_sSelGate_ProgramFile;
  SelGate.nMainFormX := g_nSelGate_MainFormX;
  SelGate.nMainFormY := g_nSelGate_MainFormY;

  FillChar(SelGate1, SizeOf(TProgram), #0);
  if g_boRunGate4_GetStart then begin //���������4����Ϸ����������򿪵ڶ�����ɫ����
    SelGate1.boGetStart := g_boSelGate_GetStart;
  end else SelGate1.boGetStart := False;

  SelGate1.boReStart := True;
  SelGate1.sDirectory := g_sGameDirectory + g_sSelGate_Directory;
  SelGate1.sProgramFile := g_sSelGate_ProgramFile;
  SelGate1.nMainFormX := g_nSelGate_MainFormX;
  SelGate1.nMainFormY := g_nSelGate_MainFormY;

  FillChar(LoginGate, SizeOf(TProgram), #0);
  LoginGate.boGetStart := g_boLoginGate_GetStart;
  LoginGate.boReStart := True;
  LoginGate.sDirectory := g_sGameDirectory + g_sLoginGate_Directory;
  LoginGate.sProgramFile := g_sLoginGate_ProgramFile;
  LoginGate.nMainFormX := g_nLoginGate_MainFormX;
  LoginGate.nMainFormY := g_nLoginGate_MainFormY;

  ButtonStartGame.Caption := g_sButtonStopStartGame;
  m_nStartStatus := 1;
  TimerStartGame.Enabled := True;
end;

procedure TfrmMain.StopGame;
begin
  ButtonStartGame.Caption := g_sButtonStopStopGame;
  MainOutMessage('���ڿ�ʼֹͣ������...');
  TimerCheckRun.Enabled := False;
  TimerStopGame.Enabled := True;
  m_nStartStatus := 3;
end;

procedure TfrmMain.TimerStartGameTimer(Sender: TObject);
var
  nRetCode: Integer;
begin
  if DBServer.boGetStart then begin
    case DBServer.btStartStatus of //
      0: begin
          nRetCode := RunProgram(DBServer, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            DBServer.btStartStatus := 1;
            DBServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, DBServer.ProcessInfo.dwProcessId);
          end else begin
            //ShowMessage(IntToStr(nRetCode));
            TimerStartGame.Enabled:=False;
            ShowMessage('����ʧ��');
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          //        DBServer.btStartStatus:=2;
          exit;
        end;
    end;
  end;
  if LoginServer.boGetStart then begin
    case LoginServer.btStartStatus of //
      0: begin
          nRetCode := RunProgram(LoginServer, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            LoginServer.btStartStatus := 1;
            LoginServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LoginServer.ProcessInfo.dwProcessId);
          end else begin
            LoginServer.btStartStatus := 9;
            ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          //        LoginServer.btStartStatus:=2;
          exit;
        end;
    end;
  end;

  if LogServer.boGetStart then begin
    case LogServer.btStartStatus of //
      0: begin
          nRetCode := RunProgram(LogServer, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            LogServer.btStartStatus := 1;
            LogServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LogServer.ProcessInfo.dwProcessId);
          end else begin
            LogServer.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          //        LogServer.btStartStatus:=2;
          exit;
        end;
    end;
  end;

  if M2Server.boGetStart then begin
    case M2Server.btStartStatus of //
      0: begin
          nRetCode := RunProgram(M2Server, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            M2Server.btStartStatus := 1;
            M2Server.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, M2Server.ProcessInfo.dwProcessId);
          end else begin
            M2Server.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          //        M2Server.btStartStatus:=2;
          exit;
        end;
    end;
  end;

  if RunGate.boGetStart then begin
    case RunGate.btStartStatus of //
      0: begin
          GetMutRunGateConfing(0);
          nRetCode := RunProgram(RunGate, IntToStr(Self.Handle), 2000);
          if nRetCode = 0 then begin
            RunGate.btStartStatus := 1;
            RunGate.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate.ProcessInfo.dwProcessId);
          end else begin
            RunGate.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          RunGate.btStartStatus := 2;
          exit;
        end;
    end;
  end;

  if RunGate1.boGetStart then begin
    case RunGate1.btStartStatus of //
      0: begin
          GetMutRunGateConfing(1);
          nRetCode := RunProgram(RunGate1, IntToStr(Self.Handle), 2000);
          if nRetCode = 0 then begin
            RunGate1.btStartStatus := 1;
            RunGate1.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate1.ProcessInfo.dwProcessId);
          end else begin
            RunGate1.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          RunGate1.btStartStatus := 2;
          exit;
        end;
    end;
  end;

  if RunGate2.boGetStart then begin
    case RunGate2.btStartStatus of //
      0: begin
          GetMutRunGateConfing(2);
          nRetCode := RunProgram(RunGate2, IntToStr(Self.Handle), 2000);
          if nRetCode = 0 then begin
            RunGate2.btStartStatus := 1;
            RunGate2.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate2.ProcessInfo.dwProcessId);
          end else begin
            RunGate2.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          RunGate2.btStartStatus := 2;
          exit;
        end;
    end;
  end;

  if RunGate3.boGetStart then begin
    case RunGate3.btStartStatus of //
      0: begin
          GetMutRunGateConfing(3);
          nRetCode := RunProgram(RunGate3, IntToStr(Self.Handle), 2000);
          if nRetCode = 0 then begin
            RunGate3.btStartStatus := 1;
            RunGate3.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate3.ProcessInfo.dwProcessId);
          end else begin
            RunGate3.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          RunGate3.btStartStatus := 2;
          exit;
        end;
    end;
  end;

  if RunGate4.boGetStart then begin
    case RunGate4.btStartStatus of //
      0: begin
          GetMutRunGateConfing(4);
          nRetCode := RunProgram(RunGate4, IntToStr(Self.Handle), 2000);
          if nRetCode = 0 then begin
            RunGate4.btStartStatus := 1;
            RunGate4.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate4.ProcessInfo.dwProcessId);
          end else begin
            RunGate4.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          RunGate4.btStartStatus := 2;
          exit;
        end;
    end;
  end;

  if RunGate5.boGetStart then begin
    case RunGate5.btStartStatus of //
      0: begin
          GetMutRunGateConfing(5);
          nRetCode := RunProgram(RunGate5, IntToStr(Self.Handle), 2000);
          if nRetCode = 0 then begin
            RunGate5.btStartStatus := 1;
            RunGate5.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate5.ProcessInfo.dwProcessId);
          end else begin
            RunGate5.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          RunGate5.btStartStatus := 2;
          exit;
        end;
    end;
  end;

  if RunGate6.boGetStart then begin
    case RunGate6.btStartStatus of //
      0: begin
          GetMutRunGateConfing(6);
          nRetCode := RunProgram(RunGate6, IntToStr(Self.Handle), 2000);
          if nRetCode = 0 then begin
            RunGate6.btStartStatus := 1;
            RunGate6.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate6.ProcessInfo.dwProcessId);
          end else begin
            RunGate6.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          RunGate6.btStartStatus := 2;
          exit;
        end;
    end;
  end;

  if RunGate7.boGetStart then begin
    case RunGate7.btStartStatus of //
      0: begin
          GetMutRunGateConfing(7);
          nRetCode := RunProgram(RunGate7, IntToStr(Self.Handle), 2000);
          if nRetCode = 0 then begin
            RunGate7.btStartStatus := 1;
            RunGate7.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate7.ProcessInfo.dwProcessId);
          end else begin
            RunGate7.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          RunGate7.btStartStatus := 2;
          exit;
        end;
    end;
  end;

  if SelGate.boGetStart then begin
    case SelGate.btStartStatus of //
      0: begin
          GenMutSelGateConfig(0);
          nRetCode := RunProgram(SelGate, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            SelGate.btStartStatus := 1;
            SelGate.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, SelGate.ProcessInfo.dwProcessId);
          end else begin
            SelGate.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          SelGate.btStartStatus:=2;
          exit;
        end;
    end;
  end;

  if SelGate1.boGetStart then begin
    case SelGate1.btStartStatus of //
      0: begin
          GenMutSelGateConfig(1);
          nRetCode := RunProgram(SelGate1, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            SelGate1.btStartStatus := 1;
            SelGate1.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, SelGate1.ProcessInfo.dwProcessId);
          end else begin
            SelGate1.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          SelGate1.btStartStatus:=2;
          exit;
        end;
    end;
  end;

  if LoginGate.boGetStart then begin
    case LoginGate.btStartStatus of //
      0: begin
          nRetCode := RunProgram(LoginGate, IntToStr(Self.Handle), 0);
          if nRetCode = 0 then begin
            LoginGate.btStartStatus := 1;
            LoginGate.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LoginGate.ProcessInfo.dwProcessId);
          end else begin
            LoginGate.btStartStatus := 9;
            //ShowMessage(IntToStr(nRetCode));
          end;
          exit;
        end;
      1: begin //���״̬Ϊ1 ��û�������
          LoginGate.btStartStatus:=2;
          exit;
        end;
    end;
  end;

  TimerStartGame.Enabled := False;
  TimerCheckRun.Enabled := True;
  ButtonStartGame.Caption := g_sButtonStopGame;
  //  ButtonStartGame.Enabled:=True;
  m_nStartStatus := 2;
  //  SetWindowPos(Self.Handle,HWND_TOPMOST,Self.Left,Self.Top,Self.Width,Self.Height,$40);
end;

procedure TfrmMain.TimerStopGameTimer(Sender: TObject);
var
  dwExitCode: LongWord;
  nRetCode: Integer;
begin
  if LoginGate.boGetStart and (LoginGate.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(LoginGate.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if LoginGate.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(LoginGate, 0);
          MainOutMessage('�����رճ�ʱ����¼�����ѱ�ǿ��ֹͣ...');
        end;
        exit; //������ڹر���ȴ�������������
      end;
      SendProgramMsg(LoginGate.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      LoginGate.btStartStatus := 3;
      exit;
    end else begin
      CloseHandle(LoginGate.ProcessHandle);
      LoginGate.btStartStatus := 0;
      MainOutMessage('��¼������ֹͣ...');
    end;
  end;

  if SelGate.boGetStart and (SelGate.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(SelGate.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if SelGate.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(SelGate, 0);
          MainOutMessage('�����رճ�ʱ����ɫ����һ�ѱ�ǿ��ֹͣ...');
        end;
        exit; //������ڹر���ȴ�������������
      end;
      SendProgramMsg(SelGate.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      SelGate.btStartStatus := 3;
      exit;
    end else begin
      CloseHandle(SelGate.ProcessHandle);
      SelGate.btStartStatus := 0;
      MainOutMessage('��ɫ����һ��ֹͣ...');
    end;
  end;

  if SelGate1.boGetStart and (SelGate1.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(SelGate1.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if SelGate1.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(SelGate1, 0);
          MainOutMessage('�����رճ�ʱ����ɫ���ض��ѱ�ǿ��ֹͣ...');
        end;
        exit; //������ڹر���ȴ�������������
      end;
      SendProgramMsg(SelGate1.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      SelGate1.btStartStatus := 3;
      exit;
    end else begin
      CloseHandle(SelGate1.ProcessHandle);
      SelGate1.btStartStatus := 0;
      MainOutMessage('��ɫ���ض���ֹͣ...');
    end;
  end;

  if RunGate.boGetStart and (RunGate.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(RunGate.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      nRetCode := StopProgram(RunGate, 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate.ProcessHandle);
        RunGate.btStartStatus := 0;
        MainOutMessage('��Ϸ����һ��ֹͣ...');
      end;
    end;
  end;

  if RunGate1.boGetStart and (RunGate1.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(RunGate1.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      nRetCode := StopProgram(RunGate1, 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate1.ProcessHandle);
        RunGate1.btStartStatus := 0;
        MainOutMessage('��Ϸ���ض���ֹͣ...');
      end;
    end;
  end;

  if RunGate2.boGetStart and (RunGate2.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(RunGate2.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      nRetCode := StopProgram(RunGate2, 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate2.ProcessHandle);
        RunGate2.btStartStatus := 0;
        MainOutMessage('��Ϸ��������ֹͣ...');
      end;
    end;
  end;
  if RunGate3.boGetStart and (RunGate3.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(RunGate3.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      nRetCode := StopProgram(RunGate3, 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate3.ProcessHandle);
        RunGate3.btStartStatus := 0;
        MainOutMessage('��Ϸ��������ֹͣ...');
      end;
    end;
  end;

  if RunGate4.boGetStart and (RunGate4.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(RunGate4.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      nRetCode := StopProgram(RunGate4, 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate4.ProcessHandle);
        RunGate4.btStartStatus := 0;
        MainOutMessage('��Ϸ��������ֹͣ...');
      end;
    end;
  end;

  if RunGate5.boGetStart and (RunGate5.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(RunGate5.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      nRetCode := StopProgram(RunGate5, 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate5.ProcessHandle);
        RunGate5.btStartStatus := 0;
        MainOutMessage('��Ϸ��������ֹͣ...');
      end;
    end;
  end;

  if RunGate6.boGetStart and (RunGate6.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(RunGate6.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      nRetCode := StopProgram(RunGate6, 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate6.ProcessHandle);
        RunGate6.btStartStatus := 0;
        MainOutMessage('��Ϸ��������ֹͣ...');
      end;
    end;
  end;

  if RunGate7.boGetStart and (RunGate7.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(RunGate7.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      nRetCode := StopProgram(RunGate7, 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate7.ProcessHandle);
        RunGate7.btStartStatus := 0;
        MainOutMessage('��Ϸ���ذ���ֹͣ...');
      end;
    end;
  end;

  if M2Server.boGetStart and (M2Server.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(M2Server.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if M2Server.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(M2Server, 1000);
          MainOutMessage('�����رճ�ʱ����Ϸ�����������ѱ�ǿ��ֹͣ...');
        end;
        exit; //������ڹر���ȴ�������������
      end;
      SendProgramMsg(M2Server.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      M2Server.btStartStatus := 3;
      exit;
    end else begin
      CloseHandle(M2Server.ProcessHandle);
      M2Server.btStartStatus := 0;
      MainOutMessage('��Ϸ������������ֹͣ...');
    end;
  end;

  if LoginServer.boGetStart and (LoginServer.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(LoginServer.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if LoginServer.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(LoginServer, 1000);
          MainOutMessage('�����رճ�ʱ����Ϸ�����������ѱ�ǿ��ֹͣ...');
        end;
        exit; //������ڹر���ȴ�������������
      end;
      SendProgramMsg(LoginServer.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      LoginServer.btStartStatus := 3;
      exit;
    end else begin
      CloseHandle(LoginServer.ProcessHandle);
      LoginServer.btStartStatus := 0;
      MainOutMessage('��¼��������ֹͣ...');
    end;
  end;

  if LogServer.boGetStart and (LogServer.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(LogServer.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if LogServer.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(LogServer, 0);
          MainOutMessage('�����رճ�ʱ����Ϸ�����������ѱ�ǿ��ֹͣ...');
        end;
        exit; //������ڹر���ȴ�������������
      end;
      SendProgramMsg(LogServer.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      LogServer.btStartStatus := 3;
      exit;
    end else begin
      CloseHandle(LogServer.ProcessHandle);
      LogServer.btStartStatus := 0;
      MainOutMessage('��Ϸ��־��������ֹͣ...');
    end;
  end;

  if DBServer.boGetStart and (DBServer.btStartStatus in [2, 3]) then begin
    GetExitCodeProcess(DBServer.ProcessHandle, dwExitCode);
    if dwExitCode = STILL_ACTIVE then begin
      if DBServer.btStartStatus = 3 then begin
        if GetTickCount - g_dwStopTick > g_dwStopTimeOut then begin
          StopProgram(DBServer, 0);
          MainOutMessage('�����رճ�ʱ����Ϸ�����������ѱ�ǿ��ֹͣ...');
        end;
        exit; //������ڹر���ȴ�������������
      end;
      SendProgramMsg(DBServer.MainFormHandle, GS_QUIT, '');
      g_dwStopTick := GetTickCount();
      DBServer.btStartStatus := 3;
      exit;
    end else begin
      CloseHandle(DBServer.ProcessHandle);
      DBServer.btStartStatus := 0;
      MainOutMessage('��Ϸ���ݿ��������ֹͣ...');
    end;
  end;
  TimerStopGame.Enabled := False;
  ButtonStartGame.Caption := g_sButtonStartGame;
  m_nStartStatus := 0;
end;

procedure TfrmMain.TimerCheckRunTimer(Sender: TObject);
var
  dwExitCode: LongWord;
  nRetCode: Integer;
begin
  if DBServer.boGetStart then begin
    GetExitCodeProcess(DBServer.ProcessHandle, dwExitCode);
    if dwExitCode <> STILL_ACTIVE then begin
      nRetCode := RunProgram(DBServer, IntToStr(Self.Handle), 0);

      if nRetCode = 0 then begin
        CloseHandle(DBServer.ProcessHandle);
        DBServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, DBServer.ProcessInfo.dwProcessId);
        MainOutMessage('���ݿ��쳣�رգ��ѱ���������...');
      end;
    end;
  end;

  if LoginServer.boGetStart then begin
    GetExitCodeProcess(LoginServer.ProcessHandle, dwExitCode);
    if dwExitCode <> STILL_ACTIVE then begin
      nRetCode := RunProgram(LoginServer, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(LoginServer.ProcessHandle);
        LoginServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LoginServer.ProcessInfo.dwProcessId);
        MainOutMessage('��¼�������쳣�رգ��ѱ���������...');
      end;
    end;
  end;

  if LogServer.boGetStart then begin
    GetExitCodeProcess(LogServer.ProcessHandle, dwExitCode);
    if dwExitCode <> STILL_ACTIVE then begin
      nRetCode := RunProgram(LogServer, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(LogServer.ProcessHandle);
        LogServer.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LogServer.ProcessInfo.dwProcessId);
        MainOutMessage('��־�������쳣�رգ��ѱ���������...');
      end;
    end;
  end;

  if M2Server.boGetStart then begin
    GetExitCodeProcess(M2Server.ProcessHandle, dwExitCode);
    if dwExitCode <> STILL_ACTIVE then begin
      nRetCode := RunProgram(M2Server, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(M2Server.ProcessHandle);
        M2Server.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, M2Server.ProcessInfo.dwProcessId);
        MainOutMessage('��Ϸ����������쳣�رգ��ѱ���������...');
      end;
    end;
  end;

  if RunGate.boGetStart then begin
    GetExitCodeProcess(RunGate.ProcessHandle, dwExitCode);
    if dwExitCode <> STILL_ACTIVE then begin
      GetMutRunGateConfing(0);
      nRetCode := RunProgram(RunGate, IntToStr(Self.Handle), 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate.ProcessHandle);
        RunGate.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate.ProcessInfo.dwProcessId);
        MainOutMessage('��Ϸ����һ�쳣�رգ��ѱ���������...');
      end;
    end;
  end;

  if RunGate1.boGetStart then begin
    GetExitCodeProcess(RunGate1.ProcessHandle, dwExitCode);
    if dwExitCode <> STILL_ACTIVE then begin
      GetMutRunGateConfing(1);
      nRetCode := RunProgram(RunGate1, IntToStr(Self.Handle), 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate1.ProcessHandle);
        RunGate1.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate1.ProcessInfo.dwProcessId);
        MainOutMessage('��Ϸ���ض��쳣�رգ��ѱ���������...');
      end;
    end;
  end;

  if RunGate2.boGetStart then begin
    GetExitCodeProcess(RunGate2.ProcessHandle, dwExitCode);
    if dwExitCode <> STILL_ACTIVE then begin
      GetMutRunGateConfing(2);
      nRetCode := RunProgram(RunGate2, IntToStr(Self.Handle), 2000);
      if nRetCode = 0 then begin
        CloseHandle(RunGate2.ProcessHandle);
        RunGate2.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, RunGate2.ProcessInfo.dwProcessId);
        MainOutMessage('��Ϸ�������쳣�رգ��ѱ���������...');
      end;
    end;
  end;

  if SelGate.boGetStart then begin
    GetExitCodeProcess(SelGate.ProcessHandle, dwExitCode);
    if dwExitCode <> STILL_ACTIVE then begin
      nRetCode := RunProgram(SelGate, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(SelGate.ProcessHandle);
        SelGate.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, SelGate.ProcessInfo.dwProcessId);
        MainOutMessage('��ɫ�����쳣�رգ��ѱ���������...');
      end;
    end;
  end;

  if LoginGate.boGetStart then begin
    GetExitCodeProcess(LoginGate.ProcessHandle, dwExitCode);
    if dwExitCode <> STILL_ACTIVE then begin
      nRetCode := RunProgram(LoginGate, IntToStr(Self.Handle), 0);
      if nRetCode = 0 then begin
        CloseHandle(LoginGate.ProcessHandle);
        LoginGate.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, False, LoginGate.ProcessInfo.dwProcessId);
        MainOutMessage('��¼�����쳣�رգ��ѱ���������...');
      end;
    end;
  end;
end;


procedure TfrmMain.ProcessMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.message = WM_SENDPROCMSG then begin
    //    ShowMessage('asfd');
    Handled := True;
  end;
end;

procedure TfrmMain.MyMessage(var MsgData: TWmCopyData);
var
  sData: String;
  //ProgramType:TProgamType;
  wIdent, wRecog: Word;
begin
  wIdent := HiWord(MsgData.From);
  wRecog := LoWord(MsgData.From);
  //ProgramType:=TProgamType(LoWord(MsgData.From));
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  //MainOutMessage(IntToStr(wIdent));
  case wRecog of //
    tDBServer: ProcessDBServerMsg(wIdent, sData);
    tLoginSrv: ProcessLoginSrvMsg(wIdent, sData);
    tLogServer: ProcessLogServerMsg(wIdent, sData);
    tM2Server: ProcessM2ServerMsg(wIdent, sData);
    tSelGate: ProcessSelGateMsg(wIdent, sData);
    tSelGate1: ProcessSelGate1Msg(wIdent, sData);
    tRunGate: ProcessRunGateMsg(wIdent, sData);
    tRunGate1: ProcessRunGate1Msg(wIdent, sData);
    tRunGate2: ProcessRunGate2Msg(wIdent, sData);
    tRunGate3: ProcessRunGate3Msg(wIdent, sData);
    tRunGate4: ProcessRunGate4Msg(wIdent, sData);
    tRunGate5: ProcessRunGate5Msg(wIdent, sData);
    tRunGate6: ProcessRunGate6Msg(wIdent, sData);
    tRunGate7: ProcessRunGate7Msg(wIdent, sData);
    tLoginGate: ProcessLoginGateMsg(wIdent, sData);
    tLoginGate1: ProcessLoginGate1Msg(wIdent, sData);
  end;
end;

procedure TfrmMain.ProcessDBServerMsg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          DBServer.MainFormHandle := Handle;
          //SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    SG_STARTNOW: begin
        MainOutMessage(sData);
      end;
    SG_STARTOK: begin
        DBServer.btStartStatus := 2;
        MainOutMessage(sData);
      end;
    SG_CHECKCODEADDR: begin
        g_dwDBCheckCodeAddr := Str_ToInt(sData, -1);
      end;
    3: ;
  end;
end;

procedure TfrmMain.ProcessLoginGateMsg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          LoginGate.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    SG_STARTNOW: begin
        MainOutMessage(sData);
      end;
    SG_STARTOK: begin
       // LoginGate.btStartStatus := 2; // 20071118
        MainOutMessage(sData);
      end;
    2: ;
    3: ;
  end;
end;

procedure TfrmMain.ProcessLoginGate1Msg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          LoginGate1.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TfrmMain.ProcessSelGateMsg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          SelGate.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    SG_STARTNOW: begin
        MainOutMessage(sData);
      end;
    SG_STARTOK: begin
        if SelGate.btStartStatus <> 2 then begin
          SelGate.btStartStatus := 2;
        end else begin

         // SelGate1.btStartStatus := 0; //20071222  ȥ��,ʹ�ڶ������ؿ�������
        end;
        MainOutMessage(sData);
      end;
  end;
end;

procedure TfrmMain.ProcessSelGate1Msg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          SelGate1.MainFormHandle := Handle;
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TfrmMain.ProcessM2ServerMsg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          M2Server.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    SG_STARTNOW: begin
        MainOutMessage(sData);
      end;
    SG_STARTOK: begin
        M2Server.btStartStatus := 2;
        MainOutMessage(sData);
      end;
    SG_CHECKCODEADDR: begin
        g_dwM2CheckCodeAddr := Str_ToInt(sData, -1);
      end;
  end;
end;

procedure TfrmMain.ProcessLoginSrvMsg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          LoginServer.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    SG_STARTNOW: begin
        MainOutMessage(sData);
      end;
    SG_STARTOK: begin
        LoginServer.btStartStatus := 2;
        MainOutMessage(sData);
      end;
  end;
end;

procedure TfrmMain.ProcessLogServerMsg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          LogServer.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    SG_STARTNOW: begin
        MainOutMessage(sData);
      end;
    SG_STARTOK: begin
        LogServer.btStartStatus := 2;
        MainOutMessage(sData);
      end;
  end;
end;

procedure TfrmMain.ProcessRunGate1Msg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          RunGate1.MainFormHandle := Handle;
          //        SetWindowPos(Self.Handle,Handle,Self.Left,Self.Top,Self.Width,Self.Height,$40);
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TfrmMain.ProcessRunGate2Msg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          RunGate2.MainFormHandle := Handle;
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TfrmMain.ProcessRunGate3Msg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          RunGate3.MainFormHandle := Handle;
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TfrmMain.ProcessRunGate4Msg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          RunGate4.MainFormHandle := Handle;
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TfrmMain.ProcessRunGate5Msg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          RunGate5.MainFormHandle := Handle;
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TfrmMain.ProcessRunGate6Msg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          RunGate6.MainFormHandle := Handle;
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TfrmMain.ProcessRunGate7Msg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          RunGate7.MainFormHandle := Handle;
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;

procedure TfrmMain.ProcessRunGateMsg(wIdent: Word; sData: String);
var
  Handle: THandle;
begin
  case wIdent of
    SG_FORMHANDLE: begin
        Handle := Str_ToInt(sData, 0);
        if Handle <> 0 then begin
          RunGate.MainFormHandle := Handle;
        end;
      end;
    1: ;
    2: ;
    3: ;
  end;
end;


procedure TfrmMain.ButtonReLoadConfigClick(Sender: TObject);
begin
  LoadConfig();
  RefGameConsole();
  Application.MessageBox('�����ؼ������...', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmMain.EditLoginGate_MainFormXChange(Sender: TObject);
begin
  if EditLoginGate_MainFormX.Text = '' then begin
    EditLoginGate_MainFormX.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nLoginGate_MainFormX := EditLoginGate_MainFormX.Value;
end;

procedure TfrmMain.EditLoginGate_MainFormYChange(Sender: TObject);
begin
  if EditLoginGate_MainFormY.Text = '' then begin
    EditLoginGate_MainFormY.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nLoginGate_MainFormY := EditLoginGate_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxboLoginGate_GetStartClick(Sender: TObject);
begin
  if not m_boOpen then exit;
  g_boLoginGate_GetStart := CheckBoxboLoginGate_GetStart.Checked;
end;

procedure TfrmMain.EditSelGate_MainFormXChange(Sender: TObject);
begin
  if EditSelGate_MainFormX.Text = '' then begin
    EditSelGate_MainFormX.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nSelGate_MainFormX := EditSelGate_MainFormX.Value;
end;

procedure TfrmMain.EditSelGate_MainFormYChange(Sender: TObject);
begin
  if EditSelGate_MainFormY.Text = '' then begin
    EditSelGate_MainFormY.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nSelGate_MainFormY := EditSelGate_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxboSelGate_GetStartClick(Sender: TObject);
begin
  if not m_boOpen then exit;
  g_boSelGate_GetStart := CheckBoxboSelGate_GetStart.Checked;
end;
procedure TfrmMain.EditLoginServer_MainFormXChange(Sender: TObject);
begin
  if EditLoginServer_MainFormX.Text = '' then begin
    EditLoginServer_MainFormX.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nLoginServer_MainFormX := EditLoginServer_MainFormX.Value;
end;

procedure TfrmMain.EditLoginServer_MainFormYChange(Sender: TObject);
begin
  if EditLoginServer_MainFormY.Text = '' then begin
    EditLoginServer_MainFormY.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nLoginServer_MainFormY := EditLoginServer_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxboLoginServer_GetStartClick(Sender: TObject);
begin
  if not m_boOpen then exit;
  g_boLoginServer_GetStart := CheckBoxboLoginServer_GetStart.Checked;
end;

procedure TfrmMain.EditDBServer_MainFormXChange(Sender: TObject);
begin
  if EditDBServer_MainFormX.Text = '' then begin
    EditDBServer_MainFormX.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nDBServer_MainFormX := EditDBServer_MainFormX.Value;
end;

procedure TfrmMain.EditDBServer_MainFormYChange(Sender: TObject);
begin
  if EditDBServer_MainFormY.Text = '' then begin
    EditDBServer_MainFormY.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nDBServer_MainFormY := EditDBServer_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxDisableAutoGameClick(Sender: TObject);
begin
  if not m_boOpen then exit;
  g_boDBServer_DisableAutoGame := CheckBoxDisableAutoGame.Checked;
end;


procedure TfrmMain.CheckBoxDBServerGetStartClick(Sender: TObject);
begin
  if not m_boOpen then exit;
  g_boDBServer_GetStart := CheckBoxDBServerGetStart.Checked;
end;

procedure TfrmMain.EditLogServer_MainFormXChange(Sender: TObject);
begin
  if EditLogServer_MainFormX.Text = '' then begin
    EditLogServer_MainFormX.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nLogServer_MainFormX := EditLogServer_MainFormX.Value;
end;

procedure TfrmMain.EditLogServer_MainFormYChange(Sender: TObject);
begin
  if EditLogServer_MainFormY.Text = '' then begin
    EditLogServer_MainFormY.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nLogServer_MainFormY := EditLogServer_MainFormY.Value;
end;

procedure TfrmMain.CheckBoxLogServerGetStartClick(Sender: TObject);
begin
  if not m_boOpen then exit;
  g_boLogServer_GetStart := CheckBoxLogServerGetStart.Checked;
end;

procedure TfrmMain.EditM2Server_MainFormXChange(Sender: TObject);
begin
  if EditM2Server_MainFormX.Text = '' then begin
    EditM2Server_MainFormX.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nM2Server_MainFormX := EditM2Server_MainFormX.Value;
end;

procedure TfrmMain.EditM2Server_MainFormYChange(Sender: TObject);
begin
  if EditM2Server_TestLevel.Text = '' then begin
    EditM2Server_TestLevel.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nM2Server_TestLevel := EditM2Server_TestLevel.Value;
end;

procedure TfrmMain.EditM2Server_TestLevelChange(Sender: TObject);
begin
  if EditM2Server_TestLevel.Text = '' then begin
    EditM2Server_TestLevel.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nM2Server_TestLevel := EditM2Server_TestLevel.Value;
end;

procedure TfrmMain.EditM2Server_TestGoldChange(Sender: TObject);
begin
  if EditM2Server_TestGold.Text = '' then begin
    EditM2Server_TestGold.Text := '0';
  end;
  if not m_boOpen then exit;
  g_nM2Server_TestGold := EditM2Server_TestGold.Value;
end;

procedure TfrmMain.CheckBoxM2ServerGetStartClick(Sender: TObject);
begin
  if not m_boOpen then exit;
  g_boM2Server_GetStart := CheckBoxM2ServerGetStart.Checked;
end;

procedure TfrmMain.MemoLogChange(Sender: TObject);
begin
  if MemoLog.Lines.Count > 100 then
    MemoLog.Clear;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if m_nStartStatus = 2 then begin
    if Application.MessageBox('��Ϸ�������������У��Ƿ�ֹͣ��Ϸ������ ?', 'ȷ����Ϣ', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
      ButtonStartGameClick(ButtonStartGame);
    end;
    CanClose := False;
    exit;
  end;

  if Application.MessageBox('�Ƿ�ȷ�Ϲرտ���̨ ?', 'ȷ����Ϣ', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    CanClose := True;
  end else begin
    CanClose := False;
  end;
end;

procedure TfrmMain.GetMutRunGateConfing(nIndex: Integer);
var
  IniGameConf: TIniFile;
  sIniFile: String;
  sGateAddr: String;
  nGatePort: Integer;
begin
  case nIndex of //
    0: begin
        sGateAddr := g_sRunGate_GateAddr;
        nGatePort := g_nRunGate_GatePort;
      end;
    1: begin
        sGateAddr := g_sRunGate1_GateAddr;
        nGatePort := g_nRunGate1_GatePort;
      end;
    2: begin
        sGateAddr := g_sRunGate2_GateAddr;
        nGatePort := g_nRunGate2_GatePort;
      end;
    3: begin
        sGateAddr := g_sRunGate3_GateAddr;
        nGatePort := g_nRunGate3_GatePort;
      end;
    4: begin
        sGateAddr := g_sRunGate4_GateAddr;
        nGatePort := g_nRunGate4_GatePort;
      end;
    5: begin
        sGateAddr := g_sRunGate5_GateAddr;
        nGatePort := g_nRunGate5_GatePort;
      end;
    6: begin
        sGateAddr := g_sRunGate6_GateAddr;
        nGatePort := g_nRunGate6_GatePort;
      end;
    7: begin
        sGateAddr := g_sRunGate7_GateAddr;
        nGatePort := g_nRunGate7_GatePort;
      end;
  end;

  sIniFile := g_sGameDirectory + g_sRunGate_Directory;
  if not DirectoryExists(sIniFile) then begin
    CreateDir(sIniFile);
  end;
  IniGameConf := TIniFile.Create(sIniFile + g_sRunGate_ConfigFile);
  IniGameConf.WriteString('server', 'Title', g_sGameName + '(' + IntToStr(nGatePort) + ')');
  IniGameConf.WriteString('server', 'GateAddr', sGateAddr);
  IniGameConf.WriteInteger('server', 'GatePort', nGatePort);
  IniGameConf.Free;
end;

procedure TfrmMain.EditRunGate_ConntChange(Sender: TObject);
begin
  if EditRunGate_Connt.Text = '' then begin
    EditRunGate_Connt.Text := '0';
  end;
  if not m_boOpen then exit;

  g_nRunGate_Count := EditRunGate_Connt.Value;
  g_boRunGate1_GetStart := g_nRunGate_Count >= 2;
  g_boRunGate2_GetStart := g_nRunGate_Count >= 3;
  g_boRunGate3_GetStart := g_nRunGate_Count >= 4;
  g_boRunGate4_GetStart := g_nRunGate_Count >= 5;
  g_boRunGate5_GetStart := g_nRunGate_Count >= 6;
  g_boRunGate6_GetStart := g_nRunGate_Count >= 7;
  g_boRunGate7_GetStart := g_nRunGate_Count >= 8;
  if g_boRunGate4_GetStart then begin
    g_sDBServer_Config_GateAddr := g_sAllIPaddr;
  end else begin
    g_sDBServer_Config_GateAddr := g_sLocalIPaddr;
  end;
  RefGameConsole();
  
  case g_nServerNum of//20080829 ����
    0:begin
      EditRunGate_GatePort1.Text     := '7200';
      EditRunGate_GatePort2.Text     := '7300';
      EditRunGate_GatePort3.Text     := '7400';
      EditRunGate_GatePort4.Text     := '7500';
      EditRunGate_GatePort5.Text     := '7600';
      EditRunGate_GatePort6.Text     := '7700';
      EditRunGate_GatePort7.Text     := '7800';
      EditRunGate_GatePort8.Text     := '7900';
    end;
    1:begin
      EditRunGate_GatePort1.Text     := '7201';
      EditRunGate_GatePort2.Text     := '7301';
      EditRunGate_GatePort3.Text     := '7401';
      EditRunGate_GatePort4.Text     := '7501';
      EditRunGate_GatePort5.Text     := '7601';
      EditRunGate_GatePort6.Text     := '7701';
      EditRunGate_GatePort7.Text     := '7801';
      EditRunGate_GatePort8.Text     := '7901';
    end;
  end;
end;

procedure TfrmMain.CheckBoxTwoServerClick(Sender: TObject);
begin
  g_boTwoServer := CheckBoxTwoServer.Checked;
  GroupBox6.Visible := CheckBoxTwoServer.Checked;
end;

procedure TfrmMain.CheckBoxDynamicIPModeClick(Sender: TObject);
begin
  EditGameExtIPaddr.Enabled := not CheckBoxDynamicIPMode.Checked;
end;

function TfrmMain.StartService: Boolean;
begin
  Result := False;
  MainOutMessage('����������Ϸ�ͻ��˿�����...');
  MainOutMessage('��Ϸ����̨�������...');
  Result := True;
end;


procedure TfrmMain.ButtonGeneralDefalultClick(Sender: TObject);
begin
  EditGameDir.Text := 'D:\MirServer\';
  EditHeroDB.Text := 'HeroDB';
  EditGameName.Text := 'IGE�Ƽ�';
  EditGameExtIPaddr.Text := '127.0.0.1';
  CheckBoxTwoServer.Checked := False;
  CheckBoxDynamicIPMode.Checked := False;
end;

procedure TfrmMain.ButtonRunGateDefaultClick(Sender: TObject);
begin
  EditRunGate_Connt.Value := 3;
  EditRunGate_GatePort1.Text := '7200';
  EditRunGate_GatePort2.Text := '7300';
  EditRunGate_GatePort3.Text := '7400';
  EditRunGate_GatePort4.Text := '7500';
  EditRunGate_GatePort5.Text := '7600';
  EditRunGate_GatePort6.Text := '7700';
  EditRunGate_GatePort7.Text := '7800';
  EditRunGate_GatePort8.Text := '7900';
end;


procedure TfrmMain.ButtonLoginGateDefaultClick(Sender: TObject);
begin
  EditLoginGate_MainFormX.Text := '0';
  EditLoginGate_MainFormY.Text := '0';
  EditLoginGate_GatePort.Text := '7000';
end;

procedure TfrmMain.ButtonSelGateDefaultClick(Sender: TObject);
begin
  EditSelGate_MainFormX.Text := '0';
  EditSelGate_MainFormY.Text := '163';
  EditSelGate_GatePort.Text := '7100';
end;

procedure TfrmMain.ButtonLoginSrvDefaultClick(Sender: TObject);
begin
  EditLoginServer_MainFormX.Text := '251';
  EditLoginServer_MainFormY.Text := '0';
  EditLoginServerGatePort.Text := '5500';
  EditLoginServerServerPort.Text := '5600';
  EditLoginServerMonPort.Text := '3000';
  CheckBoxboLoginServer_GetStart.Checked := True;
end;

procedure TfrmMain.ButtonDBServerDefaultClick(Sender: TObject);
begin
  EditDBServer_MainFormX.Text := '0';
  EditDBServer_MainFormY.Text := '326';
  CheckBoxDisableAutoGame.Checked := False;
  EditDBServerGatePort.Text := '5100';
  EditDBServerServerPort.Text := '6000';
  CheckBoxDBServerGetStart.Checked := True;
end;

procedure TfrmMain.ButtonLogServerDefaultClick(Sender: TObject);
begin
  EditLogServer_MainFormX.Text := '251';
  EditLogServer_MainFormY.Text := '239';
  EditLogServerPort.Text := '10000';
  CheckBoxLogServerGetStart.Checked := True;
end;

procedure TfrmMain.ButtonM2ServerDefaultClick(Sender: TObject);
begin
  EditM2Server_MainFormX.Text := '560';
  EditM2Server_MainFormY.Text := '0';
  EditM2Server_TestLevel.Value := 1;
  EditM2Server_TestGold.Value := 0;
  EditM2ServerGatePort.Text := '5000';
  EditM2ServerMsgSrvPort.Text := '4900';
  CheckBoxM2ServerGetStart.Checked := True;
end;


procedure TfrmMain.RefGameDebug;
var
  CheckCode: TCheckCode;
  dwReturn: LongWord;
begin
  EditM2CheckCodeAddr.Text := IntToHex(g_dwM2CheckCodeAddr, 2);
  FillChar(CheckCode, SizeOf(CheckCode), 0);
  ReadProcessMemory(M2Server.ProcessHandle, Pointer(g_dwM2CheckCodeAddr), @CheckCode, SizeOf(CheckCode), dwReturn);
  if dwReturn = SizeOf(CheckCode) then begin
    EditM2CheckCode.Text := IntToStr(CheckCode.dwThread0);
    EditM2CheckStr.Text := String(CheckCode.sThread0);
  end;

  EditDBCheckCodeAddr.Text := IntToHex(g_dwDBCheckCodeAddr, 2);
  FillChar(CheckCode, SizeOf(CheckCode), 0);
  ReadProcessMemory(DBServer.ProcessHandle, Pointer(g_dwDBCheckCodeAddr), @CheckCode, SizeOf(CheckCode), dwReturn);
  if dwReturn = SizeOf(CheckCode) then begin
    EditDBCheckCode.Text := IntToStr(CheckCode.dwThread0);
    EditDBCheckStr.Text := String(CheckCode.sThread0);
  end;
end;

procedure TfrmMain.TimerCheckDebugTimer(Sender: TObject);
begin
  RefGameDebug();
end;

procedure TfrmMain.ButtonM2SuspendClick(Sender: TObject);
begin
  SuspendThread(M2Server.ProcessInfo.hThread);
end;


////////////////////////////////���ݹ��ܴ���////////////////////////////////////
//����Ŀ¼
function DoCopyDir(sDirName:String;sToDirName:String):Boolean;
var
  hFindFile:Cardinal;
  t,tfile:String;
  sCurDir:String[255];
  FindFileData:WIN32_FIND_DATA;
begin
  //��¼��ǰĿ¼
  sCurDir:=GetCurrentDir;
  ChDir(sDirName);
  hFindFile:=FindFirstFile('*.*',FindFileData);
  if hFindFile<>INVALID_HANDLE_VALUE then
  begin
    if not DirectoryExists(sToDirName) then
      ForceDirectories(sToDirName);
    repeat
      tfile:=FindFileData.cFileName;
      if (tfile='.') or (tfile='..') then Continue;
      if FindFileData.dwFileAttributes = FILE_ATTRIBUTE_DIRECTORY then
      begin
        t:=sToDirName+'\'+tfile;
        if not DirectoryExists(t) then ForceDirectories(t);
        if sDirName[Length(sDirName)]<>'\' then
          DoCopyDir(sDirName+'\'+tfile,t)
        else
          DoCopyDir(sDirName+tfile,sToDirName+tfile);
      end else begin
        t:=sToDirName+'\'+tFile;
        CopyFile(PChar(tfile),PChar(t),True);
      end;
    until FindNextFile(hFindFile,FindFileData)=false;
///       FindClose(hFindFile);
  end
  else
  begin
    ChDir(sCurDir);
    result:=false;
    exit;
  end;
  //�ص���ǰĿ¼
  ChDir(sCurDir);   
  result:=true;   
end;

procedure TfrmMain.BakModValue;
begin
  ButBakSave.Enabled := True;
end;

//ѡ��Ŀ¼��������
function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) and (lpData <> 0) then
    SendMessage(Wnd, BFFM_SETSELECTION, Integer(True), lpData);
  result := 0;
end;
function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string; Owner: THandle): Boolean;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
begin
  result := FALSE;
  if not DirectoryExists(Directory) then
    Directory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do begin
        hwndOwner := Owner;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS;
        if Directory <> '' then begin
          lpfn := SelectDirCB;
          lParam := Integer(PChar(Directory));
        end;
      end;
      WindowList := DisableTaskWindows(0);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        EnableTaskWindows(WindowList);
      end;
      result := ItemIDList <> nil;
      if result then begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Directory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
var
  sNewDir: string;
begin
  if SelectDirectory('��ѡ������Ŀ¼', '', sNewDir, Handle) then begin
    EditData.Text := sNewdir;
  end;
end;

procedure TfrmMain.Button5Click(Sender: TObject);
var
  sNewDir: string;
begin
  if SelectDirectory('��ѡ�񱸷�Ŀ¼', '', sNewDir, Handle) then begin
    EditBak.Text := sNewdir;
  end;
end;
//��ӹ���
procedure TfrmMain.ButBakAddClick(Sender: TObject);
var
  ListItem: TListItem;
  BakInfo : pTBakInfo;
begin
  if (not DirectoryExists(EditData.Text)) or (not DirectoryExists(EditBak.Text)) then begin
    application.MessageBox('����Ŀ¼������','��ʾ��Ϣ',MB_ICONASTERISK);
    Exit;
  end;
    ListViewBak.Items.BeginUpdate;
    try
      New(BakInfo);
      //BakInfo.DataDir := EditData.Text;
      //BakInfo.BakDir  := EditBak.Text;
      BakInfo.m_dwBakTick := GetTickCount();
      if RadioBak1.Checked then BakInfo.TimeCls := True else BakInfo.TimeCls := False;
      if RadioBak1.Checked then BakInfo.Hour := SpinEdit1.Value else BakInfo.Hour := SpinEdit2.Value;
      if RadioBak1.Checked then BakInfo.Minute := SpinEdit3.Value else BakInfo.Minute := SpinEdit4.Value;
      ListItem := ListViewBak.Items.Add;
      ListItem.Caption := EditData.Text;
      ListItem.SubItems.Add(EditBak.Text);
      ListItem.Data := BakInfo;
    finally
      ListViewBak.Items.EndUpdate;
    end;
  EditData.Text := '';
  EditBak.Text  := '';
  RadioBak1.Checked := True;
  SpinEdit1.Value := 6;
  SpinEdit2.Value := 1;
  SpinEdit3.Value := 0;
  SpinEdit4.Value := 0;
end;
//ѡ��ĳ����
procedure TfrmMain.ListViewBakClick(Sender: TObject);
var
  nItemIndex: Integer;
  ListItem: TListItem;
begin
  try
    nItemIndex := ListViewBak.ItemIndex;
    ListItem := ListViewBak.Items.Item[nItemIndex];
    EditData.Text := ListItem.Caption;
    EditBak.Text  := ListItem.SubItems.Strings[0];
    if pTBakInfo(ListItem.Data)^.TimeCls then begin
      RadioBak1.Checked := True;
      SpinEdit1.Value := pTBakInfo(ListItem.Data)^.Hour;
      SpinEdit3.Value := pTBakInfo(ListItem.Data)^.Minute;
    end else begin
      RadioBak2.Checked := True;
      SpinEdit2.Value := pTBakInfo(ListItem.Data)^.Hour;
      SpinEdit4.Value := pTBakInfo(ListItem.Data)^.Minute;
    end;
    ButBakDel.Enabled := True;
    ButBakChg.Enabled := True;
  except
    ButBakDel.Enabled := False;
    ButBakChg.Enabled := False;
    EditData.Text := '';
    EditBak.Text  := '';
    RadioBak1.Checked := True;
    SpinEdit1.Value := 6;
    SpinEdit2.Value := 1;
    SpinEdit3.Value := 0;
    SpinEdit4.Value := 0;
  end;
end;
//ɾ������
procedure TfrmMain.ButBakDelClick(Sender: TObject);
begin
  ListViewBak.Items.BeginUpdate;
  try
    ListViewBak.DeleteSelected;
  finally
    ListViewBak.Items.EndUpdate;
  end;
  EditData.Text := '';
  EditBak.Text  := '';
  RadioBak1.Checked := True;
  SpinEdit1.Value := 6;
  SpinEdit2.Value := 1;
  SpinEdit3.Value := 0;
  SpinEdit4.Value := 0;
end;
//�޸Ĺ���
procedure TfrmMain.ButBakChgClick(Sender: TObject);
var
  ListItem: TListItem;
  BakInfo : pTBakInfo;
  nItemIndex: Integer;
begin
  if (EditData.Text = '') or (EditBak.Text = '') then begin
    application.MessageBox('����Ŀ¼������','��ʾ��Ϣ',MB_ICONASTERISK);
    Exit;
  end;
    nItemIndex := ListViewBak.ItemIndex;
    try
      New(BakInfo);
      //BakInfo.DataDir := EditData.Text;
      //BakInfo.BakDir  := EditBak.Text;
      BakInfo.m_dwBakTick := GetTickCount();
      if RadioBak1.Checked then BakInfo.TimeCls := True else BakInfo.TimeCls := False;
      if RadioBak1.Checked then BakInfo.Hour := SpinEdit1.Value else BakInfo.Hour := SpinEdit2.Value;
      if RadioBak1.Checked then BakInfo.Minute := SpinEdit3.Value else BakInfo.Minute := SpinEdit4.Value;
      ListItem := ListViewBak.Items.Item[nItemIndex];
      ListItem.Caption := EditData.Text;
      ListItem.SubItems.Strings[0] := EditBak.Text;
      ListItem.Data := BakInfo;
      Application.MessageBox('�޸����', '��ʾ��Ϣ', MB_ICONQUESTION);
    except
    end;
end;

procedure TfrmMain.EditDataChange(Sender: TObject);
begin
  BakModValue();
end;

procedure TfrmMain.RadioBak1Click(Sender: TObject);
begin
  BakModValue();
  SpinEdit1.Enabled := True;
  SpinEdit3.Enabled := True;
  SpinEdit2.Enabled := False;
  SpinEdit4.Enabled := False;
end;

procedure TfrmMain.RadioBak2Click(Sender: TObject);
begin
  BakModValue();
  SpinEdit2.Enabled := True;
  SpinEdit4.Enabled := True;
  SpinEdit1.Enabled := False;
  SpinEdit3.Enabled := False;
end;
//�Զ�����
procedure TfrmMain.AutoBackup;
var
  I: Integer;
  Min, Hour, Sec, Ms:Word;
begin
  if ListViewBak.Items.Count = 0 then Exit; //�б��ǿ�
  for I:=0 to ListViewBak.Items.Count -1 do begin
    if pTBakInfo(ListViewBak.Items[I].Data)^.TimeCls then begin  //������
       DecodeTime(Time, Hour, Min, Sec, Ms);
       if (Hour = pTBakInfo(ListViewBak.Items[I].Data)^.Hour) and (Min = pTBakInfo(ListViewBak.Items[I].Data)^.Minute) and (Sec = 01) then begin
          RunBak(ListViewBak.Items[I].Caption,ListViewBak.Items[I].SubItems.Strings[0]);//����
       end;
    end else begin //��ʱ����
       if (GetTickCount - pTBakInfo(ListViewBak.Items[I].Data).m_dwBakTick) > (pTBakInfo(ListViewBak.Items[I].Data).Hour * 3600 + pTBakInfo(ListViewBak.Items[I].Data).Minute * 60) * 1000 then begin
          pTBakInfo(ListViewBak.Items[I].Data).m_dwBakTick := GetTickCount();
          RunBak(ListViewBak.Items[I].Caption,ListViewBak.Items[I].SubItems.Strings[0]);//����
       end;
    end;
  end;
end;
//ѹ������
function AddFileToZip(const SrcFileName,
ZipFileName: string): Boolean;
var 
  AZip: TVCLZip;
begin
  Result := False;
  AZip := TVCLZip.Create(nil);
  try
    AZip.ZipName := ZipFileName;
    AZip.FilesList.Add(SrcFileName);
    AZip.ZipAction := zaReplace;
    AZip.Recurse:=True;
    AZip.StorePaths:=True;
    AZip.Zip;
  finally
    FreeAndNil(AZip);
  end;
  Result := True;
end;
//���ݹ���
function TfrmMain.RunBak(Data, Bak: string):Boolean;
var
  Min, Hour, Sec, Ms: Word;
  year,month,day: Word;
  Dir, NDir,Name: string;

begin
  Result := False;
  Decodedate(date,year,month,day);     //�����ڷֽ⵽����������
  DecodeTime(Time, Hour, Min, Sec, Ms);
  Name:= IntToStr(year)+'��'+IntToStr(month)+'��'+IntToStr(day)+'��'+IntToStr(Hour)+'ʱ'+IntToStr(Min)+'��'+IntToStr(Sec)+'��';
  Dir := Bak+'\'+ Name;
  if ForceDirectories(Dir) then begin
    if CheckBoxBakReduce.Checked then begin //ѹ��
        if AddFileToZip(Data+'\*.*',Dir+'\'+Name+'.zip') then  Result := True
        else application.MessageBox('ѹ���ļ�ʧ��','��ʾ��Ϣ',MB_ICONWARNING);
    end else begin //��ѹ��
        NDir := ExtractFileName(Data);  //ȡ·�����ļ�����
        if DoCopyDir(Data,Dir+'\'+NDir) then Result := True
        else application.MessageBox('�����ļ�ʧ��','��ʾ��Ϣ',MB_ICONWARNING);
    end;
  end else application.MessageBox('����Ŀ¼����Ŀ¼ʧ��','��ʾ��Ϣ',MB_ICONWARNING);
end;
//�����õĶ�ʱ��
procedure TfrmMain.TimerBakTimer(Sender: TObject);
begin
  AutoBackup;
end;
//��������
procedure TfrmMain.ButBakStartClick(Sender: TObject);
begin
  ButBakStart.ShowHint := not ButBakStart.ShowHint;
  if ButBakStart.ShowHint then begin
    ButBakStart.Caption := 'ֹͣ(&T)';
    Label7.Font.Color := clGreen;
    Label7.Caption := '���ݳ���������...';
    TimerBak.Enabled := True;
  end else begin
    ButBakStart.Caption := '����(&R)';
    Label7.Font.Color := clRed;
    Label7.Caption := '���ݳ���ֹͣ��...';
    Timerbak.Enabled := False;
  end;
end;
//��ȡ������
procedure TFrmMain.LoadBakConfig();
var
  I,IEnd:Integer;
  ListItem: TListItem;
  BakInfo : pTBakInfo;
begin
  IEnd:=g_IniConf.ReadInteger('Bak','Count',0);
  CheckBoxBakReduce.Checked := g_IniConf.ReadBool('Bak','BakReduce',False);
  CheckBoxBakAuto.Checked := g_IniConf.ReadBool('Bak','BakAuto',False);
  for I:=1 to IEnd do begin
    ListViewBak.Items.BeginUpdate;
    try
      ListItem := ListViewBak.Items.Add;
      ListItem.Caption:=g_IniConf.ReadString('Bak','DataDir'+InttoStr(I),'');
      ListItem.SubItems.Add(g_IniConf.ReadString('Bak','BakDir'+InttoStr(I),''));
      New(BakInfo);
      BakInfo.m_dwBakTick := GetTickCount();
      BakInfo.TimeCls := g_IniConf.ReadBool('Bak','TimeCls'+InttoStr(I),False);
      BakInfo.Hour := g_IniConf.ReadInteger('Bak','Hour'+InttoStr(I),0);
      BakInfo.Minute := g_IniConf.ReadInteger('Bak','Minute'+InttoStr(I),0);
      ListItem.Data := BakInfo;
      //Dispose(BakInfo);
    finally
      ListViewBak.Items.EndUpdate;
    end;
  end;
end;
//����������
procedure TfrmMain.ButBakSaveClick(Sender: TObject);
var
  I: Integer;
begin
  for I:=0 to ListViewBak.Items.Count -1 do
  begin
    g_IniConf.WriteString('Bak', 'DataDir'+Inttostr(I+1), ListViewBak.Items.Item[I].Caption);
    g_IniConf.WriteString('Bak', 'BakDir'+Inttostr(I+1), ListViewBak.Items.Item[I].SubItems.Strings[0]);
    g_IniConf.WriteBool('Bak', 'TimeCls'+Inttostr(I+1), pTBakInfo(ListViewBak.Items[I].Data)^.TimeCls);
    g_IniConf.WriteInteger('Bak', 'Hour'+Inttostr(I+1), pTBakInfo(ListViewBak.Items[I].Data)^.Hour);
    g_IniConf.WriteInteger('Bak', 'Minute'+Inttostr(I+1), pTBakInfo(ListViewBak.Items[I].Data)^.Minute);
  end;
  g_IniConf.WriteInteger('Bak', 'Count', ListViewBak.Items.Count);
  g_IniConf.WriteBool('Bak', 'BakAuto', CheckBoxBakAuto.Checked);
  g_IniConf.WriteBool('Bak', 'BakReduce', CheckBoxBakReduce.Checked);
  ButBakSave.Enabled := False;
end;
//ɾ�� ʱ �ͷ� �ڴ�
procedure TfrmMain.ListViewBakDeletion(Sender: TObject; Item: TListItem);
begin
  Dispose(Item.Data);
end;


procedure TfrmMain.RadioButtonMainServerClick(Sender: TObject);
begin
  g_nServerNum := 0;

  EditLoginGate_GatePort.Text    := '7000';
  EditSelGate_GatePort.Text      := '7100';
  EditSelGate_GatePort1.Text     := '7101';
  EditRunGate_GatePort1.Text     := '7200';
  EditRunGate_GatePort2.Text     := '7300';
  EditRunGate_GatePort3.Text     := '7400';
  EditRunGate_GatePort4.Text     := '7500';
  EditRunGate_GatePort5.Text     := '7600';
  EditRunGate_GatePort6.Text     := '7700';
  EditRunGate_GatePort7.Text     := '7800';
  EditRunGate_GatePort8.Text     := '7900';
  EditLoginServerGatePort.Text   := '5500';
  EditLoginServerMonPort.Text    := '3000';
  EditLoginServerServerPort.Text := '5600';
  EditDBServerGatePort.Text      := '5100';
  EditDBServerServerPort.Text    := '6000';
  EditLogServerPort.Text         := '10000';
  //����
  EditM2ServerGatePort.Text      := '5000';
  EditM2ServerMsgSrvPort.Text    := '4900';
end;

procedure TfrmMain.RadioButtonSinceServerClick(Sender: TObject);
begin
  g_nServerNum := 1;

  EditLoginGate_GatePort.Text    := '7001';
  EditSelGate_GatePort.Text      := '7101';
  EditSelGate_GatePort1.Text     := '7102';
  EditRunGate_GatePort1.Text     := '7201';
  EditRunGate_GatePort2.Text     := '7301';
  EditRunGate_GatePort3.Text     := '7401';
  EditRunGate_GatePort4.Text     := '7501';
  EditRunGate_GatePort5.Text     := '7601';
  EditRunGate_GatePort6.Text     := '7701';
  EditRunGate_GatePort7.Text     := '7801';
  EditRunGate_GatePort8.Text     := '7901';
  EditLoginServerGatePort.Text   := '5501';
  EditLoginServerMonPort.Text    := '3001';
  EditLoginServerServerPort.Text := '5601';
  EditDBServerGatePort.Text      := '5101';
  EditDBServerServerPort.Text    := '6001';
  EditLogServerPort.Text         := '10001';
  //����
  EditM2ServerGatePort.Text      := '5001';
  EditM2ServerMsgSrvPort.Text    := '4901';
end;

//�����Ƿ������������ ����
procedure TfrmMain.RzSplitter1CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  ListBoxMyGetTXT.Height := GroupBox26.Height - 41;
end;

procedure TfrmMain.RzSplitter2CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  ListBoxMyGetFile.Height := GroupBox43.Height - 41;
  ListBoxMyGetDir.Height := GroupBox44.Height - 41;
end;

procedure TfrmMain.BtnMyGetDirOpenClick(Sender: TObject);
var
  sNewDir: string;
begin
  if Sender = BtnMyGetTxtOpen then begin
    ClearServerOpenDialog.Filter := '�ı��ļ�(*.txt)|*.txt|�����ļ�(*.*)|*.*';
    if ClearServerOpenDialog.Execute then
      EditMyGetTXT.Text := ClearServerOpenDialog.FileName;
  end;
  if Sender = BtnMyGetFileOpen then begin
    ClearServerOpenDialog.Filter := '�ı��ļ�(*.txt)|*.txt|�����ļ�(*.*)|*.*';
    if ClearServerOpenDialog.Execute then
      EditMyGetFile.Text := ClearServerOpenDialog.FileName;
  end;
  if Sender = BtnMyGetDirOpen then begin
    if SelectDirectory('��ѡ��Ҫ��յ�Ŀ¼', '', sNewDir, Handle) then begin
      EditMyGetDir.Text := sNewdir;
    end;
  end;
end;

procedure TfrmMain.BtnMyGetFileAddClick(Sender: TObject);
begin
  if Sender = BtnMyGetFileAdd then begin
     if not FileExists(EditMyGetFile.Text) then begin
        application.MessageBox('Ҫɾ���������ļ�������','��ʾ��Ϣ',MB_ICONASTERISK);
        Exit;
     end;
     ListBoxAdd(ListBoxMyGetFile,EditMyGetFile.Text);
     ClearModValue();
  end;
  if Sender = BtnMyGetTxtAdd then begin
     if not FileExists(EditMyGetTXT.Text) then begin
        application.MessageBox('Ҫ������ݵ��ı��ļ�������','��ʾ��Ϣ',MB_ICONASTERISK);
        Exit;
     end;
     ListBoxAdd(ListBoxMyGetTXT,EditMyGetTXT.Text);
     ClearModValue();
  end;
  if Sender = BtnMyGetDirAdd then begin
    if not DirectoryExists(EditMyGetDir.Text) then begin
      application.MessageBox('Ҫ��յ�Ŀ¼������','��ʾ��Ϣ',MB_ICONASTERISK);
      Exit;
    end;
    ListBoxAdd(ListBoxMyGetDir,EditMyGetDir.Text);
    ClearModValue();
  end;
end;

procedure TfrmMain.BtnMyGetFileDelClick(Sender: TObject);
begin
  if Sender = BtnMyGetFileDel then begin
     ListBoxDel(ListBoxMyGetFile);
     ClearModValue();
  end;
  if Sender = BtnMyGetTxtDel then begin
     ListBoxDel(ListBoxMyGetTXT);
     ClearModValue();
  end;
  if Sender = BtnMyGetDirDel then begin
     ListBoxDel(ListBoxMyGetDir);
     ClearModValue();
  end;
end;

procedure TfrmMain.RzBitBtn2Click(Sender: TObject);
Var
  sGameDirectory:string;
begin
  sGameDirectory:= Trim(Edit1.text);
  if Application.MessageBox(Pchar('�Ƿ����['+sGameDirectory+']����������?'), 'ȷ����Ϣ', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    if not DirectoryExists (sGameDirectory) then
    begin
      Application.MessageBox('�����Ŀ¼�����ڣ����������ã�����', '��ʾ��Ϣ', MB_OK + MB_ICONEXCLAMATION);
      Exit;
    end;
    if m_nStartStatus = 2 then begin
      Application.MessageBox('���������������У���رշ�������ִ����������', '��ʾ��Ϣ', MB_OK + MB_ICONEXCLAMATION);
      Exit;
    end;

    RzBitBtn2.Enabled := False;
    if PageControl4.ActivePageIndex <> 0 then
      PageControl4.ActivePageIndex := 0; //��ǰҳ��Ϊ��������ҳ

    Application.ProcessMessages;
    Label44.Font.Color := clGreen;
    Label44.Caption := '����׼��ִ��������...';
    rec_pointer := 30;
    //sleep(5000);

    Application.ProcessMessages;
    Label44.Caption := '�������ȫ�ֱ���G��S...';
    if CheckBoxGlobal.Checked then begin
      if ClearGlobal(sGameDirectory+'Mir200\!Setup.txt') then
        ClearProgressBar.Position := 5
        else begin
          Label44.Font.Color := clRed;
          g_sClearError := '���ȫ�ֱ���G��S����...';
          Label44.Caption := g_sClearError;
          Exit;
        end;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ���ʺ�����...';
    if DeleteTree(sGameDirectory+IDeD.text) then begin
       if CheckBoxGlobal.Checked then
          ClearProgressBar.Position := ClearProgressBar.Position + 5
       else ClearProgressBar.Position := 10;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ����ɫ����...';
    if DeleteTree(sGameDirectory+DBeD.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ����Ϸ��־...';
    if DeleteTree(sGameDirectory+logeD.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ���ʺ�ע����־...';
    if DeleteTree(sGameDirectory+ChrLog.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ���ʺ�ͳ����־...';
    if DeleteTree(sGameDirectory+CountLog.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ����Ϸ������־...';
    if DeleteTree(sGameDirectory+M2Log.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '�������ɳ������...';
    if ClearWriteINI (sGameDirectory + csed.text+'\0\SabukW.txt','Setup','OwnGuild','') then
       ClearProgressBar.Position := ClearProgressBar.Position + 5
    else begin
       Label44.Font.Color := clRed;
       g_sClearError := '���ɳ�����ݳ���...';
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '��������л�����...';
    if DeleteTree(sGameDirectory+CBED.text+'\Guilds') then begin
       ClearTxt(sGameDirectory+CBED.text+'\GuildList.txt');
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ����½����...';
    if DeleteTree(sGameDirectory+cleD.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;

    Label44.Caption := '����ɾ��������������...';
    if DeleteTree(sGameDirectory+upgeD.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ����������...';
    if DeleteTree(sGameDirectory+SOeD.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ������1����...';
    if DeleteTree(sGameDirectory+SReD1.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ������2����...';
    if DeleteTree(sGameDirectory+SReD2.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '����ɾ�����а�����...';
    if DeleteTree(sGameDirectory+EdtSort.text) then begin
       ClearProgressBar.Position := ClearProgressBar.Position + 5;
       //sleep(2000);
    end else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;
    Application.ProcessMessages;
    Label44.Caption := '��������Զ����ı��ļ�...';
    ListBoxClearTxtFile(ListBoxMyGetTXT);
    ClearProgressBar.Position := ClearProgressBar.Position + 5;
    //sleep(2000);
    Application.ProcessMessages;
    Label44.Caption := '����ɾ���Զ��������ļ�...';
    ListBoxDelFile(ListBoxMyGetFile);
    ClearProgressBar.Position := ClearProgressBar.Position + 10;
    //sleep(2000);
    Application.ProcessMessages;
    Label44.Caption := '��������Զ���Ŀ¼...';
    if ListBoxDelDir(ListBoxMyGetDir) then
      ClearProgressBar.Position := ClearProgressBar.Position + 10
    else begin
       Label44.Font.Color := clRed;
       Label44.Caption := g_sClearError;
       Exit;
    end;

    Label44.Caption := '����ɾ�����ʱ��������ʱ�ļ�...';
    Application.ProcessMessages;
    sleep(1000);
    ClearProgressBar.Position := 100;

    RzBitBtn2.Enabled := True;
    Application.MessageBox('�����������  ���԰�ȫ�Ŀ������ˣ�����', '��ʾ��Ϣ', MB_OK + MB_ICONEXCLAMATION);
    ClearProgressBar.Position:=0;
    Label44.Font.Color := clRed;
    Label44.Caption := '����ֹͣ��...';
  end;
end;

procedure TfrmMain.ClearSaveBtnClick(Sender: TObject);
begin
  if Clear_IniConf then 
  ClearSaveBtn.Enabled := False;
end;

procedure TfrmMain.CheckBoxGlobalClick(Sender: TObject);
begin
  ClearModValue();
end;



end.


unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Login,   ComCtrls,Printers,
  Grids, DBGrids, StdCtrls,  ExtCtrls, DBCtrls,
  bsSkinData, BusinessSkinForm, bsSkinTabs, bsSkinGrids, bsDBGrids,
  bsSkinCtrls, bsSkinBoxCtrls, bsdbctrls, Mask, DBTables, DB, bsMessages,DM,Inifiles,
  RzLabel, DBGridEh, Buttons, bsSkinShellCtrls, Menus, bsSkinMenus,
  RzPrgres, RzEdit, PrnDbgeh,  bsColorCtrls, FFPBox,mywil, bsDialogs,ADODB,
  GridsEh, bsSkinExCtrls;

type
  TFrmMain = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsSkinMessage1: TbsSkinMessage;
    OpenDialog1: TbsSkinOpenDialog;
    SaveDialog1: TbsSkinSaveDialog;
    bsSkinPopupMenu3: TbsSkinPopupMenu;
    N5: TMenuItem;
    PrintDBGridEh1: TPrintDBGridEh;
    bsSkinPanel17: TbsSkinPanel;
    bsSkinStdLabel7: TbsSkinStdLabel;
    LabelProductName: TbsSkinStdLabel;
    bsSkinLinkLabel1: TbsSkinLinkLabel;
    bsSkinButtonLabel1: TbsSkinButtonLabel;
    bsSkinStdLabel17: TbsSkinStdLabel;
    LabelVersion: TbsSkinStdLabel;
    bsSkinPageControl1: TbsSkinPageControl;
    bsSkinTabSheet1: TbsSkinTabSheet;
    bsSkinPageControl2: TbsSkinPageControl;
    bsSkinTabSheet4: TbsSkinTabSheet;
    bsSkinSplitter1: TbsSkinSplitter;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    BtnMagicBaseBak: TbsSkinButton;
    BtnMagicBaseRestore: TbsSkinButton;
    bsSkinCheckRadioBox1: TbsSkinCheckRadioBox;
    bsSkinCheckRadioBox2: TbsSkinCheckRadioBox;
    bsSkinCheckRadioBox3: TbsSkinCheckRadioBox;
    EditMagName: TbsSkinEdit;
    bsSkinSpinEdit1: TbsSkinSpinEdit;
    BtnFindMagName: TbsSkinButton;
    BtnAlterMagicExp: TbsSkinButton;
    bsSkinButton12: TbsSkinButton;
    bsSkinButton15: TbsSkinButton;
    bsSkinDBNavigator1: TbsSkinDBNavigator;
    bsSkinExPanel1: TbsSkinExPanel;
    bsSkinMemo1: TbsSkinMemo;
    bsSkinPanel2: TbsSkinPanel;
    MagicDBGrid: TDBGridEh;
    bsSkinTabSheet5: TbsSkinTabSheet;
    bsSkinSplitter2: TbsSkinSplitter;
    bsSkinPanel3: TbsSkinPanel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    BtnMobBaseBak: TbsSkinButton;
    BtnMobBaseRestore: TbsSkinButton;
    EditMobName: TbsSkinEdit;
    BtnFindMonName: TbsSkinButton;
    bsSkinButton11: TbsSkinButton;
    bsSkinButton14: TbsSkinButton;
    bsSkinDBNavigator2: TbsSkinDBNavigator;
    bsSkinExPanel2: TbsSkinExPanel;
    bsSkinMemo2: TbsSkinMemo;
    bsSkinPanel4: TbsSkinPanel;
    MobDBGrid: TDBGridEh;
    bsSkinTabSheet6: TbsSkinTabSheet;
    bsSkinSplitter3: TbsSkinSplitter;
    bsSkinPanel5: TbsSkinPanel;
    bsSkinStdLabel5: TbsSkinStdLabel;
    BtnItemsBaseBak: TbsSkinButton;
    BtnItemsBaseRestore: TbsSkinButton;
    BtnFindItemName: TbsSkinButton;
    EditItemsName: TbsSkinEdit;
    bsSkinGroupBox1: TbsSkinGroupBox;
    bsSkinStdLabel4: TbsSkinStdLabel;
    ComboBoxFilterItemsMode: TbsSkinComboBox;
    bsSkinButton7: TbsSkinButton;
    bsSkinButton13: TbsSkinButton;
    bsSkinDBNavigator3: TbsSkinDBNavigator;
    bsSkinExPanel3: TbsSkinExPanel;
    bsSkinSplitter4: TbsSkinSplitter;
    MemoItemsHint: TbsSkinMemo;
    ListBoxItemsHint: TbsSkinListBox;
    bsSkinScrollBar4: TbsSkinScrollBar;
    bsSkinPanel6: TbsSkinPanel;
    bsSkinScrollBar5: TbsSkinScrollBar;
    ItemsDBGrid: TDBGridEh;
    bsSkinTabSheet2: TbsSkinTabSheet;
    bsSkinGroupBox2: TbsSkinGroupBox;
    RzLabel1: TRzLabel;
    bsSkinPanel7: TbsSkinPanel;
    TrackEditColor1: TbsSkinTrackEdit;
    TrackEditColor2: TbsSkinTrackEdit;
    bsSkinTabSheet3: TbsSkinTabSheet;
    bsSkinPanel8: TbsSkinPanel;
    bsSkinSplitter5: TbsSkinSplitter;
    bsSkinPanel9: TbsSkinPanel;
    bsSkinGroupBox3: TbsSkinGroupBox;
    bsSkinGroupBox4: TbsSkinGroupBox;
    checkboxTransparent: TbsSkinCheckRadioBox;
    CheckBoxjump: TbsSkinCheckRadioBox;
    CheckBoxzuobiao: TbsSkinCheckRadioBox;
    checkboxXY: TbsSkinCheckRadioBox;
    Rb50: TbsSkinCheckRadioBox;
    rb100: TbsSkinCheckRadioBox;
    rb200: TbsSkinCheckRadioBox;
    rb400: TbsSkinCheckRadioBox;
    rb800: TbsSkinCheckRadioBox;
    rbauto: TbsSkinCheckRadioBox;
    btnx: TbsSkinButton;
    btny: TbsSkinButton;
    bsSkinPanel10: TbsSkinPanel;
    bsSkinStdLabel6: TbsSkinStdLabel;
    Label3: TbsSkinStdLabel;
    Label2: TbsSkinStdLabel;
    Label7: TbsSkinStdLabel;
    btnup: TbsSkinButton;
    btndelete: TbsSkinButton;
    BtnAutoPlay: TbsSkinButton;
    btninput: TbsSkinButton;
    btnAdd: TbsSkinButton;
    btnallinput: TbsSkinButton;
    btndown: TbsSkinButton;
    BtnJump: TbsSkinButton;
    btnstop: TbsSkinButton;
    BtnOut: TbsSkinButton;
    btnCreate: TbsSkinButton;
    btnallOut: TbsSkinButton;
    bsSkinPanel11: TbsSkinPanel;
    bsSkinPanel12: TbsSkinPanel;
    bsSkinSplitter6: TbsSkinSplitter;
    DrawGrid1: TDrawGrid;
    Image1: TImage;
    ScrollBox1: TScrollBox;
    PaintBox1: TFlickerFreePaintBox;
    SavePictureDialog1: TbsSkinSavePictureDialog;
    OpenPictureDialog1: TbsSkinOpenPictureDialog;
    Labeltype: TbsSkinStdLabel;
    LabelSize: TbsSkinStdLabel;
    LabelIndex: TbsSkinStdLabel;
    LabelX: TbsSkinStdLabel;
    LabelY: TbsSkinStdLabel;
    InputDialog: TbsSkinInputDialog;
    Timer1: TTimer;
    EditFileName: TbsSkinFileEdit;
    bsSkinGroupBox5: TbsSkinGroupBox;
    bsSkinCheckRadioBox4: TbsSkinCheckRadioBox;
    bsSkinFileEdit1: TbsSkinFileEdit;
    bsSkinStdLabel8: TbsSkinStdLabel;
    bsSkinSelectDirectoryDialog1: TbsSkinSelectDirectoryDialog;
    bsSkinButton1: TbsSkinButton;
    LabelColorCount: TbsSkinStdLabel;
    procedure BtnFindMagNameClick(Sender: TObject);
    procedure BtnFindMonNameClick(Sender: TObject);
    procedure BtnFindItemNameClick(Sender: TObject);
    procedure ComboBoxFilterItemsModeChange(Sender: TObject);
    procedure TrackEditColor1Change(Sender: TObject);
    procedure TrackEditColor2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bsSkinButton7Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure bsSkinButton12Click(Sender: TObject);
    procedure bsSkinButton11Click(Sender: TObject);
    procedure bsSkinButton15Click(Sender: TObject);
    procedure bsSkinButton14Click(Sender: TObject);
    procedure bsSkinButton13Click(Sender: TObject);
    procedure BtnMagicBaseBakClick(Sender: TObject);
    procedure BtnMagicBaseRestoreClick(Sender: TObject);
    procedure bsSkinButtonLabel1Click(Sender: TObject);
    procedure BtnAlterMagicExpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
    Function Extractrec(Restype,ResName,ResNewNAme:string):boolean;
    procedure FillInfo(index:Integer);
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnupClick(Sender: TObject);
    procedure btndownClick(Sender: TObject);
    procedure btnxClick(Sender: TObject);
    procedure btnyClick(Sender: TObject);
    procedure Rb50Click(Sender: TObject);
    procedure BtnJumpClick(Sender: TObject);
    procedure BtnAutoPlayClick(Sender: TObject);
    procedure btnstopClick(Sender: TObject);
    procedure btninputClick(Sender: TObject);
    procedure BtnOutClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnallinputClick(Sender: TObject);
    procedure btnallOutClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure EditFileNameButtonClick(Sender: TObject);
    procedure bsSkinFileEdit1ButtonClick(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure bsSkinCheckRadioBox4Click(Sender: TObject);
    procedure bsSkinTabSheet2Show(Sender: TObject);
  private
    Function ExportTxt(DBGridEh:TDBGrideh;Var TextName:string):BooLean;//����TXT
    Function ExportTxt1(DBGridEh:TDBGrideh;Var TextName:string):BooLean;
    procedure BeforePrint();
  public
    procedure LoadConfig(); //��������
    procedure Open();
  end;

var
  FrmMain: TFrmMain;
  boDelDenyChr: Boolean;
  boSellOffItem: Boolean;
  boBigStorage: Boolean;
  Wil:TWil;
  Bmpx,bmpy: Integer;
  BmpIndex,BmpWidth,BmpHeight: Integer;
  BmpZoom: Real;
  BmpTran: Boolean;
  MainBitMap:TBitMap;
  Stop:Boolean;
  boIsSort: Boolean;//��Ʒ���ݿ��Ƿ�����
implementation

uses EGameToolsShare,EDcodeUnit,AboutUnit, DelWil, AddOneWil, NewWil, AddWil,
  OutWil;

{$R *.dfm}

procedure TFrmMain.LoadConfig; //��������
var
  MyIni: TIniFile;
begin
  MyIni := TIniFile.Create(ConfigFileName);
  DBEName := MyIni.ReadString('SYSTEM','DBEName',DBEName);
  sGameDirectory := MyIni.ReadString('SYSTEM','ServerDir',sGameDirectory);
  MyIni.Free;
end;

procedure TFrmMain.Open;
begin
  FrmDM.TableMagic.DatabaseName := DBEName;
  FrmDM.TableMagic.Active := True;
       MagicDBGrid.Columns[0].Title.Caption := '���';
       MagicDBGrid.Columns[1].Title.Caption := '����';
       MagicDBGrid.Columns[2].Title.Caption := '����Ч��';
       MagicDBGrid.Columns[3].Title.Caption := 'ħ��Ч��';
       MagicDBGrid.Columns[4].Title.Caption := 'ħ������';
       MagicDBGrid.Columns[5].Title.Caption := '��������';
       MagicDBGrid.Columns[6].Title.Caption := '�������';
       MagicDBGrid.Columns[7].Title.Caption := '����ħ��';
       MagicDBGrid.Columns[8].Title.Caption := '��������';
       MagicDBGrid.Columns[9].Title.Caption := '�����������';
       MagicDBGrid.Columns[10].Title.Caption := 'ְҵ';
       MagicDBGrid.Columns[11].Title.Caption := '1���ȼ�';
       MagicDBGrid.Columns[12].Title.Caption := '1������';
       MagicDBGrid.Columns[13].Title.Caption := '2���ȼ�';
       MagicDBGrid.Columns[14].Title.Caption := '2������';
       MagicDBGrid.Columns[15].Title.Caption := '3���ȼ�';
       MagicDBGrid.Columns[16].Title.Caption := '3������';
       MagicDBGrid.Columns[17].Title.Caption := '������ʱ';
       MagicDBGrid.Columns[18].Title.Caption := '��ע˵��';
  FrmDM.TableMonster.DatabaseName := DBEName;
  FrmDM.TableMonster.Active := True;
       MobDBGrid.Columns[0].Title.Caption := '����';
       MobDBGrid.Columns[1].Title.Caption := '����';
       MobDBGrid.Columns[2].Title.Caption := '����ͼ��';
       MobDBGrid.Columns[3].Title.Caption := '�������';
       MobDBGrid.Columns[4].Title.Caption := '�ȼ�';
       MobDBGrid.Columns[5].Title.Caption := '����ϵ';
       MobDBGrid.Columns[6].Title.Caption := '�Ӿ���Χ';
       MobDBGrid.Columns[7].Title.Caption := '����ֵ';
       MobDBGrid.Columns[8].Title.Caption := '����ֵ';
       MobDBGrid.Columns[9].Title.Caption := 'ħ��ֵ';
       MobDBGrid.Columns[10].Title.Caption := '������';
       MobDBGrid.Columns[11].Title.Caption := 'ħ����';
       MobDBGrid.Columns[12].Title.Caption := '������';
       MobDBGrid.Columns[13].Title.Caption := '��󹥻���';
       MobDBGrid.Columns[14].Title.Caption := 'ħ����';
       MobDBGrid.Columns[15].Title.Caption := '������';
       MobDBGrid.Columns[16].Title.Caption := '�ٶ�';
       MobDBGrid.Columns[17].Title.Caption := '������';
       MobDBGrid.Columns[18].Title.Caption := '�����ٶ�';
       MobDBGrid.Columns[19].Title.Caption := '���߲���';
       MobDBGrid.Columns[20].Title.Caption := '���ߵȴ�';
       MobDBGrid.Columns[21].Title.Caption := '�����ٶ�';
  FrmDM.TableStdItems.DatabaseName := DBEName;
  FrmDM.TableStdItems.Active := True;
       ItemsDBGrid.Columns[0].Title.Caption := '���';
       ItemsDBGrid.Columns[1].Title.Caption := '����';
       ItemsDBGrid.Columns[2].Title.Caption := '�����';
       ItemsDBGrid.Columns[3].Title.Caption := 'װ�����';
       ItemsDBGrid.Columns[4].Title.Caption := '����';
       ItemsDBGrid.Columns[5].Title.Caption := 'Anicount';
       ItemsDBGrid.Columns[6].Title.Caption := 'Դ����';
       ItemsDBGrid.Columns[7].Title.Caption := '����';
       ItemsDBGrid.Columns[8].Title.Caption := '��Ʒ���';
       ItemsDBGrid.Columns[9].Title.Caption := '�־���';
       ItemsDBGrid.Columns[10].Title.Caption := 'HP���޼���';
       ItemsDBGrid.Columns[11].Title.Caption := '��������';
       ItemsDBGrid.Columns[12].Title.Caption := 'MP���޼���';
       ItemsDBGrid.Columns[13].Title.Caption := '������ʱ';
       ItemsDBGrid.Columns[14].Title.Caption := '��͹�����';
       ItemsDBGrid.Columns[15].Title.Caption := '��߹�����';
       ItemsDBGrid.Columns[16].Title.Caption := '���ħ����';
       ItemsDBGrid.Columns[17].Title.Caption := '���ħ����';
       ItemsDBGrid.Columns[18].Title.Caption := '��͵�����';
       ItemsDBGrid.Columns[19].Title.Caption := '��ߵ�����';
       ItemsDBGrid.Columns[20].Title.Caption := '��������';
       ItemsDBGrid.Columns[21].Title.Caption := '��Ҫ�ȼ�';
       ItemsDBGrid.Columns[22].Title.Caption := '�ۼ�';
       ItemsDBGrid.Columns[23].Title.Caption := '�����';
       ItemsDBGrid.Columns[24].Title.Caption := '��ע';
end;
//���Ҽ�����
procedure TFrmMain.BtnFindMagNameClick(Sender: TObject);
begin
  if EditMagName.Text = '' then Exit;
  with FrmDM.TableMagic do begin
    if not Eof then begin
      EditKey;
      DisableControls;
      while not Eof do begin
        if pos(Trim(EditMagName.Text), FieldByName('MagName').AsString)   <=   0   then Next
        else Break;
      end;
      EnableControls;
    end;
  end;
end;
//���ҹ���
procedure TFrmMain.BtnFindMonNameClick(Sender: TObject);
begin
  if EditMobName.Text = '' then Exit;
  with FrmDM.TableMonster do begin
    if not Eof then begin
      EditKey;
      DisableControls;
      while not Eof do begin
        if pos(Trim(EditMobName.Text), FieldByName('Name').AsString)   <=   0   then Next
        else Break;
      end;
      EnableControls;
    end;
  end;
end;
//������Ʒ��
procedure TFrmMain.BtnFindItemNameClick(Sender: TObject);
begin
  if EditItemsName.Text = '' then Exit;
  with FrmDM.TableStdItems do begin
    if not Eof then begin
      EditKey;
      DisableControls;
      while not Eof do begin
        if pos(Trim(EditItemsName.Text), FieldByName('Name').AsString)   <=   0   then Next
        else Break;
      end;
      EnableControls;
    end;
  end;
end;
//������Ʒ
procedure TFrmMain.ComboBoxFilterItemsModeChange(Sender: TObject);
  function FilterItems(Num: string):Boolean;
  begin
    Result := False;
    FrmDM.TableStdItems.Close;
    FrmDM.TableStdItems.Filter := 'Stdmode = '+Num;
    FrmDM.TableStdItems.Filtered := True;
    FrmDM.TableStdItems.Open;
    Result := True;
  end;
  function NoFilterItems():Boolean;
  begin
    Result := False;
    FrmDM.TableStdItems.Close;
    FrmDM.TableStdItems.Filter := '';
    FrmDM.TableStdItems.Filtered := False;
    FrmDM.TableStdItems.Open;
    Result := True;
  end;
begin
  case ComboBoxFilterItemsMode.ItemIndex of
    0: begin
        if NoFilterItems() then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    1: begin
        if FilterItems('0') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=���������');
          ListBoxItemsHint.Items.Add('1=���������');
          ListBoxItemsHint.Items.Add('2=����ˮ����');
          ListBoxItemsHint.Items.Add('3=��ҩƿ1����');
          ListBoxItemsHint.Items.Add('4=��ҩƿ2����');
          MemoItemsHint.Lines.Text := 'װ�����(Shape)=������ҩƷ������Ч��'+#13+
                                      'HP������(Ac)=����ֵ������'+#13+
                                      'MP������(Mac)=ħ��ֵ������'+#13+
                                      '������ʱ(Mac2)=������Чʱ�䣬��λΪ��';
        end;
    end;
    2: begin
        if FilterItems('1') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    3: begin
        if FilterItems('2') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    4: begin
        if FilterItems('3') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('1=���������Ѿ�');
          ListBoxItemsHint.Items.Add('2=��������;�');
          ListBoxItemsHint.Items.Add('3=���سǾ�');
          ListBoxItemsHint.Items.Add('4=��ף���ͣ�');
          ListBoxItemsHint.Items.Add('5=���л�سǾ�');
          ListBoxItemsHint.Items.Add('9=�޸��͵�����');
          ListBoxItemsHint.Items.Add('10=��ս���ͣ�');
          ListBoxItemsHint.Items.Add('11=����Ʊ��');
          ListBoxItemsHint.Items.Add('12=����ħ�����ȸ���ҩˮ');
          MemoItemsHint.Lines.Text := 'װ�����(Shape)=������12ʱ��Ϊһ��ľ��顢�͡���Ʊ��Ʒ������12ʱ��Ϊ����ҩˮ����Ʒ'+#13+
                                      '�鿴����shape=12������ҩƷ��'+#13+
                                      '��������ҩˮ��������ʱ(Mac2)=180����͹�����(Dc)=5���򹥻�������5��������ʱ180�룻'+#13+
                                      '������ҩˮ��������ʱ(Mac2)=180����������(Ac2)=1���򹥻��ٶ�˲�����180�룻'+#13+
                                      '��HPǿ��ˮ��������ʱ(Mac2)=120��HP���޼���(Ac)=50����HP��������50��������ʱ120��';
       end;
    end;


    5: begin
        if FilterItems('4') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=սʿְҵ��');
          ListBoxItemsHint.Items.Add('1=��ʦְҵ��');
          ListBoxItemsHint.Items.Add('2=��ʿְҵ��');
          ListBoxItemsHint.Items.Add('3=��ͨ�ã�');
          MemoItemsHint.Lines.Text := 'ѧϰ�ȼ�(DuraMax)=Ϊ��ϰʱ����Ҫ�ĵȼ��������ǡ���Ҫ�ȼ�(NeedLevel)����';
        end;
    end;
    6: begin
        if FilterItems('5') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=Ϊ����������');
          ListBoxItemsHint.Items.Add('1=��ľ������ľ����');
          ListBoxItemsHint.Items.Add('2=����������ͭ����');
          ListBoxItemsHint.Items.Add('3=����ͭ����');
          ListBoxItemsHint.Items.Add('4=���̽���');
          ListBoxItemsHint.Items.Add('5=����磩');
          ListBoxItemsHint.Items.Add('6=���ƻꡢذ�ף�');
          ListBoxItemsHint.Items.Add('7=�����ޣ�');
          ListBoxItemsHint.Items.Add('9=�����ߣ�');
          ListBoxItemsHint.Items.Add('10=��ն����');
          ListBoxItemsHint.Items.Add('13=����˪��');
          ListBoxItemsHint.Items.Add('14=����ħ��');
          ListBoxItemsHint.Items.Add('15=���˻ģ�');
          ListBoxItemsHint.Items.Add('16=�����£�');
          ListBoxItemsHint.Items.Add('17=�������¡�ն�µ���');
          ListBoxItemsHint.Items.Add('21=���޼�����');
          ListBoxItemsHint.Items.Add('22=��Ѫ����');
          ListBoxItemsHint.Items.Add('23=����֮�У�');
          ListBoxItemsHint.Items.Add('25=�����ƽ������ǽ���');
          ListBoxItemsHint.Items.Add('26=��������GM������');
          ListBoxItemsHint.Items.Add('29=������֮�У�');
          ListBoxItemsHint.Items.Add('30=����Ѫħ����GM����');
          ListBoxItemsHint.Items.Add('31=��ͳ˧֮�У�');
          ListBoxItemsHint.Items.Add('32=������֮�ȣ�');
          ListBoxItemsHint.Items.Add('33=�������ȣ�');
          MemoItemsHint.Lines.Text := '����������׼ȷ'+#13+
                                      '������ʱ������'+#13+
                                      'Դ��������ʥǿ��'+#13+
                                      'װ�����(Shape)=����װ����ۣ�����ֵ��ͬ����Ʒ������������Ͽ�Ҳ��ͬ'+#13+
                                      'ǿ����ʥ(Source)=����ǿ�ȣ�����ֵ��0~100����������ʥ������ֵ��-100~0��'+#13+
                                      '��Ʒ���(Looks)=����ֵ��ͬ����Ʒ������Ʒ�������Ҳ��ͬ'+#13+
                                      '�־ö�(DuraMax)=��1000Ϊ��λ��1000��Ϊ1����ĳ־�'+#13+
                                      '����(AC)=������ֵ��0~100��'+#13+
                                      '׼ȷ(AC2)=������ֵ��0~200��'+#13+
                                      '����(Mac)=������ֵ��0~100��'+#13+
                                      '�����ٶ�(Mac2)=���㹫ʽ�������ٶ�=246+X��XΪ������ֵ������Ϊ�������磺�����ٶ�+6������Mac2=-240������ֵ��-236~0'+#13+
                                      '��Ҫ�ȼ�(Need)�븽������(NeedLevel)=��Ҫ���ʹ�ã�Need=0ʱNeedLevelΪ����ȼ���Need=1ʱNeedLevelΪ���蹥������Need=2ʱNeedLevelΪ����ħ������Need=3ʱNeedLevelΪ���������';
        end;
    end;
    7: begin
        if FilterItems('6') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('8=�����꣩');
          ListBoxItemsHint.Items.Add('11=��������ն�죩');
          ListBoxItemsHint.Items.Add('12=��ħ�ȡ����ȣ�');
          ListBoxItemsHint.Items.Add('18=�����£�');
          ListBoxItemsHint.Items.Add('19=���������');
          ListBoxItemsHint.Items.Add('24=���þ�֮�ȣ�');
          ListBoxItemsHint.Items.Add('27=���Ȼ귨�ȡ�GMȨ�ȣ�');
          ListBoxItemsHint.Items.Add('28=������Ȩ�ȡ�����Ȩ�ȣ�');
          MemoItemsHint.Lines.Text := 'װ�����(Shape)=����װ����ۣ�����ֵ��ͬ����Ʒ������������Ͽ�Ҳ��ͬ'+#13+
                                      'ǿ����ʥ(Source)=����ǿ�ȣ�����ֵ��0~100����������ʥ������ֵ��-100~0��'+#13+
                                      '��Ʒ���(Looks)=����ֵ��ͬ����Ʒ������Ʒ�������Ҳ��ͬ'+#13+
                                      '�־ö�(DuraMax)=��1000Ϊ��λ��1000��Ϊ1����ĳ־�'+#13+
                                      '����(AC)=������ֵ��0~100��'+#13+
                                      '׼ȷ(AC2)=������ֵ��0~200��'+#13+
                                      '����(Mac)=������ֵ��0~100��'+#13+
                                      '�����ٶ�(Mac2)=���㹫ʽ�������ٶ�=246+X��XΪ������ֵ������Ϊ�������磺�����ٶ�+6������Mac2=-240������ֵ��-236~0'+#13+
                                      '��Ҫ�ȼ�(Need)�븽������(NeedLevel)=��Ҫ���ʹ�ã�Need=0ʱNeedLevelΪ����ȼ���Need=1ʱNeedLevelΪ���蹥������Need=2ʱNeedLevelΪ����ħ������Need=3ʱNeedLevelΪ���������';
        end;
    end;

    8: begin
        if FilterItems('7') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    9:begin
        if FilterItems('8') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := 'װ�����(Shape)=0-��ͨ���� 1-���Ʋ���'+#13+
                                      'Anicount=��(Shape)ʱ�����������,'+#13+
                                      '����(Reserved)=���������еľƾ���'+#13+
                                      'HP���޼���(AC)=���Ʋ��������е�Ʒ��';
        end;
    end;
    10:begin
        if FilterItems('9') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    11: begin
        if FilterItems('10') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('1=����');
          ListBoxItemsHint.Items.Add('2=���');
          ListBoxItemsHint.Items.Add('3=�ؿ�');
          ListBoxItemsHint.Items.Add('4=ħ������');
          ListBoxItemsHint.Items.Add('5=���ս��');
          MemoItemsHint.Lines.Text := 'HP���޺͹��������Ƿ������޺�����'+#13+
                                      'MP���޺�������ʱ��ħ�����޺�����';
        end;
    end;
    12: begin
        if FilterItems('11') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('1=����');
          ListBoxItemsHint.Items.Add('2=���');
          ListBoxItemsHint.Items.Add('3=�ؿ�');
          ListBoxItemsHint.Items.Add('4=ħ������');
          ListBoxItemsHint.Items.Add('5=���ս��');
          MemoItemsHint.Lines.Text := 'HP���޺͹��������Ƿ������޺�����'+#13+
                                      'MP���޺�������ʱ��ħ�����޺�����';
        end;
    end;
    13:begin
        if FilterItems('12') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := 'װ�����(Shape) 0-��ͨ��ʹ�� 1-ҩ��ʹ��';
        end;
    end;
    14:begin
        if FilterItems('13') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := 'װ�����(Shape)=�����ϵ�AniCount,��Ʒ��+1';
        end;
    end;
    15:begin
        if FilterItems('14') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := 'Anicount��Ӧ��(Shape)ʱ�����������';
        end;
    end;
    16: begin
        if FilterItems('15') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=��ͨͷ��');
          ListBoxItemsHint.Items.Add('125=����ͷ��');
          ListBoxItemsHint.Items.Add('129=��ͷ��');
          ListBoxItemsHint.Items.Add('132=����ͷ��');
          MemoItemsHint.Lines.Text := 'HP���޺͹��������Ƿ������޺�����'+#13+
                                      'MP���޺�������ʱ��ħ�����޺�����';
        end;
    end;
    17: begin
        if FilterItems('16') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    18: begin
        if FilterItems('19') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=��������ɫ���ݡ�ˮ��');
          ListBoxItemsHint.Items.Add('123=��������');
          MemoItemsHint.Lines.Text := '������ʱ Ϊ ���� '+#13+
                                      '�������� Ϊ ħ�����'+#13+
                                      'װ�����(Shape)=����װ����ۣ�����ֵ��ͬ����Ʒ������������Ͽ�Ҳ��ͬ'+#13+
                                      '��Ʒ���(Looks)=����ֵ��ͬ����Ʒ������Ʒ�������Ҳ��ͬ'+#13+
                                      '�־ö�(DuraMax)=��1000Ϊ��λ��1000��Ϊ1����ĳ־�'+#13+
                                      'ħ�����(Ac2)=��1��10%��2��20%����������ֵ��0~100��'+#13+
                                      '����(Mac)=������ֵ��0~100��'+#13+
                                      '����(Mac2)=������ֵ��0~100��'+#13+
                                      '�������߹�����(Dc��Dc2)=������ֵ��0~200��'+#13+
                                      '��������ħ����(Mc��Mc2)=������ֵ��0~200��'+#13+
                                      '�������ߵ�����(Sc��Sc2)=������ֵ��0~200��'+#13+
                                      '��Ҫ�ȼ�(Need)�븽������(NeedLevel)=��Ҫ���ʹ�ã�Need=0ʱNeedLevelΪ����ȼ���Need=1ʱNeedLevelΪ���蹥������Need=2ʱNeedLevelΪ����ħ������Need=3ʱNeedLevelΪ���������';
        end;
    end;
    19: begin
        if FilterItems('20') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=��ͨ����');
          ListBoxItemsHint.Items.Add('113=��������');
          ListBoxItemsHint.Items.Add('120=��������');
          ListBoxItemsHint.Items.Add('121=̽������');
          ListBoxItemsHint.Items.Add('135=��������');
          ListBoxItemsHint.Items.Add('138=��������');
          MemoItemsHint.Lines.Text := '����������׼ȷ'+#13+
                                      '������ʱ������'+#13+
                                      'װ�����(Shape)=����װ����ۣ�����ֵ��ͬ����Ʒ������������Ͽ�Ҳ��ͬ'+#13+
                                      '��Ʒ���(Looks)=����ֵ��ͬ����Ʒ������Ʒ�������Ҳ��ͬ'+#13+
                                      '�־ö�(DuraMax)=��1000Ϊ��λ��1000��Ϊ1����ĳ־�'+#13+
                                      '׼ȷ(Ac2)=������ֵ��0~100��'+#13+
                                      '����(Mac2)=������ֵ��0~100��'+#13+
                                      '�������߹�����(Dc��Dc2)=������ֵ��0~200��'+#13+
                                      '��������ħ����(Mc��Mc2)=������ֵ��0~200��'+#13+
                                      '�������ߵ�����(Sc��Sc2)=������ֵ��0~200��'+#13+
                                      '��Ҫ�ȼ�(Need)�븽������(NeedLevel)=��Ҫ���ʹ�ã�Need=0ʱNeedLevelΪ����ȼ���Need=1ʱNeedLevelΪ���蹥������Need=2ʱNeedLevelΪ����ħ������Need=3ʱNeedLevelΪ���������';
        end;
    end;
    20: begin
        if FilterItems('21') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=�������');
          ListBoxItemsHint.Items.Add('113=������');
          ListBoxItemsHint.Items.Add('127=GM����');
          MemoItemsHint.Lines.Text := 'HP���� Ӧ���ǹ�������'+#13+
                                      '��������Ӧ���������ָ�'+#13+
                                      '������ʱӦ����ħ���ָ�'+#13+
                                      'װ�����(Shape)=����װ����ۣ�����ֵ��ͬ����Ʒ������������Ͽ�Ҳ��ͬ'+#13+
                                      '��Ʒ���(Looks)=����ֵ��ͬ����Ʒ������Ʒ�������Ҳ��ͬ'+#13+
                                      '�־ö�(DuraMax)=��1000Ϊ��λ��1000��Ϊ1����ĳ־�'+#13+
                                      '�������ٶ�(Ac)=������ֵ��0~10��'+#13+
                                      '�����ָ�(Ac2)=��1��10%��2��20%����������ֵ��0~100��'+#13+
                                      '�������ٶ�(Mac)=������ֵ��0~10��'+#13+
                                      'ħ���ָ�(Mac2)=��1��10%��2��20%����������ֵ��0~100��'+#13+
                                      '�������߹�����(Dc��Dc2)=������ֵ��0~200��'+#13+
                                      '��������ħ����(Mc��Mc2)=������ֵ��0~200��'+#13+
                                      '�������ߵ�����(Sc��Sc2)=������ֵ��0~200��'+#13+
                                      '��Ҫ�ȼ�(Need)�븽������(NeedLevel)=��Ҫ���ʹ�ã�Need=0ʱNeedLevelΪ����ȼ���Need=1ʱNeedLevelΪ���蹥������Need=2ʱNeedLevelΪ����ħ������Need=3ʱNeedLevelΪ���������';
        end;
    end;
    21: begin
        if FilterItems('22') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=��ͨ��ָ');
          ListBoxItemsHint.Items.Add('111=�����ָ');
          ListBoxItemsHint.Items.Add('112=���ͽ�ָ');

          ListBoxItemsHint.Items.Add('113=��Խ�ָ');
          ListBoxItemsHint.Items.Add('114=�����ָ');
          ListBoxItemsHint.Items.Add('115=�����ָ');
          ListBoxItemsHint.Items.Add('116=������ָ');
          ListBoxItemsHint.Items.Add('117=��ŭ��ָ');
          ListBoxItemsHint.Items.Add('118=�����ָ');
          ListBoxItemsHint.Items.Add('119=�����ؽ�ָ');
          ListBoxItemsHint.Items.Add('122=�����ָ');
          ListBoxItemsHint.Items.Add('130=���ؽ�ָ');
          ListBoxItemsHint.Items.Add('133=������ָ');
          ListBoxItemsHint.Items.Add('136=���ѽ�ָ');
          MemoItemsHint.Lines.Text := 'HP���޺͹��������Ƿ������޺ͷ�������'+#13+
                                      'MP���޺�������ʱӦ����ħ�����޺�����'+#13+
                                      'װ�����(Shape)=����װ����ۣ�����ֵ��ͬ����Ʒ������������Ͽ�Ҳ��ͬ'+#13+
                                      '��Ʒ���(Looks)=����ֵ��ͬ����Ʒ������Ʒ�������Ҳ��ͬ'+#13+
                                      '�־ö�(DuraMax)=��1000Ϊ��λ��1000��Ϊ1����ĳ־�'+#13+
                                      '�������߹���(Ac��Ac2)=������ֵ��0~200��'+#13+
                                      '��������ħ��(Mac��Mac2)=������ֵ��0~200��'+#13+
                                      '�������߹�����(Dc��Dc2)=������ֵ��0~200��'+#13+
                                      '��������ħ����(Mc��Mc2)=������ֵ��0~200��'+#13+
                                      '�������ߵ�����(Sc��Sc2)=������ֵ��0~200��'+#13+
                                      '��Ҫ�ȼ�(Need)�븽������(NeedLevel)=��Ҫ���ʹ�ã�Need=0ʱNeedLevelΪ����ȼ���Need=1ʱNeedLevelΪ���蹥������Need=2ʱNeedLevelΪ����ħ������Need=3ʱNeedLevelΪ���������';
        end;
    end;
    22: begin
        if FilterItems('23') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=���������¡�����ָ');
          ListBoxItemsHint.Items.Add('113=��˹��ָ');
          ListBoxItemsHint.Items.Add('114=��˹��ָ');
          ListBoxItemsHint.Items.Add('119=��˹��ָ');
          ListBoxItemsHint.Items.Add('128=����ָ');
          MemoItemsHint.Lines.Text := 'MP�����ǹ�������'+#13+
                                      '�����ٶ��Ƕ�����'+#13+
                                      '������ʱ���ж��ָ�'+#13+
                                      'װ�����(Shape)=����װ����ۣ�����ֵ��ͬ����Ʒ������������Ͽ�Ҳ��ͬ'+#13+
                                      '��Ʒ���(Looks)=����ֵ��ͬ����Ʒ������Ʒ�������Ҳ��ͬ'+#13+
                                      '�־ö�(DuraMax)=��1000Ϊ��λ��1000��Ϊ1����ĳ־�'+#13+
                                      '�������ٶ�(Ac)=������ֵ��0~10��'+#13+
                                      '������(Ac2)=��1��10%��2��20%����������ֵ��0~100��'+#13+
                                      '�������ٶ�(Mac)=������ֵ��0~10��'+#13+
                                      '�ж��ָ�(Mac2)=��1��10%��2��20%����������ֵ��0~100��'+#13+
                                      '�������߹�����(Dc��Dc2)=������ֵ��0~200��'+#13+
                                      '��������ħ����(Mc��Mc2)=������ֵ��0~200��'+#13+
                                      '�������ߵ�����(Sc��Sc2)=������ֵ��0~200��'+#13+
                                      '��Ҫ�ȼ�(Need)�븽������(NeedLevel)=��Ҫ���ʹ�ã�Need=0ʱNeedLevelΪ����ȼ���Need=1ʱNeedLevelΪ���蹥������Need=2ʱNeedLevelΪ����ħ������Need=3ʱNeedLevelΪ���������';

        end;
    end;
    23: begin
        if FilterItems('24') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=�����������ն�����а����������');
          ListBoxItemsHint.Items.Add('124=��������');
          MemoItemsHint.Lines.Text := '����������׼ȷ'+#13+
                                      '������ʱ������'+#13+
                                      'װ�����(Shape)=����װ����ۣ�����ֵ��ͬ����Ʒ������������Ͽ�Ҳ��ͬ'+#13+
                                      '��Ʒ���(Looks)=����ֵ��ͬ����Ʒ������Ʒ�������Ҳ��ͬ'+#13+
                                      '�־ö�(DuraMax)=��1000Ϊ��λ��1000��Ϊ1����ĳ־�'+#13+
                                      '׼ȷ(Ac2)=������ֵ��0~100��'+#13+
                                      '����(Mac2)=������ֵ��0~100��'+#13+
                                      '�������߹�����(Dc��Dc2)=������ֵ��0~200��'+#13+
                                      '��������ħ����(Mc��Mc2)=������ֵ��0~200��'+#13+
                                      '�������ߵ�����(Sc��Sc2)=������ֵ��0~200��'+#13+
                                      '��Ҫ�ȼ�(Need)�븽������(NeedLevel)=��Ҫ���ʹ�ã�Need=0ʱNeedLevelΪ����ȼ���Need=1ʱNeedLevelΪ���蹥������Need=2ʱNeedLevelΪ����ħ������Need=3ʱNeedLevelΪ���������';

        end;
    end;
    24: begin
        if FilterItems('25') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=��������');
          ListBoxItemsHint.Items.Add('1=��ɫҩ��');
          ListBoxItemsHint.Items.Add('2=��ɫҩ��');
          ListBoxItemsHint.Items.Add('5=�����');
        end;
    end;
    25: begin
        if FilterItems('26') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=��ͨ��');
          ListBoxItemsHint.Items.Add('126=������');
          ListBoxItemsHint.Items.Add('131=��������');
          ListBoxItemsHint.Items.Add('134=��������');
          ListBoxItemsHint.Items.Add('137=��������');
          MemoItemsHint.Lines.Text := 'HP���޺͹��������Ƿ������޺�����'+#13+
                                      'MP���޺�������ʱ��ħ�����޺�����'+#13+
                                      'װ�����(Shape)=����װ����ۣ�����ֵ��ͬ����Ʒ������������Ͽ�Ҳ��ͬ'+#13+
                                      '��Ʒ���(Looks)=����ֵ��ͬ����Ʒ������Ʒ�������Ҳ��ͬ'+#13+
                                      '�־ö�(DuraMax)=��1000Ϊ��λ��1000��Ϊ1����ĳ־�'+#13+
                                      '�������߹���(Ac��Ac2)=������ֵ��0~200��'+#13+
                                      '��������ħ��(Mac��Mac2)=������ֵ��0~200��'+#13+
                                      '�������߹�����(Dc��Dc2)=������ֵ��0~200��'+#13+
                                      '��������ħ����(Mc��Mc2)=������ֵ��0~200��'+#13+
                                      '�������ߵ�����(Sc��Sc2)=������ֵ��0~200��'+#13+
                                      '��Ҫ�ȼ�(Need)�븽������(NeedLevel)=��Ҫ���ʹ�ã�Need=0ʱNeedLevelΪ����ȼ���Need=1ʱNeedLevelΪ���蹥������Need=2ʱNeedLevelΪ����ħ������Need=3ʱNeedLevelΪ���������';

        end;
    end;
    26: begin
        if FilterItems('30') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := 'Դ����������'+#13+
                                      'HP���޺͹��������Ƿ������޺�����'+#13+
                                      'MP���޺�������ʱ��ħ�����޺�����';
        end;
    end;
    27: begin
        if FilterItems('31') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('98=������ǿ��ҩ');
          ListBoxItemsHint.Items.Add('99=������ǿħ��ҩ');
          ListBoxItemsHint.Items.Add('100=������ҩ');
          ListBoxItemsHint.Items.Add('101=����ħ��ҩ');
          ListBoxItemsHint.Items.Add('102=��ҩ��С����');
          ListBoxItemsHint.Items.Add('103=ħ��ҩ��С����');
          ListBoxItemsHint.Items.Add('104=��ҩ���У���');
          ListBoxItemsHint.Items.Add('105=ħ��ҩ���У���');
          ListBoxItemsHint.Items.Add('106=�������Ѿ��');
          ListBoxItemsHint.Items.Add('107=������;��');
          ListBoxItemsHint.Items.Add('108=�سǾ��');
          ListBoxItemsHint.Items.Add('109=�л�سǾ��');
          ListBoxItemsHint.Items.Add('110=�����');
          ListBoxItemsHint.Items.Add('111=���������');
          ListBoxItemsHint.Items.Add('112=ѩ˪��');
          ListBoxItemsHint.Items.Add('113=��ľ��');
          ListBoxItemsHint.Items.Add('114=��ľ��');
          ListBoxItemsHint.Items.Add('115=�������춾');
          ListBoxItemsHint.Items.Add('116=����������');
          MemoItemsHint.Lines.Text := 'װ�������ҩƷ������'+#13+
                                      'Anicount�ǽű�������';
        end;
    end;
    28:begin
        if FilterItems('36') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('1=���š���ľ����ľ����ľ��');
        end;
    end;
    29: begin
        if FilterItems('40') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    30: begin
        if FilterItems('41') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=����֮�顢���֤��');
          ListBoxItemsHint.Items.Add('1=Ѫ����');
        end;
    end;
    31: begin
        if FilterItems('42') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    32: begin
        if FilterItems('43') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    33: begin
        if FilterItems('44') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=����Ž�');
          ListBoxItemsHint.Items.Add('1=����ͷ��ˮ����');
        end;
    end;
    34: begin
        if FilterItems('45') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=�׾ջ�');
          ListBoxItemsHint.Items.Add('2=����');
          ListBoxItemsHint.Items.Add('6=����');
        end;
    end;
    35: begin
        if FilterItems('46') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          ListBoxItemsHint.Items.Add('0=ƾ֤');
          ListBoxItemsHint.Items.Add('1=���롢ҩ��ʦ���ŵ�');
        end;
    end;
    36: begin
        if FilterItems('47') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    37: begin
        if FilterItems('50') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    38: begin
        if FilterItems('52') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    39: begin
        if FilterItems('53') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    40: begin
        if FilterItems('54') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    41:begin
        if FilterItems('60') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
          MemoItemsHint.Lines.Text := 'Anicount 1-��ͨ�� 2-ҩ��'+#13+
                                      'װ�����(Shape)=����(Shape),���ʱ'+#13+
                                      '�Ż��п��ܻ�ö�Ӧ�ľ���';
        end;
    end;
    42: begin
        if FilterItems('62') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    43: begin
        if FilterItems('63') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
    44: begin
        if FilterItems('64') then begin
          ListBoxItemsHint.Clear;
          MemoItemsHint.Clear;
        end;
    end;
  end;
end;
//���ݿ�
procedure TFrmMain.BtnMagicBaseBakClick(Sender: TObject);
begin
    SaveDialog1.Filter := '���ݿ�(*.DB)|*.DB';

    if Sender = BtnMagicBaseBak then begin
       if not FileExists(sGameDirectory + 'Mud2\DB\Magic.DB') then begin
         FrmMain.bsSkinMessage1.MessageDlg('����İ汾Ŀ¼��û���ҵ�ħ�����ݿ�!!',mtInformation,[mbOK],0);
         Exit;
       end;
       if SaveDialog1.Execute then
       CopyFile(PChar(sGameDirectory + 'Mud2\DB\Magic.DB'),PChar(SaveDialog1.FileName),False);
    end;
    if Sender = BtnMobBaseBak then begin
       if not FileExists(sGameDirectory + 'Mud2\DB\Monster.DB') then begin
         FrmMain.bsSkinMessage1.MessageDlg('����İ汾Ŀ¼��û���ҵ��������ݿ�!!',mtInformation,[mbOK],0);
         Exit;
       end;
       if SaveDialog1.Execute then
       CopyFile(PChar(sGameDirectory + 'Mud2\DB\Monster.DB'),PChar(SaveDialog1.FileName),False);
    end;
    if Sender = BtnItemsBaseBak then begin
       if not FileExists(sGameDirectory + 'Mud2\DB\StdItems.DB') then begin
         FrmMain.bsSkinMessage1.MessageDlg('����İ汾Ŀ¼��û���ҵ���Ʒ���ݿ�!!',mtInformation,[mbOK],0);
         Exit;
       end;
       if SaveDialog1.Execute then
       CopyFile(PChar(sGameDirectory + 'Mud2\DB\StdItems.DB'),PChar(SaveDialog1.FileName),False);
    end;
end;
//�ָ���
procedure TFrmMain.BtnMagicBaseRestoreClick(Sender: TObject);
begin
    SaveDialog1.Filter := '���ݿ�(*.DB)|*.DB';
    OpenDialog1.Filter := '���ݿ�(*.DB)|*.DB';
    if Sender = BtnMagicBaseRestore then begin
       if OpenDialog1.Execute then
       if bsSkinMessage1.MessageDlg('ȷ����ѡ�ļ�������������ݿ���'+#13+'(��ѡ�Ŀ⽫������еĿ�)' ,mtInformation,[mbYes,mbNo],0) = ID_NO then Exit;
       FrmDM.TableMagic.Active := False;
       CopyFile(PChar(OpenDialog1.FileName),PChar(sGameDirectory + 'Mud2\DB\Magic.DB'),False);
       FrmDM.TableMagic.Active := True;
    end;
    if Sender = BtnMobBaseRestore then begin
       if OpenDialog1.Execute then
       if bsSkinMessage1.MessageDlg('ȷ����ѡ�ļ�������������ݿ���'+#13+'(��ѡ�Ŀ⽫������еĿ�)' ,mtInformation,[mbYes,mbNo],0) = ID_NO then Exit;
       FrmDM.TableMonster.Active := False;
       CopyFile(PChar(OpenDialog1.FileName),PChar(sGameDirectory + 'Mud2\DB\Monster.DB'),False);
       FrmDM.TableMonster.Active := True;
    end;
    if Sender = BtnItemsBaseRestore then begin
       if OpenDialog1.Execute then
       if bsSkinMessage1.MessageDlg('ȷ����ѡ�ļ�������������ݿ���'+#13+'(��ѡ�Ŀ⽫������еĿ�)' ,mtInformation,[mbYes,mbNo],0) = ID_NO then Exit;
       FrmDM.TableStdItems.Active := False;
       CopyFile(PChar(OpenDialog1.FileName),PChar(sGameDirectory + 'Mud2\DB\StdItems.DB'),False);
       FrmDM.TableStdItems.Active := True;
    end;
end;
{******************************************************************************}
//��������ɫ����������
function GetRGB(c256: Byte): TColor;
begin
  Move(ColorArray, ColorTable, SizeOf(ColorArray));
  Result := RGB(ColorTable[c256].rgbRed, ColorTable[c256].rgbGreen, ColorTable[c256].rgbBlue);
end;

procedure TFrmMain.TrackEditColor1Change(Sender: TObject);
begin
  RzLabel1.Color := GetRGB(TrackEditColor1.Value);
end;

procedure TFrmMain.TrackEditColor2Change(Sender: TObject);
begin
   RzLabel1.Font.Color := GetRGB(TrackEditColor2.Value);
end;

procedure TFrmMain.FormShow(Sender: TObject);
var
  sProductName: string;
  sVersion: string;
  sBbsSite: string;
begin
  Decode(g_sProductName, sProductName);
  Decode(g_sVersion, sVersion);
  Decode(g_sBbsSite, sBbsSite);
  LabelProductName.Caption := sProductName;
  LabelVersion.Caption := sVersion;
  bsSkinLinkLabel1.Caption := sBbsSite;
  bsSkinLinkLabel1.URL := sBbsSite;
  bsSkinPageControl1.ActivePage:= bsSkinTabSheet1;
end;
{******************************************************************************}
//�ı���������
Function TFrmMain.ExportTxt(DBGridEh:TDBGrideh;Var TextName:string):BooLean;
Var F:TextFile;
    I:Integer;
    LStrField:String;
    Field: Array of String;
begin
   if DBGridEh.DataSource.DataSet.IsEmpty then
      Raise Exception.Create('û�����ݼ�¼���뵼����');
   DBGridEh.DataSource.DataSet.First;
   SetLength(Field,DBGridEh.DataSource.DataSet.FieldCount);
  { if pos('.txt',TextName)=0 then
     TextName:=TextName+'.txt';}
   if FileExists(TextName) then
      if bsSkinMessage1.MessageDlg('���ļ��Ѵ���,�Ƿ񸲸�',mtInformation,[mbOK,mbCancel],0) = IdCancel then Abort;
   DBGridEh.DataSource.DataSet.DisableControls;
   AssignFile(F,TextName);
   ReWrite(F);
   try
     try
     While Not DBGridEh.DataSource.DataSet.Eof do
     begin
       LStrField:='';
       For I:=0 to DBGridEh.DataSource.DataSet.FieldCount-1 do
       begin
         IF DBGridEh.Columns[I].Visible then  Field[I]:=Trim(DBGridEh.DataSource.DataSet.Fields[I].AsString)+';';
          LStrField:=LStrField+Trim(Field[I]);
       end;
       WriteLn(F,LStrField);
       DBGridEh.DataSource.DataSet.Next;
     end;
     Result:=True;
     Except
       Result:=False;
     end;
   finally
     CloseFile(F);
     DBGridEh.DataSource.DataSet.EnableControls;
   end;
end;
//�ı����е���
Function TFrmMain.ExportTxt1(DBGridEh:TDBGrideh;Var TextName:string):BooLean;
var J:integer;
    S:string;
    F:TextFile;
begin
  if DBGridEh.SelectedField = nil then
    Raise Exception.Create('û�����ݼ�¼���뵼����');

   AssignFile(F,TextName);
   ReWrite(F);
   try
     try
      with DBGridEh.DataSource.DataSet do begin
        for J := 0 to DBGridEh.FieldCount-1 do begin
          S:= S + DBGridEh.Fields[J].AsString+';';
        end;
        WriteLn(F,S);
      end;
     Result:=True;
     Except
       Result:=False;
     end;
   finally
     CloseFile(F);
   end;
end;

procedure TFrmMain.bsSkinButton7Click(Sender: TObject);
var
  Filename: STRING;
begin
  if FrmDM.TableStdItems.RecordCount = 0 then
  Begin
   //Application.MessageBox(#13'û�пɵ���������,�븴��!!!', MBInfo, 16+MB_OK);
   bsSkinMessage1.MessageDlg('û�пɵ���������,�븴��!!!',mtInformation,[mbOK],0);
   Exit;
  end;
  SaveDialog1.Filter:='�ı��ļ�(*.txt)|*.txt';
  if Not SaveDialog1.Execute then Exit;
  Filename:=SaveDialog1.FileName ;
  if ExportTxt(ItemsDBGrid,Filename) then
    bsSkinMessage1.MessageDlg('��Ʒ���ݵ����ɹ�!!!',mtInformation,[mbOK],0);//Application.MessageBox('��Ʒ���ݵ����ɹ�!!!', MBInfo, 64+MB_OK);
end;

procedure TFrmMain.N5Click(Sender: TObject);
var
  Filename: STRING;
begin
  IF ItemsDBGrid.DataSource=nil then Exit;
  SaveDialog1.Filter:='�ı��ļ�(*.txt)|*.txt';
  if Not SaveDialog1.Execute then Exit;
  Filename:=SaveDialog1.FileName ;

  case bsSkinPageControl2.TabIndex of
    0:begin
       if FrmDM.TableMagic.RecordCount = 0 then
          Begin
           //Application.MessageBox(#13'û�пɵ���������,�븴��!!!', MBInfo, 16+MB_OK);
           bsSkinMessage1.MessageDlg('û�пɵ���������,�븴��!!!',mtInformation,[mbOK],0);
           Exit;
          end;
       if ExportTxt1(MagicDBGrid,Filename) then bsSkinMessage1.MessageDlg('�������ݵ����ɹ�!!!',mtInformation,[mbOK],0);//Application.MessageBox('�������ݵ����ɹ�!!!', MBInfo, 64+MB_OK);
      end;
    1:begin
        if FrmDM.TableMonster.RecordCount = 0 then
          Begin
           //Application.MessageBox(#13'û�пɵ���������,�븴��!!!', MBInfo, 16+MB_OK);
           bsSkinMessage1.MessageDlg('û�пɵ���������,�븴��!!!',mtInformation,[mbOK],0);
           Exit;
          end;
       if ExportTxt1(MobDBGrid,Filename) then
          bsSkinMessage1.MessageDlg('������ݵ����ɹ�!!!',mtInformation,[mbOK],0);//Application.MessageBox('������ݵ����ɹ�!!!', MBInfo, 64+MB_OK);
      end;
    2:begin
        if FrmDM.TableStdItems.RecordCount = 0 then
          Begin
           //Application.MessageBox(#13'û�пɵ���������,�븴��!!!', MBInfo, 16+MB_OK);
           bsSkinMessage1.MessageDlg('û�пɵ���������,�븴��!!!',mtInformation,[mbOK],0);
           Exit;
          end;
       if ExportTxt1(ItemsDBGrid,Filename) then
          bsSkinMessage1.MessageDlg('��Ʒ���ݵ����ɹ�!!!',mtInformation,[mbOK],0);//Application.MessageBox('��Ʒ���ݵ����ɹ�!!!', MBInfo, 64+MB_OK);
      end; 
  end;
end;

procedure TFrmMain.bsSkinButton12Click(Sender: TObject);
var
  Filename: STRING;
begin
  IF MagicDBGrid.DataSource=nil then Exit;
  if FrmDM.TableMagic.RecordCount = 0 then
  Begin
   bsSkinMessage1.MessageDlg('û�пɵ���������,�븴��!!!',mtInformation,[mbOK],0);
   Exit;
  end;
  SaveDialog1.Filter:='�ı��ļ�(*.txt)|*.txt';
  if Not SaveDialog1.Execute then Exit;
  Filename:=SaveDialog1.FileName ;
  if ExportTxt(MagicDBGrid,Filename) then
     bsSkinMessage1.MessageDlg('�������ݵ����ɹ�!!!',mtInformation,[mbOK],0);//Application.MessageBox('�������ݵ����ɹ�!!!', MBInfo, 64+MB_OK);
end;

procedure TFrmMain.bsSkinButton11Click(Sender: TObject);
var
  Filename: STRING;
begin
  IF MobDBGrid.DataSource=nil then Exit;
  if FrmDM.TableMonster.RecordCount = 0 then
  Begin
   bsSkinMessage1.MessageDlg('û�пɵ���������,�븴��!!!',mtInformation,[mbOK],0);
   Exit;
  end;
  SaveDialog1.Filter:='�ı��ļ�(*.txt)|*.txt';
  if Not SaveDialog1.Execute then Exit;
  Filename:=SaveDialog1.FileName ;
  if ExportTxt(MobDBGrid,Filename) then
     bsSkinMessage1.MessageDlg('������ݵ����ɹ�!!!',mtInformation,[mbOK],0);
end;
{******************************************************************************}
//�����Ǳ������
procedure TFrmMain.BeforePrint();
begin
 {if Printer.Printers.Count = 0 then begin
   bsSkinMessage1.MessageDlg('��Ҫ��װ��ӡ�����ܴ�ӡ!!!',mtInformation,[mbOK],0);
   Abort;
  end; }
  PrintDBGridEh1.PageFooter.CenterText.Add('��&[Page]ҳ ��&[Pages]ҳ');
  PrintDBGridEh1.PageHeader.CenterText.Clear;
  {�������������}
  PrintDBGridEh1.PageHeader.Font.Size:=16;                //��С
  PrintDBGridEh1.PageHeader.Font.Name:='����';            //����
  PrintDBGridEh1.PageHeader.Font.Charset:=GB2312_CHARSET; //�ַ���
  PrintDBGridEh1.PageHeader.Font.Style:=[fsBold];         //����Ӵ�
end;

procedure TFrmMain.bsSkinButton15Click(Sender: TObject);
begin
  PrintDBGridEh1.DBGridEh:=MagicDBGrid;
  BeforePrint();
  PrintDBGridEh1.PageHeader.CenterText.Add('IGE�Ƽ�--��������');
  PrintDBGridEh1.Preview;
end;

procedure TFrmMain.bsSkinButton14Click(Sender: TObject);
begin
  PrintDBGridEh1.DBGridEh:=MobDBGrid;
  BeforePrint();
  PrintDBGridEh1.PageHeader.CenterText.Add('IGE�Ƽ�--��������');
  PrintDBGridEh1.Preview;
end;

procedure TFrmMain.bsSkinButton13Click(Sender: TObject);
begin
  PrintDBGridEh1.DBGridEh:=ItemsDBGrid;
  BeforePrint();
  PrintDBGridEh1.PageHeader.CenterText.Add('IGE�Ƽ�--��Ʒ����');
  PrintDBGridEh1.Preview;
end;
{******************************************************************************}



procedure TFrmMain.bsSkinButtonLabel1Click(Sender: TObject);
begin
  FrmAbout := TFrmAbout.Create(Owner);
  FrmAbout.Open();
  FrmAbout.Free;
end;

procedure TFrmMain.BtnAlterMagicExpClick(Sender: TObject);
var
  str,SQLstr: string;
begin
  if bsSkinCheckRadioBox1.Checked then str:=' L1Train='+ FloatToStr(bsSkinSpinEdit1.Value)
  else if bsSkinCheckRadioBox2.Checked then str:=' L2Train='+ FloatToStr(bsSkinSpinEdit1.Value)
  else if bsSkinCheckRadioBox3.Checked then str:=' L3Train='+ FloatToStr(bsSkinSpinEdit1.Value);
  SQLstr:='Update Magic set '+ str;
  with FrmDM.Query1 do
  begin
    close;
    Sql.Clear;
    sql.Add(Sqlstr);
    ExecSql;
  end;
  FrmDM.TableMagic.Refresh;
end;
//----------------------------------------------------------------------------
//Wil�༭��
function TFrmMain.Extractrec(Restype,ResName,ResNewNAme:string):boolean;
var
  Res:TResourceStream;
Begin
  Res:=TResourceStream.Create(HinStance,ResName,Pchar(ResType));
  Res.SaveToFile(ResNewName);
  Res.Free;
  Result:=True;
End;

procedure TFrmMain.FillInfo(index:Integer);
var
  Width1,Height1:Integer;
  zoom,zoom1:real;
begin
  zoom:= 0;
  zoom1:=0;
  if Wil.Stream<>nil then begin
      BMpIndex:=Index;
      BmpTran:=checkboxTransparent.Checked;
      MainBitMap:=Wil.Bitmaps[index];
      Width1:=Wil.Width;
      Height1:=WIl.Height;
      if CheckBoxjump.Checked then begin
        While ((Width1<=1) or (Height1<=1))and (BmpIndex<Wil.ImageCount-1) do Begin
          Inc(BmpIndex);
          Width1:=Wil.Bitmaps[Bmpindex].Width;
          Height1:=WIl.Bitmaps[Bmpindex].Height;
        End;
      End;
      if RbAuto.Checked then Begin
        if (Width1<PaintBox1.Width) and (Height1<Paintbox1.Height) then Begin
         BmpZoom:=1;
         if checkboxXY.Checked then Begin
           Bmpx:=Paintbox1.Width div 2 +WIl.px;
           Bmpy:=PaintBox1.Height div 2+Wil.py;
         End Else Begin
           Bmpx:=(Paintbox1.Width-Width1) div 2;
           Bmpy:=(Paintbox1.Height-Height1) div 2;
         end;
        End else Begin
          if Width1>PaintBox1.Width then Zoom:=Width1/PaintBox1.Width;
          if Height1>PaintBox1.Height then Zoom1:=Height1/PaintBox1.Height;
          if zoom>zoom1 then BmpZoom:=Zoom
          else Bmpzoom:=Zoom1;
          bmpx:=1;
          Bmpy:=1;
        End;
      End else Begin
         if Rb50.Checked then BmpZoom:=0.5;
         if Rb100.Checked then BmpZoom:=1;
         if Rb200.Checked then BmpZoom:=2;
         if Rb400.Checked then BmpZoom:=4;
         if Rb800.Checked then BmpZoom:=8;
         bmpx:=1;
         Bmpy:=1;
        Paintbox1.Width:=ScrollBox1.Width-5;
        PaintBox1.Height:=ScrollBox1.Height-5;
        Width1:=Round(Width1*BMpZoom);
        Height1:=Round(Height1*BmpZoom);
        if (Width1<PaintBox1.Width) and (Height1<Paintbox1.Height) then Begin
         if checkboxXY.Checked then Begin
           Bmpx:=Paintbox1.Width div 2 +WIl.px;
           Bmpy:=PaintBox1.Height div 2+Wil.py;
         End Else Begin
           Bmpx:=(Paintbox1.Width-width1) div 2;
           Bmpy:=(Paintbox1.Height-Height1) div 2;
         end;
        End else Begin
          PaintBox1.Width:=Width1;
          PaintBox1.Height:=Height1;
        End;
      End;

      Labelx.Caption:=InttoStr(Wil.px);
      Labely.Caption:=InttoStr(Wil.py);
      LabelSize.Caption:=Inttostr(Width1)+'*'+Inttostr(Height1);
      LabelIndex.Caption:=Inttostr(Index)+'/'+Inttostr(WIl.ImageCount-1);
      case WIl.FileType of
       0: LabelType.Caption:='MIR2 ��ʽ(1)';
       1: LabelType.Caption:='MIR2 ��ʽ(2)';
       2:Begin
         if WIl.OffSet=0 then LabelType.Caption:='EI3 ��ʽ(1)'
         else LabelType.Caption:='EI3 ��ʽ(2)';
       End;
      end;
      LabelColorCount.Caption := '��ɫ('+ IntToStr(Wil.FileColorCount)+')';
      PaintBox1.Refresh;
      if Wil.FileType=2 then Begin
        BtnAllInput.Enabled:=False;
        BtnAllOut.Enabled:=True;
        Btnout.Enabled:=True;
        BtnInput.Enabled:=False;
        BtnAdd.Enabled:=False;
        BtnUp.Enabled:=True;
        BtnDown.Enabled:=True;
        BtnJump.Enabled:=True;
        BtnStop.Enabled:=True;
        BtnAutoPlay.Enabled:=True;
        BtnCreate.Enabled:=True;
        BtnStop.Enabled:=True;
        btndelete.Enabled:=False;
        btnx.Enabled:=False;
        Btny.Enabled:=False;
      End else Begin
        Btnx.Enabled:=True;
        Btny.Enabled:=True;
        btndelete.Enabled:=True;
        BtnUp.Enabled:=True;
        BtnDown.Enabled:=True;
        BtnJump.Enabled:=True;
        BtnStop.Enabled:=True;
        BtnAdd.Enabled:=True;
        BtnAllInput.Enabled:=True;
        BtnAllOut.Enabled:=True;
        BtnAutoPlay.Enabled:=True;
        BtnCreate.Enabled:=True;
        Btnout.Enabled:=True;
        BtnStop.Enabled:=True;
        BtnInput.Enabled:=True;
      End;

      if Index=(WIl.ImageCount-1) then Begin
        BtnDown.Enabled:=False;
        BtnUp.Enabled:=True;
      End;
      if Index=0 then  BtnUp.Enabled:=False;
      DrawGrid1.Row:=BmpIndex div 6;
      Drawgrid1.Col:=BmpIndex mod 6;
  End;
End;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Wil:=TWil.Create(self);
end;

procedure TFrmMain.FormPaint(Sender: TObject);
begin
  PaintBox1.Refresh;
end;

procedure TFrmMain.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
begin
 if Wil.Stream<>nil then
 Begin
   Wil.DrawZoom(Canvas,Bmpx,Bmpy,BmpINdex,BmpZoom,BmpTran,false);

 End;
 if CheckBoxzuobiao.Checked then
 Begin
   Canvas.Pen.Style:=psDot;
   Canvas.MoveTo(0,Paintbox1.Height div 2);
   Canvas.LineTo(Paintbox1.Width,Paintbox1.Height div 2);
   Canvas.MoveTo(Paintbox1.Width div 2,0);
   Canvas.LineTo(Paintbox1.Width div 2,Paintbox1.Height);
 End;
end;

procedure TFrmMain.DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Index:integer;
  w,h:integer;
  str:string;
begin
  index:=ARow*6+ACol;
  if (Wil.Stream<>nil) and (Index<wil.ImageCount) then Begin
    Wil.DrawZoomEx(DrawGrid1.Canvas,Rect,index,true);
    Str:=format('%.5d',[index]);
    DrawGrid1.Canvas.Brush.Style:=bsclear;
    w:=DrawGrid1.Canvas.TextWidth(str);
    h:=DrawGrid1.Canvas.TextHeight(str);
    DrawGrid1.Canvas.TextOut(Rect.Right-w-1,Rect.Bottom-h-1,str);
    if State<>[] then FillInfo(Index);
  End;
end;

procedure TFrmMain.btnupClick(Sender: TObject);
begin
 if Wil.Stream<>nil then Begin
   Dec(BmpIndex);
   if BmpIndex < 0 then BmpIndex:=0;
   FillInfo(BmpIndex);
 end;
end;

procedure TFrmMain.btndownClick(Sender: TObject);
begin
 if Wil.Stream <> nil then Begin
   Inc(BmpIndex);
   if BmpIndex > Wil.ImageCount then  BmpIndex:=Wil.ImageCount;
   FillInfo(BmpIndex);
 End;
end;

procedure TFrmMain.btnxClick(Sender: TObject);
var
  x:smallint;
  code:Integer;
  Str:string;
Begin
  str:= InputDialog.InputBox('����ͼƬ������','������ͼƬ�����꣺','1');
  if str='' then exit;
  val(str,x,code);
  if code > 0 then Begin
     bsSkinMessage1.MessageDlg('��������ȷ�ĸ�ʽ',mtInformation,[mbOK],0);
     exit;
  End;
  Wil.Changex(BmpIndex,x);
  FillInfo(BmpIndex);
end;

procedure TFrmMain.btnyClick(Sender: TObject);
var
  x:smallint;
  code:Integer;
  Str:string;
Begin
  str:= InputDialog.InputBox('����ͼƬ������','������ͼƬ�����꣺','1');
  if str='' then exit;
  val(str,x,code);
  if code > 0 then Begin
     bsSkinMessage1.MessageDlg('��������ȷ�ĸ�ʽ',mtInformation,[mbOK],0);
     exit;
  End;
  Wil.Changey(BmpIndex,x);
  FillInfo(BmpIndex);
end;

procedure TFrmMain.Rb50Click(Sender: TObject);
begin
  FillInfo(BmpIndex);
end;

procedure TFrmMain.BtnJumpClick(Sender: TObject);
var
  Index,Code:Integer;
  str:string;
begin
  if Wil.Stream <> nil then Begin
    str:= InputDialog.InputBox('��ת','������ͼƬ�����ţ�','');
    if str=''	then exit;
    val(str,index,code);
    if (Index>=0) and (Index<Wil.ImageCount) then FillInfo(Index);
  end;
end;

procedure TFrmMain.BtnAutoPlayClick(Sender: TObject);
begin
  Stop:=False;
  Timer1.Enabled:= True;
end;

procedure TFrmMain.btnstopClick(Sender: TObject);
begin
  Stop:= True;
  Timer1.Enabled:= False;
end;

procedure TFrmMain.btninputClick(Sender: TObject);
var
  FileName:String;
  BitMap:TBitMap;
begin
  if OpenPictureDialog1.Execute then FileName:=OpenPictureDialog1.FileName;
  Application.ProcessMessages;

  if (FileName<>'') then Begin
    Image1.Picture.LoadFromFile(FileName);
    BitMap:=Image1.Picture.Bitmap;
  if WIl.ReplaceBitMap(BmpIndex,BitMap) then
     bsSkinMessage1.MessageDlg('����ͼƬ�ɹ���',mtInformation,[mbOK],0)
  else
    bsSkinMessage1.MessageDlg('����ͼƬʧ�ܣ�',mtInformation,[mbOK],0);
  end Else bsSkinMessage1.MessageDlg('����ͼƬʧ�ܣ�',mtInformation,[mbOK],0);
end;

procedure TFrmMain.BtnOutClick(Sender: TObject);
var
  FileName:String;
begin
  if WIl.Stream <> nil then Begin
    SavePictureDialog1.FileName:=format('%.6d.bmp',[BmpIndex]);
    if SavePictureDialog1.Execute then FileName:=SavePictureDialog1.FileName;
    if FileName<>'' then Begin
      Wil.Bitmaps[BmpIndex].SaveToFile(FileName);
      bsSkinMessage1.MessageDlg('����ͼƬ�ɹ���',mtInformation,[mbOK],0)
    end;
  end;
end;

procedure TFrmMain.btndeleteClick(Sender: TObject);
begin
  FormDel := TFormDel.Create(Owner);
  FormDel.ShowModal;
  FormDel.Free;
end;

procedure TFrmMain.btnAddClick(Sender: TObject);
begin
  if Wil.Stream <> nil then begin
    FrmAddOneWil := TFrmAddOneWil.Create(Owner);
    FrmAddOneWil.ShowModal;
    FrmAddOneWil.Free;
  end;
end;

procedure TFrmMain.btnCreateClick(Sender: TObject);
begin
  FrmNewWil := TFrmNewWil.Create(Owner);
  FrmNewWil.ShowModal;
  FrmNewWil.Free;
end;

procedure TFrmMain.btnallinputClick(Sender: TObject);
begin
  if WIl.Stream <> nil then begin
     FrmAddWil := TFrmAddWil.Create(Owner);
     FrmAddWil.EditEnd.Text:=Inttostr(Wil.ImageCount-1);
     FrmAddWil.EditPicPath.Text:='';
     FrmAddWil.ShowModal;
     FrmAddWil.Free;
  end;
end;

procedure TFrmMain.btnallOutClick(Sender: TObject);
begin
 if WIl.Stream <> nil then Begin
    FrmOutWil := TFrmOutWil.Create(Owner);
    FrmOutWil.EditPicPath.Text:='';
    FrmOutWil.editBegin.Text:='0';
    FrmOutWil.EditEnd.Text:=Inttostr(wil.ImageCount-1);
    FrmOutWil.ShowModal;
    FrmOutWil.Free;
 end;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  if (BmpIndex >= WIl.ImageCount-1) or Stop then Timer1.Enabled:=False;
  Inc(BmpIndex);
  FillInfo(BmpIndex);
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.Terminate;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FrmMain:= nil;
  application.Terminate;
end;

procedure TFrmMain.EditFileNameButtonClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Wil�ļ�(*.Wil)|*.Wil';
  if OpenDialog1.Execute then begin
    EditFileName.Text:=OPenDialog1.FileName;
    if FileExists(EditFileName.Text) then begin
      if Wil.Stream<>nil then Wil.Finalize;
      Wil.FileName:=EditFileName.Text;
      Wil.Initialize;
      if wil.Stream= nil then begin
         bsSkinMessage1.MessageDlg('WIl�ļ��Ѿ����ƻ�����wil�ļ���',mtInformation,[mbOK],0);
         Exit;
      end;
      BmpIndex:=0;
      DrawGrid1.RowCount:=(Wil.ImageCount div 6)+1;
      DrawGrid1.Refresh;
      FillInfo(BmpIndex);
    end;
  end;
end;

procedure TFrmMain.bsSkinFileEdit1ButtonClick(Sender: TObject);
begin
  if bsSkinSelectDirectoryDialog1.Execute then begin
    bsSkinFileEdit1.Text:= bsSkinSelectDirectoryDialog1.Directory;
    if bsSkinFileEdit1.Text <> '' then bsSkinButton1.Enabled:= True;
  end;
end;
//��Ʒ���ݿ���չ 20080619
procedure TFrmMain.bsSkinButton1Click(Sender: TObject);
  function GetParadoxConnectionString(Path: string; Password: string): string;
  var
    s: string;
  begin
    s := 'Provider=Microsoft.Jet.OLEDB.4.0;';
    s := s + 'Data Source=' + Path + ';';
    s := s + 'Extended Properties=Paradox 7.x;Persist Security Info=False;';
    s := s + 'Mode=Share Deny None;';
    if Password <> '' then
      s := s + 'Jet OLEDB:Database Password=' + Password;
    Result := s;
  end;
var
  DestTable:TTable;
  ADOA: TAdoquery;
  I: Integer;
begin
  bsSkinCheckRadioBox4.Enabled := False;
  DestTable:=TTable.Create(Application);
try
  FrmDM.TableStdItems.Open;
  with DestTable do begin
    FieldDefs.Assign(FrmDM.TableStdItems.FieldDefs);//���Ʊ�ṹ
    DataBaseName:= bsSkinFileEdit1.text;//����·��
    TableName:='NewStdItems';//���ݿ���
    TableType:=ttParadox;//���ݿ�����
    CreateTable;//�����µ����ݱ�
  end;

  if FrmDM.TableStdItems.findfield('Desc') = nil  then begin//�ж��ֶ��Ƿ����
    ADOA:=TADOQUERY.Create(nil);
    with ADOA do begin
      ConnectionString:=GetParadoxConnectionString(bsSkinFileEdit1.text,'');
      SQL.Add('ALTER TABLE NewStdItems ADD [Desc] CHAR(80)');
      ExecSQL;
    end;
    ADOA.Free;
  end;

  DestTable.Open;
  FrmDM.Query1.DataBaseName:='HERODB';
  with FrmDM.Query1 do begin
    close;
    sql.Clear ;
    sql.add('select * from StdItems order by idx  DESC');
    open;
    First;
    I:= FrmDM.Query1.RecordCount - 1;
    while not FrmDM.Query1.Eof do begin
      with DestTable  do begin
        Insert;
        if boIsSort then FieldByName('Idx').AsInteger:= I
        else FieldByName('Idx').AsInteger:= FrmDM.Query1.FieldByName('Idx').AsInteger;
        FieldByName('Name').AsString:=FrmDM.Query1.FieldByName('Name').AsString;
        FieldByName('StdMode').AsInteger:=FrmDM.Query1.FieldByName('StdMode').AsInteger;
        FieldByName('Shape').AsInteger:=FrmDM.Query1.FieldByName('Shape').AsInteger;//װ�����
        FieldByName('Weight').AsInteger:=FrmDM.Query1.FieldByName('Weight').AsInteger;//����
        FieldByName('AniCount').AsInteger:= FrmDM.Query1.FieldByName('AniCount').AsInteger;
        FieldByName('Source').AsInteger:= FrmDM.Query1.FieldByName('Source').AsInteger;
        FieldByName('Reserved').AsInteger:= FrmDM.Query1.FieldByName('Reserved').AsInteger;//����
        FieldByName('Looks').AsInteger:= FrmDM.Query1.FieldByName('Looks').AsInteger;//��Ʒ���
        FieldByName('DuraMax').AsInteger:= FrmDM.Query1.FieldByName('DuraMax').AsInteger;
        FieldByName('Ac').AsInteger:=FrmDM.Query1.FieldByName('Ac').AsInteger;
        FieldByName('Ac2').AsString:=FrmDM.Query1.FieldByName('Ac2').AsString;
        FieldByName('Mac').AsInteger:=FrmDM.Query1.FieldByName('Mac').AsInteger;
        FieldByName('Mac2').AsInteger:=FrmDM.Query1.FieldByName('Mac2').AsInteger;
        FieldByName('Dc').AsInteger:=FrmDM.Query1.FieldByName('Dc').AsInteger;
        FieldByName('DC2').AsInteger:= FrmDM.Query1.FieldByName('DC2').AsInteger;
        FieldByName('Mc').AsInteger:= FrmDM.Query1.FieldByName('Mc').AsInteger;
        FieldByName('Mc2').AsInteger:= FrmDM.Query1.FieldByName('Mc2').AsInteger;
        FieldByName('Sc').AsInteger:= FrmDM.Query1.FieldByName('Sc').AsInteger;
        FieldByName('Sc2').AsInteger:= FrmDM.Query1.FieldByName('Sc2').AsInteger;
        FieldByName('Need').AsInteger:= FrmDM.Query1.FieldByName('Need').AsInteger;
        FieldByName('NeedLevel').AsInteger:= FrmDM.Query1.FieldByName('NeedLevel').AsInteger;
        FieldByName('Stock').AsInteger:= FrmDM.Query1.FieldByName('Stock').AsInteger;
        FieldByName('Price').AsInteger:= FrmDM.Query1.FieldByName('Price').AsInteger;
        post;
        if boIsSort then Dec(I);
      end;
      FrmDM.Query1.Next;
    end;
  end;
  finally
    DestTable.Free;
  end;
  bsSkinMessage1.MessageDlg('��Ʒ���ݿ���չ��ɣ�',mtInformation,[mbOK],0);
  bsSkinButton1.Enabled:= False;
  bsSkinCheckRadioBox4.Enabled := True;
end;

procedure TFrmMain.bsSkinCheckRadioBox4Click(Sender: TObject);
begin
  boIsSort:= bsSkinCheckRadioBox4.Checked;
end;

procedure TFrmMain.bsSkinTabSheet2Show(Sender: TObject);
begin
  boIsSort:= bsSkinCheckRadioBox4.Checked;
end;

end.

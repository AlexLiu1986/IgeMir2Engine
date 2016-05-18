unit HeroConfig;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  ComCtrls, StdCtrls, Spin, Grids;

type
  TLevelExpScheme = (s_OldLevelExp, s_StdLevelExp, s_2Mult, s_5Mult, s_8Mult, s_10Mult, s_20Mult, s_30Mult, s_40Mult, s_50Mult, s_60Mult, s_70Mult, s_80Mult, s_90Mult, s_100Mult, s_150Mult, s_200Mult, s_250Mult, s_300Mult);
  TfrmHeroConfig = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    GroupBoxLevelExp: TGroupBox;
    Label37: TLabel;
    ComboBoxLevelExp: TComboBox;
    GridLevelExp: TStringGrid;
    GroupBox8: TGroupBox;
    Label23: TLabel;
    EditKillMonExpRate: TSpinEdit;
    GroupBox29: TGroupBox;
    Label61: TLabel;
    EditStartLevel: TSpinEdit;
    GroupBox59: TGroupBox;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    SpinEditWarrorAttackTime: TSpinEdit;
    SpinEditWizardAttackTime: TSpinEdit;
    SpinEditTaoistAttackTime: TSpinEdit;
    ButtonHeroExpSave: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    SpinEditNeedLevel: TSpinEdit;
    ComboBoxBagItemCount: TComboBox;
    TabSheet2: TTabSheet;
    GroupBox67: TGroupBox;
    CheckBoxKillByMonstDropUseItem: TCheckBox;
    CheckBoxKillByHumanDropUseItem: TCheckBox;
    CheckBoxDieScatterBag: TCheckBox;
    CheckBoxDieRedScatterBagAll: TCheckBox;
    GroupBox69: TGroupBox;
    Label130: TLabel;
    Label2: TLabel;
    Label134: TLabel;
    ScrollBarDieDropUseItemRate: TScrollBar;
    EditDieDropUseItemRate: TEdit;
    ScrollBarDieRedDropUseItemRate: TScrollBar;
    EditDieRedDropUseItemRate: TEdit;
    ScrollBarDieScatterBagRate: TScrollBar;
    EditDieScatterBagRate: TEdit;
    ButtonHeroDieSave: TButton;
    GroupBox2: TGroupBox;
    Label124: TLabel;
    Label125: TLabel;
    SpinEditEatHPItemRate: TSpinEdit;
    SpinEditEatMPItemRate: TSpinEdit;
    TabSheet3: TTabSheet;
    ButtonHeroAttackSave: TButton;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    EditHeroRecallTick: TSpinEdit;
    GroupBox5: TGroupBox;
    Label10: TLabel;
    EditWinExp: TSpinEdit;
    Label11: TLabel;
    EditExpAddLoyal: TSpinEdit;
    Label12: TLabel;
    EditDeathDecLoyal: TSpinEdit;
    GroupBox6: TGroupBox;
    Label14: TLabel;
    EditGotoLV4: TSpinEdit;
    Label15: TLabel;
    EditPowerLv4: TSpinEdit;
    PageControl1: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditMaxFirDragonPoint: TSpinEdit;
    EditAddFirDragonPoint: TSpinEdit;
    EditDecFirDragonPoint: TSpinEdit;
    GroupBox9: TGroupBox;
    Label17: TLabel;
    EditHeroAttackRate_61: TSpinEdit;
    GroupBox10: TGroupBox;
    Label18: TLabel;
    EditHeroAttackRate_62: TSpinEdit;
    GroupBox11: TGroupBox;
    Label19: TLabel;
    EditHeroAttackRate_63: TSpinEdit;
    GroupBox12: TGroupBox;
    Label20: TLabel;
    EditHeroAttackRate_64: TSpinEdit;
    GroupBox13: TGroupBox;
    Label21: TLabel;
    EditHeroAttackRate_65: TSpinEdit;
    GroupBox52: TGroupBox;
    Label135: TLabel;
    EditHeroAttackRate_60: TSpinEdit;
    GroupBox15: TGroupBox;
    Label16: TLabel;
    EditHeroAttackRange_65: TSpinEdit;
    GroupBox7: TGroupBox;
    Label22: TLabel;
    EditHeroAttackRange_63: TSpinEdit;
    GroupBox14: TGroupBox;
    Label27: TLabel;
    Label29: TLabel;
    EditHeroWalkIntervalTime: TSpinEdit;
    EditHeroTurnIntervalTime: TSpinEdit;
    Label28: TLabel;
    EditPKDecLoyal: TSpinEdit;
    Label30: TLabel;
    EditGuildIncLoyal: TSpinEdit;
    Label31: TLabel;
    EditLevelOrderIncLoyal: TSpinEdit;
    Label32: TLabel;
    EditLevelOrderDecLoyal: TSpinEdit;
    Label33: TLabel;
    SpinEdit1: TSpinEdit;
    GroupBox16: TGroupBox;
    Label26: TLabel;
    EditHeroRunIntervalTime: TSpinEdit;
    Label25: TLabel;
    EditHeroRunIntervalTime1: TSpinEdit;
    Label34: TLabel;
    EditHeroRunIntervalTime2: TSpinEdit;
    GroupBox17: TGroupBox;
    LabelHeroNameColor: TLabel;
    EditHeroNameColor: TSpinEdit;
    Label65: TLabel;
    Label24: TLabel;
    Label35: TLabel;
    CheckNameSuffix: TCheckBox;
    EdtHeroName: TEdit;
    EditHeroNameSuffix: TEdit;
    GroupBox18: TGroupBox;
    Label36: TLabel;
    EditHeroAttackRange_60: TSpinEdit;
    GroupBox46: TGroupBox;
    Label89: TLabel;
    Label90: TLabel;
    EditMakeGhostHeroTime: TSpinEdit;
    Label38: TLabel;
    EditDrinkHeroStartLevel: TSpinEdit;
    EditHeroMagicHitIntervalTime: TSpinEdit;
    Label39: TLabel;
    Label40: TLabel;
    SpinEditEatItemTick: TSpinEdit;
    CheckBoxHeroProtect: TCheckBox;
    TabSheet11: TTabSheet;
    PageControl2: TPageControl;
    TabSheet12: TTabSheet;
    GroupBox19: TGroupBox;
    ButtonHeroSkillSave: TButton;
    RadioHeroSkillMode: TRadioButton;
    RadioHeroSkillModeAll: TRadioButton;
    CheckBoxHeroDieExp: TCheckBox;
    SpinEditHeroDieExpRate: TSpinEdit;
    Label41: TLabel;
    Label42: TLabel;
    SpinEditIncDragonPointTick: TSpinEdit;
    TabSheet13: TTabSheet;
    GroupBox20: TGroupBox;
    CheckBoxHeroNoTargetCall: TCheckBox;
    GroupBox21: TGroupBox;
    Label43: TLabel;
    SpinEditDecDragonHitPoint: TSpinEdit;
    Label44: TLabel;
    TabSheet14: TTabSheet;
    GroupBox22: TGroupBox;
    CheckBoxHeroAutoProtectionDefence: TCheckBox;
    GroupBox23: TGroupBox;
    Label45: TLabel;
    EditNoEditKillMonExpRate: TSpinEdit;
    GroupBox24: TGroupBox;
    Label46: TLabel;
    Label47: TLabel;
    EditDecDragonRate: TSpinEdit;
    TabSheet15: TTabSheet;
    GroupBox25: TGroupBox;
    RadioHeroSkillMode50: TRadioButton;
    RadioHeroSkillMode50All: TRadioButton;
    TabSheet16: TTabSheet;
    GroupBox26: TGroupBox;
    Label48: TLabel;
    SpinEditHeroSkill46MaxHP_0: TSpinEdit;
    Label3: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    SpinEditEatItemTick1: TSpinEdit;
    SpinEditEatHPItemRate1: TSpinEdit;
    Label53: TLabel;
    Label54: TLabel;
    SpinEditEatMPItemRate1: TSpinEdit;
    GroupBox28: TGroupBox;
    RadioHeroSkillMode_63ALL: TRadioButton;
    RadioHeroSkillMode_63: TRadioButton;
    GroupBox27: TGroupBox;
    RadioHeroSkillMode46: TRadioButton;
    RadioHeroSkillMode46All: TRadioButton;
    CheckBoxHeroRestNoFollow: TCheckBox;
    GroupBox30: TGroupBox;
    Label9: TLabel;
    EditHeroAttackRange_64: TSpinEdit;
    GroupBox79: TGroupBox;
    Label159: TLabel;
    Label160: TLabel;
    SpinEditHeroMakeSelfTick: TSpinEdit;
    Label13: TLabel;
    SpinEditHeroSkill46MaxHP_1: TSpinEdit;
    Label49: TLabel;
    SpinEditHeroSkill46MaxHP_2: TSpinEdit;
    Label55: TLabel;
    Label56: TLabel;
    SpinEditHeroSkill46MaxHP_3: TSpinEdit;
    CheckBoxHeroAttackTarget: TCheckBox;
    Label57: TLabel;
    SpinEditHeroHPRate: TSpinEdit;
    TabSheet17: TTabSheet;
    GroupBox31: TGroupBox;
    RadioHeroSkillMode43: TRadioButton;
    RadioHeroSkillMode43All: TRadioButton;
    CheckBoxHeroAttackTao: TCheckBox;
    procedure ComboBoxLevelExpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonHeroExpSaveClick(Sender: TObject);
    procedure EditStartLevelChange(Sender: TObject);
    procedure EditKillMonExpRateChange(Sender: TObject);
    procedure ComboBoxBagItemCountChange(Sender: TObject);
    procedure SpinEditNeedLevelChange(Sender: TObject);
    procedure SpinEditWarrorAttackTimeChange(Sender: TObject);
    procedure SpinEditWizardAttackTimeChange(Sender: TObject);
    procedure SpinEditTaoistAttackTimeChange(Sender: TObject);
    procedure ButtonHeroDieSaveClick(Sender: TObject);
    procedure CheckBoxKillByMonstDropUseItemClick(Sender: TObject);
    procedure CheckBoxKillByHumanDropUseItemClick(Sender: TObject);
    procedure CheckBoxDieScatterBagClick(Sender: TObject);
    procedure CheckBoxDieRedScatterBagAllClick(Sender: TObject);
    procedure ScrollBarDieDropUseItemRateChange(Sender: TObject);
    procedure ScrollBarDieRedDropUseItemRateChange(Sender: TObject);
    procedure ScrollBarDieScatterBagRateChange(Sender: TObject);
    procedure SpinEditEatHPItemRateChange(Sender: TObject);
    procedure SpinEditEatMPItemRateChange(Sender: TObject);
    procedure ButtonHeroAttackSaveClick(Sender: TObject);
    procedure EditMaxFirDragonPointChange(Sender: TObject);
    procedure EditAddFirDragonPointChange(Sender: TObject);
    procedure EditDecFirDragonPointChange(Sender: TObject);
    procedure EditHeroAttackRate_60Change(Sender: TObject);
    procedure EditHeroRecallTickChange(Sender: TObject);
    procedure EditDeathDecLoyalChange(Sender: TObject);
    procedure EditWinExpChange(Sender: TObject);
    procedure EditExpAddLoyalChange(Sender: TObject);
    procedure EditGotoLV4Change(Sender: TObject);
    procedure EditPowerLv4Change(Sender: TObject);
    procedure EditHeroAttackRate_61Change(Sender: TObject);
    procedure EditHeroAttackRate_62Change(Sender: TObject);
    procedure EditHeroAttackRate_63Change(Sender: TObject);
    procedure EditHeroAttackRate_64Change(Sender: TObject);
    procedure EditHeroAttackRate_65Change(Sender: TObject);
    procedure EditHeroAttackRange_65Change(Sender: TObject);
    procedure EditHeroAttackRange_63Change(Sender: TObject);
    procedure EditHeroRunIntervalTimeChange(Sender: TObject);
    procedure EditHeroWalkIntervalTimeChange(Sender: TObject);
    procedure EditHeroTurnIntervalTimeChange(Sender: TObject);
    procedure EditPKDecLoyalChange(Sender: TObject);
    procedure EditGuildIncLoyalChange(Sender: TObject);
    procedure EditLevelOrderIncLoyalChange(Sender: TObject);
    procedure EditLevelOrderDecLoyalChange(Sender: TObject);
    procedure EditHeroRunIntervalTime1Change(Sender: TObject);
    procedure EditHeroRunIntervalTime2Change(Sender: TObject);
    procedure EditHeroNameColorChange(Sender: TObject);
    procedure CheckNameSuffixClick(Sender: TObject);
    procedure EdtHeroNameChange(Sender: TObject);
    procedure EditHeroNameSuffixChange(Sender: TObject);
    procedure EditHeroAttackRange_60Change(Sender: TObject);
    procedure EditMakeGhostHeroTimeChange(Sender: TObject);
    procedure EditDrinkHeroStartLevelChange(Sender: TObject);
    procedure EditHeroMagicHitIntervalTimeChange(Sender: TObject);
    procedure SpinEditEatItemTickChange(Sender: TObject);
    procedure CheckBoxHeroProtectClick(Sender: TObject);
    procedure ButtonHeroSkillSaveClick(Sender: TObject);
    procedure RadioHeroSkillModeClick(Sender: TObject);
    procedure RadioHeroSkillModeAllClick(Sender: TObject);
    procedure CheckBoxHeroDieExpClick(Sender: TObject);
    procedure SpinEditHeroDieExpRateChange(Sender: TObject);
    procedure SpinEditIncDragonPointTickChange(Sender: TObject);
    procedure CheckBoxHeroNoTargetCallClick(Sender: TObject);
    procedure SpinEditDecDragonHitPointChange(Sender: TObject);
    procedure GridLevelExpSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure CheckBoxHeroAutoProtectionDefenceClick(Sender: TObject);
    procedure EditNoEditKillMonExpRateChange(Sender: TObject);
    procedure EditDecDragonRateChange(Sender: TObject);
    procedure RadioHeroSkillMode50Click(Sender: TObject);
    procedure RadioHeroSkillMode50AllClick(Sender: TObject);
    procedure SpinEditHeroSkill46MaxHP_0Change(Sender: TObject);
    procedure SpinEditEatItemTick1Change(Sender: TObject);
    procedure SpinEditEatHPItemRate1Change(Sender: TObject);
    procedure SpinEditEatMPItemRate1Change(Sender: TObject);
    procedure RadioHeroSkillMode_63Click(Sender: TObject);
    procedure RadioHeroSkillMode_63ALLClick(Sender: TObject);
    procedure RadioHeroSkillMode46Click(Sender: TObject);
    procedure RadioHeroSkillMode46AllClick(Sender: TObject);
    procedure CheckBoxHeroRestNoFollowClick(Sender: TObject);
    procedure EditHeroAttackRange_64Change(Sender: TObject);
    procedure SpinEditHeroMakeSelfTickChange(Sender: TObject);
    procedure SpinEditHeroSkill46MaxHP_1Change(Sender: TObject);
    procedure SpinEditHeroSkill46MaxHP_2Change(Sender: TObject);
    procedure SpinEditHeroSkill46MaxHP_3Change(Sender: TObject);
    procedure CheckBoxHeroAttackTargetClick(Sender: TObject);
    procedure SpinEditHeroHPRateChange(Sender: TObject);
    procedure RadioHeroSkillMode43Click(Sender: TObject);
    procedure RadioHeroSkillMode43AllClick(Sender: TObject);
    procedure CheckBoxHeroAttackTaoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
  public
    { Public declarations }
    procedure Open();
  end;

var
  frmHeroConfig: TfrmHeroConfig;

implementation
uses M2Share, HUtil32;
{$R *.dfm}

procedure TfrmHeroConfig.ModValue();
begin
  boModValued := True;
  ButtonHeroExpSave.Enabled := True;
  ButtonHeroDieSave.Enabled := True;
  ButtonHeroAttackSave.Enabled := True;
  ButtonHeroSkillSave.Enabled := True;
end;

procedure TfrmHeroConfig.uModValue();
begin
  boModValued := False;
  ButtonHeroExpSave.Enabled := False;
  ButtonHeroDieSave.Enabled := False;
  ButtonHeroAttackSave.Enabled := False;
  ButtonHeroSkillSave.Enabled := False;
end;

procedure TfrmHeroConfig.ComboBoxLevelExpClick(Sender: TObject);
var
  I: Integer;
  LevelExpScheme: TLevelExpScheme;
  dwOneLevelExp: LongWord;
  dwExp: LongWord;
begin
  if not boOpened then Exit;
  if Application.MessageBox('��������ƻ����õľ��齫������Ч���Ƿ�ȷ��ʹ�ô˾���ƻ���', 'ȷ����Ϣ', MB_YESNO + MB_ICONQUESTION) = IDNO then begin
    Exit;
  end;

  LevelExpScheme := TLevelExpScheme(ComboBoxLevelExp.Items.Objects[ComboBoxLevelExp.ItemIndex]);
  case LevelExpScheme of
    s_OldLevelExp: g_Config.dwHeroNeedExps := g_dwOldNeedExps;
    s_StdLevelExp: begin
        g_Config.dwHeroNeedExps := g_dwOldNeedExps;
        dwOneLevelExp := 4000000000 div High(g_Config.dwHeroNeedExps);
        for I := 1 to MAXCHANGELEVEL do begin
          if (26 + I) > MAXCHANGELEVEL then Break;
          dwExp := dwOneLevelExp * LongWord(I);
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[26 + I] := dwExp;
        end;
      end;
    s_2Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 2;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_5Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 5;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_8Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 8;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_10Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 10;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_20Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 20;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_30Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 30;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_40Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 40;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_50Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 50;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_60Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 60;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_70Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 70;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_80Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 80;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_90Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 90;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_100Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 100;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_150Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 150;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_200Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 200;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_250Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 250;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_300Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 300;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
  end;
  for I := 1 to GridLevelExp.RowCount - 1 do begin
    GridLevelExp.Cells[1, I] := IntToStr(g_Config.dwHeroNeedExps[I]);
  end;
  ModValue();
end;

procedure TfrmHeroConfig.Open();
var
  I: Integer;
  s01: string;
begin
  boOpened := False;
  PageControl.ActivePageIndex := 0;
  uModValue();

  for I := 1 to GridLevelExp.RowCount - 1 do begin
    GridLevelExp.Cells[1, I] := IntToStr(g_Config.dwHeroNeedExps[I]);//20080708
  end;
  GroupBoxLevelExp.Caption := Format('��������(�����Ч�ȼ�%d)', [MAXUPLEVEL]);

  EditStartLevel.Value := g_Config.nHeroStartLevel;
  EditDrinkHeroStartLevel.Value := g_Config.nDrinkHeroStartLevel;//����Ӣ�ۿ�ʼ�ȼ� 20080514
  EditKillMonExpRate.Value := g_Config.nHeroKillMonExpRate;
  EditNoEditKillMonExpRate.Value := g_Config.nHeroNoKillMonExpRate;//20080803 ��ɱ�ַ��侭�����
  ComboBoxBagItemCount.Items.Clear;
  EditHeroRecallTick.Value:=g_Config.nRecallHeroTime div 1000;//�ٻ�Ӣ�ۼ�� 20071201
  EditMakeGhostHeroTime.Value := g_Config.nMakeGhostHeroTime div 1000;//Ӣ��ʬ������ʱ�� 20080418
  SpinEditHeroHPRate.Value := g_Config.nHeroHPRate;//Ӣ��HPΪ����ı��� 20081219
  EditDeathDecLoyal.Value:=g_Config.nDeathDecLoyal;//���������ҳǶ� 20080110
  EditPKDecLoyal.Value:= g_Config.nPKDecLoyal;//PKֵ�����ҳ϶� 20080214
  EditGuildIncLoyal.Value:= g_Config.nGuildIncLoyal;//�л�ս�����ҳ϶� 20080214
  EditLevelOrderIncLoyal.Value:= g_Config.nLevelOrderIncLoyal;//����ȼ��������������ҳ϶� 20080214
  EditLevelOrderDecLoyal.Value:= g_Config.nLevelOrderDecLoyal;//����ȼ������½������ҳ϶� 20080214
  EditWinExp.Value:=g_Config.nWinExp;//��þ��� 20080110
  EditExpAddLoyal.Value:=g_Config.nExpAddLoyal;//������ҳ� 20080110
  EditGotoLV4.Value:=g_Config.nGotoLV4;//�ļ����� 20080110
  EditPowerLv4.Value:=g_Config.nPowerLV4;//�ļ�����ɱ��������ֵ 20080112
  //EditHeroRunIntervalTime.Value := g_Config.dwHeroRunIntervalTime;//սӢ���ܲ���� 20080213
  //EditHeroRunIntervalTime1.Value := g_Config.dwHeroRunIntervalTime1;//��Ӣ���ܲ���� 20080217
  //EditHeroRunIntervalTime2.Value := g_Config.dwHeroRunIntervalTime2;//��Ӣ���ܲ���� 20080217
  EditHeroWalkIntervalTime.Value := g_Config.dwHeroWalkIntervalTime;//Ӣ����·��� 20080213
  EditHeroTurnIntervalTime.Value := g_Config.dwHeroTurnIntervalTime;//Ӣ��ת���� 20080213
  EditHeroMagicHitIntervalTime.Value := g_Config.dwHeroMagicHitIntervalTime;//Ӣ��ħ����� 20080524

  if not g_Config.btHeroSkillMode then begin //Ӣ��ʩ����ʹ��ģʽ 20080604
    RadioHeroSkillMode.Checked := True;
    RadioHeroSkillModeAll.Checked := False;
  end else begin
    RadioHeroSkillMode.Checked := False;
    RadioHeroSkillModeAll.Checked := True;
  end;

  if not g_Config.btHeroSkillMode50 then begin //Ӣ���޼�����ʹ��ģʽ 20080604
    RadioHeroSkillMode50.Checked := True;
    RadioHeroSkillMode50All.Checked := False;
  end else begin
    RadioHeroSkillMode50.Checked := False;
    RadioHeroSkillMode50All.Checked := True;
  end;

  if not g_Config.btHeroSkillMode46 then begin //Ӣ�۷�����ʹ��ģʽ 20081029
    RadioHeroSkillMode46.Checked := True;
    RadioHeroSkillMode46All.Checked := False;
  end else begin
    RadioHeroSkillMode46.Checked := False;
    RadioHeroSkillMode46All.Checked := True;
  end;

  if not g_Config.btHeroSkillMode43 then begin //Ӣ�ۿ���ն�ػ�ģʽ 20081221
    RadioHeroSkillMode43.Checked := True;
    RadioHeroSkillMode43All.Checked := False;
  end else begin
    RadioHeroSkillMode43.Checked := False;
    RadioHeroSkillMode43All.Checked := True;
  end;

  if not g_Config.btHeroSkillMode_63 then begin //�ɻ�����ʹ���̶�ģʽ 20080911
    RadioHeroSkillMode_63.Checked := True;
    RadioHeroSkillMode_63All.Checked := False;
  end else begin
    RadioHeroSkillMode_63.Checked := False;
    RadioHeroSkillMode_63All.Checked := True;
  end;

  for I := Low(g_Config.nHeroBagItemCount) to High(g_Config.nHeroBagItemCount) do begin
    case I of
      0: s01 := '10��';
      1: s01 := '20��';
      2: s01 := '30��';
      3: s01 := '35��';
      4: s01 := '40��';
    end;
    ComboBoxBagItemCount.Items.AddObject(s01, TObject(g_Config.nHeroBagItemCount[I]));
  end;

  SpinEditWarrorAttackTime.Value := g_Config.dwHeroWarrorAttackTime;
  SpinEditWizardAttackTime.Value := g_Config.dwHeroWizardAttackTime;
  SpinEditTaoistAttackTime.Value := g_Config.dwHeroTaoistAttackTime;

  CheckBoxKillByMonstDropUseItem.Checked := g_Config.boHeroKillByMonstDropUseItem;
  CheckBoxKillByHumanDropUseItem.Checked := g_Config.boHeroKillByHumanDropUseItem;
  CheckBoxDieScatterBag.Checked := g_Config.boHeroDieScatterBag;
  CheckBoxDieRedScatterBagAll.Checked := g_Config.boHeroDieRedScatterBagAll;
  CheckBoxHeroDieExp.Checked := g_Config.boHeroDieExp;//Ӣ������������ 20080605
  CheckBoxHeroNoTargetCall.Checked := g_Config.boHeroNoTargetCall;//Ӣ����Ŀ���¿��ٻ����� 20080615
  CheckBoxHeroAutoProtectionDefence.Checked := g_Config.boHeroAutoProtectionDefence;//Ӣ����Ŀ�����Զ������������ 20080715
  if g_Config.boHeroDieExp then
     SpinEditHeroDieExpRate.Enabled:= True
  else  SpinEditHeroDieExpRate.Enabled:= False;
  SpinEditHeroDieExpRate.Value := g_Config.nHeroDieExpRate;//Ӣ��������������� 20080605

  ScrollBarDieDropUseItemRate.Min := 1;
  ScrollBarDieDropUseItemRate.Max := 200;
  ScrollBarDieDropUseItemRate.Position := g_Config.nHeroDieDropUseItemRate;
  ScrollBarDieRedDropUseItemRate.Min := 1;
  ScrollBarDieRedDropUseItemRate.Max := 200;
  ScrollBarDieRedDropUseItemRate.Position := g_Config.nHeroDieRedDropUseItemRate;
  ScrollBarDieScatterBagRate.Min := 1;
  ScrollBarDieScatterBagRate.Max := 200;
  ScrollBarDieScatterBagRate.Position := g_Config.nHeroDieScatterBagRate;

  SpinEditEatHPItemRate.Value := g_Config.nHeroAddHPRate;
  SpinEditEatMPItemRate.Value := g_Config.nHeroAddMPRate;
  SpinEditEatItemTick.Value := g_Config.nHeroAddHPMPTick;//Ӣ�۳���ͨҩ�ٶ� 20080601
  SpinEditEatHPItemRate1.Value := g_Config.nHeroAddHPRate1;
  SpinEditEatMPItemRate1.Value := g_Config.nHeroAddMPRate1;
  SpinEditEatItemTick1.Value := g_Config.nHeroAddHPMPTick1;//������ҩ�ٶ� 20080910

  ComboBoxBagItemCount.ItemIndex := -1;
  ComboBoxBagItemCount.Text := 'ѡ�������';
  SpinEditNeedLevel.Value := 1;
  SpinEditNeedLevel.Enabled := False;
  EditMaxFirDragonPoint.Value := g_Config.nMaxFirDragonPoint;
  EditAddFirDragonPoint.Value := g_Config.nAddFirDragonPoint;
  EditDecFirDragonPoint.Value := g_Config.nDecFirDragonPoint;
  SpinEditIncDragonPointTick.Value := g_Config.nIncDragonPointTick;//��ŭ��ʱ���� 20080606
  SpinEditHeroSkill46MaxHP_0.Value := g_Config.nHeroSkill46MaxHP_0;//Ӣ���ٻ�����HP�ı��� 20080907
  SpinEditHeroSkill46MaxHP_1.Value := g_Config.nHeroSkill46MaxHP_1;//1�� Ӣ���ٻ�����HP�ı��� 20081217
  SpinEditHeroSkill46MaxHP_2.Value := g_Config.nHeroSkill46MaxHP_2;//2�� Ӣ���ٻ�����HP�ı��� 20081217
  SpinEditHeroSkill46MaxHP_3.Value := g_Config.nHeroSkill46MaxHP_3;//3�� Ӣ���ٻ�����HP�ı��� 20081217
  SpinEditHeroMakeSelfTick.Value := g_Config.nHeroMakeSelfTick;//Ӣ�۷����ӳ�ʹ��ʱ�� 20081217
  SpinEditDecDragonHitPoint.Value := g_Config.nDecDragonHitPoint;//���Ƽ��ٺϻ��˺� 20080626
  EditDecDragonRate.Value := g_Config.nDecDragonRate;//�ϻ���������˺����� 20080803
  EditHeroAttackRate_60.Value := g_Config.nHeroAttackRate_60;//�ƻ�ն���� 20080131
  EditHeroAttackRange_60.Value:= g_Config.nHeroAttackRange_60;//�ƻ�ն ������Χ 20080406
  EditHeroAttackRate_61.Value := g_Config.nHeroAttackRate_61;//����ն���� 20080131
  EditHeroAttackRate_62.Value := g_Config.nHeroAttackRate_62;//����һ������ 20080131
  EditHeroAttackRate_63.Value := g_Config.nHeroAttackRate_63;//�ɻ��������� 20080131
  EditHeroAttackRange_63.Value:= g_Config.nHeroAttackRange_63;//�ɻ����� ������Χ 20080131
  EditHeroAttackRate_64.Value := g_Config.nHeroAttackRate_64;//ĩ���������� 20080131
  EditHeroAttackRate_65.Value := g_Config.nHeroAttackRate_65;//������������ 20080131
  EditHeroAttackRange_64.Value:= g_Config.nHeroAttackRange_64;//ĩ������  ������Χ 20081216
  EditHeroAttackRange_65.Value:= g_Config.nHeroAttackRange_65;//�������� ������Χ 20080131
  EditHeroNameColor.Value := g_Config.nHeroNameColor;//Ӣ��������ɫ 20080315
  EdtHeroName.Text:= g_Config.sHeroName ;//Ӣ������ 20080315
  EditHeroNameSuffix.Text := g_Config.sHeroNameSuffix ;//Ӣ������׺  20080315
  CheckNameSuffix.Checked := g_Config.boNameSuffix; //�Ƿ���ʾ��׺  20080315
  CheckBoxHeroProtect.Checked := g_Config.boNoSafeProtect;//��ֹ��ȫ���ػ� 20080603
  CheckBoxHeroRestNoFollow.Checked := g_Config.boRestNoFollow;//Ӣ����Ϣ�����������л���ͼ 20081209
  CheckBoxHeroAttackTarget.Checked := g_Config.boHeroAttackTarget;//����22ǰ�Ƿ������� 20081218
  CheckBoxHeroAttackTao.Checked := g_Config.boHeroAttackTao;//��22���Ƿ������� 20090108
  boOpened := True;
  ShowModal;
end;

procedure TfrmHeroConfig.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  GridLevelExp.ColWidths[0] := 30;
  GridLevelExp.ColWidths[1] := 100;
  GridLevelExp.Cells[0, 0] := '�ȼ�';
  GridLevelExp.Cells[1, 0] := '����ֵ';
  for I := 1 to GridLevelExp.RowCount - 1 do begin
    GridLevelExp.Cells[0, I] := IntToStr(I);
  end;

  ComboBoxLevelExp.AddItem('ԭʼ����ֵ', TObject(s_OldLevelExp));
  ComboBoxLevelExp.AddItem('��׼����ֵ', TObject(s_StdLevelExp));
  ComboBoxLevelExp.AddItem('��ǰ1/2������', TObject(s_2Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/5������', TObject(s_5Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/8������', TObject(s_8Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/10������', TObject(s_10Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/20������', TObject(s_20Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/30������', TObject(s_30Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/40������', TObject(s_40Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/50������', TObject(s_50Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/60������', TObject(s_60Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/70������', TObject(s_70Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/80������', TObject(s_80Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/90������', TObject(s_90Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/100������', TObject(s_100Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/150������', TObject(s_150Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/200������', TObject(s_200Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/250������', TObject(s_250Mult));
  ComboBoxLevelExp.AddItem('��ǰ1/300������', TObject(s_300Mult));
end;

procedure TfrmHeroConfig.ButtonHeroExpSaveClick(Sender: TObject);
var
  I: Integer;
  dwExp: LongWord;
  NeedExps: TLevelNeedExp;
begin
  for I := 1 to GridLevelExp.RowCount - 1 do begin
    dwExp := Str_ToInt(GridLevelExp.Cells[1, I], 0);
    if (dwExp <= 0) {or (dwExp > High(LongWord))} then begin//20080522
      Application.MessageBox(PChar('�ȼ� ' + IntToStr(I) + ' �����������ô��󣡣���'), '������Ϣ', MB_OK + MB_ICONERROR);
      GridLevelExp.Row := I;
      GridLevelExp.SetFocus;
      Exit;
    end;
    NeedExps[I] := dwExp;
  end;
  g_Config.dwHeroNeedExps := NeedExps;
  for I := 1 to 1000 do begin
    Config.WriteString('HeroExp', 'Level' + IntToStr(I), IntToStr(g_Config.dwHeroNeedExps[I]));
  end;
  Config.WriteInteger('HeroSetup', 'StartLevel', g_Config.nHeroStartLevel);
  Config.WriteInteger('HeroSetup', 'DrinkHeroStartLevel', g_Config.nDrinkHeroStartLevel);//����Ӣ�ۿ�ʼ�ȼ� 20080514
  Config.WriteInteger('HeroSetup', 'KillMonExpRate', g_Config.nHeroKillMonExpRate);
  Config.WriteInteger('HeroSetup', 'NoKillMonExpRate', g_Config.nHeroNoKillMonExpRate);//20080803 ��ɱ�ַ��侭�����

  for I := Low(g_Config.nHeroBagItemCount) to High(g_Config.nHeroBagItemCount) do begin
    Config.WriteInteger('HeroSetup', 'BagItemCount' + IntToStr(I), g_Config.nHeroBagItemCount[I]);
  end;

  Config.WriteInteger('HeroSetup', 'WarrorAttackTime', g_Config.dwHeroWarrorAttackTime);
  Config.WriteInteger('HeroSetup', 'WizardAttackTime', g_Config.dwHeroWizardAttackTime);
  Config.WriteInteger('HeroSetup', 'TaoistAttackTime', g_Config.dwHeroTaoistAttackTime);
  Config.WriteInteger('HeroSetup', 'HeroAddHPRate', g_Config.nHeroAddHPRate);
  Config.WriteInteger('HeroSetup', 'HeroAddMPRate', g_Config.nHeroAddMPRate);
  Config.WriteInteger('HeroSetup', 'HeroAddHPMPTick', g_Config.nHeroAddHPMPTick);//Ӣ�۳���ͨҩ�ٶ� 20080601
  Config.WriteInteger('HeroSetup', 'HeroAddHPRate1', g_Config.nHeroAddHPRate1);
  Config.WriteInteger('HeroSetup', 'HeroAddMPRate1', g_Config.nHeroAddMPRate1);
  Config.WriteInteger('HeroSetup', 'HeroAddHPMPTick1', g_Config.nHeroAddHPMPTick1);//������ҩ�ٶ� 20080910
  
  Config.WriteInteger('HeroSetup', 'RecallHeroTime', g_Config.nRecallHeroTime); //�ٻ�Ӣ�ۼ�� 20071201
  Config.WriteInteger('HeroSetup', 'HeroHPRate', g_Config.nHeroHPRate);//Ӣ��HPΪ����ı��� 20081219
  Config.WriteInteger('HeroSetup', 'DeathDecLoyal', g_Config.nDeathDecLoyal); //���������ҳǶ� 20080110
  Config.WriteInteger('HeroSetup', 'PKDecLoyal', g_Config.nPKDecLoyal); //PKֵ�����ҳ϶� 20080214
  Config.WriteInteger('HeroSetup', 'GuildIncLoyal', g_Config.nGuildIncLoyal);//�л�ս�����ҳ϶� 20080214
  Config.WriteInteger('HeroSetup', 'LevelOrderIncLoyal', g_Config.nLevelOrderIncLoyal);//����ȼ��������������ҳ϶� 20080214
  Config.WriteInteger('HeroSetup', 'LevelOrderDecLoyal', g_Config.nLevelOrderDecLoyal);//����ȼ������½������ҳ϶� 20080214
  Config.WriteInteger('HeroSetup', 'WinExp', g_Config.nWinExp); //��þ��� 20080110
  Config.WriteInteger('HeroSetup', 'ExpAddLoyal', g_Config.nExpAddLoyal); //������ҳ� 20080110
  Config.WriteInteger('HeroSetup', 'GotoLV4', g_Config.nGotoLV4); //�ļ����� 20080110
  Config.WriteInteger('HeroSetup', 'PowerLV4', g_Config.nPowerLV4); //�ļ�����ɱ��������ֵ 20080112
 // Config.WriteInteger('HeroSetup', 'HeroRunIntervalTime', g_Config.dwHeroRunIntervalTime); //սӢ���ܲ���� 20080213
 // Config.WriteInteger('HeroSetup', 'HeroRunIntervalTime1', g_Config.dwHeroRunIntervalTime1); //��Ӣ���ܲ���� 20080217
 // Config.WriteInteger('HeroSetup', 'HeroRunIntervalTime2', g_Config.dwHeroRunIntervalTime2); //��Ӣ���ܲ���� 20080217
  Config.WriteInteger('HeroSetup', 'HeroWalkIntervalTime', g_Config.dwHeroWalkIntervalTime);//Ӣ����·��� 20080213
  Config.WriteInteger('HeroSetup', 'HeroTurnIntervalTime', g_Config.dwHeroTurnIntervalTime); //Ӣ��ת���� 20080213
  Config.WriteInteger('HeroSetup', 'HeroMagicHitIntervalTime', g_Config.dwHeroMagicHitIntervalTime);//Ӣ��ħ����� 20080524
  Config.WriteInteger('HeroSetup', 'nHeroNameColor', g_Config.nHeroNameColor);//Ӣ��������ɫ 20080315
  Config.WriteString('HeroSetup', 'sHeroName', g_Config.sHeroName);//Ӣ������ 20080315
  Config.WriteString('HeroSetup', 'sHeroNameSuffix', g_Config.sHeroNameSuffix);//Ӣ������׺  20080315
  Config.WriteBool('HeroSetup', 'boNameSuffix', g_Config.boNameSuffix);//�Ƿ���ʾ��׺  20080315
  Config.WriteBool('HeroSetup', 'boNoSafeProtect', g_Config.boNoSafeProtect);//��ֹ��ȫ���ػ� 20080603
  Config.WriteBool('HeroSetup', 'boRestNoFollow', g_Config.boRestNoFollow);//Ӣ����Ϣ�����������л���ͼ 20081209
  Config.WriteBool('HeroSetup', 'boHeroAttackTarget', g_Config.boHeroAttackTarget);//����22ǰ�Ƿ������� 20081218
  Config.WriteBool('HeroSetup', 'boHeroAttackTao', g_Config.boHeroAttackTao);//��22���Ƿ������� 20090108
  uModValue();
end;

procedure TfrmHeroConfig.EditStartLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroStartLevel := EditStartLevel.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditKillMonExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroKillMonExpRate := EditKillMonExpRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.ComboBoxBagItemCountChange(Sender: TObject);
begin
  SpinEditNeedLevel.Value := Integer(ComboBoxBagItemCount.Items.Objects[ComboBoxBagItemCount.ItemIndex]);
  SpinEditNeedLevel.Enabled := True;
end;

procedure TfrmHeroConfig.SpinEditNeedLevelChange(Sender: TObject);
  procedure RefBagcount;
  var
    I: Integer;
  begin
    for I := 0 to ComboBoxBagItemCount.Items.Count - 1 do begin
      g_Config.nHeroBagItemCount[I] := Integer(ComboBoxBagItemCount.Items.Objects[I]);
    end;
  end;
begin
  if not boOpened then Exit;
  ComboBoxBagItemCount.Items.Objects[ComboBoxBagItemCount.ItemIndex] := TObject(SpinEditNeedLevel.Value);
  RefBagcount;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditWarrorAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroWarrorAttackTime := SpinEditWarrorAttackTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditWizardAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroWizardAttackTime := SpinEditWizardAttackTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditTaoistAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroTaoistAttackTime := SpinEditTaoistAttackTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.ButtonHeroDieSaveClick(Sender: TObject);
begin
  Config.WriteBool('HeroSetup', 'KillByMonstDropUseItem', g_Config.boHeroKillByMonstDropUseItem);
  Config.WriteBool('HeroSetup', 'KillByHumanDropUseItem', g_Config.boHeroKillByHumanDropUseItem);
  Config.WriteBool('HeroSetup', 'DieScatterBag', g_Config.boHeroDieScatterBag);
  Config.WriteBool('HeroSetup', 'DieRedScatterBagAll', g_Config.boHeroDieRedScatterBagAll);
  Config.WriteInteger('HeroSetup', 'DieDropUseItemRate', g_Config.nHeroDieDropUseItemRate);
  Config.WriteInteger('HeroSetup', 'DieRedDropUseItemRate', g_Config.nHeroDieRedDropUseItemRate);
  Config.WriteInteger('HeroSetup', 'DieScatterBagRate', g_Config.nHeroDieScatterBagRate);
  Config.WriteInteger('HeroSetup', 'MakeGhostHeroTime', g_Config.nMakeGhostHeroTime);//Ӣ��ʬ������ʱ�� 20080418
  Config.WriteBool('HeroSetup', 'HeroDieExp', g_Config.boHeroDieExp);//Ӣ������������ 20080605
  Config.WriteInteger('HeroSetup', 'HeroDieExpRate', g_Config.nHeroDieExpRate);//Ӣ��������������� 20080605
  uModValue();
end;

procedure TfrmHeroConfig.CheckBoxKillByMonstDropUseItemClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroKillByMonstDropUseItem := CheckBoxKillByMonstDropUseItem.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxKillByHumanDropUseItemClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroKillByHumanDropUseItem := CheckBoxKillByHumanDropUseItem.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxDieScatterBagClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroDieScatterBag := CheckBoxDieScatterBag.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxDieRedScatterBagAllClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroDieRedScatterBagAll := CheckBoxDieRedScatterBagAll.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.ScrollBarDieDropUseItemRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarDieDropUseItemRate.Position;
  EditDieDropUseItemRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nHeroDieDropUseItemRate := nPostion;
  ModValue();
end;

procedure TfrmHeroConfig.ScrollBarDieRedDropUseItemRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarDieRedDropUseItemRate.Position;
  EditDieRedDropUseItemRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nHeroDieRedDropUseItemRate := nPostion;
  ModValue();
end;

procedure TfrmHeroConfig.ScrollBarDieScatterBagRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarDieScatterBagRate.Position;
  EditDieScatterBagRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nHeroDieScatterBagRate := nPostion;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatHPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPRate := SpinEditEatHPItemRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatMPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddMPRate := SpinEditEatMPItemRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.ButtonHeroAttackSaveClick(Sender: TObject);
begin
  Config.WriteInteger('HeroSetup', 'MaxFirDragonPoint', g_Config.nMaxFirDragonPoint);
  Config.WriteInteger('HeroSetup', 'AddFirDragonPoint', g_Config.nAddFirDragonPoint);
  Config.WriteInteger('HeroSetup', 'DecFirDragonPoint', g_Config.nDecFirDragonPoint);
  Config.WriteInteger('HeroSetup', 'IncDragonPointTick', g_Config.nIncDragonPointTick);//��ŭ��ʱ���� 20080606
  Config.WriteInteger('HeroSetup', 'DecDragonHitPoint', g_Config.nDecDragonHitPoint);//���Ƽ��ٺϻ��˺� 20080626
  Config.WriteInteger('HeroSetup', 'DecDragonRate', g_Config.nDecDragonRate);//�ϻ���������˺����� 20080803
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_60', g_Config.nHeroAttackRate_60);//�ƻ�ն���� 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRange_60', g_Config.nHeroAttackRange_60);//�ƻ�ն������Χ 20080406
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_61', g_Config.nHeroAttackRate_61);//����ն���� 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_62', g_Config.nHeroAttackRate_62);//����һ������ 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_63', g_Config.nHeroAttackRate_63);//�ɻ��������� 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRange_63', g_Config.nHeroAttackRange_63);//�ɻ����� ������Χ 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_64', g_Config.nHeroAttackRate_64);//ĩ���������� 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRange_64', g_Config.nHeroAttackRange_64);//ĩ������  ������Χ 20081216
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_65', g_Config.nHeroAttackRate_65);//������������ 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRange_65', g_Config.nHeroAttackRange_65);//�������� ������Χ 20080131
  Config.WriteBool('HeroSetup', 'HeroSkillMode_63', g_Config.btHeroSkillMode_63);//�ɻ�����ʹ���̶�ģʽ 20080911
  uModValue();
end;

procedure TfrmHeroConfig.EditMaxFirDragonPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMaxFirDragonPoint := EditMaxFirDragonPoint.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditAddFirDragonPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAddFirDragonPoint := EditAddFirDragonPoint.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditDecFirDragonPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecFirDragonPoint := EditDecFirDragonPoint.Value;
  ModValue();
end;

//�ƻ�ն�ϻ��������� 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_60Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_60 := EditHeroAttackRate_60.Value;
  ModValue();
end;

//�ٻ�Ӣ�ۼ�� 20071201
procedure TfrmHeroConfig.EditHeroRecallTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRecallHeroTime := EditHeroRecallTick.Value* 1000;
  ModValue();
end;

//���������ҳǶ� 20080110
procedure TfrmHeroConfig.EditDeathDecLoyalChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDeathDecLoyal := EditDeathDecLoyal.Value;
  ModValue();
end;
//PKֵ�����ҳ϶� 20080214
procedure TfrmHeroConfig.EditPKDecLoyalChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPKDecLoyal := EditPKDecLoyal.Value;
  ModValue();
end;
//�л�ս�����ҳ϶� 20080214
procedure TfrmHeroConfig.EditGuildIncLoyalChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nGuildIncLoyal := EditGuildIncLoyal.Value;
  ModValue();
end;
//����ȼ��������������ҳ϶� 20080214
procedure TfrmHeroConfig.EditLevelOrderIncLoyalChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nLevelOrderIncLoyal := EditLevelOrderIncLoyal.Value;
  ModValue();
end;
//����ȼ������½������ҳ϶� 20080214
procedure TfrmHeroConfig.EditLevelOrderDecLoyalChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nLevelOrderDecLoyal := EditLevelOrderDecLoyal.Value;
  ModValue();
end;
//��þ���  20080110
procedure TfrmHeroConfig.EditWinExpChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWinExp := EditWinExp.Value;
  ModValue();
end;
//������ҳ�  20080110
procedure TfrmHeroConfig.EditExpAddLoyalChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nExpAddLoyal := EditExpAddLoyal.Value;
  ModValue();
end;
//�ļ�����   20080110
procedure TfrmHeroConfig.EditGotoLV4Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nGotoLV4 := EditGotoLV4.Value;
  ModValue();
end;
//�ļ�����ɱ��������ֵ 20080112
procedure TfrmHeroConfig.EditPowerLv4Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPowerLV4 := EditPowerLv4.Value;
  ModValue();
end;

//սӢ���ܲ���� 20080213
procedure TfrmHeroConfig.EditHeroRunIntervalTimeChange(Sender: TObject);
begin
{  if not boOpened then Exit;
  g_Config.dwHeroRunIntervalTime := EditHeroRunIntervalTime.Value;
  ModValue();  }
end;
//��Ӣ���ܲ���� 20080217
procedure TfrmHeroConfig.EditHeroRunIntervalTime1Change(Sender: TObject);
begin
{  if not boOpened then Exit;
  g_Config.dwHeroRunIntervalTime1 := EditHeroRunIntervalTime1.Value;
  ModValue();  }
end;
//��Ӣ���ܲ���� 20080217
procedure TfrmHeroConfig.EditHeroRunIntervalTime2Change(Sender: TObject);
begin
 { if not boOpened then Exit;
  g_Config.dwHeroRunIntervalTime2 := EditHeroRunIntervalTime2.Value;
  ModValue(); }
end;
//Ӣ����·��� 20080213
procedure TfrmHeroConfig.EditHeroWalkIntervalTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroWalkIntervalTime := EditHeroWalkIntervalTime.Value;
  ModValue();
end;
//Ӣ��ת���� 20080213
procedure TfrmHeroConfig.EditHeroTurnIntervalTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroTurnIntervalTime := EditHeroTurnIntervalTime.Value;
  ModValue();
end;
//����ն���� 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_61Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_61 := EditHeroAttackRate_61.Value;
  ModValue();
end;
//����һ������ 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_62Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_62 := EditHeroAttackRate_62.Value;
  ModValue();
end;
//�ɻ��������� 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_63Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_63 := EditHeroAttackRate_63.Value;
  ModValue();
end;
//ĩ���������� 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_64Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_64 := EditHeroAttackRate_64.Value;
  ModValue();
end;
//������������ 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_65Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_65 := EditHeroAttackRate_65.Value;
  ModValue();
end;
//�������� ������Χ 20080131
procedure TfrmHeroConfig.EditHeroAttackRange_65Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRange_65 := EditHeroAttackRange_65.Value;
  ModValue();
end;
//�ɻ����� ������Χ 20080131
procedure TfrmHeroConfig.EditHeroAttackRange_63Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRange_63 := EditHeroAttackRange_63.Value;
  ModValue();
end;
//Ӣ��������ɫ 20080315
procedure TfrmHeroConfig.EditHeroNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditHeroNameColor.Value;
  LabelHeroNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.nHeroNameColor := btColor;
  ModValue();
end;

//�Ƿ���ʾ��׺  20080315
procedure TfrmHeroConfig.CheckNameSuffixClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNameSuffix := CheckNameSuffix.Checked;
  ModValue();
end;

//Ӣ������ 20080315
procedure TfrmHeroConfig.EdtHeroNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sHeroName := EdtHeroName.Text;
  ModValue();
end;

//Ӣ������׺  20080315
procedure TfrmHeroConfig.EditHeroNameSuffixChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sHeroNameSuffix := EditHeroNameSuffix.Text;
  ModValue();
end;
//�ƻ�ն ������Χ 20080406
procedure TfrmHeroConfig.EditHeroAttackRange_60Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRange_60 := EditHeroAttackRange_60.Value;
  ModValue();
end;
//Ӣ��ʬ������ʱ�� 20080418
procedure TfrmHeroConfig.EditMakeGhostHeroTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeGhostHeroTime := EditMakeGhostHeroTime.Value * 1000;
  ModValue();
end;

procedure TfrmHeroConfig.EditDrinkHeroStartLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDrinkHeroStartLevel := EditDrinkHeroStartLevel.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditHeroMagicHitIntervalTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroMagicHitIntervalTime := EditHeroMagicHitIntervalTime.Value;
  ModValue();
end;
//Ӣ�۳���ͨҩ�ٶ� 20080601
procedure TfrmHeroConfig.SpinEditEatItemTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPMPTick := SpinEditEatItemTick.Value;
  ModValue();
end;
//��ֹ��ȫ���ػ� 20080603
procedure TfrmHeroConfig.CheckBoxHeroProtectClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNoSafeProtect := CheckBoxHeroProtect.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.ButtonHeroSkillSaveClick(Sender: TObject);
begin
  Config.WriteInteger('HeroSetup', 'HeroSkill46MaxHP_0', g_Config.nHeroSkill46MaxHP_0);//Ӣ���ٻ�����HP�ı��� 20080907
  Config.WriteInteger('HeroSetup', 'HeroSkill46MaxHP_1', g_Config.nHeroSkill46MaxHP_1);//1�� Ӣ���ٻ�����HP�ı��� 20081217
  Config.WriteInteger('HeroSetup', 'HeroSkill46MaxHP_2', g_Config.nHeroSkill46MaxHP_2);//2�� Ӣ���ٻ�����HP�ı��� 20081217
  Config.WriteInteger('HeroSetup', 'HeroSkill46MaxHP_3', g_Config.nHeroSkill46MaxHP_3);//3�� Ӣ���ٻ�����HP�ı��� 20081217
  Config.WriteInteger('HeroSetup', 'HeroMakeSelfTick', g_Config.nHeroMakeSelfTick);//Ӣ�۷����ӳ�ʹ��ʱ�� 20081217
  Config.WriteBool('HeroSetup', 'HeroSkillMode', g_Config.btHeroSkillMode); //Ӣ��ʩ����ʹ��ģʽ 20080604
  Config.WriteBool('HeroSetup', 'HeroNoTargetCall', g_Config.boHeroNoTargetCall);//Ӣ����Ŀ���¿��ٻ����� 20080615
  Config.WriteBool('HeroSetup', 'HeroAutoProtectionDefence', g_Config.boHeroAutoProtectionDefence);//Ӣ����Ŀ�����Զ������������ 20080715
  Config.WriteBool('HeroSetup', 'HeroSkillMode50', g_Config.btHeroSkillMode50);//Ӣ���޼�����ʹ��ģʽ 20080827
  Config.WriteBool('HeroSetup', 'HeroSkillMode46', g_Config.btHeroSkillMode46);//Ӣ�۷�����ģʽ 20081029
  Config.WriteBool('HeroSetup', 'HeroSkillMode43', g_Config.btHeroSkillMode43);//Ӣ�ۿ���ն�ػ�ģʽ 20081221
  uModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillModeClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode := False;
  end else begin
    g_Config.btHeroSkillMode := True;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillModeAllClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillModeAll.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode := True;
  end else begin
    g_Config.btHeroSkillMode := False;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxHeroDieExpClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroDieExp := CheckBoxHeroDieExp.Checked;
  if g_Config.boHeroDieExp then SpinEditHeroDieExpRate.Enabled:= True
  else  SpinEditHeroDieExpRate.Enabled:= False;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditHeroDieExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroDieExpRate := SpinEditHeroDieExpRate.Value ;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditIncDragonPointTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nIncDragonPointTick := SpinEditIncDragonPointTick.Value;
  ModValue();
end;
//Ӣ����Ŀ���¿��ٻ����� 20080615
procedure TfrmHeroConfig.CheckBoxHeroNoTargetCallClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroNoTargetCall := CheckBoxHeroNoTargetCall.Checked;
  ModValue();
end;
//���Ƽ��ٺϻ��˺� 20080626
procedure TfrmHeroConfig.SpinEditDecDragonHitPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecDragonHitPoint := SpinEditDecDragonHitPoint.Value;
  ModValue();
end;
//20080708
procedure TfrmHeroConfig.GridLevelExpSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if not boOpened then Exit;
  ModValue();
end;

//Ӣ����Ŀ�����Զ������������ 20080715
procedure TfrmHeroConfig.CheckBoxHeroAutoProtectionDefenceClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroAutoProtectionDefence := CheckBoxHeroAutoProtectionDefence.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.EditNoEditKillMonExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroNoKillMonExpRate := EditNoEditKillMonExpRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditDecDragonRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecDragonRate := EditDecDragonRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode50Click(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode50.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode50 := False;
  end else begin
    g_Config.btHeroSkillMode50 := True;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode50AllClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode50All.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode50 := True;
  end else begin
    g_Config.btHeroSkillMode50 := False;
  end;
  ModValue();
end;
//Ӣ���ٻ�����HP�ı��� 20080907
procedure TfrmHeroConfig.SpinEditHeroSkill46MaxHP_0Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill46MaxHP_0 := SpinEditHeroSkill46MaxHP_0.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatItemTick1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPMPTick1 := SpinEditEatItemTick1.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatHPItemRate1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPRate1 := SpinEditEatHPItemRate1.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatMPItemRate1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddMPRate1 := SpinEditEatMPItemRate1.Value;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode_63Click(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode_63.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode_63 := False;
  end else begin
    g_Config.btHeroSkillMode_63 := True;
  end;
  ModValue();

end;

procedure TfrmHeroConfig.RadioHeroSkillMode_63ALLClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode_63ALL.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode_63 := True;
  end else begin
    g_Config.btHeroSkillMode_63 := False;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode46Click(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode46.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode46 := False;
  end else begin
    g_Config.btHeroSkillMode46 := True;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode46AllClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode46All.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode46 := True;
  end else begin
    g_Config.btHeroSkillMode46 := False;
  end;
  ModValue();
end;

//Ӣ����Ϣ�����������л���ͼ 20081209
procedure TfrmHeroConfig.CheckBoxHeroRestNoFollowClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boRestNoFollow := CheckBoxHeroRestNoFollow.Checked;
  ModValue();
end;

//ĩ������  ������Χ 20081216
procedure TfrmHeroConfig.EditHeroAttackRange_64Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRange_64 := EditHeroAttackRange_64.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditHeroMakeSelfTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroMakeSelfTick := SpinEditHeroMakeSelfTick.Value;
  ModValue();
end;
//1�� Ӣ���ٻ�����HP�ı��� 20081217
procedure TfrmHeroConfig.SpinEditHeroSkill46MaxHP_1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill46MaxHP_1 := SpinEditHeroSkill46MaxHP_1.Value;
  ModValue();
end;
//2�� Ӣ���ٻ�����HP�ı��� 20081217
procedure TfrmHeroConfig.SpinEditHeroSkill46MaxHP_2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill46MaxHP_2 := SpinEditHeroSkill46MaxHP_2.Value;
  ModValue();
end;
//3�� Ӣ���ٻ�����HP�ı��� 20081217
procedure TfrmHeroConfig.SpinEditHeroSkill46MaxHP_3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill46MaxHP_3 := SpinEditHeroSkill46MaxHP_3.Value;
  ModValue();
end;

//����22ǰ�Ƿ������� 20081218
procedure TfrmHeroConfig.CheckBoxHeroAttackTargetClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroAttackTarget := CheckBoxHeroAttackTarget.Checked;
  ModValue();
end;
//Ӣ��HPΪ����ı��� 20081219
procedure TfrmHeroConfig.SpinEditHeroHPRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroHPRate := SpinEditHeroHPRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode43Click(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode43.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode43 := False;
  end else begin
    g_Config.btHeroSkillMode43 := True;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode43AllClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode43All.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode43 := True;
  end else begin
    g_Config.btHeroSkillMode43 := False;
  end;
  ModValue();
end;
//��22���Ƿ������� 20090108
procedure TfrmHeroConfig.CheckBoxHeroAttackTaoClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroAttackTao := CheckBoxHeroAttackTao.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.FormDestroy(Sender: TObject);
begin
  frmHeroConfig:= nil;
end;

procedure TfrmHeroConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

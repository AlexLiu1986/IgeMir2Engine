unit FunctionConfig;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  ComCtrls, StdCtrls, Spin, Grids, Grobal2;

type
  TfrmFunctionConfig = class(TForm)
    FunctionConfigControl: TPageControl;
    Label14: TLabel;
    MonSaySheet: TTabSheet;
    TabSheet1: TTabSheet;
    PasswordSheet: TTabSheet;
    GroupBox1: TGroupBox;
    CheckBoxEnablePasswordLock: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBoxLockGetBackItem: TCheckBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    EditErrorPasswordCount: TSpinEdit;
    CheckBoxErrorCountKick: TCheckBox;
    ButtonPasswordLockSave: TButton;
    GroupBox4: TGroupBox;
    CheckBoxLockWalk: TCheckBox;
    CheckBoxLockRun: TCheckBox;
    CheckBoxLockHit: TCheckBox;
    CheckBoxLockSpell: TCheckBox;
    CheckBoxLockSendMsg: TCheckBox;
    CheckBoxLockInObMode: TCheckBox;
    CheckBoxLockLogin: TCheckBox;
    CheckBoxLockUseItem: TCheckBox;
    CheckBoxLockDropItem: TCheckBox;
    CheckBoxLockDealItem: TCheckBox;
    MagicPageControl: TPageControl;
    TabSheetGeneral: TTabSheet;
    GroupBox7: TGroupBox;
    CheckBoxHungerSystem: TCheckBox;
    ButtonGeneralSave: TButton;
    GroupBoxHunger: TGroupBox;
    CheckBoxHungerDecPower: TCheckBox;
    CheckBoxHungerDecHP: TCheckBox;
    ButtonSkillSave: TButton;
    TabSheet32: TTabSheet;
    TabSheet33: TTabSheet;
    TabSheet34: TTabSheet;
    TabSheet35: TTabSheet;
    TabSheet36: TTabSheet;
    GroupBox17: TGroupBox;
    Label12: TLabel;
    EditMagicAttackRage: TSpinEdit;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    EditUpgradeWeaponMaxPoint: TSpinEdit;
    Label15: TLabel;
    EditUpgradeWeaponPrice: TSpinEdit;
    Label16: TLabel;
    EditUPgradeWeaponGetBackTime: TSpinEdit;
    Label17: TLabel;
    EditClearExpireUpgradeWeaponDays: TSpinEdit;
    Label18: TLabel;
    Label19: TLabel;
    GroupBox18: TGroupBox;
    ScrollBarUpgradeWeaponDCRate: TScrollBar;
    Label20: TLabel;
    EditUpgradeWeaponDCRate: TEdit;
    Label21: TLabel;
    ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar;
    EditUpgradeWeaponDCTwoPointRate: TEdit;
    Label22: TLabel;
    ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar;
    EditUpgradeWeaponDCThreePointRate: TEdit;
    GroupBox19: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    ScrollBarUpgradeWeaponSCRate: TScrollBar;
    EditUpgradeWeaponSCRate: TEdit;
    ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar;
    EditUpgradeWeaponSCTwoPointRate: TEdit;
    ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar;
    EditUpgradeWeaponSCThreePointRate: TEdit;
    GroupBox20: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    ScrollBarUpgradeWeaponMCRate: TScrollBar;
    EditUpgradeWeaponMCRate: TEdit;
    ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar;
    EditUpgradeWeaponMCTwoPointRate: TEdit;
    ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar;
    EditUpgradeWeaponMCThreePointRate: TEdit;
    ButtonUpgradeWeaponSave: TButton;
    GroupBox21: TGroupBox;
    ButtonMasterSave: TButton;
    GroupBox22: TGroupBox;
    EditMasterOKLevel: TSpinEdit;
    Label29: TLabel;
    GroupBox23: TGroupBox;
    EditMasterOKCreditPoint: TSpinEdit;
    Label30: TLabel;
    EditMasterOKBonusPoint: TSpinEdit;
    Label31: TLabel;
    GroupBox24: TGroupBox;
    ScrollBarMakeMineHitRate: TScrollBar;
    EditMakeMineHitRate: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    ScrollBarMakeMineRate: TScrollBar;
    EditMakeMineRate: TEdit;
    GroupBox25: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    ScrollBarStoneTypeRate: TScrollBar;
    EditStoneTypeRate: TEdit;
    ScrollBarGoldStoneMax: TScrollBar;
    EditGoldStoneMax: TEdit;
    Label36: TLabel;
    ScrollBarSilverStoneMax: TScrollBar;
    EditSilverStoneMax: TEdit;
    Label37: TLabel;
    ScrollBarSteelStoneMax: TScrollBar;
    EditSteelStoneMax: TEdit;
    Label38: TLabel;
    EditBlackStoneMax: TEdit;
    ScrollBarBlackStoneMax: TScrollBar;
    ButtonMakeMineSave: TButton;
    GroupBox26: TGroupBox;
    Label39: TLabel;
    EditStoneMinDura: TSpinEdit;
    Label40: TLabel;
    EditStoneGeneralDuraRate: TSpinEdit;
    Label41: TLabel;
    EditStoneAddDuraRate: TSpinEdit;
    Label42: TLabel;
    EditStoneAddDuraMax: TSpinEdit;
    TabSheet37: TTabSheet;
    GroupBox27: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    ScrollBarWinLottery1Max: TScrollBar;
    EditWinLottery1Max: TEdit;
    ScrollBarWinLottery2Max: TScrollBar;
    EditWinLottery2Max: TEdit;
    ScrollBarWinLottery3Max: TScrollBar;
    EditWinLottery3Max: TEdit;
    ScrollBarWinLottery4Max: TScrollBar;
    EditWinLottery4Max: TEdit;
    EditWinLottery5Max: TEdit;
    ScrollBarWinLottery5Max: TScrollBar;
    Label48: TLabel;
    ScrollBarWinLottery6Max: TScrollBar;
    EditWinLottery6Max: TEdit;
    EditWinLotteryRate: TEdit;
    ScrollBarWinLotteryRate: TScrollBar;
    Label49: TLabel;
    GroupBox28: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    EditWinLottery1Gold: TSpinEdit;
    EditWinLottery2Gold: TSpinEdit;
    EditWinLottery3Gold: TSpinEdit;
    EditWinLottery4Gold: TSpinEdit;
    Label54: TLabel;
    EditWinLottery5Gold: TSpinEdit;
    Label55: TLabel;
    EditWinLottery6Gold: TSpinEdit;
    ButtonWinLotterySave: TButton;
    TabSheet38: TTabSheet;
    GroupBox29: TGroupBox;
    Label56: TLabel;
    EditReNewNameColor1: TSpinEdit;
    LabelReNewNameColor1: TLabel;
    Label58: TLabel;
    EditReNewNameColor2: TSpinEdit;
    LabelReNewNameColor2: TLabel;
    Label60: TLabel;
    EditReNewNameColor3: TSpinEdit;
    LabelReNewNameColor3: TLabel;
    Label62: TLabel;
    EditReNewNameColor4: TSpinEdit;
    LabelReNewNameColor4: TLabel;
    Label64: TLabel;
    EditReNewNameColor5: TSpinEdit;
    LabelReNewNameColor5: TLabel;
    Label66: TLabel;
    EditReNewNameColor6: TSpinEdit;
    LabelReNewNameColor6: TLabel;
    Label68: TLabel;
    EditReNewNameColor7: TSpinEdit;
    LabelReNewNameColor7: TLabel;
    Label70: TLabel;
    EditReNewNameColor8: TSpinEdit;
    LabelReNewNameColor8: TLabel;
    Label72: TLabel;
    EditReNewNameColor9: TSpinEdit;
    LabelReNewNameColor9: TLabel;
    Label74: TLabel;
    EditReNewNameColor10: TSpinEdit;
    LabelReNewNameColor10: TLabel;
    ButtonReNewLevelSave: TButton;
    GroupBox30: TGroupBox;
    Label57: TLabel;
    EditReNewNameColorTime: TSpinEdit;
    Label59: TLabel;
    TabSheet39: TTabSheet;
    ButtonMonUpgradeSave: TButton;
    GroupBox32: TGroupBox;
    Label65: TLabel;
    LabelMonUpgradeColor1: TLabel;
    Label67: TLabel;
    LabelMonUpgradeColor2: TLabel;
    Label69: TLabel;
    LabelMonUpgradeColor3: TLabel;
    Label71: TLabel;
    LabelMonUpgradeColor4: TLabel;
    Label73: TLabel;
    LabelMonUpgradeColor5: TLabel;
    Label75: TLabel;
    LabelMonUpgradeColor6: TLabel;
    Label76: TLabel;
    LabelMonUpgradeColor7: TLabel;
    Label77: TLabel;
    LabelMonUpgradeColor8: TLabel;
    EditMonUpgradeColor1: TSpinEdit;
    EditMonUpgradeColor2: TSpinEdit;
    EditMonUpgradeColor3: TSpinEdit;
    EditMonUpgradeColor4: TSpinEdit;
    EditMonUpgradeColor5: TSpinEdit;
    EditMonUpgradeColor6: TSpinEdit;
    EditMonUpgradeColor7: TSpinEdit;
    EditMonUpgradeColor8: TSpinEdit;
    GroupBox31: TGroupBox;
    Label61: TLabel;
    Label63: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    EditMonUpgradeKillCount1: TSpinEdit;
    EditMonUpgradeKillCount2: TSpinEdit;
    EditMonUpgradeKillCount3: TSpinEdit;
    EditMonUpgradeKillCount4: TSpinEdit;
    EditMonUpgradeKillCount5: TSpinEdit;
    EditMonUpgradeKillCount6: TSpinEdit;
    EditMonUpgradeKillCount7: TSpinEdit;
    EditMonUpLvNeedKillBase: TSpinEdit;
    EditMonUpLvRate: TSpinEdit;
    Label84: TLabel;
    CheckBoxReNewChangeColor: TCheckBox;
    GroupBox33: TGroupBox;
    CheckBoxReNewLevelClearExp: TCheckBox;
    GroupBox34: TGroupBox;
    Label85: TLabel;
    EditPKFlagNameColor: TSpinEdit;
    LabelPKFlagNameColor: TLabel;
    Label87: TLabel;
    EditPKLevel1NameColor: TSpinEdit;
    LabelPKLevel1NameColor: TLabel;
    Label89: TLabel;
    EditPKLevel2NameColor: TSpinEdit;
    LabelPKLevel2NameColor: TLabel;
    Label91: TLabel;
    EditAllyAndGuildNameColor: TSpinEdit;
    LabelAllyAndGuildNameColor: TLabel;
    Label93: TLabel;
    EditWarGuildNameColor: TSpinEdit;
    LabelWarGuildNameColor: TLabel;
    Label95: TLabel;
    EditInFreePKAreaNameColor: TSpinEdit;
    LabelInFreePKAreaNameColor: TLabel;
    TabSheet40: TTabSheet;
    Label86: TLabel;
    EditMonUpgradeColor9: TSpinEdit;
    LabelMonUpgradeColor9: TLabel;
    GroupBox35: TGroupBox;
    CheckBoxMasterDieMutiny: TCheckBox;
    Label88: TLabel;
    EditMasterDieMutinyRate: TSpinEdit;
    Label90: TLabel;
    EditMasterDieMutinyPower: TSpinEdit;
    Label92: TLabel;
    EditMasterDieMutinySpeed: TSpinEdit;
    GroupBox36: TGroupBox;
    Label94: TLabel;
    Label96: TLabel;
    CheckBoxSpiritMutiny: TCheckBox;
    EditSpiritMutinyTime: TSpinEdit;
    EditSpiritPowerRate: TSpinEdit;
    ButtonSpiritMutinySave: TButton;
    GroupBox40: TGroupBox;
    CheckBoxMonSayMsg: TCheckBox;
    ButtonMonSayMsgSave: TButton;
    ButtonUpgradeWeaponDefaulf: TButton;
    ButtonMakeMineDefault: TButton;
    ButtonWinLotteryDefault: TButton;
    TabSheet42: TTabSheet;
    GroupBox44: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    ScrollBarWeaponMakeUnLuckRate: TScrollBar;
    EditWeaponMakeUnLuckRate: TEdit;
    ScrollBarWeaponMakeLuckPoint1: TScrollBar;
    EditWeaponMakeLuckPoint1: TEdit;
    ScrollBarWeaponMakeLuckPoint2: TScrollBar;
    EditWeaponMakeLuckPoint2: TEdit;
    ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar;
    EditWeaponMakeLuckPoint2Rate: TEdit;
    EditWeaponMakeLuckPoint3: TEdit;
    ScrollBarWeaponMakeLuckPoint3: TScrollBar;
    Label110: TLabel;
    ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar;
    EditWeaponMakeLuckPoint3Rate: TEdit;
    ButtonWeaponMakeLuckDefault: TButton;
    ButtonWeaponMakeLuckSave: TButton;
    GroupBox47: TGroupBox;
    Label112: TLabel;
    CheckBoxBBMonAutoChangeColor: TCheckBox;
    EditBBMonAutoChangeColorTime: TSpinEdit;
    TabSheet44: TTabSheet;
    GroupBox49: TGroupBox;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    SpinEditSellOffCount: TSpinEdit;
    SpinEditSellOffTax: TSpinEdit;
    ButtonSellOffSave: TButton;
    TabSheet50: TTabSheet;
    GroupBox55: TGroupBox;
    CheckBoxItemName: TCheckBox;
    Label118: TLabel;
    EditItemName: TEdit;
    ButtonChangeUseItemName: TButton;
    GroupBox62: TGroupBox;
    CheckBoxStartMapEvent: TCheckBox;
    GroupBox68: TGroupBox;
    Label158: TLabel;
    EdtDecUserGameGold: TSpinEdit;
    TabSheet8: TTabSheet;
    PageControl1: TPageControl;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    GroupBox9: TGroupBox;
    CheckBoxLimitSwordLong: TCheckBox;
    GroupBox10: TGroupBox;
    Label4: TLabel;
    Label10: TLabel;
    EditSwordLongPowerRate: TSpinEdit;
    GroupBox56: TGroupBox;
    Label119: TLabel;
    Label120: TLabel;
    SpinEditSkill39Sec: TSpinEdit;
    GroupBox57: TGroupBox;
    CheckBoxDedingAllowPK: TCheckBox;
    GroupBox52: TGroupBox;
    Label135: TLabel;
    SpinEditDidingPowerRate: TSpinEdit;
    TabSheet11: TTabSheet;
    PageControl2: TPageControl;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    GroupBox14: TGroupBox;
    Label8: TLabel;
    EditSnowWindRange: TSpinEdit;
    GroupBox13: TGroupBox;
    Label7: TLabel;
    EditFireBoomRage: TSpinEdit;
    TabSheet14: TTabSheet;
    GroupBox63: TGroupBox;
    CheckBoxFireChgMapExtinguish: TCheckBox;
    GroupBox53: TGroupBox;
    Label117: TLabel;
    Label116: TLabel;
    SpinEditFireDelayTime: TSpinEdit;
    SpinEditFirePower: TSpinEdit;
    GroupBox46: TGroupBox;
    CheckBoxFireCrossInSafeZone: TCheckBox;
    TabSheet15: TTabSheet;
    GroupBox37: TGroupBox;
    Label97: TLabel;
    EditMagTurnUndeadLevel: TSpinEdit;
    TabSheet16: TTabSheet;
    GroupBox15: TGroupBox;
    Label9: TLabel;
    EditElecBlizzardRange: TSpinEdit;
    TabSheet17: TTabSheet;
    GroupBox38: TGroupBox;
    Label98: TLabel;
    EditMagTammingLevel: TSpinEdit;
    GroupBox45: TGroupBox;
    Label111: TLabel;
    EditTammingCount: TSpinEdit;
    GroupBox39: TGroupBox;
    Label99: TLabel;
    Label100: TLabel;
    EditMagTammingTargetLevel: TSpinEdit;
    EditMagTammingHPRate: TSpinEdit;
    TabSheet18: TTabSheet;
    GroupBox41: TGroupBox;
    Label101: TLabel;
    Label102: TLabel;
    EditMabMabeHitRandRate: TSpinEdit;
    EditMabMabeHitMinLvLimit: TSpinEdit;
    GroupBox43: TGroupBox;
    Label104: TLabel;
    EditMabMabeHitMabeTimeRate: TSpinEdit;
    GroupBox42: TGroupBox;
    Label103: TLabel;
    EditMabMabeHitSucessRate: TSpinEdit;
    TabSheet19: TTabSheet;
    GroupBox51: TGroupBox;
    CheckBoxPlayObjectReduceMP: TCheckBox;
    TabSheet20: TTabSheet;
    GroupBox59: TGroupBox;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    SpinEditWarrorAttackTime: TSpinEdit;
    SpinEditWizardAttackTime: TSpinEdit;
    SpinEditTaoistAttackTime: TSpinEdit;
    GroupBox61: TGroupBox;
    CheckBoxNeedLevelHighTarget: TCheckBox;
    CheckBoxAllowReCallMobOtherHum: TCheckBox;
    GroupBox73: TGroupBox;
    Label146: TLabel;
    Label147: TLabel;
    SpinEditnCopyHumanTick: TSpinEdit;
    GroupBox79: TGroupBox;
    Label159: TLabel;
    Label160: TLabel;
    SpinEditMakeSelfTick: TSpinEdit;
    TabSheet21: TTabSheet;
    GroupBox60: TGroupBox;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    EditBagItems1: TEdit;
    EditBagItems2: TEdit;
    EditBagItems3: TEdit;
    TabSheet22: TTabSheet;
    GroupBox58: TGroupBox;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label161: TLabel;
    LabelCopyHumNameColor: TLabel;
    SpinEditAllowCopyCount: TSpinEdit;
    EditCopyHumName: TEdit;
    CheckBoxMasterName: TCheckBox;
    SpinEditPickUpItemCount: TSpinEdit;
    SpinEditEatHPItemRate: TSpinEdit;
    SpinEditEatMPItemRate: TSpinEdit;
    CheckBoxAllowGuardAttack: TCheckBox;
    EditCopyHumNameColor: TSpinEdit;
    TabSheet23: TTabSheet;
    GroupBox48: TGroupBox;
    CheckBoxGroupMbAttackPlayObject: TCheckBox;
    GroupBox54: TGroupBox;
    CheckBoxGroupMbAttackSlave: TCheckBox;
    TabSheet24: TTabSheet;
    GroupBox50: TGroupBox;
    CheckBoxPullPlayObject: TCheckBox;
    CheckBoxPullCrossInSafeZone: TCheckBox;
    TabSheet25: TTabSheet;
    PageControl3: TPageControl;
    TabSheet26: TTabSheet;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EditBoneFammName: TEdit;
    EditBoneFammCount: TSpinEdit;
    GroupBox6: TGroupBox;
    GridBoneFamm: TStringGrid;
    TabSheet3: TTabSheet;
    GroupBox11: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EditDogzName: TEdit;
    EditDogzCount: TSpinEdit;
    GroupBox12: TGroupBox;
    GridDogz: TStringGrid;
    TabSheet4: TTabSheet;
    GroupBox16: TGroupBox;
    Label11: TLabel;
    EditAmyOunsulPoint: TSpinEdit;
    TabSheet6: TTabSheet;
    GroupBox80: TGroupBox;
    AutoCanHit: TCheckBox;
    TabSheet7: TTabSheet;
    GroupBox64: TGroupBox;
    Label134: TLabel;
    Label136: TLabel;
    FairyNameEdt: TEdit;
    SpinFairyEdt: TSpinEdit;
    GroupBox65: TGroupBox;
    GridFairy: TStringGrid;
    TabSheet27: TTabSheet;
    GroupBox71: TGroupBox;
    Label144: TLabel;
    Label145: TLabel;
    SpinEditKill43Sec: TSpinEdit;
    GroupBox74: TGroupBox;
    Label151: TLabel;
    Label152: TLabel;
    Spin43KillHitRateEdt: TSpinEdit;
    Spin43KillAttackRateEdt: TSpinEdit;
    GroupBox75: TGroupBox;
    Label153: TLabel;
    SpinEditAttackRate_43: TSpinEdit;
    TabSheet5: TTabSheet;
    GroupBox76: TGroupBox;
    Label154: TLabel;
    SpinEditAttackRate_42: TSpinEdit;
    GroupBox77: TGroupBox;
    Label155: TLabel;
    EditMagicAttackRage_42: TSpinEdit;
    TabSheet2: TTabSheet;
    PageControl4: TPageControl;
    TabSheet28: TTabSheet;
    GroupBox66: TGroupBox;
    Label139: TLabel;
    Label140: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    EditProtectionDefenceTime: TSpinEdit;
    EditProtectionTick: TSpinEdit;
    GroupBox67: TGroupBox;
    Label141: TLabel;
    Label142: TLabel;
    EditProtectionRate: TSpinEdit;
    GroupBox69: TGroupBox;
    Label143: TLabel;
    EditProtectionBadRate: TSpinEdit;
    GroupBox78: TGroupBox;
    ShowProtectionEnv: TCheckBox;
    AutoProtection: TCheckBox;
    GroupBox70: TGroupBox;
    CheckRushkungBad: TCheckBox;
    CheckErgumBad: TCheckBox;
    CheckFirehitBad: TCheckBox;
    CheckTwnhitBad: TCheckBox;
    TabSheet29: TTabSheet;
    GroupBox81: TGroupBox;
    Label162: TLabel;
    EditMeteorFireRainRage: TSpinEdit;
    TabSheet30: TTabSheet;
    GroupBox82: TGroupBox;
    Label163: TLabel;
    Label164: TLabel;
    EditMagFireCharmTreatment: TSpinEdit;
    TabSheet31: TTabSheet;
    GroupBox83: TGroupBox;
    Label165: TLabel;
    SpinEditAttackRate_74: TSpinEdit;
    CheckBoxLockCallHero: TCheckBox;
    GroupBox84: TGroupBox;
    Label166: TLabel;
    EditMasterCount: TSpinEdit;
    TabSheet41: TTabSheet;
    GroupBox85: TGroupBox;
    Label167: TLabel;
    Label168: TLabel;
    EditAbilityUpTick: TSpinEdit;
    GroupBox86: TGroupBox;
    Label169: TLabel;
    Label170: TLabel;
    SpinEditAbilityUpUseTime: TSpinEdit;
    TabSheet43: TTabSheet;
    GroupBox87: TGroupBox;
    Label172: TLabel;
    Label174: TLabel;
    SpinEditMagChangXY: TSpinEdit;
    GroupBox88: TGroupBox;
    Label171: TLabel;
    Label173: TLabel;
    SpinEditKill42Sec: TSpinEdit;
    TabSheet45: TTabSheet;
    GroupBox89: TGroupBox;
    Label175: TLabel;
    Label176: TLabel;
    SpinEditMakeWineTime: TSpinEdit;
    GroupBox90: TGroupBox;
    Label177: TLabel;
    SpinEditMakeWineRate: TSpinEdit;
    ButtonSaveMakeWine: TButton;
    Label178: TLabel;
    SpinEditMakeWineTime1: TSpinEdit;
    Label179: TLabel;
    GroupBox91: TGroupBox;
    Label180: TLabel;
    Label181: TLabel;
    Label182: TLabel;
    Label183: TLabel;
    SpinEditIncAlcoholTick: TSpinEdit;
    SpinEditDesDrinkTick: TSpinEdit;
    Label184: TLabel;
    SpinEditMaxAlcoholValue: TSpinEdit;
    Label185: TLabel;
    SpinEditIncAlcoholValue: TSpinEdit;
    GroupBox92: TGroupBox;
    GridMedicineExp: TStringGrid;
    Label186: TLabel;
    SpinEditDesMedicineValue: TSpinEdit;
    Label187: TLabel;
    SpinEditDesMedicineTick: TSpinEdit;
    Label188: TLabel;
    GroupBox93: TGroupBox;
    Label189: TLabel;
    SpinEditInFountainTime: TSpinEdit;
    Label190: TLabel;
    TabSheet46: TTabSheet;
    TabSheet47: TTabSheet;
    GroupBox94: TGroupBox;
    Label191: TLabel;
    Label192: TLabel;
    SpinEditHPUpTick: TSpinEdit;
    GroupBox95: TGroupBox;
    Label193: TLabel;
    Label194: TLabel;
    SpinEditHPUpUseTime: TSpinEdit;
    GroupBox96: TGroupBox;
    GridSkill68: TStringGrid;
    GroupBox97: TGroupBox;
    Label195: TLabel;
    SpinEditMinDrinkValue67: TSpinEdit;
    Label196: TLabel;
    GroupBox98: TGroupBox;
    Label197: TLabel;
    Label198: TLabel;
    SpinEditMinDrinkValue68: TSpinEdit;
    Label199: TLabel;
    SpinEditMinGuildFountain: TSpinEdit;
    Label200: TLabel;
    Label201: TLabel;
    SpinEditDecGuildFountain: TSpinEdit;
    GroupBox99: TGroupBox;
    Label202: TLabel;
    Label203: TLabel;
    SpinEditChallengeTime: TSpinEdit;
    GroupBox100: TGroupBox;
    CheckSlaveMoveMaster: TCheckBox;
    CheckBoxShowGuildName: TCheckBox;
    GroupBox101: TGroupBox;
    Label204: TLabel;
    Label205: TLabel;
    Label206: TLabel;
    Label207: TLabel;
    Label208: TLabel;
    Label209: TLabel;
    SpinEditStartHPRock: TSpinEdit;
    SpinEditRockAddHP: TSpinEdit;
    SpinEditHPRockDecDura: TSpinEdit;
    SpinEditHPRockSpell: TSpinEdit;
    GroupBox102: TGroupBox;
    Label210: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    Label213: TLabel;
    Label214: TLabel;
    Label215: TLabel;
    SpinEditStartMPRock: TSpinEdit;
    SpinEditRockAddMP: TSpinEdit;
    SpinEditMPRockDecDura: TSpinEdit;
    SpinEditMPRockSpell: TSpinEdit;
    GroupBox103: TGroupBox;
    Label216: TLabel;
    Label217: TLabel;
    Label218: TLabel;
    Label219: TLabel;
    Label220: TLabel;
    Label221: TLabel;
    SpinEditStartHPMPRock: TSpinEdit;
    SpinEditRockAddHPMP: TSpinEdit;
    SpinEditHPMPRockDecDura: TSpinEdit;
    SpinEditHPMPRockSpell: TSpinEdit;
    TabSheet48: TTabSheet;
    GroupBox104: TGroupBox;
    RadioboSkill31EffectFalse: TRadioButton;
    RadioboSkill31EffectTrue: TRadioButton;
    GroupBox105: TGroupBox;
    Label222: TLabel;
    SpinEditSkill66Rate: TSpinEdit;
    GroupBox106: TGroupBox;
    Label223: TLabel;
    Label224: TLabel;
    EditProtectionOKRate: TSpinEdit;
    TabSheet49: TTabSheet;
    PageControl5: TPageControl;
    TabSheet51: TTabSheet;
    GroupBox107: TGroupBox;
    Label225: TLabel;
    SpinEditSkill69NG: TSpinEdit;
    Label226: TLabel;
    SpinEditSkill69NGExp: TSpinEdit;
    Label227: TLabel;
    SpinEditHeroSkill69NGExp: TSpinEdit;
    GroupBox108: TGroupBox;
    Label228: TLabel;
    SpinEditdwIncNHTime: TSpinEdit;
    GroupBox109: TGroupBox;
    Label229: TLabel;
    SpinEditDrinkIncNHExp: TSpinEdit;
    Label230: TLabel;
    SpinEditHitStruckDecNH: TSpinEdit;
    CheckBoxAbilityUpFixMode: TCheckBox;
    SpinEditAbilityUpFixUseTime: TSpinEdit;
    Label231: TLabel;
    TabSheet52: TTabSheet;
    GroupBox110: TGroupBox;
    Label232: TLabel;
    SpinEditAttackRate_26: TSpinEdit;
    GroupBox111: TGroupBox;
    Label233: TLabel;
    EditKillMonNGExpMultiple: TSpinEdit;
    Label234: TLabel;
    SpinEditNPCNameColor: TSpinEdit;
    LabelNPCNameColor: TLabel;
    GroupBox112: TGroupBox;
    Label235: TLabel;
    SpinEditNGSkillRate: TSpinEdit;
    GroupBox113: TGroupBox;
    Label236: TLabel;
    SpinEditNGLevelDamage: TSpinEdit;
    GroupBox114: TGroupBox;
    Label237: TLabel;
    SpinEditOrdinarySkill66Rate: TSpinEdit;
    GroupBox115: TGroupBox;
    Label137: TLabel;
    SpinFairyDuntRateEdt: TSpinEdit;
    Label138: TLabel;
    SpinFairyAttackRateEdt: TSpinEdit;
    Label238: TLabel;
    SpinEditFairyDuntRateBelow: TSpinEdit;
    TabSheet53: TTabSheet;
    GroupBoxLevelExp: TGroupBox;
    GridExpCrystalLevelExp: TStringGrid;
    ButtonExpCrystalSave: TButton;
    GroupBox72: TGroupBox;
    Label148: TLabel;
    EditHeroCrystalExpRate: TSpinEdit;
    procedure CheckBoxEnablePasswordLockClick(Sender: TObject);
    procedure CheckBoxLockGetBackItemClick(Sender: TObject);
    procedure CheckBoxLockDealItemClick(Sender: TObject);
    procedure CheckBoxLockDropItemClick(Sender: TObject);
    procedure CheckBoxLockWalkClick(Sender: TObject);
    procedure CheckBoxLockRunClick(Sender: TObject);
    procedure CheckBoxLockHitClick(Sender: TObject);
    procedure CheckBoxLockSpellClick(Sender: TObject);
    procedure CheckBoxLockSendMsgClick(Sender: TObject);
    procedure CheckBoxLockInObModeClick(Sender: TObject);
    procedure EditErrorPasswordCountChange(Sender: TObject);
    procedure ButtonPasswordLockSaveClick(Sender: TObject);
    procedure CheckBoxErrorCountKickClick(Sender: TObject);
    procedure CheckBoxLockLoginClick(Sender: TObject);
    procedure CheckBoxLockUseItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxHungerSystemClick(Sender: TObject);
    procedure CheckBoxHungerDecHPClick(Sender: TObject);
    procedure CheckBoxHungerDecPowerClick(Sender: TObject);
    procedure ButtonGeneralSaveClick(Sender: TObject);
    procedure CheckBoxLimitSwordLongClick(Sender: TObject);
    procedure ButtonSkillSaveClick(Sender: TObject);
    procedure EditBoneFammNameChange(Sender: TObject);
    procedure EditBoneFammCountChange(Sender: TObject);
    procedure EditSwordLongPowerRateChange(Sender: TObject);
    procedure EditFireBoomRageChange(Sender: TObject);
    procedure EditSnowWindRangeChange(Sender: TObject);
    procedure EditElecBlizzardRangeChange(Sender: TObject);
    procedure EditDogzCountChange(Sender: TObject);
    procedure EditDogzNameChange(Sender: TObject);
    procedure GridBoneFammSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure EditAmyOunsulPointChange(Sender: TObject);
    procedure EditMagicAttackRageChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCThreePointRateChange(
      Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCThreePointRateChange(
      Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCThreePointRateChange(
      Sender: TObject);
    procedure EditUpgradeWeaponMaxPointChange(Sender: TObject);
    procedure EditUpgradeWeaponPriceChange(Sender: TObject);
    procedure EditUPgradeWeaponGetBackTimeChange(Sender: TObject);
    procedure EditClearExpireUpgradeWeaponDaysChange(Sender: TObject);
    procedure ButtonUpgradeWeaponSaveClick(Sender: TObject);
    procedure EditMasterOKLevelChange(Sender: TObject);
    procedure ButtonMasterSaveClick(Sender: TObject);
    procedure EditMasterOKCreditPointChange(Sender: TObject);
    procedure EditMasterOKBonusPointChange(Sender: TObject);
    procedure ScrollBarMakeMineHitRateChange(Sender: TObject);
    procedure ScrollBarMakeMineRateChange(Sender: TObject);
    procedure ScrollBarStoneTypeRateChange(Sender: TObject);
    procedure ScrollBarGoldStoneMaxChange(Sender: TObject);
    procedure ScrollBarSilverStoneMaxChange(Sender: TObject);
    procedure ScrollBarSteelStoneMaxChange(Sender: TObject);
    procedure ScrollBarBlackStoneMaxChange(Sender: TObject);
    procedure ButtonMakeMineSaveClick(Sender: TObject);
    procedure EditStoneMinDuraChange(Sender: TObject);
    procedure EditStoneGeneralDuraRateChange(Sender: TObject);
    procedure EditStoneAddDuraRateChange(Sender: TObject);
    procedure EditStoneAddDuraMaxChange(Sender: TObject);
    procedure ButtonWinLotterySaveClick(Sender: TObject);
    procedure EditWinLottery1GoldChange(Sender: TObject);
    procedure EditWinLottery2GoldChange(Sender: TObject);
    procedure EditWinLottery3GoldChange(Sender: TObject);
    procedure EditWinLottery4GoldChange(Sender: TObject);
    procedure EditWinLottery5GoldChange(Sender: TObject);
    procedure EditWinLottery6GoldChange(Sender: TObject);
    procedure ScrollBarWinLottery1MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery2MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery3MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery4MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery5MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery6MaxChange(Sender: TObject);
    procedure ScrollBarWinLotteryRateChange(Sender: TObject);
    procedure ButtonReNewLevelSaveClick(Sender: TObject);
    procedure EditReNewNameColor1Change(Sender: TObject);
    procedure EditReNewNameColor2Change(Sender: TObject);
    procedure EditReNewNameColor3Change(Sender: TObject);
    procedure EditReNewNameColor4Change(Sender: TObject);
    procedure EditReNewNameColor5Change(Sender: TObject);
    procedure EditReNewNameColor6Change(Sender: TObject);
    procedure EditReNewNameColor7Change(Sender: TObject);
    procedure EditReNewNameColor8Change(Sender: TObject);
    procedure EditReNewNameColor9Change(Sender: TObject);
    procedure EditReNewNameColor10Change(Sender: TObject);
    procedure EditReNewNameColorTimeChange(Sender: TObject);
    procedure FunctionConfigControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure ButtonMonUpgradeSaveClick(Sender: TObject);
    procedure EditMonUpgradeColor1Change(Sender: TObject);
    procedure EditMonUpgradeColor2Change(Sender: TObject);
    procedure EditMonUpgradeColor3Change(Sender: TObject);
    procedure EditMonUpgradeColor4Change(Sender: TObject);
    procedure EditMonUpgradeColor5Change(Sender: TObject);
    procedure EditMonUpgradeColor6Change(Sender: TObject);
    procedure EditMonUpgradeColor7Change(Sender: TObject);
    procedure EditMonUpgradeColor8Change(Sender: TObject);
    procedure EditMonUpgradeColor9Change(Sender: TObject);
    procedure CheckBoxReNewChangeColorClick(Sender: TObject);
    procedure CheckBoxReNewLevelClearExpClick(Sender: TObject);
    procedure EditPKFlagNameColorChange(Sender: TObject);
    procedure EditPKLevel1NameColorChange(Sender: TObject);
    procedure EditPKLevel2NameColorChange(Sender: TObject);
    procedure EditAllyAndGuildNameColorChange(Sender: TObject);
    procedure EditWarGuildNameColorChange(Sender: TObject);
    procedure EditInFreePKAreaNameColorChange(Sender: TObject);
    procedure EditMonUpgradeKillCount1Change(Sender: TObject);
    procedure EditMonUpgradeKillCount2Change(Sender: TObject);
    procedure EditMonUpgradeKillCount3Change(Sender: TObject);
    procedure EditMonUpgradeKillCount4Change(Sender: TObject);
    procedure EditMonUpgradeKillCount5Change(Sender: TObject);
    procedure EditMonUpgradeKillCount6Change(Sender: TObject);
    procedure EditMonUpgradeKillCount7Change(Sender: TObject);
    procedure EditMonUpLvNeedKillBaseChange(Sender: TObject);
    procedure EditMonUpLvRateChange(Sender: TObject);
    procedure CheckBoxMasterDieMutinyClick(Sender: TObject);
    procedure EditMasterDieMutinyRateChange(Sender: TObject);
    procedure EditMasterDieMutinyPowerChange(Sender: TObject);
    procedure EditMasterDieMutinySpeedChange(Sender: TObject);
    procedure ButtonSpiritMutinySaveClick(Sender: TObject);
    procedure CheckBoxSpiritMutinyClick(Sender: TObject);
    procedure EditSpiritMutinyTimeChange(Sender: TObject);
    procedure EditSpiritPowerRateChange(Sender: TObject);
    procedure EditMagTurnUndeadLevelChange(Sender: TObject);
    procedure EditMagTammingLevelChange(Sender: TObject);
    procedure EditMagTammingTargetLevelChange(Sender: TObject);
    procedure EditMagTammingHPRateChange(Sender: TObject);
    procedure ButtonMonSayMsgSaveClick(Sender: TObject);
    procedure CheckBoxMonSayMsgClick(Sender: TObject);
    procedure ButtonUpgradeWeaponDefaulfClick(Sender: TObject);
    procedure ButtonMakeMineDefaultClick(Sender: TObject);
    procedure ButtonWinLotteryDefaultClick(Sender: TObject);
    procedure EditMabMabeHitRandRateChange(Sender: TObject);
    procedure EditMabMabeHitMinLvLimitChange(Sender: TObject);
    procedure EditMabMabeHitSucessRateChange(Sender: TObject);
    procedure EditMabMabeHitMabeTimeRateChange(Sender: TObject);
    procedure ButtonWeaponMakeLuckDefaultClick(Sender: TObject);
    procedure ButtonWeaponMakeLuckSaveClick(Sender: TObject);
    procedure ScrollBarWeaponMakeUnLuckRateChange(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint1Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint2Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint2RateChange(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint3Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint3RateChange(Sender: TObject);
    procedure EditTammingCountChange(Sender: TObject);
    procedure CheckBoxFireCrossInSafeZoneClick(Sender: TObject);
    procedure CheckBoxBBMonAutoChangeColorClick(Sender: TObject);
    procedure EditBBMonAutoChangeColorTimeChange(Sender: TObject);
    procedure CheckBoxGroupMbAttackPlayObjectClick(Sender: TObject);
    procedure SpinEditSellOffCountChange(Sender: TObject);
    procedure SpinEditSellOffTaxChange(Sender: TObject);
    procedure ButtonSellOffSaveClick(Sender: TObject);
    procedure CheckBoxPullPlayObjectClick(Sender: TObject);
    procedure CheckBoxPlayObjectReduceMPClick(Sender: TObject);
    procedure CheckBoxGroupMbAttackSlaveClick(Sender: TObject);
    procedure CheckBoxItemNameClick(Sender: TObject);
    procedure EditItemNameChange(Sender: TObject);
    procedure ButtonChangeUseItemNameClick(Sender: TObject);
    procedure SpinEditSkill39SecChange(Sender: TObject);
    procedure CheckBoxDedingAllowPKClick(Sender: TObject);
    procedure SpinEditAllowCopyCountChange(Sender: TObject);
    procedure EditCopyHumNameChange(Sender: TObject);
    procedure CheckBoxMasterNameClick(Sender: TObject);
    procedure SpinEditPickUpItemCountChange(Sender: TObject);
    procedure SpinEditEatHPItemRateChange(Sender: TObject);
    procedure SpinEditEatMPItemRateChange(Sender: TObject);
    procedure EditBagItems1Change(Sender: TObject);
    procedure EditBagItems2Change(Sender: TObject);
    procedure EditBagItems3Change(Sender: TObject);
    procedure CheckBoxAllowGuardAttackClick(Sender: TObject);
    procedure SpinEditWarrorAttackTimeChange(Sender: TObject);
    procedure SpinEditWizardAttackTimeChange(Sender: TObject);
    procedure SpinEditTaoistAttackTimeChange(Sender: TObject);
    procedure CheckBoxAllowReCallMobOtherHumClick(Sender: TObject);
    procedure CheckBoxNeedLevelHighTargetClick(Sender: TObject);
    procedure CheckBoxPullCrossInSafeZoneClick(Sender: TObject);
    procedure CheckBoxStartMapEventClick(Sender: TObject);
    procedure CheckBoxFireChgMapExtinguishClick(Sender: TObject);
    procedure SpinEditFireDelayTimeClick(Sender: TObject);
    procedure SpinEditFirePowerClick(Sender: TObject);
    procedure SpinEditDidingPowerRateClick(Sender: TObject);
    procedure FairyNameEdtChange(Sender: TObject);
    procedure SpinFairyEdtChange(Sender: TObject);
    procedure GridFairySetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure SpinFairyDuntRateEdtChange(Sender: TObject);
    procedure SpinFairyAttackRateEdtChange(Sender: TObject);
    procedure EditProtectionDefenceTimeChange(Sender: TObject);
    procedure EditProtectionTickChange(Sender: TObject);
    procedure EditProtectionRateChange(Sender: TObject);
    procedure EditProtectionBadRateChange(Sender: TObject);
    procedure CheckRushkungBadClick(Sender: TObject);
    procedure CheckErgumBadClick(Sender: TObject);
    procedure CheckFirehitBadClick(Sender: TObject);
    procedure CheckTwnhitBadClick(Sender: TObject);
    procedure EditDecDragonPointChange(Sender: TObject);
    procedure SpinEditKill43SecChange(Sender: TObject);
    procedure SpinEditnCopyHumanTickChange(Sender: TObject);
    procedure Spin43KillHitRateEdtChange(Sender: TObject);
    procedure Spin43KillAttackRateEdtChange(Sender: TObject);
    procedure SpinEditAttackRate_43Change(Sender: TObject);
    procedure SpinEditAttackRate_2Change(Sender: TObject);
    procedure EditMagicAttackRage_42Change(Sender: TObject);
    procedure EdtDecUserGameGoldChange(Sender: TObject);
    procedure ShowProtectionEnvClick(Sender: TObject);
    procedure AutoProtectionClick(Sender: TObject);
    procedure SpinEditMakeSelfTickChange(Sender: TObject);
    procedure EditCopyHumNameColorChange(Sender: TObject);
    procedure AutoCanHitClick(Sender: TObject);
    procedure EditMeteorFireRainRageChange(Sender: TObject);
    procedure EditMagFireCharmTreatmentChange(Sender: TObject);
    procedure SpinEditAttackRate_74Change(Sender: TObject);
    procedure CheckBoxLockCallHeroClick(Sender: TObject);
    procedure EditMasterCountChange(Sender: TObject);
    procedure EditAbilityUpTickChange(Sender: TObject);
    procedure SpinEditAbilityUpUseTimeChange(Sender: TObject);
    procedure SpinEditMagChangXYChange(Sender: TObject);
    procedure SpinEditKill42SecChange(Sender: TObject);
    procedure SpinEditMakeWineTimeChange(Sender: TObject);
    procedure SpinEditMakeWineRateChange(Sender: TObject);
    procedure ButtonSaveMakeWineClick(Sender: TObject);
    procedure SpinEditMakeWineTime1Change(Sender: TObject);
    procedure SpinEditIncAlcoholTickChange(Sender: TObject);
    procedure SpinEditDesDrinkTickChange(Sender: TObject);
    procedure SpinEditMaxAlcoholValueChange(Sender: TObject);
    procedure SpinEditIncAlcoholValueChange(Sender: TObject);
    procedure GridMedicineExpEnter(Sender: TObject);
    procedure SpinEditDesMedicineValueChange(Sender: TObject);
    procedure SpinEditDesMedicineTickChange(Sender: TObject);
    procedure SpinEditInFountainTimeChange(Sender: TObject);
    procedure SpinEditHPUpTickChange(Sender: TObject);
    procedure SpinEditHPUpUseTimeChange(Sender: TObject);
    procedure GridSkill68Enter(Sender: TObject);
    procedure SpinEditMinDrinkValue67Change(Sender: TObject);
    procedure SpinEditMinDrinkValue68Change(Sender: TObject);
    procedure SpinEditMinGuildFountainChange(Sender: TObject);
    procedure SpinEditDecGuildFountainChange(Sender: TObject);
    procedure SpinEditChallengeTimeChange(Sender: TObject);
    procedure CheckSlaveMoveMasterClick(Sender: TObject);
    procedure CheckBoxShowGuildNameClick(Sender: TObject);
    procedure SpinEditStartHPRockChange(Sender: TObject);
    procedure SpinEditHPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddHPChange(Sender: TObject);
    procedure SpinEditHPRockDecDuraChange(Sender: TObject);
    procedure SpinEditStartMPRockChange(Sender: TObject);
    procedure SpinEditMPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddMPChange(Sender: TObject);
    procedure SpinEditMPRockDecDuraChange(Sender: TObject);
    procedure SpinEditStartHPMPRockChange(Sender: TObject);
    procedure SpinEditHPMPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddHPMPChange(Sender: TObject);
    procedure SpinEditHPMPRockDecDuraChange(Sender: TObject);
    procedure RadioboSkill31EffectFalseClick(Sender: TObject);
    procedure RadioboSkill31EffectTrueClick(Sender: TObject);
    procedure SpinEditSkill66RateChange(Sender: TObject);
    procedure EditProtectionOKRateChange(Sender: TObject);
    procedure SpinEditSkill69NGChange(Sender: TObject);
    procedure SpinEditSkill69NGExpChange(Sender: TObject);
    procedure SpinEditHeroSkill69NGExpChange(Sender: TObject);
    procedure SpinEditdwIncNHTimeChange(Sender: TObject);
    procedure SpinEditDrinkIncNHExpChange(Sender: TObject);
    procedure SpinEditHitStruckDecNHChange(Sender: TObject);
    procedure SpinEditAbilityUpFixUseTimeChange(Sender: TObject);
    procedure CheckBoxAbilityUpFixModeClick(Sender: TObject);
    procedure SpinEditAttackRate_26Change(Sender: TObject);
    procedure EditKillMonNGExpMultipleChange(Sender: TObject);
    procedure SpinEditNPCNameColorChange(Sender: TObject);
    procedure SpinEditNGSkillRateChange(Sender: TObject);
    procedure SpinEditNGLevelDamageChange(Sender: TObject);
    procedure SpinEditOrdinarySkill66RateChange(Sender: TObject);
    procedure SpinEditFairyDuntRateBelowChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonExpCrystalSaveClick(Sender: TObject);
    procedure GridExpCrystalLevelExpEnter(Sender: TObject);
    procedure EditHeroCrystalExpRateChange(Sender: TObject);

  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefReNewLevelConf;
    procedure RefUpgradeWeapon;
    procedure RefMakeMine;
    procedure RefWinLottery;
    procedure RefMonUpgrade;
    procedure RefGeneral;
    procedure RefSpiritMutiny;
    procedure RefMagicSkill;
    procedure RefMonSayMsg;
    procedure RefWeaponMakeLuck();
    procedure RefCopyHumConf;
    { Private declarations }
  public
    procedure Open;
    { Public declarations }
  end;
                                                         
var
  frmFunctionConfig: TfrmFunctionConfig;

implementation

uses M2Share, HUtil32;

{$R *.dfm}

{ TfrmFunctionConfig }

procedure TfrmFunctionConfig.ModValue;
begin
  boModValued := True;
  ButtonPasswordLockSave.Enabled := True;
  ButtonGeneralSave.Enabled := True;
  ButtonSkillSave.Enabled := True;
  ButtonUpgradeWeaponSave.Enabled := True;
  ButtonMasterSave.Enabled := True;
  ButtonMakeMineSave.Enabled := True;
  ButtonWinLotterySave.Enabled := True;
  ButtonReNewLevelSave.Enabled := True;
  ButtonMonUpgradeSave.Enabled := True;
  ButtonSpiritMutinySave.Enabled := True;
  ButtonMonSayMsgSave.Enabled := True;
  ButtonSellOffSave.Enabled := True;
  ButtonChangeUseItemName.Enabled := True;
  ButtonSaveMakeWine.Enabled := True;
  ButtonWeaponMakeLuckSave.Enabled := True;
  ButtonExpCrystalSave.Enabled := True;
end;

procedure TfrmFunctionConfig.uModValue;
begin
  boModValued := False;
  ButtonPasswordLockSave.Enabled := False;
  ButtonGeneralSave.Enabled := False;
  ButtonSkillSave.Enabled := False;
  ButtonUpgradeWeaponSave.Enabled := False;
  ButtonMasterSave.Enabled := False;
  ButtonMakeMineSave.Enabled := False;
  ButtonWinLotterySave.Enabled := False;
  ButtonReNewLevelSave.Enabled := False;
  ButtonMonUpgradeSave.Enabled := False;
  ButtonSpiritMutinySave.Enabled := False;
  ButtonMonSayMsgSave.Enabled := False;
  ButtonSellOffSave.Enabled := False;
  ButtonChangeUseItemName.Enabled := False;
  ButtonSaveMakeWine.Enabled := False;
  ButtonWeaponMakeLuckSave.Enabled := False;
  ButtonExpCrystalSave.Enabled := False;
end;
procedure TfrmFunctionConfig.FunctionConfigControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if boModValued then begin
    if Application.MessageBox('参数设置已经被修改，是否确认不保存修改的设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
      uModValue
    end else AllowChange := False;
  end;
end;
procedure TfrmFunctionConfig.Open;
var
  I: Integer;
begin
  boOpened := False;
  uModValue();

  RefGeneral();
  CheckBoxHungerSystem.Checked := g_Config.boHungerSystem;
  CheckBoxHungerDecHP.Checked := g_Config.boHungerDecHP;
  CheckBoxHungerDecPower.Checked := g_Config.boHungerDecPower;

  CheckBoxHungerSystemClick(CheckBoxHungerSystem);


  CheckBoxEnablePasswordLock.Checked := g_Config.boPasswordLockSystem;
  CheckBoxLockGetBackItem.Checked := g_Config.boLockGetBackItemAction;
  CheckBoxLockDealItem.Checked := g_Config.boLockDealAction;
  CheckBoxLockDropItem.Checked := g_Config.boLockDropAction;
  CheckBoxLockWalk.Checked := g_Config.boLockWalkAction;
  CheckBoxLockRun.Checked := g_Config.boLockRunAction;
  CheckBoxLockHit.Checked := g_Config.boLockHitAction;
  CheckBoxLockSpell.Checked := g_Config.boLockSpellAction;
  CheckBoxLockCallHero.Checked := g_Config.boLockCallHeroAction;//是否锁定召唤英雄操作  20080529
  CheckBoxLockSendMsg.Checked := g_Config.boLockSendMsgAction;
  CheckBoxLockInObMode.Checked := g_Config.boLockInObModeAction;

  CheckBoxLockLogin.Checked := g_Config.boLockHumanLogin;
  CheckBoxLockUseItem.Checked := g_Config.boLockUserItemAction;

  CheckBoxEnablePasswordLockClick(CheckBoxEnablePasswordLock);
  CheckBoxLockLoginClick(CheckBoxLockLogin);

  EditErrorPasswordCount.Value := g_Config.nPasswordErrorCountLock;


  EditBoneFammName.Text := g_Config.sBoneFamm;
  EditBoneFammCount.Value := g_Config.nBoneFammCount;

  EdtDecUserGameGold.Value := g_Config.nDecUserGameGold;//每次扣多少元宝(元宝寄售) 20080319
  SpinEditMakeWineTime.Value:= g_Config.nMakeWineTime;//酿普通酒等待时间 20080621
  SpinEditMakeWineTime1.Value:= g_Config.nMakeWineTime1;//酿药酒等待时间 20080621
  SpinEditMakeWineRate.Value:= g_Config.nMakeWineRate;//酿酒获得酒曲机率 20080621
  SpinEditIncAlcoholTick.Value:= g_Config.nIncAlcoholTick;//增加酒量进度的间隔时间 20080623
  SpinEditDesDrinkTick.Value:= g_Config.nDesDrinkTick;//减少醉酒度的间隔时间 20080623
  SpinEditMaxAlcoholValue.Value:= g_Config.nMaxAlcoholValue;//酒量上限初始值 20080623
  SpinEditIncAlcoholValue.Value:= g_Config.nIncAlcoholValue;//升级后增加酒量上限值 20080623
  SpinEditDesMedicineValue.Value:= g_Config.nDesMedicineValue;//长时间不使用酒,减药力值 20080623
  SpinEditDesMedicineTick.Value:= g_Config.nDesMedicineTick;//减药力值时间间隔 20080624
  SpinEditInFountainTime.Value:= g_Config.nInFountainTime;//站在泉眼上的累积时间(秒) 20080624
  SpinEditMinGuildFountain.Value:= g_Config.nMinGuildFountain;//行会酒泉蓄量少于时,不能领取 20080627
  SpinEditDecGuildFountain.Value:= g_Config.nDecGuildFountain;//行会成员领取酒泉,蓄量减少 20080627
  for I := 1 to GridMedicineExp.RowCount - 1 do begin//药力值 20080623
    GridMedicineExp.Cells[1, I] := IntToStr(g_Config.dwMedicineNeedExps[I]);
  end;
  for I := 1 to GridExpCrystalLevelExp.RowCount - 1 do begin//天地结晶 20090131
    GridExpCrystalLevelExp.Cells[1, I] := IntToStr(g_Config.dwExpCrystalNeedExps[I]);
    GridExpCrystalLevelExp.Cells[2, I] := IntToStr(g_Config.dwNGExpCrystalNeedExps[I]);
  end;
  EditHeroCrystalExpRate.Value := g_Config.nHeroCrystalExpRate;//天地结晶英雄分配比例 20090202

  //SpinEditSellOffCount.Value := g_Config.nUserSellOffCount; //20080504 去掉拍卖功能
  //SpinEditSellOffTax.Value := g_Config.nUserSellOffTax;  //20080504 去掉拍卖功能

  SpinEditFireDelayTime.Value := g_Config.nFireDelayTimeRate;
  SpinEditFirePower.Value := g_Config.nFirePowerRate;
  CheckBoxFireChgMapExtinguish.Checked := g_Config.boChangeMapFireExtinguish;
  SpinEditDidingPowerRate.Value := g_Config.nDidingPowerRate;
  for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
    if g_Config.BoneFammArray[I].nHumLevel <= 0 then Break;

    GridBoneFamm.Cells[0, I + 1] := IntToStr(g_Config.BoneFammArray[I].nHumLevel);
    GridBoneFamm.Cells[1, I + 1] := g_Config.BoneFammArray[I].sMonName;
    GridBoneFamm.Cells[2, I + 1] := IntToStr(g_Config.BoneFammArray[I].nCount);
    GridBoneFamm.Cells[3, I + 1] := IntToStr(g_Config.BoneFammArray[I].nLevel);
  end;

  EditDogzName.Text := g_Config.sDogz;
  EditDogzCount.Value := g_Config.nDogzCount;
  for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
    if g_Config.DogzArray[I].nHumLevel <= 0 then Break;
    GridDogz.Cells[0, I + 1] := IntToStr(g_Config.DogzArray[I].nHumLevel);
    GridDogz.Cells[1, I + 1] := g_Config.DogzArray[I].sMonName;
    GridDogz.Cells[2, I + 1] := IntToStr(g_Config.DogzArray[I].nCount);
    GridDogz.Cells[3, I + 1] := IntToStr(g_Config.DogzArray[I].nLevel);
  end;
 //月灵
  FairyNameEdt.Text := g_Config.sFairy;
  SpinFairyEdt.Value := g_Config.nFairyCount;
  SpinFairyDuntRateEdt.Value :=g_Config.nFairyDuntRate;
  SpinEditFairyDuntRateBelow.Value :=g_Config.nFairyDuntRateBelow;//月灵重击次数,达到次数时按等级出重击 20090105
  SpinFairyAttackRateEdt.Value :=g_Config.nFairyAttackRate;
  Spin43KillHitRateEdt.Value :=g_Config.n43KillHitRate;//开天斩重击几率 20080213
  Spin43KillAttackRateEdt.Value :=g_Config.n43KillAttackRate;//开天斩重击倍数  20080213
  SpinEditAttackRate_43.Value :=g_Config.nAttackRate_43;//开天斩威力  20080213
  SpinEditAttackRate_26.Value :=g_Config.nAttackRate_26;//烈火剑法威力倍数 20081208
  SpinEditAttackRate_74.Value :=g_Config.nAttackRate_74;//逐日剑法威力倍数 20080511
  for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do begin
    if g_Config.FairyArray[I].nHumLevel <= 0 then Break;
    GridFairy.Cells[0, I + 1] := IntToStr(g_Config.FairyArray[I].nHumLevel);
    GridFairy.Cells[1, I + 1] := g_Config.FairyArray[I].sMonName;
    GridFairy.Cells[2, I + 1] := IntToStr(g_Config.FairyArray[I].nCount);
    GridFairy.Cells[3, I + 1] := IntToStr(g_Config.FairyArray[I].nLevel);
  end;


  RefMagicSkill();

  RefUpgradeWeapon();
  RefMakeMine();
  RefWinLottery();
  EditMasterCount.Value := g_Config.nMasterCount;//可收徒弟数 20080530
  EditMasterOKLevel.Value := g_Config.nMasterOKLevel;
  EditMasterOKCreditPoint.Value := g_Config.nMasterOKCreditPoint;
  EditMasterOKBonusPoint.Value := g_Config.nMasterOKBonusPoint;

  CheckBoxPullPlayObject.Checked := g_Config.boPullPlayObject;
  CheckBoxPullCrossInSafeZone.Checked := g_Config.boPullCrossInSafeZone;
  CheckBoxPullCrossInSafeZone.Enabled := g_Config.boPullPlayObject;

  CheckBoxPlayObjectReduceMP.Checked := g_Config.boPlayObjectReduceMP;
  CheckBoxGroupMbAttackSlave.Checked := g_Config.boGroupMbAttackSlave;
  CheckBoxItemName.Checked := g_Config.boChangeUseItemNameByPlayName;
  EditItemName.Text := g_Config.sChangeUseItemName;
  CheckBoxDedingAllowPK.Checked := g_Config.boDedingAllowPK;

  SpinEditMakeSelfTick.Value := g_Config.nMakeSelfTick;//分身使用时长 20080404
  SpinEditnCopyHumanTick.Value := g_Config.nCopyHumanTick;//召唤分身间隔 20080204
  SpinEditKill43Sec.Value := g_Config.nKill43UseTime;//开天斩使用间隔 20080204
  SpinEditSkill39Sec.Value := g_Config.nDedingUseTime;
  CheckBoxStartMapEvent.Checked := g_Config.boStartMapEvent;//开启地图事件触发
  EditAbilityUpTick.Value := g_Config.nAbilityUpTick;//无极真气使用间隔 20080603

  CheckBoxAbilityUpFixMode.Checked := g_Config.boAbilityUpFixMode;//无极真气使用时长模式 20081109
  if g_Config.boAbilityUpFixMode then begin
    SpinEditAbilityUpFixUseTime.Enabled:= True;
    SpinEditAbilityUpUseTime.Enabled:= False;
  end else begin
    SpinEditAbilityUpFixUseTime.Enabled:= False;
    SpinEditAbilityUpUseTime.Enabled:= True;
  end;
  SpinEditAbilityUpFixUseTime.Value := g_Config.nAbilityUpFixUseTime;//无极真气使用固定时长 20081109
  SpinEditAbilityUpUseTime.Value := g_Config.nAbilityUpUseTime;//无极真气使用时长 20080603
  
  SpinEditMinDrinkValue67.Value := g_Config.nMinDrinkValue67;//先天元力失效酒量下限比例 20080626
  SpinEditMinDrinkValue68.Value := g_Config.nMinDrinkValue68;//酒气护体失效酒量下限比例 20080626
  SpinEditHPUpTick.Value := g_Config.nHPUpTick;//酒气护体使用间隔 20080625
  SpinEditHPUpUseTime.Value := g_Config.nHPUpUseTime;//酒气护体增加使用时长 20080625
  for I := 1 to GridSkill68.RowCount - 1 do begin//酒气护体升级经验 20080625
    GridSkill68.Cells[1, I] := IntToStr(g_Config.dwSkill68NeedExps[I]);
  end;
  SpinEditChallengeTime.Value := g_Config.nChallengeTime;//挑战时间 20080706
  CheckBoxShowGuildName.Checked := g_Config.boShowGuildName;//人物名是否显示行会信息 20080726

  if g_Config.boSkill31Effect then begin//魔法盾效果 T-特色效果 F-盛大效果 20080808
    RadioboSkill31EffectTrue.Checked := True;
    RadioboSkill31EffectFalse.Checked := False;
  end else begin
    RadioboSkill31EffectTrue.Checked := False;
    RadioboSkill31EffectFalse.Checked := True;
  end;
  SpinEditSkill66Rate.Value := g_Config.nSkill66Rate;//四级魔法盾抵御伤害百分率 20080829
  SpinEditOrdinarySkill66Rate.Value := g_Config.nOrdinarySkill66Rate;//普通魔法盾抵御伤害百分率 20081226
  SpinEditNGSkillRate.Value := g_Config.nNGSkillRate;//内功技能增强的攻防比率 20081223
  SpinEditNGLevelDamage.Value := g_Config.nNGLevelDamage;//内功等级增加攻防的级数比率 20081223
  SpinEditSkill69NG.Value := g_Config.nSkill69NG;//内力值参数 20081001
  SpinEditSkill69NGExp.Value := g_Config.nSkill69NGExp;//主体内功经验参数 20081001
  SpinEditHeroSkill69NGExp.Value := g_Config.nHeroSkill69NGExp;//英雄内功经验参数 20081001
  SpinEditdwIncNHTime.Value := g_Config.dwIncNHTime div 1000;//增加内力值间隔 20081002
  SpinEditDrinkIncNHExp.Value := g_Config.nDrinkIncNHExp;//饮酒增加内功经验 20081003
  SpinEditHitStruckDecNH.Value := g_Config.nHitStruckDecNH;//内功抵御普通攻击消耗内力值 20081003
  EditKillMonNGExpMultiple.Value := g_Config.dwKillMonNGExpMultiple;//杀怪内功经验倍数 20081215

  RefReNewLevelConf();
  RefMonUpgrade();
  RefSpiritMutiny();
  RefMonSayMsg();
  RefWeaponMakeLuck();

  RefCopyHumConf;

  boOpened := True;
  FunctionConfigControl.ActivePageIndex := 0;
  ShowModal;
end;

procedure TfrmFunctionConfig.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  GridExpCrystalLevelExp.Cells[0, 0] := '等级';
  GridExpCrystalLevelExp.Cells[1, 0] := '经验值';
  GridExpCrystalLevelExp.Cells[2, 0] := '内功经验值';
  for I := 1 to GridExpCrystalLevelExp.RowCount - 1 do begin
    GridExpCrystalLevelExp.Cells[0, I] := IntToStr(I);
  end;

  GridMedicineExp.Cells[0, 0] := '等级';
  GridMedicineExp.Cells[1, 0] := '药力值';
  for I := 1 to GridMedicineExp.RowCount - 1 do begin
    GridMedicineExp.Cells[0, I] := IntToStr(I);
  end;

  GridSkill68.Cells[0, 0] := '等级';
  GridSkill68.Cells[1, 0] := '经验值';
  for I := 1 to GridSkill68.RowCount - 1 do begin
    GridSkill68.Cells[0, I] := IntToStr(I);
  end;

  GridBoneFamm.Cells[0, 0] := '人物等级';
  GridBoneFamm.Cells[1, 0] := '怪物名称';
  GridBoneFamm.Cells[2, 0] := '数量';
  GridBoneFamm.Cells[3, 0] := '等级';

  GridDogz.Cells[0, 0] := '人物等级';
  GridDogz.Cells[1, 0] := '怪物名称';
  GridDogz.Cells[2, 0] := '数量';
  GridDogz.Cells[3, 0] := '等级';

  //月灵
  GridFairy.Cells[0, 0] := '人物等级';
  GridFairy.Cells[1, 0] := '怪物名称';
  GridFairy.Cells[2, 0] := '数量';
  GridFairy.Cells[3, 0] := '等级';

  FunctionConfigControl.ActivePageIndex := 0;
  MagicPageControl.ActivePageIndex := 0;
{$IF (SoftVersion = VERPRO) or (SoftVersion = VERENT)}
  CheckBoxHungerDecPower.Visible := True;
{$ELSE}
  CheckBoxHungerDecPower.Visible := False;
{$IFEND}

{$IF SoftVersion = VERDEMO}
  Caption := '功能设置[演示版本，所有设置调整有效，但不能保存]'
{$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxEnablePasswordLockClick(
  Sender: TObject);
begin
  case CheckBoxEnablePasswordLock.Checked of
    True: begin
        CheckBoxLockGetBackItem.Enabled := True;
        CheckBoxLockLogin.Enabled := True;
      end;
    False: begin
        CheckBoxLockGetBackItem.Checked := False;
        CheckBoxLockLogin.Checked := False;

        CheckBoxLockGetBackItem.Enabled := False;
        CheckBoxLockLogin.Enabled := False;
      end;
  end;
  if not boOpened then Exit;
  g_Config.boPasswordLockSystem := CheckBoxEnablePasswordLock.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockGetBackItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockGetBackItemAction := CheckBoxLockGetBackItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockDealItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockDealAction := CheckBoxLockDealItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockDropItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockDropAction := CheckBoxLockDropItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockUseItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockUserItemAction := CheckBoxLockUseItem.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxLockLoginClick(Sender: TObject);
begin
  case CheckBoxLockLogin.Checked of //
    True: begin
        CheckBoxLockWalk.Enabled := True;
        CheckBoxLockRun.Enabled := True;
        CheckBoxLockHit.Enabled := True;
        CheckBoxLockSpell.Enabled := True;
        CheckBoxLockInObMode.Enabled := True;
        CheckBoxLockSendMsg.Enabled := True;
        CheckBoxLockDealItem.Enabled := True;
        CheckBoxLockDropItem.Enabled := True;
        CheckBoxLockUseItem.Enabled := True;
        CheckBoxLockCallHero.Enabled := True;
      end;
    False: begin
        CheckBoxLockWalk.Checked := False;
        CheckBoxLockRun.Checked := False;
        CheckBoxLockHit.Checked := False;
        CheckBoxLockSpell.Checked := False;
        CheckBoxLockInObMode.Checked := False;
        CheckBoxLockSendMsg.Checked := False;
        CheckBoxLockDealItem.Checked := False;
        CheckBoxLockDropItem.Checked := False;
        CheckBoxLockUseItem.Checked := False;
        CheckBoxLockCallHero.Checked := False;

        CheckBoxLockWalk.Enabled := False;
        CheckBoxLockRun.Enabled := False;
        CheckBoxLockHit.Enabled := False;
        CheckBoxLockSpell.Enabled := False;
        CheckBoxLockInObMode.Enabled := False;
        CheckBoxLockSendMsg.Enabled := False;
        CheckBoxLockDealItem.Enabled := False;
        CheckBoxLockDropItem.Enabled := False;
        CheckBoxLockUseItem.Enabled := False;
        CheckBoxLockCallHero.Enabled := False;
      end;
  end;
  if not boOpened then Exit;
  g_Config.boLockHumanLogin := CheckBoxLockLogin.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxLockWalkClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockWalkAction := CheckBoxLockWalk.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockRunClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockRunAction := CheckBoxLockRun.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockHitClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockHitAction := CheckBoxLockHit.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockSpellClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockSpellAction := CheckBoxLockSpell.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockSendMsgClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockSendMsgAction := CheckBoxLockSendMsg.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockInObModeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockInObModeAction := CheckBoxLockInObMode.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditErrorPasswordCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPasswordErrorCountLock := EditErrorPasswordCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxErrorCountKickClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPasswordErrorCountLock := EditErrorPasswordCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonPasswordLockSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'PasswordLockSystem', g_Config.boPasswordLockSystem);
  Config.WriteBool('Setup', 'PasswordLockDealAction', g_Config.boLockDealAction);
  Config.WriteBool('Setup', 'PasswordLockDropAction', g_Config.boLockDropAction);
  Config.WriteBool('Setup', 'PasswordLockGetBackItemAction', g_Config.boLockGetBackItemAction);
  Config.WriteBool('Setup', 'PasswordLockWalkAction', g_Config.boLockWalkAction);
  Config.WriteBool('Setup', 'PasswordLockRunAction', g_Config.boLockRunAction);
  Config.WriteBool('Setup', 'PasswordLockHitAction', g_Config.boLockHitAction);
  Config.WriteBool('Setup', 'PasswordLockSpellAction', g_Config.boLockSpellAction);
  Config.WriteBool('Setup', 'PasswordLockCallHeroAction', g_Config.boLockCallHeroAction);//是否锁定召唤英雄操作  20080529
  Config.WriteBool('Setup', 'PasswordLockSendMsgAction', g_Config.boLockSendMsgAction);
  Config.WriteBool('Setup', 'PasswordLockInObModeAction', g_Config.boLockInObModeAction);
  Config.WriteBool('Setup', 'PasswordLockUserItemAction', g_Config.boLockUserItemAction);

  Config.WriteBool('Setup', 'PasswordLockHumanLogin', g_Config.boLockHumanLogin);
  Config.WriteInteger('Setup', 'PasswordErrorCountLock', g_Config.nPasswordErrorCountLock);

{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.RefGeneral();
begin
  SpinEditNPCNameColor.Value := g_Config.btNPCNameColor;//NPC名字颜色 20081218
  EditPKFlagNameColor.Value := g_Config.btPKFlagNameColor;
  EditPKLevel1NameColor.Value := g_Config.btPKLevel1NameColor;
  EditPKLevel2NameColor.Value := g_Config.btPKLevel2NameColor;
  EditAllyAndGuildNameColor.Value := g_Config.btAllyAndGuildNameColor;
  EditWarGuildNameColor.Value := g_Config.btWarGuildNameColor;
  EditInFreePKAreaNameColor.Value := g_Config.btInFreePKAreaNameColor;

  SpinEditStartHPRock.Value := g_Config.nStartHPRock;
  SpinEditStartMPRock.Value := g_Config.nStartMPRock;
  SpinEditStartHPMPRock.Value := g_Config.nStartHPMPRock;
  SpinEditHPRockSpell.Value := g_Config.nHPRockSpell;
  SpinEditMPRockSpell.Value := g_Config.nMPRockSpell;
  SpinEditHPMPRockSpell.Value := g_Config.nHPMPRockSpell;
  SpinEditRockAddHP.Value := g_Config.nRockAddHP;
  SpinEditRockAddMP.Value := g_Config.nRockAddMP;
  SpinEditRockAddHPMP.Value := g_Config.nRockAddHPMP;
  SpinEditHPRockDecDura.Value := g_Config.nHPRockDecDura;
  SpinEditMPRockDecDura.Value := g_Config.nMPRockDecDura;
  SpinEditHPMPRockDecDura.Value := g_Config.nHPMPRockDecDura;  
end;

procedure TfrmFunctionConfig.CheckBoxHungerSystemClick(Sender: TObject);
begin
  if CheckBoxHungerSystem.Checked then begin
    CheckBoxHungerDecHP.Enabled := True;
    CheckBoxHungerDecPower.Enabled := True;
  end else begin
    CheckBoxHungerDecHP.Checked := False;
    CheckBoxHungerDecPower.Checked := False;
    CheckBoxHungerDecHP.Enabled := False;
    CheckBoxHungerDecPower.Enabled := False;
  end;

  if not boOpened then Exit;
  g_Config.boHungerSystem := CheckBoxHungerSystem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxHungerDecHPClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHungerDecHP := CheckBoxHungerDecHP.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxHungerDecPowerClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHungerDecPower := CheckBoxHungerDecPower.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonGeneralSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'HungerSystem', g_Config.boHungerSystem);
  Config.WriteBool('Setup', 'HungerDecHP', g_Config.boHungerDecHP);
  Config.WriteBool('Setup', 'HungerDecPower', g_Config.boHungerDecPower);
  Config.WriteInteger('Setup', 'ChallengeTime', g_Config.nChallengeTime);//挑战时间 20080706

  Config.WriteInteger('Setup', 'NPCNameColor', g_Config.btNPCNameColor);//NPC名字颜色 20081218
  Config.WriteInteger('Setup', 'PKFlagNameColor', g_Config.btPKFlagNameColor);
  Config.WriteInteger('Setup', 'AllyAndGuildNameColor', g_Config.btAllyAndGuildNameColor);
  Config.WriteInteger('Setup', 'WarGuildNameColor', g_Config.btWarGuildNameColor);
  Config.WriteInteger('Setup', 'InFreePKAreaNameColor', g_Config.btInFreePKAreaNameColor);
  Config.WriteInteger('Setup', 'PKLevel1NameColor', g_Config.btPKLevel1NameColor);
  Config.WriteInteger('Setup', 'PKLevel2NameColor', g_Config.btPKLevel2NameColor);
  Config.WriteBool('Setup', 'StartMapEvent', g_Config.boStartMapEvent);
  Config.WriteBool('Setup', 'ShowGuildName', g_Config.boShowGuildName);//人物名是否显示行会信息 20080726

  Config.WriteInteger('Setup', 'StartHPRock', g_Config.nStartHPRock);
  Config.WriteInteger('Setup', 'StartMPRock', g_Config.nStartMPRock);
  Config.WriteInteger('Setup', 'StartHPMPRock', g_Config.nStartHPMPRock);
  Config.WriteInteger('Setup', 'HPRockSpell', g_Config.nHPRockSpell);
  Config.WriteInteger('Setup', 'MPRockSpell', g_Config.nMPRockSpell);
  Config.WriteInteger('Setup', 'HPMPRockSpell', g_Config.nHPMPRockSpell);
  Config.WriteInteger('Setup', 'RockAddHP', g_Config.nRockAddHP);
  Config.WriteInteger('Setup', 'RockAddMP', g_Config.nRockAddMP);
  Config.WriteInteger('Setup', 'RockAddHPMP', g_Config.nRockAddHPMP);
  Config.WriteInteger('Setup', 'HPRockDecDura', g_Config.nHPRockDecDura);
  Config.WriteInteger('Setup', 'MPRockDecDura', g_Config.nMPRockDecDura);
  Config.WriteInteger('Setup', 'HPMPRockDecDura', g_Config.nHPMPRockDecDura);  
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditMagicAttackRageChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagicAttackRage := EditMagicAttackRage.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.RefMagicSkill;
begin
  EditSwordLongPowerRate.Value := g_Config.nSwordLongPowerRate;
  CheckBoxLimitSwordLong.Checked := g_Config.boLimitSwordLong;
  EditFireBoomRage.Value := g_Config.nFireBoomRage;
  EditSnowWindRange.Value := g_Config.nSnowWindRange;
  EditMeteorFireRainRage.Value := g_Config.nMeteorFireRainRage;//流星火雨攻击范围 20080510
  EditMagFireCharmTreatment.Value := g_Config.nMagFireCharmTreatment;//噬血术加血百分率 20080511
  EditElecBlizzardRange.Value := g_Config.nElecBlizzardRange;
  EditMagicAttackRage.Value := g_Config.nMagicAttackRage;
  EditAmyOunsulPoint.Value := g_Config.nAmyOunsulPoint;
  EditMagTurnUndeadLevel.Value := g_Config.nMagTurnUndeadLevel;
  EditMagTammingLevel.Value := g_Config.nMagTammingLevel;
  EditMagTammingTargetLevel.Value := g_Config.nMagTammingTargetLevel;
  EditMagTammingHPRate.Value := g_Config.nMagTammingHPRate;
  EditTammingCount.Value := g_Config.nMagTammingCount;
  EditMabMabeHitRandRate.Value := g_Config.nMabMabeHitRandRate;
  EditMabMabeHitMinLvLimit.Value := g_Config.nMabMabeHitMinLvLimit;
  EditMabMabeHitSucessRate.Value := g_Config.nMabMabeHitSucessRate;
  EditMabMabeHitMabeTimeRate.Value := g_Config.nMabMabeHitMabeTimeRate;
  CheckBoxFireCrossInSafeZone.Checked := g_Config.boDisableInSafeZoneFireCross;
  CheckBoxGroupMbAttackPlayObject.Checked := g_Config.boGroupMbAttackPlayObject;
//------------------------------------------------------------------------------
  SpinEditMagChangXY.Value := g_Config.dwMagChangXYTick div 1000;//移行换位使用间隔 20080616
//护体神盾 20080108
  EditProtectionDefenceTime.Value := g_Config.nProtectionDefenceTime  div 1000;
  EditProtectionTick.Value := g_Config.dwProtectionTick  div 1000;
  EditProtectionRate.Value := g_Config.nProtectionRate;
  EditProtectionOKRate.Value := g_Config.nProtectionOKRate;//护体神盾生效机率 20080929
  EditProtectionBadRate.Value := g_Config.nProtectionBadRate;
  CheckRushkungBad.Checked:=g_Config.RushkungBadProtection;
  CheckErgumBad.Checked:=g_Config.ErgumBadProtection;
  CheckFirehitBad.Checked:=g_Config.FirehitBadProtection;
  CheckTwnhitBad.Checked:=g_Config.TwnhitBadProtection;
  ShowProtectionEnv.Checked := g_Config.boShowProtectionEnv;//显示护体神盾效果 20080328
  AutoProtection.Checked := g_Config.boAutoProtection;//自动使用神盾 20080328
  AutoCanHit.Checked := g_Config.boAutoCanHit;//智能锁定 20080418
  CheckSlaveMoveMaster.Checked := g_Config.boSlaveMoveMaster;//宝宝是否飞到主人身边 20080713
//------------------------------------------------------------------------------
  SpinEditKill42Sec.Value := g_Config.nKill42UseTime;//龙影剑法使用间隔 20080619
  SpinEditAttackRate_42.Value := g_Config.nAttackRate_42;//龙影剑法威力 20080213
  EditMagicAttackRage_42.Value := g_Config.nMagicAttackRage_42;//龙影剑法范围 20080218
//------------------------------------------------------------------------------
end;

procedure TfrmFunctionConfig.EditBoneFammCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBoneFammCount := EditBoneFammCount.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.EditDogzCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDogzCount := EditDogzCount.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.CheckBoxLimitSwordLongClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLimitSwordLong := CheckBoxLimitSwordLong.Checked;
  ModValue();
end;
procedure TfrmFunctionConfig.EditSwordLongPowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSwordLongPowerRate := EditSwordLongPowerRate.Value;
  ModValue()
end;
procedure TfrmFunctionConfig.EditBoneFammNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;
procedure TfrmFunctionConfig.EditDogzNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;
procedure TfrmFunctionConfig.EditFireBoomRageChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireBoomRage := EditFireBoomRage.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.EditSnowWindRangeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSnowWindRange := EditSnowWindRange.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditElecBlizzardRangeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nElecBlizzardRange := EditElecBlizzardRange.Value;//地狱雷光攻击范围
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTurnUndeadLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTurnUndeadLevel := EditMagTurnUndeadLevel.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.GridBoneFammSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  if not boOpened then Exit;
  ModValue();
end;
procedure TfrmFunctionConfig.EditAmyOunsulPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAmyOunsulPoint := EditAmyOunsulPoint.Value;
  ModValue();
end;


procedure TfrmFunctionConfig.CheckBoxFireChgMapExtinguishClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boChangeMapFireExtinguish := CheckBoxFireChgMapExtinguish.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxFireCrossInSafeZoneClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boDisableInSafeZoneFireCross := CheckBoxFireCrossInSafeZone.Checked;
  ModValue();
end;


procedure TfrmFunctionConfig.CheckBoxGroupMbAttackPlayObjectClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boGroupMbAttackPlayObject := CheckBoxGroupMbAttackPlayObject.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSkillSaveClick(Sender: TObject);
var
  I: Integer;
  RecallArray: array[0..9] of TRecallMigic;
  Rect: TGridRect;
  dwExp: LongWord;
  NeedExps: TLevelNeedExp2;
begin
  FillChar(RecallArray, SizeOf(RecallArray), #0);

  g_Config.sBoneFamm := Trim(EditBoneFammName.Text);

  for I := Low(RecallArray) to High(RecallArray) do begin
    RecallArray[I].nHumLevel := Str_ToInt(GridBoneFamm.Cells[0, I + 1], -1);
    RecallArray[I].sMonName := Trim(GridBoneFamm.Cells[1, I + 1]);
    RecallArray[I].nCount := Str_ToInt(GridBoneFamm.Cells[2, I + 1], -1);
    RecallArray[I].nLevel := Str_ToInt(GridBoneFamm.Cells[3, I + 1], -1);
    if GridBoneFamm.Cells[0, I + 1] = '' then Break;
    if (RecallArray[I].nHumLevel <= 0) then begin
      Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 0;
      Rect.Top := I + 1;
      Rect.Right := 0;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      Exit;
    end;
    if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then begin
      Application.MessageBox('骷髅怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 1;
      Rect.Top := I + 1;
      Rect.Right := 1;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      Exit;
    end;
    if RecallArray[I].nCount <= 0 then begin
      Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 2;
      Rect.Top := I + 1;
      Rect.Right := 2;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      Exit;
    end;
    if RecallArray[I].nLevel < 0 then begin
      Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 3;
      Rect.Top := I + 1;
      Rect.Right := 3;
      Rect.Bottom := I + 1;
      GridBoneFamm.Selection := Rect;
      Exit;
    end;
  end;

  for I := Low(RecallArray) to High(RecallArray) do begin
    RecallArray[I].nHumLevel := Str_ToInt(GridDogz.Cells[0, I + 1], -1);
    RecallArray[I].sMonName := Trim(GridDogz.Cells[1, I + 1]);
    RecallArray[I].nCount := Str_ToInt(GridDogz.Cells[2, I + 1], -1);
    RecallArray[I].nLevel := Str_ToInt(GridDogz.Cells[3, I + 1], -1);
    if GridDogz.Cells[0, I + 1] = '' then Break;
    if (RecallArray[I].nHumLevel <= 0) then begin
      Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 0;
      Rect.Top := I + 1;
      Rect.Right := 0;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      Exit;
    end;
    if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then begin
      Application.MessageBox('神兽怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 1;
      Rect.Top := I + 1;
      Rect.Right := 1;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      Exit;
    end;
    if RecallArray[I].nCount <= 0 then begin
      Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 2;
      Rect.Top := I + 1;
      Rect.Right := 2;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      Exit;
    end;
    if RecallArray[I].nLevel < 0 then begin
      Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 3;
      Rect.Top := I + 1;
      Rect.Right := 3;
      Rect.Bottom := I + 1;
      GridDogz.Selection := Rect;
      Exit;
    end;
  end;
  //月灵

  for I := Low(RecallArray) to High(RecallArray) do begin
    RecallArray[I].nHumLevel := Str_ToInt(GridFairy.Cells[0, I + 1], -1);
    RecallArray[I].sMonName := Trim(GridFairy.Cells[1, I + 1]);
    RecallArray[I].nCount := Str_ToInt(GridFairy.Cells[2, I + 1], -1);
    RecallArray[I].nLevel := Str_ToInt(GridFairy.Cells[3, I + 1], -1);
    if GridFairy.Cells[0, I + 1] = '' then Break;
    if (RecallArray[I].nHumLevel <= 0) then begin
      Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 0;
      Rect.Top := I + 1;
      Rect.Right := 0;
      Rect.Bottom := I + 1;
      GridFairy.Selection := Rect;
      Exit;
    end;
    if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then begin
      Application.MessageBox('月灵怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 1;
      Rect.Top := I + 1;
      Rect.Right := 1;
      Rect.Bottom := I + 1;
      GridFairy.Selection := Rect;
      Exit;
    end;
    if RecallArray[I].nCount <= 0 then begin
      Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 2;
      Rect.Top := I + 1;
      Rect.Right := 2;
      Rect.Bottom := I + 1;
      GridFairy.Selection := Rect;
      Exit;
    end;
    if RecallArray[I].nLevel < 0 then begin
      Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
      Rect.Left := 3;
      Rect.Top := I + 1;
      Rect.Right := 3;
      Rect.Bottom := I + 1;
      GridFairy.Selection := Rect;
      Exit;
    end;
  end;



  FillChar(g_Config.BoneFammArray, SizeOf(g_Config.BoneFammArray), #0);
  for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
    Config.WriteInteger('Setup', 'BoneFammHumLevel' + IntToStr(I), 0);
    Config.WriteString('Names', 'BoneFamm' + IntToStr(I), '');
    Config.WriteInteger('Setup', 'BoneFammCount' + IntToStr(I), 0);
    Config.WriteInteger('Setup', 'BoneFammLevel' + IntToStr(I), 0);
  end;
  for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
    if GridBoneFamm.Cells[0, I + 1] = '' then Break;
    g_Config.BoneFammArray[I].nHumLevel := Str_ToInt(GridBoneFamm.Cells[0, I + 1], -1);
    g_Config.BoneFammArray[I].sMonName := Trim(GridBoneFamm.Cells[1, I + 1]);
    g_Config.BoneFammArray[I].nCount := Str_ToInt(GridBoneFamm.Cells[2, I + 1], -1);
    g_Config.BoneFammArray[I].nLevel := Str_ToInt(GridBoneFamm.Cells[3, I + 1], -1);

    Config.WriteInteger('Setup', 'BoneFammHumLevel' + IntToStr(I), g_Config.BoneFammArray[I].nHumLevel);
    Config.WriteString('Names', 'BoneFamm' + IntToStr(I), g_Config.BoneFammArray[I].sMonName);
    Config.WriteInteger('Setup', 'BoneFammCount' + IntToStr(I), g_Config.BoneFammArray[I].nCount);
    Config.WriteInteger('Setup', 'BoneFammLevel' + IntToStr(I), g_Config.BoneFammArray[I].nLevel);
  end;

  FillChar(g_Config.DogzArray, SizeOf(g_Config.DogzArray), #0);
  for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
    Config.WriteInteger('Setup', 'DogzHumLevel' + IntToStr(I), 0);
    Config.WriteString('Names', 'Dogz' + IntToStr(I), '');
    Config.WriteInteger('Setup', 'DogzCount' + IntToStr(I), 0);
    Config.WriteInteger('Setup', 'DogzLevel' + IntToStr(I), 0);
  end;
  for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
    if GridDogz.Cells[0, I + 1] = '' then Break;

    g_Config.DogzArray[I].nHumLevel := Str_ToInt(GridDogz.Cells[0, I + 1], -1);
    g_Config.DogzArray[I].sMonName := Trim(GridDogz.Cells[1, I + 1]);
    g_Config.DogzArray[I].nCount := Str_ToInt(GridDogz.Cells[2, I + 1], -1);
    g_Config.DogzArray[I].nLevel := Str_ToInt(GridDogz.Cells[3, I + 1], -1);

    Config.WriteInteger('Setup', 'DogzHumLevel' + IntToStr(I), g_Config.DogzArray[I].nHumLevel);
    Config.WriteString('Names', 'Dogz' + IntToStr(I), g_Config.DogzArray[I].sMonName);
    Config.WriteInteger('Setup', 'DogzCount' + IntToStr(I), g_Config.DogzArray[I].nCount);
    Config.WriteInteger('Setup', 'DogzLevel' + IntToStr(I), g_Config.DogzArray[I].nLevel);
  end;

  //月灵
  FillChar(g_Config.FairyArray, SizeOf(g_Config.FairyArray), #0);
  for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do begin
    Config.WriteInteger('Setup', 'FairyHumLevel' + IntToStr(I), 0);
    Config.WriteString('Names', 'Fairy' + IntToStr(I), '');
    Config.WriteInteger('Setup', 'FairyCount' + IntToStr(I), 0);
    Config.WriteInteger('Setup', 'Fairyevel' + IntToStr(I), 0);
  end;
  for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do begin
    if GridFairy.Cells[0, I + 1] = '' then Break;

    g_Config.FairyArray[I].nHumLevel := Str_ToInt(GridFairy.Cells[0, I + 1], -1);
    g_Config.FairyArray[I].sMonName := Trim(GridFairy.Cells[1, I + 1]);
    g_Config.FairyArray[I].nCount := Str_ToInt(GridFairy.Cells[2, I + 1], -1);
    g_Config.FairyArray[I].nLevel := Str_ToInt(GridFairy.Cells[3, I + 1], -1);

    Config.WriteInteger('Setup', 'FairyHumLevel' + IntToStr(I), g_Config.FairyArray[I].nHumLevel);
    Config.WriteString('Names', 'Fairy' + IntToStr(I), g_Config.FairyArray[I].sMonName);
    Config.WriteInteger('Setup', 'FairyCount' + IntToStr(I), g_Config.FairyArray[I].nCount);
    Config.WriteInteger('Setup', 'FairyLevel' + IntToStr(I), g_Config.FairyArray[I].nLevel);
  end;

{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'LimitSwordLong', g_Config.boLimitSwordLong);
  Config.WriteInteger('Setup', 'SwordLongPowerRate', g_Config.nSwordLongPowerRate);
  Config.WriteInteger('Setup', 'BoneFammCount', g_Config.nBoneFammCount);
  Config.WriteString('Names', 'BoneFamm', g_Config.sBoneFamm);
  Config.WriteInteger('Setup', 'DogzCount', g_Config.nDogzCount);
  Config.WriteString('Names', 'Dogz', g_Config.sDogz);
  //月灵
  Config.WriteInteger('Setup', 'FairyAttackRate', g_Config.nFairyAttackRate);//20080520
  Config.WriteInteger('Setup', 'FairyCount', g_Config.nFairyCount);
  Config.WriteString('Names', 'Fairy', g_Config.sFairy);
  Config.WriteInteger('Setup', 'FairyDuntRate', g_Config.nFairyDuntRate);
  Config.WriteInteger('Setup', 'FairyDuntRateBelow', g_Config.nFairyDuntRateBelow);//月灵重击次数,达到次数时按等级出重击 20090105
  Config.WriteInteger('Setup', '43KillHitRate', g_Config.n43KillHitRate);//开天斩重击几率 20080213
  Config.WriteInteger('Setup', '43KillAttackRate', g_Config.n43KillAttackRate);//开天斩重击倍数  20080213
  Config.WriteInteger('Setup', 'AttackRate_43', g_Config.nAttackRate_43);//开天斩威力  20080213
  Config.WriteInteger('Setup', 'AttackRate_26', g_Config.nAttackRate_26);//烈火剑法威力倍数 20081208
  Config.WriteInteger('Setup', 'AttackRate_74', g_Config.nAttackRate_74);//逐日剑法威力倍数 20080511
  Config.WriteInteger('Setup', 'FireBoomRage', g_Config.nFireBoomRage);
  Config.WriteInteger('Setup', 'SnowWindRange', g_Config.nSnowWindRange);
  Config.WriteInteger('Setup', 'MeteorFireRainRage', g_Config.nMeteorFireRainRage);//流星火雨攻击范围 20080510
  Config.WriteInteger('Setup', 'MagFireCharmTreatment', g_Config.nMagFireCharmTreatment);//噬血术加血百分率 20080511
  Config.WriteInteger('Setup', 'ElecBlizzardRange', g_Config.nElecBlizzardRange);
  Config.WriteInteger('Setup', 'AmyOunsulPoint', g_Config.nAmyOunsulPoint);
  Config.WriteInteger('Setup', 'MagicAttackRage', g_Config.nMagicAttackRage);
  Config.WriteInteger('Setup', 'MagTurnUndeadLevel', g_Config.nMagTurnUndeadLevel);
  Config.WriteInteger('Setup', 'MagTammingLevel', g_Config.nMagTammingLevel);
  Config.WriteInteger('Setup', 'MagTammingTargetLevel', g_Config.nMagTammingTargetLevel);
  Config.WriteInteger('Setup', 'MagTammingTargetHPRate', g_Config.nMagTammingHPRate);
  Config.WriteInteger('Setup', 'MagTammingCount', g_Config.nMagTammingCount);

  Config.WriteInteger('Setup', 'MabMabeHitRandRate', g_Config.nMabMabeHitRandRate);
  Config.WriteInteger('Setup', 'MabMabeHitMinLvLimit', g_Config.nMabMabeHitMinLvLimit);
  Config.WriteInteger('Setup', 'MabMabeHitSucessRate', g_Config.nMabMabeHitSucessRate);
  Config.WriteInteger('Setup', 'MabMabeHitMabeTimeRate', g_Config.nMabMabeHitMabeTimeRate);

  Config.WriteBool('Setup', 'DisableInSafeZoneFireCross', g_Config.boDisableInSafeZoneFireCross);
  Config.WriteBool('Setup', 'GroupMbAttackPlayObject', g_Config.boGroupMbAttackPlayObject);

  Config.WriteBool('Setup', 'PullPlayObject', g_Config.boPullPlayObject);
  Config.WriteBool('Setup', 'PullCrossInSafeZone', g_Config.boPullCrossInSafeZone);

  Config.WriteBool('Setup', 'GroupMbAttackSlave', g_Config.boGroupMbAttackSlave);
  Config.WriteBool('Setup', 'DamageMP', g_Config.boPlayObjectReduceMP);

  //Config.WriteInteger('Setup', 'MagicValidTimeRate', g_Config.nMagDelayTimeDoubly);//未使用 20080504
  //Config.WriteInteger('Setup', 'MagicPowerRate', g_Config.nMagPowerDoubly);//未使用 20080504
  Config.WriteInteger('Setup', 'Magic43UseTime', g_Config.nKill43UseTime);//开天斩使用间隔 20080204
  Config.WriteInteger('Setup', 'MagicDedingUseTime', g_Config.nDedingUseTime);
  Config.WriteInteger('Setup', 'AbilityUpTick', g_Config.nAbilityUpTick);//无极真气使用间隔 20080603

  Config.WriteBool('Setup', 'AbilityUpFixMode', g_Config.boAbilityUpFixMode);//无极真气使用时长模式 20081109
  Config.WriteInteger('Setup', 'AbilityUpFixUseTime', g_Config.nAbilityUpFixUseTime);//无极真气使用固定时长 20081109
  Config.WriteInteger('Setup', 'AbilityUpUseTime', g_Config.nAbilityUpUseTime);//无极真气使用时长 20080603
  Config.WriteInteger('Setup', 'MinDrinkValue67', g_Config.nMinDrinkValue67);//先天元力失效酒量下限比例 20080626
  Config.WriteInteger('Setup', 'MinDrinkValue68', g_Config.nMinDrinkValue68);//酒气护体失效酒量下限比例 20080626
  Config.WriteInteger('Setup', 'HPUpTick', g_Config.nHPUpTick);//酒气护体使用间隔 20080625
  Config.WriteInteger('Setup', 'HPUpUseTime', g_Config.nHPUpUseTime);//酒气护体增加使用时长 20080625

  for I := 1 to GridSkill68.RowCount - 1 do begin
    dwExp := Str_ToInt(GridSkill68.Cells[1, I], 0);
    if (dwExp <= 0) then begin
      Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 经验值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridSkill68.Row := I;
      GridSkill68.SetFocus;
      Exit;
    end;
    NeedExps[I] := dwExp;
  end;
  g_Config.dwSkill68NeedExps := NeedExps;
  for I := 1 to 100 do begin
    Config.WriteString('Skill68', 'Level' + IntToStr(I), IntToStr(g_Config.dwSkill68NeedExps[I]));
  end;



  Config.WriteBool('Setup', 'DedingAllowPK', g_Config.boDedingAllowPK);

  Config.WriteInteger('Setup', 'FireDelayTimeRate', g_Config.nFireDelayTimeRate);
  Config.WriteInteger('Setup', 'FirePowerRate', g_Config.nFirePowerRate);
  Config.WriteBool('Setup', 'ChangeMapFireExtinguish', g_Config.boChangeMapFireExtinguish);
  Config.WriteInteger('Setup', 'DidingPowerRate', g_Config.nDidingPowerRate);
  {分身术}
  if not g_Config.boAddMasterName then begin
    if g_Config.sCopyHumName = '' then begin
      Application.MessageBox('分身人物名称不能为空！！！', '错误信息', MB_OK + MB_ICONERROR);
      Exit;
    end;
  end;
  Config.WriteInteger('Setup', 'MakeSelfTick', g_Config.nMakeSelfTick);//分身使用时长 20080404
  Config.WriteInteger('Setup', 'CopyHumanTick', g_Config.nCopyHumanTick);//召唤分身间隔 20080204
  Config.WriteInteger('Setup', 'CopyHumanBagCount', g_Config.nCopyHumanBagCount);
  Config.WriteInteger('Setup', 'CopyHumNameColor', g_Config.nCopyHumNameColor);//分身名字颜色 20080404
  Config.WriteInteger('Setup', 'AllowCopyHumanCount', g_Config.nAllowCopyHumanCount);
  Config.WriteBool('Setup', 'AddMasterName', g_Config.boAddMasterName);
  Config.WriteString('Setup', 'CopyHumName', g_Config.sCopyHumName);
  Config.WriteInteger('Setup', 'CopyHumAddHPRate', g_Config.nCopyHumAddHPRate);
  Config.WriteInteger('Setup', 'CopyHumAddMPRate', g_Config.nCopyHumAddMPRate);
  Config.WriteString('Setup', 'CopyHumBagItems1', g_Config.sCopyHumBagItems1);
  Config.WriteString('Setup', 'CopyHumBagItems2', g_Config.sCopyHumBagItems2);
  Config.WriteString('Setup', 'CopyHumBagItems3', g_Config.sCopyHumBagItems3);
  Config.WriteBool('Setup', 'AllowGuardAttack', g_Config.boAllowGuardAttack);

  Config.WriteInteger('Setup', 'WarrorAttackTime', g_Config.dwWarrorAttackTime);
  Config.WriteInteger('Setup', 'WizardAttackTime', g_Config.dwWizardAttackTime);
  Config.WriteInteger('Setup', 'TaoistAttackTime', g_Config.dwTaoistAttackTime);

  Config.WriteBool('Setup', 'AllowReCallMobOtherHum', g_Config.boAllowReCallMobOtherHum);
  Config.WriteBool('Setup', 'NeedLevelHighTarget', g_Config.boNeedLevelHighTarget);
//------------------------------------------------------------------------------
  Config.WriteInteger('Setup', 'MagChangXYTick', g_Config.dwMagChangXYTick);//移行换位使用间隔 20080616
//护体神盾 20080108
  Config.WriteInteger('Setup', 'ProtectionDefenceTime', g_Config.nProtectionDefenceTime);
  Config.WriteInteger('Setup', 'ProtectionTick', g_Config.dwProtectionTick);
  Config.WriteInteger('Setup', 'ProtectionRate', g_Config.nProtectionRate);
  Config.WriteInteger('Setup', 'ProtectionOKRate', g_Config.nProtectionOKRate);//护体神盾生效机率 20080929
  Config.WriteInteger('Setup', 'ProtectionBadRate', g_Config.nProtectionBadRate);
  Config.WriteBool('Setup', 'RushkungBadProtection', g_Config.RushkungBadProtection);
  Config.WriteBool('Setup', 'ErgumBadProtection', g_Config.ErgumBadProtection);
  Config.WriteBool('Setup', 'FirehitBadProtection', g_Config.FirehitBadProtection);
  Config.WriteBool('Setup', 'TwnhitBadProtection', g_Config.TwnhitBadProtection);
  Config.WriteBool('Setup', 'ShowProtectionEnv', g_Config.boShowProtectionEnv);//显示护体神盾效果 20080328
  Config.WriteBool('Setup', 'AutoProtection', g_Config.boAutoProtection);//自动使用神盾 20080328
  Config.WriteBool('Setup', 'AutoCanHit', g_Config.boAutoCanHit);//智能锁定 20080418
  Config.WriteBool('Setup', 'SlaveMoveMaster', g_Config.boSlaveMoveMaster);//宝宝是否飞到主人身边 20080713
//------------------------------------------------------------------------------
//黄条气槽 20080201
  Config.WriteInteger('Setup', 'Magic42UseTime', g_Config.nKill42UseTime);//龙影剑法使用间隔 20080204
  Config.WriteInteger('Setup', 'AttackRate_42', g_Config.nAttackRate_42); //龙影剑法威力 20080213
  Config.WriteInteger('Setup', 'MagicAttackRage_42', g_Config.nMagicAttackRage_42); //龙影剑法范围 20080218
//------------------------------------------------------------------------------
  Config.WriteBool('Setup', 'Skill31Effect', g_Config.boSkill31Effect);//魔法盾效果 T-特色效果 F-盛大效果 20080808
  Config.WriteInteger('Setup', 'Skill66Rate', g_Config.nSkill66Rate);//四级魔法盾抵御伤害百分率 20080829
  Config.WriteInteger('Setup', 'OrdinarySkill66Rate', g_Config.nOrdinarySkill66Rate);//普通魔法盾抵御伤害百分率 20081226
  Config.WriteInteger('Setup', 'NGSkillRate', g_Config.nNGSkillRate);//内功技能增强的攻防比率 20081223
  Config.WriteInteger('Setup', 'NGLevelDamage', g_Config.nNGLevelDamage);//内功等级增加攻防的级数比率 20081223
  Config.WriteInteger('Setup', 'Skill69NG', g_Config.nSkill69NG);//内力值参数 20081001
  Config.WriteInteger('Setup', 'Skill69NGExp', g_Config.nSkill69NGExp);//主体内功经验参数 20081001
  Config.WriteInteger('Setup', 'HeroSkill69NGExp', g_Config.nHeroSkill69NGExp);//英雄内功经验参数 20081001
  Config.WriteInteger('Setup', 'dwIncNHTime', g_Config.dwIncNHTime);//增加内力值间隔 20081002
  Config.WriteInteger('Setup', 'DrinkIncNHExp', g_Config.nDrinkIncNHExp);//饮酒增加内功经验 20081003
  Config.WriteInteger('Setup', 'HitStruckDecNH', g_Config.nHitStruckDecNH);//内功抵御普通攻击消耗内力值 20081003
  Config.WriteInteger('Exp', 'KillMonNGExpMultiple', g_Config.dwKillMonNGExpMultiple);//杀怪内功经验倍数 20081215
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.RefUpgradeWeapon();
begin
  ScrollBarUpgradeWeaponDCRate.Position := g_Config.nUpgradeWeaponDCRate;
  ScrollBarUpgradeWeaponDCTwoPointRate.Position := g_Config.nUpgradeWeaponDCTwoPointRate;
  ScrollBarUpgradeWeaponDCThreePointRate.Position := g_Config.nUpgradeWeaponDCThreePointRate;

  ScrollBarUpgradeWeaponMCRate.Position := g_Config.nUpgradeWeaponMCRate;
  ScrollBarUpgradeWeaponMCTwoPointRate.Position := g_Config.nUpgradeWeaponMCTwoPointRate;
  ScrollBarUpgradeWeaponMCThreePointRate.Position := g_Config.nUpgradeWeaponMCThreePointRate;

  ScrollBarUpgradeWeaponSCRate.Position := g_Config.nUpgradeWeaponSCRate;
  ScrollBarUpgradeWeaponSCTwoPointRate.Position := g_Config.nUpgradeWeaponSCTwoPointRate;
  ScrollBarUpgradeWeaponSCThreePointRate.Position := g_Config.nUpgradeWeaponSCThreePointRate;

  EditUpgradeWeaponMaxPoint.Value := g_Config.nUpgradeWeaponMaxPoint;
  EditUpgradeWeaponPrice.Value := g_Config.nUpgradeWeaponPrice;
  EditUPgradeWeaponGetBackTime.Value := g_Config.dwUPgradeWeaponGetBackTime div 1000;
  EditClearExpireUpgradeWeaponDays.Value := g_Config.nClearExpireUpgradeWeaponDays;
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCRate.Position;
  EditUpgradeWeaponDCRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponDCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCTwoPointRate.Position;
  EditUpgradeWeaponDCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponDCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCThreePointRate.Position;
  EditUpgradeWeaponDCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponDCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCRate.Position;
  EditUpgradeWeaponSCRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponSCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCTwoPointRate.Position;
  EditUpgradeWeaponSCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponSCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCThreePointRate.Position;
  EditUpgradeWeaponSCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponSCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCRate.Position;
  EditUpgradeWeaponMCRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCTwoPointRate.Position;
  EditUpgradeWeaponMCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCThreePointRate.Position;
  EditUpgradeWeaponMCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUpgradeWeaponMaxPointChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMaxPoint := EditUpgradeWeaponMaxPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUpgradeWeaponPriceChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponPrice := EditUpgradeWeaponPrice.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUPgradeWeaponGetBackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwUPgradeWeaponGetBackTime := EditUPgradeWeaponGetBackTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditClearExpireUpgradeWeaponDaysChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nClearExpireUpgradeWeaponDays := EditClearExpireUpgradeWeaponDays.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonUpgradeWeaponSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'UpgradeWeaponMaxPoint', g_Config.nUpgradeWeaponMaxPoint);
  Config.WriteInteger('Setup', 'UpgradeWeaponPrice', g_Config.nUpgradeWeaponPrice);
  Config.WriteInteger('Setup', 'ClearExpireUpgradeWeaponDays', g_Config.nClearExpireUpgradeWeaponDays);
  Config.WriteInteger('Setup', 'UPgradeWeaponGetBackTime', g_Config.dwUPgradeWeaponGetBackTime);

  Config.WriteInteger('Setup', 'UpgradeWeaponDCRate', g_Config.nUpgradeWeaponDCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponDCTwoPointRate', g_Config.nUpgradeWeaponDCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponDCThreePointRate', g_Config.nUpgradeWeaponDCThreePointRate);

  Config.WriteInteger('Setup', 'UpgradeWeaponMCRate', g_Config.nUpgradeWeaponMCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponMCTwoPointRate', g_Config.nUpgradeWeaponMCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponMCThreePointRate', g_Config.nUpgradeWeaponMCThreePointRate);

  Config.WriteInteger('Setup', 'UpgradeWeaponSCRate', g_Config.nUpgradeWeaponSCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponSCTwoPointRate', g_Config.nUpgradeWeaponSCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponSCThreePointRate', g_Config.nUpgradeWeaponSCThreePointRate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonUpgradeWeaponDefaulfClick(
  Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;
  g_Config.nUpgradeWeaponMaxPoint := 20;
  g_Config.nUpgradeWeaponPrice := 10000;
  g_Config.nClearExpireUpgradeWeaponDays := 8;
  g_Config.dwUPgradeWeaponGetBackTime := 3600000{60 * 60 * 1000};

  g_Config.nUpgradeWeaponDCRate := 100;
  g_Config.nUpgradeWeaponDCTwoPointRate := 30;
  g_Config.nUpgradeWeaponDCThreePointRate := 200;

  g_Config.nUpgradeWeaponMCRate := 100;
  g_Config.nUpgradeWeaponMCTwoPointRate := 30;
  g_Config.nUpgradeWeaponMCThreePointRate := 200;

  g_Config.nUpgradeWeaponSCRate := 100;
  g_Config.nUpgradeWeaponSCTwoPointRate := 30;
  g_Config.nUpgradeWeaponSCThreePointRate := 200;
  RefUpgradeWeapon();
end;

procedure TfrmFunctionConfig.EditMasterOKLevelChange(Sender: TObject);
begin
  if EditMasterOKLevel.Text = '' then begin
    EditMasterOKLevel.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterOKLevel := EditMasterOKLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterOKCreditPointChange(
  Sender: TObject);
begin
  if EditMasterOKCreditPoint.Text = '' then begin
    EditMasterOKCreditPoint.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterOKCreditPoint := EditMasterOKCreditPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterOKBonusPointChange(Sender: TObject);
begin
  if EditMasterOKBonusPoint.Text = '' then begin
    EditMasterOKBonusPoint.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterOKBonusPoint := EditMasterOKBonusPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonMasterSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MasterCount', g_Config.nMasterCount);//可收徒弟数 20080530
  Config.WriteInteger('Setup', 'MasterOKLevel', g_Config.nMasterOKLevel);
  Config.WriteInteger('Setup', 'MasterOKCreditPoint', g_Config.nMasterOKCreditPoint);
  Config.WriteInteger('Setup', 'MasterOKBonusPoint', g_Config.nMasterOKBonusPoint);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonMakeMineSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MakeMineHitRate', g_Config.nMakeMineHitRate);
  Config.WriteInteger('Setup', 'MakeMineRate', g_Config.nMakeMineRate);
  Config.WriteInteger('Setup', 'StoneTypeRate', g_Config.nStoneTypeRate);
  Config.WriteInteger('Setup', 'StoneTypeRateMin', g_Config.nStoneTypeRateMin);
  Config.WriteInteger('Setup', 'GoldStoneMin', g_Config.nGoldStoneMin);
  Config.WriteInteger('Setup', 'GoldStoneMax', g_Config.nGoldStoneMax);
  Config.WriteInteger('Setup', 'SilverStoneMin', g_Config.nSilverStoneMin);
  Config.WriteInteger('Setup', 'SilverStoneMax', g_Config.nSilverStoneMax);
  Config.WriteInteger('Setup', 'SteelStoneMin', g_Config.nSteelStoneMin);
  Config.WriteInteger('Setup', 'SteelStoneMax', g_Config.nSteelStoneMax);
  Config.WriteInteger('Setup', 'BlackStoneMin', g_Config.nBlackStoneMin);
  Config.WriteInteger('Setup', 'BlackStoneMax', g_Config.nBlackStoneMax);
  Config.WriteInteger('Setup', 'StoneMinDura', g_Config.nStoneMinDura);
  Config.WriteInteger('Setup', 'StoneGeneralDuraRate', g_Config.nStoneGeneralDuraRate);
  Config.WriteInteger('Setup', 'StoneAddDuraRate', g_Config.nStoneAddDuraRate);
  Config.WriteInteger('Setup', 'StoneAddDuraMax', g_Config.nStoneAddDuraMax);
{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.ButtonMakeMineDefaultClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;
  g_Config.nMakeMineHitRate := 4;
  g_Config.nMakeMineRate := 12;
  g_Config.nStoneTypeRate := 120;
  g_Config.nStoneTypeRateMin := 56;
  g_Config.nGoldStoneMin := 1;
  g_Config.nGoldStoneMax := 2;
  g_Config.nSilverStoneMin := 3;
  g_Config.nSilverStoneMax := 20;
  g_Config.nSteelStoneMin := 21;
  g_Config.nSteelStoneMax := 45;
  g_Config.nBlackStoneMin := 46;
  g_Config.nBlackStoneMax := 56;
  g_Config.nStoneMinDura := 3000;
  g_Config.nStoneGeneralDuraRate := 13000;
  g_Config.nStoneAddDuraRate := 20;
  g_Config.nStoneAddDuraMax := 10000;
  RefMakeMine();
end;

procedure TfrmFunctionConfig.RefMakeMine();
begin
  ScrollBarMakeMineHitRate.Position := g_Config.nMakeMineHitRate;
  ScrollBarMakeMineHitRate.Min := 0;
  ScrollBarMakeMineHitRate.Max := 10;

  ScrollBarMakeMineRate.Position := g_Config.nMakeMineRate;
  ScrollBarMakeMineRate.Min := 0;
  ScrollBarMakeMineRate.Max := 50;

  ScrollBarStoneTypeRate.Position := g_Config.nStoneTypeRate;
  ScrollBarStoneTypeRate.Min := g_Config.nStoneTypeRateMin;
  ScrollBarStoneTypeRate.Max := 500;

  ScrollBarGoldStoneMax.Min := 1;
  ScrollBarGoldStoneMax.Max := g_Config.nSilverStoneMax;

  ScrollBarSilverStoneMax.Min := g_Config.nGoldStoneMax;
  ScrollBarSilverStoneMax.Max := g_Config.nSteelStoneMax;

  ScrollBarSteelStoneMax.Min := g_Config.nSilverStoneMax;
  ScrollBarSteelStoneMax.Max := g_Config.nBlackStoneMax;

  ScrollBarBlackStoneMax.Min := g_Config.nSteelStoneMax;
  ScrollBarBlackStoneMax.Max := g_Config.nStoneTypeRate;

  ScrollBarGoldStoneMax.Position := g_Config.nGoldStoneMax;
  ScrollBarSilverStoneMax.Position := g_Config.nSilverStoneMax;
  ScrollBarSteelStoneMax.Position := g_Config.nSteelStoneMax;
  ScrollBarBlackStoneMax.Position := g_Config.nBlackStoneMax;

  EditStoneMinDura.Value := g_Config.nStoneMinDura div 1000;
  EditStoneGeneralDuraRate.Value := g_Config.nStoneGeneralDuraRate div 1000;
  EditStoneAddDuraRate.Value := g_Config.nStoneAddDuraRate;
  EditStoneAddDuraMax.Value := g_Config.nStoneAddDuraMax div 1000;
end;

procedure TfrmFunctionConfig.ScrollBarMakeMineHitRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarMakeMineHitRate.Position;
  EditMakeMineHitRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nMakeMineHitRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarMakeMineRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarMakeMineRate.Position;
  EditMakeMineRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nMakeMineRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarStoneTypeRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarStoneTypeRate.Position;
  EditStoneTypeRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  ScrollBarBlackStoneMax.Max := nPostion;
  g_Config.nStoneTypeRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarGoldStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarGoldStoneMax.Position;
  EditGoldStoneMax.Text := IntToStr(g_Config.nGoldStoneMin) + '-' + IntToStr(g_Config.nGoldStoneMax);
  if not boOpened then Exit;
  g_Config.nSilverStoneMin := nPostion + 1;
  ScrollBarSilverStoneMax.Min := nPostion + 1;
  g_Config.nGoldStoneMax := nPostion;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarSilverStoneMaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarSilverStoneMax.Position;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  if not boOpened then Exit;
  ScrollBarGoldStoneMax.Max := nPostion - 1;
  g_Config.nSteelStoneMin := nPostion + 1;
  ScrollBarSteelStoneMax.Min := nPostion + 1;
  g_Config.nSilverStoneMax := nPostion;
  EditGoldStoneMax.Text := IntToStr(g_Config.nGoldStoneMin) + '-' + IntToStr(g_Config.nGoldStoneMax);
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarSteelStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarSteelStoneMax.Position;
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  if not boOpened then Exit;
  ScrollBarSilverStoneMax.Max := nPostion - 1;
  g_Config.nBlackStoneMin := nPostion + 1;
  ScrollBarBlackStoneMax.Min := nPostion + 1;
  g_Config.nSteelStoneMax := nPostion;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  EditBlackStoneMax.Text := IntToStr(g_Config.nBlackStoneMin) + '-' + IntToStr(g_Config.nBlackStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarBlackStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarBlackStoneMax.Position;
  EditBlackStoneMax.Text := IntToStr(g_Config.nBlackStoneMin) + '-' + IntToStr(g_Config.nBlackStoneMax);
  if not boOpened then Exit;
  ScrollBarSteelStoneMax.Max := nPostion - 1;
  ScrollBarStoneTypeRate.Min := nPostion;
  g_Config.nBlackStoneMax := nPostion;
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneMinDuraChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneMinDura := EditStoneMinDura.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneGeneralDuraRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneGeneralDuraRate := EditStoneGeneralDuraRate.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneAddDuraRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneAddDuraRate := EditStoneAddDuraRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneAddDuraMaxChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneAddDuraMax := EditStoneAddDuraMax.Value * 1000;
  ModValue();
end;
procedure TfrmFunctionConfig.RefWinLottery;
begin
  ScrollBarWinLotteryRate.Max := 100000;
  ScrollBarWinLotteryRate.Position := g_Config.nWinLotteryRate;
  ScrollBarWinLottery1Max.Max := g_Config.nWinLotteryRate;
  ScrollBarWinLottery1Max.Min := g_Config.nWinLottery1Min;
  ScrollBarWinLottery2Max.Max := g_Config.nWinLottery1Max;
  ScrollBarWinLottery2Max.Min := g_Config.nWinLottery2Min;
  ScrollBarWinLottery3Max.Max := g_Config.nWinLottery2Max;
  ScrollBarWinLottery3Max.Min := g_Config.nWinLottery3Min;
  ScrollBarWinLottery4Max.Max := g_Config.nWinLottery3Max;
  ScrollBarWinLottery4Max.Min := g_Config.nWinLottery4Min;
  ScrollBarWinLottery5Max.Max := g_Config.nWinLottery4Max;
  ScrollBarWinLottery5Max.Min := g_Config.nWinLottery5Min;
  ScrollBarWinLottery6Max.Max := g_Config.nWinLottery5Max;
  ScrollBarWinLottery6Max.Min := g_Config.nWinLottery6Min;
  ScrollBarWinLotteryRate.Min := g_Config.nWinLottery1Max;

  ScrollBarWinLottery1Max.Position := g_Config.nWinLottery1Max;
  ScrollBarWinLottery2Max.Position := g_Config.nWinLottery2Max;
  ScrollBarWinLottery3Max.Position := g_Config.nWinLottery3Max;
  ScrollBarWinLottery4Max.Position := g_Config.nWinLottery4Max;
  ScrollBarWinLottery5Max.Position := g_Config.nWinLottery5Max;
  ScrollBarWinLottery6Max.Position := g_Config.nWinLottery6Max;

  EditWinLottery1Gold.Value := g_Config.nWinLottery1Gold;
  EditWinLottery2Gold.Value := g_Config.nWinLottery2Gold;
  EditWinLottery3Gold.Value := g_Config.nWinLottery3Gold;
  EditWinLottery4Gold.Value := g_Config.nWinLottery4Gold;
  EditWinLottery5Gold.Value := g_Config.nWinLottery5Gold;
  EditWinLottery6Gold.Value := g_Config.nWinLottery6Gold;
end;
procedure TfrmFunctionConfig.ButtonWinLotterySaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'WinLottery1Gold', g_Config.nWinLottery1Gold);
  Config.WriteInteger('Setup', 'WinLottery2Gold', g_Config.nWinLottery2Gold);
  Config.WriteInteger('Setup', 'WinLottery3Gold', g_Config.nWinLottery3Gold);
  Config.WriteInteger('Setup', 'WinLottery4Gold', g_Config.nWinLottery4Gold);
  Config.WriteInteger('Setup', 'WinLottery5Gold', g_Config.nWinLottery5Gold);
  Config.WriteInteger('Setup', 'WinLottery6Gold', g_Config.nWinLottery6Gold);
  Config.WriteInteger('Setup', 'WinLottery1Min', g_Config.nWinLottery1Min);
  Config.WriteInteger('Setup', 'WinLottery1Max', g_Config.nWinLottery1Max);
  Config.WriteInteger('Setup', 'WinLottery2Min', g_Config.nWinLottery2Min);
  Config.WriteInteger('Setup', 'WinLottery2Max', g_Config.nWinLottery2Max);
  Config.WriteInteger('Setup', 'WinLottery3Min', g_Config.nWinLottery3Min);
  Config.WriteInteger('Setup', 'WinLottery3Max', g_Config.nWinLottery3Max);
  Config.WriteInteger('Setup', 'WinLottery4Min', g_Config.nWinLottery4Min);
  Config.WriteInteger('Setup', 'WinLottery4Max', g_Config.nWinLottery4Max);
  Config.WriteInteger('Setup', 'WinLottery5Min', g_Config.nWinLottery5Min);
  Config.WriteInteger('Setup', 'WinLottery5Max', g_Config.nWinLottery5Max);
  Config.WriteInteger('Setup', 'WinLottery6Min', g_Config.nWinLottery6Min);
  Config.WriteInteger('Setup', 'WinLottery6Max', g_Config.nWinLottery6Max);
  Config.WriteInteger('Setup', 'WinLotteryRate', g_Config.nWinLotteryRate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonWinLotteryDefaultClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;


  g_Config.nWinLottery1Gold := 1000000;
  g_Config.nWinLottery2Gold := 200000;
  g_Config.nWinLottery3Gold := 100000;
  g_Config.nWinLottery4Gold := 10000;
  g_Config.nWinLottery5Gold := 1000;
  g_Config.nWinLottery6Gold := 500;
  g_Config.nWinLottery6Min := 1;
  g_Config.nWinLottery6Max := 4999;
  g_Config.nWinLottery5Min := 14000;
  g_Config.nWinLottery5Max := 15999;
  g_Config.nWinLottery4Min := 16000;
  g_Config.nWinLottery4Max := 16149;
  g_Config.nWinLottery3Min := 16150;
  g_Config.nWinLottery3Max := 16169;
  g_Config.nWinLottery2Min := 16170;
  g_Config.nWinLottery2Max := 16179;
  g_Config.nWinLottery1Min := 16180;
  g_Config.nWinLottery1Max := 16185;
  g_Config.nWinLotteryRate := 30000;
  RefWinLottery();
end;

procedure TfrmFunctionConfig.EditWinLottery1GoldChange(Sender: TObject);
begin
  if EditWinLottery1Gold.Text = '' then begin
    EditWinLottery1Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery1Gold := EditWinLottery1Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWinLottery2GoldChange(Sender: TObject);
begin
  if EditWinLottery2Gold.Text = '' then begin
    EditWinLottery2Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery2Gold := EditWinLottery2Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWinLottery3GoldChange(Sender: TObject);
begin
  if EditWinLottery3Gold.Text = '' then begin
    EditWinLottery3Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery3Gold := EditWinLottery3Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery4GoldChange(Sender: TObject);
begin
  if EditWinLottery4Gold.Text = '' then begin
    EditWinLottery4Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery4Gold := EditWinLottery4Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery5GoldChange(Sender: TObject);
begin
  if EditWinLottery5Gold.Text = '' then begin
    EditWinLottery5Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery5Gold := EditWinLottery5Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery6GoldChange(Sender: TObject);
begin
  if EditWinLottery6Gold.Text = '' then begin
    EditWinLottery6Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery6Gold := EditWinLottery6Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery1MaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery1Max.Position;
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  if not boOpened then Exit;
  g_Config.nWinLottery1Max := nPostion;
  ScrollBarWinLottery2Max.Max := nPostion - 1;
  ScrollBarWinLotteryRate.Min := nPostion;
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery2MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery2Max.Position;
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  if not boOpened then Exit;
  g_Config.nWinLottery1Min := nPostion + 1;
  ScrollBarWinLottery1Max.Min := nPostion + 1;
  g_Config.nWinLottery2Max := nPostion;
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery3MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery3Max.Position;
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  if not boOpened then Exit;
  g_Config.nWinLottery2Min := nPostion + 1;
  ScrollBarWinLottery2Max.Min := nPostion + 1;
  g_Config.nWinLottery3Max := nPostion;
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery4MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery4Max.Position;
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  if not boOpened then Exit;
  g_Config.nWinLottery3Min := nPostion + 1;
  ScrollBarWinLottery3Max.Min := nPostion + 1;
  g_Config.nWinLottery4Max := nPostion;
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery5MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery5Max.Position;
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  if not boOpened then Exit;
  g_Config.nWinLottery4Min := nPostion + 1;
  ScrollBarWinLottery4Max.Min := nPostion + 1;
  g_Config.nWinLottery5Max := nPostion;
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery6MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery6Max.Position;
  EditWinLottery6Max.Text := IntToStr(g_Config.nWinLottery6Min) + '-' + IntToStr(g_Config.nWinLottery6Max);
  if not boOpened then Exit;
  g_Config.nWinLottery5Min := nPostion + 1;
  ScrollBarWinLottery5Max.Min := nPostion + 1;
  g_Config.nWinLottery6Max := nPostion;
  EditWinLottery6Max.Text := IntToStr(g_Config.nWinLottery6Min) + '-' + IntToStr(g_Config.nWinLottery6Max);
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  ModValue();

end;

procedure TfrmFunctionConfig.ScrollBarWinLotteryRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLotteryRate.Position;
  EditWinLotteryRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  ScrollBarWinLottery1Max.Max := nPostion;
  g_Config.nWinLotteryRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.RefReNewLevelConf();
begin
  EditReNewNameColor1.Value := g_Config.ReNewNameColor[0];
  EditReNewNameColor2.Value := g_Config.ReNewNameColor[1];
  EditReNewNameColor3.Value := g_Config.ReNewNameColor[2];
  EditReNewNameColor4.Value := g_Config.ReNewNameColor[3];
  EditReNewNameColor5.Value := g_Config.ReNewNameColor[4];
  EditReNewNameColor6.Value := g_Config.ReNewNameColor[5];
  EditReNewNameColor7.Value := g_Config.ReNewNameColor[6];
  EditReNewNameColor8.Value := g_Config.ReNewNameColor[7];
  EditReNewNameColor9.Value := g_Config.ReNewNameColor[8];
  EditReNewNameColor10.Value := g_Config.ReNewNameColor[9];
  EditReNewNameColorTime.Value := g_Config.dwReNewNameColorTime div 1000;
  CheckBoxReNewChangeColor.Checked := g_Config.boReNewChangeColor;
  CheckBoxReNewLevelClearExp.Checked := g_Config.boReNewLevelClearExp;
end;

procedure TfrmFunctionConfig.ButtonReNewLevelSaveClick(Sender: TObject);
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
{$IFEND}
begin
{$IF SoftVersion <> VERDEMO}
  for I := Low(g_Config.ReNewNameColor) to High(g_Config.ReNewNameColor) do begin
    Config.WriteInteger('Setup', 'ReNewNameColor' + IntToStr(I), g_Config.ReNewNameColor[I]);
  end;
  Config.WriteInteger('Setup', 'ReNewNameColorTime', g_Config.dwReNewNameColorTime);
  Config.WriteBool('Setup', 'ReNewChangeColor', g_Config.boReNewChangeColor);
  Config.WriteBool('Setup', 'ReNewLevelClearExp', g_Config.boReNewLevelClearExp);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor1Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor1.Value;
  LabelReNewNameColor1.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[0] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor2Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor2.Value;
  LabelReNewNameColor2.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[1] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor3Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor3.Value;
  LabelReNewNameColor3.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[2] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor4Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor4.Value;
  LabelReNewNameColor4.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[3] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor5Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor5.Value;
  LabelReNewNameColor5.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[4] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor6Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor6.Value;
  LabelReNewNameColor6.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[5] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor7Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor7.Value;
  LabelReNewNameColor7.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[6] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor8Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor8.Value;
  LabelReNewNameColor8.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[7] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor9Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor9.Value;
  LabelReNewNameColor9.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[8] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor10Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor10.Value;
  LabelReNewNameColor10.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[9] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColorTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwReNewNameColorTime := EditReNewNameColorTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.RefMonUpgrade();
begin
  EditMonUpgradeColor1.Value := g_Config.SlaveColor[0];
  EditMonUpgradeColor2.Value := g_Config.SlaveColor[1];
  EditMonUpgradeColor3.Value := g_Config.SlaveColor[2];
  EditMonUpgradeColor4.Value := g_Config.SlaveColor[3];
  EditMonUpgradeColor5.Value := g_Config.SlaveColor[4];
  EditMonUpgradeColor6.Value := g_Config.SlaveColor[5];
  EditMonUpgradeColor7.Value := g_Config.SlaveColor[6];
  EditMonUpgradeColor8.Value := g_Config.SlaveColor[7];
  EditMonUpgradeColor9.Value := g_Config.SlaveColor[8];
  EditMonUpgradeKillCount1.Value := g_Config.MonUpLvNeedKillCount[0];
  EditMonUpgradeKillCount2.Value := g_Config.MonUpLvNeedKillCount[1];
  EditMonUpgradeKillCount3.Value := g_Config.MonUpLvNeedKillCount[2];
  EditMonUpgradeKillCount4.Value := g_Config.MonUpLvNeedKillCount[3];
  EditMonUpgradeKillCount5.Value := g_Config.MonUpLvNeedKillCount[4];
  EditMonUpgradeKillCount6.Value := g_Config.MonUpLvNeedKillCount[5];
  EditMonUpgradeKillCount7.Value := g_Config.MonUpLvNeedKillCount[6];
  EditMonUpLvNeedKillBase.Value := g_Config.nMonUpLvNeedKillBase;
  EditMonUpLvRate.Value := g_Config.nMonUpLvRate;

  CheckBoxMasterDieMutiny.Checked := g_Config.boMasterDieMutiny;
  EditMasterDieMutinyRate.Value := g_Config.nMasterDieMutinyRate;
  EditMasterDieMutinyPower.Value := g_Config.nMasterDieMutinyPower;
  EditMasterDieMutinySpeed.Value := g_Config.nMasterDieMutinySpeed;

  CheckBoxMasterDieMutinyClick(CheckBoxMasterDieMutiny);

  CheckBoxBBMonAutoChangeColor.Checked := g_Config.boBBMonAutoChangeColor;
  EditBBMonAutoChangeColorTime.Value := g_Config.dwBBMonAutoChangeColorTime div 1000;
end;

procedure TfrmFunctionConfig.ButtonMonUpgradeSaveClick(Sender: TObject);
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
{$IFEND}
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MonUpLvNeedKillBase', g_Config.nMonUpLvNeedKillBase);
  Config.WriteInteger('Setup', 'MonUpLvRate', g_Config.nMonUpLvRate);
  for I := Low(g_Config.MonUpLvNeedKillCount) to High(g_Config.MonUpLvNeedKillCount) do begin
    Config.WriteInteger('Setup', 'MonUpLvNeedKillCount' + IntToStr(I), g_Config.MonUpLvNeedKillCount[I]);
  end;

  for I := Low(g_Config.SlaveColor) to High(g_Config.SlaveColor) do begin
    Config.WriteInteger('Setup', 'SlaveColor' + IntToStr(I), g_Config.SlaveColor[I]);
  end;
  Config.WriteBool('Setup', 'MasterDieMutiny', g_Config.boMasterDieMutiny);
  Config.WriteInteger('Setup', 'MasterDieMutinyRate', g_Config.nMasterDieMutinyRate);
  Config.WriteInteger('Setup', 'MasterDieMutinyPower', g_Config.nMasterDieMutinyPower);
  Config.WriteInteger('Setup', 'MasterDieMutinyPower', g_Config.nMasterDieMutinySpeed);

  Config.WriteBool('Setup', 'BBMonAutoChangeColor', g_Config.boBBMonAutoChangeColor);
  Config.WriteInteger('Setup', 'BBMonAutoChangeColorTime', g_Config.dwBBMonAutoChangeColorTime);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor1Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor1.Value;
  LabelMonUpgradeColor1.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[0] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor2Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor2.Value;
  LabelMonUpgradeColor2.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[1] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor3Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor3.Value;
  LabelMonUpgradeColor3.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[2] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor4Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor4.Value;
  LabelMonUpgradeColor4.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[3] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor5Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor5.Value;
  LabelMonUpgradeColor5.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[4] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor6Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor6.Value;
  LabelMonUpgradeColor6.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[5] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor7Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor7.Value;
  LabelMonUpgradeColor7.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[6] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor8Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor8.Value;
  LabelMonUpgradeColor8.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[7] := btColor;
  ModValue();
end;
procedure TfrmFunctionConfig.EditMonUpgradeColor9Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor9.Value;
  LabelMonUpgradeColor9.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[8] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxReNewChangeColorClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boReNewChangeColor := CheckBoxReNewChangeColor.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxReNewLevelClearExpClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boReNewLevelClearExp := CheckBoxReNewLevelClearExp.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKFlagNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKFlagNameColor.Value;
  LabelPKFlagNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btPKFlagNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKLevel1NameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKLevel1NameColor.Value;
  LabelPKLevel1NameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btPKLevel1NameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKLevel2NameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKLevel2NameColor.Value;
  LabelPKLevel2NameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btPKLevel2NameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditAllyAndGuildNameColorChange(
  Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditAllyAndGuildNameColor.Value;
  LabelAllyAndGuildNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btAllyAndGuildNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWarGuildNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditWarGuildNameColor.Value;
  LabelWarGuildNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btWarGuildNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditInFreePKAreaNameColorChange(
  Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditInFreePKAreaNameColor.Value;
  LabelInFreePKAreaNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btInFreePKAreaNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount1Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[0] := EditMonUpgradeKillCount1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount2Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[1] := EditMonUpgradeKillCount2.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount3Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[2] := EditMonUpgradeKillCount3.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount4Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[3] := EditMonUpgradeKillCount4.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount5Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[4] := EditMonUpgradeKillCount5.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount6Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[5] := EditMonUpgradeKillCount6.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount7Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[6] := EditMonUpgradeKillCount7.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpLvNeedKillBaseChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonUpLvNeedKillBase := EditMonUpLvNeedKillBase.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpLvRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonUpLvRate := EditMonUpLvRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMasterDieMutinyClick(Sender: TObject);
begin
  if CheckBoxMasterDieMutiny.Checked then begin
    EditMasterDieMutinyRate.Enabled := True;
    EditMasterDieMutinyPower.Enabled := True;
    EditMasterDieMutinySpeed.Enabled := True;
  end else begin
    EditMasterDieMutinyRate.Enabled := False;
    EditMasterDieMutinyPower.Enabled := False;
    EditMasterDieMutinySpeed.Enabled := False;
  end;
  if not boOpened then Exit;
  g_Config.boMasterDieMutiny := CheckBoxMasterDieMutiny.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinyRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMasterDieMutinyRate := EditMasterDieMutinyRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinyPowerChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMasterDieMutinyPower := EditMasterDieMutinyPower.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinySpeedChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMasterDieMutinySpeed := EditMasterDieMutinySpeed.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxBBMonAutoChangeColorClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boBBMonAutoChangeColor := CheckBoxBBMonAutoChangeColor.Checked;
  ModValue();
end;


procedure TfrmFunctionConfig.EditBBMonAutoChangeColorTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwBBMonAutoChangeColorTime := EditBBMonAutoChangeColorTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.RefSpiritMutiny();
begin
  CheckBoxSpiritMutiny.Checked := g_Config.boSpiritMutiny;
  EditSpiritMutinyTime.Value := g_Config.dwSpiritMutinyTime div 60000{(60 * 1000)};
  //EditSpiritPowerRate.Value := g_Config.nSpiritPowerRate;//20080504 未使用  祈祷能量倍数
  CheckBoxSpiritMutinyClick(CheckBoxSpiritMutiny);
end;
procedure TfrmFunctionConfig.ButtonSpiritMutinySaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'SpiritMutiny', g_Config.boSpiritMutiny);
  Config.WriteInteger('Setup', 'SpiritMutinyTime', g_Config.dwSpiritMutinyTime);
  //Config.WriteInteger('Setup', 'SpiritPowerRate', g_Config.nSpiritPowerRate);//20080504 未使用  祈祷能量倍数
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxSpiritMutinyClick(Sender: TObject);
begin
  if CheckBoxSpiritMutiny.Checked then begin
    EditSpiritMutinyTime.Enabled := True;
    //    EditSpiritPowerRate.Enabled:=True;
  end else begin
    EditSpiritMutinyTime.Enabled := False;
    EditSpiritPowerRate.Enabled := False;
  end;
  if not boOpened then Exit;
  g_Config.boSpiritMutiny := CheckBoxSpiritMutiny.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSpiritMutinyTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwSpiritMutinyTime := EditSpiritMutinyTime.Value * 60000{60 * 1000};
  ModValue();
end;
//祈祷能量倍数,未使用
procedure TfrmFunctionConfig.EditSpiritPowerRateChange(Sender: TObject);
begin
{  if not boOpened then Exit;
  g_Config.nSpiritPowerRate := EditSpiritPowerRate.Value;
  ModValue(); }
end;

procedure TfrmFunctionConfig.EditMagTammingLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingLevel := EditMagTammingLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTammingTargetLevelChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingTargetLevel := EditMagTammingTargetLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTammingHPRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingHPRate := EditMagTammingHPRate.Value;
  ModValue();
end;


procedure TfrmFunctionConfig.EditTammingCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingCount := EditTammingCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitRandRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitRandRate := EditMabMabeHitRandRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitMinLvLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitMinLvLimit := EditMabMabeHitMinLvLimit.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitSucessRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitSucessRate := EditMabMabeHitSucessRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitMabeTimeRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitMabeTimeRate := EditMabMabeHitMabeTimeRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.RefMonSayMsg;
begin
  CheckBoxMonSayMsg.Checked := g_Config.boMonSayMsg;
end;

procedure TfrmFunctionConfig.ButtonMonSayMsgSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'MonSayMsg', g_Config.boMonSayMsg);
{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.CheckBoxMonSayMsgClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boMonSayMsg := CheckBoxMonSayMsg.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RefWeaponMakeLuck;
begin
  ScrollBarWeaponMakeUnLuckRate.Min := 1;
  ScrollBarWeaponMakeUnLuckRate.Max := 50;
  ScrollBarWeaponMakeUnLuckRate.Position := g_Config.nWeaponMakeUnLuckRate;

  ScrollBarWeaponMakeLuckPoint1.Min := 1;
  ScrollBarWeaponMakeLuckPoint1.Max := 10;
  ScrollBarWeaponMakeLuckPoint1.Position := g_Config.nWeaponMakeLuckPoint1;

  ScrollBarWeaponMakeLuckPoint2.Min := 1;
  ScrollBarWeaponMakeLuckPoint2.Max := 10;
  ScrollBarWeaponMakeLuckPoint2.Position := g_Config.nWeaponMakeLuckPoint2;

  ScrollBarWeaponMakeLuckPoint3.Min := 1;
  ScrollBarWeaponMakeLuckPoint3.Max := 10;
  ScrollBarWeaponMakeLuckPoint3.Position := g_Config.nWeaponMakeLuckPoint3;

  ScrollBarWeaponMakeLuckPoint2Rate.Min := 1;
  ScrollBarWeaponMakeLuckPoint2Rate.Max := 50;
  ScrollBarWeaponMakeLuckPoint2Rate.Position := g_Config.nWeaponMakeLuckPoint2Rate;

  ScrollBarWeaponMakeLuckPoint3Rate.Min := 1;
  ScrollBarWeaponMakeLuckPoint3Rate.Max := 50;
  ScrollBarWeaponMakeLuckPoint3Rate.Position := g_Config.nWeaponMakeLuckPoint3Rate;
end;

procedure TfrmFunctionConfig.ButtonWeaponMakeLuckDefaultClick(
  Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;
  g_Config.nWeaponMakeUnLuckRate := 20;
  g_Config.nWeaponMakeLuckPoint1 := 1;
  g_Config.nWeaponMakeLuckPoint2 := 3;
  g_Config.nWeaponMakeLuckPoint3 := 7;
  g_Config.nWeaponMakeLuckPoint2Rate := 6;
  g_Config.nWeaponMakeLuckPoint3Rate := 40;
  RefWeaponMakeLuck();
end;

procedure TfrmFunctionConfig.ButtonWeaponMakeLuckSaveClick(
  Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'WeaponMakeUnLuckRate', g_Config.nWeaponMakeUnLuckRate);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint1', g_Config.nWeaponMakeLuckPoint1);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint2', g_Config.nWeaponMakeLuckPoint2);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint3', g_Config.nWeaponMakeLuckPoint3);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint2Rate', g_Config.nWeaponMakeLuckPoint2Rate);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint3Rate', g_Config.nWeaponMakeLuckPoint3Rate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeUnLuckRateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeUnLuckRate.Position;
  EditWeaponMakeUnLuckRate.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeUnLuckRate := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint1Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint1.Position;
  EditWeaponMakeLuckPoint1.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint1 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint2.Position;
  EditWeaponMakeLuckPoint2.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint2 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2RateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint2Rate.Position;
  EditWeaponMakeLuckPoint2Rate.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint2Rate := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint3.Position;
  EditWeaponMakeLuckPoint3.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint3 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3RateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint3Rate.Position;
  EditWeaponMakeLuckPoint3Rate.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint3Rate := nInteger;
  ModValue();
end;

//每次扣多少元宝(元宝寄售) 20080319
procedure TfrmFunctionConfig.EdtDecUserGameGoldChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecUserGameGold := EdtDecUserGameGold.Value;
  ModValue();
end;
 //20080504 去掉拍卖功能
procedure TfrmFunctionConfig.SpinEditSellOffCountChange(Sender: TObject);
begin
{  if not boOpened then Exit;
  g_Config.nUserSellOffCount := SpinEditSellOffCount.Value;
  ModValue(); }
end;
 //20080504 去掉拍卖功能
procedure TfrmFunctionConfig.SpinEditSellOffTaxChange(Sender: TObject);
begin
{  if not boOpened then Exit;
  g_Config.nUserSellOffTax := SpinEditSellOffTax.Value;
  ModValue();}
end;

procedure TfrmFunctionConfig.ButtonSellOffSaveClick(Sender: TObject);
begin
 // Config.WriteInteger('Setup', 'SellOffCountLimit', g_Config.nUserSellOffCount); //20080504 去掉拍卖功能
 // Config.WriteInteger('Setup', 'SellOffRate', g_Config.nUserSellOffTax); //20080504 去掉拍卖功能
  Config.WriteInteger('Setup', 'DecUserGameGold', g_Config.nDecUserGameGold);//每次扣多少元宝(元宝寄售) 20080319
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPullPlayObjectClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boPullPlayObject := CheckBoxPullPlayObject.Checked;
  CheckBoxPullCrossInSafeZone.Enabled := CheckBoxPullPlayObject.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPlayObjectReduceMPClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boPlayObjectReduceMP := CheckBoxPlayObjectReduceMP.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxGroupMbAttackSlaveClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boGroupMbAttackSlave := CheckBoxGroupMbAttackSlave.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxItemNameClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boChangeUseItemNameByPlayName := CheckBoxItemName.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditItemNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sChangeUseItemName := Trim(EditItemName.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonChangeUseItemNameClick(Sender: TObject);
begin
  {if (not CheckBoxItemName.Checked) and (g_Config.sChangeUseItemName = '') then begin
    Application.MessageBox('请输入自定义前缀', '提示信息', MB_ICONQUESTION);
    Exit;
  end;}
  Config.WriteBool('Setup', 'ChangeUseItemNameByPlayName', g_Config.boChangeUseItemNameByPlayName);
  Config.WriteString('Setup', 'ChangeUseItemName', g_Config.sChangeUseItemName);
  uModValue();
end;

procedure TfrmFunctionConfig.SpinEditSkill39SecChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDedingUseTime := SpinEditSkill39Sec.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxDedingAllowPKClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boDedingAllowPK := CheckBoxDedingAllowPK.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditAllowCopyCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAllowCopyHumanCount := SpinEditAllowCopyCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditCopyHumNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumName := EditCopyHumName.Text;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMasterNameClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAddMasterName := CheckBoxMasterName.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditPickUpItemCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumanBagCount := SpinEditPickUpItemCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditEatHPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumAddHPRate := SpinEditEatHPItemRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditEatMPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumAddMPRate := SpinEditEatMPItemRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFireDelayTimeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireDelayTimeRate := SpinEditFireDelayTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFirePowerClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFirePowerRate := SpinEditFirePower.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditBagItems1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumBagItems1 := Trim(EditBagItems1.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.EditBagItems2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumBagItems2 := Trim(EditBagItems2.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.EditBagItems3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumBagItems3 := Trim(EditBagItems3.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAllowGuardAttackClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowGuardAttack := CheckBoxAllowGuardAttack.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RefCopyHumConf;
begin
  EditCopyHumNameColor.Value := g_Config.nCopyHumNameColor;//分身名字颜色 20080404
  SpinEditAllowCopyCount.Value := g_Config.nAllowCopyHumanCount;
  EditCopyHumName.Text := g_Config.sCopyHumName;
  CheckBoxMasterName.Checked := g_Config.boAddMasterName;
  SpinEditPickUpItemCount.Value := g_Config.nCopyHumanBagCount;
  SpinEditEatHPItemRate.Value := g_Config.nCopyHumAddHPRate;
  SpinEditEatMPItemRate.Value := g_Config.nCopyHumAddMPRate;
  EditBagItems1.Text := g_Config.sCopyHumBagItems1;
  EditBagItems2.Text := g_Config.sCopyHumBagItems2;
  EditBagItems3.Text := g_Config.sCopyHumBagItems3;
  CheckBoxAllowGuardAttack.Checked := g_Config.boAllowGuardAttack;
  SpinEditWarrorAttackTime.Value := g_Config.dwWarrorAttackTime;
  SpinEditWizardAttackTime.Value := g_Config.dwWizardAttackTime;
  SpinEditTaoistAttackTime.Value := g_Config.dwTaoistAttackTime;

  CheckBoxAllowReCallMobOtherHum.Checked := g_Config.boAllowReCallMobOtherHum;
  CheckBoxNeedLevelHighTarget.Checked := g_Config.boNeedLevelHighTarget;
  CheckBoxNeedLevelHighTarget.Enabled := g_Config.boAllowReCallMobOtherHum;
end;

procedure TfrmFunctionConfig.SpinEditWarrorAttackTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwWarrorAttackTime := SpinEditWarrorAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditWizardAttackTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwWizardAttackTime := SpinEditWizardAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditTaoistAttackTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwTaoistAttackTime := SpinEditTaoistAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAllowReCallMobOtherHumClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowReCallMobOtherHum := CheckBoxAllowReCallMobOtherHum.Checked;
  CheckBoxNeedLevelHighTarget.Enabled := g_Config.boAllowReCallMobOtherHum;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxNeedLevelHighTargetClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNeedLevelHighTarget := CheckBoxNeedLevelHighTarget.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPullCrossInSafeZoneClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boPullCrossInSafeZone := CheckBoxPullCrossInSafeZone.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxStartMapEventClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boStartMapEvent := CheckBoxStartMapEvent.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditDidingPowerRateClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDidingPowerRate := SpinEditDidingPowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.FairyNameEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinFairyEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFairyCount := SpinFairyEdt.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.GridFairySetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinFairyDuntRateEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFairyDuntRate := SpinFairyDuntRateEdt.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinFairyAttackRateEdtChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFairyAttackRate := SpinFairyAttackRateEdt.Value;
  ModValue();
end;

//------------------------------------------------------------------------------
//护体神盾 20080108
procedure TfrmFunctionConfig.EditProtectionDefenceTimeChange(
  Sender: TObject);             
begin
  if not boOpened then Exit;
  g_Config.nProtectionDefenceTime := EditProtectionDefenceTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditProtectionTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwProtectionTick := EditProtectionTick.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditProtectionRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nProtectionRate := EditProtectionRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditProtectionBadRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nProtectionBadRate := EditProtectionBadRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckRushkungBadClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.RushkungBadProtection :=CheckRushkungBad.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckErgumBadClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.ErgumBadProtection :=CheckErgumBad.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckFirehitBadClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.FirehitBadProtection :=CheckFirehitBad.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckTwnhitBadClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.TwnhitBadProtection :=CheckTwnhitBad.Checked;
  ModValue();
end;
//-----------------------------------------------------------------------------
//龙影剑法使用间隔 20080204
procedure TfrmFunctionConfig.SpinEditKill42SecChange(Sender: TObject);
begin
  if not boOpened then Exit; //20080619 注释
  g_Config.nKill42UseTime := SpinEditKill42Sec.Value;
  ModValue();
end;

//黄条气槽 20080201
procedure TfrmFunctionConfig.EditDecDragonPointChange(Sender: TObject);
begin

end;
//龙影剑法威力 20080213
procedure TfrmFunctionConfig.SpinEditAttackRate_2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackRate_42 := SpinEditAttackRate_42.Value;
  ModValue();
end;
//龙影剑法范围 20080218
procedure TfrmFunctionConfig.EditMagicAttackRage_42Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagicAttackRage_42 := EditMagicAttackRage_42.Value;
  ModValue();
end;
//-----------------------------------------------------------------------------
//开天斩使用间隔 20080204
procedure TfrmFunctionConfig.SpinEditKill43SecChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nKill43UseTime := SpinEditKill43Sec.Value;
  ModValue();
end;
//分身使用时长 20080404
procedure TfrmFunctionConfig.SpinEditMakeSelfTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeSelfTick := SpinEditMakeSelfTick.Value;
  ModValue();
end;
//召唤分身间隔 20080204
procedure TfrmFunctionConfig.SpinEditnCopyHumanTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumanTick := SpinEditnCopyHumanTick.Value;
  ModValue();
end;
//开天斩重击几率 20080213
procedure TfrmFunctionConfig.Spin43KillHitRateEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.n43KillHitRate := Spin43KillHitRateEdt.Value;
  ModValue();
end;
//开天斩重击倍数  20080213
procedure TfrmFunctionConfig.Spin43KillAttackRateEdtChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.n43KillAttackRate := Spin43KillAttackRateEdt.Value;
  ModValue();
end;
//开天斩威力 20080213
procedure TfrmFunctionConfig.SpinEditAttackRate_43Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackRate_43 := SpinEditAttackRate_43.Value;
  ModValue();
end;
//显示护体神盾效果 20080328
procedure TfrmFunctionConfig.ShowProtectionEnvClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boShowProtectionEnv := ShowProtectionEnv.Checked;
  ModValue();
end;
//自动使用神盾 20080328
procedure TfrmFunctionConfig.AutoProtectionClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAutoProtection := AutoProtection.Checked;
  ModValue();
end;
//分身名字颜色 20080404
procedure TfrmFunctionConfig.EditCopyHumNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditCopyHumNameColor.Value;
  LabelCopyHumNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.nCopyHumNameColor := btColor;
  ModValue();
end;

//智能锁定 20080418
procedure TfrmFunctionConfig.AutoCanHitClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAutoCanHit := AutoCanHit.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMeteorFireRainRageChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMeteorFireRainRage := EditMeteorFireRainRage.Value;
  ModValue();
end;
//噬血术加血百分率 20080511
procedure TfrmFunctionConfig.EditMagFireCharmTreatmentChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagFireCharmTreatment := EditMagFireCharmTreatment.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditAttackRate_74Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackRate_74 := SpinEditAttackRate_74.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockCallHeroClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockCallHeroAction := CheckBoxLockCallHero.Checked;
  ModValue();
end;
//可收徒弟数 20080530
procedure TfrmFunctionConfig.EditMasterCountChange(Sender: TObject);
begin
  if EditMasterCount.Text = '' then begin
    EditMasterCount.Text := '1';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterCount := EditMasterCount.Value;
  ModValue();
end;
//无极真气使用间隔 20080603
procedure TfrmFunctionConfig.EditAbilityUpTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAbilityUpTick := EditAbilityUpTick.Value;
  ModValue();
end;
//无极真气使用时长 20080603
procedure TfrmFunctionConfig.SpinEditAbilityUpUseTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAbilityUpUseTime := SpinEditAbilityUpUseTime.Value;
  ModValue();
end;
//移行换位使用间隔 20080616
procedure TfrmFunctionConfig.SpinEditMagChangXYChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwMagChangXYTick := SpinEditMagChangXY.Value * 1000;
  ModValue();
end;
//酿酒等待时间 20080621
procedure TfrmFunctionConfig.SpinEditMakeWineTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeWineTime := SpinEditMakeWineTime.Value;
  ModValue();
end;
//酿药酒等待时间 20080621
procedure TfrmFunctionConfig.SpinEditMakeWineTime1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeWineTime1 := SpinEditMakeWineTime1.Value;
  ModValue();
end;
//酿酒获得酒曲机率 20080621
procedure TfrmFunctionConfig.SpinEditMakeWineRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeWineRate := SpinEditMakeWineRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSaveMakeWineClick(Sender: TObject);
var
  I: Integer;
  dwExp: LongWord;
  NeedExps: TLevelNeedExp1;
begin
  for I := 1 to GridMedicineExp.RowCount - 1 do begin
    dwExp := Str_ToInt(GridMedicineExp.Cells[1, I], 0);
    if (dwExp <= 0) then begin//20080522
      Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 药力值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridMedicineExp.Row := I;
      GridMedicineExp.SetFocus;
      Exit;
    end;
    NeedExps[I] := dwExp;
  end;
  g_Config.dwMedicineNeedExps := NeedExps;
  for I := 1 to 1000 do begin
    Config.WriteString('MedicineExp', 'Level' + IntToStr(I), IntToStr(g_Config.dwMedicineNeedExps[I]));
  end;
  Config.WriteInteger('Setup', 'MinGuildFountain', g_Config.nMinGuildFountain);//行会酒泉蓄量少于时,不能领取 20080627
  Config.WriteInteger('Setup', 'DecGuildFountain', g_Config.nDecGuildFountain);//行会成员领取酒泉,蓄量减少 20080627
  Config.WriteInteger('Setup', 'InFountainTime', g_Config.nInFountainTime);//站在泉眼上的累积时间(秒) 20080624
  Config.WriteInteger('Setup', 'DesMedicineTick', g_Config.nDesMedicineTick);////减药力值时间间隔 20080624
  Config.WriteInteger('Setup', 'DesMedicineValue', g_Config.nDesMedicineValue);//长时间不使用酒,减药力值 20080623
  Config.WriteInteger('Setup', 'MakeWineTime', g_Config.nMakeWineTime);//酿普通酒等待时间 20080621
  Config.WriteInteger('Setup', 'MakeWineTime1', g_Config.nMakeWineTime1);//酿药酒等待时间 20080621
  Config.WriteInteger('Setup', 'MakeWineRate', g_Config.nMakeWineRate);//酿酒获得酒曲机率 20080621
  Config.WriteInteger('Setup', 'IncAlcoholTick', g_Config.nIncAlcoholTick);//增加酒量进度的间隔时间 20080623
  Config.WriteInteger('Setup', 'DesDrinkTick', g_Config.nDesDrinkTick);//减少醉酒度的间隔时间 20080623
  Config.WriteInteger('Setup', 'MaxAlcoholValue', g_Config.nMaxAlcoholValue);//酒量上限初始值 20080623
  Config.WriteInteger('Setup', 'IncAlcoholValue', g_Config.nIncAlcoholValue);//升级后增加酒量上限值 20080623
  uModValue();
end;

//增加酒量进度的间隔时间 20080623
procedure TfrmFunctionConfig.SpinEditIncAlcoholTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nIncAlcoholTick := SpinEditIncAlcoholTick.Value;
  ModValue();
end;
//减少醉酒度的间隔时间 20080623
procedure TfrmFunctionConfig.SpinEditDesDrinkTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDesDrinkTick := SpinEditDesDrinkTick.Value;
  ModValue();
end;
//酒量上限初始值 20080623
procedure TfrmFunctionConfig.SpinEditMaxAlcoholValueChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMaxAlcoholValue := SpinEditMaxAlcoholValue.Value;
  ModValue();
end;
//升级后增加酒量上限值 20080623
procedure TfrmFunctionConfig.SpinEditIncAlcoholValueChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nIncAlcoholValue := SpinEditIncAlcoholValue.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.GridMedicineExpEnter(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;
//长时间不使用酒,减药力值 20080623
procedure TfrmFunctionConfig.SpinEditDesMedicineValueChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDesMedicineValue := SpinEditDesMedicineValue.Value;
  ModValue();
end;
//减药力值时间间隔 20080624
procedure TfrmFunctionConfig.SpinEditDesMedicineTickChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDesMedicineTick := SpinEditDesMedicineTick.Value;
  ModValue();
end;
//站在泉眼上的累积时间(秒) 20080624
procedure TfrmFunctionConfig.SpinEditInFountainTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nInFountainTime := SpinEditInFountainTime.Value;
  ModValue();
end;
//酒气护体使用间隔 20080625
procedure TfrmFunctionConfig.SpinEditHPUpTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHPUpTick := SpinEditHPUpTick.Value;
  ModValue();
end;

//酒气护体增加使用时长 20080625
procedure TfrmFunctionConfig.SpinEditHPUpUseTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHPUpUseTime := SpinEditHPUpUseTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.GridSkill68Enter(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

//先天元力失效酒量下限比例 20080626
procedure TfrmFunctionConfig.SpinEditMinDrinkValue67Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMinDrinkValue67 := SpinEditMinDrinkValue67.Value;
  ModValue();
end;

//酒气护体失效酒量下限比例 20080626
procedure TfrmFunctionConfig.SpinEditMinDrinkValue68Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMinDrinkValue68 := SpinEditMinDrinkValue68.Value;
  ModValue();
end;
//行会酒泉蓄量少于时,不能领取 20080627
procedure TfrmFunctionConfig.SpinEditMinGuildFountainChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMinGuildFountain := SpinEditMinGuildFountain.Value;
  ModValue();
end;
//行会成员领取酒泉,蓄量减少 20080627
procedure TfrmFunctionConfig.SpinEditDecGuildFountainChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecGuildFountain := SpinEditDecGuildFountain.Value;
  ModValue();
end;
//挑战时间 20080706
procedure TfrmFunctionConfig.SpinEditChallengeTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nChallengeTime := SpinEditChallengeTime.Value ;
  ModValue();
end;

//宝宝是否飞到主人身边 20080713
procedure TfrmFunctionConfig.CheckSlaveMoveMasterClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boSlaveMoveMaster := CheckSlaveMoveMaster.Checked;
  ModValue();
end;

//人物名是否显示行会信息  20080726
procedure TfrmFunctionConfig.CheckBoxShowGuildNameClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boShowGuildName := CheckBoxShowGuildName.Checked;
  ModValue();
end;

//--------------------------气血石配置------------------------------
procedure TfrmFunctionConfig.SpinEditStartHPRockChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStartHPRock := SpinEditStartHPRock.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditHPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHPRockSpell := SpinEditHPRockSpell.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditRockAddHPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRockAddHP := SpinEditRockAddHP.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditHPRockDecDuraChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHPRockDecDura := SpinEditHPRockDecDura.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditStartMPRockChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStartMPRock := SpinEditStartMPRock.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditMPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMPRockSpell := SpinEditMPRockSpell.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditRockAddMPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRockAddMP := SpinEditRockAddMP.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditMPRockDecDuraChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMPRockDecDura := SpinEditMPRockDecDura.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditStartHPMPRockChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStartHPMPRock := SpinEditStartHPMPRock.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditHPMPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHPMPRockSpell := SpinEditHPMPRockSpell.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditRockAddHPMPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRockAddHPMP := SpinEditRockAddHPMP.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditHPMPRockDecDuraChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHPMPRockDecDura := SpinEditHPMPRockDecDura.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.RadioboSkill31EffectFalseClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boSkill31Effect :=not RadioboSkill31EffectFalse.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RadioboSkill31EffectTrueClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boSkill31Effect := RadioboSkill31EffectTrue.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditSkill66RateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill66Rate := SpinEditSkill66Rate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditProtectionOKRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nProtectionOKRate := EditProtectionOKRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditSkill69NGChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill69NG := SpinEditSkill69NG.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditSkill69NGExpChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill69NGExp := SpinEditSkill69NGExp.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditHeroSkill69NGExpChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill69NGExp := SpinEditHeroSkill69NGExp.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditdwIncNHTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwIncNHTime := SpinEditdwIncNHTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditDrinkIncNHExpChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDrinkIncNHExp := SpinEditDrinkIncNHExp.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditHitStruckDecNHChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHitStruckDecNH := SpinEditHitStruckDecNH.Value;
  ModValue();
end;

//无极真气使用固定时长 20081109
procedure TfrmFunctionConfig.SpinEditAbilityUpFixUseTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAbilityUpFixUseTime := SpinEditAbilityUpFixUseTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAbilityUpFixModeClick(
  Sender: TObject);
var
  boStatus: Boolean;
begin
  boStatus := CheckBoxAbilityUpFixMode.Checked;
  SpinEditAbilityUpFixUseTime.Enabled := boStatus;
  SpinEditAbilityUpUseTime.Enabled := not boStatus;
  if not boOpened then Exit;
  g_Config.boAbilityUpFixMode := boStatus;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditAttackRate_26Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackRate_26 := SpinEditAttackRate_26.Value;
  ModValue();
end;
//杀怪内功经验倍数 20081215
procedure TfrmFunctionConfig.EditKillMonNGExpMultipleChange(
  Sender: TObject);
begin
  if EditKillMonNGExpMultiple.Text = '' then begin
    EditKillMonNGExpMultiple.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.dwKillMonNGExpMultiple := EditKillMonNGExpMultiple.Value;
  ModValue();
end;
//NPC名字颜色 20081218
procedure TfrmFunctionConfig.SpinEditNPCNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := SpinEditNPCNameColor.Value;
  LabelNPCNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btNPCNameColor := btColor;
  ModValue();
end;

//内功技能增强的攻防比率 20081223
procedure TfrmFunctionConfig.SpinEditNGSkillRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNGSkillRate := SpinEditNGSkillRate.Value;
  ModValue();
end;
//内功等级增加攻防的级数比率 20081223
procedure TfrmFunctionConfig.SpinEditNGLevelDamageChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNGLevelDamage := SpinEditNGLevelDamage.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditOrdinarySkill66RateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nOrdinarySkill66Rate := SpinEditOrdinarySkill66Rate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFairyDuntRateBelowChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFairyDuntRateBelow := SpinEditFairyDuntRateBelow.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFunctionConfig.FormDestroy(Sender: TObject);
begin
  frmFunctionConfig:= nil;
end;

procedure TfrmFunctionConfig.ButtonExpCrystalSaveClick(Sender: TObject);
var
  I: Byte;
  dwExp, dwExp1: LongWord;
  NeedExps, NeedExps1: TExpCrystalLevelNeedExp;
begin
  for I := 1 to GridExpCrystalLevelExp.RowCount - 1 do begin
    dwExp := Str_ToInt(GridExpCrystalLevelExp.Cells[1, I], 0);
    if (dwExp <= 0) then begin
      Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 经验值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridExpCrystalLevelExp.Row := I;
      GridExpCrystalLevelExp.SetFocus;
      Exit;
    end;
    dwExp1 := Str_ToInt(GridExpCrystalLevelExp.Cells[2, I], 0);
    if (dwExp1 <= 0) then begin
      Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 内功经验值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridExpCrystalLevelExp.Row := I;
      GridExpCrystalLevelExp.SetFocus;
      Exit;
    end;
    NeedExps[I] := dwExp;
    NeedExps1[I] := dwExp1;
  end;
  g_Config.dwExpCrystalNeedExps := NeedExps;
  g_Config.dwNGExpCrystalNeedExps := NeedExps1;
  for I := 1 to 4 do begin
    Config.WriteString('ExpCrystal', 'Level' + IntToStr(I), IntToStr(g_Config.dwExpCrystalNeedExps[I]));
    Config.WriteString('NGExpCrystal', 'Level' + IntToStr(I), IntToStr(g_Config.dwNGExpCrystalNeedExps[I]));
  end;
  Config.WriteInteger('Setup', 'HeroCrystalExpRate', g_Config.nHeroCrystalExpRate);
  uModValue();
end;

procedure TfrmFunctionConfig.GridExpCrystalLevelExpEnter(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

//天地结晶英雄分配比例 20090202
procedure TfrmFunctionConfig.EditHeroCrystalExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroCrystalExpRate := EditHeroCrystalExpRate.Value;
  ModValue();
end;

end.

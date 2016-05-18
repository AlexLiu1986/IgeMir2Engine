unit FState;
//����Ԫ�ṩϵͳ�е����жԻ�����ʾ
interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DXDraws, Grids, Grobal2, clFunc, hUtil32, cliUtil,EDcode, soundUtil, actor,
  DWinCtl;

const
   BOTTOMBOARD800 = 371;//����������ͼ�κ�
   BOTTOMBOARD1024 = 2;//����������ͼ�κ�
   VIEWCHATLINE = 9;
   MAXSTATEPAGE = 4;
   LISTLINEHEIGHT = 13;
   MAXMENU = 10;

   STRLINS = 50;

   AdjustAbilHints : array[0..8] of string = (
      '������',
      'ħ����',
      '������',
      '������',
      'ħ����',
      '����ֵ',
      '����ֵ',
      '׼ȷ��',
      '���ݵ�'
   );

type
  TSpotDlgMode = (dmSell, dmRepair, dmStorage, dmPlayDrink);

  TClickPoint = record
     rc: TRect;
     RStr: string;
  end;
  pTClickPoint = ^TClickPoint;
  TDiceInfo = record
    nDicePoint :Integer;      //0x66C
    nPlayPoint :Integer;//0x670 ��ǰ���ӵ���
    nX         :Integer;      //0x674
    nY         :Integer;      //0x678
    n67C       :Integer;      //0x67C
    n680       :Integer;      //0x680
    dwPlayTick :LongWord; //0x684
  end;
  pTDiceInfo = ^TDiceInfo;
  
  TFrmDlg = class(TForm)
    DStateWin: TDWindow;
    DBackground: TDWindow;
    DItemBag: TDWindow;
    DBottom: TDWindow;
    DMyState: TDButton;
    DMyBag: TDButton;
    DMyMagic: TDButton;
    DOption: TDButton;
    DGold: TDButton;
    DPrevState: TDButton;
    DItemsUpBut: TDButton;
    DCloseBag: TDButton;
    DCloseState: TDButton;
    DLogIn: TDWindow;
    DLoginNew: TDButton;
    DLoginOk: TDButton;
    DNewAccount: TDWindow;
    DNewAccountOk: TDButton;
    DLoginClose: TDButton;
    DNewAccountClose: TDButton;
    DSelectChr: TDWindow;
    DscSelect1: TDButton;
    DscSelect2: TDButton;
    DscStart: TDButton;
    DscNewChr: TDButton;
    DscEraseChr: TDButton;
    DscCredits: TDButton;
    DscExit: TDButton;
    DCreateChr: TDWindow;
    DccWarrior: TDButton;
    DccWizzard: TDButton;
    DccMonk: TDButton;
    DccReserved: TDButton;
    DccMale: TDButton;
    DccFemale: TDButton;
    DccLeftHair: TDButton;
    DccRightHair: TDButton;
    DccOk: TDButton;
    DccClose: TDButton;
    DItemGrid: TDGrid;
    DLoginChgPw: TDButton;
    DMsgDlg: TDWindow;
    DMsgDlgOk: TDButton;
    DMsgDlgYes: TDButton;
    DMsgDlgCancel: TDButton;
    DMsgDlgNo: TDButton;
    DNextState: TDButton;
    DSWNecklace: TDButton;
    DSWLight: TDButton;
    DSWArmRingR: TDButton;
    DSWArmRingL: TDButton;
    DSWRingR: TDButton;
    DSWRingL: TDButton;
    DSWWeapon: TDButton;
    DSWDress: TDButton;
    DSWHelmet: TDButton;
    DSWBujuk: TDButton;
    DSWBelt: TDButton;
    DSWBoots: TDButton;
    DSWCharm: TDButton;

    DBelt1: TDButton;
    DBelt2: TDButton;
    DBelt3: TDButton;
    DBelt4: TDButton;
    DBelt5: TDButton;
    DBelt6: TDButton;
    DChgPw: TDWindow;
    DChgpwOk: TDButton;
    DChgpwCancel: TDButton;
    DMerchantDlg: TDWindow;
    DMerchantDlgClose: TDButton;
    DMenuDlg: TDWindow;
    DMenuPrev: TDButton;
    DMenuNext: TDButton;
    DMenuBuy: TDButton;
    DMenuClose: TDButton;
    DSellDlg: TDWindow;
    DSellDlgOk: TDButton;
    DSellDlgClose: TDButton;
    DSellDlgSpot: TDButton;
    DStMag1: TDButton;
    DStMag2: TDButton;
    DStMag3: TDButton;
    DStMag4: TDButton;
    DStMag5: TDButton;
    DKeySelDlg: TDWindow;
    DKsIcon: TDButton;
    DKsF1: TDButton;
    DKsF2: TDButton;
    DKsF3: TDButton;
    DKsF4: TDButton;
    DKsNone: TDButton;
    DKsOk: TDButton;
    DBotGroup: TDButton;
    DBotTrade: TDButton;
    DBotMiniMap: TDButton;
    DBotFriend: TDButton;
    DGroupDlg: TDWindow;
    DGrpAllowGroup: TDButton;
    DGrpDlgClose: TDButton;
    DGrpCreate: TDButton;
    DGrpAddMem: TDButton;
    DGrpDelMem: TDButton;
    DBotLogout: TDButton;
    DBotExit: TDButton;
    DBotGuild: TDButton;
    DStPageUp: TDButton;
    DStPageDown: TDButton;
    DDealRemoteDlg: TDWindow;
    DDealDlg: TDWindow;
    DDRGrid: TDGrid;
    DDGrid: TDGrid;
    DDealOk: TDButton;
    DDealClose: TDButton;
    DDGold: TDButton;
    DDRGold: TDButton;
    DSelServerDlg: TDWindow;
    DSSrvClose: TDButton;
    DSServer1: TDButton;
    DSServer2: TDButton;
    DUserState1: TDWindow;
    DCloseUS1: TDButton;
    DWeaponUS1: TDButton;
    DHelmetUS1: TDButton;
    DNecklaceUS1: TDButton;
    DDressUS1: TDButton;
    DLightUS1: TDButton;
    DArmringRUS1: TDButton;
    DRingRUS1: TDButton;
    DArmringLUS1: TDButton;
    DRingLUS1: TDButton;

    DBujukUS1: TDButton;
    DBeltUS1: TDButton;
    DBootsUS1: TDButton;
    DCharmUS1: TDButton;

    DSServer3: TDButton;
    DSServer4: TDButton;
    DGuildDlg: TDWindow;
    DGDHome: TDButton;
    DGDList: TDButton;
    DGDChat: TDButton;
    DGDAddMem: TDButton;
    DGDDelMem: TDButton;
    DGDEditNotice: TDButton;
    DGDEditGrade: TDButton;
    DGDAlly: TDButton;
    DGDBreakAlly: TDButton;
    DGDWar: TDButton;
    DGDCancelWar: TDButton;
    DGDUp: TDButton;
    DGDDown: TDButton;
    DGDClose: TDButton;
    DGuildEditNotice: TDWindow;
    DGEClose: TDButton;
    DGEOk: TDButton;
    DSServer5: TDButton;
    DSServer6: TDButton;
    DNewAccountCancel: TDButton;
    DAdjustAbility: TDWindow;
    DPlusDC: TDButton;
    DPlusMC: TDButton;
    DPlusSC: TDButton;
    DPlusAC: TDButton;
    DPlusMAC: TDButton;
    DPlusHP: TDButton;
    DPlusMP: TDButton;
    DPlusHit: TDButton;
    DPlusSpeed: TDButton;
    DMinusDC: TDButton;
    DMinusMC: TDButton;
    DMinusSC: TDButton;
    DMinusAC: TDButton;
    DMinusMAC: TDButton;
    DMinusMP: TDButton;
    DMinusHP: TDButton;
    DMinusHit: TDButton;
    DMinusSpeed: TDButton;
    DAdjustAbilClose: TDButton;
    DAdjustAbilOk: TDButton;
    DBotPlusAbil: TDButton;
    DKsF5: TDButton;
    DKsF6: TDButton;
    DKsF7: TDButton;
    DKsF8: TDButton;
    DEngServer1: TDButton;
    DKsConF1: TDButton;
    DKsConF2: TDButton;
    DKsConF3: TDButton;
    DKsConF4: TDButton;
    DKsConF5: TDButton;
    DKsConF6: TDButton;
    DKsConF7: TDButton;
    DKsConF8: TDButton;
    DBotMemo: TDButton;
    DFriendDlg: TDWindow;
    DFrdClose: TDButton;
    DButton1: TDButton;
    DButton2: TDButton;
    DChgGamePwd: TDWindow;
    DChgGamePwdClose: TDButton;
    DButtonHP: TDButton;
    DButtonMP: TDButton;
    RefusePublicChat: TDButton;
    RefuseCRY: TDButton;
    RefuseWHISPER: TDButton;
    Refuseguild: TDButton;
    AutoCRY: TDButton;
    CallHero: TDButton;
    HeroState: TDButton;
    HeroPackage: TDButton;
    RelationSystem: TDButton;
    Challenge: TDButton;
    CharacterSranking: TDButton;
    DStateHero: TDWindow;
    DCloseHeroState: TDButton;
    DSHHelmet: TDButton;
    DSHWeapon: TDButton;
    DSHDress: TDButton;
    DPrevStateHero: TDButton;
    DSHArmRingR: TDButton;
    DSHRingR: TDButton;
    DNextStateHero: TDButton;
    DSHNecklace: TDButton;
    DSHLight: TDButton;
    DSHArmRingL: TDButton;
    DSHRingL: TDButton;
    DStMagHero1: TDButton;
    DStMagHero2: TDButton;
    DStMagHero3: TDButton;
    DStMagHero4: TDButton;
    DStMagHero5: TDButton;
    DSHPageUp: TDButton;
    DSHPageDown: TDButton;
    DSHBujuk: TDButton;
    DSHBelt: TDButton;
    DSHBoots: TDButton;
    DSHCharm: TDButton;
    DHeroItemBag: TDWindow;
    DHeroItemGrid: TDGrid;
    DHeroItemGridClose: TDButton;
    DHeroIcon: TDWindow;
    DHeroRoleIcon: TDButton;
    DHeroSpleen: TDWindow;
    DButton3: TDButton;
    DShop: TDWindow;
    DShopClose: TDButton;
    DShopImgLogo: TDButton;
    DShopDecorate: TDButton;
    DShopSupplies: TDButton;
    DshopStrengthen: TDButton;
    DShopFriend: TDButton;
    DShopCapacity: TDButton;
    DShopPrev: TDButton;
    DShopNext: TDButton;
    DShopBuy: TDButton;
    DShopPresent: TDButton;
    DShopClose1: TDButton;
    DShopImg1: TDButton;
    DShopImg2: TDButton;
    DShopImg3: TDButton;
    DShopImg4: TDButton;
    DShopImg5: TDButton;
    DShopImg6: TDButton;
    DShopImg7: TDButton;
    DShopImg8: TDButton;
    DShopImg9: TDButton;
    DShopImg10: TDButton;
    DShopSpeciallyImg1: TDButton;
    DShopSpeciallyImg2: TDButton;
    DShopSpeciallyImg3: TDButton;
    DShopSpeciallyImg4: TDButton;
    DShopSpeciallyImg5: TDButton;
    DLevelOrder: TDWindow;
    DLevelOrderClose: TDButton;
    DIndividualOrder: TDButton;
    DHeroOrder: TDButton;
    DMasterOrder: TDButton;
    DColonyHeroOrder: TDButton;
    DWarriorOrder: TDButton;
    DWizerdOrder: TDButton;
    DTaoistOrder: TDButton;
    DHeroAllOrder: TDButton;
    DWarriorHeroOrder: TDButton;
    DWizerdHeroOrder: TDButton;
    DTaoistHeroOrder: TDButton;
    DLevelOrderIndex: TDButton;
    DLevelOrderPrev: TDButton;
    DLevelOrderNext: TDButton;
    DLevelOrderLastPage: TDButton;
    DMyLevelOrder: TDButton;
    DBoxs: TDWindow;
    DBoxsBelt1: TDButton;
    DBoxsBelt2: TDButton;
    DBoxsBelt3: TDButton;
    DBoxsBelt4: TDButton;
    DBoxsBelt5: TDButton;
    DBoxsBelt6: TDButton;
    DBoxsBelt7: TDButton;
    DBoxsBelt8: TDButton;
    DBoxsBelt9: TDButton;
    DBoxsTautology: TDButton;
    DLieDragon: TDWindow;
    DLieDragonClose: TDButton;
    DLieDragonPrevPage: TDButton;
    DLieDragonNextPage: TDButton;
    DGoToLieDragon: TDButton;
    DLieDragonNpc: TDWindow;
    DLieDragonNpcClose: TDButton;
    DItemsUp: TDWindow;
    DItemsUpClose: TDButton;
    DItemsUpBelt1: TDButton;
    DItemsUpBelt2: TDButton;
    DItemsUpBelt3: TDButton;
    DItemsUpOk: TDButton;
    DHelp: TDButton;
    DInternet: TDButton;
    DGameGirdExchange: TDButton;
    DWSellOff: TDWindow;
    DSellOffClose: TDButton;
    DSellOffOk: TDButton;
    DSellOffCancel: TDButton;
    DSellOffItemGrid: TDGrid;
    DWSellOffList: TDWindow;
    DSellOffListColse: TDButton;
    DEditSellOffName: TDButton;
    DEditSellOffNum: TDButton;
    DSellOffItem1: TDButton;
    DSellOffItem2: TDButton;
    DSellOffItem3: TDButton;
    DSellOffItem4: TDButton;
    DSellOffItem5: TDButton;
    DSellOffItem6: TDButton;
    DSellOffItem7: TDButton;
    DSellOffItem8: TDButton;
    DSellOffItem9: TDButton;
    DSellOffItem0: TDButton;
    DSellOffListCancel: TDButton;
    DSellOffBuyCancel: TDButton;
    DSellOffBuy: TDButton;
    DWGameGold: TDButton;
    DWMiniMap: TDWindow;
    DStMag6: TDButton;
    DStMagHero6: TDButton;
    DWiGetHero: TDWindow;
    DGetHeroClose: TDButton;
    DGlory: TDButton;
    DSelHero1: TDButton;
    DSelHero2: TDButton;
    DPlayDrink: TDWindow;
    DPlayDrinkClose: TDButton;
    DPlayDrinkFist: TDButton;
    DPlayDrinkScissors: TDButton;
    DPlayDrinkCloth: TDButton;
    DPlayFist: TDButton;
    DDrink3: TDButton;
    DDrink1: TDButton;
    DDrink2: TDButton;
    DDrink4: TDButton;
    DDrink5: TDButton;
    DDrink6: TDButton;
    DWPleaseDrink: TDWindow;
    DPDrink1: TDButton;
    DPDrink2: TDButton;
    DPleaseDrinkClose: TDButton;
    DPleaseDrinkDrink: TDButton;
    DPleaseDrinkExit: TDButton;
    DPlayDrinkNpcNum: TDButton;
    DPlayDrinkPlayNum: TDButton;
    DPlayDrinkWhoWin: TDButton;
    DLOGO: TDButton;
    DFriendDlgFrd: TDButton;
    DFriendDlgMasterOrder: TDButton;
    DHeiMingDan: TDButton;
    DPrevFriendDlg: TDButton;
    DNextFriendDlg: TDButton;
    DFriendList: TDButton;
    DAddFriend: TDButton;
    DDelFriend: TDButton;
    DWCheckNum: TDWindow;
    DCheckNumClose: TDButton;
    DCheckNumOK: TDButton;
    DCheckNumChange: TDButton;
    DEditCheckNum: TDEdit;
    DWMakeWineDesk: TDWindow;
    DMakeWineDeskClose: TDButton;
    DDrunkScale: TDButton;
    DLiquorProgress: TDButton;
    DMakeWineHelp: TDButton;
    DMaterialMemo: TDButton;
    DStartMakeWine: TDButton;
    DBMateria: TDButton;
    DBWineSong: TDButton;
    DBWater: TDButton;
    DBWineCrock: TDButton;
    DBAssistMaterial1: TDButton;
    DBAssistMaterial2: TDButton;
    DBAssistMaterial3: TDButton;
    DBDrug: TDButton;
    DBWine: TDButton;
    DBWineBottle: TDButton;
    DHeroLiquorProgress: TDButton;
    DWNewSdoAssistant: TDWindow;
    DNewSdoAssistantClose: TDButton;
    DNewSdoBasic: TDButton;
    DNewSdoProtect: TDButton;
    DNewSdoSkill: TDButton;
    DNewSdoKey: TDButton;
    DNedSdoHelp: TDButton;
    DCheckSdoNameShow: TDCheckBox;
    DCheckSdoDuraWarning: TDCheckBox;
    DCheckSdoAvoidShift: TDCheckBox;
    DCheckSdoItemsHint: TDCheckBox;
    DCheckSdoShowFiltrate: TDCheckBox;
    DCheckSdoAutoPickItems: TDCheckBox;
    DCheckSdoPickFiltrate: TDCheckBox;
    DCheckSdoLongHit: TDCheckBox;
    DCheckSdoAutoWideHit: TDCheckBox;
    DCheckSdoAutoFireHit: TDCheckBox;
    DCheckSdoZhuri: TDCheckBox;
    DCheckSdoAutoShield: TDCheckBox;
    DCheckSdoHeroShield: TDCheckBox;
    DCheckSdoAutoHide: TDCheckBox;
    DCheckSdoAutoMagic: TDCheckBox;
    DEdtSdoAutoMagicTimer: TDEdit;
    DCheckSdoCommonHp: TDCheckBox;
    DEdtSdoCommonHp: TDEdit;
    DEdtSdoCommonHpTimer: TDEdit;
    DCheckSdoCommonMp: TDCheckBox;
    DEdtSdoCommonMp: TDEdit;
    DEdtSdoCommonMpTimer: TDEdit;
    DCheckSdoSpecialHp: TDCheckBox;
    DEdtSdoSpecialHp: TDEdit;
    DEdtSdoSpecialHpTimer: TDEdit;
    DCheckSdoRandomHp: TDCheckBox;
    DEdtSdoRandomHp: TDEdit;
    DEdtSdoRandomHpTimer: TDEdit;
    DSdoHelpUp: TDButton;
    DSdoHelpNext: TDButton;
    DCheckSdoStartKey: TDCheckBox;
    DBtnSdoCallHeroKey: TDButton;
    DBtnSdoHeroAttackTargetKey: TDButton;
    DBtnSdoHeroGotethKey: TDButton;
    DBtnSdoHeroStateKey: TDButton;
    DBtnSdoHeroGuardKey: TDButton;
    DBtnSdoAttackModeKey: TDButton;
    DBtnSdoMinMapKey: TDButton;
    DBtnSdoRandomName: TDButton;
    DCheckSdoAutoDrinkWine: TDCheckBox;
    DEdtSdoDrunkWineDegree: TDEdit;
    DCheckSdoHeroAutoDrinkWine: TDCheckBox;
    DEdtSdoHeroDrunkWineDegree: TDEdit;
    DWChallenge: TDWindow;
    DChallengeClose: TDButton;
    DChallengeOK: TDButton;
    DChallengeCancel: TDButton;
    DChallengeGrid: TDGrid;
    DChallengeGold: TDButton;
    DRChallengeGrid: TDGrid;
    dwRecoverChr: TDWindow;
    dgrdRecoverName: TDGrid;
    btnRecover: TDButton;
    btnRecvChrClose: TDButton;
    DCheckSdoExpFiltrate: TDCheckBox;
    DCheckSdoAutoDrinkDrugWine: TDCheckBox;
    DEdtSdoDrunkDrugWineDegree: TDEdit;
    DCheckSdoHeroAutoDrinkDrugWine: TDCheckBox;
    DEdtSdoHeroDrunkDrugWineDegree: TDEdit;
    DStateTab: TDButton;
    DHeroStateTab: TDButton;



    procedure DBottomInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DBottomDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMyStateDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DOptionClick();
    procedure DItemBagDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemsUpButDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DStateWinDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure FormCreate(Sender: TObject);
    procedure DPrevStateDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLoginNewDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DscSelect1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DccCloseDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DItemGridDblClick(Sender: TObject);
    procedure DMsgDlgOkDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMsgDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMsgDlgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCloseBagDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBackgroundBackgroundClick(Sender: TObject);
    procedure DItemGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DBelt1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure FormDestroy(Sender: TObject);
    procedure DBelt1DblClick(Sender: TObject);
    procedure DLoginCloseClick(Sender: TObject; X, Y: Integer);
    procedure DLoginOkClick(Sender: TObject; X, Y: Integer);
    procedure DLoginNewClick(Sender: TObject; X, Y: Integer);
    procedure DLoginChgPwClick(Sender: TObject; X, Y: Integer);
    procedure DNewAccountOkClick(Sender: TObject; X, Y: Integer);
    procedure DNewAccountCloseClick(Sender: TObject; X, Y: Integer);
    procedure DccCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgpwOkClick(Sender: TObject; X, Y: Integer);
    procedure DscSelect1Click(Sender: TObject; X, Y: Integer);
    procedure DCloseStateClick(Sender: TObject; X, Y: Integer);
    procedure DPrevStateClick(Sender: TObject; X, Y: Integer);
    procedure DNextStateClick(Sender: TObject; X, Y: Integer);
    procedure DSWWeaponClick(Sender: TObject; X, Y: Integer);//�ƶ�Ӣ��װ����Ʒ
    procedure HeroPageChanged;

    procedure DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DCloseBagClick(Sender: TObject; X, Y: Integer);
    procedure DBelt1Click(Sender: TObject; X, Y: Integer);
    procedure DMyStateClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinClick(Sender: TObject; X, Y: Integer);
    procedure DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBelt1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMerchantDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMerchantDlgClick(Sender: TObject; X, Y: Integer);
    procedure DMerchantDlgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMerchantDlgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMenuCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMenuDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMenuDlgClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSellDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgSpotClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgSpotDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSellDlgSpotMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DSellDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DMenuBuyClick(Sender: TObject; X, Y: Integer);
    procedure DMenuPrevClick(Sender: TObject; X, Y: Integer);
    procedure DMenuNextClick(Sender: TObject; X, Y: Integer);
    procedure DGoldClick(Sender: TObject; X, Y: Integer);
    procedure DSWLightDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSHLightDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);  //��ʾӢ��װ��    ����$010
    procedure DBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DStateWinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DLoginNewClickSound(Sender: TObject;
      Clicksound: TClickSound);
    procedure DStMag1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DStMag1Click(Sender: TObject; X, Y: Integer);
    procedure DKsIconDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DKsF1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DKsOkClick(Sender: TObject; X, Y: Integer);
    procedure DKsF1Click(Sender: TObject; X, Y: Integer);
    procedure DKeySelDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotGroupDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGrpAllowGroupDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGrpDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpCreateClick(Sender: TObject; X, Y: Integer);
    procedure DGroupDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGrpAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DGrpDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DBotLogoutClick(Sender: TObject; X, Y: Integer);
    procedure DBotExitClick(Sender: TObject; X, Y: Integer);
    procedure DStPageUpClick(Sender: TObject; X, Y: Integer);
    procedure DBottomMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DDealOkClick(Sender: TObject; X, Y: Integer);
    procedure DDealCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotTradeClick(Sender: TObject; X, Y: Integer);
    procedure DDealRemoteDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDealDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DDGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DDRGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDGoldClick(Sender: TObject; X, Y: Integer);
    procedure DSServer1Click(Sender: TObject; X, Y: Integer);
    procedure DSSrvCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotMiniMapClick(Sender: TObject; X, Y: Integer);
    procedure DMenuDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DUserState1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DUserState1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DCloseUS1Click(Sender: TObject; X, Y: Integer);
    procedure DNecklaceUS1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotGuildClick(Sender: TObject; X, Y: Integer);
    procedure DGuildDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGDUpClick(Sender: TObject; X, Y: Integer);
    procedure DGDDownClick(Sender: TObject; X, Y: Integer);
    procedure DGDCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGDHomeClick(Sender: TObject; X, Y: Integer);
    procedure DGDListClick(Sender: TObject; X, Y: Integer);
    procedure DGDAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DGDDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
    procedure DGDEditGradeClick(Sender: TObject; X, Y: Integer);
    procedure DGECloseClick(Sender: TObject; X, Y: Integer);
    procedure DGEOkClick(Sender: TObject; X, Y: Integer);
    procedure DGuildEditNoticeDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGDChatClick(Sender: TObject; X, Y: Integer);
    procedure DGoldDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DNewAccountDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DAdjustAbilCloseClick(Sender: TObject; X, Y: Integer);
    procedure DAdjustAbilityDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotPlusAbilClick(Sender: TObject; X, Y: Integer);
    procedure DPlusDCClick(Sender: TObject; X, Y: Integer);
    procedure DMinusDCClick(Sender: TObject; X, Y: Integer);
    procedure DAdjustAbilOkClick(Sender: TObject; X, Y: Integer);
    procedure DBotPlusAbilDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DAdjustAbilityMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DUserState1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DEngServer1Click(Sender: TObject; X, Y: Integer);
    procedure DGDAllyClick(Sender: TObject; X, Y: Integer);
    procedure DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
    procedure DBotMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DFrdFriendDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotFriendClick(Sender: TObject; X, Y: Integer);
    procedure DFrdCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgGamePwdCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgGamePwdDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure CallHeroClick(Sender: TObject; X, Y: Integer);
    procedure RefuseguildClick(Sender: TObject; X, Y: Integer);
    procedure RefuseWHISPERClick(Sender: TObject; X, Y: Integer);
    procedure HeroStateClick(Sender: TObject; X, Y: Integer);
    procedure DCloseHeroStateClick(Sender: TObject; X, Y: Integer);
    procedure DStateHeroDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCloseHeroStateDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSHWeaponMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
    procedure HeroPackageClick(Sender: TObject; X, Y: Integer);
    procedure DNextStateHeroClick(Sender: TObject; X, Y: Integer);
    procedure RefusePublicChatClick(Sender: TObject; X, Y: Integer);
    procedure DHeroItemBagDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DHeroItemGridCloseClick(Sender: TObject; X, Y: Integer);
    procedure DHeroItemGridGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DHeroItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DHeroItemGridDblClick(Sender: TObject);
    function HeroIcon(sex:integer;job:integer):integer;
    procedure DHeroRoleIconDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroIconDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DButton3DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DPrevStateHeroClick(Sender: TObject; X, Y: Integer);
    procedure DSHPageUpClick(Sender: TObject; X, Y: Integer);
    procedure DHeroIconClick(Sender: TObject; X, Y: Integer);
    procedure DStMagHero1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DStateHeroMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBotMemoClick(Sender: TObject; X, Y: Integer);
    procedure ShopStrWord(s:string;dsurface:TDirectDrawSurface;x,y:integer);//ȡ|���� ���ұߵ�����
    procedure DShopDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DShopCloseClick(Sender: TObject; X, Y: Integer);
    procedure DShopImg1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DShopNextClick(Sender: TObject; X, Y: Integer);
    procedure DShopDecorateClick(Sender: TObject; X, Y: Integer);
    procedure DShopImg1Click(Sender: TObject; X, Y: Integer);
    procedure Itemstrorlist(str:string; WIDTH,HEIGH:integer);
    procedure DShopBuyClick(Sender: TObject; X, Y: Integer);
    procedure DShopSpeciallyImg1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DShopSpeciallyImg1Click(Sender: TObject; X, Y: Integer);
    //Shop ��Ʒ������ʾ
    procedure ShopGifInfo(dsurface: TDirectDrawSurface;dx,dy,ShopGifBegin,ShopGifEnd:integer);
    procedure DShopPresentClick(Sender: TObject; X, Y: Integer);
    procedure CharacterSrankingClick(Sender: TObject; X, Y: Integer);
    procedure DLevelOrderCloseClick(Sender: TObject; X, Y: Integer);
    procedure DIndividualOrderClick(Sender: TObject; X, Y: Integer);
    procedure DHeroOrderClick(Sender: TObject; X, Y: Integer);
    procedure DLevelOrderDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DColonyHeroOrderClick(Sender: TObject; X, Y: Integer);
    procedure DHeroAllOrderClick(Sender: TObject; X, Y: Integer);
    procedure DMasterOrderClick(Sender: TObject; X, Y: Integer);
    procedure DMyLevelOrderClick(Sender: TObject; X, Y: Integer);
    procedure DLevelOrderIndexClick(Sender: TObject; X, Y: Integer);
    procedure DLevelOrderLastPageClick(Sender: TObject; X, Y: Integer);
    procedure DLevelOrderNextClick(Sender: TObject; X, Y: Integer);
    procedure DBottomMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure typeTimeimg; //Ӣ��ŭ���任����
    procedure DPlayGameNum();
    procedure ItemLightTimeImg();//��Ʒ����任���� 20080223
    procedure BoxsFlash(Button: TDButton;dsurface: TDirectDrawSurface);
    procedure BoxsRandomImg;
    procedure BoxsRunning(dsurface: TDirectDrawSurface);
    procedure DBoxsDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBoxsClick(Sender: TObject; X, Y: Integer);
    procedure DBoxsBelt5DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBoxsBelt5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBoxsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBoxsTautologyClick(Sender: TObject; X, Y: Integer);
    procedure DBoxsTautologyMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DBoxsBelt1DblClick(Sender: TObject);
    procedure DLieDragonDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLieDragonCloseDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLieDragonCloseClick(Sender: TObject; X, Y: Integer);
    procedure DLieDragonNextPageDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLieDragonPrevPageDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLieDragonNextPageClick(Sender: TObject; X, Y: Integer);
    procedure DGoToLieDragonDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLieDragonNpcDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLieDragonNpcCloseClick(Sender: TObject; X, Y: Integer);
    procedure ShowBoxsGird(Show:Boolean);
    procedure DGoToLieDragonClick(Sender: TObject; X, Y: Integer);
    procedure DItemsUpButMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DItemsUpButClick(Sender: TObject; X, Y: Integer);
    procedure DItemBagMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DCIDSpleenDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DButton4DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure RefuseCRYClick(Sender: TObject; X, Y: Integer);
    procedure AutoCRYClick(Sender: TObject; X, Y: Integer);
    procedure DSHWeaponClick(Sender: TObject; X, Y: Integer);
    procedure DHelpDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGameGirdExchangeDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGameGirdExchangeClick(Sender: TObject; X, Y: Integer);
    procedure DLevelOrderClick(Sender: TObject; X, Y: Integer);
    procedure DSellOffCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSellOffItemGridGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DSellOffItemGridGridPaint(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDirectDrawSurface);
    procedure DSellOffItemGridGridSelect(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DWSellOffDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSellOffOkClick(Sender: TObject; X, Y: Integer);
    procedure DSellOffCancelClick(Sender: TObject; X, Y: Integer);
    procedure ShowSellOffListDlg;
    procedure DEditSellOffNameClick(Sender: TObject; X, Y: Integer);
    procedure DEditSellOffNumClick(Sender: TObject; X, Y: Integer);
    procedure DEditSellOffNameDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DEditSellOffNumDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSellOffListColseClick(Sender: TObject; X, Y: Integer);
    procedure DWSellOffListDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSellOffItem0DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSellOffItem0Click(Sender: TObject; X, Y: Integer);
    procedure DSellOffListCancelClick(Sender: TObject; X, Y: Integer);
    procedure DSellOffBuyCancelClick(Sender: TObject; X, Y: Integer);
    procedure DSellOffBuyClick(Sender: TObject; X, Y: Integer);
    procedure DWGameGoldMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWMiniMapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWMiniMapDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWMiniMapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DSelectChrMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DCIDSpleenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DUserState1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DHeroIconMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBoxsTautologyDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemsUpBelt1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemsUpBelt1Click(Sender: TObject; X, Y: Integer);
    procedure DItemsUpOkClick(Sender: TObject; X, Y: Integer);
    procedure DItemsUpBelt1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DItemsUpCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGetHeroCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGloryDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSelHero1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DPlayDrinkDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure ChallengeClick(Sender: TObject; X, Y: Integer);
    procedure DDrink1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWiGetHeroDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSelHero1Click(Sender: TObject; X, Y: Integer);
    procedure DPlayFistClick(Sender: TObject; X, Y: Integer);
    procedure DPlayDrinkCloseDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DPlayDrinkMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DPlayDrinkMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DPlayDrinkClick(Sender: TObject; X, Y: Integer);
    procedure DWPleaseDrinkDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DPDrink1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DPlayDrinkCloseClick(Sender: TObject; X, Y: Integer);
    procedure DPlayDrinkFistClick(Sender: TObject; X, Y: Integer);
    procedure DPlayDrinkNpcNumDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DPlayDrinkPlayNumDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DPlayDrinkWhoWinDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface); //��ʾ�����б���� 20080317
    procedure ShowPlayDrinkImg(Show: Boolean);
    procedure DPlayDrinkFistDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDrink1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DPlayDrinkMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DDrink1Click(Sender: TObject; X, Y: Integer);
    procedure DPDrink1Click(Sender: TObject; X, Y: Integer);
    procedure DPDrink1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWPleaseDrinkMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DPleaseDrinkExitClick(Sender: TObject; X, Y: Integer);
    procedure DPleaseDrinkDrinkClick(Sender: TObject; X, Y: Integer);
    procedure DWPleaseDrinkClick(Sender: TObject; X, Y: Integer);
    procedure DWPleaseDrinkMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DWPleaseDrinkMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DLOGODirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLOGOClick(Sender: TObject; X, Y: Integer);
    procedure DFriendDlgFrdDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DFriendDlgFrdClick(Sender: TObject; X, Y: Integer);
    procedure DFriendDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DFriendListDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DFriendListDblClick(Sender: TObject);
    procedure DFriendListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DPrevFriendDlgClick(Sender: TObject; X, Y: Integer);
    procedure DAddFriendClick(Sender: TObject; X, Y: Integer);
    procedure DDelFriendClick(Sender: TObject; X, Y: Integer);
    procedure DInternetClick(Sender: TObject; X, Y: Integer);
    procedure DStMagHero1Click(Sender: TObject; X, Y: Integer);
    procedure DWCheckNumDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCheckNumOKDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCheckNumOKClick(Sender: TObject; X, Y: Integer);
    procedure DEditCheckNumKeyPress(Sender: TObject; var Key: Char);
    procedure DEditCheckNumKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCheckNumChangeClick(Sender: TObject; X, Y: Integer);
    procedure DWMakeWineDeskDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMakeWineHelpDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMakeWineDeskCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMakeWineHelpClick(Sender: TObject; X, Y: Integer);
    procedure DMaterialMemoClick(Sender: TObject; X, Y: Integer);
    procedure DBMateriaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWMakeWineDeskMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ShowMakeWine(bool:Boolean);
    procedure DBMateriaClick(Sender: TObject; X, Y: Integer);
    procedure DBMateriaDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBDrugDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBDrugClick(Sender: TObject; X, Y: Integer);
    procedure DStartMakeWineClick(Sender: TObject; X, Y: Integer);
    procedure DDrunkScaleDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLiquorProgressDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBDrugMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DHeroLiquorProgressDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCheckSdoNameShowDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DNewSdoBasicDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWNewSdoAssistantDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DNewSdoBasicClick(Sender: TObject; X, Y: Integer);
    procedure DEdtSdoAutoMagicTimerDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DNewSdoAssistantCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSdoHelpUpClick(Sender: TObject; X, Y: Integer);
    procedure DBtnSdoCallHeroKeyDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBtnSdoRandomNameDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCheckSdoNameShowClick(Sender: TObject; X, Y: Integer);
    procedure DCheckSdoCommonHpClick(Sender: TObject; X, Y: Integer);
    procedure DEdtSdoCommonHpChange(Sender: TObject);
    procedure DCheckSdoLongHitClick(Sender: TObject; X, Y: Integer);
    procedure DBtnSdoRandomNameClick(Sender: TObject; X, Y: Integer);
    procedure DBtnSdoCallHeroKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBtnSdoCallHeroKeyMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DEdtSdoCommonHpKeyPress(Sender: TObject; var Key: Char);
    procedure DWChallengeDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DChallengeGridGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DChallengeGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DChallengeGridGridSelect(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DChallengeCloseClick(Sender: TObject; X, Y: Integer);
    procedure DRChallengeGridGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DRChallengeGridGridPaint(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDirectDrawSurface);
    procedure DChallengeOKClick(Sender: TObject; X, Y: Integer);
    procedure DChallengeGoldClick(Sender: TObject; X, Y: Integer);
    procedure btnRecvChrCloseClick(Sender: TObject; X, Y: Integer);
    procedure dgrdRecoverNameGridPaint(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDirectDrawSurface);
    procedure dgrdRecoverNameGridSelect(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure btnRecoverClick(Sender: TObject; X, Y: Integer);
    procedure DWChallengeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DEdtSdoCommonHpTimerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCheckSdoExpFiltrateMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DWNewSdoAssistantMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DHeroItemBagMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DStateTabClick(Sender: TObject; X, Y: Integer);
    procedure DStateTabDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroStateTabDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHeroStateTabClick(Sender: TObject; X, Y: Integer);
    constructor Create(AOwner: TComponent); override;
  private
    DlgTemp: TList;
    magcur, magtop, HeroMagTop: integer;
    EdDlgEdit: TEdit;
    Memo: TMemo;

    ViewDlgEdit: Boolean;
    msglx, msgly: integer;
    MenuTop: integer;

    MagKeyIcon, MagKeyCurKey: integer;
    MagKeyMagName: string;
    MagicPage: integer;
    InternalForceMagicPage: integer;  //�ڹ�����ҳ
    HeroMagicPage: integer;
    HeroInternalForceMagicPage: integer; //Ӣ���ڹ�����ҳ
    BlinkTime: Longword;
    BlinkCount: integer;  //0..9���̸� �ݺ�

    imginsex:integer;// ����
    typetime: longword;
    procedure HideAllControls;
    procedure RestoreHideControls;
    procedure PageChanged;
    procedure InternalForcePageChanged;
    procedure HeroInternalForcePageChanged;
    procedure LevelOrderPageChanged;//�ȼ����а�ҳ���ı� 2007.12.12
    procedure MouseRightItem(WhoItemBag{˭�İ���},ACol,ARow:Integer);//�Ҽ���װ��
    procedure DealItemReturnBag (mitem: TClientItem);
    procedure ChallengeItemReturnBag (mitem: TClientItem);
    procedure SellOffItemReturnBag (mitem: TClientItem);//Ԫ�����۷��ذ��� 20080316
    //procedure ItemUpReturnBag (mitem: TMovingItem); //�������ذ��� 20080506
    procedure DealZeroGold;
    function  GetMiniMapNum(num:Integer): TDirectDrawSurface;  //�����С��ͼ��  20080324
    procedure NpcAutoSelDrinkRuning(dsurface: TDirectDrawSurface);
  public
    StateTab: Byte; //�ڹ������ҳ
    HeroStateTab: Byte; //Ӣ���ڹ������ҳ
    InternalForcePage: Integer; //�ڹ�״̬ҳ
    HeroInternalForcePage: Integer; //Ӣ���ڹ�״̬ҳ

    StatePage: Integer;
    LevelOrderPage: Integer;

    strorlist    :array[0..STRLINS-1] of String;
    strorlistidx :array[0..STRLINS-1] of Integer;
    strorliscont :Integer;
    HeroStatePage: Integer; //Ӣ����Ϣҳ�� ����$012 2007.10.21
    MsgText: string;
    DialogSize: Integer;

    m_nDiceCount:Integer;
    m_boPlayDice:Boolean;
    m_Dice:array[0..9] of TDiceInfo;

    MerchantName: string;
    MerchantFace: Integer;
    MDlgStr: string;
    MDlgPoints: TList;
    RequireAddPoints: Boolean;
    SelectMenuStr: string;
    LastestClickTime: longword;
    SpotDlgMode: TSpotDlgMode;

    MenuList: TList; //list of PTClientGoods
    MenuIndex: integer;
    CurDetailItem: string;
    MenuTopLine: integer;
    BoDetailMenu: Boolean;
    BoStorageMenu: Boolean;
    BoNoDisplayMaxDura: Boolean;
    BoMakeDrugMenu: Boolean;
    NAHelps: TStringList;
    NewAccountTitle: string;

    DlgEditText: string;
    UserState1: TUserStateInfo;

    Guild: string;
    GuildFlag: string;
    GuildCommanderMode: Boolean;
    GuildStrs: TStringList;
    GuildStrs2: TStringList;
    GuildNotice: TStringList;
    GuildMembers: TStringList;
    GuildTopLine: integer;
    GuildEditHint: string;
    GuildChats: TStringList;
    BoGuildChat: Boolean;

    procedure Initialize;
    procedure InitializePlace; //��ʼ��ͼ��λ�� 20080524
    procedure OpenMyStatus;
    procedure OpenUserState (UserState: TUserStateInfo);
    procedure OpenItemBag;
    procedure ViewBottomBox (visible: Boolean);
    procedure CancelItemMoving;
    procedure CancelHeroItemMoving; // ȡ��Ӣ����Ʒ�ƶ�
    procedure DropMovingItem;
    procedure DropHeroMovingItem; //Ӣ���������Ӷ���
    procedure OpenAdjustAbility;

    procedure ShowSelectServerDlg;
    function  DMessageDlg (msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
    procedure ShowMDlg (face: integer; mname, msgstr: string);
    procedure ShowGuildDlg;
    procedure ShowGuildEditNotice;
    procedure ShowGuildEditGrade;

    procedure ResetMenuDlg;
    procedure ShowShopMenuDlg;
    procedure ShowShopSellDlg;
    procedure ShowShopSellOffDlg;  //Ԫ��������ʾ���� 20080316
    procedure CloseDSellDlg;
    procedure CloseMDlg;

    procedure ToggleShowGroupDlg;
    procedure OpenDealDlg;

    procedure OpenChallengeDlg; //����ս�Ի���
    procedure CloseChallengeDlg;
    procedure CloseDealDlg;

    procedure OpenFriendDlg;

    procedure SoldOutGoods (itemserverindex: integer);
    procedure DelStorageItem (itemserverindex: integer);
    procedure GetMouseItemInfo (var iname, line1, line2, line3: string; var useable: boolean; Who: Integer{1Ϊ����,2ΪӢ��}); //���� 2007.12.15 ֧��Ӣ��
    procedure SetMagicKeyDlg (icon: integer; magname: string; var curkey: word);
    procedure AddGuildChat (str: string);
    procedure ShowPlayDrink (Who1: integer; msgstr: string);
    procedure NewSdoAssistantPageChanged;//��ʢ���ڹ�ҳ���ı� 20080624
  end;

var
  FrmDlg: TFrmDlg;

implementation

uses
   ClMain, MShare, Share, Browser, Splash, DataUnit;

{$R *.DFM}

procedure TFrmDlg.FormCreate(Sender: TObject);
begin
   //frmMain.DXDraw.Initialize;
   //ItemLightImgIdx := 0; //��ʼ����Ʒ����ͼƬIDΪ0 20080223
   g_boBoxsMiddleItems := False; //��ʼ��������ƷΪ�м�
   StatePage := 0;
   LevelOrderPage := 0;
   g_nBoxsImg := 0;
   g_BoxsFlashImg := 0;
   g_LieDragonPage := 0; //����
   HeroStatePage := 0;
   HeroMagicPage := 0;
   DlgTemp := TList.Create;
   DialogSize := 1;
   m_nDiceCount:=0;
   m_boPlayDice:=False;
   magcur := 0;
   magtop := 0;
   HeroMagTop := 0;
   MDlgPoints := TList.Create;
   SelectMenuStr := '';
   MenuList := TList.Create;
   MenuIndex := -1;
   MenuTopLine := 0;
   BoDetailMenu := FALSE;
   BoStorageMenu := FALSE;
   BoNoDisplayMaxDura := FALSE;
   BoMakeDrugMenu := FALSE;
   MagicPage := 0;
   InternalForceMagicPage := 0;
   HeroInternalForceMagicPage := 0;
   NAHelps := TStringList.Create;
   BlinkTime := GetTickCount;
   BlinkCount := 0;

   g_ShopPage:=0;
   ShopGifFrame:=0;
   imginsex:=0;
   //ShopImgIdx := 0;

   g_SellDlgItem.S.Name := '';
   Guild := '';
   GuildFlag := '';
   GuildCommanderMode := FALSE;
   GuildStrs := TStringList.Create;
   GuildStrs2 := TStringList.Create; //�����
   GuildNotice := TStringList.Create;
   GuildMembers := TStringList.Create;
   GuildChats := TStringList.Create;

   g_PlayDrinkPoints := TList.Create; //20080515
   

   EdDlgEdit := TEdit.Create (FrmMain.Owner);
   with EdDlgEdit do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 9;
      MaxLength := 30;
      Height := 16;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
   end;
   Memo := TMemo.Create (FrmMain.Owner);
   with Memo do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 9;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
   end;
end;

procedure TFrmDlg.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
   DlgTemp.Free;
   for I:=0 to MDlgPoints.Count - 1  do begin  //20080718�ͷ��ڴ�
    if pTClickPoint(MDlgPoints[i]) <> nil then
      Dispose(pTClickPoint(MDlgPoints[i]));
   end;
   FreeAndNil(MDlgPoints);
   g_PlayDrinkPoints.Free;  
   MenuList.Free;
   NAHelps.Free;
   GuildStrs.Free;
   GuildStrs2.Free;
   GuildNotice.Free;
   GuildMembers.Free;
   GuildChats.Free;
end;

procedure TFrmDlg.HideAllControls;
var
   i: integer;
   c: TControl;
begin
   DlgTemp.Clear;
   with FrmMain do
      if ControlCount > 0 then //20080629
      for i:=0 to ControlCount-1 do begin
         c := Controls[i];
         if c is TEdit then
            if (c.Visible) and (c <> EdDlgEdit) then begin
               DlgTemp.Add (c);
               c.Visible := FALSE;
            end;
      end;
end;

procedure TFrmDlg.RestoreHideControls;
var
   i: integer;
begin
   if DlgTemp.Count > 0 then //20080629
   for i:=0 to DlgTemp.Count-1 do begin
      TControl(DlgTemp[i]).Visible := TRUE;
   end;
end;

procedure TFrmDlg.Initialize;  //��ʼ������  ���� 2007.10.20
var
   d: TDirectDrawSurface;
begin
   g_DWinMan.ClearAll;

   DBackground.Left := 0;
   DBackground.Top := 0;
   DBackground.Width := SCREENWIDTH;
   DBackground.Height := SCREENHEIGHT;
   DBackground.Background := TRUE;
   g_DWinMan.AddDControl (DBackground, TRUE);

   {-----------------------------------------------------------}
   //��¼�Ի���
   d := g_WMain3Images.Images[18];
   if d <> nil then begin
      DLogIn.SetImgIndex (g_WMain3Images, 18);
      DLogIn.Left := (SCREENWIDTH - d.Width) div 2;
      DLogIn.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DLoginNew.SetImgIndex (g_WMainImages, 61);
   DLoginNew.Left := 32;
   DLoginNew.Top  := 173;
   DLoginOk.SetImgIndex (g_WMain3Images, 10);
   DLoginOk.Left := 164;
   DLoginOk.Top := 172;
   DLoginChgPw.SetImgIndex (g_WMain3Images, 28);
   DLoginChgPw.Left := 164;
   DLoginChgPw.Top  := 215;
   DLoginClose.SetImgIndex (g_WMainImages, 64);
   DLoginClose.Left := 258;
   DLoginClose.Top := 24;
    
   {-----------------------------------------------------------}
   //������ѡ�񴰿�
      d := g_WMainImages.Images[256]; //81];
      if d <> nil then begin
         DSelServerDlg.SetImgIndex (g_WMainImages, 256);
         DSelServerDlg.Left := (SCREENWIDTH - d.Width) div 2;
         DSelServerDlg.Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      DSSrvClose.SetImgIndex (g_WMainImages, 64);
      DSSrvClose.Left := 245;
      DSSrvClose.Top := 31;

      DSServer1.SetImgIndex (g_WMain3Images, 2);
      DSServer1.Left := 65;
      DSServer1.Top  := 100;

      DSServer2.SetImgIndex (g_WMain3Images, 2);
      DSServer2.Left := 65;
      DSServer2.Top  := 145;

      DSServer3.SetImgIndex (g_WMain3Images, 2);
      DSServer3.Left := 65;
      DSServer3.Top  := 190;

      DSServer4.SetImgIndex (g_WMain3Images, 2);
      DSServer4.Left := 65;
      DSServer4.Top  := 235;

      DSServer5.SetImgIndex (g_WMain3Images, 2);
      DSServer5.Left := 65;
      DSServer5.Top  := 280;

      DSServer6.SetImgIndex (g_WMain3Images, 2);
      DSServer6.Left := 65;
      DSServer6.Top  := 325;

      DEngServer1.Visible := FALSE;
      DSServer1.Visible := FALSE;
      DSServer2.Visible := FALSE;
      DSServer3.Visible := FALSE;
      DSServer4.Visible := FALSE;
      DSServer5.Visible := FALSE;
      DSServer6.Visible := FALSE;
   {-----------------------------------------------------------}
   //�½��ʺŴ���
   d := g_WMainImages.Images[63];
   if d <> nil then
      DNewAccount.SetImgIndex (g_WMainImages, 63);
   DNewAccountOk.SetImgIndex (g_WMainImages, 62);
   DNewAccountCancel.SetImgIndex (g_WMainImages, 52);
   DNewAccountClose.SetImgIndex (g_WMainImages, 64);
   {-----------------------------------------------------------}
   //�޸����봰��
   d := g_WMainImages.Images[50];
   if d <> nil then
      DChgPw.SetImgIndex (g_WMainImages, 50);
   DChgpwOk.SetImgIndex (g_WMainImages, 62);
   DChgpwCancel.SetImgIndex (g_WMainImages, 52);
   {-----------------------------------------------------------}
   //ѡ���ɫ����
   DscSelect1.SetImgIndex (g_WMainImages, 66);
   DscSelect2.SetImgIndex (g_WMainImages, 67);
   DscStart.SetImgIndex (g_WMainImages, 68);
   DscNewChr.SetImgIndex (g_WMainImages, 69);
   DscEraseChr.SetImgIndex (g_WMainImages, 70);
   DscCredits.SetImgIndex (g_WMain3Images, 405);
   DscExit.SetImgIndex (g_WMainImages, 72);
   d := g_WMain3Images.Images[406];
   if d <> nil then begin
     dwRecoverChr.SetImgIndex(g_WMain3Images, 406);
     btnRecvChrClose.SetImgIndex(g_WMainImages, 64);
     btnRecover.SetImgIndex(g_WMain3Images, 407);
   end;
   {-----------------------------------------------------------}
   //������ɫ����
   d := g_WMainImages.Images[73];
   if d <> nil then
      DCreateChr.SetImgIndex (g_WMainImages, 73);
   DccWarrior.SetImgIndex (g_WMainImages, 74);
   DccWizzard.SetImgIndex (g_WMainImages, 75);
   DccMonk.SetImgIndex (g_WMainImages, 76);
   DccMale.SetImgIndex (g_WMainImages, 77);
   DccFemale.SetImgIndex (g_WMainImages, 78);
   DccLeftHair.SetImgIndex (g_WMainImages, 79);
   DccRightHair.SetImgIndex (g_WMainImages, 80);
   DccOk.SetImgIndex (g_WMainImages, 62);
   DccClose.SetImgIndex (g_WMainImages, 64);
    {-----------------------------------------------------------}
    //NPC�Ի���
   d := g_WMainImages.Images[360];
   if d <> nil then
      DMsgDlg.SetImgIndex (g_WMainImages, 360);
   DMsgDlgOk.SetImgIndex (g_WMainImages, 361);
   DMsgDlgYes.SetImgIndex (g_WMainImages, 363);
   DMsgDlgCancel.SetImgIndex (g_WMainImages, 365);
   DMsgDlgNo.SetImgIndex (g_WMainImages, 367);
   {-----------------------------------------------------------}
   //�޸����봰��
   d := g_WMainImages.Images[50];
   if d <> nil then
      DChgGamePwd.SetImgIndex (g_WMainImages, 689);
   DChgGamePwdClose.SetImgIndex (g_WMainImages, 64);
   //����״̬����
   d := g_WMain3Images.Images[207];
   if d <> nil then
      DStateWin.SetImgIndex (g_WMain3Images, 207); //����״̬  4��ͼ
   DStPageUp.SetImgIndex (g_WMainImages, 398);
   DStPageDown.SetImgIndex (g_WMainImages, 396);
   DCloseState.SetImgIndex (g_WMainImages, 371);
   DPrevState.SetImgIndex (g_WMainImages, 373);
   DNextState.SetImgIndex (g_WMainImages, 372);
   //�ڹ�
   DStateTab.SetImgIndex(g_WMain2Images, 744);
{******************************************************************************}
  {---------------------Ӣ��״̬����-------------------------}   //����$009 2007.10.21

     d := g_WMain3Images.Images[384];
   if d <> nil then
      DStateHero.SetImgIndex (g_WMain3Images, 384); //����״̬  4��ͼ
   DSHPageUp.SetImgIndex (g_WMainImages, 398);
   DSHPageDown.SetImgIndex (g_WMainImages, 396);
   DCloseHeroState.SetImgIndex (g_WMainImages, 371);
   DPrevStateHero.SetImgIndex (g_WMainImages, 373);
   DNextStateHero.SetImgIndex (g_WMainImages, 372);
   DHeroStateTab.SetImgIndex(g_WMain2Images, 746);
   //������Ʒ����
   DHeroItemBag.SetImgIndex (g_WMain3Images, 376);
   DHeroItemGridClose.SetImgIndex (g_WMainImages, 371);
   //Ӣ��ͼ��
      d := g_WMain3Images.Images[370];
   if d <> nil then
      DHeroIcon.SetImgIndex (g_WMain3Images, 385);
   d := g_WMain3Images.Images[370];
   if d <> nil then
      DHeroSpleen.SetImgIndex (g_WMain3Images, 410);
    {-------------------------------------------------------}
   //���а�
   d := g_WMain3Images.Images[420];
   if d <> nil then
      DLevelOrder.SetImgIndex (g_WMain3Images, 420);
    DLevelOrderClose.SetImgIndex(g_WmainImages,371);
    DIndividualOrder.SetImgIndex(g_Wmain3Images,443);
    DHeroOrder.SetImgIndex(g_Wmain3Images,444);
    DMasterOrder.SetImgIndex(g_Wmain3Images,445);
    DColonyHeroOrder.SetImgIndex(g_Wmain3Images,427);
    DWarriorOrder.SetImgIndex(g_Wmain3Images,431);
    DWizerdOrder.SetImgIndex(g_Wmain3Images,433);
    DTaoistOrder.SetImgIndex(g_Wmain3Images,435);
    DHeroAllOrder.SetImgIndex(g_Wmain3Images,429);
    DWarriorHeroOrder.SetImgIndex(g_Wmain3Images,437);
    DWizerdHeroOrder.SetImgIndex(g_Wmain3Images,439);
    DTaoistHeroOrder.SetImgIndex(g_Wmain3Images,441);
    DLevelOrderIndex.SetImgIndex(g_Wmain3Images,450);
    DLevelOrderPrev.SetImgIndex(g_Wmain3Images,452);
    DLevelOrderNext.SetImgIndex(g_Wmain3Images,454);
    DLevelOrderLastPage.SetImgIndex(g_Wmain3Images,456);
    DMyLevelOrder.SetImgIndex(g_Wmain3Images,458);
   {-----------------------------------------------------------}
   //����״̬����(�鿴������Ϣ)
   d := g_WMainImages.Images[370];
   if d <> nil then
      DUserState1.SetImgIndex (g_WMain3Images, 207);   //4��
   DCloseUS1.SetImgIndex (g_WMainImages, 371);
  {-------------------------------------------------------------}
   //������Ʒ����
   DItemBag.SetImgIndex (g_qingqingImages, 1);
   {-----------------------------------------------------------}
   //Shop
   DShop.SetImgIndex (g_Wmain3Images,298);
   DShopClose.SetImgIndex(g_WmainImages,371);
   DShopBuy.SetImgIndex(g_Wmain3Images,304);
   DShopPresent.SetImgIndex(g_Wmain3Images,305);
   DShopClose1.SetImgIndex(g_Wmain3Images,306);
   DShopPrev.SetImgIndex(g_WmainImages,388);
   DShopNext.SetImgIndex(g_WmainImages,387);
{******************************************************************************}
//Ԫ���������  20080316
  d := g_WMain3Images.Images[209];
  if d <> nil then
    DWSellOff.SetImgIndex(g_WMain3Images, 209);
  DSellOffClose.SetImgIndex(g_WMainImages, 371);
  DSellOffOk.SetImgIndex(g_WMain3Images, 210);
  DSellOffCancel.SetImgIndex(g_WMain3Images, 212);
//Ԫ��������Ʒ�б�
  DWSellOffList.SetImgIndex(g_WMain3Images, 277);
  DSellOffListColse.SetImgIndex(g_WMainImages, 371);
  d := g_WMain3Images.Images[251];
  if d <> nil then
    DSellOffListCancel.SetImgIndex(g_WMain3Images, 251);
  DSellOffBuyCancel.SetImgIndex(g_WMain3Images, 249);
  DSellOffBuy.SetImgIndex(g_WMain3Images, 247);
{******************************************************************************}
   //�������
(*{$IF SWH = SWH800}
   d := g_WMain3Images.Images[BOTTOMBOARD800];
{$ELSEIF SWH = SWH1024}
   d := g_WMainImages.Images[BOTTOMBOARD1024];
{$IFEND} *)
   {-----------------------------------------------------------}
   //���ܰ�ť
   DMyState.SetImgIndex (g_WMainImages, 8);
   DMyBag.SetImgIndex (g_WMainImages, 9);
   DMyMagic.SetImgIndex (g_WMainImages, 10);
   DOption.SetImgIndex (g_WMainImages, 11);
   {-----------------------------------------------------------}
   //��ݰ�ť
   DBotMiniMap.SetImgIndex (g_WMainImages, DlgConf.DBotMiniMap.Image);
   DBotTrade.SetImgIndex (g_WMainImages,DlgConf.DBotTrade.Image);
   DBotGuild.SetImgIndex (g_WMainImages,DlgConf.DBotGuild.Image);
   DBotGroup.SetImgIndex (g_WMainImages,DlgConf.DBotGroup.Image);
   DBotPlusAbil.SetImgIndex (g_WMainImages,DlgConf.DBotPlusAbil.Image);
   DBotMemo.SetImgIndex (g_WMain3Images,DlgConf.DBotMemo.Image);
   DBotExit.SetImgIndex (g_WMainImages,DlgConf.DBotExit.Image);
   DBotLogout.SetImgIndex (g_WMainImages,DlgConf.DBotLogout.Image);
   {------------------Ӣ�۰��ݰ�ť2007.10.17���-----------------------}
   RefusePublicChat.SetImgIndex(g_WMain3Images,280); //�ܾ����й�����Ϣ
   RefuseCRY.SetImgIndex(g_WMain3Images,282);    //�ܾ����к�����Ϣ
   RefuseWHISPER.SetImgIndex(g_WMain3Images,284);   //�ܾ�����˽����Ϣ
   Refuseguild.SetImgIndex(g_WMain3Images,286);  //�ܾ��л�������Ϣ
   AutoCRY.SetImgIndex(g_WMain3Images,288);   //�Զ���������
   CallHero.SetImgIndex(g_WMain3Images,372);    //�ٻ�Ӣ��
   DHelp.SetImgIndex(g_WMain2Images,495);
   DInternet.SetImgIndex(g_WMain2Images,498);
   HeroState.SetImgIndex(g_WMain3Images,373); //Ӣ��״̬��Ϣ
   HeroPackage.SetImgIndex(g_WMain3Images,374);   //Ӣ�۰���
   DBotFriend.SetImgIndex (g_WMain3Images,34);  //��ϵϵͳ
   Challenge.SetImgIndex (g_WMain3Images,36);  //��ս
   CharacterSranking.SetImgIndex (g_WMain3Images,460);  //��������
   {-----------------------------------------------------------}
   //�������ͼƬ
   DGold.SetImgIndex (g_WMainImages, 29); //��ũ�� 3�� ����
   DItemsUpBut.SetImgIndex (g_qingqingImages, 3);
   DClosebag.SetImgIndex (g_WMainImages, 371);
   DWGameGold.SetImgIndex(g_qingqingImages, 2);
   {-----------------------------------------------------------}
   //NPC�����˶Ի���
   d := g_WMainImages.Images[384];
   if d <> nil then
      DMerchantDlg.SetImgIndex (g_WMainImages, 384);
   DMerchantDlgClose.SetImgIndex (g_WMainImages, 64);
{-----------------------------------------------------------}
  //����
   d := g_WMain3Images.Images[520];
   if d <> nil then
    DBoxs.SetImgIndex(g_WMain3Images,520);
   DBoxsBelt1.SetImgIndex(g_WMain3Images, 514);
   DBoxsBelt2.SetImgIndex(g_WMain3Images, 514);
   DBoxsBelt3.SetImgIndex(g_WMain3Images, 514);
   DBoxsBelt4.SetImgIndex(g_WMain3Images, 514);
   DBoxsBelt5.SetImgIndex(g_WMain3Images, 514);
   DBoxsBelt6.SetImgIndex(g_WMain3Images, 514);
   DBoxsBelt7.SetImgIndex(g_WMain3Images, 514);
   DBoxsBelt8.SetImgIndex(g_WMain3Images, 514);
   DBoxsBelt9.SetImgIndex(g_WMain3Images, 514);
   DBoxsTautology.SetImgIndex(g_WMain3Images, 511);
{-----------------------------------------------------------}
  //װ������
   d := g_WMain3Images.Images[462];
   if d <> nil then
      DItemsUp.SetImgIndex (g_WMain3Images, 462);
   DItemsUpClose.SetImgIndex (g_WMainImages, 64);
   DItemsUpOk.SetImgIndex(g_WMain3Images, 463);
{-----------------------------------------------------------}
   //�˵��Ի���
   d := g_WMainImages.Images[385];
   if d <> nil then
      DMenuDlg.SetImgIndex (g_WMainImages, 385);
   DMenuPrev.SetImgIndex (g_WMainImages, 388);
   DMenuNext.SetImgIndex (g_WMainImages, 387);
   DMenuBuy.SetImgIndex (g_WMainImages, 386);
   DMenuClose.SetImgIndex (g_WMainImages, 64);
   {-----------------------------------------------------------}
   //����
   d := g_WMainImages.Images[392];
   if d <> nil then
      DSellDlg.SetImgIndex (g_WMainImages, 392);
   DSellDlgOk.SetImgIndex (g_WMainImages, 393);
   DSellDlgClose.SetImgIndex (g_WMainImages, 64);
   {-----------------------------------------------------------}
   //����ħ����ݶԻ���
   d := g_WMain3Images.Images[126];
   if d <> nil then
      DKeySelDlg.SetImgIndex (g_WMain3Images, 126);
   DKsF1.SetImgIndex (g_WMainImages, 232);
   DKsF2.SetImgIndex (g_WMainImages, 234);
   DKsF3.SetImgIndex (g_WMainImages, 236);
   DKsF4.SetImgIndex (g_WMainImages, 238);
   DKsF5.SetImgIndex (g_WMainImages, 240);
   DKsF6.SetImgIndex (g_WMainImages, 242);
   DKsF7.SetImgIndex (g_WMainImages, 244);
   DKsF8.SetImgIndex (g_WMainImages, 246);
   DKsConF1.SetImgIndex (g_WMain3Images, 132);
   DKsConF2.SetImgIndex (g_WMain3Images, 134);
   DKsConF3.SetImgIndex (g_WMain3Images, 136);
   DKsConF4.SetImgIndex (g_WMain3Images, 138);
   DKsConF5.SetImgIndex (g_WMain3Images, 140);
   DKsConF6.SetImgIndex (g_WMain3Images, 142);
   DKsConF7.SetImgIndex (g_WMain3Images, 144);
   DKsConF8.SetImgIndex (g_WMain3Images, 146);
   DKsNone.SetImgIndex (g_WMain3Images, 129);
   DKsOk.SetImgIndex (g_WMain3Images, 127);
   {-----------------------------------------------------------}
   //��Ի���
   d := g_WMainImages.Images[120];
   if d <> nil then
      DGroupDlg.SetImgIndex (g_WMainImages, 120);
   DGrpDlgClose.SetImgIndex (g_WMainImages, 64);
   DGrpAllowGroup.SetImgIndex (g_WMainImages, 122);
   DGrpCreate.SetImgIndex (g_WMainImages, 123);
   DGrpAddMem.SetImgIndex (g_WMainImages, 124);
   DGrpDelMem.SetImgIndex (g_WMainImages, 125);
   {-----------------------------------------------------------}
   d := g_WMainImages.Images[389];  //�� ��ȯâ
   if d <> nil then
      DDealDlg.SetImgIndex (g_WMainImages, 389);
   DDealOk.SetImgIndex (g_WMainImages, 391);
   DDealClose.SetImgIndex (g_WMainImages, 64);
   DDGold.SetImgIndex (g_WMainImages, 28);
   d := g_WMainImages.Images[390];  //�����
   if d <> nil then
      DDealRemoteDlg.SetImgIndex (g_WMainImages, 390);
   DDRGold.SetImgIndex (g_WMainImages, 28);
   {-----------------------------------------------------------}
   //�л�
   d := g_WMainImages.Images[180];
   if d <> nil then
      DGuildDlg.SetImgIndex (g_WMainImages, 180);
   DGDClose.SetImgIndex (g_WMainImages, 64);
   DGDHome.SetImgIndex (g_WMainImages, 198);
   DGDList.SetImgIndex (g_WMainImages, 200);
   DGDChat.SetImgIndex (g_WMainImages, 190);
   DGDAddMem.SetImgIndex (g_WMainImages, 182);
   DGDDelMem.SetImgIndex (g_WMainImages, 192);
   DGDEditNotice.SetImgIndex (g_WMainImages, 196);
   DGDEditGrade.SetImgIndex (g_WMainImages, 194);
   DGDAlly.SetImgIndex (g_WMainImages, 184);
   DGDBreakAlly.SetImgIndex (g_WMainImages, 186);
   DGDWar.SetImgIndex (g_WMainImages, 202);
   DGDCancelWar.SetImgIndex (g_WMainImages, 188);
   DGDUp.SetImgIndex (g_WMainImages, 373);
   DGDDown.SetImgIndex (g_WMainImages, 372);
   //�л�ͨ��༭��
   DGuildEditNotice.SetImgIndex (g_WMainImages, 204);
   DGEOk.SetImgIndex (g_WMainImages, 361);
   DGEClose.SetImgIndex (g_WMainImages, 64);
   {-----------------------------------------------------------}
   //���Ե����Ի���
   DAdjustAbility.SetImgIndex (g_WMainImages, 226);
   DAdjustAbilClose.SetImgIndex (g_WMainImages, 64);
   DAdjustAbilOk.SetImgIndex (g_WMainImages, 62);
   DPlusDC.SetImgIndex (g_WMainImages, 227);
   DPlusMC.SetImgIndex (g_WMainImages, 227);
   DPlusSC.SetImgIndex (g_WMainImages, 227);
   DPlusAC.SetImgIndex (g_WMainImages, 227);
   DPlusMAC.SetImgIndex (g_WMainImages, 227);
   DPlusHP.SetImgIndex (g_WMainImages, 227);
   DPlusMP.SetImgIndex (g_WMainImages, 227);
   DPlusHit.SetImgIndex (g_WMainImages, 227);
   DPlusSpeed.SetImgIndex (g_WMainImages, 227);
   DMinusDC.SetImgIndex (g_WMainImages, 228);
   DMinusMC.SetImgIndex (g_WMainImages, 228);
   DMinusSC.SetImgIndex (g_WMainImages, 228);
   DMinusAC.SetImgIndex (g_WMainImages, 228);
   DMinusMAC.SetImgIndex (g_WMainImages, 228);
   DMinusHP.SetImgIndex (g_WMainImages, 228);
   DMinusMP.SetImgIndex (g_WMainImages, 228);
   DMinusHit.SetImgIndex (g_WMainImages, 228);
   DMinusSpeed.SetImgIndex (g_WMainImages, 228);
{******************************************************************************}
//��ϵϵͳ
   d := g_WMain3Images.Images[475];
   if d <> nil then
      DFriendDlg.SetImgIndex (g_WMain3Images, 475);
   DFrdClose.SetImgIndex(g_WMainImages, 371);

   DFriendDlgFrd.SetImgIndex (g_WMain3Images, 481);
   DFriendDlgMasterOrder.SetImgIndex (g_WMain3Images, 482);
   DHeiMingDan.SetImgIndex (g_WMain3Images, 483);
   DAddFriend.SetImgIndex (g_WMain3Images, 485);
   DDelFriend.SetImgIndex (g_WMain3Images, 484);
   DPrevFriendDlg.SetImgIndex (g_WMainImages, 398);
   DNextFriendDlg.SetImgIndex (g_WMainImages, 396);
{******************************************************************************}
//�ƹ�1��20080508
   DGetHeroClose.SetImgIndex(g_WmainImages,371);
   d := g_WMain2Images.Images[501];
   if d <> nil then DWiGetHero.SetImgIndex (g_WMain2Images, 501);
   DSelHero1.SetImgIndex(g_Wmain2Images,508);
   DSelHero2.SetImgIndex(g_Wmain2Images,508);
   d := g_WMain2Images.Images[341];
   if d <> nil then
      DPlayDrink.SetImgIndex (g_WMain2Images, 341);
  DPlayDrinkClose.SetImgIndex(g_WMain2Images, 148);
   d := g_WMain2Images.Images[348];
   if d <> nil then
      DPlayDrinkFist.SetImgIndex(g_WMain2Images, 348);
   d := g_WMain2Images.Images[350];
   if d <> nil then
      DPlayDrinkScissors.SetImgIndex(g_WMain2Images, 350);
   d := g_WMain2Images.Images[350];
   if d <> nil then
      DPlayDrinkCloth.SetImgIndex(g_WMain2Images, 352);
   DPlayFist.SetImgIndex(g_WMain2Images, 358);
   DDrink1.SetImgIndex(g_WMain2Images, 363);
   DDrink2.SetImgIndex(g_WMain2Images, 363);
   DDrink3.SetImgIndex(g_WMain2Images, 363);
   DDrink4.SetImgIndex(g_WMain2Images, 363);
   DDrink5.SetImgIndex(g_WMain2Images, 363);
   DDrink6.SetImgIndex(g_WMain2Images, 363);
   d := g_WMain2Images.Images[340];
   if d <> nil then begin
      DWPleaseDrink.SetImgIndex (g_WMain2Images, 340);
      DPDrink1.SetImgIndex(g_WMain2Images, 365);
      DPDrink2.SetImgIndex(g_WMain2Images, 365);
      DPleaseDrinkClose.SetImgIndex(g_WMain2Images, 148);
      DPleaseDrinkDrink.SetImgIndex(g_WMain2Images, 354);
      DPleaseDrinkExit.SetImgIndex(g_WMain2Images, 356);
   end;
//�ƹ�2��
   d := g_WMain2Images.Images[584];
   if d <> nil then begin
      DWMakeWineDesk.SetImgIndex(g_WMain2Images, 584);
      DMakeWineDeskClose.SetImgIndex (g_WMainImages, 371);
      DDrunkScale.SetImgIndex(g_WMain2Images, 511);
      DLiquorProgress.SetImgIndex(g_WMain2Images, 575);
      DHeroLiquorProgress.SetImgIndex(g_WMain2Images, 575);
      DMakeWineHelp.SetImgIndex(g_WMain2Images, 590);
      DMaterialMemo.SetImgIndex(g_WMain2Images, 590);
      DStartMakeWine.SetImgIndex(g_WMain2Images, 590);
   end;
{******************************************************************************}
//��֤�� 20080612
   DWCheckNum.SetImgIndex(g_WMain3Images, 43);
   DCheckNumClose.SetImgIndex (g_WMainImages, 64);
   DCheckNumOK.SetImgIndex(g_WMain2Images, 146);
   DCheckNumChange.SetImgIndex(g_WMain2Images, 146);
{******************************************************************************}
//ʢ�����ڹ�
   //DWNewSdoAssistant.SetImgIndex(g_WMain2Images, 607);
   DWNewSdoAssistant.SetImgIndex(g_qingqingImages, 4);
   DNewSdoAssistantClose.SetImgIndex(g_WMain2Images, 279);
   {DNewSdoBasic.SetImgIndex(g_WMain2Images, 608);
   DNewSdoProtect.SetImgIndex(g_WMain2Images, 608);
   DNewSdoSkill.SetImgIndex(g_WMain2Images, 608);
   DNewSdoKey.SetImgIndex(g_WMain2Images, 608);
   DNedSdoHelp.SetImgIndex(g_WMain2Images, 608);  }
   DNewSdoBasic.SetImgIndex(g_qingqingImages, 5);
   DNewSdoProtect.SetImgIndex(g_qingqingImages, 5);
   DNewSdoSkill.SetImgIndex(g_qingqingImages, 5);
   DNewSdoKey.SetImgIndex(g_qingqingImages, 5);
   DNedSdoHelp.SetImgIndex(g_qingqingImages, 5);
   DSdoHelpUp.SetImgIndex(g_WMain2Images, 292);
   DSdoHelpNext.SetImgIndex(g_WMain2Images, 294);
{******************************************************************************}
//��ս
   d := g_WMain3Images.Images[465];
   if d <> nil then begin
    DWChallenge.SetImgIndex(g_WMain3Images, 465);
    DChallengeClose.SetImgIndex(g_WMain2Images, 148);
    DChallengeOK.SetImgIndex(g_WMain3Images, 463);
    DChallengeCancel.SetImgIndex(g_WMain3Images, 466);
   end;
end;

//��ʼ��ͼ��λ�� 20080524
procedure TFrmDlg.InitializePlace;
begin
  SplashForm.ProgressBar1.Position := SplashForm.ProgressBar1.Position + 2;
//==============================================================================
//������ʾ
   DGlory.Left := 721;
   DGlory.Top  := 152;
//==============================================================================
//�ƹ���� 20080508
   DGetHeroClose.Left := 244;
   DGetHeroClose.Top := 16;
   DGetHeroClose.Width := 14;
   DGetHeroClose.Height := 20;
   DWiGetHero.Left := 264;
   DWiGetHero.Top := 177;
   DSelHero1.Left := 66;
   DSelHero1.Top := 171;
   DSelHero2.Left := 184;
   DSelHero2.Top := 171;
   DPlayDrink.Left := 174;
   DPlayDrink.Top := 50;
   DPlayDrinkClose.Left := 428;
   DPlayDrinkClose.Top  := 34;
   DPlayDrinkFist.Left := 395;
   DPlayDrinkFist.Top  := 240;
   DPlayDrinkScissors.Left := 351;
   DPlayDrinkScissors.Top  := 250;
   DPlayDrinkCloth.Left := 342;
   DPlayDrinkCloth.Top  := 294;
   DPlayFist.Left := 390;
   DPlayFist.Top  := 286;
   DDrink1.Left := 155;
   DDrink1.Top  := 140;
   DDrink2.Left := 225;
   DDrink2.Top  := 140;
   DDrink3.Left := 100;
   DDrink3.Top  := 170;
   DDrink4.Left := 280;
   DDrink4.Top  := 170;
   DDrink5.Left := 160;
   DDrink5.Top  := 190;
   DDrink6.Left := 230;
   DDrink6.Top  := 190;
   DWPleaseDrink.Left := 200;
   DWPleaseDrink.Top := 139;
   DPDrink1.Left := 125;
   DPDrink1.Top  := 136;
   DPDrink2.Left := 210;
   DPDrink2.Top  := 165;
   DPleaseDrinkClose.Left := 376;
   DPleaseDrinkClose.Top  := 40;
   DPleaseDrinkDrink.Left := 287;
   DPleaseDrinkDrink.Top  := 263;
   DPleaseDrinkExit.Left := 338;
   DPleaseDrinkExit.Top  := 263;
   DPlayDrinkNpcNum.Left := 0;
   DPlayDrinkNpcNum.Top  := 172;
   DPlayDrinkPlayNum.Left := 269;
   DPlayDrinkPlayNum.Top := 172;
   DPlayDrinkWhoWin.Left := 173;
   DPlayDrinkWhoWin.Top  := 128;
//�ƹ�2��
   DWMakeWineDesk.Left := 380;
   DWMakeWineDesk.Top  := 50;
   DDrunkScale.Left := 79;
   DDrunkScale.Top  := 91;
   DLiquorProgress.Left := 105;
   DLiquorProgress.Top  := 275;
   DHeroLiquorProgress.Left := 105;
   DHeroLiquorProgress.Top  := 275;
   DMakeWineDeskClose.Left := 362;
   DMakeWineDeskClose.Top  := 7;
   DMakeWineHelp.Left := 17;
   DMakeWineHelp.Top  := 134;
   DMaterialMemo.Left := 17;
   DMaterialMemo.Top  := 162;
   DStartMakeWine.Left := 17;
   DStartMakeWine.Top  := 208;
   DBMateria.Width := 32;
   DBMateria.Height := 30;
   DBMateria.Left := 114;
   DBMateria.Top  := 225;

   DBWineSong.Width := 32;
   DBWineSong.Height := 30;
   DBWineSong.Left := 162;
   DBWineSong.Top  := 211;
   DBWater.Width := 32;
   DBWater.Height := 30;
   DBWater.Left := 162;
   DBWater.Top  := 244;
   DBWineCrock.Width := 32;
   DBWineCrock.Height := 30;
   DBWineCrock.Left := 208;
   DBWineCrock.Top  := 225;
   DBAssistMaterial1.Width := 32;
   DBAssistMaterial1.Height := 30;
   DBAssistMaterial1.Left := 258;
   DBAssistMaterial1.Top  := 225;
   DBAssistMaterial2.Width := 32;
   DBAssistMaterial2.Height := 30;
   DBAssistMaterial2.Left := 293;
   DBAssistMaterial2.Top  := 225;
   DBAssistMaterial3.Width := 32;
   DBAssistMaterial3.Height := 30;
   DBAssistMaterial3.Left := 328;
   DBAssistMaterial3.Top  := 225;

   DBDrug.Width := 32;
   DBDrug.Height := 30;
   DBDrug.Left := 149;
   DBDrug.Top  := 226;

   DBWine.Width := 32;
   DBWine.Height := 30;
   DBWine.Left := 220;
   DBWine.Top  := 226;

   DBWineBottle.Width := 32;
   DBWineBottle.Height := 30;
   DBWineBottle.Left := 291;
   DBWineBottle.Top  := 226;

//ʢ�����ڹ� 20080624
   DWNewSdoAssistant.Left := 200;
   DWNewSdoAssistant.Top := 140;
   DNewSdoAssistantClose.Left := 394;
   DNewSdoAssistantClose.Top := 1;
   DNewSdoBasic.Left := 10;
   DNewSdoBasic.Top := 14;
   DNewSdoProtect.Left := 58; // DNewSdoBasic+48
   DNewSdoProtect.Top := 14;
   DNewSdoSkill.Left := 106;
   DNewSdoSkill.Top := 14;
   DNewSdoKey.Left := 154;
   DNewSdoKey.Top := 14;
   DNedSdoHelp.Left := 202;
   DNedSdoHelp.Top := 14;
   //����ҳ��
   DCheckSdoNameShow.Left := 40;
   DCheckSdoNameShow.Top := 73;
   DCheckSdoNameShow.Width := 71;
   DCheckSdoNameShow.Height := 17;
   DCheckSdoDuraWarning.Left := 40;
   DCheckSdoDuraWarning.Top := 97;
   DCheckSdoDuraWarning.Width := 71;
   DCheckSdoDuraWarning.Height := 17;
   DCheckSdoAvoidShift.Top := 121;
   DCheckSdoAvoidShift.Left := 40;
   DCheckSdoAvoidShift.Width := 78;
   DCheckSdoAvoidShift.Height := 17;
   DCheckSdoExpFiltrate.Top := 145;
   DCheckSdoExpFiltrate.Left := 40;
   DCheckSdoExpFiltrate.Width := 78;
   DCheckSdoExpFiltrate.Height := 17;
   DCheckSdoItemsHint.Top := 73;
   DCheckSdoItemsHint.Left := 157;
   DCheckSdoItemsHint.Width := 71;
   DCheckSdoItemsHint.Height := 17;
   DCheckSdoShowFiltrate.Top := 97;
   DCheckSdoShowFiltrate.Left := 157;
   DCheckSdoShowFiltrate.Width := 71;
   DCheckSdoShowFiltrate.Height := 17;
   DCheckSdoAutoPickItems.Top := 121;
   DCheckSdoAutoPickItems.Left := 157;
   DCheckSdoAutoPickItems.Width := 71;
   DCheckSdoAutoPickItems.Height := 17;
   DCheckSdoPickFiltrate.Top := 145;
   DCheckSdoPickFiltrate.Left := 157;
   DCheckSdoPickFiltrate.Width := 71;
   DCheckSdoPickFiltrate.Height := 17;
   //����ҳ��
   DCheckSdoCommonHp.Top := 73;
   DCheckSdoCommonHp.Left := 40;
   DCheckSdoCommonHp.Width := 48;
   DCheckSdoCommonHp.Height := 17;
   DEdtSdoCommonHp.Top := 73;
   DEdtSdoCommonHp.Left := 89;
   DEdtSdoCommonHp.Width := 50;
   DEdtSdoCommonHp.Height := 19;
   DEdtSdoCommonHpTimer.Top := 73;
   DEdtSdoCommonHpTimer.Left := 150;
   DEdtSdoCommonHpTimer.Width := 24;
   DEdtSdoCommonHpTimer.Height := 19;
   DCheckSdoCommonMp.Top := 97;
   DCheckSdoCommonMp.Left := 40;
   DCheckSdoCommonMp.Width := 48;
   DCheckSdoCommonMp.Height := 17;
   DEdtSdoCommonMp.Top := 97;
   DEdtSdoCommonMp.Left := 89;
   DEdtSdoCommonMp.Width := 50;
   DEdtSdoCommonMp.Height := 19;
   DEdtSdoCommonMpTimer.Top := 97;
   DEdtSdoCommonMpTimer.Left := 150;
   DEdtSdoCommonMpTimer.Width := 24;
   DEdtSdoCommonMpTimer.Height := 19;
   DCheckSdoSpecialHp.Top := 145;
   DCheckSdoSpecialHp.Left := 40;
   DCheckSdoSpecialHp.Width := 48;
   DCheckSdoSpecialHp.Height := 17;
   DEdtSdoSpecialHp.Top := 145;
   DEdtSdoSpecialHp.Left := 89;
   DEdtSdoSpecialHp.Width := 50;
   DEdtSdoSpecialHp.Height := 19;
   DEdtSdoSpecialHpTimer.Top := 145;
   DEdtSdoSpecialHpTimer.Left := 150;
   DEdtSdoSpecialHpTimer.Width := 24;
   DEdtSdoSpecialHpTimer.Height := 19;
   DCheckSdoRandomHp.Top := 193;
   DCheckSdoRandomHp.Left := 40;
   DCheckSdoRandomHp.Width := 48;
   DCheckSdoRandomHp.Height := 17;
   DEdtSdoRandomHp.Top := 193;
   DEdtSdoRandomHp.Left := 89;
   DEdtSdoRandomHp.Width := 50;
   DEdtSdoRandomHp.Height := 19;
   DEdtSdoRandomHpTimer.Top := 193;
   DEdtSdoRandomHpTimer.Left := 150;
   DEdtSdoRandomHpTimer.Width := 24;
   DEdtSdoRandomHpTimer.Height := 19;
   DBtnSdoRandomName.Top := 218;
   DBtnSdoRandomName.Left := 89;
   DBtnSdoRandomName.Width := 85;
   DBtnSdoRandomName.Height := 20;

   DCheckSdoAutoDrinkWine.Top := 74;
   DCheckSdoAutoDrinkWine.Left := 290;
   DCheckSdoAutoDrinkWine.Width := 20;
   DCheckSdoAutoDrinkWine.Height := 17;
   DEdtSdoDrunkWineDegree.Top := 73;
   DEdtSdoDrunkWineDegree.Left := 317;
   DEdtSdoDrunkWineDegree.Width := 20;
   DEdtSdoDrunkWineDegree.Height := 19;

   DCheckSdoHeroAutoDrinkWine.Top := 98;
   DCheckSdoHeroAutoDrinkWine.Left := 290;
   DCheckSdoHeroAutoDrinkWine.Width := 20;
   DCheckSdoHeroAutoDrinkWine.Height := 17;
   DEdtSdoHeroDrunkWineDegree.Top := 97;
   DEdtSdoHeroDrunkWineDegree.Left := 317;
   DEdtSdoHeroDrunkWineDegree.Width := 20;
   DEdtSdoHeroDrunkWineDegree.Height := 19;

   DCheckSdoAutoDrinkDrugWine.Top := 122;
   DCheckSdoAutoDrinkDrugWine.Left := 290;
   DCheckSdoAutoDrinkDrugWine.Width := 20;
   DCheckSdoAutoDrinkDrugWine.Height := 17;
   DEdtSdoDrunkDrugWineDegree.Top := 121;
   DEdtSdoDrunkDrugWineDegree.Left := 317;
   DEdtSdoDrunkDrugWineDegree.Width := 20;
   DEdtSdoDrunkDrugWineDegree.Height := 19;

   DCheckSdoHeroAutoDrinkDrugWine.Top := 146;
   DCheckSdoHeroAutoDrinkDrugWine.Left := 290;
   DCheckSdoHeroAutoDrinkDrugWine.Width := 20;
   DCheckSdoHeroAutoDrinkDrugWine.Height := 17;
   DEdtSdoHeroDrunkDrugWineDegree.Top := 145;
   DEdtSdoHeroDrunkDrugWineDegree.Left := 317;
   DEdtSdoHeroDrunkDrugWineDegree.Width := 20;
   DEdtSdoHeroDrunkDrugWineDegree.Height := 19;
   
   //����ҳ��
   DCheckSdoLongHit.Top := 73;
   DCheckSdoLongHit.Left := 40;
   DCheckSdoLongHit.Width := 71;
   DCheckSdoLongHit.Height := 17;
   DCheckSdoAutoWideHit.Top := 97;
   DCheckSdoAutoWideHit.Left := 40;
   DCheckSdoAutoWideHit.Width := 71;
   DCheckSdoAutoWideHit.Height := 17;
   DCheckSdoAutoFireHit.Top := 121;
   DCheckSdoAutoFireHit.Left := 40;
   DCheckSdoAutoFireHit.Width := 71;
   DCheckSdoAutoFireHit.Height := 17;
   DCheckSdoZhuri.Top := 145;
   DCheckSdoZhuri.Left := 40;
   DCheckSdoZhuri.Width := 71;
   DCheckSdoZhuri.Height := 17;
   DCheckSdoAutoShield.Top := 193;
   DCheckSdoAutoShield.Left := 40;
   DCheckSdoAutoShield.Width := 71;
   DCheckSdoAutoShield.Height := 17;
   DCheckSdoHeroShield.Top := 217;
   DCheckSdoHeroShield.Left := 40;
   DCheckSdoHeroShield.Width := 106;
   DCheckSdoHeroShield.Height := 17;
   DCheckSdoAutoHide.Top := 73;
   DCheckSdoAutoHide.Left := 157;
   DCheckSdoAutoHide.Width := 71;
   DCheckSdoAutoHide.Height := 17;
   DCheckSdoAutoMagic.Top := 73;
   DCheckSdoAutoMagic.Left := 270;
   DCheckSdoAutoMagic.Width := 71;
   DCheckSdoAutoMagic.Height := 17;
   DEdtSdoAutoMagicTimer.Top := 73;
   DEdtSdoAutoMagicTimer.Left := 346;
   DEdtSdoAutoMagicTimer.Width := 24;
   DEdtSdoAutoMagicTimer.Height := 19;
   //����ҳ��
   DCheckSdoStartKey.Top := 43;
   DCheckSdoStartKey.Left := 23;
   DCheckSdoStartKey.Width := 118;
   DCheckSdoStartKey.Height := 19;
   DBtnSdoCallHeroKey.Top := 86;
   DBtnSdoCallHeroKey.Left := 255;
   DBtnSdoCallHeroKey.Width := 130;
   DBtnSdoCallHeroKey.Height := 19;

   DBtnSdoHeroAttackTargetKey.Top := 108;
   DBtnSdoHeroAttackTargetKey.Left := 255;
   DBtnSdoHeroAttackTargetKey.Width := 130;
   DBtnSdoHeroAttackTargetKey.Height := 19;

   DBtnSdoHeroGotethKey.Top := 130;
   DBtnSdoHeroGotethKey.Left := 255;
   DBtnSdoHeroGotethKey.Width := 130;
   DBtnSdoHeroGotethKey.Height := 19;

   DBtnSdoHeroStateKey.Top := 152;
   DBtnSdoHeroStateKey.Left := 255;
   DBtnSdoHeroStateKey.Width := 130;
   DBtnSdoHeroStateKey.Height := 19;

   DBtnSdoHeroGuardKey.Top := 174;
   DBtnSdoHeroGuardKey.Left := 255;
   DBtnSdoHeroGuardKey.Width := 130;
   DBtnSdoHeroGuardKey.Height := 19;

   DBtnSdoAttackModeKey.Top := 196;
   DBtnSdoAttackModeKey.Left := 255;
   DBtnSdoAttackModeKey.Width := 130;
   DBtnSdoAttackModeKey.Height := 19;

   DBtnSdoMinMapKey.Top := 218;
   DBtnSdoMinMapKey.Left := 255;
   DBtnSdoMinMapKey.Width := 130;
   DBtnSdoMinMapKey.Height := 19;

   //����ҳ��
   DSdoHelpUp.Left := 383;
   DSdoHelpUp.Top := 39;
   DSdoHelpNext.Left := 383;
   DSdoHelpNext.Top := 225;
   SplashForm.ProgressBar1.Position := SplashForm.ProgressBar1.Position + 4;
//==============================================================================
//��ս
   DWChallenge.Left := 544;
   DWChallenge.Top := 10;
   DChallengeClose.Left := 238;
   DChallengeClose.Top := 0;
   DChallengeOK.Left := 73;
   DChallengeOK.Top := 231;
   DChallengeCancel.Left := 122;
   DChallengeCancel.Top := 231;
   DChallengeGrid.Left := 26;
   DChallengeGrid.Top  := 156;
   DChallengeGrid.Width := 188;
   DChallengeGrid.Height := 34;
   DChallengeGold.Top := 198;
   DChallengeGold.Left := 26;
   DChallengeGold.Width := 41;
   DChallengeGold.Height := 20;
   DRChallengeGrid.Left := 26;
   DRChallengeGrid.Top  := 56;
   DRChallengeGrid.Width := 188;
   DRChallengeGrid.Height := 34;
//==============================================================================
//���Ե����Ի���
   DAdjustAbilClose.Left := 316;
   DAdjustAbilClose.Top := 1;
   DAdjustAbilOk.Left := 220;
   DAdjustAbilOk.Top := 298;
   DPlusDC.Left := 217;
   DPlusDC.Top := 101;
   DPlusMC.Left := 217;
   DPlusMC.Top := 121;
   DPlusSC.Left := 217;
   DPlusSC.Top := 140;
   DPlusAC.Left := 217;
   DPlusAC.Top := 160;
   DPlusMAC.Left := 217;
   DPlusMAC.Top := 181;
   DPlusHP.Left := 217;
   DPlusHP.Top := 201;
   DPlusMP.Left := 217;
   DPlusMP.Top := 220;
   DPlusHit.Left := 217;
   DPlusHit.Top := 240;
   DPlusSpeed.Left := 217;
   DPlusSpeed.Top := 261;
   DMinusDC.Left := 227;
   DMinusDC.Top := 101;
   DMinusMC.Left := 227;
   DMinusMC.Top := 121;
   DMinusSC.Left := 227;
   DMinusSC.Top := 140;
   DMinusAC.Left := 227;
   DMinusAC.Top := 160;
   DMinusMAC.Left := 227;
   DMinusMAC.Top := 181;
   DMinusHP.Left := 227;
   DMinusHP.Top := 201;
   DMinusMP.Left := 227;
   DMinusMP.Top := 220;
   DMinusHit.Left := 227;
   DMinusHit.Top := 240;
   DMinusSpeed.Left := 227;
   DMinusSpeed.Top := 261;
   DFriendDlg.Left := 160;
   DFriendDlg.Top := 120;
   DFrdClose.Left:=193;
   DFrdClose.Top:=2;
   DFriendDlgFrd.Left := 17;
   DFriendDlgFrd.Top  := 20;
   DFriendDlgMasterOrder.Left := 63;
   DFriendDlgMasterOrder.Top  := 20;
   DHeiMingDan.Left := 109;
   DHeiMingDan.Top := 20;
   DAddFriend.Left := 31;
   DAddFriend.Top  := 231;
   DDelFriend.Left := 97;
   DDelFriend.Top  := 231;
   DPrevFriendDlg.Left := 166;
   DPrevFriendDlg.Top  := 90;
   DNextFriendDlg.Left := 166;
   DNextFriendDlg.Top  := 140;
   DFriendList.Top    := 50;
   DFriendList.Left   := 38;
   DFriendList.Width  := 120;
   DFriendList.Height := 170;

   DButtonHP.Left   := 40;
   DButtonHP.Top    := 91;
   DButtonHP.Width  := 45;
   DButtonHP.Height := 90;
   DButtonMP.Left   := 87;
   DButtonMP.Top    := 91;
   DButtonMP.Width  := 45;
   DButtonMP.Height := 90;
   DWMiniMap.Left := 680;
   DWMiniMap.Top  := 0;
   DWMiniMap.Width := 120;
   DWMiniMap.Height := 120;
//==============================================================================
  SplashForm.ProgressBar1.Position := SplashForm.ProgressBar1.Position + 2;
//�л�
   DGuildDlg.Left := 0;
   DGuildDlg.Top := 0;
   DGDClose.Left := 584;
   DGDClose.Top  := 6;
   DGDHome.Left := 13;
   DGDHome.Top  := 411;
   DGDList.Left := 13;
   DGDList.Top  := 429;
   DGDChat.Left := 94;
   DGDChat.Top  := 429;
   DGDAddMem.Left := 243;
   DGDAddMem.Top  := 411;
   DGDDelMem.Left := 243;
   DGDDelMem.Top  := 429;
   DGDEditNotice.Left := 325;
   DGDEditNotice.Top  := 411;
   DGDEditGrade.Left := 325;
   DGDEditGrade.Top  := 429;
   DGDAlly.Left := 407;
   DGDAlly.Top  := 411;
   DGDBreakAlly.Left := 407;
   DGDBreakAlly.Top  := 429;
   DGDWar.Left := 529;
   DGDWar.Top  := 411;
   DGDCancelWar.Left := 529;
   DGDCancelWar.Top  := 429;
   DGDUp.Left := 595;
   DGDUp.Top  := 239;
   DGDDown.Left := 595;
   DGDDown.Top  := 291;
   //�л�ͨ��༭��
   DGEOk.Left := 514;
   DGEOk.Top := 287;
   DGEClose.Left := 584;
   DGEClose.Top := 6;
//==============================================================================
   DDealDlg.Left := 564;
   DDealDlg.Top  := 0;
   DDGrid.Left := 21;
   DDGrid.Top  := 56;
   DDGrid.Width := 180;
   DDGrid.Height := 66;
   DDealOk.Left := 155;
   DDealOk.Top := 128;
   DDealClose.Left := 220;
   DDealClose.Top := 42;
   DDGold.Left := 11;
   DDGold.Top  := 137;
   DDealRemoteDlg.Left := 344;
   DDealRemoteDlg.Top  := 0;
   DDRGrid.Left := 21;
   DDRGrid.Top  := 56;
   DDRGrid.Width := 180;
   DDRGrid.Height := 66;
   DDRGold.Left := 11;
   DDRGold.Top  := 137;
//==============================================================================
//��ӻ���
   DGroupDlg.Left := 262;
   DGroupDlg.Top  := 179;
   DGrpDlgClose.Left := 260;
   DGrpDlgClose.Top := 0;
   DGrpAllowGroup.Left := 20;
   DGrpAllowGroup.Top := 18;
   DGrpCreate.Left := 22;
   DGrpCreate.Top := 203;
   DGrpAddMem.Left := 97;
   DGrpAddMem.Top := 203;
   DGrpDelMem.Left := 172;
   DGrpDelMem.Top := 203;
//==============================================================================
//����ħ����ݶԻ���
   DKeySelDlg.Left := 212;
   DKeySelDlg.Top  := 210;
   DKsIcon.Left := 51;
   DKsIcon.Top := 31;
   DKsF1.Left := 25;
   DKsF1.Top  := 78;
   DKsF2.Left := 57;
   DKsF2.Top  := 78;
   DKsF3.Left := 89;
   DKsF3.Top  := 78;
   DKsF4.Left := 121;
   DKsF4.Top  := 78;
   DKsF5.Left := 160;
   DKsF5.Top  := 78;
   DKsF6.Left := 192;
   DKsF6.Top  := 78;
   DKsF7.Left := 224;
   DKsF7.Top  := 78;
   DKsF8.Left := 256;
   DKsF8.Top := 78;
   DKsConF1.Left := 25;
   DKsConF1.Top  := 120;
   DKsConF2.Left := 57;
   DKsConF2.Top  := 120;
   DKsConF3.Left := 89;
   DKsConF3.Top  := 120;
   DKsConF4.Left := 121;
   DKsConF4.Top  := 120;
   DKsConF5.Left := 160;
   DKsConF5.Top  := 120;
   DKsConF6.Left := 192;
   DKsConF6.Top  := 120;
   DKsConF7.Left := 224;
   DKsConF7.Top  := 120;
   DKsConF8.Left := 256;
   DKsConF8.Top := 120;
   DKsNone.Left := 296;
   DKsNone.Top  := 78;
   DKsOk.Left := 296;
   DKsOk.Top  := 120;
//==============================================================================
  SplashForm.ProgressBar1.Position := SplashForm.ProgressBar1.Position + 4;
//����
   DSellDlg.Left := 328;
   DSellDlg.Top  := 163;
   DSellDlgOk.Left := 85;
   DSellDlgOk.Top := 150;
   DSellDlgClose.Left := 115;
   DSellDlgClose.Top := 0;
   DSellDlgSpot.Left := 27;
   DSellDlgSpot.Top  := 67;
   DSellDlgSpot.Width := 61;
   DSellDlgSpot.Height := 52;
//==============================================================================
//�˵��Ի���
   DMenuDlg.Left := 138;
   DMenuDlg.Top  := 163;
   DMenuPrev.Left := 43;
   DMenuPrev.Top := 175;
   DMenuNext.Left := 90;
   DMenuNext.Top := 175;
   DMenuBuy.Left := 215;
   DMenuBuy.Top := 171;
   DMenuClose.Left := 291;
   DMenuClose.Top := 0;
//==============================================================================
  SplashForm.ProgressBar1.Position := SplashForm.ProgressBar1.Position + 2;
//װ������
   DItemsUp.Left := 402;
   DItemsUp.Top  := 163;
   DItemsUpClose.Left := 230;
   DItemsUpClose.Top := 0;
   DItemsUpOk.Left := 91;
   DItemsUpOk.Top := 176;
//==============================================================================
{//��Ӱŭ��             20080619
   DCIDSpleen.Left   := 78;
   DCIDSpleen.Top    := 92;
   DCIDSpleen.Width  := 16;
   DCIDSpleen.Height := 94; }
//==============================================================================
//����
   DLieDragon.Left := 136;
   DLieDragon.Top  := 10;
   DLieDragon.Width := 528;
   DLieDragon.Height := 371;
   DLieDragonClose.Left := 508;
   DLieDragonClose.Top := 4;
   DLieDragonClose.Width  := 17;
   DLieDragonClose.Height := 16;
   DLieDragonNextPage.Left   := 414;
   DLieDragonNextPage.Top    := 319;
   DLieDragonNextPage.Width  := 60;
   DLieDragonNextPage.Height := 18;
   DLieDragonPrevPage.Left   := 51;
   DLieDragonPrevPage.Top    := 319;
   DLieDragonPrevPage.Width  := 60;
   DLieDragonPrevPage.Height := 18;
   DGoToLieDragon.Left   := 371;
   DGoToLieDragon.Top    := 317;
   DGoToLieDragon.Width  := 108;
   DGoToLieDragon.Height := 21;
   DLieDragonNpc.Left   := 128;
   DLieDragonNpc.Top    := 50;
   DLieDragonNpc.Width  := 544;
   DLieDragonNpc.Height := 287;
   DLieDragonNpcClose.Left   := 508;
   DLieDragonNpcClose.Top    := 0;
   DLieDragonNpcClose.Width  := 17;
   DLieDragonNpcClose.Height := 16;
//==============================================================================
//����
   DBoxs.Left := 215;
   DBoxs.Top  := 164;
   DBoxsBelt1.Left := 30;
   DBoxsBelt1.Top  := 28;
   DBoxsBelt2.Left := 80;
   DBoxsBelt2.Top  := 28;
   DBoxsBelt3.Left := 130;
   DBoxsBelt3.Top  := 28;
   DBoxsBelt4.Left := 30;
   DBoxsBelt4.Top  := 76;
   DBoxsBelt5.Left := 80;
   DBoxsBelt5.Top  := 76;
   DBoxsBelt6.Left := 130;
   DBoxsBelt6.Top  := 76;
   DBoxsBelt7.Left := 30;
   DBoxsBelt7.Top  := 124;
   DBoxsBelt8.Left := 80;
   DBoxsBelt8.Top  := 124;
   DBoxsBelt9.Left := 130;
   DBoxsBelt9.Top  := 124;
   DBoxsTautology.Left := 77;
   DBoxsTautology.Top  := 175;
//==============================================================================
   SplashForm.ProgressBar1.Position := SplashForm.ProgressBar1.Position + 4;
//NPC�����˶Ի�
   DMerchantDlg.Left := 0;
   DMerchantDlg.Top := 0;
   DMerchantDlgClose.Left := 399;
   DMerchantDlgClose.Top := 1;
//==============================================================================
//�������ͼƬ
   DGold.Left := 18;
   DGold.Top  := 217;
   DItemsUpBut.Left := 299;
   DItemsUpBut.Top := 212;
   DCloseBag.Left := 336;
   DCloseBag.Top := 59;
   DCloseBag.Width := 14;
   DCloseBag.Height := 20;
   DWGameGold.Left := 230;
   DWGameGold.Top  := 207;
//==============================================================================
//Belt �����
   DBelt1.Left := 285;
   DBelt1.Width := 32;
   DBelt1.Top := 59;
   DBelt1.Height := 29;
   DBelt2.Left := 328;
   DBelt2.Width := 32;
   DBelt2.Top := 59;
   DBelt2.Height := 29;
   DBelt3.Left := 371;
   DBelt3.Width := 32;
   DBelt3.Top := 59;
   DBelt3.Height := 29;
   DBelt4.Left := 414;
   DBelt4.Width := 32;
   DBelt4.Top := 59;
   DBelt4.Height := 29;
   DBelt5.Left := 457;
   DBelt5.Width := 32;
   DBelt5.Top := 59;
   DBelt5.Height := 29;
   DBelt6.Left := 500;
   DBelt6.Width := 32;
   DBelt6.Top := 59;
   DBelt6.Height := 29;
//==============================================================================
//Ӣ�۰��ݰ�ť2007.10.17���
   RefusePublicChat.Left:=175;
   RefusePublicChat.Top:=120;
   RefuseCRY.Left:=175;
   RefuseCRY.Top:=140;
   RefuseWHISPER.Left:=175;
   RefuseWHISPER.Top:=160;
   Refuseguild.Left:=175;
   Refuseguild.Top:=180;
   AutoCRY.Left:=175;
   AutoCRY.Top:=200;
   CallHero.Left:=638;
   CallHero.Top:=109;
   DHelp.Left:= 602;
   DHelp.Top := 66;
   DInternet.Left:= 170;
   DInternet.Top := 67;
   HeroState.Left:=665;
   HeroState.Top:=109;
   HeroPackage.Left:=692;
   HeroPackage.Top:=109;
   DBotFriend.Left :=339;
   DBotFriend.Top :=104;
   Challenge.Left :=369;
   Challenge.Top :=104;
   CharacterSranking.Left :=399;
   CharacterSranking.Top :=104;
//==============================================================================
//��ݰ�ť
   DBotMiniMap.Left := DlgConf.DBotMiniMap.Left;
   DBotMiniMap.Top := DlgConf.DBotMiniMap.Top;
   DBotTrade.Left :=DlgConf.DBotTrade.Left;
   DBotTrade.Top := DlgConf.DBotTrade.Top;
   DBotGuild.Left := DlgConf.DBotGuild.Left;
   DBotGuild.Top := DlgConf.DBotGuild.Top;
   DBotGroup.Left :=DlgConf.DBotGroup.Left;
   DBotGroup.Top :=DlgConf.DBotGroup.Top;
   DBotPlusAbil.Left :=DlgConf.DBotPlusAbil.Left;
   DBotPlusAbil.Top :=DlgConf.DBotPlusAbil.Top;
   //DBotFriend.Left :=DlgConf.DBotFriend.Left;
   //DBotFriend.Top :=DlgConf.DBotFriend.Top;
   DBotMemo.Left :=DlgConf.DBotMemo.Left;
   DBotMemo.Top :=DlgConf.DBotMemo.Top;
   DBotExit.Left :=DlgConf.DBotExit.Left;
   DBotExit.Top :=DlgConf.DBotExit.Top;
   DBotLogout.Left :=DlgConf.DBotLogout.Left;
   DBotLogout.Top :=DlgConf.DBotLogout.Top;
//==============================================================================
//����20080506
   DItemsUpBelt1.Left   := 100;
   DItemsUpBelt1.Top    := 35;
   DItemsUpBelt1.Width  := 34;
   DItemsUpBelt1.Height := 31;

   DItemsUpBelt2.Left   := 40;
   DItemsUpBelt2.Top    := 110;
   DItemsUpBelt2.Width  := 34;
   DItemsUpBelt2.Height := 31;

   DItemsUpBelt3.Left   := 158;
   DItemsUpBelt3.Top    := 110;
   DItemsUpBelt3.Width  := 34;
   DItemsUpBelt3.Height := 31;
//==============================================================================
//���ܰ�ť
   DMyState.Left := 643;
   DMyState.Top := 61;
   DMyBag.Left := 682;
   DMyBag.Top := 41;
   DMyMagic.Left := 722;
   DMyMagic.Top := 21;
   DOption.Left := 764;
   DOption.Top := 11;
//==============================================================================
//�������
   DBottom.Left := 0;
   DBottom.Top  := 349;
   DBottom.Width := 800;
   DBottom.Height := 251;
//==============================================================================
//Ԫ���������  20080316
  DWSellOff.Left := 592;
  DWSellOff.Top  := 0;
  DSellOffClose.Left := 190;
  DSellOffClose.Top  := 2;
  DSellOffOk.Left := 87;
  DSellOffOk.Top  := 176;
  DSellOffCancel.Left := 148;
  DSellOffCancel.Top  := 176;
  DSellOffItemGrid.Left := 12;
  DSellOffItemGrid.Top  := 29;
  DSellOffItemGrid.Width := 180;
  DSellOffItemGrid.Height := 64;
  //Ԫ��������Ʒ�б�
  DWSellOffList.Left := 138;
  DWSellOffList.Top  := 163;
  DSellOffListColse.Left := 291;
  DSellOffListColse.Top  := 0;
  DEditSellOffName.Left := 92;
  DEditSellOffName.Top := 110;
  DEditSellOffName.Width := 90;
  DEditSellOffName.Height := 18;
  DEditSellOffNum.Left := 92;
  DEditSellOffNum.Top := 140;
  DEditSellOffNum.Width := 38;
  DEditSellOffNum.Height := 18;
  DSellOffItem0.Left   := 173;
  DSellOffItem0.Top    := 28;
  DSellOffItem0.Width  := 112;
  DSellOffItem0.Height := 15;
  DSellOffItem1.Left   := 173;
  DSellOffItem1.Top    := 43;
  DSellOffItem1.Width  := 112;
  DSellOffItem1.Height := 16;
  DSellOffItem2.Left   := 173;
  DSellOffItem2.Top    := 58;
  DSellOffItem2.Width  := 112;
  DSellOffItem2.Height := 16;
  DSellOffItem3.Left   := 173;
  DSellOffItem3.Top    := 73;
  DSellOffItem3.Width  := 112;
  DSellOffItem3.Height := 16;
  DSellOffItem4.Left   := 173;
  DSellOffItem4.Top    := 88;
  DSellOffItem4.Width  := 112;
  DSellOffItem4.Height := 16;
  DSellOffItem5.Left   := 173;
  DSellOffItem5.Top    := 103;
  DSellOffItem5.Width  := 112;
  DSellOffItem5.Height := 16;
  DSellOffItem6.Left   := 173;
  DSellOffItem6.Top    := 118;
  DSellOffItem6.Width  := 112;
  DSellOffItem6.Height := 16;
  DSellOffItem7.Left   := 173;
  DSellOffItem7.Top    := 133;
  DSellOffItem7.Width  := 112;
  DSellOffItem7.Height := 16;
  DSellOffItem8.Left   := 173;
  DSellOffItem8.Top    := 148;
  DSellOffItem8.Width  := 112;
  DSellOffItem8.Height := 16;
  DSellOffItem9.Left   := 173;
  DSellOffItem9.Top    := 163;
  DSellOffItem9.Width  := 112;
  DSellOffItem9.Height := 16;
  DSellOffListCancel.Left := 38;
  DSellOffListCancel.Top  := 182;
  DSellOffBuyCancel.Left := 40;
  DSellOffBuyCancel.Top  := 182;
  DSellOffBuy.Left := 183;
  DSellOffBuy.Top  := 182;
//==============================================================================
  SplashForm.ProgressBar1.Position := SplashForm.ProgressBar1.Position + 4;
//Stop
   DShop.Left := 0;
   DShop.Top := 0;
   DShopClose.Left := 606;
   DShopClose.Top := 5;
   DShopClose.Width := 14;
   DShopClose.Height := 20;
   DShopBuy.Left := 329;
   DShopBuy.Top  := 365;
   DShopPresent.Left := 387;
   DShopPresent.Top  := 365;
   DShopClose1.Left := 445;
   DShopClose1.Top  := 365;
   DShopPrev.Left := 197;
   DShopPrev.Top  := 349;
   DShopNext.Left := 287;
   DShopNext.Top  := 349;
   DShopImgLogo.Left:=18;
   DShopImgLogo.Top:=35;
   DShopDecorate.Left :=176;
   DShopDecorate.Top  :=13;
   DShopDecorate.Width  :=56;
   DShopDecorate.Height := 16;
   DShopSupplies.Left :=234;
   DShopSupplies.Top  :=13;
   DShopSupplies.Width  :=56;
   DShopSupplies.Height := 16;
   DshopStrengthen.Left :=292;
   DshopStrengthen.Top  :=13;
   DshopStrengthen.Width  :=56;
   DshopStrengthen.Height := 16;
   DShopFriend.Left :=350;
   DShopFriend.Top  :=13;
   DShopFriend.Width  :=56;
   DShopFriend.Height := 16;
   DShopCapacity.Left :=408;
   DShopCapacity.Top  :=13;
   DShopCapacity.Width  :=56;
   DShopCapacity.Height := 16;
   DShopSpeciallyImg1.Left :=517;
   DShopSpeciallyImg1.Top :=67;
   DShopSpeciallyImg1.Width :=90;
   DShopSpeciallyImg1.Height :=60;
   DShopSpeciallyImg2.Left :=517;
   DShopSpeciallyImg2.Top :=132;
   DShopSpeciallyImg2.Width :=90;
   DShopSpeciallyImg2.Height :=60;
   DShopSpeciallyImg3.Left :=517;
   DShopSpeciallyImg3.Top :=197;
   DShopSpeciallyImg3.Width :=90;
   DShopSpeciallyImg3.Height :=60;
   DShopSpeciallyImg4.Left :=517;
   DShopSpeciallyImg4.Top :=262;
   DShopSpeciallyImg4.Width :=90;
   DShopSpeciallyImg4.Height :=60;
   DShopSpeciallyImg5.Left :=517;
   DShopSpeciallyImg5.Top :=327;
   DShopSpeciallyImg5.Width :=90;
   DShopSpeciallyImg5.Height :=60;
   DShopImg1.Left := 178;
   DShopImg1.Top := 61;
   DShopImg1.Width := 160;
   DShopImg1.Height := 52;
   DShopImg2.Left := 349;
   DShopImg2.Top := 61;
   DShopImg2.Width := 160;
   DShopImg2.Height := 52;
   DShopImg3.Left := 178;
   DShopImg3.Top := 115;
   DShopImg3.Width := 160;
   DShopImg3.Height := 52;
   DShopImg4.Left := 349;
   DShopImg4.Top := 115;
   DShopImg4.Width := 160;
   DShopImg4.Height := 52;
   DShopImg5.Left := 178;
   DShopImg5.Top := 167;
   DShopImg5.Width := 160;
   DShopImg5.Height := 52;
   DShopImg6.Left := 349;
   DShopImg6.Top := 169;
   DShopImg6.Width := 160;
   DShopImg6.Height := 52;
   DShopImg7.Left := 178;
   DShopImg7.Top := 223;
   DShopImg7.Width := 160;
   DShopImg7.Height := 52;
   DShopImg8.Left := 349;
   DShopImg8.Top := 220;
   DShopImg8.Width := 160;
   DShopImg8.Height := 52;
   DShopImg9.Left := 178;
   DShopImg9.Top := 277;
   DShopImg9.Width := 160;
   DShopImg9.Height := 52;
   DShopImg10.Left := 349;
   DShopImg10.Top := 277;
   DShopImg10.Width := 160;
   DShopImg10.Height := 52;
   //�һ����
   DGameGirdExchange.Left   := 436;
   DGameGirdExchange.Top    := 332;
   DGameGirdExchange.Width  := 64;
   DGameGirdExchange.Height := 19;
//==============================================================================
//������Ʒ����
   DItemBag.Left := -5;
   DItemBag.Top := -25;
   DItemGrid.Left := 28;
   DItemGrid.Top  := 41;
   DItemGrid.Width := 286;
   DItemGrid.Height := 162;
//==============================================================================
//����״̬����(�鿴������Ϣ)
   DUserState1.Left := 336;
   DUserState1.Top := 0;
   DNecklaceUS1.Left := 168;
   DNecklaceUS1.Top  := 87;
   DNecklaceUS1.Width := 34;
   DNecklaceUS1.Height := 31;
   DHelmetUS1.Left := 115;
   DHelmetUS1.Top  := 93;
   DHelmetUS1.Width := 18;
   DHelmetUS1.Height := 18;
   DLightUS1.Left := 168;
   DLightUS1.Top  := 125;
   DLightUS1.Width := 34;
   DLightUS1.Height := 31;
   DArmRingRUS1.Left := 42;
   DArmRingRUS1.Top  := 176;
   DArmRingRUS1.Width := 34;
   DArmRingRUS1.Height := 31;
   DArmRingLUS1.Left := 168;
   DArmRingLUS1.Top  := 176;
   DArmRingLUS1.Width := 34;
   DArmRingLUS1.Height := 31;
   DRingRUS1.Left := 42;
   DRingRUS1.Top  := 215;
   DRingRUS1.Width := 34;
   DRingRUS1.Height := 31;
   DRingLUS1.Left := 168;
   DRingLUS1.Top  := 215;
   DRingLUS1.Width := 34;
   DRingLUS1.Height := 31;
   DWeaponUS1.Left := 47;
   DWeaponUS1.Top  := 80;
   DWeaponUS1.Width := 47;
   DWeaponUS1.Height := 87;
   DDressUS1.Left := 96;
   DDressUS1.Top  := 122;
   DDressUS1.Width := 53;
   DDressUS1.Height := 112;
   DBujukUS1.Left := 42;
   DBujukUS1.Top  := 254;
   DBujukUS1.Width := 34;
   DBujukUS1.Height := 31;
   DBeltUS1.Left := 84;
   DBeltUS1.Top  := 254;
   DBeltUS1.Width := 34;
   DBeltUS1.Height := 31;
   DBootsUS1.Left := 126;
   DBootsUS1.Top  := 254;
   DBootsUS1.Width := 34;
   DBootsUS1.Height := 31;
   DCharmUS1.Left := 168;
   DCharmUS1.Top  := 254;
   DCharmUS1.Width := 34;
   DCharmUS1.Height := 31;
   DCloseUS1.Left := 8;
   DCloseUS1.Top := 39;
  //�ڹ�
   DStateTab.Left := 38;
   DStateTab.Top := 31;
   DHeroStateTab.Left := 38;
   DHeroStateTab.Top := 31;
//==============================================================================
  SplashForm.ProgressBar1.Position := SplashForm.ProgressBar1.Position + 4;
//���а�
    DLevelOrder.Left := 236;
    DLevelOrder.Top := 20;
    DLevelOrderClose.Left := 325;
    DLevelOrderClose.Top := 47;
    DLevelOrderClose.Width := 14;
    DLevelOrderClose.Height := 20;
    DIndividualOrder.Left := 29;
    DIndividualOrder.Top := 60;
    DHeroOrder.Left := 123;
    DHeroOrder.Top := 60;
    DMasterOrder.Left := 220;
    DMasterOrder.Top := 60;
    DColonyHeroOrder.Left := 84;
    DColonyHeroOrder.Top := 110;
    DWarriorOrder.Left := 84;
    DWarriorOrder.Top := 165;
    DWizerdOrder.Left := 84;
    DWizerdOrder.Top := 220;
    DTaoistOrder.Left := 84;
    DTaoistOrder.Top := 275;
    DHeroAllOrder.Left := 84;
    DHeroAllOrder.Top := 110;
    DWarriorHeroOrder.Left := 84;
    DWarriorHeroOrder.Top := 165;
    DWizerdHeroOrder.Left := 84;
    DWizerdHeroOrder.Top := 220;
    DTaoistHeroOrder.Left := 84;
    DTaoistHeroOrder.Top := 275;
    DLevelOrderIndex.Left := 25;
    DLevelOrderIndex.Top := 342;
    DLevelOrderPrev.Left := 75;
    DLevelOrderPrev.Top := 342;
    DLevelOrderNext.Left := 125;
    DLevelOrderNext.Top := 342;
    DLevelOrderLastPage.Left := 175;
    DLevelOrderLastPage.Top := 342;
    DMyLevelOrder.Left := 245;
    DMyLevelOrder.Top := 342;
//==============================================================================
   DStateHero.Left := 477;
   DStateHero.Top := 0;
   DSHNecklace.Left := 168;
   DSHNecklace.Top  := 87;
   DSHNecklace.Width := 34;
   DSHNecklace.Height := 31;
   DSHHelmet.Left := 115;
   DSHHelmet.Top  := 93;
   DSHHelmet.Width := 18;
   DSHHelmet.Height := 18;
   DSHLight.Left := 168;
   DSHLight.Top  := 125;
   DSHLight.Width := 34;
   DSHLight.Height := 31;
   DSHArmRingR.Left := 42;
   DSHArmRingR.Top  := 176;
   DSHArmRingR.Width := 34;
   DSHArmRingR.Height := 31;
   DSHArmRingL.Left := 168;
   DSHArmRingL.Top  := 176;
   DSHArmRingL.Width := 34;
   DSHArmRingL.Height := 31;
   DSHRingR.Left := 42;
   DSHRingR.Top  := 215;
   DSHRingR.Width := 34;
   DSHRingR.Height := 31;
   DSHRingL.Left := 168;
   DSHRingL.Top  := 215;
   DSHRingL.Width := 34;
   DSHRingL.Height := 31;
   DSHWeapon.Left := 47;
   DSHWeapon.Top  := 80;
   DSHWeapon.Width := 47;
   DSHWeapon.Height := 87;
   DSHDress.Left := 96;
   DSHDress.Top  := 122;
   DSHDress.Width := 53;
   DSHDress.Height := 112;
   DSHBujuk.Left := 42;
   DSHBujuk.Top  := 254;
   DSHBujuk.Width := 34;
   DSHBujuk.Height := 31;
   DSHBelt.Left := 84;
   DSHBelt.Top  := 254;
   DSHBelt.Width := 34;
   DSHBelt.Height := 31;
   DSHBoots.Left := 126;
   DSHBoots.Top  := 254;
   DSHBoots.Width := 34;
   DSHBoots.Height := 31;
   DSHCharm.Left := 168;
   DSHCharm.Top  := 254;
   DSHCharm.Width := 34;
   DSHCharm.Height := 31;
   DStMagHero1.Left := 46;
   DStMagHero1.Top := 59;
   DStMagHero1.Width := 31;
   DStMagHero1.Height := 33;
   DStMagHero2.Left := 46;
   DStMagHero2.Top := 96;
   DStMagHero2.Width := 31;
   DStMagHero2.Height := 33;
   DStMagHero3.Left := 46;
   DStMagHero3.Top := 134;
   DStMagHero3.Width := 31;
   DStMagHero3.Height := 33;
   DStMagHero4.Left := 46;
   DStMagHero4.Top := 171;
   DStMagHero4.Width := 31;
   DStMagHero4.Height := 33;
   DStMagHero5.Left := 46;
   DStMagHero5.Top := 208;
   DStMagHero5.Width := 31;
   DStMagHero5.Height := 33;
   DStMagHero6.Left := 46;
   DStMagHero6.Top := 245;
   DStMagHero6.Width  := 31;
   DStMagHero6.Height := 33;
   DSHPageUp.Left := 213;
   DSHPageUp.Top  := 113;
   DSHPageDown.Left := 213;
   DSHPageDown.Top  := 143;
   DCloseHeroState.Left := 8;
   DCloseHeroState.Top := 39;
   DPrevStateHero.Left := 7;
   DPrevStateHero.Top := 128;
   DNextStateHero.Left := 7;
   DNextStateHero.Top := 187;
   //������Ʒ����
   DHeroItemBag.Left := 0;
   DHeroItemBag.Top := 20;
   DHeroItemGrid.Left := 15;
   DHeroItemGrid.Top  := 13;
   DHeroItemGrid.Width := 185;
   DHeroItemGrid.Height := 126;
   DHeroItemGridClose.Left := 208;
   DHeroItemGridClose.Top := 0;
   DHeroItemGridClose.Width := 14;
   DHeroItemGridClose.Height := 20;
   //Ӣ��ͼ��
   DHeroIcon.Left := 0;
   DHeroIcon.Top := 0;
   DHeroSpleen.Left := 605;
   DHeroSpleen.Top := 87;
//==============================================================================
  SplashForm.ProgressBar1.Position := SplashForm.ProgressBar1.Position + 4;
//����״̬����
   DStateWin.Left := 568;
   DStateWin.Top := 0;
   DSWNecklace.Left := 168;
   DSWNecklace.Top  := 87;
   DSWNecklace.Width := 34;
   DSWNecklace.Height := 31;
   DSWHelmet.Left := 115;
   DSWHelmet.Top  := 93;
   DSWHelmet.Width := 18;
   DSWHelmet.Height := 18;
   DSWLight.Left := 168;
   DSWLight.Top  := 125;
   DSWLight.Width := 34;
   DSWLight.Height := 31;
   DSWArmRingR.Left := 42;
   DSWArmRingR.Top  := 176;
   DSWArmRingR.Width := 34;
   DSWArmRingR.Height := 31;
   DSWArmRingL.Left := 168;
   DSWArmRingL.Top  := 176;
   DSWArmRingL.Width := 34;
   DSWArmRingL.Height := 31;
   DSWRingR.Left := 42;
   DSWRingR.Top  := 215;
   DSWRingR.Width := 34;
   DSWRingR.Height := 31;
   DSWRingL.Left := 168;
   DSWRingL.Top  := 215;
   DSWRingL.Width := 34;
   DSWRingL.Height := 31;
   DSWWeapon.Left := 47;
   DSWWeapon.Top  := 80;
   DSWWeapon.Width := 47;
   DSWWeapon.Height := 87;
   DSWDress.Left := 96;
   DSWDress.Top  := 122;
   DSWDress.Width := 53;
   DSWDress.Height := 112;
   DSWBujuk.Left := 42;
   DSWBujuk.Top  := 254;
   DSWBujuk.Width := 34;
   DSWBujuk.Height := 31;
   DSWBelt.Left := 84;
   DSWBelt.Top  := 254;
   DSWBelt.Width := 34;
   DSWBelt.Height := 31;
   DSWBoots.Left := 126;
   DSWBoots.Top  := 254;
   DSWBoots.Width := 34;
   DSWBoots.Height := 31;
   DSWCharm.Left := 168;
   DSWCharm.Top  := 254;
   DSWCharm.Width := 34;
   DSWCharm.Height := 31;
   DStMag1.Left := 46;
   DStMag1.Top := 59;
   DStMag1.Width := 31;
   DStMag1.Height := 33;
   DStMag2.Left := 46;
   DStMag2.Top := 96;
   DStMag2.Width := 31;
   DStMag2.Height := 33;
   DStMag3.Left := 46;
   DStMag3.Top := 134;
   DStMag3.Width := 31;
   DStMag3.Height := 33;
   DStMag4.Left := 46;
   DStMag4.Top := 171;
   DStMag4.Width := 31;
   DStMag4.Height := 33;
   DStMag5.Left := 46;
   DStMag5.Top := 208;
   DStMag5.Width := 31;
   DStMag5.Height := 33;
   DStMag6.Left := 46;
   DStMag6.Top := 245;
   DStMag6.Width := 31;
   DStMag6.Height := 33;
   DStPageUp.Left := 213;
   DStPageUp.Top  := 113;
   DStPageDown.Left := 213;
   DStPageDown.Top  := 143;
   DCloseState.Left := 8;
   DCloseState.Top := 39;
   DPrevState.Left := 7;
   DPrevState.Top := 128;
   DNextState.Left := 7;
   DNextState.Top := 187;
//==============================================================================
//�޸����봰��
   DChgGamePwd.Left := 190;
   DChgGamePwd.Top  := 150;
   DChgGamePwdClose.Left := 291;
   DChgGamePwdClose.Top := 8;
//==============================================================================
//NPC�Ի���
   DMsgDlg.Left := 174;
   DMsgDlg.Top := 210;
   DMsgDlgOk.Top := 126;
   DMsgDlgYes.Top := 126;
   DMsgDlgCancel.Top := 126;
   DMsgDlgNo.Top := 126;
   DCreateChr.Left := 250;
   DCreateChr.Top := 91;
   DccWarrior.Left := 48;
   DccWarrior.Top := 157;
   DccWizzard.Left := 93;
   DccWizzard.Top := 157;
   DccMonk.Left := 138;
   DccMonk.Top := 157;
   DccMale.Left := 93;
   DccMale.Top := 231;
   DccFemale.Left := 138;
   DccFemale.Top := 231;
   DccLeftHair.Left := 76;
   DccLeftHair.Top := 308;
   DccRightHair.Left := 170;
   DccRightHair.Top := 308;
   DccOk.Left := 104;
   DccOk.Top := 361;
   DccClose.Left := 248;
   DccClose.Top := 31;
//==============================================================================
//ѡ���ɫ����
   DSelectChr.Left := 0;
   DSelectChr.Top := 0;
   DSelectChr.Width := 800;
   DSelectChr.Height := 600;
   //ѡ�������Ǹ�����ť����
    DscSelect1.Left := 134;
    DscSelect1.Top := 454;
    DscSelect2.Left := 685;
    DscSelect2.Top := 454;
    DscStart.Left := 385;
    DscStart.Top := 456;
    DscNewChr.Left := 348;
    DscNewChr.Top := 486;
    DscEraseChr.Left := 347;
    DscEraseChr.Top := 506;
    DscCredits.Left := 346;
    DscCredits.Top := 527;
    DscExit.Left := 379;
    DscExit.Top := 547;

    dwRecoverChr.Left := 24;
    dwRecoverChr.Top := 26;
    btnRecvChrClose.Left := 247;
    btnRecvChrClose.Top := 30;
    btnRecover.Left := 100;
    btnRecover.Top := 360;

    dgrdRecoverName.Left := 24;
    dgrdRecoverName.Top := 122;
    dgrdRecoverName.Width := 216;
    dgrdRecoverName.Height := 224;
//==============================================================================
//�޸����봰��
   DChgPw.Left := 190;
   DChgPw.Top  := 150;
   DChgPwOk.Left := 182;
   DChgPwOk.Top := 252;
   DChgPwCancel.Left := 277;
   DChgPwCancel.Top := 251;
//==============================================================================
//�½��ʺŴ���
   DNewAccount.Left := 80;
   DNewAccount.Top := 63;
   DNewAccountOk.Left := 160;
   DNewAccountOk.Top := 417;
   DNewAccountCancel.Left := 447;
   DNewAccountCancel.Top := 419;
   DNewAccountClose.Left := 587;
   DNewAccountClose.Top := 33;
  SplashForm.ProgressBar1.Position := SplashForm.ProgressBar1.Position + 4;
//==============================================================================
//LOGO����
   DLOGO.Left := 0;
   DLOGO.Top := 0;
   DLOGO.Width := 800;
   DLOGO.Height := 600;
//==============================================================================
//��֤�� 20080612
   DWCheckNum.Left := 300;
   DWCheckNum.Top  := 200;
   DCheckNumClose.Left := 205;
   DCheckNumClose.Top := 0;
   DCheckNumOK.Left := 36;
   DCheckNumOK.Top := 113;
   DCheckNumChange.Left := 122;
   DCheckNumChange.Top := 113;
   DEditCheckNum.Left := 95;
   DEditCheckNum.Top  := 8;
   DEditCheckNum.Width := 90;
   DEditCheckNum.Height := 19;
end;

{------------------------------------------------------------------------}
//��������Ϣ״̬
procedure TFrmDlg.OpenMyStatus;
begin
   DStateWin.Visible := not DStateWin.Visible;
   PageChanged;
end;
//��ʾ�����Ϣ�Ի���
procedure TFrmDlg.OpenUserState (UserState: TUserStateInfo);
begin
   UserState1 := UserState;
   DUserState1.Visible := TRUE;
end;

//��ʾ/�ر���Ʒ�Ի���
procedure TFrmDlg.OpenItemBag;
begin
   DItemBag.Visible := not DItemBag.Visible;
   if DItemBag.Visible then
      ArrangeItemBag;
end;

//�ײ�״̬��
procedure TFrmDlg.ViewBottomBox (visible: Boolean);
begin
   DBottom.Visible := visible;
end;

// ȡ��Ӣ����Ʒ�ƶ�
procedure TFrmDlg.CancelHeroItemMoving;
var
   idx, n: integer;
begin
   if g_boHeroItemMoving then begin
      g_boHeroItemMoving := FALSE;
      idx := g_MovingHeroItem.Index;
      if idx < 0 then begin
        n := -(idx+1);
        if n in [0..13] then
          g_HeroItems[n] := g_MovingHeroItem.Item;
      end else
         if idx in [0..MAXBAGITEM-1] then begin
            if g_HeroItemArr[idx].S.Name = '' then begin
               g_HeroItemArr[idx] := g_MovingHeroItem.Item;
            end else begin
               AddHeroItemBag (g_MovingHeroItem.Item);
            end;
         end;
      g_MovingHeroItem.Item.S.Name := '';
   end;
   ArrangeHeroItemBag;
end;

// ȡ����Ʒ�ƶ�
procedure TFrmDlg.CancelItemMoving;
var
   idx, n: integer;
begin
   if g_boItemMoving then begin
      g_boItemMoving := FALSE;
      idx := g_MovingItem.Index;
      if idx < 0 then begin
         if (idx <= -20) and (idx > -30) then begin
            AddDealItem (g_MovingItem.Item);
         end else begin
            n := -(idx+1);
            //showmessage(inttostr(n));
            if n in [0..13] then begin
               g_UseItems[n] := g_MovingItem.Item;
            end;
            if n in [40..42]then begin //������Ʒ���� 20080507
               g_ItemsUpItem[n-40] := g_MovingItem.Item;
            end;
            if n in [44..45] then begin  //�����Ʒ
               g_PDrinkItem[n-44] := g_MovingItem.Item;
            end;
            if n in [46..52] then begin  //��ͨ����Ʒ
               g_WineItem[n-46] := g_MovingItem.Item;
            end;
            if n in [53..55] then begin  //ҩ����Ʒ
               g_DrugWineItem[n-53] := g_MovingItem.Item;
            end;
         end;
      end else
         if idx in [0..MAXBAGITEM-1] then begin
            if g_ItemArr[idx].S.Name = '' then begin
               g_ItemArr[idx] := g_MovingItem.Item;
            end else begin
               AddItemBag (g_MovingItem.Item);
            end;
         end;
      g_MovingItem.Item.S.Name := '';
   end;
   ArrangeItemBag;
end;

//���ƶ�����Ʒ����
procedure TFrmDlg.DropMovingItem;
begin
   if g_boItemMoving then begin
      g_boItemMoving := FALSE;
      if g_MovingItem.Item.S.Name <> '' then begin
         FrmMain.SendDropItem (g_MovingItem.Item.S.Name, g_MovingItem.Item.MakeIndex);
         AddDropItem (g_MovingItem.Item);
         g_MovingItem.Item.S.Name := '';
      end;
   end;
end;

procedure TFrmDlg.DropHeroMovingItem;//Ӣ������������Ʒ ���� 2007.11.8
begin
   if g_boHeroItemMoving then begin
      g_boHeroItemMoving := FALSE;
      if g_MovingHeroItem.Item.S.Name <> '' then begin
         FrmMain.SendHeroDropItem (g_MovingHeroItem.Item.S.Name, g_MovingHeroItem.Item.MakeIndex);
         AddDropItem (g_MovingHeroItem.Item);
         g_MovingHeroItem.Item.S.Name := '';
      end;
   end;
end;

//�����Ե����Ի���
procedure TFrmDlg.OpenAdjustAbility;
begin
   DAdjustAbility.Left := 0;
   DAdjustAbility.Top := 0;
   g_nSaveBonusPoint := g_nBonusPoint;
   FillChar (g_BonusAbilChg, sizeof(TNakedAbility), #0);
   DAdjustAbility.Visible := TRUE;
end;

procedure TFrmDlg.DBackgroundBackgroundClick(Sender: TObject);
var
   dropgold: integer;
   valstr: string;
begin
   if g_boItemMoving then begin
      DBackground.WantReturn := TRUE;
      if g_MovingItem.Item.S.Name = g_sGoldName{'���'} then begin
         g_boItemMoving := FALSE;
         g_MovingItem.Item.S.Name := '';
         //�󸶸� ���� ���� �����.
         DialogSize := 1;
         DMessageDlg ('������ ' +g_sGoldName+ ' ����?', [mbOk, mbAbort]);
         GetValidStrVal (DlgEditText, valstr, [' ']);
         dropgold := Str_ToInt (valstr, 0);
         //
         FrmMain.SendDropGold (dropgold);
      end;
      if g_MovingItem.Index >= 0 then //������ ���濡�� �����͸�..
         DropMovingItem;
   end;
   if g_boHeroItemMoving then begin
      DBackground.WantReturn := TRUE;
      if g_MovingHeroItem.Index >= 0 then //������ ���濡�� �����͸�..
      DropHeroMovingItem;
   end;
end;

procedure TFrmDlg.DBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if g_boItemMoving then begin
      DBackground.WantReturn := TRUE;
   end;
end;

procedure TFrmDlg.DBottomMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
   function ExtractUserName (line: string): string;
   var
      uname: string;
   begin
      GetValidStr3 (line, line, ['(', '!', '*', '/', ')']);
      GetValidStr3 (line, uname, [' ', '=', ':']);
      if uname <> '' then
         if (uname[1] = '/') or (uname[1] = '(') or (uname[1] = ' ') or (uname[1] = '[') then
            uname := '';
      Result := uname;
   end;
var
   n: integer;
begin
   //�������ڵײ�״̬������Ϣ��ʱ��
   if (X >= 208) and (X <= 208+374) and (Y >= SCREENHEIGHT-130) and (Y <= SCREENHEIGHT-130 + 12*9) then begin
      n := DScreen.ChatBoardTop + (Y - (SCREENHEIGHT-130)) div 12;
      if (n < DScreen.ChatStrs.Count) then begin
         if not PlayScene.EdChat.Visible then begin
            PlayScene.EdChat.Visible := TRUE;
            PlayScene.EdChat.SetFocus;
         end;
         if ssCtrl in shift then begin
            PlayScene.EdChat.Text :=DScreen.ChatStrs[n];
         end else begin
            PlayScene.EdChat.Text := '/' + ExtractUserName (DScreen.ChatStrs[n]) + ' ';
         end;

         PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
         PlayScene.EdChat.SelLength := 0;
      end else
         PlayScene.EdChat.Text := ''; 
   end;
end;

{------------------------------------------------------------------------}
////��ʾͨ�öԻ���
function  TFrmDlg.DMessageDlg (msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
const
   XBase = 324;
var
  I: Integer;
   lx, ly: integer;
   d: TDirectDrawSurface;
  procedure ShowDice();
  var
    I: Integer;
    bo05:Boolean;
  begin
    if m_nDiceCount = 1 then begin
      if m_Dice[0].n67C < 20 then begin
        if GetTickCount - m_Dice[0].dwPlayTick > 100 then begin
          if m_Dice[0].n67C div 5 = 4 then begin
            m_Dice[0].nPlayPoint:=Random(6) + 1;
          end else begin
            m_Dice[0].nPlayPoint:=m_Dice[0].n67C div 5 + 8;
          end;
          m_Dice[0].dwPlayTick:=GetTickCount();
          Inc(m_Dice[0].n67C);
        end;
        exit;
      end;//00491461
      m_Dice[0].nPlayPoint:= m_Dice[0].nDicePoint;
      if GetTickCount - m_Dice[0].dwPlayTick > 1500 then begin
        DMsgDlg.Visible:=False;
      end;
      exit;
    end;//004914AD
    
    bo05:=True;
    if m_nDiceCount > 0 then //20080629
    for I := 0 to m_nDiceCount - 1 do begin
      if m_Dice[I].n67C < m_Dice[I].n680 then begin
        if GetTickCount - m_Dice[I].dwPlayTick > 100 then begin
          if m_Dice[I].n67C div 5 = 4 then begin
            m_Dice[I].nPlayPoint:=Random(6) + 1;
          end else begin
            m_Dice[I].nPlayPoint:=m_Dice[I].n67C div 5 + 8;
          end;
          m_Dice[I].dwPlayTick:=GetTickCount();
          Inc(m_Dice[I].n67C);
        end;
        bo05:=False;
      end else begin  //004915E4
        m_Dice[I].nPlayPoint:= m_Dice[I].nDicePoint;
        if GetTickCount - m_Dice[I].dwPlayTick < 2000 then begin
          bo05:=False;
        end;
      end;
    end; //for
    if bo05 then begin
      DMsgDlg.Visible:=False;
    end;
      
  end;
begin
     
   lx := XBase;
   ly := 126;
   case DialogSize of
      0:  //С�Ի���
         begin
            d := g_WMainImages.Images[381];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (g_WMainImages, 381);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               msglx := 39;
               msgly := 38;
               lx := 90;
               ly := 36;
            end;
         end;
      1:  //��Ի��򣨺ᣩ
         begin
            d := g_WMainImages.Images[360];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (g_WMainImages, 360);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               msglx := 39;
               msgly := 38;
               lx := XBase;
               ly := 126;
            end;
         end;
      2:  //��Ի�������
         begin
            d := g_WMainImages.Images[380];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (g_WMainImages, 380);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               msglx := 23;
               msgly := 20;
               lx := 90;
               ly := 305;
            end;
         end;
   end;
   MsgText := msgstr;
   ViewDlgEdit := FALSE;
   DMsgDlg.Floating := TRUE;   //�༭�򲻿ɼ�
   DMsgDlgOk.Visible := FALSE; //��������ƶ�
   DMsgDlgYes.Visible := FALSE;
   DMsgDlgCancel.Visible := FALSE;
   DMsgDlgNo.Visible := FALSE;
   DMsgDlg.Left := (SCREENWIDTH - DMsgDlg.Width) div 2;
   DMsgDlg.Top := (SCREENHEIGHT - DMsgDlg.Height) div 2;
   //������ť
   if m_nDiceCount > 0 then //20080629
   for I := 0 to m_nDiceCount - 1 do begin
     m_Dice[I].n67C:=0;
     m_Dice[I].n680:=Random(m_nDiceCount + 2) * 5 + 10;
     m_Dice[I].nPlayPoint:=1;
     m_Dice[I].dwPlayTick:=GetTickCount();
   end;

   if mbCancel in DlgButtons then begin
      DMsgDlgCancel.Left := lx;
      DMsgDlgCancel.Top := ly;
      DMsgDlgCancel.Visible := TRUE;
      lx := lx - 110;
   end;
   if mbNo in DlgButtons then begin
      DMsgDlgNo.Left := lx;
      DMsgDlgNo.Top := ly;
      DMsgDlgNo.Visible := TRUE;
      lx := lx - 110;
   end;
   if mbYes in DlgButtons then begin
      DMsgDlgYes.Left := lx;
      DMsgDlgYes.Top := ly;
      DMsgDlgYes.Visible := TRUE;
      lx := lx - 110;
   end;
   if (mbOk in DlgButtons) or (lx = XBase) then begin    //ֻ��ȷ��
      DMsgDlgOk.Left := lx;
      DMsgDlgOk.Top := ly;
      DMsgDlgOk.Visible := TRUE;
//      lx := lx - 110;
   end;
   HideAllControls;
   DMsgDlg.ShowModal;
   if mbAbort in DlgButtons then begin
      ViewDlgEdit := TRUE; //��ʾ�༭��.
      DMsgDlg.Floating := FALSE;
      with EdDlgEdit do begin
         Text := '';
         Width := DMsgDlg.Width - 70;
         Left := (SCREENWIDTH - EdDlgEdit.Width) div 2;
         Top  := (SCREENHEIGHT - EdDlgEdit.Height) div 2 - 10;
      end;
   end;
   Result := mrOk;

   while TRUE do begin
      if not DMsgDlg.Visible then break;
      //FrmMain.DXTimerTimer (self, 0);
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;

      if m_nDiceCount > 0 then begin
        m_boPlayDice:=True;
        if m_nDiceCount > 0 then //20080629
        for I := 0 to m_nDiceCount - 1 do begin
          m_Dice[I].nX:=((DMsgDlg.Width div 2 + 6) - ((m_nDiceCount * 32 + m_nDiceCount) div 2)) + (I * 32 + I);
          m_Dice[I].nY:=DMsgDlg.Height div 2 - 14;
        end;

        ShowDice();

      end;

      if Application.Terminated then exit;
   end;
   
   EdDlgEdit.Visible := FALSE;
   RestoreHideControls;
   DlgEditText := EdDlgEdit.Text;
   if PlayScene.EdChat.Visible then PlayScene.EdChat.SetFocus;
   ViewDlgEdit := FALSE;
   Result := DMsgDlg.DialogResult;
   DialogSize := 1; //�⺻����
   m_nDiceCount:=0;
   m_boPlayDice:=False;
end;

procedure TFrmDlg.DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DMsgDlgOk then DMsgDlg.DialogResult := mrOk;
   if Sender = DMsgDlgYes then DMsgDlg.DialogResult := mrYes;
   if Sender = DMsgDlgCancel then DMsgDlg.DialogResult := mrCancel;
   if Sender = DMsgDlgNo then DMsgDlg.DialogResult := mrNo;
   DMsgDlg.Visible := FALSE;
end;

procedure TFrmDlg.DMsgDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = 13 then begin
      if DMsgDlgOk.Visible and not (DMsgDlgYes.Visible {or DMsgDlgCancel.Visible 20080713} or DMsgDlgNo.Visible) then begin
         DMsgDlg.DialogResult := mrOk;
         DMsgDlg.Visible := FALSE;
      end;
      if DMsgDlgYes.Visible and not (DMsgDlgOk.Visible or DMsgDlgCancel.Visible or DMsgDlgNo.Visible) then begin
         DMsgDlg.DialogResult := mrYes;
         DMsgDlg.Visible := FALSE;
      end;
   end;
   if Key = 27 then begin
      if DMsgDlgCancel.Visible then begin
         DMsgDlg.DialogResult := mrCancel;
         DMsgDlg.Visible := FALSE;
      end;
   end;
end;

procedure TFrmDlg.DMsgDlgOkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  tStr:String;
  nTextWidth, nTextHeight: Integer;
  //nStatus:Integer;
begin
//try
  d:=nil; //����
   //nStatus:=-1;
   with Sender as TDButton do begin
      if WLib <> nil then begin //20080701
        if not Downed then
          d := WLib.Images[FaceIndex]
        else d := WLib.Images[FaceIndex+1];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      if (Name = 'DSServer1') and (g_ServerList.Count >= 1) then begin
        tStr:=g_ServerList.Strings[0];
        //nStatus:=Integer(g_ServerList.Objects[0]);
      end;
      if (Name = 'DSServer2') and (g_ServerList.Count >= 2) then begin
        tStr:=g_ServerList.Strings[1];
        //nStatus:=Integer(g_ServerList.Objects[1]);
      end;
      if (Name = 'DSServer3') and (g_ServerList.Count >= 3) then begin
        tStr:=g_ServerList.Strings[2];
        //nStatus:=Integer(g_ServerList.Objects[2]);
      end;
      if (Name = 'DSServer4') and (g_ServerList.Count >= 4) then begin
        tStr:=g_ServerList.Strings[3];
        //nStatus:=Integer(g_ServerList.Objects[3]);
      end;
      if (Name = 'DSServer5') and (g_ServerList.Count >= 5) then begin
        tStr:=g_ServerList.Strings[4];
        //nStatus:=Integer(g_ServerList.Objects[4]);
      end;
      if (Name = 'DSServer6') and (g_ServerList.Count >= 6) then begin
        tStr:=g_ServerList.Strings[5];
        //nStatus:=Integer(g_ServerList.Objects[5]);
      end;
      {$if Version = 1}
      Color:=$0093F4F2;
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      dsurface.Canvas.Font.Name := '����';
      dsurface.Canvas.Font.Size :=12;
      dsurface.Canvas.Font.Style:=[fsBold];
      if TDButton(Sender).Downed then begin
        BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(tStr)) div 2) + 2, SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(tStr)) div 2) + 2, Color{clYellow}, clBlack, tStr);
      end else begin
        BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(tStr)) div 2), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(tStr)) div 2), Color{clYellow}, clBlack, tStr);
      end;
      dsurface.Canvas.Font.Style:=[];
      dsurface.Canvas.Font.Size :=9;
      dsurface.Canvas.Release;
      {$ELSE}                    
      Color:=$0093F4F2;
      dsurface.Canvas.Font.Size := 12;
      dsurface.Canvas.Font.Style:=[fsBold];
      nTextWidth := dsurface.Canvas.TextExtent(tStr).cx;
      nTextHeight := dsurface.Canvas.TextExtent(tStr).cy;
      dsurface.Canvas.Release;
      if TDButton(Sender).Downed then begin
        BoldTextOut (dsurface, SurfaceX(Left + (d.Width - {frmMain.Canvas.TextWidth(tStr)}nTextWidth) div 2) + 2, SurfaceY(Top + (d.Height -{frmMain.Canvas.TextHeight(tStr)}nTextHeight) div 2) + 2, Color{clYellow}, clBlack, tStr);
      end else begin
        BoldTextOut (dsurface, SurfaceX(Left + (d.Width - {frmMain.Canvas.TextWidth(tStr)}nTextWidth) div 2), SurfaceY(Top + (d.Height -{frmMain.Canvas.TextHeight(tStr)}nTextHeight) div 2), Color{clYellow}, clBlack, tStr);
      end;
      dsurface.Canvas.Font.Style:=[];
      dsurface.Canvas.Font.Size :=9;
      dsurface.Canvas.Release;
      {$IFEND}
   end;
{except
  on e: Exception do begin
    ShowMessage(E.Message);
  end; 
end; }
end;
procedure TFrmDlg.DMsgDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  I: Integer;
  d: TDirectDrawSurface;
  ly: integer;
  str, data: string;
  nX,nY:Integer;
begin
   with Sender as TDWindow do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      if m_boPlayDice then begin
        if m_nDiceCount > 0 then //20080629
        for I := 0 to m_nDiceCount - 1 do begin
          d:=g_WBagItemImages.GetCachedImage(m_Dice[I].nPlayPoint + 376 - 1,nX,nY);
          if d <> nil then begin
            dsurface.Draw (SurfaceX(Left) + m_Dice[I].nX + nX - 14, SurfaceY(Top) + m_Dice[I].nY + nY + 38, d.ClientRect, d, TRUE);
          end;
        end;
      end;
      {$if Version = 1}
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      {$IFEND}
      ly := msgly;
      str := MsgText;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then
            BoldTextOut (dsurface, SurfaceX(Left+msglx), SurfaceY(Top+ly), clWhite, clBlack, data);
         ly := ly + 14;
      end;
      dsurface.Canvas.Release;
   end;
   if ViewDlgEdit then begin
      if not EdDlgEdit.Visible then begin
         EdDlgEdit.Visible := TRUE;
         EdDlgEdit.SetFocus;
      end;
   end;   
end;




{------------------------------------------------------------------------}

//�α��� â


procedure TFrmDlg.DLoginNewDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if TDButton(Sender).Downed then begin
         if WLib <> nil then begin //20080701
           d := WLib.Images[FaceIndex];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
         end;
      end;
   end;
end;

procedure TFrmDlg.DLoginNewClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.NewClick;
end;

procedure TFrmDlg.DLoginOkClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.OkClick;
end;

procedure TFrmDlg.DLoginCloseClick(Sender: TObject; X, Y: Integer);
begin
   FrmMain.Close;
end;

procedure TFrmDlg.DLoginChgPwClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.ChgPwClick;
end;

procedure TFrmDlg.DLoginNewClickSound(Sender: TObject;
  Clicksound: TClickSound);
begin
   case Clicksound of
      csNorm:  PlaySound (s_norm_button_click);
      csStone: PlaySound (s_rock_button_click);
      csGlass: PlaySound (s_glass_button_click);
   end;
end;



{------------------------------------------------------------------------}
//��ʾѡ��������Ի���
procedure TFrmDlg.ShowSelectServerDlg;
begin
   case g_ServerList.Count of
     1:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=204;
         DSServer2.Visible:=False;
         DSServer3.Visible:=False;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     2:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=190;
         DSServer2.Visible:=True;
         DSServer2.Top:=235;
         DSServer3.Visible:=False;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     3:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     4:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     5:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=True;
         DSServer6.Visible:=False;
       end;
     6:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=True;
         DSServer6.Visible:=True;
       end;
     else begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=True;
         DSServer6.Visible:=True;
       end;
   end;
   DSelServerDlg.Visible:=TRUE;
end;
procedure TFrmDlg.DSServer1Click(Sender: TObject; X, Y: Integer);
var
  svname: string;
begin
   svname := '';
   if Sender = DSServer1 then begin
     svname:=g_ServerList.Strings[0];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer2 then begin
     svname:=g_ServerList.Strings[1];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer3 then begin
     svname:=g_ServerList.Strings[2];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer4 then begin
     svname:=g_ServerList.Strings[3];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer5 then begin
     svname:=g_ServerList.Strings[4];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer6 then begin 
     svname:=g_ServerList.Strings[5];
     g_sServerMiniName:=svname;
   end;
   if svname <> '' then begin
      //20080910ע��  û�ط��õ�
      {if BO_FOR_TEST then begin
         svname := '��������';
         g_sServerMiniName := '����';
      end;}
      FrmMain.SendSelectServer (svname);
      DSelServerDlg.Visible := FALSE;
      g_sServerName := svname;
   end;
end;
procedure TFrmDlg.DEngServer1Click(Sender: TObject; X, Y: Integer);
var
   svname: string;
begin
   svname := 'IGEM2����';
   g_sServerMiniName := svname;

   if svname <> '' then begin
      FrmMain.SendSelectServer (svname);
      DSelServerDlg.Visible := FALSE;
      g_sServerName := svname;
   end;
end;


procedure TFrmDlg.DSSrvCloseClick(Sender: TObject; X, Y: Integer);
begin
   DSelServerDlg.Visible := FALSE;
   FrmMain.Close;
end;


{------------------------------------------------------------------------}
//���ʺ�
procedure TFrmDlg.DNewAccountOkClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.NewAccountOk;
end;

procedure TFrmDlg.DNewAccountCloseClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.NewAccountClose;
end;

procedure TFrmDlg.DNewAccountDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   i: integer;
begin
   with dsurface.Canvas do begin
      with DNewAccount do begin
        if WLib <> nil then begin //20080701
         d := DMenuDlg.WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
      {$if Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clSilver;
      {$IFEND}
      if NAHelps.Count > 0 then //20080629
      for i:=0 to NAHelps.Count-1 do begin
        {$if Version = 1}
        TextOut ((SCREENWIDTH div 2 - 320) + 396, (SCREENHEIGHT div 2 - 238) + 124 + i*14, NAHelps[i]);
        {$ELSE}
        ClFunc.TextOut(dsurface, 476, 186 + i*14, clSilver, NAHelps[I]);
        {$IFEND}
      end;
      BoldTextOut (dsurface, 362, 121, clWhite, clBlack, NewAccountTitle);
      Release;
   end;
end;



{------------------------------------------------------------------------}
////Chg pw �ڽ�


procedure TFrmDlg.DChgpwOkClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DChgpwOk then LoginScene.ChgpwOk;
   if Sender = DChgpwCancel then LoginScene.ChgpwCancel;
end;




{------------------------------------------------------------------------}
//ĳ���� ����


procedure TFrmDlg.DscSelect1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if Downed and (WLib <> nil) then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (Left, Top, d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DscSelect1Click(Sender: TObject; X, Y: Integer);
begin
   if Sender = DscSelect1 then SelectChrScene.SelChrSelect1Click;
   if Sender = DscSelect2 then SelectChrScene.SelChrSelect2Click;
   if Sender = DscStart then SelectChrScene.SelChrStartClick;
   if Sender = DscNewChr then SelectChrScene.SelChrNewChrClick;
   if Sender = DscEraseChr then SelectChrScene.SelChrEraseChrClick;
   if Sender = DscCredits then SelectChrScene.SelChrCreditsClick;
   if Sender = DscExit then SelectChrScene.SelChrExitClick;
end;




{------------------------------------------------------------------------}
//�� ĳ���� ����� â


procedure TFrmDlg.DccCloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if Downed then begin
         if WLib <> nil then begin //20080701
           d := WLib.Images[FaceIndex];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
         end;
      end else begin
         d := nil;
         if Sender = DccWarrior then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Job = 0 then d := WLib.Images[55];
         end;
         if Sender = DccWizzard then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Job = 1 then d := WLib.Images[56];
         end;
         if Sender = DccMonk then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Job = 2 then d := WLib.Images[57];
         end;
         if Sender = DccMale then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Sex = 0 then d := WLib.Images[58];
         end;
         if Sender = DccFemale then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Sex = 1 then d := WLib.Images[59];
         end;
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DccCloseClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DccClose then SelectChrScene.SelChrNewClose;
   if Sender = DccWarrior then SelectChrScene.SelChrNewJob (0);
   if Sender = DccWizzard then SelectChrScene.SelChrNewJob (1);
   if Sender = DccMonk then SelectChrScene.SelChrNewJob (2);
   if Sender = DccReserved then SelectChrScene.SelChrNewJob (3);
   if Sender = DccMale then SelectChrScene.SelChrNewm_btSex (0);
   if Sender = DccFemale then SelectChrScene.SelChrNewm_btSex (1);
   if Sender = DccLeftHair then SelectChrScene.SelChrNewPrevHair;
   if Sender = DccRightHair then SelectChrScene.SelChrNewNextHair;
   if Sender = DccOk then SelectChrScene.SelChrNewOk;
end;

//������Ϣ���滭 ����2007.10.20...
procedure TFrmDlg.DStateWinDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   i, l, m, pgidx, magline, bbx, bby, mmx, idx, ax, ay, trainlv: integer;
   pm: PTClientMagic;
   d: TDirectDrawSurface;
   hcolor, old, keyimg: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
   rc: TRect;
begin
   if g_MySelf = nil then exit;
   DLiquorProgress.Visible := False;
   with DStateWin do begin
      if WLib <> nil then begin //20080701
          d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;


      d:=frmMain.UiImages(29);//FrmMain.UiDXImageList.Items.Find('StateWindowHuman').PatternSurfaces[0];
        if d<>nil then
          dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      case StateTab of
        0: begin
          case StatePage of
             0: begin //�Լ�װ��  2007.10.16 ����
                pgidx := 29;              //��4��  2007.10.16 ����
                if g_MySelf <> nil then
                   if g_MySelf.m_btSex = 1 then pgidx := 30{377};  //Ů4��  2007.10.16 ����
                bbx := Left + 38;
                bby := Top + 52;
                d := g_WMain3Images.Images[pgidx];
                if d <> nil then
                   dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);
                bbx := bbx - 7;
                bby := bby + 44;
               //�Լ����﷢��  2007.10.16 ����
                idx := 1799; //�Ӹ� ��Ÿ��
                if g_MySelf.m_btSex = 1 then  idx := 2399;
                if g_MySelf.m_btSex = 0 then begin  //��
                  if g_MySelf.m_btHair <> 0 then
                    if idx > 0 then begin
                       d := g_WHairImgImages.GetCachedImage (idx, ax, ay);
                       if d <> nil then
                          dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                    end;
                 end else if g_MySelf.m_btHair <> 1 then begin
                    if idx > 0 then begin
                       d := g_WHairImgImages.GetCachedImage (idx, ax, ay);
                       if d <> nil then
                          dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                    end;
                 end else begin
                       d := g_WHairImgImages.GetCachedImage (1199, ax, ay);
                       if d <> nil then
                          dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                 end;
                if g_UseItems[U_DRESS].S.Name <> '' then begin
                   idx := g_UseItems[U_DRESS].S.Looks; //�� if Myself.m_btSex = 1 then idx := 80; //���ڿ�
                   if idx >= 0 then begin
                      d := FrmMain.GetWStateImg(idx,ax,ay);
                      if d <> nil then
                         dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                   end;
                end;
                if g_UseItems[U_WEAPON].S.Name <> '' then begin
                   idx := g_UseItems[U_WEAPON].S.Looks;
                   if idx >= 0 then begin
                      d := FrmMain.GetWStateImg(idx,ax,ay);
                      if d <> nil then
                         dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                   end;
                end;
                //���� 20080417
                if g_UseItems[U_ZHULI].S.Name <> '' then begin
                   idx := g_UseItems[U_ZHULI].S.Looks;
                   if idx >= 0 then begin
                      d := FrmMain.GetWStateImg(idx,ax,ay);
                      if d <> nil then
                         dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                   end;
                end else
                  if g_UseItems[U_HELMET].S.Name <> '' then begin
                     idx := g_UseItems[U_HELMET].S.Looks;
                     if idx >= 0 then begin
                        d := FrmMain.GetWStateImg(idx,ax,ay);
                        if d <> nil then
                           dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                     end;
                  end;
             end;
             1: begin //״ֵ̬
                l := Left + 112; //66;
                m := Top + 99;
                with dsurface.Canvas do begin
                   {$if Version = 1}
                   SetBkMode (Handle, TRANSPARENT);
                   {$IFEND}
                   BoldTextOut(dsurface, SurfaceX(l), SurfaceY(m+0), clWhite, clBlack, IntToStr(LoWord(g_MySelf.m_Abil.AC)) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.AC)));
                   BoldTextOut(dsurface, SurfaceX(l), SurfaceY(m+20), clWhite, clBlack, IntToStr(LoWord(g_MySelf.m_Abil.MAC)) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.MAC)));
                   BoldTextOut(dsurface, SurfaceX(l), SurfaceY(m+40), clWhite, clBlack, IntToStr(LoWord(g_MySelf.m_Abil.DC)) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.DC)));
                   BoldTextOut(dsurface, SurfaceX(l), SurfaceY(m+60), clWhite, clBlack, IntToStr(LoWord(g_MySelf.m_Abil.MC)) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.MC)));
                   BoldTextOut(dsurface, SurfaceX(l), SurfaceY(m+80), clWhite, clBlack, IntToStr(LoWord(g_MySelf.m_Abil.SC)) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.SC)));
                   BoldTextOut(dsurface, SurfaceX(l), SurfaceY(m+100), clWhite, clBlack, IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP));
                   BoldTextOut(dsurface, SurfaceX(l), SurfaceY(m+120), clWhite, clBlack, IntToStr(g_MySelf.m_Abil.MP) + '/' + IntToStr(g_MySelf.m_Abil.MaxMP));
                   BoldTextOut(dsurface, SurfaceX(l), SurfaceY(m+140), clWhite, clBlack, IntToStr(g_MySelf.m_Abil.MedicineValue) + '/' + IntToStr(g_MySelf.m_Abil.MaxMedicineValue));//20080624
                   BoldTextOut(dsurface, SurfaceX(l), SurfaceY(m+160), clWhite, clBlack, IntToStr(g_MySelf.m_Abil.MaxAlcohol));
                   Release;
                end;
                DLiquorProgress.Visible := True;
             end;
             2: begin //����������ֵ
                bbx := Left + 38;
                bby := Top + 52;
                d := g_WMain3Images.Images[32];
                if d <> nil then
                   dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);

                bbx := bbx + 20;
                bby := bby + 10;
                with dsurface.Canvas do begin
                   {$if Version = 1}
                   SetBkMode (Handle, TRANSPARENT);
                   {$IFEND}
                   mmx := bbx + 85;
                   BoldTextOut (dsurface, bbx, bby, clSilver, clBlack, '��ǰ����');
                   BoldTextOut (dsurface, mmx, bby, clSilver, clBlack, IntToStr(g_MySelf.m_Abil.Exp));
                   BoldTextOut (dsurface, bbx, bby+14*1, clSilver, clBlack, '��������');
                   BoldTextOut (dsurface, mmx, bby+14*1, clSilver, clBlack, IntToStr(g_MySelf.m_Abil.MaxExp));
                   BoldTextOut (dsurface, bbx, bby+14*2, clSilver, clBlack, '��������');
                   if g_MySelf.m_Abil.Weight > g_MySelf.m_Abil.MaxWeight then
                      BoldTextOut (dsurface, mmx, bby+14*2, clRed, clBlack, IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight))
                   else   
                   BoldTextOut (dsurface, mmx, bby+14*2, clSilver, clBlack, IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight));
                   BoldTextOut (dsurface, bbx, bby+14*3, clSilver, clBlack, '��������');
                   if g_MySelf.m_Abil.WearWeight > g_MySelf.m_Abil.MaxWearWeight then
                      BoldTextOut (dsurface, mmx, bby+14*3, clRed, clBlack, IntToStr(g_MySelf.m_Abil.WearWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWearWeight))
                   else
                   BoldTextOut (dsurface, mmx, bby+14*3, clSilver, clBlack, IntToStr(g_MySelf.m_Abil.WearWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWearWeight));
                   BoldTextOut (dsurface, bbx, bby+14*4, clSilver, clBlack, '����');
                   if g_MySelf.m_Abil.HandWeight > g_MySelf.m_Abil.MaxHandWeight then
                      BoldTextOut (dsurface, mmx, bby+14*4, clRed, clBlack, IntToStr(g_MySelf.m_Abil.HandWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxHandWeight))
                   else   
                   BoldTextOut (dsurface, mmx, bby+14*4, clSilver, clBlack, IntToStr(g_MySelf.m_Abil.HandWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxHandWeight));
                   BoldTextOut (dsurface, bbx, bby+14*5, clSilver, clBlack, '��ȷ��');
                   BoldTextOut (dsurface, mmx, bby+14*5, clSilver, clBlack, IntToStr(g_nMyHitPoint));
                   BoldTextOut (dsurface, bbx, bby+14*6, clSilver, clBlack, '���ݶ�');
                   BoldTextOut (dsurface, mmx, bby+14*6, clSilver, clBlack, IntToStr(g_nMySpeedPoint));
                   BoldTextOut (dsurface, bbx, bby+14*7, clSilver, clBlack, 'ħ������');
                   BoldTextOut (dsurface, mmx, bby+14*7, clSilver, clBlack, '+' + IntToStr(g_nMyAntiMagic * 10) + '%');
                   BoldTextOut (dsurface, bbx, bby+14*8, clSilver, clBlack, '�ж�����');
                   BoldTextOut (dsurface, mmx, bby+14*8, clSilver, clBlack, '+' + IntToStr(g_nMyAntiPoison * 10) + '%');
                   BoldTextOut (dsurface, bbx, bby+14*9, clSilver, clBlack, '�ж��ָ�');
                   BoldTextOut (dsurface, mmx, bby+14*9, clSilver, clBlack, '+' + IntToStr(g_nMyPoisonRecover * 10) + '%');
                   BoldTextOut (dsurface, bbx, bby+14*10, clSilver, clBlack, '�����ָ�');
                   BoldTextOut (dsurface, mmx, bby+14*10, clSilver, clBlack, '+' + IntToStr(g_nMyHealthRecover * 10) + '%');
                   BoldTextOut (dsurface, bbx, bby+14*11, clSilver, clBlack, 'ħ���ָ�');
                   BoldTextOut (dsurface, mmx, bby+14*11, clSilver, clBlack, '+' + IntToStr(g_nMySpellRecover * 10) + '%');
                   BoldTextOut (dsurface, bbx, bby+14*12, clSilver, clBlack, g_sGameDiaMond+'��'); //���ʯ
                   BoldTextOut (dsurface, mmx, bby+14*12, clSilver, clBlack, IntToStr(g_MySelf.m_nGameDiaMond));
                   BoldTextOut (dsurface, bbx, bby+14*13, clSilver, clBlack, g_sGameGird+'����'); //���
                   BoldTextOut (dsurface, mmx, bby+14*13, clSilver, clBlack, IntToStr(g_MySelf.m_nGameGird));
                   BoldTextOut (dsurface, bbx, bby+14*14, clSilver, clBlack, g_sGameGoldName+'����'); //Ԫ��
                   BoldTextOut (dsurface, mmx, bby+14*14, clSilver, clBlack, IntToStr(g_MySelf.m_nGameGold));
                   BoldTextOut (dsurface, bbx, bby+14*15, clSilver, clBlack, g_sGamePointName+'����'); //��Ϸ��
                   BoldTextOut (dsurface, mmx, bby+14*15, clSilver, clBlack, IntToStr(g_MySelf.m_nGamePoint));
                   Release;
                end;
             end;
             3: begin //ħ������
                bbx := Left + 38;
                bby := Top + 52;
                //d := g_WMain3Images.Images[32];
                d:=FrmMain.UiDXImageList.Items.Find('HManAbility').PatternSurfaces[0];
                if d <> nil then
                   dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);

                //Ű ǥ��, lv, exp
                magtop := MagicPage * 6;
                magline := _MIN(MagicPage*6+6, g_MagicList.Count);
                for i:=magtop to magline-1 do begin
                   pm := PTClientMagic (g_MagicList[i]);
                   m := i - magtop;
                   keyimg := 0;
                   case byte(pm.Key) of
                      byte('1'): keyimg := 156;
                      byte('2'): keyimg := 157;
                      byte('3'): keyimg := 158;
                      byte('4'): keyimg := 159;
                      byte('5'): keyimg := 160;
                      byte('6'): keyimg := 161;
                      byte('7'): keyimg := 162;
                      byte('8'): keyimg := 163;
                      byte('E'): keyimg := 148;
                      byte('F'): keyimg := 149;
                      byte('G'): keyimg := 150;
                      byte('H'): keyimg := 151;
                      byte('I'): keyimg := 152;
                      byte('J'): keyimg := 153;
                      byte('K'): keyimg := 154;
                      byte('L'): keyimg := 155;
                   end;
                   if keyimg > 0 then begin
                      d := g_WMain3Images.Images[keyimg];
                      if d <> nil then
                         dsurface.Draw (bbx + 145, bby+8+m*37, d.ClientRect, d, TRUE);
                   end;
                   d := g_WMainImages.Images[112]; //lv
                   if d <> nil then begin
                      if pm.Def.wMagicId = 68 then   //��������
                      dsurface.Draw (bbx + 110, bby+15+m*37-7, d.ClientRect, d, TRUE)
                      else
                      dsurface.Draw (bbx + 48, bby+8+15+m*37, d.ClientRect, d, TRUE);
                   end;
                   d := g_WMainImages.Images[111]; //exp
                   if d <> nil then begin
                      if pm.Def.wMagicId <> 68 then
                      dsurface.Draw (bbx + 48 + 26, bby+8+15+m*37, d.ClientRect, d, TRUE);
                   end;
                   if (pm.Def.wMagicId = 68) and (pm.Level < 100) then begin
                     d := g_WMain2Images.Images[577];
                     if d <> nil then
                      dsurface.Draw (bbx + 48, bby+27+m*37, d.ClientRect, d, TRUE);
                 
                     d := g_WMain2Images.Images[578];
                       if d <> nil then begin
                         rc := d.ClientRect;
                         if g_dwExp68 > 0 then begin//�������� 20080622
                           rc.Right := Round((rc.Right-rc.Left) / g_dwMaxExp68 * g_dwExp68);
                           dsurface.Draw (bbx + 48, bby+27+m*37, rc, d, TRUE);
                        end;
                      end;
                    end;
                end;

                with dsurface.Canvas do begin
                   {$if Version = 1}
                   SetBkMode (Handle, TRANSPARENT);
                   {$IFEND}
                   for i:=magtop to magline-1 do begin
                      pm := PTClientMagic (g_MagicList[i]);
                      m := i - magtop;
                      if pm.Def.wMagicId <> 68 then
                      if not (pm.Level in [0..4]) then pm.Level := 0;
                      BoldTextOut (dsurface, bbx + 48, bby + 8 + m*37,
                                  clSilver, clBlack, pm.Def.sMagicName);
                      if pm.Def.wMagicId = 68 then begin
                        trainlv := pm.Level;
                        BoldTextOut (dsurface, bbx + 124, bby + 15 + m*37-7, clSilver, clBlack, IntToStr(pm.Level));
                      end else begin
                        if pm.Level in [0..4] then trainlv := pm.Level
                        else trainlv := 0;
                        BoldTextOut (dsurface, bbx + 48 + 16, bby + 8 + 15 + m*37, clSilver, clBlack, IntToStr(pm.Level));
                      end;
                      if pm.Def.MaxTrain[trainlv] > 0 then begin
                        if pm.Def.wMagicId <> 68 then begin
                         if trainlv < 3 then
                            BoldTextOut (dsurface, bbx + 48 + 46, bby + 8 + 15 + m*37, clSilver, clBlack, IntToStr(pm.CurTrain) + '/' + IntToStr(pm.Def.MaxTrain[trainlv]))
                         else BoldTextOut (dsurface, bbx + 48 + 46, bby + 8 + 15 + m*37, clSilver, clBlack, '-');
                        end;
                      end;
                   end;
                   Release;
                end;
             end;
          end;
        end;
        1: begin
          case InternalForcePage of
            0: begin
              d := g_WMain2Images.Images[741];
              if d<>nil then begin
                rc := d.ClientRect;
                rc.Right := d.ClientRect.Right - 4;
                rc.Bottom := d.ClientRect.Bottom - 2;
                dsurface.Draw (SurfaceX(Left) + 38, SurfaceY(Top) + 52, rc, d, False);
              end;
              d:=g_WMain2Images.Images[752];
              if d<>nil then
              dsurface.Draw (SurfaceX(Left) + 124, SurfaceY(Top) + 110, d.ClientRect, d, TRUE);
              dsurface.Draw (SurfaceX(Left) + 124, SurfaceY(Top) + 142, d.ClientRect, d, TRUE);
              dsurface.Draw (SurfaceX(Left) + 124, SurfaceY(Top) + 174, d.ClientRect, d, TRUE);
              dsurface.Draw (SurfaceX(Left) + 124, SurfaceY(Top) + 206, d.ClientRect, d, TRUE);
              {$if Version = 1}
              SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
              {$IFEND}
              BoldTextOut (dsurface, SurfaceX(Left) + 48, SurfaceY(Top) + 112, clSilver, clBlack, '��ǰ�ڹ��ȼ�');
              BoldTextOut (dsurface, SurfaceX(Left) + 48, SurfaceY(Top) + 144, clSilver, clBlack, '��ǰ�ڹ�����');
              BoldTextOut (dsurface, SurfaceX(Left) + 48, SurfaceY(Top) + 176, clSilver, clBlack, '�����ڹ�����');
              BoldTextOut (dsurface, SurfaceX(Left) + 48, SurfaceY(Top) + 208, clSilver, clBlack, '�� �� ֵ');
              BoldTextOut (dsurface, SurfaceX(Left) + 130, SurfaceY(Top) + 112, clSilver, clBlack, IntToStr(g_btInternalForceLevel));
              BoldTextOut (dsurface, SurfaceX(Left) + 130, SurfaceY(Top) + 144, clSilver, clBlack, IntToStr(g_dwExp69));
              BoldTextOut (dsurface, SurfaceX(Left) + 130, SurfaceY(Top) + 176, clSilver, clBlack, IntToStr(g_dwMaxExp69));
              BoldTextOut (dsurface, SurfaceX(Left) + 130, SurfaceY(Top) + 208, clSilver, clBlack, IntToStr(g_MySelf.m_Skill69NH)+'/'+IntToStr(g_MySelf.m_Skill69MaxNH));
              dsurface.Canvas.Release;
            end;
            1: begin
              d := g_WMain2Images.Images[743];
              if d<>nil then begin
                bbx := Left + 38;
                bby := Top + 52;
                rc := d.ClientRect;
                rc.Right := d.ClientRect.Right - 4;
                rc.Bottom := d.ClientRect.Bottom - 2;
                dsurface.Draw (bbx, bby, rc, d, False);

                //Ű ǥ��, lv, exp
                magtop := InternalForceMagicPage * 6;
                magline := _MIN(InternalForceMagicPage*6+6, g_InternalForceMagicList.Count);
                for i:=magtop to magline-1 do begin
                   pm := PTClientMagic (g_InternalForceMagicList[i]);
                   m := i - magtop;
                   d := g_WMagIconImages.Images[pm.Def.btEffect * 2];
                   if d <> nil then
                      dsurface.Draw (bbx + 8, bby+7+m*37, d.ClientRect, d, TRUE);
                      
                   d := g_WMainImages.Images[112]; //lv
                   if d <> nil then
                      dsurface.Draw (bbx + 48, bby+8+15+m*37, d.ClientRect, d, TRUE);

                   d := g_WMainImages.Images[111]; //exp
                   if d <> nil then begin
                      if pm.Def.wMagicId <> 68 then
                      dsurface.Draw (bbx + 48 + 26, bby+8+15+m*37, d.ClientRect, d, TRUE);
                   end;
                end;
                with dsurface.Canvas do begin
                   {$if Version = 1}
                   SetBkMode (Handle, TRANSPARENT);
                   {$IFEND}
                   for i:=magtop to magline-1 do begin
                      pm := PTClientMagic (g_InternalForceMagicList[i]);
                      m := i - magtop;
                      if not (pm.Level in [0..4]) then pm.Level := 0;
                      BoldTextOut (dsurface, bbx + 48, bby + 8 + m*37,
                                  clSilver, clBlack, pm.Def.sMagicName);
                      if pm.Level in [0..4] then trainlv := pm.Level
                      else trainlv := 0;
                      BoldTextOut (dsurface, bbx + 48 + 16, bby + 8 + 15 + m*37, clSilver, clBlack, IntToStr(pm.Level));
                      if pm.Def.MaxTrain[trainlv] > 0 then begin
                         if trainlv < 3 then
                            BoldTextOut (dsurface, bbx + 48 + 46, bby + 8 + 15 + m*37, clSilver, clBlack, IntToStr(pm.CurTrain) + '/' + IntToStr(pm.Def.MaxTrain[trainlv]))
                         else BoldTextOut (dsurface, bbx + 48 + 46, bby + 8 + 15 + m*37, clSilver, clBlack, '-');
                      end;
                   end;
                   Release;
                end;
              end;
            end;
          end;
        end;
      end;

      //������Ϊ��ʾ��������������Ʒ��Ϣ����ʾλ��Ϊ�����·�
      if g_MouseStateItem.S.Name <> '' then begin
         g_MouseItem := g_MouseStateItem;
         GetMouseItemInfo (iname, d1, d2, d3, useable, 1{����});
         if iname <> '' then begin
            if g_MouseItem.Dura = 0 then hcolor := clRed
            else hcolor := clWhite;
            with dsurface.Canvas do begin
               {$if Version = 1}
               SetBkMode (Handle, TRANSPARENT);
               {$IFEND}
               old := Font.Size;
               Font.Size := 9;
               BoldTextOut (dsurface,SurfaceX(Left+37), SurfaceY(Top+310), clYellow, clBlack,iname);
               BoldTextOut (dsurface,SurfaceX(Left+37+ frmMain.Canvas.TextWidth(iname)), SurfaceY(Top+310), hcolor, clBlack,d1);
               BoldTextOut (dsurface,SurfaceX(Left+37), SurfaceY(Top+310+frmMain.Canvas.TextHeight('A')+2), hcolor, clBlack,d2);
               BoldTextOut (dsurface,SurfaceX(Left+37), SurfaceY(Top+310+(frmMain.Canvas.TextHeight('A')+2)*2), hcolor, clBlack,d3);
               Font.Size := old;
               Release;
            end;
         end;
         g_MouseItem.S.Name := '';
      end;  

      {$IF Version = 1}
      //�̸�
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := g_MySelf.m_nNameColor;
         if g_boIsInternalForce then
         TextOut (SurfaceX(Left + 122 - TextWidth(FrmMain.CharName) div 2),
                  SurfaceY(Top + 16), g_MySelf.m_sUserName)
         else
         TextOut (SurfaceX(Left + 122 - TextWidth(FrmMain.CharName) div 2),
                  SurfaceY(Top + 23), g_MySelf.m_sUserName);
         if (StatePage = 0) and (StateTab = 0{����ҳ}) then begin
            Font.Color := clSilver;
            TextOut (SurfaceX(Left + 45), SurfaceY(Top + 55),
                     g_sGuildName + ' ' + g_sGuildRankName);
         end;
         Release;
      end;
      {$ELSE}
       if g_boIsInternalForce then
          ClFunc.TextOut(dsurface,SurfaceX(Left + 122 - frmMain.Canvas.TextWidth(FrmMain.CharName) div 2),
                  SurfaceY(Top + 16), g_MySelf.m_nNameColor, g_MySelf.m_sUserName)
       else
          ClFunc.TextOut(dsurface,SurfaceX(Left + 122 - frmMain.Canvas.TextWidth(FrmMain.CharName) div 2),
                  SurfaceY(Top + 23), g_MySelf.m_nNameColor, g_MySelf.m_sUserName);
       if (StatePage = 0) and (StateTab = 0{����ҳ}) then begin
          ClFunc.TextOut (dsurface, SurfaceX(Left + 45), SurfaceY(Top + 55),
                   clSilver, g_sGuildName + ' ' + g_sGuildRankName);
       end;
       dsurface.Canvas.Release;
      {$IFEND}
   end;
end;

procedure TFrmDlg.DSWLightDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
  if (g_UseItems[U_NECKLACE].S.Reserved1 = 1) or (g_UseItems[U_RIGHTHAND].S.Reserved1 = 1)
      or (g_UseItems[U_ARMRINGR].S.Reserved1 = 1) or (g_UseItems[U_ARMRINGL].S.Reserved = 1)
      or (g_UseItems[U_RINGR].S.Reserved1 = 1) or (g_UseItems[U_RINGL].S.Reserved1 = 1)
      or (g_UseItems[U_BUJUK].S.Reserved1 = 1) or (g_UseItems[U_BELT].S.Reserved1 = 1)
      or (g_UseItems[U_BOOTS].S.Reserved1 = 1) or (g_UseItems[U_CHARM].S.Reserved1 = 1) then
      ItemLightTimeImg(); //��Ʒ����任���� 20080223

   if (StateTab = 0{����ҳ}) and (StatePage = 0) then begin
      if Sender = DSWNecklace then begin
         if g_UseItems[U_NECKLACE].S.Name <> '' then begin  //����
            idx := g_UseItems[U_NECKLACE].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWNecklace.SurfaceX(DSWNecklace.Left + (DSWNecklace.Width - d.Width) div 2),
                                 DSWNecklace.SurfaceY(DSWNecklace.Top + (DSWNecklace.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_UseItems[U_NECKLACE].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSWNecklace.SurfaceX(DSWNecklace.Left-21), DSWNecklace.SurfaceY(DSWNecklace.Top-23), d, 1);
              end;
            end;
         end;
      end;
      if Sender = DSWLight then begin
         if g_UseItems[U_RIGHTHAND].S.Name <> '' then begin  //������Ʒ
            idx := g_UseItems[U_RIGHTHAND].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWLight.SurfaceX(DSWLight.Left + (DSWLight.Width - d.Width) div 2),
                                 DSWLight.SurfaceY(DSWLight.Top + (DSWLight.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);

              if g_UseItems[U_RIGHTHAND].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSWLight.SurfaceX(DSWLight.Left-21), DSWLight.SurfaceY(DSWLight.Top-23), d, 1);
              end;
            end;
         end;
      end;
      if Sender = DSWArmRingR then begin
         if g_UseItems[U_ARMRINGR].S.Name <> '' then begin
            idx := g_UseItems[U_ARMRINGR].S.Looks;     //��������,��
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWArmRingR.SurfaceX(DSWArmRingR.Left + (DSWArmRingR.Width - d.Width) div 2),
                                 DSWArmRingR.SurfaceY(DSWArmRingR.Top + (DSWArmRingR.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);

              if g_UseItems[U_ARMRINGR].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSWArmRingR.SurfaceX(DSWArmRingR.Left-21), DSWArmRingR.SurfaceY(DSWArmRingR.Top-23), d, 1);
              end;
            end;
         end;
      end;
      if Sender = DSWArmRingL then begin
         if g_UseItems[U_ARMRINGL].S.Name <> '' then begin
            idx := g_UseItems[U_ARMRINGL].S.Looks;   //��������
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWArmRingL.SurfaceX(DSWArmRingL.Left + (DSWArmRingL.Width - d.Width) div 2),
                                 DSWArmRingL.SurfaceY(DSWArmRingL.Top + (DSWArmRingL.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);

              if g_UseItems[U_ARMRINGL].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSWArmRingL.SurfaceX(DSWArmRingL.Left-21), DSWArmRingL.SurfaceY(DSWArmRingL.Top-23), d, 1);
              end;
            end;
         end;
      end;
      if Sender = DSWRingR then begin
         if g_UseItems[U_RINGR].S.Name <> '' then begin
            idx := g_UseItems[U_RINGR].S.Looks;      //�ҽ�ָ
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWRingR.SurfaceX(DSWRingR.Left + (DSWRingR.Width - d.Width) div 2),
                                 DSWRingR.SurfaceY(DSWRingR.Top + (DSWRingR.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);

              if g_UseItems[U_RINGR].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSWRingR.SurfaceX(DSWRingR.Left-21), DSWRingR.SurfaceY(DSWRingR.Top-23), d, 1);
              end;
            end;
         end;
      end;
      if Sender = DSWRingL then begin
         if g_UseItems[U_RINGL].S.Name <> '' then begin
            idx := g_UseItems[U_RINGL].S.Looks; //���ָ
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWRingL.SurfaceX(DSWRingL.Left + (DSWRingL.Width - d.Width) div 2),
                                 DSWRingL.SurfaceY(DSWRingL.Top + (DSWRingL.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);

              if g_UseItems[U_RINGL].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSWRingL.SurfaceX(DSWRingL.Left-21), DSWRingL.SurfaceY(DSWRingL.Top-23), d, 1);
              end;
            end;
         end;
      end;

      if Sender = DSWBujuk then begin
         if g_UseItems[U_BUJUK].S.Name <> '' then begin
            idx := g_UseItems[U_BUJUK].S.Looks; //4����ķ��ط�
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWBujuk.SurfaceX(DSWBujuk.Left + (DSWBujuk.Width - d.Width) div 2),
                                 DSWBujuk.SurfaceY(DSWBujuk.Top + (DSWBujuk.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);

              if g_UseItems[U_BUJUK].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSWBujuk.SurfaceX(DSWBujuk.Left-21), DSWBujuk.SurfaceY(DSWBujuk.Top-23), d, 1);
              end;
            end;
         end;
      end;

      if Sender = DSWBelt then begin
         if g_UseItems[U_BELT].S.Name <> '' then begin
            idx := g_UseItems[U_BELT].S.Looks;   //����
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWBelt.SurfaceX(DSWBelt.Left + (DSWBelt.Width - d.Width) div 2),
                                 DSWBelt.SurfaceY(DSWBelt.Top + (DSWBelt.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);

              if g_UseItems[U_BELT].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSWBelt.SurfaceX(DSWBelt.Left-21), DSWBelt.SurfaceY(DSWBelt.Top-23), d, 1);
              end;
            end;
         end;
      end;

      if Sender = DSWBoots then begin
         if g_UseItems[U_BOOTS].S.Name <> '' then begin
            idx := g_UseItems[U_BOOTS].S.Looks;  //Ь
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWBoots.SurfaceX(DSWBoots.Left + (DSWBoots.Width - d.Width) div 2),
                                 DSWBoots.SurfaceY(DSWBoots.Top + (DSWBoots.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);

              if g_UseItems[U_BOOTS].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSWBoots.SurfaceX(DSWBoots.Left-21), DSWBoots.SurfaceY(DSWBoots.Top-23), d, 1);
              end;
            end;
         end;
      end;

      if Sender = DSWCharm then begin
         if g_UseItems[U_CHARM].S.Name <> '' then begin
            idx := g_UseItems[U_CHARM].S.Looks; //��ʯ
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWCharm.SurfaceX(DSWCharm.Left + (DSWCharm.Width - d.Width) div 2),
                                 DSWCharm.SurfaceY(DSWCharm.Top + (DSWCharm.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);

              if g_UseItems[U_CHARM].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSWCharm.SurfaceX(DSWCharm.Left-21), DSWCharm.SurfaceY(DSWCharm.Top-23), d, 1);
              end;
            end;
         end;
      end;

   end;
end;

procedure TFrmDlg.DStateWinClick(Sender: TObject; X, Y: Integer);
begin
   if StatePage = 3 then begin
      X := DStateWin.LocalX (X) - DStateWin.Left;
      Y := DStateWin.LocalY (Y) - DStateWin.Top;
      if (X >= 33) and (X <= 33+166) and (Y >= 55) and (Y <= 55+37*5) then begin
         magcur := (Y-55) div 37;
         if (magcur+magtop) >= g_MagicList.Count then
            magcur := (g_MagicList.Count-1) - magtop;
      end;
   end;
end;

procedure TFrmDlg.DCloseStateClick(Sender: TObject; X, Y: Integer);
begin
   DStateWin.Visible := FALSE;
end;

procedure TFrmDlg.DPrevStateDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if TDButton(Sender).Downed then begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
   end;
end;

procedure TFrmDlg.PageChanged;
begin
   DScreen.ClearHint;
   case StatePage of
      3: begin //ħ�� ����â
         DStMag1.Visible := TRUE;  DStMag2.Visible := TRUE;
         DStMag3.Visible := TRUE;  DStMag4.Visible := TRUE;
         DStMag5.Visible := TRUE;  DStMag6.Visible := True;
         DStPageUp.Visible := TRUE;
         DStPageDown.Visible := TRUE;
         MagicPage := 0;
      end;
      else begin
         DStMag1.Visible := FALSE;  DStMag2.Visible := FALSE;
         DStMag3.Visible := FALSE;  DStMag4.Visible := FALSE;
         DStMag5.Visible := FALSE;  DStMag6.Visible := FALSE;
         DStPageUp.Visible := FALSE;
         DStPageDown.Visible := FALSE;
      end;
   end;
end;

procedure TFrmDlg.InternalForcePageChanged;
begin
   DScreen.ClearHint;
   case InternalForcePage of
      1: begin //ħ�� ����â
         DStPageUp.Visible := TRUE;
         DStPageDown.Visible := TRUE;
         InternalForceMagicPage := 0;
      end;
      else begin
         DStPageUp.Visible := FALSE;
         DStPageDown.Visible := FALSE;
      end;
   end;
end;

procedure TFrmDlg.HeroInternalForcePageChanged;
begin
   DScreen.ClearHint;
   case HeroInternalForcePage of
      1: begin //ħ�� ����â
         DSHPageUp.Visible := TRUE;
         DSHPageDown.Visible := TRUE;
         HeroInternalForceMagicPage := 0;
      end;
      else begin
         DSHPageUp.Visible := FALSE;
         DSHPageDown.Visible := FALSE;
      end;
   end;
end;

procedure TFrmDlg.DPrevStateClick(Sender: TObject; X, Y: Integer);
begin
  if StateTab = 0 then begin
    Dec (StatePage);
    if StatePage < 0 then
      StatePage := MAXSTATEPAGE-1;
    PageChanged;
  end else begin   //�ڹ�
    Dec (InternalForcePage);
    if InternalForcePage < 0 then
      InternalForcePage := 1;
    InternalForcePageChanged;
  end;
end;

procedure TFrmDlg.DNextStateClick(Sender: TObject; X, Y: Integer);
begin
  if StateTab = 0 then begin
    Inc (StatePage);
    if StatePage > MAXSTATEPAGE-1 then
      StatePage := 0;
    PageChanged;
  end else begin //�ڹ�
    Inc (InternalForcePage);
    if InternalForcePage > 1 then
      InternalForcePage := 0;
    InternalForcePageChanged;
  end;
end;
//����������·���װ��
procedure TFrmDlg.DSWWeaponClick(Sender: TObject; X, Y: Integer);
var
   where, n, sel: integer;
   flag: Boolean;
   msg: TDefaultMessage;
begin
   if g_MySelf = nil then exit;
   if not g_boRightItem {��������Ҽ�������Ʒ} then  if (StateTab <> 0) or (StatePage <> 0) then exit;
   if g_boItemMoving or g_boRightItem{�Ҽ�����Ʒ} then begin
      flag := FALSE;
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Item.S.Name = '') or (g_WaitingUseItem.Item.S.Name <> '') then exit;
      where := GetTakeOnPosition (g_MovingItem.Item.S.StdMode);
      if g_MovingItem.Index >= 0 then begin

      //��Ź���Ʒ����չ   20080315
      if ((g_UseItems[U_BUJUK].s.StdMode = 2) and (g_UseItems[U_BUJUK].s.AniCount = 21) and (Byte(g_UseItems[U_BUJUK].s.Source) = g_MovingItem.Item.s.Shape) and (g_UseItems[U_BUJUK].s.Shape = g_MovingItem.Item.s.StdMode)) and (not (g_MovingItem.Item.s.StdMode in [5,6,10,11])) then begin
         if Sender = DSWBujuk then begin
           g_WaitingUseItem := g_MovingItem;
           g_MovingItem.Item.s.Name := '';
           g_boItemMoving := False;
           msg := MakeDefaultMsg (CM_REPAIRDRAGON,g_WaitingUseItem.Item.MakeIndex, 4, 0, 0, frmMain.Certification);//20071231
           FrmMain.SendSocket (EncodeMessage (msg)+Encodestring(g_WaitingUseItem.Item.s.Name));//20071231
           //Exit;
         end;
      end;
      //����ʯ�޸�
      if (g_UseItems[U_BUJUK].s.StdMode = 25) and (g_UseItems[U_BUJUK].s.Shape = 10) and (g_MovingItem.Item.s.StdMode = 43) and (g_MovingItem.Item.s.Shape = 1) then begin
         if Sender = DSWBujuk then begin
            g_WaitingUseItem := g_MovingItem;
            g_MovingItem.Item.s.Name := '';
            g_boItemMoving := False;
            msg := MakeDefaultMsg (CM_REPAIRFINEITEM,g_WaitingUseItem.Item.MakeIndex, 0, 0, 0, frmMain.Certification);//20080507
            FrmMain.SendSocket (EncodeMessage (msg)+Encodestring(g_WaitingUseItem.Item.s.Name));//20080507
         end;
      end;
         case where of
            {X_RepairFir: begin //�޲�����֮��
             if Sender = DSHBujuk then begin
               if (g_UseItems[U_BUJUK].s.Shape = 9) and (g_UseItems[U_BUJUK].s.StdMode = 25) and (g_MovingItem.Item.s.StdMode = 42) then begin
                 msg := MakeDefaultMsg (CM_REPAIRFIRDRAGON,g_MovingHeroItem.Item.MakeIndex, 4, 0, 0, Certification);//20071231
                 FrmMain.SendSocket (EncodeMessage (msg)+Encodestring(g_MovingHeroItem.Item.s.Name));//20071231
               end;
             end;
            end; }
            //�·�
            U_DRESS: begin
               if Sender = DSWDress then begin
                  if g_MySelf.m_btSex = 0 then //�е�
                     if g_MovingItem.Item.S.StdMode <> 10 then //10��ʽ�·�
                        exit;
                  if g_MySelf.m_btSex = 1 then //Ů��
                     if g_MovingItem.Item.S.StdMode <> 11 then //11��ʽ�·�
                        exit;
                  flag := TRUE;
               end;
            end;
            //����
            U_WEAPON: begin
               if Sender = DSWWEAPON then begin
                  flag := TRUE;
               end;
            end;
            //����
            U_NECKLACE: begin
               if Sender = DSWNecklace then
                  flag := TRUE;
            end;
             //���򡢻�ѡ�ʥ�ơ�ѫ��֮���
            U_RIGHTHAND: begin
               if Sender = DSWLight then
                  flag := TRUE;
            end;
            U_HELMET: begin
            //ͷ��
               if Sender = DSWHelmet then  //ԭ������
                  flag := TRUE;
            end;
            U_ZHULI: begin
            //����
              if Sender = DSWHelmet then
                 flag := True;
            end;
            //��ָ�����Ҷ����ԣ�
            U_RINGR, U_RINGL: begin
               if Sender = DSWRingL then begin
                  where := U_RINGL;
                  flag := TRUE;
               end;
               if Sender = DSWRingR then begin
                  where := U_RINGR;
                  flag := TRUE;
               end;
            end;
            //��������(���Ҷ�����)
            U_ARMRINGR: begin  
               if Sender = DSWArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
               if Sender = DSWArmRingR then begin
                  where := U_ARMRINGR;
                  flag := TRUE;
               end;
            end;
            //�������ҩ��֮���
            U_ARMRINGL: begin  
               if Sender = DSWArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
            end;
            //�������ҩ��֮���
            U_BUJUK: begin
               if Sender = DSWBujuk then begin
               {if (g_UseItems[U_BUJUK].s.StdMode = 2) and (g_UseItems[U_BUJUK].s.AniCount = 21) and (g_UseItems[U_BUJUK].s.Source = g_MovingItem.Item.s.Shape) then begin
                 msg := MakeDefaultMsg (CM_REPAIRDRAGON,g_MovingItem.Item.MakeIndex, 4, 0, 0, Certification);//20071231
                 FrmMain.SendSocket (EncodeMessage (msg)+Encodestring(g_MovingItem.Item.s.Name));//20071231
                 Exit;
               end;   }
                 case g_MovingItem.Item.s.StdMode of
                   2: begin //ף���ޣ�ħ���
                     if (g_MovingItem.Item.s.StdMode = 2) and (g_MovingItem.Item.s.AniCount = 21) then
                     begin
                      where := U_BUJUK;
                      flag := TRUE;
                     end;
                   end;
                    25: begin //��
                      where := U_BUJUK;
                      flag := TRUE;
                    end;
                 end;
               end;
               if Sender = DSWArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
            end;
            //����
            U_BELT: begin
               if Sender = DSWBelt then begin
                  where := U_BELT;
                  flag := TRUE;
               end;
            end;
            //Ь��
            U_BOOTS: begin
               if Sender = DSWBoots then begin
                  where := U_BOOTS;
                  flag := TRUE;
               end;
            end;
            //��ʯ
            U_CHARM: begin
               if Sender = DSWCharm then begin
                  where := U_CHARM;
                  flag := TRUE;
               end;
            end;
         end;
      end else begin
         n := -(g_MovingItem.Index+1);
         if n in [0..13] then begin
            ItemClickSound (g_MovingItem.Item.S);
            g_UseItems[n] := g_MovingItem.Item;
            g_MovingItem.Item.S.Name := '';
            g_boItemMoving := FALSE;
            g_boRightItem := FALSE; {�Ҽ�����Ʒ}
         end;
      end;
      if flag then begin
         ItemClickSound (g_MovingItem.Item.S);
         g_WaitingUseItem := g_MovingItem;
         g_WaitingUseItem.Index := where;
         FrmMain.SendTakeOnItem (where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
         g_MovingItem.Item.S.Name := '';
         g_boItemMoving := FALSE;
         g_boRightItem := FALSE;{�Ҽ�����װ��}
      end;
   end else begin
      if g_boHeroItemMoving then Exit;
      if (g_MovingItem.Item.S.Name <> '') or (g_WaitingUseItem.Item.S.Name <> '') then exit;
      sel := -1;
      if Sender = DSWDress then sel := U_DRESS;
      if Sender = DSWWeapon then sel := U_WEAPON;

      //if Sender = DSWHelmet then sel := U_HELMET;

      //����
      if Sender = DSWHelmet then begin
        if g_UseItems[U_ZHULI].s.Name <> '' then
         sel := U_ZHULI
        else sel := U_HELMET;
      end;

      if Sender = DSWNecklace then sel := U_NECKLACE;
      if Sender = DSWLight then sel := U_RIGHTHAND;
      if Sender = DSWRingL then sel := U_RINGL;
      if Sender = DSWRingR then sel := U_RINGR;
      if Sender = DSWArmRingL then sel := U_ARMRINGL;
      if Sender = DSWArmRingR then sel := U_ARMRINGR;

      if Sender = DSWBujuk then sel := U_BUJUK;
      if Sender = DSWBelt then sel := U_BELT;  //
      if Sender = DSWBoots then sel := U_BOOTS;
      if Sender = DSWCharm then sel := U_CHARM;

      if sel >= 0 then begin
         if g_UseItems[sel].S.Name <> '' then begin
            ItemClickSound (g_UseItems[sel].S);
            g_MovingItem.Index := -(sel+1);
            g_MovingItem.Item := g_UseItems[sel];
            g_UseItems[sel].S.Name := '';
            g_boItemMoving := TRUE;
         end;
      end;
   end;
end;

procedure TFrmDlg.DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
//  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  sel: integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
  hcolor: TColor;
  Butt:TDButton;
begin
   if (StateTab <> 0{���ǻ���ҳ}) or (StatePage <> 0) then Exit;
   sel := -1;
   Butt:=TDButton(Sender);
   if Sender = DSWDress then sel := U_DRESS;
   if Sender = DSWWeapon then sel := U_WEAPON;
   if Sender = DSWHelmet then sel := U_HELMET;
   if Sender = DSWNecklace then sel := U_NECKLACE;
   if Sender = DSWLight then sel := U_RIGHTHAND;
   if Sender = DSWRingL then sel := U_RINGL;
   if Sender = DSWRingR then sel := U_RINGR;
   if Sender = DSWArmRingL then sel := U_ARMRINGL;
   if Sender = DSWArmRingR then sel := U_ARMRINGR;

   if Sender = DSWBujuk then sel := U_BUJUK;
   if Sender = DSWBelt then sel := U_BELT;
   if Sender = DSWBoots then sel := U_BOOTS;
   if Sender = DSWCharm then sel := U_CHARM;
   
   if sel >= 0 then begin
      g_MouseStateItem := g_UseItems[sel];
      //ԭΪע�͵� ��ʾ�������ϴ�����Ʒ��Ϣ

      if Sender = DSWHelmet then begin
        if g_UseItems[U_ZHULI].s.Name <> '' then begin
          g_MouseItem := g_UseItems[U_ZHULI];
          GetMouseItemInfo (iname, d1, d2, d3, useable, 1{����});
          if iname <> '' then begin
            if g_UseItems[U_ZHULI].Dura = 0 then hcolor := clRed
            else hcolor := clYellow;

            nHintX:=DSWHelmet.SurfaceX(DSWHelmet.Left) + DSWHelmet.Width * 2;
            nHintY:=DSWHelmet.SurfaceY(DSWHelmet.Top);
            with Butt as TDButton do
              DScreen.ShowHint(nHintX,nHintY,
                             iname  + '\'+ d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
          end;
          g_MouseItem.S.Name := '';
        end;
      end;
      (*g_MouseItem := g_UseItems[sel];
      GetMouseItemInfo (iname, d1, d2, d3, useable, 1{����});
      if iname <> '' then begin
         if g_UseItems[sel].Dura = 0 then hcolor := clRed
         else hcolor := clWhite;

         nLocalX:=Butt.LocalX(X - Butt.Left);
         nLocalY:=Butt.LocalY(Y - Butt.Top);
         nHintX:=Butt.SurfaceX(Butt.Left) + DStateWin.SurfaceX(DStateWin.Left) + nLocalX;
         nHintY:=Butt.SurfaceY(Butt.Top) + DStateWin.SurfaceY(DStateWin.Top) + nLocalY;

         with Butt as TDButton do
          DScreen.ShowHint(nHintX,nHintY,
                             iname + d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
      end;
      g_MouseItem.S.Name := '';  *)
      //

   end;
end;

procedure TFrmDlg.DStateWinMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   DScreen.ClearHint;
   g_MouseStateItem.S.Name := '';
end;


//����â : ħ�� ������

procedure TFrmDlg.DStMag1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx, icon: integer;
   d: TDirectDrawSurface;
   pm: PTClientMagic;
begin
   with Sender as TDButton do begin
      idx := _Max(Tag + MagicPage * 6, 0);
      if idx < g_MagicList.Count then begin
         pm := PTClientMagic (g_MagicList[idx]);
         if pm.Def.btEffect = 91 then icon := 0   //�������ħ������ͼ��  20080229
         else icon := pm.Def.btEffect * 2;
         if icon >= 0 then begin
            if not Downed then begin
               d := g_WMagIconImages.Images[icon];
               if d <> nil then
                  dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
            end else begin
               d := g_WMagIconImages.Images[icon+1];
               if d <> nil then
                  dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
            end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DStMag1Click(Sender: TObject; X, Y: Integer);
var
   i, idx: integer;
   selkey: word;
   keych: char;
   pm: PTClientMagic;
   icon :Integer;   //�������ħ������ͼ��  20080229
begin
   if StatePage = 3 then begin
      idx := TDButton(Sender).Tag + magtop;
      if (idx >= 0) and (idx < g_MagicList.Count) then begin

         pm := PTClientMagic (g_MagicList[idx]);
         selkey := word(pm.Key);
         if pm.Def.btEffect = 91 then icon := 0 //�������ħ������ͼ��  20080229
         else icon := pm.Def.btEffect * 2;
         SetMagicKeyDlg (icon, pm.Def.sMagicName, selkey); //�������ħ������ͼ��  20080229
         keych := char(selkey);

         if g_MagicList.Count > 0 then //20080629
         for i:=0 to g_MagicList.Count-1 do begin
            pm := PTClientMagic (g_MagicList[i]);
            if pm.Key = keych then begin
               pm.Key := #0;
               FrmMain.SendMagicKeyChange (pm.Def.wMagicId, #0);
            end;
         end;
         pm := PTClientMagic (g_MagicList[idx]);
         pm.Key := keych;
         FrmMain.SendMagicKeyChange (pm.Def.wMagicId, keych);
      end;
   end;
end;

procedure TFrmDlg.DStPageUpClick(Sender: TObject; X, Y: Integer);
begin
  if StateTab = 0 then begin
     if Sender = DStPageUp then begin
        if MagicPage > 0 then
           Dec (MagicPage);
     end else begin
        if MagicPage < (g_MagicList.Count+5) div 6 - 1 then
           Inc (MagicPage);
     end;
  end else begin
     if Sender = DStPageUp then begin
        if InternalForceMagicPage > 0 then
           Dec (InternalForceMagicPage);
     end else begin
        if InternalForceMagicPage < (g_InternalForceMagicList.Count+5) div 6 - 1 then
           Inc (InternalForceMagicPage);
     end;
  end;
end;





{------------------------------------------------------------------------}
//�ײ�״̬
{------------------------------------------------------------------------}
procedure TFrmDlg.DBottomDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d:TDirectDrawSurface;
  rc:TRect;
  btop, sx, sy, i, fcolor, bcolor: integer;
  r: Real;
begin

{$IF SWH = SWH800}
  d:=g_WMain3Images.Images[BOTTOMBOARD800];
{$ELSEIF SWH = SWH1024}
  d:=g_WMainImages.Images[BOTTOMBOARD1024];
{$IFEND}
  if d <> nil then
    dsurface.Draw (DBottom.Left, DBottom.Top, d.ClientRect, d, TRUE);
  btop := 0;
  if d <> nil then begin
    with d.ClientRect do
       rc := Rect (Left, Top, Right, Top+120);
    btop := SCREENHEIGHT - d.height;
    //�ϰ벿͸��
    dsurface.Draw (0, btop, rc, d, TRUE);
    //�°벿��͸��
    with d.ClientRect do
      rc := Rect (Left, Top+120, Right, Bottom);
    dsurface.Draw (0, btop + 120, rc, d, FALSE);
  end;

   d := nil;
   case g_nDayBright of
      0: d := g_WMainImages.Images[15];  //����
      1: d := g_WMainImages.Images[12];  //����
      2: d := g_WMainImages.Images[13];  //����
      3: d := g_WMainImages.Images[14];  //����
   end;
   if d <> nil then
     dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 348)){748}, 79+DBottom.Top, d.ClientRect, d, FALSE);

   if g_MySelf <> nil then begin
      //��ʾHP��MP ͼ��
      if (g_MySelf.m_Abil.MaxHP > 0) and (g_MySelf.m_Abil.MaxMP > 0) then begin
         if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level < 28) then begin //��ʿ
            d := g_WMainImages.Images[5];
            if d <> nil then begin
               rc := d.ClientRect;
               rc.Right := d.ClientRect.Right - 2;
               dsurface.Draw (38, btop+90, rc, d, FALSE);
            end;
            d := g_WMainImages.Images[6];
            if d <> nil then begin
               rc := d.ClientRect;
               rc.Right := d.ClientRect.Right - 2;
               rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
               dsurface.Draw (38, btop+90+rc.Top, rc, d, FALSE);
            end;
         end else begin
            d := g_WMainImages.Images[4];
            if d <> nil then begin
               //HP ͼ��
               rc := d.ClientRect;
               rc.Right := d.ClientRect.Right div 2 - 1;                        
               rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
               dsurface.Draw (40, btop+91+rc.Top, rc, d, FALSE);
               //MP ͼ��
               rc := d.ClientRect;
               rc.Left := d.ClientRect.Right div 2 + 1;
               rc.Right := d.ClientRect.Right - 1;
               rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxMP * (g_MySelf.m_Abil.MaxMP - g_MySelf.m_Abil.MP));
               dsurface.Draw (40 + rc.Left, btop+91+rc.Top, rc, d, FALSE);
            end;
         end;
      end;

      //�ȼ�
      with dsurface.Canvas do begin
        PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 104, IntToStr(g_MySelf.m_Abil.Level));
      end;

      with dsurface.Canvas do begin
        {$if Version = 1}
        SetBkMode (Handle, TRANSPARENT);
        {$IFEND}
        {-----------------����Ļ���½���ʾ����ģʽ ���� 2008.02.28--------------------------------------}
        BoldTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (385 - 220)){660}, SCREENHEIGHT - 125, clWhite, clBlack, g_sAttackMode);
        {-----------------����Ļ���½���ʾʱ�� ���� 2007.11.5--------------------------------------}
        BoldTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (385 - 258)){660}, SCREENHEIGHT - 21, clWhite, clBlack, FormatDateTime('hh:mm:ss',Now));
        {-----------------����Ļ���½���ʾ����Ѫ���� ���� 2007.11.5--------------------------------------}
        BoldTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (1032 - 260)){660}, SCREENHEIGHT - 37, clWhite, clBlack, (format('%d/%d',[g_MySelf.m_Abil.HP,g_MySelf.m_Abil.MaxHP])));
        BoldTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (965 - 260)){660}, SCREENHEIGHT - 37, clWhite, clBlack, (format('%d/%d',[g_MySelf.m_Abil.MP,g_MySelf.m_Abil.MaxMP])));
        Release;
      end;

      if (g_MySelf.m_Abil.MaxExp > 0) and (g_MySelf.m_Abil.MaxWeight > 0) then begin
         d := g_WMainImages.Images[7];
         if d <> nil then begin
            //������
            rc := d.ClientRect;
            if g_MySelf.m_Abil.Exp > 0 then r := g_MySelf.m_Abil.MaxExp / g_MySelf.m_Abil.Exp
            else r := 0;
            if r > 0 then rc.Right := Round (rc.Right / r)
            else rc.Right := 0;
            dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 266)){666}, SCREENHEIGHT - 73, rc, d, FALSE);
            //����������
            rc := d.ClientRect;
            if g_MySelf.m_Abil.Weight > 0 then r := g_MySelf.m_Abil.MaxWeight / g_MySelf.m_Abil.Weight
            else r := 0;
            if r > 0 then rc.Right := Round (rc.Right / r)
            else rc.Right := 0;
            dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 266)){666}, SCREENHEIGHT - 40, rc, d, FALSE);
         end;
      end;
      //�����̶�
      if g_nMyHungryState in [1..4] then begin
        d := g_WMainImages.Images[16 + g_nMyHungryState-1];
        if d <> nil then begin
          dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 354)){754}, 553, d.ClientRect, d, TRUE);
        end;
      end;
    end;

   //��ʾ���������
   sx := 208;
   sy := SCREENHEIGHT - 130;
   {$IF Version = 1}
   with DScreen do begin
      SetBkMode (dsurface.Canvas.Handle, OPAQUE);
      for i := ChatBoardTop to ChatBoardTop + VIEWCHATLINE-1 do begin
         if i > ChatStrs.Count-1 then break;
         fcolor := integer(ChatStrs.Objects[i]);
         bcolor := integer(ChatBks[i]);
         dsurface.Canvas.Font.Color := fcolor;
         dsurface.Canvas.Brush.Color := bcolor;
         dsurface.Canvas.TextOut (sx, sy+(i-ChatBoardTop)*12, ChatStrs.Strings[i]);
      end;
   end;
   dsurface.Canvas.Release;
   {$ELSE}
   with DScreen do begin
      for i := ChatBoardTop to ChatBoardTop + VIEWCHATLINE-1 do begin
         if i > ChatStrs.Count-1 then break;
         fcolor := integer(ChatStrs.Objects[i]);
         bcolor := integer(ChatBks[i]);
         ClFunc.ChatTextOut (dsurface, sx, sy+(i-ChatBoardTop)*12, fcolor, bcolor, ChatStrs.Strings[i]);
         dsurface.Canvas.Release;
      end;
   end;
   {$IFEND}
end;



{--------------------------------------------------------------}
//�жϵײ�����ϵ�һ���Ƿ�͸��
procedure TFrmDlg.DBottomInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
var
   d: TDirectDrawSurface;
begin
{$IF SWH = SWH800}
   d := g_WMain3Images.Images[BOTTOMBOARD800];
{$ELSEIF SWH = SWH1024}
   d := g_WMainImages.Images[BOTTOMBOARD1024];
{$IFEND}
   if d <> nil then begin
      if d.Pixels[X, Y] > 0 then IsRealArea := TRUE
      else IsRealArea := FALSE;
   end;
end;

procedure TFrmDlg.DMyStateDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if d.WLib <> nil then begin //20080701
        if d.Downed then begin
           dd := d.WLib.Images[d.FaceIndex];
           if dd <> nil then
              dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
        end;
      end;
   end;
end;

//�׷�, ��ȯ, �� ��ư
procedure TFrmDlg.DBotGroupDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if d.WLib <> nil then begin //20080701
        if not d.Downed then begin
           dd := d.WLib.Images[d.FaceIndex];
           if dd <> nil then
              dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
        end else begin
           dd := d.WLib.Images[d.FaceIndex+1];
           if dd <> nil then
              dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
        end;
      end;
   end;
end;

procedure TFrmDlg.DBotPlusAbilDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if not d.Downed then begin
         if (BlinkCount mod 2 = 0) and (not DAdjustAbility.Visible) then dd := d.WLib.Images[d.FaceIndex]
         else dd := d.WLib.Images[d.FaceIndex + 2];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end else begin
         dd := d.WLib.Images[d.FaceIndex+1];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;

      if GetTickCount - BlinkTime >= 500 then begin
         BlinkTime := GetTickCount;
         Inc (BlinkCount);
         if BlinkCount >= 10 then BlinkCount := 0;
      end;
   end;
end;



procedure TFrmDlg.DMyStateClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DMyState then begin
      StatePage := 0;
      OpenMyStatus;
   end;
   if Sender = DMyBag then OpenItemBag;
   if Sender = DMyMagic then begin
      StateTab := 0;
      StatePage := 3;
      OpenMyStatus;
   end;
   if Sender = DOption then DOptionClick;
end;

procedure TFrmDlg.DOptionClick();
begin
  g_boSound := not g_boSound;
  if g_boSound then begin
    DScreen.AddChatBoardString ('[��Ч ��]',clWhite, clBlack);
  end else begin
    DScreen.AddChatBoardString ('[��Ч ��]',clWhite, clBlack);
  end;
end;







{------------------------------------------------------------------------}

// ��Ʈ

{------------------------------------------------------------------------}


procedure TFrmDlg.DBelt1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      idx := Tag;
      if idx in [0..5] then begin
         if g_ItemArr[idx].S.Name <> '' then begin
            d := g_WBagItemImages.Images[g_ItemArr[idx].S.Looks];
            if d <> nil then
               dsurface.Draw (SurfaceX(Left+(Width-d.Width) div 2), SurfaceY(Top+(Height-d.Height) div 2), d.ClientRect, d, TRUE);
         end;
      end;
      PomiTextOut (dsurface, SurfaceX(Left+13), SurfaceY(Top+19), IntToStr(idx+1));
   end;
end;

procedure TFrmDlg.DBelt1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   idx: integer;
begin
   idx := TDButton(Sender).Tag;
   if idx in [0..5] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         g_MouseItem := g_ItemArr[idx];
      end;
   end;
end;

procedure TFrmDlg.DBelt1Click(Sender: TObject; X, Y: Integer);
var
   idx: integer;
   temp: TClientItem;
begin
   idx := TDButton(Sender).Tag;
   if idx in [0..5] then begin
      if not g_boItemMoving then begin
         if g_boHeroItemMoving then Exit;
         if g_ItemArr[idx].S.Name <> '' then begin
            ItemClickSound (g_ItemArr[idx].S);
            g_boItemMoving := TRUE;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := g_ItemArr[idx];
            g_ItemArr[idx].S.Name := '';
         end;
      end else begin
         if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
         if (g_MovingItem.Item.S.StdMode) <= 3 then begin //����,����,��ũ��
            if (g_MovingItem.Item.s.StdMode = 2) and (g_MovingItem.Item.s.Need = 1) then Exit;  //������������Ʒ 20080331
            //ItemClickSound (MovingItem.Item.S.StdMode);
            if g_ItemArr[idx].S.Name <> '' then begin
               temp := g_ItemArr[idx];
               g_ItemArr[idx] := g_MovingItem.Item;
               g_MovingItem.Index := idx;
               g_MovingItem.Item := temp
            end else begin
               g_ItemArr[idx] := g_MovingItem.Item;
               g_MovingItem.Item.S.name := '';
               g_boItemMoving := FALSE;
            end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DBelt1DblClick(Sender: TObject);
var
   idx: integer;
begin
   idx := TDButton(Sender).Tag;
   if idx in [0..5] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         if (g_ItemArr[idx].S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31) then begin //����� �� �ִ� ������
            FrmMain.EatItem (idx);
         end;
      end else begin
         if g_boItemMoving and (g_MovingItem.Index = idx) and
           (g_MovingItem.Item.S.StdMode <= 4) or (g_MovingItem.Item.S.StdMode = 31)
         then begin
            g_BeltIdx := idx; //˫�� �Զ���ҩIDX 20080229
            FrmMain.EatItem (-1);
         end;
      end;
   end;
end;


{----------------------------------------------------------}
//��Ʒ��Ϣ   2007.10.17    ����
{----------------------------------------------------------}
procedure TFrmDlg.GetMouseItemInfo (var iname, line1, line2, line3: string; var useable: boolean; Who: Integer{1Ϊ����,2ΪӢ��}); //���� 2007.12.15 ֧��Ӣ��
   function GetDuraStr (dura, maxdura: integer): string;
   begin
      if not BoNoDisplayMaxDura then
         Result := IntToStr(Round(dura/1000)) + '/' + IntToStr(Round(maxdura/1000))
      else
         Result := IntToStr(Round(dura/1000));
   end;
   function GetDura100Str (dura, maxdura: integer): string;
   begin
      if not BoNoDisplayMaxDura then
         Result := IntToStr(Round(dura/100)) + '/' + IntToStr(Round(maxdura/100))
      else
         Result := IntToStr(Round(dura/100));
   end;
   function GetDuraShowStr (dura, maxdura: integer): string;   //20080306 ���ã� ֱ�Ӱ�������������STRING
   begin
      if not BoNoDisplayMaxDura then
         Result := IntToStr(Round(dura)) + '/' + IntToStr(Round(maxdura))
      else
         Result := IntToStr(Round(dura));
   end;
var
  sWgt:String;
  MouseItem : TClientItem; //20080222
begin
   case Who of
     1:begin
        if g_MySelf = nil then exit;
        MouseItem := g_MouseItem;
     end;
     2:begin
        if g_HeroSelf = nil then exit;
        MouseItem := g_HeroMouseItem;
     end;
   end;
   iname := ''; line1 := ''; line2 := ''; line3 := '';
   useable := TRUE;

   if MouseItem.S.Name <> '' then begin
      iname := MouseItem.S.Name + ' ';
      sWgt := '����';
      case MouseItem.S.StdMode of
         0: begin //ҩƷ
              if MouseItem.s.Shape <> 3 then begin
                if MouseItem.S.AC > 0 then
                  line1 := '+' + IntToStr(MouseItem.S.AC) + 'HP ';
                if MouseItem.S.MAC > 0 then
                  line1 := line1 + '+' + IntToStr(MouseItem.S.MAC) + 'MP';
              end;
                line1 := line1 + '����' + IntToStr(MouseItem.S.Weight);
            end;
         1..3:
            begin
               case MouseItem.s.AniCount of
                9: begin
                  line1 := line1 + '����' +  IntToStr(MouseItem.S.Weight);
                  line2 := '���ۼ��޸��־�'+ IntToStr(Round(MouseItem.Dura / 100))+'��';
                end;
                21: begin
                  if (MouseItem.s.StdMode= 2) and (MouseItem.s.Reserved = 56) then begin  //Ȫˮ�� 20080624
                    line1 := line1 + '����' +  IntToStr(MouseItem.S.Weight);
                    line2 := '���� '+ GetDura100Str(MouseItem.Dura, MouseItem.DuraMax);
                  end else begin
                    line1 := line1 + '����' +  IntToStr(MouseItem.S.Weight);
                    line2 := '���� '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
                  end;
                end;
                22: begin
                  line1 := line1 + '����' +  IntToStr(MouseItem.S.Weight);
                  line2 := '���� '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
                end;
               else
               line1 := line1 + '����' +  IntToStr(MouseItem.S.Weight);
               end;
             if (MouseItem.S.StdMode = 2) and (MouseItem.s.Reserved <> 56) then
               if MouseItem.s.Shape in [0..2] then
                  line2 := 'ʹ�� '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' ��';
            end;
         51: begin
             line1 := line1 + '����' +  IntToStr(MouseItem.S.Weight);
             if MouseItem.Dura = MouseItem.DuraMax then begin
                line2 := '����ֵ������('+IntToStr(MouseItem.DuraMax)+'��)  ˫���ͷ�';
                //line2 := '�ۻ����� ' +  IntToStr(MouseItem.Dura)+'/'+IntToStr(MouseItem.DuraMax)+' ��';
              end else begin
                if MouseItem.s.Need = 0 then begin
                  line2 := '�ۻ����� ' +  IntToStr(MouseItem.Dura)+'/'+IntToStr(MouseItem.DuraMax)+'��';
                  line3 := IntToStr(MouseItem.s.AniCount * 24)+'Сʱ��ֹͣ�ۻ�����';
                end else begin
                  //line1 := 'ʣ��'+ Inttostr(MouseItem.s.Need div 24)+'��'+IntToStr(MouseItem.s.Need mod 24)+'Сʱ';
                  line2 := '�ۻ����� ' +  IntToStr(MouseItem.Dura  + g_nBeadWinExp)+'/'+IntToStr(MouseItem.DuraMax)+'��';
                  line3 := IntToStr(MouseItem.s.Need)+'Сʱ��ֹͣ�ۻ�����';
                end;
              end;
         end;
         4:   //������
            begin
               line1 := line1 + '����' +  IntToStr(MouseItem.S.Weight);
               case MouseItem.s.AniCount of
                 0: begin
                   line3 := '��Ҫ�ȼ�' + IntToStr(MouseItem.S.DuraMax);
                   useable := FALSE;
                   case MouseItem.S.Shape of
                     0: begin
                            line2 := '��ʿ�ؼ�';
                            case Who of
                              1: if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level >= MouseItem.S.DuraMax) then
                                   useable := TRUE;
                              2: if (g_HeroSelf.m_btJob = 0) and (g_HeroSelf.m_Abil.Level >= MouseItem.S.DuraMax) then
                                   useable := TRUE;
                            end;
                        end;
                      1: begin
                            line2 := 'ħ����';
                            case Who of
                              1: if (g_MySelf.m_btJob = 1) and (g_MySelf.m_Abil.Level >= MouseItem.S.DuraMax) then
                                 useable := TRUE;
                              2: if (g_HeroSelf.m_btJob = 1) and (g_HeroSelf.m_Abil.Level >= MouseItem.S.DuraMax) then
                                 useable := TRUE;
                            end;
                         end;
                      2: begin
                            line2 := '��ʿ�ؼ�';
                            case Who of
                              1: if (g_MySelf.m_btJob = 2) and (g_MySelf.m_Abil.Level >= MouseItem.S.DuraMax) then
                                 useable := TRUE;
                              2: if (g_HeroSelf.m_btJob = 2) and (g_HeroSelf.m_Abil.Level >= MouseItem.S.DuraMax) then
                                 useable := TRUE;
                            end;
                         end;
                      3: begin
                          //if g_MouseItem.s.AniCount in [60..65] then begin
                            line2 := '�ϻ�����';
                            case Who of
                              1: if g_MySelf.m_Abil.Level >= MouseItem.S.DuraMax then
                                 useable := TRUE;
                              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.DuraMax then
                                 useable := TRUE;
                            end;
                          //end;
                         end;
                   end;
                 end;
                 1: begin
                   line3 := '��Ҫ�ڹ��ȼ�' + IntToStr(MouseItem.S.DuraMax);
                   useable := FALSE;
                   case MouseItem.S.Shape of
                     0: begin
                            line2 := '�����ؼ�';
                            case Who of
                              1: if (g_MySelf.m_btJob = 0) and (g_btInternalForceLevel >= MouseItem.S.DuraMax) then
                                   useable := TRUE;
                              2: if (g_HeroSelf.m_btJob = 0) and (g_btHeroInternalForceLevel >= MouseItem.S.DuraMax) then
                                   useable := TRUE;
                            end;
                        end;
                      1: begin
                            line2 := 'ħ����';
                            case Who of
                              1: if (g_MySelf.m_btJob = 1) and (g_btInternalForceLevel >= MouseItem.S.DuraMax) then
                                 useable := TRUE;
                              2: if (g_HeroSelf.m_btJob = 1) and (g_btHeroInternalForceLevel >= MouseItem.S.DuraMax) then
                                 useable := TRUE;
                            end;
                         end;
                      2: begin
                            line2 := '�����ؼ�';
                            case Who of
                              1: if (g_MySelf.m_btJob = 2) and (g_btInternalForceLevel >= MouseItem.S.DuraMax) then
                                 useable := TRUE;
                              2: if (g_HeroSelf.m_btJob = 2) and (g_btHeroInternalForceLevel >= MouseItem.S.DuraMax) then
                                 useable := TRUE;
                            end;
                         end;
                      99: begin
                          //if g_MouseItem.s.AniCount in [60..65] then begin
                            line2 := 'սʿ��ħ��ʦ����ʿ����ѧϰ';
                            case Who of
                              1: if g_btInternalForceLevel >= MouseItem.S.DuraMax then
                                 useable := TRUE;
                              2: if g_btHeroInternalForceLevel >= MouseItem.S.DuraMax then
                                 useable := TRUE;
                            end;
                          //end;
                         end;
                   end;
                 end;
               end;
            end;
            7: begin
              case MouseItem.s.Shape of
                0:begin  //ǧ�ﴫ��
                  line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
                  line2 := '���� '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' ��';
                end; 
                1:begin
                  line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
                  line2 := 'HP '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' ��';
                end;
                2:begin
                  line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
                  line2 := 'MP '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' ��';
                end;
                3:begin
                  line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
                  line2 := 'HPMP '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' ��';
                end;
              end;
            end;
            8: begin  //�ƾƲ��� 20080622
                {str:= MouseItem.s.sDesc;
                str := GetValidStr3 (str, str1, ['\']);
                str := GetValidStr3 (str, str2, ['\']);  }
                line1 := line1 + 'Ʒ��' + IntToStr(MouseItem.S.AC);
                {if str1 <> '' then line2 := line2 + str1;
                if str2 <> '' then line3 := line3 + str2;  }
                case MouseItem.s.Shape of
                  1: begin
                    line2 := '�ɸ����Ѽӹ����ɵ���ʳ������Ϊ�����Ƶ�';
                    line3 := '���ϻ������Ƶĸ���';
                  end;
                  2: begin
                    line2 := '��ˮ���Ѽӹ����ɵ���ʳ������Ϊ�����վ�';
                    line3 := '�����ϻ������Ƶĸ���';
                  end;
                  3: begin
                    line2 := '�׾ƣ����и�ԭ�Ķ��ط��飬�ڸд���';
                  end;
                  4: begin
                    line2 := '�׾ƣ��Թ�ζ��ƣ�����������������';
                  end;
                  5: begin
                    line2 := '�ƾƣ�������ͣ��Ȼ���������ůθ֮��Ч';
                  end;
                  6: begin
                    line2 := '�Դ���ζ������Ϊ�����Ƶ����ϻ������Ƶ�';
                    line3 := '����';
                  end;
                  7: begin
                    line2 := '��Ŵճ���������������ģ�����Ϊ����Ƶ�';
                    line3 := '���ϻ������Ƶĸ���';
                  end;
                  8: begin
                    line2 := '���ӹ����Ϻø����ף�����Ϊ�����Ƶ�����';
                    line3 := '�������Ƶĸ���';
                  end;
                  9: begin
                    line2 := '���ӹ����Ϻõ��ף�����Ϊ�����վƵ�����';
                    line3 := '�������Ƶĸ���';
                  end;
                  10: begin
                    line2 := '���ӹ����Ϻ�����������Ϊ�����Ƶ����ϻ�';
                    line3 := '�����Ƶĸ���';
                  end;
                  11: begin
                    line2 := '���������ᴿ��ˮ����֭������Ϊ��¶�Ƶ�';
                    line3 := '���ϻ������Ƶĸ���';
                  end;
                  12: begin
                    line2 := '���ӹ����Ϻ����ף�����Ϊ���׻ƾƵ�����';
                    line3 := '�������Ƶĸ���';
                  end;
                  13: begin
                    line2 := '���ӹ��ĺ������𣬿���Ϊ�����Ƶ����ϻ�';
                    line3 := '�����Ƶĸ���';
                  end;
                  14: begin
                    line2 := '���ӹ����Ϻ�Ŵ�ף�����Ϊ����Ƶ����ϻ�';
                    line3 := '�����Ƶĸ���';
                  end;
                end;
            end;
            9: begin  //���ˮ����
              line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);;
              case Mouseitem.s.Shape of
                0: line2 := '�귨�˳��������õ�ˮ���ʵ���ͨ';
                1: line2 := '���Եص׵�Ȫˮ�������ɿڣ�ζ����';
              end;
            end;
            12: begin //����
              line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);;
              case MouseItem.s.Shape of
                0: line2 := '�귨��½�϶������ͨ�������';
                1: line2 := '��������һ��ҩ�Ƶľ��¾�ƿ';
              end;
            end;
            13: begin //����
              line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);;
              case MouseItem.s.Shape of
                1: line2 := '���������ʱʹ�ã�����߾Ƶ�Ʒ��';
                2: line2 := '���쵾���վ�ʱʹ�ã�����߾Ƶ�Ʒ��';
                3: line2 := '����������ʱʹ�ã�����߾Ƶ�Ʒ��';
                4: line2 := '�����¶��ʱʹ�ã�����߾Ƶ�Ʒ��';
                5: line2 := '�������׾�ʱʹ�ã�����߾Ƶ�Ʒ��';
                6: line2 := '���������ʱʹ�ã�����߾Ƶ�Ʒ��';
                7: line2 := '���컨���ʱʹ�ã�����߾Ƶ�Ʒ��';
              end;
            end;
            14: begin //���ҩ��
              {str:= MouseItem.s.sDesc;
              str := GetValidStr3 (str, str1, ['\']);
              str := GetValidStr3 (str, str2, ['\']);  }
              line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);;
              {if str1 <> '' then line2 := line2 + str1;
              if str2 <> '' then line3 := line3 + str2; }
              case MouseItem.s.Shape of
                1: begin
                  line2 := '��ĥ���Ǿ������ã�ʹ��Ʒ��6���ϵľ���';
                  line3 := '�����ƿɻ�û��Ǿ�';
                end;
                2: begin
                  line2 := '�����Ĵ���Ƭ��ʹ��Ʒ��6���ϵľ�������';
                  line3 := '�ƿɻ�ý𲭾�';
                end;
                3: begin
                  line2 := '��ͳ���ϼ��̲�Ʒ��ʹ��Ʒ��6���ϵľ���';
                  line3 := '�����ƿɻ�����ξ�';
                end;
                4: begin
                  line2 := '�ֳƵع�Ҷ�������衢ɢ��ʹ��Ʒ��6����';
                  line3 := '�ľ��������ƿɻ�û�����';
                end;
                5: begin
                  line2 := '���Ƚⶾ��ζ�࣬ʹ��Ʒ��6���ϵľ�����';
                  line3 := '���ƿɻ���ߵ���';
                end;
              end;
            end;
            60: begin //�ƺ��վ�
                if MouseItem.s.Shape <> 0 then begin
                  line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight) + ' ����' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
                  line2 := line2 + 'Ʒ��' + IntToStr(MouseItem.S.AC) + ' �ƾ���' + IntToStr(MouseItem.S.MAC) + '��';
                  //if MouseItem.s.sDesc <> '' then line3 := line3 + MouseItem.s.sDesc;
                end else line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
                case MouseItem.s.Shape of
                  1: line3 := '�׾ƣ����崼�񣬿ڸ��೤����Ϊ������ϲ';
                  2: line3 := '�׾ƣ��Դ����𣬴���Ũ���������Ϣ';
                  3: line3 := '�׾ƣ����и�ԭ�Ķ��ط��飬�ڸд���';
                  4: line3 := '�׾ƣ��Թ�ζ��ƣ�����������������';
                  5: line3 := '�ƾƣ�������ͣ��Ȼ���������ůθ֮��Ч';
                  6: line3 := '�ƾƣ�������������ڸ���ȴ��ճ��֮��';
                  7: line3 := '�ƾƣ���ɫ��֣�ӯ�Ѳ��磬�����������';
                  8: line3 := '��ǿ���֮�ã������'+IntToStr(MouseItem.s.Need)+'��������';
                  9: line3 := '�˾ƿ����ĺ�Ѫ�������'+IntToStr(MouseItem.s.Need)+'��������';
                 10: line3 := '��ʹ�����ָ�Ϊ�������'+IntToStr(MouseItem.s.Need)+'��������';
                 11: line3 := '�ɼ��ǣ��ͺ�������'+IntToStr(MouseItem.s.Need)+'��������';
                 12: line3 := '�����������������'+IntToStr(MouseItem.s.Need)+'��������';
                end;
            end;
         5..6: //����
            begin
               useable := FALSE;
               if MouseItem.S.Reserved and $01 <> 0 then
                  iname := '(*)' + iname;

               line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight) +
                        ' �־�'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
               if MouseItem.S.DC > 0 then
                  line2 := '����' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC));
               if MouseItem.S.MC > 0 then
                  line2 := line2 + 'ħ��' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC));
               if MouseItem.S.SC > 0 then
                  line2 := line2 + '����' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC));
               if ((MouseItem.s.Source - 1 - 10) < 0) and (MouseItem.s.Source > 0) then
                  line2 := line2 + 'ǿ��+' + IntToStr(MouseItem.S.Source);
               if (MouseItem.S.Source <= -1) and (MouseItem.S.Source >= -50) then
                  line2 := line2 + '��ʥ+' + IntToStr(-MouseItem.S.Source);
               if (MouseItem.S.Source <= -51) and (MouseItem.S.Source >= -100) then
                  line2 := line2 + '��ʥ-' + IntToStr(-MouseItem.S.Source - 50);

               if HiWord(MouseItem.S.AC) > 0 then
                  line3 := line3 + '׼ȷ+' + IntToStr(HiWord(MouseItem.S.AC));
               if HiWord(MouseItem.S.MAC) > 0 then begin
                  if HiWord(MouseItem.S.MAC) > 10 then
                     line3 := line3 + '�����ٶ�+' + IntToStr(HiWord(MouseItem.S.MAC)-10) + ' '
                  else
                     line3 := line3 + '�����ٶ�-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
               end;
               if LoWord(MouseItem.S.AC) > 0 then
                  line3 := line3 + '����+' + IntToStr(LoWord(MouseItem.S.AC)) + ' ';
               if LoWord(MouseItem.S.MAC) > 0 then
                  line3 := line3 + '����+' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
               case MouseItem.S.Need of
                  0: begin
                        case Who of
                          1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫ�ȼ�' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  1: begin
                        case Who of
                          1: if HiWord (g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if HiWord (g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫ����' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  2: begin
                        case Who of
                          1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫħ����' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  3: begin
                        case Who of
                          1: if HiWord (g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if HiWord (g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫ������' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  4: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת���ȼ�' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  40: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&�ȼ�' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  41: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&����' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  42: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&ħ����' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  43: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&������' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  44: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&������' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  5: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫ������' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                     end;
                  6: begin
                        useable := TRUE;
                        line3 := line3 + '�л��Աר��' + ' ';
                     end;
                  60: begin
                        useable := TRUE;
                        line3 := line3 + '�л�����ר��' + ' ';
                     end;
                  7: begin
                        useable := TRUE;
                        line3 := line3 + 'ɳ�ǳ�Աר��' + ' ';
                     end;
                  70: begin
                        useable := TRUE;
                        line3 := line3 + 'ɳ�ǳ���ר��';
                     end;
                  8: begin
                        useable := TRUE;
                        line3 := line3 + '��Աר��' + ' ';
                     end;
                  81: begin
                        useable := TRUE;
                        line3 := line3 + '��Ա���� =' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '��Ա�ȼ� >=' + IntToStr(HiWord(MouseItem.S.NeedLevel)) + ' ';
                     end;
                  82: begin
                        useable := TRUE;
                        line3 := line3 + '��Ա���� >=' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '��Ա�ȼ� >=' + IntToStr(HiWord(MouseItem.S.NeedLevel)) + ' ';
                     end;
               end;
            end;
         10, 11:  //���·�, Ů�·�
            begin
               useable := FALSE;
               line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight) +
                        ' �־�'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
               //line1 := line1 + '����' + IntToStr(MouseItem.S.Weight) +
               //      ' �־�'+ IntToStr(Round(MouseItem.Dura/1000)) + '/' + IntToStr(Round(MouseItem.DuraMax/1000));
               if MouseItem.S.AC > 0 then
                  line2 := '����' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
               if MouseItem.S.MAC > 0 then
                  line2 := line2 + 'ħ��' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
               if MouseItem.S.DC > 0 then
                  line2 := line2 + '����' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC)) + ' ';
               if MouseItem.S.MC > 0 then
                  line2 := line2 + 'ħ��' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC)) + ' ';
               if MouseItem.S.SC > 0 then
                  line2 := line2 + '����' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC));

               if LoByte(MouseItem.S.Source) > 0 then
                  line3 := line3 + '����+' + IntToStr(LoByte(MouseItem.S.Source)) + ' ';
               if HiByte(MouseItem.S.Source) > 0 then
                  line3 := line3 + '����+' + IntToStr(HiByte(MouseItem.S.Source)) + ' ';

               case MouseItem.S.Need of
                  0: begin
                        case Who of
                          1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫ�ȼ�' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  1: begin
                        case Who of
                          1: if HiWord (g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if HiWord (g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫ����' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        case Who of
                          1: if HiWord (g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if HiWord (g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫħ����' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        case Who of
                          1: if HiWord (g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if HiWord (g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫ������' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  4: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת���ȼ�' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  40: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&�ȼ�' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  41: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&������' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  42: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&ħ����' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  43: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&������' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  44: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&������' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  5: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫ������' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  6: begin
                        useable := TRUE;
                        line3 := line3 + '�л��Աר��';
                     end;
                  60: begin
                        useable := TRUE;
                        line3 := line3 + '�л�����ר��';
                     end;
                  7: begin
                        useable := TRUE;
                        line3 := line3 + 'ɳ�ǳ�Աר��';
                     end;
                  70: begin
                        useable := TRUE;
                        line3 := line3 + 'ɳ�ǳ���ר��';
                     end;
                  8: begin
                        useable := TRUE;
                        line3 := line3 + '��Աר��';
                     end;
                  81: begin
                        useable := TRUE;
                        line3 := line3 + '��Ա���� =' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '��Ա�ȼ� >=' + IntToStr(HiWord(MouseItem.S.NeedLevel));
                     end;
                  82: begin
                        useable := TRUE;
                        line3 := line3 + '��Ա���� >=' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '��Ա�ȼ� >=' + IntToStr(HiWord(MouseItem.S.NeedLevel));
                     end;
               end;
            end;
         15,30,16,     //ͷ��,������,����
         19,20,21,  //����
         22,23,  //��ָ
         24,26, //����
         52,62,   //Ь
         53,63,//��ʯ
         54,64:   //����
            begin
               useable := FALSE;
               if MouseItem.s.Shape = 188 then line1 := '�ȼ�' + IntToStr(MouseItem.s.Reserved) + ' ';
               line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight) +
                        ' �־�'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);

               case MouseItem.S.StdMode of
                  19,53{��ʯ}: //����
                     begin
                        if MouseItem.S.AC > 0 then
                           line2 := line2 + 'ħ�����+' + IntToStr(HiWord(MouseItem.S.AC)) + '0% ';
                        if LoWord(MouseItem.S.MAC) > 0 then line2 := line2 + '����+' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
                        if HiWord(MouseItem.S.MAC) > 0 then line2 := line2 + '����+' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
                           //���� ǥ�þȵ� + IntToStr(Hibyte(MouseItem.S.MAC)) + ' ';
                     end;
                  20, 24: //���� �� ����: MaxAC -> Hit,  MaxMac -> Speed
                     begin
                        if MouseItem.S.AC > 0 then
                           line2 := line2 + '׼ȷ+' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
                        if MouseItem.S.MAC > 0 then
                           line2 := line2 + '����+' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
                     end;
                  21:  //����
                     begin
                        if HiWord(MouseItem.S.AC) > 0 then
                           line2 := line2 + '�����ָ�+' + IntToStr(HiWord(MouseItem.S.AC)) + '0% ';
                        if HiWord(MouseItem.S.MAC) > 0 then
                           line2 := line2 + 'ħ���ָ�' + IntToStr(HiWord(MouseItem.S.MAC)) + '0% ';
                        if LoWord(MouseItem.S.AC) > 0 then
                           line2 := line2 + '�����ٶ�+' + IntToStr(LoWord(MouseItem.S.AC)) + ' ';
                        if LoWord(MouseItem.S.MAC) > 0 then
                           line2 := line2 + '�����ٶ�-' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
                     end;
                  23:  //��ָ
                     begin
                        if HiWord(MouseItem.S.AC) > 0 then
                           line2 := line2 + '������+' + IntToStr(HiWord(MouseItem.S.AC)) + '0% ';
                        if HiWord(MouseItem.S.MAC) > 0 then
                           line2 := line2 + '�ж��ָ�+' + IntToStr(HiWord(MouseItem.S.MAC)) + '0% ';
                        if LoWord(MouseItem.S.AC) > 0 then
                           line2 := line2 + '�����ٶ�+' + IntToStr(LoWord(MouseItem.S.AC)) + ' ';
                        if LoWord(MouseItem.S.MAC) > 0 then
                           line2 := line2 + '�����ٶ�-' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
                     end;
                  28,27{����}:  //ѥ��
                     begin
                        if MouseItem.S.AC > 0 then
                           line2 := line2 + '����' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
                        if MouseItem.S.MAC > 0 then
                           line2 := line2 + 'ħ��' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
                     end;
                  52,54: //������ѥ�Ӹ��� 20080325
                     begin
                        if MouseItem.S.AC > 0 then
                           line2 := line2 + '����' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
                        if MouseItem.S.MAC > 0 then
                           line2 := line2 + 'ħ��' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
                        if MouseItem.s.AniCount > 0 then
                          line2 := line2 + '����+' + IntToStr(MouseItem.s.AniCount) + ' ';
                     end;
                  63: //Charm
                     begin
                        if LoWord(MouseItem.S.AC) > 0 then line2 := line2 + 'HP+' + IntToStr(LoWord(MouseItem.S.AC)) + ' ';
                        if HiWord(MouseItem.S.AC) > 0 then line2 := line2 + 'MP+' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
                        if LoWord(MouseItem.S.MAC) > 0 then line2 := line2 + '����+' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
                        if HiWord(MouseItem.S.MAC) > 0 then line2 := line2 + '����+' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
                     end;
                  else
                     begin
                        if MouseItem.S.AC > 0 then
                           line2 := line2 + '����' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
                        if MouseItem.S.MAC > 0 then
                           line2 := line2 + 'ħ��' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
                     end;
               end;
               if MouseItem.S.DC > 0 then
                  line2 := line2 + '����' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC)) + ' ';
               if MouseItem.S.MC > 0 then
                  line2 := line2 + 'ħ��' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC)) + ' ';
               if MouseItem.S.SC > 0 then
                  line2 := line2 + '����' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC)) + ' ';

               if (MouseItem.S.Source <= -1) and (MouseItem.S.Source >= -50) then
                  line2 := line2 + '��ʥ+' + IntToStr(-MouseItem.S.Source);
               if (MouseItem.S.Source <= -51) and (MouseItem.S.Source >= -100) then
                  line2 := line2 + '��ʥ-' + IntToStr(-MouseItem.S.Source - 50);

               case MouseItem.S.Need of
                  0: begin
                        case Who of
                          1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                          2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫ�ȼ�' + IntToStr(MouseItem.S.NeedLevel);
                        if MouseItem.s.Shape = 188 then
                          if MouseItem.s.Source > 0 then
                          line3 := line3 + ' �˺�����' + IntToStr(MouseItem.s.Source) + '%';
                     end;
                  1: begin
                        case Who of
                          1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫ������' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        case Who of
                          1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫħ����' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        case Who of
                          1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                          2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then
                             useable := TRUE;
                        end;
                        line3 := line3 + '��Ҫ������' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  4: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת���ȼ�' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  40: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&�ȼ�' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  41: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&����' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  42: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&ħ����' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  43: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&������' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  44: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫת��&������' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  5: begin
                        useable := TRUE;
                        line3 := line3 + '��Ҫ������' + IntToStr(MouseItem.S.NeedLevel);
                     end;
                  6: begin
                        useable := TRUE;
                        line3 := line3 + '�л��Աר��';
                     end;
                  60: begin
                        useable := TRUE;
                        line3 := line3 + '�л�����ר��';
                     end;
                  7: begin
                        useable := TRUE;
                        line3 := line3 + 'ɳ�ǳ�Աר��';
                     end;
                  70: begin
                        useable := TRUE;
                        line3 := line3 + 'ɳ�ǳ���ר��';
                     end;
                  8: begin
                        useable := TRUE;
                        line3 := line3 + '��Աר��';
                     end;
                  81: begin
                        useable := TRUE;
                        line3 := line3 + '��Ա����=' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '��Ա�ȼ� >=' + IntToStr(HiWord(MouseItem.S.NeedLevel));
                     end;
                  82: begin
                        useable := TRUE;
                        line3 := line3 + '��Ա����>=' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '��Ա�ȼ� >=' + IntToStr(HiWord(MouseItem.S.NeedLevel));
                     end;
               end;
            end;
         25: //���������ҩ
            begin
               case MouseItem.S.Shape of
                   9: begin  //����֮��
                      line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
                      line2 := '���� '+ IntToStr(MouseItem.Dura) +'/'+ IntToStr(MouseItem.DuraMax);
                   end;
                   10..11: begin
                      line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
                      line2 := '�־� '+ GetDura100Str(MouseItem.Dura, MouseItem.DuraMax);
                   end;
                 else begin
                   line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
                   line2 := '���� '+ GetDura100Str(MouseItem.Dura, MouseItem.DuraMax);
                 end;
               end;
            end;
         {30: //������
            begin
               line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight) + ' �־�:'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
            end;   }
         40: //��
            begin
               line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight) + ' Ʒ��'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
            end;
         42: //ҩ��
            begin
               line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight) + ' ҩ��';
            end;
         43: //��ʯ
            begin
               line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight) + ' ����'+ IntToStr(Round(MouseItem.Dura/1000));
            end;
         48,49:
            begin
              case MouseItem.S.StdMode of
                48: begin
                   line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
                   line2 := ' ';
                   line3 := '˫���򿪱���';
                 end;
                 49: begin
                   line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
                   line2 := ' ';
                   line3 := '��������Կ�ף��ƶ��������ڼ���';
                 end;
              end;
            end;
         else begin
               line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
            end;
      end;
   end;
end;

//�滭���ﱳ��
procedure TFrmDlg.DItemBagDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d0, d1, d2, d3: string;
   n: integer;
   useable: Boolean;
   d: TDirectDrawSurface;
begin
   if g_MySelf = nil then exit;
   with DItemBag do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      GetMouseItemInfo (d0, d1, d2, d3, useable, 1{����});
      with dsurface.Canvas do begin
         {$if Version = 1}
         SetBkMode (Handle, TRANSPARENT);
         {$IFEND}
         BoldTextOut (dsurface,SurfaceX(Left+70), SurfaceY(Top+211), clWhite, clBlack,GetGoldStr(g_MySelf.m_nGold));
         //��ʾ���  20080222
         if g_MouseItem.s.Name = '' then begin
            BoldTextOut (dsurface,SurfaceX(Left+75), SurfaceY(Top+241), clWhite, clBlack,'�Ҽ��������װ��');
            BoldTextOut (dsurface,SurfaceX(Left+75), SurfaceY(Top+241+14), clWhite, clBlack,'ALT + R ��ˢ�°���');
         end;
         if (g_MouseItem.s.Name = 'Ԫ����Ϣ') and (g_MouseItem.MakeIndex = 3000)
            and (g_MouseItem.Dura = 3000) and (g_MouseItem.DuraMax = 3000) then begin
            BoldTextOut (dsurface,SurfaceX(Left+75), SurfaceY(Top+241), clWhite, clBlack,g_sGameGoldName+'���� ' + IntToStr(g_MySelf.m_nGameGold));
            BoldTextOut (dsurface,SurfaceX(Left+75), SurfaceY(Top+241+14), clWhite, clBlack,g_sGameGird+'���� ' + IntToStr(g_MySelf.m_nGameGird));
            BoldTextOut (dsurface,SurfaceX(Left+75), SurfaceY(Top+241+14*2), clWhite, clBlack,g_sGameDiaMond+'���� ' + IntToStr(g_MySelf.m_nGameDiaMond));
            d0 := '';
         end;
         if d0 <> '' then begin
            n := FrmMain.Canvas.TextWidth (d0);
            BoldTextOut (dsurface,SurfaceX(Left+75), SurfaceY(Top+241), clYellow, clBlack,d0);
            BoldTextOut (dsurface,SurfaceX(Left+75) + n, SurfaceY(Top+241), clWhite, clBlack,d1);
            BoldTextOut (dsurface,SurfaceX(Left+75), SurfaceY(Top+241+14), clWhite, clBlack,d2);
            if not useable then
            BoldTextOut (dsurface,SurfaceX(Left+75), SurfaceY(Top+241+14*2), clRed, clBlack,d3)
            else BoldTextOut (dsurface,SurfaceX(Left+75), SurfaceY(Top+241+14*2), clWhite, clBlack,d3);
         end;
         Release;
      end;
   end;
end;

procedure TFrmDlg.DItemsUpButDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DItemsUpBut do begin
      if WLib <> nil then begin //20080701
        if DItemsUpBut.Downed then begin
           d := WLib.Images[FaceIndex];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
   end;
end;

procedure TFrmDlg.DCloseBagDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DCloseBag do begin
      if WLib <> nil then begin //20080701
        if DCloseBag.Downed then begin
           d := WLib.Images[FaceIndex];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
   end;
end;

procedure TFrmDlg.DCloseBagClick(Sender: TObject; X, Y: Integer);
begin
   DItemBag.Visible := FALSE;
end;

procedure TFrmDlg.DItemGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
begin
  DScreen.ClearHint;
   if ssRight in Shift then begin
      if g_boItemMoving then
         DItemGridGridSelect (self, ACol, ARow, Shift)
      else
          if GetTickCount - g_nRightItemTick > 700 then begin  //20080308
            g_nRightItemTick := GetTickCount();
            MouseRightItem(1,ACol,ARow);
          end;
   end else begin
      idx := ACol + ARow * DItemGrid.ColCount + 6{��Ʈ����};
      if idx in [6..MAXBAGITEM-1] then begin
         g_MouseItem := g_ItemArr[idx];
         {GetMouseItemInfo (iname, d1, d2, d3, useable ,1);
         if iname <> '' then begin
            if useable then hcolor := clWhite
            else hcolor := clRed;
            with DItemGrid do
               DScreen.ShowHint (SurfaceX(Left + ACol*ColWidth),
                                 SurfaceY(Top + (ARow+1)*RowHeight),
                                 iname + d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
         end;
         g_MouseItem.S.Name := '';   }
      end;
   end;
end;

procedure TFrmDlg.DItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
   idx, mi: integer;
   temp: TClientItem;
   TempIdx: Integer;
begin
  //20080803���� Ӣ��װ�����µ����˰��� ��Ʒ�ص�
  if (g_boHeroItemMoving) and (-g_MovingHeroItem.Index in [1..14]) then Exit;
{-------------------------------------------------------}
//��Ӣ�۰��������˰��� ���� 2007.10.24
   if g_boHeroItemMoving then begin
    if g_MovingHeroItem.Item.s.Name <> '' then begin
      TempIdx := -(g_MovingHeroItem.Index);
      if not (TempIdx in [1..14]) then begin
       g_WaitingUseItem := g_MovingHeroItem;
       FrmMain.SendItemToMasterBag(-(g_MovingHeroItem.Index+1), g_MovingHeroItem.Item.MakeIndex, g_MovingHeroItem.Item.S.Name);
       g_boHeroItemMoving := FALSE;
       g_MovingHeroItem.Item.s.Name:='';
       Exit; //20080331
      end;
    end;
   end;   
{-------------------------------------------------------------}
  idx := ACol + ARow * DItemGrid.ColCount + 6{��Ʈ����};
   if idx in [6..MAXBAGITEM-1] then begin
      if not g_boItemMoving then begin
         if g_ItemArr[idx].S.Name <> '' then begin
              g_boItemMoving := TRUE;
              g_MovingItem.Index := idx;
              g_MovingItem.Item := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';
              ItemClickSound (g_ItemArr[idx].S);
         end;
      end else begin
         mi := g_MovingItem.Index;
         if (mi = -97) or (mi = -98) then exit; //��...
         if (mi < 0) and (mi >= -14 {-9}) then begin  //-99: Sellâ���� ��������
            //����â���� ��������
            g_WaitingUseItem := g_MovingItem;
            FrmMain.SendTakeOffItem (-(g_MovingItem.Index+1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
         end else begin
            if (mi <= -20) and (mi > -30) then
               DealItemReturnBag (g_MovingItem.Item);
            if (mi <= -57) and (mi > -63) then
               ChallengeItemReturnBag (g_MovingItem.Item);
            if (mi <= -30) and (mi > -40) then //Ԫ������ 20080316
               SellOffItemReturnBag (g_MovingItem.Item);
            if (mi <= -41) and (mi > -44) then begin//�������ذ��� 20080506
               g_ItemsUpItem[(-mi-40)].s.Name := '';
            end;
            if g_ItemArr[idx].S.Name <> '' then begin
               temp := g_ItemArr[idx];
               g_ItemArr[idx] := g_MovingItem.Item;
               g_MovingItem.Index := idx;
               g_MovingItem.Item := temp
            end else begin
               g_ItemArr[idx] := g_MovingItem.Item;
               g_MovingItem.Item.S.name := '';
               g_boItemMoving := FALSE;
            end;
         end;
      end;
   end;
   ArrangeItemBag;
end;

procedure TFrmDlg.DItemGridDblClick(Sender: TObject);
var
   idx: integer;
   keyvalue: TKeyBoardState;
   cu: TClientItem;
begin
    g_BeltIdx := 50;  //20080305
   idx := DItemGrid.Col + DItemGrid.Row * DItemGrid.ColCount + 6;
   if idx in [6..MAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         FillChar(keyvalue, sizeof(TKeyboardState), #0);
         GetKeyboardState (keyvalue);
         if keyvalue[VK_CONTROL] = $80 then begin
            //��Ʈâ���� �ű�
            cu := g_ItemArr[idx];
            g_ItemArr[idx].S.Name := '';
            AddItemBag (cu);
         end else
            if (g_ItemArr[idx].S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31) then begin //������ �� �ִ� ������
               FrmMain.EatItem (idx);
            end;
      end else begin
         if g_boItemMoving and (g_MovingItem.Item.S.Name <> '') and (g_MovingItem.Index <> -98{20080320 ��ֹ����װ��}) then begin
            FillChar(keyvalue, sizeof(TKeyboardState), #0);
            GetKeyboardState (keyvalue);
            if keyvalue[VK_CONTROL] = $80 then begin
               //��Ʈâ���� �ű�
               cu := g_MovingItem.Item;
               g_MovingItem.Item.S.Name := '';
               g_boItemMoving := FALSE;
               AddItemBag (cu);
            end else
               if (g_MovingItem.Index = idx) and
                  (g_MovingItem.Item.S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31)  or (g_MovingItem.Item.S.StdMode = 48{���� 2008.01.16}) or (g_MovingItem.Item.S.StdMode = 51{������ 2008.02.21}) or ((g_MovingItem.Item.S.StdMode = 60) and (g_MovingItem.Item.S.Shape <> 0))
               then begin
                  FrmMain.EatItem (-1);
               end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DItemGrid.ColCount + 6;
   if idx in [6..MAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_ItemArr[idx].S.Looks];
         if d <> nil then
            with DItemGrid do  begin
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
              if g_ItemArr[idx].S.Reserved1 = 1 then begin //���� 20080223
                ItemLightTimeImg();
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                  DrawBlend(dsurface,SurfaceX(Rect.Left-21), SurfaceY(Rect.Top-23), d, 1);
              end;
            end;
      end;
   end;
end;

procedure TFrmDlg.DGoldClick(Sender: TObject; X, Y: Integer);
begin
   if g_MySelf = nil then exit;
   if not g_boItemMoving then begin
      if g_MySelf.m_nGold > 0 then begin
         PlaySound (s_money);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -98; //��
         g_MovingItem.Item.S.Name := g_sGoldName{'���'};
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then begin //����..
         g_boItemMoving := FALSE;
         g_MovingItem.Item.S.Name := '';
         if g_MovingItem.Index = -97 then begin //��ȯâ���� ��
            DealZeroGold;
         end;
      end;
   end;
end;






{------------------------------------------------------------------------}

//���� ��ȭ â

{------------------------------------------------------------------------}


procedure TFrmDlg.ShowMDlg (face: integer; mname, msgstr: string);
var
   i: integer;
begin
   DMerchantDlg.Left := 0;  //�⺻ ��ġ
   DMerchantDlg.Top := 0;
   MerchantFace := face;
   MerchantName := mname;
   MDlgStr := msgstr;
   DMerchantDlg.Visible := TRUE;
   DHeroIcon.Visible:=false;//���NPC�Ի�����ʾ ��ôӢ��ͼ������
   DItemBag.Left := 440;  //������ġ ����
   DItemBag.Top := -25;
   if MDlgPoints.Count > 0 then //20080629
   for i:=0 to MDlgPoints.Count-1 do
      Dispose (pTClickPoint (MDlgPoints[i]));
   MDlgPoints.Clear;
   RequireAddPoints := TRUE;
   LastestClickTime := GetTickCount;
end;


procedure TFrmDlg.ResetMenuDlg;
var
   i: integer;
begin
   CloseDSellDlg;
   if g_MenuItemList.Count > 0 then //20080629
   for i:=0 to g_MenuItemList.Count-1 do  //���� �޴��� Ŭ���� ��.
      Dispose(PTClientItem(g_MenuItemList[i]));
   g_MenuItemList.Clear;

   if MenuList.Count > 0 then //20080629
   for i:=0 to MenuList.Count-1 do
      Dispose (PTClientGoods(MenuList[i]));
   MenuList.Clear;

   //CurDetailItem := '';
   MenuIndex := -1;
   MenuTopLine := 0;
   BoDetailMenu := False;
   BoStorageMenu := False;
   BoMakeDrugMenu := False;

   DSellDlg.Visible := False;
   DMenuDlg.Visible := False;
   DWSellOffList.Visible := False; //Ԫ�������б��ɼ� 20080318
   g_SellOffItemIndex := 200;
end;

procedure TFrmDlg.ShowShopMenuDlg;
begin
   MenuIndex := -1;
   DMerchantDlg.Left := 0;  //�⺻ ��ġ
   DMerchantDlg.Top := 0;
   DMerchantDlg.Visible := TRUE;
   DSellDlg.Visible := FALSE;
   DMenuDlg.Left := 0;
   DMenuDlg.Top  := 176;
   DMenuDlg.Visible := TRUE;
   MenuTop := 0;
   DItemBag.Left := 440;
   DItemBag.Top := -25;
   DItemBag.Visible := TRUE;
   LastestClickTime := GetTickCount;
end;

procedure TFrmDlg.ShowShopSellDlg;
begin
   DSellDlg.Left := 260;
   DSellDlg.Top := 176;
   DSellDlg.Visible := TRUE;
   DMenuDlg.Visible := FALSE;
   DItemBag.Left := 440;
   DItemBag.Top := -25;
   DItemBag.Visible := TRUE;
   LastestClickTime := GetTickCount;
   g_sSellPriceStr := '';
end;

procedure TFrmDlg.CloseMDlg;
var
   i: integer;
begin
   MDlgStr := '';
   DMerchantDlg.Visible := FALSE;
   if MDlgPoints.Count > 0 then //20080629
   for i:=0 to MDlgPoints.Count-1 do
      Dispose (PTClickPoint (MDlgPoints[i]));
   MDlgPoints.Clear;
   //�޴�â�� ����
   DItemBag.Left := -5;
   DItemBag.Top := -25;
   DMenuDlg.Visible := FALSE;
   CloseDSellDlg;
   DWSellOffList.Visible := False; //Ԫ�������б��ɼ� 20080318
   DWSellOff.Visible := False;
   if g_HeroSelf <> nil then
   DHeroIcon.Visible := TRUE;//���NPC�Ի���ر� ��ôӢ��ͼ����ʾ
{******************************************************************************}
//�ƹ�
   DWiGetHero.Visible := False;
   DPlayDrink.Visible := False;

   DWPleaseDrink.Visible := False;
   if g_PDrinkItem[0].s.Name <> '' then begin
     AddItemBag(g_PDrinkItem[0]);
     g_PDrinkItem[0].s.Name := '';
   end;
   if g_PDrinkItem[1].s.Name <> '' then begin
     AddItemBag(g_PDrinkItem[1]);
     g_PDrinkItem[1].s.Name := '';
   end;
end;

procedure TFrmDlg.CloseDSellDlg;
begin
   DSellDlg.Visible := FALSE;
   if g_SellDlgItem.S.Name <> '' then
      AddItemBag (g_SellDlgItem);
   g_SellDlgItem.S.Name := '';
end;


(*******************************************************************************
���� :NPC�ű�����{����}��ʾλ��
���� :
���� :
*******************************************************************************)
procedure TFrmDlg.DMerchantDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   str, data, fdata, cmdstr, cmdparam: string;
   lx, ly, sx: integer;
   //DrawCenter: Boolean;
   pcp: PTClickPoint;
   colorg: string;   //�õ�NPC��ɫ��
   color123 : Tcolor;//npc����ɫ
begin
   with Sender as TDWindow do begin
     if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
     end;
      {$if Version = 1}
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);  //����͸��
      {$IFEND}
      lx := 30;
      ly := 20;
      str := MDlgStr;
//      DrawCenter := FALSE;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then begin
            sx := 0;
            fdata := '';
            while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do begin
               if data[1] <> '<' then begin
                  data := '<' + GetValidStr3 (data, fdata, ['<']);
               end;
               data := ArrestStringEx (data, '<', '>', cmdstr);//�õ�"<"��">" ��֮�����   ����� cmdstr

               //fdata + cmdstr + data
               if cmdstr <> '' then begin
                  if Uppercase(cmdstr) = 'C' then begin
//                     drawcenter := TRUE;
                     continue;
                  end;
                  if UpperCase(cmdstr) = '/C' then begin
//                     drawcenter := FALSE;
                     continue;
                  end;
                  cmdparam := GetValidStr3 (cmdstr, cmdstr, ['/']); //cmdparam : �������
                  colorg := GetValidStr3 (cmdparam, colorg, ['=']); //��NPC�ű��еõ�����ɫ����
                  color123 := GetRGB(Str_ToInt(colorg,0));//strת��byte
               end else begin
                  DMenuDlg.Visible := FALSE;
                  DSellDlg.Visible := FALSE;
               end;

               if fdata <> '' then begin
                  BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, fdata);
                  sx := sx + FrmMain.Canvas.TextWidth(fdata);
                  //dsurface.Canvas.Release;
               end;
               if (cmdstr <> '') then begin
                  if RequireAddPoints and (color123 = 0) then begin
                     new (pcp);
                     pcp.rc := Rect (lx+sx, ly, lx+sx + FrmMain.Canvas.TextWidth(cmdstr), ly + 14);
                     pcp.RStr := cmdparam;
                     MDlgPoints.Add (pcp);
                  end;
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style + [fsUnderline];  //�����»���
                  if SelectMenuStr = cmdparam then begin
                     BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clRed, clBlack, cmdstr);
                     //dsurface.Canvas.Release;
                  //else BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clYellow, clBlack, cmdstr);//ԭ
                  end else begin
                    if Str_ToInt(colorg,0) <> 0 then begin
                      dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline]; //ȥ������������»���
                      BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), color123, clBlack, cmdstr)  //��ʾ��ɫ����
                    end else BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clYellow, clBlack, cmdstr);
                    //dsurface.Canvas.Release;
                  end;
                  sx := sx + FrmMain.Canvas.TextWidth(cmdstr);
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline];
                  //dsurface.Canvas.Release;
               end;
            end;
            if data <> '' then
               BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, data);
               //dsurface.Canvas.Release;
         end;
         ly := ly + 16;
      end;
      dsurface.Canvas.Release;
      RequireAddPoints := FALSE;
   end;

end;

procedure TFrmDlg.DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
   CloseMDlg;
end;

procedure TFrmDlg.DMenuDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
      Result := DMenuDlg.SurfaceX (DMenuDlg.Left + x);
  end;
  function SY(y: integer): integer;
  begin
      Result := DMenuDlg.SurfaceY (DMenuDlg.Top + y);
  end;
var
   i, lh,  m, menuline: integer;
   d: TDirectDrawSurface;
   pg: PTClientGoods;
   str: string;
begin
   with dsurface.Canvas do begin
      with DMenuDlg do begin
        if DMenuDlg.WLib <> nil then begin //20080701
         d := DMenuDlg.WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;

      {$IF Version = 1}
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      SetBkMode (Handle, TRANSPARENT);
      //title
      Font.Color := clWhite;
      if not BoStorageMenu then begin
         TextOut (SX(19),  SY(11), '��Ʒ�б�');
         TextOut (SX(156), SY(11), '�۸�');
         TextOut (SX(245), SY(11), '�־�');
         lh := LISTLINEHEIGHT;
         menuline := _MIN(MAXMENU, MenuList.Count-MenuTop);
         //��ǰ ����Ʈ
         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            if i = MenuIndex then begin
               Font.Color := clRed;
               TextOut (SX(12),  SY(32 + m*lh), char(7));
            end else Font.Color := clWhite;
            pg := PTClientGoods (MenuList[i]);
            TextOut (SX(19),  SY(32 + m*lh), pg.Name);
            if pg.SubMenu >= 1 then
               TextOut (SX(137), SY(32 + m*lh), #31);
            TextOut (SX(156), SY(32 + m*lh), IntToStr(pg.Price) + ' ' + g_sGoldName{���'});
            str := '';
            if pg.Grade = -1 then str := '-'
            else TextOut (SX(245), SY(32 + m*lh), IntToStr(pg.Grade));
            {else for k:=0 to pg.Grade-1 do
               str := str + '*';
            if Length(str) >= 4 then begin
               Font.Color := clYellow;
               TextOut (SX(245), SY(32 + m*lh), str);
            end else
               TextOut (SX(245), SY(32 + m*lh), str);}
         end;
      end else begin
         TextOut (SX(19),  SY(11), '�й���Ʒ�б�('+IntToStr(MenuList.Count)+'/44��)');
         TextOut (SX(156), SY(11), '�־�');
         TextOut (SX(245), SY(11), '');
         lh := LISTLINEHEIGHT;
         menuline := _MIN(MAXMENU, MenuList.Count-MenuTop);
         //��ǰ ����Ʈ
         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            if i = MenuIndex then begin
               Font.Color := clRed;
               TextOut (SX(12),  SY(32 + m*lh), char(7));
            end else Font.Color := clWhite;
            pg := PTClientGoods (MenuList[i]);
            TextOut (SX(19),  SY(32 + m*lh), pg.Name);
            if pg.SubMenu >= 1 then
               TextOut (SX(137), SY(32 + m*lh), #31);
            TextOut (SX(156), SY(32 + m*lh), IntToStr(pg.Stock) + '/' + IntToStr(pg.Grade));
         end;
      end;
      Release;
      {$ELSE}
      //title
      Font.Color := clWhite;
      if not BoStorageMenu then begin
         ClFunc.TextOut (dsurface, 19,  SY(11), Font.Color, '��Ʒ�б�');
         ClFunc.TextOut (dsurface, SX(156), SY(11), Font.Color, '�۸�');
         ClFunc.TextOut (dsurface, SX(245), SY(11), Font.Color, '�־�');
         lh := LISTLINEHEIGHT;
         menuline := _MIN(MAXMENU, MenuList.Count-MenuTop);
         //��ǰ ����Ʈ
         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            if i = MenuIndex then begin
              Font.Color := clRed;
               ClFunc.TextOut (dsurface, SX(12),  SY(32 + m*lh), Font.Color, char(7));
            end else Font.Color := clWhite;
            pg := PTClientGoods (MenuList[i]);
            ClFunc.TextOut (dsurface, SX(19),  SY(32 + m*lh), Font.Color, pg.Name);
            //if pg.SubMenu >= 1 then
            //   ClFunc.TextOut (dsurface, SX(137), SY(32 + m*lh), Font.Color, #31);
            ClFunc.TextOut (dsurface, SX(156), SY(32 + m*lh), Font.Color, IntToStr(pg.Price) + ' ' + g_sGoldName{���'});
            str := '';
            if pg.Grade = -1 then str := '-'
            else ClFunc.TextOut (dsurface, SX(245), SY(32 + m*lh), Font.Color,IntToStr(pg.Grade));
         end;
      end else begin
         ClFunc.TextOut (dsurface, SX(19),  SY(11), Font.Color, '�й���Ʒ�б�('+IntToStr(MenuList.Count)+'/44��)');
         ClFunc.TextOut (dsurface, SX(156), SY(11), Font.Color, '�־�');
         //ClFunc.TextOut (dsurface, SX(245), SY(11), Font.Color, '');
         lh := LISTLINEHEIGHT;
         menuline := _MIN(MAXMENU, MenuList.Count-MenuTop);
         //��ǰ ����Ʈ
         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            if i = MenuIndex then begin
               Font.Color := clRed;
               ClFunc.TextOut (dsurface, SX(12),  SY(32 + m*lh), Font.Color, char(7));
            end else Font.Color := clWhite;
            pg := PTClientGoods (MenuList[i]);
            ClFunc.TextOut (dsurface, SX(19),  SY(32 + m*lh), Font.Color, pg.Name);
            //if pg.SubMenu >= 1 then
            //   ClFunc.TextOut (dsurface, SX(137), SY(32 + m*lh), Font.Color, #31);
            ClFunc.TextOut (dsurface, SX(156), SY(32 + m*lh), Font.Color, IntToStr(pg.Stock) + '/' + IntToStr(pg.Grade));
         end;
      end;
      //TextOut (0, 0, IntToStr(MenuTopLine));
      Release;
      {$IFEND}
   end;
end;

procedure TFrmDlg.DMenuDlgClick(Sender: TObject; X, Y: Integer);
var
   lx, ly, idx: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
begin
   DScreen.ClearHint;
   lx := DMenuDlg.LocalX (X) - DMenuDlg.Left;
   ly := DMenuDlg.LocalY (Y) - DMenuDlg.Top;
   if (lx >= 14) and (lx <= 279) and (ly >= 32) and (ly <= 160){���� 2008.02.13} then begin
      idx := (ly-32) div LISTLINEHEIGHT + MenuTop;
      if idx < MenuList.Count then begin
         PlaySound (s_glass_button_click);
         MenuIndex := idx;
      end;
   end;

   if BoStorageMenu then begin
      if (MenuIndex >= 0) and (MenuIndex < g_SaveItemList.Count) then begin
         g_MouseItem := PTClientItem(g_SaveItemList[MenuIndex])^;
         GetMouseItemInfo (iname, d1, d2, d3, useable, 1{����});
         if iname <> '' then begin
            lx := 240;
            ly := 32+(MenuIndex-MenuTop) * LISTLINEHEIGHT;
            with Sender as TDButton do
               DScreen.ShowHint (DMenuDlg.SurfaceX(Left + lx),
                                 DMenuDlg.SurfaceY(Top + ly),
                                 iname + d1 + '\' + d2 + '\' + d3, clYellow, FALSE);
         end;
         g_MouseItem.S.Name := '';
      end;
   end else begin
      if (MenuIndex >= 0) and (MenuIndex < g_MenuItemList.Count) and (PTClientGoods (MenuList[MenuIndex]).SubMenu = 0) then begin
         g_MouseItem := PTClientItem(g_MenuItemList[MenuIndex])^;
         BoNoDisplayMaxDura := TRUE;
         GetMouseItemInfo (iname, d1, d2, d3, useable, 1{����});
         BoNoDisplayMaxDura := FALSE;
         if iname <> '' then begin
            lx := 240;
            ly := 32+(MenuIndex-MenuTop) * LISTLINEHEIGHT;
            with Sender as TDButton do
               DScreen.ShowHint (DMenuDlg.SurfaceX(Left + lx),
                                 DMenuDlg.SurfaceY(Top + ly),
                                 iname + d1 + '\' + d2 + '\' + d3, clYellow, FALSE);
         end;
         g_MouseItem.S.Name := '';
      end;
   end;
end;

procedure TFrmDlg.DMenuDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   with DMenuDlg do
      if (X < SurfaceX(Left+10)) or (X > SurfaceX(Left+Width-20)) or (Y < SurfaceY(Top+30)) or (Y > SurfaceY(Top+Height-50)) then begin
         DScreen.ClearHint;
      end;
end;

procedure TFrmDlg.DMenuBuyClick(Sender: TObject; X, Y: Integer);
var
   pg: PTClientGoods;
begin
   if GetTickCount < LastestClickTime then exit; 
   if (MenuIndex >= 0) and (MenuIndex < MenuList.Count) then begin
      pg := PTClientGoods (MenuList[MenuIndex]);
      LastestClickTime := GetTickCount + 5000;
      if pg.SubMenu > 0 then begin
         FrmMain.SendGetDetailItem (g_nCurMerchant, 0, pg.Name);
         MenuTopLine := 0;
         CurDetailItem := pg.Name;
      end else begin
         if BoStorageMenu then begin
            FrmMain.SendTakeBackStorageItem (g_nCurMerchant, pg.Price{MakeIndex}, pg.Name);
            exit;
         end;
         if BoMakeDrugMenu then begin
            FrmMain.SendMakeDrugItem (g_nCurMerchant, pg.Name);
            exit;
         end;
         FrmMain.SendBuyItem (g_nCurMerchant, pg.Stock, pg.Name)
      end;
   end;
end;

procedure TFrmDlg.DMenuPrevClick(Sender: TObject; X, Y: Integer);
begin
   if not BoDetailMenu then begin
      if MenuTop > 0 then Dec (MenuTop, MAXMENU-1);
      if MenuTop < 0 then MenuTop := 0;
   end else begin
      if MenuTopLine > 0 then begin
         MenuTopLine := _MAX(0, MenuTopLine-10);
         FrmMain.SendGetDetailItem (g_nCurMerchant, MenuTopLine, CurDetailItem);
      end;
   end;
end;

procedure TFrmDlg.DMenuNextClick(Sender: TObject; X, Y: Integer);
begin
   if not BoDetailMenu then begin
      if MenuTop + MAXMENU < MenuList.Count then Inc (MenuTop, MAXMENU-1);
   end else begin
      MenuTopLine := MenuTopLine + 10;
      FrmMain.SendGetDetailItem (g_nCurMerchant, MenuTopLine, CurDetailItem);
   end;      
end;

procedure TFrmDlg.SoldOutGoods (itemserverindex: integer);
var
   i: integer;
   pg: PTClientGoods;
begin
   if MenuList.Count > 0 then //20080629
   for i:=0 to MenuList.Count-1 do begin
      pg := PTClientGoods (MenuList[i]);
      if (pg.Grade >= 0) and (pg.Stock = itemserverindex) then begin
         Dispose (pg);
         MenuList.Delete (i);
         if i < g_MenuItemList.Count then g_MenuItemList.Delete (i);
         if MenuIndex > MenuList.Count-1 then MenuIndex := MenuList.Count-1;
         break;
      end;
   end;
end;

procedure TFrmDlg.DelStorageItem (itemserverindex: integer);
var
   i: integer;
   pg: PTClientGoods;
begin
   if MenuList.Count > 0 then //20080629
   for i:=0 to MenuList.Count-1 do begin
      pg := PTClientGoods (MenuList[i]);
      if (pg.Price = itemserverindex) then begin //��������ΰ�� Price = ItemServerIndex��.
         Dispose (pg);
         MenuList.Delete (i);
         if i < g_SaveItemList.Count then g_SaveItemList.Delete (i);
         if MenuIndex > MenuList.Count-1 then MenuIndex := MenuList.Count-1;
         break;
      end;
   end;
end;

procedure TFrmDlg.DMenuCloseClick(Sender: TObject; X, Y: Integer);
begin
   DMenuDlg.Visible := FALSE;
end;

procedure TFrmDlg.DMerchantDlgClick(Sender: TObject; X, Y: Integer);
var
   i, L, T: integer;
   p: PTClickPoint;
begin
   if GetTickCount < LastestClickTime then exit; 
   L := DMerchantDlg.Left;
   T := DMerchantDlg.Top;
   with DMerchantDlg do
      if MDlgPoints.Count > 0 then //20080629
      for i:=0 to MDlgPoints.Count-1 do begin
         p := PTClickPoint (MDlgPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            PlaySound (s_glass_button_click);
            FrmMain.SendMerchantDlgSelect (g_nCurMerchant, p.RStr);
            LastestClickTime := GetTickCount + 2000; //20080803�޸� ��ǰΪ5000
            break;
         end;
      end;
end;

procedure TFrmDlg.DMerchantDlgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   i, L, T: integer;
   p: PTClickPoint;
begin
   if GetTickCount < LastestClickTime then exit; 
   SelectMenuStr := '';
   L := DMerchantDlg.Left;
   T := DMerchantDlg.Top;
   with DMerchantDlg do
      if MDlgPoints.Count > 0 then //20080629
      for i:=0 to MDlgPoints.Count-1 do begin
         p := PTClickPoint (MDlgPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            SelectMenuStr := p.RStr;
            break;
         end;
      end;
   if DHeroIcon.Visible then DHeroIcon.Visible := False;  //20080521
end;

procedure TFrmDlg.DMerchantDlgMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   SelectMenuStr := '';
end;

procedure TFrmDlg.DSellDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   actionname: string;
begin
   with DSellDlg do begin
      if DMenuDlg.WLib <> nil then begin //20080701
        d := DMenuDlg.WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      with dsurface.Canvas do begin
         {$IF Version = 1}
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         {$IFEND}
         actionname := '';
         case SpotDlgMode of
            dmSell:   actionname := '����: ';
            dmRepair: actionname := '����: ';
            dmStorage: actionname := ' ������Ʒ';
            dmPlayDrink: actionname := '���';  //20080515
         end;
         {$IF Version = 1}
         TextOut (SurfaceX(Left+8), SurfaceY(Top+6), actionname + g_sSellPriceStr);
         {$ELSE}
         ClFunc.TextOut (dsurface, SurfaceX(Left+8), SurfaceY(Top+6), clWhite, actionname + g_sSellPriceStr);
         {$IFEND}
         Release;
      end;
   end;
end;

procedure TFrmDlg.DSellDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
   CloseDSellDlg;
end;

procedure TFrmDlg.DSellDlgSpotClick(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
begin
   g_sSellPriceStr := '';
   if not g_boItemMoving then begin
      if g_SellDlgItem.S.Name <> '' then begin
         ItemClickSound (g_SellDlgItem.S);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -99; //sell â���� ����..
         g_MovingItem.Item := g_SellDlgItem;
         g_SellDlgItem.S.Name := '';
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin //����,��Ʈ���� �°͸�
         ItemClickSound (g_MovingItem.Item.S);
         if g_SellDlgItem.S.Name <> '' then begin //�ڸ��� ������
            temp := g_SellDlgItem;
            g_SellDlgItem := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell â���� ����..
            g_MovingItem.Item := temp
         end else begin
            g_SellDlgItem := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
         end;
         g_boQueryPrice := TRUE;
         g_dwQueryPriceTime := GetTickCount;
      end;
   end;
end;

procedure TFrmDlg.DSellDlgSpotDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   if g_SellDlgItem.S.Name <> '' then begin
      d := g_WBagItemImages.Images[g_SellDlgItem.S.Looks];
      if d <> nil then
         with DSellDlgSpot do
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect,
                           d, TRUE);
   end;
end;

//����Ʒʱ����Ʒ���Ǹ����
procedure TFrmDlg.DSellDlgSpotMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   g_MouseItem := g_SellDlgItem;
end;

//����Ʒ��ȷ����ť
procedure TFrmDlg.DSellDlgOkClick(Sender: TObject; X, Y: Integer);
begin
   if (g_SellDlgItem.S.Name = '') and (g_SellDlgItemSellWait.S.Name = '') then exit;
   if GetTickCount < LastestClickTime then exit; 
   case SpotDlgMode of
      dmSell: FrmMain.SendSellItem (g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
      dmRepair: FrmMain.SendRepairItem (g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
      dmStorage: FrmMain.SendStorageItem (g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
      dmPlayDrink: FrmMain.SendPlayDrinkItem(g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
   end;
   g_SellDlgItemSellWait := g_SellDlgItem;
   g_SellDlgItem.S.Name := '';
   LastestClickTime := GetTickCount + 5000;
   g_sSellPriceStr := '';
end;



{------------------------------------------------------------------------}

//ħ�� Ű ���� â (���̾� �α�)

{------------------------------------------------------------------------}


procedure TFrmDlg.SetMagicKeyDlg (icon: integer; magname: string; var curkey: word);
begin
   MagKeyIcon := icon;
   MagKeyMagName := magname;
   MagKeyCurKey := curkey;


   DKeySelDlg.Left := (SCREENWIDTH - DKeySelDlg.Width) div 2;
   DKeySelDlg.Top  := (SCREENHEIGHT - DKeySelDlg.Height) div 2;
   HideAllControls;
   DKeySelDlg.ShowModal;

   while TRUE do begin
      if not DKeySelDlg.Visible then break;
      //FrmMain.DXTimerTimer (self, 0);
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;
      if Application.Terminated then exit;
   end;

   RestoreHideControls;
   curkey := MagKeyCurKey;
end;

procedure TFrmDlg.DKeySelDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DKeySelDlg do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
      //ħ����ݼ�
      with dsurface.Canvas do begin
         {$IF Version = 1}
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clSilver;
         {$IFEND}
         {$IF Version = 1}
         TextOut (SurfaceX(Left + 95), SurfaceY(Top + 38), MagKeyMagName + '  ��ݼ��̱�����Ϊ.');
         {$ELSE}
         ClFunc.TextOut (dsurface, SurfaceX(Left + 95), SurfaceY(Top + 38), clSilver ,MagKeyMagName + '  ��ݼ��̱�����Ϊ.');
         {$IFEND}
         Release;
      end;
   end;
end;

procedure TFrmDlg.DKsIconDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DksIcon do begin
      d := g_WMagIconImages.Images[MagKeyIcon];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DKsF1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   b: TDButton;
   d: TDirectDrawSurface;
begin
   case MagKeyCurKey of
      word('1'): b := DKsF1;
      word('2'): b := DKsF2;
      word('3'): b := DKsF3;
      word('4'): b := DKsF4;
      word('5'): b := DKsF5;
      word('6'): b := DKsF6;
      word('7'): b := DKsF7;
      word('8'): b := DKsF8;
      word('E'): b := DKsConF1;
      word('F'): b := DKsConF2;
      word('G'): b := DKsConF3;
      word('H'): b := DKsConF4;
      word('I'): b := DKsConF5;
      word('J'): b := DKsConF6;
      word('K'): b := DKsConF7;
      word('L'): b := DKsConF8;
      else b := DKsNone;
   end;
   if b = Sender then begin
      with b do begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex+1];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
   end;
   with Sender as TDButton do begin
      if Downed then begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
   end;
end;

procedure TFrmDlg.DKsOkClick(Sender: TObject; X, Y: Integer);
begin
   DKeySelDlg.Visible := FALSE;
end;

procedure TFrmDlg.DKsF1Click(Sender: TObject; X, Y: Integer);
begin
   if Sender = DKsF1 then MagKeyCurKey := integer('1');
   if Sender = DKsF2 then MagKeyCurKey := integer('2');
   if Sender = DKsF3 then MagKeyCurKey := integer('3');
   if Sender = DKsF4 then MagKeyCurKey := integer('4');
   if Sender = DKsF5 then MagKeyCurKey := integer('5');
   if Sender = DKsF6 then MagKeyCurKey := integer('6');
   if Sender = DKsF7 then MagKeyCurKey := integer('7');
   if Sender = DKsF8 then MagKeyCurKey := integer('8');
   if Sender = DKsConF1 then MagKeyCurKey := integer('E');
   if Sender = DKsConF2 then MagKeyCurKey := integer('F');
   if Sender = DKsConF3 then MagKeyCurKey := integer('G');
   if Sender = DKsConF4 then MagKeyCurKey := integer('H');
   if Sender = DKsConF5 then MagKeyCurKey := integer('I');
   if Sender = DKsConF6 then MagKeyCurKey := integer('J');
   if Sender = DKsConF7 then MagKeyCurKey := integer('K');
   if Sender = DKsConF8 then MagKeyCurKey := integer('L');
   if Sender = DKsNone then MagKeyCurKey := 0;
end;



{------------------------------------------------------------------------}

//�⺻â�� �̴� ��ư

{------------------------------------------------------------------------}


procedure TFrmDlg.DBotMiniMapClick(Sender: TObject; X, Y: Integer);
begin
  if not g_boViewMiniMap then begin
    if GetTickCount > g_dwQueryMsgTick then begin
       g_dwQueryMsgTick := GetTickCount + 3000;
       FrmMain.SendWantMiniMap;
       g_nViewMinMapLv:=1;
       DWMiniMap.Left := SCREENWIDTH - 120; //20080323
       DWMiniMap.Width := 120; //20080323
       DWMiniMap.Height:= 120; //20080323
    end;
  end else begin
   if g_nViewMinMapLv >= 2 then begin
     g_nViewMinMapLv:=0;
     g_boViewMiniMap := FALSE;
     DWMiniMap.Visible := False; //20080323
   end else begin
     Inc(g_nViewMinMapLv);
     DWMiniMap.Left := SCREENWIDTH - 160; //20080323
     DWMiniMap.Width := 160; //20080323
     DWMiniMap.Height:= 160; //20080323
   end;
  end;
end;

procedure TFrmDlg.DBotTradeClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwQueryMsgTick then begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendDealTry;
   end;
end;

procedure TFrmDlg.DBotGuildClick(Sender: TObject; X, Y: Integer);
begin
   if DGuildDlg.Visible then begin
      DGuildDlg.Visible := FALSE;
   end else
      if GetTickCount > g_dwQueryMsgTick then begin
         g_dwQueryMsgTick := GetTickCount + 3000;
         FrmMain.SendGuildDlg;
      end;
end;

procedure TFrmDlg.DBotGroupClick(Sender: TObject; X, Y: Integer);
begin
   ToggleShowGroupDlg;
end;


{------------------------------------------------------------------------}

//�׷� ���̾�α�

{------------------------------------------------------------------------}

procedure TFrmDlg.ToggleShowGroupDlg;
begin
   DGroupDlg.Visible := not DGroupDlg.Visible;
end;

procedure TFrmDlg.DGroupDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   lx, ly, n: integer;
begin
   with DGroupDlg do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
      {$IF Version = 1}
      if g_GroupMembers.Count > 0 then begin
         with dsurface.Canvas do begin
            SetBkMode (Handle, TRANSPARENT);
            Font.Color := clSilver;
            lx := SurfaceX(28) + Left;
            ly := SurfaceY(80) + Top;
            TextOut (lx, ly, g_GroupMembers[0]);
            if g_GroupMembers.Count > 0 then //20080629
            for n:=1 to g_GroupMembers.Count-1 do begin
               lx := SurfaceX(28) + Left + ((n-1) mod 2) * 100;
               ly := SurfaceY(80 + 16) + Top + ((n-1) div 2) * 16;
               TextOut (lx, ly, g_GroupMembers[n]);
            end;
            Release;
         end;
      end;
      {$ELSE}
      if g_GroupMembers.Count > 0 then begin
         with dsurface.Canvas do begin
            //SetBkMode (Handle, TRANSPARENT);
            //Font.Color := clSilver;
            lx := SurfaceX(28) + Left;
            ly := SurfaceY(80) + Top;
            ClFunc.TextOut (dsurface, lx, ly, clSilver, g_GroupMembers[0]);
            if g_GroupMembers.Count > 0 then //20080629
            for n:=1 to g_GroupMembers.Count-1 do begin
               lx := SurfaceX(28) + Left + ((n-1) mod 2) * 100;
               ly := SurfaceY(80 + 16) + Top + ((n-1) div 2) * 16;
               ClFunc.TextOut (dsurface, lx, ly, clSilver, g_GroupMembers[n]);
            end;
            Release;
         end;
      end;
      {$IFEND}
   end;
end;

procedure TFrmDlg.DGrpDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
   DGroupDlg.Visible := FALSE;
end;

procedure TFrmDlg.DGrpAllowGroupDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if WLib <> nil then begin //20080701
        if Downed then begin
           d := WLib.Images[FaceIndex-1];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end else begin
           if g_boAllowGroup then begin
              d := WLib.Images[FaceIndex];
              if d <> nil then
                 dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
           end;
        end;
      end;
   end;
end;

procedure TFrmDlg.DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwChangeGroupModeTick then begin
      g_boAllowGroup := not g_boAllowGroup;
      g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5��
      FrmMain.SendGroupMode (g_boAllowGroup);
   end;
end;

procedure TFrmDlg.DGrpCreateClick(Sender: TObject; X, Y: Integer);
var
   who: string;
begin
   if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count = 0) then begin
      DialogSize := 1;
      DMessageDlg ('��������������������.', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5��
         FrmMain.SendCreateGroup (Trim (DlgEditText));
      end;
   end;
end;

procedure TFrmDlg.DGrpAddMemClick(Sender: TObject; X, Y: Integer);
var
   who: string;
begin
   if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count > 0) then begin
      DialogSize := 1;
      DMessageDlg ('��������������������.', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5��
         FrmMain.SendAddGroupMember (Trim (DlgEditText));
      end;
   end;
end;

procedure TFrmDlg.DGrpDelMemClick(Sender: TObject; X, Y: Integer);
var
   who: string;
begin
   if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count > 0) then begin
      DialogSize := 1;
      DMessageDlg ('�������˳�������������.', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5��
         FrmMain.SendDelGroupMember (Trim (DlgEditText));
      end;
   end;
end;

procedure TFrmDlg.DBotLogoutClick(Sender: TObject; X, Y: Integer);
begin
               //ǿ���˳�
               g_dwLatestStruckTick:=GetTickCount() + 10001;
               g_dwLatestMagicTick:=GetTickCount() + 10001;
               g_dwLatestHitTick:=GetTickCount() + 10001;
               //
   if (GetTickCount - g_dwLatestStruckTick > 10000) and
      (GetTickCount - g_dwLatestMagicTick > 10000) and
      (GetTickCount - g_dwLatestHitTick > 10000) or
      (g_MySelf.m_boDeath) then begin
      FrmMain.AppLogOut;
   end else
      DScreen.AddChatBoardString ('����״̬�����˳���Ϸ.', clYellow, clRed);
end;

procedure TFrmDlg.DBotExitClick(Sender: TObject; X, Y: Integer);
begin
               //ǿ���˳�
               g_dwLatestStruckTick:=GetTickCount() + 10001;
               g_dwLatestMagicTick:=GetTickCount() + 10001;
               g_dwLatestHitTick:=GetTickCount() + 10001;
               //
   if (GetTickCount - g_dwLatestStruckTick > 10000) and
      (GetTickCount - g_dwLatestMagicTick > 10000) and
      (GetTickCount - g_dwLatestHitTick > 10000) or
      (g_MySelf.m_boDeath) then begin
      FrmMain.AppExit;
   end else
      DScreen.AddChatBoardString ('����״̬�����˳���Ϸ.', clYellow, clRed);
end;

procedure TFrmDlg.DBotPlusAbilClick(Sender: TObject; X, Y: Integer);
begin
   FrmDlg.OpenAdjustAbility;
end;

{******************************************************************************}
//�򿪽��׶Ի���
procedure TFrmDlg.OpenDealDlg;
//var
//   d: TDirectDrawSurface;
begin
   DDealRemoteDlg.Left := SCREENWIDTH-236-100;
   DDealRemoteDlg.Top := 0;
   DDealDlg.Left := SCREENWIDTH-236-100;
   DDealDlg.Top  := DDealRemoteDlg.Height-15;
   DItemBag.Left := -5; //475;
   DItemBag.Top := -25;
   DItemBag.Visible := TRUE;
   DDealDlg.Visible := TRUE;
   DDealRemoteDlg.Visible := TRUE;

   FillCHar (g_DealItems, sizeof(TClientItem)*10, #0);
   FillCHar (g_DealRemoteItems, sizeof(TClientItem)*20, #0);
   g_nDealGold := 0;
   g_nDealRemoteGold := 0;
   g_boDealEnd := FALSE;
   ArrangeItembag;
end;
{******************************************************************************}
//����ս�Ի���
procedure TFrmDlg.OpenChallengeDlg;
//var
//   d: TDirectDrawSurface;
begin
   DWChallenge.Left := 544;
   DWChallenge.Top := 0;
   DItemBag.Left := -5; //475;
   DItemBag.Top := -25;
   DItemBag.Visible := TRUE;
   DWChallenge.Visible := TRUE;

   FillCHar (g_ChallengeItems, sizeof(TClientItem)*4, #0);
   FillCHar (g_ChallengeRemoteItems, sizeof(TClientItem)*4, #0);
   g_nChallengeGold := 0;
   g_nChallengeRemoteGold := 0;
   g_nChallengeDiamond := 0;
   g_nChallengeRemoteDiamond := 0;
   g_boChallengeEnd := FALSE;
   ArrangeItembag;
end;
procedure TFrmDlg.CloseChallengeDlg;
begin
   DWChallenge.Visible := FALSE;
   ArrangeItembag;
end;
{******************************************************************************}
procedure TFrmDlg.CloseDealDlg;
begin
   DDealDlg.Visible := FALSE;
   DDealRemoteDlg.Visible := FALSE;

   //������ ���濡 �ܻ��� �ִ��� �˻�
   ArrangeItembag;
end;

procedure TFrmDlg.DDealOkClick(Sender: TObject; X, Y: Integer);
var
   mi: integer;
begin
   if GetTickCount > g_dwDealActionTick then begin
      //CloseDealDlg;
      FrmMain.SendDealEnd;
      g_dwDealActionTick := GetTickCount + 4000;
      g_boDealEnd := TRUE;
      if g_boItemMoving then begin
         mi := g_MovingItem.Index;
         if (mi <= -20) and (mi > -30) then begin //�� â���� �°͸�
            AddDealItem (g_MovingItem.Item);
            g_boItemMoving := FALSE;
            g_MovingItem.Item.S.name := '';
         end;
      end;
   end;
end;

procedure TFrmDlg.DDealCloseClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwDealActionTick then begin
      CloseDealDlg;
      FrmMain.SendCancelDeal;
   end;
end;

procedure TFrmDlg.DDealRemoteDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   with DDealRemoteDlg do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
      with dsurface.Canvas do begin
         {$IF Version = 1}
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (SurfaceX(Left+64), SurfaceY(Top+196-65), GetGoldStr(g_nDealRemoteGold));
         TextOut (SurfaceX(Left+59 + (106-TextWidth(g_sDealWho)) div 2), SurfaceY(Top+3)+3, g_sDealWho);         
         {$ELSE}
         ClFunc.TextOut (dsurface, SurfaceX(Left+64), SurfaceY(Top+196-65), clWhite, GetGoldStr(g_nDealRemoteGold));
         ClFunc.TextOut (dsurface, SurfaceX(Left+59 + (106-FrmMain.Canvas.TextWidth(g_sDealWho)) div 2), SurfaceY(Top+3)+3, clWhite, g_sDealWho);
         {$IFEND}
         Release;
      end;
   end;
end;

procedure TFrmDlg.DDealDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   with DDealDlg do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
      with dsurface.Canvas do begin
         {$IF Version = 1}
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (SurfaceX(Left+64), SurfaceY(Top+196-65), GetGoldStr(g_nDealGold));
         TextOut (SurfaceX(Left+59 + (106-TextWidth(FrmMain.CharName)) div 2), SurfaceY(Top+3)+3, FrmMain.CharName);
         {$ELSE}
         ClFunc.TextOut (dsurface, SurfaceX(Left+64), SurfaceY(Top+196-65), clWhite, GetGoldStr(g_nDealGold));
         ClFunc.TextOut (dsurface, SurfaceX(Left+59 + (106-FrmMain.Canvas.TextWidth(FrmMain.CharName)) div 2), SurfaceY(Top+3)+3, clWhite, FrmMain.CharName);
         {$IFEND}
         Release;
      end;
   end;
end;

procedure TFrmDlg.DealItemReturnBag (mitem: TClientItem);
begin
   if not g_boDealEnd then begin
      g_DealDlgItem := mitem;
      FrmMain.SendDelDealItem (g_DealDlgItem);
      g_dwDealActionTick := GetTickCount + 4000;
   end;
end;
//��ս��Ʒ���ذ��� 20080705
procedure TFrmDlg.ChallengeItemReturnBag (mitem: TClientItem);
begin
   if not g_boChallengeEnd then begin
      g_ChallengeDlgItem := mitem;
      FrmMain.SendDelChallengeItem (g_ChallengeDlgItem);
      g_dwChallengeActionTick := GetTickCount + 4000;
   end;
end;
//Ԫ�����۷��ذ��� 20080316
procedure TFrmDlg.SellOffItemReturnBag(mitem: TClientItem);
begin
  g_SellOffDlgItem := mitem;
  FrmMain.SendDelSellOffItem (g_SellOffDlgItem);
end;

procedure TFrmDlg.DDGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
//   temp: TClientItem;
   mi, idx: integer;
begin
   if not g_boDealEnd and (GetTickCount > g_dwDealActionTick) then begin
      if not g_boItemMoving then begin
         idx := ACol + ARow * DDGrid.ColCount;
         if idx in [0..9] then
            if g_DealItems[idx].S.Name <> '' then begin
               g_boItemMoving := TRUE;
               g_MovingItem.Index := -idx - 20;
               g_MovingItem.Item := g_DealItems[idx];
               g_DealItems[idx].S.Name := '';
               ItemClickSound (g_MovingItem.Item.S);
            end;
      end else begin
         mi := g_MovingItem.Index;
         if (mi >= 0) or (mi <= -20) and (mi > -30) then begin //����,���� �°͸�
            ItemClickSound (g_MovingItem.Item.S);
            g_boItemMoving := FALSE;
            if mi >= 0 then begin
               g_DealDlgItem := g_MovingItem.Item; //������ ����� ��ٸ��µ��� ����
               FrmMain.SendAddDealItem (g_DealDlgItem);
               g_dwDealActionTick := GetTickCount + 4000;
            end else
               AddDealItem (g_MovingItem.Item);
            g_MovingItem.Item.S.name := '';
         end;
         if mi = -98 then DDGoldClick (self, 0, 0);
      end;
      ArrangeItemBag;
   end;
end;

procedure TFrmDlg.DDGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DDGrid.ColCount;
   if idx in [0..9] then begin
      if g_DealItems[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_DealItems[idx].S.Looks];
         if d <> nil then
            with DDGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DDGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
   idx: integer;
begin
   idx := ACol + ARow * DDGrid.ColCount;
   if idx in [0..9] then begin
      g_MouseItem := g_DealItems[idx];
   end;
end;

procedure TFrmDlg.DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DDRGrid.ColCount;
   if idx in [0..19] then begin
      if g_DealRemoteItems[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_DealRemoteItems[idx].S.Looks];
         if d <> nil then
            with DDRGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DDRGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
begin
   idx := ACol + ARow * DDRGrid.ColCount;
   if idx in [0..19] then begin
      g_MouseItem := g_DealRemoteItems[idx];
   end;
end;

procedure TFrmDlg.DealZeroGold;
begin
   if not g_boDealEnd and (g_nDealGold > 0) then begin
      g_dwDealActionTick := GetTickCount + 4000;
      FrmMain.SendChangeDealGold (0);
   end;
end;

procedure TFrmDlg.DDGoldClick(Sender: TObject; X, Y: Integer);
var
   dgold: integer;
   valstr: string;
begin
   if g_MySelf = nil then exit;
   if not g_boDealEnd and (GetTickCount > g_dwDealActionTick) then begin
      if not g_boItemMoving then begin
         if g_nDealGold > 0 then begin
            PlaySound (s_money);
            g_boItemMoving := TRUE;
            g_MovingItem.Index := -97; //��ȯ â������ ��
            g_MovingItem.Item.S.Name := g_sGoldName{'���'};
         end;
      end else begin
         if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then begin //����..
            if (g_MovingItem.Index = -98) then begin //����â���� �� ��
               if g_MovingItem.Item.S.Name = g_sGoldName{'���'} then begin
                  //�󸶸� ���� ���� �����.
                  DialogSize := 1;
                  g_boItemMoving := FALSE;
                  g_MovingItem.Item.S.Name := '';
                  DMessageDlg ('������ ' +g_sGoldName+ ' ����', [mbOk, mbAbort]);
                  GetValidStrVal (DlgEditText, valstr, [' ']);
                  dgold := Str_ToInt (valstr, 0);
                  if (dgold <= (g_nDealGold+g_MySelf.m_nGold)) and (dgold > 0) then begin
                     FrmMain.SendChangeDealGold (dgold);
                     g_dwDealActionTick := GetTickCount + 4000;
                  end;
               end;
            end;
            g_boItemMoving := FALSE;
            g_MovingItem.Item.S.Name := '';
         end;
      end;
   end;
end;



{--------------------����װ������2007.10.16-----����-----------------}


procedure TFrmDlg.DUserState1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   pgidx, bbx, bby, idx, ax, ay, sex, hair: integer;
   d: TDirectDrawSurface;
   hcolor: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
begin
   with DUserState1 do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      //�۲���˵�װ��4����
      sex := DRESSfeature (UserState1.Feature) mod 2;    //�Ա�
      hair := HAIRfeature (UserState1.Feature);
      if sex = 1 then pgidx := 30{377}   //Ů
      else pgidx := 29{376};     //��
      bbx := Left + 38;
      bby := Top + 52;
      d := g_WMain3Images.Images[pgidx];
      if d <> nil then
         dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);
      bbx := bbx - 7;
      bby := bby + 44;
      //�۲�������﷢��2007.10.16 ����
      idx := 1799; //�Ӹ� ��Ÿ��
      if sex = 1 then idx := 2399;//480 + hair div 2;
      {if hair <> 0 then
      if idx > 0 then begin
         d := g_WHairImgImages.GetCachedImage (idx, ax, ay);
         if d <> nil then
            dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
      end;}
     if sex = 0 then begin   //��
      if hair <> 0 then
        if idx > 0 then begin
           d := g_WHairImgImages.GetCachedImage (idx, ax, ay);
           if d <> nil then
              dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
        end;
     end else if hair <> 1 then begin
        if idx > 0 then begin
           d := g_WHairImgImages.GetCachedImage (idx, ax, ay);
           if d <> nil then
              dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
        end;
     end else begin
           d := g_WHairImgImages.GetCachedImage (1199, ax, ay);
           if d <> nil then
              dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
     end;
      if UserState1.UseItems[U_DRESS].S.Name <> '' then begin
         idx := UserState1.UseItems[U_DRESS].S.Looks; //�� if m_btSex = 1 then idx := 80; //���ڿ�
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            d := FrmMain.GetWStateImg(idx,ax,ay);
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
         end;
      end;
      if UserState1.UseItems[U_WEAPON].S.Name <> '' then begin
         idx := UserState1.UseItems[U_WEAPON].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            d := FrmMain.GetWStateImg(idx,ax,ay);
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
         end;
      end;
      {if UserState1.UseItems[U_HELMET].S.Name <> '' then begin
         idx := UserState1.UseItems[U_HELMET].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            d := FrmMain.GetWStateImg(idx,ax,ay);
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
         end;
      end;}
            //���� 20080417
            if UserState1.UseItems[U_ZHULI].S.Name <> '' then begin
               idx := UserState1.UseItems[U_ZHULI].S.Looks;
               if idx >= 0 then begin
                  d := FrmMain.GetWStateImg(idx,ax,ay);
                  if d <> nil then
                     dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
               end;
            end else
              if UserState1.UseItems[U_HELMET].S.Name <> '' then begin
                 idx := UserState1.UseItems[U_HELMET].S.Looks;
                 if idx >= 0 then begin
                    d := FrmMain.GetWStateImg(idx,ax,ay);
                    if d <> nil then
                       dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                 end;
              end;


      //ԭΪ�򿪣���ʾ����������Ϣ���װ����Ϣ����ʾ�������·�
      if g_MouseUserStateItem.S.Name <> '' then begin
         g_MouseItem := g_MouseUserStateItem;
         GetMouseItemInfo (iname, d1, d2, d3, useable,1);
         if iname <> '' then begin
            if g_MouseItem.Dura = 0 then hcolor := clRed
            else hcolor := clWhite;
            with dsurface.Canvas do begin
               {$if Version = 1}
               SetBkMode (Handle, TRANSPARENT);
               {$IFEND}
               BoldTextOut (dsurface,SurfaceX(Left+37), SurfaceY(Top+310), clYellow, clBlack,iname);
               BoldTextOut (dsurface,SurfaceX(Left+37+FrmMain.Canvas.TextWidth(iname)), SurfaceY(Top+310), hcolor, clBlack, d1);
               BoldTextOut (dsurface,SurfaceX(Left+37), SurfaceY(Top+310+FrmMain.Canvas.TextHeight('A')+2), hcolor, clBlack, d2);
               BoldTextOut (dsurface,SurfaceX(Left+37), SurfaceY(Top+310+(FrmMain.Canvas.TextHeight('A')+2)*2), hcolor, clBlack, d3);
               Release;
            end;
         end;
         g_MouseItem.S.Name := '';
      end;


      {$IF Version = 1}
      //���ֺ��л�
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         if g_nUserSelectName = 1 then //20080302
          Font.Color := clSilver
         else if g_nUserSelectName = 3 then Font.Color := clRed else
         Font.Color := UserState1.NameColor;
         TextOut (SurfaceX(Left + 122 - TextWidth(UserState1.UserName) div 2),
                  SurfaceY(Top + 23), UserState1.UserName);
         if g_nUserSelectName = 2 then  //20080302
           Font.Color := clWhite
         else if g_nUserSelectName = 4 then Font.Color := clRed else
         Font.Color := clSilver;
         case g_boUserIsWho of
          1: TextOut (SurfaceX(Left + 45), SurfaceY(Top + 55),
                      UserState1.GuildName+' ��Ӣ��');
          2: TextOut (SurfaceX(Left + 45), SurfaceY(Top + 55),
                      UserState1.GuildName+' �ķ���');
         else
            TextOut (SurfaceX(Left + 45), SurfaceY(Top + 55),
                      UserState1.GuildName + ' ' + UserState1.GuildRankName);
         end;
         Release;
      end;
      {$ELSE}
      //���ֺ��л�
      with dsurface.Canvas do begin
         //SetBkMode (Handle, TRANSPARENT);
         if g_nUserSelectName = 1 then //20080302
          Font.Color := clSilver
         else if g_nUserSelectName = 3 then Font.Color := clRed else
         Font.Color := UserState1.NameColor;
         ClFunc.TextOut (dsurface, SurfaceX(Left + 122 - FrmMain.Canvas.TextWidth(UserState1.UserName) div 2),
                  SurfaceY(Top + 23), Font.Color, UserState1.UserName);
         if g_nUserSelectName = 2 then  //20080302
           Font.Color := clWhite
         else if g_nUserSelectName = 4 then Font.Color := clRed else
         Font.Color := clSilver;
         case g_boUserIsWho of
          1: ClFunc.TextOut (dsurface, SurfaceX(Left + 45), SurfaceY(Top + 55),
                     font.Color, UserState1.GuildName+' ��Ӣ��');
          2: ClFunc.TextOut (dsurface, SurfaceX(Left + 45), SurfaceY(Top + 55),
                     Font.Color, UserState1.GuildName+' �ķ���');
         else
            ClFunc.TextOut (dsurface, SurfaceX(Left + 45), SurfaceY(Top + 55),
                     Font.Color, UserState1.GuildName + ' ' + UserState1.GuildRankName);
         end;
         //Release;
      end;
      {$IFEND}
   end;
end;

procedure TFrmDlg.DUserState1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lx,ly:integer;
begin
   lx := DUserState1.LocalX (X) - DUserState1.Left;
   ly := DUserState1.LocalY (Y) - DUserState1.Top;
   if (lx >= 56) and (lx <= 180) and (ly >= 22) and (ly <= 35) then begin
      g_nUserSelectName := 3;
      g_boSelectText := True;
   end;
   if (lx >= 42) and (lx <= 201) and (ly >= 56) and (ly <= 69) then begin
      g_nUserSelectName := 4;
      g_boSelectText := True;
   end;
end;

procedure TFrmDlg.DUserState1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  lx,ly:integer;
begin
  DScreen.ClearHint;
  g_MouseUserStateItem.S.Name := '';
   if not g_boSelectText then 
      g_nUserSelectName := 0;   //20080302
   lx := DUserState1.LocalX (X) - DUserState1.Left;
   ly := DUserState1.LocalY (Y) - DUserState1.Top;
   if (lx >= 56) and (lx <= 180) and (ly >= 22) and (ly <= 35) then begin
         if not g_boSelectText then
           g_nUserSelectName := 1;  //20080302
        if ssLeft in Shift then begin
          PlayScene.EdChat.Visible := TRUE;
          PlayScene.EdChat.Text := '/'+ UserState1.UserName+' ';
          PlayScene.EdChat.SetFocus;
          SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
          PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
        end;
   end;
   if (lx >= 42) and (lx <= 201) and (ly >= 56) and (ly <= 69) then begin
       if not g_boSelectText then
          g_nUserSelectName := 2;  //20080302
       if ssLeft in Shift then begin
          PlayScene.EdChat.Visible := TRUE;
          PlayScene.EdChat.Text := '/'+ UserState1.GuildName+' ';
          PlayScene.EdChat.SetFocus;
          SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
          PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
        end;
   end;


end;

procedure TFrmDlg.DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
   sel: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
   hcolor: TColor;
   nHintX,nHintY: Integer;
begin
   sel := -1;
   if Sender = DDressUS1 then sel := U_DRESS;
   if Sender = DWeaponUS1 then sel := U_WEAPON;
   if Sender = DHelmetUS1 then sel := U_HELMET;
   if Sender = DNecklaceUS1 then sel := U_NECKLACE;
   if Sender = DLightUS1 then sel := U_RIGHTHAND;
   if Sender = DRingLUS1 then sel := U_RINGL;
   if Sender = DRingRUS1 then sel := U_RINGR;
   if Sender = DArmRingLUS1 then sel := U_ARMRINGL;
   if Sender = DArmRingRUS1 then sel := U_ARMRINGR;

   if Sender = DBujukUS1 then sel := U_BUJUK;
   if Sender = DBeltUS1 then sel := U_BELT;
   if Sender = DBootsUS1 then sel := U_BOOTS;
   if Sender = DCharmUS1 then sel := U_CHARM;

   if sel >= 0 then begin
      g_MouseUserStateItem := UserState1.UseItems[sel];


      if Sender = DHelmetUS1 then begin
        if UserState1.UseItems[U_ZHULI].s.Name <> '' then begin
          g_MouseItem := UserState1.UseItems[U_ZHULI];
          GetMouseItemInfo (iname, d1, d2, d3, useable, 1{Ӣ��});
          if iname <> '' then begin
            if UserState1.UseItems[U_ZHULI].Dura = 0 then hcolor := clRed
            else hcolor := clYellow;

            nHintX:=DHelmetUS1.SurfaceX(DHelmetUS1.Left) + DHelmetUS1.Width * 2;
            nHintY:=DHelmetUS1.SurfaceY(DHelmetUS1.Top);
            with DHelmetUS1 as TDButton do
              DScreen.ShowHint(nHintX,nHintY,
                             iname  + '\'+ d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
          end;
          g_MouseItem.S.Name := '';
        end;
      end;
      //ԭΪע�͵� ��ʾ�������ϴ�����Ʒ��Ϣ
      (*g_MouseItem := UserState1.UseItems[sel];
      GetMouseItemInfo (iname, d1, d2, d3, useable, 1{����});
      if iname <> '' then begin
         if UserState1.UseItems[sel].Dura = 0 then hcolor := clRed
         else hcolor := clWhite;
         with Sender as TDButton do
            DScreen.ShowHint (SurfaceX(Left - 30),
                              SurfaceY(Top + 50),
                              iname + d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
      end;
      g_MouseItem.S.Name := '';  *)
      //      
   end;

end;

procedure TFrmDlg.DCloseUS1Click(Sender: TObject; X, Y: Integer);
begin
   DUserState1.Visible := FALSE;
end;

procedure TFrmDlg.DNecklaceUS1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
  if (UserState1.UseItems[U_NECKLACE].S.Reserved1 = 1) or (UserState1.UseItems[U_RIGHTHAND].S.Reserved1 = 1)
      or (UserState1.UseItems[U_ARMRINGR].S.Reserved1 = 1) or (UserState1.UseItems[U_ARMRINGL].S.Reserved = 1)
      or (UserState1.UseItems[U_RINGR].S.Reserved1 = 1) or (UserState1.UseItems[U_RINGL].S.Reserved1 = 1)
      or (UserState1.UseItems[U_BUJUK].S.Reserved1 = 1) or (UserState1.UseItems[U_BELT].S.Reserved1 = 1)
      or (UserState1.UseItems[U_BOOTS].S.Reserved1 = 1) or (UserState1.UseItems[U_CHARM].S.Reserved1 = 1) then
      ItemLightTimeImg(); //��Ʒ����任���� 20080223

   if Sender = DNecklaceUS1 then begin
      if UserState1.UseItems[U_NECKLACE].S.Name <> '' then begin
         idx := UserState1.UseItems[U_NECKLACE].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DNecklaceUS1.SurfaceX(DNecklaceUS1.Left + (DNecklaceUS1.Width - d.Width) div 2),
                              DNecklaceUS1.SurfaceY(DNecklaceUS1.Top + (DNecklaceUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);

              if UserState1.UseItems[U_NECKLACE].S.Reserved1 = 1 then begin  //���� 20080223
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DNecklaceUS1.SurfaceX(DNecklaceUS1.Left-21), DNecklaceUS1.SurfaceY(DNecklaceUS1.Top-23), d, 1);
              end;
         end;
      end;
   end;
   if Sender = DLightUS1 then begin
      if UserState1.UseItems[U_RIGHTHAND].S.Name <> '' then begin
         idx := UserState1.UseItems[U_RIGHTHAND].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DLightUS1.SurfaceX(DLightUS1.Left + (DLightUS1.Width - d.Width) div 2),
                              DLightUS1.SurfaceY(DLightUS1.Top + (DLightUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);

              if UserState1.UseItems[U_RIGHTHAND].S.Reserved1 = 1 then begin  //���� 20080223
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DLightUS1.SurfaceX(DLightUS1.Left-21), DLightUS1.SurfaceY(DLightUS1.Top-23), d, 1);
              end;
         end;
      end;
   end;
   if Sender = DArmRingRUS1 then begin
      if UserState1.UseItems[U_ARMRINGR].S.Name <> '' then begin
         idx := UserState1.UseItems[U_ARMRINGR].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DArmRingRUS1.SurfaceX(DArmRingRUS1.Left + (DArmRingRUS1.Width - d.Width) div 2),
                              DArmRingRUS1.SurfaceY(DArmRingRUS1.Top + (DArmRingRUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);

              if UserState1.UseItems[U_ARMRINGR].S.Reserved1 = 1 then begin  //���� 20080223
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DArmRingRUS1.SurfaceX(DArmRingRUS1.Left-21), DArmRingRUS1.SurfaceY(DArmRingRUS1.Top-23), d, 1);
              end;
         end;
      end;
   end;
   if Sender = DArmRingLUS1 then begin
      if UserState1.UseItems[U_ARMRINGL].S.Name <> '' then begin
         idx := UserState1.UseItems[U_ARMRINGL].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DArmRingLUS1.SurfaceX(DArmRingLUS1.Left + (DArmRingLUS1.Width - d.Width) div 2),
                              DArmRingLUS1.SurfaceY(DArmRingLUS1.Top + (DArmRingLUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);

              if UserState1.UseItems[U_ARMRINGL].S.Reserved1 = 1 then begin  //���� 20080223
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DArmRingLUS1.SurfaceX(DArmRingLUS1.Left-21), DArmRingLUS1.SurfaceY(DArmRingLUS1.Top-23), d, 1);
              end;
         end;
      end;
   end;
   if Sender = DRingRUS1 then begin
      if UserState1.UseItems[U_RINGR].S.Name <> '' then begin
         idx := UserState1.UseItems[U_RINGR].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DRingRUS1.SurfaceX(DRingRUS1.Left + (DRingRUS1.Width - d.Width) div 2),
                              DRingRUS1.SurfaceY(DRingRUS1.Top + (DRingRUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);

              if UserState1.UseItems[U_RINGR].S.Reserved1 = 1 then begin  //���� 20080223
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DRingRUS1.SurfaceX(DRingRUS1.Left-21), DRingRUS1.SurfaceY(DRingRUS1.Top-23), d, 1);
              end;
         end;
      end;
   end;
   if Sender = DRingLUS1 then begin
      if UserState1.UseItems[U_RINGL].S.Name <> '' then begin
         idx := UserState1.UseItems[U_RINGL].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DRingLUS1.SurfaceX(DRingLUS1.Left + (DRingLUS1.Width - d.Width) div 2),
                              DRingLUS1.SurfaceY(DRingLUS1.Top + (DRingLUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);

              if UserState1.UseItems[U_RINGL].S.Reserved1 = 1 then begin  //���� 20080223
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DRingLUS1.SurfaceX(DRingLUS1.Left-21), DRingLUS1.SurfaceY(DRingLUS1.Top-23), d, 1);
              end;
         end;
      end;
   end;


   if Sender = DBujukUS1 then begin
      if UserState1.UseItems[U_BUJUK].S.Name <> '' then begin
         idx := UserState1.UseItems[U_BUJUK].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DBujukUS1.SurfaceX(DBujukUS1.Left + (DBujukUS1.Width - d.Width) div 2),
                              DBujukUS1.SurfaceY(DBujukUS1.Top + (DBujukUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);

              if UserState1.UseItems[U_BUJUK].S.Reserved1 = 1 then begin  //���� 20080223
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DBujukUS1.SurfaceX(DBujukUS1.Left-21), DBujukUS1.SurfaceY(DBujukUS1.Top-23), d, 1);
              end;
         end;
      end;
   end;

   if Sender = DBeltUS1 then begin
      if UserState1.UseItems[U_BELT].S.Name <> '' then begin
         idx := UserState1.UseItems[U_BELT].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DBeltUS1.SurfaceX(DBeltUS1.Left + (DBeltUS1.Width - d.Width) div 2),
                              DBeltUS1.SurfaceY(DBeltUS1.Top + (DBeltUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);

              if UserState1.UseItems[U_BELT].S.Reserved1 = 1 then begin  //���� 20080223
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DBeltUS1.SurfaceX(DBeltUS1.Left-21), DBeltUS1.SurfaceY(DBeltUS1.Top-23), d, 1);
              end;
         end;
      end;
   end;

   if Sender = DBootsUS1 then begin
      if UserState1.UseItems[U_BOOTS].S.Name <> '' then begin
         idx := UserState1.UseItems[U_BOOTS].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DBootsUS1.SurfaceX(DBootsUS1.Left + (DBootsUS1.Width - d.Width) div 2),
                              DBootsUS1.SurfaceY(DBootsUS1.Top + (DBootsUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);

              if UserState1.UseItems[U_BOOTS].S.Reserved1 = 1 then begin  //���� 20080223
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DBootsUS1.SurfaceX(DBootsUS1.Left-21), DBootsUS1.SurfaceY(DBootsUS1.Top-23), d, 1);
              end;
         end;
      end;
   end;

   if Sender = DCharmUS1 then begin
      if UserState1.UseItems[U_CHARM].S.Name <> '' then begin
         idx := UserState1.UseItems[U_CHARM].S.Looks;
         if idx >= 0 then begin
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DCharmUS1.SurfaceX(DCharmUS1.Left + (DCharmUS1.Width - d.Width) div 2),
                              DCharmUS1.SurfaceY(DCharmUS1.Top + (DCharmUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);

              if UserState1.UseItems[U_CHARM].S.Reserved1 = 1 then begin  //���� 20080223
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DCharmUS1.SurfaceX(DCharmUS1.Left-21), DCharmUS1.SurfaceY(DCharmUS1.Top-23), d, 1);
              end;
         end;
      end;
   end;
end;


procedure TFrmDlg.ShowGuildDlg;
begin
   DGuildDlg.Visible := TRUE;  //not DGuildDlg.Visible;
   DGuildDlg.Top := -3;
   DGuildDlg.Left := 0;
   if DGuildDlg.Visible then begin
      if GuildCommanderMode then begin
         DGDAddMem.Visible := TRUE;
         DGDDelMem.Visible := TRUE;
         DGDEditNotice.Visible := TRUE;
         DGDEditGrade.Visible := TRUE;
         DGDAlly.Visible := TRUE;
         DGDBreakAlly.Visible := TRUE;
         DGDWar.Visible := TRUE;
         DGDCancelWar.Visible := TRUE;
      end else begin
         DGDAddMem.Visible := FALSE;
         DGDDelMem.Visible := FALSE;
         DGDEditNotice.Visible := FALSE;
         DGDEditGrade.Visible := FALSE;
         DGDAlly.Visible := FALSE;
         DGDBreakAlly.Visible := FALSE;
         DGDWar.Visible := FALSE;
         DGDCancelWar.Visible := FALSE;
      end;

   end;
   GuildTopLine := 0;
end;

procedure TFrmDlg.ShowGuildEditNotice;
var
   d: TDirectDrawSurface;
   i: integer;
   data: string;
begin
   with DGuildEditNotice do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then begin
         Left := (SCREENWIDTH - d.Width) div 2;
         Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      HideAllControls;
      DGuildEditNotice.ShowModal;

      Memo.Left := SurfaceX(Left+16);
      Memo.Top  := SurfaceY(Top+36);
      Memo.Width := 571;
      Memo.Height := 246;
      Memo.Lines.Assign (GuildNotice);
      Memo.Visible := TRUE;

      while TRUE do begin
         if not DGuildEditNotice.Visible then break;
         FrmMain.ProcOnIdle;
         Application.ProcessMessages;
         if Application.Terminated then exit;
      end;

      DGuildEditNotice.Visible := FALSE;
      RestoreHideControls;

      if DMsgDlg.DialogResult = mrOk then begin
         data := '';
         if Memo.Lines.Count > 0 then //20080629
         for i:=0 to Memo.Lines.Count-1 do begin
            if Memo.Lines[i] = '' then
               data := data + Memo.Lines[i] + ' '#13
            else data := data + Memo.Lines[i] + #13;
         end;
         if Length(data) > 4000 then begin
            data := Copy (data, 1, 4000);
            DMessageDlg ('�������ݳ������ƴ�С���������ݽ����ض̣�', [mbOk]);
         end;
         FrmMain.SendGuildUpdateNotice (data);
      end;
   end;
end;

procedure TFrmDlg.ShowGuildEditGrade;
var
   d: TDirectDrawSurface;
   data: string;
   i: integer;
begin
   if GuildMembers.Count <= 0 then begin
      DMessageDlg ('���ȴ򿪳�Ա�б�', [mbOk]);
      Exit;
   end;

   with DGuildEditNotice do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then begin
         Left := (SCREENWIDTH - d.Width) div 2;
         Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      HideAllControls;
      DGuildEditNotice.ShowModal;

      Memo.Left := SurfaceX(Left+16);
      Memo.Top  := SurfaceY(Top+36);
      Memo.Width := 571;
      Memo.Height := 246;
      Memo.Lines.Assign (GuildMembers);
      Memo.Visible := TRUE;

      while TRUE do begin
         if not DGuildEditNotice.Visible then break;
         FrmMain.ProcOnIdle;
         Application.ProcessMessages;
         if Application.Terminated then exit;
      end;

      DGuildEditNotice.Visible := FALSE;
      RestoreHideControls;

      if DMsgDlg.DialogResult = mrOk then begin
         data := '';
         if Memo.Lines.Count > 0 then //20080629
         for i:=0 to Memo.Lines.Count-1 do begin
            data := data + Memo.Lines[i] + #13;  
         end;
         if Length(data) > 5000 then begin
            data := Copy (data, 1, 5000);
            DMessageDlg ('���ݳ������ƴ�С�����ݽ����ض�', [mbOk]);
         end;
         FrmMain.SendGuildUpdateGrade (data);
      end;
   end;
end;

procedure TFrmDlg.DGuildDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  i, n, bx, by: integer;
begin
   with DGuildDlg do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      with dsurface.Canvas do begin
         {$IF Version = 1}
         SetBkMode (Handle, TRANSPARENT);
         {$IFEND}
         Font.Color := clWhite;
         {$IF Version = 1}
         TextOut (Left+320, Top+13, Guild); //�л���
         {$ELSE}
         ClFunc.TextOut (dsurface, Left+320, Top+13, Font.Color, Guild); //�л���
         {$IFEND}

         bx := Left + 24;
         by := Top + 41;
         if GuildStrs.Count > 0 then //20080629
         for i:=GuildTopLine to GuildStrs.Count-1 do begin
            n := i-GuildTopLine;
            if n*14 > 356 then break;
            if Integer(GuildStrs.Objects[i]) <> 0 then Font.Color := TColor(GuildStrs.Objects[i])
            else begin
               if BoGuildChat then Font.Color := GetRGB (2)
               else Font.Color := clSilver;
            end;
            {$IF Version = 1}
            TextOut (bx, by + n*14, GuildStrs[i]);
            {$ELSE}
            ClFunc.TextOut (dsurface, bx, by + n*14, Font.Color, GuildStrs[i]);
            {$IFEND}
         end;
         {$IF Version = 1}
         Release;
         {$IFEND}
      end;

   end;
end;

procedure TFrmDlg.DGDUpClick(Sender: TObject; X, Y: Integer);
begin
   if GuildTopLine > 0 then Dec (GuildTopLine, 3);
   if GuildTopLine < 0 then GuildTopLine := 0;
end;

procedure TFrmDlg.DGDDownClick(Sender: TObject; X, Y: Integer);
begin
   if GuildTopLine+12 < GuildStrs.Count then Inc (GuildTopLine, 3);
end;

procedure TFrmDlg.DGDCloseClick(Sender: TObject; X, Y: Integer);
begin
   DGuildDlg.Visible := FALSE;
   BoGuildChat := FALSE;
end;

procedure TFrmDlg.DGDHomeClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwQueryMsgTick then begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendGuildHome;
      BoGuildChat := FALSE;
   end;
end;

procedure TFrmDlg.DGDListClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwQueryMsgTick then begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendGuildMemberList;
      BoGuildChat := FALSE;
   end;
end;

procedure TFrmDlg.DGDAddMemClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg ('�����������' + Guild + '���������ƣ�', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendGuildAddMem (DlgEditText);
end;

procedure TFrmDlg.DGDDelMemClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg ('��������Ҫ�������������ƣ�', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendGuildDelMem (DlgEditText);
end;

procedure TFrmDlg.DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
begin
   GuildEditHint := '[�޸��л�ͨ������]';
   ShowGuildEditNotice;
end;

procedure TFrmDlg.DGDEditGradeClick(Sender: TObject; X, Y: Integer);
begin
   GuildEditHint := '[�޸��л��Ա�ĵȼ���ְλ�� # ���� : ���������л��Ա/ɾ���л��Ա]';
   ShowGuildEditGrade;
end;
//����
procedure TFrmDlg.DGDAllyClick(Sender: TObject; X, Y: Integer);
begin
   if mrOk = DMessageDlg ('�Է������л������ [�������]״̬�¡�\' +
                  '���Ҷ����л�Ĺ����߱�������档\' +
                  '�Ƿ�ȷ���л���ˣ�', [mbOk, mbCancel])
   then
      FrmMain.SendSay ('@Alliance');
end;
//�������
procedure TFrmDlg.DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg ('����������ȡ�����˵��л������.', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendSay ('@CancelAlliance ' + DlgEditText);
end;



procedure TFrmDlg.DGuildEditNoticeDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DGuildEditNotice do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      with dsurface.Canvas do begin
         {$IF Version = 1}
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clSilver;
         TextOut (Left+18, Top+291, GuildEditHint);
         Release;
         {$ELSE}
         ClFunc.TextOut (dsurface, Left+18, Top+291, clSilver, GuildEditHint);
         {$IFEND}
      end;
   end;
end;

procedure TFrmDlg.DGECloseClick(Sender: TObject; X, Y: Integer);
begin
   DGuildEditNotice.Visible := FALSE;
   Memo.Visible := FALSE;
   DMsgDlg.DialogResult := mrCancel;
end;

procedure TFrmDlg.DGEOkClick(Sender: TObject; X, Y: Integer);
begin
   DGECloseClick (self, 0, 0);
   DMsgDlg.DialogResult := mrOk;
end;

procedure TFrmDlg.AddGuildChat (str: string);
var
   i: integer;
begin
   GuildChats.Add (str);
   if GuildChats.Count > 500 then begin
      for i:=0 to 100 do GuildChats.Delete(0);
   end;
   if BoGuildChat then
      GuildStrs.Assign (GuildChats);
end;

procedure TFrmDlg.DGDChatClick(Sender: TObject; X, Y: Integer);
begin
   BoGuildChat := not BoGuildChat;
   if BoGuildChat then begin
      GuildStrs2.Assign (GuildStrs);
      GuildStrs.Assign (GuildChats);
   end else
      GuildStrs.Assign (GuildStrs2);
end;

procedure TFrmDlg.DGoldDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   if g_MySelf = nil then exit;
   with DGold do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;


{--------------------------------------------------------------}
//�ɷ�ġ ���� â

procedure TFrmDlg.DAdjustAbilCloseClick(Sender: TObject; X, Y: Integer);
begin
   DAdjustAbility.Visible := FALSE;
   g_nBonusPoint := g_nSaveBonusPoint;
end;

procedure TFrmDlg.DAdjustAbilityDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
   procedure AdjustAb (abil: byte; val: word; var lov, hiv: Word);
   var
      lo, hi: byte;
      i: integer;
   begin
      lo := Lobyte(abil);
      hi := Hibyte(abil);
      lov := 0; hiv := 0;
      for i:=1 to val do begin
         if lo+1 < hi then begin Inc(lo); Inc(lov);
         end else begin Inc(hi); Inc(hiv); end;
      end;
   end;
var
   d: TDirectDrawSurface;
   l, m, adc, amc, asc, aac, amac: integer;
   ldc, lmc, lsc, lac, lmac, hdc, hmc, hsc, hac, hmac: Word;
begin
   if g_MySelf = nil then exit;
   with dsurface.Canvas do begin
      with DAdjustAbility do begin
        if DMenuDlg.WLib <> nil then begin //20080701
         d := DMenuDlg.WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
      {$IF Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clSilver;

      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 36;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 22;

      TextOut (l, m,      '��ϲ���Ѿ�������һ���ȼ�.');
      TextOut (l, m+14,   'ѡ��������ߵ�����');
      TextOut (l, m+14*2, '������ѡ����ֻ������һ��');
      TextOut (l, m+14*3, '����ܺ�С�ĵ�ѡ��.');

      Font.Color := clWhite;
      //������ �ɷ�ġ
      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 100; //66;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;

      {
      adc := (g_BonusAbil.DC + g_BonusAbilChg.DC) div g_BonusTick.DC;
      amc := (g_BonusAbil.MC + g_BonusAbilChg.MC) div g_BonusTick.MC;
      asc := (g_BonusAbil.SC + g_BonusAbilChg.SC) div g_BonusTick.SC;
      aac := (g_BonusAbil.AC + g_BonusAbilChg.AC) div g_BonusTick.AC;
      amac := (g_BonusAbil.MAC + g_BonusAbilChg.MAC) div g_BonusTick.MAC;
      }
      adc := (g_BonusAbilChg.DC) div g_BonusTick.DC;
      amc := (g_BonusAbilChg.MC) div g_BonusTick.MC;
      asc := (g_BonusAbilChg.SC) div g_BonusTick.SC;
      aac := (g_BonusAbilChg.AC) div g_BonusTick.AC;
      amac := (g_BonusAbilChg.MAC) div g_BonusTick.MAC;

      AdjustAb (g_NakedAbil.DC, adc, ldc, hdc);
      AdjustAb (g_NakedAbil.MC, amc, lmc, hmc);
      AdjustAb (g_NakedAbil.SC, asc, lsc, hsc);
      AdjustAb (g_NakedAbil.AC, aac, lac, hac);
      AdjustAb (g_NakedAbil.MAC, amac, lmac, hmac);
      //lac  := 0;  hac := aac;
      //lmac := 0;  hmac := amac;

      TextOut (l+0, m+0, IntToStr(LoWord(g_MySelf.m_Abil.DC)+ldc) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.DC) + hdc));
      TextOut (l+0, m+20, IntToStr(LoWord(g_MySelf.m_Abil.MC)+lmc) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.MC) + hmc));
      TextOut (l+0, m+40, IntToStr(LoWord(g_MySelf.m_Abil.SC)+lsc) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.SC) + hsc));
      TextOut (l+0, m+60, IntToStr(LoWord(g_MySelf.m_Abil.AC)+lac) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.AC) + hac));
      TextOut (l+0, m+80, IntToStr(LoWord(g_MySelf.m_Abil.MAC)+lmac) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.MAC) + hmac));
      TextOut (l+0, m+100, IntToStr(g_MySelf.m_Abil.MaxHP + (g_BonusAbil.HP + g_BonusAbilChg.HP) div g_BonusTick.HP));
      TextOut (l+0, m+120, IntToStr(g_MySelf.m_Abil.MaxMP + (g_BonusAbil.MP + g_BonusAbilChg.MP) div g_BonusTick.MP));
      TextOut (l+0, m+140, IntToStr(g_nMyHitPoint + (g_BonusAbil.Hit + g_BonusAbilChg.Hit) div g_BonusTick.Hit));
      TextOut (l+0, m+160, IntToStr(g_nMySpeedPoint + (g_BonusAbil.Speed + g_BonusAbilChg.Speed) div g_BonusTick.Speed));

      Font.Color := clYellow;
      TextOut (l+0, m+180, IntToStr(g_nBonusPoint));

      Font.Color := clWhite;
      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 155; //66;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;

      if g_BonusAbilChg.DC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+0, IntToStr(g_BonusAbilChg.DC + g_BonusAbil.DC) + '/' + IntToStr(g_BonusTick.DC));

      if g_BonusAbilChg.MC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+20, IntToStr(g_BonusAbilChg.MC + g_BonusAbil.MC) + '/' + IntToStr(g_BonusTick.MC));

      if g_BonusAbilChg.SC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+40, IntToStr(g_BonusAbilChg.SC + g_BonusAbil.SC) + '/' + IntToStr(g_BonusTick.SC));

      if g_BonusAbilChg.AC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+60, IntToStr(g_BonusAbilChg.AC + g_BonusAbil.AC) + '/' + IntToStr(g_BonusTick.AC));

      if g_BonusAbilChg.MAC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+80, IntToStr(g_BonusAbilChg.MAC + g_BonusAbil.MAC) + '/' + IntToStr(g_BonusTick.MAC));

      if g_BonusAbilChg.HP > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+100, IntToStr(g_BonusAbilChg.HP + g_BonusAbil.HP) + '/' + IntToStr(g_BonusTick.HP));

      if g_BonusAbilChg.MP > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+120, IntToStr(g_BonusAbilChg.MP + g_BonusAbil.MP) + '/' + IntToStr(g_BonusTick.MP));

      if g_BonusAbilChg.Hit > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+140, IntToStr(g_BonusAbilChg.Hit + g_BonusAbil.Hit) + '/' + IntToStr(g_BonusTick.Hit));

      if g_BonusAbilChg.Speed > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+160, IntToStr(g_BonusAbilChg.Speed + g_BonusAbil.Speed) + '/' + IntToStr(g_BonusTick.Speed));

      Release;
      {$ELSE}
      //SetBkMode (Handle, TRANSPARENT);
      Font.Color := clSilver;
      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 36;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 22;
      ClFunc.TextOut (dsurface, l, m,   Font.Color,   '��ϲ���Ѿ�������һ���ȼ�.');
      ClFunc.TextOut (dsurface, l, m+14, Font.Color,   'ѡ��������ߵ�����');
      ClFunc.TextOut (dsurface, l, m+14*2, Font.Color, '������ѡ����ֻ������һ��');
      ClFunc.TextOut (dsurface, l, m+14*3, Font.Color, '����ܺ�С�ĵ�ѡ��.');
      Font.Color := clWhite;
      //������ �ɷ�ġ
      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 100; //66;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;
      adc := (g_BonusAbilChg.DC) div g_BonusTick.DC;
      amc := (g_BonusAbilChg.MC) div g_BonusTick.MC;
      asc := (g_BonusAbilChg.SC) div g_BonusTick.SC;
      aac := (g_BonusAbilChg.AC) div g_BonusTick.AC;
      amac := (g_BonusAbilChg.MAC) div g_BonusTick.MAC;
      AdjustAb (g_NakedAbil.DC, adc, ldc, hdc);
      AdjustAb (g_NakedAbil.MC, amc, lmc, hmc);
      AdjustAb (g_NakedAbil.SC, asc, lsc, hsc);
      AdjustAb (g_NakedAbil.AC, aac, lac, hac);
      AdjustAb (g_NakedAbil.MAC, amac, lmac, hmac);
      ClFunc.TextOut (dsurface, l, m+0, Font.Color, IntToStr(LoWord(g_MySelf.m_Abil.DC)+ldc) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.DC) + hdc));
      ClFunc.TextOut (dsurface, l, m+20, Font.Color, IntToStr(LoWord(g_MySelf.m_Abil.MC)+lmc) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.MC) + hmc));
      ClFunc.TextOut (dsurface, l, m+40, Font.Color, IntToStr(LoWord(g_MySelf.m_Abil.SC)+lsc) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.SC) + hsc));
      ClFunc.TextOut (dsurface, l, m+60, Font.Color, IntToStr(LoWord(g_MySelf.m_Abil.AC)+lac) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.AC) + hac));
      ClFunc.TextOut (dsurface, l, m+80, Font.Color, IntToStr(LoWord(g_MySelf.m_Abil.MAC)+lmac) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.MAC) + hmac));
      ClFunc.TextOut (dsurface, l, m+100, Font.Color, IntToStr(g_MySelf.m_Abil.MaxHP + (g_BonusAbil.HP + g_BonusAbilChg.HP) div g_BonusTick.HP));
      ClFunc.TextOut (dsurface, l, m+120, Font.Color, IntToStr(g_MySelf.m_Abil.MaxMP + (g_BonusAbil.MP + g_BonusAbilChg.MP) div g_BonusTick.MP));
      ClFunc.TextOut (dsurface, l, m+140, Font.Color, IntToStr(g_nMyHitPoint + (g_BonusAbil.Hit + g_BonusAbilChg.Hit) div g_BonusTick.Hit));
      ClFunc.TextOut (dsurface, l, m+160, Font.Color, IntToStr(g_nMySpeedPoint + (g_BonusAbil.Speed + g_BonusAbilChg.Speed) div g_BonusTick.Speed));
      Font.Color := clYellow;
      ClFunc.TextOut (dsurface, l, m+180, Font.Color, IntToStr(g_nBonusPoint));
      Font.Color := clWhite;
      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 155; //66;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;
      if g_BonusAbilChg.DC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      ClFunc.TextOut (dsurface, l, m, Font.Color, IntToStr(g_BonusAbilChg.DC + g_BonusAbil.DC) + '/' + IntToStr(g_BonusTick.DC));
      if g_BonusAbilChg.MC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      ClFunc.TextOut (dsurface, l, m+20, Font.Color, IntToStr(g_BonusAbilChg.MC + g_BonusAbil.MC) + '/' + IntToStr(g_BonusTick.MC));
      if g_BonusAbilChg.SC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      ClFunc.TextOut (dsurface, l, m+40, Font.Color, IntToStr(g_BonusAbilChg.SC + g_BonusAbil.SC) + '/' + IntToStr(g_BonusTick.SC));
      if g_BonusAbilChg.AC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      ClFunc.TextOut (dsurface, l, m+60, Font.Color, IntToStr(g_BonusAbilChg.AC + g_BonusAbil.AC) + '/' + IntToStr(g_BonusTick.AC));
      if g_BonusAbilChg.MAC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      ClFunc.TextOut (dsurface, l, m+80, Font.Color, IntToStr(g_BonusAbilChg.MAC + g_BonusAbil.MAC) + '/' + IntToStr(g_BonusTick.MAC));
      if g_BonusAbilChg.HP > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      ClFunc.TextOut (dsurface, l, m+100, Font.Color, IntToStr(g_BonusAbilChg.HP + g_BonusAbil.HP) + '/' + IntToStr(g_BonusTick.HP));
      if g_BonusAbilChg.MP > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      ClFunc.TextOut (dsurface, l, m+120, Font.Color, IntToStr(g_BonusAbilChg.MP + g_BonusAbil.MP) + '/' + IntToStr(g_BonusTick.MP));
      if g_BonusAbilChg.Hit > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      ClFunc.TextOut (dsurface, l, m+140, Font.Color, IntToStr(g_BonusAbilChg.Hit + g_BonusAbil.Hit) + '/' + IntToStr(g_BonusTick.Hit));
      if g_BonusAbilChg.Speed > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      ClFunc.TextOut (dsurface, l, m+160, Font.Color, IntToStr(g_BonusAbilChg.Speed + g_BonusAbil.Speed) + '/' + IntToStr(g_BonusTick.Speed));
      Release;
      {$IFEND}
   end;
end;

procedure TFrmDlg.DPlusDCClick(Sender: TObject; X, Y: Integer);
var
   incp: integer;
begin
   if g_nBonusPoint > 0 then begin
      if IsKeyPressed (VK_CONTROL) and (g_nBonusPoint > 10) then incp := 10
      else incp := 1;
      Dec(g_nBonusPoint, incp);
      if Sender = DPlusDC then Inc (g_BonusAbilChg.DC, incp);
      if Sender = DPlusMC then Inc (g_BonusAbilChg.MC, incp);
      if Sender = DPlusSC then Inc (g_BonusAbilChg.SC, incp);
      if Sender = DPlusAC then Inc (g_BonusAbilChg.AC, incp);
      if Sender = DPlusMAC then Inc (g_BonusAbilChg.MAC, incp);
      if Sender = DPlusHP then Inc (g_BonusAbilChg.HP, incp);
      if Sender = DPlusMP then Inc (g_BonusAbilChg.MP, incp);
      if Sender = DPlusHit then Inc (g_BonusAbilChg.Hit, incp);
      if Sender = DPlusSpeed then Inc (g_BonusAbilChg.Speed, incp);
   end;
end;

procedure TFrmDlg.DMinusDCClick(Sender: TObject; X, Y: Integer);
var
   decp: integer;
begin
   if IsKeyPressed (VK_CONTROL) and (g_nBonusPoint-10 > 0) then decp := 10
   else decp := 1;
   if Sender = DMinusDC then
      if g_BonusAbilChg.DC >= decp then begin
         Dec(g_BonusAbilChg.DC, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusMC then
      if g_BonusAbilChg.MC >= decp then begin
         Dec(g_BonusAbilChg.MC, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusSC then
      if g_BonusAbilChg.SC >= decp then begin
         Dec(g_BonusAbilChg.SC, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusAC then
      if g_BonusAbilChg.AC >= decp then begin
         Dec(g_BonusAbilChg.AC, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusMAC then
      if g_BonusAbilChg.MAC >= decp then begin
         Dec(g_BonusAbilChg.MAC, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusHP then
      if g_BonusAbilChg.HP >= decp then begin
         Dec(g_BonusAbilChg.HP, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusMP then
      if g_BonusAbilChg.MP >= decp then begin
         Dec(g_BonusAbilChg.MP, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusHit then
      if g_BonusAbilChg.Hit >= decp then begin
         Dec(g_BonusAbilChg.Hit, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusSpeed then
      if g_BonusAbilChg.Speed >= decp then begin
         Dec(g_BonusAbilChg.Speed, decp);
         Inc (g_nBonusPoint, decp);
      end;
end;

procedure TFrmDlg.DAdjustAbilOkClick(Sender: TObject; X, Y: Integer);
begin
   FrmMain.SendAdjustBonus(g_nBonusPoint, g_BonusAbilChg);
   DAdjustAbility.Visible := FALSE;
end;

procedure TFrmDlg.DAdjustAbilityMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   i, lx, ly: integer;
   flag: Boolean;
begin
   with DAdjustAbility do begin
      lx := LocalX (X - Left);
      ly := LocalY (Y - Top);
      flag := FALSE;
      if (lx >= 50) and (lx < 150) then
         for i:=0 to 8 do begin  //DC,MC,SC..�� ��Ʈ�� ������ �Ѵ�.
            if (ly >= 98 + i*20) and (ly < 98 + (i+1)*20) then begin
               DScreen.ShowHint (SurfaceX(Left) + lx + 10,
                                 SurfaceY(Top) + ly + 5,
                                 AdjustAbilHints[i],
                                 clWhite,
                                 FALSE);
               flag := TRUE;
               break;
            end;
         end;
      if not flag then
         DScreen.ClearHint;
   end;
end;

procedure TFrmDlg.DBotMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sMsg:String;
  Int: Integer;
begin
  if g_MySelf = nil then Exit;
 // g_boHintDragonPoint := False;  20080619
  Butt:=TDButton(Sender);
  if Sender = DBotMiniMap then sMsg:= 'С��ͼ\ȫ����ͼ(TAB)';
  if Sender = DBotTrade then sMsg:= '��Ʒ����';
  if Sender = DBotGuild then sMsg:= '�л���Ϣ';
  if Sender = DBotGroup then sMsg:= '��ӿ���/�Ҽ�����';
  if Sender = DBotPlusAbil then sMsg:= '���Ե�';
  if Sender = DBotFriend then sMsg:= '��ϵϵͳ';
  if Sender = DBotLogout then sMsg:= 'С��(Alt+X)';
  if Sender = DBotExit then sMsg:= '�˳�(Alt+Q)';
  if Sender = DBotMemo then sMsg:= '����(Ctrl+B)';
  if Sender = DMyState then sMsg:= '״̬��Ϣ(F10)';
  if Sender = DMyBag then sMsg:= '������Ʒ(F9)';
  if Sender = DMyMagic then sMsg:= '������Ϣ(F11)';
  if Sender = DOption then sMsg:= '��Ч����';
  if Sender = RefusePublicChat then sMsg:= '�ܾ����й�����Ϣ';
  if Sender = RefuseCRY then sMsg:= '�ܾ����к�����Ϣ';
  if Sender = RefuseWHISPER then sMsg:= '�ܾ�����˽����Ϣ';
  if Sender = Refuseguild then sMsg:= '�ܾ��л�������Ϣ';
  if Sender = AutoCRY then sMsg:= '�Զ���������';
  if Sender = DInternet then sMsg:= '�ȵ�';
  if Sender = DDrunkScale then sMsg := '��ƶ�: %d';
  if Sender = DLiquorProgress then sMsg := '������������%d';
  if Sender = DHeroLiquorProgress then sMsg := '������������%d';


  if Sender = DLiquorProgress then begin
    Int := _MAX(0, 100 * g_MySelf.m_Abil.Alcohol div g_MySelf.m_Abil.MaxAlcohol);
    with Butt as TDButton do
      DScreen.ShowHint(Butt.SurfaceX(Butt.Left), Butt.SurfaceY(Butt.Top + Butt.Height), Format(sMsg ,[Int]) + '%' , clWhite, FALSE);
    Exit;
  end;

  if Sender = DDrunkScale then begin
    Int := _MAX(0, 100 * g_MySelf.m_Abil.WineDrinkValue div g_MySelf.m_Abil.MaxAlcohol);
    with Butt as TDButton do
      DScreen.ShowHint(Butt.SurfaceX(Butt.Left)-Canvas.TextWidth(sMsg) + 36, Butt.SurfaceY(Butt.Top + Butt.Height), Format(sMsg,[Int]) + '%', clWhite, FALSE);
    Exit;
  end;

  if Sender = DHeroLiquorProgress then begin
    Int := _MAX(0, 100 * g_HeroSelf.m_Abil.Alcohol div g_HeroSelf.m_Abil.MaxAlcohol);
    with Butt as TDButton do
      DScreen.ShowHint(Butt.SurfaceX(Butt.Left), Butt.SurfaceY(Butt.Top + Butt.Height), Format(sMsg ,[Int]) + '%' , clWhite, FALSE);
    Exit;
  end;

  if (Sender = RefusePublicChat) or (Sender = RefuseCRY) or
     (Sender = RefuseWHISPER) or (Sender = Refuseguild) or (Sender = AutoCRY) then begin
    with Butt as TDButton do
      DScreen.ShowHint(Butt.SurfaceX(Butt.Left)-Canvas.TextWidth(sMsg)-8, Butt.SurfaceY(Butt.Top), sMsg, clWhite, FALSE);
    Exit;
  end;

  if Sender = CallHero then sMsg:= '�ٻ�Ӣ��';
  if Sender = HeroState then sMsg:= 'Ӣ��״̬��Ϣ';
  if Sender = HeroPackage then sMsg:= 'Ӣ�۰���';
  if Sender = RelationSystem then sMsg:= '��ϵϵͳ';
  if Sender = Challenge then sMsg:= '��ս';
  if Sender = CharacterSranking then sMsg:= '��������';

  if Sender = DBottom then begin
    g_nUserSelectName := 0;
    if ((X >= SCREENWIDTH - 135) and (X <= SCREENWIDTH - 96)) and ((Y >= SCREENHEIGHT - 108) and (Y <= SCREENHEIGHT - 92)) then begin
      sMsg := '��ǰ�ȼ�';
      nHintX := SCREENWIDTH - 135;
      nHintY := SCREENHEIGHT - 92+20;
      DScreen.ShowHint(nHintX,nHintY,sMsg, clWhite, TRUE);
      exit;
    end
    else if ((X >= SCREENWIDTH - 135) and (X <= SCREENWIDTH - 55)) and ((Y >= SCREENHEIGHT - 77) and (Y <= SCREENHEIGHT - 63)) then begin
      sMsg := '��ǰ����';
      nHintX := SCREENWIDTH - 135;
      nHintY := SCREENHEIGHT - 63+20;
      DScreen.ShowHint(nHintX,nHintY,sMsg+FloatToStrFixFmt(100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) +'%', clWhite, TRUE);
      exit;
    end
    else if ((X >= SCREENWIDTH - 135) and (X <= SCREENWIDTH - 55)) and ((Y >= SCREENHEIGHT - 44) and (Y <= SCREENHEIGHT - 28)) then begin
      sMsg := format('��������%d/%d',[g_MySelf.m_Abil.Weight,g_MySelf.m_Abil.MaxWeight]);
      nHintX := SCREENWIDTH - 135;
      nHintY := SCREENHEIGHT - 28+20;
      DScreen.ShowHint(nHintX,nHintY,sMsg, clWhite, TRUE);
      exit;
    end;
  end;
  if pos('\',sMsg) > 0 then
    nLocalY := 12
  else nLocalY := 0;

  with Butt as TDButton do
    DScreen.ShowHint(Butt.SurfaceX(Butt.Left), Butt.SurfaceY(Butt.Top - 20 -nLocalY ), sMsg, clWhite, FALSE);
end;


procedure TFrmDlg.DFrdFriendDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if WLib <> nil then begin //20080701
        if not TDButton(Sender).Downed then begin
           d := WLib.Images[FaceIndex];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end else begin
           d := WLib.Images[FaceIndex + 1];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
   end;
end;

procedure TFrmDlg.DBotFriendClick(Sender: TObject; X, Y: Integer);
begin
  OpenFriendDlg();
end;
procedure TFrmDlg.OpenFriendDlg();
begin
  DFriendDlg.Visible:=not DFriendDlg.Visible;
end;

procedure TFrmDlg.DFrdCloseClick(Sender: TObject; X, Y: Integer);
begin
  OpenFriendDlg();
end;

procedure TFrmDlg.DChgGamePwdCloseClick(Sender: TObject; X, Y: Integer);
begin
  DChgGamePwd.Visible:=False;
end;

procedure TFrmDlg.DChgGamePwdDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d:TDirectDrawSurface;
begin
  with Sender as TDWindow do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
    {$if Version = 1}
    SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
    {$IFEND}
    BoldTextOut (dsurface, SurfaceX(Left+15), SurfaceY(Top+13), clWhite, clBlack, 'GamePoint');

    dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style + [fsUnderline];
    BoldTextOut (dsurface, SurfaceX(Left+12), SurfaceY(Top+190), clYellow, clBlack, 'GameGold');
    dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline];
    dsurface.Canvas.Release;
  end;
end;
//�ٻ�Ӣ��
procedure TFrmDlg.CallHeroClick(Sender: TObject; X, Y: Integer);
var
 msg: TDefaultMessage;
begin
  if FrmDlg.CallHero.ShowHint then
      msg := MakeDefaultMsg (CM_RECALLHERO, 0, 0, 0, 0, frmMain.Certification) //�ٻ�Ӣ��
  else
      msg := MakeDefaultMsg (CM_HEROLOGOUT, 0, 0, 0, 0, frmMain.Certification); //Ӣ���˳�
   FrmMain.SendSocket (EncodeMessage (msg));
end;
//�ܾ��л�������Ϣ
procedure TFrmDlg.RefuseguildClick(Sender: TObject; X, Y: Integer);
begin
  if g_Refuseguild then begin
      Refuseguild.SetImgIndex(g_WMain3Images,287);
      Refuseguild.Left:=175;
      Refuseguild.Top:=180;
      g_Refuseguild:=false;
      FrmMain.SendSay ('@�ܾ��л�����');
  end else begin
      Refuseguild.SetImgIndex(g_WMain3Images,286);
      Refuseguild.Left:=175;
      Refuseguild.Top:=180;
      g_Refuseguild:=true;
      FrmMain.SendSay ('@�ܾ��л�����');
  end;
end;
//�ܾ�˽��
procedure TFrmDlg.RefuseWHISPERClick(Sender: TObject; X, Y: Integer);
begin
if g_RefuseWHISPER then begin
  RefuseWHISPER.SetImgIndex(g_WMain3Images,285);
  RefuseWHISPER.Left:=175;
  RefuseWHISPER.Top:=160;
  g_RefuseWHISPER:=false;
  FrmMain.SendSay ('@�ܾ�˽��'); end
  else begin
  RefuseWHISPER.SetImgIndex(g_WMain3Images,284);
  RefuseWHISPER.Left:=175;
  RefuseWHISPER.Top:=160;
  g_RefuseWHISPER:=true;
  FrmMain.SendSay ('@�ܾ�˽��');
end;
end;
procedure TFrmDlg.HeroStateClick(Sender: TObject; X, Y: Integer);
begin
if g_HeroSelf = nil then exit;
   DStateHero.Visible := not DStateHero.Visible;
   //PageChanged;
end;
//�ر�Ӣ����Ϣ��
procedure TFrmDlg.DCloseHeroStateClick(Sender: TObject; X, Y: Integer); //����$008 2007.10.21
begin
  DStateHero.Visible:=FALSE;
end;

//Ӣ��װ��������
procedure TFrmDlg.DStateHeroDirectPaint(Sender: TObject;     //����$007 2007.10.21
  dsurface: TDirectDrawSurface);
var
   i, l, m, pgidx, magline, bbx, bby, mmx, idx, ax, ay, trainlv: integer;
   pm: PTClientMagic;
   d: TDirectDrawSurface;
   hcolor, old, MagColor: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
   rc: TRect;
begin
   if g_HeroSelf = nil then exit;
   DHeroLiquorProgress.Visible := False;
   with DStateHero do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
      case HeroStateTab of
        0: begin
          case HeroStatePage of
             0: begin //�Լ�װ��  2007.10.16 ����
                pgidx := 380{376};              //��4��  2007.10.16 ����
                if g_HeroSelf <> nil then
                   if g_HeroSelf.m_btSex = 1 then
                   pgidx := 381{377};  //Ů4��  2007.10.16 ����
                bbx := Left + 38;
                bby := Top + 52;
                d := g_WMain3Images.Images[pgidx];
                if d <> nil then
                   dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);
                bbx := bbx - 7;
                bby := bby + 44;
               //�Լ����﷢��  2007.10.16 ����
                idx := 1799; //�Ӹ� ��Ÿ��
                if g_HeroSelf.m_btSex = 1 then idx := 2399;//480 + g_HeroSelf.m_btHair div 2;
                if g_HeroSelf.m_btSex = 0 then begin  //��
                  if g_HeroSelf.m_btHair <> 0 then
                    if idx > 0 then begin
                       d := g_WHairImgImages.GetCachedImage (idx, ax, ay);
                       if d <> nil then
                          dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                    end;
                end else if g_HeroSelf.m_btHair <> 1 then begin
                    if idx > 0 then begin
                       d := g_WHairImgImages.GetCachedImage (idx, ax, ay);
                       if d <> nil then
                          dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                    end;
                end else begin
                       d := g_WHairImgImages.GetCachedImage (1199, ax, ay);
                       if d <> nil then
                        dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                end;

                {if g_HeroSelf.m_btHair <> 0 then begn
                  if g_HeroSelf.m_btSex = 1 begin
                  if idx > 0 then begin
                     d := g_WHairImgImages.GetCachedImage (idx, ax, ay);
                     if d <> nil then
                        dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                  end;
                end; }
                if g_HeroItems[U_DRESS].S.Name <> '' then begin
                   idx := g_HeroItems[U_DRESS].S.Looks; //�� if Myself.m_btSex = 1 then idx := 80; //���ڿ�
                   if idx >= 0 then begin
                      d := FrmMain.GetWStateImg(idx,ax,ay);
                      if d <> nil then
                         dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                   end;
                end;
                if g_HeroItems[U_WEAPON].S.Name <> '' then begin
                   idx := g_HeroItems[U_WEAPON].S.Looks;
                   if idx >= 0 then begin
                      d := FrmMain.GetWStateImg(idx,ax,ay);
                      if d <> nil then
                         dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                   end;
                end;

                {if g_HeroItems[U_HELMET].S.Name <> '' then begin
                   idx := g_HeroItems[U_HELMET].S.Looks;
                   if idx >= 0 then begin
                      d := FrmMain.GetWStateImg(idx,ax,ay);
                      if d <> nil then
                         dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                   end;
                end;}
                //���� 20080417
                if g_HeroItems[U_ZHULI].S.Name <> '' then begin
                   idx := g_HeroItems[U_ZHULI].S.Looks;
                   if idx >= 0 then begin
                      d := FrmMain.GetWStateImg(idx,ax,ay);
                      if d <> nil then
                         dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                   end;
                end else
                  if g_HeroItems[U_HELMET].S.Name <> '' then begin
                     idx := g_HeroItems[U_HELMET].S.Looks;
                     if idx >= 0 then begin
                        d := FrmMain.GetWStateImg(idx,ax,ay);
                        if d <> nil then
                           dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                     end;
                  end;

                //�̸�
                with dsurface.Canvas do begin
                   {$IF Version = 1}
                   SetBkMode (Handle, TRANSPARENT);
                   //Font.Color := g_HeroSelf.m_nNameColor;
                   Font.Color := clWhite;
                   TextOut (SurfaceX(Left + 122 - TextWidth(g_HeroSelf.m_sUserName) div 2),
                            SurfaceY(Top + 52), g_HeroSelf.m_sUserName);
                   {$ELSE}
                   ClFunc.TextOut (dsurface, SurfaceX(Left + 122 - frmMain.Canvas.TextWidth(g_HeroSelf.m_sUserName) div 2),
                            SurfaceY(Top + 52), clWhite, g_HeroSelf.m_sUserName);
                   {$IFEND}
                   Release;
                end;
             end;
             1: begin //�ɷ�ġ
                    bbx := Left + 38;
                    bby := Top + 52;
                    {d := g_WMain3Images.Images[383];
                    if d <> nil then
                       dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);   }
                     d:=FrmMain.UiImages(30);//FrmMain.UiDXImageList.Items.Find('StateWindowHero').PatternSurfaces[0];
                      if d<>nil then
                        dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);
                    l := Left + 112; //66;
                    m := Top + 99;
                with dsurface.Canvas do begin
                   {$if Version = 1}
                   SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
                   {$IFEND}
                   BoldTextOut (dsurface, SurfaceX(l+0), SurfaceY(m+0), clWhite, clBlack, IntToStr(LoWord(g_HeroSelf.m_Abil.AC)) + '-' + IntToStr(HiWord(g_HeroSelf.m_Abil.AC)));
                   BoldTextOut (dsurface, SurfaceX(l+0), SurfaceY(m+20), clWhite, clBlack, IntToStr(LoWord(g_HeroSelf.m_Abil.MAC)) + '-' + IntToStr(HiWord(g_HeroSelf.m_Abil.MAC)));
                   BoldTextOut (dsurface, SurfaceX(l+0), SurfaceY(m+40), clWhite, clBlack, IntToStr(LoWord(g_HeroSelf.m_Abil.DC)) + '-' + IntToStr(HiWord(g_HeroSelf.m_Abil.DC)));
                   BoldTextOut (dsurface, SurfaceX(l+0), SurfaceY(m+60), clWhite, clBlack, IntToStr(LoWord(g_HeroSelf.m_Abil.MC)) + '-' + IntToStr(HiWord(g_HeroSelf.m_Abil.MC)));
                   BoldTextOut (dsurface, SurfaceX(l+0), SurfaceY(m+80), clWhite, clBlack, IntToStr(LoWord(g_HeroSelf.m_Abil.SC)) + '-' + IntToStr(HiWord(g_HeroSelf.m_Abil.SC)));
                   BoldTextOut (dsurface, SurfaceX(l+0), SurfaceY(m+100), clWhite, clBlack, IntToStr(g_HeroSelf.m_Abil.HP) + '/' + IntToStr(g_HeroSelf.m_Abil.MaxHP));
                   BoldTextOut (dsurface, SurfaceX(l+0), SurfaceY(m+120), clWhite, clBlack, IntToStr(g_HeroSelf.m_Abil.MP) + '/' + IntToStr(g_HeroSelf.m_Abil.MaxMP));
                   BoldTextOut (dsurface, SurfaceX(l+0), SurfaceY(m+140), clWhite, clBlack, IntToStr(g_HeroSelf.m_Abil.MedicineValue) + '/' + IntToStr(g_HeroSelf.m_Abil.MaxMedicineValue));//20080624
                   BoldTextOut (dsurface, SurfaceX(l+0), SurfaceY(m+160), clWhite, clBlack, IntToStr(g_HeroSelf.m_Abil.MaxAlcohol));
                   Release;
                end;
                DHeroLiquorProgress.Visible := True;
             end;
             2: begin //����������ֵ
                bbx := Left + 38;
                bby := Top + 52;
                //d := g_WMain3Images.Images[32];
                {d := g_WMain3Images.Images[382];
                if d <> nil then
                   dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);    }

                bbx := bbx + 20;
                bby := bby + 10;
                with dsurface.Canvas do begin
                   {$if Version = 1}
                   SetBkMode (Handle, TRANSPARENT);
                   {$IFEND}
                   mmx := bbx + 85;
                   //Font.Color := clSilver;
                   BoldTextOut (dsurface, bbx, bby, clSilver, clBlack, '��ǰ����');
                   BoldTextOut (dsurface, mmx, bby, clSilver, clBlack, IntToStr(g_HeroSelf.m_Abil.Exp));
                   BoldTextOut (dsurface, bbx, bby+14*1, clSilver, clBlack, '��������');
                   BoldTextOut (dsurface, mmx, bby+14*1, clSilver, clBlack, IntToStr(g_HeroSelf.m_Abil.MaxExp));
                   BoldTextOut (dsurface, bbx, bby+14*2, clSilver, clBlack, '��������');
                   if g_HeroSelf.m_Abil.Weight > g_HeroSelf.m_Abil.MaxWeight then
                      BoldTextOut (dsurface, mmx, bby+14*2, clRed, clBlack, IntToStr(g_HeroSelf.m_Abil.Weight) + '/' + IntToStr(g_HeroSelf.m_Abil.MaxWeight))
                   else
                   BoldTextOut (dsurface, mmx, bby+14*2, clSilver, clBlack, IntToStr(g_HeroSelf.m_Abil.Weight) + '/' + IntToStr(g_HeroSelf.m_Abil.MaxWeight));
                   BoldTextOut (dsurface, bbx, bby+14*3, clSilver, clBlack, '��������');
                   if g_HeroSelf.m_Abil.WearWeight > g_HeroSelf.m_Abil.MaxWearWeight then
                      BoldTextOut (dsurface, mmx, bby+14*3, clRed, clBlack, IntToStr(g_HeroSelf.m_Abil.WearWeight) + '/' + IntToStr(g_HeroSelf.m_Abil.MaxWearWeight))
                   else
                   BoldTextOut (dsurface, mmx, bby+14*3, clSilver, clBlack, IntToStr(g_HeroSelf.m_Abil.WearWeight) + '/' + IntToStr(g_HeroSelf.m_Abil.MaxWearWeight));
                   BoldTextOut (dsurface, bbx, bby+14*4, clSilver, clBlack, '����');
                   if g_HeroSelf.m_Abil.HandWeight > g_HeroSelf.m_Abil.MaxHandWeight then
                      BoldTextOut (dsurface, mmx, bby+14*4, clRed, clBlack, IntToStr(g_HeroSelf.m_Abil.HandWeight) + '/' + IntToStr(g_HeroSelf.m_Abil.MaxHandWeight))
                   else
                   BoldTextOut (dsurface, mmx, bby+14*4, clSilver, clBlack, IntToStr(g_HeroSelf.m_Abil.HandWeight) + '/' + IntToStr(g_HeroSelf.m_Abil.MaxHandWeight));
                   BoldTextOut (dsurface, bbx, bby+14*5, clSilver, clBlack, '��ȷ��');
                   BoldTextOut (dsurface, mmx, bby+14*5, clSilver, clBlack, IntToStr(g_nHeroHitPoint));
                   BoldTextOut (dsurface, bbx, bby+14*6, clSilver, clBlack, '���ݶ�');
                   BoldTextOut (dsurface, mmx, bby+14*6, clSilver, clBlack, IntToStr(g_nHeroSpeedPoint));
                   BoldTextOut (dsurface, bbx, bby+14*7, clSilver, clBlack, 'ħ������');
                   BoldTextOut (dsurface, mmx, bby+14*7, clSilver, clBlack, '+' + IntToStr(g_nHeroAntiMagic * 10) + '%');
                   BoldTextOut (dsurface, bbx, bby+14*8, clSilver, clBlack, '�ж�����');
                   BoldTextOut (dsurface, mmx, bby+14*8, clSilver, clBlack, '+' + IntToStr(g_nHeroAntiPoison * 10) + '%');
                   BoldTextOut (dsurface, bbx, bby+14*9, clSilver, clBlack, '�ж��ָ�');
                   BoldTextOut (dsurface, mmx, bby+14*9, clSilver, clBlack, '+' + IntToStr(g_nHeroPoisonRecover * 10) + '%');
                   BoldTextOut (dsurface, bbx, bby+14*10, clSilver, clBlack, '�����ָ�');
                   BoldTextOut (dsurface, mmx, bby+14*10, clSilver, clBlack, '+' + IntToStr(g_nHeroHealthRecover * 10) + '%');
                   BoldTextOut (dsurface, bbx, bby+14*11, clSilver, clBlack, 'ħ���ָ�');
                   BoldTextOut (dsurface, mmx, bby+14*11, clSilver, clBlack, '+' + IntToStr(g_nHeroSpellRecover * 10) + '%');
                   Release;
                end;
             end;
             3: begin //ħ������
                bbx := Left + 38;
                bby := Top + 52;
                //d := g_WMain3Images.Images[382];
                d:=FrmMain.UiDXImageList.Items.Find('HeroAbility').PatternSurfaces[0];

                if d <> nil then
                   dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);

                //Ű ǥ��, lv, exp
                HeroMagTop := HeroMagicPage * 6;
                magline := _MIN(HeroMagicPage*6+6, g_HeroMagicList.Count);
                for i:=HeroMagTop to magline-1 do begin
                   pm := PTClientMagic (g_HeroMagicList[i]);
                   m := i - HeroMagTop;
                   d := g_WMainImages.Images[112]; //lv
                   if d <> nil then begin
                      if pm.Def.wMagicId = 68 then   //��������
                      dsurface.Draw (bbx + 110, bby+15+m*37-7, d.ClientRect, d, TRUE)
                      else
                      dsurface.Draw (bbx + 48, bby+8+15+m*37, d.ClientRect, d, TRUE);
                   end;
                   d := g_WMainImages.Images[111]; //exp
                   if d <> nil then begin
                     if pm.Def.wMagicId <> 68 then
                      dsurface.Draw (bbx + 48 + 26, bby+8+15+m*37, d.ClientRect, d, TRUE);
                   end;
                   if (pm.Def.wMagicId = 68) and (pm.Level < 100) then begin
                     d := g_WMain2Images.Images[577];
                     if d <> nil then 
                      dsurface.Draw (bbx + 48, bby+27+m*37, d.ClientRect, d, TRUE);

                     d := g_WMain2Images.Images[578];
                       if d <> nil then begin
                         rc := d.ClientRect;
                         if g_dwHeroExp68 > 0 then begin//�������� 20080622
                           rc.Right := Round((rc.Right-rc.Left) / g_dwHeroMaxExp68 * g_dwHeroExp68);
                           dsurface.Draw (bbx + 48, bby+27+m*37, rc, d, TRUE);
                        end;
                      end;
                   end;
                end;

                with dsurface.Canvas do begin
                   {$if Version = 1}
                   SetBkMode (Handle, TRANSPARENT);
                   {$IFEND}
                   //Font.Color := clSilver;
                   for i:=HeroMagTop to magline-1 do begin
                      pm := PTClientMagic (g_HeroMagicList[i]);
                      if word(pm.Key) = 0 then MagColor := clSilver
                        else MagColor := clGray;
                      m := i - HeroMagTop;
                      if pm.Def.wMagicId <> 68 then
                      if not (pm.Level in [0..4]) then pm.Level := 0;//20080111 ���ܵȼ���ʾ
                      if word(pm.Key) = 0 then
                        BoldTextOut (dsurface, bbx + 48, bby + 8 + m*37,
                                  MagColor, clBlack, pm.Def.sMagicName)
                      else
                        BoldTextOut (dsurface, bbx + 48, bby + 8 + m*37,
                                  MagColor, clBlack, pm.Def.sMagicName+'[��]');
                      if pm.Def.wMagicId = 68 then begin
                        trainlv := pm.Level;
                        BoldTextOut (dsurface, bbx + 124, bby + 15 + m*37-7, clSilver, clBlack, IntToStr(pm.Level));
                      end else begin
                        if pm.Level in [0..4] then trainlv := pm.Level//20080111 ���ܵȼ���ʾ
                        else trainlv := 0;
                        BoldTextOut (dsurface, bbx + 48 + 16, bby + 8 + 15 + m*37, MagColor, clBlack, IntToStr(pm.Level));
                      end;
                      if pm.Def.MaxTrain[trainlv] > 0 then begin
                        if pm.Def.wMagicId <> 68 then begin
                         if trainlv < 3 then
                            BoldTextOut (dsurface, bbx + 48 + 46, bby + 8 + 15 + m*37, MagColor, clBlack, IntToStr(pm.CurTrain) + '/' + IntToStr(pm.Def.MaxTrain[trainlv]))
                         else BoldTextOut (dsurface, bbx + 48 + 46, bby + 8 + 15 + m*37, MagColor, clBlack, '-');
                        end;
                      end;
                   end;
                   Release;
                end;
             end;
          end;
        end;
        1: begin
          case HeroInternalForcePage of
            0: begin
              d := g_WMain2Images.Images[749];
              if d<>nil then begin
                rc := d.ClientRect;
                rc.Right := d.ClientRect.Right - 4;
                rc.Bottom := d.ClientRect.Bottom - 2;
                dsurface.Draw (SurfaceX(Left) + 38, SurfaceY(Top) + 52, rc, d, False);
              end;
              d:=g_WMain2Images.Images[752];
              if d<>nil then
              dsurface.Draw (SurfaceX(Left) + 124, SurfaceY(Top) + 110, d.ClientRect, d, TRUE);
              dsurface.Draw (SurfaceX(Left) + 124, SurfaceY(Top) + 142, d.ClientRect, d, TRUE);
              dsurface.Draw (SurfaceX(Left) + 124, SurfaceY(Top) + 174, d.ClientRect, d, TRUE);
              dsurface.Draw (SurfaceX(Left) + 124, SurfaceY(Top) + 206, d.ClientRect, d, TRUE);
              {$if Version = 1}
              SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
              {$IFEND}
              BoldTextOut (dsurface, SurfaceX(Left) + 48, SurfaceY(Top) + 112, clSilver, clBlack, '��ǰ�ڹ��ȼ�');
              BoldTextOut (dsurface, SurfaceX(Left) + 48, SurfaceY(Top) + 144, clSilver, clBlack, '��ǰ�ڹ�����');
              BoldTextOut (dsurface, SurfaceX(Left) + 48, SurfaceY(Top) + 176, clSilver, clBlack, '�����ڹ�����');
              BoldTextOut (dsurface, SurfaceX(Left) + 48, SurfaceY(Top) + 208, clSilver, clBlack, '�� �� ֵ');
              BoldTextOut (dsurface, SurfaceX(Left) + 130, SurfaceY(Top) + 112, clSilver, clBlack, IntToStr(g_btHeroInternalForceLevel));
              BoldTextOut (dsurface, SurfaceX(Left) + 130, SurfaceY(Top) + 144, clSilver, clBlack, IntToStr(g_dwHeroExp69));
              BoldTextOut (dsurface, SurfaceX(Left) + 130, SurfaceY(Top) + 176, clSilver, clBlack, IntToStr(g_dwHeroMaxExp69));
              BoldTextOut (dsurface, SurfaceX(Left) + 130, SurfaceY(Top) + 208, clSilver, clBlack, IntToStr(g_HeroSelf.m_Skill69NH)+'/'+IntToStr(g_HeroSelf.m_Skill69MaxNH));
              dsurface.Canvas.Release;
            end;
            1: begin
              d := g_WMain2Images.Images[751];
              if d<>nil then begin
                bbx := Left + 38;
                bby := Top + 52;
                rc := d.ClientRect;
                rc.Right := d.ClientRect.Right - 4;
                rc.Bottom := d.ClientRect.Bottom - 2;
                dsurface.Draw (SurfaceX(Left) + 38, SurfaceY(Top) + 52, rc, d, False);

                //Ű ǥ��, lv, exp
                magtop := HeroInternalForceMagicPage * 6;
                magline := _MIN(HeroInternalForceMagicPage*6+6, g_HeroInternalForceMagicList.Count);
                for i:=magtop to magline-1 do begin
                   pm := PTClientMagic (g_HeroInternalForceMagicList[i]);
                   m := i - magtop;
                   d := g_WMagIconImages.Images[pm.Def.btEffect * 2];
                   if d <> nil then
                      dsurface.Draw (bbx + 8, bby+7+m*37, d.ClientRect, d, TRUE);
                      
                   d := g_WMainImages.Images[112]; //lv
                   if d <> nil then
                      dsurface.Draw (bbx + 48, bby+8+15+m*37, d.ClientRect, d, TRUE);

                   d := g_WMainImages.Images[111]; //exp
                   if d <> nil then begin
                      if pm.Def.wMagicId <> 68 then
                      dsurface.Draw (bbx + 48 + 26, bby+8+15+m*37, d.ClientRect, d, TRUE);
                   end;
                end;
                with dsurface.Canvas do begin
                   {$if Version = 1}
                   SetBkMode (Handle, TRANSPARENT);
                   {$IFEND}
                   for i:=magtop to magline-1 do begin
                      pm := PTClientMagic (g_HeroInternalForceMagicList[i]);
                      m := i - magtop;
                      if not (pm.Level in [0..4]) then pm.Level := 0;
                      BoldTextOut (dsurface, bbx + 48, bby + 8 + m*37,
                                  clSilver, clBlack, pm.Def.sMagicName);
                      if pm.Level in [0..4] then trainlv := pm.Level
                      else trainlv := 0;
                      BoldTextOut (dsurface, bbx + 48 + 16, bby + 8 + 15 + m*37, clSilver, clBlack, IntToStr(pm.Level));
                      if pm.Def.MaxTrain[trainlv] > 0 then begin
                         if trainlv < 3 then
                            BoldTextOut (dsurface, bbx + 48 + 46, bby + 8 + 15 + m*37, clSilver, clBlack, IntToStr(pm.CurTrain) + '/' + IntToStr(pm.Def.MaxTrain[trainlv]))
                         else BoldTextOut (dsurface, bbx + 48 + 46, bby + 8 + 15 + m*37, clSilver, clBlack, '-');
                      end;
                   end;
                   Release;
                end;
              end;
            end;
          end;
        end;
      end;

      //������Ϊ��ʾ��������������Ʒ��Ϣ����ʾλ��Ϊ�����·�
      if g_HeroMouseStateItem.S.Name <> '' then begin
         g_HeroMouseItem := g_HeroMouseStateItem;
         GetMouseItemInfo (iname, d1, d2, d3, useable,2);
         if iname <> '' then begin
            if g_HeroMouseItem.Dura = 0 then hcolor := clRed
            else hcolor := clWhite;
            with dsurface.Canvas do begin
               {$if Version = 1}
               SetBkMode (Handle, TRANSPARENT);
               {$IFEND}
               old := Font.Size;
               Font.Size := 9;
               BoldTextOut (dsurface,SurfaceX(Left+37), SurfaceY(Top+310), clYellow, clBlack,iname);
               BoldTextOut (dsurface,SurfaceX(Left+37+ frmMain.Canvas.TextWidth(iname)), SurfaceY(Top+310), hcolor, clBlack,d1);
               BoldTextOut (dsurface,SurfaceX(Left+37), SurfaceY(Top+310+frmMain.Canvas.TextHeight('A')+2), hcolor, clBlack,d2);
               BoldTextOut (dsurface,SurfaceX(Left+37), SurfaceY(Top+310+(frmMain.Canvas.TextHeight('A')+2)*2), hcolor, clBlack,d3);
               Font.Size := old;
               Release;
            end;
         end;
         g_HeroMouseItem.S.Name := '';
      end;
   end;
end;

procedure TFrmDlg.DCloseHeroStateDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if WLib <> nil then begin //20080701
        if TDButton(Sender).Downed then begin
           d := WLib.Images[FaceIndex];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
   end;

end;
//�����װ����ĳ��װ�����ƶ���ʾ����
procedure TFrmDlg.DSHWeaponMouseMove(Sender: TObject; Shift: TShiftState;   //����$006 2007.10.21
  X, Y: Integer);
var
//  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  sel: integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
  hcolor: TColor;
  Butt:TDButton;
begin
   if (HeroStateTab <> 0) or (HeroStatePage <> 0) then exit;
   //DScreen.ClearHint;
   sel := -1;
   Butt:=TDButton(Sender);
   if Sender = DSHDress then sel := U_DRESS;
   if Sender = DSHWeapon then sel := U_WEAPON;
   if Sender = DSHHelmet then sel := U_HELMET;
   if Sender = DSHNecklace then sel := U_NECKLACE;
   if Sender = DSHLight then sel := U_RIGHTHAND;
   if Sender = DSHRingL then sel := U_RINGL;
   if Sender = DSHRingR then sel := U_RINGR;
   if Sender = DSHArmRingL then sel := U_ARMRINGL;
   if Sender = DSHArmRingR then sel := U_ARMRINGR;
   {
   if Sender = DSWBujuk then sel := U_RINGL;
   if Sender = DSWBelt then sel := U_RINGR;
   if Sender = DSWBoots then sel := U_ARMRINGL;
   if Sender = DSWCharm then sel := U_ARMRINGR;
   }

   if Sender = DSHBujuk then sel := U_BUJUK;
   if Sender = DSHBelt then sel := U_BELT;
   if Sender = DSHBoots then sel := U_BOOTS;
   if Sender = DSHCharm then sel := U_CHARM;
   
   if sel >= 0 then begin
      g_HeroMouseStateItem := g_HeroItems[sel];

      if Sender = DSHHelmet then begin
        if g_HeroItems[U_ZHULI].s.Name <> '' then begin
          g_HeroMouseItem := g_HeroItems[U_ZHULI];
          GetMouseItemInfo (iname, d1, d2, d3, useable, 2{Ӣ��});
          if iname <> '' then begin
            if g_HeroItems[U_ZHULI].Dura = 0 then hcolor := clRed
            else hcolor := clYellow;

            nHintX:=DSHHelmet.SurfaceX(DSHHelmet.Left) + DSHHelmet.Width * 2;
            nHintY:=DSHHelmet.SurfaceY(DSHHelmet.Top);
            with Butt as TDButton do
              DScreen.ShowHint(nHintX,nHintY,
                             iname  + '\'+ d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
          end;
          g_HeroMouseItem.S.Name := '';
        end;
      end;
      //ԭΪע�͵� ��ʾ�������ϴ�����Ʒ��Ϣ
      (*g_MouseItem := g_HeroItems[sel];
      GetMouseItemInfo (iname, d1, d2, d3, useable, 2{Ӣ��});
      if iname <> '' then begin
         if g_HeroItems[sel].Dura = 0 then hcolor := clRed
         else hcolor := clWhite;

         nLocalX:=Butt.LocalX(X - Butt.Left);
         nLocalY:=Butt.LocalY(Y - Butt.Top);
         nHintX:=Butt.SurfaceX(Butt.Left) + DStateHero.SurfaceX(DStateHero.Left) + nLocalX;
         nHintY:=Butt.SurfaceY(Butt.Top) + DStateHero.SurfaceY(DStateHero.Top) + nLocalY;

         with Butt as TDButton do
            DScreen.ShowHint (nHintX,
                              nHintY,
                              iname + d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
      end;
      g_MouseItem.S.Name := ''; *)
      //

   end;
end;

procedure TFrmDlg.HeroPackageClick(Sender: TObject; X, Y: Integer);
begin
   if g_HeroSelf = nil then exit;
   DHeroItemBag.Visible := not DHeroItemBag.Visible;
   if DHeroItemBag.Visible then
   ArrangeHeroItemBag;
end;

//Ӣ����ʾװ��
procedure TFrmDlg.DSHLightDirectPaint(Sender: TObject;  //���� $011 2007.10.21
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
  if (g_HeroItems[U_NECKLACE].S.Reserved1 = 1) or (g_HeroItems[U_RIGHTHAND].S.Reserved1 = 1)
      or (g_HeroItems[U_ARMRINGR].S.Reserved1 = 1) or (g_HeroItems[U_ARMRINGL].S.Reserved = 1)
      or (g_HeroItems[U_RINGR].S.Reserved1 = 1) or (g_HeroItems[U_RINGL].S.Reserved1 = 1)
      or (g_HeroItems[U_BUJUK].S.Reserved1 = 1) or (g_HeroItems[U_BELT].S.Reserved1 = 1)
      or (g_HeroItems[U_BOOTS].S.Reserved1 = 1) or (g_HeroItems[U_CHARM].S.Reserved1 = 1) then
      ItemLightTimeImg(); //��Ʒ����任���� 20080223
   if (HeroStateTab = 0) and (HeroStatePage = 0) then begin
      if Sender = DSHNecklace then begin
         if g_HeroItems[U_NECKLACE].S.Name <> '' then begin
            idx := g_HeroItems[U_NECKLACE].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSHNecklace.SurfaceX(DSHNecklace.Left + (DSHNecklace.Width - d.Width) div 2),
                                 DSHNecklace.SurfaceY(DSHNecklace.Top + (DSHNecklace.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_HeroItems[U_NECKLACE].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSHNecklace.SurfaceX(DSHNecklace.Left-21), DSHNecklace.SurfaceY(DSHNecklace.Top-23), d, 1);
              end;
            end;
         end;
      end;
      if Sender = DSHLight then begin
         if g_HeroItems[U_RIGHTHAND].S.Name <> '' then begin
            idx := g_HeroItems[U_RIGHTHAND].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSHLight.SurfaceX(DSHLight.Left + (DSHLight.Width - d.Width) div 2),
                                 DSHLight.SurfaceY(DSHLight.Top + (DSHLight.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_HeroItems[U_RIGHTHAND].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSHLight.SurfaceX(DSHLight.Left-21), DSHLight.SurfaceY(DSHLight.Top-23), d, 1);
              end;
            end;
         end;
      end;
      if Sender = DSHArmRingR then begin
         if g_HeroItems[U_ARMRINGR].S.Name <> '' then begin
            idx := g_HeroItems[U_ARMRINGR].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSHArmRingR.SurfaceX(DSHArmRingR.Left + (DSHArmRingR.Width - d.Width) div 2),
                                 DSHArmRingR.SurfaceY(DSHArmRingR.Top + (DSHArmRingR.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_HeroItems[U_ARMRINGR].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSHArmRingR.SurfaceX(DSHArmRingR.Left-21), DSHArmRingR.SurfaceY(DSHArmRingR.Top-23), d, 1);
              end;
            end;
         end;
      end;
      if Sender = DSHArmRingL then begin
         if g_HeroItems[U_ARMRINGL].S.Name <> '' then begin
            idx := g_HeroItems[U_ARMRINGL].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSHArmRingL.SurfaceX(DSHArmRingL.Left + (DSHArmRingL.Width - d.Width) div 2),
                                 DSHArmRingL.SurfaceY(DSHArmRingL.Top + (DSHArmRingL.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_HeroItems[U_ARMRINGL].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSHArmRingL.SurfaceX(DSHArmRingL.Left-21), DSHArmRingL.SurfaceY(DSHArmRingL.Top-23), d, 1);
              end;
            end;
         end;
      end;
      if Sender = DSHRingR then begin
         if g_HeroItems[U_RINGR].S.Name <> '' then begin
            idx := g_HeroItems[U_RINGR].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSHRingR.SurfaceX(DSHRingR.Left + (DSHRingR.Width - d.Width) div 2),
                                 DSHRingR.SurfaceY(DSHRingR.Top + (DSHRingR.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_HeroItems[U_RINGR].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSHRingR.SurfaceX(DSHRingR.Left-21), DSHRingR.SurfaceY(DSHRingR.Top-23), d, 1);
              end;
            end;
         end;
      end;
      if Sender = DSHRingL then begin
         if g_HeroItems[U_RINGL].S.Name <> '' then begin
            idx := g_HeroItems[U_RINGL].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSHRingL.SurfaceX(DSHRingL.Left + (DSHRingL.Width - d.Width) div 2),
                                 DSHRingL.SurfaceY(DSHRingL.Top + (DSHRingL.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_HeroItems[U_RINGL].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSHRingL.SurfaceX(DSHRingL.Left-21), DSHRingL.SurfaceY(DSHRingL.Top-23), d, 1);
              end;
            end;
         end;
      end;

      if Sender = DSHBujuk then begin
         if g_HeroItems[U_BUJUK].S.Name <> '' then begin
            idx := g_HeroItems[U_BUJUK].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSHBujuk.SurfaceX(DSHBujuk.Left + (DSHBujuk.Width - d.Width) div 2),
                                 DSHBujuk.SurfaceY(DSHBujuk.Top + (DSHBujuk.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_HeroItems[U_BUJUK].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSHBujuk.SurfaceX(DSHBujuk.Left-21), DSHBujuk.SurfaceY(DSHBujuk.Top-23), d, 1);
              end;
            end;
         end;
      end;

      if Sender = DSHBelt then begin
         if g_HeroItems[U_BELT].S.Name <> '' then begin
            idx := g_HeroItems[U_BELT].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSHBelt.SurfaceX(DSHBelt.Left + (DSHBelt.Width - d.Width) div 2),
                                 DSHBelt.SurfaceY(DSHBelt.Top + (DSHBelt.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_HeroItems[U_BELT].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSHBelt.SurfaceX(DSHBelt.Left-21), DSHBelt.SurfaceY(DSHBelt.Top-23), d, 1);
              end;
            end;
         end;
      end;

      if Sender = DSHBoots then begin
         if g_HeroItems[U_BOOTS].S.Name <> '' then begin
            idx := g_HeroItems[U_BOOTS].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSHBoots.SurfaceX(DSHBoots.Left + (DSHBoots.Width - d.Width) div 2),
                                 DSHBoots.SurfaceY(DSHBoots.Top + (DSHBoots.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_HeroItems[U_BOOTS].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSHBoots.SurfaceX(DSHBoots.Left-21), DSHBoots.SurfaceY(DSHBoots.Top-23), d, 1);
              end;
            end;
         end;
      end;

      if Sender = DSHCharm then begin
         if g_HeroItems[U_CHARM].S.Name <> '' then begin
            idx := g_HeroItems[U_CHARM].S.Looks;
            if idx >= 0 then begin
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSHCharm.SurfaceX(DSHCharm.Left + (DSHCharm.Width - d.Width) div 2),
                                 DSHCharm.SurfaceY(DSHCharm.Top + (DSHCharm.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
              if g_HeroItems[U_CHARM].S.Reserved1 = 1 then begin
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                   DrawBlend(dsurface,DSHCharm.SurfaceX(DSHCharm.Left-21), DSHCharm.SurfaceY(DSHCharm.Top-23), d, 1);
              end;
            end;
         end;
      end;
   end;
end;


procedure TFrmDlg.DHeroItemBagDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d0, d1, d2, d3: string;
   n, HitY: integer;
   useable: Boolean;
   d: TDirectDrawSurface;
begin
   if g_HeroSelf = nil then Exit;
      with DHeroItemBag do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
         GetMouseItemInfo (d0, d1, d2, d3, useable, 2{Ӣ��});
         case g_HeroBagCount of
            10: begin
              DHeroItemBag.SetImgIndex (g_WMain3Images, 375);
              DHeroItemGrid.RowCount:= 2;
              DHeroItemGrid.Height:= 63;
            end;
            20: begin
              DHeroItemBag.SetImgIndex (g_WMain3Images, 376);
              DHeroItemGrid.RowCount:= 4;
              DHeroItemGrid.Height:= 126;
            end;
            30: begin
              DHeroItemBag.SetImgIndex (g_WMain3Images, 377);
              DHeroItemGrid.RowCount:= 6;
              DHeroItemGrid.Height:= 192;
            end;
            35: begin
              DHeroItemBag.SetImgIndex (g_WMain3Images, 378);
              DHeroItemGrid.RowCount:= 7;
              DHeroItemGrid.Height:= 224;
            end;
            40: begin
              DHeroItemBag.SetImgIndex (g_WMain3Images, 379);
              DHeroItemGrid.RowCount:= 8;
              DHeroItemGrid.Height:= 255;
            end;
         end;

         with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          HitY := DHeroItemGrid.Height+42;

          //��ʾ���   20080222
         if g_HeroMouseItem.s.Name = '' then begin
            {$IF Version = 1}
            Font.Color := clWhite;
            TextOut (SurfaceX(Left+14), SurfaceY(Top+HitY), '�Ҽ��������װ��');
            TextOut (SurfaceX(Left+14), SurfaceY(Top+HitY+14), 'ALT + R ��ˢ�°���');
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left+14), SurfaceY(Top+HitY), clWhite, '�Ҽ��������װ��');
            ClFunc.TextOut (dsurface, SurfaceX(Left+14), SurfaceY(Top+HitY+14), clWhite, 'ALT + R ��ˢ�°���');
            {$IFEND}
         end;
          
         //ʢ����Ʒ��
          if d0 <> '' then begin
            n := FrmMain.Canvas.TextWidth (d0);
            BoldTextOut (dsurface,SurfaceX(Left+14), SurfaceY(Top+HitY), clYellow, clBlack,d0);
            BoldTextOut (dsurface,SurfaceX(Left+14) + n, SurfaceY(Top+HitY), clWhite, clBlack,d1);
            BoldTextOut (dsurface,SurfaceX(Left+14), SurfaceY(Top+HitY+14), clWhite, clBlack,d2);

            if not useable then
            BoldTextOut (dsurface,SurfaceX(Left+14), SurfaceY(Top+HitY+14*2), clRed, clBlack,d3)
            else BoldTextOut (dsurface,SurfaceX(Left+14), SurfaceY(Top+HitY+14*2), clWhite, clBlack,d3);
          end;
         Release;
      end;
   end;
end;

//Ӣ�۰�������
procedure TFrmDlg.DHeroItemGridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DHeroItemGrid.ColCount;
   if idx in [0..g_HeroBagCount-1] then begin
      if g_HeroItemArr[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_HeroItemArr[idx].S.Looks];
         if d <> nil then
            with DHeroItemGrid do begin
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 -1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
              if g_HeroItemArr[idx].S.Reserved1 = 1 then begin //���� 20080223
                ItemLightTimeImg();
                d := g_WMain2Images.Images[ItemLightImgIdx + 260];
                if d <> nil then
                  DrawBlend(dsurface,SurfaceX(Rect.Left-21), SurfaceY(Rect.Top-23), d, 1);
              end;
            end;
      end;
   end;
end;
//����ƶ����̣���꾭��ĳ����Ʒ����ʾ
procedure TFrmDlg.DHeroItemGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
begin
  DScreen.ClearHint;
   if ssRight in Shift then begin
      if g_boHeroItemMoving then
         DHeroItemGridGridSelect (self, ACol, ARow, Shift)
      else
          if GetTickCount - g_nRightItemTick > 700 then begin   //20080308
            g_nRightItemTick := GetTickCount();
            MouseRightItem(2,ACol,ARow);
          end;
   end else begin
      idx := ACol + ARow * DHeroItemGrid.ColCount;
      if idx in [0..g_HeroBagCount-1] then begin
         g_HeroMouseItem := g_HeroItemArr[idx];
      end;
   end;

   {GetMouseItemInfo (iname, d1, d2, d3, useable, 2);
     if iname <> '' then begin
        if useable then hcolor := clWhite
        else hcolor := clRed;
        with DHeroItemGrid do
           DScreen.ShowHint (SurfaceX(Left + ACol*ColWidth),
                             SurfaceY(Top + (ARow+1)*RowHeight),
                             iname + d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
     end;
     g_MouseItem.S.Name := '';    }
end;
//�ƶ�Ӣ��װ��
procedure TFrmDlg.DSHWeaponClick(Sender: TObject; X, Y: Integer);
var
   where, n, sel: integer;
   flag: Boolean;
 msg: TDefaultMessage;
begin
   if g_HeroSelf = nil then exit;
   if not g_boHeroRightItem {��������Ҽ�������Ʒ}then if (HeroStateTab <> 0) or (HeroStatePage <> 0) then exit;
   if g_boHeroItemMoving or g_boHeroRightItem{�Ҽ�����Ʒ}  then begin
      flag := FALSE;
      if (g_MovingHeroItem.Index = -97) or (g_MovingHeroItem.Index = -98) then exit;
      if (g_MovingHeroItem.Item.S.Name = '') or (g_WaitingHeroUseItem.Item.S.Name <> '') then exit;
      where := GetTakeOnPosition (g_MovingHeroItem.Item.S.StdMode);
      if g_MovingHeroItem.Index >= 0 then begin
         case where of
            U_DRESS: begin
               if Sender = DSHDress then begin
                  if g_HeroSelf.m_btSex = 0 then //��
                     if g_MovingHeroItem.Item.S.StdMode <> 10 then //���·�
                        exit;
                  if g_HeroSelf.m_btSex = 1 then //Ů
                     if g_MovingHeroItem.Item.S.StdMode <> 11 then //Ů�·�
                        exit;
                  flag := TRUE;
               end;
            end;
            U_WEAPON: begin
               if Sender = DSHWEAPON then begin
                  flag := TRUE;
               end;
            end;
            X_RepairFir: begin //�޲�����֮��
             if Sender = DSHBujuk then begin
               if (g_HeroItems[U_BUJUK].s.Shape = 9) and (g_HeroItems[U_BUJUK].s.StdMode = 25) and (g_MovingHeroItem.Item.s.StdMode = 42) then begin
                 msg := MakeDefaultMsg (CM_REPAIRFIRDRAGON,g_MovingHeroItem.Item.MakeIndex, 4, 0, 0, frmMain.Certification);//20071231
                 FrmMain.SendSocket (EncodeMessage (msg)+Encodestring(g_MovingHeroItem.Item.s.Name));//20071231
               end;
             end;
            end;
            U_NECKLACE: begin
               if Sender = DSHNecklace then
                  flag := TRUE;
            end;
            U_RIGHTHAND: begin
               if Sender = DSHLight then
                  flag := TRUE;
            end;
            U_HELMET: begin  //ͷ��
               if Sender = DSHHelmet then
                  flag := TRUE;
            end;
            U_ZHULI: begin //����
              if Sender = DSHHelmet then
                 flag := True;
            end;
            U_RINGR, U_RINGL: begin
               if Sender = DSHRingL then begin
                  where := U_RINGL;
                  flag := TRUE;
               end;
               if Sender = DSHRingR then begin
                  where := U_RINGR;
                  flag := TRUE;
               end;
            end;
            U_ARMRINGR: begin  //����
               if Sender = DSHArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
               if Sender = DSHArmRingR then begin
                  where := U_ARMRINGR;
                  flag := TRUE;
               end;
            end;
            U_ARMRINGL: begin  //25,  ������,����
               if Sender = DSHArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
            end;
            U_BUJUK: begin
               if Sender = DSHBujuk then begin
                  where := U_BUJUK;
                  flag := TRUE;
               end;
               if Sender = DSHArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
            end;
            U_BELT: begin
               if Sender = DSHBelt then begin
                  where := U_BELT;
                  flag := TRUE;
               end;
            end;
            U_BOOTS: begin
               if Sender = DSHBoots then begin
                  where := U_BOOTS;
                  flag := TRUE;
               end;
            end;
            U_CHARM: begin
               if Sender = DSHCharm then begin
                  where := U_CHARM;
                  flag := TRUE;
               end;
            end;
         end;
      end else begin
         n := -(g_MovingHeroItem.Index+1);
         if n in [0..13] then begin
            ItemClickSound (g_MovingHeroItem.Item.S);
            g_HeroItems[n] := g_MovingHeroItem.Item;
            g_MovingHeroItem.Item.S.Name := '';
            g_boHeroItemMoving := FALSE;
            g_boHeroRightItem := FALSE; {�Ҽ�����Ʒ}
         end;
      end;
      if flag then begin
         ItemClickSound (g_MovingHeroItem.Item.S);
         g_WaitingHeroUseItem := g_MovingHeroItem;
         g_WaitingHeroUseItem.Index := where;
         FrmMain.SendTakeOnHeroItem (where, g_MovingHeroItem.Item.MakeIndex, g_MovingHeroItem.Item.S.Name);
         g_MovingHeroItem.Item.S.Name := '';
         g_boHeroItemMoving := FALSE;
         g_boHeroRightItem := FALSE;{�Ҽ�����װ��}
      end;
      if (Sender = DSHBujuk) and (g_MovingHeroItem.Item.s.Shape=9) and (g_boHeroItemMoving = FALSE) then begin
        DHeroSpleen.Visible:=TRUE;
      end;   //20080319
  end
   else begin
      if g_boItemMoving then Exit;
      if (g_MovingHeroItem.Item.S.Name <> '') or (g_WaitingHeroUseItem.Item.S.Name <> '') then exit;
      sel := -1;
      if Sender = DSHDress then sel := U_DRESS;
      if Sender = DSHWeapon then sel := U_WEAPON;

      //if Sender = DSHHelmet then sel := U_HELMET;

      //����
      if Sender = DSHHelmet then begin
        if g_HeroItems[U_ZHULI].s.Name <> '' then
         sel := U_ZHULI
        else sel := U_HELMET;
      end;

      if Sender = DSHNecklace then sel := U_NECKLACE;
      if Sender = DSHLight then sel := U_RIGHTHAND;
      if Sender = DSHRingL then sel := U_RINGL;
      if Sender = DSHRingR then sel := U_RINGR;
      if Sender = DSHArmRingL then sel := U_ARMRINGL;
      if Sender = DSHArmRingR then sel := U_ARMRINGR;

      if Sender = DSHBujuk then sel := U_BUJUK;
      if Sender = DSHBelt then sel := U_BELT;  //
      if Sender = DSHBoots then sel := U_BOOTS;
      if Sender = DSHCharm then sel := U_CHARM;

      if sel >= 0 then begin
         if g_HeroItems[sel].S.Name <> '' then begin
            ItemClickSound (g_HeroItems[sel].S);
            g_MovingHeroItem.Index := -(sel+1);
            g_MovingHeroItem.Item := g_HeroItems[sel];
            g_HeroItems[sel].S.Name := '';
            g_boHeroItemMoving := TRUE;
         end;
      end;
      if (Sender = DSHBujuk) and (g_HeroItems[U_BUJUK].s.Shape=9) and (g_boHeroItemMoving = TRUE) then begin
        DHeroSpleen.Visible:=FALSE;
   end;
   end;
end;
//Ӣ�۷�ҳ����� ����$013 2007.10.21
procedure TFrmDlg.HeroPageChanged;
begin
   DScreen.ClearHint;
   case HeroStatePage of
      3: begin //ħ�� ����â
         DStMagHero1.Visible := TRUE;  DStMagHero2.Visible := TRUE;
         DStMagHero3.Visible := TRUE;  DStMagHero4.Visible := TRUE;
         DStMagHero5.Visible := TRUE;  DStMagHero6.Visible := TRUE;
         DSHPageUp.Visible := TRUE;
         DSHPageDown.Visible := TRUE;
         HeroMagicPage := 0;
      end;
      else begin
         DStMagHero1.Visible := FALSE;  DStMagHero2.Visible := FALSE;
         DStMagHero3.Visible := FALSE;  DStMagHero4.Visible := FALSE;
         DStMagHero5.Visible := FALSE;  DStMagHero6.Visible := FALSE;
         DSHPageUp.Visible := FALSE;
         DSHPageDown.Visible := FALSE;
      end;
   end;
end;
procedure TFrmDlg.DPrevStateHeroClick(Sender: TObject; X, Y: Integer);
begin
  if HeroStateTab = 0 then begin
   Dec (HeroStatePage);
   if HeroStatePage < 0 then
      HeroStatePage := MAXSTATEPAGE-1;
   HeroPageChanged;
  end else begin
    Dec (HeroInternalForcePage);
    if HeroInternalForcePage < 0 then
      HeroInternalForcePage := 1;
    HeroInternalForcePageChanged;
  end;
end;
procedure TFrmDlg.DNextStateHeroClick(Sender: TObject; X, Y: Integer);
begin
  if HeroStateTab = 0 then begin
   Inc (HeroStatePage);
   if HeroStatePage > MAXSTATEPAGE-1 then
      HeroStatePage := 0;
   HeroPageChanged;
  end else begin
    Inc (HeroInternalForcePage);
    if HeroInternalForcePage > 1 then
      HeroInternalForcePage := 0;
    HeroInternalForcePageChanged;
  end;
end;

procedure TFrmDlg.RefusePublicChatClick(Sender: TObject; X, Y: Integer);
begin
    g_boOwnerMsg := not g_boOwnerMsg;
    if g_boOwnerMsg then begin
      RefusePublicChat.SetImgIndex(g_WMain3Images,281);
      DScreen.AddChatBoardString('[��ֹ���չ���]', GetRGB(219), clWhite);
    end else begin
      RefusePublicChat.SetImgIndex(g_WMain3Images,280);
      DScreen.AddChatBoardString('[������չ���]', GetRGB(219), clWhite);
    end;
end;



procedure TFrmDlg.DHeroItemGridCloseClick(Sender: TObject; X, Y: Integer);
begin
   DHeroItemBag.Visible := FALSE;
end;

procedure TFrmDlg.DHeroItemGridGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx, mi: integer;
   temp: TClientItem;
   TempIdx: Integer;
begin
  //20080803���� ����װ�����µ�Ӣ�۰��� ��Ʒ�ص�
  if (g_boItemMoving) and (-g_MovingItem.Index in [1..14]) then Exit;
{-------------------------------------------------------}
//�����˰�����Ӣ�۰��� ���� 2007.10.24
   if g_boItemMoving then begin
    if g_MovingItem.Item.s.Name <> '' then begin
     TempIdx := -(g_MovingItem.Index);
     if not (TempIdx in [1..14]) then begin
       g_WaitingHeroUseItem := g_MovingItem;
       FrmMain.SendItemToHeroBag(-(g_MovingItem.Index+1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
       g_boItemMoving := FALSE;
       g_MovingItem.Item.s.Name:='';
       Exit; //20080331
     end;
    end;
   end;
{-------------------------------------------------------------}
    idx := ACol + ARow * DHeroItemGrid.ColCount{��Ʈ����};
   if idx in [0..g_HeroBagCount-1] then begin
      if not g_boHeroItemMoving then begin
         if g_HeroItemArr[idx].S.Name <> '' then begin
            g_boHeroItemMoving := TRUE;
            g_MovingHeroItem.Index := idx;
            g_MovingHeroItem.Item := g_HeroItemArr[idx];
            g_HeroItemArr[idx].S.Name := '';
            ItemClickSound (g_HeroItemArr[idx].S);
         end;
      end else begin
         mi := g_MovingHeroItem.Index;
         if (mi = -97) or (mi = -98) then exit; //��...
         if (mi < 0) and (mi >= -14 {-9}) then begin  //-99: Sellâ���� ��������
            //����â���� ��������
            g_WaitingHeroUseItem := g_MovingHeroItem;
            FrmMain.SendTakeOffHeroItem (-(g_MovingHeroItem.Index+1), g_MovingHeroItem.Item.MakeIndex, g_MovingHeroItem.Item.S.Name);
            g_MovingHeroItem.Item.S.name := '';
            g_boHeroItemMoving := FALSE;
         end else begin
            if (mi <= -20) and (mi > -30) then
               DealItemReturnBag (g_MovingHeroItem.Item);
            if g_HeroItemArr[idx].S.Name <> '' then begin
               temp := g_HeroItemArr[idx];
               g_HeroItemArr[idx] := g_MovingHeroItem.Item;
               g_MovingHeroItem.Index := idx;
               g_MovingHeroItem.Item := temp
            end else begin
               g_HeroItemArr[idx] := g_MovingHeroItem.Item;
               g_MovingHeroItem.Item.S.name := '';
               g_boHeroItemMoving := FALSE;
            end;
         end;
      end;
   end;
   ArrangeHeroItemBag;
end;

procedure TFrmDlg.DHeroItemGridDblClick(Sender: TObject);
var
   idx: integer;
   keyvalue: TKeyBoardState;
   cu: TClientItem;
begin
   idx := DHeroItemGrid.Col + DHeroItemGrid.Row * DHeroItemGrid.ColCount;
   if idx in [0..g_HeroBagCount-1] then begin
      if g_HeroItemArr[idx].S.Name <> '' then begin
         FillChar(keyvalue, sizeof(TKeyboardState), #0);
         GetKeyboardState (keyvalue);
         if keyvalue[VK_CONTROL] = $80 then begin   //ctrl
            //��Ʈâ���� �ű�
            cu := g_HeroItemArr[idx];
            g_HeroItemArr[idx].S.Name := '';
            AddHeroItemBag (cu);
         end else
            if (g_HeroItemArr[idx].S.StdMode <= 4) or (g_HeroItemArr[idx].S.StdMode = 31) then begin //������ �� �ִ� ������
               FrmMain.HeroEatItem (idx);
            end;
      end else begin
         if g_boHeroItemMoving and (g_MovingHeroItem.Item.S.Name <> '') then begin
            FillChar(keyvalue, sizeof(TKeyboardState), #0);
            GetKeyboardState (keyvalue);
            if keyvalue[VK_CONTROL] = $80 then begin
               //��Ʈâ���� �ű�
               cu := g_MovingHeroItem.Item;
               g_MovingHeroItem.Item.S.Name := '';
               g_boHeroItemMoving := FALSE;
               AddHeroItemBag (cu);
            end else
               if (g_MovingHeroItem.Index = idx) and
                  (g_MovingHeroItem.Item.S.StdMode <= 4) or (g_HeroItemArr[idx].S.StdMode = 31) or ((g_MovingItem.Item.S.StdMode = 60) and (g_MovingItem.Item.S.Shape <> 0))
               then begin
                  FrmMain.HeroEatItem (-1);
               end;
         end;
      end;
   end;
end;

//Ӣ��ͼ���Ա� ְҵ ͼ������    ���� 2007.11.2  ����$005
function TFrmDlg.HeroIcon(sex:integer;job:integer):integer;
begin
  case Sex of
    0:Result := 365+job;
    1:Result := 368+job;
  end;
end;

//Ӣ�۵ײ㱳������
procedure TFrmDlg.DHeroRoleIconDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  pgidx,bbx,bby:integer;
  d: TDirectDrawSurface;
  rc: TRect;
begin
  pgidx:=HeroIcon(g_HeroSelf.m_btSex,g_HeroSelf.m_btJob);
  bbx := 17;
  bby := 18;
  with Sender as TDButton do begin
    d := g_WMain3Images.Images[pgidx];
  if (g_HeroSelf <> nil) and (g_HeroSelf.m_Abil.HP <= 0) and (g_HeroSelf.m_boDeath) then begin
    g_HeroSelf.m_Abil.MP := 0;
    g_HeroSelf.m_Abil.Exp := 0;
    if d <> nil then
      DrawBlendEx(dsurface,SurfaceX(bbx),
                  SurfaceY(bby), d,0,0,d.Width,d.Height, 0);
    end else begin
      if d <> nil then
      dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, true);
    end;
  end;
  with dsurface.Canvas do begin
    {$IF Version = 1}
    SetBkMode (Handle, TRANSPARENT);
    Font.Color := clWhite;
    TextOut (14 - TextWidth(IntToStr(g_HeroSelf.m_Abil.Level)) div 2,61, Inttostr(g_Heroself.m_Abil.Level));
    Release;
    {$ELSE}
    ClFunc.TextOut (dsurface, 14 - FrmMain.Canvas.TextWidth(IntToStr(g_HeroSelf.m_Abil.Level)) div 2,61, clWhite, Inttostr(g_Heroself.m_Abil.Level));
    {$IFEND}
  end;

  d := g_WMain2Images.Images[513];
  if d <> nil then
     dsurface.Draw (34, 12, d.ClientRect, d, true);

  d := g_WMain2Images.Images[582];
  if d <> nil then begin
     rc := d.ClientRect;
     if (g_HeroSelf.m_Abil.MaxAlcohol > 0) and (g_HeroSelf.m_Abil.WineDrinkValue > 0) then begin
       rc.Top := Round(rc.Bottom / g_HeroSelf.m_Abil.MaxAlcohol * (g_HeroSelf.m_Abil.MaxAlcohol - g_HeroSelf.m_Abil.WineDrinkValue));
       dsurface.Draw (34, 12+rc.Top, rc, d, True);
     end;
  end;
  
end;

//Ӣ��ͼ�����
procedure TFrmDlg.DHeroIconDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc:Trect;
//  infoMsg:String;
begin
  d := FrmMain.UiImages(0);//FrmMain.UiDXImageList.Items.Find('HeroStatusWindow').PatternSurfaces[0];
  if d <> nil then begin
    dsurface.Draw (0, 0, d.ClientRect, d, true);
  end;
  //FrmMain.UiDXImageList.Items.Find('HeroStatusWindow').Draw({FrmMain.DXDraw.Surface}dsurface, 0, 10, 0);

  d := g_WMain3Images.Images[386];
  if d <> nil then begin
     rc := d.ClientRect;
     if g_Heroself.m_Abil.MaxHP > 0 then
     rc.Right := Round((rc.Right-rc.Left) / g_Heroself.m_Abil.MaxHP * g_Heroself.m_Abil.HP);
     dsurface.Draw (75, 24, rc, d, true);
  end;
  d := g_WMain3Images.Images[387];
  if d <> nil then begin
     rc := d.ClientRect;
     if g_Heroself.m_Abil.MaxMP > 0 then
     rc.Right := Round((rc.Right-rc.Left) / g_Heroself.m_Abil.MaxMP * g_Heroself.m_Abil.MP);
     dsurface.Draw (80, 37, rc, d, TRUE);
  end;
  d := g_WMain3Images.Images[388];
  if d <> nil then begin
     rc := d.ClientRect;
     if g_Heroself.m_Abil.MaxExp > 0 then
     rc.Right := Round((rc.Right-rc.Left) / g_Heroself.m_Abil.MaxExp * g_Heroself.m_Abil.Exp);
     dsurface.Draw (80, 49, rc, d, TRUE);
  end;
  with dsurface.Canvas do begin
    {$if Version = 1}
    SetBkMode (Handle, TRANSPARENT);
    Font.Color := clWhite;
    TextOut (80, 5, g_HeroSelf.m_sUserName);
    {$ELSE}
    ClFunc.TextOut (dsurface, 80, 5, clWhite, g_HeroSelf.m_sUserName);
    {$IFEND}
    BoldTextOut(dsurface,240 div 2 - FrmMain.Canvas.TextWidth(formatfloat('0.00',g_HeroSelf.m_nLoyal / 100)+'%') div 2,
     62, clWhite, clBlack, FormatFloat('0.00',g_HeroSelf.m_nLoyal / 100)+'%');
    Release;
  end;
end;
//Ӣ��ŭ���任����
procedure TFrmDlg.typeTimeimg;
begin
    if GetTickCount - typetime > 500 then begin
     typetime := GetTickCount;
     inc(imginsex);
    if imginsex > 1 then imginsex := 0;
    end;
end;

//Ӣ��ŭ��
procedure TFrmDlg.DButton3DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc:Trect;
begin
  d := g_WMain3Images.Images[411];
  rc := d.ClientRect;
  if d <> nil then begin
    if nMaxFirDragonPoint > 0 then begin
     rc.Top := Round(rc.Bottom / nMaxFirDragonPoint * (nMaxFirDragonPoint - m_nFirDragonPoint));
     dsurface.Draw (607 + rc.Left, 456+rc.Top, rc, d, FALSE);
    end;
  end;
  if m_nFirDragonPoint >= nMaxFirDragonPoint then begin
    typeTimeimg;//��ʾʱ����
    d := g_WMain3Images.Images[imginsex + 411];
    if d <> nil then
     dsurface.Draw (607 + rc.Left, 456+rc.Top, d.ClientRect, d, false);
  end;
end;


procedure TFrmDlg.DSHPageUpClick(Sender: TObject; X, Y: Integer);
begin
  if HeroStateTab = 0 then begin
    if Sender = DSHPageUp then begin
      if HeroMagicPage > 0 then
         Dec (HeroMagicPage);
    end else begin
      if HeroMagicPage < (g_HeroMagicList.Count+4) div 5 - 1 then
         Inc (HeroMagicPage);
    end;
  end else begin
    if Sender = DSHPageUp then begin
      if HeroInternalForceMagicPage > 0 then
         Dec (HeroInternalForceMagicPage);
    end else begin
      if HeroInternalForceMagicPage < (g_HeroInternalForceMagicList.Count+4) div 5 - 1 then
         Inc (HeroInternalForceMagicPage);
    end;
  end;
end;

procedure TFrmDlg.DHeroIconClick(Sender: TObject; X, Y: Integer);
begin
if g_HeroSelf = nil then exit;
{-------------------------------------------------------}
//�����˰�����Ӣ�۰��� ���� 2007.10.24
   if g_boItemMoving then begin
    if g_MovingItem.Item.s.Name <> '' then begin
     g_WaitingHeroUseItem := g_MovingItem;
     FrmMain.SendItemToHeroBag(-(g_MovingItem.Index+1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
     g_boItemMoving := FALSE;
     g_MovingItem.Item.s.Name:='';
    end;
   end;
end;

procedure TFrmDlg.DStMagHero1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx, icon: integer;
   d: TDirectDrawSurface;
   pm: PTClientMagic;
begin
  if HeroStatePage = 3 then begin
   with Sender as TDButton do begin
      idx := _Max(Tag + HeroMagicPage * 6, 0);
      if idx < g_HeroMagicList.Count then begin
         pm := PTClientMagic (g_HeroMagicList[idx]);
         if pm.Def.btEffect = 91 then icon := 0   //�������ħ������ͼ��  20080229
         else if (pm.Def.wMagicId = 13) and (pm.Level = 4) then icon := 140 //4�������ͼ��
         else if (pm.Def.wMagicId = 45) and (pm.Level = 4) then icon := 144 //4�������ͼ��
         else if (pm.Def.wMagicId = 26) and (pm.Level = 4) then icon := 142 //4���һ�ͼ��
         else icon := pm.Def.btEffect * 2;
         if icon >= 0 then begin 
            if not Downed then begin
               d := g_WMagIconImages.Images[icon];
               if d <> nil then begin
                  if word(pm.Key) = 0 then
                    dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE)
                  else
                    DrawBlendEx(dsurface,SurfaceX(Left),
                       SurfaceY(Top), d,0,0,d.Width,d.Height, 0);
               end;
            end else begin
               if (pm.Def.wMagicId in [3,4,60..65,67]) then begin
                 d := g_WMagIconImages.Images[icon];
                 if d <> nil then
                      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
               end else begin
                 d := g_WMagIconImages.Images[icon+1];
                 if d <> nil then
                    if word(pm.Key) = 0 then
                      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE)
                    else
                      DrawBlendEx(dsurface,SurfaceX(Left),
                         SurfaceY(Top), d,0,0,d.Width,d.Height, 0);
               end;
            end;
         end;
      end;
   end;
  end;
end;

procedure TFrmDlg.DStateHeroMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
  g_HeroMouseStateItem.S.Name := '';
end;

procedure TFrmDlg.DBotMemoClick(Sender: TObject; X, Y: Integer);
begin
  if GetTickCount - g_dwShopTick > 2000 then begin
    g_dwShopTick := GetTickCount();
    Dshop.Visible:=True;
    DShopDecorateClick(DShopDecorate,x,y);
    ShopIndex := -1;
    ShopSpeciallyIndex := -1;
  end;
end;
(*******************************************************************************
  ���� : ���������ط��ķָ������
  ���� : ShopStrWord(s:string;dsurface:TdirectDrawSurface;x,y:integer)
  ���� : sΪ�������ַ���. dsurfaceΪ�������. x,yΪ���������
*******************************************************************************)
procedure TFrmDlg.ShopStrWord(s:string;dsurface:TDirectDrawSurface;x,y:integer);//ȡ|���� ���ұߵ�����
var i,j:integer;
str:string;
begin
  j:=0;
  str:='';
  s:=s+'|';
  if Length(s)<=0 then begin //20080629
      exit;
  end;
  for i:=1 to length(s) do begin
    if (s[i]='|' ) then begin
      if str<>'' then begin
        with dsurface.Canvas do begin
          {$IF Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          j:=j+1;
          TextOut (x, y+j*14 ,str);
          {$ELSE}
          j:=j+1;
          ClFunc.TextOut (dsurface, x, y+j*14, clWhite, str);
          {$IFEND}
        end;
      end;
      str:='';
      continue;
    end;
  str:=str+s[i]
  end;
end;

procedure TFrmDlg.DShopDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  i,bbx,bby,m:integer;
  d:TDirectDrawSurface;
  pm:pTShopInfo;
begin
  with DShop do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;

    d := g_WEffectImages.Images[380];
    if d <> nil then
    dsurface.Draw (SurfaceX(Left+18), SurfaceY(Top+35), d.ClientRect, d, true);
    if g_ShopSpeciallyItemList.Count > 0 then //20080629
    for I:=0 to g_ShopSpeciallyItemList.Count-1 do begin
            pm := pTShopInfo (g_ShopSpeciallyItemList[i]);
            if ShopSpeciallyIndex=i then begin
            ShopGifInfo(dsurface,SurfaceX(Left+18),SurfaceY(Top+35),strtoint(pm.ImgBegin),strtoint(pm.Imgend));
            end;
    end;
    if g_ShopItemList.Count > 0 then //20080629
    for I:=0 to g_ShopItemList.Count-1 do begin
            pm := pTShopInfo (g_ShopItemList[i]);
            if ShopIndex=i then begin
            ShopGifInfo(dsurface,SurfaceX(Left+18),SurfaceY(Top+35),strtoint(pm.ImgBegin),strtoint(pm.Imgend));
            end;
    end;

    bbx:=left+170;
    bby:=top+10;
  end;


  with dsurface.Canvas do begin
    {$IF Version = 1}
    SetBkMode (Handle, TRANSPARENT);
    {$IFEND}
      if g_ShopItemList.Count > 0 then //20080629
      for i:=0 to g_ShopItemList.Count-1 do begin
        pm := pTShopInfo (g_ShopItemList[i]);
        m := i;
          if odd(i) then begin
          if ShopIndex=i then Font.Color := clRed else Font.Color := clWhite;
          {$IF Version = 1}
          TextOut (bbx + 230, bby + 25 + m*27,pm.StdItem.Name);
          TextOut (bbx + 230, bby + 40 + m*27, pm.Introduce1);
          TextOut (bbx + 230, bby + 55 + m*27,{'�۸�'+}inttostr(pm.StdItem.Price div 100)+' Ԫ��');
          {$ELSE}
          ClFunc.TextOut (dsurface, bbx + 230, bby + 25 + m*27, Font.Color, pm.StdItem.Name);
          ClFunc.TextOut (dsurface, bbx + 230, bby + 40 + m*27, Font.Color, pm.Introduce1);
          ClFunc.TextOut (dsurface, bbx + 230, bby + 55 + m*27,{'�۸�'+}Font.Color, inttostr(pm.StdItem.Price div 100)+' Ԫ��');
          {$IFEND}
          if ShopIndex=i then begin
          g_ShopItemName :=pm.StdItem.Name;
          Font.Color := clWhite;
          ShopStrWord(pm.sIntroduce,dsurface,bbx -150,bby + 230);
          end;
          end else  begin
            if ShopIndex=i then Font.Color := clRed else Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (bbx + 60, bby + 52 + m*27,pm.StdItem.Name);
            TextOut (bbx + 60, bby + 67 + m*27,pm.Introduce1);
            TextOut (bbx + 60, bby + 82 + m*27,{'�۸�'+}inttostr(pm.StdItem.Price div 100)+' Ԫ��');
            {$ELSE}
            ClFunc.TextOut (dsurface, bbx + 60, bby + 52 + m*27, Font.Color, pm.StdItem.Name);
            ClFunc.TextOut (dsurface, bbx + 60, bby + 67 + m*27, Font.Color, pm.Introduce1);
            ClFunc.TextOut (dsurface, bbx + 60, bby + 82 + m*27,{'�۸�'+} Font.Color, inttostr(pm.StdItem.Price div 100)+' Ԫ��');
            {$IFEND}
            if ShopIndex=i then  begin
              g_ShopItemName :=pm.StdItem.Name;
              Font.Color := clWhite;
              ShopStrWord(pm.sIntroduce,dsurface,bbx -150,bby + 230);
            end;
          end;
        end;
  Release;
  end;
  with dsurface.Canvas do begin
    {$IF Version = 1}
    SetBkMode (Handle, TRANSPARENT);
    {$IFEND}
    if g_ShopSpeciallyItemList.Count > 0 then //20080629
    for i:=0 to g_ShopSpeciallyItemList.Count-1 do begin
        pm := pTShopInfo (g_ShopSpeciallyItemList[i]);
        if ShopSpeciallyIndex=i then begin
          Font.Color := clRed;
          {$IF Version = 1}
          TextOut (bbx + 350, bby + 89 + i*65,pm.StdItem.Name);
          TextOut (bbx + 350, bby + 102 + i*65,{'�۸�'+}inttostr(pm.StdItem.Price div 100)+' Ԫ��');
          {$ELSE}
          ClFunc.TextOut (dsurface, bbx + 350, bby + 89 + i*65, Font.Color, pm.StdItem.Name);
          ClFunc.TextOut (dsurface, bbx + 350, bby + 102 + i*65,{'�۸�'+}Font.Color, inttostr(pm.StdItem.Price div 100)+' Ԫ��');
          {$IFEND}
          Font.Color := clWhite;
          ShopStrWord(pm.sIntroduce,dsurface,bbx -150,bby + 230);
          g_ShopItemName:=pm.StdItem.Name;
        end else begin
          Font.Color := clWhite;
          {$IF Version = 1}
          TextOut (bbx + 350, bby + 89 + i*65,pm.StdItem.Name);
          TextOut (bbx + 350, bby + 102 + i*65,{'�۸�'+}inttostr(pm.StdItem.Price div 100)+' Ԫ��');
          {$ELSE}
          ClFunc.TextOut (dsurface, bbx + 350, bby + 89 + i*65, Font.Color, pm.StdItem.Name);
          ClFunc.TextOut (dsurface, bbx + 350, bby + 102 + i*65,{'�۸�'+}Font.Color, inttostr(pm.StdItem.Price div 100)+' Ԫ��');
          {$IFEND}
        end;
    end;
  Release;
  end;
end;

procedure TFrmDlg.DShopCloseClick(Sender: TObject; X, Y: Integer);
begin
  Dshop.Visible := FALSE;
end;

procedure TFrmDlg.DShopImg1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  icon,idx:integer;
  pm:pTShopInfo;
  d:TDirectDrawSurface;
begin
    with Sender as TDButton do begin
      idx := _Max(Tag + 0 * 10, 0);
      if idx < g_ShopItemList.Count then begin
         pm := pTShopInfo (g_ShopItemList[idx]);
         icon := pm.StdItem.Looks;
         if icon >= 0 then begin //�������� ���°�..
               d := g_WBagItemImages.Images[icon];
               if d <> nil then
                  dsurface.Draw (SurfaceX(Left+(50-d.Width) div 2), SurfaceY(Top + (50 - d.Height) div 2), d.ClientRect, d, TRUE);
         end;
      end;
   end;
end;

procedure TFrmDlg.DShopNextClick(Sender: TObject; X, Y: Integer);
var
 msg: TDefaultMessage;
 I: Integer;
begin
if Sender = DShopPrev then begin
  if g_ShopPage > 0 then begin
     Dec (g_ShopPage);
     for I:=0 to g_ShopItemList.Count - 1  do begin  //20080718�ͷ��ڴ�
      if PTShopInfo(g_ShopItemList.Items[i]) <> nil then
       Dispose(PTShopInfo(g_ShopItemList.Items[i]));
     end;
     g_ShopItemList.Clear;
     msg := MakeDefaultMsg (CM_OPENSHOP, 0, g_ShopPage{ҳ��}, g_ShopTypePage{ShopType}, 0, frmMain.Certification);
     FrmMain.SendSocket (EncodeMessage (msg));
  end;
end else begin
  if g_ShopPage < g_ShopReturnPage-1 then begin
     Inc (g_ShopPage);
     for I:=0 to g_ShopItemList.Count - 1  do begin  //20080718�ͷ��ڴ�
      if PTShopInfo(g_ShopItemList.Items[i]) <> nil then
       Dispose(PTShopInfo(g_ShopItemList.Items[i]));
     end;
     g_ShopItemList.Clear;
     msg := MakeDefaultMsg (CM_OPENSHOP, 0, g_ShopPage{ҳ��}, g_ShopTypePage{ShopType}, 0, frmMain.Certification);
     FrmMain.SendSocket (EncodeMessage (msg));
  end;
end;
end;

procedure TFrmDlg.DShopDecorateClick(Sender: TObject; X, Y: Integer);
    procedure ShopClear();
    begin
       DShopDecorate.SetImgIndex(g_Wmain3Images,-1);
       DShopSupplies.SetImgIndex(g_Wmain3Images,-1);
       DshopStrengthen.SetImgIndex(g_Wmain3Images,-1);
       DShopFriend.SetImgIndex(g_Wmain3Images,-1);
       DShopCapacity.SetImgIndex(g_Wmain3Images,-1);
       ShopIndex:=-1;
       g_ShopItemName:='';
    end;
var
 msg: TDefaultMessage;
 I: Integer;
begin
  ShopClear();
  for I:=0 to g_ShopItemList.Count - 1  do begin  //20080718�ͷ��ڴ�
    if PTShopInfo(g_ShopItemList.Items[i]) <> nil then
      Dispose(PTShopInfo(g_ShopItemList.Items[i]));
  end;
  g_ShopItemList.Clear;
  if Sender = DShopDecorate then begin
    DShopDecorate.SetImgIndex(g_Wmain3Images,299);
    msg := MakeDefaultMsg (CM_OPENSHOP, 0, 0{ҳ��}, 0{ShopType}, 0, frmMain.Certification);
    FrmMain.SendSocket (EncodeMessage (msg));
    g_ShopTypePage:=0;
    g_ShopPage:=0;
  end;
  if Sender = DShopSupplies then begin
    DShopSupplies.SetImgIndex(g_Wmain3Images,300);
        msg := MakeDefaultMsg (CM_OPENSHOP, 0, 0{ҳ��}, 1{ShopType}, 0, frmMain.Certification);
    FrmMain.SendSocket (EncodeMessage (msg));
    g_ShopTypePage:=1;
    g_ShopPage:=0;
  end;
  if Sender = DshopStrengthen then begin
    DshopStrengthen.SetImgIndex(g_Wmain3Images,301);
        msg := MakeDefaultMsg (CM_OPENSHOP, 0, 0{ҳ��}, 2{ShopType}, 0, frmMain.Certification);
    FrmMain.SendSocket (EncodeMessage (msg));
    g_ShopTypePage:=2;
    g_ShopPage:=0;
  end;
  if Sender = DShopFriend then begin
    DShopFriend.SetImgIndex(g_Wmain3Images,302);
        msg := MakeDefaultMsg (CM_OPENSHOP, 0, 0{ҳ��}, 3{ShopType}, 0, frmMain.Certification);
    FrmMain.SendSocket (EncodeMessage (msg));
    g_ShopTypePage:=3;
    g_ShopPage:=0;
  end;
  if Sender = DShopCapacity then begin
    DShopCapacity.SetImgIndex(g_Wmain3Images,303);
        msg := MakeDefaultMsg (CM_OPENSHOP, 0, 0{ҳ��}, 4{ShopType}, 0, frmMain.Certification);
    FrmMain.SendSocket (EncodeMessage (msg));
    g_ShopTypePage:=4;
    g_ShopPage:=0;
  end;
end;

procedure TFrmDlg.DShopImg1Click(Sender: TObject; X, Y: Integer);
begin
  ShopGifFrame:=0;
  ShopSpeciallyIndex:=-1;
  ShopIndex:=TDButton(Sender).Tag
end;
(*******************************************************************************
  ���� : TextOut�Զ����д��� (��ʱδ��)
  ���� : Itemstrorlist(str:string; WIDTH,HEIGH:integer);
  ���� : strΪ�������ַ���. ��Ҫ�����WIDTH���. HEIGH��Ҫ����ĸ߶�
*******************************************************************************)
procedure TFrmDlg.Itemstrorlist(str:string; WIDTH,HEIGH:integer);
var
   i, len, aline, n, MAXWIDTH,MAXEIGHS: integer;
    temp: string;
   loop: Boolean;
begin
   MAXWIDTH := WIDTH;
   MAXEIGHS := HEIGH;
   strorliscont := 0;
   n := 0;
   loop := TRUE;
  while loop do begin
   temp := '';
   i := 1;
   len := Length (str);
   while TRUE do begin
   if i > len then begin
        loop := FALSE;
        break;
        end;
         if byte (str[i]) >= MAXWIDTH then begin
            temp := temp + str[i];
            Inc (i);
            if i <= len then temp := temp + str[i]
            else begin
               loop := FALSE;
               break;
            end;
         end else
            temp := temp + str[i];

         aline := FrmMain.Canvas.TextWidth (temp);
         if aline > MAXWIDTH then begin
            strorlist[n] := temp;
            strorlistidx[n] := aline;
            Inc (strorliscont);
            Inc (n);
            if n >= MAXEIGHS then begin
            loop := FALSE;
               break;
            end;
            str := Copy (str, i+1, Len-i);
            temp := '';
            break;
         end;
         Inc (i);
      end;
      if temp <> '' then begin
         if n < MAXWIDTH then begin
            strorlist[n] := temp;
            strorlistidx[n] := FrmMain.Canvas.TextWidth (temp);
            Inc (strorliscont);
         end;
      end;
   end;
end;

procedure TFrmDlg.DShopBuyClick(Sender: TObject; X, Y: Integer);
var
 msg: TDefaultMessage;
begin
  if mrOk = FrmDlg.DMessageDlg ('�Ƿ�ȷ�Ϲ��� ' + g_ShopItemName+' ��', [mbOk, mbCancel]) then begin
  msg := MakeDefaultMsg (CM_BUYSHOPITEM, 0, 0, 0, 0, frmMain.Certification);
  FrmMain.SendSocket (EncodeMessage (msg)+EncodeString(g_ShopItemName));
  end;
end;

procedure TFrmDlg.DShopSpeciallyImg1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  icon,idx:integer;
  pm:pTShopInfo;
  d:TDirectDrawSurface;
begin
    with Sender as TDButton do begin
      idx := _Max(Tag-10, 0);
      if idx < g_ShopSpeciallyItemList.Count then begin
         pm := pTShopInfo (g_ShopSpeciallyItemList[idx]);
         icon := pm.StdItem.Looks;
         if icon >= 0 then begin //�������� ���°�..
               d := g_WBagItemImages.Images[icon];
               if d <> nil then
                  dsurface.Draw (SurfaceX(Left+(120 - d.Width) div 2), SurfaceY(Top + (31 - d.Height) div 2), d.ClientRect, d, TRUE);
         end;
      end;
   end;
end;

procedure TFrmDlg.DShopSpeciallyImg1Click(Sender: TObject; X, Y: Integer);
begin
  ShopGifFrame:=0;
  ShopIndex:=-1;
  ShopSpeciallyIndex:=TDButton(Sender).Tag-10;
end;
//Shop ��Ʒ������ʾ
procedure TFrmDlg.ShopGifInfo(dsurface: TDirectDrawSurface;dx,dy,ShopGifBegin,ShopGifEnd:integer);
var
  d:TDirectDrawSurface;
  img: integer;
begin
    if ShopGifEnd = 0 then begin
      d := g_WEffectImages.Images[380];
      if d <> nil then
      dsurface.Draw (dx, dy, d.ClientRect, d, true);
      Exit;
    end;
    ShopGifExplosionFrame:=ShopGifEnd-ShopGifBegin;
    if GetTickCount - ShopGifTime >  700 then
    begin
      ShopGifTime:=GetTickCount;
      inc(ShopGifFrame);
    end;

    if ShopGifFrame > ShopGifExplosionFrame then
      ShopGifFrame := 0;

      img:=ShopGifBegin+ShopGifFrame;
           d := g_WEffectImages.Images[img];
      if d <> nil then
      dsurface.Draw(dx,dy,d.ClientRect,d, False);
end;

procedure TFrmDlg.DShopPresentClick(Sender: TObject; X, Y: Integer);
var
  who: string;
  msg: TDefaultMessage;
begin
  if g_ShopItemName <> '' then begin
    DMessageDlg ('������ '+g_ShopItemName+' Ҫ���͵��������ƣ�', [mbOk, mbAbort]);
    who := Trim (DlgEditText);
      if who <> '' then begin
        msg := MakeDefaultMsg (CM_BUYSHOPITEMGIVE, 0, 0, 0, 0, frmMain.Certification);
        FrmMain.SendSocket(EncodeMessage(msg) + EncodeString(g_ShopItemName) + '/' + EncodeString(who) + '/' +EncodeString(g_MySelf.m_sUserName));
      end;
  end else begin
     DMessageDlg ('��ѡ��һ����Ʒ�������ͣ�', [mbOk]);
     end;
end;

procedure TFrmDlg.CharacterSrankingClick(Sender: TObject; X, Y: Integer);
begin
  DLevelOrder.Visible:=not DLevelOrder.Visible;
  LevelOrderPage := 0;
  LevelOrderPageChanged;
end;

procedure TFrmDlg.DLevelOrderCloseClick(Sender: TObject; X, Y: Integer);
begin
  DLevelOrder.Visible := False;
end;

procedure TFrmDlg.LevelOrderPageChanged;
begin
         DColonyHeroOrder.Visible := FALSE;  DWarriorOrder.Visible := FALSE;
         DWizerdOrder.Visible := FALSE;  DTaoistOrder.Visible := FALSE;
         DHeroAllOrder.Visible := FALSE;
         DWarriorHeroOrder.Visible := FALSE;
         DWizerdHeroOrder.Visible := FALSE;
         DTaoistHeroOrder.Visible := FALSE;
         DLevelOrderIndex.Visible := FALSE;
         DLevelOrderPrev.Visible := FALSE;
         DLevelOrderNext.Visible := FALSE;
         DLevelOrderLastPage.Visible := FALSE;
         DMyLevelOrder.Visible := FALSE;
         m_PlayObjectLevelList.Clear; //����ȼ�����
         m_WarrorObjectLevelList.Clear; //սʿ�ȼ�����
         m_WizardObjectLevelList.Clear; //��ʦ�ȼ�����
         m_TaoistObjectLevelList.Clear; //��ʿ�ȼ�����
         m_PlayObjectMasterList.Clear; //ͽ��������

         m_HeroObjectLevelList.Clear; //Ӣ�۵ȼ�����
         m_WarrorHeroObjectLevelList.Clear; //Ӣ��սʿ�ȼ�����
         m_WizardHeroObjectLevelList.Clear; //Ӣ�۷�ʦ�ȼ�����
         m_TaoistHeroObjectLevelList.Clear; //Ӣ�۵�ʿ�ȼ�����
   case LevelOrderPage of
      0: begin 
         DColonyHeroOrder.Visible := TRUE;  DWarriorOrder.Visible := TRUE;
         DWizerdOrder.Visible := TRUE;  DTaoistOrder.Visible := TRUE;
      end;
      1: begin
         DHeroAllOrder.Visible := TRUE;
         DWarriorHeroOrder.Visible := TRUE;
         DWizerdHeroOrder.Visible := TRUE;
         DTaoistHeroOrder.Visible := TRUE;
      end;
      2: begin
         DLevelOrderIndex.Visible := TRUE;
         DLevelOrderPrev.Visible := TRUE;
         DLevelOrderNext.Visible := TRUE;
         DLevelOrderLastPage.Visible := TRUE;
         DMyLevelOrder.Visible := TRUE;
      end;
      3: begin
         DLevelOrderIndex.Visible := TRUE;
         DLevelOrderPrev.Visible := TRUE;
         DLevelOrderNext.Visible := TRUE;
         DLevelOrderLastPage.Visible := TRUE;
         DMyLevelOrder.Visible := TRUE;
      end;
      4: begin
         DLevelOrderIndex.Visible := TRUE;
         DLevelOrderPrev.Visible := TRUE;
         DLevelOrderNext.Visible := TRUE;
         DLevelOrderLastPage.Visible := TRUE;
         DMyLevelOrder.Visible := TRUE;
      end;

   end;
end;

procedure TFrmDlg.DIndividualOrderClick(Sender: TObject; X, Y: Integer);
begin
   LevelOrderPage := TDButton(Sender).Tag;
   LevelOrderPageChanged;
   nLevelOrderSortTypePage := 0;
end;

procedure TFrmDlg.DHeroOrderClick(Sender: TObject; X, Y: Integer);
begin
   LevelOrderPage := TDButton(Sender).Tag;
   LevelOrderPageChanged;
   nLevelOrderSortTypePage := 1;
end;

procedure TFrmDlg.DLevelOrderDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
function GetSortList: TList;
  begin
    Result := nil;
    case nLevelOrderSortType of
      0: begin
          case nLevelOrderType of
            1: Result := m_PlayObjectLevelList;
            2: Result := m_WarrorObjectLevelList;
            3: Result := m_WizardObjectLevelList;
            4: Result := m_TaoistObjectLevelList;
          end;
        end;
      1: begin
          case nLevelOrderType of
            1: Result := m_HeroObjectLevelList;
            2: Result := m_WarrorHeroObjectLevelList;
            3: Result := m_WizardHeroObjectLevelList;
            4: Result := m_TaoistHeroObjectLevelList;
          end;
        end;
      2: begin
          Result := m_PlayObjectMasterList;
        end;
    end;
  end;
var
  d: TDirectDrawSurface;
  I: Integer;
  UserLevelSort: pTUserLevelSort;
  HeroLevelSort: pTHeroLevelSort;
  UserMasterSort: pTUserMasterSort;
  bbx,bby: Integer;
  List: TList;
begin
   List := GetSortList;
   with DLevelOrder do begin
      if WLib <> nil then begin //20080701
        d := WLib.Images[FaceIndex];
        if d <> nil then
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      case LevelOrderPage of
         2: begin
           d := g_WMain3Images.Images[423];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left+25), SurfaceY(Top+91), d.ClientRect, d, true);
         end;
         3: begin
           d := g_WMain3Images.Images[424];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left+25), SurfaceY(Top+91), d.ClientRect, d, true);
         end;
         4: begin
           d := g_WMain3Images.Images[425];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left+25), SurfaceY(Top+91), d.ClientRect, d, true);
         end;
      end;
    bbx:=left+20;
    bby:=top+120;
   end;
    with dsurface.Canvas do begin
      {$IF Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      {$IFEND}
      Font.Color := clWhite;
      if (List <> nil) and (List.Count > 0) then begin
        case nLevelOrderSortType of
         0: begin
             for I:= 0 to List.Count-1 do begin
                  if I = nLevelOrderIndex then
                   Font.Color := clYellow
                  else Font.Color := clWhite;
                  UserLevelSort := pTUserLevelSort (List[i]);
                  {$IF Version = 1}
                  TextOut (bbx + 35, bby + i*22,inttostr(UserLevelSort.nIndex));
                  TextOut (bbx + 95, bby + i*22,UserLevelSort.sChrName);
                  TextOut (bbx + 240, bby + i*22,inttostr(UserLevelSort.wLevel));
                  {$ELSE}
                  ClFunc.TextOut (dsurface, bbx + 35, bby + i*22, Font.Color, Inttostr(UserLevelSort.nIndex));
                  ClFunc.TextOut (dsurface, bbx + 95, bby + i*22, Font.Color, UserLevelSort.sChrName);
                  ClFunc.TextOut (dsurface, bbx + 240, bby + i*22, Font.Color, inttostr(UserLevelSort.wLevel));
                  {$IFEND}
             end;
         end;
         1: begin
             for I:= 0 to List.Count-1 do begin
              if I = nLevelOrderIndex then
               Font.Color := clYellow
               else Font.Color := clWhite;
               HeroLevelSort := pTHeroLevelSort (List[i]);
               {$IF Version = 1}
               TextOut (bbx + 18, bby + i*22,inttostr(HeroLevelSort.nIndex));
               TextOut (bbx + 50, bby + i*22,HeroLevelSort.sHeroName);
               TextOut (bbx + 145, bby + i*22,HeroLevelSort.sChrName);
               TextOut (bbx + 255, bby + i*22,inttostr(HeroLevelSort.wLevel));
               {$ELSE}
               ClFunc.TextOut (dsurface, bbx + 18, bby + i*22, Font.Color, inttostr(HeroLevelSort.nIndex));
               ClFunc.TextOut (dsurface, bbx + 50, bby + i*22, Font.Color, HeroLevelSort.sHeroName);
               ClFunc.TextOut (dsurface, bbx + 145, bby + i*22, Font.Color, HeroLevelSort.sChrName);
               ClFunc.TextOut (dsurface, bbx + 255, bby + i*22, Font.Color, inttostr(HeroLevelSort.wLevel));
               {$IFEND}
             end;
         end;
         2: begin
             for I:= 0 to List.Count-1 do begin
              if I = nLevelOrderIndex then
               Font.Color := clYellow
               else Font.Color := clWhite;
               UserMasterSort := pTUserMasterSort (List[i]);
               {$IF Version = 1}
               TextOut (bbx + 35, bby + i*22,inttostr(UserMasterSort.nIndex));
               TextOut (bbx + 95, bby + i*22,UserMasterSort.sChrName);
               TextOut (bbx + 240, bby + i*22,inttostr(UserMasterSort.nMasterCount));
               {$ELSE}
               ClFunc.TextOut (dsurface, bbx + 35, bby + i*22, Font.Color, inttostr(UserMasterSort.nIndex));
               ClFunc.TextOut (dsurface, bbx + 95, bby + i*22, Font.Color, UserMasterSort.sChrName);
               ClFunc.TextOut (dsurface, bbx + 240, bby + i*22, Font.Color, inttostr(UserMasterSort.nMasterCount));
               {$IFEND}
             end;
         end;
        end;
      end;
      Release;
    end;
end;

procedure TFrmDlg.DColonyHeroOrderClick(Sender: TObject; X, Y: Integer);
var
 msg: TDefaultMessage;
begin
  LevelOrderPage := 2;
  LevelOrderPageChanged;
  nLevelOrderTypePage := TDButton(Sender).Tag;
  if Sender = DColonyHeroOrder then msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, 0{nPage}, 0{nSortType}, 1{nType}, 0, frmMain.Certification);
  if Sender = DWarriorOrder then msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, 0{nPage}, 0{nSortType}, 2{nType}, 0, frmMain.Certification);
  if Sender = DWizerdOrder then msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, 0{nPage}, 0{nSortType}, 3{nType}, 0, frmMain.Certification);
  if Sender = DTaoistOrder then msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, 0{nPage}, 0{nSortType}, 4{nType}, 0, frmMain.Certification);
  FrmMain.SendSocket (EncodeMessage (msg));
end;

procedure TFrmDlg.DHeroAllOrderClick(Sender: TObject; X, Y: Integer);
var
 msg: TDefaultMessage;
begin
  LevelOrderPage := 3;
  LevelOrderPageChanged;
  nLevelOrderTypePage := TDButton(Sender).Tag;
  if Sender = DHeroAllOrder then msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, 0{nPage}, 1{nSortType}, 1{nType}, 0, frmMain.Certification);
  if Sender = DWarriorHeroOrder then msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, 0{nPage}, 1{nSortType}, 2{nType}, 0, frmMain.Certification);
  if Sender = DWizerdHeroOrder then msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, 0{nPage}, 1{nSortType}, 3{nType}, 0, frmMain.Certification);
  if Sender = DTaoistHeroOrder then msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, 0{nPage}, 1{nSortType}, 4{nType}, 0, frmMain.Certification);
  FrmMain.SendSocket (EncodeMessage (msg));
end;

procedure TFrmDlg.DMasterOrderClick(Sender: TObject; X, Y: Integer);
var
 msg: TDefaultMessage;
begin
  LevelOrderPage := 4;
  LevelOrderPageChanged;
  nLevelOrderSortTypePage := 2;
  msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, 0{nPage}, 2{nSortType}, 0{nType}, 0, frmMain.Certification);
  FrmMain.SendSocket (EncodeMessage (msg));
end;

procedure TFrmDlg.DMyLevelOrderClick(Sender: TObject; X, Y: Integer);
var
 msg: TDefaultMessage;
begin
  nLevelOrderIndex := 0;
  LevelOrderPageChanged;
  msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, -1{nPage}, nLevelOrderSortTypePage{nSortType}, nLevelOrderTypePage{nType}, 0, frmMain.Certification);
  FrmMain.SendSocket (EncodeMessage (msg));
end;

procedure TFrmDlg.DLevelOrderIndexClick(Sender: TObject; X, Y: Integer);
var
  msg: TDefaultMessage;
begin
  LevelOrderPageChanged;
  msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, 0{nPage}, nLevelOrderSortTypePage{nSortType}, nLevelOrderTypePage{nType}, 0, frmMain.Certification);
  FrmMain.SendSocket (EncodeMessage (msg));
end;

procedure TFrmDlg.DLevelOrderLastPageClick(Sender: TObject; X, Y: Integer);
var
  msg: TDefaultMessage;
begin
  LevelOrderPageChanged;
  msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, nLevelOrderTypePageCount-1{nPage}, nLevelOrderSortTypePage{nSortType}, nLevelOrderTypePage{nType}, 0, frmMain.Certification);
  FrmMain.SendSocket (EncodeMessage (msg));
end;

procedure TFrmDlg.DLevelOrderNextClick(Sender: TObject; X, Y: Integer);
var
  msg: TDefaultMessage;
begin
  if Sender = DLevelOrderNext then begin
    if nLevelOrderPage < nLevelOrderTypePageCount-1 then begin
    LevelOrderPageChanged;
    msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, nLevelOrderPage+1{nPage}, nLevelOrderSortTypePage{nSortType}, nLevelOrderTypePage{nType}, 0, frmMain.Certification);
    FrmMain.SendSocket (EncodeMessage (msg));
    end;
  end else begin
    if nLevelOrderPage > 0 then begin
    LevelOrderPageChanged;
    msg := MakeDefaultMsg (CM_QUERYUSERLEVELSORT, nLevelOrderPage-1{nPage}, nLevelOrderSortTypePage{nSortType}, nLevelOrderTypePage{nType}, 0, frmMain.Certification);
    FrmMain.SendSocket (EncodeMessage (msg));
    end;
  end;
end;

procedure TFrmDlg.DBottomMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  {g_nUserSelectName := 0; //20080302
  DScreen.ClearHint; }
end;

procedure TfrmDlg.MouseRightItem(WhoItemBag{˭�İ���},ACol,ARow:Integer);//�Ҽ���װ��
var
  idx, where: Integer;
begin
  case WhoItemBag of
    1: begin
        if g_MySelf = nil then exit;
        idx := ACol + ARow * DItemGrid.ColCount + 6;
        //g_nRightTempIdx := idx;    //20080229
        if idx in [6..MAXBAGITEM-1] then begin
          where := GetTakeOnPosition (g_ItemArr[idx].s.StdMode);
         case where of
           U_DRESS:begin //�·�
              if g_MySelf.m_btSex = 0 then
                 if g_ItemArr[idx].S.StdMode <> 10 then Exit;//Ů
              if g_MySelf.m_btSex = 1 then
                 if g_ItemArr[idx].S.StdMode <> 11 then Exit;//��
              g_boRightItem := TRUE;
              g_MovingItem.Index := idx;
              g_MovingItem.Item := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';  //20080229
              DSWWeaponClick(DSWDress,0,0);
              g_boRightItem := FALSE;

           end;
           U_WEAPON:begin //����
              g_boRightItem := TRUE;
              g_MovingItem.Index := idx;
              g_MovingItem.Item := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';  //20080229
              DSWWeaponClick(DSWWEAPON,0,0);
              g_boRightItem := FALSE;
           end;
           U_NECKLACE:begin //����
              g_boRightItem := TRUE;
              g_MovingItem.Index := idx;
              g_MovingItem.Item := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';   //20080229
              DSWWeaponClick(DSWNecklace,0,0);
              g_boRightItem := FALSE;
           end;
           U_RIGHTHAND:begin //����
              g_boRightItem := TRUE;
              g_MovingItem.Index := idx;
              g_MovingItem.Item := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';  //20080229
              DSWWeaponClick(DSWLight,0,0);
              g_boRightItem := FALSE;
           end;
           U_HELMET,U_ZHULI:begin  //ͷ��,���� 20080417
              g_boRightItem := TRUE;
              g_MovingItem.Index := idx;
              g_MovingItem.Item := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';   //20080229
              DSWWeaponClick(DSWHelmet,0,0);
              g_boRightItem := FALSE;
           end;
           U_RINGR,U_RINGL:begin  //�ҽ�ָ
              if g_UseItems[U_RINGR].s.Name = '' then begin
                g_boRightItem := TRUE;
                g_MovingItem.Index := idx;
                g_MovingItem.Item := g_ItemArr[idx];
                g_ItemArr[idx].S.Name := '';  //20080229
                DSWWeaponClick(DSWRingR,0,0);
              end else
                if g_UseItems[U_RINGL].s.Name = '' then begin
                  g_boRightItem := TRUE;
                  g_MovingItem.Index := idx;
                  g_MovingItem.Item := g_ItemArr[idx];
                  g_ItemArr[idx].S.Name := '';  //20080229
                  DSWWeaponClick(DSWRingL,0,0);
                end else
                  if not g_boRightItemRingEmpty then begin
                    g_boRightItem := TRUE;
                    g_MovingItem.Index := idx;
                    g_MovingItem.Item := g_ItemArr[idx];
                    g_ItemArr[idx].S.Name := '';  //20080229
                    DSWWeaponClick(DSWRingR,0,0);
                    g_boRightItemRingEmpty := True; //20080319
                  end else
                    if g_boRightItemRingEmpty then begin
                      g_boRightItem := TRUE;
                      g_MovingItem.Index := idx;
                      g_MovingItem.Item := g_ItemArr[idx];
                      g_ItemArr[idx].S.Name := '';  //20080229
                      DSWWeaponClick(DSWRingL,0,0);
                      g_boRightItemRingEmpty := False; //20080319
                    end;
                g_boRightItem := FALSE;     
              end;
           U_ARMRINGR,U_ARMRINGL:begin //��������
              if g_UseItems[U_ARMRINGR].s.Name = '' then begin
                g_boRightItem := TRUE;
                g_MovingItem.Index := idx;
                g_MovingItem.Item := g_ItemArr[idx];
                g_ItemArr[idx].S.Name := '';   //20080229
                DSWWeaponClick(DSWArmRingR,0,0);
              end else
                if g_UseItems[U_ARMRINGL].s.Name = '' then begin
                  g_boRightItem := TRUE;
                  g_MovingItem.Index := idx;
                  g_MovingItem.Item := g_ItemArr[idx];
                  g_ItemArr[idx].S.Name := '';  //20080229
                  DSWWeaponClick(DSWArmRingL,0,0);
                end else
                  if not g_boRightItemArmRingEmpty then begin
                    g_boRightItem := TRUE;
                    g_MovingItem.Index := idx;
                    g_MovingItem.Item := g_ItemArr[idx];
                    g_ItemArr[idx].S.Name := '';   //20080229
                    DSWWeaponClick(DSWArmRingR,0,0);
                    g_boRightItemArmRingEmpty := True;
                  end else
                    if g_boRightItemArmRingEmpty then begin
                      g_boRightItem := TRUE;
                      g_MovingItem.Index := idx;
                      g_MovingItem.Item := g_ItemArr[idx];
                      g_ItemArr[idx].S.Name := '';  //20080229
                      DSWWeaponClick(DSWArmRingL,0,0);
                      g_boRightItemArmRingEmpty := False;
                    end;
              g_boRightItem := FALSE;
           end;
           U_BUJUK:begin  //��
              if (g_ItemArr[idx].s.StdMode = 2) and (g_ItemArr[idx].s.AniCount <> 21) then Exit; //20080322 ����2����Ʒ.�һ�������.
              g_boRightItem := TRUE;
              g_MovingItem.Index := idx;
              g_MovingItem.Item := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';  //20080229
              DSWWeaponClick(DSWBujuk,0,0);
              g_boRightItem := FALSE;
           end;
           U_BELT:begin  //����
              g_boRightItem := TRUE;
              g_MovingItem.Index := idx;
              g_MovingItem.Item := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';   //20080229
              DSWWeaponClick(DSWBelt,0,0);
              g_boRightItem := FALSE;
           end;
           U_BOOTS:begin //Ь
              g_boRightItem := TRUE;
              g_MovingItem.Index := idx;
              g_MovingItem.Item := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';   //20080229
              DSWWeaponClick(DSWBoots,0,0);
              g_boRightItem := FALSE;
           end;
           U_CHARM:begin //��ʯ
              g_boRightItem := TRUE;
              g_MovingItem.Index := idx;
              g_MovingItem.Item := g_ItemArr[idx];
              g_ItemArr[idx].S.Name := '';  //20080229
              DSWWeaponClick(DSWCharm,0,0);
              g_boRightItem := FALSE;
           end;
        end;
      end;
    end;//1:begin
    2: begin //Ӣ��
        if g_HeroSelf = nil then exit;
        idx := ACol + ARow * DHeroItemGrid.ColCount;
        //g_nRightTempIdx := idx;
        if idx in [0..g_HeroBagCount-1] then begin
          where := GetTakeOnPosition (g_HeroItemArr[idx].s.StdMode);
         case where of
           U_DRESS:begin //�·�
              if g_HeroSelf.m_btSex = 0 then //����
                 if g_HeroItemArr[idx].S.StdMode <> 10 then Exit;//Ů
              if g_HeroSelf.m_btSex = 1 then //����
                 if g_HeroItemArr[idx].S.StdMode <> 11 then Exit;//��
              g_boHeroRightItem := TRUE;
              g_MovingHeroItem.Index := idx;
              g_MovingHeroItem.Item := g_HeroItemArr[idx];
              g_HeroItemArr[idx].S.Name := '';  //20080229
              DSHWeaponClick(DSHDress,0,0);
              g_boHeroRightItem := FALSE;
           end;
           U_WEAPON:begin //����
              g_boHeroRightItem := TRUE;
              g_MovingHeroItem.Index := idx;
              g_MovingHeroItem.Item := g_HeroItemArr[idx];
              g_HeroItemArr[idx].S.Name := '';  //20080229
              DSHWeaponClick(DSHWeapon,0,0);
              g_boHeroRightItem := FALSE;
           end;
           U_NECKLACE:begin //����
              g_boHeroRightItem := TRUE;
              g_MovingHeroItem.Index := idx;
              g_MovingHeroItem.Item := g_HeroItemArr[idx];
              g_HeroItemArr[idx].S.Name := ''; //20080229
              DSHWeaponClick(DSHNecklace,0,0);
              g_boHeroRightItem := FALSE;
           end;
           U_RIGHTHAND:begin //����
              g_boHeroRightItem := TRUE;
              g_MovingHeroItem.Index := idx;
              g_MovingHeroItem.Item := g_HeroItemArr[idx];
              g_HeroItemArr[idx].S.Name := ''; //20080229
              DSHWeaponClick(DSHLight,0,0);
              g_boHeroRightItem := FALSE;
           end;
           U_HELMET,U_ZHULI:begin  //ͷ��,���� 20080416
              g_boHeroRightItem := TRUE;
              g_MovingHeroItem.Index := idx;
              g_MovingHeroItem.Item := g_HeroItemArr[idx];
              g_HeroItemArr[idx].S.Name := '';  //20080229
              DSHWeaponClick(DSHHelmet,0,0);
              g_boHeroRightItem := FALSE;
           end;
           U_RINGR,U_RINGL:begin  //�ҽ�ָ
              if g_HeroItems[U_RINGR].s.Name = '' then begin
                g_boHeroRightItem := TRUE;
                g_MovingHeroItem.Index := idx;
                g_MovingHeroItem.Item := g_HeroItemArr[idx];
                g_HeroItemArr[idx].S.Name := '';  //20080229
                DSHWeaponClick(DSHRingR,0,0);
              end else
                if g_HeroItems[U_RINGL].s.Name = '' then begin
                  g_boHeroRightItem := TRUE;
                  g_MovingHeroItem.Index := idx;
                  g_MovingHeroItem.Item := g_HeroItemArr[idx];
                  g_HeroItemArr[idx].S.Name := '';  //20080229
                  DSHWeaponClick(DSHRingL,0,0);
                end else
                  if not g_boHeroRightItemRingEmpty then begin
                    g_boHeroRightItem := TRUE;
                    g_MovingHeroItem.Index := idx;
                    g_MovingHeroItem.Item := g_HeroItemArr[idx];
                    g_HeroItemArr[idx].S.Name := '';  //20080229
                    DSHWeaponClick(DSHRingR,0,0);
                    g_boHeroRightItemRingEmpty := True; //20080319
                  end else
                    if g_boHeroRightItemRingEmpty then begin
                      g_boHeroRightItem := TRUE;
                      g_MovingHeroItem.Index := idx;
                      g_MovingHeroItem.Item := g_HeroItemArr[idx];
                      g_HeroItemArr[idx].S.Name := '';  //20080229
                      DSHWeaponClick(DSHRingL,0,0);
                      g_boHeroRightItemRingEmpty := False; //20080319
                    end;
                g_boHeroRightItem := FALSE;     
              end;
           U_ARMRINGR,U_ARMRINGL:begin //��������
              if g_HeroItems[U_ARMRINGR].s.Name = '' then begin
                g_boHeroRightItem := TRUE;
                g_MovingHeroItem.Index := idx;
                g_MovingHeroItem.Item := g_HeroItemArr[idx];
                g_HeroItemArr[idx].S.Name := ''; //20080229
                DSHWeaponClick(DSHArmRingR,0,0);
              end else
                if g_HeroItems[U_ARMRINGL].s.Name = '' then begin
                  g_boHeroRightItem := TRUE;
                  g_MovingHeroItem.Index := idx;
                  g_MovingHeroItem.Item := g_HeroItemArr[idx];
                  g_HeroItemArr[idx].S.Name := ''; //20080229
                  DSHWeaponClick(DSHArmRingL,0,0);
                end else
                  if not g_boHeroRightItemArmRingEmpty then begin
                    g_boHeroRightItem := TRUE;
                    g_MovingHeroItem.Index := idx;
                    g_MovingHeroItem.Item := g_HeroItemArr[idx];
                    g_HeroItemArr[idx].S.Name := ''; //20080229
                    DSHWeaponClick(DSHArmRingR,0,0);
                    g_boHeroRightItemArmRingEmpty := True;
                  end else
                    if g_boHeroRightItemArmRingEmpty then begin
                      g_boHeroRightItem := TRUE;
                      g_MovingHeroItem.Index := idx;
                      g_MovingHeroItem.Item := g_HeroItemArr[idx];
                      g_HeroItemArr[idx].S.Name := ''; //20080229
                      DSHWeaponClick(DSHArmRingL,0,0);
                      g_boHeroRightItemArmRingEmpty := False;
                    end;
              g_boHeroRightItem := FALSE;
           end;
           U_BUJUK:begin  //��
              g_boHeroRightItem := TRUE;
              g_MovingHeroItem.Index := idx;
              g_MovingHeroItem.Item := g_HeroItemArr[idx];
              g_HeroItemArr[idx].S.Name := '';  //20080229
              DSHWeaponClick(DSHBujuk,0,0);
              g_boHeroRightItem := FALSE;
           end;
           U_BELT:begin  //����
              g_boHeroRightItem := TRUE;
              g_MovingHeroItem.Index := idx;
              g_MovingHeroItem.Item := g_HeroItemArr[idx];
              g_HeroItemArr[idx].S.Name := '';  //20080229
              DSHWeaponClick(DSHBelt,0,0);
              g_boHeroRightItem := FALSE;
           end;
           U_BOOTS:begin //Ь
              g_boHeroRightItem := TRUE;
              g_MovingHeroItem.Index := idx;
              g_MovingHeroItem.Item := g_HeroItemArr[idx];
              g_HeroItemArr[idx].S.Name := '';   //20080229
              DSHWeaponClick(DSHBoots,0,0);
              g_boHeroRightItem := FALSE;
           end;
           U_CHARM:begin //��ʯ
              g_boHeroRightItem := TRUE;
              g_MovingHeroItem.Index := idx;
              g_MovingHeroItem.Item := g_HeroItemArr[idx];
              g_HeroItemArr[idx].S.Name := '';   //20080229
              DSHWeaponClick(DSHCharm,0,0);
              g_boHeroRightItem := FALSE;
           end;
        end;
      end;
    end;//2 : begin
  end;//case WhoItemBag of
end;

{******************************************************************************}
//����ϵͳ
procedure TFrmDlg.DBoxsDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  Shape :integer;
begin
  with DBoxs do begin
      if DBoxs.FaceIndex = 510 then begin
          if WLib <> nil then begin //20080701
          d := WLib.Images[FaceIndex];
          if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;

    if g_boPutBoxsKey then begin
      if GetTickCount - g_dwBoxsTick > 200 then begin
        g_dwBoxsTick := GetTickCount;
        Inc(g_nBoxsImg);
        if g_nBoxsImg > 6 then begin
          g_nBoxsImg := 0;
          g_boPutBoxsKey := False;
          DBoxs.SetImgIndex(g_WMain3Images, 510);
          d := g_WMain3Images.Images[510];
          DBoxs.Left := SCREENWIDTH div 2- d.Width div 2;
          DBoxs.Top  := (SCREENHEIGHT - d.Height) div 2;
          d := g_WMain3Images.Images[510];
          if d <> nil then  
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, true);
          ShowBoxsGird(True); //��ʾ�����
          DBoxsTautology.Visible := True;
        end;
      end;
    end; //if g_boPutBoxsKey then begin

    if DBoxsBelt1.Visible then Exit;
    case g_EatingItem.s.Shape of
      1: Shape := 520;
      2: Shape := 540;
      3: Shape := 560;
      4: Shape := 580;
      5: Shape := 130;
    end;
    if Shape <> 130 then begin
      DBoxs.SetImgIndex(g_WMain3Images, Shape);
      d := g_WMain3Images.Images[Shape+g_nBoxsImg];
      if d <> nil then
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, true);
      d := g_WMain3Images.Images[Shape+7+g_nBoxsImg];
      if d <> nil then
        DrawBlend(dsurface,SurfaceX(Left), SurfaceY(Top), d, 1);
    end else begin
      DBoxs.SetImgIndex(g_WMain2Images, Shape);
      d := g_WMain2Images.Images[Shape+g_nBoxsImg];
      if d <> nil then
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, true);
      d := g_WMain2Images.Images[Shape+7+g_nBoxsImg];
      if d <> nil then
        DrawBlend(dsurface,SurfaceX(Left), SurfaceY(Top), d, 1);
    end;
 end;
end;

procedure TFrmDlg.DBoxsClick(Sender: TObject; X, Y: Integer);
var
  msg: TDefaultMessage;
begin
  if not DBoxsTautology.Visible then begin
    if (not g_boItemMoving) and (g_MovingItem.Item.s.Name = '') and (not g_boPutBoxsKey)then  begin
      AddItemBag (g_EatingItem);
      DBoxS.Visible := False;
      ShowBoxsGird(False); //��ʾ�����
      g_BoxsShowPosition := -1;
      Exit;
    end;
    if g_boItemMoving then begin
     if g_MovingItem.Item.s.Shape = g_EatingItem.s.AniCount then begin
        msg := MakeDefaultMsg (CM_OPENBOXS, g_EatingItem.MakeIndex, {g_MovingItem.Item.MakeIndex}0, 0, 0, frmMain.Certification);
        FrmMain.SendSocket (EncodeMessage (msg) + EncodeString({Inttostr(g_EatingItem.MakeIndex) + '/' + }Inttostr(g_MovingItem.Item.MakeIndex)));
        g_BoxsTempKeyItems := g_MovingItem.Item;  //��Կ�״�ŵ���ʱ��Ʒ     ʧ���򷵻�

        g_boItemMoving := false;
        g_MovingItem.Item.s.Name := '';  //��Կ�ױ�û
        g_MovingItem.Item.s.Shape := 0;  //��Կ�ױ�û

        g_boPutBoxsKey := True;

        g_BoxsCircleNum := 0;  //��ʼ��ת��Ȧ��
        //g_boBoxsMiddleItems := True; //��ʼ����ƷΪ�м�
        g_BoxsShowPosition := 8;

        g_BoxsFirstMove := False; //��ʼ����1��ת��
        g_BoxsMoveDegree := 0;  //��ʼ�� ת�̴���
        BoxsRandomImg;
        MyPlaySound(Openbox_ground);
        //DBoxsTautology.Visible := True;
     end;
    end;
  end;
end;

procedure TFrmDlg.ShowBoxsGird(Show: Boolean);
begin
   if Show then begin
      DBoxsBelt1.Visible := True;
      DBoxsBelt2.Visible := True;
      DBoxsBelt3.Visible := True;
      DBoxsBelt4.Visible := True;
      DBoxsBelt5.Visible := True;
      DBoxsBelt6.Visible := True;
      DBoxsBelt7.Visible := True;
      DBoxsBelt8.Visible := True;
      DBoxsBelt9.Visible := True;
   end else begin
      DBoxsBelt1.Visible := False;
      DBoxsBelt2.Visible := False;
      DBoxsBelt3.Visible := False;
      DBoxsBelt4.Visible := False;
      DBoxsBelt5.Visible := False;
      DBoxsBelt6.Visible := False;
      DBoxsBelt7.Visible := False;
      DBoxsBelt8.Visible := False;
      DBoxsBelt9.Visible := False;
   end;
end;

procedure TFrmDlg.DBoxsBelt5DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  idx: Integer;
  Butt:TDButton;
  Sel: Integer;
begin
  BoxsRunning(dsurface);//����ת��
  Butt:=TDButton(Sender);
  if Sender = DBoxsBelt1 then Sel := 0;
  if Sender = DBoxsBelt2 then Sel := 1;
  if Sender = DBoxsBelt3 then Sel := 2;
  if Sender = DBoxsBelt4 then Sel := 7;
  if Sender = DBoxsBelt5 then Sel := 8;
  if Sender = DBoxsBelt6 then Sel := 3;
  if Sender = DBoxsBelt7 then Sel := 6;
  if Sender = DBoxsBelt8 then Sel := 5;
  if Sender = DBoxsBelt9 then Sel := 4;
  with Butt do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
       if Sender = DBoxsBelt5 then begin
          d := g_Wmain3Images.Images[513];
          if d <> nil then
            dsurface.Draw (SurfaceX(Left-5), SurfaceY(Top-5), d.ClientRect, d, true);
       end;
    if g_BoxSItems[Sel].S.Name <> '' then begin
      if (g_BoxSItems[Sel].S.Name = g_sGameDiaMond) or (g_BoxSItems[Sel].S.Name = '����') or (g_BoxSItems[Sel].S.Name = '����') then begin
        if g_BoxSItems[Sel].S.Name = g_sGameDiaMond then idx := 1187;
        if g_BoxSItems[Sel].S.Name = '����' then idx := 1186;
        if g_BoxSItems[Sel].S.Name = '����' then idx := 1185;
      end else
      idx := g_BoxSItems[Sel].S.Looks;
      if idx >= 0 then begin
        if g_BoxsShowPosition = Butt.Tag then begin
            BoxsFlash(Butt, dsurface);

          d := g_WBagItemImages.Images[idx];
          if d <> nil then
          dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                         SurfaceY(Top + (Height - d.Height) div 2),
                         d.ClientRect, d, TRUE);
        end else begin
          d := g_WBagItemImages.Images[idx];
          if d <> nil then
          DrawBlendEx(dsurface,SurfaceX(Left + (Width - d.Width) div 2),
                       SurfaceY(Top + (Height - d.Height) div 2), d,0,0,d.Width,d.Height, 0);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBoxsBelt5MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  iname, d1, d2, d3: string;
  useable: Boolean;
  Sel: Integer;
  Butt:TDButton;
  pcm: pTBoxsInfo;
begin
   Sel := -1;
   Butt:=TDButton(Sender);

   if Sender = DBoxsBelt1 then Sel := 0;
   if Sender = DBoxsBelt2 then Sel := 1;
   if Sender = DBoxsBelt3 then Sel := 2;
   if Sender = DBoxsBelt4 then Sel := 7;
   if Sender = DBoxsBelt5 then Sel := 8;
   if Sender = DBoxsBelt6 then Sel := 3;
   if Sender = DBoxsBelt7 then Sel := 6;
   if Sender = DBoxsBelt8 then Sel := 5;
   if Sender = DBoxsBelt9 then Sel := 4;

   pcm := pTBoxsInfo(g_BoxsItemList[Sel]);



   if (g_BoxsItems[sel].s.Name = '����') or (g_BoxsItems[sel].s.Name = g_sGameDiaMond) or (g_BoxsItems[sel].s.Name = '����') then begin
      iname := g_BoxsItems[sel].s.Name + '\' + '����: '+IntToStr(pcm.nItemNum);
      if g_BoxsShowPosition = Butt.Tag then
        DScreen.ShowHint(Butt.SurfaceX(Butt.Left + Butt.Width), Butt.SurfaceY(Butt.Top), iname+ '\' + '(˫�����)', clYellow, FALSE)
      else
        DScreen.ShowHint(Butt.SurfaceX(Butt.Left + Butt.Width), Butt.SurfaceY(Butt.Top), iname, clWhite, FALSE);
      g_MouseItem.S.Name := '';
   end else begin
      g_MouseItem := g_BoxsItems[sel];
      GetMouseItemInfo (iname, d1, d2, d3, useable ,1);
      if g_BoxsShowPosition = Butt.Tag then
         DScreen.ShowHint(Butt.SurfaceX(Butt.Left + Butt.Width), Butt.SurfaceY(Butt.Top), iname + d1 + '\' + d2 + '\' + d3 + '\' + '(˫�����)', clYellow, FALSE)
      else
        DScreen.ShowHint(Butt.SurfaceX(Butt.Left + Butt.Width), Butt.SurfaceY(Butt.Top), iname + d1 + '\' + d2 + '\' + d3, clWhite, FALSE);
      g_MouseItem.S.Name := '';
  end;
end;

procedure TFrmDlg.DBoxsMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  DScreen.ClearHint;
end;

//������Ʒ��˸����
procedure TFrmDlg.BoxsFlash(Button: TDButton;dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
    if GetTickCount - g_dwBoxsFlashTick > 100 then begin
      g_dwBoxsFlashTick := GetTickCount;
      Inc(g_BoxsFlashImg);
      if g_BoxsFlashImg > 2 then g_BoxsFlashImg := 0;
    end;
    if g_BoxsFlashImg = 2 then Exit;
    d := g_WMain3Images.Images[g_BoxsbsImg+g_BoxsFlashImg];
    if d <> nil then
      DrawBlend(dsurface,Button.SurfaceX(Button.Left-10),Button.SurfaceY(Button.Top-11), d, 1);
end;
//������Ʒ���ȡͼ
procedure TFrmDlg.BoxsRandomImg;
var
    vList:   TList;
    I,   J:   Integer;
    vData:   Integer;
begin
   Randomize;   //�����������
    vList := TList.Create;
    try
      for I:=600 to 617 do vList.Add(Pointer(I));//�õ�һ��˳�����е��˿�
        for I:=1 to 8 do  //ȡ8����
          begin
              J := Random(vList.Count);  //�����µ��˿������ѡһ��
              vData := Integer(vList[J]);
              if vData= 601 then Continue;
              if vData= 603 then Continue;
              if vData= 605 then Continue;
              if vData= 607 then Continue;
              if vData= 609 then Continue;
              if vData= 611 then Continue;
              if vData= 613 then Continue;
              if vData= 615 then Continue;
              if vData= 617 then Continue;
              vList.Delete(J); //��ȡ�����б���ɾ��
              g_BoxsbsImg := vData;
              break;
          end;
    finally
        vList.Free;
    end;
end;

procedure TFrmDlg.DBoxsTautologyClick(Sender: TObject; X, Y: Integer);
var
  msg: TDefaultMessage;
  pcm: pTBoxsInfo;
begin
  BoxsRandomImg; //�任��ɫ
  pcm := pTBoxsInfo(g_BoxsItemList[0]);
  if g_BoxsMoveDegree >= pcm.nUses then
     DMessageDlg ('�����Ѿ��𻵣��޷��ٴ�����ת�̣�', [mbOk])
  else begin
    if not g_boBoxsShowPosition then begin
      if g_BoxsFirstMove then begin
        if mrOk = FrmDlg.DMessageDlg ('�Ƿ�ȷ��Ҫ�ٴ���������ת�̣����������Ҫ[��ң�'+IntToStr(g_BoxsGold)+']��Ԫ����['+IntToStr(g_BoxsGameGold)+'] ��', [mbOk, mbCancel]) then begin
          if (g_MySelf.m_nGameGold >= g_BoxsGameGold) and (g_MySelf.m_nGold >= g_BoxsGold) then begin
            msg := MakeDefaultMsg (CM_MOVEBOXS, 1, 0, 0, 0, frmMain.Certification);
            FrmMain.SendSocket (EncodeMessage (msg));
            g_boBoxsShowPosition := True;
            g_BoxsCircleNum := 0; //Ȧ����Ϊ0
            g_boBoxsMiddleItems := False; //��ʾ�м���Ʒ
            Inc(g_BoxsMoveDegree);
          end else DMessageDlg ('�����ϵĽ�һ���Ԫ������̫��Ŷ��', [mbOk]);
        end;
      end else begin
          msg := MakeDefaultMsg (CM_MOVEBOXS, 1, 0, 0, 0, frmMain.Certification);
          FrmMain.SendSocket (EncodeMessage (msg));
          g_boBoxsShowPosition := True;
          g_BoxsCircleNum := 0; //Ȧ����Ϊ0
          g_boBoxsMiddleItems := False; //��ʾ�м���Ʒ
          g_BoxsFirstMove := True;
          Inc(g_BoxsMoveDegree);
      end;
    end;
  end;
end;
//����ת��
procedure TFrmDlg.BoxsRunning(dsurface: TDirectDrawSurface);
begin
  if g_boBoxsShowPosition then begin
    if (g_BoxsCircleNum > 0) and (g_BoxsCircleNum < 9) then g_BoxsShowPositionTime := 50 else g_BoxsShowPositionTime := 400;
    if GetTickCount - g_BoxsShowPositionTick > g_BoxsShowPositionTime then begin
     g_BoxsShowPositionTick := GetTickCount;
     Inc(g_BoxsShowPosition);
      MyPlaySound (SelectBoxFlash_ground); //�㱦������
      if g_BoxsShowPosition > 7 then begin
        g_BoxsShowPosition := 0;
        Inc(g_BoxsCircleNum); //ת��Ȧ��
      end;
      if g_BoxsCircleNum = 9 then begin
        if g_BoxSItems[g_BoxsShowPosition].MakeIndex = g_BoxsMakeIndex then begin
          g_boBoxsShowPosition := False;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBoxsTautologyMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  DScreen.ShowHint(DBoxsTautology.SurfaceX(DBoxsTautology.Left)-62, DBoxsTautology.SurfaceY(DBoxsTautology.Top)-16, '����Ǭ��Ų�ƻ�ȡһ����Ȧ��Ʒ', clWhite, FALSE);
end;

procedure TFrmDlg.DBoxsBelt1DblClick(Sender: TObject);
var
  msg: TDefaultMessage;
begin
  if not g_boBoxsShowPosition then begin //ת��ֹͣ�С���
    if Sender = DBoxsBelt1 then begin
      if g_BoxSItems[0].s.Name <> '' then begin
        if g_BoxsShowPosition = 0 then begin
          msg := MakeDefaultMsg (CM_GETBOXS, 0, 0, 0, 0, frmMain.Certification);
          FrmMain.SendSocket (EncodeMessage (msg));
          DBoxS.Visible := False;   //���� ��������
          ShowBoxsGird(False); //��ʾ�����
          g_BoxsShowPosition := -1; //��ʼ��ת��λ��
          g_boBoxsShowPosition := False; //
        end;
      end;
    end;
    if Sender = DBoxsBelt2 then begin
      if g_BoxSItems[1].s.Name <> '' then begin
        if g_BoxsShowPosition = 1 then begin
          msg := MakeDefaultMsg (CM_GETBOXS, 0, 0, 0, 0, frmMain.Certification);
          FrmMain.SendSocket (EncodeMessage (msg));
          DBoxS.Visible := False;   //���� ��������
          ShowBoxsGird(False); //��ʾ�����
          g_BoxsShowPosition := -1; //��ʼ��ת��λ��
          g_boBoxsShowPosition := False; //
        end;
      end;
    end;
    if Sender = DBoxsBelt3 then begin
      if g_BoxSItems[2].s.Name <> '' then begin
        if g_BoxsShowPosition = 2 then begin
          msg := MakeDefaultMsg (CM_GETBOXS, 0, 0, 0, 0, frmMain.Certification);
          FrmMain.SendSocket (EncodeMessage (msg));
          DBoxS.Visible := False;   //���� ��������
          ShowBoxsGird(False); //��ʾ�����
          g_BoxsShowPosition := -1; //��ʼ��ת��λ��
          g_boBoxsShowPosition := False; //
        end;
      end;
    end;
    if Sender = DBoxsBelt4 then begin
      if g_BoxSItems[7].s.Name <> '' then begin
        if g_BoxsShowPosition = 7 then begin
          msg := MakeDefaultMsg (CM_GETBOXS, 0, 0, 0, 0, frmMain.Certification);
          FrmMain.SendSocket (EncodeMessage (msg));
          DBoxS.Visible := False;   //���� ��������
          ShowBoxsGird(False); //��ʾ�����
          g_BoxsShowPosition := -1; //��ʼ��ת��λ��
          g_boBoxsShowPosition := False; //
        end;
      end;
    end;
    if Sender = DBoxsBelt5 then begin    //�м���Ʒ
      if g_BoxSItems[8].s.Name <> '' then begin
        if g_BoxsMoveDegree = 0 then begin
          msg := MakeDefaultMsg (CM_GETBOXS, 0, 0, 0, 0, frmMain.Certification);
          FrmMain.SendSocket (EncodeMessage (msg));
          DBoxS.Visible := False;   //���� ��������
          ShowBoxsGird(False); //��ʾ�����
          g_BoxsShowPosition := -1; //��ʼ��ת��λ��
          g_boBoxsShowPosition := False; //
        end;
      end;
    end;
    if Sender = DBoxsBelt6 then begin
      if g_BoxSItems[3].s.Name <> '' then begin
        if g_BoxsShowPosition = 3 then begin
          msg := MakeDefaultMsg (CM_GETBOXS, 0, 0, 0, 0, frmMain.Certification);
          FrmMain.SendSocket (EncodeMessage (msg));
          DBoxS.Visible := False;   //���� ��������
          ShowBoxsGird(False); //��ʾ�����
          g_BoxsShowPosition := -1; //��ʼ��ת��λ��
          g_boBoxsShowPosition := False; //
        end;
      end;
    end;
    if Sender = DBoxsBelt7 then begin
      if g_BoxSItems[6].s.Name <> '' then begin
        if g_BoxsShowPosition = 6 then begin
          msg := MakeDefaultMsg (CM_GETBOXS, 0, 0, 0, 0, frmMain.Certification);
          FrmMain.SendSocket (EncodeMessage (msg));
          DBoxS.Visible := False;   //���� ��������
          ShowBoxsGird(False); //��ʾ�����
          g_BoxsShowPosition := -1; //��ʼ��ת��λ��
          g_boBoxsShowPosition := False; //
        end;
      end;
    end;
    if Sender = DBoxsBelt8 then begin
      if g_BoxSItems[5].s.Name <> '' then begin
        if g_BoxsShowPosition = 5 then begin
          msg := MakeDefaultMsg (CM_GETBOXS, 0, 0, 0, 0, frmMain.Certification);
          FrmMain.SendSocket (EncodeMessage (msg));
          DBoxS.Visible := False;   //���� ��������
          ShowBoxsGird(False); //��ʾ�����
          g_BoxsShowPosition := -1; //��ʼ��ת��λ��
          g_boBoxsShowPosition := False; //
        end;
      end;
    end;
    if Sender = DBoxsBelt9 then begin
      if g_BoxSItems[4].s.Name <> '' then begin
        if g_BoxsShowPosition = 4 then begin
          msg := MakeDefaultMsg (CM_GETBOXS, 0, 0, 0, 0, frmMain.Certification);
          FrmMain.SendSocket (EncodeMessage (msg));
          DBoxS.Visible := False;   //���� ��������
          ShowBoxsGird(False); //��ʾ�����
          g_BoxsShowPosition := -1; //��ʼ��ת��λ��
          g_boBoxsShowPosition := False; //
        end;
      end;
    end;
  end;
end;
{******************************************************************************}
procedure TFrmDlg.DLieDragonDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  d:=FrmMain.UiImages(1);//FrmMain.UiDXImageList.Items.Find('BookBkgnd').PatternSurfaces[0];
  if d<>nil then begin
     dsurface.Draw (DLieDragon.SurfaceX(DLieDragon.Left), DLieDragon.SurfaceY(DLieDragon.Top), d.ClientRect, d, TRUE);
  end;
  case g_LieDragonPage of
    0: begin
      d:=FrmMain.UiImages(8);//FrmMain.UiDXImageList.Items.Find('Books1').PatternSurfaces[0];
    if d<>nil then
       dsurface.Draw (DLieDragon.SurfaceX(DLieDragon.Left+43), DLieDragon.SurfaceY(DLieDragon.Top+30), d.ClientRect, d, TRUE);
    end;
    1: begin
      d:=FrmMain.UiImages(9);//FrmMain.UiDXImageList.Items.Find('Books2').PatternSurfaces[0];
    if d<>nil then
       dsurface.Draw (DLieDragon.SurfaceX(DLieDragon.Left+43), DLieDragon.SurfaceY(DLieDragon.Top+30), d.ClientRect, d, TRUE);
    end;
    2: begin
      d:=FrmMain.UiImages(10);//FrmMain.UiDXImageList.Items.Find('Books3').PatternSurfaces[0];
    if d<>nil then
       dsurface.Draw (DLieDragon.SurfaceX(DLieDragon.Left+43), DLieDragon.SurfaceY(DLieDragon.Top+30), d.ClientRect, d, TRUE);
    end;
    3: begin
      d:=FrmMain.UiImages(11);//FrmMain.UiDXImageList.Items.Find('Books4').PatternSurfaces[0];
    if d<>nil then
       dsurface.Draw (DLieDragon.SurfaceX(DLieDragon.Left+43), DLieDragon.SurfaceY(DLieDragon.Top+30), d.ClientRect, d, TRUE);
    end;
    4: begin
      d:=FrmMain.UiImages(12);//FrmMain.UiDXImageList.Items.Find('Books5').PatternSurfaces[0];
    if d<>nil then
       dsurface.Draw (DLieDragon.SurfaceX(DLieDragon.Left+43), DLieDragon.SurfaceY(DLieDragon.Top+30), d.ClientRect, d, TRUE);
    end;
  end;
end;

procedure TFrmDlg.DLieDragonCloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  if TDButton(Sender).Downed then begin
    d:=FrmMain.UiImages(2);//FrmMain.UiDXImageList.Items.Find('BookCloseDown').PatternSurfaces[0];
    if d<>nil then
      with TDButton(Sender) do
       dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end else begin
    d:=FrmMain.UiImages(3);//FrmMain.UiDXImageList.Items.Find('BookCloseNormal').PatternSurfaces[0];
    if d<>nil then
      with TDButton(Sender) do
       dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;
end;

procedure TFrmDlg.DLieDragonCloseClick(Sender: TObject; X, Y: Integer);
begin
  DLieDragon.Visible := False;
end;

procedure TFrmDlg.DLieDragonNextPageDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  if TDButton(Sender).Downed then begin
    d:=FrmMain.UiImages(4);//FrmMain.UiDXImageList.Items.Find('BookNextPageDown').PatternSurfaces[0];
    if d<>nil then
      with TDButton(Sender) do
       dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end else begin
    d:=FrmMain.UiImages(5);//FrmMain.UiDXImageList.Items.Find('BookNextPageNormal').PatternSurfaces[0];
    if d<>nil then
      with TDButton(Sender) do
       dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;
end;

procedure TFrmDlg.DLieDragonPrevPageDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  if TDButton(Sender).Downed then begin
    d:=FrmMain.UiImages(6);//FrmMain.UiDXImageList.Items.Find('BookPrevPageDown').PatternSurfaces[0];
    if d<>nil then
      with TDButton(Sender) do
       dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end else begin
    d:=FrmMain.UiImages(7);//FrmMain.UiDXImageList.Items.Find('BookPrevPageNormal').PatternSurfaces[0];
    if d<>nil then
      with TDButton(Sender) do
       dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;
end;

procedure TFrmDlg.DLieDragonNextPageClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DLieDragonNextPage then begin
     Inc (g_LieDragonPage);
     if g_LieDragonPage > 0 then DLieDragonPrevPage.Visible := True;
     if g_LieDragonPage >= 4 then begin
       DLieDragonNextPage.Visible := False;
       DGoToLieDragon.Visible := True;
     end;
  end else begin
     Dec (g_LieDragonPage);
     if g_LieDragonPage < 4 then begin
       DLieDragonNextPage.Visible := True;
       DGoToLieDragon.Visible := False;
       if g_LieDragonPage <= 0 then DLieDragonPrevPage.Visible := False;
     end;
  end;
end;

procedure TFrmDlg.DGoToLieDragonDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  if TDButton(Sender).Downed then begin
    d:=FrmMain.UiImages(13);//FrmMain.UiDXImageList.Items.Find('CommandDown').PatternSurfaces[0];
    if d<>nil then
      with TDButton(Sender) do
       dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end else begin
    d:=FrmMain.UiImages(14);//FrmMain.UiDXImageList.Items.Find('CommandNormal').PatternSurfaces[0];
    if d<>nil then
      with TDButton(Sender) do
       dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;     
end;

procedure TFrmDlg.DLieDragonNpcDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  case g_LieDragonNpcIndex of
    1: begin
      d:=FrmMain.UiImages(15);//FrmMain.UiDXImageList.Items.Find('BooksNpc1').PatternSurfaces[0];
      if d<>nil then
         dsurface.Draw (DLieDragonNpc.SurfaceX(DLieDragonNpc.Left), DLieDragonNpc.SurfaceY(DLieDragonNpc.Top), d.ClientRect, d, TRUE);
    end;
    2: begin
      d:=FrmMain.UiImages(16);//FrmMain.UiDXImageList.Items.Find('BooksNpc2').PatternSurfaces[0];
      if d<>nil then
         dsurface.Draw (DLieDragonNpc.SurfaceX(DLieDragonNpc.Left), DLieDragonNpc.SurfaceY(DLieDragonNpc.Top), d.ClientRect, d, TRUE);
    end;
    3: begin
      d:=FrmMain.UiImages(17);//FrmMain.UiDXImageList.Items.Find('BooksNpc3').PatternSurfaces[0];
      if d<>nil then
         dsurface.Draw (DLieDragonNpc.SurfaceX(DLieDragonNpc.Left), DLieDragonNpc.SurfaceY(DLieDragonNpc.Top), d.ClientRect, d, TRUE);
    end;
    4: begin
      d:=FrmMain.UiImages(18);//FrmMain.UiDXImageList.Items.Find('BooksNpc4').PatternSurfaces[0];
      if d<>nil then
         dsurface.Draw (DLieDragonNpc.SurfaceX(DLieDragonNpc.Left), DLieDragonNpc.SurfaceY(DLieDragonNpc.Top), d.ClientRect, d, TRUE);
    end;
    5: begin
      d:=FrmMain.UiImages(19);//FrmMain.UiDXImageList.Items.Find('BooksNpc5').PatternSurfaces[0];
      if d<>nil then
         dsurface.Draw (DLieDragonNpc.SurfaceX(DLieDragonNpc.Left), DLieDragonNpc.SurfaceY(DLieDragonNpc.Top), d.ClientRect, d, TRUE);
    end;
  end;
end;

procedure TFrmDlg.DLieDragonNpcCloseClick(Sender: TObject; X, Y: Integer);
begin
  DLieDragonNpc.Visible := False;
end;

procedure TFrmDlg.DGoToLieDragonClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.SendMerchantDlgSelect (g_nCurMerchant, '@goHero1');
  DLieDragon.Visible := False;
end;

procedure TFrmDlg.DItemsUpButMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  DScreen.ShowHint(DItemsUpBut.SurfaceX(DItemsUpBut.Left), DItemsUpBut.SurfaceY(DItemsUpBut.Top + DItemsUpBut.Height), '����װ��', clWhite, FALSE);
end;

procedure TFrmDlg.DItemsUpButClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DItemsUpBut then
    DItemsUp.Visible := True
  else DItemsUp.Visible := False;
end;

procedure TFrmDlg.DItemBagMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DCIDSpleenDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
//var
  //d: TDirectDrawSurface;
begin
{  d:=FrmMain.UiDXImageList.Items.Find('vigourbar1').PatternSurfaces[0];
  if d<>nil then begin
     dsurface.Draw (DCIDSpleen.SurfaceX(DCIDSpleen.Left), DCIDSpleen.SurfaceY(DCIDSpleen.Top), d.ClientRect, d, TRUE);
  end;   }
end;

procedure TFrmDlg.DButton4DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
//var
 // d: TDirectDrawSurface;
 // rc:Trect;
begin
  {d := FrmMain.UiDXImageList.Items.Find('vigourbar2').PatternSurfaces[0];
  rc := d.ClientRect;
  if d <> nil then begin
     rc.Top := Round(rc.Bottom / nMaxDragonPoint * (nMaxDragonPoint - m_nDragonPoint));
     dsurface.Draw (DCIDSpleen.Left + rc.Left, DCIDSpleen.Top+DBottom.top+rc.Top, rc, d, FALSE);
  end;
  if g_boHintDragonPoint then begin  //20080401
    with dsurface.Canvas do begin
      SetBkMode (Handle, TRANSPARENT);
      BoldTextOut(dsurface,86- TextWidth(IntToStr(m_nDragonPoint)+'/'+IntToStr(nMaxDragonPoint)) div 2, SCREENHEIGHT - 120, clWhite, clBlack,IntToStr(m_nDragonPoint)+'/'+IntToStr(nMaxDragonPoint));
      Release;
    end;
  end;  }//20080619
end;

procedure TFrmDlg.RefuseCRYClick(Sender: TObject; X, Y: Integer);
begin
  if g_RefuseCRY then begin
      RefuseCRY.SetImgIndex(g_WMain3Images,283);
      g_RefuseCRY:=false;
      FrmMain.SendSay ('@��ֹ����');
  end else begin
      RefuseCRY.SetImgIndex(g_WMain3Images,282);
      g_RefuseCRY:=true;
      FrmMain.SendSay ('@��ֹ����');
  end;
end;

procedure TFrmDlg.AutoCRYClick(Sender: TObject; X, Y: Integer);
begin
  g_boAutoTalk := not g_boAutoTalk;
  if g_boAutoTalk then begin
     AutoCRY.SetImgIndex(g_WMain3Images,289);
     g_sAutoTalkStr := PlayScene.EdChat.Text;
     DScreen.AddChatBoardString('[�������Զ��������ܣ�������е������Ѽ�¼Ϊ��������]', GetRGB(219), clWhite)
  end else begin
     AutoCRY.SetImgIndex(g_WMain3Images,288);
     g_sAutoTalkStr := '';
     DScreen.AddChatBoardString('[�Զ����������ѹر�]', GetRGB(219), clWhite)
  end;
end;

//��Ʒ����任���� 20080223
procedure TFrmDlg.ItemLightTimeImg();
begin
    if GetTickCount - ItemLightTimeTick > 200 then begin
     ItemLightTimeTick := GetTickCount;
     Inc(ItemLightImgIdx);
    if ItemLightImgIdx > 5 then ItemLightImgIdx := 0;
    end;
end;

procedure TFrmDlg.DHelpDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if d.WLib <> nil then begin //20080701
        if not d.Downed then begin
           dd := d.WLib.Images[d.FaceIndex];
           if dd <> nil then
              dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
        end else begin
           dd := d.WLib.Images[d.FaceIndex+2];
           if dd <> nil then
              dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
        end;
      end;
   end;
end;



procedure TFrmDlg.DGameGirdExchangeDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  if TDButton(Sender).Downed then begin
    d:=FrmMain.UiImages(23);//FrmMain.UiDXImageList.Items.Find('BuyLingfuDown').PatternSurfaces[0];
    if d<>nil then
      with TDButton(Sender) do
       dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end else begin
    d:=FrmMain.UiImages(24);//FrmMain.UiDXImageList.Items.Find('BuyLingfuNormal').PatternSurfaces[0];
    if d<>nil then
      with TDButton(Sender) do
       dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;
end;

procedure TFrmDlg.DGameGirdExchangeClick(Sender: TObject; X, Y: Integer);
var
  int, i: Integer;
begin
    int := 0;
    DMessageDlg ('��������ֵ,ֻ��Ϊ����,���4λ����', [mbOk, mbAbort]);
    if DlgEditText = '' then int := 1;
    for i:=1 to length(DlgEditText) do
      if (DlgEditText[i] <'0') or ( DlgEditText[i] > '9') then int := 2;
    if length(DlgEditText) >4 then int := 3;
    if int = 0 then begin
      g_BuyGameGirdNum := StrToInt(DlgEditText);
      FrmMain.SendBuyGameGird(g_BuyGameGirdNum); //������Ϣ
    end else DMessageDlg ('���������ֵ����ȷ�����������룡', [mbOk]);
end;

//�õ����а���������  20080304
procedure TFrmDlg.DLevelOrderClick(Sender: TObject; X, Y: Integer);
function GetSortList: TList;
  begin
    Result := nil;
    case nLevelOrderSortType of
      0: begin
          case nLevelOrderType of
            1: Result := m_PlayObjectLevelList;
            2: Result := m_WarrorObjectLevelList;
            3: Result := m_WizardObjectLevelList;
            4: Result := m_TaoistObjectLevelList;
          end;
        end;
      1: begin
          case nLevelOrderType of
            1: Result := m_HeroObjectLevelList;
            2: Result := m_WarrorHeroObjectLevelList;
            3: Result := m_WizardHeroObjectLevelList;
            4: Result := m_TaoistHeroObjectLevelList;
          end;
        end;
      2: begin
          Result := m_PlayObjectMasterList;
        end;
    end;
  end;
var
  lx,ly: Integer;
  List: TList;
  idx: Integer;
  UserLevelSort: pTUserLevelSort;
  HeroLevelSort: pTHeroLevelSort;
  UserMasterSort: pTUserMasterSort;
begin
   lx := DLevelOrder.LocalX (X) - DLevelOrder.Left;
   ly := DLevelOrder.LocalY (Y) - DLevelOrder.Top;
   List := GetSortList;
   case nLevelOrderSortType of
     0: begin
        if (lx >= 24) and (lx <= 304) and (ly >= 118) and (ly <= 330){���� 2008.02.13} then begin
          idx := (ly-118) div 22;
          if List <> nil then begin
            if idx < List.Count then begin
               PlaySound (s_glass_button_click);
               nLevelOrderIndex := idx;
               UserLevelSort := pTUserLevelSort (List[idx]);
               PlayScene.EdChat.Visible := TRUE;
               PlayScene.EdChat.Text := '/'+ UserLevelSort.sChrName+' ';
               PlayScene.EdChat.SetFocus;
               SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
               PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
            end;
          end;
        end;
     end;
     1: begin
        if (lx >= 24) and (lx <= 304) and (ly >= 118) and (ly <= 330){���� 2008.02.13} then begin
          idx := (ly-118) div 22 + 0;
          if idx < List.Count then begin
             PlaySound (s_glass_button_click);
             nLevelOrderIndex := idx;
             HeroLevelSort := pTHeroLevelSort (List[idx]);
             PlayScene.EdChat.Visible := TRUE;
             PlayScene.EdChat.Text := '/'+ HeroLevelSort.sChrName+' ';
             PlayScene.EdChat.SetFocus;
             SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
             PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
          end;
        end;
     end;
     2: begin
        if (lx >= 24) and (lx <= 304) and (ly >= 118) and (ly <= 330){���� 2008.02.13} then begin
          idx := (ly-118) div 22 + 0;
          if idx < List.Count then begin
             PlaySound (s_glass_button_click);
             nLevelOrderIndex := idx;
             UserMasterSort := pTUserMasterSort (List[idx]);
             PlayScene.EdChat.Visible := TRUE;
             PlayScene.EdChat.Text := '/'+ UserMasterSort.sChrName+' ';
             PlayScene.EdChat.SetFocus;
             SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
             PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
          end;
        end;
     end;
   end; //case
end;
{******************************************************************************}
//Ԫ��������ʾ���� 20080316
procedure TFrmDlg.ShowShopSellOffDlg;
begin
   DWSEllOff.Visible := TRUE;
   DMenuDlg.Visible := FALSE;
   DItemBag.Visible := TRUE;
   LastestClickTime := GetTickCount;
   g_sSellPriceStr := '';
   g_SellOffName := '';
   g_SellOffGameGold := 0;
   g_SellOffGameDiaMond := 0;
   //g_boSellOffEnd := False;
end;
procedure TFrmDlg.DSellOffCloseClick(Sender: TObject; X, Y: Integer);
begin
   FrmMain.SendCancelSellOffItem;
   g_SellOffName := '';//���۶Է�����
   g_SellOffGameGold := 0; //���۵�Ԫ������
   g_SellOffGameDiaMond := 0;
   DWSEllOff.Visible := False;
   ArrangeItembag;
end;

procedure TFrmDlg.DSellOffItemGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
begin
   idx := ACol + ARow * DDGrid.ColCount;
   if idx in [0..8] then begin
      g_MouseItem := g_SellOffItems[idx];
   end;
end;

procedure TFrmDlg.DSellOffItemGridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DSellOffItemGrid.ColCount;
   if idx in [0..8] then begin
      if g_SellOffItems[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_SellOffItems[idx].S.Looks];
         if d <> nil then
            with DSellOffItemGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DSellOffItemGridGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   mi, idx, i: integer;
   int: Byte;
begin
  idx := ACol + ARow * DSellOffItemGrid.ColCount;  //����
  if not g_boItemMoving then begin   //��������ƶ���Ʒ  ��ôѡ���������Ʒ
     if idx in [0..8] then begin
        if g_SellOffItems[idx].S.Name <> '' then begin
           g_boItemMoving := TRUE;
           g_MovingItem.Index := -idx - 30;
           g_MovingItem.Item := g_SellOffItems[idx];
           g_SellOffItems[idx].S.Name := '';
           ItemClickSound (g_MovingItem.Item.S);
        end;
     end else begin
        if idx = 9 then begin
            int := 0;
            DMessageDlg ('������'+g_sGameDiaMond+'��������0-9999֮��', [mbOk, mbAbort]);
            if DlgEditText = '' then int := 1;
            for i:=1 to length(DlgEditText) do
              if (DlgEditText[i] <'0') or ( DlgEditText[i] > '9') then int := 2;
            if length(DlgEditText) > 4 then int := 3;
            case int of
              0:g_SellOffGameDiaMond := StrToInt(DlgEditText);
              1:DMessageDlg ('���ݲ���Ϊ�գ�', [mbOk]);
              2:DMessageDlg ('�����'+g_sGameDiaMond+'����', [mbOk]);
              3:DMessageDlg (g_sGameDiaMond + '�������ܳ���4λ', [mbOk]);
            end;
        end;
     end;
  end else begin
     mi := g_MovingItem.Index;
     if idx in [0..8] then begin
       if (mi >= 0) or (mi <= -30) and (mi > -40) then begin
          ItemClickSound (g_MovingItem.Item.S);
          g_boItemMoving := FALSE;
          if mi >= 0 then begin
             g_SellOffDlgItem := g_MovingItem.Item;
             FrmMain.SendAddSellOffItem (g_SellOffDlgItem);  //����Ϣ
             //g_dwDealActionTick := GetTickCount + 4000;      //������� ��ʱ�����
          end else
             AddSellOffItem (g_MovingItem.Item);
          g_MovingItem.Item.S.name := '';
       end;
     end;
  end;
  ArrangeItemBag;
end;

procedure TFrmDlg.DWSellOffDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
  with DWSellOff do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;

    with dsurface.Canvas do begin
      {$IF Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clWhite;
      TextOut (Left + 174 - TextWidth('0') div 2, Top + 64, IntToStr(g_SellOffGameDiaMond));
      TextOut (Left + 158, Top + 78,g_sGameDiaMond);
      {$ELSE}
      ClFunc.TextOut (dsurface, Left + 174 - FrmMain.Canvas.TextWidth('0') div 2, Top + 64, clWhite, IntToStr(g_SellOffGameDiaMond));
      ClFunc.TextOut (dsurface, Left + 158, Top + 78, clWhite, g_sGameDiaMond);
      {$IFEND}
      Release;
    end;
  end;
end;



procedure TFrmDlg.DSellOffOkClick(Sender: TObject; X, Y: Integer);
var
   mi: integer;
begin
  FrmMain.SendSellOffEnd;
  if g_boItemMoving then begin
     mi := g_MovingItem.Index;
     if (mi <= -30) and (mi > -40) then begin
        AddSellOffItem (g_MovingItem.Item);
        g_boItemMoving := FALSE;
        g_MovingItem.Item.S.name := '';
     end;
  end;
end;

procedure TFrmDlg.DSellOffCancelClick(Sender: TObject; X, Y: Integer);
begin
   //if GetTickCount > g_dwDealActionTick then begin
      //CloseDealDlg;
      FrmMain.SendCancelSellOffItem;
      g_SellOffName := '';//���۶Է�����
      g_SellOffGameGold := 0; //���۵�Ԫ������
      g_SellOffGameDiaMond := 0;
      ArrangeItembag;
   //end;
end;
//��ʾ�����б���� 20080317
procedure TFrmDlg.ShowSellOffListDlg;
begin
   MenuIndex := -1;
   DMerchantDlg.Left := 0;
   DMerchantDlg.Top := 0;
   DMerchantDlg.Visible := TRUE;

   DWSellOffList.Left := 0;
   DWSellOffList.Top  := 176;
   DWSellOffList.Visible := TRUE;

   DSellOffListCancel.Visible := False;
   DSellOffBuyCancel.Visible := False;
   DSellOffBuy.Visible := False;

   DItemBag.Left := 440;
   DItemBag.Top := -25;
   DItemBag.Visible := TRUE;

   LastestClickTime := GetTickCount;
end;
{******************************************************************************}
procedure TFrmDlg.DEditSellOffNameClick(Sender: TObject; X, Y: Integer);
var
  int: Byte;
begin
    int := 0;
    DMessageDlg ('������Է�������', [mbOk, mbAbort]);
    if DlgEditText = '' then int := 1;
    if length(DlgEditText) > 14 then int := 2;
    case int of
      0:g_SellOffName := DlgEditText;
      1:DMessageDlg ('���ݲ���Ϊ�գ�', [mbOk]);
      2:DMessageDlg ('����ĶԷ����ִ���', [mbOk]);
    end;
end;

procedure TFrmDlg.DEditSellOffNumClick(Sender: TObject; X, Y: Integer);
var
  i: Integer;
  int: Byte;
begin
    int := 0;
    DMessageDlg ('������'+g_sGameGoldName+'����,���5λ����', [mbOk, mbAbort]);
    if DlgEditText = '' then int := 1;
    for i:=1 to length(DlgEditText) do
      if (DlgEditText[i] <'0') or ( DlgEditText[i] > '9') then int := 2;
    if length(DlgEditText) > 5 then int := 3;
    case int of
      0:g_SellOffGameGold := StrToInt(DlgEditText);
      1:DMessageDlg ('���ݲ���Ϊ�գ�', [mbOk]);
      2:DMessageDlg ('�����' + g_sGameGoldName + '����', [mbOk]);
      3:DMessageDlg (g_sGameGoldName + '�������ܳ���5λ', [mbOk]);
    end;
end;

procedure TFrmDlg.DEditSellOffNameDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  with DEditSellOffName do begin
     with dsurface.Canvas do begin
        {$IF Version = 1}
        SetBkMode (Handle, TRANSPARENT);
        Font.Color := clWhite;
        TextOut (SurfaceX(Left+1), SurfaceY(Top+3), g_SellOffName);
        {$ELSE}
        ClFunc.TextOut (dsurface, SurfaceX(Left+1), SurfaceY(Top+3), clWhite, g_SellOffName);
        {$IFEND}
        Release;
     end;
  end;
end;

procedure TFrmDlg.DEditSellOffNumDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  with DEditSellOffNum do begin
     with dsurface.Canvas do begin
        {$IF Version = 1}
        SetBkMode (Handle, TRANSPARENT);
        Font.Color := clWhite;
        TextOut (SurfaceX(Left+1), SurfaceY(Top+3), IntToStr(g_SellOffGameGold));
        {$ELSE}
        ClFunc.TextOut (dsurface, SurfaceX(Left+1), SurfaceY(Top+3), clWhite, IntToStr(g_SellOffGameGold));
        {$IFEND}
        Release;
     end;
  end;
end;

procedure TFrmDlg.DSellOffListColseClick(Sender: TObject; X, Y: Integer);
begin
  DWSellOffList.Visible := False;
end;

procedure TFrmDlg.DWSellOffListDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   str: string;
begin
  with DWSellOffList do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
    {$IF Version = 1}
    with dsurface.Canvas do begin
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clWhite;
      TextOut (Left + 18, Top + 12, '������ϸ');
      TextOut (Left + 180, Top + 12, '��Ʒ�б�');
      TextOut (Left + 18, Top + 32, '������ɫ��');
      TextOut (Left + 18, Top + 32 + 20 * 1, '�򷽽�ɫ��');
      TextOut (Left + 18, Top + 32 + 20 * 2, 'Ԫ��������');

      case g_SellOffInfo.nSellGold of
            0..9: Font.Color := clWhite;
          10..99: Font.Color := clYellow;
        100..999: Font.Color := clAqua;
      else Font.Color := clFuchsia;
      end;

      Font.Style := Font.Style + [fsBold];  //��������
      TextOut (Left + 78, Top + 32 + 20 * 2,IntToStr(g_SellOffInfo.nSellGold));
      Font.Style := Font.Style - [fsBold];  //����ȥ������
      Font.Color := clWhite;
      TextOut (Left + 18, Top + 32 + 20 * 3, '�ύ���ڣ�');
      TextOut (Left + 78, Top + 32 + 20 * 3,DateToStr(g_SellOffInfo.dSellDateTime));

      TextOut (Left + 18, Top + 32 + 20 * 4, '����״̬��');
      case g_SellOffInfo.N of
        0: str := '����';
        2: str := '���';
        3: str := '�Է�ȡ���չ�';
      end;
      TextOut (Left + 78, Top + 32 + 20 * 4,str);

      Font.Color := clLime;
      TextOut (Left + 78, Top + 32,g_SellOffInfo.sDealCharName);
      TextOut (Left + 78, Top + 32 + 20,g_SellOffInfo.sBuyCharName);
      Release;
    end;
    {$ELSE}
    with dsurface.Canvas do begin
      ClFunc.TextOut (dsurface, Left + 18, Top + 12, clWhite, '������ϸ');
      ClFunc.TextOut (dsurface, Left + 180, Top + 12, clWhite, '��Ʒ�б�');
      ClFunc.TextOut (dsurface, Left + 18, Top + 32, clWhite, '������ɫ��');
      ClFunc.TextOut (dsurface, Left + 18, Top + 32 + 20 * 1, clWhite, '�򷽽�ɫ��');
      ClFunc.TextOut (dsurface, Left + 18, Top + 32 + 20 * 2, clWhite, 'Ԫ��������');
      case g_SellOffInfo.nSellGold of
            0..9: Font.Color := clWhite;
          10..99: Font.Color := clYellow;
        100..999: Font.Color := clAqua;
      else Font.Color := clFuchsia;
      end;
      Font.Style := Font.Style + [fsBold];  //��������
      ClFunc.TextOut (dsurface, Left + 78, Top + 32 + 20 * 2, Font.Color, IntToStr(g_SellOffInfo.nSellGold));
      Font.Style := Font.Style - [fsBold];  //����ȥ������
      Font.Color := clWhite;
      ClFunc.TextOut (dsurface, Left + 18, Top + 32 + 20 * 3, Font.Color, '�ύ���ڣ�');
      ClFunc.TextOut (dsurface, Left + 78, Top + 32 + 20 * 3, Font.Color, DateToStr(g_SellOffInfo.dSellDateTime));
      ClFunc.TextOut (dsurface, Left + 18, Top + 32 + 20 * 4, Font.Color, '����״̬��');
      case g_SellOffInfo.N of
        0: str := '����';
        2: str := '���';
        3: str := '�Է�ȡ���չ�';
      end;
      ClFunc.TextOut (dsurface, Left + 78, Top + 32 + 20 * 4, Font.Color, str);
      Font.Color := clLime;
      ClFunc.TextOut (dsurface, Left + 78, Top + 32, Font.Color, g_SellOffInfo.sDealCharName);
      ClFunc.TextOut (dsurface, Left + 78, Top + 32 + 20, Font.Color, g_SellOffInfo.sBuyCharName);
      Release;
    end;
    {$IFEND}
  end;
end;

procedure TFrmDlg.DSellOffItem0DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  idx: Integer;
begin
  if Sender = DSellOffItem0 then begin
    if g_SellOffInfo.UseItems[0].S.Name <> '' then begin
      idx := g_SellOffInfo.UseItems[0].s.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        with DSellOffItem0 do begin
          if d <> nil then
              dsurface.StretchDraw (Rect(SurfaceX(Left), SurfaceY(Top), SurfaceX(Left + 16), SurfaceY(Top + 16)), d.ClientRect,d, True);
          with dsurface.Canvas do begin
            {$IF Version = 1}
            SetBkMode (Handle, TRANSPARENT);
            {$IFEND}
            if g_SellOffItemIndex = 0 then Font.Color := clRed else
              Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (SurfaceX(Left) + 17, SurfaceY(Top) + 2,  g_SellOffInfo.UseItems[0].s.Name);
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left) + 17, SurfaceY(Top) + 2, Font.Color, g_SellOffInfo.UseItems[0].s.Name);
            {$IFEND}
            Release;
          end;
        end;
      end;
    end;
  end;

  if Sender = DSellOffItem1 then begin
    if g_SellOffInfo.UseItems[1].S.Name <> '' then begin
      idx := g_SellOffInfo.UseItems[1].s.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        with DSellOffItem1 do begin
          if d <> nil then
              dsurface.StretchDraw (Rect(SurfaceX(Left), SurfaceY(Top), SurfaceX(Left + 16), SurfaceY(Top + 16)), d.ClientRect,d, True);
          with dsurface.Canvas do begin
            {$IF Version = 1}
            SetBkMode (Handle, TRANSPARENT);
            {$IFEND}
            if g_SellOffItemIndex = 1 then Font.Color := clRed else
              Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (SurfaceX(Left) + 17, SurfaceY(Top) + 2,  g_SellOffInfo.UseItems[1].s.Name);
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left) + 17, SurfaceY(Top) + 2, Font.Color, g_SellOffInfo.UseItems[1].s.Name);
            {$IFEND}
            Release;
          end;
        end;
      end;
    end;
  end;

  if Sender = DSellOffItem2 then begin
    if g_SellOffInfo.UseItems[2].S.Name <> '' then begin
      idx := g_SellOffInfo.UseItems[2].s.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        with DSellOffItem2 do begin
          if d <> nil then
              dsurface.StretchDraw (Rect(SurfaceX(Left), SurfaceY(Top), SurfaceX(Left + 16), SurfaceY(Top + 16)), d.ClientRect,d, True);
          with dsurface.Canvas do begin
            {$IF Version = 1}
            SetBkMode (Handle, TRANSPARENT);
            {$IFEND}
            if g_SellOffItemIndex = 2 then Font.Color := clRed else
              Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (SurfaceX(Left) + 17, SurfaceY(Top) + 2,  g_SellOffInfo.UseItems[2].s.Name);
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left) + 17, SurfaceY(Top) + 2, Font.Color, g_SellOffInfo.UseItems[2].s.Name);
            {$IFEND}
            Release;
          end;
        end;
      end;
    end;
  end;

  if Sender = DSellOffItem3 then begin
    if g_SellOffInfo.UseItems[3].S.Name <> '' then begin
      idx := g_SellOffInfo.UseItems[3].s.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        with DSellOffItem3 do begin
          if d <> nil then
              dsurface.StretchDraw (Rect(SurfaceX(Left), SurfaceY(Top), SurfaceX(Left + 16), SurfaceY(Top + 16)), d.ClientRect,d, True);
          with dsurface.Canvas do begin
            {$IF Version = 1}
            SetBkMode (Handle, TRANSPARENT);
            {$IFEND}
            if g_SellOffItemIndex = 3 then Font.Color := clRed else
              Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (SurfaceX(Left) + 17, SurfaceY(Top) + 2,  g_SellOffInfo.UseItems[3].s.Name);
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left) + 17, SurfaceY(Top) + 2, Font.Color, g_SellOffInfo.UseItems[3].s.Name);
            {$IFEND}
           Release;
          end;
        end;
      end;
    end;
  end;

  if Sender = DSellOffItem4 then begin
    if g_SellOffInfo.UseItems[4].S.Name <> '' then begin
      idx := g_SellOffInfo.UseItems[4].s.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        with DSellOffItem4 do begin
          if d <> nil then
              dsurface.StretchDraw (Rect(SurfaceX(Left), SurfaceY(Top), SurfaceX(Left + 16), SurfaceY(Top + 16)), d.ClientRect,d, True);
          with dsurface.Canvas do begin
            {$IF Version = 1}
            SetBkMode (Handle, TRANSPARENT);
            {$IFEND}
            if g_SellOffItemIndex = 4 then Font.Color := clRed else
              Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (SurfaceX(Left) + 17, SurfaceY(Top) + 2,  g_SellOffInfo.UseItems[4].s.Name);
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left) + 17, SurfaceY(Top) + 2, Font.Color, g_SellOffInfo.UseItems[4].s.Name);
            {$IFEND}
            Release;
          end;
        end;
      end;
    end;
  end;

  if Sender = DSellOffItem5 then begin
    if g_SellOffInfo.UseItems[5].S.Name <> '' then begin
      idx := g_SellOffInfo.UseItems[5].s.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        with DSellOffItem5 do begin
          if d <> nil then
              dsurface.StretchDraw (Rect(SurfaceX(Left), SurfaceY(Top), SurfaceX(Left + 16), SurfaceY(Top + 16)), d.ClientRect,d, True);
          with dsurface.Canvas do begin
            {$IF Version = 1}
            SetBkMode (Handle, TRANSPARENT);
            {$IFEND}
            if g_SellOffItemIndex = 5 then Font.Color := clRed else
              Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (SurfaceX(Left) + 17, SurfaceY(Top) + 2,  g_SellOffInfo.UseItems[5].s.Name);
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left) + 17, SurfaceY(Top) + 2, Font.Color, g_SellOffInfo.UseItems[5].s.Name);
            {$IFEND}
            Release;
          end;
        end;
      end;
    end;
  end;

  if Sender = DSellOffItem6 then begin
    if g_SellOffInfo.UseItems[6].S.Name <> '' then begin
      idx := g_SellOffInfo.UseItems[6].s.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        with DSellOffItem6 do begin
          if d <> nil then
              dsurface.StretchDraw (Rect(SurfaceX(Left), SurfaceY(Top), SurfaceX(Left + 16), SurfaceY(Top + 16)), d.ClientRect,d, True);
          with dsurface.Canvas do begin
            {$IF Version = 1}
            SetBkMode (Handle, TRANSPARENT);
            {$IFEND}
            if g_SellOffItemIndex = 6 then Font.Color := clRed else
              Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (SurfaceX(Left) + 17, SurfaceY(Top) + 2,  g_SellOffInfo.UseItems[6].s.Name);
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left) + 17, SurfaceY(Top) + 2, Font.Color, g_SellOffInfo.UseItems[6].s.Name);
            {$IFEND}
            Release;
          end;
        end;
      end;
    end;
  end;

  if Sender = DSellOffItem7 then begin
    if g_SellOffInfo.UseItems[7].S.Name <> '' then begin
      idx := g_SellOffInfo.UseItems[7].s.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        with DSellOffItem7 do begin
          if d <> nil then
              dsurface.StretchDraw (Rect(SurfaceX(Left), SurfaceY(Top), SurfaceX(Left + 16), SurfaceY(Top + 16)), d.ClientRect,d, True);
          with dsurface.Canvas do begin
            {$IF Version = 1}
            SetBkMode (Handle, TRANSPARENT);
            {$IFEND}
            if g_SellOffItemIndex = 7 then Font.Color := clRed else
              Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (SurfaceX(Left) + 17, SurfaceY(Top) + 2,  g_SellOffInfo.UseItems[7].s.Name);
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left) + 17, SurfaceY(Top) + 2, Font.Color, g_SellOffInfo.UseItems[7].s.Name);
            {$IFEND}
            Release;
          end;
        end;
      end;
    end;
  end;

  if Sender = DSellOffItem8 then begin
    if g_SellOffInfo.UseItems[8].S.Name <> '' then begin
      idx := g_SellOffInfo.UseItems[8].s.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        with DSellOffItem8 do begin
          if d <> nil then
              dsurface.StretchDraw (Rect(SurfaceX(Left), SurfaceY(Top), SurfaceX(Left + 16), SurfaceY(Top + 16)), d.ClientRect,d, True);
          with dsurface.Canvas do begin
            {$IF Version = 1}
            SetBkMode (Handle, TRANSPARENT);
            {$IFEND}
            if g_SellOffItemIndex = 8 then Font.Color := clRed else
              Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (SurfaceX(Left) + 17, SurfaceY(Top) + 2,  g_SellOffInfo.UseItems[8].s.Name);
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left) + 17, SurfaceY(Top) + 2, Font.Color, g_SellOffInfo.UseItems[8].s.Name);
            {$IFEND}
            Release;
          end;
        end;
      end;
    end;
  end;

  if Sender = DSellOffItem9 then begin
    if g_SellOffInfo.UseItems[9].S.Name <> '' then begin
      idx := g_SellOffInfo.UseItems[9].s.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        with DSellOffItem9 do begin
          if d <> nil then
              dsurface.StretchDraw (Rect(SurfaceX(Left), SurfaceY(Top), SurfaceX(Left + 16), SurfaceY(Top + 16)), d.ClientRect,d, True);
          with dsurface.Canvas do begin
            {$IF Version = 1}
            SetBkMode (Handle, TRANSPARENT);
            {$IFEND}
            if g_SellOffItemIndex = 9 then Font.Color := clRed else
              Font.Color := clWhite;
            {$IF Version = 1}
            TextOut (SurfaceX(Left) + 17, SurfaceY(Top) + 2,  g_SellOffInfo.UseItems[9].s.Name);            
            {$ELSE}
            ClFunc.TextOut (dsurface, SurfaceX(Left) + 17, SurfaceY(Top) + 2, Font.Color, g_SellOffInfo.UseItems[9].s.Name);
            {$IFEND}
            Release;
          end;
        end;
      end;
    end;
  end;

end;

procedure TFrmDlg.DSellOffItem0Click(Sender: TObject; X, Y: Integer);
var
  iname, d1, d2, d3: string;
  useable: Boolean;
  sel: integer;
  Butt:TDButton;
begin
   g_SellOffItemIndex := TDButton(Sender).Tag;
    sel := -1;
   Butt:=TDButton(Sender);
   if Sender = DSellOffItem0 then sel := 0;
   if Sender = DSellOffItem1 then sel := 1;
   if Sender = DSellOffItem2 then sel := 2;
   if Sender = DSellOffItem3 then sel := 3;
   if Sender = DSellOffItem4 then sel := 4;
   if Sender = DSellOffItem5 then sel := 5;
   if Sender = DSellOffItem6 then sel := 6;
   if Sender = DSellOffItem7 then sel := 7;
   if Sender = DSellOffItem8 then sel := 8;
   if Sender = DSellOffItem9 then sel := 9;

   if (g_SellOffInfo.UseItems[sel].Dura = High(Word)) and (g_SellOffInfo.UseItems[sel].s.DuraMax = High(Word))
      and (Pos(g_sGameDiaMond,g_SellOffInfo.UseItems[sel].s.Name ) > 0)
      and (g_SellOffInfo.UseItems[sel].s.Price > 0)
      and (g_SellOffInfo.UseItems[sel].s.Looks = High(Word))then begin
      iname := g_sGameDiaMond + ' ���� '+IntToStr(g_SellOffInfo.UseItems[sel].s.Price) + ' ��';
      with Butt as TDButton do
        DScreen.ShowHint(Butt.SurfaceX(Butt.Left) + 115, Butt.SurfaceY(Butt.Top), iname, clWhite, FALSE);
        g_MouseItem.S.Name := '';
   end else begin
      //ԭΪע�͵� ��ʾ�������ϴ�����Ʒ��Ϣ
      g_MouseItem := g_SellOffInfo.UseItems[sel];
      GetMouseItemInfo (iname, d1, d2, d3, useable ,1);
      with Butt as TDButton do
        DScreen.ShowHint(Butt.SurfaceX(Butt.Left) + 115, Butt.SurfaceY(Butt.Top), iname + d1 + '\' + d2 + '\' + d3, clWhite, FALSE);
        g_MouseItem.S.Name := '';
   end;
end;

procedure TFrmDlg.DSellOffListCancelClick(Sender: TObject; X, Y: Integer);
begin
      FrmMain.SendCancelMySellOffIteming;
      ArrangeItembag;
      DWSellOffList.Visible := False;
      FillChar (g_SellOffInfo, sizeof(TClientDealOffInfo), #0); //��ռ����б���Ʒ 20080318
end;

procedure TFrmDlg.DSellOffBuyCancelClick(Sender: TObject; X, Y: Integer);
begin
      FrmMain.SendSellOffBuyCancel;
      DWSellOffList.Visible := False;
      FillChar (g_SellOffInfo, sizeof(TClientDealOffInfo), #0); //��ռ����б���Ʒ 20080318
end;

procedure TFrmDlg.DSellOffBuyClick(Sender: TObject; X, Y: Integer);
begin         
      FrmMain.SendSellOffBuy;
end;

procedure TFrmDlg.DWGameGoldMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  g_MouseItem.s.Name := 'Ԫ����Ϣ';
  g_MouseItem.MakeIndex := 3000;
  g_MouseItem.Dura := 3000;
  g_MouseItem.DuraMax := 3000;
end;

procedure TFrmDlg.DWMiniMapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  d: TDirectDrawSurface;
  rc: TRect;
  nx, ny: Integer;
begin
  try
  if GetMiniMapNum(g_nMiniMapIndex) <> nil then  //��С��ͼ
    d:= GetMiniMapNum(g_nMiniMapIndex)
  else
    d := g_WMMapImages.Images[g_nMiniMapIndex];
    if d <> nil then begin
      rc := d.ClientRect;
      if g_nViewMinMapLv = 1 then begin
        if x < 60 then nx := -(60-x) else nx:= x-60;
        g_nMouseMinMapX := (g_MySelf.m_nCurrX * 32) div 32 - rc.Left + nx - (SCREENWIDTH - 120);
        if y < 60 then ny := -(60-y) else ny:= y-60;
        g_nMouseMinMapY := (g_MySelf.m_nCurrY * 32) div 32 - rc.Top + ny;
      end else
        if g_nViewMinMapLv = 2 then begin
          g_nMouseMinMapX := _MAX(0, Round((X - 640) * d.Width / 245));  //ȫ�� ����Ե�
          g_nMouseMinMapY := Round(Y * d.Height / 155);
        end;
    end;
  except
    DebugOutStr ('MiniMapMouseMove');
  end;
end;
//�����С��ͼ��  20080324
function TFrmDlg.GetMiniMapNum(num:Integer): TDirectDrawSurface;
begin
  case num of
    10301: Result := FrmMain.UiImages(20);//FrmMain.UiDXImageList.Items.Find('301MinMap').PatternSurfaces[0];
    10302: Result := FrmMain.UiImages(25);//FrmMain.UiDXImageList.Items.Find('302MinMap').PatternSurfaces[0];
    10303: Result := FrmMain.UiImages(26);//FrmMain.UiDXImageList.Items.Find('303MinMap').PatternSurfaces[0];
    10304: Result := FrmMain.UiImages(27);//FrmMain.UiDXImageList.Items.Find('304MinMap').PatternSurfaces[0];
    10306: Result := FrmMain.UiImages(28);//FrmMain.UiDXImageList.Items.Find('306MinMap').PatternSurfaces[0];
    10307: Result := frmMain.UiImages(37); //20080807
    10308: Result := frmMain.UiImages(38); //20080807
    10309: Result := frmMain.UiImages(39); //20080807
    10310: Result := frmMain.UiImages(40); //20080807
    10311: Result := frmMain.UiImages(41); //20080807
    10312: Result := frmMain.UiImages(42); //20080807
    10313: Result := frmMain.UiImages(43); //20080807
    10314: Result := frmMain.UiImages(44); //20080807
    10315: Result := frmMain.UiImages(45); //20080807
    10316: Result := frmMain.UiImages(46); //20080807
    10317: Result := frmMain.UiImages(47); //20080807
    10318: Result := frmMain.UiImages(48); //20080807
    10319: Result := frmMain.UiImages(49); //20080807
    10320: Result := frmMain.UiImages(50); //20080807
    10321: Result := frmMain.UiImages(51); //20080807
    10322: Result := frmMain.UiImages(52); //20080807
    10323: Result := frmMain.UiImages(53); //20080807
  else Result := nil;
  end;
end;

procedure TFrmDlg.DWMiniMapDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  mx, my,nx,ny, i: Integer;
  rc: TRect;
  actor:TActor;
  x,y:integer;
  btColor:Byte;
  {T,} old: PFindNOde;  //�Զ�Ѱ· 20080617
  Automx,Automy: Integer; //�Զ�Ѱ· 20080617
begin
  if GetTickCount > m_dwBlinkTime + 300 then begin  //��ǰ�����С��ͼ�ϵ�λ�ã�ÿ300������һ��
    m_dwBlinkTime := GetTickCount;
    m_boViewBlink := not m_boViewBlink;
  end;
  if g_nMiniMapIndex < 0 then exit;
  if GetMiniMapNum(g_nMiniMapIndex) <> nil then  //��С��ͼ
    d:= GetMiniMapNum(g_nMiniMapIndex)
  else
    d := g_WMMapImages.Images[g_nMiniMapIndex];

  if d = nil then exit;

  mx := (g_MySelf.m_nCurrX*48) div 32;
  my := (g_MySelf.m_nCurrY*32) div 32;

    rc.Left := _MAX(0, mx-60);
    rc.Top := _MAX(0, my-60);
    rc.Right := _MIN(d.ClientRect.Right, rc.Left + 120);
    rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + 120);

   if g_nViewMinMapLv = 1 then begin
   
      if not g_boTransparentMiniMap then
        dsurface.Draw ((SCREENWIDTH-120), 0, rc, d, FALSE)
      else begin
        DrawBlendEx (dsurface, (SCREENWIDTH-120), 0, d,rc.Left, rc.Top, 120, 120, 0);
      end;

      m_boViewBlink := True;
      if (g_nMouseMinMapX <> 0) and (g_nMouseMinMapY <> 0) then
      with dsurface.Canvas do begin
        {$if Version = 1}
        SetBkMode (Handle, TRANSPARENT);
        {$IFEND}
        //Font.Color := clWhite;
        BoldTextOut (dsurface,DWMiniMap.Left + 120 - FrmMain.Canvas.TextWidth(IntToStr(g_nMouseMinMapX)+':'+IntToStr(g_nMouseMinMapY))
          , DWMiniMap.Top + 108, clWhite, clBlack,IntToStr(g_nMouseMinMapX)+':'+IntToStr(g_nMouseMinMapY));
        Release;
      end;
      //С��ͼ���Զ�Ѱ··�� 20080617
      if (g_RoadList.Count > 0)and(g_SearchMap<>nil) then begin
        with dsurface.Canvas do begin
          //T := PFindNOde(g_RoadList[0]);
          Pen.Color := clYellow;
          Automx := (SCREENWIDTH-120) + (g_MySelf.m_nCurrX * 48) div 32 - rc.Left;
          AutomY := (g_MySelf.m_nCurrY * 32) div 32 - rc.Top;
          if g_RoadList.Count > 0 then //20080629
          for i := 0 to g_RoadList.Count - 1 do begin
            old := PFindNOde(g_RoadList[i]);
            if old <> nil then begin
              MoveTo(Automx, Automy);
              Automx := (SCREENWIDTH-120) + (old.X * 48) div 32 - rc.Left;
              AutomY := (old.Y * 32) div 32 - rc.Top;
              LineTo(Automx, Automy);
            end;
            //T := old;
          end;
          Release;
        end;
      end;
   end else begin
      if (d <> nil) and (d.Width <> 0) and (d.Height <> 0)then begin
        dsurface.StretchDraw(Rect((SCREENWIDTH - 160), 0, 800, 160), d.ClientRect,d, False);
        rc := d.ClientRect;
        mx := UpInt((245 / d.Width) * g_MySelf.m_nCurrX) + 800 - 160;
        my := UpInt((155 / d.Height) * g_MySelf.m_nCurrY);
      end;
      m_boViewBlink := False;
      if (g_nMouseMinMapX <> 0) and (g_nMouseMinMapY <> 0) then
      with dsurface.Canvas do begin
        {$if Version = 1}
        SetBkMode (Handle, TRANSPARENT);
        {$IFEND}
        Font.Color := clWhite;
        BoldTextOut (dsurface,DWMiniMap.Left + 160 - FrmMain.Canvas.TextWidth(IntToStr(g_nMouseMinMapX)+':'+IntToStr(g_nMouseMinMapY))
          , DWMiniMap.Top + 148, clWhite, clBlack,IntToStr(g_nMouseMinMapX)+':'+IntToStr(g_nMouseMinMapY));
        Release;
      end;
      //���ͼ���Զ�Ѱ··�� 20080617
      if (g_RoadList.Count > 0)and(g_SearchMap<>nil) then begin
        with dsurface.Canvas do begin
          //T := PFindNOde(g_RoadList[0]);
          Pen.Color := clYellow;
          Automx := UpInt((245 / d.Width) * g_MySelf.m_nCurrX) + 800 - 160;
          Automy := UpInt((155 / d.Height) * g_MySelf.m_nCurrY);
          if g_RoadList.Count > 0 then //20080629
          for i := 0 to g_RoadList.Count - 1 do begin
            old := PFindNOde(g_RoadList[i]);
            if old <> nil then begin
              MoveTo(Automx, Automy);
              Automx := UpInt((245 / d.Width) * Old.X) + 800 - 160;
              Automy := UpInt((155 / d.Height) * Old.Y);
              LineTo(Automx, Automy);
            end;
            //T := old;
          end;
          Release;
        end;
      end;
      {$if Version = 1}
      for x:=0 to 3 do
        for y:=0 to 3 do
        dsurface.Pixels[mx+x, my+y] := 255;
      {$ELSE}
      ClFunc.PixelsOut(dsurface,mx, my, 255, 4);
      {$IFEND}

   end;

     //�״�
  if not m_boViewBlink then exit;
  mx := (SCREENWIDTH-120) + (g_MySelf.m_nCurrX * 48) div 32 - rc.Left;
  my := (g_MySelf.m_nCurrY * 32) div 32 - rc.Top;
  {$if Version = 1}
  for x:=0 to 2 do
    for y:=0 to 2 do
  dsurface.Pixels[mx+x, my+y] := 255;
  {$ELSE}
  ClFunc.PixelsOut(dsurface,mx, my, 255, 3);
  {$IFEND}

  for nx:=g_MySelf.m_nCurrX - 10  to g_MySelf.m_nCurrX + 10 do begin
    for ny:=g_MySelf.m_nCurrY - 10 to g_MySelf.m_nCurrY + 10 do begin
      actor := PlayScene.FindActorXY(nx,ny);
      if (actor <> nil) and (actor <> g_MySelf) and (not actor.m_boDeath) then begin
        mx := (SCREENWIDTH-120) + (actor.m_nCurrX * 48) div 32 - rc.Left;
        my := (actor.m_nCurrY * 32) div 32 - rc.Top;
        case actor.m_btRace of    //
          50,12: btColor:=215;
          0,150: btColor:=251;
          else btColor:=249;
        end;    // case
        if (actor.m_btRace= 1) then btColor := actor.m_btMiniMapHeroColor;
        {$if Version = 1}
        for x:=0 to 2 do
          for y:=0 to 2 do
            dsurface.Pixels[mx+x, my+y] := btColor ;
        {$ELSE}
        ClFunc.PixelsOut(dsurface,mx, my, btColor, 3);
        {$IFEND}
      end;
    end;
  end;
end;

procedure TFrmDlg.DWMiniMapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then begin
    if g_boViewMiniMap then begin
      if g_nViewMinMapLv >= 2 then begin
         g_nViewMinMapLv:=1;
         DWMiniMap.Left := SCREENWIDTH - 120; //20080323
         DWMiniMap.Width := 120; //20080323
         DWMiniMap.Height:= 120; //20080323
      end else begin
        Inc(g_nViewMinMapLv);
        DWMiniMap.Left := SCREENWIDTH - 160; //20080323
        DWMiniMap.Width := 160; //20080323
        DWMiniMap.Height:= 160; //20080323
      end;
    end;
  end;
  if Button = mbRight then begin
    g_boTransparentMiniMap := not g_boTransparentMiniMap;
  end;
end;

procedure TFrmDlg.DSelectChrMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DCIDSpleenMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 // g_boHintDragonPoint := True;
end;

procedure TFrmDlg.DUserState1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  g_boSelectText := False;
end;

procedure TFrmDlg.DHeroIconMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if g_Heroself = nil then Exit;
 DScreen.ShowHint(DHeroIcon.SurfaceX(DHeroIcon.Left) + DheroIcon.Width - 2, DHeroIcon.SurfaceY(DHeroIcon.Top)+18,
     '����ֵ: ' + IntToStr(g_Heroself.m_Abil.HP)+ '/' + IntToStr(g_Heroself.m_Abil.MaxHP) + '\' +
     'ħ��ֵ: ' + IntToStr(g_Heroself.m_Abil.MP)+ '/' + IntToStr(g_Heroself.m_Abil.MaxMP) + '\' +
     '����ֵ: ' + FloatToStrFixFmt (Round(100 * g_HeroSelf.m_Abil.Exp / g_HeroSelf.m_Abil.MaxExp), 3, 2) + '%' + '\' +
     '�ҳ϶�: ' + FormatFloat('0.00',g_HeroSelf.m_nLoyal / 100)+'%' + '\' +
     '��ƶ�: ' + IntToStr(_MAX(0, 100 * g_HeroSelf.m_Abil.WineDrinkValue div g_HeroSelf.m_Abil.MaxAlcohol)) + '%'
     , clWhite, FALSE);
end;

procedure TFrmDlg.DBoxsTautologyDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
    with DBoxsTautology do begin
      if DBoxsTautology.Downed then begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;



    if GetTickCount - g_dwBoxsTautologyTick > 400 then begin
     g_dwBoxsTautologyTick := GetTickCount;
     Inc(g_BoxsTautologyImg);
    if g_BoxsTautologyImg > 3 then g_BoxsTautologyImg := 0;
    end;
    d := g_WMain3Images.Images[515+g_BoxsTautologyImg];
      DrawBlend(dsurface,SurfaceX(Left- 10),SurfaceY(Top - 20), d, 1);
    end;

end;

procedure TFrmDlg.DItemsUpBelt1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  idx: Integer;
begin
  if Sender = DItemsUpBelt1 then begin
    if g_ItemsUpItem[0].S.Name <> '' then begin
      idx := g_ItemsUpItem[0].S.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        if d <> nil then
          dsurface.Draw (DItemsUpBelt1.SurfaceX(DItemsUpBelt1.Left + (DItemsUpBelt1.Width - d.Width) div 2),
                         DItemsUpBelt1.SurfaceY(DItemsUpBelt1.Top + (DItemsUpBelt1.Height - d.Height) div 2),
                         d.ClientRect, d, TRUE);
      end;
    end;
  end;
  if Sender = DItemsUpBelt2 then begin
    if g_ItemsUpItem[1].S.Name <> '' then begin
      idx := g_ItemsUpItem[1].S.Looks;
      if idx >= 0 then begin
        d := g_WBagItemImages.Images[idx];
        if d <> nil then
          dsurface.Draw (DItemsUpBelt2.SurfaceX(DItemsUpBelt2.Left + (DItemsUpBelt2.Width - d.Width) div 2),
                         DItemsUpBelt2.SurfaceY(DItemsUpBelt2.Top + (DItemsUpBelt2.Height - d.Height) div 2),
                         d.ClientRect, d, TRUE);
      end;
    end;
  end;
  if Sender = DItemsUpBelt3 then begin
    if g_ItemsUpItem[2].S.Name <> '' then begin
      idx := g_ItemsUpItem[2].S.Looks;
      if idx >= 0 then begin
        d :=g_WBagItemImages.Images[idx];
        if d <> nil then
          dsurface.Draw (DItemsUpBelt3.SurfaceX(DItemsUpBelt3.Left + (DItemsUpBelt3.Width - d.Width) div 2),
                         DItemsUpBelt3.SurfaceY(DItemsUpBelt3.Top + (DItemsUpBelt3.Height - d.Height) div 2),
                         d.ClientRect, d, TRUE);
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemsUpBelt1Click(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   butt: TDButton;
   sel: Integer;
begin
   butt := TDButton(Sender);
   if not g_boItemMoving then begin
      if g_ItemsUpItem[butt.Tag].s.Name <> '' then begin
         ItemClickSound (g_ItemsUpItem[butt.Tag].s);
         if (g_MovingItem.Item.S.Name <> '') or (g_WaitingItemUp.Item.S.Name <> '') then exit;
         sel := -1;
         if Sender = DItemsUpBelt1 then sel := 0;
         if Sender = DItemsUpBelt2 then sel := 1;
         if Sender = DItemsUpBelt3 then sel := 2;
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -(sel + 41);
         g_MovingItem.Item := g_ItemsUpItem[butt.Tag];
         g_ItemsUpItem[butt.Tag].s.Name := '';
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) or (g_MovingItem.Index = -99) then Exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -41) or (g_MovingItem.Index = -42) or
         (g_MovingItem.Index = -43) then begin
         ItemClickSound (g_MovingItem.Item.S);
         if g_ItemsUpItem[butt.Tag].s.Name <> '' then begin //�ڸ��� ������
            temp := g_ItemsUpItem[butt.Tag];
            g_ItemsUpItem[butt.Tag] := g_MovingItem.Item;
            g_MovingItem.Index := -(sel + 41);
            g_MovingItem.Item := temp
         end else begin
            g_ItemsUpItem[butt.Tag] := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
         end;
      end;
   end;
end;



procedure TFrmDlg.DItemsUpOkClick(Sender: TObject; X, Y: Integer);
begin
  if (g_ItemsUpItem[0].s.Name = '') or (g_ItemsUpItem[1].s.Name = '') or (g_ItemsUpItem[2].s.Name = '') then Exit;
  FrmMain.SendItemUpOK();
end;

procedure TFrmDlg.DItemsUpBelt1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   idx: integer;
begin
   idx := TDButton(Sender).Tag;
   if idx in [0..2] then begin
      if g_ItemsUpItem[idx].S.Name <> '' then begin
         g_MouseItem := g_ItemsUpItem[idx];
      end;
   end;
end;

procedure TFrmDlg.DItemsUpCloseClick(Sender: TObject; X, Y: Integer);
begin
  DItemsUp.Visible := False;
  if g_ItemsUpItem[0].s.Name <> '' then begin
    AddItemBag(g_ItemsUpItem[0]);
    g_ItemsUpItem[0].s.Name := '';
  end;
  if g_ItemsUpItem[1].s.Name <> '' then begin
    AddItemBag(g_ItemsUpItem[1]);
    g_ItemsUpItem[1].s.Name := '';
  end;
  if g_ItemsUpItem[2].s.Name <> '' then begin
    AddItemBag(g_ItemsUpItem[2]);
    g_ItemsUpItem[2].s.Name := '';
  end;
end;

procedure TFrmDlg.DGetHeroCloseClick(Sender: TObject; X, Y: Integer);
begin
  DWiGetHero.Visible := False;
end;

procedure TFrmDlg.DGloryDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
  with DGlory do begin
   // d:=FrmMain.UiDXImageList.Items.Find('GloryButton').PatternSurfaces[0];
   d:=frmMain.UiImages(33);
    if d<>nil then
     dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

    with dsurface.Canvas do begin

      {$IF Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clWhite;
      TextOut (SurfaceX(Left) + 50 - TextWidth(IntToStr(g_btGameGlory)) div 2, SurfaceY(Top) + 4, IntToStr(g_btGameGlory));
      {$ELSE}
      ClFunc.TextOut (dsurface, SurfaceX(Left) + 50 - frmMain.Canvas.TextWidth(IntToStr(g_btGameGlory)) div 2, SurfaceY(Top) + 4, clWhite, IntToStr(g_btGameGlory));
      {$IFEND}
      Release;
    end;
  end;
end;

procedure TFrmDlg.DSelHero1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if WLib <> nil then begin //20080701
        if not TDButton(Sender).Downed then begin
           d := WLib.Images[FaceIndex];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end else begin
           d := WLib.Images[FaceIndex + 2];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
   end;
end;

procedure TfrmDlg.DPlayGameNum();
var
  J, vData: Integer;
begin
    if GetTickCount - g_DwPlayDrinkTick > 50 then begin
      g_DwPlayDrinkTick := GetTickCount;
      if g_nImgLeft < 130 then Inc(g_nImgLeft,30)
       else Inc(g_nPlayDrinkDelay);
      if g_nImgLeft > 100 then DPlayDrinkWhoWin.Visible := True;  //��ʾ˭Ӯ
      if g_nPlayDrinkDelay > 30 then begin
        g_boPlayDrink := False;
        ShowPlayDrinkImg(False);
        if g_btWhoWin = 1 then begin //NPCӮ
          if g_NpcRandomDrinkList.Count= 0 then Exit;
          Randomize(); //�������
          J := Random(g_NpcRandomDrinkList.Count);//�����µľ������ѡһƿ
          vData := Integer(g_NpcRandomDrinkList[J]);
          g_NpcRandomDrinkList.Delete(J); //��ȡ�����б���ɾ��
          g_btNpcDrinkTarget := vData; //���Ŀ��
          g_boNpcAutoSelDrink := True;  //�Զ�ѡ��
          g_nNpcSelDrinkPosition := -1; //λ�ó�ʼ��
          g_btNpcAutoSelDrinkCircleNum := 0; //��ʼ��Ȧ��
        end;
      end;
    end;
end;

procedure TFrmDlg.DPlayDrinkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  procedure PlayDrinkTextOut1(dsurface: TDirectDrawSurface);
  var
     str, data, fdata, cmdstr, cmdparam: string;
     lx, ly, sx: integer;
//     DrawCenter: Boolean;
     pcp: PTClickPoint;
     colorg: string;   //�õ�NPC��ɫ��
     color123 : Tcolor;//npc����ɫ
  begin
    with DPlayDrink do begin
      {$if Version = 1}
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);  //����͸��
      {$IFEND}
      lx := 120;
      ly := 46;
      str := g_sPlayDrinkStr1;
//      DrawCenter := FALSE;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then begin
            sx := 0;
            fdata := '';
            while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do begin
               if data[1] <> '<' then begin
                  data := '<' + GetValidStr3 (data, fdata, ['<']);
               end;
               data := ArrestStringEx (data, '<', '>', cmdstr);//�õ�"<"��">" ��֮�����   ����� cmdstr
               if cmdstr <> '' then begin
                  if Uppercase(cmdstr) = 'C' then begin
//                     drawcenter := TRUE;
                     continue;
                  end;
                  if UpperCase(cmdstr) = '/C' then begin
//                     drawcenter := FALSE;
                     continue;
                  end;
                  cmdparam := GetValidStr3 (cmdstr, cmdstr, ['/']); //cmdparam : �������
                  colorg := GetValidStr3 (cmdparam, colorg, ['=']); //��NPC�ű��еõ�����ɫ����
                  color123 := GetRGB(Str_ToInt(colorg,0));//strת��byte
               end else begin
                  DPlayDrink.Visible := FALSE;
               end;

               if fdata <> '' then begin
                  BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, fdata);
                  sx := sx + FrmMain.Canvas.TextWidth(fdata);
               end;
               if cmdstr <> '' then begin
                  if g_boRequireAddPoints1 then begin
                     new (pcp);
                     pcp.rc := Rect (lx+sx, ly, lx+sx + FrmMain.Canvas.TextWidth(cmdstr), ly + 14);
                     pcp.RStr := cmdparam;
                     g_PlayDrinkPoints.Add (pcp);
                  end;
                  dsurface.Canvas.Font.Style := FrmMain.Canvas.Font.Style + [fsUnderline];  //�����»���
                  if SelectMenuStr = cmdparam then
                     BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clRed, clBlack, cmdstr)
                  else begin
                    if Str_ToInt(colorg,0) <> 0 then begin
                      dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline]; //ȥ������������»���
                      BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), color123, clBlack, cmdstr)  //��ʾ��ɫ����
                    end else BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clYellow, clBlack, cmdstr);
                  end;
                  sx := sx + FrmMain.Canvas.TextWidth(cmdstr);
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline];
               end;
            end;
            if data <> '' then
               BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, data);
         end;
         ly := ly + 16;
      end;
      dsurface.Canvas.Release;
      g_boRequireAddPoints1 := FALSE;
    end;
  end;
  procedure PlayDrinkTextOut2(dsurface: TDirectDrawSurface);
  var
     str, data, fdata, cmdstr, cmdparam: string;
     lx, ly, sx: integer;
//     DrawCenter: Boolean;
     pcp: PTClickPoint;
     colorg: string;   //�õ�NPC��ɫ��
     color123 : Tcolor;//npc����ɫ
  begin
    with DPlayDrink do begin
      {$if Version = 1}
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);  //����͸��
      {$IFEND}
      lx := 120;
      ly := 274;
      str := g_sPlayDrinkStr2;
//      DrawCenter := FALSE;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then begin
            sx := 0;
            fdata := '';
            while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do begin
               if data[1] <> '<' then begin
                  data := '<' + GetValidStr3 (data, fdata, ['<']);
               end;
               data := ArrestStringEx (data, '<', '>', cmdstr);//�õ�"<"��">" ��֮�����   ����� cmdstr
               if cmdstr <> '' then begin
                  if Uppercase(cmdstr) = 'C' then begin
//                     drawcenter := TRUE;
                     continue;
                  end;
                  if UpperCase(cmdstr) = '/C' then begin
//                     drawcenter := FALSE;
                     continue;
                  end;
                  cmdparam := GetValidStr3 (cmdstr, cmdstr, ['/']); //cmdparam : �������
                  colorg := GetValidStr3 (cmdparam, colorg, ['=']); //��NPC�ű��еõ�����ɫ����
                  color123 := GetRGB(Str_ToInt(colorg,0));//strת��byte
               end else begin
                  DPlayDrink.Visible := FALSE;
               end;

               if fdata <> '' then begin
                  BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, fdata);
                  sx := sx + FrmMain.Canvas.TextWidth(fdata);
               end;
               if cmdstr <> '' then begin
                  if g_boRequireAddPoints2 then begin
                     new (pcp);
                     pcp.rc := Rect (lx+sx, ly, lx+sx + FrmMain.Canvas.TextWidth(cmdstr), ly + 14);
                     pcp.RStr := cmdparam;
                     g_PlayDrinkPoints.Add (pcp);
                  end;
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style + [fsUnderline];  //�����»���
                  if SelectMenuStr = cmdparam then
                     BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clRed, clBlack, cmdstr)
                  else begin
                    if Str_ToInt(colorg,0) <> 0 then begin
                      dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline]; //ȥ������������»���
                      BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), color123, clBlack, cmdstr)  //��ʾ��ɫ����
                    end else BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clYellow, clBlack, cmdstr);
                  end;
                  sx := sx + FrmMain.Canvas.TextWidth(cmdstr);
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline];
               end;
            end;
            if data <> '' then
               BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, data);
         end;
         ly := ly + 16;
      end;
      dsurface.Canvas.Release;
      g_boRequireAddPoints2 := FALSE;
    end;
  end;
var
   d: TDirectDrawSurface;
   MyIcon: Integer;
   Butt: TDButton;
   rc: Trect;
   IconFlash: Integer; //��λNPC�����ͷ�񴦺Ⱦ�ͼ
begin
  with DPlayDrink do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
    if g_btDrinkValue[0] <= 92 then begin
       d := g_WMain2Images.Images[342+g_btNpcIcon]; //NPCͷ��
       if d <> nil then
          dsurface.Draw (SurfaceX(Left + 16), SurfaceY(Top + 19), d.ClientRect, d, TRUE);
    end;
//------------------------NPC�Ⱦƶ�����ʾ
    if g_btShowPlayDrinkFlash = 1 then begin
      if GetTickCount - g_DwShowPlayDrinkFlashTick > 150 then begin
         g_DwShowPlayDrinkFlashTick := GetTickCount;
         inc(g_nShowPlayDrinkFlashImg);
         if g_btTempDrinkValue[0] > 92 then begin//NPC������
            if g_nShowPlayDrinkFlashImg > 14 then begin
              g_btShowPlayDrinkFlash := 0;
              g_btDrinkValue[0] := g_btTempDrinkValue[0];
            end;
         end else begin
            if g_nShowPlayDrinkFlashImg > 10 then begin
              g_btShowPlayDrinkFlash := 0;
              g_btDrinkValue[0] := g_btTempDrinkValue[0];
            end;
         end;
      end;
      case g_btNpcIcon of
        0: IconFlash := 370;
        1: IconFlash := 390;
        2: IconFlash := 410;
        else IconFlash := 370;
      end;
      d := g_WMain2Images.Images[IconFlash + g_nShowPlayDrinkFlashImg];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left + 16), SurfaceY(Top + 19), d.ClientRect, d, TRUE);
    end;
    if g_btDrinkValue[0] > 92 then begin //����������ͼ
      case g_btNpcIcon of
        0: IconFlash := 370;
        1: IconFlash := 390;
        2: IconFlash := 410;
        else IconFlash := 370;
      end;
      d := g_WMain2Images.Images[IconFlash + g_nShowPlayDrinkFlashImg - 1];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left + 16), SurfaceY(Top + 19), d.ClientRect, d, TRUE);
    end;
//-----------------
    if g_btDrinkValue[1] <= 92 then begin
     if g_Myself.m_btSex = 0 then MyIcon := 337 else MyIcon := 338;
     if MyIcon > 0 then begin //���ͷ��
       d := g_WMain2Images.Images[MyIcon];
       if d <> nil then
          dsurface.Draw (SurfaceX(Left + 16), SurfaceY(Top + 248), d.ClientRect, d, TRUE);
     end;
    end;
//-------------��ҺȾƶ�����ʾ
    if g_btShowPlayDrinkFlash = 2 then begin
      if GetTickCount - g_DwShowPlayDrinkFlashTick > 150 then begin
         g_DwShowPlayDrinkFlashTick := GetTickCount;
         inc(g_nShowPlayDrinkFlashImg);
         if g_btTempDrinkValue[1] > 92 then begin//NPC������
            if g_nShowPlayDrinkFlashImg > 14 then begin
              g_btShowPlayDrinkFlash := 0;
              g_btDrinkValue[1] := g_btTempDrinkValue[1];
            end;
         end else begin
            if g_nShowPlayDrinkFlashImg > 10 then begin
              g_btShowPlayDrinkFlash := 0;
              g_btDrinkValue[1] := g_btTempDrinkValue[1];
            end;
         end;
      end;
      if g_Myself.m_btSex = 0 then IconFlash := 430 else IconFlash := 450;
      d := g_WMain2Images.Images[IconFlash + g_nShowPlayDrinkFlashImg];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left + 16), SurfaceY(Top + 248), d.ClientRect, d, TRUE);
    end;
    if g_btDrinkValue[1] > 92 then begin //����������ͼ
      if g_Myself.m_btSex = 0 then IconFlash := 430 else IconFlash := 450;
      d := g_WMain2Images.Images[IconFlash + g_nShowPlayDrinkFlashImg - 1];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left + 16), SurfaceY(Top + 248), d.ClientRect, d, TRUE);
    end;
//-----------------
    d := g_WMain2Images.Images[369];  //NPC����
    if d <> nil then begin
       rc := d.ClientRect;
       rc.Right := Round((rc.Right-rc.Left) /100 * g_btDrinkValue[0]);
       dsurface.Draw (SurfaceX(Left + 111), SurfaceY(Top + 97), rc, d, true);
    end;
    d := g_WMain2Images.Images[369];  //��Ҿ���
    if d <> nil then begin
       rc := d.ClientRect;
       rc.Right := Round((rc.Right-rc.Left) /100 * g_btDrinkValue[1]);
       dsurface.Draw (SurfaceX(Left + 111), SurfaceY(Top + 326), rc, d, true);
    end;
     with dsurface.Canvas do  begin
      Brush.Color := clRed;
      FillRect(rect(SurfaceX(Left)+313,  //���      ����ɫ����
                    SurfaceY(Top) + 97,      //�ϱ�
                    SurfaceX(Left)+315,   //�ұ�
                    SurfaceY(Top)+ 106));//�±�
      FillRect(rect(SurfaceX(Left)+313,  //���      ����ɫ����
                    SurfaceY(Top) + 326,      //�ϱ�
                    SurfaceX(Left)+315,   //�ұ�
                    SurfaceY(Top)+ 335));//�±�
      Release;
     end;
     with dsurface.Canvas do  begin
      {$IF Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clWhite;
      TextOut(SurfaceX(Left) + 60 - TextWidth(g_sNpcName) div 2 , SurfaceY(Top) + 97, g_sNpcName);
      TextOut(SurfaceX(Left) + 60 - TextWidth(g_MySelf.m_sUserName) div 2 , SurfaceY(Top) + 326, g_MySelf.m_sUserName);
      {$ELSE}
      ClFunc.TextOut(dsurface, SurfaceX(Left) + 60 - FrmMain.Canvas.TextWidth(g_sNpcName) div 2 , SurfaceY(Top) + 97, clWhite, g_sNpcName);
      ClFunc.TextOut(dsurface, SurfaceX(Left) + 60 - FrmMain.Canvas.TextWidth(g_MySelf.m_sUserName) div 2 , SurfaceY(Top) + 326, clWhite, g_MySelf.m_sUserName);
      {$IFEND}
      Release;
     end;

    d := g_WMain2Images.Images[348];
    if d <> nil then begin
      if g_boStopPlayDrinkGame then
        DrawBlendEx(dsurface,SurfaceX(Left) + 395,
                  SurfaceY(Top) + 240, d,0,0,d.Width,d.Height, 0)
      else
        dsurface.Draw (SurfaceX(Left) + 395, SurfaceY(Top) + 240, d.ClientRect, d, TRUE);
    end;
    d := g_WMain2Images.Images[350];
    if d <> nil then begin
      if g_boStopPlayDrinkGame then
        DrawBlendEx(dsurface,SurfaceX(Left) + 351,
                  SurfaceY(Top) + 250, d,0,0,d.Width,d.Height, 0)
      else
      dsurface.Draw (SurfaceX(Left) + 351, SurfaceY(Top) + 250, d.ClientRect, d, TRUE);
    end;
    d := g_WMain2Images.Images[352];
    if d <> nil then begin
      if g_boStopPlayDrinkGame then
        DrawBlendEx(dsurface,SurfaceX(Left) + 342,
                  SurfaceY(Top) + 294, d,0,0,d.Width,d.Height, 0)
      else
      dsurface.Draw (SurfaceX(Left) + 342, SurfaceY(Top) + 294, d.ClientRect, d, TRUE);
    end;
     if not g_boStopPlayDrinkGame then begin
      if g_btPlayDrinkGameNum <= 2 then begin
        if DPlayDrinkFist.Tag = g_btPlayDrinkGameNum then butt := DPlayDrinkFist;
        if DPlayDrinkScissors.Tag = g_btPlayDrinkGameNum then butt := DPlayDrinkScissors;
        if DPlayDrinkCloth.Tag = g_btPlayDrinkGameNum then butt := DPlayDrinkCloth;
        if butt.Tag = g_btPlayDrinkGameNum then begin
            if GetTickCount - g_dwPlayDrinkSelImgTick > 100 then begin
               g_dwPlayDrinkSelImgTick := GetTickCount;
               inc(g_nPlayDrinkSelImg);
              if g_nPlayDrinkSelImg > 1 then g_nPlayDrinkSelImg := 0;
            end;
          with butt do begin
            d := g_WMain2Images.Images[361 + g_nPlayDrinkSelImg];
            if d <> nil then
                DrawBlend(dsurface,SurfaceX(Left), SurfaceY(Top), d, 1);
          end;
        end;
      end;
     end;
    if not g_boPlayDrink then begin
      PlayDrinkTextOut1(dsurface); //���ű�����
      PlayDrinkTextOut2(dsurface); //���ű�����
    end;

    if g_boPlayDrink then begin
      d := g_WMain2Images.Images[339];
      if d <> nil then
            DrawBlendEx(dsurface,SurfaceX(Left),
                    SurfaceY(Top), d,0,0,d.Width,d.Height, 0);

      DPlayGameNum();
      DPlayDrinkNpcNum.Left := 0 + g_nImgLeft;
      d := g_WMain2Images.Images[345];
        if d <> nil then
      DPlayDrinkPlayNum.Left := DPlayDrink.Width - d.Width - g_nImgLeft;

    end;
  end;
end;

procedure TFrmDlg.ChallengeClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwQueryMsgTick then begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendChallenge;
   end;
end;
//�ƹ�NPC�Զ�ѡ���С���
procedure TFrmDlg.NpcAutoSelDrinkRuning(dsurface: TDirectDrawSurface);
begin
  if g_boNpcAutoSelDrink then begin     //NPC�Զ�ѡ����
    if GetTickCount - g_DwShowNpcSelDrinkTick > 150 then begin
     g_DwShowNpcSelDrinkTick := GetTickCount;
     Inc(g_nNpcSelDrinkPosition);  //��һ��λ��
      if g_nNpcSelDrinkPosition > 5 then begin
        g_nNpcSelDrinkPosition := 0;
        Inc(g_btNpcAutoSelDrinkCircleNum); //ת��Ȧ��
      end;

    if g_btNpcAutoSelDrinkCircleNum = 2 then begin
      if g_nNpcSelDrinkPosition = 0 then
        if DDrink1.Tag = g_btNpcDrinkTarget then begin
          DDrink1.Visible := False;
          g_boNpcAutoSelDrink := False;
          FrmMain.SendDrinkUpdateValue(g_nCurMerchant, 0, 0);
        end;
      if g_nNpcSelDrinkPosition = 1 then
        if DDrink2.Tag = g_btNpcDrinkTarget then begin
          DDrink2.Visible := False;
          g_boNpcAutoSelDrink := False;
          FrmMain.SendDrinkUpdateValue(g_nCurMerchant, 0, 0);
        end;
      if g_nNpcSelDrinkPosition = 2 then
        if DDrink4.Tag = g_btNpcDrinkTarget then begin
          DDrink4.Visible := False;
          g_boNpcAutoSelDrink := False;
          FrmMain.SendDrinkUpdateValue(g_nCurMerchant, 0, 0);
        end;
      if g_nNpcSelDrinkPosition = 3 then
        if DDrink6.Tag = g_btNpcDrinkTarget then begin
          DDrink6.Visible := False;
          g_boNpcAutoSelDrink := False;
          FrmMain.SendDrinkUpdateValue(g_nCurMerchant, 0, 0);
        end;
      if g_nNpcSelDrinkPosition = 4 then
        if DDrink5.Tag = g_btNpcDrinkTarget then begin
          DDrink5.Visible := False;
          g_boNpcAutoSelDrink := False;
          FrmMain.SendDrinkUpdateValue(g_nCurMerchant, 0, 0);
        end;
      if g_nNpcSelDrinkPosition = 5 then
        if DDrink3.Tag = g_btNpcDrinkTarget then begin
          DDrink3.Visible := False;
          g_boNpcAutoSelDrink := False;
          FrmMain.SendDrinkUpdateValue(g_nCurMerchant, 0, 0);
        end;
    end;
    end;
  end;
end;

procedure TFrmDlg.DDrink1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  NpcAutoSelDrinkRuning(dsurface);
   with TDButton(Sender) do begin
     if g_boPermitSelDrink then begin  //�Ʋ���͸�����������ѡ��
        if TDButton(Sender).ShowHint then begin//����ƶ�������ƿ��  ����
          d := g_WMain2Images.Images[329];
          dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end else begin   //��ͨ��ʾ
          d := g_WMain2Images.Images[363];
          if d <> nil then
          dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
        if g_boNpcAutoSelDrink then begin   //NPC�Զ�ѡ
          if TDButton(Sender).Tag = g_nNpcSelDrinkPosition then begin
            d := g_WMain2Images.Images[329];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
          end;
        end else begin   //���ѡ��
          if TDButton(Sender).Tag = g_btPlaySelDrink then begin
            d := g_WMain2Images.Images[329];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
          end;
        end;
     end else begin
       d := g_WMain2Images.Images[363];
       if d <> nil then
         DrawBlendEx(dsurface,SurfaceX(Left),
                  SurfaceY(Top), d,0,0,d.Width,d.Height, 0);
     end;
   end;
end;

procedure TFrmDlg.DWiGetHeroDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function GetHeroIcon(Job,Sex: Byte): Integer;
  var
    Icon: Integer;
  begin
    case Job of
      0:Icon := 502;
      1:Icon := 506;
      2:Icon := 504;
    end;

    if Sex = 1 then Result := Icon +1
    else Result := Icon;
  end;
  function GetHeroJob(Job: Byte): string;
  begin
    case Job of
      0:Result := 'սʿ';
      1:Result := '��ʦ';
      2:Result := '��ʿ';
    end;
  end;
var
   d: TDirectDrawSurface;
   Job: string;
   Icon: Integer;
begin
  with DWiGetHero do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;

    if g_GetHeroData[0].sChrName <> '' then begin
      Icon := GetHeroIcon(g_GetHeroData[0].btJob, g_GetHeroData[0].btSex);
      d := g_WMain2Images.Images[Icon];
      if d <> nil then
        dsurface.Draw (SurfaceX(Left) + 32, SurfaceY(Top) + 76, d.ClientRect, d, TRUE);
    end;

    if g_GetHeroData[1].sChrName <> '' then begin
      Icon := GetHeroIcon(g_GetHeroData[1].btJob, g_GetHeroData[1].btSex);
      d := g_WMain2Images.Images[Icon];
      if d <> nil then
        dsurface.Draw (SurfaceX(Left) + 150, SurfaceY(Top) + 77, d.ClientRect, d, TRUE);
    end;
    {$IF Version = 1}
    with dsurface.Canvas do  begin
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clSkyBlue;
      if g_GetHeroData[0].sChrName <> '' then begin
        TextOut(SurfaceX(Left) + 74 - TextWidth(g_GetHeroData[0].sChrName) div 2 , SurfaceY(Top) + 58, g_GetHeroData[0].sChrName);
        Font.Color := $0040BBF1;
        TextOut(SurfaceX(Left) + 67 , SurfaceY(Top) + 192, IntToStr(g_GetHeroData[0].Level));
        Job := GetHeroJob(g_GetHeroData[0].btJob);
        TextOut(SurfaceX(Left) + 67 , SurfaceY(Top) + 206, Job);
      end;

      if g_GetHeroData[1].sChrName <> '' then begin
        Font.Color := clSkyBlue;
        TextOut(SurfaceX(Left) + 192 - TextWidth(g_GetHeroData[1].sChrName) div 2 , SurfaceY(Top) + 58, g_GetHeroData[1].sChrName);
        Font.Color := $0040BBF1;
        TextOut(SurfaceX(Left) + 184 , SurfaceY(Top) + 192, IntToStr(g_GetHeroData[1].Level));
        Job := GetHeroJob(g_GetHeroData[1].btJob);
        TextOut(SurfaceX(Left) + 184 , SurfaceY(Top) + 206, Job);
      end;
      Release;
    end;
    {$ELSE}
    with dsurface.Canvas do  begin
      if g_GetHeroData[0].sChrName <> '' then begin
        clFunc.TextOut(dsurface, SurfaceX(Left) + 74 - FrmMain.Canvas.TextWidth(g_GetHeroData[0].sChrName) div 2 , SurfaceY(Top) + 58, clSkyBlue, g_GetHeroData[0].sChrName);
        Font.Color := $0040BBF1;
        clFunc.TextOut(dsurface, SurfaceX(Left) + 67 , SurfaceY(Top) + 192, Font.Color, IntToStr(g_GetHeroData[0].Level));
        Job := GetHeroJob(g_GetHeroData[0].btJob);
        clFunc.TextOut(dsurface, SurfaceX(Left) + 67 , SurfaceY(Top) + 206, Font.Color, Job);
      end;
      if g_GetHeroData[1].sChrName <> '' then begin
        clFunc.TextOut(dsurface, SurfaceX(Left) + 192 - FrmMain.Canvas.TextWidth(g_GetHeroData[1].sChrName) div 2 , SurfaceY(Top) + 58, clSkyBlue, g_GetHeroData[1].sChrName);
        Font.Color := $0040BBF1;
        clFunc.TextOut(dsurface, SurfaceX(Left) + 184 , SurfaceY(Top) + 192, Font.Color, IntToStr(g_GetHeroData[1].Level));
        Job := GetHeroJob(g_GetHeroData[1].btJob);
        clFunc.TextOut(dsurface, SurfaceX(Left) + 184 , SurfaceY(Top) + 206, Font.Color, Job);
      end;
      Release;
    end;
    {$IFEND}
  end;
end;

procedure TFrmDlg.DSelHero1Click(Sender: TObject; X, Y: Integer);
begin
  if g_GetHeroData[TDButton(Sender).Tag].sChrName <> '' then begin
    FrmMain.SendSelHeroName(g_GetHeroData[TDButton(Sender).Tag].btType, g_GetHeroData[TDButton(Sender).Tag].sChrName);
    DWiGetHero.Visible := False;
  end;
end;

procedure TFrmDlg.DPlayFistClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.SendPlayDrinkGame(g_nCurMerchant,g_btPlayDrinkGameNum); //���Ͳ�ȭ����
  g_boPermitSelDrink := True;
  DPlayFist.Visible := False;
end;

procedure TFrmDlg.DPlayDrinkCloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
    if WLib <> nil then begin //20080701
      if not TDButton(Sender).Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            if g_boPlayDrink then
              DrawBlendEx(dsurface,SurfaceX(Left),
                  SurfaceY(Top), d,0,0,d.Width,d.Height, 0)
            else
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end else begin
         d := WLib.Images[FaceIndex + 1];
         if d <> nil then
            if g_boPlayDrink then
              DrawBlendEx(dsurface,SurfaceX(Left),
                  SurfaceY(Top), d,0,0,d.Width,d.Height, 0)
            else
              dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
   end;
end;

procedure TFrmDlg.ShowPlayDrink (Who1: integer; msgstr: string);
var
   i: integer;
begin
   if Who1 = 1 then   //�������
   g_sPlayDrinkStr1 := msgstr
   else if Who1 = 2 then   g_sPlayDrinkStr2 := msgstr;  //�������
   if g_PlayDrinkPoints.Count > 0 then //20080629
   for i:=0 to g_PlayDrinkPoints.Count-1 do
      Dispose (pTClickPoint (g_PlayDrinkPoints[i]));
   g_PlayDrinkPoints.Clear;
   if Who1 = 1 then
   g_boRequireAddPoints1 := TRUE;
   if who1 = 2 then
   g_boRequireAddPoints2 := TRUE;
end;
procedure TFrmDlg.DPlayDrinkMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   i, L, T: integer;
   p: PTClickPoint;
begin
   SelectMenuStr := '';
   L := DPlayDrink.Left;
   T := DPlayDrink.Top;
   with DPlayDrink do
      if g_PlayDrinkPoints.Count > 0 then //20080629
      for i:=0 to g_PlayDrinkPoints.Count-1 do begin
         p := PTClickPoint (g_PlayDrinkPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            SelectMenuStr := p.RStr;
            break;
         end;
      end;
end;

procedure TFrmDlg.DPlayDrinkMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SelectMenuStr := '';
end;

procedure TFrmDlg.DPlayDrinkClick(Sender: TObject; X, Y: Integer);
var
   i, L, T: integer;
   p: PTClickPoint;
begin
   L := DPlayDrink.Left;
   T := DPlayDrink.Top;
   with DPlayDrink do
      if g_PlayDrinkPoints.Count > 0 then //20080629
      for i:=0 to g_PlayDrinkPoints.Count-1 do begin
         p := PTClickPoint (g_PlayDrinkPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            FrmMain.SendPlayDrinkDlgSelect (g_nCurMerchant, p.RStr);
            break;
         end;
      end;
end;

procedure TFrmDlg.DWPleaseDrinkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  procedure PlayDrinkTextOut1(dsurface: TDirectDrawSurface);
  var
     str, data, fdata, cmdstr, cmdparam: string;
     lx, ly, sx: integer;
//     DrawCenter: Boolean;
     pcp: PTClickPoint;
     colorg: string;   //�õ�NPC��ɫ��
     color123 : Tcolor;//npc����ɫ
  begin
    with DWPleaseDrink do begin
      {$if Version = 1}
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);  //����͸��
      {$IFEND}
      lx := 115;
      ly := 55;
      str := g_sPlayDrinkStr1;
//      DrawCenter := FALSE;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then begin
            sx := 0;
            fdata := '';
            while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do begin
               if data[1] <> '<' then begin
                  data := '<' + GetValidStr3 (data, fdata, ['<']);
               end;
               data := ArrestStringEx (data, '<', '>', cmdstr);//�õ�"<"��">" ��֮�����   ����� cmdstr
               if cmdstr <> '' then begin
                  if Uppercase(cmdstr) = 'C' then begin
//                     drawcenter := TRUE;
                     continue;
                  end;
                  if UpperCase(cmdstr) = '/C' then begin
//                     drawcenter := FALSE;
                     continue;
                  end;
                  cmdparam := GetValidStr3 (cmdstr, cmdstr, ['/']); //cmdparam : �������
                  colorg := GetValidStr3 (cmdparam, colorg, ['=']); //��NPC�ű��еõ�����ɫ����
                  color123 := GetRGB(Str_ToInt(colorg,0));//strת��byte
               end else begin
                  DPlayDrink.Visible := FALSE;
               end;

               if fdata <> '' then begin
                  BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, fdata);
                  sx := sx + FrmMain.Canvas.TextWidth(fdata);
               end;
               if cmdstr <> '' then begin
                  if g_boRequireAddPoints1 then begin
                     new (pcp);
                     pcp.rc := Rect (lx+sx, ly, lx+sx + FrmMain.Canvas.TextWidth(cmdstr), ly + 14);
                     pcp.RStr := cmdparam;
                     g_PlayDrinkPoints.Add (pcp);
                  end;
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style + [fsUnderline];  //�����»���
                  if SelectMenuStr = cmdparam then
                     BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clRed, clBlack, cmdstr)
                  else begin
                    if Str_ToInt(colorg,0) <> 0 then begin
                      dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline]; //ȥ������������»���
                      BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), color123, clBlack, cmdstr)  //��ʾ��ɫ����
                    end else BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clYellow, clBlack, cmdstr);
                  end;
                  sx := sx + FrmMain.Canvas.TextWidth(cmdstr);
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline];
               end;
            end;
            if data <> '' then
               BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, data);
         end;
         ly := ly + 16;
      end;
      dsurface.Canvas.Release;
      g_boRequireAddPoints1 := FALSE;
    end;
  end;
  procedure PlayDrinkTextOut2(dsurface: TDirectDrawSurface);
  var
     str, data, fdata, cmdstr, cmdparam: string;
     lx, ly, sx: integer;
//     DrawCenter: Boolean;
     pcp: PTClickPoint;
     colorg: string;   //�õ�NPC��ɫ��
     color123 : Tcolor;//npc����ɫ
  begin
    with DWPleaseDrink do begin
      {$if Version = 1}
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);  //����͸��
      {$IFEND}
      lx := 30;
      ly := 263;
      str := g_sPlayDrinkStr2;
//      DrawCenter := FALSE;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then begin
            sx := 0;
            fdata := '';
            while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do begin
               if data[1] <> '<' then begin
                  data := '<' + GetValidStr3 (data, fdata, ['<']);
               end;
               data := ArrestStringEx (data, '<', '>', cmdstr);//�õ�"<"��">" ��֮�����   ����� cmdstr
               if cmdstr <> '' then begin
                  if Uppercase(cmdstr) = 'C' then begin
//                     drawcenter := TRUE;
                     continue;
                  end;
                  if UpperCase(cmdstr) = '/C' then begin
//                     drawcenter := FALSE;
                     continue;
                  end;
                  cmdparam := GetValidStr3 (cmdstr, cmdstr, ['/']); //cmdparam : �������
                  colorg := GetValidStr3 (cmdparam, colorg, ['=']); //��NPC�ű��еõ�����ɫ����
                  color123 := GetRGB(Str_ToInt(colorg,0));//strת��byte
               end else begin
                  DPlayDrink.Visible := FALSE;
               end;

               if fdata <> '' then begin
                  BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, fdata);
                  sx := sx + FrmMain.Canvas.TextWidth(fdata);
               end;
               if cmdstr <> '' then begin
                  if g_boRequireAddPoints2 then begin
                     new (pcp);
                     pcp.rc := Rect (lx+sx, ly, lx+sx + FrmMain.Canvas.TextWidth(cmdstr), ly + 14);
                     pcp.RStr := cmdparam;
                     g_PlayDrinkPoints.Add (pcp);
                  end;
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style + [fsUnderline];  //�����»���
                  if SelectMenuStr = cmdparam then
                     BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clRed, clBlack, cmdstr)
                  else begin
                    if Str_ToInt(colorg,0) <> 0 then begin
                      dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline]; //ȥ������������»���
                      BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), color123, clBlack, cmdstr)  //��ʾ��ɫ����
                    end else BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clYellow, clBlack, cmdstr);
                  end;
                  sx := sx + FrmMain.Canvas.TextWidth(cmdstr);
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline];
               end;
            end;
            if data <> '' then
               BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, data);
         end;
         ly := ly + 16;
      end;
      dsurface.Canvas.Release;
      g_boRequireAddPoints2 := FALSE;
    end;
  end;
var
  d: TDirectDrawSurface;
  IconFlash: Integer;
begin
  with DWPleaseDrink do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;

       d := g_WMain2Images.Images[342+g_btNpcIcon]; //NPCͷ��
       if d <> nil then
          dsurface.Draw (SurfaceX(Left + 16), SurfaceY(Top + 19), d.ClientRect, d, TRUE);
          
//------------------------NPC�Ⱦƶ�����ʾ
    if g_btShowPlayDrinkFlash = 1 then begin
      if GetTickCount - g_DwShowPlayDrinkFlashTick > 150 then begin
         g_DwShowPlayDrinkFlashTick := GetTickCount;
         inc(g_nShowPlayDrinkFlashImg);
         if g_nShowPlayDrinkFlashImg > 10 then begin
           g_btShowPlayDrinkFlash := 0;
           g_btDrinkValue[0] := g_btTempDrinkValue[0];
         end;
      end;
      case g_btNpcIcon of
        0: IconFlash := 370;
        1: IconFlash := 390;
        2: IconFlash := 410;
        else IconFlash := 370;
      end;
      d := g_WMain2Images.Images[IconFlash + g_nShowPlayDrinkFlashImg];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left + 16), SurfaceY(Top + 19), d.ClientRect, d, TRUE);
    end;


     with dsurface.Canvas do  begin
      {$IF Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clWhite;
      TextOut(SurfaceX(Left) + 60 - TextWidth(g_sNpcName) div 2 , SurfaceY(Top) + 97, g_sNpcName);
      {$ELSE}
      clFunc.TextOut(dsurface, SurfaceX(Left) + 60 - FrmMain.Canvas.TextWidth(g_sNpcName) div 2 , SurfaceY(Top) + 97, clWhite, g_sNpcName);
      {$IFEND}
      Release;
     end;

    PlayDrinkTextOut1(dsurface);
    PlayDrinkTextOut2(dsurface);
    
    d := g_WMain2Images.Images[364];
    if d <> nil then
          dsurface.Draw (SurfaceX(Left + 96), SurfaceY(Top + 186), d.ClientRect, d, TRUE);
    if d <> nil then
          dsurface.Draw (SurfaceX(Left + 290), SurfaceY(Top + 196), d.ClientRect, d, TRUE);


  end;
end;

procedure TFrmDlg.DPDrink1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  if Sender = DPDrink1 then begin
    d := g_WMain2Images.Images[365];
    if d <> nil then begin
      if DPDrink1.ShowHint then
         DrawBlendEx(dsurface,DPDrink1.SurfaceX(DPDrink1.Left),
            DPDrink1.SurfaceY(DPDrink1.Top), d,0,0,d.Width,d.Height, 0)
      else
         dsurface.Draw (DPDrink1.SurfaceX(DPDrink1.Left + (DPDrink1.Width - d.Width) div 2),
                     DPDrink1.SurfaceY(DPDrink1.Top + (DPDrink1.Height - d.Height) div 2),
                     d.ClientRect, d, TRUE);
    end;
    if g_PDrinkItem[0].S.Name <> '' then begin
        d := g_WMain2Images.Images[363];
        if d <> nil then begin
          if DPDrink1.ShowHint then
             DrawBlendEx(dsurface,DPDrink1.SurfaceX(DPDrink1.Left),
                DPDrink1.SurfaceY(DPDrink1.Top), d,0,0,d.Width,d.Height, 0)
          else
             dsurface.Draw (DPDrink2.SurfaceX(DPDrink1.Left + (DPDrink1.Width - d.Width) div 2),
                         DPDrink2.SurfaceY(DPDrink1.Top + (DPDrink1.Height - d.Height) div 2),
                         d.ClientRect, d, TRUE);
        end;
    end;
  end;

  if Sender = DPDrink2 then begin
    d := g_WMain2Images.Images[365];
    if d <> nil then begin
      if DPDrink2.ShowHint then
         DrawBlendEx(dsurface,DPDrink2.SurfaceX(DPDrink2.Left),
            DPDrink2.SurfaceY(DPDrink2.Top), d,0,0,d.Width,d.Height, 0)
      else
        dsurface.Draw (DPDrink2.SurfaceX(DPDrink2.Left + (DPDrink2.Width - d.Width) div 2),
                     DPDrink2.SurfaceY(DPDrink2.Top + (DPDrink2.Height - d.Height) div 2),
                     d.ClientRect, d, TRUE);
    end;
    if g_PDrinkItem[1].S.Name <> '' then begin
        d := g_WMain2Images.Images[363];
        if d <> nil then begin
          if DPDrink2.ShowHint then
             DrawBlendEx(dsurface,DPDrink2.SurfaceX(DPDrink2.Left),
                DPDrink2.SurfaceY(DPDrink2.Top), d,0,0,d.Width,d.Height, 0)
          else
            dsurface.Draw (DPDrink2.SurfaceX(DPDrink2.Left + (DPDrink2.Width - d.Width) div 2),
                         DPDrink2.SurfaceY(DPDrink2.Top + (DPDrink2.Height - d.Height) div 2),
                         d.ClientRect, d, TRUE);
        end;
    end;
  end;
end;

procedure TFrmDlg.DPlayDrinkCloseClick(Sender: TObject; X, Y: Integer);
begin
  DPlayDrink.Visible := False;
end;

procedure TFrmDlg.DPlayDrinkFistClick(Sender: TObject; X, Y: Integer);
begin
  if g_boPlayDrink then Exit;
  if g_boNpcAutoSelDrink then Exit;
  if g_btWhoWin = 0 then if not g_boHumWinDrink then Exit; //20080614 ���Ӯ���Ƿ���˾�
  g_btPlayDrinkGameNum := TDButton(Sender).Tag;
  DPlayFist.Visible := True;
end;

procedure TFrmDlg.DPlayDrinkNpcNumDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with DPlayDrinkNpcNum do begin
    d := g_WMain2Images.Images[366 + g_btNpcNum];
    if d <> nil then
    dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;
end;

procedure TFrmDlg.DPlayDrinkPlayNumDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with DPlayDrinkPlayNum do begin
    d := g_WMain2Images.Images[345 + g_btPlayNum];
    if d <> nil then
    dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;
end;

procedure TFrmDlg.DPlayDrinkWhoWinDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with DPlayDrinkWhoWin do begin
    d := g_WMain2Images.Images[334 + g_btWhoWin];
    if d <> nil then
    dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
  end;
end;
//�Ƿ���ʾ����һЩͼ
procedure TFrmDlg.ShowPlayDrinkImg(Show: Boolean);
begin
    DPlayDrinkWhoWin.Visible := Show;
    DPlayDrinkNpcNum.Visible := Show;
    DPlayDrinkPlayNum.Visible := Show;
end;

procedure TFrmDlg.DPlayDrinkFistDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
 //������̲���ɾ��  �ö��Ƶİ�ťΪ����ʾ
end;

procedure TFrmDlg.DDrink1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if g_boPlayDrink then Exit;
  if g_boNpcAutoSelDrink then Exit;
  TDButton(Sender).ShowHint := True;
end;

procedure TFrmDlg.DPlayDrinkMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DDrink1.ShowHint := False;
  DDrink2.ShowHint := False;
  DDrink3.ShowHint := False;
  DDrink4.ShowHint := False;
  DDrink5.ShowHint := False;
  DDrink6.ShowHint := False;
end;

procedure TFrmDlg.DDrink1Click(Sender: TObject; X, Y: Integer);
begin
  if g_boPlayDrink then Exit;
  if g_boNpcAutoSelDrink then Exit;
  if not g_boPermitSelDrink then Exit;
  g_btPlaySelDrink := TDButton(Sender).Tag;  //���ѡ�ľ�
  FrmMain.ClientGetPlayDrinkSay(g_nCurMerchant,2,'��̳�Ƹ�˭�Ⱥ��أ�  <�Է�/@@@�Է�> <�Լ�/@@@�Լ�>');
end;

procedure TFrmDlg.DPDrink1Click(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   butt: TDButton;
   sel: Integer;
begin
   butt := TDButton(Sender);
   if not g_boItemMoving then begin
      if g_PDrinkItem[butt.Tag].s.Name <> '' then begin
         ItemClickSound (g_PDrinkItem[butt.Tag].s);
         if (g_MovingItem.Item.S.Name <> '') or (g_WaitingItemUp.Item.S.Name <> '') then exit;
         sel := -1;
         if Sender = DPDrink1 then sel := 0;
         if Sender = DPDrink2 then sel := 1;
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -(sel + 45);
         g_MovingItem.Item := g_PDrinkItem[butt.Tag];
         g_PDrinkItem[butt.Tag].s.Name := '';
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) or (g_MovingItem.Index = -99) then Exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -45) or (g_MovingItem.Index = -46) then begin
         if (g_MovingItem.Item.s.StdMode = 60) and (g_MovingItem.Item.s.Shape = 0) then begin  //���վ�
           ItemClickSound (g_MovingItem.Item.S);
           if g_PDrinkItem[butt.Tag].s.Name <> '' then begin //�ڸ��� ������
              temp := g_PDrinkItem[butt.Tag];
              g_PDrinkItem[butt.Tag] := g_MovingItem.Item;
              g_MovingItem.Index := -(sel + 45);
              g_MovingItem.Item := temp
           end else begin
              g_PDrinkItem[butt.Tag] := g_MovingItem.Item;
              g_MovingItem.Item.S.name := '';
              g_boItemMoving := FALSE;
           end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DPDrink1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TDButton(Sender).ShowHint := True;
end;

procedure TFrmDlg.DWPleaseDrinkMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  DPDrink1.ShowHint := False;
  DPDrink2.ShowHint := False;
end;

procedure TFrmDlg.DPleaseDrinkExitClick(Sender: TObject; X, Y: Integer);
begin
  DWPleaseDrink.Visible := False;
  if g_PDrinkItem[0].s.Name <> '' then begin
    AddItemBag(g_PDrinkItem[0]);
    g_PDrinkItem[0].s.Name := '';
  end;
  if g_PDrinkItem[1].s.Name <> '' then begin
    AddItemBag(g_PDrinkItem[1]);
    g_PDrinkItem[1].s.Name := '';
  end;
end;

procedure TFrmDlg.DPleaseDrinkDrinkClick(Sender: TObject; X, Y: Integer);
begin
  if g_PDrinkItem[0].s.Name = '' then begin
     FrmMain.ClientGetPlayDrinkSay(g_nCurMerchant,1,'�����ˣ��㲻�����ҺȾ����ҵľ��أ�');
     Exit;
  end;
  if g_PDrinkItem[1].s.Name = '' then begin
     FrmMain.ClientGetPlayDrinkSay(g_nCurMerchant,1,'�����ˣ������ҺȾƣ���ô�Լ������أ�');
     Exit;
  end;
  FrmMain.SendDrinkDrinkOK();
end;

procedure TFrmDlg.DWPleaseDrinkClick(Sender: TObject; X, Y: Integer);
var
   i, L, T: integer;
   p: PTClickPoint;
begin
   L := DWPleaseDrink.Left;
   T := DWPleaseDrink.Top;
   with DWPleaseDrink do
      if g_PlayDrinkPoints.Count > 0 then //20080629
      for i:=0 to g_PlayDrinkPoints.Count-1 do begin
         p := PTClickPoint (g_PlayDrinkPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            FrmMain.SendPlayDrinkDlgSelect (g_nCurMerchant, p.RStr);
            break;
         end;
      end;
end;

procedure TFrmDlg.DWPleaseDrinkMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   i, L, T: integer;
   p: PTClickPoint;
begin
   SelectMenuStr := '';
   L := DWPleaseDrink.Left;
   T := DWPleaseDrink.Top;
   with DWPleaseDrink do
      if g_PlayDrinkPoints.Count > 0 then //20080629
      for i:=0 to g_PlayDrinkPoints.Count-1 do begin
         p := PTClickPoint (g_PlayDrinkPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            SelectMenuStr := p.RStr;
            break;
         end;
      end;
end;

procedure TFrmDlg.DWPleaseDrinkMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SelectMenuStr := '';
end;

procedure TFrmDlg.DLOGODirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  if GetTickCount - g_dwLogoTick > 1000 then begin
    g_dwLogoTick := GetTickCount;
    Inc(g_nLogoTimer);
    if g_nLogoTimer > 5 then begin
      DLOGOClick( DLOGO, 0, 0);
      Exit;
    end;
  end;
  d:=FrmMain.UiDXImageList.Items.Find('LOGO').PatternSurfaces[0];
  if d<>nil then begin
  LoginScene.m_EdId.Visible := FALSE;
  LoginScene.m_EdPasswd.Visible := False;
  dsurface.FillRect(rect(0,  //���      ����ɫ����
                    0,      //�ϱ�
                    800,   //�ұ�
                    600),255);//�±�
  dsurface.Draw ((800 - d.Width) div 2, (600 - d.Height) div 2, d.ClientRect, d, TRUE);
  end;
end;

procedure TFrmDlg.DLOGOClick(Sender: TObject; X, Y: Integer);
begin
  DLOGO.Visible := False;
  LoginScene.m_EdId.Visible := True;
  LoginScene.m_EdPasswd.Visible := True;
  LoginScene.m_EdId.SetFocus;
  FrmMain.UiDXImageList.Items[34].Picture.Assign(nil);
  PlayBGM (bmg_intro);
end;

procedure TFrmDlg.DFriendDlgFrdDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   b: TDButton;
   d: TDirectDrawSurface;
begin
   b := nil;
   case g_btFriendTypePage of
      1: b := DFriendDlgFrd;
      2: b := DFriendDlgMasterOrder;
      3: b := DHeiMingDan;
   end;
   if b = Sender then begin
      with b do begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
      end;
   end;
end;

procedure TFrmDlg.DFriendDlgFrdClick(Sender: TObject; X, Y: Integer);
begin
  g_btFriendTypePage := TDButton(Sender).Tag;
  if g_btFriendTypePage in [1,3] then begin
    DFriendList.Visible := True;
    DAddFriend.Visible := True;
    DDelFriend.Visible := True;
    DPrevFriendDlg.Visible := True;
    DNextFriendDlg.Visible := True;
    g_btFriendPage := 0;
  end else begin
    DFriendList.Visible := False;
    DAddFriend.Visible := False;
    DDelFriend.Visible := False;
    DPrevFriendDlg.Visible := False;
    DNextFriendDlg.Visible := False;
  end;
end;

procedure TFrmDlg.DFriendDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d:TDirectDrawSurface;
begin
  with DFriendDlg do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;

    if g_btFriendTypePage = 2 then begin//ʦͽ
      d := g_WMain3Images.Images[478];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left) + 9, SurfaceY(Top) + 38, d.ClientRect, d, TRUE);
    end;
  end;
end;

procedure TFrmDlg.DFriendListDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  msgtop, msgline, I,M: Integer;
begin
  with DFriendList do begin
    with dsurface.Canvas do begin
      {$IF Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      {$IFEND}
      Font.Color := clWhite;
      case g_btFriendTypePage of
         1: begin
           msgtop := g_btFriendPage * 10;
           msgline := _MIN(g_btFriendPage * 10 + 10, g_FriendList.Count);
           for I:= msgtop to msgline-1 do begin
            m := I - msgtop;
            if I = g_btFriendIndex then
             Font.Color := clRed
            else Font.Color := clWhite;
             {$IF Version = 1}
             TextOut (SurfaceX(Left), SurfaceY(Top) + M*17,g_FriendList.Strings[I]);
             {$ELSE}
             clFunc.TextOut (dsurface, SurfaceX(Left), SurfaceY(Top) + M*17, Font.Color, g_FriendList.Strings[I]);
             {$IFEND}
           end;
         end;
         3: begin
           msgtop := g_btFriendPage * 10;
           msgline := _MIN(g_btFriendPage * 10 + 10, g_HeiMingDanList.Count);
           for I:= msgtop to msgline-1 do begin
            m := I - msgtop;
            if I = g_btFriendIndex then
             Font.Color := clRed
            else Font.Color := clWhite;
             {$IF Version = 1}
             TextOut (SurfaceX(Left), SurfaceY(Top) + M*17,g_HeiMingDanList.Strings[I]);
             {$ELSE}
             clFunc.TextOut (dsurface, SurfaceX(Left), SurfaceY(Top) + M*17, Font.Color, g_HeiMingDanList.Strings[I]);
             {$IFEND}
           end;
         end;
      end;
      Release;
    end;
  end;
end;

procedure TFrmDlg.DFriendListDblClick(Sender: TObject);
var
  lx,ly, idx, msgtop: Integer;
begin
   lx := g_btFriendMoveX - DFriendList.Left;
   ly := g_btFriendMoveY - DFriendList.Top;

   case g_btFriendTypePage of
     1: begin
        if (lx >= 0) and (lx <= DFriendList.Width) and (ly >= 0) and (ly <= 330) then begin
          idx := ly div 17;
          if idx < g_FriendList.Count then begin
             msgtop := g_btFriendPage * 10;
             g_btFriendIndex := idx + msgtop;
             if g_FriendList.Strings[g_btFriendIndex] <> '' then begin
               PlayScene.EdChat.Visible := TRUE;
               PlayScene.EdChat.Text := '/'+ g_FriendList.Strings[g_btFriendIndex]+' ';
               PlayScene.EdChat.SetFocus;
               SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
               PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
             end;
          end;
        end;
     end;
     3: begin
        if (lx >= 0) and (lx <= DFriendList.Width) and (ly >= 0) and (ly <= 330) then begin
          idx := ly div 17;
          if idx < g_HeiMingDanList.Count then begin
             msgtop := g_btFriendPage * 10;
             g_btFriendIndex := idx + msgtop;
             if g_HeiMingDanList.Strings[g_btFriendIndex] <> '' then begin
               PlayScene.EdChat.Visible := TRUE;
               PlayScene.EdChat.Text := '/'+ g_HeiMingDanList.Strings[g_btFriendIndex]+' ';
               PlayScene.EdChat.SetFocus;
               SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
               PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
             end;
          end;
        end;
     end;
   end;
end;

procedure TFrmDlg.DFriendListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  lx,ly, idx, msgtop: Integer;
begin
  g_btFriendMoveX := x;
  g_btFriendMoveY := Y;
   lx := X - DFriendList.Left;
   ly := Y - DFriendList.Top;
   case g_btFriendTypePage of
     1: begin
        if (lx >= 0) and (lx <= DFriendList.Width) and (ly >= 0) and (ly <= 330) then begin
          idx := ly div 17;
          if idx < g_FriendList.Count then begin
            msgtop := g_btFriendPage * 10;
            g_btFriendIndex := idx + msgtop;
          end;
        end;
     end;
     3: begin
        if (lx >= 0) and (lx <= DFriendList.Width) and (ly >= 0) and (ly <= 330) then begin
          idx := ly div 17;
          if idx < g_HeiMingDanList.Count then begin
            msgtop := g_btFriendPage * 10;
            g_btFriendIndex := idx + msgtop;
          end;
        end;
     end;
   end;
end;

procedure TFrmDlg.DPrevFriendDlgClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DPrevFriendDlg then begin
      if g_btFriendPage > 0 then
         Dec (g_btFriendPage);
   end else begin
      if g_btFriendTypePage = 1 then begin
        if g_btFriendPage < (g_FriendList.Count+9) div 10 - 1 then
           Inc (g_btFriendPage);
      end;
      if g_btFriendTypePage = 3 then begin
        if g_btFriendPage < (g_HeiMingDanList.Count+9) div 10 - 1 then
           Inc (g_btFriendPage);
      end;
   end;
end;

procedure TFrmDlg.DAddFriendClick(Sender: TObject; X, Y: Integer);
  function GetPageCount(List: TStringList): Integer;
  begin
    Result := List.Count div 10;
    if List.Count mod 10 > 0 then Inc(Result);
  end;
var
  int: Integer;
begin
  if g_btFriendTypePage = 1 then begin
    int := 0;
    DMessageDlg ('����µĺ���', [mbOk, mbAbort]);
    if DlgEditText = '' then Exit;
    if length(DlgEditText) > 14 then int := 3;
    if int = 0 then begin
        g_FriendList.Add(DlgEditText);
        g_btFriendPage := GetPageCount(g_FriendList) - 1;
    end else DMessageDlg ('����������С��15λ', [mbOk]);
  end else begin
    int := 0;
    DMessageDlg ('����µĺ�����', [mbOk, mbAbort]);
    if DlgEditText = '' then Exit;
    if length(DlgEditText) > 14 then int := 3;
    if int = 0 then begin
        g_HeiMingDanList.Add(DlgEditText);
        g_btFriendPage := GetPageCount(g_HeiMingDanList) - 1;
    end else DMessageDlg ('����������С��15λ', [mbOk]);
  end;
end;

procedure TFrmDlg.DDelFriendClick(Sender: TObject; X, Y: Integer);
var
  sUserName: string;
begin
  if g_btFriendTypePage = 1 then sUserName := g_FriendList.Strings[g_btFriendIndex]
  else sUserName := g_HeiMingDanList.Strings[g_btFriendIndex];
  if mrOk = FrmDlg.DMessageDlg ('��ȷ��ɾ�� [ ' + sUserName+' ] ��', [mbOk, mbCancel]) then begin
    if g_btFriendTypePage = 1 then g_FriendList.Delete(g_btFriendIndex)
    else g_HeiMingDanList.Delete(g_btFriendIndex);
  end;
end;

procedure TFrmDlg.DInternetClick(Sender: TObject; X, Y: Integer);
begin
  if g_sGameESystem <> '' then
  frmBrowser.Open(g_sGameESystem);
end;

procedure TFrmDlg.DStMagHero1Click(Sender: TObject; X, Y: Integer);
var
   idx: integer;
   keych: char;
   pm: PTClientMagic;
begin
   if HeroStatePage = 3 then begin
      idx := TDButton(Sender).Tag + HeroMagTop;
      if (idx >= 0) and (idx < g_HeroMagicList.Count) then begin
         pm := PTClientMagic (g_HeroMagicList[idx]);
         if not (pm.Def.wMagicId in [3,4,60..65,67]) then begin
           if word(pm.Key) = 0 then
             keych := char(word(1))
           else keych := char(word(0));
           pm.Key := keych;
           FrmMain.SendHeroMagicKeyChange (pm.Def.wMagicId, keych);
         end;
      end;
   end;
end;

procedure TFrmDlg.DWCheckNumDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
{  I,j,k,o,p:   Integer;
  vPoint:   TPoint;
  vLeft:   Integer;  }
begin
  with DWCheckNum do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
    with dsurface.Canvas do begin
      {$if Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      {$IFEND}
      Font.Style := Font.Style + [fsBold];  //��������
      BoldTextOut (dsurface, Left + 14, Top + 14, $0040BBF1, clBlack, 'ͼƬ��֤��:');
      Font.Style := [];  //����ȥ������
      Release;
    end;
    d := FrmMain.UiDXImageList.Items.Find('CheckNum').PatternSurfaces[0];
    if d <> nil then begin
       dsurface.Draw (SurfaceX(Left)+60, SurfaceY(Top)+50, d.ClientRect, d, TRUE);
    end;
  end;
end;

procedure TFrmDlg.DCheckNumOKDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if not TDButton(Sender).Downed then begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          Font.Style := Font.Style + [fsBold];
          BoldTextOut (dsurface, SurfaceX(Left) + 28 - FrmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2, SurfaceY(Top) + 6, $008CC6EF, clBlack, TDButton(Sender).Hint);
          Font.Style := [];
          Release;
        end;
      end else begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex + 1];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          Font.Style := Font.Style + [fsBold];
          BoldTextOut (dsurface, SurfaceX(Left) + 30 - FrmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2, SurfaceY(Top) + 7, $0040BBF1, clBlack, TDButton(Sender).Hint);
          Font.Style := [];
          Release;
        end;
      end;
   end;
end;

procedure TFrmDlg.DCheckNumOKClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.SendCheckNum(DEditCheckNum.Text);
//g_boIsChangeCheckNum:= True;

end;

procedure TFrmDlg.DEditCheckNumKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9','a'..'z','A'..'Z', #8, #13]) then
    Key := #0;
end;

procedure TFrmDlg.DEditCheckNumKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then DCheckNumOKClick(DCheckNumOK ,0 , 0);
end;

procedure TFrmDlg.DCheckNumChangeClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.SendChangeCheckNum();
end;

procedure TFrmDlg.DWMakeWineDeskDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with DWMakeWineDesk do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;


      d := g_WMain2Images.Images[586];   //����ͼ
      if d <> nil then
        dsurface.Draw (SurfaceX(Left + 100), SurfaceY(Top + 9), d.ClientRect, d, TRUE);
      if g_MakeTypeWine = 0 then begin  //��ͨ��
        if g_WineItem[0].s.Name <> '' then begin
          d := g_WMain2Images.Images[598];   //ͼ�оƵ�����ͼ
          if d <> nil then
            dsurface.Draw (SurfaceX(Left + 235), SurfaceY(Top + 124), d.ClientRect, d, TRUE);
        end;
        if g_WineItem[1].s.Name <> '' then begin
          d := g_WMain2Images.Images[596];   //ͼ�оƵ�����ͼ
          if d <> nil then
            dsurface.Draw (SurfaceX(Left + 121), SurfaceY(Top + 109), d.ClientRect, d, TRUE);
        end;
        if g_WineItem[2].s.Name <> '' then begin
          d := g_WMain2Images.Images[597];   //ͼ�оƵ�����ͼ
          if d <> nil then
            dsurface.Draw (SurfaceX(Left + 155), SurfaceY(Top + 167), d.ClientRect, d, TRUE);
        end;
        if g_WineItem[4].s.Name <> '' then begin
          d := g_WMain2Images.Images[599];   //ͼ�оƵ�����ͼ
          if d <> nil then
            dsurface.Draw (SurfaceX(Left + 288), SurfaceY(Top + 119), d.ClientRect, d, TRUE);
        end;
        if g_WineItem[5].s.Name <> '' then begin
          d := g_WMain2Images.Images[600];   //ͼ�оƵ�����ͼ
          if d <> nil then
            dsurface.Draw (SurfaceX(Left + 330), SurfaceY(Top + 137), d.ClientRect, d, TRUE);
        end;
        if g_WineItem[6].s.Name <> '' then begin
          d := g_WMain2Images.Images[601];   //ͼ�оƵ�����ͼ
          if d <> nil then
            dsurface.Draw (SurfaceX(Left + 294), SurfaceY(Top + 147), d.ClientRect, d, TRUE);
        end;
    end else begin  //ҩ��
        if g_DrugWineItem[0].s.Name <> '' then begin
          d := g_WMain2Images.Images[603];   //ͼ�оƵ�����ͼ
          if d <> nil then
            dsurface.Draw (SurfaceX(Left + 244), SurfaceY(Top + 107), d.ClientRect, d, TRUE);
        end;
        if g_DrugWineItem[1].s.Name <> '' then begin
          d := g_WMain2Images.Images[602];   //ͼ�оƵ�����ͼ
          if d <> nil then
            dsurface.Draw (SurfaceX(Left + 158), SurfaceY(Top + 132), d.ClientRect, d, TRUE);
        end;
    end;

    if g_sNpcName <> '' then begin  //��NPC����
      with dsurface.Canvas do begin
         {$IF Version = 1}
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (Left + 50 - TextWidth(g_sNpcName) div 2, Top + 110, g_sNpcName);
         {$ELSE}
         clFunc.TextOut (dsurface, Left + 50 - FrmMain.Canvas.TextWidth(g_sNpcName) div 2, Top + 110, clWhite, g_sNpcName);
         {$IFEND}
         Release;
      end;
    end;

    if DMaterialMemo.ShowHint then begin
         d := g_WMain2Images.Images[589];   //����˵��
         if d <> nil then
            dsurface.Draw (SurfaceX(Left + 102), SurfaceY(Top + 13), d.ClientRect, d, True);
     if g_MakeTypeWine = 0 then begin    //��ͨ��
         with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          BoldTextOut (dsurface, SurfaceX(Left + 108), SurfaceY(Top + 21), clWhite, clBlack, '���ϵ�Ʒ���Ǿ�Ʒ�ʵĻ�����Ʒ��Խ�ã���Խ');
          BoldTextOut (dsurface, SurfaceX(Left + 108), SurfaceY(Top + 35), clWhite, clBlack, '�п�������þơ����У�������б���������');
          BoldTextOut (dsurface, SurfaceX(Left + 108), SurfaceY(Top + 49), clWhite, clBlack, 'ˮ�������ˮ������������ƾ͸����ˡ�');
          Release;
         end;
      end else begin   //ҩ��
         with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          BoldTextOut (dsurface, SurfaceX(Left + 108), SurfaceY(Top + 21), clWhite, clBlack, 'ҩ�ƵĹ�Ч��ҪԴ��ҩ�ģ���ͬ��ҩ�Ļ��в�');
          BoldTextOut (dsurface, SurfaceX(Left + 108), SurfaceY(Top + 35), clWhite, clBlack, 'ͬ��Ч������˵����һЩ���ص�ҩ�ƣ����ܻ�');
          BoldTextOut (dsurface, SurfaceX(Left + 108), SurfaceY(Top + 49), clWhite, clBlack, '������ҩ�Ƶ�ƿ������Ҫ��');
          Release;
         end;
      end;
    end;

    if g_MakeTypeWine = 0 then begin    //��ͨ��
      d := g_WMain2Images.Images[585];   //����ͼ
      if d <> nil then
        dsurface.Draw (SurfaceX(Left + 98), SurfaceY(Top + 200), d.ClientRect, d, TRUE);
    end else begin //ҩ��
      d := g_WMain2Images.Images[587];   //����ͼ
      if d <> nil then
        dsurface.Draw (SurfaceX(Left + 98), SurfaceY(Top + 200), d.ClientRect, d, TRUE);
    end;


    if DMakeWineHelp.ShowHint then begin  //������
      if g_MakeTypeWine = 0 then begin    //��ͨ��
        d := g_WMain2Images.Images[592];
        if d <> nil then
          dsurface.Draw (SurfaceX(Left + 100), SurfaceY(Top - 2), d.ClientRect, d, TRUE);
      end else begin  //ҩ��
        d := g_WMain2Images.Images[593];
        if d <> nil then
          dsurface.Draw (SurfaceX(Left + 100), SurfaceY(Top - 2), d.ClientRect, d, TRUE);
      end;
    end;
    if DStartMakeWine.ShowHint then begin
        d := g_WMain2Images.Images[588];   //������Ƶı���ͼ
        if d <> nil then
          dsurface.Draw (SurfaceX(Left + 100), SurfaceY(Top + 9), d.ClientRect, d, TRUE);
          
        if GetTickCount - g_dwShowStartMakeWineTick > 150 then begin
         g_dwShowStartMakeWineTick := GetTickCount;
         inc(g_nShowStartMakeWineImg);

            if g_nShowStartMakeWineImg > 18 then begin
              DStartMakeWine.ShowHint := False;
              FrmMain.SendMakeWineItems;
            end;

      end;
        d := g_WMain2Images.Images[610+g_nShowStartMakeWineImg];   //������Ƶı���ͼ
        if d <> nil then
          dsurface.Draw (SurfaceX(Left + 165), SurfaceY(Top + 9), d.ClientRect, d, TRUE);




       {d := g_WMain2Images.Images[594];   //����ͼ
        if d <> nil then
          DrawBlendEx(dsurface,SurfaceX(Left+100),
                    SurfaceY(Top), d,0,0,d.Width,d.Height, 0); }
    end;
  end;
end;

procedure TFrmDlg.DMakeWineHelpDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if DStartMakeWine.ShowHint then begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          Font.Style := Font.Style + [fsBold];
          BoldTextOut (dsurface, SurfaceX(Left + 36 - FrmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2), SurfaceY(Top) + 5, clGrayText, clBlack, TDButton(Sender).Hint);
          Font.Style := [];
          Release;
        end;
        Exit;
      end;

      if not TDButton(Sender).Downed then begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          Font.Style := Font.Style + [fsBold];
          BoldTextOut (dsurface, SurfaceX(Left + 36 - FrmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2), SurfaceY(Top) + 5, $008CC6EF, clBlack, TDButton(Sender).Hint);
          Font.Style := [];
          Release;
        end;
      end else begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex + 1];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          Font.Style := Font.Style + [fsBold];
          BoldTextOut (dsurface, SurfaceX(Left + 38 - FrmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2), SurfaceY(Top) + 6, $0040BBF1, clBlack, TDButton(Sender).Hint);
          Font.Style := [];
          Release;
        end;
      end;
      if not TDButton(Sender).Moveed then begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          Font.Style := Font.Style + [fsBold];
          BoldTextOut (dsurface, SurfaceX(Left + 36 - FrmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2), SurfaceY(Top) + 5, $00ADD7EF, clBlack, TDButton(Sender).Hint);
          Font.Style := [];
          Release;
        end;
      end;
   end;
end;

procedure TFrmDlg.DMakeWineDeskCloseClick(Sender: TObject; X, Y: Integer);
var
 I: Integer;
begin
  if DStartMakeWine.ShowHint then Exit;
  DWMakeWineDesk.Visible := False;
  DItemBag.Visible := False;
  if g_MakeTypeWine = 0 then begin //��ͨ��
    for I:=Low(g_WineItem) to High(g_WineItem) do begin
      if g_WineItem[I].s.Name <> '' then begin
        AddItemBag(g_WineItem[I]);
        g_WineItem[I].s.Name := '';
      end;
    end;
  end else begin
    for I:=Low(g_DrugWineItem) to High(g_DrugWineItem) do begin
      if g_DrugWineItem[I].s.Name <> '' then begin  //ҩ��
        AddItemBag(g_DrugWineItem[I]);
        g_DrugWineItem[I].s.Name := '';
      end;
    end;
  end;
end;

procedure TFrmDlg.DMakeWineHelpClick(Sender: TObject; X, Y: Integer);
begin
  if DStartMakeWine.ShowHint then Exit;
  ShowMakeWine(False); //��������BUTTON
  DMakeWineHelp.ShowHint := True;   //���´˰�ť
end;

procedure TFrmDlg.DMaterialMemoClick(Sender: TObject; X, Y: Integer);
begin
  if DStartMakeWine.ShowHint then Exit;
  ShowMakeWine(True); //��ʾ����BUTTON
  DMakeWineHelp.ShowHint := False;   //ȥ�������ð���ΪFALSE
  DMaterialMemo.ShowHint := True;    //���´˰�ť
end;

procedure TFrmDlg.DBMateriaMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Butt:TDButton;
begin
   Butt:=TDButton(Sender);
   DScreen.ShowHint(Butt.SurfaceX(Butt.Left), Butt.SurfaceY(Butt.Top - 18), Butt.Hint, clWhite, FALSE);
   g_MouseItem := g_WineItem[Butt.Tag];
end;

procedure TFrmDlg.DWMakeWineDeskMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  DScreen.ClearHint;
  g_MouseItem.S.Name := '';
end;

procedure TFrmDlg.ShowMakeWine(bool:Boolean);
begin
    DBMateria.Visible := False;
    DBWineSong.Visible := False;
    DBWater.Visible := False;
    DBWineCrock.Visible := False;
    DBAssistMaterial1.Visible := False;
    DBAssistMaterial2.Visible := False;
    DBAssistMaterial3.Visible := False;
    DBDrug.Visible := False;
    DBWine.Visible := False;
    DBWineBottle.Visible := False;
  if g_MakeTypeWine = 0 then begin //��ͨ��
    DBMateria.Visible := bool;
    DBWineSong.Visible := bool;
    DBWater.Visible := bool;
    DBWineCrock.Visible := bool;
    DBAssistMaterial1.Visible := bool;
    DBAssistMaterial2.Visible := bool;
    DBAssistMaterial3.Visible := bool;
  end else begin  //ҩ��
    DBDrug.Visible := bool;
    DBWine.Visible := bool;
    DBWineBottle.Visible := bool;
  end;
end;

procedure TFrmDlg.DBMateriaClick(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   butt: TDButton;
begin
   if DStartMakeWine.ShowHint then Exit;
   butt := TDButton(Sender);
   if not g_boItemMoving then begin
      if g_WineItem[butt.Tag].s.Name <> '' then begin
         ItemClickSound (g_WineItem[butt.Tag].s);
         if (g_MovingItem.Item.S.Name <> '') or (g_WaitingWineItem.Item.S.Name <> '') then exit;
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -(butt.Tag + 47);
         g_MovingItem.Item := g_WineItem[butt.Tag];
         g_WineItem[butt.Tag].s.Name := '';
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) or (g_MovingItem.Index = -99) then Exit;  //-97 -98 �ǽ��
      if (g_MovingItem.Index = -45) or (g_MovingItem.Index = -46) then Exit;  //-45 .. -46 ���������վ���Ʒ
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -47) or (g_MovingItem.Index = -48) or (g_MovingItem.Index = -49)
         or (g_MovingItem.Index = -50) or (g_MovingItem.Index = -51) or (g_MovingItem.Index = -52) or (g_MovingItem.Index = -53) then begin
           case butt.Tag of
             0: if g_MovingItem.Item.s.StdMode <> 8 then Exit;
             1: if g_MovingItem.Item.s.StdMode <> 13 then Exit;
             2: if g_MovingItem.Item.s.StdMode <> 9 then Exit;
             3: if g_MovingItem.Item.s.StdMode <> 12 then Exit;
             4: if g_MovingItem.Item.s.StdMode <> 8 then Exit;
             5: if g_MovingItem.Item.s.StdMode <> 8 then Exit;
             6: if g_MovingItem.Item.s.StdMode <> 8 then Exit;
           end;
           ItemClickSound (g_MovingItem.Item.S);
           if g_WineItem[butt.Tag].s.Name <> '' then begin //�ڸ��� ������
              temp := g_WineItem[butt.Tag];
              g_WineItem[butt.Tag] := g_MovingItem.Item;
              g_MovingItem.Index := -(butt.Tag + 47);
              g_MovingItem.Item := temp
           end else begin
              g_WineItem[butt.Tag] := g_MovingItem.Item;
              g_MovingItem.Item.S.name := '';
              g_boItemMoving := FALSE;
           end;
      end;
   end;
end;

procedure TFrmDlg.DBMateriaDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  idx: Integer;
  Butt:TDButton;
begin
  if Sender = DBMateria then begin
    Butt:=TDButton(Sender);
    with Butt do begin
      if g_WineItem[Butt.Tag].s.Name <> '' then begin
        idx := g_WineItem[Butt.Tag].S.Looks;
        if idx >= 0 then begin
            d := g_WBagItemImages.Images[idx];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else begin
        if (g_MovingItem.Item.s.StdMode = 8) and g_boItemMoving then begin
          d:=FrmMain.UiDXImageList.Items.Find('MakeWineSel').PatternSurfaces[0];
          if d<>nil then
            DrawBlendEx (dsurface, SurfaceX(Left), SurfaceY(Top), d, 0, 0, d.Width, d.Height, 0);
        end;
      end;
    end;
  end;
  if Sender = DBWineSong then begin
    Butt:=TDButton(Sender);
    with Butt do begin
      if g_WineItem[Butt.Tag].s.Name <> '' then begin
        idx := g_WineItem[Butt.Tag].S.Looks;
        if idx >= 0 then begin
            d := g_WBagItemImages.Images[idx];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else begin
        if (g_MovingItem.Item.s.StdMode = 13) and g_boItemMoving then begin
          d:=FrmMain.UiDXImageList.Items.Find('MakeWineSel').PatternSurfaces[0];
          if d<>nil then
            DrawBlendEx (dsurface, SurfaceX(Left), SurfaceY(Top), d, 0, 0, d.Width, d.Height, 0);
        end;
      end;
    end;
  end;
  if Sender = DBWater then begin
    Butt:=TDButton(Sender);
    with Butt do begin
      if g_WineItem[Butt.Tag].s.Name <> '' then begin
        idx := g_WineItem[Butt.Tag].S.Looks;
        if idx >= 0 then begin
            d := g_WBagItemImages.Images[idx];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else begin
        if (g_MovingItem.Item.s.StdMode = 9) and g_boItemMoving then begin
          d:=FrmMain.UiDXImageList.Items.Find('MakeWineSel').PatternSurfaces[0];
          if d<>nil then
            DrawBlendEx (dsurface, SurfaceX(Left), SurfaceY(Top), d, 0, 0, d.Width, d.Height, 0);
        end;
      end;
    end;
  end;
  if Sender = DBWineCrock then begin
    Butt:=TDButton(Sender);
    with Butt do begin
      if g_WineItem[Butt.Tag].s.Name <> '' then begin
        idx := g_WineItem[Butt.Tag].S.Looks;
        if idx >= 0 then begin
            d := g_WBagItemImages.Images[idx];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else begin
        if (g_MovingItem.Item.s.StdMode = 12) and g_boItemMoving then begin
          d:=FrmMain.UiDXImageList.Items.Find('MakeWineSel').PatternSurfaces[0];
          if d<>nil then
            DrawBlendEx (dsurface, SurfaceX(Left), SurfaceY(Top), d, 0, 0, d.Width, d.Height, 0);
        end;
      end;
    end;
  end;
  if Sender = DBAssistMaterial1 then begin
    Butt:=TDButton(Sender);
    with Butt do begin
      if g_WineItem[Butt.Tag].s.Name <> '' then begin
        idx := g_WineItem[Butt.Tag].S.Looks;
        if idx >= 0 then begin
            d := g_WBagItemImages.Images[idx];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else begin
        if (g_MovingItem.Item.s.StdMode = 8) and g_boItemMoving then begin
          d:=FrmMain.UiDXImageList.Items.Find('MakeWineSel').PatternSurfaces[0];
          if d<>nil then
            DrawBlendEx (dsurface, SurfaceX(Left), SurfaceY(Top), d, 0, 0, d.Width, d.Height, 0);
        end;
      end;
    end;
  end;
  if Sender = DBAssistMaterial2 then begin
    Butt:=TDButton(Sender);
    with Butt do begin
      if g_WineItem[Butt.Tag].s.Name <> '' then begin
        idx := g_WineItem[Butt.Tag].S.Looks;
        if idx >= 0 then begin
            d := g_WBagItemImages.Images[idx];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else begin
        if (g_MovingItem.Item.s.StdMode = 8) and g_boItemMoving then begin
          d:=FrmMain.UiDXImageList.Items.Find('MakeWineSel').PatternSurfaces[0];
          if d<>nil then
            DrawBlendEx (dsurface, SurfaceX(Left), SurfaceY(Top), d, 0, 0, d.Width, d.Height, 0);
        end;
      end;
    end;
  end;
  if Sender = DBAssistMaterial3 then begin
    Butt:=TDButton(Sender);
    with Butt do begin
      if g_WineItem[Butt.Tag].s.Name <> '' then begin
        idx := g_WineItem[Butt.Tag].S.Looks;
        if idx >= 0 then begin
            d := g_WBagItemImages.Images[idx];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else begin
        if (g_MovingItem.Item.s.StdMode = 8) and g_boItemMoving then begin
          d:=FrmMain.UiDXImageList.Items.Find('MakeWineSel').PatternSurfaces[0];
          if d<>nil then
            DrawBlendEx (dsurface, SurfaceX(Left), SurfaceY(Top), d, 0, 0, d.Width, d.Height, 0);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBDrugDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  idx: Integer;
  Butt:TDButton;
begin
  if Sender = DBDrug then begin
    Butt:=TDButton(Sender);
    with Butt do begin
      if g_DrugWineItem[Butt.Tag].s.Name <> '' then begin
        idx := g_DrugWineItem[Butt.Tag].S.Looks;
        if idx >= 0 then begin
            d := g_WBagItemImages.Images[idx];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else begin
        if (g_MovingItem.Item.s.StdMode = 14) and g_boItemMoving then begin
          d:=FrmMain.UiDXImageList.Items.Find('MakeWineSel').PatternSurfaces[0];
          if d<>nil then
            DrawBlendEx (dsurface, SurfaceX(Left), SurfaceY(Top), d, 0, 0, d.Width, d.Height, 0);
        end;
      end;
    end;
  end;
  if Sender = DBWine then begin
    Butt:=TDButton(Sender);
    with Butt do begin
      if g_DrugWineItem[Butt.Tag].s.Name <> '' then begin
        idx := g_DrugWineItem[Butt.Tag].S.Looks;
        if idx >= 0 then begin
            d := g_WBagItemImages.Images[idx];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else begin
        if (g_MovingItem.Item.s.StdMode = 60) and g_boItemMoving then begin
          d:=FrmMain.UiDXImageList.Items.Find('MakeWineSel').PatternSurfaces[0];
          if d<>nil then
            DrawBlendEx (dsurface, SurfaceX(Left), SurfaceY(Top), d, 0, 0, d.Width, d.Height, 0);
        end;
      end;
    end;
  end;
  if Sender = DBWineBottle then begin
    Butt:=TDButton(Sender);
    with Butt do begin
      if g_DrugWineItem[Butt.Tag].s.Name <> '' then begin
        idx := g_DrugWineItem[Butt.Tag].S.Looks;
        if idx >= 0 then begin
            d := g_WBagItemImages.Images[idx];
            if d <> nil then
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else begin
        if (g_MovingItem.Item.s.StdMode = 12) and g_boItemMoving then begin
          d:=FrmMain.UiDXImageList.Items.Find('MakeWineSel').PatternSurfaces[0];
          if d<>nil then
            DrawBlendEx (dsurface, SurfaceX(Left), SurfaceY(Top), d, 0, 0, d.Width, d.Height, 0);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBDrugClick(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   butt: TDButton;
begin
   if DStartMakeWine.ShowHint then Exit;
   butt := TDButton(Sender);
   if not g_boItemMoving then begin
      if g_DrugWineItem[butt.Tag].s.Name <> '' then begin
         ItemClickSound (g_DrugWineItem[butt.Tag].s);
         if (g_MovingItem.Item.S.Name <> '') or (g_WaitingDrugWineItem.Item.S.Name <> '') then exit;
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -(butt.Tag + 54);
         g_MovingItem.Item := g_DrugWineItem[butt.Tag];
         g_DrugWineItem[butt.Tag].s.Name := '';
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) or (g_MovingItem.Index = -99) then Exit;  //-97 -98 �ǽ��
      if (g_MovingItem.Index = -45) or (g_MovingItem.Index = -46) then Exit;  //-45 .. -46 ���������վ���Ʒ
      if (g_MovingItem.Index = -47) or (g_MovingItem.Index = -48) or (g_MovingItem.Index = -49)
         or (g_MovingItem.Index = -50) or (g_MovingItem.Index = -51) or (g_MovingItem.Index = -52) or (g_MovingItem.Index = -53) then Exit; //��ͨ����Ʒ
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -54) or (g_MovingItem.Index = -55) or (g_MovingItem.Index = -56) then begin
           case butt.Tag of
             0: if g_MovingItem.Item.s.StdMode <> 14 then Exit;
             1: if g_MovingItem.Item.s.StdMode <> 60 then Exit;
             2: if g_MovingItem.Item.s.StdMode <> 12 then Exit;
           end;
           ItemClickSound (g_MovingItem.Item.S);
           if g_DrugWineItem[butt.Tag].s.Name <> '' then begin //�ڸ��� ������
              temp := g_DrugWineItem[butt.Tag];
              g_DrugWineItem[butt.Tag] := g_MovingItem.Item;
              g_MovingItem.Index := -(butt.Tag + 54);
              g_MovingItem.Item := temp
           end else begin
              g_DrugWineItem[butt.Tag] := g_MovingItem.Item;
              g_MovingItem.Item.S.name := '';
              g_boItemMoving := FALSE;
           end;
      end;
   end;
end;

procedure TFrmDlg.DStartMakeWineClick(Sender: TObject; X, Y: Integer);
begin
  if g_boItemMoving then Exit;
  if DStartMakeWine.ShowHint then Exit;
  if g_MakeTypeWine = 0 then begin //��ͨ��
     if (g_WineItem[0].s.Name = '') or (g_WineItem[2].s.Name = '') or (g_WineItem[3].s.Name = '')
      or (g_WineItem[4].s.Name = '') or (g_WineItem[5].s.Name = '') or (g_WineItem[6].s.Name = '') then Exit;
  end else begin  //ҩ��
    if (g_DrugWineItem[0].s.Name = '') or (g_DrugWineItem[1].s.Name = '') or (g_DrugWineItem[2].s.Name = '') then Exit;
  end;
  if DMakeWineHelp.ShowHint then begin
   DMakeWineHelp.ShowHint := False;
   ShowMakeWine(False); //��ʾ����BUTTON
  end;
  DStartMakeWine.ShowHint := True;
  g_nShowStartMakeWineImg := 0;
end;

procedure TFrmDlg.DDrunkScaleDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc: Trect;
begin
  with DDrunkScale do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;

    d := g_WMain2Images.Images[583];
    if d <> nil then begin
       rc := d.ClientRect;
       if (g_MySelf.m_Abil.WineDrinkValue > 0) then begin
       rc.Top := _Max(0,Round(rc.Bottom / g_MySelf.m_Abil.MaxAlcohol * (g_MySelf.m_Abil.MaxAlcohol - g_MySelf.m_Abil.WineDrinkValue)));
       dsurface.Draw (SurfaceX(Left) + rc.Left, SurfaceY(Top)+rc.Top, rc, d, FALSE);
       end;
    end;
  end;
end;

procedure TFrmDlg.DLiquorProgressDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc: Trect;
begin
  with DLiquorProgress do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;

    d := g_WMain2Images.Images[576];
    if d <> nil then begin
      rc := d.ClientRect;
      if g_MySelf.m_Abil.Alcohol > 0 then begin//���� 20080622
        rc.Right := Round((rc.Right-rc.Left) / g_MySelf.m_Abil.MaxAlcohol * g_MySelf.m_Abil.Alcohol);
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), rc, d, TRUE);
      end;
    end;
  end;
end;

procedure TFrmDlg.DBDrugMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Butt:TDButton;
begin
   Butt:=TDButton(Sender);
   DScreen.ShowHint(Butt.SurfaceX(Butt.Left), Butt.SurfaceY(Butt.Top - 18), Butt.Hint, clWhite, FALSE);
   g_MouseItem := g_DrugWineItem[Butt.Tag];
end;

procedure TFrmDlg.DHeroLiquorProgressDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  rc: Trect;
begin
  with DHeroLiquorProgress do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;

    d := g_WMain2Images.Images[576];
    if d <> nil then begin
      rc := d.ClientRect;
      if g_HeroSelf.m_Abil.Alcohol > 0 then begin//���� 20080622
        rc.Right := Round((rc.Right-rc.Left) / g_HeroSelf.m_Abil.MaxAlcohol * g_HeroSelf.m_Abil.Alcohol);
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), rc, d, TRUE);
      end;
    end;
  end;
end;


{var
   d: TDirectDrawSurface;
begin
   with Sender as TDCheckBox do begin
      if not TDCheckBox(Sender).Checked then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end else begin
         d := WLib.Images[FaceIndex + 1];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end; }
procedure TFrmDlg.DCheckSdoNameShowDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
  with Sender as TDCheckBox do begin
    if not TDCheckBox(Sender).Checked then begin
     d := g_qingqingImages.Images[7];
     if d <> nil then
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end else begin
     d := g_qingqingImages.Images[8];
     if d <> nil then
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
    if TDCheckBox(Sender).Moveed then Color := clWhite else Color := clSilver;
    with dsurface.Canvas do begin
      {$if Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      {$IFEND}
      if d <> nil then 
      BoldTextOut (dsurface, SurfaceX(Left + d.Width + 2), SurfaceY(Top) + 3, Color, clBlack, TDCheckBox(Sender).Hint);
      Release;
    end;
  end;
end;

procedure TFrmDlg.DNewSdoBasicDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if TDButton(Sender).Tag <> g_btSdoAssistantPage then begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
        end;
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          BoldTextOut (dsurface, SurfaceX(Left) + 24 - FrmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2, SurfaceY(Top) + 4, clWhite, clBlack, TDButton(Sender).Hint);
          Release;
        end;
      end else begin
        if WLib <> nil then begin //20080701
         d := WLib.Images[FaceIndex + 1];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top) - 2, d.ClientRect, d, TRUE);
        end;
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          BoldTextOut (dsurface, SurfaceX(Left) + 24 - FrmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2, SurfaceY(Top) + 2, clWhite, clBlack, TDButton(Sender).Hint);
          Release;
        end;
      end;
   end;
end;

procedure TFrmDlg.DWNewSdoAssistantDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  Int: Integer;
begin
  with DWNewSdoAssistant do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;

    case g_btSdoAssistantPage of
      0: begin //����
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          Font.Style := Font.Style + [fsBold];
          BoldTextOut (dsurface, SurfaceX(Left) + 30, SurfaceY(Top) + 50, clSilver, clBlack, '������������');
          BoldTextOut (dsurface, SurfaceX(Left) + 148, SurfaceY(Top) + 50, clSilver, clBlack, '��Ʒ����');
          Font.Style := [];
          Release;
        end;
      end;
      1: begin //����
        with dsurface.Canvas do begin
          d := g_qingqingImages.Images[7];
           if d <> nil then
              dsurface.Draw (SurfaceX(Left)+240, SurfaceY(Top) + 217, d.ClientRect, d, TRUE);
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          Font.Style := Font.Style + [fsBold];
          BoldTextOut (dsurface, SurfaceX(Left) + 30, SurfaceY(Top) + 50, clSilver, clBlack, '��ͨҩƷ');
          BoldTextOut (dsurface, SurfaceX(Left) + 200, SurfaceY(Top) + 50, clSilver, clBlack, '�Զ�����');
          BoldTextOut (dsurface, SurfaceX(Left) + 30, SurfaceY(Top) + 123, clSilver, clBlack, '����ҩƷ');
          BoldTextOut (dsurface, SurfaceX(Left) + 30, SurfaceY(Top) + 172, clSilver, clBlack, '�������');
          BoldTextOut (dsurface, SurfaceX(Left) + 200, SurfaceY(Top) + 172, clSilver, clBlack, 'Ӣ�۱�������');          
          Font.Style := [];
          BoldTextOut (dsurface, SurfaceX(Left) + 178, SurfaceY(Top) + 76, clSilver, clBlack, '��');
          BoldTextOut (dsurface, SurfaceX(Left) + 178, SurfaceY(Top) + 100, clSilver, clBlack, '��');
          BoldTextOut (dsurface, SurfaceX(Left) + 178, SurfaceY(Top) + 149, clSilver, clBlack, '��');
          BoldTextOut (dsurface, SurfaceX(Left) + 178, SurfaceY(Top) + 196, clSilver, clBlack, '��');
          BoldTextOut (dsurface, SurfaceX(Left) + 40, SurfaceY(Top) + 219, clSilver, clBlack, '��������');

          BoldTextOut (dsurface, SurfaceX(Left) + 210, SurfaceY(Top) + 76, clSilver, clBlack, '��ͨ��');
          BoldTextOut (dsurface, SurfaceX(Left) + 210, SurfaceY(Top) + 100, clSilver, clBlack, '��ͨ��(Ӣ��)');
          BoldTextOut (dsurface, SurfaceX(Left) + 210, SurfaceY(Top) + 123, clSilver, clBlack, 'ҩ��');
          BoldTextOut (dsurface, SurfaceX(Left) + 210, SurfaceY(Top) + 149, clSilver, clBlack, 'ҩ��(Ӣ��)');

          BoldTextOut (dsurface, SurfaceX(Left) + 340, SurfaceY(Top) + 76, clSilver, clBlack, '% ��ƶ�');
          BoldTextOut (dsurface, SurfaceX(Left) + 340, SurfaceY(Top) + 100, clSilver, clBlack, '% ��ƶ�');
          BoldTextOut (dsurface, SurfaceX(Left) + 340, SurfaceY(Top) + 123, clSilver, clBlack, '����');
          BoldTextOut (dsurface, SurfaceX(Left) + 340, SurfaceY(Top) + 149, clSilver, clBlack, '����');
          BoldTextOut (dsurface, SurfaceX(Left) + 240, SurfaceY(Top) + 196, clSilver, clBlack, '����Ѫ��:');
          BoldTextOut (dsurface, SurfaceX(Left) + 338, SurfaceY(Top) + 196, clSilver, clBlack, 'HP');
          BoldTextOut (dsurface, SurfaceX(Left) + 262, SurfaceY(Top) + 220, clSilver, clBlack, '����񻯱���');
          pen.Color := $00638494;
          Brush.Color := clBlack;
                   //��                    //��                //��                       
          Rectangle(SurfaceX(Left) + 295,SurfaceY(Top) + 193,SurfaceX(Left) + 335,SurfaceY(Top) + 212);
          {$IF Version = 1}
          Font.Color := clWhite;
          TextOut(SurfaceX(Left) + 297, SurfaceY(Top) + 196,'0');
          {$ELSE}
          clFunc.TextOut(dsurface, SurfaceX(Left) + 297, SurfaceY(Top) + 196,clWhite,'0');
          {$IFEND}
          Release;
        end;
      end;
      2: begin //����
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          Font.Style := Font.Style + [fsBold];
          BoldTextOut (dsurface, SurfaceX(Left) + 30, SurfaceY(Top) + 50, clSilver, clBlack, 'սʿ����');
          BoldTextOut (dsurface, SurfaceX(Left) + 148, SurfaceY(Top) + 50, clSilver, clBlack, '��ʿ����');         //
          BoldTextOut (dsurface, SurfaceX(Left) + 30, SurfaceY(Top) + 172, clSilver, clBlack, '��ʦ����');
          BoldTextOut (dsurface, SurfaceX(Left) + 266, SurfaceY(Top) + 50, clSilver, clBlack, '�Զ�����');
          BoldTextOut (dsurface, SurfaceX(Left) + 264, SurfaceY(Top) + 96, clSilver, clBlack,  '���Զ�������,ʹ��');
          BoldTextOut (dsurface, SurfaceX(Left) + 264, SurfaceY(Top) + 110, clSilver, clBlack, 'һ��Ҫ�����ļ���,��');
          BoldTextOut (dsurface, SurfaceX(Left) + 264, SurfaceY(Top) + 124, clSilver, clBlack, '���ܻᰴ�����趨��');
          BoldTextOut (dsurface, SurfaceX(Left) + 264, SurfaceY(Top) + 138, clSilver, clBlack, '���ʱ���ظ�ʹ��.');
          Font.Style := [];
          BoldTextOut (dsurface, SurfaceX(Left) + 376, SurfaceY(Top) + 77, clSilver, clBlack, '��');
          //=================================================
          pen.Color := $00638494;    //���߽���
          MoveTo(SurfaceX(Left)+260,   SurfaceY(Top)+69);
          LineTo(SurfaceX(Left)+390,   SurfaceY(Top)+69);
          LineTo(SurfaceX(Left)+390,   SurfaceY(Top)+154);
          LineTo(SurfaceX(Left)+260,   SurfaceY(Top)+154);
          LineTo(SurfaceX(Left)+260,   SurfaceY(Top)+69);
          //==================================================
          Release;
        end;
      end;
      3: begin//����
        with dsurface.Canvas do begin
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          Font.Style := Font.Style + [fsBold];
          BoldTextOut (dsurface, SurfaceX(Left) + 28, SurfaceY(Top) + 66, clSilver, clBlack, '��������');
          BoldTextOut (dsurface, SurfaceX(Left) + 150, SurfaceY(Top) + 66, clSilver, clBlack, 'Ĭ�Ͽ�ݼ�');
          BoldTextOut (dsurface, SurfaceX(Left) + 280, SurfaceY(Top) + 66, clSilver, clBlack, '�Զ����ݼ�');
          Font.Style := [];
          BoldTextOut (dsurface, SurfaceX(Left) + 28, SurfaceY(Top) + 89, clSilver, clBlack, '�ٻ�Ӣ��');
          BoldTextOut (dsurface, SurfaceX(Left) + 28, SurfaceY(Top) + 111, clSilver, clBlack, 'Ӣ�۹���Ŀ��');
          BoldTextOut (dsurface, SurfaceX(Left) + 28, SurfaceY(Top) + 133, clSilver, clBlack, 'ʹ�úϻ���');
          BoldTextOut (dsurface, SurfaceX(Left) + 28, SurfaceY(Top) + 155, clSilver, clBlack, '�л�Ӣ��״̬');
          BoldTextOut (dsurface, SurfaceX(Left) + 28, SurfaceY(Top) + 177, clSilver, clBlack, 'Ӣ���ػ�');
          BoldTextOut (dsurface, SurfaceX(Left) + 28, SurfaceY(Top) + 199, clSilver, clBlack, '�л�����ģʽ');
          BoldTextOut (dsurface, SurfaceX(Left) + 28, SurfaceY(Top) + 221, clSilver, clBlack, '�л�С��ͼ');

          pen.Color := $0053424A;    //���߽���
          MoveTo(SurfaceX(Left)+26,   SurfaceY(Top)+82);
          LineTo(SurfaceX(Left)+390,   SurfaceY(Top)+82);
          //����
          pen.Color := clGray;
          Brush.Color := clBlack;
          Rectangle(SurfaceX(Left)+115,SurfaceY(Top)+86,SurfaceX(Left)+245,SurfaceY(Top)+105);
          Rectangle(SurfaceX(Left)+115,SurfaceY(Top)+108,SurfaceX(Left)+245,SurfaceY(Top)+127);
          Rectangle(SurfaceX(Left)+115,SurfaceY(Top)+130,SurfaceX(Left)+245,SurfaceY(Top)+149);
          Rectangle(SurfaceX(Left)+115,SurfaceY(Top)+152,SurfaceX(Left)+245,SurfaceY(Top)+171);
          Rectangle(SurfaceX(Left)+115,SurfaceY(Top)+174,SurfaceX(Left)+245,SurfaceY(Top)+193);
          Rectangle(SurfaceX(Left)+115,SurfaceY(Top)+196,SurfaceX(Left)+245,SurfaceY(Top)+215);
          Rectangle(SurfaceX(Left)+115,SurfaceY(Top)+218,SurfaceX(Left)+245,SurfaceY(Top)+237);
          {$IF Version <> 1}
          Release;
          {$IFEND}

          BoldTextOut (dsurface, SurfaceX(Left) + 160, SurfaceY(Top) + 112, clSilver, clBlack, 'Ctrl+W');
          BoldTextOut (dsurface, SurfaceX(Left) + 160, SurfaceY(Top) + 134, clSilver, clBlack, 'Ctrl+S');
          BoldTextOut (dsurface, SurfaceX(Left) + 160, SurfaceY(Top) + 156, clSilver, clBlack, 'Ctrl+E');
          BoldTextOut (dsurface, SurfaceX(Left) + 160, SurfaceY(Top) + 178, clSilver, clBlack, 'Ctrl+Q');
          BoldTextOut (dsurface, SurfaceX(Left) + 160, SurfaceY(Top) + 200, clSilver, clBlack, 'Ctrl+H');
          BoldTextOut (dsurface, SurfaceX(Left) + 170, SurfaceY(Top) + 222, clSilver, clBlack, 'Tab');
          Release;
        end;
      end;
      4: begin //����
        d := g_WMain2Images.Images[291];   //����ͼ
        if d <> nil then
          dsurface.StretchDraw(Rect(SurfaceX(Left + 382), SurfaceY(Top + 38), SurfaceX(Left + 382) + 16, SurfaceY(Top + 24)+219), d.ClientRect,d, TRUE);
        with dsurface.Canvas do begin
          Int := 16;
          {$if Version = 1}
          SetBkMode (Handle, TRANSPARENT);
          {$IFEND}
          case g_btSdoAssistantHelpPage of
            0: begin
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44, clWhite, clBlack, '��������˵��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int, clSilver, clBlack, '  ��Ʒ��ʾ   ��ʾ��Ļ��Χ�ڵ��ϵ�������Ʒ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*2, clSilver, clBlack, '  �Զ�����   ֻҪվ����Ҫʰȡ����Ʒ�ϼ����Զ���ȥ����Ʒ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*3, clSilver, clBlack, '  ��ʾ����   ֻ��ʾ��Ļ��Χ�ڵ��ϵĹ�����Ʒ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*4, clSilver, clBlack, '  ��ȡ����   ͬ���Զ�������ܵ�ֻ��ȥ������Ʒ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*5, clSilver, clBlack, '  ��Shift    ��ѡ�˹��ܺ�����Զ�׷ɱĿ��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*6, clSilver, clBlack, '  ������ʾ   ��ʾ��Ļ��Χ�����н�ɫ������');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*7, clSilver, clBlack, '  �־þ���   �Լ����𻵵���Ʒ����������н�����ǰ����');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*9, clWhite, clBlack, '������˵��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*10, clSilver, clBlack, '  ������    �ƻ������ж������ߡ�������ʰȡ��Ʒ����������');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*11, clSilver, clBlack, '  ����Ҽ�    Զ���ĵ���ܹ��ڵ�ͼ���ܶ�');
              Release;
            end;
            1: begin
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44, clSilver, clBlack, '  Shift+���  ǿ�й���ָ��Ŀ��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int, clSilver, clBlack, '  Ctrl+�Ҽ�   ���ܹ�����������ҵ���Ϣ,�������ú�F10һ�� ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*2, clSilver, clBlack, '  Alt+���    �ռ���Ʒ ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*3, clSilver, clBlack, '  ˫���Ҽ�    ˫�������ڵ��ϵ���Ʒ����Ϳ��Լ�����');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*4, clSilver, clBlack, '  ������������˫���ڰ��������Ʒ���㽫����ֱ��ʹ�ø���Ʒ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*6, clWhite, clBlack, '��ݼ�˵��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*7, clSilver, clBlack, '  F1��F8   ���������õļ��ܿ�ݼ�');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*8, clSilver, clBlack, '  F9       ��/�رհ�������');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*9, clSilver, clBlack, '  F10      ��/�رս�ɫ����');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*10, clSilver, clBlack, '  F11      ��/�رս�ɫ���ܴ���');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*11, clSilver, clBlack, '  F12      ��/�رո������ܴ���');
              Release;
            end;
            2: begin
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44, clSilver, clBlack, '  Alt+X    ���ص���ɫѡ�����');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int, clSilver, clBlack, '  Alt+Q    ֱ���˳���Ϸ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*2, clSilver, clBlack, '  Pause    ����Ϸ�н�ͼ��������Ϸ\ImagesĿ¼���� ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*3, clSilver, clBlack, '  Ctrl+B   ��/�ر����̴���');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*4, clSilver, clBlack, '  Ctrl+H   ѡ���Լ�ϲ���Ĺ���ģʽ��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*5, clSilver, clBlack, '  ����ƽ����ģʽ - ���κ���ҹ�������Ч');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*6, clSilver, clBlack, '  ���лṥ��ģʽ - ���Լ��л��ڵ�������ҹ�����Ч');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*7, clSilver, clBlack, '  �����鹥��ģʽ - ����ͬһС�����ҹ�����Ч');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*8, clSilver, clBlack, '  ��ȫ�幥��ģʽ - �����е���Ҷ����й���Ч��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*9, clSilver, clBlack, '  ���ƶ񹥻�ģʽ - PK����ר�ù���ģʽ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*11, clWhite, clBlack, '��������˵��');
              Release;
            end;
            3: begin
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44, clSilver, clBlack, '  /�������     ˽��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int, clSilver, clBlack, '  !��������     ����');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*2, clSilver, clBlack, '  !!����        �������');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*3, clSilver, clBlack, '  !~����        �л�����');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*4, clSilver, clBlack, '  ���·����    �鿴��ȥ��������Ϣ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*6, clSilver, clBlack, '  @�ܾ�˽��     �ܾ����е�˽����������� ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*7, clSilver, clBlack, '  @�ܾ�+����    ���ض���ĳһ�����������ֽ������� ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*8, clSilver, clBlack, '  @�ܾ��л����� �����л�����������Ϣ������ ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*9, clSilver, clBlack, '  @�˳�����     �����л� ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*11, clWhite, clBlack, '������˵��');
              Release;
            end;
            4: begin
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44, clSilver, clBlack, '  ������ָ����ɫͬʱ��ALT+S���ɽ�����Ҽ�����������ٴ�ʹ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int, clSilver, clBlack, '  ��������ָ����ɫͬʱALT+S���ɽ�������Ƴ�����������Ҽ�');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*2, clSilver, clBlack, '  ����������������θ���ҵĺ���');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*4, clSilver, clBlack, '  ʹ��ָ�� @���������+�ո�+�������Ҳ�ɽ���Ҽ��������');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*5, clSilver, clBlack, '  �ٴ����� @���������+�ո�+��������ɽ�������Ƴ�������');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*7, clWhite, clBlack, '���ٱ���˵��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*8, clSilver, clBlack, '  ������Ҫ��ӵĽ�ɫͬʱ��ALT+W�����Զ��͸ý�ɫ��ӣ��ٴ�');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*9, clSilver, clBlack, '  ��ALT+E�����Զ��Ѹý�ɫ�Ӷ�����ɾ��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*11, clWhite, clBlack, 'Ӣ�۲�����ݼ�');
              Release;
            end;
            5: begin
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44, clSilver, clBlack, '  Ctrl+E  �л�Ӣ������״̬�����桢��Ϣ��ս�� ');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int, clSilver, clBlack, '  Ctrl+Q  ����/�ر�Ӣ�ۡ��ػ���״̬');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*2, clSilver, clBlack, '  Ctrl+W  ָ��Ӣ�۹��������е�Ŀ��');
              BoldTextOut (dsurface, SurfaceX(Left) + 25, SurfaceY(Top) + 44 + Int*3, clSilver, clBlack, '  Ctrl+S  �ͷźϻ�����');
              Release;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.NewSdoAssistantPageChanged;
begin
  //����
  DCheckSdoNameShow.Visible := False;
  DCheckSdoDuraWarning.Visible := False;
  DCheckSdoAvoidShift.Visible := False;
  DCheckSdoItemsHint.Visible := False;
  DCheckSdoShowFiltrate.Visible := False;
  DCheckSdoAutoPickItems.Visible := False;
  DCheckSdoPickFiltrate.Visible := False;
  DCheckSdoExpFiltrate.Visible := False;
  //����
  DCheckSdoCommonHp.Visible := False;
  DEdtSdoCommonHp.Visible := False;
  DEdtSdoCommonHpTimer.Visible := False;
  DCheckSdoCommonMp.Visible := False;
  DEdtSdoCommonMp.Visible := False;
  DEdtSdoCommonMpTimer.Visible := False;
  DCheckSdoSpecialHp.Visible := False;
  DEdtSdoSpecialHp.Visible := False;
  DEdtSdoSpecialHpTimer.Visible := False;
  DCheckSdoRandomHp.Visible := False;
  DEdtSdoRandomHp.Visible := False;
  DEdtSdoRandomHpTimer.Visible := False;
  DBtnSdoRandomName.Visible := False;
  DCheckSdoAutoDrinkWine.Visible := False;
  DEdtSdoDrunkWineDegree.Visible := False;
  DCheckSdoHeroAutoDrinkWine.Visible := False;
  DEdtSdoHeroDrunkWineDegree.Visible := False;
  DCheckSdoAutoDrinkDrugWine.Visible := False;
  DEdtSdoDrunkDrugWineDegree.Visible := False;
  DCheckSdoHeroAutoDrinkDrugWine.Visible := False;
  DEdtSdoHeroDrunkDrugWineDegree.Visible := False;
  //����
  DCheckSdoLongHit.Visible := False;
  DCheckSdoAutoWideHit.Visible := False;
  DCheckSdoAutoFireHit.Visible := False;
  DCheckSdoZhuri.Visible := False;
  DCheckSdoAutoShield.Visible := False;
  DCheckSdoHeroShield.Visible := False;
  DCheckSdoAutoHide.Visible := False;
  DCheckSdoAutoMagic.Visible := False;
  DEdtSdoAutoMagicTimer.Visible := False;
  //����ҳ��
  DCheckSdoStartKey.Visible := False;
  DBtnSdoCallHeroKey.Visible := False;
  DBtnSdoHeroAttackTargetKey.Visible := False;
  DBtnSdoHeroGotethKey.Visible := False;
  DBtnSdoHeroStateKey.Visible := False;
  DBtnSdoHeroGuardKey.Visible := False;
  DBtnSdoAttackModeKey.Visible := False;
  DBtnSdoMinMapKey.Visible := False;
  //����
  DSdoHelpUp.Visible := False;
  DSdoHelpNext.Visible := False;
  case g_btSdoAssistantPage of
    0: begin //����
      DCheckSdoNameShow.Visible := True;
      DCheckSdoDuraWarning.Visible := True;
      DCheckSdoAvoidShift.Visible := True;
      DCheckSdoItemsHint.Visible := True;
      DCheckSdoShowFiltrate.Visible := True;
      DCheckSdoAutoPickItems.Visible := True;
      DCheckSdoPickFiltrate.Visible := True;
      DCheckSdoExpFiltrate.Visible := True;
    end;
    1: begin //����
      DCheckSdoCommonHp.Visible := True;
      DEdtSdoCommonHp.Visible := True;
      DEdtSdoCommonHpTimer.Visible := True;
      DCheckSdoCommonMp.Visible := True;
      DEdtSdoCommonMp.Visible := True;
      DEdtSdoCommonMpTimer.Visible := True;
      DCheckSdoSpecialHp.Visible := True;
      DEdtSdoSpecialHp.Visible := True;
      DEdtSdoSpecialHpTimer.Visible := True;
      DCheckSdoRandomHp.Visible := True;
      DEdtSdoRandomHp.Visible := True;
      DEdtSdoRandomHpTimer.Visible := True;
      DBtnSdoRandomName.Visible := True;
      DCheckSdoAutoDrinkWine.Visible := True;
      DEdtSdoDrunkWineDegree.Visible := True;
      DCheckSdoHeroAutoDrinkWine.Visible := True;
      DEdtSdoHeroDrunkWineDegree.Visible := True;
      DCheckSdoAutoDrinkDrugWine.Visible := True;
      DEdtSdoDrunkDrugWineDegree.Visible := True;
      DCheckSdoHeroAutoDrinkDrugWine.Visible := True;
      DEdtSdoHeroDrunkDrugWineDegree.Visible := True;
    end;
    2: begin //����
      DCheckSdoLongHit.Visible := True;
      DCheckSdoAutoWideHit.Visible := True;
      DCheckSdoAutoFireHit.Visible := True;
      DCheckSdoZhuri.Visible := True;
      DCheckSdoAutoShield.Visible := True;
      DCheckSdoHeroShield.Visible := True;
      DCheckSdoAutoHide.Visible := True;
      DCheckSdoAutoMagic.Visible := True;
      DEdtSdoAutoMagicTimer.Visible := True;
    end;
    3: begin//����
      DCheckSdoStartKey.Visible := True;
      DBtnSdoCallHeroKey.Visible := True;
      DBtnSdoHeroAttackTargetKey.Visible := True;
      DBtnSdoHeroGotethKey.Visible := True;
      DBtnSdoHeroStateKey.Visible := True;
      DBtnSdoHeroGuardKey.Visible := True;
      DBtnSdoAttackModeKey.Visible := True;
      DBtnSdoMinMapKey.Visible := True;
    end;
    4: begin//����
      DSdoHelpUp.Visible := True;
      DSdoHelpNext.Visible := True;
    end;
  end;
end;

procedure TFrmDlg.DNewSdoBasicClick(Sender: TObject; X, Y: Integer);
begin
  g_btSdoAssistantPage := TDButton(Sender).Tag;
  NewSdoAssistantPageChanged();
end;

procedure TFrmDlg.DEdtSdoAutoMagicTimerDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  with Sender as TDEdit do begin
    with dsurface.Canvas do begin
        //=================================================
        if TDEdit(Sender).Moveed then
        pen.Color := $00387B9C    //���߽���
        else
        pen.Color := $00638494;    //���߽���
        if TDEdit(Sender).Focused then pen.Color := $005993BD;
        MoveTo(SurfaceX(Left),   SurfaceY(Top));
        LineTo(SurfaceX(Left)+Width,   SurfaceY(Top));
        LineTo(SurfaceX(Left)+Width,   SurfaceY(Top)+Height);
        LineTo(SurfaceX(Left),   SurfaceY(Top)+Height);
        LineTo(SurfaceX(Left),   SurfaceY(Top));
        //==================================================
      Release;
    end;
  end;
end;

procedure TFrmDlg.DNewSdoAssistantCloseClick(Sender: TObject; X,
  Y: Integer);
begin
  FrmMain.OpenSdoAssistant;
end;

procedure TFrmDlg.DSdoHelpUpClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DSdoHelpUp then begin
     if g_btSdoAssistantHelpPage <= 0 then Exit
     else Dec(g_btSdoAssistantHelpPage);
  end else begin
     if g_btSdoAssistantHelpPage >= 5 then Exit
     else Inc(g_btSdoAssistantHelpPage);
  end;
end;

procedure TFrmDlg.DBtnSdoCallHeroKeyDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   TextColor: TColor;
begin
  with Sender as TDButton do begin
    if TDButton(Sender).Moveed then begin
      Color := $005993BD;
      TextColor := clYellow;
    end else begin
      Color := $00638494;
      TextColor := clWhite;
    end;
    with dsurface.Canvas do begin
      pen.Color := Color;
      if TDButton(Sender).Focused then begin
        pen.Color := $005993BD;
        pen.Width := 2;
        TextColor := clAqua; 
      end;
      Brush.Color := clBlack;
               //��                               //��                            //��
      Rectangle(SurfaceX(Left),SurfaceY(Top),SurfaceX(Left)+TDButton(Sender).Width,SurfaceY(Top)+TDButton(Sender).Height);
      pen.Width := 1;
      {$if Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      {$ELSE}
      Release;
      {$IFEND}
      BoldTextOut (dsurface, SurfaceX(Left) + 64-FrmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2, SurfaceY(Top) + 4, TextColor, clBlack, TDButton(Sender).Hint);
      Release;
    end;
  end;
end;

procedure TFrmDlg.DBtnSdoRandomNameDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   FontColor: Tcolor;
begin
  with Sender as TDButton do begin
    if TDButton(Sender).Moveed then begin
      Color := $00387B9C;
      FontColor := clYellow;
    end else begin
      Color := $00498394;
      FontColor := clWhite;
    end;

    with dsurface.Canvas do begin
      pen.Color := Color;
      Brush.Color := clBlack;
               //��                               //��                            //��
      Rectangle(SurfaceX(Left),SurfaceY(Top),SurfaceX(Left)+TDButton(Sender).Width,SurfaceY(Top)+TDButton(Sender).Height);
      Brush.Color := Color;
      if TDButton(Sender).Downed then
        Polygon([Point(SurfaceX(Left)+73+3,   SurfaceY(Top)+12),   Point(SurfaceX(Left)+73,   SurfaceY(Top)+9),   Point(SurfaceX(Left)+73+6,   SurfaceY(Top)+9)])   //��������
      else
        Polygon([Point(SurfaceX(Left)+73+3,   SurfaceY(Top)+11),   Point(SurfaceX(Left)+73,   SurfaceY(Top)+8),   Point(SurfaceX(Left)+73+6,   SurfaceY(Top)+8)]);   //��������
      Release;
      {$if Version = 1}
      SetBkMode (Handle, TRANSPARENT);
      {$IFEND}
      case g_nRandomType of
        0: begin
          BoldTextOut (dsurface, SurfaceX(Left) + 2, SurfaceY(Top) + 4, FontColor, clBlack, '�سǾ�');
          g_sRandomName := '�سǾ�';
        end;
        1: begin
          BoldTextOut (dsurface, SurfaceX(Left) + 2, SurfaceY(Top) + 4, FontColor, clBlack, '�л�سǾ�');
          g_sRandomName := '�л�سǾ�';
        end;
        2:begin
          BoldTextOut (dsurface, SurfaceX(Left) + 2, SurfaceY(Top) + 4, FontColor, clBlack, '���ش���ʯ');
          g_sRandomName := '���ش���ʯ';
        end;
        3:begin
          BoldTextOut (dsurface, SurfaceX(Left) + 2, SurfaceY(Top) + 4, FontColor, clBlack, '���洫��ʯ');
          g_sRandomName := '���洫��ʯ';
        end;
        4:begin
          BoldTextOut (dsurface, SurfaceX(Left) + 2, SurfaceY(Top) + 4, FontColor, clBlack, '�������ʯ');
          g_sRandomName := '�������ʯ';
        end;
        5:begin
          BoldTextOut (dsurface, SurfaceX(Left) + 2, SurfaceY(Top) + 4, FontColor, clBlack, '������;�');
          g_sRandomName := '������;�';
        end;
        6:begin
          BoldTextOut (dsurface, SurfaceX(Left) + 2, SurfaceY(Top) + 4, FontColor, clBlack, '�������Ѿ�');
          g_sRandomName := '�������Ѿ�';
        end;
      end;
      Release;
    end;
  end;
end;

procedure TFrmDlg.DCheckSdoNameShowClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DCheckSdoNameShow then begin
    g_boShowName := DCheckSdoNameShow.Checked
  end;

  if Sender = DCheckSdoDuraWarning then begin
    g_boDuraWarning := DCheckSdoDuraWarning.Checked;
  end;
  if Sender = DCheckSdoAvoidShift then begin
    g_boNoShift := DCheckSdoAvoidShift.Checked;
  end;

  if Sender = DCheckSdoItemsHint then begin
    g_boShowAllItem := DCheckSdoItemsHint.Checked;
  end;

  if Sender = DCheckSdoShowFiltrate then begin
    g_boFilterAutoItemShow := DCheckSdoShowFiltrate.Checked;
  end;

  if Sender = DCheckSdoAutoPickItems then begin
      g_boAutoPuckUpItem := DCheckSdoAutoPickItems.Checked;
  end;

  if Sender = DCheckSdoPickFiltrate then begin
    g_boFilterAutoItemUp := DCheckSdoPickFiltrate.Checked;
  end;
  //�Զ�����DCheckSdoAutoMagic
  if Sender = DCheckSdoAutoMagic then begin
    g_boAutoMagic := DCheckSdoAutoMagic.Checked;
  end;
  //������ʾ����
  if Sender = DCheckSdoExpFiltrate then begin
    g_boExpFiltrate := DCheckSdoExpFiltrate.Checked;
  end;
end;

procedure TFrmDlg.DCheckSdoCommonHpClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DCheckSdoCommonHp then begin
    g_boCommonHp := DCheckSdoCommonHp.Checked;
  end;
  if Sender = DCheckSdoCommonMp then begin
    g_boCommonMp := DCheckSdoCommonMp.Checked;
  end;
  if Sender = DCheckSdoSpecialHp then begin
    g_boSpecialHp := DCheckSdoSpecialHp.Checked;
  end;
  if Sender = DCheckSdoRandomHp then begin
    g_boRandomHp := DCheckSdoRandomHp.Checked;
  end;
  if Sender = DCheckSdoStartKey then begin
   if not DCheckSdoStartKey.Checked then begin
     with FrmMain do begin
       ActCallHeroKey.Enabled := False;
       ActHeroAttackTargetKey.Enabled := False;
       ActHeroGotethKey.Enabled := False;
       ActHeroStateKey.Enabled := False;
       ActHeroGuardKey.Enabled := False;
       ActAttackModeKey.Enabled := False;
       ActMinMapKey.Enabled := False;
     end;
   end else begin
     with FrmMain do begin
       ActCallHeroKey.Enabled := True;
       ActHeroAttackTargetKey.Enabled := True;
       ActHeroGotethKey.Enabled := True;
       ActHeroStateKey.Enabled := True;
       ActHeroGuardKey.Enabled := True;
       ActAttackModeKey.Enabled := True;
       ActMinMapKey.Enabled := True;
     end;
   end;
  end;
  //δ��ͨ�Ĺ���
  if Sender = DCheckSdoAutoDrinkWine then begin
    g_boAutoEatWine := DCheckSdoAutoDrinkWine.Checked;
  end;
  if Sender = DCheckSdoHeroAutoDrinkWine then begin
    g_boAutoEatHeroWine := DCheckSdoHeroAutoDrinkWine.Checked;
  end;
  if Sender = DCheckSdoAutoDrinkDrugWine then begin
    g_boAutoEatDrugWine := DCheckSdoAutoDrinkDrugWine.Checked;
  end;
  if Sender = DCheckSdoHeroAutoDrinkDrugWine then begin
    g_boAutoEatHeroDrugWine := DCheckSdoHeroAutoDrinkDrugWine.Checked;  
  end;
end;

procedure TFrmDlg.DEdtSdoCommonHpChange(Sender: TObject);
begin
  if Sender = DEdtSdoCommonHp then begin
    if DEdtSdoCommonHp.Text = '' then Exit;
    g_nEditCommonHp := StrToInt(DEdtSdoCommonHp.Text);
  end;
  if Sender = DEdtSdoCommonHpTimer then begin
    if DEdtSdoCommonHpTimer.Text = '' then Exit;
    g_nEditCommonHpTimer := StrToInt(DEdtSdoCommonHpTimer.Text);
  end;
  if Sender = DEdtSdoCommonMp then begin
    if DEdtSdoCommonMp.Text = '' then Exit;
    g_nEditCommonMp := StrToInt(DEdtSdoCommonMp.Text);
  end;
  if Sender = DEdtSdoCommonMpTimer then begin
    if DEdtSdoCommonMpTimer.Text = '' then Exit;
    g_nEditCommonMpTimer := StrToInt(DEdtSdoCommonMpTimer.Text);
  end;
  if Sender = DEdtSdoSpecialHp then begin
    if DEdtSdoSpecialHp.Text = '' then Exit;
    g_nEditSpecialHp := StrToInt(DEdtSdoSpecialHp.Text);
  end;

  if Sender = DEdtSdoSpecialHpTimer then begin
    if DEdtSdoSpecialHpTimer.Text = '' then Exit;
    g_nEditSpecialHpTimer := StrToInt(DEdtSdoSpecialHpTimer.Text);
  end;

  if Sender = DEdtSdoRandomHp then begin
    if DEdtSdoRandomHp.Text = '' then Exit;
    g_nEditRandomHp := StrToInt(DEdtSdoRandomHp.Text);
  end;

  if Sender = DEdtSdoRandomHpTimer then begin
    if DEdtSdoRandomHpTimer.Text = '' then Exit;
    g_nEditRandomHpTimer := StrToInt(DEdtSdoRandomHpTimer.Text);
  end;

  if Sender = DEdtSdoAutoMagicTimer then begin
    if DEdtSdoAutoMagicTimer.Text = '' then Exit;
    g_nAutoMagicTime := StrToInt(DEdtSdoAutoMagicTimer.Text);
  end;

  if Sender = DEdtSdoDrunkWineDegree then begin
    if DEdtSdoDrunkWineDegree.Text = '' then Exit;
    g_btEditWine := StrToInt(DEdtSdoDrunkWineDegree.Text);
  end;

  if Sender = DEdtSdoHeroDrunkWineDegree then begin
    if DEdtSdoHeroDrunkWineDegree.Text = '' then Exit;
    g_btEditHeroWine := StrToInt(DEdtSdoHeroDrunkWineDegree.Text);
  end;

  if Sender = DEdtSdoDrunkDrugWineDegree then begin
    if DEdtSdoDrunkDrugWineDegree.Text = '' then Exit;
    g_btEditDrugWine := StrToInt(DEdtSdoDrunkDrugWineDegree.Text);
  end;

  if Sender = DEdtSdoHeroDrunkDrugWineDegree then begin
    if DEdtSdoHeroDrunkDrugWineDegree.Text = '' then Exit;
    g_btEditHeroDrugWine := StrToInt(DEdtSdoHeroDrunkDrugWineDegree.Text);
  end;
end;

procedure TFrmDlg.DCheckSdoLongHitClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DCheckSdoLongHit then begin
    if not FrmMain.GetMagicByID(12) then begin //��ɱ
       DCheckSdoLongHit.Checked := False;
       g_boLongHit := False;
       Exit;
    end;
   // g_boCanLongHit := DCheckSdoLongHit.Checked; //20080802�����ڹ��Զ���ɱ����
    g_boLongHit := DCheckSdoLongHit.Checked;
  end;

  if Sender = DCheckSdoAutoWideHit then begin
    if not FrmMain.GetMagicByID(25) then begin //����
       DCheckSdoAutoWideHit.Checked := False;
       g_boAutoWideHit := False;
       Exit;
    end;
    //g_boCanWideHit := DCheckSdoAutoWideHit.Checked; //20080802 �����ڹ��Զ���������
    g_boAutoWideHit := DCheckSdoAutoWideHit.Checked;
  end;

  if Sender = DCheckSdoAutoFireHit then begin
    if not FrmMain.GetMagicByID(26) then begin //�һ�
       DCheckSdoAutoFireHit.Checked := False;
       g_boAutoFireHit := False;
       Exit;
    end;
    g_boAutoFireHit := DCheckSdoAutoFireHit.Checked;
  end;

  if Sender = DCheckSdoZhuri then begin
    if not FrmMain.GetMagicByID(74) then begin //����
       DCheckSdoZhuri.Checked := False;
       g_boAutoZhuRiHit := False;
       Exit;
    end;
    g_boAutoZhuRiHit := DCheckSdoZhuri.Checked;
  end;

  if Sender = DCheckSdoAutoShield then begin
    if FrmMain.GetMagicByID(31) or FrmMain.GetMagicByID(66){4��ħ����} then begin //�Զ�����
       g_boAutoShield := DCheckSdoAutoShield.Checked;
    end else begin
       DCheckSdoAutoShield.Checked := False;
       g_boAutoShield := False;
       Exit;
    end;
  end;

  if Sender = DCheckSdoAutoHide then begin
    if not FrmMain.GetMagicByID(18) then begin //�Զ�����
       DCheckSdoAutoHide.Checked := False;
       g_boAutoHide := False;
       Exit;
    end;
    g_boAutoHide := DCheckSdoAutoHide.Checked;
  end;

  //δ��ͨ�Ĺ���
  if Sender = DCheckSdoHeroShield then begin
     //DCheckSdoHeroShield.Checked := False;
     if g_HeroSelf <> nil then begin
       if g_HeroSelf.m_btJob = 1 then begin
         if DCheckSdoHeroShield.Checked then
          FrmMain.SendHeroAutoOpenDefence(1)
         else FrmMain.SendHeroAutoOpenDefence(2);
       end else DCheckSdoHeroShield.Checked := False;
     end else DCheckSdoHeroShield.Checked := False;
     g_boHeroAutoDEfence := DCheckSdoHeroShield.Checked;
  end;
end;

procedure TFrmDlg.DBtnSdoRandomNameClick(Sender: TObject; X, Y: Integer);
begin
  if g_nRandomType >= 6 then
  g_nRandomType:=0 else Inc(g_nRandomType);
end;

procedure TFrmDlg.DBtnSdoCallHeroKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  CombinationKey: Integer;
begin
  if Key in [DBtnSdoCallHeroKey.Tag,DBtnSdoHeroAttackTargetKey.Tag,DBtnSdoHeroGotethKey.Tag,DBtnSdoHeroStateKey.Tag,DBtnSdoHeroGuardKey.Tag,DBtnSdoAttackModeKey.Tag,DBtnSdoMinMapKey.Tag] then begin
    Exit;
  end;
  if key in [0..7,9..11,12,14..15,21..32,41..45,47..92,94..123,144..145,186..192,219..222,226] then begin
    TDButton(Sender).Hint:='';
    CombinationKey:=0;
    if ssCtrl in Shift then
      TDButton(Sender).Hint := 'Ctrl+';
    if ssShift in Shift then
      TDButton(Sender).Hint := TDButton(Sender).Hint+'Shift+';
    if ssAlt in Shift then
      TDButton(Sender).Hint := TDButton(Sender).Hint+'Alt+';
    case Key of
     0..7,9..11,14..15,21..26,28..32,41..44,47..92,94..95:
      TDButton(Sender).Hint := TDButton(Sender).Hint+Char(key);
     12: TDButton(Sender).Hint := TDButton(Sender).Hint+'Num 5';
     27: TDButton(Sender).Hint := TDButton(Sender).Hint+'Esc';
     45: TDButton(Sender).Hint := TDButton(Sender).Hint+'Insert';
     96..105: //С����
      TDButton(Sender).Hint := TDButton(Sender).Hint+'Num '+Char(key-48);
     106..111:
      TDButton(Sender).Hint := TDButton(Sender).Hint+'Num '+Char(key-64);
     112..122: //���ܼ�
      TDButton(Sender).Hint := TDButton(Sender).Hint+'F'+IntToStr(Key-112+1);
     123: begin
       frmMain.OpenSdoAssistant();
       Exit;
     end;
     144: //Pause С���������Ǹ�
      TDButton(Sender).Hint := TDButton(Sender).Hint+'Pause';
     145: //Scroll Lock
      TDButton(Sender).Hint := TDButton(Sender).Hint+'Scroll Lock';
     192:
      TDButton(Sender).Hint := TDButton(Sender).Hint+Char(key-96);
     186:
       TDButton(Sender).Hint := TDButton(Sender).Hint+Char(key-127);
     187..191:
      TDButton(Sender).Hint := TDButton(Sender).Hint+Char(key-144);
     219..221:
      TDButton(Sender).Hint := TDButton(Sender).Hint+Char(key-128);
     222:
       TDButton(Sender).Hint := TDButton(Sender).Hint+Char(key-183);
     226:
      TDButton(Sender).Hint := TDButton(Sender).Hint+Char(key-134);
    else
      //TDButton(Sender).Hint := inttostr(key);
    end;
  //if  not DCheckSdoStartKey.Checked then begin TDButton(Sender).Tag := Key //else begin
      if Pos ('Ctrl',TDButton(Sender).Hint) > 0 then  CombinationKey := 16384;
      if Pos ('Shift',TDButton(Sender).Hint) > 0 then  CombinationKey := CombinationKey + 8192;
      if Pos ('Alt',TDButton(Sender).Hint) > 0 then  CombinationKey := CombinationKey + 32768;
      TDButton(Sender).Tag := Key;
    if Sender = DBtnSdoCallHeroKey then begin
      FrmMain.ActCallHeroKey.ShortCut := CombinationKey + Key;
    end;
    if Sender = DBtnSdoHeroAttackTargetKey then begin
      FrmMain.ActHeroAttackTargetKey.ShortCut := CombinationKey + Key;
    end;
    if Sender = DBtnSdoHeroGotethKey then begin
      FrmMain.ActHeroGotethKey.ShortCut := CombinationKey + Key;
    end;
    if Sender = DBtnSdoHeroStateKey then begin
      FrmMain.ActHeroStateKey.ShortCut := CombinationKey + Key;
    end;
    if Sender = DBtnSdoHeroGuardKey then begin
      FrmMain.ActHeroGuardKey.ShortCut := CombinationKey + Key;
    end;
    if Sender = DBtnSdoAttackModeKey then begin
      FrmMain.ActAttackModeKey.ShortCut := CombinationKey + Key;
    end;
    if Sender = DBtnSdoMinMapKey then begin
      FrmMain.ActMinMapKey.ShortCut := CombinationKey + Key;
    end;
  //end;
  end;
end;

procedure TFrmDlg.DBtnSdoCallHeroKeyMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then begin
    if Sender = DBtnSdoCallHeroKey then begin
      DBtnSdoCallHeroKey.Hint := '';
      DBtnSdoCallHeroKey.Tag := 0;
      FrmMain.ActCallHeroKey.ShortCut := 0;
    end;
    if Sender = DBtnSdoHeroAttackTargetKey then begin
      DBtnSdoHeroAttackTargetKey.Hint := '';
      DBtnSdoHeroAttackTargetKey.Tag := 0;
      FrmMain.ActHeroAttackTargetKey.ShortCut := 0;
    end;
    if Sender = DBtnSdoHeroGotethKey then begin
      DBtnSdoHeroGotethKey.Hint := '';
      DBtnSdoHeroGotethKey.Tag := 0;
      FrmMain.ActHeroGotethKey.ShortCut := 0;
    end;
    if Sender = DBtnSdoHeroStateKey then begin
      DBtnSdoHeroStateKey.Hint := '';
      DBtnSdoHeroStateKey.Tag := 0;
      FrmMain.ActHeroStateKey.ShortCut := 0;
    end;
    if Sender = DBtnSdoHeroGuardKey then begin
      DBtnSdoHeroGuardKey.Hint := '';
      DBtnSdoHeroGuardKey.Tag := 0;
      FrmMain.ActHeroGuardKey.ShortCut := 0;
    end;
    if Sender = DBtnSdoAttackModeKey then begin
      DBtnSdoAttackModeKey.Hint := '';
      DBtnSdoAttackModeKey.Tag := 0;
      FrmMain.ActAttackModeKey.ShortCut := 0;
    end;
    if Sender = DBtnSdoMinMapKey then begin
      DBtnSdoMinMapKey.Hint := '';
      DBtnSdoMinMapKey.Tag := 0;
      FrmMain.ActMinMapKey.ShortCut := 0;
    end;
  end;
end;

procedure TFrmDlg.DEdtSdoCommonHpKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13]) then Key := #0;
end;

procedure TFrmDlg.DWChallengeDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with DWChallenge do begin
    if WLib <> nil then begin //20080701
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
    {$IF Version = 1}
    with dsurface.Canvas do begin
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clYellow;
      TextOut (Left + 30, Top + 137, FrmMain.CharName);
      TextOut (Left + 30, Top + 36, g_sChallengeWho);
      Font.Color := clLime;
      TextOut (Left + 80, Top + 202, IntToStr(g_nChallengeGold));
      TextOut (Left + 80, Top + 101, IntToStr(g_nChallengeRemoteGold));
      TextOut (Left + 196 - TextWidth(IntToStr(g_nChallengeDiamond)) div 2, Top + 176, IntToStr(g_nChallengeDiamond));
      TextOut (Left + 196 - TextWidth(IntToStr(g_nChallengeRemoteDiamond)) div 2, Top + 75, IntToStr(g_nChallengeRemoteDiamond));
      Font.Color := clWhite;
      TextOut (Left + 179, Top + 163,g_sGameDiaMond);
      TextOut (Left + 179, Top + 62,g_sGameDiaMond);
      TextOut (Left + 52, Top + 270, '��ս�н�����ݽ�ͷ����ս��');
      TextOut (Left + 28, Top + 284, '����Ϊ����ʤ���ı�׼�������ͬ');
      TextOut (Left + 28, Top + 298, '����뿪ʼ��ս�ɡ�');
      Release;
    end;
    {$ELSE}
    with dsurface.Canvas do begin
      clFunc.TextOut (dsurface, Left + 30, Top + 137, clYellow, FrmMain.CharName);
      clFunc.TextOut (dsurface, Left + 30, Top + 36, clYellow, g_sChallengeWho);
      clFunc.TextOut (dsurface, Left + 80, Top + 202, clLime, IntToStr(g_nChallengeGold));
      clFunc.TextOut (dsurface, Left + 80, Top + 101, clLime, IntToStr(g_nChallengeRemoteGold));
      clFunc.TextOut (dsurface, Left + 196 - FrmMain.Canvas.TextWidth(IntToStr(g_nChallengeDiamond)) div 2, Top + 176, clLime, IntToStr(g_nChallengeDiamond));
      clFunc.TextOut (dsurface, Left + 196 - FrmMain.Canvas.TextWidth(IntToStr(g_nChallengeRemoteDiamond)) div 2, Top + 75, clLime, IntToStr(g_nChallengeRemoteDiamond));
      clFunc.TextOut (dsurface, Left + 179, Top + 163, clWhite, g_sGameDiaMond);
      clFunc.TextOut (dsurface, Left + 179, Top + 62, clWhite, g_sGameDiaMond);
      clFunc.TextOut (dsurface, Left + 52, Top + 270, clWhite, '��ս�н�����ݽ�ͷ����ս��');
      clFunc.TextOut (dsurface, Left + 28, Top + 284, clWhite, '����Ϊ����ʤ���ı�׼�������ͬ');
      clFunc.TextOut (dsurface, Left + 28, Top + 298, clWhite, '����뿪ʼ��ս�ɡ�');
      Release;
    end;
    {$IFEND}
  end;
end;
procedure TFrmDlg.DChallengeGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
begin
   idx := ACol + ARow * DChallengeGrid.ColCount;
   if idx in [0..3] then begin
      g_MouseItem := g_ChallengeItems[idx];
   end;
end;

procedure TFrmDlg.DChallengeGridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DChallengeGrid.ColCount;
   if idx in [0..3] then begin
      if g_ChallengeItems[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_ChallengeItems[idx].S.Looks];
         if d <> nil then
            with DChallengeGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DChallengeGridGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   I, mi, idx: integer;
   int: Byte;
begin
   if not g_boChallengeEnd and (GetTickCount > g_dwChallengeActionTick) then begin
      if not g_boItemMoving then begin
         idx := ACol + ARow * DChallengeGrid.ColCount;
         if idx in [0..3] then begin
            if g_ChallengeItems[idx].S.Name <> '' then begin
               g_boItemMoving := TRUE;
               g_MovingItem.Index := -idx - 57;
               g_MovingItem.Item := g_ChallengeItems[idx];
               g_ChallengeItems[idx].S.Name := '';
               ItemClickSound (g_MovingItem.Item.S);
            end;
         end else begin
            if idx = 4 then begin
                int := 0;
                DMessageDlg ('������'+g_sGameDiaMond+'��������0-9999֮��', [mbOk, mbAbort]);
                if DlgEditText = '' then int := 1;
                for I:=1 to length(DlgEditText) do
                  if (DlgEditText[i] <'0') or ( DlgEditText[i] > '9') then int := 2;
                if length(DlgEditText) > 4 then int := 3;
                case int of
                  0: begin
                    if (StrToInt(DlgEditText) > 0) and (StrToInt(DlgEditText) < 10000) then begin
                      FrmMain.SendChangeChallengeDiamond(StrToInt(DlgEditText));
                    end;
                  end;
                  1:DMessageDlg ('���ݲ���Ϊ�գ�', [mbOk]);
                  2:DMessageDlg ('�����'+g_sGameDiaMond+'����', [mbOk]);
                  3:DMessageDlg (g_sGameDiaMond + '�������ܳ���4λ', [mbOk]);
                end;
            end;
         end;
      end else begin
         mi := g_MovingItem.Index;
         if (mi >= 0) or (mi <= -57) and (mi > -63) then begin //����,���� �°͸�
            ItemClickSound (g_MovingItem.Item.S);
            g_boItemMoving := FALSE;
            if mi >= 0 then begin
               g_ChallengeDlgItem := g_MovingItem.Item; //������ ����� ��ٸ��µ��� ����
               FrmMain.SendAddChallengeItem (g_ChallengeDlgItem);
               g_dwChallengeActionTick := GetTickCount + 4000;
            end else
               AddChallengeItem (g_MovingItem.Item);
            g_MovingItem.Item.S.name := '';
         end;
         if mi = -98 then DDGoldClick (self, 0, 0);
      end;
      ArrangeItemBag;
   end;
end;

procedure TFrmDlg.DChallengeCloseClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwChallengeActionTick then begin
      CloseChallengeDlg;
      FrmMain.SendCancelChallenge;
   end;
end;

procedure TFrmDlg.DRChallengeGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
begin
   idx := ACol + ARow * DRChallengeGrid.ColCount;
   if idx in [0..3] then begin
      g_MouseItem := g_ChallengeRemoteItems[idx];
   end;
end;

procedure TFrmDlg.DRChallengeGridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DRChallengeGrid.ColCount;
   if idx in [0..3] then begin
      if g_ChallengeRemoteItems[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_ChallengeRemoteItems[idx].S.Looks];
         if d <> nil then
            with DRChallengeGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DChallengeOKClick(Sender: TObject; X, Y: Integer);
var
   mi: integer;
begin
   if GetTickCount > g_dwChallengeActionTick then begin
      FrmMain.SendChallengeEnd;
      g_dwChallengeActionTick := GetTickCount + 4000;
      g_boChallengeEnd := TRUE;
      if g_boItemMoving then begin
         mi := g_MovingItem.Index;
         if (mi <= -57) and (mi > -61) then begin //�� â���� �°͸�
            AddChallengeItem (g_MovingItem.Item);
            g_boItemMoving := FALSE;
            g_MovingItem.Item.S.name := '';
         end;
      end;
   end;
end;

procedure TFrmDlg.DChallengeGoldClick(Sender: TObject; X, Y: Integer);
var
   dgold: integer;
   valstr: string;
begin
   if g_MySelf = nil then Exit;
   if not g_boChallengeEnd and (GetTickCount > g_dwChallengeActionTick) then begin
    PlaySound (s_money);
    DialogSize := 1;
    DMessageDlg ('�����Ѻ����' +g_sGoldName + '��', [mbOk, mbAbort]);
    GetValidStrVal (DlgEditText, valstr, [' ']);
    dgold := Str_ToInt (valstr, 0);
    if (dgold <= (g_nChallengeGold+g_MySelf.m_nGold)) and (dgold > 0) then begin
       FrmMain.SendChangeChallengeGold (dgold);
       g_dwChallengeActionTick := GetTickCount + 4000;
    end;
   end;
end;

procedure TFrmDlg.btnRecvChrCloseClick(Sender: TObject; X, Y: Integer);
var
  I: Integer;
begin
  dwRecoverChr.Visible := False;
  if g_DelChrList <> nil then 
  if g_DelChrList.Count > 0 then begin//20080629
    for I := 0 to g_DelChrList.Count - 1 do begin //20080304 �ͷ�
      if pTDelChr(g_DelChrList.Items[I]) <> nil then Dispose(pTDelChr(g_DelChrList.Items[I]));
    end;
  end;
  FreeAndNil(g_DelChrList); //20080114 ����
end;

procedure TFrmDlg.dgrdRecoverNameGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   Idx: integer;
   DelChr: pTDelChr;
   sJob: string;
begin
   idx := ACol + ARow * dgrdRecoverName.ColCount;
   if idx in [0..9] then begin
     if g_DelChrList.Count >= idx+1 then begin
       if g_DelChrList.Items[idx] <> nil then begin
         DelChr := pTDelChr(g_DelChrList.Items[idx]);
         if DelChr <> nil then begin
           if DelChr.ChrInfo.Name <> '' then begin
              {$IF Version = 1}
              with dgrdRecoverName do
              with dsurface.Canvas do begin
                SetBkMode (Handle, TRANSPARENT);
                if Idx = dgrdRecoverName.Tag then begin
                   Font.Color := clRed;
                   TextOut (SurfaceX(Rect.Left), SurfaceY(Rect.Top)+4,'��');
                end else Font.Color := clWhite;
                TextOut (SurfaceX(Rect.Left) + 14, SurfaceY(Rect.Top)+4,DelChr.ChrInfo.Name);
                TextOut (SurfaceX(Rect.Left) + 100, SurfaceY(Rect.Top)+4,IntToStr(DelChr.ChrInfo.Level)+'��');
                case DelChr.ChrInfo.Job of
                  0: sJob := '��ʿ';
                  1: sJob := '��ʦ';
                  2: sJob := '��ʿ';
                end;
                TextOut (SurfaceX(Rect.Left) + 140, SurfaceY(Rect.Top)+4,sJob);
                if DelChr.ChrInfo.sex = 0 then
                  TextOut (SurfaceX(Rect.Left) + 190, SurfaceY(Rect.Top)+4,'��')
                else
                  TextOut (SurfaceX(Rect.Left) + 190, SurfaceY(Rect.Top)+4,'Ů');
                Release;
              end;
              {$ELSE}
              with dgrdRecoverName do
              with dsurface.Canvas do begin
                //SetBkMode (Handle, TRANSPARENT);
                if Idx = dgrdRecoverName.Tag then begin
                   Font.Color := clRed;
                   clFunc.TextOut (dsurface, SurfaceX(Rect.Left), SurfaceY(Rect.Top)+4, Font.Color, '��');
                end else Font.Color := clWhite;
                clFunc.TextOut (dsurface, SurfaceX(Rect.Left) + 14, SurfaceY(Rect.Top)+4, Font.Color, DelChr.ChrInfo.Name);
                clFunc.TextOut (dsurface, SurfaceX(Rect.Left) + 100, SurfaceY(Rect.Top)+4,Font.Color, IntToStr(DelChr.ChrInfo.Level)+'��');
                case DelChr.ChrInfo.Job of
                  0: sJob := '��ʿ';
                  1: sJob := '��ʦ';
                  2: sJob := '��ʿ';
                end;
                clFunc.TextOut (dsurface, SurfaceX(Rect.Left) + 140, SurfaceY(Rect.Top)+4, Font.Color, sJob);
                if DelChr.ChrInfo.sex = 0 then
                  clFunc.TextOut (dsurface, SurfaceX(Rect.Left) + 190, SurfaceY(Rect.Top)+4, Font.Color, '��')
                else
                  clFunc.TextOut (dsurface, SurfaceX(Rect.Left) + 190, SurfaceY(Rect.Top)+4, Font.Color, 'Ů');
                Release;
              end;
              {$IFEND}
           end;
         end;
       end;
     end;
   end;
end;

procedure TFrmDlg.dgrdRecoverNameGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
  Idx: Integer;
begin
  Idx := ACol + ARow * dgrdRecoverName.ColCount;
  if Idx in [0..9] then begin
    dgrdRecoverName.Tag := Idx;
  end;
end;

procedure TFrmDlg.btnRecoverClick(Sender: TObject; X, Y: Integer);
begin
  if dgrdRecoverName.Tag in [0..9] then begin
    FrmMain.SendResDelChr(pTDelChr(g_DelChrList.Items[dgrdRecoverName.Tag]).ChrInfo.Name);
    dgrdRecoverName.Tag := 20;
    btnRecvChrCloseClick (self, 0, 0);
  end;
end;

procedure TFrmDlg.DWChallengeMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   DScreen.ClearHint;
end;

procedure TFrmDlg.DEdtSdoCommonHpTimerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 123 then begin
    frmMain.OpenSdoAssistant();
  end;
end;

procedure TFrmDlg.DCheckSdoExpFiltrateMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Butt:TDCheckBox;
  sMsg:String;
begin
  if g_MySelf = nil then Exit;
  Butt:=TDCheckBox(Sender);
  if Sender = DCheckSdoNameShow then sMsg := 'ѡ�д��ȫ����ʾ�������';
  if Sender = DCheckSdoDuraWarning then sMsg := 'ѡ�д����װ���ͳ־�ʱ\������ʾ';
  if Sender = DCheckSdoAvoidShift then sMsg := 'ѡ�д������Ҫ����SHIFT\��Ҳ�ܹ����������';
  if Sender = DCheckSdoExpFiltrate then sMsg := 'ѡ�д������������е�\��2000�ľ���ֵ������ʾ';
  if Sender = DCheckSdoItemsHint then sMsg := 'ѡ�д����ʾ���������\Ʒ������';
  if Sender = DCheckSdoShowFiltrate then sMsg := 'ѡ�д��������ͨ�ĵ���\��Ʒ����';
  if Sender = DCheckSdoAutoPickItems then sMsg := 'ѡ�д���Զ���ȡ�����\�����Ʒ';
  if Sender = DCheckSdoPickFiltrate then sMsg := 'ѡ�д���Զ�������ͨ��\����Ʒ�ļ�ȡ';

  with Butt as TDCheckBox do
    DScreen.ShowHint(Butt.SurfaceX(Butt.Left), Butt.SurfaceY(Butt.Top + Butt.Height), sMsg, clYellow, FALSE);
end;

procedure TFrmDlg.DWNewSdoAssistantMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DHeroItemBagMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DStateTabClick(Sender: TObject; X, Y: Integer);
var
  lx: Integer;
begin
  lx := X - DStateTab.Left;
  if (lx >= 13) and (lx <= 83) then begin
    StateTab := 0;
    {if StatePage = 3 then begin
       DStMag1.Visible := True;  DStMag2.Visible := True;
       DStMag3.Visible := True;  DStMag4.Visible := True;
       DStMag5.Visible := True;  DStMag6.Visible := True;
       DStPageUp.Visible := True;
       DStPageDown.Visible := True;
    end; }
    PageChanged;
  end else
  if (lx >= 84) and (lx <= 152) then begin
    StateTab := 1;
    DStMag1.Visible := FALSE;  DStMag2.Visible := FALSE;
    DStMag3.Visible := FALSE;  DStMag4.Visible := FALSE;
    DStMag5.Visible := FALSE;  DStMag6.Visible := FALSE;
    if InternalForcePage <> 1 then begin
      DStPageUp.Visible := FALSE;
      DStPageDown.Visible := FALSE;
    end else begin
      DStPageUp.Visible := True;
      DStPageDown.Visible := True;
    end;
  end;
end;

procedure TFrmDlg.DStateTabDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if WLib <> nil then begin //20080701
        if StateTab = 0 then
           d := WLib.Images[FaceIndex]
        else
           d := WLib.Images[FaceIndex+1];
        if d <> nil then
          dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;



procedure TFrmDlg.DHeroStateTabDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if WLib <> nil then begin //20080701
        if HeroStateTab = 0 then
           d := WLib.Images[FaceIndex]
        else
           d := WLib.Images[FaceIndex+1];
        if d <> nil then
          dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DHeroStateTabClick(Sender: TObject; X, Y: Integer);
var
  lx: Integer;
begin
  lx := X - DStateTab.Left;
  if (lx >= 13) and (lx <= 83) then begin
    HeroStateTab := 0;
    {if HeroStatePage = 3 then begin
       DStMagHero1.Visible := TRUE;  DStMagHero2.Visible := TRUE;
       DStMagHero3.Visible := TRUE;  DStMagHero4.Visible := TRUE;
       DStMagHero5.Visible := TRUE;  DStMagHero6.Visible := TRUE;
       DSHPageUp.Visible := TRUE;
       DSHPageDown.Visible := TRUE;
    end;  }
    HeroPageChanged;
  end else
  if (lx >= 84) and (lx <= 152) then begin
    HeroStateTab := 1;
    DStMagHero1.Visible := False;  DStMagHero2.Visible := False;
    DStMagHero3.Visible := False;  DStMagHero4.Visible := False;
    DStMagHero5.Visible := False;  DStMagHero6.Visible := False;
    if HeroInternalForcePage <> 1 then begin
      DSHPageUp.Visible := FALSE;
      DSHPageDown.Visible := FALSE;
    end else begin
      DSHPageUp.Visible := True;
      DSHPageDown.Visible := True;
    end;
  end;
end;


function Mz_InternalReadComponentData(var Instance: TComponent; const DfmData: string): Boolean;
var
  StrStream: TStringStream;
begin
  StrStream := nil;

  try
    StrStream := TStringStream.Create(DfmData);
    Instance := StrStream.ReadComponent(Instance);
  finally
    StrStream.Free;
  end;

  Result := True;
end;

function Mz_InitInheritedComponent(Instance: TComponent; RootAncestor: TClass; const DfmData: string): Boolean;
  function Mz_InitComponent(ClassType: TClass; const DfmData: string): Boolean;
  begin
    Result := False;
    if (ClassType = TComponent) or (ClassType = RootAncestor) then Exit;
    Result := Mz_InitComponent(ClassType.ClassParent, DfmData);
    Result := Mz_InternalReadComponentData(Instance, DfmData) or Result; // **
  end;
var
  LocalizeLoading: Boolean;
begin
  GlobalNameSpace.BeginWrite;  // hold lock across all ancestor loads (performance)
  try
    LocalizeLoading := (Instance.ComponentState * [csInline, csLoading]) = [];
    if LocalizeLoading then BeginGlobalLoading;       // push new loadlist onto stack
    try
      Result := Mz_InitComponent(Instance.ClassType, DfmData); // **
      if LocalizeLoading then NotifyGlobalLoading;    // call Loaded
    finally
      if LocalizeLoading then EndGlobalLoading;       // pop loadlist off stack
    end;
  finally
    GlobalNameSpace.EndWrite;
  end;
end;

constructor TFrmDlg.Create(AOwner: TComponent);
begin
  GlobalNameSpace.BeginWrite;
  try
    CreateNew(AOwner);
    if (ClassType <> TForm) and not (csDesigning in ComponentState) then
    begin
      Include(FFormState, fsCreating);
      try
        if (Mz_InitInheritedComponent(Self, TForm, DemoDfm) = False) then // **
          ShowMessage('ע��, ��ʼ������ʧ��, ����DataUnit.DfmData, :~)');
      finally
        Exclude(FFormState, fsCreating);
      end;
      if OldCreateOrder then DoCreate;
    end;
  finally
    GlobalNameSpace.EndWrite;
  end;
end;

end.


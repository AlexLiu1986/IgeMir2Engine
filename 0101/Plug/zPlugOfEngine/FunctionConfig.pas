unit FunctionConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, EngineAPI, EngineType, Menus, IniFiles;

type
  TFrmFunctionConfig = class(TForm)
    FunctionConfigControl: TPageControl;
    Label14: TLabel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox52: TGroupBox;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label128: TLabel;
    SpinEditStartHPRock: TSpinEdit;
    SpinEditRockAddHP: TSpinEdit;
    SpinEditHPRockDecDura: TSpinEdit;
    SpinEditHPRockSpell: TSpinEdit;
    CheckBoxStartHPRock: TCheckBox;
    GroupBox53: TGroupBox;
    Label122: TLabel;
    Label124: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label123: TLabel;
    Label129: TLabel;
    SpinEditStartMPRock: TSpinEdit;
    SpinEditRockAddMP: TSpinEdit;
    SpinEditMPRockDecDura: TSpinEdit;
    SpinEditMPRockSpell: TSpinEdit;
    CheckBoxStartMPRock: TCheckBox;
    ButtonSuperRockSave: TButton;
    Label1: TLabel;
    EditStartHPRockMsg: TEdit;
    Label2: TLabel;
    EditStartMPRockMsg: TEdit;
    GroupBox21: TGroupBox;
    ListBoxitemList: TListBox;
    BtnDisallowSave: TButton;
    GroupBox22: TGroupBox;
    ListViewMsgFilter: TListView;
    GroupBox23: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    EditFilterMsg: TEdit;
    EditNewMsg: TEdit;
    ButtonMsgFilterAdd: TButton;
    ButtonMsgFilterDel: TButton;
    ButtonMsgFilterSave: TButton;
    ButtonMsgFilterChg: TButton;
    GroupBox5: TGroupBox;
    ListBoxUserCommand: TListBox;
    Label3: TLabel;
    EditCommandName: TEdit;
    ButtonUserCommandAdd: TButton;
    Label4: TLabel;
    SpinEditCommandIdx: TSpinEdit;
    ButtonUserCommandDel: TButton;
    ButtonUserCommandChg: TButton;
    ButtonUserCommandSave: TButton;
    ButtonLoadUserCommandList: TButton;
    ButtonLoadMsgFilterList: TButton;
    GroupBoxAttack: TGroupBox;
    CheckBoxAttack1: TCheckBox;
    CheckBoxAttack2: TCheckBox;
    CheckBoxAttack3: TCheckBox;
    SpinEditAttack1: TSpinEdit;
    SpinEditAttack2: TSpinEdit;
    SpinEditAttack3: TSpinEdit;
    ButtonAttackSave: TButton;
    CheckBoxStart: TCheckBox;
    GroupBox54: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    SpinEditStartHPMPRock: TSpinEdit;
    SpinEditRockAddHPMP: TSpinEdit;
    SpinEditHPMPRockDecDura: TSpinEdit;
    SpinEditHPMPRockSpell: TSpinEdit;
    CheckBoxStartHPMPRock: TCheckBox;
    EditStartHPMPRockMsg: TEdit;
    Label7: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    GroupBox2: TGroupBox;
    ListBoxDisallow: TListBox;
    GroupBox3: TGroupBox;
    Label16: TLabel;
    EditItemName: TEdit;
    GroupBox4: TGroupBox;
    BtnDisallowSelAll: TButton;
    BtnDisallowCancelAll: TButton;
    CheckBoxDisallowDrop: TCheckBox;
    CheckBoxDisallowDeal: TCheckBox;
    CheckBoxDisallowStorage: TCheckBox;
    CheckBoxDisallowRepair: TCheckBox;
    CheckBoxDisallowDropHint: TCheckBox;
    CheckBoxDisallowOpenBoxsHint: TCheckBox;
    CheckBoxDisallowNoDropItem: TCheckBox;
    CheckBoxDisallowButchHint: TCheckBox;
    BtnDisallowAdd: TButton;
    BtnDisallowDel: TButton;
    BtnDisallowAddAll: TButton;
    BtnDisallowDelAll: TButton;
    BtnDisallowChg: TButton;
    CheckBoxDisallowHeroUse: TCheckBox;
    CheckBoxDisallowPickUpItem: TCheckBox;
    CheckBoxDieDropItems: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    procedure CheckBoxStartHPRockClick(Sender: TObject);
    procedure CheckBoxStartMPRockClick(Sender: TObject);
    procedure EditStartHPRockMsgChange(Sender: TObject);
    procedure EditStartMPRockMsgChange(Sender: TObject);
    procedure ButtonSuperRockSaveClick(Sender: TObject);
    procedure SpinEditStartHPRockChange(Sender: TObject);
    procedure SpinEditHPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddHPChange(Sender: TObject);
    procedure SpinEditHPRockDecDuraChange(Sender: TObject);
    procedure SpinEditMPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddMPChange(Sender: TObject);
    procedure SpinEditMPRockDecDuraChange(Sender: TObject);
    procedure SpinEditStartMPRockChange(Sender: TObject);
    procedure ListBoxUserCommandClick(Sender: TObject);
    procedure ButtonUserCommandAddClick(Sender: TObject);
    procedure ButtonUserCommandDelClick(Sender: TObject);
    procedure ButtonUserCommandChgClick(Sender: TObject);
    procedure ButtonUserCommandSaveClick(Sender: TObject);
    procedure ButtonLoadUserCommandListClick(Sender: TObject);
    procedure BtnDisallowSaveClick(Sender: TObject);
    procedure ListViewMsgFilterClick(Sender: TObject);
    procedure ButtonLoadMsgFilterListClick(Sender: TObject);
    procedure ButtonMsgFilterSaveClick(Sender: TObject);
    procedure ButtonMsgFilterAddClick(Sender: TObject);
    procedure ButtonMsgFilterChgClick(Sender: TObject);
    procedure ButtonMsgFilterDelClick(Sender: TObject);
    procedure CheckBoxAttack1Click(Sender: TObject);
    procedure CheckBoxAttack2Click(Sender: TObject);
    procedure CheckBoxAttack3Click(Sender: TObject);
    procedure SpinEditAttack1Change(Sender: TObject);
    procedure SpinEditAttack2Change(Sender: TObject);
    procedure SpinEditAttack3Change(Sender: TObject);
    procedure ButtonAttackSaveClick(Sender: TObject);
    procedure CheckBoxStartClick(Sender: TObject);
    procedure EditStartHPMPRockMsgChange(Sender: TObject);
    procedure SpinEditStartHPMPRockChange(Sender: TObject);
    procedure SpinEditHPMPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddHPMPChange(Sender: TObject);
    procedure SpinEditHPMPRockDecDuraChange(Sender: TObject);
    procedure CheckBoxStartHPMPRockClick(Sender: TObject);
    procedure BtnDisallowSelAllClick(Sender: TObject);
    procedure BtnDisallowCancelAllClick(Sender: TObject);
    procedure BtnDisallowAddClick(Sender: TObject);
    procedure ListBoxitemListClick(Sender: TObject);
    procedure BtnDisallowDelClick(Sender: TObject);
    procedure BtnDisallowAddAllClick(Sender: TObject);
    procedure BtnDisallowDelAllClick(Sender: TObject);
    procedure BtnDisallowChgClick(Sender: TObject);
    procedure ListBoxDisallowClick(Sender: TObject);
    procedure ListBoxitemListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBoxDieDropItemsClick(Sender: TObject);
    procedure CheckBoxDisallowNoDropItemClick(Sender: TObject);
  private
    { Private declarations }
    procedure uModValue;
    procedure ModValue;
    procedure RefSuperRock();
    procedure RefLoadMsgFilterList();
    procedure RefLoadDisallowStdItems();
    procedure RefLoadAttackInfo();
    function InCommandListOfName(sCommandName: string): Boolean;
    function InCommandListOfIndex(nIndex: Integer): Boolean;
    function InFilterMsgList(sFilterMsg: string): Boolean;

    procedure DisallowSelAll(SelAll: Boolean); //是否全选20080418
    procedure FindListBox(); //查找列表里的物品 20080419
  public
    { Public declarations }
    procedure Open();
  end;
procedure InitUserConfig();
procedure InitSuperRock();
procedure UnInitSuperRock();
procedure SuperRock(PlayObject: TPlayObject; var m_UseItems: _TPLAYUSEITEMS; var m_WAbil: _TABILITY); stdcall;
var
  FrmFunctionConfig: TFrmFunctionConfig;
  boModValued, boOpened: Boolean;
implementation
uses
  PlayUserCmd, PlayUser, PlugShare;
{$R *.dfm}
procedure InitSuperRock();
begin
  Try
  TPlayObject_SetHookUserRunMsg(SuperRock);
  except
    MainOutMessage('[异常] PlugOfEngine.InitSuperRock');
  end;
end;
procedure UnInitSuperRock();
begin
  Try
  TPlayObject_SetHookUserRunMsg(nil);
  except
    MainOutMessage('[异常] PlugOfEngine.UnInitSuperRock');
  end;
end;

procedure SuperRock(PlayObject: TPlayObject; var m_UseItems: _TPLAYUSEITEMS; var m_WAbil: _TABILITY);
var
  StdItem: _LPTSTDITEM;
  nTempDura: Integer;
  szString: String;
begin
Try
  //气血石 魔血石                                                                                                  //20080611
  if (PlayObject <> nil) and (not TBaseObject_boDeath(PlayObject)^) and (not TBaseObject_boGhost(PlayObject)^) and (m_WAbil.wHP > 0) then begin
    if m_UseItems[U_CHARM].wIndex > 0 then begin
      if m_UseItems[U_CHARM].wDura > 0 then begin
        StdItem := TUserEngine_GetStdItemByIndex(m_UseItems[U_CHARM].wIndex);
        if (StdItem <> nil) and (StdItem.btShape > 0) then begin
          case StdItem.btShape of
            1: begin //气血石
                if m_WAbil.wHP <= ((m_WAbil.wMaxHP * nStartHPRock) div 100) then begin
                  if GetTickCount - TBaseObject_dwRockAddHPTick(PlayObject)^ > nHPRockSpell then begin
                    TBaseObject_dwRockAddHPTick(PlayObject)^:= GetTickCount;//气石加HP间隔 20080524
                    if (boStartHPRockMsg) and (sStartHPRockMsg <> '') then TBaseObject_SysMsg(PlayObject, PChar(sStartHPRockMsg), mc_Red, mt_Hint);
                    if m_UseItems[U_CHARM].wDura * 10 > nHPRockDecDura then begin    //清清 2007 12.14
                      Inc(m_WAbil.wHP, nRockAddHP);
                      if m_WAbil.wHP > m_WAbil.wMaxHP then m_WAbil.wHP := m_WAbil.wMaxHP;
                      nTempDura := m_UseItems[U_CHARM].wDura * 10;
                      Dec(nTempDura, nHPRockDecDura);  //清清 2007.12.14
                      m_UseItems[U_CHARM].wDura := Round(nTempDura / 10);
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin //人物  20080309
                        TPlugOfEngine_HealthSpellChanged(PlayObject);
                        TBaseObject_SendMsg(PlayObject, PlayObject, RM_DURACHANGE, U_CHARM, m_UseItems[U_CHARM].wDura, m_UseItems[U_CHARM].wDuraMax, 0, nil);  //清清 2007.12.14
                      end;
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                        TPlugOfEngine_HealthSpellChanged(PlayObject);
                        //TBaseObject_SendMsg(TBaseObject_Master(PlayObject)^, TBaseObject_Master(PlayObject)^, RM_HEROABILITY, 0, 0, 0, 0, nil);
                        TBaseObject_SendMsg(TBaseObject_Master(PlayObject)^, TBaseObject_Master(PlayObject)^, RM_HERODURACHANGE, U_CHARM, m_UseItems[U_CHARM].wDura, m_UseItems[U_CHARM].wDuraMax, 0, nil);
                      end;
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYMOSTER then//人形 20080428
                         TPlugOfEngine_HealthSpellChanged(PlayObject);

                      if m_UseItems[U_CHARM].wDura <= 0 then begin//20080725
                        if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin
                          TPlayObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                          m_UseItems[U_CHARM].wIndex:= 0;
                        end else
                        if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                          THeroObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                          m_UseItems[U_CHARM].wIndex:= 0;
                        end else m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                    end else begin
                      Inc(m_WAbil.wHP, nRockAddHP);
                      if m_WAbil.wHP > m_WAbil.wMaxHP then m_WAbil.wHP := m_WAbil.wMaxHP;
                      m_UseItems[U_CHARM].wDura := 0;

                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin
                        TPlayObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end else
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                        THeroObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                    end;
                  end;
                end;
              end;
            2: begin
                if m_WAbil.wMP <= ((m_WAbil.wMaxMP * nStartMPRock) div 100) then begin
                  if GetTickCount - TBaseObject_dwRockAddMPTick(PlayObject)^ > nMPRockSpell then begin
                    TBaseObject_dwRockAddMPTick(PlayObject)^:= GetTickCount;//气石加MP间隔 20080524
                    if (boStartMPRockMsg) and (sStartMPRockMsg <> '') then TBaseObject_SysMsg(PlayObject, PChar(sStartMPRockMsg), mc_Red, mt_Hint);
                    if m_UseItems[U_CHARM].wDura * 10 > nMPRockDecDura then begin    //清清 2007 12.14
                      Inc(m_WAbil.wMP, nRockAddMP);
                      if m_WAbil.wMP > m_WAbil.wMaxMP then  m_WAbil.wMP:= m_WAbil.wMaxMP ;

                      nTempDura := m_UseItems[U_CHARM].wDura * 10;
                      Dec(nTempDura,nMPRockDecDura);//清清 2007.12.14
                      m_UseItems[U_CHARM].wDura := Round(nTempDura / 10);
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin //人物  20080309
                        //TBaseObject_SendMsg(PlayObject, PlayObject, RM_ABILITY, 0, 0, 0, 0, nil); //改变人物属性MP
                        TPlugOfEngine_HealthSpellChanged(PlayObject);
                        TBaseObject_SendMsg(PlayObject, PlayObject, RM_DURACHANGE, U_CHARM, m_UseItems[U_CHARM].wDura, m_UseItems[U_CHARM].wDuraMax, 0, nil);  //清清 2007.12.14
                      end;
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                        //TBaseObject_SendMsg(TBaseObject_Master(PlayObject)^, TBaseObject_Master(PlayObject)^,RM_HEROABILITY, 0, 0, 0, 0, nil);
                        TPlugOfEngine_HealthSpellChanged(PlayObject);
                        TBaseObject_SendMsg(TBaseObject_Master(PlayObject)^, TBaseObject_Master(PlayObject)^, RM_HERODURACHANGE, U_CHARM, m_UseItems[U_CHARM].wDura, m_UseItems[U_CHARM].wDuraMax, 0, nil);
                      end;
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYMOSTER then//人形 20080428
                         TPlugOfEngine_HealthSpellChanged(PlayObject);

                      if m_UseItems[U_CHARM].wDura <= 0 then begin//20080725
                        if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin
                          TPlayObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                          m_UseItems[U_CHARM].wIndex:= 0;
                        end else
                        if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                          THeroObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                          m_UseItems[U_CHARM].wIndex:= 0;
                        end else m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                    end else begin
                      Inc(m_WAbil.wMP, nRockAddMP);
                      if m_WAbil.wMP > m_WAbil.wMaxMP then  m_WAbil.wMP:= m_WAbil.wMaxMP ;
                      m_UseItems[U_CHARM].wDura := 0;

                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin
                        TPlayObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end else
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                        THeroObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                    end;
                  end;
                end;
              end;
            3: begin 
              if m_WAbil.wHP <= ((m_WAbil.wMaxHP * nStartHPMPRock) div 100) then begin
                  if GetTickCount - TBaseObject_dwRockAddHPTick(PlayObject)^ > nHPMPRockSpell then begin
                    TBaseObject_dwRockAddHPTick(PlayObject)^:= GetTickCount;//气石加HP间隔 20080524
                    if (boStartHPMPRockMsg) and (sStartHPMPRockMsg <> '') then TBaseObject_SysMsg(PlayObject, PChar(sStartHPMPRockMsg), mc_Red, mt_Hint);
                    if m_UseItems[U_CHARM].wDura * 10 > nHPMPRockDecDura then begin  //清清 2007.12.14
                      Inc(m_WAbil.wHP, nRockAddHPMP);
                      if m_WAbil.wHP > m_WAbil.wMaxHP then m_WAbil.wHP := m_WAbil.wMaxHP;
                      nTempDura := m_UseItems[U_CHARM].wDura * 10;
                      Dec(nTempDura, nHPMPRockDecDura);  //清清 2007.12.14
                      m_UseItems[U_CHARM].wDura := Round(nTempDura / 10);
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin //人物  20080309
                        TPlugOfEngine_HealthSpellChanged(PlayObject);
                        //TBaseObject_SendMsg(PlayObject, PlayObject, RM_ABILITY, 0, 0, 0, 0, nil);
                        TBaseObject_SendMsg(PlayObject, PlayObject, RM_DURACHANGE, U_CHARM, m_UseItems[U_CHARM].wDura, m_UseItems[U_CHARM].wDuraMax, 0, nil);  //清清 2007.12.14
                      end; //else
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                        //TBaseObject_SendMsg(TBaseObject_Master(PlayObject)^, TBaseObject_Master(PlayObject)^,RM_HEROABILITY, 0, 0, 0, 0, nil);
                        TPlugOfEngine_HealthSpellChanged(PlayObject);
                        TBaseObject_SendMsg(TBaseObject_Master(PlayObject)^, TBaseObject_Master(PlayObject)^, RM_HERODURACHANGE, U_CHARM, m_UseItems[U_CHARM].wDura, m_UseItems[U_CHARM].wDuraMax, 0, nil);
                      end;// else
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYMOSTER then//人形 20080428
                         TPlugOfEngine_HealthSpellChanged(PlayObject);

                      if m_UseItems[U_CHARM].wDura <= 0 then begin//20080725
                        if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin
                          TPlayObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                          m_UseItems[U_CHARM].wIndex:= 0;
                        end else
                        if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                          THeroObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                          m_UseItems[U_CHARM].wIndex:= 0;
                        end else m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                    end else begin
                      Inc(m_WAbil.wHP, nRockAddHPMP);
                      if m_WAbil.wHP > m_WAbil.wMaxHP then m_WAbil.wHP := m_WAbil.wMaxHP;
                      m_UseItems[U_CHARM].wDura := 0;
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin
                        TPlayObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end else
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                        THeroObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                    end;
                  end;
                end;
              //======================================================================
              if m_WAbil.wMP <= ((m_WAbil.wMaxMP * nStartHPMPRock) div 100) then begin
                  if GetTickCount - TBaseObject_dwRockAddMPTick(PlayObject)^ > nHPMPRockSpell then begin
                    TBaseObject_dwRockAddMPTick(PlayObject)^:= GetTickCount;//气石加MP间隔 20080524
                    if (boStartHPMPRockMsg) and (sStartHPMPRockMsg <> '') then TBaseObject_SysMsg(PlayObject, PChar(sStartHPMPRockMsg), mc_Red, mt_Hint);
                    if m_UseItems[U_CHARM].wDura * 10 > nHPMPRockDecDura then begin  //清清 2007.12.14
                      Inc(m_WAbil.wMP, nRockAddHPMP);
                      if m_WAbil.wMP > m_WAbil.wMaxMP then m_WAbil.wMP := m_WAbil.wMaxMP;
                      nTempDura := m_UseItems[U_CHARM].wDura * 10;
                      Dec(nTempDura, nHPMPRockDecDura); //清清 2007.12.14
                      m_UseItems[U_CHARM].wDura := Round(nTempDura / 10);
                      if TBaseObject_btRaceServer(PlayObject)^ =0 then begin //人物  20080309
                        //TBaseObject_SendMsg(PlayObject, PlayObject, RM_ABILITY, 0, 0, 0, 0, nil); //改变人物属性MP
                        TPlugOfEngine_HealthSpellChanged(PlayObject);
                        TBaseObject_SendMsg(PlayObject, PlayObject, RM_DURACHANGE, U_CHARM, m_UseItems[U_CHARM].wDura, m_UseItems[U_CHARM].wDuraMax, 0, nil);  //清清 2007.12.14
                      end;// else
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                        //TBaseObject_SendMsg(TBaseObject_Master(PlayObject)^, TBaseObject_Master(PlayObject)^,RM_HEROABILITY, 0, 0, 0, 0, nil);
                        TPlugOfEngine_HealthSpellChanged(PlayObject);
                        TBaseObject_SendMsg(TBaseObject_Master(PlayObject)^, TBaseObject_Master(PlayObject)^, RM_HERODURACHANGE, U_CHARM, m_UseItems[U_CHARM].wDura, m_UseItems[U_CHARM].wDuraMax, 0, nil);
                      end;// else
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYMOSTER then//人形 20080428
                         TPlugOfEngine_HealthSpellChanged(PlayObject);

                      if m_UseItems[U_CHARM].wDura <= 0 then begin//20080725
                        if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin
                          TPlayObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                          m_UseItems[U_CHARM].wIndex:= 0;
                        end else
                        if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                          THeroObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                          m_UseItems[U_CHARM].wIndex:= 0;
                        end else m_UseItems[U_CHARM].wIndex:= 0;
                      end;                         
                    end else begin
                      Inc(m_WAbil.wMP, nRockAddHPMP);
                      if m_WAbil.wMP > m_WAbil.wMaxMP then m_WAbil.wMP := m_WAbil.wMaxMP;
                      m_UseItems[U_CHARM].wDura := 0;
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_PLAYOBJECT then begin
                        TPlayObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end else
                      if TBaseObject_btRaceServer(PlayObject)^ = RC_HEROOBJECT then begin //英雄  20080309
                        THeroObject_SendDelItem(PlayObject,@m_UseItems[U_CHARM]);
                        m_UseItems[U_CHARM].wIndex:= 0;
                      end;
                    end;
                  end;
                end;
            end;//3 begin
          end;
        end;
      end;
    end;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.SuperRock');
  end;
end;

procedure TFrmFunctionConfig.ButtonSuperRockSaveClick(Sender: TObject);
var
  Config: TIniFile;
  sFileName: string;
begin
  Try
  sFileName := '.\zPlugOfEngine.ini';
  Config := TIniFile.Create(sFileName);
  if Config <> nil then begin
    Config.WriteInteger(PlugClass, 'StartHPRock', nStartHPRock);
    Config.WriteInteger(PlugClass, 'StartMPRock', nStartMPRock);
    Config.WriteInteger(PlugClass, 'StartHPMPRock', nStartHPMPRock);
    Config.WriteInteger(PlugClass, 'HPRockSpell', nHPRockSpell);
    Config.WriteInteger(PlugClass, 'MPRockSpell', nMPRockSpell);
    Config.WriteInteger(PlugClass, 'HPMPRockSpell', nHPMPRockSpell);
    Config.WriteInteger(PlugClass, 'RockAddHP', nRockAddHP);
    Config.WriteInteger(PlugClass, 'RockAddMP', nRockAddMP);
    Config.WriteInteger(PlugClass, 'RockAddHPMP', nRockAddHPMP);
    Config.WriteInteger(PlugClass, 'HPRockDecDura', nHPRockDecDura);
    Config.WriteInteger(PlugClass, 'MPRockDecDura', nMPRockDecDura);
    Config.WriteInteger(PlugClass, 'HPMPRockDecDura', nHPMPRockDecDura);
    Config.WriteBool(PlugClass, 'StartHPRockHint', boStartHPRockMsg);
    Config.WriteBool(PlugClass, 'StartMPRockHint', boStartMPRockMsg);
    Config.WriteBool(PlugClass, 'StartHPMPRockHint', boStartHPMPRockMsg);
    Config.WriteString(PlugClass, 'StartHPRockMsg', sStartHPRockMsg);
    Config.WriteString(PlugClass, 'StartMPRockMsg', sStartMPRockMsg);
    Config.WriteString(PlugClass, 'StartHPMPRockMsg', sStartHPMPRockMsg);
    Config.Free;
  end;
  uModValue();
  except
    MainOutMessage('[异常] PlugOfEngine.ButtonSuperRockSaveClick');
  end;
end;

procedure InitUserConfig();
var
  Config: TIniFile;
  sFileName: string;
  nLoadInteger: Integer;
  LoadString: string;
begin
Try
  sFileName := '.\zPlugOfEngine.ini';
  Config := TIniFile.Create(sFileName);
  if Config <> nil then begin
    nLoadInteger := Config.ReadInteger(PlugClass, 'StartHPRock', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'StartHPRock', nStartHPRock)
    else nStartHPRock := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'StartMPRock', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'StartMPRock', nStartMPRock)
    else nStartMPRock := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'StartHPMPRock', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'StartHPMPRock', nStartHPMPRock)
    else nStartHPMPRock := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'HPRockSpell', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'HPRockSpell', nHPRockSpell)
    else nHPRockSpell := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'MPRockSpell', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'MPRockSpell', nMPRockSpell)
    else nMPRockSpell := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'HPMPRockSpell', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'HPMPRockSpell', nHPMPRockSpell)
    else nHPMPRockSpell := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'RockAddHP', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'RockAddHP', nRockAddHP)
    else nRockAddHP := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'RockAddMP', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'RockAddMP', nRockAddMP)
    else nRockAddMP := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'RockAddHPMP', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'RockAddHPMP', nRockAddHPMP)
    else nRockAddHPMP := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'HPRockDecDura', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'HPRockDecDura', nHPRockDecDura)
    else nHPRockDecDura := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'MPRockDecDura', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'MPRockDecDura', nMPRockDecDura)
    else nMPRockDecDura := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'HPMPRockDecDura', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'HPMPRockDecDura', nHPMPRockDecDura)
    else nHPMPRockDecDura := nLoadInteger;

    {if Config.ReadInteger(PlugClass, 'StartHPRockHint', -1) < 0 then  20080227日注释
      Config.WriteBool(PlugClass, 'StartHPRockHint', boStartHPRockMsg);
    boStartHPRockMsg := Config.ReadBool(PlugClass, 'StartHPRockHint', boStartHPRockMsg);

    if Config.ReadInteger(PlugClass, 'StartMPRockHint', -1) < 0 then
      Config.WriteBool(PlugClass, 'StartMPRockHint', boStartMPRockMsg);
    boStartMPRockMsg := Config.ReadBool(PlugClass, 'StartMPRockHint', boStartMPRockMsg);

    if Config.ReadInteger(PlugClass, 'StartHPMPRockHint', -1) < 0 then
      Config.WriteBool(PlugClass, 'StartHPMPRockHint', boStartHPMPRockMsg);
    boStartHPMPRockMsg := Config.ReadBool(PlugClass, 'StartHPMPRockHint', boStartHPMPRockMsg);   }

    LoadString := Config.ReadString(PlugClass, 'StartHPRockMsg', '');
    if LoadString = '' then
      Config.WriteString(PlugClass, 'StartHPRockMsg', sStartHPRockMsg)
    else sStartHPRockMsg := LoadString;

    LoadString := Config.ReadString(PlugClass, 'StartMPRockMsg', '');
    if LoadString = '' then
      Config.WriteString(PlugClass, 'StartMPRockMsg', sStartMPRockMsg)
    else sStartMPRockMsg := LoadString;

    LoadString := Config.ReadString(PlugClass, 'StartHPMPRockMsg', '');
    if LoadString = '' then
      Config.WriteString(PlugClass, 'StartHPMPRockMsg', sStartHPMPRockMsg)
    else sStartHPMPRockMsg := LoadString;

    ////////////////////////////////////////////////////////////////////////////////
    if Config.ReadInteger(PlugClass, 'CCAttack', -1) < 0 then
      Config.WriteBool(PlugClass, 'CCAttack', boCCAttack);
    boCCAttack := Config.ReadBool(PlugClass, 'CCAttack', boCCAttack);

    if Config.ReadInteger(PlugClass, 'DataAttack', -1) < 0 then
      Config.WriteBool(PlugClass, 'DataAttack', boDataAttack);
    boDataAttack := Config.ReadBool(PlugClass, 'DataAttack', boDataAttack);

    if Config.ReadInteger(PlugClass, 'KeepConnect', -1) < 0 then
      Config.WriteBool(PlugClass, 'KeepConnect', boKeepConnectTimeOut);
    boKeepConnectTimeOut := Config.ReadBool(PlugClass, 'KeepConnect', boKeepConnectTimeOut);

    nLoadInteger := Config.ReadInteger(PlugClass, 'CCAttackTime', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'CCAttackTime', dwAttackTick)
    else dwAttackTick := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'ReviceMsgLength', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'ReviceMsgLength', nReviceMsgLength)
    else nReviceMsgLength := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'KeepConnectTimeOut', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut)
    else dwKeepConnectTimeOut := nLoadInteger;

    if Config.ReadInteger(PlugClass, 'StartAttack', -1) < 0 then
      Config.WriteBool(PlugClass, 'StartAttack', boStartAttack);
    boStartAttack := Config.ReadBool(PlugClass, 'StartAttack', boStartAttack);

    Config.Free;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.InitUserConfig');
  end;
end;

procedure TFrmFunctionConfig.Open();
var
  I: Integer;
  //StdItem: _LPTOSTDITEM;  //20080728修改 使用新类
  StdItem: _LPTSTDITEM;
  List: Classes.TList;
begin
  boOpened := False;
  uModValue();
  ListBoxitemList.Items.Clear;
  ListBoxUserCommand.Items.Clear;
  if TUserEngine_GetStdItemList <> nil then begin
    List := Classes.TList(TUserEngine_GetStdItemList);
    if List.Count > 0 then begin//20080629
      for I := 0 to List.Count - 1 do begin
        StdItem := List.Items[I];
        ListBoxitemList.Items.AddObject(StdItem.szName, TObject(StdItem));
      end;
    end;
  end;
  RefSuperRock();
  RefLoadMsgFilterList();
  RefLoadDisallowStdItems();
  RefLoadAttackInfo();
  ListBoxUserCommand.Items.AddStrings(g_UserCmdList);
  boOpened := TRUE;
  FunctionConfigControl.ActivePageIndex := 0;
  ShowModal;
end;

procedure TFrmFunctionConfig.ModValue;
begin
  boModValued := TRUE;
  ButtonSuperRockSave.Enabled := TRUE;
  ButtonUserCommandSave.Enabled := TRUE;
  BtnDisallowSave.Enabled := TRUE;
  ButtonMsgFilterSave.Enabled := TRUE;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.uModValue;
begin
  boModValued := False;
  ButtonSuperRockSave.Enabled := False;
  ButtonUserCommandDel.Enabled := False;
  ButtonUserCommandChg.Enabled := False;
  BtnDisallowDel.Enabled := False;
  ButtonMsgFilterDel.Enabled := False;
  ButtonMsgFilterChg.Enabled := False;
  ButtonAttackSave.Enabled := False;
  BtnDisallowSave.Enabled := False;
  BtnDisallowAdd.Enabled := False;
  BtnDisallowChg.Enabled := False;
end;

procedure TFrmFunctionConfig.RefSuperRock();
begin
  SpinEditStartHPRock.Value := nStartHPRock;
  SpinEditStartMPRock.Value := nStartMPRock;
  SpinEditStartHPMPRock.Value := nStartHPMPRock;
  SpinEditHPRockSpell.Value := nHPRockSpell;
  SpinEditMPRockSpell.Value := nMPRockSpell;
  SpinEditHPMPRockSpell.Value := nHPMPRockSpell;
  SpinEditRockAddHP.Value := nRockAddHP;
  SpinEditRockAddMP.Value := nRockAddMP;
  SpinEditRockAddHPMP.Value := nRockAddHPMP;
  SpinEditHPRockDecDura.Value := nHPRockDecDura;
  SpinEditMPRockDecDura.Value := nMPRockDecDura;
  SpinEditHPMPRockDecDura.Value := nHPMPRockDecDura;
  CheckBoxStartHPRock.Checked := boStartHPRockMsg;
  CheckBoxStartMPRock.Checked := boStartMPRockMsg;
  CheckBoxStartHPMPRock.Checked := boStartHPMPRockMsg;
  EditStartHPRockMsg.Text := sStartHPRockMsg;
  EditStartMPRockMsg.Text := sStartMPRockMsg;
  EditStartHPMPRockMsg.Text := sStartHPMPRockMsg;
end;

procedure TFrmFunctionConfig.CheckBoxStartHPRockClick(Sender: TObject);
begin
  if not boOpened then Exit;
  boStartHPRockMsg := CheckBoxStartHPRock.Checked;
  ButtonSuperRockSave.Enabled := TRUE;
  if boStartHPRockMsg then
    EditStartHPRockMsg.Enabled := TRUE
  else EditStartHPRockMsg.Enabled := False;
end;

procedure TFrmFunctionConfig.CheckBoxStartMPRockClick(Sender: TObject);
begin
  if not boOpened then Exit;
  boStartMPRockMsg := CheckBoxStartMPRock.Checked;
  ButtonSuperRockSave.Enabled := TRUE;
  if boStartMPRockMsg then
    EditStartMPRockMsg.Enabled := TRUE
  else EditStartMPRockMsg.Enabled := False;
end;

procedure TFrmFunctionConfig.EditStartHPRockMsgChange(Sender: TObject);
begin
  if not boOpened then Exit;
  sStartHPRockMsg := Trim(EditStartHPRockMsg.Text);
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.EditStartMPRockMsgChange(Sender: TObject);
begin
  if not boOpened then Exit;
  sStartMPRockMsg := Trim(EditStartMPRockMsg.Text);
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditStartHPRockChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nStartHPRock := SpinEditStartHPRock.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditHPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nHPRockSpell := SpinEditHPRockSpell.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditRockAddHPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nRockAddHP := SpinEditRockAddHP.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditHPRockDecDuraChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nHPRockDecDura := SpinEditHPRockDecDura.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditMPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nMPRockSpell := SpinEditMPRockSpell.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditRockAddMPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nRockAddMP := SpinEditRockAddMP.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditMPRockDecDuraChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nMPRockDecDura := SpinEditMPRockDecDura.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditStartMPRockChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nStartMPRock := SpinEditStartMPRock.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.ListBoxUserCommandClick(Sender: TObject);
begin
  try
    EditCommandName.Text := ListBoxUserCommand.Items.Strings[ListBoxUserCommand.ItemIndex];
    SpinEditCommandIdx.Value := Integer(ListBoxUserCommand.Items.Objects[ListBoxUserCommand.ItemIndex]);
    ButtonUserCommandDel.Enabled := TRUE;
    ButtonUserCommandChg.Enabled := TRUE;
  except
    EditCommandName.Text := '';
    SpinEditCommandIdx.Value := 0;
    ButtonUserCommandDel.Enabled := False;
    ButtonUserCommandChg.Enabled := False;
  end;
end;

function TFrmFunctionConfig.InCommandListOfIndex(nIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  Try
  if ListBoxUserCommand.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
      if nIndex = Integer(ListBoxUserCommand.Items.Objects[I]) then begin
        Result := TRUE;
        break;
      end;
    end;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.InCommandListOfIndex');
  end;
end;

function TFrmFunctionConfig.InCommandListOfName(sCommandName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  Try
  if ListBoxUserCommand.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
      if CompareText(sCommandName, ListBoxUserCommand.Items.Strings[I]) = 0 then begin
        Result := TRUE;
        break;
      end;
    end;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.InCommandListOfName');
  end;
end;

procedure TFrmFunctionConfig.ButtonUserCommandAddClick(Sender: TObject);
var
  sCommandName: string;
  nCommandIndex: Integer;
begin
  sCommandName := Trim(EditCommandName.Text);
  nCommandIndex := SpinEditCommandIdx.Value;
  if sCommandName = '' then begin
    Application.MessageBox('请输入命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfName(sCommandName) then begin
    Application.MessageBox('输入的命令已经存在，请选择其他命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfIndex(nCommandIndex) then begin
    Application.MessageBox('输入的命令编号已经存在，请选择其他命令编号！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListBoxUserCommand.Items.AddObject(sCommandName, TObject(nCommandIndex));
end;

procedure TFrmFunctionConfig.ButtonUserCommandDelClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认删除此命令？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    try
      ListBoxUserCommand.DeleteSelected;
    except
    end;
  end;
end;

procedure TFrmFunctionConfig.ButtonUserCommandChgClick(Sender: TObject);
var
  sCommandName: string;
  nCommandIndex: Integer;
  nItemIndex: Integer;
begin
  sCommandName := Trim(EditCommandName.Text);
  nCommandIndex := SpinEditCommandIdx.Value;
  if sCommandName = '' then begin
    Application.MessageBox('请输入命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfName(sCommandName) then begin
    Application.MessageBox('你要修改的命令已经存在，请选择其他命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfIndex(nCommandIndex) then begin
    Application.MessageBox('你要修改的命令编号已经存在，请选择其他命令编号！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  nItemIndex := ListBoxUserCommand.ItemIndex;
  try
    ListBoxUserCommand.Items.Strings[nItemIndex] := sCommandName;
    ListBoxUserCommand.Items.Objects[nItemIndex] := TObject(nCommandIndex);
    Application.MessageBox('修改完成！！！', '提示信息', MB_ICONQUESTION);
  except
    Application.MessageBox('修改失败！！！', '提示信息', MB_ICONQUESTION);
  end;
end;

procedure TFrmFunctionConfig.ButtonUserCommandSaveClick(Sender: TObject);
var
  sFileName: string;
  I: Integer;
  sCommandName: string;
  nCommandIndex: Integer;
  SaveList: Classes.TStringList;
begin
  ButtonUserCommandSave.Enabled := False;
  sFileName := '.\UserCmd.txt';
  SaveList := Classes.TStringList.Create;
  SaveList.Add(';引擎插件配置文件');
  SaveList.Add(';命令名称'#9'对应编号');
  if ListBoxUserCommand.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
      sCommandName := ListBoxUserCommand.Items.Strings[I];
      nCommandIndex := Integer(ListBoxUserCommand.Items.Objects[I]);
      SaveList.Add(sCommandName + #9 + IntToStr(nCommandIndex));
    end;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonUserCommandSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.ButtonLoadUserCommandListClick(
  Sender: TObject);
begin
  ButtonLoadUserCommandList.Enabled := False;
  LoadUserCmdList();
  ListBoxUserCommand.Items.Clear;
  ListBoxUserCommand.Items.AddStrings(g_UserCmdList);
  Application.MessageBox('重新加载自定义命令列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadUserCommandList.Enabled := TRUE;
end;


procedure TFrmFunctionConfig.RefLoadDisallowStdItems();
var
  I: Integer;
  //ListItem: TListItem;//20080419
  CheckItem: pTCheckItem;
  sItemName: string;
  {boCanDrop: Boolean; //20080419
  boCanDeal: Boolean;
  boCanStorage: Boolean;
  boCanRepair: Boolean;
  boCanDropHint: Boolean; //是否掉落提示
  boCanOpenBoxsHint: Boolean; //是否开宝箱提示
  boCanNoDropItem: Boolean; //是否永不暴出
  boCanButchHint: Boolean;  //是否挖取提示  }
  DisallowInfo: pTDisallowInfo;
begin
  Try
  ListBoxDisallow.Items.Clear;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := pTCheckItem(g_CheckItemList.Items[I]);
      sItemName := CheckItem.szItemName;
      New(DisallowInfo);
      DisallowInfo.boDrop := CheckItem.boCanDrop;
      DisallowInfo.boDeal := CheckItem.boCanDeal;
      DisallowInfo.boStorage := CheckItem.boCanStorage;
      DisallowInfo.boRepair := CheckItem.boCanRepair;
      DisallowInfo.boDropHint := CheckItem.boCanDropHint;
      DisallowInfo.boOpenBoxsHint := CheckItem.boCanOpenBoxsHint;
      DisallowInfo.boNoDropItem := CheckItem.boCanNoDropItem;
      DisallowInfo.boButchHint := CheckItem.boCanButchHint;
      DisallowInfo.boHeroUse := CheckItem.boCanHeroUse;
      DisallowInfo.boPickUpItem := CheckItem.boPickUpItem;//禁止捡起(除GM外) 20080611
      DisallowInfo.boDieDropItems := CheckItem.boDieDropItems;//死亡掉落 20080614
      ListBoxDisallow.AddItem(sItemName, TObject(DisallowInfo));
      {boCanDrop := CheckItem.boCanDrop;
      boCanDeal := CheckItem.boCanDeal;
      boCanStorage := CheckItem.boCanStorage;
      boCanRepair := CheckItem.boCanRepair;
      boCanDropHint := CheckItem.boCanDropHint;
      boCanOpenBoxsHint := CheckItem.boCanOpenBoxsHint;
      boCanNoDropItem := CheckItem.boCanNoDropItem;

      boCanButchHint := CheckItem.boCanButchHint;   }



      {ListViewDisallow.Items.BeginUpdate;
      try
        ListItem := ListViewDisallow.Items.Add;
        ListItem.Caption := sItemName;
        ListItem.SubItems.Add(sCanDrop);
        ListItem.SubItems.Add(sCanDeal);
        ListItem.SubItems.Add(sCanStorage);
        ListItem.SubItems.Add(sCanRepair);
        ListItem.SubItems.Add(sCanDropHint);
        ListItem.SubItems.Add(sCanOpenBoxsHint);
        ListItem.SubItems.Add(sCanNoDropItem);
        ListItem.SubItems.Add(sCanButchHint);
      finally
        ListViewDisallow.Items.EndUpdate;
      end;    }
    end;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.RefLoadDisallowStdItems');
  end;
end;

procedure TFrmFunctionConfig.BtnDisallowSaveClick(Sender: TObject);
var
  I: Integer;
  SaveList: Classes.TStringList;
  sFileName: string;
  sLineText: string;
  sItemName: string;
  sCanDrop: string;
  sCanDeal: string;
  sCanStorage: string;
  sCanRepair: string;
  sCanDropHint: string; //是否掉落提示
  sCanOpenBoxsHint: string; //是否开宝箱提示
  sCanNoDropItem: string; //是否永不暴出
  sCanButchHint: string;  //是否挖取提示
  sCanHeroUse: string; //是否禁止英雄使用
  sCanPickUpItem: string;//是否禁止捡起(除GM外) 20080611
  sCanDieDropItems: string;//死亡掉落 20080614
begin
  Try
  BtnDisallowSave.Enabled := False;
  sFileName := '.\CheckItemList.txt';
  SaveList := Classes.TStringList.Create;
  SaveList.Add(';引擎插件禁止物品配置文件');
  SaveList.Add(';物品名称'#9'丢弃'#9'交易'#9'存仓'#9'修理'#9'掉落提示'#9'开宝箱提示'#9'永不暴出'#9'挖取提示');
  if ListBoxDisallow.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxDisallow.Items.Count - 1 do begin
      sItemName := ListBoxDisallow.Items.Strings[I];
      sCanDrop := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDrop);
      sCanDeal := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDeal);
      sCanStorage := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boStorage);
      sCanRepair := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boRepair);
      sCanDropHint := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDropHint);
      sCanOpenBoxsHint := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boOpenBoxsHint);
      sCanNoDropItem := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boNoDropItem);
      sCanButchHint := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boButchHint);
      sCanHeroUse := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boHeroUse);
      sCanPickUpItem := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boPickUpItem);//是否禁止捡起(除GM外) 20080611
      sCanDieDropItems:= BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDieDropItems);//死亡掉落 20080614
      sLineText := sItemName + #9 + sCanDrop + #9 + sCanDeal + #9 + sCanStorage + #9 + sCanRepair + #9 +sCanDropHint + #9 + sCanOpenBoxsHint + #9 + sCanNoDropItem + #9 + sCanButchHint + #9 + sCanHeroUse + #9 + sCanPickUpItem+ #9 +sCanDieDropItems;
      SaveList.Add(sLineText);
    end;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  if Application.MessageBox('此设置必须重新加载物品配置才能生效，是否重新加载？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    LoadCheckItemList();
    RefLoadDisallowStdItems();
  end else begin
    BtnDisallowSave.Enabled := True;
    Exit;
  end;
  BtnDisallowSave.Enabled := False;
  except
    MainOutMessage('[异常] PlugOfEngine.BtnDisallowSaveClick');
  end;
end;

procedure TFrmFunctionConfig.RefLoadMsgFilterList();
var
  I: Integer;
  ListItem: TListItem;
  FilterMsg: pTFilterMsg;
begin
  Try
  ListViewMsgFilter.Items.BeginUpdate;
  ListViewMsgFilter.Items.Clear;
  try
    if g_MsgFilterList.Count > 0 then begin//20080629
      for I := 0 to g_MsgFilterList.Count - 1 do begin
        ListItem := ListViewMsgFilter.Items.Add;
        FilterMsg := g_MsgFilterList.Items[I];
        ListItem.Caption := FilterMsg.sFilterMsg;
        ListItem.SubItems.Add(FilterMsg.sNewMsg);
      end;
    end;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.RefLoadMsgFilterList');
  end;
end;

procedure TFrmFunctionConfig.ListViewMsgFilterClick(Sender: TObject);
var
  ListItem: TListItem;
  nItemIndex: Integer;
begin
  try
    nItemIndex := ListViewMsgFilter.ItemIndex;
    ListItem := ListViewMsgFilter.Items.Item[nItemIndex];
    EditFilterMsg.Text := ListItem.Caption;
    EditNewMsg.Text := ListItem.SubItems.Strings[0];
    ButtonMsgFilterDel.Enabled := TRUE;
    ButtonMsgFilterChg.Enabled := TRUE;
  except
    EditFilterMsg.Text := '';
    EditNewMsg.Text := '';
    ButtonMsgFilterDel.Enabled := False;
    ButtonMsgFilterChg.Enabled := False;
  end;
end;

procedure TFrmFunctionConfig.ButtonLoadMsgFilterListClick(Sender: TObject);
begin
  ButtonLoadMsgFilterList.Enabled := False;
  LoadMsgFilterList();
  RefLoadMsgFilterList();
  Application.MessageBox('重新加载消息过滤列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadMsgFilterList.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterSaveClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: Classes.TStringList;
  sFilterMsg: string;
  sNewMsg: string;
  sFileName: string;
begin
Try
  ButtonMsgFilterSave.Enabled := False;
  sFileName := '.\MsgFilterList.txt';
  SaveList := Classes.TStringList.Create;
  SaveList.Add(';引擎插件消息过滤配置文件');
  SaveList.Add(';过滤消息'#9'替换消息');
  ListViewMsgFilter.Items.BeginUpdate;
  try
    if ListViewMsgFilter.Items.Count > 0 then begin//20080629
      for I := 0 to ListViewMsgFilter.Items.Count - 1 do begin
        ListItem := ListViewMsgFilter.Items.Item[I];
        sFilterMsg := ListItem.Caption;
        sNewMsg := ListItem.SubItems.Strings[0];
        SaveList.Add(sFilterMsg + #9 + sNewMsg);
      end;
    end;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonMsgFilterSave.Enabled := TRUE;
  except
    MainOutMessage('[异常] PlugOfEngine.ButtonMsgFilterSaveClick');
  end;
end;

function TFrmFunctionConfig.InFilterMsgList(sFilterMsg: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
Try
  ListViewMsgFilter.Items.BeginUpdate;
  try
    if ListViewMsgFilter.Items.Count > 0 then begin//20080629
      for I := 0 to ListViewMsgFilter.Items.Count - 1 do begin
        ListItem := ListViewMsgFilter.Items.Item[I];
        if CompareText(sFilterMsg, ListItem.Caption) = 0 then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.InFilterMsgList');
  end;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterAddClick(Sender: TObject);
var
  sFilterMsg: string;
  sNewMsg: string;
  ListItem: TListItem;
begin
  sFilterMsg := Trim(EditFilterMsg.Text);
  sNewMsg := Trim(EditNewMsg.Text);
  if sFilterMsg = '' then begin
    Application.MessageBox('请输入过滤消息！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InFilterMsgList(sFilterMsg) then begin
    Application.MessageBox('你输入的过滤消息已经存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListViewMsgFilter.Items.BeginUpdate;
  try
    ListItem := ListViewMsgFilter.Items.Add;
    ListItem.Caption := sFilterMsg;
    ListItem.SubItems.Add(sNewMsg);
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterChgClick(Sender: TObject);
var
  sFilterMsg: string;
  sNewMsg: string;
  ListItem: TListItem;
begin
  sFilterMsg := Trim(EditFilterMsg.Text);
  sNewMsg := Trim(EditNewMsg.Text);
  if sFilterMsg = '' then begin
    Application.MessageBox('请输入过滤消息！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InFilterMsgList(sFilterMsg) then begin
    Application.MessageBox('你输入的过滤消息已经存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListViewMsgFilter.Items.BeginUpdate;
  try
    ListItem := ListViewMsgFilter.Items.Item[ListViewMsgFilter.ItemIndex];
    ListItem.Caption := sFilterMsg;
    ListItem.SubItems.Strings[0] := sNewMsg;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterDelClick(Sender: TObject);
begin
  try
    ListViewMsgFilter.DeleteSelected;
  except
  end;
end;

procedure TFrmFunctionConfig.CheckBoxAttack1Click(Sender: TObject);
begin
  if not boOpened then Exit;
  boCCAttack := CheckBoxAttack1.Checked;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.CheckBoxAttack2Click(Sender: TObject);
begin
  if not boOpened then Exit;
  boDataAttack := CheckBoxAttack2.Checked;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.CheckBoxAttack3Click(Sender: TObject);
begin
  if not boOpened then Exit;
  boKeepConnectTimeOut := CheckBoxAttack3.Checked;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditAttack1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  dwAttackTick := SpinEditAttack1.Value;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditAttack2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  nReviceMsgLength := SpinEditAttack2.Value;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditAttack3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  dwKeepConnectTimeOut := SpinEditAttack3.Value;
  ButtonAttackSave.Enabled := TRUE;
end;
procedure TFrmFunctionConfig.RefLoadAttackInfo();
begin
  CheckBoxAttack1.Checked := boCCAttack;
  CheckBoxAttack2.Checked := boDataAttack;
  CheckBoxAttack3.Checked := boKeepConnectTimeOut;
  SpinEditAttack1.Value := dwAttackTick;
  SpinEditAttack2.Value := nReviceMsgLength;
  SpinEditAttack3.Value := dwKeepConnectTimeOut;
  CheckBoxStart.Checked := boStartAttack;
  if CheckBoxStart.Checked then begin
    CheckBoxAttack1.Enabled := TRUE;
    CheckBoxAttack2.Enabled := TRUE;
    CheckBoxAttack3.Enabled := TRUE;
    SpinEditAttack1.Enabled := TRUE;
    SpinEditAttack2.Enabled := TRUE;
    SpinEditAttack3.Enabled := TRUE;
  end else begin
    CheckBoxAttack1.Enabled := False;
    CheckBoxAttack2.Enabled := False;
    CheckBoxAttack3.Enabled := False;
    SpinEditAttack1.Enabled := False;
    SpinEditAttack2.Enabled := False;
    SpinEditAttack3.Enabled := False;
  end;
end;

procedure TFrmFunctionConfig.ButtonAttackSaveClick(Sender: TObject);
var
  Config: TIniFile;
  sFileName: string;
begin
  ButtonAttackSave.Enabled := False;
  sFileName := '.\zPlugOfEngine.ini';
  Config := TIniFile.Create(sFileName);
  if Config <> nil then begin
    Config.WriteBool(PlugClass, 'CCAttack', boCCAttack);
    Config.WriteBool(PlugClass, 'DataAttack', boDataAttack);
    Config.WriteBool(PlugClass, 'KeepConnect', boKeepConnectTimeOut);
    Config.WriteBool(PlugClass, 'StartAttack', boStartAttack);
    Config.WriteInteger(PlugClass, 'CCAttackTime', dwAttackTick);
    Config.WriteInteger(PlugClass, 'ReviceMsgLength', nReviceMsgLength);
    Config.WriteInteger(PlugClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);
    Config.Free;
  end;
end;

procedure TFrmFunctionConfig.CheckBoxStartClick(Sender: TObject);
begin
  if not boOpened then Exit;
  ButtonAttackSave.Enabled := TRUE;
  CheckBoxStart.Enabled := False;
  if CheckBoxStart.Checked then begin
    InitAttack();
    boStartAttack := TRUE;
    CheckBoxAttack1.Enabled := TRUE;
    CheckBoxAttack2.Enabled := TRUE;
    CheckBoxAttack3.Enabled := TRUE;
    SpinEditAttack1.Enabled := TRUE;
    SpinEditAttack2.Enabled := TRUE;
    SpinEditAttack3.Enabled := TRUE;
  end else begin
    boStartAttack := False;
    CheckBoxAttack1.Enabled := False;
    CheckBoxAttack2.Enabled := False;
    CheckBoxAttack3.Enabled := False;
    SpinEditAttack1.Enabled := False;
    SpinEditAttack2.Enabled := False;
    SpinEditAttack3.Enabled := False;
    UnInitAttack();
  end;
  CheckBoxStart.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.EditStartHPMPRockMsgChange(Sender: TObject);
begin
  if not boOpened then Exit;
  sStartHPMPRockMsg := Trim(EditStartHPMPRockMsg.Text);
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditStartHPMPRockChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nStartHPMPRock := SpinEditStartHPMPRock.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditHPMPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nHPMPRockSpell := SpinEditHPMPRockSpell.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditRockAddHPMPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nRockAddHPMP := SpinEditRockAddHPMP.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditHPMPRockDecDuraChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  nHPMPRockDecDura := SpinEditHPMPRockDecDura.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.CheckBoxStartHPMPRockClick(Sender: TObject);
begin
  if not boOpened then Exit;
  boStartHPMPRockMsg := CheckBoxStartHPMPRock.Checked;
  ButtonSuperRockSave.Enabled := TRUE;
  if boStartHPMPRockMsg then
    EditStartHPMPRockMsg.Enabled := TRUE
  else EditStartHPMPRockMsg.Enabled := False;
end;

procedure TFrmFunctionConfig.DisallowSelAll(SelAll: Boolean);
begin
  if SelAll then begin
    CheckBoxDisallowDrop.Checked         := True;
    CheckBoxDisallowDeal.Checked         := True;
    CheckBoxDisallowStorage.Checked      := True;
    CheckBoxDisallowRepair.Checked       := True;
    CheckBoxDisallowDropHint.Checked     := True;
    CheckBoxDisallowOpenBoxsHint.Checked := True;
    CheckBoxDisallowNoDropItem.Checked   := True;
    CheckBoxDisallowButchHint.Checked    := True;
    CheckBoxDisallowHeroUse.Checked      := True;
    CheckBoxDieDropItems.Checked := True;
  end else begin
    CheckBoxDisallowDrop.Checked         := False;
    CheckBoxDisallowDeal.Checked         := False;
    CheckBoxDisallowStorage.Checked      := False;
    CheckBoxDisallowRepair.Checked       := False;
    CheckBoxDisallowDropHint.Checked     := False;
    CheckBoxDisallowOpenBoxsHint.Checked := False;
    CheckBoxDisallowNoDropItem.Checked   := False;
    CheckBoxDisallowButchHint.Checked    := False;
    CheckBoxDisallowHeroUse.Checked      := False;
    CheckBoxDieDropItems.Checked := False;
  end;
end;

procedure TFrmFunctionConfig.BtnDisallowSelAllClick(Sender: TObject);
begin
  DisallowSelAll(True);
end;

procedure TFrmFunctionConfig.BtnDisallowCancelAllClick(Sender: TObject);
begin
  DisallowSelAll(False);
end;

procedure TFrmFunctionConfig.BtnDisallowAddClick(Sender: TObject);
var
  DisallowInfo: pTDisallowInfo;
  sItemName: string;
  I: Integer;
begin
Try
  sItemName := Trim(EditItemName.Text);
    if ListBoxDisallow.Items.Count > 0 then begin//20080629
      for I := 0 to ListBoxDisallow.Items.Count - 1 do begin
        if CompareText(ListBoxDisallow.Items.Strings[I], sItemName)= 0 then begin
          Application.MessageBox('此物品已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
          Exit;
        end;
      end;
    end;
    New(DisallowInfo);
    DisallowInfo.boDrop := CheckBoxDisallowDrop.Checked; //禁止丢弃
    DisallowInfo.boDeal := CheckBoxDisallowDeal.Checked; //禁止交易
    DisallowInfo.boStorage := CheckBoxDisallowStorage.Checked; //禁止存仓
    DisallowInfo.boRepair := CheckBoxDisallowRepair.Checked; //禁止修理
    DisallowInfo.boDropHint := CheckBoxDisallowDropHint.Checked; //掉落提示
    DisallowInfo.boOpenBoxsHint := CheckBoxDisallowOpenBoxsHint.Checked; //宝箱提示
    DisallowInfo.boNoDropItem := CheckBoxDisallowNoDropItem.Checked; //永不爆出
    DisallowInfo.boButchHint := CheckBoxDisallowButchHint.Checked; //挖取提示
    DisallowInfo.boHeroUse := CheckBoxDisallowHeroUse.Checked; //禁止英雄使用
    DisallowInfo.boPickUpItem := CheckBoxDisallowPickUpItem.Checked;//禁止捡起(除GM外) 20080611
    DisallowInfo.boDieDropItems := CheckBoxDieDropItems.Checked;//死亡掉落 20080614
    ListBoxDisallow.AddItem(sItemName, Tobject(DisallowInfo));
    BtnDisallowSave.Enabled := True;
    //Dispose(DisallowInfo);
  except
    MainOutMessage('[异常] PlugOfEngine.BtnDisallowAddClick');
  end;
end;

procedure TFrmFunctionConfig.ListBoxitemListClick(Sender: TObject);
begin
  try
    EditItemName.Text := ListBoxitemList.Items.Strings[ListBoxitemList.ItemIndex];
    BtnDisallowAdd.Enabled := True;
    BtnDisallowDel.Enabled := False;
    BtnDisallowChg.Enabled := False;
  except
    EditItemName.Text := '';
    BtnDisallowAdd.Enabled := False;
  end;
end;

procedure TFrmFunctionConfig.BtnDisallowDelClick(Sender: TObject);
begin
    try
      ListBoxDisallow.DeleteSelected;
      BtnDisallowSave.Enabled := True;
    except
      BtnDisallowSave.Enabled := False;
    end;
end;

procedure TFrmFunctionConfig.BtnDisallowAddAllClick(Sender: TObject);
var
  DisallowInfo: pTDisallowInfo;
  I: Integer;
begin
Try
  ListBoxDisallow.Items.Clear;
  if ListBoxitemList.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxitemList.Items.Count - 1 do begin
      New(DisallowInfo);
      DisallowInfo.boDrop := CheckBoxDisallowDrop.Checked; //禁止丢弃
      DisallowInfo.boDeal := CheckBoxDisallowDeal.Checked; //禁止交易
      DisallowInfo.boStorage := CheckBoxDisallowStorage.Checked; //禁止存仓
      DisallowInfo.boRepair := CheckBoxDisallowRepair.Checked; //禁止修理
      DisallowInfo.boDropHint := CheckBoxDisallowDropHint.Checked; //掉落提示
      DisallowInfo.boOpenBoxsHint := CheckBoxDisallowOpenBoxsHint.Checked; //宝箱提示
      DisallowInfo.boNoDropItem := CheckBoxDisallowNoDropItem.Checked; //永不爆出
      DisallowInfo.boButchHint := CheckBoxDisallowButchHint.Checked; //挖取提示
      DisallowInfo.boHeroUse := CheckBoxDisallowHeroUse.Checked; //禁止英雄使用
      DisallowInfo.boPickUpItem := CheckBoxDisallowPickUpItem.Checked;//禁止捡起(除GM外) 20080611
      DisallowInfo.boDieDropItems := CheckBoxDieDropItems.Checked;//死亡掉落 20080614
      ListBoxDisallow.AddItem(ListBoxitemList.Items[I], Tobject(DisallowInfo));
    end;
  end;
  BtnDisallowSave.Enabled := True;
  except
    MainOutMessage('[异常] PlugOfEngine.BtnDisallowAddAllClick');
  end;
end;

procedure TFrmFunctionConfig.BtnDisallowDelAllClick(Sender: TObject);
begin
  ListBoxDisallow.Items.Clear;
  BtnDisallowSave.Enabled := True;
end;

procedure TFrmFunctionConfig.BtnDisallowChgClick(Sender: TObject);
var
  DisallowInfo: pTDisallowInfo;
  nItemIndex: Integer;
begin
Try
    nItemIndex := ListBoxDisallow.ItemIndex;
    New(DisallowInfo);
    DisallowInfo.boDrop := CheckBoxDisallowDrop.Checked; //禁止丢弃
    DisallowInfo.boDeal := CheckBoxDisallowDeal.Checked; //禁止交易
    DisallowInfo.boStorage := CheckBoxDisallowStorage.Checked; //禁止存仓
    DisallowInfo.boRepair := CheckBoxDisallowRepair.Checked; //禁止修理
    DisallowInfo.boDropHint := CheckBoxDisallowDropHint.Checked; //掉落提示
    DisallowInfo.boOpenBoxsHint := CheckBoxDisallowOpenBoxsHint.Checked; //宝箱提示
    DisallowInfo.boNoDropItem := CheckBoxDisallowNoDropItem.Checked; //永不爆出
    DisallowInfo.boButchHint := CheckBoxDisallowButchHint.Checked; //挖取提示
    DisallowInfo.boHeroUse := CheckBoxDisallowHeroUse.Checked; //禁止英雄使用
    DisallowInfo.boPickUpItem := CheckBoxDisallowPickUpItem.Checked;//禁止捡起(除GM外) 20080611
    DisallowInfo.boDieDropItems := CheckBoxDieDropItems.Checked;//死亡掉落 20080614
    ListBoxDisallow.Items.Objects[nItemIndex] := TObject(DisallowInfo);
    BtnDisallowSave.Enabled := True;
    BtnDisallowChg.Enabled := False;
    //Dispose(DisallowInfo);
  except
    MainOutMessage('[异常] PlugOfEngine.BtnDisallowChgClick');
  end;
end;

procedure TFrmFunctionConfig.ListBoxDisallowClick(Sender: TObject);
begin
  try
    EditItemName.Text := ListBoxDisallow.Items.Strings[ListBoxDisallow.ItemIndex];
    CheckBoxDisallowDrop.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boDrop;
    CheckBoxDisallowDeal.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boDeal;
    CheckBoxDisallowStorage.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boStorage;
    CheckBoxDisallowRepair.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boRepair;
    CheckBoxDisallowDropHint.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boDropHint;
    CheckBoxDisallowOpenBoxsHint.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boOpenBoxsHint;
    CheckBoxDisallowNoDropItem.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boNoDropItem;
    CheckBoxDisallowButchHint.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boButchHint;
    CheckBoxDisallowHeroUse.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boHeroUse;
    CheckBoxDisallowPickUpItem.Checked := pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boPickUpItem;//禁止捡起(除GM外) 20080611
    CheckBoxDieDropItems.Checked :=  pTDisallowInfo(ListBoxDisallow.Items.Objects[ListBoxDisallow.ItemIndex]).boDieDropItems;//死亡掉落 20080614

    BtnDisallowChg.Enabled := True;
    BtnDisallowDel.Enabled := True;
    BtnDisallowAdd.Enabled := False;
  except
    EditItemName.Text := '';
    CheckBoxDisallowDrop.Checked := False;
    CheckBoxDisallowDeal.Checked := False;
    CheckBoxDisallowStorage.Checked := False;
    CheckBoxDisallowRepair.Checked := False;
    CheckBoxDisallowDropHint.Checked := False;
    CheckBoxDisallowOpenBoxsHint.Checked := False;
    CheckBoxDisallowNoDropItem.Checked := False;
    CheckBoxDisallowButchHint.Checked := False;
    CheckBoxDisallowHeroUse.Checked := False;
    CheckBoxDisallowPickUpItem.Checked := False;
  end;
end;

procedure TFrmFunctionConfig.ListBoxitemListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = Word('F') then begin
   if ssCtrl in Shift then begin
      FindListBox();
   end;
  end;
end;

procedure TFrmFunctionConfig.FindListBox;
var
  s: string;
  I: Integer;
begin
  Try
  s := inputBox('查找物品','请输入要查找的物品名字:','');
  if ListBoxitemList.Count > 0 then begin//20080629
    for I:=0 to ListBoxitemList.Count - 1 do begin
      if CompareText(ListBoxItemList.Items.Strings[I],s) = 0 then begin
         ListBoxItemList.ItemIndex:=I;
         Exit;
      end;
    end;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.FindListBox');
  end;
end;

procedure TFrmFunctionConfig.CheckBoxDieDropItemsClick(Sender: TObject);
begin
  CheckBoxDisallowNoDropItem.Checked := False;
end;

procedure TFrmFunctionConfig.CheckBoxDisallowNoDropItemClick(
  Sender: TObject);
begin
  CheckBoxDieDropItems.Checked := False;
end;

end.


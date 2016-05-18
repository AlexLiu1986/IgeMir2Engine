unit ViewList2;

interface

uses
  Windows, SysUtils,  Forms,Dialogs, Spin, Classes, Controls, ComCtrls, StdCtrls,
  ExtCtrls;

type
  TfrmViewList2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    ListView1: TListView;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpinEdtMaxHP: TSpinEdit;
    SpinEdtMaxMP: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label4: TLabel;
    SpinEdit3: TSpinEdit;
    Label5: TLabel;
    SpinEdit4: TSpinEdit;
    Label6: TLabel;
    SpinEdit5: TSpinEdit;
    Label7: TLabel;
    SpinEdit6: TSpinEdit;
    Label8: TLabel;
    SpinEdit7: TSpinEdit;
    Label9: TLabel;
    SpinEdit8: TSpinEdit;
    Label10: TLabel;
    SpinEdit9: TSpinEdit;
    Label11: TLabel;
    SpinEdit10: TSpinEdit;
    Label12: TLabel;
    SpinEdit11: TSpinEdit;
    Label13: TLabel;
    SpinEdit12: TSpinEdit;
    Label14: TLabel;
    SpinEdit13: TSpinEdit;
    Label15: TLabel;
    SpinEdit14: TSpinEdit;
    SpinEdit15: TSpinEdit;
    Label16: TLabel;
    SpinEdit16: TSpinEdit;
    Label17: TLabel;
    SpinEdit17: TSpinEdit;
    Label18: TLabel;
    Label19: TLabel;
    SpinEdit18: TSpinEdit;
    Label20: TLabel;
    SpinEdit19: TSpinEdit;
    Label21: TLabel;
    SpinEdit20: TSpinEdit;
    SpinEdit21: TSpinEdit;
    Label22: TLabel;
    SpinEdit22: TSpinEdit;
    Label23: TLabel;
    Label24: TLabel;
    SpinEdit23: TSpinEdit;
    Label27: TLabel;
    Label28: TLabel;
    SpinEdit26: TSpinEdit;
    SpinEdit24: TSpinEdit;
    Label29: TLabel;
    Label30: TLabel;
    SpinEdit28: TSpinEdit;
    SpinEdit25: TSpinEdit;
    Label31: TLabel;
    SpinEdit30: TSpinEdit;
    Label32: TLabel;
    Edit1: TEdit;
    Label33: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label34: TLabel;
    TabSheet2: TTabSheet;
    Label35: TLabel;
    Label36: TLabel;
    ListView2: TListView;
    ListView3: TListView;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    TabSheet3: TTabSheet;
    Label37: TLabel;
    RefineItemListBox: TListBox;
    Label38: TLabel;
    ListView4: TListView;
    Label39: TLabel;
    GroupBox3: TGroupBox;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    GroupBox4: TGroupBox;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Label43: TLabel;
    Edit6: TEdit;
    Label44: TLabel;
    SpinEdit1: TSpinEdit;
    Label45: TLabel;
    SpinEdit31: TSpinEdit;
    Label46: TLabel;
    SpinEdit32: TSpinEdit;
    Label47: TLabel;
    SpinEdit33: TSpinEdit;
    GroupBox5: TGroupBox;
    Label48: TLabel;
    SpinEdit34: TSpinEdit;
    Label49: TLabel;
    SpinEdit36: TSpinEdit;
    Label50: TLabel;
    SpinEdit37: TSpinEdit;
    Label51: TLabel;
    SpinEdit38: TSpinEdit;
    SpinEdit39: TSpinEdit;
    SpinEdit40: TSpinEdit;
    SpinEdit41: TSpinEdit;
    SpinEdit42: TSpinEdit;
    SpinEdit43: TSpinEdit;
    SpinEdit44: TSpinEdit;
    SpinEdit45: TSpinEdit;
    SpinEdit46: TSpinEdit;
    SpinEdit47: TSpinEdit;
    SpinEdit48: TSpinEdit;
    SpinEdit35: TSpinEdit;
    SpinEdit49: TSpinEdit;
    SpinEdit50: TSpinEdit;
    SpinEdit51: TSpinEdit;
    SpinEdit52: TSpinEdit;
    SpinEdit53: TSpinEdit;
    SpinEdit54: TSpinEdit;
    SpinEdit55: TSpinEdit;
    SpinEdit56: TSpinEdit;
    SpinEdit57: TSpinEdit;
    SpinEdit58: TSpinEdit;
    SpinEdit59: TSpinEdit;
    SpinEdit60: TSpinEdit;
    SpinEdit61: TSpinEdit;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    TabSheet5: TTabSheet;
    GroupBox6: TGroupBox;
    ListBoxUserCommand: TListBox;
    Label79: TLabel;
    Label81: TLabel;
    SpinEditCommandIdx: TSpinEdit;
    EditCommandName: TEdit;
    ButtonUserCommandAdd: TButton;
    ButtonUserCommandDel: TButton;
    ButtonUserCommandChg: TButton;
    ButtonLoadUserCommandList: TButton;
    ButtonUserCommandSave: TButton;
    TabSheet6: TTabSheet;
    GroupBox7: TGroupBox;
    ListBoxDisallow: TListBox;
    GroupBox21: TGroupBox;
    ListBoxitemList: TListBox;
    GroupBox8: TGroupBox;
    Label89: TLabel;
    EditItemName: TEdit;
    GroupBox9: TGroupBox;
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
    BtnDisallowAdd: TButton;
    BtnDisallowDel: TButton;
    BtnDisallowAddAll: TButton;
    BtnDisallowDelAll: TButton;
    BtnDisallowChg: TButton;
    BtnDisallowSave: TButton;
    Label92: TLabel;
    TabSheet7: TTabSheet;
    GroupBox22: TGroupBox;
    ListViewMsgFilter: TListView;
    GroupBox23: TGroupBox;
    Label93: TLabel;
    Label94: TLabel;
    EditFilterMsg: TEdit;
    EditNewMsg: TEdit;
    ButtonMsgFilterAdd: TButton;
    ButtonMsgFilterDel: TButton;
    ButtonMsgFilterChg: TButton;
    ButtonMsgFilterSave: TButton;
    ButtonLoadMsgFilterList: TButton;
    TabSheet8: TTabSheet;
    GroupBox10: TGroupBox;
    ListViewItemList: TListView;
    GroupBox11: TGroupBox;
    ListBoxItemListShop: TListBox;
    Label103: TLabel;
    Panel1: TPanel;
    SpinEditPrice: TSpinEdit;
    SpinEditGameGird: TSpinEdit;
    ShopTypeBoBox: TComboBox;
    Memo1: TMemo;
    Label99: TLabel;
    Label98: TLabel;
    Label97: TLabel;
    Label96: TLabel;
    Label95: TLabel;
    Label100: TLabel;
    GroupBox12: TGroupBox;
    Label101: TLabel;
    Label102: TLabel;
    EditShopImgBegin: TEdit;
    EditShopImgEnd: TEdit;
    EditShopItemName: TEdit;
    EditShopItemIntroduce: TEdit;
    CheckBoxBuyGameGird: TCheckBox;
    ButtonSaveShopItemList: TButton;
    ButtonLoadShopItemList: TButton;
    ButtonDelShopItem: TButton;
    ButtonChgShopItem: TButton;
    ButtonAddShopItem: TButton;
    Label82: TLabel;
    SpinEdit27: TSpinEdit;
    Label83: TLabel;
    SpinEdit29: TSpinEdit;
    CheckBoxTeleport: TCheckBox;
    CheckBoxParalysis: TCheckBox;
    CheckBoxRevival: TCheckBox;
    CheckBoxMagicShield: TCheckBox;
    CheckBoxUnParalysis: TCheckBox;
    procedure ListView1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListView2DblClick(Sender: TObject);
    procedure ListView3DblClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure RefineItemListBoxDblClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure ListView4Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure ButtonUserCommandAddClick(Sender: TObject);
    procedure ButtonUserCommandDelClick(Sender: TObject);
    procedure ButtonUserCommandChgClick(Sender: TObject);
    procedure ButtonUserCommandSaveClick(Sender: TObject);
    procedure ButtonLoadUserCommandListClick(Sender: TObject);
    procedure TabSheet5Show(Sender: TObject);
    procedure ListBoxUserCommandClick(Sender: TObject);
    procedure BtnDisallowSelAllClick(Sender: TObject);
    procedure BtnDisallowCancelAllClick(Sender: TObject);
    procedure ListBoxitemListClick(Sender: TObject);
    procedure ListBoxitemListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnDisallowAddClick(Sender: TObject);
    procedure BtnDisallowDelClick(Sender: TObject);
    procedure BtnDisallowAddAllClick(Sender: TObject);
    procedure BtnDisallowDelAllClick(Sender: TObject);
    procedure BtnDisallowChgClick(Sender: TObject);
    procedure BtnDisallowSaveClick(Sender: TObject);
    procedure TabSheet6Show(Sender: TObject);
    procedure ListBoxDisallowClick(Sender: TObject);
    procedure CheckBoxDisallowNoDropItemClick(Sender: TObject);
    procedure CheckBoxDieDropItemsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ListViewMsgFilterClick(Sender: TObject);
    procedure ButtonMsgFilterAddClick(Sender: TObject);
    procedure ButtonMsgFilterDelClick(Sender: TObject);
    procedure ButtonMsgFilterChgClick(Sender: TObject);
    procedure ButtonMsgFilterSaveClick(Sender: TObject);
    procedure ButtonLoadMsgFilterListClick(Sender: TObject);
    procedure TabSheet7Show(Sender: TObject);
    procedure ListViewItemListClick(Sender: TObject);
    procedure ListBoxItemListShopClick(Sender: TObject);
    procedure ListBoxItemListShopKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBoxBuyGameGirdClick(Sender: TObject);
    procedure SpinEditGameGirdChange(Sender: TObject);
    procedure ButtonDelShopItemClick(Sender: TObject);
    procedure ButtonChgShopItemClick(Sender: TObject);
    procedure ButtonAddShopItemClick(Sender: TObject);
    procedure ButtonSaveShopItemListClick(Sender: TObject);
    procedure ButtonLoadShopItemListClick(Sender: TObject);
    procedure TabSheet8Show(Sender: TObject);
  private
    procedure LoadSuitItem;
    procedure ClearEdt;
    procedure ClearEdt1;
    procedure LoadGlobalVal;//读取全局变量 20080426
    procedure LoadGlobalAVal;//读取全局字符型变量 20080426
    procedure LoadRefineItem;//读取粹练配置 20080508
    procedure SaveRefineItemInfo; //保存粹练配置
    function InCommandListOfName(sCommandName: string): Boolean;
    function InCommandListOfIndex(nIndex: Integer): Boolean;
    procedure DisallowSelAll(SelAll: Boolean);
    procedure RefLoadDisallowStdItems();
    function InFilterMsgList(sFilterMsg: string): Boolean;
    procedure RefLoadMsgFilterList();
    function InListViewItemList(sItemName: string): Boolean;
    procedure RefLoadShopItemList();
    { Private declarations }
  public
    procedure Open;
    { Public declarations }
  end;

var
  frmViewList2: TfrmViewList2;

implementation
uses Grobal2, M2Share, LocalDB, HUtil32;
{$R *.dfm}

function IsChar(str:string):integer;//判断有几个'|'号
var I:integer;
begin
Result:=0;
  for I:=1 to length(str) do
    if (str[I] in ['|']) then begin
      Inc(Result);
    end;
end;

procedure TfrmViewList2.ClearEdt;
begin
  Edit2.Text:= '';
  Edit1.Text:= '';
  SpinEdtMaxHP.Value := 0;
  SpinEdtMaxMP.Value := 0;
  SpinEdit3.Value := 0;
  SpinEdit4.Value := 0;
  SpinEdit6.Value := 0;
  SpinEdit7.Value := 0;
  SpinEdit9.Value := 0;
  SpinEdit10.Value := 0;
  SpinEdit12.Value := 0;
  SpinEdit13.Value := 0;
  SpinEdit17.Value := 0;
  SpinEdit16.Value := 0;
  SpinEdit18.Value := 0;
  SpinEdit19.Value := 0;
  SpinEdit23.Value := 0;
  SpinEdit22.Value := 0;
  SpinEdit26.Value := 0;
  SpinEdit2.Value := 0;
  SpinEdit5.Value := 0;
  SpinEdit8.Value := 0;
  SpinEdit11.Value := 0;
  SpinEdit14.Value := 0;
  SpinEdit15.Value := 0;
  SpinEdit20.Value := 0;
  SpinEdit21.Value := 0;
  SpinEdit28.Value := 0;
  SpinEdit30.Value := 0;
  CheckBoxTeleport.Checked:= False;//传送  20080824
  CheckBoxParalysis.Checked:= False;//麻痹
  CheckBoxRevival.Checked:= False;//复活
  CheckBoxMagicShield.Checked:= False;//护身
  CheckBoxUnParalysis.Checked:= False;//防麻痹
end;

procedure TfrmViewList2.LoadSuitItem;
var
  ListItem: TListItem;
  I: Integer;
  SuitItem: pTSuitItem;
begin
  ListView1.Clear;
  if SuitItemList.Count > 0 then begin//20080630
    for I := 0 to SuitItemList.Count - 1 do begin
      SuitItem:=pTSuitItem(SuitItemList.Items[I]);
      if SuitItem <> nil then  begin
        ListItem := ListView1.Items.Add;
        ListItem.Caption := Inttostr(I);
        ListItem.SubItems.Add(SuitItem.Note);
        ListItem.SubItems.Add(IntToStr(SuitItem.ItemCount));
        ListItem.SubItems.Add(SuitItem.Name);
        ListItem.SubItems.Add(IntToStr(SuitItem.MaxHP)+'|'+IntToStr(SuitItem.MaxMP)+'|'+
                              IntToStr(SuitItem.DC)+'|'+IntToStr(SuitItem.MaxDC)+'|'+
                              IntToStr(SuitItem.MC)+'|'+IntToStr(SuitItem.MaxMC)+'|'+
                              IntToStr(SuitItem.SC)+'|'+IntToStr(SuitItem.MaxSC)+'|'+
                              IntToStr(SuitItem.AC)+'|'+IntToStr(SuitItem.MaxAC)+'|'+
                              IntToStr(SuitItem.MAC)+'|'+IntToStr(SuitItem.MaxMAC)+'|'+
                              IntToStr(SuitItem.HitPoint)+'|'+IntToStr(SuitItem.SpeedPoint)+'|'+
                              IntToStr(SuitItem.HealthRecover)+'|'+IntToStr(SuitItem.SpellRecover)+'|'+
                              IntToStr(SuitItem.RiskRate)+'|'+IntToStr(SuitItem.btReserved)+'|'+
                              IntToStr(SuitItem.btReserved1)+'|'+IntToStr(SuitItem.btReserved2)+'|'+
                              IntToStr(SuitItem.btReserved3)+'|'+IntToStr(SuitItem.nEXPRATE)+'|'+
                              IntToStr(SuitItem.nPowerRate)+'|'+IntToStr(SuitItem.nMagicRate)+'|'+
                              IntToStr(SuitItem.nSCRate)+'|'+IntToStr(SuitItem.nACRate)+'|'+
                              IntToStr(SuitItem.nMACRate)+'|'+IntToStr(SuitItem.nAntiMagic)+'|'+
                              IntToStr(SuitItem.nAntiPoison)+'|'+IntToStr(SuitItem.nPoisonRecover));
      end;
    end;
  end;
end;

procedure TfrmViewList2.Open;
begin
  LoadSuitItem;
  LoadGlobalVal;//读取全局变量 20080426
  LoadGlobalAVal;//读取全局字符型变量 20080426
  
  ShowModal;
end;

procedure TfrmViewList2.ListView1Click(Sender: TObject);
var
  SuitItem: pTSuitItem;
  nIndex: Integer;
begin
  nIndex := ListView1.ItemIndex;
  if nIndex < 0 then Exit;
  if (nIndex < 0) and (nIndex >= SuitItemList.Count) then Exit;
  SuitItem := pTSuitItem(SuitItemList.Items[nIndex]);
  Edit2.Text:= SuitItem.Name;
  Edit1.Text:= SuitItem.Note;
  SpinEdtMaxHP.Value := SuitItem.MaxHP;
  SpinEdtMaxMP.Value := SuitItem.MaxMP;
  SpinEdit3.Value := SuitItem.DC;
  SpinEdit4.Value := SuitItem.MaxDC;
  SpinEdit6.Value := SuitItem.MC;
  SpinEdit7.Value := SuitItem.MaxMC;
  SpinEdit9.Value := SuitItem.SC;
  SpinEdit10.Value := SuitItem.MaxSC;
  SpinEdit12.Value := SuitItem.AC;
  SpinEdit13.Value := SuitItem.MaxAC;
  SpinEdit17.Value := SuitItem.MAC;
  SpinEdit16.Value := SuitItem.MaxMAC;
  SpinEdit18.Value := SuitItem.HitPoint;
  SpinEdit19.Value := SuitItem.SpeedPoint;
  SpinEdit23.Value := SuitItem.HealthRecover;
  SpinEdit22.Value := SuitItem.SpellRecover;
  SpinEdit26.Value := SuitItem.RiskRate;
  SpinEdit2.Value := SuitItem.nEXPRATE;
  SpinEdit5.Value := SuitItem.nPowerRate;
  SpinEdit8.Value := SuitItem.nMagicRate;
  SpinEdit11.Value := SuitItem.nSCRate;
  SpinEdit14.Value := SuitItem.nACRate;
  SpinEdit15.Value := SuitItem.nMACRate;
  SpinEdit20.Value := SuitItem.nAntiMagic;
  SpinEdit21.Value := SuitItem.nAntiPoison;
  SpinEdit28.Value := SuitItem.nPoisonRecover;
  SpinEdit30.Value := SuitItem.ItemCount;
  SpinEdit24.Value := SuitItem.btReserved;//吸血(虹吸)
  CheckBoxTeleport.Checked := SuitItem.boTeleport;//传送  20080824
  CheckBoxParalysis.Checked := SuitItem.boParalysis;//麻痹
  CheckBoxRevival.Checked := SuitItem.boRevival;//复活
  CheckBoxMagicShield.Checked := SuitItem.boMagicShield;//护身
  CheckBoxUnParalysis.Checked := SuitItem. boUnParalysis;//防麻痹
  Button2.Enabled := True;
  Button3.Enabled := True;
end;

procedure TfrmViewList2.Button1Click(Sender: TObject);
var
  SuitItem: pTSuitItem;
begin
  if IsChar(Edit2.text) <= 0 then begin
    Application.MessageBox('套装名字输入不正确,格式:XXX|XXX|！！！', '提示信息', MB_OK + MB_ICONERROR);
    Edit2.SetFocus;
    Exit;
  end;
  New(SuitItem);
  SuitItem.ItemCount := SpinEdit30.Value;
  if Edit1.text <> '' then
    SuitItem.Note := Edit1.text
  else SuitItem.Note := '????';
  SuitItem.Name := Edit2.text;
  SuitItem.MaxHP:= SpinEdtMaxHP.Value;
  SuitItem.MaxMP:= SpinEdtMaxMP.Value;
  SuitItem.DC:= SpinEdit3.Value ;//攻击力
  SuitItem.MaxDC:= SpinEdit4.Value ;
  SuitItem.MC:= SpinEdit6.Value ;//魔法
  SuitItem.MaxMC:= SpinEdit7.Value;
  SuitItem.SC:= SpinEdit9.Value;//道术
  SuitItem.MaxSC:= SpinEdit10.Value;
  SuitItem.AC:= SpinEdit12.Value;//防御
  SuitItem.MaxAC:= SpinEdit13.Value;
  SuitItem.MAC:= SpinEdit17.Value;//魔防
  SuitItem.MaxMAC:= SpinEdit16.Value;
  SuitItem.HitPoint:= SpinEdit18.Value;//精确度
  SuitItem.SpeedPoint:= SpinEdit19.Value;//敏捷度
  SuitItem.HealthRecover:= SpinEdit23.Value; //体力恢复
  SuitItem.SpellRecover:= SpinEdit22.Value; //魔法恢复
  SuitItem.RiskRate:= SpinEdit26.Value; //爆率机率
  SuitItem.btReserved:= SpinEdit24.Value;//吸血(虹吸)
  SuitItem.btReserved1:= SpinEdit25.Value; //保留
  SuitItem.btReserved2:= SpinEdit27.Value; //保留
  SuitItem.btReserved3:= SpinEdit29.Value; //保留
  SuitItem.nEXPRATE:= SpinEdit2.Value;//经验倍数
  SuitItem.nPowerRate:= SpinEdit5.Value;//攻击倍数
  SuitItem.nMagicRate:= SpinEdit8.Value;//魔法倍数
  SuitItem.nSCRate:= SpinEdit11.Value;//道术倍数
  SuitItem.nACRate:= SpinEdit14.Value;//防御倍数
  SuitItem.nMACRate:= SpinEdit15.Value;//魔御倍数
  SuitItem.nAntiMagic:= SpinEdit20.Value; //魔法躲避
  SuitItem.nAntiPoison:= SpinEdit21.Value; //毒物躲避
  SuitItem.nPoisonRecover:= SpinEdit28.Value;//中毒恢复
  SuitItem.boTeleport := CheckBoxTeleport.Checked;//传送  20080824
  SuitItem.boParalysis := CheckBoxParalysis.Checked;//麻痹
  SuitItem.boRevival := CheckBoxRevival.Checked;//复活
  SuitItem.boMagicShield := CheckBoxMagicShield.Checked;//护身
  SuitItem. boUnParalysis := CheckBoxUnParalysis.Checked;//防麻痹
  SuitItemList.Add(SuitItem);
  LoadSuitItem;
  Button4.Enabled:= True;
end;

procedure TfrmViewList2.Button3Click(Sender: TObject);
var
  nIndex: Integer;
  SuitItem: pTSuitItem;
begin
  nIndex := ListView1.ItemIndex;
  if nIndex < 0 then Exit;

  if IsChar(Edit2.text) <= 0 then begin
    Application.MessageBox('套装名字输入不正确,格式:XXX|XXX|！！！', '提示信息', MB_OK + MB_ICONERROR);
    Edit2.SetFocus;
    Exit;
  end;

  if (nIndex < 0) and (nIndex >= SuitItemList.Count) then Exit;
  SuitItem := pTSuitItem(SuitItemList.Items[nIndex]);
  SuitItem.ItemCount := SpinEdit30.Value;
  SuitItem.Note := Edit1.text;
  SuitItem.Name := Edit2.text;
  SuitItem.MaxHP:= SpinEdtMaxHP.Value;
  SuitItem.MaxMP:= SpinEdtMaxMP.Value;
  SuitItem.DC:= SpinEdit3.Value ;//攻击力
  SuitItem.MaxDC:= SpinEdit4.Value;
  SuitItem.MC:= SpinEdit6.Value ;//魔法
  SuitItem.MaxMC:= SpinEdit7.Value;
  SuitItem.SC:= SpinEdit9.Value;//道术
  SuitItem.MaxSC:= SpinEdit10.Value;
  SuitItem.MaxAC:= SpinEdit13.Value;//防御
  SuitItem.AC:= SpinEdit12.Value;
  SuitItem.MaxMAC:= SpinEdit16.Value;//魔防
  SuitItem.MAC:= SpinEdit17.Value;
  SuitItem.HitPoint:= SpinEdit18.Value;//精确度
  SuitItem.SpeedPoint:= SpinEdit19.Value;//敏捷度
  SuitItem.HealthRecover:= SpinEdit23.Value; //体力恢复
  SuitItem.SpellRecover:= SpinEdit22.Value; //魔法恢复
  SuitItem.RiskRate:= SpinEdit26.Value; //爆率机率
  SuitItem.btReserved:= SpinEdit24.Value;//吸血(虹吸)
  SuitItem.btReserved1:= SpinEdit25.Value; //保留
  SuitItem.btReserved2:= SpinEdit27.Value; //保留
  SuitItem.btReserved3:= SpinEdit29.Value; //保留
  SuitItem.nEXPRATE:= SpinEdit2.Value;//经验倍数
  SuitItem.nPowerRate:= SpinEdit5.Value;//攻击倍数
  SuitItem.nMagicRate:= SpinEdit8.Value;//魔法倍数
  SuitItem.nSCRate:= SpinEdit11.Value;//道术倍数
  SuitItem.nACRate:= SpinEdit14.Value;//防御倍数
  SuitItem.nMACRate:= SpinEdit15.Value;//魔御倍数
  SuitItem.nAntiMagic:= SpinEdit20.Value; //魔法躲避
  SuitItem.nAntiPoison:= SpinEdit21.Value; //毒物躲避
  SuitItem.nPoisonRecover:= SpinEdit28.Value;//中毒恢复
  SuitItem.boTeleport := CheckBoxTeleport.Checked;//传送  20080824
  SuitItem.boParalysis := CheckBoxParalysis.Checked;//麻痹
  SuitItem.boRevival := CheckBoxRevival.Checked;//复活
  SuitItem.boMagicShield := CheckBoxMagicShield.Checked;//护身
  SuitItem. boUnParalysis := CheckBoxUnParalysis.Checked;//防麻痹  
  LoadSuitItem;
  ClearEdt;
  Button4.Enabled:= True;
  Button2.Enabled:= False;
  Button3.Enabled:= False;
end;

procedure TfrmViewList2.Button2Click(Sender: TObject);
var
  nIndex: Integer;
begin
  nIndex := ListView1.ItemIndex;
  if nIndex < 0 then Exit;
  if (nIndex < 0) and (nIndex >= SuitItemList.Count) then Exit;
  Dispose(pTSuitItem(SuitItemList.Items[nIndex]));
  SuitItemList.Delete(nIndex);
  LoadSuitItem;
  ClearEdt;
  Button4.Enabled:= True;
  Button2.Enabled:= False;
  Button3.Enabled:= False;
end;

procedure TfrmViewList2.Button4Click(Sender: TObject);
var
  I: Integer;
  sFileName: string;
  SaveList: TStringList;
  SuitItem: pTSuitItem;
begin
  sFileName := g_Config.sEnvirDir + 'SuitItemList.txt';
  SaveList := TStringList.Create;
  if SuitItemList.Count > 0 then begin//20080630
    for I := 0 to SuitItemList.Count - 1 do begin
      SuitItem := pTSuitItem(SuitItemList.Items[I]);
      SaveList.Add(IntTostr(SuitItem.ItemCount)+' '+SuitItem.Note+' '+SuitItem.Name+' '+
                   IntTostr(SuitItem.MaxHP)+' '+IntTostr(SuitItem.MaxMP)+' '+
                   IntToStr(SuitItem.DC)+' '+IntToStr(SuitItem.MaxDC)+' '+
                   IntToStr(SuitItem.MC)+' '+IntToStr(SuitItem.MaxMC)+' '+
                   IntToStr(SuitItem.SC)+' '+IntToStr(SuitItem.MaxSC)+' '+
                   IntToStr(SuitItem.AC)+' '+IntToStr(SuitItem.MaxAC)+' '+
                   IntToStr(SuitItem.MAC)+' '+IntToStr(SuitItem.MaxMAC)+' '+
                   IntToStr(SuitItem.HitPoint)+' '+IntToStr(SuitItem.SpeedPoint)+' '+
                   IntToStr(SuitItem.HealthRecover)+' '+IntToStr(SuitItem.SpellRecover)+' '+
                   IntToStr(SuitItem.RiskRate)+' '+IntToStr(SuitItem.btReserved)+' '+
                   IntToStr(SuitItem.btReserved1)+' '+IntToStr(SuitItem.btReserved2)+' '+
                   IntToStr(SuitItem.btReserved3)+' '+IntToStr(SuitItem.nEXPRATE)+' '+
                   IntToStr(SuitItem.nPowerRate)+' '+IntToStr(SuitItem.nMagicRate)+' '+
                   IntToStr(SuitItem.nSCRate)+' '+IntToStr(SuitItem.nACRate)+' '+
                   IntToStr(SuitItem.nMACRate)+' '+IntToStr(SuitItem.nAntiMagic)+' '+
                   IntToStr(SuitItem.nAntiPoison)+' '+IntToStr(SuitItem.nPoisonRecover)+' '+
                   BoolToIntStr(SuitItem.boTeleport)+' '+BoolToIntStr(SuitItem.boParalysis)+' '+
                   BoolToIntStr(SuitItem.boRevival)+' '+BoolToIntStr(SuitItem.boMagicShield)+' '+
                   BoolToIntStr(SuitItem.boUnParalysis));
    end;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;//20080529
  Button2.Enabled:= False;
  Button3.Enabled:= False;
  Button4.Enabled:= False;
  Button7.Enabled:= True;
end;
//读取全局数值变量 20080426
procedure TfrmViewList2.LoadGlobalVal;
var
  ListItem: TListItem;
  I:integer;
begin
  ListView2.Items.BeginUpdate;
  try
    for I := Low(g_Config.GlobalVal) to High(g_Config.GlobalVal) do begin
      ListItem := ListView2.Items.Add;
      ListItem.Caption := Inttostr(I);
      ListItem.SubItems.Add(Inttostr(g_Config.GlobalVal[I]));
    end;
  finally
    ListView2.Items.EndUpdate;
  end;
end;

//读取全局字符型变量 20080426
procedure TfrmViewList2.LoadGlobalAVal;
var
  ListItem: TListItem;
  I:integer;
begin
  ListView3.Items.BeginUpdate;
  try
    for I := Low(g_Config.GlobalAVal) to High(g_Config.GlobalAVal) do begin
      ListItem := ListView3.Items.Add;
      ListItem.Caption := Inttostr(I);
      ListItem.SubItems.Add(g_Config.GlobalAVal[I]);
    end;
  finally
    ListView3.Items.EndUpdate;
  end;
end;

procedure TfrmViewList2.ListView2DblClick(Sender: TObject);
  function IsNum(str:string):boolean;
  var
     i:integer;
  begin
     for i:=1 to length(str) do
       if not (str[i] in ['0'..'9']) then
       begin
         result:=false;
         exit;
       end;
     result:=true;
  end;
var
  ListItem: TListItem;
  str :string;
begin
  ListItem := ListView2.Selected;
  str := InputBox('设置变量','数值变量',ListItem.SubItems.Strings[0]);
  if IsNum(str) then begin
    ListItem.SubItems.Strings[0] := str;
    g_Config.GlobalVal[ListItem.Index]:=StrToInt(Str);
  end;
end;


procedure TfrmViewList2.ListView3DblClick(Sender: TObject);
var
  ListItem: TListItem;
  str :string;
begin
  ListItem := ListView3.Selected;
  str := InputBox('设置变量','字符变量',ListItem.SubItems.Strings[0]);
  ListItem.SubItems.Strings[0] := str;
  g_Config.GlobalAVal[ListItem.Index]:=Str;
end;

procedure TfrmViewList2.Button5Click(Sender: TObject);
var
  I:integer;
begin
  if Application.MessageBox(Pchar('是否真的要清空所有数值变量的值?'),'提示信息',MB_ICONQUESTION+MB_YESNO)=IDYES then Begin
    Try
      for I := Low(g_Config.GlobalVal) to High(g_Config.GlobalVal) do begin
        g_Config.GlobalVal[I]:= 0;
        Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(I), g_Config.GlobalVal[I]); //保存系统变量
      end;
      ListView2.Clear;
      LoadGlobalVal;
    except
      MainOutMessage('{异常} TfrmViewList2.Button5Click');
    end;
  end;
end;

procedure TfrmViewList2.Button6Click(Sender: TObject);
var
  I:integer;
begin
  if Application.MessageBox(Pchar('是否真的要清空所有字符变量的值?'),'提示信息',MB_ICONQUESTION+MB_YESNO)=IDYES then Begin
    Try
      for I := Low(g_Config.GlobalAVal) to High(g_Config.GlobalAVal) do begin
        g_Config.GlobalAVal[I]:= '';
        Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(I), g_Config.GlobalAVal[I]);//保存系统变量
      end;
      ListView3.Clear;
      LoadGlobalAVal;
    except
      MainOutMessage('{异常} TfrmViewList2.Button6Click');
    end;
  end;
end;

procedure TfrmViewList2.Button7Click(Sender: TObject);
begin
  FrmDB.LoadSuitItemList();//读取套装装备数据 20080506
  Button7.Enabled:= False;
end;

procedure TfrmViewList2.TabSheet3Show(Sender: TObject);
begin
  LoadRefineItem;//读取粹练配置
end;

//读取粹练配置
procedure TfrmViewList2.LoadRefineItem;
var
  I:integer;
begin
 if g_RefineItemList.Count > 0 then begin
   RefineItemListBox.Clear;
   if g_RefineItemList.Count > 0 then begin//20080630
     for I:= 0 to g_RefineItemList.Count -1 do begin
       RefineItemListBox.Items.Add(g_RefineItemList.Strings[I]);
     end;
   end;
 end;
end;

//取淬练列表物品的名称
procedure GetBackRefineItemName(ItmeStr:string ;var sItemName, sItemName1, sItemName2: string);
var
  str: String;
begin
  str:= ItmeStr;
  if str <> '' then begin
    str := GetValidStr3(str, sItemName,  ['+']);
    str := GetValidStr3(str, sItemName1, ['+']);
    str := GetValidStr3(str, sItemName2, ['+']);
  end;
end;

//判断增加,修改的材料名称是否重复
function IsRefineItemInfo(sItemName,sItemName1,sItemName2: string): Boolean;
  function InStr(Str,sItemName, sItemName1, sItemName2: string):Boolean;
  begin
    Result := False;
    if length(Str)= length(sItemName+'+'+sItemName1+'+'+sItemName2) then begin
      if pos(sItemName,Str) > 0 then begin
        Str:= copy(Str,0,pos(sItemName,Str))+ copy(Str,pos(sItemName,Str)+length(sItemName),length(str));
        if pos(sItemName1,Str) > 0 then begin
          Str:= copy(Str,0,pos(sItemName1,Str))+ copy(Str,pos(sItemName1,Str)+length(sItemName1),length(str));
          if pos(sItemName2,Str) > 0 then  Result := True;
        end;
      end;
    end;
  end;
var
  I: Integer;
  Str: String;
begin
  Result := True;
  if g_RefineItemList.Count > 0 then begin//20080630
    for I := 0 to g_RefineItemList.Count - 1 do begin
      Str:= g_RefineItemList.Strings[I];
      if InStr(Str,sItemName, sItemName1, sItemName2) then begin
        Result := False;
        Break;
      end;
    end;
  end;
end;
//保存粹练配置
procedure TfrmViewList2.SaveRefineItemInfo;
var
  I,K,J:Integer;
  ItemList:TList;
  sFileName,str ,str1 : string;
  SaveList: TStringList;
  TRefineItemInfo:pTRefineItemInfo;
begin
  sFileName := g_Config.sEnvirDir +'RefineItem.txt';
  SaveList := TStringList.Create();
  SaveList.Add(';配置文件');
  SaveList.Add(';淬炼后的物品 淬炼成功几率 失败还原几率 火云石是否消失 淬炼极品属性几率 淬炼极品属性设置');
  SaveList.Add(';[火云石碎片+魔龙冰晶+弩牌]');
  SaveList.Add(';光芒项链 60 0 0 1 2-6,2-6,0-5,0-5,4-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,0-5,');
  if g_RefineItemList.Count > 0 then begin//20080630
    for I := 0 to g_RefineItemList.Count - 1 do begin
      SaveList.Add('['+g_RefineItemList.Strings[I]+']');
      ItemList := TList(g_RefineItemList.Objects[I]);
      if ItemList.Count > 0 then begin
         for K := 0 to ItemList.Count - 1 do begin
           TRefineItemInfo:=pTRefineItemInfo(ItemList.Items[K]);
           str:=TRefineItemInfo.sItemName+' '+inttostr(TRefineItemInfo.nRefineRate)+' '+
                inttostr(TRefineItemInfo.nReductionRate)+' '+BoolTostr(TRefineItemInfo.boDisappear)+' '+ inttostr(TRefineItemInfo.nNeedRate);
           str1:='';
           for J:=0 to 13 do begin
             if str1 <> '' then str1:=str1+',';
             str1:=str1+inttostr(TRefineItemInfo.nAttribute[J].nPoints)+'-'+ inttostr(TRefineItemInfo.nAttribute[J].nDifficult);
           end;
           str:=str+' '+str1;
           SaveList.Add(str);
         end;
      end;
    end;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
end;

procedure TfrmViewList2.RefineItemListBoxDblClick(Sender: TObject);
var str,str1:string;
    ItemList:TList;
    I, K:integer;
    TRefineItemInfo:pTRefineItemInfo;
    ListItem: TListItem;
    str2,str3,str4:string;
begin
if RefineItemListBox.ItemIndex >=0 then begin
  ListView4.Clear;
  str:= RefineItemListBox.Items.Strings[RefineItemListBox.ItemIndex];//取得材料名称:火云石+黑铁头盔+雷霆战戒
  Label78.Caption := Str;
  GetBackRefineItemName(str,str2,str3,str4);
  Edit3.text:=Str2;
  Edit4.text:=Str3;
  Edit5.text:=Str4;
  Button9.Enabled:= True;
  Button10.Enabled:= True;
  ItemList:= nil;//20080522
  if g_RefineItemList.Count > 0 then begin//20080630
    for I := 0 to g_RefineItemList.Count - 1 do begin
      if CompareText(g_RefineItemList.Strings[I],str)=0 then begin
        ItemList := TList(g_RefineItemList.Objects[I]);
        Break;
      end;
    end;
  end;
  if ItemList <> nil then begin
    if ItemList.Count > 0 then begin
      for I := 0 to ItemList.Count - 1 do begin
        TRefineItemInfo:=pTRefineItemInfo(ItemList.Items[I]);
        ListView4.Items.BeginUpdate;
        try
          ListItem := ListView4.Items.Add;
          ListItem.Caption := TRefineItemInfo.sItemName;
          ListItem.SubItems.Add(inttostr(TRefineItemInfo.nRefineRate));
          ListItem.SubItems.Add(inttostr(TRefineItemInfo.nReductionRate));
          if TRefineItemInfo.boDisappear then
            ListItem.SubItems.Add(inttostr(0))
          else  ListItem.SubItems.Add(inttostr(1));
          ListItem.SubItems.Add(inttostr(TRefineItemInfo.nNeedRate));
          str1:='';
          for K:=0 to 13 do begin
            if str1 <> '' then str1:=str1+',';
            str1:=str1+inttostr(TRefineItemInfo.nAttribute[K].nPoints)+'-'+ inttostr(TRefineItemInfo.nAttribute[K].nDifficult);
          end;
          ListItem.SubItems.Add(Str1);
        finally
          ListView4.Items.EndUpdate;
        end;
      end;
    end;
  end;
end;
end;
//增加粹练材料
procedure TfrmViewList2.Button8Click(Sender: TObject);
var List28: TList;
begin
  if IsRefineItemInfo(Trim(Edit3.text),Trim(Edit4.text),Trim(Edit5.text)) then begin
     List28 := TList.Create;
     if List28 <> nil then begin
       g_RefineItemList.AddObject(Trim(Edit3.text)+'+'+Trim(Edit4.text)+'+'+Trim(Edit5.text), List28);
       RefineItemListBox.Items.Add(Trim(Edit3.text)+'+'+Trim(Edit4.text)+'+'+Trim(Edit5.text));
       Button11.Enabled:=True;
       Edit3.Text:='';
       Edit4.Text:='';
       Edit5.Text:='';
       Label78.Caption := '';
     end;
  end else Application.MessageBox('此物品粹练配方已存在！' ,'提示信息',MB_ICONQUESTION+MB_OK);
end;
//修改粹练材料
procedure TfrmViewList2.Button9Click(Sender: TObject);
begin
  if RefineItemListBox.ItemIndex >= 0 then begin
    if IsRefineItemInfo(Trim(Edit3.text),Trim(Edit4.text),Trim(Edit5.text)) then begin
      g_RefineItemList.Strings[RefineItemListBox.ItemIndex]:=Trim(Edit3.text)+'+'+Trim(Edit4.text)+'+'+Trim(Edit5.text);
      Button11.Enabled:=True;
      Button10.Enabled:=False;
      Edit3.Text:='';
      Edit4.Text:='';
      Edit5.Text:='';
      Label78.Caption := '';
      LoadRefineItem;//读取粹练配置
    end  else Application.MessageBox('此物品粹练配方已存在！' ,'提示信息',MB_ICONQUESTION+MB_OK);
  end;
end;

procedure TfrmViewList2.Button10Click(Sender: TObject);
begin
  if RefineItemListBox.ItemIndex >= 0 then begin
    g_RefineItemList.Delete(RefineItemListBox.ItemIndex);
    Button9.Enabled:=False;
    Button11.Enabled:=True;
    Edit3.Text:='';
    Edit4.Text:='';
    Edit5.Text:='';
    Label78.Caption := '';
    RefineItemListBox.DeleteSelected;
  end;  
end;

procedure TfrmViewList2.Button11Click(Sender: TObject);
begin
  SaveRefineItemInfo;
  Button9.Enabled:=False;
  Button10.Enabled:=False;
  Button11.Enabled:=False;
  Edit3.Text:='';
  Edit4.Text:='';
  Edit5.Text:='';
  Label78.Caption := '';
end;

procedure TfrmViewList2.ListView4Click(Sender: TObject);
var
  ListItem: TListItem;
  s18: String;
  n1,n11,n2,n22,n3,n33,n4,n44,n5,n55,n6,n66,n7,n77,n8,n88,n9,n99,nA,nAA,nB,nBB,nC,nCC,nD,nDD,nE,nEE: string;
begin
  if ListView4.ItemIndex >= 0 then begin
    ListItem := ListView4.Items.Item[ListView4.ItemIndex];
    Edit6.text:= ListItem.Caption;
    SpinEdit1.Value := Str_ToInt(ListItem.SubItems.Strings[0], 0);
    SpinEdit31.Value := Str_ToInt(ListItem.SubItems.Strings[1], 0);
    SpinEdit32.Value := Str_ToInt(ListItem.SubItems.Strings[2], 0);
    SpinEdit33.Value := Str_ToInt(ListItem.SubItems.Strings[3], 0);
    s18 := ListItem.SubItems.Strings[4];

    s18 := GetValidStr3(s18, n1,  ['-',',', #9]);//各属性值及难度
    s18 := GetValidStr3(s18, n11, ['-',',', #9]);
    s18 := GetValidStr3(s18, n2,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n22, ['-',',', #9]);
    s18 := GetValidStr3(s18, n3,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n33, ['-',',', #9]);
    s18 := GetValidStr3(s18, n4,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n44, ['-',',', #9]);
    s18 := GetValidStr3(s18, n5,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n55, ['-',',', #9]);
    s18 := GetValidStr3(s18, n6,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n66, ['-',',', #9]);
    s18 := GetValidStr3(s18, n7,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n77, ['-',',', #9]);
    s18 := GetValidStr3(s18, n8,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n88, ['-',',', #9]);
    s18 := GetValidStr3(s18, n9,  ['-',',', #9]);
    s18 := GetValidStr3(s18, n99, ['-',',', #9]);
    s18 := GetValidStr3(s18, nA,  ['-',',', #9]);
    s18 := GetValidStr3(s18, nAA, ['-',',', #9]);
    s18 := GetValidStr3(s18, nB,  ['-',',', #9]);
    s18 := GetValidStr3(s18, nBB, ['-',',', #9]);
    s18 := GetValidStr3(s18, nC,  ['-',',', #9]);
    s18 := GetValidStr3(s18, nCC, ['-',',', #9]);
    s18 := GetValidStr3(s18, nD,  ['-',',', #9]);
    s18 := GetValidStr3(s18, nDD, ['-',',', #9]);
    s18 := GetValidStr3(s18, nE,  ['-',',', #9]);
    s18 := GetValidStr3(s18, nEE, ['-',',', #9]);

    SpinEdit34.Value:= Str_ToInt(Trim(n1), 0);
    SpinEdit35.Value:= Str_ToInt(Trim(n11), 0);
    SpinEdit36.Value:=Str_ToInt(Trim(n2), 0);
    SpinEdit49.Value:=Str_ToInt(Trim(n22), 0);
    SpinEdit37.Value:=Str_ToInt(Trim(n3), 0);
    SpinEdit50.Value:=Str_ToInt(Trim(n33), 0);
    SpinEdit38.Value:=Str_ToInt(Trim(n4), 0);
    SpinEdit51.Value:=Str_ToInt(Trim(n44), 0);
    SpinEdit40.Value:=Str_ToInt(Trim(n5), 0);
    SpinEdit52.Value:=Str_ToInt(Trim(n55), 0);
    SpinEdit41.Value:=Str_ToInt(Trim(n6), 0);
    SpinEdit53.Value:=Str_ToInt(Trim(n66), 0);
    SpinEdit42.Value:=Str_ToInt(Trim(n7), 0);
    SpinEdit54.Value:=Str_ToInt(Trim(n77), 0);
    SpinEdit39.Value:=Str_ToInt(Trim(n8), 0);
    SpinEdit55.Value:=Str_ToInt(Trim(n88), 0);
    SpinEdit43.Value:=Str_ToInt(Trim(n9), 0);
    SpinEdit56.Value:=Str_ToInt(Trim(n99), 0);
    SpinEdit44.Value:=Str_ToInt(Trim(nA), 0);
    SpinEdit57.Value:=Str_ToInt(Trim(nAA), 0);
    SpinEdit45.Value:=Str_ToInt(Trim(nB), 0);
    SpinEdit58.Value:=Str_ToInt(Trim(nBB), 0);
    SpinEdit46.Value:=Str_ToInt(Trim(nC), 0);
    SpinEdit59.Value:=Str_ToInt(Trim(nCC), 0);
    SpinEdit47.Value:=Str_ToInt(Trim(nD), 0);
    SpinEdit60.Value:=Str_ToInt(Trim(nDD), 0);
    SpinEdit48.Value:=Str_ToInt(Trim(nE), 0);
    SpinEdit61.Value:=Str_ToInt(Trim(nEE), 0);
    Button13.Enabled:=True;
    Button14.Enabled:=True;
  end;
end;

procedure TfrmViewList2.ClearEdt1;
begin
  Edit6.Text:= '';
  SpinEdit1.Value := 0;
  SpinEdit31.Value := 0;
  SpinEdit32.Value := 0;
  SpinEdit33.Value := 0;
  SpinEdit34.Value:= 0;
  SpinEdit35.Value:= 0;
  SpinEdit36.Value:=0;
  SpinEdit49.Value:=0;
  SpinEdit37.Value:=0;
  SpinEdit50.Value:=0;
  SpinEdit38.Value:=0;
  SpinEdit51.Value:=0;
  SpinEdit40.Value:=0;
  SpinEdit52.Value:=0;
  SpinEdit41.Value:=0;
  SpinEdit53.Value:=0;
  SpinEdit42.Value:=0;
  SpinEdit54.Value:=0;
  SpinEdit39.Value:=0;
  SpinEdit55.Value:=0;
  SpinEdit43.Value:=0;
  SpinEdit56.Value:=0;
  SpinEdit44.Value:=0;
  SpinEdit57.Value:=0;
  SpinEdit45.Value:=0;
  SpinEdit58.Value:=0;
  SpinEdit46.Value:=0;
  SpinEdit59.Value:=0;
  SpinEdit47.Value:=0;
  SpinEdit60.Value:=0;
  SpinEdit48.Value:=0;
  SpinEdit61.Value:=0;
end;

procedure TfrmViewList2.Button12Click(Sender: TObject);
var
  I, k:Integer;
  ItemList:TList;
  sItemName, sItemName1, sItemName2: string;
  TRefineItemInfo:pTRefineItemInfo;
  boAdd:boolean;
  str1:string;
  ListItem: TListItem;
begin
  if Label78.Caption <> '' then begin
    boAdd:= True;
    GetBackRefineItemName(Label78.Caption,sItemName, sItemName1, sItemName2);
    ItemList:=GetRefineItemInfo(sItemName,sItemName1,sItemName2);
    if ItemList.Count > 0 then begin//20080630
      for I:=0 to ItemList.Count-1 do begin
         TRefineItemInfo:=pTRefineItemInfo(ItemList.Items[I]);
         if CompareText(Trim(Edit6.text),TRefineItemInfo.sItemName)= 0 then begin
           boAdd:= False;//不能存在同名物品
           Break;
         end;
      end;
    end;
    if boAdd then begin
      New(TRefineItemInfo);
      TRefineItemInfo.sItemName:= Trim(Edit6.text);
      TRefineItemInfo.nRefineRate:= SpinEdit1.Value;
      TRefineItemInfo.nReductionRate:= SpinEdit31.Value;
      TRefineItemInfo.boDisappear:= SpinEdit32.Value = 0;//0-减持久 1-消失
      TRefineItemInfo.nNeedRate:= SpinEdit33.Value;
      TRefineItemInfo.nAttribute[0].nPoints:= SpinEdit34.Value;;
      TRefineItemInfo.nAttribute[0].nDifficult:= SpinEdit35.Value;
      TRefineItemInfo.nAttribute[1].nPoints:= SpinEdit36.Value;;
      TRefineItemInfo.nAttribute[1].nDifficult:= SpinEdit49.Value;
      TRefineItemInfo.nAttribute[2].nPoints:= SpinEdit37.Value;
      TRefineItemInfo.nAttribute[2].nDifficult:= SpinEdit50.Value;
      TRefineItemInfo.nAttribute[3].nPoints:= SpinEdit38.Value;
      TRefineItemInfo.nAttribute[3].nDifficult:= SpinEdit51.Value;
      TRefineItemInfo.nAttribute[4].nPoints:= SpinEdit40.Value;
      TRefineItemInfo.nAttribute[4].nDifficult:= SpinEdit52.Value;
      TRefineItemInfo.nAttribute[5].nPoints:= SpinEdit41.Value;
      TRefineItemInfo.nAttribute[5].nDifficult:= SpinEdit53.Value;
      TRefineItemInfo.nAttribute[6].nPoints:= SpinEdit42.Value;
      TRefineItemInfo.nAttribute[6].nDifficult:= SpinEdit54.Value;
      TRefineItemInfo.nAttribute[7].nPoints:= SpinEdit39.Value;
      TRefineItemInfo.nAttribute[7].nDifficult:= SpinEdit55.Value;
      TRefineItemInfo.nAttribute[8].nPoints:= SpinEdit43.Value;
      TRefineItemInfo.nAttribute[8].nDifficult:= SpinEdit56.Value;
      TRefineItemInfo.nAttribute[9].nPoints:= SpinEdit44.Value;
      TRefineItemInfo.nAttribute[9].nDifficult:= SpinEdit57.Value;
      TRefineItemInfo.nAttribute[10].nPoints:= SpinEdit45.Value;
      TRefineItemInfo.nAttribute[10].nDifficult:= SpinEdit58.Value;
      TRefineItemInfo.nAttribute[11].nPoints:= SpinEdit46.Value;
      TRefineItemInfo.nAttribute[11].nDifficult:= SpinEdit59.Value;
      TRefineItemInfo.nAttribute[12].nPoints:= SpinEdit47.Value;
      TRefineItemInfo.nAttribute[12].nDifficult:= SpinEdit60.Value;
      TRefineItemInfo.nAttribute[13].nPoints:= SpinEdit48.Value;
      TRefineItemInfo.nAttribute[13].nDifficult:= SpinEdit61.Value;
      ItemList.Add(TRefineItemInfo);

      ListView4.Items.BeginUpdate;
      try
        ListItem := ListView4.Items.Add;
        ListItem.Caption := TRefineItemInfo.sItemName;
        ListItem.SubItems.Add(inttostr(TRefineItemInfo.nRefineRate));
        ListItem.SubItems.Add(inttostr(TRefineItemInfo.nReductionRate));
        if TRefineItemInfo.boDisappear then
          ListItem.SubItems.Add(inttostr(0))
        else  ListItem.SubItems.Add(inttostr(1));
        ListItem.SubItems.Add(inttostr(TRefineItemInfo.nNeedRate));
        str1:='';
        for K:=0 to 13 do begin
          if str1 <> '' then str1:=str1+',';
          str1:=str1+inttostr(TRefineItemInfo.nAttribute[K].nPoints)+'-'+ inttostr(TRefineItemInfo.nAttribute[K].nDifficult);
        end;
        ListItem.SubItems.Add(Str1);
      finally
        ListView4.Items.EndUpdate;
      end;

      Button13.Enabled:=False;
      Button14.Enabled:=False;
      Button15.Enabled:=True;
      ClearEdt1;
    end else  Application.MessageBox('该配方已存在此物品,不能再重复增加！' ,'提示信息',MB_ICONQUESTION+MB_OK);
  end else Application.MessageBox('请从粹练材料列表中选择要增加物品的配方名！' ,'提示信息',MB_ICONQUESTION+MB_OK);
end;

procedure TfrmViewList2.Button13Click(Sender: TObject);
var
  I, K:Integer;
  ItemList:TList;
  sItemName, sItemName1, sItemName2: string;
  TRefineItemInfo:pTRefineItemInfo;
  str,str1:string;
  ListItem: TListItem;
begin
if ListView4.ItemIndex >= 0 then begin
  if Label78.Caption <> '' then begin
  str:= ListView4.Items[ListView4.ItemIndex].Caption;//物品名称
  if (str <> '') then begin
    GetBackRefineItemName(Label78.Caption ,sItemName, sItemName1, sItemName2);
    ItemList:=GetRefineItemInfo(sItemName,sItemName1,sItemName2);
    if ItemList.Count > 0 then begin
      for I := 0 to ItemList.Count - 1 do begin
         TRefineItemInfo:=pTRefineItemInfo(ItemList.Items[I]);
         if CompareText(str,TRefineItemInfo.sItemName)= 0 then begin
            TRefineItemInfo.nRefineRate:= SpinEdit1.Value;
            TRefineItemInfo.nReductionRate:= SpinEdit31.Value;
            TRefineItemInfo.boDisappear:= SpinEdit32.Value = 0;//0-减持久 1-消失
            TRefineItemInfo.nNeedRate:= SpinEdit33.Value;
            TRefineItemInfo.nAttribute[0].nPoints:= SpinEdit34.Value;;
            TRefineItemInfo.nAttribute[0].nDifficult:= SpinEdit35.Value;
            TRefineItemInfo.nAttribute[1].nPoints:= SpinEdit36.Value;;
            TRefineItemInfo.nAttribute[1].nDifficult:= SpinEdit49.Value;
            TRefineItemInfo.nAttribute[2].nPoints:= SpinEdit37.Value;
            TRefineItemInfo.nAttribute[2].nDifficult:= SpinEdit50.Value;
            TRefineItemInfo.nAttribute[3].nPoints:= SpinEdit38.Value;
            TRefineItemInfo.nAttribute[3].nDifficult:= SpinEdit51.Value;
            TRefineItemInfo.nAttribute[4].nPoints:= SpinEdit40.Value;
            TRefineItemInfo.nAttribute[4].nDifficult:= SpinEdit52.Value;
            TRefineItemInfo.nAttribute[5].nPoints:= SpinEdit41.Value;
            TRefineItemInfo.nAttribute[5].nDifficult:= SpinEdit53.Value;
            TRefineItemInfo.nAttribute[6].nPoints:= SpinEdit42.Value;
            TRefineItemInfo.nAttribute[6].nDifficult:= SpinEdit54.Value;
            TRefineItemInfo.nAttribute[7].nPoints:= SpinEdit39.Value;
            TRefineItemInfo.nAttribute[7].nDifficult:= SpinEdit55.Value;
            TRefineItemInfo.nAttribute[8].nPoints:= SpinEdit43.Value;
            TRefineItemInfo.nAttribute[8].nDifficult:= SpinEdit56.Value;
            TRefineItemInfo.nAttribute[9].nPoints:= SpinEdit44.Value;
            TRefineItemInfo.nAttribute[9].nDifficult:= SpinEdit57.Value;
            TRefineItemInfo.nAttribute[10].nPoints:= SpinEdit45.Value;
            TRefineItemInfo.nAttribute[10].nDifficult:= SpinEdit58.Value;
            TRefineItemInfo.nAttribute[11].nPoints:= SpinEdit46.Value;
            TRefineItemInfo.nAttribute[11].nDifficult:= SpinEdit59.Value;
            TRefineItemInfo.nAttribute[12].nPoints:= SpinEdit47.Value;
            TRefineItemInfo.nAttribute[12].nDifficult:= SpinEdit60.Value;
            TRefineItemInfo.nAttribute[13].nPoints:= SpinEdit48.Value;
            TRefineItemInfo.nAttribute[13].nDifficult:= SpinEdit61.Value;

            ListItem := ListView4.Items.Item[ListView4.ItemIndex];
            ListItem.Caption := TRefineItemInfo.sItemName;
            ListItem.SubItems.Strings[0] :=inttostr(TRefineItemInfo.nRefineRate);
            ListItem.SubItems.Strings[1] :=inttostr(TRefineItemInfo.nReductionRate);
            ListItem.SubItems.Strings[2] :=inttostr(SpinEdit32.Value);
            ListItem.SubItems.Strings[3] :=inttostr(TRefineItemInfo.nNeedRate);
            str1:='';
            for K:=0 to 13 do begin
              if str1 <> '' then str1:=str1+',';
              str1:=str1+inttostr(TRefineItemInfo.nAttribute[K].nPoints)+'-'+ inttostr(TRefineItemInfo.nAttribute[K].nDifficult);
            end;
            ListItem.SubItems.Strings[4] :=Str1;

            Button13.Enabled:=False;
            Button14.Enabled:=False;
            Button15.Enabled:=True;
            ClearEdt1;
            break;
         end;
      end;
    end;
  end;
 end else Application.MessageBox('请从粹练材料列表中选择要修改物品的配方名！' ,'提示信息',MB_ICONQUESTION+MB_OK);
end;
end;

procedure TfrmViewList2.Button14Click(Sender: TObject);
var I:Integer;
    ItemList:TList;
    sItemName, sItemName1, sItemName2: string;
    TRefineItemInfo:pTRefineItemInfo;
    str:string;
begin
if ListView4.ItemIndex >= 0 then begin
  if Label78.Caption <> '' then begin
    str:= ListView4.Items[ListView4.ItemIndex].Caption;//物品名称
    ListView4.Items.BeginUpdate;
    try
      ListView4.DeleteSelected;
    finally
      ListView4.Items.EndUpdate;
    end;

    if str <> '' then begin
      GetBackRefineItemName(Label78.Caption ,sItemName, sItemName1, sItemName2);
      ItemList:=GetRefineItemInfo(sItemName,sItemName1,sItemName2);
      if ItemList.Count > 0 then begin
        for I := 0 to ItemList.Count - 1 do begin
           TRefineItemInfo:=pTRefineItemInfo(ItemList.Items[I]);
           if CompareText(str,TRefineItemInfo.sItemName)= 0 then begin
              ItemList.Delete(I);
              Button13.Enabled:=False;
              Button14.Enabled:=False;
              Button15.Enabled:=True;
              ClearEdt1;
              break;
           end;
        end;
      end;
    end;
  end else Application.MessageBox('请从粹练材料列表中选择要删除物品的配方名！' ,'提示信息',MB_ICONQUESTION+MB_OK);
end;
end;

procedure TfrmViewList2.Button15Click(Sender: TObject);
begin
  SaveRefineItemInfo;
  Button13.Enabled:=False;
  Button14.Enabled:=False;
  Button15.Enabled:=False;
end;

//------------------------自定义命令---------------------------------
function TfrmViewList2.InCommandListOfName(sCommandName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ListBoxUserCommand.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
      if CompareText(sCommandName, ListBoxUserCommand.Items.Strings[I]) = 0 then begin
        Result := TRUE;
        break;
      end;
    end;
  end;
end;

function TfrmViewList2.InCommandListOfIndex(nIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ListBoxUserCommand.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
      if nIndex = Integer(ListBoxUserCommand.Items.Objects[I]) then begin
        Result := TRUE;
        break;
      end;
    end;
  end;
end;

procedure TfrmViewList2.ButtonUserCommandAddClick(Sender: TObject);
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

procedure TfrmViewList2.ButtonUserCommandDelClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认删除此命令？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    try
      ListBoxUserCommand.DeleteSelected;
    except
    end;
  end;
end;

procedure TfrmViewList2.ButtonUserCommandChgClick(Sender: TObject);
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

procedure TfrmViewList2.ButtonUserCommandSaveClick(Sender: TObject);
var
  sFileName: string;
  I: Integer;
  sCommandName: string;
  nCommandIndex: Integer;
  SaveList: TStringList;
begin
  ButtonUserCommandSave.Enabled := False;
  sFileName := '.\UserCmd.txt';
  SaveList := TStringList.Create;
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

procedure TfrmViewList2.ButtonLoadUserCommandListClick(Sender: TObject);
begin
  ButtonLoadUserCommandList.Enabled := False;
  LoadUserCmdList();
  ListBoxUserCommand.Items.Clear;
  ListBoxUserCommand.Items.AddStrings(g_UserCmdList);
  Application.MessageBox('重新加载自定义命令列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadUserCommandList.Enabled := TRUE;
end;

procedure TfrmViewList2.TabSheet5Show(Sender: TObject);
begin
  ListBoxUserCommand.Items.Clear;
  ListBoxUserCommand.Items.AddStrings(g_UserCmdList);
end;

procedure TfrmViewList2.ListBoxUserCommandClick(Sender: TObject);
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

//-------------------------禁止物品设置------------------------------
procedure TfrmViewList2.DisallowSelAll(SelAll: Boolean);
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
    CheckBoxDisallowPickUpItem.Checked:= True;
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
    CheckBoxDisallowPickUpItem.Checked:= False;
    CheckBoxDieDropItems.Checked := False;
  end;
end;

procedure TfrmViewList2.RefLoadDisallowStdItems();
var
  I: Integer;
  CheckItem: pTCheckItem;
  sItemName: string;
  DisallowInfo: pTDisallowInfo;
begin
  Try
  if ListBoxDisallow.Items.count > 0 then begin
    for I:= 0 to ListBoxDisallow.Items.count -1 do begin
      Dispose(pTDisallowInfo(ListBoxDisallow.Items.objects[I]));
    end;
    ListBoxDisallow.Items.Clear;
  end;
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
    end;
  end;
  except
    MainOutMessage('{异常} TfrmViewList2.RefLoadDisallowStdItems');
  end;
end;


procedure TfrmViewList2.BtnDisallowSelAllClick(Sender: TObject);
begin
  DisallowSelAll(True);
end;

procedure TfrmViewList2.BtnDisallowCancelAllClick(Sender: TObject);
begin
  DisallowSelAll(False);
end;

procedure TfrmViewList2.ListBoxitemListClick(Sender: TObject);
begin
  try
    EditItemName.Text := ListBoxitemList.Items.Strings[ListBoxitemList.ItemIndex];
    DisallowSelAll(False);
    BtnDisallowAdd.Enabled := True;
    BtnDisallowDel.Enabled := False;
    BtnDisallowChg.Enabled := False;
  except
    EditItemName.Text := '';
    BtnDisallowAdd.Enabled := False;
  end;
end;

procedure TfrmViewList2.ListBoxitemListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  s: string;
  I: Integer;
begin
  if Key = Word('F') then begin
   if ssCtrl in Shift then begin
      s := inputBox('查找物品','请输入要查找的物品名字:','');
      if ListBoxitemList.Count > 0 then begin//20080629
        for I:=0 to ListBoxitemList.Count - 1 do begin
          if CompareText(ListBoxItemList.Items.Strings[I],s) = 0 then begin
             ListBoxItemList.ItemIndex:=I;
             Exit;
          end;
        end;
      end;
   end;
  end;
end;

procedure TfrmViewList2.BtnDisallowAddClick(Sender: TObject);
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
    MainOutMessage('{异常} TfrmViewList2.BtnDisallowAddClick');
  end;
end;

procedure TfrmViewList2.BtnDisallowDelClick(Sender: TObject);
begin
  try
    ListBoxDisallow.DeleteSelected;
    BtnDisallowSave.Enabled := True;
  except
    BtnDisallowSave.Enabled := False;
  end;
end;

procedure TfrmViewList2.BtnDisallowAddAllClick(Sender: TObject);
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
    MainOutMessage('{异常} TfrmViewList2.BtnDisallowAddAllClick');
  end;
end;

procedure TfrmViewList2.BtnDisallowDelAllClick(Sender: TObject);
begin
  ListBoxDisallow.Items.Clear;
  BtnDisallowSave.Enabled := True;
end;

procedure TfrmViewList2.BtnDisallowChgClick(Sender: TObject);
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
  except
    MainOutMessage('{异常} TfrmViewList2.BtnDisallowChgClick');
  end;
end;

procedure TfrmViewList2.BtnDisallowSaveClick(Sender: TObject);
var
  I: Integer;
  SaveList: TStringList;
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
  SaveList := TStringList.Create;
  SaveList.Add(';引擎插件禁止物品配置文件');
  SaveList.Add(';物品名称'#9'丢弃'#9'交易'#9'存仓'#9'修理'#9'掉落提示'#9'开宝箱提示'#9'永不暴出'#9'挖取提示');
  if ListBoxDisallow.Items.Count > 0 then begin//20080629
    for I := 0 to ListBoxDisallow.Items.Count - 1 do begin
      sItemName := ListBoxDisallow.Items.Strings[I];
      sCanDrop := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDrop);
      sCanDeal := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDeal);
      sCanStorage := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boStorage);
      sCanRepair := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boRepair);
      sCanDropHint := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDropHint);
      sCanOpenBoxsHint := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boOpenBoxsHint);
      sCanNoDropItem := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boNoDropItem);
      sCanButchHint := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boButchHint);
      sCanHeroUse := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boHeroUse);
      sCanPickUpItem := BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boPickUpItem);//是否禁止捡起(除GM外) 20080611
      sCanDieDropItems:= BoolToIntStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDieDropItems);//死亡掉落 20080614
    {  sCanDrop := Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDrop));
      sCanDeal := Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDeal));
      sCanStorage := Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boStorage));
      sCanRepair := Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boRepair));
      sCanDropHint := Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDropHint));
      sCanOpenBoxsHint := Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boOpenBoxsHint));
      sCanNoDropItem := Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boNoDropItem));
      sCanButchHint := Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boButchHint));
      sCanHeroUse := Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boHeroUse));
      sCanPickUpItem := Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boPickUpItem));//是否禁止捡起(除GM外) 20080611
      sCanDieDropItems:= Inttostr(Integer(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDieDropItems));//死亡掉落 20080614 }

     { sCanDrop := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDrop);
      sCanDeal := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDeal);
      sCanStorage := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boStorage);
      sCanRepair := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boRepair);
      sCanDropHint := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDropHint);
      sCanOpenBoxsHint := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boOpenBoxsHint);
      sCanNoDropItem := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boNoDropItem);
      sCanButchHint := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boButchHint);
      sCanHeroUse := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boHeroUse);
      sCanPickUpItem := BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boPickUpItem);//是否禁止捡起(除GM外) 20080611
      sCanDieDropItems:= BoolToStr(pTDisallowInfo(ListBoxDisallow.Items.Objects[I]).boDieDropItems);//死亡掉落 20080614 }

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
    MainOutMessage('{异常} TfrmViewList2.BtnDisallowSaveClick');
  end;
end;

procedure TfrmViewList2.TabSheet6Show(Sender: TObject);
var
  I: Integer;
  StdItem: pTStdItem;
begin
  ListBoxitemList.Items.Clear;
  if UserEngine.StdItemList <> nil then begin
    if UserEngine.StdItemList.Count > 0 then begin//20080629
      for I := 0 to UserEngine.StdItemList.Count - 1 do begin
        StdItem:= pTStdItem(UserEngine.StdItemList.Items[I]);
        //ListBoxitemList.Items.AddObject(StdItem.Name, TObject(StdItem));
        ListBoxitemList.Items.Add(StdItem.Name);
      end;
    end;
  end;
  RefLoadDisallowStdItems();
end;

procedure TfrmViewList2.ListBoxDisallowClick(Sender: TObject);
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

procedure TfrmViewList2.CheckBoxDisallowNoDropItemClick(Sender: TObject);
begin
  CheckBoxDieDropItems.Checked := False;
end;

procedure TfrmViewList2.CheckBoxDieDropItemsClick(Sender: TObject);
begin
  CheckBoxDisallowNoDropItem.Checked := False;
end;

procedure TfrmViewList2.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmViewList2.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  I: Integer;
begin
  Try
    if ListBoxDisallow.Items.count > 0 then begin
      for I:= 0 to ListBoxDisallow.Items.count -1 do begin
        Dispose(pTDisallowInfo(ListBoxDisallow.Items.objects[I]));
      end;
    end;
  except
  end;
end;

//--------------------------消息过滤------------------
function TfrmViewList2.InFilterMsgList(sFilterMsg: string): Boolean;
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
    MainOutMessage('{异常} TfrmViewList2.InFilterMsgList');
  end;
end;

procedure TfrmViewList2.RefLoadMsgFilterList();
var
  I: Integer;
  ListItem: TListItem;
  FilterMsg: pTFilterMsg;
begin
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
  except
    MainOutMessage('{异常} TfrmViewList2.RefLoadMsgFilterList');
  end;
end;

procedure TfrmViewList2.ListViewMsgFilterClick(Sender: TObject);
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

procedure TfrmViewList2.ButtonMsgFilterAddClick(Sender: TObject);
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
    EditFilterMsg.Text:= '';
    EditNewMsg.Text:='';
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TfrmViewList2.ButtonMsgFilterDelClick(Sender: TObject);
begin
  try
    ListViewMsgFilter.DeleteSelected;
  except
  end;
end;

procedure TfrmViewList2.ButtonMsgFilterChgClick(Sender: TObject);
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
    EditFilterMsg.Text:= '';
    EditNewMsg.Text:='';    
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TfrmViewList2.ButtonMsgFilterSaveClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: TStringList;
  sFilterMsg: string;
  sNewMsg: string;
  sFileName: string;
begin
Try
  ButtonMsgFilterSave.Enabled := False;
  sFileName := '.\MsgFilterList.txt';
  SaveList := TStringList.Create;
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
    MainOutMessage('{异常} TfrmViewList2.ButtonMsgFilterSaveClick');
  end;
end;

procedure TfrmViewList2.ButtonLoadMsgFilterListClick(Sender: TObject);
begin
  ButtonLoadMsgFilterList.Enabled := False;
  LoadMsgFilterList();
  RefLoadMsgFilterList();
  Application.MessageBox('重新加载消息过滤列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadMsgFilterList.Enabled := TRUE;
end;

procedure TfrmViewList2.TabSheet7Show(Sender: TObject);
begin
  RefLoadMsgFilterList();
end;
//-----------------------------商铺设置-----------------------------------
function TfrmViewList2.InListViewItemList(sItemName: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  ListViewItemList.Items.BeginUpdate;
  try
    for I := 0 to ListViewItemList.Items.Count - 1 do begin
      ListItem := ListViewItemList.Items.Item[I];
      if CompareText(sItemName, ListItem.Caption) = 0 then begin
        Result := True;
        Break;
      end;
    end;
  finally
    ListViewItemList.Items.EndUpdate;
  end;
end;

procedure TfrmViewList2.RefLoadShopItemList();
var
  I: Integer;
  ListItem: TListItem;
  ShopInfo: pTShopInfo;
begin
Try
  ListViewItemList.Clear;
  if g_ShopItemList <> nil then begin
    if g_ShopItemList.Count > 0 then begin//20080629
      for I := 0 to g_ShopItemList.Count - 1 do begin
        ShopInfo := pTShopInfo(g_ShopItemList.Items[I]);
        ListViewItemList.Items.BeginUpdate;
        try
          ListItem := ListViewItemList.Items.Add;
          ListItem.Caption := ShopInfo.StdItem.Name;
          ListItem.SubItems.Add(ShopInfo.Idx);
          ListItem.SubItems.Add(IntToStr(ShopInfo.StdItem.Price div 100));
          ListItem.SubItems.Add(ShopInfo.ImgBegin);
          ListItem.SubItems.Add(ShopInfo.Imgend);
          ListItem.SubItems.Add(ShopInfo.Introduce1);
          ListItem.SubItems.Add(StrPas(@ShopInfo.sIntroduce));
        finally
          ListViewItemList.Items.EndUpdate;
        end;
      end;//for
    end;
    CheckBoxBuyGameGird.Checked :=g_Config.g_boGameGird;//20080808
    SpinEditGameGird.Value := g_Config.g_nGameGold;//20080808
  end;
  except
    MainOutMessage('{异常} TfrmViewList2.RefLoadShopItemList');
  end;
end;

procedure TfrmViewList2.ListViewItemListClick(Sender: TObject);
var
  nItemIndex: Integer;
  ListItem: TListItem;
begin
  try
    nItemIndex := ListViewItemList.ItemIndex;
    ListItem := ListViewItemList.Items.Item[nItemIndex];
    EditShopItemName.Text := ListItem.Caption;
    SpinEditPrice.Value := Str_ToInt(ListItem.SubItems.Strings[1], 0);
    EditShopImgBegin.Text :=ListItem.SubItems.Strings[2];
    EditShopImgEnd.Text :=ListItem.SubItems.Strings[3];
    EditShopItemIntroduce.Text := ListItem.SubItems.Strings[4];
    ShopTypeBoBox.ItemIndex := Str_ToInt(ListItem.SubItems.Strings[0], 0);
    Memo1.Text := ListItem.SubItems.Strings[5];
    ButtonChgShopItem.Enabled := True;
    ButtonDelShopItem.Enabled := True;
  except
    ButtonChgShopItem.Enabled := False;
    ButtonDelShopItem.Enabled := False;
  end;
end;

procedure TfrmViewList2.ListBoxItemListShopClick(Sender: TObject);
begin
  try
    EditShopItemName.Text := ListBoxItemListShop.Items.Strings[ListBoxItemListShop.ItemIndex];
    ButtonAddShopItem.Enabled := True;
    ButtonChgShopItem.Enabled := False;
    ButtonDelShopItem.Enabled := False;
    EditShopItemIntroduce.Text:='';
    Memo1.Text:='';
  except
    ButtonAddShopItem.Enabled := False;
  end;
end;

procedure TfrmViewList2.ListBoxItemListShopKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  s: string;
  I: Integer;
begin
  if Key = Word('F') then begin
   if ssCtrl in Shift then begin
      s := inputBox('查找物品','请输入要查找的物品名字:','');
      for I:=0 to ListBoxItemListShop.Count - 1 do begin
        if CompareText(ListBoxItemListShop.Items.Strings[I],s) = 0 then begin
           ListBoxItemListShop.ItemIndex:=I;
           Exit;
        end;
      end;
   end;
  end;
end;

procedure TfrmViewList2.CheckBoxBuyGameGirdClick(Sender: TObject);
begin
  g_Config.g_boGameGird := CheckBoxBuyGameGird.Checked;
  ButtonSaveShopItemList.Enabled := True;
end;

procedure TfrmViewList2.SpinEditGameGirdChange(Sender: TObject);
begin
  g_Config.g_nGameGold := SpinEditGameGird.Value;
  ButtonSaveShopItemList.Enabled := True;
end;

procedure TfrmViewList2.ButtonDelShopItemClick(Sender: TObject);
begin
  ListViewItemList.Items.BeginUpdate;
  try
    ListViewItemList.DeleteSelected;
    ButtonSaveShopItemList.Enabled:= True;//20080320
  finally
    ListViewItemList.Items.EndUpdate;
  end;
end;

procedure TfrmViewList2.ButtonChgShopItemClick(Sender: TObject);
var
  nItemIndex: Integer;
  ListItem: TListItem;
begin
  try
    nItemIndex := ListViewItemList.ItemIndex;
    ListItem := ListViewItemList.Items.Item[nItemIndex];
    ListItem.SubItems.Strings[0] := IntToStr(ShopTypeBoBox.ItemIndex);
    ListItem.SubItems.Strings[1] := IntToStr(SpinEditPrice.Value);
    ListItem.SubItems.Strings[2] := Trim(EditShopImgBegin.Text);
    ListItem.SubItems.Strings[3] := Trim(EditShopImgEnd.Text);
    ListItem.SubItems.Strings[4] := Trim(EditShopItemIntroduce.Text);
    ListItem.SubItems.Strings[5] := Trim(Memo1.Text);
    ButtonSaveShopItemList.Enabled:= True;
  except
  end;
end;

procedure TfrmViewList2.ButtonAddShopItemClick(Sender: TObject);
var
  ListItem: TListItem;
  sItemName: string;
begin
 Try
  sItemName := Trim(EditShopItemName.Text);
  if sItemName = '' then begin
    Application.MessageBox('请选择你要添加的商品！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if Memo1.Text = '' then begin
    Application.MessageBox('请输入商品描述！！！', '提示信息', MB_ICONQUESTION);
    Memo1.SetFocus;
    Exit;
  end;
  if InListViewItemList(sItemName) then begin
    Application.MessageBox('你要添加的商品已经存在，请选择其他商品！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListViewItemList.Items.BeginUpdate;
  try
    ListItem := ListViewItemList.Items.Add;
    ListItem.SubItems.Add(IntToStr(ShopTypeBoBox.ItemIndex));
    ListItem.Caption := sItemName;
    ListItem.SubItems.Add(IntToStr(SpinEditPrice.Value));
    ListItem.SubItems.Add(Trim(EditShopImgBegin.Text));
    ListItem.SubItems.Add(Trim(EditShopImgEnd.Text));
    ListItem.SubItems.Add(Trim(EditShopItemIntroduce.Text));
    ListItem.SubItems.Add(Trim(Memo1.Text));
    ButtonSaveShopItemList.Enabled:= True;
  finally
    ListViewItemList.Items.EndUpdate;
  end;
  except
    MainOutMessage('{异常} TfrmViewList2.ButtonAddShopItemClick');
  end;
end;

procedure TfrmViewList2.ButtonSaveShopItemListClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: TStringList;

  sIdx      : string;
  sImgBegin : string;
  sImgEnd   : string;
  sIntroduce: string;

  sLineText : string;
  sFileName : string;
  sItemName : string;
  sPrice    : string;
  sMemo     : string;
begin
Try
  sFileName := '.\BuyItemList.txt';
  SaveList := TStringList.Create();
  SaveList.Add(';引擎插件商铺配置文件');
  SaveList.Add(';商品分类'#9'商品名称'#9'出售价格'#9'图片开始'#9'图片结束'#9'简单介绍'#9'商品描述');
  ListViewItemList.Items.BeginUpdate;
  try
    for I := 0 to ListViewItemList.Items.Count - 1 do begin
      ListItem := ListViewItemList.Items.Item[I];
      sIdx := ListItem.SubItems.Strings[0];
      sItemName := ListItem.Caption;
      sPrice := ListItem.SubItems.Strings[1];
      sImgBegin := ListItem.SubItems.Strings[2];
      sImgEnd := ListItem.SubItems.Strings[3];
      sIntroduce := ListItem.SubItems.Strings[4];
      sMemo := ListItem.SubItems.Strings[5];
      sLineText := sIdx + #9 + sItemName + #9 + sPrice + #9 + sImgBegin + #9 + sImgEnd + #9 + sIntroduce + #9 + sMemo;
      SaveList.Add(sLineText);
    end;
  finally
    ListViewItemList.Items.EndUpdate;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonSaveShopItemList.Enabled := False;
{******************************************************************************}
//以下为灵符兑换保存代码 
  Config.WriteBool('Shop','ShopBuyGameGird',g_Config.g_boGameGird);
  Config.WriteInteger('Shop','GameGold',g_Config.g_nGameGold);
{******************************************************************************}
  except
    MainOutMessage('{异常} PlugOfShop.ButtonSaveShopItemListClick');
  end;
end;

procedure TfrmViewList2.ButtonLoadShopItemListClick(Sender: TObject);
begin
  ButtonLoadShopItemList.Enabled := False;
  LoadShopItemList();
  RefLoadShopItemList();
  Application.MessageBox('重新加载商列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadShopItemList.Enabled := True;
end;

procedure TfrmViewList2.TabSheet8Show(Sender: TObject);
var
  I: Integer;
  StdItem: pTStdItem;
begin
  ButtonChgShopItem.Enabled := False;
  ButtonDelShopItem.Enabled := False;
  ButtonAddShopItem.Enabled := False;
  ListBoxItemListShop.Items.Clear;
  if UserEngine.StdItemList <> nil then begin
    if UserEngine.StdItemList.Count > 0 then begin//20080629
      for I := 0 to UserEngine.StdItemList.Count - 1 do begin
        StdItem:= pTStdItem(UserEngine.StdItemList.Items[I]);
        ListBoxItemListShop.Items.Add(StdItem.Name);
      end;
    end;
  end;
  RefLoadShopItemList();
end;

end.

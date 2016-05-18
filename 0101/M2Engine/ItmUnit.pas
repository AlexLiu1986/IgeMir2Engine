unit ItmUnit;

interface
uses
  Windows, Classes, SysUtils, SDK, Grobal2;
type
  TItemUnit = class
  private
    function GetRandomRange(nCount, nRate: Integer): Integer;
  public
    m_ItemNameList: TGList;
    constructor Create();
    destructor Destroy; override;
    procedure GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem);
    procedure RandomUpgradeWeapon(UserItem: pTUserItem);
    procedure RandomUpgradeDress(UserItem: pTUserItem);
    procedure RandomUpgrade19(UserItem: pTUserItem);
    procedure RandomUpgrade202124(UserItem: pTUserItem);
    procedure RandomUpgrade26(UserItem: pTUserItem);
    procedure RandomUpgrade22(UserItem: pTUserItem);
    procedure RandomUpgrade23(UserItem: pTUserItem);
    procedure RandomUpgradeHelMet(UserItem: pTUserItem);
    procedure RandomUpgradeBoots(UserItem: pTUserItem);
    procedure UnknowHelmet(UserItem: pTUserItem);
    procedure UnknowRing(UserItem: pTUserItem);
    procedure UnknowNecklace(UserItem: pTUserItem);
    function LoadCustomItemName(): Boolean;
    function SaveCustomItemName(): Boolean;
    function AddCustomItemName(nMakeIndex, nItemIndex: Integer; sItemName: string): Boolean;
    function DelCustomItemName(nMakeIndex, nItemIndex: Integer): Boolean;
    function GetCustomItemName(nMakeIndex, nItemIndex: Integer): string;
    procedure Lock();
    procedure UnLock();
  end;
implementation

uses HUtil32, M2Share;


{ TItemUnit }


constructor TItemUnit.Create;
begin
  m_ItemNameList := TGList.Create;
end;

destructor TItemUnit.Destroy;
var
  I: Integer;
begin
  if m_ItemNameList.Count > 0 then begin//20080630
    for I := 0 to m_ItemNameList.Count - 1 do begin
      if pTItemName(m_ItemNameList.Items[I]) <> nil then
         Dispose(pTItemName(m_ItemNameList.Items[I]));
    end;
  end;
  m_ItemNameList.Free;
  inherited;
end;

function TItemUnit.GetRandomRange(nCount, nRate: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to nCount - 1 do
    if Random(nRate) = 0 then Inc(Result);
end;

procedure TItemUnit.RandomUpgradeWeapon(UserItem: pTUserItem); //随机升级武器
var
  nC, n10, n14: Integer;
begin
  nC := GetRandomRange(g_Config.nWeaponDCAddValueMaxLimit, g_Config.nWeaponDCAddValueRate);
  if Random(g_Config.nWeaponDCAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nWeaponDCAddValueMaxLimit then UserItem.btValue[0]:= g_Config.nWeaponDCAddValueMaxLimit;//20080724 限制上限
  end;

  nC := GetRandomRange(12, 15);
  if Random(15) = 0 then begin
    n14 := (nC + 1) div 3;
    if n14 > 0 then begin
      if Random(3) <> 0 then begin
        UserItem.btValue[6] := n14;
      end else begin
        UserItem.btValue[6] := n14 + 10;
      end;
    end;
  end;

  nC := GetRandomRange(g_Config.nWeaponMCAddValueMaxLimit, g_Config.nWeaponMCAddValueRate);
  if Random(g_Config.nWeaponMCAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nWeaponMCAddValueMaxLimit then UserItem.btValue[1]:= g_Config.nWeaponMCAddValueMaxLimit;//20080724 限制上限
  end;
  nC := GetRandomRange(g_Config.nWeaponSCAddValueMaxLimit, g_Config.nWeaponSCAddValueRate);
  if Random(g_Config.nWeaponSCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nWeaponSCAddValueMaxLimit then UserItem.btValue[2]:= g_Config.nWeaponSCAddValueMaxLimit;//20080724 限制上限
  end;

  nC := GetRandomRange(12, 15);
  if Random(15) = 0 then begin
    UserItem.btValue[5] := nC div 2 + 1;
  end;
  nC := GetRandomRange(12, 12);
  if Random(3) < 2 then begin
    n10 := (nC + 1) * 2000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
  nC := GetRandomRange(12, 15);
  if Random(10) = 0 then begin
    UserItem.btValue[7] := nC div 2 + 1;
  end;
end;

procedure TItemUnit.RandomUpgradeDress(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nDressACAddValueMaxLimit, g_Config.nDressACAddValueRate);
  if Random(g_Config.nDressACAddRate) = 0 then begin
     UserItem.btValue[0] := nC + 1;
     if UserItem.btValue[0] > g_Config.nDressACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nDressACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nDressMACAddValueMaxLimit, g_Config.nDressMACAddValueRate);
  if Random(g_Config.nDressMACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nDressMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nDressMACAddValueMaxLimit;//20080724 限制上线
  end;

  nC := GetRandomRange(g_Config.nDressDCAddValueMaxLimit, g_Config.nDressDCAddValueRate);
  if Random(g_Config.nDressDCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nDressDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nDressDCAddValueMaxLimit;//20080724 限制上线
  end;

  nC := GetRandomRange(g_Config.nDressMCAddValueMaxLimit, g_Config.nDressMCAddValueRate);
  if Random(g_Config.nDressMCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nDressMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nDressMCAddValueMaxLimit;//20080724 限制上线
  end;

  nC := GetRandomRange(g_Config.nDressSCAddValueMaxLimit, g_Config.nDressSCAddValueRate);
  if Random(g_Config.nDressSCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nDressSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nDressSCAddValueMaxLimit;//20080724 限制上线
  end;

  nC := GetRandomRange(6, 10);
  if Random(8) < 6 then begin
    n10 := (nC + 1) * 2000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade202124(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nNeckLace202124ACAddValueMaxLimit, g_Config.nNeckLace202124ACAddValueRate);
  if Random(g_Config.nNeckLace202124ACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nNeckLace202124ACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nNeckLace202124ACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace202124MACAddValueMaxLimit, g_Config.nNeckLace202124MACAddValueRate);
  if Random(g_Config.nNeckLace202124MACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nNeckLace202124MACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nNeckLace202124MACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace202124DCAddValueMaxLimit, g_Config.nNeckLace202124DCAddValueRate);
  if Random(g_Config.nNeckLace202124DCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nNeckLace202124DCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nNeckLace202124DCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace202124MCAddValueMaxLimit, g_Config.nNeckLace202124MCAddValueRate);
  if Random(g_Config.nNeckLace202124MCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nNeckLace202124MCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nNeckLace202124MCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace202124SCAddValueMaxLimit, g_Config.nNeckLace202124SCAddValueRate);
  if Random(g_Config.nNeckLace202124SCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nNeckLace202124SCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nNeckLace202124SCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(20) < 15 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade26(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nArmRing26ACAddValueMaxLimit, g_Config.nArmRing26ACAddValueRate);
  if Random(g_Config.nArmRing26ACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nArmRing26ACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nArmRing26ACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nArmRing26MACAddValueMaxLimit, g_Config.nArmRing26MACAddValueRate);
  if Random(g_Config.nArmRing26MACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nArmRing26MACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nArmRing26MACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nArmRing26DCAddValueMaxLimit, g_Config.nArmRing26DCAddValueRate);
  if Random(g_Config.nArmRing26DCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nArmRing26DCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nArmRing26DCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nArmRing26MCAddValueMaxLimit, g_Config.nArmRing26MCAddValueRate);
  if Random(g_Config.nArmRing26MCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nArmRing26MCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nArmRing26MCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nArmRing26SCAddValueMaxLimit, g_Config.nArmRing26SCAddValueRate);
  if Random(g_Config.nArmRing26SCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nArmRing26SCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nArmRing26SCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(20) < 15 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;
//随机升级-分类19物品(幸运类项链)
procedure TItemUnit.RandomUpgrade19(UserItem: pTUserItem); //00494D60
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nNeckLace19ACAddValueMaxLimit, g_Config.nNeckLace19ACAddValueRate);
  if Random(g_Config.nNeckLace19ACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nNeckLace19ACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nNeckLace19ACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace19MACAddValueMaxLimit, g_Config.nNeckLace19MACAddValueRate);
  if Random(g_Config.nNeckLace19MACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nNeckLace19MACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nNeckLace19MACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace19DCAddValueMaxLimit, g_Config.nNeckLace19DCAddValueRate);
  if Random(g_Config.nNeckLace19DCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nNeckLace19DCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nNeckLace19DCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace19MCAddValueMaxLimit, g_Config.nNeckLace19MCAddValueRate);
  if Random(g_Config.nNeckLace19MCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nNeckLace19MCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nNeckLace19MCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace19SCAddValueMaxLimit, g_Config.nNeckLace19SCAddValueRate);
  if Random(g_Config.nNeckLace19SCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nNeckLace19SCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nNeckLace19SCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 10);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade22(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nRing22DCAddValueMaxLimit, g_Config.nRing22DCAddValueRate);
  if Random(g_Config.nRing22DCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nRing22DCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nRing22DCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing22MCAddValueMaxLimit, g_Config.nRing22MCAddValueRate);
  if Random(g_Config.nRing22MCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nRing22MCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nRing22MCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing22SCAddValueMaxLimit, g_Config.nRing22SCAddValueRate);
  if Random(g_Config.nRing22SCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nRing22SCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nRing22SCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade23(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nRing23ACAddValueMaxLimit, g_Config.nRing23ACAddValueRate);
  if Random(g_Config.nRing23ACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nRing23ACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nRing23ACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing23MACAddValueMaxLimit, g_Config.nRing23MACAddValueRate);
  if Random(g_Config.nRing23MACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nRing23MACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nRing23MACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing23DCAddValueMaxLimit, g_Config.nRing23DCAddValueRate);
  if Random(g_Config.nRing23DCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nRing23DCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nRing23DCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing23MCAddValueMaxLimit, g_Config.nRing23MCAddValueRate);
  if Random(g_Config.nRing23MCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nRing23MCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nRing23MCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing23SCAddValueMaxLimit, g_Config.nRing23SCAddValueRate);
  if Random(g_Config.nRing23SCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nRing23SCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nRing23SCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;
//头盔,斗笠 极品属性
procedure TItemUnit.RandomUpgradeHelMet(UserItem: pTUserItem); //00495110
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nHelMetACAddValueMaxLimit, g_Config.nHelMetACAddValueRate);
  if Random(g_Config.nHelMetACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nHelMetACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nHelMetACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nHelMetMACAddValueMaxLimit, g_Config.nHelMetMACAddValueRate);
  if Random(g_Config.nHelMetMACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nHelMetMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nHelMetMACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nHelMetDCAddValueMaxLimit, g_Config.nHelMetDCAddValueRate);
  if Random(g_Config.nHelMetDCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nHelMetDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nHelMetDCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nHelMetMCAddValueMaxLimit, g_Config.nHelMetMCAddValueRate);
  if Random(g_Config.nHelMetMCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nHelMetMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nHelMetMCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nHelMetSCAddValueMaxLimit, g_Config.nHelMetSCAddValueRate);
  if Random(g_Config.nHelMetSCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nHelMetSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nHelMetSCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;
//20080503  鞋子腰带极品
procedure TItemUnit.RandomUpgradeBoots(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nBootsACAddValueMaxLimit, g_Config.nBootsACAddValueRate);
  if Random(g_Config.nBootsACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;//防御
    if UserItem.btValue[0] > g_Config.nBootsACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nBootsACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nBootsMACAddValueMaxLimit, g_Config.nBootsMACAddValueRate);
  if Random(g_Config.nBootsMACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;//魔御
    if UserItem.btValue[1] > g_Config.nBootsMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nBootsMACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nBootsDCAddValueMaxLimit , g_Config.nBootsDCAddValueRate );
  if Random(g_Config.nBootsDCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;//攻击力
    if UserItem.btValue[2] > g_Config.nBootsDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nBootsDCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nBootsMCAddValueMaxLimit, g_Config.nBootsMCAddValueRate);
  if Random(g_Config.nBootsMCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;//魔法
    if UserItem.btValue[3] > g_Config.nBootsMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nBootsMCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nBootsSCAddValueMaxLimit, g_Config.nBootsSCAddValueRate);
  if Random(g_Config.nBootsSCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;//道术
    if UserItem.btValue[4] > g_Config.nBootsSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nBootsSCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.UnknowHelmet(UserItem: pTUserItem); //神秘头盔
var
  nC, nRandPoint, n14: Integer;
begin
  nRandPoint := GetRandomRange(g_Config.nUnknowHelMetACAddValueMaxLimit, g_Config.nUnknowHelMetACAddRate);
  if nRandPoint > 0 then begin
    UserItem.btValue[0] := nRandPoint;
    if UserItem.btValue[0] > g_Config.nUnknowHelMetACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nUnknowHelMetACAddValueMaxLimit;//20080724 限制上线
  end;
  n14 := nRandPoint;
  nRandPoint := GetRandomRange(g_Config.nUnknowHelMetMACAddValueMaxLimit, g_Config.nUnknowHelMetMACAddRate);
  if nRandPoint > 0 then begin
    UserItem.btValue[1] := nRandPoint;
    if UserItem.btValue[1] > g_Config.nUnknowHelMetMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nUnknowHelMetMACAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, nRandPoint);
  nRandPoint := GetRandomRange(g_Config.nUnknowHelMetDCAddValueMaxLimit, g_Config.nUnknowHelMetDCAddRate);
  if nRandPoint > 0 then begin
    UserItem.btValue[2] := nRandPoint;
    if UserItem.btValue[2] > g_Config.nUnknowHelMetDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nUnknowHelMetDCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, nRandPoint);
  nRandPoint := GetRandomRange(g_Config.nUnknowHelMetMCAddValueMaxLimit, g_Config.nUnknowHelMetMCAddRate);
  if nRandPoint > 0 then begin
    UserItem.btValue[3] := nRandPoint;
    if UserItem.btValue[3] > g_Config.nUnknowHelMetMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nUnknowHelMetMCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, nRandPoint);
  nRandPoint := GetRandomRange(g_Config.nUnknowHelMetSCAddValueMaxLimit, g_Config.nUnknowHelMetSCAddRate);
  if nRandPoint > 0 then begin
    UserItem.btValue[4] := nRandPoint;
    if UserItem.btValue[4] > g_Config.nUnknowHelMetSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nUnknowHelMetSCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, nRandPoint);
  nRandPoint := GetRandomRange(6, 30);
  if nRandPoint > 0 then begin
    nC := (nRandPoint + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nC);
    UserItem.Dura := _MIN(65000, UserItem.Dura + nC);
  end;
  if Random(30) = 0 then UserItem.btValue[7] := 1;
  UserItem.btValue[8] := 1;
  if n14 >= 3 then begin
    if UserItem.btValue[0] >= 5 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[0] * 3 + 25;
      Exit;
    end;
    if UserItem.btValue[2] >= 2 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[2] * 4 + 35;
      Exit;
    end;
    if UserItem.btValue[3] >= 2 then begin
      UserItem.btValue[5] := 2;
      UserItem.btValue[6] := UserItem.btValue[3] * 2 + 18;
      Exit;
    end;
    if UserItem.btValue[4] >= 2 then begin
      UserItem.btValue[5] := 3;
      UserItem.btValue[6] := UserItem.btValue[4] * 2 + 18;
      Exit;
    end;
    UserItem.btValue[6] := n14 * 2 + 18;
  end;
end;

procedure TItemUnit.UnknowRing(UserItem: pTUserItem); //神秘戒指
var
  nC, n10, n14: Integer;
begin
  n10 := GetRandomRange(g_Config.nUnknowRingACAddValueMaxLimit, g_Config.nUnknowRingACAddRate);
  if n10 > 0 then begin
    UserItem.btValue[0] := n10;
    if UserItem.btValue[0] > g_Config.nUnknowRingACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nUnknowRingACAddValueMaxLimit;//20080724 限制上线
  end;
  n14 := n10;
  n10 := GetRandomRange(g_Config.nUnknowRingMACAddValueMaxLimit, g_Config.nUnknowRingMACAddRate);
  if n10 > 0 then begin
    UserItem.btValue[1] := n10;
    if UserItem.btValue[1] > g_Config.nUnknowRingMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nUnknowRingMACAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);

  n10 := GetRandomRange(g_Config.nUnknowRingDCAddValueMaxLimit, g_Config.nUnknowRingDCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[2] := n10;
    if UserItem.btValue[2] > g_Config.nUnknowRingDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nUnknowRingDCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(g_Config.nUnknowRingMCAddValueMaxLimit, g_Config.nUnknowRingMCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[3] := n10;
    if UserItem.btValue[3] > g_Config.nUnknowRingMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nUnknowRingMCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(g_Config.nUnknowRingSCAddValueMaxLimit, g_Config.nUnknowRingSCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[4] := n10;
    if UserItem.btValue[4] > g_Config.nUnknowRingSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nUnknowRingSCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(6, 30);
  if n10 > 0 then begin
    nC := (n10 + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nC);
    UserItem.Dura := _MIN(65000, UserItem.Dura + nC);
  end;
  if Random(30) = 0 then UserItem.btValue[7] := 1;
  UserItem.btValue[8] := 1;
  if n14 >= 3 then begin
    if UserItem.btValue[2] >= 3 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[2] * 3 + 25;
      Exit;
    end;
    if UserItem.btValue[3] >= 3 then begin
      UserItem.btValue[5] := 2;
      UserItem.btValue[6] := UserItem.btValue[3] * 2 + 18;
      Exit;
    end;
    if UserItem.btValue[4] >= 3 then begin
      UserItem.btValue[5] := 3;
      UserItem.btValue[6] := UserItem.btValue[4] * 2 + 18;
      Exit;
    end;
    UserItem.btValue[6] := n14 * 2 + 18;
  end;
end;

procedure TItemUnit.UnknowNecklace(UserItem: pTUserItem); //神秘腰带
var
  nC, n10, n14: Integer;
begin
  n10 := GetRandomRange(g_Config.nUnknowNecklaceACAddValueMaxLimit, g_Config.nUnknowNecklaceACAddRate);
  if n10 > 0 then begin
    UserItem.btValue[0] := n10;
    if UserItem.btValue[0] > g_Config.nUnknowNecklaceACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nUnknowNecklaceACAddValueMaxLimit;//20080724 限制上线
  end;
  n14 := n10;
  n10 := GetRandomRange(g_Config.nUnknowNecklaceMACAddValueMaxLimit, g_Config.nUnknowNecklaceMACAddRate);
  if n10 > 0 then begin
    UserItem.btValue[1] := n10;
    if UserItem.btValue[1] > g_Config.nUnknowNecklaceMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nUnknowNecklaceMACAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(g_Config.nUnknowNecklaceDCAddValueMaxLimit, g_Config.nUnknowNecklaceDCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[2] := n10;
    if UserItem.btValue[2] > g_Config.nUnknowNecklaceDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nUnknowNecklaceDCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(g_Config.nUnknowNecklaceMCAddValueMaxLimit, g_Config.nUnknowNecklaceMCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[3] := n10;
    if UserItem.btValue[3] > g_Config.nUnknowNecklaceMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nUnknowNecklaceMCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(g_Config.nUnknowNecklaceSCAddValueMaxLimit, g_Config.nUnknowNecklaceSCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[4] := n10;
    if UserItem.btValue[4] > g_Config.nUnknowNecklaceSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nUnknowNecklaceSCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(6, 30);
  if n10 > 0 then begin
    nC := (n10 + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nC);
    UserItem.Dura := _MIN(65000, UserItem.Dura + nC);
  end;
  if Random(30) = 0 then UserItem.btValue[7] := 1;
  UserItem.btValue[8] := 1;
  if n14 >= 2 then begin
    if UserItem.btValue[0] >= 3 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[0] * 3 + 25;
      Exit;
    end;
    if UserItem.btValue[2] >= 2 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[2] * 3 + 30;
      Exit;
    end;
    if UserItem.btValue[3] >= 2 then begin
      UserItem.btValue[5] := 2;
      UserItem.btValue[6] := UserItem.btValue[3] * 2 + 20;
      Exit;
    end;
    if UserItem.btValue[4] >= 2 then begin
      UserItem.btValue[5] := 3;
      UserItem.btValue[6] := UserItem.btValue[4] * 2 + 20;
      Exit;
    end;
    UserItem.btValue[6] := n14 * 2 + 18;
  end;
end;
//取物品的附属属性
procedure TItemUnit.GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem); //00495974
begin
  case StdItem.StdMode of
    5, 6: begin //004959D6
        StdItem.DC := MakeLong(LoWord(StdItem.DC), HiWord(StdItem.DC) + UserItem.btValue[0]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC), HiWord(StdItem.MC) + UserItem.btValue[1]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC), HiWord(StdItem.SC) + UserItem.btValue[2]);
        StdItem.AC := MakeLong(LoWord(StdItem.AC) + UserItem.btValue[3], HiWord(StdItem.AC) + UserItem.btValue[5]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC) + UserItem.btValue[4], HiWord(StdItem.MAC) + UserItem.btValue[6]);
        if Byte(UserItem.btValue[7] - 1) < 10 then begin //神圣
          StdItem.Source := UserItem.btValue[7];
        end;
        if UserItem.btValue[10] <> 0 then
          StdItem.Reserved := StdItem.Reserved or 1;
      end;
    10, 11: begin
        StdItem.AC := MakeLong(LoWord(StdItem.AC), HiWord(StdItem.AC) + UserItem.btValue[0]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC), HiWord(StdItem.MAC) + UserItem.btValue[1]);
        StdItem.DC := MakeLong(LoWord(StdItem.DC), HiWord(StdItem.DC) + UserItem.btValue[2]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC), HiWord(StdItem.MC) + UserItem.btValue[3]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC), HiWord(StdItem.SC) + UserItem.btValue[4]);
      end;
    15, 16, 19, 20, 21, 22, 23, 24, 26, 51, 52, 53, 54, 62, 63, 64, 30: begin//加入勋章分类 20080616
        StdItem.AC := MakeLong(LoWord(StdItem.AC), HiWord(StdItem.AC) + UserItem.btValue[0]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC), HiWord(StdItem.MAC) + UserItem.btValue[1]);
        StdItem.DC := MakeLong(LoWord(StdItem.DC), HiWord(StdItem.DC) + UserItem.btValue[2]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC), HiWord(StdItem.MC) + UserItem.btValue[3]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC), HiWord(StdItem.SC) + UserItem.btValue[4]);
        if UserItem.btValue[5] > 0 then begin
          StdItem.Need := UserItem.btValue[5];
        end;
        if UserItem.btValue[6] > 0 then begin
          StdItem.NeedLevel := UserItem.btValue[6];
        end;
      end;
  end;
  if (UserItem.btValue[20] > 0) or (StdItem.Source > 0) then begin //吸伤属性 20080324
    Case StdItem.StdMode of
      15,16,19..24,26,30,52,54,62,64:begin//头盔,项链,戒指,手镯,鞋子,腰带,勋章
         if StdItem.Shape = 188{140} then begin
           StdItem.Source:= StdItem.Source + UserItem.btValue[20];
           if StdItem.Source > 100 then StdItem.Source:= 100;
           StdItem.Reserved:=StdItem.Reserved + UserItem.btValue[9];
           if StdItem.Reserved > 5 then StdItem.Reserved:= 5;//吸伤装备等级 20080816
         end;
       end;
    end;
  end;
end;
//取自定义物品名称
function TItemUnit.GetCustomItemName(nMakeIndex,
  nItemIndex: Integer): string;
var
  I: Integer;
  ItemName: pTItemName;
begin
  Result := '';
  m_ItemNameList.Lock;
  try
    for I := 0 to m_ItemNameList.Count - 1 do begin
      ItemName := m_ItemNameList.Items[I];
      if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex = nItemIndex) then begin
        Result := ItemName.sItemName;
        Break;
      end;
    end;
  finally
    m_ItemNameList.UnLock;
  end;
end;


function TItemUnit.AddCustomItemName(nMakeIndex, nItemIndex: Integer;
  sItemName: string): Boolean;
var
  I: Integer;
  ItemName: pTItemName;
begin
  Result := False;
  m_ItemNameList.Lock;
  try
    for I := 0 to m_ItemNameList.Count - 1 do begin
      ItemName := m_ItemNameList.Items[I];
      if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex = nItemIndex) then begin
        Exit;
      end;
    end;
    New(ItemName);
    ItemName.nMakeIndex := nMakeIndex;
    ItemName.nItemIndex := nItemIndex;
    ItemName.sItemName := sItemName;
    m_ItemNameList.Add(ItemName);
    Result := True;
  finally
    m_ItemNameList.UnLock;
  end;
end;

function TItemUnit.DelCustomItemName(nMakeIndex, nItemIndex: Integer): Boolean;
var
  I: Integer;
  ItemName: pTItemName;
begin
  Result := False;
  m_ItemNameList.Lock;
  try
    for I := m_ItemNameList.Count - 1 downto 0 do begin//20080917
      if m_ItemNameList.Count <= 0 then Break;//20080917
      ItemName := m_ItemNameList.Items[I];
      if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex = nItemIndex) then begin
        Dispose(ItemName);
        m_ItemNameList.Delete(I);
        Result := True;
        Exit;
      end;
    end;
  finally
    m_ItemNameList.UnLock;
  end;
end;

function TItemUnit.LoadCustomItemName: Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sLineText: string;
  sMakeIndex: string;
  sItemIndex: string;
  nMakeIndex: Integer;
  nItemIndex: Integer;
  sItemName: string;
  ItemName: pTItemName;
begin
  Result := False;
  sFileName := g_Config.sEnvirDir + 'ItemNameList.txt';
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    m_ItemNameList.Lock;
    try
      if m_ItemNameList.Count > 0 then m_ItemNameList.Clear;//20080831 修改
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := Trim(LoadList.Strings[I]);
        sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sItemIndex, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
        nMakeIndex := Str_ToInt(sMakeIndex, -1);
        nItemIndex := Str_ToInt(sItemIndex, -1);
        if (nMakeIndex >= 0) and (nItemIndex >= 0) then begin
          New(ItemName);
          ItemName.nMakeIndex := nMakeIndex;
          ItemName.nItemIndex := nItemIndex;
          ItemName.sItemName := sItemName;
          m_ItemNameList.Add(ItemName);
        end;
      end;//for
      Result := True;
    finally
      m_ItemNameList.UnLock;
    end;
  end else begin
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;

function TItemUnit.SaveCustomItemName: Boolean;
var
  I: Integer;
  SaveList: TStringList;
  sFileName: string;
  ItemName: pTItemName;
begin
  sFileName := g_Config.sEnvirDir + 'ItemNameList.txt';
  SaveList := TStringList.Create;
  m_ItemNameList.Lock;
  try
    if m_ItemNameList.Count > 0 then begin//20080630
      for I := 0 to m_ItemNameList.Count - 1 do begin
        ItemName := m_ItemNameList.Items[I];
        SaveList.Add(IntToStr(ItemName.nMakeIndex) + #9 + IntToStr(ItemName.nItemIndex) + #9 + ItemName.sItemName);
      end;
    end;
  finally
    m_ItemNameList.UnLock;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Result := True;
end;

procedure TItemUnit.Lock;
begin
  m_ItemNameList.Lock;
end;

procedure TItemUnit.UnLock;
begin
  m_ItemNameList.UnLock;
end;

end.

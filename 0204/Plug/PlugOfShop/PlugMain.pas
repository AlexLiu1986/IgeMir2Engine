unit PlugMain;

interface
uses
  Windows;
procedure InitPlug();
procedure UnInitPlug();
function StartPlug(): Boolean;
implementation

uses PlayShop;

procedure InitPlug();
begin
  InitPlayShop();
end;

procedure UnInitPlug();
begin
  UnInitPlayShop();
end;

function StartPlug(): Boolean;
begin
  Result := TRUE;
  LoadShopItemList();
end;

end.


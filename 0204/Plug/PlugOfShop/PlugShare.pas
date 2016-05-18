unit PlugShare;

interface
uses
  Windows, Classes, EngineType;
type
  TShopInfo = record
    StdItem: _TSTDITEM;
    sIntroduce:array [0..200] of Char;
    Idx: string[1];
    ImgBegin: string[5];
    Imgend: string[5];
    Introduce1:string[20];
  end;
  pTShopInfo = ^TShopInfo;
var
  PlugHandle: Integer;
  PlugClass: string = 'Config';
  g_ShopItemList: Classes.TList;

  g_nGameGold : Integer = 1; //Ôª±¦ 20080302
  g_boGameGird: Boolean = True;
  
implementation

end.


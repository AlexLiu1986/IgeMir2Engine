unit ClFunc;
//辅助函数库
interface

uses
  Windows, SysUtils, Classes, Graphics,
  DXDraws, Grobal2, HUtil32, SDK, Share;
type
   TextOutImage = record
     Surface: TDirectDrawSurface;
     Text: string;
     FColor: Integer;
     BColor: Integer;
     dwLatestTime: LongWord;
   end;
   pTextOutImage = ^TextOutImage;
var
   DropItems: TList;  //lsit of TClientItem
   {$IF Version <> 1}
   //字用图输出 20080916
   TextOutList: TGList;
   ChatTextOutList: TGList;
   BoldTextOutList: TGList;
   NameTextOutList: TGList;
   PixelsOutList: TGList;  //画点点图
   dwTextMemChecktTick: LongWord;
   dwChatMemChecktTick: LongWord;
   dwBoldMemChecktTick: LongWord;
   dwNameMemChecktTick: LongWord;
   dwPixelsMemChecktTick: LongWord; 
   {$IFEND}

function  fmStr (str: string; len: integer): string;
function  GetGoldStr (gold: integer): string;
procedure SaveBags (flname: string; pbuf: Pbyte);
procedure Loadbags (flname: string; pbuf: Pbyte);
procedure ClearBag;
function  AddItemBag (cu: TClientItem): Boolean;
function  AddHeroItemBag (cu: TClientItem): Boolean;  //英雄包 清清$016 2007.10.23
procedure ArrangeHeroItemBag;//英雄包 清清$017 2007.10.23
function  HeroUpdateItemBag (cu: TClientItem): Boolean;    //更新英雄包裹
function  DelHeroItemBag (iname: string; iindex: integer): Boolean; //删除英雄物品函数
function  UpdateItemBag (cu: TClientItem): Boolean;
function  DelItemBag (iname: string; iindex: integer): Boolean;
procedure ArrangeItemBag;
procedure AddDropItem (ci: TClientItem);
function  GetDropItem (iname: string; MakeIndex: integer): PTClientItem;
procedure DelDropItem (iname: string; MakeIndex: integer);
procedure AddDealItem (ci: TClientItem);
procedure DelDealItem (ci: TClientItem);
procedure AddSellOffItem (ci: TClientItem); //添加到寄售出售框中 20080316
procedure MoveSellOffItemToBag; //寄售相关 20080316
procedure AddChallengeItem (ci: TClientItem);
procedure DelChallengeItem (ci: TClientItem);
procedure MoveChallengeItemToBag;
procedure AddChallengeRemoteItem (ci: TClientItem);
procedure DelChallengeRemoteItem (ci: TClientItem);
procedure MoveDealItemToBag;
procedure AddDealRemoteItem (ci: TClientItem);
procedure DelDealRemoteItem (ci: TClientItem);
function  GetDistance (sx, sy, dx, dy: integer): integer;
procedure GetNextPosXY (dir: byte; var x, y:Integer);
function GetNextPosCanXY (var dir: byte; x, y: Integer):Boolean;
procedure GetNextRunXY (dir: byte; var x, y:Integer);
procedure GetNextHorseRunXY (dir: byte; var x, y:Integer);
function  GetNextDirection (sx, sy, dx, dy: Integer): byte;
function  GetBack (dir: integer): integer;
procedure GetBackPosition (sx, sy, dir: integer; var newx, newy: integer);
procedure GetFrontPosition (sx, sy, dir: integer; var newx, newy: integer);
function  GetFlyDirection (sx, sy, ttx, tty: integer): Integer;
function  GetFlyDirection16 (sx, sy, ttx, tty: integer): Integer;
function  PrivDir (ndir: integer): integer;
function  NextDir (ndir: integer): integer;
{$IF Version <> 1}
procedure BoldTextOut(surface: TDirectDrawSurface; x, y, fcolor, bcolor: Integer; str:string);
procedure NameTextOut(surface: TDirectDrawSurface; x, y, fcolor, bcolor: Integer; str:string);
procedure ChatTextOut(surface: TDirectDrawSurface; X, Y, FColor, BColor: Integer; str:string);
procedure TextOut(surface: TDirectDrawSurface; X, Y, Color: Integer; str:string);
procedure PixelsOut(surface: TDirectDrawSurface; X, Y, Color, Size: Integer);
{$ELSE}
procedure BoldTextOut(surface: TDirectDrawSurface; x, y, fcolor, bcolor: Integer; str:string);
{$IFEND}
function  GetTakeOnPosition (smode: integer): integer;
function  IsKeyPressed (key: byte): Boolean;
procedure BoldTextOut1(surface: TDirectDrawSurface; x, y, fcolor, bcolor: Integer; str:string);
procedure AddChangeFace (recogid: integer);
procedure DelChangeFace (recogid: integer);
function  IsChangingFace (recogid: integer): Boolean;

implementation

uses
   clMain, MShare, cliUtil;

//格式化字符串为指定长度（后面添空格）
function fmStr (str: string; len: integer): string;
var i: integer;
begin
try
   Result := str + ' ';
   for i:=1 to len - Length(str)-1 do
      Result := Result + ' ';
except
	Result := str + ' ';
end;
end;
//整数转换为千位带逗号的字符串，例如1234567转换为“1,234,567”
//这里用于显示金钱数量
function  GetGoldStr (gold: integer): string;
var
   i, n: integer;
   str: string;
begin
   str := IntToStr (gold);
   n := 0;
   Result := '';
   for i:=Length(str) downto 1 do begin
      if n = 3 then begin
         Result := str[i] + ',' + Result;
         n := 1;
      end else begin
         Result := str[i] + Result;
         Inc(n);
      end;
   end;
end;
//保存装备物品到文件
procedure SaveBags (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
   if FileExists (flname) then
      fhandle := FileOpen (flname, fmOpenWrite or fmShareDenyNone)
   else fhandle := FileCreate (flname);
   if fhandle > 0 then begin
      FileWrite (fhandle, pbuf^, sizeof(TClientItem) * MAXBAGITEMCL);
      FileClose (fhandle);
   end;
end;
//装载装备物品
procedure Loadbags (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
         FileRead (fhandle, pbuf^, sizeof(TClientItem) * MAXBAGITEMCL);
         FileClose (fhandle);
      end;
   end;
end;
//清除物品
procedure ClearBag;
var
   i: integer;
begin
   for i:=0 to MAXBAGITEMCL-1 do
      g_ItemArr[i].S.Name := '';
end;
//添加物品
function  AddItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   //检查要添加的物品是否已经存在
   for i:=0 to MAXBAGITEMCL-1 do begin
      if (g_ItemArr[i].MakeIndex = cu.MakeIndex) and (g_ItemArr[i].S.Name = cu.S.Name) then begin
         exit;
      end;
   end;

   if cu.S.Name = '' then exit;
   if (cu.S.StdMode <= 3) then begin //可以使用的物品,首先放在快捷物品栏
      if (cu.s.StdMode = 2) and (cu.s.Need = 1) then  //不允许放入的物品 20080331
      
      else begin
      for i:=0 to 5 do
         if g_ItemArr[i].S.Name = '' then begin     //找一个空档放下
            g_ItemArr[i] := cu;
            Result := TRUE;
            Exit;
         end;
      end;
   end;
   for i:=6 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[i].S.Name = '' then begin
         g_ItemArr[i] := cu;
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItembag;
end;
//英雄包 清清$017 2007.10.23
function  AddHeroItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=0 to g_HeroBagCount-1 do begin
      if (g_HeroItemArr[i].MakeIndex = cu.MakeIndex) and (g_HeroItemArr[i].S.Name = cu.S.Name) then begin
         Exit;  
      end;
   end;

   if cu.S.Name = '' then exit;
   for i:=0 to MAXHEROBAGITEM{英雄包裹最大容量在G单元里}-1 do begin
      if g_HeroItemArr[i].S.Name = '' then begin
         g_HeroItemArr[i] := cu;
         Result := TRUE;
         break;
      end;
   end;
   ArrangeHeroItembag;
end;
//用当前的物品属性替代已经存在的该物品属性
function  HeroUpdateItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_HeroItemArr[i].S.Name = cu.S.Name) and (g_HeroItemArr[i].MakeIndex = cu.MakeIndex) then begin
         g_HeroItemArr[i] := cu;  //诀单捞飘
         Result := TRUE;
         break;
      end;
   end;
end;
//删除指定的物品
function  DelHeroItemBag (iname: string; iindex: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_HeroItemArr[i].S.Name = iname) and (g_HeroItemArr[i].MakeIndex = iindex) then begin
         FillChar (g_HeroItemArr[i], sizeof(TClientItem), #0);
         Result := TRUE;
         break;
      end;
   end;
   ArrangeHeroItembag;
end;
//用当前的物品属性替代已经存在的该物品属性
function  UpdateItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_ItemArr[i].S.Name = cu.S.Name) and (g_ItemArr[i].MakeIndex = cu.MakeIndex) then begin
         g_ItemArr[i] := cu;  //诀单捞飘
         Result := TRUE;
         break;
      end;
   end;
end;
//删除指定的物品
function  DelItemBag (iname: string; iindex: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_ItemArr[i].S.Name = iname) and (g_ItemArr[i].MakeIndex = iindex) then begin
         FillChar (g_ItemArr[i], sizeof(TClientItem), #0);
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItembag;
end;
//整理物品包
procedure ArrangeItemBag;
var
   i, k: integer;
begin
   //整理背包物品
   for i:=0 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[i].S.Name <> '' then begin
         for k:=i+1 to MAXBAGITEMCL-1 do begin   //清除相同的物品
            if (g_ItemArr[i].S.Name = g_ItemArr[k].S.Name) and (g_ItemArr[i].MakeIndex = g_ItemArr[k].MakeIndex) then begin
               FillChar (g_ItemArr[k], sizeof(TClientItem), #0);
            end;
         end;
         {for k:=0 to 9 do begin
            if (ItemArr[i].S.Name = DealItems[k].S.Name) and (ItemArr[i].MakeIndex = DealItems[k].MakeIndex) then begin
               FillChar (ItemArr[i], sizeof(TClientItem), #0);
               //FillChar (DealItems[k], sizeof(TClientItem), #0);
            end;
         end; }
         //若有移动的物品
         if (g_ItemArr[i].S.Name = g_MovingItem.Item.S.Name) and (g_ItemArr[i].MakeIndex = g_MovingItem.Item.MakeIndex) then begin
            g_MovingItem.Index := 0;
            g_MovingItem.Item.S.Name := '';
         end;
      end;
   end;

   //6样快捷物品栏物品
   for i:=46 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[i].S.Name <> '' then begin
         for k:=6 to 45 do begin
            if g_ItemArr[k].S.Name = '' then begin
               g_ItemArr[k] := g_ItemArr[i];
               g_ItemArr[i].S.Name := '';
               break;
            end;
         end;
      end;
   end;
end;


//整理英雄包 清清$017 2007.10.23
procedure ArrangeHeroItemBag;
var
   i, k: integer;
begin
   //整理背包物品
   for i:=0 to MAXBAGITEMCL-1 do begin
      if g_HeroItemArr[i].S.Name <> '' then begin
         for k:=i+1 to MAXBAGITEMCL-1 do begin
            if (g_HeroItemArr[i].S.Name = g_HeroItemArr[k].S.Name) and (g_HeroItemArr[i].MakeIndex = g_HeroItemArr[k].MakeIndex) then begin
               FillChar (g_HeroItemArr[k], sizeof(TClientItem), #0);
            end;
         end;
         //若有移动的物品
         if (g_HeroItemArr[i].S.Name = g_MovingHeroItem.Item.S.Name) and (g_HeroItemArr[i].MakeIndex = g_MovingHeroItem.Item.MakeIndex) then begin
            g_MovingHeroItem.Index := 0;
            g_MovingHeroItem.Item.S.Name := '';
         end;
      end;
   end;

   //6样快捷物品栏物品
   for i:=46 to MAXBAGITEMCL-1 do begin
      if g_HeroItemArr[i].S.Name <> '' then begin
         for k:=6 to 45 do begin
            if g_HeroItemArr[k].S.Name = '' then begin
               g_HeroItemArr[k] := g_HeroItemArr[i];
               g_HeroItemArr[i].S.Name := '';
               break;
            end;
         end;
      end;
   end;
end;
{----------------------------------------------------------}
//添加跌落物品
procedure AddDropItem (ci: TClientItem);
var
   pc: PTClientItem;
begin
   new (pc);
   pc^ := ci;
   DropItems.Add (pc);
end;
//获取跌落物品
function  GetDropItem (iname: string; MakeIndex: integer): PTClientItem;
var
   i: integer;
begin
   Result := nil;
   if DropItems.Count > 0 then //20080629
   for i:=0 to DropItems.Count-1 do begin
      if (PTClientItem(DropItems[i]).S.Name = iname) and (PTClientItem(DropItems[i]).MakeIndex = MakeIndex) then begin
         Result := PTClientItem(DropItems[i]);
         break;
      end;
   end;
end;
//删除跌落物品
procedure DelDropItem (iname: string; MakeIndex: integer);
var
   I: integer;
begin
   if DropItems.Count > 0 then //20080629
   for i:=0 to DropItems.Count-1 do begin
      if (PTClientItem(DropItems[i]).S.Name = iname) and (PTClientItem(DropItems[i]).MakeIndex = MakeIndex) then begin
         Dispose (PTClientItem(DropItems[i]));
         DropItems.Delete (i);
         break;
      end;
   end;
end;

{----------------------------------------------------------}

procedure AddDealItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if g_DealItems[i].S.Name = '' then begin
         g_DealItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelDealItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if (g_DealItems[i].S.Name = ci.S.Name) and (g_DealItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_DealItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;
{******************************************************************************}
//挑战 20080705
procedure AddChallengeItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 3 do begin
      if g_ChallengeItems[i].S.Name = '' then begin
         g_ChallengeItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelChallengeItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 3 do begin
      if (g_ChallengeItems[i].S.Name = ci.S.Name) and (g_ChallengeItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_ChallengeItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;

procedure MoveChallengeItemToBag;
var
   i: integer;
begin
   for i:=0 to 3 do begin
      if g_ChallengeItems[i].S.Name <> '' then
         AddItemBag (g_ChallengeItems[i]);
   end;
   FillChar (g_ChallengeItems, sizeof(TClientItem)*4, #0);
end;

procedure AddChallengeRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 3 do begin
      if g_ChallengeRemoteItems[i].S.Name = '' then begin
         g_ChallengeRemoteItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelChallengeRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 3 do begin
      if (g_ChallengeRemoteItems[i].S.Name = ci.S.Name) and (g_ChallengeRemoteItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_ChallengeRemoteItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;

{******************************************************************************}
//元宝寄售系统 20080316
procedure AddSellOffItem (ci: TClientItem); //添加到寄售出售框中
var
   i: integer;
begin
   for i:=0 to 9-1 do begin
      if g_SellOffItems[i].S.Name = '' then begin
         g_SellOffItems[i] := ci;
         break;
      end;
   end;
end;

procedure MoveSellOffItemToBag;   //寄售相关 20080316
var
   i: integer;
begin
   for i:=0 to 9-1 do begin
      if g_SellOffItems[i].S.Name <> '' then
         AddItemBag (g_SellOffItems[i]);
   end;
   FillChar (g_SellOffItems, sizeof(TClientItem)*9, #0);
end;
{******************************************************************************}
procedure MoveDealItemToBag;
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if g_DealItems[i].S.Name <> '' then
         AddItemBag (g_DealItems[i]);
   end;
   FillChar (g_DealItems, sizeof(TClientItem)*10, #0);
end;

procedure AddDealRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 20-1 do begin
      if g_DealRemoteItems[i].S.Name = '' then begin
         g_DealRemoteItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelDealRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 20-1 do begin
      if (g_DealRemoteItems[i].S.Name = ci.S.Name) and (g_DealRemoteItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_DealRemoteItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;

{----------------------------------------------------------}
//计算两点间的距离（X或Y方向）
function  GetDistance (sx, sy, dx, dy: integer): integer;
begin
   Result := _MAX(abs(sx-dx), abs(sy-dy));
end;
//根据方向和当前位置确定下一个位置坐标(位移量=1）
procedure GetNextPosXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:     begin x := x;   y := y-1; end;
      DR_UPRIGHT:   begin x := x+1; y := y-1; end;
      DR_RIGHT:  begin x := x+1; y := y; end;
      DR_DOWNRIGHT:  begin x := x+1; y := y+1; end;
      DR_DOWN:   begin x := x;   y := y+1; end;
      DR_DOWNLEFT:   begin x := x-1; y := y+1; end;
      DR_LEFT:   begin x := x-1; y := y; end;
      DR_UPLEFT:  begin x := x-1; y := y-1; end;
   end;
end;
//找方向和当前位置确定可走下一个位置坐标(位移量=1)
function GetNextPosCanXY (var dir: byte; x, y: Integer):Boolean;
var
  mx,my: Integer;
begin
  Result := False;
  dir := 0;//GetNextDirection(x, y, TargetX, TargetY);
  while True do begin
    if dir > DR_UPLEFT then break;   //DIR 到最后一个方向 还走不了 那么退出
    case dir of
      DR_UP: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_UP, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_UP;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_UPRIGHT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_UPRIGHT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_UPRIGHT;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_RIGHT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_RIGHT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_RIGHT;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_DOWNRIGHT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_DOWNRIGHT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_DOWNRIGHT;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_DOWN: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_DOWN, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_DOWN;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_DOWNLEFT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_DOWNLEFT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_DOWNLEFT;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_LEFT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_LEFT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_LEFT;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_UPLEFT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_UPLEFT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_UPLEFT;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end; else Break;
    end;
  end;
end;
//根据方向和当前位置确定下一个位置坐标(位移量=2）
procedure GetNextRunXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:     begin x := x;   y := y-2; end;
      DR_UPRIGHT:   begin x := x+2; y := y-2; end;
      DR_RIGHT:  begin x := x+2; y := y; end;
      DR_DOWNRIGHT:  begin x := x+2; y := y+2; end;
      DR_DOWN:   begin x := x;   y := y+2; end;
      DR_DOWNLEFT:   begin x := x-2; y := y+2; end;
      DR_LEFT:   begin x := x-2; y := y; end;
      DR_UPLEFT:  begin x := x-2; y := y-2; end;
   end;
end;

procedure GetNextHorseRunXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:     begin x := x;   y := y-3; end;
      DR_UPRIGHT:   begin x := x+3; y := y-3; end;
      DR_RIGHT:  begin x := x+3; y := y; end;
      DR_DOWNRIGHT:  begin x := x+3; y := y+3; end;
      DR_DOWN:   begin x := x;   y := y+3; end;
      DR_DOWNLEFT:   begin x := x-3; y := y+3; end;
      DR_LEFT:   begin x := x-3; y := y; end;
      DR_UPLEFT:  begin x := x-3; y := y-3; end;
   end;
end;

//根据两点计算移动的方向
function GetNextDirection (sx, sy, dx, dy: Integer): byte;
var
   flagx, flagy: integer;
begin
   Result := DR_DOWN;
   if sx < dx then flagx := 1
   else if sx = dx then flagx := 0
   else flagx := -1;
   if abs(sy-dy) > 2
    then if (sx >= dx-1) and (sx <= dx+1) then flagx := 0;

   if sy < dy then flagy := 1
   else if sy = dy then flagy := 0
   else flagy := -1;
   if abs(sx-dx) > 2 then if (sy > dy-1) and (sy <= dy+1) then flagy := 0;

   if (flagx = 0)  and (flagy = -1) then Result := DR_UP;
   if (flagx = 1)  and (flagy = -1) then Result := DR_UPRIGHT;
   if (flagx = 1)  and (flagy = 0)  then Result := DR_RIGHT;
   if (flagx = 1)  and (flagy = 1)  then Result := DR_DOWNRIGHT;
   if (flagx = 0)  and (flagy = 1)  then Result := DR_DOWN;
   if (flagx = -1) and (flagy = 1)  then Result := DR_DOWNLEFT;
   if (flagx = -1) and (flagy = 0)  then Result := DR_LEFT;
   if (flagx = -1) and (flagy = -1) then Result := DR_UPLEFT;
end;
//根据当前方向获得转身后的方向
function  GetBack (dir: integer): integer;
begin
   Result := DR_UP;
   case dir of
      DR_UP:     Result := DR_DOWN;
      DR_DOWN:   Result := DR_UP;
      DR_LEFT:   Result := DR_RIGHT;
      DR_RIGHT:  Result := DR_LEFT;
      DR_UPLEFT:     Result := DR_DOWNRIGHT;
      DR_UPRIGHT:    Result := DR_DOWNLEFT;
      DR_DOWNLEFT:   Result := DR_UPRIGHT;
      DR_DOWNRIGHT:  Result := DR_UPLEFT;
   end;
end;
//根据当前坐标和方向获得后退的坐标
procedure GetBackPosition (sx, sy, dir: integer; var newx, newy: integer);
begin
   newx := sx;
   newy := sy;
   case dir of
      DR_UP:      newy := newy+1;
      DR_DOWN:    newy := newy-1;
      DR_LEFT:    newx := newx+1;
      DR_RIGHT:   newx := newx-1;
      DR_UPLEFT:
         begin
            newx := newx + 1;
            newy := newy + 1;
         end;
      DR_UPRIGHT:
         begin
            newx := newx - 1;
            newy := newy + 1;
         end;
      DR_DOWNLEFT:
         begin
            newx := newx + 1;
            newy := newy - 1;
         end;
      DR_DOWNRIGHT:
         begin
            newx := newx - 1;
            newy := newy - 1;
         end;
   end;
end;
//根据当前位置和方向获得前进一步的坐标
procedure GetFrontPosition (sx, sy, dir: integer; var newx, newy: integer);
begin
   newx := sx;
   newy := sy;
   case dir of
      DR_UP:      newy := newy-1;
      DR_DOWN:    newy := newy+1;
      DR_LEFT:    newx := newx-1;
      DR_RIGHT:   newx := newx+1;
      DR_UPLEFT:
         begin
            newx := newx - 1;
            newy := newy - 1;
         end;
      DR_UPRIGHT:
         begin
            newx := newx + 1;
            newy := newy - 1;
         end;
      DR_DOWNLEFT:
         begin
            newx := newx - 1;
            newy := newy + 1;
         end;
      DR_DOWNRIGHT:
         begin
            newx := newx + 1;
            newy := newy + 1;
         end;
   end;
end;
//根据两点位置获得飞行方向（8个方向）
function  GetFlyDirection (sx, sy, ttx, tty: integer): Integer;
var
   fx, fy: Real;
begin
   fx := ttx - sx;
   fy := tty - sy;
   {sx := 0;
   sy := 0;  }
   Result := DR_DOWN;
   if fx=0 then begin         //两点的X坐标相等
      if fy < 0 then Result := DR_UP
      else Result := DR_DOWN;
      exit;
   end;
   if fy=0 then begin         //两点的Y坐标相等
      if fx < 0 then Result := DR_LEFT
      else Result := DR_RIGHT;
      exit;
   end;
   if (fx > 0) and (fy < 0) then begin
      if -fy > fx*2.5 then Result := DR_UP
      else if -fy < fx/3 then Result := DR_RIGHT
      else Result := DR_UPRIGHT;
   end;
   if (fx > 0) and (fy > 0) then begin
      if fy < fx/3 then Result := DR_RIGHT
      else if fy > fx*2.5 then Result := DR_DOWN
      else Result := DR_DOWNRIGHT;
   end;
   if (fx < 0) and (fy > 0) then begin
      if fy  < -fx/3 then Result := DR_LEFT
      else if fy > -fx*2.5 then Result := DR_DOWN
      else Result := DR_DOWNLEFT;
   end;
   if (fx < 0) and (fy < 0) then begin
      if -fy > -fx*2.5 then Result := DR_UP
      else if -fy < -fx/3 then Result := DR_LEFT
      else Result := DR_UPLEFT;
   end;
end;
//根据两点位置获得飞行方向(16个方向)
function  GetFlyDirection16 (sx, sy, ttx, tty: integer): Integer;
var
   fx, fy: Real;
begin
   fx := ttx - sx;
   fy := tty - sy;
   {sx := 0;
   sy := 0; }
   Result := 0;
   if fx=0 then begin
      if fy < 0 then Result := 0
      else Result := 8;
      exit;
   end;
   if fy=0 then begin
      if fx < 0 then Result := 12
      else Result := 4;
      exit;
   end;
   if (fx > 0) and (fy < 0) then begin
      Result := 4;
      if -fy > fx/4 then Result := 3;
      if -fy > fx/1.9 then Result := 2;
      if -fy > fx*1.4 then Result := 1;
      if -fy > fx*4 then Result := 0;
   end;
   if (fx > 0) and (fy > 0) then begin
      Result := 4;
      if fy > fx/4 then Result := 5;
      if fy > fx/1.9 then Result := 6;
      if fy > fx*1.4 then Result := 7;
      if fy > fx*4 then Result := 8;
   end;
   if (fx < 0) and (fy > 0) then begin
      Result := 12;
      if fy > -fx/4 then Result := 11;
      if fy > -fx/1.9 then Result := 10;
      if fy > -fx*1.4 then Result := 9;
      if fy > -fx*4 then Result := 8;
   end;
   if (fx < 0) and (fy < 0) then begin
      Result := 12;
      if -fy > -fx/4 then Result := 13;
      if -fy > -fx/1.9 then Result := 14;
      if -fy > -fx*1.4 then Result := 15;
      if -fy > -fx*4 then Result := 0;
   end;
end;
//按逆时针转动一个方向后的方向
function  PrivDir (ndir: integer): integer;
begin
   if ndir - 1 < 0 then Result := 7
   else Result := ndir-1;
end;
//按顺时针转动一个方向后的方向
function  NextDir (ndir: integer): integer;
begin
   if ndir + 1 > 7 then Result := 0
   else Result := ndir+1;
end;

{$IF Version = 1}
procedure BoldTextOut (surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; str: string);
begin
   Surface.Canvas.Lock;
   try
   with Surface.Canvas do begin
      Font.Color := bcolor;
      TextOut (x-1, y, str);
      TextOut (x+1, y, str);
      TextOut (x, y-1, str);
      TextOut (x, y+1, str);
      Font.Color := fcolor;
      TextOut (x, y, str);
   end;
   finally
     Surface.Canvas.Unlock;
   end;
end;
{$IFEND}
//解决滚动公告用图片显示不出来
procedure BoldTextOut1 (surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; str: string);
begin
   Surface.Canvas.Lock;
   try
   with Surface.Canvas do begin
      Font.Color := bcolor;
      TextOut (x-1, y, str);
      TextOut (x+1, y, str);
      TextOut (x, y-1, str);
      TextOut (x, y+1, str);
      Font.Color := fcolor;
      TextOut (x, y, str);
   end;
   finally
     Surface.Canvas.Unlock;
   end;
end;

function  GetTakeOnPosition (smode: integer): integer;
begin
   Result := -1;
   case smode of //StdMode
      5, 6     :Result := U_WEAPON;//武器
      10, 11   :Result := U_DRESS;
      15    :Result := U_HELMET;
      16    :Result := U_ZHULI;  //斗笠
      19,20,21 :Result := U_NECKLACE;
      22,23    :Result := U_RINGL;
      24,26    :Result := U_ARMRINGR;
      30,29 :Result := U_RIGHTHAND;
      25,2{祝福罐,魔令包}    :Result := U_BUJUK; //符
      52,62    :Result := U_BOOTS; //鞋
      53,63,7{气血石}    :Result := U_CHARM; //宝石
      54,64    :Result := U_BELT;  //腰带
      42,3{祝福油},41{魔族指令书}:Result := X_RepairFir; //修补火龙之心

   end;
end;
//判断某个键是否按下
function  IsKeyPressed (key: byte): Boolean;
var
   keyvalue: TKeyBoardState;
begin
   Result := FALSE;
   FillChar(keyvalue, sizeof(TKeyboardState), #0);
   if GetKeyboardState (keyvalue) then
      if (keyvalue[key] and $80) <> 0 then
         Result := TRUE;
end;

procedure AddChangeFace (recogid: integer);
begin
   g_ChangeFaceReadyList.Add (pointer(recogid));
end;

procedure DelChangeFace (recogid: integer);
var
   i: integer;
begin
   if g_ChangeFaceReadyList.Count > 0 then //20080629
   for i:=0 to g_ChangeFaceReadyList.Count-1 do begin
      if integer(g_ChangeFaceReadyList[i]) = recogid then begin
         g_ChangeFaceReadyList.Delete (i);
         break;
      end;
   end;
end;

function  IsChangingFace (recogid: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if g_ChangeFaceReadyList.Count > 0 then //20080629 
   for i:=0 to g_ChangeFaceReadyList.Count-1 do begin
      if integer(g_ChangeFaceReadyList[i]) = recogid then begin
         Result := TRUE;
         break;
      end;
   end;
end;

{$IF Version <> 1}
procedure NameTextOut(surface: TDirectDrawSurface; x, y, fcolor, bcolor: Integer; str:string);
  procedure FreeNameOldMemorys();
  var
    I: Integer;
  begin
    for I:=NameTextOutList.Count-1 downto 0 do begin
      if pTextOutImage(NameTextOutList[I]) <> nil then begin
        if GetTickCount - pTextOutImage(NameTextOutList[I]).dwLatestTime > 50000 then begin
          FreeAndNil(pTextOutImage(NameTextOutList[I]).Surface);
          Dispose(pTextOutImage(NameTextOutList[I]));
          NameTextOutList.Delete(I);
        end;
      end;
    end;
  end;
var
  I: Integer;
  TextOutImage: pTextOutImage;
begin
  {$I VMProtectBegin.inc}
  if NameTextOutList.Count > 0 then begin
    if GetTickCount - dwNameMemChecktTick > 10000 then begin
      dwNameMemChecktTick := GetTickCount;
      FreeNameOldMemorys;
    end;
    for I:=0 to NameTextOutList.Count - 1 do begin
      TextOutImage := pTextOutImage(NameTextOutList[I]);
      if TextOutImage <> nil then begin
        if (str = TextOutImage.Text) and (FColor = TextOutImage.FColor) then begin
          pTextOutImage(NameTextOutList[I]).dwLatestTime := GetTickCount;
          surface.Draw (x, y, TextOutImage.Surface.ClientRect, TextOutImage.Surface, TRUE);
          Exit;
        end;
      end;
    end;
  end;
  
  if str <> '' then begin
    New(TextOutImage);
    TextOutImage.Surface :=  TDirectDrawSurface.Create (frmMain.DXDraw.DDraw);
    TextOutImage.Surface.SystemMemory := TRUE;
    TextOutImage.Surface.SetSize (frmMain.Canvas.TextWidth(str)+2, frmMain.Canvas.TextHeight(str)+2);
    TextOutImage.Surface.Fill(18);
    TextOutImage.Surface.Canvas.Font := surface.Canvas.Font;
    TextOutImage.Surface.Canvas.Font.Color := bcolor;
    SetBkMode (TextOutImage.Surface.Canvas.Handle, TRANSPARENT);
    TextOutImage.Surface.Canvas.TextOut (0, 1, str);
    TextOutImage.Surface.Canvas.TextOut (2, 1, str);
    TextOutImage.Surface.Canvas.TextOut (1, 0, str);
    TextOutImage.Surface.Canvas.TextOut (1, 2, str);
    TextOutImage.Surface.Canvas.Font.Color := fcolor;
    TextOutImage.Surface.Canvas.TextOut (1, 1, str);
    TextOutImage.Surface.Canvas.Release;
    TextOutImage.Surface.TransparentColor := 18;
    TextOutImage.Text := str;
    TextOutImage.FColor := fcolor;
    TextOutImage.BColor := bcolor;
    TextOutImage.dwLatestTime := GetTickCount;
    NameTextOutList.Add(TextOutImage);
  end;
  {$I VMProtectEnd.inc}
end;  


//着重显示文字（以bcolor色加文字边框）
procedure BoldTextOut(surface: TDirectDrawSurface; x, y, fcolor, bcolor: Integer; str:string);
  procedure FreeBoldOldMemorys();
  var
    I: Integer;
  begin
    for I:=BoldTextOutList.Count-1 downto 0 do begin
      if pTextOutImage(BoldTextOutList[I]) <> nil then begin
        if GetTickCount - pTextOutImage(BoldTextOutList[I]).dwLatestTime > 30000 then begin
          FreeAndNil(pTextOutImage(BoldTextOutList[I]).Surface);
          Dispose(pTextOutImage(BoldTextOutList[I]));
          BoldTextOutList.Delete(I);
        end;
      end;
    end;
  end;
var
  I: Integer;
  TextOutImage: pTextOutImage;
  wh: TSize;
begin
  {$I VMProtectBegin.inc}
  if BoldTextOutList.Count > 0 then begin
    if GetTickCount - dwBoldMemChecktTick > 10000 then begin
      dwBoldMemChecktTick := GetTickCount;
      FreeBoldOldMemorys;
    end;
    for I:=0 to BoldTextOutList.Count - 1 do begin
      TextOutImage := pTextOutImage(BoldTextOutList[I]);
      if TextOutImage <> nil then begin
        if (str = TextOutImage.Text) and (FColor = TextOutImage.FColor) then begin
          pTextOutImage(BoldTextOutList[I]).dwLatestTime := GetTickCount;
          surface.Draw (x, y, TextOutImage.Surface.ClientRect, TextOutImage.Surface, TRUE);
          Exit;
        end;
      end;
    end;
  end;
  
  if str <> '' then begin
    New(TextOutImage);
    TextOutImage.Surface :=  TDirectDrawSurface.Create (frmMain.DXDraw.DDraw);
    TextOutImage.Surface.SystemMemory := TRUE;
    if (surface.Canvas.Font.Size <> 9) or ((surface.Canvas.Font.Style = [fsBold]){ and  not(fsUnderline in surface.Canvas.Font.Style)}) then begin
      wh := surface.Canvas.TextExtent(str);
      TextOutImage.Surface.SetSize (wh.cx, wh.cy);
    end else begin
      TextOutImage.Surface.SetSize (frmMain.Canvas.TextWidth(str)+2, frmMain.Canvas.TextHeight(str)+2);
    end;
    TextOutImage.Surface.Fill(18);
    TextOutImage.Surface.Canvas.Font := surface.Canvas.Font;
    TextOutImage.Surface.Canvas.Font.Color := bcolor;
    SetBkMode (TextOutImage.Surface.Canvas.Handle, TRANSPARENT);
    TextOutImage.Surface.Canvas.TextOut (0, 1, str);
    TextOutImage.Surface.Canvas.TextOut (2, 1, str);
    TextOutImage.Surface.Canvas.TextOut (1, 0, str);
    TextOutImage.Surface.Canvas.TextOut (1, 2, str);
    TextOutImage.Surface.Canvas.Font.Color := fcolor;
    TextOutImage.Surface.Canvas.TextOut (1, 1, str);
    TextOutImage.Surface.Canvas.Release;
    TextOutImage.Surface.TransparentColor := 18;
    surface.Draw (x, y, TextOutImage.Surface.ClientRect, TextOutImage.Surface, TRUE);
    TextOutImage.Text := str;
    TextOutImage.FColor := fcolor;
    TextOutImage.BColor := bcolor;
    TextOutImage.dwLatestTime := GetTickCount;
    BoldTextOutList.Add(TextOutImage);
  end;
  {$I VMProtectEnd.inc}
end;

procedure TextOut(surface: TDirectDrawSurface; X, Y, Color: Integer; str:string);
  procedure FreeTextOldMemorys();
  var
    I: Integer;
  begin
    for I:=TextOutList.Count-1 downto 0 do begin
      if pTextOutImage(TextOutList[I]) <> nil then begin
        if GetTickCount - pTextOutImage(TextOutList[I]).dwLatestTime > 40000 then begin
          FreeAndNil(pTextOutImage(TextOutList[I]).Surface);
          Dispose(pTextOutImage(TextOutList[I]));
          TextOutList.Delete(I);
        end;
      end;
    end;
  end;
var
  I: Integer;
  TextOutImage: pTextOutImage;
  wh: TSize;
begin
  {$I VMProtectBegin.inc}
  if TextOutList.Count > 0 then begin
    if GetTickCount - dwTextMemChecktTick > 10000 then begin
      dwTextMemChecktTick := GetTickCount;
      FreeTextOldMemorys;
    end;
    for I:=0 to TextOutList.Count - 1 do begin
      TextOutImage := pTextOutImage(TextOutList.Items[I]);
      if TextOutImage <> nil then begin
        if (str = TextOutImage.Text) and (Color = TextOutImage.FColor)then begin
          pTextOutImage(TextOutList.Items[I]).dwLatestTime := GetTickCount;
          surface.Draw (x, y, TextOutImage.Surface.ClientRect, TextOutImage.Surface, True);
          Exit;
        end;
      end;
    end;
  end;
  if str <> '' then begin
    New(TextOutImage);
    TextOutImage.Surface :=  TDirectDrawSurface.Create (frmMain.DXDraw.DDraw);
    TextOutImage.Surface.SystemMemory := TRUE;
    if (surface.Canvas.Font.Size <> 9) or ((surface.Canvas.Font.Style = [fsBold]){ and  not(fsUnderline in surface.Canvas.Font.Style)}) then begin
      wh := surface.Canvas.TextExtent(str);
      TextOutImage.Surface.SetSize (wh.cx, wh.cy);
    end else begin
      TextOutImage.Surface.SetSize (frmMain.Canvas.TextWidth(str), frmMain.Canvas.TextHeight(str));
    end;
    TextOutImage.Surface.Fill(18);
    TextOutImage.Surface.Canvas.Font := surface.Canvas.Font;
    TextOutImage.Surface.Canvas.Font.Color := Color;
    SetBkMode (TextOutImage.Surface.Canvas.Handle, TRANSPARENT);
    TextOutImage.Surface.Canvas.TextOut(0,0,str);
    TextOutImage.Surface.Canvas.Release;
    surface.Draw (x, y, TextOutImage.Surface.ClientRect, TextOutImage.Surface, TRUE);
    TextOutImage.Surface.TransparentColor := 18;
    TextOutImage.Text := str;
    TextOutImage.FColor := Color;
    TextOutImage.dwLatestTime := GetTickCount;
    TextOutList.Add(TextOutImage);
  end;
  {$I VMProtectEnd.inc}
end;

procedure ChatTextOut(surface: TDirectDrawSurface; X, Y, FColor, BColor: Integer; str:string);
  procedure FreeChatOldMemorys();
  var
    I: Integer;
  begin
    for I:=ChatTextOutList.Count-1 downto 0 do begin
      if pTextOutImage(ChatTextOutList[I]) <> nil then begin
        if GetTickCount - pTextOutImage(ChatTextOutList[I]).dwLatestTime > 60000 then begin
          FreeAndNil(pTextOutImage(ChatTextOutList[I]).Surface);
          Dispose(pTextOutImage(ChatTextOutList[I]));
          ChatTextOutList.Delete(I);
        end;
      end;
    end;
  end;
var
  I: Integer;
  TextOutImage: pTextOutImage;
begin
  {$I VMProtectBegin.inc}
  if ChatTextOutList.Count > 0 then begin
    if GetTickCount - dwChatMemChecktTick > 10000 then begin
      dwChatMemChecktTick := GetTickCount;
      FreeChatOldMemorys;
    end;
    for I:=0 to ChatTextOutList.Count - 1 do begin
      TextOutImage := pTextOutImage(ChatTextOutList[I]);
      if TextOutImage <> nil then begin
        if (str = TextOutImage.Text) and (FColor = TextOutImage.FColor) and (BColor = TextOutImage.BColor) then begin
          pTextOutImage(ChatTextOutList[I]).dwLatestTime := GetTickCount;
          surface.Draw (x, y, TextOutImage.Surface.ClientRect, TextOutImage.Surface, False);
          Exit;
        end;
      end;
    end;
  end;
  if str <> '' then begin
    New(TextOutImage);
    TextOutImage.Surface :=  TDirectDrawSurface.Create (frmMain.DXDraw.DDraw);
    TextOutImage.Surface.SystemMemory := TRUE;
    TextOutImage.Surface.SetSize (frmMain.Canvas.TextWidth(str), frmMain.Canvas.TextHeight(str));
    //TextOutImage.Surface.Fill(18);
    TextOutImage.Surface.Canvas.Font := surface.Canvas.Font;
    TextOutImage.Surface.Canvas.Font.Color := FColor;
    TextOutImage.Surface.Canvas.Brush.Color := Bcolor;
    SetBkMode (TextOutImage.Surface.Canvas.Handle, OPAQUE);
    TextOutImage.Surface.Canvas.TextOut(0,0,str);
    TextOutImage.Surface.Canvas.Release;
    surface.Draw (x, y, TextOutImage.Surface.ClientRect, TextOutImage.Surface, False);
    TextOutImage.Text := str;
    TextOutImage.FColor := FColor;
    TextOutImage.BColor := BColor;
    TextOutImage.dwLatestTime := GetTickCount;
    ChatTextOutList.Add(TextOutImage);
   // surface.Draw (x, y, TextOutImage.Surface.ClientRect, TextOutImage.Surface, False);
  end;
  {$I VMProtectEnd.inc}
end;

procedure PixelsOut(surface: TDirectDrawSurface; X, Y, Color, Size: Integer);
  procedure FreePixelsOldMemorys();
  var
    I: Integer;
  begin
    for I:=PixelsOutList.Count-1 downto 0 do begin
      if pTextOutImage(PixelsOutList[I]) <> nil then begin
        if GetTickCount - pTextOutImage(PixelsOutList[I]).dwLatestTime > 80000 then begin
          FreeAndNil(pTextOutImage(PixelsOutList[I]).Surface);
          Dispose(pTextOutImage(PixelsOutList[I]));
          PixelsOutList.Delete(I);
        end;
      end;
    end;
  end;
var
  I: Integer;
  PixelsOutImage: pTextOutImage;
begin
  {$I VMProtectBegin.inc}
  if PixelsOutList.Count > 0 then begin
    if GetTickCount - dwPixelsMemChecktTick > 10000 then begin
      dwPixelsMemChecktTick := GetTickCount;
      FreePixelsOldMemorys;
    end;
    for I:=0 to PixelsOutList.Count - 1 do begin
      PixelsOutImage := pTextOutImage(PixelsOutList.Items[I]);
      if PixelsOutImage <> nil then begin
        if (Size = PixelsOutImage.BColor) and (Color = PixelsOutImage.FColor) then begin
          pTextOutImage(PixelsOutList.Items[I]).dwLatestTime := GetTickCount;
          surface.Draw (x, y, PixelsOutImage.Surface.ClientRect, PixelsOutImage.Surface, False);
          Exit;
        end;
      end;
    end;
  end;
  New(PixelsOutImage);
  PixelsOutImage.Surface :=  TDirectDrawSurface.Create (frmMain.DXDraw.DDraw);
  PixelsOutImage.Surface.SystemMemory := TRUE;
  PixelsOutImage.Surface.SetSize (Size, Size);
  PixelsOutImage.Surface.Fill(Color);
  surface.Draw (x, y, PixelsOutImage.Surface.ClientRect, PixelsOutImage.Surface, False);
  PixelsOutImage.FColor := Color;
  PixelsOutImage.BColor := Size;
  PixelsOutImage.dwLatestTime := GetTickCount;
  PixelsOutList.Add(PixelsOutImage);
  {$I VMProtectEnd.inc}
end;


{$IFEND}

Initialization
  DropItems := TList.Create;
  {$IF Version <> 1}
  TextOutList := TGList.Create;
  BoldTextOutList := TGList.Create;
  NameTextOutList := TGList.Create;
  ChatTextOutList := TGList.Create;
  PixelsOutList := TGList.Create;
  {$IFEND}
Finalization
  DropItems.Free;
  {$IF Version <> 1}
  TextOutList.Free;
  BoldTextOutList.Free;
  NameTextOutList.Free;
  ChatTextOutList.Free;
  PixelsOutList.Free;
  {$IFEND}

end.

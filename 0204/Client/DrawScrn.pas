unit DrawScrn;//DrawScrn,其实更准确地说是DrawScrn-txt,,,,整个场景的实际绘图工作已经在introscrn.pas和playscrn.pas中完成了
//场景管理器
interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, 
  DXDraws, DXClass, IntroScn, Actor, cliUtil, clFunc,
  HUtil32,Grobal2,Dialogs;


const
   VIEWCHATLINE = 9;//9行文本输入框
   AREASTATEICONBASE = 150;//area state icon base Prguse.wil中150战斗151安全
   HEALTHBAR_BLACK = 0;//Prguse3.wil中
   HEALTHBAR_RED = 1; //Prguse3.wil中


type
//走马灯
  PBoardStyle=^TBoardStyle;
  TBoardStyle=Record
     FColor:Integer;
     BColor:Integer;
     Time :Integer;
     Createtime:Integer;
  end;
//走马灯
   TDrawScreen = class
   private
      m_dwFrameTime       :LongWord;
      //m_dwFrameCount      :LongWord;
      //m_dwDrawFrameCount  :LongWord;
      m_SysMsgList        :TStringList;
      m_SysMsgListBottom  :TStringList; //下面提示

       //滚动消息
      m_SysBoard:TStringList;
      m_SysBoardIndex: Integer;
      m_SysBoardxPos :Integer;
      m_SysBoardTime: LongWord;
   public
      CurrentScene: TScene;       //当前场景
      ChatStrs: TStringList;      //聊天内容
      ChatBks: TList;             //对应的背景色
      ChatBoardTop: integer;

      HintList: TStringList;      //提示信息列表
      HintX, HintY, HintWidth, HintHeight: integer;
      HintUp: Boolean;
      HintColor: TColor;

      //聊天栏上面的倒记时变量
      m_boCountDown: Boolean;  //是否显示
      m_SCountDown :string; //显示内容
      m_CountDownForeGroundColor :Integer;
      m_dwCountDownTimeTick :longWord;
      m_dwCountDownTimer :longWord;
      m_dwCountDownTimeTick1 :longWord;
      
      constructor Create;
      destructor Destroy; override;
      procedure KeyPress (var Key: Char);
      procedure KeyDown (var Key: Word; Shift: TShiftState);
      procedure MouseMove (Shift: TShiftState; X, Y: Integer);
      procedure MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      procedure Initialize;
      procedure Finalize;
      procedure ChangeScene (scenetype: TSceneType);
      procedure DrawScreen (MSurface: TDirectDrawSurface);
      procedure DrawScreenTop (MSurface: TDirectDrawSurface);
      procedure AddSysMsg (msg: string);
      procedure AddBottomSysMsg (msg: string);
      procedure AddSysBoard(msg: string;FColor,BColor,Time:Integer);
      procedure AddChatBoardString (str: string; fcolor, bcolor: integer);
      procedure ClearChatBoard;

      procedure ShowHint (x, y: integer; str: string; color: TColor; drawup: Boolean);
      procedure ClearHint;
      procedure DrawScreenBoard(MSurface: TDirectDrawSurface);//走马灯
      procedure AddCenterLetter(ForeGroundColor,BackGroundColor,Timer:Integer;CenterLetter:string);//添加在屏幕中间显示文字消息
      procedure DrawScreenCenterLetter(MSurface: TDirectDrawSurface);//屏幕中间显示文字消息
      procedure AddCountDown(ForeGroundColor:Integer;Timer:LongWord;CountDown:string);//添加在屏幕中间显示文字消息
      procedure DrawScreenCountDown(MSurface: TDirectDrawSurface);//显示聊天栏上面的倒记时
      procedure DrawHint (MSurface: TDirectDrawSurface);
   end;


implementation

uses
   ClMain, MShare, Share;
   

constructor TDrawScreen.Create;
begin
   CurrentScene := nil;
   m_dwFrameTime := GetTickCount;
  // m_dwFrameCount := 0;
   m_SysMsgList := TStringList.Create;
   m_SysMsgListBottom := TStringList.Create;
   m_SysBoard:=TStringList.Create;//初始化走马灯列表
   ChatStrs := TStringList.Create;
   ChatBks := TList.Create;
   //走马灯
   m_SysBoardIndex:=0;
   m_SysBoardxPos:=800;
   //走马灯
   ChatBoardTop := 0;
   HintList := TStringList.Create;

   m_boCountDown := False;  //是否显示
end;

destructor TDrawScreen.Destroy;
begin
   m_SysMsgList.Free;
   m_SysMsgListBottom.Free;
   m_SysBoard.Free;//走马灯列表
   ChatStrs.Free;
   ChatBks.Free;
   HintList.Free;
   inherited Destroy;
end;

procedure TDrawScreen.Initialize;
begin
end;

procedure TDrawScreen.Finalize;
begin
end;

procedure TDrawScreen.KeyPress (var Key: Char);
begin
   if CurrentScene <> nil then
      CurrentScene.KeyPress (Key);
end;

procedure TDrawScreen.KeyDown (var Key: Word; Shift: TShiftState);
begin
   if CurrentScene <> nil then
      CurrentScene.KeyDown (Key, Shift);
end;

procedure TDrawScreen.MouseMove (Shift: TShiftState; X, Y: Integer);
begin
   if CurrentScene <> nil then
      CurrentScene.MouseMove (Shift, X, Y);
end;

procedure TDrawScreen.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if CurrentScene <> nil then
      CurrentScene.MouseDown (Button, Shift, X, Y);
end;

procedure TDrawScreen.ChangeScene (scenetype: TSceneType);
begin
   if CurrentScene <> nil then
      CurrentScene.CloseScene;
   case scenetype of
      stIntro:  CurrentScene := IntroScene;
      stLogin:  CurrentScene := LoginScene;
      stSelectCountry:  ;
      stSelectChr: CurrentScene := SelectChrScene;
      stNewChr:     ;
      stLoading:    ;
      stLoginNotice: CurrentScene := LoginNoticeScene;
      stPlayGame: CurrentScene := PlayScene;
   end;
   if CurrentScene <> nil then
      CurrentScene.OpenScene;
end;
//添加系统信息
procedure TDrawScreen.AddSysMsg (msg: string);
begin
   if m_SysMsgList.Count >= 10 then m_SysMsgList.Delete (0);
   m_SysMsgList.AddObject (msg, TObject(GetTickCount));
end;
//添加下面系统信息
procedure TDrawScreen.AddBottomSysMsg (msg: string);
begin
  if m_SysMsgListBottom.Count >= 10 then m_SysMsgListBottom.Delete (0);
  m_SysMsgListBottom.AddObject(msg, TObject(GetTickCount));
end;

//添加信息到走马灯列表   清清 2007.11.11
procedure TDrawScreen.AddSysBoard(msg: string;FColor,BColor,Time:Integer);
var
  Boardstyle:PBoardStyle;
begin
  if m_SysBoard.Count >= 10 then begin
    Boardstyle:=PBoardStyle(m_SysBoard.Objects[0]);
    DisPose(Boardstyle);
    m_SysBoard.Delete(0);
  end;
  New(Boardstyle);
  Boardstyle^.FColor:=FColor;
  Boardstyle^.BColor:=Bcolor;
  Boardstyle^.Time:=Time;
  Boardstyle^.Createtime:=0;
  m_SysBoard.AddObject(msg, TObject(Boardstyle));
end;
//添加信息聊天板
procedure TDrawScreen.AddChatBoardString (str: string; fcolor, bcolor: integer);
var
   i, len, aline: integer;
   temp: string;
const
   BOXWIDTH = (SCREENWIDTH div 2 - 214) * 2{374}; //41 聊天框文字宽度
begin
   len := Length (str);
   temp := '';
   i := 1;
   while TRUE do begin
      if i > len then break;
      if byte (str[i]) >= 128 then begin
         temp := temp + str[i];
         Inc (i);
         if i <= len then temp := temp + str[i]
         else break;
      end else
         temp := temp + str[i];

      aline := FrmMain.Canvas.TextWidth (temp);
      if aline > BOXWIDTH then begin
         ChatStrs.AddObject (temp, TObject(fcolor));
         ChatBks.Add (Pointer(bcolor));
         str := Copy (str, i+1, Len-i);
         temp := '';
         break;
      end;
      Inc (i);
   end;
   if temp <> '' then begin
      ChatStrs.AddObject (temp, TObject(fcolor));
      ChatBks.Add (Pointer(bcolor));
      str := '';
   end;
   if ChatStrs.Count > 200 then begin
      ChatStrs.Delete (0);
      ChatBks.Delete (0);
      if ChatStrs.Count - ChatBoardTop < VIEWCHATLINE then Dec(ChatBoardTop);
   end else if (ChatStrs.Count-ChatBoardTop) > VIEWCHATLINE then begin
      Inc (ChatBoardTop);
   end;

   if str <> '' then
      AddChatBoardString (' ' + str, fcolor, bcolor);

end;
//鼠标放在某个物品上显示的信息   清清 2007.10.21
procedure TDrawScreen.ShowHint (x, y: integer; str: string; color: TColor; drawup: Boolean);
var
   data: string;
   w: integer;
begin
   ClearHint;
   HintX := x;
   HintY := y;
   HintWidth := 0;
   HintHeight := 0;
   HintUp := drawup;
   HintColor := color;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, ['\']);
      w := FrmMain.Canvas.TextWidth (data) + 4{咯归} * 2;
      if w > HintWidth then HintWidth := w;
      if data <> '' then
         HintList.Add (data)
   end;
   HintHeight := (FrmMain.Canvas.TextHeight('A') + 1) * HintList.Count + 3{咯归} * 2;
   if HintUp then
      HintY := HintY - HintHeight;
end;
//清除鼠标放在某个物品上显示的信息   清清 2007.10.21
procedure TDrawScreen.ClearHint;
begin
   HintList.Clear;
end;

procedure TDrawScreen.ClearChatBoard;
begin
   m_SysMsgList.Clear;
   m_SysMsgListBottom.Clear;
   ChatStrs.Clear;
   ChatBks.Clear;
   ChatBoardTop := 0;
end;


procedure TDrawScreen.DrawScreen (MSurface: TDirectDrawSurface);
   procedure NameTextOut (actor: TActor; surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; namestr: string);
   var
      i, row: integer;
      nstr: string;
      nfcolor: Integer;
   begin
      row := 0;
      for i:=0 to 10 do begin
         if namestr = '' then break;
         namestr := GetValidStr3 (namestr, nstr, ['\']);
         if Pos('(可探索)',nstr) > 0 then nfcolor := $005AC663 else nfcolor := fcolor;
         {$if Version <> 1}
         ClFunc.NameTextOut (surface,
                      x - FrmMain.Canvas.TextWidth(nstr) div 2,
                      y + row * 12,
                      nfcolor, bcolor, nstr);
         {$ELSE}
         BoldTextOut (surface,
                      x - FrmMain.Canvas.TextWidth(nstr) div 2,
                      y + row * 12,
                      nfcolor, bcolor, nstr);
         {$IFEND}
         Inc (row);
      end;
   end;
var
   I, K: integer;
   actor: TActor;
   uname: string;
   d: TDirectDrawSurface;
   rc: TRect;
   infoMsg :String;
   DropItem: PTDropItem;
   ShowItem: pTShowItem;
   mx,my:integer;
begin
   MSurface.Fill(0);
   if CurrentScene <> nil then CurrentScene.PlayScene (MSurface);
   if g_MySelf = nil then Exit;

   if CurrentScene = PlayScene then begin
      with MSurface do begin
         with PlayScene do begin
            //显示物品
            if g_boShowAllItem then begin
             if g_DropedItemList.Count > 0 then begin
               {$if Version = 1}
               SetBkMode (Canvas.Handle, TRANSPARENT);
               {$IFEND}
               for k:=0 to g_DropedItemList.Count-1 do begin
                 DropItem := PTDropItem (g_DropedItemList[k]);
                 if DropItem <> nil then begin
                   if g_boFilterAutoItemShow then begin
                     ShowItem:=GetShowItem(DropItem.Name);//盛大挂查找过滤物品
                     if ((ShowItem <> nil) and (not ShowItem.boShowName)) then  Continue;
                   end;
                   ScreenXYfromMCXY(DropItem.X, DropItem.Y, mx, my);
                   if (abs(g_MySelf.m_nCurrX - DropItem.X) >= 9) or (abs(g_MySelf.m_nCurrY - DropItem.Y) >= 7) then Continue;
                   BoldTextOut(MSurface,
                                 mx - 16,
                                 my - 20,
                                 clSkyBlue,
                                 clBlack,
                                 DropItem.Name);
                 end;
               end;
               {$if Version = 1}
               Canvas.Release;
               {$IFEND}
             end;
            end;
         
            if m_ActorList.Count > 0 then //20080629
            for k:=0 to m_ActorList.Count-1 do begin  //画出每一个人物的状态
               actor := m_ActorList[k];
               //显示人物血量(数字显示)清清
               if (actor.m_Abil.MaxHP > 1) and not actor.m_boDeath then begin
                  if actor = g_HeroSelf then begin   //在次修正英雄资料消失 2008.01.27
                    if (abs(g_MySelf.m_nCurrX - g_HeroSelf.m_nCurrX) <= 8) and (abs(g_MySelf.m_nCurrY - g_HeroSelf.m_nCurrY) <= 7) then begin
                      {$if Version = 1}
                      SetBkMode (Canvas.Handle, TRANSPARENT);
                      {$IFEND}
                      InfoMsg:=IntToStr(actor.m_Abil.HP) + '/' + IntToStr(actor.m_Abil.MaxHP);
                      BoldTextOut (MSurface,{actor.m_nSayX - 15}actor.m_nSayX - FrmMain.Canvas.TextWidth(infoMsg) div 2 ,actor.m_nSayY - 22,clWhite, clBlack,infoMsg );
                      Canvas.Release;
                    end;
                  end else begin
                    if (actor.m_btRace <> 50) and (abs(g_MySelf.m_nCurrX - Actor.m_nCurrX) <= 8) and (abs(g_MySelf.m_nCurrY - Actor.m_nCurrY) <= 7) then begin  //NPC不数字显血 20080410
                      {$if Version = 1}
                      SetBkMode (Canvas.Handle, TRANSPARENT);
                      {$IFEND}
                      InfoMsg:=IntToStr(actor.m_Abil.HP) + '/' + IntToStr(actor.m_Abil.MaxHP);
                      BoldTextOut (MSurface,{actor.m_nSayX - 15}actor.m_nSayX - FrmMain.Canvas.TextWidth(infoMsg) div 2 ,actor.m_nSayY - 22,clWhite, clBlack,infoMsg );
                      Canvas.Release;
                    end;
                  end;
               end;
               
              //显示血条  清清
               if not actor.m_boDeath and ((abs(g_MySelf.m_nCurrX - Actor.m_nCurrX) <= 8) and (abs(g_MySelf.m_nCurrY - Actor.m_nCurrY) <= 7)) then  begin
                    if (actor.m_btRace = 50) and   //某些NPC 不显示血条 20080323
                          ((actor.m_wAppearance in [35..40,48..50,54..58,62,65..66,70..75,82..84,90..92]) or (TNpcActor(actor).g_boNpcWalk) ) then Continue;
                    if actor.m_btRace = 95 then Continue; //火龙守护兽
                    if actor.m_noInstanceOpenHealth then
                       if GetTickCount - actor.m_dwOpenHealthStart > actor.m_dwOpenHealthTime then
                          actor.m_noInstanceOpenHealth := FALSE;
                    d := g_WMain3Images.Images[HEALTHBAR_BLACK];
                    if d <> nil then begin
                       MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 10, d.ClientRect, d, TRUE);
                       //内功黄条背景
                       if actor.m_Skill69MaxNH > 0 then begin
                          MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 7, d.ClientRect, d, TRUE);
                       end;
                    end;
                    if actor.m_btRace in [12,24,50] then //大刀，带刀，NPC
                       d := g_qingqingImages.Images[0]
                    else d := g_WMain3Images.Images[HEALTHBAR_RED];
                    if d <> nil then begin
                       rc := d.ClientRect;
                       if actor.m_Abil.MaxHP > 0 then
                          rc.Right := Round((rc.Right-rc.Left) / actor.m_Abil.MaxHP * actor.m_Abil.HP);
                       MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 10, rc, d, TRUE);
                    end;
                    //内功黄条
                    if actor.m_Skill69MaxNH > 0 then begin
                      d := g_qingqingImages.Images[9];
                      if d <> nil then begin
                        rc := d.ClientRect;
                        rc.Right := Round((rc.Right-rc.Left) / actor.m_Skill69MaxNH * actor.m_Skill69NH);
                          MSurface.Draw(actor.m_nSayX - d.Width div 2, actor.m_nSayY - 7, rc, d, False);
                      end;
                    end;
                  //end;
               end;
            end;
         end;

       //自动显示名称  清清  2007.12.18
        {$if Version = 1}
        SetBkMode (Canvas.Handle, TRANSPARENT);
        {$IFEND}
        if g_boShowName then begin
          with PlayScene do begin
            for k := 0 to m_ActorList.Count - 1 do begin
              Actor := m_ActorList[k];
              if (Actor <> nil)  and (not Actor.m_boDeath) and
                (Actor.m_nSayX <> 0) and (Actor.m_nSayY <> 0)  and ((actor.m_btRace = 0) or (actor.m_btRace = 1) or (actor.m_btRace = 150) or (actor.m_btRace = 50){人类,英雄,人型20080629}) then begin
                  if (Actor <> g_FocusCret) then begin
                    if (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) >= 9) or (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) >= 7) then Continue;
                    //if ((actor.m_btRace = 50) and (TNpcActor(actor).g_boNpcWalk)) then  Continue;  //2080621
                                        if (actor.m_btRace = 50) and   //某些NPC 不显示血条 20080323
                          ((actor.m_wAppearance in [35..40,48..50,62,65..66,70..75,82..84,90..92]) or (TNpcActor(actor).g_boNpcWalk) ) then Continue;
                    if (actor = g_MySelf) and g_boSelectMyself then Continue;
                      uname := Actor.m_sUserName;
                      NameTextOut(Actor, MSurface,
                        Actor.m_nSayX, // - Canvas.TextWidth(uname) div 2,
                        Actor.m_nSayY + 30,
                        Actor.m_nNameColor, ClBlack,
                        uname);
                  end;
                end;
            end;
          end;
        end; //with
        Canvas.Release;
         //自动显示名称  结束

         //画当前选择的物品/人物的名字
         {$if Version = 1}
         SetBkMode (Canvas.Handle, TRANSPARENT);
         {$IFEND}
         if ((g_FocusCret <> nil) and PlayScene.IsValidActor (g_FocusCret)) then begin
            if (g_FocusCret.m_btRace = 50) then begin
              if not TNpcActor(g_FocusCret).g_boNpcWalk then begin
                uname := g_FocusCret.m_sDescUserName + '\' + g_FocusCret.m_sUserName;
                NameTextOut (g_FocusCret, MSurface,
                          g_FocusCret.m_nSayX,
                          g_FocusCret.m_nSayY + 30,
                          g_FocusCret.m_nNameColor, clBlack,
                          uname);
              end;
            end else begin
                uname := g_FocusCret.m_sDescUserName + '\' + g_FocusCret.m_sUserName;
                NameTextOut (g_FocusCret, MSurface,
                          g_FocusCret.m_nSayX,
                          g_FocusCret.m_nSayY + 30,
                          g_FocusCret.m_nNameColor, clBlack,
                          uname);
            end;
         end;

         //玩家名称
         if g_boSelectMyself then begin
            uname := g_MySelf.m_sDescUserName + '\' + g_MySelf.m_sUserName;
            NameTextOut (g_MySelf, MSurface,
                      g_MySelf.m_nSayX, // - Canvas.TextWidth(uname) div 2,
                      g_MySelf.m_nSayY + 30,
                      g_MySelf.m_nNameColor, clBlack,
                      uname);
         end;

         //显示角色说话文字
         with PlayScene do begin
            if m_ActorList.Count > 0 then begin//20080629
              for k:=0 to m_ActorList.Count-1 do begin
                actor := m_ActorList[k];
                if (actor.m_SayingArr[0] <> '') and (GetTickCount - actor.m_dwSayTime < 4 * 1000) then begin
                   if actor.m_nSayLineCount > 0 then begin//20080629
                     for i:=0 to actor.m_nSayLineCount - 1 do //显示每个玩家说的话
                        if actor.m_boDeath then              //死了的话就灰/黑色显示
                           BoldTextOut (MSurface,
                                     actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                     actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 - 20,
                                     clGray, clBlack,
                                     actor.m_SayingArr[i])
                        else                         //正常的玩家用黑/白色显示
                           BoldTextOut (MSurface,
                                     actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                     actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 - 20,
                                     clWhite, clBlack,
                                     actor.m_SayingArr[i]);
                   end;
                end else actor.m_SayingArr[0] := '';  //说的话显示4秒
              end;
            end;
         end;


         //System Message
         if (g_nAreaStateValue and $04) <> 0 then begin
            BoldTextOut (MSurface, 0, 0, clWhite, clBlack, '攻城区域');
         end;
         Canvas.Release;


         //显示地图状态，16种：0000000000000000 从右到左，为1表示：战斗、安全、上面的那种状态 (当前只有这几种状态)
         {k := 0;
         for i:=0 to 15 do begin
            if g_nAreaStateValue and ($01 shr i) <> 0 then begin
               d := g_WMainImages.Images[AREASTATEICONBASE + i];
               if d <> nil then begin
                  k := k + d.Width;
                  MSurface.Draw (SCREENWIDTH-k, 0, d.ClientRect, d, TRUE);
               end;
            end;
         end; }
         k := 0;
         if g_nAreaStateValue <> 0 then begin
             d := g_WMainImages.Images[AREASTATEICONBASE + g_nAreaStateValue - 1];
             if d <> nil then begin
                k := k + d.Width;
                MSurface.Draw (SCREENWIDTH-k, 0, d.ClientRect, d, TRUE);
             end;
         end;

        DrawScreenCenterLetter(MSurface); //在屏幕中间显示
        DrawScreenCountDown(MSurface); //在聊天栏上面显示倒记时消息
        DrawScreenBoard(MSurface);//滚动公告显示
      end;
   end;
end;
//显示左上角信息文字
procedure TDrawScreen.DrawScreenTop (MSurface: TDirectDrawSurface);
var
   i, sx, sy: integer;
begin
   if g_MySelf = nil then Exit;

   if CurrentScene = PlayScene then begin
      with MSurface do begin
         {$if Version = 1}
         SetBkMode (Canvas.Handle, TRANSPARENT);
         {$IFEND}
         if m_SysMsgList.Count > 0 then begin
            sx := 30;
            sy := 40;
            for i:=0 to m_SysMsgList.Count-1 do begin
               BoldTextOut (MSurface, sx, sy, clGreen, clBlack, m_SysMsgList[i]);
               inc (sy, 16);
            end;
            //3秒减少一个系统消息
            if GetTickCount - longword(m_SysMsgList.Objects[0]) >= 3000 then
               m_SysMsgList.Delete (0);
         end;
         Canvas.Release;
         {$if Version = 1}
         SetBkMode (Canvas.Handle, TRANSPARENT);
         {$IFEND}
         if m_SysMsgListBottom.Count > 0 then begin
            sx := 15;
            sy := 386;
            for i:=0 to m_SysMsgListBottom.Count-1 do begin
               BoldTextOut (MSurface, sx, sy, clRed, clBlack, m_SysMsgListBottom[i]);
               Dec (sy, 16);
            end;
            //3秒减少一个系统消息
            if GetTickCount - longword(m_SysMsgListBottom.Objects[0]) >= 3000 then
               m_SysMsgListBottom.Delete (0);
         end;
         Canvas.Release;
      end;
   end;
end;

function _Copy(str:String;Index,COunt:Integer):String;
var
  s:WideString;
Begin
  s:=WideString(str);
  Result:=Copy(s,index,count);
End;
(*******************************************************************************
  作用 :  添加在屏幕中间显示文字消息
  过程 :  AddCenterLetter(ForeGroundColor,BackGroundColor:Integer;CenterLetter:string);
  参数 :  ForeGroundColor前景色;BackGroundColor背景色;CenterLetter显示文字
*******************************************************************************)
procedure TDrawScreen.AddCenterLetter(ForeGroundColor,BackGroundColor,Timer:Integer; CenterLetter:string);
begin
  m_boCenTerLetter := True;
  m_SCenterLetter := CenterLetter;
  m_CenterLetterForeGroundColor := ForeGroundColor;
  m_CenterLetterBackGroundColor := BackGroundColor;
  m_dwCenterLetterTimeTick := GetTickCount;
  m_nCenterLetterTimer := Timer;
end;
(*******************************************************************************
  作用 :  在屏幕中间显示文字消息
  过程 :  DrawScreenCenterLetter(MSurface: TDirectDrawSurface)
  参数 :  MSurface 为画板
*******************************************************************************)
procedure TDrawScreen.DrawScreenCenterLetter(MSurface: TDirectDrawSurface);
var
    nTextWidth, nTextHeight: Integer;
begin
  if m_boCenTerLetter then begin
    if CurrentScene = PlayScene then begin//如果为游戏画面页
      with MSurface.Canvas do begin
          {$if Version = 1}
          SetBkMode(handle, TRANSPARENT);
          {$IFEND}
          Font.Size := 18;
          nTextWidth := MSurface.Canvas.TextExtent(m_SCenterLetter).cx;
          nTextHeight := MSurface.Canvas.TextExtent(m_SCenterLetter).cy;
          Release;
          BoldTextOut (MSurface, SCREENWIDTH Div 2 - nTextWidth div 2,
                                 SCREENHEIGHT Div 2 - 100 - nTextHeight div 2,
                                 GetRGB(m_CenterLetterForeGroundColor), GetRGB(m_CenterLetterBackGroundColor), m_SCenterLetter);
          Font.Size := 9;
          Release;
      end;
    end;
  end;
    if GetTickCount - m_dwCenterLetterTimeTick > m_nCenterLetterTimer*1000 then begin
      m_dwCenterLetterTimeTick := GetTickCount;
      m_boCenTerLetter := False;
    end;
end;

//跑马灯 滚动信息
procedure TDrawScreen.DrawScreenBoard(MSurface: TDirectDrawSurface);
var
  sx,xpos: Integer;
  Boardstyle:PBoardStyle;
  Str:String;
  Len:Integer;
begin
  if (g_MySelf = nil) or (m_SysBoard.Count = 0) then Exit;
  if CurrentScene = PlayScene then begin//如果为游戏画面页
    with MSurface do begin
      //{$if Version = 1}
      SetBkMode(Canvas.handle, TRANSPARENT);
      //{$IFEND}
      if m_SysBoard.Count > 0 then begin //如果走马灯的列表不为0
        xpos:=1;
        if m_SysBoardIndex>=m_SysBoard.Count then begin
           m_SysBoardIndex:=0;
          // Inc(m_SysBoardCount);
          m_SysBoard.Clear;
        end;
        if m_SysBoard.Count > 0 then begin //20080802
          if PBoardStyle(m_SysBoard.Objects[m_SysBoardIndex]) <> nil then begin
            Boardstyle:=PBoardStyle(m_SysBoard.Objects[m_SysBoardIndex]);
            Len:=(804-m_SysBoardXPos) div Canvas.TextWidth('a')+1;   //长度
            if m_SysBoardXPos<=-150 then begin
              Xpos:=(-150-m_sysBoardXpos) div Canvas.TextWidth('a')+1;
              Len:=Len-Xpos-1;
            end;
            Str:=m_SysBoard[m_SysBoardIndex];
            Str:=_Copy(Str,Xpos,len);
            if (Str='') or(Xpos>Length(m_SysBoard[m_SysBoardIndex])) then begin
             { if m_SysBoardIndex<m_SysBoard.Count then
              Begin
                Boardstyle:=PBoardStyle(m_SysBoard.Objects[m_SysBoardIndex]);
                Inc(Boardstyle^.Createtime);
              End; }
              m_SysBoardXPos:=800;
              Inc(m_SysBoardIndex);
            end;
            //sx:=Max(200,m_SysBoardXPos);
            sx := Max(-150,m_SysBoardXPos+1);
            BoldTextOut1(MSurface,sx,15,GetRGB(Boardstyle.FColor),GetRGB(Boardstyle.BColor),str);
           { if (Boardstyle^.Createtime >= Boardstyle^.Time)and(Boardstyle^.Time>0) then
              m_SysBoard.Delete(m_SysBoardIndex);   }
          if GetTickCount-m_SysBoardTime>100 then begin
             Dec(m_SysBoardXPos,2);
             m_SysBoardTime:=GetTickCount;
          end;
           Canvas.Release;
        end;
      end;
    end;
    end;
  end;
end;
//显示提示信息
procedure TDrawScreen.DrawHint (MSurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   i, hx, hy: integer;
begin
  //显示提示框
   hx:=0;
   hy:=0;//Jacky
   if HintList.Count > 0 then begin
     d := g_WMainImages.Images[394];
     if d <> nil then begin
       if HintWidth > d.Width then HintWidth := d.Width;
       if HintHeight > d.Height then HintHeight := d.Height;
       if HintX + HintWidth > SCREENWIDTH then hx := SCREENWIDTH - HintWidth
       else hx := HintX;
       if HintY < 0 then hy := 0
       else hy := HintY;
       if hx < 0 then hx := 0;
       DrawBlendEx(MSurface, hx, hy, d, 0, 0, HintWidth, HintHeight, 0);
     end;
   end; 
   {$IF Version = 1}
   //在提示框中显示提示信息
   with MSurface do begin
      SetBkMode (Canvas.Handle, TRANSPARENT);
      if HintList.Count > 0 then begin
         Canvas.Font.Color := HintColor;
         for i:=0 to HintList.Count-1 do begin
            Canvas.TextOut (hx+4, hy+3+(Canvas.TextHeight('A')+1)*i, HintList[i]);
         end;
      end;
      if g_MySelf <> nil then begin
         BoldTextOut (MSurface, 8, SCREENHEIGHT-16, clWhite, clBlack, g_sMapTitle + ' ' + IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY));
      end;
      Canvas.Release;
   end;
   {$ELSE}
   //在提示框中显示提示信息
   with MSurface do begin
      if HintList.Count > 0 then begin
         for i:=0 to HintList.Count-1 do begin
            clFunc.TextOut(MSurface, hx+4, hy+3+(FrmMain.Canvas.TextHeight('A')+1)*i, HintColor, HintList[i]);
            Canvas.Release;
         end;
      end;
      if g_MySelf <> nil then begin
         BoldTextOut (MSurface, 8, SCREENHEIGHT-16, clWhite, clBlack, g_sMapTitle + ' ' + IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY));
         Canvas.Release;
      end;
   end;
   {$IFEND} 
end;

(*******************************************************************************
  作用 :  在聊天栏上面显示倒记时文字消息
  过程 :  DrawScreenCountDown(MSurface: TDirectDrawSurface)
  参数 :  MSurface 为画板
*******************************************************************************)
procedure TDrawScreen.DrawScreenCountDown(MSurface: TDirectDrawSurface);
var
  line1,Str: string;
begin
  if m_boCountDown then begin  
    if CurrentScene = PlayScene then begin//如果为游戏画面页
      if m_dwCountDownTimer >= 60 then begin
        line1 := Inttostr(m_dwCountDownTimer div 60)+'分'+IntToStr(m_dwCountDownTimer mod 60)+'秒';
      end else begin
        line1 := IntToStr(m_dwCountDownTimer mod 60)+'秒';
      end;
      Str := Format(m_SCountDown,[line1]);
      with MSurface.Canvas do begin
          {$if Version = 1}
          SetBkMode(handle, TRANSPARENT);
          {$IFEND}
          BoldTextOut (MSurface, SCREENWIDTH Div 2 - FrmMain.Canvas.TextWidth(Str) div 2,
                                 SCREENHEIGHT - 210 - FrmMain.Canvas.TextHeight(Str) div 2,
                                 GetRGB(m_CountDownForeGroundColor), clBlack, Str);
          Release;
      end;
    end;
  end;
end;

procedure TDrawScreen.AddCountDown(ForeGroundColor: Integer;
  Timer: LongWord; CountDown: string);
begin
  m_boCountDown := True;
  m_SCountDown := CountDown;
  m_CountDownForeGroundColor := ForeGroundColor;
  m_dwCountDownTimeTick := GetTickCount;
  m_dwCountDownTimeTick1 := GetTickCount;
  m_dwCountDownTimer := Timer;
  frmMain.CountDownTimer.Enabled := True;
end;

end.

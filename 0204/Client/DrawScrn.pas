unit DrawScrn;//DrawScrn,��ʵ��׼ȷ��˵��DrawScrn-txt,,,,����������ʵ�ʻ�ͼ�����Ѿ���introscrn.pas��playscrn.pas�������
//����������
interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, 
  DXDraws, DXClass, IntroScn, Actor, cliUtil, clFunc,
  HUtil32,Grobal2,Dialogs;


const
   VIEWCHATLINE = 9;//9���ı������
   AREASTATEICONBASE = 150;//area state icon base Prguse.wil��150ս��151��ȫ
   HEALTHBAR_BLACK = 0;//Prguse3.wil��
   HEALTHBAR_RED = 1; //Prguse3.wil��


type
//�����
  PBoardStyle=^TBoardStyle;
  TBoardStyle=Record
     FColor:Integer;
     BColor:Integer;
     Time :Integer;
     Createtime:Integer;
  end;
//�����
   TDrawScreen = class
   private
      m_dwFrameTime       :LongWord;
      //m_dwFrameCount      :LongWord;
      //m_dwDrawFrameCount  :LongWord;
      m_SysMsgList        :TStringList;
      m_SysMsgListBottom  :TStringList; //������ʾ

       //������Ϣ
      m_SysBoard:TStringList;
      m_SysBoardIndex: Integer;
      m_SysBoardxPos :Integer;
      m_SysBoardTime: LongWord;
   public
      CurrentScene: TScene;       //��ǰ����
      ChatStrs: TStringList;      //��������
      ChatBks: TList;             //��Ӧ�ı���ɫ
      ChatBoardTop: integer;

      HintList: TStringList;      //��ʾ��Ϣ�б�
      HintX, HintY, HintWidth, HintHeight: integer;
      HintUp: Boolean;
      HintColor: TColor;

      //����������ĵ���ʱ����
      m_boCountDown: Boolean;  //�Ƿ���ʾ
      m_SCountDown :string; //��ʾ����
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
      procedure DrawScreenBoard(MSurface: TDirectDrawSurface);//�����
      procedure AddCenterLetter(ForeGroundColor,BackGroundColor,Timer:Integer;CenterLetter:string);//�������Ļ�м���ʾ������Ϣ
      procedure DrawScreenCenterLetter(MSurface: TDirectDrawSurface);//��Ļ�м���ʾ������Ϣ
      procedure AddCountDown(ForeGroundColor:Integer;Timer:LongWord;CountDown:string);//�������Ļ�м���ʾ������Ϣ
      procedure DrawScreenCountDown(MSurface: TDirectDrawSurface);//��ʾ����������ĵ���ʱ
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
   m_SysBoard:=TStringList.Create;//��ʼ��������б�
   ChatStrs := TStringList.Create;
   ChatBks := TList.Create;
   //�����
   m_SysBoardIndex:=0;
   m_SysBoardxPos:=800;
   //�����
   ChatBoardTop := 0;
   HintList := TStringList.Create;

   m_boCountDown := False;  //�Ƿ���ʾ
end;

destructor TDrawScreen.Destroy;
begin
   m_SysMsgList.Free;
   m_SysMsgListBottom.Free;
   m_SysBoard.Free;//������б�
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
//���ϵͳ��Ϣ
procedure TDrawScreen.AddSysMsg (msg: string);
begin
   if m_SysMsgList.Count >= 10 then m_SysMsgList.Delete (0);
   m_SysMsgList.AddObject (msg, TObject(GetTickCount));
end;
//�������ϵͳ��Ϣ
procedure TDrawScreen.AddBottomSysMsg (msg: string);
begin
  if m_SysMsgListBottom.Count >= 10 then m_SysMsgListBottom.Delete (0);
  m_SysMsgListBottom.AddObject(msg, TObject(GetTickCount));
end;

//�����Ϣ��������б�   ���� 2007.11.11
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
//�����Ϣ�����
procedure TDrawScreen.AddChatBoardString (str: string; fcolor, bcolor: integer);
var
   i, len, aline: integer;
   temp: string;
const
   BOXWIDTH = (SCREENWIDTH div 2 - 214) * 2{374}; //41 ��������ֿ��
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
//������ĳ����Ʒ����ʾ����Ϣ   ���� 2007.10.21
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
      w := FrmMain.Canvas.TextWidth (data) + 4{����} * 2;
      if w > HintWidth then HintWidth := w;
      if data <> '' then
         HintList.Add (data)
   end;
   HintHeight := (FrmMain.Canvas.TextHeight('A') + 1) * HintList.Count + 3{����} * 2;
   if HintUp then
      HintY := HintY - HintHeight;
end;
//���������ĳ����Ʒ����ʾ����Ϣ   ���� 2007.10.21
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
         if Pos('(��̽��)',nstr) > 0 then nfcolor := $005AC663 else nfcolor := fcolor;
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
            //��ʾ��Ʒ
            if g_boShowAllItem then begin
             if g_DropedItemList.Count > 0 then begin
               {$if Version = 1}
               SetBkMode (Canvas.Handle, TRANSPARENT);
               {$IFEND}
               for k:=0 to g_DropedItemList.Count-1 do begin
                 DropItem := PTDropItem (g_DropedItemList[k]);
                 if DropItem <> nil then begin
                   if g_boFilterAutoItemShow then begin
                     ShowItem:=GetShowItem(DropItem.Name);//ʢ��Ҳ��ҹ�����Ʒ
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
            for k:=0 to m_ActorList.Count-1 do begin  //����ÿһ�������״̬
               actor := m_ActorList[k];
               //��ʾ����Ѫ��(������ʾ)����
               if (actor.m_Abil.MaxHP > 1) and not actor.m_boDeath then begin
                  if actor = g_HeroSelf then begin   //�ڴ�����Ӣ��������ʧ 2008.01.27
                    if (abs(g_MySelf.m_nCurrX - g_HeroSelf.m_nCurrX) <= 8) and (abs(g_MySelf.m_nCurrY - g_HeroSelf.m_nCurrY) <= 7) then begin
                      {$if Version = 1}
                      SetBkMode (Canvas.Handle, TRANSPARENT);
                      {$IFEND}
                      InfoMsg:=IntToStr(actor.m_Abil.HP) + '/' + IntToStr(actor.m_Abil.MaxHP);
                      BoldTextOut (MSurface,{actor.m_nSayX - 15}actor.m_nSayX - FrmMain.Canvas.TextWidth(infoMsg) div 2 ,actor.m_nSayY - 22,clWhite, clBlack,infoMsg );
                      Canvas.Release;
                    end;
                  end else begin
                    if (actor.m_btRace <> 50) and (abs(g_MySelf.m_nCurrX - Actor.m_nCurrX) <= 8) and (abs(g_MySelf.m_nCurrY - Actor.m_nCurrY) <= 7) then begin  //NPC��������Ѫ 20080410
                      {$if Version = 1}
                      SetBkMode (Canvas.Handle, TRANSPARENT);
                      {$IFEND}
                      InfoMsg:=IntToStr(actor.m_Abil.HP) + '/' + IntToStr(actor.m_Abil.MaxHP);
                      BoldTextOut (MSurface,{actor.m_nSayX - 15}actor.m_nSayX - FrmMain.Canvas.TextWidth(infoMsg) div 2 ,actor.m_nSayY - 22,clWhite, clBlack,infoMsg );
                      Canvas.Release;
                    end;
                  end;
               end;
               
              //��ʾѪ��  ����
               if not actor.m_boDeath and ((abs(g_MySelf.m_nCurrX - Actor.m_nCurrX) <= 8) and (abs(g_MySelf.m_nCurrY - Actor.m_nCurrY) <= 7)) then  begin
                    if (actor.m_btRace = 50) and   //ĳЩNPC ����ʾѪ�� 20080323
                          ((actor.m_wAppearance in [35..40,48..50,54..58,62,65..66,70..75,82..84,90..92]) or (TNpcActor(actor).g_boNpcWalk) ) then Continue;
                    if actor.m_btRace = 95 then Continue; //�����ػ���
                    if actor.m_noInstanceOpenHealth then
                       if GetTickCount - actor.m_dwOpenHealthStart > actor.m_dwOpenHealthTime then
                          actor.m_noInstanceOpenHealth := FALSE;
                    d := g_WMain3Images.Images[HEALTHBAR_BLACK];
                    if d <> nil then begin
                       MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 10, d.ClientRect, d, TRUE);
                       //�ڹ���������
                       if actor.m_Skill69MaxNH > 0 then begin
                          MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 7, d.ClientRect, d, TRUE);
                       end;
                    end;
                    if actor.m_btRace in [12,24,50] then //�󵶣�������NPC
                       d := g_qingqingImages.Images[0]
                    else d := g_WMain3Images.Images[HEALTHBAR_RED];
                    if d <> nil then begin
                       rc := d.ClientRect;
                       if actor.m_Abil.MaxHP > 0 then
                          rc.Right := Round((rc.Right-rc.Left) / actor.m_Abil.MaxHP * actor.m_Abil.HP);
                       MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 10, rc, d, TRUE);
                    end;
                    //�ڹ�����
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

       //�Զ���ʾ����  ����  2007.12.18
        {$if Version = 1}
        SetBkMode (Canvas.Handle, TRANSPARENT);
        {$IFEND}
        if g_boShowName then begin
          with PlayScene do begin
            for k := 0 to m_ActorList.Count - 1 do begin
              Actor := m_ActorList[k];
              if (Actor <> nil)  and (not Actor.m_boDeath) and
                (Actor.m_nSayX <> 0) and (Actor.m_nSayY <> 0)  and ((actor.m_btRace = 0) or (actor.m_btRace = 1) or (actor.m_btRace = 150) or (actor.m_btRace = 50){����,Ӣ��,����20080629}) then begin
                  if (Actor <> g_FocusCret) then begin
                    if (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) >= 9) or (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) >= 7) then Continue;
                    //if ((actor.m_btRace = 50) and (TNpcActor(actor).g_boNpcWalk)) then  Continue;  //2080621
                                        if (actor.m_btRace = 50) and   //ĳЩNPC ����ʾѪ�� 20080323
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
         //�Զ���ʾ����  ����

         //����ǰѡ�����Ʒ/���������
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

         //�������
         if g_boSelectMyself then begin
            uname := g_MySelf.m_sDescUserName + '\' + g_MySelf.m_sUserName;
            NameTextOut (g_MySelf, MSurface,
                      g_MySelf.m_nSayX, // - Canvas.TextWidth(uname) div 2,
                      g_MySelf.m_nSayY + 30,
                      g_MySelf.m_nNameColor, clBlack,
                      uname);
         end;

         //��ʾ��ɫ˵������
         with PlayScene do begin
            if m_ActorList.Count > 0 then begin//20080629
              for k:=0 to m_ActorList.Count-1 do begin
                actor := m_ActorList[k];
                if (actor.m_SayingArr[0] <> '') and (GetTickCount - actor.m_dwSayTime < 4 * 1000) then begin
                   if actor.m_nSayLineCount > 0 then begin//20080629
                     for i:=0 to actor.m_nSayLineCount - 1 do //��ʾÿ�����˵�Ļ�
                        if actor.m_boDeath then              //���˵Ļ��ͻ�/��ɫ��ʾ
                           BoldTextOut (MSurface,
                                     actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                     actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 - 20,
                                     clGray, clBlack,
                                     actor.m_SayingArr[i])
                        else                         //����������ú�/��ɫ��ʾ
                           BoldTextOut (MSurface,
                                     actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                     actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 - 20,
                                     clWhite, clBlack,
                                     actor.m_SayingArr[i]);
                   end;
                end else actor.m_SayingArr[0] := '';  //˵�Ļ���ʾ4��
              end;
            end;
         end;


         //System Message
         if (g_nAreaStateValue and $04) <> 0 then begin
            BoldTextOut (MSurface, 0, 0, clWhite, clBlack, '��������');
         end;
         Canvas.Release;


         //��ʾ��ͼ״̬��16�֣�0000000000000000 ���ҵ���Ϊ1��ʾ��ս������ȫ�����������״̬ (��ǰֻ���⼸��״̬)
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

        DrawScreenCenterLetter(MSurface); //����Ļ�м���ʾ
        DrawScreenCountDown(MSurface); //��������������ʾ����ʱ��Ϣ
        DrawScreenBoard(MSurface);//����������ʾ
      end;
   end;
end;
//��ʾ���Ͻ���Ϣ����
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
            //3�����һ��ϵͳ��Ϣ
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
            //3�����һ��ϵͳ��Ϣ
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
  ���� :  �������Ļ�м���ʾ������Ϣ
  ���� :  AddCenterLetter(ForeGroundColor,BackGroundColor:Integer;CenterLetter:string);
  ���� :  ForeGroundColorǰ��ɫ;BackGroundColor����ɫ;CenterLetter��ʾ����
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
  ���� :  ����Ļ�м���ʾ������Ϣ
  ���� :  DrawScreenCenterLetter(MSurface: TDirectDrawSurface)
  ���� :  MSurface Ϊ����
*******************************************************************************)
procedure TDrawScreen.DrawScreenCenterLetter(MSurface: TDirectDrawSurface);
var
    nTextWidth, nTextHeight: Integer;
begin
  if m_boCenTerLetter then begin
    if CurrentScene = PlayScene then begin//���Ϊ��Ϸ����ҳ
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

//����� ������Ϣ
procedure TDrawScreen.DrawScreenBoard(MSurface: TDirectDrawSurface);
var
  sx,xpos: Integer;
  Boardstyle:PBoardStyle;
  Str:String;
  Len:Integer;
begin
  if (g_MySelf = nil) or (m_SysBoard.Count = 0) then Exit;
  if CurrentScene = PlayScene then begin//���Ϊ��Ϸ����ҳ
    with MSurface do begin
      //{$if Version = 1}
      SetBkMode(Canvas.handle, TRANSPARENT);
      //{$IFEND}
      if m_SysBoard.Count > 0 then begin //�������Ƶ��б�Ϊ0
        xpos:=1;
        if m_SysBoardIndex>=m_SysBoard.Count then begin
           m_SysBoardIndex:=0;
          // Inc(m_SysBoardCount);
          m_SysBoard.Clear;
        end;
        if m_SysBoard.Count > 0 then begin //20080802
          if PBoardStyle(m_SysBoard.Objects[m_SysBoardIndex]) <> nil then begin
            Boardstyle:=PBoardStyle(m_SysBoard.Objects[m_SysBoardIndex]);
            Len:=(804-m_SysBoardXPos) div Canvas.TextWidth('a')+1;   //����
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
//��ʾ��ʾ��Ϣ
procedure TDrawScreen.DrawHint (MSurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   i, hx, hy: integer;
begin
  //��ʾ��ʾ��
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
   //����ʾ������ʾ��ʾ��Ϣ
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
   //����ʾ������ʾ��ʾ��Ϣ
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
  ���� :  ��������������ʾ����ʱ������Ϣ
  ���� :  DrawScreenCountDown(MSurface: TDirectDrawSurface)
  ���� :  MSurface Ϊ����
*******************************************************************************)
procedure TDrawScreen.DrawScreenCountDown(MSurface: TDirectDrawSurface);
var
  line1,Str: string;
begin
  if m_boCountDown then begin  
    if CurrentScene = PlayScene then begin//���Ϊ��Ϸ����ҳ
      if m_dwCountDownTimer >= 60 then begin
        line1 := Inttostr(m_dwCountDownTimer div 60)+'��'+IntToStr(m_dwCountDownTimer mod 60)+'��';
      end else begin
        line1 := IntToStr(m_dwCountDownTimer mod 60)+'��';
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

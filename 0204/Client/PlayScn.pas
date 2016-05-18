unit PlayScn;
//��Ϸ������
interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, 
  DXDraws, IntroScn, Grobal2, CliUtil, HUtil32,
  Actor, HerbActor, AxeMon, SoundUtil, ClEvent, Wil,
  StdCtrls, clFunc, Magiceff, extctrls, MShare, Share;

const
   LONGHEIGHT_IMAGE = 35;
   FLASHBASE = 410;
   AAX = 16;
   SOFFX = 0;
   SOFFY = 0;
{ 20080816ע����ʾ�ڰ�
   LMX = 30;
   LMY = 26; }


{  20080816ע����ʾ�ڰ�
   MAXLIGHT = 5;
   LightFiles : array[0..MAXLIGHT] of string = (
      'Data\lig0a.dat',
      'Data\lig0b.dat',
      'Data\lig0c.dat',
      'Data\lig0d.dat',
      'Data\lig0e.dat',
      'Data\lig0f.dat'
   );

   LightMask0 : array[0..2, 0..2] of shortint = (
      (0,1,0),
      (1,3,1),
      (0,1,0)
   );
   LightMask1 : array[0..4, 0..4] of shortint = (
      (0,1,1,1,0),
      (1,1,3,1,1),
      (1,3,4,3,1),
      (1,1,3,1,1),
      (0,1,2,1,0)
   );
   LightMask2 : array[0..8, 0..8] of shortint = (
      (0,0,0,1,1,1,0,0,0),
      (0,0,1,2,3,2,1,0,0),
      (0,1,2,3,4,3,2,1,0),
      (1,2,3,4,4,4,3,2,1),
      (1,3,4,4,4,4,4,3,1),
      (1,2,3,4,4,4,3,2,1),
      (0,1,2,3,4,3,2,1,0),
      (0,0,1,2,3,2,1,0,0),
      (0,0,0,1,1,1,0,0,0)
   );
   LightMask3 : array[0..10, 0..10] of shortint = (
      (0,0,0,0,1,1,1,0,0,0,0),
      (0,0,0,1,2,2,2,1,0,0,0),
      (0,0,1,2,3,3,3,2,1,0,0),
      (0,1,2,3,4,4,4,3,2,1,0),
      (1,2,3,4,4,4,4,4,3,2,1),
      (2,3,4,4,4,4,4,4,4,3,2),
      (1,2,3,4,4,4,4,4,3,2,1),
      (0,1,2,3,4,4,4,3,2,1,0),
      (0,0,1,2,3,3,3,2,1,0,0),
      (0,0,0,1,2,2,2,1,0,0,0),
      (0,0,0,0,1,1,1,0,0,0,0)
   );

   LightMask4 : array[0..14, 0..14] of shortint = (
      (0,0,0,0,0,0,1,1,1,0,0,0,0,0,0),
      (0,0,0,0,0,1,1,1,1,1,0,0,0,0,0),
      (0,0,0,0,1,1,2,2,2,1,1,0,0,0,0),
      (0,0,0,1,1,2,3,3,3,2,1,1,0,0,0),
      (0,0,1,1,2,3,4,4,4,3,2,1,1,0,0),
      (0,1,1,2,3,4,4,4,4,4,3,2,1,1,0),
      (1,1,2,3,4,4,4,4,4,4,4,3,2,1,1),
      (1,2,3,4,4,4,4,4,4,4,4,4,3,2,1),
      (1,1,2,3,4,4,4,4,4,4,4,3,2,1,1),
      (0,1,1,2,3,4,4,4,4,4,3,2,1,1,0),
      (0,0,1,1,2,3,4,4,4,3,2,1,1,0,0),
      (0,0,0,1,1,2,3,3,3,2,1,1,0,0,0),
      (0,0,0,0,1,1,2,2,2,1,1,0,0,0,0),
      (0,0,0,0,0,1,1,1,1,1,0,0,0,0,0),
      (0,0,0,0,0,0,1,1,1,0,0,0,0,0,0)
   );

   LightMask5 : array[0..16, 0..16] of shortint = (
      (0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0),
      (0,0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0),
      (0,0,0,0,0,1,2,4,4,4,2,1,0,0,0,0,0),
      (0,0,0,0,1,2,4,4,4,4,4,2,1,0,0,0,0),
      (0,0,0,1,2,4,4,4,4,4,4,4,2,1,0,0,0),
      (0,0,1,2,4,4,4,4,4,4,4,4,4,2,1,0,0),
      (0,1,2,4,4,4,4,4,4,4,4,4,4,4,2,1,0),
      (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
      (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
      (1,2,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1),
      (0,1,2,4,4,4,4,4,4,4,4,4,4,4,2,1,0),
      (0,0,1,2,4,4,4,4,4,4,4,4,4,2,1,0,0),
      (0,0,0,1,2,4,4,4,4,4,4,4,2,1,0,0,0),
      (0,0,0,0,1,2,4,4,4,4,4,2,1,0,0,0,0),
      (0,0,0,0,0,1,2,4,4,4,2,1,0,0,0,0,0),
      (0,0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0),
      (0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0)
   ); }

type
   //PShoftInt = ^ShortInt;
   { 20080816ע����ʾ�ڰ�
   TLightEffect = record
      Width: integer;
      Height: integer;
      PFog: Pbyte;
   end;
   TLightMapInfo = record
      ShiftX: integer;
      ShiftY: integer;
      light:  integer;
      bright: integer;
   end;  }

   TPlayScene = class (TScene)
   private
     m_MapSurface    :TDirectDrawSurface;
     m_ObjSurface    :TDirectDrawSurface; //0x0C

{     m_FogScreen     :array[0..MAPSURFACEHEIGHT, 0..MAPSURFACEWIDTH] of byte;
     m_PFogScreen    :PByte;
     m_nFogWidth     :Integer;   20080816ע����ʾ�ڰ�
     m_nFogHeight    :Integer;
     m_Lights        :array[0..MAXLIGHT] of TLightEffect;  }
     m_dwMoveTime    :LongWord;
     m_nMoveStepCount:Integer;
     m_dwAniTime     :LongWord;
     m_nAniCount     :Integer;
     m_nDefXX        :Integer;
     m_nDefYY        :Integer;
     m_MainSoundTimer:TTimer;
     m_MsgList       :TList;
    // m_LightMap      :array[0..LMX, 0..LMY] of TLightMapInfo;  20080816ע����ʾ�ڰ�
     procedure DrawTileMap;
//     procedure LoadFog;  20080816ע����ʾ�ڰ�
//     procedure ClearLightMap;  20080816ע����ʾ�ڰ�
//     procedure AddLight (x, y, shiftx, shifty, light: integer; nocheck: Boolean); 20080816ע����ʾ�ڰ�
//     procedure UpdateBright (x, y, light: integer);  20080816ע����ʾ�ڰ�
//     function  CheckOverLight (x, y, light: integer): Boolean; 20080816ע����ʾ�ڰ�
//     procedure ApplyLightMap; 20080816ע����ʾ�ڰ�
     //procedure DrawLightEffect (lx, ly, bright: integer);   20080816ע����ʾ�ڰ�
     procedure EdChatKeyPress (Sender: TObject; var Key: Char);
     procedure SoundOnTimer (Sender: TObject);
     function  CrashManEx(mx, my: integer): Boolean;
     procedure ClearDropItem();
   public
      EdChat: TEdit;
      MemoLog: TMemo;
      EdAccountt: TEdit;//2004/05/17
      EdChrNamet: TEdit;//2004/05/17
      
     m_ActorList        :TList;
     //m_GroundEffectList :TList;  20080721ע��  û�õ�
     m_EffectList       :TList;
     m_FlyList          :TList;  
     //m_dwBlinkTime      :LongWord;   20080323
     //m_boViewBlink      :Boolean;

      constructor Create;
      destructor Destroy; override;
      procedure Initialize; override;
      procedure Finalize; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure OpeningScene; override;
      //procedure DrawMiniMap (surface: TDirectDrawSurface); 20080323
      procedure PlayScene (MSurface: TDirectDrawSurface); override;
      function  ButchAnimal (x, y: integer): TActor;

      function  FindActor (id: integer): TActor;overload;
      function  FindActor (sName:String): TActor;overload;
      function  FindActorXY (x, y: integer): TActor;
      function  IsValidActor (actor: TActor): Boolean;
      function  NewActor (chrid: integer; cx, cy, cdir: word; cfeature, cstate: integer): TActor;
      procedure ActorDied (actor: TObject); 
      procedure SetActorDrawLevel (actor: TObject; level: integer);
      procedure ClearActors;
      function  DeleteActor (id: integer): TActor;
      procedure DelActor (actor: TObject);
      procedure SendMsg (ident, chrid, x, y, cdir, feature, state: integer; str: string);


      procedure NewMagic (aowner: TActor;
                          magid, magnumb, cx, cy, tx, ty, targetcode: integer;
                          mtype: TMagicType;
                          Recusion: Boolean;
                          anitime: integer;
                          var bofly: Boolean);
      //procedure DelMagic (magid: integer);
      function  NewFlyObject (aowner: TActor; cx, cy, tx, ty, targetcode: integer;  mtype: TMagicType): TMagicEff;
      procedure ScreenXYfromMCXY (cx, cy: integer; var sx, sy: integer);
      procedure CXYfromMouseXY (mx, my: integer; var ccx, ccy: integer);
      function  GetCharacter (x, y, wantsel: integer; var nowsel: integer; liveonly: Boolean): TActor;
      function  GetAttackFocusCharacter (x, y, wantsel: integer; var nowsel: integer; liveonly: Boolean): TActor;
      function  IsSelectMyself (x, y: integer): Boolean;
      function  GetDropItems (x, y: integer; var inames: string): PTDropItem;
      //function  GetXYDropItems (nX,nY:Integer):pTDropItem;
      procedure GetXYDropItemsList (nX,nY:Integer;var ItemList:TList);
      function  CanRun (sx, sy, ex, ey: integer): Boolean;
      function  CanWalk (mx, my: integer): Boolean;
      function  CanWalkEx (mx, my: integer): Boolean;
      function  CrashMan (mx, my: integer): Boolean; 
      //function  CanFly (mx, my: integer): Boolean;
      //procedure RefreshScene;
      procedure CleanObjects;
   end;

implementation

uses
   ClMain, FState;


constructor TPlayScene.Create;
begin
   m_MapSurface := nil;
   m_ObjSurface := nil;
   m_MsgList := TList.Create;   //��Ϣ�б�
   m_ActorList := TList.Create; //��ɫ�б�
   //m_GroundEffectList := TList.Create; 20080721ע��  û�õ�
   m_EffectList := TList.Create;
   m_FlyList := TList.Create;
   m_dwBlinkTime := GetTickCount;
   m_boViewBlink := FALSE;
   //������Ϣ�����
   EdChat := TEdit.Create (FrmMain.Owner);
   with EdChat do begin
      Parent := FrmMain;
      BorderStyle := bsNone;
      OnKeyPress := EdChatKeyPress;
      Visible := FALSE;
      MaxLength := 70;
      Ctl3D := FALSE;
      Left   := 208;
      Top    := SCREENHEIGHT - 19;
      Height := 12;
      Width  := (SCREENWIDTH div 2 - 207) * 2{387};
      Color := clSilver;
   end;
   MemoLog:=TMemo.Create(FrmMain.Owner);
   with MemoLog do begin
      Parent := FrmMain;
      BorderStyle := bsNone;
      Visible := False;
      //Visible := True;
      Ctl3D := False;
    Left := 0;
    Top := 250;
    Width := 300;
    Height := 150;
   end;
   //2004/05/17
   EdAccountt := TEdit.Create (FrmMain.Owner);
   with EdAccountt do begin
      Parent := FrmMain;
      BorderStyle := bsSingle;
      Visible := False;
      MaxLength := 70;
      Ctl3D := True;
      Left   := (SCREENWIDTH - 194) div 2;
      Top    := SCREENHEIGHT - 200;
      Height := 12;
      Width  := 194;
   end;
   //2004/05/17
   //2004/05/17
   EdChrNamet := TEdit.Create (FrmMain.Owner);
   with EdChrNamet do begin
      Parent := FrmMain;
      BorderStyle := bsSingle;
      Visible := False;
      MaxLength := 70;
      Ctl3D := True;
      Left   := (SCREENWIDTH - 194) div 2;
      Top    := SCREENHEIGHT - 176;
      Height := 12;
      Width  := 194;
   end;
   //2004/05/17

   m_dwMoveTime := GetTickCount;
   m_dwAniTime := GetTickCount;
   m_nAniCount := 0;
   m_nMoveStepCount := 0;
   m_MainSoundTimer := TTimer.Create (FrmMain.Owner);
   with m_MainSoundTimer do begin
      OnTimer := SoundOnTimer;
      Interval := 1;
      Enabled := FALSE;
   end;
  // nx := SCREENWIDTH div 2 - 210;
  // ny := SCREENHEIGHT div 2 - 150;
end;

destructor TPlayScene.Destroy;
var
  I: Integer;
begin
  if m_MsgList.Count > 0 then begin//20080629
    for I := 0 to m_MsgList.Count - 1 do
     if  pTChrMsg(m_MsgList.Items[I]) <> nil then Dispose(pTChrMsg(m_MsgList.Items[I]));
  end;
  FreeAndNil(m_MsgList);
  
  if m_ActorList.Count > 0 then begin   //�ͷ����� 20080718
    for I := 0 to m_ActorList.Count - 1 do
      if TActor(m_ActorList[I]) <> nil then TActor(m_ActorList[I]).Free;
  end;
  FreeAndNil(m_ActorList);
  {  20080721ע��  û�õ�
  if m_GroundEffectList.Count > 0 then begin   //�ͷ����� 20080718
    for I := 0 to m_GroundEffectList.Count - 1 do
      if TMagicEff(m_GroundEffectList.Items[I]) <> nil then TMagicEff(m_GroundEffectList.Items[I]).Free;
  end;
  FreeAndNil(m_GroundEffectList);   }
  if m_EffectList.Count > 0 then begin   //�ͷ����� 20080718
    for I := 0 to m_EffectList.Count - 1 do
      if TMagicEff(m_EffectList[I]) <> nil then TMagicEff(m_EffectList[I]).Free;
  end;
  FreeAndNil(m_EffectList);
  if m_FlyList.Count > 0 then begin   //�ͷ����� 20080718
    for I := 0 to m_FlyList.Count - 1 do
      if TMagicEff(m_FlyList.Items[I]) <> nil then TMagicEff(m_FlyList.Items[I]).Free;
  end;
  FreeAndNil(m_FlyList);
   inherited Destroy;
end;
//��Ϸ�������ı������֣����ȣ�43�룩
procedure TPlayScene.SoundOnTimer (Sender: TObject);
begin
   PlaySound (s_main_theme);
   m_MainSoundTimer.Interval := 46 * 1000;
end;
//������Ϣ����
procedure TPlayScene.EdChatKeyPress (Sender: TObject; var Key: Char);
begin
   if Key = #13 then begin
      FrmMain.SendSay (EdChat.Text);
      EdChat.Text := '';
      EdChat.Visible := FALSE;
      Key := #0;
   end;
   if Key = #27 then begin
      EdChat.Text := '';
      EdChat.Visible := FALSE;
      Key := #0;
   end;
end;
//��ʼ������
procedure TPlayScene.Initialize;
begin
   //frmMain.DXDraw.BeginScene; //20080718
   //��ͼ
   m_MapSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
   m_MapSurface.SystemMemory := TRUE;
   m_MapSurface.SetSize (MAPSURFACEWIDTH+UNITX*4+30, MAPSURFACEHEIGHT+UNITY*4);
   //��Ʒ
   m_ObjSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
   m_ObjSurface.SystemMemory := TRUE;
   m_ObjSurface.SetSize (MAPSURFACEWIDTH-SOFFX*2, MAPSURFACEHEIGHT);
   {//�� 20080816ע����ʾ�ڰ�
   m_nFogWidth := MAPSURFACEWIDTH - SOFFX * 2;
   m_nFogHeight := MAPSURFACEHEIGHT;
   m_PFogScreen := @m_FogScreen;
   ZeroMemory (m_PFogScreen, MAPSURFACEHEIGHT * MAPSURFACEWIDTH); }

   //g_boViewFog := FALSE;  20080816ע����ʾ�ڰ�
  { for i:=0 to MAXLIGHT do
      m_Lights[i].PFog := nil;
   //LoadFog; 20080816ע����ʾ�ڰ�
   //frmMain.DXDraw.EndScene;  }
end;

procedure TPlayScene.Finalize;
begin
   if m_MapSurface <> nil then
      m_MapSurface.Free;
   if m_ObjSurface <> nil then
      m_ObjSurface.Free;
   m_MapSurface := nil;
   m_ObjSurface := nil;

   //if m_Lights <> nil then   //20080718�ͷ��ڴ�
    {  20080816ע����ʾ�ڰ�
    for I:=0 to MAXLIGHT do begin
       if m_Lights[i].PFog <> nil then
          FreeMem(m_Lights[i].PFog);
          //FillChar (m_Lights[i].PFog^, m_Lights[i].Width*m_Lights[i].Height+8, #0);
    end; }

end;
//������ʼ
procedure TPlayScene.OpenScene;
begin
   g_WMainImages.ClearCache;  //�ͷų���
   FrmDlg.ViewBottomBox (TRUE);

   SetImeMode (FrmMain.Handle, LocalLanguage);
   //MainSoundTimer.Interval := 1000;
   //MainSoundTimer.Enabled := TRUE;
end;
//�رճ���
procedure TPlayScene.CloseScene;
begin
   //MainSoundTimer.Enabled := FALSE;
   SilenceSound;

   EdChat.Visible := FALSE;
   FrmDlg.ViewBottomBox (FALSE);
end;

procedure TPlayScene.OpeningScene;
begin
end;
{//ˢ�³���(��Ϸ��ɫ��
procedure TPlayScene.RefreshScene;
var
   i: integer;
begin
   Map.m_OldClientRect.Left := -1;
   if m_ActorList.Count > 0 then //20080629
   for i:=0 to m_ActorList.Count-1 do
      TActor (m_ActorList[i]).LoadSurface;
end; }

procedure TPlayScene.CleanObjects;
var
  I: integer;
begin
  if m_ActorList.Count > 0 then begin //20080629
    if g_HeroSelf = nil then begin
       //ɾ�����зǵ�ǰ��ҽ�ɫ
       for i := m_ActorList.Count-1 downto 0 do begin
          if TActor(m_ActorList[i]) <> g_MySelf then begin
             TActor(m_ActorList[i]).Free;
             m_ActorList.Delete (i);
          end;
       end;
    end else begin
        //��� Ӣ�ۻ���ͼ  ����û�˵�����   ���� 2007.11.9
        for i := m_ActorList.Count-1 downto 0 do begin
          if (TActor(m_ActorList[i]) <> g_MySelf) and (TActor(m_ActorList[i]) <> g_HeroSelf) then begin
             TActor(m_ActorList[i]).Free;
             m_ActorList.Delete (i);
          end;
        end;
    end;
  end;
   m_MsgList.Clear;
   g_TargetCret := nil; 
   g_FocusCret := nil;
   g_MagicTarget := nil;
   //���ħ��Ч��
   { 20080721ע��  û�õ�
   if m_GroundEffectList.Count > 0 then begin//20080629
     for i:=0 to m_GroundEffectList.Count-1 do
        TMagicEff (m_GroundEffectList[i]).Free;
     m_GroundEffectList.Clear;
   end; }
   if m_EffectList.Count > 0 then begin//20080629
     for i:=0 to m_EffectList.Count-1 do
        TMagicEff (m_EffectList[i]).Free;
     m_EffectList.Clear;
   end;
end;

{---------------------- Draw Map -----------------------}
//����ͼ
procedure TPlayScene.DrawTileMap;
var
  i,j, nY,nX,nImgNumber:integer;
  DSurface: TDirectDrawSurface;
begin
  with Map do
    if (m_ClientRect.Left = m_OldClientRect.Left) and (m_ClientRect.Top = m_OldClientRect.Top) then Exit;

  Map.m_OldClientRect := Map.m_ClientRect;
  m_MapSurface.Fill(0);

//��ͼ����
 //if not g_boDrawTileMap then Exit;
  with Map.m_ClientRect do begin
    nY := -UNITY * 2;  //-32*2=-64
    for J:=(Top - Map.m_nBlockTop - 1) to (Bottom - Map.m_nBlockTop + 1) do begin  //�ӵ�ͼ�������²�
      nX := AAX + 14 -UNITX; //16+14-48=-18
      for i:=(Left - Map.m_nBlockLeft -2) to (Right - Map.m_nBlockLeft + 1) do begin //����ߵ��ұ�
        if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT *3) then begin
          nImgNumber := (Map.m_MArr[i, j].wBkImg and $7FFF);
          if nImgNumber > 0 then begin
            if (i mod 2 = 0) and (j mod 2 = 0) then begin
              nImgNumber := nImgNumber - 1;
              DSurface := g_WTilesImages.Images[nImgNumber];
              if Dsurface <> nil then begin
                m_MapSurface.Draw (nX, nY, DSurface.ClientRect, DSurface, FALSE);
              end;
             end;
           end;
         end;
         Inc (nX, UNITX);
       end;
       Inc (nY, UNITY);
    end;
  end;


   //��ʾ���ϵĲ�   ������밲ȫ���Ĳ�
   with Map.m_ClientRect do begin
      nY := -UNITY;
      for j:=(Top - Map.m_nBlockTop-1) to (Bottom - Map.m_nBlockTop+1) do begin
         nX := AAX + 14 -UNITX;
         for i:=(Left - Map.m_nBlockLeft-2) to (Right - Map.m_nBlockLeft+1) do begin
            if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then begin
               nImgNumber := Map.m_MArr[i, j].wMidImg;
               if nImgNumber > 0 then begin
                  nImgNumber := nImgNumber - 1;
                  DSurface := g_WSmTilesImages.Images[nImgNumber];
                  if Dsurface <> nil then
                     m_MapSurface.Draw (nX, nY, DSurface.ClientRect, DSurface, TRUE);
               end;
            end;
            Inc (nX, UNITX);
         end;
         Inc (nY, UNITY);
      end;
   end;

end;



{----------------------- ����, ����Ʈ ó�� -----------------------}

{ 20080816ע����ʾ�ڰ�
//���ļ���װ����
procedure TPlayScene.LoadFog;  
var
   i, fhandle, w, h, prevsize: integer;
   Cheat: Boolean;
begin
   prevsize := 0; //���� üũ
   Cheat := FALSE;
   for i:=0 to MAXLIGHT do begin
      if FileExists (LightFiles[i]) then begin
         fhandle := FileOpen (LightFiles[i], fmOpenRead or fmShareDenyNone);
         FileRead (fhandle, w, sizeof(integer));
         FileRead (fhandle, h, sizeof(integer));
         m_Lights[i].Width := w;
         m_Lights[i].Height := h;
         m_Lights[i].PFog := AllocMem  (w * h + 8);
         if prevsize < w * h then begin
            FileRead (fhandle, m_Lights[i].PFog^, w*h);
         end else
            cheat := TRUE;
         prevsize := w * h;
         FileClose (fhandle);
      end;
   end;
   if cheat then
      for i:=0 to MAXLIGHT do begin
         if m_Lights[i].PFog <> nil then
            FillChar (m_Lights[i].PFog^, m_Lights[i].Width*m_Lights[i].Height+8, #0);
      end;
end;
}
procedure TPlayScene.ClearDropItem;
var
  I:Integer;
  DropItem:pTDropItem;
begin
  if g_DropedItemList.Count > 0 then begin//20080629
    for I := g_DropedItemList.Count - 1 downto 0 do begin
      DropItem:=g_DropedItemList.Items[I];   
      if DropItem = nil then begin
        g_DropedItemList.Delete(I);
        Continue;
      end;
      if (abs(DropItem.x - g_MySelf.m_nCurrX) > 20) and (abs(DropItem.y - g_MySelf.m_nCurrY) > 20) then begin
  {$IF DEBUG = 1}
        DScreen.AddChatBoardString (format('DropItem:%s X:%d Y:%d',[DropItem.Name,DropItem.X,DropItem.Y]),clWhite, clRed);
  {$IFEND}
        Dispose(DropItem);
        g_DropedItemList.Delete(I);
      end;
    end;
  end;
end;

{ 20080816ע����ʾ�ڰ�
procedure TPlayScene.ClearLightMap;
var
   i, j: integer;
begin
   FillChar (m_LightMap, (LMX+1)*(LMY+1)*SizeOf(TLightMapInfo), 0);
   for i:=0 to LMX do
      for j:=0 to LMY do
         m_LightMap[i, j].Light := -1;
end; }

{ 20080816ע����ʾ�ڰ�
procedure TPlayScene.UpdateBright (x, y, light: integer);
var
   i, j, r, lx, ly: integer;
   pmask: ^ShortInt;
begin
   pmask:=nil;//jacky
   r := -1;
   case light of
      0: begin r := 2; pmask := @LightMask0; end;
      1: begin r := 4; pmask := @LightMask1; end;
      2: begin r := 8; pmask := @LightMask2; end;
      3: begin r := 10; pmask := @LightMask3; end;
      4: begin r := 14; pmask := @LightMask4; end;
      5: begin r := 16; pmask := @LightMask5; end;
   end;
   for i:=0 to r do
      for j:=0 to r do begin
         lx := x-(r div 2)+i;
         ly := y-(r div 2)+j;
         if (lx in [0..LMX]) and (ly in [0..LMY]) then
            m_LightMap[lx, ly].bright := m_LightMap[lx, ly].bright + PShoftInt(integer(pmask) + (i*(r+1) + j) * sizeof(shortint))^;
      end;
end; }
{ 20080816ע����ʾ�ڰ�
function  TPlayScene.CheckOverLight (x, y, light: integer): Boolean;
var
   i, j, r, mlight, lx, ly, count, check: integer;
   pmask: ^ShortInt;
begin
   pmask:=nil;//jacky
   check:=0;//jacky
   r := -1;
   case light of
      0: begin r := 2; pmask := @LightMask0; check := 0; end;
      1: begin r := 4; pmask := @LightMask1; check := 4; end;
      2: begin r := 8; pmask := @LightMask2; check := 8; end;
      3: begin r := 10; pmask := @LightMask3; check := 18; end;
      4: begin r := 14; pmask := @LightMask4; check := 30; end;
      5: begin r := 16; pmask := @LightMask5; check := 40; end;
   end;
   count := 0;
   
   for i:=0 to r do
      for j:=0 to r do begin
         lx := x-(r div 2)+i;
         ly := y-(r div 2)+j;
         if (lx in [0..LMX]) and (ly in [0..LMY]) then begin
            mlight := PShoftInt(integer(pmask) + (i*(r+1) + j) * sizeof(shortint))^;
            if m_LightMap[lx, ly].bright < mlight then begin
               inc (count, mlight - m_LightMap[lx, ly].bright);
               if count >= check then begin
                  Result := FALSE;
                  exit;
               end;
            end;
         end;
      end;
   Result := TRUE;
end;

procedure TPlayScene.AddLight (x, y, shiftx, shifty, light: integer; nocheck: Boolean);
var
   lx, ly: integer;
begin
   lx := x - g_MySelf.m_nRx + LMX div 2;
   ly := y - g_MySelf.m_nRy + LMY div 2;
   if (lx >= 1) and (lx < LMX) and (ly >= 1) and (ly < LMY) then begin
      if m_LightMap[lx, ly].light < light then begin
         if not CheckOverLight(lx, ly, light) or nocheck then begin // > LightMap[lx, ly].light then begin
            UpdateBright (lx, ly, light);
            m_LightMap[lx, ly].light := light;
            m_LightMap[lx, ly].Shiftx := shiftx;
            m_LightMap[lx, ly].Shifty := shifty;
         end;
      end;
   end;
end;

procedure TPlayScene.ApplyLightMap;
var
   i, j, light, defx, defy, lx, ly, lxx, lyy: integer;
begin
   defx := -UNITX*2 + AAX + 14 - g_MySelf.m_nShiftX;
   defy := -UNITY*3 - g_MySelf.m_nShiftY;
   for i:=1 to LMX-1 do
      for j:=1 to LMY-1 do begin
         light := m_LightMap[i, j].light;
         if light >= 0 then begin
            lx := (i + g_MySelf.m_nRx - LMX div 2);
            ly := (j + g_MySelf.m_nRy - LMY div 2);
            lxx := (lx-Map.m_ClientRect.Left)*UNITX + defx + m_LightMap[i, j].ShiftX;
            lyy := (ly-Map.m_ClientRect.Top)*UNITY + defy + m_LightMap[i, j].ShiftY;

            FogCopy (m_Lights[light].PFog,
                     0,
                     0,
                     m_Lights[light].Width,
                     m_Lights[light].Height,
                     m_PFogScreen,
                     lxx - (m_Lights[light].Width-UNITX) div 2,
                     lyy - (m_Lights[light].Height-UNITY) div 2 - 5,
                     m_nFogWidth,
                     m_nFogHeight,
                     20);
         end;
      end;
end;
}
{procedure TPlayScene.DrawLightEffect (lx, ly, bright: integer);
begin
   if (bright > 0) and (bright <= MAXLIGHT) then
      FogCopy (m_Lights[bright].PFog,
               0,
               0,
               m_Lights[bright].Width,
               m_Lights[bright].Height,
               m_PFogScreen,
               lx - (m_Lights[bright].Width-UNITX) div 2,
               ly - (m_Lights[bright].Height-UNITY) div 2,
               m_nFogWidth,
               m_nFogHeight,
               15);
end;   }

{-----------------------------------------------------------------------}
(*//��ʾС��ͼ   20080323
procedure TPlayScene.DrawMiniMap (surface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  v: Boolean;
  mx, my,nx,ny, i: integer;
  rc: TRect;
  actor:TActor;
  x,y:integer;
  btColor:Byte;
begin
  if GetTickCount > m_dwBlinkTime + 300 then begin  //��ǰ�����С��ͼ�ϵ�λ�ã�ÿ300������һ��
    m_dwBlinkTime := GetTickCount;
    m_boViewBlink := not m_boViewBlink;
  end;
  if g_nMiniMapIndex < 0 then exit; //Jacky
  if g_nMiniMapIndex = 10301 then  //����
    d:=FrmMain.UiDXImageList.Items.Find('301MinMap').PatternSurfaces[0]
  else
  d := g_WMMapImages.Images[g_nMiniMapIndex];



  if d = nil then exit;

  mx := (g_MySelf.m_nCurrX*48) div 32;
  my := (g_MySelf.m_nCurrY*32) div 32;

    rc.Left := _MAX(0, mx-60);
    rc.Top := _MAX(0, my-60);
    rc.Right := _MIN(d.ClientRect.Right, rc.Left + 120);
    rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + 120);

  {if g_nViewMinMapLv = 1 then
    DrawBlendEx (surface, (SCREENWIDTH-120), 0, d, rc.Left, rc.Top, 120, 120, 0)
  else surface.Draw ((SCREENWIDTH-120), 0, rc, d, FALSE);}
  //20080228�޸�С��ͼ֧��ȫ��
   if g_nViewMinMapLv = 1 then begin
    surface.Draw ((SCREENWIDTH-120), 0, rc, d, FALSE);
    m_boViewBlink := True;
   end else begin
      Surface.StretchDraw(Rect((SCREENWIDTH - 160), 0, 800, 160), d.ClientRect,d, False);
        rc := d.ClientRect;
     m_boViewBlink := False;
      mx := UpInt((245 / d.Width) * g_MySelf.m_nCurrX) + 800 - 160;
      my := UpInt((155 / d.Height) * g_MySelf.m_nCurrY);

  for x:=0 to 3 do
    for y:=0 to 3 do
      surface.Pixels[mx+x, my+y] := 255;
   end;

     //�״�
  if not m_boViewBlink then exit;
  mx := (SCREENWIDTH-120) + (g_MySelf.m_nCurrX * 48) div 32 - rc.Left;
  my := (g_MySelf.m_nCurrY * 32) div 32 - rc.Top;
  for x:=0 to 2 do
    for y:=0 to 2 do
  surface.Pixels[mx+x, my+y] := 255;

  for nx:=g_MySelf.m_nCurrX - 10  to g_MySelf.m_nCurrX + 10 do begin
    for ny:=g_MySelf.m_nCurrY - 10 to g_MySelf.m_nCurrY + 10 do begin
      actor := FindActorXY(nx,ny);
      if (actor <> nil) and (actor <> g_MySelf) and (not actor.m_boDeath) then begin
        mx := (SCREENWIDTH-120) + (actor.m_nCurrX * 48) div 32 - rc.Left;
        my := (actor.m_nCurrY * 32) div 32 - rc.Top;
        case actor.m_btRace of    //
          50,12: btColor:=215;
          0: btColor:=251;
          else btColor:=249;
        end;    // case
        for x:=0 to 2 do
          for y:=0 to 2 do
            surface.Pixels[mx+x, my+y] := btColor
      end;
    end;
  end;
end;  *)
{-----------------------------------------------------------------------}

//����Ϸ��ʽ����
procedure TPlayScene.PlayScene (MSurface: TDirectDrawSurface);
var
   i, j, k, n, m, mmm, ix, iy, line, defx, defy, wunit, fridx, ani, anitick, ax, ay, idx, drawingbottomline: Integer;
   DSurface, d: TDirectDrawSurface;
   blend, movetick: Boolean;
   DropItem: PTDropItem;
   evn: TClEvent;
   actor: TActor;
   meff: TMagicEff;
   msgstr: string;
   ErrorCode: Integer;
begin
   DrawingBottomLine:=0;//jacky
   if (g_MySelf = nil) then begin
        msgstr := '�����˳���Ϸ�����Ժ�...';
      with MSurface.Canvas do begin
         {$if Version = 1}
         SetBkMode (Handle, TRANSPARENT);
         {$IFEND}
         BoldTextOut (MSurface, (SCREENWIDTH-FrmMain.Canvas.TextWidth(msgstr)) div 2, 200,
                      clWhite, clBlack, msgstr);
         Release;
      end;
      Exit;
   end;
   
   g_boDoFastFadeOut := FALSE;
   movetick := FALSE;
   if GetTickCount - m_dwMoveTime >= 100 then begin
      m_dwMoveTime := GetTickCount;   //�ƶ���ʼʱ��
      movetick := TRUE;          //�����ƶ�
      Inc (m_nMoveStepCount);
      if m_nMoveStepCount > 1 then m_nMoveStepCount := 0;
   end;
   if GetTickCount - m_dwAniTime >= 50 then begin
      m_dwAniTime := GetTickCount;
      Inc (m_nAniCount);
      if m_nAniCount > 100000 then m_nAniCount := 0;
   end;
   //�����ɫһЩ��ض���
   ErrorCode := 0;
   try
   I := 0;
   while TRUE do begin
      if i >= m_ActorList.Count then break;
      actor := m_ActorList[i];
      if movetick then actor.m_boLockEndFrame := FALSE; //�����ƶ�
      if not actor.m_boLockEndFrame then begin   //û����������
         actor.ProcMsg;   //�����ɫ����Ϣ.
         if MoveTick then
            if actor.Move(m_nMoveStepCount) then begin  //��ɫ�ƶ�
               Inc (I);
               continue;
            end;
         actor.Run;    //
         if actor <> g_MySelf then actor.ProcHurryMsg;
      end;
      if actor = g_MySelf then actor.ProcHurryMsg;
      //
      if (actor.m_nWaitForRecogId <> 0) and (actor.IsIdle){��ǰ�Ƿ�û�п�ִ�еĶ���} then begin
        DelChangeFace (actor.m_nWaitForRecogId);
        NewActor (actor.m_nWaitForRecogId, actor.m_nCurrX, actor.m_nCurrY, actor.m_btDir, actor.m_nWaitForFeature, actor.m_nWaitForStatus);
        actor.m_nWaitForRecogId := 0;
        actor.m_boDelActor := TRUE;
      end;
      if actor.m_boDelActor then begin
         g_FreeActorList.Add (actor);
         m_ActorList.Delete (i);
         if g_TargetCret = actor then g_TargetCret := nil;
         if g_FocusCret = actor then g_FocusCret := nil;
         if g_MagicTarget = actor then g_MagicTarget := nil;
      end else Inc (i);
   end;
   except
      DebugOutStr ('101');
   end; 
   { 20080721ע��  û�õ�
   //���������˶��ļ���
   try
   I := 0;
   while TRUE do begin
      if i >= m_GroundEffectList.Count then break;
      meff := m_GroundEffectList[i];
      if meff.m_boActive then begin
         if not meff.Run then begin //����ȿ��
            //meff.Free;  ��ǰ20080719
            FreeAndNil(meff);          
            m_GroundEffectList.Delete (i);
            continue;
         end;
      end;
      Inc (I);
   end;  }
   //��Ч�����˶����Եļ���
   try
   i := 0;
   ErrorCode := 0;
   while TRUE do begin
      if I >= m_EffectList.Count then break;
      ErrorCode := 1;
      meff := m_EffectList[i];
        if meff.m_boActive then begin
           ErrorCode := 2;
           if not meff.Run then begin //����ȿ��
              meff.Free; 
              m_EffectList.Delete (i);
              continue;
           end;
        end;
      Inc (i);
   end;
   //����ħ���ͷ�
   i := 0;
   ErrorCode := 3;
   while TRUE do begin
      if i >= m_FlyList.Count then break;
      meff := m_FlyList[i];
      if meff.m_boActive then begin
         if not meff.Run then begin //����,ȭ��� ���ư���
            meff.Free; 
            m_FlyList.Delete (i);
            continue;
         end;
      end;
      Inc (i);
   end;
   ErrorCode := 4;
   EventMan.Execute;
   ErrorCode := 5;
   except
      DebugOutStr ('102 Code:'+IntToStr(ErrorCode));
   end;

   try
   ErrorCode := 0;
   //������Ʒ����
   ClearDropItem();
   ErrorCode := 1;
   //�ͷ��¼��ĵط�
   if EventMan.EventList.Count > 0 then begin//20080629
     for k:=0 to EventMan.EventList.Count-1 do begin  
        ErrorCode := 2;
        evn := TClEvent (EventMan.EventList[k]);
        if (Abs(evn.m_nX-g_MySelf.m_nCurrX) > 20) or (Abs(evn.m_nY-g_MySelf.m_nCurrY) > 20) then begin
           evn.Free; 
           EventMan.EventList.Delete (k);
           break;  //�ѹ��� �Ѱ���
        end;
     end;
   end;
   ErrorCode := 4;
   except
      DebugOutStr ('103 Code:'+IntToStr(ErrorCode));
   end;
   //���µ�ͼ�ɼ���Χ
   try
   ErrorCode := 0;
   with Map.m_ClientRect do begin       //800x600ģʽ ��ͼ�ķ�Χ�����Ϊ���ģ����Ҹ�9
{$IF SWH = SWH800}
      Left   := g_MySelf.m_nRx - 9;
      Top    := g_MySelf.m_nRy - 9;
      Right  := g_MySelf.m_nRx + 9;
      Bottom := g_MySelf.m_nRy + 8;
{$ELSEIF SWH = SWH1024}                  //1024X768ģʽ
      Left   := g_MySelf.m_nRx - 12;
      Top    := g_MySelf.m_nRy - 12;
      Right  := g_MySelf.m_nRx + 12;                      
      Bottom := g_MySelf.m_nRy + 15;
{$IFEND}
   end;
   ErrorCode := 1;
   //װ�ص�ͼ����
   Map.UpdateMapPos (g_MySelf.m_nRx, g_MySelf.m_nRy);
   ErrorCode := 2;

   ///////////////////////
   //ViewFog := FALSE;
   ///////////////////////

   { 20080816ע����ʾ�ڰ�
   if g_boNoDarkness or (g_MySelf.m_boDeath) then begin
      g_boViewFog := FALSE;
   end;

   if g_boViewFog then begin
      ZeroMemory (m_PFogScreen, MAPSURFACEHEIGHT * MAPSURFACEWIDTH);
      ClearLightMap;
   end;  }
   ErrorCode := 3;
   //drawingbottomline := 450;
   drawingbottomline := SCREENHEIGHT;

   m_ObjSurface.Fill(0); //��仭��  0Ϊ��ɫ
   //����ͼ
   DrawTileMap;
   ErrorCode := 4;
   m_ObjSurface.Draw (0, 0,
                    Rect(UNITX*3 + g_MySelf.m_nShiftX,
                         UNITY*2 + g_MySelf.m_nShiftY,
                         UNITX*3 + g_MySelf.m_nShiftX + MAPSURFACEWIDTH,
                         UNITY*2 + g_MySelf.m_nShiftY + MAPSURFACEHEIGHT),
                    m_MapSurface,
                    FALSE);
   ErrorCode := 5;
   except
      DebugOutStr ('104 Code:'+IntToStr(ErrorCode));
   end;

   defx := -UNITX*2 - g_MySelf.m_nShiftX + AAX + 14;
   defy := -UNITY*2 - g_MySelf.m_nShiftY;
   m_nDefXX := defx;
   m_nDefYY := defy;
   //�������ϵ����壬�緿�ݵ�
   try
   ErrorCode := 0;
   m := defy - UNITY;
   for j:=(Map.m_ClientRect.Top - Map.m_nBlockTop) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop{+ LONGHEIGHT_IMAGE}{20081226�Ż�}) do begin
      if j < 0 then begin Inc (m, UNITY); continue; end;
      n := defx-UNITX*2;
      //*** 48*32 ��һ������СͼƬ�Ĵ�С
      ErrorCode := 1;
      for i:=(Map.m_ClientRect.Left - Map.m_nBlockLeft-2) to (Map.m_ClientRect.Right - Map.m_nBlockLeft+2{20081226�Ż�}) do begin
         if (i >= 0) and (i < LOGICALMAPUNIT*3) and (j >= 0) and (j < LOGICALMAPUNIT*3) then begin
            fridx := (Map.m_MArr[i, j].wFrImg) and $7FFF;
            if fridx > 0 then begin
               ani := Map.m_MArr[i, j].btAniFrame;
               wunit := Map.m_MArr[i, j].btArea;
               if (ani and $80) > 0 then begin
                  blend := TRUE;
                  ani := ani and $7F;
               end;
               if ani > 0 then begin
                  anitick := Map.m_MArr[i, j].btAniTick;
                  fridx := fridx + (m_nAniCount mod (ani + (ani*anitick))) div (1+anitick);
               end;
               if (Map.m_MArr[i, j].btDoorOffset and $80) > 0 then begin //����
                  if (Map.m_MArr[i, j].btDoorIndex and $7F) > 0 then  //������ ǥ�õ� �͸�
                     fridx := fridx + (Map.m_MArr[i, j].btDoorOffset and $7F); //���� ��
               end;
               fridx := fridx - 1;
               // ȡͼƬ
               DSurface := GetObjs (wunit, fridx);
               if DSurface <> nil then begin
                  if (DSurface.Width = 48) and (DSurface.Height = 32) then begin
                     mmm := m + UNITY - DSurface.Height;
                     if (n+DSurface.Width > 0) and (n <= SCREENWIDTH) and (mmm + DSurface.Height > 0) and (mmm < drawingbottomline) then begin
                        m_ObjSurface.Draw (n, mmm, DSurface.ClientRect, Dsurface, TRUE)
                     end else begin
                        if mmm < drawingbottomline then begin //���ʿ��ϰ� �׸��� ���� ����
                           m_ObjSurface.Draw (n, mmm, DSurface.ClientRect, DSurface, TRUE)
                        end;
                     end;
                  end;
               end;
            end;
         end;
         Inc (n, UNITX);
      end;
      Inc (m, UNITY);
   end;
   { 20080721ע��  û�õ�
   //����������Ч��
   if m_GroundEffectList.Count > 0 then //20080629
   for k:=0 to m_GroundEffectList.Count-1 do begin
      meff := TMagicEff(m_GroundEffectList[k]);
      meff.DrawEff (m_ObjSurface);
      if g_boViewFog then begin
         AddLight (meff.Rx, meff.Ry, 0, 0, meff.light, FALSE);
      end;
   end; }
   
   except
      DebugOutStr ('105 Code:'+IntToStr(ErrorCode));
   end; 

   try
     ErrorCode := 0;
     m := defy - UNITY;
     for j:=(Map.m_ClientRect.Top - Map.m_nBlockTop) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop + 20 {+ LONGHEIGHT_IMAGE}{20080821�Ż�}) do begin
        if j < 0 then begin Inc (m, UNITY); continue; end;
        n := defx-UNITX*2;
        //*** ��������Ʈ �׸���
        ErrorCode := 1;
        for i:=(Map.m_ClientRect.Left - Map.m_nBlockLeft-2) to (Map.m_ClientRect.Right - Map.m_nBlockLeft+2{20080821�Ż�}) do begin
           if (i >= 0) and (i < LOGICALMAPUNIT*3) and (j >= 0) and (j < LOGICALMAPUNIT*3) then begin
              fridx := (Map.m_MArr[i, j].wFrImg) and $7FFF;
              if fridx > 0 then begin
                 blend := FALSE;
                 wunit := Map.m_MArr[i, j].btArea;
                 //���ϸ��̼�
                 ani := Map.m_MArr[i, j].btAniFrame;
                 if (ani and $80) > 0 then begin
                    blend := TRUE;
                    ani := ani and $7F;
                 end;
                 if ani > 0 then begin
                    anitick := Map.m_MArr[i, j].btAniTick;
                    fridx := fridx + (m_nAniCount mod (ani + (ani*anitick))) div (1+anitick);
                 end;
                 if (Map.m_MArr[i, j].btDoorOffset and $80) > 0 then begin //����
                    if (Map.m_MArr[i, j].btDoorIndex and $7F) > 0 then  //������ ǥ�õ� �͸�
                       fridx := fridx + (Map.m_MArr[i, j].btDoorOffset and $7F); //���� ��
                 end;
                 fridx := fridx - 1;
                 // ��ü �׸�
                 if not blend then begin
                    DSurface := GetObjs (wunit, fridx);
                    if DSurface <> nil then begin
                       if (DSurface.Width <> 48) or (DSurface.Height <> 32) then begin
                          mmm := m + UNITY - DSurface.Height;
                          if (n+DSurface.Width > 0) and (n <= SCREENWIDTH) and (mmm + DSurface.Height > 0) and (mmm < drawingbottomline) then begin
                             m_ObjSurface.Draw (n, mmm, DSurface.ClientRect, Dsurface, TRUE)
                          end else begin
                             if mmm < drawingbottomline then begin //���ʿ��ϰ� �׸��� ���� ����
                                m_ObjSurface.Draw (n, mmm, DSurface.ClientRect, DSurface, TRUE)
                             end;
                          end;
                       end;
                    end;
                 end else begin
                    ErrorCode := 2;
                    //---------------------��ʾ�ƹ�ĵط�
                    DSurface := GetObjsEx (wunit, fridx, ax, ay);
                    if DSurface <> nil then begin
                       mmm := m + ay - 68;
                       if (n > 0) and (mmm + DSurface.Height > 0) and (n + Dsurface.Width < SCREENWIDTH) and (mmm < drawingbottomline) then begin
                          DrawBlend (m_ObjSurface, n+ax-2, mmm, DSurface, 1);
                       end else begin
                          if mmm < drawingbottomline then begin 
                             DrawBlend (m_ObjSurface, n+ax-2, mmm, DSurface, 1);
                          end;
                       end;
                    end;
                 end;
              end;

           end;
           Inc (n, UNITX);
        end;
        ErrorCode := 3;
        if (j <= (Map.m_ClientRect.Bottom - Map.m_nBlockTop )) and (not g_boServerChanging) then begin
           if EventMan.EventList.Count > 0 then begin//20080629
             for k:=0 to EventMan.EventList.Count-1 do begin
                evn := TClEvent (EventMan.EventList[k]);
                if j = (evn.m_nY - Map.m_nBlockTop) then begin
                   evn.DrawEvent (m_ObjSurface,
                                  (evn.m_nX-Map.m_ClientRect.Left)*UNITX + defx,
                                  m);
                end;
             end;
           end;


           //if g_boDrawDropItem then begin
           ErrorCode := 4;
           //��ʾ������Ʒ����
           if g_DropedItemList.Count > 0 then //20080629
           for k:=0 to g_DropedItemList.Count-1 do begin
             ErrorCode := 5;
              DropItem := PTDropItem (g_DropedItemList[k]);
              ErrorCode := 6;
              if DropItem <> nil then begin
                 if j = (DropItem.y - Map.m_nBlockTop) then begin
                    d := g_WDnItemImages.Images[DropItem.Looks];
                    if d <> nil then begin
                       ix := (DropItem.x-Map.m_ClientRect.Left) * UNITX + defx + SOFFX; // + actor.ShiftX;
                       iy := m; // + actor.ShiftY;
                       ErrorCode := 7;
                       if DropItem = g_FocusItem then begin
                          g_ImgMixSurface.Draw (0, 0, d.ClientRect, d, FALSE);
                          DrawEffect (0, 0, d.Width, d.Height, g_ImgMixSurface, ceBright);
                          m_ObjSurface.Draw (ix + HALFX-(d.Width div 2),
                                        iy + HALFY-(d.Height div 2),
                                        d.ClientRect,
                                        g_ImgMixSurface, TRUE);
                       end else begin
                          m_ObjSurface.Draw (ix + HALFX-(d.Width div 2),
                                        iy + HALFY-(d.Height div 2),
                                        d.ClientRect,
                                        d, TRUE);
                       end;

                    end;
                 end;
              end;
           end;
           //end;
           ErrorCode := 8;
           //*** ��ʾ����˵����Ϣ
           for k:=0 to m_ActorList.Count-1 do begin
             ErrorCode := 9;
              actor := m_ActorList[k];
                ErrorCode := 10;
                if (j = actor.m_nRy-Map.m_nBlockTop-actor.m_nDownDrawLevel) then begin
                   ErrorCode := 11;
                   actor.m_nSayX := (actor.m_nRx-Map.m_ClientRect.Left)*UNITX + defx + actor.m_nShiftX + 24;
                   if actor.m_boDeath then
                      actor.m_nSayY := m + UNITY + actor.m_nShiftY + 16 - 60  + (actor.m_nDownDrawLevel * UNITY)
                   else actor.m_nSayY := m + UNITY + actor.m_nShiftY + 16 - 95  + (actor.m_nDownDrawLevel * UNITY);
                   ErrorCode := 12;
                   actor.DrawChr (m_ObjSurface, (actor.m_nRx-Map.m_ClientRect.Left)*UNITX + defx,
                                               m + (actor.m_nDownDrawLevel * UNITY),
                                               FALSE,True);
                end;
           end;
           ErrorCode := 13;
           //������ħ���ط�
           if m_FlyList.Count > 0 then //20080629
           for k:=0 to m_FlyList.Count-1 do begin
              ErrorCode := 14;
              meff := TMagicEff(m_FlyList[k]);
              ErrorCode := 15;
              if meff <> nil then begin
                ErrorCode := 16;
                if j = (meff.Ry - Map.m_nBlockTop) then begin
                  ErrorCode := 17;
                   meff.DrawEff (m_ObjSurface);
                   ErrorCode := 18;
                end;
              end;
           end;
        end;
        Inc (m, UNITY);
     end;
   except
      DebugOutStr ('106 Code:'+IntToStr(ErrorCode));
   end;
   { 20080816ע����ʾ�ڰ�
   //�����Ч�������ߣ�
   try
   if g_boViewFog then begin
      m := defy - UNITY*4;
      for j:=(Map.m_ClientRect.Top - Map.m_nBlockTop - 4) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE) do begin
         if j < 0 then begin Inc (m, UNITY); continue; end;
         n := defx-UNITX*5;
         //��� ���� �׸���
         for i:=(Map.m_ClientRect.Left - Map.m_nBlockLeft-5) to (Map.m_ClientRect.Right - Map.m_nBlockLeft+5) do begin
            if (i >= 0) and (i < LOGICALMAPUNIT*3) and (j >= 0) and (j < LOGICALMAPUNIT*3) then begin
               idx := Map.m_MArr[i, j].btLight;
               if idx > 0 then begin
                  AddLight (i+Map.m_nBlockLeft, j+Map.m_nBlockTop, 0, 0, idx, FALSE);
               end;
            end;
            Inc (n, UNITX);
         end;
         Inc (m, UNITY);
      end;

      //ĳ���� ���� �׸���
      if m_ActorList.Count > 0 then begin
         for k:=0 to m_ActorList.Count-1 do begin
            actor := m_ActorList[k];
            if actor <> nil then begin
              if (actor = g_MySelf) or (actor.Light > 0) then
                 AddLight (actor.m_nRx, actor.m_nRy, actor.m_nShiftX, actor.m_nShiftY, actor.Light, actor=g_MySelf);
            end;
         end;
      end else begin
         if g_MySelf <> nil then
            AddLight (g_MySelf.m_nRx, g_MySelf.m_nRy, g_MySelf.m_nShiftX, g_MySelf.m_nShiftY, g_MySelf.Light, TRUE);
      end;
   end;
   except
      DebugOutStr ('107');
   end; }

   if not g_boServerChanging then begin
      try
      ErrorCode := 0;
      //**** ������״̬
         if g_MySelf.m_nState and $00800000 = 0 then 
            g_MySelf.DrawChr (m_ObjSurface, (g_MySelf.m_nRx-Map.m_ClientRect.Left)*UNITX+defx, (g_MySelf.m_nRy - Map.m_ClientRect.Top-1)*UNITY+defy, TRUE,FALSE);
      ErrorCode := 1;
      //**** ��ǰ���ָ��Ľ�ɫ
      if (g_FocusCret <> nil) then begin
        if (g_FocusCret.m_btRace = 50) then begin
          if g_FocusCret.m_wAppearance <> 54 then begin //ѩ��NPC
            if IsValidActor (g_FocusCret) and (g_FocusCret <> g_MySelf) then
              if (g_FocusCret.m_nState and $00800000 = 0) then //Jacky
                 g_FocusCret.DrawChr (m_ObjSurface,
                             (g_FocusCret.m_nRx - Map.m_ClientRect.Left)*UNITX+defx,
                             (g_FocusCret.m_nRy - Map.m_ClientRect.Top-1)*UNITY+defy, TRUE,FALSE);
          end;
        end else begin
         if IsValidActor (g_FocusCret) and (g_FocusCret <> g_MySelf) then
            if (g_FocusCret.m_nState and $00800000 = 0) then //Jacky
               g_FocusCret.DrawChr (m_ObjSurface,
                           (g_FocusCret.m_nRx - Map.m_ClientRect.Left)*UNITX+defx,
                           (g_FocusCret.m_nRy - Map.m_ClientRect.Top-1)*UNITY+defy, TRUE,FALSE);
        end;
      end;
      ErrorCode := 2;
      //**** ��ħ����ʱ����������ʾ
      if (g_MagicTarget <> nil) then begin
         if IsValidActor (g_MagicTarget) and (g_MagicTarget <> g_MySelf) then
            if g_MagicTarget.m_nState and $00800000 = 0 then //������ �ƴϸ�
               g_MagicTarget.DrawChr (m_ObjSurface,
                           (g_MagicTarget.m_nRx-Map.m_ClientRect.Left)*UNITX+defx,
                           (g_MagicTarget.m_nRy - Map.m_ClientRect.Top-1)*UNITY+defy, TRUE,FALSE);
      end;
      ErrorCode := 3;
      except
         DebugOutStr ('108 Code:'+IntToStr(ErrorCode));
      end;
   end;

   try
   ErrorCode := 0;
   //**** ����ɫЧ��
   if m_ActorList.Count > 0 then begin//20080629
    ErrorCode := 4;
     for k:=0 to m_ActorList.Count-1 do begin
       ErrorCode := 5;
        actor := m_ActorList[k];
        ErrorCode := 6;
        if actor <> nil then begin
          ErrorCode := 7;
          actor.DrawEff (m_ObjSurface,
                        (actor.m_nRx-Map.m_ClientRect.Left)*UNITX + defx,
                        (actor.m_nRy-Map.m_ClientRect.Top-1)*UNITY + defy);
        end;
     end;
   end;
   ErrorCode := 1;
   //��ħ��Ч��
   if m_EffectList.Count > 0 then begin//20080629
    ErrorCode := 8;
     for k:=0 to m_EffectList.Count-1 do begin
       ErrorCode := 9;
        meff := TMagicEff(m_EffectList[k]);
        ErrorCode := 10;
        if meff <> nil then begin
          ErrorCode := 11;
          meff.DrawEff (m_ObjSurface);
          ErrorCode := 12;
        end;
        {20080816ע����ʾ�ڰ�
        if g_boViewFog then begin
          ErrorCode := 12;
           AddLight (meff.Rx, meff.Ry, 0, 0, meff.Light, FALSE);
        end; }
     end;
   end;
   ErrorCode := 2;
   { 20080816ע����ʾ�ڰ�
   if g_boViewFog then begin
      if EventMan.EventList.Count > 0 then //20080629
      for k:=0 to EventMan.EventList.Count-1 do begin
         evn := TClEvent (EventMan.EventList[k]);
         if evn.m_nLight > 0 then
            AddLight (evn.m_nX, evn.m_nY, 0, 0, evn.m_nLight, FALSE);
      end;
   end;
   ErrorCode := 3; }
   except
      DebugOutStr ('109 Code:'+IntToStr(ErrorCode));
   end;   

   //������Ʒ����
  try
    ErrorCode := 0;
    if g_DropedItemList.Count > 0 then //20080629
    for k:=0 to g_DropedItemList.Count-1 do begin
      ErrorCode := 1;
      DropItem := PTDropItem (g_DropedItemList[k]);
      ErrorCode := 2;
      if DropItem <> nil then begin
        ErrorCode := 4;
        if GetTickCount - DropItem.FlashTime > 5000 then begin    //��˸
          DropItem.FlashTime := GetTickCount;
          DropItem.BoFlash := TRUE;
          DropItem.FlashStepTime := GetTickCount;
          DropItem.FlashStep := 0;
        end;
        ErrorCode := 5;
        ix := (DropItem.x - Map.m_ClientRect.Left) * UNITX + defx + SOFFX;
        iy := (DropItem.y - Map.m_ClientRect.Top - 1) * UNITY + defy + SOFFY;
        ErrorCode := 6;
        if DropItem.BoFlash then begin
          if GetTickCount - DropItem.FlashStepTime >= 20 then begin
            DropItem.FlashStepTime := GetTickCount;
            Inc (DropItem.FlashStep);
          end;
          ErrorCode := 7;
          if (DropItem.FlashStep >= 0) and (DropItem.FlashStep < 10) then begin
            ErrorCode := 8;
            DSurface := g_WMainImages.GetCachedImage (FLASHBASE + DropItem.FlashStep, ax, ay);
            ErrorCode := 9;
            DrawBlend (m_ObjSurface, ix + ax, iy + ay, DSurface, 1);
            ErrorCode := 10;
          end else DropItem.BoFlash := FALSE;
          ErrorCode := 11;
        end;
      end;
    end;
  ErrorCode := 3;
  except
    DebugOutStr('110 Code:'+IntToStr(ErrorCode));
  end;
   try
   ErrorCode := 0;
 // g_boViewFog:=False;      //Jacky ����
   (* 20080816ע����ʾ�ڰ�
   if  g_boViewFog {and not g_boForceNotViewFog 20080816ע������} then begin
      ApplyLightMap;
      DrawFog (m_ObjSurface, m_PFogScreen, m_nFogWidth);
      MSurface.Draw (SOFFX, SOFFY, m_ObjSurface.ClientRect, m_ObjSurface, FALSE);
   end else begin  *)
      if g_MySelf.m_boDeath then //������������ʾ�ڰ׻���
         DrawEffect (0, 0, m_ObjSurface.Width, m_ObjSurface.Height, m_ObjSurface, g_DeathColorEffect{ceGrayScale});

      MSurface.Draw (SOFFX, SOFFY, m_ObjSurface.ClientRect, m_ObjSurface, FALSE);
   //end;
   ErrorCode := 1;
   except
      DebugOutStr ('111 Code:'+IntToStr(ErrorCode));
   end;
   {if g_boViewMiniMap then begin
      DrawMiniMap (MSurface);
   end; }   //20080323
end;

{------------------------------------------------------------------------------}
//ʵ����ָ��Ŀ�겥��ĳ��ħ��Ч��(20071029 ����)
//NewMagic(aowner, magid,magnumb,cx,cy,tx,ty,targetcode,mtype,Recusion,anitime,bofly)
//
//
//        �����Ժ�����
//
//
//
{------------------------------------------------------------------------------}
//cx, cy, tx, ty : ���� ��ǥ
procedure TPlayScene.NewMagic (aowner: TActor;
                               magid, magnumb{Effect}, cx, cy, tx, ty, targetcode: integer;
                               mtype: TMagicType; //EffectType
                               Recusion: Boolean;
                               anitime: integer;
                               var boFly: Boolean);
var
   i, scx, scy, sctx, scty, effnum: integer;
   meff: TMagicEff;
   target: TActor;
   wimg: TWMImages;
begin
  try
   boFly := FALSE;
   if magid <> 111 then //
      if m_EffectList.Count > 0 then //20080629
      for i:=0 to m_EffectList.Count-1 do
         if TMagicEff(m_EffectList[i]).ServerMagicId = magid then exit;
         
   ScreenXYfromMCXY (cx, cy, scx, scy);
   ScreenXYfromMCXY (tx, ty, sctx, scty);
   if magnumb > 0 then GetEffectBase (magnumb-1, 0, wimg, effnum)  //magnumbΪEffect
   else effnum := -Magnumb;
   Target := FindActor (Targetcode);//Ŀ��
   meff := nil;

   case mtype of  //EffectType
      mtReady, mtFly, mtFlyAxe: begin
        case magnumb of
          39: begin  //������
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.TargetActor := target;
            meff.frame := 4;
            if wimg <> nil then meff.ImgLib:=wimg;
          end;
          63: begin  //�ɻ�����
            meff := TFireFixedEffect.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.TargetActor := target;
            meff.ExplosionFrame:=36;
            if wimg <> nil then meff.ImgLib := wimg;
          end;
          42: begin  //������
            meff := TfenshenThunder.Create (10, scx, scy, sctx, scty, aowner);
            if wimg <> nil then meff.ImgLib:=wimg;
          end;
          100: begin //������ͨ����
            Effnum := 100;
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.TargetActor := target; //nil;//��Ŀ��
            meff.NextFrameTime := 120;
            meff.frame := 3;
            if wimg <> nil then meff.ImgLib:=g_WMagic5Images;
          end;
          101: begin
            Effnum := 280;
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.TargetActor := target; //nil;//��Ŀ��
            meff.NextFrameTime := 120;
            meff.frame := 3;
            if wimg <> nil then meff.ImgLib:=g_WMagic5Images;
          end;
          102: begin
            Effnum := 130;
            meff := TFireDragonEffect.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.TargetActor := target; //nil;//��Ŀ��
            meff.NextFrameTime := 120;
            meff.MagExplosionBase := 200;
            meff.ExplosionFrame:=20;
            if wimg <> nil then meff.ImgLib:=g_WDragonImages;
          end;
          60: meff := TPHHitEffect.Create (0, scx, scy, sctx, scty, aowner);
          else begin
             meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
             meff.TargetActor := target;
          end;
        end;
        bofly := TRUE;
      end;
      mtExplosion:
        case magnumb of
          18: begin //�ջ�֮��
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1570;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
          end;
          19: begin  //���л�λ 20080424
            meff := nil;
          end;
          21: begin //���ѻ���
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1660;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.Light := 3;
          end;
          26: begin //������ʾ
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 3990;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.Light := 2;
          end;
          27: begin //Ⱥ��������
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1800;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.Light := 3;
          end;
          30: begin //ʥ����
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 3930;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 16;
            meff.Light := 3;
          end;
          31: begin //������
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 3850;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.Light := 3;
          end;
          34: begin //�����
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 140;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.Light := 3;                      
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
          40: begin // ������
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 620;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.Light := 3;
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
          45: begin //��������
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 920;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.Light := 3;
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
          47: begin //쫷���
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1010;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.Light := 3;
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
          48: begin //Ѫ��
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1060;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 50;
            meff.ExplosionFrame := 20;
            meff.Light := 3;
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
          49: begin //������
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1110;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.Light := 3;
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
          51: begin //���ǻ��� 20080510
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 640;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 70;
            meff.ExplosionFrame := 30;
            meff.Light := 3;
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
          102: begin //�������� ����
            Effnum := 3730;
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 3730;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 200;
            meff.ExplosionFrame := 10;
            meff.Light := 3;
            if wimg <> nil then meff.ImgLib:=g_WMonImagesArr[23];
          end;
          else begin //Ĭ��
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
         end;
      end;
      mtFireWind:
         if magnumb = 35 then begin
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtExplosion, Recusion, anitime);
            meff.MagExplosionBase := 165;//Ϊwil���idx
            meff.TargetActor := TActor(aowner); //nil;//��Ŀ��
            meff.NextFrameTime := 60; //ʱ��
            meff.ExplosionFrame := 10; //���󲥷ŵ�֡��
            if wimg <> nil then
              meff.ImgLib:=wimg;
         end else
         meff := nil; 
      mtFireGun: //ȭ�����    //���һ���
         meff := TFireGunEffect.Create (930, scx, scy, sctx, scty);
      mtThunder: begin//�׵���
        case magnumb of
          9,80,70{Ⱥ���׵�},71,72,73,74: begin
             meff := TThuderEffect.Create (10, sctx, scty, nil); //target);
             meff.ExplosionFrame := 6;
             meff.ImgLib := g_WMagic2Images;
          end;
          61: begin //Ӣ�ۺϻ� ����ն ����2007.10.29
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtExplosion, Recusion, anitime);
            meff.MagExplosionBase := 495;//Ϊwil���idx
            meff.TargetActor := nil; //nil;//��Ŀ��
            meff.NextFrameTime := 80; //ʱ��
            meff.ExplosionFrame := 19; //���󲥷ŵ�֡��
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
          62: begin //Ӣ�ۺϻ� ����һ�� ����2007.10.31
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtExplosion, Recusion, anitime);
            meff.MagExplosionBase := 390;//Ϊwil���idx
            meff.TargetActor := nil; //nil;//��Ŀ��
            meff.NextFrameTime := 80; //ʱ��
            meff.ExplosionFrame := 25; //���󲥷ŵ�֡��
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
          64: begin //Ӣ�ۺϻ� ĩ������ ����2007.10.29
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtExplosion, Recusion, anitime);
            meff.MagExplosionBase := 230;//Ϊwil���idx
            meff.TargetActor := nil; //nil;//��Ŀ��
            meff.NextFrameTime := 80; //ʱ��
            meff.ExplosionFrame := 27; //���󲥷ŵ�֡��
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
           65: begin //Ӣ�ۺϻ� �������� ����2007.10.29
            meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtExplosion, Recusion, anitime);
            meff.MagExplosionBase := 561;//Ϊwil���idx
            meff.TargetActor := nil; //nil;//��Ŀ��
            meff.NextFrameTime := 80; //ʱ��
            meff.ExplosionFrame := 37; //���󲥷ŵ�֡��
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
        end;
      end;
      mtRedThunder: begin
        meff := TRedThunderEffect.Create (230, sctx, scty, nil); 
        meff.ExplosionFrame := 6;
      end;
      mtLava: begin
        case magnumb of
          91: meff := TLavaEffect.Create (470, sctx, scty, nil, 10);//�ҽ�
          92: meff := TLavaEffect.Create (350, sctx, scty, nil, 34);//�����ػ�����Ч��
        end;
      end;
      mtLightingThunder:   //�����Ӱ ħ��
         meff := TLightingThunder.Create (970, scx, scy, sctx, scty, target);
      mtExploBujauk: begin
        case magnumb of
         100: begin  //4������� 20080111
            meff := TExploBujaukEffect.Create (140, scx, scy, sctx, scty, target);
            meff.MagExplosionBase := 300;
            meff.TargetActor := target; //nil;//��Ŀ��
            meff.NextFrameTime := 80; //ʱ��
            meff.ExplosionFrame := 4; //���󲥷ŵ�֡��
            if wimg <> nil then
              meff.ImgLib:=wimg;
          end;
          10: begin  //�����
            meff := TExploBujaukEffect.Create (1160, scx, scy, sctx, scty, target);
            meff.MagExplosionBase := 1360;
            meff.NextFrameTime := 80; //ʱ��
          end;
          17: begin  //����������
            meff := TExploBujaukEffect.Create (1160, scx, scy, sctx, scty, target);
            meff.MagExplosionBase := 1540;
          end;
        end;
        bofly := TRUE;
      end;
      mtBujaukGroundEffect: begin
        meff := TBujaukGroundEffect.Create (1160, magnumb, scx, scy, sctx, scty);
        case magnumb of
          11: meff.ExplosionFrame := 16; //�����
          12: meff.ExplosionFrame := 16; //��ʥս����
          46: meff.ExplosionFrame := 24; //������
        end;
        bofly := TRUE;
      end;
      mtKyulKai: begin
        meff := nil; //TKyulKai.Create (1380, scx, scy, sctx, scty);
      end;
      mt12: begin

      end;
      mt13: begin
        meff := TMagicEff.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
        if meff <> nil then begin
          case magnumb of
            32: begin
              meff.ImgLib := {FrmMain.WMon21Img20080720ע��}g_WMonImagesArr[20];
              meff.MagExplosionBase:=3580;
              meff.TargetActor := target;
              meff.Light := 3;
              meff.NextFrameTime := 20;
            end;
            37: begin
              meff.ImgLib := {FrmMain.WMon22Img20080720ע��}g_WMonImagesArr[21];
              meff.MagExplosionBase:=3520;
              meff.TargetActor := target;
              meff.Light := 5;
              meff.NextFrameTime := 20;
            end;
          end;
        end;
      end;
      mt14: begin
        case magnumb of
          101: begin
            meff := TThuderEffect.Create (100, sctx, scty, nil); //target);
            meff.ExplosionFrame := 15;
            meff.ImgLib := g_WMagic6Images;
          end;
          34: begin
            meff := TThuderEffect.Create (140, sctx, scty, nil); //target);
            meff.ExplosionFrame := 10;
            meff.ImgLib := g_WMagic2Images;
          end;
        end;
      end;
      mt15: begin
        meff := TFlyingBug.Create (magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
        meff.TargetActor := target;
        bofly:=True;
      end;
      mt16: begin

      end;

   end;
   if (meff = nil) then Exit;

   meff.TargetRx := tx;
   meff.TargetRy := ty;
   if meff.TargetActor <> nil then begin
      meff.TargetRx := TActor(meff.TargetActor).m_nCurrX;
      meff.TargetRy := TActor(meff.TargetActor).m_nCurrY;
   end;
   meff.MagOwner := aowner;
   m_EffectList.Add (meff);
  except
    DebugOutStr('TPlayScene.NewMagic'+IntToStr(magnumb));
  end;
end;

//cx, cy, tx, ty : ���� ��ǥ
function  TPlayScene.NewFlyObject (aowner: TActor; cx, cy, tx, ty, targetcode: integer;  mtype: TMagicType): TMagicEff;
var
   scx, scy, sctx, scty: integer;
   meff: TMagicEff;
begin
   ScreenXYfromMCXY (cx, cy, scx, scy);
   ScreenXYfromMCXY (tx, ty, sctx, scty);
   case mtype of
      mtFlyArrow: meff := TFlyingArrow.Create (1, 1, scx, scy, sctx, scty, mtype, TRUE, 0);
      mt12: meff := TFlyingFireBall.Create (1, 1, scx, scy, sctx, scty, mtype, TRUE, 0);
      mt15: meff := TFlyingBug.Create (1, 1, scx, scy, sctx, scty, mtype, TRUE, 0);
      else meff := TFlyingAxe.Create (1, 1, scx, scy, sctx, scty, mtype, TRUE, 0);
   end;
   meff.TargetRx := tx;
   meff.TargetRy := ty;
   meff.TargetActor := FindActor (targetcode);
   meff.MagOwner := aowner;
   m_FlyList.Add (meff);
   Result := meff;
end;

procedure TPlayScene.ScreenXYfromMCXY (cx, cy: integer; var sx, sy: integer);
begin
   if g_MySelf = nil then exit;
     if SWH = SWH800 then begin
       sx := (cx-g_MySelf.m_nRx)*UNITX + 364 + UNITX div 2 - g_MySelf.m_nShiftX;
       sy := (cy-g_MySelf.m_nRy)*UNITY + 192 + UNITY div 2 - g_MySelf.m_nShiftY;
       exit;
     end else
       sx := (cx-g_MySelf.m_nRx)*UNITX + 505 + UNITX div 2 - g_MySelf.m_nShiftX;
       sy := (cy-g_MySelf.m_nRy)*UNITY + 290 + UNITY div 2 - g_MySelf.m_nShiftY;
end;

//��Ļ���� mx, myת����ccx, ccy��ͼ����
procedure TPlayScene.CXYfromMouseXY (mx, my: integer; var ccx, ccy: integer);
begin
   if g_MySelf = nil then exit;
{$IF SWH = SWH800}
   ccx := UpInt((mx - 364 + g_MySelf.m_nShiftX - UNITX) / UNITX) + g_MySelf.m_nRx;
   ccy := UpInt((my - 192 + g_MySelf.m_nShiftY - UNITY) / UNITY) + g_MySelf.m_nRy;
{$ELSEIF SWH = SWH1024}
   ccx := Round((mx - 485{364}  + g_MySelf.m_nShiftX - UNITX) / UNITX) + g_MySelf.m_nRx;
   ccy := Round((my - 270{192} + g_MySelf.m_nShiftY - UNITY) / UNITY) + g_MySelf.m_nRy;
{$IFEND}
end;

//ȭ����ǥ�� ĳ����, �ȼ� ������ ����..
function  TPlayScene.GetCharacter (x, y, wantsel: integer; var nowsel: integer; liveonly: Boolean): TActor;
var
   k, i, ccx, ccy, dx, dy: integer;
   a: TActor;
begin
   Result := nil;
   nowsel := -1;
   CXYfromMouseXY (x, y, ccx, ccy);
   for k:=ccy+8 downto ccy-1 do begin
      if m_ActorList.Count > 0 then begin//20080629
        for i:=m_ActorList.Count-1 downto 0 do
           if TActor(m_ActorList[i]) <> g_MySelf then begin
              a := TActor(m_ActorList[i]);
              if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and (a.m_boVisible) then begin
                 if a.m_nCurrY = k then begin
                    //�� ���� ������ ���õǰ�
                    dx := (a.m_nRx-Map.m_ClientRect.Left)*UNITX + m_nDefXX + a.m_nPx + a.m_nShiftX;
                    dy := (a.m_nRy-Map.m_ClientRect.Top-1)*UNITY + m_nDefYY + a.m_nPy + a.m_nShiftY;
                    if a.CheckSelect (x-dx, y-dy) then begin
                       Result := a;
                       Inc (nowsel);
                       if nowsel >= wantsel then Exit;
                    end;
                 end;
              end;
           end;
      end;
   end;
end;

//ȡ�������ָ����Ľ�ɫ
function  TPlayScene.GetAttackFocusCharacter (x, y, wantsel: integer; var nowsel: integer; liveonly: Boolean): TActor;
var
   k, i, ccx, ccy, dx, dy, centx, centy: integer;
   a: TActor;
begin
   Result := GetCharacter (x, y, wantsel, nowsel, liveonly);
   if Result = nil then begin
      nowsel := -1;
      CXYfromMouseXY (x, y, ccx, ccy);
      for k:=ccy+8 downto ccy-1 do begin
         if m_ActorList.Count > 0 then //20080629
         for i:=m_ActorList.Count-1 downto 0 do
            if TActor(m_ActorList[i]) <> g_MySelf then begin
               a := TActor(m_ActorList[i]);
               if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and (a.m_boVisible) then begin
                  if a.m_nCurrY = k then begin
                     dx := (a.m_nRx-Map.m_ClientRect.Left)*UNITX + m_nDefXX + a.m_nPx + a.m_nShiftX;
                     dy := (a.m_nRy-Map.m_ClientRect.Top-1)*UNITY+ m_nDefYY + a.m_nPy + a.m_nShiftY;
                     if a.CharWidth > 40 then centx := (a.CharWidth - 40) div 2
                     else centx := 0;
                     if a.CharHeight > 70 then centy := (a.CharHeight - 70) div 2
                     else centy := 0;
                     if (x-dx >= centx) and (x-dx <= a.CharWidth-centx) and (y-dy >= centy) and (y-dy <= a.CharHeight-centy) then begin
                        Result := a;
                        Inc (nowsel);
                        if nowsel >= wantsel then Exit;
                     end;
                  end;
               end;
            end;
      end;
   end;
   //if (Result.m_btRace = 50) and (Result.m_wAppearance in [54..58]) then Result := nil;
end;

function  TPlayScene.IsSelectMyself (x, y: integer): Boolean;
var
  k, ccx, ccy, dx, dy: integer;
begin
  Result := FALSE;
  CXYfromMouseXY (x, y, ccx, ccy);
  for k:=ccy+2 downto ccy-1 do begin
    if g_MySelf.m_nCurrY = k then begin
      //�� ���� ������ ���õǰ�
      dx:=(g_MySelf.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + g_MySelf.m_nPx + g_MySelf.m_nShiftX;
      dy:=(g_MySelf.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + g_MySelf.m_nPy + g_MySelf.m_nShiftY;
      if g_MySelf.CheckSelect (x-dx, y-dy) then begin
        Result := TRUE;
        exit;
      end;
    end;
  end;
end;
{
//ȡ��ָ�����������Ʒ
// x,y Ϊ��Ļ����
function  TPlayScene.GetDropItems (x, y: integer; var inames: string): PTDropItem; //ȭ����ǥ�� ������
var
  k, i, ccx, ccy, ssx, ssy, dx, dy: integer;
  DropItem:PTDropItem;
  s: TDirectDrawSurface;
  c: byte;
begin
  Result := nil;
  CXYfromMouseXY (x, y, ccx, ccy);
  ScreenXYfromMCXY (ccx, ccy, ssx, ssy);
  dx := x - ssx;
  dy := y - ssy;
  inames := '';
  for i:=0 to g_DropedItemList.Count-1 do begin
    DropItem := PTDropItem(g_DropedItemList[i]);
    if (DropItem.X = ccx) and (DropItem.Y = ccy) then begin

      s := g_WDnItemImages.Images[DropItem.Looks];
      if s = nil then continue;
      dx := (x - ssx) + (s.Width div 2) - 3;
      dy := (y - ssy) + (s.Height div 2);
      c := s.Pixels[dx, dy];
      if c <> 0 then begin

        if Result = nil then Result := DropItem;
        inames := inames + DropItem.Name + '\';
        //break;
      end;
    end;
  end;
end;
}

//ȡ��ָ�����������Ʒ
// x,y Ϊ��Ļ����
function  TPlayScene.GetDropItems (x, y: integer; var inames: string): PTDropItem;
var
   i, ccx, ccy, ssx, ssy: integer;
   d: PTDropItem;
begin
   Result := nil;
   CXYfromMouseXY (x, y, ccx, ccy);
   ScreenXYfromMCXY (ccx, ccy, ssx, ssy);
   inames := '';
   if g_DropedItemList.Count > 0 then //20080629
   for i:=0 to g_DropedItemList.Count-1 do begin
      d := PTDropItem(g_DropedItemList[i]);
      if (d.X = ccx) and (d.Y = ccy) then begin        // ��������ƶ�����Ʒ����ʾ���ֺ���  20080314
         {s := FrmMain.WDnItem.Images[d.Looks];        // �������Ʒ�Ƿ������ͼƬ
         if s = nil then continue;
         dx := (x - ssx) + (s.Width div 2) - 3;
         dy := (y - ssy) + (s.Height div 2);
         c := s.Pixels[dx, dy];
         if c <> 0 then }begin 
            if Result = nil then Result := d;
            inames := inames + d.Name + '\';   
            //break;
         end;
      end;
   end;
end;
procedure TPlayScene.GetXYDropItemsList(nX,nY:Integer;var ItemList:TList);
var
  I:Integer;
  DropItem:pTDropItem;
begin
  if g_DropedItemList.Count > 0 then //20080629
  for I:= 0 to g_DropedItemList.Count - 1 do begin
    DropItem:=g_DropedItemList[i];
    if (DropItem.X = nX) and (DropItem.Y = nY) then begin
      ItemList.Add(DropItem);
    end;
  end;
end;

{function TPlayScene.GetXYDropItems(nX, nY: Integer): pTDropItem;
var
  I:Integer;
  DropItem:pTDropItem;
begin
  Result:=nil;
  if g_DropedItemList.Count > 0 then //20080629
  for I:= 0 to g_DropedItemList.Count - 1 do begin
    DropItem:=g_DropedItemList[i];
    if (DropItem.X = nX) and (DropItem.Y = nY) then begin
      Result:=DropItem;
      break;
    end;
  end;
end; }

function  TPlayScene.CanRun (sx, sy, ex, ey: integer): Boolean;
var
   ndir, rx, ry: integer;
begin
   ndir := GetNextDirection (sx, sy, ex, ey);
   rx := sx;
   ry := sy;
   GetNextPosXY (ndir, rx, ry);

   if Map.CanMove (rx, ry) and Map.CanMove (ex, ey) then
     Result:=True
   else Result:=False;

   if CanWalkEx (rx, ry) and CanWalkEx (ex, ey) then
      Result := TRUE
   else Result := FALSE;
end;
function  TPlayScene.CanWalkEx (mx, my: integer): Boolean;
begin
   Result := FALSE;
   if Map.CanMove(mx,my) then
      Result := not CrashManEx (mx, my);   {true;} //����
end;
//����
function  TPlayScene.CrashManEx (mx, my: integer): Boolean;
var
  I:Integer;
  Actor:TActor;
begin    
  Result := False;
  if m_ActorList.Count > 0 then //20080629
  for i:=0 to m_ActorList.Count-1 do begin
    Actor:= TActor(m_ActorList[i]);
    if (Actor.m_boVisible) and (Actor.m_boHoldPlace) and (not Actor.m_boDeath) and (Actor.m_nCurrX = mx) and (Actor.m_nCurrY = my) then begin
//      DScreen.AddChatBoardString ('Actor.m_btRace ' + IntToStr(Actor.m_btRace),clWhite, clRed);
      if (Actor.m_btRace in [RCC_USERHUMAN,1,150]) and g_boCanRunHuman then Continue;
      if (Actor.m_btRace = RCC_MERCHANT) and g_boCanRunNpc then Continue;
      if (Actor.m_btRace <> 0) and (Actor.m_btRace <> 50) and g_boCanRunMon then Continue;
      //if ((Actor.m_btRace > RCC_USERHUMAN) and (Actor.m_btRace <> RCC_MERCHANT)) and g_boCanRunMon then Continue;
      //m_btRace ���� 0 �������� 50 ��Ϊ����
      Result:=True;
      break;
    end;
  end;
end;

function  TPlayScene.CanWalk (mx, my: integer): Boolean;
begin
   Result := FALSE;
   if Map.CanMove(mx,my) then
      Result := not CrashMan (mx, my);
end;

function  TPlayScene.CrashMan (mx, my: integer): Boolean;
var
   i: integer;
   a: TActor;
begin
   Result := FALSE;
   if m_ActorList.Count > 0 then //20080629
   for i:=0 to m_ActorList.Count-1 do begin
      a := TActor(m_ActorList[i]);
      if (a.m_boVisible) and (a.m_boHoldPlace) and (not a.m_boDeath) and (a.m_nCurrX = mx) and (a.m_nCurrY = my) then begin
         Result := TRUE;
         break;
      end;
   end;
end;

{function  TPlayScene.CanFly (mx, my: integer): Boolean;
begin
   Result := Map.CanFly (mx, my);
end; }


{------------------------ Actor ------------------------}
//ͨ��ID ���������ɫ
function  TPlayScene.FindActor (id: integer): TActor;
var
   i: integer;
begin
   Result := nil;
   if m_ActorList.Count > 0 then //20080629
   for i:=0 to m_ActorList.Count-1 do begin
      if TActor(m_ActorList[i]).m_nRecogId = id then begin
         Result := TActor(m_ActorList[i]);
         break;
      end;
   end;
end;
//ͨ�������������ɫ
function TPlayScene.FindActor(sName: String): TActor;
var
  I:Integer;
  Actor:TActor;
begin
  Result := nil;
  if m_ActorList.Count > 0 then //20080629
  for I:=0 to m_ActorList.Count-1 do begin
    Actor:=TActor(m_ActorList[i]);
    if CompareText(Actor.m_sUserName,sName) = 0 then begin
      Result:=Actor;
      break;
    end;
  end;
end;
//��X��Y�����������ɫ
function  TPlayScene.FindActorXY (x, y: integer): TActor;
var
   i: integer;
begin
   Result := nil;
   if m_ActorList.Count > 0 then //20080629
   for i:=0 to m_ActorList.Count-1 do begin
      if (TActor(m_ActorList[i]).m_nCurrX = x) and (TActor(m_ActorList[i]).m_nCurrY = y) then begin
         Result := TActor(m_ActorList[i]);
         if not Result.m_boDeath and Result.m_boVisible and Result.m_boHoldPlace then break;
      end;
   end;
end;
//�б����Ƿ��������ɫ
function  TPlayScene.IsValidActor (actor: TActor): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if m_ActorList.Count > 0 then //20080629
   for i:=0 to m_ActorList.Count - 1 do begin
      if TActor(m_ActorList[i]) = actor then begin
         Result := TRUE;
         break;
      end;
   end;
end;

function  TPlayScene.NewActor (chrid:     integer;  //��ɫID
                               cx:        word; //x
                               cy:        word; //y
                               cdir:      word;
                               cfeature:  integer; //race, hair, dress, weapon
                               cstate:    integer): TActor;
var
   i: integer;
   actor: TActor;
begin
   Result:=nil;//jacky
   //��������ɫ�Ƿ��Ѿ����ڽ�ɫ�б��У������ڣ����ô���
   if m_ActorList.Count > 0 then //20080629
   for i:=0 to m_ActorList.Count-1 do
      if TActor(m_ActorList[i]).m_nRecogId = chrid then begin
         Result := TActor(m_ActorList[i]);
         Exit;
      end;
   if IsChangingFace (chrid) then exit;  //������...
   //����Race������Ӧ�Ľ�ɫ����
   case RACEfeature (cfeature) of //m_btRaceImg
      0:  actor := THumActor.Create;              //����
      1:  actor := THumActor.Create;              //Ӣ��
      9:  actor := TSoccerBall.Create;            //����
      13: actor := TKillingHerb.Create;           //ʳ�˻�
      14: actor := TSkeletonOma.Create;           //����
      15: actor := TDualAxeOma.Create;            //��������

      16: actor := TGasKuDeGi.Create;             //����

      17: actor := TCatMon.Create;                //��צè
      18: actor := THuSuABi.Create;               //������
      19: actor := TCatMon.Create;                //����սʿ

      20: actor := TFireCowFaceMon.Create;        //��������
      21: actor := TCowFaceKing.Create;           //�������
      22: actor := TDualAxeOma.Create;            //�ڰ�սʿ
      23: actor := TWhiteSkeleton.Create;         //��������
      24: actor := TSuperiorGuard.Create;         //������ʿ
      30: actor := TCatMon.Create; //������
      31: actor := TCatMon.Create;                //��Ӭ
      32: actor := TScorpionMon.Create;           //Ы��

      33: actor := TCentipedeKingMon.Create;      //������
      34: actor := TBigHeartMon.Create;           //���¶�ħ
      35: actor := TSpiderHouseMon.Create;        //��Ӱ֩��
      36: actor := TExplosionSpider.Create;       //��ħ֩��
      37: actor := TFlyingSpider.Create;       //

      40: actor := TZombiLighting.Create;         //��ʬ1
      41: actor := TZombiDigOut.Create;           //��ʬ2
      42: actor := TZombiZilkin.Create;           //��ʬ3

      43: actor := TBeeQueen.Create;              //��Ӭ��

      45: actor := TArcherMon.Create;             //������
      47: actor := TSculptureMon.Create;          //�������
      48: actor := TSculptureMon.Create;          //
      49: actor := TSculptureKingMon.Create;      //�������

      50: actor := TNpcActor.Create;

      52: actor := TGasKuDeGi.Create;             //Ш��
      53: actor := TGasKuDeGi.Create;             //���
      54: actor := TSmallElfMonster.Create;       //����
      55: actor := TWarriorElfMonster.Create;     //����1

      60: actor := TElectronicScolpionMon.Create;
      61: actor := TBossPigMon.Create;
      62: actor := TKingOfSculpureKingMon.Create;
      63: actor := TSkeletonKingMon.Create;
      64: actor := TGasKuDeGi.Create;       
      65: actor := TSamuraiMon.Create;
      66: actor := TSkeletonSoldierMon.Create;
      67: actor := TSkeletonSoldierMon.Create;
      68: actor := TSkeletonSoldierMon.Create;
      69: actor := TSkeletonArcherMon.Create;
      70: actor := TBanyaGuardMon.Create;//ţħ��ʦ
      71: actor := TBanyaGuardMon.Create;//ţħ��˾
      72: actor := TBanyaGuardMon.Create;//��֮ţħ��
      73: actor := TPBOMA1Mon.Create;
      74: actor := TCatMon.Create;
      75: actor := TStoneMonster.Create;
      76: actor := TSuperiorGuard.Create;
      77: actor := TStoneMonster.Create;
      78: actor := TBanyaGuardMon.Create;  //ħ����
      79: actor := TPBOMA6Mon.Create;
      80: actor := TMineMon.Create;
      81: actor := TAngel.Create;
      83: actor := TFireDragon.Create;           //��������  20080304
      84: actor := TDragonStatue.Create;
      90: actor := TDragonBody.Create;            //��
      //91: actor := TTempleGuardian.Create;   //ʥ����ʿ 20080809
      91: actor := TRedThunderZuma.create;
      92: actor := TheCrutchesSpider.Create;  //����֩��
      93: actor := TYanLeiWangSpider.Create;  //�������� 20080812
      94: actor := TSnowy.Create; //ѩ�򺮱�ħ��ѩ������ħ��ѩ���嶾ħ
      95: actor := TFireDragonGuard.Create; //�����ػ���
      96: actor := TSwordsmanMon.Create;
      97: actor := TSwordsmanMon.Create;
      98: actor := TWallStructure.Create;         //LeftWall
      99: actor := TCastleDoor.Create;            //MainDoor
     100: actor := TFairyMonster.Create;    //����
     150: actor := THumActor.Create;              //����
      else actor := TActor.Create;
   end;

   with actor do begin
      m_nRecogId := chrid;
      m_nCurrX     := cx;
      m_nCurrY     := cy;
      m_nRx        := m_nCurrX;
      m_nRy        := m_nCurrY;
      m_btDir      := cdir;
      m_nFeature   := cfeature;
      m_btRace     := RACEfeature(cfeature);         //����
      m_btHair     := HAIRfeature(cfeature);         //ͷ��
      m_btDress    := DRESSfeature(cfeature);        //��װ
      m_btWeapon   := WEAPONfeature(cfeature);       //����
      m_wAppearance:= APPRfeature(cfeature);         //��ò

      //m_Action     := GetMonAction(m_wAppearance);
      if m_btRace in [0,1,150] then begin      //����,Ӣ��,����20080629
        m_btSex := m_btDress mod 2;   //0:�� 1:Ů
      end else begin
        m_btSex := 0;
      end;
      m_nState  := cstate;
      m_SayingArr[0] := '';
   end;
   m_ActorList.Add(actor);
   Result := actor;
end;
//��ɫ�������Ѹý�ɫɾ����Ȼ�����·ŵ���ɫ�б��еĵ�һ��δ������ɫǰ��
procedure TPlayScene.ActorDied (actor: TObject);
var
   i: integer;
   flag: Boolean;
begin
  try
   if m_ActorList.Count > 0 then //20080629
   for i:=0 to m_ActorList.Count-1 do
      if m_ActorList[i] = actor then begin
         m_ActorList.Delete (i);
         break;
      end;
   flag := FALSE;
   if m_ActorList.Count > 0 then //20080629
   for i:=0 to m_ActorList.Count-1 do
      if not TActor(m_ActorList[i]).m_boDeath then begin
         m_ActorList.Insert (i, actor);
         flag := TRUE;
         break;
      end;
   if not flag then m_ActorList.Add (actor);
  except
    DebugOutStr('TPlayScene.ActorDied');
  end;
end;
//���ý�ɫ����ʾ�㼶����ɫ�б��˳��
//��Level=0ʱ������ָ���Ľ�ɫ���ڽ�ɫ�б����ǰ��
procedure TPlayScene.SetActorDrawLevel (actor: TObject; level: integer);
var
   i: integer;
begin
  try
   if level = 0 then begin
      if m_ActorList.Count > 0 then //20080629
      for i:=0 to m_ActorList.Count-1 do
         if m_ActorList[i] = actor then begin
            m_ActorList.Delete (i);
            m_ActorList.Insert (0, actor);
            break;
         end;
   end;
  except
    DebugOutStr('TPlayScene.SetActorDrawLevel');
  end;
end;
//������н�ɫ
procedure TPlayScene.ClearActors;  //�α׾ƿ��� ���
var
   i: integer;
begin
  try
   if m_ActorList.Count > 0 then begin//20080629
     for i:=0 to m_ActorList.Count-1 do
        TActor(m_ActorList.Items[i]).Free;
     m_ActorList.Clear;
   end;
   g_MySelf := nil;
   g_HeroSelf := nil;
   g_TargetCret := nil;
   g_FocusCret := nil;
   g_MagicTarget := nil;

   //���ħ��Ч������
   if m_EffectList.Count > 0 then begin//20080629
     for i:=0 to m_EffectList.Count-1 do
        TMagicEff (m_EffectList[i]).Free;
     m_EffectList.Clear;
   end;
  except
    DebugOutStr('TPlayScene.ClearActors');
  end;
end;
//���ݽ�ɫIDɾ��һ����ɫ
function  TPlayScene.DeleteActor (id: integer): TActor;
var
   i: integer;
begin
  try
   Result := nil;
   i := 0;
   while TRUE do begin
      if i >= m_ActorList.Count then break;
      if TActor(m_ActorList[i]).m_nRecogId = id then begin
         if g_TargetCret = TActor(m_ActorList[i]) then g_TargetCret := nil;
         if g_FocusCret = TActor(m_ActorList[i]) then g_FocusCret := nil;
         if g_MagicTarget = TActor(m_ActorList[i]) then g_MagicTarget := nil;
         TActor(m_ActorList[i]).m_dwDeleteTime := GetTickCount;
         g_FreeActorList.Add (m_ActorList[i]);
         //TActor(ActorList[i]).Free;
         m_ActorList.Delete (i);
      end else
         Inc (i);
   end;
  except
    DebugOutStr('TPlayScene.DeleteActor');
  end;
end;
//�ӽ�ɫ�б���ɾ��һ����ɫ
procedure TPlayScene.DelActor (actor: TObject);
var
   i: integer;
begin
  try
   if m_ActorList.Count > 0 then //20080629
   for i:=0 to m_ActorList.Count-1 do
      if m_ActorList[i] = actor then begin
         TActor(m_ActorList[i]).m_dwDeleteTime := GetTickCount;
         g_FreeActorList.Add (m_ActorList[i]);
         m_ActorList.Delete (i);
         break;
      end;
  except
    DebugOutStr('TPlayScene.DelActor');
  end;
end;
//��������(X,Y)���Ľ�ɫ�������ɫ�Ѿ��������Ҳ�������
function  TPlayScene.ButchAnimal (x, y: integer): TActor;
var
   i: integer;
   a: TActor;
begin
  try
   Result := nil;
   if m_ActorList.Count > 0 then //20080629
   for i:=0 to m_ActorList.Count-1 do begin
      a := TActor(m_ActorList[i]);
      if a.m_boDeath and (a.m_btRace <> 0) then begin //2008.01.20 ���͹ֺ������ͻ
         if (abs(a.m_nCurrX - x) <= 1) and (abs(a.m_nCurrY - y) <= 1) then begin
            Result := a;
            break;
         end;
      end;
   end;
  except
    DebugOutStr('TPlayScene.ButchAnimal');
  end;
end;




{------------------------- Msg -------------------------}
//�޼����� ���۸��ϴ� ������ ?
//ĳ������ �޼��� ���ۿ� �޼����� ���� �ִ� ���¿���
//���� �޼����� ó���Ǹ� �ȵǱ� ������.
procedure TPlayScene.SendMsg (ident, chrid, x, y, cdir, feature, state: integer; str: string);
var
   actor: TActor;
begin
  try
   case ident of
      SM_TEST:
         begin
            actor := NewActor (111, 254{x}, 214{y}, 0, 0, 0);
            g_MySelf := THumActor (actor);
            Map.LoadMap ('0', g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
         end;
      SM_CHANGEMAP,
      SM_NEWMAP: begin
        Map.LoadMap (str, x, y);
        { 20080816ע����ʾ�ڰ�
        DarkLevel := cdir;
        if DarkLevel = 0 then g_boViewFog := FALSE
        else g_boViewFog := TRUE;  }
            //
        if g_boViewMiniMap then begin
          g_nMiniMapIndex:= -1;
          FrmMain.SendWantMiniMap;
        end;
            //
        if (ident = SM_NEWMAP) and (g_MySelf <> nil) then begin
          g_MySelf.m_nCurrX := x;
          g_MySelf.m_nCurrY := y;
          g_MySelf.m_nRx := x;
          g_MySelf.m_nRy := y;
          DelActor (g_MySelf);
          if g_HeroSelf <> nil then //20080720����
          DelActor (g_HeroSelf);
        end;

      end;
      SM_RECALLHERO:
         begin
            actor := FindActor (chrid);
            if actor = nil then begin
               actor := NewActor (chrid, x, y, Lobyte(cdir), feature, state);
               actor.m_nChrLight := Hibyte(cdir);
            end;
            if g_HeroSelf <> nil then begin
               g_HeroSelf := nil;
            end;
            g_HeroSelf := THumActor (actor);
         end;
      SM_CREATEHERO:
        begin
          actor := FindActor (chrid);
            if actor = nil then begin
               actor := NewActor (chrid, x, y, Lobyte(cdir), feature, state);
               actor.m_nChrLight := Hibyte(cdir);
            end;
        end;
      SM_LOGON:
         begin

            actor := FindActor (chrid);
            if actor = nil then begin
               actor := NewActor (chrid, x, y, Lobyte(cdir), feature, state);
               actor.m_nChrLight := Hibyte(cdir);
               cdir := Lobyte(cdir);
               actor.SendMsg (SM_TURN, x, y, cdir, feature, state, '', 0); //ת��
            end;
            if g_MySelf <> nil then begin
               g_MySelf := nil;
            end;
            g_MySelf := THumActor (actor);
         end;
      SM_HIDE:
         begin
            actor := FindActor (chrid);
            if actor = g_HeroSelf then Exit;  //�ڴ�����Ӣ��������ʧ 2008.01.27
            if actor <> nil then begin
               if actor.m_boDelActionAfterFinished then exit;
               if actor.m_nWaitForRecogId <> 0 then Exit;
            end;
            DeleteActor (chrid);
         end;
      else begin
            actor := FindActor (chrid);
            if (ident=SM_TURN) or (ident=SM_RUN) {or (ident=SM_HORSERUN)20080803ע��������Ϣ} or (ident=SM_WALK) or (ident=SM_NPCWALK) or
               (ident=SM_BACKSTEP) or
               (ident = SM_DEATH) or (ident = SM_SKELETON) or
               (ident = SM_DIGUP) or (ident = SM_ALIVE) then
            begin
               if actor = nil then
                  actor := NewActor (chrid, x, y, Lobyte(cdir), feature, state);
               if actor <> nil then begin
                  actor.m_nChrLight := Hibyte(cdir);
                  cdir := Lobyte(cdir);
                  if ident = SM_SKELETON then begin
                     actor.m_boDeath := TRUE;
                     actor.m_boSkeleton := TRUE;
                  end;
               end;
            end;
            if actor = nil then exit;
            case ident of
               SM_FEATURECHANGED: begin
                 actor.m_nFeature := feature;
                 actor.m_nFeatureEx:=state;
                 actor.FeatureChanged;
                 //MemoLog.Lines.Add(actor.m_sUserName);
               end;
               SM_CHARSTATUSCHANGED: begin
                 actor.m_nState:= Feature;
                 actor.m_nHitSpeed:= state;
                 {if actor.m_btRace in [0,1,150] then begin
                 if str = '444' then THumActor(actor).m_boMagbubble4 := True; //��
                 if str = '555' then THumActor(actor).m_boMagbubble4 := False;//�� 
                 end; }
               end;
               SM_MAGIC69SKILLNH: begin
                  actor.m_Skill69NH := x;
                  actor.m_Skill69MaxNH := y;
               end;
               else begin
                  if ident = SM_TURN then begin
                     if str <> '' then
                        actor.m_sUserName := str;
                  end;
                  actor.SendMsg (ident, x, y, cdir, feature, state, '', 0);
               end;
            end;
         end;
   end;
  except
    DebugOutStr('TPlayScene.SendMsg');
  end;
end;


end.

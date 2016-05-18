unit Magic;

interface
uses
  Windows, Classes, Grobal2, ObjBase, ObjHero, SysUtils;
type
  TMagicManager = class
  private

  public
    constructor Create();
    destructor Destroy; override;
    function MagMakePrivateTransparent(BaseObject: TBaseObject; nHTime: Integer): Boolean;
    function IsWarrSkill(wMagIdx: Integer): Boolean;
    function DoSpell(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;

    function MagBigHealing(PlayObject: TBaseObject; nPower, nX, nY: Integer): Boolean;
    function MagPushArround(PlayObject: TBaseObject; nPushLevel: Integer): Integer;
    function MagTurnUndead(BaseObject, TargeTBaseObject: TBaseObject; nTargetX, nTargetY: Integer; nLevel: Integer): Boolean;
    function MagMakeHolyCurtain(BaseObject: TBaseObject; nPower: Integer; nX, nY: Integer): Integer;
    function MagMakeGroupTransparent(BaseObject: TBaseObject; nX, nY: Integer; nHTime: Integer): Boolean;
    function MagTamming(BaseObject, TargeTBaseObject: TBaseObject; nTargetX, nTargetY: Integer; nMagicLevel: Integer): Boolean;
    function MagSaceMove(BaseObject: TBaseObject; nLevel: Integer): Boolean;
    function MagMakeFireCross(PlayObject: TBaseObject; nDamage, nHTime, nX, nY: Integer): Integer;
    function MagBigExplosion(BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage: Integer; nCode: Byte): Boolean;
    //���ǻ��� 20080510
    function MagBigExplosion1(BaseObject: TBaseObject; nPower, nX, nY: Integer; nRage: Integer): Boolean;
    function MagElecBlizzard(BaseObject: TBaseObject; nPower: Integer): Boolean;
    function MabMabe(BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel, nTargetX, nTargetY: Integer): Boolean;
    //�ٻ�����
    function MagMakeSlave(PlayObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
    //�ٻ�����
    function MagMakeFairy(PlayObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
    function MagMakeSelf(BaseObject, TargeTBaseObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
    function MagMakeSinSuSlave(PlayObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
    function MagWindTebo(PlayObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
    function MagGroupLightening(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean;
    function MagGroupAmyounsul(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagGroupDeDing(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagGroupMb(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagHbFireBall(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    //function MagReturn(BaseObject, TargeTBaseObject: TBaseObject; nTargetX, nTargetY, nMagicLevel: Integer): Boolean;//δʹ�� 20080410
    function MagMakeSlave_(PlayObject: TBaseObject; UserMagic: pTUserMagic; sMonName: string; nCount, nHumLevel, nMonLevel: Integer): Boolean;
    function MagLightening(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean;
    function MagMakeSuperFireCross(PlayObject: TBaseObject; nDamage, nHTime, nX, nY: Integer; nCount: Integer): Integer;

    function MagMakeFireball(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagTreatment(PlayObject: TBaseObject; UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeHellFire(PlayObject: TBaseObject ; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeQuickLighting(PlayObject: TBaseObject; UserMagic: pTUserMagic; var nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeLighting(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeFireCharm(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    //��Ѫ�� 20080511
    function MagFireCharmTreatment(PlayObject: TBaseObject;UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeUnTreatment(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeLivePlayObject(PlayObject: TBaseObject; UserMagic: pTUserMagic; TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeArrestObject(PlayObject: TBaseObject; UserMagic: pTUserMagic; TargeTBaseObject: TBaseObject): Boolean;
    function MagChangePosition(PlayObject: TBaseObject; nTargetX, nTargetY: Integer): Boolean;
    function MagChangePosition2(PlayObject: TBaseObject; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeFireDay(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagGroupFengPo(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagTamming2(BaseObject, TargeTBaseObject: TBaseObject; nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
    function MagMakeSkillFire_60(PlayObject: TBaseObject; UserMagic: pTUserMagic; nPower: Integer): Boolean;
    function MagMakeSkillFire_61(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeSkillFire_62(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeSkillFire_63(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeSkillFire_64(PlayObject: TBaseObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
    function MagMakeSkillFire_65(BaseObject: TBaseObject; nPower: Integer): Boolean;
    function MagMakeHPUp(PlayObject: TBaseObject; UserMagic: pTUserMagic): Boolean;//�������� 20080625
    function GetNGPow(BaseObject: TBaseObject; UserMagic: pTUserMagic; Power: Integer): Integer;//�ڹ����ܵ�����ֵ
  end;
  function MPow(UserMagic: pTUserMagic): Integer;
  function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
  function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
  function GetRPow(wInt: Integer): Word;
  function CheckAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer; var Idx: Integer): Boolean;
  procedure UseAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer; var Idx: Integer);
  procedure FinancialsDefence( PlayObject: TBaseObject);//20080218 �ƻ������

implementation

uses HUtil32, M2Share, Event, Envir ,PlugOfEngine;


//�����������
function MPow(UserMagic: pTUserMagic): Integer;
begin
  Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
end;
function GetPower(nPower: Integer; UserMagic: pTUserMagic): Integer;
begin
  Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
end;

function GetPower13(nInt: Integer; UserMagic: pTUserMagic): Integer;
var
  d10: Double;
  d18: Double;
begin
  d10 := nInt / 3.0;
  d18 := nInt - d10;
  Result := Round(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
end;
function GetRPow(wInt: Integer): Word;
begin
  if HiWord(wInt) > LoWord(wInt) then begin
    Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
  end else Result := LoWord(wInt);
end;
{----------------------------------------------------------------------
��������:��黤����� �Ƿ����
���� nType Ϊָ������ 1 Ϊ����� 2 Ϊ��ҩ
���ж�װ�������Ƿ���д�����Ʒ,��û��,����������Ƿ���д�����Ʒ
-----------------------------------------------------------------------}
function CheckAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer; var Idx: Integer): Boolean;
var
  I: Integer;
  UserItem: pTUserItem; //20071227 ��,�����ֱ��ʹ��
  AmuletStdItem: pTStdItem;
begin
  Result := False;
  try
  if PlayObject.m_boGhost then Exit;//20090101
  Idx := 0;
  if PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0 then begin
    AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_ARMRINGL].wIndex);
    if (AmuletStdItem <> nil) then begin
      if (AmuletStdItem.StdMode = 25) then begin
        case nType of
          1: begin
              if (AmuletStdItem.Shape = 5) and (Round(PlayObject.m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
                Idx := U_ARMRINGL;
                Result := True;
                Exit;
              end;
            end;
          2: begin
              if PlayObject.m_btRaceServer =RC_PLAYOBJECT then begin
                if (AmuletStdItem.Shape <= 2) and (Round(PlayObject.m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
                  Idx := U_ARMRINGL;//20080722
                  Result := True;
                  Exit;
                end;
              end else
              if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
                 case THeroObject(PlayObject).n_AmuletIndx of
                   1: begin //�̶�
                      if (AmuletStdItem.Shape = 1) and (Round(PlayObject.m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
                        Idx := U_ARMRINGL;
                        Result := True;
                        //THeroObject(PlayObject).n_AmuletIndx:= 0;//20081213 ʹӢ��Ⱥ��ʱ�ܴ�����
                        Exit;
                      end;
                   end;
                   2:begin //�춾
                       if (AmuletStdItem.Shape = 2) and (Round(PlayObject.m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
                        Idx := U_ARMRINGL;
                        Result := True;
                        //THeroObject(PlayObject).n_AmuletIndx:= 0;//20081213 ʹӢ��Ⱥ��ʱ�ܴ�����
                        Exit;
                      end;
                   end;
                 end;//Case
              end;
             { if (AmuletStdItem.Shape <= 2) and (Round(PlayObject.m_UseItems[U_ARMRINGL].Dura / 100) >= nCount) then begin
                Idx := U_ARMRINGL;
                Result := True;
                Exit;
              end; }
            end;
        end;
      end;
    end;
  end;

  if PlayObject.m_UseItems[U_BUJUK].wIndex > 0 then begin
    AmuletStdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[U_BUJUK].wIndex);
    if (AmuletStdItem <> nil) then begin
      if (AmuletStdItem.StdMode = 25) then begin
        case nType of //
          1: begin//��
              if (AmuletStdItem.Shape = 5) and (Round(PlayObject.m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
                Idx := U_BUJUK;
                Result := True;
                Exit;
              end;
            end;
          2: begin//��
              if (PlayObject.m_btRaceServer =RC_PLAYOBJECT) or (PlayObject.m_btRaceServer = RC_PLAYMOSTER) then begin//20080722
                if (AmuletStdItem.Shape <= 2) and (Round(PlayObject.m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
                  Idx := U_BUJUK;
                  Result := True;
                  Exit;
                end;
              end else
              if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
                 case THeroObject(PlayObject).n_AmuletIndx of
                   1: begin //�̶�
                      if (AmuletStdItem.Shape = 1) and (Round(PlayObject.m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
                        Idx := U_BUJUK;
                        Result := True;
                        //THeroObject(PlayObject).n_AmuletIndx:= 0;//20081213 ʹӢ��Ⱥ��ʱ�ܴ�����
                        Exit;
                      end;
                   end;
                   2:begin //�춾
                       if (AmuletStdItem.Shape = 2) and (Round(PlayObject.m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
                        Idx := U_BUJUK;
                        Result := True;
                        //THeroObject(PlayObject).n_AmuletIndx:= 0;//20081213 ʹӢ��Ⱥ��ʱ�ܴ�����
                        Exit;
                      end;
                   end;
                 end;//Case
              end;
              {if (AmuletStdItem.Shape <= 2) and (Round(PlayObject.m_UseItems[U_BUJUK].Dura / 100) >= nCount) then begin
                Idx := U_BUJUK;
                Result := True;
                Exit;
              end; }
            end;
        end;
      end;
    end;
  end;

//  if PlayObject.m_btRaceServer =RC_PLAYOBJECT then begin //20080315 ����ż����������Ʒ
  //20071228 ��,�����ֱ��ʹ��(�����������Ƿ���ڶ�,�����)
  if PlayObject.m_ItemList.Count > 0 then begin//20080628
    for I := 0 to PlayObject.m_ItemList.Count - 1 do begin //���������Ϊ��
      UserItem := PlayObject.m_ItemList.Items[I];
      AmuletStdItem := UserEngine.GetStdItem(UserItem.wIndex);
      if (AmuletStdItem <> nil) then begin
        if (AmuletStdItem.StdMode = 25) then begin
          case nType of
            1: begin
                if (AmuletStdItem.Shape = 5) and (Round(UserItem.Dura / 100) >= nCount) then begin  //20071227
                  Idx :=UserItem.wIndex; //20071227
                  Result := True;
                  Exit;
                end;
              end;
            2: begin
                if PlayObject.m_btRaceServer =RC_PLAYOBJECT then begin
                  if (AmuletStdItem.Shape <= 2) and (Round(UserItem.Dura / 100) >= nCount) then begin
                    Idx :=UserItem.wIndex;
                    Result := True;
                    Exit;
                  end;
                end else
                if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
                   case THeroObject(PlayObject).n_AmuletIndx of
                     1: begin //�̶�
                        if (AmuletStdItem.Shape = 1) and (Round(UserItem.Dura / 100) >= nCount) then begin
                          Idx := UserItem.wIndex;
                          Result := True;
                          //THeroObject(PlayObject).n_AmuletIndx:= 0;//20081213 ʹӢ��Ⱥ��ʱ�ܴ�����
                          Exit;
                        end;
                     end;
                     2:begin //�춾
                         if (AmuletStdItem.Shape = 2) and (Round(UserItem.Dura / 100) >= nCount) then begin
                          Idx :=UserItem.wIndex;
                          Result := True;
                          //THeroObject(PlayObject).n_AmuletIndx:= 0;//20081213 ʹӢ��Ⱥ��ʱ�ܴ�����
                          Exit;
                        end;
                     end;
                   end;//Case
                end;
              end;//2
          end;//case
        end;
      end;
    end;
  end; 
//  end;
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} TMagic.CheckAmulet');
    end;
  end;
end;
{-------------------------------------------------------------------------------
//ʹ�û���� nType Ϊָ������ 1 Ϊ����� 2 Ϊ��ҩ
//20071227�޸�,ʹ�����еĶ�,���������ֱ��ʹ��,��װ����û�з��ϻ������,
�������д�����Ʒ,��ֱ��ʹ�ð������д�����Ʒ
--------------------------------------------------------------------------------}
procedure UseAmulet(PlayObject: TBaseObject; nCount: Integer; nType: Integer; var Idx: Integer);
var
  I : Integer;
  UserItem: pTUserItem; //20071227 ��,�����ֱ��ʹ��
  AmuletStdItem: pTStdItem;
  nCode: byte;
begin
  try
    nCode:= 0;
    if PlayObject.m_boGhost then Exit;//20090101
{// ԭ���Ĵ���
if PlayObject.m_UseItems[Idx].Dura > nCount * 100 then begin
    Dec(PlayObject.m_UseItems[Idx].Dura, nCount * 100);
    PlayObject.SendMsg(PlayObject, RM_DURACHANGE, Idx, PlayObject.m_UseItems[Idx].Dura, PlayObject.m_UseItems[Idx].DuraMax, 0, '');
  end else begin
    PlayObject.m_UseItems[Idx].Dura := 0;
    if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
      TPlayObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[Idx]);
    PlayObject.m_UseItems[Idx].wIndex := 0;
  end; }
//20071228 add
   nCode:= 1;                                                           {20080218 �޸�}
   if ((PlayObject.m_UseItems[U_BUJUK].wIndex > 0) or (PlayObject.m_UseItems[U_ARMRINGL].wIndex > 0)) and ((U_BUJUK =Idx) or (U_ARMRINGL = Idx))//20080212 ����,�ж�װ����û���������Ʒ
    and (PlayObject.m_UseItems[Idx].Dura >= nCount * 100) then begin
      nCode:= 2;
      Dec(PlayObject.m_UseItems[Idx].Dura, nCount * 100);
      if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        nCode:= 3;
        PlayObject.SendMsg(PlayObject, RM_DURACHANGE, Idx, PlayObject.m_UseItems[Idx].Dura, PlayObject.m_UseItems[Idx].DuraMax, 0, '');
        nCode:= 4;
        TPlayObject(PlayObject).SendUpdateItem(@PlayObject.m_UseItems[Idx]);//20080212 ������Ʒ
        if PlayObject.m_UseItems[Idx].Dura <= 0 then begin
          nCode:= 5;
          TPlayObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[Idx]);
          PlayObject.m_UseItems[Idx].wIndex := 0;
        end;
      end else
      if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
        nCode:= 6;
        PlayObject.SendMsg(PlayObject, RM_HERODURACHANGE, Idx, PlayObject.m_UseItems[Idx].Dura, PlayObject.m_UseItems[Idx].DuraMax, 0, '');
        nCode:= 7;
        THeroObject(PlayObject).SendUpdateItem(@PlayObject.m_UseItems[Idx]);//20080212 ������Ʒ
        if PlayObject.m_UseItems[Idx].Dura <= 0 then begin
          nCode:= 8;
          THeroObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[Idx]);
          PlayObject.m_UseItems[Idx].wIndex := 0;
        end;
      end;
    end else begin
    nCode:= 9;
    for I := PlayObject.m_ItemList.Count - 1 downto 0 do begin //���������Ϊ�� 20080916 �޸�
      if PlayObject.m_ItemList.Count <= 0 then Break;//20080916
      nCode:= 10;         
      UserItem := PlayObject.m_ItemList.Items[I];
      if UserItem.wIndex = idx then begin
        nCode:= 11;
        AmuletStdItem := UserEngine.GetStdItem(UserItem.wIndex);
        if (AmuletStdItem <> nil) then begin
          nCode:= 12;
          if (AmuletStdItem.StdMode = 25) then begin
            case nType of
              1: begin  //�����
                  if(AmuletStdItem.Shape = 5) and (UserItem.Dura >= nCount* 100) then  //20071227
                    Dec(UserItem.Dura, nCount * 100);
                end;
              2: begin // ��ҩ
                  if  (AmuletStdItem.Shape <= 2) and (UserItem.Dura >= nCount* 100) then  //20071227
                    Dec(UserItem.Dura, nCount * 100);
                end;
            end; //case

            if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin//20080212 �޸�
              nCode:= 13;
              PlayObject.SendMsg(PlayObject, RM_DURACHANGE,UserItem.wIndex, UserItem.Dura, UserItem.DuraMax, 0, '');
              nCode:= 14;
              TPlayObject(PlayObject).SendUpdateItem(UserItem);//������Ʒ
              if UserItem.Dura <= 0 then begin
                nCode:= 15;
                PlayObject.m_ItemList.Delete(I);
                nCode:= 16;
                TPlayObject(PlayObject).SendDelItems(UserItem);
              end;
            end else
            if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
              nCode:= 17;
              PlayObject.SendMsg(PlayObject, RM_HERODURACHANGE,UserItem.wIndex, UserItem.Dura, UserItem.DuraMax, 0, '');
              nCode:= 18;
              THeroObject(PlayObject).SendUpdateItem(UserItem);//������Ʒ
              if UserItem.Dura <= 0 then begin
                nCode:= 19;
                PlayObject.m_ItemList.Delete(I);
                nCode:= 20;
                THeroObject(PlayObject).SendDelItems(UserItem);
              end;
            end;
            Exit;
          end;
        end;
      end;
    end;
  //20071228 end
  end;
  except
    on E: Exception do begin
      MainOutMessage('{�쳣} TMagic.UseAmulet Code:'+inttostr(nCode));
    end;
  end;
end;
//20080218 �ƻ������
procedure FinancialsDefence( PlayObject: TBaseObject);
begin
  if PlayObject.m_boProtectionDefence then//���Ŀ����ʹ�û������
    PlayObject.m_wStatusTimeArr[STATE_ProtectionDEFENCE]:=1; //�����ƶܵĶ���
end;
//������
function TMagicManager.MagPushArround(PlayObject: TBaseObject; nPushLevel: Integer): Integer; //00492204
var
  I, nDir, levelgap, push: Integer;
  BaseObject: TBaseObject;
begin
  Result := 0;
  if PlayObject.m_VisibleActors.Count > 0 then begin//20080629
    for I := 0 to PlayObject.m_VisibleActors.Count - 1 do begin
      BaseObject := TBaseObject(pTVisibleBaseObject(PlayObject.m_VisibleActors[I]).BaseObject);
      if BaseObject <> nil then begin
        if (abs(PlayObject.m_nCurrX - BaseObject.m_nCurrX) <= 1) and (abs(PlayObject.m_nCurrY - BaseObject.m_nCurrY) <= 1) then begin
          if (not BaseObject.m_boDeath) and (BaseObject <> PlayObject) then begin
            if (PlayObject.m_Abil.Level >= BaseObject.m_Abil.Level) and (not BaseObject.m_boStickMode) then begin
              levelgap := PlayObject.m_Abil.Level - BaseObject.m_Abil.Level;
              if (Random(20) < 6 + nPushLevel * 3 + levelgap) then begin
                if PlayObject.IsProperTarget(BaseObject) then begin
                  push := 1 + _MAX(0, nPushLevel - 1) + Random({2}3);//20081217 �޸�
                  nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
                  BaseObject.CharPushed(nDir, push);
                  Inc(Result);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;
//Ⱥ��������
function TMagicManager.MagBigHealing(PlayObject: TBaseObject; nPower, nX, nY: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nX, nY, 1, BaseObjectList);
  if BaseObjectList.Count > 0 then begin//20080629
    for I := 0 to BaseObjectList.Count - 1 do begin
      BaseObject := TBaseObject(BaseObjectList[I]);
      if PlayObject.IsProperFriend(BaseObject) then begin
        if BaseObject.m_WAbil.HP < BaseObject.m_WAbil.MaxHP then begin
          BaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
          Result := True;
        end;
        if PlayObject.m_boAbilSeeHealGauge then begin
          PlayObject.SendMsg(BaseObject, RM_10414, 0, 0, 0, 0, ''); //?? RM_INSTANCEHEALGUAGE
        end;
      end;
    end;
  end;
  BaseObjectList.Free;
end;

constructor TMagicManager.Create;
begin

end;

destructor TMagicManager.Destroy;
begin

  inherited;
end;
{����,�����}
function TMagicManager.MagMakeFireball(PlayObject: TBaseObject; 
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower, NGSecPwr: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) or g_Config.boAutoCanHit then begin
    if PlayObject.IsProperTarget(TargeTBaseObject) then begin
      if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
        with PlayObject do begin
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
            SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
        end;

        case UserMagic.MagicInfo.wMagicId of
          SKILL_FIREBALL{1}: begin//������
              if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                if TPlayObject(PlayObject).m_MagicSkill_208 <> nil then begin//20081223
                  NGSecPwr := GetNGPow(PlayObject, TPlayObject(PlayObject).m_MagicSkill_208,nPower);//ŭ֮����
                  if TargeTBaseObject <> nil then begin
                    if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                      NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_209,nPower);//��֮����
                    end else
                    if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                      NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_209,nPower);//��֮����
                    end;
                  end;
                  nPower := _MAX(0, nPower + NGSecPwr);
                end;
              end else
              if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
                if THEROOBJECT(PlayObject).m_MagicSkill_208 <> nil then begin//20081223
                  NGSecPwr := GetNGPow(PlayObject, THEROOBJECT(PlayObject).m_MagicSkill_208,nPower);//ŭ֮����
                  if TargeTBaseObject <> nil then begin
                    if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                      NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_209,nPower);//��֮����
                    end else
                    if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                      NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_209,nPower);//��֮����
                    end;
                  end;
                  nPower := _MAX(0, nPower + NGSecPwr);
                end;
              end;
            end;
          SKILL_FIREBALL2{5}: begin //�����
              if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                if TPlayObject(PlayObject).m_MagicSkill_210 <> nil then begin//20081223
                  NGSecPwr := GetNGPow(PlayObject, TPlayObject(PlayObject).m_MagicSkill_210,nPower);//ŭ֮�����
                  if TargeTBaseObject <> nil then begin
                    if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                      NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_211,nPower);//��֮�����
                    end else
                    if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                      NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_211,nPower);//��֮�����
                    end;
                  end;
                  nPower := _MAX(0, nPower + NGSecPwr);
                end;
              end else
              if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
                if THEROOBJECT(PlayObject).m_MagicSkill_210 <> nil then begin//20081223
                  NGSecPwr := GetNGPow(PlayObject, THEROOBJECT(PlayObject).m_MagicSkill_210,nPower);//ŭ֮�����
                  if TargeTBaseObject <> nil then begin
                    if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                      NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_211,nPower);//��֮�����
                    end else
                    if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                      NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_211,nPower);//��֮����
                    end;
                  end;
                  nPower := _MAX(0, nPower + NGSecPwr);
                end;
              end;
            end;
        end;

        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
        if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then Result := True;
      end else
        TargeTBaseObject := nil;
    end else
      TargeTBaseObject := nil;
  end else
    TargeTBaseObject := nil;
end;

{������}
function TMagicManager.MagTreatment(PlayObject: TBaseObject; UserMagic: pTUserMagic;
   var nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if TargeTBaseObject = nil then begin
    TargeTBaseObject := PlayObject;
    nTargetX := PlayObject.m_nCurrX;
    nTargetY := PlayObject.m_nCurrY;
  end;
  if PlayObject.IsProperFriend(TargeTBaseObject) then begin
    nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC) * 2,
      SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1) + PlayObject.m_WAbil.Level;
    if TargeTBaseObject.m_WAbil.HP < TargeTBaseObject.m_WAbil.MaxHP then begin
      TargeTBaseObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
      Result := True;
    end;
    if PlayObject.m_boAbilSeeHealGauge then//������ʾ
      PlayObject.SendMsg(TargeTBaseObject, RM_10414, 0, 0, 0, 0, '');
  end;
end;

//������
function TMagicManager.MagMakeHellFire(PlayObject: TBaseObject; UserMagic: pTUserMagic;
 nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
var
  nPower,nSccPwr: Integer;
  n1C, NGSecPwr: Integer;
  n14, n18: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
  if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 1, n14, n18) then begin
    PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 5, nTargetX, nTargetY);
    nSccPwr := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
      SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
    nPower:= nSccPwr;
    if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      NGSecPwr := GetNGPow(PlayObject, TPlayObject(PlayObject).m_MagicSkill_214,nSccPwr);//ŭ֮������
      nPower := _MAX(0, nSccPwr + NGSecPwr);
    end else
    if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
      NGSecPwr := GetNGPow(PlayObject, THEROOBJECT(PlayObject).m_MagicSkill_214,nSccPwr);//ŭ֮������
      nPower := _MAX(0, nSccPwr + NGSecPwr);
    end;
    if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C, nPower,nSccPwr, False, SKILL_FIRE) > 0 then
      Result := True;
  end;
end;

//�����Ӱ
function TMagicManager.MagMakeQuickLighting(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  var nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
var
  nPower,nSccPwr: Integer;
  n1C, NGSecPwr: Integer;
  n14, n18: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  n1C := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
  if PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 1, n14, n18) then begin
    PlayObject.m_PEnvir.GetNextPosition(PlayObject.m_nCurrX, PlayObject.m_nCurrY, n1C, 8, nTargetX, nTargetY);
    nSccPwr := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
      SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
    nPower:= nSccPwr;  
    if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      NGSecPwr := GetNGPow(PlayObject, TPlayObject(PlayObject).m_MagicSkill_216,nSccPwr);//ŭ֮�����Ӱ
      nPower := _MAX(0, nSccPwr + NGSecPwr);
    end else
    if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
      NGSecPwr := GetNGPow(PlayObject, THEROOBJECT(PlayObject).m_MagicSkill_216,nSccPwr);//ŭ֮�����Ӱ
      nPower := _MAX(0, nSccPwr + NGSecPwr);
    end;
    if PlayObject.MagPassThroughMagic(n14, n18, nTargetX, nTargetY, n1C, nPower, nSccPwr, True, SKILL_SHOOTLIGHTEN) > 0 then
      Result := True;
  end;
end;

//�׵���(��,Ӣ��ʹ�ô˹���,������)
function TMagicManager.MagMakeLighting(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower, NGSecPwr: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);
      if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        if TPlayObject(PlayObject).m_MagicSkill_222 <> nil then begin//20081223
          NGSecPwr := GetNGPow(PlayObject, TPlayObject(PlayObject).m_MagicSkill_222,nPower);//ŭ֮�׵�
          if TargeTBaseObject <> nil then begin
            if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
              NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_223,nPower);//��֮�׵�
            end else
            if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
              NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_223,nPower);//��֮�׵�
            end;
          end;
          nPower := _MAX(0, nPower + NGSecPwr);
        end;
      end else
      if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
        if THEROOBJECT(PlayObject).m_MagicSkill_222 <> nil then begin//20081223
          NGSecPwr := GetNGPow(PlayObject, THEROOBJECT(PlayObject).m_MagicSkill_222,nPower);//ŭ֮�׵�
          if TargeTBaseObject <> nil then begin
            if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
              NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_223,nPower);//��֮�׵�
            end else
            if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
              NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_223,nPower);//��֮�׵�
            end;
          end;
          nPower := _MAX(0, nPower + NGSecPwr);
        end;
      end;
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
      if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
      else if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then Result := True;
    end else TargeTBaseObject := nil
  end else TargeTBaseObject := nil;
end;


//����� 20080531�޸�,֧��4�����
function TMagicManager.MagMakeFireCharm(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer;var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower, NGSecPwr: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin //ħ���ܹ���Ŀ��
    if PlayObject.IsProperTarget(TargeTBaseObject) then begin //�Ƿ����ʵ���Ŀ��
      if Random(10) >= TargeTBaseObject.m_nAntiMagic then begin
        if (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),
            SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
          if (PlayObject.m_btRaceServer = RC_HEROOBJECT) and (UserMagic.btLevel = 4) then begin//Ӣ���ж��Ƿ���4������,�ҳ϶ȴﵽ��,���ӹ����� 20080531
            if THeroObject(PlayObject).m_nLoyal >= g_Config.nGotoLV4 then
              nPower := nPower + g_Config.nPowerLV4;  //����������ͨħ������
          end;

          if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
            if TPlayObject(PlayObject).m_MagicSkill_230 <> nil then begin//20081223
              NGSecPwr := GetNGPow(PlayObject, TPlayObject(PlayObject).m_MagicSkill_230,nPower);//ŭ֮���
              if TargeTBaseObject <> nil then begin
                if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                  NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_231,nPower);//��֮���
                end else
                if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                  NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_231,nPower);//��֮���
                end;
              end;
              nPower := _MAX(0, nPower + NGSecPwr);
            end;
          end else
          if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
            if THEROOBJECT(PlayObject).m_MagicSkill_230 <> nil then begin//20081223
              NGSecPwr := GetNGPow(PlayObject, THEROOBJECT(PlayObject).m_MagicSkill_230,nPower);//ŭ֮���
              if TargeTBaseObject <> nil then begin
                if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                  NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_231,nPower);//��֮���
                end else
                if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                  NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_231,nPower);//��֮���
                end;
              end;
              nPower := _MAX(0, nPower + NGSecPwr);
            end;
          end;

          if g_Config.boAutoCanHit then begin//��������
            PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY), 2, Integer(TargeTBaseObject), '', {1200}600);
          end else begin
            PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', {1200}600);
          end;
          
          if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
          else if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then Result := True;
        end;
      end;
    end;
  end else TargeTBaseObject := nil;
end;
//��Ѫ�� 20080511
//��ʹ��������Ե�������˺������к󣬻�����ȡ�Է�������Ϊ�Լ��ظ�һ����Ѫ������������ĳЩ�����ϰ���ֱ�����˵�Ҫ����
function TMagicManager.MagFireCharmTreatment(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower, NGSecPwr: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin //�Ƿ����ʵ���Ŀ��
    if Random(10) >= TargeTBaseObject.m_nAntiMagic then begin
      if (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC),SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
        NGSecPwr := 0;//20081213
        if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
          if TPlayObject(PlayObject).m_MagicSkill_232 <> nil then begin//20081223
            NGSecPwr := GetNGPow(PlayObject, TPlayObject(PlayObject).m_MagicSkill_232,nPower);//ŭ֮��Ѫ
            if TargeTBaseObject <> nil then begin
              if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_233,nPower);//��֮��Ѫ
              end else
              if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_233,nPower);//��֮��Ѫ
              end;
            end;
            nPower := _MAX(0, nPower + NGSecPwr);
          end;
        end else
        if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
          if THEROOBJECT(PlayObject).m_MagicSkill_232 <> nil then begin//20081223
            NGSecPwr := GetNGPow(PlayObject, THEROOBJECT(PlayObject).m_MagicSkill_232,nPower);//ŭ֮��Ѫ
            if TargeTBaseObject <> nil then begin
              if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_233,nPower);//��֮��Ѫ
              end else
              if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_233,nPower);//��֮��Ѫ
              end;
            end;
            nPower := _MAX(0, nPower + NGSecPwr);
          end;
        end;

        PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 1000);
        if PlayObject.m_WAbil.HP < PlayObject.m_WAbil.MaxHP then begin//�ظ�һ����HPֵ
          nPower:= Round(nPower * g_Config.nMagFireCharmTreatment / 100);
          PlayObject.SendDelayMsg(PlayObject, RM_MAGHEALING, 0, nPower, 0, 0, '', 800);
          PlayObject.SendRefMsg(RM_MYSHOW, 11, 0, 0, 0, ''); //20080718
        end;
        if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
        else if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) and (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then Result := True;
      end;
    end;
  end;
end;

//����� ֧��4������ 20080531
function TMagicManager.MagMakeFireDay(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer;var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower, NGSecPwr: Integer;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    if (Random(10) >= TargeTBaseObject.m_nAntiMagic) then begin
      nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
        SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
      if TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD then nPower := Round(nPower * 1.5);
      if (PlayObject.m_btRaceServer = RC_HEROOBJECT) and (UserMagic.btLevel = 4) then begin
         if THeroObject(PlayObject).m_nLoyal >=g_Config.nGotoLV4 then
           nPower := nPower + g_Config.nPowerLV4;//����������ͨħ������
      end;
      NGSecPwr := 0;//20081217
      if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        if TPlayObject(PlayObject).m_MagicSkill_228 <> nil then begin//20081223
          NGSecPwr := GetNGPow(PlayObject, TPlayObject(PlayObject).m_MagicSkill_228,nPower);//ŭ֮�����
          if TargeTBaseObject <> nil then begin
            if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
              NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_229,nPower);//��֮�����
            end else
            if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
              NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_229,nPower);//��֮�����
            end;
          end;
          nPower := _MAX(0, nPower + NGSecPwr);
        end;
      end else
      if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
        if THEROOBJECT(PlayObject).m_MagicSkill_228 <> nil then begin//20081223
          NGSecPwr := GetNGPow(PlayObject, THEROOBJECT(PlayObject).m_MagicSkill_228,nPower);//ŭ֮�����
          if TargeTBaseObject <> nil then begin
            if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
              NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_229,nPower);//��֮�����
            end else
            if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
              NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_229,nPower);//��֮�����
            end;
          end;
          nPower := _MAX(0, nPower + NGSecPwr);
        end;
      end;
      
      PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
      if g_Config.boPlayObjectReduceMP then begin//���м�MPֵ,��35% 20090104
        TargeTBaseObject.DamageSpell(Abs(Round(nPower * 0.35)));
      end;
      if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
      else if TargeTBaseObject.m_btRaceServer >= RC_ANIMAL then Result := True;
    end else TargeTBaseObject := nil
  end else TargeTBaseObject := nil;
end;

{�ⶾ��}
function TMagicManager.MagMakeUnTreatment(PlayObject: TBaseObject; {�޸� TBaseObject}
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  var TargeTBaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if TargeTBaseObject = nil then begin
    TargeTBaseObject := PlayObject;
   // nTargetX := PlayObject.m_nCurrX;  20080117ע��
   // nTargetY := PlayObject.m_nCurrY;  20080117ע��
  end;
  if PlayObject.IsProperFriend {0FFF3}(TargeTBaseObject) then begin
    if Random(7) - (UserMagic.btLevel + 1) < 0 then begin
      if TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_DECHEALTH] := 1;
        Result := True;
      end;
      if TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_DAMAGEARMOR] := 1;
        Result := True;
      end;
      if TargeTBaseObject.m_wStatusTimeArr[POISON_STONE] <> 0 then begin
        TargeTBaseObject.m_wStatusTimeArr[POISON_STONE] := 1;
        Result := True;
      end;
    end;
  end;
end;

{������}
function TMagicManager.MagMakeLivePlayObject(PlayObject: TBaseObject; UserMagic: pTUserMagic; TargeTBaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if PlayObject.IsProperTargetSKILL_57(TargeTBaseObject) then begin
    if (Random(10 + UserMagic.btLevel) + UserMagic.btLevel) >= 8 then begin
      TPlayObject(TargeTBaseObject).ReAlive;
      TPlayObject(TargeTBaseObject).m_WAbil.HP := TPlayObject(TargeTBaseObject).m_WAbil.MaxHP;
      TPlayObject(TargeTBaseObject).SendMsg(TPlayObject(TargeTBaseObject), RM_ABILITY, 0, 0, 0, 0, '');
      Result := True;
    end;
  end;
end;

{������}
function TMagicManager.MagMakeArrestObject(PlayObject: TBaseObject; UserMagic: pTUserMagic; TargeTBaseObject: TBaseObject): Boolean;
var
  nX, nY: Integer;
begin
  Result := False;
  if PlayObject.IsProperTargetSKILL_55(PlayObject.m_WAbil.Level, TargeTBaseObject) then begin
    if (Random(10 + UserMagic.btLevel) + UserMagic.btLevel) >= 5 then begin
      PlayObject.GetFrontPosition(nX, nY);
      TargeTBaseObject.SpaceMove(TargeTBaseObject.m_PEnvir.sMapName, nX, nY, 0);
      TargeTBaseObject.SendRefMsg(RM_MONMOVE, 0, nX, nY, 0, '');
      Result := True;
    end;
  end;
end;
{���л�λ--δʹ��}
function TMagicManager.MagChangePosition2(PlayObject: TBaseObject; {�޸� TBaseObject} nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
//var
 { I,nX, nY, olddir, oldx, oldy, nBackDir, nDir: Integer;}
 // n01: Integer; 20080117ע��
begin
  Result := False;
//  n01 := 0; 20080117ע��
  if not PlayObject.m_boOnHorse then begin
   // if PlayObject.IsProperTargetSKILL_56(TargeTBaseObject, nTargetX, nTargetY) then begin
      //nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, nTargetX, nTargetY);
    PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      //PlayObject.SendRefMsg(RM_CHANGETURN, 0, 0, 0, 0, '');
    PlayObject.SpaceMove(PlayObject.m_PEnvir.sMapName, nTargetX, nTargetY, 0);
    Result := True;
    //end;
  end;
end;

{���л�λ}
function TMagicManager.MagChangePosition(PlayObject: TBaseObject; nTargetX, nTargetY: Integer): Boolean;
begin
  Result := False;
  if not PlayObject.m_boOnHorse then begin
    if PlayObject.m_PEnvir.CanWalk(nTargetX, nTargetY, True) and (PlayObject.m_PEnvir.GetXYObjCount(nTargetX, nTargetY) = 0) then begin
      PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE, 0, 0, 0, 0, '');
      PlayObject.SpaceMove2(nTargetX, nTargetY, 0);
      Result := True;
    end;
  end;
end;

//�ƻ�ն ս+ս
function TMagicManager.MagMakeSkillFire_60(PlayObject: TBaseObject; UserMagic: pTUserMagic; nPower: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  nPowerValue: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  try
    PlayObject.GetDirectionBaseObjects(PlayObject.m_btDirection, g_Config.nHeroAttackRange_60, BaseObjectList);//�Լ������Ŀ��
    if BaseObjectList.Count > 0 then begin//20080629
      for I := 0 to BaseObjectList.Count - 1 do begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);  //Ŀ��
        if PlayObject.IsProperTarget(TargeTBaseObject) then begin
          if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin//�ϻ������Լ���Ӣ�� 20090126
            if (TPlayObject(PlayObject).m_MyHero <> nil) and (TargeTBaseObject <> nil) then begin
              if TPlayObject(PlayObject).m_MyHero = TargeTBaseObject then Continue;
            end;
          end;

          if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin //20080531 ����Ӣ��������,����������
            if not THeroObject(PlayObject).m_boTarget then PlayObject.SetTargetCreat(TargeTBaseObject);
          end else PlayObject.SetTargetCreat(TargeTBaseObject);
      
          nPowerValue := Round(nPower * (g_Config.nHeroAttackRate_60 / 100));
          if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT) then begin//Ŀ�����˻�Ӣ�����жϾ��� 20080626
             nPowerValue :=Round(nPowerValue* (g_Config.nDecDragonRate / 100));//20080803 �ϻ����˵��˺�����
             if TargeTBaseObject.m_Abil.WineDrinkValue > 0 then begin//������Ϊ0ʱ
               nPowerValue :=Round(nPowerValue* (1 - g_Config.nDecDragonHitPoint / 100));
               TargeTBaseObject.SendRefMsg(RM_MYSHOW, ET_DRINKDECDRAGON, 0, 0, 0, '');//�ȾƵ����ϻ�����ʾ����Ч�� 20090105
             end;
          end;
          TargeTBaseObject.SendMsg(PlayObject, RM_MAGSTRUCK, 0, nPowerValue, 0, 0, ''); //����Ŀ����Ϣ
          PlayObject.SendRefMsg(RM_MAGICFIRE, 0, //����������Ϣ  20080105
            MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
            MakeLong(TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY),
            Integer(TargeTBaseObject),
            '');
          if g_Config.ErgumBadProtection then FinancialsDefence(TargeTBaseObject);//20080218 �ϻ��Ʊ������
          Result := True;
        end;
      end;
    end;
  finally
    BaseObjectList.Free;
  end;
end;
//����ն  ս+��
function TMagicManager.MagMakeSkillFire_61(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  nCode: Byte;
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  nCode:=0;
  Result := False;
  try
    nPower := 0;
    if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
      nCode:=1;
      if PlayObject.IsProperTarget(TargeTBaseObject) then begin   {20080612 �޸����ֵ}
        if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin//�ϻ������Լ���Ӣ�� 20090126
          if (TPlayObject(PlayObject).m_MyHero <> nil) and (TargeTBaseObject <> nil) then begin
            if TPlayObject(PlayObject).m_MyHero = TargeTBaseObject then Exit;
          end;
        end;
        nCode:=2;
        if ({TargeTBaseObject.m_nAntiMagic <= Random(10)}Random(TargeTBaseObject.m_nAntiMagic + 10) <= 10) and (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
          nCode:=3;
          with PlayObject do begin
            case m_btJob of
              2: nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1) * 2;
              0: nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1) * 2;
            end;
          end;
          nCode:=4;
          nPower := Round(nPower * (g_Config.nHeroAttackRate_61 / 100));//20080131 ����ն����
          nCode:=5;
          if TargeTBaseObject <> nil then begin//20080727 ����
            if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT) then begin//Ŀ�����˻�Ӣ�����жϾ��� 20080626
               nCode:=8;
               nPower :=Round(nPower* (g_Config.nDecDragonRate / 100));//20080803 �ϻ����˵��˺�����
               if TargeTBaseObject.m_Abil.WineDrinkValue > 0 then begin//������Ϊ0ʱ
                  nCode:=9;
                  nPower :=Round(nPower* (1 - g_Config.nDecDragonHitPoint / 100));
                  TargeTBaseObject.SendRefMsg(RM_MYSHOW, ET_DRINKDECDRAGON, 0, 0, 0, '');//�ȾƵ����ϻ�����ʾ����Ч�� 20090105
               end;
            end;
          end;
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 500);
          nCode:=6;
          if g_Config.ErgumBadProtection then FinancialsDefence(TargeTBaseObject);//20080218 �ϻ��Ʊ������
          nCode:=7;
          Result := True;
        end else TargeTBaseObject := nil;
      end else TargeTBaseObject := nil;
    end else TargeTBaseObject := nil;
  except
    MainOutMessage('{�쳣} TMagicManager.MagMakeSkillFire_61 Code:'+inttostr(nCode));
  end;
end;
//����һ��  ս+��
function TMagicManager.MagMakeSkillFire_62(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  nCode: Byte;//20080806
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  nPower := 0;
  nCode:= 0;
  try
    if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
      nCode:= 1;
      if PlayObject.IsProperTarget(TargeTBaseObject) then begin      {20080612 �޸����ֵ}
        if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin//�ϻ������Լ���Ӣ�� 20090126
          if (TPlayObject(PlayObject).m_MyHero <> nil) and (TargeTBaseObject <> nil) then begin
            if TPlayObject(PlayObject).m_MyHero = TargeTBaseObject then exit;
          end;
        end;
        nCode:= 2;
        if ({TargeTBaseObject.m_nAntiMagic <= Random(10)}Random(TargeTBaseObject.m_nAntiMagic + 10) <= 10) and (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
          nCode:= 3;
          with PlayObject do begin
            case m_btJob of
              1: nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1) * 2;
              0: nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.DC), SmallInt(HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC)) + 1) * 2;
            end;
          end;
          nCode:= 4;
          nPower := Round(nPower * (g_Config.nHeroAttackRate_62 / 100)); //����һ������ 20080131
          nCode:= 5;
          if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT) then begin//Ŀ�����˻�Ӣ�����жϾ��� 20080626
             nCode:= 8;
             nPower :=Round(nPower* (g_Config.nDecDragonRate / 100));//20080803 �ϻ����˵��˺�����
             if TargeTBaseObject.m_Abil.WineDrinkValue > 0 then begin//������Ϊ0ʱ
                nCode:= 9;
                nPower :=Round(nPower* (1 - g_Config.nDecDragonHitPoint / 100));
                TargeTBaseObject.SendRefMsg(RM_MYSHOW, ET_DRINKDECDRAGON, 0, 0, 0, '');//�ȾƵ����ϻ�����ʾ����Ч�� 20090105
             end;
          end;
          //nCode:= 10;
          //TargeTBaseObject.MagDownHealth(0, (Random(10) + UserMagic.btLevel) * 2 + 1, nPower div 10 + 1);//20080830 ע��,ȥ������Ŀ���,Ŀ�껹Ҫ��Ѫ
          nCode:= 11;
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
          nCode:= 12;
          if g_Config.ErgumBadProtection then FinancialsDefence(TargeTBaseObject);//20080218 �ϻ��Ʊ������
          Result := True;
        end else
          TargeTBaseObject := nil;
      end else
        TargeTBaseObject := nil;
    end else
      TargeTBaseObject := nil;
  except
    MainOutMessage('{�쳣} TMagicManager.MagMakeSkillFire_62 Code:'+inttostr(nCode));
  end;
end;
//�ɻ����� ��+��
function TMagicManager.MagMakeSkillFire_63(PlayObject: TBaseObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  Result := False;
  try
    if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin//20090203 ħ���Ƿ���Դ�Ŀ��
      BaseObjectList := TList.Create;
      try
        PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, g_Config.nHeroAttackRange_63{������Χ}, BaseObjectList); //�ɻ����� ������Χ 20080131
        if BaseObjectList.Count > 0 then begin//20080629
          for I := 0 to BaseObjectList.Count - 1 do begin
            BaseObject := TBaseObject(BaseObjectList.Items[I]);
            if BaseObject = nil then Continue;//20090126
            if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
            if PlayObject.m_btRaceServer = RC_PLAYOBJECT then
              if (TPlayObject(PlayObject).m_MyHero <> nil) then begin//�����Լ�Ӣ��
                if (TPlayObject(PlayObject).m_MyHero = BaseObject) then Continue;//20080715 ����
              end;
            if (PlayObject.m_btRaceServer = RC_HEROOBJECT) and (PlayObject.m_Master <> nil) then
              if (PlayObject.m_Master = BaseObject) then Continue;//20080715 ����
            if PlayObject.IsProperTarget(BaseObject) then begin
              if Random(BaseObject.m_btAntiPoison + 7) <= 7 then begin
                Result := True;
                with PlayObject do begin
                  nPower := GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.SC),
                    SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1) * 2;
                end;
                nPower := Round(nPower * (g_Config.nHeroAttackRate_63 / 100));//�ɻ��������� 20080131
                if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin//Ŀ�����˻�Ӣ�����жϾ��� 20080626
                  nPower :=Round(nPower* (g_Config.nDecDragonRate / 100));//20080803 �ϻ����˵��˺�����
                  if BaseObject.m_Abil.WineDrinkValue > 0 then begin//������Ϊ0ʱ
                    nPower :=Round(nPower* (1 - g_Config.nDecDragonHitPoint / 100));
                    BaseObject.SendRefMsg(RM_MYSHOW, ET_DRINKDECDRAGON, 0, 0, 0, '');//�ȾƵ����ϻ�����ʾ����Ч�� 20090105
                  end;
                end;
                BaseObject.SendMsg(PlayObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '');

                if g_Config.btHeroSkillMode_63 then begin//�������̶� 20080911
                  nPower := GetPower13(50, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;//�ж�ʱ�� 20080822
                  BaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {�ж����� - �̶�}, nPower, Integer(PlayObject), Round(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)), '', 1000);
                  if (TargeTBaseObject <> nil) then PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, {nPower}0, MakeLong(nTargetX, nTargetY), 3, Integer(TargeTBaseObject), '', 600);//20080826
                end;
                if g_Config.ErgumBadProtection and (TargeTBaseObject <> nil) then FinancialsDefence(TargeTBaseObject);//20090203 �ϻ��Ʊ������
                BaseObject.SetLastHiter(PlayObject);
                if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin //20080531 ����Ӣ��������,����������
                   if not THeroObject(PlayObject).m_boTarget then PlayObject.SetTargetCreat(BaseObject);
                end else PlayObject.SetTargetCreat(BaseObject);
              end;
            end;
          end;
        end;
      finally
        BaseObjectList.Free;
      end;
    end;
  except
    //MainOutMessage('{�쳣} TMagicManager.MagMakeSkillFire_63');
  end;
end;
//ĩ������  ��+��  //20081216 �޸ĳ�Ⱥ�幥��
function TMagicManager.MagMakeSkillFire_64(PlayObject: TBaseObject;
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  nPower: Integer;
  I: Integer;//20081216
  BaseObjectList: TList;//20081216
  BaseObject: TBaseObject;//20081216
  function MPow(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
begin
  Result := False;
  if PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    if PlayObject.m_TargetCret = nil then Exit;//��Ŀ�����������ܹ����ķ�Χ
    BaseObjectList := TList.Create;
    try                                                                                                                  
      PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, PlayObject.m_TargetCret.m_nCurrX, PlayObject.m_TargetCret.m_nCurrY, g_Config.nHeroAttackRange_64{������Χ}, BaseObjectList);
      if BaseObjectList.Count > 0 then begin
        for I := 0 to BaseObjectList.Count - 1 do begin
          BaseObject := TBaseObject(BaseObjectList.Items[I]);
          nPower := 0;
          if BaseObject <> nil then begin
            if PlayObject.IsProperTarget(BaseObject) then begin
              if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin//�ϻ������Լ���Ӣ�� 20090126
                if (TPlayObject(PlayObject).m_MyHero <> nil) and (BaseObject <> nil) then begin
                  if TPlayObject(PlayObject).m_MyHero = BaseObject then Continue;
                end;
              end;
              if BaseObject.m_Master <> nil then begin
                if BaseObject.m_Master = PlayObject then Continue;
              end;
              if (BaseObject.m_nAntiMagic <= Random(10)) and (abs(BaseObject.m_nCurrX - nTargetX) <= g_Config.nHeroAttackRange_64) and (abs(BaseObject.m_nCurrY - nTargetY) <= g_Config.nHeroAttackRange_64) then begin
                with PlayObject do begin
                  case m_btJob of
                    1: nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC), SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1) * 2;
                    2: nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.SC), SmallInt(HiWord(m_WAbil.SC) - LoWord(m_WAbil.SC)) + 1) * 2;
                  end;
                end;
                nPower := Round(nPower * (g_Config.nHeroAttackRate_64 / 100));//ĩ���������� 20080131
                if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin//Ŀ�����˻�Ӣ�����жϾ��� 20080626
                   nPower :=Round(nPower* (g_Config.nDecDragonRate / 100));//20080803 �ϻ����˵��˺�����
                   if BaseObject.m_Abil.WineDrinkValue > 0 then begin//������Ϊ0ʱ
                     nPower :=Round(nPower* (1 - g_Config.nDecDragonHitPoint / 100));
                     BaseObject.SendRefMsg(RM_MYSHOW, ET_DRINKDECDRAGON, 0, 0, 0, '');//�ȾƵ����ϻ�����ʾ����Ч�� 20090105
                   end;
                end;
                if (abs(BaseObject.m_nCurrX - nTargetX) > 1) and (abs(BaseObject.m_nCurrY - nTargetY) > 1) then begin
                  nPower := Round(nPower * 0.4);
                end;
                {if BaseObject.m_btRaceServer <> RC_PLAYMOSTER then//20080604 �����ιֲ�����
                   //BaseObject.MagDownHealth(1, (Random(3) + UserMagic.btLevel) * 2 + 1, nPower div 15 + 1);//20081002 �޸�
                   BaseObject.MagDownHealth(1, 1, Round(nPower * 0.15)+ 1);//20090112 �޸�,��������15%����  20090204 ������}

                BaseObject.SendMsg(PlayObject, RM_MAGSTRUCK, 0, nPower, 0, 0, '');
                if g_Config.ErgumBadProtection then FinancialsDefence(BaseObject);//20080218 �ϻ��Ʊ������
                Result := True;
              end;
            end;
          end;
        end;
      end;
    finally
      BaseObjectList.Free;
    end;
  end;
end;
//��������  ��+��
function TMagicManager.MagMakeSkillFire_65(BaseObject: TBaseObject; nPower: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  nPowerValue: Integer;
begin
  Result := False;
  if BaseObject.m_TargetCret= nil then Exit;//20080418 �޸���Ŀ�����������ܹ����ķ�Χ
  BaseObjectList := TList.Create;
  try
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, BaseObject.m_TargetCret.m_nCurrX{BaseObject.m_nCurrX}, BaseObject.m_TargetCret.m_nCurrY{BaseObject.m_nCurrY}, g_Config.nHeroAttackRange_65{������Χ}, BaseObjectList); //�������� ������Χ 20080131
    if BaseObjectList.Count > 0 then begin//20080629
      for I := 0 to BaseObjectList.Count - 1 do begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
        if BaseObject.IsProperTarget(TargeTBaseObject) then begin
          if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin//�ϻ������Լ���Ӣ�� 20090126
            if (TPlayObject(BaseObject).m_MyHero <> nil) and (TargeTBaseObject <> nil) then begin
              if TPlayObject(BaseObject).m_MyHero = TargeTBaseObject then Continue;
            end;
          end;
          //BaseObject.SetTargetCreat(TargeTBaseObject);
          nPowerValue := Round(nPower * 2 * (g_Config.nHeroAttackRate_65 / 100));//������������ 20080131

          if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT) then begin//Ŀ�����˻�Ӣ�����жϾ��� 20080626
             nPowerValue :=Round(nPowerValue* (g_Config.nDecDragonRate / 100));//20080803 �ϻ����˵��˺�����
             if TargeTBaseObject.m_Abil.WineDrinkValue > 0 then begin//������Ϊ0ʱ
               nPowerValue :=Round(nPowerValue * (1 - g_Config.nDecDragonHitPoint div 100));
               TargeTBaseObject.SendRefMsg(RM_MYSHOW, ET_DRINKDECDRAGON, 0, 0, 0, '');//�ȾƵ����ϻ�����ʾ����Ч�� 20090105
             end;
          end;
          TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPowerValue, 0, 0, '');
          if g_Config.ErgumBadProtection then FinancialsDefence(TargeTBaseObject);//20080218 �ϻ��Ʊ������
          Result := True;
        end;
      end;
    end;
  except
    BaseObjectList.Free;
  end;
end;
//�Ƿ���սʿ����
function TMagicManager.IsWarrSkill(wMagIdx: Integer): Boolean;
begin
  Result := False;
  if wMagIdx in [SKILL_ONESWORD {3}, SKILL_ILKWANG {4}, SKILL_YEDO {7}, SKILL_ERGUM {12}, SKILL_BANWOL {25}, SKILL_FIRESWORD {26}, SKILL_MOOTEBO {27}, SKILL_40 {40}, SKILL_42{42}, SKILL_43{43},SKILL_74{74}] then
    Result := True;
end;

function TMagicManager.DoSpell(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
var
  boTrain: Boolean;
  boSpellFail: Boolean;
  boSpellFire: Boolean;
  nPower: Integer;
  nAmuletIdx: Integer;
  nPowerRate: Integer;
  nDelayTime: Integer;
  nDelayTimeRate: Integer;
  function MPow(UserMagic: pTUserMagic): Integer; 
  begin
    Result := UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
  end;
  function GetPower(nPower: Integer): Integer;
  begin
    Result := Round(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  end;
  function GetPower13(nInt: Integer): Integer;
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := Round(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word;
  begin
    if HiWord(wInt) > LoWord(wInt) then begin
      Result := Random(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt);
    end else Result := LoWord(wInt);
  end;
  procedure sub_4934B4(PlayObject: TBaseObject);
  begin
    if PlayObject.m_UseItems[U_ARMRINGL].Dura < 100 then begin
      PlayObject.m_UseItems[U_ARMRINGL].Dura := 0;
      if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
        TPlayObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
      end else
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
        THeroObject(PlayObject).SendDelItems(@PlayObject.m_UseItems[U_ARMRINGL]);
      end;
      PlayObject.m_UseItems[U_ARMRINGL].wIndex := 0;
    end;
  end;
begin
  Result := False;
try
  if TargeTBaseObject <> nil then  //20080215 �޸�,
    if (TargeTBaseObject.m_boGhost) or (TargeTBaseObject.m_boDeath) or (TargeTBaseObject.m_WAbil.HP <=0) then Exit;//20080428 �޸�
  if IsWarrSkill(UserMagic.wMagIdx) then Exit;
  if (abs(PlayObject.m_nCurrX - nTargetX) > g_Config.nMagicAttackRage) or (abs(PlayObject.m_nCurrY - nTargetY) > g_Config.nMagicAttackRage) then begin
    Exit;
  end;

  if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if g_FunctionNPC <> nil then g_FunctionNPC.GotoLable(TPlayObject(PlayObject), '@MagSelfFunc'+inttostr(UserMagic.MagicInfo.wMagicId), False); //���＼�ܴ��� 20080609
    if (PlayObject.m_btJob = 0) and (UserMagic.MagicInfo.wMagicId = 61) then begin //20080611 ����նսʿЧ��
       PlayObject.m_btDirection:= GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);//20080611
       PlayObject.SendRefMsg(RM_MYSHOW, 5,0, 0, 0, ''); //����սʿ������  20080611
       PlayObject.SendAttackMsg(RM_PIXINGHIT, PlayObject.m_btDirection, PlayObject.m_nCurrX, PlayObject.m_nCurrY);
    end else
    if (PlayObject.m_btJob = 0) and (UserMagic.MagicInfo.wMagicId = 62) then begin //20080611 ����һ��սʿЧ��
       PlayObject.m_btDirection:= GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);//20080611
       PlayObject.SendAttackMsg(RM_LEITINGHIT, PlayObject.m_btDirection, PlayObject.m_nCurrX, PlayObject.m_nCurrY);
    end else
    PlayObject.SendRefMsg(RM_SPELL, UserMagic.MagicInfo.btEffect, nTargetX, nTargetY, UserMagic.MagicInfo.wMagicId, '');
  end;

  if (TargeTBaseObject <> nil) and (UserMagic.MagicInfo.wMagicId <> SKILL_57) and (UserMagic.MagicInfo.wMagicId <> SKILL_54) and (UserMagic.MagicInfo.wMagicId < 100) then begin
    if (TargeTBaseObject.m_boDeath) then TargeTBaseObject := nil;
  end;
  boTrain := False;
  boSpellFail := False;
  boSpellFire := True;
 // nPower := 0;  //20080117ע��
  if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if (TPlayObject(PlayObject).m_nSoftVersionDateEx = 0) and (TPlayObject(PlayObject).m_dwClientTick = 0) and (UserMagic.MagicInfo.wMagicId > 40) then Exit;
  end;

  case UserMagic.MagicInfo.wMagicId of //
    SKILL_FIREBALL {1},//������
      SKILL_FIREBALL2 {5}: begin //�����
        if MagMakeFireball(PlayObject, UserMagic,nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
      end;
    SKILL_HEALLING {2}: begin //������
        if MagTreatment(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
      end;
    SKILL_AMYOUNSUL {6}: begin //ʩ����
        if MagLightening(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject, boSpellFail) then
          boTrain := True;
      end;
    SKILL_FIREWIND {8}: begin //���ܻ�  00493754
        if MagPushArround(PlayObject, UserMagic.btLevel) > 0 then boTrain := True;
      end;
    SKILL_FIRE {9}: begin //������ 00493778
        if MagMakeHellFire(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
      end;
    SKILL_SHOOTLIGHTEN {10}: begin //�����Ӱ
        if MagMakeQuickLighting(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
      end;
    SKILL_LIGHTENING {11}: begin //�׵���
        if MagMakeLighting(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
      end;
      SKILL_FIRECHARM {13},
      SKILL_HANGMAJINBUB {14},
      SKILL_DEJIWONHO {15},
      SKILL_HOLYSHIELD {16},
      SKILL_SKELLETON {17},
      SKILL_CLOAK {18},
      SKILL_BIGCLOAK {19},
      SKILL_52, {52}
      SKILL_57,
      SKILL_59: begin //004940BC
        boSpellFail := True;
        if CheckAmulet(PlayObject, 1, 1, nAmuletIdx) then begin
          UseAmulet(PlayObject, 1, 1, nAmuletIdx);
          case UserMagic.MagicInfo.wMagicId of //
            SKILL_FIRECHARM {13}: begin //�����
                if MagMakeFireCharm(PlayObject,
                  UserMagic,
                  nTargetX,
                  nTargetY,
                  TargeTBaseObject) then boTrain := True;
              end;
            SKILL_HANGMAJINBUB {14}: begin //�����
                nPower := PlayObject.GetAttackPower(GetPower13(60) + LoWord(PlayObject.m_WAbil.SC) * 10, SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 1) > 0 then
                  boTrain := True;
              end;
            SKILL_DEJIWONHO {15}: begin //��ʥս���� 004942E5
                nPower := PlayObject.GetAttackPower(GetPower13(60) + LoWord(PlayObject.m_WAbil.SC) * 10, SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
                if PlayObject.MagMakeDefenceArea(nTargetX, nTargetY, 3, nPower, 0) > 0 then
                  boTrain := True;
              end;
            SKILL_HOLYSHIELD {16}: begin //��ħ�� 00494353
                if MagMakeHolyCurtain(PlayObject, GetPower13(40) + GetRPow(PlayObject.m_WAbil.SC) * 3, nTargetX, nTargetY) > 0 then
                  boTrain := True;
              end;
            SKILL_SKELLETON {17}: begin //�ٻ����� 004943A2
                if MagMakeSlave(PlayObject, UserMagic) then begin
                  boTrain := True;
                end;
              end;
            SKILL_CLOAK {18}: begin //������
                if MagMakePrivateTransparent(PlayObject, GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 3) then
                  boTrain := True;
              end;
            SKILL_BIGCLOAK {19}: begin //����������
                if MagMakeGroupTransparent(PlayObject, nTargetX, nTargetY, GetPower13(30) + GetRPow(PlayObject.m_WAbil.SC) * 3) then
                  boTrain := True;
              end;
            SKILL_52: begin //������
                nPower := PlayObject.GetAttackPower(GetPower13(20) + LoWord(PlayObject.m_WAbil.SC) * 2, SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) + 1);
                if PlayObject.MagMakeAbilityArea(nTargetX, nTargetY, 3, nPower) > 0 then
                  boTrain := True;
              end;
            SKILL_57: begin //������
                if MagMakeLivePlayObject(PlayObject, UserMagic, TargeTBaseObject) then boTrain := True;
              end;
            SKILL_59: begin//��Ѫ�� 20080511
                if MagFireCharmTreatment(PlayObject,UserMagic,nTargetX,nTargetY,TargeTBaseObject) then boTrain := True;
              end;
          end;
          boSpellFail := False;
          sub_4934B4(PlayObject);
        end;
      end;
    SKILL_TAMMING {20}: begin //�ջ�֮��
        if PlayObject.IsProperTarget(TargeTBaseObject) then begin
          if MagTamming(PlayObject, TargeTBaseObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_SPACEMOVE {21}: begin //˲Ϣ�ƶ�
        PlayObject.SendRefMsg(RM_MAGICFIRE, 0, MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect), MakeLong(nTargetX, nTargetY), Integer(TargeTBaseObject), '');
        boSpellFire := False;
        if MagSaceMove(PlayObject, UserMagic.btLevel) then
          boTrain := True;
      end;
    SKILL_EARTHFIRE {22}: begin //��ǽ
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC),
          SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
        nDelayTime := GetPower(10) + (Word(GetRPow(PlayObject.m_WAbil.MC)) shr 1);
        //2006-11-12 ��ǽ������ʱ��ı���
        nPowerRate := Round(nPower * (g_Config.nFirePowerRate / 100));
        nDelayTimeRate := Round(nDelayTime * (g_Config.nFireDelayTimeRate / 100));
        if MagMakeFireCross(PlayObject, nPowerRate,
          nDelayTimeRate,
          nTargetX,
          nTargetY) > 0 then
          boTrain := True;
      end;
    SKILL_FIREBOOM {23}: begin //���ѻ���
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          g_Config.nFireBoomRage {1}, SKILL_FIREBOOM) then
          boTrain := True;
      end;
    SKILL_LIGHTFLOWER {24}: begin //�����׹�
        if MagElecBlizzard(PlayObject, PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1)) then
          boTrain := True;
      end;
    SKILL_SHOWHP {28}: begin//������ʾ
        if (TargeTBaseObject <> nil) and not TargeTBaseObject.m_boShowHP then begin
          if Random(6) <= (UserMagic.btLevel + 3) then begin
            TargeTBaseObject.m_dwShowHPTick := GetTickCount();
            TargeTBaseObject.m_dwShowHPInterval := GetPower13(GetRPow(PlayObject.m_WAbil.SC) * 2 + 30) * 1000;
            TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_DOOPENHEALTH, 0, 0, 0, 0, '', 1500);
            boTrain := True;
          end;
        end;
      end;
    SKILL_BIGHEALLING {29}: begin //Ⱥ��������
        nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.SC) * 2,
          SmallInt(HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC)) * 2 + 1);
        if MagBigHealing(PlayObject, nPower + PlayObject.m_WAbil.Level, nTargetX, nTargetY) then boTrain := True;
      end;
    SKILL_SINSU {30}: begin  //�ٻ�����
        boSpellFail := True;
        if CheckAmulet(PlayObject, 5, 1, nAmuletIdx) then begin
          UseAmulet(PlayObject, 5, 1, nAmuletIdx);
          if MagMakeSinSuSlave(PlayObject, UserMagic) then begin
            boTrain := True;
          end;
          boSpellFail := False;
        end;
      end;
    SKILL_SHIELD {31},SKILL_66: begin //ħ����,4��ħ���� 20080624
          if PlayObject.MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(PlayObject.m_WAbil.MC) + 15)) then
           boTrain := True;
      end;
    SKILL_73 {73}: begin //������  20080301
          if PlayObject.MagBubbleDefenceUp(UserMagic.btLevel, GetPower(GetRPow(PlayObject.m_WAbil.SC) + 15)) then
            boTrain := True;
      end;
    SKILL_75 {75}: begin //������� 20080107
          if (GetTickCount - PlayObject.m_boProtectionTick > g_Config.dwProtectionTick) then begin
            if PlayObject.MagProtectionDefenceUp(UserMagic.btLevel) then begin
              boTrain := True;
              PlayObject.SysMsg(g_sOpenShieldMsg{'���������Ч'},c_Blue,t_Hint);//��ʾ�û�;
            end;
          end else begin
             PlayObject.SysMsg(Format_ToStr(g_sOpenShieldTickMsg, [(g_Config.dwProtectionTick-(GetTickCount - PlayObject.m_boProtectionTick))div 1000]), c_Red, t_Hint);
             Exit;
          end;
       {   PlayObject.m_wStatusTimeArr[STATE_ProtectionDEFENCE]:=1; //�����ƶܵĶ���
          //PlayObject.SysMsg('�رջ������',c_Blue,t_Hint);//��ʾ�û�;
          PlayObject.m_boProtectionTick := GetTickCount;//������ܽ���ʱ�� 20080228 }
      end;
    SKILL_KILLUNDEAD {32}: begin //ʥ����
        if PlayObject.IsProperTarget(TargeTBaseObject) then begin
          if MagTurnUndead(PlayObject, TargeTBaseObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_SNOWWIND {33}: begin //������
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          g_Config.nSnowWindRange {1},SKILL_SNOWWIND) then
          boTrain := True;
      end;
    SKILL_UNAMYOUNSUL {34}: begin //�ⶾ��
        if MagMakeUnTreatment(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
      end;
    SKILL_WINDTEBO {35}: if MagWindTebo(PlayObject, UserMagic) then boTrain := True;
    SKILL_MABE {36}: begin //�����
        with PlayObject do begin
          nPower := GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(m_WAbil.MC),
            SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
        end;
        if MabMabe(PlayObject, TargeTBaseObject, nPower, UserMagic.btLevel, nTargetX, nTargetY) then boTrain := True;
      end;
    SKILL_GROUPLIGHTENING {37 Ⱥ���׵���}: begin
        if MagGroupLightening(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject, boSpellFire) then
          boTrain := True;
      end;
    SKILL_GROUPAMYOUNSUL {38 Ⱥ��ʩ����}: begin
        if MagGroupAmyounsul(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then  boTrain := True;
      end;
    SKILL_GROUPDEDING {39 �ض�}: begin
        if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if GetTickCount - TPlayObject(PlayObject).m_dwDedingUseTick > g_Config.nDedingUseTime * 1000 then begin
            TPlayObject(PlayObject).m_dwDedingUseTick := GetTickCount;
            if MagGroupDeDing(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
          end;
        end else begin
          if (TargeTBaseObject <> nil) and MagGroupDeDing(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then
            boTrain := True;
        end;
      end;
    SKILL_41: begin //ʨ�Ӻ�
        if MagGroupMb(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then begin
          boTrain := True;
        end;
      end;
    SKILL_42: begin //����ն
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
      end;
    SKILL_43: begin //��Ӱ����
          if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
      end;
    //��ʦ
    SKILL_44: begin //������
        if MagHbFireBall(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
      end;
    SKILL_45: begin //�����
        if MagMakeFireDay(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
       // boSpellFire:=False;//20080113
      end;
    SKILL_46: begin //������
        if MagMakeSelf(PlayObject, TargeTBaseObject, UserMagic) then begin
          boTrain := True;
        end;
      end;
    SKILL_47: begin //��������
        if MagBigExplosion(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          g_Config.nFireBoomRage {1},SKILL_47) then
          boTrain := True;
      end;
    SKILL_58: begin //���ǻ��� 20080510
        if MagBigExplosion1(PlayObject,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1),
          nTargetX,
          nTargetY,
          g_Config.nMeteorFireRainRage) then
          boTrain := True;
      end;
    //��ʿ
    SKILL_48: begin //������
        if MagPushArround(PlayObject, UserMagic.btLevel) > 0 then boTrain := True;
      end;
    SKILL_49: begin //������
        boTrain := True;
      end;
    SKILL_50: begin //�޼�����
        if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
          if TPlayObject(PlayObject).AbilityUp(UserMagic) then boTrain := True;
        end else
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
          if THeroObject(PlayObject).AbilityUp(UserMagic) then boTrain := True;
        end;
      end;
    SKILL_51: begin //쫷���
        if MagGroupFengPo(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject) then boTrain := True;
      end;
    SKILL_53: begin //Ѫ��
        boTrain := True;
      end;
    SKILL_54: begin //������
        if PlayObject.IsProperTargetSKILL_54(TargeTBaseObject) then begin
          if MagTamming2(PlayObject, TargeTBaseObject, nTargetX, nTargetY, UserMagic.btLevel) then
            boTrain := True;
        end;
      end;
    SKILL_55: begin //������
        if MagMakeArrestObject(PlayObject, UserMagic, TargeTBaseObject) then boTrain := True;
      end;
    SKILL_56: begin //���л�λ
        if (GetTickCount - PlayObject.m_boMagChangXYTick > g_Config.dwMagChangXYTick) then begin//���л�λʹ�ü�� 20080616
           if MagChangePosition(PlayObject, nTargetX, nTargetY) then begin
              PlayObject.m_boMagChangXYTick:= GetTickCount;
              boTrain := True;
           end;
        end else begin
           PlayObject.SysMsg(Format_ToStr(g_sOpenShieldTickMsg, [(g_Config.dwMagChangXYTick-(GetTickCount - PlayObject.m_boMagChangXYTick))div 1000]), c_Red, t_Hint);
           Exit;
        end;
      end;
    SKILL_68: begin//�������� 20080625
        MagMakeHPUp(PlayObject, UserMagic);
        boTrain := False;
      end;
    SKILL_72: begin //�ٻ�����
        if CheckAmulet(PlayObject, 5, 1, nAmuletIdx) then begin
           UseAmulet(PlayObject, 5, 1, nAmuletIdx);
           if MagMakeFairy(PlayObject, UserMagic) then
           begin
              boTrain := True;
           end;
        end;
      end;
{$IF HEROVERSION = 1}
    SKILL_60: begin  //�ƻ�ն  ս+ս
        MagMakeSkillFire_60(PlayObject, UserMagic,
          PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.DC), SmallInt(HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC)) + 1) * 3);
        boTrain:= False;
      end;
    SKILL_61: begin //����ն  ս+��
        MagMakeSkillFire_61(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject);
        boTrain:= False;
      end;
    SKILL_62: begin//����һ��  ս+��
        MagMakeSkillFire_62(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject);
        boTrain:= False;
      end;
    SKILL_63: begin //�ɻ�����  ��+��
        MagMakeSkillFire_63(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject);
        boTrain:= False;
     end;
    SKILL_64: begin //ĩ������  ��+��
        MagMakeSkillFire_64(PlayObject, UserMagic, nTargetX, nTargetY, TargeTBaseObject);
        boTrain:= False;
      end;
    SKILL_65: begin //��������  ��+��
        MagMakeSkillFire_65(PlayObject, PlayObject.GetAttackPower(GetPower(MPow(UserMagic)) + LoWord(PlayObject.m_WAbil.MC), SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1));
        boTrain:= False;
      end;
{$IFEND}
  else begin
      if Assigned(zPlugOfEngine.SetHookDoSpell) then begin
        boTrain := zPlugOfEngine.SetHookDoSpell(Self, TPlayObject(PlayObject), UserMagic, nTargetX, nTargetY, TargeTBaseObject, boSpellFail, boSpellFire);
      end;
    end;
  end;
  if boSpellFail then Exit;
  if boSpellFire {and (UserMagic.MagicInfo.wMagicId <> 60)} then begin //20080111 ��4���ټ��ܲ�����Ϣ
   { PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
      MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
      MakeLong(nTargetX, nTargetY),
      Integer(TargeTBaseObject),
      '');  }

    if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      PlayObject.SendRefMsg(RM_MAGICFIRE, 0,MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
                            MakeLong(nTargetX, nTargetY),Integer(TargeTBaseObject),'');
    end;
  end;

  if (UserMagic.btLevel < 3) and (boTrain) then begin
    if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] <= PlayObject.m_Abil.Level then begin
      PlayObject.TrainSkill(UserMagic, Random(3) + 1);///���Ӽ��ܵ�����ֵ
      if not PlayObject.CheckMagicLevelup(UserMagic) then begin
        if PlayObject.m_btRaceServer = RC_PLAYOBJECT then begin
          PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 1000);
        end else
          if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin
          THeroObject(PlayObject).SendDelayMsg(PlayObject, RM_HEROMAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 1000);
        end else begin
          //PlayObject.SendDelayMsg(PlayObject, RM_MAGIC_LVEXP, 0, UserMagic.MagicInfo.wMagicId, UserMagic.btLevel, UserMagic.nTranPoint, '', 1000);
        end;
      end;
    end;
  end;
  Result := True;
  except
    on E: Exception do begin
      MainOutMessage(Format('{�쳣} TMagicManager.DoSpell MagID:%d X:%d Y:%d', [UserMagic.wMagIdx, nTargetX, nTargetY]));
    end;
  end;
end;
//������
function TMagicManager.MagMakePrivateTransparent(BaseObject: TBaseObject; nHTime: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  if BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT] > 0 then Exit;
  BaseObjectList := TList.Create;
  try
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 9, BaseObjectList);
    if BaseObjectList.Count > 0 then begin//20080628
      for I := 0 to BaseObjectList.Count - 1 do begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
        if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and (TargeTBaseObject.m_TargetCret = BaseObject) then begin
          if (abs(TargeTBaseObject.m_nCurrX - BaseObject.m_nCurrX) > 1) or
            (abs(TargeTBaseObject.m_nCurrY - BaseObject.m_nCurrY) > 1) or
            (Random(2) = 0) then begin
            TargeTBaseObject.m_TargetCret := nil;
          end;
        end;
      end;
    end;
  finally
    BaseObjectList.Free;
  end;
  BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT] := nHTime;
  BaseObject.m_nCharStatus := BaseObject.GetCharStatus();
  BaseObject.StatusChanged('');
  BaseObject.m_boHideMode := True;
  BaseObject.m_boTransparent := True;
  Result := True;
end;
{//δʹ�� 20080410
function TMagicManager.MagReturn(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
begin
  Result := False;
  TargeTBaseObject.ReAlive;
  TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.MaxHP;
  TargeTBaseObject.SendMsg(TargeTBaseObject, RM_ABILITY, 0, 0, 0, 0, '');
  Result := True;
end;}

function TMagicManager.MagTamming2(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
begin
  Result := False;
  if (TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and ((Random(4 - nMagicLevel) = 0)) then begin
    TargeTBaseObject.m_TargetCret := nil;
    if Random(2) = 0 then begin
      if TargeTBaseObject.m_Abil.Level <= BaseObject.m_Abil.Level + 2 then begin
        if Random(3) = 0 then begin
          if Random((BaseObject.m_Abil.Level + 20) + (nMagicLevel * 5)) > (TargeTBaseObject.m_Abil.Level + g_Config.nMagTammingTargetLevel {10}) then begin
            if not (TargeTBaseObject.bo2C1) and
              (TargeTBaseObject.m_btLifeAttrib = 0) and
              (TargeTBaseObject.m_Abil.Level < g_Config.nMagTammingLevel {50}) and
              (BaseObject.m_SlaveList.Count < g_Config.nMagTammingCount {(nMagicLevel + 2)}) then begin
              TargeTBaseObject.m_Master := BaseObject;
              TargeTBaseObject.m_dwMasterRoyaltyTick := LongWord((Random(BaseObject.m_Abil.Level * 2) + (nMagicLevel shl 2) * 5 + 20) * 60000{60 * 1000}) {+ GetTickCount};
              TargeTBaseObject.m_dwMasterRoyaltyTime := GetTickCount;//20080813 ����
              TargeTBaseObject.m_btSlaveMakeLevel := nMagicLevel;
              if TargeTBaseObject.m_dwMasterTick = 0 then TargeTBaseObject.m_dwMasterTick := GetTickCount();
              TargeTBaseObject.BreakHolySeizeMode();
              if LongWord(1500 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nWalkSpeed) then begin
                TargeTBaseObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
              end;
              if LongWord(2000 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nNextHitTime) then begin
                TargeTBaseObject.m_nNextHitTime := 2000 - nMagicLevel * 200;
              end;
              TargeTBaseObject.ReAlive;
              TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.MaxHP;
              TargeTBaseObject.SendMsg(TargeTBaseObject, RM_ABILITY, 0, 0, 0, 0, '');
              TargeTBaseObject.RefShowName();
              BaseObject.m_SlaveList.Add(TargeTBaseObject);
            end;
          end;
        end else begin
          if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) = 0) then
            TargeTBaseObject.OpenCrazyMode(Random(20) + 10);
        end;
      end else begin
        if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
          TargeTBaseObject.OpenCrazyMode(Random(20) + 10); //���
      end;
    end;
  end;
  Result := True;
end;

function TMagicManager.MagTamming(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nMagicLevel: Integer): Boolean;
var
  n14: Integer;
begin
  Result := False;
  if (TargeTBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and ((Random(4 - nMagicLevel) = 0)) then begin
    TargeTBaseObject.m_TargetCret := nil;
    if TargeTBaseObject.m_Master = BaseObject then begin
      TargeTBaseObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
      Result := True;
    end else begin
      if Random(2) = 0 then begin
        if TargeTBaseObject.m_Abil.Level <= BaseObject.m_Abil.Level + 2 then begin
          if Random(3) = 0 then begin
            if Random((BaseObject.m_Abil.Level + 20) + (nMagicLevel * 5)) > (TargeTBaseObject.m_Abil.Level + g_Config.nMagTammingTargetLevel {10}) then begin
              if not (TargeTBaseObject.bo2C1) and
                (TargeTBaseObject.m_btLifeAttrib = 0) and
                (TargeTBaseObject.m_Abil.Level < g_Config.nMagTammingLevel {50}) and
                (BaseObject.m_SlaveList.Count < g_Config.nMagTammingCount {(nMagicLevel + 2)}) then begin
                n14 := TargeTBaseObject.m_WAbil.MaxHP div g_Config.nMagTammingHPRate {100};
                if n14 <= 2 then n14 := 2
                else Inc(n14, n14);
                if (TargeTBaseObject.m_Master <> BaseObject) and (Random(n14) = 0) then begin
                  TargeTBaseObject.BreakCrazyMode();
                  if TargeTBaseObject.m_Master <> nil then begin
                    TargeTBaseObject.m_WAbil.HP := TargeTBaseObject.m_WAbil.HP div 10;
                  end;
                  TargeTBaseObject.m_Master := BaseObject;
                  TargeTBaseObject.m_dwMasterRoyaltyTick := LongWord((Random(BaseObject.m_Abil.Level * 2) + (nMagicLevel shl 2) * 5 + 20) * 60000{60 * 1000}) {+ GetTickCount};
                  TargeTBaseObject.m_dwMasterRoyaltyTime := GetTickCount;//20080813 ����
                  TargeTBaseObject.m_btSlaveMakeLevel := nMagicLevel;
                  if TargeTBaseObject.m_dwMasterTick = 0 then TargeTBaseObject.m_dwMasterTick := GetTickCount();
                  TargeTBaseObject.BreakHolySeizeMode();
                  if LongWord(1500 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nWalkSpeed) then begin
                    TargeTBaseObject.m_nWalkSpeed := 1500 - nMagicLevel * 200;
                  end;
                  if LongWord(2000 - nMagicLevel * 200) < LongWord(TargeTBaseObject.m_nNextHitTime) then begin
                    TargeTBaseObject.m_nNextHitTime := 2000 - nMagicLevel * 200;
                  end;
                  TargeTBaseObject.RefShowName();
                  BaseObject.m_SlaveList.Add(TargeTBaseObject);
                end else begin //004925F2
                  if Random(14) = 0 then TargeTBaseObject.m_WAbil.HP := 0;
                end;
              end else begin //00492615
                if (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) = 0) then
                  TargeTBaseObject.m_WAbil.HP := 0;
              end;
            end else begin //00492641
              if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) and (Random(20) = 0) then
                TargeTBaseObject.OpenCrazyMode(Random(20) + 10);
            end;
          end else begin //00492674
            if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then
              TargeTBaseObject.OpenCrazyMode(Random(20) + 10); //���
          end;
        end; //004926B0
      end else begin //00492699
        TargeTBaseObject.OpenHolySeizeMode((nMagicLevel * 5 + 10) * 1000);
      end;
      Result := True;
    end;
  end else begin
    if Random(2) = 0 then Result := True;
  end;
end;

function TMagicManager.MagTurnUndead(BaseObject, TargeTBaseObject: TBaseObject;
  nTargetX, nTargetY, nLevel: Integer): Boolean; //004926D4
var
  n14: Integer;
begin
  Result := False;
  if TargeTBaseObject.m_boSuperMan or not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then Exit;
  TAnimalObject(TargeTBaseObject).Struck {FFEC}(BaseObject);
  if TargeTBaseObject.m_TargetCret = nil then begin
    TAnimalObject(TargeTBaseObject).m_boRunAwayMode := True;
    TAnimalObject(TargeTBaseObject).m_dwRunAwayStart := GetTickCount();
    TAnimalObject(TargeTBaseObject).m_dwRunAwayTime := 10000{10 * 1000};
  end;

  if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin //20080531 ����Ӣ��������,����������
     if not THeroObject(BaseObject).m_boTarget then BaseObject.SetTargetCreat(TargeTBaseObject);
  end else BaseObject.SetTargetCreat(TargeTBaseObject);

  if (Random(2) + (BaseObject.m_Abil.Level - 1)) > TargeTBaseObject.m_Abil.Level then begin
    if TargeTBaseObject.m_Abil.Level < g_Config.nMagTurnUndeadLevel then begin
      n14 := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
      if Random(100) < ((nLevel shl 3) - nLevel + 15 + n14) then begin
        TargeTBaseObject.SetLastHiter(BaseObject);
        TargeTBaseObject.m_WAbil.HP := 0;
        Result := True;
      end
    end;
  end;
end;

function TMagicManager.MagWindTebo(PlayObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
var
  PoseBaseObject: TBaseObject;
begin
  Result := False;
  PoseBaseObject := PlayObject.GetPoseCreate;
  if (PoseBaseObject <> nil) and
    (PoseBaseObject <> PlayObject) and
    (not PoseBaseObject.m_boDeath) and
    (not PoseBaseObject.m_boGhost) and
    (PlayObject.IsProperTarget(PoseBaseObject)) and
    (not PoseBaseObject.m_boStickMode) then begin
    if (abs(PlayObject.m_nCurrX - PoseBaseObject.m_nCurrX) <= 1) and
      (abs(PlayObject.m_nCurrY - PoseBaseObject.m_nCurrY) <= 1) and
      (PlayObject.m_Abil.Level > PoseBaseObject.m_Abil.Level) then begin
      if Random(20) < UserMagic.btLevel * 6 + 6 + (PlayObject.m_Abil.Level - PoseBaseObject.m_Abil.Level) then begin
        PoseBaseObject.CharPushed(GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, PoseBaseObject.m_nCurrX, PoseBaseObject.m_nCurrY), _MAX(0, UserMagic.btLevel - 1) + 1);
        Result := True;
      end;
    end;
  end;
end;

function TMagicManager.MagSaceMove(BaseObject: TBaseObject;
  nLevel: Integer): Boolean;
var
  Envir: TEnvirnoment;
  PlayObject: TPlayObject;
begin
  Result := False;
  if Random(11) < nLevel * 2 + 4 then begin
    BaseObject.SendRefMsg(RM_SPACEMOVE_FIRE2, 0, 0, 0, 0, '');
    if BaseObject is TPlayObject then begin
      Envir := BaseObject.m_PEnvir;
      BaseObject.MapRandomMove(BaseObject.m_sHomeMap, 1);
      if (Envir <> BaseObject.m_PEnvir) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        PlayObject := TPlayObject(BaseObject);
        PlayObject.m_boTimeRecall := False;
      end;
    end;
    Result := True;
  end;
end;

function TMagicManager.MagGroupFengPo(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  if BaseObjectList.Count > 0 then begin//20080629
    for I := 0 to BaseObjectList.Count - 1 do begin
      BaseObject := TBaseObject(BaseObjectList.Items[I]);
      if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
      if PlayObject.IsProperTarget(BaseObject) then begin
        nPower := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.SC), SmallInt((HiWord(PlayObject.m_WAbil.SC) - LoWord(PlayObject.m_WAbil.SC))));
        {if (Random(BaseObject.m_btSpeedPoint) >= PlayObject.m_btHitPoint) then begin
          nPower := 0;
        end;}
        if nPower > 0 then begin
          nPower := BaseObject.GetHitStruckDamage(PlayObject, nPower);
        end;
        if nPower > 0 then begin
          BaseObject.StruckDamage(nPower);
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 1, Integer(BaseObject), '', 200);
        end;
        if BaseObject.m_btRaceServer >= RC_ANIMAL then
          Result := True;
      end;
    end;
  end;
  BaseObjectList.Free;
end;
//Ⱥ��ʩ����
function TMagicManager.MagGroupAmyounsul(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer; TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
  StdItem: pTStdItem;
  nAmuletIdx: Integer;
  nCode: Byte;
begin
  Result := False;
  nCode:= 0;
  try
    BaseObjectList := TList.Create;
    try
      nCode:= 1;
      PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
      nCode:= 2;
      if BaseObjectList.Count > 0 then begin
        for I := 0 to BaseObjectList.Count - 1 do begin
          nCode:= 3;
          BaseObject := TBaseObject(BaseObjectList.Items[I]);
          nCode:= 4;
          if BaseObject <> nil then begin
            if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) or (BaseObject.m_btRaceServer = 128) then Continue;//20090111 ����ħ�޲��ܶ�
            nCode:= 5;
            if PlayObject.IsProperTarget(BaseObject) then begin
              nCode:= 6;
              if CheckAmulet(PlayObject, 1, 2, nAmuletIdx) then begin
                nCode:= 7;
                StdItem := nil;//20080722
                if (nAmuletIdx = U_ARMRINGL) or (nAmuletIdx = U_BUJUK) then begin//20080722 �޸�
                  nCode:= 8;
                  if PlayObject.m_UseItems[nAmuletIdx].wIndex > 0 then
                      StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
                  nCode:= 9;
                end;
                nCode:= 20;
                //StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);//20080708
                if (StdItem = nil) or ((StdItem <> nil) and (StdItem.StdMode <> 25)) then StdItem:= UserEngine.GetStdItem(nAmuletIdx); //���װ������û����Ʒ,��Ӱ������� 20080314
                nCode:= 10;
                if StdItem <> nil then begin
                  UseAmulet(PlayObject, 1, 2, nAmuletIdx);
                  nCode:= 11;
                  if Random(BaseObject.m_btAntiPoison + 7) <= 6 then begin
                    case StdItem.Shape of
                      1: begin
                          nCode:= 12;
                          nPower := GetPower13(40, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                          //nPower :=11 + UserMagic.btLevel * 3 ;//20080329 �޸�ʱ���㷨
                          nCode:= 13;
                          BaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {�ж����� - �̶�}, nPower, Integer(PlayObject), Round(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)), '', {1000}200);
                        end;
                      2: begin
                          nCode:= 14;
                          nPower := GetPower13(30, UserMagic) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                          //nPower :=11 + UserMagic.btLevel * 3 ;//20080329 �޸�ʱ���㷨
                          nCode:= 15;
                          BaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {�ж����� - �춾}, nPower, Integer(PlayObject), Round(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)), '', {1000}200);
                        end;
                    end;
                    nCode:= 16;
                    if BaseObject <> nil then begin
                      if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer >= RC_ANIMAL) then Result := True;
                      nCode:= 17;
                      if PlayObject <> nil then begin//20081216
                        BaseObject.SetLastHiter(PlayObject);
                        nCode:= 18;
                        if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin //20080531 ����Ӣ��������,����������
                          nCode:= 19;
                          if not THeroObject(PlayObject).m_boTarget then PlayObject.SetTargetCreat(BaseObject);
                        end else PlayObject.SetTargetCreat(BaseObject);
                        nCode:= 20;
                        if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin//20081108 ������Ӣ��,Ӣ�۲�����
                          nCode:= 21;
                          if not THeroObject(BaseObject).m_boTarget then BaseObject.SetTargetCreat(PlayObject);
                        end;
                      end;
                    end;
                    nCode:= 22;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    finally
      BaseObjectList.Free;
    end;
  except
    MainOutMessage('{�쳣} TMagicManager.MagGroupAmyounsul Code:'+inttostr(nCode));
  end;
end;

function TMagicManager.MagGroupDeDing(PlayObject: TBaseObject; {�޸� TBaseObject}
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  if BaseObjectList.Count > 0 then begin//20080629
    for I := 0 to BaseObjectList.Count - 1 do begin
      BaseObject := TBaseObject(BaseObjectList.Items[I]);
      if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
      if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) and not g_Config.boDedingAllowPK then Continue;
      if PlayObject.IsProperTarget(BaseObject) then begin
        nPower := PlayObject.GetAttackPower(LoWord(PlayObject.m_WAbil.DC), SmallInt((HiWord(PlayObject.m_WAbil.DC) - LoWord(PlayObject.m_WAbil.DC))));

        if (Random(BaseObject.m_btSpeedPoint) >= PlayObject.m_btHitPoint) then begin
          nPower := 0;
        end;
        if nPower > 0 then begin
          nPower := BaseObject.GetHitStruckDamage(PlayObject, nPower);
        end;
        nPower := Round(nPower * (g_Config.nDidingPowerRate / 100));
        if nPower > 0 then begin
          BaseObject.StruckDamage(nPower);
          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 1, Integer(BaseObject), '', 200);
          //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 1, Integer(BaseObject), '');
        end;
        if BaseObject.m_btRaceServer >= RC_ANIMAL then
          Result := True;
      end;
      PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 1, '');
    end;
  end;
  BaseObjectList.Free;
end;
//Ⱥ���׵���
function TMagicManager.MagGroupLightening(PlayObject: TBaseObject; {�޸� TBaseObject}
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject; var boSpellFire: Boolean): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nPower: Integer;
begin
  Result := False;
  boSpellFire := False;
  BaseObjectList := TList.Create;
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, nTargetX, nTargetY, _MAX(1, UserMagic.btLevel), BaseObjectList);
  PlayObject.SendRefMsg(RM_MAGICFIRE, 0,
    MakeWord(UserMagic.MagicInfo.btEffectType, UserMagic.MagicInfo.btEffect),
    MakeLong(nTargetX, nTargetY),
    Integer(TargeTBaseObject),
    '');
  if BaseObjectList.Count > 0 then begin//20080629
    for I := 0 to BaseObjectList.Count - 1 do begin
      BaseObject := TBaseObject(BaseObjectList.Items[I]);
      if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
      if PlayObject.IsProperTarget(BaseObject) then begin
        if (Random(10) >= BaseObject.m_nAntiMagic) then begin
          nPower := PlayObject.GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(PlayObject.m_WAbil.MC),
            SmallInt(HiWord(PlayObject.m_WAbil.MC) - LoWord(PlayObject.m_WAbil.MC)) + 1);
          if BaseObject.m_btLifeAttrib = LA_UNDEAD then
            nPower := Round(nPower * 1.5);

          PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '', 600);
          //PlayObject.SendMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(BaseObject.m_nCurrX, BaseObject.m_nCurrY), 2, Integer(BaseObject), '');
          if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
          else if BaseObject.m_btRaceServer >= RC_ANIMAL then Result := True;
        end;
        if (BaseObject.m_nCurrX <> nTargetX) or (BaseObject.m_nCurrY <> nTargetY) then
          PlayObject.SendRefMsg(RM_10205, 0, BaseObject.m_nCurrX, BaseObject.m_nCurrY, 4 {type}, '');
      end;
    end;
  end;
  BaseObjectList.Free;
end;
//ʩ����  ���û��Ŀ��,�� boSpellFire:=False,�򲻷ų���Ч��
//0��--11�� 1��--14�� 2��--17�� 3��--20�� 
//ʱ��=11+3*���ܵȼ�
function TMagicManager.MagLightening(PlayObject: TBaseObject {�޸� TBaseObject};
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject; var boSpellFire: Boolean{�Ƿ����}): Boolean;
var
  nPower: Integer;
  StdItem: pTStdItem;
  nAmuletIdx: Integer;
  nCode: Byte;
  function GetPower13(nInt: Integer): Integer; //0049338C
  var
    d10: Double;
    d18: Double;
  begin
    d10 := nInt / 3.0;
    d18 := nInt - d10;
    Result := Round(d18 / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1) + d10 + (UserMagic.MagicInfo.btDefPower + {Random}(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower)));
  end;
  function GetRPow(wInt: Integer): Word;
  begin
    if HiWord(wInt) > LoWord(wInt) then begin
      Result := {Random}(HiWord(wInt) - LoWord(wInt) + 1) + LoWord(wInt); //��ʹ�����ֵ,ʹ�����̺춾���� 20080328
    end else Result := LoWord(wInt);
  end;
begin
  Result := False;
  nCode:=0;
try
  boSpellFire:= True;//20080322
  if TargeTBaseObject = nil then Exit;//20080908
  if TargeTBaseObject.m_btRaceServer = 128 then Exit;//20090111 ����ħ�޲��ܶ�
  if PlayObject.IsProperTarget(TargeTBaseObject) then begin
    nCode:=1;
    if CheckAmulet(PlayObject, 1, 2, nAmuletIdx) then begin
      nCode:=2;
      StdItem := nil;//20080722
      nCode:=3;
      if (nAmuletIdx = U_ARMRINGL) or (nAmuletIdx = U_BUJUK) then begin//20080722 �޸�
        nCode:=4;
        if PlayObject.m_UseItems[nAmuletIdx].wIndex > 0 then//20080623 ����
            StdItem := UserEngine.GetStdItem(PlayObject.m_UseItems[nAmuletIdx].wIndex);
      end;
      nCode:=5;
      if (StdItem = nil) or ((StdItem <> nil) and (StdItem.StdMode <> 25)) then StdItem:= UserEngine.GetStdItem(nAmuletIdx); //���װ������û����Ʒ,��Ӱ������� 20080314
      nCode:=6;
      if StdItem <> nil then begin
        nCode:=7;
        UseAmulet(PlayObject, 1, 2, nAmuletIdx);
        nCode:=8;
        if Random(TargeTBaseObject.m_btAntiPoison + 7) <= 6 then begin
          case StdItem.Shape of
            1: begin
                nCode:=9;
                nPower := GetPower13({40}20) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                //nPower :=11 + UserMagic.btLevel * 3 ;//20080329 �޸�ʱ���㷨
                nCode:=10;
                TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DECHEALTH {�ж����� - �̶�}, nPower, Integer(PlayObject), Round(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)), '', {1000}150);
              end;
            2: begin
                nCode:=11;
                nPower := GetPower13({40}20) + GetRPow(PlayObject.m_WAbil.SC) * 2;
                //nPower :=11 + UserMagic.btLevel * 3 ;//20080329 �޸�ʱ���㷨
                nCode:=12;
                TargeTBaseObject.SendDelayMsg(PlayObject, RM_POISON, POISON_DAMAGEARMOR {�ж����� - �춾}, nPower, Integer(PlayObject), Round(UserMagic.btLevel / 3 * (nPower / g_Config.nAmyOunsulPoint)), '', {1000}150);
              end;
          end;
          nCode:= 13;
          if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT) or (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then
            Result := True;
        end;
        nCode:=14;
        if PlayObject.m_btRaceServer = RC_HEROOBJECT then begin //20080531 ����Ӣ��������,����������
          nCode:=15;
          if not THeroObject(PlayObject).m_boTarget then PlayObject.SetTargetCreat(TargeTBaseObject);
        end else PlayObject.SetTargetCreat(TargeTBaseObject);
        if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin//20081102 ������Ӣ��,Ӣ�۲�����
          if not THeroObject(TargeTBaseObject).m_boTarget then TargeTBaseObject.SetTargetCreat(PlayObject);
        end;
        boSpellFire:= False;//20080322 ʩ��������
      end;
    end;
  end;
  except
    MainOutMessage('{�쳣} TMagicManager.MagLightening  Code:'+inttostr(nCode));
  end;
end;
//������ ����ն ��Ӱ����
function TMagicManager.MagHbFireBall(PlayObject: TBaseObject; UserMagic: pTUserMagic;
  nTargetX, nTargetY: Integer; var TargeTBaseObject: TBaseObject): Boolean;
var
  nPower, NGSecPwr: Integer;
  nDir: Integer;
  levelgap: Integer;
  push: Integer;
begin
  Result := False;
  if not PlayObject.MagCanHitTarget(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject) then begin
    TargeTBaseObject := nil;
    Exit;
  end;
  if not PlayObject.IsProperTarget(TargeTBaseObject) then begin
    TargeTBaseObject := nil;
    Exit;
  end;
  if (TargeTBaseObject.m_nAntiMagic > Random(10)) or (abs(TargeTBaseObject.m_nCurrX - nTargetX) > 1) or (abs(TargeTBaseObject.m_nCurrY - nTargetY) > 1) then begin
    TargeTBaseObject := nil;
    Exit;
  end;
  with PlayObject do begin
    nPower := GetAttackPower(GetPower(MPow(UserMagic), UserMagic) + LoWord(m_WAbil.MC),
      SmallInt(HiWord(m_WAbil.MC) - LoWord(m_WAbil.MC)) + 1);
  end;

  if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    if TPlayObject(PlayObject).m_MagicSkill_226 <> nil then begin//20081223
      NGSecPwr := GetNGPow(PlayObject, TPlayObject(PlayObject).m_MagicSkill_226,nPower);//ŭ֮������
      if TargeTBaseObject <> nil then begin
        if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_227,nPower);//��֮������
        end else
        if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
          NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_227,nPower);//��֮������
        end;
      end;
      nPower := _MAX(0, nPower + NGSecPwr);
    end;
  end else
  if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
    if THEROOBJECT(PlayObject).m_MagicSkill_226 <> nil then begin//20081223
      NGSecPwr := GetNGPow(PlayObject, THEROOBJECT(PlayObject).m_MagicSkill_226,nPower);//ŭ֮������
      if TargeTBaseObject <> nil then begin
        if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_227,nPower);//��֮������
        end else
        if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
          NGSecPwr:= NGSecPwr - GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_227,nPower);//��֮������
        end;
      end;
      nPower := _MAX(0, nPower + NGSecPwr);
    end;
  end;

  PlayObject.SendDelayMsg(PlayObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
  if (TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) then Result := True;

  if (PlayObject.m_Abil.Level > TargeTBaseObject.m_Abil.Level) and (not TargeTBaseObject.m_boStickMode) then begin
    levelgap := PlayObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
    if (Random(20) < 6 + UserMagic.btLevel * 3 + levelgap) then begin
      push := Random(UserMagic.btLevel) - 1;
      if push > 0 then begin
        nDir := GetNextDirection(PlayObject.m_nCurrX, PlayObject.m_nCurrY, TargeTBaseObject.m_nCurrX, TargeTBaseObject.m_nCurrY);
        PlayObject.SendDelayMsg(PlayObject, RM_DELAYPUSHED, nDir, MakeLong(nTargetX, nTargetY), push, Integer(TargeTBaseObject), '', 600);
      end;
    end;
  end;
end;

//����������״�Ļ�
function TMagicManager.MagMakeSuperFireCross(PlayObject: TBaseObject; {�޸� TBaseObject} nDamage,
  nHTime, nX, nY: Integer; nCount: Integer): Integer;
  function MagMakeSuperFireCrossOfDir(btDir: Integer): Integer;
  var
    FireBurnEvent: TFireBurnEvent;
    I,{ II,} x, y: Integer;
    nTime: Integer;
   // x1, X2, y1, y2: string;
  begin
    Result := 0;
    nTime := 1;
    case btDir of
      DR_UP: begin
          for y := PlayObject.m_nCurrY downto PlayObject.m_nCurrY - 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, PlayObject.m_nCurrX, y, ET_FIRE, nHTime * nTime, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_UPRIGHT: begin
          for I := 0 to 6 do begin
            x := PlayObject.m_nCurrX + I;
            y := PlayObject.m_nCurrY - I;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE, nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_RIGHT: begin
          for x := PlayObject.m_nCurrX to PlayObject.m_nCurrX + 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, PlayObject.m_nCurrY, ET_FIRE, nHTime * nTime, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_DOWNRIGHT: begin
          for I := 0 to 6 do begin
            x := PlayObject.m_nCurrX + I;
            y := PlayObject.m_nCurrY + I;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE, nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_DOWN: begin
          for y := PlayObject.m_nCurrY to PlayObject.m_nCurrY + 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, PlayObject.m_nCurrX, y, ET_FIRE, nHTime * nTime, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_DOWNLEFT: begin
          for I := 0 to 6 do begin
            x := PlayObject.m_nCurrX - I;
            y := PlayObject.m_nCurrY + I;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE, nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_LEFT: begin
          for x := PlayObject.m_nCurrX downto PlayObject.m_nCurrX - 10 do begin
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, PlayObject.m_nCurrY, ET_FIRE, nHTime * nTime, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
      DR_UPLEFT: begin
          for I := 0 to 6 do begin
            x := PlayObject.m_nCurrX - I;
            y := PlayObject.m_nCurrY - I;
            FireBurnEvent := TFireBurnEvent.Create(PlayObject, x, y, ET_FIRE, nHTime * nTime * 2, nDamage);
            g_EventManager.AddEvent(FireBurnEvent);
            Inc(nTime);
          end;
        end;
    end;
    Result := 1;
  end;
var
  I: Integer;
begin
  Result := 0;
  case nCount of
    1: begin
        Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
      end;
    3: begin
        case PlayObject.m_btDirection of
          DR_UP: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
            end;
          DR_UPRIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
          DR_RIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWNRIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
            end;
          DR_DOWN: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWNLEFT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
            end;
          DR_LEFT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
            end;
          DR_UPLEFT: begin
              Result := MagMakeSuperFireCrossOfDir(PlayObject.m_btDirection);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
            end;
        end;
      end;
    4: begin
        Result := MagMakeSuperFireCrossOfDir(DR_UP);
        Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
        Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
        Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
      end;
    5: begin
        case PlayObject.m_btDirection of
          DR_UP, DR_UPLEFT, DR_UPRIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
              Result := MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
          DR_LEFT: begin
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
              Result := MagMakeSuperFireCrossOfDir(DR_UPLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
            end;
          DR_RIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(DR_UP);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
              Result := MagMakeSuperFireCrossOfDir(DR_UPRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
            end;
          DR_DOWN, DR_DOWNLEFT, DR_DOWNRIGHT: begin
              Result := MagMakeSuperFireCrossOfDir(DR_DOWN);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNRIGHT);
              Result := MagMakeSuperFireCrossOfDir(DR_DOWNLEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_LEFT);
              Result := MagMakeSuperFireCrossOfDir(DR_RIGHT);
            end;
        end;
      end;
    8: begin
        for I := DR_UP to DR_UPLEFT do Result := MagMakeSuperFireCrossOfDir(I);
      end;
  end;
end;

//��ǽ 2*2��Χ
function TMagicManager.MagMakeFireCross(PlayObject: TBaseObject; nDamage,
  nHTime, nX, nY: Integer): Integer;
var
  FireBurnEvent: TFireBurnEvent;
  NGSecPwr,nScePwr: Integer;
begin
  Result := 0;
  nScePwr:= nDamage;
  if g_Config.boDisableInSafeZoneFireCross and PlayObject.InSafeZone(PlayObject.m_PEnvir, nX, nY) then begin
    PlayObject.SysMsg('��ȫ��������ʹ��...', c_Red, t_Notice);
    Exit;
  end;
  if (PlayObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    if TPlayObject(PlayObject).m_MagicSkill_212 <> nil then begin//20081223
      NGSecPwr := GetNGPow(PlayObject, TPlayObject(PlayObject).m_MagicSkill_212,nDamage);//ŭ֮��ǽ
      nDamage := _MAX(0, nDamage + NGSecPwr);
    end;
  end else
  if (PlayObject.m_btRaceServer = RC_HEROOBJECT) then begin
    if THEROOBJECT(PlayObject).m_MagicSkill_212 <> nil then begin//20081223
      NGSecPwr := GetNGPow(PlayObject, THEROOBJECT(PlayObject).m_MagicSkill_212,nDamage);//ŭ֮��ǽ
      nDamage := _MAX(0, nDamage + NGSecPwr);
    end;  
  end;
  if PlayObject.m_PEnvir.GetEvent(nX, nY - 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY - 1, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492CFC   x
  if PlayObject.m_PEnvir.GetEvent(nX - 1, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX - 1, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492D4D
  if PlayObject.m_PEnvir.GetEvent(nX, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492D9C
  if PlayObject.m_PEnvir.GetEvent(nX + 1, nY) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX + 1, nY, ET_FIRE, nHTime * 1000, nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492DED
  if PlayObject.m_PEnvir.GetEvent(nX, nY + 1) = nil then begin
    FireBurnEvent := TFireBurnEvent.Create(PlayObject, nX, nY + 1, ET_FIRE, nHTime * 1000, nDamage);
    FireBurnEvent.nTwoPwr:= nScePwr;
    if nDamage > nScePwr then FireBurnEvent.boReadSkill:= True;//20081223 �����б仯������Ϊ��ѧ���ڹ�����
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492E3E
  Result := 1;
end;
//������  ���ѻ��� ��������
function TMagicManager.MagBigExplosion(BaseObject: TBaseObject; nPower, nX,
  nY: Integer; nRage: Integer; nCode:Byte): Boolean;
var
  I, NGSecPwr, nSePwr, nTwoPwr: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  boReadSkill: Boolean;//�Ƿ�ѧ���ڹ�����
begin
  Result := False;
  BaseObjectList := TList.Create;
  try
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
    nTwoPwr:= nPower;
    boReadSkill:= False;
    if BaseObjectList.Count > 0 then begin//20080629
      case nCode of
        SKILL_FIREBOOM: begin//���ѻ���
            if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
              if TPlayObject(BaseObject).m_MagicSkill_218 <> nil then begin//20081223
                NGSecPwr := GetNGPow(BaseObject, TPlayObject(BaseObject).m_MagicSkill_218,nTwoPwr);//ŭ֮���ѻ���
                nPower := nPower + NGSecPwr;
                boReadSkill:= True;
              end;
            end else
            if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
              if THEROOBJECT(BaseObject).m_MagicSkill_218 <> nil then begin//20081223
                NGSecPwr := GetNGPow(BaseObject, THEROOBJECT(BaseObject).m_MagicSkill_218,nTwoPwr);//ŭ֮���ѻ���
                nPower := nPower + NGSecPwr;
                boReadSkill:= True;
              end;
            end;
         end;
        SKILL_SNOWWIND: begin//������
            if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
              if TPlayObject(BaseObject).m_MagicSkill_220 <> nil then begin//20081223
                NGSecPwr := GetNGPow(BaseObject, TPlayObject(BaseObject).m_MagicSkill_220,nTwoPwr);//ŭ֮������
                nPower := nPower + NGSecPwr;
                boReadSkill:= True;
              end;
            end else
            if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
              if THEROOBJECT(BaseObject).m_MagicSkill_220 <> nil then begin//20081223
                NGSecPwr := GetNGPow(BaseObject, THEROOBJECT(BaseObject).m_MagicSkill_220,nTwoPwr);//ŭ֮������
                nPower := nPower + NGSecPwr;
                boReadSkill:= True;
              end;
            end;
         end;
      end;

      for I := 0 to BaseObjectList.Count - 1 do begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
        if BaseObject.IsProperTarget(TargeTBaseObject) then begin
          nSePwr:= nPower;
          if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin //20080531 ����Ӣ��������,����������
             if not THeroObject(BaseObject).m_boTarget then BaseObject.SetTargetCreat(TargeTBaseObject);
          end else BaseObject.SetTargetCreat(TargeTBaseObject);
        
          if boReadSkill then begin//20081223
            case nCode of
              SKILL_FIREBOOM: begin//���ѻ���
                  NGSecPwr:= 0;
                  if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                    NGSecPwr:= GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_219,nTwoPwr);//��֮���ѻ���
                  end else
                  if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                    NGSecPwr:= GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_219,nTwoPwr);//��֮���ѻ���
                  end;
                  nSePwr := _MAX(0, nSePwr - NGSecPwr);
                end;
              SKILL_SNOWWIND: begin//������
                  NGSecPwr:= 0;
                  if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                    NGSecPwr:= GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_221,nTwoPwr);//��֮������
                  end else
                  if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                    NGSecPwr:= GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_221,nTwoPwr);//��֮������
                  end;
                  nSePwr := _MAX(0, nSePwr - NGSecPwr);
                end;
            end;
          end;

          TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nSePwr, 0, 0, '');
          Result := True;
        end;
      end;
    end;
  finally
    BaseObjectList.Free;
  end;
end;
//���ǻ��� 20080510
function TMagicManager.MagBigExplosion1(BaseObject: TBaseObject; nPower, nX,
  nY: Integer; nRage: Integer): Boolean;
var
  I, NGSecPwr, nSePwr, nTwoPwr: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  Try
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, nRage, BaseObjectList);
    nTwoPwr:= nPower;
    if BaseObjectList.Count > 0 then begin//20080629
      if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        if TPlayObject(BaseObject).m_MagicSkill_234 <> nil then begin//20081223
          NGSecPwr := GetNGPow(BaseObject, TPlayObject(BaseObject).m_MagicSkill_234, nTwoPwr);//ŭ֮���ǻ���
          nPower := nPower + NGSecPwr;
        end;
      end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
        if THEROOBJECT(BaseObject).m_MagicSkill_234 <> nil then begin//20081223
          NGSecPwr := GetNGPow(BaseObject, THEROOBJECT(BaseObject).m_MagicSkill_234, nTwoPwr);//ŭ֮���ǻ���
          nPower := nPower + NGSecPwr;
        end;
      end;

      for I := 0 to BaseObjectList.Count - 1 do begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
        if TargeTBaseObject <> nil then begin
          if (BaseObject.m_btRaceServer = RC_HEROOBJECT) or (BaseObject.m_btRaceServer = RC_PLAYMOSTER) then BaseObject.m_ExpHitter := TargeTBaseObject;//20081221 Ӣ�ۿ��԰���Χ��Ŀ��
          if BaseObject.IsProperTarget(TargeTBaseObject) then begin
            if BaseObject.m_btRaceServer = RC_HEROOBJECT then begin //20080531 ����Ӣ��������,����������
              if not THeroObject(BaseObject).m_boTarget then BaseObject.SetTargetCreat(TargeTBaseObject);
            end else BaseObject.SetTargetCreat(TargeTBaseObject);

            NGSecPwr:= 0;
            if nPower > nTwoPwr then begin//20081223
              if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                NGSecPwr:= GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_235, nTwoPwr);//��֮���ǻ���
              end else
              if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
                NGSecPwr:= GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_235, nTwoPwr);//��֮���ǻ���
              end;
            end;
            nSePwr := _MAX(0, nPower - NGSecPwr);

            TargeTBaseObject.SendDelayMsg(BaseObject, RM_MAGSTRUCK, 0, nSePwr, 0, 0, '', 1500);
            Result := True;
          end;
        end;
      end;
    end;
  Finally
    BaseObjectList.Free;
  end;
end;
//�����׹�
function TMagicManager.MagElecBlizzard(BaseObject: TBaseObject; nPower: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  nPowerPoint, NGSecPwr, nSewPwr, nTwoPwr: Integer;
begin
  Result := False;
  BaseObjectList := TList.Create;
  try
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, BaseObject.m_nCurrX, BaseObject.m_nCurrY, g_Config.nElecBlizzardRange {2}, BaseObjectList);
    nTwoPwr:= nPower;
    if BaseObjectList.Count > 0 then begin//20080629
      if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        if TPlayObject(BaseObject).m_MagicSkill_224 <> nil then begin//20081223
          NGSecPwr := GetNGPow(BaseObject, TPlayObject(BaseObject).m_MagicSkill_224, nTwoPwr);//ŭ֮�����׹�
          nPower := nPower + NGSecPwr;
        end;
      end else
      if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
        if THEROOBJECT(BaseObject).m_MagicSkill_224 <> nil then begin//20081223
          NGSecPwr := GetNGPow(BaseObject, THEROOBJECT(BaseObject).m_MagicSkill_224, nTwoPwr);//ŭ֮�����׹�
          nPower := nPower + NGSecPwr;
        end;
      end;

      for I := 0 to BaseObjectList.Count - 1 do begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
        NGSecPwr:= 0;
        if nPower > nTwoPwr then begin//20081223
          if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
            NGSecPwr:= GetNGPow(TargeTBaseObject, TPlayObject(TargeTBaseObject).m_MagicSkill_225, nTwoPwr);//��֮�����׹�
          end else
          if TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT then begin
            NGSecPwr:= GetNGPow(TargeTBaseObject, THEROOBJECT(TargeTBaseObject).m_MagicSkill_225, nTwoPwr);//��֮�����׹�
          end;
        end;
        nSewPwr := _MAX(0, nPower - NGSecPwr);

        if not (TargeTBaseObject.m_btLifeAttrib = LA_UNDEAD) then begin//��Ϊ����ϵ
          nPowerPoint := nSewPwr div 10;
        end else nPowerPoint := nSewPwr;

        if BaseObject.IsProperTarget(TargeTBaseObject) then begin
          //BaseObject.SetTargetCreat(TargeTBaseObject);
          TargeTBaseObject.SendMsg(BaseObject, RM_MAGSTRUCK, 0, nPowerPoint, 0, 0, '');
          Result := True;
        end;
      end;
    end;
  finally
    BaseObjectList.Free;
  end;
end;
//��ħ��
function TMagicManager.MagMakeHolyCurtain(BaseObject: TBaseObject; nPower: Integer; nX, nY: Integer): Integer; //004928C0
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
  MagicEvent: pTMagicEvent;
  HolyCurtainEvent: THolyCurtainEvent;
begin
  Result := 0;
  if BaseObject.m_PEnvir.CanWalk(nX, nY, True) then begin
    BaseObjectList := TList.Create;
    try
      MagicEvent := nil;
      BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, 1, BaseObjectList);
      if BaseObjectList.Count > 0 then begin//20080629
        for I := 0 to BaseObjectList.Count - 1 do begin
          TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
          if ((TargeTBaseObject.m_btRaceServer = 127) or//��ħ���� �����жϵȼ� 20090112     
            ((TargeTBaseObject.m_btRaceServer >= RC_ANIMAL) and ((Random(4) + (BaseObject.m_Abil.Level - 1))> TargeTBaseObject.m_Abil.Level))) and
            {(TargeTBaseObject.m_Abil.Level < 50) and}
          (TargeTBaseObject.m_Master = nil) then begin
            TargeTBaseObject.OpenHolySeizeMode(nPower * 1000);
            if MagicEvent = nil then begin
              New(MagicEvent);
              FillChar(MagicEvent^, SizeOf(TMagicEvent), #0);
              MagicEvent.BaseObjectList := TList.Create;
              MagicEvent.dwStartTick := GetTickCount();
              MagicEvent.dwTime := nPower * 1000;
            end;
            MagicEvent.BaseObjectList.Add(TargeTBaseObject);
            Inc(Result);
          end else begin
            Result := 0;
          end;
        end;
      end;
    finally
      BaseObjectList.Free;
    end;
    if (Result > 0) and (MagicEvent <> nil) then begin
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 1, nY - 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[0] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 1, nY - 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[1] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 2, nY - 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[2] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 2, nY - 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[3] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 2, nY + 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[4] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 2, nY + 1, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[5] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX - 1, nY + 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[6] := HolyCurtainEvent;
      HolyCurtainEvent := THolyCurtainEvent.Create(BaseObject.m_PEnvir, nX + 1, nY + 2, ET_HOLYCURTAIN, nPower * 1000);
      g_EventManager.AddEvent(HolyCurtainEvent);
      MagicEvent.Events[7] := HolyCurtainEvent;
      UserEngine.m_MagicEventList.Add(MagicEvent);
    end else begin
      if MagicEvent <> nil then begin
        MagicEvent.BaseObjectList.Free;
        Dispose(MagicEvent);
      end;
    end;
  end;
end;
//Ⱥ��������
function TMagicManager.MagMakeGroupTransparent(BaseObject: TBaseObject; nX, nY,
  nHTime: Integer): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  TargeTBaseObject: TBaseObject;
begin
  Result := False;
  BaseObjectList := TList.Create;
  try
    BaseObject.GetMapBaseObjects(BaseObject.m_PEnvir, nX, nY, 1, BaseObjectList);
    if BaseObjectList.Count > 0 then begin//20080629
      for I := 0 to BaseObjectList.Count - 1 do begin
        TargeTBaseObject := TBaseObject(BaseObjectList.Items[I]);
        if BaseObject.IsProperFriend(TargeTBaseObject) then begin
          if TargeTBaseObject.m_wStatusTimeArr[STATE_TRANSPARENT ] = 0 then begin
            TargeTBaseObject.SendDelayMsg(TargeTBaseObject, RM_TRANSPARENT, 0, nHTime, 0, 0, '', 800);
            Result := True;
          end;
        end
      end;
    end;
  finally
    BaseObjectList.Free;
  end;
end;
//=====================================================================================
//���ƣ�
//���ܣ�
//������
//     BaseObject       ħ��������
//     TargeTBaseObject �ܹ�����ɫ
//     nPower           ħ������С
//     nLevel           ���������ȼ�
//     nTargetX         Ŀ������X
//     nTargetY         Ŀ������Y
//����ֵ��
//=====================================================================================
function TMagicManager.MabMabe(BaseObject, TargeTBaseObject: TBaseObject; nPower, nLevel,
  nTargetX, nTargetY: Integer): Boolean;
var
  nLv: Integer;
begin
  Result := False;
  if BaseObject.MagCanHitTarget(BaseObject.m_nCurrX, BaseObject.m_nCurrY, TargeTBaseObject) then begin
    if BaseObject.IsProperTarget(TargeTBaseObject) and (BaseObject <> TargeTBaseObject) then begin
      if (TargeTBaseObject.m_nAntiMagic <= Random(10)) and (abs(TargeTBaseObject.m_nCurrX - nTargetX) <= 1) and (abs(TargeTBaseObject.m_nCurrY - nTargetY) <= 1) then begin
        BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower div 3, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
        if (Random(2) + (BaseObject.m_Abil.Level - 1)) > TargeTBaseObject.m_Abil.Level then begin
          nLv := BaseObject.m_Abil.Level - TargeTBaseObject.m_Abil.Level;
          if (Random(g_Config.nMabMabeHitRandRate {100}) < _MAX(g_Config.nMabMabeHitMinLvLimit, (nLevel * 8) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then begin
            // if (Random(100) < ((nLevel shl 3) - nLevel + 15 + nLv)) {or (Random(abs(nLv))} then begin
            if (Random(g_Config.nMabMabeHitSucessRate {21}) < nLevel * 2 + 4) then begin
              if (TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT){or (TargeTBaseObject.m_btRaceServer = RC_HEROOBJECT)} then begin//Ӣ�ۻ�ɫ 20080721
                BaseObject.SetPKFlag(BaseObject);
                BaseObject.SetTargetCreat(TargeTBaseObject);
              end;
              TargeTBaseObject.SetLastHiter(BaseObject);
              nPower := TargeTBaseObject.GetMagStruckDamage(BaseObject, nPower);
              BaseObject.SendDelayMsg(BaseObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '', 600);
              //BaseObject.SendMsg(BaseObject, RM_DELAYMAGIC, nPower, MakeLong(nTargetX, nTargetY), 2, Integer(TargeTBaseObject), '');
              if not TargeTBaseObject.m_boUnParalysis then
                TargeTBaseObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE {�ж����� - ���}, nPower div g_Config.nMabMabeHitMabeTimeRate {20} + Random(nLevel), Integer(BaseObject), nLevel, '', 650);
              //TargeTBaseObject.SendDelayMsg(BaseObject, RM_POISON, POISON_STONE {�ж����� - ���}, nPower div g_Config.nMabMabeHitMabeTimeRate {20} + Random(nLevel), Integer(BaseObject), nLevel, '', 10);
              Result := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;
//�ٻ�����
function TMagicManager.MagMakeSinSuSlave(PlayObject: TBaseObject; {�޸� TBaseObject}
  UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  Slave: TBaseObject;//20080218
  nCode: Byte;//20080604
begin
  Result := False;
  nCode:= 0;
try
  if not PlayObject.sub_4DD704 then begin
    nCode:= 1;
    sMonName := g_Config.sDogz;
    nMakeLevel := UserMagic.btLevel;
    nExpLevel := UserMagic.btLevel;
    nCount := g_Config.nDogzCount;
    dwRoyaltySec := 1728000{20 * 24 * 60 * 60};
    nCode:= 2;
    for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
      if g_Config.DogzArray[I].nHumLevel = 0 then Break;
      if PlayObject.m_Abil.Level >= g_Config.DogzArray[I].nHumLevel then begin
        sMonName := g_Config.DogzArray[I].sMonName;
        nExpLevel := g_Config.DogzArray[I].nLevel;
        nCount := g_Config.DogzArray[I].nCount;
      end;
    end;
    nCode:= 3;
    if PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, nCount, dwRoyaltySec) <> nil then begin
      Result := True;
    end else begin //���г���������,�ɵ�������� 20080218
      nCode:= 4;
      if (PlayObject.m_SlaveList.Count > 0) and g_Config.boSlaveMoveMaster then begin//20080713
        for I := 0 to PlayObject.m_SlaveList.Count -1 do begin
          Slave := TBaseObject(PlayObject.m_SlaveList.Items[I]);
          nCode:= 5;
          if (Slave <> nil) and (not Slave.m_boDeath) then begin//20080604
            if (CompareText(Slave.m_sCharName, sMonName) = 0) or (CompareText(Slave.m_sCharName, sMonName+'1') = 0) then begin
              nCode:= 6;
              if Slave.m_TargetCret <> nil then Slave.m_TargetCret:= nil;//20080527 �����ٻ�����ߺ�,����ȥ��ԭ����Ŀ��
              nCode:= 7;
              Slave.SpaceMove( PlayObject.m_sMapName,PlayObject.m_nCurrX, PlayObject.m_nCurrY, 0);
              //Break;//20080504 �������ʱ,һ���
            end;
          end;
        end;//for
      end;
    end;
  end;
  except
    MainOutMessage('{�쳣} TMagicManager.MagMakeSinSuSlave  Code:'+inttostr(nCode));
  end;
end;
//�ٻ�����
function TMagicManager.MagMakeSlave(PlayObject: TBaseObject; {�޸� TBaseObject} UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  Slave: TBaseObject;//20080323
  nCode: Byte;//20080604
begin
  Result := False;
  nCode:= 0;
try
  if not PlayObject.sub_4DD704 then begin
    nCode:= 1;
    sMonName := g_Config.sBoneFamm;
    nMakeLevel := UserMagic.btLevel;
    nExpLevel := UserMagic.btLevel;
    nCount := g_Config.nBoneFammCount;
    dwRoyaltySec := 1728000{20 * 24 * 60 * 60};
    nCode:= 2;
    for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
      nCode:= 3;
      if g_Config.BoneFammArray[I].nHumLevel = 0 then Break;
      nCode:= 4;
      if PlayObject.m_Abil.Level >= g_Config.BoneFammArray[I].nHumLevel then begin
        nCode:= 5;
        sMonName := g_Config.BoneFammArray[I].sMonName;
        nExpLevel := g_Config.BoneFammArray[I].nLevel;
        nCount := g_Config.BoneFammArray[I].nCount;
        nCode:= 6;
      end;
    end;
    nCode:= 7;
    if PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, nCount, dwRoyaltySec) <> nil then begin
      nCode:= 8;
      Result := True;
    end else begin //���г����ı�������,�ɵ�������� //20080323
      nCode:= 9;
      if (PlayObject.m_SlaveList.Count > 0) and g_Config.boSlaveMoveMaster then begin//20080713
        for I := 0 to PlayObject.m_SlaveList.Count -1 do begin
          nCode:= 10;
          Slave := TBaseObject(PlayObject.m_SlaveList.Items[I]);
          nCode:= 11;
          if (Slave <> nil) and (not Slave.m_boDeath) then begin//20080604
            if CompareText(Slave.m_sCharName, sMonName) = 0 then begin
              nCode:= 12;
              if Slave.m_TargetCret <> nil then Slave.m_TargetCret:= nil;//20080527 �����ٻ�����ߺ�,����ȥ��ԭ����Ŀ��
              nCode:= 13;
              Slave.SpaceMove( PlayObject.m_sMapName,PlayObject.m_nCurrX, PlayObject.m_nCurrY, 0);
              //Break;//20080504 �������ʱ,һ���
            end;
          end;
        end;//for
      end;
    end;
  end;
  except
    MainOutMessage('{�쳣} TMagicManager.MagMakeSlave  Code:'+inttostr(nCode));
  end;
end;
//�ٻ�����
function TMagicManager.MagMakeFairy(PlayObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
var
  I: Integer;
  sMonName: string;
  nMakeLevel, nExpLevel: Integer;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  Slave: TBaseObject;//20080330
  nCode: Byte;//20080604
begin
  Result := False;
  nCode:= 0;
try
  if not PlayObject.sub_4DD704 then begin
    nCode:= 1;
    sMonName := g_Config.sFairy;
    nMakeLevel := UserMagic.btLevel;
    nExpLevel := UserMagic.btLevel;
    nCount := g_Config.nFairyCount;
    dwRoyaltySec := 1728000{20 * 24 * 60 * 60};
    nCode:= 2;
    for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do begin
      nCode:= 3;
      if g_Config.FairyArray[I].nHumLevel = 0 then Break;
      nCode:= 4;
      if PlayObject.m_Abil.Level >= g_Config.FairyArray[I].nHumLevel then begin
        nCode:= 5;
        sMonName := g_Config.FairyArray[I].sMonName;
        nExpLevel := g_Config.FairyArray[I].nLevel;
        nCount := g_Config.FairyArray[I].nCount;
        nCode:= 6;
      end;
    end;
    nCode:= 7;
    if PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, nCount, dwRoyaltySec) <> nil then begin
      Result := True;
    end else begin //���г���������,�ɵ�������� 20080330
      nCode:= 8;
      if (PlayObject.m_SlaveList.Count > 0) and g_Config.boSlaveMoveMaster then begin//20080713
        for I := 0 to PlayObject.m_SlaveList.Count -1 do begin
          nCode:= 9;
          Slave := TBaseObject(PlayObject.m_SlaveList.Items[I]);
          nCode:= 10;
          if (Slave <> nil) and (not Slave.m_boDeath) then begin//20080604
            nCode:= 11;
            if CompareText(Slave.m_sCharName, sMonName) = 0 then begin
              nCode:= 12;
              if Slave.m_TargetCret <> nil then Slave.m_TargetCret:= nil;//20080527 �����ٻ�����ߺ�,����ȥ��ԭ����Ŀ��
              nCode:= 13;
              Slave.SpaceMove( PlayObject.m_sMapName,PlayObject.m_nCurrX, PlayObject.m_nCurrY, 0);
              //Break;//20080504 �������ʱ,һ���
            end;
          end;
        end;//for
      end;
    end;
  end;
  except
    MainOutMessage('{�쳣} TMagicManager.MagMakeFairy  Code:'+inttostr(nCode));
  end;
end;
//�ٻ�����
function TMagicManager.MagMakeSlave_(PlayObject: TBaseObject; {�޸� TBaseObject} UserMagic: pTUserMagic; sMonName: string; nCount, nHumLevel, nMonLevel: Integer): Boolean;
var
  nMakeLevel, nExpLevel: Integer;
  dwRoyaltySec: LongWord;
begin
  Result := False;
  nMakeLevel:= 0;//20080521
  nExpLevel:= 0;//20080521
  dwRoyaltySec:= 0;//20080522
  if not PlayObject.sub_4DD704 then begin
    nMakeLevel := UserMagic.btLevel;
    nExpLevel := UserMagic.btLevel;
    nCount := g_Config.nBoneFammCount;
    dwRoyaltySec := 864000{10 * 24 * 60 * 60};
    if PlayObject.m_Abil.Level >= nHumLevel then begin
      nExpLevel := nMonLevel;
    end;
  end;
  if PlayObject.MakeSlave(sMonName, nMakeLevel, nExpLevel, nCount, dwRoyaltySec) <> nil then
    Result := True;
end;
//������
function TMagicManager.MagMakeSelf(BaseObject, TargeTBaseObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
var
  sMonName: string;
  nCount: Integer;
  dwRoyaltySec: LongWord;
  boboAllowReCallMob: Boolean;
  BaseObject01: TBaseObject;
begin
  Result := False;
  if (GetTickCount - BaseObject.m_dwLatest46Tick) > (g_Config.nCopyHumanTick * 1000) then begin //�����ٻ���� 20080204
    BaseObject.m_dwLatest46Tick:=GetTickCount;
    boboAllowReCallMob := False;
    BaseObject01 := nil;
    if not BaseObject.sub_4DD704 then begin
      if g_Config.boAddMasterName then begin
        sMonName := BaseObject.m_sCharName + g_Config.sCopyHumName;
      end else begin
        sMonName := g_Config.sCopyHumName;
      end;
      nCount := g_Config.nAllowCopyHumanCount;
      if BaseObject.m_btRaceServer <> RC_HEROOBJECT then begin//Ӣ�۷������ܵȼ�����ʹ��ʱ�� 20081217
        //dwRoyaltySec := 10 * 24 * 60 * 60;//20080404
        dwRoyaltySec := g_Config.nMakeSelfTick ;//20080404 ����ʹ��ʱ����Ե���
      end else begin
        dwRoyaltySec := g_Config.nMakeSelfTick + UserMagic.btLevel * g_Config.nHeroMakeSelfTick;
      end;
      if g_Config.boAllowReCallMobOtherHum then begin                          {�ٻ�����Ľ�ɫ��Ӣ�� 20080204}
        if (TargeTBaseObject <> nil) and (not TargeTBaseObject.m_boDeath) and (BaseObject.m_btRaceServer <> RC_HEROOBJECT) then begin
          if TargeTBaseObject.m_btRaceServer = RC_PLAYOBJECT then begin 
            BaseObject01 := TargeTBaseObject;
            boboAllowReCallMob := True;
          end;
        end else begin
          BaseObject01 := BaseObject;
          boboAllowReCallMob := True;
        end;
        if g_Config.boNeedLevelHighTarget and (TargeTBaseObject <> nil) and (BaseObject.m_Abil.Level < TargeTBaseObject.m_Abil.Level) then boboAllowReCallMob := False;
      end else begin
        BaseObject01 := BaseObject;
        boboAllowReCallMob := True;
      end;
      if boboAllowReCallMob then begin
        if TPlayObject(BaseObject).MakeSelf(TPlayObject(BaseObject01), sMonName, nCount, dwRoyaltySec) <> nil then
          Result := True;
      end;
    end;
  end;
end;
//ʨ�Ӻ� 
function TMagicManager.MagGroupMb(PlayObject: TBaseObject; {�޸� TBaseObject}
  UserMagic: pTUserMagic; nTargetX, nTargetY: Integer;
  TargeTBaseObject: TBaseObject): Boolean;
var
  I: Integer;
  BaseObjectList: TList;
  BaseObject: TBaseObject;
  nTime: Integer;
begin
//if TargeTBaseObject.m_wStatusTimeArr[POISON_STONE] <> 0 then begin
  Result := False;
  BaseObjectList := TList.Create;
  //nTime := 5 * UserMagic.btLevel + 1;
  nTime := 1 * UserMagic.btLevel + 3;//20080330 0-3�� 1-4�� 2-5�� 3-6��
  PlayObject.GetMapBaseObjects(PlayObject.m_PEnvir, PlayObject.m_nCurrX, PlayObject.m_nCurrY, UserMagic.btLevel + 2, BaseObjectList);
  if BaseObjectList.Count > 0 then begin//20080629
    for I := 0 to BaseObjectList.Count - 1 do begin
      BaseObject := TBaseObject(BaseObjectList.Items[I]);
      if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (PlayObject = BaseObject) then Continue;
      if ((BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = RC_HEROOBJECT) or (BaseObject.m_btRaceServer = RC_PLAYMOSTER)) and (not g_Config.boGroupMbAttackPlayObject) then Continue;//Ӣ��,����,������Ч 20080410
      if (BaseObject.m_Master <> nil) and (BaseObject.m_Master = PlayObject) and  (not g_Config.boGroupMbAttackPlayObject) then Continue;//20080410 ��������������
      if (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) and (BaseObject.m_Master <> nil) and (not g_Config.boGroupMbAttackSlave) then Continue;
      if PlayObject.IsProperTarget(BaseObject) then begin
        if not BaseObject.m_boUnParalysis and (Random(BaseObject.m_btAntiPoison) = 0) then begin
          if (BaseObject.m_Abil.Level < PlayObject.m_Abil.Level) or (Random(PlayObject.m_Abil.Level - BaseObject.m_Abil.Level) = 0) then begin
            BaseObject.MakePosion(POISON_STONE, nTime, 0);
            //BaseObject.m_boFastParalysis := True;//������ԣ��ܹ��������������ʧ 20080329
          end;
        end;
      end;
      if (PlayObject.m_btRaceServer = RC_PLAYMOSTER) or (PlayObject.m_btRaceServer = RC_HEROOBJECT) then Result := True
      else if BaseObject.m_btRaceServer >= RC_ANIMAL then Result := True;
    end;
  end;
  BaseObjectList.Free;
end;

//�������� 20080625
function TMagicManager.MagMakeHPUp(PlayObject: TBaseObject; UserMagic: pTUserMagic): Boolean;
  function GetSpellPoint(UserMagic: pTUserMagic): Integer;
  begin
    Result := UserMagic.MagicInfo.wSpell + UserMagic.MagicInfo.btDefSpell;
  end;
var
  nSpellPoint, n14: Integer;
begin
  Result := False;
  nSpellPoint := GetSpellPoint(UserMagic);
  if nSpellPoint > 0 then begin                                                                                                                                         if UserMagic.btLevel > 0 then begin
      if (PlayObject.m_Abil.WineDrinkValue >= Round(PlayObject.m_Abil.MaxAlcohol * g_Config.nMinDrinkValue68 / 100)) then begin//20090108 div��/
        if (GetTickCount - PlayObject.m_dwStatusArrTimeOutTick[4] > g_Config.nHPUpTick * 1000) and (PlayObject.m_wStatusArrValue[4] = 0) then begin //ʱ����
          if PlayObject.m_WAbil.MP < nSpellPoint then begin
            PlayObject.SysMsg('MPֵ����!!!', c_Red, t_Hint);
            Exit;
          end;
          PlayObject.DamageSpell(nSpellPoint);//��MPֵ 20080727
          PlayObject.HealthSpellChanged();//20080727
          n14:= {UserMagic.btLevel}300 + g_Config.nHPUpUseTime;
          PlayObject.m_dwStatusArrTimeOutTick[4] := GetTickCount + n14 * 1000;//ʹ��ʱ��
          PlayObject.m_wStatusArrValue[4] := UserMagic.btLevel;//����ֵ
          PlayObject.SysMsg('����ֵ˲������, ����' + IntToStr(n14) + '��', c_Green, t_Hint);
          PlayObject.SysMsg('��ľ��������Ѿ��ڼ���״̬', c_Green, t_Hint);
          PlayObject.RecalcAbilitys();
          PlayObject.CompareSuitItem(False);//��װ������װ���Ա� 20080808
          PlayObject.SendMsg(PlayObject, RM_ABILITY, 0, 0, 0, 0, '');
          Result := True;
        end else PlayObject.SysMsg(g_sOpenShieldOKMsg, c_Red, t_Hint);
      end else PlayObject.SysMsg('��ƶȲ�����'+inttostr(g_Config.nMinDrinkValue68)+'%ʱ,����ʹ�ô˼��� ', c_Red, t_Hint);
    end else PlayObject.SysMsg('�ȼ����1������,����ʹ�ô˼���', c_Red, t_Hint);
  end;
end;

//�ڹ����ܵ�����ֵ,
function TMagicManager.GetNGPow(BaseObject: TBaseObject; UserMagic: pTUserMagic; Power: Integer): Integer;
var nNHPoint:Integer;
begin
  Result := 0;
  if (UserMagic <> nil) and (BaseObject <> nil) then begin
    if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      nNHPoint := TPlayObject(BaseObject).GetSpellPoint(UserMagic);
      if TPlayObject(BaseObject).m_Skill69NH >= nNHPoint then begin
        TPlayObject(BaseObject).m_Skill69NH := _MAX(0, TPlayObject(BaseObject).m_Skill69NH - nNHPoint);
        TPlayObject(BaseObject).SendREFMsg( RM_MAGIC69SKILLNH, 0, TPlayObject(BaseObject).m_Skill69NH, TPlayObject(BaseObject).m_Skill69MaxNH, 0, '');
        //Result := GetPower(MPow(UserMagic),UserMagic);
        Result := Round(Power * ((UserMagic.btLevel + 1) * (g_Config.nNGSkillRate / 100)));//���㹥���� 20081222
        TPlayObject(BaseObject).NGMAGIC_LVEXP(UserMagic);//�ڹ��������� 20081003
      end;
    end else
    if (BaseObject.m_btRaceServer = RC_HEROOBJECT) then begin
      nNHPoint := THEROOBJECT(BaseObject).GetSpellPoint(UserMagic);
      if THEROOBJECT(BaseObject).m_Skill69NH >= nNHPoint then begin
        THEROOBJECT(BaseObject).m_Skill69NH := _MAX(0, THEROOBJECT(BaseObject).m_Skill69NH - nNHPoint);
        THEROOBJECT(BaseObject).SendREFMsg( RM_MAGIC69SKILLNH, 0, THEROOBJECT(BaseObject).m_Skill69NH, THEROOBJECT(BaseObject).m_Skill69MaxNH, 0, '');
        //Result := GetPower(MPow(UserMagic),UserMagic);
        Result := Round(Power * ((UserMagic.btLevel + 1) * (g_Config.nNGSkillRate / 100)));//���㹥���� 20081222
        THEROOBJECT(BaseObject).NGMAGIC_LVEXP(UserMagic);//�ڹ��������� 20081003
      end;
    end;
  end;
end;

end.


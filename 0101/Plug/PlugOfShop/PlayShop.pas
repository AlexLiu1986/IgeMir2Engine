unit PlayShop;

interface
uses
  Windows, SysUtils, Classes, EngineAPI, EngineType, IniFiles;
const
  //�������
  BUFFERSIZE = 10000;
  RM_OPENSHOPSpecially = 30000;
  RM_OPENSHOP = 30001;
  RM_BUYSHOPITEM_SUCCESS = 30002;
  RM_BUYSHOPITEM_FAIL = 30003;
  RM_BUYSHOPITEMGIVE_FAIL = 30004;
  RM_BUYSHOPITEMGIVE_SUCCESS = 30005;
  CM_OPENSHOP = 9000; //������
  SM_SENGSHOPITEMS = 9001; // SERIES 7 ÿҳ������    wParam ��ҳ��
  CM_BUYSHOPITEM = 9002;
  SM_BUYSHOPITEM_SUCCESS = 9003;
  SM_BUYSHOPITEM_FAIL = 9004;
  SM_SENGSHOPSPECIALLYITEMS = 9005;
  CM_BUYSHOPITEMGIVE = 9006; //����
  SM_BUYSHOPITEMGIVE_FAIL = 9007;
  SM_BUYSHOPITEMGIVE_SUCCESS = 9008;
  CM_EXCHANGEGAMEGIRD = 20042;//���̶һ����  20080302
  SM_EXCHANGEGAMEGIRD_FAIL = 20043;
  SM_EXCHANGEGAMEGIRD_SUCCESS = 20044;
  RM_EXCHANGEGAMEGIRD_FAIL = 20045;
  RM_EXCHANGEGAMEGIRD_SUCCESS = 20046;
procedure LoadShopItemList();
procedure UnLoadShopItemList();
procedure InitPlayShop();
procedure UnInitPlayShop();

procedure ClientGetShopItemList(PlayObject: TPlayObject; nPage,nType: Integer; MsgObject: TObject);
function PlayObjectOperateMessage(BaseObject: TObject;
  wIdent: Word;
  wParam: Word;
  nParam1: Integer;
  nParam2: Integer;
  nParam3: Integer;
  MsgObject: TObject;
  dwDeliveryTime: LongWord;
  pszMsg: PChar;
  var boReturn: Boolean): Boolean; stdcall;

var
  OldPlayOperateMessage: _TOBJECTOPERATEMESSAGE;
implementation
uses PlugShare, HUtil32;
procedure InitPlayShop();
begin
Try
  OldPlayOperateMessage := TPlayObject_GetHookPlayOperateMessage();
  TPlayObject_SetHookPlayOperateMessage(PlugHandle, PlayObjectOperateMessage);
  except
    MainOutMessage('[�쳣] PlugOfShop.InitPlayShop');
  end;
end;

procedure UnInitPlayShop();
begin
  Try
  TPlayObject_SetHookPlayOperateMessage(PlugHandle, OldPlayOperateMessage);
  UnLoadShopItemList();
  except
    MainOutMessage('[�쳣] PlugOfShop.UnInitPlayShop');
  end;
end;

function MakeDefaultMsg(wIdent: Word; nRecog: Integer; wParam, wTag, wSeries: Word): _TDEFAULTMESSAGE;
begin
  Try
  Result.nRecog := nRecog;
  Result.wIdent := wIdent;
  Result.wParam := wParam;
  Result.wTag := wTag;
  Result.wSeries := wSeries;
  except
    MainOutMessage('[�쳣] PlugOfShop.MakeDefaultMsg');
  end;
end;

procedure ClientGetShopItemList(PlayObject: TPlayObject; nPage,nType: Integer; MsgObject: TObject);
  function GetPageCount(nItemListCount: Integer): Integer;
  begin
    Result := 0;
    if nItemListCount > 0 then begin
      Result := nItemListCount div 10;
      if (nItemListCount mod 10) > 0 then Inc(Result);
    end;
  end;
var
  I: Integer;
  n01,n02,n03: Integer;
  sSendStr,sSendStr1: string;
  pShopInfo: pTShopInfo;
  ShopInfo: TShopInfo;
  nPageCount: Integer;
  pszDest: array[0..BUFFERSIZE - 1] of Char;
  TempList: Classes.TList;
begin
  Try
  if g_ShopItemList = nil then Exit;
  n01 := 0;
  n02 := 0;
  n03 := 0;
  sSendStr := '';
  sSendStr1 := '';

  if g_ShopItemList.Count > 0 then begin//20080629
    for I := 0 to g_ShopItemList.Count - 1 do begin
        pShopInfo := pTShopInfo(g_ShopItemList.Items[I]);
        ShopInfo := pShopInfo^;
        if strtoint(ShopInfo.Idx) = nType then begin
        Inc(n03);
        end;
    end;
  end;
  nPageCount := GetPageCount(n03);
  if nPage > 0 then begin
    {if g_ShopItemList.Count >= nPage * 10 then begin
      Log('g_ShopItemList.Count >= nPage * 10');
      for I := nPage * 10 to g_ShopItemList.Count - 1 do begin
        pShopInfo := pTShopInfo(g_ShopItemList.Items[I]);
        ShopInfo := pShopInfo^;
        if StrToInt(ShopInfo.Idx) = nType then begin
        Inc(n01);
        EDcode_EncodeBuffer(@ShopInfo, SizeOf(TShopInfo), pszDest);
        sSendStr := sSendStr + StrPas(@pszDest)+'/';
        if n01 >= 10 then break;   //����2007.11.14
        end;
      end;
    end; }
    if g_ShopItemList.Count >= nPage * 10 then begin
      TempList := Classes.TList.Create;
      for I := 0 to g_ShopItemList.Count - 1 do begin
        pShopInfo := pTShopInfo(g_ShopItemList.Items[I]);
        ShopInfo := pShopInfo^;
        if StrToInt(ShopInfo.Idx) = nType then
          TempList.Add(pShopInfo);
      end;
      for I:= nPage * 10 to TempList.Count -1 do begin
        pShopInfo := pTShopInfo(TempList.Items[I]);
        ShopInfo := pShopInfo^;
        Inc(n01);
        EDcode_EncodeBuffer(@ShopInfo, SizeOf(TShopInfo), pszDest);
        sSendStr := sSendStr + StrPas(@pszDest)+'/';
        if n01 >= 10 then break;   //����2007.11.14
      end;
      TempList.Free;
    end;
  end else begin
    if g_ShopItemList.Count > 0 then begin//20080629
      for I := 0 to g_ShopItemList.Count - 1 do begin
        pShopInfo := pTShopInfo(g_ShopItemList.Items[I]);

        ShopInfo := pShopInfo^;

        if strtoint(ShopInfo.Idx) = nType then begin
        Inc(n01);
        EDcode_EncodeBuffer(@ShopInfo, SizeOf(TShopInfo), pszDest);
        sSendStr := sSendStr + StrPas(@pszDest)+'/';
        if n01 >= 10 then break;   //����2007.11.14
        end;
      end;
    end;
  end;
  if sSendStr <> '' then begin
    TBaseObject_SendMsg(PlayObject, MsgObject, RM_OPENSHOP, 0, nPageCount, nPage + 1, n01, PChar(sSendStr));
  end;
  // ��������
  if g_ShopItemList.Count > 0 then begin//20080629
    for I := 0 to g_ShopItemList.Count - 1 do begin
        pShopInfo := pTShopInfo(g_ShopItemList.Items[I]);
        ShopInfo := pShopInfo^;
        if strtoint(ShopInfo.Idx) = 5 then begin
        Inc(n02);
        EDcode_EncodeBuffer(@ShopInfo, SizeOf(TShopInfo), pszDest);
        sSendStr1 := sSendStr1 + StrPas(@pszDest)+'/';
        if n02 >= 5 then break;   //����2007.11.14
        end;
    end;
  end;
  if sSendStr1 <> '' then begin
    TBaseObject_SendMsg(PlayObject, MsgObject, RM_OPENSHOPSPECIALLY, 0, nPageCount, nPage + 1, n02, PChar(sSendStr1));
  end;
  except
    MainOutMessage('[�쳣] PlugOfShop.ClientGetShopItemList');
  end;
end;

function GetStdItem(sItemName: string): _LPTSTDITEM; //004AC348
var
  I: Integer;
  ShopInfo: pTShopInfo;
begin
  Result := nil;
  Try
  if sItemName = '' then Exit;
  if g_ShopItemList.Count > 0 then begin//20080629
    for I := 0 to g_ShopItemList.Count - 1 do begin
      ShopInfo := g_ShopItemList.Items[I];
      if CompareText(ShopInfo.StdItem.szName, sItemName) = 0 then begin
        Result := @ShopInfo.StdItem;
        break;
      end;
    end;
  end;
  except
    MainOutMessage('[�쳣] PlugOfShop.GetStdItem');
  end;
end;


procedure ClientBuyShopItemGive(PlayObject: TPlayObject; MsgObject: TObject; pszMsg: PChar);
var
  sItemName,sLineText,UseName,MyName: string;
  GiveUseName,GiveItemName,GiveMyName: string;
  StdItem: _LPTSTDITEM;
  nGameGold: Integer;
  UserItem: _LPTUSERITEM;
  nPrice: Integer;
  pszName: array[0..BUFFERSIZE - 1] of Char;
  pszItemName: array[0..BUFFERSIZE - 1] of Char;
  pszMyName: array[0..BUFFERSIZE - 1] of Char;
  PlayObjectGive:TPlayObject;
begin
Try
  sLineText := GetValidStr3(pszMsg, sItemName, ['/']);
  sLineText := GetValidStr3(sLineText, UseName, ['/']);
  sLineText := GetValidStr3(sLineText, MyName, ['/']);

  EDcode_DeCodeString(pchar(UseName),pszName);
  EDcode_DeCodeString(pchar(sItemName),pszItemName);
  EDcode_DeCodeString(pchar(MyName),pszMyName);

  GiveUseName:=StrPas(@pszName);
  GiveItemName:=StrPas(@pszItemName);
  GiveMyName:=StrPas(@pszMyName);
  StdItem := GetStdItem(GiveItemName);
  if StdItem <> nil then begin
    PlayObjectGive:=TUserEngine_GetPlayObject(pchar(GiveUseName),FALSE);
    nGameGold := TPlayObject_nGameGold(PlayObject)^;
    nPrice := StdItem.nPrice div 100;
    if PlayObjectGive = nil then begin  //��ɫû����
          TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_BUYSHOPITEMGIVE_FAIL, 0, 4, 0, 0, PChar(GiveUseName)); //���͵���û����
          EXIT;
    end;
      if (nGameGold >= nPrice) and (nPrice >= 0) then begin
         if TPlayObject_IsEnoughBag(PlayObjectGive) then begin   //���ﱳ��
             New(UserItem);
             TUserEngine_CopyToUserItemFromName(PChar(GiveItemName), UserItem);
             if TBaseObject_AddItemToBag(PlayObjectGive, UserItem) then begin
               TPlayObject_DecGameGold(PlayObject, nPrice);
               TPlayObject_SendAddItem(PlayObjectGive, UserItem);
               TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_BUYSHOPITEMGIVE_SUCCESS, 0, 1, 0, 0, PChar(GiveItemName + '/' + GiveUseName + '/' + GiveMyName + '/'));
               TBaseObject_SendMsg(PlayObjectGive, TPlayObject(MsgObject), RM_BUYSHOPITEMGIVE_SUCCESS, 0, 2, 0, 0, PChar(GiveItemName + '/' + GiveUseName + '/' + GiveMyName + '/'));
             End;
             DisPose(UserItem);
         End else begin //������
           TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_BUYSHOPITEMGIVE_FAIL, 0, 3, 0, 0, PChar(GiveItemName));
         end;
      end else begin //Ԫ������
       TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_BUYSHOPITEMGIVE_FAIL, 0, 1, 0, 0, PChar(GiveItemName));
      end;
    end else begin //û���ҵ������Ʒ
      TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_BUYSHOPITEMGIVE_FAIL, 0, 2, 0, 0, PChar(GiveItemName));
    end;
  except
    MainOutMessage('[�쳣] PlugOfShop.ClientBuyShopItemGive');
  end;
end;

//�һ���� 20080302
procedure ClientExchangeGameGird(PlayObject: TPlayObject; MsgObject: TObject; nParam2: Integer);
var
  nOldGameGold: Integer;
begin
  Try
   if not g_boGameGird then begin
      TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_EXCHANGEGAMEGIRD_FAIL, 0, 1, 0, 0, '');
      Exit;
   end;
   nOldGameGold := TPlayObject_nGameGold(PlayObject)^;     //Ԫ��
   if nOldGameGold <= 0 then begin
      TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_EXCHANGEGAMEGIRD_FAIL, 0, 0, 0, 0, '');
      Exit;
   end;
   if nOldGameGold > nParam2 * g_nGameGold then begin    //��ǰԪ��>�һ�����*ÿ���������
        TPlayObject_DecGameGold(PlayObject, nParam2 * g_nGameGold);  //����ɫ��Ԫ��
        TPlayObject_IncGameGird(PlayObject, nParam2);
        TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_EXCHANGEGAMEGIRD_SUCCESS, 0, nParam2, 0, 0, '');
   end else   //Ԫ������
     TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_EXCHANGEGAMEGIRD_FAIL, 0, 0, 0, 0, '');
  except
    MainOutMessage('[�쳣] PlugOfShop.ClientExchangeGameGird');
  end;
end;


procedure ClientBuyShopItem(PlayObject: TPlayObject; MsgObject: TObject; pszMsg: PChar);
var
  sItemName: string;
  StdItem: _LPTSTDITEM;
  nGameGold: Integer;
  UserItem: _LPTUSERITEM;
  nPrice: Integer;
//  pszDest: array[0..BUFFERSIZE - 1] of Char;
begin
  Try
  {EDcode_DeCodeString(pszMsg, pszDest);
  sItemName := StrPas(@pszDest); }
  sItemName := pszMsg;
  StdItem := GetStdItem(sItemName);
  if StdItem <> nil then begin
    nGameGold := TPlayObject_nGameGold(PlayObject)^;
    nPrice := StdItem.nPrice div 100;
    if (nGameGold >= nPrice) and (nPrice >= 0) then begin
      if TPlayObject_IsEnoughBag(PlayObject) then begin
        New(UserItem);
        TUserEngine_CopyToUserItemFromName(PChar(sItemName), UserItem);
        if TBaseObject_AddItemToBag(PlayObject, UserItem) then begin
          TPlayObject_DecGameGold(PlayObject, nPrice);
          TPlayObject_SendAddItem(PlayObject, UserItem);
          TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_BUYSHOPITEM_SUCCESS, 0, 0, 0, 0, PChar(sItemName));
        end;
        DisPose(UserItem);
      end else begin
        TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_BUYSHOPITEM_FAIL, 0, 2, 0, 0, PChar(sItemName)); //������
      end;
    end else begin
      TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_BUYSHOPITEM_FAIL, 0, 1, 0, 0, PChar(sItemName));
    end;
  end else begin
    TBaseObject_SendMsg(PlayObject, TPlayObject(MsgObject), RM_BUYSHOPITEM_FAIL, 0, 3, 0, 0, PChar(sItemName));
  end;

  except
    MainOutMessage('[�쳣] PlugOfShop.ClientBuyShopItem');
  end;
end;


function PlayObjectOperateMessage(BaseObject: TObject;
  wIdent: Word;
  wParam: Word;
  nParam1: Integer;
  nParam2: Integer;
  nParam3: Integer;
  MsgObject: TObject;
  dwDeliveryTime: LongWord;
  pszMsg: PChar;
  var boReturn: Boolean): Boolean; stdcall;
var
  sLineText,sItemName,UseName,MyName: string;
  m_DefMsg: _TDEFAULTMESSAGE;
  GameGoldName: _LPTSHORTSTRING;
  szGameGoldName: array[0..256] of Char;
  sGameGoldName: string;
  text:Pchar;
  dwClientTick: LongWord;
  pszDest: array[0..BUFFERSIZE - 1] of Char;
begin
  Result := TRUE;
  Try
  case wIdent of
    CM_OPENSHOP: begin//OK
        //dwClientTick := TPlayObject_GetPlayObjectTick(BaseObject, 0)^;//20080521
        //if GetTickCount - dwClientTick >= 1000 then begin
          TPlayObject_SetPlayObjectTick(BaseObject, 0);
          ClientGetShopItemList(TPlayObject(BaseObject), nParam2,nParam3, MsgObject);
        //end;
      end;
    CM_BUYSHOPITEM: begin //OK
        dwClientTick := TPlayObject_GetPlayObjectTick(BaseObject, 1)^;
        if GetTickCount - dwClientTick >= 500 then begin
          TPlayObject_SetPlayObjectTick(BaseObject, 1);
          ClientBuyShopItem(BaseObject, MsgObject, pszMsg);
        end else begin
          Text := Pchar('[ʧ��]�����ٶȹ���!');
          EDcode_EncodeString(text,pszDest);
          m_DefMsg := MakeDefaultMsg(SM_EXCHANGEGAMEGIRD_FAIL, 0, 0, 0, 0);
          TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszDest);
        end;
      end;
    //����
    CM_BUYSHOPITEMGIVE: begin//ok
      dwClientTick := TPlayObject_GetPlayObjectTick(BaseObject, 1)^;
        if GetTickCount - dwClientTick >= 500 then begin
          TPlayObject_SetPlayObjectTick(BaseObject, 1);
          ClientBuyShopItemGive(BaseObject, MsgObject, pszMsg);
        end else begin
          Text := Pchar('[ʧ��]�����ٶȹ���!');
          EDcode_EncodeString(text,pszDest);
          m_DefMsg := MakeDefaultMsg(SM_EXCHANGEGAMEGIRD_FAIL, 0, 0, 0, 0);
          TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszDest);
        end;
    end;
    //�һ����
    CM_EXCHANGEGAMEGIRD: begin//ok
      dwClientTick := TPlayObject_GetPlayObjectTick(BaseObject, 1)^;
        if GetTickCount - dwClientTick >= 500 then begin
          TPlayObject_SetPlayObjectTick(BaseObject, 1);
          ClientExchangeGameGird(BaseObject, MsgObject, nParam2);
        end else begin
          Text := Pchar('[ʧ��]�һ�����!');
          EDcode_EncodeString(text,pszDest);
          m_DefMsg := MakeDefaultMsg(SM_EXCHANGEGAMEGIRD_FAIL, 0, 0, 0, 0);
          TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszDest);
        end;
    end;
    RM_BUYSHOPITEM_SUCCESS: begin//ok
        TBaseObject_GameGoldChanged(BaseObject);
        //text:=Pchar('[�ɹ�] '+ pszMsg +' ����ɹ���');
        //EDcode_EncodeString(text,pszDest);
        //m_DefMsg := MakeDefaultMsg(SM_BUYSHOPITEM_SUCCESS, 0, 0, 0, 0);
        //TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszDest);
        //TBaseObject_SendBroadCastMsgExt(Pchar('[�ɹ�] '+ pszMsg +' ����ɹ���'),mt_Hint);
        //TBaseObject_SysMsg(BaseObject, Pchar('[�ɹ�] '+ pszMsg +' ����ɹ���'), mc_Blue, mt_Hint);
        TBaseObject_SysMsg(BaseObject, Pchar('[�ɹ�] '+ pszMsg +' ����ɹ���'), mc_Blue, mt_Hint);
      end;
    RM_BUYSHOPITEMGIVE_SUCCESS: begin//ok
        TBaseObject_GameGoldChanged(BaseObject);
        sLineText := GetValidStr3(pszMsg, sItemName, ['/']);
        sLineText := GetValidStr3(sLineText, UseName, ['/']);
        sLineText := GetValidStr3(sLineText, MyName, ['/']);
        case nParam1 of
        1:text:=Pchar('[�ɹ�]���͸� ' + UseName + ' ��Ʒ ' + sItemName + ' �ɹ���');
        //2:text:=Pchar('[��ϲ]������� ' + MyName + ' �������� ' + sItemName + ' �������գ�');
        2:begin
          TBaseObject_SysMsg(BaseObject, Pchar('[��ϲ]������� ' + MyName + ' ��������������� ' + sItemName + ' �������գ�'), mc_Blue, mt_Hint);
          Exit;
        end;
        end;
        EDcode_EncodeString(text,pszDest);
        m_DefMsg := MakeDefaultMsg(SM_BUYSHOPITEMGIVE_SUCCESS, 0, 0, 0, 0);
        TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszDest);
    end;
    RM_BUYSHOPITEM_FAIL: begin//ok
      case nParam1 of
        1: begin
            GameGoldName := GetGameGoldName;
            ShortStringToPChar(GameGoldName, szGameGoldName);
            sGameGoldName := szGameGoldName;
            text:=Pchar('[ʧ��]��� ' + sGameGoldName + ' �����޷����� '+ pszMsg);
          end;
        2:text:=Pchar('[ʧ��]��İ�����������������ڹ��� ' + pszMsg); 
        3:text:=Pchar('[ʧ��]û���ҵ� ' + pszMsg); //TBaseObject_SysMsg(BaseObject, PChar('û���ҵ� ' + pszMsg), mc_Red, mt_Hint);
      end;
    EDcode_EncodeString(text,pszDest);
    m_DefMsg := MakeDefaultMsg(SM_BUYSHOPITEM_FAIL, 0, 0, 0, 0);
    TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszDest);
    end;
    //����ʧ��
    RM_BUYSHOPITEMGIVE_FAIL: begin//ok
      case nParam1 of
        1: begin
            GameGoldName := GetGameGoldName;
            ShortStringToPChar(GameGoldName, szGameGoldName);
            sGameGoldName := szGameGoldName;
            text:=Pchar('[ʧ��]��� ' + sGameGoldName + ' �����޷����� '+ pszMsg); //����
          end;
        2:text:=Pchar('[ʧ��]û���ҵ� ' + pszMsg);//����
        3:text:=Pchar('[ʧ��]�����ѵİ�����������֪ͨ������������ڹ����� ' + pszMsg);
        4:text:=Pchar('[ʧ��]������� ' + pszMsg +' û�����ߣ�'); //����
      end;
    EDcode_EncodeString(text,pszDest);
    m_DefMsg := MakeDefaultMsg(SM_BUYSHOPITEMGIVE_FAIL, 0, 0, 0, 0);
    TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszDest);
    end;
    //�һ����ʧ�� 20080302
    RM_EXCHANGEGAMEGIRD_FAIL: begin//ok
      case nParam1 of
       0:begin
        GameGoldName := GetGameGoldName;
        ShortStringToPChar(GameGoldName, szGameGoldName);
        sGameGoldName := szGameGoldName;
        Text := Pchar('[ʧ��]����'+ sGameGoldName + '���������ֵ�� ����'+IntToStr(g_nGameGold)+'��'+ sGameGoldName+ '�һ�1�������');
       end;
       1:Text := Pchar('[ʧ��]�Բ��𣬱�����û�п���');
      end;
        EDcode_EncodeString(text,pszDest);
        m_DefMsg := MakeDefaultMsg(SM_EXCHANGEGAMEGIRD_FAIL, 0, 0, 0, 0);
        TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszDest);
    end;
    //�һ�����ɹ� 20080302
    RM_EXCHANGEGAMEGIRD_SUCCESS: begin//ok
        TBaseObject_GameGoldChanged(BaseObject);
        Text := Pchar('[�ɹ�]���ɹ��Ķһ��� '+ IntToStr(nParam1)+' �����');
        EDcode_EncodeString(text,pszDest);
        m_DefMsg := MakeDefaultMsg(SM_EXCHANGEGAMEGIRD_SUCCESS, 0, 0, 0, 0);
        TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszDest);
    end;
    RM_OPENSHOP: begin//ok
        m_DefMsg := MakeDefaultMsg(SM_SENGSHOPITEMS, wParam, nParam1, nParam2, nParam3);
        TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszMsg);
    end;
    RM_OPENSHOPSPECIALLY: begin//ok
        m_DefMsg := MakeDefaultMsg(SM_SENGSHOPSPECIALLYITEMS, wParam, nParam1, nParam2, nParam3);
        TPlayObject_SendSocket(BaseObject, @m_DefMsg, pszMsg);
    end;
    else begin
        if Assigned(OldPlayOperateMessage) then begin
          Result := OldPlayOperateMessage(BaseObject,
            wIdent,
            wParam,
            nParam1,
            nParam2,
            nParam3,
            MsgObject,
            dwDeliveryTime,
            pszMsg,
            boReturn);
          if not Result then boReturn := TRUE;
        end else begin
          boReturn := TRUE;
          Result := False;
        end;
      end;
  end;
  except
    MainOutMessage('[�쳣] PlugOfShop.PlayObjectOperateMessage');
  end;
end;

procedure LoadShopItemList();
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sItemName: string;
  sPrice: string;
  sIntroduce: string;
  nPrice: Integer;
  StdItem: _LPTSTDITEM;
  ShopInfo: pTShopInfo;

  sIdx: string;
  sImgBegin: string;
  sImgend: string;
  sIntroduce1: string;

  MyIni     : TIniFile;   //����һ�  20080302
begin
 Try
  if g_ShopItemList <> nil then begin
    UnLoadShopItemList();
  end;
  g_ShopItemList := Classes.TList.Create();
  sFileName := '.\BuyItemList.txt';
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create();
    LoadList.Add(';���������������ļ�');
    LoadList.Add(';��Ʒ����'#9'��Ʒ����'#9'���ۼ۸�'#9'ͼƬ��ʼ'#9'ͼƬ����'#9'�򵥽���'#9'��Ʒ����');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  g_ShopItemList.Clear;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      SetLength(sIntroduce, 50);
      sLineText := GetValidStr3(sLineText, sIdx, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPrice, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sImgBegin, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sImgend, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sIntroduce1, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sIntroduce, [' ', #9]);
      nPrice := Str_ToInt(sPrice, -1);
      if (sItemName <> '') and (nPrice >= 0) and (sIntroduce <> '') and (sIdx <> '') then begin
        StdItem := TUserEngine_GetStdItemByName(PChar(sItemName));
        if StdItem <> nil then begin
          New(ShopInfo);
          ShopInfo.Idx := sIdx;
          ShopInfo.ImgBegin := sImgBegin;
          ShopInfo.Imgend := sImgEnd;
          ShopInfo.Introduce1 := sIntroduce1;
          ShopInfo.StdItem := StdItem^;
          ShopInfo.StdItem.nPrice := nPrice * 100;
          FillChar(ShopInfo.sIntroduce, SizeOf(ShopInfo.sIntroduce), 0);
          Move(sIntroduce[1], ShopInfo.sIntroduce, Length(sIntroduce));
          g_ShopItemList.Add(ShopInfo);
        end;
      end;
    end;
  end;
  LoadList.Free;

{******************************************************************************}
//����Ϊ����һ�������� 20080302
  MyIni := TIniFile.Create('.\!SetUp.txt');
  g_boGameGird := MyIni.ReadBool('Shop','ShopBuyGameGird',g_boGameGird);
  g_nGameGold := MyIni.ReadInteger('Shop','GameGold',g_nGameGold);
  MyIni.Free;
{******************************************************************************}
  except
    MainOutMessage('[�쳣] PlugOfShop.LoadShopItemList');
  end;
end;

procedure UnLoadShopItemList();
var
  I: Integer;
  ShopInfo: pTShopInfo;
begin
 Try
  if g_ShopItemList <> nil then begin
    if g_ShopItemList.Count > 0 then begin//20080629
      for I := 0 to g_ShopItemList.Count - 1 do begin
        ShopInfo := pTShopInfo(g_ShopItemList.Items[I]);
        if ShopInfo <> nil then DisPose(ShopInfo);
      end;
    end;
    g_ShopItemList.Free;
    g_ShopItemList := nil;
  end;
  except
    MainOutMessage('[�쳣] PlugOfShop.UnLoadShopItemList');
  end;
end;

end.


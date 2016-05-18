unit PlayUser;

interface
uses
  Windows, Classes, SysUtils, StrUtils, ExtCtrls, EngineAPI, EngineType;
const
  MAXBAGITEM = 46;

  RM_MENU_OK = 10309;
type
  TMyTimer = class(TObject)
    Timer: TTimer;
    procedure OnTimer(Sender: TObject);
  end;

procedure InitPlayUser();
procedure UnInitPlayUser();
procedure LoadCheckItemList();
procedure UnLoadCheckItemList();

procedure InitMsgFilter();
procedure UnInitMsgFilter();
procedure LoadMsgFilterList();
procedure UnLoadMsgFilterList();

procedure InitAttack();
procedure UnInitAttack();
function IsFilterMsg(var sMsg: string): Boolean;
//procedure FilterMsg(PlayObject: TObject; pszSrcMsg: PChar; pszDestMsg: PChar); stdcall;
function FilterMsg(PlayObject: TObject; pszSrcMsg: PChar; pszDestMsg: PChar): Boolean;stdcall;{20071113 �޸�}

function CheckCanDropItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
function CheckCanDealItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
function CheckCanStorageItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
function CheckCanRepairItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;

function CheckCanDropHint(PlayObject: TPlayObject; pszItemName,pszString: PChar): Boolean; stdcall; //�Ƿ������ʾ 20080613
function CheckCanOpenBoxsHint(PlayObject: TPlayObject; pszItemName,pszString: PChar): Boolean; stdcall; //�Ƿ���������ʾ 20080613
function CheckCanNoDropItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall; //�Ƿ��������� 20080224
function CheckCanButchHint(PlayObject: TPlayObject; pszItemName,pszString: PChar): Boolean; stdcall;  //�Ƿ���ȡ��ʾ 20080224
function CheckCanHeroUseItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;  //�Ƿ��ֹӢ��ʹ�� 20080419
function CheckCanPickUpItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;//��ֹ����(��GM��) 20080611
function CheckCanDieDropItems(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;//�������� 20080614

procedure TRunSocketObject_Open(GateIdx, nSocket: Integer; sIPaddr: PChar); stdcall;
procedure TRunSocketObject_Close(GateIdx, nSocket: Integer); stdcall;
procedure TRunSocketObject_Eeceive_OK(); stdcall;
procedure TRunSocketObject_Data(GateIdx, nSocket: Integer; MsgBuff: PChar); stdcall;
var
  MyTimer: TMyTimer;
implementation

uses HUtil32, PlugShare;

procedure InitPlayUser();
begin
Try
  LoadCheckItemList();
  TPlayObject_SetCheckClientDropItem(CheckCanDropItem);
  TPlayObject_SetCheckClientDealItem(CheckCanDealItem);
  TPlayObject_SetCheckClientStorageItem(CheckCanStorageItem);
  TPlayObject_SetCheckClientRepairItem(CheckCanRepairItem);

  TPlayObject_SetCheckClientDropHint(CheckCanDropHint); //��Ʒ������ʾ����  20080226
  TPlayObject_SetCheckClientOpenBoxsHint(CheckCanOpenBoxsHint); //����������ʾ����  20080226
  TPlayObject_SetCheckClientNoDropItem(CheckCanNoDropItem); //��Ʒ������������  20080226
  TPlayObject_SetCheckClientButchHint(CheckCanButchHint);//��Ʒ������� ��ȡ��ʾ����  20080226
  TPlayObject_SetCheckClientHeroUseItem(CheckCanHeroUseItem); //��Ʒ������� ��ֹӢ��ʹ�ù��� 20080419
  TPlayObject_SetCheckClientPickUpItem(CheckCanPickUpItem);//��ֹ����(��GM��) 20080611
  TPlayObject_SetCheckClientDieDropItems(CheckCanDieDropItems);//�������� 20080614
  except
    MainOutMessage('[�쳣] PlugOfEngine.InitPlayUser');
  end;
end;

procedure UnInitPlayUser();
begin
Try
  TPlayObject_SetCheckClientDropItem(nil);
  TPlayObject_SetCheckClientDealItem(nil);
  TPlayObject_SetCheckClientStorageItem(nil);
  TPlayObject_SetCheckClientRepairItem(nil);

  TPlayObject_SetCheckClientDropHint(nil); //��Ʒ������ʾ����  20080226
  TPlayObject_SetCheckClientOpenBoxsHint(nil); //����������ʾ����  20080226
  TPlayObject_SetCheckClientNoDropItem(nil); //��Ʒ������������  20080226
  TPlayObject_SetCheckClientButchHint(nil);//��Ʒ������� ��ȡ��ʾ����  20080226
  TPlayObject_SetCheckClientHeroUseItem(nil);//��Ʒ������� ��ֹӢ��ʹ�ù��� 20080419
  TPlayObject_SetCheckClientPickUpItem(nil);//��ֹ����(��GM��) 20080611
  TPlayObject_SetCheckClientDieDropItems(nil);//�������� 20080614
  UnLoadCheckItemList();
  except
    MainOutMessage('[�쳣] PlugOfEngine.UnInitPlayUser');
  end;
end;

//������Ʒ�����б�
procedure LoadCheckItemList();
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sItemName: string; //��Ʒ����
  sCanDrop: string;  //�ܷ���
  sCanDeal: string;  //�ܷ���
  sCanStorage: string; //�ܷ���
  sCanRepair: string;  //�ܷ�����
  sCanDropHint: string; //�Ƿ������ʾ
  sCanOpenBoxsHint: string; //�Ƿ񿪱�����ʾ
  sCanNoDropItem: string; //�Ƿ���������
  sCanButchHint: string;  //�Ƿ���ȡ��ʾ
  sCanHeroUse: string; //�Ƿ��ֹӢ��ʹ��
  sCanPickUpItem: string;//��ֹ����(��GM��) 20080611
  sCanDieDropItems: string;//�������� 20080614
  CheckItem: pTCheckItem;
begin
Try
  sFileName := '.\CheckItemList.txt';

  if g_CheckItemList <> nil then begin
    UnLoadCheckItemList();
  end;
  g_CheckItemList := Classes.TList.Create;
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create();
    LoadList.Add(';��������ֹ��Ʒ�����ļ�');
    LoadList.Add(';��Ʒ����'#9'����'#9'����'#9'���'#9'����'#9'������ʾ'#9'��������ʾ'#9'��������'#9'��ȡ��ʾ');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanDrop, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanDeal, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanStorage, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanRepair, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanDropHint, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanOpenBoxsHint, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanNoDropItem, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanButchHint, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanHeroUse, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanPickUpItem, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanDieDropItems, [' ', #9]);

      if (sItemName <> '') then begin
        New(CheckItem);
        CheckItem.szItemName := sItemName;
        CheckItem.boCanDrop := sCanDrop = '-1';
        CheckItem.boCanDeal := sCanDeal = '-1';
        CheckItem.boCanStorage := sCanStorage = '-1';
        CheckItem.boCanRepair := sCanRepair = '-1';
        CheckItem.boCanDropHint := sCanDropHint = '-1';
        CheckItem.boCanOpenBoxsHint := sCanOpenBoxsHint = '-1';
        CheckItem.boCanNoDropItem := sCanNoDropItem = '-1';
        CheckItem.boCanButchHint := sCanButchHint = '-1';
        CheckItem.boCanHeroUse := sCanHeroUse = '-1';
        CheckItem.boPickUpItem := sCanPickUpItem = '-1';
        CheckItem.boDieDropItems:= sCanDieDropItems= '-1';//�������� 20080614

        g_CheckItemList.Add(CheckItem);
      end;
    end;
  end;
  LoadList.Free;
  except
    MainOutMessage('[�쳣] PlugOfEngine.LoadCheckItemList');
  end;
end;
procedure UnLoadCheckItemList();
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
Try
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if CheckItem <> nil then Dispose(CheckItem);
    end;
  end;
  g_CheckItemList.Free;
  g_CheckItemList := nil;
  except
    MainOutMessage('[�쳣] PlugOfEngine.UnLoadCheckItemList');
  end;
end;

function CheckCanDropItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
resourcestring
  sMsg = '����Ʒ��ֹ���ڵ��ϣ�����';
var
  I: Integer;
  CheckItem: pTCheckItem;
  NormNpc: TNormNpc;
begin
  Result := TRUE;
  Try
    if g_CheckItemList = nil then begin
      Result := False;
      Exit;
    end;
    if g_CheckItemList.Count > 0 then begin//20080629
      for I := 0 to g_CheckItemList.Count - 1 do begin
        CheckItem := g_CheckItemList.Items[I];
        if (CheckItem.boCanDrop) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
          NormNpc := TNormNpc_GetManageNpc();
          TBaseObject_SendMsg(PlayObject, NormNpc, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, PChar(sMsg));
          Result := False;
          break;
        end;
      end;//for
    end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanDropItem');
  end;
end;
function CheckCanDealItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
resourcestring
  sMsg = '����Ʒ��ֹ���ף�����';
var
  I: Integer;
  CheckItem: pTCheckItem;
  NormNpc: TNormNpc;
begin
  Result := TRUE;
  Try
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if (CheckItem.boCanDeal) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
        NormNpc := TNormNpc_GetManageNpc();
        TBaseObject_SendMsg(PlayObject, NormNpc, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, PChar(sMsg));
        Result := False;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanDealItem');
  end;
end;
function CheckCanStorageItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
resourcestring
  sMsg = '����Ʒ��ֹ��ֿ⣡����';
var
  I: Integer;
  CheckItem: pTCheckItem;
  NormNpc: TNormNpc;
begin
  Result := TRUE;
  Try
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if (CheckItem.boCanStorage) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
        NormNpc := TNormNpc_GetManageNpc();
        TBaseObject_SendMsg(PlayObject, NormNpc, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, PChar(sMsg));
        Result := False;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanStorageItem');
  end;
end;
function CheckCanRepairItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
//resourcestring
//  sMsg = '����Ʒ��ֹ��������'; //20080409
var
  I: Integer;
  CheckItem: pTCheckItem;
  //NormNpc: TNormNpc;
begin
  Result := TRUE;
  Try
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if (CheckItem.boCanRepair) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
        //NormNpc := TNormNpc_GetManageNpc();//20080523
        //TBaseObject_SendMsg(PlayObject, NormNpc, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, PChar(sMsg));//20080409
        Result := False;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanRepairItem');
  end;
end;
//�Ƿ������ʾ 20080613
function CheckCanDropHint(PlayObject: TPlayObject; pszItemName,pszString: PChar): Boolean; stdcall;
var
  I: Integer;
  CheckItem: pTCheckItem;
  UserName: _LPTSHORTSTRING;
  szUserName: array[0..ACTORNAMELEN] of Char;
  UserMap: _LPTSHORTSTRING;
  szUserMap: array[0..256] of Char;
  szString: string;
begin
  Result := TRUE;
  Try
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if (CheckItem.boCanDropHint) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
        UserName := TBaseObject_sCharName(PlayObject);
        ShortStringToPChar(UserName, szUserName);

        UserMap := TBaseObject_sMapByName(PlayObject);
        ShortStringToPChar(UserMap, szUserMap);
        szString := AnsiReplaceText(pszString, '%map', szUserMap);
        szString := AnsiReplaceText(szString, '%item', pszItemName);
        szString := AnsiReplaceText(szString, '%name', szUserName);
        TBaseObject_SendBroadCastMsgExt(PChar(szString), mt_Say);

        {UserMap := TBaseObject_sMapByName(PlayObject);//20080415 ȡ�������ڵ�ͼ����
        ShortStringToPChar(UserMap, szUserMap);
        TBaseObject_SendBroadCastMsgExt(PChar('ϵͳ����'+pszItemName+'��������'+szUserMap),mt_Say);}
        Result := False;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanDropHint');
  end;
end;

//�Ƿ���������ʾ 20080613
function CheckCanOpenBoxsHint(PlayObject: TPlayObject; pszItemName,pszString: PChar): Boolean; stdcall;
var
  I: Integer;
  CheckItem: pTCheckItem;
  UserName: _LPTSHORTSTRING;
  szUserName: array[0..256] of Char;
  szString: string;
begin
  Result := TRUE;
  Try
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if (CheckItem.boCanOpenBoxsHint) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
        UserName := TBaseObject_sCharName(PlayObject);
        ShortStringToPChar(UserName, szUserName);

        szString := AnsiReplaceText(pszString, '%name', szUserName);
        szString := AnsiReplaceText(szString, '%s', pszItemName);
        TBaseObject_SendBroadCastMsgExt(PChar(szString), mt_Say);

        //TBaseObject_SendBroadCastMsgExt(PChar('ϵͳ�����['+szUserName+']��������,��á�'+pszItemName+'��'),mt_Say);
        Result := False;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanOpenBoxsHint');
  end;
end;

//�Ƿ��������� 20080224
function CheckCanNoDropItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  Result := TRUE;
  Try
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if (CheckItem.boCanNoDropItem) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
        Result := False;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanNoDropItem');
  end;
end;

//�Ƿ���ȡ��ʾ 20080224
function CheckCanButchHint(PlayObject: TPlayObject; pszItemName,pszString: PChar): Boolean; stdcall;
var
  I: Integer;
  CheckItem: pTCheckItem;
  UserName: _LPTSHORTSTRING;
  szUserName: array[0..ACTORNAMELEN] of Char;//20080415
  UserMap: _LPTSHORTSTRING;
  szUserMap: array[0..256] of Char;
  szString: String;
begin
  Result := TRUE;
  Try
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if (CheckItem.boCanButchHint) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
        UserName := TBaseObject_sCharName(PlayObject);
        ShortStringToPChar(UserName, szUserName);
        //UserMap := TBaseObject_sMapName(PlayObject);
        UserMap := TBaseObject_sMapByName(PlayObject);//20080415 ȡ�������ڵ�ͼ����
        ShortStringToPChar(UserMap, szUserMap);
        szString := AnsiReplaceText(pszString, '%s', szUserName);
        szString := AnsiReplaceText(szString, '%map', szUserMap);
        szString := AnsiReplaceText(szString, '%item', pszItemName);
        TBaseObject_SendBroadCastMsgExt(PChar(szString), mt_Say);
        //TBaseObject_SendBroadCastMsgExt(PChar('ϵͳ�����['+szUserName+']��['+szUserMap+']��ȡ����'+pszItemName+'��'), mt_Say);
        Result := False;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanButchHint');
  end;
end;
//�Ƿ��ֹӢ��ʹ�� 20080419
function CheckCanHeroUseItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
resourcestring
  sMsg = '����Ʒ��ֹӢ��ʹ��!';
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  Result := False;
  Try
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if (CheckItem.boCanHeroUse) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
        TBaseObject_SysMsg(PlayObject, PChar(sMsg), mc_Red, mt_Hint);
        Result := True;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanHeroUseItem');
  end;
end;
//��ֹ����(��GM��) 20080611
function CheckCanPickUpItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  Result := TRUE;
  Try
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if (CheckItem.boPickUpItem) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
        Result := False;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanPickUpItem');
  end;
end;
//�������� 20080614
function CheckCanDieDropItems(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  Result := TRUE;
  Try
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  if g_CheckItemList.Count > 0 then begin//20080629
    for I := 0 to g_CheckItemList.Count - 1 do begin
      CheckItem := g_CheckItemList.Items[I];
      if (CheckItem.boDieDropItems) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
        Result := False;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.CheckCanDieDropItems');
  end;
end;

function IsFilterMsg(var sMsg: string): Boolean;
var
  I: Integer;
 // nLen: Integer;
 // sReplaceText: string;
 // sFilterText: string;
  FilterMsg: pTFilterMsg;
begin
  Result := False;
  Try
  if g_MsgFilterList = nil then begin
    Result := TRUE;
    Exit;
  end;
  if g_MsgFilterList.Count > 0 then begin//20080629
    for I := 0 to g_MsgFilterList.Count - 1 do begin
      FilterMsg := g_MsgFilterList.Items[I];
      if (FilterMsg.sFilterMsg <> '') and (AnsiContainsText(sMsg, FilterMsg.sFilterMsg)) then begin
        { for nLen := 1 to Length(MsgFilter.sFilterMsg) do begin
           sReplaceText := sReplaceText + sReplaceWord;
         end;}
        if FilterMsg.sNewMsg = '' then begin
          sMsg := '';
        end else begin
          sMsg := AnsiReplaceText(sMsg, FilterMsg.sFilterMsg, FilterMsg.sNewMsg);
        end;
        Result := TRUE;
        break;
      end;
    end;//for
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.IsFilterMsg');
  end;
end;

//procedure FilterMsg(PlayObject: TObject; pszSrcMsg: PChar; pszDestMsg: PChar);
function FilterMsg(PlayObject: TObject; pszSrcMsg: PChar; pszDestMsg: PChar): Boolean;
var
  sSrcMsg: string;
  nDestLen: Integer;
begin
  Result :=False;
  Try
  sSrcMsg := StrPas(pszSrcMsg);
  IsFilterMsg(sSrcMsg);//��Ϣ����
  if sSrcMsg <> '' then begin
    nDestLen := length(sSrcMsg);
    Move(sSrcMsg[1], pszDestMsg^, nDestLen);
    Result :=True;
  end else begin
    pszDestMsg := nil;
  end;
//if @pszDestMsg <> nil then Result :=True;
  except
    MainOutMessage('[�쳣] PlugOfEngine.FilterMsg');
  end;
end;

procedure LoadMsgFilterList();
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sFilterMsg: string;
  sNewMsg: string;
  FilterMsg: pTFilterMsg;
begin
  Try
  sFileName := '.\MsgFilterList.txt';
  if g_MsgFilterList <> nil then begin
    UnLoadMsgFilterList();
  end;
  g_MsgFilterList := Classes.TList.Create;
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create;
    LoadList.Add(';��������Ϣ���������ļ�');
    LoadList.Add(';������Ϣ'#9'�滻��Ϣ');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sFilterMsg, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sNewMsg, [' ', #9]);
      if (sFilterMsg <> '') then begin
        New(FilterMsg);
        FilterMsg.sFilterMsg := sFilterMsg;
        FilterMsg.sNewMsg := sNewMsg;
        g_MsgFilterList.Add(FilterMsg);
      end;
    end;
  end;
  LoadList.Free;
  except
    MainOutMessage('[�쳣] PlugOfEngine.LoadMsgFilterList');
  end;
end;

procedure UnLoadMsgFilterList();
var
  I: Integer;
begin
  Try
  if g_MsgFilterList.Count > 0 then begin//20080629
    for I := 0 to g_MsgFilterList.Count - 1 do begin
      Dispose(g_MsgFilterList.Items[I]);
    end;
  end;
  g_MsgFilterList.Free;
  g_MsgFilterList := nil;
  except
    MainOutMessage('[�쳣] PlugOfEngine.UnLoadMsgFilterList');
  end;
end;

procedure InitMsgFilter();
begin
  Try
  LoadMsgFilterList();
  TPlayObject_SetHookFilterMsg(FilterMsg);
  except
    MainOutMessage('[�쳣] PlugOfEngine.InitMsgFilter');
  end;
end;

procedure UnInitMsgFilter();
begin
  Try
  TPlayObject_SetHookFilterMsg(nil);
  UnLoadMsgFilterList();
  except
    MainOutMessage('[�쳣] PlugOfEngine.UnInitMsgFilter');
  end;
end;
////////////////////////////////////////////////////////////////////////////////
procedure InitTimer();
begin
  Try
  MyTimer := TMyTimer.Create;
  MyTimer.Timer := TTimer.Create(nil);
  MyTimer.Timer.Enabled := False;
  MyTimer.Timer.Interval := 10;
  MyTimer.Timer.OnTimer := MyTimer.OnTimer;
  MyTimer.Timer.Enabled := TRUE;
  except
    MainOutMessage('[�쳣] PlugOfEngine.InitTimer');
  end;
end;

procedure UnInitTimer();
begin
  Try
  MyTimer.Timer.Enabled := False;
  MyTimer.Timer.Free;
  MyTimer.Destroy;
  except
    MainOutMessage('[�쳣] PlugOfEngine.UnInitTimer');
  end;
end;

procedure InitAttack();
begin
  Try
  CurrIPaddrList := Classes.TList.Create;
  AttackIPaddrList := Classes.TList.Create;
  g_SessionList := Classes.TList.Create;
  TRunSocket_SetHookExecGateMsgOpen(TRunSocketObject_Open);
  TRunSocket_SetHookExecGateMsgClose(TRunSocketObject_Close);
  TRunSocket_SetHookExecGateMsgEeceive_OK(TRunSocketObject_Eeceive_OK);
  TRunSocket_SetHookExecGateMsgData(TRunSocketObject_Data);
  InitTimer();
  except
    MainOutMessage('[�쳣] PlugOfEngine.InitAttack');
  end;
end;

procedure UnInitAttack();
var
  IPList: Classes.TList;
  I, II: Integer;
begin
try
  UnInitTimer();
  TRunSocket_SetHookExecGateMsgOpen(nil);
  TRunSocket_SetHookExecGateMsgClose(nil);
  TRunSocket_SetHookExecGateMsgEeceive_OK(nil);
  TRunSocket_SetHookExecGateMsgData(nil);
  if g_SessionList.Count > 0 then begin//20080629
    for I := 0 to g_SessionList.Count - 1 do begin
      Dispose(g_SessionList.Items[I]);
    end;
  end;
  g_SessionList.Free;
  if CurrIPaddrList.Count > 0 then begin//20080629
    for I := 0 to CurrIPaddrList.Count - 1 do begin
      IPList := Classes.TList(CurrIPaddrList.Items[I]);
      if IPList <> nil then begin
        if IPList.Count > 0 then begin//20080629
          for II := 0 to IPList.Count - 1 do begin
            if pTSockaddr(IPList.Items[II]) <> nil then
              Dispose(pTSockaddr(IPList.Items[II]));
          end;
        end;
        IPList.Free;
      end;
    end;
  end;
  CurrIPaddrList.Free;
  if AttackIPaddrList.Count > 0 then begin//20080629
    for I := 0 to AttackIPaddrList.Count - 1 do begin
      Dispose(AttackIPaddrList.Items[I]);
    end;
  end;
  AttackIPaddrList.Free;
  except
    MainOutMessage('[�쳣] PlugOfEngine.UnInitAttack');
  end;
end;

function AddAttackIP(GateIdx, nSocket: Integer; sIPaddr: string): Boolean;
var
  I: Integer;
  IPaddr, AddIPaddr: pTSockaddr;
 // nIPaddr: Integer;
  bo01: Boolean;
begin
  Result := False;
  Try
  if nAttackLevel > 0 then begin
    bo01 := False;
    if AttackIPaddrList.Count > 0 then begin//20080629
      for I := AttackIPaddrList.Count - 1 downto 0 do begin
        IPaddr := pTSockaddr(AttackIPaddrList.Items[I]);
        if CompareText(sIPaddr, IPaddr.sIPaddr) = 0 then begin
          if (GetTickCount - IPaddr.dwStartAttackTick) <= dwAttackTick * nAttackLevel then begin
            IPaddr.dwStartAttackTick := GetTickCount;
            Inc(IPaddr.nAttackCount);
            if IPaddr.nAttackCount >= nAttackCount * nAttackLevel then begin
              Dispose(IPaddr);
              AttackIPaddrList.Delete(I);
              Result := TRUE;
            end;
          end else begin
            if IPaddr.nAttackCount > nAttackCount * nAttackLevel then begin
              Result := TRUE;
            end;
            Dispose(IPaddr);
            AttackIPaddrList.Delete(I);
          end;
          bo01 := TRUE;
          break;
        end;
      end;//for
    end;
    if not bo01 then begin
      New(AddIPaddr);
      FillChar(AddIPaddr^, SizeOf(TSockaddr), 0);
      AddIPaddr^.nGateIdx := GateIdx;
      AddIPaddr^.nSocket := nSocket;
      AddIPaddr^.sIPaddr := sIPaddr;
      AddIPaddr^.dwStartAttackTick := GetTickCount;
      AddIPaddr^.nAttackCount := 0;
      AttackIPaddrList.Add(AddIPaddr);
    end;
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.AddAttackIP');
  end;
end;

function IsConnLimited(GateIdx, nSocket: Integer; sIPaddr: string): Boolean;
var
  I: Integer;
  IPaddr, AttackIPaddr: pTSockaddr;
  bo01: Boolean;
  IPList: Classes.TList;
begin
  Result := False;
  Try
  if nAttackLevel > 0 then begin
    bo01 := False;
    if CurrIPaddrList.Count > 0 then begin//20080629
      for I := 0 to CurrIPaddrList.Count - 1 do begin
        IPList := Classes.TList(CurrIPaddrList.Items[I]);
        if IPList <> nil then begin
          IPaddr := pTSockaddr(IPList.Items[0]);
          if IPaddr <> nil then begin
            if CompareText(sIPaddr, IPaddr.sIPaddr) = 0 then begin
              bo01 := TRUE;
              Result := AddAttackIP(GateIdx, nSocket, sIPaddr);
              New(AttackIPaddr);
              FillChar(AttackIPaddr^, SizeOf(TSockaddr), 0);
              AttackIPaddr^.nGateIdx := GateIdx;
              AttackIPaddr^.nSocket := nSocket;
              AttackIPaddr^.sIPaddr := sIPaddr;
              IPList.Add(AttackIPaddr);
              if IPList.Count > nMaxConnOfIPaddr * nAttackLevel then Result := TRUE;
              break;
            end;
          end;
        end;
      end;//for
    end;
    if not bo01 then begin
      //IPList := nil;//20080727 ע��
      New(IPaddr);
      FillChar(IPaddr^, SizeOf(TSockaddr), 0);
      IPaddr^.nGateIdx := GateIdx;
      IPaddr^.nSocket := nSocket;
      IPaddr^.sIPaddr := sIPaddr;
      IPList := Classes.TList.Create;
      IPList.Add(IPaddr);
      CurrIPaddrList.Add(IPList);
    end;
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.IsConnLimited');
  end;
end;

procedure TRunSocketObject_Open(GateIdx, nSocket: Integer; sIPaddr: PChar);
var
  SessionInfo: pTSessionInfo;
  sUserIPaddr: string;
begin
  Try
  sUserIPaddr := StrPas(sIPaddr);
  if boCCAttack and IsConnLimited(GateIdx, nSocket, sUserIPaddr) then begin
    TRunSocket_CloseUser(GateIdx, nSocket);
    MainOutMessage(PChar('�˿ڹ�����' + sUserIPaddr));
    Exit;
  end;
  New(SessionInfo);
  SessionInfo.nGateIdx := GateIdx;
  SessionInfo.nSocket := nSocket;
  SessionInfo.sRemoteAddr := StrPas(sIPaddr);
  SessionInfo.dwReceiveTimeTick := GetTickCount;
  SessionInfo.nReceiveLength := 0;
  SessionInfo.dwConnctCheckTick := GetTickCount;
  SessionInfo.dwReceiveTick := GetTickCount;
  g_SessionList.Add(SessionInfo);
  except
    MainOutMessage('[�쳣] PlugOfEngine.TRunSocketObject_Open');
  end;
end;

procedure TRunSocketObject_Close(GateIdx, nSocket: Integer);
var
  I: Integer;
  IPList: Classes.TList;
  SessionInfo: pTSessionInfo;
begin
  Try
  if CurrIPaddrList.Count > 0 then begin//20080629
    for I := CurrIPaddrList.Count - 1 downto 0 do begin
      IPList := Classes.TList(CurrIPaddrList.Items[I]);
      if IPList <> nil then begin
        if pTSockaddr(IPList.Items[0]) <> nil then begin
          if (pTSockaddr(IPList.Items[0]).nGateIdx = GateIdx) and (pTSockaddr(IPList.Items[0]).nSocket = nSocket) then begin
            Dispose(pTSockaddr(IPList.Items[0]));
            IPList.Delete(0);
            if IPList.Count <= 0 then begin
              IPList.Free;
              CurrIPaddrList.Delete(I);
            end;
            break;
          end;
        end;
      end;
    end;//for
  end;
  if g_SessionList.Count > 0 then begin//20080629
    for I := g_SessionList.Count - 1 downto 0 do begin
      SessionInfo := pTSessionInfo(g_SessionList.Items[I]);
      if (SessionInfo.nGateIdx = GateIdx) and (SessionInfo.nSocket = nSocket) then begin
        Dispose(SessionInfo);
        g_SessionList.Delete(I);
        break;
      end;
    end;
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.TRunSocketObject_Close');
  end;
end;

procedure DelNoLineUser(GateIdx, nSocket: Integer);
var
  I: Integer;
  IPList: Classes.TList;
begin
  Try
  if CurrIPaddrList.Count > 0 then begin//20080629
    for I := CurrIPaddrList.Count - 1 downto 0 do begin
      IPList := Classes.TList(CurrIPaddrList.Items[I]);
      if IPList <> nil then begin
        if pTSockaddr(IPList.Items[0]) <> nil then begin
          if (pTSockaddr(IPList.Items[0]).nGateIdx = GateIdx) and (pTSockaddr(IPList.Items[0]).nSocket = nSocket) then begin
            Dispose(pTSockaddr(IPList.Items[0]));
            IPList.Delete(0);
            if IPList.Count <= 0 then begin
              IPList.Free;
              CurrIPaddrList.Delete(I);
            end;
            break;
          end;
        end;
      end;
    end;
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.DelNoLineUser');
  end;
end;

procedure TRunSocketObject_Eeceive_OK();
begin

end;

procedure TRunSocketObject_Data(GateIdx, nSocket: Integer; MsgBuff: PChar);
var
  I: Integer;
  SessionInfo: pTSessionInfo;
  sData: string;
begin
Try
  sData := StrPas(MsgBuff);
  if g_SessionList.Count > 0 then begin//20080629
    for I := 0 to g_SessionList.Count - 1 do begin
      SessionInfo := pTSessionInfo(g_SessionList.Items[I]);
      if (SessionInfo.nGateIdx = GateIdx) and (SessionInfo.nSocket = nSocket) then begin
        SessionInfo.dwReceiveTimeTick := GetTickCount;
        Inc(SessionInfo.nReceiveLength, length(sData));
        break;
      end;
    end;
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.TRunSocketObject_Data');
  end;
end;

procedure TMyTimer.OnTimer(Sender: TObject);
var
  I: Integer;
  SessionInfo: pTSessionInfo;
begin
  I := 0;
  Try
  while I <= g_SessionList.Count - 1 do begin
    SessionInfo := pTSessionInfo(g_SessionList.Items[I]);
    if (GetTickCount - SessionInfo.dwReceiveTick) > dwReviceTick * nAttackLevel then begin
      SessionInfo.dwReceiveTick := GetTickCount;
      if SessionInfo.nReceiveLength > nReviceMsgLength * nAttackLevel then begin
        if boDataAttack then begin
          TRunSocket_CloseUser(SessionInfo.nGateIdx, SessionInfo.nSocket);
          DelNoLineUser(SessionInfo.nGateIdx, SessionInfo.nSocket);
          MainOutMessage(PChar('�˿ڹ������ݰ����ȣ�' + IntToStr(SessionInfo.nReceiveLength)));
          Dispose(SessionInfo);
          g_SessionList.Delete(I);
        end else SessionInfo.nReceiveLength := 0;
      end else begin
        SessionInfo.nReceiveLength := 0;
      end;
    end;
    if boKeepConnectTimeOut then begin
      if (GetTickCount - SessionInfo.dwReceiveTimeTick) > dwKeepConnectTimeOut then begin
        TRunSocket_CloseUser(SessionInfo.nGateIdx, SessionInfo.nSocket);
        DelNoLineUser(SessionInfo.nGateIdx, SessionInfo.nSocket);
        Dispose(SessionInfo);
        MainOutMessage(PChar('�˿ڿ����ӹ���'));
        g_SessionList.Delete(I);
      end;
    end;
    Inc(I);
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.OnTimer');
  end;
end;

end.


unit NpcScriptCmd;

interface
uses
  Windows, SysUtils, EngineAPI, EngineType, PlugShare;
const
  szString = '@@InPutString';
  szInteger = '@@InPutInteger';

  sSC_CHECKONLINEPLAYCOUNT = 'CHECKONLINEPLAYCOUNT';
  nSC_CHECKONLINEPLAYCOUNT = 10000;

  sSC_CHECKPLAYDIELVL = 'CHECKPLAYDIELVL';
  nSC_CHECKPLAYDIELVL = 10001; //杀人后检测

  sSC_CHECKPLAYDIEJOB = 'CHECKPLAYDIEJOB';
  nSC_CHECKPLAYDIEJOB = 10002;

  sSC_CHECKPLAYDIESEX = 'CHECKPLAYDIESEX';
  nSC_CHECKPLAYDIESEX = 10003;

  sSC_CHECKKILLPLAYLVL = 'CHECKKILLPLAYLVL';
  nSC_CHECKKILLPLAYLVL = 10004; //死亡后检测

  sSC_CHECKKILLPLAYJOB = 'CHECKKILLPLAYJOB';
  nSC_CHECKKILLPLAYJOB = 10005;
  
  sSC_CHECKKILLPLAYSEX = 'CHECKKILLPLAYSEX';
  nSC_CHECKKILLPLAYSEX = 10006;


procedure InitNpcScriptCmd();
procedure UnInitNpcScriptCmd();
function ScriptActionCmd(pszCmd: PChar): Integer; stdcall;
function ScriptConditionCmd(pszCmd: PChar): Integer; stdcall;
function ConditionOfCheckOnlinePlayCount(Npc: TObject; pszParam1: PChar; nCount: Integer): Boolean;
//20080727 注释
{procedure ScriptAction(Npc: TObject; PlayObject: TObject; nCmdCode: Integer; pszParam1: PChar;
  nParam1: Integer; pszParam2: PChar; nParam2: Integer;
  pszParam3: PChar; nParam3: Integer; pszParam4: PChar;
  nParam4: Integer; pszParam5: PChar; nParam5: Integer;
  pszParam6: PChar; nParam6: Integer); stdcall;}

function ScriptCondition(Npc: TObject; PlayObject: TObject; nCmdCode: Integer; pszParam1: PChar;
  nParam1: Integer; pszParam2: PChar; nParam2: Integer;
  pszParam3: PChar; nParam3: Integer; pszParam4: PChar;
  nParam4: Integer; pszParam5: PChar; nParam5: Integer;
  pszParam6: PChar; nParam6: Integer): Boolean; stdcall;

procedure CheckUserSelect(Merchant: TMerchant; PlayObject: TPlayObject; pszLabel, pszData: PChar); stdcall;

function ConditionOfCheckPlaylvl(PlayObject: TObject; pszParam1: PChar; nParam1: Integer): Boolean;
function ConditionOfCheckPlaySex(PlayObject: TObject; pszParam1: PChar): Boolean;
function ConditionOfCheckPlayJob(PlayObject: TObject; pszParam1: PChar): Boolean;

var
  OldScriptActionCmd: _TSCRIPTCMD;
  OldScriptConditionCmd: _TSCRIPTCMD;
  OldScriptAction: _TSCRIPTACTION;
  OldScriptCondition: _TSCRIPTCONDITION;
  OldUserSelelt: _TOBJECTACTIONUSERSELECT;
implementation
uses HUtil32, PlayUser;
procedure InitNpcScriptCmd();
begin
try
  OldScriptActionCmd := TNormNpc_GetScriptActionCmd();
  OldScriptConditionCmd := TNormNpc_GetScriptConditionCmd();
  OldScriptAction := TNormNpc_GetScriptAction();
  OldScriptCondition := TNormNpc_GetScriptCondition();
  OldUserSelelt := TMerchant_GetCheckUserSelect();
  TNormNpc_SetScriptActionCmd(PlugHandle, ScriptActionCmd);
  TNormNpc_SetScriptConditionCmd(PlugHandle, ScriptConditionCmd);
  //TNormNpc_SetScriptAction(PlugHandle, ScriptAction);//20080727 注释
  TNormNpc_SetScriptCondition(PlugHandle, ScriptCondition);
  TMerchant_SetCheckUserSelect(PlugHandle, CheckUserSelect);
  except
    MainOutMessage('[异常] PlugOfEngine.InitNpcScriptCmd');
  end;
end;

procedure UnInitNpcScriptCmd();
begin
try
  TNormNpc_SetScriptActionCmd(PlugHandle, OldScriptActionCmd);
  TNormNpc_SetScriptConditionCmd(PlugHandle, OldScriptConditionCmd);
  TNormNpc_SetScriptAction(PlugHandle, OldScriptAction);
  TNormNpc_SetScriptCondition(PlugHandle, OldScriptCondition);
  TMerchant_SetCheckUserSelect(PlugHandle, OldUserSelelt);
  except
    MainOutMessage('[异常] PlugOfEngine.UnInitNpcScriptCmd');
  end;
end;

function ConditionOfCheckPlaylvl(PlayObject: TObject; pszParam1: PChar; nParam1: Integer): Boolean;
var
  KillPlayObject: TObject;
  m_Abil: _TABILITY;
  btType: Byte;
  cMethod: Char;
begin
  Result := False;
try
  if TBaseObject_LastHiter(PlayObject) <> nil then begin
    KillPlayObject := TBaseObject_LastHiter(PlayObject)^;
    btType := TBaseObject_btRaceServer(KillPlayObject)^;
    if btType = RC_PLAYOBJECT then begin
      if TBaseObject_WAbility(KillPlayObject) <> nil then begin
        m_Abil := TBaseObject_WAbility(KillPlayObject)^;
        cMethod := StrPas(pszParam1)[1];
        case cMethod of
          '=': if m_Abil.wLevel = nParam1 then Result := TRUE;
          '>': if m_Abil.wLevel > nParam1 then Result := TRUE;
          '<': if m_Abil.wLevel < nParam1 then Result := TRUE;
          else if m_Abil.wLevel >= nParam1 then Result := TRUE;
        end;
      end;
    end;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.ConditionOfCheckPlaylvl');
  end;
end;

function ConditionOfCheckPlaySex(PlayObject: TObject; pszParam1: PChar): Boolean;
var
  KillPlayObject: TObject;
  btType: Byte;
  btSex: Byte;
  sParam1: string;
const
  MAN = 'MAN';
  WOMAN = 'WOMAN';
begin
  Result := False;
try
  if TBaseObject_LastHiter(PlayObject) <> nil then begin
    KillPlayObject := TBaseObject_LastHiter(PlayObject)^;
    btType := TBaseObject_btRaceServer(KillPlayObject)^;
    if btType = RC_PLAYOBJECT then begin
      sParam1 := StrPas(pszParam1);
      btSex := TBaseObject_btGender(KillPlayObject)^;
      case btSex of
        0: if CompareText(sParam1, MAN) = 0 then Result := TRUE;
        1: if CompareText(sParam1, WOMAN) = 0 then Result := TRUE;
        else Result := False;
      end;
    end;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.ConditionOfCheckPlaySex');
  end;
end;

function ConditionOfCheckPlayJob(PlayObject: TObject; pszParam1: PChar): Boolean;
var
  KillPlayObject: TObject;
  btType: Byte;
  btJob: Byte;
  sParam1: string;
const
  WARRIOR = 'WARRIOR';
  WIZARD = 'WIZARD';
  TAOIST = 'TAOIST';
begin
  Result := False;
  try
  if TBaseObject_LastHiter(PlayObject) <> nil then begin
    KillPlayObject := TBaseObject_LastHiter(PlayObject)^;
    btType := TBaseObject_btRaceServer(KillPlayObject)^;
    if btType = RC_PLAYOBJECT then begin
      sParam1 := StrPas(pszParam1);
      btJob := TBaseObject_btJob(KillPlayObject)^;
      case btJob of
        0: if CompareText(sParam1, WARRIOR) = 0 then Result := TRUE;
        1: if CompareText(sParam1, WIZARD) = 0 then Result := TRUE;
        2: if CompareText(sParam1, TAOIST) = 0 then Result := TRUE;
        else Result := False;
      end;
    end;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.ConditionOfCheckPlayJob');
  end;
end;

procedure CheckUserSelect(Merchant: TMerchant; PlayObject: TPlayObject; pszLabel, pszData: PChar);
  function IsStringNumber(Str: string): Boolean;
  var
    i:integer;
  begin
    if Length(str)<=0 then begin
        Result:=False;
        exit;    
    end;
    for i:=1 to length(str) do
      if not (str[i] in ['0'..'9']) then begin
        Result:=False;
        exit;
      end;
    Result:=true;
  end;
var
  sLabel, sData: string;
  nData: Integer;
  nLength: Integer;
begin
try
  sLabel := StrPas(pszLabel);
  nLength := CompareText(sLabel, szString);
  if nLength > 0 then begin
    sLabel := Copy(sLabel, length(szString) + 1, nLength);
    sData := StrPas(pszData);
    if not IsFilterMsg(sData) then begin
      //TPlayObject_SetUserInPutString(PlayObject, pszData);
      if IsStringNumber(sLabel) then
        TPlayObject_SetUserInPutString(PlayObject, pszData , StrToInt(sLabel))//20080402 修改
      else TPlayObject_SetUserInPutString(PlayObject, pszData , 0);

      TNormNpc_GotoLable(Merchant, PlayObject, PChar('@InPutString' + sLabel));
    end else begin
      TNormNpc_GotoLable(Merchant, PlayObject, PChar('@MsgFilter'));
    end;
    Exit;
  end else
    nLength := CompareText(sLabel, szInteger);
  if nLength > 0 then begin
    sLabel := Copy(sLabel, length(szInteger) + 1, nLength);
    sData := StrPas(pszData);
    nData := Str_ToInt(sData, -1);
    //TPlayObject_SetUserInPutInteger(PlayObject, nData);
    if IsStringNumber(sLabel) then
      TPlayObject_SetUserInPutInteger(PlayObject, nData, StrToInt(sLabel))//20080402 修改
    else TPlayObject_SetUserInPutInteger(PlayObject, nData , 0);
    TNormNpc_GotoLable(Merchant, PlayObject, PChar('@InPutInteger' + sLabel));
    Exit;
  end else begin
    if Assigned(OldUserSelelt) then begin
      OldUserSelelt(Merchant, PlayObject, pszLabel, pszData);
    end;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.CheckUserSelect');
  end;
end;

function ScriptActionCmd(pszCmd: PChar): Integer; stdcall;
begin
  try
  if StrIComp(pszCmd, sSC_CHECKONLINEPLAYCOUNT) = 0 then begin
    Result := nSC_CHECKONLINEPLAYCOUNT;
  {end else
    if StrIComp(pszCmd, szTAKEUSERITEM) = 0 then begin
    Result := nTAKEUSERITEM; }
  end else begin
    Result := -1;
  end;
 { if (Result < 0) and Assigned(OldScriptActionCmd) then begin //20080516 注释掉
    Result := OldScriptActionCmd(pszCmd);
  end; }
  except
    MainOutMessage('[异常] PlugOfEngine.ScriptActionCmd');
  end;
end;

function ScriptConditionCmd(pszCmd: PChar): Integer; stdcall;
begin
try
  if StrIComp(pszCmd, sSC_CHECKONLINEPLAYCOUNT) = 0 then begin
    Result := nSC_CHECKONLINEPLAYCOUNT;
  end else begin
    Result := -1;
  end;
  if (Result < 0) and Assigned(OldScriptConditionCmd) then begin
    //调用下一个插件处理函数
    Result := OldScriptConditionCmd(pszCmd);
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.ScriptConditionCmd');
  end;
end;

{procedure ActionOfGiveUserItem(Npc: TObject; PlayObject: TObject; pszItemName: PChar; nCount: Integer);
begin

end;

procedure ActionOfTakeUserItem(Npc: TObject; PlayObject: TObject; pszItemName: PChar; nCount: Integer);
begin

end;}

function ConditionOfCheckOnlinePlayCount(Npc: TObject; pszParam1: PChar; nCount: Integer): Boolean;
var
  cMethod: Char;
  szParam1: string;
begin
  Result := False;
  Try
  szParam1 := StrPas(pszParam1);
  cMethod := szParam1[1];
  case cMethod of
    '=': if TUserEngine_GetPlayObjectCount = nCount then Result := TRUE;
    '>': if TUserEngine_GetPlayObjectCount > nCount then Result := TRUE;
    '<': if TUserEngine_GetPlayObjectCount < nCount then Result := TRUE;
    else if TUserEngine_GetPlayObjectCount >= nCount then Result := TRUE;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.ConditionOfCheckOnlinePlayCount');
  end;
end;
//20080727 注释
(*procedure ScriptAction(Npc: TObject; PlayObject: TObject; nCmdCode: Integer; pszParam1: PChar;
  nParam1: Integer; pszParam2: PChar; nParam2: Integer;
  pszParam3: PChar; nParam3: Integer; pszParam4: PChar;
  nParam4: Integer; pszParam5: PChar; nParam5: Integer;
  pszParam6: PChar; nParam6: Integer); stdcall;
begin
  {case nCmdCode of
    nGIVEUSERITEM: ActionOfGiveUserItem(Npc, PlayObject, pszParam1, nParam2);
    nTAKEUSERITEM: ActionOfTakeUserItem(Npc, PlayObject, pszParam1, nParam2);
  end; }
end; *)

function ScriptCondition(Npc: TObject; PlayObject: TObject; nCmdCode: Integer; pszParam1: PChar;
  nParam1: Integer; pszParam2: PChar; nParam2: Integer;
  pszParam3: PChar; nParam3: Integer; pszParam4: PChar;
  nParam4: Integer; pszParam5: PChar; nParam5: Integer;
  pszParam6: PChar; nParam6: Integer): Boolean; stdcall;
begin
  Result := TRUE;
  Try
  case nCmdCode of
    nSC_CHECKONLINEPLAYCOUNT: if not ConditionOfCheckOnlinePlayCount(Npc, pszParam1, nParam2) then Result := False;
    nSC_CHECKPLAYDIELVL,
      nSC_CHECKKILLPLAYLVL: if not ConditionOfCheckPlaylvl(PlayObject, pszParam1, nParam1) then Result := False;
    nSC_CHECKPLAYDIEJOB,
      nSC_CHECKKILLPLAYJOB: if not ConditionOfCheckPlayJob(PlayObject, pszParam1) then Result := False;
    nSC_CHECKPLAYDIESEX,
      nSC_CHECKKILLPLAYSEX: if not ConditionOfCheckPlaySex(PlayObject, pszParam1) then Result := False;
  end;
  except
    MainOutMessage('[异常] PlugOfEngine.ScriptCondition');
  end;
end;

end.

unit PlugMain;

interface
uses
  Windows, EngineAPI, UserMagic;

procedure InitPlug();
procedure UnInitPlug();
function StartPlug(): Boolean;
implementation

procedure InitPlug();
begin
  Try
  LoadMagicList();
  TMagicManager_SetHookDoSpell(DoSpell);
  except
    MainOutMessage('[“Ï≥£] MagicManage.InitPlug');
  end;
end;

procedure UnInitPlug();
begin
  Try
  TMagicManager_SetHookDoSpell(nil);
  UnLoadMagicList();
  except
    MainOutMessage('[“Ï≥£] MagicManage.UnInitPlug');
  end;
end;

function StartPlug(): Boolean;
begin
  Result := TRUE;
  Try
  LoadMagicListToEngine();
  except
    MainOutMessage('[“Ï≥£] MagicManage.StartPlug');
  end;
end;

end.


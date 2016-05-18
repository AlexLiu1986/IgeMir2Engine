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
    MainOutMessage('[�쳣] MagicManage.InitPlug');
  end;
end;

procedure UnInitPlug();
begin
  Try
  TMagicManager_SetHookDoSpell(nil);
  UnLoadMagicList();
  except
    MainOutMessage('[�쳣] MagicManage.UnInitPlug');
  end;
end;

function StartPlug(): Boolean;
begin
  Result := TRUE;
  Try
  LoadMagicListToEngine();
  except
    MainOutMessage('[�쳣] MagicManage.StartPlug');
  end;
end;

end.


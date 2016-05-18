unit PlugMain;

interface
uses
  Windows, SysUtils, EngineAPI, ExtCtrls, Classes;
procedure InitPlug();
procedure UnInitPlug();
function StartPlug(): Boolean;
implementation

uses PlayUserCmd, NpcScriptCmd, PlugShare, PlayUser, FunctionConfig;

procedure InitPlug();
begin
Try
  InitPlayUserCmd();
  InitNpcScriptCmd();
  InitPlayUser();
  InitUserConfig();
  InitSuperRock();
  InitMsgFilter();
  {if boStartAttack then
    InitAttack();}
  except
    MainOutMessage('[“Ï≥£] PlugOfEngine.InitPlug');
  end;
end;

procedure UnInitPlug();
begin
  Try
  UnInitPlayUserCmd();
  UnInitNpcScriptCmd();
  UnInitPlayUser();
  UnInitSuperRock();
  UnInitMsgFilter();
  {if boStartAttack then
    UnInitAttack(); }
  except
    MainOutMessage('[“Ï≥£] PlugOfEngine.UnInitPlug');
  end;
end;

function StartPlug(): Boolean;
begin
  Result := TRUE;
end;

end.

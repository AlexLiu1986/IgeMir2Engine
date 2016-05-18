unit PlayUserCmd;

interface
uses
  Windows, Classes, SysUtils, EngineAPI, EngineType;
procedure InitPlayUserCmd();
procedure UnInitPlayUserCmd();
procedure LoadUserCmdList();
function PlayUserCommand(PlayObject: TObject; pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean; stdcall;
function ProcessUserCmd(PlayObject: TObject; pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean;
var
  OldUserCmd: _TOBJECTUSERCMD;
implementation

uses PlugShare, HUtil32, PlayUser;
procedure InitPlayUserCmd();
begin
  Try
  OldUserCmd := TPlayObject_GetHookUserCmd();
  TPlayObject_SetHookUserCmd(PlugHandle, PlayUserCommand);
  g_UserCmdList := Classes.TStringList.Create();
  LoadUserCmdList();
  except
    MainOutMessage('[�쳣] PlugOfEngine.InitPlayUserCmd');
  end;
end;
procedure UnInitPlayUserCmd();
begin
  Try
  TPlayObject_SetHookUserCmd(PlugHandle, OldUserCmd);
  g_UserCmdList.Free;
  except
    MainOutMessage('[�쳣] PlugOfEngine.UnInitPlayUserCmd');
  end;
end;
procedure LoadUserCmdList();
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sUserCmd: string;
  sCmdNo: string;
  nCmdNo: Integer;
begin
  Try
  sFileName := '.\UserCmd.txt';
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create();
    LoadList.Add(';�����������ļ�');
    LoadList.Add(';��������'#9'��Ӧ���');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  g_UserCmdList.Clear;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sUserCmd, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCmdNo, [' ', #9]);
      nCmdNo := Str_ToInt(sCmdNo, -1);
      if (sUserCmd <> '') and (nCmdNo >= 0) then begin
        g_UserCmdList.AddObject(sUserCmd, TObject(nCmdNo));
      end;
    end;
  end;
  LoadList.Free;
  except
    MainOutMessage('[�쳣] PlugOfEngine.LoadUserCmdList');
  end;
end;
//������Ϸ����
//�˺�����������������Ϸ�����ǰ����
//����ֵ��True/False
//True  ��������������ƥ�����������˳�����
//False ��˵����Ϸ����δ�������������ƥ����������
function PlayUserCommand(PlayObject: TObject; pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean; stdcall;
begin
  Try
  Result := ProcessUserCmd(PlayObject, pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7);
  if not Result and Assigned(OldUserCmd) then begin
    //������һ����Ϸ�������
    Result := OldUserCmd(PlayObject, pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7);
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.PlayUserCommand');
  end;
end;

function ProcessUserCmd(PlayObject: TObject; pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean;
var
  I: Integer;
  sLable: string;
  FunctionNPC: TNormNpc;
begin
  Result := False;
  Try
  if (g_UserCmdList = nil) or (g_UserCmdList.Count <= 0) then Exit;
  for I := 0 to g_UserCmdList.Count - 1 do begin
    if CompareText(pszCmd, g_UserCmdList.Strings[I]) = 0 then begin
      FunctionNPC := TNormNpc_GetFunctionNpc();
      if FunctionNPC = nil then break;
      sLable := '@UserCmd' + IntToStr(Integer(g_UserCmdList.Objects[I]));
      if PlayObject <> nil then begin
      //TPlayObject_SetUserInPutString(PlayObject, pszParam1);
      //TPlayObject_SetUserInPutInteger(PlayObject, Str_ToInt(pszParam1, 0));
        TPlayObject_SetUserInPutString(PlayObject, pszParam1,Integer(g_UserCmdList.Objects[I]));//20080401 �޸�
        TPlayObject_SetUserInPutInteger(PlayObject, Str_ToInt(pszParam1, 0),Integer(g_UserCmdList.Objects[I]));//20080401 �޸�
        TNormNpc_GotoLable(FunctionNPC, PlayObject, PChar(sLable));
        Result := TRUE;
      end;
      break;
    end;
  end;
  except
    MainOutMessage('[�쳣] PlugOfEngine.ProcessUserCmd');
  end;
end;

end.


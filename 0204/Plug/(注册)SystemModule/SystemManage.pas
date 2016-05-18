unit SystemManage;

interface
uses
  Windows, Graphics, SysUtils, UserLicense {, DiaLogs};
var
  License: TLicense;
procedure InitLicense(nVersion: Integer; btStatus: Byte; wCount, wPersonCount: Word; MaxDate: TDateTime; UserName: PChar);
procedure UnInitLicense();
function GetRegisterName(): String;
procedure GetLicense(var UserMode: Byte; var wCount, wPersonCount: Word; var ErrorInfo: Integer; var btStatus: Byte); stdcall;
function MakeRegisterInfo(btUserMode: Byte; sRegisterName: PChar; wUserCount, wPersonCount: Word; sUserName: PChar; RegisterDate: TDateTime): PChar; stdcall;
function StartRegister(sRegisterInfo, sUserName: PChar): Integer;
function ClearRegisterInfo(): Boolean;
implementation
function ClearRegisterInfo(): Boolean;
begin
  Result := License.Clear;
end;
procedure InitLicense(nVersion: Integer;btStatus: Byte; wCount, wPersonCount: Word; MaxDate: TDateTime; UserName: PChar);
begin
  License := TLicense.Create(nVersion, btStatus, wCount, wPersonCount, MaxDate, UserName);
end;
procedure UnInitLicense();
begin
  License.Destroy;
end;
function GetRegisterName(): String;
begin
  Result := License.RegisterName;
end;
//取许可数据
procedure GetLicense(var UserMode: Byte; var wCount, wPersonCount: Word; var ErrorInfo: Integer; var btStatus: Byte);
begin
  UserMode := License.UserMode;
  wCount := License.Count;
  wPersonCount := License.PersonCount;
  ErrorInfo := License.ErrorInfo;
  btStatus := License.Status;
end;
function MakeRegisterInfo(btUserMode: Byte; sRegisterName: PChar; wUserCount, wPersonCount: Word; sUserName: PChar; RegisterDate: TDateTime): PChar;
begin
  Result := PChar(License.MakeRegisterInfo(btUserMode, StrPas(sRegisterName), wUserCount, wPersonCount, StrPas(sUserName), RegisterDate));
end;
function StartRegister(sRegisterInfo, sUserName: PChar): Integer;
begin
  Result := License.StartRegister(StrPas(sRegisterInfo), StrPas(sUserName));
end;

end.


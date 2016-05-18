unit SysManage;

interface
uses
  Windows, SysUtils, UserLicense, Share, ChinaRAS;
var
  License: TLicense;
procedure InitLicense(nVersion: Integer; btStatus: Byte; wCount, wPersonCount: Word; MaxDate: TDateTime; UserName: PChar);
procedure UnInitLicense();
function GetRegisterName(): String;
procedure GetLicense(var UserMode: Byte; var wCount, wPersonCount: Word; var ErrorInfo: Integer; var btStatus: Byte); stdcall;
function MakeRegisterInfo(btUserMode: Byte; sRegisterName: PChar; wUserCount, wPersonCount: Word; sUserName: PChar; RegisterDate: TDateTime): PChar; stdcall;
function StartRegister(sRegisterInfo, sUserName: PChar): Integer;
function ClearRegisterInfo(): Boolean;
function RegisterName: PChar;//ȡ������
function StartInfoLicense(sRegisterInfo, sUserName: PChar): Integer;//����ע��
implementation

//����ע��
function StartInfoLicense(sRegisterInfo, sUserName: PChar): Integer;
begin
  Result := 0;
  Try
    InitLicense(Version, 0, 0, 0, Date, PChar(IntToStr(Version)));
    Result := StartRegister(sRegisterInfo, sUserName);
    UnInitLicense();
  except
  end;
end;

//ȡ������
function RegisterName: PChar;
begin
  Try
    InitLicense(Version, 0, 0, 0, Date, PChar(IntToStr(Version)));
    Result := PChar(GetRegisterName());
    UnInitLicense();
  except
  end;
end;

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
//ȡ�������
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

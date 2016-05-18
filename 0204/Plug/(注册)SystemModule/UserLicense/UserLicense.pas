unit UserLicense;

interface
uses
  Windows, SysUtils, Classes, Controls, Math, Registry, IniFiles, MD5EncodeStr, {Dialogs,}
  HardInfo, EDcode;
type
  THeader = record
    sDesc: string[10];
    sVersion: string[10];
    n1: Integer;
  end;
  TLicenseInfo = record
    Header: THeader;
    sUserName: string[32];
    btUserMode: Byte; //0未注册用户 1次数限制  2日期限制 3无限用户
    LastDate: TDateTime; //上次使用时间
    wUserCount: Word; //已经使用次数
    wErrorInfo: Word;
    btStatus: Byte; //使用状态 注册状态 和试用状态
  end;
  pTLicenseInfo = ^TLicenseInfo;

  TRegisterCodeOfDay = record
    sUserName: string[32];
    sRegisterCode: string[32]; //存放注册码
    btUserMode: Byte; //0未注册用户 1次数限制  2日期限制 3无限用户
    RegisterDate: TDateTime; //注册时间
    wPersonCount: Word; //人数
    MaxDate: TDate; //到期时间
    wLicDay: Word; //剩余天数
    LastDate: TDateTime; //上次使用时间
  end;
  pTRegisterCodeOfDay = ^TRegisterCodeOfDay;

  TRegisterCodeOfCount = record
    sUserName: string[32];
    sRegisterCode: string[32]; //存放注册码
    btUserMode: Byte; //0未注册用户 1次数限制  2日期限制 3无限用户
    RegisterDate: TDateTime; //注册时间
    wPersonCount: Word; //人数
    wMaxCount: Word; //最大次数
    wLicCount: Word; //剩余次数
    LastDate: TDateTime; //上次使用时间
  end;
  pTRegisterCodeOfCount = ^TRegisterCodeOfCount;

  TRegisterCodeOfUnLimited = record
    sUserName: string[32];
    sRegisterCode: string[32]; //存放注册码
    btUserMode: Byte; //0未注册用户 1次数限制  2日期限制 3无限用户
    RegisterDate: TDateTime; //注册时间
    wPersonCount: Word; //人数
    wMaxCount: Word; //最大次数
    wLicCount: Word; //剩余次数
    LastDate: TDateTime; //上次使用时间
  end;
  pTRegisterCodeOfUnLimited = ^TRegisterCodeOfUnLimited;

  TRegisterCode = record
    RegisterDate: TDateTime; //注册时间
    nRegisterCode: Int64; //存放注册码
    btUserMode: Byte; //0未注册用户 1无限用户
    wPersonCount: Word; //人数
    wUserCount: Word;
    MaxDate: TDateTime; //最后时间
  end;
  pTRegisterCode = ^TRegisterCode;

type
  TLicense = class
  public
    constructor Create(nVersion: Integer; btStatus: Byte; wCount, wPersonCount: Word; MaxDate: TDateTime; UserName: PChar);
    destructor Destroy; override;
    function GetRegisterName(): string;
    function GetRegisterCode(sRegisterName: string): string; overload;
    function GetRegisterCode64(sRegisterCode: string): Int64; overload;
    function ReadRegisterInfo(sRegisterInfo, sUserName: string): Byte; //读取注册信息
    function GetDayCount(MaxDate, MinDate: TDateTime): Cardinal;
    function Clear: Boolean;
    function GetRegisterInfo(sRegisterName: string): string;
    function StartRegister(sRegisterInfo, sUserName: string): Cardinal;
    procedure DecodeUserMessageOfDay(Str: string; var RegisterCodeOfDay: TRegisterCodeOfDay);
    procedure EncodeUserMessageOfDay(sMsg: TRegisterCodeOfDay; var sResult: string);
    procedure DecodeUserMessageOfCount(Str: string; var RegisterCodeOfCount: TRegisterCodeOfCount);
    procedure EncodeUserMessageOfCount(sMsg: TRegisterCodeOfCount; var sResult: string);
    procedure DecodeUserMessageOfUnLimited(Str: string; var RegisterCodeOfUnLimited: TRegisterCodeOfUnLimited);
    procedure EncodeUserMessageOfUnLimited(sMsg: TRegisterCodeOfUnLimited; var sResult: string);
    procedure DecodeUserMessageOfRegister(Str: string; var RegisterCode: TRegisterCode);
    procedure EncodeUserMessageOfRegister(sMsg: TRegisterCode; var sResult: string);
    function MakeRegisterInfo(MaxDate: TDateTime): Boolean; overload;
    function MakeRegisterInfo(btUserMode: Byte; sRegisterName: string; wUserCount, wPersonCount: Word; sUserName: string; RegisterDate: TDateTime): string; overload;
    function LicenseData: Pointer;
  private
    FCriticalSection: TRTLCriticalSection;
    FVersion: Cardinal;
    FStatus: Byte;
    FRegisterName: string;
    FRegisterCode: string;
    FRegisterInfo: string;
    FLicDays: Cardinal;
    FLicCount: Cardinal;
    FUserMode: Cardinal;
    FMaxCount: Cardinal;
    FMaxDate: TDateTime;
    FSubKeyPath: string;
    //FKeyFileName: string;
    FBasicInfo: string;
    FUserInfo: string;
    FUserName: string;
    FLicenseInfo: TLicenseInfo;
    FRegisterCodeOfDay: TRegisterCodeOfDay;
    FRegisterCodeOfCount: TRegisterCodeOfCount;
    FRegisterCodeOfUnLimited: TRegisterCodeOfUnLimited;
    FLicenseData: Pointer;
    FCodeError: Cardinal;
    FCount: Cardinal;
    FPersonCount: Cardinal;
    FRegisterCode64: Int64;
    function myGetWindowsDirectory: string;
    function ReadRegKey(const iMode: Integer; const sPath,
      sKeyName: string; var sResult: string): Boolean;
    function WriteRegKey(const iMode: Integer; const sPath, sKeyName,
      sKeyValue: string): Boolean;
    procedure Lock();
    procedure UnLock();
    procedure IniWriteString(sKey, sRegisterInfo: string);
    function IniReadString(sKey: string; var sResult: string): Boolean;
    procedure UpDate(LicenseInfo: TLicenseInfo);
    procedure UpDateOfDay(RegisterCodeOfDay: TRegisterCodeOfDay);
    procedure UpDateOfCount(RegisterCodeOfCount: TRegisterCodeOfCount);
    procedure UpDateOfUnLimited(RegisterCodeOfUnLimited: TRegisterCodeOfUnLimited);
    function CheckRegisterCode(sRegisterCode: string): Boolean; overload;
    function CheckRegisterCode(nRegisterCode: Int64): Boolean; overload;
    procedure DecodeUserMessage(Str: string; var LicenseInfo: TLicenseInfo);
    procedure EncodeUserMessage(sMsg: TLicenseInfo; var sResult: string);
    function IsRegister(RegisterDate: TDateTime): Boolean;
  published
    property RegisterName: string read FRegisterName;
    property RegisterCode: string read FRegisterCode;
    property UserName: string read FUserName;
    property ErrorInfo: Cardinal read FCodeError;
    property UserMode: Cardinal read FUserMode;
    property Count: Cardinal read FCount;
    property PersonCount: Cardinal read FPersonCount;
    property MaxCount: Cardinal read FMaxCount;
    property Status: Byte read FStatus;
  end;

const
  MyRootKey = HKEY_LOCAL_MACHINE; //注册表根键
  MySubKey = '\Software\Microsoft\Windows\CurrentVersion\Windows UpData\'; //注册表子键
 // KeyFileName = 'UserLicense.ini'; {20071110去掉}
  BasicInfo = 'BasicInfo';
  UserInfo = 'UserInfo';
 // Desc = '240621028';
  Desc = '398432431';
  Version = '2.0.0.0';
  n1 = 2007;
implementation


function CompareLStr(Src, targ: string; compn: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  if compn <= 0 then Exit;
  if Length(Src) < compn then Exit;
  if Length(targ) < compn then Exit;
  Result := True;
  for i := 1 to compn do
    if UpCase(Src[i]) <> UpCase(targ[i]) then begin
      Result := False;
      break;
    end;
end;

// FCodeError 1修改系统时间 2，3 修改注册信息 4注册码错误 5未知错误  6软件类型错误 7机器码错误
constructor TLicense.Create(nVersion: Integer; btStatus: Byte; wCount, wPersonCount: Word; MaxDate: TDateTime; UserName: PChar);
var
  sRegisterInfo: string;
  sRegisterCodeOfCount: string;
  sRegisterCodeOfDay: string;
  sRegisterCodeOfUnLimited: string;
  nCount, nPersonCount: Integer;
begin
  inherited Create;
  InitializeCriticalSection(FCriticalSection);
  FStatus := btStatus;
  FVersion := nVersion;
  nCount := wCount;
  nPersonCount := wPersonCount;
  //FKeyFileName := KeyFileName;
  FBasicInfo := BasicInfo;
  FUserInfo := UserInfo;
  FCodeError := 0;
  FUserName := '';
  sRegisterInfo := '';
  FCount := 0;
  FPersonCount := 0;
  FUserMode := 0;
  FRegisterCode64 := 0;
  FRegisterName := GetRegisterName();//取硬件信息
  FRegisterCode := '';
  FSubKeyPath := MySubKey + FRegisterName + '\';
  FillChar(FLicenseInfo, Sizeof(TLicenseInfo), #0);
  FillChar(FLicenseInfo.Header, Sizeof(THeader), #0);
  FillChar(FRegisterCodeOfDay, Sizeof(TRegisterCodeOfDay), #0);
  FillChar(FRegisterCodeOfCount, Sizeof(TRegisterCodeOfCount), #0);
  FillChar(FRegisterCodeOfUnLimited, Sizeof(TRegisterCodeOfUnLimited), #0);
  if FRegisterName = '' then FCodeError := 7;
  if (not ReadRegKey(1, FSubKeyPath, FBasicInfo, FRegisterInfo)) and (not IniReadString(FBasicInfo, sRegisterInfo)) then begin
    if FStatus > 0 then begin
      FUserMode := FStatus;
      FCount := wCount;
      FPersonCount := wPersonCount;
      FUserName := Trim(StrPas(UserName)) + IntToStr(FVersion);
      FUserName := RivestStr(FUserName);
      MakeRegisterInfo(MaxDate);
      case FUserMode of
        1: UpDateOfCount(FRegisterCodeOfCount);
        2: UpDateOfDay(FRegisterCodeOfDay);
      end;
    end;
    FRegisterInfo := Trim(GetRegisterInfo(FRegisterName));
    WriteRegKey(1, FSubKeyPath, FBasicInfo, FRegisterInfo);
    IniWriteString(FBasicInfo, FRegisterInfo);
  end;
  IniReadString(FBasicInfo, sRegisterInfo);
  if (FCodeError = 0) and CompareLStr(FRegisterInfo, sRegisterInfo, Length(FRegisterInfo)) then begin
    DecodeUserMessage(FRegisterInfo, FLicenseInfo);
    FUserName := FLicenseInfo.sUserName;
    FCodeError := FLicenseInfo.wErrorInfo;
    FStatus := FLicenseInfo.btStatus;
    if FCodeError = 0 then begin
      FLicenseInfo.LastDate := Now;
      Inc(FLicenseInfo.wUserCount);
      FUserMode := FLicenseInfo.btUserMode;
      case FUserMode of
        0: ;
        1: begin //使用次数
            if ReadRegKey(1, FSubKeyPath, FUserInfo, sRegisterCodeOfCount) then begin
              if IniReadString(FUserInfo, sRegisterInfo) and CompareLStr(sRegisterCodeOfCount, sRegisterInfo, Length(sRegisterCodeOfCount)) then begin
                DecodeUserMessageOfCount(sRegisterCodeOfCount, FRegisterCodeOfCount);
                FMaxCount := FRegisterCodeOfCount.wMaxCount;
                if FRegisterCodeOfCount.btUserMode = FUserMode then begin
                  FUserName := FRegisterCodeOfCount.sUserName;
                  FRegisterCode := GetRegisterCode(FRegisterName);
                  FRegisterCode64 := GetRegisterCode64(FRegisterCode);
                  if CheckRegisterCode(FRegisterCodeOfCount.sRegisterCode) then begin
                    if (nCount > 0) and (nPersonCount > 0) then begin
                      if FRegisterCodeOfCount.wLicCount > 0 then begin
                        FCount := FRegisterCodeOfCount.wLicCount;
                        Dec(FRegisterCodeOfCount.wLicCount);
                      end else begin
                        FRegisterCodeOfCount.wLicCount := 0;
                        FCount := 0;
                      end;
                      //if FRegisterCodeOfCount.RegisterDate > Now then FCodeError := 1;
                    end;
                    FCount := FRegisterCodeOfCount.wLicCount;
                    FPersonCount := FRegisterCodeOfCount.wPersonCount;
                  end else FCodeError := 4;
                  UpDateOfCount(FRegisterCodeOfCount);
                end else FCodeError := 5;
              end else FCodeError := 3;
            end else FCodeError := 3;
          end;
        2: begin
            if ReadRegKey(1, FSubKeyPath, FUserInfo, sRegisterCodeOfDay) then begin
              if IniReadString(FUserInfo, sRegisterInfo) and CompareLStr(sRegisterCodeOfDay, sRegisterInfo, Length(sRegisterCodeOfDay)) then begin
                DecodeUserMessageOfDay(sRegisterCodeOfDay, FRegisterCodeOfDay);
                FMaxCount := GetDayCount(FRegisterCodeOfDay.MaxDate, FRegisterCodeOfDay.RegisterDate);
                if FRegisterCodeOfDay.btUserMode = FUserMode then begin
                  FUserName := FRegisterCodeOfDay.sUserName;
                  FRegisterCode := GetRegisterCode(FRegisterName);
                  FRegisterCode64 := GetRegisterCode64(FRegisterCode);
                  if CheckRegisterCode(FRegisterCodeOfDay.sRegisterCode) then begin
                    if FRegisterCodeOfDay.LastDate <= Now then FRegisterCodeOfDay.LastDate := Now else FCodeError := 1;
                    if FRegisterCodeOfDay.RegisterDate > Now then FCodeError := 1;
                    if (FRegisterCodeOfDay.MaxDate > Date) and (FRegisterCodeOfDay.wLicDay > 0) then begin
                      FRegisterCodeOfDay.wLicDay := GetDayCount(FRegisterCodeOfDay.MaxDate, Date);
                      FCount := FRegisterCodeOfDay.wLicDay;
                    end else begin
                      FCount := 0;
                      FRegisterCodeOfDay.wLicDay := 0;
                    end;
                    FPersonCount := FRegisterCodeOfDay.wPersonCount;
                    UpDateOfDay(FRegisterCodeOfDay);
                  end else FCodeError := 4;
                end else FCodeError := 5;
              end else FCodeError := 3;
            end else FCodeError := 3;
          end;
        3: begin
            if ReadRegKey(1, FSubKeyPath, FUserInfo, sRegisterCodeOfUnLimited) then begin
              if IniReadString(FUserInfo, sRegisterInfo) and CompareLStr(sRegisterCodeOfUnLimited, sRegisterInfo, Length(sRegisterCodeOfUnLimited)) then begin
                DecodeUserMessageOfUnLimited(sRegisterCodeOfUnLimited, FRegisterCodeOfUnLimited);
                if FRegisterCodeOfUnLimited.btUserMode = FUserMode then begin
                  FUserName := FRegisterCodeOfUnLimited.sUserName;
                  FRegisterCode := GetRegisterCode(FRegisterName);
                  FRegisterCode64 := GetRegisterCode64(FRegisterCode);
                  if CheckRegisterCode(FRegisterCodeOfUnLimited.sRegisterCode) then begin
                    FPersonCount := FRegisterCodeOfUnLimited.wPersonCount;
                    FCount := High(Word);
                  end else FCodeError := 4;
                end else FCodeError := 5;
              end else FCodeError := 3;
            end else FCodeError := 5;
          end;
        else begin
            FCodeError := 5;
          end;
      end;
    end;
  end else FCodeError := 2;
  FLicenseInfo.wErrorInfo := FCodeError;
  FUserMode := FLicenseInfo.btUserMode;
  FLicenseInfo.sUserName := FUserName;
  UpDate(FLicenseInfo);
end;

destructor TLicense.Destroy;
begin
  if Assigned(FLicenseData) then Dispose(FLicenseData);
  DeleteCriticalSection(FCriticalSection);
  inherited Destroy;
end;
//检查注册码
function TLicense.CheckRegisterCode(nRegisterCode: Int64): Boolean;
begin
  if FRegisterCode64 = nRegisterCode then Result := True else Result := False;
end;

function TLicense.GetRegisterCode64(sRegisterCode: string): Int64;
var
  nRegisterCode: array[1..32] of Integer;
  i, n01, n02, n03, n04: Integer;
  sCode: string;
  nCode: Integer;
begin
  for i := 1 to Length(sRegisterCode) do
    nRegisterCode[i] := Chinese2UniCode(sRegisterCode[i]);
  n01 := 0;
  n02 := 0;
  n03 := 0;
  n04 := 0;
  for i := 1 to 8 do Inc(n01, nRegisterCode[i]);
  for i := 9 to 16 do Inc(n02, nRegisterCode[i]);
  for i := 17 to 24 do Inc(n03, nRegisterCode[i]);
  for i := 25 to 32 do Inc(n04, nRegisterCode[i]);
  sCode := Format('%d%d%d%d', [n01, n02, n03, n04]);
  nCode := Length(sCode);
  if nCode > 18 then sCode := Copy(sCode, 1, 18);
  Result := StrToInt64(sCode);
end;

function TLicense.MakeRegisterInfo(MaxDate: TDateTime): Boolean;
begin
  Result := False;
  GetRegisterCode(FRegisterName);
  case FUserMode of
    1: begin
        FRegisterCodeOfCount.sUserName := FUserName;
        FRegisterCodeOfCount.sRegisterCode := GetRegisterCode(FRegisterName);
        FRegisterCodeOfCount.btUserMode := FUserMode;
        FRegisterCodeOfCount.RegisterDate := Date;
        FRegisterCodeOfCount.wMaxCount := FCount;
        FRegisterCodeOfCount.wLicCount := FCount;
        FRegisterCodeOfCount.wPersonCount := FPersonCount;
        Result := True;
      end;
    2: begin
        FRegisterCodeOfDay.sUserName := FUserName;
        FRegisterCodeOfDay.sRegisterCode := GetRegisterCode(FRegisterName);
        FRegisterCodeOfDay.btUserMode := FUserMode;
        FRegisterCodeOfDay.RegisterDate := Date;
        FRegisterCodeOfDay.MaxDate := MaxDate;
        FRegisterCodeOfDay.wPersonCount := FPersonCount;
        FRegisterCodeOfDay.wLicDay := GetDayCount(MaxDate, Date);
        FRegisterCodeOfDay.LastDate := Now;
        Result := True;
      end;
  end;
end;
//创建注册信息
function TLicense.MakeRegisterInfo(btUserMode: Byte; sRegisterName: string; wUserCount, wPersonCount: Word; sUserName: string; RegisterDate: TDateTime): string;
var
  RegisterCode: pTRegisterCode;
  sRegisterCode: string;
begin
  Result := '';
  FUserName := Trim(sUserName) + IntToStr(FVersion);
  FUserName := RivestStr(FUserName);
  sRegisterCode := GetRegisterCode(sRegisterName);
  New(RegisterCode);
  RegisterCode.RegisterDate := RegisterDate;
  RegisterCode.nRegisterCode := GetRegisterCode64(sRegisterCode);
  RegisterCode.btUserMode := btUserMode; //btUserMode://0未注册用户 1无限用户
  RegisterCode.wPersonCount := wPersonCount;
  RegisterCode.wUserCount := wUserCount;
  RegisterCode.MaxDate := RegisterDate + wUserCount;
  EncodeUserMessageOfRegister(RegisterCode^, Result);
  Dispose(RegisterCode);
end;

function TLicense.IsRegister(RegisterDate: TDateTime): Boolean;
var
  Year1, Month1, Day1: Word;
  Year2, Month2, Day2: Word;
  Hour1, Min1, Sec1, MSec1: Word;
  Hour2, Min2, Sec2, MSec2: Word;
  LocalDateTime: TDateTime;
begin
  Lock();
  case FUserMode of
    1: LocalDateTime := FRegisterCodeOfCount.RegisterDate;
    2: LocalDateTime := FRegisterCodeOfDay.RegisterDate;
    3: LocalDateTime := FRegisterCodeOfUnLimited.RegisterDate;
    else begin
        LocalDateTime := RegisterDate;
      end;
  end;
  DecodeDate(LocalDateTime, Year1, Month1, Day1);
  DecodeDate(RegisterDate, Year2, Month2, Day2);
  DecodeTime(LocalDateTime, Hour1, Min1, Sec1, MSec1);
  DecodeTime(RegisterDate, Hour2, Min2, Sec2, MSec2);
  if (Year1 = Year2) and (Month1 = Month2) and (Day1 = Day2) and (Hour1 = Hour2) and (Min1 = Min2) and (Sec1 = Sec2) then
    Result := True else Result := False;
  UnLock();
end;
//注册函数
function TLicense.StartRegister(sRegisterInfo, sUserName: string): Cardinal;
var
  {RegisterCodeOfCount: TRegisterCodeOfCount;
  RegisterCodeOfDay: TRegisterCodeOfDay;
  RegisterCodeOfUnLimited: TRegisterCodeOfUnLimited;}
  RegisterCode: TRegisterCode;
  sOldUserName: string;
  btOldUserMode: Byte;
  LicenseInfo: pTLicenseInfo;
  nCount: Integer;
begin
  Result := 0;
  nCount := 0;
  // New(LicenseInfo);
   //LicenseInfo^ := FLicenseInfo;
  sOldUserName := FUserName;
  btOldUserMode := FUserMode;
  FUserName := Trim(sUserName) + IntToStr(FVersion);
  FUserName := RivestStr(FUserName);
  DecodeUserMessageOfRegister(sRegisterInfo, RegisterCode);
  FLicenseInfo.sUserName := FUserName;
  FLicenseInfo.btUserMode := RegisterCode.btUserMode;
 // MainOutMessasge('FLicenseInfo.btUserMode: ' + IntToStr(FLicenseInfo.btUserMode), 0);
  FUserMode := FLicenseInfo.btUserMode;
  case FLicenseInfo.btUserMode of
    1: begin //1次数限制
        if not IsRegister(RegisterCode.RegisterDate) then begin
          FRegisterCode := GetRegisterCode(FRegisterName);//FRegisterName 机器码
          FRegisterCode64 := GetRegisterCode64(FRegisterCode);
          if CheckRegisterCode(RegisterCode.nRegisterCode) then begin  //比较注册码是否正确
            //FillChar(RegisterCodeOfCount, Sizeof(TRegisterCodeOfCount), #0);
            FRegisterCodeOfCount.sUserName := FUserName;
            FRegisterCodeOfCount.sRegisterCode := FRegisterCode;
            FRegisterCodeOfCount.btUserMode := RegisterCode.btUserMode;
            FRegisterCodeOfCount.RegisterDate := RegisterCode.RegisterDate;
            FRegisterCodeOfCount.wPersonCount := RegisterCode.wPersonCount;
            if FStatus <= 0 then begin
              Inc(FRegisterCodeOfCount.wMaxCount, RegisterCode.wUserCount);
              Inc(FRegisterCodeOfCount.wLicCount, RegisterCode.wUserCount);
              if FRegisterCodeOfCount.wPersonCount < High(Word) then
                Inc(FRegisterCodeOfCount.wPersonCount, RegisterCode.wPersonCount);
            end else begin
              FRegisterCodeOfCount.wMaxCount := RegisterCode.wUserCount;
              FRegisterCodeOfCount.wLicCount := RegisterCode.wUserCount;
              FRegisterCodeOfCount.wPersonCount := RegisterCode.wPersonCount;
            end;
            FStatus := 0;
            FLicenseInfo.wErrorInfo := 0;
            FLicenseInfo.btStatus := FStatus;
            FLicenseInfo.wUserCount := 0;
            FPersonCount := FRegisterCodeOfCount.wPersonCount;
            FCount := FRegisterCodeOfCount.wLicCount;
            UpDateOfCount(FRegisterCodeOfCount);
            UpDate(FLicenseInfo);
            Result := 1;
          end else Result := 4;
        end else begin
          FLicenseInfo.sUserName := sOldUserName;
          FLicenseInfo.btUserMode := btOldUserMode;
          //FLicenseInfo := LicenseInfo^;
          FLicenseInfo.wErrorInfo := 0;
          //UpDateOfCount(FRegisterCodeOfCount);
          UpDate(FLicenseInfo);
          Result := 2;
        end;
      end;
    2: begin // 2日期限制
        if not IsRegister(RegisterCode.RegisterDate) then begin
          FRegisterCode := GetRegisterCode(FRegisterName);
          FRegisterCode64 := GetRegisterCode64(FRegisterCode);
          if CheckRegisterCode(RegisterCode.nRegisterCode) then begin
            //FillChar(RegisterCodeOfDay, Sizeof(TRegisterCodeOfDay), #0);
            //if FRegisterCodeOfDay.LastDate > Date then begin
            FRegisterCodeOfDay.sUserName := FUserName;
            FRegisterCodeOfDay.sRegisterCode := FRegisterCode;
            FRegisterCodeOfDay.btUserMode := RegisterCode.btUserMode;
            FRegisterCodeOfDay.RegisterDate := RegisterCode.RegisterDate;
            FRegisterCodeOfDay.wPersonCount := RegisterCode.wPersonCount;
            if FStatus <= 0 then begin
              Inc(FRegisterCodeOfDay.wLicDay, RegisterCode.wUserCount);
              if FRegisterCodeOfDay.wPersonCount < High(Word) then begin
                Inc(FRegisterCodeOfDay.wPersonCount, RegisterCode.wPersonCount);
              end else FRegisterCodeOfDay.wPersonCount := High(Word);
              FRegisterCodeOfDay.MaxDate := FRegisterCodeOfDay.RegisterDate + FRegisterCodeOfDay.wLicDay;
            end else begin
              FRegisterCodeOfDay.wLicDay := RegisterCode.wUserCount;
              FRegisterCodeOfDay.MaxDate := RegisterCode.MaxDate;
              FRegisterCodeOfDay.wPersonCount := RegisterCode.wPersonCount;
            end;
            FRegisterCodeOfDay.LastDate := Now;
            FPersonCount := FRegisterCodeOfDay.wPersonCount;
            FCount := FRegisterCodeOfDay.wLicDay;
            FStatus := 0;
            FLicenseInfo.wErrorInfo := 0;
            FLicenseInfo.btStatus := FStatus;
            FLicenseInfo.wUserCount := 0;
            UpDateOfDay(FRegisterCodeOfDay);
            UpDate(FLicenseInfo);
            Result := 1;
            //end else Result := 3;
          end else Result := 4;
        end else begin
          FLicenseInfo.wErrorInfo := 0;
          FLicenseInfo.sUserName := sOldUserName;
          FLicenseInfo.btUserMode := btOldUserMode;
          //UpDateOfDay(FRegisterCodeOfDay);
          UpDate(FLicenseInfo);
          Result := 2;
        end;
      end;
    3: begin //3无限用户
        if not IsRegister(RegisterCode.RegisterDate) then begin
          FRegisterCode := GetRegisterCode(FRegisterName);
          FRegisterCode64 := GetRegisterCode64(FRegisterCode);
          if CheckRegisterCode(RegisterCode.nRegisterCode) then begin
            //FillChar(RegisterCodeOfUnLimited, Sizeof(TRegisterCodeOfUnLimited), #0);
            FUserMode := FLicenseInfo.btUserMode;
            FRegisterCodeOfUnLimited.sUserName := FUserName;
            FRegisterCodeOfUnLimited.sRegisterCode := FRegisterCode;
            FRegisterCodeOfUnLimited.btUserMode := RegisterCode.btUserMode;
            FRegisterCodeOfUnLimited.RegisterDate := RegisterCode.RegisterDate;
            FRegisterCodeOfUnLimited.wPersonCount := RegisterCode.wPersonCount;
            FRegisterCodeOfUnLimited.wLicCount := RegisterCode.wPersonCount;
            FRegisterCodeOfUnLimited.wMaxCount := RegisterCode.wPersonCount;
            FLicenseInfo.wUserCount := 0;
            FLicenseInfo.wErrorInfo := 0;
            FPersonCount := RegisterCode.wPersonCount;
            FCount := RegisterCode.wPersonCount;
            UpDateOfUnLimited(FRegisterCodeOfUnLimited);
            UpDate(FLicenseInfo);
            Result := 1;
          end else Result := 4;
        end else begin
          FLicenseInfo.wErrorInfo := 0;
          FLicenseInfo.sUserName := sOldUserName;
          FLicenseInfo.btUserMode := btOldUserMode;
          //UpDateOfUnLimited(FRegisterCodeOfUnLimited);
          UpDate(FLicenseInfo);
          Result := 2;
        end;
      end;
    else begin
        Result := 5;
      end;
  end;
end;

procedure TLicense.UpDate(LicenseInfo: TLicenseInfo);
var
  sResult: string;
begin
  Lock;
  try
    EncodeUserMessage(LicenseInfo, sResult);
    WriteRegKey(1, FSubKeyPath, FBasicInfo, sResult);
    IniWriteString(FBasicInfo, sResult);
  finally
    UnLock;
  end;
end;

procedure TLicense.UpDateOfCount(RegisterCodeOfCount: TRegisterCodeOfCount);
var
  sResult: string;
begin
  Lock;
  try
    EncodeUserMessageOfCount(RegisterCodeOfCount, sResult);
    WriteRegKey(1, FSubKeyPath, FUserInfo, sResult);
    IniWriteString(FUserInfo, sResult);
  finally
    UnLock;
  end;
end;

procedure TLicense.UpDateOfDay(RegisterCodeOfDay: TRegisterCodeOfDay);
var
  sResult: string;
begin
  Lock;
  try
    EncodeUserMessageOfDay(RegisterCodeOfDay, sResult);
    WriteRegKey(1, FSubKeyPath, FUserInfo, sResult);
    IniWriteString(FUserInfo, sResult);
  finally
    UnLock;
  end;
end;

procedure TLicense.UpDateOfUnLimited(RegisterCodeOfUnLimited: TRegisterCodeOfUnLimited);
var
  sResult: string;
begin
  Lock;
  try
    EncodeUserMessageOfUnLimited(RegisterCodeOfUnLimited, sResult);
    WriteRegKey(1, FSubKeyPath, FUserInfo, sResult);
    IniWriteString(FUserInfo, sResult);
  finally
    UnLock;
  end;
end;

procedure TLicense.DecodeUserMessage(Str: string; var LicenseInfo: TLicenseInfo);
var
  Msg: string;
begin
  try
    Msg := Decry(Str, IntToStr(FVersion));
    DecodeBuffer(Msg, @LicenseInfo, Sizeof(TLicenseInfo));
  except
  end;
end;

procedure TLicense.EncodeUserMessage(sMsg: TLicenseInfo; var sResult: string);
var
  Str: string;
begin
  try
    Str := EncodeBuffer(@sMsg, Sizeof(TLicenseInfo));
    sResult := Encry(Str, IntToStr(FVersion));
  except
  end;
end;

procedure TLicense.DecodeUserMessageOfCount(Str: string; var RegisterCodeOfCount: TRegisterCodeOfCount);
var
  Msg: string;
begin
  try
    Msg := Decry(Str, FUserName);
    DecodeBuffer(Msg, @RegisterCodeOfCount, Sizeof(TRegisterCodeOfCount));
  except
  end;
end;

procedure TLicense.EncodeUserMessageOfCount(sMsg: TRegisterCodeOfCount; var sResult: string);
var
  Str: string;
begin
  try
    Str := EncodeBuffer(@sMsg, Sizeof(TRegisterCodeOfCount));
    sResult := Encry(Str, FUserName);
  except
  end;
end;

procedure TLicense.DecodeUserMessageOfDay(Str: string; var RegisterCodeOfDay: TRegisterCodeOfDay);
var
  Msg: string;
begin
  try
    Msg := Decry(Str, FUserName);
    DecodeBuffer(Msg, @RegisterCodeOfDay, Sizeof(TRegisterCodeOfDay));
  except
  end;
end;

procedure TLicense.EncodeUserMessageOfDay(sMsg: TRegisterCodeOfDay; var sResult: string);
var
  Str: string;
begin
  try
    Str := EncodeBuffer(@sMsg, Sizeof(TRegisterCodeOfDay));
    sResult := Encry(Str, FUserName);
  except
  end;
end;

procedure TLicense.DecodeUserMessageOfUnLimited(Str: string; var RegisterCodeOfUnLimited: TRegisterCodeOfUnLimited);
var
  Msg: string;
begin
  try
    Msg := Decry(Str, FUserName);
    DecodeBuffer(Msg, @RegisterCodeOfUnLimited, Sizeof(TRegisterCodeOfUnLimited));
  except
  end;
end;

procedure TLicense.EncodeUserMessageOfUnLimited(sMsg: TRegisterCodeOfUnLimited; var sResult: string);
var
  Str: string;
begin
  try
    Str := EncodeBuffer(@sMsg, Sizeof(TRegisterCodeOfUnLimited));
    sResult := Encry(Str, FUserName);
  except
  end;
end;

procedure TLicense.DecodeUserMessageOfRegister(Str: string; var RegisterCode: TRegisterCode);
var
  Msg: string;
begin
  try
    Msg := Decry(Str, FUserName);
    DecodeBuffer(Msg, @RegisterCode, Sizeof(TRegisterCode));
  except
  end;
end;

procedure TLicense.EncodeUserMessageOfRegister(sMsg: TRegisterCode; var sResult: string);
var
  Str: string;
begin
  try
    Str := EncodeBuffer(@sMsg, Sizeof(TRegisterCode));
    sResult := Encry(Str, FUserName);
  except
  end;
end;

function TLicense.GetRegisterInfo(sRegisterName: string): string;
var
  LicenseInfo: TLicenseInfo;
begin
  LicenseInfo.Header.sDesc := Desc;
  LicenseInfo.Header.sVersion := Version;
  LicenseInfo.Header.n1 := n1;
  LicenseInfo.sUserName := FUserName;
  LicenseInfo.btUserMode := FUserMode;
  LicenseInfo.LastDate := Now;
  LicenseInfo.wUserCount := 0;
  LicenseInfo.wErrorInfo := 0;
  LicenseInfo.btStatus := FStatus;
  EncodeUserMessage(LicenseInfo, Result);
end;

procedure TLicense.Lock();
begin
  EnterCriticalSection(FCriticalSection);
end;

procedure TLicense.UnLock();
begin
  LeaveCriticalSection(FCriticalSection);
end;
//取硬件信息
function TLicense.GetRegisterName(): string;
var
  sRegisterName, Str, sTempStr: string;
  n64: Int64;
  nLoopCount: Integer;
  boSame: Boolean;
begin
  Lock();
  try
    Str := '';
    sRegisterName := '';

    if sRegisterName = '' then begin
      try
        sRegisterName := Trim(HardInfo.GetScsisn); //硬盘序列号
      except
        sRegisterName := '';
      end;
    end;

    if sRegisterName = '' then begin
      try
        sRegisterName := Trim(HardInfo.GetCPUInfo_); //CPU序列号
      except
        sRegisterName := '';
      end;
    end;

    if sRegisterName = '' then begin
      try
        sRegisterName := Trim(HardInfo.GetAdapterMac(0)); //网卡地址
      except
        sRegisterName := '';
      end;
    end;

    if sRegisterName <> '' then begin
      Str := Encry(sRegisterName, IntToStr(FVersion));
      Result := RivestStr(Str);
    end else Result := '';
  finally
    UnLock();
  end;
end;

function TLicense.GetRegisterCode(sRegisterName: string): string;
var
  Str: string;
  n1, n2, n3: Integer;
  nEncryLength, nRegisterLength: Integer;
begin
  try
    Lock();
    if sRegisterName <> '' then begin
      Str := Encry(sRegisterName, FUserName);
      Result := RivestStr(Str);
    end else Result := '';
  finally
    UnLock();
  end;
end;

function TLicense.CheckRegisterCode(sRegisterCode: string): Boolean;
begin
  if CompareLStr(FRegisterCode, sRegisterCode, Length(FRegisterCode)) then Result := True else Result := False;
end;

function TLicense.LicenseData: Pointer;
begin
  Result := FLicenseData;
end;

function TLicense.ReadRegisterInfo(sRegisterInfo, sUserName: string): Byte; //读取注册信息
{var
  LicenseCodeOfPublic: pTLicenseCodeOfPublic;
  LicenseCodeOfCount: pTLicenseCodeOfCount;
  LicenseCodeOfDay: pTLicenseCodeOfDay;
  LicenseCodeOfNoLimit: pTLicenseCodeOfNoLimit; }
begin
  {FUserName := sUserName;
  New(LicenseCodeOfPublic);
  DecodeUserMessage(Trim(sRegisterInfo), LicenseCodeOfPublic^);
  FUserMode := LicenseCodeOfPublic.btUserMode;
  Result := FUserMode;
  Dispose(LicenseCodeOfPublic);
  if Assigned(FLicenseData) then Dispose(FLicenseData);
  case FUserMode of
    1: begin
        New(LicenseCodeOfCount);
        DecodeUserMessage(sRegisterInfo, LicenseCodeOfCount^);
        New(FLicenseData);
        FLicenseData := LicenseCodeOfCount;
        Dispose(LicenseCodeOfCount);
      end;
    2: begin
        New(LicenseCodeOfDay);
        DecodeUserMessage(sRegisterInfo, LicenseCodeOfDay^);
        New(FLicenseData);
        FLicenseData := LicenseCodeOfDay;
        Dispose(LicenseCodeOfDay);
      end;
    3: begin
        New(LicenseCodeOfNoLimit);
        DecodeUserMessage(sRegisterInfo, LicenseCodeOfNoLimit^);
        New(FLicenseData);
        FLicenseData := LicenseCodeOfNoLimit;
        Dispose(LicenseCodeOfNoLimit);
      end;
  end;}
end;

function TLicense.GetDayCount(MaxDate, MinDate: TDateTime): Cardinal;
var
  Day: LongInt;
begin
  Day := Trunc(MaxDate) - Trunc(MinDate);
  if Day > 0 then Result := Day else Result := 0;
end;

function TLicense.Clear: Boolean;
var
  rRegObject: TRegistry;
  bData: Byte;
  sWindowsDirectory: string;
  boClearRegistry: Boolean;
begin
  rRegObject := TRegistry.Create;
  try
    rRegObject.RootKey := MyRootKey;
    if rRegObject.OpenKey(MySubKey, False) then begin
      if rRegObject.DeleteKey(MySubKey) then boClearRegistry := True else boClearRegistry := False;
    end else boClearRegistry := False;
  finally
    rRegObject.Free;
  end;
  sWindowsDirectory := myGetWindowsDirectory;
  if sWindowsDirectory[Length(sWindowsDirectory)] <> '\' then sWindowsDirectory := sWindowsDirectory + '\';
  if DeleteFile(sWindowsDirectory + FRegisterName + '.ini') and boClearRegistry then Result := True else Result := False;
end;
//______________________________________________________________________________
function TLicense.ReadRegKey(const iMode: Integer; const sPath,
  sKeyName: string; var sResult: string): Boolean;
var
  rRegObject: TRegistry;
begin
  rRegObject := TRegistry.Create;
  Result := False;
  try
    with rRegObject do begin
      RootKey := MyRootKey;
      if OpenKey(sPath, True) then begin
        case iMode of
          1: sResult := Trim(ReadString(sKeyName));
          2: sResult := IntToStr(ReadInteger(sKeyName));
          //3: sResult := ReadBinaryData(sKeyName, Buffer, BufSize);
        end;
        if sResult = '' then Result := False else Result := True;
      end
      else
        Result := False;
      CloseKey;
    end;
  finally
    rRegObject.Free;
  end;
end;
//_____________________________________________________________________//

function TLicense.WriteRegKey(const iMode: Integer; const sPath, sKeyName,
  sKeyValue: string): Boolean;
var
  rRegObject: TRegistry;
  bData: Byte;
begin
  rRegObject := TRegistry.Create;
  try
    with rRegObject do begin
      RootKey := MyRootKey;
      if OpenKey(sPath, True) then begin
        case iMode of
          1: WriteString(sKeyName, sKeyValue);
          2: WriteInteger(sKeyName, StrToInt(sKeyValue));
          3: WriteBinaryData(sKeyName, bData, 1);
        end;
        Result := True;
      end
      else
        Result := False;
      CloseKey;
    end;
  finally
    rRegObject.Free;
  end;
end;
//------------------------------------------------------------------------------
function TLicense.myGetWindowsDirectory: string;
var
  pcWindowsDirectory: PChar;
  dwWDSize: DWORD;
begin
  dwWDSize := MAX_PATH + 1;
  Result := '';
  GetMem(pcWindowsDirectory, dwWDSize);
  try
    if Windows.GetWindowsDirectory(pcWindowsDirectory, dwWDSize) <> 0 then
      Result := pcWindowsDirectory;
  finally
    FreeMem(pcWindowsDirectory);
  end;
end;

function TLicense.IniReadString(sKey: string; var sResult: string): Boolean;
var
  MyIniFile: TInifile;
  sWindowsDirectory: string;
begin
  Result := False;
  sWindowsDirectory := myGetWindowsDirectory;
  if sWindowsDirectory[Length(sWindowsDirectory)] <> '\' then sWindowsDirectory := sWindowsDirectory + '\';
  FileSetAttr(sWindowsDirectory + FRegisterName + '.ini', 0);
  MyIniFile := TInifile.Create(sWindowsDirectory + FRegisterName + '.ini');
  if MyIniFile <> nil then begin
    sResult := Trim(MyIniFile.ReadString(FRegisterName, sKey, ''));
    MyIniFile.Free;
  end;
  if sResult <> '' then Result := True;
end;

procedure TLicense.IniWriteString(sKey, sRegisterInfo: string);
var
  MyIniFile: TInifile;
  sWindowsDirectory: string;
begin
  sWindowsDirectory := myGetWindowsDirectory;
  if sWindowsDirectory[Length(sWindowsDirectory)] <> '\' then sWindowsDirectory := sWindowsDirectory + '\';
  MyIniFile := TInifile.Create(sWindowsDirectory + FRegisterName + '.ini');
  if MyIniFile <> nil then begin
    MyIniFile.WriteString(FRegisterName, sKey, sRegisterInfo);
    MyIniFile.Free;
  end;
  //FileSetAttr(sWindowsDirectory + FKeyFileName, faReadOnly or faSysFile or faHidden);
  FileSetAttr(sWindowsDirectory + FRegisterName + '.ini', faHidden);
end;

initialization

finalization

end.


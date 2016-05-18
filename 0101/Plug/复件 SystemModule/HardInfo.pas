
{***********************************************
*                                              *
*                                              *
*      ���ģ����������ȡCPU��Ӳ�����кţ�CPU��*
*                                              *
*   ���ʡ���ʾ����ˢ����������MAC��ַ����Ϣ    *
*                                              *
*                                              *
*     ��������2005.03.18  ף�Ʒ�          ��   *
*************************************************}

unit HardInfo;

interface

uses
  Windows, SysUtils, Nb30, MSI_CPU, MSI_Storage;

const
  ID_BIT = $200000; // EFLAGS ID bit

type
  TCPUID = array[1..4] of Longint;
  TVendor = array[0..11] of char;

function IsCPUID_Available: Boolean; register; //�ж�CPU���к��Ƿ���ú���
function GetCPUID: TCPUID; assembler; register; //��ȡCPU���кź���
function GetCPUVendor: TVendor; assembler; register; //��ȡCPU�������Һ���
function GetCPUInfo: string; //CPU���к�(��ʽ�����ַ���)
function GetCPUSpeed: Double; //��ȡCPU�ٶȺ���
function GetDisplayFrequency: Integer; //��ȡ��ʾ��ˢ����
function GetScsisn: string; //��ȡIDEӲ�����кź���
function MonthMaxDay(year, month: Integer): Integer; //��ȡĳ��ĳ�µ��������
function GetAdapterMac(ANo: Integer): string;
function MacAddress: string;//����Mac��ַ 20080703
function GetCPUInfo_: string;
function GetDiskSerialNumber: string;

implementation

//����Mac��ַ
function MacAddress: string;
var
  Lib: Cardinal;
  Func: function(GUID: PGUID): Longint; stdcall;
  GUID1, GUID2: TGUID;
begin
  Result := '';
  Lib := LoadLibrary('rpcrt4.dll');
  if Lib <> 0 then
  begin
    if Win32Platform <>VER_PLATFORM_WIN32_NT then
      @Func := GetProcAddress(Lib, 'UuidCreate')
      else @Func := GetProcAddress(Lib, 'UuidCreateSequential');
    if Assigned(Func) then 
    begin
      if (Func(@GUID1) = 0) and 
        (Func(@GUID2) = 0) and 
        (GUID1.D4[2] = GUID2.D4[2]) and
        (GUID1.D4[3] = GUID2.D4[3]) and 
        (GUID1.D4[4] = GUID2.D4[4]) and 
        (GUID1.D4[5] = GUID2.D4[5]) and
        (GUID1.D4[6] = GUID2.D4[6]) and 
        (GUID1.D4[7] = GUID2.D4[7]) then
      begin 
        Result := 
         IntToHex(GUID1.D4[2], 2) + '-' +
         IntToHex(GUID1.D4[3], 2) + '-' + 
         IntToHex(GUID1.D4[4], 2) + '-' +
         IntToHex(GUID1.D4[5], 2) + '-' + 
         IntToHex(GUID1.D4[6], 2) + '-' + 
         IntToHex(GUID1.D4[7], 2);
      end; 
    end;
    FreeLibrary(Lib);
  end;
end;

function GetDiskSerialNumber: string;
var
  Storage: TStorage;
begin
  Result := '';
  Storage := TStorage.Create;
  Storage.GetInfo;
  if Storage.DeviceCount > 0 then begin
    Result := Storage.Devices[0].SerialNumber;
  end;
  Storage.Free;
end;

function GetCPUInfo_: string;
var
  CPU: TCPU;
begin
  CPU := TCPU.Create;
  CPU.GetInfo();
  Result := CPU.SerialNumber;
  CPU.Free;
end;

function IsCPUID_Available: Boolean; register;
asm
    PUSHFD {direct access to flags no possible, only via stack}
    POP EAX {flags to EAX}
    MOV EDX,EAX {save current flags}
    XOR EAX,ID_BIT {not ID bit}
    PUSH EAX {onto stack}
    POPFD {from stack to flags, with not ID bit}
    PUSHFD {back to stack}
    POP EAX {get back to EAX}
    XOR EAX,EDX {check if ID bit affected}
    JZ @exit {no, CPUID not availavle}
    MOV AL,True {Result=True}
    @exit:
end;



function GetCPUID: TCPUID; assembler; register;
asm
    PUSH    EBX         {Save affected register}
    PUSH    EDI
    MOV     EDI,EAX     {@Resukt}
    MOV     EAX,1
    DW      $A20F       {CPUID Command}
    STOSD                {CPUID[1]}
    MOV     EAX,EBX
    STOSD               {CPUID[2]}
    MOV     EAX,ECX
    STOSD               {CPUID[3]}
    MOV     EAX,EDX
    STOSD               {CPUID[4]}
    POP     EDI         {Restore registers}
    POP     EBX
end;

function GetCPUVendor: TVendor; assembler; register;
//��ȡCPU�������Һ���
//���÷���:EDIT.TEXT:='Current CPU Vendor:'+GetCPUVendor;
asm
      PUSH EBX {Save affected register}
      PUSH EDI
      MOV EDI,EAX {@Result (TVendor)}
      MOV EAX,0
      DW $A20F {CPUID Command}
      MOV EAX,EBX
      XCHG EBX,ECX {save ECX result}
      MOV ECX,4
      @1:
      STOSB
      SHR EAX,8
      LOOP @1
      MOV EAX,EDX
      MOV ECX,4
      @2:
      STOSB
      SHR EAX,8
      LOOP @2
      MOV EAX,EBX
      MOV ECX,4
      @3:
      STOSB
      SHR EAX,8
      LOOP @3
      POP EDI {Restore registers}
      POP EBX
end;

function GetCPUInfo: string;
var
  CPUID: TCPUID;
  I: Integer;
  S: TVendor;
begin
  for I := Low(CPUID) to High(CPUID) do CPUID[I] := -1;
  if IsCPUID_Available then begin
    CPUID := GetCPUID;
    S := GetCPUVendor;
    Result := IntToHex(CPUID[1], 8)
      + '-' + IntToHex(CPUID[2], 8)
      + '-' + IntToHex(CPUID[3], 8)
      + '-' + IntToHex(CPUID[4], 8);
  end
  else Result := 'CPUID not available';
end;


function GetCPUSpeed: Double;
//��ȡCPU���ʺ���
//���÷���:EDIT.TEXT:='Current CPU Speed:'+floattostr(GetCPUSpeed)+'MHz';
const
  DelayTime = 500; // ʱ�䵥λ�Ǻ���
var
  TimerHi, TimerLo: DWORD;
  PriorityClass, Priority: Integer;
begin
  PriorityClass := GetPriorityClass(GetCurrentProcess);
  Priority := GetThreadPriority(GetCurrentThread);
  SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);
  Sleep(10);
  asm
        dw 310Fh // rdtsc
        mov TimerLo, eax
        mov TimerHi, edx
  end;
  Sleep(DelayTime);
  asm
        dw 310Fh // rdtsc
        sub eax, TimerLo
        sbb edx, TimerHi
        mov TimerLo, eax
        mov TimerHi, edx
  end;

  SetThreadPriority(GetCurrentThread, Priority);
  SetPriorityClass(GetCurrentProcess, PriorityClass);
  Result := TimerLo / (1000.0 * DelayTime);
end;

function GetDisplayFrequency: Integer;
// ����������ص���ʾˢ��������HzΪ��λ��
//���÷���:EDIT.TEXT:='Current DisplayFrequency:'+inttostr(GetDisplayFrequency)+' Hz';
var
  DeviceMode: TDeviceMode;
begin
  EnumDisplaySettings(nil, Cardinal(-1), DeviceMode);
  Result := DeviceMode.dmDisplayFrequency;
end;


//����Ҽӷְɣ������������ڲ�Ӳ�����кŵģ����ԶԸ�IDE / SCSI�ġ�

//��getscsisn�ȿɵõ�Ӳ�����к�


function GetIdeDiskSerialNumber: pchar;
//��ȡ��һ��IDEӲ�̵����к�
//���÷�����EDIT.TEXT:='HardDriver SerialNumber:'+strpas(GetIdeSerialNumber);
const IDENTIFY_BUFFER_SIZE = 512;
type
  TIDERegs = packed record
    bFeaturesReg: BYTE; // Used for specifying SMART "commands".
    bSectorCountReg: BYTE; // IDE sector count register
    bSectorNumberReg: BYTE; // IDE sector number register
    bCylLowReg: BYTE; // IDE low order cylinder value
    bCylHighReg: BYTE; // IDE high order cylinder value
    bDriveHeadReg: BYTE; // IDE drive/head register
    bCommandReg: BYTE; // Actual IDE command.
    bReserved: BYTE; // reserved for future use.  Must be zero.
  end;
  TSendCmdInParams = packed record
    // Buffer size in bytes
    cBufferSize: DWORD;
    // Structure with drive register values.
    irDriveRegs: TIDERegs;
    // Physical drive number to send command to (0,1,2,3).
    bDriveNumber: BYTE;
    bReserved: array[0..2] of BYTE;
    dwReserved: array[0..3] of DWORD;
    bBuffer: array[0..0] of BYTE; // Input buffer.
  end;
  TIdSector = packed record
    wGenConfig: Word;
    wNumCyls: Word;
    wReserved: Word;
    wNumHeads: Word;
    wBytesPerTrack: Word;
    wBytesPerSector: Word;
    wSectorsPerTrack: Word;
    wVendorUnique: array[0..2] of Word;
    sSerialNumber: array[0..19] of char;
    wBufferType: Word;
    wBufferSize: Word;
    wECCSize: Word;
    sFirmwareRev: array[0..7] of char;
    sModelNumber: array[0..39] of char;
    wMoreVendorUnique: Word;
    wDoubleWordIO: Word;
    wCapabilities: Word;
    wReserved1: Word;
    wPIOTiming: Word;
    wDMATiming: Word;
    wBS: Word;
    wNumCurrentCyls: Word;
    wNumCurrentHeads: Word;
    wNumCurrentSectorsPerTrack: Word;
    ulCurrentSectorCapacity: DWORD;
    wMultSectorStuff: Word;
    ulTotalAddressableSectors: DWORD;
    wSingleWordDMA: Word;
    wMultiWordDMA: Word;
    bReserved: array[0..127] of BYTE;
  end;
  PIdSector = ^TIdSector;
  TDriverStatus = packed record
    // ���������صĴ�����룬�޴��򷵻�0
    bDriverError: BYTE;
    // IDE����Ĵ��������ݣ�ֻ�е�bDriverError Ϊ SMART_IDE_ERROR ʱ��Ч
    bIDEStatus: BYTE;
    bReserved: array[0..1] of BYTE;
    dwReserved: array[0..1] of DWORD;
  end;
  TSendCmdOutParams = packed record
    // bBuffer�Ĵ�С
    cBufferSize: DWORD;
    // ������״̬
    DriverStatus: TDriverStatus;
    // ���ڱ�������������������ݵĻ�������ʵ�ʳ�����cBufferSize����
    bBuffer: array[0..0] of BYTE;
  end;
var hDevice: THandle;
  cbBytesReturned: DWORD;
  SCIP: TSendCmdInParams;
  aIdOutCmd: array[0..(SizeOf(TSendCmdOutParams) + IDENTIFY_BUFFER_SIZE - 1) - 1] of BYTE;
  IdOutCmd: TSendCmdOutParams absolute aIdOutCmd;
  procedure ChangeByteOrder(var Data; Size: Integer);
  var ptr: pchar;
    I: Integer;
    c: char;
  begin
    ptr := @Data;
    for I := 0 to (Size shr 1) - 1 do begin
      c := ptr^;
      ptr^ := (ptr + 1)^;
      (ptr + 1)^ := c;
      Inc(ptr, 2);
    end;
  end;
begin
  Result := ''; // ��������򷵻ؿմ�
  try
  if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then begin // Windows NT, Windows 2000
    // ��ʾ! �ı����ƿ���������������������ڶ����������� '\\.\PhysicalDrive1\'
    hDevice := CreateFile('\\.\PhysicalDrive0', GENERIC_READ or GENERIC_WRITE,
      FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  end else // Version Windows 95 OSR2, Windows 98
    hDevice := CreateFile('\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0);
  if hDevice = INVALID_HANDLE_VALUE then Exit;
  try
    FillChar(SCIP, SizeOf(TSendCmdInParams) - 1, #0);
    FillChar(aIdOutCmd, SizeOf(aIdOutCmd), #0);
    cbBytesReturned := 0;
    // Set up data structures for IDENTIFY command.
    with SCIP do begin
      cBufferSize := IDENTIFY_BUFFER_SIZE;
      //      bDriveNumber := 0;
      with irDriveRegs do begin
        bSectorCountReg := 1;
        bSectorNumberReg := 1;
        //      if Win32Platform=VER_PLATFORM_WIN32_NT then bDriveHeadReg := $A0
        //      else bDriveHeadReg := $A0 or ((bDriveNum and 1) shl 4);
        bDriveHeadReg := $A0;
        bCommandReg := $EC;
      end;
    end;
    if not DeviceIoControl(hDevice, $0007C088, @SCIP, SizeOf(TSendCmdInParams) - 1,
      @aIdOutCmd, SizeOf(aIdOutCmd), cbBytesReturned, nil) then Exit;
  finally
    CloseHandle(hDevice);
  end;
  with PIdSector(@IdOutCmd.bBuffer)^ do begin
    ChangeByteOrder(sSerialNumber, SizeOf(sSerialNumber));
    (pchar(@sSerialNumber) + SizeOf(sSerialNumber))^ := #0;
    Result := pchar(@sSerialNumber);
  end;
  except
  end;
  // ������� S.M.A.R.T. ioctl ����Ϣ�ɲ鿴:
  // http://www.microsoft.com/hwdev/download/respec/iocltapi.rtf
  // MSDN����Ҳ��һЩ�򵥵�����
  // Windows Development -> Win32 Device Driver Kit ->
  // SAMPLE: SmartApp.exe Accesses SMART stats in IDE drives
  // �����Բ鿴 http://www.mtgroup.ru/~alexk
  // IdeInfo.zip - һ���򵥵�ʹ����S.M.A.R.T. Ioctl API��DelphiӦ�ó���
  // ע��:
  // WinNT/Win2000 - �����ӵ�ж�Ӳ�̵Ķ�/д����Ȩ��
  // Win98
  // SMARTVSD.VXD ���밲װ�� \windows\system\iosubsys
  // (��Ҫ�����ڸ��ƺ���������ϵͳ)
end;

function ScsiHddSerialNumber(DeviceHandle: THandle): string;
{$ALIGN ON}
type
  TScsiPassThrough = record
    Length: Word;
    ScsiStatus: BYTE;
    PathId: BYTE;
    TargetId: BYTE;
    Lun: BYTE;
    CdbLength: BYTE;
    SenseInfoLength: BYTE;
    DataIn: BYTE;
    DataTransferLength: ULONG;
    TimeOutValue: ULONG;
    DataBufferOffset: DWORD;
    SenseInfoOffset: ULONG;
    Cdb: array[0..15] of BYTE;
  end;
  TScsiPassThroughWithBuffers = record
    spt: TScsiPassThrough;
    bSenseBuf: array[0..31] of BYTE;
    bDataBuf: array[0..191] of BYTE;
  end;
  {ALIGN OFF}
var dwReturned: DWORD;
  len: DWORD;
  Buffer: array[0..255] of BYTE;
  sptwb: TScsiPassThroughWithBuffers absolute Buffer;
begin
  Result := '';
  Try
  FillChar(Buffer, SizeOf(Buffer), #0);
  with sptwb.spt do begin
    Length := SizeOf(TScsiPassThrough);
    CdbLength := 6; // CDB6GENERIC_LENGTH
    SenseInfoLength := 24;
    DataIn := 1; // SCSI_IOCTL_DATA_IN
    DataTransferLength := 192;
    TimeOutValue := 2;
    DataBufferOffset := pchar(@sptwb.bDataBuf) - pchar(@sptwb);
    SenseInfoOffset := pchar(@sptwb.bSenseBuf) - pchar(@sptwb);
    Cdb[0] := $12; // OperationCode := SCSIOP_INQUIRY;
    Cdb[1] := $01; // Flags := CDB_INQUIRY_EVPD;  Vital product data
    Cdb[2] := $80; // PageCode            Unit serial number
    Cdb[4] := 192; // AllocationLength
  end;
  len := sptwb.spt.DataBufferOffset + sptwb.spt.DataTransferLength;
  if DeviceIoControl(DeviceHandle, $0004D004, @sptwb, SizeOf
    (TScsiPassThrough), @sptwb, len, dwReturned, nil)
    and ((pchar(@sptwb.bDataBuf) + 1)^ = #$80)
    then
    SetString(Result, pchar(@sptwb.bDataBuf) + 4,
      Ord((pchar(@sptwb.bDataBuf) + 3)^));
  except
  end;    
end;

function GetDeviceHandle(sDeviceName: string): THandle;
begin
  Result := CreateFile(pchar('\\.\' + sDeviceName),
    GENERIC_READ or GENERIC_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE,
    nil, OPEN_EXISTING, 0, 0)
end;

//(3)ȡ ��һ����(C:\) ���к�
function GetVolumeSerialNumber: string;
var
  I, j: Integer;
  SerialNum: DWORD;
  a, b: DWORD;
  Buffer1: array[0..255] of char; //������
begin
  // ȡ��һ�����̷�
  GetSystemDirectory(Buffer1, SizeOf(Buffer1));
  for I := 0 to 255 do
    if Buffer1[I] = ':' then begin
      break;
    end;
  for j := I + 2 to 255 do
    Buffer1[j] := #0;

  //ȡ ��һ����(C:\) ���к�
  if GetVolumeInformation(Buffer1, nil, 0, @SerialNum, b, a, nil, 0) then
    Result := IntToStr(SerialNum)
  else Result := '';
end;

function GetScsisn: string;
var
  sSerNum, sDeviceName: string;
//  rc: DWORD;
  hDevice: THandle;
begin
  sDeviceName := 'C:';
  hDevice := GetDeviceHandle(sDeviceName);
  if hDevice <> INVALID_HANDLE_VALUE then try
    sSerNum := Trim(GetIdeDiskSerialNumber);
    if sSerNum = '' then
      sSerNum := Trim(ScsiHddSerialNumber(hDevice));
    Result := sSerNum;
  finally
    CloseHandle(hDevice);
  end;
end;

function MonthMaxDay(year, month: Integer): Integer; //��ȡĳ��ĳ���������
begin
  case month of
    1, 3, 5, 7, 8, 10, 12: Result := 31; //����1��3��5��7��8��10��12�����Ϊ31��
    2: if (year mod 4 = 0) and (year mod 100 <> 0) or (year mod 400 = 0) then Result := 29
      else Result := 28; //��������2����29�죬����2�����Ϊ28��
    else Result := 30; //������4��6��9��11���������Ϊ30��
  end;
end;


function GetAdapterMac(ANo: Integer): string;
//��ȡ������MAC��ַ
var
  Ncb: TNcb;
  Adapter: TAdapterStatus;
  Lanaenum: TLanaenum;
  IntIdx: Integer; //
  cRc: char;
  StrTemp: string;
begin
  Result := '';
  try
    ZeroMemory(@Ncb, SizeOf(Ncb));
    Ncb.ncb_command := Chr(NCbenum);
    NetBios(@Ncb);
    Ncb.ncb_buffer := @Lanaenum; //�ٴ���enum����
    Ncb.ncb_length := SizeOf(Lanaenum);
    cRc := NetBios(@Ncb);
    if Ord(cRc) <> 0 then Exit;
    ZeroMemory(@Ncb, SizeOf(Ncb)); //����������
    Ncb.ncb_command := Chr(NcbReset);
    Ncb.ncb_lana_num := Lanaenum.lana[ANo];
    cRc := NetBios(@Ncb);
    if Ord(cRc) <> 0 then Exit;
    //�õ�������״̬
    ZeroMemory(@Ncb, SizeOf(Ncb));
    Ncb.ncb_command := Chr(NcbAstat);
    Ncb.ncb_lana_num := Lanaenum.lana[ANo];
    StrPcopy(Ncb.ncb_callname, '*');
    Ncb.ncb_buffer := @Adapter;
    Ncb.ncb_length := SizeOf(Adapter);
    NetBios(@Ncb);
    //��mac��ַת�����ַ������
    StrTemp := '';
    for IntIdx := 0 to 5 do
      StrTemp := StrTemp + IntToHex(Integer(Adapter.adapter_address[IntIdx]), 2);
    Result := StrTemp;
  finally
  end;
end;

end.


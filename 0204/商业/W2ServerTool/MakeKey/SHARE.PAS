unit share;

interface

uses Windows, SysUtils, Des, DESTR, ChinaRAS;

Type
  TRecinfo = record//插件自身信息记录
    PlugName: string[50];//插件名称
    StartLoadPlugSucced: string[50];//加载成功信息
    StartLoadPlugFail: string[50];//加载失败信息
    UnLoadPlug: string[50];//卸载信息
    GameShowUrl: String[150];//注册窗口显示的信息
    BakGameListURL: string[50];//注册用户(即密钥)
  end;

const
  RecInfoSize = Sizeof(TRecinfo);//TRecinfo所占用的字节数
  MsgProc = 398432431; //过客的Q号,与M2相对应(M2Share.pas Version = 398432431)
  Version = MsgProc;
//将输入的信息写入插件尾部
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
//释放资源文件
procedure ReleaseRes(const ResName, ResType, FileName: PChar);
//假字符串加解密函数 20071225
Function EncryptText(Text: String): String;
//字符串加解密函数 20071225
Function SetRelease(Text: String): String;

function DecodeString_3des(Source, Key: string): string;
function EncodeString_3des(Source, Key: string): string;
procedure DecodeBuffer(Src: string; Buf: PChar; bufsize: Integer);
function EncodeBuffer(Buf: PChar; bufsize: Integer): string;

function EncodeMD5(str: string): string;
function DecodeMD5(str: string): string;
function Chinese2UniCode(AiChinese: string): Integer;
function Decry(Src, Key: string): string;
function Encry(Src, Key: string): string;

var
  nRegisterCode:Integer;
  boEnterKey: Boolean;
  nCheckCode:Integer;
implementation

//释放资源文件
procedure ReleaseRes(const ResName, ResType, FileName: PChar);
var
  HResource, HGlobal, HFile: THandle;
  FSize, WSize: DWORD;
  FMemory: Pointer;
begin
  HResource := FindResource(HInstance, ResName, ResType); //FindResource在模块中寻找资源
  if (HResource = 0) then Exit;
  HGlobal := LoadResource(HInstance, HResource); //LoadResource返回资源句柄,该函数装载指定资源到全局存储器
  if (HGlobal = 0) then Exit;
  FMemory := LockResource(HGlobal); //LockResource锁定内存中的指定资源,参数:被装载的资源的句柄
  if (FMemory = nil) then begin
    FreeResource(HGlobal); //FreeResource释放用LoadResource函数装载资源
    Exit;
  end;
  HFile := CreateFile(FileName, GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
          //CreateFile建立、打开或截断文件
  if (HFile = INVALID_HANDLE_VALUE) then begin
    UnlockResource(HGlobal); //UnlockResource该函数已过时。这个函数仅兼容于16位的Windows，对于32位的应用程序不必要解锁资源。
    FreeResource(HGlobal);
    Exit;
  end;
  FSize := SizeOfResource(HInstance, HResource);//SizeOfResource返回资源大小
  //参数：hModule：包合资源的可执行文件模块的句柄,hResInfo：资源句柄。此句柄必须由函数FindResource或FindResourceEx来创建
  WriteFile(HFile, FMemory^, FSize, Wsize, nil);
  if (FSize <> Wsize) then begin
    UnlockResource(HGlobal);
    FreeResource(HGlobal);
    Exit;
  end;
  SetEndofFile(HFile);//SetEndofFile设置文本尾指针
  CloseHandle(HFile);  //关闭打开的对象句柄
  UnlockResource(HGlobal);
  FreeResource(HGlobal);
end;

//假字符串加解密函数 20071225
Function EncryptText(Text: String): String;
Begin
  Result := Text;
End;

//字符串加解密函数 20071225
Function SetRelease(Text: String): String;
Var
  I: Word;
  C: Word;
Begin
  Result := '';
  For I := 1 To Length(Text) Do Begin
    C := Ord(Text[I]);
    Result := Result + Chr((C Xor 15));
  End;
End;

function DecodeString_3des(Source, Key: string): string;
var
  Decode: TDCP_3des;
begin
  try
    Result := '';
    Decode := TDCP_3des.Create(nil);
    Decode.InitStr(Key);
    Decode.Reset;
    Result := Decode.DecryptString(Source);
    Decode.Reset;
    Decode.Free;
  except
    Result := '';
  end;
end;

function EncodeString_3des(Source, Key: string): string;
var
  Encode: TDCP_3des;
begin
  try
    Result := '';
    Encode := TDCP_3des.Create(nil);
    Encode.InitStr(Key);
    Encode.Reset;
    Result := Encode.EncryptString(Source);
    Encode.Reset;
    Encode.Free;
  except
    Result := '';
  end;
end;

//-----------------------------------------------------------------------
procedure Encode6BitBuf(pSrc, pDest: PChar; nSrcLen, nDestLen: Integer);
var
  I, nRestCount, nDestPos: Integer;
  btMade, btCh, btRest: Byte;
begin
  nRestCount := 0;
  btRest := 0;
  nDestPos := 0;
  for I := 0 to nSrcLen - 1 do begin
    if nDestPos >= nDestLen then Break;
    btCh := Byte(pSrc[I]);
    btMade := Byte((btRest or (btCh shr (2 + nRestCount))) and $3F);
    btRest := Byte(((btCh shl (8 - (2 + nRestCount))) shr 2) and $3F);
    Inc(nRestCount, 2);

    if nRestCount < 6 then begin
      pDest[nDestPos] := Char(btMade + $3C);
      Inc(nDestPos);
    end else begin
      if nDestPos < nDestLen - 1 then begin
        pDest[nDestPos] := Char(btMade + $3C);
        pDest[nDestPos + 1] := Char(btRest + $3C);
        Inc(nDestPos, 2);
      end else begin
        pDest[nDestPos] := Char(btMade + $3C);
        Inc(nDestPos);
      end;
      nRestCount := 0;
      btRest := 0;
    end;
  end;
  if nRestCount > 0 then begin
    pDest[nDestPos] := Char(btRest + $3C);
    Inc(nDestPos);
  end;
  pDest[nDestPos] := #0;
end;

procedure Decode6BitBuf(sSource: PChar; pBuf: PChar; nSrcLen, nBufLen: Integer);
const
  Masks: array[2..6] of Byte = ($FC, $F8, $F0, $E0, $C0);
  //($FE, $FC, $F8, $F0, $E0, $C0, $80, $00);
var
  I, {nLen,} nBitPos, nMadeBit, nBufPos: Integer;
  btCh, btTmp, btByte: Byte;
begin
  //  nLen:= Length (sSource);
  nBitPos := 2;
  nMadeBit := 0;
  nBufPos := 0;
  btTmp := 0;
  btCh := 0;//20080521
  for I := 0 to nSrcLen - 1 do begin
    if Integer(sSource[I]) - $3C >= 0 then
      btCh := Byte(sSource[I]) - $3C
    else begin
      nBufPos := 0;
      Break;
    end;
    if nBufPos >= nBufLen then Break;
    if (nMadeBit + 6) >= 8 then begin
      btByte := Byte(btTmp or ((btCh and $3F) shr (6 - nBitPos)));
      pBuf[nBufPos] := Char(btByte);
      Inc(nBufPos);
      nMadeBit := 0;
      if nBitPos < 6 then Inc(nBitPos, 2)
      else begin
        nBitPos := 2;
        Continue;
      end;
    end;
    btTmp := Byte(Byte(btCh shl nBitPos) and Masks[nBitPos]); // #### ##--
    Inc(nMadeBit, 8 - nBitPos);
  end;
  pBuf[nBufPos] := #0;
end;

function EncodeBuffer(Buf: PChar; bufsize: Integer): string;
var
  EncBuf, TempBuf: array[0..10000 - 1] of Char;
begin
  if bufsize < 10000 then begin
    Move(Buf^, TempBuf, bufsize);
    Encode6BitBuf(@TempBuf, @EncBuf, bufsize, SizeOf(EncBuf));
    Result := StrPas(EncBuf);
  end else Result := '';
end;

procedure DecodeBuffer(Src: string; Buf: PChar; bufsize: Integer);
var
  EncBuf: array[0..10000 - 1] of Char;
begin
  Decode6BitBuf(PChar(Src), @EncBuf, Length(Src), SizeOf(EncBuf));
  Move(EncBuf, Buf^, bufsize);
end;

{解密函数}
function EncodeMD5(str: string): string;
var
  EncBuf:array[0..10000 - 1] of Char;
begin
  Decode6BitBuf(PChar(str), @EncBuf,Length(str), SizeOf(EncBuf));
  Result := StrPas (EncBuf);
end;

{加密函数}
function DecodeMD5(str: string): string;
var
  EncBuf:array[0..10000 - 1] of Char;
begin
  Encode6BitBuf(PChar(str), @EncBuf, Length(str), SizeOf(EncBuf));
  Result:=StrPas(EncBuf);
end;

//将输入的信息写入插件尾部
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
var
  TargetFile: file;
begin
  try
    Result := True;
    AssignFile(TargetFile, FilePath);
    FileMode := 2;
    Reset(TargetFile, 1);
    Seek(TargetFile, FileSize(TargetFile));
    BlockWrite(TargetFile, MyRecInfo, RecInfoSize);
    CloseFile(TargetFile);
  except
    Result := False;
  end;
end;

function Chinese2UniCode(AiChinese: string): Integer;
var
  ch, cl: string[2];
  a: array[1..2] of Char;
begin
  StringToWideChar(Copy(AiChinese, 1, 2), @(a[1]), 2);
  ch := IntToHex(Integer(a[2]), 2);
  cl := IntToHex(Integer(a[1]), 2);
  Result := StrToInt('$' + ch + cl);
end;

function ReverseStr(SourceStr: string): string;
var
  Counter: Integer;
begin
  Result := '';
  for Counter := 1 to Length(SourceStr) do
    Result := SourceStr[Counter] + Result;
end;

function Encry(Src, Key: string): string;
var
  sSrc, sKey: string;
begin
  if Key = '' then sKey := IntToStr(0123456789)
  else sKey := Key;
  sSrc := EncryStrHex(Src, sKey);
  Result := ReverseStr(sSrc);
end;

function Decry(Src, Key: string): string;
var
  sSrc, sKey: string;
begin
  try
    if Key = '' then sKey := IntToStr(0123456789)
    else sKey := Key;
    sSrc := ReverseStr(Src);
    Result := DecryStrHex(sSrc, sKey);
  except
    Result := '';
  end;
end;

end.

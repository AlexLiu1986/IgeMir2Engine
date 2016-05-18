unit Share;

interface

uses SysUtils, DESTR, DES;

function DecodeString_3des(Source, Key: string): string;
function EncodeString_3des(Source, Key: string): string;
procedure DecodeBuffer(Src: string; Buf: PChar; bufsize: Integer);
function EncodeBuffer(Buf: PChar; bufsize: Integer): string;

function Chinese2UniCode(AiChinese: string): Integer;
function Decry(Src, Key: string): string;
function Encry(Src, Key: string): string;
var
  nCheckCode:Integer;
  boEnterKey: Boolean;
const
  MsgProc = 398432431; //过客的Q号,与M2相对应(M2Share.pas Version = 398432431)
  Version = MsgProc;
implementation
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

unit wmutil;

interface

uses
  Windows, DXDraws;

type

   TWMImageHeader = record
      Title: String[40];        // 库文件标题 'WEMADE Entertainment inc.'
      ImageCount: integer;      // 图片数量
      ColorCount: integer;      // 色彩数量
      PaletteSize: integer;     // 调色板大小
      VerFlag:integer;
   end;
   PTWMImageHeader = ^TWMImageHeader;

   TWMImageInfo = record
     nWidth    :SmallInt;     // 位图宽度
     nHeight   :SmallInt;     // 位图高度
      px: smallint;
      py: smallint;
      bits: PByte;
   end;
   PTWMImageInfo = ^TWMImageInfo;

   TWMIndexHeader = record
      Title: string[40];        //'WEMADE Entertainment inc.'
      IndexCount: integer;      // 索引总数
      VerFlag:integer;
   end;

   PTWMIndexHeader = ^TWMIndexHeader;

   TWMIndexInfo = record
      Position: integer;
      Size: integer;
   end;
   PTWMIndexInfo = ^TWMIndexInfo;


   TDXImage = record
     nPx          :SmallInt;
     nPy          :SmallInt;
     Surface      :TDirectDrawSurface;
     dwLatestTime :LongWord;
   end;
   pTDxImage = ^TDXImage;


function WidthBytes(w: Integer): Integer;

implementation


function WidthBytes(w: Integer): Integer;
begin
  Result := (((w * 8) + 31) div 32) * 4;
end;


end.

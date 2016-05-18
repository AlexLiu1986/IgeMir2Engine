unit wmutil;

interface

uses
  Windows, DXDraws;

type

   TWMImageHeader = record
      Title: String[40];        // ���ļ����� 'WEMADE Entertainment inc.'
      ImageCount: integer;      // ͼƬ����
      ColorCount: integer;      // ɫ������
      PaletteSize: integer;     // ��ɫ���С
      VerFlag:integer;
   end;
   PTWMImageHeader = ^TWMImageHeader;

   TWMImageInfo = record
     nWidth    :SmallInt;     // λͼ���
     nHeight   :SmallInt;     // λͼ�߶�
      px: smallint;
      py: smallint;
      bits: PByte;
   end;
   PTWMImageInfo = ^TWMImageInfo;

   TWMIndexHeader = record
      Title: string[40];        //'WEMADE Entertainment inc.'
      IndexCount: integer;      // ��������
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

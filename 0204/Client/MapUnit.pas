unit MapUnit;
//��ͼ��Ԫ
{ MAP�ļ��ṹ
    �ļ�ͷ��52�ֽ�
    ��һ�е�һ�ж���
    �ڶ��е�һ�ж���
    �����е�һ�ж���
    ��
    ��
    ��
    ��Width�е�һ�ж���
    ��һ�еڶ��ж���
    ��
    ��
    ��
}
interface

uses
   Windows, Classes, SysUtils, Grobal2, HUtil32, Share;
type
// -------------------------------------------------------------------------------
// Map
// -------------------------------------------------------------------------------
  //.MAP�ļ�ͷ  52bytes
  TMapHeader = packed record
    wWidth      :Word;                 //���      2
    wHeight     :Word;                 //�߶�      2
    sTitle      :String[16];          //����      16
    UpdateDate  :TDateTime;          //��������  8
    Reserved    :array[0..22] of Char;  //����      20
  end;
  //��ͼ�ļ�һ��Ԫ�صĶ���
  TMapInfo = packed record
    wBkImg       :Word;
    wMidImg      :Word;
    wFrImg       :Word;
    btDoorIndex  :Byte;  //$80 (��¦), ���� �ĺ� �ε���
    btDoorOffset :Byte;  //���� ���� �׸��� ��� ��ġ, $80 (����/����(�⺻))
    btAniFrame   :Byte;      //$80(Draw Alpha) +  ������ ��
    btAniTick    :Byte;
    btArea       :Byte;        //���� ����
    btLight      :Byte;       //0..1..4 ���� ȿ��
  end;
  pTMapInfo = ^TMapInfo;

  TMapInfoArr = array[0..MaxListSize] of TMapInfo;
  pTMapInfoArr = ^TMapInfoArr;

  TMap = class
  private
    function  LoadMapInfo(sMapFile:String; var nWidth, nHeight: Integer): Boolean;
    procedure LoadMapArr(nCurrX, nCurrY: integer);
    procedure SaveMapArr(nCurrX,nCurrY:Integer);
  public
    m_sMapBase      :string;
    m_MArr          :array[0..MAXX * 3, 0..MAXY * 3] of TMapInfo;
    m_boChange      :Boolean;
    m_ClientRect    :TRect;
    m_OldClientRect :TRect;
    m_nBlockLeft    :Integer;
    m_nBlockTop     :Integer; //Ÿ�� ��ǥ�� ����, ����� ��ǥ
    m_nOldLeft      :Integer;
    m_nOldTop       :Integer;
    m_sOldMap       :String;
    m_nCurUnitX     :Integer;
    m_nCurUnitY     :Integer;
    m_sCurrentMap   :String;
    m_nSegXCount    :Integer;
    m_nSegYCount    :Integer;
    m_nMapWidth,M_nMapHeight: Word; //20080617 �Զ�Ѱ·�õ�
    constructor Create;
    destructor Destroy;override;//Jacky
    procedure UpdateMapSquare (cx, cy: integer);
    procedure UpdateMapPos (mx, my: integer);
    procedure ReadyReload;
    procedure LoadMap(sMapName:String;nMx,nMy:Integer);
    procedure MarkCanWalk (mx, my: integer; bowalk: Boolean);
    function  CanMove (mx, my: integer): Boolean;
    function  CanFly  (mx, my: integer): Boolean;
    function  GetDoor (mx, my: integer): Integer;
    function  IsDoorOpen (mx, my: integer): Boolean;
    function  OpenDoor (mx, my: integer): Boolean;
    function  CloseDoor (mx, my: integer): Boolean;
  end;

implementation

uses
   ClMain;


constructor TMap.Create;
begin
   inherited Create;
   //GetMem (MInfoArr, sizeof(TMapInfo) * LOGICALMAPUNIT * 3 * LOGICALMAPUNIT * 3);
   m_ClientRect  := Rect (0,0,0,0);
   m_boChange    :=False;
   m_sMapBase    := '.\Map\';    //��ͼ�ļ�����Ŀ¼
   m_sCurrentMap := '';          //��ǰ��ͼ�ļ���������.MAP��
   m_nSegXCount  := 0;
   m_nSegYCount  := 0;
   m_nCurUnitX   := -1;          //��ǰ��Ԫλ��X��Y
   m_nCurUnitY   := -1;
   m_nBlockLeft  := -1;          //��ǰ��X,Y���Ͻ�
   m_nBlockTop   := -1;
   m_sOldMap     := '';          //ǰһ����ͼ�ļ������ڻ���ͼ��ʱ���ã�
end;

destructor TMap.Destroy;
begin
   FillChar(m_MArr, SizeOf(m_MArr), #0);
   inherited Destroy;
end;
//��MAP�ļ��Ŀ�Ⱥ͸߶�
function  TMap.LoadMapInfo (sMapFile:String; var nWidth, nHeight: Integer): Boolean;
var
  sFileName    :String;
  nHandle      :Integer;
  Header       :TMapHeader;
begin
  try
    Result := FALSE;
    sFileName := m_sMapBase + sMapFile;
    if FileExists (sFileName) then begin
      nHandle := FileOpen (sFileName, fmOpenRead or fmShareDenyNone);
      if nHandle > 0 then begin
        FileRead (nHandle, Header, sizeof(TMapHeader));
        nWidth := Header.wWidth;
        nHeight := Header.wHeight;
      end;
      FileClose(nHandle);
    end;
  except
    DebugOutStr('TMap.LoadMapInfo');
  end;
end;

//���ص�ͼ������
//�Ե�ǰ����Ϊ׼
procedure TMap.LoadMapArr(nCurrX,nCurrY: integer);
var
  I         :Integer;
  nAline    :Integer;
  nLx       :Integer;
  nRx       :Integer;
  nTy       :Integer;
  nBy       :Integer;
  sFileName :String;
  nHandle   :Integer;
  Header    :TMapHeader; 
begin
  try
    FillChar(m_MArr, SizeOf(m_MArr), #0);
    sFileName:=m_sMapBase + m_sCurrentMap + '.map';
    if FileExists(sFileName) then begin
      nHandle:=FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
      if nHandle > 0 then begin
        FileRead (nHandle, Header, SizeOf(TMapHeader));
        nLx := (nCurrX - 1) * LOGICALMAPUNIT;
        nRx := (nCurrX + 2) * LOGICALMAPUNIT;    //rx
        nTy := (nCurrY - 1) * LOGICALMAPUNIT;
        nBy := (nCurrY + 2) * LOGICALMAPUNIT;

        if nLx < 0 then nLx := 0;
        if nTy < 0 then nTy := 0;
        if nBy >= Header.wHeight then nBy := Header.wHeight;
        nAline := SizeOf(TMapInfo) * Header.wHeight;     //һ���еĴ�С���ֽ�����
        m_nMapWidth:=Header.wWidth;   //20080617 �Զ�Ѱ·��
        m_nMapHeight:=Header.wHeight;
        for I:=nLx to nRx - 1 do begin      //i����� 3*LOGICALMAPUNIT ֵ,�����Ҫ���µĵ�ͼ������
          if (I >= 0) and (I < Header.wWidth) then begin
           //��ǰ����ΪX,Y����Ӧ��X*ÿ���ֽ���+Y*ÿ���ֽ�����ʼ����һ������
            FileSeek(nHandle, SizeOf(TMapHeader) + (nAline * I) + (SizeOf(TMapInfo) * nTy), 0);
            FileRead(nHandle, m_MArr[I - nLx, 0], SizeOf(TMapInfo) * (nBy - nTy));
          end;
        end;
        FileClose(nHandle);
      end;
    end;
  except
    DebugOutStr('TMap.LoadMapArr');
  end;
end;

procedure TMap.SaveMapArr(nCurrX,nCurrY:Integer);
var
  I         :Integer;
  nAline    :Integer;
  nLx       :Integer;
  nRx       :Integer;
  nTy       :Integer;
  nBy       :Integer; 
  sFileName :String;
  nHandle   :Integer;
  Header    :TMapHeader; 
begin
  try
    FillChar(m_MArr, SizeOf(m_MArr), #0);
    sFileName:=m_sMapBase + m_sCurrentMap + '.map';
    if FileExists(sFileName) then begin
      nHandle:=FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
      if nHandle > 0 then begin
        FileRead (nHandle, Header, SizeOf(TMapHeader));
        nLx := (nCurrX - 1) * LOGICALMAPUNIT;
        nRx := (nCurrX + 2) * LOGICALMAPUNIT;    //rx
        nTy := (nCurrY - 1) * LOGICALMAPUNIT;
        nBy := (nCurrY + 2) * LOGICALMAPUNIT;

        if nLx < 0 then nLx := 0;
        if nTy < 0 then nTy := 0;
        if nBy >= Header.wHeight then nBy := Header.wHeight;
        nAline := SizeOf(TMapInfo) * Header.wHeight;
        m_nMapWidth:=Header.wWidth;  //20080617 �Զ�Ѱ·��
        m_nMapHeight:=Header.wHeight;
        if nRx > 0 then //20080629
        for I:=nLx to nRx - 1 do begin
          if (I >= 0) and (I < Header.wWidth) then begin
            FileSeek(nHandle, SizeOf(TMapHeader) + (nAline * I) + (SizeOf(TMapInfo) * nTy), 0);
            FileRead(nHandle, m_MArr[I - nLx, 0], SizeOf(TMapInfo) * (nBy - nTy));
          end;
        end;
        FileClose(nHandle);
      end;
    end;
  except
    DebugOutStr('TMap.SaveMapArr');
  end;
end;
procedure TMap.ReadyReload;
begin
   m_nCurUnitX := -1;
   m_nCurUnitY := -1;
end;

//cx, cy: λ��, ��LOGICALMAPUNITΪ��λ
procedure TMap.UpdateMapSquare (cx, cy: integer);
begin
  try
    if (cx <> m_nCurUnitX) or (cy <> m_nCurUnitY) then begin
      LoadMapArr(cx, cy);
      m_nCurUnitX := cx;
      m_nCurUnitY := cy;
    end;
  except
    DebugOutStr('TMap.UpdateMapSquare');
  end;
end;

//��ĳ���� �̵��� ����� ȣ��..
procedure TMap.UpdateMapPos (mx, my: integer);    //mx,my��������
var
   cx, cy: integer;       //��ͼ���߼�����
   procedure Unmark (xx, yy: integer);     //xx,yy�����ص�����
   var
      ax, ay: integer;
   begin
      if (cx = xx div LOGICALMAPUNIT) and (cy = yy div LOGICALMAPUNIT) then begin
         ax := xx - m_nBlockLeft;
         ay := yy - m_nBlockTop;
         m_MArr[ax,ay].wFrImg := m_MArr[ax,ay].wFrImg and $7FFF;
         m_MArr[ax,ay].wBkImg := m_MArr[ax,ay].wBkImg and $7FFF;
      end;
   end;
begin
  try
   cx := mx div LOGICALMAPUNIT;       //������߼�����
   cy := my div LOGICALMAPUNIT;
   m_nBlockLeft := _MAX (0, (cx - 1) * LOGICALMAPUNIT);  //��������
   m_nBlockTop  := _MAX (0, (cy - 1) * LOGICALMAPUNIT);

   UpdateMapSquare (cx, cy);

   if (m_nOldLeft <> m_nBlockLeft) or (m_nOldTop <> m_nBlockTop) or (m_sOldMap <> m_sCurrentMap) then begin
      //3���� �����ڸ� ���� ���� (2001-7-3)
      if m_sCurrentMap = '3' then begin
         Unmark (624, 278);
         Unmark (627, 278);
         Unmark (634, 271);
         Unmark (564, 287);
         Unmark (564, 286);
         Unmark (661, 277);
         Unmark (578, 296);
      end;
   end;
   m_nOldLeft := m_nBlockLeft;
   m_nOldTop := m_nBlockTop;
  except
    DebugOutStr('TMap.UpdateMapPos');
  end;
end;

//�ʺ���� ó�� �ѹ� ȣ��..
procedure TMap.LoadMap(sMapName:String;nMx,nMy:Integer);
begin
   m_nCurUnitX   := -1;
   m_nCurUnitY   := -1;
   m_sCurrentMap := sMapName;
   UpdateMapPos(nMx, nMy);
   m_sOldMap := m_sCurrentMap;
end;
//��ǰ���Ƿ��������
procedure TMap.MarkCanWalk (mx, my: integer; bowalk: Boolean);
var
   cx, cy: integer;
begin
  try
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if (cx < 0) or (cy < 0) then exit;
   if bowalk then //������������ߣ���MArr[cx,cy]��ֵ���λΪ0
      Map.m_MArr[cx, cy].wFrImg := Map.m_MArr[cx, cy].wFrImg and $7FFF
   else //���������ߵģ����λΪ1
      Map.m_MArr[cx, cy].wFrImg := Map.m_MArr[cx, cy].wFrImg or $8000;
  except
    DebugOutStr('TMap.MarkCanWalk');
  end;
end;
//��ǰ���ͱ����������ߣ��򷵻���
function  TMap.CanMove (mx, my: integer): Boolean;
var
   cx, cy: integer;
begin
  try
   Result:=False;  //jacky
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if (cx < 0) or (cy < 0) then exit;
   //ǰ���ͱ����������ߣ����λΪ0��
   Result := ((Map.m_MArr[cx, cy].wBkImg and $8000) + (Map.m_MArr[cx, cy].wFrImg and $8000)) = 0;
   if Result then begin //���˻�
      if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin  //��¦�� ����
         if (Map.m_MArr[cx, cy].btDoorOffset and  $80) = 0 then
            Result := FALSE; //���� �� ������.
      end;
   end;
  except
    DebugOutStr('TMap.CanMove');
  end;
end;
//��ǰ�������ߣ��򷵻��档
function  TMap.CanFly(mx, my: integer): Boolean;
var
   cx, cy: integer;
begin
  try
   Result:=False;  //jacky
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if (cx < 0) or (cy < 0) then exit;
   Result := (Map.m_MArr[cx, cy].wFrImg and $8000) = 0;
   if Result then begin //���˻�
      if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin  //��¦�� ����
         if (Map.m_MArr[cx, cy].btDoorOffset and  $80) = 0 then
            Result := FALSE;
      end;
   end;
  except
    DebugOutStr('TMap.CanFly');
  end;
end;
//���ָ��������ŵ�������
function  TMap.GetDoor (mx, my: integer): Integer;
var
   cx, cy: integer;
begin
  try
   Result := 0;
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin   //����
      Result := Map.m_MArr[cx, cy].btDoorIndex and $7F;       //�ŵ������ڵ�7λ
   end;
  except
    DebugOutStr('TMap.GetDoor');
  end;
end;
//�ж����Ƿ��
function  TMap.IsDoorOpen (mx, my: integer): Boolean;
var
   cx, cy: integer;
begin
  try
   Result := FALSE;
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin   //����
      Result := (Map.m_MArr[cx, cy].btDoorOffset and $80 <> 0);
   end;
  except
    DebugOutStr('TMap.IsDoorOpen');
  end;
end;
//����
function  TMap.OpenDoor (mx, my: integer): Boolean;
var
   i, j, cx, cy, idx: integer;
begin
  try
   Result := FALSE;
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if (cx < 0) or (cy < 0) then Exit;
   if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
      idx := Map.m_MArr[cx, cy].btDoorIndex and $7F;
      for i:=cx - 10 to cx + 10 do
         for j:=cy - 10 to cy + 10 do begin
            if (i > 0) and (j > 0) then
               if (Map.m_MArr[i, j].btDoorIndex and $7F) = idx then
                  Map.m_MArr[i, j].btDoorOffset := Map.m_MArr[i, j].btDoorOffset or $80;
         end;
   end;
  except
    DebugOutStr('TMap.OpenDoor');
  end;
end;

function  TMap.CloseDoor (mx, my: integer): Boolean;
var
   i, j, cx, cy, idx: integer;
begin
  try
   Result := FALSE;
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if (cx < 0) or (cy < 0) then Exit;
   if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
      idx := Map.m_MArr[cx, cy].btDoorIndex and $7F;
      for i:=cx-8 to cx+10 do
         for j:=cy-8 to cy+10 do begin
            if (Map.m_MArr[i, j].btDoorIndex and $7F) = idx then
               Map.m_MArr[i, j].btDoorOffset := Map.m_MArr[i, j].btDoorOffset and $7F;
         end;
   end;
  except
    DebugOutStr('TMap.CloseDoor');
  end;
end;

end.

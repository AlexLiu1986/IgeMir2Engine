unit DBToolsShare;

interface
uses Windows,Classes,Grobal2,SysUtils;
var
  n4ADAE4: Integer;
  n4ADAF0: Integer;
  n4ADAE8: Integer;
  n4ADAEC: Integer;
  n4ADAFC: Integer;
  n4ADB04: Integer;
  n4ADB00: Integer;

  //ID�ı���
  g_n472A6C: Integer;
  g_n472A70: Integer;
  g_n472A74: Integer;
  g_boDataDBReady: Boolean; //0x00472A78
  //End
  boHumDBReady: Boolean; //0x4ADB08
  boDataDBReady: Boolean; //0x004ADAF4
  HumDB_CS: TRTLCriticalSection; //0x004ADACC
  MagicList: TList; //ħ���б�
  StdItemList: TList;

  sHeroDB: string = 'HeroDB';//����Դ
  sIDDBFilePath: string = 'D:\Mirserver\LoginSrv\IDDB\ID.DB';
  sHumDBFilePath: string = 'D:\Mirserver\DBServer\FDB\Hum.DB';
  sMirDBFilePath: string = 'D:\Mirserver\DBServer\FDB\Mir.DB';

  function GetMagicName(wMagicId: Word): string;//���ݼ���ID�����������
  function GetMagicId(sMagicName: String): Word;//���ݼ������Ʋ������ID

implementation
//���ݼ���ID�����������
function GetMagicName(wMagicId: Word): string;
var
  i: Integer;
  Magic: pTMagic;
begin
  for i := 0 to MagicList.Count - 1 do begin
    Magic := MagicList.Items[i];
    if Magic <> nil then begin
      if Magic.wMagicId = wMagicId then begin
        Result := Magic.sMagicName;
        break;
      end;
    end;
  end;
end;

//���ݼ������Ʋ������ID
function GetMagicId(sMagicName: String): Word;
var
  i: Integer;
  Magic: pTMagic;
begin
  Result := 0;
  for i := 0 to MagicList.Count - 1 do begin
    Magic := MagicList.Items[i];
    if Magic <> nil then begin
      if CompareText(Magic.sMagicName,sMagicName) = 0 then begin
        Result := Magic.wMagicId;
        break;
      end;
    end;
  end;
end;

initialization
  begin
  InitializeCriticalSection(HumDB_CS);
  MagicList := TList.Create;
  StdItemList := TList.Create;
  end;
finalization
  begin
    DeleteCriticalSection(HumDB_CS);
    MagicList.Free;
    StdItemList.Free;
  end;
end.

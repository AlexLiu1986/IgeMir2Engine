unit NoticeM;

interface
uses
  Classes, SysUtils;
type
  TNoticeMsg = record //0x0C 00491BE9
    sMsg: string;//公告文件路径
    sList: TStringList;
    //bo0C: Boolean;//20080815 注释
  end;
  TNoticeList = array[0..99] of TNoticeMsg;
  TNoticeManager = class
  private
    NoticeList: TNoticeList;
  public
    constructor Create();
    destructor Destroy; override;
    function GetNoticeMsg(sStr: string; LoadList: TStringList): Boolean;
    procedure LoadingNotice();
  end;
implementation

uses M2Share;

{ TNoticeManager }

//00491C9E
constructor TNoticeManager.Create;
var
  I: Integer;
begin
  for I := Low(NoticeList) to High(NoticeList) do begin
    NoticeList[I].sMsg := '';
    NoticeList[I].sList := nil;
    //NoticeList[I].bo0C := True;//20080815 注释
  end;
end;

destructor TNoticeManager.Destroy;
var
  I: Integer;
begin
  for I := Low(NoticeList) to High(NoticeList) do begin
    if NoticeList[I].sList <> nil then NoticeList[I].sList.Free;
  end;
  inherited;
end;
procedure TNoticeManager.LoadingNotice(); //00491D54
var
  sFileName: string;
  I: Integer;
begin
  for I := Low(NoticeList) to High(NoticeList) do begin
    if NoticeList[I].sMsg = '' then Continue;
    sFileName := g_Config.sNoticeDir + NoticeList[I].sMsg + '.txt';
    if FileExists(sFileName) then begin
      try
        if NoticeList[I].sList = nil then NoticeList[I].sList := TStringList.Create;
        NoticeList[I].sList.LoadFromFile(sFileName);
      except
        MainOutMessage('读取文本内容错误,文件名为:' + sFileName);
      end;
    end;
  end;
end;
function TNoticeManager.GetNoticeMsg(sStr: string; LoadList: TStringList): Boolean; //00491EA0
var
  //bo15: Boolean;//20080815 注释
  n14: Integer;
  sFileName: string;
begin
  Result := False;
  //bo15 := True;//20080815 注释
  for n14 := Low(NoticeList) to High(NoticeList) do begin
    if CompareText(NoticeList[n14].sMsg, sStr) = 0 then begin
      if NoticeList[n14].sList <> nil then begin
        LoadList.AddStrings(NoticeList[n14].sList);
        Result := True;
      end;
      //bo15 := False;
      Exit;//20080815 修改
    end;
  end; 
  //if not bo15 then Exit;//20080815 注释
  for n14 := Low(NoticeList) to High(NoticeList) do begin
    if NoticeList[n14].sMsg = '' then begin
      sFileName := g_Config.sNoticeDir + sStr + '.txt';
      if FileExists(sFileName) then begin
        try
          if NoticeList[n14].sList = nil then NoticeList[n14].sList := TStringList.Create;
          NoticeList[n14].sList.LoadFromFile(sFileName);
          LoadList.AddStrings(NoticeList[n14].sList);
        except
          MainOutMessage('读取文本内容错误,文件名为: ' + sFileName);
        end;
        NoticeList[n14].sMsg := sStr;
        Result := True;
        Break;
      end;
    end;
  end;
end;
end.

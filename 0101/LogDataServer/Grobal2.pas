unit Grobal2;

interface
uses
  Windows, SysUtils;

    function IntToString(nInt: Integer): String;

const
  DEFBLOCKSIZE = {16}22;//20081216
  BUFFERSIZE = 10000;
  GS_QUIT = 2000;
  SG_FORMHANDLE=1000;//������HANLD
  SG_STARTNOW=1001;  //��������������...
  SG_STARTOK=1002;   //�������...
type
  TDefaultMessage = record
    Recog: Integer;
    Ident: word;
    Param: word;
    Tag: word;
    Series: word;
  end;
  
implementation

function IntToString(nInt: Integer): String;
begin
  if nInt < 10 then Result := '0' + IntToStr(nInt)
  else Result := IntToStr(nInt);
end;

end.


unit RSADESCrypt;

interface
uses
  Classes, SysUtils, Variants;

  function RSENCRYPT(Str: String): String;
  function RSDECRYPT(Str: String): String;
implementation
 uses FGInt, FGIntPrimeGeneration, FGIntRSA;
 
function RSENCRYPT(Str: String): String;
var
test,b64:string;
e,n:tfgint;
begin
test:=Str;
Base10StringToFGInt('65537', e);
Base10StringToFGInt('88044653761154454781428784943', n);
RSAEncrypt(test, e, n, test);
Str:='';
ConvertBase256to64(test,b64);
Result := b64;
FGIntDestroy(e);
FGIntDestroy(n);

end;

function RSDECRYPT(Str: String): String;
var
test,b64:string;
d,n,nilgint:tfgint;
begin
test:=Str;
ConvertBase64to256(test,b64);
test:='';
Base10StringToFGInt('43759684977985364714029209473', d);
Base10StringToFGInt('88044653761154454781428784943', n);
RSADecrypt(b64, d, n, Nilgint, Nilgint, Nilgint, Nilgint, test);
Result :=test;
FGIntDestroy(d);
FGIntDestroy(n);
FGIntDestroy(nilgint);
end;

end.

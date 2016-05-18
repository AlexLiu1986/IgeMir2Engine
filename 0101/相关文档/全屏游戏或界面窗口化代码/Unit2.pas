unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SUIButton, ExtCtrls, SUIForm, StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Button1: TButton;
    procedure suiButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.suiButton1Click(Sender: TObject);
begin
     form2.Close;
end;

end.

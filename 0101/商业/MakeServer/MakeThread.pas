unit MakeThread;

interface
uses Windows,Classes, SysUtils;

type
  TMakeLoginThread = class(TThread)//登陆器线程
  private
  protected
    procedure Execute;override;
  public
    sData1: string;
    constructor Create(sData: string);
    destructor  Destroy;override;
  end;

  TMakeGateThread = class(TThread)//网关线程
  private
  protected
    procedure Execute;override;
  public
    sData1: string;
    constructor Create(sData: string);
    destructor  Destroy;override;
  end;

var
  MakeLoginThread: TMakeLoginThread;
  MakeGateThread: TMakeGateThread;
implementation
uses Main, Share;

constructor TMakeLoginThread.Create(sData: string);
begin
  inherited  Create(False);
  FreeOnTerminate:= True;
  sData1:= sData;
  Inc(g_nNowMakeUserNum);  //增加 现在有多少个用户在生成
end;

destructor TMakeLoginThread.Destroy;
begin
  inherited;
end;

procedure TMakeLoginThread.Execute;
begin
  FrmMain.MakeLogin(sData1);
  Dec(g_nNowMakeUserNum);  //减少 现在有多少个用户在生成
end;

//-----------------------------------------------------------
constructor TMakeGateThread.Create(sData: string);
begin
  inherited  Create(False);
  FreeOnTerminate:= True;
  sData1:= sData;
  Inc(g_nNowMakeUserNum);  //增加 现在有多少个用户在生成
end;   

destructor TMakeGateThread.Destroy;
begin
  inherited;
end;

procedure TMakeGateThread.Execute;
begin
  FrmMain.MakeGate(sData1);
  Dec(g_nNowMakeUserNum);  //增加 现在有多少个用户在生成
end;

end.

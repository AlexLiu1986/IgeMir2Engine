unit MakeThread;

interface
uses Windows,Classes, SysUtils;

type
  TMakeLoginThread = class(TThread)//��½���߳�
  private
  protected
    procedure Execute;override;
  public
    sData1: string;
    constructor Create(sData: string);
    destructor  Destroy;override;
  end;

  TMakeGateThread = class(TThread)//�����߳�
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
  Inc(g_nNowMakeUserNum);  //���� �����ж��ٸ��û�������
end;

destructor TMakeLoginThread.Destroy;
begin
  inherited;
end;

procedure TMakeLoginThread.Execute;
begin
  FrmMain.MakeLogin(sData1);
  Dec(g_nNowMakeUserNum);  //���� �����ж��ٸ��û�������
end;

//-----------------------------------------------------------
constructor TMakeGateThread.Create(sData: string);
begin
  inherited  Create(False);
  FreeOnTerminate:= True;
  sData1:= sData;
  Inc(g_nNowMakeUserNum);  //���� �����ж��ٸ��û�������
end;   

destructor TMakeGateThread.Destroy;
begin
  inherited;
end;

procedure TMakeGateThread.Execute;
begin
  FrmMain.MakeGate(sData1);
  Dec(g_nNowMakeUserNum);  //���� �����ж��ٸ��û�������
end;

end.

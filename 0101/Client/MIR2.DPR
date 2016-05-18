program mir2;

uses
  Forms,
  Windows,
  sysutils,
  ClMain in 'ClMain.pas' {frmMain},
  DrawScrn in 'DrawScrn.pas',
  IntroScn in 'IntroScn.pas',
  PlayScn in 'PlayScn.pas',
  MapUnit in 'MapUnit.pas',
  FState in 'FState.pas' {FrmDlg},
  ClFunc in 'ClFunc.pas',
  cliUtil in 'cliUtil.pas',
  DWinCtl in 'DWinCtl.pas',
  WIL in 'WIL.pas',
  magiceff in 'magiceff.pas',
  SoundUtil in 'SoundUtil.pas',
  Actor in 'Actor.pas',
  HerbActor in 'HerbActor.pas',
  AxeMon in 'AxeMon.pas',
  clEvent in 'clEvent.pas',
  HUtil32 in 'HUtil32.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  MShare in 'MShare.pas',
  Share in 'Share.pas',
  SDK in '..\SDK\SDK.pas',
  Mpeg in 'Mpeg.pas',
  wmutil in 'wmUtil.pas',
  EDcode in '..\Common\EDcode.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  Splash in 'Splash.pas' {SplashForm},
  Browser in 'Browser.pas' {frmBrowser},
  QuickSearchMap in 'QuickSearchMap.pas',
  DataUnit in 'DataUnit.pas';

{$R *.RES}

var
   dwExStyle : DWORD;
begin
{******************************************************************************}
//Òþ²ØÈÎÎñÀ¸Í¼±ê 20080527
   dwExStyle := GetWindowLong(Application.Handle, GWL_EXSTYLE);
   dwExStyle := dwExStyle + WS_EX_TOOLWINDOW;
   SetWindowLong(Application.Handle, GWL_EXSTYLE, dwExStyle);     
{******************************************************************************}



  Application.Initialize;
  //Application.Title := 'legend of mir';

  Application.CreateForm(TSplashForm, SplashForm);
  //InitObj();

  //g_nThisCRC := CalcFileCRC(Application.ExeName);
  Application.Run;
end.

unit HookToolRes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Spin;

type
  TFrmHookCheck = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    LabelWalkIntrt: TLabel;
    SpinEditWalk: TSpinEdit;
    CheckBoxWalk: TCheckBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    SpinEditRun: TSpinEdit;
    CheckBoxRun: TCheckBox;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    SpinEditHit: TSpinEdit;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    SpinEditSpell: TSpinEdit;
    CheckBoxHit: TCheckBox;
    CheckBoxSpell: TCheckBox;
    GroupBox6: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    CheckBoxDoubleAttack: TCheckBox;
    SpinEditIncErrorCount: TSpinEdit;
    SpinEditDecErrorCount: TSpinEdit;
    CheckBoxUnitActCtrl: TCheckBox;
    CheckBoxKick: TCheckBox;
    EditErrMsg: TEdit;
    CheckBoxWarning: TCheckBox;
    BitBtnVSetup: TBitBtn;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    CheckBoxCheck: TCheckBox;
    ComBoxSpeedHackWarningType: TComboBox;
    Label4: TLabel;
    procedure CheckBoxCheckClick(Sender: TObject);
    procedure CheckBoxWarningClick(Sender: TObject);
    procedure CheckBoxWalkClick(Sender: TObject);
    procedure CheckBoxHitClick(Sender: TObject);
    procedure CheckBoxRunClick(Sender: TObject);
    procedure CheckBoxSpellClick(Sender: TObject);
    procedure BitBtnVSetupClick(Sender: TObject);
    procedure SpinEditWalkChange(Sender: TObject);
    procedure SpinEditHitChange(Sender: TObject);
    procedure SpinEditRunChange(Sender: TObject);
    procedure SpinEditSpellChange(Sender: TObject);
    procedure SpinEditIncErrorCountChange(Sender: TObject);
    procedure SpinEditDecErrorCountChange(Sender: TObject);
    procedure EditErrMsgChange(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
  private
    procedure FCheckBoxCheck(BoolStatrt: Boolean);
    procedure ClearModValue();
  public
  end;

var
  FrmHookCheck: TFrmHookCheck;

implementation
uses GateShare;
{$R *.dfm}

{ TFrmHookCheck }

procedure TFrmHookCheck.FCheckBoxCheck(BoolStatrt: Boolean);
begin
  CheckBoxWalk.Enabled := BoolStatrt;
  CheckBoxHit.Enabled := BoolStatrt;
  CheckBoxRun.Enabled := BoolStatrt;
  CheckBoxSpell.Enabled := BoolStatrt;
  SpinEditWalk.Enabled := BoolStatrt;
  SpinEditHit.Enabled := BoolStatrt;
  SpinEditRun.Enabled := BoolStatrt;
  SpinEditSpell.Enabled := BoolStatrt;
  SpinEditIncErrorCount.Enabled := BoolStatrt;
  SpinEditDecErrorCount.Enabled := BoolStatrt;
end;

procedure TFrmHookCheck.CheckBoxCheckClick(Sender: TObject);
begin
  FCheckBoxCheck(CheckBoxCheck.Checked);
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxWarningClick(Sender: TObject);
begin
  EditErrMsg.Enabled:= CheckBoxWarning.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxWalkClick(Sender: TObject);
begin
  SpinEditWalk.Enabled := CheckBoxWalk.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxHitClick(Sender: TObject);
begin
  SpinEditHit.Enabled := CheckBoxHit.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxRunClick(Sender: TObject);
begin
  SpinEditRun.Enabled := CheckBoxRun.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxSpellClick(Sender: TObject);
begin
  SpinEditSpell.Enabled := CheckBoxSpell.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.BitBtnVSetupClick(Sender: TObject);
begin
  if boStartHookCheck then begin
    CheckBoxWalk.Checked := True;
    SpinEditWalk.Enabled := True;
    CheckBoxHit.Checked := True;
    SpinEditHit.Enabled := True;
    CheckBoxRun.Checked := True;
    SpinEditRun.Enabled := True;
    CheckBoxSpell.Checked := True;
    SpinEditSpell.Enabled := True;
    CheckBoxWarning.Checked := True;
    EditErrMsg.Enabled := True;
  end;
  SpinEditWalk.Value := 550;
  SpinEditHit.Value := 600;
  SpinEditRun.Value := 580;
  SpinEditSpell.Value := 950;
  SpinEditIncErrorCount.Value := 5;
  SpinEditDecErrorCount.Value := 1;
  EditErrMsg.Text := '[提示]: 请爱护游戏环境，关闭加速外挂重新登陆';
  ClearModValue();
end;

procedure TFrmHookCheck.ClearModValue;
begin
  BitBtnOK.Enabled := True;
end;

procedure TFrmHookCheck.SpinEditWalkChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.SpinEditHitChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.SpinEditRunChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.SpinEditSpellChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.SpinEditIncErrorCountChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.SpinEditDecErrorCountChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.EditErrMsgChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.BitBtnCancelClick(Sender: TObject);
begin
  Close();
end;

procedure TFrmHookCheck.BitBtnOKClick(Sender: TObject);
begin
  boStartWalkCheck := CheckBoxWalk.Checked;
  boStartHitCheck := CheckBoxHit.Checked;
  boStartRunCheck := CheckBoxRun.Checked;
  boStartSpellCheck := CheckBoxSpell.Checked;
  boStartWarning := CheckBoxWarning.Checked;
  nIncErrorCount := SpinEditIncErrorCount.Value;
  dwRunTime := SpinEditRun.Value;
  boStartHookCheck := CheckBoxCheck.Checked;
  dwSpellTime := SpinEditSpell.Value;
  nDecErrorCount := SpinEditDecErrorCount.Value;
  dwWalkTime := SpinEditWalk.Value;
  dwHitTime := SpinEditHit.Value;
  sErrMsg := EditErrMsg.Text;
  if Conf <> nil then begin
    Conf.WriteBool(SpeedCheckClass,'CheckSpeed', boStartHookCheck);
    Conf.WriteBool(SpeedCheckClass,'CtrlWalkSpeed', boStartWalkCheck);
    Conf.WriteBool(SpeedCheckClass,'CtrlHitSpeed', boStartHitCheck);
    Conf.WriteBool(SpeedCheckClass,'CtrlRunSpeed', boStartRunCheck);
    Conf.WriteBool(SpeedCheckClass,'CtrlSpellSpeed', boStartSpellCheck);
    Conf.WriteBool(SpeedCheckClass,'SpeedHackWarning', boStartWarning);
    Conf.WriteInteger(SpeedCheckClass,'IncErrorCount', nIncErrorCount);
    Conf.WriteInteger(SpeedCheckClass,'DecErrorCount', nDecErrorCount);
    Conf.WriteString(SpeedCheckClass,'WarningMsg', sErrMsg);
    Conf.WriteInteger(SpeedCheckClass,'HitTime', dwHitTime);
    Conf.WriteInteger(SpeedCheckClass,'WalkTime', dwWalkTime);
    Conf.WriteInteger(SpeedCheckClass,'RunTime', dwRunTime);
    Conf.WriteInteger(SpeedCheckClass,'SpellTime', dwSpellTime);
  end;
  BitBtnOK.Enabled := False;
end;

end.

unit DBTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, StdCtrls, ExtCtrls, Spin;

type
  TfrmDBTool = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    GridMirDBInfo: TStringGrid;
    GroupBox2: TGroupBox;
    GridHumDBInfo: TStringGrid;
    TabSheet2: TTabSheet;
    ButtonStartRebuild: TButton;
    LabelProcess: TLabel;
    TimerShowInfo: TTimer;
    GroupBox3: TGroupBox;
    CheckBoxDelDenyChr: TCheckBox;
    CheckBoxDelAllItem: TCheckBox;
    CheckBoxDelAllSkill: TCheckBox;
    CheckBoxDelBonusAbil: TCheckBox;
    CheckBoxDelLevel: TCheckBox;
    CheckBoxDelMinLevel: TCheckBox;
    EditLevel: TSpinEdit;
    Button1: TButton;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ButtonStartRebuildClick(Sender: TObject);
    procedure TimerShowInfoTimer(Sender: TObject);
    procedure CheckBoxDelDenyChrClick(Sender: TObject);
    procedure CheckBoxDelLevelClick(Sender: TObject);
    procedure CheckBoxDelAllItemClick(Sender: TObject);
    procedure CheckBoxDelAllSkillClick(Sender: TObject);
    procedure CheckBoxDelBonusAbilClick(Sender: TObject);
    procedure EditLevelChange(Sender: TObject);
    procedure CheckBoxDelMinLevelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    procedure RefDBInfo();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

  TBuildDB = class(TThread)
  private
    procedure UpdateProcess();
    { Private declarations }
  protected
    procedure Execute; override;
  end;
var
  frmDBTool: TfrmDBTool;

implementation

uses HumDB, DBShare, Grobal2;
var
  boRebuilding: Boolean = False;
  BuildDB: TBuildDB;
  nProcID: Integer;
  nProcMax: Integer;
  UpdateProcessTick: LongWord;
  boDelDenyChr: Boolean = False;
  boDelAllItem: Boolean = False;
  boDelAllSkill: Boolean = False;
  boDelBonusAbil: Boolean = False;
  boDelLevel: Boolean = False;
  boDelMinLevel: Boolean = False;//删除等级小于指定值的角色 20080816
  boDelNameEorr: Boolean = False;
  nMinLevel: Integer;


{$R *.dfm}

  { TfrmDBTool }

procedure TfrmDBTool.Open;
begin
  RefDBInfo();
  ShowModal;
end;

procedure TfrmDBTool.RefDBInfo;
begin
  try
    if HumDataDB.OpenEx then begin
      GridMirDBInfo.Cells[1, 1] := HumDataDB.m_sDBFileName;
      GridMirDBInfo.Cells[1, 2] := HumDataDB.m_Header.sDesc;
      GridMirDBInfo.Cells[1, 3] := IntToStr(HumDataDB.m_Header.nHumCount);
      GridMirDBInfo.Cells[1, 4] := IntToStr(HumDataDB.m_QuickList.Count);
      GridMirDBInfo.Cells[1, 5] := IntToStr(HumDataDB.m_DeletedList.Count);
      GridMirDBInfo.Cells[1, 6] := DateTimeToStr(HumDataDB.m_Header.dUpdateDate);
    end;
  finally
    HumDataDB.Close();
  end;
  try
    if HumChrDB.OpenEx then begin
      GridHumDBInfo.Cells[1, 1] := HumChrDB.m_sDBFileName;
      GridHumDBInfo.Cells[1, 2] := HumChrDB.m_Header.sDesc;
      GridHumDBInfo.Cells[1, 3] := IntToStr(HumChrDB.m_Header.nHumCount);
      GridHumDBInfo.Cells[1, 4] := IntToStr(HumChrDB.m_QuickList.Count);
      GridHumDBInfo.Cells[1, 5] := IntToStr(HumChrDB.m_DeletedList.Count);
      GridHumDBInfo.Cells[1, 6] := DateTimeToStr(HumChrDB.m_Header.dUpdateDate);
    end;
  finally
    HumChrDB.Close();
  end;
end;

procedure TfrmDBTool.FormCreate(Sender: TObject);
begin
  GridMirDBInfo.Cells[0, 0] := '参数';
  GridMirDBInfo.Cells[1, 0] := '内容';
  GridMirDBInfo.Cells[0, 1] := '文件位置';
  GridMirDBInfo.Cells[0, 2] := '文件标识';
  GridMirDBInfo.Cells[0, 3] := '记录总数';
  GridMirDBInfo.Cells[0, 4] := '有效数量';
  GridMirDBInfo.Cells[0, 5] := '删除数量';
  GridMirDBInfo.Cells[0, 6] := '更新日期';

  GridHumDBInfo.Cells[0, 0] := '参数';
  GridHumDBInfo.Cells[1, 0] := '内容';
  GridHumDBInfo.Cells[0, 1] := '文件位置';
  GridHumDBInfo.Cells[0, 2] := '文件标识';
  GridHumDBInfo.Cells[0, 3] := '记录总数';
  GridHumDBInfo.Cells[0, 4] := '有效数量';
  GridHumDBInfo.Cells[0, 5] := '删除数量';
  GridHumDBInfo.Cells[0, 6] := '更新日期';
end;

procedure TfrmDBTool.ButtonStartRebuildClick(Sender: TObject);
begin
  boAutoClearDB := False;
  boRebuilding := True;
  ButtonStartRebuild.Enabled := False;
  BuildDB := TBuildDB.Create(False);
  BuildDB.FreeOnTerminate := True;
  TimerShowInfo.Enabled := True;
  //
end;

{ TBuildDB }

procedure TBuildDB.Execute;
var
  i: Integer;
  NewChrDB: TFileHumDB;
  NewDataDB: TFileDB;
  sHumDBFile, sMirDBFile: string;
  SrcHumanRCD: THumDataInfo;
  HumRecord: THumInfo;
  nSrcHumIndex: Integer;
begin
  sHumDBFile := sHumDBFilePath + 'NewHum.DB';
  sMirDBFile := sHumDBFilePath + 'NewMir.DB';
  if FileExists(sHumDBFile) then DeleteFile(sHumDBFile);
  if FileExists(sMirDBFile) then DeleteFile(sMirDBFile);

  NewChrDB := TFileHumDB.Create(sHumDBFile);
  NewDataDB := TFileDB.Create(sMirDBFile);
  try
    if HumDataDB.Open and HumChrDB.Open then begin
      nProcID := 0;
      nProcMax := HumDataDB.m_QuickList.Count - 1;
      for i := 0 to HumDataDB.m_QuickList.Count - 1 do begin
        nProcID := i;
        if (HumDataDB.Get(i, SrcHumanRCD) < 0) or (SrcHumanRCD.Data.sChrName = '') or (SrcHumanRCD.Data.sAccount= '') then Continue;
        if boDelNameEorr then begin
          if (HumChrDB.ChrCountOfAccount(SrcHumanRCD.Data.sAccount)<= 0) and (HumChrDB.Index(SrcHumanRCD.Data.sChrName)<=0) then Continue;//检查Hum.DB中是否存在对应的账号,修正乱码数据 20090106
        end;
        if boDelDenyChr then begin
          FillChar(HumRecord, SizeOf(HumRecord), #0);
          nSrcHumIndex := HumChrDB.Index(SrcHumanRCD.Data.sChrName);
          if HumChrDB.GetBy(nSrcHumIndex, HumRecord) then begin
            if HumRecord.boDeleted then Continue;
          end;
        end;
        if boDelMinLevel then begin//删除等级小于指定值的角色 20080816
          if SrcHumanRCD.Data.Abil.Level < nMinLevel then  Continue;
        end;
        if boDelLevel then begin
          FillChar(SrcHumanRCD.Data.Abil, SizeOf(TAbility), #0);
          SrcHumanRCD.Data.sCurMap := '3';
          SrcHumanRCD.Data.wCurX := 330;
          SrcHumanRCD.Data.wCurY := 330;
          SrcHumanRCD.Data.nGold := 0;
          SrcHumanRCD.Data.sHomeMap := '3';
          SrcHumanRCD.Data.wHomeX := 330;
          SrcHumanRCD.Data.wHomeY := 330;
          SrcHumanRCD.Data.btReLevel := 0;
          SrcHumanRCD.Data.sDearName := '';
          SrcHumanRCD.Data.boMaster := False;
          SrcHumanRCD.Data.sDearName := '';
          SrcHumanRCD.Data.btCreditPoint := 0;
          SrcHumanRCD.Data.btMarryCount := 0;
          SrcHumanRCD.Data.sStoragePwd := '';
          SrcHumanRCD.Data.nGameGold := 0;
          SrcHumanRCD.Data.nPKPoint := 0;
        end;

        if boDelAllItem then begin
          FillChar(SrcHumanRCD.Data.HumItems, SizeOf(THumItems), #0);
          FillChar(SrcHumanRCD.Data.BagItems, SizeOf(THumItems), #0);
          FillChar(SrcHumanRCD.Data.StorageItems, SizeOf(THumItems), #0);
          FillChar(SrcHumanRCD.Data.HumAddItems, SizeOf(THumItems), #0);
        end;

        if boDelAllSkill then begin
          FillChar(SrcHumanRCD.Data.HumMagics, SizeOf(THumMagics), #0);
        end;
        if boDelBonusAbil then begin
          FillChar(SrcHumanRCD.Data.BonusAbil, SizeOf(TNakedAbility), #0);
          SrcHumanRCD.Data.nBonusPoint := 0;
        end;

        NewDataDB.Lock;
        try
          if NewDataDB.Index(SrcHumanRCD.Data.sChrName) >= 0 then Continue;
        finally
          NewDataDB.UnLock;
        end;
        FillChar(HumRecord, SizeOf(THumInfo), #0);
        try
          if NewChrDB.Open then begin
            if NewChrDB.ChrCountOfAccount(SrcHumanRCD.Data.sChrName) < 2 then begin
              HumRecord.sChrName := SrcHumanRCD.Data.sChrName;
              HumRecord.sAccount := SrcHumanRCD.Data.sAccount;
              HumRecord.Header.boIsHero:= SrcHumanRCD.Data.boIsHero;//20080916 统一英雄标识
              HumRecord.boDeleted := False;
              HumRecord.btCount := 0;
              HumRecord.Header.sName := SrcHumanRCD.Data.sChrName;
              NewChrDB.Add(HumRecord);
            end;
          end;
        finally
          NewChrDB.Close;
        end;

        try
          if NewDataDB.Open and (NewDataDB.Index(SrcHumanRCD.Data.sChrName) = -1) then begin

            NewDataDB.Add(SrcHumanRCD);
          end;
        finally
          NewDataDB.Close;
        end;
      end;
    end;
  finally
    HumDataDB.Close;
    HumChrDB.Close;
  end;

  NewChrDB.Free;
  NewDataDB.Free;
  boRebuilding := False;

end;

procedure TBuildDB.UpdateProcess;
begin
  if (GetTickCount - UpdateProcessTick > 1000) or (nProcID >= nProcMax) then begin
    UpdateProcessTick := GetTickCount();
    //frmDBTool.LabelProcess.Caption:=IntToStr(nProcID) + '/' + IntToStr(nProcMax);
  end;

end;

procedure TfrmDBTool.TimerShowInfoTimer(Sender: TObject);
begin
  LabelProcess.Caption := IntToStr(nProcID) + '/' + IntToStr(nProcMax);
  if not boRebuilding then begin
    TimerShowInfo.Enabled := False;
    LabelProcess.Caption := '完成！！！';
    ShowMessage('完成！！！');
  end;
end;

procedure TfrmDBTool.CheckBoxDelDenyChrClick(Sender: TObject);
begin
  boDelDenyChr := CheckBoxDelDenyChr.Checked;
end;

procedure TfrmDBTool.CheckBoxDelLevelClick(Sender: TObject);
begin
  boDelLevel := CheckBoxDelLevel.Checked;
end;

procedure TfrmDBTool.CheckBoxDelAllItemClick(Sender: TObject);
begin
  boDelAllItem := CheckBoxDelAllItem.Checked;
end;

procedure TfrmDBTool.CheckBoxDelAllSkillClick(Sender: TObject);
begin
  boDelAllSkill := CheckBoxDelAllSkill.Checked;
end;

procedure TfrmDBTool.CheckBoxDelBonusAbilClick(Sender: TObject);
begin
  boDelBonusAbil := CheckBoxDelBonusAbil.Checked;
end;

procedure TfrmDBTool.EditLevelChange(Sender: TObject);
begin
  nMinLevel:= EditLevel.Value;
end;

procedure TfrmDBTool.CheckBoxDelMinLevelClick(Sender: TObject);
begin
  boDelMinLevel:= CheckBoxDelMinLevel.Checked;
end;

//修复Mir.DB账号与Hum.DB不对应 20081220
procedure TfrmDBTool.Button1Click(Sender: TObject);
var
  i: Integer;
  SrcHumanRCD: THumDataInfo;
  HumRecord: THumInfo;
  nIdx: Integer;
begin
  Button1.Enabled:= False;
  try
    if HumChrDB.Open and HumDataDB.Open then begin
      for I := 0 to HumChrDB.m_QuickList.Count - 1 do begin
        if HumChrDB.GetBy(I, HumRecord) then begin
          nIdx := HumDataDB.Index(HumRecord.sChrName);
          if nIdx >= 0 then begin
            if HumDataDB.Get(nIdx, SrcHumanRCD) >= 0 then begin
              if (SrcHumanRCD.Data.sChrName = '') then Continue;
              if CompareText(HumRecord.sAccount , SrcHumanRCD.Data.sAccount) <> 0 then begin
                SrcHumanRCD.Data.sAccount:= HumRecord.sAccount;
                HumDataDB.Update(nIdx, SrcHumanRCD);
              end;
            end;
          end;
        end;
      end;  
    end;
  finally
    HumDataDB.Close;
    HumChrDB.Close;
    Button1.Enabled:= True;
    ShowMessage('修复Mir.DB完成！！！');
  end;
end;

procedure TfrmDBTool.CheckBox1Click(Sender: TObject);
begin
  boDelNameEorr:= CheckBox1.Checked;
end;

end.

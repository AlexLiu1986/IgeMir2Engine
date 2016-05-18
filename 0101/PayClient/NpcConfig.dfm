object FrmNpcConfig: TFrmNpcConfig
  Left = 171
  Top = 141
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #33050#26412#29983#25104
  ClientHeight = 453
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 4
    Top = 5
    Width = 534
    Height = 443
    Caption = #33050#26412#35774#32622
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 417
      Width = 36
      Height = 12
      Caption = #27604#20363#65306
    end
    object Label2: TLabel
      Left = 112
      Top = 417
      Width = 96
      Height = 12
      Caption = #26412#21306#30701#20449#20195#30721#21495#65306
    end
    object MemoNpc: TMemo
      Left = 8
      Top = 16
      Width = 518
      Height = 387
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object SEdtRatio: TSpinEdit
      Left = 43
      Top = 413
      Width = 62
      Height = 21
      Hint = '1RMB='#22810#23569#20803#23453
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 5
    end
    object BtnMakeNpc: TButton
      Left = 286
      Top = 410
      Width = 75
      Height = 25
      Caption = #29983#25104'(&B)'
      TabOrder = 2
      OnClick = BtnMakeNpcClick
    end
    object BtnSave: TButton
      Left = 368
      Top = 410
      Width = 75
      Height = 25
      Caption = #20445#23384'(&S)'
      TabOrder = 3
      OnClick = BtnSaveClick
    end
    object BtnSelDir: TButton
      Left = 451
      Top = 410
      Width = 75
      Height = 25
      Caption = #36873#25321#36335#24452
      TabOrder = 4
      OnClick = BtnSelDirClick
    end
    object EdtDuanXinNum: TEdit
      Left = 208
      Top = 413
      Width = 73
      Height = 20
      Hint = #35831#21040#25214#25903#20184#21518#21488#26597#30475#24744#30340#30701#20449#20195#30721#21495'('#27880#24847#65306#27492#20195#30721#21495#21482#26377#28155#21152#20102#21306#20197#21518#65292#25165#33021#22312#21518#21488#30475#21040')'#13#10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
  end
end

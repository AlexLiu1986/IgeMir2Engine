object FrmServerValue: TFrmServerValue
  Left = 390
  Top = 315
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #24615#33021#21442#25968#37197#32622
  ClientHeight = 192
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Label18: TLabel
    Left = 8
    Top = 175
    Width = 432
    Height = 12
    Caption = #35843#25972#30340#21442#25968#31435#21363#29983#25928#65292#22312#32447#26102#35831#30830#35748#27492#21442#25968#30340#20316#29992#20877#35843#25972#65292#20081#35843#25972#23558#23548#33268#28216#25103#28151#20081
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 368
    Top = 144
    Width = 91
    Height = 25
    Caption = #30830#23450'(&O)'
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object CbViewHack: TCheckBox
    Left = 152
    Top = 136
    Width = 161
    Height = 17
    Caption = #26174#31034#28216#25103#36895#24230#24322#24120#20449#24687
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = CbViewHackClick
  end
  object CkViewAdmfail: TCheckBox
    Left = 152
    Top = 152
    Width = 209
    Height = 17
    Caption = #26174#31034#38750#27861#30331#24405#20449#24687
    TabOrder = 2
    OnClick = CkViewAdmfailClick
  end
  object GroupBox1: TGroupBox
    Left = 152
    Top = 8
    Width = 169
    Height = 121
    Caption = #32593#20851#25968#25454#20256#36755
    TabOrder = 3
    object Label8: TLabel
      Left = 11
      Top = 24
      Width = 66
      Height = 12
      Caption = #25968#25454#22359#22823#23567':'
    end
    object Label7: TLabel
      Left = 9
      Top = 48
      Width = 66
      Height = 12
      Caption = #33258#26816#25968#25454#22359':'
    end
    object Label9: TLabel
      Left = 7
      Top = 69
      Width = 66
      Height = 12
      Caption = #20445#30041#25968#25454#22359':'
      Enabled = False
    end
    object Label10: TLabel
      Left = 7
      Top = 93
      Width = 54
      Height = 12
      Caption = #36127#36733#27979#35797':'
    end
    object Label11: TLabel
      Left = 145
      Top = 24
      Width = 6
      Height = 12
      Caption = 'B'
    end
    object Label12: TLabel
      Left = 145
      Top = 48
      Width = 6
      Height = 12
      Caption = 'B'
    end
    object Label13: TLabel
      Left = 145
      Top = 72
      Width = 6
      Height = 12
      Caption = 'B'
    end
    object Label14: TLabel
      Left = 145
      Top = 96
      Width = 12
      Height = 12
      Caption = 'KB'
    end
    object EGateLoad: TSpinEdit
      Left = 78
      Top = 92
      Width = 59
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = EGateLoadChange
    end
    object EAvailableBlock: TSpinEdit
      Left = 78
      Top = 68
      Width = 59
      Height = 21
      Enabled = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = EAvailableBlockChange
    end
    object ECheckBlock: TSpinEdit
      Left = 78
      Top = 44
      Width = 59
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = ECheckBlockChange
    end
    object ESendBlock: TSpinEdit
      Left = 78
      Top = 21
      Width = 59
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = ESendBlockChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 161
    Caption = #22788#29702#26102#38388#20998#37197'('#27627#31186')'
    TabOrder = 4
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 54
      Height = 12
      Caption = #20154#29289#22788#29702':'
    end
    object Label2: TLabel
      Left = 16
      Top = 40
      Width = 54
      Height = 12
      Caption = #24618#29289#22788#29702':'
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 54
      Height = 12
      Caption = #24618#29289#21047#26032':'
    end
    object Label4: TLabel
      Left = 16
      Top = 88
      Width = 54
      Height = 12
      Caption = #25968#25454#20256#36755':'
    end
    object Label5: TLabel
      Left = 16
      Top = 136
      Width = 48
      Height = 12
      Caption = 'NPC'#22788#29702':'
    end
    object Label6: TLabel
      Left = 16
      Top = 112
      Width = 54
      Height = 12
      Caption = #20445#30041#22788#29702':'
      Enabled = False
    end
    object EHum: TSpinEdit
      Left = 76
      Top = 13
      Width = 47
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = EHumChange
    end
    object EMon: TSpinEdit
      Left = 76
      Top = 37
      Width = 47
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = EMonChange
    end
    object EZen: TSpinEdit
      Left = 76
      Top = 61
      Width = 47
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = EZenChange
    end
    object ESoc: TSpinEdit
      Left = 76
      Top = 85
      Width = 47
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = ESocChange
    end
    object ENpc: TSpinEdit
      Left = 76
      Top = 133
      Width = 47
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 0
      OnChange = ENpcChange
    end
    object EDec: TSpinEdit
      Left = 76
      Top = 109
      Width = 47
      Height = 21
      Enabled = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 328
    Top = 8
    Width = 129
    Height = 89
    Caption = #24618#29289#22788#29702#25511#21046
    TabOrder = 5
    object Label15: TLabel
      Left = 8
      Top = 16
      Width = 54
      Height = 12
      Caption = #21047#24618#20493#25968':'
    end
    object Label16: TLabel
      Left = 8
      Top = 64
      Width = 54
      Height = 12
      Caption = #22788#29702#38388#38548':'
    end
    object Label17: TLabel
      Left = 8
      Top = 40
      Width = 54
      Height = 12
      Caption = #21047#24618#38388#38548':'
    end
    object EditZenMonRate: TSpinEdit
      Left = 68
      Top = 13
      Width = 47
      Height = 21
      MaxValue = 1000
      MinValue = 0
      TabOrder = 0
      Value = 1
      OnChange = EditZenMonRateChange
    end
    object EditProcessTime: TSpinEdit
      Left = 68
      Top = 61
      Width = 47
      Height = 21
      Increment = 10
      MaxValue = 1000
      MinValue = 0
      TabOrder = 1
      Value = 1
      OnChange = EditProcessTimeChange
    end
    object EditZenMonTime: TSpinEdit
      Left = 68
      Top = 37
      Width = 47
      Height = 21
      Increment = 10
      MaxValue = 1000
      MinValue = 0
      TabOrder = 2
      Value = 1
      OnChange = EditZenMonTimeChange
    end
  end
  object ButtonDefault: TButton
    Left = 368
    Top = 112
    Width = 89
    Height = 25
    Caption = #40664#35748#35774#32622
    TabOrder = 6
    OnClick = ButtonDefaultClick
  end
end

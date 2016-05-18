object frmDBTool: TfrmDBTool
  Left = 392
  Top = 251
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25968#25454#31649#29702#24037#20855
  ClientHeight = 296
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 577
    Height = 273
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #25968#25454#24211#20449#24687
      object GroupBox1: TGroupBox
        Left = 8
        Top = 4
        Width = 273
        Height = 233
        Caption = #20154#29289#20449#24687#25968#25454#24211'(Mir.DB)'
        TabOrder = 0
        object GridMirDBInfo: TStringGrid
          Left = 8
          Top = 16
          Width = 257
          Height = 201
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 10
          TabOrder = 0
          ColWidths = (
            64
            181)
        end
      end
      object GroupBox2: TGroupBox
        Left = 288
        Top = 4
        Width = 273
        Height = 233
        Caption = #20154#29289#25968#25454#24211'(Hum.DB)'
        TabOrder = 1
        object GridHumDBInfo: TStringGrid
          Left = 8
          Top = 16
          Width = 257
          Height = 201
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 10
          TabOrder = 0
          ColWidths = (
            64
            181)
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25968#25454#24211#37325#24314
      ImageIndex = 1
      object LabelProcess: TLabel
        Left = 8
        Top = 224
        Width = 84
        Height = 13
        Caption = 'LabelProcess'
      end
      object ButtonStartRebuild: TButton
        Left = 8
        Top = 8
        Width = 75
        Height = 25
        Caption = #24320#22987'(&S)'
        TabOrder = 0
        OnClick = ButtonStartRebuildClick
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 48
        Width = 201
        Height = 145
        Caption = #37325#24314#36873#39033
        TabOrder = 1
        object CheckBoxDelDenyChr: TCheckBox
          Left = 9
          Top = 16
          Width = 145
          Height = 17
          Caption = #21024#38500#24050#31105#29992#30340#35282#33394
          TabOrder = 0
          OnClick = CheckBoxDelDenyChrClick
        end
        object CheckBoxDelAllItem: TCheckBox
          Left = 9
          Top = 48
          Width = 113
          Height = 17
          Caption = #21024#38500#20154#29289#29289#21697
          TabOrder = 1
          OnClick = CheckBoxDelAllItemClick
        end
        object CheckBoxDelAllSkill: TCheckBox
          Left = 9
          Top = 64
          Width = 113
          Height = 17
          Caption = #21024#38500#20154#29289#25216#33021
          TabOrder = 2
          OnClick = CheckBoxDelAllSkillClick
        end
        object CheckBoxDelBonusAbil: TCheckBox
          Left = 9
          Top = 80
          Width = 113
          Height = 17
          Caption = #21024#38500#20154#29289#23646#24615#28857
          TabOrder = 3
          OnClick = CheckBoxDelBonusAbilClick
        end
        object CheckBoxDelLevel: TCheckBox
          Left = 9
          Top = 32
          Width = 184
          Height = 17
          Caption = #21024#38500#20154#29289#31561#32423#21450#30456#20851#20449#24687
          TabOrder = 4
          OnClick = CheckBoxDelLevelClick
        end
        object CheckBoxDelMinLevel: TCheckBox
          Left = 10
          Top = 99
          Width = 183
          Height = 17
          Caption = #21024#38500#31561#32423#23567#20110'        '#35282#33394
          TabOrder = 5
          OnClick = CheckBoxDelMinLevelClick
        end
        object EditLevel: TSpinEdit
          Left = 111
          Top = 96
          Width = 50
          Height = 22
          MaxLength = 1
          MaxValue = 65535
          MinValue = 10
          TabOrder = 6
          Value = 10
          OnChange = EditLevelChange
        end
        object CheckBox1: TCheckBox
          Left = 9
          Top = 120
          Width = 168
          Height = 17
          Caption = #21024#38500#20081#30721#25968#25454#35282#33394
          TabOrder = 7
          OnClick = CheckBox1Click
        end
      end
      object Button1: TButton
        Left = 424
        Top = 8
        Width = 129
        Height = 25
        Hint = #26816#26597'Hum.DB'#19982'Mir.DB'#36134#21495#26159#21542#27491#30830','#38656#35201#26381#21153#20572#27490#21518#25165#33021#36827#34892','
        Caption = #20462#22797'Mir.DB'#30331#38470#36134#21495
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Button1Click
      end
    end
  end
  object TimerShowInfo: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerShowInfoTimer
    Left = 144
    Top = 32
  end
end

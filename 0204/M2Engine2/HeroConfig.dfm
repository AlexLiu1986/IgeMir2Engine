object frmHeroConfig: TfrmHeroConfig
  Left = 421
  Top = 149
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #33521#38596#35774#32622
  ClientHeight = 431
  ClientWidth = 485
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Label3: TLabel
    Left = 10
    Top = 256
    Width = 168
    Height = 12
    Caption = #21507#26222#36890#33647#38388#38548'          ('#27627#31186')'
  end
  object Label50: TLabel
    Left = 180
    Top = 256
    Width = 66
    Height = 12
    Caption = 'HP        %'
  end
  object Label51: TLabel
    Left = 249
    Top = 256
    Width = 66
    Height = 12
    Caption = 'MP        %'
  end
  object Label55: TLabel
    Left = 16
    Top = 22
    Width = 114
    Height = 12
    Caption = '0'#32423' HP'#65306'          %'
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 485
    Height = 431
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412#35774#32622
      object Label57: TLabel
        Left = 8
        Top = 386
        Width = 150
        Height = 12
        Caption = #33521#38596'HP'#20493#25968#65306'        /1000'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object GroupBoxLevelExp: TGroupBox
        Left = 4
        Top = 0
        Width = 176
        Height = 184
        Caption = #21319#32423#32463#39564
        TabOrder = 0
        object Label37: TLabel
          Left = 11
          Top = 162
          Width = 30
          Height = 12
          Caption = #35745#21010':'
        end
        object ComboBoxLevelExp: TComboBox
          Left = 48
          Top = 157
          Width = 121
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 0
          OnClick = ComboBoxLevelExpClick
        end
        object GridLevelExp: TStringGrid
          Left = 8
          Top = 16
          Width = 161
          Height = 137
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 1001
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
          TabOrder = 1
          OnSetEditText = GridLevelExpSetEditText
          ColWidths = (
            64
            67)
          RowHeights = (
            18
            18
            19
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18)
        end
      end
      object GroupBox8: TGroupBox
        Left = 184
        Top = 0
        Width = 129
        Height = 35
        Caption = #26432#24618#32463#39564#20998#37197
        TabOrder = 1
        object Label23: TLabel
          Left = 11
          Top = 14
          Width = 54
          Height = 12
          Caption = #20998#37197#27604#20363':'
        end
        object EditKillMonExpRate: TSpinEdit
          Left = 68
          Top = 10
          Width = 53
          Height = 21
          Hint = #33509#33521#38596#20998#37197'40'#21363'40%,'#20154#29289#23601#21482#33021#20998#21040'60%'#32463#39564
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 40
          OnChange = EditKillMonExpRateChange
        end
      end
      object GroupBox29: TGroupBox
        Left = 184
        Top = 35
        Width = 129
        Height = 54
        Caption = #20986#36523#31561#32423
        TabOrder = 2
        object Label61: TLabel
          Left = 6
          Top = 14
          Width = 66
          Height = 12
          Caption = #30333#26085#38376#33521#38596':'
        end
        object Label38: TLabel
          Left = 19
          Top = 35
          Width = 54
          Height = 12
          Caption = #21351#40857#33521#38596':'
        end
        object EditStartLevel: TSpinEdit
          Left = 68
          Top = 10
          Width = 52
          Height = 21
          Hint = #20154#29289#36215#22987#31561#32423#12290#30333#26085#38376#33521#38596
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditStartLevelChange
        end
        object EditDrinkHeroStartLevel: TSpinEdit
          Left = 68
          Top = 31
          Width = 52
          Height = 21
          Hint = #20154#29289#36215#22987#31561#32423#12290#37202#39302#39046#21462#30340#33521#38596
          MaxValue = 65535
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditDrinkHeroStartLevelChange
        end
      end
      object GroupBox59: TGroupBox
        Left = 320
        Top = 35
        Width = 137
        Height = 84
        Caption = #25915#20987#36895#24230
        TabOrder = 3
        object Label131: TLabel
          Left = 8
          Top = 16
          Width = 60
          Height = 12
          Caption = #25112#22763#36895#24230#65306
        end
        object Label132: TLabel
          Left = 8
          Top = 40
          Width = 60
          Height = 12
          Caption = #27861#24072#36895#24230#65306
        end
        object Label133: TLabel
          Left = 8
          Top = 64
          Width = 60
          Height = 12
          Caption = #36947#22763#36895#24230#65306
        end
        object SpinEditWarrorAttackTime: TSpinEdit
          Left = 72
          Top = 12
          Width = 57
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 100000
          MinValue = 400
          TabOrder = 0
          Value = 400
          OnChange = SpinEditWarrorAttackTimeChange
        end
        object SpinEditWizardAttackTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 57
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 10000
          MinValue = 400
          TabOrder = 1
          Value = 400
          OnChange = SpinEditWizardAttackTimeChange
        end
        object SpinEditTaoistAttackTime: TSpinEdit
          Left = 72
          Top = 60
          Width = 57
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 10000
          MinValue = 400
          TabOrder = 2
          Value = 400
          OnChange = SpinEditTaoistAttackTimeChange
        end
      end
      object ButtonHeroExpSave: TButton
        Left = 377
        Top = 371
        Width = 79
        Height = 28
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonHeroExpSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 320
        Top = 119
        Width = 137
        Height = 67
        Caption = #21253#35065#35774#32622
        TabOrder = 5
        object Label1: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #38656#35201#31561#32423':'
        end
        object SpinEditNeedLevel: TSpinEdit
          Left = 68
          Top = 40
          Width = 53
          Height = 21
          Hint = #25351#23450#21253#35065#25968#38656#35201#30340#31561#32423#12290
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = SpinEditNeedLevelChange
        end
        object ComboBoxBagItemCount: TComboBox
          Left = 8
          Top = 16
          Width = 113
          Height = 20
          ItemHeight = 12
          TabOrder = 1
          Text = #36873#25321#21253#35065#25968
          OnChange = ComboBoxBagItemCountChange
          Items.Strings = (
            '10'#26684
            '20'#26684
            '30'#26684
            '35'#26684
            '40'#26684)
        end
      end
      object GroupBox2: TGroupBox
        Left = 4
        Top = 184
        Width = 311
        Height = 62
        Caption = #33521#38596#21507#33647
        TabOrder = 6
        object Label124: TLabel
          Left = 176
          Top = 17
          Width = 66
          Height = 12
          Caption = 'HP        %'
        end
        object Label125: TLabel
          Left = 247
          Top = 17
          Width = 60
          Height = 12
          Caption = 'MP       %'
        end
        object Label40: TLabel
          Left = 6
          Top = 17
          Width = 162
          Height = 12
          Caption = #21507#26222#36890#33647#38388#38548'           '#27627#31186
        end
        object Label52: TLabel
          Left = 6
          Top = 39
          Width = 162
          Height = 12
          Caption = #21507#29305#27530#33647#38388#38548'           '#27627#31186
        end
        object Label53: TLabel
          Left = 176
          Top = 39
          Width = 66
          Height = 12
          Caption = 'HP        %'
        end
        object Label54: TLabel
          Left = 247
          Top = 39
          Width = 60
          Height = 12
          Caption = 'MP       %'
        end
        object SpinEditEatHPItemRate: TSpinEdit
          Left = 192
          Top = 13
          Width = 42
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 60
          OnChange = SpinEditEatHPItemRateChange
        end
        object SpinEditEatMPItemRate: TSpinEdit
          Left = 259
          Top = 13
          Width = 42
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 60
          OnChange = SpinEditEatMPItemRateChange
        end
        object SpinEditEatItemTick: TSpinEdit
          Left = 80
          Top = 13
          Width = 59
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = SpinEditEatItemTickChange
        end
        object SpinEditEatItemTick1: TSpinEdit
          Left = 80
          Top = 35
          Width = 59
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = SpinEditEatItemTick1Change
        end
        object SpinEditEatHPItemRate1: TSpinEdit
          Left = 192
          Top = 35
          Width = 42
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Value = 60
          OnChange = SpinEditEatHPItemRate1Change
        end
        object SpinEditEatMPItemRate1: TSpinEdit
          Left = 259
          Top = 35
          Width = 42
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 60
          OnChange = SpinEditEatMPItemRate1Change
        end
      end
      object GroupBox4: TGroupBox
        Left = 184
        Top = 91
        Width = 129
        Height = 36
        Caption = #21484#21796#38388#38548
        TabOrder = 7
        object Label7: TLabel
          Left = 8
          Top = 16
          Width = 54
          Height = 12
          Caption = #38388#38548#26102#38388':'
        end
        object Label8: TLabel
          Left = 115
          Top = 16
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditHeroRecallTick: TSpinEdit
          Left = 68
          Top = 12
          Width = 45
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditHeroRecallTickChange
        end
      end
      object GroupBox5: TGroupBox
        Left = 5
        Top = 248
        Width = 310
        Height = 114
        Caption = #24544#35802#24230#35774#32622
        TabOrder = 8
        object Label10: TLabel
          Left = 10
          Top = 68
          Width = 54
          Height = 12
          Caption = #33719#24471#32463#39564':'
        end
        object Label11: TLabel
          Left = 134
          Top = 67
          Width = 42
          Height = 12
          Caption = #28857'/'#22686#21152
        end
        object Label12: TLabel
          Left = 12
          Top = 92
          Width = 54
          Height = 12
          Caption = #27515#20129#20943#23569':'
        end
        object Label28: TLabel
          Left = 10
          Top = 44
          Width = 78
          Height = 12
          Caption = #24694#24847#26432#20154#20943#23569':'
        end
        object Label30: TLabel
          Left = 169
          Top = 43
          Width = 78
          Height = 12
          Caption = #21512#27861#26432#20154#22686#21152':'
        end
        object Label31: TLabel
          Left = 8
          Top = 18
          Width = 114
          Height = 12
          Caption = #20027#20154#31561#32423#25490#21517#19978#21319#21152':'
        end
        object Label32: TLabel
          Left = 183
          Top = 18
          Width = 36
          Height = 12
          Caption = #19979#38477#20943
        end
        object Label33: TLabel
          Left = 140
          Top = 92
          Width = 78
          Height = 12
          Caption = #33635#35465#25552#21319#22686#21152':'
        end
        object EditWinExp: TSpinEdit
          Left = 68
          Top = 64
          Width = 61
          Height = 21
          Hint = #33719#24471#32463#39564#36798#21040#25351#23450#20540','#21363#21487#22686#21152#30456#24212#30340#24544#35802#24230'.100'#20026'1%'
          MaxValue = 2000000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 10000
          OnChange = EditWinExpChange
        end
        object EditExpAddLoyal: TSpinEdit
          Left = 182
          Top = 63
          Width = 61
          Height = 21
          Hint = #33719#24471#32463#39564#36798#21040#25351#23450#20540','#21363#21487#22686#21152#30456#24212#30340#24544#35802#24230'.100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 1
          OnChange = EditExpAddLoyalChange
        end
        object EditDeathDecLoyal: TSpinEdit
          Left = 68
          Top = 88
          Width = 61
          Height = 21
          Hint = #33521#38596#27515#20129#20943#23569#24544#35802#24230',100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 5
          OnChange = EditDeathDecLoyalChange
        end
        object EditPKDecLoyal: TSpinEdit
          Left = 92
          Top = 40
          Width = 61
          Height = 21
          Hint = #24694#24847#26432#20154#25351#26432#20154#22686#21152'PK'#20540','#24544#35802#24230'100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 1
          OnChange = EditPKDecLoyalChange
        end
        object EditGuildIncLoyal: TSpinEdit
          Left = 252
          Top = 39
          Width = 52
          Height = 21
          Hint = #21512#27861#26432#20154#25351#34892#20250#25112#21644#25915#22478#25112','#24544#35802#24230'100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Value = 1
          OnChange = EditGuildIncLoyalChange
        end
        object EditLevelOrderIncLoyal: TSpinEdit
          Left = 121
          Top = 14
          Width = 57
          Height = 21
          Hint = #20027#20154#31561#32423#25490#21517#19978#21319#21152#24544#35802#24230',100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 1
          OnChange = EditLevelOrderIncLoyalChange
        end
        object EditLevelOrderDecLoyal: TSpinEdit
          Left = 222
          Top = 13
          Width = 61
          Height = 21
          Hint = #20027#20154#31561#32423#25490#21517#19979#38477#20943#24544#35802#24230',100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Value = 1
          OnChange = EditLevelOrderDecLoyalChange
        end
        object SpinEdit1: TSpinEdit
          Left = 220
          Top = 88
          Width = 61
          Height = 21
          Hint = #33635#35465#20540#26242#26102#26080#25928#26524','#24544#35802#24230'100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 7
          Value = 0
        end
      end
      object GroupBox6: TGroupBox
        Left = 184
        Top = 127
        Width = 130
        Height = 56
        Caption = #22235#32423#25216#33021
        TabOrder = 9
        object Label14: TLabel
          Left = 8
          Top = 14
          Width = 54
          Height = 12
          Caption = #22235#32423#35302#21457':'
        end
        object Label15: TLabel
          Left = 5
          Top = 35
          Width = 60
          Height = 12
          Caption = #26432#20260#21147#22686#21152
        end
        object EditGotoLV4: TSpinEdit
          Left = 68
          Top = 10
          Width = 53
          Height = 21
          Hint = #24544#35802#24230#36798#21040#25351#23450#25968#20540#26102','#35302#21457#22235#32423#25216#33021',100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 3000
          OnChange = EditGotoLV4Change
        end
        object EditPowerLv4: TSpinEdit
          Left = 68
          Top = 32
          Width = 53
          Height = 21
          Hint = #22312#21407#26469#25216#33021#30340#22522#30784#19978#22686#21152#30340#26432#20260#21147'.'#13#10#38500'4'#32423#28872#28779#22806','#21482#23545'4'#32423#28781#22825#28779#21644#28779#31526#26377#25928
          MaxValue = 50
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = EditPowerLv4Change
        end
      end
      object GroupBox14: TGroupBox
        Left = 320
        Top = 186
        Width = 137
        Height = 88
        Caption = #38388#38548#25511#21046'('#27627#31186')'
        TabOrder = 10
        object Label27: TLabel
          Left = 19
          Top = 22
          Width = 30
          Height = 12
          Caption = #36208#36335':'
        end
        object Label29: TLabel
          Left = 19
          Top = 44
          Width = 30
          Height = 12
          Caption = #36716#21521':'
        end
        object Label39: TLabel
          Left = 20
          Top = 66
          Width = 30
          Height = 12
          Caption = #39764#27861':'
        end
        object EditHeroWalkIntervalTime: TSpinEdit
          Left = 52
          Top = 18
          Width = 55
          Height = 21
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 0
          Value = 600
          OnChange = EditHeroWalkIntervalTimeChange
        end
        object EditHeroTurnIntervalTime: TSpinEdit
          Left = 52
          Top = 40
          Width = 55
          Height = 21
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 1
          Value = 600
          OnChange = EditHeroTurnIntervalTimeChange
        end
        object GroupBox16: TGroupBox
          Left = 115
          Top = 14
          Width = 112
          Height = 80
          Caption = #36305#27493
          TabOrder = 2
          Visible = False
          object Label26: TLabel
            Left = 12
            Top = 15
            Width = 30
            Height = 12
            Caption = #25112#22763':'
          end
          object Label25: TLabel
            Left = 12
            Top = 39
            Width = 30
            Height = 12
            Caption = #27861#24072':'
          end
          object Label34: TLabel
            Left = 12
            Top = 60
            Width = 30
            Height = 12
            Caption = #36947#22763':'
          end
          object EditHeroRunIntervalTime: TSpinEdit
            Left = 45
            Top = 11
            Width = 55
            Height = 21
            EditorEnabled = False
            Increment = 10
            MaxValue = 2000
            MinValue = 10
            TabOrder = 0
            Value = 600
            OnChange = EditHeroRunIntervalTimeChange
          end
          object EditHeroRunIntervalTime1: TSpinEdit
            Left = 45
            Top = 34
            Width = 55
            Height = 21
            EditorEnabled = False
            Increment = 10
            MaxValue = 2000
            MinValue = 10
            TabOrder = 1
            Value = 600
            OnChange = EditHeroRunIntervalTime1Change
          end
          object EditHeroRunIntervalTime2: TSpinEdit
            Left = 45
            Top = 56
            Width = 55
            Height = 21
            EditorEnabled = False
            Increment = 10
            MaxValue = 2000
            MinValue = 10
            TabOrder = 2
            Value = 600
            OnChange = EditHeroRunIntervalTime2Change
          end
        end
        object EditHeroMagicHitIntervalTime: TSpinEdit
          Left = 53
          Top = 62
          Width = 55
          Height = 21
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 3
          Value = 800
          OnChange = EditHeroMagicHitIntervalTimeChange
        end
      end
      object GroupBox17: TGroupBox
        Left = 320
        Top = 274
        Width = 136
        Height = 90
        Caption = #33521#38596#21517#23383#35774#32622
        TabOrder = 11
        object LabelHeroNameColor: TLabel
          Left = 91
          Top = 28
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label65: TLabel
          Left = 12
          Top = 31
          Width = 30
          Height = 12
          Caption = #39068#33394':'
        end
        object Label24: TLabel
          Left = 12
          Top = 51
          Width = 30
          Height = 12
          Caption = #21517#23383':'
        end
        object Label35: TLabel
          Left = 12
          Top = 72
          Width = 30
          Height = 12
          Caption = #21518#32512':'
        end
        object EditHeroNameColor: TSpinEdit
          Left = 47
          Top = 26
          Width = 43
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditHeroNameColorChange
        end
        object CheckNameSuffix: TCheckBox
          Left = 16
          Top = 13
          Width = 97
          Height = 14
          Caption = #26174#31034#20027#20154#21517#23383
          TabOrder = 1
          OnClick = CheckNameSuffixClick
        end
        object EdtHeroName: TEdit
          Left = 47
          Top = 47
          Width = 77
          Height = 20
          TabOrder = 2
          OnChange = EdtHeroNameChange
        end
        object EditHeroNameSuffix: TEdit
          Left = 47
          Top = 67
          Width = 77
          Height = 20
          TabOrder = 3
          OnChange = EditHeroNameSuffixChange
        end
      end
      object CheckBoxHeroProtect: TCheckBox
        Left = 6
        Top = 364
        Width = 113
        Height = 16
        Caption = #31105#27490#23433#20840#21306#23432#25252
        TabOrder = 12
        OnClick = CheckBoxHeroProtectClick
      end
      object GroupBox23: TGroupBox
        Left = 320
        Top = 0
        Width = 136
        Height = 35
        Caption = #38750#26432#24618#32463#39564#20998#37197
        TabOrder = 13
        object Label45: TLabel
          Left = 11
          Top = 14
          Width = 54
          Height = 12
          Caption = #20998#37197#27604#20363':'
        end
        object EditNoEditKillMonExpRate: TSpinEdit
          Left = 68
          Top = 10
          Width = 53
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 40
          OnChange = EditNoEditKillMonExpRateChange
        end
      end
      object CheckBoxHeroRestNoFollow: TCheckBox
        Left = 114
        Top = 364
        Width = 113
        Height = 16
        Hint = #33521#38596#22312#20241#24687#29366#24577#26102#65292#19981#20250#19982#20027#20154#19968#36215#20999#25442#22320#22270
        Caption = #20241#24687#19981#19982#20027#20154#31227#21160
        ParentShowHint = False
        ShowHint = True
        TabOrder = 14
        OnClick = CheckBoxHeroRestNoFollowClick
      end
      object CheckBoxHeroAttackTarget: TCheckBox
        Left = 234
        Top = 364
        Width = 135
        Height = 16
        Caption = #36947#27861'22'#32423#21069#29289#29702#25915#20987
        ParentShowHint = False
        ShowHint = True
        TabOrder = 15
        OnClick = CheckBoxHeroAttackTargetClick
      end
      object SpinEditHeroHPRate: TSpinEdit
        Left = 80
        Top = 382
        Width = 49
        Height = 21
        Hint = #33521#38596'HP='#20154#29289'HP*'#35774#32622#20540'/1000'#13#10#22914#38656#20154#29289#19982#33521#38596'HP'#19968#33268#65292#21017#35774#32622#20026'1000'
        MaxValue = 60000
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 16
        Value = 2000
        OnChange = SpinEditHeroHPRateChange
      end
      object CheckBoxHeroAttackTao: TCheckBox
        Left = 202
        Top = 384
        Width = 167
        Height = 16
        Hint = #36947#22763','#24403#30446#26631'HP'#23569#20110'700'#26102','#21487#20197#20351#29992#29289#29702#25915#20987
        Caption = '700'#20197#19979#30446#26631#36947#22763#29289#29702#25915#20987
        ParentShowHint = False
        ShowHint = True
        TabOrder = 17
        OnClick = CheckBoxHeroAttackTaoClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #33521#38596#27515#20129
      ImageIndex = 1
      object GroupBox67: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 106
        Caption = #27515#20129#25481#29289#21697#35268#21017
        TabOrder = 0
        object Label41: TLabel
          Left = 136
          Top = 83
          Width = 24
          Height = 12
          Caption = '/100'
        end
        object CheckBoxKillByMonstDropUseItem: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Hint = #24403#20154#29289#34987#24618#29289#26432#27515#26102#20250#25353#25481#33853#26426#29575#25481#33853#36523#19978#25140#30340#29289#21697#12290
          Caption = #34987#24618#29289#26432#27515#25481#35013#22791
          TabOrder = 0
          OnClick = CheckBoxKillByMonstDropUseItemClick
        end
        object CheckBoxKillByHumanDropUseItem: TCheckBox
          Left = 8
          Top = 32
          Width = 121
          Height = 17
          Hint = #24403#20154#29289#34987#21035#20154#26432#27515#26102#20250#25353#25481#33853#26426#29575#25481#33853#36523#19978#25140#30340#29289#21697#12290
          Caption = #34987#20154#29289#26432#27515#25481#35013#22791
          TabOrder = 1
          OnClick = CheckBoxKillByHumanDropUseItemClick
        end
        object CheckBoxDieScatterBag: TCheckBox
          Left = 8
          Top = 48
          Width = 113
          Height = 17
          Hint = #24403#20154#29289#27515#20129#26102#20250#25353#25481#33853#26426#29575#25481#33853#32972#21253#37324#30340#29289#21697#12290
          Caption = #27515#20129#25481#32972#21253#29289#21697
          TabOrder = 2
          OnClick = CheckBoxDieScatterBagClick
        end
        object CheckBoxDieRedScatterBagAll: TCheckBox
          Left = 8
          Top = 64
          Width = 145
          Height = 17
          Hint = #32418#21517#20154#29289#27515#20129#26102#25481#33853#32972#21253#20013#20840#37096#29289#21697#12290
          Caption = #32418#21517#25481#20840#37096#32972#21253#29289#21697
          TabOrder = 3
          OnClick = CheckBoxDieRedScatterBagAllClick
        end
        object CheckBoxHeroDieExp: TCheckBox
          Left = 8
          Top = 82
          Width = 89
          Height = 17
          Hint = #32418#21517#20154#29289#27515#20129#26102#25481#33853#32972#21253#20013#20840#37096#29289#21697#12290
          Caption = #27515#20129#25481#32463#39564
          TabOrder = 4
          OnClick = CheckBoxHeroDieExpClick
        end
        object SpinEditHeroDieExpRate: TSpinEdit
          Left = 91
          Top = 80
          Width = 43
          Height = 21
          Hint = #27515#20129#25481#32463#39564#27604#29575','#21363#24403#21069#21319#32423#31561#32423#25152#38656#24635#32463#39564#30340#30334#20998#20043#20960
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 100
          OnChange = SpinEditHeroDieExpRateChange
        end
      end
      object GroupBox69: TGroupBox
        Left = 192
        Top = 8
        Width = 265
        Height = 89
        Caption = #25481#29289#21697#26426#29575
        TabOrder = 1
        object Label130: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25481#33853#35013#22791':'
        end
        object Label2: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #32418#21517#35013#22791':'
        end
        object Label134: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #32972#21253#29289#21697':'
        end
        object ScrollBarDieDropUseItemRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #20154#29289#27515#20129#25481#33853#36523#19978#25140#30340#29289#21697#26426#29575#65292#35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarDieDropUseItemRateChange
        end
        object EditDieDropUseItemRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarDieRedDropUseItemRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #32418#21517#20154#29289#27515#20129#25481#33853#36523#19978#25140#30340#29289#21697#26426#29575#65292#35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarDieRedDropUseItemRateChange
        end
        object EditDieRedDropUseItemRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarDieScatterBagRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #20154#29289#27515#20129#25481#33853#32972#21253#20013#30340#29289#21697#26426#29575#65292#35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarDieScatterBagRateChange
        end
        object EditDieScatterBagRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object ButtonHeroDieSave: TButton
        Left = 392
        Top = 317
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonHeroDieSaveClick
      end
      object GroupBox46: TGroupBox
        Left = 8
        Top = 123
        Width = 129
        Height = 49
        Caption = #28165#29702#26102#38388
        TabOrder = 3
        object Label89: TLabel
          Left = 18
          Top = 21
          Width = 30
          Height = 12
          Caption = #27515#23608':'
        end
        object Label90: TLabel
          Left = 106
          Top = 21
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditMakeGhostHeroTime: TSpinEdit
          Left = 51
          Top = 17
          Width = 53
          Height = 21
          Hint = #28165#38500#22320#19978#27515#23608#26102#38388#12290
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 180
          OnChange = EditMakeGhostHeroTimeChange
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #33521#38596#21512#20987
      ImageIndex = 2
      object ButtonHeroAttackSave: TButton
        Left = 392
        Top = 317
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonHeroAttackSaveClick
      end
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 477
        Height = 305
        ActivePage = TabSheet4
        Align = alTop
        TabOrder = 1
        object TabSheet4: TTabSheet
          Caption = #22522#26412#35774#32622
          object GroupBox3: TGroupBox
            Left = 4
            Top = 2
            Width = 177
            Height = 119
            Caption = #24594#27668#27133
            TabOrder = 0
            object Label4: TLabel
              Left = 8
              Top = 24
              Width = 66
              Height = 12
              Caption = #24594#27133#26368#22823#20540':'
            end
            object Label5: TLabel
              Left = 8
              Top = 48
              Width = 78
              Height = 12
              Caption = #24594#27133#27599#27425#22686#21152':'
            end
            object Label6: TLabel
              Left = 8
              Top = 72
              Width = 102
              Height = 12
              Caption = #28779#40857#20043#24515#27599#27425#20943#23569':'
            end
            object Label42: TLabel
              Left = 8
              Top = 96
              Width = 66
              Height = 12
              Caption = #21152#24594#27668#38388#38548':'
            end
            object EditMaxFirDragonPoint: TSpinEdit
              Left = 116
              Top = 20
              Width = 53
              Height = 21
              EditorEnabled = False
              MaxValue = 300
              MinValue = 1
              TabOrder = 0
              Value = 40
              OnChange = EditMaxFirDragonPointChange
            end
            object EditAddFirDragonPoint: TSpinEdit
              Left = 116
              Top = 44
              Width = 53
              Height = 21
              EditorEnabled = False
              MaxValue = 300
              MinValue = 1
              TabOrder = 1
              Value = 40
              OnChange = EditAddFirDragonPointChange
            end
            object EditDecFirDragonPoint: TSpinEdit
              Left = 116
              Top = 68
              Width = 53
              Height = 21
              EditorEnabled = False
              MaxValue = 300
              MinValue = 1
              TabOrder = 2
              Value = 40
              OnChange = EditDecFirDragonPointChange
            end
            object SpinEditIncDragonPointTick: TSpinEdit
              Left = 116
              Top = 92
              Width = 53
              Height = 21
              Hint = #21363#27599#38548#22810#23569#27627#31186#21152#24594#27668
              MaxValue = 10000000
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              Value = 3000
              OnChange = SpinEditIncDragonPointTickChange
            end
          end
          object GroupBox21: TGroupBox
            Left = 3
            Top = 125
            Width = 179
            Height = 50
            Caption = #39278#37202#20943#23569#21512#20987#20260#23475
            TabOrder = 1
            object Label43: TLabel
              Left = 20
              Top = 22
              Width = 72
              Height = 12
              Caption = #20943#20260#23475#27604#29575#65306
            end
            object Label44: TLabel
              Left = 140
              Top = 21
              Width = 6
              Height = 12
              Caption = '%'
            end
            object SpinEditDecDragonHitPoint: TSpinEdit
              Left = 89
              Top = 18
              Width = 47
              Height = 21
              Hint = #37257#20540#24230#19981#20026'0'#26102','#21487#20197#20943#23569#21512#20987#20260#23475#30340#30334#20998#29575
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = SpinEditDecDragonHitPointChange
            end
          end
          object GroupBox24: TGroupBox
            Left = 3
            Top = 181
            Width = 181
            Height = 50
            Caption = #25915#20987#25511#21046
            TabOrder = 2
            object Label46: TLabel
              Left = 3
              Top = 22
              Width = 132
              Height = 12
              Caption = #21512#20987#23545#20154#29289#30340#20260#23475#27604#20363#65306
            end
            object Label47: TLabel
              Left = 172
              Top = 22
              Width = 6
              Height = 12
              Caption = '%'
            end
            object EditDecDragonRate: TSpinEdit
              Left = 130
              Top = 18
              Width = 42
              Height = 21
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditDecDragonRateChange
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = #30772#39746#26025
          ImageIndex = 1
          object GroupBox52: TGroupBox
            Left = 8
            Top = 4
            Width = 161
            Height = 50
            Caption = #21512#20987#21442#25968
            TabOrder = 0
            object Label135: TLabel
              Left = 8
              Top = 20
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_60: TSpinEdit
              Left = 72
              Top = 16
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_60Change
            end
          end
          object GroupBox18: TGroupBox
            Left = 8
            Top = 72
            Width = 162
            Height = 46
            Caption = #25915#20987#33539#22260
            TabOrder = 1
            object Label36: TLabel
              Left = 10
              Top = 20
              Width = 60
              Height = 12
              Caption = #33539'    '#22260#65306
            end
            object EditHeroAttackRange_60: TSpinEdit
              Left = 75
              Top = 13
              Width = 77
              Height = 21
              Hint = #39764#27861#25915#20987#33539#22260#24452#12290
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditHeroAttackRange_60Change
            end
          end
        end
        object TabSheet6: TTabSheet
          Caption = #21128#26143#26025
          ImageIndex = 2
          object GroupBox9: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 57
            Caption = #25915#20987#21147#20493#25968
            TabOrder = 0
            object Label17: TLabel
              Left = 11
              Top = 23
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_61: TSpinEdit
              Left = 83
              Top = 19
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_61Change
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = #38647#38662#19968#20987
          ImageIndex = 3
          object GroupBox10: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 57
            Caption = #25915#20987#21147#20493#25968
            TabOrder = 0
            object Label18: TLabel
              Left = 11
              Top = 23
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_62: TSpinEdit
              Left = 83
              Top = 19
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_62Change
            end
          end
        end
        object TabSheet8: TTabSheet
          Caption = #22124#39746#27836#27901
          ImageIndex = 4
          object GroupBox11: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 57
            Caption = #25915#20987#21147#20493#25968
            TabOrder = 0
            object Label19: TLabel
              Left = 11
              Top = 23
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_63: TSpinEdit
              Left = 83
              Top = 19
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_63Change
            end
          end
          object GroupBox7: TGroupBox
            Left = 8
            Top = 72
            Width = 177
            Height = 46
            Caption = #25915#20987#33539#22260
            TabOrder = 1
            object Label22: TLabel
              Left = 10
              Top = 20
              Width = 60
              Height = 12
              Caption = #33539'    '#22260#65306
            end
            object EditHeroAttackRange_63: TSpinEdit
              Left = 84
              Top = 13
              Width = 77
              Height = 21
              Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditHeroAttackRange_63Change
            end
          end
          object GroupBox28: TGroupBox
            Left = 8
            Top = 125
            Width = 178
            Height = 65
            Caption = #20013#27602#35774#32622
            TabOrder = 2
            object RadioHeroSkillMode_63ALL: TRadioButton
              Left = 16
              Top = 16
              Width = 137
              Height = 17
              Caption = #30446#26631#21516#26102#20013#32511#27602
              TabOrder = 0
              OnClick = RadioHeroSkillMode_63ALLClick
            end
            object RadioHeroSkillMode_63: TRadioButton
              Left = 16
              Top = 40
              Width = 97
              Height = 17
              Hint = #19981#20351#29992#32511#27602#25915#20987
              Caption = #19981#20013#32511#27602
              TabOrder = 1
              OnClick = RadioHeroSkillMode_63Click
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = #26411#26085#23457#21028
          ImageIndex = 5
          object GroupBox12: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 57
            Caption = #25915#20987#21147#20493#25968
            TabOrder = 0
            object Label20: TLabel
              Left = 11
              Top = 23
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_64: TSpinEdit
              Left = 83
              Top = 19
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_64Change
            end
          end
          object GroupBox30: TGroupBox
            Left = 8
            Top = 72
            Width = 177
            Height = 46
            Caption = #25915#20987#33539#22260
            TabOrder = 1
            object Label9: TLabel
              Left = 10
              Top = 20
              Width = 60
              Height = 12
              Caption = #33539'    '#22260#65306
            end
            object EditHeroAttackRange_64: TSpinEdit
              Left = 84
              Top = 13
              Width = 77
              Height = 21
              Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditHeroAttackRange_64Change
            end
          end
        end
        object TabSheet10: TTabSheet
          Caption = #28779#40857#27668#28976
          ImageIndex = 6
          object GroupBox13: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 57
            Caption = #25915#20987#21147#20493#25968
            TabOrder = 0
            object Label21: TLabel
              Left = 11
              Top = 23
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_65: TSpinEdit
              Left = 83
              Top = 19
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_65Change
            end
          end
          object GroupBox15: TGroupBox
            Left = 8
            Top = 72
            Width = 177
            Height = 46
            Caption = #25915#20987#33539#22260
            TabOrder = 1
            object Label16: TLabel
              Left = 10
              Top = 20
              Width = 60
              Height = 12
              Caption = #33539'    '#22260#65306
            end
            object EditHeroAttackRange_65: TSpinEdit
              Left = 84
              Top = 13
              Width = 77
              Height = 21
              Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditHeroAttackRange_65Change
            end
          end
        end
      end
    end
    object TabSheet11: TTabSheet
      Caption = #33521#38596#25216#33021
      ImageIndex = 3
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 473
        Height = 321
        ActivePage = TabSheet12
        MultiLine = True
        TabOrder = 0
        object TabSheet12: TTabSheet
          Caption = #26045#27602#26415
          object GroupBox19: TGroupBox
            Left = 16
            Top = 8
            Width = 161
            Height = 65
            Caption = #22522#26412#35774#32622
            TabOrder = 0
            object RadioHeroSkillMode: TRadioButton
              Left = 16
              Top = 16
              Width = 137
              Height = 17
              Caption = #30446#26631#34880#20540#36798'700'#26102#20351#29992
              TabOrder = 0
              OnClick = RadioHeroSkillModeClick
            end
            object RadioHeroSkillModeAll: TRadioButton
              Left = 16
              Top = 40
              Width = 97
              Height = 17
              Hint = #19981#31649#30446#26631#34880#20540','#20840#37096#21487#20197#20351#29992#26045#27602#26415
              Caption = #20840#37096#21487#20351#29992
              TabOrder = 1
              OnClick = RadioHeroSkillModeAllClick
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = #21484#21796#23453#23453
          ImageIndex = 1
          object GroupBox20: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 54
            Caption = #22522#26412#35774#32622
            TabOrder = 0
            object CheckBoxHeroNoTargetCall: TCheckBox
              Left = 7
              Top = 22
              Width = 167
              Height = 18
              Hint = #21363#33521#38596#21484#21796#20986#26469#21518','#21363#21487#21484#21796#23453#23453
              Caption = #26080#25915#20987#30446#26631#26102#21487#20197#21484#21796#23453#23453
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = CheckBoxHeroNoTargetCallClick
            end
          end
        end
        object TabSheet14: TTabSheet
          Caption = #25252#20307#31070#30462
          ImageIndex = 2
          object GroupBox22: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 54
            Caption = #22522#26412#35774#32622
            TabOrder = 0
            object CheckBoxHeroAutoProtectionDefence: TCheckBox
              Left = 15
              Top = 22
              Width = 151
              Height = 18
              Caption = #26080#25915#20987#30446#26631#26102#33258#21160#24320#21551
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = CheckBoxHeroAutoProtectionDefenceClick
            end
          end
        end
        object TabSheet15: TTabSheet
          Caption = #26080#26497#30495#27668
          ImageIndex = 3
          object GroupBox25: TGroupBox
            Left = 16
            Top = 8
            Width = 161
            Height = 65
            Caption = #22522#26412#35774#32622
            TabOrder = 0
            object RadioHeroSkillMode50: TRadioButton
              Left = 16
              Top = 16
              Width = 137
              Height = 17
              Caption = #30446#26631'HP > 700'#26102#20351#29992
              TabOrder = 0
              OnClick = RadioHeroSkillMode50Click
            end
            object RadioHeroSkillMode50All: TRadioButton
              Left = 16
              Top = 40
              Width = 97
              Height = 17
              Hint = #19981#31649#30446#26631#34880#20540','#20840#37096#21487#20197#20351#29992
              Caption = #20840#37096#21487#20351#29992
              TabOrder = 1
              OnClick = RadioHeroSkillMode50AllClick
            end
          end
        end
        object TabSheet16: TTabSheet
          Caption = #20998#36523#26415
          ImageIndex = 4
          object GroupBox26: TGroupBox
            Left = 3
            Top = 77
            Width = 150
            Height = 120
            Caption = #27861#33521#38596'HP'#20302#20110#26102#21484#21796#20998#36523
            TabOrder = 0
            object Label48: TLabel
              Left = 16
              Top = 22
              Width = 114
              Height = 12
              Caption = '0'#32423' HP'#65306'          %'
            end
            object Label13: TLabel
              Left = 16
              Top = 46
              Width = 114
              Height = 12
              Caption = '1'#32423' HP'#65306'          %'
            end
            object Label49: TLabel
              Left = 16
              Top = 70
              Width = 114
              Height = 12
              Caption = '2'#32423' HP'#65306'          %'
            end
            object Label56: TLabel
              Left = 16
              Top = 94
              Width = 114
              Height = 12
              Caption = '3'#32423' HP'#65306'          %'
            end
            object SpinEditHeroSkill46MaxHP_0: TSpinEdit
              Left = 69
              Top = 18
              Width = 47
              Height = 21
              Hint = #22914#35774#32622#20026'80%,'#21017#33521#38596#22312#26377#30446#26631#26102','#20998#36523#25216#33021#31561#32423#20026'0'#32423#26102',HP'#20302#20110'80%'#26102#25165#20351#29992#20998#36523#25216#33021
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Value = 1
              OnChange = SpinEditHeroSkill46MaxHP_0Change
            end
            object SpinEditHeroSkill46MaxHP_1: TSpinEdit
              Left = 69
              Top = 42
              Width = 47
              Height = 21
              Hint = #22914#35774#32622#20026'80%,'#21017#33521#38596#22312#26377#30446#26631#26102','#20998#36523#25216#33021#31561#32423#20026'1'#32423#26102',HP'#20302#20110'80%'#26102#25165#20351#29992#20998#36523#25216#33021
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Value = 1
              OnChange = SpinEditHeroSkill46MaxHP_1Change
            end
            object SpinEditHeroSkill46MaxHP_2: TSpinEdit
              Left = 69
              Top = 66
              Width = 47
              Height = 21
              Hint = #22914#35774#32622#20026'80%,'#21017#33521#38596#22312#26377#30446#26631#26102','#20998#36523#25216#33021#31561#32423#20026'2'#32423#26102',HP'#20302#20110'80%'#26102#25165#20351#29992#20998#36523#25216#33021
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Value = 1
              OnChange = SpinEditHeroSkill46MaxHP_2Change
            end
            object SpinEditHeroSkill46MaxHP_3: TSpinEdit
              Left = 69
              Top = 90
              Width = 47
              Height = 21
              Hint = #22914#35774#32622#20026'80%,'#21017#33521#38596#22312#26377#30446#26631#26102','#20998#36523#25216#33021#31561#32423#20026'3'#32423#26102',HP'#20302#20110'80%'#26102#25165#20351#29992#20998#36523#25216#33021
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              Value = 1
              OnChange = SpinEditHeroSkill46MaxHP_3Change
            end
          end
          object GroupBox27: TGroupBox
            Left = 4
            Top = 6
            Width = 149
            Height = 65
            Caption = #22522#26412#35774#32622
            TabOrder = 1
            object RadioHeroSkillMode46: TRadioButton
              Left = 9
              Top = 16
              Width = 135
              Height = 17
              Caption = #26377#30446#26631#26102#21487#20351#29992
              TabOrder = 0
              OnClick = RadioHeroSkillMode46Click
            end
            object RadioHeroSkillMode46All: TRadioButton
              Left = 10
              Top = 40
              Width = 97
              Height = 17
              Hint = #19981#31649#26159#21542#26377#30446#26631',HP'#36798#21040#35774#32622#26102#21363#21487#20351#29992
              Caption = #20840#37096#21487#20351#29992
              TabOrder = 1
              OnClick = RadioHeroSkillMode46AllClick
            end
          end
          object GroupBox79: TGroupBox
            Left = 164
            Top = 8
            Width = 151
            Height = 47
            Caption = #25216#33021#31561#32423#24310#38271#20351#29992#26102#38388
            TabOrder = 2
            object Label159: TLabel
              Left = 16
              Top = 24
              Width = 36
              Height = 12
              Caption = #26102#38388#65306
            end
            object Label160: TLabel
              Left = 120
              Top = 24
              Width = 12
              Height = 12
              Caption = #31186
            end
            object SpinEditHeroMakeSelfTick: TSpinEdit
              Left = 56
              Top = 20
              Width = 57
              Height = 21
              Hint = #27599#20010#31561#32423#24310#38271#20998#36523#30340#20351#29992#26102#38388','#22914#35774#32622#20026'10'#31186','#24403#25216#33021#31561#32423#20026'3'#32423#26102','#21017#24310#38271#20998#36523#26102#38388#20026'30'#31186
              MaxValue = 65535
              MinValue = 0
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Value = 10
              OnChange = SpinEditHeroMakeSelfTickChange
            end
          end
        end
        object TabSheet17: TTabSheet
          Caption = #24320#22825#26025
          ImageIndex = 5
          object GroupBox31: TGroupBox
            Left = 4
            Top = 6
            Width = 157
            Height = 64
            Caption = #37325#20987#35774#32622
            TabOrder = 0
            object RadioHeroSkillMode43: TRadioButton
              Left = 9
              Top = 16
              Width = 144
              Height = 17
              Caption = #31561#32423#22823#20110#30446#26631#26102#21487#20351#29992
              TabOrder = 0
              OnClick = RadioHeroSkillMode43Click
            end
            object RadioHeroSkillMode43All: TRadioButton
              Left = 10
              Top = 40
              Width = 97
              Height = 17
              Hint = #19981#31649#30446#26631#31561#32423#26159#21542#39640#20110#33521#38596','#37325#20987#37117#21487#20351#29992','#26426#29575#19982#20027#20307#19968#33268
              Caption = #20840#37096#21487#20351#29992
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = RadioHeroSkillMode43AllClick
            end
          end
        end
      end
      object ButtonHeroSkillSave: TButton
        Left = 384
        Top = 333
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonHeroSkillSaveClick
      end
    end
  end
end

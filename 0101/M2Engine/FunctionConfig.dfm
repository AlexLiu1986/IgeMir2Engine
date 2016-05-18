object frmFunctionConfig: TfrmFunctionConfig
  Left = 513
  Top = 282
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #21151#33021#35774#32622
  ClientHeight = 403
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label14: TLabel
    Left = 8
    Top = 383
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
  object FunctionConfigControl: TPageControl
    Left = 8
    Top = 8
    Width = 457
    Height = 369
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 0
    OnChanging = FunctionConfigControlChanging
    object TabSheetGeneral: TTabSheet
      Caption = #22522#26412#21151#33021
      ImageIndex = 3
      object GroupBox7: TGroupBox
        Left = 8
        Top = 206
        Width = 138
        Height = 102
        Caption = #33021#37327#25511#21046
        TabOrder = 0
        object CheckBoxHungerSystem: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Hint = #21551#29992#27492#21151#33021#21518#65292#20154#29289#24517#39035#23450#26102#21507#39135#29289#20197#20445#25345#33021#37327#65292#22914#26524#38271#26102#38388#26410#21507#39135#29289#65292#20154#29289#23558#34987#39295#27515#12290
          Caption = #21551#29992#33021#37327#25511#21046#31995#32479
          TabOrder = 0
          OnClick = CheckBoxHungerSystemClick
        end
        object GroupBoxHunger: TGroupBox
          Left = 8
          Top = 40
          Width = 117
          Height = 57
          Caption = #33021#37327#19981#22815#26102
          TabOrder = 1
          object CheckBoxHungerDecPower: TCheckBox
            Left = 8
            Top = 32
            Width = 97
            Height = 17
            Hint = #20154#29289#30340#25915#20987#21147#65292#19982#20154#29289#30340#33021#37327#30456#20851#65292#33021#37327#19981#22815#26102#20154#29289#30340#25915#20987#21147#23558#38543#20043#19979#38477#12290
            Caption = #33258#21160#20943#25915#20987#21147
            TabOrder = 0
            OnClick = CheckBoxHungerDecPowerClick
          end
          object CheckBoxHungerDecHP: TCheckBox
            Left = 8
            Top = 16
            Width = 89
            Height = 17
            Hint = #24403#20154#29289#38271#26102#38388#27809#21507#39135#29289#21518#33021#37327#38477#21040'0'#21518#65292#23558#24320#22987#33258#21160#20943#23569'HP'#20540#65292#38477#21040'0'#21518#65292#20154#29289#27515#20129#12290
            Caption = #33258#21160#20943'HP'
            TabOrder = 1
            OnClick = CheckBoxHungerDecHPClick
          end
        end
      end
      object ButtonGeneralSave: TButton
        Left = 368
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonGeneralSaveClick
      end
      object GroupBox34: TGroupBox
        Left = 8
        Top = 8
        Width = 137
        Height = 197
        Caption = #21517#23383#26174#31034#39068#33394
        TabOrder = 2
        object Label85: TLabel
          Left = 11
          Top = 16
          Width = 54
          Height = 12
          Caption = #25915#20987#29366#24577':'
        end
        object LabelPKFlagNameColor: TLabel
          Left = 112
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label87: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #40644#21517#29366#24577':'
        end
        object LabelPKLevel1NameColor: TLabel
          Left = 112
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label89: TLabel
          Left = 11
          Top = 64
          Width = 54
          Height = 12
          Caption = #32418#21517#29366#24577':'
        end
        object LabelPKLevel2NameColor: TLabel
          Left = 112
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label91: TLabel
          Left = 11
          Top = 88
          Width = 54
          Height = 12
          Caption = #32852#30431#25112#20105':'
        end
        object LabelAllyAndGuildNameColor: TLabel
          Left = 112
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label93: TLabel
          Left = 11
          Top = 112
          Width = 54
          Height = 12
          Caption = #25932#23545#25112#20105':'
        end
        object LabelWarGuildNameColor: TLabel
          Left = 112
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label95: TLabel
          Left = 11
          Top = 136
          Width = 54
          Height = 12
          Caption = #25112#20105#21306#22495':'
        end
        object LabelInFreePKAreaNameColor: TLabel
          Left = 112
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label234: TLabel
          Left = 11
          Top = 160
          Width = 48
          Height = 12
          Caption = 'NPC'#21517#23383':'
        end
        object LabelNPCNameColor: TLabel
          Left = 112
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditPKFlagNameColor: TSpinEdit
          Left = 64
          Top = 12
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#25915#20987#20854#20182#20154#29289#26102#21517#23383#39068#33394#65292#40664#35748#20026'47'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditPKFlagNameColorChange
        end
        object EditPKLevel1NameColor: TSpinEdit
          Left = 64
          Top = 36
          Width = 41
          Height = 21
          Hint = #24403#20154#29289'PK'#28857#36229#36807'100'#28857#26102#21517#23383#39068#33394#65292#40664#35748#20026'251'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditPKLevel1NameColorChange
        end
        object EditPKLevel2NameColor: TSpinEdit
          Left = 64
          Top = 60
          Width = 41
          Height = 21
          Hint = #24403#20154#29289'PK'#28857#36229#36807'200'#28857#26102#21517#23383#39068#33394#65292#40664#35748#20026'249'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditPKLevel2NameColorChange
        end
        object EditAllyAndGuildNameColor: TSpinEdit
          Left = 64
          Top = 84
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#26102#65292#26412#34892#20250#21450#32852#30431#34892#20250#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'180'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditAllyAndGuildNameColorChange
        end
        object EditWarGuildNameColor: TSpinEdit
          Left = 64
          Top = 108
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#26102#65292#25932#23545#34892#20250#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'69'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditWarGuildNameColorChange
        end
        object EditInFreePKAreaNameColor: TSpinEdit
          Left = 64
          Top = 132
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#21306#22495#26102#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'221'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditInFreePKAreaNameColorChange
        end
        object CheckBoxShowGuildName: TCheckBox
          Left = 8
          Top = 178
          Width = 121
          Height = 17
          Hint = #20154#29289#21517#31216#26174#31034#34892#20250#20449#24687','#22914#19981#35774#32622','#21017#21482#13#26377#27801#24052#20811#34892#20250#22312#20154#29289#21517#31216#26174#31034','#20854#23427#34892#13#20250'('#38500#25915#22478#21306#22495#22806')'#19981#22312#20154#29289#21517#31216#26174#31034#20449#24687
          Caption = #21517#23383#26174#31034#34892#20250#20449#24687
          TabOrder = 6
          OnClick = CheckBoxShowGuildNameClick
        end
        object SpinEditNPCNameColor: TSpinEdit
          Left = 64
          Top = 156
          Width = 41
          Height = 21
          Hint = 'NPC'#21517#23383#39068#33394#65292#40664#35748#20026'255'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = SpinEditNPCNameColorChange
        end
      end
      object GroupBox62: TGroupBox
        Left = 152
        Top = 8
        Width = 137
        Height = 43
        Caption = #22320#22270#20107#20214#35302#21457
        TabOrder = 3
        object CheckBoxStartMapEvent: TCheckBox
          Left = 8
          Top = 17
          Width = 121
          Height = 15
          Caption = #24320#21551#22320#22270#20107#20214#35302#21457
          TabOrder = 0
          OnClick = CheckBoxStartMapEventClick
        end
      end
      object GroupBox99: TGroupBox
        Left = 295
        Top = 8
        Width = 139
        Height = 43
        Caption = #25361#25112#26102#38271
        TabOrder = 4
        object Label202: TLabel
          Left = 7
          Top = 19
          Width = 60
          Height = 12
          Caption = #25361#25112#26102#38388#65306
        end
        object Label203: TLabel
          Left = 120
          Top = 20
          Width = 12
          Height = 12
          Caption = #31186
        end
        object SpinEditChallengeTime: TSpinEdit
          Left = 71
          Top = 15
          Width = 48
          Height = 21
          Hint = #36827#34892#25361#25112#30340#26377#25928#26102#38388
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 300
          OnChange = SpinEditChallengeTimeChange
        end
      end
      object GroupBox101: TGroupBox
        Left = 152
        Top = 54
        Width = 295
        Height = 63
        Caption = #27668#34880#30707
        TabOrder = 5
        object Label204: TLabel
          Left = 5
          Top = 17
          Width = 36
          Height = 12
          Caption = #24403'HP'#25481
        end
        object Label205: TLabel
          Left = 81
          Top = 17
          Width = 108
          Height = 12
          Caption = #26102#24320#21551#27668#34880#30707','#38388#38548':'
        end
        object Label206: TLabel
          Left = 4
          Top = 41
          Width = 48
          Height = 12
          Caption = #27599#27425#21152'HP'
        end
        object Label207: TLabel
          Left = 117
          Top = 41
          Width = 84
          Height = 12
          Caption = #27668#34880#30707#25345#20037#20943#23569
        end
        object Label208: TLabel
          Left = 269
          Top = 41
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label209: TLabel
          Left = 254
          Top = 17
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object SpinEditStartHPRock: TSpinEdit
          Left = 40
          Top = 13
          Width = 41
          Height = 21
          Hint = #24635#34880#20540#20026'600,'#35774#32622#20540'90,'#21363#24403#21069#34880#20540#20302#20110'510'#26102','#20351#29992#29289#21697
          MaxValue = 10000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 90
          OnChange = SpinEditStartHPRockChange
        end
        object SpinEditRockAddHP: TSpinEdit
          Left = 53
          Top = 37
          Width = 49
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = SpinEditRockAddHPChange
        end
        object SpinEditHPRockDecDura: TSpinEdit
          Left = 200
          Top = 37
          Width = 65
          Height = 21
          Hint = '1000=1'#25345#20037
          MaxValue = 1000000
          MinValue = 6
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 100
          OnChange = SpinEditHPRockDecDuraChange
        end
        object SpinEditHPRockSpell: TSpinEdit
          Left = 188
          Top = 13
          Width = 60
          Height = 21
          Hint = #27599#27425#20351#29992#30340#38388#38548#26102#38388
          MaxValue = 10000000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 700
          OnChange = SpinEditHPRockSpellChange
        end
      end
      object GroupBox102: TGroupBox
        Left = 152
        Top = 118
        Width = 296
        Height = 62
        Caption = #24187#39764#30707
        TabOrder = 6
        object Label210: TLabel
          Left = 8
          Top = 15
          Width = 36
          Height = 12
          Caption = #24403'MP'#25481
        end
        object Label211: TLabel
          Left = 8
          Top = 38
          Width = 48
          Height = 12
          Caption = #27599#27425#21152'MP'
        end
        object Label212: TLabel
          Left = 119
          Top = 38
          Width = 84
          Height = 12
          Caption = #24187#39764#30707#25345#20037#20943#23569
        end
        object Label213: TLabel
          Left = 270
          Top = 38
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label214: TLabel
          Left = 86
          Top = 15
          Width = 108
          Height = 12
          Caption = #26102#24320#21551#24187#39764#30707','#38388#38548':'
        end
        object Label215: TLabel
          Left = 251
          Top = 14
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object SpinEditStartMPRock: TSpinEdit
          Left = 45
          Top = 11
          Width = 41
          Height = 21
          Hint = #24635#39764#27861#20540#20026'600,'#35774#32622#20540'90,'#21363#24403#21069#39764#27861#20540#20302#20110'510'#26102','#20351#29992#29289#21697
          MaxValue = 10000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 90
          OnChange = SpinEditStartMPRockChange
        end
        object SpinEditRockAddMP: TSpinEdit
          Left = 60
          Top = 34
          Width = 49
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = SpinEditRockAddMPChange
        end
        object SpinEditMPRockDecDura: TSpinEdit
          Left = 202
          Top = 34
          Width = 65
          Height = 21
          Hint = '1000=1'#25345#20037
          MaxValue = 1000000
          MinValue = 6
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 100
          OnChange = SpinEditMPRockDecDuraChange
        end
        object SpinEditMPRockSpell: TSpinEdit
          Left = 193
          Top = 11
          Width = 57
          Height = 21
          Hint = #27599#27425#20351#29992#30340#38388#38548#26102#38388
          MaxValue = 10000000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 700
          OnChange = SpinEditMPRockSpellChange
        end
      end
      object GroupBox103: TGroupBox
        Left = 152
        Top = 181
        Width = 296
        Height = 61
        Caption = #39764#34880#30707
        TabOrder = 7
        object Label216: TLabel
          Left = 3
          Top = 15
          Width = 60
          Height = 12
          Caption = #24403'HP'#25110'MP'#25481
        end
        object Label217: TLabel
          Left = 3
          Top = 38
          Width = 72
          Height = 12
          Caption = #27599#27425#21152'HP'#25110'MP'
        end
        object Label218: TLabel
          Left = 131
          Top = 38
          Width = 84
          Height = 12
          Caption = #39764#34880#30707#25345#20037#20943#23569
        end
        object Label219: TLabel
          Left = 277
          Top = 38
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label220: TLabel
          Left = 107
          Top = 15
          Width = 108
          Height = 12
          Caption = #26102#24320#21551#39764#34880#30707','#38388#38548':'
        end
        object Label221: TLabel
          Left = 267
          Top = 15
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object SpinEditStartHPMPRock: TSpinEdit
          Left = 63
          Top = 11
          Width = 42
          Height = 21
          Hint = #24635'HP'#25110'MP'#20026'600,'#35774#32622#20540'90,'#21363#24403#21069'HP'#25110'MP'#20302#20110'510'#26102','#20351#29992#29289#21697
          MaxValue = 10000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 90
          OnChange = SpinEditStartHPMPRockChange
        end
        object SpinEditRockAddHPMP: TSpinEdit
          Left = 80
          Top = 34
          Width = 49
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = SpinEditRockAddHPMPChange
        end
        object SpinEditHPMPRockDecDura: TSpinEdit
          Left = 214
          Top = 34
          Width = 60
          Height = 21
          Hint = '1000=1'#25345#20037
          MaxValue = 1000000
          MinValue = 6
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 100
          OnChange = SpinEditHPMPRockDecDuraChange
        end
        object SpinEditHPMPRockSpell: TSpinEdit
          Left = 213
          Top = 11
          Width = 53
          Height = 21
          Hint = #27599#27425#20351#29992#30340#38388#38548#26102#38388
          MaxValue = 10000000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 700
          OnChange = SpinEditHPMPRockSpellChange
        end
      end
    end
    object PasswordSheet: TTabSheet
      Caption = #23494#30721#20445#25252
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 8
        Top = 0
        Width = 433
        Height = 193
        TabOrder = 0
        object CheckBoxEnablePasswordLock: TCheckBox
          Left = 8
          Top = -5
          Width = 121
          Height = 25
          Caption = #21551#29992#23494#30721#20445#25252#31995#32479
          TabOrder = 0
          OnClick = CheckBoxEnablePasswordLockClick
        end
        object GroupBox2: TGroupBox
          Left = 8
          Top = 16
          Width = 265
          Height = 169
          Caption = #38145#23450#25511#21046
          TabOrder = 1
          object CheckBoxLockGetBackItem: TCheckBox
            Left = 8
            Top = 16
            Width = 121
            Height = 17
            Caption = #31105#27490#21462#20179#24211
            TabOrder = 0
            OnClick = CheckBoxLockGetBackItemClick
          end
          object GroupBox4: TGroupBox
            Left = 8
            Top = 40
            Width = 249
            Height = 116
            Caption = #30331#24405#38145#23450
            TabOrder = 1
            object CheckBoxLockWalk: TCheckBox
              Left = 8
              Top = 32
              Width = 105
              Height = 17
              Caption = #31105#27490#36208#36335
              TabOrder = 0
              OnClick = CheckBoxLockWalkClick
            end
            object CheckBoxLockRun: TCheckBox
              Left = 8
              Top = 48
              Width = 105
              Height = 17
              Caption = #31105#27490#36305#27493
              TabOrder = 1
              OnClick = CheckBoxLockRunClick
            end
            object CheckBoxLockHit: TCheckBox
              Left = 8
              Top = 64
              Width = 105
              Height = 17
              Caption = #31105#27490#25915#20987
              TabOrder = 2
              OnClick = CheckBoxLockHitClick
            end
            object CheckBoxLockSpell: TCheckBox
              Left = 8
              Top = 80
              Width = 105
              Height = 17
              Caption = #31105#27490#39764#27861
              TabOrder = 3
              OnClick = CheckBoxLockSpellClick
            end
            object CheckBoxLockSendMsg: TCheckBox
              Left = 120
              Top = 32
              Width = 105
              Height = 17
              Caption = #31105#27490#32842#22825
              TabOrder = 4
              OnClick = CheckBoxLockSendMsgClick
            end
            object CheckBoxLockInObMode: TCheckBox
              Left = 120
              Top = 16
              Width = 121
              Height = 17
              Hint = #22914#26524#26377#23494#30721#20445#25252#26102#65292#20154#29289#30331#24405#26102#20026#38544#36523#29366#24577#65292#24618#29289#19981#20250#25915#20987#20154#29289#65292#22312#36755#20837#23494#30721#24320#38145#21518#24674#22797#27491#24120#12290
              Caption = #38145#23450#26102#20026#38544#36523#27169#24335
              TabOrder = 5
              OnClick = CheckBoxLockInObModeClick
            end
            object CheckBoxLockLogin: TCheckBox
              Left = 8
              Top = 16
              Width = 105
              Height = 17
              Caption = #38145#23450#20154#29289#30331#24405
              TabOrder = 6
              OnClick = CheckBoxLockLoginClick
            end
            object CheckBoxLockUseItem: TCheckBox
              Left = 120
              Top = 80
              Width = 105
              Height = 17
              Caption = #31105#27490#20351#29992#21697
              TabOrder = 7
              OnClick = CheckBoxLockUseItemClick
            end
            object CheckBoxLockDropItem: TCheckBox
              Left = 120
              Top = 64
              Width = 105
              Height = 17
              Caption = #31105#27490#25172#29289#21697
              TabOrder = 8
              OnClick = CheckBoxLockDropItemClick
            end
            object CheckBoxLockDealItem: TCheckBox
              Left = 120
              Top = 48
              Width = 121
              Height = 17
              Caption = #31105#27490#20132#26131#29289#21697
              TabOrder = 9
              OnClick = CheckBoxLockDealItemClick
            end
            object CheckBoxLockCallHero: TCheckBox
              Left = 8
              Top = 96
              Width = 105
              Height = 17
              Caption = #31105#27490#21484#21796#33521#38596
              TabOrder = 10
              OnClick = CheckBoxLockCallHeroClick
            end
          end
        end
        object GroupBox3: TGroupBox
          Left = 280
          Top = 16
          Width = 145
          Height = 65
          Caption = #23494#30721#36755#20837#38169#35823#25511#21046
          TabOrder = 2
          object Label1: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #38169#35823#27425#25968':'
          end
          object EditErrorPasswordCount: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #22312#24320#38145#26102#36755#20837#23494#30721#65292#22914#26524#36755#20837#38169#35823#36229#36807#25351#23450#27425#25968#65292#21017#38145#23450#23494#30721#65292#24517#39035#37325#26032#30331#24405#19968#27425#25165#21487#20197#20877#27425#36755#20837#23494#30721#12290
            EditorEnabled = False
            MaxValue = 10
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditErrorPasswordCountChange
          end
          object CheckBoxErrorCountKick: TCheckBox
            Left = 8
            Top = 40
            Width = 129
            Height = 17
            Caption = #36229#36807#25351#23450#27425#25968#36386#19979#32447
            Enabled = False
            TabOrder = 1
            OnClick = CheckBoxErrorCountKickClick
          end
        end
        object ButtonPasswordLockSave: TButton
          Left = 360
          Top = 157
          Width = 65
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 3
          OnClick = ButtonPasswordLockSaveClick
        end
      end
    end
    object TabSheet32: TTabSheet
      Caption = #32467#23130#31995#32479
      ImageIndex = 4
    end
    object TabSheet33: TTabSheet
      Caption = #24072#24466#31995#32479
      ImageIndex = 5
      object GroupBox21: TGroupBox
        Left = 8
        Top = 8
        Width = 161
        Height = 153
        Caption = #24466#24351#20986#24072
        TabOrder = 0
        object GroupBox22: TGroupBox
          Left = 8
          Top = 16
          Width = 145
          Height = 49
          Caption = #20986#24072#31561#32423
          TabOrder = 0
          object Label29: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #20986#24072#31561#32423':'
          end
          object EditMasterOKLevel: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #20986#24072#31561#32423#35774#32622#65292#20154#29289#22312#25308#24072#21518#65292#21040#25351#23450#31561#32423#21518#23558#33258#21160#20986#24072#12290
            MaxValue = 65535
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKLevelChange
          end
        end
        object GroupBox23: TGroupBox
          Left = 8
          Top = 72
          Width = 145
          Height = 73
          Caption = #24072#29238#25152#24471
          TabOrder = 1
          object Label30: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #22768#26395#28857#25968':'
          end
          object Label31: TLabel
            Left = 8
            Top = 42
            Width = 54
            Height = 12
            Caption = #20998#37197#28857#25968':'
          end
          object EditMasterOKCreditPoint: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #24466#24351#20986#24072#21518#65292#24072#29238#24471#21040#30340#22768#26395#28857#25968#12290
            MaxValue = 100
            MinValue = 0
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKCreditPointChange
          end
          object EditMasterOKBonusPoint: TSpinEdit
            Left = 68
            Top = 39
            Width = 53
            Height = 21
            Hint = #24466#24351#20986#24072#21518#65292#24072#29238#24471#21040#30340#20998#37197#28857#25968#12290
            MaxValue = 1000
            MinValue = 0
            TabOrder = 1
            Value = 10
            OnChange = EditMasterOKBonusPointChange
          end
        end
      end
      object ButtonMasterSave: TButton
        Left = 360
        Top = 157
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonMasterSaveClick
      end
      object GroupBox84: TGroupBox
        Left = 176
        Top = 8
        Width = 131
        Height = 49
        Caption = #24466#24351#25968#37327
        TabOrder = 2
        object Label166: TLabel
          Left = 14
          Top = 22
          Width = 42
          Height = 12
          Caption = #25910#24466#25968':'
        end
        object EditMasterCount: TSpinEdit
          Left = 61
          Top = 17
          Width = 53
          Height = 21
          Hint = #26368#22810#21487#25910#20960#20301#24466#24351'.'
          MaxValue = 100
          MinValue = 1
          TabOrder = 0
          Value = 5
          OnChange = EditMasterCountChange
        end
      end
    end
    object TabSheet38: TTabSheet
      Caption = #36716#29983#31995#32479
      ImageIndex = 9
      object GroupBox29: TGroupBox
        Left = 8
        Top = 8
        Width = 113
        Height = 257
        Caption = #33258#21160#21464#33394
        TabOrder = 0
        object Label56: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object LabelReNewNameColor1: TLabel
          Left = 88
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label58: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object LabelReNewNameColor2: TLabel
          Left = 88
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label60: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object LabelReNewNameColor3: TLabel
          Left = 88
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label62: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object LabelReNewNameColor4: TLabel
          Left = 88
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label64: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object LabelReNewNameColor5: TLabel
          Left = 88
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label66: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object LabelReNewNameColor6: TLabel
          Left = 88
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label68: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object LabelReNewNameColor7: TLabel
          Left = 88
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label70: TLabel
          Left = 11
          Top = 184
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object LabelReNewNameColor8: TLabel
          Left = 88
          Top = 182
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label72: TLabel
          Left = 11
          Top = 208
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object LabelReNewNameColor9: TLabel
          Left = 88
          Top = 206
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label74: TLabel
          Left = 11
          Top = 232
          Width = 18
          Height = 12
          Caption = #21313':'
        end
        object LabelReNewNameColor10: TLabel
          Left = 88
          Top = 230
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditReNewNameColor1: TSpinEdit
          Left = 40
          Top = 12
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditReNewNameColor1Change
        end
        object EditReNewNameColor2: TSpinEdit
          Left = 40
          Top = 36
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditReNewNameColor2Change
        end
        object EditReNewNameColor3: TSpinEdit
          Left = 40
          Top = 60
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditReNewNameColor3Change
        end
        object EditReNewNameColor4: TSpinEdit
          Left = 40
          Top = 84
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditReNewNameColor4Change
        end
        object EditReNewNameColor5: TSpinEdit
          Left = 40
          Top = 108
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditReNewNameColor5Change
        end
        object EditReNewNameColor6: TSpinEdit
          Left = 40
          Top = 132
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditReNewNameColor6Change
        end
        object EditReNewNameColor7: TSpinEdit
          Left = 40
          Top = 156
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditReNewNameColor7Change
        end
        object EditReNewNameColor8: TSpinEdit
          Left = 40
          Top = 180
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditReNewNameColor8Change
        end
        object EditReNewNameColor9: TSpinEdit
          Left = 40
          Top = 204
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditReNewNameColor9Change
        end
        object EditReNewNameColor10: TSpinEdit
          Left = 40
          Top = 228
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 100
          OnChange = EditReNewNameColor10Change
        end
      end
      object ButtonReNewLevelSave: TButton
        Left = 360
        Top = 157
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonReNewLevelSaveClick
      end
      object GroupBox30: TGroupBox
        Left = 128
        Top = 8
        Width = 105
        Height = 65
        Caption = #21517#23383#21464#33394
        TabOrder = 2
        object Label57: TLabel
          Left = 8
          Top = 42
          Width = 30
          Height = 12
          Caption = #38388#38548':'
        end
        object Label59: TLabel
          Left = 83
          Top = 44
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditReNewNameColorTime: TSpinEdit
          Left = 44
          Top = 39
          Width = 37
          Height = 21
          Hint = #21517#23383#21464#33394#30340#38388#38548#12290
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditReNewNameColorTimeChange
        end
        object CheckBoxReNewChangeColor: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = #25171#24320#27492#21151#33021#21518#65292#36716#29983#30340#20154#29289#30340#21517#23383#39068#33394#20250#33258#21160#21464#21270#12290
          Caption = #33258#21160#21464#33394
          TabOrder = 1
          OnClick = CheckBoxReNewChangeColorClick
        end
      end
      object GroupBox33: TGroupBox
        Left = 128
        Top = 80
        Width = 105
        Height = 41
        Caption = #36716#29983#25511#21046
        TabOrder = 3
        object CheckBoxReNewLevelClearExp: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = #36716#29983#26102#26159#21542#28165#38500#24050#32463#26377#30340#32463#39564#20540#12290
          Caption = #28165#38500#24050#26377#32463#39564
          TabOrder = 0
          OnClick = CheckBoxReNewLevelClearExpClick
        end
      end
    end
    object TabSheet39: TTabSheet
      Caption = #23453#23453#21319#32423
      ImageIndex = 10
      object ButtonMonUpgradeSave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonMonUpgradeSaveClick
      end
      object GroupBox32: TGroupBox
        Left = 8
        Top = 8
        Width = 113
        Height = 233
        Caption = #31561#32423#39068#33394
        TabOrder = 1
        object Label65: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object LabelMonUpgradeColor1: TLabel
          Left = 88
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label67: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object LabelMonUpgradeColor2: TLabel
          Left = 88
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label69: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object LabelMonUpgradeColor3: TLabel
          Left = 88
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label71: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object LabelMonUpgradeColor4: TLabel
          Left = 88
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label73: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object LabelMonUpgradeColor5: TLabel
          Left = 88
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label75: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object LabelMonUpgradeColor6: TLabel
          Left = 88
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label76: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object LabelMonUpgradeColor7: TLabel
          Left = 88
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label77: TLabel
          Left = 11
          Top = 184
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object LabelMonUpgradeColor8: TLabel
          Left = 88
          Top = 182
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label86: TLabel
          Left = 11
          Top = 208
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object LabelMonUpgradeColor9: TLabel
          Left = 88
          Top = 206
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditMonUpgradeColor1: TSpinEdit
          Left = 40
          Top = 12
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeColor1Change
        end
        object EditMonUpgradeColor2: TSpinEdit
          Left = 40
          Top = 36
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeColor2Change
        end
        object EditMonUpgradeColor3: TSpinEdit
          Left = 40
          Top = 60
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeColor3Change
        end
        object EditMonUpgradeColor4: TSpinEdit
          Left = 40
          Top = 84
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeColor4Change
        end
        object EditMonUpgradeColor5: TSpinEdit
          Left = 40
          Top = 108
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeColor5Change
        end
        object EditMonUpgradeColor6: TSpinEdit
          Left = 40
          Top = 132
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeColor6Change
        end
        object EditMonUpgradeColor7: TSpinEdit
          Left = 40
          Top = 156
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeColor7Change
        end
        object EditMonUpgradeColor8: TSpinEdit
          Left = 40
          Top = 180
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpgradeColor8Change
        end
        object EditMonUpgradeColor9: TSpinEdit
          Left = 40
          Top = 204
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpgradeColor9Change
        end
      end
      object GroupBox31: TGroupBox
        Left = 128
        Top = 8
        Width = 97
        Height = 233
        Caption = #21319#32423#26432#24618#25968
        TabOrder = 2
        object Label61: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object Label63: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object Label78: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object Label79: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object Label80: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object Label81: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object Label82: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object Label83: TLabel
          Left = 11
          Top = 184
          Width = 30
          Height = 12
          Caption = #22522#25968':'
        end
        object Label84: TLabel
          Left = 11
          Top = 208
          Width = 30
          Height = 12
          Caption = #20493#29575':'
        end
        object EditMonUpgradeKillCount1: TSpinEdit
          Left = 40
          Top = 12
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeKillCount1Change
        end
        object EditMonUpgradeKillCount2: TSpinEdit
          Left = 40
          Top = 36
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeKillCount2Change
        end
        object EditMonUpgradeKillCount3: TSpinEdit
          Left = 40
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeKillCount3Change
        end
        object EditMonUpgradeKillCount4: TSpinEdit
          Left = 40
          Top = 84
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeKillCount4Change
        end
        object EditMonUpgradeKillCount5: TSpinEdit
          Left = 40
          Top = 108
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeKillCount5Change
        end
        object EditMonUpgradeKillCount6: TSpinEdit
          Left = 40
          Top = 132
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeKillCount6Change
        end
        object EditMonUpgradeKillCount7: TSpinEdit
          Left = 40
          Top = 156
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeKillCount7Change
        end
        object EditMonUpLvNeedKillBase: TSpinEdit
          Left = 40
          Top = 180
          Width = 49
          Height = 21
          Hint = #26432#24618#25968#37327'='#31561#32423' * '#20493#29575' + '#31561#32423' + '#22522#25968' + '#27599#32423#25968#37327
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpLvNeedKillBaseChange
        end
        object EditMonUpLvRate: TSpinEdit
          Left = 40
          Top = 204
          Width = 49
          Height = 21
          Hint = #26432#24618#25968#37327'='#24618#29289#31561#32423' * '#20493#29575' + '#31561#32423' + '#22522#25968' + '#27599#32423#25968#37327
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpLvRateChange
        end
      end
      object GroupBox35: TGroupBox
        Left = 232
        Top = 8
        Width = 137
        Height = 113
        Caption = #20027#20154#27515#20129#25511#21046
        TabOrder = 3
        object Label88: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #21464#24322#26426#29575':'
        end
        object Label90: TLabel
          Left = 11
          Top = 64
          Width = 54
          Height = 12
          Caption = #22686#21152#25915#20987':'
        end
        object Label92: TLabel
          Left = 11
          Top = 88
          Width = 54
          Height = 12
          Caption = #22686#21152#36895#24230':'
        end
        object CheckBoxMasterDieMutiny: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #20027#20154#27515#20129#21518#21464#24322
          TabOrder = 0
          OnClick = CheckBoxMasterDieMutinyClick
        end
        object EditMasterDieMutinyRate: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          Hint = #25968#23383#36234#23567#65292#21464#24322#26426#29575#36234#22823#12290
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMasterDieMutinyRateChange
        end
        object EditMasterDieMutinyPower: TSpinEdit
          Left = 72
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMasterDieMutinyPowerChange
        end
        object EditMasterDieMutinySpeed: TSpinEdit
          Left = 72
          Top = 84
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMasterDieMutinySpeedChange
        end
      end
      object GroupBox47: TGroupBox
        Left = 232
        Top = 128
        Width = 137
        Height = 73
        Caption = #19971#24425#23453#23453
        TabOrder = 4
        object Label112: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #26102#38388#38388#38548':'
        end
        object CheckBoxBBMonAutoChangeColor: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #23453#23453#33258#21160#21464#33394
          TabOrder = 0
          OnClick = CheckBoxBBMonAutoChangeColorClick
        end
        object EditBBMonAutoChangeColorTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          Hint = #25968#23383#36234#23567#65292#21464#33394#36895#24230#36234#24555#65292#21333#20301'('#31186')'#12290
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = EditBBMonAutoChangeColorTimeChange
        end
      end
    end
    object MonSaySheet: TTabSheet
      Caption = #24618#29289#35828#35805
      object GroupBox40: TGroupBox
        Left = 8
        Top = 8
        Width = 137
        Height = 49
        Caption = #24618#29289#35828#35805
        TabOrder = 0
        object CheckBoxMonSayMsg: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #24320#21551#24618#29289#35828#35805
          TabOrder = 0
          OnClick = CheckBoxMonSayMsgClick
        end
      end
      object ButtonMonSayMsgSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonMonSayMsgSaveClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = #25216#33021#39764#27861
      ImageIndex = 1
      object MagicPageControl: TPageControl
        Left = 0
        Top = 0
        Width = 449
        Height = 273
        ActivePage = TabSheet36
        MultiLine = True
        TabOrder = 0
        object TabSheet36: TTabSheet
          Caption = #22522#26412#21442#25968
          ImageIndex = 31
          object GroupBox17: TGroupBox
            Left = 8
            Top = 8
            Width = 145
            Height = 49
            Caption = #39764#27861#25915#20987#33539#22260#38480#21046
            TabOrder = 0
            object Label12: TLabel
              Left = 8
              Top = 18
              Width = 54
              Height = 12
              Caption = #33539#22260#22823#23567':'
            end
            object EditMagicAttackRage: TSpinEdit
              Left = 68
              Top = 15
              Width = 53
              Height = 21
              Hint = #39764#27861#25915#20987#26377#25928#36317#31163#65292#36229#36807#25351#23450#36317#31163#25915#20987#26080#25928#12290
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMagicAttackRageChange
            end
          end
          object GroupBox100: TGroupBox
            Left = 8
            Top = 64
            Width = 145
            Height = 49
            Caption = #23453#23453#35774#32622
            TabOrder = 1
            object CheckSlaveMoveMaster: TCheckBox
              Left = 8
              Top = 18
              Width = 129
              Height = 17
              Hint = #24050#25307#21484#20986#26469#30340#23453#23453','#20877#25353#24555#25463#38190','#21017#23453#23453#39134#21040#20027#20154#36523#36793
              Caption = #25307#20986#26469#30340#39134#21040#20027#20154#26049
              TabOrder = 0
              OnClick = CheckSlaveMoveMasterClick
            end
          end
        end
        object TabSheet8: TTabSheet
          Caption = #27494#22763#25216#33021
          ImageIndex = 24
          object PageControl1: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 246
            ActivePage = TabSheet5
            Align = alClient
            TabOrder = 0
            object TabSheet9: TTabSheet
              Caption = #21050#26432#21073#26415
              object GroupBox9: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #26080#38480#21050#26432
                TabOrder = 0
                object CheckBoxLimitSwordLong: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23558#26816#26597#26816#26597#38548#20301#26159#21542#26377#35282#33394#23384#22312#65292#20197#31105#27490#20992#20992#21050#26432#12290
                  Caption = #31105#27490#26080#38480#21050#26432
                  TabOrder = 0
                  OnClick = CheckBoxLimitSwordLongClick
                end
              end
              object GroupBox10: TGroupBox
                Left = 8
                Top = 56
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 1
                object Label4: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label10: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSwordLongPowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSwordLongPowerRateChange
                end
              end
            end
            object TabSheet10: TTabSheet
              Caption = #24443#22320#38025
              ImageIndex = 1
              object GroupBox56: TGroupBox
                Left = 8
                Top = 8
                Width = 185
                Height = 57
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                object Label119: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label120: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditSkill39Sec: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkill39SecChange
                end
              end
              object GroupBox57: TGroupBox
                Left = 200
                Top = 8
                Width = 185
                Height = 57
                Caption = #20801#35768'PK'
                TabOrder = 1
                object CheckBoxDedingAllowPK: TCheckBox
                  Left = 16
                  Top = 24
                  Width = 97
                  Height = 17
                  Caption = #20801#35768'PK'
                  TabOrder = 0
                  OnClick = CheckBoxDedingAllowPKClick
                end
              end
              object GroupBox52: TGroupBox
                Left = 8
                Top = 71
                Width = 185
                Height = 56
                Caption = #25216#33021#21442#25968
                TabOrder = 2
                object Label135: TLabel
                  Left = 8
                  Top = 26
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditDidingPowerRate: TSpinEdit
                  Left = 96
                  Top = 22
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20056#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnClick = SpinEditDidingPowerRateClick
                end
              end
            end
            object TabSheet23: TTabSheet
              Caption = #29422#23376#21564
              ImageIndex = 2
              object GroupBox48: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #23545#20154#29289#26377#25928
                TabOrder = 0
                object CheckBoxGroupMbAttackPlayObject: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23601#21487#20197#40635#30201#20154#29289
                  Caption = #20801#35768#40635#30201#20154#29289
                  TabOrder = 0
                  OnClick = CheckBoxGroupMbAttackPlayObjectClick
                end
              end
              object GroupBox54: TGroupBox
                Left = 128
                Top = 8
                Width = 121
                Height = 41
                Caption = #23545#23453#23453#26377#25928
                TabOrder = 1
                object CheckBoxGroupMbAttackSlave: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Caption = #20801#35768#40635#30201#23453#23453
                  TabOrder = 0
                  OnClick = CheckBoxGroupMbAttackSlaveClick
                end
              end
            end
            object TabSheet24: TTabSheet
              Caption = #25810#40857#25163
              ImageIndex = 3
              object GroupBox50: TGroupBox
                Left = 8
                Top = 8
                Width = 161
                Height = 65
                Caption = #26159#21542#21487#20197#25235#20154#29289
                TabOrder = 0
                object CheckBoxPullPlayObject: TCheckBox
                  Left = 16
                  Top = 16
                  Width = 89
                  Height = 17
                  Caption = #20801#35768#25235#20154#29289
                  TabOrder = 0
                  OnClick = CheckBoxPullPlayObjectClick
                end
                object CheckBoxPullCrossInSafeZone: TCheckBox
                  Left = 16
                  Top = 40
                  Width = 121
                  Height = 17
                  Caption = #31105#27490#25235#23433#20840#21306#20154#29289
                  TabOrder = 1
                  OnClick = CheckBoxPullCrossInSafeZoneClick
                end
              end
            end
            object TabSheet27: TTabSheet
              Caption = #24320#22825#26025
              ImageIndex = 4
              object GroupBox71: TGroupBox
                Left = 8
                Top = 8
                Width = 153
                Height = 57
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                object Label144: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label145: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditKill43Sec: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditKill43SecChange
                end
              end
              object GroupBox74: TGroupBox
                Left = 8
                Top = 72
                Width = 153
                Height = 67
                Caption = #37325#20987#35774#32622
                TabOrder = 1
                object Label151: TLabel
                  Left = 8
                  Top = 21
                  Width = 60
                  Height = 12
                  Caption = #37325#20987#20960#29575#65306
                end
                object Label152: TLabel
                  Left = 8
                  Top = 45
                  Width = 60
                  Height = 12
                  Caption = #25915#20987#20493#25968#65306
                end
                object Spin43KillHitRateEdt: TSpinEdit
                  Left = 68
                  Top = 16
                  Width = 53
                  Height = 21
                  Hint = #25968#23383#36234#23567#65292#37325#20987#27425#25968#36234#22810#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 6
                  OnChange = Spin43KillHitRateEdtChange
                end
                object Spin43KillAttackRateEdt: TSpinEdit
                  Left = 68
                  Top = 41
                  Width = 53
                  Height = 21
                  Hint = #27604#22914#26222#36890#25915#20987#21147#20026'10'#37027#20040'2'#20493#20026'20,'#20381#27425#24448#21518#25512','#26368#22823#20026'10'#20493
                  EditorEnabled = False
                  MaxValue = 10
                  MinValue = 1
                  TabOrder = 1
                  Value = 2
                  OnChange = Spin43KillAttackRateEdtChange
                end
              end
              object GroupBox75: TGroupBox
                Left = 176
                Top = 8
                Width = 161
                Height = 56
                Caption = #25915#20987#21147
                TabOrder = 2
                object Label153: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditAttackRate_43: TSpinEdit
                  Left = 74
                  Top = 20
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditAttackRate_43Change
                end
              end
            end
            object TabSheet5: TTabSheet
              Caption = #40857#24433#21073#27861
              ImageIndex = 5
              object GroupBox72: TGroupBox
                Left = 7
                Top = 4
                Width = 163
                Height = 97
                Caption = #40644#26465#27668#27133
                Enabled = False
                TabOrder = 0
                object Label148: TLabel
                  Left = 8
                  Top = 24
                  Width = 66
                  Height = 12
                  Caption = #27668#27133#26368#22823#20540':'
                  Enabled = False
                end
                object Label149: TLabel
                  Left = 8
                  Top = 48
                  Width = 78
                  Height = 12
                  Caption = #27668#27133#27599#27425#22686#21152':'
                  Enabled = False
                end
                object Label150: TLabel
                  Left = 8
                  Top = 72
                  Width = 78
                  Height = 12
                  Caption = #20351#29992#27599#27425#20943#23569':'
                  Enabled = False
                end
                object EditMaxDragonPoint: TSpinEdit
                  Left = 105
                  Top = 20
                  Width = 53
                  Height = 21
                  EditorEnabled = False
                  Enabled = False
                  MaxValue = 10000
                  MinValue = 0
                  TabOrder = 0
                  Value = 40
                  OnChange = EditMaxDragonPointChange
                end
                object EditAddDragonPoint: TSpinEdit
                  Left = 105
                  Top = 44
                  Width = 53
                  Height = 21
                  EditorEnabled = False
                  Enabled = False
                  MaxValue = 10000
                  MinValue = 0
                  TabOrder = 1
                  Value = 40
                  OnChange = EditAddDragonPointChange
                end
                object EditDecDragonPoint: TSpinEdit
                  Left = 105
                  Top = 68
                  Width = 53
                  Height = 21
                  EditorEnabled = False
                  Enabled = False
                  MaxValue = 10000
                  MinValue = 0
                  TabOrder = 2
                  Value = 40
                  OnChange = EditDecDragonPointChange
                end
              end
              object GroupBox76: TGroupBox
                Left = 176
                Top = 4
                Width = 161
                Height = 47
                Caption = #25915#20987#21147
                TabOrder = 1
                object Label154: TLabel
                  Left = 10
                  Top = 21
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditAttackRate_42: TSpinEdit
                  Left = 74
                  Top = 17
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditAttackRate_2Change
                end
              end
              object GroupBox77: TGroupBox
                Left = 176
                Top = 55
                Width = 161
                Height = 46
                Caption = #25915#20987#33539#22260
                TabOrder = 2
                object Label155: TLabel
                  Left = 10
                  Top = 20
                  Width = 60
                  Height = 12
                  Caption = #33539#22260#22823#23567#65306
                end
                object EditMagicAttackRage_42: TSpinEdit
                  Left = 74
                  Top = 16
                  Width = 81
                  Height = 21
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 3
                  OnChange = EditMagicAttackRage_42Change
                end
              end
              object GroupBox88: TGroupBox
                Left = 8
                Top = 104
                Width = 161
                Height = 49
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 3
                object Label171: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label173: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditKill42Sec: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditKill42SecChange
                end
              end
            end
            object TabSheet31: TTabSheet
              Caption = #36880#26085#21073#27861
              ImageIndex = 6
              object GroupBox83: TGroupBox
                Left = 8
                Top = 8
                Width = 161
                Height = 56
                Caption = #25915#20987#21147
                TabOrder = 0
                object Label165: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditAttackRate_74: TSpinEdit
                  Left = 74
                  Top = 20
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'#13#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'200'#13#23454#38469#23041#21147'=100*(200/100)=200'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = SpinEditAttackRate_74Change
                end
              end
            end
            object TabSheet52: TTabSheet
              Caption = #28872#28779#21073#27861
              ImageIndex = 7
              object GroupBox110: TGroupBox
                Left = 8
                Top = 8
                Width = 161
                Height = 56
                Caption = #25915#20987#21147
                TabOrder = 0
                object Label232: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditAttackRate_26: TSpinEdit
                  Left = 74
                  Top = 20
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'#13#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'200'#13#23454#38469#23041#21147'=100*(200/100)=200'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = SpinEditAttackRate_26Change
                end
              end
            end
          end
        end
        object TabSheet11: TTabSheet
          Caption = #27861#24072#25216#33021
          ImageIndex = 23
          object PageControl2: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 246
            ActivePage = TabSheet12
            Align = alClient
            TabOrder = 0
            object TabSheet12: TTabSheet
              Caption = #20912#21638#21742
              object GroupBox14: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label8: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditSnowWindRange: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditSnowWindRangeChange
                end
              end
            end
            object TabSheet13: TTabSheet
              Caption = #29190#35010#28779#28976
              ImageIndex = 1
              object GroupBox13: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label7: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditFireBoomRage: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditFireBoomRageChange
                end
              end
            end
            object TabSheet14: TTabSheet
              Caption = #28779#22681
              ImageIndex = 2
              object GroupBox63: TGroupBox
                Left = 127
                Top = 8
                Width = 154
                Height = 41
                Caption = #25442#22320#22270#33258#21160#28040#22833
                TabOrder = 0
                object CheckBoxFireChgMapExtinguish: TCheckBox
                  Left = 13
                  Top = 13
                  Width = 108
                  Height = 17
                  Caption = #25442#22320#22270#33258#21160#28040#22833
                  TabOrder = 0
                  OnClick = CheckBoxFireChgMapExtinguishClick
                end
              end
              object GroupBox53: TGroupBox
                Left = 8
                Top = 55
                Width = 185
                Height = 74
                Caption = #25216#33021#21442#25968
                TabOrder = 1
                object Label117: TLabel
                  Left = 8
                  Top = 20
                  Width = 84
                  Height = 12
                  Caption = #26377#25928#26102#38388#20493#25968#65306
                end
                object Label116: TLabel
                  Left = 8
                  Top = 44
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditFireDelayTime: TSpinEdit
                  Left = 96
                  Top = 16
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditFireDelayTimeClick
                end
                object SpinEditFirePower: TSpinEdit
                  Left = 96
                  Top = 40
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 1
                  Value = 100
                  OnChange = SpinEditFirePowerClick
                end
              end
              object GroupBox46: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #23433#20840#21306#31105#27490#28779#22681
                TabOrder = 2
                object CheckBoxFireCrossInSafeZone: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#22312#23433#20840#21306#19981#20801#35768#25918#28779#22681#12290
                  Caption = #31105#27490#28779#22681
                  TabOrder = 0
                  OnClick = CheckBoxFireCrossInSafeZoneClick
                end
              end
            end
            object TabSheet15: TTabSheet
              Caption = #22307#35328#26415
              ImageIndex = 3
              object GroupBox37: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label97: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #31561#32423':'
                end
                object EditMagTurnUndeadLevel: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #25351#23450#31561#32423#20197#19979#30340#24618#29289#25165#20250#34987#22307#35328#65292#25351#23450#31561#32423#20197#19978#30340#24618#29289#22307#35328#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTurnUndeadLevelChange
                end
              end
            end
            object TabSheet16: TTabSheet
              Caption = #22320#29425#38647#20809
              ImageIndex = 4
              object GroupBox15: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label9: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditElecBlizzardRange: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditElecBlizzardRangeChange
                end
              end
            end
            object TabSheet17: TTabSheet
              Caption = #35825#24785#20043#20809
              ImageIndex = 5
              object GroupBox38: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label98: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #31561#32423':'
                end
                object EditMagTammingLevel: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #25351#23450#31561#32423#20197#19979#30340#24618#29289#25165#20250#34987#35825#24785#65292#25351#23450#31561#32423#20197#19978#30340#24618#29289#35825#24785#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingLevelChange
                end
              end
              object GroupBox45: TGroupBox
                Left = 128
                Top = 8
                Width = 113
                Height = 41
                Caption = #35825#24785#25968#37327
                TabOrder = 1
                object Label111: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #25968#37327':'
                end
                object EditTammingCount: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #21487#35825#24785#24618#29289#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditTammingCountChange
                end
              end
              object GroupBox39: TGroupBox
                Left = 8
                Top = 56
                Width = 113
                Height = 73
                Caption = #35825#24785#26426#29575
                TabOrder = 2
                object Label99: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#31561#32423':'
                end
                object Label100: TLabel
                  Left = 8
                  Top = 44
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#34880#37327':'
                end
                object EditMagTammingTargetLevel: TSpinEdit
                  Left = 64
                  Top = 15
                  Width = 41
                  Height = 21
                  Hint = #24618#29289#31561#32423#27604#29575#65292#27492#25968#23383#36234#23567#26426#29575#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingTargetLevelChange
                end
                object EditMagTammingHPRate: TSpinEdit
                  Left = 64
                  Top = 39
                  Width = 41
                  Height = 21
                  Hint = #24618#29289#34880#37327#27604#29575#65292#27492#25968#23383#36234#22823#65292#26426#29575#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 1
                  OnChange = EditMagTammingHPRateChange
                end
              end
            end
            object TabSheet18: TTabSheet
              Caption = #28779#28976#20912
              ImageIndex = 6
              object GroupBox41: TGroupBox
                Left = 8
                Top = 8
                Width = 145
                Height = 73
                Caption = #35282#33394#31561#32423#26426#29575#35774#32622
                TabOrder = 0
                object Label101: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #30456#24046#26426#29575':'
                end
                object Label102: TLabel
                  Left = 8
                  Top = 42
                  Width = 54
                  Height = 12
                  Caption = #30456#24046#38480#21046':'
                end
                object EditMabMabeHitRandRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#34987#25915#20987#21452#26041#30456#24046#31561#32423#21629#20013#26426#29575#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitRandRateChange
                end
                object EditMabMabeHitMinLvLimit: TSpinEdit
                  Left = 68
                  Top = 39
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#34987#25915#20987#21452#26041#30456#24046#31561#32423#21629#20013#26426#29575#65292#26368#23567#38480#21046#65292#25968#23383#36234#23567#26426#29575#36234#20302#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditMabMabeHitMinLvLimitChange
                end
              end
              object GroupBox43: TGroupBox
                Left = 160
                Top = 8
                Width = 145
                Height = 49
                Caption = #40635#30201#26102#38388#21442#25968#20493#29575
                TabOrder = 1
                object Label104: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #21629#20013#26426#29575':'
                end
                object EditMabMabeHitMabeTimeRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #40635#30201#26102#38388#38271#24230#20493#29575#65292#22522#25968#19982#35282#33394#30340#39764#27861#26377#20851#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitMabeTimeRateChange
                end
              end
              object GroupBox42: TGroupBox
                Left = 8
                Top = 88
                Width = 145
                Height = 49
                Caption = #40635#30201#21629#20013#26426#29575
                TabOrder = 2
                object Label103: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #21629#20013#26426#29575':'
                end
                object EditMabMabeHitSucessRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#40635#30201#26426#29575#65292#26368#23567#38480#21046#65292#25968#23383#36234#23567#26426#29575#36234#20302#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitSucessRateChange
                end
              end
            end
            object TabSheet19: TTabSheet
              Caption = #28781#22825#28779
              ImageIndex = 7
              object GroupBox51: TGroupBox
                Left = 8
                Top = 8
                Width = 121
                Height = 49
                Caption = #20943'MP'#20540
                TabOrder = 0
                object CheckBoxPlayObjectReduceMP: TCheckBox
                  Left = 16
                  Top = 16
                  Width = 97
                  Height = 17
                  Caption = #20987#20013#20943'MP'#20540
                  TabOrder = 0
                  OnClick = CheckBoxPlayObjectReduceMPClick
                end
              end
            end
            object TabSheet20: TTabSheet
              Caption = #20998#36523#26415
              ImageIndex = 8
              object GroupBox59: TGroupBox
                Left = 8
                Top = 8
                Width = 425
                Height = 145
                Caption = #21442#25968#37197#21046'(2)'
                TabOrder = 0
                object Label131: TLabel
                  Left = 16
                  Top = 24
                  Width = 84
                  Height = 12
                  Caption = #25112#22763#25915#20987#36895#24230#65306
                end
                object Label132: TLabel
                  Left = 16
                  Top = 48
                  Width = 84
                  Height = 12
                  Caption = #27861#24072#25915#20987#36895#24230#65306
                end
                object Label133: TLabel
                  Left = 16
                  Top = 72
                  Width = 84
                  Height = 12
                  Caption = #36947#22763#25915#20987#36895#24230#65306
                end
                object SpinEditWarrorAttackTime: TSpinEdit
                  Left = 104
                  Top = 20
                  Width = 121
                  Height = 21
                  Hint = #21333#20301#27627#31186
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = SpinEditWarrorAttackTimeChange
                end
                object SpinEditWizardAttackTime: TSpinEdit
                  Left = 104
                  Top = 44
                  Width = 121
                  Height = 21
                  Hint = #21333#20301#27627#31186
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  OnChange = SpinEditWizardAttackTimeChange
                end
                object SpinEditTaoistAttackTime: TSpinEdit
                  Left = 104
                  Top = 68
                  Width = 121
                  Height = 21
                  Hint = #21333#20301#27627#31186
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 2
                  Value = 0
                  OnChange = SpinEditTaoistAttackTimeChange
                end
                object GroupBox61: TGroupBox
                  Left = 232
                  Top = 16
                  Width = 185
                  Height = 73
                  Caption = #21484#21796#20854#20182#32844#19994#30340#20998#36523
                  TabOrder = 3
                  object CheckBoxNeedLevelHighTarget: TCheckBox
                    Left = 8
                    Top = 48
                    Width = 145
                    Height = 17
                    Hint = #22914#26524#19981#36873#25321#65292#23601#20250#20986#29616#19968#20010#31561#32423#19981#39640#30340#29609#23478#21484#21796#19968#20010#31561#32423#24456#39640#30340#20998#36523#12290
                    Caption = #31561#32423#24517#39035#22823#20110#30446#26631#31561#32423
                    TabOrder = 0
                    OnClick = CheckBoxNeedLevelHighTargetClick
                  end
                  object CheckBoxAllowReCallMobOtherHum: TCheckBox
                    Left = 8
                    Top = 24
                    Width = 169
                    Height = 17
                    Hint = 
                      #36873#25321#36825#20010#21151#33021#21518#65292#20351#29992#20998#36523#26415#26102#65292#23601#20250#20197#40736#26631#36873#25321#30340#20154#29289#20026#23545#35937#65292#23436#20840#22797#21046#19968#20010#31561#32423#12289#32844#19994#12289#24615#21035#12289#36523#19978#35013#22791#23436#20840#21644#20320#36873#25321#30340#20154#29289#19968#27169#19968#26679#30340#20998#36523 +
                      #12290
                    Caption = #20801#35768#20197#30446#26631#20026#23545#35937#21484#21796#20998#36523
                    TabOrder = 1
                    OnClick = CheckBoxAllowReCallMobOtherHumClick
                  end
                end
                object GroupBox73: TGroupBox
                  Left = 16
                  Top = 94
                  Width = 185
                  Height = 47
                  Caption = #21484#21796#20998#36523#38388#38548
                  TabOrder = 4
                  object Label146: TLabel
                    Left = 16
                    Top = 24
                    Width = 36
                    Height = 12
                    Caption = #26102#38388#65306
                  end
                  object Label147: TLabel
                    Left = 120
                    Top = 24
                    Width = 12
                    Height = 12
                    Caption = #31186
                  end
                  object SpinEditnCopyHumanTick: TSpinEdit
                    Left = 56
                    Top = 20
                    Width = 57
                    Height = 21
                    MaxValue = 100
                    MinValue = 0
                    TabOrder = 0
                    Value = 10
                    OnChange = SpinEditnCopyHumanTickChange
                  end
                end
                object GroupBox79: TGroupBox
                  Left = 232
                  Top = 93
                  Width = 160
                  Height = 47
                  Caption = #20998#36523#20351#29992#26102#38388
                  TabOrder = 5
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
                  object SpinEditMakeSelfTick: TSpinEdit
                    Left = 56
                    Top = 20
                    Width = 57
                    Height = 21
                    Hint = #21484#21796#20998#36523#21518','#22810#23569#26102#38388#21518#33258#21160#28040#22833
                    MaxValue = 65535
                    MinValue = 0
                    TabOrder = 0
                    Value = 10
                    OnChange = SpinEditMakeSelfTickChange
                  end
                end
              end
            end
            object TabSheet21: TTabSheet
              Caption = #20998#36523#26415
              ImageIndex = 9
              object GroupBox60: TGroupBox
                Left = 8
                Top = 8
                Width = 425
                Height = 97
                Caption = #20986#29983#21518#21253#35065#20013#25918#20837#29289#21697
                TabOrder = 0
                object Label128: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #25112#22763#65306
                end
                object Label129: TLabel
                  Left = 16
                  Top = 48
                  Width = 36
                  Height = 12
                  Caption = #27861#24072#65306
                end
                object Label130: TLabel
                  Left = 16
                  Top = 72
                  Width = 36
                  Height = 12
                  Caption = #36947#22763#65306
                end
                object EditBagItems1: TEdit
                  Left = 56
                  Top = 20
                  Width = 361
                  Height = 20
                  TabOrder = 0
                  OnChange = EditBagItems1Change
                end
                object EditBagItems2: TEdit
                  Left = 56
                  Top = 44
                  Width = 361
                  Height = 20
                  TabOrder = 1
                  OnChange = EditBagItems2Change
                end
                object EditBagItems3: TEdit
                  Left = 56
                  Top = 68
                  Width = 361
                  Height = 20
                  TabOrder = 2
                  OnChange = EditBagItems3Change
                end
              end
            end
            object TabSheet22: TTabSheet
              Caption = #20998#36523#26415
              ImageIndex = 10
              object GroupBox58: TGroupBox
                Left = 8
                Top = 8
                Width = 425
                Height = 145
                Caption = #21442#25968#37197#21046'(1)'
                TabOrder = 0
                object Label121: TLabel
                  Left = 16
                  Top = 24
                  Width = 84
                  Height = 12
                  Caption = #20801#35768#20998#36523#25968#37327#65306
                end
                object Label122: TLabel
                  Left = 16
                  Top = 48
                  Width = 60
                  Height = 12
                  Caption = #20998#36523#21517#31216#65306
                end
                object Label123: TLabel
                  Left = 16
                  Top = 72
                  Width = 132
                  Height = 12
                  Caption = #20801#35768#21253#34993#20013#25441#33647#21697#25968#37327#65306
                end
                object Label124: TLabel
                  Left = 16
                  Top = 96
                  Width = 108
                  Height = 12
                  Caption = #34880#20540#20302#20110#24635#34880#20540#30340#65306
                end
                object Label125: TLabel
                  Left = 16
                  Top = 120
                  Width = 132
                  Height = 12
                  Caption = #39764#27861#20540#20302#20110#24635#39764#27861#20540#30340#65306
                end
                object Label126: TLabel
                  Left = 248
                  Top = 96
                  Width = 72
                  Height = 12
                  Caption = '% '#26102#24320#22987#21507#33647
                end
                object Label127: TLabel
                  Left = 248
                  Top = 120
                  Width = 72
                  Height = 12
                  Caption = '% '#26102#24320#22987#21507#33647
                end
                object Label161: TLabel
                  Left = 289
                  Top = 24
                  Width = 54
                  Height = 12
                  Caption = #21517#23383#39068#33394':'
                end
                object LabelCopyHumNameColor: TLabel
                  Left = 387
                  Top = 21
                  Width = 9
                  Height = 17
                  AutoSize = False
                  Color = clBackground
                  ParentColor = False
                end
                object SpinEditAllowCopyCount: TSpinEdit
                  Left = 144
                  Top = 20
                  Width = 121
                  Height = 21
                  Hint = #20801#35768#20998#36523#30340#25968#37327
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = SpinEditAllowCopyCountChange
                end
                object EditCopyHumName: TEdit
                  Left = 144
                  Top = 44
                  Width = 121
                  Height = 20
                  TabOrder = 1
                  OnChange = EditCopyHumNameChange
                end
                object CheckBoxMasterName: TCheckBox
                  Left = 272
                  Top = 44
                  Width = 137
                  Height = 17
                  Caption = #20351#29992#20027#20154#21517#31216#20570#21069#32512
                  TabOrder = 2
                  OnClick = CheckBoxMasterNameClick
                end
                object SpinEditPickUpItemCount: TSpinEdit
                  Left = 144
                  Top = 68
                  Width = 121
                  Height = 21
                  Hint = 
                    #20998#36523#21487#20197#25441#21462#33647#29289#30340#25968#37327#65292#20998#36523#25441#21040#33647#29289#65292#21253#35065#20013#27809#26377#36229#36807#35774#23450#30340#25968#20540#26102#65292#25165#20250#25918#21040#33258#24049#21253#35065#20013#12290#25441#21040#20854#20182#29289#21697#65292#25110#32773#21253#35065#24050#32463#36229#36807#35774#23450#30340#25968#20540#26102 +
                    #65292#30452#25509#25918#21040#20027#20154#30340#21253#35065#20013#12290
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 3
                  Value = 0
                  OnChange = SpinEditPickUpItemCountChange
                end
                object SpinEditEatHPItemRate: TSpinEdit
                  Left = 144
                  Top = 92
                  Width = 97
                  Height = 21
                  MaxValue = 100
                  MinValue = 1
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 4
                  Value = 60
                  OnChange = SpinEditEatHPItemRateChange
                end
                object SpinEditEatMPItemRate: TSpinEdit
                  Left = 144
                  Top = 116
                  Width = 97
                  Height = 21
                  MaxValue = 100
                  MinValue = 1
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 5
                  Value = 60
                  OnChange = SpinEditEatMPItemRateChange
                end
                object CheckBoxAllowGuardAttack: TCheckBox
                  Left = 272
                  Top = 72
                  Width = 121
                  Height = 17
                  Caption = #20801#35768#22823#20992#25915#20987#20998#36523
                  TabOrder = 6
                  OnClick = CheckBoxAllowGuardAttackClick
                end
                object EditCopyHumNameColor: TSpinEdit
                  Left = 343
                  Top = 19
                  Width = 43
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 0
                  TabOrder = 7
                  Value = 100
                  OnChange = EditCopyHumNameColorChange
                end
              end
            end
            object TabSheet29: TTabSheet
              Caption = #27969#26143#28779#38632
              ImageIndex = 11
              object GroupBox81: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label162: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditMeteorFireRainRage: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMeteorFireRainRageChange
                end
              end
            end
            object TabSheet48: TTabSheet
              Caption = #39764#27861#30462
              ImageIndex = 12
              object GroupBox104: TGroupBox
                Left = 8
                Top = 6
                Width = 120
                Height = 67
                Caption = #39764#27861#30462#25928#26524
                TabOrder = 0
                object RadioboSkill31EffectFalse: TRadioButton
                  Left = 24
                  Top = 17
                  Width = 76
                  Height = 17
                  Caption = #30427#22823#25928#26524
                  TabOrder = 0
                  OnClick = RadioboSkill31EffectFalseClick
                end
                object RadioboSkill31EffectTrue: TRadioButton
                  Left = 24
                  Top = 40
                  Width = 78
                  Height = 17
                  Caption = #29305#33394#25928#26524
                  Enabled = False
                  TabOrder = 1
                  OnClick = RadioboSkill31EffectTrueClick
                end
              end
              object GroupBox105: TGroupBox
                Left = 8
                Top = 80
                Width = 121
                Height = 53
                Caption = #22235#32423#30462#25269#24481#20260#23475
                TabOrder = 1
                object Label222: TLabel
                  Left = 10
                  Top = 24
                  Width = 96
                  Height = 12
                  Caption = #20260#23475#65306'         %'
                end
                object SpinEditSkill66Rate: TSpinEdit
                  Left = 50
                  Top = 20
                  Width = 43
                  Height = 21
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 75
                  OnChange = SpinEditSkill66RateChange
                end
              end
              object GroupBox114: TGroupBox
                Left = 8
                Top = 140
                Width = 121
                Height = 53
                Caption = #26222#36890#30462#25269#24481#20260#23475
                TabOrder = 2
                object Label237: TLabel
                  Left = 10
                  Top = 24
                  Width = 96
                  Height = 12
                  Caption = #20260#23475#65306'         %'
                end
                object SpinEditOrdinarySkill66Rate: TSpinEdit
                  Left = 50
                  Top = 20
                  Width = 43
                  Height = 21
                  Hint = #22914#35774#32622#20026'15%,'#21017'0'#32423#39764#27861#30462#25269#24481'15%,1'#32423'-30%,2'#32423'-45%,3'#32423'-60%'
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 15
                  OnChange = SpinEditOrdinarySkill66RateChange
                end
              end
            end
          end
        end
        object TabSheet25: TTabSheet
          Caption = #36947#22763#25216#33021
          ImageIndex = 11
          object PageControl3: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 246
            ActivePage = TabSheet26
            Align = alClient
            MultiLine = True
            TabOrder = 0
            object TabSheet26: TTabSheet
              Caption = #21484#21796#39607#39621
              object GroupBox5: TGroupBox
                Left = 5
                Top = 2
                Width = 132
                Height = 135
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label2: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label3: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditBoneFammName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  TabOrder = 0
                  OnChange = EditBoneFammNameChange
                end
                object EditBoneFammCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditBoneFammCountChange
                end
              end
              object GroupBox6: TGroupBox
                Left = 144
                Top = 2
                Width = 289
                Height = 135
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridBoneFamm: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 113
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet3: TTabSheet
              Caption = #21484#21796#31070#20861
              ImageIndex = 1
              object GroupBox11: TGroupBox
                Left = 5
                Top = 2
                Width = 132
                Height = 135
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label5: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label6: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditDogzName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  TabOrder = 0
                  OnChange = EditDogzNameChange
                end
                object EditDogzCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditDogzCountChange
                end
              end
              object GroupBox12: TGroupBox
                Left = 144
                Top = 2
                Width = 289
                Height = 135
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridDogz: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 113
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet4: TTabSheet
              Caption = #26045#27602#26415
              ImageIndex = 2
              object GroupBox16: TGroupBox
                Left = 8
                Top = 8
                Width = 137
                Height = 49
                Caption = #27602#33647#38477#28857
                TabOrder = 0
                object Label11: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #28857#25968#25511#21046':'
                end
                object EditAmyOunsulPoint: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #20013#27602#21518#25351#23450#26102#38388#20869#38477#28857#25968#65292#23454#38469#28857#25968#36319#25216#33021#31561#32423#21450#26412#36523#36947#26415#39640#20302#26377#20851#65292#27492#21442#25968#21482#26159#35843#20854#20013#31639#27861#21442#25968#65292#27492#25968#23383#36234#23567#65292#28857#25968#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditAmyOunsulPointChange
                end
              end
            end
            object TabSheet6: TTabSheet
              Caption = #28789#39746#28779#31526
              ImageIndex = 3
              object GroupBox80: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 57
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object AutoCanHit: TCheckBox
                  Left = 16
                  Top = 24
                  Width = 81
                  Height = 17
                  Hint = #28779#31526#12289#28779#29699#26234#33021#38145#23450#24320#20851#65288#30446#26631#31227#21160#36895#24230#36739#24555#65292#24320#21551#21151#33021#21518'100%'#25171#20013#30446#26631')'
                  Caption = #26234#33021#38145#23450' '
                  TabOrder = 0
                  OnClick = AutoCanHitClick
                end
              end
            end
            object TabSheet7: TTabSheet
              Caption = #21484#21796#26376#28789
              ImageIndex = 4
              object GroupBox64: TGroupBox
                Left = 5
                Top = 2
                Width = 132
                Height = 135
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label134: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label136: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object Label137: TLabel
                  Left = 8
                  Top = 91
                  Width = 54
                  Height = 12
                  Caption = #37325#20987#20960#29575':'
                end
                object Label138: TLabel
                  Left = 8
                  Top = 113
                  Width = 54
                  Height = 12
                  Caption = #25915#20987#20493#25968':'
                end
                object FairyNameEdt: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  TabOrder = 0
                  OnChange = FairyNameEdtChange
                end
                object SpinFairyEdt: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = SpinFairyEdtChange
                end
                object SpinFairyDuntRateEdt: TSpinEdit
                  Left = 60
                  Top = 87
                  Width = 53
                  Height = 21
                  Hint = #25968#23383#36234#23567#65292#37325#20987#27425#25968#36234#22810#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 2
                  Value = 6
                  OnChange = SpinFairyDuntRateEdtChange
                end
                object SpinFairyAttackRateEdt: TSpinEdit
                  Left = 60
                  Top = 110
                  Width = 53
                  Height = 21
                  Hint = #27604#22914#26376#28789#25915#26222#36890#25915#20987#21147#20026'10'#37027#20040'2'#20493#20026'20,'#20381#27425#24448#21518#25512','#26368#22823#20026'10'#20493
                  EditorEnabled = False
                  MaxValue = 10
                  MinValue = 1
                  TabOrder = 3
                  Value = 2
                  OnChange = SpinFairyAttackRateEdtChange
                end
              end
              object GroupBox65: TGroupBox
                Left = 144
                Top = 2
                Width = 289
                Height = 135
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridFairy: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 113
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridFairySetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet30: TTabSheet
              Caption = #22124#34880#26415
              ImageIndex = 5
              object GroupBox82: TGroupBox
                Left = 7
                Top = 8
                Width = 148
                Height = 56
                Caption = #21152#34880#30334#20998#27604
                TabOrder = 0
                object Label163: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #27604#20363#65306
                end
                object Label164: TLabel
                  Left = 112
                  Top = 24
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditMagFireCharmTreatment: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 49
                  Height = 21
                  Hint = #24618#29289#25481#34880','#33021#33258#24049#21152#34880#30340#30334#20998#29575','#13#21363#20540#20026'50%,'#25216#33021#20351#24618#25481'100'#34880','#20154#29289#21152'50'#34880
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = EditMagFireCharmTreatmentChange
                end
              end
            end
            object TabSheet41: TTabSheet
              Caption = #26080#26497#30495#27668
              ImageIndex = 6
              object GroupBox85: TGroupBox
                Left = 6
                Top = 5
                Width = 145
                Height = 52
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                object Label167: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label168: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditAbilityUpTick: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditAbilityUpTickChange
                end
              end
              object GroupBox86: TGroupBox
                Left = 6
                Top = 61
                Width = 145
                Height = 76
                Caption = #25345#32493#26102#38271#35774#32622
                TabOrder = 1
                object Label169: TLabel
                  Left = 16
                  Top = 48
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label170: TLabel
                  Left = 120
                  Top = 48
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label231: TLabel
                  Left = 127
                  Top = 20
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditAbilityUpUseTime: TSpinEdit
                  Left = 56
                  Top = 44
                  Width = 57
                  Height = 21
                  Hint = #22312#21407#22522#30784#19978#22686#21152#20351#29992#26102#38388
                  Enabled = False
                  MaxValue = 255
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditAbilityUpUseTimeChange
                end
                object CheckBoxAbilityUpFixMode: TCheckBox
                  Left = 13
                  Top = 18
                  Width = 73
                  Height = 17
                  Hint = #25216#33021#26102#38271#19982#25216#33021#31561#32423#26080#20851','
                  Caption = #22266#23450#26102#38271
                  TabOrder = 1
                  OnClick = CheckBoxAbilityUpFixModeClick
                end
                object SpinEditAbilityUpFixUseTime: TSpinEdit
                  Left = 81
                  Top = 15
                  Width = 44
                  Height = 21
                  Hint = #22266#23450#20351#29992#26102#38388
                  Enabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = SpinEditAbilityUpFixUseTimeChange
                end
              end
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #36890#29992#25216#33021
          ImageIndex = 5
          object PageControl4: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 246
            ActivePage = TabSheet28
            Align = alClient
            TabOrder = 0
            object TabSheet28: TTabSheet
              Caption = #25252#20307#31070#30462
              object GroupBox66: TGroupBox
                Left = 7
                Top = 8
                Width = 148
                Height = 74
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label139: TLabel
                  Left = 16
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #26368#38271#26102#38388#65306
                end
                object Label140: TLabel
                  Left = 16
                  Top = 48
                  Width = 60
                  Height = 12
                  Caption = #20351#29992#38388#38548#65306
                end
                object Label156: TLabel
                  Left = 130
                  Top = 25
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label157: TLabel
                  Left = 129
                  Top = 49
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditProtectionDefenceTime: TSpinEdit
                  Left = 80
                  Top = 20
                  Width = 49
                  Height = 21
                  Hint = #25252#20307#31070#30462#26368#38271#26102#38388
                  MaxValue = 65535
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = EditProtectionDefenceTimeChange
                end
                object EditProtectionTick: TSpinEdit
                  Left = 80
                  Top = 44
                  Width = 48
                  Height = 21
                  Hint = #25252#20307#31070#30462#20351#29992#38388#38548
                  MaxValue = 65535
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  OnChange = EditProtectionTickChange
                end
              end
              object GroupBox67: TGroupBox
                Left = 7
                Top = 88
                Width = 148
                Height = 59
                Caption = #25252#20307#20943#25915#20987#30334#20998#27604
                TabOrder = 1
                object Label141: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #27604#20363#65306
                end
                object Label142: TLabel
                  Left = 112
                  Top = 24
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditProtectionRate: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 49
                  Height = 21
                  Hint = #25252#20307#31070#30462#20943#25915#20987#30334#20998#27604
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = EditProtectionRateChange
                end
              end
              object GroupBox69: TGroupBox
                Left = 8
                Top = 149
                Width = 148
                Height = 59
                Caption = #30462#34987#20987#30772#26426#29575
                TabOrder = 2
                object Label143: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26426#29575#65306
                end
                object EditProtectionBadRate: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 49
                  Height = 21
                  Hint = #25968#36234#23567'  '#20960#29575#36234#22823
                  MaxValue = 10
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = EditProtectionBadRateChange
                end
              end
              object GroupBox78: TGroupBox
                Left = 163
                Top = 119
                Width = 122
                Height = 89
                Caption = #20854#23427#35774#32622
                TabOrder = 3
                object ShowProtectionEnv: TCheckBox
                  Left = 13
                  Top = 58
                  Width = 97
                  Height = 17
                  Hint = #26174#31034#25252#20307#31070#30462#21160#30011#25928#26524
                  Caption = #26159#21542#26174#31034#25928#26524
                  TabOrder = 0
                  OnClick = ShowProtectionEnvClick
                end
                object AutoProtection: TCheckBox
                  Left = 13
                  Top = 30
                  Width = 97
                  Height = 17
                  Caption = #33258#21160#24320#21551#31070#30462
                  TabOrder = 1
                  OnClick = AutoProtectionClick
                end
              end
              object GroupBox70: TGroupBox
                Left = 164
                Top = 8
                Width = 121
                Height = 104
                Caption = #25915#20987#24517#30772#36873#39033
                TabOrder = 4
                object CheckRushkungBad: TCheckBox
                  Left = 16
                  Top = 19
                  Width = 97
                  Height = 17
                  Caption = #21050#26432#24517#30772
                  TabOrder = 0
                  OnClick = CheckRushkungBadClick
                end
                object CheckErgumBad: TCheckBox
                  Left = 16
                  Top = 79
                  Width = 97
                  Height = 17
                  Caption = #21512#20987#24517#30772
                  TabOrder = 1
                  OnClick = CheckErgumBadClick
                end
                object CheckFirehitBad: TCheckBox
                  Left = 16
                  Top = 40
                  Width = 97
                  Height = 17
                  Caption = #28872#28779#24517#30772
                  TabOrder = 2
                  OnClick = CheckFirehitBadClick
                end
                object CheckTwnhitBad: TCheckBox
                  Left = 16
                  Top = 60
                  Width = 97
                  Height = 17
                  Caption = #24320#22825#24517#30772
                  TabOrder = 3
                  OnClick = CheckTwnhitBadClick
                end
              end
              object GroupBox106: TGroupBox
                Left = 293
                Top = 8
                Width = 132
                Height = 59
                Caption = #29983#25928#26426#29575
                TabOrder = 5
                object Label223: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #27604#20363#65306
                end
                object Label224: TLabel
                  Left = 108
                  Top = 24
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object EditProtectionOKRate: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 49
                  Height = 21
                  Hint = #25252#20307#31070#30462#29983#25928#30340#26426#29575','#22914#35774#32622'10%,'#13#10#21017#26377'10%'#30340#26426#29575#21487#20197#25269#24481#20260#23475#13#10#25216#33021#27599#21319#19968#32423#22686#21152'3%'#30340#29983#25928#26426#29575
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = EditProtectionOKRateChange
                end
              end
            end
            object TabSheet43: TTabSheet
              Caption = #31227#34892#25442#20301
              ImageIndex = 1
              object GroupBox87: TGroupBox
                Left = 7
                Top = 8
                Width = 148
                Height = 46
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label172: TLabel
                  Left = 16
                  Top = 19
                  Width = 60
                  Height = 12
                  Caption = #20351#29992#38388#38548#65306
                end
                object Label174: TLabel
                  Left = 129
                  Top = 20
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditMagChangXY: TSpinEdit
                  Left = 80
                  Top = 15
                  Width = 48
                  Height = 21
                  Hint = #31227#34892#25442#20301#20351#29992#38388#38548
                  MaxValue = 65535
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = SpinEditMagChangXYChange
                end
              end
            end
            object TabSheet46: TTabSheet
              Caption = #37202#27668#25252#20307
              ImageIndex = 2
              object GroupBox94: TGroupBox
                Left = 182
                Top = 6
                Width = 145
                Height = 52
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                object Label191: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label192: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditHPUpTick: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditHPUpTickChange
                end
              end
              object GroupBox95: TGroupBox
                Left = 182
                Top = 61
                Width = 145
                Height = 52
                Caption = #25345#32493#26102#38388#22686#21152
                TabOrder = 1
                object Label193: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label194: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditHPUpUseTime: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  Hint = #22312#21407#22522#30784#19978#22686#21152#20351#29992#26102#38388
                  MaxValue = 255
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditHPUpUseTimeChange
                end
              end
              object GroupBox96: TGroupBox
                Left = 6
                Top = 5
                Width = 166
                Height = 193
                Caption = #21319#32423#32463#39564
                TabOrder = 2
                object GridSkill68: TStringGrid
                  Left = 6
                  Top = 15
                  Width = 153
                  Height = 171
                  ColCount = 2
                  DefaultRowHeight = 18
                  RowCount = 101
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
                  TabOrder = 0
                  OnEnter = GridSkill68Enter
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
                    18)
                end
              end
              object GroupBox98: TGroupBox
                Left = 182
                Top = 118
                Width = 146
                Height = 52
                Caption = #25216#33021#22833#25928#35774#32622
                TabOrder = 3
                object Label197: TLabel
                  Left = 8
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #37202#37327#20302#20110#65306
                end
                object Label198: TLabel
                  Left = 117
                  Top = 24
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object SpinEditMinDrinkValue68: TSpinEdit
                  Left = 64
                  Top = 20
                  Width = 50
                  Height = 21
                  Hint = #24403#37202#37327#20302#20110' '#24635#37202#37327'* '#35774#32622#20540'/100 '#26102','#25216#33021#26080#27861#20351#29992
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 5
                  OnChange = SpinEditMinDrinkValue68Change
                end
              end
            end
            object TabSheet47: TTabSheet
              Caption = #20808#22825#20803#21147
              ImageIndex = 3
              object GroupBox97: TGroupBox
                Left = 14
                Top = 6
                Width = 163
                Height = 52
                Caption = #25216#33021#22833#25928#35774#32622
                TabOrder = 0
                object Label195: TLabel
                  Left = 8
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #37202#37327#20302#20110#65306
                end
                object Label196: TLabel
                  Left = 128
                  Top = 24
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object SpinEditMinDrinkValue67: TSpinEdit
                  Left = 64
                  Top = 20
                  Width = 57
                  Height = 21
                  Hint = #24403#37202#37327#20302#20110' '#24635#37202#37327'* '#35774#32622#20540'/100 '#26102','#25216#33021#22833#25928
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 5
                  OnChange = SpinEditMinDrinkValue67Change
                end
              end
            end
          end
        end
        object TabSheet49: TTabSheet
          Caption = #20869#21151#25216#33021
          ImageIndex = 5
          object PageControl5: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 246
            ActivePage = TabSheet51
            Align = alClient
            TabOrder = 0
            object TabSheet51: TTabSheet
              Caption = #22522#26412#21442#25968
              object GroupBox107: TGroupBox
                Left = 4
                Top = 5
                Width = 177
                Height = 93
                Caption = #30456#20851#21442#25968
                TabOrder = 0
                object Label225: TLabel
                  Left = 20
                  Top = 20
                  Width = 72
                  Height = 12
                  Caption = #20869#21147#20540#21442#25968#65306
                end
                object Label226: TLabel
                  Left = 8
                  Top = 44
                  Width = 84
                  Height = 12
                  Caption = #20027#20307#32463#39564#21442#25968#65306
                end
                object Label227: TLabel
                  Left = 8
                  Top = 68
                  Width = 84
                  Height = 12
                  Caption = #33521#38596#32463#39564#21442#25968#65306
                end
                object SpinEditSkill69NG: TSpinEdit
                  Left = 96
                  Top = 16
                  Width = 65
                  Height = 21
                  Hint = #20869#32622#20844#24335#35745#31639#20986#30340#20540'+'#35774#32622#20540','#21363#20026#27599#20010#31561#32423#30340#20869#21147#20540#19978#38480#13#10#27880':'#26368#22823#20869#21147#20540#19978#38480#20026'65535.'#40664#35748#20540'10'
                  MaxValue = 50
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkill69NGChange
                end
                object SpinEditSkill69NGExp: TSpinEdit
                  Left = 96
                  Top = 40
                  Width = 65
                  Height = 21
                  Hint = #20869#32622#20844#24335#35745#31639#20986#30340#20540'+'#35774#32622#20540','#13#10#21363#20026#27599#20010#31561#32423#30340#21319#32423#25152#38656#30340#32463#39564#13#10#40664#35748#20540':55330'
                  MaxValue = 10000000
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = SpinEditSkill69NGExpChange
                end
                object SpinEditHeroSkill69NGExp: TSpinEdit
                  Left = 96
                  Top = 64
                  Width = 65
                  Height = 21
                  Hint = #20869#32622#20844#24335#35745#31639#20986#30340#20540'+'#35774#32622#20540','#13#10#21363#20026#27599#20010#31561#32423#30340#21319#32423#25152#38656#30340#32463#39564#13#10#40664#35748#20540':62400'
                  MaxValue = 10000000
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = SpinEditHeroSkill69NGExpChange
                end
              end
              object GroupBox108: TGroupBox
                Left = 4
                Top = 100
                Width = 178
                Height = 48
                Caption = #20869#21147#20540#30456#20851#35774#32622
                TabOrder = 1
                object Label228: TLabel
                  Left = 20
                  Top = 23
                  Width = 120
                  Height = 12
                  Caption = #38548'        '#31186#21152#20869#21147#20540
                end
                object SpinEditdwIncNHTime: TSpinEdit
                  Left = 35
                  Top = 19
                  Width = 45
                  Height = 21
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 8
                  OnChange = SpinEditdwIncNHTimeChange
                end
              end
              object GroupBox109: TGroupBox
                Left = 188
                Top = 6
                Width = 205
                Height = 92
                Caption = #20869#21151#30456#20851
                TabOrder = 2
                object Label229: TLabel
                  Left = 9
                  Top = 20
                  Width = 72
                  Height = 12
                  Caption = #39278#37202#22686#21152#32463#39564
                end
                object Label230: TLabel
                  Left = 5
                  Top = 44
                  Width = 132
                  Height = 12
                  Caption = #22686#21152#25915#20987'('#38450#24481')'#20943#20869#21147#20540
                end
                object SpinEditDrinkIncNHExp: TSpinEdit
                  Left = 87
                  Top = 15
                  Width = 74
                  Height = 21
                  Hint = #39278#37202#21487#20197#33719#24471#20869#21151#32463#39564#65292#37202#37327#36234#22823#65292#39278#29992#37202#30340#21697#36136#36234#39640#65292#13#10#33719#24471#20869#21151#32463#39564#36234#22810','#26377#37257#37202#24230#26102#27599#27425#22686#21152#30340#20869#21151#32463#39564
                  MaxValue = 100000000
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditDrinkIncNHExpChange
                end
                object SpinEditHitStruckDecNH: TSpinEdit
                  Left = 138
                  Top = 39
                  Width = 42
                  Height = 21
                  Hint = #20869#21151#23545#20110#26222#36890#25915#20987#38450#25269#24481','#38656#35201#28040#32791#30340#20869#21147#20540#13#10#20869#21151#23545#20110#22686#21152#25915#20987#21147','#38656#35201#28040#32791#30340#20869#21147#20540
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = SpinEditHitStruckDecNHChange
                end
              end
              object GroupBox111: TGroupBox
                Left = 188
                Top = 100
                Width = 155
                Height = 48
                Caption = #26432#24618#20869#21151#32463#39564
                TabOrder = 3
                object Label233: TLabel
                  Left = 27
                  Top = 22
                  Width = 30
                  Height = 12
                  Caption = #20493#29575':'
                end
                object EditKillMonNGExpMultiple: TSpinEdit
                  Left = 60
                  Top = 18
                  Width = 53
                  Height = 21
                  Hint = #26432#24618#25152#24471#30340#32463#39564'*'#27492#21442#25968'='#24471#21040#30340#20869#21151#32463#39564
                  EditorEnabled = False
                  MaxValue = 2000
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditKillMonNGExpMultipleChange
                end
              end
              object GroupBox112: TGroupBox
                Left = 4
                Top = 150
                Width = 179
                Height = 45
                Caption = #20869#21151#25216#33021
                TabOrder = 4
                object Label235: TLabel
                  Left = 10
                  Top = 19
                  Width = 156
                  Height = 12
                  Caption = #22686#24378#25915'('#38450')'#65306'          /100'
                end
                object SpinEditNGSkillRate: TSpinEdit
                  Left = 82
                  Top = 15
                  Width = 55
                  Height = 21
                  Hint = 
                    #20869#21151#25216#33021#27599#32423#21487#22686#21152#30340#23041#21147#27604#29575','#22914#28872#28779#23041#21147#20026'100,'#13#10#23398#20064'0'#32423#24594#20043#28872#28779','#35774#32622#20540#20026'25,'#21017#26368#21518#23041#21147#20026':100+100*25/100' +
                    '=125'#13#10#23398#20064'1'#32423#24594#20043#28872#28779','#35774#32622#20540#20026'25,'#21017#26368#21518#23041#21147#20026':100+100*50/100=150'#13#10#13#10#22914#23398#38745#20043#28872#28779'0'#32423','#30446#26631#23398#26377 +
                    #24594#20043#28872#28779'0'#32423','#35774#32622#20540#20026'25 '#13#10#23398#20064'0'#32423#38745#20043#28872#28779','#35774#32622#20540#20026'25,'#21017#26368#21518#23041#21147#20026':125-100*25/100=100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 25
                  OnChange = SpinEditNGSkillRateChange
                end
              end
              object GroupBox113: TGroupBox
                Left = 192
                Top = 150
                Width = 163
                Height = 45
                Caption = #20869#21151#31561#32423'+'#25915#38450
                TabOrder = 5
                object Label236: TLabel
                  Left = 4
                  Top = 19
                  Width = 156
                  Height = 12
                  Caption = #20869#21151#27599'        '#32423' +1('#25915'/'#38450')'
                end
                object SpinEditNGLevelDamage: TSpinEdit
                  Left = 41
                  Top = 15
                  Width = 44
                  Height = 21
                  Hint = #20869#21151#31561#32423#22686#21152#25915#38450#30340#35774#32622','#22914#35774#32622#20026'8,'#13#10#21017#27599'8'#32423#30340#20869#21151#31561#32423#21487#22686#21152'1'#28857#25915#38450','#13#10
                  MaxValue = 10
                  MinValue = 1
                  TabOrder = 0
                  Value = 8
                  OnChange = SpinEditNGLevelDamageChange
                end
              end
            end
          end
        end
      end
      object ButtonSkillSave: TButton
        Left = 362
        Top = 277
        Width = 66
        Height = 24
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSkillSaveClick
      end
    end
    object TabSheet34: TTabSheet
      Caption = #21319#32423#27494#22120
      ImageIndex = 6
      object GroupBox8: TGroupBox
        Left = 8
        Top = 8
        Width = 161
        Height = 121
        Caption = #22522#26412#35774#32622
        TabOrder = 0
        object Label13: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #26368#39640#28857#25968':'
        end
        object Label15: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #25152#38656#36153#29992':'
        end
        object Label16: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #25152#38656#26102#38388':'
        end
        object Label17: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #36807#26399#26102#38388':'
        end
        object Label18: TLabel
          Left = 136
          Top = 65
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label19: TLabel
          Left = 136
          Top = 89
          Width = 12
          Height = 12
          Caption = #22825
        end
        object EditUpgradeWeaponMaxPoint: TSpinEdit
          Left = 68
          Top = 15
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 765
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditUpgradeWeaponMaxPointChange
        end
        object EditUpgradeWeaponPrice: TSpinEdit
          Left = 68
          Top = 39
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditUpgradeWeaponPriceChange
        end
        object EditUPgradeWeaponGetBackTime: TSpinEdit
          Left = 68
          Top = 63
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 36000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditUPgradeWeaponGetBackTimeChange
        end
        object EditClearExpireUpgradeWeaponDays: TSpinEdit
          Left = 68
          Top = 87
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditClearExpireUpgradeWeaponDaysChange
        end
      end
      object GroupBox18: TGroupBox
        Left = 176
        Top = 8
        Width = 265
        Height = 89
        Caption = #25915#20987#21147#21319#32423
        TabOrder = 1
        object Label20: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label21: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label22: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponDCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#25915#20987#21147#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponDCRateChange
        end
        object EditUpgradeWeaponDCRate: TEdit
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
        object ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponDCTwoPointRateChange
        end
        object EditUpgradeWeaponDCTwoPointRate: TEdit
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
        object ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponDCThreePointRateChange
        end
        object EditUpgradeWeaponDCThreePointRate: TEdit
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
      object GroupBox19: TGroupBox
        Left = 176
        Top = 104
        Width = 265
        Height = 97
        Caption = #36947#26415#21319#32423
        TabOrder = 2
        object Label23: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label24: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label25: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponSCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#36947#26415#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponSCRateChange
        end
        object EditUpgradeWeaponSCRate: TEdit
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
        object ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponSCTwoPointRateChange
        end
        object EditUpgradeWeaponSCTwoPointRate: TEdit
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
        object ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponSCThreePointRateChange
        end
        object EditUpgradeWeaponSCThreePointRate: TEdit
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
      object GroupBox20: TGroupBox
        Left = 176
        Top = 208
        Width = 265
        Height = 89
        Caption = #39764#27861#21319#32423
        TabOrder = 3
        object Label26: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label27: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label28: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponMCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#39764#27861#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponMCRateChange
        end
        object EditUpgradeWeaponMCRate: TEdit
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
        object ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponMCTwoPointRateChange
        end
        object EditUpgradeWeaponMCTwoPointRate: TEdit
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
        object ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponMCThreePointRateChange
        end
        object EditUpgradeWeaponMCThreePointRate: TEdit
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
      object ButtonUpgradeWeaponSave: TButton
        Left = 8
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonUpgradeWeaponSaveClick
      end
      object ButtonUpgradeWeaponDefaulf: TButton
        Left = 80
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 5
        OnClick = ButtonUpgradeWeaponDefaulfClick
      end
    end
    object TabSheet35: TTabSheet
      Caption = #25366#30719#25511#21046
      ImageIndex = 7
      object GroupBox24: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 60
        Caption = #24471#21040#30719#30707#26426#29575
        TabOrder = 0
        object Label32: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #21629#20013#26426#29575':'
        end
        object Label33: TLabel
          Left = 8
          Top = 36
          Width = 54
          Height = 12
          Caption = #25366#30719#26426#29575':'
        end
        object ScrollBarMakeMineHitRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Hint = #35774#32622#30340#25968#23383#36234#23567#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarMakeMineHitRateChange
        end
        object EditMakeMineHitRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarMakeMineRate: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Hint = #35774#32622#30340#25968#23383#36234#23567#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarMakeMineRateChange
        end
        object EditMakeMineRate: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
      end
      object GroupBox25: TGroupBox
        Left = 8
        Top = 72
        Width = 273
        Height = 217
        Caption = #30719#30707#31867#22411#26426#29575
        TabOrder = 1
        object Label34: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #30719#30707#22240#23376':'
        end
        object Label35: TLabel
          Left = 8
          Top = 38
          Width = 42
          Height = 12
          Caption = #37329#30719#29575':'
        end
        object Label36: TLabel
          Left = 8
          Top = 56
          Width = 42
          Height = 12
          Caption = #38134#30719#29575':'
        end
        object Label37: TLabel
          Left = 8
          Top = 76
          Width = 42
          Height = 12
          Caption = #38081#30719#29575':'
        end
        object Label38: TLabel
          Left = 8
          Top = 96
          Width = 54
          Height = 12
          Caption = #40657#38081#30719#29575':'
        end
        object ScrollBarStoneTypeRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarStoneTypeRateChange
        end
        object EditStoneTypeRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarGoldStoneMax: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarGoldStoneMaxChange
        end
        object EditGoldStoneMax: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarSilverStoneMax: TScrollBar
          Left = 72
          Top = 56
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarSilverStoneMaxChange
        end
        object EditSilverStoneMax: TEdit
          Left = 208
          Top = 56
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarSteelStoneMax: TScrollBar
          Left = 72
          Top = 76
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarSteelStoneMaxChange
        end
        object EditSteelStoneMax: TEdit
          Left = 208
          Top = 76
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditBlackStoneMax: TEdit
          Left = 208
          Top = 96
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarBlackStoneMax: TScrollBar
          Left = 72
          Top = 96
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarBlackStoneMaxChange
        end
      end
      object ButtonMakeMineSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonMakeMineSaveClick
      end
      object GroupBox26: TGroupBox
        Left = 288
        Top = 8
        Width = 153
        Height = 121
        Caption = #30719#30707#21697#36136
        TabOrder = 3
        object Label39: TLabel
          Left = 8
          Top = 18
          Width = 78
          Height = 12
          Caption = #30719#30707#26368#23567#21697#36136':'
        end
        object Label40: TLabel
          Left = 8
          Top = 42
          Width = 78
          Height = 12
          Caption = #26222#36890#21697#36136#33539#22260':'
        end
        object Label41: TLabel
          Left = 8
          Top = 66
          Width = 66
          Height = 12
          Caption = #39640#21697#36136#26426#29575':'
        end
        object Label42: TLabel
          Left = 8
          Top = 90
          Width = 66
          Height = 12
          Caption = #39640#21697#36136#33539#22260':'
        end
        object EditStoneMinDura: TSpinEdit
          Left = 92
          Top = 15
          Width = 45
          Height = 21
          Hint = #30719#30707#20986#29616#26368#20302#21697#36136#28857#25968#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditStoneMinDuraChange
        end
        object EditStoneGeneralDuraRate: TSpinEdit
          Left = 92
          Top = 39
          Width = 45
          Height = 21
          Hint = #30719#30707#38543#26426#20986#29616#21697#36136#28857#25968#33539#22260#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditStoneGeneralDuraRateChange
        end
        object EditStoneAddDuraRate: TSpinEdit
          Left = 92
          Top = 63
          Width = 45
          Height = 21
          Hint = #30719#30707#20986#29616#39640#21697#36136#28857#25968#26426#29575#65292#39640#21697#36136#37327#25351#21487#36798#21040'20'#25110#20197#19978#30340#28857#25968#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditStoneAddDuraRateChange
        end
        object EditStoneAddDuraMax: TSpinEdit
          Left = 92
          Top = 87
          Width = 45
          Height = 21
          Hint = #39640#21697#36136#30719#30707#38543#26426#20986#29616#21697#36136#28857#25968#33539#22260#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditStoneAddDuraMaxChange
        end
      end
      object ButtonMakeMineDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 4
        OnClick = ButtonMakeMineDefaultClick
      end
    end
    object TabSheet42: TTabSheet
      Caption = #31069#31119#27833#25511#21046
      ImageIndex = 12
      object GroupBox44: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 217
        Caption = #26426#29575#35774#32622
        TabOrder = 0
        object Label105: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #35781#21650#26426#29575':'
        end
        object Label106: TLabel
          Left = 8
          Top = 38
          Width = 54
          Height = 12
          Caption = #19968#32423#28857#25968':'
        end
        object Label107: TLabel
          Left = 8
          Top = 56
          Width = 54
          Height = 12
          Caption = #20108#32423#28857#25968':'
        end
        object Label108: TLabel
          Left = 8
          Top = 76
          Width = 54
          Height = 12
          Caption = #20108#32423#26426#29575':'
        end
        object Label109: TLabel
          Left = 8
          Top = 96
          Width = 54
          Height = 12
          Caption = #19977#32423#28857#25968':'
        end
        object Label110: TLabel
          Left = 8
          Top = 116
          Width = 54
          Height = 12
          Caption = #19977#32423#26426#29575':'
        end
        object ScrollBarWeaponMakeUnLuckRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Hint = #20351#29992#31069#31119#27833#35781#21650#26426#29575#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWeaponMakeUnLuckRateChange
        end
        object EditWeaponMakeUnLuckRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWeaponMakeLuckPoint1: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017'100% '#25104#21151#12290
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWeaponMakeLuckPoint1Change
        end
        object EditWeaponMakeLuckPoint1: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWeaponMakeLuckPoint2: TScrollBar
          Left = 72
          Top = 56
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017#25353#25351#23450#26426#29575#20915#23450#26159#21542#21152#24184#36816#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWeaponMakeLuckPoint2Change
        end
        object EditWeaponMakeLuckPoint2: TEdit
          Left = 208
          Top = 56
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar
          Left = 72
          Top = 76
          Width = 129
          Height = 15
          Hint = #26426#29575#28857#25968#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWeaponMakeLuckPoint2RateChange
        end
        object EditWeaponMakeLuckPoint2Rate: TEdit
          Left = 208
          Top = 76
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWeaponMakeLuckPoint3: TEdit
          Left = 208
          Top = 96
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWeaponMakeLuckPoint3: TScrollBar
          Left = 72
          Top = 96
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017#25353#25351#23450#26426#29575#20915#23450#26159#21542#21152#24184#36816#12290
          Max = 500
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWeaponMakeLuckPoint3Change
        end
        object ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar
          Left = 72
          Top = 116
          Width = 129
          Height = 15
          Hint = #26426#29575#28857#25968#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWeaponMakeLuckPoint3RateChange
        end
        object EditWeaponMakeLuckPoint3Rate: TEdit
          Left = 208
          Top = 116
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
      end
      object ButtonWeaponMakeLuckDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 1
        OnClick = ButtonWeaponMakeLuckDefaultClick
      end
      object ButtonWeaponMakeLuckSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonWeaponMakeLuckSaveClick
      end
    end
    object TabSheet37: TTabSheet
      Caption = #24425#31080#25511#21046
      ImageIndex = 8
      object GroupBox27: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 169
        Caption = #20013#22870#26426#29575
        TabOrder = 0
        object Label43: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #19968#31561#22870':'
        end
        object Label44: TLabel
          Left = 8
          Top = 62
          Width = 42
          Height = 12
          Caption = #20108#31561#22870':'
        end
        object Label45: TLabel
          Left = 8
          Top = 80
          Width = 42
          Height = 12
          Caption = #19977#31561#22870':'
        end
        object Label46: TLabel
          Left = 8
          Top = 100
          Width = 42
          Height = 12
          Caption = #22235#31561#22870':'
        end
        object Label47: TLabel
          Left = 8
          Top = 120
          Width = 42
          Height = 12
          Caption = #20116#31561#22870':'
        end
        object Label48: TLabel
          Left = 8
          Top = 140
          Width = 42
          Height = 12
          Caption = #20845#31561#22870':'
        end
        object Label49: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = #22240#23376':'
        end
        object ScrollBarWinLottery1Max: TScrollBar
          Left = 56
          Top = 40
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWinLottery1MaxChange
        end
        object EditWinLottery1Max: TEdit
          Left = 192
          Top = 40
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWinLottery2Max: TScrollBar
          Left = 56
          Top = 60
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWinLottery2MaxChange
        end
        object EditWinLottery2Max: TEdit
          Left = 192
          Top = 60
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWinLottery3Max: TScrollBar
          Left = 56
          Top = 80
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWinLottery3MaxChange
        end
        object EditWinLottery3Max: TEdit
          Left = 192
          Top = 80
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWinLottery4Max: TScrollBar
          Left = 56
          Top = 100
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWinLottery4MaxChange
        end
        object EditWinLottery4Max: TEdit
          Left = 192
          Top = 100
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWinLottery5Max: TEdit
          Left = 192
          Top = 120
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWinLottery5Max: TScrollBar
          Left = 56
          Top = 120
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWinLottery5MaxChange
        end
        object ScrollBarWinLottery6Max: TScrollBar
          Left = 56
          Top = 140
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWinLottery6MaxChange
        end
        object EditWinLottery6Max: TEdit
          Left = 192
          Top = 140
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
        object EditWinLotteryRate: TEdit
          Left = 192
          Top = 16
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 12
        end
        object ScrollBarWinLotteryRate: TScrollBar
          Left = 56
          Top = 16
          Width = 129
          Height = 15
          Max = 100000
          PageSize = 0
          TabOrder = 13
          OnChange = ScrollBarWinLotteryRateChange
        end
      end
      object GroupBox28: TGroupBox
        Left = 288
        Top = 8
        Width = 145
        Height = 169
        Caption = #22870#37329
        TabOrder = 1
        object Label50: TLabel
          Left = 8
          Top = 18
          Width = 42
          Height = 12
          Caption = #19968#31561#22870':'
        end
        object Label51: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #20108#31561#22870':'
        end
        object Label52: TLabel
          Left = 8
          Top = 66
          Width = 42
          Height = 12
          Caption = #19977#31561#22870':'
        end
        object Label53: TLabel
          Left = 8
          Top = 90
          Width = 42
          Height = 12
          Caption = #22235#31561#22870':'
        end
        object Label54: TLabel
          Left = 8
          Top = 114
          Width = 42
          Height = 12
          Caption = #20116#31561#22870':'
        end
        object Label55: TLabel
          Left = 8
          Top = 138
          Width = 42
          Height = 12
          Caption = #20845#31561#22870':'
        end
        object EditWinLottery1Gold: TSpinEdit
          Left = 56
          Top = 15
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 100000000
          OnChange = EditWinLottery1GoldChange
        end
        object EditWinLottery2Gold: TSpinEdit
          Left = 56
          Top = 39
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditWinLottery2GoldChange
        end
        object EditWinLottery3Gold: TSpinEdit
          Left = 56
          Top = 63
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditWinLottery3GoldChange
        end
        object EditWinLottery4Gold: TSpinEdit
          Left = 56
          Top = 87
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditWinLottery4GoldChange
        end
        object EditWinLottery5Gold: TSpinEdit
          Left = 56
          Top = 111
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 4
          Value = 10
          OnChange = EditWinLottery5GoldChange
        end
        object EditWinLottery6Gold: TSpinEdit
          Left = 56
          Top = 135
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = EditWinLottery6GoldChange
        end
      end
      object ButtonWinLotterySave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        ModalResult = 1
        TabOrder = 2
        OnClick = ButtonWinLotterySaveClick
      end
      object ButtonWinLotteryDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 3
        OnClick = ButtonWinLotteryDefaultClick
      end
    end
    object TabSheet40: TTabSheet
      Caption = #31048#31095#29983#25928
      ImageIndex = 11
      object GroupBox36: TGroupBox
        Left = 8
        Top = 8
        Width = 137
        Height = 89
        Caption = #31048#31095#29983#25928
        TabOrder = 0
        object Label94: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #29983#25928#26102#38271':'
        end
        object Label96: TLabel
          Left = 11
          Top = 64
          Width = 54
          Height = 12
          Caption = #33021#37327#20493#25968':'
          Enabled = False
          Visible = False
        end
        object CheckBoxSpiritMutiny: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #21551#29992#31048#31095#29305#27530#21151#33021
          TabOrder = 0
          OnClick = CheckBoxSpiritMutinyClick
        end
        object EditSpiritMutinyTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditSpiritMutinyTimeChange
        end
        object EditSpiritPowerRate: TSpinEdit
          Left = 72
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          Visible = False
          OnChange = EditSpiritPowerRateChange
        end
      end
      object ButtonSpiritMutinySave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSpiritMutinySaveClick
      end
    end
    object TabSheet44: TTabSheet
      Caption = #23492#21806#31995#32479
      ImageIndex = 13
      object GroupBox49: TGroupBox
        Left = 8
        Top = 8
        Width = 185
        Height = 81
        Caption = #23492#21806#31995#32479
        TabOrder = 0
        object Label113: TLabel
          Left = 16
          Top = 24
          Width = 60
          Height = 12
          Caption = #25968#37327#38480#21046#65306
        end
        object Label114: TLabel
          Left = 16
          Top = 48
          Width = 48
          Height = 12
          Caption = #31246#25910#29575#65306
        end
        object Label115: TLabel
          Left = 144
          Top = 48
          Width = 6
          Height = 12
          Caption = '%'
        end
        object SpinEditSellOffCount: TSpinEdit
          Left = 80
          Top = 20
          Width = 57
          Height = 21
          Hint = #27599#20010#20154#23492#21806#29289#21697#30340#25968#37327
          Enabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = SpinEditSellOffCountChange
        end
        object SpinEditSellOffTax: TSpinEdit
          Left = 80
          Top = 44
          Width = 57
          Height = 21
          Hint = #36890#36807#20132#26131#25152#25910#21462#30340#31246#29575
          Enabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = SpinEditSellOffTaxChange
        end
      end
      object ButtonSellOffSave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSellOffSaveClick
      end
      object GroupBox68: TGroupBox
        Left = 8
        Top = 96
        Width = 185
        Height = 81
        Caption = #20803#23453#23492#21806#31995#32479
        TabOrder = 2
        object Label158: TLabel
          Left = 10
          Top = 36
          Width = 72
          Height = 12
          Caption = #27599#27425#25187#20803#23453#65306
        end
        object EdtDecUserGameGold: TSpinEdit
          Left = 82
          Top = 32
          Width = 57
          Height = 21
          Hint = #27599#27425#36141#20080#25110#20986#21806#25152#25187#30340#20803#23453#20540
          MaxValue = 1000
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EdtDecUserGameGoldChange
        end
      end
    end
    object TabSheet50: TTabSheet
      Caption = #35013#22791#21051#21517
      ImageIndex = 14
      object GroupBox55: TGroupBox
        Left = 8
        Top = 8
        Width = 257
        Height = 81
        Caption = #35013#22791#21051#21517
        TabOrder = 0
        object Label118: TLabel
          Left = 16
          Top = 48
          Width = 72
          Height = 12
          Caption = #33258#23450#20041#21069#32512#65306
        end
        object CheckBoxItemName: TCheckBox
          Left = 16
          Top = 24
          Width = 153
          Height = 17
          Caption = #20351#29992#29609#23478#30340#21517#31216#20570#21069#32512
          TabOrder = 0
          OnClick = CheckBoxItemNameClick
        end
        object EditItemName: TEdit
          Left = 88
          Top = 44
          Width = 161
          Height = 20
          TabOrder = 1
          Text = #12310#25913#12311
          OnChange = EditItemNameChange
        end
      end
      object ButtonChangeUseItemName: TButton
        Left = 360
        Top = 259
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonChangeUseItemNameClick
      end
    end
    object TabSheet45: TTabSheet
      Caption = #37202#39302#31995#32479
      ImageIndex = 15
      object GroupBox89: TGroupBox
        Left = 8
        Top = 1
        Width = 164
        Height = 65
        Caption = #37247#37202#31561#24453#26102#38388
        TabOrder = 0
        object Label175: TLabel
          Left = 17
          Top = 19
          Width = 48
          Height = 12
          Caption = #26222#36890#37202#65306
        end
        object Label176: TLabel
          Left = 129
          Top = 19
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label178: TLabel
          Left = 17
          Top = 43
          Width = 48
          Height = 12
          Caption = #33647'  '#37202#65306
        end
        object Label179: TLabel
          Left = 129
          Top = 43
          Width = 12
          Height = 12
          Caption = #31186
        end
        object SpinEditMakeWineTime: TSpinEdit
          Left = 65
          Top = 15
          Width = 57
          Height = 21
          Hint = #37247#26222#36890#37202#38656#35201#31561#24453#30340#26102#38388
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = SpinEditMakeWineTimeChange
        end
        object SpinEditMakeWineTime1: TSpinEdit
          Left = 65
          Top = 39
          Width = 57
          Height = 21
          Hint = #37247#33647#37202#38656#35201#31561#24453#30340#26102#38388
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = SpinEditMakeWineTime1Change
        end
      end
      object GroupBox90: TGroupBox
        Left = 8
        Top = 69
        Width = 165
        Height = 45
        Caption = #33719#24471#37202#26354#26426#29575
        TabOrder = 1
        object Label177: TLabel
          Left = 11
          Top = 21
          Width = 54
          Height = 12
          Caption = #37202#26354#20960#29575':'
        end
        object SpinEditMakeWineRate: TSpinEdit
          Left = 76
          Top = 15
          Width = 53
          Height = 21
          Hint = #25968#23383#36234#23567#65292#37247#36896#26222#36890#37202#33719#24471#37202#26354#26426#29575#36234#22823#12290
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 6
          OnChange = SpinEditMakeWineRateChange
        end
      end
      object ButtonSaveMakeWine: TButton
        Left = 368
        Top = 237
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonSaveMakeWineClick
      end
      object GroupBox91: TGroupBox
        Left = 180
        Top = 1
        Width = 213
        Height = 113
        Caption = #39278#37202#30456#20851
        TabOrder = 3
        object Label180: TLabel
          Left = 17
          Top = 20
          Width = 108
          Height = 12
          Caption = #37202#37327#36827#24230#22686#21152#38388#38548#65306
        end
        object Label181: TLabel
          Left = 193
          Top = 20
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label182: TLabel
          Left = 28
          Top = 44
          Width = 96
          Height = 12
          Caption = #37257#37202#24230#20943#23569#38388#38548#65306
        end
        object Label183: TLabel
          Left = 193
          Top = 44
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label184: TLabel
          Left = 28
          Top = 68
          Width = 96
          Height = 12
          Caption = #37202#37327#19978#38480#21021#22987#20540#65306
        end
        object Label185: TLabel
          Left = 17
          Top = 92
          Width = 108
          Height = 12
          Caption = #37202#37327#21319#32423#19978#38480#22686#21152#65306
        end
        object SpinEditIncAlcoholTick: TSpinEdit
          Left = 129
          Top = 16
          Width = 57
          Height = 21
          Hint = #37202#37327#36827#24230#22686#21152#26102#38388#38388#38548
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = SpinEditIncAlcoholTickChange
        end
        object SpinEditDesDrinkTick: TSpinEdit
          Left = 129
          Top = 40
          Width = 57
          Height = 21
          Hint = #37257#37202#24230#20943#23569#38388#38548#26102#38388
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = SpinEditDesDrinkTickChange
        end
        object SpinEditMaxAlcoholValue: TSpinEdit
          Left = 129
          Top = 64
          Width = 57
          Height = 21
          Hint = #37202#37327#21021#22987#19978#38480#20540
          MaxValue = 65535
          MinValue = 1
          TabOrder = 2
          Value = 2000
          OnChange = SpinEditMaxAlcoholValueChange
        end
        object SpinEditIncAlcoholValue: TSpinEdit
          Left = 129
          Top = 88
          Width = 57
          Height = 21
          Hint = #24403#21069#37202#37327#20540#36798#21040#19978#38480#21518','#37202#37327#19978#38480#22686#21152#25351#23450#30340#20540
          MaxValue = 65535
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = SpinEditIncAlcoholValueChange
        end
      end
      object GroupBox92: TGroupBox
        Left = 8
        Top = 115
        Width = 166
        Height = 193
        Caption = #33647#21147#20540#30456#20851
        TabOrder = 4
        object Label186: TLabel
          Left = 26
          Top = 173
          Width = 60
          Height = 12
          Caption = #20943#33647#21147#20540#65306
        end
        object Label187: TLabel
          Left = 4
          Top = 152
          Width = 84
          Height = 12
          Caption = #20943#33647#21147#20540#38388#38548#65306
        end
        object Label188: TLabel
          Left = 150
          Top = 152
          Width = 12
          Height = 12
          Caption = #31186
        end
        object GridMedicineExp: TStringGrid
          Left = 6
          Top = 11
          Width = 153
          Height = 137
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 1001
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
          TabOrder = 0
          OnEnter = GridMedicineExpEnter
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
        object SpinEditDesMedicineValue: TSpinEdit
          Left = 85
          Top = 169
          Width = 65
          Height = 21
          Hint = #22312#32447#25351#23450#26102#38388#20869#27809#26377#39278#29992#33647#37202','#21017#20943#33647#21147#20540
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 1
          OnChange = SpinEditDesMedicineValueChange
        end
        object SpinEditDesMedicineTick: TSpinEdit
          Left = 85
          Top = 148
          Width = 65
          Height = 21
          Hint = #38271#26399#27809#26377#39278#37202','#38388#38548#22810#38271#26102#38388#20943#33647#21147#20540
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 2
          Value = 43200
          OnChange = SpinEditDesMedicineTickChange
        end
      end
      object GroupBox93: TGroupBox
        Left = 182
        Top = 116
        Width = 219
        Height = 89
        Caption = #27849#27700
        TabOrder = 5
        object Label189: TLabel
          Left = 18
          Top = 19
          Width = 60
          Height = 12
          Caption = #37319#38598#26102#38388#65306
        end
        object Label190: TLabel
          Left = 142
          Top = 19
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label199: TLabel
          Left = 4
          Top = 43
          Width = 108
          Height = 12
          Caption = #34892#20250#37202#27849#33988#37327#23569#20110#65306
        end
        object Label200: TLabel
          Left = 156
          Top = 42
          Width = 60
          Height = 12
          Caption = #26102#19981#33021#39046#21462
        end
        object Label201: TLabel
          Left = 4
          Top = 67
          Width = 150
          Height = 12
          Caption = #34892#20250#25104#21592#39046#21462#27849#27700','#20943#33988#37327#65306
        end
        object SpinEditInFountainTime: TSpinEdit
          Left = 78
          Top = 15
          Width = 57
          Height = 21
          Hint = #37319#38598#27849#27700#38656#31449#22312#27849#30524#19978#30340#26102#38388','#36798#21040#13#25351#23450#26102#38388#21518','#27849#27700#32592#25165#33021#22686#21152#25345#20037'.'
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = SpinEditInFountainTimeChange
        end
        object SpinEditMinGuildFountain: TSpinEdit
          Left = 107
          Top = 39
          Width = 49
          Height = 21
          Hint = #34892#20250#37202#27849#33988#37327#23569#20110#35774#32622#20540#26102','#34892#20250#25104#21592#21017#26080#27861#39046#21462#27849#27700
          MaxValue = 65535
          MinValue = 1
          TabOrder = 1
          Value = 50
          OnChange = SpinEditMinGuildFountainChange
        end
        object SpinEditDecGuildFountain: TSpinEdit
          Left = 151
          Top = 63
          Width = 49
          Height = 21
          Hint = #34892#20250#25104#21592#39046#21462#37202#27849#26102','#34892#20250#33988#37327#20943#23569#25351#23450#30340#20540
          MaxValue = 65535
          MinValue = 1
          TabOrder = 2
          Value = 50
          OnChange = SpinEditDecGuildFountainChange
        end
      end
    end
  end
end

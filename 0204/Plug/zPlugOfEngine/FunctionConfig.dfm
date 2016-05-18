object FrmFunctionConfig: TFrmFunctionConfig
  Left = 188
  Top = 177
  BorderStyle = bsDialog
  Caption = #21151#33021#35774#32622
  ClientHeight = 415
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label14: TLabel
    Left = 8
    Top = 399
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
    Width = 537
    Height = 381
    ActivePage = TabSheet3
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #27668#34880#30707#35774#32622
      object GroupBox52: TGroupBox
        Left = 6
        Top = 0
        Width = 515
        Height = 109
        Caption = #27668#34880#30707
        TabOrder = 0
        object Label116: TLabel
          Left = 8
          Top = 17
          Width = 132
          Height = 12
          Caption = #24403#20154#29289#34880#20540#20302#20110#24635#34880#20540#30340
        end
        object Label117: TLabel
          Left = 208
          Top = 17
          Width = 96
          Height = 12
          Caption = '% '#26102#21551#21160#27668#34880#30707#12290
        end
        object Label118: TLabel
          Left = 8
          Top = 41
          Width = 84
          Height = 12
          Caption = #27599#27425#22686#21152'HP'#20026#65306
        end
        object Label120: TLabel
          Left = 8
          Top = 65
          Width = 144
          Height = 12
          Caption = #27599#20351#29992#19968#27425#27668#34880#30707#25345#20037#20943#23569
        end
        object Label121: TLabel
          Left = 232
          Top = 65
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label128: TLabel
          Left = 256
          Top = 41
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object Label1: TLabel
          Left = 120
          Top = 87
          Width = 60
          Height = 12
          Caption = #25552#31034#20449#24687#65306
        end
        object Label7: TLabel
          Left = 152
          Top = 41
          Width = 36
          Height = 12
          Caption = #38388#38548#65306
        end
        object SpinEditStartHPRock: TSpinEdit
          Left = 144
          Top = 13
          Width = 57
          Height = 21
          Hint = #24635#34880#20540#20026'600,'#35774#32622#20540'90%,'#21363#24403#21069#34880#20540#20302#20110'600*90%=540'#26102','#20351#29992#29289#21697
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 90
          OnChange = SpinEditStartHPRockChange
        end
        object SpinEditRockAddHP: TSpinEdit
          Left = 96
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
          Left = 160
          Top = 61
          Width = 65
          Height = 21
          Hint = '1000=1'#25345#20037
          MaxValue = 1000000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 100
          OnChange = SpinEditHPRockDecDuraChange
        end
        object SpinEditHPRockSpell: TSpinEdit
          Left = 187
          Top = 37
          Width = 62
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
        object CheckBoxStartHPRock: TCheckBox
          Left = 8
          Top = 85
          Width = 105
          Height = 17
          Hint = #36873#25321#21518#21551#21160#26102#65292#20250#22312#32842#22825#26639#20013#65292#32418#33394#23383#20307#25552#31034#29609#23478
          Caption = #21551#21160#26102#25552#31034#29992#25143
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = CheckBoxStartHPRockClick
        end
        object EditStartHPRockMsg: TEdit
          Left = 184
          Top = 84
          Width = 257
          Height = 20
          Enabled = False
          TabOrder = 5
          OnChange = EditStartHPRockMsgChange
        end
      end
      object GroupBox53: TGroupBox
        Left = 6
        Top = 110
        Width = 515
        Height = 107
        Caption = #24187#39764#30707
        TabOrder = 1
        object Label122: TLabel
          Left = 8
          Top = 15
          Width = 156
          Height = 12
          Caption = #24403#20154#29289#39764#27861#20540#20302#20110#24635#39764#27861#20540#30340
        end
        object Label124: TLabel
          Left = 8
          Top = 38
          Width = 84
          Height = 12
          Caption = #27599#27425#22686#21152'MP'#20026#65306
        end
        object Label126: TLabel
          Left = 8
          Top = 62
          Width = 132
          Height = 12
          Caption = #27599#29992#19968#27425#24187#39764#30707#25345#20037#20943#23569
        end
        object Label127: TLabel
          Left = 232
          Top = 62
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label123: TLabel
          Left = 232
          Top = 15
          Width = 96
          Height = 12
          Caption = '% '#26102#21551#21160#24187#39764#30707#12290
        end
        object Label129: TLabel
          Left = 256
          Top = 39
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object Label2: TLabel
          Left = 120
          Top = 83
          Width = 60
          Height = 12
          Caption = #25552#31034#20449#24687#65306
        end
        object Label13: TLabel
          Left = 152
          Top = 38
          Width = 36
          Height = 12
          Caption = #38388#38548#65306
        end
        object SpinEditStartMPRock: TSpinEdit
          Left = 168
          Top = 11
          Width = 57
          Height = 21
          Hint = #24635#39764#27861#20540#20026'600,'#35774#32622#20540'90%,'#21363#24403#21069#39764#27861#20540#20302#20110'600*90%=540'#26102','#20351#29992#29289#21697
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 90
          OnChange = SpinEditStartMPRockChange
        end
        object SpinEditRockAddMP: TSpinEdit
          Left = 96
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
          Left = 160
          Top = 58
          Width = 65
          Height = 21
          Hint = '1000=1'#25345#20037
          MaxValue = 1000000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 100
          OnChange = SpinEditMPRockDecDuraChange
        end
        object SpinEditMPRockSpell: TSpinEdit
          Left = 187
          Top = 35
          Width = 62
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
        object CheckBoxStartMPRock: TCheckBox
          Left = 8
          Top = 81
          Width = 105
          Height = 17
          Hint = #36873#25321#21518#21551#21160#26102#65292#20250#22312#32842#22825#26639#20013#65292#32418#33394#23383#20307#25552#31034#29609#23478
          Caption = #21551#21160#26102#25552#31034#29992#25143
          Enabled = False
          TabOrder = 4
          OnClick = CheckBoxStartMPRockClick
        end
        object EditStartMPRockMsg: TEdit
          Left = 184
          Top = 81
          Width = 273
          Height = 20
          Enabled = False
          TabOrder = 5
          OnChange = EditStartMPRockMsgChange
        end
      end
      object ButtonSuperRockSave: TButton
        Left = 448
        Top = 330
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonSuperRockSaveClick
      end
      object GroupBox54: TGroupBox
        Left = 6
        Top = 219
        Width = 515
        Height = 107
        Caption = #39764#34880#30707
        TabOrder = 3
        object Label5: TLabel
          Left = 8
          Top = 15
          Width = 156
          Height = 12
          Caption = #24403#20154#29289'HP'#25110'MP'#20302#20110#24635'HP'#25110'MP'#30340
        end
        object Label6: TLabel
          Left = 8
          Top = 38
          Width = 108
          Height = 12
          Caption = #27599#27425#22686#21152'HP'#25110'MP'#20026#65306
        end
        object Label8: TLabel
          Left = 8
          Top = 62
          Width = 132
          Height = 12
          Caption = #27599#29992#19968#27425#39764#34880#30707#25345#20037#20943#23569
        end
        object Label9: TLabel
          Left = 232
          Top = 62
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label10: TLabel
          Left = 232
          Top = 15
          Width = 156
          Height = 12
          Caption = '% '#26102#21551#21160#39764#34880#30707#12290#20351#29992#38388#38548#65306
        end
        object Label11: TLabel
          Left = 280
          Top = 39
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object Label12: TLabel
          Left = 120
          Top = 83
          Width = 60
          Height = 12
          Caption = #25552#31034#20449#24687#65306
        end
        object Label15: TLabel
          Left = 176
          Top = 38
          Width = 36
          Height = 12
          Caption = #38388#38548#65306
        end
        object SpinEditStartHPMPRock: TSpinEdit
          Left = 168
          Top = 11
          Width = 57
          Height = 21
          Hint = #24635'HP'#25110'MP'#20026'600,'#35774#32622#20540'90%,'#21363#24403#21069'HP'#25110'MP'#20302#20110'600*90%=540'#26102','#20351#29992#29289#21697
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 90
          OnChange = SpinEditStartHPMPRockChange
        end
        object SpinEditRockAddHPMP: TSpinEdit
          Left = 119
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
          Left = 160
          Top = 58
          Width = 65
          Height = 21
          Hint = '1000=1'#25345#20037
          MaxValue = 1000000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 100
          OnChange = SpinEditHPMPRockDecDuraChange
        end
        object SpinEditHPMPRockSpell: TSpinEdit
          Left = 210
          Top = 35
          Width = 63
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
        object CheckBoxStartHPMPRock: TCheckBox
          Left = 8
          Top = 81
          Width = 105
          Height = 17
          Hint = #36873#25321#21518#21551#21160#26102#65292#20250#22312#32842#22825#26639#20013#65292#32418#33394#23383#20307#25552#31034#29609#23478
          Caption = #21551#21160#26102#25552#31034#29992#25143
          Enabled = False
          TabOrder = 4
          OnClick = CheckBoxStartHPMPRockClick
        end
        object EditStartHPMPRockMsg: TEdit
          Left = 184
          Top = 81
          Width = 273
          Height = 20
          Enabled = False
          TabOrder = 5
          OnChange = EditStartHPMPRockMsgChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #33258#23450#20041#21629#20196
      ImageIndex = 1
      object Label3: TLabel
        Left = 246
        Top = 214
        Width = 60
        Height = 12
        Caption = #21629#20196#21517#31216#65306
      end
      object Label4: TLabel
        Left = 246
        Top = 238
        Width = 60
        Height = 12
        Caption = #21629#20196#32534#21495#65306
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 209
        Height = 345
        Caption = #33258#23450#20041#21629#20196#21015#34920
        TabOrder = 0
        object ListBoxUserCommand: TListBox
          Left = 8
          Top = 16
          Width = 193
          Height = 321
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxUserCommandClick
        end
      end
      object EditCommandName: TEdit
        Left = 310
        Top = 210
        Width = 161
        Height = 20
        TabOrder = 1
      end
      object ButtonUserCommandAdd: TButton
        Left = 318
        Top = 262
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonUserCommandAddClick
      end
      object SpinEditCommandIdx: TSpinEdit
        Left = 310
        Top = 234
        Width = 161
        Height = 21
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object ButtonUserCommandDel: TButton
        Left = 398
        Top = 262
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonUserCommandDelClick
      end
      object ButtonUserCommandChg: TButton
        Left = 318
        Top = 294
        Width = 75
        Height = 25
        Caption = #20462#25913'(&C)'
        TabOrder = 5
        OnClick = ButtonUserCommandChgClick
      end
      object ButtonUserCommandSave: TButton
        Left = 398
        Top = 294
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonUserCommandSaveClick
      end
      object ButtonLoadUserCommandList: TButton
        Left = 318
        Top = 326
        Width = 153
        Height = 25
        Caption = #37325#26032#21152#36733#33258#23450#20041#21629#20196#21015#34920
        TabOrder = 7
        OnClick = ButtonLoadUserCommandListClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = #31105#27490#29289#21697#35774#32622
      ImageIndex = 2
      object GroupBox21: TGroupBox
        Left = 184
        Top = 8
        Width = 157
        Height = 337
        Caption = #29289#21697#21015#34920'(CTRL+F'#26597#25214')'
        TabOrder = 0
        object ListBoxitemList: TListBox
          Left = 8
          Top = 16
          Width = 141
          Height = 313
          Hint = 'Ctrl+F '#26597#25214
          ItemHeight = 12
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ListBoxitemListClick
          OnKeyDown = ListBoxitemListKeyDown
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 169
        Height = 337
        Caption = #31105#27490#29289#21697#21015#34920
        TabOrder = 1
        object ListBoxDisallow: TListBox
          Left = 8
          Top = 16
          Width = 153
          Height = 313
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisallowClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 344
        Top = 8
        Width = 179
        Height = 337
        Caption = #35268#21017#35774#32622
        TabOrder = 2
        object Label16: TLabel
          Left = 8
          Top = 24
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object EditItemName: TEdit
          Left = 64
          Top = 20
          Width = 106
          Height = 20
          Enabled = False
          TabOrder = 0
        end
        object GroupBox4: TGroupBox
          Left = 7
          Top = 44
          Width = 165
          Height = 205
          Caption = #32534#36753#29289#21697#23646#24615
          TabOrder = 1
          object BtnDisallowSelAll: TButton
            Left = 5
            Top = 176
            Width = 75
            Height = 23
            Caption = #20840#37096#36873#20013
            TabOrder = 0
            OnClick = BtnDisallowSelAllClick
          end
          object BtnDisallowCancelAll: TButton
            Left = 85
            Top = 176
            Width = 75
            Height = 23
            Caption = #20840#37096#21462#28040
            TabOrder = 1
            OnClick = BtnDisallowCancelAllClick
          end
          object CheckBoxDisallowDrop: TCheckBox
            Left = 9
            Top = 18
            Width = 65
            Height = 17
            Caption = #31105#27490#20002#24323
            TabOrder = 2
          end
          object CheckBoxDisallowDeal: TCheckBox
            Left = 88
            Top = 18
            Width = 65
            Height = 17
            Caption = #31105#27490#20132#26131
            TabOrder = 3
          end
          object CheckBoxDisallowStorage: TCheckBox
            Left = 9
            Top = 33
            Width = 65
            Height = 17
            Caption = #31105#27490#23384#20179
            TabOrder = 4
          end
          object CheckBoxDisallowRepair: TCheckBox
            Left = 88
            Top = 33
            Width = 65
            Height = 17
            Caption = #31105#27490#20462#29702
            TabOrder = 5
          end
          object CheckBoxDisallowDropHint: TCheckBox
            Left = 9
            Top = 48
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#29289#21697#25481#33853#22312#22320#19978#26102#21521#20840#26381#21457#24067#22320#22270#19982#22352#26631#25552#31034#12290
            Caption = #25481#33853#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
          end
          object CheckBoxDisallowOpenBoxsHint: TCheckBox
            Left = 88
            Top = 48
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#29289#21697#25171#24320#23453#31665#33719#24471#26102#21521#20840#26381#21457#36865#25552#31034#12290
            Caption = #23453#31665#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
          end
          object CheckBoxDisallowNoDropItem: TCheckBox
            Left = 9
            Top = 63
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#35813#29289#21697#27515#20129#19981#25481#33853#12290
            Caption = #27704#19981#29190#20986
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            OnClick = CheckBoxDisallowNoDropItemClick
          end
          object CheckBoxDisallowButchHint: TCheckBox
            Left = 88
            Top = 63
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#20174#24618#29289#25110#20154#22411#24618#36523#19978#25366#21040#35813#29289#21697#26102#36827#34892#20840#26381#25552#31034#12290
            Caption = #25366#21462#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 9
          end
          object CheckBoxDisallowHeroUse: TCheckBox
            Left = 9
            Top = 78
            Width = 68
            Height = 17
            Hint = #36873#20013#35813#39033#65292#33521#38596#19981#21487#20197#31359#25140#35813#29289#21697#12290
            Caption = #31105#27490#33521#38596
            ParentShowHint = False
            ShowHint = True
            TabOrder = 10
          end
          object CheckBoxDisallowPickUpItem: TCheckBox
            Left = 88
            Top = 78
            Width = 65
            Height = 17
            Caption = #31105#27490#25441#36215
            TabOrder = 11
          end
          object CheckBoxDieDropItems: TCheckBox
            Left = 9
            Top = 93
            Width = 65
            Height = 17
            Caption = #27515#20129#24517#26292
            TabOrder = 12
            OnClick = CheckBoxDieDropItemsClick
          end
          object CheckBox4: TCheckBox
            Left = 88
            Top = 93
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 13
          end
          object CheckBox5: TCheckBox
            Left = 9
            Top = 108
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 14
          end
          object CheckBox6: TCheckBox
            Left = 88
            Top = 108
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 15
          end
          object CheckBox7: TCheckBox
            Left = 9
            Top = 123
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 16
          end
          object CheckBox8: TCheckBox
            Left = 88
            Top = 123
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 17
          end
          object CheckBox9: TCheckBox
            Left = 9
            Top = 138
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 18
          end
          object CheckBox10: TCheckBox
            Left = 88
            Top = 138
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 19
          end
          object CheckBox11: TCheckBox
            Left = 9
            Top = 154
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 20
          end
          object CheckBox12: TCheckBox
            Left = 88
            Top = 154
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 21
          end
        end
        object BtnDisallowAdd: TButton
          Left = 8
          Top = 256
          Width = 78
          Height = 23
          Caption = #22686#21152'(&A)'
          TabOrder = 2
          OnClick = BtnDisallowAddClick
        end
        object BtnDisallowDel: TButton
          Left = 93
          Top = 256
          Width = 78
          Height = 23
          Caption = #21024#38500'(&D)'
          TabOrder = 3
          OnClick = BtnDisallowDelClick
        end
        object BtnDisallowAddAll: TButton
          Left = 8
          Top = 280
          Width = 78
          Height = 23
          Caption = #20840#37096#22686#21152'(&A)'
          TabOrder = 4
          OnClick = BtnDisallowAddAllClick
        end
        object BtnDisallowDelAll: TButton
          Left = 93
          Top = 280
          Width = 78
          Height = 23
          Caption = #20840#37096#21024#38500'(&D)'
          TabOrder = 5
          OnClick = BtnDisallowDelAllClick
        end
        object BtnDisallowChg: TButton
          Left = 8
          Top = 305
          Width = 78
          Height = 23
          Caption = #20462#25913'(&C)'
          TabOrder = 6
          OnClick = BtnDisallowChgClick
        end
        object BtnDisallowSave: TButton
          Left = 93
          Top = 305
          Width = 78
          Height = 23
          Caption = #20445#23384'(&S)'
          TabOrder = 7
          OnClick = BtnDisallowSaveClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #38450#25915#20987#35774#32622
      ImageIndex = 3
      object GroupBoxAttack: TGroupBox
        Left = 8
        Top = 8
        Width = 265
        Height = 326
        Caption = #37197#21046
        TabOrder = 0
        object CheckBoxAttack1: TCheckBox
          Left = 16
          Top = 16
          Width = 97
          Height = 17
          Caption = #31105#27490'CC'#25915#20987
          TabOrder = 0
          OnClick = CheckBoxAttack1Click
        end
        object CheckBoxAttack2: TCheckBox
          Left = 16
          Top = 40
          Width = 97
          Height = 17
          Caption = #31105#27490#27969#37327#25915#20987
          TabOrder = 1
          OnClick = CheckBoxAttack2Click
        end
        object CheckBoxAttack3: TCheckBox
          Left = 16
          Top = 64
          Width = 97
          Height = 17
          Caption = #31105#27490#31354#36830#25509
          TabOrder = 2
          OnClick = CheckBoxAttack3Click
        end
        object SpinEditAttack1: TSpinEdit
          Left = 128
          Top = 16
          Width = 121
          Height = 21
          Hint = 'CC'#25915#20987#20020#30028#26102#38388
          MaxValue = 10000
          MinValue = 10
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 100
          OnChange = SpinEditAttack1Change
        end
        object SpinEditAttack2: TSpinEdit
          Left = 128
          Top = 40
          Width = 121
          Height = 21
          Hint = #25968#25454#21253#22823#23567
          MaxValue = 1000
          MinValue = 10
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Value = 100
          OnChange = SpinEditAttack2Change
        end
        object SpinEditAttack3: TSpinEdit
          Left = 128
          Top = 64
          Width = 121
          Height = 21
          Hint = #31354#36830#25509#26102#38388
          MaxValue = 10000000
          MinValue = 1000
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 180000
          OnChange = SpinEditAttack3Change
        end
      end
      object ButtonAttackSave: TButton
        Left = 368
        Top = 304
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonAttackSaveClick
      end
      object CheckBoxStart: TCheckBox
        Left = 296
        Top = 16
        Width = 81
        Height = 17
        Caption = #21551#21160#38450#25915#20987
        TabOrder = 2
        OnClick = CheckBoxStartClick
      end
    end
    object TabSheet5: TTabSheet
      Caption = #28040#24687#36807#28388
      ImageIndex = 4
      object GroupBox22: TGroupBox
        Left = 8
        Top = 8
        Width = 513
        Height = 217
        Caption = #28040#24687#36807#28388#21015#34920
        TabOrder = 0
        object ListViewMsgFilter: TListView
          Left = 8
          Top = 16
          Width = 497
          Height = 193
          Columns = <
            item
              Caption = #36807#28388#28040#24687
              Width = 200
            end
            item
              Caption = #26367#25442#28040#24687
              Width = 200
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewMsgFilterClick
        end
      end
      object GroupBox23: TGroupBox
        Left = 8
        Top = 232
        Width = 513
        Height = 81
        Caption = #28040#24687#36807#28388#21015#34920#32534#36753
        TabOrder = 1
        object Label22: TLabel
          Left = 8
          Top = 24
          Width = 60
          Height = 12
          Caption = #36807#28388#28040#24687#65306
        end
        object Label23: TLabel
          Left = 8
          Top = 48
          Width = 60
          Height = 12
          Caption = #26367#25442#28040#24687#65306
        end
        object EditFilterMsg: TEdit
          Left = 72
          Top = 20
          Width = 433
          Height = 20
          TabOrder = 0
        end
        object EditNewMsg: TEdit
          Left = 72
          Top = 44
          Width = 433
          Height = 20
          Hint = #26367#25442#28040#24687#20026#31354#26102#65292#20002#25481#25972#21477#12290
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
      object ButtonMsgFilterAdd: TButton
        Left = 80
        Top = 323
        Width = 68
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonMsgFilterAddClick
      end
      object ButtonMsgFilterDel: TButton
        Left = 154
        Top = 323
        Width = 68
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonMsgFilterDelClick
      end
      object ButtonMsgFilterSave: TButton
        Left = 302
        Top = 323
        Width = 68
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonMsgFilterSaveClick
      end
      object ButtonMsgFilterChg: TButton
        Left = 228
        Top = 323
        Width = 68
        Height = 25
        Caption = #20462#25913'(&C)'
        TabOrder = 5
        OnClick = ButtonMsgFilterChgClick
      end
      object ButtonLoadMsgFilterList: TButton
        Left = 376
        Top = 323
        Width = 145
        Height = 25
        Caption = #37325#26032#21152#36733#28040#24687#36807#28388#21015#34920
        TabOrder = 6
        OnClick = ButtonLoadMsgFilterListClick
      end
    end
  end
end

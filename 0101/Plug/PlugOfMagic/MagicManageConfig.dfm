object FrmMagicManage: TFrmMagicManage
  Left = 161
  Top = 21
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #33258#23450#20041#39764#27861#32534#36753
  ClientHeight = 578
  ClientWidth = 848
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 833
    Height = 257
    Caption = #39764#27861#21015#34920
    TabOrder = 0
    object ListViewMagic: TListView
      Left = 8
      Top = 16
      Width = 817
      Height = 233
      Columns = <
        item
          Caption = 'MagID'
        end
        item
          Caption = 'MagName'
          Width = 80
        end
        item
          Caption = 'EffectType'
          Width = 65
        end
        item
          Caption = 'Effect'
          Width = 65
        end
        item
          Caption = 'Spell'
          Width = 65
        end
        item
          Caption = 'Power'
          Width = 65
        end
        item
          Caption = 'MaxPower'
          Width = 65
        end
        item
          Caption = 'DefSpell'
          Width = 65
        end
        item
          Caption = 'DefPower'
          Width = 65
        end
        item
          Caption = 'DefMaxPower'
          Width = 65
        end
        item
          Caption = 'Job'
          Width = 65
        end
        item
          Caption = 'NeedL1'
          Width = 65
        end
        item
          Caption = 'L1Train'
          Width = 65
        end
        item
          Caption = 'NeedL2'
          Width = 65
        end
        item
          Caption = 'L2Train'
          Width = 65
        end
        item
          Caption = 'NeedL3'
          Width = 65
        end
        item
          Caption = 'L3Train'
          Width = 65
        end
        item
          Caption = 'Delay'
          Width = 65
        end
        item
          Caption = 'Descr'
          Width = 100
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = ListViewMagicClick
    end
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 272
    Width = 833
    Height = 265
    ActivePage = TabSheet1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #39764#27861#25968#25454#24211#32534#36753
      object GroupBox2: TGroupBox
        Left = 8
        Top = 5
        Width = 809
        Height = 212
        Caption = #39764#27861#25968#25454#32534#36753
        TabOrder = 0
        object Label1: TLabel
          Left = 20
          Top = 19
          Width = 30
          Height = 24
          Caption = 'MagID'#13#24207' '#21495
        end
        object Label2: TLabel
          Left = 131
          Top = 18
          Width = 42
          Height = 24
          Caption = 'MagName'#13#21517'   '#31216
        end
        object Label3: TLabel
          Left = 295
          Top = 18
          Width = 60
          Height = 24
          Caption = 'EffectType'#13' '#21160#20316#25928#26524
        end
        object Label4: TLabel
          Left = 444
          Top = 18
          Width = 48
          Height = 24
          Caption = ' Effect'#13#39764#27861#25928#26524
        end
        object Label5: TLabel
          Left = 554
          Top = 18
          Width = 48
          Height = 24
          Caption = ' Spell'#13#39764#27861#28040#32791
        end
        object Label6: TLabel
          Left = 668
          Top = 18
          Width = 48
          Height = 24
          Caption = ' Power'#13#22522#26412#23041#21147
        end
        object Label7: TLabel
          Left = 8
          Top = 57
          Width = 48
          Height = 24
          Caption = 'MaxPower'#13#26368#22823#23041#21147
        end
        object Label8: TLabel
          Left = 125
          Top = 57
          Width = 48
          Height = 24
          Caption = 'DefSpell'#13#21319#32423#39764#27861
        end
        object Label9: TLabel
          Left = 306
          Top = 56
          Width = 48
          Height = 24
          Caption = 'DefPower'#13#21319#32423#23041#21147
        end
        object Label10: TLabel
          Left = 426
          Top = 58
          Width = 66
          Height = 24
          Caption = 'DefMaxPower'#13#21319#26368#22823#23041#21147
        end
        object Label11: TLabel
          Left = 566
          Top = 58
          Width = 24
          Height = 24
          Caption = 'Job'#13#32844#19994
        end
        object Label12: TLabel
          Left = 673
          Top = 57
          Width = 42
          Height = 24
          Caption = 'NeedL1'#13'1'#32423#31561#32423
        end
        object Label13: TLabel
          Left = 8
          Top = 95
          Width = 42
          Height = 24
          Caption = 'L1Train'#13'1'#32423#32463#39564
        end
        object Label14: TLabel
          Left = 130
          Top = 95
          Width = 42
          Height = 24
          Caption = 'NeedL2'#13'2'#32423#31561#32423
        end
        object Label15: TLabel
          Left = 311
          Top = 95
          Width = 42
          Height = 24
          Caption = 'L2Train'#13'2'#32423#32463#39564
        end
        object Label16: TLabel
          Left = 449
          Top = 95
          Width = 42
          Height = 24
          Caption = 'NeedL3'#13'3'#32423#31561#32423
        end
        object Label17: TLabel
          Left = 560
          Top = 95
          Width = 42
          Height = 24
          Caption = 'L3Train'#13'3'#32423#32463#39564
        end
        object Label18: TLabel
          Left = 673
          Top = 94
          Width = 48
          Height = 24
          Caption = ' Delay'#13#25216#33021#24310#26102
        end
        object Label19: TLabel
          Left = 8
          Top = 135
          Width = 48
          Height = 24
          Caption = ' Descr'#13#22791#27880#35828#26126
        end
        object SpinEditMagID: TSpinEdit
          Left = 57
          Top = 20
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 100
          TabOrder = 0
          Value = 100
        end
        object EditMagName: TEdit
          Left = 176
          Top = 20
          Width = 105
          Height = 20
          TabOrder = 1
          Text = #28459#22825#28779#38632
        end
        object SpinEditEffectType: TSpinEdit
          Left = 360
          Top = 20
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 2
          Value = 4
        end
        object SpinEditEffect: TSpinEdit
          Left = 496
          Top = 20
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 3
          Value = 20
        end
        object SpinEditPower: TSpinEdit
          Left = 720
          Top = 20
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 4
          Value = 1
        end
        object SpinEditMaxPower: TSpinEdit
          Left = 57
          Top = 59
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 5
          Value = 1
        end
        object SpinEditDefSpell: TSpinEdit
          Left = 176
          Top = 59
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 6
          Value = 25
        end
        object SpinEditDefPower: TSpinEdit
          Left = 360
          Top = 59
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 7
          Value = 1
        end
        object SpinEditDefMaxPower: TSpinEdit
          Left = 496
          Top = 59
          Width = 49
          Height = 21
          MaxValue = 1000000
          MinValue = 0
          TabOrder = 8
          Value = 1
        end
        object SpinEditJob: TSpinEdit
          Left = 606
          Top = 59
          Width = 49
          Height = 21
          MaxValue = 2
          MinValue = 0
          TabOrder = 9
          Value = 1
        end
        object SpinEditNeedL1: TSpinEdit
          Left = 720
          Top = 59
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 10
          Value = 24
        end
        object SpinEditSpell: TSpinEdit
          Left = 605
          Top = 20
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 11
          Value = 20
        end
        object SpinEditL1Train: TSpinEdit
          Left = 57
          Top = 98
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 12
          Value = 50
        end
        object SpinEditNeedL2: TSpinEdit
          Left = 176
          Top = 98
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 13
          Value = 29
        end
        object SpinEditL2Train: TSpinEdit
          Left = 360
          Top = 98
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 14
          Value = 100
        end
        object SpinEditNeedL3: TSpinEdit
          Left = 496
          Top = 98
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 15
          Value = 33
        end
        object SpinEditL3Train: TSpinEdit
          Left = 606
          Top = 98
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 16
          Value = 150
        end
        object SpinEditDelay: TSpinEdit
          Left = 721
          Top = 95
          Width = 49
          Height = 21
          MaxValue = 10000
          MinValue = 0
          TabOrder = 17
          Value = 80
        end
        object EditDescr: TEdit
          Left = 64
          Top = 139
          Width = 217
          Height = 20
          TabOrder = 18
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #39764#27861#21151#33021#35774#32622
      ImageIndex = 1
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 313
        Height = 225
        Caption = #36873#25321#19968#20010#39764#27861#25928#26524
        TabOrder = 0
        object ListBoxMagic: TListBox
          Left = 8
          Top = 16
          Width = 121
          Height = 201
          Hint = #36873#25321#19968#20010#39764#27861#25928#26524
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxMagicClick
        end
        object GroupBox6: TGroupBox
          Left = 136
          Top = 16
          Width = 169
          Height = 201
          Caption = #39764#27861#35774#32622
          TabOrder = 1
          object LabelSelMagic: TLabel
            Left = 8
            Top = 24
            Width = 72
            Height = 12
            Caption = #20320#36873#25321#30340#26159#65306
          end
          object Label21: TLabel
            Left = 8
            Top = 80
            Width = 54
            Height = 12
            Caption = #39764#27861#25968#37327':'
          end
          object LabelSelMagicName: TLabel
            Left = 8
            Top = 48
            Width = 6
            Height = 12
          end
          object SpinEditMagicCount: TSpinEdit
            Left = 64
            Top = 76
            Width = 97
            Height = 21
            MaxValue = 100
            MinValue = 0
            TabOrder = 0
            Value = 1
          end
        end
      end
      object GroupBox5: TGroupBox
        Left = 480
        Top = 8
        Width = 337
        Height = 225
        Caption = #34987#25915#20987#23545#35937
        TabOrder = 1
        Visible = False
        object CheckBoxHP: TCheckBox
          Left = 104
          Top = 24
          Width = 33
          Height = 17
          Caption = 'HP'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object CheckBoxMP: TCheckBox
          Left = 144
          Top = 24
          Width = 33
          Height = 17
          Caption = 'MP'
          TabOrder = 1
        end
        object CheckBoxAbil: TCheckBox
          Left = 104
          Top = 48
          Width = 215
          Height = 17
          Caption = #25353#29031#32844#19994#20998#21035#22686#21152#25110#20943#23569'DC'#65292'MC'#65292'SC'
          TabOrder = 2
        end
        object CheckBoxAC: TCheckBox
          Left = 184
          Top = 24
          Width = 41
          Height = 17
          Caption = 'AC'
          TabOrder = 3
        end
        object CheckBoxMC: TCheckBox
          Left = 224
          Top = 24
          Width = 33
          Height = 17
          Caption = 'MC'
          TabOrder = 4
        end
        object RadioGroupWay: TRadioGroup
          Left = 8
          Top = 16
          Width = 89
          Height = 201
          Caption = #25915#20987#26041#24335
          ItemIndex = 1
          Items.Strings = (
            #22686#21152#23646#24615
            #20943#23569#23646#24615
            #31227#21160#30446#26631
            #25512#21160#30446#26631
            #40635#30201#30446#26631
            #21484#21796#23453#23453
            #35825#24785#30446#26631
            #32473#30446#26631#25918#27602)
          TabOrder = 5
          Visible = False
          OnClick = RadioGroupWayClick
        end
      end
      object RadioGroupAttackRange: TRadioGroup
        Left = 328
        Top = 8
        Width = 145
        Height = 89
        Caption = #25915#20987#33539#22260
        ItemIndex = 1
        Items.Strings = (
          #21333#20010#30446#26631
          #19968#20010#33539#22260#30340#25152#26377#30446#26631
          #20840#23631#25915#20987)
        TabOrder = 2
        Visible = False
      end
      object RadioGroupMagicNeed: TRadioGroup
        Left = 328
        Top = 104
        Width = 145
        Height = 129
        Caption = #26045#23637#39764#27861
        ItemIndex = 0
        Items.Strings = (
          #38656#35201#39764#27861
          #38656#35201#31526#21650
          #38656#35201#27602#33647)
        TabOrder = 3
        Visible = False
      end
    end
  end
  object ButtonLoadMagic: TButton
    Left = 648
    Top = 544
    Width = 195
    Height = 25
    Caption = #37325#26032#21152#36733#33258#23450#20041#39764#27861#25968#25454#24211'(&R)'
    TabOrder = 2
    OnClick = ButtonLoadMagicClick
  end
  object ButtonSaveMagic: TButton
    Left = 568
    Top = 544
    Width = 75
    Height = 25
    Caption = #20445#23384'(&S)'
    TabOrder = 3
    OnClick = ButtonSaveMagicClick
  end
  object ButtonChgMagic: TButton
    Left = 328
    Top = 544
    Width = 75
    Height = 25
    Caption = #20462#25913'(&C)'
    TabOrder = 4
    OnClick = ButtonChgMagicClick
  end
  object ButtonDelMagic: TButton
    Left = 408
    Top = 544
    Width = 75
    Height = 25
    Caption = #21024#38500'(&D)'
    TabOrder = 5
    OnClick = ButtonDelMagicClick
  end
  object ButtonAddMagic: TButton
    Left = 488
    Top = 544
    Width = 75
    Height = 25
    Caption = #22686#21152'(&A)'
    TabOrder = 6
    OnClick = ButtonAddMagicClick
  end
end

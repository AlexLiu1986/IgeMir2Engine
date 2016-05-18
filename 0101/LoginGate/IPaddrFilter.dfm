object frmIPaddrFilter: TfrmIPaddrFilter
  Left = 225
  Top = 219
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #32593#32476#23433#20840#36807#28388
  ClientHeight = 372
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label6: TLabel
    Left = 0
    Top = 334
    Width = 486
    Height = 36
    Caption = 
      #35828#26126#65306'IP'#27573#36807#28388#65292#22914#35201#23631#34109'192.168.1.0'#33267'192.168.255.255'#30340#20840#37096'IP'#65292#21487#20197#28155#21152'192.168.*.*'#13#10#22914 +
      #21482#38656'192.168.1.0'#33267'192.168.1.255,'#28155#21152'192.168.1.* '#21363#21487'.'#13#10#27880#24847#65306'192.168.*.15,'#21482 +
      #33021#23631#34109'192.168.0.0-192.168.255.255'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object GroupBox2: TGroupBox
    Left = 438
    Top = 1
    Width = 186
    Height = 281
    Caption = #25915#20987#20445#25252
    TabOrder = 0
    object Label2: TLabel
      Left = 5
      Top = 20
      Width = 54
      Height = 12
      Caption = #36830#25509#38480#21046':'
    end
    object Label3: TLabel
      Left = 133
      Top = 20
      Width = 42
      Height = 12
      Caption = #36830#25509'/IP'
    end
    object Label7: TLabel
      Left = 37
      Top = 256
      Width = 120
      Height = 12
      Caption = #20197#19978#21442#25968#35843#21518#31435#21363#29983#25928
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 5
      Top = 40
      Width = 84
      Height = 12
      Caption = #38450#24481#31561#32423#35843#25972#65306
    end
    object EditMaxConnect: TSpinEdit
      Left = 61
      Top = 16
      Width = 65
      Height = 21
      Hint = #21333#20010'IP'#22320#22336#65292#26368#22810#21487#20197#24314#31435#36830#25509#25968#65292#36229#36807#25351#23450#36830#25509#25968#23558#25353#19979#38754#30340#25805#20316#22788#29702
      EditorEnabled = False
      MaxValue = 1000
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 50
      OnChange = EditMaxConnectChange
    end
    object GroupBox3: TGroupBox
      Left = 5
      Top = 160
      Width = 177
      Height = 89
      Caption = #25915#20987#25805#20316
      TabOrder = 1
      object RadioAddBlockList: TRadioButton
        Left = 16
        Top = 64
        Width = 129
        Height = 17
        Hint = #23558#27492#36830#25509#30340'IP'#21152#20837#27704#20037#36807#28388#21015#34920#65292#24182#23558#27492'IP'#30340#25152#26377#36830#25509#24378#34892#20013#26029
        Caption = #21152#20837#27704#20037#36807#28388#21015#34920
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = RadioAddBlockListClick
      end
      object RadioAddTempList: TRadioButton
        Left = 16
        Top = 40
        Width = 129
        Height = 17
        Hint = #23558#27492#36830#25509#30340'IP'#21152#20837#21160#24577#36807#28388#21015#34920#65292#24182#23558#27492'IP'#30340#25152#26377#36830#25509#24378#34892#20013#26029
        Caption = #21152#20837#21160#24577#36807#28388#21015#34920
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = RadioAddTempListClick
      end
      object RadioDisConnect: TRadioButton
        Left = 16
        Top = 16
        Width = 129
        Height = 17
        Hint = #23558#36830#25509#31616#21333#30340#26029#24320#22788#29702
        Caption = #26029#24320#36830#25509
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = RadioDisConnectClick
      end
    end
    object TrackBarAttack: TTrackBar
      Left = 5
      Top = 56
      Width = 177
      Height = 33
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnChange = TrackBarAttackChange
    end
    object CheckBoxChg: TCheckBox
      Left = 5
      Top = 88
      Width = 129
      Height = 17
      Caption = #35843#25972#38450#24481#31561#32423#20026'1'#32423
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = CheckBoxChgClick
    end
    object CheckBoxAutoClearTempList: TCheckBox
      Left = 5
      Top = 112
      Width = 121
      Height = 17
      Caption = #28165#38500#21160#24577#36807#28388#21015#34920
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = CheckBoxAutoClearTempListClick
    end
    object SpinEdit2: TSpinEdit
      Left = 133
      Top = 112
      Width = 41
      Height = 21
      Hint = #31186
      MaxValue = 10000
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Value = 1
      OnChange = SpinEdit2Change
    end
    object CheckBoxReliefDefend: TCheckBox
      Left = 5
      Top = 136
      Width = 129
      Height = 17
      Caption = #26080#25915#20987#36824#21407#38450#24481#31561#32423
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = CheckBoxReliefDefendClick
    end
    object SpinEdit3: TSpinEdit
      Left = 133
      Top = 136
      Width = 41
      Height = 21
      Hint = #31186
      MaxValue = 10000
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Value = 1
      OnChange = SpinEdit3Change
    end
    object SpinEdit1: TSpinEdit
      Left = 133
      Top = 88
      Width = 41
      Height = 21
      Hint = #27425
      MaxValue = 1000
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Value = 1
      OnChange = SpinEdit1Change
    end
  end
  object ButtonOK: TButton
    Left = 489
    Top = 299
    Width = 89
    Height = 25
    Caption = #30830#23450'(&O)'
    Default = True
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 1
    Width = 437
    Height = 329
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 137
      Top = 0
      Height = 329
    end
    object GroupBoxActive: TGroupBox
      Left = 0
      Top = 0
      Width = 137
      Height = 329
      Align = alLeft
      Caption = #24403#21069#36830#25509
      TabOrder = 0
      object Label4: TLabel
        Left = 8
        Top = 17
        Width = 54
        Height = 12
        Caption = #36830#25509#21015#34920':'
      end
      object ListBoxActiveList: TListBox
        Left = 2
        Top = 30
        Width = 133
        Height = 297
        Hint = #24403#21069#36830#25509#30340'IP'#22320#22336#21015#34920
        Align = alBottom
        ItemHeight = 12
        Items.Strings = (
          '888.888.888.888')
        MultiSelect = True
        ParentShowHint = False
        PopupMenu = ActiveListPopupMenu
        ShowHint = True
        Sorted = True
        TabOrder = 0
      end
    end
    object Panel2: TPanel
      Left = 140
      Top = 0
      Width = 297
      Height = 329
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 297
        Height = 329
        Align = alClient
        Caption = #36807#28388#21015#34920
        TabOrder = 0
        object Splitter2: TSplitter
          Left = 141
          Top = 14
          Height = 313
        end
        object Panel3: TPanel
          Left = 2
          Top = 14
          Width = 139
          Height = 313
          Align = alLeft
          BevelOuter = bvNone
          BiDiMode = bdLeftToRight
          Ctl3D = True
          ParentBiDiMode = False
          ParentCtl3D = False
          TabOrder = 0
          object LabelTempList: TLabel
            Left = 6
            Top = 2
            Width = 54
            Height = 12
            Caption = #21160#24577#36807#28388':'
          end
          object ListBoxTempList: TListBox
            Left = 0
            Top = 16
            Width = 139
            Height = 297
            Hint = #21160#24577#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#20294#22312#31243#24207#37325#26032#21551#21160#26102#27492#21015#34920#30340#20449#24687#23558#34987#28165#31354
            Align = alBottom
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ItemHeight = 12
            Items.Strings = (
              '888.888.888.888')
            MultiSelect = True
            ParentFont = False
            ParentShowHint = False
            PopupMenu = TempBlockListPopupMenu
            ShowHint = True
            Sorted = True
            TabOrder = 0
          end
        end
        object Panel4: TPanel
          Left = 144
          Top = 14
          Width = 151
          Height = 313
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Label1: TLabel
            Left = 7
            Top = 3
            Width = 54
            Height = 12
            Caption = #27704#20037#36807#28388':'
          end
          object ListBoxBlockList: TListBox
            Left = 0
            Top = 16
            Width = 151
            Height = 297
            Hint = #27704#20037#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#27492#21015#34920#23558#20445#23384#20110#37197#32622#25991#20214#20013#65292#22312#31243#24207#37325#26032#21551#21160#26102#20250#37325#26032#21152#36733#27492#21015#34920
            Align = alBottom
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ItemHeight = 12
            Items.Strings = (
              '888.888.888.888')
            MultiSelect = True
            ParentFont = False
            ParentShowHint = False
            PopupMenu = BlockListPopupMenu
            ShowHint = True
            Sorted = True
            TabOrder = 0
          end
        end
      end
    end
  end
  object ListBox1: TListBox
    Left = 597
    Top = 244
    Width = 121
    Height = 69
    ItemHeight = 12
    TabOrder = 3
    Visible = False
  end
  object BlockListPopupMenu: TPopupMenu
    OnPopup = BlockListPopupMenuPopup
    Left = 336
    Top = 160
    object BPOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = BPOPMENU_REFLISTClick
    end
    object BPOPMENU_SORT: TMenuItem
      Caption = #25490#24207'(&S)'
      OnClick = BPOPMENU_SORTClick
    end
    object BPOPMENU_ADD: TMenuItem
      Caption = #22686#21152'(&A)'
      OnClick = BPOPMENU_ADDClick
    end
    object BPOPMENU_ADDTEMPLIST: TMenuItem
      Caption = #21152#20837#21160#24577#36807#28388#21015#34920'(&A)'
      OnClick = BPOPMENU_ADDTEMPLISTClick
    end
    object BPOPMENU_DELETE: TMenuItem
      Caption = #21024#38500'(&D)'
      OnClick = BPOPMENU_DELETEClick
    end
  end
  object TempBlockListPopupMenu: TPopupMenu
    OnPopup = TempBlockListPopupMenuPopup
    Left = 216
    Top = 160
    object TPOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = TPOPMENU_REFLISTClick
    end
    object TPOPMENU_SORT: TMenuItem
      Caption = #25490#24207'(&S)'
      OnClick = TPOPMENU_SORTClick
    end
    object TPOPMENU_ADD: TMenuItem
      Caption = #22686#21152'(&A)'
      OnClick = TPOPMENU_ADDClick
    end
    object TPOPMENU_BLOCKLIST: TMenuItem
      Caption = #21152#20837#27704#20037#36807#28388#21015#34920'(&D)'
      OnClick = TPOPMENU_BLOCKLISTClick
    end
    object TPOPMENU_DELETE: TMenuItem
      Caption = #21024#38500'(&D)'
      OnClick = TPOPMENU_DELETEClick
    end
  end
  object ActiveListPopupMenu: TPopupMenu
    OnPopup = ActiveListPopupMenuPopup
    Left = 56
    Top = 160
    object APOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = APOPMENU_REFLISTClick
    end
    object APOPMENU_SORT: TMenuItem
      Caption = #25490#24207'(&S)'
      OnClick = APOPMENU_SORTClick
    end
    object APOPMENU_ADDTEMPLIST: TMenuItem
      Caption = #21152#20837#21160#24577#36807#28388#21015#34920'(&A)'
      OnClick = APOPMENU_ADDTEMPLISTClick
    end
    object APOPMENU_BLOCKLIST: TMenuItem
      Caption = #21152#20837#27704#20037#36807#28388#21015#34920'(&D)'
      OnClick = APOPMENU_BLOCKLISTClick
    end
    object APOPMENU_KICK: TMenuItem
      Caption = #36386#38500#19979#32447'(&K)'
      OnClick = APOPMENU_KICKClick
    end
  end
end

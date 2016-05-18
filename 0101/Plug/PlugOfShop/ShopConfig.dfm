object FrmShopItem: TFrmShopItem
  Left = 77
  Top = 110
  BorderStyle = bsDialog
  Caption = #21830#21697#32534#36753
  ClientHeight = 543
  ClientWidth = 823
  Color = clWindow
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label8: TLabel
    Left = 8
    Top = 469
    Width = 510
    Height = 72
    Caption = 
      #27880#24847#65306#13'['#21160#30011#35774#32622'] '#26159#26576#29992#25143#28857#20987#21830#38138#29289#21697' '#22312#21830#38138#30028#38754#24038#19978#35282#26174#31034#30340#21160#30011#65307#13'['#19981#26174#31034#21160#30011'] '#35831#22312' '#8220#22270#29255#24320#22987#8221' '#22788#28155'380,'#8220#22270#29255 +
      #32467#26463#8221' '#22788#28155'0  '#20999#35760#65307#13'['#26174#31034#21160#30011'] '#22270#29255#24320#22987#22788#35831#28155' '#21160#30011#26174#31034#30340#31532'1'#24352#22270#25968'   '#22270#29255#32467#26463#22788#28155' '#26174#31034#23436#21160#30011#30340#37027#24352#22270#30340#25968#65307#13#27880#24847#65306 +
      ' '#21160#30011#26174#31034#30340#22270#29255#22312#23458#25143#31471#30340' '#8220'Effect.wil'#8221' '#37324#12290#13#25805#20316#8220#22686#21152#12289#20462#25913#12289#21024#38500#8221#21518#65292#35201#28857#20987#8220#20445#23384#8221#65292#25165#33021#20445#23384#25968#25454#12290
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object GroupBox2: TGroupBox
    Left = 656
    Top = 8
    Width = 161
    Height = 457
    Caption = #29289#21697#21015#34920'(CTRL+F'#26597#25214')'
    TabOrder = 0
    object ListBoxItemList: TListBox
      Left = 8
      Top = 16
      Width = 145
      Height = 433
      Hint = 'Ctrl+F '#26597#25214
      ItemHeight = 12
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = ListBoxItemListClick
      OnKeyDown = ListBoxItemListKeyDown
    end
  end
  object RzPanel1: TRzPanel
    Left = 9
    Top = 305
    Width = 640
    Height = 161
    BorderOuter = fsFlatRounded
    BorderColor = clBtnHighlight
    Color = clWindow
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 60
      Height = 12
      Caption = #21830#21697#21517#31216#65306
    end
    object Label3: TLabel
      Left = 336
      Top = 66
      Width = 60
      Height = 12
      Caption = #21830#21697#25551#36848#65306
    end
    object Label2: TLabel
      Left = 8
      Top = 37
      Width = 60
      Height = 12
      Caption = #21830#21697#20215#26684#65306
    end
    object Label4: TLabel
      Left = 336
      Top = 43
      Width = 60
      Height = 12
      Caption = #21830#21697#20171#32461#65306
    end
    object Label7: TLabel
      Left = 120
      Top = 37
      Width = 60
      Height = 12
      Caption = #21830#21697#31867#21035#65306
    end
    object Label9: TLabel
      Left = 483
      Top = 13
      Width = 90
      Height = 12
      Caption = #20803#23453#20817#25442'1'#20010#28789#31526
    end
    object EditShopItemName: TEdit
      Left = 67
      Top = 9
      Width = 150
      Height = 20
      ReadOnly = True
      TabOrder = 0
    end
    object Memo1: TMemo
      Left = 400
      Top = 64
      Width = 225
      Height = 89
      Hint = #25551#36848#20013#38388#30340#65073#20195#34920#25442#34892
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object ButtonLoadShopItemList: TButton
      Left = 8
      Top = 128
      Width = 281
      Height = 25
      Caption = #37325#26032#21152#36733#21830#21697#21015#34920'(&R)'
      TabOrder = 2
      OnClick = ButtonLoadShopItemListClick
    end
    object ButtonSaveShopItemList: TButton
      Left = 224
      Top = 96
      Width = 65
      Height = 25
      Caption = #20445#23384'(&S)'
      TabOrder = 3
      OnClick = ButtonSaveShopItemListClick
    end
    object ButtonDelShopItem: TButton
      Left = 8
      Top = 96
      Width = 65
      Height = 25
      Caption = #21024#38500'(&D)'
      TabOrder = 4
      OnClick = ButtonDelShopItemClick
    end
    object ButtonChgShopItem: TButton
      Left = 80
      Top = 96
      Width = 65
      Height = 25
      Caption = #20462#25913'(&C)'
      TabOrder = 5
      OnClick = ButtonChgShopItemClick
    end
    object ButtonAddShopItem: TButton
      Left = 152
      Top = 96
      Width = 65
      Height = 25
      Caption = #22686#21152'(&A)'
      TabOrder = 6
      OnClick = ButtonAddShopItemClick
    end
    object SpinEditPrice: TSpinEdit
      Left = 67
      Top = 33
      Width = 46
      Height = 21
      MaxValue = 100000000
      MinValue = 0
      TabOrder = 7
      Value = 100
    end
    object EditShopItemIntroduce: TEdit
      Left = 400
      Top = 40
      Width = 225
      Height = 20
      TabOrder = 8
    end
    object ShopTypeBoBox: TComboBox
      Left = 178
      Top = 32
      Width = 113
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      ItemIndex = 0
      TabOrder = 9
      Text = #35013#39280
      Items.Strings = (
        #35013#39280
        #34917#32473
        #24378#21270
        #22909#21451
        #38480#37327
        #22855#29645)
    end
    object GroupBox3: TGroupBox
      Left = 6
      Top = 51
      Width = 283
      Height = 39
      Caption = #21160#30011#35774#32622
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 10
      object Label5: TLabel
        Left = 8
        Top = 18
        Width = 60
        Height = 12
        Caption = #22270#29255#24320#22987#65306
      end
      object Label6: TLabel
        Left = 133
        Top = 17
        Width = 60
        Height = 12
        Caption = #22270#29255#32467#26463#65306
      end
      object EditShopImgBegin: TEdit
        Left = 66
        Top = 13
        Width = 63
        Height = 20
        TabOrder = 0
        Text = '380'
      end
      object EditShopImgEnd: TEdit
        Left = 200
        Top = 13
        Width = 73
        Height = 20
        TabOrder = 1
        Text = '0'
      end
    end
    object CheckBoxBuyGameGird: TCheckBox
      Left = 308
      Top = 11
      Width = 117
      Height = 17
      Caption = #24320#21551#20817#25442#28789#31526#21151#33021
      Checked = True
      State = cbChecked
      TabOrder = 11
      OnClick = CheckBoxBuyGameGirdClick
    end
    object SpinEditGameGird: TSpinEdit
      Left = 436
      Top = 9
      Width = 46
      Height = 21
      MaxValue = 999
      MinValue = 0
      TabOrder = 12
      Value = 1
      OnChange = SpinEditGameGirdChange
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 641
    Height = 289
    Caption = #21830#21697#21015#34920
    TabOrder = 2
    object ListViewItemList: TListView
      Left = 8
      Top = 16
      Width = 625
      Height = 257
      Columns = <
        item
          Caption = #21830#21697#21517#31216
          Width = 100
        end
        item
          Caption = #31867#22411
          Width = 40
        end
        item
          Caption = #21830#21697#20215#26684
          Width = 80
        end
        item
          Caption = #22270#29255#24320#22987
          Width = 60
        end
        item
          Caption = #22270#29255#32467#26463
          Width = 60
        end
        item
          Caption = #31616#21333#20171#32461
          Width = 90
        end
        item
          Caption = #21830#21697#25551#36848
          Width = 190
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = ListViewItemListClick
    end
  end
end

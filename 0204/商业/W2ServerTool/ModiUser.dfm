object ModiUserFrm: TModiUserFrm
  Left = 212
  Top = 129
  Width = 467
  Height = 409
  Caption = #20195#29702#20805#20540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 0
    Top = 0
    Width = 459
    Height = 223
    Align = alTop
    Caption = #20449#24687#26174#31034
    TabOrder = 0
    object DBGridEh1: TDBGridEh
      Left = 2
      Top = 15
      Width = 455
      Height = 206
      Align = alClient
      DataSource = DataSource1
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = DBGridEh1CellClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'ID'
          Footers = <>
          Title.Caption = #32534#21495
        end
        item
          EditButtons = <>
          FieldName = 'User'
          Footers = <>
          Title.Caption = #29992#25143#21517
          Width = 103
        end
        item
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Title.Caption = #30495#23454#22995#21517
          Width = 132
        end
        item
          DisplayFormat = #65509'0.00'
          EditButtons = <>
          FieldName = 'YuE'
          Footers = <>
          Title.Caption = #24080#25143#20313#39069
          Width = 117
        end>
    end
  end
  object GroupBox1: TGroupBox
    Left = 2
    Top = 227
    Width = 456
    Height = 142
    Caption = #35814#32454#20449#24687
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = #26999#20307'_GB2312'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label2: TLabel
      Left = 24
      Top = 24
      Width = 42
      Height = 14
      Caption = #29992#25143#21517
    end
    object Label9: TLabel
      Left = 10
      Top = 84
      Width = 56
      Height = 14
      Caption = #36134#21495#20313#39069
    end
    object Label10: TLabel
      Left = 12
      Top = 55
      Width = 56
      Height = 14
      Caption = #30495#23454#22995#21517
    end
    object Label1: TLabel
      Left = 208
      Top = 24
      Width = 28
      Height = 14
      Caption = #32534#21495
    end
    object Label3: TLabel
      Left = 202
      Top = 83
      Width = 42
      Height = 14
      Caption = #20805#20540#65306
    end
    object Edit2: TEdit
      Left = 72
      Top = 18
      Width = 121
      Height = 22
      Color = clScrollBar
      MaxLength = 8
      ReadOnly = True
      TabOrder = 0
    end
    object Edit4: TEdit
      Left = 72
      Top = 80
      Width = 121
      Height = 22
      Color = clScrollBar
      MaxLength = 18
      ReadOnly = True
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 72
      Top = 51
      Width = 121
      Height = 22
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 261
      Top = 105
      Width = 75
      Height = 26
      Caption = #20462#25913
      TabOrder = 3
      OnClick = BitBtn1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 349
      Top = 106
      Width = 75
      Height = 25
      Caption = #36864#20986
      TabOrder = 4
      OnClick = BitBtn2Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
    object Edit1: TEdit
      Left = 240
      Top = 18
      Width = 121
      Height = 22
      Color = clScrollBar
      MaxLength = 8
      ReadOnly = True
      TabOrder = 5
    end
    object Edit5: TEdit
      Left = 240
      Top = 78
      Width = 121
      Height = 22
      MaxLength = 18
      TabOrder = 6
      OnKeyPress = Edit5KeyPress
    end
    object RadioButton1: TRadioButton
      Left = 208
      Top = 53
      Width = 89
      Height = 17
      Caption = #27491#24120#20805#20540
      Checked = True
      TabOrder = 7
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 304
      Top = 54
      Width = 113
      Height = 17
      Caption = #22870#21169#20801#20540
      TabOrder = 8
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 448
    Top = 136
  end
  object ADOQuery1: TADOQuery
    Connection = LoginForm.ADOConn
    Parameters = <>
    Left = 416
    Top = 136
  end
end

object FrmMain: TFrmMain
  Left = 243
  Top = 259
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'IGE'#25968#25454#24211#36716#25442#24037#20855' V1231'
  ClientHeight = 224
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 481
    Height = 201
    TabOrder = 0
    object Label1: TLabel
      Left = 14
      Top = 18
      Width = 438
      Height = 36
      Caption = 
        #35828#26126#65306#27492#36716#25442#22120#21482#25903#25345'IGE20081014'#20197#21518#30340'DBServer.Exe'#65292'20081014'#20197#21069#30340#19981#20860#23481#65292#13#10#36716#25442#23436#25104#21518#65292#38543#20415#26597#25214 +
        #20219#24847#20154#29289#21517#31216#65292#26597#30475#20854#25968#25454#24211#26159#21542#27491#24120#65292#22914#26524#27491#13#10#24120#23601#35777#26126#36716#25442#25104#21151#65292#21487#20197#20351#29992#12290
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 14
      Top = 72
      Width = 60
      Height = 12
      Caption = #36716#25442#36873#39033#65306
    end
    object Label3: TLabel
      Left = 14
      Top = 99
      Width = 108
      Height = 12
      Caption = 'BLUE'#25968#25454#24211#25991#20214#22841#65306
    end
    object Label4: TLabel
      Left = 14
      Top = 125
      Width = 108
      Height = 12
      Caption = #20445#23384#25968#25454#24211#25991#20214#22841#65306
    end
    object Label5: TLabel
      Left = 14
      Top = 148
      Width = 60
      Height = 12
      Caption = #36716#25442#36827#24230#65306
    end
    object RzProgressBar1: TRzProgressBar
      Left = 120
      Top = 145
      Width = 345
      Height = 16
      Hint = #25991#20214#19979#36733#36827#24230
      BackColor = clWindow
      BarColor = clGreen
      BarColorStop = clLime
      BarStyle = bsGradient
      BorderOuter = fsButtonDown
      BorderWidth = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      InteriorOffset = 0
      ParentFont = False
      ParentShowHint = False
      PartsComplete = 0
      Percent = 0
      ShowHint = True
      TotalParts = 0
    end
    object RzButtonEdit1: TRzButtonEdit
      Left = 120
      Top = 95
      Width = 345
      Height = 20
      TabOrder = 0
      OnButtonClick = RzButtonEdit1ButtonClick
    end
    object RzButtonEdit2: TRzButtonEdit
      Left = 120
      Top = 120
      Width = 345
      Height = 20
      TabOrder = 1
      OnButtonClick = RzButtonEdit2ButtonClick
    end
    object RzButton1: TRzButton
      Left = 168
      Top = 168
      Width = 121
      Caption = #24320#22987#36716#25442'(&S)'
      HotTrack = True
      TabOrder = 2
      OnClick = RzButton1Click
    end
    object ComboBox1: TComboBox
      Left = 120
      Top = 70
      Width = 145
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      ItemIndex = 0
      TabOrder = 3
      Text = 'BLUE'#36716#25442'IGE'
      OnChange = ComboBox1Change
      Items.Strings = (
        'BLUE'#36716#25442'IGE')
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 209
    Width = 495
    Height = 15
    Align = alBottom
    BorderOuter = fsStatus
    TabOrder = 1
    object LabelCopyright: TRzLabel
      Left = 16
      Top = 3
      Width = 84
      Height = 12
      Caption = 'LabelCopyright'
      Transparent = True
    end
    object URLLabel1: TRzURLLabel
      Left = 223
      Top = 2
      Width = 54
      Height = 12
      Caption = 'URLLabel1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object URLLabel2: TRzURLLabel
      Left = 361
      Top = 2
      Width = 54
      Height = 12
      Caption = 'URLLabel1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsUnderline]
      ParentFont = False
      Transparent = True
    end
  end
end

object frmGeneralConfig: TfrmGeneralConfig
  Left = 490
  Top = 296
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22522#26412#35774#32622
  ClientHeight = 158
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBoxNet: TGroupBox
    Left = 2
    Top = 8
    Width = 185
    Height = 113
    Caption = #32593#32476#35774#32622
    TabOrder = 0
    object LabelGateIPaddr: TLabel
      Left = 8
      Top = 20
      Width = 54
      Height = 12
      Caption = #32593#20851#22320#22336':'
    end
    object LabelGatePort: TLabel
      Left = 8
      Top = 44
      Width = 54
      Height = 12
      Caption = #32593#20851#31471#21475':'
    end
    object LabelServerPort: TLabel
      Left = 8
      Top = 92
      Width = 66
      Height = 12
      Caption = #26381#21153#22120#31471#21475':'
    end
    object LabelServerIPaddr: TLabel
      Left = 8
      Top = 68
      Width = 66
      Height = 12
      Caption = #26381#21153#22120#22320#22336':'
    end
    object EditGateIPaddr: TEdit
      Left = 80
      Top = 16
      Width = 97
      Height = 20
      TabOrder = 0
      Text = '0.0.0.0'
    end
    object EditGatePort: TEdit
      Left = 80
      Top = 40
      Width = 41
      Height = 20
      TabOrder = 1
      Text = '37000'
    end
    object EditServerPort: TEdit
      Left = 80
      Top = 88
      Width = 41
      Height = 20
      TabOrder = 2
      Text = '37001'
    end
    object EditServerIPaddr: TEdit
      Left = 80
      Top = 64
      Width = 97
      Height = 20
      TabOrder = 3
      Text = '127.0.0.1'
    end
  end
  object GroupBoxInfo: TGroupBox
    Left = 189
    Top = 8
    Width = 176
    Height = 113
    Caption = #22522#26412#21442#25968
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 49
      Width = 30
      Height = 12
      Caption = #26631#39064':'
      Visible = False
    end
    object LabelShowLogLevel: TLabel
      Left = 8
      Top = 73
      Width = 78
      Height = 12
      Caption = #26174#31034#26085#24535#31561#32423':'
      Visible = False
    end
    object Label202: TLabel
      Left = 4
      Top = 21
      Width = 168
      Height = 12
      Caption = #36386#20986#26080#25805#20316#29992#25143#38388#38548':       '#31186
    end
    object EditTitle: TEdit
      Left = 40
      Top = 45
      Width = 105
      Height = 20
      TabOrder = 0
      Text = #32593#34013#31185#25216
      Visible = False
    end
    object TrackBarLogLevel: TTrackBar
      Left = 8
      Top = 85
      Width = 145
      Height = 25
      TabOrder = 1
      Visible = False
    end
    object SpinEditKeepConnectTime: TSpinEdit
      Left = 116
      Top = 17
      Width = 44
      Height = 21
      MaxValue = 65535
      MinValue = 1
      TabOrder = 2
      Value = 10
    end
  end
  object ButtonOK: TButton
    Left = 296
    Top = 128
    Width = 65
    Height = 25
    Caption = #30830#23450'(&O)'
    TabOrder = 2
    OnClick = ButtonOKClick
  end
end

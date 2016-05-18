object FrmLogin: TFrmLogin
  Left = 334
  Top = 343
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #30331#38470
  ClientHeight = 142
  ClientWidth = 225
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 4
    Top = 6
    Width = 217
    Height = 116
    Caption = #30331#38470
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 22
      Width = 48
      Height = 12
      Caption = #29992#25143#21517#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 48
      Height = 12
      Caption = #23494'  '#30721#65306
    end
    object EdtUser: TEdit
      Left = 64
      Top = 16
      Width = 121
      Height = 20
      TabOrder = 0
      OnKeyDown = EdtUserKeyDown
    end
    object EdtPass: TEdit
      Left = 64
      Top = 43
      Width = 121
      Height = 20
      PasswordChar = '*'
      TabOrder = 1
      OnKeyDown = EdtPassKeyDown
    end
    object CheckBoxSavePass: TCheckBox
      Left = 24
      Top = 67
      Width = 70
      Height = 17
      Caption = #20445#23384#23494#30721
      TabOrder = 4
      OnClick = CheckBoxSavePassClick
    end
    object BtnLogin: TRzButton
      Left = 31
      Top = 85
      Width = 60
      Caption = #30331#38470
      HotTrack = True
      TabOrder = 2
      OnClick = BtnLoginClick
    end
    object BtnReg: TRzButton
      Left = 112
      Top = 85
      Width = 60
      Caption = #27880#20876
      HotTrack = True
      TabOrder = 3
      OnClick = BtnRegClick
    end
    object CheckBoxAutoLogin: TCheckBox
      Left = 105
      Top = 66
      Width = 70
      Height = 17
      Caption = #33258#21160#30331#38470
      TabOrder = 5
      OnClick = CheckBoxAutoLoginClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 123
    Width = 225
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 8
    Top = 128
  end
end

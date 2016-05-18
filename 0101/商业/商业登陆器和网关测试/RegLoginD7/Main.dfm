object FrmMain: TFrmMain
  Left = 472
  Top = 172
  BorderStyle = bsSingle
  Caption = 'RegLogin'
  ClientHeight = 312
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 329
    Height = 89
    Caption = 'UserInfo'
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 33
      Width = 62
      Height = 13
      Caption = 'UserLoginID:'
    end
    object Label2: TLabel
      Left = 19
      Top = 56
      Width = 67
      Height = 13
      Caption = 'UserLoginQQ:'
    end
    object EdtUserLoginID: TEdit
      Left = 103
      Top = 30
      Width = 121
      Height = 21
      TabOrder = 0
      OnKeyPress = EdtUserLoginIDKeyPress
    end
    object EdtUserQQ: TEdit
      Left = 103
      Top = 57
      Width = 121
      Height = 21
      TabOrder = 1
      OnKeyPress = EdtUserQQKeyPress
    end
    object Button1: TButton
      Left = 230
      Top = 28
      Width = 75
      Height = 25
      Caption = 'CheckUserID'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 102
    Width = 329
    Height = 171
    Caption = 'RegInfo'
    TabOrder = 1
    object Label3: TLabel
      Left = 5
      Top = 24
      Width = 69
      Height = 13
      Caption = 'GameListURL:'
    end
    object Label4: TLabel
      Left = 5
      Top = 49
      Width = 88
      Height = 13
      Caption = 'GameBakListURL:'
    end
    object Label5: TLabel
      Left = 5
      Top = 70
      Width = 63
      Height = 13
      Caption = 'PathListURL:'
    end
    object Label6: TLabel
      Left = 5
      Top = 93
      Width = 74
      Height = 13
      Caption = 'GameMonURL:'
    end
    object Label7: TLabel
      Left = 5
      Top = 116
      Width = 55
      Height = 13
      Caption = 'EWebURL:'
    end
    object Label8: TLabel
      Left = 5
      Top = 139
      Width = 49
      Height = 13
      Caption = 'GatePass:'
    end
    object EdtGameListURL: TEdit
      Left = 92
      Top = 22
      Width = 230
      Height = 21
      TabOrder = 0
      Text = 'http://LocalHost/QKServerList.txt'
    end
    object EdtGameBakListURL: TEdit
      Left = 92
      Top = 45
      Width = 230
      Height = 21
      TabOrder = 1
      Text = 'http://LocalHost/QKServerList.txt'
    end
    object EdtPathListURL: TEdit
      Left = 92
      Top = 69
      Width = 230
      Height = 21
      TabOrder = 2
      Text = 'http://LocalHost/QKPatchList.txt'
    end
    object EdtGameMonURL: TEdit
      Left = 92
      Top = 92
      Width = 230
      Height = 21
      TabOrder = 3
      Text = 'http://LocalHost/QKGameMonList.txt'
    end
    object EdtEWebURL: TEdit
      Left = 92
      Top = 115
      Width = 230
      Height = 21
      TabOrder = 4
      Text = 'http://LocalHost/rdxt.htm'
    end
    object EdtGatePass: TEdit
      Left = 92
      Top = 139
      Width = 148
      Height = 21
      Enabled = False
      TabOrder = 5
    end
    object BtnRandomGatePass: TButton
      Left = 241
      Top = 137
      Width = 81
      Height = 25
      Caption = 'RandomMake'
      TabOrder = 6
      OnClick = BtnRandomGatePassClick
    end
  end
  object Button3: TButton
    Left = 56
    Top = 279
    Width = 97
    Height = 25
    Caption = 'RegLogin(&R)'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 200
    Top = 279
    Width = 99
    Height = 25
    Caption = 'CopyRegInfo(&C)'
    TabOrder = 3
    OnClick = Button4Click
  end
  object ADOQuery1: TADOQuery
    Connection = FrmLogin.ADOConn
    Parameters = <>
    Left = 8
    Top = 8
  end
end

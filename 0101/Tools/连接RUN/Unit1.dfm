object Form1: TForm1
  Left = 192
  Top = 114
  Width = 444
  Height = 264
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Rungate'#36830#25509#22120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 36
    Height = 13
    Caption = #29366#24577#65306
  end
  object Label2: TLabel
    Left = 16
    Top = 26
    Width = 10
    Height = 13
    Caption = 'IP'
  end
  object Label3: TLabel
    Left = 179
    Top = 28
    Width = 24
    Height = 13
    Caption = #31471#21475
  end
  object Button1: TButton
    Left = 272
    Top = 21
    Width = 75
    Height = 25
    Caption = #36830#25509
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 32
    Top = 24
    Width = 137
    Height = 21
    TabOrder = 1
    Text = '127.0.0.1'
  end
  object Button2: TButton
    Left = 248
    Top = 112
    Width = 75
    Height = 25
    Caption = #21457#21253
    TabOrder = 2
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 24
    Top = 56
    Width = 201
    Height = 153
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 208
    Top = 24
    Width = 57
    Height = 21
    TabOrder = 4
    Text = '7200'
  end
  object CheckBox1: TCheckBox
    Left = 240
    Top = 152
    Width = 97
    Height = 17
    Caption = #26029#24320#37325#26032#36830#25509
    TabOrder = 5
  end
  object Button3: TButton
    Left = 352
    Top = 21
    Width = 75
    Height = 25
    Caption = #26029#24320
    TabOrder = 6
    OnClick = Button3Click
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnError = ClientSocketError
    Left = 152
    Top = 152
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 256
    Top = 176
  end
end

object FrmGeneralConfig: TFrmGeneralConfig
  Left = 332
  Top = 228
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22522#26412#35774#32622
  ClientHeight = 378
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 335
    Caption = #22522#26412#35774#32622
    TabOrder = 0
    object ListViewServer: TListView
      Left = 8
      Top = 16
      Width = 393
      Height = 309
      Columns = <
        item
          Caption = #20998#21306#32534#21495
          Width = 70
        end
        item
          Caption = #20998#21306#21517#31216
          Width = 100
        end
        item
          Caption = #20998#21306#36335#24452
          Width = 200
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = ListViewServerClick
    end
  end
  object BtnAddServer: TButton
    Left = 232
    Top = 348
    Width = 90
    Height = 25
    Caption = #28155#21152#20998#21306'(&A)'
    TabOrder = 1
    OnClick = BtnAddServerClick
  end
  object BtnDelServer: TButton
    Left = 329
    Top = 348
    Width = 90
    Height = 25
    Caption = #21024#38500#20998#21306'(&D)'
    TabOrder = 2
    OnClick = BtnDelServerClick
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnRead = ClientSocketRead
    Left = 8
    Top = 345
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 40
    Top = 344
  end
end

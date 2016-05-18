object FrmOldPayRecord: TFrmOldPayRecord
  Left = 189
  Top = 73
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #21382#21490#20132#26131#26597#30475
  ClientHeight = 584
  ClientWidth = 542
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
    Left = 6
    Top = 4
    Width = 530
    Height = 573
    Caption = #35814#32454#35760#24405
    TabOrder = 0
    object ListViewLog: TListView
      Left = 2
      Top = 14
      Width = 526
      Height = 557
      Align = alClient
      Columns = <
        item
          Caption = #29609#23478
          Width = 70
        end
        item
          Caption = #26381#21153#22120
          Width = 100
        end
        item
          Caption = #37329#39069
          Width = 40
        end
        item
          Caption = #26102#38388
          Width = 120
        end
        item
          Caption = #21807#19968'ID'
          Width = 180
        end>
      GridLines = True
      MultiSelect = True
      RowSelect = True
      PopupMenu = PopupMenu1
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 262
    Top = 252
    object N1: TMenuItem
      Caption = #22797#21046'(&C)'
      OnClick = N1Click
    end
    object A1: TMenuItem
      Caption = #20840#36873'(&A)'
      OnClick = A1Click
    end
  end
end

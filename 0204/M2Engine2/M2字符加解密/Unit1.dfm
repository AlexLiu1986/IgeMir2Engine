object Form1: TForm1
  Left = 195
  Top = 241
  Width = 605
  Height = 158
  BorderIcons = [biSystemMenu]
  Caption = '56M2'#23383#31526#21152#23494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 597
    Height = 131
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'M2Server'#21152#35299#23494
      object Edit1: TEdit
        Left = 16
        Top = 14
        Width = 560
        Height = 21
        TabOrder = 0
      end
      object Button1: TButton
        Left = 39
        Top = 37
        Width = 75
        Height = 25
        Caption = #21152#23494
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 127
        Top = 37
        Width = 75
        Height = 25
        Caption = #35299#23494
        TabOrder = 2
        OnClick = Button2Click
      end
      object Edit2: TEdit
        Left = 13
        Top = 65
        Width = 563
        Height = 21
        TabOrder = 3
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20854#23427#31243#24207#21152#35299#23494
      ImageIndex = 1
      object Edit4: TEdit
        Left = 10
        Top = 12
        Width = 559
        Height = 21
        TabOrder = 0
      end
      object Button3: TButton
        Left = 32
        Top = 36
        Width = 75
        Height = 25
        Caption = #21152#23494
        TabOrder = 1
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 120
        Top = 36
        Width = 75
        Height = 25
        Caption = #35299#23494
        TabOrder = 2
        OnClick = Button4Click
      end
      object Edit3: TEdit
        Left = 6
        Top = 64
        Width = 563
        Height = 21
        TabOrder = 3
      end
    end
  end
end

object Form1: TForm1
  Left = 333
  Top = 194
  Width = 452
  Height = 350
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 444
    Height = 316
    Align = alClient
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 136
      Width = 36
      Height = 12
      Caption = #32467#26524#65306
    end
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 36
      Height = 12
      Caption = #20195#30721#65306
    end
    object Memo1: TMemo
      Left = 1
      Top = 33
      Width = 442
      Height = 89
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object Memo2: TMemo
      Left = 1
      Top = 160
      Width = 442
      Height = 73
      Align = alCustom
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
    end
    object Button1: TButton
      Left = 126
      Top = 256
      Width = 75
      Height = 25
      Caption = #21152#23494
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 224
      Top = 256
      Width = 75
      Height = 25
      Caption = #35299#23494
      TabOrder = 3
      OnClick = Button2Click
    end
  end
end

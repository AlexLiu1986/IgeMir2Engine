object LogForm: TLogForm
  Left = 306
  Top = 136
  Width = 696
  Height = 480
  BorderIcons = [biSystemMenu]
  Caption = #26085#24535#20998#26512
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 80
    Height = 16
    Caption = #36215#22987#26085#26399#65306
  end
  object Label2: TLabel
    Left = 16
    Top = 52
    Width = 80
    Height = 16
    Caption = #25130#27490#26085#26399#65306
  end
  object Label3: TLabel
    Left = 248
    Top = 32
    Width = 80
    Height = 16
    Caption = #26085#24535#31867#22411#65306
  end
  object dt1: TDateTimePicker
    Left = 96
    Top = 13
    Width = 137
    Height = 24
    Date = 39823.424703414400000000
    Time = 39823.424703414400000000
    TabOrder = 0
  end
  object dt2: TDateTimePicker
    Left = 96
    Top = 48
    Width = 137
    Height = 24
    Date = 39692.424725648100000000
    Time = 39692.424725648100000000
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 326
    Top = 28
    Width = 145
    Height = 24
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 2
    Text = #27880#20876#20195#29702
    Items.Strings = (
      #27880#20876#20195#29702
      #20195#29702#20805#20540
      #27880#20876#29992#25143)
  end
  object Button1: TButton
    Left = 504
    Top = 27
    Width = 75
    Height = 25
    Caption = #26597#35810
    TabOrder = 3
    OnClick = Button1Click
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 80
    Width = 681
    Height = 361
    DataSource = DataSource1
    FooterColor = clWindow
    FooterFont.Charset = GB2312_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -16
    FooterFont.Name = #23435#20307
    FooterFont.Style = []
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghDialogFind]
    SumList.Active = True
    TabOrder = 4
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    Left = 200
    Top = 128
  end
end

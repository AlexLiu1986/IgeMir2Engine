object SXSumFrm: TSXSumFrm
  Left = 392
  Top = 282
  Width = 326
  Height = 219
  BorderIcons = [biSystemMenu]
  Caption = #36873#25321#26085#26399'...'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clBlue
  Font.Height = -19
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 48
    Top = 44
    Width = 95
    Height = 19
    Caption = #36215#22987#26085#26399#65306
  end
  object Label2: TLabel
    Left = 45
    Top = 76
    Width = 95
    Height = 19
    Caption = #25130#27490#26085#26399#65306
  end
  object dt1: TDateTimePicker
    Left = 136
    Top = 40
    Width = 137
    Height = 27
    Date = 39823.424703414400000000
    Time = 39823.424703414400000000
    TabOrder = 0
  end
  object dt2: TDateTimePicker
    Left = 136
    Top = 72
    Width = 137
    Height = 27
    Date = 39692.424725648100000000
    Time = 39692.424725648100000000
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 56
    Top = 128
    Width = 84
    Height = 28
    Caption = #36755#20986
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 168
    Top = 128
    Width = 84
    Height = 28
    Caption = #36864#20986
    TabOrder = 3
    OnClick = BitBtn2Click
  end
end

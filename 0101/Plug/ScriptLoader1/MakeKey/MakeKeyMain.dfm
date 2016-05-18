object FrmMakeKey: TFrmMakeKey
  Left = 352
  Top = 305
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #33050#26412#25554#20214#27880#20876#26426
  ClientHeight = 147
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 48
    Height = 12
    Caption = #26426#22120#30721#65306
  end
  object Label2: TLabel
    Left = 13
    Top = 68
    Width = 48
    Height = 12
    Caption = #27880#20876#30721#65306
  end
  object Label4: TLabel
    Left = 25
    Top = 43
    Width = 36
    Height = 12
    Caption = #23494#30721#65306
  end
  object EditRegisterName: TEdit
    Left = 64
    Top = 16
    Width = 233
    Height = 20
    TabOrder = 0
  end
  object ButtonOK: TButton
    Left = 192
    Top = 104
    Width = 75
    Height = 25
    Caption = #35745#31639
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object EditRegisterCode: TEdit
    Left = 64
    Top = 64
    Width = 233
    Height = 20
    TabOrder = 2
  end
  object EditPassword: TEdit
    Left = 64
    Top = 40
    Width = 233
    Height = 20
    TabOrder = 3
  end
end

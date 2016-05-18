object FrmBasicSet: TFrmBasicSet
  Left = 238
  Top = 206
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22522#26412#35774#32622
  ClientHeight = 238
  ClientWidth = 366
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
    Left = 8
    Top = 8
    Width = 353
    Height = 217
    Caption = #22522#26412#20449#24687
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 24
      Width = 108
      Height = 12
      Caption = #27599#26085#26368#22823#29983#25104#27425#25968#65306
    end
    object EdtMaxDayMakeNum: TEdit
      Left = 114
      Top = 20
      Width = 42
      Height = 20
      TabOrder = 0
    end
    object BtnSave: TButton
      Left = 268
      Top = 183
      Width = 75
      Height = 25
      Caption = #20445#23384'(&S)'
      TabOrder = 1
      OnClick = BtnSaveClick
    end
  end
end

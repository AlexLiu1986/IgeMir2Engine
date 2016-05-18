object FrmLogin: TFrmLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 106
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 16
    Width = 64
    Height = 13
    Caption = 'Account(&L)'#65306
  end
  object Label2: TLabel
    Left = 24
    Top = 51
    Width = 48
    Height = 13
    Caption = 'Pass(&P)'#65306
  end
  object UsersEdt: TComboBox
    Left = 80
    Top = 13
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object PassEdt: TEdit
    Left = 80
    Top = 48
    Width = 145
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    OnKeyDown = PassEdtKeyDown
  end
  object Button1: TButton
    Left = 32
    Top = 75
    Width = 75
    Height = 25
    Caption = 'Ok(&O)'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 136
    Top = 75
    Width = 75
    Height = 25
    Caption = 'Exit(&X)'
    TabOrder = 3
    OnClick = Button2Click
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Left = 8
  end
  object ADOTable1: TADOTable
    Connection = ADOConn
    Left = 40
  end
end

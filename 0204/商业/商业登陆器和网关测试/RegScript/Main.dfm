object FrmMain: TFrmMain
  Left = 192
  Top = 114
  BorderStyle = bsSingle
  Caption = 'RegScript'
  ClientHeight = 251
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 313
    Height = 201
    Caption = #27880#20876#20449#24687
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 17
      Width = 60
      Height = 12
      Caption = #26426' '#22120' '#30721#65306
    end
    object Label3: TLabel
      Left = 8
      Top = 62
      Width = 60
      Height = 12
      Caption = #21040#26399#26102#38388#65306
    end
    object Label5: TLabel
      Left = 8
      Top = 39
      Width = 60
      Height = 12
      Caption = #27880#20876#26085#26399#65306
    end
    object Label2: TLabel
      Left = 8
      Top = 84
      Width = 60
      Height = 12
      Caption = #29992' '#25143' '#21517#65306
    end
    object Label9: TLabel
      Left = 8
      Top = 128
      Width = 60
      Height = 12
      Caption = #27880' '#20876' '#30721#65306
    end
    object UserKeyEdit: TEdit
      Left = 72
      Top = 13
      Width = 233
      Height = 20
      TabOrder = 0
    end
    object UserDateTimeEdit: TRzDateTimeEdit
      Left = 72
      Top = 58
      Width = 233
      Height = 20
      EditType = etDate
      TabOrder = 1
    end
    object RzDateTimeEditRegister: TRzDateTimeEdit
      Left = 72
      Top = 35
      Width = 233
      Height = 20
      EditType = etDate
      TabOrder = 2
    end
    object EditEnterKey: TMemo
      Left = 71
      Top = 103
      Width = 233
      Height = 82
      TabOrder = 3
    end
  end
  object EditUserName: TEdit
    Left = 80
    Top = 89
    Width = 232
    Height = 20
    TabOrder = 1
  end
  object MakeKeyButton: TButton
    Left = 168
    Top = 216
    Width = 97
    Height = 25
    Caption = #35745#31639#27880#20876#30721'(&M)'
    TabOrder = 2
    OnClick = MakeKeyButtonClick
  end
  object ButtonExit: TButton
    Left = 288
    Top = 216
    Width = 99
    Height = 25
    Caption = #20851#38381'(&E)'
    TabOrder = 3
    OnClick = ButtonExitClick
  end
  object RadioGroupLicDay: TRadioGroup
    Left = 328
    Top = 8
    Width = 89
    Height = 201
    Caption = #25480#26435#22825#25968
    ItemIndex = 2
    Items.Strings = (
      #19968#20010#26376
      #21322#24180
      #19968#24180
      #19968#24180#21322
      #20108#24180)
    TabOrder = 4
    OnClick = RadioGroupLicDayClick
  end
end

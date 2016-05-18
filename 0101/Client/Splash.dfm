object SplashForm: TSplashForm
  Left = 466
  Top = 600
  BorderStyle = bsNone
  Caption = 'SplashForm'
  ClientHeight = 100
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 550
    Height = 100
    Align = alClient
  end
  object StateLabel: TRzLabel
    Left = 32
    Top = 34
    Width = 84
    Height = 12
    Caption = #35831' '#31245' '#31561'......'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object ProgressBar1: TProgressBar
    Left = 11
    Top = 52
    Width = 530
    Height = 14
    Enabled = False
    TabOrder = 0
  end
  object Timer2: TTimer
    Interval = 30
    OnTimer = Timer2Timer
    Left = 88
    Top = 2
  end
  object Timer3: TTimer
    Enabled = False
    OnTimer = Timer3Timer
    Left = 118
    Top = 2
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 1
    Top = 1
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 29
    Top = 1
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 57
    Top = 1
  end
  object SendMailTimer: TTimer
    Enabled = False
    OnTimer = SendMailTimerTimer
    Left = 149
    Top = 1
  end
end

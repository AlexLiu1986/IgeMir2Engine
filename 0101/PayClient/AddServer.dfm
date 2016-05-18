object FrmAddServer: TFrmAddServer
  Left = 334
  Top = 426
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22686#21152#20998#21306
  ClientHeight = 87
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 401
    Height = 73
    Caption = #28155#21152#20998#21306#26381#21153#22120
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 84
      Height = 12
      Caption = #20998#21306#26381#21153#22120#21517#65306
    end
    object Label2: TLabel
      Left = 40
      Top = 43
      Width = 60
      Height = 12
      Caption = #20998#21306#36335#24452#65306
    end
    object EdtServerName: TEdit
      Left = 99
      Top = 16
      Width = 201
      Height = 20
      TabOrder = 0
    end
    object BtnAddServer: TButton
      Left = 307
      Top = 12
      Width = 89
      Height = 25
      Caption = #28155#21152#20998#21306
      TabOrder = 1
      OnClick = BtnAddServerClick
    end
    object EdtNpc: TRzButtonEdit
      Left = 99
      Top = 40
      Width = 299
      Height = 20
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 2
      OnButtonClick = EdtNpcButtonClick
    end
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnRead = ClientSocketRead
    Left = 8
    Top = 56
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 40
    Top = 55
  end
end

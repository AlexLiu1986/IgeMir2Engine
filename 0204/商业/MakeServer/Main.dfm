object FrmMain: TFrmMain
  Left = 621
  Top = 241
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #30331#38470#22120#21644#32593#20851#29983#25104#24341#25806
  ClientHeight = 160
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 81
    Width = 366
    Height = 16
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object Label1: TLabel
      Left = 26
      Top = 1
      Width = 54
      Height = 12
      Alignment = taCenter
      Caption = #26410#36830#25509'!!!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 7
      Top = 1
      Width = 6
      Height = 12
      Caption = '\'
    end
    object LbTransCount: TLabel
      Left = 180
      Top = 1
      Width = 60
      Height = 12
      Caption = #29983#25104#32593#20851':0'
    end
    object Label2: TLabel
      Left = 85
      Top = 1
      Width = 72
      Height = 12
      Alignment = taRightJustify
      Caption = #29983#25104#30331#38470#22120':0'
    end
    object Label4: TLabel
      Left = 263
      Top = 1
      Width = 84
      Height = 12
      Caption = #27491#22312#21516#26102#29983#25104':0'
    end
  end
  object MemoLog: TMemo
    Left = 0
    Top = 0
    Width = 366
    Height = 81
    Align = alTop
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clLime
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 97
    Width = 366
    Height = 63
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    Color = clGreen
    TabOrder = 2
    object ListView: TListView
      Left = 0
      Top = 0
      Width = 366
      Height = 63
      Align = alClient
      Columns = <
        item
          Caption = #27169#22359#21517#31216
          Width = 80
        end
        item
          Caption = #36830#25509#22320#22336
          Width = 230
        end
        item
          Caption = #29366#24577
          Width = 40
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      SortType = stBoth
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object DecodeTimer: TTimer
    Interval = 1
    OnTimer = DecodeTimerTimer
    Left = 32
    Top = 4
  end
  object ServerSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 4
    Top = 4
  end
  object MainMenu: TMainMenu
    Left = 88
    Top = 4
    object T2: TMenuItem
      Caption = #25511#21046'(&C)'
      object MENU_CONTROL_START: TMenuItem
        Caption = #21551#21160#26381#21153'(&S)'
        OnClick = MENU_CONTROL_STARTClick
      end
      object MENU_CONTROL_STOP: TMenuItem
        Caption = #20572#27490#26381#21153'(&T)'
        OnClick = MENU_CONTROL_STOPClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N4: TMenuItem
        Caption = #36864#20986
        OnClick = N4Click
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&O)'
      object N8: TMenuItem
        Caption = #22522#26412#35774#32622'(&G)'
        OnClick = N8Click
      end
    end
    object N1: TMenuItem
      Caption = #27979#35797
      object N2: TMenuItem
        Caption = #29983#25104#30331#38470#22120
        OnClick = N2Click
      end
      object N5: TMenuItem
        Caption = #29983#25104#32593#20851
        OnClick = N5Click
      end
    end
    object N6: TMenuItem
      Caption = #24110#21161'(&H)'
      object A1: TMenuItem
        Caption = #20851#20110'(&A)'
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 60
    Top = 4
  end
  object Timer2: TTimer
    Interval = 300
    OnTimer = Timer2Timer
    Left = 116
    Top = 4
  end
end

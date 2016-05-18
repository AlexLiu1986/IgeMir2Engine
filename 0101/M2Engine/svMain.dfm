object FrmMain: TFrmMain
  Left = 840
  Top = 379
  Width = 440
  Height = 391
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzSplitter: TRzSplitter
    Left = 0
    Top = 0
    Width = 432
    Height = 337
    Orientation = orVertical
    Position = 158
    Percent = 46
    HotSpotVisible = True
    HotSpotSizePercent = 100
    SplitterWidth = 7
    Align = alClient
    BorderShadow = clBtnFace
    Color = 16777088
    TabOrder = 0
    BarSize = (
      0
      158
      432
      165)
    UpperLeftControls = (
      MemoLog)
    LowerRightControls = (
      RzSplitter1)
    object MemoLog: TRzMemo
      Left = 0
      Top = 0
      Width = 432
      Height = 158
      Align = alClient
      Color = clBlack
      Font.Charset = GB2312_CHARSET
      Font.Color = clLime
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = MemoLogChange
      OnDblClick = MemoLogDblClick
      FrameVisible = True
    end
    object RzSplitter1: TRzSplitter
      Left = 0
      Top = 0
      Width = 432
      Height = 172
      Orientation = orVertical
      Position = 79
      Percent = 46
      SplitterWidth = 0
      Align = alClient
      TabOrder = 0
      BarSize = (
        0
        79
        432
        79)
      UpperLeftControls = (
        Panel)
      LowerRightControls = (
        GridGate)
      object Panel: TRzPanel
        Left = 0
        Top = 0
        Width = 432
        Height = 79
        Align = alClient
        BorderOuter = fsNone
        TabOrder = 0
        object Label1: TLabel
          Left = 0
          Top = 16
          Width = 6
          Height = 12
          Transparent = True
        end
        object Label2: TLabel
          Left = 0
          Top = 32
          Width = 6
          Height = 12
          Transparent = True
        end
        object Label20: TLabel
          Left = 0
          Top = 64
          Width = 6
          Height = 12
          Transparent = True
        end
        object Label5: TLabel
          Left = 0
          Top = 48
          Width = 6
          Height = 12
          Transparent = True
        end
        object Lbcheck: TLabel
          Left = 48
          Top = 64
          Width = 6
          Height = 12
          Transparent = True
          Visible = False
        end
        object LbRunSocketTime: TLabel
          Left = 0
          Top = 0
          Width = 6
          Height = 12
          Transparent = True
        end
        object LbRunTime: TLabel
          Left = 256
          Top = 16
          Width = 6
          Height = 12
          Transparent = True
        end
        object LbTimeCount: TLabel
          Left = 427
          Top = 64
          Width = 6
          Height = 12
          Alignment = taRightJustify
          Transparent = True
        end
        object LbUserCount: TLabel
          Left = 427
          Top = 0
          Width = 6
          Height = 12
          Alignment = taRightJustify
          Transparent = True
        end
        object MemStatus: TLabel
          Left = 427
          Top = 13
          Width = 6
          Height = 12
          Alignment = taRightJustify
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
          Visible = False
        end
        object LabelVersion: TLabel
          Left = 426
          Top = 32
          Width = 6
          Height = 12
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
        end
      end
      object GridGate: TRzStringGrid
        Left = 0
        Top = 0
        Width = 432
        Height = 93
        Align = alClient
        ColCount = 7
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        ColWidths = (
          32
          110
          54
          52
          51
          51
          51)
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    Left = 60
    Top = 12
  end
  object RunTimer: TTimer
    Enabled = False
    Interval = 1
    Left = 96
    Top = 12
  end
  object DBSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 6000
    Left = 24
    Top = 11
  end
  object ConnectTimer: TTimer
    Enabled = False
    Interval = 3000
    Left = 60
    Top = 48
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 100
    Left = 132
    Top = 12
  end
  object SaveVariableTimer: TTimer
    Enabled = False
    Interval = 30000
    Left = 164
    Top = 12
  end
  object CloseTimer: TTimer
    Enabled = False
    Interval = 100
    Left = 96
    Top = 48
  end
  object MainMenu: TMainMenu
    AutoHotkeys = maManual
    Left = 160
    Top = 48
    object MENU_CONTROL: TMenuItem
      Caption = #25511#21046'(&C)'
      OnClick = MENU_CONTROLClick
      object MENU_CONTROL_CLEARLOGMSG: TMenuItem
        Caption = #28165#38500#26085#24535'(&C)'
        OnClick = MENU_CONTROL_CLEARLOGMSGClick
      end
      object MENU_CONTROL_RELOAD: TMenuItem
        Caption = #37325#26032#21152#36733'(&R)'
        object MENU_CONTROL_RELOAD_ITEMDB: TMenuItem
          Caption = #29289#21697#25968#25454#24211'(&I)'
          OnClick = MENU_CONTROL_RELOAD_ITEMDBClick
        end
        object MENU_CONTROL_RELOAD_MAGICDB: TMenuItem
          Caption = #25216#33021#25968#25454#24211'(&S)'
          OnClick = MENU_CONTROL_RELOAD_MAGICDBClick
        end
        object MENU_CONTROL_RELOAD_MONSTERDB: TMenuItem
          Caption = #24618#29289#25968#25454#24211'(&M)'
          OnClick = MENU_CONTROL_RELOAD_MONSTERDBClick
        end
        object MENU_CONTROL_RELOAD_MONSTERSAY: TMenuItem
          Caption = #24618#29289#35828#35805#35774#32622'(&M)'
          OnClick = MENU_CONTROL_RELOAD_MONSTERSAYClick
        end
        object MENU_CONTROL_RELOAD_DISABLEMAKE: TMenuItem
          Caption = #25968#25454#21015#34920'(&D)'
          OnClick = MENU_CONTROL_RELOAD_DISABLEMAKEClick
        end
        object MENU_CONTROL_RELOAD_STARTPOINT: TMenuItem
          Caption = #22320#22270#23433#20840#21306'(&S)'
          OnClick = MENU_CONTROL_RELOAD_STARTPOINTClick
        end
        object MENU_CONTROL_RELOAD_CONF: TMenuItem
          Caption = #21442#25968#35774#32622'(&C)'
          OnClick = MENU_CONTROL_RELOAD_CONFClick
        end
        object QFunctionNPC: TMenuItem
          Caption = 'QFunction '#33050#26412'(&Q)'
          OnClick = QFunctionNPCClick
        end
        object QManageNPC: TMenuItem
          Caption = #30331#38470#33050#26412'(&L)'
          OnClick = QManageNPCClick
        end
        object RobotManageNPC: TMenuItem
          Caption = #26426#22120#20154#33050#26412'(&R)'
          OnClick = RobotManageNPCClick
        end
        object MonItems: TMenuItem
          Caption = #24618#29289#29190#29575'(&M)'
          OnClick = MonItemsClick
        end
        object N2: TMenuItem
          Caption = '-'
        end
        object N3: TMenuItem
          Caption = #23453#31665#37197#32622
          OnClick = N3Click
        end
        object N5: TMenuItem
          Caption = #24618#29289#21047#26032#37197#32622
          OnClick = N5Click
        end
        object N6: TMenuItem
          Caption = #20844#21578#25552#31034#20449#24687
          OnClick = N6Click
        end
        object NPC1: TMenuItem
          Caption = #20132#26131'NPC'#37197#32622
          OnClick = NPC1Click
        end
        object NPC2: TMenuItem
          Caption = #31649#29702'NPC'#37197#32622
          OnClick = NPC2Click
        end
        object N7: TMenuItem
          Caption = #28140#28860#37197#32622
          OnClick = N7Click
        end
        object S1: TMenuItem
          Caption = #21021#22987#21270#27801#22478#37197#32622'(&S)'
          OnClick = S1Click
        end
      end
      object MENU_CONTROL_GATE: TMenuItem
        Caption = #28216#25103#32593#20851'(&G)'
        object MENU_CONTROL_GATE_OPEN: TMenuItem
          Caption = #25171#24320'(&O)'
          OnClick = MENU_CONTROL_GATE_OPENClick
        end
        object MENU_CONTROL_GATE_CLOSE: TMenuItem
          Caption = #20851#38381'(&C)'
          OnClick = MENU_CONTROL_GATE_CLOSEClick
        end
      end
      object MENU_CONTROL_EXIT: TMenuItem
        Caption = #36864#20986'(&X)'
        OnClick = MENU_CONTROL_EXITClick
      end
      object XXX1: TMenuItem
        Caption = #27979#35797
        Visible = False
        OnClick = XXX1Click
      end
    end
    object MENU_VIEW: TMenuItem
      Caption = #26597#30475'(&V)'
      object MENU_VIEW_ONLINEHUMAN: TMenuItem
        Caption = #22312#32447#20154#29289'(&O)'
        OnClick = MENU_VIEW_ONLINEHUMANClick
      end
      object MENU_VIEW_SESSION: TMenuItem
        Caption = #20840#23616#20250#35805'(&S)'
        OnClick = MENU_VIEW_SESSIONClick
      end
      object MENU_VIEW_LEVEL: TMenuItem
        Caption = #31561#32423#23646#24615'(&L)'
        OnClick = MENU_VIEW_LEVELClick
      end
      object MENU_VIEW_LIST: TMenuItem
        Caption = #21015#34920#20449#24687#19968'(&L)'
        OnClick = MENU_VIEW_LISTClick
      end
      object N1: TMenuItem
        Caption = #21015#34920#20449#24687#20108'(&L)'
        OnClick = N1Click
      end
      object MENU_VIEW_KERNELINFO: TMenuItem
        Caption = #20869#26680#25968#25454'(&K)'
        OnClick = MENU_VIEW_KERNELINFOClick
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&P)'
      object MENU_OPTION_GENERAL: TMenuItem
        Caption = #22522#26412#35774#32622'(&G)'
        OnClick = MENU_OPTION_GENERALClick
      end
      object MENU_OPTION_GAME: TMenuItem
        Caption = #21442#25968#35774#32622'(&O)'
        OnClick = MENU_OPTION_GAMEClick
      end
      object MENU_OPTION_ITEMFUNC: TMenuItem
        Caption = #29289#21697#35013#22791'(&I)'
        OnClick = MENU_OPTION_ITEMFUNCClick
      end
      object MENU_OPTION_FUNCTION: TMenuItem
        Caption = #21151#33021#35774#32622'(&F)'
        OnClick = MENU_OPTION_FUNCTIONClick
      end
      object G1: TMenuItem
        Caption = #28216#25103#21629#20196'(&C)'
        OnClick = G1Click
      end
      object MENU_OPTION_MONSTER: TMenuItem
        Caption = #24618#29289#35774#32622'(&M)'
        OnClick = MENU_OPTION_MONSTERClick
      end
      object MENU_OPTION_SERVERCONFIG: TMenuItem
        Caption = #24615#33021#21442#25968'(&P)'
        OnClick = MENU_OPTION_SERVERCONFIGClick
      end
      object MENU_OPTION_HERO: TMenuItem
        Caption = #33521#38596#35774#32622'(&H)'
        OnClick = MENU_OPTION_HEROClick
      end
    end
    object MENU_MANAGE: TMenuItem
      Caption = #31649#29702'(&M)'
      object MENU_MANAGE_ONLINEMSG: TMenuItem
        Caption = #22312#32447#28040#24687'(&S)'
        OnClick = MENU_MANAGE_ONLINEMSGClick
      end
      object MENU_MANAGE_PLUG: TMenuItem
        Caption = #21151#33021#25554#20214'(&P)'
        OnClick = MENU_MANAGE_PLUGClick
      end
      object MENU_MANAGE_CASTLE: TMenuItem
        Caption = #22478#22561#31649#29702'(&C)'
        OnClick = MENU_MANAGE_CASTLEClick
      end
    end
    object MENU_TOOLS: TMenuItem
      Caption = #24037#20855'(&T)'
      object MENU_TOOLS_MERCHANT: TMenuItem
        Caption = #20132#26131'NPC'#37197#32622'(&M)'
        OnClick = MENU_TOOLS_MERCHANTClick
      end
      object MENU_TOOLS_NPC: TMenuItem
        Caption = #31649#29702'NPC'#37197#32622'(&N)'
        Visible = False
      end
      object MENU_TOOLS_MONGEN: TMenuItem
        Caption = #21047#24618#37197#32622'(&G)'
        OnClick = MENU_TOOLS_MONGENClick
      end
      object MENU_TOOLS_IPSEARCH: TMenuItem
        Caption = #22320#21306#26597#35810'(&S)'
        OnClick = MENU_TOOLS_IPSEARCHClick
      end
    end
    object MENU_HELP: TMenuItem
      Caption = #24110#21161'(&H)'
      object MENU_HELP_REGKEY: TMenuItem
        Caption = #27880#20876'(&R)'
        Visible = False
        OnClick = MENU_HELP_REGKEYClick
      end
      object MENU_HELP_ABOUT: TMenuItem
        Caption = #20851#20110'(&A)'
        OnClick = MENU_HELP_ABOUTClick
      end
    end
  end
  object IdUDPClientLog: TIdUDPClient
    Port = 0
    Left = 128
    Top = 48
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 24
    Top = 48
  end
end

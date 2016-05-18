object FrmHookCheck: TFrmHookCheck
  Left = 338
  Top = 225
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22806#25346#25511#21046
  ClientHeight = 215
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 6
    Top = 6
    Width = 483
    Height = 176
    Caption = #21551#29992#22806#25346#25511#21046
    TabOrder = 0
    object Label4: TLabel
      Left = 263
      Top = 133
      Width = 210
      Height = 12
      Caption = #25552#31034#65306#32047#35745#20540#36798#21040'50'#21017#35753#21152#36895#20154#29289'T'#19979#32447
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 16
      Width = 145
      Height = 49
      Caption = '1'
      TabOrder = 1
      object LabelWalkIntrt: TLabel
        Left = 7
        Top = 21
        Width = 132
        Height = 12
        Caption = #26102#38388#38388#38548':         '#27627#31186
      end
      object SpinEditWalk: TSpinEdit
        Left = 63
        Top = 16
        Width = 49
        Height = 21
        Hint = #27492#20540#24212#19982'M2('#21442#25968#35774#32622'->'#28216#25103#36895#24230')'#36208#36335#36895#24230#35774#32622#30456#36817#20284
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 45000
        MinValue = 100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Value = 600
        OnChange = SpinEditWalkChange
      end
    end
    object CheckBoxWalk: TCheckBox
      Left = 16
      Top = 12
      Width = 65
      Height = 20
      Caption = #36208#36335#25511#21046
      Enabled = False
      TabOrder = 0
      OnClick = CheckBoxWalkClick
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 72
      Width = 145
      Height = 49
      Caption = '2'
      TabOrder = 3
      object Label1: TLabel
        Left = 7
        Top = 21
        Width = 132
        Height = 12
        Caption = #26102#38388#38388#38548':         '#27627#31186
      end
      object SpinEditRun: TSpinEdit
        Left = 63
        Top = 16
        Width = 49
        Height = 21
        Hint = #27492#20540#24212#19982'M2('#21442#25968#35774#32622'->'#28216#25103#36895#24230')'#36305#27493#36895#24230#35774#32622#30456#36817#20284
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 45000
        MinValue = 100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Value = 430
        OnChange = SpinEditRunChange
      end
    end
    object CheckBoxRun: TCheckBox
      Left = 16
      Top = 69
      Width = 65
      Height = 17
      Caption = #36305#27493#25511#21046
      Enabled = False
      TabOrder = 2
      OnClick = CheckBoxRunClick
    end
    object GroupBox4: TGroupBox
      Left = 160
      Top = 16
      Width = 145
      Height = 49
      Caption = '2'
      TabOrder = 5
      object Label2: TLabel
        Left = 7
        Top = 21
        Width = 132
        Height = 12
        Caption = #26102#38388#38388#38548':         '#27627#31186
      end
      object SpinEditHit: TSpinEdit
        Left = 63
        Top = 16
        Width = 49
        Height = 21
        Hint = #27492#20540#24212#19982'M2('#21442#25968#35774#32622'->'#28216#25103#36895#24230')'#25915#20987#36895#24230#35774#32622#30456#36817#20284#13#10#38656#32771#34385#24102#21152#36895#29289#21697#21518#30340#25915#20987#36895#24230
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 45000
        MinValue = 100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Value = 900
        OnChange = SpinEditHitChange
      end
    end
    object GroupBox5: TGroupBox
      Left = 160
      Top = 72
      Width = 145
      Height = 49
      Caption = '2'
      TabOrder = 7
      object Label3: TLabel
        Left = 7
        Top = 21
        Width = 132
        Height = 12
        Caption = #26102#38388#38388#38548':         '#27627#31186
      end
      object SpinEditSpell: TSpinEdit
        Left = 63
        Top = 16
        Width = 49
        Height = 21
        Hint = #27492#20540#24212#19982'M2('#21442#25968#35774#32622'->'#28216#25103#36895#24230')'#39764#27861#36895#24230#35774#32622#30456#36817#20284#13#10#38656#32771#34385#24102#21152#36895#29289#21697#21518#30340#39764#27861#36895#24230
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 45000
        MinValue = 100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Value = 800
        OnChange = SpinEditSpellChange
      end
    end
    object CheckBoxHit: TCheckBox
      Left = 168
      Top = 12
      Width = 65
      Height = 20
      Caption = #25915#20987#25511#21046
      Enabled = False
      TabOrder = 4
      OnClick = CheckBoxHitClick
    end
    object CheckBoxSpell: TCheckBox
      Left = 168
      Top = 69
      Width = 65
      Height = 17
      Caption = #39764#27861#25511#21046
      Enabled = False
      TabOrder = 6
      OnClick = CheckBoxSpellClick
    end
    object GroupBox6: TGroupBox
      Left = 312
      Top = 16
      Width = 161
      Height = 113
      Caption = #20849#29992#35774#32622
      TabOrder = 8
      object Label9: TLabel
        Left = 7
        Top = 66
        Width = 102
        Height = 12
        Caption = #27599#27425#21152#36895#30340#32047#21152#20540':'
      end
      object Label10: TLabel
        Left = 7
        Top = 90
        Width = 102
        Height = 12
        Caption = #27491#24120#21160#20316#30340#20943#23569#20540':'
      end
      object CheckBoxDoubleAttack: TCheckBox
        Left = 9
        Top = 16
        Width = 97
        Height = 17
        Caption = #31105#27490#22810#20493#25915#20987
        Enabled = False
        TabOrder = 0
      end
      object SpinEditIncErrorCount: TSpinEdit
        Left = 112
        Top = 61
        Width = 41
        Height = 21
        EditorEnabled = False
        Enabled = False
        MaxValue = 500
        MinValue = 1
        TabOrder = 1
        Value = 5
        OnChange = SpinEditIncErrorCountChange
      end
      object SpinEditDecErrorCount: TSpinEdit
        Left = 112
        Top = 85
        Width = 41
        Height = 21
        EditorEnabled = False
        Enabled = False
        MaxValue = 500
        MinValue = 1
        TabOrder = 2
        Value = 1
        OnChange = SpinEditDecErrorCountChange
      end
      object CheckBoxUnitActCtrl: TCheckBox
        Left = 9
        Top = 32
        Width = 97
        Height = 17
        Caption = #24320#21551#32452#21512#25511#21046
        Enabled = False
        TabOrder = 3
      end
      object CheckBoxKick: TCheckBox
        Left = 9
        Top = 48
        Width = 97
        Height = 17
        Caption = #21152#36895#25481#32447#22788#29702
        Enabled = False
        TabOrder = 4
      end
    end
    object EditErrMsg: TEdit
      Left = 8
      Top = 148
      Width = 465
      Height = 20
      Color = clRed
      Enabled = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 255
      ParentFont = False
      TabOrder = 9
      Text = '['#25552#31034']: '#35831#29233#25252#28216#25103#29615#22659#65292#20851#38381#21152#36895#22806#25346#37325#26032#30331#38470
      OnChange = EditErrMsgChange
    end
    object CheckBoxWarning: TCheckBox
      Left = 9
      Top = 128
      Width = 96
      Height = 15
      Caption = #24320#21551#21152#36895#25552#31034
      TabOrder = 10
      OnClick = CheckBoxWarningClick
    end
    object ComBoxSpeedHackWarningType: TComboBox
      Left = 104
      Top = 125
      Width = 72
      Height = 20
      Enabled = False
      ItemHeight = 12
      ItemIndex = 0
      TabOrder = 11
      Text = #23494#20154#25552#31034
      Items.Strings = (
        #23494#20154#25552#31034
        #24377#31383#25552#31034)
    end
  end
  object BitBtnVSetup: TBitBtn
    Left = 294
    Top = 185
    Width = 105
    Height = 25
    Caption = #24674#22797#40664#35748#35774#32622'(&C)'
    TabOrder = 1
    OnClick = BitBtnVSetupClick
  end
  object BitBtnOK: TBitBtn
    Left = 182
    Top = 185
    Width = 105
    Height = 25
    Caption = #20445#23384#21551#29992#35774#32622'(&O)'
    Enabled = False
    TabOrder = 2
    OnClick = BitBtnOKClick
  end
  object BitBtnCancel: TBitBtn
    Left = 406
    Top = 185
    Width = 81
    Height = 25
    Caption = #20851#38381'(&C)'
    ModalResult = 2
    TabOrder = 3
    OnClick = BitBtnCancelClick
  end
  object CheckBoxCheck: TCheckBox
    Left = 14
    Top = 3
    Width = 92
    Height = 17
    Caption = #21551#29992#22806#25346#25511#21046
    TabOrder = 4
    OnClick = CheckBoxCheckClick
  end
end

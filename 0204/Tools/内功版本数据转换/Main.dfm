object FrmMain: TFrmMain
  Left = 192
  Top = 107
  Width = 696
  Height = 446
  Caption = 'IGE'#31185#25216#25968#25454#26684#24335#21319#32423#24037#20855
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 688
    Height = 412
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet3: TTabSheet
      Caption = '0824~0929'#29256'->1231'#29256
      ImageIndex = 2
      DesignSize = (
        680
        385)
      object Label17: TLabel
        Left = 8
        Top = 16
        Width = 54
        Height = 12
        Caption = #20445#23384#30446#24405':'
      end
      object SpeedButton7: TSpeedButton
        Left = 645
        Top = 12
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '...'
        OnClick = SpeedButton7Click
      end
      object Label20: TLabel
        Left = 8
        Top = 120
        Width = 600
        Height = 24
        Caption = 
          #27880#24847#65306#21319#32423#20043#21069#19968#23450#35201#22791#20221'FDB'#24211#65292#21542#21017#36896#25104#20219#20309#21518#26524#33258#36127#12290' '#22914#26524#26377#36716#25442#19981#20102#25110#36716#25442#20043#21518#20154#29289#20986#38169#35831#21040#35770#22363#21453#26144#12290#13'Http://Www.' +
          'IGEM2.Com.Cn'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Edit3: TEdit
        Left = 64
        Top = 13
        Width = 582
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object GroupBox5: TGroupBox
        Left = 7
        Top = 41
        Width = 671
        Height = 76
        Caption = #38656#36716#25442#30340#25968#25454#25991#20214
        TabOrder = 1
        DesignSize = (
          671
          76)
        object Label18: TLabel
          Left = 8
          Top = 25
          Width = 36
          Height = 12
          Caption = 'Hum.db'
        end
        object Label19: TLabel
          Left = 8
          Top = 52
          Width = 36
          Height = 12
          Caption = 'Mir.db'
        end
        object SpeedButton8: TSpeedButton
          Left = 638
          Top = 22
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton8Click
        end
        object SpeedButton9: TSpeedButton
          Left = 638
          Top = 49
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton9Click
        end
        object Hum_db3: TEdit
          Left = 48
          Top = 22
          Width = 591
          Height = 20
          TabOrder = 0
        end
        object Mir_db3: TEdit
          Left = 48
          Top = 49
          Width = 591
          Height = 20
          TabOrder = 1
        end
      end
      object GroupBox6: TGroupBox
        Left = 3
        Top = 147
        Width = 677
        Height = 204
        Anchors = [akLeft, akRight, akBottom]
        Caption = #36827#24230#20449#24687
        TabOrder = 2
        DesignSize = (
          677
          204)
        object Label21: TLabel
          Left = 8
          Top = 16
          Width = 30
          Height = 12
          Caption = #20449#24687':'
        end
        object Label22: TLabel
          Left = 648
          Top = 32
          Width = 18
          Height = 12
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = '0/0'
          ParentBiDiMode = False
        end
        object Label23: TLabel
          Left = 624
          Top = 15
          Width = 30
          Height = 12
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = #22833#36133':'
          ParentBiDiMode = False
        end
        object Label24: TLabel
          Left = 8
          Top = 32
          Width = 18
          Height = 12
          Caption = '0/0'
        end
        object Memo3: TMemo
          Left = 8
          Top = 69
          Width = 658
          Height = 124
          Anchors = [akLeft, akTop, akRight]
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object ProgressBar5: TProgressBar
          Left = 0
          Top = -16
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          Visible = False
        end
        object ProgressBar6: TProgressBar
          Left = 8
          Top = 48
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
      end
      object Button5: TButton
        Left = 456
        Top = 359
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #24320#22987#36716#25442
        Default = True
        TabOrder = 3
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 541
        Top = 359
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986
        TabOrder = 4
        OnClick = Button6Click
      end
    end
    object TabSheet1: TTabSheet
      Caption = '1014'#29256'->1231'#29256
      ImageIndex = 1
      DesignSize = (
        680
        385)
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 54
        Height = 12
        Caption = #20445#23384#30446#24405':'
      end
      object SpeedButton1: TSpeedButton
        Left = 645
        Top = 12
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object Label2: TLabel
        Left = 8
        Top = 120
        Width = 600
        Height = 24
        Caption = 
          #27880#24847#65306#21319#32423#20043#21069#19968#23450#35201#22791#20221'FDB'#24211#65292#21542#21017#36896#25104#20219#20309#21518#26524#33258#36127#12290' '#22914#26524#26377#36716#25442#19981#20102#25110#36716#25442#20043#21518#20154#29289#20986#38169#35831#21040#35770#22363#21453#26144#12290#13'Http://Www.' +
          'IGEM2.Com.Cn'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 64
        Top = 13
        Width = 582
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 147
        Width = 677
        Height = 204
        Anchors = [akLeft, akRight, akBottom]
        Caption = #36827#24230#20449#24687
        TabOrder = 1
        DesignSize = (
          677
          204)
        object Label3: TLabel
          Left = 8
          Top = 16
          Width = 30
          Height = 12
          Caption = #20449#24687':'
        end
        object Label4: TLabel
          Left = 648
          Top = 32
          Width = 18
          Height = 12
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = '0/0'
          ParentBiDiMode = False
        end
        object Label5: TLabel
          Left = 624
          Top = 15
          Width = 30
          Height = 12
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = #22833#36133':'
          ParentBiDiMode = False
        end
        object Label6: TLabel
          Left = 8
          Top = 32
          Width = 18
          Height = 12
          Caption = '0/0'
        end
        object Memo1: TMemo
          Left = 8
          Top = 69
          Width = 658
          Height = 124
          Anchors = [akLeft, akTop, akRight]
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object ProgressBar1: TProgressBar
          Left = 0
          Top = -16
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          Visible = False
        end
        object ProgressBar2: TProgressBar
          Left = 8
          Top = 48
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
      end
      object GroupBox2: TGroupBox
        Left = 7
        Top = 41
        Width = 671
        Height = 76
        Caption = #38656#36716#25442#30340#25968#25454#25991#20214
        TabOrder = 2
        DesignSize = (
          671
          76)
        object Label7: TLabel
          Left = 8
          Top = 25
          Width = 36
          Height = 12
          Caption = 'Hum.db'
        end
        object Label8: TLabel
          Left = 8
          Top = 52
          Width = 36
          Height = 12
          Caption = 'Mir.db'
        end
        object SpeedButton2: TSpeedButton
          Left = 638
          Top = 22
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton2Click
        end
        object SpeedButton3: TSpeedButton
          Left = 638
          Top = 49
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton3Click
        end
        object Hum_db1014: TEdit
          Left = 48
          Top = 22
          Width = 591
          Height = 20
          TabOrder = 0
        end
        object Mir_db1014: TEdit
          Left = 48
          Top = 49
          Width = 591
          Height = 20
          TabOrder = 1
        end
      end
      object Button1: TButton
        Left = 456
        Top = 360
        Width = 75
        Height = 24
        Anchors = [akRight, akBottom]
        Caption = #24320#22987#36716#25442
        Default = True
        TabOrder = 3
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 541
        Top = 359
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986
        TabOrder = 4
        OnClick = Button6Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = '1107'#29256'->1231'#29256
      ImageIndex = 2
      DesignSize = (
        680
        385)
      object Label9: TLabel
        Left = 8
        Top = 16
        Width = 54
        Height = 12
        Caption = #20445#23384#30446#24405':'
      end
      object Label12: TLabel
        Left = 8
        Top = 120
        Width = 600
        Height = 24
        Caption = 
          #27880#24847#65306#21319#32423#20043#21069#19968#23450#35201#22791#20221'FDB'#24211#65292#21542#21017#36896#25104#20219#20309#21518#26524#33258#36127#12290' '#22914#26524#26377#36716#25442#19981#20102#25110#36716#25442#20043#21518#20154#29289#20986#38169#35831#21040#35770#22363#21453#26144#12290#13'Http://Www.' +
          'IGEM2.Com.Cn'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object SpeedButton6: TSpeedButton
        Left = 645
        Top = 12
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '...'
        OnClick = SpeedButton6Click
      end
      object Edit2: TEdit
        Left = 64
        Top = 13
        Width = 582
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object GroupBox3: TGroupBox
        Left = 7
        Top = 41
        Width = 671
        Height = 76
        Caption = #38656#36716#25442#30340#25968#25454#25991#20214
        TabOrder = 1
        DesignSize = (
          671
          76)
        object Label10: TLabel
          Left = 8
          Top = 25
          Width = 36
          Height = 12
          Caption = 'Hum.db'
        end
        object Label11: TLabel
          Left = 8
          Top = 52
          Width = 36
          Height = 12
          Caption = 'Mir.db'
        end
        object SpeedButton4: TSpeedButton
          Left = 640
          Top = 22
          Width = 21
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton4Click
        end
        object SpeedButton5: TSpeedButton
          Left = 638
          Top = 49
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton5Click
        end
        object Hum_db1107: TEdit
          Left = 48
          Top = 22
          Width = 591
          Height = 20
          TabOrder = 0
        end
        object Mir_db1107: TEdit
          Left = 48
          Top = 49
          Width = 591
          Height = 20
          TabOrder = 1
        end
      end
      object GroupBox4: TGroupBox
        Left = 3
        Top = 147
        Width = 677
        Height = 204
        Anchors = [akLeft, akRight, akBottom]
        Caption = #36827#24230#20449#24687
        TabOrder = 2
        DesignSize = (
          677
          204)
        object Label13: TLabel
          Left = 8
          Top = 16
          Width = 30
          Height = 12
          Caption = #20449#24687':'
        end
        object Label14: TLabel
          Left = 648
          Top = 32
          Width = 18
          Height = 12
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = '0/0'
          ParentBiDiMode = False
        end
        object Label15: TLabel
          Left = 624
          Top = 15
          Width = 30
          Height = 12
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = #22833#36133':'
          ParentBiDiMode = False
        end
        object Label16: TLabel
          Left = 8
          Top = 32
          Width = 18
          Height = 12
          Caption = '0/0'
        end
        object Memo2: TMemo
          Left = 8
          Top = 69
          Width = 658
          Height = 124
          Anchors = [akLeft, akTop, akRight]
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object ProgressBar3: TProgressBar
          Left = 0
          Top = -16
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          Visible = False
        end
        object ProgressBar4: TProgressBar
          Left = 8
          Top = 48
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
      end
      object Button3: TButton
        Left = 456
        Top = 360
        Width = 75
        Height = 24
        Anchors = [akRight, akBottom]
        Caption = #24320#22987#36716#25442
        Default = True
        TabOrder = 3
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 541
        Top = 359
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986
        TabOrder = 4
        OnClick = Button6Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = '1219'#29256'->1231'#29256
      ImageIndex = 3
      DesignSize = (
        680
        385)
      object Label25: TLabel
        Left = 8
        Top = 16
        Width = 54
        Height = 12
        Caption = #20445#23384#30446#24405':'
      end
      object SpeedButton10: TSpeedButton
        Left = 645
        Top = 12
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '...'
        OnClick = SpeedButton10Click
      end
      object Label28: TLabel
        Left = 8
        Top = 120
        Width = 600
        Height = 24
        Caption = 
          #27880#24847#65306#21319#32423#20043#21069#19968#23450#35201#22791#20221'FDB'#24211#65292#21542#21017#36896#25104#20219#20309#21518#26524#33258#36127#12290' '#22914#26524#26377#36716#25442#19981#20102#25110#36716#25442#20043#21518#20154#29289#20986#38169#35831#21040#35770#22363#21453#26144#12290#13'Http://Www.' +
          'IGEM2.Com.Cn'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Edit1219: TEdit
        Left = 64
        Top = 13
        Width = 582
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object GroupBox7: TGroupBox
        Left = 7
        Top = 41
        Width = 671
        Height = 76
        Caption = #38656#36716#25442#30340#25968#25454#25991#20214
        TabOrder = 1
        DesignSize = (
          671
          76)
        object Label26: TLabel
          Left = 8
          Top = 25
          Width = 36
          Height = 12
          Caption = 'Hum.db'
        end
        object Label27: TLabel
          Left = 8
          Top = 52
          Width = 36
          Height = 12
          Caption = 'Mir.db'
        end
        object SpeedButton11: TSpeedButton
          Left = 638
          Top = 22
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton11Click
        end
        object SpeedButton12: TSpeedButton
          Left = 638
          Top = 49
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton12Click
        end
        object Hum_db1219: TEdit
          Left = 48
          Top = 22
          Width = 591
          Height = 20
          TabOrder = 0
        end
        object Mir_db1219: TEdit
          Left = 48
          Top = 49
          Width = 591
          Height = 20
          TabOrder = 1
        end
      end
      object GroupBox8: TGroupBox
        Left = 3
        Top = 147
        Width = 677
        Height = 204
        Anchors = [akLeft, akRight, akBottom]
        Caption = #36827#24230#20449#24687
        TabOrder = 2
        DesignSize = (
          677
          204)
        object Label29: TLabel
          Left = 8
          Top = 16
          Width = 30
          Height = 12
          Caption = #20449#24687':'
        end
        object Label30: TLabel
          Left = 648
          Top = 32
          Width = 18
          Height = 12
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = '0/0'
          ParentBiDiMode = False
        end
        object Label31: TLabel
          Left = 624
          Top = 15
          Width = 30
          Height = 12
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = #22833#36133':'
          ParentBiDiMode = False
        end
        object Label32: TLabel
          Left = 8
          Top = 32
          Width = 18
          Height = 12
          Caption = '0/0'
        end
        object Memo4: TMemo
          Left = 8
          Top = 69
          Width = 658
          Height = 124
          Anchors = [akLeft, akTop, akRight]
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object ProgressBar7: TProgressBar
          Left = 0
          Top = -16
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          Visible = False
        end
        object ProgressBar8: TProgressBar
          Left = 8
          Top = 48
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
      end
      object Button7: TButton
        Left = 456
        Top = 360
        Width = 75
        Height = 24
        Anchors = [akRight, akBottom]
        Caption = #24320#22987#36716#25442
        Default = True
        TabOrder = 3
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 541
        Top = 359
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986
        TabOrder = 4
        OnClick = Button6Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #25968#25454#25991#20214'(*.DB)|*.DB'
    Left = 222
    Top = 315
  end
end

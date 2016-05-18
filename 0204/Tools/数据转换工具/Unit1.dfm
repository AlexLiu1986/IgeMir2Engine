object Form1: TForm1
  Left = 192
  Top = 107
  Width = 696
  Height = 480
  Caption = 'IGE'#31185#25216#25968#25454#26684#24335#21319#32423#24037#20855'('#21319#32423#21040'0514'#29256')  ('#26412#24037#20855#26356#26032#26085#26399#20026'0515)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 688
    Height = 446
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #24403#21069#29256#26412#21495#20026'0510'
      DesignSize = (
        680
        418)
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 52
        Height = 13
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
      object Label15: TLabel
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
        Height = 21
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
        object Label8: TLabel
          Left = 8
          Top = 25
          Width = 37
          Height = 13
          Caption = 'Hum.db'
        end
        object Label9: TLabel
          Left = 8
          Top = 52
          Width = 30
          Height = 13
          Caption = 'Mir.db'
        end
        object SpeedButton3: TSpeedButton
          Left = 638
          Top = 22
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton3Clik
        end
        object SpeedButton4: TSpeedButton
          Left = 638
          Top = 49
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton4Click
        end
        object Hum_db1: TEdit
          Left = 48
          Top = 22
          Width = 591
          Height = 21
          TabOrder = 0
        end
        object Mir_db1: TEdit
          Left = 48
          Top = 49
          Width = 591
          Height = 21
          TabOrder = 1
        end
      end
      object GroupBox2: TGroupBox
        Left = 3
        Top = 148
        Width = 677
        Height = 229
        Anchors = [akLeft, akRight, akBottom]
        Caption = #36827#24230#20449#24687
        TabOrder = 2
        DesignSize = (
          677
          229)
        object Label3: TLabel
          Left = 8
          Top = 16
          Width = 28
          Height = 13
          Caption = #20449#24687':'
        end
        object Label4: TLabel
          Left = 650
          Top = 32
          Width = 16
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = '0/0'
          ParentBiDiMode = False
        end
        object Label5: TLabel
          Left = 642
          Top = 15
          Width = 28
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = #22833#36133':'
          ParentBiDiMode = False
        end
        object Label6: TLabel
          Left = 8
          Top = 32
          Width = 16
          Height = 13
          Caption = '0/0'
        end
        object Memo1: TMemo
          Left = 8
          Top = 101
          Width = 658
          Height = 124
          Anchors = [akLeft, akTop, akRight]
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object ProgressBar1: TProgressBar
          Left = 8
          Top = 56
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
        object ProgressBar2: TProgressBar
          Left = 8
          Top = 80
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          Visible = False
        end
      end
      object Button3: TButton
        Left = 456
        Top = 384
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #24320#22987#36716#25442
        Default = True
        TabOrder = 3
        OnClick = Button3Click
      end
      object Button2: TButton
        Left = 549
        Top = 384
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986
        TabOrder = 4
        OnClick = Button2Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #24403#21069#29256#26412#21495#20026'0513'
      ImageIndex = 1
      DesignSize = (
        680
        418)
      object Label2: TLabel
        Left = 8
        Top = 16
        Width = 52
        Height = 13
        Caption = #20445#23384#30446#24405':'
      end
      object SpeedButton2: TSpeedButton
        Left = 645
        Top = 12
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '...'
        OnClick = SpeedButton2Click
      end
      object Label16: TLabel
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
      object Edit2: TEdit
        Left = 64
        Top = 13
        Width = 582
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object GroupBox1: TGroupBox
        Left = 7
        Top = 41
        Width = 671
        Height = 76
        Caption = #38656#36716#25442#30340#25968#25454#25991#20214
        TabOrder = 1
        DesignSize = (
          671
          76)
        object Label7: TLabel
          Left = 8
          Top = 25
          Width = 37
          Height = 13
          Caption = 'Hum.db'
        end
        object Label10: TLabel
          Left = 8
          Top = 52
          Width = 30
          Height = 13
          Caption = 'Mir.db'
        end
        object SpeedButton5: TSpeedButton
          Left = 638
          Top = 22
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton5Click
        end
        object SpeedButton6: TSpeedButton
          Left = 638
          Top = 49
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton6Click
        end
        object Hum_db2: TEdit
          Left = 48
          Top = 22
          Width = 591
          Height = 21
          TabOrder = 0
        end
        object Mir_db2: TEdit
          Left = 48
          Top = 49
          Width = 591
          Height = 21
          TabOrder = 1
        end
      end
      object GroupBox4: TGroupBox
        Left = 3
        Top = 148
        Width = 677
        Height = 229
        Anchors = [akLeft, akRight, akBottom]
        Caption = #36827#24230#20449#24687
        TabOrder = 2
        DesignSize = (
          677
          229)
        object Label11: TLabel
          Left = 8
          Top = 16
          Width = 28
          Height = 13
          Caption = #20449#24687':'
        end
        object Label12: TLabel
          Left = 650
          Top = 32
          Width = 16
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = '0/0'
          ParentBiDiMode = False
        end
        object Label13: TLabel
          Left = 642
          Top = 15
          Width = 28
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = #22833#36133':'
          ParentBiDiMode = False
        end
        object Label14: TLabel
          Left = 8
          Top = 32
          Width = 16
          Height = 13
          Caption = '0/0'
        end
        object Memo2: TMemo
          Left = 8
          Top = 101
          Width = 658
          Height = 124
          Anchors = [akLeft, akTop, akRight]
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object ProgressBar3: TProgressBar
          Left = 8
          Top = 56
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
        object ProgressBar4: TProgressBar
          Left = 8
          Top = 80
          Width = 657
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          Visible = False
        end
      end
      object Button1: TButton
        Left = 456
        Top = 384
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #24320#22987#36716#25442
        Default = True
        TabOrder = 3
        OnClick = Button1Click
      end
      object Button4: TButton
        Left = 549
        Top = 384
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986
        TabOrder = 4
        OnClick = Button2Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #25968#25454#25991#20214'(*.DB)|*.DB'
    Left = 422
    Top = 75
  end
end

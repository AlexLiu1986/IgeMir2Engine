object frmViewList2: TfrmViewList2
  Left = 191
  Top = 207
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #26597#30475#21015#34920#20449#24687
  ClientHeight = 449
  ClientWidth = 723
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 723
    Height = 449
    ActivePage = TabSheet1
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22871#35013#29289#21697
      object Label34: TLabel
        Left = 6
        Top = 371
        Width = 324
        Height = 48
        Caption = 
          #37325#35201#35828#26126#65306#22871#35013#29289#21697#19981#19968#23450#35201#36319#22871#35013#25968#37327#30456#31561#65292#20363#22914#22871#35013#25968#37327#13#35774#32622#20026'2'#65292#22871#35013#29289#21697#35774#32622#20026#25163#38255#65292#21482#35201#24102#21452#25163#38255#21363#35302#21457#12290#21482#25345#13#21333#20214#35013#22791#26080#27861#35302#21457 +
          #20351#29992#12290#20363#22914#65306#22307#25112#25163#38255#21152#22836#30420#19968#22871#65292#22307#25112#25163#13#38255#21152#39033#38142#21448#26159#19968#22871'('#22871#35013#29289#21697#26684#24335#65306'XXXX|XXXX|)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 0
        Width = 334
        Height = 361
        Caption = #22871#35013#21015#34920
        TabOrder = 0
        object ListView1: TListView
          Left = 6
          Top = 15
          Width = 323
          Height = 338
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #22871#35013#35828#26126
              Width = 120
            end
            item
              Caption = #25968#37327
              Width = 38
            end
            item
              Caption = #22871#35013#29289#21697
              Width = 120
            end
            item
              Caption = #23646#24615
              Width = 120
            end>
          GridLines = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListView1Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 346
        Top = 0
        Width = 363
        Height = 361
        Caption = #38468#21152#23646#24615#35774#32622
        TabOrder = 1
        object Label1: TLabel
          Left = 7
          Top = 22
          Width = 52
          Height = 13
          Caption = 'HP'#22686#21152'%:'
        end
        object Label2: TLabel
          Left = 124
          Top = 22
          Width = 53
          Height = 13
          Caption = 'MP'#22686#21152'%:'
        end
        object Label3: TLabel
          Left = 243
          Top = 22
          Width = 52
          Height = 13
          Caption = #32463#39564#20493#25968':'
        end
        object Label4: TLabel
          Left = 7
          Top = 48
          Width = 52
          Height = 13
          Caption = #25915#20987#19978#38480':'
        end
        object Label5: TLabel
          Left = 124
          Top = 48
          Width = 52
          Height = 13
          Caption = #25915#20987#19979#38480':'
        end
        object Label6: TLabel
          Left = 243
          Top = 48
          Width = 52
          Height = 13
          Caption = #25915#20987#20493#25968':'
        end
        object Label7: TLabel
          Left = 7
          Top = 73
          Width = 52
          Height = 13
          Caption = #39764#27861#19978#38480':'
        end
        object Label8: TLabel
          Left = 124
          Top = 73
          Width = 52
          Height = 13
          Caption = #39764#27861#19979#38480':'
        end
        object Label9: TLabel
          Left = 243
          Top = 73
          Width = 52
          Height = 13
          Caption = #39764#27861#20493#25968':'
        end
        object Label10: TLabel
          Left = 7
          Top = 99
          Width = 52
          Height = 13
          Caption = #36947#26415#19978#38480':'
        end
        object Label11: TLabel
          Left = 124
          Top = 99
          Width = 52
          Height = 13
          Caption = #36947#26415#19979#38480':'
        end
        object Label12: TLabel
          Left = 243
          Top = 99
          Width = 52
          Height = 13
          Caption = #36947#26415#20493#25968':'
        end
        object Label13: TLabel
          Left = 7
          Top = 124
          Width = 52
          Height = 13
          Caption = #38450#24481#19978#38480':'
        end
        object Label14: TLabel
          Left = 124
          Top = 124
          Width = 52
          Height = 13
          Caption = #38450#24481#19979#38480':'
        end
        object Label15: TLabel
          Left = 243
          Top = 124
          Width = 52
          Height = 13
          Caption = #38450#24481#20493#25968':'
        end
        object Label16: TLabel
          Left = 243
          Top = 150
          Width = 52
          Height = 13
          Caption = #39764#24481#20493#25968':'
        end
        object Label17: TLabel
          Left = 124
          Top = 150
          Width = 52
          Height = 13
          Caption = #39764#24481#19979#38480':'
        end
        object Label18: TLabel
          Left = 7
          Top = 150
          Width = 52
          Height = 13
          Caption = #39764#24481#19978#38480':'
        end
        object Label19: TLabel
          Left = 7
          Top = 177
          Width = 46
          Height = 13
          Caption = #20934' '#30830' '#24230':'
        end
        object Label20: TLabel
          Left = 124
          Top = 177
          Width = 46
          Height = 13
          Caption = #25935' '#25463' '#24230':'
        end
        object Label21: TLabel
          Left = 243
          Top = 177
          Width = 52
          Height = 13
          Caption = #39764#27861#36530#36991':'
        end
        object Label22: TLabel
          Left = 243
          Top = 203
          Width = 52
          Height = 13
          Caption = #27602#29289#36530#36991':'
        end
        object Label23: TLabel
          Left = 124
          Top = 203
          Width = 52
          Height = 13
          Caption = #39764#27861#24674#22797':'
        end
        object Label24: TLabel
          Left = 7
          Top = 203
          Width = 52
          Height = 13
          Caption = #20307#21147#24674#22797':'
        end
        object Label27: TLabel
          Left = 124
          Top = 230
          Width = 52
          Height = 13
          Caption = #29190#29575#26426#29575':'
        end
        object Label28: TLabel
          Left = 7
          Top = 229
          Width = 49
          Height = 13
          Caption = #21560'       '#34880':'
        end
        object Label29: TLabel
          Left = 243
          Top = 230
          Width = 52
          Height = 13
          Caption = #20013#27602#24674#22797':'
        end
        object Label30: TLabel
          Left = 4
          Top = 257
          Width = 52
          Height = 13
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label31: TLabel
          Left = 7
          Top = 310
          Width = 52
          Height = 13
          Caption = #22871#35013#25968#37327':'
        end
        object Label32: TLabel
          Left = 123
          Top = 310
          Width = 52
          Height = 13
          Caption = #22871#35013#35828#26126':'
        end
        object Label33: TLabel
          Left = 7
          Top = 335
          Width = 52
          Height = 13
          Caption = #22871#35013#29289#21697':'
        end
        object Label82: TLabel
          Left = 124
          Top = 256
          Width = 52
          Height = 13
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label83: TLabel
          Left = 243
          Top = 256
          Width = 52
          Height = 13
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object SpinEdtMaxHP: TSpinEdit
          Left = 59
          Top = 18
          Width = 61
          Height = 22
          Hint = 'HP'#22686#21152#27604#20363','#21363#35282#33394'HP'#20540#20026'100'#26102','#35774#32622#22686'50%,'#21363#22871#35013#22686#21152'50'#28857'HP'
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 0
        end
        object SpinEdtMaxMP: TSpinEdit
          Left = 176
          Top = 18
          Width = 61
          Height = 22
          Hint = 'MP'#22686#21152#27604#20363','#21363#35282#33394'MP'#20540#20026'100'#26102','#35774#32622#22686'50%,'#21363#22871#35013#22686#21152'50'#28857'MP'
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 0
        end
        object SpinEdit2: TSpinEdit
          Left = 297
          Top = 18
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'1'#21017#34920#31034'1'#20493'  ('#25152#24471#21040#30340#32463#39564#20540'='#24403#21069#32463#39564#20540'*'#32463#39564#20493#25968'),'#22914#26524#35774#32622#20026'1'#20493','#21017#26159#21407#26469#30340#32463#39564#25968#12290
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 1
        end
        object SpinEdit3: TSpinEdit
          Left = 59
          Top = 44
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object SpinEdit4: TSpinEdit
          Left = 176
          Top = 44
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 4
          Value = 0
        end
        object SpinEdit5: TSpinEdit
          Left = 297
          Top = 44
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'1'#21017#34920#31034'1'#20493','#19978#38480#21644#19979#38480#21516#26102#32763#20493' ('#25915#20987#20540'='#25915#20987#20540'*'#20493#25968'),'#22914#26524#35774#32622#20026'1'#20493','#21017#26159#21407#26469#30340#25915#20987#20540#12290
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 1
        end
        object SpinEdit6: TSpinEdit
          Left = 59
          Top = 69
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
        object SpinEdit7: TSpinEdit
          Left = 176
          Top = 69
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 7
          Value = 0
        end
        object SpinEdit8: TSpinEdit
          Left = 297
          Top = 69
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'1'#21017#34920#31034'1'#20493','#19978#38480#21644#19979#38480#21516#26102#32763#20493' ('#39764#27861#20540'='#39764#27861#20540'*'#20493#25968'),'#22914#26524#35774#32622#20026'1'#20493','#21017#26159#21407#26469#30340#39764#27861#20540#12290
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          Value = 1
        end
        object SpinEdit9: TSpinEdit
          Left = 59
          Top = 95
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
        object SpinEdit10: TSpinEdit
          Left = 176
          Top = 95
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 10
          Value = 0
        end
        object SpinEdit11: TSpinEdit
          Left = 298
          Top = 95
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'1'#21017#34920#31034'1'#20493','#19978#38480#21644#19979#38480#21516#26102#32763#20493' ('#36947#26415#20540'='#36947#26415#20540'*'#20493#25968'),'#22914#26524#35774#32622#20026'1'#20493','#21017#26159#21407#26469#30340#36947#26415#20540#12290
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          Value = 1
        end
        object SpinEdit12: TSpinEdit
          Left = 59
          Top = 120
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 12
          Value = 0
        end
        object SpinEdit13: TSpinEdit
          Left = 176
          Top = 120
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 13
          Value = 0
        end
        object SpinEdit14: TSpinEdit
          Left = 298
          Top = 120
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'1'#21017#34920#31034'1'#20493','#19978#38480#21644#19979#38480#21516#26102#32763#20493' ('#38450#24481#20540'='#38450#24481#20540'*'#20493#25968'),'#22914#26524#35774#32622#20026'1'#20493','#21017#26159#21407#26469#30340#38450#24481#20540#12290
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          Value = 1
        end
        object SpinEdit15: TSpinEdit
          Left = 298
          Top = 146
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'1'#21017#34920#31034'1'#20493','#19978#38480#21644#19979#38480#21516#26102#32763#20493' ('#39764#24481#20540'='#39764#24481#20540'*'#20493#25968'),'#22914#26524#35774#32622#20026'1'#20493','#21017#26159#21407#26469#30340#39764#24481#20540#12290
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          Value = 1
        end
        object SpinEdit16: TSpinEdit
          Left = 176
          Top = 146
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 16
          Value = 0
        end
        object SpinEdit17: TSpinEdit
          Left = 59
          Top = 146
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 17
          Value = 0
        end
        object SpinEdit18: TSpinEdit
          Left = 59
          Top = 173
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 18
          Value = 0
        end
        object SpinEdit19: TSpinEdit
          Left = 176
          Top = 173
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 19
          Value = 0
        end
        object SpinEdit20: TSpinEdit
          Left = 298
          Top = 173
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'1'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 20
          Value = 0
        end
        object SpinEdit21: TSpinEdit
          Left = 298
          Top = 199
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'1'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 21
          Value = 0
        end
        object SpinEdit22: TSpinEdit
          Left = 176
          Top = 199
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'1'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 22
          Value = 0
        end
        object SpinEdit23: TSpinEdit
          Left = 59
          Top = 199
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'1'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 23
          Value = 0
        end
        object SpinEdit26: TSpinEdit
          Left = 176
          Top = 226
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 24
          Value = 0
        end
        object SpinEdit24: TSpinEdit
          Left = 59
          Top = 225
          Width = 61
          Height = 22
          Hint = #25171#24618#25481#34880'200,'#35774#32622#20540#20026'5,200/100*5=10,'#21363#21152#34880'10'#28857
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 25
          Value = 0
        end
        object SpinEdit28: TSpinEdit
          Left = 298
          Top = 226
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'1'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 26
          Value = 0
        end
        object SpinEdit25: TSpinEdit
          Left = 59
          Top = 253
          Width = 61
          Height = 22
          Enabled = False
          MaxValue = 65535
          MinValue = 0
          TabOrder = 27
          Value = 0
        end
        object SpinEdit30: TSpinEdit
          Left = 59
          Top = 306
          Width = 61
          Height = 22
          MaxValue = 12
          MinValue = 0
          TabOrder = 28
          Value = 0
        end
        object Edit1: TEdit
          Left = 176
          Top = 307
          Width = 183
          Height = 21
          TabOrder = 29
        end
        object Edit2: TEdit
          Left = 58
          Top = 333
          Width = 300
          Height = 21
          Hint = #29289#21697#26684#24335#65306'XXXX|XXXX| '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 30
        end
        object SpinEdit27: TSpinEdit
          Left = 176
          Top = 252
          Width = 61
          Height = 22
          Enabled = False
          MaxValue = 65535
          MinValue = 0
          TabOrder = 31
          Value = 0
        end
        object SpinEdit29: TSpinEdit
          Left = 298
          Top = 252
          Width = 61
          Height = 22
          Enabled = False
          MaxValue = 65535
          MinValue = 0
          TabOrder = 32
          Value = 0
        end
        object CheckBoxTeleport: TCheckBox
          Left = 21
          Top = 282
          Width = 70
          Height = 17
          Caption = #20256#36865
          TabOrder = 33
        end
        object CheckBoxParalysis: TCheckBox
          Left = 93
          Top = 282
          Width = 65
          Height = 17
          Caption = #40635#30201
          TabOrder = 34
        end
        object CheckBoxRevival: TCheckBox
          Left = 157
          Top = 282
          Width = 65
          Height = 17
          Caption = #22797#27963
          TabOrder = 35
        end
        object CheckBoxMagicShield: TCheckBox
          Left = 221
          Top = 282
          Width = 58
          Height = 17
          Caption = #25252#36523
          TabOrder = 36
        end
        object CheckBoxUnParalysis: TCheckBox
          Left = 282
          Top = 282
          Width = 63
          Height = 17
          Caption = #38450#40635#30201
          TabOrder = 37
        end
      end
      object Button1: TButton
        Left = 350
        Top = 365
        Width = 63
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 422
        Top = 365
        Width = 63
        Height = 25
        Caption = #21024#38500'(&D)'
        Enabled = False
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 495
        Top = 365
        Width = 63
        Height = 25
        Caption = #20462#25913'(&E)'
        Enabled = False
        TabOrder = 4
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 566
        Top = 365
        Width = 63
        Height = 25
        Caption = #20445#23384'(&S)'
        Enabled = False
        TabOrder = 5
        OnClick = Button4Click
      end
      object Button7: TButton
        Left = 638
        Top = 365
        Width = 65
        Height = 25
        Hint = #37325#26032#21152#36733#26032#30340#22871#35013#37197#32622','#21363#22312'M2'#37324#29983#25928','#22914#19981#37325#26032#21152#36733','#21017#28216#25103#37324#19981#33021#20351#29992#26032#30340#37197#32622
        Caption = #37325#26032#21152#36733
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = Button7Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #21464#37327#31649#29702
      ImageIndex = 1
      object Label35: TLabel
        Left = 8
        Top = 2
        Width = 72
        Height = 13
        Caption = #20840#23616#25972#24418#21464#37327
      end
      object Label36: TLabel
        Left = 349
        Top = 4
        Width = 72
        Height = 13
        Caption = #20840#23616#23383#31526#21464#37327
      end
      object ListView2: TListView
        Left = 0
        Top = 22
        Width = 329
        Height = 395
        Hint = #21452#20987#20462#25913#21464#37327#20540
        Columns = <
          item
            Caption = #24207#21495
          end
          item
            Caption = #25968#20540#21464#37327#20540
            Width = 230
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = ListView2DblClick
      end
      object ListView3: TListView
        Left = 342
        Top = 22
        Width = 355
        Height = 395
        Hint = #21452#20987#20462#25913#21464#37327#20540
        Columns = <
          item
            Caption = #24207#21495
          end
          item
            Caption = #23383#31526#21464#37327#20540
            Width = 270
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        ViewStyle = vsReport
        OnDblClick = ListView3DblClick
      end
      object Button5: TButton
        Left = 248
        Top = 4
        Width = 76
        Height = 19
        Caption = #20840#37096#28165#38500
        TabOrder = 2
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 619
        Top = 4
        Width = 76
        Height = 19
        Caption = #20840#37096#28165#38500
        TabOrder = 3
        OnClick = Button6Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = #31929#32451#37197#32622
      ImageIndex = 2
      OnShow = TabSheet3Show
      object Label37: TLabel
        Left = 0
        Top = 408
        Width = 432
        Height = 12
        Caption = #35843#25972#30340#21442#25968#31435#21363#29983#25928#65292#22312#32447#26102#35831#30830#35748#27492#21442#25968#30340#20316#29992#20877#35843#25972#65292#20081#35843#25972#23558#23548#33268#28216#25103#28151#20081
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label38: TLabel
        Left = 0
        Top = 0
        Width = 72
        Height = 13
        Caption = #31929#32451#26448#26009#21015#34920
      end
      object Label39: TLabel
        Left = 192
        Top = 0
        Width = 108
        Height = 13
        Caption = #31929#32451#25104#21151#21518#24471#21040#29289#21697
      end
      object Label78: TLabel
        Left = 360
        Top = 0
        Width = 6
        Height = 11
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RefineItemListBox: TListBox
        Left = -1
        Top = 13
        Width = 189
        Height = 288
        Hint = #21452#20987#36873#25321#23545#24212#30340#26448#26009#36827#34892#25805#20316
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnDblClick = RefineItemListBoxDblClick
      end
      object ListView4: TListView
        Left = 189
        Top = 13
        Width = 308
        Height = 392
        Hint = #21452#20987#36873#25321#29289#21697#25968#25454'('#20462#25913#29289#21697#21517#31216#26080#25928')'
        Columns = <
          item
            Caption = #29289#21697
            Width = 65
          end
          item
            Caption = #25104#21151#29575
            Width = 48
          end
          item
            Caption = #36824#21407#29575
            Width = 48
          end
          item
            Caption = #26159#21542#28040#22833
            Width = 60
          end
          item
            Caption = #26497#21697#29575
            Width = 48
          end
          item
            Caption = #23646#24615#35774#32622
            Width = 200
          end>
        GridLines = True
        RowSelect = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        ViewStyle = vsReport
        OnClick = ListView4Click
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 304
        Width = 188
        Height = 101
        Caption = #31929#32451#26448#26009#35774#32622
        TabOrder = 2
        object Label40: TLabel
          Left = 4
          Top = 23
          Width = 40
          Height = 13
          Caption = #26448#26009#19968':'
        end
        object Label41: TLabel
          Left = 4
          Top = 46
          Width = 40
          Height = 13
          Caption = #26448#26009#20108':'
        end
        object Label42: TLabel
          Left = 4
          Top = 70
          Width = 40
          Height = 13
          Caption = #26448#26009#19977':'
        end
        object Edit3: TEdit
          Left = 44
          Top = 19
          Width = 75
          Height = 21
          Hint = #19977#20214#26448#26009#20013#38656#35201#26377#19968#20214#26159#28779#20113#30707#25110#28779#20113#26230#30707
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object Edit4: TEdit
          Left = 44
          Top = 43
          Width = 75
          Height = 21
          Hint = #19977#20214#26448#26009#20013#38656#35201#26377#19968#20214#26159#28779#20113#30707#25110#28779#20113#26230#30707
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object Edit5: TEdit
          Left = 44
          Top = 67
          Width = 75
          Height = 21
          Hint = #19977#20214#26448#26009#20013#38656#35201#26377#19968#20214#26159#28779#20113#30707#25110#28779#20113#26230#30707
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object Button8: TButton
          Left = 121
          Top = 9
          Width = 62
          Height = 22
          Caption = #22686#21152
          TabOrder = 3
          OnClick = Button8Click
        end
        object Button9: TButton
          Left = 121
          Top = 31
          Width = 62
          Height = 22
          Caption = #20462#25913
          Enabled = False
          TabOrder = 4
          OnClick = Button9Click
        end
        object Button10: TButton
          Left = 121
          Top = 53
          Width = 62
          Height = 22
          Caption = #21024#38500
          Enabled = False
          TabOrder = 5
          OnClick = Button10Click
        end
        object Button11: TButton
          Left = 121
          Top = 75
          Width = 62
          Height = 22
          Caption = #20445#23384
          Enabled = False
          TabOrder = 6
          OnClick = Button11Click
        end
      end
      object GroupBox4: TGroupBox
        Left = 501
        Top = 8
        Width = 214
        Height = 409
        Caption = #29289#21697#35774#32622
        TabOrder = 3
        object Label43: TLabel
          Left = 5
          Top = 17
          Width = 52
          Height = 13
          Caption = #29289#21697#21517#31216':'
        end
        object Label44: TLabel
          Left = 6
          Top = 40
          Width = 40
          Height = 13
          Caption = #25104#21151#29575':'
        end
        object Label45: TLabel
          Left = 100
          Top = 40
          Width = 40
          Height = 13
          Hint = #31929#32451#22833#36133#21518','#36824#21407#29289#21697#30340#26426#29575','#21363#21319#32423#29289#21697#23646#24615#19981#21464#31561
          Caption = #36824#21407#29575':'
          ParentShowHint = False
          ShowHint = True
        end
        object Label46: TLabel
          Left = 6
          Top = 64
          Width = 40
          Height = 13
          Caption = #28779#20113#30707':'
        end
        object Label47: TLabel
          Left = 100
          Top = 64
          Width = 40
          Height = 13
          Hint = #31929#32451#22833#36133#21518','#36824#21407#29289#21697#30340#26426#29575','#21363#21319#32423#29289#21697#23646#24615#19981#21464#31561
          Caption = #26497#21697#29575':'
          ParentShowHint = False
          ShowHint = True
        end
        object Button12: TButton
          Left = 149
          Top = 307
          Width = 62
          Height = 22
          Caption = #22686#21152
          TabOrder = 0
          OnClick = Button12Click
        end
        object Button13: TButton
          Left = 149
          Top = 331
          Width = 62
          Height = 22
          Caption = #20462#25913
          TabOrder = 1
          OnClick = Button13Click
        end
        object Button14: TButton
          Left = 149
          Top = 355
          Width = 62
          Height = 22
          Caption = #21024#38500
          TabOrder = 2
          OnClick = Button14Click
        end
        object Button15: TButton
          Left = 150
          Top = 379
          Width = 62
          Height = 22
          Caption = #20445#23384
          TabOrder = 3
          OnClick = Button15Click
        end
        object Edit6: TEdit
          Left = 58
          Top = 13
          Width = 127
          Height = 21
          Hint = #20462#25913#26102#29289#21697#21517#23383#20462#25913#26080#25928';'#22686#21152#26102','#29289#21697#21517#31216#37325#22797#23558#26080#25928'!'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object SpinEdit1: TSpinEdit
          Left = 49
          Top = 35
          Width = 44
          Height = 22
          Hint = #31929#32451#25104#21151#30340#26426#29575','#20540#20026'100,'#21363#30334#20998#30334#31929#32451#25104#21151
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 0
        end
        object SpinEdit31: TSpinEdit
          Left = 144
          Top = 35
          Width = 44
          Height = 22
          Hint = #31929#32451#22833#36133#36824#21407#29289#21697#30340#26426#29575','#20540#20026'100,'#21363#31929#32451#22833#36133#21518','#30334#20998#30334#36864#22238#21407#29289#21697
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Value = 0
        end
        object SpinEdit32: TSpinEdit
          Left = 49
          Top = 59
          Width = 44
          Height = 22
          Hint = #28779#20113#30707#26159#21542#28040#22833',0='#20943#23569#25345#20037' ,1='#28040#22833
          MaxValue = 1
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Value = 0
        end
        object SpinEdit33: TSpinEdit
          Left = 144
          Top = 59
          Width = 44
          Height = 22
          Hint = #31929#32451#25104#21151#21518','#21462#24471#26426#21697#23646#24615#30340#26426#29575','#27880':'#27492#26497#21697#23646#24615#38750#35774#32622#30340#23646#24615
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          Value = 0
        end
        object GroupBox5: TGroupBox
          Left = 4
          Top = 82
          Width = 143
          Height = 324
          TabOrder = 9
          object Label48: TLabel
            Left = 6
            Top = 18
            Width = 40
            Height = 13
            Hint = 'AC2'
            Caption = #23646#24615#19968':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label49: TLabel
            Left = 6
            Top = 38
            Width = 40
            Height = 13
            Hint = 'MAC2'
            Caption = #23646#24615#20108':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label50: TLabel
            Left = 6
            Top = 61
            Width = 40
            Height = 13
            Hint = 'DC2'
            Caption = #23646#24615#19977':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label51: TLabel
            Left = 7
            Top = 85
            Width = 40
            Height = 13
            Hint = 'MC2'
            Caption = #23646#24615#22235':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label52: TLabel
            Left = 7
            Top = 106
            Width = 40
            Height = 13
            Hint = 'SC2'
            Caption = #23646#24615#20116':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label53: TLabel
            Left = 7
            Top = 126
            Width = 40
            Height = 13
            Hint = #20329#24102#38656#27714
            Caption = #23646#24615#20845':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label54: TLabel
            Left = 7
            Top = 149
            Width = 40
            Height = 13
            Hint = #20329#24102#32423#21035' '
            Caption = #23646#24615#19971':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label55: TLabel
            Left = 7
            Top = 172
            Width = 40
            Height = 13
            Hint = 'Reserved'
            Caption = #23646#24615#20843':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label56: TLabel
            Left = 2
            Top = 238
            Width = 48
            Height = 13
            Caption = #23646#24615#21313#19968
            Enabled = False
          end
          object Label57: TLabel
            Left = 1
            Top = 259
            Width = 48
            Height = 13
            Caption = #23646#24615#21313#20108
          end
          object Label58: TLabel
            Left = 1
            Top = 281
            Width = 48
            Height = 13
            Caption = #23646#24615#21313#19977
          end
          object Label59: TLabel
            Left = 2
            Top = 304
            Width = 48
            Height = 13
            Hint = #25345#20037
            Caption = #23646#24615#21313#22235
            ParentShowHint = False
            ShowHint = True
          end
          object Label60: TLabel
            Left = 8
            Top = 216
            Width = 40
            Height = 13
            Caption = #23646#24615#21313':'
          end
          object Label61: TLabel
            Left = 7
            Top = 193
            Width = 40
            Height = 13
            Caption = #23646#24615#20061':'
          end
          object Label62: TLabel
            Left = 87
            Top = 18
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label63: TLabel
            Left = 87
            Top = 38
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label64: TLabel
            Left = 86
            Top = 61
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label65: TLabel
            Left = 87
            Top = 85
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label66: TLabel
            Left = 87
            Top = 106
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label67: TLabel
            Left = 87
            Top = 126
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label68: TLabel
            Left = 87
            Top = 149
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label69: TLabel
            Left = 87
            Top = 172
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label70: TLabel
            Left = 87
            Top = 193
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label71: TLabel
            Left = 87
            Top = 216
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label72: TLabel
            Left = 87
            Top = 238
            Width = 12
            Height = 13
            Caption = #19968
            Enabled = False
          end
          object Label73: TLabel
            Left = 87
            Top = 259
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label74: TLabel
            Left = 87
            Top = 281
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label75: TLabel
            Left = 88
            Top = 303
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label76: TLabel
            Left = 45
            Top = -1
            Width = 48
            Height = 13
            Caption = #26368#39640#28857#25968
          end
          object Label77: TLabel
            Left = 102
            Top = -1
            Width = 24
            Height = 13
            Caption = #38590#24230
          end
          object SpinEdit34: TSpinEdit
            Left = 49
            Top = 13
            Width = 40
            Height = 22
            Hint = 
              #27494#22120'(5,6) '#20026#25915#20987#13#39033#38142'(19) '#20026#39764#27861#36530#36991#13#39033#38142'(20)\ '#25163#38255'(24) '#20026#20934#30830#13#39033#38142'(21) '#20026#20307#21147#24674#22797#13#25106#25351'(23) ' +
              #20026#27602#29289#36530#36991#13#20854#20182'   '#20026#38450#24481
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Value = 0
          end
          object SpinEdit36: TSpinEdit
            Left = 49
            Top = 35
            Width = 40
            Height = 22
            Hint = 
              #39033#38142'(19)  '#20026#24184#36816#13#39033#38142'(20)\'#25163#38255'(24) '#20026#25935#25463#13#39033#38142'(21)   '#20026#39764#27861#24674#22797#13#25106#25351'(23)   '#20026#20013#27602#24674#22797#13#27494#22120'(5' +
              ',6)  '#20026#39764#27861#13#20854#20182' '#20026#39764#24481
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Value = 0
          end
          object SpinEdit37: TSpinEdit
            Left = 49
            Top = 57
            Width = 40
            Height = 22
            Hint = #27494#22120'(5,6)  '#20026#36947#26415#13#20854#20182'         '#20026#25915#20987
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Value = 0
          end
          object SpinEdit38: TSpinEdit
            Left = 49
            Top = 79
            Width = 40
            Height = 22
            Hint = #27494#22120'(5,6)  '#20026#24184#36816#13#20854#20182'         '#20026#39764#27861
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Value = 0
          end
          object SpinEdit39: TSpinEdit
            Left = 49
            Top = 167
            Width = 40
            Height = 22
            Hint = #27494#22120'  '#20026#24378#24230#13#25106#25351'\'#25163#38255'\'#39033#38142' '#20026#20329#24102#32423#21035#13#20854#20182#26080#25928
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Value = 0
          end
          object SpinEdit40: TSpinEdit
            Left = 49
            Top = 101
            Width = 40
            Height = 22
            Hint = #27494#22120'(5,6)  '#20026#35781#21650#13#20854#20182'         '#20026#36947#26415
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            Value = 0
          end
          object SpinEdit41: TSpinEdit
            Left = 49
            Top = 123
            Width = 40
            Height = 22
            Hint = #27494#22120'(5,6)  '#20026#20934#30830#13#22836#30420'\'#26007#31520'  '#20026#20329#24102#38656#27714#13#20854#20182'    '#26080#25928
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            Value = 0
          end
          object SpinEdit42: TSpinEdit
            Left = 49
            Top = 145
            Width = 40
            Height = 22
            Hint = 
              #27494#22120'(5,6)         '#20026#25915#20987#36895#24230' '#13#25106#25351'\'#25163#38255'\'#39033#38142'  '#20026#20329#24102#38656#27714#13#22836#30420'\'#26007#31520'         '#20026#20329#24102#32423#21035#13#20854#20182'  '#26080 +
              #25928
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            Value = 0
          end
          object SpinEdit43: TSpinEdit
            Left = 49
            Top = 189
            Width = 40
            Height = 22
            Hint = #22836#30420','#26007#31520','#25106#25351','#25163#22871','#25163#38255'  '#20026#31070#31192#23646#24615#13#20854#20182#26080#25928' '
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            Value = 0
          end
          object SpinEdit44: TSpinEdit
            Left = 49
            Top = 211
            Width = 40
            Height = 22
            Hint = #27494#22120'  '#20026#38656#24320#23553#13#20854#20182#26080#25928
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 9
            Value = 0
          end
          object SpinEdit45: TSpinEdit
            Left = 49
            Top = 233
            Width = 40
            Height = 22
            Hint = #20445#30041#23646#24615
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 10
            Value = 0
          end
          object SpinEdit46: TSpinEdit
            Left = 49
            Top = 255
            Width = 40
            Height = 22
            Hint = #27494#22120#26080#25928#13#20854#23427#20540#20026'1'#26102','#29289#21697#21457#20809
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 11
            Value = 0
          end
          object SpinEdit47: TSpinEdit
            Left = 49
            Top = 277
            Width = 40
            Height = 22
            Hint = #20540#20026'1'#26102','#20026#33258#23450#20041#29289#21697
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 12
            Value = 0
          end
          object SpinEdit48: TSpinEdit
            Left = 49
            Top = 299
            Width = 40
            Height = 22
            Hint = #25345#20037#20540
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 13
            Value = 0
          end
          object SpinEdit35: TSpinEdit
            Left = 96
            Top = 13
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 14
            Value = 0
          end
          object SpinEdit49: TSpinEdit
            Left = 96
            Top = 35
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 15
            Value = 0
          end
          object SpinEdit50: TSpinEdit
            Left = 96
            Top = 57
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 16
            Value = 0
          end
          object SpinEdit51: TSpinEdit
            Left = 96
            Top = 79
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 17
            Value = 0
          end
          object SpinEdit52: TSpinEdit
            Left = 96
            Top = 101
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 18
            Value = 0
          end
          object SpinEdit53: TSpinEdit
            Left = 96
            Top = 123
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 19
            Value = 0
          end
          object SpinEdit54: TSpinEdit
            Left = 96
            Top = 145
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 20
            Value = 0
          end
          object SpinEdit55: TSpinEdit
            Left = 96
            Top = 167
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 21
            Value = 0
          end
          object SpinEdit56: TSpinEdit
            Left = 96
            Top = 189
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 22
            Value = 0
          end
          object SpinEdit57: TSpinEdit
            Left = 96
            Top = 211
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 23
            Value = 0
          end
          object SpinEdit58: TSpinEdit
            Left = 96
            Top = 233
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 24
            Value = 0
          end
          object SpinEdit59: TSpinEdit
            Left = 96
            Top = 255
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 25
            Value = 0
          end
          object SpinEdit60: TSpinEdit
            Left = 96
            Top = 277
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 26
            Value = 0
          end
          object SpinEdit61: TSpinEdit
            Left = 96
            Top = 299
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 27
            Value = 0
          end
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #33258#23450#20041#21629#20196
      ImageIndex = 4
      OnShow = TabSheet5Show
      object Label79: TLabel
        Left = 246
        Top = 214
        Width = 60
        Height = 13
        Caption = #21629#20196#21517#31216#65306
      end
      object Label81: TLabel
        Left = 246
        Top = 238
        Width = 60
        Height = 13
        Caption = #21629#20196#32534#21495#65306
      end
      object GroupBox6: TGroupBox
        Left = 11
        Top = 8
        Width = 209
        Height = 407
        Caption = #33258#23450#20041#21629#20196#21015#34920
        TabOrder = 0
        object ListBoxUserCommand: TListBox
          Left = 8
          Top = 16
          Width = 193
          Height = 381
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBoxUserCommandClick
        end
      end
      object SpinEditCommandIdx: TSpinEdit
        Left = 310
        Top = 234
        Width = 161
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object EditCommandName: TEdit
        Left = 310
        Top = 210
        Width = 161
        Height = 21
        TabOrder = 2
      end
      object ButtonUserCommandAdd: TButton
        Left = 318
        Top = 262
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonUserCommandAddClick
      end
      object ButtonUserCommandDel: TButton
        Left = 398
        Top = 262
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonUserCommandDelClick
      end
      object ButtonUserCommandChg: TButton
        Left = 318
        Top = 294
        Width = 75
        Height = 25
        Caption = #20462#25913'(&C)'
        TabOrder = 5
        OnClick = ButtonUserCommandChgClick
      end
      object ButtonLoadUserCommandList: TButton
        Left = 318
        Top = 326
        Width = 153
        Height = 25
        Caption = #37325#26032#21152#36733#33258#23450#20041#21629#20196#21015#34920
        TabOrder = 6
        OnClick = ButtonLoadUserCommandListClick
      end
      object ButtonUserCommandSave: TButton
        Left = 398
        Top = 294
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 7
        OnClick = ButtonUserCommandSaveClick
      end
    end
    object TabSheet6: TTabSheet
      Caption = #31105#27490#29289#21697#35774#32622
      ImageIndex = 5
      OnShow = TabSheet6Show
      object Label92: TLabel
        Left = 8
        Top = 399
        Width = 432
        Height = 12
        Caption = #35843#25972#30340#21442#25968#31435#21363#29983#25928#65292#22312#32447#26102#35831#30830#35748#27492#21442#25968#30340#20316#29992#20877#35843#25972#65292#20081#35843#25972#23558#23548#33268#28216#25103#28151#20081
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 8
        Width = 193
        Height = 386
        Caption = #31105#27490#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxDisallow: TListBox
          Left = 8
          Top = 16
          Width = 177
          Height = 362
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBoxDisallowClick
        end
      end
      object GroupBox21: TGroupBox
        Left = 394
        Top = 8
        Width = 193
        Height = 386
        Caption = #29289#21697#21015#34920'(CTRL+F'#26597#25214')'
        TabOrder = 1
        object ListBoxitemList: TListBox
          Left = 8
          Top = 16
          Width = 177
          Height = 363
          Hint = 'Ctrl+F '#26597#25214
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ListBoxitemListClick
          OnKeyDown = ListBoxitemListKeyDown
        end
      end
      object GroupBox8: TGroupBox
        Left = 208
        Top = 8
        Width = 179
        Height = 386
        Caption = #35268#21017#35774#32622
        TabOrder = 2
        object Label89: TLabel
          Left = 8
          Top = 24
          Width = 52
          Height = 13
          Caption = #29289#21697#21517#31216':'
        end
        object EditItemName: TEdit
          Left = 64
          Top = 20
          Width = 106
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object GroupBox9: TGroupBox
          Left = 7
          Top = 50
          Width = 165
          Height = 206
          Caption = #32534#36753#29289#21697#23646#24615
          TabOrder = 1
          object BtnDisallowSelAll: TButton
            Left = 5
            Top = 174
            Width = 75
            Height = 23
            Caption = #20840#37096#36873#20013
            TabOrder = 0
            OnClick = BtnDisallowSelAllClick
          end
          object BtnDisallowCancelAll: TButton
            Left = 85
            Top = 174
            Width = 75
            Height = 23
            Caption = #20840#37096#21462#28040
            TabOrder = 1
            OnClick = BtnDisallowCancelAllClick
          end
          object CheckBoxDisallowDrop: TCheckBox
            Left = 9
            Top = 18
            Width = 65
            Height = 17
            Caption = #31105#27490#20002#24323
            TabOrder = 2
          end
          object CheckBoxDisallowDeal: TCheckBox
            Left = 88
            Top = 18
            Width = 65
            Height = 17
            Caption = #31105#27490#20132#26131
            TabOrder = 3
          end
          object CheckBoxDisallowStorage: TCheckBox
            Left = 9
            Top = 33
            Width = 65
            Height = 17
            Caption = #31105#27490#23384#20179
            TabOrder = 4
          end
          object CheckBoxDisallowRepair: TCheckBox
            Left = 88
            Top = 33
            Width = 65
            Height = 17
            Caption = #31105#27490#20462#29702
            TabOrder = 5
          end
          object CheckBoxDisallowDropHint: TCheckBox
            Left = 9
            Top = 48
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#29289#21697#25481#33853#22312#22320#19978#26102#21521#20840#26381#21457#24067#22320#22270#19982#22352#26631#25552#31034#12290
            Caption = #25481#33853#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
          end
          object CheckBoxDisallowOpenBoxsHint: TCheckBox
            Left = 88
            Top = 48
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#29289#21697#25171#24320#23453#31665#33719#24471#26102#21521#20840#26381#21457#36865#25552#31034#12290
            Caption = #23453#31665#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
          end
          object CheckBoxDisallowNoDropItem: TCheckBox
            Left = 9
            Top = 63
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#35813#29289#21697#27515#20129#19981#25481#33853#12290
            Caption = #27704#19981#29190#20986
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            OnClick = CheckBoxDisallowNoDropItemClick
          end
          object CheckBoxDisallowButchHint: TCheckBox
            Left = 88
            Top = 63
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#20174#24618#29289#25110#20154#22411#24618#36523#19978#25366#21040#35813#29289#21697#26102#36827#34892#20840#26381#25552#31034#12290
            Caption = #25366#21462#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 9
          end
          object CheckBoxDisallowHeroUse: TCheckBox
            Left = 9
            Top = 78
            Width = 68
            Height = 17
            Hint = #36873#20013#35813#39033#65292#33521#38596#19981#21487#20197#31359#25140#35813#29289#21697#12290#13#10#20027#20307#19981#33021#25226#29289#21697#25918#21040#33521#38596#21253#35065#20013#12290
            Caption = #31105#27490#33521#38596
            ParentShowHint = False
            ShowHint = True
            TabOrder = 10
          end
          object CheckBoxDisallowPickUpItem: TCheckBox
            Left = 88
            Top = 78
            Width = 65
            Height = 17
            Caption = #31105#27490#25441#36215
            TabOrder = 11
          end
          object CheckBoxDieDropItems: TCheckBox
            Left = 9
            Top = 93
            Width = 65
            Height = 17
            Caption = #27515#20129#24517#26292
            TabOrder = 12
            OnClick = CheckBoxDieDropItemsClick
          end
          object CheckBox4: TCheckBox
            Left = 88
            Top = 93
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 13
          end
          object CheckBox5: TCheckBox
            Left = 9
            Top = 108
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 14
          end
          object CheckBox6: TCheckBox
            Left = 88
            Top = 108
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 15
          end
          object CheckBox7: TCheckBox
            Left = 9
            Top = 123
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 16
          end
          object CheckBox8: TCheckBox
            Left = 88
            Top = 123
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 17
          end
          object CheckBox9: TCheckBox
            Left = 9
            Top = 138
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 18
          end
          object CheckBox10: TCheckBox
            Left = 88
            Top = 138
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 19
          end
          object CheckBox11: TCheckBox
            Left = 9
            Top = 154
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 20
          end
          object CheckBox12: TCheckBox
            Left = 88
            Top = 154
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 21
          end
        end
        object BtnDisallowAdd: TButton
          Left = 8
          Top = 292
          Width = 78
          Height = 23
          Caption = #22686#21152'(&A)'
          TabOrder = 2
          OnClick = BtnDisallowAddClick
        end
        object BtnDisallowDel: TButton
          Left = 93
          Top = 292
          Width = 78
          Height = 23
          Caption = #21024#38500'(&D)'
          TabOrder = 3
          OnClick = BtnDisallowDelClick
        end
        object BtnDisallowAddAll: TButton
          Left = 8
          Top = 322
          Width = 78
          Height = 23
          Caption = #20840#37096#22686#21152'(&A)'
          TabOrder = 4
          OnClick = BtnDisallowAddAllClick
        end
        object BtnDisallowDelAll: TButton
          Left = 93
          Top = 322
          Width = 78
          Height = 23
          Caption = #20840#37096#21024#38500'(&D)'
          TabOrder = 5
          OnClick = BtnDisallowDelAllClick
        end
        object BtnDisallowChg: TButton
          Left = 8
          Top = 353
          Width = 78
          Height = 23
          Caption = #20462#25913'(&C)'
          TabOrder = 6
          OnClick = BtnDisallowChgClick
        end
        object BtnDisallowSave: TButton
          Left = 93
          Top = 353
          Width = 78
          Height = 23
          Caption = #20445#23384'(&S)'
          TabOrder = 7
          OnClick = BtnDisallowSaveClick
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #28040#24687#36807#28388
      ImageIndex = 6
      OnShow = TabSheet7Show
      object GroupBox22: TGroupBox
        Left = 8
        Top = 8
        Width = 697
        Height = 252
        Caption = #28040#24687#36807#28388#21015#34920
        TabOrder = 0
        object ListViewMsgFilter: TListView
          Left = 8
          Top = 16
          Width = 681
          Height = 226
          Columns = <
            item
              Caption = #36807#28388#28040#24687
              Width = 200
            end
            item
              Caption = #26367#25442#28040#24687
              Width = 200
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewMsgFilterClick
        end
      end
      object GroupBox23: TGroupBox
        Left = 8
        Top = 264
        Width = 697
        Height = 81
        Caption = #28040#24687#36807#28388#21015#34920#32534#36753
        TabOrder = 1
        object Label93: TLabel
          Left = 8
          Top = 24
          Width = 60
          Height = 13
          Caption = #36807#28388#28040#24687#65306
        end
        object Label94: TLabel
          Left = 8
          Top = 48
          Width = 60
          Height = 13
          Caption = #26367#25442#28040#24687#65306
        end
        object EditFilterMsg: TEdit
          Left = 72
          Top = 20
          Width = 609
          Height = 21
          TabOrder = 0
        end
        object EditNewMsg: TEdit
          Left = 72
          Top = 44
          Width = 609
          Height = 21
          Hint = #26367#25442#28040#24687#20026#31354#26102#65292#20002#25481#25972#21477#12290
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
      object ButtonMsgFilterAdd: TButton
        Left = 104
        Top = 355
        Width = 68
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonMsgFilterAddClick
      end
      object ButtonMsgFilterDel: TButton
        Left = 178
        Top = 355
        Width = 68
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonMsgFilterDelClick
      end
      object ButtonMsgFilterChg: TButton
        Left = 252
        Top = 355
        Width = 68
        Height = 25
        Caption = #20462#25913'(&C)'
        TabOrder = 4
        OnClick = ButtonMsgFilterChgClick
      end
      object ButtonMsgFilterSave: TButton
        Left = 326
        Top = 355
        Width = 68
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonMsgFilterSaveClick
      end
      object ButtonLoadMsgFilterList: TButton
        Left = 400
        Top = 355
        Width = 145
        Height = 25
        Caption = #37325#26032#21152#36733#28040#24687#36807#28388#21015#34920
        TabOrder = 6
        OnClick = ButtonLoadMsgFilterListClick
      end
    end
    object TabSheet8: TTabSheet
      Caption = #21830#38138#35774#32622
      ImageIndex = 7
      OnShow = TabSheet8Show
      object Label103: TLabel
        Left = 1
        Top = 386
        Width = 702
        Height = 36
        Caption = 
          #27880#24847#65306'['#21160#30011#35774#32622'] '#26159#26576#29992#25143#28857#20987#21830#38138#29289#21697' '#22312#21830#38138#30028#38754#24038#19978#35282#26174#31034#30340#21160#30011#65307'['#19981#26174#31034#21160#30011'] '#35831#22312' '#8220#22270#29255#24320#22987#8221' '#22788#28155'380,'#8220#22270#29255#32467#26463 +
          #8221#13#22788#28155'0  '#20999#35760#65307'['#26174#31034#21160#30011'] '#22270#29255#24320#22987#22788#35831#28155' '#21160#30011#26174#31034#30340#31532'1'#24352#22270#25968'   '#22270#29255#32467#26463#22788#28155' '#26174#31034#23436#21160#30011#30340#37027#24352#22270#30340#25968#65307#27880#24847#65306' '#21160#30011#26174 +
          #31034#30340#22270#13#29255#22312#23458#25143#31471#30340' '#8220'Effect.wil'#8221' '#37324#12290#25805#20316#8220#22686#21152#12289#20462#25913#12289#21024#38500#8221#21518#65292#35201#28857#20987#8220#20445#23384#8221#65292#25165#33021#20445#23384#25968#25454#12290
        Color = clBtnFace
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object GroupBox10: TGroupBox
        Left = 0
        Top = -1
        Width = 581
        Height = 263
        Caption = #21830#21697#21015#34920
        TabOrder = 0
        object ListViewItemList: TListView
          Left = 3
          Top = 14
          Width = 575
          Height = 246
          Columns = <
            item
              Caption = #21830#21697#21517#31216
              Width = 85
            end
            item
              Caption = #31867#22411
              Width = 36
            end
            item
              Caption = #21830#21697#20215#26684
              Width = 60
            end
            item
              Caption = #22270#29255#24320#22987
              Width = 60
            end
            item
              Caption = #22270#29255#32467#26463
              Width = 60
            end
            item
              Caption = #25968#37327
              Width = 36
            end
            item
              Caption = #31616#21333#20171#32461
              Width = 90
            end
            item
              Caption = #21830#21697#25551#36848
              Width = 160
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewItemListClick
        end
      end
      object GroupBox11: TGroupBox
        Left = 582
        Top = -1
        Width = 132
        Height = 385
        Caption = #29289#21697#21015#34920'(CTRL+F'#26597#25214')'
        TabOrder = 1
        object ListBoxItemListShop: TListBox
          Left = 4
          Top = 16
          Width = 123
          Height = 365
          Hint = 'Ctrl+F '#26597#25214
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ListBoxItemListShopClick
          OnKeyDown = ListBoxItemListShopKeyDown
        end
      end
      object Panel1: TPanel
        Left = 1
        Top = 261
        Width = 580
        Height = 122
        TabOrder = 2
        object Label99: TLabel
          Left = 120
          Top = 29
          Width = 60
          Height = 13
          Caption = #21830#21697#31867#21035#65306
        end
        object Label98: TLabel
          Left = 294
          Top = 26
          Width = 60
          Height = 13
          Caption = #21830#21697#20171#32461#65306
        end
        object Label97: TLabel
          Left = 8
          Top = 29
          Width = 60
          Height = 13
          Caption = #21830#21697#20215#26684#65306
        end
        object Label96: TLabel
          Left = 294
          Top = 47
          Width = 60
          Height = 13
          Caption = #21830#21697#25551#36848#65306
        end
        object Label95: TLabel
          Left = 8
          Top = 6
          Width = 60
          Height = 13
          Caption = #21830#21697#21517#31216#65306
        end
        object Label100: TLabel
          Left = 484
          Top = 5
          Width = 90
          Height = 13
          Caption = #20803#23453#20817#25442'1'#20010#28789#31526
        end
        object Label25: TLabel
          Left = 213
          Top = 5
          Width = 36
          Height = 13
          Caption = #25968#37327#65306
        end
        object SpinEditPrice: TSpinEdit
          Left = 67
          Top = 25
          Width = 46
          Height = 22
          MaxValue = 100000000
          MinValue = 0
          TabOrder = 0
          Value = 100
        end
        object SpinEditGameGird: TSpinEdit
          Left = 437
          Top = 1
          Width = 46
          Height = 22
          MaxValue = 999
          MinValue = 0
          TabOrder = 1
          Value = 1
          OnChange = SpinEditGameGirdChange
        end
        object ShopTypeBoBox: TComboBox
          Left = 178
          Top = 24
          Width = 113
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 2
          Text = '0--'#35013#39280
          Items.Strings = (
            '0--'#35013#39280
            '1--'#34917#32473
            '2--'#24378#21270
            '3--'#22909#21451
            '4--'#38480#37327
            '5--'#22855#29645)
        end
        object Memo1: TMemo
          Left = 353
          Top = 45
          Width = 224
          Height = 74
          Hint = #25551#36848#20013#38388#30340#65073#20195#34920#25442#34892
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object GroupBox12: TGroupBox
          Left = 6
          Top = 45
          Width = 283
          Height = 33
          Caption = #21160#30011#35774#32622
          Color = clBtnFace
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 4
          object Label101: TLabel
            Left = 8
            Top = 15
            Width = 60
            Height = 12
            Caption = #22270#29255#24320#22987#65306
          end
          object Label102: TLabel
            Left = 133
            Top = 14
            Width = 60
            Height = 12
            Caption = #22270#29255#32467#26463#65306
          end
          object EditShopImgBegin: TEdit
            Left = 66
            Top = 10
            Width = 63
            Height = 20
            TabOrder = 0
            Text = '380'
          end
          object EditShopImgEnd: TEdit
            Left = 200
            Top = 10
            Width = 73
            Height = 20
            TabOrder = 1
            Text = '0'
          end
        end
        object EditShopItemName: TEdit
          Left = 67
          Top = 2
          Width = 143
          Height = 21
          ReadOnly = True
          TabOrder = 5
        end
        object EditShopItemIntroduce: TEdit
          Left = 352
          Top = 23
          Width = 225
          Height = 21
          TabOrder = 6
        end
        object CheckBoxBuyGameGird: TCheckBox
          Left = 315
          Top = 3
          Width = 117
          Height = 17
          Caption = #24320#21551#20817#25442#28789#31526#21151#33021
          Checked = True
          State = cbChecked
          TabOrder = 7
          OnClick = CheckBoxBuyGameGirdClick
        end
        object ButtonSaveShopItemList: TButton
          Left = 224
          Top = 78
          Width = 65
          Height = 20
          Caption = #20445#23384'(&S)'
          TabOrder = 8
          OnClick = ButtonSaveShopItemListClick
        end
        object ButtonLoadShopItemList: TButton
          Left = 8
          Top = 101
          Width = 281
          Height = 18
          Caption = #37325#26032#21152#36733#21830#21697#21015#34920'(&R)'
          TabOrder = 9
          OnClick = ButtonLoadShopItemListClick
        end
        object ButtonDelShopItem: TButton
          Left = 8
          Top = 78
          Width = 65
          Height = 20
          Caption = #21024#38500'(&D)'
          TabOrder = 10
          OnClick = ButtonDelShopItemClick
        end
        object ButtonChgShopItem: TButton
          Left = 80
          Top = 78
          Width = 65
          Height = 20
          Caption = #20462#25913'(&C)'
          TabOrder = 11
          OnClick = ButtonChgShopItemClick
        end
        object ButtonAddShopItem: TButton
          Left = 152
          Top = 78
          Width = 65
          Height = 20
          Caption = #22686#21152'(&A)'
          TabOrder = 12
          OnClick = ButtonAddShopItemClick
        end
        object SpinEditShopItemCount: TSpinEdit
          Left = 246
          Top = 2
          Width = 46
          Height = 22
          Hint = #19968#27425#36141#20080#21487#20197#33719#24471#30340#29289#21697#25968#37327
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          Value = 1
        end
      end
    end
  end
end

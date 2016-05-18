object Form1: TForm1
  Left = 373
  Top = 248
  Width = 423
  Height = 324
  Caption = #21830#19994#30331#38470#22120#21644#32593#20851#29983#25104#22120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object RzPageControl1: TRzPageControl
    Left = 0
    Top = 0
    Width = 415
    Height = 290
    ActivePage = TabSheet1
    Align = alClient
    Color = 16119543
    FlatColor = 10263441
    ParentColor = False
    TabColors.HighlightBar = 1350640
    TabIndex = 0
    TabOrder = 0
    FixedDimension = 18
    object TabSheet1: TRzTabSheet
      Color = 16119543
      Caption = #30331#38470#22120
      object RzLabel1: TRzLabel
        Left = 16
        Top = 16
        Width = 72
        Height = 12
        Caption = #30331#38470#22120#21517#31216#65306
      end
      object RzLabel2: TRzLabel
        Left = 16
        Top = 56
        Width = 60
        Height = 12
        Caption = #28216#25103#21015#34920#65306
      end
      object RzLabel3: TRzLabel
        Left = 16
        Top = 76
        Width = 60
        Height = 12
        Caption = #22791#29992#21015#34920#65306
      end
      object RzLabel4: TRzLabel
        Left = 16
        Top = 96
        Width = 60
        Height = 12
        Caption = #26356#26032#21015#34920#65306
      end
      object RzLabel5: TRzLabel
        Left = 16
        Top = 117
        Width = 72
        Height = 12
        Caption = #21453#22806#25346#21015#34920#65306
      end
      object RzLabel6: TRzLabel
        Left = 16
        Top = 197
        Width = 48
        Height = 12
        Caption = #23553#21253#30721#65306
      end
      object RzLabel7: TRzLabel
        Left = 16
        Top = 137
        Width = 42
        Height = 12
        Caption = 'E'#31995#32479#65306
      end
      object RzLabel8: TRzLabel
        Left = 16
        Top = 36
        Width = 84
        Height = 12
        Caption = #23458#25143#31471#25991#20214#21517#65306
      end
      object RzLabel9: TRzLabel
        Left = 16
        Top = 157
        Width = 84
        Height = 12
        Caption = #30331#38470#22120#32972#26223#22270#65306
      end
      object RzLabel10: TRzLabel
        Left = 16
        Top = 177
        Width = 72
        Height = 12
        Caption = #30331#38470#22120#31243#24207#65306
      end
      object RzLabel13: TRzLabel
        Left = 16
        Top = 220
        Width = 84
        Height = 12
        Caption = #28216#25103#36807#28388#25991#20214#65306
      end
      object RzEdit1: TRzEdit
        Left = 104
        Top = 10
        Width = 297
        Height = 20
        TabOrder = 0
      end
      object RzEdit2: TRzEdit
        Left = 104
        Top = 50
        Width = 297
        Height = 20
        Text = 'http://127.0.0.1/QKServerList.txt'
        TabOrder = 1
      end
      object RzEdit3: TRzEdit
        Left = 104
        Top = 70
        Width = 297
        Height = 20
        Text = 'http://127.0.0.1/QKServerList.txt'
        TabOrder = 2
      end
      object RzEdit4: TRzEdit
        Left = 104
        Top = 90
        Width = 297
        Height = 20
        Text = 'http://127.0.0.1/QKPatchList.txt'
        TabOrder = 3
      end
      object RzEdit5: TRzEdit
        Left = 104
        Top = 110
        Width = 297
        Height = 20
        Text = 'http://127.0.0.1/QKGameMonList.txt'
        TabOrder = 4
      end
      object RzEdit6: TRzEdit
        Left = 104
        Top = 130
        Width = 297
        Height = 20
        Text = 'http://www.igem2.com'
        TabOrder = 5
      end
      object RzEdit7: TRzEdit
        Left = 104
        Top = 192
        Width = 233
        Height = 20
        TabOrder = 6
      end
      object RzEdit8: TRzEdit
        Left = 104
        Top = 30
        Width = 233
        Height = 20
        TabOrder = 7
      end
      object RzButtonEdit1: TRzButtonEdit
        Left = 104
        Top = 150
        Width = 297
        Height = 20
        TabOrder = 8
        OnButtonClick = RzButtonEdit1ButtonClick
      end
      object RzButton1: TRzButton
        Left = 341
        Top = 28
        Width = 60
        Height = 22
        Caption = #38543#26426#29983#25104
        HotTrack = True
        TabOrder = 9
        OnClick = RzButton1Click
      end
      object RzButton2: TRzButton
        Left = 112
        Top = 238
        Width = 185
        Caption = #29983#25104#30331#38470#22120
        HotTrack = True
        TabOrder = 10
        OnClick = RzButton2Click
      end
      object RzButton3: TRzButton
        Left = 341
        Top = 190
        Width = 60
        Height = 22
        Caption = #38543#26426#29983#25104
        HotTrack = True
        TabOrder = 11
        OnClick = RzButton3Click
      end
      object RzButtonEdit2: TRzButtonEdit
        Left = 104
        Top = 170
        Width = 297
        Height = 20
        TabOrder = 12
        OnButtonClick = RzButtonEdit2ButtonClick
      end
      object RzButtonEdit4: TRzButtonEdit
        Left = 104
        Top = 214
        Width = 297
        Height = 20
        TabOrder = 13
        OnButtonClick = RzButtonEdit4ButtonClick
      end
    end
    object TabSheet2: TRzTabSheet
      Color = 16119543
      Caption = #32593#20851
      object RzLabel11: TRzLabel
        Left = 40
        Top = 44
        Width = 48
        Height = 12
        Caption = #23553#21253#30721#65306
      end
      object RzLabel12: TRzLabel
        Left = 29
        Top = 16
        Width = 60
        Height = 12
        Caption = #32593#20851#31243#24207#65306
      end
      object Edit1: TEdit
        Left = 88
        Top = 39
        Width = 273
        Height = 20
        TabOrder = 0
      end
      object RzButton4: TRzButton
        Left = 128
        Top = 72
        Width = 129
        Caption = #29983#25104#37197#22871#32593#20851'(&M)'
        HotTrack = True
        TabOrder = 1
        OnClick = RzButton4Click
      end
      object RzButtonEdit3: TRzButtonEdit
        Left = 88
        Top = 12
        Width = 273
        Height = 20
        TabOrder = 2
        OnButtonClick = RzButtonEdit3ButtonClick
      end
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Title = #25171#24320
    Left = 63
    Top = 274
  end
  object OpenDialog1: TOpenDialog
    Title = #25171#24320
    Left = 28
    Top = 271
  end
end

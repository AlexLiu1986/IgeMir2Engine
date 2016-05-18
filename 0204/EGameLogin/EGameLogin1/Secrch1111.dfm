object FrmSecrch: TFrmSecrch
  Left = 192
  Top = 114
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #25628#32034#20256#22855#23458#25143#31471#30446#24405'...'
  ClientHeight = 360
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TRzGroupBox
    Left = 8
    Top = 8
    Width = 425
    Height = 337
    Caption = #33258#21160#23547#25214#23458#25143#31471
    FlatColor = clBlack
    TabOrder = 0
    Transparent = True
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 396
      Height = 36
      Caption = 
        '    '#24744#22909#65292#20146#29233#30340#29609#23478#65292#24744#29616#22312#36816#34892#30340#20256#22855#30331#38470#22120#36824#27809#26377#25351#23450#20256#22855#28216#25103#30446#24405#13#20026#20102#24744#33021#27491#24120#28216#25103#65292#24744#21487#20197#23558#30331#38470#22120#22797#21046#21040#24744#30340#20256#22855#28216#25103#30446#24405#12290 +
        #37325#26032#36816#34892#65292#13#25110#32773#36890#36807#19979#38754#30340#26234#33021#21521#23548#36827#34892#35774#32622#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object GroupBox2: TRzGroupBox
      Left = 8
      Top = 64
      Width = 409
      Height = 241
      Caption = #26234#33021#21521#23548
      FlatColor = clBlack
      TabOrder = 0
      Transparent = True
      object Label2: TLabel
        Left = 16
        Top = 16
        Width = 378
        Height = 36
        Caption = 
          '   '#20146#29233#30340#29609#23478#65292#36825#37324#26159#26234#33021#35774#32622#21521#23548#65292#35831#24744#25353#29031#25552#31034#23436#25104#28216#25103#36335#24452#35774#32622#13'1'#12289#25105#26159#26032#25163#65292#25105#23545#30005#33041#19981#29087#24713#65306#13'       '#24744#21487#20197#36890#36807#8220#26234 +
          #33021#25628#32034#8221#23436#25104#24744#30340#25628#32034#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object SecrchInfoLabel: TRzLabel
        Left = 48
        Top = 85
        Width = 78
        Height = 12
        Caption = #27491#22312#25628#32034#65306'*.*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 16
        Top = 104
        Width = 390
        Height = 36
        Caption = 
          '2'#12289#25105#26159#39640#25163#65292#25105#23545#30005#33041#24456#29087#24713#65306#13'       '#24744#21487#20197#22312#19979#38754#30340#36755#20837#26694#20869#36755#20837#20256#22855#28216#25103#30446#24405#25110#32773#28857#20987#8220#25163#24037#36873#25321#8221#13'   '#25353#38062#65292#36873#25321#24744#30340#20256 +
          #22855#23458#25143#31471#30446#24405#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 40
        Top = 152
        Width = 60
        Height = 12
        Caption = #28216#25103#36335#24452#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label5: TLabel
        Left = 16
        Top = 176
        Width = 372
        Height = 48
        Caption = 
          #27880#24847#65306#33258#21160#25628#32034#23558#25628#32034#24744#30340#25972#20010#30005#33041#65292#26681#25454#24744#30340#30005#33041#36895#24230#36319#30828#30424#22823#23567#30340#13'      '#19981#21516#65292#25628#32034#23558#33457#36153#26102#38388#65292#35831#32784#24515#31561#24453#12290#13#22914#26524#25628#32034#25552#31034#8220#27809 +
          #26377#25214#21040#20256#22855#23458#25143#31471#8221#65292#35831#24744#19979#36733#30427#22823#25110#32773#31169#26381#30340#19987#29992#13#23458#25143#31471#25110#32773#21672#35810#31995#32479#31649#29702#21592#12290
        Transparent = True
      end
      object EditPath: TEdit
        Left = 104
        Top = 148
        Width = 209
        Height = 20
        AutoSelect = False
        BiDiMode = bdLeftToRight
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        Text = '        '#25163#24037#36873#25321#35831#28857#36825#37324#8594
      end
      object RzToolButtonSearch: TbsSkinButton
        Left = 16
        Top = 56
        Width = 385
        Height = 25
        TabOrder = 1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #26234#33021#25628#32034#65288#28857#20987#25105#23558#24320#22987#26234#33021#25628#32034#24744#30005#33041#19978#30340#20256#22855#23458#25143#31471#65289
        NumGlyphs = 1
        Spacing = 1
        OnClick = RzToolButtonSearchClick
      end
      object RzButtonSelDir: TbsSkinButton
        Left = 320
        Top = 144
        Width = 75
        Height = 25
        TabOrder = 2
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #25163#24037#36873#25321
        NumGlyphs = 1
        Spacing = 1
        OnClick = RzButtonSelDirClick
      end
    end
    object StopButton: TbsSkinButton
      Left = 176
      Top = 308
      Width = 75
      Height = 25
      TabOrder = 1
      SkinDataName = 'button'
      DefaultFont.Charset = GB2312_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -12
      DefaultFont.Name = #23435#20307
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      ImageIndex = -1
      UseSkinSize = True
      UseSkinFontColor = True
      RepeatMode = False
      RepeatInterval = 100
      AllowAllUp = False
      TabStop = True
      CanFocused = True
      Down = False
      GroupIndex = 0
      Caption = #21462#28040'(&C)'
      NumGlyphs = 1
      Spacing = 1
      OnClick = StopButtonClick
    end
  end
  object SelectDirectoryDialog: TbsSkinSelectDirectoryDialog
    DialogWidth = 0
    DialogHeight = 0
    DialogMinWidth = 0
    DialogMinHeight = 0
    AlphaBlend = False
    AlphaBlendValue = 200
    AlphaBlendAnimation = False
    DefaultFont.Charset = GB2312_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -12
    DefaultFont.Name = #23435#20307
    DefaultFont.Style = []
    Title = #35831#36873#25321#20256#22855#25152#22312#30446#24405
    ShowToolBar = False
    Left = 72
    Top = 312
  end
end

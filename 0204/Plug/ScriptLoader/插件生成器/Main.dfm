object Form1: TForm1
  Left = 313
  Top = 239
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'IGE'#31185#25216#33050#26412#21152#23494#25554#20214#29983#25104#22120
  ClientHeight = 293
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 5
    Top = 7
    Width = 384
    Height = 238
    Caption = #37197#32622#20449#24687
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 115
      Width = 54
      Height = 12
      Caption = #25554#20214#23494#30721':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 54
      Height = 12
      Caption = #25554#20214#21517#31216':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 44
      Width = 78
      Height = 12
      Caption = #21152#36733#25104#21151#20449#24687':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 68
      Width = 78
      Height = 12
      Caption = #21152#36733#22833#36133#20449#24687':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 92
      Width = 54
      Height = 12
      Caption = #21368#36733#20449#24687':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object EditBakGameListURL: TEdit
      Left = 106
      Top = 112
      Width = 271
      Height = 20
      MaxLength = 50
      TabOrder = 0
    end
    object EditPlugName: TEdit
      Left = 106
      Top = 16
      Width = 271
      Height = 20
      MaxLength = 50
      TabOrder = 1
      Text = #12304'IGE'#31185#25216' '#21830#19994#33050#26412#25554#20214#12305
    end
    object GroupBox2: TGroupBox
      Left = 17
      Top = 136
      Width = 359
      Height = 97
      Caption = #25554#20214#25552#31034#20449#24687
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object EditGameShowUrl: TMemo
        Left = 2
        Top = 14
        Width = 355
        Height = 81
        Align = alClient
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        Lines.Strings = (
          #35831#25226#26426#22120#30721#22797#21046#21518#21457#36865#32473#23458#26381#22788','#33719#21462#27880#20876#30721'!'#27880#20876#21518#25165
          #33021#27491#24120#20351#29992'!'
          #23458#26381'QQ:228589790'
          #31243#24207#32593#22336':http://www.Igem2.com'
          #26356#26032#26085#26399':2008-12-17')
        MaxLength = 250
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object EditStartLoadPlugSucced: TEdit
      Left = 106
      Top = 40
      Width = 271
      Height = 20
      MaxLength = 50
      TabOrder = 3
      Text = #21152#36733#12304'IGE'#31185#25216' '#21830#19994#33050#26412#25554#20214#12305#25104#21151
    end
    object EditStartLoadPlugFail: TEdit
      Left = 106
      Top = 64
      Width = 271
      Height = 20
      MaxLength = 50
      TabOrder = 4
      Text = #21152#36733#12304'IGE'#31185#25216' '#21830#19994#33050#26412#25554#20214#12305#22833#36133
    end
    object EditUnLoadPlug: TEdit
      Left = 106
      Top = 88
      Width = 271
      Height = 20
      MaxLength = 50
      TabOrder = 5
      Text = #21368#36733#12304'IGE'#31185#25216' '#21830#19994#33050#26412#25554#20214#12305#25104#21151
    end
  end
  object Button2: TButton
    Left = 307
    Top = 254
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 221
    Top = 254
    Width = 75
    Height = 25
    Caption = #29983#25104#25554#20214
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 120
    Top = 255
    Width = 75
    Height = 25
    Caption = #27880#20876#25554#20214
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 16
    Top = 255
    Width = 75
    Height = 25
    Caption = #35299#23494#38053
    Enabled = False
    TabOrder = 4
    Visible = False
    OnClick = Button4Click
  end
end

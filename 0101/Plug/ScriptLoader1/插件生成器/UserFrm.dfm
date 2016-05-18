object UserForm: TUserForm
  Left = 317
  Top = 239
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #29992#25143#27880#20876
  ClientHeight = 232
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 377
    Height = 219
    Caption = #27880#20876#20449#24687
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 24
      Width = 330
      Height = 60
      Caption = 
        #35831#25226#26426#22120#30721#22797#21046#21457#36865#32473#23458#26381','#33719#21462#27880#20876#30721'!'#27880#20876#21518#25165#33021#27491#24120#20351#29992'!'#13#10#23458#26381'QQ:228589790'#13#10#31243#24207#32593#22336':http://www.I' +
        'gem2.com'#13#10#26356#26032#26085#26399':2008-12-17'#13#10
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 12
      Top = 91
      Width = 52
      Height = 13
      Caption = #26426#22120#30721#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 12
      Top = 151
      Width = 52
      Height = 13
      Caption = #27880#20876#30721#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 12
      Top = 118
      Width = 52
      Height = 13
      Caption = #29992#25143#21517#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object EditUserName: TEdit
      Left = 64
      Top = 90
      Width = 297
      Height = 20
      AutoSelect = False
      BorderStyle = bsNone
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'EditUserName'
    end
    object EditUserInfo: TEdit
      Left = 60
      Top = 114
      Width = 301
      Height = 20
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 16
      Top = 183
      Width = 75
      Height = 25
      Caption = #21462#28040'(&E)'
      TabOrder = 2
      OnClick = BitBtn1Click
      Kind = bkCancel
    end
    object BitBtn2: TBitBtn
      Left = 283
      Top = 183
      Width = 75
      Height = 25
      Caption = #30830#23450'(&R)'
      TabOrder = 3
      OnClick = BitBtn2Click
      Kind = bkOK
    end
    object EditEnterKey: TMemo
      Left = 60
      Top = 137
      Width = 301
      Height = 41
      TabOrder = 4
    end
  end
end

object FrmBasicSet: TFrmBasicSet
  Left = 347
  Top = 303
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22522#26412#35774#32622
  ClientHeight = 257
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 449
    Height = 223
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #30331#38470#22120
      object GroupBox1: TGroupBox
        Left = 8
        Top = 3
        Width = 425
        Height = 185
        Caption = #30331#38470#22120#39118#26684#35774#32622
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 18
          Width = 84
          Height = 12
          Caption = #30331#38470#22120#19968#30028#38754#65306
        end
        object Label2: TLabel
          Left = 16
          Top = 39
          Width = 84
          Height = 12
          Caption = #30331#38470#22120#19968#31243#24207#65306
        end
        object Label3: TLabel
          Left = 16
          Top = 61
          Width = 84
          Height = 12
          Caption = #30331#38470#22120#20108#30028#38754#65306
        end
        object Label4: TLabel
          Left = 16
          Top = 81
          Width = 84
          Height = 12
          Caption = #30331#38470#22120#20108#31243#24207#65306
        end
        object Label9: TLabel
          Left = 16
          Top = 103
          Width = 84
          Height = 12
          Caption = #30331#38470#22120#19977#30028#38754#65306
        end
        object Label10: TLabel
          Left = 16
          Top = 123
          Width = 84
          Height = 12
          Caption = #30331#38470#22120#19977#31243#24207#65306
        end
        object Label11: TLabel
          Left = 8
          Top = 145
          Width = 96
          Height = 12
          Caption = #20223#30427#22823#40664#35748#30028#38754#65306
          Visible = False
        end
        object Label12: TLabel
          Left = 8
          Top = 165
          Width = 96
          Height = 12
          Caption = #20223#30427#22823#40664#35748#31243#24207#65306
          Visible = False
        end
        object EdtMainImages1: TRzButtonEdit
          Left = 103
          Top = 14
          Width = 314
          Height = 20
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainImages1ButtonClick
        end
        object EdtLoginExe1: TRzButtonEdit
          Left = 103
          Top = 35
          Width = 314
          Height = 20
          TabOrder = 1
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtLoginExe1ButtonClick
        end
        object EdtMainImages2: TRzButtonEdit
          Left = 103
          Top = 56
          Width = 314
          Height = 20
          TabOrder = 2
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainImages2ButtonClick
        end
        object EdtLoginExe2: TRzButtonEdit
          Left = 103
          Top = 77
          Width = 314
          Height = 20
          TabOrder = 3
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtLoginExe2ButtonClick
        end
        object EdtMainImages3: TRzButtonEdit
          Left = 103
          Top = 98
          Width = 314
          Height = 20
          TabOrder = 4
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainImages3ButtonClick
        end
        object EdtLoginExe3: TRzButtonEdit
          Left = 103
          Top = 119
          Width = 314
          Height = 20
          TabOrder = 5
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtLoginExe3ButtonClick
        end
        object EdtMainImages4: TRzButtonEdit
          Left = 103
          Top = 140
          Width = 314
          Height = 20
          TabOrder = 6
          Visible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainImages4ButtonClick
        end
        object EdtLoginExe4: TRzButtonEdit
          Left = 103
          Top = 161
          Width = 314
          Height = 20
          TabOrder = 7
          Visible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtLoginExe4ButtonClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #32593#20851
      ImageIndex = 2
      object GroupBox4: TGroupBox
        Left = 8
        Top = 3
        Width = 425
        Height = 185
        Caption = #32593#20851#35774#32622
        TabOrder = 0
        object Label7: TLabel
          Left = 8
          Top = 24
          Width = 84
          Height = 12
          Caption = #32593#20851#40664#35748#31243#24207#65306
        end
        object EdtGateExe: TRzButtonEdit
          Left = 95
          Top = 20
          Width = 322
          Height = 20
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtGateExeButtonClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'HTTP'#21450#29983#25104#30446#24405
      ImageIndex = 1
      object Label13: TLabel
        Left = 8
        Top = 160
        Width = 24
        Height = 12
        Caption = #20801#35768
      end
      object Label14: TLabel
        Left = 82
        Top = 160
        Width = 96
        Height = 12
        Caption = #29992#25143#22312#32447#21516#26102#29983#25104
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 3
        Width = 425
        Height = 46
        Caption = 'HTTP'#35774#32622
        TabOrder = 0
        object Label5: TLabel
          Left = 8
          Top = 21
          Width = 84
          Height = 12
          Caption = #19979#36733#32593#31449#36335#24452#65306
        end
        object EdtHttp: TEdit
          Left = 92
          Top = 16
          Width = 323
          Height = 20
          TabOrder = 0
          Text = 'Http://Vip.56m2.cn/'
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 52
        Width = 425
        Height = 46
        Caption = #29983#25104#30446#24405#35774#32622
        TabOrder = 1
        object Label6: TLabel
          Left = 8
          Top = 21
          Width = 60
          Height = 12
          Caption = #29983#25104#36335#24452#65306
        end
        object EdtMakeDir: TRzButtonEdit
          Left = 67
          Top = 17
          Width = 350
          Height = 20
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMakeDirButtonClick
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 101
        Width = 425
        Height = 46
        Caption = #29992#25143'FTP'#19978#20256#30446#24405#35774#32622
        TabOrder = 2
        object Label8: TLabel
          Left = 8
          Top = 21
          Width = 60
          Height = 12
          Caption = #19978#20256#36335#24452#65306
        end
        object EdtUpFileDir: TRzButtonEdit
          Left = 67
          Top = 17
          Width = 350
          Height = 20
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtUpFileDirButtonClick
        end
      end
      object EdtUserOneTimeMake: TSpinEdit
        Left = 36
        Top = 155
        Width = 44
        Height = 21
        MaxValue = 50
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
    end
  end
  object BtnSave: TButton
    Left = 360
    Top = 227
    Width = 75
    Height = 25
    Caption = #20445#23384'(&S)'
    TabOrder = 1
    OnClick = BtnSaveClick
  end
  object OpenDialog1: TOpenDialog
    Filter = #30331#38470#22120#31243#24207'(*.EXE)|*.EXE'
    Title = #25171#24320
    Left = 12
    Top = 226
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'All (*.png;*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf)|*.jpg;*.jpeg;*.' +
      'bmp;*.ico;*.emf;*.wmf|JPEG Image File (*.jpg)|*.jpg|JPEG Image F' +
      'ile (*.jpeg)|*.jpeg|Bitmaps (*.bmp)|*.bmp|Icons (*.ico)|*.ico|En' +
      'hanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf'
    Title = #25171#24320
    Left = 44
    Top = 226
  end
end

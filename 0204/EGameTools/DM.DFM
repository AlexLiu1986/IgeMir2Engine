object FrmDM: TFrmDM
  OldCreateOrder = False
  Left = 326
  Top = 307
  Height = 210
  Width = 236
  object DataSourceMagic: TDataSource
    DataSet = TableMagic
    Left = 20
  end
  object TableMagic: TTable
    AutoRefresh = True
    TableName = 'Magic.DB'
    Left = 76
  end
  object TableMonster: TTable
    AutoRefresh = True
    TableName = 'Monster.DB'
    Left = 76
    Top = 48
  end
  object DataSourceMonster: TDataSource
    DataSet = TableMonster
    Left = 20
    Top = 48
  end
  object DataSourceStdItems: TDataSource
    DataSet = TableStdItems
    Left = 20
    Top = 104
  end
  object TableStdItems: TTable
    AutoRefresh = True
    TableName = 'StdItems.DB'
    Left = 76
    Top = 104
  end
  object Query1: TQuery
    Left = 152
    Top = 104
  end
end

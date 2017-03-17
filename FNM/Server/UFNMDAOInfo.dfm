object FNMDaoInfo: TFNMDaoInfo
  OldCreateOrder = False
  OnCreate = MtsDataModuleCreate
  Pooled = False
  Left = 192
  Top = 133
  Height = 150
  Width = 352
  object dataSetProvider: TDataSetProvider
    Constraints = True
    Left = 144
    Top = 16
  end
  object adoConnection: TADOConnection
    Left = 40
    Top = 16
  end
end

object FNMDaoUpt: TFNMDaoUpt
  OldCreateOrder = False
  OnCreate = MtsDataModuleCreate
  Pooled = False
  Left = 253
  Top = 135
  Height = 186
  Width = 314
  object dataSetProvider: TDataSetProvider
    Constraints = True
    Left = 128
    Top = 16
  end
  object adoConnection: TADOConnection
    Left = 40
    Top = 16
  end
end

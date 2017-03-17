object WMISUserRight: TWMISUserRight
  OldCreateOrder = False
  OnCreate = MtsDataModuleCreate
  Pooled = False
  Left = 509
  Top = 224
  Height = 147
  Width = 240
  object adoqryPublic: TADOQuery
    Connection = adoConnection
    Parameters = <>
    SQL.Strings = (
      'EXEC USP_GetRsTask ')
    Left = 115
    Top = 16
  end
  object adoConnection: TADOConnection
    Left = 40
    Top = 16
  end
end

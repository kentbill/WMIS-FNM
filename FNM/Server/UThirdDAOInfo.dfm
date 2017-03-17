object ThirdDAOInfo: TThirdDAOInfo
  OldCreateOrder = False
  OnCreate = MtsDataModuleCreate
  Pooled = False
  Left = 236
  Top = 86
  Height = 283
  Width = 245
  object ADOConn_MONFonts: TADOConnection
    Left = 40
    Top = 16
  end
  object DataSetProvider: TDataSetProvider
    Constraints = True
    Left = 144
    Top = 16
  end
  object ADOConn_OTServer: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=123;Persist Security Info=True;User' +
      ' ID=SA;Initial Catalog=Orgatex2;Data Source=OT-SERVER'
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 80
  end
  object ADOConn_CSServer: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=123;Persist Security Info=True;User' +
      ' ID=SA;Initial Catalog=Orgatex2;Data Source=OT-SERVER'
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 152
  end
end

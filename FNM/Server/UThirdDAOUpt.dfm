object ThirdDAOUpt: TThirdDAOUpt
  OldCreateOrder = False
  OnCreate = MtsDataModuleCreate
  Pooled = False
  Left = 303
  Top = 103
  Height = 296
  Width = 267
  object ADOConn_CSServer: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=123;Persist Security Info=True;User' +
      ' ID=SA;Initial Catalog=Orgatex2;Data Source=OT-SERVER'
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 152
  end
  object ADOConn_OTServer: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=123;Persist Security Info=True;User' +
      ' ID=SA;Initial Catalog=Orgatex2;Data Source=OT-SERVER'
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 80
  end
  object ADOConn_MONFonts: TADOConnection
    Left = 40
    Top = 16
  end
end

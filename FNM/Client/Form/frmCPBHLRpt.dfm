inherited CPBHLRptForm: TCPBHLRptForm
  Left = 336
  Top = 179
  Caption = 'HL'#25253#34920
  PixelsPerInch = 96
  TextHeight = 12
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 680
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 19
      Width = 48
      Height = 12
      Caption = #24320#22987#26085#26399
    end
    object Label2: TLabel
      Left = 192
      Top = 19
      Width = 48
      Height = 12
      Caption = #32467#26463#26085#26399
    end
    object btnRefresh: TSpeedButton
      Left = 361
      Top = 13
      Width = 78
      Height = 25
      Caption = #21047#26032'(&R)'
      Flat = True
      OnClick = btnRefreshClick
    end
    object btnClose: TSpeedButton
      Left = 443
      Top = 13
      Width = 78
      Height = 25
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnCloseClick
    end
    object dpBeginDate: TDateTimePicker
      Left = 72
      Top = 16
      Width = 107
      Height = 20
      CalAlignment = dtaLeft
      Date = 42068
      Time = 42068
      ShowCheckbox = True
      DateFormat = dfShort
      DateMode = dmComboBox
      ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object dpEndDate: TDateTimePicker
      Left = 248
      Top = 16
      Width = 107
      Height = 20
      CalAlignment = dtaLeft
      Date = 42068
      Time = 42068
      ShowCheckbox = True
      DateFormat = dfShort
      DateMode = dmComboBox
      ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
  end
  object cxgridHLRpt: TcxGrid
    Left = 0
    Top = 49
    Width = 680
    Height = 393
    Align = alClient
    TabOrder = 1
    object cxgridtvCPBHLRpt: TcxGridDBTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
    end
    object cxGridlHLRpt: TcxGridLevel
      GridView = cxgridtvCPBHLRpt
    end
  end
  object dsCPBHLRpt: TDataSource
    DataSet = cdsCPBHLRpt
    Left = 112
    Top = 224
  end
  object cdsCPBHLRpt: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 224
  end
end

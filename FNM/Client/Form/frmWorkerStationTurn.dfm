inherited WorkerStationTurnForm: TWorkerStationTurnForm
  Left = 260
  Top = 191
  Caption = #19978#20256#36718#20241#34920
  OldCreateOrder = True
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 12
  object pnl1: TPanel
    Left = 0
    Top = 419
    Width = 688
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    OnMouseMove = pnl1MouseMove
    DesignSize = (
      688
      34)
    object btnQuery: TSpeedButton
      Left = 338
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #26597#35810'(&Q)'
      Flat = True
      OnClick = btnQueryClick
    end
    object btnExcel: TSpeedButton
      Left = 426
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #19978#20256'(&I)'
      Flat = True
      OnClick = btnExcelClick
    end
    object btnSave: TSpeedButton
      Left = 513
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      Flat = True
      OnClick = btnSaveClick
    end
    object btnExit: TSpeedButton
      Left = 600
      Top = 6
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnExitClick
    end
    object btnQueryResult: TSpeedButton
      Left = 251
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #26597#35810#32467#26524'(&R)'
      Flat = True
      OnClick = btnQueryResultClick
    end
    object btnDelete: TSpeedButton
      Left = 36
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #21024#38500'(&D)'
      Flat = True
      OnClick = btnDeleteClick
    end
  end
  object cxgridWorkerStationTurn: TcxGrid
    Left = 0
    Top = 0
    Width = 688
    Height = 419
    Align = alClient
    TabOrder = 1
    object cxgridtvWorkerStationTurn: TcxGridDBTableView
      DataController.DataSource = dsWorkerStationTurn
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OnCustomDrawCell = cxgridtvWorkerStationTurnCustomDrawCell
    end
    object cxGridlWorkerStationTurn: TcxGridLevel
      GridView = cxgridtvWorkerStationTurn
    end
  end
  object dsWorkerStationTurn: TDataSource
    DataSet = cdsWorkerStationTurn
    Left = 432
    Top = 72
  end
  object cdsWorkerStationTurn: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 136
  end
  object dsImport: TADODataSet
    Parameters = <>
    Left = 72
    Top = 216
  end
end

inherited TraceRepairForm: TTraceRepairForm
  Caption = #36820#24037#24067#36319#36394
  OldCreateOrder = True
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      688
      65)
    object btn_Save: TBitBtn
      Left = 277
      Top = 22
      Width = 58
      Height = 25
      Anchors = [akLeft, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #20445#23384'(&S)'
      Default = True
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 0
      OnClick = btn_SaveClick
    end
    object btn_Exit: TBitBtn
      Left = 456
      Top = 22
      Width = 58
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akLeft, akBottom]
      BiDiMode = bdLeftToRight
      Cancel = True
      Caption = #36864#20986'(&X)'
      ParentBiDiMode = False
      TabOrder = 1
      OnClick = btn_ExitClick
    end
    object btn_Refresh: TBitBtn
      Left = 188
      Top = 22
      Width = 58
      Height = 25
      Anchors = [akLeft, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #21047#26032'(&R)'
      Default = True
      ParentBiDiMode = False
      TabOrder = 2
      OnClick = btn_RefreshClick
    end
    object btnCancel: TBitBtn
      Left = 367
      Top = 22
      Width = 58
      Height = 25
      Anchors = [akLeft, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #25764#28040'(&C)'
      Default = True
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 3
      OnClick = btnCancelClick
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 65
    Width = 688
    Height = 388
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object cxgridTraceRepair: TcxGrid
      Left = 0
      Top = 0
      Width = 688
      Height = 388
      Align = alClient
      TabOrder = 0
      object cxgridtvTraceRepair: TcxGridDBTableView
        DataController.DataSource = dsTraceRepair
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnFocusedItemChanged = cxgridtvTraceRepairFocusedItemChanged
        OnFocusedRecordChanged = cxgridtvTraceRepairFocusedRecordChanged
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
      end
      object cxGridlTraceRepair: TcxGridLevel
        GridView = cxgridtvTraceRepair
      end
    end
  end
  object dsTraceRepair: TDataSource
    DataSet = cdsTraceRepair
    Left = 304
    Top = 216
  end
  object cdsTraceRepair: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 240
    Top = 216
  end
end

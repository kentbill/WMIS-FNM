inherited FabricReportForm: TFabricReportForm
  Left = 86
  Top = 26
  Width = 772
  Height = 479
  Caption = #26085'/'#26376#25253
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlBottom: TPanel
    Left = 0
    Top = 387
    Width = 764
    Height = 65
    Align = alBottom
    BevelOuter = bvNone
    Caption = '`'
    TabOrder = 1
    DesignSize = (
      764
      65)
    object lblBeginTime: TLabel
      Left = 44
      Top = 18
      Width = 54
      Height = 12
      Caption = #24320#22987#26102#38388':'
    end
    object lblEndTime: TLabel
      Left = 43
      Top = 46
      Width = 54
      Height = 12
      Caption = #32467#26463#26102#38388':'
    end
    object lbl1: TLabel
      Left = 298
      Top = 46
      Width = 30
      Height = 12
      Caption = #37096#38376':'
    end
    object Label1: TLabel
      Left = 298
      Top = 18
      Width = 30
      Height = 12
      Caption = #31867#22411':'
    end
    object btnClose: TBitBtn
      Left = 653
      Top = 31
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object btnRefresh: TBitBtn
      Left = 569
      Top = 31
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #26597#35810'(&Q)'
      Default = True
      TabOrder = 0
      OnClick = btnRefreshClick
    end
    object dtpBeginDate: TDateTimePicker
      Left = 99
      Top = 10
      Width = 83
      Height = 20
      CalAlignment = dtaLeft
      Date = 38338.429389537
      Time = 38338.429389537
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
    object dtpBeginTime: TDateTimePicker
      Left = 180
      Top = 10
      Width = 71
      Height = 20
      CalAlignment = dtaLeft
      Date = 38338.429389537
      Time = 38338.429389537
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkTime
      ParseInput = False
      TabOrder = 3
    end
    object dtpEndDate: TDateTimePicker
      Left = 99
      Top = 38
      Width = 83
      Height = 20
      CalAlignment = dtaLeft
      Date = 38338.429389537
      Time = 38338.429389537
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 4
    end
    object dtpEndTime: TDateTimePicker
      Left = 180
      Top = 38
      Width = 71
      Height = 20
      CalAlignment = dtaLeft
      Date = 38338.429389537
      Time = 38338.429389537
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkTime
      ParseInput = False
      TabOrder = 5
    end
    object cbbCurrentDept: TComboBox
      Left = 339
      Top = 38
      Width = 145
      Height = 20
      Hint = #24403#21069#24212#29992#31243#24207#27491#22312#25805#20316#30340#37096#38376
      ItemHeight = 12
      TabOrder = 6
    end
    object cbbReportType: TComboBox
      Left = 339
      Top = 10
      Width = 145
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 7
      OnChange = cbbReportTypeChange
      Items.Strings = (
        #25910'    '#22383
        #24403#21069#24211#23384
        #36865'    '#24067
        #26085'    '#25253
        #36820#24037#26085#25253
        #30424#28857'('#21345#21495')'
        #30424#28857'('#21697#21517')')
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 387
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object cxgridFabricReport: TcxGrid
      Left = 0
      Top = 0
      Width = 764
      Height = 387
      Align = alClient
      TabOrder = 0
      object cxgridtvFabricReport: TcxGridDBTableView
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
      end
      object cxGridlFabricReport: TcxGridLevel
        GridView = cxgridtvFabricReport
      end
    end
  end
  object dsFabricReport: TDataSource
    DataSet = cdsFabricReport
    Left = 120
    Top = 160
  end
  object cdsFabricReport: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 160
  end
end

inherited BaseDataForm: TBaseDataForm
  Left = 270
  Top = 153
  Caption = #23383#20856#32500#25252
  OldCreateOrder = True
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 12
  object cxg1: TcxGrid
    Left = 0
    Top = 0
    Width = 688
    Height = 416
    Align = alClient
    TabOrder = 0
    object cxgtvTable: TcxGridDBTableView
      DataController.DataSource = dsTable
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OnFocusedItemChanged = cxgtvTableFocusedItemChanged
      OptionsData.Appending = True
      OptionsView.GroupByBox = False
    end
    object cxglvTable: TcxGridLevel
      GridView = cxgtvTable
    end
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 416
    Width = 688
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnQuery: TSpeedButton
      Left = 231
      Top = 5
      Width = 82
      Height = 28
      Caption = #26597#35810'(&Q)'
      Flat = True
      OnClick = btnQueryClick
    end
    object btnSave: TSpeedButton
      Left = 405
      Top = 5
      Width = 81
      Height = 28
      Caption = #20445#23384'(&S)'
      Flat = True
      OnClick = btnSaveClick
    end
    object btn_Exit: TSpeedButton
      Left = 874
      Top = 5
      Width = 81
      Height = 28
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btn_ExitClick
    end
    object btnDelete: TSpeedButton
      Left = 493
      Top = 5
      Width = 81
      Height = 28
      Caption = #21024#38500'(&D)'
      Flat = True
      OnClick = btnDeleteClick
    end
    object btnAdd: TSpeedButton
      Left = 318
      Top = 5
      Width = 81
      Height = 28
      Caption = #22686#21152'(&A)'
      Flat = True
      OnClick = btnAddClick
    end
    object btnCancel: TSpeedButton
      Left = 579
      Top = 5
      Width = 81
      Height = 28
      Caption = #21462#28040'(&C)'
      Flat = True
      OnClick = btnCancelClick
    end
    object cbbTableName: TcxComboBox
      Left = 24
      Top = 8
      Width = 201
      Height = 21
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      TabOrder = 0
      Text = #35831#36873#25321#23383#20856#34920
    end
  end
  object cdsTable: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 48
  end
  object dsTable: TDataSource
    DataSet = cdsTable
    Left = 88
    Top = 48
  end
  object cdsTableName: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 184
  end
end

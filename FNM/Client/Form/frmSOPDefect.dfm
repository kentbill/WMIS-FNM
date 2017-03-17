object SOPDefectForm: TSOPDefectForm
  Left = 240
  Top = 141
  Width = 677
  Height = 433
  Caption = 'SOP'#38169#39033
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grp1: TGroupBox
    Left = 0
    Top = 0
    Width = 669
    Height = 369
    Align = alClient
    Caption = 'SOP'#26816#26597
    TabOrder = 0
    object cxgrdSOPDefect: TcxGrid
      Left = 2
      Top = 15
      Width = 665
      Height = 352
      Align = alClient
      TabOrder = 0
      object cxgridtvSOPDefect: TcxGridDBTableView
        DataController.DataSource = dsSOPDefect
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnFocusedItemChanged = cxgridtvSOPDefectFocusedItemChanged
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
      end
      object cxgrdlvlGridlSOPDefect: TcxGridLevel
        GridView = cxgridtvSOPDefect
      end
    end
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 369
    Width = 669
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnQuery: TSpeedButton
      Left = 447
      Top = 5
      Width = 82
      Height = 28
      Caption = #26597#35810'(&Q)'
      Flat = True
      OnClick = btnQueryClick
    end
    object btnSave: TSpeedButton
      Left = 621
      Top = 5
      Width = 81
      Height = 28
      Caption = #20445#23384'(&S)'
      Flat = True
      OnClick = btnSaveClick
    end
    object btn_Exit: TSpeedButton
      Left = 882
      Top = 5
      Width = 81
      Height = 28
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btn_ExitClick
    end
    object btnDelete: TSpeedButton
      Left = 709
      Top = 5
      Width = 81
      Height = 28
      Caption = #21024#38500'(&D)'
      Flat = True
      OnClick = btnDeleteClick
    end
    object btnAdd: TSpeedButton
      Left = 534
      Top = 5
      Width = 81
      Height = 28
      Caption = #22686#21152'(&A)'
      Flat = True
      OnClick = btnAddClick
    end
    object btnCancel: TSpeedButton
      Left = 795
      Top = 5
      Width = 81
      Height = 28
      Caption = #21462#28040'(&C)'
      Flat = True
      OnClick = btnCancelClick
    end
    object txt_Only: TStaticText
      Left = 182
      Top = 16
      Width = 31
      Height = 17
      Caption = #26085#26399':'
      TabOrder = 0
    end
    object dtpDate: TDateTimePicker
      Left = 217
      Top = 9
      Width = 113
      Height = 20
      CalAlignment = dtaLeft
      Date = 40459.4370261574
      Time = 40459.4370261574
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object dtpEnd: TDateTimePicker
      Left = 329
      Top = 9
      Width = 114
      Height = 20
      CalAlignment = dtaLeft
      Date = 40459.4370261574
      Time = 40459.4370261574
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
    object cxtWorkerID: TcxTextEdit
      Left = 49
      Top = 9
      Width = 131
      Height = 21
      Hint = #21592#24037#21345#21495
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
  end
  object cdsSOPDefect: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 200
  end
  object dsSOPDefect: TDataSource
    DataSet = cdsSOPDefect
    Left = 216
    Top = 192
  end
  object cdsFillItems: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 328
  end
end

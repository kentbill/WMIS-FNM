inherited ShrinkageAnalysiForm: TShrinkageAnalysiForm
  Left = 45
  Top = 81
  Width = 736
  Caption = #32553#27700#29575#24322#24120#20998#26512
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlBottom: TPanel
    Left = 0
    Top = 421
    Width = 728
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      728
      32)
    object btnSave: TSpeedButton
      Left = 552
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #20445#23384'(&S)'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      OnClick = btnSaveClick
    end
    object btnClose: TSpeedButton
      Left = 637
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnCloseClick
    end
    object lbl2: TLabel
      Left = 15
      Top = 15
      Width = 54
      Height = 12
      Caption = #32553#27700#21407#22240':'
    end
    object btnBatch: TSpeedButton
      Left = 430
      Top = 5
      Width = 90
      Height = 25
      Caption = #25209#22788#29702'(&B)'
      Flat = True
      OnClick = btnBatchClick
    end
    object edtReason: TEdit
      Left = 72
      Top = 7
      Width = 353
      Height = 20
      TabOrder = 0
    end
  end
  object cxgdShrinkage: TcxGrid
    Left = 0
    Top = 31
    Width = 728
    Height = 390
    Align = alClient
    TabOrder = 1
    object cxdbgtvShrinkage: TcxGridDBTableView
      DataController.DataSource = dsShrinkage
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OnCustomDrawCell = cxdbgtvShrinkageCustomDrawCell
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsView.GroupByBox = False
    end
    object cxGridlShrinkage: TcxGridLevel
      GridView = cxdbgtvShrinkage
    end
  end
  object pnltop: TPanel
    Left = 0
    Top = 0
    Width = 728
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object btnQuery: TSpeedButton
      Left = 402
      Top = 3
      Width = 75
      Height = 25
      Caption = #26597#35810'(&Q)'
      Flat = True
      OnClick = btnQueryClick
    end
    object lbl3: TLabel
      Left = 16
      Top = 15
      Width = 54
      Height = 12
      Caption = #24320#22987#26102#38388':'
    end
    object lbl4: TLabel
      Left = 211
      Top = 15
      Width = 54
      Height = 12
      Caption = #32467#26463#26102#38388':'
    end
    object dtpBegin_Date: TDateTimePicker
      Left = 76
      Top = 7
      Width = 125
      Height = 20
      CalAlignment = dtaLeft
      Date = 38301.5052943634
      Time = 38301.5052943634
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object dtpEnd_Date: TDateTimePicker
      Left = 272
      Top = 7
      Width = 125
      Height = 20
      CalAlignment = dtaLeft
      Date = 38301.5052943634
      Time = 38301.5052943634
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
  end
  object cdsShrinkage: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 3
    Top = 365
  end
  object dsShrinkage: TDataSource
    DataSet = cdsShrinkage
    Left = 34
    Top = 365
  end
end

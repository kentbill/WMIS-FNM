inherited EditSpecialOTDForm: TEditSpecialOTDForm
  Left = 7
  Top = 21
  Width = 722
  Align = alTop
  Caption = #32534#36753'OTD'#21697#31181
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlValue: TPanel
    Left = 0
    Top = 417
    Width = 714
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      714
      36)
    object btnSave: TBitBtn
      Left = 555
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnClose: TBitBtn
      Left = 635
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object btnUpdateOTD: TBitBtn
      Left = 475
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #26356#26032'OTD'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnUpdateOTDClick
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 714
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lbl3: TLabel
      Left = 24
      Top = 13
      Width = 54
      Height = 12
      Caption = #24320#22987#26102#38388':'
    end
    object lbl4: TLabel
      Left = 240
      Top = 13
      Width = 54
      Height = 12
      Caption = #32467#26463#26102#38388':'
    end
    object btnBitQueryDelayOTD1: TBitBtn
      Left = 540
      Top = 0
      Width = 75
      Height = 25
      Caption = #26597#35810'(&Q)'
      Default = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnBitQueryDelayOTD1Click
    end
    object dtpBegin_Date: TDateTimePicker
      Left = 84
      Top = 5
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
    object dtpEnd_Date: TDateTimePicker
      Left = 301
      Top = 5
      Width = 125
      Height = 20
      CalAlignment = dtaLeft
      Date = 38301.5052943634
      Time = 38301.5052943634
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
    object chkStatus: TCheckBox
      Left = 441
      Top = 6
      Width = 98
      Height = 19
      Caption = #25353#23436#25104#26085#26399
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object cxgdDelayOTD1: TcxGrid
    Left = 0
    Top = 32
    Width = 714
    Height = 385
    Align = alClient
    TabOrder = 2
    object cxGridDBtvDelayOTD: TcxGridDBTableView
      DataController.DataSource = dsDelayOTD
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OnCustomDrawCell = cxGridDBtvDelayOTDCustomDrawCell
      OptionsView.Footer = True
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBtvDelayOTD
    end
  end
  object cxgpmOTD: TcxGridPopupMenu
    PopupMenus = <>
    Left = 592
    Top = 160
  end
  object dsDelayOTD: TDataSource
    DataSet = cdsDelayOTD
    Left = 104
    Top = 144
  end
  object cdsDelayOTD: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 104
    Top = 112
  end
end

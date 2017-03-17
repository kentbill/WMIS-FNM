object ScrapInfoForm: TScrapInfoForm
  Left = 386
  Top = 131
  Width = 943
  Height = 531
  Caption = #24223#24323#24067#20449#24687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 935
    Height = 65
    Align = alTop
    TabOrder = 0
    object lblBeginDate: TLabel
      Left = 28
      Top = 24
      Width = 60
      Height = 13
      Caption = #24320#22987#26102#38388#65306
    end
    object lblEndDate: TLabel
      Left = 219
      Top = 24
      Width = 60
      Height = 13
      Caption = #32467#26463#26102#38388#65306
    end
    object btnQuery: TButton
      Left = 430
      Top = 18
      Width = 65
      Height = 25
      Caption = #26597#35810'(&Q)'
      TabOrder = 0
      OnClick = btnQueryClick
    end
    object dtpEnd: TDateTimePicker
      Left = 288
      Top = 21
      Width = 97
      Height = 20
      CalAlignment = dtaLeft
      Date = 41082.9555707292
      Time = 41082.9555707292
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object dtpBegin: TDateTimePicker
      Left = 94
      Top = 20
      Width = 99
      Height = 20
      BevelEdges = []
      CalAlignment = dtaLeft
      Date = 38221.9555707292
      Time = 38221.9555707292
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 65
    Width = 935
    Height = 432
    Align = alClient
    TabOrder = 1
    object cxgridScrapInfo: TcxGrid
      Left = 2
      Top = 15
      Width = 931
      Height = 415
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object cxgridtvScrapInfo: TcxGridDBTableView
        DataController.DataSource = dsScrapInfo
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsCustomize.ColumnFiltering = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfAlwaysVisible
      end
      object cxGridlScrapInfo: TcxGridLevel
        GridView = cxgridtvScrapInfo
      end
    end
  end
  object cdsScrapInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 160
  end
  object dsScrapInfo: TDataSource
    DataSet = cdsScrapInfo
    Left = 144
    Top = 160
  end
end

object OTDTraceForm: TOTDTraceForm
  Left = 86
  Top = 159
  Width = 1280
  Height = 480
  Caption = 'OTD'#36827#24230#36319#36394
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
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object gbBottom: TGroupBox
    Left = 0
    Top = 381
    Width = 1272
    Height = 65
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      1272
      65)
    object btnQuery: TButton
      Left = 78
      Top = 23
      Width = 65
      Height = 25
      Caption = #26597#35810'(&Q)'
      TabOrder = 0
      OnClick = btnQueryClick
    end
    object btnSaveRemerk: TButton
      Left = 169
      Top = 23
      Width = 88
      Height = 25
      Caption = #20445#23384#22791#27880'(&S)'
      TabOrder = 1
      OnClick = btnSaveRemerkClick
    end
    object Button1: TButton
      Left = 1094
      Top = 23
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #36864#20986
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object gbClient: TGroupBox
    Left = 0
    Top = 0
    Width = 1272
    Height = 381
    Align = alClient
    TabOrder = 1
    object cxgrid_OTDTrace: TcxGrid
      Left = 2
      Top = 15
      Width = 1268
      Height = 364
      Align = alClient
      TabOrder = 0
      RootLevelOptions.DetailTabsPosition = dtpTop
      object cxgridtv_OTDTrace: TcxGridDBTableView
        DataController.DataSource = dsOTDInfo
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
      end
      object cxGridl_OTDTrace: TcxGridLevel
        GridView = cxgridtv_OTDTrace
        Options.DetailTabsPosition = dtpTop
      end
    end
  end
  object dsOTDInfo: TDataSource
    DataSet = cdsOTDInfo
    Left = 136
    Top = 144
  end
  object cdsOTDInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 144
  end
end

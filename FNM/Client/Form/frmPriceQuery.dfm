object PriceQueryForm: TPriceQueryForm
  Left = 147
  Top = 178
  Width = 928
  Height = 480
  Caption = #22870#32602'/'#38169#39033#26597#35810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 16
      Width = 60
      Height = 13
      Caption = #21592#24037#21345#21495#65306
    end
    object Label2: TLabel
      Left = 280
      Top = 16
      Width = 60
      Height = 13
      Caption = #24320#22987#26102#38388#65306
    end
    object edtWorkID: TEdit
      Left = 103
      Top = 12
      Width = 145
      Height = 21
      TabOrder = 0
    end
    object btnQuery: TButton
      Left = 792
      Top = 13
      Width = 73
      Height = 25
      Caption = #26597#35810'(&Q)'
      TabOrder = 1
      OnClick = btnQueryClick
    end
    object dtpDate: TDateTimePicker
      Left = 352
      Top = 11
      Width = 161
      Height = 20
      CalAlignment = dtaLeft
      Date = 40497.4241688773
      Time = 40497.4241688773
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 400
    Width = 912
    Height = 42
    Align = alBottom
    TabOrder = 1
    object btnExit: TButton
      Left = 802
      Top = 10
      Width = 73
      Height = 25
      Caption = #36864#20986'(&C)'
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 49
    Width = 912
    Height = 351
    Align = alClient
    TabOrder = 2
    object cxgridPrice: TcxGrid
      Left = 1
      Top = 1
      Width = 910
      Height = 349
      Align = alClient
      TabOrder = 0
      object cxgridtvPrice: TcxGridDBTableView
        DataController.DataSource = dsPrice
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.GroupByBox = False
      end
      object cxgridlPrice: TcxGridLevel
        GridView = cxgridtvPrice
      end
    end
  end
  object dsPrice: TDataSource
    DataSet = cdsPrice
    Left = 184
    Top = 88
  end
  object cdsPrice: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 88
  end
end

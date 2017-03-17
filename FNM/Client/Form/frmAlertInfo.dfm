object AlertInfoForm: TAlertInfoForm
  Left = 320
  Top = 207
  Width = 928
  Height = 480
  Caption = #25253#35686#20449#24687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 920
    Height = 57
    Align = alTop
    TabOrder = 0
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 57
    Width = 920
    Height = 389
    Align = alClient
    TabOrder = 1
    object cxgridAlertInfo: TcxGrid
      Left = 2
      Top = 15
      Width = 916
      Height = 372
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object cxgridtvAlertInfo: TcxGridDBTableView
        DataController.DataSource = dsAlertInfo
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
      object cxGridlAlertInfo: TcxGridLevel
        GridView = cxgridtvAlertInfo
      end
    end
  end
  object cdsAlertInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 152
  end
  object dsAlertInfo: TDataSource
    DataSet = cdsAlertInfo
    Left = 272
    Top = 152
  end
end

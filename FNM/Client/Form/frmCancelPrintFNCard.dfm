inherited CancePrintFNCardForm: TCancePrintFNCardForm
  Left = 272
  Top = 108
  Width = 569
  Height = 375
  Caption = #21462#28040#25171#21345
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object cxgridFNCard: TcxGrid
    Left = 0
    Top = 0
    Width = 561
    Height = 310
    Align = alClient
    TabOrder = 0
    object cxgridtvFNCard: TcxGridDBTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
    end
    object cxGridlFNCard: TcxGridLevel
      GridView = cxgridtvFNCard
    end
  end
  object TPanel
    Left = 0
    Top = 310
    Width = 561
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object pnl1: TPanel
      Left = 0
      Top = 4
      Width = 561
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        561
        34)
      object lblFNCard: TLabel
        Left = 16
        Top = 18
        Width = 30
        Height = 12
        Caption = #21345#21495':'
      end
      object btnClose: TSpeedButton
        Left = 474
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
      object btnCancel: TSpeedButton
        Left = 386
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
        Enabled = False
        Flat = True
        OnClick = btnCancelClick
      end
      object btnQuery: TSpeedButton
        Left = 175
        Top = 5
        Width = 75
        Height = 25
        Caption = #26597#35810'(&Q)'
        Flat = True
        OnClick = btnQueryClick
      end
      object edtFNCard: TEdit
        Left = 48
        Top = 10
        Width = 121
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 0
      end
    end
  end
  object cdsFNCard: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 280
  end
  object dsFNCard: TDataSource
    DataSet = cdsFNCard
    Left = 8
    Top = 280
  end
end

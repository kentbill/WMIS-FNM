object DistributeTerminalForm: TDistributeTerminalForm
  Left = 121
  Top = 148
  Width = 812
  Height = 462
  Caption = #20998#24067
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  Scaled = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 369
    Align = alClient
    TabOrder = 0
    object cxgridStockInfo: TcxGrid
      Left = 1
      Top = 1
      Width = 802
      Height = 367
      Align = alClient
      TabOrder = 0
      object cxgridtvStockInfo: TcxGridDBTableView
        DataController.DataSource = dsStockInfo
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = cxgridtvStockInfoCustomDrawCell
        OnFocusedRecordChanged = cxgridtvStockInfoFocusedRecordChanged
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.MultiSelect = True
      end
      object cxGridlcxgrid2Level1: TcxGridLevel
        GridView = cxgridtvStockInfo
      end
    end
  end
  object TPanel
    Left = 0
    Top = 369
    Width = 804
    Height = 66
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object pnlNormalTop: TPanel
      Left = 2
      Top = -2
      Width = 800
      Height = 66
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        800
        66)
      object lbl2: TLabel
        Left = 5
        Top = 11
        Width = 54
        Height = 12
        Caption = #22383#24067#26469#28304':'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object btnRefresh: TSpeedButton
        Left = 408
        Top = 34
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object lblCar_NO: TLabel
        Left = 298
        Top = 22
        Width = 42
        Height = 12
        Caption = #36710#29260#21495':'
      end
      object btnEdit: TSpeedButton
        Left = 486
        Top = 33
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20998#24067'(&M)'
        Flat = True
        OnClick = btnEditClick
      end
      object btnCancel: TSpeedButton
        Left = 565
        Top = 33
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #25764#28040#20998#24067'(&C)'
        Enabled = False
        Flat = True
        OnClick = btnCancelClick
      end
      object btnSave: TSpeedButton
        Left = 643
        Top = 33
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btnSaveClick
      end
      object btnClose: TSpeedButton
        Left = 721
        Top = 33
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
      object lbl: TLabel
        Left = 106
        Top = 12
        Width = 54
        Height = 12
        Caption = #20998#24067#20154#21592':'
      end
      object cbbNormal: TComboBox
        Left = 4
        Top = 32
        Width = 137
        Height = 20
        ItemHeight = 12
        TabOrder = 1
        OnSelect = cbbNormalSelect
      end
      object edtCar_NO: TEdit
        Left = 341
        Top = 14
        Width = 68
        Height = 20
        MaxLength = 3
        TabOrder = 0
      end
      object chkIncludeCarNO: TCheckBox
        Left = 298
        Top = 42
        Width = 97
        Height = 17
        Caption = #21547#24050#26377#36710#29260#21495
        TabOrder = 2
      end
      object lstOperator: TListBox
        Left = 162
        Top = 5
        Width = 123
        Height = 57
        ItemHeight = 12
        TabOrder = 3
      end
    end
  end
  object cdsStockInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 55
    Top = 47
  end
  object dsStockInfo: TDataSource
    DataSet = cdsStockInfo
    Left = 112
    Top = 48
  end
end

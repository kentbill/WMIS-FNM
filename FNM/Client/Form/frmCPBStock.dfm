inherited CPBStockForm: TCPBStockForm
  Left = 125
  Top = 67
  Width = 1079
  Height = 528
  Caption = 'CPB'#24211#23384#24067
  KeyPreview = False
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object Panel2: TPanel
    Left = 0
    Top = 456
    Width = 1063
    Height = 34
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      1063
      34)
    object btnImport: TSpeedButton
      Left = 420
      Top = 5
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #23548#20837'(&I)'
      Flat = True
      OnClick = btnImportClick
    end
    object btnSave: TSpeedButton
      Left = 647
      Top = 4
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      Flat = True
      OnClick = btnSaveClick
    end
    object btnExit: TSpeedButton
      Left = 723
      Top = 4
      Width = 70
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnExitClick
    end
    object btnRefresh: TSpeedButton
      Left = 346
      Top = 5
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #21047#26032'(&R)'
      Flat = True
      OnClick = btnRefreshClick
    end
    object btnDelete: TSpeedButton
      Left = 495
      Top = 5
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #21024#38500'(&D)'
      Flat = True
      OnClick = btnDeleteClick
    end
    object btnAdd: TSpeedButton
      Left = 572
      Top = 4
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #26032#22686'(&A)'
      Flat = True
      OnClick = btnAddClick
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 641
    Height = 456
    Align = alClient
    TabOrder = 1
    object cxGridDBTV: TcxGridDBTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGridDBTV
    end
  end
  object GroupBox1: TGroupBox
    Left = 649
    Top = 0
    Width = 414
    Height = 456
    Align = alRight
    Caption = #24403#21069#24211#23384
    TabOrder = 2
    object cxGrid2: TcxGrid
      Left = 2
      Top = 14
      Width = 410
      Height = 440
      Align = alClient
      TabOrder = 0
      object cxGridDBTVStock: TcxGridDBTableView
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTVStock
      end
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 641
    Top = 0
    Width = 8
    Height = 456
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salRight
    Control = GroupBox1
  end
  object pnlAdd: TPanel
    Left = 192
    Top = 112
    Width = 385
    Height = 217
    TabOrder = 4
    Visible = False
    DesignSize = (
      385
      217)
    object btnoK: TSpeedButton
      Left = 107
      Top = 179
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #30830' '#23450
      Flat = True
      OnClick = btnoKClick
    end
    object SpeedButton2: TSpeedButton
      Left = 211
      Top = 179
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20851' '#38381
      Flat = True
      OnClick = SpeedButton2Click
    end
    object Label1: TLabel
      Left = 49
      Top = 146
      Width = 72
      Height = 12
      Caption = 'Fabric_Type:'
    end
    object Label3: TLabel
      Left = 66
      Top = 119
      Width = 54
      Height = 12
      Caption = 'Quantity:'
    end
    object Label4: TLabel
      Left = 39
      Top = 87
      Width = 78
      Height = 12
      Caption = 'Construction:'
    end
    object Label5: TLabel
      Left = 82
      Top = 56
      Width = 36
      Height = 12
      Caption = 'GF_NO:'
    end
    object edtQuantity: TEdit
      Left = 125
      Top = 115
      Width = 170
      Height = 20
      TabOrder = 0
      OnKeyPress = edtQuantityKeyPress
    end
    object cbbFabric_Type: TComboBox
      Left = 125
      Top = 143
      Width = 170
      Height = 20
      ItemHeight = 12
      TabOrder = 1
      Items.Strings = (
        'EAP'
        'OXFORD'
        #24377#21147
        #22810#33218
        #26041#24179
        #33457#28784
        #26825#40635
        #24179#32441
        #24179#32441#30952#27611
        #20854#20182
        #22871#33394
        #26012#32441
        #26012#32441#30952#27611)
    end
    object edtConstruction: TEdit
      Left = 125
      Top = 83
      Width = 170
      Height = 20
      Color = clScrollBar
      Enabled = False
      TabOrder = 2
      OnKeyPress = edtQuantityKeyPress
    end
    object edtGF_NO: TEdit
      Left = 125
      Top = 51
      Width = 170
      Height = 20
      TabOrder = 3
      OnKeyPress = edtGF_NOKeyPress
    end
  end
  object adodsImport: TADODataSet
    Parameters = <>
    Left = 80
    Top = 208
  end
  object cdsCPBIn: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 112
  end
  object dsCPBIn: TDataSource
    DataSet = cdsCPBIn
    Left = 128
    Top = 136
  end
  object dsCPBStock: TDataSource
    Left = 960
    Top = 616
  end
  object cdsTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 528
    Top = 248
  end
end

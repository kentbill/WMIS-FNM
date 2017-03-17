inherited CPBChangeGFNOForm: TCPBChangeGFNOForm
  Left = 77
  Top = 93
  Width = 923
  Height = 520
  Caption = #30041#20301#25913#21697#21517
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 455
    Width = 915
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object pnlTop: TPanel
      Left = 0
      Top = 4
      Width = 915
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        915
        34)
      object btnRefresh: TSpeedButton
        Left = 641
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object btnSave: TSpeedButton
        Left = 737
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btnSaveClick
      end
      object btnClose: TSpeedButton
        Left = 830
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
    end
  end
  object TPanel
    Left = 0
    Top = 452
    Width = 915
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 432
    Top = 0
    Width = 483
    Height = 452
    Align = alClient
    Caption = #24211#23384#20449#24687
    TabOrder = 2
    object cxdbgUnSelect: TcxGrid
      Left = 2
      Top = 14
      Width = 479
      Height = 258
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object cxdbgtvUnSelect: TcxGridDBTableView
        OnKeyDown = cxdbgtvUnSelectKeyDown
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsView.GroupByBox = False
      end
      object cxGridlUnSelect: TcxGridLevel
        GridView = cxdbgtvUnSelect
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 2
      Top = 272
      Width = 479
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salTop
      Control = cxdbgUnSelect
    end
    object pnlCard: TPanel
      Left = 2
      Top = 280
      Width = 479
      Height = 170
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object pnl2: TPanel
        Left = 0
        Top = 0
        Width = 479
        Height = 35
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object btnAdd: TSpeedButton
          Left = 206
          Top = 6
          Width = 75
          Height = 25
          Caption = #28155#21152'(&A)'
          Flat = True
          OnClick = btnAddClick
        end
        object btnUp: TSpeedButton
          Left = 468
          Top = 6
          Width = 75
          Height = 25
          Caption = #20840#37096'(&U)'
          Flat = True
          OnClick = btnUpClick
        end
        object btnCancel: TSpeedButton
          Left = 380
          Top = 6
          Width = 75
          Height = 25
          Caption = #25764#28040'(&C)'
          Flat = True
          OnClick = btnCancelClick
        end
        object btnDown: TSpeedButton
          Left = 293
          Top = 7
          Width = 75
          Height = 25
          Caption = #20840#37096'(&D)'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          OnClick = btnDownClick
        end
      end
      object cxdbgSelect: TcxGrid
        Left = 0
        Top = 35
        Width = 479
        Height = 135
        Align = alClient
        TabOrder = 1
        object cxdbgtvSelect: TcxGridDBTableView
          OnKeyDown = cxdbgtvSelectKeyDown
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsView.GroupByBox = False
        end
        object cxGridlSelect: TcxGridLevel
          GridView = cxdbgtvSelect
        end
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 424
    Height = 452
    Align = alLeft
    Caption = #30041#20301#20449#24687
    TabOrder = 0
    object cxGrid1: TcxGrid
      Left = 2
      Top = 14
      Width = 420
      Height = 436
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object cxdbgtvReserved: TcxGridDBTableView
        OnKeyDown = cxdbgtvReservedKeyDown
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsView.GroupByBox = False
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxdbgtvReserved
      end
    end
  end
  object cxSplitter2: TcxSplitter
    Left = 424
    Top = 0
    Width = 8
    Height = 452
    HotZoneClassName = 'TcxXPTaskBarStyle'
    Control = GroupBox2
  end
  object cdsUnSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = cdsUnSelectFilterRecord
    Left = 449
    Top = 232
  end
  object dsUnSelect: TDataSource
    DataSet = cdsUnSelect
    Left = 479
    Top = 232
  end
  object cdsSelect: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnFilterRecord = cdsSelectFilterRecord
    Left = 440
    Top = 415
  end
  object dsSelect: TDataSource
    DataSet = cdsSelect
    Left = 473
    Top = 415
  end
  object cdsReserved: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = cdsUnSelectFilterRecord
    Left = 57
    Top = 221
  end
  object dsReserved: TDataSource
    DataSet = cdsReserved
    Left = 86
    Top = 221
  end
end

inherited CPBSignForm: TCPBSignForm
  Left = 339
  Top = 164
  Width = 865
  Height = 520
  Caption = #23548#20986#21040#21560#26009#26426
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 857
    Height = 452
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object pnlCard: TPanel
      Left = 2
      Top = 268
      Width = 853
      Height = 182
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object pnl2: TPanel
        Left = 0
        Top = 0
        Width = 853
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
          Left = 249
          Top = 5
          Width = 75
          Height = 25
          Caption = #28155#21152'(&A)'
          Flat = True
          OnClick = btnAddClick
        end
        object btnUp: TSpeedButton
          Left = 511
          Top = 5
          Width = 75
          Height = 25
          Caption = #20840#37096'(&U)'
          Flat = True
          OnClick = btnUpClick
        end
        object btnCancel: TSpeedButton
          Left = 423
          Top = 5
          Width = 75
          Height = 25
          Caption = #25764#28040'(&C)'
          Flat = True
          OnClick = btnCancelClick
        end
        object btnDown: TSpeedButton
          Left = 336
          Top = 6
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
        Width = 853
        Height = 147
        Align = alClient
        TabOrder = 1
        object cxdbgtvSelect: TcxGridDBTableView
          OnKeyDown = cxdbgtvSelectKeyDown
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxdbgtvSelectCustomDrawCell
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
    object cxSplitter1: TcxSplitter
      Left = 2
      Top = 260
      Width = 853
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salTop
      Control = cxdbgUnSelect
    end
    object cxdbgUnSelect: TcxGrid
      Left = 2
      Top = 2
      Width = 853
      Height = 258
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object cxdbgtvUnSelect: TcxGridDBTableView
        OnKeyDown = cxdbgtvUnSelectKeyDown
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = cxdbgtvUnSelectCustomDrawCell
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
  end
  object TPanel
    Left = 0
    Top = 455
    Width = 857
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object pnlTop: TPanel
      Left = 0
      Top = 4
      Width = 857
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        857
        34)
      object btnRefresh: TSpeedButton
        Left = 583
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object btnSave: TSpeedButton
        Left = 679
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #23548#20986'(&E)'
        Flat = True
        OnClick = btnSaveClick
      end
      object btnClose: TSpeedButton
        Left = 772
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
      object Label13: TLabel
        Left = 13
        Top = 9
        Width = 30
        Height = 12
        Caption = #37197#26041':'
      end
      object btnExport: TSpeedButton
        Left = 182
        Top = 2
        Width = 108
        Height = 25
        Caption = #37325#26032#23548#20837#21560#26009#26426
        Flat = True
        OnClick = btnExportClick
      end
      object Label1: TLabel
        Left = 305
        Top = 10
        Width = 216
        Height = 12
        Caption = #25552#31034':'#36716#26723#38656#35201#26102#38388','#35831#38388#38548#12304'10'#31186#12305#23548#20986
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object edtRCP: TEdit
        Left = 45
        Top = 4
        Width = 130
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 0
      end
    end
  end
  object TPanel
    Left = 0
    Top = 452
    Width = 857
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object cdsUnSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = cdsUnSelectFilterRecord
    Left = 4
    Top = 229
  end
  object dsUnSelect: TDataSource
    DataSet = cdsUnSelect
    Left = 34
    Top = 229
  end
  object cdsSelect: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnFilterRecord = cdsSelectFilterRecord
    Left = 8
    Top = 423
  end
  object dsSelect: TDataSource
    DataSet = cdsSelect
    Left = 41
    Top = 423
  end
end

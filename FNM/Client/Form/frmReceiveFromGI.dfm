object ReceiveFromGIForm: TReceiveFromGIForm
  Left = 389
  Top = 280
  Width = 778
  Height = 535
  Caption = #30452#25509#25509#25910#22383#24067
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 608
    Height = 464
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object pnlCard: TPanel
      Left = 0
      Top = 275
      Width = 608
      Height = 189
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object pnl2: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 35
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object btnAdd: TSpeedButton
          Left = 106
          Top = 5
          Width = 75
          Height = 25
          Caption = #28155#21152'(&A)'
          Flat = True
          OnClick = btnAddClick
        end
        object btnUp: TSpeedButton
          Left = 432
          Top = 5
          Width = 75
          Height = 25
          Caption = #20840#37096'(&U)'
          Flat = True
          OnClick = btnUpClick
        end
        object btnCancel: TSpeedButton
          Left = 324
          Top = 5
          Width = 75
          Height = 25
          Caption = #25764#28040'(&C)'
          Flat = True
          OnClick = btnCancelClick
        end
        object btnDown: TSpeedButton
          Left = 215
          Top = 5
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
        Width = 608
        Height = 154
        Align = alClient
        TabOrder = 1
        object cxdbgtvSelect: TcxGridDBTableView
          OnKeyDown = cxdbgtvSelectKeyDown
          DataController.DataSource = dsSelect
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
        object cxGridlSelect: TcxGridLevel
          GridView = cxdbgtvSelect
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 0
      Top = 267
      Width = 608
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salBottom
      Control = pnlCard
    end
    object cxdbgUnSelect: TcxGrid
      Left = 0
      Top = 0
      Width = 608
      Height = 267
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object cxdbgtvUnSelect: TcxGridDBTableView
        OnKeyDown = cxdbgtvUnSelectKeyDown
        DataController.DataSource = dsUnSelect
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
      end
      object cxGridlUnSelect: TcxGridLevel
        GridView = cxdbgtvUnSelect
      end
    end
    object lstFabricNO: TListBox
      Left = 3
      Top = 113
      Width = 86
      Height = 80
      ItemHeight = 12
      TabOrder = 3
      Visible = False
    end
  end
  object TPanel
    Left = 0
    Top = 467
    Width = 770
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object TPanel
      Left = 0
      Top = 0
      Width = 770
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        770
        34)
      object btnSave: TSpeedButton
        Left = 591
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        OnClick = btnSaveClick
      end
      object btnClose: TSpeedButton
        Left = 679
        Top = 4
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
      object btnRefresh: TSpeedButton
        Left = 461
        Top = 4
        Width = 75
        Height = 25
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object lbl2: TLabel
        Left = 174
        Top = 15
        Width = 54
        Height = 12
        Caption = #22383#24067#26469#28304':'
      end
      object lbl1: TLabel
        Left = 8
        Top = 17
        Width = 30
        Height = 12
        Caption = #37096#38376':'
      end
      object cbbSource: TComboBox
        Left = 231
        Top = 9
        Width = 143
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 0
      end
      object cbbCurrentDept: TComboBox
        Left = 41
        Top = 9
        Width = 125
        Height = 20
        Hint = #24403#21069#24212#29992#31243#24207#27491#22312#25805#20316#30340#37096#38376
        ItemHeight = 12
        TabOrder = 1
      end
      object cbFinish: TCheckBox
        Left = 384
        Top = 8
        Width = 71
        Height = 17
        Hint = #22383#24067#24050#22815#25968
        Caption = #38598#20013#25972#29702
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 2
      end
    end
  end
  object TPanel
    Left = 0
    Top = 464
    Width = 770
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object reFormula: TRichEdit
    Left = 616
    Top = 0
    Width = 154
    Height = 464
    Align = alClient
    Color = clMenu
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object cxSpLeft: TcxSplitter
    Left = 608
    Top = 0
    Width = 8
    Height = 464
    HotZoneClassName = 'TcxXPTaskBarStyle'
    Control = pnlClient
    OnMoved = cxSpLeftMoved
  end
  object cdsUnSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = cdsUnSelectFilterRecord
    Left = 375
    Top = 70
  end
  object dsUnSelect: TDataSource
    DataSet = cdsUnSelect
    Left = 446
    Top = 69
  end
  object cdsSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = cdsSelectFilterRecord
    Left = 43
    Top = 365
  end
  object dsSelect: TDataSource
    DataSet = cdsSelect
    Left = 114
    Top = 365
  end
end

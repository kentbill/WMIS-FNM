inherited RSTraceForm: TRSTraceForm
  Left = 56
  Top = 99
  Width = 688
  Height = 451
  Caption = #36215#27611#24067#36827#24230#36319#36394
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlValue: TPanel
    Left = 0
    Top = 388
    Width = 680
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      680
      36)
    object btnClose: TBitBtn
      Left = 601
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnQuery: TBitBtn
      Left = 521
      Top = 8
      Width = 75
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = #26597#35810'(&Q)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnQueryClick
    end
  end
  object cxspl2: TcxSplitter
    Left = 400
    Top = 0
    Width = 8
    Height = 388
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salRight
    Control = GroupBox2
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 400
    Height = 388
    Align = alClient
    Caption = #23450#21333#26126#32454
    TabOrder = 2
    object cxGrid1: TcxGrid
      Left = 2
      Top = 14
      Width = 396
      Height = 372
      Align = alClient
      TabOrder = 0
      object cxGridTVRSTrace: TcxGridDBTableView
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.Appending = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGridTVRSTrace
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 408
    Top = 0
    Width = 272
    Height = 388
    Align = alRight
    Caption = #32534#36753#36215#27611#27425#25968
    TabOrder = 3
    object Panel2: TPanel
      Left = 2
      Top = 351
      Width = 268
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        268
        35)
      object btnSave: TBitBtn
        Left = 190
        Top = 6
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnSaveClick
      end
      object chbRefresh: TCheckBox
        Left = 6
        Top = 11
        Width = 110
        Height = 17
        Caption = #20445#23384#21518#21450#26102#21047#26032
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object cxGrid2: TcxGrid
      Left = 2
      Top = 14
      Width = 268
      Height = 337
      Align = alClient
      TabOrder = 1
      object cxGridTVEditRSTrace: TcxGridDBTableView
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridTVEditRSTrace
      end
    end
  end
  object dsRSTrace: TDataSource
    DataSet = cdsRSTrace
    Left = 104
    Top = 144
  end
  object cdsRSTrace: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 104
    Top = 112
  end
  object cdsEditRsTrace: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 456
    Top = 120
  end
  object dsEditRSTrace: TDataSource
    DataSet = cdsEditRsTrace
    Left = 456
    Top = 152
  end
end

object InnerRepairCheckForm: TInnerRepairCheckForm
  Left = 40
  Top = 114
  Width = 790
  Height = 408
  Caption = #20869#22238#20462#25968#25454#30830#35748
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 347
    Width = 782
    Height = 34
    Align = alBottom
    AutoSize = True
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object pnl_Only: TPanel
      Left = 2
      Top = 2
      Width = 778
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object btn_Help: TSpeedButton
        Left = 8
        Top = 5
        Width = 75
        Height = 22
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
      end
      object btn_Query: TSpeedButton
        Left = 229
        Top = 5
        Width = 75
        Height = 22
        Caption = #26597#35810'(&Q)'
        Flat = True
        OnClick = btn_QueryClick
      end
      object btn_Save: TSpeedButton
        Left = 608
        Top = 5
        Width = 75
        Height = 22
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveClick
      end
      object btn_Exit: TSpeedButton
        Left = 694
        Top = 5
        Width = 75
        Height = 22
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
      object txt_Only: TStaticText
        Left = 91
        Top = 11
        Width = 34
        Height = 16
        Caption = #26085#26399':'
        TabOrder = 0
      end
      object dtp_OperateTime: TDateTimePicker
        Left = 120
        Top = 7
        Width = 105
        Height = 20
        CalAlignment = dtaLeft
        Date = 38845.4370261574
        Time = 38845.4370261574
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
        OnChange = dtp_OperateTimeChange
      end
    end
  end
  object TPanel
    Left = 0
    Top = 344
    Width = 782
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 316
    Width = 782
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btn_Ignore: TSpeedButton
      Left = 696
      Top = 5
      Width = 75
      Height = 22
      Caption = #24573#30053'(&I)'
      Flat = True
      OnClick = btn_IgnoreClick
    end
    object Label1: TLabel
      Left = 10
      Top = 14
      Width = 48
      Height = 12
      Caption = #22791#27880'(&R):'
      FocusControl = edt_Remark
    end
    object edt_Remark: TEdit
      Left = 74
      Top = 6
      Width = 611
      Height = 20
      TabOrder = 0
    end
  end
  object cxgrid_FabricData: TcxGrid
    Left = 0
    Top = 0
    Width = 782
    Height = 316
    Align = alClient
    TabOrder = 3
    object cxgridtv_FabricData: TcxGridDBTableView
      DataController.DataSource = ds_FabricData
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
    end
    object cxGridl_FabricData: TcxGridLevel
      GridView = cxgridtv_FabricData
    end
  end
  object cds_FabricData: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cds_FabricDataAfterScroll
    Left = 253
    Top = 281
  end
  object ds_FabricData: TDataSource
    DataSet = cds_FabricData
    Left = 286
    Top = 282
  end
end

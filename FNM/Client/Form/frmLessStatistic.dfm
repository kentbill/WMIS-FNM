object LessStatisticForm: TLessStatisticForm
  Left = 163
  Top = 130
  Width = 902
  Height = 558
  Caption = #27424#25968#26597#35810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
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
  TextHeight = 13
  object cxgrid_LessStatistic: TcxGrid
    Left = 0
    Top = 49
    Width = 886
    Height = 385
    Align = alClient
    TabOrder = 0
    RootLevelOptions.DetailTabsPosition = dtpTop
    object cxgridtv_LessStatistic: TcxGridDBBandedTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OnCellClick = cxgridtv_LessStatisticCellClick
      Bands = <
        item
        end>
    end
    object cxGridl_LessStatistic: TcxGridLevel
      GridView = cxgridtv_LessStatistic
      Options.DetailTabsPosition = dtpTop
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 886
    Height = 49
    Align = alTop
    TabOrder = 1
    object btnQuery: TButton
      Left = 22
      Top = 15
      Width = 65
      Height = 25
      Caption = #26597#35810'(&Q)'
      TabOrder = 0
      OnClick = btnQueryClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 434
    Width = 886
    Height = 86
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      886
      86)
    object Label1: TLabel
      Left = 336
      Top = 16
      Width = 84
      Height = 13
      Caption = #35745#21010#23436#25104#26085#26399#65306
    end
    object Label2: TLabel
      Left = 577
      Top = 14
      Width = 39
      Height = 13
      Caption = ' '#32452#21035#65306
    end
    object Label3: TLabel
      Left = 338
      Top = 40
      Width = 36
      Height = 13
      Caption = #22791#27880#65306
    end
    object Button1: TButton
      Left = 811
      Top = 24
      Width = 73
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #36864#20986'(&C)'
      TabOrder = 0
      OnClick = Button1Click
    end
    object btnSave: TButton
      Left = 716
      Top = 24
      Width = 73
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #20445#23384'(&S)'
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 10
      Width = 305
      Height = 71
      TabOrder = 2
      Visible = False
      object lblBeginDate: TLabel
        Left = 4
        Top = 16
        Width = 60
        Height = 13
        Caption = #24320#22987#26102#38388#65306
      end
      object lblEndDate: TLabel
        Left = 3
        Top = 48
        Width = 60
        Height = 13
        Caption = #32467#26463#26102#38388#65306
      end
      object dtpBegin: TDateTimePicker
        Left = 70
        Top = 12
        Width = 99
        Height = 20
        BevelEdges = []
        CalAlignment = dtaLeft
        Date = 38221.9555707292
        Time = 38221.9555707292
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 0
      end
      object dtpEnd: TDateTimePicker
        Left = 71
        Top = 45
        Width = 97
        Height = 20
        CalAlignment = dtaLeft
        Date = 41082.9555707292
        Time = 41082.9555707292
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
      end
      object btnGetData: TButton
        Left = 176
        Top = 10
        Width = 121
        Height = 25
        Caption = #33719#21462#27424#25968#25968#25454'(&G)'
        TabOrder = 2
        OnClick = btnGetDataClick
      end
    end
    object edtPlanDate: TEdit
      Left = 435
      Top = 10
      Width = 137
      Height = 21
      TabOrder = 3
    end
    object edtGroup: TEdit
      Left = 619
      Top = 10
      Width = 102
      Height = 21
      TabOrder = 4
      Visible = False
    end
    object edtRemark: TEdit
      Left = 386
      Top = 35
      Width = 335
      Height = 21
      TabOrder = 5
    end
    object cbGroup: TComboBox
      Left = 616
      Top = 10
      Width = 102
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      Items.Strings = (
        #24037#33402
        #25805#20316
        #35745#21010
        #36136#37327)
    end
  end
  object cdsLessStatistic: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 608
    Top = 320
  end
  object dsLessStatistic: TDataSource
    DataSet = cdsLessStatistic
    Left = 648
    Top = 320
  end
  object cdsChange: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 352
    Top = 408
  end
end

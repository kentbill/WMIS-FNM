object EnergyQueryForm: TEnergyQueryForm
  Left = 401
  Top = 130
  Width = 930
  Height = 582
  Caption = #33021#28304#31649#29702#26597#35810
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
  object GroupBox1: TGroupBox
    Left = 177
    Top = 0
    Width = 553
    Height = 468
    Align = alClient
    TabOrder = 0
    object tbcStatistic: TTabControl
      Left = 2
      Top = 15
      Width = 549
      Height = 451
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      Tabs.Strings = (
        #25968#25454#34920
        #36235#21183#26354#32447
        #26609#29366#22270)
      TabIndex = 0
      OnChange = tbcStatisticChange
      object tdcStatistic: TDBChart
        Left = 4
        Top = 27
        Width = 539
        Height = 174
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          #33021#28304#31649#29702#32479#35745)
        Legend.LegendStyle = lsSeries
        View3D = False
        Align = alCustom
        BevelInner = bvLowered
        TabOrder = 0
        object Series1: TLineSeries
          Marks.ArrowLength = 8
          Marks.Style = smsValue
          Marks.Visible = False
          SeriesColor = clRed
          Title = #26368#21916#27426
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object Series2: TBarSeries
          Marks.ArrowLength = 20
          Marks.Style = smsValue
          Marks.Visible = True
          SeriesColor = clGreen
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Bar'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
      end
      object cxgrid_Statistic: TcxGrid
        Left = 8
        Top = 288
        Width = 529
        Height = 135
        Align = alCustom
        TabOrder = 1
        object cxgridtv_Statistic: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
        end
        object cxGridl_Statistic: TcxGridLevel
          GridView = cxgridtv_Statistic
        end
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 177
    Height = 468
    Align = alLeft
    TabOrder = 1
    object Label1: TLabel
      Left = 2
      Top = 15
      Width = 173
      Height = 16
      Align = alTop
      Caption = '                     '#26597#35810
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnHourReport: TBitBtn
      Left = 36
      Top = 107
      Width = 97
      Height = 33
      Caption = #23567#26102#25253#34920
      TabOrder = 0
      OnClick = btnHourReportClick
    end
    object btnClassReport: TBitBtn
      Left = 36
      Top = 158
      Width = 97
      Height = 33
      Caption = #29677#25253#26597#35810
      TabOrder = 1
      OnClick = btnClassReportClick
    end
    object btnDayReport: TBitBtn
      Left = 36
      Top = 210
      Width = 97
      Height = 33
      Caption = #26085#25253#26597#35810
      TabOrder = 2
      OnClick = btnDayReportClick
    end
    object btnWeekReport: TBitBtn
      Left = 36
      Top = 260
      Width = 97
      Height = 33
      Caption = #21608#25253#26597#35810
      TabOrder = 3
      OnClick = btnWeekReportClick
    end
    object btnMonthReport: TBitBtn
      Left = 36
      Top = 311
      Width = 97
      Height = 33
      Caption = #26376#25253#26597#35810
      TabOrder = 4
      OnClick = btnMonthReportClick
    end
    object btnWorngReport: TBitBtn
      Left = 36
      Top = 363
      Width = 97
      Height = 33
      Caption = #25925#38556#26597#35810
      TabOrder = 5
      OnClick = btnWorngReportClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 730
    Top = 0
    Width = 192
    Height = 468
    Align = alRight
    TabOrder = 2
    object Label2: TLabel
      Left = 2
      Top = 15
      Width = 188
      Height = 16
      Align = alTop
      Caption = '                 '#21464#37327#21015#34920
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 468
    Width = 922
    Height = 80
    Align = alBottom
    TabOrder = 3
    object Label3: TLabel
      Left = 200
      Top = 32
      Width = 60
      Height = 13
      Caption = #24320#22987#26102#38388#65306
    end
    object Label4: TLabel
      Left = 453
      Top = 33
      Width = 60
      Height = 13
      Caption = #32467#26463#26102#38388#65306
    end
    object edtBegin: TEdit
      Left = 264
      Top = 28
      Width = 161
      Height = 21
      TabOrder = 0
      Text = '2012-1-1 7:00:00'
    end
    object edtEnd: TEdit
      Left = 512
      Top = 28
      Width = 161
      Height = 21
      TabOrder = 1
      Text = '2012-1-1 7:00:00'
    end
    object cbCustom: TCheckBox
      Left = 72
      Top = 32
      Width = 113
      Height = 17
      Caption = #33258#23450#20041#26597#35810#26102#38388
      TabOrder = 2
    end
  end
  object dsStatistic: TDataSource
    DataSet = cdsStatistic
    Left = 664
    Top = 136
  end
  object cdsStatistic: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 664
    Top = 176
  end
end

inherited WIPQueryForm: TWIPQueryForm
  Left = 87
  Top = 65
  Width = 711
  Height = 451
  Caption = #24037#24207'WIP'
  OldCreateOrder = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCreate = nil
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 703
    Height = 292
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object dbchtOperationCode: TDBChart
      Left = 0
      Top = 0
      Width = 703
      Height = 292
      AllowPanning = pmNone
      AllowZoom = False
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      BackWall.Pen.Visible = False
      Title.Font.Charset = ANSI_CHARSET
      Title.Font.Color = clBlue
      Title.Font.Height = -12
      Title.Font.Name = #23435#20307
      Title.Font.Style = []
      Title.Text.Strings = (
        '')
      AxisVisible = False
      ClipPoints = False
      Frame.Visible = False
      Legend.TextStyle = ltsRightValue
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      View3DWalls = False
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Series4: TBarSeries
        Marks.ArrowLength = 20
        Marks.Visible = True
        SeriesColor = clRed
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1
        YValues.Order = loNone
      end
      object Series5: TPieSeries
        Marks.ArrowLength = 8
        Marks.Visible = True
        SeriesColor = clGreen
        OtherSlice.Text = 'Other'
        PieValues.DateTime = False
        PieValues.Name = 'Pie'
        PieValues.Multiplier = 1
        PieValues.Order = loNone
      end
      object Series6: TLineSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        SeriesColor = clYellow
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
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 383
    Width = 703
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      703
      41)
    object lbl1: TLabel
      Left = 248
      Top = 18
      Width = 30
      Height = 12
      Caption = #37096#38376':'
    end
    object btnClose: TBitBtn
      Left = 612
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      TabOrder = 3
      OnClick = btnCloseClick
    end
    object btnRefresh: TBitBtn
      Left = 452
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #21047#26032'(&R)'
      Default = True
      TabOrder = 1
      OnClick = btnRefreshClick
    end
    object rgSeriesType: TRadioGroup
      Left = 16
      Top = 0
      Width = 185
      Height = 33
      Caption = #22270#24418
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        #26609#22411
        #39292#22411
        #32447#22411)
      TabOrder = 0
      OnClick = rgSeriesTypeClick
    end
    object btnExport: TBitBtn
      Left = 532
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #23548#20986'(&E)'
      TabOrder = 2
      OnClick = btnExportClick
    end
    object chk3D: TCheckBox
      Left = 208
      Top = 14
      Width = 38
      Height = 17
      Caption = '3D'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = chk3DClick
    end
    object cbbCurrentDept: TComboBox
      Left = 281
      Top = 11
      Width = 130
      Height = 20
      Hint = #24403#21069#24212#29992#31243#24207#27491#22312#25805#20316#30340#37096#38376
      ItemHeight = 12
      TabOrder = 5
    end
  end
  object cxsplTop: TcxSplitter
    Left = 0
    Top = 292
    Width = 703
    Height = 8
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salTop
    Control = pnlTop
  end
  object pnlClient: TPanel
    Left = 0
    Top = 300
    Width = 703
    Height = 83
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object cxgridWIP: TcxGrid
      Left = 0
      Top = 0
      Width = 703
      Height = 83
      Align = alClient
      TabOrder = 0
      object cxgridtvWIP: TcxGridDBTableView
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = cxgridtvWIPCustomDrawCell
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
      end
      object cxGridlWIP: TcxGridLevel
        GridView = cxgridtvWIP
      end
    end
  end
  object dsWIPDetail: TDataSource
    DataSet = cdsWIPDetail
    Left = 112
    Top = 224
  end
  object cdsWIPDetail: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 224
  end
  object cdsWIPOperationCode: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 192
  end
  object dlgSaveDlg: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'Bmp File(*.bmp)|*.bmp|All File(*.*)|*.*'
    Left = 288
    Top = 128
  end
end

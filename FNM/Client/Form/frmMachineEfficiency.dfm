object MachineEfficiencyForm: TMachineEfficiencyForm
  Left = 168
  Top = 129
  Width = 669
  Height = 404
  Caption = #26426#21488#25928#29575#20998#26512
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object pnl_Only: TPanel
    Left = 0
    Top = 325
    Width = 661
    Height = 52
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 48
      Height = 12
      Caption = #26426#21488'(&M):'
    end
    object Label2: TLabel
      Left = 8
      Top = 34
      Width = 48
      Height = 12
      Caption = #21442#25968'(&P):'
    end
    object Label3: TLabel
      Left = 216
      Top = 12
      Width = 72
      Height = 12
      Caption = #24320#22987#26102#38388'(&B):'
    end
    object Label4: TLabel
      Left = 437
      Top = 10
      Width = 72
      Height = 12
      Caption = #32467#26463#26102#38388'(&E):'
    end
    object cmb_MachineList: TComboBox
      Left = 56
      Top = 5
      Width = 145
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 0
      OnChange = cmb_MachineListChange
      Items.Strings = (
        'MON2->'#23450#22411#26426'1#'
        'MON3->'#23450#22411#26426'2#'
        'MON4->'#23450#22411#26426'3#'
        'MON5->'#39044#32553#26426'1#'
        'MON6->'#39044#32553#26426'2#')
    end
    object cmb_ParamterList: TComboBox
      Left = 56
      Top = 29
      Width = 377
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
      OnDropDown = cmb_ParamterListDropDown
    end
    object cmb_BeginTime: TComboBox
      Left = 288
      Top = 5
      Width = 145
      Height = 20
      ItemHeight = 12
      TabOrder = 2
      Text = '2006-02-17 07:00:00'
    end
    object cmb_EndTime: TComboBox
      Left = 509
      Top = 5
      Width = 145
      Height = 20
      ItemHeight = 12
      TabOrder = 3
      Text = '2006-2-18 1:17:13'
    end
    object btn_ParamterLog: TButton
      Left = 497
      Top = 28
      Width = 75
      Height = 22
      Caption = #21442#25968#26085#24535'(&L)'
      Enabled = False
      TabOrder = 4
      OnClick = btn_ParamterLogClick
    end
    object btn_MachineEfficiency: TButton
      Left = 579
      Top = 28
      Width = 75
      Height = 22
      Caption = #25928#29575'(&F)'
      TabOrder = 5
      OnClick = btn_MachineEfficiencyClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 661
    Height = 325
    ActivePage = TabSheet1
    Align = alClient
    Style = tsFlatButtons
    TabIndex = 0
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #26126#32454
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 653
        Height = 295
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        TabOrder = 0
        LookAndFeel.NativeStyle = True
        object cxGrid1DBTableView1: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #22270#34920
      ImageIndex = 1
      object DBChart1: TDBChart
        Left = 0
        Top = 0
        Width = 653
        Height = 295
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          #25928#29575#36235#21183#22270)
        View3D = False
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Series1: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
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
        object Series2: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clGreen
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
  end
  object cds_ParamterList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 8
    Top = 40
  end
  object cds_ParamterLog: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = cds_ParamterLog
    Left = 72
    Top = 48
  end
end

inherited PlanForm: TPlanForm
  Left = 365
  Top = 177
  Width = 654
  Height = 454
  Caption = #23433#25490#26426#21488#35745#21010
  Font.Charset = ANSI_CHARSET
  OldCreateOrder = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 12
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 329
    Height = 420
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 0
    object grpPlanTask: TGroupBox
      Left = 92
      Top = 1
      Width = 236
      Height = 418
      Align = alClient
      Caption = '    '#24453#23433#25490#20219#21153#21015#34920
      TabOrder = 0
      object btnArrange: TSpeedButton
        Left = 8
        Top = 1
        Width = 24
        Height = 13
        Hint = #35843#25972#35745#21010#19982#20219#21153#31383#21475#30340#25490#21015#65281
        Flat = True
        Glyph.Data = {
          E6000000424DE60000000000000076000000280000000F0000000E0000000100
          0400000000007000000000000000000000001000000000000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF0087FFFFFFFFFFFF0B3087FFFFFFFFFFF0BB0087FF
          FFFFFFFF0BB3008FFFFFFFFFF0BBB008FFFFFFFFF00BBB007FFFFFFF00BBB007
          FFF0FFFFF00BBB007FF0FFFFFFF00BB007F0FFFFFFFFF00B0070FFFFFFFFFFF0
          00F0FFFFFFFFFFFFFFF0}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnArrangeClick
      end
      object cxgridPlanTaskInfo: TcxGrid
        Left = 2
        Top = 14
        Width = 232
        Height = 402
        Align = alClient
        DragOpening = False
        TabOrder = 0
        LookAndFeel.Kind = lfStandard
        object cxgridtvPlanTaskInfo: TcxGridDBBandedTableView
          DragMode = dmAutomatic
          OnDblClick = cxgridtvPlanTaskInfoDblClick
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxgridtvPlanTaskInfoCustomDrawCell
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          Bands = <
            item
              Caption = #22522#26412#20449#24687
              FixedKind = fkLeft
              Width = 228
            end
            item
              Caption = #25193#23637#20449#24687
            end>
        end
        object cxGridlPlanTaskInfo: TcxGridLevel
          GridView = cxgridtvPlanTaskInfo
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 91
      Height = 418
      Align = alLeft
      Caption = #26426#21488#31867#22411#21015#34920
      TabOrder = 1
      object lblMachine: TLabel
        Left = 2
        Top = 14
        Width = 87
        Height = 24
        Align = alTop
        AutoSize = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -21
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lstMachineModel: TListBox
        Left = 2
        Top = 38
        Width = 87
        Height = 378
        Align = alClient
        Columns = 1
        ItemHeight = 12
        TabOrder = 0
        OnClick = lstMachineModelClick
        OnDblClick = lstMachineModelDblClick
      end
    end
  end
  object cxsplLeft: TcxSplitter
    Left = 329
    Top = 0
    Width = 8
    Height = 420
    HotZoneClassName = 'TcxXPTaskBarStyle'
    DragThreshold = 2
    Control = pnlLeft
  end
  object pnlClient: TPanel
    Left = 337
    Top = 0
    Width = 309
    Height = 420
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 2
    object pgcPlanList: TPageControl
      Left = 1
      Top = 1
      Width = 307
      Height = 378
      ActivePage = tsPlanListTable
      Align = alClient
      TabIndex = 1
      TabOrder = 0
      TabPosition = tpBottom
      object tsPlanListChart: TTabSheet
        Caption = #29976#29305#22270'(&P)'
        object gttFNCard: TGTT
          Left = 0
          Top = 0
          Width = 299
          Height = 353
          HorzScrollBar.Range = 2
          VertScrollBar.Range = 19
          Align = alClient
          AutoScroll = False
          TabOrder = 0
          UZoomTimes = 4
          UUnitTime = tuHour
          UUnitWidth = 40
          UMachineHeight = 20
          UMachineWidth = 80
          USeparatorLineType = psDot
          USeparatorLineColor = clGradientInactiveCaption
          UPlotColor = clInfoBk
          UPlotAlternateColor = clWhite
          UCurrentTime = 38388.5948590856
          UStartAt = 38388
          UEndAt = 38488.5833333333
          UIfCanDragScrollX = True
          OnBeforeChangeMachine = gttFNCardBeforeChangeMachine
          OnBeforeTaskMove = gttFNCardBeforeTaskMove
          OnTaskDblClick = gttFNCardTaskDblClick
          OnMachineDragDrop = gttFNCardMachineDragDrop
        end
      end
      object tsPlanListTable: TTabSheet
        Hint = #24050#32463#20445#23384#30340#35745#21010
        Caption = #34920#26684#35270#22270'(&G)'
        ImageIndex = 1
        object grpPlanList: TGroupBox
          Left = 0
          Top = 0
          Width = 299
          Height = 353
          Align = alClient
          Caption = #24050#23433#25490#20219#21153#21015#34920
          TabOrder = 0
          object cxgridPlanListInfo: TcxGrid
            Left = 2
            Top = 14
            Width = 295
            Height = 337
            Align = alClient
            PopupMenu = pmFNCard
            TabOrder = 0
            object cxgridtvPlanListInfo: TcxGridDBTableView
              DataController.DataSource = dsPlanListInfo
              DataController.Summary.DefaultGroupSummaryItems = <
                item
                  Kind = skCount
                  Column = cxgdbcPlanListInfoFN_Card1
                end
                item
                  Kind = skSum
                  Column = cxgdbcPlanListInfoQuantity1
                end>
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skCount
                  Column = cxgdbcPlanListInfoFN_Card1
                end
                item
                  Kind = skSum
                  Column = cxgdbcPlanListInfoQuantity1
                end>
              DataController.Summary.SummaryGroups = <>
              NavigatorButtons.ConfirmDelete = False
              OnCustomDrawCell = cxgridtvPlanListInfoCustomDrawCell
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.Footer = True
              object cxgdbcPlanListInfoFN_Card1: TcxGridDBColumn
                Caption = #21345#21495
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'FN_Card'
              end
              object cxgdbcPlanListInfoCar_NO1: TcxGridDBColumn
                Caption = #36710#29260#21495
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Car_NO'
              end
              object cxgdbcPlanListInfoQuantity1: TcxGridDBColumn
                Caption = #25968#37327
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Quantity'
              end
              object cxgdbcPlanListInfoOperation_CHN1: TcxGridDBColumn
                Caption = #24037#24207
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Operation_CHN'
              end
              object cxgdbcPlanListInfoWhite_Type: TcxGridDBColumn
                Caption = #29305#28418#30333
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'White_Type'
              end
              object cxgdbcPlanListInfoGF_ID1: TcxGridDBColumn
                Caption = #21697#21517'ID'
                HeaderAlignmentHorz = taCenter
                Width = 65
                DataBinding.FieldName = 'GF_ID'
              end
              object cxgdbcPlanListInfoGF_NO1: TcxGridDBColumn
                Caption = #21697#21517
                HeaderAlignmentHorz = taCenter
                Width = 106
                DataBinding.FieldName = 'GF_NO'
              end
              object cxgdbcPlanListInfoJob_NO1: TcxGridDBColumn
                Caption = #25490#21333#21495
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Job_NO'
              end
              object cxgdbcPlanListInfoDelivery_Date1: TcxGridDBColumn
                Caption = #20132#26399
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Delivery_Date'
              end
              object cxgdbcPlanListInfoMachine_ID1: TcxGridDBColumn
                Caption = #26426#21488#21495
                Visible = False
                GroupIndex = 0
                HeaderAlignmentHorz = taCenter
                SortOrder = soAscending
                Width = 71
                DataBinding.FieldName = 'Machine_ID'
              end
              object cxgdbcPlanListInfoUrgent_Type1: TcxGridDBColumn
                Visible = False
                DataBinding.FieldName = 'Urgent_Type'
              end
              object cxgdbcPlanListInfoIs_Cut_Cloth1: TcxGridDBColumn
                Caption = #39318#33853#24067
                HeaderAlignmentHorz = taCenter
                Width = 37
                DataBinding.FieldName = 'Is_Cut_Cloth'
              end
              object cxgdbcPlanListInfoIs_Hold1: TcxGridDBColumn
                Caption = 'HOLD'
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Is_Hold'
              end
              object cxgdbcPlanListInfoType1: TcxGridDBColumn
                HeaderAlignmentHorz = taCenter
                Width = 79
                DataBinding.FieldName = 'Type'
              end
              object cxgdbcPlanListInfoSeconds1: TcxGridDBColumn
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Seconds'
              end
              object cxgdbcPlanListInfoPrepare_Type1: TcxGridDBColumn
                Caption = #20934#22791#31867#22411
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Prepare_Type'
              end
              object cxgdbcPlanListInfoPrepare_Minute1: TcxGridDBColumn
                Caption = #20934#22791#26102#38388
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Prepare_Minute'
              end
              object cxgdbcPlanListInfoWV_IsFinished1: TcxGridDBColumn
                Caption = #20102#26426
                HeaderAlignmentHorz = taCenter
                Width = 77
                DataBinding.FieldName = 'WV_IsFinished'
              end
              object cxgdbcPlanListInfoFact_Begin_Time1: TcxGridDBColumn
                Caption = #23454#38469#24320#22987#26102#38388
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Fact_Begin_Time'
              end
              object cxgdbcPlanListInfoPlan_Begin_Time1: TcxGridDBColumn
                Caption = #35745#21010#24320#22987#26102#38388
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Plan_Begin_Time'
              end
              object cxgdbcPlanListInfoPlan_End_Time1: TcxGridDBColumn
                Caption = #35745#21010#32467#26463#26102#38388
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Plan_End_Time'
              end
              object cxgdbcPlanListInfoPlanner1: TcxGridDBColumn
                Caption = #35745#21010#20154
                HeaderAlignmentHorz = taCenter
                Width = 57
                DataBinding.FieldName = 'Planner'
              end
              object cxgdbcPlanListInfoPlan_Time1: TcxGridDBColumn
                Caption = #35745#21010#26085#26399
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Plan_Time'
              end
              object cxgdbcPlanListInfoHoldByAff: TcxGridDBColumn
                Caption = 'holdbyaff'
                HeaderAlignmentHorz = taCenter
                DataBinding.FieldName = 'Is_HoldByAffirm'
              end
              object TcxGridDBColumn
              end
            end
            object cxGridlPlanListInfo: TcxGridLevel
              GridView = cxgridtvPlanListInfo
            end
          end
        end
      end
      object TabSheet1: TTabSheet
        Caption = #21024#38500#35745#21010
        ImageIndex = 2
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 299
          Height = 49
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label1: TLabel
            Left = 8
            Top = 14
            Width = 30
            Height = 12
            Caption = #21697#21517':'
          end
          object Label2: TLabel
            Left = 169
            Top = 32
            Width = 318
            Height = 12
            Caption = #25552#31034': ('#27492#21024#38500#21482#21024#38500#20102#26412#22320#25968#25454','#38656#35201#20445#23384#21518#25165#33021#24443#24213#21024#38500')'
            Color = clBtnFace
            Font.Charset = GB2312_CHARSET
            Font.Color = clGreen
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object edtGFNO: TEdit
            Left = 40
            Top = 6
            Width = 121
            Height = 20
            CharCase = ecUpperCase
            TabOrder = 0
          end
          object btnQuery: TButton
            Left = 168
            Top = 4
            Width = 75
            Height = 25
            Caption = #26597#35810'(&Q)'
            TabOrder = 1
            OnClick = btnQueryClick
          end
          object btnDelete: TButton
            Left = 248
            Top = 4
            Width = 75
            Height = 25
            Caption = #21024#38500'(&D)'
            TabOrder = 2
            OnClick = btnDeleteClick
          end
        end
        object GroupBox2: TGroupBox
          Left = 0
          Top = 49
          Width = 299
          Height = 304
          Align = alClient
          Caption = '             '#21345#21495#21015#34920
          TabOrder = 1
          object clbFNCardList: TCheckListBox
            Left = 2
            Top = 14
            Width = 295
            Height = 288
            Align = alClient
            Columns = 3
            ItemHeight = 12
            TabOrder = 1
          end
          object chbAll: TCheckBox
            Left = 9
            Top = 0
            Width = 78
            Height = 13
            Caption = #20840#36873'/'#21462#28040
            TabOrder = 0
            OnClick = chbAllClick
          end
        end
      end
    end
    object pnlBottom: TPanel
      Left = 1
      Top = 379
      Width = 307
      Height = 40
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        307
        40)
      object lblFNCard: TLabel
        Left = 24
        Top = 20
        Width = 30
        Height = 12
        Caption = #21345#21495':'
      end
      object btnSave: TButton
        Left = 144
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = btnSaveClick
      end
      object btnClose: TButton
        Left = 326
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = #36864#20986'(&X)'
        TabOrder = 3
        OnClick = btnCloseClick
      end
      object btnRefresh: TButton
        Left = 67
        Top = 8
        Width = 74
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21047#26032'(&R)'
        TabOrder = 0
        OnClick = btnRefreshClick
      end
      object btnFind: TButton
        Left = 145
        Top = 9
        Width = 74
        Height = 25
        Caption = #26597#25214'(&F)'
        TabOrder = 1
        OnClick = btnFindClick
      end
      object edtFNCard: TEdit
        Left = 56
        Top = 12
        Width = 86
        Height = 20
        CharCase = ecUpperCase
        MaxLength = 9
        TabOrder = 4
        OnEnter = edtFNCardEnter
        OnExit = edtFNCardExit
      end
      object btnSort: TButton
        Left = -11
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #33258#21160#25490#21015'(&A)'
        TabOrder = 5
        OnClick = btnSortClick
      end
      object btnExit: TButton
        Left = 222
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        TabOrder = 6
        OnClick = btnExitClick
      end
      object btnAutoPlan: TButton
        Left = -91
        Top = 8
        Width = 75
        Height = 25
        Hint = #26681#25454#26426#21488#31867#22411#33258#21160#25490#35745#21010#65292#38656#20445#23384
        Anchors = [akRight, akBottom]
        Caption = #33258#21160#25490#21333'(&P)'
        TabOrder = 7
        OnClick = btnAutoPlanClick
      end
    end
  end
  object dsPlanTaskInfo: TDataSource
    DataSet = cdsPlanTaskInfo
    Left = 192
    Top = 80
  end
  object cdsPlanTaskInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 80
  end
  object cdsPlanListInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 144
  end
  object cdsPlanInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 208
  end
  object dsPlanListInfo: TDataSource
    DataSet = cdsPlanListInfo
    Left = 192
    Top = 144
  end
  object pmFNCard: TPopupMenu
    OnPopup = pmFNCardPopup
    Left = 184
    Top = 264
  end
  object cxgpmPlanList: TcxGridPopupMenu
    Grid = cxgridPlanListInfo
    PopupMenus = <>
    Left = 264
    Top = 272
  end
  object cdsAutoPlan: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 208
  end
  object cdsRoll: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 184
  end
  object cdsAlertRemark: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 264
  end
end

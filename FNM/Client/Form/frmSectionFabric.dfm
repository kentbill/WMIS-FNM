object SectionFabricForm: TSectionFabricForm
  Left = 399
  Top = 229
  Width = 906
  Height = 530
  Caption = #27573#24067#22788#29702
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 890
    Height = 492
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #27573#24067#20449#24687#24405#20837
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 882
        Height = 97
        Align = alTop
        TabOrder = 0
        object lblWeight: TLabel
          Left = 56
          Top = 32
          Width = 36
          Height = 13
          Caption = #37325#37327#65306
        end
        object edtWeight: TEdit
          Left = 100
          Top = 28
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object btnSave: TButton
          Left = 336
          Top = 24
          Width = 73
          Height = 25
          Caption = #20445#23384'&S'
          TabOrder = 1
          OnClick = btnSaveClick
        end
        object btnSend: TButton
          Left = 504
          Top = 24
          Width = 73
          Height = 25
          Caption = #36865#24067'&D'
          TabOrder = 2
          OnClick = btnSendClick
        end
        object btnDel: TButton
          Left = 416
          Top = 24
          Width = 73
          Height = 25
          Caption = #21024#38500' &D'
          TabOrder = 3
          OnClick = btnDelClick
        end
        object btnAdd: TButton
          Left = 240
          Top = 24
          Width = 73
          Height = 25
          Caption = #22686#21152'&S'
          TabOrder = 4
          OnClick = btnAddClick
        end
        object btnRefresh: TButton
          Left = 240
          Top = 56
          Width = 73
          Height = 25
          Caption = #21047#26032'&R'
          TabOrder = 5
          OnClick = btnRefreshClick
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 97
        Width = 882
        Height = 367
        Align = alClient
        TabOrder = 1
        object cxgridFabricInfo: TcxGrid
          Left = 1
          Top = 1
          Width = 880
          Height = 365
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfFlat
          object cxgridtvFabricInfo: TcxGridDBTableView
            DataController.DataSource = dsSectionFabric
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsCustomize.ColumnFiltering = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsSelection.MultiSelect = True
            OptionsView.GroupByBox = False
            OptionsView.GroupFooters = gfAlwaysVisible
            object cxgridtvFabricInfoDBColumn1: TcxGridDBColumn
              Visible = False
              DataBinding.FieldName = 'iden'
            end
            object cxgridtvFabricInfoDBColumn5: TcxGridDBColumn
              Caption = #24067#21495
              Width = 125
              DataBinding.FieldName = 'fabric_no'
            end
            object cxgridtvFabricInfoDBColumn2: TcxGridDBColumn
              Caption = #37325#37327
              Width = 150
              DataBinding.FieldName = 'Fabric_Weight'
            end
            object cxgridtvFabricInfoDBColumn3: TcxGridDBColumn
              Caption = #26102#38388
              Width = 184
              DataBinding.FieldName = 'Operate_Time'
            end
            object cxgridtvFabricInfoDBColumn4: TcxGridDBColumn
              Caption = #24405#20837#20154
              Width = 155
              DataBinding.FieldName = 'Operator'
            end
          end
          object cxGridlFabricInfo: TcxGridLevel
            GridView = cxgridtvFabricInfo
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #21462#28040#36865#24067
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 882
        Height = 81
        Align = alTop
        TabOrder = 0
        object Button2: TButton
          Left = 48
          Top = 24
          Width = 89
          Height = 25
          Caption = #21462#28040#36865#24067'&C'
          TabOrder = 0
          OnClick = Button2Click
        end
        object Button1: TButton
          Left = 176
          Top = 24
          Width = 73
          Height = 25
          Caption = #21047#26032'&R'
          TabOrder = 1
          OnClick = btnRefreshClick
        end
        object Button3: TButton
          Left = 280
          Top = 24
          Width = 89
          Height = 25
          Caption = #37325#25171#26631#31614' &P'
          TabOrder = 2
          OnClick = Button3Click
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 81
        Width = 882
        Height = 383
        Align = alClient
        TabOrder = 1
        object cxGrid1: TcxGrid
          Left = 1
          Top = 1
          Width = 880
          Height = 381
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfFlat
          object cxGridDBtvSend: TcxGridDBTableView
            DataController.DataSource = dsSendFabric
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsCustomize.ColumnFiltering = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsSelection.MultiSelect = True
            OptionsView.GroupByBox = False
            OptionsView.GroupFooters = gfAlwaysVisible
            object cxGridDBColumn1: TcxGridDBColumn
              Caption = #24207#21495
              Visible = False
              Width = 145
              DataBinding.FieldName = 'iden'
            end
            object cxGridDBColumn2: TcxGridDBColumn
              Caption = #37325#37327
              Width = 135
              DataBinding.FieldName = 'Fabric_Weight'
            end
            object cxGridDBColumn3: TcxGridDBColumn
              Caption = #26102#38388
              Width = 166
              DataBinding.FieldName = 'Operate_Time'
            end
            object cxGridDBColumn4: TcxGridDBColumn
              Caption = #24405#20837#20154
              Width = 155
              DataBinding.FieldName = 'Operator'
            end
            object cxGridDBtvSendDBColumn3: TcxGridDBColumn
              Caption = #24067#21495
              SortOrder = soAscending
              Width = 87
              DataBinding.FieldName = 'fabric_no'
            end
            object cxGridDBtvSendDBColumn1: TcxGridDBColumn
              Caption = #36865#24067#21333#21495
              Width = 105
              DataBinding.FieldName = 'NOTE_NO'
            end
            object cxGridDBtvSendDBColumn2: TcxGridDBColumn
              Caption = #36865#24067#26102#38388
              DataBinding.FieldName = 'send_time'
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridDBtvSend
          end
        end
      end
    end
  end
  object cdsSectionFabric: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 784
    Top = 72
  end
  object dsSectionFabric: TDataSource
    DataSet = cdsSectionFabric
    Left = 824
    Top = 72
  end
  object dsSendFabric: TDataSource
    DataSet = cdsSendFabric
    Left = 824
    Top = 32
  end
  object cdsSendFabric: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 784
    Top = 32
  end
end

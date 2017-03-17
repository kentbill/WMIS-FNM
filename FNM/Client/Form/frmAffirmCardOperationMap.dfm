inherited AffirmCardOperationMapForm: TAffirmCardOperationMapForm
  Left = 189
  Top = 183
  Caption = #26426#21488#31649#29702#20154#21592#32500#25252
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 12
  object cxgrdMap: TcxGrid
    Left = 0
    Top = 0
    Width = 424
    Height = 453
    Align = alClient
    TabOrder = 0
    object cxgridtvMap: TcxGridDBTableView
      DataController.DataSource = dsMap
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsView.GroupByBox = False
    end
    object cxgrdlvlGridlMap: TcxGridLevel
      GridView = cxgridtvMap
    end
  end
  object pnl_Only: TPanel
    Left = 424
    Top = 0
    Width = 264
    Height = 453
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object lbl1: TLabel
      Left = 8
      Top = 64
      Width = 88
      Height = 16
      Caption = #26426#21488#31649#29702#21592':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object btn_Query: TSpeedButton
      Left = 29
      Top = 156
      Width = 75
      Height = 25
      Caption = #21047#26032'(&R)'
      Flat = True
      OnClick = btn_QueryClick
    end
    object btnSave: TSpeedButton
      Left = 29
      Top = 212
      Width = 75
      Height = 25
      Caption = #20445#23384'(&S)'
      Flat = True
      OnClick = btnSaveClick
    end
    object btn_Exit: TSpeedButton
      Left = 125
      Top = 212
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btn_ExitClick
    end
    object btnCancel: TSpeedButton
      Left = 125
      Top = 156
      Width = 75
      Height = 25
      Caption = #21462#28040'(&C)'
      Flat = True
      OnClick = btnCancelClick
    end
    object Label1: TLabel
      Left = 56
      Top = 24
      Width = 40
      Height = 16
      Caption = #24037#24207':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object cxdbcbIsActive: TcxDBCheckBox
      Left = 112
      Top = 96
      Width = 121
      Height = 24
      DataBinding.DataField = 'Is_Active'
      DataBinding.DataSource = dsMap
      ParentFont = False
      Properties.DisplayUnchecked = 'False'
      Properties.Caption = #26159#21542#26377#25928
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      TabOrder = 0
    end
    object cxdblcmWorker: TcxDBLookupComboBox
      Left = 104
      Top = 60
      Width = 145
      Height = 24
      DataBinding.DataField = 'Worker_ID'
      DataBinding.DataSource = dsMap
      ParentFont = False
      Properties.DropDownRows = 12
      Properties.KeyFieldNames = 'Worker_ID'
      Properties.ListColumns = <
        item
          FieldName = 'Worker_Name'
        end>
      Properties.ListSource = dsWorker
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      TabOrder = 1
    end
    object cxdblcmOperation: TcxDBLookupComboBox
      Left = 103
      Top = 20
      Width = 145
      Height = 24
      HelpType = htKeyword
      DataBinding.DataField = 'Operation_Code'
      DataBinding.DataSource = dsMap
      Enabled = False
      ParentFont = False
      Properties.DropDownRows = 12
      Properties.KeyFieldNames = 'Operation_Code'
      Properties.ListColumns = <
        item
          FieldName = 'Operation_CHN'
        end>
      Properties.ListSource = dsOperation
      Properties.MaxLength = 0
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      TabOrder = 2
    end
  end
  object cdsMap: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterPost = cdsMapAfterPost
    Left = 96
    Top = 176
  end
  object dsMap: TDataSource
    DataSet = cdsMap
    Left = 176
    Top = 176
  end
  object cdsWorker: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 152
  end
  object dsWorker: TDataSource
    DataSet = cdsWorker
    Left = 304
    Top = 200
  end
  object cdsOperation: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 392
    Top = 152
  end
  object dsOperation: TDataSource
    DataSet = cdsOperation
    Left = 384
    Top = 200
  end
end

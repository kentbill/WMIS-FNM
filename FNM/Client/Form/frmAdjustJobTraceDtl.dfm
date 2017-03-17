inherited AdjustJobTraceDtlForm: TAdjustJobTraceDtlForm
  Left = 47
  Top = 92
  Width = 808
  Caption = #20135#37327#21450#36710#36895#35843#25972
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 360
    Align = alClient
    TabOrder = 1
    object cxGridJobTraceDtl: TcxGrid
      Left = 1
      Top = 1
      Width = 798
      Height = 358
      Align = alClient
      TabOrder = 0
      object cxGridtvJobTraceDtl: TcxGridDBTableView
        DataController.DataSource = dsJobTraceDtl
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        object cxGridtvJobTraceDtlIden: TcxGridDBColumn
          Visible = False
          DataBinding.FieldName = 'Iden'
        end
        object cxGridtvJobTraceDtlGF_NO: TcxGridDBColumn
          Caption = #21697#21517
          Width = 108
          DataBinding.FieldName = 'GF_NO'
        end
        object cxGridtvJobTraceDtlFN_Card: TcxGridDBColumn
          Caption = #21345#21495
          DataBinding.FieldName = 'FN_Card'
        end
        object cxGridtvJobTraceDtlStep_NO: TcxGridDBColumn
          Caption = #27493#39588
          Width = 45
          DataBinding.FieldName = 'Step_NO'
        end
        object cxGridtvJobTraceDtlOperation_CHN: TcxGridDBColumn
          Caption = #24037#24207#21517
          Width = 71
          DataBinding.FieldName = 'Operation_CHN'
        end
        object cxGridtvJobTraceDtlQuantity: TcxGridDBColumn
          Caption = #25968#37327
          Width = 51
          DataBinding.FieldName = 'Quantity'
        end
        object cxGridtvJobTraceDtlMachine_ID: TcxGridDBColumn
          Caption = #26426#21488
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'Machine_ID'
          Properties.ListColumns = <
            item
              FieldName = 'Machine_Model_CHN'
            end>
          Properties.ListSource = dsMachineList
          Width = 62
          DataBinding.FieldName = 'Machine_ID'
        end
        object cxGridtvJobTraceDtlSpeed: TcxGridDBColumn
          Caption = #36710#36895
          DataBinding.FieldName = 'Speed'
        end
        object cxGridtvJobTraceDtlBefor_Operator: TcxGridDBColumn
          Caption = #36827#24067#24037
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'Worker_ID'
          Properties.ListColumns = <
            item
              FieldName = 'Worker_Name'
            end>
          Properties.ListSource = dsWorkerList
          Width = 73
          DataBinding.FieldName = 'Befor_Operator'
        end
        object cxGridtvJobTraceDtlMiddle_Operator: TcxGridDBColumn
          Caption = #25805#20316#24037
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'Worker_ID'
          Properties.ListColumns = <
            item
              FieldName = 'Worker_Name'
            end>
          Properties.ListSource = dsWorkerList
          Width = 69
          DataBinding.FieldName = 'Middle_Operator'
        end
        object cxGridtvJobTraceDtlAfter_Operator: TcxGridDBColumn
          Caption = #33853#24067#24037
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.KeyFieldNames = 'Worker_ID'
          Properties.ListColumns = <
            item
              FieldName = 'Worker_Name'
            end>
          Properties.ListSource = dsWorkerList
          Width = 66
          DataBinding.FieldName = 'After_Operator'
        end
        object cxGridtvJobTraceDtlBegin_Time: TcxGridDBColumn
          Caption = #24320#22987#26102#38388
          DataBinding.FieldName = 'Begin_Time'
        end
        object cxGridtvJobTraceDtlEnd_Time: TcxGridDBColumn
          Caption = #32467#26463#26102#38388
          DataBinding.FieldName = 'End_Time'
        end
        object cxGridtvJobTraceDtlOperator: TcxGridDBColumn
          Caption = #36755#20837#20154
          Width = 64
          DataBinding.FieldName = 'Operator'
        end
        object cxGridtvJobTraceDtlOperate_Time: TcxGridDBColumn
          Caption = #36755#20837#26102#38388
          DataBinding.FieldName = 'Operate_Time'
        end
        object cxGridtvJobTraceDtlGF_ID: TcxGridDBColumn
          Visible = False
          DataBinding.FieldName = 'GF_ID'
        end
        object cxGridtvJobTraceDtlJob_NO: TcxGridDBColumn
          Visible = False
          DataBinding.FieldName = 'Job_NO'
        end
        object cxGridtvJobTraceDtlOperation_Code: TcxGridDBColumn
          Visible = False
          DataBinding.FieldName = 'Operation_Code'
        end
      end
      object cxGridlJobTraceDtlLevel: TcxGridLevel
        GridView = cxGridtvJobTraceDtl
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 368
    Width = 800
    Height = 85
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      800
      85)
    object btnQuery: TSpeedButton
      Left = 535
      Top = 52
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #26597#35810'(&Q)'
      Flat = True
      OnClick = btnQueryClick
    end
    object btnSave: TSpeedButton
      Left = 621
      Top = 52
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
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
      Left = 709
      Top = 52
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnCloseClick
    end
    object pgcType: TPageControl
      Left = 0
      Top = 0
      Width = 417
      Height = 85
      ActivePage = TabSheet1
      Align = alLeft
      Style = tsFlatButtons
      TabIndex = 0
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #26426#21488
        object lblBeginTime: TLabel
          Left = 12
          Top = 10
          Width = 54
          Height = 12
          Caption = #24320#22987#26102#38388':'
        end
        object lblEndTime: TLabel
          Left = 11
          Top = 38
          Width = 54
          Height = 12
          Caption = #32467#26463#26102#38388':'
        end
        object Label1: TLabel
          Left = 226
          Top = 34
          Width = 30
          Height = 12
          Caption = #26426#21488':'
        end
        object dtpBeginDate: TDateTimePicker
          Left = 67
          Top = 2
          Width = 83
          Height = 20
          CalAlignment = dtaLeft
          Date = 38338.429389537
          Time = 38338.429389537
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 0
        end
        object dtpBeginTime: TDateTimePicker
          Left = 148
          Top = 2
          Width = 71
          Height = 20
          CalAlignment = dtaLeft
          Date = 38338.429389537
          Time = 38338.429389537
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkTime
          ParseInput = False
          TabOrder = 1
        end
        object dtpEndDate: TDateTimePicker
          Left = 67
          Top = 30
          Width = 83
          Height = 20
          CalAlignment = dtaLeft
          Date = 38338.429389537
          Time = 38338.429389537
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 2
        end
        object dtpEndTime: TDateTimePicker
          Left = 148
          Top = 30
          Width = 71
          Height = 20
          CalAlignment = dtaLeft
          Date = 38338.429389537
          Time = 38338.429389537
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkTime
          ParseInput = False
          TabOrder = 3
        end
        object cbbMachineList: TComboBox
          Left = 256
          Top = 26
          Width = 145
          Height = 20
          Style = csDropDownList
          ItemHeight = 12
          TabOrder = 4
          Items.Strings = (
            #25910'    '#22383
            #24403#21069#24211#23384
            #36865'    '#24067
            #26085'    '#25253
            #36820#24037#26085#25253
            #30424'    '#28857)
        end
      end
      object TabSheet2: TTabSheet
        Caption = #21345#21495
        ImageIndex = 1
        object lblFNCard: TLabel
          Left = 12
          Top = 21
          Width = 30
          Height = 12
          Caption = #21345#21495':'
        end
        object edtFNCard: TEdit
          Left = 44
          Top = 13
          Width = 105
          Height = 20
          CharCase = ecUpperCase
          MaxLength = 9
          TabOrder = 0
          OnKeyDown = edtFNCardKeyDown
        end
      end
    end
  end
  object cxSplBottom: TcxSplitter
    Left = 0
    Top = 360
    Width = 800
    Height = 8
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salBottom
    Control = pnlBottom
  end
  object dsJobTraceDtl: TDataSource
    DataSet = cdsJobTraceDtl
    Left = 120
    Top = 104
  end
  object cdsJobTraceDtl: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 120
    Top = 136
    object cdsJobTraceDtlIden: TAutoIncField
      FieldName = 'Iden'
      ReadOnly = True
    end
    object cdsJobTraceDtlGF_NO: TStringField
      FieldName = 'GF_NO'
      ReadOnly = True
    end
    object cdsJobTraceDtlFN_Card: TStringField
      FieldName = 'FN_Card'
      ReadOnly = True
      FixedChar = True
      Size = 9
    end
    object cdsJobTraceDtlQuantity: TBCDField
      FieldName = 'Quantity'
      ReadOnly = True
      Precision = 9
      Size = 2
    end
    object cdsJobTraceDtlStep_NO: TSmallintField
      FieldName = 'Step_NO'
      ReadOnly = True
    end
    object cdsJobTraceDtlOperation_CHN: TStringField
      FieldName = 'Operation_CHN'
      ReadOnly = True
    end
    object cdsJobTraceDtlMachine_ID: TStringField
      FieldName = 'Machine_ID'
      FixedChar = True
      Size = 4
    end
    object cdsJobTraceDtlSpeed: TBCDField
      FieldName = 'Speed'
      Precision = 9
      Size = 2
    end
    object cdsJobTraceDtlBegin_Time: TDateTimeField
      FieldName = 'Begin_Time'
      ReadOnly = True
    end
    object cdsJobTraceDtlEnd_Time: TDateTimeField
      FieldName = 'End_Time'
      ReadOnly = True
    end
    object cdsJobTraceDtlBefor_Operator: TStringField
      FieldName = 'Befor_Operator'
      FixedChar = True
      Size = 7
    end
    object cdsJobTraceDtlMiddle_Operator: TStringField
      FieldName = 'Middle_Operator'
      FixedChar = True
      Size = 7
    end
    object cdsJobTraceDtlAfter_Operator: TStringField
      FieldName = 'After_Operator'
      FixedChar = True
      Size = 7
    end
    object cdsJobTraceDtlOperator: TStringField
      FieldName = 'Operator'
      ReadOnly = True
    end
    object cdsJobTraceDtlOperate_Time: TDateTimeField
      FieldName = 'Operate_Time'
      ReadOnly = True
    end
    object cdsJobTraceDtlGF_ID: TIntegerField
      FieldName = 'GF_ID'
      ReadOnly = True
    end
    object cdsJobTraceDtlJob_NO: TStringField
      FieldName = 'Job_NO'
      ReadOnly = True
      Size = 10
    end
    object cdsJobTraceDtlOperation_Code: TStringField
      FieldName = 'Operation_Code'
      ReadOnly = True
      FixedChar = True
      Size = 3
    end
  end
  object dsMachineList: TDataSource
    Left = 128
    Top = 288
  end
  object dsWorkerList: TDataSource
    Left = 128
    Top = 320
  end
end

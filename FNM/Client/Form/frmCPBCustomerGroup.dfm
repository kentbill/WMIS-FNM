inherited CPBCustomerGroupForm: TCPBCustomerGroupForm
  Left = 248
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'CPB'#23458#25143#32452#21035#32500#25252
  FormStyle = fsNormal
  OldCreateOrder = True
  Visible = False
  PixelsPerInch = 96
  TextHeight = 12
  object pnl_Only: TPanel
    Left = 440
    Top = 0
    Width = 248
    Height = 453
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object lbl1: TLabel
      Left = 16
      Top = 64
      Width = 72
      Height = 16
      Caption = #23458#25143#32452#21035':'
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
    object lbl2: TLabel
      Left = 48
      Top = 32
      Width = 40
      Height = 16
      Caption = #23458#25143':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object cxdbcbbGroup: TcxDBComboBox
      Left = 112
      Top = 62
      Width = 121
      Height = 24
      HelpType = htKeyword
      DataBinding.DataField = 'Customer_Group'
      DataBinding.DataSource = dsCustomer
      ParentFont = False
      Properties.CharCase = ecUpperCase
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      TabOrder = 0
    end
    object cxdbcbIsActive: TcxDBCheckBox
      Left = 112
      Top = 96
      Width = 121
      Height = 24
      DataBinding.DataField = 'Is_Active'
      DataBinding.DataSource = dsCustomer
      ParentFont = False
      Properties.DisplayUnchecked = 'False'
      Properties.Caption = #26159#21542#26377#25928
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      TabOrder = 1
    end
    object cxdbte1: TcxDBTextEdit
      Left = 112
      Top = 32
      Width = 121
      Height = 20
      DataBinding.DataField = 'Customer'
      DataBinding.DataSource = dsCustomer
      Enabled = False
      TabOrder = 2
    end
  end
  object cxgridCustomer: TcxGrid
    Left = 0
    Top = 0
    Width = 440
    Height = 453
    Align = alClient
    TabOrder = 1
    object cxgridtvCustomer: TcxGridDBTableView
      DataController.DataSource = dsCustomer
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsView.GroupByBox = False
      object cxgdbcCustomerDBColumn1: TcxGridDBColumn
        PropertiesClassName = 'TcxTextEditProperties'
        DataBinding.FieldName = 'Customer'
      end
      object cxgdbcCustomerDBColumn2: TcxGridDBColumn
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.ReadOnly = False
        DataBinding.FieldName = 'Customer_Group'
      end
      object cxgdbcCustomerDBColumn3: TcxGridDBColumn
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.DisplayUnchecked = 'False'
        DataBinding.FieldName = 'Is_Active'
      end
    end
    object cxGridlCustomer: TcxGridLevel
      GridView = cxgridtvCustomer
    end
  end
  object cdsCustomer: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 176
  end
  object dsCustomer: TDataSource
    DataSet = cdsCustomer
    Left = 176
    Top = 176
  end
  object cdsGroup: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 424
    Top = 96
  end
end

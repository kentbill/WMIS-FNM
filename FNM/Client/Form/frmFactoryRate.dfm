object FactoryRateForm: TFactoryRateForm
  Left = 322
  Top = 248
  Width = 571
  Height = 261
  Caption = #33258#21160#20998#21378#24037#21378#27604#29575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 555
    Height = 57
    Align = alTop
    TabOrder = 0
    object lbl1: TLabel
      Left = 2
      Top = 24
      Width = 60
      Height = 13
      Caption = #29983#20135#24037#21378#65306
    end
    object lbl2: TLabel
      Left = 144
      Top = 24
      Width = 36
      Height = 13
      Caption = #27604#20540#65306
    end
    object btnDelete: TSpeedButton
      Left = 424
      Top = 16
      Width = 49
      Height = 25
      Caption = #21024#38500
      OnClick = btnDeleteClick
    end
    object dbedtfactory: TDBEdit
      Left = 56
      Top = 22
      Width = 73
      Height = 21
      DataField = 'factory'
      DataSource = dsFactoryRate
      TabOrder = 0
    end
    object dbedtrate: TDBEdit
      Left = 184
      Top = 20
      Width = 57
      Height = 21
      DataField = 'rate'
      DataSource = dsFactoryRate
      TabOrder = 1
    end
    object btn1: TBitBtn
      Left = 264
      Top = 16
      Width = 65
      Height = 25
      Caption = #20445' '#23384
      TabOrder = 2
      OnClick = btn1Click
    end
    object btn2: TBitBtn
      Left = 496
      Top = 16
      Width = 57
      Height = 25
      Caption = #20851' '#38381
      TabOrder = 3
      OnClick = btn2Click
    end
    object btnAdd: TBitBtn
      Left = 344
      Top = 16
      Width = 57
      Height = 25
      Caption = #26032#22686
      TabOrder = 4
      OnClick = btnAddClick
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 57
    Width = 555
    Height = 165
    Align = alClient
    TabOrder = 1
    object cxGrid1: TcxGrid
      Left = 1
      Top = 1
      Width = 553
      Height = 163
      Align = alClient
      TabOrder = 0
      object cxGridFactoryRate: TcxGridDBTableView
        DataController.DataSource = dsFactoryRate
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsSelection.CellSelect = False
        object cxgrdbclmnID: TcxGridDBColumn
          Width = 76
          DataBinding.FieldName = 'ID'
        end
        object cxgrdbclmnGridFactoryRateDBColumn2: TcxGridDBColumn
          MinWidth = 40
          Width = 81
          DataBinding.FieldName = 'factory'
        end
        object cxgrdbclmnGridFactoryRateDBColumn3: TcxGridDBColumn
          MinWidth = 40
          Width = 104
          DataBinding.FieldName = 'rate'
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGridFactoryRate
      end
    end
  end
  object cdsFactoryRate: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 136
  end
  object dsFactoryRate: TDataSource
    DataSet = cdsFactoryRate
    Left = 224
    Top = 136
  end
end

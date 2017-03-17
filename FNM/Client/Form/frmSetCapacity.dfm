object SetCapacityForm: TSetCapacityForm
  Left = 285
  Top = 198
  Width = 1052
  Height = 596
  Caption = 'SetCapacityForm'
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
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 268
    Width = 1036
    Height = 289
    Align = alBottom
    TabOrder = 0
    object grp1: TGroupBox
      Left = 1
      Top = 1
      Width = 1034
      Height = 120
      Align = alTop
      Caption = #26032#22686
      TabOrder = 0
      object lbl9: TLabel
        Left = 448
        Top = 63
        Width = 48
        Height = 13
        Caption = #26085#20135#33021#65306
      end
      object lbl8: TLabel
        Left = 445
        Top = 26
        Width = 47
        Height = 13
        Caption = #26426#21488'ID'#65306
      end
      object lbl1: TLabel
        Left = 444
        Top = 97
        Width = 42
        Height = 13
        Caption = #22791'  '#27880#65306
      end
      object lbl4: TLabel
        Left = 608
        Top = 63
        Width = 36
        Height = 13
        Caption = #36710#36895#65306
      end
      object btnSave: TBitBtn
        Left = 928
        Top = 56
        Width = 65
        Height = 25
        Caption = #20445#23384
        TabOrder = 0
        OnClick = btnSaveClick
      end
      object rgFactory: TRadioGroup
        Left = 24
        Top = 16
        Width = 97
        Height = 97
        Caption = #29983#20135#24037#21378
        ItemIndex = 0
        Items.Strings = (
          'FA'
          'FG')
        TabOrder = 1
      end
      object rgOperation: TRadioGroup
        Left = 152
        Top = 16
        Width = 105
        Height = 97
        Caption = #24037#24207#31867#22411
        ItemIndex = 0
        Items.Strings = (
          #28903#27611
          #36864#27974
          #19997#20809)
        TabOrder = 2
      end
      object edt_DayCapacity: TEdit
        Left = 502
        Top = 61
        Width = 91
        Height = 21
        TabOrder = 3
      end
      object cbbMachine_id: TComboBox
        Left = 502
        Top = 24
        Width = 108
        Height = 21
        ItemHeight = 13
        TabOrder = 4
      end
      object btnNew: TBitBtn
        Left = 744
        Top = 56
        Width = 73
        Height = 25
        Caption = #26032#22686
        TabOrder = 5
        OnClick = btnNewClick
      end
      object edtRemark: TEdit
        Left = 502
        Top = 94
        Width = 284
        Height = 21
        TabOrder = 6
      end
      object btnDelete: TBitBtn
        Left = 832
        Top = 56
        Width = 73
        Height = 25
        Caption = #34892#21024#38500
        TabOrder = 7
        OnClick = btnDeleteClick
      end
      object grp3: TGroupBox
        Left = 288
        Top = 16
        Width = 137
        Height = 97
        Caption = 'white_type'
        TabOrder = 8
        object chk_Twhite: TCheckBox
          Left = 8
          Top = 24
          Width = 49
          Height = 25
          Caption = #29305#30333
          TabOrder = 0
        end
        object chk_Pwhite: TCheckBox
          Left = 8
          Top = 56
          Width = 49
          Height = 25
          Caption = #28418#30333
          TabOrder = 1
        end
        object chk_Bwhite: TCheckBox
          Left = 70
          Top = 24
          Width = 50
          Height = 25
          Caption = #26412#30333
          TabOrder = 2
        end
        object chk_SYwhite: TCheckBox
          Left = 70
          Top = 56
          Width = 65
          Height = 17
          Caption = #23569#33639#20809
          TabOrder = 3
        end
      end
      object edt_Speed: TEdit
        Left = 648
        Top = 60
        Width = 65
        Height = 21
        TabOrder = 9
      end
    end
    object pnl3: TPanel
      Left = 1
      Top = 121
      Width = 1034
      Height = 167
      Align = alClient
      Caption = 'pnl3'
      TabOrder = 1
      object cxGridInCapacity: TcxGrid
        Left = 1
        Top = 1
        Width = 1032
        Height = 165
        Align = alClient
        TabOrder = 0
        object cxGridInCapacityTV: TcxGridDBTableView
          DataController.DataSource = dsInCapacity
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsSelection.CellSelect = False
        end
        object cxGridInCapacityLV: TcxGridLevel
          GridView = cxGridInCapacityTV
        end
      end
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 1036
    Height = 268
    Align = alClient
    TabOrder = 1
    object grp2: TGroupBox
      Left = 1
      Top = 1
      Width = 1034
      Height = 96
      Align = alTop
      Caption = #25968#25454#32500#25252
      TabOrder = 0
      object lbl2: TLabel
        Left = 384
        Top = 58
        Width = 48
        Height = 13
        Caption = #26085#20135#33021#65306
      end
      object lbl3: TLabel
        Left = 372
        Top = 26
        Width = 60
        Height = 13
        Caption = #28418#30333#31867#22411#65306
      end
      object lbl5: TLabel
        Left = 539
        Top = 58
        Width = 36
        Height = 13
        Caption = #36710#36895#65306
      end
      object btnModifyQuery: TBitBtn
        Left = 88
        Top = 42
        Width = 65
        Height = 25
        Caption = #26597#35810
        TabOrder = 0
        OnClick = btnModifyQueryClick
      end
      object btnModifyDelete: TBitBtn
        Left = 848
        Top = 56
        Width = 73
        Height = 25
        Caption = #34892#21024#38500
        TabOrder = 1
        OnClick = btnModifyDeleteClick
      end
      object btnModifySave: TBitBtn
        Left = 744
        Top = 56
        Width = 73
        Height = 25
        Caption = #20445#23384
        TabOrder = 2
        OnClick = btnModifySaveClick
      end
      object grp4: TGroupBox
        Left = 208
        Top = 6
        Width = 137
        Height = 83
        Caption = 'white_type'
        TabOrder = 3
        object chk_Twhite_Q: TCheckBox
          Left = 8
          Top = 24
          Width = 49
          Height = 25
          Caption = #29305#30333
          TabOrder = 0
        end
        object chk_Pwhite_Q: TCheckBox
          Left = 8
          Top = 56
          Width = 49
          Height = 25
          Caption = #28418#30333
          TabOrder = 1
        end
        object chk_Bwhite_Q: TCheckBox
          Left = 70
          Top = 24
          Width = 50
          Height = 25
          Caption = #26412#30333
          TabOrder = 2
        end
        object chk_Swhite_Q: TCheckBox
          Left = 70
          Top = 56
          Width = 65
          Height = 17
          Caption = #23569#33639#20809
          TabOrder = 3
        end
      end
      object btn2: TBitBtn
        Left = 664
        Top = 56
        Width = 65
        Height = 25
        Caption = #26356#26032#28418#30333
        TabOrder = 4
        OnClick = btn2Click
      end
      object dbedtmachine_capacity: TDBEdit
        Left = 440
        Top = 56
        Width = 89
        Height = 21
        DataField = 'machine_capacity'
        DataSource = dsQueryapacity
        TabOrder = 5
      end
      object dbedtwhite_type: TDBEdit
        Left = 440
        Top = 24
        Width = 201
        Height = 21
        DataField = 'white_type'
        DataSource = dsQueryapacity
        Enabled = False
        TabOrder = 6
      end
      object btn1: TBitBtn
        Left = 952
        Top = 56
        Width = 73
        Height = 25
        Caption = #20851#38381
        TabOrder = 7
        OnClick = btn1Click
      end
      object dbedtstandard_speed: TDBEdit
        Left = 576
        Top = 56
        Width = 65
        Height = 21
        DataField = 'standard_speed'
        DataSource = dsQueryapacity
        TabOrder = 8
      end
    end
    object pnl4: TPanel
      Left = 1
      Top = 97
      Width = 1034
      Height = 170
      Align = alClient
      Caption = 'pnl4'
      TabOrder = 1
      object cxGridQueryapacity: TcxGrid
        Left = 1
        Top = 1
        Width = 1032
        Height = 168
        Align = alClient
        TabOrder = 0
        object cxGridQueryapacityTV: TcxGridDBTableView
          DataController.DataSource = dsQueryapacity
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsSelection.CellSelect = False
        end
        object cxGridQueryapacityLV: TcxGridLevel
          GridView = cxGridQueryapacityTV
        end
      end
    end
  end
  object dsInCapacity: TDataSource
    DataSet = cdsInCapacity
    Left = 624
    Top = 456
  end
  object cdsInCapacity: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 672
    Top = 456
  end
  object cdsQueryapacity: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 640
    Top = 208
  end
  object dsQueryapacity: TDataSource
    DataSet = cdsQueryapacity
    Left = 680
    Top = 208
  end
  object MakeSQL1: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <
      item
        ParaCaption = #24037#21378
        ParaName = 'factory'
        SelectPoint.Strings = (
          '='
          '<>'
          '>'
          '<'
          '>='
          '<='
          'like'
          'is Null'
          'is Not Null')
      end>
    Left = 224
    Top = 288
  end
end

inherited ChemicalRatioForm: TChemicalRatioForm
  Left = 110
  Top = 105
  Caption = #26579#26009#31995#25968#23383#20856#34920
  OldCreateOrder = True
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 12
  object cxgridRatio: TcxGrid
    Left = 0
    Top = 0
    Width = 424
    Height = 453
    Align = alClient
    TabOrder = 0
    object cxgridtvRatio: TcxGridDBTableView
      DataController.DataSource = dsRatio
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
    end
    object cxGridlRatio: TcxGridLevel
      GridView = cxgridtvRatio
    end
  end
  object pnl1: TPanel
    Left = 424
    Top = 0
    Width = 264
    Height = 453
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    OnMouseUp = pnl1MouseUp
    object cxl1: TcxLabel
      Left = 32
      Top = 56
      Width = 52
      Height = 16
      Caption = #21270#26009#21517#65306
      TabOrder = 0
    end
    object cxdbteName: TcxDBTextEdit
      Left = 88
      Top = 56
      Width = 121
      Height = 20
      DataBinding.DataField = 'Chemical_Name'
      DataBinding.DataSource = dsRatio
      Enabled = False
      TabOrder = 1
    end
    object cxdbseRatio: TcxDBSpinEdit
      Left = 88
      Top = 243
      Width = 121
      Height = 20
      DataBinding.DataField = 'Ratio'
      DataBinding.DataSource = dsRatio
      Properties.MaxValue = 9999
      Properties.ValueType = vtFloat
      TabOrder = 2
      OnExit = cxdbseRatioExit
    end
    object cxl2: TcxLabel
      Left = 20
      Top = 152
      Width = 64
      Height = 16
      Caption = 'Oracle'#21517#65306
      TabOrder = 4
    end
    object cxl3: TcxLabel
      Left = 44
      Top = 120
      Width = 40
      Height = 16
      Caption = #31616#31216#65306
      TabOrder = 5
    end
    object cxl4: TcxLabel
      Left = 20
      Top = 248
      Width = 64
      Height = 16
      Caption = #26579#26009#31995#25968#65306
      TabOrder = 6
    end
    object cxdbteSTDName: TcxDBTextEdit
      Left = 88
      Top = 87
      Width = 121
      Height = 20
      DataBinding.DataField = 'Chemical_STD_Name'
      DataBinding.DataSource = dsRatio
      Enabled = False
      TabOrder = 7
    end
    object cxdbteShortName: TcxDBTextEdit
      Left = 88
      Top = 118
      Width = 121
      Height = 20
      DataBinding.DataField = 'Chemical_Short_Name'
      DataBinding.DataSource = dsRatio
      Enabled = False
      TabOrder = 8
    end
    object cxl5: TcxLabel
      Left = 8
      Top = 88
      Width = 76
      Height = 16
      Caption = #26631#20934#21270#26009#21517#65306
      TabOrder = 9
    end
    object cxdbteOracleName: TcxDBTextEdit
      Left = 88
      Top = 149
      Width = 121
      Height = 20
      DataBinding.DataField = 'Oracle_Name'
      DataBinding.DataSource = dsRatio
      Enabled = False
      TabOrder = 10
    end
    object cxl6: TcxLabel
      Left = 20
      Top = 216
      Width = 64
      Height = 16
      Caption = #20462#35746#26102#38388#65306
      TabOrder = 11
    end
    object cxl7: TcxLabel
      Left = 32
      Top = 184
      Width = 52
      Height = 16
      Caption = #20462#35746#20154#65306
      TabOrder = 12
    end
    object cxdbteOperator: TcxDBTextEdit
      Left = 88
      Top = 181
      Width = 121
      Height = 20
      DataBinding.DataField = 'Operator'
      DataBinding.DataSource = dsRatio
      Enabled = False
      TabOrder = 13
    end
    object cxdbteOperateTime: TcxDBTextEdit
      Left = 88
      Top = 212
      Width = 121
      Height = 20
      DataBinding.DataField = 'Operate_Time'
      DataBinding.DataSource = dsRatio
      Enabled = False
      TabOrder = 14
    end
    object TPanel
      Left = 0
      Top = 416
      Width = 264
      Height = 37
      Align = alBottom
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 15
      DesignSize = (
        264
        37)
      object btn_Save: TBitBtn
        Left = 75
        Top = 10
        Width = 58
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #20445#23384'(&S)'
        Default = True
        Enabled = False
        ParentBiDiMode = False
        TabOrder = 1
        OnClick = btn_SaveClick
      end
      object btn_Exit: TBitBtn
        Left = 200
        Top = 10
        Width = 58
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Cancel = True
        Caption = #36864#20986'(&X)'
        ParentBiDiMode = False
        TabOrder = 3
        OnClick = btn_ExitClick
      end
      object btn_Refresh: TBitBtn
        Left = 12
        Top = 10
        Width = 58
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #21047#26032'(&R)'
        Default = True
        ParentBiDiMode = False
        TabOrder = 0
        OnClick = btn_RefreshClick
      end
      object btnCancel: TBitBtn
        Left = 137
        Top = 10
        Width = 58
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #25764#28040'(&C)'
        Default = True
        Enabled = False
        ParentBiDiMode = False
        TabOrder = 2
        OnClick = btnCancelClick
      end
    end
    object cxdbteID: TcxDBTextEdit
      Left = 88
      Top = 24
      Width = 121
      Height = 20
      DataBinding.DataField = 'Chemical_ID'
      DataBinding.DataSource = dsRatio
      Enabled = False
      TabOrder = 16
      Visible = False
    end
    object cxcbAll: TcxCheckBox
      Left = 88
      Top = 276
      Width = 153
      Height = 21
      Properties.DisplayUnchecked = 'False'
      Properties.OnChange = cxcbAllPropertiesChange
      Properties.Caption = #21516#26102#20462#25152#26377#30340#35760#24405#65288'&A'#65289
      TabOrder = 3
    end
  end
  object dsRatio: TDataSource
    DataSet = cdsRatio
    Left = 360
    Top = 96
  end
  object cdsRatio: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 160
  end
end

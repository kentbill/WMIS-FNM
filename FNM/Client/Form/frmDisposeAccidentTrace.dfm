inherited DisposeAccidentTraceForm: TDisposeAccidentTraceForm
  Left = 228
  Top = 107
  Width = 944
  Height = 598
  Caption = #36319#36394#22788#29702#21333
  OldCreateOrder = True
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object pnl1: TPanel
    Left = 672
    Top = 0
    Width = 264
    Height = 564
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object lbl1: TLabel
      Left = 15
      Top = 196
      Width = 54
      Height = 12
      Caption = #36131#20219#24037#24207':'
    end
    object lbl2: TLabel
      Left = 15
      Top = 170
      Width = 54
      Height = 12
      Caption = #22788#29702#24847#35265':'
    end
    object lbl3: TLabel
      Left = 15
      Top = 19
      Width = 42
      Height = 12
      Caption = #21333'  '#21495':'
    end
    object lbl4: TLabel
      Left = 15
      Top = 44
      Width = 42
      Height = 12
      Caption = #24037'  '#24207':'
    end
    object lbl5: TLabel
      Left = 15
      Top = 69
      Width = 42
      Height = 12
      Caption = #30133#28857#21517':'
    end
    object lbl6: TLabel
      Left = 15
      Top = 95
      Width = 42
      Height = 12
      Caption = #21457#29616#28857':'
    end
    object lbl7: TLabel
      Left = 15
      Top = 120
      Width = 42
      Height = 12
      Caption = #30721'  '#38271':'
    end
    object lbl8: TLabel
      Left = 15
      Top = 145
      Width = 42
      Height = 12
      Caption = #31867'  '#22411':'
    end
    object lbl11: TLabel
      Left = 15
      Top = 221
      Width = 42
      Height = 12
      Caption = #22791'  '#27880':'
    end
    object lbl12: TLabel
      Left = 15
      Top = 246
      Width = 54
      Height = 12
      Hint = #26426#21488#31649#29702#22788#29702#24847#35265
      Caption = #26426#21488#24847#35265':'
    end
    object lbl10: TLabel
      Left = 15
      Top = 317
      Width = 54
      Height = 12
      Caption = #26426#21488#32467#35770':'
    end
    object lbl9: TLabel
      Left = 15
      Top = 341
      Width = 54
      Height = 12
      Caption = #30133#28857#23646#24615':'
    end
    object vle_RepairReasonList: TValueListEditor
      Left = 14
      Top = 360
      Width = 239
      Height = 233
      Align = alCustom
      Color = clMenu
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
      TabOrder = 1
      TitleCaptions.Strings = (
        #23646#24615#21517
        #23646#24615#20540)
      ColWidths = (
        89
        144)
    end
    object cxdbteAccident_NO: TcxDBTextEdit
      Left = 71
      Top = 15
      Width = 183
      Height = 20
      DataBinding.DataField = 'Accident_NO'
      DataBinding.DataSource = dsAccident
      Enabled = False
      Properties.ReadOnly = True
      TabOrder = 2
    end
    object cxdbteOperation_Name: TcxDBTextEdit
      Left = 71
      Top = 40
      Width = 183
      Height = 20
      DataBinding.DataField = 'Operation_Name'
      DataBinding.DataSource = dsAccident
      Enabled = False
      TabOrder = 3
    end
    object cxdbteDefect_Name: TcxDBTextEdit
      Left = 71
      Top = 65
      Width = 183
      Height = 20
      DataBinding.DataField = 'Defect_Name'
      DataBinding.DataSource = dsAccident
      Enabled = False
      TabOrder = 4
    end
    object cxdbteBefore_After: TcxDBTextEdit
      Left = 71
      Top = 90
      Width = 183
      Height = 20
      DataBinding.DataField = 'Before_After'
      DataBinding.DataSource = dsAccident
      Enabled = False
      TabOrder = 5
    end
    object cxdbteQuantity: TcxDBTextEdit
      Left = 71
      Top = 115
      Width = 183
      Height = 20
      DataBinding.DataField = 'Quantity'
      DataBinding.DataSource = dsAccident
      Enabled = False
      TabOrder = 6
    end
    object cxdbteQuality_Type: TcxDBTextEdit
      Left = 71
      Top = 140
      Width = 183
      Height = 20
      DataBinding.DataField = 'Quality_Type'
      DataBinding.DataSource = dsAccident
      Enabled = False
      TabOrder = 7
    end
    object cxdbteDispose_Info: TcxDBTextEdit
      Left = 71
      Top = 165
      Width = 183
      Height = 20
      HelpType = htKeyword
      DataBinding.DataField = 'Dispose_Info'
      DataBinding.DataSource = dsAccident
      Enabled = False
      TabOrder = 8
    end
    object cxdbteQuality_Operation: TcxDBTextEdit
      Left = 71
      Top = 190
      Width = 183
      Height = 20
      HelpType = htKeyword
      DataBinding.DataField = 'Quality_Operation'
      DataBinding.DataSource = dsAccident
      Enabled = False
      TabOrder = 9
    end
    object cxdbteRemark: TcxDBTextEdit
      Left = 71
      Top = 215
      Width = 183
      Height = 20
      HelpType = htKeyword
      DataBinding.DataField = 'Remark'
      DataBinding.DataSource = dsAccident
      Enabled = False
      TabOrder = 10
      OnExit = cxdbteRemarkExit
    end
    object cxdbcbOK: TcxDBCheckBox
      Left = 71
      Top = 312
      Width = 183
      Height = 21
      DataBinding.DataField = 'Final_Result'
      DataBinding.DataSource = dsAccident
      Properties.DisplayUnchecked = 'False'
      Properties.ReadOnly = False
      Properties.OnChange = cxdbcbOKPropertiesChange
      Properties.Caption = #19981#36319#36394
      TabOrder = 11
    end
    object TPanel
      Left = 0
      Top = 507
      Width = 264
      Height = 57
      Align = alBottom
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 0
      DesignSize = (
        264
        57)
      object btn_Save: TBitBtn
        Left = 75
        Top = 30
        Width = 58
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #20445#23384'(&S)'
        Default = True
        Enabled = False
        ParentBiDiMode = False
        TabOrder = 0
        OnClick = btn_SaveClick
      end
      object btn_Exit: TBitBtn
        Left = 200
        Top = 30
        Width = 58
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Cancel = True
        Caption = #36864#20986'(&X)'
        ParentBiDiMode = False
        TabOrder = 1
        OnClick = btn_ExitClick
      end
      object btn_Refresh: TBitBtn
        Left = 12
        Top = 30
        Width = 58
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #21047#26032'(&R)'
        Default = True
        ParentBiDiMode = False
        TabOrder = 2
        OnClick = btn_RefreshClick
      end
      object btnCancel: TBitBtn
        Left = 137
        Top = 30
        Width = 58
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #25764#28040'(&C)'
        Default = True
        Enabled = False
        ParentBiDiMode = False
        TabOrder = 3
        OnClick = btnCancelClick
      end
      object cxcbAll: TcxCheckBox
        Left = 16
        Top = 4
        Width = 241
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.Caption = #26174#31034#25152#26377#26410#36865#24067#30340#22788#29702#21333#65288'&D'#65289
        TabOrder = 4
      end
    end
    object cxteFinal_Remark: TcxTextEdit
      Left = 71
      Top = 289
      Width = 183
      Height = 20
      Properties.OnValidate = cxteFinal_RemarkPropertiesValidate
      TabOrder = 12
      OnEnter = cxteFinal_RemarkEnter
    end
    object cxdbmemFinal_Remark: TcxDBMemo
      Left = 71
      Top = 240
      Width = 183
      Height = 42
      DataBinding.DataField = 'Final_Remark'
      DataBinding.DataSource = dsAccident
      Enabled = False
      TabOrder = 13
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 564
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object cxgridOthers: TcxGrid
      Left = 0
      Top = 395
      Width = 672
      Height = 169
      Hint = #21516#21345#20854#23427#22788#29702#21333
      Align = alBottom
      TabOrder = 0
      object cxgridtvOthers: TcxGridDBTableView
        OnKeyDown = cxgridtvAccidentKeyDown
        OnMouseDown = cxgridtvAccidentMouseDown
        DataController.DataSource = dsOthers
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
      end
      object cxGridlOthers: TcxGridLevel
        GridView = cxgridtvOthers
      end
    end
    object tbcAccident: TTabControl
      Left = 224
      Top = 160
      Width = 329
      Height = 137
      Align = alCustom
      Style = tsFlatButtons
      TabOrder = 1
      Tabs.Strings = (
        #25805#20316#29677#38271'(&0)'
        #26426#21488#31649#29702#21592'(&1)'
        #25805#20316#20027#20219'(&2)'
        #37096#38376#32463#29702'(&3)')
      TabIndex = 0
      Visible = False
      OnChange = tbcAccidentChange
    end
    object gbLeft: TGroupBox
      Left = 0
      Top = 0
      Width = 672
      Height = 395
      Align = alClient
      TabOrder = 2
      object cxgridAccident: TcxGrid
        Left = 2
        Top = 14
        Width = 668
        Height = 379
        Align = alClient
        TabOrder = 0
        object cxgridtvAccident: TcxGridDBTableView
          OnKeyDown = cxgridtvAccidentKeyDown
          OnMouseDown = cxgridtvAccidentMouseDown
          DataController.DataSource = dsAccident
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsData.Inserting = False
        end
        object cxGridlAccident: TcxGridLevel
          GridView = cxgridtvAccident
        end
      end
    end
  end
  object cdsAccident: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 64
  end
  object dsAccident: TDataSource
    DataSet = cdsAccident
    Left = 112
    Top = 64
  end
  object cdsTmp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 240
    Top = 288
  end
  object cdsOthers: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 296
  end
  object dsOthers: TDataSource
    DataSet = cdsOthers
    Left = 136
    Top = 296
  end
end

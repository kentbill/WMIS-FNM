inherited AffirmCardForm: TAffirmCardForm
  Left = 299
  Top = 164
  Width = 965
  Height = 538
  Caption = #25805#20316#23457#21333
  OldCreateOrder = True
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 957
    Height = 463
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object cxgrdSTDArt: TcxGrid
      Left = 0
      Top = 288
      Width = 957
      Height = 175
      Align = alBottom
      TabOrder = 0
      object cxgdtvSTDArt: TcxGridDBTableView
        DataController.DataSource = dsSTDArt
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnFocusedItemChanged = cxgdtvSTDArtFocusedItemChanged
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
      end
      object cxgrdlvlSTDArt: TcxGridLevel
        GridView = cxgdtvSTDArt
      end
    end
    object cxgrdAffirmCard: TcxGrid
      Left = 0
      Top = 0
      Width = 957
      Height = 288
      Align = alClient
      TabOrder = 1
      object cxgdtvAffirmCard: TcxGridDBTableView
        OnDblClick = cxgdtvAffirmCardDblClick
        OnMouseDown = cxgdtvAffirmCardMouseDown
        DataController.DataSource = dsAffirmCard
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnCellClick = cxgdtvAffirmCardCellClick
        OnFocusedItemChanged = cxgdtvSTDArtFocusedItemChanged
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
      end
      object cxgrdlvlAffirmCard: TcxGridLevel
        GridView = cxgdtvAffirmCard
      end
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 463
    Width = 957
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object TPanel
      Left = 0
      Top = -16
      Width = 957
      Height = 57
      Align = alBottom
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 0
      DesignSize = (
        957
        57)
      object btn_Save: TBitBtn
        Left = 498
        Top = 28
        Width = 58
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #20445#23384'(&S)'
        Default = True
        Enabled = False
        ParentBiDiMode = False
        TabOrder = 0
        Visible = False
        OnClick = btn_SaveClick
      end
      object btn_Exit: TBitBtn
        Left = 634
        Top = 28
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
        Left = 182
        Top = 28
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
        Left = 566
        Top = 28
        Width = 58
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #25764#28040'(&C)'
        Default = True
        Enabled = False
        ParentBiDiMode = False
        TabOrder = 3
        Visible = False
        OnClick = btnCancelClick
      end
      object cxcbAll: TcxCheckBox
        Left = 14
        Top = 31
        Width = 129
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.OnChange = cxcbAllPropertiesChange
        Properties.Caption = #26174#31034#25152#26377#65288'&D'#65289
        TabOrder = 4
      end
      object cxcbCheckAll: TcxCheckBox
        Left = 712
        Top = 32
        Width = 129
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.OnChange = cxcbCheckAllPropertiesChange
        Properties.Caption = #25209#37327#24573#30053#65288'&A'#65289
        TabOrder = 5
        Visible = False
        OnClick = cxcbCheckAllClick
      end
      object cxcbNoTrace: TcxCheckBox
        Left = 832
        Top = 32
        Width = 129
        Height = 21
        Properties.DisplayUnchecked = 'False'
        Properties.OnChange = cxcbNoTracePropertiesChange
        Properties.Caption = #25209#37327#19981#36319#36394#65288'&T'#65289
        TabOrder = 6
        Visible = False
        OnClick = cxcbNoTraceClick
      end
      object btn_NotTrace: TBitBtn
        Left = 325
        Top = 28
        Width = 68
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #19981#36319#36394
        Default = True
        ParentBiDiMode = False
        TabOrder = 7
        OnClick = btn_NotTraceClick
      end
      object btn_Ignore: TBitBtn
        Left = 396
        Top = 28
        Width = 68
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #24573#30053
        Default = True
        ParentBiDiMode = False
        TabOrder = 8
        OnClick = btn_IgnoreClick
      end
      object btn_Trace: TBitBtn
        Left = 251
        Top = 28
        Width = 68
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #36319#36394
        Default = True
        ParentBiDiMode = False
        TabOrder = 9
        OnClick = btn_TraceClick
      end
      object btnNew: TBitBtn
        Left = 118
        Top = 27
        Width = 51
        Height = 25
        Anchors = [akLeft, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #26032#22686
        Default = True
        ParentBiDiMode = False
        TabOrder = 10
        OnClick = btnNewClick
      end
    end
  end
  object dsAffirmCard: TDataSource
    DataSet = cdsAffirmCard
    Left = 176
    Top = 64
  end
  object cdsAffirmCard: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 104
    Top = 64
  end
  object cdsSTDArt: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 352
  end
  object dsSTDArt: TDataSource
    DataSet = cdsSTDArt
    Left = 160
    Top = 352
  end
end

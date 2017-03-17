object RecipePlanForm: TRecipePlanForm
  Left = 69
  Top = 115
  Width = 829
  Height = 538
  Caption = #21270#26009#21333#23433#25490
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = KeyDownAControl
  PixelsPerInch = 96
  TextHeight = 12
  object spl1: TSplitter
    Left = 0
    Top = 134
    Width = 821
    Height = 4
    Cursor = crVSplit
    Align = alBottom
  end
  object TPanel
    Left = 0
    Top = 481
    Width = 821
    Height = 30
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 0
    object TPanel
      Left = 0
      Top = 0
      Width = 821
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        821
        30)
      object btn_Exit: TSpeedButton
        Left = 742
        Top = 2
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = ClickAButton
      end
      object btn_Refresh: TSpeedButton
        Left = 658
        Top = 2
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = ClickAButton
      end
    end
  end
  object TPanel
    Left = 0
    Top = 319
    Width = 821
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 821
    Height = 134
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 2
    object pnl2: TPanel
      Left = 2
      Top = 103
      Width = 817
      Height = 29
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        817
        29)
      object btn_NewRecipe: TSpeedButton
        Left = 4
        Top = 3
        Width = 110
        Height = 25
        Caption = #26032#24314'/'#34917#20805'(&N)'
        Flat = True
        ParentShowHint = False
        ShowHint = False
        OnClick = ClickAButton
      end
      object btn_DeleteRecipe: TSpeedButton
        Left = 116
        Top = 3
        Width = 88
        Height = 25
        Hint = #21024#38500#21270#26009#21333'|'#21024#38500#36873#25321#30340#21270#26009#21333
        Caption = #21024#38500#37197#26041'(&D)'
        Flat = True
        OnClick = ClickAButton
      end
      object btn_SplitRecipe: TSpeedButton
        Left = 763
        Top = 3
        Width = 23
        Height = 22
        Hint = #20998#32568'|'#23558#36873#25321#30340#21270#26009#21333#20998#20837#25351#23450#30340#26009#32568
        Anchors = [akTop, akRight]
        Flat = True
        OnClick = ClickAButton
      end
      object btn_DeleteBatch: TSpeedButton
        Left = 789
        Top = 3
        Width = 23
        Height = 22
        Hint = #21024#38500#20998#32568'|'#21024#38500#24403#21069#26009#32568#20013#30340#20998#32568
        Anchors = [akTop, akRight]
        Flat = True
        OnClick = ClickAButton
      end
      object btn_PrintPreview: TSpeedButton
        Left = 206
        Top = 3
        Width = 88
        Height = 25
        Caption = #25171#21360'(&P)'
        Flat = True
        OnClick = ClickAButton
      end
      object btn_EditBaseVolume: TSpeedButton
        Left = 301
        Top = 3
        Width = 88
        Height = 25
        Caption = #20462#25913#20307#31215
        Flat = True
        OnClick = Btn_EditBaseVolumeClick
      end
      object txt2: TStaticText
        Left = 471
        Top = 10
        Width = 58
        Height = 16
        Anchors = [akTop, akRight]
        Caption = #26009#32568'(&V):'
        TabOrder = 0
      end
      object cbb_VatCode: TComboBox
        Left = 521
        Top = 6
        Width = 112
        Height = 20
        Style = csDropDownList
        Anchors = [akTop, akRight]
        ItemHeight = 12
        TabOrder = 1
        OnChange = cbb_VatCodeChange
      end
      object StaticText1: TStaticText
        Left = 639
        Top = 10
        Width = 58
        Height = 16
        Anchors = [akTop, akRight]
        Caption = #20307#31215'(&M):'
        TabOrder = 2
      end
      object edt_BatchVolume: TEdit
        Left = 689
        Top = 6
        Width = 72
        Height = 20
        Anchors = [akTop, akRight]
        TabOrder = 3
      end
    end
    object cxGrid2: TcxGrid
      Left = 2
      Top = 2
      Width = 817
      Height = 101
      Align = alClient
      TabOrder = 1
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = True
      RootLevelOptions.DetailTabsPosition = dtpTop
      object cxgtv_RecipeNOs: TcxGridDBTableView
        DataController.DataSource = ds_NoFinishRecipe
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
      end
      object cxGridLevel1: TcxGridLevel
        Caption = #24453#20998#32568#37197#26041#20449#24687
        GridView = cxgtv_RecipeNOs
      end
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 138
    Width = 821
    Height = 181
    Align = alBottom
    TabOrder = 3
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    RootLevelOptions.DetailTabsPosition = dtpTop
    object cxgtv_RecipeNOBatch: TcxGridDBTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OnCustomDrawCell = cxgtv_RecipeNOBatchCustomDrawCell
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
    end
    object cxGrid1Level1: TcxGridLevel
      Caption = #24050#20998#32568#20449#24687
      GridView = cxgtv_RecipeNOBatch
    end
  end
  object cxsplBottom: TcxSplitter
    Left = 0
    Top = 322
    Width = 821
    Height = 8
    Hint = #21270#26009#24773#20917
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salBottom
    Control = grp1
    OnAfterOpen = cxsplBottomAfterOpen
    OnAfterClose = cxsplBottomAfterClose
    ShowHint = True
    ParentShowHint = False
  end
  object grp1: TGroupBox
    Left = 0
    Top = 330
    Width = 821
    Height = 151
    Align = alBottom
    Caption = #21270#26009#24773#20917'(&9)'
    TabOrder = 5
    DesignSize = (
      821
      151)
    object cxgridRecipeInfo: TcxGrid
      Left = 2
      Top = 96
      Width = 546
      Height = 22
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object cxgridtvRecipeInfo: TcxGridDBTableView
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
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfAlwaysVisible
      end
      object cxGridl1: TcxGridLevel
        GridView = cxgridtvRecipeInfo
      end
    end
    object sclbVat: TScrollBox
      Left = 2
      Top = 14
      Width = 817
      Height = 135
      Align = alClient
      TabOrder = 1
    end
    object btnVat: TBitBtn
      Left = 741
      Top = 117
      Width = 75
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = #21047#26032'(F4)'
      TabOrder = 2
      OnClick = btnVatClick
    end
  end
  object cds_NoFinishRecipe: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = AfterScrollADataSet
    Left = 64
    Top = 347
  end
  object ds_NoFinishRecipe: TDataSource
    DataSet = cds_NoFinishRecipe
    Left = 32
    Top = 347
  end
  object cds_BatchList: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = AfterScrollADataSet
    Left = 152
    Top = 347
  end
  object ds_BatchList: TDataSource
    DataSet = cds_BatchList
    Left = 184
    Top = 347
  end
  object cdsVatInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 352
  end
  object tmr1: TTimer
    Enabled = False
    Interval = 300000
    OnTimer = tmr1Timer
    Left = 344
    Top = 352
  end
end

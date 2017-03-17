object ArtReviewForm: TArtReviewForm
  Left = 127
  Top = 214
  Width = 632
  Height = 407
  Caption = #24037#33402#22238#39038
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Position = poOwnerFormCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object spl1: TSplitter
    Left = 247
    Top = 3
    Width = 3
    Height = 336
    Cursor = crHSplit
  end
  object TPanel
    Left = 0
    Top = 3
    Width = 247
    Height = 336
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object TPanel
      Left = 0
      Top = 283
      Width = 247
      Height = 53
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 4
      DesignSize = (
        247
        53)
      object btn_InputArtReview: TSpeedButton
        Left = 207
        Top = 20
        Width = 25
        Height = 22
        Anchors = [akTop, akRight]
        Flat = True
        OnClick = btn_InputArtReviewClick
      end
      object TStaticText
        Left = 2
        Top = 2
        Width = 243
        Height = 16
        Align = alTop
        Caption = #36873#25321#30340#21345#21495
        TabOrder = 0
      end
      object edt_SelectCard: TEdit
        Left = 12
        Top = 22
        Width = 187
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        OnKeyDown = edt_SelectCardKeyDown
      end
    end
    object TPanel
      Left = 0
      Top = 0
      Width = 247
      Height = 50
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 0
      DesignSize = (
        247
        50)
      object btn_GetSendCardList: TSpeedButton
        Left = 207
        Top = 20
        Width = 25
        Height = 22
        Anchors = [akTop, akRight]
        Flat = True
        OnClick = btn_GetSendCardListClick
      end
      object TStaticText
        Left = 2
        Top = 2
        Width = 243
        Height = 16
        Align = alTop
        Caption = #26085#26399#36873#25321':'
        TabOrder = 0
      end
      object dtp_SelectDate: TDateTimePicker
        Left = 12
        Top = 22
        Width = 187
        Height = 20
        Anchors = [akLeft, akTop, akRight]
        CalAlignment = dtaLeft
        Date = 38221.9555707292
        Time = 38221.9555707292
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
      end
    end
    object TPanel
      Left = 0
      Top = 50
      Width = 247
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object TPanel
      Left = 0
      Top = 53
      Width = 247
      Height = 227
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 2
      object txt_Only: TStaticText
        Left = 2
        Top = 2
        Width = 243
        Height = 16
        Align = alTop
        Caption = #24453#36755#22238#39038#21345#21495
        TabOrder = 0
      end
      object lv_CardList: TListView
        Left = 2
        Top = 18
        Width = 243
        Height = 207
        Align = alClient
        Columns = <
          item
            Caption = #21345#21495
            Width = 65
          end
          item
            Caption = #30721#38271
            Width = 45
          end
          item
            Caption = #21697#21517
            Width = 120
          end>
        ColumnClick = False
        GridLines = True
        HideSelection = False
        Items.Data = {1D0000000100000000000000FFFFFFFFFFFFFFFF000000000000000000}
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lv_CardListChange
        OnDblClick = lv_CardListDblClick
      end
    end
    object TPanel
      Left = 0
      Top = 280
      Width = 247
      Height = 3
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
    end
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object pnl_Only: TPanel
    Left = 250
    Top = 3
    Width = 374
    Height = 336
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object cxgrid_FactArtDtl: TcxGrid
      Left = 2
      Top = 2
      Width = 370
      Height = 332
      Align = alClient
      TabOrder = 0
      RootLevelOptions.DetailTabsPosition = dtpTop
      object cxgridtv_FactArtDtl: TcxGridDBTableView
        OnKeyDown = cxgridtv_FactArtDtlKeyDown
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
      end
      object cxGridl_FactArtDtl: TcxGridLevel
        Caption = #22238#39038#36755#20837#39033#30446
        GridView = cxgridtv_FactArtDtl
        Options.DetailTabsPosition = dtpTop
      end
    end
  end
  object TPanel
    Left = 0
    Top = 343
    Width = 624
    Height = 37
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 4
    object TPanel
      Left = 0
      Top = 0
      Width = 624
      Height = 37
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        624
        37)
      object btn_Help: TSpeedButton
        Left = 9
        Top = 5
        Width = 81
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
      end
      object btn_Exit: TSpeedButton
        Left = 535
        Top = 5
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
      object btn_SaveArtReview: TSpeedButton
        Left = 443
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveArtReviewClick
      end
    end
  end
  object TPanel
    Left = 0
    Top = 339
    Width = 624
    Height = 4
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
  end
  object cds_FactArtDtl: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterEdit = cds_FactArtDtlAfterEdit
    Left = 144
    Top = 248
  end
  object ds_FactArtDtl: TDataSource
    DataSet = cds_FactArtDtl
    Left = 176
    Top = 248
  end
end

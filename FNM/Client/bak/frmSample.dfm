object SampleForm: TSampleForm
  Left = 91
  Top = 70
  Width = 800
  Height = 601
  Caption = #21462#26679#27979#35797
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
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
  object pnl_Only: TPanel
    Left = 0
    Top = 0
    Width = 560
    Height = 535
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object spl_Only: TSplitter
      Left = 0
      Top = 237
      Width = 560
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object TPanel
      Left = 0
      Top = 240
      Width = 560
      Height = 35
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object btn_Add: TSpeedButton
        Left = 215
        Top = 5
        Width = 75
        Height = 25
        Caption = #28155#21152'(&A)'
        Flat = True
        OnClick = ClickAButton
      end
      object btn_Delete: TSpeedButton
        Left = 108
        Top = 5
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        Flat = True
        OnClick = ClickAButton
      end
      object btn_Refresh: TSpeedButton
        Left = 406
        Top = 5
        Width = 75
        Height = 25
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = ClickAButton
      end
    end
    object TGroupBox
      Left = 0
      Top = 275
      Width = 560
      Height = 260
      Align = alClient
      Caption = #24050#25910#26679':'
      TabOrder = 1
      object lv_ReceivSample: TListView
        Left = 2
        Top = 14
        Width = 556
        Height = 244
        Align = alClient
        Columns = <
          item
            Caption = #24207#21495
          end
          item
            Alignment = taCenter
            Caption = #24067#21495
            Width = 70
          end
          item
            Alignment = taCenter
            Caption = #21345#21495
            Width = 70
          end
          item
            Alignment = taCenter
            Caption = #21697#21517'ID'
          end
          item
            Alignment = taCenter
            Caption = #21697#21517
            Width = 90
          end
          item
            Alignment = taCenter
            Caption = #24037#24207
            Width = 60
          end
          item
            Alignment = taCenter
            Caption = #21462#26679#20195#21495
            Width = 70
          end
          item
            Alignment = taCenter
            Caption = #21462#26679#38271#24230
            Width = 70
          end>
        GridLines = True
        TabOrder = 0
        ViewStyle = vsReport
        OnSelectItem = lv_ReceivSampleSelectItem
      end
    end
    object TGroupBox
      Left = 0
      Top = 0
      Width = 560
      Height = 237
      Align = alTop
      Caption = #26426#21488#24050#21462#26679':'
      TabOrder = 2
      object cxgrid_SampleInfo: TcxGrid
        Left = 2
        Top = 14
        Width = 556
        Height = 221
        Align = alClient
        TabOrder = 0
        object cxgridtv_SampleInfo: TcxGridDBTableView
          DataController.DataSource = ds_SampleInfo
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
        end
        object cxGridl_SampleInfo: TcxGridLevel
          GridView = cxgridtv_SampleInfo
        end
      end
    end
  end
  object cxspl1: TcxSplitter
    Left = 560
    Top = 0
    Width = 8
    Height = 535
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salRight
    Control = grp_Only
  end
  object TPanel
    Left = 0
    Top = 538
    Width = 792
    Height = 36
    Align = alBottom
    Anchors = [akRight, akBottom]
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 3
    object TPanel
      Left = 0
      Top = 0
      Width = 792
      Height = 36
      Align = alBottom
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        792
        36)
      object btn3: TSpeedButton
        Left = 8
        Top = 5
        Width = 75
        Height = 25
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
      end
      object btn_Save: TSpeedButton
        Left = 623
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = ClickAButton
      end
      object btn_Exit: TSpeedButton
        Left = 708
        Top = 6
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
    end
  end
  object TPanel
    Left = 0
    Top = 535
    Width = 792
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
  end
  object grp_Only: TGroupBox
    Left = 568
    Top = 0
    Width = 224
    Height = 535
    Align = alRight
    Caption = #27979#35797#39033#30446':'
    TabOrder = 4
    object Vle_SampleList: TValueListEditor
      Left = 2
      Top = 14
      Width = 220
      Height = 519
      Align = alClient
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
      TabOrder = 0
      TitleCaptions.Strings = (
        #27979#35797#39033#30446
        #21462#26679#30721#38271)
      ColWidths = (
        121
        93)
    end
  end
  object cds_SampleInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    ReadOnly = True
    AfterScroll = cds_SampleInfoAfterScroll
    Left = 88
    Top = 528
  end
  object ds_SampleInfo: TDataSource
    DataSet = cds_SampleInfo
    Left = 120
    Top = 528
  end
  object cds_Samplist: TClientDataSet
    Aggregates = <>
    Params = <>
    ReadOnly = True
    Left = 152
    Top = 528
  end
end

object CheckModifyFactoryForm: TCheckModifyFactoryForm
  Left = 132
  Top = 184
  Width = 1106
  Height = 480
  Caption = 'CheckModifyFactoryForm'
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
    Top = 0
    Width = 241
    Height = 441
    Align = alLeft
    Caption = 'pnl1'
    TabOrder = 0
    object pnl3: TPanel
      Left = 1
      Top = 65
      Width = 239
      Height = 375
      Align = alClient
      Caption = 'pnl3'
      TabOrder = 0
      object lv_query: TListView
        Left = 1
        Top = 1
        Width = 237
        Height = 373
        Hint = #21697#21517#21015#34920'|'#26410#30830#35748#24037#33402#30340#21697#21517#21015#34920
        Align = alClient
        Columns = <
          item
            Caption = #23457#25209#21333#21495
            Width = 60
          end
          item
            Caption = #30003#35831#26102#38388
          end
          item
            Caption = #30003#35831#29366#24577
          end
          item
            Caption = #30003#35831#20154
          end>
        GridLines = True
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnCustomDrawItem = lv_queryCustomDrawItem
        OnDblClick = lv_QueryDblClick
      end
    end
    object grp1: TGroupBox
      Left = 1
      Top = 1
      Width = 239
      Height = 64
      Align = alTop
      Caption = #25968#25454#25805#20316
      TabOrder = 1
      object btnQuery: TBitBtn
        Left = 40
        Top = 24
        Width = 105
        Height = 25
        Caption = #26597#35810#24453#23457#25209#20449#24687
        TabOrder = 0
        OnClick = btnQueryClick
      end
    end
  end
  object pnl2: TPanel
    Left = 241
    Top = 0
    Width = 849
    Height = 441
    Align = alClient
    Caption = 'pnl2'
    TabOrder = 1
    object pnl4: TPanel
      Left = 1
      Top = 1
      Width = 847
      Height = 65
      Align = alTop
      TabOrder = 0
      object btnChoseAll: TBitBtn
        Left = 96
        Top = 24
        Width = 73
        Height = 25
        Caption = #36873#25321#20840#37096
        TabOrder = 0
        OnClick = btnChoseAllClick
      end
      object btnCheck: TBitBtn
        Left = 200
        Top = 23
        Width = 65
        Height = 25
        Caption = #23457#25209
        TabOrder = 1
        OnClick = btnCheckClick
      end
      object btnArt: TBitBtn
        Left = 640
        Top = 32
        Width = 89
        Height = 25
        Caption = #26174#31034#24037#33402#26126#32454
        TabOrder = 2
        OnClick = btnStepNo
      end
      object btnclose: TBitBtn
        Left = 312
        Top = 24
        Width = 75
        Height = 25
        Caption = #20851#38381
        TabOrder = 3
        OnClick = btncloseClick
      end
    end
    object pnl5: TPanel
      Left = 1
      Top = 66
      Width = 640
      Height = 374
      Align = alLeft
      Caption = 'pnl5'
      TabOrder = 1
      object cxgrdCheck: TcxGrid
        Left = 1
        Top = 1
        Width = 638
        Height = 372
        Align = alClient
        TabOrder = 0
        OnDblClick = cxgrdCheckDblClick
        OnEnter = cxgrdCheckEnter
        object cxgrdCheckTV: TcxGridDBTableView
          OnKeyDown = cxgrdCheckTVKeyDown
          DataController.DataSource = dsCheck
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCellClick = cxgrdCheckTVCellClick
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
        end
        object cxgrdCheckLV: TcxGridLevel
          GridView = cxgrdCheckTV
        end
      end
    end
    object pnl6: TPanel
      Left = 641
      Top = 66
      Width = 207
      Height = 374
      Align = alClient
      Caption = 'pnl6'
      TabOrder = 2
      object cxgrdStdStep: TcxGrid
        Left = 1
        Top = 1
        Width = 205
        Height = 372
        Align = alClient
        TabOrder = 0
        object cxgrdStdStepTV: TcxGridDBTableView
          DataController.DataSource = dsStdStep
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OptionsView.GroupByBox = False
        end
        object cxgrdStdStepLV: TcxGridLevel
          GridView = cxgrdStdStepTV
        end
      end
    end
  end
  object cdsCheck: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 216
  end
  object dsCheck: TDataSource
    DataSet = cdsCheck
    Left = 432
    Top = 216
  end
  object dsStdStep: TDataSource
    DataSet = cdsStdStep
    Left = 800
    Top = 248
  end
  object cdsStdStep: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 760
    Top = 248
  end
  object MakeSQL: TMakeSQL
    Caption = #26597#35810#26465#20214#32534#36753
    ItemNames = <>
    Left = 168
    Top = 24
  end
  object cdsQuery: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 152
  end
  object dsQuery: TDataSource
    DataSet = cdsQuery
    Left = 104
    Top = 152
  end
end

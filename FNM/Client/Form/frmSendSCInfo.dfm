inherited SendSCInfoForm: TSendSCInfoForm
  Left = 290
  Top = 210
  Width = 1083
  Height = 549
  Caption = #22806#21457#30830#35748
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 477
    Width = 1067
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object TPanel
      Left = 0
      Top = 0
      Width = 1067
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        1067
        34)
      object btnClose: TSpeedButton
        Left = 994
        Top = 7
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
      object btnSave: TSpeedButton
        Left = 224
        Top = 7
        Width = 100
        Height = 26
        Caption = #20445#23384#30003#35831'(&P)'
        Enabled = False
        Flat = True
        OnClick = btnSaveClick
      end
      object btnRefresh: TSpeedButton
        Left = 52
        Top = 8
        Width = 75
        Height = 25
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object btnSb: TSpeedButton
        Left = 885
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #30830#35748#25910#24067'(&M)'
        Flat = True
        OnClick = btnSbClick
      end
    end
  end
  object cxspl1: TcxSplitter
    Left = 753
    Top = 0
    Width = 8
    Height = 477
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salRight
    Control = cxgrdOnlineSendInfo
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 753
    Height = 477
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object spl1: TSplitter
      Left = 0
      Top = 238
      Width = 753
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object grpSource: TGroupBox
      Left = 0
      Top = 0
      Width = 753
      Height = 238
      Align = alClient
      Caption = #26410#25171#21333
      TabOrder = 0
      object pnl7: TPanel
        Left = 2
        Top = 206
        Width = 749
        Height = 30
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lblQuantitySource: TLabel
          Left = 78
          Top = 12
          Width = 30
          Height = 12
          Caption = #30721#38271':'
        end
        object edtQuantitySource: TEdit
          Left = 110
          Top = 4
          Width = 70
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 0
        end
      end
      object lvSource: TListView
        Left = 2
        Top = 14
        Width = 749
        Height = 192
        Align = alClient
        Columns = <
          item
            Caption = #21345#21495
            Width = 60
          end
          item
            Alignment = taCenter
            Caption = #25968#37327
            Width = 60
          end
          item
            Caption = #22806#21457#24037#24207
            Width = 65
          end
          item
            Alignment = taCenter
            Caption = #21697#21517
            Width = 120
          end
          item
            Caption = #27493#39588#21495
            Width = 120
          end
          item
            Caption = #25490#21333#21495
            Width = 80
          end
          item
            Caption = #24037#33402#20540
            Width = 80
          end
          item
            Caption = #24403#21069#37096#38376
            Width = 80
          end
          item
            Caption = #24403#21069#27493#39588
            Width = 80
          end
          item
            Caption = #24403#21069#24037#24207
            Width = 80
          end
          item
            Caption = #24037#24207#21152#24037#22320#28857
            Width = 80
          end
          item
            Caption = #20102#26426#22825#25968
            Width = 100
          end>
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnChange = lvSourceChange
        OnColumnClick = lvSourceColumnClick
        OnDblClick = lvSourceDblClick
        OnKeyUp = lvSourceKeyUp
      end
    end
    object TPanel
      Left = 0
      Top = 241
      Width = 753
      Height = 236
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object pnlButton: TPanel
        Left = 0
        Top = 0
        Width = 753
        Height = 32
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object btnRight: TSpeedButton
          Left = 14
          Top = 4
          Width = 75
          Height = 25
          Enabled = False
          Flat = True
          OnClick = btnRightClick
        end
        object btnRightAll: TSpeedButton
          Left = 92
          Top = 4
          Width = 75
          Height = 25
          Enabled = False
          Flat = True
          OnClick = btnRightAllClick
        end
        object btnLeft: TSpeedButton
          Left = 170
          Top = 4
          Width = 75
          Height = 25
          Enabled = False
          Flat = True
          OnClick = btnLeftClick
        end
        object btnLeftAll: TSpeedButton
          Left = 249
          Top = 4
          Width = 75
          Height = 25
          Enabled = False
          Flat = True
          OnClick = btnLeftAllClick
        end
      end
      object grpDestinate: TGroupBox
        Left = 0
        Top = 32
        Width = 753
        Height = 204
        Align = alClient
        Caption = #24050#25171#21333
        TabOrder = 1
        object pnl8: TPanel
          Left = 2
          Top = 172
          Width = 749
          Height = 30
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object lblQuantityDestinate: TLabel
            Left = 77
            Top = 11
            Width = 30
            Height = 12
            Caption = #30721#38271':'
          end
          object edtQuantityDestinate: TEdit
            Left = 106
            Top = 3
            Width = 70
            Height = 20
            Color = clMenu
            ReadOnly = True
            TabOrder = 0
          end
        end
        object lvDestinate: TListView
          Left = 2
          Top = 14
          Width = 749
          Height = 158
          Align = alClient
          Columns = <
            item
              Caption = #21345#21495
              Width = 60
            end
            item
              Alignment = taCenter
              Caption = #25968#37327
              Width = 60
            end
            item
              Caption = #24037#24207#21517
              Width = 65
            end
            item
              Alignment = taCenter
              Caption = #21697#21517
              Width = 120
            end>
          GridLines = True
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnChange = lvDestinateChange
          OnColumnClick = lvDestinateColumnClick
          OnCustomDraw = lvDestinateCustomDraw
          OnDblClick = lvDestinateDblClick
          OnKeyUp = lvDestinateKeyUp
        end
      end
    end
  end
  object cxgrdOnlineSendInfo: TcxGrid
    Left = 761
    Top = 0
    Width = 306
    Height = 477
    Align = alRight
    TabOrder = 3
    object cxgrdtvSendInfo: TcxGridDBTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.MultiSelect = True
    end
    object cxgrdlvlOnLineGridlcxgrid2Level1: TcxGridLevel
      GridView = cxgrdtvSendInfo
    end
  end
  object cdsSendInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 544
    Top = 448
  end
  object dsSendInfo: TDataSource
    DataSet = cdsSendInfo
    Left = 584
    Top = 448
  end
end

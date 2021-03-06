inherited SendInfoForm: TSendInfoForm
  Left = 277
  Top = 120
  Width = 792
  Height = 517
  Caption = #36865#24067
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 441
    Width = 776
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object TPanel
      Left = 0
      Top = 4
      Width = 776
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        776
        34)
      object lblDestinate: TLabel
        Left = 5
        Top = 17
        Width = 54
        Height = 12
        Caption = #36865#24067#22320#28857':'
      end
      object btnClose: TSpeedButton
        Left = 703
        Top = 7
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
      object btnSave: TSpeedButton
        Left = 623
        Top = 7
        Width = 75
        Height = 26
        Anchors = [akTop, akRight]
        Caption = #25171#21360'(&P)'
        Enabled = False
        Flat = True
        OnClick = btnSaveClick
      end
      object btnRefresh: TSpeedButton
        Left = 196
        Top = 8
        Width = 75
        Height = 25
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object lbQualityOperator: TLabel
        Left = 338
        Top = 17
        Width = 54
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #36136#37327#29677#38271':'
      end
      object lbPlanOperator: TLabel
        Left = 474
        Top = 17
        Width = 54
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #35745#21010#29677#38271':'
      end
      object cbbDestinate: TComboBox
        Left = 61
        Top = 9
        Width = 132
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 0
        OnChange = cbbDestinateChange
      end
      object cbQualityOperator: TComboBox
        Left = 394
        Top = 9
        Width = 73
        Height = 20
        Style = csDropDownList
        Anchors = [akRight, akBottom]
        ItemHeight = 12
        TabOrder = 1
      end
      object cbPlanOperator: TComboBox
        Left = 530
        Top = 9
        Width = 73
        Height = 20
        Style = csDropDownList
        Anchors = [akRight, akBottom]
        ItemHeight = 12
        TabOrder = 2
      end
    end
  end
  object cxspl1: TcxSplitter
    Left = 336
    Top = 0
    Width = 8
    Height = 441
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salRight
    Control = cxgridSendInfo
  end
  object cxgridSendInfo: TcxGrid
    Left = 344
    Top = 0
    Width = 432
    Height = 441
    Align = alRight
    TabOrder = 2
    object cxgridtvSendInfo: TcxGridDBTableView
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
    object cxGridlcxgrid2Level1: TcxGridLevel
      GridView = cxgridtvSendInfo
    end
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 336
    Height = 441
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object spl1: TSplitter
      Left = 0
      Top = 202
      Width = 336
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object grpSource: TGroupBox
      Left = 0
      Top = 0
      Width = 336
      Height = 202
      Align = alClient
      Caption = #26410#25171#21333
      TabOrder = 0
      object pnl7: TPanel
        Left = 2
        Top = 170
        Width = 332
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
        Width = 332
        Height = 156
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
          end
          item
            Caption = #19978#24037#24207#32467#26463#26102#38388
            Width = 120
          end
          item
            Caption = 'Holder'
          end
          item
            Caption = 'Car_No'
          end
          item
            Caption = 'WHITE_TYPE'
          end
          item
            Caption = 'LOCATIONNO'
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
      Top = 205
      Width = 336
      Height = 236
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object pnlButton: TPanel
        Left = 0
        Top = 0
        Width = 336
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
        Width = 336
        Height = 204
        Align = alClient
        Caption = #24050#25171#21333
        TabOrder = 1
        object pnl8: TPanel
          Left = 2
          Top = 172
          Width = 332
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
          Width = 332
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
  object cdsSendInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 448
  end
  object dsSendInfo: TDataSource
    DataSet = cdsSendInfo
    Left = 496
    Top = 448
  end
end

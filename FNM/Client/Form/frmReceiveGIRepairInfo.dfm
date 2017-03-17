inherited ReceiveGIRepairInfoForm: TReceiveGIRepairInfoForm
  Left = 197
  Top = 153
  Width = 759
  Height = 429
  Caption = #22238#25910#25361#20462#24067
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object spl1: TSplitter
    Left = 0
    Top = 133
    Width = 751
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object grpSource: TGroupBox
    Left = 0
    Top = 0
    Width = 751
    Height = 133
    Align = alClient
    Caption = #26410#25509#25910#30340#25361#20462#24067
    TabOrder = 0
    object lvSource: TListView
      Left = 2
      Top = 14
      Width = 747
      Height = 117
      Align = alClient
      Columns = <
        item
          Caption = #24067#21495
          Width = 80
        end
        item
          Alignment = taCenter
          Caption = #25968#37327
          Width = 60
        end
        item
          Caption = #21697#21517'ID'
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
      OnClick = lvSourceClick
      OnColumnClick = lvSourceColumnClick
      OnDblClick = lvSourceDblClick
      OnKeyUp = lvSourceKeyUp
    end
  end
  object TPanel
    Left = 0
    Top = 364
    Width = 751
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object TPanel
      Left = 0
      Top = 4
      Width = 751
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        751
        34)
      object btnRefresh: TSpeedButton
        Left = 489
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object btnSave: TSpeedButton
        Left = 577
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20445#23384'&S)'
        Enabled = False
        Flat = True
        OnClick = btnSaveClick
      end
      object btnClose: TSpeedButton
        Left = 665
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
    end
  end
  object TPanel
    Left = 0
    Top = 136
    Width = 751
    Height = 228
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pnl_Only: TPanel
      Left = 0
      Top = 0
      Width = 751
      Height = 36
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object btnRight: TSpeedButton
        Left = 176
        Top = 5
        Width = 75
        Height = 25
        Enabled = False
        Flat = True
        OnClick = btnRightClick
      end
      object btnRightAll: TSpeedButton
        Left = 264
        Top = 5
        Width = 75
        Height = 25
        Enabled = False
        Flat = True
        OnClick = btnRightAllClick
      end
      object btnLeft: TSpeedButton
        Left = 352
        Top = 5
        Width = 75
        Height = 25
        Enabled = False
        Flat = True
        OnClick = btnLeftClick
      end
      object btnLeftAll: TSpeedButton
        Left = 440
        Top = 5
        Width = 75
        Height = 25
        Enabled = False
        Flat = True
        OnClick = btnLeftAllClick
      end
    end
    object grp4: TGroupBox
      Left = 0
      Top = 36
      Width = 751
      Height = 192
      Align = alClient
      Caption = #24050#25509#25910#30340#25361#20462#24067
      TabOrder = 1
      object lvDestinate: TListView
        Left = 2
        Top = 14
        Width = 747
        Height = 176
        Align = alClient
        Columns = <
          item
            Caption = #24067#21495
            Width = 80
          end
          item
            Alignment = taCenter
            Caption = #25968#37327
            Width = 60
          end
          item
            Caption = #21697#21517'ID'
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
        OnClick = lvDestinateClick
        OnColumnClick = lvDestinateColumnClick
        OnCustomDraw = lvDestinateCustomDraw
        OnDblClick = lvDestinateDblClick
        OnKeyUp = lvDestinateKeyUp
      end
    end
  end
  object cdsGIRepairInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 71
  end
end

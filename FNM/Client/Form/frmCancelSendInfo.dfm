inherited CancelSendInfoForm: TCancelSendInfoForm
  Left = 145
  Top = 174
  Width = 812
  Height = 485
  Caption = #21462#28040#36865#24067
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object cxsplLeft: TcxSplitter
    Left = 0
    Top = 153
    Width = 804
    Height = 8
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salTop
    Control = lvFNCard
  end
  object lvFNCard: TListView
    Left = 0
    Top = 0
    Width = 804
    Height = 153
    Align = alTop
    Columns = <
      item
        Caption = #21345#21495
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = #25968#37327
        Width = 90
      end
      item
        Alignment = taCenter
        Caption = #21697#21517'ID'
        Width = 48
      end
      item
        Alignment = taCenter
        Caption = #21697#21517
        Width = 190
      end>
    GridLines = True
    Items.Data = {1D0000000100000000000000FFFFFFFFFFFFFFFF000000000000000000}
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object cxgridSendInfo: TcxGrid
    Left = 0
    Top = 161
    Width = 804
    Height = 259
    Align = alClient
    TabOrder = 2
    object cxgridtvSendInfo: TcxGridDBTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
    end
    object cxGridlSendInfo: TcxGridLevel
      GridView = cxgridtvSendInfo
    end
  end
  object TPanel
    Left = 0
    Top = 420
    Width = 804
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object pnlBottom: TPanel
      Left = 0
      Top = 4
      Width = 804
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        804
        34)
      object lblNoteNO: TLabel
        Left = 8
        Top = 16
        Width = 30
        Height = 12
        Caption = #21333#21495':'
      end
      object btnSave: TSpeedButton
        Left = 632
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Enabled = False
        Flat = True
        OnClick = btnSaveClick
      end
      object btnClose: TSpeedButton
        Left = 712
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnCloseClick
      end
      object btnRefresh: TSpeedButton
        Left = 544
        Top = 6
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object cbbNoteNO: TComboBox
        Left = 43
        Top = 10
        Width = 115
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 0
        OnSelect = cbbNoteNOSelect
      end
    end
  end
  object dsSendInfo: TDataSource
    DataSet = cdsSendInfo
    Left = 168
    Top = 424
  end
  object cdsSendInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 424
  end
end

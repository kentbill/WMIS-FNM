object qiFabricListForm: TqiFabricListForm
  Left = 39
  Top = 149
  Width = 1224
  Height = 500
  BorderIcons = [biSystemMenu]
  Caption = #25104#21697#24067#21495#20449#24687
  Color = clLime
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 1208
    Height = 462
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 0
    object pnl2: TPanel
      Left = 1
      Top = 425
      Width = 1202
      Height = 32
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnClose: TBitBtn
        Left = 1048
        Top = 4
        Width = 75
        Height = 25
        Cancel = True
        Caption = #36864#20986' &X'
        TabOrder = 0
        OnClick = btnCloseClick
        Glyph.Data = {
          42020000424D4202000000000000420000002800000010000000100000000100
          1000030000000002000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C00000042004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C0000000000420042004200000000000000000000000000000000
          1F7C1F7C1F7C1F7C000000420042004200001F7C1F7C00001F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C000000420042000000001F7C1F7C00001F7C1F7C1F7C1F7C
          10001F7C1F7C1F7C000000420042004200001F7C1F7C00001F7C1F7C1F7C1000
          10001F7C1F7C1F7C000000420042004200001F7C1F7C00001F7C1F7C10001000
          1000100010001F7C000000420042004200001F7C1F7C00001F7C100010001000
          1000100010001F7C000000420042004200001F7C1F7C00001F7C1F7C10001000
          1000100010001F7C00000042004200001F7C1F7C1F7C00001F7C1F7C1F7C1000
          10001F7C1F7C1F7C0000004200001F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
          10001F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C000000000000000000000000000000001F7C1F7C1F7C1F7C
          1F7C1F7C1F7C}
      end
    end
    object cxGridFabric: TcxGrid
      Left = 1
      Top = 1
      Width = 1202
      Height = 424
      Align = alClient
      TabOrder = 0
      object cxViewFabric: TcxGridDBTableView
        DataController.DataSource = DS_FabricList
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
      end
      object cxLevelFabric: TcxGridLevel
        GridView = cxViewFabric
      end
    end
  end
  object CDS_FabricList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 56
  end
  object DS_FabricList: TDataSource
    DataSet = CDS_FabricList
    Left = 88
    Top = 56
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxGridFabric
    PopupMenus = <>
    Left = 216
    Top = 160
  end
end

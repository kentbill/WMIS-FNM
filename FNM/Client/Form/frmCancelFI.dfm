inherited CancelFIForm: TCancelFIForm
  Left = 116
  Top = 104
  Width = 628
  Height = 426
  Caption = #21462#28040#25104#21697#22238#20462
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnl1: TPanel
    Left = 0
    Top = 365
    Width = 620
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      620
      34)
    object lblNote_NO: TLabel
      Left = 101
      Top = 17
      Width = 54
      Height = 12
      Caption = #36865#24067#21333#21495':'
    end
    object btnSave: TButton
      Left = 461
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnClose: TButton
      Left = 538
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object btnQuery: TButton
      Left = 284
      Top = 5
      Width = 75
      Height = 25
      Caption = #26597#35810'(&Q)'
      TabOrder = 2
      OnClick = btnQueryClick
    end
    object chkAll: TCheckBox
      Left = 8
      Top = 11
      Width = 78
      Height = 17
      Caption = #20840#36873'/'#21462#28040
      TabOrder = 3
      OnClick = chkAllClick
    end
    object edtNoteNO: TEdit
      Left = 157
      Top = 8
      Width = 121
      Height = 20
      TabOrder = 4
    end
  end
  object cxgdReceiveInfo1: TcxGrid
    Left = 185
    Top = 0
    Width = 435
    Height = 365
    Align = alClient
    TabOrder = 1
    object cxgridtvReceiveInfo: TcxGridDBTableView
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
    object cxGridl2: TcxGridLevel
      GridView = cxgridtvReceiveInfo
    end
  end
  object grp1: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 365
    Align = alLeft
    Caption = #24067#21495#21015#34920
    TabOrder = 2
    object chklstFabricNOList: TCheckListBox
      Left = 2
      Top = 14
      Width = 181
      Height = 349
      Align = alClient
      ItemHeight = 12
      TabOrder = 0
    end
  end
  object dsReceiveInfo: TDataSource
    DataSet = cdsReceiveInfo
    Left = 408
    Top = 280
  end
  object cdsReceiveInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 448
    Top = 280
  end
end

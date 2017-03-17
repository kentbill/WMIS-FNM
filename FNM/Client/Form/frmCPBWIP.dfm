inherited CPBWIPForm: TCPBWIPForm
  Left = 266
  Top = 174
  Caption = 'CPB  WIP'
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object cxgridWIP: TcxGrid
    Left = 0
    Top = 36
    Width = 688
    Height = 417
    Align = alClient
    TabOrder = 0
    object cxgridtvCPBWIP: TcxGridDBTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OnCustomDrawCell = cxgridtvCPBWIPCustomDrawCell
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
    end
    object cxGridlWIP: TcxGridLevel
      GridView = cxgridtvCPBWIP
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lbl1: TLabel
      Left = 16
      Top = 16
      Width = 30
      Height = 12
      Caption = #37096#38376':'
    end
    object btnClose: TSpeedButton
      Left = 267
      Top = 5
      Width = 78
      Height = 25
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnCloseClick
    end
    object btnRefresh: TSpeedButton
      Left = 185
      Top = 5
      Width = 78
      Height = 25
      Caption = #21047#26032'(&R)'
      Flat = True
      OnClick = btnRefreshClick
    end
    object cbbCurrentDept: TComboBox
      Left = 49
      Top = 9
      Width = 130
      Height = 20
      Hint = #24403#21069#24212#29992#31243#24207#27491#22312#25805#20316#30340#37096#38376
      ItemHeight = 12
      TabOrder = 0
    end
  end
  object dsCPBWIP: TDataSource
    DataSet = cdsCPBWIP
    Left = 112
    Top = 224
  end
  object cdsCPBWIP: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 224
  end
end

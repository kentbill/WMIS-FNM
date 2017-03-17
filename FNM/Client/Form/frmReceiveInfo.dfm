inherited ReceiveInfoForm: TReceiveInfoForm
  Left = 183
  Top = 131
  Width = 1163
  Height = 447
  Caption = #25353#21333#25509#25910#22383#24067
  OldCreateOrder = True
  Position = poDefault
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlClient: TPanel
    Left = 0
    Top = 371
    Width = 1147
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object pnl1: TPanel
      Left = 0
      Top = 4
      Width = 1147
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        1147
        34)
      object lbl2: TLabel
        Left = 4
        Top = 17
        Width = 54
        Height = 12
        Caption = #22383#24067#26469#28304':'
      end
      object lblNote_NO: TLabel
        Left = 229
        Top = 17
        Width = 54
        Height = 12
        Caption = #36865#24067#21333#21495':'
      end
      object btnSave: TButton
        Left = 903
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Enabled = False
        TabOrder = 0
        OnClick = btnSaveClick
      end
      object btnCancel: TButton
        Left = 988
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21462#28040#25910#22383'(&C)'
        TabOrder = 1
        OnClick = btnCancelClick
      end
      object btnClose: TButton
        Left = 1073
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = #36864#20986'(&X)'
        TabOrder = 2
        OnClick = btnCloseClick
      end
      object cbbNormal: TComboBox
        Left = 68
        Top = 9
        Width = 150
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 3
        OnChange = cbbNormalChange
      end
      object cbbNoteNO: TComboBox
        Left = 284
        Top = 9
        Width = 150
        Height = 20
        ItemHeight = 12
        TabOrder = 4
        OnChange = cbbNoteNOChange
      end
      object btnQuery: TButton
        Left = 819
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #26597#35810'(&Q)'
        TabOrder = 5
        OnClick = btnQueryClick
      end
      object btnLoadFromFile: TButton
        Left = 512
        Top = 5
        Width = 75
        Height = 25
        Caption = #23548#20837
        TabOrder = 6
        Visible = False
        OnClick = btnLoadFromFileClick
      end
      object btnCancelIFI: TButton
        Left = 592
        Top = 5
        Width = 89
        Height = 25
        Caption = #25209#37327#21462#28040#25910#22383
        TabOrder = 7
        Visible = False
        OnClick = btnCancelIFIClick
      end
    end
  end
  object cxgridReceiveInfo: TcxGrid
    Left = 0
    Top = 0
    Width = 1147
    Height = 371
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
  object dsReceiveInfo: TDataSource
    DataSet = cdsReceiveInfo
    Left = 192
    Top = 408
  end
  object cdsReceiveInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 408
  end
  object cdsPublic: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 408
  end
end

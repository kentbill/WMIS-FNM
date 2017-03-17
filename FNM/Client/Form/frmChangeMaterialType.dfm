inherited ChangeMaterialTypeForm: TChangeMaterialTypeForm
  Left = 144
  Top = 103
  Width = 798
  Height = 529
  Caption = #26356#25913#24067#30340#31867#22411
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 790
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnQuery: TSpeedButton
      Left = 319
      Top = 3
      Width = 75
      Height = 25
      Caption = #26597#35810'(&Q)'
      Flat = True
      OnClick = btnQueryClick
    end
    object rgType: TRadioGroup
      Left = 0
      Top = 0
      Width = 143
      Height = 36
      Align = alLeft
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        #24067#21495
        #21345#21495)
      TabOrder = 0
      OnClick = rgTypeClick
    end
    object lbledtCode: TLabeledEdit
      Left = 185
      Top = 9
      Width = 121
      Height = 20
      CharCase = ecUpperCase
      EditLabel.Width = 30
      EditLabel.Height = 12
      EditLabel.Caption = #24067#21495':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      OEMConvert = True
      TabOrder = 1
      OnKeyDown = lbledtCodeKeyDown
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 36
    Width = 790
    Height = 405
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object cxGridFabric: TcxGrid
      Left = 0
      Top = 0
      Width = 790
      Height = 405
      Align = alClient
      TabOrder = 0
      object cxGridtvFabric: TcxGridDBTableView
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        NavigatorButtons.First.Visible = True
        NavigatorButtons.PriorPage.Visible = True
        NavigatorButtons.Prior.Visible = True
        NavigatorButtons.Next.Visible = True
        NavigatorButtons.NextPage.Visible = True
        NavigatorButtons.Last.Visible = True
        NavigatorButtons.Insert.Visible = True
        NavigatorButtons.Delete.Visible = True
        NavigatorButtons.Edit.Visible = True
        NavigatorButtons.Post.Visible = True
        NavigatorButtons.Cancel.Visible = True
        NavigatorButtons.Refresh.Visible = True
        NavigatorButtons.SaveBookmark.Visible = True
        NavigatorButtons.GotoBookmark.Visible = True
        NavigatorButtons.Filter.Visible = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
      end
      object cxGridlFabric: TcxGridLevel
        GridView = cxGridtvFabric
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 441
    Width = 790
    Height = 61
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      790
      61)
    object btnSave: TSpeedButton
      Left = 616
      Top = 26
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      OnClick = btnSaveClick
    end
    object btnClose: TSpeedButton
      Left = 702
      Top = 26
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnCloseClick
    end
    object lbReason: TLabel
      Left = 277
      Top = 17
      Width = 30
      Height = 12
      Caption = #21407#22240':'
    end
    object Label2: TLabel
      Left = 44
      Top = 17
      Width = 54
      Height = 12
      Caption = #36131#20219#37096#38376':'
    end
    object Label1: TLabel
      Left = 44
      Top = 41
      Width = 54
      Height = 12
      Caption = #24067#30340#31867#22411':'
    end
    object mmoReason: TMemo
      Left = 316
      Top = 9
      Width = 269
      Height = 44
      TabOrder = 1
    end
    object cbbDutyDepartment: TComboBox
      Left = 101
      Top = 9
      Width = 164
      Height = 20
      Style = csDropDownList
      CharCase = ecUpperCase
      ItemHeight = 12
      TabOrder = 0
    end
    object cbMaterialType: TComboBox
      Left = 101
      Top = 33
      Width = 164
      Height = 20
      Style = csDropDownList
      CharCase = ecUpperCase
      ItemHeight = 12
      TabOrder = 2
      Items.Strings = (
        #27491#24120#24067
        #22788#29702#24067
        #23384#27801#24067)
    end
  end
  object dsFabric: TDataSource
    DataSet = cdsFabric
    Left = 267
    Top = 114
  end
  object cdsFabric: TClientDataSet
    Aggregates = <>
    Params = <>
    ReadOnly = True
    Left = 324
    Top = 90
  end
end

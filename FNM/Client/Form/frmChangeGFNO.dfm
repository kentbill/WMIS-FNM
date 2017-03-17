inherited ChangeGFNOForm: TChangeGFNOForm
  Left = 289
  Top = 98
  Width = 993
  Height = 541
  Caption = #21697#21517#20462#25913
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 977
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
    Width = 977
    Height = 395
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object cxGridFabric: TcxGrid
      Left = 0
      Top = 0
      Width = 977
      Height = 395
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
    Top = 431
    Width = 977
    Height = 72
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      977
      72)
    object btnSave: TSpeedButton
      Left = 811
      Top = 40
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
      Left = 897
      Top = 39
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #36864#20986'(&X)'
      Flat = True
      OnClick = btnCloseClick
    end
    object lbReason: TLabel
      Left = 589
      Top = 42
      Width = 30
      Height = 12
      Caption = #21407#22240':'
    end
    object Label1: TLabel
      Left = 208
      Top = 21
      Width = 60
      Height = 12
      Caption = #26032#21697#21517'/ID:'
    end
    object Label2: TLabel
      Left = 208
      Top = 49
      Width = 54
      Height = 12
      Caption = #26032#25490#21333#21495':'
    end
    object lbledtOldGFID: TLabeledEdit
      Left = 72
      Top = 13
      Width = 121
      Height = 20
      CharCase = ecUpperCase
      Color = clMenu
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #21407#21697#21517'/ID:'
      LabelPosition = lpLeft
      LabelSpacing = 3
      OEMConvert = True
      ReadOnly = True
      TabOrder = 0
    end
    object lbledtOldJobNO: TLabeledEdit
      Left = 72
      Top = 41
      Width = 121
      Height = 20
      CharCase = ecUpperCase
      Color = clMenu
      EditLabel.Width = 54
      EditLabel.Height = 12
      EditLabel.Caption = #21407#25490#21333#21495':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      OEMConvert = True
      ReadOnly = True
      TabOrder = 1
    end
    object mmoReason: TMemo
      Left = 620
      Top = 13
      Width = 169
      Height = 49
      TabOrder = 4
    end
    object cxbeGFKey: TcxButtonEdit
      Left = 273
      Top = 13
      Width = 121
      Height = 20
      Properties.Buttons = <
        item
          Default = True
          Kind = bkGlyph
        end>
      Properties.CharCase = ecUpperCase
      Properties.OnButtonClick = cxbeGFKeyPropertiesButtonClick
      Style.LookAndFeel.Kind = lfStandard
      TabOrder = 2
      OnKeyDown = cxbeGFKeyKeyDown
    end
    object cbbJobNO: TComboBox
      Left = 273
      Top = 41
      Width = 121
      Height = 20
      Style = csDropDownList
      CharCase = ecUpperCase
      ItemHeight = 12
      TabOrder = 3
      OnChange = cbbJobNOChange
      OnEnter = cbbJobNOEnter
    end
    object Memo1: TMemo
      Left = 825
      Top = 8
      Width = 162
      Height = 28
      BorderStyle = bsNone
      Color = clMenu
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      Lines.Strings = (
        #35831#36890#30693#24037#33402#21592#21450#26102#20462#25913#27492#21345#30340
        #23454#38469#24037#33402)
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
    object lbledtLength: TLabeledEdit
      Left = 481
      Top = 41
      Width = 104
      Height = 20
      CharCase = ecUpperCase
      EditLabel.Width = 78
      EditLabel.Height = 12
      EditLabel.Caption = #22383#24067#30041#20301#30721#38271':'
      LabelPosition = lpLeft
      LabelSpacing = 3
      OEMConvert = True
      TabOrder = 6
      OnKeyDown = lbledtCodeKeyDown
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

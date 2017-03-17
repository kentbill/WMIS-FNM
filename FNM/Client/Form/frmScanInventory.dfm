object ScanInventoryForm: TScanInventoryForm
  Left = 273
  Top = 205
  Width = 940
  Height = 480
  Caption = #25195#25551#30424#28857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 924
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 36
      Height = 13
      Caption = #21345#21495#65306
    end
    object edtFnCard: TEdit
      Left = 72
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
      OnChange = edtFnCardChange
    end
    object Button2: TButton
      Left = 243
      Top = 13
      Width = 70
      Height = 25
      Caption = #28165#31354'(&C)'
      TabOrder = 1
      OnClick = Button2Click
    end
    object btnImport: TButton
      Left = 419
      Top = 13
      Width = 86
      Height = 25
      Caption = #23548#20837'(&E)'
      TabOrder = 2
      OnClick = btnImportClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 396
    Width = 924
    Height = 46
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      924
      46)
    object Button1: TButton
      Left = 814
      Top = 10
      Width = 79
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #36864#20986'(&C)'
      TabOrder = 0
      OnClick = Button1Click
    end
    object btnSave: TButton
      Left = 678
      Top = 10
      Width = 79
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #20445#23384'(&S)'
      TabOrder = 1
      OnClick = btnSaveClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 49
    Width = 924
    Height = 347
    Align = alClient
    TabOrder = 2
    object cxGridJobTrace: TcxGrid
      Left = 1
      Top = 1
      Width = 922
      Height = 345
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 0
      object cxtvJobTrace: TcxGridDBTableView
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
        OptionsSelection.MultiSelect = True
      end
      object cxGridJobTraceLevel1: TcxGridLevel
        GridView = cxtvJobTrace
      end
    end
  end
  object cdsCardInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 208
    Top = 96
  end
  object dsCardInfo: TDataSource
    DataSet = cdsCardInfo
    Left = 240
    Top = 96
  end
  object dlgOpen1: TOpenDialog
    Left = 352
    Top = 128
  end
end

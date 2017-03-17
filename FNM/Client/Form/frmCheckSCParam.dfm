object CheckSCParamForm: TCheckSCParamForm
  Left = 229
  Top = 142
  Width = 893
  Height = 480
  Caption = #22806#21457#21442#25968#30830#35748
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 877
    Height = 73
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 240
      Top = 32
      Width = 36
      Height = 13
      Caption = #21697#21517#65306
    end
    object cbGF_NO: TComboBox
      Left = 294
      Top = 28
      Width = 185
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object btnResfresh: TButton
      Left = 528
      Top = 25
      Width = 97
      Height = 25
      Caption = #21047#26032'(&R)'
      TabOrder = 1
      OnClick = btnResfreshClick
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 8
      Width = 225
      Height = 57
      TabOrder = 2
      object rdoCheck: TRadioButton
        Left = 12
        Top = 19
        Width = 75
        Height = 25
        Caption = #24050#30830#35748
        TabOrder = 0
      end
      object rdoNoCheck: TRadioButton
        Left = 89
        Top = 19
        Width = 71
        Height = 25
        Caption = #26410#30830#35748
        TabOrder = 1
      end
      object rdoAll: TRadioButton
        Left = 166
        Top = 23
        Width = 53
        Height = 17
        Caption = #25152#26377
        Checked = True
        TabOrder = 2
        TabStop = True
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 73
    Width = 877
    Height = 311
    Align = alClient
    TabOrder = 1
    object cxgridCheckInfo: TcxGrid
      Left = 2
      Top = 15
      Width = 873
      Height = 294
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object cxgridtvCheckInfo: TcxGridDBTableView
        DataController.DataSource = dsCheckInfo
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsCustomize.ColumnFiltering = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.MultiSelect = True
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfAlwaysVisible
      end
      object cxGridlCheckInfo: TcxGridLevel
        GridView = cxgridtvCheckInfo
      end
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 384
    Width = 877
    Height = 58
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      877
      58)
    object btnOK: TButton
      Left = 536
      Top = 24
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #30830#35748'(&O)'
      TabOrder = 0
      OnClick = btnOKClick
    end
  end
  object cdsCheckInfo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 528
    Top = 312
  end
  object dsCheckInfo: TDataSource
    DataSet = cdsCheckInfo
    Left = 568
    Top = 312
  end
end

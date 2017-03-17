object ColorInfoEditFrom: TColorInfoEditFrom
  Left = 91
  Top = 120
  Width = 1103
  Height = 624
  Caption = #39068#33394#20449#24687#24405#20837
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1087
    Height = 121
    Align = alTop
    TabOrder = 0
    object lbl1: TLabel
      Left = 35
      Top = 27
      Width = 36
      Height = 13
      Caption = #21697#21517#65306
    end
    object edtGF_NO: TEdit
      Left = 86
      Top = 23
      Width = 161
      Height = 21
      TabOrder = 0
    end
    object btnQuery: TButton
      Left = 286
      Top = 22
      Width = 89
      Height = 25
      Caption = #26597#35810'(&Q)'
      TabOrder = 1
      OnClick = btnQueryClick
    end
    object grp1: TGroupBox
      Left = 496
      Top = 1
      Width = 590
      Height = 119
      Align = alRight
      TabOrder = 2
      object lbl2: TLabel
        Left = 106
        Top = 24
        Width = 36
        Height = 13
        Caption = #30333#24230#65306
      end
      object lbl3: TLabel
        Left = 106
        Top = 56
        Width = 36
        Height = 13
        Caption = #32423#21035#65306
      end
      object lbl4: TLabel
        Left = 77
        Top = 89
        Width = 60
        Height = 13
        Caption = #33394#20809#20559#21521#65306
      end
      object cbbColor: TComboBox
        Left = 165
        Top = 84
        Width = 121
        Height = 21
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 0
        Text = #40644
        Items.Strings = (
          #32418
          #40644
          #20848)
      end
      object cbbGrade: TComboBox
        Left = 165
        Top = 50
        Width = 121
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = 'C+'
        Items.Strings = (
          'B'
          'B+'
          'B/C'
          'B/C+'
          'C'
          'C/D'
          'C/D+'
          'C+'
          'D'
          'D+')
      end
      object edtWhite: TEdit
        Left = 165
        Top = 16
        Width = 116
        Height = 21
        TabOrder = 2
      end
      object btnSave: TButton
        Left = 325
        Top = 80
        Width = 105
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 3
        OnClick = btnSaveClick
      end
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 121
    Width = 1087
    Height = 465
    Align = alClient
    TabOrder = 1
    object cxgrdOnline: TcxGrid
      Left = 1
      Top = 1
      Width = 1085
      Height = 463
      Align = alClient
      TabOrder = 0
      object cxgrdtvGridOnLine: TcxGridDBTableView
        DataController.DataSource = dsOnline
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.MultiSelect = True
        OptionsView.GroupByBox = False
      end
      object cxgrdlvlOnLine: TcxGridLevel
        GridView = cxgrdtvGridOnLine
      end
    end
  end
  object cdsOnline: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 208
  end
  object dsOnline: TDataSource
    DataSet = cdsOnline
    Left = 312
    Top = 208
  end
end

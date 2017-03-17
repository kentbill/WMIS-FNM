object TrackOnlineForm: TTrackOnlineForm
  Left = 191
  Top = 140
  Width = 1033
  Height = 569
  Caption = #22312#32447#36319#36394#26597#35810
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
    Top = 481
    Width = 1025
    Height = 54
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 4
      Top = 20
      Width = 36
      Height = 13
      Caption = #21697#21517#65306
    end
    object Label2: TLabel
      Left = 159
      Top = 21
      Width = 60
      Height = 13
      Caption = #24320#22987#26102#38388#65306
    end
    object Label3: TLabel
      Left = 320
      Top = 21
      Width = 60
      Height = 13
      Caption = #32467#26463#26102#38388#65306
    end
    object btnSave: TButton
      Left = 697
      Top = 16
      Width = 73
      Height = 25
      Caption = #22312#32447#26597#35810'(&Q)'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnClose: TButton
      Left = 781
      Top = 16
      Width = 73
      Height = 25
      Caption = #36864#20986'(&C)'
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object btnResult: TButton
      Left = 598
      Top = 17
      Width = 85
      Height = 25
      Caption = #36319#36394#32467#26524'(&I)'
      TabOrder = 2
      OnClick = btnResultClick
    end
    object edtGF_NO: TEdit
      Left = 39
      Top = 16
      Width = 113
      Height = 21
      TabOrder = 3
    end
    object dtpBegin: TDateTimePicker
      Left = 220
      Top = 16
      Width = 85
      Height = 25
      CalAlignment = dtaLeft
      Date = 40544
      Time = 40544
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 4
    end
    object dtpEND: TDateTimePicker
      Left = 382
      Top = 16
      Width = 91
      Height = 25
      CalAlignment = dtaLeft
      Date = 41254.9999884259
      Time = 41254.9999884259
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 5
    end
    object Button1: TButton
      Left = 479
      Top = 16
      Width = 73
      Height = 25
      Caption = #32467#26524#26597#35810
      TabOrder = 6
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 1025
    Height = 481
    Align = alClient
    TabOrder = 1
    object cxgrdTrack: TcxGrid
      Left = 2
      Top = 15
      Width = 1021
      Height = 464
      Align = alClient
      TabOrder = 0
      object cxgdtvTrack: TcxGridDBTableView
        DataController.DataSource = dsTrack
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
      end
      object cxgrdlvlTrack: TcxGridLevel
        GridView = cxgdtvTrack
      end
    end
  end
  object cdsTrack: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 120
  end
  object dsTrack: TDataSource
    DataSet = cdsTrack
    Left = 200
    Top = 120
  end
  object cdsReslut: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 176
  end
  object dsResult: TDataSource
    DataSet = cdsReslut
    Left = 200
    Top = 176
  end
end

object EditCarNoByFNCardForm: TEditCarNoByFNCardForm
  Left = 207
  Top = 133
  Width = 970
  Height = 481
  Caption = #36710#20301#20462#25913
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGEditCarNO: TcxGrid
    Left = 0
    Top = 0
    Width = 954
    Height = 409
    Align = alClient
    TabOrder = 1
    object cxTVEditCarNO: TcxGridDBTableView
      DataController.DataSource = DSEditCarNOData
      DataController.Filter.OnBeforeChange = cxTVEditCarNODataControllerFilterBeforeChange
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OptionsView.GroupByBox = False
    end
    object cxLEditCarNO: TcxGridLevel
      GridView = cxTVEditCarNO
    end
  end
  object PnlBottom: TPanel
    Left = 0
    Top = 409
    Width = 954
    Height = 34
    Align = alBottom
    TabOrder = 0
    object Label2: TLabel
      Left = 456
      Top = 11
      Width = 49
      Height = 14
      AutoSize = False
      Caption = #22320#20301#21495
    end
    object Label1: TLabel
      Left = 16
      Top = 11
      Width = 57
      Height = 13
      AutoSize = False
      Caption = #21518#25972#21345#21495
    end
    object lbl1: TLabel
      Left = 300
      Top = 11
      Width = 49
      Height = 14
      AutoSize = False
      Caption = #36710#29260#21495
    end
    object Panel2: TPanel
      Left = 848
      Top = 1
      Width = 105
      Height = 32
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object SBtnExit: TSpeedButton
        Left = 8
        Top = 4
        Width = 78
        Height = 25
        Caption = #36864#20986
        OnClick = SBtnExitClick
      end
    end
    object EdtNewCarNo: TEdit
      Left = 506
      Top = 7
      Width = 129
      Height = 21
      TabOrder = 1
    end
    object EdtFNCard: TEdit
      Left = 80
      Top = 7
      Width = 129
      Height = 21
      TabOrder = 0
      OnChange = EdtFNCardChange
    end
    object ButQuery: TButton
      Left = 216
      Top = 5
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 3
      OnClick = ButQueryClick
    end
    object BtnEdit: TButton
      Left = 722
      Top = 5
      Width = 75
      Height = 25
      Caption = #20462#25913
      TabOrder = 4
      Visible = False
      OnClick = BtnEditClick
    end
    object BtnSave: TButton
      Left = 642
      Top = 5
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 5
      OnClick = BtnSaveClick
    end
    object edt1: TEdit
      Left = 343
      Top = 8
      Width = 104
      Height = 20
      TabOrder = 6
    end
  end
  object CDSEditCarNO: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 304
  end
  object DSEditCarNOData: TDataSource
    DataSet = CDSEditCarNO
    Left = 392
    Top = 304
  end
end

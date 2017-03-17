object FNEditCarNoForm: TFNEditCarNoForm
  Left = 200
  Top = 158
  Width = 999
  Height = 532
  Caption = #22383#24067#36816#36755#19979#26426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object cxGEditCarNO: TcxGrid
    Left = 0
    Top = 0
    Width = 983
    Height = 457
    Align = alClient
    TabOrder = 0
    object cxTVEditCarNO: TcxGridDBTableView
      DataController.DataSource = DSEditCarNOData
      DataController.Filter.OnBeforeChange = cxTVEditCarNODataControllerFilterBeforeChange
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      NavigatorButtons.ConfirmDelete = False
      OnEditValueChanged = cxTVEditCarNOEditValueChanged
      OptionsView.GroupByBox = False
    end
    object cxLEditCarNO: TcxGridLevel
      GridView = cxTVEditCarNO
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 457
    Width = 983
    Height = 37
    Align = alBottom
    TabOrder = 1
    object SBtnRefresh: TSpeedButton
      Left = 120
      Top = 6
      Width = 75
      Height = 25
      Caption = #21047#26032
      OnClick = SBtnRefreshClick
    end
    object Label1: TLabel
      Left = 392
      Top = 12
      Width = 41
      Height = 13
      AutoSize = False
      Caption = #22320#20301#21495
    end
    object Label2: TLabel
      Left = 216
      Top = 12
      Width = 33
      Height = 13
      AutoSize = False
      Caption = #36710#29260#21495
    end
    object SBtnSave: TSpeedButton
      Left = 656
      Top = 6
      Width = 75
      Height = 25
      Caption = #20445#23384
      OnClick = SBtnSaveClick
    end
    object Panel2: TPanel
      Left = 887
      Top = 1
      Width = 95
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object SBtnExit: TSpeedButton
        Left = 11
        Top = 5
        Width = 75
        Height = 25
        Caption = #36864#20986
        OnClick = SBtnExitClick
      end
    end
    object chkLocalQuery: TCheckBox
      Left = 16
      Top = 10
      Width = 89
      Height = 17
      Alignment = taLeftJustify
      Caption = #25171#24320#20998#32452#26639
      TabOrder = 1
      OnClick = chkLocalQueryClick
    end
    object EdtNewLocation: TEdit
      Left = 440
      Top = 8
      Width = 129
      Height = 21
      TabOrder = 2
      OnKeyPress = EdtNewLocationKeyPress
    end
    object BtnEdit: TButton
      Left = 576
      Top = 6
      Width = 75
      Height = 25
      Caption = #20462#25913
      TabOrder = 3
      OnClick = BtnEditClick
    end
    object EctCarNo: TEdit
      Left = 255
      Top = 8
      Width = 121
      Height = 21
      Color = clWhite
      TabOrder = 4
    end
  end
  object CDSEditCarNO: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = CDSEditCarNOAfterScroll
    Left = 360
    Top = 304
  end
  object DSEditCarNOData: TDataSource
    DataSet = CDSEditCarNO
    Left = 392
    Top = 304
  end
end

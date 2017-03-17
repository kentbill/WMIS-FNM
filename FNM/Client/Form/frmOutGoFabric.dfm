object OutGoFabricForm: TOutGoFabricForm
  Left = 257
  Top = 137
  Width = 992
  Height = 540
  Caption = #20986#24067
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GrpWait: TGroupBox
    Left = 0
    Top = 0
    Width = 976
    Height = 353
    Align = alTop
    Caption = #24453#20986#24067#21015#34920
    TabOrder = 0
    object cxGrdWait: TcxGrid
      Left = 2
      Top = 15
      Width = 972
      Height = 298
      Align = alClient
      TabOrder = 0
      object cxTVWait: TcxGridDBTableView
        OnDblClick = cxTVWaitDblClick
        DataController.DataSource = DSWait
        DataController.Filter.OnBeforeChange = cxTVWaitDataControllerFilterBeforeChange
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = cxTVWaitCustomDrawCell
        OnEditValueChanged = cxTVWaitEditValueChanged
        OptionsView.GroupByBox = False
      end
      object cxLWait: TcxGridLevel
        GridView = cxTVWait
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 313
      Width = 972
      Height = 38
      Align = alBottom
      TabOrder = 1
      object SBtnAdd: TSpeedButton
        Left = 824
        Top = 6
        Width = 73
        Height = 25
        Caption = #28155#21152
        OnClick = SBtnAddClick
      end
      object SBtnCancel: TSpeedButton
        Left = 900
        Top = 6
        Width = 75
        Height = 25
        Caption = #25764#38144
        OnClick = SBtnCancelClick
      end
      object SBtnRefresh: TSpeedButton
        Left = 133
        Top = 6
        Width = 75
        Height = 25
        Caption = #21047#26032
        OnClick = SBtnRefreshClick
      end
      object Label2: TLabel
        Left = 319
        Top = 12
        Width = 42
        Height = 13
        AutoSize = False
        Caption = #36710#29260#21495
      end
      object Label1: TLabel
        Left = 454
        Top = 12
        Width = 41
        Height = 13
        AutoSize = False
        Caption = #22320#20301#21495
      end
      object Label3: TLabel
        Left = 8
        Top = 12
        Width = 57
        Height = 13
        AutoSize = False
        Caption = #26469#28304#37096#38376
      end
      object chkLocalQuery: TCheckBox
        Left = 224
        Top = 10
        Width = 89
        Height = 17
        Alignment = taLeftJustify
        Caption = #25171#24320#20998#32452#26639
        TabOrder = 0
        OnClick = chkLocalQueryClick
      end
      object EdtNewLocation: TEdit
        Left = 496
        Top = 8
        Width = 129
        Height = 21
        TabOrder = 1
        OnKeyPress = EdtNewLocationKeyPress
      end
      object BtnEdit: TButton
        Left = 640
        Top = 6
        Width = 75
        Height = 25
        Caption = #20462#25913
        TabOrder = 2
        OnClick = BtnEditClick
      end
      object BtnSave: TButton
        Left = 719
        Top = 6
        Width = 75
        Height = 25
        Caption = #20445#23384
        TabOrder = 3
        OnClick = BtnSaveClick
      end
      object EdtCarNo: TEdit
        Left = 360
        Top = 8
        Width = 80
        Height = 21
        Color = clWhite
        TabOrder = 4
      end
      object CBBSrcDepartment: TComboBox
        Left = 64
        Top = 8
        Width = 65
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
      end
    end
  end
  object GrpSelection: TGroupBox
    Left = 0
    Top = 361
    Width = 976
    Height = 141
    Align = alClient
    Caption = #20986#24067#21015#34920
    TabOrder = 1
    object cxGrdSelection: TcxGrid
      Left = 2
      Top = 15
      Width = 972
      Height = 83
      Align = alClient
      TabOrder = 0
      object cxTVSelection: TcxGridDBTableView
        OnDblClick = cxTVSelectionDblClick
        DataController.DataSource = DSSelection
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = cxTVSelectionCustomDrawCell
        OptionsView.GroupByBox = False
      end
      object cxLSelection: TcxGridLevel
        GridView = cxTVSelection
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 98
      Width = 972
      Height = 41
      Align = alBottom
      TabOrder = 1
      object Panel3: TPanel
        Left = 774
        Top = 1
        Width = 197
        Height = 39
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object SBtnOutGo: TSpeedButton
          Left = 8
          Top = 8
          Width = 75
          Height = 25
          Caption = #20986#24067
          OnClick = SBtnOutGoClick
        end
        object SBtnExit: TSpeedButton
          Left = 91
          Top = 8
          Width = 75
          Height = 25
          Caption = #36864#20986
          OnClick = SBtnExitClick
        end
      end
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 353
    Width = 976
    Height = 8
    HotZoneClassName = 'TcxMediaPlayer8Style'
    AlignSplitter = salTop
    Control = GrpWait
  end
  object CDSWait: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = CDSWaitAfterScroll
    Left = 152
    Top = 192
  end
  object CDSSelection: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 400
  end
  object DSWait: TDataSource
    DataSet = CDSWait
    Left = 192
    Top = 192
  end
  object DSSelection: TDataSource
    DataSet = CDSSelection
    Left = 176
    Top = 400
  end
end

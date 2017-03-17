object PrepareFabricForm: TPrepareFabricForm
  Left = 206
  Top = 69
  Width = 980
  Height = 540
  Caption = #22791#24067
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 964
    Height = 501
    Align = alClient
    Caption = #22791#24067#21015#34920
    TabOrder = 0
    object cxGrdWait: TcxGrid
      Left = 2
      Top = 15
      Width = 960
      Height = 446
      Align = alClient
      TabOrder = 0
      object cxTVWait: TcxGridDBTableView
        DataController.DataSource = DSWait
        DataController.Filter.OnBeforeChange = cxTVWaitDataControllerFilterBeforeChange
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OnEditValueChanged = cxTVWaitEditValueChanged
        OptionsView.GroupByBox = False
      end
      object cxLWait: TcxGridLevel
        GridView = cxTVWait
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 461
      Width = 960
      Height = 38
      Align = alBottom
      TabOrder = 1
      object SBtnRefresh: TSpeedButton
        Left = 133
        Top = 6
        Width = 75
        Height = 25
        Caption = #21047#26032
        OnClick = SBtnRefreshClick
      end
      object Label3: TLabel
        Left = 8
        Top = 12
        Width = 57
        Height = 13
        AutoSize = False
        Caption = #26469#28304#37096#38376
      end
      object Label2: TLabel
        Left = 331
        Top = 12
        Width = 42
        Height = 13
        AutoSize = False
        Caption = #36710#29260#21495
      end
      object Label1: TLabel
        Left = 464
        Top = 12
        Width = 41
        Height = 13
        AutoSize = False
        Caption = #22320#20301#21495
      end
      object SBtnEdit: TSpeedButton
        Left = 637
        Top = 6
        Width = 75
        Height = 25
        Caption = #20462#25913
        OnClick = SBtnEditClick
      end
      object SBtnSave: TSpeedButton
        Left = 717
        Top = 8
        Width = 75
        Height = 23
        Caption = #20445#23384
        OnClick = SBtnSaveClick
      end
      object SBtnCancelFNCard: TSpeedButton
        Left = 797
        Top = 6
        Width = 75
        Height = 25
        Caption = #25764#38144#21345#21495
        OnClick = SBtnCancelFNCardClick
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
      object CBBSrcDepartment: TComboBox
        Left = 64
        Top = 8
        Width = 65
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 844
        Top = 1
        Width = 115
        Height = 36
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
        object SBtnExit: TSpeedButton
          Left = 16
          Top = 5
          Width = 75
          Height = 25
          Caption = #36864#20986
          OnClick = SBtnExitClick
        end
      end
      object EdtCarNo: TEdit
        Left = 368
        Top = 8
        Width = 80
        Height = 21
        Color = clScrollBar
        Enabled = False
        TabOrder = 3
      end
      object EdtNewLocation: TEdit
        Left = 504
        Top = 8
        Width = 129
        Height = 21
        TabOrder = 4
        OnKeyPress = EdtNewLocationKeyPress
      end
    end
  end
  object CDSEditCarNO: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = CDSEditCarNOAfterScroll
    Left = 152
    Top = 192
  end
  object DSWait: TDataSource
    DataSet = CDSEditCarNO
    Left = 192
    Top = 192
  end
  object CDSUserLevel: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 192
  end
end

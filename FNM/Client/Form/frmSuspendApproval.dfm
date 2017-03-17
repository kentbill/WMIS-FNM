object SuspendApprovalForm: TSuspendApprovalForm
  Left = 341
  Top = 191
  Width = 949
  Height = 521
  Caption = #20572#26426#23457#25209
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
    Width = 941
    Height = 425
    Align = alClient
    Caption = #24453#23457#25209#20572#26426#35760#24405
    TabOrder = 0
    object tbcApproval: TTabControl
      Left = 2
      Top = 15
      Width = 937
      Height = 408
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      Tabs.Strings = (
        #26426#21488#31649#29702#21592
        #25805#20316#20027#20219)
      TabIndex = 0
      OnChange = tbcApprovalChange
      object GroupBox2: TGroupBox
        Left = 4
        Top = 27
        Width = 929
        Height = 377
        Align = alClient
        TabOrder = 0
        object cxgrid_SuspendApproval: TcxGrid
          Left = 2
          Top = 15
          Width = 925
          Height = 360
          Align = alClient
          TabOrder = 0
          RootLevelOptions.DetailTabsPosition = dtpTop
          object cxgridtv_SuspendApproval: TcxGridDBTableView
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsSelection.MultiSelect = True
          end
          object cxGridl_SuspendApproval: TcxGridLevel
            GridView = cxgridtv_SuspendApproval
            Options.DetailTabsPosition = dtpTop
          end
        end
      end
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 425
    Width = 941
    Height = 62
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      941
      62)
    object btn_Exit: TBitBtn
      Left = 826
      Top = 19
      Width = 75
      Height = 25
      Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      TabOrder = 0
      OnClick = btn_ExitClick
    end
    object btn_Approve: TBitBtn
      Left = 738
      Top = 19
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #23457#25209'(&S)'
      Default = True
      TabOrder = 1
      OnClick = btn_ApproveClick
    end
  end
  object dsApproval: TDataSource
    DataSet = cdsApproval
    Left = 272
    Top = 72
  end
  object cdsApproval: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 320
    Top = 72
  end
end

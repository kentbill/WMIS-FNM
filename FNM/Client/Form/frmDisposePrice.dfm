object DisposePriceForm: TDisposePriceForm
  Left = 223
  Top = 213
  Width = 928
  Height = 480
  Caption = #22788#29702#22870#32602'/'#38169#39033
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 545
    Height = 442
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    object tbcAccident: TTabControl
      Left = 1
      Top = 1
      Width = 543
      Height = 440
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      Tabs.Strings = (
        #25805#20316#29677#38271'(&0)'
        #26426#21488#31649#29702#21592'(&1)'
        #25805#20316#20027#20219'(&2)'
        #37096#38376#32463#29702'(&3)')
      TabIndex = 0
      OnChange = tbcAccidentChange
      object gbLeft: TGroupBox
        Left = 4
        Top = 27
        Width = 535
        Height = 409
        Align = alClient
        Caption = #22870#32602'/'#38169#39033
        TabOrder = 0
        object cxgridPrice: TcxGrid
          Left = 2
          Top = 15
          Width = 531
          Height = 392
          Align = alClient
          TabOrder = 0
          object cxgridtvPrice: TcxGridDBTableView
            DataController.DataSource = dsPrice
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsSelection.MultiSelect = True
            OptionsView.GroupByBox = False
          end
          object cxgridlPrice: TcxGridLevel
            GridView = cxgridtvPrice
          end
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 545
    Top = 0
    Width = 367
    Height = 442
    Align = alClient
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 409
      Width = 365
      Height = 32
      Align = alBottom
      TabOrder = 0
      DesignSize = (
        365
        32)
      object btn_Exit: TBitBtn
        Left = 282
        Top = 2
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Cancel = True
        Caption = #36864#20986'(&X)'
        TabOrder = 0
        OnClick = btn_ExitClick
      end
      object btnSubmit: TBitBtn
        Left = 197
        Top = 3
        Width = 75
        Height = 25
        Hint = #26412#32423#20154#21592#26080#26435#22788#29702#65292#21521#19978#19968#32423#31649#29702#20154#21592#25552#20132
        Anchors = [akRight, akBottom]
        Caption = #25552#20132#22788#29702'(&B)'
        Default = True
        TabOrder = 1
        OnClick = btnSubmitClick
      end
      object btnQuery: TBitBtn
        Left = 93
        Top = 3
        Width = 75
        Height = 25
        Hint = #26412#32423#20154#21592#26080#26435#22788#29702#65292#21521#19978#19968#32423#31649#29702#20154#21592#25552#20132
        Anchors = [akRight, akBottom]
        Caption = #21047#26032'(&R)'
        Default = True
        TabOrder = 2
        OnClick = btnQueryClick
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 365
      Height = 408
      Align = alClient
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 18
        Width = 60
        Height = 13
        Caption = #22788#29702#32467#26524#65306
      end
      object Label2: TLabel
        Left = 8
        Top = 48
        Width = 60
        Height = 13
        Caption = #22788#29702#22791#27880#65306
      end
      object cbb_Result: TComboBox
        Left = 80
        Top = 14
        Width = 113
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = 'OK'
        Items.Strings = (
          'OK'
          'Cancel')
      end
      object mmRemark: TMemo
        Left = 80
        Top = 48
        Width = 273
        Height = 153
        TabOrder = 1
      end
    end
  end
  object dsPrice: TDataSource
    DataSet = cdsPrice
    Left = 112
    Top = 104
  end
  object cdsPrice: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 104
  end
end

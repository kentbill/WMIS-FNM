object MachineRulesForm: TMachineRulesForm
  Left = 239
  Top = 104
  Width = 1127
  Height = 593
  Caption = #26426#21488#20998#37197#35268#21017
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
    Width = 1119
    Height = 169
    Align = alTop
    Caption = #26426#21488'/'#27169#24335
    TabOrder = 0
    object lblContents: TLabel
      Left = 14
      Top = 77
      Width = 3
      Height = 13
    end
    object Label1: TLabel
      Left = 56
      Top = 20
      Width = 39
      Height = 13
      Caption = #26426#21488' '#65306
    end
    object Label2: TLabel
      Left = 56
      Top = 52
      Width = 39
      Height = 13
      Caption = #27169#24335' '#65306
    end
    object cbMachine: TComboBox
      Left = 104
      Top = 16
      Width = 137
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbMachineChange
    end
    object cbMode: TComboBox
      Left = 104
      Top = 48
      Width = 137
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      OnChange = cbModeChange
      Items.Strings = (
        #27169#24335'1'
        #27169#24335'2'
        #27169#24335'3'
        #27169#24335'4'
        ''
        '')
    end
    object btnSave: TButton
      Left = 312
      Top = 16
      Width = 73
      Height = 25
      Caption = #20445#23384'(&S)'
      TabOrder = 2
      OnClick = btnSaveClick
    end
    object Button1: TButton
      Left = 568
      Top = 16
      Width = 113
      Height = 25
      Caption = #26426#21488#25490#35745#21010'(&P)'
      TabOrder = 3
      OnClick = Button1Click
    end
    object CheckBox1: TCheckBox
      Left = 432
      Top = 24
      Width = 89
      Height = 17
      Caption = #20445#30041#24050#25490#35745#21010
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 424
    Width = 1119
    Height = 135
    Align = alBottom
    Caption = #26465#20214
    TabOrder = 1
    object cxgrdCondition: TcxGrid
      Left = 2
      Top = 15
      Width = 1115
      Height = 118
      Align = alClient
      TabOrder = 0
      object cxgdtvCondition: TcxGridDBTableView
        DataController.DataSource = dsCondition
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NavigatorButtons.ConfirmDelete = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
      end
      object cxgrdlvlCondition: TcxGridLevel
        GridView = cxgdtvCondition
      end
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 169
    Width = 1119
    Height = 255
    Align = alClient
    Caption = #35268#21017
    TabOrder = 2
    object Label3: TLabel
      Left = 80
      Top = 168
      Width = 3
      Height = 13
    end
    object Label4: TLabel
      Left = 16
      Top = 168
      Width = 60
      Height = 13
      Caption = #20013#25991#25551#36848#65306
    end
    object white_type_t: TCheckBox
      Left = 16
      Top = 40
      Width = 49
      Height = 17
      Caption = #29305#30333
      TabOrder = 0
    end
    object white_type_s: TCheckBox
      Left = 16
      Top = 63
      Width = 49
      Height = 17
      Caption = #23569#33639
      TabOrder = 1
    end
    object white_type_p: TCheckBox
      Left = 16
      Top = 88
      Width = 49
      Height = 17
      Caption = #28418#30333
      TabOrder = 2
    end
    object white_type_b: TCheckBox
      Left = 16
      Top = 115
      Width = 49
      Height = 17
      Caption = #26412#30333
      TabOrder = 3
    end
    object Degree_18: TCheckBox
      Left = 116
      Top = 40
      Width = 41
      Height = 17
      Caption = '18'
      TabOrder = 4
    end
    object Degree_24: TCheckBox
      Left = 116
      Top = 72
      Width = 41
      Height = 17
      Caption = '24'
      TabOrder = 5
    end
    object spring_y: TCheckBox
      Left = 451
      Top = 39
      Width = 73
      Height = 17
      Caption = #24377#21147#24067
      TabOrder = 6
    end
    object spring_n: TCheckBox
      Left = 451
      Top = 71
      Width = 73
      Height = 17
      Caption = #38750#24377#21147#24067
      TabOrder = 7
    end
    object cb_MC: TCheckBox
      Left = 551
      Top = 40
      Width = 41
      Height = 17
      Caption = 'MC'
      TabOrder = 8
    end
    object cb_ETI: TCheckBox
      Left = 552
      Top = 72
      Width = 41
      Height = 17
      Caption = 'ETI'
      TabOrder = 9
    end
    object cb_AP: TCheckBox
      Left = 552
      Top = 102
      Width = 41
      Height = 17
      Caption = 'AP'
      TabOrder = 10
    end
    object MM_y: TCheckBox
      Left = 612
      Top = 40
      Width = 49
      Height = 17
      Caption = #30952#27611
      TabOrder = 11
    end
    object MM_n: TCheckBox
      Left = 610
      Top = 71
      Width = 65
      Height = 17
      Caption = #38750#30952#27611
      TabOrder = 12
    end
    object Royal_y: TCheckBox
      Left = 696
      Top = 40
      Width = 49
      Height = 17
      Caption = #28082#27688
      TabOrder = 13
    end
    object Royal_n: TCheckBox
      Left = 696
      Top = 72
      Width = 57
      Height = 17
      Caption = #38750#28082#27688
      TabOrder = 14
    end
    object sm_y: TCheckBox
      Left = 782
      Top = 40
      Width = 89
      Height = 17
      Caption = #21069#24037#24207#28903#27611
      TabOrder = 15
    end
    object sm_n: TCheckBox
      Left = 781
      Top = 71
      Width = 105
      Height = 17
      Caption = #21069#24037#24207#38750#28903#27611
      TabOrder = 16
    end
    object roll_y: TCheckBox
      Left = 896
      Top = 40
      Width = 49
      Height = 17
      Caption = #21367#35013
      TabOrder = 17
    end
    object roll_n: TCheckBox
      Left = 896
      Top = 72
      Width = 57
      Height = 17
      Caption = #38750#21367#35013
      TabOrder = 18
    end
    object cbOthers: TCheckBox
      Left = 552
      Top = 130
      Width = 41
      Height = 17
      Caption = #20854#20182
      TabOrder = 19
    end
    object cb_0: TCheckBox
      Left = 208
      Top = 39
      Width = 73
      Height = 17
      Caption = '0-1000'
      TabOrder = 20
    end
    object cb_1000: TCheckBox
      Left = 208
      Top = 56
      Width = 81
      Height = 17
      Caption = '1001-10000'
      TabOrder = 21
    end
    object cb_10000: TCheckBox
      Left = 208
      Top = 73
      Width = 89
      Height = 17
      Caption = '10001-25000'
      TabOrder = 22
    end
    object cb_25000: TCheckBox
      Left = 208
      Top = 91
      Width = 89
      Height = 17
      Caption = '25001-40000'
      TabOrder = 23
    end
    object cb_40000: TCheckBox
      Left = 208
      Top = 109
      Width = 89
      Height = 17
      Caption = '40001-60000'
      TabOrder = 24
    end
    object cb_max: TCheckBox
      Left = 208
      Top = 147
      Width = 89
      Height = 17
      Caption = '80001-MAX'
      TabOrder = 25
    end
    object white_type_cpbb: TCheckBox
      Left = 16
      Top = 140
      Width = 73
      Height = 17
      Caption = 'CPB'#26412#30333
      TabOrder = 26
    end
    object cb_60000: TCheckBox
      Left = 208
      Top = 128
      Width = 89
      Height = 17
      Caption = '60001-80000'
      TabOrder = 27
    end
    object cb_TQ: TCheckBox
      Left = 348
      Top = 40
      Width = 69
      Height = 17
      Caption = 'TQ'
      TabOrder = 28
    end
    object cb_OR: TCheckBox
      Left = 348
      Top = 64
      Width = 69
      Height = 17
      Caption = 'OR'
      TabOrder = 29
    end
    object cb_RD: TCheckBox
      Left = 348
      Top = 88
      Width = 69
      Height = 17
      Caption = 'RD'
      TabOrder = 30
    end
    object cb_GN: TCheckBox
      Left = 348
      Top = 112
      Width = 69
      Height = 17
      Caption = 'GN'
      TabOrder = 31
    end
  end
  object cdsCondition: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 456
  end
  object dsCondition: TDataSource
    DataSet = cdsCondition
    Left = 304
    Top = 456
  end
end

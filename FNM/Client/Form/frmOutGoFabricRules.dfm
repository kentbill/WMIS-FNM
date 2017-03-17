object OutGoFabricRulesForm: TOutGoFabricRulesForm
  Left = 213
  Top = 167
  Width = 1102
  Height = 535
  Caption = #20986#24067#35268#21017#32500#25252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 352
    Width = 1094
    Height = 156
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 23
      Width = 60
      Height = 13
      AutoSize = False
      Caption = #35268#21017#21517#31216
    end
    object Label2: TLabel
      Left = 440
      Top = 23
      Width = 57
      Height = 13
      AutoSize = False
      Caption = #35268#21017#31867#22411
    end
    object Label3: TLabel
      Left = 16
      Top = 88
      Width = 60
      Height = 13
      AutoSize = False
      Caption = #21442#25968'1'
    end
    object Label4: TLabel
      Left = 232
      Top = 88
      Width = 60
      Height = 13
      AutoSize = False
      Caption = #21442#25968'2'
    end
    object Label5: TLabel
      Left = 448
      Top = 88
      Width = 60
      Height = 13
      AutoSize = False
      Caption = #21442#25968'3'
    end
    object Label6: TLabel
      Left = 664
      Top = 88
      Width = 60
      Height = 13
      AutoSize = False
      Caption = #21442#25968'4'
    end
    object Label7: TLabel
      Left = 16
      Top = 56
      Width = 60
      Height = 13
      AutoSize = False
      Caption = #35268#21017
    end
    object Label8: TLabel
      Left = 224
      Top = 23
      Width = 60
      Height = 13
      AutoSize = False
      Caption = #35268#21017#20248#20808#32423
    end
    object DBEdtName: TDBEdit
      Left = 72
      Top = 19
      Width = 121
      Height = 21
      DataField = 'Rule_Description'
      DataSource = DSRules
      TabOrder = 0
    end
    object DBEdtValue1: TDBEdit
      Left = 72
      Top = 84
      Width = 121
      Height = 21
      DataField = 'value1'
      DataSource = DSRules
      TabOrder = 4
    end
    object DBEdtValue2: TDBEdit
      Left = 296
      Top = 84
      Width = 121
      Height = 21
      DataField = 'value2'
      DataSource = DSRules
      TabOrder = 5
    end
    object DBEdtValue3: TDBEdit
      Left = 506
      Top = 84
      Width = 121
      Height = 21
      DataField = 'value3'
      DataSource = DSRules
      TabOrder = 6
    end
    object DBEdtValue4: TDBEdit
      Left = 711
      Top = 84
      Width = 121
      Height = 21
      DataField = 'value4'
      DataSource = DSRules
      TabOrder = 7
    end
    object DBEdtType: TDBEdit
      Left = 504
      Top = 19
      Width = 121
      Height = 21
      DataField = 'Rule_Type'
      DataSource = DSRules
      TabOrder = 2
    end
    object DBEdtRules: TDBEdit
      Left = 72
      Top = 52
      Width = 345
      Height = 21
      DataField = 'Combination'
      DataSource = DSRules
      TabOrder = 3
    end
    object DBEdtPriority: TDBEdit
      Left = 296
      Top = 19
      Width = 121
      Height = 21
      DataField = 'Priority'
      DataSource = DSRules
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 1
      Top = 112
      Width = 1092
      Height = 43
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 8
      object Panel3: TPanel
        Left = 753
        Top = 0
        Width = 339
        Height = 43
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object SBtnAdd: TSpeedButton
          Left = 8
          Top = 8
          Width = 75
          Height = 25
          Caption = #26032#22686
          OnClick = SBtnAddClick
        end
        object SBtnRemove: TSpeedButton
          Left = 88
          Top = 8
          Width = 75
          Height = 25
          Caption = #21024#38500
          OnClick = SBtnRemoveClick
        end
        object SBtnSave: TSpeedButton
          Left = 168
          Top = 8
          Width = 75
          Height = 25
          Caption = #20445#23384
          OnClick = SBtnSaveClick
        end
        object SBtnExit: TSpeedButton
          Left = 248
          Top = 8
          Width = 75
          Height = 25
          Caption = #36864#20986
          OnClick = SBtnExitClick
        end
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 856
    Top = 0
    Width = 238
    Height = 352
    Align = alRight
    Caption = #35268#21017#26465#20214#21517#31216#19982#30721#23545#27604
    TabOrder = 1
    object DBGrdTerms: TDBGrid
      Left = 2
      Top = 15
      Width = 234
      Height = 335
      Align = alClient
      DataSource = DSTerms
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Terms_Number'
          Title.Caption = #26465#20214#32534#21495
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Terms_Name'
          Title.Caption = #26465#20214#21517#31216
          Width = 120
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 856
    Height = 352
    Align = alClient
    Caption = #20986#24067#35268#21017
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 852
      Height = 335
      Align = alClient
      DataSource = DSRules
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Rule_Description'
          Title.Caption = #35268#21017#21517#31216
          Width = 180
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Priority'
          Title.Caption = #35268#21017#20248#20808#32423
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Rule_Type'
          Title.Caption = #35268#21017#31867#22411
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Combination'
          Title.Caption = #35268#21017
          Width = 350
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'value1'
          Title.Caption = #21442#25968'1'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'value2'
          Title.Caption = #21442#25968'2'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'value3'
          Title.Caption = #21442#25968'3'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'value4'
          Title.Caption = #21442#25968'4'
          Width = 95
          Visible = True
        end>
    end
  end
  object CDSRules: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 240
    Top = 160
  end
  object DSRules: TDataSource
    DataSet = CDSRules
    Left = 280
    Top = 160
  end
  object CDSTerms: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 864
    Top = 136
  end
  object DSTerms: TDataSource
    DataSet = CDSTerms
    Left = 896
    Top = 136
  end
end

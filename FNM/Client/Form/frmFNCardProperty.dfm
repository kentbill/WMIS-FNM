object FNCardPropertyForm: TFNCardPropertyForm
  Left = 109
  Top = 107
  BorderStyle = bsDialog
  Caption = #23646#24615'...'
  ClientHeight = 426
  ClientWidth = 573
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object pgcFNCardProperty: TPageControl
    Left = 4
    Top = 6
    Width = 565
    Height = 387
    ActivePage = tsFNCardProperty
    TabIndex = 0
    TabOrder = 0
    object tsFNCardProperty: TTabSheet
      Caption = #22522#26412#23646#24615
      object grpBaseInfo: TGroupBox
        Left = 6
        Top = 3
        Width = 328
        Height = 354
        Caption = #21345#30340#23646#24615
        TabOrder = 0
        object lblFN_Card: TLabel
          Left = 8
          Top = 23
          Width = 30
          Height = 12
          Caption = #21345#21495':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblMachine_Name: TLabel
          Left = 176
          Top = 23
          Width = 30
          Height = 12
          Caption = #26426#21488':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblGF_ID: TLabel
          Left = 8
          Top = 95
          Width = 42
          Height = 12
          Caption = #21697#21517'ID:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblGF_NO: TLabel
          Left = 176
          Top = 95
          Width = 30
          Height = 12
          Caption = #21697#21517':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblJob_NO: TLabel
          Left = 8
          Top = 119
          Width = 42
          Height = 12
          Caption = #25490#21333#21495':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblPpo_NO: TLabel
          Left = 176
          Top = 119
          Width = 42
          Height = 12
          Caption = #35746#21333#21495':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblStep_NO: TLabel
          Left = 8
          Top = 47
          Width = 30
          Height = 12
          Caption = #27493#39588':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblOperation_CHN: TLabel
          Left = 176
          Top = 47
          Width = 30
          Height = 12
          Caption = #24037#24207':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblQuantity: TLabel
          Left = 8
          Top = 71
          Width = 30
          Height = 12
          Caption = #25968#37327':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblStatus: TLabel
          Left = 176
          Top = 71
          Width = 30
          Height = 12
          Caption = #29366#24577':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblFact_Art_ID: TLabel
          Left = 176
          Top = 192
          Width = 42
          Height = 12
          Caption = #29305#28418#30333':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblCustomer: TLabel
          Left = 8
          Top = 143
          Width = 30
          Height = 12
          Caption = #23458#25143':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblDelivery_Date: TLabel
          Left = 176
          Top = 143
          Width = 30
          Height = 12
          Caption = #20132#26399':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblUrgent_Type: TLabel
          Left = 8
          Top = 167
          Width = 54
          Height = 12
          Caption = #24613#21333#31867#22411':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblCut_Cloth: TLabel
          Left = 176
          Top = 167
          Width = 42
          Height = 12
          Caption = #39318#33853#24067':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblHold: TLabel
          Left = 8
          Top = 192
          Width = 30
          Height = 12
          Caption = 'HOLD:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblPlan_Begin_Time: TLabel
          Left = 8
          Top = 217
          Width = 78
          Height = 12
          Caption = #35745#21010#24320#22987#26102#38388':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblPlan_End_Time: TLabel
          Left = 8
          Top = 241
          Width = 78
          Height = 12
          Caption = #35745#21010#32467#26463#26102#38388':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblFact_Begin_Time: TLabel
          Left = 9
          Top = 265
          Width = 78
          Height = 12
          Caption = #23454#38469#24320#22987#26102#38388':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lblArt_Remark: TLabel
          Left = 8
          Top = 293
          Width = 54
          Height = 12
          Caption = #24037#33402#22791#27880':'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object edtFN_Card: TEdit
          Left = 63
          Top = 15
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 0
        end
        object edtMachine_Name: TEdit
          Left = 219
          Top = 15
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 1
        end
        object edtGF_ID: TEdit
          Left = 63
          Top = 87
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 6
        end
        object edtGF_NO: TEdit
          Left = 219
          Top = 87
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 7
        end
        object edtJob_NO: TEdit
          Left = 63
          Top = 111
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 8
        end
        object edtPpo_NO: TEdit
          Left = 219
          Top = 111
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 9
        end
        object edtStep_NO: TEdit
          Left = 63
          Top = 39
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 2
        end
        object edtOperation_CHN: TEdit
          Left = 219
          Top = 39
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 3
        end
        object edtQuantity: TEdit
          Left = 63
          Top = 63
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 4
        end
        object edtStatus: TEdit
          Left = 219
          Top = 63
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 5
        end
        object edtWhiteType: TEdit
          Left = 219
          Top = 184
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 15
        end
        object edtCustomer: TEdit
          Left = 63
          Top = 135
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 10
        end
        object edtDelivery_Date: TEdit
          Left = 219
          Top = 135
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 11
        end
        object edtUrgent_Type: TEdit
          Left = 64
          Top = 159
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 12
        end
        object edtCut_Cloth: TEdit
          Left = 219
          Top = 159
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 13
        end
        object edtHold: TEdit
          Left = 63
          Top = 184
          Width = 100
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 14
        end
        object edtPlan_Begin_Time: TEdit
          Left = 87
          Top = 209
          Width = 232
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 16
        end
        object edtPlan_End_Time: TEdit
          Left = 87
          Top = 233
          Width = 232
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 17
        end
        object edtFact_Begin_Time: TEdit
          Left = 87
          Top = 257
          Width = 232
          Height = 20
          Color = clMenu
          ReadOnly = True
          TabOrder = 18
        end
        object mmoArt_Remark: TMemo
          Left = 87
          Top = 282
          Width = 232
          Height = 66
          Color = clMenu
          ReadOnly = True
          TabOrder = 19
        end
      end
      object grp1: TGroupBox
        Left = 341
        Top = 3
        Width = 210
        Height = 175
        Caption = #24037#33402#33457#22411
        TabOrder = 1
        object gfcadPattern: TGFCAD
          Left = 2
          Top = 14
          Width = 206
          Height = 159
          Align = alClient
          TabOrder = 0
          ControlData = {000001004A1500006F10000000000000}
        end
      end
      object grp2: TGroupBox
        Left = 341
        Top = 182
        Width = 210
        Height = 175
        Caption = #24037#33402#21442#25968
        TabOrder = 2
        object vleArtParam: TValueListEditor
          Left = 2
          Top = 14
          Width = 206
          Height = 159
          Align = alClient
          Color = clMenu
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
          TabOrder = 0
          TitleCaptions.Strings = (
            '               '#21442#25968#21517
            '  '#21442#25968#20540)
          ColWidths = (
            143
            57)
        end
      end
    end
  end
  object btnOK: TButton
    Left = 494
    Top = 397
    Width = 75
    Height = 25
    Cancel = True
    Caption = #30830#23450'(&O)'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
end

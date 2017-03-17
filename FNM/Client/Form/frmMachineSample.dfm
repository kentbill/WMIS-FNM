object MachineSampleForm: TMachineSampleForm
  Left = 408
  Top = 382
  BorderIcons = []
  BorderStyle = bsDialog
  BorderWidth = 2
  Caption = #26426#21488#21462#26679
  ClientHeight = 175
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  DesignSize = (
    329
    175)
  PixelsPerInch = 96
  TextHeight = 12
  object lbl5: TLabel
    Left = 8
    Top = 80
    Width = 54
    Height = 12
    Caption = #24067#21495#21015#34920':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 8
    Top = 37
    Width = 54
    Height = 12
    Caption = #21462#26679#39033#30446':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 8
    Top = 58
    Width = 96
    Height = 12
    Caption = #35745#21010#21462#26679#30721#38271'(Y):'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 8
    Top = 125
    Width = 96
    Height = 12
    Caption = #23454#38469#21462#26679#30721#38271'(Y):'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 8
    Top = 102
    Width = 54
    Height = 12
    Caption = #24037#20154#21015#34920':'
  end
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 42
    Height = 12
    Caption = #24037#24207#21517':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object btnOK: TButton
    Left = 162
    Top = 148
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #30830#23450'(&O)'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 245
    Top = 148
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 3
  end
  object edtPlanQuantity: TEdit
    Left = 100
    Top = 50
    Width = 220
    Height = 20
    ParentColor = True
    ReadOnly = True
    TabOrder = 6
  end
  object edtFactQuantity: TEdit
    Left = 100
    Top = 117
    Width = 220
    Height = 20
    TabOrder = 1
  end
  object cbbWorkerList: TComboBox
    Left = 100
    Top = 94
    Width = 220
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 0
  end
  object cbbFabricNOList: TComboBox
    Left = 100
    Top = 72
    Width = 220
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 7
  end
  object edtSampleName: TEdit
    Left = 100
    Top = 29
    Width = 220
    Height = 20
    ParentColor = True
    TabOrder = 5
  end
  object edtOperation: TEdit
    Left = 100
    Top = 8
    Width = 220
    Height = 20
    ParentColor = True
    TabOrder = 4
  end
end

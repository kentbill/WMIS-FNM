object AutoPlanShiftForm: TAutoPlanShiftForm
  Left = 275
  Top = 180
  Width = 488
  Height = 249
  Caption = #26426#21488#33258#21160#25490#35745#21010#35268#21017
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBtton: TPanel
    Left = 0
    Top = 195
    Width = 480
    Height = 27
    Hint = #20197#36873#23450#30340#35268#21017#20248#20808#23433#25490#65292#27809#26377#35268#21017#25353#40664#35748#35268#21017#23433#25490
    Align = alBottom
    BevelOuter = bvNone
    BiDiMode = bdRightToLeftNoAlign
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DesignSize = (
      480
      27)
    object btnSave: TBitBtn
      Left = 187
      Top = 2
      Width = 58
      Height = 25
      Hint = #20197#36873#23450#30340#35268#21017#20248#20808#23433#25490#65292#27809#26377#35268#21017#25353#40664#35748#35268#21017#23433#25490
      Anchors = [akLeft, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #30830#23450'(&S)'
      Default = True
      ModalResult = 1
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TBitBtn
      Left = 277
      Top = 2
      Width = 58
      Height = 25
      Anchors = [akLeft, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #21462#28040'(&C)'
      Default = True
      ModalResult = 2
      ParentBiDiMode = False
      TabOrder = 1
    end
  end
  object cdsMachines: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 208
  end
  object cdsItems: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 104
    Top = 208
  end
  object cdsType: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 208
  end
  object cdsSave: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 208
  end
end

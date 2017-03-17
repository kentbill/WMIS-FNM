object MachineSelectForm: TMachineSelectForm
  Left = 322
  Top = 174
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #36873#25321#26426#21488
  ClientHeight = 91
  ClientWidth = 354
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    354
    91)
  PixelsPerInch = 96
  TextHeight = 12
  object lblPrompt: TLabel
    Left = 8
    Top = 32
    Width = 72
    Height = 12
    Caption = #21152#24037#26426#21488'(&M):'
  end
  object cbbMachineList: TComboBox
    Left = 88
    Top = 25
    Width = 257
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 0
  end
  object btn1: TButton
    Left = 180
    Top = 62
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object btn2: TButton
    Left = 266
    Top = 62
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end

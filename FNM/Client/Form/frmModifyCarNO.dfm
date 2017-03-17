object ModifyCarNOForm: TModifyCarNOForm
  Left = 363
  Top = 303
  BorderStyle = bsDialog
  Caption = #20462#25913#36710#29260#12289#21367#21495
  ClientHeight = 153
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object txt1: TStaticText
    Left = 28
    Top = 21
    Width = 50
    Height = 17
    Caption = #21345#21495'(&C):'
    TabOrder = 0
  end
  object txt2: TStaticText
    Left = 28
    Top = 48
    Width = 62
    Height = 17
    Caption = #36710#29260#21495'(&A):'
    TabOrder = 1
  end
  object txt3: TStaticText
    Left = 28
    Top = 74
    Width = 56
    Height = 17
    Caption = #20462#25913#20154'(P):'
    TabOrder = 2
  end
  object btn1: TButton
    Left = 85
    Top = 127
    Width = 75
    Height = 25
    Caption = #20445#23384'(&O)'
    TabOrder = 3
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 182
    Top = 127
    Width = 75
    Height = 25
    Caption = #36864#20986'(&C)'
    ModalResult = 1
    TabOrder = 4
  end
  object edt_Card: TEdit
    Left = 84
    Top = 14
    Width = 187
    Height = 21
    TabOrder = 5
  end
  object edt_CarNO: TEdit
    Left = 84
    Top = 41
    Width = 187
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 6
  end
  object cbb_Operator: TComboBox
    Left = 84
    Top = 67
    Width = 187
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 7
  end
  object StaticText1: TStaticText
    Left = 27
    Top = 96
    Width = 63
    Height = 17
    Caption = #22320#20301#21495'(&R):'
    TabOrder = 8
  end
  object edt_RollNO: TEdit
    Left = 84
    Top = 89
    Width = 187
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 9
  end
end

object ModifyCarNoAndLocationNoForm: TModifyCarNoAndLocationNoForm
  Left = 424
  Top = 239
  Width = 238
  Height = 196
  Caption = #20462#25913#36710#21495#12289#22320#20301#21495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 16
    Top = 16
    Width = 39
    Height = 13
    Caption = #36710#29260#21495
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 16
    Top = 66
    Width = 39
    Height = 13
    Caption = #22320#20301#21495
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object edt1: TEdit
    Left = 16
    Top = 32
    Width = 185
    Height = 21
    Color = cl3DLight
    Enabled = False
    TabOrder = 0
  end
  object edt2: TEdit
    Left = 16
    Top = 88
    Width = 185
    Height = 21
    TabOrder = 1
  end
  object btn1: TBitBtn
    Left = 24
    Top = 120
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 2
    OnClick = btn1Click
  end
  object btn2: TBitBtn
    Left = 112
    Top = 120
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 3
    OnClick = btn2Click
  end
end

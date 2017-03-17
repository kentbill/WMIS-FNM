object SelectFNColorCodeForm: TSelectFNColorCodeForm
  Left = 363
  Top = 263
  Width = 348
  Height = 186
  Caption = #35831#36873#25321#33394#21495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    340
    159)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 40
    Width = 60
    Height = 13
    Caption = #36873#25321#33394#21495#65306
  end
  object Label6: TLabel
    Left = 24
    Top = 81
    Width = 60
    Height = 13
    Caption = #39068#33394#31616#31216#65306
  end
  object cbbFNColorCode: TComboBox
    Left = 96
    Top = 32
    Width = 137
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = cbbFNColorCodeChange
  end
  object btn1: TButton
    Left = 95
    Top = 125
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = #30830#35748
    ModalResult = 1
    TabOrder = 1
  end
  object btn2: TButton
    Left = 201
    Top = 125
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 2
  end
  object plShowColor: TPanel
    Left = 239
    Top = 29
    Width = 98
    Height = 67
    Cursor = crHandPoint
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 2
    TabOrder = 3
    object edtRGB: TEdit
      Left = 9
      Top = 20
      Width = 78
      Height = 21
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
      Visible = False
    end
  end
  object cbSimpleColor: TComboBox
    Left = 96
    Top = 73
    Width = 67
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 4
  end
  object cbbDegree: TComboBox
    Left = 177
    Top = 73
    Width = 54
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 5
    Items.Strings = (
      #27973
      #28145)
  end
  object dsFNColor: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 104
  end
end

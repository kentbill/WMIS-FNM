object DownInfoForm: TDownInfoForm
  Left = 580
  Top = 252
  Width = 274
  Height = 195
  Caption = #19979#26426#20449#24687
  Color = clBtnFace
  Constraints.MaxHeight = 195
  Constraints.MaxWidth = 274
  Constraints.MinHeight = 195
  Constraints.MinWidth = 274
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 22
    Width = 36
    Height = 13
    Caption = #33853#24133#65306
  end
  object Label2: TLabel
    Left = 40
    Top = 54
    Width = 36
    Height = 13
    Caption = #36710#21495#65306
  end
  object Label3: TLabel
    Left = 40
    Top = 86
    Width = 38
    Height = 13
    Caption = 'j'#21367#21495#65306
  end
  object edtWidth: TEdit
    Left = 81
    Top = 18
    Width = 120
    Height = 20
    Color = clMenu
    TabOrder = 0
  end
  object edtCar_NO: TEdit
    Left = 81
    Top = 49
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    Color = clMenu
    MaxLength = 10
    TabOrder = 1
  end
  object edtRoll: TEdit
    Left = 81
    Top = 81
    Width = 120
    Height = 21
    CharCase = ecUpperCase
    Color = clMenu
    MaxLength = 10
    TabOrder = 2
  end
  object btnClose: TBitBtn
    Left = 144
    Top = 121
    Width = 75
    Height = 22
    Cancel = True
    Caption = #36864#20986
    ModalResult = 2
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object btnOK: TBitBtn
    Left = 48
    Top = 121
    Width = 75
    Height = 22
    Cancel = True
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 4
    OnClick = btnOKClick
  end
end

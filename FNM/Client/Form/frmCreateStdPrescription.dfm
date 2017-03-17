object CreateStdPrescriptionForm: TCreateStdPrescriptionForm
  Left = 330
  Top = 187
  BorderStyle = bsDialog
  Caption = #26631#20934#37197#26041#36873#25321
  ClientHeight = 314
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object btn_Query: TSpeedButton
    Left = 207
    Top = 5
    Width = 23
    Height = 22
    Flat = True
    OnClick = ClickAButton
  end
  object txt1: TStaticText
    Left = 8
    Top = 13
    Width = 34
    Height = 16
    Caption = #22788#26041':'
    TabOrder = 0
  end
  object cbb_StdPrescription: TComboBox
    Left = 40
    Top = 6
    Width = 165
    Height = 20
    CharCase = ecUpperCase
    ItemHeight = 12
    TabOrder = 1
    OnKeyDown = KeyDownAControl
  end
  object pnl1: TPanel
    Left = 5
    Top = 31
    Width = 473
    Height = 245
    BevelOuter = bvNone
    Caption = 'pnl1'
    TabOrder = 2
    object TPanel
      Left = 264
      Top = 0
      Width = 209
      Height = 245
      Align = alRight
      BevelInner = bvLowered
      TabOrder = 0
      object TStaticText
        Left = 2
        Top = 2
        Width = 205
        Height = 16
        Align = alTop
        BevelKind = bkSoft
        Caption = #21487#36873#21270#24037#26009'(&C):'
        TabOrder = 0
      end
      object tv_Chemical_Name: TTreeView
        Left = 2
        Top = 18
        Width = 205
        Height = 225
        Align = alClient
        Indent = 19
        TabOrder = 1
        OnKeyDown = KeyDownAControl
      end
    end
    object pnl2: TPanel
      Left = 0
      Top = 0
      Width = 230
      Height = 245
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 1
      object txt3: TStaticText
        Left = 2
        Top = 2
        Width = 226
        Height = 16
        Align = alTop
        BevelKind = bkSoft
        Caption = #26126#32454':'
        TabOrder = 0
      end
      object vle_Chemicallist: TValueListEditor
        Left = 2
        Top = 18
        Width = 226
        Height = 225
        Align = alClient
        TabOrder = 1
        TitleCaptions.Strings = (
          #21270#24037#26009#21517
          #29992#37327'(g/L)')
        OnValidate = vle_ChemicallistValidate
        ColWidths = (
          102
          118)
      end
    end
    object TPanel
      Left = 233
      Top = 0
      Width = 28
      Height = 245
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object btn_Add_Chemical: TSpeedButton
        Left = 2
        Top = 42
        Width = 24
        Height = 24
        Flat = True
        OnClick = ClickAButton
      end
      object btn_Del_Chemical: TSpeedButton
        Left = 2
        Top = 117
        Width = 24
        Height = 24
        Flat = True
        OnClick = ClickAButton
      end
    end
    object TPanel
      Left = 230
      Top = 0
      Width = 3
      Height = 245
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 3
    end
    object TPanel
      Left = 261
      Top = 0
      Width = 3
      Height = 245
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 4
    end
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 277
    Width = 484
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      484
      37)
    object btn3: TButton
      Left = 8
      Top = 7
      Width = 75
      Height = 25
      Caption = #24110#21161'(&H)'
      TabOrder = 0
    end
    object btn2: TButton
      Left = 308
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #21462#28040'(&C)'
      ModalResult = 2
      TabOrder = 1
    end
    object btn_OK: TButton
      Left = 396
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #30830#23450'(&O)'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
  end
end

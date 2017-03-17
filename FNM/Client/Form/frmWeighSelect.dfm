object WeighSelectForm: TWeighSelectForm
  Left = 407
  Top = 242
  BorderStyle = bsSingle
  Caption = #25163#24037#31216#37325
  ClientHeight = 114
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 471
    Height = 114
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 62
      Top = 11
      Width = 136
      Height = 32
      Caption = #35831#36755#20837#23494#30721':'
    end
    object edtPassword: TEdit
      Left = 66
      Top = 51
      Width = 187
      Height = 40
      CharCase = ecUpperCase
      PasswordChar = '*'
      TabOrder = 0
      OnKeyPress = edtPasswordKeyPress
    end
    object Button1: TButton
      Left = 295
      Top = 20
      Width = 124
      Height = 83
      Cancel = True
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
    end
  end
  object rgSel: TRadioGroup
    Left = 0
    Top = 0
    Width = 471
    Height = 114
    Align = alClient
    Caption = #35831#36873#25321#31216#37325#37325' KG'
    Columns = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      '20 KG'
      '25 KG'
      '30 KG'
      #33258#23450#20041)
    ParentFont = False
    TabOrder = 0
    OnClick = rgSelClick
  end
end

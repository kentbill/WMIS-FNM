object SubRecipeForm: TSubRecipeForm
  Left = 231
  Top = 241
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'SubRecipeForm'
  ClientHeight = 213
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  DesignSize = (
    352
    213)
  PixelsPerInch = 96
  TextHeight = 12
  object gbAdd: TGroupBox
    Left = 0
    Top = 0
    Width = 345
    Height = 183
    Caption = #21270#26009#21015#34920
    TabOrder = 2
    object SubChemicallist: TValueListEditor
      Left = 2
      Top = 14
      Width = 341
      Height = 167
      Align = alClient
      TabOrder = 0
      TitleCaptions.Strings = (
        #21270#26009#21517
        #21152#26009#25968#37327'(g/l)')
      ColWidths = (
        202
        133)
    end
  end
  object gbDilute: TGroupBox
    Left = 0
    Top = 0
    Width = 346
    Height = 184
    Caption = #21270#26009#21015#34920
    TabOrder = 3
    DesignSize = (
      346
      184)
    object Label1: TLabel
      Left = 162
      Top = 164
      Width = 72
      Height = 12
      Anchors = [akRight, akBottom]
      Caption = #20914#31232#27604#20363'(%):'
    end
    object clbChemicalList: TCheckListBox
      Left = 2
      Top = 14
      Width = 342
      Height = 137
      Align = alTop
      ItemHeight = 12
      TabOrder = 0
    end
    object cbRatioList: TComboBox
      Left = 242
      Top = 156
      Width = 96
      Height = 20
      Anchors = [akRight, akBottom]
      ItemHeight = 12
      TabOrder = 1
      Items.Strings = (
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50')
    end
  end
  object btnOK: TButton
    Left = 274
    Top = 189
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #30830#23450'(&O)'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 184
    Top = 189
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
end

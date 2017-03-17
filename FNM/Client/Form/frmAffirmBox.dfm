object AffirmBoxForm: TAffirmBoxForm
  Left = 530
  Top = 255
  Width = 480
  Height = 282
  Caption = #36319#36394#22791#27880
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object groupbox1: TGroupBox
    Left = 0
    Top = 0
    Width = 472
    Height = 248
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 31
      Width = 60
      Height = 13
      Caption = #21152#24037#29677#27425#65306
    end
    object Label2: TLabel
      Left = 12
      Top = 61
      Width = 60
      Height = 13
      Caption = #21152#24037#22791#27880#65306
    end
    object cboClass: TComboBox
      Left = 74
      Top = 27
      Width = 121
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = #30333#29677
      Items.Strings = (
        #30333#29677
        #19977#29677)
    end
    object mRemark: TMemo
      Left = 73
      Top = 58
      Width = 377
      Height = 121
      TabOrder = 1
    end
    object btnSave: TButton
      Left = 72
      Top = 200
      Width = 97
      Height = 25
      Caption = #20445#23384'(&S)'
      TabOrder = 2
      OnClick = btnSaveClick
    end
  end
end

object SaveScrapInfoForm: TSaveScrapInfoForm
  Left = 533
  Top = 258
  Width = 309
  Height = 262
  Caption = #24223#24067#20449#24687
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 301
    Height = 228
    Align = alClient
    TabOrder = 0
    object lblQuantity: TLabel
      Left = 40
      Top = 64
      Width = 36
      Height = 13
      Caption = #30721#38271#65306
    end
    object lblMargin: TLabel
      Left = 40
      Top = 104
      Width = 36
      Height = 13
      Caption = #36793#36317#65306
    end
    object lblFabricNo: TLabel
      Left = 40
      Top = 32
      Width = 36
      Height = 13
      Caption = #24067#21495#65306
    end
    object Label1: TLabel
      Left = 16
      Top = 139
      Width = 60
      Height = 13
      Caption = #24403#29677#29677#38271#65306
    end
    object edtQuantity: TEdit
      Left = 87
      Top = 59
      Width = 153
      Height = 21
      TabOrder = 0
    end
    object edtMargin: TEdit
      Left = 86
      Top = 96
      Width = 155
      Height = 21
      TabOrder = 1
    end
    object btnSave: TButton
      Left = 80
      Top = 173
      Width = 73
      Height = 25
      Caption = #20445#23384'(&S)'
      TabOrder = 2
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 172
      Top = 173
      Width = 71
      Height = 25
      Caption = #21462#28040'(&C)'
      TabOrder = 3
      OnClick = btnCancelClick
    end
    object cboFabricNo: TComboBox
      Left = 88
      Top = 24
      Width = 153
      Height = 21
      ItemHeight = 13
      TabOrder = 4
    end
    object edtSquad: TEdit
      Left = 86
      Top = 135
      Width = 155
      Height = 21
      TabOrder = 5
    end
  end
  object cdsFabricNo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 24
  end
end

object CreateAffirmHandForm: TCreateAffirmHandForm
  Left = 392
  Top = 247
  Width = 631
  Height = 316
  Caption = #36136#37327#39044#38450'-'#25163#24037#28155#21152
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 623
    Height = 209
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 27
      Width = 36
      Height = 13
      Caption = #21697#21517#65306
    end
    object Label2: TLabel
      Left = 208
      Top = 27
      Width = 36
      Height = 13
      Caption = #27493#39588#65306
    end
    object Label3: TLabel
      Left = 392
      Top = 26
      Width = 36
      Height = 13
      Caption = #24037#24207#65306
    end
    object Label4: TLabel
      Left = 16
      Top = 66
      Width = 60
      Height = 13
      Caption = #39044#38450#20449#24687#65306
    end
    object edtGFNO: TEdit
      Left = 66
      Top = 23
      Width = 118
      Height = 21
      TabOrder = 0
    end
    object edtStepNO: TEdit
      Left = 248
      Top = 24
      Width = 129
      Height = 21
      TabOrder = 1
      OnChange = edtStepNOChange
    end
    object cboOperationCode: TComboBox
      Left = 432
      Top = 24
      Width = 129
      Height = 21
      ItemHeight = 13
      TabOrder = 2
    end
    object memoPrevent: TMemo
      Left = 64
      Top = 88
      Width = 497
      Height = 105
      Lines.Strings = (
        '')
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 209
    Width = 623
    Height = 73
    Align = alBottom
    TabOrder = 1
    object btnSave: TButton
      Left = 368
      Top = 24
      Width = 89
      Height = 25
      Caption = #20445#23384'(&S)'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnClose: TButton
      Left = 480
      Top = 24
      Width = 81
      Height = 25
      Caption = #21462#28040'(&C)'
      TabOrder = 1
      OnClick = btnCloseClick
    end
  end
end

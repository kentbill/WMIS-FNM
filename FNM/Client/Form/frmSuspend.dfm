object SuspendForm: TSuspendForm
  Left = 220
  Top = 153
  BorderStyle = bsDialog
  Caption = #26426#21488#20572#26426
  ClientHeight = 194
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object lbl1: TLabel
    Left = 19
    Top = 66
    Width = 54
    Height = 12
    Caption = #20572#26426#21407#22240':'
  end
  object lbl2: TLabel
    Left = 19
    Top = 20
    Width = 54
    Height = 12
    Caption = #24320#22987#26102#38388':'
  end
  object Label1: TLabel
    Left = 19
    Top = 44
    Width = 54
    Height = 12
    Caption = #32467#26463#26102#38388':'
  end
  object lbl3: TLabel
    Left = 21
    Top = 86
    Width = 54
    Height = 12
    Caption = #22791'    '#27880':'
  end
  object cbbSuspend: TComboBox
    Left = 78
    Top = 59
    Width = 219
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 4
  end
  object btnSave: TButton
    Left = 59
    Top = 161
    Width = 75
    Height = 25
    Caption = #20445#23384'(&S)'
    Default = True
    ModalResult = 1
    TabOrder = 5
    OnClick = btnSaveClick
  end
  object btnClose: TButton
    Left = 183
    Top = 161
    Width = 75
    Height = 26
    Cancel = True
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 6
    OnClick = btnCloseClick
  end
  object dtpBeginDate: TDateTimePicker
    Left = 78
    Top = 13
    Width = 117
    Height = 20
    CalAlignment = dtaLeft
    Date = 38470.5432952315
    Time = 38470.5432952315
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 0
  end
  object dtpBeginTime: TDateTimePicker
    Left = 196
    Top = 13
    Width = 101
    Height = 20
    CalAlignment = dtaLeft
    Date = 38470.5432952315
    Time = 38470.5432952315
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkTime
    ParseInput = False
    TabOrder = 1
  end
  object dtpEndDate: TDateTimePicker
    Left = 78
    Top = 36
    Width = 116
    Height = 20
    CalAlignment = dtaLeft
    Date = 38470.5432952315
    Time = 38470.5432952315
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
  end
  object dtpEndTime: TDateTimePicker
    Left = 196
    Top = 36
    Width = 101
    Height = 20
    CalAlignment = dtaLeft
    Date = 38470.5432952315
    Time = 38470.5432952315
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkTime
    ParseInput = False
    TabOrder = 3
  end
  object mmoRemark: TMemo
    Left = 78
    Top = 82
    Width = 219
    Height = 69
    TabOrder = 7
  end
end

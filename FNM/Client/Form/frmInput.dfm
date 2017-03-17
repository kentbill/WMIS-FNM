object InputForm: TInputForm
  Left = 417
  Top = 174
  BorderStyle = bsDialog
  Caption = #36873#25321#36131#20219#20154
  ClientHeight = 197
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    290
    197)
  PixelsPerInch = 96
  TextHeight = 12
  object lblPrompt: TLabel
    Left = 16
    Top = 16
    Width = 78
    Height = 12
    Caption = #35831#36873#25321#36131#20219#20154':'
  end
  object lblMonitor: TLabel
    Left = 16
    Top = 59
    Width = 66
    Height = 12
    Caption = #35831#36873#25321#29677#38271':'
  end
  object lbRemark: TLabel
    Left = 16
    Top = 104
    Width = 72
    Height = 12
    Caption = #20462#25913#21407#22240'(*):'
  end
  object cbbWorkerList: TComboBox
    Left = 16
    Top = 33
    Width = 257
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 0
  end
  object btn1: TButton
    Left = 60
    Top = 168
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object btn2: TButton
    Left = 162
    Top = 168
    Width = 75
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object cbbMonitorList: TComboBox
    Left = 16
    Top = 75
    Width = 257
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 3
  end
  object moRemark: TMemo
    Left = 16
    Top = 120
    Width = 257
    Height = 41
    TabOrder = 4
  end
end

object RePrintNoteNOForm: TRePrintNoteNOForm
  Left = 285
  Top = 196
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = #21333#25454#37325#25171
  ClientHeight = 275
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object lblCarNO: TLabel
    Left = 167
    Top = 186
    Width = 42
    Height = 12
    Caption = #36710#29260#21495':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lblNoteNO: TLabel
    Left = 167
    Top = 8
    Width = 54
    Height = 12
    Caption = #27491#24120#21345#21495':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object bvl2: TBevel
    Left = 12
    Top = 230
    Width = 309
    Height = 2
    Shape = bsFrame
  end
  object btnCancel: TBitBtn
    Left = 214
    Top = 243
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040'(&C)'
    TabOrder = 0
    OnClick = btnCancelClick
  end
  object btnPrint: TBitBtn
    Left = 127
    Top = 243
    Width = 75
    Height = 25
    Caption = #25171#21360'(&P)'
    Default = True
    TabOrder = 1
    OnClick = btnPrintClick
  end
  object edtCarNO: TEdit
    Left = 167
    Top = 201
    Width = 120
    Height = 20
    TabOrder = 2
    OnKeyDown = edtCarNOKeyDown
  end
  object cbbNoteNO: TComboBox
    Left = 167
    Top = 22
    Width = 120
    Height = 162
    Style = csSimple
    CharCase = ecUpperCase
    ItemHeight = 12
    TabOrder = 3
    OnKeyDown = cbbNoteNOKeyDown
  end
  object btnPreview: TBitBtn
    Left = 41
    Top = 243
    Width = 75
    Height = 25
    Caption = #39044#35272'(&V)'
    TabOrder = 4
    OnClick = btnPreviewClick
  end
  object cbbType: TRadioGroup
    Left = 32
    Top = 8
    Width = 103
    Height = 214
    Caption = #31867#22411
    ItemIndex = 0
    Items.Strings = (
      #27491#24120#21345#21495
      #22238#20462#21345#21495
      #25163#32455#26495#21495
      #36865#24067#21333#21495
      #37197#26041#21333#21495
      'CPB '#37197#26041
      'CPB '#20869#37096'OK'#26041
      'CPB '#23458#25143'OK'#26041)
    TabOrder = 5
    OnClick = cbbTypeClick
  end
end

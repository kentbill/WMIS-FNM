object ColorPropertyForm: TColorPropertyForm
  Left = 246
  Top = 146
  BorderStyle = bsDialog
  Caption = #39068#33394#23646#24615'...'
  ClientHeight = 207
  ClientWidth = 195
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pbUrgentColor: TPaintBox
    Left = 112
    Top = 23
    Width = 75
    Height = 75
    OnClick = btnSetClick
    OnPaint = pbUrgentColorPaint
  end
  object lblUrgentType: TLabel
    Left = 7
    Top = 5
    Width = 54
    Height = 12
    Caption = #24613#21333#31867#22411':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lstUrgentType: TListBox
    Left = 7
    Top = 23
    Width = 98
    Height = 174
    ItemHeight = 13
    TabOrder = 0
    OnClick = lstUrgentTypeClick
  end
  object btnSet: TButton
    Left = 112
    Top = 108
    Width = 75
    Height = 25
    Caption = #35774#32622'(S)'
    TabOrder = 1
    OnClick = btnSetClick
  end
  object btnOK: TButton
    Left = 112
    Top = 140
    Width = 75
    Height = 25
    Caption = #30830#23450'(&O)'
    Enabled = False
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnClose: TButton
    Left = 112
    Top = 172
    Width = 75
    Height = 25
    Cancel = True
    Caption = #36864#20986'(&X)'
    Default = True
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object dlgColor: TColorDialog
    Ctl3D = True
    Left = 80
    Top = 8
  end
end

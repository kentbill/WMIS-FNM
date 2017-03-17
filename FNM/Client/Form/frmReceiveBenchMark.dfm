object ReceiveBenchMarkForm: TReceiveBenchMarkForm
  Left = 275
  Top = 92
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'ReceiveBenchMarkForm'
  ClientHeight = 427
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    313
    427)
  PixelsPerInch = 96
  TextHeight = 13
  object GFTypeEditor: TValueListEditor
    Left = 0
    Top = 0
    Width = 313
    Height = 401
    Align = alTop
    DefaultRowHeight = 16
    TabOrder = 0
    TitleCaptions.Strings = (
      #21697#31181#31867#22411
      #25968#37327'('#30721'/'#21152#24037#25209#27425')')
    OnValidate = GFTypeEditorValidate
    ColWidths = (
      150
      157)
  end
  object btnRefresh: TButton
    Left = 80
    Top = 402
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #21047#26032'(&R)'
    TabOrder = 1
    OnClick = btnRefreshClick
  end
  object btnSave: TButton
    Left = 159
    Top = 402
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #20445#23384'(&S)'
    Default = True
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnClose: TButton
    Left = 238
    Top = 402
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #36864#20986'(&X)'
    TabOrder = 3
    OnClick = btnCloseClick
  end
end

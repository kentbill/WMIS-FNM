object QualityRemarkForm: TQualityRemarkForm
  Left = 302
  Top = 291
  BorderStyle = bsDialog
  Caption = #36136#37327#22791#27880#24405#20837
  ClientHeight = 317
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object vle_Operation_Parlist: TValueListEditor
    Left = 0
    Top = 34
    Width = 503
    Height = 245
    Align = alClient
    TabOrder = 0
    TitleCaptions.Strings = (
      #24037#24207
      #22791#27880)
    OnKeyDown = vle_Operation_ParlistKeyDown
    OnValidate = vle_Operation_ParlistValidate
    ColWidths = (
      230
      267)
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 282
    Width = 503
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      503
      35)
    object bvl2: TBevel
      Left = 0
      Top = 0
      Width = 503
      Height = 2
      Align = alTop
      Shape = bsBottomLine
    end
    object btn3: TButton
      Left = 8
      Top = 5
      Width = 75
      Height = 25
      Caption = #24110#21161'(&H)'
      TabOrder = 0
    end
    object btn_SaveArt: TButton
      Left = 335
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'(&S)'
      TabOrder = 1
      OnClick = btn_SaveArtClick
    end
    object btn_OK: TButton
      Left = 423
      Top = 5
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #36864#20986'(&X)'
      ModalResult = 1
      TabOrder = 2
      OnClick = btn_OKClick
    end
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 503
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      503
      31)
    object txt1: TStaticText
      Left = 8
      Top = 13
      Width = 34
      Height = 16
      Caption = #21697#21517':'
      TabOrder = 0
    end
    object cxbe_GFKeyValue: TcxButtonEdit
      Left = 39
      Top = 4
      Width = 176
      Height = 20
      Anchors = [akLeft, akRight]
      Properties.Buttons = <
        item
          Default = True
          Kind = bkGlyph
        end>
      Properties.OnButtonClick = cxbe_GFKeyValuePropertiesButtonClick
      TabOrder = 1
      OnKeyDown = cxbe_GFKeyValueKeyDown
    end
  end
  object TPanel
    Left = 0
    Top = 279
    Width = 503
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
  end
  object TPanel
    Left = 0
    Top = 31
    Width = 503
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
  end
end

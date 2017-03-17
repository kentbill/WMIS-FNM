object OperationAddrForm: TOperationAddrForm
  Left = 278
  Top = 257
  Width = 583
  Height = 374
  Caption = #24037#24207#21152#24037#22320#20462#25913
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object pnl_Only: TPanel
    Left = 0
    Top = 0
    Width = 222
    Height = 298
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 0
    object btn_OpenFactArt: TSpeedButton
      Left = 26
      Top = 277
      Width = 118
      Height = 25
      Caption = #20462#25913'(&K)'
      Flat = True
      OnClick = btn_OpenFactArtClick
    end
    object TPanel
      Left = 2
      Top = 2
      Width = 218
      Height = 45
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object TStaticText
        Left = 5
        Top = 24
        Width = 34
        Height = 16
        Caption = #21697#21517':'
        TabOrder = 1
      end
      object TStaticText
        Left = 0
        Top = 0
        Width = 218
        Height = 16
        Align = alTop
        Caption = #20462#25913#21697#21517#24037#33402'(&P):'
        TabOrder = 0
      end
      object cxbe_GFKeyValue: TcxButtonEdit
        Left = 35
        Top = 20
        Width = 176
        Height = 20
        Properties.Buttons = <
          item
            Default = True
            Kind = bkGlyph
          end>
        Properties.CharCase = ecUpperCase
        Properties.OnButtonClick = cxbe_GFKeyValuePropertiesButtonClick
        TabOrder = 2
        OnKeyDown = KeyDownAControl
      end
    end
    object pnl_Only2: TPanel
      Left = 2
      Top = 50
      Width = 218
      Height = 219
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 2
      object txt_Only: TStaticText
        Left = 2
        Top = 2
        Width = 214
        Height = 16
        Align = alTop
        Caption = #22312#32447#21345#21495#21015#34920':'
        TabOrder = 0
      end
      object tv_CardList: TTreeView
        Left = 2
        Top = 18
        Width = 214
        Height = 199
        Align = alClient
        HideSelection = False
        Indent = 19
        ReadOnly = True
        TabOrder = 1
        OnKeyDown = KeyDownAControl
        OnMouseDown = tv_CardListMouseDown
      end
    end
    object TPanel
      Left = 2
      Top = 47
      Width = 218
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object vle_Operation_Parlist: TValueListEditor
    Left = 225
    Top = 0
    Width = 342
    Height = 298
    Align = alClient
    TabOrder = 1
    TitleCaptions.Strings = (
      #24037#24207
      #21152#24037#22320#28857)
    OnKeyDown = vle_Operation_ParlistKeyDown
    OnSelectCell = vle_Operation_ParlistSelectCell
    OnValidate = vle_Operation_ParlistValidate
    ColWidths = (
      150
      186)
  end
  object TPanel
    Left = 222
    Top = 0
    Width = 3
    Height = 298
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
  end
  object TPanel
    Left = 0
    Top = 298
    Width = 567
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
  end
  object TPanel
    Left = 0
    Top = 301
    Width = 567
    Height = 35
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 4
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 567
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        567
        35)
      object btn3: TButton
        Left = 8
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #24110#21161'(&H)'
        TabOrder = 0
      end
      object btn_SaveArt: TButton
        Left = 409
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = btn_SaveArtClick
      end
      object btn_OK: TButton
        Left = 497
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
  end
end

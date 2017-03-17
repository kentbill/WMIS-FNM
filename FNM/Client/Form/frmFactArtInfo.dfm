object FactArtInfoForm: TFactArtInfoForm
  Left = 234
  Top = 141
  Width = 748
  Height = 488
  Caption = #20462#25913#23454#38469#24037#33402
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = KeyDownAControl
  PixelsPerInch = 96
  TextHeight = 12
  object cxspl_XX: TcxSplitter
    Left = 177
    Top = 88
    Width = 8
    Height = 332
    HotZoneClassName = 'TcxXPTaskBarStyle'
    Control = pnl_Only
  end
  object TPanel
    Left = 0
    Top = 85
    Width = 732
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 88
    Width = 177
    Height = 332
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 2
    object btn_OpenFactArt: TSpeedButton
      Left = 27
      Top = 309
      Width = 118
      Height = 22
      Caption = #26597#30475#24037#33402'(&K)'
      Enabled = False
      Flat = True
      OnClick = ClickOpenFactArt
    end
    object TPanel
      Left = 2
      Top = 2
      Width = 173
      Height = 44
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        173
        44)
      object TStaticText
        Left = 5
        Top = 5
        Width = 154
        Height = 16
        Caption = #21697#21517'(&G) '#20026#31354#26102#20026#20869#22238#20462' :'
        FocusControl = cxbe_GFKeyValue
        TabOrder = 1
      end
      object cxbe_GFKeyValue: TcxButtonEdit
        Left = 10
        Top = 19
        Width = 156
        Height = 20
        Anchors = [akLeft, akRight]
        Properties.Buttons = <
          item
            Default = True
            Kind = bkGlyph
          end>
        Properties.OnButtonClick = cxbe_GF_NO_FNCardPropertiesButtonClick
        TabOrder = 0
        OnKeyDown = KeyDownAControl
      end
    end
    object pnl_Only2: TPanel
      Left = 2
      Top = 49
      Width = 173
      Height = 224
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object txt_Only: TStaticText
        Left = 0
        Top = 0
        Width = 173
        Height = 16
        Align = alTop
        BevelKind = bkFlat
        BevelOuter = bvNone
        Caption = #22312#32447#21345#21495#21015#34920':'
        TabOrder = 0
      end
      object tv_CardList: TTreeView
        Left = 0
        Top = 16
        Width = 173
        Height = 208
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
      Top = 46
      Width = 173
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 732
    Height = 85
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object TStaticText
      Left = 621
      Top = 40
      Width = 58
      Height = 16
      Caption = #35774#35745#26102#38388':'
      TabOrder = 21
    end
    object TStaticText
      Left = 315
      Top = 15
      Width = 58
      Height = 16
      Caption = #22383#24067#23494#24230':'
      TabOrder = 5
    end
    object TStaticText
      Left = 315
      Top = 40
      Width = 58
      Height = 16
      Caption = #25104#21697#23494#24230':'
      TabOrder = 12
    end
    object TStaticText
      Left = 315
      Top = 64
      Width = 58
      Height = 16
      Caption = #21518#25972#32553#29575':'
      TabOrder = 19
    end
    object TStaticText
      Left = 160
      Top = 64
      Width = 46
      Height = 16
      Caption = 'BR'#21547#37327':'
      TabOrder = 23
    end
    object edt_Density: TEdit
      Left = 371
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object edt_GreyDensity: TEdit
      Left = 371
      Top = 7
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object TStaticText
      Left = 5
      Top = 40
      Width = 34
      Height = 16
      Caption = #23458#25143':'
      TabOrder = 10
    end
    object txt1: TStaticText
      Left = 5
      Top = 15
      Width = 34
      Height = 16
      Caption = #21697#21517':'
      TabOrder = 3
    end
    object TStaticText
      Left = 148
      Top = 15
      Width = 58
      Height = 16
      Caption = #22383#24067#24133#23485':'
      TabOrder = 4
    end
    object TStaticText
      Left = 148
      Top = 40
      Width = 58
      Height = 16
      Caption = #25104#21697#24133#23485':'
      TabOrder = 11
    end
    object TStaticText
      Left = 483
      Top = 64
      Width = 34
      Height = 16
      Caption = #35774#35745':'
      TabOrder = 20
    end
    object edt_Customer: TEdit
      Left = 37
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 6
    end
    object edt_Grey_Width: TEdit
      Left = 202
      Top = 7
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object edt_Width: TEdit
      Left = 202
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object edt_Designer: TEdit
      Left = 513
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 16
    end
    object edt_Designer_Time: TEdit
      Left = 627
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      BevelEdges = [beLeft, beTop]
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 17
    end
    object edt_GFKeyValue: TEdit
      Left = 37
      Top = 7
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object edt_FN_Shrinkage: TEdit
      Left = 371
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 15
    end
    object TStaticText
      Left = 5
      Top = 64
      Width = 34
      Height = 16
      Caption = #33639#20809':'
      TabOrder = 18
    end
    object edt_Anti_Fluorescence: TEdit
      Left = 37
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 14
    end
    object TStaticText
      Left = 483
      Top = 40
      Width = 34
      Height = 16
      Caption = #29256#26412':'
      TabOrder = 13
    end
    object edt_Version: TEdit
      Left = 513
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
    end
    object edt_BR: TEdit
      Left = 202
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 22
    end
    object TStaticText
      Left = 482
      Top = 15
      Width = 34
      Height = 16
      Caption = #31576#24133':'
      TabOrder = 24
    end
    object edt_ReedWidth: TEdit
      Left = 512
      Top = 8
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 25
    end
  end
  object pnl_Only1: TPanel
    Left = 185
    Top = 88
    Width = 547
    Height = 332
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object spl1: TSplitter
      Left = 185
      Top = 82
      Width = 3
      Height = 185
      Cursor = crHSplit
    end
    object grp_Only: TGroupBox
      Left = 0
      Top = 267
      Width = 547
      Height = 65
      Align = alBottom
      Caption = #22791#27880
      TabOrder = 4
      object mmo_Remark: TMemo
        Left = 2
        Top = 14
        Width = 543
        Height = 49
        Hint = #22791#27880'|'#24037#24207#30340#25972#20307#22791#27880
        Align = alClient
        ImeMode = imHanguel
        MaxLength = 150
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = ChangeAEdit
      end
    end
    object TPanel
      Left = 0
      Top = 82
      Width = 185
      Height = 185
      Align = alLeft
      BevelInner = bvLowered
      TabOrder = 2
      object TPanel
        Left = 154
        Top = 18
        Width = 29
        Height = 165
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object btn_MoveUP_Operation: TSpeedButton
          Left = 3
          Top = 83
          Width = 24
          Height = 24
          Hint = #19978#31227'|'#23558#24403#21069#21152#24037#24037#24207#19978#31227#19968#27493
          Flat = True
          OnClick = btn_Operation
        end
        object btn_MoveDown_Operation: TSpeedButton
          Left = 3
          Top = 117
          Width = 24
          Height = 24
          Hint = #19979#31227'|'#23558#24403#21069#21152#24037#24037#24207#19979#31227#19968#27493
          Flat = True
          OnClick = btn_Operation
        end
        object btn_Del_Operation: TSpeedButton
          Left = 3
          Top = 44
          Width = 24
          Height = 24
          Hint = #21024#38500'|'#21024#38500#24403#21069#24037#24207
          Flat = True
          OnClick = btn_Operation
        end
        object btn_Add_Operation: TSpeedButton
          Left = 3
          Top = 10
          Width = 24
          Height = 24
          Hint = #28155#21152'|'#28155#21152#36873#25321#30340#24037#24207
          Flat = True
          OnClick = btn_Add_OperationClick
        end
      end
      object TStaticText
        Left = 2
        Top = 2
        Width = 181
        Height = 16
        Align = alTop
        Caption = #24037#24207#21015#34920'(&W):'
        TabOrder = 0
      end
      object lst_Operationlist: TListBox
        Left = 2
        Top = 18
        Width = 152
        Height = 165
        Style = lbOwnerDrawFixed
        Align = alClient
        BevelOuter = bvNone
        ItemHeight = 12
        TabOrder = 2
        OnClick = chklst_OperationlistClick
        OnKeyDown = KeyDownAControl
      end
    end
    object TPanel
      Left = 0
      Top = 79
      Width = 547
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object TPanel
      Left = 188
      Top = 82
      Width = 359
      Height = 185
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 3
      object pgc_Operation: TPageControl
        Left = 2
        Top = 2
        Width = 355
        Height = 181
        Align = alClient
        Style = tsFlatButtons
        TabIndex = 0
        TabOrder = 0
        OnChange = pgc_OperationChange
        object TTabSheet
          Caption = #21487#36873#24037#24207
          ImageIndex = 1
          object cbb_Operation_Name: TComboBox
            Left = 0
            Top = 0
            Width = 193
            Height = 105
            Style = csSimple
            ItemHeight = 12
            TabOrder = 0
            OnKeyDown = KeyDownAControl
          end
        end
        object ts_Only: TTabSheet
          Caption = #24037#24207#21442#25968
          object Vle_Operation_Parlist: TValueListEditor
            Left = 0
            Top = 0
            Width = 347
            Height = 151
            Hint = #24037#24207#21442#25968'|'#36873#23450#24037#24207#30340#21442#25968
            Align = alClient
            TabOrder = 0
            TitleCaptions.Strings = (
              #21442#25968#21517
              #21442#25968#20540)
            OnEditButtonClick = Vle_Operation_ParlistEditButtonClick
            OnKeyDown = Vle_Operation_ParlistKeyDown
            OnValidate = Vle_Operation_ParlistValidate
            ColWidths = (
              132
              217)
          end
        end
      end
    end
    object TPanel
      Left = 0
      Top = 0
      Width = 547
      Height = 79
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 0
      object TStaticText
        Left = 366
        Top = 36
        Width = 34
        Height = 16
        Caption = #25163#24863':'
        TabOrder = 10
      end
      object TStaticText
        Left = 366
        Top = 14
        Width = 34
        Height = 16
        Caption = #32553#27700':'
        TabOrder = 2
      end
      object TStaticText
        Left = 4
        Top = 14
        Width = 46
        Height = 16
        Caption = #24037#33402#21495':'
        TabOrder = 0
      end
      object TStaticText
        Left = 4
        Top = 36
        Width = 46
        Height = 16
        Caption = #39068#33394#21495':'
        TabOrder = 3
      end
      object TStaticText
        Left = 189
        Top = 14
        Width = 34
        Height = 16
        AutoSize = False
        Caption = #33639#20809':'
        TabOrder = 1
      end
      object TStaticText
        Left = 189
        Top = 36
        Width = 34
        Height = 16
        AutoSize = False
        Caption = #33457#22411':'
        TabOrder = 4
      end
      object edt_FN_Art_NO1: TEdit
        Tag = 1
        Left = 48
        Top = 7
        Width = 130
        Height = 20
        Hint = #24037#33402#20195#21495'|'#21518#25972#29702#26631#20934#24037#33402#20195#21495
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 6
        OnChange = ChangeAEdit
        OnKeyDown = KeyDownAComboBox
      end
      object edt_ColorCode: TEdit
        Left = 48
        Top = 29
        Width = 130
        Height = 20
        Hint = #39068#33394#20195#21495
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 5
        OnChange = ChangeAEdit
        OnKeyDown = KeyDownAComboBox
      end
      object edt_FN_Art_NO4: TEdit
        Tag = 4
        Left = 223
        Top = 29
        Width = 130
        Height = 20
        Hint = #24037#33402#20195#21495'|'#33457#22411
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 7
        OnChange = ChangeAEdit
        OnKeyDown = KeyDownAComboBox
      end
      object edt_FN_Art_NO2: TEdit
        Tag = 2
        Left = 223
        Top = 7
        Width = 130
        Height = 20
        Hint = #24037#33402#20195#21495'|'#21518#25972#29702#23376#24037#33402#20195#21495
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 8
        OnChange = ChangeAEdit
        OnKeyDown = KeyDownAComboBox
      end
      object edt_Shrinkage: TEdit
        Tag = 2
        Left = 402
        Top = 7
        Width = 130
        Height = 20
        Hint = #24037#33402#20195#21495'|'#21518#25972#29702#23376#24037#33402#20195#21495
        BevelEdges = [beLeft, beTop]
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 9
        OnChange = ChangeAEdit
        OnKeyDown = KeyDownAComboBox
      end
      object edt_HandFeel: TEdit
        Left = 402
        Top = 29
        Width = 130
        Height = 20
        Hint = #21697#21517'|'#23558#35201#36171#20540#26631#20934#24037#33402#30340#21697#21517
        BevelEdges = [beLeft, beTop]
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 11
        OnKeyDown = KeyDownAControl
      end
      object TStaticText
        Left = 16
        Top = 57
        Width = 34
        Height = 16
        Caption = #38376#24133':'
        FocusControl = edt_ProductWidth
        TabOrder = 12
      end
      object edt_ProductWidth: TEdit
        Left = 48
        Top = 51
        Width = 130
        Height = 20
        BevelEdges = [beLeft, beTop]
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 13
        OnKeyDown = KeyDownAControl
      end
      object cbb_ReasonName: TComboBox
        Left = 402
        Top = 51
        Width = 130
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 14
      end
      object TStaticText
        Left = 366
        Top = 57
        Width = 34
        Height = 16
        Caption = #21407#22240':'
        TabOrder = 15
      end
      object TStaticText
        Left = 190
        Top = 57
        Width = 34
        Height = 16
        Caption = #31867#22411':'
        TabOrder = 16
      end
      object cbb_ReasonType: TComboBox
        Left = 223
        Top = 51
        Width = 130
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 17
        OnSelect = cbb_ReasonTypeSelect
      end
    end
  end
  object TPanel
    Left = 0
    Top = 420
    Width = 732
    Height = 30
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 5
    object TPanel
      Left = 0
      Top = 0
      Width = 732
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        732
        30)
      object btn_Help: TSpeedButton
        Left = 8
        Top = 4
        Width = 75
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
      end
      object btn_Exit: TSpeedButton
        Left = 656
        Top = 4
        Width = 75
        Height = 22
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
      object btn_SaveArt: TSpeedButton
        Left = 567
        Top = 4
        Width = 75
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveArtClick
      end
      object btn_ViewArtDtl: TSpeedButton
        Left = 478
        Top = 4
        Width = 75
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = #26597#30475'(&W)'
        Flat = True
        OnClick = btn_ViewArtDtlClick
      end
      object lblRemark: TLabel
        Left = 128
        Top = 8
        Width = 7
        Height = 13
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object cdsRemark: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 432
  end
  object cdsRecipe: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 424
  end
end

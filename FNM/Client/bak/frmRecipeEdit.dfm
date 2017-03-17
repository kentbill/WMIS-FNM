object RecipeEditForm: TRecipeEditForm
  Left = 277
  Top = 103
  Width = 729
  Height = 406
  Caption = #21270#26009#21333#20462#25913
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
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
  object spl3: TSplitter
    Left = 175
    Top = 35
    Width = 3
    Height = 314
    Cursor = crHSplit
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 721
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Only: TStaticText
      Left = 5
      Top = 14
      Width = 34
      Height = 16
      Caption = #21333#21495':'
      TabOrder = 0
    end
    object TStaticText
      Left = 162
      Top = 14
      Width = 34
      Height = 16
      Caption = #24037#24207':'
      TabOrder = 1
    end
    object TStaticText
      Left = 324
      Top = 14
      Width = 46
      Height = 16
      Caption = #35774#35745#20154':'
      TabOrder = 2
    end
    object TStaticText
      Left = 500
      Top = 14
      Width = 58
      Height = 16
      Caption = #35774#35745#26102#38388':'
      TabOrder = 3
    end
    object edt_OperationName: TEdit
      Left = 193
      Top = 6
      Width = 121
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object edt_Designer: TEdit
      Left = 369
      Top = 6
      Width = 121
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
    object edt_DesignerTime: TEdit
      Left = 555
      Top = 6
      Width = 121
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 6
    end
    object edt_RecipeNO1: TEdit
      Left = 36
      Top = 6
      Width = 121
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
  end
  object TPanel
    Left = 0
    Top = 32
    Width = 721
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
  object TPanel
    Left = 178
    Top = 35
    Width = 543
    Height = 314
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object spl2: TSplitter
      Left = 0
      Top = 217
      Width = 543
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object pnl_Only1: TPanel
      Left = 0
      Top = 74
      Width = 543
      Height = 143
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object spl1: TSplitter
        Left = 177
        Top = 3
        Width = 3
        Height = 140
        Cursor = crHSplit
      end
      object TPanel
        Left = 0
        Top = 3
        Width = 177
        Height = 140
        Align = alLeft
        BevelInner = bvLowered
        TabOrder = 1
        object TPanel
          Left = 144
          Top = 18
          Width = 31
          Height = 120
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 2
          object btn_Add_Chemical: TSpeedButton
            Left = 4
            Top = 18
            Width = 23
            Height = 22
            Flat = True
            OnClick = ClickASpeedButton
          end
          object btn_Del_Chemical: TSpeedButton
            Left = 4
            Top = 67
            Width = 23
            Height = 22
            Flat = True
            OnClick = ClickASpeedButton
          end
        end
        object TStaticText
          Left = 2
          Top = 2
          Width = 173
          Height = 16
          Align = alTop
          Caption = #21487#36873#21270#24037#26009'(&C):'
          TabOrder = 0
        end
        object tv_ChemicalName: TTreeView
          Left = 2
          Top = 18
          Width = 142
          Height = 120
          Align = alClient
          HideSelection = False
          Indent = 19
          ReadOnly = True
          TabOrder = 1
          OnKeyDown = KeyDownAControl
        end
      end
      object TPanel
        Left = 0
        Top = 0
        Width = 543
        Height = 3
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
      end
      object Vle_Chemicallist: TValueListEditor
        Left = 180
        Top = 3
        Width = 363
        Height = 140
        Align = alClient
        TabOrder = 2
        TitleCaptions.Strings = (
          #21270#24037#26009#21517
          #29992#37327'(g/L)')
        OnGetEditMask = Vle_ChemicallistGetEditMask
        OnGetPickList = Vle_ChemicallistGetPickList
        OnValidate = Vle_ChemicallistValidate
        ColWidths = (
          152
          205)
      end
    end
    object TPanel
      Left = 0
      Top = 0
      Width = 543
      Height = 74
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 1
      object TStaticText
        Left = 16
        Top = 33
        Width = 46
        Height = 16
        Caption = #28322#27969#37327':'
        TabOrder = 0
      end
      object TStaticText
        Left = 173
        Top = 11
        Width = 58
        Height = 16
        Caption = #39044#28888#28201#24230':'
        TabOrder = 1
      end
      object cbb_FloodPercent: TComboBox
        Left = 61
        Top = 27
        Width = 108
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 2
        Text = #23567
        OnChange = ChangeValues
        Items.Strings = (
          #23567
          #20013
          #22823)
      end
      object TStaticText
        Left = 173
        Top = 33
        Width = 58
        Height = 16
        Caption = #28888#24178#28201#24230':'
        TabOrder = 3
      end
      object cxSE_Pre_Dry_Temperature: TcxSpinEdit
        Left = 228
        Top = 5
        Width = 108
        Height = 20
        Properties.MinValue = 1
        Properties.SpinButtons.ShowFastButtons = True
        Properties.OnChange = ChangeValues
        TabOrder = 4
      end
      object cxSE_Dry_Temperature: TcxSpinEdit
        Left = 228
        Top = 27
        Width = 108
        Height = 20
        Properties.MinValue = 1
        Properties.SpinButtons.ShowFastButtons = True
        Properties.OnChange = ChangeValues
        TabOrder = 5
      end
      object TStaticText
        Left = 4
        Top = 11
        Width = 58
        Height = 16
        Caption = #28322#27969#31867#22411':'
        TabOrder = 6
      end
      object cbb_FloodClass: TComboBox
        Left = 61
        Top = 5
        Width = 108
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 7
        Text = #24490#29615#28322#27969
        OnChange = ChangeValues
        Items.Strings = (
          #24490#29615#28322#27969
          #22806#28322#27969)
      end
      object TStaticText
        Left = 341
        Top = 11
        Width = 34
        Height = 16
        Caption = #26426#21488':'
        TabOrder = 8
      end
      object cbb_MachineID: TComboBox
        Left = 370
        Top = 6
        Width = 108
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 9
        OnChange = ChangeValues
      end
      object TStaticText
        Left = 28
        Top = 54
        Width = 34
        Height = 16
        Caption = #35797'2Y:'
        TabOrder = 10
      end
      object cbb_SampleType: TComboBox
        Left = 61
        Top = 48
        Width = 108
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 11
        Text = '0->'#19981#35797
        OnChange = ChangeValues
        Items.Strings = (
          '0->'#19981#35797
          '1->'#22836#32568#35797
          '2->'#27599#32568#37117#35797)
      end
      object TStaticText
        Left = 197
        Top = 54
        Width = 34
        Height = 16
        Caption = #36319#36394':'
        TabOrder = 12
      end
      object cbb_NeedTrace: TComboBox
        Left = 228
        Top = 48
        Width = 108
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 13
        Text = '0->'#19981#35201#36319#36394
        OnChange = ChangeValues
        Items.Strings = (
          '0->'#19981#35201#36319#36394
          '1->'#22836#32568#36319#36394
          '2->'#27599#32568#37117#36319#36394)
      end
    end
    object pnl2: TPanel
      Left = 0
      Top = 220
      Width = 543
      Height = 94
      Align = alBottom
      TabOrder = 2
      object Splitter1: TSplitter
        Left = 302
        Top = 1
        Width = 3
        Height = 92
        Cursor = crHSplit
      end
      object grp_Only: TGroupBox
        Left = 305
        Top = 1
        Width = 237
        Height = 92
        Align = alClient
        Caption = #22791#27880
        TabOrder = 0
        object mmo_Remark: TMemo
          Left = 2
          Top = 14
          Width = 233
          Height = 76
          Align = alClient
          ImeMode = imHanguel
          ScrollBars = ssVertical
          TabOrder = 0
          OnChange = ChangeValues
        end
      end
      object grp1: TGroupBox
        Left = 1
        Top = 1
        Width = 301
        Height = 92
        Align = alLeft
        Caption = #21345#21495
        TabOrder = 1
        object TPanel
          Left = 2
          Top = 14
          Width = 27
          Height = 76
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object btn_DeleteCard: TSpeedButton
            Left = 2
            Top = 0
            Width = 23
            Height = 73
            Hint = #21024#38500#21345#21495'|'#21024#38500#24403#21069#36873#25321#30340#21345#21495#12290
            Caption = #21024#13#10#38500#13#10#21345#13#10#21495#13#10
            Flat = True
            Layout = blGlyphTop
            OnClick = ClickASpeedButton
          end
        end
        object lv_IncludeCard: TListView
          Left = 29
          Top = 14
          Width = 270
          Height = 76
          Align = alClient
          Columns = <
            item
              Caption = #21345#21495
              Width = 85
            end
            item
              Caption = #21697#21517
              Width = 120
            end
            item
              Caption = #30721#38271
              Width = 60
            end>
          GridLines = True
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
        end
      end
    end
  end
  object TPanel
    Left = 0
    Top = 35
    Width = 175
    Height = 314
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 2
    object TPanel
      Left = 2
      Top = 2
      Width = 171
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object btn_Query: TSpeedButton
        Left = 144
        Top = 0
        Width = 23
        Height = 22
        Flat = True
        OnClick = btn_QueryClick
      end
      object edt_RecipeNO: TEdit
        Left = 0
        Top = 0
        Width = 145
        Height = 20
        TabOrder = 0
        Text = 'RN0601050045'
      end
    end
    object TPanel
      Left = 2
      Top = 290
      Width = 171
      Height = 22
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btn_NewStep: TSpeedButton
        Left = 0
        Top = 0
        Width = 133
        Height = 22
        Caption = #26032#24314#19968#27493'(&N)'
        Flat = True
      end
      object btn_DelStep: TSpeedButton
        Left = 144
        Top = 0
        Width = 23
        Height = 22
        Flat = True
      end
    end
    object lst_StepList: TListBox
      Left = 2
      Top = 24
      Width = 171
      Height = 266
      Align = alClient
      ItemHeight = 12
      TabOrder = 2
      OnKeyDown = KeyDownAControl
    end
  end
  object TPanel
    Left = 0
    Top = 349
    Width = 721
    Height = 30
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 4
    object TPanel
      Left = 0
      Top = 0
      Width = 721
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        721
        30)
      object btn_Help: TSpeedButton
        Left = 8
        Top = 5
        Width = 75
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
      end
      object btn_DeleteRecipe: TSpeedButton
        Left = 474
        Top = 5
        Width = 75
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = #21024#38500'(&D)'
        Flat = True
        OnClick = ClickAButton
      end
      object btn_SaveRecipe: TSpeedButton
        Left = 557
        Top = 5
        Width = 75
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = ClickAButton
      end
      object btn_Exit: TSpeedButton
        Left = 640
        Top = 5
        Width = 75
        Height = 22
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
    end
  end
  object dsz: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Assistant_Prescrip_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Prescrip_NO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Parent_Prescrip_NO'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 88
    Top = 539
  end
  object cds_NoFinishRecipe: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 400
  end
  object ds_NoFinishRecipe: TDataSource
    DataSet = cds_NoFinishRecipe
    Left = 120
    Top = 400
  end
end

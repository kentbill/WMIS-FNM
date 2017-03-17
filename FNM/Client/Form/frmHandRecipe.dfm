object HandRecipeForm: THandRecipeForm
  Left = 314
  Top = 122
  Width = 968
  Height = 466
  Caption = #25163#24037#24320#21270#26009#21333
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
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
  object TPanel
    Left = 0
    Top = 33
    Width = 960
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object pnl_Only1: TPanel
    Left = 214
    Top = 36
    Width = 746
    Height = 368
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object TPanel
      Left = 0
      Top = 0
      Width = 746
      Height = 73
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 0
      object TStaticText
        Left = 16
        Top = 33
        Width = 46
        Height = 16
        Caption = #28322#27969#37327':'
        TabOrder = 3
      end
      object TStaticText
        Left = 173
        Top = 11
        Width = 58
        Height = 16
        Caption = #39044#28888#28201#24230':'
        TabOrder = 0
      end
      object cbb_FloodPercent: TComboBox
        Left = 61
        Top = 27
        Width = 108
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 1
        OnChange = ChangeValues
        Items.Strings = (
          #23567
          #20013
          #22823
          #26080)
      end
      object TStaticText
        Left = 173
        Top = 33
        Width = 58
        Height = 16
        Caption = #28888#24178#28201#24230':'
        TabOrder = 2
      end
      object cxSE_Pre_Dry_Temperature: TcxSpinEdit
        Left = 228
        Top = 5
        Width = 108
        Height = 20
        Properties.MinValue = 1
        Properties.SpinButtons.ShowFastButtons = True
        TabOrder = 4
      end
      object cxSE_Dry_Temperature: TcxSpinEdit
        Left = 228
        Top = 27
        Width = 108
        Height = 20
        Properties.MinValue = 1
        Properties.SpinButtons.ShowFastButtons = True
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
        TabOrder = 7
        OnChange = ChangeValues
        Items.Strings = (
          #24490#29615#28322#27969
          #22806#28322#27969
          #19981#28322#27969)
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
    object TPanel
      Left = 0
      Top = 76
      Width = 746
      Height = 292
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object spl1: TSplitter
        Left = 177
        Top = 0
        Width = 3
        Height = 178
        Cursor = crHSplit
      end
      object spl2: TSplitter
        Left = 0
        Top = 178
        Width = 746
        Height = 3
        Cursor = crVSplit
        Align = alBottom
      end
      object TPanel
        Left = 0
        Top = 0
        Width = 177
        Height = 178
        Align = alLeft
        BevelInner = bvLowered
        TabOrder = 0
        object TPanel
          Left = 144
          Top = 18
          Width = 31
          Height = 158
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
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
            Top = 61
            Width = 23
            Height = 22
            Flat = True
            OnClick = ClickASpeedButton
          end
        end
        object txt_Only: TStaticText
          Left = 2
          Top = 2
          Width = 173
          Height = 16
          Align = alTop
          Caption = #21270#24037#26009'(&C):'
          TabOrder = 1
        end
        object tv_Chemical_Name: TTreeView
          Left = 2
          Top = 18
          Width = 142
          Height = 158
          Align = alClient
          Indent = 19
          TabOrder = 2
          OnKeyDown = KeyDownAControl
        end
      end
      object pnl2: TPanel
        Left = 0
        Top = 181
        Width = 746
        Height = 111
        Align = alBottom
        TabOrder = 1
        object spl3: TSplitter
          Left = 302
          Top = 1
          Width = 3
          Height = 109
          Cursor = crHSplit
        end
        object grp_Only: TGroupBox
          Left = 305
          Top = 1
          Width = 440
          Height = 109
          Align = alClient
          Caption = #22791#27880
          TabOrder = 0
          object mmo_Remark: TMemo
            Left = 2
            Top = 14
            Width = 436
            Height = 93
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
          Height = 109
          Align = alLeft
          Caption = #21345#21495
          TabOrder = 1
          object TPanel
            Left = 2
            Top = 14
            Width = 27
            Height = 93
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object btn_DeleteCard: TSpeedButton
              Left = 2
              Top = 11
              Width = 23
              Height = 78
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
            Height = 93
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
      object Vle_Chemicallist: TValueListEditor
        Left = 180
        Top = 0
        Width = 566
        Height = 178
        Align = alClient
        TabOrder = 2
        TitleCaptions.Strings = (
          #21270#24037#26009#21517
          #29992#37327'(g/L)')
        OnGetEditMask = Vle_ChemicallistGetEditMask
        OnGetPickList = Vle_ChemicallistGetPickList
        OnKeyDown = Vle_ChemicallistKeyDown
        OnValidate = Vle_ChemicallistValidate
        ColWidths = (
          140
          420)
      end
    end
    object TPanel
      Left = 0
      Top = 73
      Width = 746
      Height = 3
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  object pnl_Only: TPanel
    Left = 0
    Top = 36
    Width = 206
    Height = 368
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 2
    object pgc_HandRecipe: TPageControl
      Left = 2
      Top = 2
      Width = 202
      Height = 364
      ActivePage = ts_Only
      Align = alClient
      Style = tsFlatButtons
      TabIndex = 0
      TabOrder = 0
      OnChange = pgc_HandRecipeChange
      object ts_Only: TTabSheet
        Caption = #21046#23450#21270#26009#21333
        DesignSize = (
          194
          334)
        object TPanel
          Left = 0
          Top = 0
          Width = 194
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            194
            28)
          object TStaticText
            Left = 5
            Top = 8
            Width = 34
            Height = 16
            Caption = #21697#21517':'
            TabOrder = 0
          end
          object cxbe_GF_KeyValue: TcxButtonEdit
            Left = 38
            Top = 4
            Width = 147
            Height = 20
            Anchors = [akLeft, akTop, akRight]
            Properties.Buttons = <
              item
                Default = True
                Kind = bkGlyph
              end>
            Properties.OnButtonClick = ClickAcxbePropertiesButton
            TabOrder = 1
            OnKeyDown = KeyDownAControl
          end
        end
        object TPanel
          Left = 0
          Top = 28
          Width = 194
          Height = 3
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
        end
        object cbb_OnLineOperation: TComboBox
          Left = 8
          Top = 32
          Width = 185
          Height = 289
          Style = csSimple
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 12
          TabOrder = 2
          OnKeyDown = KeyDownAControl
        end
      end
      object TTabSheet
        Caption = #23457#26680#21270#26009#21333
        ImageIndex = 1
        object TPanel
          Left = 0
          Top = 0
          Width = 194
          Height = 25
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object btn_RefrshNoCheckList: TSpeedButton
            Left = 16
            Top = 0
            Width = 160
            Height = 24
            Hint = #21047#26032'|'#21047#26032#21270#26009#21333#21015#34920
            Caption = #21047#26032'(F5)'
            Flat = True
            OnClick = btn_RefrshNoCheckListClick
          end
        end
        object TPanel
          Left = 0
          Top = 25
          Width = 194
          Height = 3
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
        end
        object lst_NOCheckList: TListBox
          Left = 0
          Top = 28
          Width = 194
          Height = 306
          Align = alClient
          ItemHeight = 12
          TabOrder = 2
          OnKeyDown = KeyDownAControl
        end
      end
    end
  end
  object cxspl_Only: TcxSplitter
    Left = 206
    Top = 36
    Width = 8
    Height = 368
    HotZoneClassName = 'TcxXPTaskBarStyle'
    Control = pnl_Only
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 960
    Height = 33
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 4
    object TStaticText
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
    object edt_RecipeNO: TEdit
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
    Top = 404
    Width = 960
    Height = 28
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 5
    object TPanel
      Left = 0
      Top = 0
      Width = 960
      Height = 28
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        960
        28)
      object btn_Help: TSpeedButton
        Left = 8
        Top = 3
        Width = 75
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
      end
      object btn_Check: TSpeedButton
        Left = 626
        Top = 3
        Width = 75
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = #30830#35748'(&V)'
        Flat = True
        OnClick = btn_CheckClick
      end
      object btn_Save: TSpeedButton
        Left = 793
        Top = 3
        Width = 75
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveClick
      end
      object btn_Exit: TSpeedButton
        Left = 876
        Top = 3
        Width = 75
        Height = 22
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
      object btn_DeletetAssiPrescription: TSpeedButton
        Left = 709
        Top = 3
        Width = 75
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = #21024#38500'(&D)'
        Flat = True
        OnClick = btn_DeletetAssiPrescriptionClick
      end
    end
  end
  object ds_NoRecipeCards: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 349
  end
end

object StdArtInfoForm: TStdArtInfoForm
  Left = 235
  Top = 74
  Width = 1001
  Height = 573
  Caption = #21046#23450#26631#20934#24037#33402
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = True
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
  object pnl_Only: TPanel
    Left = 0
    Top = 86
    Width = 241
    Height = 412
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object TGroupBox
      Left = 0
      Top = 359
      Width = 241
      Height = 53
      Align = alBottom
      Caption = #22797#21046#24037#33402
      TabOrder = 0
      DesignSize = (
        241
        53)
      object btn_CopyExistArt: TSpeedButton
        Left = 176
        Top = 17
        Width = 59
        Height = 25
        Hint = #22797#21046#24037#33402'|'#22797#21046#36755#20837#21697#21517#30340#26631#20934#24037#33402
        Anchors = [akRight]
        Caption = #22797#21046
        Enabled = False
        Flat = True
        PopupMenu = pm_CopyExistArt
        OnClick = btn_CopyExistArtClick
      end
      object TStaticText
        Left = 5
        Top = 23
        Width = 58
        Height = 16
        Anchors = [akLeft, akBottom]
        Caption = #21697#21517'(&P):'
        TabOrder = 1
      end
      object edt_CopyExistArt: TEdit
        Left = 51
        Top = 19
        Width = 122
        Height = 20
        Hint = #21697#21517'|'#23558#35201#36171#20540#26631#20934#24037#33402#30340#21697#21517
        TabStop = False
        Anchors = [akLeft, akRight, akBottom]
        Color = clBtnFace
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        OnKeyDown = KeyDownAControl
      end
    end
    object TPanel
      Left = 0
      Top = 0
      Width = 241
      Height = 359
      Align = alClient
      BevelInner = bvLowered
      TabOrder = 1
      object pgc_GFNOList: TPageControl
        Left = 2
        Top = 2
        Width = 237
        Height = 355
        ActivePage = ts_UnConfirm
        Align = alClient
        HotTrack = True
        MultiLine = True
        Style = tsFlatButtons
        TabIndex = 3
        TabOrder = 0
        OnChange = pgc_GFNOListChange
        object ts_NoCheck: TTabSheet
          Caption = #37096#24453#30830#35748
          object lv_CurNOCheckArt: TListView
            Left = 0
            Top = 0
            Width = 229
            Height = 302
            Hint = #21697#21517#21015#34920'|'#26410#30830#35748#24037#33402#30340#21697#21517#21015#34920
            Align = alClient
            Columns = <
              item
                Caption = #21697#21517
                Width = 160
              end
              item
                Caption = #24037#33402#20195#21495
                Width = 0
              end
              item
                Caption = #32433#25903
              end
              item
                Caption = 'CAD'
                Width = 0
              end>
            GridLines = True
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = lv_CurNOCheckArtColumnClick
            OnCustomDrawItem = lv_CurNOCheckArtCustomDrawItem
            OnKeyDown = KeyDownAControl
          end
        end
        object ts_Other: TTabSheet
          Caption = #20854#23427#24453#30830#35748
          ImageIndex = 1
          object lv_OtherNOCheckArt: TListView
            Left = 0
            Top = 0
            Width = 229
            Height = 302
            Hint = #21697#21517#21015#34920'|'#26410#30830#35748#24037#33402#30340#21697#21517#21015#34920
            Align = alClient
            Columns = <
              item
                Caption = #21697#21517
                Width = 160
              end
              item
                Caption = #24037#33402#20195#21495
                Width = 0
              end
              item
                Caption = #32433#25903
              end
              item
                Caption = 'CAD'
                Width = 0
              end>
            GridLines = True
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = lv_OtherNOCheckArtColumnClick
            OnCustomDrawItem = lv_OtherNOCheckArtCustomDrawItem
            OnKeyDown = KeyDownAControl
          end
        end
        object ts_Feedback: TTabSheet
          Caption = #24037#33402#21453#39304
          ImageIndex = 2
          object lv_Feedback: TListView
            Left = 0
            Top = 0
            Width = 229
            Height = 302
            Hint = #21697#21517#21015#34920'|'#26410#30830#35748#24037#33402#30340#21697#21517#21015#34920
            Align = alClient
            Columns = <
              item
                Caption = #21697#21517
                Width = 160
              end
              item
                Caption = #24037#33402#20195#21495
                Width = 0
              end
              item
                Caption = #32433#25903
              end
              item
                Caption = 'CAD'
                Width = 0
              end>
            GridLines = True
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = lv_FeedbackColumnClick
            OnCustomDrawItem = lv_FeedbackCustomDrawItem
            OnKeyDown = KeyDownAControl
          end
        end
        object ts_UnConfirm: TTabSheet
          Caption = #24453#35843#24230#30830#35748
          ImageIndex = 3
          object lv_UNConfirm: TListView
            Left = 0
            Top = 0
            Width = 229
            Height = 302
            Hint = #21697#21517#21015#34920'|'#26410#30830#35748#24037#33402#30340#21697#21517#21015#34920
            Align = alClient
            Columns = <
              item
                Caption = #21697#21517
                Width = 160
              end
              item
                Caption = #24037#33402#20195#21495
                Width = 0
              end
              item
                Caption = #32433#25903
              end
              item
                Caption = 'CAD'
                Width = 0
              end>
            GridLines = True
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = lv_CurNOCheckArtColumnClick
            OnCustomDrawItem = lv_CurNOCheckArtCustomDrawItem
            OnKeyDown = KeyDownAControl
          end
        end
      end
    end
  end
  object cxspl_Only: TcxSplitter
    Left = 241
    Top = 86
    Width = 8
    Height = 412
    HotZoneClassName = 'TcxXPTaskBarStyle'
    Control = pnl_Only
  end
  object TPanel
    Left = 0
    Top = 83
    Width = 985
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 985
    Height = 83
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object lblRadio: TLabel
      Left = 816
      Top = 48
      Width = 6
      Height = 12
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object TStaticText
      Left = 156
      Top = 40
      Width = 58
      Height = 16
      Caption = #25104#21697#24133#23485':'
      TabOrder = 13
    end
    object TStaticText
      Left = 156
      Top = 64
      Width = 46
      Height = 16
      Caption = 'BR'#21547#37327':'
      TabOrder = 21
    end
    object TStaticText
      Left = 318
      Top = 15
      Width = 58
      Height = 16
      Caption = #22383#24067#23494#24230':'
      TabOrder = 5
    end
    object TStaticText
      Left = 318
      Top = 40
      Width = 58
      Height = 16
      Caption = #25104#21697#23494#24230':'
      TabOrder = 14
    end
    object edt_Density: TEdit
      Left = 370
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      BevelOuter = bvRaised
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object edt_GreyDensity: TEdit
      Left = 370
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
      TabOrder = 12
    end
    object txt_Only: TStaticText
      Left = 5
      Top = 15
      Width = 58
      Height = 16
      Caption = #21697#21517'(&G):'
      FocusControl = cxbe_GFKeyValue
      TabOrder = 3
    end
    object TStaticText
      Left = 156
      Top = 15
      Width = 58
      Height = 16
      Caption = #22383#24067#24133#23485':'
      TabOrder = 4
    end
    object TStaticText
      Left = 482
      Top = 39
      Width = 34
      Height = 16
      Caption = #35774#35745':'
      TabOrder = 10
    end
    object TStaticText
      Left = 482
      Top = 64
      Width = 34
      Height = 16
      Caption = #30830#35748':'
      TabOrder = 23
    end
    object edt_Customer: TEdit
      Left = 51
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 6
    end
    object edt_Grey_Width: TEdit
      Left = 209
      Top = 7
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object edt_BR: TEdit
      Left = 209
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 16
    end
    object edt_Designer: TEdit
      Left = 512
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object edt_Designer_Time: TEdit
      Left = 680
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      BevelEdges = [beLeft, beTop]
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
    end
    object edt_Check: TEdit
      Left = 512
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 18
    end
    object edt_Check_Time: TEdit
      Left = 680
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      BevelEdges = [beLeft, beTop]
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 19
    end
    object TStaticText
      Left = 621
      Top = 64
      Width = 58
      Height = 16
      Caption = #30830#35748#26102#38388':'
      TabOrder = 24
    end
    object TStaticText
      Left = 621
      Top = 39
      Width = 58
      Height = 16
      Caption = #35774#35745#26102#38388':'
      TabOrder = 11
    end
    object cxbe_GFKeyValue: TcxButtonEdit
      Left = 51
      Top = 7
      Width = 105
      Height = 20
      Properties.Buttons = <
        item
          Default = True
          Kind = bkGlyph
        end>
      Properties.CharCase = ecUpperCase
      Properties.OnButtonClick = cxbe_PropertiesButtonClick
      TabOrder = 0
      OnKeyDown = KeyDownAControl
    end
    object TStaticText
      Left = 5
      Top = 64
      Width = 34
      Height = 16
      Caption = #33639#20809':'
      TabOrder = 20
    end
    object edt_Anti_Fluorescence: TEdit
      Left = 51
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 15
    end
    object TStaticText
      Left = 318
      Top = 64
      Width = 34
      Height = 16
      Caption = #29256#26412':'
      TabOrder = 22
    end
    object edt_Version: TEdit
      Left = 370
      Top = 56
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 17
    end
    object TStaticText
      Left = 482
      Top = 15
      Width = 34
      Height = 16
      Caption = #31576#24133':'
      TabOrder = 25
    end
    object edt_ReedWidth: TEdit
      Left = 512
      Top = 8
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 26
    end
    object edt_Width: TEdit
      Left = 209
      Top = 32
      Width = 105
      Height = 20
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 27
    end
    object TStaticText
      Left = 621
      Top = 15
      Width = 46
      Height = 16
      Caption = #21697#21517'ID:'
      TabOrder = 28
    end
    object edtGFID: TEdit
      Left = 680
      Top = 8
      Width = 105
      Height = 20
      TabStop = False
      BevelEdges = [beLeft, beTop]
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 29
    end
    object TStaticText
      Left = 789
      Top = 15
      Width = 70
      Height = 16
      Caption = #29305#27530#32433#27604#20363':'
      TabOrder = 31
    end
    object edtSpecialYarnRate: TEdit
      Left = 856
      Top = 8
      Width = 105
      Height = 20
      TabStop = False
      BevelEdges = [beLeft, beTop]
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 30
    end
  end
  object TPanel
    Left = 0
    Top = 498
    Width = 985
    Height = 3
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
  end
  object TPanel
    Left = 0
    Top = 501
    Width = 985
    Height = 34
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 5
    object TPanel
      Left = 0
      Top = 0
      Width = 985
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        985
        34)
      object btn_Help: TSpeedButton
        Left = 8
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #24110#21161'(&H)'
        Enabled = False
        Flat = True
      end
      object btn_Exit: TSpeedButton
        Left = 909
        Top = 5
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btn_ExitClick
      end
      object btn_RefrshGFNOList: TSpeedButton
        Left = 553
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21047#26032'(F5)'
        Flat = True
        OnClick = btn_RefrshGFNOListClick
      end
      object btn_CheckArtData: TSpeedButton
        Left = 731
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #30830#35748'(&V)'
        Flat = True
        OnClick = btn_CheckArtDataClick
      end
      object btn_SaveArt: TSpeedButton
        Left = 820
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Flat = True
        OnClick = btn_SaveArtClick
      end
      object btn_ViewArtDtl: TSpeedButton
        Left = 642
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #26597#30475'(&W)'
        Flat = True
        OnClick = btn_ViewArtDtlClick
      end
    end
  end
  object PageControl1: TPageControl
    Left = 249
    Top = 86
    Width = 736
    Height = 412
    ActivePage = TabSheet1
    Align = alClient
    MultiLine = True
    Style = tsFlatButtons
    TabIndex = 0
    TabOrder = 6
    object TabSheet1: TTabSheet
      Caption = #26631#20934#24037#33402#20449#24687
      object pnl_Only1: TPanel
        Left = 0
        Top = 0
        Width = 728
        Height = 382
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object spl1: TSplitter
          Left = 185
          Top = 79
          Width = 3
          Height = 254
          Cursor = crHSplit
        end
        object grp_Only: TGroupBox
          Left = 0
          Top = 333
          Width = 728
          Height = 49
          Align = alBottom
          Caption = #24037#33402#22791#27880
          TabOrder = 4
          object mmo_Remark: TMemo
            Left = 2
            Top = 14
            Width = 724
            Height = 33
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
          Top = 79
          Width = 185
          Height = 254
          Align = alLeft
          BevelInner = bvLowered
          TabOrder = 2
          object lst_Operationlist: TListBox
            Left = 2
            Top = 18
            Width = 152
            Height = 234
            Style = lbOwnerDrawFixed
            Align = alClient
            BevelOuter = bvNone
            ItemHeight = 12
            TabOrder = 1
            OnClick = lst_OperationlistClick
            OnKeyDown = KeyDownAControl
          end
          object TPanel
            Left = 154
            Top = 18
            Width = 29
            Height = 234
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 2
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
              Top = 115
              Width = 24
              Height = 24
              Hint = #19979#31227'|'#23558#24403#21069#21152#24037#24037#24207#19979#31227#19968#27493
              Flat = True
              OnClick = btn_Operation
            end
            object btn_Del_Operation: TSpeedButton
              Left = 3
              Top = 38
              Width = 24
              Height = 24
              Hint = #21024#38500'|'#21024#38500#24403#21069#24037#24207
              Flat = True
              OnClick = btn_Operation
            end
            object btn_Add_Operation: TSpeedButton
              Left = 3
              Top = 6
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
            FocusControl = lst_Operationlist
            TabOrder = 0
          end
        end
        object TPanel
          Left = 0
          Top = 76
          Width = 728
          Height = 3
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
        end
        object TPanel
          Left = 188
          Top = 79
          Width = 540
          Height = 254
          Align = alClient
          BevelInner = bvLowered
          TabOrder = 3
          object pgc_Operation: TPageControl
            Left = 2
            Top = 2
            Width = 536
            Height = 250
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
                Top = 8
                Width = 321
                Height = 137
                Style = csSimple
                ItemHeight = 12
                TabOrder = 0
                OnKeyDown = KeyDownAControl
              end
            end
            object TTabSheet
              Caption = #24037#24207#21442#25968
              object Vle_Operation_Parlist: TValueListEditor
                Left = 0
                Top = 0
                Width = 453
                Height = 220
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
                  315)
              end
            end
            object TabSheet3: TTabSheet
              Caption = #24037#33402#39044#35272
              ImageIndex = 2
              object mmoArtView: TMemo
                Left = 0
                Top = 32
                Width = 528
                Height = 188
                Align = alClient
                Color = clBtnFace
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                ScrollBars = ssBoth
                TabOrder = 0
              end
              object rgFilter: TRadioGroup
                Left = 0
                Top = 0
                Width = 528
                Height = 32
                Align = alTop
                Caption = #36807#28388#31867#22411
                Columns = 3
                ItemIndex = 0
                Items.Strings = (
                  #26377#20540
                  #31354#20540
                  #25152#26377)
                TabOrder = 1
                OnClick = rgFilterClick
              end
            end
          end
        end
        object TPanel
          Left = 0
          Top = 0
          Width = 728
          Height = 76
          Align = alTop
          BevelInner = bvLowered
          TabOrder = 0
          object TStaticText
            Left = 362
            Top = 55
            Width = 58
            Height = 16
            Caption = #38376#24133'(&H):'
            FocusControl = edt_ProductWidth
            TabOrder = 13
          end
          object TStaticText
            Left = 191
            Top = 32
            Width = 58
            Height = 16
            Caption = #33457#22411'(&P):'
            FocusControl = cbb_FN_Art_NO1
            TabOrder = 9
          end
          object TStaticText
            Left = 191
            Top = 11
            Width = 58
            Height = 16
            Caption = #33639#20809'(&F):'
            FocusControl = cbb_FN_Art_NO1
            TabOrder = 4
          end
          object TStaticText
            Left = 10
            Top = 33
            Width = 70
            Height = 16
            Caption = #39068#33394#21495'(&O):'
            FocusControl = cbb_ColorCode
            TabOrder = 11
          end
          object TStaticText
            Left = 10
            Top = 11
            Width = 70
            Height = 16
            Caption = #24037#33402#21495'(&C):'
            FocusControl = cbb_FN_Art_NO1
            TabOrder = 3
          end
          object cbb_ColorCode: TComboBox
            Left = 66
            Top = 26
            Width = 117
            Height = 20
            Hint = #39068#33394#20195#21495
            Style = csDropDownList
            ItemHeight = 12
            TabOrder = 6
            OnChange = ChangeAEdit
            OnKeyDown = KeyDownAComboBox
          end
          object cbb_FN_Art_NO1: TComboBox
            Tag = 1
            Left = 66
            Top = 4
            Width = 117
            Height = 20
            Hint = #24037#33402#20195#21495'|'#21518#25972#29702#26631#20934#24037#33402#20195#21495
            Style = csDropDownList
            ItemHeight = 12
            TabOrder = 0
            OnChange = ChangeAEdit
            OnKeyDown = KeyDownAComboBox
          end
          object cbb_FN_Art_NO2: TComboBox
            Tag = 2
            Left = 238
            Top = 4
            Width = 117
            Height = 20
            Hint = #24037#33402#20195#21495
            Style = csDropDownList
            ItemHeight = 12
            TabOrder = 1
            OnChange = ChangeAEdit
            OnCloseUp = cbb_FN_Art_NO2CloseUp
            OnKeyDown = KeyDownAComboBox
          end
          object cbb_FN_Art_NO4: TComboBox
            Tag = 4
            Left = 238
            Top = 26
            Width = 117
            Height = 20
            Hint = #24037#33402#20195#21495'|'#33457#22411
            Style = csDropDownList
            ItemHeight = 12
            TabOrder = 7
            OnChange = ChangeAEdit
            OnKeyDown = KeyDownAComboBox
          end
          object TStaticText
            Left = 362
            Top = 11
            Width = 58
            Height = 16
            Caption = #32553#27700'(&K):'
            FocusControl = cbb_FN_Art_NO1
            TabOrder = 5
          end
          object cbb_Shrinkage: TComboBox
            Tag = 2
            Left = 410
            Top = 4
            Width = 117
            Height = 20
            BevelEdges = [beLeft, beTop]
            ItemHeight = 12
            TabOrder = 2
            OnChange = ChangeAEdit
            OnKeyDown = KeyDownAComboBox
          end
          object TStaticText
            Left = 362
            Top = 32
            Width = 58
            Height = 16
            Caption = #25163#24863'(&H):'
            FocusControl = edt_HandFeel
            TabOrder = 10
          end
          object edt_HandFeel: TEdit
            Left = 410
            Top = 26
            Width = 117
            Height = 20
            BevelEdges = [beLeft, beTop]
            TabOrder = 8
            OnChange = ChangeAEdit
            OnKeyDown = KeyDownAControl
          end
          object chk_Is_Active: TCheckBox
            Left = 11
            Top = 53
            Width = 324
            Height = 18
            Hint = #24037#33402#26159#21542#26377#25928'|'#22914#26524#24037#33402#26080#25928#23558#23548#33268#26410#25171#21345#30340#19981#19981#33021#32487#32493#19981#33021#25171#21345
            Caption = #24037#33402#26159#21542#26377#25928'(&E) ['#27880#24847#65306#26080#25928#24037#33402#22312#25171#21345#26102#23558#19981#21487#29992']'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 12
            OnClick = ChangeAEdit
          end
          object edt_ProductWidth: TEdit
            Left = 410
            Top = 49
            Width = 117
            Height = 20
            BevelEdges = [beLeft, beTop]
            TabOrder = 14
            OnChange = ChangeAEdit
            OnKeyDown = KeyDownAControl
          end
          object btnDeleteArtByHand: TBitBtn
            Left = 640
            Top = 24
            Width = 65
            Height = 25
            Caption = #21024#38500
            TabOrder = 15
            OnClick = btnDeleteArtByHandClick
          end
          object chkArtByHand: TCheckBox
            Left = 544
            Top = 24
            Width = 89
            Height = 25
            Caption = #25554#20837#21697#21517#24211
            TabOrder = 16
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #24037#33402#21453#39304#20449#24687
      ImageIndex = 1
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 543
        Height = 382
        Align = alClient
        TabOrder = 0
        object cxGridDBTVFeedback: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxGridDBTVFeedbackCustomDrawCell
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGridDBTVFeedback
        end
      end
      object Panel1: TPanel
        Left = 543
        Top = 0
        Width = 185
        Height = 382
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          185
          382)
        object sbFeedback: TSpeedButton
          Left = 16
          Top = 425
          Width = 153
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = #30452#25509#21453#39304'(&D)'
          Flat = True
          OnClick = sbFeedbackClick
        end
        object GroupBox1: TGroupBox
          Left = 0
          Top = 50
          Width = 185
          Height = 169
          Align = alTop
          TabOrder = 0
          object mmoPDA: TMemo
            Left = 2
            Top = 14
            Width = 181
            Height = 153
            Align = alClient
            Color = clBtnFace
            Enabled = False
            TabOrder = 0
          end
        end
        object GroupBox2: TGroupBox
          Left = 0
          Top = 220
          Width = 185
          Height = 109
          TabOrder = 1
          object mmoPDM: TMemo
            Left = 2
            Top = 14
            Width = 181
            Height = 93
            Align = alClient
            Color = clBtnFace
            Enabled = False
            TabOrder = 0
          end
        end
        object chbPDA: TCheckBox
          Left = 4
          Top = 50
          Width = 95
          Height = 12
          Caption = #21453#39304#32763#21333#35780#23457
          TabOrder = 2
          OnClick = chbPDAClick
        end
        object chbPDM: TCheckBox
          Left = 4
          Top = 218
          Width = 82
          Height = 12
          Caption = #21453#39304#25216#26415#37096
          TabOrder = 3
          OnClick = chbPDMClick
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 185
          Height = 50
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 4
          object TStaticText
            Left = 11
            Top = 9
            Width = 46
            Height = 16
            Caption = #21453#39304#20154':'
            TabOrder = 0
          end
          object TStaticText
            Left = 11
            Top = 31
            Width = 58
            Height = 16
            Caption = #21453#39304#26102#38388':'
            TabOrder = 1
          end
          object edt_Feedback: TEdit
            Left = 64
            Top = 2
            Width = 105
            Height = 20
            TabStop = False
            BevelEdges = [beLeft, beTop]
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object edt_Feedback_Time: TEdit
            Left = 64
            Top = 23
            Width = 105
            Height = 20
            TabStop = False
            BevelEdges = [beLeft, beTop]
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 3
          end
        end
      end
    end
  end
  object pm_CopyExistArt: TPopupMenu
    OnPopup = pm_CopyExistArtPopup
    Left = 88
    Top = 541
  end
  object dsFeedback: TDataSource
    DataSet = cdsFeedback
    Left = 360
    Top = 216
  end
  object cdsFeedback: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 288
  end
  object cdsRecipe: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 424
  end
  object cdsCheckRecipe: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 464
  end
  object cdsRadio: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 832
    Top = 48
  end
  object cdsArtbyHand: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 872
    Top = 72
  end
end

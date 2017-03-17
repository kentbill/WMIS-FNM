object CPBFormatForm: TCPBFormatForm
  Left = 59
  Top = 27
  Width = 1366
  Height = 599
  Caption = #22823#36135#22797#26495
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 45
    Width = 1358
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object TPanel
    Left = 191
    Top = 48
    Width = 1167
    Height = 484
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 1167
      Height = 213
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object gbChemicalList: TGroupBox
        Left = 0
        Top = 0
        Width = 307
        Height = 213
        Align = alLeft
        Caption = #21487#36873#21270#24037#26009'(&C)'
        TabOrder = 1
        Visible = False
        object PageControl1: TPageControl
          Left = 2
          Top = 14
          Width = 303
          Height = 197
          ActivePage = TabSheet1
          Align = alClient
          Style = tsFlatButtons
          TabIndex = 0
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = #26641
            object tvChemical: TTreeView
              Left = 0
              Top = 0
              Width = 295
              Height = 167
              Align = alClient
              HideSelection = False
              Indent = 19
              ReadOnly = True
              TabOrder = 0
              OnDblClick = btnAddClick
              OnKeyDown = tvChemicalKeyDown
            end
          end
          object TabSheet2: TTabSheet
            Caption = #21015#34920
            ImageIndex = 1
            DesignSize = (
              295
              167)
            object cbbChemicalName: TComboBox
              Left = 4
              Top = 0
              Width = 389
              Height = 150
              Style = csSimple
              Anchors = [akLeft, akTop, akRight, akBottom]
              ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
              ItemHeight = 0
              TabOrder = 0
              OnDblClick = cbbChemicalNameDblClick
            end
          end
        end
      end
      object GroupBox3: TGroupBox
        Left = 315
        Top = 0
        Width = 852
        Height = 213
        Align = alClient
        Caption = #37197#26041#20027#35201#20449#24687
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object vlePDParam: TValueListEditor
          Left = 441
          Top = 14
          Width = 409
          Height = 197
          Align = alClient
          Ctl3D = False
          DefaultRowHeight = 17
          ParentCtl3D = False
          TabOrder = 1
          TitleCaptions.Strings = (
            #21442#25968#21517
            #21442#25968#20540)
          OnGetPickList = vlePDParamGetPickList
          OnKeyPress = vleChemicallistKeyPress
          OnStringsChange = vlePDParamStringsChange
          ColWidths = (
            147
            258)
        end
        object Panel1: TPanel
          Left = 2
          Top = 14
          Width = 439
          Height = 197
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object Label2: TLabel
            Left = 9
            Top = 5
            Width = 54
            Height = 12
            Caption = #21407#37197#26041#21495':'
          end
          object Label3: TLabel
            Left = 9
            Top = 53
            Width = 54
            Height = 12
            Caption = #26469#26679#33457#22411':'
          end
          object Label4: TLabel
            Left = 9
            Top = 130
            Width = 30
            Height = 12
            Caption = #33394#32423':'
          end
          object Label6: TLabel
            Left = 209
            Top = 10
            Width = 30
            Height = 12
            Caption = #21697#21517':'
          end
          object Label7: TLabel
            Left = 9
            Top = 154
            Width = 54
            Height = 12
            Caption = #30721#38271'(cm):'
          end
          object Label8: TLabel
            Left = 209
            Top = 57
            Width = 42
            Height = 12
            Caption = 'FN'#33394#21495':'
          end
          object Label5: TLabel
            Left = 9
            Top = 28
            Width = 54
            Height = 12
            Caption = #26469#26679#21333#21495':'
          end
          object Label9: TLabel
            Left = 209
            Top = 34
            Width = 30
            Height = 12
            Caption = #33394#21517':'
          end
          object lblFNColorCode: TLabel
            Left = 210
            Top = 75
            Width = 192
            Height = 36
            Alignment = taCenter
            AutoSize = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -35
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label11: TLabel
            Left = 9
            Top = 81
            Width = 54
            Height = 12
            Caption = #26469#26679#27454#24335':'
          end
          object lbl1: TLabel
            Left = 9
            Top = 178
            Width = 54
            Height = 12
            Caption = #25972#29702#26041#24335':'
          end
          object lbl2: TLabel
            Left = 9
            Top = 106
            Width = 30
            Height = 12
            Caption = #20132#26399':'
          end
          object Label16: TLabel
            Left = 241
            Top = 21
            Width = 30
            Height = 12
            Caption = #20132#26399':'
            Visible = False
          end
          object Label15: TLabel
            Left = 249
            Top = 21
            Width = 30
            Height = 12
            Caption = #23458#25143':'
            Visible = False
          end
          object Label14: TLabel
            Left = 241
            Top = 18
            Width = 30
            Height = 12
            Caption = #32467#26500':'
            Visible = False
          end
          object edtRecipeNO: TEdit
            Left = 69
            Top = 1
            Width = 131
            Height = 21
            TabStop = False
            CharCase = ecUpperCase
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object edtPatternName: TEdit
            Left = 69
            Top = 49
            Width = 131
            Height = 20
            TabStop = False
            CharCase = ecUpperCase
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ReadOnly = True
            TabOrder = 1
          end
          object edtCPBGFNO: TEdit
            Left = 269
            Top = 1
            Width = 131
            Height = 21
            TabStop = False
            CharCase = ecUpperCase
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object edtQuantity: TEdit
            Left = 69
            Top = 146
            Width = 131
            Height = 20
            TabStop = False
            CharCase = ecUpperCase
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ReadOnly = True
            TabOrder = 3
          end
          object edtFNColorCode: TEdit
            Left = 269
            Top = 49
            Width = 131
            Height = 21
            TabStop = False
            CharCase = ecUpperCase
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object edtLBNO: TEdit
            Left = 69
            Top = 25
            Width = 131
            Height = 20
            TabStop = False
            CharCase = ecUpperCase
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ReadOnly = True
            TabOrder = 5
          end
          object edtFabColorName: TEdit
            Left = 269
            Top = 25
            Width = 131
            Height = 21
            TabStop = False
            CharCase = ecUpperCase
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object cbShade: TComboBox
            Left = 69
            Top = 122
            Width = 131
            Height = 20
            Style = csDropDownList
            CharCase = ecUpperCase
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ItemHeight = 12
            ParentColor = True
            TabOrder = 7
            TabStop = False
          end
          object plShowColor: TPanel
            Left = 209
            Top = 115
            Width = 193
            Height = 52
            Cursor = crArrow
            BevelInner = bvRaised
            BevelOuter = bvLowered
            BevelWidth = 2
            TabOrder = 8
          end
          object edtPatternID: TEdit
            Left = 235
            Top = 125
            Width = 131
            Height = 20
            TabStop = False
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            TabOrder = 9
            Visible = False
          end
          object edtStyleName: TEdit
            Left = 69
            Top = 73
            Width = 131
            Height = 21
            TabStop = False
            CharCase = ecUpperCase
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
          object edtFinishMethod: TEdit
            Left = 69
            Top = 169
            Width = 333
            Height = 20
            TabStop = False
            CharCase = ecUpperCase
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 11
          end
          object edtLaunchTime: TEdit
            Left = 69
            Top = 98
            Width = 131
            Height = 20
            TabStop = False
            CharCase = ecUpperCase
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
        end
      end
      object cxSplitter2: TcxSplitter
        Left = 307
        Top = 0
        Width = 8
        Height = 213
        HotZoneClassName = 'TcxXPTaskBarStyle'
        DragThreshold = 2
        Control = gbChemicalList
      end
    end
    object cxSplitter3: TcxSplitter
      Left = 0
      Top = 213
      Width = 1167
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salTop
      DragThreshold = 2
      Control = pnlTop
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 221
      Width = 349
      Height = 263
      Align = alLeft
      Caption = #26579#26009#32452#21512
      TabOrder = 2
      object TPanel
        Left = 2
        Top = 44
        Width = 34
        Height = 217
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object btnDown: TSpeedButton
          Left = 4
          Top = 102
          Width = 25
          Height = 25
          Hint = #21521#19979
          Flat = True
          ParentShowHint = False
          ShowHint = True
          OnClick = btnDownClick
        end
        object btnUp: TSpeedButton
          Left = 4
          Top = 56
          Width = 25
          Height = 23
          Hint = #21521#19978
          Flat = True
          ParentShowHint = False
          ShowHint = True
          OnClick = btnUpClick
        end
        object btnCalc: TSpeedButton
          Left = 4
          Top = 3
          Width = 25
          Height = 25
          Hint = #35745#31639
          Flat = True
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCalcClick
        end
        object btnDel: TSpeedButton
          Left = 4
          Top = 159
          Width = 25
          Height = 25
          Hint = #21024#38500
          Flat = True
          ParentShowHint = False
          ShowHint = True
          OnClick = btnDelClick
        end
      end
      object vleChemicallist: TValueListEditor
        Left = 36
        Top = 44
        Width = 292
        Height = 217
        Hint = #21491#38190#24555#25463#33756#21333#21487#24555#36895#22686#21152'CPB'#21161#21058#12290
        Align = alClient
        Ctl3D = False
        DefaultRowHeight = 17
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goThumbTracking]
        ParentCtl3D = False
        ParentShowHint = False
        PopupMenu = popMChemical
        ShowHint = True
        TabOrder = 1
        TitleCaptions.Strings = (
          #21270#24037#26009#21517
          #29992#37327'(g/l)')
        OnDrawCell = vleChemicallistDrawCell
        OnKeyPress = vleChemicallistKeyPress
        OnSelectCell = vleChemicallistSelectCell
        OnValidate = vleChemicallistValidate
        ColWidths = (
          136
          152)
      end
      object TPanel
        Left = 2
        Top = 14
        Width = 345
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object btnAdd: TSpeedButton
          Left = 280
          Top = 2
          Width = 48
          Height = 25
          Hint = #36873#20013
          Caption = #22686#21152
          Flat = True
          ParentShowHint = False
          ShowHint = True
          OnClick = btnAddClick
        end
        object cbViewChemical: TCheckBox
          Left = 197
          Top = 6
          Width = 84
          Height = 17
          Caption = #26174#31034#21270#24037#26009
          TabOrder = 0
          OnClick = cbViewChemicalClick
        end
        object pnlGroup: TPanel
          Left = 0
          Top = 0
          Width = 194
          Height = 30
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object btnGroup: TSpeedButton
            Left = 4
            Top = 4
            Width = 65
            Height = 21
            Caption = #26579#26009#32452#21512
            Flat = True
            OnClick = btnGroupClick
          end
          object cbChemicalGroup: TComboBox
            Left = 72
            Top = 3
            Width = 122
            Height = 20
            Style = csDropDownList
            CharCase = ecUpperCase
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ItemHeight = 12
            TabOrder = 0
            OnChange = cbChemicalGroupChange
          end
        end
      end
      object gbAddRatio: TGroupBox
        Left = 328
        Top = 44
        Width = 19
        Height = 217
        Align = alRight
        Caption = #21152#25104#12304'%'#12305
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Visible = False
        object btnAddRatio: TSpeedButton
          Left = 11
          Top = 87
          Width = 48
          Height = 48
          Hint = #35745#31639#21152#25104#27604#20363
          Caption = #21152#25104
          Flat = True
          Layout = blGlyphTop
          ParentShowHint = False
          ShowHint = True
          OnClick = btnAddRatioClick
        end
        object Label10: TLabel
          Left = 7
          Top = 33
          Width = 54
          Height = 12
          Caption = #27604#20363'[+/-]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #26032#23435#20307
          Font.Style = []
          ParentFont = False
        end
        object edtRatio: TEdit
          Left = 11
          Top = 58
          Width = 49
          Height = 21
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #26032#23435#20307
          Font.Style = []
          ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
          ParentFont = False
          TabOrder = 0
          Text = '10'
          OnKeyDown = edtRatioKeyDown
        end
      end
    end
    object pnlRight: TPanel
      Left = 349
      Top = 221
      Width = 818
      Height = 263
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlRight'
      TabOrder = 3
      object gbFNCard: TGroupBox
        Left = 2
        Top = 68
        Width = 451
        Height = 202
        TabOrder = 2
        object cbAll: TCheckBox
          Left = 9
          Top = 0
          Width = 137
          Height = 13
          Caption = #21345#21495#21015#34920'('#20840#36873'/'#21462#28040')'
          TabOrder = 0
          OnClick = cbAllClick
        end
        object lvFNCard: TListView
          Left = 2
          Top = 45
          Width = 447
          Height = 155
          Align = alClient
          Checkboxes = True
          Columns = <
            item
              Caption = #21345#21495
              Width = 87
            end
            item
              Caption = #25968#37327
              Width = 54
            end
            item
              Caption = #21697#21517
              Width = 120
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
          OnClick = lvFNCardClick
        end
        object Panel2: TPanel
          Left = 2
          Top = 14
          Width = 447
          Height = 31
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object Label1: TLabel
            Left = 4
            Top = 7
            Width = 54
            Height = 12
            Caption = #38468#21152#21697#21517':'
          end
          object btnAddGFNO: TSpeedButton
            Left = 193
            Top = 2
            Width = 75
            Height = 25
            Caption = #22686#21152
            Flat = True
            ParentShowHint = False
            ShowHint = True
            OnClick = btnAddGFNOClick
          end
          object lblMC: TLabel
            Left = 292
            Top = 7
            Width = 6
            Height = 12
          end
          object edtAddGFNO: TEdit
            Left = 59
            Top = 4
            Width = 121
            Height = 20
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            TabOrder = 0
          end
        end
      end
      object gbHistoryRecipe: TGroupBox
        Left = 692
        Top = 0
        Width = 126
        Height = 263
        Align = alRight
        Caption = #21382#21490#37197#26041#21333#21495
        TabOrder = 0
        Visible = False
        DesignSize = (
          126
          263)
        object btnPrint: TSpeedButton
          Left = 11
          Top = 226
          Width = 110
          Height = 28
          Anchors = [akTop, akRight, akBottom]
          Caption = #25171#21360'(&P)'
          Flat = True
          OnClick = btnPrintClick
        end
        object cbbHistoryRecipe: TComboBox
          Left = 9
          Top = 17
          Width = 112
          Height = 168
          Style = csSimple
          CharCase = ecUpperCase
          ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
          ItemHeight = 12
          TabOrder = 0
          OnClick = cbbHistoryRecipeClick
          Items.Strings = (
            '')
        end
      end
      object gbHistory: TGroupBox
        Left = 266
        Top = 129
        Width = 358
        Height = 129
        Caption = #21382#21490#37197#26041
        TabOrder = 1
        object cxGrid1: TcxGrid
          Left = 2
          Top = 44
          Width = 354
          Height = 83
          Align = alClient
          TabOrder = 0
          object cxGridTVCPBDtl: TcxGridDBTableView
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            NavigatorButtons.ConfirmDelete = False
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Appending = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsSelection.InvertSelect = False
            OptionsView.DataRowHeight = 18
            OptionsView.GroupByBox = False
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxGridTVCPBDtl
          end
        end
        object lvChemicalGroup: TListView
          Left = 2
          Top = 14
          Width = 354
          Height = 30
          Align = alTop
          Columns = <
            item
              Caption = ' '#32452#21512
              Width = 49
            end>
          ColumnClick = False
          Ctl3D = False
          ReadOnly = True
          RowSelect = True
          TabOrder = 1
          OnDblClick = lvChemicalGroupDblClick
        end
      end
    end
  end
  object pn1: TPanel
    Left = 0
    Top = 48
    Width = 183
    Height = 484
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 2
    object grp2: TGroupBox
      Left = 2
      Top = 89
      Width = 179
      Height = 393
      Align = alClient
      Caption = #20219#21153#21015#34920
      TabOrder = 1
      Visible = False
      object cxGrid2: TcxGrid
        Left = 2
        Top = 14
        Width = 175
        Height = 377
        Align = alClient
        TabOrder = 0
        object cxgdTVTask: TcxGridDBTableView
          OnDblClick = cxgdTVTaskDblClick
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxgdTVTaskCustomDrawCell
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxgdTVTask
        end
      end
    end
    object pn0: TPanel
      Left = 2
      Top = 2
      Width = 179
      Height = 87
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lbLBNO: TLabel
        Left = 5
        Top = 13
        Width = 30
        Height = 12
        Caption = #21697#21517';'
      end
      object btnQuery: TSpeedButton
        Left = 91
        Top = 30
        Width = 79
        Height = 24
        Caption = #26597#35810'(&Q)'
        Flat = True
        OnClick = btnQueryClick
      end
      object btnRefresh: TSpeedButton
        Left = 3
        Top = 30
        Width = 79
        Height = 24
        Caption = #21047#26032'(&R)'
        Flat = True
        Visible = False
        OnClick = btnRefreshClick
      end
      object Label12: TLabel
        Left = 5
        Top = 65
        Width = 30
        Height = 12
        Caption = #31867#22411':'
      end
      object edtGFNO: TEdit
        Left = 35
        Top = 4
        Width = 138
        Height = 20
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 0
        OnKeyDown = edtGFNOKeyDown
      end
      object cbbRecipeType: TComboBox
        Left = 35
        Top = 58
        Width = 138
        Height = 20
        Style = csDropDownList
        CharCase = ecUpperCase
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ItemHeight = 12
        ParentFont = False
        TabOrder = 1
      end
      object ComboBox1: TComboBox
        Left = 35
        Top = 88
        Width = 137
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ItemHeight = 12
        TabOrder = 2
      end
    end
  end
  object TPanel
    Left = 0
    Top = 532
    Width = 1358
    Height = 33
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 5
    object TPanel
      Left = 0
      Top = 0
      Width = 1358
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        1358
        33)
      object Label13: TLabel
        Left = 914
        Top = 15
        Width = 42
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #24320#21333#20154':'
      end
      object lbToner: TLabel
        Left = 1046
        Top = 16
        Width = 42
        Height = 12
        Anchors = [akRight, akBottom]
        BiDiMode = bdLeftToRight
        Caption = #35843#33394#24072':'
        ParentBiDiMode = False
      end
      object cbbToner: TComboBox
        Left = 958
        Top = 12
        Width = 80
        Height = 20
        Style = csDropDownList
        Anchors = [akRight, akBottom]
        CharCase = ecUpperCase
        DropDownCount = 10
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ItemHeight = 12
        ParentFont = False
        TabOrder = 5
      end
      object cbExport: TCheckBox
        Left = 774
        Top = 12
        Width = 129
        Height = 17
        Anchors = [akRight, akBottom]
        Caption = #20445#23384#26102#23548#21040#21560#26009#26426
        TabOrder = 3
        Visible = False
      end
      object pnlDelete: TPanel
        Left = 0
        Top = 0
        Width = 546
        Height = 33
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          546
          33)
        object btnDelete: TSpeedButton
          Left = 205
          Top = 5
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = #21024#38500'(&D)'
          Flat = True
          OnClick = btnDeleteClick
        end
        object lblDeleteNO: TLabel
          Left = 12
          Top = 13
          Width = 42
          Height = 12
          Anchors = [akRight, akBottom]
          Caption = #37197#26041#21495':'
        end
        object lbl3: TLabel
          Left = 334
          Top = 14
          Width = 54
          Height = 12
          Anchors = [akRight, akBottom]
          Caption = #26032#37197#26041#21495':'
        end
        object edtDeleteNO: TEdit
          Left = 64
          Top = 10
          Width = 131
          Height = 20
          Anchors = [akRight, akBottom]
          CharCase = ecUpperCase
          ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
          TabOrder = 0
        end
        object edtNewRecipe: TEdit
          Left = 452
          Top = 10
          Width = 131
          Height = 21
          Anchors = [akRight, akBottom]
          CharCase = ecUpperCase
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
      end
      object btnSave: TBitBtn
        Left = 1201
        Top = 6
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = btnSaveClick
      end
      object btnExit: TBitBtn
        Left = 1281
        Top = 6
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        TabOrder = 2
        OnClick = btnExitClick
      end
      object cbbOperator: TComboBox
        Left = 1092
        Top = 12
        Width = 80
        Height = 20
        Style = csDropDownList
        Anchors = [akRight, akBottom]
        CharCase = ecUpperCase
        DropDownCount = 10
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ItemHeight = 12
        ParentFont = False
        TabOrder = 4
      end
      object edtJQ: TEdit
        Left = 268
        Top = 12
        Width = 131
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        Visible = False
      end
      object edtKH: TEdit
        Left = 276
        Top = 12
        Width = 131
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
        Visible = False
      end
      object edtJG: TEdit
        Left = 268
        Top = 1
        Width = 131
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
        Visible = False
      end
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 183
    Top = 48
    Width = 8
    Height = 484
    HotZoneClassName = 'TcxXPTaskBarStyle'
    DragThreshold = 2
    Control = pn1
  end
  object pnlCaption: TPanel
    Left = 0
    Top = 0
    Width = 1358
    Height = 45
    Align = alTop
    BevelOuter = bvLowered
    Caption = '  Panel2'
    Color = clMedGray
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -32
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object dsTask: TDataSource
    DataSet = cdsTask
    Left = 64
    Top = 256
  end
  object cdsTask: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 224
  end
  object cdsCPBRecipeDtl: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 648
    Top = 104
  end
  object dsCPBRecipeDtl: TDataSource
    DataSet = cdsCPBRecipeDtl
    Left = 640
    Top = 136
  end
  object popMChemical: TPopupMenu
    Left = 304
    Top = 344
    object popMChemicalN1: TMenuItem
      Caption = #22686#21152#27700#29627#29827#65288'37-40Be)'
      OnClick = popMChemicalN1Click
    end
    object popMChemicalN2: TMenuItem
      Caption = #22686#21152'NaOH 50%'
      OnClick = popMChemicalN2Click
    end
  end
  object cdsHistoryRecipe: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 672
    Top = 288
  end
end

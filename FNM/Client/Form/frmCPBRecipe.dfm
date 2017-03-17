inherited CPBRecipeForm: TCPBRecipeForm
  Left = 82
  Top = 40
  Width = 1366
  Height = 636
  Caption = #25171#26679#37197#26041#24405#20837
  OldCreateOrder = True
  Position = poDefault
  ShowHint = True
  WindowState = wsMaximized
  OnKeyPress = nil
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 0
    Width = 1358
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object TPanel
    Left = 177
    Top = 3
    Width = 1181
    Height = 569
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 1181
      Height = 193
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object gbChemicalList: TGroupBox
        Left = 205
        Top = 0
        Width = 305
        Height = 193
        Align = alLeft
        Caption = #21487#36873#21270#24037#26009'(&C)'
        TabOrder = 1
        Visible = False
        object PageControl1: TPageControl
          Left = 2
          Top = 14
          Width = 301
          Height = 177
          ActivePage = TabSheet2
          Align = alClient
          Style = tsFlatButtons
          TabIndex = 1
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = #26641
            object tvChemical: TTreeView
              Left = 0
              Top = 0
              Width = 293
              Height = 147
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
              293
              147)
            object cbbChemicalName: TComboBox
              Left = 4
              Top = 0
              Width = 287
              Height = 142
              Style = csSimple
              Anchors = [akLeft, akTop, akRight, akBottom]
              ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
              ItemHeight = 12
              TabOrder = 0
              OnDblClick = cbbChemicalNameDblClick
            end
          end
        end
      end
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 205
        Height = 193
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object TPanel
          Left = 0
          Top = 0
          Width = 205
          Height = 193
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object lbLBNO: TLabel
            Left = 6
            Top = 22
            Width = 54
            Height = 12
            Caption = #26469#26679#21333#21495';'
          end
          object Label1: TLabel
            Left = 6
            Top = 44
            Width = 42
            Height = 12
            Caption = 'FN'#33394#21495':'
          end
          object btnQuery: TSpeedButton
            Left = 101
            Top = 65
            Width = 75
            Height = 25
            Caption = #26597#35810'(&Q)'
            Flat = True
            OnClick = btnQueryClick
          end
          object btnRefresh: TSpeedButton
            Left = 7
            Top = 65
            Width = 75
            Height = 25
            Caption = #21047#26032'(&R)'
            Flat = True
            OnClick = btnRefreshClick
          end
          object Label7: TLabel
            Left = 6
            Top = 113
            Width = 30
            Height = 12
            Caption = #21697#21517':'
          end
          object Label12: TLabel
            Left = 6
            Top = 160
            Width = 54
            Height = 12
            Caption = #25171#26679#31867#22411':'
          end
          object Label5: TLabel
            Left = 7
            Top = 134
            Width = 54
            Height = 12
            Caption = #25171#26495#35268#26684':'
          end
          object edtLBNO: TEdit
            Left = 68
            Top = 14
            Width = 130
            Height = 20
            CharCase = ecUpperCase
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            TabOrder = 0
            OnKeyPress = edtLBNOKeyPress
          end
          object edtFabColorCode: TEdit
            Left = 68
            Top = 36
            Width = 130
            Height = 20
            CharCase = ecUpperCase
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            TabOrder = 1
            OnChange = edtFabColorCodeChange
            OnKeyDown = edtFabColorCodeKeyDown
          end
          object cbGFNO: TComboBox
            Left = 68
            Top = 106
            Width = 130
            Height = 20
            Hint = #36755#20837#22383#24067#21697#21517#21518#65292#19979#25289#36873#25321#25104#21697#21697#21517#12290
            AutoComplete = False
            ImeMode = imClose
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ItemHeight = 12
            TabOrder = 2
            OnChange = cbGFNOChange
            OnDropDown = cbGFNODropDown
            OnKeyDown = cbGFNOKeyDown
          end
          object cbbRecipeType: TComboBox
            Left = 68
            Top = 156
            Width = 130
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
            TabOrder = 3
            OnKeyDown = cbbRecipeTypeKeyDown
          end
          object edtConstruction: TEdit
            Left = 69
            Top = 131
            Width = 127
            Height = 20
            TabStop = False
            CharCase = ecUpperCase
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
        end
      end
      object gbRight: TGroupBox
        Left = 518
        Top = 0
        Width = 663
        Height = 193
        Align = alClient
        Caption = #37197#26041#20027#35201#20449#24687
        TabOrder = 3
        object Panel1: TPanel
          Left = 2
          Top = 14
          Width = 474
          Height = 177
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object Label2: TLabel
            Left = 15
            Top = 6
            Width = 42
            Height = 12
            Caption = #37197#26041#21495':'
          end
          object Label6: TLabel
            Left = 8
            Top = 5
            Width = 54
            Height = 12
            Caption = #30721#38271'(cm):'
            Visible = False
          end
          object Label8: TLabel
            Left = 193
            Top = 30
            Width = 42
            Height = 12
            Caption = 'FN'#33394#21495':'
            Visible = False
          end
          object Label11: TLabel
            Left = 8
            Top = 30
            Width = 30
            Height = 12
            Caption = #23458#25143':'
            Visible = False
          end
          object lblFNColorCode: TLabel
            Left = 296
            Top = 45
            Width = 177
            Height = 34
            Alignment = taCenter
            AutoSize = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label3: TLabel
            Left = 7
            Top = 51
            Width = 54
            Height = 12
            Caption = #26469#26679#21333#21495':'
            Visible = False
          end
          object Label9: TLabel
            Left = 8
            Top = 74
            Width = 54
            Height = 12
            Caption = #26469#26679#33457#22411':'
            Visible = False
          end
          object Label10: TLabel
            Left = 7
            Top = 96
            Width = 54
            Height = 12
            Caption = #26469#26679#27454#24335':'
            Visible = False
          end
          object lbl1: TLabel
            Left = 7
            Top = 30
            Width = 54
            Height = 12
            Caption = #25972#29702#26041#24335':'
          end
          object lbl2: TLabel
            Left = 7
            Top = 119
            Width = 30
            Height = 12
            Caption = #20132#26399':'
            Visible = False
          end
          object lbl3: TLabel
            Left = 7
            Top = 143
            Width = 54
            Height = 12
            Caption = #26469#26679#31867#22411':'
            Visible = False
          end
          object Label4: TLabel
            Left = 9
            Top = 50
            Width = 42
            Height = 12
            Caption = #25171#26679#21592':'
          end
          object lbl4: TLabel
            Left = 9
            Top = 71
            Width = 42
            Height = 12
            Caption = #35843#33394#24072':'
          end
          object edtRecipeNO: TEdit
            Left = 63
            Top = 0
            Width = 117
            Height = 20
            TabStop = False
            CharCase = ecUpperCase
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object edtQuantity: TEdit
            Left = 63
            Top = 1
            Width = 114
            Height = 20
            TabStop = False
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            TabOrder = 10
            Visible = False
          end
          object edtFNColorCode: TEdit
            Left = 247
            Top = 22
            Width = 121
            Height = 20
            TabStop = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            TabOrder = 2
            Visible = False
          end
          object edtCustomer: TEdit
            Left = 63
            Top = 22
            Width = 121
            Height = 20
            TabStop = False
            CharCase = ecUpperCase
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ReadOnly = True
            TabOrder = 1
            Visible = False
          end
          object plShowColor: TPanel
            Left = 294
            Top = 78
            Width = 179
            Height = 99
            Cursor = crArrow
            BevelInner = bvRaised
            BevelOuter = bvLowered
            BevelWidth = 2
            TabOrder = 5
            object edtFabColorName: TEdit
              Left = 19
              Top = 8
              Width = 121
              Height = 20
              TabStop = False
              CharCase = ecUpperCase
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = [fsBold]
              ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
              ParentColor = True
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              Visible = False
            end
            object edtPatternID: TEdit
              Left = 23
              Top = 40
              Width = 121
              Height = 20
              TabStop = False
              Ctl3D = True
              ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
              ParentColor = True
              ParentCtl3D = False
              TabOrder = 1
              Visible = False
            end
          end
          object edtLB_NO: TEdit
            Left = 63
            Top = 44
            Width = 121
            Height = 20
            TabStop = False
            CharCase = ecUpperCase
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ReadOnly = True
            TabOrder = 3
            Visible = False
          end
          object edtPatternName: TEdit
            Left = 63
            Top = 66
            Width = 121
            Height = 20
            TabStop = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            TabOrder = 4
            Visible = False
          end
          object edtStyleName: TEdit
            Left = 63
            Top = 88
            Width = 121
            Height = 20
            TabStop = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
            Visible = False
          end
          object edtFinishMethod: TEdit
            Left = 63
            Top = 22
            Width = 394
            Height = 20
            TabStop = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            TabOrder = 7
          end
          object edtLaunchTime: TEdit
            Left = 63
            Top = 111
            Width = 121
            Height = 20
            TabStop = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            Visible = False
          end
          object edtPPOType: TEdit
            Left = 63
            Top = 135
            Width = 121
            Height = 20
            TabStop = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 9
            Visible = False
          end
          object cbbOperator: TComboBox
            Left = 63
            Top = 44
            Width = 122
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
            TabOrder = 11
            OnChange = cbbOperatorChange
            OnKeyDown = cbbOperatorKeyDown
          end
          object cbbToner: TComboBox
            Left = 63
            Top = 66
            Width = 122
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
            TabOrder = 12
            OnKeyDown = cbbTonerKeyDown
          end
          object edtOperator: TEdit
            Left = 189
            Top = 44
            Width = 100
            Height = 20
            TabOrder = 13
          end
        end
        object Panel2: TPanel
          Left = 476
          Top = 14
          Width = 185
          Height = 177
          Align = alClient
          Caption = 'Panel2'
          TabOrder = 1
          object vlePDParam: TValueListEditor
            Left = 1
            Top = 1
            Width = 183
            Height = 175
            TabStop = False
            Align = alClient
            Ctl3D = False
            DefaultRowHeight = 17
            ParentCtl3D = False
            TabOrder = 0
            TitleCaptions.Strings = (
              #21442#25968#21517
              #21442#25968#20540)
            OnGetPickList = vlePDParamGetPickList
            OnKeyPress = vleChemicallistKeyPress
            OnStringsChange = vlePDParamStringsChange
            ColWidths = (
              110
              69)
          end
        end
      end
      object cxSplitter4: TcxSplitter
        Left = 510
        Top = 0
        Width = 8
        Height = 193
        HotZoneClassName = 'TcxXPTaskBarStyle'
        DragThreshold = 2
        Control = gbChemicalList
      end
    end
    object cxSplitter3: TcxSplitter
      Left = 0
      Top = 193
      Width = 1181
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salTop
      DragThreshold = 2
      Control = pnlTop
    end
    object gbLeft: TGroupBox
      Left = 0
      Top = 201
      Width = 385
      Height = 368
      Align = alLeft
      Caption = #26579#26009#32452#21512
      TabOrder = 2
      object vleChemicallist: TValueListEditor
        Left = 33
        Top = 38
        Width = 350
        Height = 328
        Hint = #21491#38190#24555#25463#33756#21333#21487#24555#36895#22686#21152'CPB'#21161#21058#12290
        Align = alClient
        Ctl3D = False
        DefaultRowHeight = 17
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goThumbTracking]
        ParentCtl3D = False
        PopupMenu = popMChemical
        Strings.Strings = (
          '=')
        TabOrder = 2
        TitleCaptions.Strings = (
          #21270#24037#26009#21517
          #29992#37327'(g/l)')
        OnDrawCell = vleChemicallistDrawCell
        OnKeyPress = vleChemicallistKeyPress
        OnSelectCell = vleChemicallistSelectCell
        OnValidate = vleChemicallistValidate
        ColWidths = (
          173
          173)
      end
      object TPanel
        Left = 2
        Top = 38
        Width = 31
        Height = 328
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object btnDown: TSpeedButton
          Left = 4
          Top = 122
          Width = 23
          Height = 23
          Hint = #21521#19979
          Flat = True
          OnClick = btnDownClick
        end
        object btnUp: TSpeedButton
          Left = 4
          Top = 90
          Width = 23
          Height = 23
          Hint = #21521#19978
          Flat = True
          OnClick = btnUpClick
        end
        object btnCalc: TSpeedButton
          Left = 5
          Top = 31
          Width = 23
          Height = 23
          Hint = #35745#31639
          Flat = True
          OnClick = btnCalcClick
        end
        object btnDel: TSpeedButton
          Left = 6
          Top = 2
          Width = 23
          Height = 23
          Hint = #21024#38500
          Flat = True
          OnClick = btnDelClick
        end
      end
      object TPanel
        Left = 2
        Top = 14
        Width = 381
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object btnAdd: TSpeedButton
          Left = 286
          Top = 0
          Width = 67
          Height = 23
          Hint = #36873#20013
          Caption = #22686#21152
          Flat = True
          OnClick = btnAddClick
        end
        object btnGroup: TSpeedButton
          Left = 102
          Top = 24
          Width = 60
          Height = 23
          Caption = #32452#21512'(&C)'
          Flat = True
          OnClick = btnGroupClick
        end
        object cbChemicalGroup: TComboBox
          Left = 66
          Top = 3
          Width = 122
          Height = 20
          Hint = #26579#26009#32452#21512
          Style = csDropDownList
          CharCase = ecUpperCase
          Font.Charset = GB2312_CHARSET
          Font.Color = clMenuHighlight
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
          ItemHeight = 12
          ParentFont = False
          TabOrder = 0
          OnChange = cbChemicalGroupChange
        end
        object cbViewChemical: TCheckBox
          Left = 197
          Top = 6
          Width = 84
          Height = 17
          Caption = #26174#31034#21270#24037#26009
          TabOrder = 1
          OnClick = cbViewChemicalClick
        end
      end
    end
    object gbClient: TGroupBox
      Left = 385
      Top = 201
      Width = 796
      Height = 368
      Align = alClient
      Caption = #21382#21490#37197#26041
      TabOrder = 3
      object cxGrid1: TcxGrid
        Left = 2
        Top = 37
        Width = 792
        Height = 329
        Align = alClient
        TabOrder = 1
        object cxGridTVCPBDtl: TcxGridDBTableView
          OnDblClick = cxGridTVCPBDtlDblClick
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCellClick = cxGridTVCPBDtlCellClick
          OnCustomDrawCell = cxGridTVCPBDtlCustomDrawCell
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Appending = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsSelection.InvertSelect = False
          OptionsView.DataRowHeight = 18
          OptionsView.GroupByBox = False
          OptionsView.IndicatorWidth = 21
          OnCustomDrawIndicatorCell = cxGridTVCPBDtlCustomDrawIndicatorCell
          object cxGridTVCPBDtlDBColumn1: TcxGridDBColumn
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridTVCPBDtl
        end
      end
      object lvChemicalGroup: TListView
        Left = 2
        Top = 14
        Width = 792
        Height = 23
        Align = alTop
        Columns = <
          item
            Caption = ' '#32452#21512
            Width = 45
          end>
        ColumnClick = False
        Ctl3D = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        OnDblClick = lvChemicalGroupDblClick
      end
    end
  end
  object pn1: TPanel
    Left = 0
    Top = 3
    Width = 169
    Height = 569
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 1
    object grp2: TGroupBox
      Left = 2
      Top = 2
      Width = 165
      Height = 565
      Align = alClient
      Caption = #20219#21153#21015#34920
      TabOrder = 0
      object cxGrid2: TcxGrid
        Left = 2
        Top = 14
        Width = 161
        Height = 549
        Align = alClient
        TabOrder = 0
        object cxgdTVTask: TcxGridDBTableView
          OnDblClick = cxgdTVTaskDblClick
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NavigatorButtons.ConfirmDelete = False
          OnCustomDrawCell = cxgdTVTaskCustomDrawCell
          OptionsSelection.CellSelect = False
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxgdTVTask
        end
      end
    end
  end
  object TPanel
    Left = 0
    Top = 572
    Width = 1358
    Height = 30
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 4
    object TPanel
      Left = 0
      Top = 0
      Width = 1358
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        1358
        30)
      object cbExport: TCheckBox
        Left = 1056
        Top = 8
        Width = 129
        Height = 17
        Anchors = [akRight, akBottom]
        Caption = #20445#23384#26102#23548#21040#21560#26009#26426
        TabOrder = 2
        Visible = False
      end
      object btnSave: TBitBtn
        Left = 1199
        Top = 3
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = btnSaveClick
      end
      object btnExit: TBitBtn
        Left = 1280
        Top = 3
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        TabOrder = 1
        OnClick = btnExitClick
      end
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 169
    Top = 3
    Width = 8
    Height = 569
    HotZoneClassName = 'TcxXPTaskBarStyle'
    DragThreshold = 2
    Control = pn1
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
    Left = 424
    Top = 432
  end
  object dsCPBRecipeDtl: TDataSource
    DataSet = cdsCPBRecipeDtl
    Left = 339
    Top = 503
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
end

inherited CPBFormatExForm: TCPBFormatExForm
  Left = 190
  Top = 120
  Width = 1032
  Height = 748
  Caption = 'CPBFormatExForm'
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object TPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object TPanel
    Left = 177
    Top = 3
    Width = 847
    Height = 688
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 847
      Height = 346
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object cxSplitter2: TcxSplitter
        Left = 389
        Top = 0
        Width = 8
        Height = 346
        HotZoneClassName = 'TcxXPTaskBarStyle'
        AlignSplitter = salRight
        DragThreshold = 2
        Control = GroupBox3
      end
      object GroupBox3: TGroupBox
        Left = 397
        Top = 0
        Width = 450
        Height = 346
        Align = alRight
        Caption = #37197#26041#20027#35201#20449#24687
        TabOrder = 1
        object vlePDParam: TValueListEditor
          Left = 197
          Top = 14
          Width = 251
          Height = 330
          Align = alClient
          Ctl3D = False
          DefaultRowHeight = 17
          ParentCtl3D = False
          TabOrder = 0
          TitleCaptions.Strings = (
            #21442#25968#21517
            #21442#25968#20540)
          ColWidths = (
            165
            82)
        end
        object Panel1: TPanel
          Left = 2
          Top = 14
          Width = 195
          Height = 330
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object Label2: TLabel
            Left = 8
            Top = 9
            Width = 54
            Height = 12
            Caption = #21407#37197#26041#21495':'
          end
          object Label3: TLabel
            Left = 8
            Top = 53
            Width = 54
            Height = 12
            Caption = #26469#26679#33457#22411':'
          end
          object Label4: TLabel
            Left = 8
            Top = 119
            Width = 30
            Height = 12
            Caption = #33394#32423':'
          end
          object Label6: TLabel
            Left = 8
            Top = 141
            Width = 30
            Height = 12
            Caption = #21697#21517':'
          end
          object Label7: TLabel
            Left = 8
            Top = 163
            Width = 54
            Height = 12
            Caption = #30721#38271'(cm):'
          end
          object Label8: TLabel
            Left = 8
            Top = 185
            Width = 42
            Height = 12
            Caption = 'FN'#33394#21495':'
          end
          object Label5: TLabel
            Left = 8
            Top = 31
            Width = 54
            Height = 12
            Caption = #26469#26679#21333#21495':'
          end
          object Label9: TLabel
            Left = 8
            Top = 97
            Width = 30
            Height = 12
            Caption = #33394#21517':'
          end
          object lblFNColorCode: TLabel
            Left = 9
            Top = 201
            Width = 177
            Height = 33
            Alignment = taCenter
            AutoSize = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label11: TLabel
            Left = 8
            Top = 75
            Width = 54
            Height = 12
            Caption = #26469#26679#27454#24335':'
          end
          object edtRecipeNO: TEdit
            Left = 64
            Top = 1
            Width = 121
            Height = 20
            CharCase = ecUpperCase
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object edtPatternName: TEdit
            Left = 64
            Top = 45
            Width = 121
            Height = 20
            ParentColor = True
            TabOrder = 1
          end
          object edtCPBGFNO: TEdit
            Left = 64
            Top = 133
            Width = 121
            Height = 20
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object edtQuantity: TEdit
            Left = 64
            Top = 155
            Width = 121
            Height = 20
            ParentColor = True
            ReadOnly = True
            TabOrder = 3
          end
          object edtFNColorCode: TEdit
            Left = 64
            Top = 177
            Width = 121
            Height = 20
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object edtLBNO: TEdit
            Left = 64
            Top = 23
            Width = 121
            Height = 20
            CharCase = ecUpperCase
            ParentColor = True
            ReadOnly = True
            TabOrder = 5
          end
          object edtFabColorName: TEdit
            Left = 64
            Top = 89
            Width = 121
            Height = 20
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 6
          end
          object cbShade: TComboBox
            Left = 64
            Top = 111
            Width = 121
            Height = 20
            Style = csDropDownList
            ItemHeight = 12
            ParentColor = True
            TabOrder = 7
          end
          object plShowColor: TPanel
            Left = 8
            Top = 238
            Width = 178
            Height = 89
            Cursor = crArrow
            BevelInner = bvRaised
            BevelOuter = bvLowered
            BevelWidth = 2
            TabOrder = 8
          end
          object edtPatternID: TEdit
            Left = 32
            Top = 247
            Width = 121
            Height = 20
            ParentColor = True
            TabOrder = 9
            Visible = False
          end
          object edtStyleName: TEdit
            Left = 64
            Top = 67
            Width = 121
            Height = 20
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 10
          end
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 389
        Height = 346
        Align = alClient
        Caption = #21487#36873#21270#24037#26009'(&C)'
        TabOrder = 2
        object TPanel
          Left = 2
          Top = 319
          Width = 385
          Height = 25
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object btnAdd: TSpeedButton
            Left = 36
            Top = 0
            Width = 23
            Height = 22
            Hint = #36873#20013
            Flat = True
            ParentShowHint = False
            ShowHint = True
            OnClick = btnAddClick
          end
          object btnDel: TSpeedButton
            Left = 84
            Top = -1
            Width = 23
            Height = 23
            Hint = #21024#38500
            Flat = True
            ParentShowHint = False
            ShowHint = True
            OnClick = btnDelClick
          end
          object Label10: TLabel
            Left = 140
            Top = 5
            Width = 54
            Height = 12
            Caption = #26579#26009#32452#21512':'
          end
          object cbChemicalGroup: TComboBox
            Left = 194
            Top = 1
            Width = 170
            Height = 20
            Style = csDropDownList
            CharCase = ecUpperCase
            ItemHeight = 12
            TabOrder = 0
            OnChange = cbChemicalGroupChange
          end
        end
        object PageControl1: TPageControl
          Left = 2
          Top = 14
          Width = 385
          Height = 305
          ActivePage = TabSheet1
          Align = alClient
          Style = tsFlatButtons
          TabIndex = 0
          TabOrder = 1
          object TabSheet1: TTabSheet
            Caption = #26641
            object tvChemical: TTreeView
              Left = 0
              Top = 0
              Width = 377
              Height = 275
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
              377
              275)
            object cbbChemicalName: TComboBox
              Left = 4
              Top = 0
              Width = 386
              Height = 262
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
    end
    object cxSplitter3: TcxSplitter
      Left = 0
      Top = 346
      Width = 847
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salTop
      DragThreshold = 2
      Control = pnlTop
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 354
      Width = 389
      Height = 334
      Align = alClient
      Caption = #26579#26009#32452#21512
      TabOrder = 2
      object vleChemicallist: TValueListEditor
        Left = 33
        Top = 14
        Width = 354
        Height = 318
        Align = alClient
        Ctl3D = False
        DefaultRowHeight = 17
        ParentCtl3D = False
        TabOrder = 0
        TitleCaptions.Strings = (
          #21270#24037#26009#21517
          #29992#37327'(g/l)')
        OnValidate = vleChemicallistValidate
        ColWidths = (
          247
          103)
      end
      object TPanel
        Left = 2
        Top = 14
        Width = 31
        Height = 318
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object btnDown: TSpeedButton
          Left = 4
          Top = 104
          Width = 23
          Height = 23
          Hint = #21521#19979
          Flat = True
          ParentShowHint = False
          ShowHint = True
          OnClick = btnDownClick
        end
        object btnUp: TSpeedButton
          Left = 4
          Top = 50
          Width = 23
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
          Width = 23
          Height = 23
          Hint = #35745#31639
          Flat = True
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCalcClick
        end
      end
    end
    object cxSplitter4: TcxSplitter
      Left = 389
      Top = 354
      Width = 8
      Height = 334
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salRight
      DragThreshold = 2
      Control = pnlRight
    end
    object pnlRight: TPanel
      Left = 397
      Top = 354
      Width = 450
      Height = 334
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlRight'
      TabOrder = 4
      object gbHistory: TGroupBox
        Left = 24
        Top = 16
        Width = 330
        Height = 119
        Caption = #21382#21490#37197#26041
        TabOrder = 0
        object cxGrid1: TcxGrid
          Left = 50
          Top = 14
          Width = 278
          Height = 103
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
          Width = 48
          Height = 103
          Align = alLeft
          Columns = <
            item
              Caption = ' '#32452#21512
              Width = 45
            end>
          ColumnClick = False
          Ctl3D = False
          ReadOnly = True
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
          Visible = False
          OnDblClick = lvChemicalGroupDblClick
        end
      end
      object gbFNCard: TGroupBox
        Left = 0
        Top = 152
        Width = 410
        Height = 136
        TabOrder = 1
        object cbAll: TCheckBox
          Left = 8
          Top = 0
          Width = 127
          Height = 12
          Caption = #21345#21495#21015#34920'('#20840#36873'/'#21462#28040')'
          TabOrder = 0
          OnClick = cbAllClick
        end
        object lvFNCard: TListView
          Left = 2
          Top = 14
          Width = 406
          Height = 120
          Align = alClient
          Checkboxes = True
          Columns = <
            item
              Caption = #21345#21495
              Width = 80
            end
            item
              Caption = #25968#37327
            end
            item
              Caption = #19997#20809#30333#24230
              Width = 60
            end
            item
              Caption = #19968#20998#38047#27611#25928
              Width = 80
            end
            item
              Caption = #21697#21517
              Width = 110
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
        end
      end
      object gbHistoryRecipe: TGroupBox
        Left = 350
        Top = 0
        Width = 100
        Height = 334
        Align = alRight
        Caption = #21382#21490#37197#26041#21333#21495
        TabOrder = 2
        DesignSize = (
          100
          334)
        object btnPrint: TSpeedButton
          Left = 4
          Top = 308
          Width = 91
          Height = 22
          Anchors = [akTop, akRight, akBottom]
          Caption = #25171#21360'(&P)'
          Flat = True
          OnClick = btnPrintClick
        end
        object cbbHistoryRecipe: TComboBox
          Left = 8
          Top = 16
          Width = 86
          Height = 273
          Style = csSimple
          CharCase = ecUpperCase
          ItemHeight = 12
          TabOrder = 0
        end
      end
    end
  end
  object pn1: TPanel
    Left = 0
    Top = 3
    Width = 169
    Height = 688
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 2
    object grp2: TGroupBox
      Left = 2
      Top = 54
      Width = 165
      Height = 632
      Align = alClient
      Caption = #21697#21517#21015#34920
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        165
        632)
      object btnRefresh: TSpeedButton
        Left = 9
        Top = 12
        Width = 152
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        Caption = #21047#26032'(&R)'
        Flat = True
        OnClick = btnRefreshClick
      end
      object lvGFNO: TListView
        Left = 2
        Top = 40
        Width = 161
        Height = 590
        Checkboxes = True
        Columns = <
          item
            Caption = #21697#21517
            Width = 150
          end
          item
            Caption = #33394#21517
            Width = 0
          end
          item
            Caption = #32452#32455#32467#26500
            Width = 0
          end
          item
            Caption = 'RGB'
            Width = 0
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TPanel
      Left = 2
      Top = 2
      Width = 165
      Height = 52
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lb0: TLabel
        Left = 3
        Top = 12
        Width = 30
        Height = 12
        Caption = #33394#21495':'
      end
      object btnQuery: TSpeedButton
        Left = 8
        Top = 28
        Width = 149
        Height = 22
        Caption = #26597#35810'(&Q)'
        Flat = True
        OnClick = btnQueryClick
      end
      object edtFabColorCode: TEdit
        Left = 36
        Top = 4
        Width = 124
        Height = 20
        CharCase = ecUpperCase
        TabOrder = 0
        OnKeyDown = edtFabColorCodeKeyDown
      end
    end
  end
  object TPanel
    Left = 0
    Top = 691
    Width = 1024
    Height = 30
    Align = alBottom
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 3
    object TPanel
      Left = 0
      Top = 0
      Width = 1024
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        1024
        30)
      object btnSave: TSpeedButton
        Left = 863
        Top = 3
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #20445#23384'(&S)'
        Enabled = False
        Flat = True
        OnClick = btnSaveClick
      end
      object btnExit: TSpeedButton
        Left = 944
        Top = 3
        Width = 75
        Height = 25
        Hint = #36864#20986'|'#20851#38381#24403#21069#27963#21160#31383#20307
        Anchors = [akRight, akBottom]
        Caption = #36864#20986'(&X)'
        Flat = True
        OnClick = btnExitClick
      end
      object Label1: TLabel
        Left = 671
        Top = 12
        Width = 54
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #26032#37197#26041#21495':'
      end
      object btnDelete: TSpeedButton
        Left = 527
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21024#38500'(&D)'
        Flat = True
        OnClick = btnDeleteClick
      end
      object lblDeleteNO: TLabel
        Left = 346
        Top = 12
        Width = 42
        Height = 12
        Anchors = [akRight, akBottom]
        Caption = #37197#26041#21495':'
      end
      object edtNewRecipe: TEdit
        Left = 727
        Top = 9
        Width = 121
        Height = 20
        Anchors = [akRight, akBottom]
        CharCase = ecUpperCase
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edtDeleteNO: TEdit
        Left = 394
        Top = 9
        Width = 121
        Height = 20
        Anchors = [akRight, akBottom]
        CharCase = ecUpperCase
        TabOrder = 1
      end
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 169
    Top = 3
    Width = 8
    Height = 688
    HotZoneClassName = 'TcxXPTaskBarStyle'
    DragThreshold = 2
    Control = pn1
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
end
